Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274080;
	b=Yi6HjiWfePm5UezgVmwbE73g0cyc/lIfCoksAjwbCb6DHxT7YQUz2exDVUU9sN+8/ifJ
	 5XRLyk7ziLg/JwkaSCxhlMUgALSAz0qUl7At29atgeXWI8DT0ZBNue+eLq5ZPS4YW62Tm
	 gL1FeCHzcrIThrjn8Pk6erzYyaQshnWj/iCHxDZ2dCRWeShotJvsXTa44sBQFTBCOiSlv
	 XBqCpFV8Iw9D+dPrUurUg01mm9pXoNdsKrEjkzKy8Z6iwgDYUJyi9X0ZtuCm8Of1ezppp
	 m6/9+qiP5k1aQxKXz7cOnvAfXJIRM2NTnXg8sULfZ1luXM4bYsEgvLXDcy6ZZNvklMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274080;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=YoekcW5M6HBeqAKu+dPMxxseHZI0rbbZ9FvBEYHmiH0=;
	b=0SnymIuqqfD76WFe8n0LId7zlLqq1mt2TpbGrgxIe4jnNNmSmHF8LOO7Ari0IrpnqZCD
	 3UmLp2Dp9i2FmnIZgwo1zNbYv1UzVAsx3GUp2rRypWXxqIHRPbYZm6ZX6sSuAMJkICT5P
	 MTIZeA3X9eskfsXviOtNkWGw7NWQqfqNerEey5ml+HGoMtTNDjXuVdTFUcmjjMjyRqIvh
	 vgnH/x/O8GvENQ/ck87/psfOfNCbXkqLTkNNwj3iV2X2A6jpCTQvctmHlMng7MRe+yutJ
	 IMqMCiJjQt+cXoqCoXCwpx+JF2Ta8CtNDDtQPFxmmzFBVQffCXB/81CeC3mFr156wdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a7yHftr0;
	arc=none smtp.remote-ip=209.85.160.52
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1EC606A321
	for <linux-block@vger.kernel.org>; Tue, 10 Nov 2026 01:27:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F1EC606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a7yHftr0
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4a76f0cce5fso686726fac.2
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 17:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794274079; x=1794878879; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YoekcW5M6HBeqAKu+dPMxxseHZI0rbbZ9FvBEYHmiH0=;
        b=a7yHftr0d0Ms5sFOlelLvEoWuEVYQDOQj/PKzXEMTL+2qG6P7NEXXRaF33KlfqFUZv
         gWakab0GEKhj0C6HIWEC+XmJi5HYP5sACKmrfz37nUS5lw/UMN5Hw6ix7TXNsPj53krz
         wqo1Rag+KsgatT6Hi91F7BpLoIYWz+TxmwhUuVIOAncp8bvLtDyf6CzPrLF3hSx3w0PX
         UsInBJrWh7LLbh1cTIqHutmUk2UTBC/N3UdvXgKCa8SvtTo0rZdoCltpxYfDET0iaR2p
         H29etj3Yz5FNZMzOk1bu71Wo+XQJrHNaNmLc/KLPu27c07KB85kWBKuKl07/E0mmQjdm
         L7lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794274079; x=1794878879;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YoekcW5M6HBeqAKu+dPMxxseHZI0rbbZ9FvBEYHmiH0=;
        b=YmO2O+lYmqM/E7l/XORVGTL5IQquUkIrpwcxwF13UCwK+D6hpVWf2O/SXVlPArVVK8
         mBwa0Lk8sR9c9mjjmujMm39TkYph0P41kappcJr8z7Tgl/x4k2qyIzYz3BJhiDJ9BvvQ
         O9CF/eHN+bRg4gSWomyRvQVeqRVq5nmqdjpZiXifzZw+II+HBeYBlz7CICaHDvAc2iI3
         XTvwCwORw8tQMqgfpmYsruvK8nMi+jD7IEdRaiQjLsBVVcDg5Teje71/PYpKx8kAlJc7
         GXzG5BHFREijZDSKmr3p2+NcL0WnL8X5m7GTIvUhqWGndYxoBl6KsX+HuuO3pafUs/hD
         gOaw==
X-Gm-Message-State: APuU4Z/bSVO/pmUGpSrWdsayHRSM5VJhMvQUCKn5DDIyQvEo09ZLsgYf
	pEvdo5OthBMvb6AKuEmEMDbLDLoE44nLcNC+qG+1rQxHAaDPdAIw2xty
