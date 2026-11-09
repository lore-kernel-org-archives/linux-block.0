Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794260469;
	b=pFsH21jUN5gNVFQaDvaI9tozetRJIZA3QGeehWCinnGklUVZrujK+QmEZHJt5p35n+GF
	 gCUetRVlFftxK+xkSGXk0rkteKVgqJZzBJMe7ZzhWAmTK0nPu6kofhtrmNXuD3XL4RPwF
	 0LFPXABQfOrn0TvarYaR2lnT1nB8A0cGNfUwGrHSZ/DdROvsraZx6uwE4ek4h2WqUeiOe
	 dU823VuKl57L9boZ3LsEdPThC2CthJjicCBOE4dS+hDzxYj7u6Rik5FtH9k6UWZthJLFW
	 d+5zsSHvVTyWRshvRWs1ckCWlbfg6C6AcxFs5fGkrJlS6c8HbYS3RnHqdYAGkjcCgTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794260469;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:In-Reply-To:
	 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Mailer;
	bh=cQ9ZUrfagDvFzetYmGWZJ2gxXOJb5fLn+QoANv/Ytps=;
	b=Cuh6rUhg6F1hIU42dkLW6B02OxAlovEp9BFKfnxIQ/bHKEqUgZ7/wZUR5mGNtIILtEci
	 OSj0Psx7baY5YBsFkD2sq9tie3LgwCAtbhalqgwSP1KCsQd+VncNZPoSo1Fz5FRCQM6x1
	 B6ydByK5Dhr2CQN0sQIbDJ5nJmO308P1JFCIs7RiuwdFmmrya8la5lVkEsc8MO3nhFMJD
	 KZvEL/T06XiLLnarwaGlkhRPR45LdDAA0dH8EphAd/uXGbff55qoE1PHwNA/2IunDgnP7
	 p/5j/UmEgEjmcpzeiibT2kvgDtfsg/L5rRY+YVaA3PO2+XKnCmDo+OZEIdu4NrOsV3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jDHvccOQ;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0550B606A325
	for <linux-block@vger.kernel.org>; Mon,  9 Nov 2026 21:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0550B606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20260707.gappssmtp.com header.i=@kernel-dk.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jDHvccOQ
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3b0bbdeae06so836383a91.1
        for <linux-block@vger.kernel.org>; Mon, 09 Nov 2026 13:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20260707.gappssmtp.com; s=20260707; t=1794260468; x=1794865268; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cQ9ZUrfagDvFzetYmGWZJ2gxXOJb5fLn+QoANv/Ytps=;
        b=jDHvccOQJIQsCBpokaBPbumYKIu6HLyCFaxaJy/V9K/E0dRxsDmiDcTm9sIP514+FR
         TYbZJpaV36J1qjpm1Z3x6ku2i8HaNkmqbgbfDIdiTcF1voVk5PvEyZjfPN/1Vw1ioakV
         UB1hJjmBdQd6YBkdCwq7neGOc2Jvnj/dFGWkzTt7P/Lqayo8JuiOEGGECSj527TBlrj2
         Pwxrs7cwSwQD833dAytc3K2YnscwUFpEw2Or8Nc7JV4KeIS9eCcwXYpClDuxVqOBJcno
         t2DSqXQOfiJuHDBTXyOCbcJ/iM40cQAbym/LDGAIH4GcRvcki4k9tbZpjS92WKrE/hjO
         hilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794260468; x=1794865268;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cQ9ZUrfagDvFzetYmGWZJ2gxXOJb5fLn+QoANv/Ytps=;
        b=A6iTZup4+H9Z2vihAQAUjvSUggL/sD6g2uBW622R9/iFOEWxRfYf5/+8PCS4cnIcZj
         eF4j+otwiRN0p2sXZD4xbj/kA19Y2dM4dEN+kEsdGct/O2pSWo23Gr4L3CC+uEKFI7MS
         XBQ1s31dJjcs7ucYzdqT4qNmJ1imRj9jMoeEYMSbDn/Oi7taVF89CPYqb5IhOjBx9LP4
         bUbq5Fjjfi0bVtUpF1B3NwhB5YD9BxN/rFINPdClGK24nMOfDqMSqXq8y3HeeWAcAjGs
         URfEpxdNggeA9XSfmAGG8phH5UesuRRIvl6Gl5Pghu9l994+7Yr02dZKUsmrcNhdQXIt
         E/MQ==
