Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236E5C43334
	for <linux-block@archiver.kernel.org>; Mon, 18 Jul 2022 15:16:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbiGRPQT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jul 2022 11:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbiGRPQT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jul 2022 11:16:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4E1A52528A
        for <linux-block@vger.kernel.org>; Mon, 18 Jul 2022 08:16:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658157377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4w2YzXwIcNhtVOHvuOnlSaUKnkJgVptl3/QWhOtpS6c=;
        b=SHBnbr6XefITyLYtc5Y/z3hnce804jndIh8KuOhdVm8QkG5ZQ2QAtLXDtlFQNh15yHWfkQ
        yNnS71FioHpDFCBLnTLZb5VAF12mywPmr7bSMIhNSwN/5v8z7EaaQLnreYMK5z/pkuOudR
        zcMTZYBWff6tDWOoMJLImLCfsGSvX1Y=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-307-GFD1dWvaMliiWCjkhxY0aQ-1; Mon, 18 Jul 2022 11:16:16 -0400
X-MC-Unique: GFD1dWvaMliiWCjkhxY0aQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 618FE1C06ECC;
        Mon, 18 Jul 2022 15:16:15 +0000 (UTC)
Received: from T590 (ovpn-8-29.pek2.redhat.com [10.72.8.29])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8B85340C1288;
        Mon, 18 Jul 2022 15:16:12 +0000 (UTC)
Date:   Mon, 18 Jul 2022 23:16:07 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org, ming.lei@redhat.com
Subject: Re: [PATCH 1/2] block: call blk_mq_exit_queue from disk_release for
 never added disks
Message-ID: <YtV5N2ATLgy+d/q+@T590>
References: <20220718062928.335399-1-hch@lst.de>
 <YtUJXGhFBw5yrf7N@T590>
 <20220718130725.GA19204@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718130725.GA19204@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Jul 18, 2022 at 03:07:25PM +0200, Christoph Hellwig wrote:
> On Mon, Jul 18, 2022 at 03:18:52PM +0800, Ming Lei wrote:
> > Request queue is allocated successfully, but disk allocation may fail,
> > so blk_mq_exit_queue still may be missed in this case.
> 
> Yes.  That's a separate issue, though and solved by this one liner:
> 
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index d716b7f3763f3..70177ee74295b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -3960,7 +3960,7 @@ struct gendisk *__blk_mq_alloc_disk(struct blk_mq_tag_set *set, void *queuedata,
>  
>  	disk = __alloc_disk_node(q, set->numa_node, lkclass);
>  	if (!disk) {
> -		blk_put_queue(q);
> +		blk_mq_destroy_queue(q);
>  		return ERR_PTR(-ENOMEM);

OK, but it is still tricky, since there isn't the required order between
calling blk_mq_free_tag_set and put_disk, but now put_disk has to be called
before calling blk_mq_free_tag_set, so you may have to audit drivers
first, and make sure that all put_disk is called before blk_mq_free_tag_set()
in driver's error handling code path.



Thanks,
Ming

