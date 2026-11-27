Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795742361;
	b=lWb4ZSujzB1jxvxPe/nUF/R4Rvs//mg+c6gdZOggNQ/IjM1Uya7HGGXoiyUdGMxJi1mG
	 XoW96VI/41regZ5L+eqtKxEtnZEBrD+93d62tMabt8W3rjA0JtRPDxA7yC5fkkvf0dNz3
	 TdHJoCbvkirmWgz8ObW2clEy/zd1c3t8EqHA+nQ95ZsT0tHKd4bt9zeWRs/FPrSoNzYvu
	 oVNhWeydnuUcVmisVPgqUjl2pl87ZBoEXh35r4mq9w8stMynwFSjOkzkSwVGhpJ+Q4gUs
	 36Ik9xh0K03Dh6jfiOxQ5wKR33EiRqZBMbnSxc6+m6yIqXZzQRCw1aTlYG1uhsBlP7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795742361;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=9S2wD3u5c8Swjbtm9qjZJok1wpzb9JsdrrAA8lW58GI=;
	b=t9vHrjVZxatOeoDsV0Rpko+agd/G0UKbUnNp5FUJ5gvZQL7hfnoBSwd25G1s5CTQfj2S
	 4oyFA1yI2QsOafLEmWP2RYLAtttOEhfjvRea+kZ79A/mC/4lpYLAT/FW+vrMBzFKElxiI
	 7AqZ9vEIuFm7HQvaFWQx+3YHyRu85s2KYcFgROjD4bNN1a9LSdjM2JEGgyPXt09WcyDra
	 0guH43YJo/IIcxpGethiOg2119aihasUDHf7lVskMxmWDN+tqhx5Km5hheYRxU+73/vew
	 Qr0kj/q0GVzoYt8vFhAIjS2qlMKY+/FPIn5WnJPx4jN8RfLOzLBWHrRsaeYoEJ45oWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=gqesYc00;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC60606A32A
	for <linux-block@vger.kernel.org>; Fri, 27 Nov 2026 01:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0FC60606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=gqesYc00
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cde827b7b95so2419177a12.0
        for <linux-block@vger.kernel.org>; Thu, 26 Nov 2026 17:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795742360; x=1796347160; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9S2wD3u5c8Swjbtm9qjZJok1wpzb9JsdrrAA8lW58GI=;
        b=gqesYc0000eL7XF1wi7BtoTw2Ip7GPQcmU04rUbun+G8KmplMt+t9cAguF7JirI2RI
         ONKpvLSgAVZE/I6dak814vwqahXhxa/KEO1a+PWxcLPT717PCTdfIQ8w4TuWM/Es+zoi
         vs1Xvn9hM75mbx+7MkCTeuWnQH5nf1BYqH/yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795742360; x=1796347160;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9S2wD3u5c8Swjbtm9qjZJok1wpzb9JsdrrAA8lW58GI=;
        b=v06cTSsiK/6ou2/8XHxSwrZujOy3RlVTrYFzWwPpjRYGe50WbKHMhec7tjavSJXukY
         MPoSo7cinNHCz+H1+qOLv95MgRkTTbo95qSctdnaGiqn8kAableoQKdyH/aA0O6NlMXf
         z6g4uXivSdlo9iam/iZt2m9ERVMNHnMWJsLUNWcSNxbzxTpW3QN5zWZjJAlKXsx3Q0G0
         spQRCF0IJIaV/fZ/JXo2lz1N8XjRWp33voLVWTGNBGfSfwNWYktoekBzmKTeK2a+2n22
         QNEMDw53Ej3m97zagRFPu16cSocSt2QhckQ/hUfUwZs4JA0pOSwTb1xnmLunFTULP7uq
         7RXQ==
X-Forwarded-Encrypted: i=1; AL+hErGfJvDinR4JGtZxkBKMa75joFIl2vT0T6NQmUFeBbjCY8Uw/uLERHWMOnFbf9jRDee+E8Sx7MYxUDf5Ag==@vger.kernel.org
X-Gm-Message-State: APuU4Z9Domfvc3XSPmCMSQIEI5V9C7+2uUgC6tJOmViFDcbT/AOzJqqB
	9pz00agvIr27JijtQtG5sytaCbl+3mDwzQGMPFQjpNwy/SNlT3pyFrQR8IgP+vbVyQ==
X-Gm-Gg: AZFdTZf9NwifHAdzzmpCUCZBxDut52FqZjao2R3p+Rwbb0beBLGwMIbqGN7UK3MU2KM
	Bx78wjxUk6owaQgIzenld71LG4e3R/+a356f0OZFIGxHKqCmmGrSErxfpaqUDhrYejIMwjSkOlC
	IxQWEpVF0yCbKfPZF+u50ZivtNb+xGNz8jCJjCkiVZx4vWbnLWSvJbf1CaPGcgSoiGyIxMA3qkJ
	YuJlL7lwl5RMh4Qe6bjgG9EPIdk1U3G5UCVubJASkDUpMqn/WD6LH6yGR/rWQuPMy9LNxqnZbWB
	/qIDLY2tZs+E3QdXYil9DsIBZ/nrh+vCNOwIMiS2BKOT/iyEvR3EOoaLgo72WPBaztAJmcWbrlo
	VxOtlhFdOwDa0gdr3xuzIMdrmhuEQWjQ3qrOdaV/2Evuipb++vmVds58jRDoul6H4OsBDvDAERJ
	MCyIkwcoAqJSkc5QPJ5hjOGujCTxF/DopwWhkWc08C0OvCokL5qdmht/RQXb2zT6XUBgRXupHHK
	BQRRwc4DJcd5MVEVFX9wtl5T4n0UEEAzKIHuqjM6Q3BBn9jOach5wnJa3sYbF8i0iqut1KFcIXO
	oiOG5TLA9DhulDAkyPqcU7y1v13HHFCPwjxfc4dRnkYuQfEEXpkjjpu0qzdjjEdJ3FZY
X-Received: by 2002:a17:90b:3f0f:b0:3b4:393:452a with SMTP id 98e67ed59e1d1-3b41c9120c3mr23694154a91.23.1795742359875;
        Thu, 26 Nov 2026 17:19:19 -0800 (PST)
Received: from google.com ([2a00:79e0:2031:6:5bf8:984e:5bb:e51d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0a33fsm35954294a91.6.2026.11.26.17.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 17:19:19 -0800 (PST)
Date: Fri, 27 Nov 2026 10:19:14 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Artem Novak <artem122novak@gmail.com>
Cc: minchan@kernel.org, senozhatsky@chromium.org, axboe@kernel.dk, 
	linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: validate decompressed page size
Message-ID: <awjaHB2ugCG_F3Io@google.com>
References: <20261127004411.109585-1-artem122novak@gmail.com>
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
In-Reply-To: <20261127004411.109585-1-artem122novak@gmail.com>

On (26/11/26 18:44), Artem Novak wrote:
[..]
> @@ -185,6 +185,8 @@ int zcomp_decompress(struct zcomp *comp, struct zcomp_strm *zstrm,
>  	ret = comp->ops->decompress(comp->params, &zstrm->ctx, &req);
>  	if (src)
>  		kunmap_local(src);
> +	if (!ret && req.dst_len != PAGE_SIZE)
> +		ret = -EINVAL;
>  	return ret;
>  }

Yeah, I don't think we should do this.  We only ever compress PAGE_SIZE
buffers, if some backend decompresses it to a something that is not
PAGE_SIZE and doesn't signal an error via "ret" then it's a bug in the
backend and zram should not cover it up.
