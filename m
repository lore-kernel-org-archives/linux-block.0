Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27960C433F5
	for <linux-block@archiver.kernel.org>; Fri,  7 Jan 2022 03:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiAGDxM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Jan 2022 22:53:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30946 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233174AbiAGDxI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Jan 2022 22:53:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641527586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=J6JuYGp/HJsnQ5Gk+KhRijunPmVW7QFt32ERdmW7Eas=;
        b=J5hnDBehgbb9ln3P58FzwNkcp0uPnWg3eMytlXCXOX687KeMi2YCj/IrBiy5PiDxjYsg2U
        GEewyGV3873S2szCAbcECQzoLJ47shyYHt3Kj1QEWl6wV4MPdfC/vHPht1NA2Y/5DB3qcF
        Si4L0o45Zq+c95DOX+6OXeIYIiAVHBA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-457-ixmY_SbmPgugUdKupa-t0w-1; Thu, 06 Jan 2022 22:53:03 -0500
X-MC-Unique: ixmY_SbmPgugUdKupa-t0w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 73016189DF41;
        Fri,  7 Jan 2022 03:53:01 +0000 (UTC)
Received: from T590 (ovpn-8-26.pek2.redhat.com [10.72.8.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 74C7456F84;
        Fri,  7 Jan 2022 03:52:52 +0000 (UTC)
Date:   Fri, 7 Jan 2022 11:52:48 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     brookxu <brookxu.cn@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        lining2020x@163.com, Tejun Heo <tj@kernel.org>,
        Chunguang Xu <brookxu@tencent.com>
Subject: Re: [PATCH] block: throttle: charge io re-submission for iops limit
Message-ID: <Yde5EK12LoBq1wHw@T590>
References: <20211230034513.131619-1-ming.lei@redhat.com>
 <6eac325f-3d37-92b9-ca4a-f419a17345a1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6eac325f-3d37-92b9-ca4a-f419a17345a1@gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 06, 2022 at 03:46:54PM +0800, brookxu wrote:
> Hi Ming:
> 
> I think it may be due to other reasons, I test this patch seems work fine,
> Can you verify it in your environment?

Your patch can't cover the issue Ning Li reported.

> 
> 
> From 2c7305042e71d0f53ca50a8a3f2eebe6a2dcdb86 Mon Sep 17 00:00:00 2001
> From: Chunguang Xu <brookxu@tencent.com>
> Date: Thu, 6 Jan 2022 15:18:50 +0800
> Subject: [PATCH] blk-throtl: avoid double charge of bio IOPS due to split
> 
> After commit 900e08075202("block: move queue enter logic into
> blk_mq_submit_bio()"), submit_bio_checks() is moved from the
> entrance of the IO stack to the specific submit_bio() entrance.
> Therefore, the IO may be splited before entering blk-throtl, so
> we need to check whether the BIO is throttled, and only need
> to update the io_split_cnt for the throttled bio to avoid
> double charge.

Actually since commit 900e08075202, your commit 4f1e9630afe6
("blk-throtl: optimize IOPS throttle for large IO scenarios") doesn't
need any more, because split bio is always sent to submit_bio_checks().

But I don't think that way is reasonable, especially precise driver tag
and request is consumed by each throttling, so the following patch is posted:

https://lore.kernel.org/linux-block/20220104134223.590803-1-ming.lei@redhat.com/T/#u


Thanks,
Ming

