Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FCC33F8B1
	for <linux-block@vger.kernel.org>; Thu, 19 Feb 2026 14:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771512838; cv=none; b=WZp1LZGmrD6I8eAsc9tJvvSdcR34mIHLM2K4/jz35UjLVy452BjxyjC/q82us8u94hwzhbJKRnOudMkSPcPwQx8mn2/0EvRDUWGbzbR/uL+2AOoaoPfsf3flon3JO/SBhlp3IrCxjTfMhDQiYCcBpa3xvQ0aA0MP6qhzzJGE1LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771512838; c=relaxed/simple;
	bh=UtSPcQuy9S0EqE5S/a3ZAC5VC3JZC6AUONOCl5P9GPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EGlrqpabvKUCGU76q9yvjucd4nG6gGtSHc8UmaBQEUZ7TLsd3fGDPg0QgFnuITD7UcdIY54C8857u3pHKACSUJWelsteqrUs7ycKAf72k6LOq8grAuO4iLNwbY3CBUKdyemjnA4itfAZ1Z7FCHsc69Zxp7Vre0+FOUk1MfY9tRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=L+zM3Z+j; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="L+zM3Z+j"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4359a316d89so982077f8f.0
        for <linux-block@vger.kernel.org>; Thu, 19 Feb 2026 06:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1771512835; x=1772117635; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/BPu7oUCo+mkYs6t9WVIVRIlfLwpsIPMLJ2jvnF+txg=;
        b=L+zM3Z+js+MbjFV1LHJxMEWmJNqNbnGHDcBNYS22/len5y+2vEIICqvC3geXuTMDTD
         IAae65O0bXL6ijB3mzNXJQdASyShxQhoBpf/pFd7hEN0lXdeEVAA17RyV3IXLAQMjjMO
         Fy8zMkNSfhaIP/f17HcggDSEk3EeVqmYlg3WTzQynNz5Jr4vF7hAxnlq76rEbCwt5tvs
         FyV82OVy/9a8hDPdhu1Yw+PxmFYmm3Z55/Ir0MiMOzTCxhox5sV7oavyJZcYxloTQgkL
         XZpeIadQ1TuxE5Od5SKrkKHmd90NPI72XBueKuGsSAEj7pMxNmc9zO2k4+FsQFHWpWmK
         yXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771512835; x=1772117635;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/BPu7oUCo+mkYs6t9WVIVRIlfLwpsIPMLJ2jvnF+txg=;
        b=ab3Y0KwGSPVVFJ4yC5azrGMaEil7chJW7VHTRLkUXh4HnCGH8/zzNG3KGT0rWdwifY
         OTNVu1eox/+ouhdUiRwbwrElE2PpePSz9FeKr2sY7hfo6YlltoLV7Aw7n116MeA6OmSh
         dYH8eWNLws+6qR8ndR5kAMR0LeCyHo5sG22za4z5jaqR4d1gfvbVNoVPFTm2zixViQDR
         Bd8QDU5CeClCoS5p9AVmZ6AT+MhL5Rp7KcIw9hrucDUTDwv1FcV1AmPVktBZDB0px93C
         l3uyPq65gIsdfcKDvOAXhUuUSmsyORc20Uc1go/rG1d4Viu78CEU7tdiGCBU5c8SipQs
         qqbA==
X-Forwarded-Encrypted: i=1; AJvYcCW5mMRi7GSQPI+xUXwmskUG0NGQ8VqC1EAaINMCuHjEHANAv7VZyZSCLp7e3+yB65+fhcwFkAffFKvJTw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Dwkm7978uPhZWtRO9fjMOxqdLaONdldyERarV/XDzCt1JlNy
	guUlUrlIfQ4DHKNFiw3iubfBmJq8fJCm4M9KcaXAHpBczcUXfBLLjpFS7wSY5T/s/qQ=
X-Gm-Gg: AZuq6aJVDcdhOrJ/Am/i53Wb3OPB5mwMC1rII01+ttwx7iA6JOqsDaDXH6UMlorFDN9
	1brepVXbzlUpp+PS3M8uJ5c4jkU4M+4e8T6KT4kVfu4mRT41lQIJcPajG1ZDYOPVaXURzjMGpFn
	pC/K4a1qgAlYflSjIs4LyBrGQ35OKHb+j5xH93O2cG/YUR4k7YRpEqKkBNwGqPhdzTCzXVNg3op
	laG/5VWIWq1EbGF/VW24b4qUtlW6wGii9pbZBjInWbuIxj7MigSssMwlv+yKsi98MdToSZV3Nu/
	1HmYUzlaYDjDpXSBZZaWqGnJ2w/VOpNoI1yx1R/oTzinjXL6wUV13hPx9OUeik61KtdNwPfCCMY
	oyO8wou5IWOrc3ZBFfHiuyNbci2tIthOA3vdFG/7sS1mXJjlm2o5P77bIF7hEa522Av3cVGBWpf
	gY0C5jUW5u3JK91VzV32Kbmii8LEpTKb5exS631t4rsiczVNpZekJKJ8hruNlvpxvebs0wvYO3I
	Wvw1ymE+FmxFxJzJiw=
