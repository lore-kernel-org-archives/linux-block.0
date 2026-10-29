Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793238953;
	b=eJqx8CnmCK9OVasAkR+AQ6Bx5BTUyrjeEkrwwoHYhnOwG3t+P0GgRYA3EjvlMzKO4DlK
	 07qPRPT29IFZzigkj/z14a/ugt5ViWoj/iNZGCA/Xo5tyU+i/eXSUbRsxIfVaBVDfPoIO
	 xS3lsaw9SBanTOeo8K9akhSy/sp+PbaTMKaIt95tVV6ZZkY9oEDNRxTAW5aG3pzqBgAEd
	 Sxx9ra7DF1/iwAE7/Ljk77PjVsn1ZddzWOo/YCgJ9xAxrtLy5Y+41n1eVYDx4OONcAvh0
	 gVtgXM/WFZtK0b/RzQTzTZhnyzmKZGy+B4v4l9Vq/cjAUihnY7KMa7UPmdLgCkpFr4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793238953;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=mM9FIZHjvXLh6GKV1lHpR65tjCqOqOs259NYJp6APhE=;
	b=LQ6KLX8aSPIxV4ZS/484KitICjpeT7taPVnQHup2qtRnLyXtCbEEmzecEqkw/bQ30Hf3
	 SULaKZva6AkGd8bSbylO0ELR+LhZvR4g1x3pMWhNXC/7Pul2v+h4Rt51oqjKEiNHgYOEr
	 MUWClZixtPU7IX19YgW10BJ69vdG1tRhawVM9aX7gVYxMdSeYQkCx447e3vZdUmgpOtvi
	 bi9RxAsqoo1eHhvsew8fq/LIYpAvdKE9Ck3sT7keQ3FlKUVYX0DSm44cZBppuKQ03rVvT
	 mXM3TetiV/iEkPus/mF5/c4zKP+AXJNc4SpmqdRF0SPvgp7Rx8Tq0GnmHKahrxZHLeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=dagB4wZY;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBCE606A31A
	for <linux-block@vger.kernel.org>; Thu, 29 Oct 2026 01:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BBCE606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=dagB4wZY
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-369f33df08eso3027647eec.0
        for <linux-block@vger.kernel.org>; Wed, 28 Oct 2026 18:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793238952; x=1793843752; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mM9FIZHjvXLh6GKV1lHpR65tjCqOqOs259NYJp6APhE=;
        b=dagB4wZYDy/ARbl+WK01b3NRqScay6nDfrxfEUvSrr7fHfUCusfj+hWT7EX6ufHeZw
         KlAfd8k3gZmkoE8t82E22DviarUqoDoIqgmQ22RPBRTcoVI+vGD3MbraQmRbrmeS/5tS
         8wRoNMR48gC6TPaIGPPClQbD2FXArXQWC0kfQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793238952; x=1793843752;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mM9FIZHjvXLh6GKV1lHpR65tjCqOqOs259NYJp6APhE=;
        b=TkMFn3S2aVhW4I/aNGQSPFBe9SjFxhJUAzF23iPZkfZvmN4jadTR8SI+pX0OIZBX3s
         ThATIP1gDHiqlFS53XKJeyVcnQAfbuCf4cEAwmNFUhDNZiIT1wraaXtuwmsos3iUWx3a
         aPT0Ch3VEpjvPJY1oS+NBRYuW2atylxbDVWkodryslgsgXNjeAtxCd2AJqTDzaJTdcWI
         d6G4wh/tC0mEHbbYpmNu/GNvwajAWDP7iWnzptbWxgL4ELK3PLeP68MWT0RTQomp0sX9
         xKME+DAccXi0LIiCJSizQ1haJYjndvDkqaQgyYO1KTOFTycDgRjFc3UIe9PhrHSI6ovK
         ujGw==
X-Forwarded-Encrypted: i=1; AKwUvBwrUV4p6exDSlsTHJG+6ao28X4wdfhqXz5DyMrQReRxxkUjnpebJJUt0eMXOLR/mYNyXWeeNjxpCxYBAg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLRgspBzw/2qvNoMo7G5s+uB9WhL2m4b2QUQZOMgMXpQoaIA/rw
	ryxha6lGQpBPqMpdFZwcQQFLPT9X3DTBDtTOWOT0WGePcFn6yUUtv1m2S31AjMHNYQ==
