Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287652D3731
	for <linux-block@vger.kernel.org>; Mon, 25 Aug 2025 13:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129671; cv=none; b=Ctz7hkGmNxOhBawZ0ltNwGQ6RSBOzv94F6TCom6TdYxcYcxr/sFWXBZypZgmjSWwI/zC1oRH6Ip3GR7aY33dne1dYNoBrobWaqxZrIr3YMT2uLfLk9mgaL4rxQGCqDG4Y9yn2XIPtm0tKq2+nXBhrEDsX6CldacPXu7u9lhOO/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129671; c=relaxed/simple;
	bh=vR3ELiBlp+nEPtCo+5yznHNNX7nIlPRPDkL6/Y4usVs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=nLeIHrbO51QJi4wU1ebXVbT0hYqg0yLXNVfU9/uem5Zq8dBP7m3A78Xir18CD1tPNusSmh/EFZ5+gxTyyFd7keJu0Fv7hHLW2U4qxIipDTiRpEQjSwMZrPzkOMv1eANBGGOZCPW0tlN2V4QlBSqZeq0Ej1t86+k3p+ugFZSMd2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=AvcHDz9v; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="AvcHDz9v"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-88432e31114so367123639f.2
        for <linux-block@vger.kernel.org>; Mon, 25 Aug 2025 06:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756129665; x=1756734465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBc+koNxzNYkLXGaE2HMu3UyvOdaSSN/vPguHG2JiMI=;
        b=AvcHDz9vGWYjBnTLOIKflH9zW3Oix/sOTuN6jxMIFuzObC4ZeSZRf4XH0CtBgNs6uC
         jdm6qYJnBITKUoDwb6NdetAMI7ktWD7UQTMWTyNhfBPS0BWzjVLkVWyyPrDHeTK6X39X
         UPGeVkXxz/VwsRbthXVjeG/M7erKUFT1vljWzqGOtKGOsPP/SjY/1DS/JDEHi5dfGTL/
         DcoqKju5cQZFPM80RaDpxU7A3Pj7UEOP9mE0xqqIlNV2o86BrqdRqn39GX5sx0ko3hDD
         SGv5Acauuxg7w0ujRHKLzkLxKmb/llzkycffiB0g0ldmfP1gacmBsAgz1/NnhY10p192
         Prug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756129665; x=1756734465;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HBc+koNxzNYkLXGaE2HMu3UyvOdaSSN/vPguHG2JiMI=;
        b=kPj0Op9nyOt4BuGPEdm7Yq2TLOvQ8+ExMTzOnvtidpB1YIVRfK5xcX/N34CiAs3XkX
         Veg0PYGpcvqdOxt+OyM42/wTqSlglRD6zPuAuFvC8QXVATQUdN2EotVgJH2D+cQ0iZlF
         ra2JOD4Ko0un8nOUA9pqAo12vr56xLm6YAVCmBiSwXOzTrygTDuG+mCSmSCIzg8T4LVY
         K+B+Phv97Jg5w2VAK1sAWzPG9Ih8B3vvcOSAhppzR59wzCN0YmDifzoAQ1Y7eR+EE1ZF
         n9yqrmtNXQvUFPtAtsjZ2tTKzZ+vadysrJPTraasOxay4Zt8UviEf8j82NYIU3GacNkv
         XNoQ==
X-Gm-Message-State: AOJu0Yw0raZIWErNNlYcP5P1gRRUGWzeYxIBgpajLfm49py0vqw2vwC7
	5zWJCe6YsIMhF9PZK9zoORM+YsPPeFMpAG7MR44E7h5PFHBZ5FgLJYwE8PsLGg7hmYg=
X-Gm-Gg: ASbGncurJvhtfj97Nv+v9ocHsYcJMRc3LJFD8vseie1rCV/g/ynagNxiBeKiqmdTHjx
	6nI2cwTRrk15PhcwGigT4Z75pJOBKCFfVDnYWS+O/GDO2VZpLVPUUwcMxUN/gIPYgswvCZP9NA+
	6SZ4yT6kHCuxDwn0XSnGNv8kj+UJ1lRzzCe5n9foGGu0N4mpX36h8Djmvyn2xiHTy8y3xOSAx7q
	FSQbVv2+Hs2A7itjj0YPOowFfZkm0ozBPomuo23aGEXezrARRN9wOphx6gWw7Fi7Jf5dExYFy9y
	lPu5FpVttURPmggO6FjF1LZJkhRi/rqz8CjCJx1fEEdLc91/Z1xi8HrjudnstEY6eLFRNr8yRmf
	CN1ORb92wbposgbaW/Mj1OS8U
X-Google-Smtp-Source: AGHT+IElh9Q/ZAIPGzrZLoacK3I57vtsTZr0FfqOvIqZ2YsoI3hlDMJrBjCesK4YwM4uPnK+wWiMTA==
X-Received: by 2002:a05:6e02:3309:b0:3eb:1211:8738 with SMTP id e9e14a558f8ab-3eb121187c5mr80555825ab.21.1756129664761;
        Mon, 25 Aug 2025 06:47:44 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3eb18693d2esm38348625ab.42.2025.08.25.06.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 06:47:43 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Keith Busch <kbusch@meta.com>
Cc: hch@lst.de, joshi.k@samsung.com, Keith Busch <kbusch@kernel.org>
In-Reply-To: <20250813153153.3260897-1-kbusch@meta.com>
References: <20250813153153.3260897-1-kbusch@meta.com>
Subject: Re: [PATCHv7 0/9] blk dma iter for integrity metadata
Message-Id: <175612966335.55174.17855813946100333153.b4-ty@kernel.dk>
Date: Mon, 25 Aug 2025 07:47:43 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Wed, 13 Aug 2025 08:31:44 -0700, Keith Busch wrote:
> Previous version:
> 
>   https://lore.kernel.org/linux-block/20250812135210.4172178-1-kbusch@meta.com/
> 
> Changes since v6 addressing review feeback from Christoph:
> 
>   - Moved the integrity sg conversion to its own patch
> 
> [...]

Applied, thanks!

[1/9] blk-mq-dma: create blk_map_iter type
      (no commit info)
[2/9] blk-mq-dma: provide the bio_vec array being iterated
      (no commit info)
[3/9] blk-mq-dma: require unmap caller provide p2p map type
      (no commit info)
[4/9] blk-mq: remove REQ_P2PDMA flag
      (no commit info)
[5/9] blk-mq-dma: move common dma start code to a helper
      (no commit info)
[6/9] blk-mq-dma: add scatter-less integrity data DMA mapping
      (no commit info)
[7/9] blk-integrity: use iterator for mapping sg
      (no commit info)
[8/9] nvme-pci: create common sgl unmapping helper
      (no commit info)
[9/9] nvme-pci: convert metadata mapping to dma iter
      (no commit info)

Best regards,
-- 
Jens Axboe



