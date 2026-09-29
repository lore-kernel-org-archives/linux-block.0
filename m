Received: from mail-qk2-f39.google.com (mail-qk2-f39.google.com [74.125.230.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D1394EBAFF
	for <linux-block@vger.kernel.org>; Tue, 29 Sep 2026 09:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790673372; cv=none; b=BkOS2lQRLdXHkvL2v1S//9ibBxQ7G6/KLJ3ZMFeniSOV0ry16UddtU4SFVP9kGVkKqKTApQwEzK41+s/SSCKXFsZ+YSuDu2jvzVhozlot6yjso5+f/lfEVxSkV8yFotUyupcyl1AWQjQMcarBSudJZ0trs911apsJ6Vr6SGCjyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790673372; c=relaxed/simple;
	bh=54EiX3+UdtxYRud7qzJ9Xdl7ocd3pBdmAA4FFSUhnKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a5DgdEsdcdjDhdIE404uRQ+3DS52maBZw4EOu0cghgXFKQNBNUtPGnfRTDV0f2c+/wZj0R3ucrSFCgzd/3CBbmjGv9dsvXfp5HvIk+EyvtDR7fBE/5gPy0ETSNoM6HWdIzn2uM4jUnSAw+8eihtescV7CtJDsqBhNRekyE58vaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bPOrXwuL; arc=none smtp.client-ip=74.125.230.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bPOrXwuL"
Received: by mail-qk2-f39.google.com with SMTP id d75a77b69052e-53336049862so21002861cf.3
        for <linux-block@vger.kernel.org>; Tue, 29 Sep 2026 02:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790673363; x=1791278163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qauo8Xd0HQhFlQMJlGhHF2NW2UaNdyZCQsI5gccJOpE=;
        b=bPOrXwuLGnV1AP6FxwXwSIjgpFx7PhRAuFJTwjndEc7oDg1H8mpx/u30oYzYNOuVTC
         iFDPe4rEaAZTW9vBmSy1SJBAsv+4d2GFIm4wINvu3kxCUcv1Vzh92qYBWAeii0HjBUB+
         O262xS0UlAGnf1d4W6C6xGVyPbRDKOvBZRHLqwNarf/q2yHpSrQPuPPTTWjRYBqFhfXR
         uCLAlTOSgmurSeK00/Qr5Q/rou2MkjbJWtQ0F/3kjd3nNfdiarKfPyQXS3qGmsR2Xbvd
         d2JwjE1AtoFfHidXc5mO9bS3n3cQEOu+czwwzsQRg9+MwfaQduKlET9PwKMoG9f2TPS2
         ec0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790673363; x=1791278163;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qauo8Xd0HQhFlQMJlGhHF2NW2UaNdyZCQsI5gccJOpE=;
        b=eZEEtUZs43AcCsa8RIRSmJurdCJmIcIpwr7jjbFjf6towX6y4NPKoDKvVTeFarzfMH
         ob1ytQbh4a/4jzdVouVN0WhTJ3DQBF4mcOeIAAiahbiCNGh+KCb0MoLvQKVDYM8pjQ2j
         CYHXJCSOWr0vQcWXKeHBlzxl/dVgsZp8ByQFMCT5tkySChlAmGufWti/fwuXwsxCiqYT
         G883j39QVfVB354Qw/V2q2whox1uYNxjLuE2ZvSn70QGBXhUxk5s8Ku5pIi5i5jdg/OY
         RfQgwleaybmfg3wsN+aj25qivA9f0EwX3t1h9QeUb8E4dOuFLptlEKqSRfFamFGePQUL
         4NvA==
X-Forwarded-Encrypted: i=1; AKwUvBwzpdYBW+4lPpWa298Ikr3RRTWg2a3oxPw4txMquBM5CU6pIGPnlP+EIyWk/LHdSKm6uwIlHt+nJSChaA==@vger.kernel.org
X-Gm-Message-State: AFuF++mk+tEp62PJy1SQurHvNzQqMrzCpM5hapYrMXuA/FV1zPvHuT2c
	AynQPgPYAHmnTozgyWdKvGWiQHBqfHT8EvUWPG9M9I1lNatTnn2WEsPLUnPVTg==
X-Gm-Gg: AYBFou0CkeW8tg2TK9L/t+4sazAbJJ+irjgo/b4zuwtOtar3QnET/27y7pYcY8rm0rN
	yU05ToMeHpe8ikLZdWljZ63ZVNVwKPNLBHnFhnUd5b27OrLprcP1c4Cgy/vQly8HTWPNAz4CDBS
	oSMPLhozYVoV2MGIkReDaYhOkd3Pdtqb1EbboGKkUPVvPpX3vIw1eQmjVQF3fMQU4n2BfkjuhVg
	fKfEqkEAOX54R9b7jkxggzOo0K6QLPEqsjyMwFdZx2lIYKazhy2xCec3eTDnkGKEM1lpfh88sXy
	ajJC02taH1oeRZuFEUndU9p01r0Fel9KD9o3dW3zpnbwLBlFqdEdEwCKat/WO0YcZy2WtN5kDBQ
	jPIvdKRCN/UWRFCNQbe8fejpMlJhPR57v+peooA7p6/JNzxLUvIThUb7EGkqBczY7ZTc3ZKgf7V
	GNqMlioLJTxdFW+8XJJetaGe/PIuFL1dOEmC27fyH3x8cLssrW1kps0gt5G7Fl/9BWUiKFKVnnF
	zmER2No74NdXxQ87CJj/r+XAaZHesoFmpbMPh1NKUQWab7dEFZyzH06JcvFCRfC9s2to5s4XODz
	e3g=
X-Received: by 2002:ac8:5945:0:b0:530:cc3c:c62d with SMTP id d75a77b69052e-5330b6cab33mr273215601cf.44.1790673363100;
        Tue, 29 Sep 2026 02:16:03 -0700 (PDT)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5332238c585sm83979351cf.20.2026.09.29.02.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 02:16:02 -0700 (PDT)
Date: Tue, 29 Sep 2026 04:15:56 -0500
From: Ming Lei <tom.leiming@gmail.com>
To: lirongqing <lirongqing@baidu.com>
Cc: Jens Axboe <axboe@kernel.dk>, Andreas Hindborg <a.hindborg@kernel.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: use global index for reported zones
Message-ID: <aruBzOsvpYoWAO51@fedora-laptop>
References: <20260929070012.2325-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929070012.2325-1-lirongqing@baidu.com>

On Tue, Sep 29, 2026 at 03:00:12PM +0800, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> ublk_report_zones() may split a zone report into multiple requests when
> the number of zones exceeds the temporary buffer capacity. The index
> passed to disk_report_zone() must refer to the zone position in the
> whole report, rather than the position within the current request.
> 
> Currently, the per-request loop index is used as the callback index,
> causing each chunk after the first one to restart from zero. This can
> make userspace callbacks receive duplicate zone indices and may result
> in blk_revalidate_disk_zones() updating incorrect entries in its zone
> state array.
> 
> Use the number of zones already reported as the base index for each
> request so that zone indices remain continuous across all chunks.
> 
> Fixes: 29802d7ca33b ("ublk: enable zoned storage support")
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/block/ublk_drv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 66eb55e..007e703 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -649,6 +649,7 @@ static int ublk_report_zones(struct gendisk *disk, sector_t sector,
>  		unsigned int remaining_zones = nr_zones - done_zones;
>  		unsigned int zones_in_request =
>  			min_t(unsigned int, remaining_zones, max_zones_per_request);
> +		unsigned int batch_start = done_zones;
>  		struct request *req;
>  		struct ublk_zoned_report_desc desc;
>  		blk_status_t status;
> @@ -687,7 +688,7 @@ static int ublk_report_zones(struct gendisk *disk, sector_t sector,
>  			if (!zone->len)
>  				break;
>  
> -			ret = disk_report_zone(disk, zone, i, args);
> +			ret = disk_report_zone(disk, zone, batch_start + i, args);

`done_zones` can be passed directly, then we can save one local variable,
otherwise, this patch looks fine:

Reviewed-by: Ming Lei <tom.leiming@gmail.com>


Thanks,
Ming