X-Gm-Message-State: APuU4Z/sv6pM8R4Uyieg78a1xPc3QLuC6SAP/zsUQXEDQXphaiV5dhgE
	tAVWT0lf0wU2BTOOBlkSETbKY0UnVlbE6S+tetShB0sjIzBSQexnYzM71cqXl2b0/8c=
X-Gm-Gg: AYBFou3Zfa5Oe0hQScbvXuIJiP6zjhs9NdOZz4RPx3F3QNUz0JGYKKBasb7ut3WtiaR
	DHi+eVVE7A3EUzT0NAg9U2LdbMHU5RYIUlI0jjyETjG3hGZ4Pyk0zq1Yum2Emn6qTI+Sp+mZ7yV
	knXUvIlxFBw/FNhPt91RIU7k843SYE8bFoFNaszZAA+GnnHw0aIsavXSAO3nylpKTHBThFCbr3T
	UhNbubKblIqox0Z9xTany8VUJpNhs0pviS4ZaIZzzlt/2M9G8Q0+1lFLD7Wr0irS0v1G8zB9+Sb
	VRuEJP814vXjJHNOIQsKt7iloiNQv+5yhVMZNcfrrDZNE410XHDfxMsemb3dtb0VSOsC0xmxiKM
	SlGVo2U017ojaYfQ7G6Xd30ug3O6uRXZGZuLd1KdoSVetM+OTuOLYxL93w4T9Z9Yr2z974oM8uw
	ySqd2rbIwwJL+EqnoP1vLIvUpll/mTOSXLwPCFhLQy1FEWYL2Vmau2iNwlbaAlVeyJk38Vt1k4j
	V5LbclIK7tMjhQfAAkrw+PQhQI9z1F4jEux+zp7KNFGjnOW7Q1TJzCUTh3G8ZE8P0XqxRWRTvbu
	pnYvG2MxEdNGJ3omzJbxgdR4B3IbfkeUMgqA5DlrtKaNs/izrtmnYJb77W/mjLtE8FZOGsDeZx4
	VVfAp7yD8x8g6
X-Received: by 2002:a17:90a:ec8c:b0:3ac:6e91:3f22 with SMTP id 98e67ed59e1d1-3b166d273ddmr680652a91.52.1794260468210;
        Mon, 09 Nov 2026 13:41:08 -0800 (PST)
Received: from [192.168.1.106] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b16903a7fasm366974a91.3.2026.11.09.13.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 13:41:06 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <tom.leiming@gmail.com>, Mark Korenberg <socketpair@gmail.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ming Lei <ming.lei@redhat.com>
In-Reply-To: <20261105-ublk-del-gendisk-hang-v1-0-913a91a4314d@gmail.com>
References: <20261105-ublk-del-gendisk-hang-v1-0-913a91a4314d@gmail.com>
Subject: Re: [PATCH 0/2] ublk: don't let one stuck device block control of
 all ublk devices
Message-Id: <179426046567.144457.17637297692373243844.b4-ty@b4>
Date: Mon, 09 Nov 2026 14:41:05 -0700
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 05 Nov 2026 00:25:04 +0500, Mark Korenberg wrote:
> If the filesystem on a ublk device is stuck, removing that device
> blocks in del_gendisk(), which syncs the filesystem. DEL_DEV holds the
> global ublk_ctl_mutex across the removal, so ADD_DEV and DEL_DEV of
> every other ublk device hang too, until reboot. It doesn't matter
> whether the server is alive: when it dies, the release work does the
> same syncing del_gendisk() under ub->mutex, and DEL_DEV waits for
> ub->mutex holding ublk_ctl_mutex.
> 
> [...]

Applied, thanks!

[1/2] ublk: publish a new device by its id only once it is set up
      commit: e5c463e5074a940c644d54d8fc29aba06709aab0
[2/2] ublk: don't take ublk_ctl_mutex in DEL_DEV
      commit: 8067050e7226844fb32062b5cea947e5897d3d7e

Best regards,
-- 
Jens Axboe



