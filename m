Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EF7126C03
	for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 23:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776815497; cv=none; b=oYNkzztXfAK/xLWYioso3o3MCawpoQoMt5DwaPdbnuxkacnTLiL30itukBnpoWOLUDoyfGe8bvKcd325d1EmVlemzSznsh4+8KtnRHs7kYAb6kJe+C96/MwwIYY354FH/OAme3Hu30ODL9a/UDCLaVE+wenwRkEVHLNq5Ges5rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776815497; c=relaxed/simple;
	bh=2AzrYkkgpTx3fjRxudg30kIroDX8P20+i+BvUvZC36s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLdouRsXlfze1yDEhIW6GUu95wmqCOnlF5n8ciTajzuS9NRpvjdW7kEuMmItWoVy2RxdUWO2CkrPpFMXoOhMOgoMPqggEbj7BVrG8NyeQfVu2TgbeaRVkbWaS5J2qLrxPOMtfiQ2+IMuzcQfpKf3AtBzVK1WQgkh6RMWDe6caNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fyK7cMjp; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fyK7cMjp"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so4439163f8f.2
        for <linux-block@vger.kernel.org>; Tue, 21 Apr 2026 16:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776815495; x=1777420295; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E7KtRjUQ6sLg+MZ5FkEZdS8HGZukGSYFwBFKnRZPFYg=;
        b=fyK7cMjp2CMGPz2FdRfRpzvDF1ODnzXxOeGgLbsoyMuJs8CtmnVoMuEGKR/DiQwvVd
         om2H2D8vJ66wmPSxXLdGRVEfa08nqNR1m0TG6U71NgNi8bqjnZRaUjftd7a6DVByQu+b
         RvnuisU94v0RHBD7dPGzjtc5xPl1L6TB/RAT1rQaZLo/nMCR1leYulMNHWr159h/NSHT
         Ac5Zkm+x6KJs6SUjOmIG04nmqBbWNSMNjRzCB2y9ltcjEAsSwST7gHixqoJhz1c2+Cer
         8uZJMHjoSY7zpUA/UKDSSSZ1LSAlJbVClGD/2ksgmp4LWD83I5ObRtShYIZk7yjrnbMi
         s15g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776815495; x=1777420295;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7KtRjUQ6sLg+MZ5FkEZdS8HGZukGSYFwBFKnRZPFYg=;
        b=lilRmXg/kdrBWT1t5DwI4dslZFbYYTd9bPVDMvcgwbRxacf7rwqqp+d8mF/X1mcKwQ
         QWi/zHCLxR2bT7fsfD1ygCYw0HK8Xx1tE33RWreNgbG8l5yY9cyaKipDBb7xYrisu5ZS
         v5dfg36pv/idjW0VVHKihTo3wp9QVI3LXlot9SlcyaiijnKIaASHPPcqYlvsfLXZEANM
         Ol+IBiYcR4Pz1FZE6zjWS3uULbU4veo0HvwcKRce8biHw+sip8dO5/DvNy+5KI/rIYn6
         jpDrDgiEWV3BOkWvPnyqC2+JcSlSzM4eUGaRcC7uAoS51e1BIUFn58dmQWK6bRZc1PXd
         s38w==
X-Forwarded-Encrypted: i=1; AFNElJ9+jGUAd2DJP9yqeqVZKDwlDxD8N3AageGA4gmmjEyi0D3fDlGNHgNNTNHoNf2ZXEykscU9GK3Xdpq4Aw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtlkGWrtYpvvz0A3xUxAjPSWl2C2aHDI8yGzxTcsaBK8XGdqfh
	cdIxJnwBDMn0qbk4OKqHau8pWTw6+/qpSiOZnkLqxRoVsuLIaqKlqquT
X-Gm-Gg: AeBDieu9S46vSbkE+cA1e1zwF4k3tqAK9AAsyjdJMcNi0tJ9r5bKaWWPtE3VlQ5XPcy
	k5vf9a1i3hIMUfDuvN28ht+WI400e7Wv4PFXkrJcQ4EVHe10jeifM7RU2I779IKItSEk4eaiL1F
	7BvPgmjp4xH6Uq64YjEdEsC8ESRFLmTZKPKMw8wo11Nvi/suLsMPv+RJ8IoW3o25EK8pOztIJwr
	5xLxv4vP55WhSMSIj9Cf2pVr7e8ufKKlhzlKlI8z4jQptz6aDHetOqZkYZpsBgZ+WVJkDuD+EkC
	rB+DhkXtmPezubRx1f9wmQYJ9ByjYQ9ApY+NZNrbn1HkHQCbwL7SNsLmq3vdQEam8mTr9OWterQ
	Ll1N7GNXe8crM3d3m+Vb3H+9vTylXVOZ0zfO4yjFuPTJMoQsO4ko7w9iJF2BK/sw6/w7hdWIk1/
	sHHzslXWjNb2uQjJrI8PJ560UFW7HCZZlaFuZ1AUSTfZ4VJl1NlRmE/KRVHIOV3xpvfal8CkLW9
	wlHdVXbiUC850SfLVw=
X-Received: by 2002:a05:6000:1a8d:b0:43c:f28b:8863 with SMTP id ffacd0b85a97d-43fe3dc7998mr31534684f8f.13.1776815494812;
        Tue, 21 Apr 2026 16:51:34 -0700 (PDT)
Received: from fedora (185-147-214-8.mad.as62651.net. [185.147.214.8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e4d525sm39222137f8f.31.2026.04.21.16.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 16:51:34 -0700 (PDT)
Date: Wed, 22 Apr 2026 07:51:27 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: optimize ublk_rq_has_data()
Message-ID: <aegNf5C5-0ccxBPp@fedora>
References: <20260421194744.1524637-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421194744.1524637-1-csander@purestorage.com>

On Tue, Apr 21, 2026 at 01:47:42PM -0600, Caleb Sander Mateos wrote:
> ublk_rq_has_data() currently uses bio_has_data(), which involves 2
> indirections and several branches. Use blk_rq_bytes() instead, which
> performs a single indirection with no branches.
> 
> Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> ---
>  drivers/block/ublk_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index ef8a0705e68b..5f9b3c3876f4 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -1172,11 +1172,11 @@ static inline struct ublk_queue *ublk_get_queue(struct ublk_device *dev,
>  	return dev->queues[qid];
>  }
>  
>  static inline bool ublk_rq_has_data(const struct request *rq)
>  {
> -	return bio_has_data(rq->bio);
> +	return blk_rq_bytes(rq);
>  }

blk_rq_bytes() doesn't return the actual payload data bytes, such as,
discard command, but bio_has_data() does.


thanks,
Ming
