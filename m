Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DEC3803C1
	for <linux-block@vger.kernel.org>; Mon,  9 Mar 2026 10:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773050933; cv=none; b=Jz+8zf5vcO9vltfxG9V0k7ooMv8P1mZnpKNnYHrFiZBacS7fuCsOBzU/9O5R83GuMOyDyjaNTdfCG4Mla67rNHaI8I78y8sM/MO2KdgaQEzERMHRo5YLQI0UneZI2MydHE1zAFe5UrZqg2cQ3paYMcSmgCuxHJF7Dl7LfHn5VVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773050933; c=relaxed/simple;
	bh=xlxOdHU01zXUgPqkDL2Rz95md1PvVDxj1Ea7cW2QxKk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rgvmmU9BNF0K9YtzVYcDzqYmeZsLivJBp94vFDz+ueT4EgdG0dX4tGaF40rg/qOOJZC1vzxNcs/9uedeOzSdPUg2UZmFLpttaLj+tWInU9tV6cC5qlNC1CWsSXXHKkSK56Jvoc7T86l8lZ+LwdNek9KVITm5maJNuHiBj79G4Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=JOJV8ab7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="JOJV8ab7"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso92523745e9.1
        for <linux-block@vger.kernel.org>; Mon, 09 Mar 2026 03:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1773050930; x=1773655730; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TbXW5x5tYbyTYwpxI98m0FduOlkZmsP9jD1G75SV6Q0=;
        b=JOJV8ab7Fowuv5uYkRU/gUcrQSD8AqYLaUJzC0Yl33dBmhrw7mNba4RTnNN+A4BoiV
         uyaWGw4ehYylI844kIBx6mnloPNmo9z0eKAW/5enA6tBXp1qrqQp6Kd/XVaFA4sButt0
         nkUwpVhnQCkG9fQBPTOXv7zeEhBHB/YTyQFcG+9whpHDlUNADx3QWrQ8AKVm/8bwDrYl
         mH/LcurMYqujruh4HWEWPNfNdu/+UtiR8x3VyYUX4FNy7SGgtRlP1KZqbN6GX/62vZyk
         3nebkkq5zfupd8ebLxzdJ7xOnQ3NUdFkppTWbOHP9bz0wZR0aIFIYRAmQT6sJgPJS2bI
         dNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773050930; x=1773655730;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TbXW5x5tYbyTYwpxI98m0FduOlkZmsP9jD1G75SV6Q0=;
        b=TqMXhYu62cV1qWEV2oJh5mUR0wFUNJMB5/ZbUiFP3Gu4DJ4KRTYZe2pIC5jyXVL/bS
         nI3LO98Kag5/qrNl5mvh43xxw/vaRFBp5zMfgDi5t8ehFPkXFFlGaEQYt6Sx5l+vRz2d
         nC8Xis+16QOO/dKzRPBLJb70LESWBxHLRu1yLGDwHa8Dauq2Hw7GJskFy0p9hacwzvSb
         lRliOb99lWZWMM39HSF9Jfx7Wa2ZG3LmTmON+1ieJFSVTEUfBTQNamiHVCKibk/z1wc0
         hA0x4i+RdRvO3sa32W5af4FFqONvLKkfTfZuOBsvoII+P4TMFGZopi3oU19P16ATovP2
         de/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQ3cySYrVRmYmKg6oNN8N/pQS5Yyf6OpuUf2RxaqMcCECcuj4Qzm+o1geLhODosEkYj9s8ASHCigCuYw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbaIA/KRukGl7+qWbfAEkk74a+eveK7pluZ8P7AO/suUBX50RZ
	HphRKwwgTL6zAnv0C8irnAQqGjL5k07sQbVckKeTPdrKTe5BbMYce3RBoaV5I1LOOM4=
