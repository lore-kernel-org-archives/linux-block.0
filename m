Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7330126AF5
	for <linux-block@vger.kernel.org>; Thu, 23 Jan 2025 13:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737639284; cv=none; b=iL1U+ai4aLjKOOxd6fk/FnkN0+/qFXyt9NPTwaNJyrHpFqJmmoejyAvQX82CzgVK1GTYj9EMnLh+eJFM9hC+yYInFl82oTl6HpCbKe1cO0ZXUkAiigW4ZmEuwesSiqep8icSjgHbDfLofH9t+Cxtvj6wpkz/6sMCf5vo4VF1LBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737639284; c=relaxed/simple;
	bh=9zJcYfGV+ZajniBTEOgrT76UryFl1jAvuGKaaXBLDLo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gD7dtME06Abkoc+9R3csV2NHzsH71luGLPXpnICCAWDTsldHlVDgaIGBQUKdZCZZPlZXoRlAYIUPwakZHLQ+PQS0SEELkzjc820RO3AfRHDDLQHuZCrqTDITk4uNzXEbn/pL7zt6CZWhh20hy3RkfHJNQyVwLcRpogFPSvlGFWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KevpA4ho; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KevpA4ho"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-844ee15d6f4so69661939f.1
        for <linux-block@vger.kernel.org>; Thu, 23 Jan 2025 05:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1737639281; x=1738244081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bKvFwymZW7VvqewZ7rZtJEVVcDKE3oDTmz2hKU6nuUs=;
        b=KevpA4ho8+Mu5mL0nxHoGLbdh0b8X1NO5zLKgQd4AEo2yw2kR8WtLuN0uYGHnnmxge
         zifOTmmXgww6sz5bpoVtwU1kBUlgNjZjQumPN458BnkGCJIATJWajegSxd+aM/R8uz9O
         KDlO5V4AlOcQof2PHyK+oOz+ZEV6EYOKrZCLBvzWiiqhAm6SLTI6FfGpE1j9u3dbzXf3
         f1e5mStycz7w5BfUCQY9jmpm+LHvLGxBgcY+RnJF7N2UgiqD86rifvLOHXfXkg0yuZmO
         EXvzQfcpSa/bwHKv1TwYX+KD+YTrhYHR1vvoSxDmq56XT1CggXKs/8odq/PBriFCGHQl
         1CEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737639281; x=1738244081;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bKvFwymZW7VvqewZ7rZtJEVVcDKE3oDTmz2hKU6nuUs=;
        b=qocD+/XQ+sAx13O1xiQrcw2jqbHneYi0+KnmafhBGFAPqjtxfN2lCNCv5R+i8ExD8x
         FTK3QuZhtUH0JMS7jnEtKhrrwRpp/zl+TbTDNMrvWrZ9X/o7AV30BR7bAL9bFAxfx3Zu
         4ZWanuByaHRJAUB6CANK/YFqUbZ3L5sFxlDxS8VkLVMjU+4V9SgKeMu4nmaDAbXOqfIa
         EawRFRBblsR2EhwxZOMi0US4hnJMCR7CU4uZG1/UODioFe4gDwtmZVC5vVI/9W9YgM/k
         mF0iwYk7TfIYl2vePAPL6Rq79vzyuZjzB8mUUoEyAuqZNERzbuPUtGeF44pPBFGaCHUK
         dyow==
X-Forwarded-Encrypted: i=1; AJvYcCV3gxSGYLq5YkXEsJnXA3v6H/slhf8maMKy3z7gRcizHev/Z96YWxMgZ5tahgo+bQU/v0j9NmN78NWAdQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxJilvB+uGk+Jng7hAfovrZRcH0EYH7AwNxdhCVt3kiMr8hNKPR
	raPTc0hdK3Z93QT2pVwLxwQczbYfg7ar7FQAjt/sGlPFIZ4aB04r6cemNSIBKW8=
X-Gm-Gg: ASbGnctYje9DiHhzUTSFq+jfgzpHzImn2uNI5IxYg4sBCRF6thFVVVOb7Wsy/Pr3Dvv
	GhsX36Q4ZdqoxpWfolJhFiyadNDIFY7n9SsSzWgjH4r0kpSWNfgr1mpN6RQc55+aMKIz+LIfAB/
	pwBZGb1Ed+nbqpVR6bSZmITCIRZmgWNxkkZm0Ejjm2bD5Nb+4Bb4R/6Epz1ySsdJXLs1PYyKdVd
	mKnbWa2H4xn3oNlB3sQqJdR0jhkQ2QXFlLXMYj+d2RTPl+asZxRC9UhegMiiQdUAofjbSJm
X-Google-Smtp-Source: AGHT+IFVaAg7rlUgoK0h4CjnGdfukwtoPLJ6TJK8zo8Sd+oryaeaDPG6VYhd5CFWhayviPNEOXYkWA==
X-Received: by 2002:a05:6e02:3d04:b0:3ce:8055:9b39 with SMTP id e9e14a558f8ab-3cf743ba91bmr245756305ab.3.1737639281398;
        Thu, 23 Jan 2025 05:34:41 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea756bd464sm4934932173.134.2025.01.23.05.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 05:34:40 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Daniel Wagner <wagi@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Hannes Reinecke <hare@suse.de>, 
 Ming Lei <ming.lei@redhat.com>, John Garry <john.g.garry@oracle.com>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250123-fix-blk_mq_map_hw_queues-v1-1-08dbd01f2c39@kernel.org>
References: <20250123-fix-blk_mq_map_hw_queues-v1-1-08dbd01f2c39@kernel.org>
Subject: Re: [PATCH] blk-mq: create correct map for fallback case
Message-Id: <173763928053.406374.16234649012932331156.b4-ty@kernel.dk>
Date: Thu, 23 Jan 2025 06:34:40 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Thu, 23 Jan 2025 14:08:29 +0100, Daniel Wagner wrote:
> The fallback code in blk_mq_map_hw_queues is original from
> blk_mq_pci_map_queues and was added to handle the case where
> pci_irq_get_affinity will return NULL for !SMP configuration.
> 
> blk_mq_map_hw_queues replaces besides blk_mq_pci_map_queues also
> blk_mq_virtio_map_queues which used to use blk_mq_map_queues for the
> fallback.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: create correct map for fallback case
      commit: a9ae6fe1c319c4776c2b11e85e15109cd3f04076

Best regards,
-- 
Jens Axboe



