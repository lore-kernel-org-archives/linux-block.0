Return-Path: <SRS0=NecV=22=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09417C32767
	for <linux-block@archiver.kernel.org>; Sun,  5 Jan 2020 00:49:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C916C215A4
	for <linux-block@archiver.kernel.org>; Sun,  5 Jan 2020 00:49:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NWyAKwNR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgAEAtS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 Jan 2020 19:49:18 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54590 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726205AbgAEAtS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 4 Jan 2020 19:49:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578185356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F7kx1fYZnl08Zrl5qbG/2Z5BQvBXmJ+dX7kdzKz8TW4=;
        b=NWyAKwNR/HloZmWWxoH3AQHVbp4ljzBvPcMau1fTEMof3K34KBOR5OA7zm/FCG0etY+OLk
        4i7s+idDcid3DtVPhj2OvVbLGa51gPM/puJrWn6Pl1S0Gs/tKKChoHXp1AEF8QnO5chh85
        uTvIEbYkhXezT0u9JH80gdw9UTsAvCE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-IoFbELNWOA2IfiBBBiEjoA-1; Sat, 04 Jan 2020 19:49:13 -0500
X-MC-Unique: IoFbELNWOA2IfiBBBiEjoA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E23CC182B791;
        Sun,  5 Jan 2020 00:49:11 +0000 (UTC)
Received: from ming.t460p (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9848860C81;
        Sun,  5 Jan 2020 00:49:07 +0000 (UTC)
Date:   Sun, 5 Jan 2020 08:49:02 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: remove unused mp_bvec_last_segment
Message-ID: <20200105004902.GA1812@ming.t460p>
References: <d8642060-8984-f584-6d93-6fcf032d6b6e@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8642060-8984-f584-6d93-6fcf032d6b6e@kernel.dk>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Jan 04, 2020 at 10:43:09AM -0700, Jens Axboe wrote:
> After commit 85a8ce62c2ea ("block: add bio_truncate to fix guard_bio_eod")
> this function is unused, remove it.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> 
> ---
> 
> diff --git a/include/linux/bvec.h b/include/linux/bvec.h
> index 679a42253170..a81c13ac1972 100644
> --- a/include/linux/bvec.h
> +++ b/include/linux/bvec.h
> @@ -153,26 +153,4 @@ static inline void bvec_advance(const struct bio_vec *bvec,
>  	}
>  }
>  
> -/*
> - * Get the last single-page segment from the multi-page bvec and store it
> - * in @seg
> - */
> -static inline void mp_bvec_last_segment(const struct bio_vec *bvec,
> -					struct bio_vec *seg)
> -{
> -	unsigned total = bvec->bv_offset + bvec->bv_len;
> -	unsigned last_page = (total - 1) / PAGE_SIZE;
> -
> -	seg->bv_page = bvec->bv_page + last_page;
> -
> -	/* the whole segment is inside the last page */
> -	if (bvec->bv_offset >= last_page * PAGE_SIZE) {
> -		seg->bv_offset = bvec->bv_offset % PAGE_SIZE;
> -		seg->bv_len = bvec->bv_len;
> -	} else {
> -		seg->bv_offset = 0;
> -		seg->bv_len = total - last_page * PAGE_SIZE;
> -	}
> -}
> -
>  #endif /* __LINUX_BVEC_ITER_H */
> 
> -- 
> Jens Axboe
> 

Reviewed-by: Ming Lei <ming.lei@redhat.com>

-- 
Ming