X-Received: by 2002:a5d:50ce:0:b0:437:8fc0:8802 with SMTP id ffacd0b85a97d-43958e527f8mr8129399f8f.48.1771512835126;
        Thu, 19 Feb 2026 06:53:55 -0800 (PST)
Received: from [10.43.5.171] (62-99-137-214.static.upcbusiness.at. [62.99.137.214])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796acf5b9sm49037171f8f.34.2026.02.19.06.53.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Feb 2026 06:53:54 -0800 (PST)
Message-ID: <2b87cbab-49e2-4290-8784-b771e90e016f@linbit.com>
Date: Thu, 19 Feb 2026 15:53:53 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drbd: fix a null-pointer dereference when the request
 event in drbd_request_endio() is READ_COMPLETED_WITH_ERROR
To: Tuo Li <islituo@gmail.com>, philipp.reisner@linbit.com,
 lars.ellenberg@linbit.com, axboe@kernel.dk
Cc: drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260104165355.151864-1-islituo@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
In-Reply-To: <20260104165355.151864-1-islituo@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/4/26 17:53, Tuo Li wrote:
> In drbd_request_endio(), the request event what can be set to
> READ_COMPLETED_WITH_ERROR. In this case, __req_mod() is invoked with a NULL
> peer_device:
> 
>    __req_mod(req, what, NULL, &m);
> 
> When handling READ_COMPLETED_WITH_ERROR, __req_mod() unconditionally calls
> drbd_set_out_of_sync():
> 
>    case READ_COMPLETED_WITH_ERROR:
>      drbd_set_out_of_sync(peer_device, req->i.sector, req->i.size);
> 
> The drbd_set_out_of_sync() macro expands to __drbd_change_sync():
> 
>    #define drbd_set_out_of_sync(peer_device, sector, size) \
> 	__drbd_change_sync(peer_device, sector, size, SET_OUT_OF_SYNC)
> 
> However, __drbd_change_sync() assumes a valid peer_device and immediately
> dereferences it:
> 
>    struct drbd_device *device = peer_device->device;
> 
> If peer_device is NULL, this results in a NULL-pointer dereference.
> 
> Fix this by adding a NULL check in __req_mod() before calling
> drbd_set_out_of_sync().

Thank you for the report and patch.
The bug analysis is correct, but the fix is not.

> 
> Signed-off-by: Tuo Li <islituo@gmail.com>
> ---
>   drivers/block/drbd/drbd_req.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/block/drbd/drbd_req.c b/drivers/block/drbd/drbd_req.c
> index d15826f6ee81..aa3da2733f14 100644
> --- a/drivers/block/drbd/drbd_req.c
> +++ b/drivers/block/drbd/drbd_req.c
> @@ -621,7 +621,8 @@ int __req_mod(struct drbd_request *req, enum drbd_req_event what,
>   		break;
>   
>   	case READ_COMPLETED_WITH_ERROR:
> -		drbd_set_out_of_sync(peer_device, req->i.sector, req->i.size);
> +		if (peer_device)
> +			drbd_set_out_of_sync(peer_device, req->i.sector, req->i.size);
>   		drbd_report_io_error(device, req);
>   		__drbd_chk_io_error(device, DRBD_READ_ERROR);
>   		fallthrough;

In this code path, peer_device is *always* NULL -- the only caller that
sets READ_COMPLETED_WITH_ERROR is drbd_request_endio(), which always
passes NULL for peer_device. So this NULL check effectively turns the
drbd_set_out_of_sync() call into dead code.

Silently skipping the call here means we lose out-of-sync tracking
for local read errors, which is a data consistency problem.

The proper fix is to obtain the peer_device via 
first_peer_device(device), like in a similar path in drbd_req_destroy 
(drbd_req.c:125).

case READ_COMPLETED_WITH_ERROR:
	drbd_set_out_of_sync(first_peer_device(device),
			     req->i.sector, req->i.size);

Regards,
Christoph

--
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