X-Gm-Gg: AYBFou3Fh1zFiE6CnmDJ1jfPTIPq7OgeMC8fTEGb8DvRdkGWiFIEeuGv4Pp58cW0nT0
	dAVqCkMvMJ20cG8svsuUPHvXnCFf4TqB4HMvmon7XBQNgDd2CjULU7/yzoOS2t3XRoeKIFoI47m
	pdmHsdYFkWZoNykEiGLrEdQRarm+zAoR4XtlBAzWAFYk5v4PKfyl7icERubnt15Ie8TgFocDH8Q
	LPYQABXxAq7aMWmBDdfGM3wMlCLBTDIZKI491pyJoJCVQCC6Jg93BqcK7T5c/uxlWeeaDVjoYHb
	D32IVFPvs4umRqv3cccnflTcOBu+GT51bReUCsWjtzweDBFkducQKeP8iRZFZ5TljKxkJaFWhcr
	fWp4n73QiCRO5UW96eD8zIqm+t4hoZkPif57uZTepmyIebaTa5e17qwZYL7aXJ08mtbsqF0uabX
	ialVoAZ+dmrQp/2MxG2imoWsw9UaKRtgO4aEl+8C5vDVntyZo2GL0GC2P1ozaA6C2pv4/ieYt7N
	240kqfaagta2BD7PF++AZYo5mG0nn9qTv3EnuKLUxdYG+vVrJ0uLrm5hxG86sydQbK2MLzXEgBo
	rKWGrR28tBejGnOagS93JCIKMZXnjx+OqIL3c2OAmLR8/2tpG5SVP//E/3X74kU6yZ4A1xlK1hE
	4TIIKYpJvGovyYFA=
X-Received: by 2002:a05:701b:281b:b0:160:90a3:ca8c with SMTP id a92af1059eb24-1a6ced8fd89mr4981461c88.7.1793238952218;
        Wed, 28 Oct 2026 18:55:52 -0700 (PDT)
Received: from google.com ([2a00:79e0:2031:6:f72e:e03e:c64e:b5b3])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75fdc1031sm10259266c88.19.2026.10.28.18.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 18:55:51 -0700 (PDT)
Date: Thu, 29 Oct 2026 10:55:48 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, 
	linux-block@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
	Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH 24/98] zram: accept lz4 dictionaries of more than 64 KiB
Message-ID: <auKnXsfgwSfCrjPh@google.com>
References: <20261028164415.1262013-1-axboe@kernel.dk>
 <20261028164415.1262013-25-axboe@kernel.dk>
 <auKfEyDhNK0lf0c6@google.com>
 <beffc39a-9680-45c3-83d0-6251e28840fc@kernel.dk>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <beffc39a-9680-45c3-83d0-6251e28840fc@kernel.dk>

On (26/10/28 19:54), Jens Axboe wrote:
> On 10/28/26 7:20 PM, Sergey Senozhatsky wrote:
> > On (26/10/28 10:41), Jens Axboe wrote:
> > [..]
> >>  #include <linux/kernel.h>
> >>  #include <linux/lz4.h>
> >> +#include <linux/sizes.h>
> >>  #include <linux/slab.h>
> >>  #include <linux/vmalloc.h>
> >>  
> >> @@ -48,7 +49,8 @@ static int lz4_setup_params(struct zcomp_params *params)
> >>  
> >>  	ret = LZ4_loadDict(dict_stream,
> >>  			   params->dict, params->dict_sz);
> >> -	if (ret != params->dict_sz) {
> >> +	/* Only the last 64 KiB of a dictionary are of use */
> >> +	if (ret != min_t(size_t, params->dict_sz, SZ_64K)) {
> >>  		kfree(dict_stream);
> >>  		return -EINVAL;
> >>  	}
> >> diff --git a/drivers/block/zram/backend_lz4hc.c b/drivers/block/zram/backend_lz4hc.c
> >> index d8aa01bb258f..d163ff0ae8ae 100644
> >> --- a/drivers/block/zram/backend_lz4hc.c
> >> +++ b/drivers/block/zram/backend_lz4hc.c
> >> @@ -4,6 +4,7 @@
> >>  
> >>  #include <linux/kernel.h>
> >>  #include <linux/lz4.h>
> >> +#include <linux/sizes.h>
> >>  #include <linux/slab.h>
> >>  #include <linux/vmalloc.h>
> >>  
> >> @@ -96,7 +97,8 @@ static int lz4hc_compress(struct zcomp_params *params, struct zcomp_ctx *ctx,
> >>  		LZ4_resetStreamHC(zctx->cstrm, params->level);
> >>  		ret = LZ4_loadDictHC(zctx->cstrm, params->dict,
> >>  				     params->dict_sz);
> >> -		if (ret != params->dict_sz)
> >> +		/* Only the last 64 KiB of a dictionary are of use */
> >> +		if (ret != min_t(size_t, params->dict_sz, SZ_64K))
> >>  			return -EINVAL;
> > 
> > I think this should patch lz4hc_setup_params() instead.
> > Similarly to lz4 hunk.
> 
> You're the maintainer, so queue up a patch like that. Like I told
> Bart, I'm not sending this out to get review. Either ack it if it's
> good, and if not, as the maintainer of this driver, just fix it and
> I'll happily drop this one.

Works for me, I'll queue up a fix (will give you credit).
