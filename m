Return-Path: <SRS0=ppXp=VU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57290C7618B
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 15:48:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26542223BA
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 15:48:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="dY8VZJx9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="dY8VZJx9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731343AbfGWPs4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jul 2019 11:48:56 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:39716 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729331AbfGWPs4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jul 2019 11:48:56 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 84B1A8EE147;
        Tue, 23 Jul 2019 08:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1563896935;
        bh=iAQmggOmQmeD+24vcy0sUA4qWsBoS2Og2tw7Q926Yas=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dY8VZJx986lqDQpOhRlmE0N9Jagw6IpAstRQYeJL8irGcKcdj9JMBNe61LQ4lIYtg
         kcwec30RKlcK52aKjmLcOinluNFRdby7cs/zHjomHSrG/8lK+bW6sgkK+kB8ptmH6d
         /yV1/aO5hFXA/l4rDkocm/TtEYS66j8kOhEl7TqI=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VA1v1WntbSN2; Tue, 23 Jul 2019 08:48:55 -0700 (PDT)
Received: from jarvis.lan (unknown [50.35.68.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 0913D8EE0EF;
        Tue, 23 Jul 2019 08:48:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1563896935;
        bh=iAQmggOmQmeD+24vcy0sUA4qWsBoS2Og2tw7Q926Yas=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dY8VZJx986lqDQpOhRlmE0N9Jagw6IpAstRQYeJL8irGcKcdj9JMBNe61LQ4lIYtg
         kcwec30RKlcK52aKjmLcOinluNFRdby7cs/zHjomHSrG/8lK+bW6sgkK+kB8ptmH6d
         /yV1/aO5hFXA/l4rDkocm/TtEYS66j8kOhEl7TqI=
Message-ID: <1563896932.3609.15.camel@HansenPartnership.com>
Subject: Re: [PATCH 2/4] block: force an unlimited segment size on queues
 with a virt boundary
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Christoph Hellwig <hch@lst.de>, axboe@fb.com
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        Hannes Reinecke <hare@suse.com>
Date:   Tue, 23 Jul 2019 08:48:52 -0700
In-Reply-To: <20190521070143.22631-3-hch@lst.de>
References: <20190521070143.22631-1-hch@lst.de>
         <20190521070143.22631-3-hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 2019-05-21 at 09:01 +0200, Christoph Hellwig wrote:
> We currently fail to update the front/back segment size in the bio
> when
> deciding to allow an otherwise gappy segement to a device with a
> virt boundary.  The reason why this did not cause problems is that
> devices with a virt boundary fundamentally don't use segments as we
> know it and thus don't care.  Make that assumption formal by forcing
> an unlimited segement size in this case.
> 
> Fixes: f6970f83ef79 ("block: don't check if adjacent bvecs in one bio
> can be mergeable")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> ---
>  block/blk-settings.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/block/blk-settings.c b/block/blk-settings.c
> index 3facc41476be..2ae348c101a0 100644
> --- a/block/blk-settings.c
> +++ b/block/blk-settings.c
> @@ -310,6 +310,9 @@ void blk_queue_max_segment_size(struct
> request_queue *q, unsigned int max_size)
>  		       __func__, max_size);
>  	}
>  
> +	/* see blk_queue_virt_boundary() for the explanation */
> +	WARN_ON_ONCE(q->limits.virt_boundary_mask);
> +
>  	q->limits.max_segment_size = max_size;
>  }
>  EXPORT_SYMBOL(blk_queue_max_segment_size);
> @@ -742,6 +745,14 @@ EXPORT_SYMBOL(blk_queue_segment_boundary);
>  void blk_queue_virt_boundary(struct request_queue *q, unsigned long
> mask)
>  {
>  	q->limits.virt_boundary_mask = mask;
> +
> +	/*
> +	 * Devices that require a virtual boundary do not support
> scatter/gather
> +	 * I/O natively, but instead require a descriptor list entry
> for each
> +	 * page (which might not be idential to the Linux
> PAGE_SIZE).  Because
> +	 * of that they are not limited by our notion of "segment
> size".
> +	 */
> +	q->limits.max_segment_size = UINT_MAX;

This needs to be conditional.  If you did set the max segment size, the
block layer should still respect it and not do an override here.  This
seems to be what's causing a regression in SCSI because we set the
max_segment_size first then call the blk_queue_virt_boundary. 
Additionally, if you're not setting the virt boundary (mask == 0) this
should not be set.  I suggest the below.

James

---
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 2ae348c101a0..46a95536f3bd 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -752,7 +752,8 @@ void blk_queue_virt_boundary(struct request_queue *q, unsigned long mask)
 	 * page (which might not be idential to the Linux PAGE_SIZE).  Because
 	 * of that they are not limited by our notion of "segment size".
 	 */
-	q->limits.max_segment_size = UINT_MAX;
+	if (mask != 0 && q->limits.max_segment_size == BLK_MAX_SEGMENT_SIZE)
+		q->limits.max_segment_size = UINT_MAX;
 }
 EXPORT_SYMBOL(blk_queue_virt_boundary);
 

