Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A49C433E0
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 06:36:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FBE665216
	for <linux-block@archiver.kernel.org>; Tue, 16 Mar 2021 06:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232455AbhCPGfx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 Mar 2021 02:35:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59574 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232424AbhCPGfw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 Mar 2021 02:35:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615876547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lsPFOVL+yZL6SDoC0u3JNeLMJYDLF1Gvsvy8jWGw3r0=;
        b=IFAOTTaYgK7rCUzulLKctnFeH8Yj34yUNNpD8LDcSrJ2b8KoWueKJVoZ4qCuaEm/CUfRzl
        Jh4d0dkp2DAV+BLHtYd9V+zXswlVxbXRS8i5MhlVDOcLqyJp/NGoNgsaT9x07TV57XwNN4
        wrVF0EQnrHoi8o+aCLh7/cAwzV8zdB8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-bWCtXJbqPnmsuAFG5YJwDw-1; Tue, 16 Mar 2021 02:35:43 -0400
X-MC-Unique: bWCtXJbqPnmsuAFG5YJwDw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 614A08189C6;
        Tue, 16 Mar 2021 06:35:42 +0000 (UTC)
Received: from T590 (ovpn-13-0.pek2.redhat.com [10.72.13.0])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 279EF60C0F;
        Tue, 16 Mar 2021 06:35:34 +0000 (UTC)
Date:   Tue, 16 Mar 2021 14:35:30 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Omar Sandoval <osandov@fb.com>
Subject: Re: [PATCH] sbitmap: Fix sbitmap_put()
Message-ID: <YFBRsozJDW3kjxhv@T590>
References: <20210316035420.2584-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210316035420.2584-1-bvanassche@acm.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Mar 15, 2021 at 08:54:20PM -0700, Bart Van Assche wrote:
> This patch fixes the following kernel warning:
> 
> BUG: using smp_processor_id() in preemptible [00000000] code: scsi_eh_0/152
> caller is debug_smp_processor_id+0x17/0x20
> CPU: 1 PID: 152 Comm: scsi_eh_0 Tainted: G        W         5.12.0-rc1-dbg+ #6
> Call Trace:
>  show_stack+0x52/0x58
>  dump_stack+0xaf/0xf3
>  check_preemption_disabled+0xce/0xd0
>  debug_smp_processor_id+0x17/0x20
>  scsi_device_unbusy+0x13a/0x1c0 [scsi_mod]
>  scsi_finish_command+0x4d/0x290 [scsi_mod]
>  scsi_eh_flush_done_q+0x1e7/0x280 [scsi_mod]
>  ata_scsi_port_error_handler+0x592/0x750 [libata]
>  ata_scsi_error+0x1a0/0x1f0 [libata]
>  scsi_error_handler+0x19e/0x330 [scsi_mod]
>  kthread+0x222/0x250
>  ret_from_fork+0x1f/0x30
> 
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Cc: Omar Sandoval <osandov@fb.com>
> Fixes: c548e62bcf6a ("scsi: sbitmap: Move allocation hint into sbitmap")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  include/linux/sbitmap.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/sbitmap.h b/include/linux/sbitmap.h
> index 3087e1f15fdd..2713e689ad66 100644
> --- a/include/linux/sbitmap.h
> +++ b/include/linux/sbitmap.h
> @@ -324,7 +324,7 @@ static inline void sbitmap_put(struct sbitmap *sb, unsigned int bitnr)
>  	sbitmap_deferred_clear_bit(sb, bitnr);
>  
>  	if (likely(sb->alloc_hint && !sb->round_robin && bitnr < sb->depth))
> -		*this_cpu_ptr(sb->alloc_hint) = bitnr;
> +		*raw_cpu_ptr(sb->alloc_hint) = bitnr;
>  }
>  
>  static inline int sbitmap_test_bit(struct sbitmap *sb, unsigned int bitnr)
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

