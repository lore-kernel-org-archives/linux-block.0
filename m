Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4214926FDB7
	for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 12:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745497870; cv=none; b=eVSluBIybG8TZ4D8b9XG1nxE/GPMt4YCADPHgIhg9DwBkcwp0k91d7bCtoUEF10pc72yr2PTWhex2n85alZi3rc8utclMMgKE7QgQFKIioGw6q60sLt3yw9DpyFsSkXLWefkGIpDhnHj4gl5Mqr21P2SbAhfhkV0ufhSUuZRTvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745497870; c=relaxed/simple;
	bh=WPftREPW4/qo/5xHH+9LLqlgxhde25Fhn0/iIWIwpuY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=eJKlYGCIxxuwHtwYxHKBjCn9LQLWJKxqkdx/xEUHR873F+OkhVOBqwkR4xyiuqcAxC/F4pdF63GUIgMWAOskUxQvpZBqSB12tIydL/xbdhEo3jvLACLo5Ga2pr2LonDgHqD22pdYuCxzko5L9dYeT4NQT1sq1J1tS4A5NIRCQhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=eX5YrhpX; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="eX5YrhpX"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-72ec926e828so319509a34.0
        for <linux-block@vger.kernel.org>; Thu, 24 Apr 2025 05:31:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1745497867; x=1746102667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pps9V8ncwYdRycRJbT3v3474lDbFCNoVouzd6mCKRd4=;
        b=eX5YrhpXLWESEHDAQA6W29/SJ6NRb7hcv3THQcMZZ5CoZ/HFJLJAtkP6gKZyw+nhZn
         O/clCzNY06950aNnz2byPPXcJcjU6/YJRNXPnMservILBght2mAm/BOZPKYaicULcZoq
         yq38fvvPTRo5uV/MiWPxSvNH1U7Yh2DiihkUhdC1fEbL+R9lvMIVRVM1LnxnOmV3MtaR
         Q2Z0kEyMW9csxK/JkM4hanYTPXkv9ZLZgyfkLP4+kYIEMl2pUsNOjlTIum5d0XmyLhiN
         SlkCIjqgTsXGaJ59ggN7wy+TVWlT5bq2F5J+Qyv00PYwe9FEB+3WoQeem9qPGdPeF8j2
         I/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745497867; x=1746102667;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pps9V8ncwYdRycRJbT3v3474lDbFCNoVouzd6mCKRd4=;
        b=p5R3/+30+fDzxOLvV6n3pTPB6arMY01HCVNdHsmlkdGbb+IqxbxC+Pjt6trGYaZcjF
         3yczXtR4jXInlP0u+j5uJgD8pKXOwvI2miiGzZZDWIFXPbDVm8yhAK6hZGIfxXC6pMR3
         vTPC7qQNLLpvMm/Q60vZrUmFbBwpjVVBxeZESU4l9WeUmmWJdXy+yR3k/JXh8ttN+0a1
         OExAwz0NwgnNIZwwzjfIED8iO4FRGopqeOSokypFK3EedTYk5h5OHrK5WlWzp1NOF4Gf
         F9Iz2OlDUpa4yI8ajytg9wwUcjKUjOw8GeesTtGh/dHPNX97qJPsQF87ZvmHTRByi1fz
         imdQ==
X-Gm-Message-State: AOJu0YyH88Trkiu6yuRTGN3PWrKkwrzNtCRprh+IpoH2Vnq3Y5ID0gzy
	rLFz4gR5nMp3qr9Yn1MypkPAoGxbP75eYJdgnvWpz4hAfF1kzJ6yhPvQwc5X2gM=
X-Gm-Gg: ASbGnctR61ZwAbscn70LC3gUHzlM2Pw/tGuyhMKEXMGg9rL+z9CQhIaGpApzsQv0zQU
	MRgVpLEdeKRc4WDTbvzCNkdXzJgbZPXpwE+WkACiA/YKjYrjwpx5CQYaHMWCc+S/h+bjd5VkHwa
	uRIN/FDUKrApEDxDDcofydnF7tNxzMlbS/HZunPKk5b/5NldfdBGx8+UfN4lJBV7R6vUnYJ5col
	49rgGykMewOY7WHdeEyAOEK9vljUzR0IiT7dOIsT5AfJCSg/fFpGxAi193A0Q4eL/Ng4RTIVrLt
	eY7KK+/WYViOjBEUStkoW5tB3KExIGkE
X-Google-Smtp-Source: AGHT+IHcDAhbNIdVSY+XYgylitasV2oC9fI4HWvx3NtkldPFUlYRuJvXAwP5NGZRmvjfiIpdimj8HA==
X-Received: by 2002:a05:6871:5809:b0:2d9:45b7:8ffc with SMTP id 586e51a60fabf-2d96e21adf2mr1149904fac.3.1745497867264;
        Thu, 24 Apr 2025 05:31:07 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f8249f8c91sm259639173.15.2025.04.24.05.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 05:31:06 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: Ming Lei <ming.lei@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 Uday Shankar <ushankar@purestorage.com>
Cc: linux-block@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250423-ublk_selftests-v1-0-7d060e260e76@purestorage.com>
References: <20250423-ublk_selftests-v1-0-7d060e260e76@purestorage.com>
Subject: Re: (subset) [PATCH 0/2] selftests: ublk: misc fixes
Message-Id: <174549786571.628784.9329773694519239539.b4-ty@kernel.dk>
Date: Thu, 24 Apr 2025 06:31:05 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Wed, 23 Apr 2025 15:29:01 -0600, Uday Shankar wrote:
> Fix a couple of small issues in the ublk selftests
> 
> 

Applied, thanks!

[2/2] selftests: ublk: common: fix _get_disk_dev_t for pre-9.0 coreutils
      commit: 1d019736b6f812bebf3ef89d6e887d06e2a822fc

Best regards,
-- 
Jens Axboe



