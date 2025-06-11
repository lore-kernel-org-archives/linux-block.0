Received: from mail-io1-f44.google.com (mail-io1-f44.google.com [209.85.166.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B57327C844
	for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 12:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749645803; cv=none; b=lIfW0lGMjQeJ8qIKSLIl8fRLRjq1xZKjM/IJWq6UbIJK64khgg80hM47KfwiAhNsl67IsB14X38z1wvdc7zXq5Z9ZxI3RjgppY00cZ1MwNbjKM0i8WsydXKHCKSOf2W3xQQxaYtc3mbN2CMR6CgBiqBWkd1lEr6sExzAwJ4pCzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749645803; c=relaxed/simple;
	bh=HMWIo1UEXBaeGjWOALUSZJVehj7RFUAIWEhwQr/NAkY=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=uZsV3hl3aIUgzxY+jtv5aXubyJcaC+y2YbdlpwqHZspTlNISQI1MkQFUKO3S2dWSau9GjqgaAC/Z3xH/ZWUn9d/ppJE61h6P/FYdsrzFPpw1TY2owGak10wrvuAGdEOwQVyBRQ3avX1flnVXek/Lmelkp7FmQw8FQzK6IHfIZgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=E1O7RAHC; arc=none smtp.client-ip=209.85.166.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="E1O7RAHC"
Received: by mail-io1-f44.google.com with SMTP id ca18e2360f4ac-86a55400913so197289739f.1
        for <linux-block@vger.kernel.org>; Wed, 11 Jun 2025 05:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749645799; x=1750250599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3NM2FJzuzLwO+DRLM8d7gXDFxIqBQHSBWJJdeuI9cK0=;
        b=E1O7RAHCac9hqUgGKw5vR2R9Lz251lPOUy/7+JFe8us2rUbVxbF92ocsNhQuj7WVZr
         1dMyvBANtc3+vCTX2VAEqbBs59BVxsTvQ+AgVY+K1o5iXVGEXIk44KMUdmN3ul5Yco0f
         dY5uTS92B9idpZMR8j7ANcLRte+QTSGuWotwZ4HDzaObaGNFbp0/9O6pCGAj+D3+W00t
         hp5phyMmO/OIBC7+LQ/SgWzj6zT/FF0lEySXV1PHD8lrHEZXhLZmQGZTGVXLai/TYbqH
         RpV90NPtp4AGeQCtwi+ReJfXtQIZiSFuTseHAcw8m28XZSiXS7mfS3Nd3YkUfbb8T6ce
         QNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749645799; x=1750250599;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3NM2FJzuzLwO+DRLM8d7gXDFxIqBQHSBWJJdeuI9cK0=;
        b=Ov9TckfLjToVhL/kWSDPUdIUh5bZwbOsAAHJdmotELfNP+HOj/2aRM4IfymfXLZYA8
         BHX5PFm9fsFdd9QY10YnMGH5begGRWLOkMS3zCMBhA4jRen50tS72B7AUAg+iviYbBaR
         UKLPDt3XtnQXm1abq6guK4whN8NDZ+PxK6NDipoxv/e5tsRF4OZkAYTBLO+hgUJD1iQg
         ew52ABcTkHbdDCtRd0vE+xJob1sUpfHxwwpwXdezuAi1NkFEEi6b99EyuaANZ+ZvH2lu
         q1NSUEq7zAqsagRd/BM6sbj0ADRKYvK/6nsSTlsX8hMHM8cib9zJ+eTA/B4szDZTfCxv
         +zJQ==
X-Gm-Message-State: AOJu0YzpElj9EJ1vIC68sKBoppOg0MSvPn8vY3JmQLXXFbYgOyGzrUtl
	Lkd1Ydo+xgSnwkEsqw17u2NZEFKsqGw9t4nkNuX0zJhK50JdpvYlVlU/otyYj659knI=
X-Gm-Gg: ASbGncucyUPCqGt/asUfc8OE5z9BmKTjMzpkoyA5maB8lX1wx3xTO1YkgHdtAeZVe33
	ctH70z9tD5BiHM2dtS8c8ncNindGFRv03YVVU/ovCG+juB7HqeskCNy0Dk1lwNK2zlsG+k30NEg
	ejSbMsWbctEbT7fPRkjd7sP1jjcW++AE324on4dOWZ3rQ5wArDZN8gMQdmSiTc5BPuTGA1sbE9y
	EgumlTXCCr1CdWgotkAoSO6ttMrxwmSlIQFgwx4VFZ9RvLrsePDnNjrZe5KtfCgOnpGlcT52A/o
	dcfL8GOb4bIE0xToezhdI2C3ZVNI/Rxc9b9DewK4VIWWEj1CGMcf8w==
X-Google-Smtp-Source: AGHT+IH0l0aqdELN4rvNCek1RNUKcGS00jNgO/4RI/iF4Fu2jJ0qPivYgDbcp+ZDeYHlpIi49jSigw==
X-Received: by 2002:a05:6602:7217:b0:874:e108:8e3a with SMTP id ca18e2360f4ac-875bccd0389mr306985639f.12.1749645799120;
        Wed, 11 Jun 2025 05:43:19 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-875bc585b5asm39495339f.9.2025.06.11.05.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 05:43:18 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
In-Reply-To: <20250611005915.89843-1-dlemoal@kernel.org>
References: <20250611005915.89843-1-dlemoal@kernel.org>
Subject: Re: [PATCH] block: Clear BIO_EMULATES_ZONE_APPEND flag on BIO
 completion
Message-Id: <174964579798.357731.8612552058431184719.b4-ty@kernel.dk>
Date: Wed, 11 Jun 2025 06:43:17 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Wed, 11 Jun 2025 09:59:15 +0900, Damien Le Moal wrote:
> When blk_zone_write_plug_bio_endio() is called for a regular write BIO
> used to emulate a zone append operation, that is, a BIO flagged with
> BIO_EMULATES_ZONE_APPEND, the BIO operation code is restored to the
> original REQ_OP_ZONE_APPEND but the BIO_EMULATES_ZONE_APPEND flag is not
> cleared. Clear it to fully return the BIO to its orginal definition.
> 
> 
> [...]

Applied, thanks!

[1/1] block: Clear BIO_EMULATES_ZONE_APPEND flag on BIO completion
      commit: f705d33c2f0353039d03e5d6f18f70467d86080e

Best regards,
-- 
Jens Axboe



