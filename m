Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E293F99CD
	for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 14:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774535181; cv=none; b=Y0JycUVolS8MVmkIsEB2YDRhLoP7+3Je0//Djc7CfchsPgOQHz7/Moa1Wr0LTlE55DChpJzImEgetW15B/QWLt0V5cS+G6lxGKSmj3k1ta1FHTtsjudkXCW1B0cgxZNre6qJA7ILT6s9O3hbws//h+7Tj37T5dwISlfEwA9swxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774535181; c=relaxed/simple;
	bh=6Hv9yoKIKwxTtz3CTjyWdTAt9zBbZOsdr/QjKnf0beI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rddtSfP2V8a3CEOWYsex43sQE9a04A40730OvjD2cABE3V6M/92rjDxp3xQAV/fAzVXukBScvDmguk1XW16LPLEmO7YxGxpNz6hfv626614ccZuCrG0EHgreC/SwznjLQz6UtxVKppeDBotQ8FKv4hrHBPfatvgxCX2mzFHuDG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=miiofPK1; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="miiofPK1"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-439b9b190easo715934f8f.2
        for <linux-block@vger.kernel.org>; Thu, 26 Mar 2026 07:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1774535177; x=1775139977; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D2Q2L6QPYD77pFkuLTamPUn8SCwVh3rf5WS9Lfg0NYM=;
        b=miiofPK1ysa6TeJaSG4fhhRa2ofxi/fWIPkBT7GE+L3kBoztwLURixxUIxP382VmKS
         LzjE0infn6o8jrwjjy0qdIwXLUBy7ayGQT/9MLNEboW5A4fv5LAQPyLKavzqg2cq5BDJ
         z9fzlMfKase65GyHnrWC4J+iDrKrPbtbkTwbapRqEiAKmZ4X5PJlLLM2y+LKbr4drA2/
         wWDH1CzLR4h/IOttgkjbmnEmrb2tMdiA2kRIqbERgmceN68qobLKFst6W2xMaSg7tNAP
         ibNojiB52RthRAsHa1GBRC/I8K5RZAHCbjIWWViTHbmXaUbjef8axTuJLnEtOTlQmGFr
         WGFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774535177; x=1775139977;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D2Q2L6QPYD77pFkuLTamPUn8SCwVh3rf5WS9Lfg0NYM=;
        b=NS+8lMWvZKB/BrzHqo7en1MDN1coElqTLC42MeABxhXSOieBk/rEk3gXrgdlEtovGn
         4d2yNZrUO1AxNhzh+JZcrN3u5vKReoFiTu8WgHS2BWm9ff1OU1g14KSy+nleRgMz/n8u
         rxol4lP1iWHLJsOVf5u0SsCg3sJmdjlzSiliEXRFa1cpaP95iG93EsJSx6HB1c8uIYsD
         Rixj03GtXxX4czBYltFGITiEb0TNhPMJwcMJQNCF7QHVROn3szKjArlrzV0J+Z4y2hWr
         lMQ6UUY4koHcS0tHbGMB3W87Ny8T1ZJ5orAQpse9pQVkWGU1tDk+x7KL7z3sFajiUHNh
         oxcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdt04dbI9IOijU8oKe9VfKdVffmaRFMcu+UuwP3GIWEErstrENMK41L63eX8us/jwJooc6ctdZFeusHA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwtWR6aOs2dbHv0p6LqE50X1WRDh/WvZAweqbw6/cKv9ZuFfmvG
	4fijIDKvEknUEE0OHj6073z35CkmtQekRiV8VkEAG3BV/lsI6EMzplD/4Vk1wI0MSvk=
X-Gm-Gg: ATEYQzxpqZG6EvZKVmi9Fdpfyo7GFh5H5+bhsBtxldFbmwKVpV3gnZutx4Flie1IiV+
	rAwfAdx/gRBV93HEUFMfgtgLtxtgAEbl9sqpmiX12auTKpV2lBO4Ood3lTvr4i5qLu8msT4icFA
	EoW9ojKqjog0EslK0pxzI/h4kckZ3BIhmta12bpswnimSUD5AKN8HTbuNlB2VWazyuSGgcAcJuL
	iRWnhWUdmCDew6WKOTPJYIBuqgaCw6abkf+VVUbYsmiOqD5TRjlg6AD7wCyJTzCHwEgiQ3EZVj6
	RtaMylvWwNZSzADuq3wfiiIwnzy4BJKTitLEYc5srNOr8TR9IAYvegzidC2yDo7oBZISdZN4xH9
	6CEi75vmoVbo6DUB+Uk3zf2t2kA3zHDFMinRf3Tua7/ULdDtfm6/QsuwcXBPWPj0DO3AAJIle+V
	ccUPAHzU57fGE/157IIQRb0hxRPqf6RockEh6g2XGdI+cfqBGZlHg3BACYCB90H8aniv5lRWbuK
	B7U6B88bse4blMuELo=
X-Received: by 2002:a5d:5f83:0:b0:43b:4273:a6d2 with SMTP id ffacd0b85a97d-43b889af3f6mr11954568f8f.13.1774535176699;
        Thu, 26 Mar 2026 07:26:16 -0700 (PDT)
Received: from [10.43.5.171] (62-99-137-214.static.upcbusiness.at. [62.99.137.214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919df85csm11907248f8f.28.2026.03.26.07.26.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 07:26:16 -0700 (PDT)
Message-ID: <af0dab46-3a73-4756-bea6-7cef66bb8d5e@linbit.com>
Date: Thu, 26 Mar 2026 15:26:14 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] drbd: Add check for error pointer
To: Ethan Tidmore <ethantidmore06@gmail.com>,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>, Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260317232318.18923-1-ethantidmore06@gmail.com>
 <20260317232318.18923-5-ethantidmore06@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20260317232318.18923-5-ethantidmore06@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/18/26 00:23, Ethan Tidmore wrote:
> The function find_cfg_context_attr() can return an error pointer or NULL
> in its error path.
> 
> Change NULL check to IS_ERR_OR_NULL().
> 
> Detected by Smatch:
> drivers/block/drbd/drbd_nl.c:6571 drbd_adm_dump_paths() error:
> 'resource_filter' dereferencing possible ERR_PTR()
> 
> Fixes: 626c95b0e2a23 ("drbd: rework netlink interface for DRBD 9 multi-peer config")
> Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
> ---
>   drivers/block/drbd/drbd_nl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
> index c5e253820ccf..1f458eb972e9 100644
> --- a/drivers/block/drbd/drbd_nl.c
> +++ b/drivers/block/drbd/drbd_nl.c
> @@ -6566,7 +6566,7 @@ static int drbd_adm_dump_paths(struct sk_buff *skb, struct netlink_callback *cb)
>   	resource = (struct drbd_resource *)cb->args[0];
>   	if (!cb->args[0]) {
>   		resource_filter = find_cfg_context_attr(cb->nlh, T_ctx_resource_name);
> -		if (resource_filter) {
> +		if (!IS_ERR_OR_NULL(resource_filter)) {
>   			retcode = ERR_RES_NOT_KNOWN;
>   			resource = drbd_find_resource(nla_data(resource_filter));
>   			if (!resource)

find_cfg_context_attr is also called identically in 3 other cases, so 
these have the same issue.
I've also fixed these 3 cases in my squash.

Regards,
Christoph