X-Gm-Gg: ATEYQzxSPZWdWfMz4XJaY8SE5Biy78Z4MnFocdUNWkLIk8I+DpFe69bn1SC+JkJpkNf
	tiDDKOQEnqKUKJgcxTEdvpUu0wX31uXwHASIT8yeg3cPmllZQ+mbqAyodX2ZUBY2AYCBCi9XkYK
	1TincZ6cXAKCFtL4Luk9RtoLxTuDxM4EvccT8YvYI3q69Y+KOUWinvvYGI6//1YtojVgve6d5KX
	pxlfEwMJ2YB2iEgAnleJz6lYkBFLFrZ7NdbYmszDdXhSNStpZyozDn4U8BAMO4xwPlvHrw5YCdS
	NOzG4sfX394XSX00LgfSzl/GLkhMazhUymTS6CVMqHy6DVGzJIIh6yvHf6xClWYOYQ+gcAT+cdw
	G6HHk0mlMPgFhArHUbDGsIfE8moKxAbdt6OdxI/XsUMN2pB3u8W32YRsWAk1tLxeUnJznU9XF6E
	Vv8zNxo9Q7f9vrrpGCcsWQ7hdhRytzRKFxYNs1oO3NZc9MRn+65+HqZR9GHByEVpwLFk9Zq7eAE
	a+wCI/hVdZ84kq3BdrWuPwPqQ==
X-Received: by 2002:a05:600c:8b5b:b0:46e:4e6d:79f4 with SMTP id 5b1f17b1804b1-48526927a4dmr172833535e9.15.1773050930048;
        Mon, 09 Mar 2026 03:08:50 -0700 (PDT)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48529a2fa39sm66483065e9.8.2026.03.09.03.08.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Mar 2026 03:08:48 -0700 (PDT)
Message-ID: <cbcfb229-9a5d-4552-9ced-788de1e69842@linbit.com>
Date: Mon, 9 Mar 2026 11:08:41 +0100
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] drbd: Make the lock context annotations compatible
 with Clang
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>,
 Marco Elver <elver@google.com>, linux-block@vger.kernel.org,
 Philipp Reisner <philipp.reisner@linbit.com>,
 Lars Ellenberg <lars.ellenberg@linbit.com>,
 Nathan Chancellor <nathan@kernel.org>
References: <20260304194843.760669-1-bvanassche@acm.org>
 <20260304194843.760669-6-bvanassche@acm.org>
From: =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
Content-Language: en-US
In-Reply-To: <20260304194843.760669-6-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Am 04.03.26 um 20:48 schrieb Bart Van Assche:
> Clang performs more strict checking of lock context annotations than
> sparse. This patch makes the DRBD lock context annotations compatible
> with Clang and prepares for enabling lock context analysis.
> 
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  drivers/block/drbd/drbd_bitmap.c   | 20 +++++++------
>  drivers/block/drbd/drbd_int.h      | 46 ++++++++++++++----------------
>  drivers/block/drbd/drbd_main.c     | 45 ++++++++++++++++++++++-------
>  drivers/block/drbd/drbd_nl.c       |  5 ++--
>  drivers/block/drbd/drbd_receiver.c | 20 +++++++------
>  drivers/block/drbd/drbd_req.c      |  2 ++
>  drivers/block/drbd/drbd_state.c    |  3 ++
>  drivers/block/drbd/drbd_worker.c   |  6 ++--
>  8 files changed, 91 insertions(+), 56 deletions(-)
[...]
>  
>  void drbd_send_sr_reply(struct drbd_peer_device *peer_device, enum drbd_state_rv retcode)
> +	__cond_acquires(true, peer_device->connection->data.mutex)
>  {
>  	struct drbd_socket *sock;
>  	struct p_req_state_reply *p;
> @@ -1048,6 +1063,7 @@ void drbd_send_sr_reply(struct drbd_peer_device *peer_device, enum drbd_state_rv
>  }
>  
>  void conn_send_sr_reply(struct drbd_connection *connection, enum drbd_state_rv retcode)
> +	__cond_acquires(true, connection->data.mutex)
>  {
>  	struct drbd_socket *sock;
>  	struct p_req_state_reply *p;

These are marked as acquiring connection->data.mutex, but actually use
connection->meta later. So the annotation should reference meta.mutex.

Also, I think the annotations on drbd_send_* are wrong. These functions
have no path where they return without releasing the mutex, but these
annotations would tell clang that they hold the mutex on non-zero return.

Regards,
Christoph

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage

