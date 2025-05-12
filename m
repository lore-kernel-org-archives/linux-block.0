Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6F6293473
	for <linux-block@vger.kernel.org>; Mon, 12 May 2025 13:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747055669; cv=none; b=YQB4aey7qCwx0L8cs8H14Na9FuCW+fxJ3+TZt7uJGQQT7bU9y5NhFjK9WaOWQjghDKRJEcGuriupsVK9hILg0fOmEII0t0oZG16eIir7r4qEwmxF8VOF3/qOVPBDweT+Z2zjBURHqiOnd5r2whkPCPuQ3BN2jDxQzmwzs8JK5ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747055669; c=relaxed/simple;
	bh=u+OUnDRXA95zP50DYQMDl5x+E9wSEH4VyZ/N0xDzzNs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uGY3Szcj7u/Q/DXZVItRiTVRX/NVUM5sj7ZN1OVZ7AS2IzdCdZ2LibT6CLQVQitfiuJMEgxDainR6acNfOdSCYg5WqFr3tEGIn5gYe7mVHeZm+PatRV3YGiQMxBdYq6BX7Z77Iu4l75rqqtq7+eF4XrEiXyYDY4hSubCrxriTjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=f8JStCge; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="f8JStCge"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7cadd46ea9aso707164085a.1
        for <linux-block@vger.kernel.org>; Mon, 12 May 2025 06:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1747055666; x=1747660466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l7uLEvnL9It+L+ySuSLMLY956fbhswBH9YYBR/9I38A=;
        b=f8JStCgeLNuQ3b3c2ZlAVz+DWJyaQTN9Oef4ithT7ldDDnd58ydLkHmGP3R6u2Huvg
         uIRQLM5Xm/jthla2NdteHvDgzBbXCQwvZxHRLwEzwMO0dgiLjhL5ILiHJ3MhWLOROpXO
         ZhzLL30eklNAE1yAU1LhP61zRJmwyXBmx5XQSSYzJMhtb5bDW8iQSX26xZ9a4mR1qUf9
         JKgILcBEAEqP0lQU2s7XdMLNbrIPK5GpakGs1XsKyywQs29KNuMo1PWwsqsADVmQy/Kw
         B2IzMBdl6ny4UQEwUlQ2Cu9AWGX5oSURjq/ZoompUoAZumH55WKDZbUAoIrR/Pm7UBrU
         mA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747055666; x=1747660466;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l7uLEvnL9It+L+ySuSLMLY956fbhswBH9YYBR/9I38A=;
        b=wMTHa4vOM2ZDBKVAr74T+FrN2vhzXXKHK7CZJu3CemVRrT2imoVoS2eYO5/FJT5I98
         CLDQpy4xtvukPmN9xzpYpY3oT9VV8zZ/2MVvg1XMTLzkWt0PM+zUej/J3zPOjbvSTeng
         J/mOn2upDcAnI4jDlgd7P+2vpcJwO87pht134Ld2UDtvt4aEH5g+N2hoDsTECq9skvbJ
         V45BYbOwTxLcmRNv7l4XTyhl+avRnCuC+yQrgkxvgiORW64MCQOhyTRjAC+gEqEdRy/u
         iJp9YS8mcP36Gdy2IgKCdhSJUXaNTgAKhghNWh7J93B9Nl/Jjh1rnYggnxcIzMqIBX/0
         2l7w==
X-Gm-Message-State: AOJu0YxdFThQDN2XQzgSsIlVFO3ahE8GVQLJi5k/tI65emokc/ob4vfJ
	UenuswpzT5zDDG5n0jI5tIGOVEye4dnvMdgzhr7kAnbG3b0Qjofe2HrFE2y85CS1bOGeOtcMLvg
	E
X-Gm-Gg: ASbGncsW7A+/QJKnA448smPj9AgVH+MHcLgGTw4F+8wMrHJToMMtJBJXOJDEV+fTPnU
	Itng5i9LU1dBrDEUKA/7Khsfsov+9qMf+1RDGRZdXkalGrGFIOz094QH9HrdLEirKDUxo5aBnuv
	N6GNDFdZpvPGDspCv2R8tvIYT0h36HF+jUcaa6SEpnuhnFEG5mIyzSDwOpGUvfoxjtJats1/HWy
	dXalfO+K6yfMpOYnsx/zVptT7GVjfdYXY2GGlrPuItioOGocC4p7xfEDOx8qOcYOA35c3Z+QLir
	2e3vPzuhRBlGM9R7AtWIWJgxuTXOodsOuCFTOH80fg==
X-Google-Smtp-Source: AGHT+IEg5qkUNjUgTohGchi7m7P7l8taw6AjG4tuQQkB8eUk9z/8Q4ao9ohGewENQxJuvxHQc7cs4g==
X-Received: by 2002:a05:6e02:2292:b0:3d6:cd54:ba53 with SMTP id e9e14a558f8ab-3da7e21658cmr157478745ab.22.1747055655568;
        Mon, 12 May 2025 06:14:15 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3da7e1136f4sm23046545ab.35.2025.05.12.06.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 06:14:15 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, martin.petersen@oracle.com, hch@lst.de, 
 Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>
In-Reply-To: <20250509153802.3482493-1-kbusch@meta.com>
References: <20250509153802.3482493-1-kbusch@meta.com>
Subject: Re: [PATCHv4] block: always allocate integrity buffer when
 required
Message-Id: <174705565470.246281.8071371916977870882.b4-ty@kernel.dk>
Date: Mon, 12 May 2025 07:14:14 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Fri, 09 May 2025 08:38:02 -0700, Keith Busch wrote:
> Many nvme metadata formats can not strip or generate the metadata on the
> controller side. For these formats, a host provided integrity buffer is
> mandatory even if it isn't checked.
> 
> The block integrity read_verify and write_generate attributes prevent
> allocating the metadata buffer, but we need it when the format requires
> it, otherwise reads and writes will be rejected by the driver with IO
> errors.
> 
> [...]

Applied, thanks!

[1/1] block: always allocate integrity buffer when required
      commit: 8098514bd5ca98beca6ec725751d82d0d5b492d8

Best regards,
-- 
Jens Axboe