X-Gm-Gg: AYBFou16qeKzsNUpRLmRXwIOVoPhfabWqSDL5K+6M2DbiLkat39lGRluFFk705t7U0T
	m9XX1CoRGlcRQVisyIilwkoYh1ryH5mxskKaKUc11u2A8s1jjQEqFitMHY66M9DxGM+4Xe36Y+w
	KLq6v7uUonseGO7nF5RB0T/+bqMqFM2+LCw+5Zr+BVJ2vSZ8qIGxYRTbIzXZq3nI6fVWA0UEHQr
	z+Hu+wgTt2QMAWjqRlhRBi5RF4QOgLDn9tBrHSyIoDkrEkeEl9MjW6XE3T0JOwLSSfoL0xUfB+u
	p8IIiCbAcJFhxww+1EkmRhxcDrrXzxLOwoI5tyqxcp7aQcEIZ800MH4WPJ41M/w9ktS/xZePvrF
	v0tMj1PRGEMkxc3zBtgtCUM+rjaCbWQwzWwt/Q1MFFd3HT3m5rFjlV5upuztGLDRtw6GWUaaH6/
	S/N2q2QvauEB6Se6CI1UPaMtraPBxHCtd7Cn74McAmkofh1Lu+xEyGPdRaRJmyXvJhRzPoRxZ4E
	fZXyutkpnRCTD5wzFfOXo3bErBz1BX64HvY6ACyrBi3yGCCTCBXOV3zmmVWaqFfaUEAPFPcBwAk
	qtA+iCQ06bZzegTa7f85kREfLZQlvIwwTL8OdExFgoSHWHx9UVl+UvSG2552CcnlO4pHq6g8St5
	Tm4pi2ndIX1wHxUvvvCD2ygvbSoRTvHo=
X-Received: by 2002:a05:6870:d1c7:b0:48f:e363:5cc8 with SMTP id 586e51a60fabf-4ae227a302fmr611212fac.54.1794274078752;
        Mon, 09 Nov 2026 17:27:58 -0800 (PST)
Received: from fedora-laptop ([172.245.82.59])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4ae22d1d541sm657257fac.2.2026.11.09.17.27.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 17:27:57 -0800 (PST)
Date: Mon, 9 Nov 2026 19:27:52 -0600
From: Ming Lei <tom.leiming@gmail.com>
To: shao.mingyin@zte.com.cn
Cc: linux-block@vger.kernel.org, axboe@kernel.dk,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ublk: stop reporting zones on an empty response
Message-ID: <avJzGIqp5ZUehCGx@fedora-laptop>
References: <20261109225110056QQJAEflTHzwYHzwXlMBb_@zte.com.cn>
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
In-Reply-To: <20261109225110056QQJAEflTHzwYHzwXlMBb_@zte.com.cn>

On Mon, Nov 09, 2026 at 10:51:10PM +0800, shao.mingyin@zte.com.cn wrote:
> From: Shao Mingyin <shao.mingyin@zte.com.cn>
> 
> ublk_report_zones() treats a zero-length zone as the end of a server
> response, but only breaks out of the inner loop.  If the server returns
> an empty report, done_zones and sector do not advance, so the driver
> keeps issuing REPORT ZONES requests at the same sector indefinitely.
> 
> Finish the report when the zero-length marker is encountered and return
> the number of zones already reported.  Use the existing exit path to
> release the report buffer, including when the first response is empty.

The issue is real, I can reproduce it with one ublk server which
completes UBLK_IO_OP_REPORT_ZONES without filling any zone: both
BLKREPORTZONE and START_DEV(blk_revalidate_disk_zones()) loop forever,
and the task can't be killed.

> 
> Fixes: 29802d7ca33b ("ublk: enable zoned storage support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shao Mingyin <shao.mingyin@zte.com.cn>
> ---
>  drivers/block/ublk_drv.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 3d322fa1bc83..5c14daeaebbf 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -693,8 +693,10 @@ static int ublk_report_zones(struct gendisk *disk, sector_t sector,
>  			struct blk_zone *zone = buffer + i;
>  
>  			/* A zero length zone means no more zones in this response */
> -			if (!zone->len)
> -				break;
> +			if (!zone->len) {
> +				ret = done_zones;
> +				goto out;
> +			}

But this terminates the whole report on any zero-length zone, not only
on an empty response.

A zero-length zone means "no more zones in this response", and so far
the driver continues from the advanced sector and asks for the remaining
zones. With this patch, a server returning fewer zones than requested
gets a truncated report. For example, when the server fills half of
the requested zones each time:

- BLKREPORTZONE for 256 zones returns 128 zones

- START_DEV fails:

	ublkb0: last zone and capacity mismatch (1048576 != 2097152)
	ublkb0: failed to revalidate zones

Both work fine before this patch.

How about stopping only if the response doesn't carry any zone? That is
what sd_zbc and virtio_blk do too. Something like:

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -661,6 +661,7 @@ static int ublk_report_zones(struct gendisk *disk, sector_t sector,
 		struct request *req;
 		struct ublk_zoned_report_desc desc;
 		blk_status_t status;
+		unsigned int i;
 
 		memset(buffer, 0, buffer_length);
 
@@ -689,7 +690,7 @@ static int ublk_report_zones(struct gendisk *disk, sector_t sector,
 		if (ret)
 			goto out;
 
-		for (unsigned int i = 0; i < zones_in_request; i++) {
+		for (i = 0; i < zones_in_request; i++) {
 			struct blk_zone *zone = buffer + i;
 
 			/* A zero length zone means no more zones in this response */
@@ -704,6 +705,10 @@ static int ublk_report_zones(struct gendisk *disk, sector_t sector,
 			sector += zone_size_sectors;
 
 		}
+
+		/* empty response: no progress, don't ask again */
+		if (!i)
+			break;
 	}
 
 	ret = done_zones;

With the above, empty response is handled as in your patch
(BLKREPORTZONE returns 0 zones, START_DEV fails with "No zones
reported"), and partial response still works.


Thanks,
Ming
