Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE2FC6FD1C
	for <linux-block@archiver.kernel.org>; Mon, 20 Mar 2023 23:30:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjCTX3e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Mar 2023 19:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjCTX3Y (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Mar 2023 19:29:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C12818A91
        for <linux-block@vger.kernel.org>; Mon, 20 Mar 2023 16:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679354909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tYmTv+DTfCEebB+wfhQbSw/zGfKYOUHcx0zc9rP9F/o=;
        b=SVwSlriIwWtLg9/qZX4+raJ/WqVuQyuFTYz0tXaFp+zMk0oLSlw6GTet5liupwFTVU91+s
        WCHWMPZv0ucI6FoDN/48a+bXoB7uNs8eTQq0aVTDH/RfnX58GLR3w0qVYt5hb5d5iR8VZV
        FNvAzRfjdJP4pwZY0x/lD8aFciJ+K70=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-131-VmJINxkAM2iafqpkyv43dQ-1; Mon, 20 Mar 2023 19:28:26 -0400
X-MC-Unique: VmJINxkAM2iafqpkyv43dQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D749F1C05AF0;
        Mon, 20 Mar 2023 23:28:25 +0000 (UTC)
Received: from ovpn-8-29.pek2.redhat.com (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AFA8E492C13;
        Mon, 20 Mar 2023 23:28:20 +0000 (UTC)
Date:   Tue, 21 Mar 2023 07:28:15 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        ming.lei@redhat.com
Subject: Re: [PATCH 2/2] block: Split and submit bios in LBA order
Message-ID: <ZBjsDy2pfPk9t6qB@ovpn-8-29.pek2.redhat.com>
References: <20230317195938.1745318-1-bvanassche@acm.org>
 <20230317195938.1745318-3-bvanassche@acm.org>
 <ZBT6EmhEfJmgRXU1@ovpn-8-18.pek2.redhat.com>
 <580e712c-5e43-e1a5-277b-c4e8c50485f0@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <580e712c-5e43-e1a5-277b-c4e8c50485f0@acm.org>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 17, 2023 at 04:45:46PM -0700, Bart Van Assche wrote:
> On 3/17/23 16:38, Ming Lei wrote:
> > On Fri, Mar 17, 2023 at 12:59:38PM -0700, Bart Van Assche wrote:
> > > Instead of submitting the bio fragment with the highest LBA first,
> > > submit the bio fragment with the lowest LBA first. If plugging is
> > > active, append requests at the end of the list with plugged requests
> > > instead of at the start. This approach prevents write errors when
> > > submitting large bios to host-managed zoned block devices.
> > 
> > zoned pages are added via bio_add_zone_append_page(), which is supposed
> > to not call into split code path, do you have such error log?
> 
> Hi Ming,
> 
> Thanks for having taken a look. This patch series is intended for
> REQ_OP_WRITE requests and not for REQ_OP_ZONE_APPEND requests.

But you are talking about host-managed zoned device, and the write
should have to be zone append, right?

Thanks,
Ming

