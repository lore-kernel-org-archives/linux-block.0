Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE66A3BB24
	for <linux-block@vger.kernel.org>; Tue,  4 Jun 2024 14:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717512223; cv=none; b=WsFB+7wrr6dkRT4qB4mOQbBRl2b8pBq+npX4i6jy/KoqqpgH2yo9mES3Iosp6EGEWBBNdNc65rX7Evi7HfkOQxLNsfvsZmPMb0vywKrJDLc7LeXprZkDgbk8yPUkVHUgx5POTZ+ZZUljz2ybZfU32gMmiq9w/6CLpSG1j1Vxddc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717512223; c=relaxed/simple;
	bh=ctL3vOIMlqdpL6CapPC1i2IXAG8LcWYLTNh2SbfxJmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OVNJ/Rr16JlO8LRkTrmecPeiZgBzwFwCHZLvo0aKeQ8qdbTNheylIeySQfL1soTlEqIlqYbL9QKeLguw2+98TIdbYjAtSB/m9iC0JbMkA/W9l4c+GTv70jSZweR4u8X2p+a9RCIBCwvxcw0cZN6c8hEDGl5XjxMUple/qX/BkdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=1wDv1eu6; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="1wDv1eu6"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52ba5868965so861326e87.2
        for <linux-block@vger.kernel.org>; Tue, 04 Jun 2024 07:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1717512218; x=1718117018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZCEn26vgqSLqQ0Kbr2xP1FXMBBWSrXPv0PAuT8e/Jrs=;
        b=1wDv1eu6oWQwOgVoxRmo6/jVdW76i+Rv7vHzZR3oochQDxCFUrsKeAeDWAVR33in34
         JARx+1OWL95eZDw6y8yTGXcpuVnreGTvDCXMXW0lqSsTq0/UcruHNGzOFy2MS1cwVMbN
         KJEWSw6dmB/57HAUDd0Gh3faRLuMdlLtLjJSrgdOy9EXFkkyWQ9K9dojckCID7QV8+pz
         UMAqIVP35kFTK15dTCN6GTg7eU0ycjn4zod2ty0+EoHDqZhI/yZe58skmzTLPSz9myys
         RYR8z4oU8HgODH7cjFD72QFzHrzspbSPS7zhNj9VHHMA1VUskDAReSkBqGVnbNDvOvPS
         ddmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717512218; x=1718117018;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZCEn26vgqSLqQ0Kbr2xP1FXMBBWSrXPv0PAuT8e/Jrs=;
        b=wdTuMvdu9PEM0NaREmHbqvSF/OW+QYjhdTDStW4t06Ivo9uD9uqMttBLfOMxeiDRv9
         W02RU0qpMrWocB7K9E74mdl164ansE+Xdx3WvCkLdL5+FcBNsVr1y6VyO30y2LIP98NX
         eMiW9V7sImBEHBW/Zvq8excDAALZp/yJAsiDzlMFAv9pxD6q2wbxGNVI+UrYgeN0L6yJ
         EavUKGfsw87IySUb4XuQtVSvJkcGJtbvL1eyHwgG1PY3JS1Hz5lGTLPzrl5THheFOreY
         44luK92ZGuV9qKLYlXXHx2b6stbwlzqhbLumgIKlQw28bZs4kgmjSZ9ZIUToLomyIVvo
         xwSg==
X-Forwarded-Encrypted: i=1; AJvYcCXP/HNCH+hBK/PuVF6pvhsGlBk+85rgEsiH+Wxdxrux5txVHxAIsZ7WJaAMb4DNvUKsnaGXDQxCiBJP2zJN8bISHQwg5Mn6L6FyjFE=
X-Gm-Message-State: AOJu0Yzchb4ASgOSbIWmr9xldocn2buY9mDIuL2APmob5kpjlqSX4K+9
	M1TpUumayIo6tybwWNdGhu0wskHlIdnlL9ngqPvWvkuY+W82Rt6zt7nHqXNxZ0Q=
X-Google-Smtp-Source: AGHT+IE7Xgjew2+pYIorgscT+zEtC6CiHfD7k5h5SBbUKiV5TVIkUTo4RiJEiP56EYmy6Bj8NTlM6Q==
X-Received: by 2002:a05:6512:1152:b0:52b:9c8a:735a with SMTP id 2adb3069b0e04-52b9c8a74fcmr3991508e87.40.1717512218053;
        Tue, 04 Jun 2024 07:43:38 -0700 (PDT)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a6522d405sm3599992a12.1.2024.06.04.07.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jun 2024 07:43:37 -0700 (PDT)
Message-ID: <c117893f-865a-4fdf-a480-705c31a72ee3@linbit.com>
Date: Tue, 4 Jun 2024 16:43:36 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] drbd: use sendpages_ok() instead of sendpage_ok()
To: Ofir Gal <ofir.gal@volumez.com>, davem@davemloft.net,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, ceph-devel@vger.kernel.org
Cc: dhowells@redhat.com, edumazet@google.com, pabeni@redhat.com,
 philipp.reisner@linbit.com, lars.ellenberg@linbit.com
References: <20240530142417.146696-1-ofir.gal@volumez.com>
 <20240530142417.146696-4-ofir.gal@volumez.com>
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Content-Language: en-US
In-Reply-To: <20240530142417.146696-4-ofir.gal@volumez.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 30.05.24 um 16:24 schrieb Ofir Gal:
> Currently _drbd_send_page() use sendpage_ok() in order to enable
> MSG_SPLICE_PAGES, it check the first page of the iterator, the iterator
> may represent contiguous pages.
> 
> MSG_SPLICE_PAGES enables skb_splice_from_iter() which checks all the
> pages it sends with sendpage_ok().
> 
> When _drbd_send_page() sends an iterator that the first page is
> sendable, but one of the other pages isn't skb_splice_from_iter() warns
> and aborts the data transfer.
> 
> Using the new helper sendpages_ok() in order to enable MSG_SPLICE_PAGES
> solves the issue.
> 
> Signed-off-by: Ofir Gal <ofir.gal@volumez.com>
> ---
>  drivers/block/drbd/drbd_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/block/drbd/drbd_main.c b/drivers/block/drbd/drbd_main.c
> index 113b441d4d36..a5dbbf6cce23 100644
> --- a/drivers/block/drbd/drbd_main.c
> +++ b/drivers/block/drbd/drbd_main.c
> @@ -1550,7 +1550,7 @@ static int _drbd_send_page(struct drbd_peer_device *peer_device, struct page *pa
>  	 * put_page(); and would cause either a VM_BUG directly, or
>  	 * __page_cache_release a page that would actually still be referenced
>  	 * by someone, leading to some obscure delayed Oops somewhere else. */
> -	if (!drbd_disable_sendpage && sendpage_ok(page))
> +	if (!drbd_disable_sendpage && sendpages_ok(page, len, offset))
>  		msg.msg_flags |= MSG_NOSIGNAL | MSG_SPLICE_PAGES;
>  
>  	drbd_update_congested(peer_device->connection);

Acked-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
