Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367C4C433EF
	for <linux-block@archiver.kernel.org>; Tue, 11 Jan 2022 01:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346475AbiAKB5Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Jan 2022 20:57:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26387 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346473AbiAKB5Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Jan 2022 20:57:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641866213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/z1beFA1SPtM3/rm6eOKu/aJAS4VlrouRNzoYqVL3JI=;
        b=eJtEJKq8fowGHtx3R0s4jaDbVEuRLC9asGZkpsO+ctg5G4QcM1GPLIUaLa9ppQjmwUFAuQ
        qe2QhxLvCLXGwumnGQMRiTtqDqeizQl/JWuZlaDWy9Mn0M5ow6gMqMjXC913iiXMZBgjRo
        bSvskQijOHA7+eMgQSmJpWPgBShPzF0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520-S3-BWQkGPJ6j09ZF7crcgg-1; Mon, 10 Jan 2022 20:56:48 -0500
X-MC-Unique: S3-BWQkGPJ6j09ZF7crcgg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0575D8189DD;
        Tue, 11 Jan 2022 01:56:47 +0000 (UTC)
Received: from T590 (ovpn-8-21.pek2.redhat.com [10.72.8.21])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 927A74EDC1;
        Tue, 11 Jan 2022 01:56:41 +0000 (UTC)
Date:   Tue, 11 Jan 2022 09:56:36 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        lining <lining2020x@163.com>, Tejun Heo <tj@kernel.org>,
        Chunguang Xu <brookxu@tencent.com>
Subject: Re: [PATCH 1/2] block: add resubmit_bio_noacct()
Message-ID: <Ydzj1JSoRGz+9g8B@T590>
References: <20220110075141.389532-1-ming.lei@redhat.com>
 <20220110075141.389532-2-ming.lei@redhat.com>
 <YdxuWlZAPJkPyr3h@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdxuWlZAPJkPyr3h@infradead.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jan 10, 2022 at 09:35:22AM -0800, Christoph Hellwig wrote:
> On Mon, Jan 10, 2022 at 03:51:40PM +0800, Ming Lei wrote:
> > Add block layer API of resubmit_bio_noacct() for handling blk-throttle
> > iops limit correctly. Typical use case is that bio split, and it isn't
> > good to export blk_throtl_charge_bio_split() for drivers, so add new API
> > for serving such purpose.
> 
> Umm, submit_bio_noacct is meant exactly for this case of resubmitting
> a bio.  We should not need another API for that.

Follows the background of the issue first:

1) IOPS limit throttle needs to cover split bio since iostat accounts
split bio actually, and user space setup iops limit throttle by the
feedback from iostat/diskstat;

2) block throttle is block layer internal stuff, and we shouldn't expose
blk_throtl_charge_bio_split() to driver.

Maybe rename the new API as submit_split_bio_noacct(), but we can't
reuse submit_bio_noacct() simply, otherwise blk_throtl_charge_bio_split()
needs to be exported.

Another ides is to clearing BIO_THROTTLED before calling submit_bio_noacct(),
meantime blk-throttle code needs to change to avoid double accounting of bio
bytes, so the caller of submit_bio_noacct() still needs some change.
This way can get smooth IOPS throttle, but needs to call __blk_throtl_bio
for split bio one more time.

Or other idea for this bio split vs. iops limit issue?


Thanks,
Ming

