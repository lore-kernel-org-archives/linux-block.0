Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F972E610B
	for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 16:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750783764; cv=none; b=X8gCGEU6Rdz07i37smIRb7TtfEOyWy3U+GlkrDm1pObwmw1O8z5p1LOVLshlkwU0WnwsZgqEyurdESg+D9gDX+n4iTbQeVmeGK//abDcne4Om2R9rJ/aAYMckfo4r8tp1+4K/jqOobLL1D2R44DAFDbynLUDBgGGyDX6qt0ltYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750783764; c=relaxed/simple;
	bh=DFzwDCdmcdPCJ05ZBQ6ykk/u73SbQVDTdPNlya8JXnY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=cFIk+k6cFNQvGVrlPTTgVDGTMqJIv4xYgErYKvo+NltiuK53Pzj2KlejscEPMOBHMO5PZvZdcdIMzVDmiPEsDrfwSYnHR1+P7jru8RjCIE1i6AkNV89yBOajMw2vdu6RUGN++misluB5GGmKDw6IWFmHWwjIXB7fYqkig1WuJ7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=e7cRFQGs; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="e7cRFQGs"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-234bfe37cccso10054005ad.0
        for <linux-block@vger.kernel.org>; Tue, 24 Jun 2025 09:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1750783758; x=1751388558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FPF9vDqWTZfjGwMhYHp+XZjGtsE7pqlB3rNEP3wyk4g=;
        b=e7cRFQGsx1sRrH+FIsinHPBk9vD8x9bS42z0h33wPyYYm+XO2uMajhzfrJJxm7YTWL
         xYD0/fhRYZF/uXJJmhYfp2W5TOcdLZpxMHxllWVwtlPpugzNMf6chM3q1/9UK0uGgFcf
         GuD9CrOCLdpMKSrbbxT0lS4dEV1nRtWdxarvmGIiKkiMQhn0CvpYOVudPOZLXIQPtWwO
         fB/n8TzxxoLKJy/42MA9IEFq/J+w6jI9i8kRGiVPBzcYqyQXD1+JZKRrJu7aJpHbLrKY
         oj2amIHG1Avume2oCP86r3Optyt+hor8W6bXxtz1ib6I95p8JZa8iNW1CD4hBx4T8U4h
         rrfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750783758; x=1751388558;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FPF9vDqWTZfjGwMhYHp+XZjGtsE7pqlB3rNEP3wyk4g=;
        b=WLcP+4RAs9qbrAvazP7zGmgda/fKdisrD9jGUNdp7SmiTzdwvEl6irf28IDjZP16kX
         XBUvPGZEYfI45AbMGwPpT2puQqz5xUyvSypK8B0DNqg6PpDODO6DUna84Ef0J7KTpPH5
         OWImZaXvBVkhYFDImWzK9c32q3I1Fx9hFD0iI5wswraOqAeRZavibp4rahHh+gl6FyhB
         wuddMAsaD356qt0IdmDelqPbwz7/MPcUGcCun5h72k4UEM7p/CxPT1DG6/TkWiIJlFXN
         GamydyS5jEoWsN7JqWq2rAwbYe/LnJ8UD3TMkS1luxP9ACqMOBOoizBA1ycmJfuv1wcU
         c9kw==
X-Gm-Message-State: AOJu0Yzaixrmnvv9X0jEHyWcFrmQGRqIuovScKDnZ8pE36T302yQIwUe
	aXi0i4ZvvOMQaeTfUk+XUq1bj117M18q/TbrPipf78+/9H8ukq1lxrqoI3d4UbFP5pY=
X-Gm-Gg: ASbGncuE+xw1M3dAiusL21UBOjWjcFst5aud4hvixjBTgoC2JzLewrs/ZZFFzEhrj+z
	vp+e9Qky0R/WJxcm37okYRbXw1i+e03Ow/+uQr/rEhOg0bVe0114kIK1Pm2BZ4GVPWluQixMBAN
	R9fkKokBXMyiG/cGsz9NldQHrHYzwgjfhdPdoQf/hJYGecMwhg6lq8cT8szF30WlDe3Kn0Wm90c
	s1NjDW7gy9Ui7X99PNMX8ihtD9k9ouU0pH7j1EyCrKeIAaxVqdyY9JbV/5TlX/8v0YHnprUsg9o
	Qm4r5RzI3+UFFKXAPF0l3a6PsoXJHO+hkqsPnTLIlH4VSQC0CM0BAxh1pJRlrEFD/6MEHg==
X-Google-Smtp-Source: AGHT+IHz7a7GFwqALOUprD+572Qt2+xcIO+oMiI1aILlyrA2ND6B6Y/nOe6JXQ+oNKEwXvS9Vtd/Dg==
X-Received: by 2002:a17:903:4b07:b0:234:e7bb:963b with SMTP id d9443c01a7336-237d97eff8cmr281899195ad.16.1750783758004;
        Tue, 24 Jun 2025 09:49:18 -0700 (PDT)
Received: from [127.0.0.1] ([2600:380:8633:3524:a756:ef64:1aa1:6fb1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8695195sm115142355ad.187.2025.06.24.09.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 09:49:17 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, 
 "Martin K . Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250618060045.37593-1-dlemoal@kernel.org>
References: <20250618060045.37593-1-dlemoal@kernel.org>
Subject: Re: [PATCH v2] block: Increase BLK_DEF_MAX_SECTORS_CAP
Message-Id: <175078375641.82625.9467584315092336312.b4-ty@kernel.dk>
Date: Tue, 24 Jun 2025 10:49:16 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-d7477


On Wed, 18 Jun 2025 15:00:45 +0900, Damien Le Moal wrote:
> Back in 2015, commit d2be537c3ba3 ("block: bump BLK_DEF_MAX_SECTORS to
> 2560") increased the default maximum size of a block device I/O to 2560
> sectors (1280 KiB) to "accommodate a 10-data-disk stripe write with
> chunk size 128k". This choice is rather arbitrary and since then,
> improvements to the block layer have software RAID drivers correctly
> advertize their stripe width through chunk_sectors and abuses of
> BLK_DEF_MAX_SECTORS_CAP by drivers (to set the HW limit rather than the
> default user controlled maximum I/O size) have been fixed.
> 
> [...]

Applied, thanks!

[1/1] block: Increase BLK_DEF_MAX_SECTORS_CAP
      commit: 345c5091ffec5d4d53d7fe572fef3bcc3805824b

Best regards,
-- 
Jens Axboe



