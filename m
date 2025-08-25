Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F431DFCE
	for <linux-block@vger.kernel.org>; Mon, 25 Aug 2025 13:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756129677; cv=none; b=RhsFST2uuRnNDVVT5fbZ+H1zLwXR40ur9ctU7yzyrr2OiLPP51Njq/2AGrFV10s3p9osojXgkiFR2fG+gfwO5zBnRYRLChrEsKtXNooKOZjz+e+fztLc5Iq9AxrVj8nIR4iYmc/VvHYWvJeZ26wPsGxd9jiDmpWXl4RFlGxn40s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756129677; c=relaxed/simple;
	bh=0g4nfZL06xXfcqQP2ZXeFhZtwkwQeXk3VS6zc+kDK/g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Sw3fexjYKZ4RXJejabtaAYTvU243jOBZ0nAS1hXrmYEd1Jv4CZo+nnek+GePivtAM2/DuRu0oQjJfK2jRRiSPiVcTKbc9wbqlZb7nP56GTMvyPvN5UJjAcm6hT6XUiDIPWvwFqySv8dARw5j5ZRwNprrwBeh79Zsb6nS7Asq6Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=hfgmdoRS; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="hfgmdoRS"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-88432dc61d8so431232139f.1
        for <linux-block@vger.kernel.org>; Mon, 25 Aug 2025 06:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1756129674; x=1756734474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yaJhzYO4iaGPetQog50EhntUWyYduBz9Frmzzr2P5Qo=;
        b=hfgmdoRSzKpjCpiNql9Lwq6XbXmLMRNwntE8BJy0O0SAFu1eDcv1fjKMmAN/zDohPH
         JG2mu8IaEnJtxXD908Qr6Htuv3a5M0yGo+LJTMJUREKu3VVu/jfj+5glnFhOKf9ml9MT
         ZKQb/ZCvZH5SWMC849Kjqb3bu0WlParJWMz3NZU0hq2qzjlpT6rzSKPSjoll+u51mK9P
         Xh75TZC0vIKPWvyvB74lhX8PVCbOXkNILwMBzygXrLOM14kxwbYOeIusIqZhuXcVNVLH
         EpkXE+emkjI9G1xKi0QOhsePy8AqN/IH9y5LU0CmcoePPCBzPV85nB0kpLVi//JwcvR9
         1mxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756129674; x=1756734474;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yaJhzYO4iaGPetQog50EhntUWyYduBz9Frmzzr2P5Qo=;
        b=dxx8VSs+IL2NH2tE+gcVLCiz3b2u8IhhshM9ENNjCz+sCn77U7RfDLc8ezgCCTEEtz
         3EpsyM9r9D/tEZh9fqzoOQ36SDioo3VVfokwcufUWyMAQwkW/Y1a20rKq25XYENuv8hB
         QD5KRvce5mAfmE2B/6js8Esw7hsYmdJoIBMlLROjSIIIdo9RGYA7eU8/v5hCMm6ALNWT
         1EbGo2jctgbA5Pe4LnL3JnIP3yf6aUtxWiQLnAFBmC9GHPx1+UinQgfMfhV/+uRv+ltz
         agOgQ50jMnsa9sTS91JTkLpIvjJJZMJsbgnwpvm+vQ87qCSyUie1EurdlJXOgy8zLDLp
         J8yA==
X-Gm-Message-State: AOJu0Yw+Um9XOZaK4dGYdPgBSN1vB5ZESkJnk/lrBDRHUX1nZzZWajTh
	VDJTOEmJ29383MR1J6gsgFATV/DQEb5qzWnH/3Tcuf5PHbz2LTTcB/E/VJKi8BJ/7zk=
X-Gm-Gg: ASbGncsxzH/pnFvRSKrrMIr0g8imzhgZ1JtPKRKkYmADtcwSH7tNcor5taqotyTPqSo
	H1lA+wufVMCgdkRNKHxZvFspW1bTUq+jO1397ZAQUzh4uOPzWkIQsxW0snLDY1jBsDHbI6msU4H
	7kf8GO5XywBydtpwEUQINbYyHA57DgmQaBC1ajoQ6U06I3EcH5GTbKp+Mz1UsYokx1fp+cQIYW4
	uxBTvAJr3Jg12LQ+8kpuHsjrrKamHBYxCsTUISsQSzFN5YyfYE9Om0/FSxYHSF4Hchl6bBoXjG4
	pZBQMQ4aSYI5CV/VR3m5cQesDJ0I/0MRw6u+PA0EeXj990IvxctM0S2I7p8cEW4X+w/SG4LAr95
	c8qCH2YHrX5fl0g==
X-Google-Smtp-Source: AGHT+IG9EQPhdHbz8mEGF2jLK140waZfJrbHSx+bzTm1sOM18L8qwaMMO1zcVhW/7At0bhqvqh7H7g==
X-Received: by 2002:a05:6e02:184c:b0:3ec:40cf:2d37 with SMTP id e9e14a558f8ab-3ec40cf2ed7mr54279585ab.31.1756129666261;
        Mon, 25 Aug 2025 06:47:46 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3eb18693d2esm38348625ab.42.2025.08.25.06.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 06:47:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: ming.lei@redhat.com, hch@infradead.org, yukuai3@huawei.com, 
 rajeevm@hpe.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yi.zhang@huawei.com, yangerkun@huawei.com, johnny.chenyi@huawei.com
In-Reply-To: <20250825093205.3684121-1-yukuai1@huaweicloud.com>
References: <20250825093205.3684121-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH v2] loop: fix zero sized loop for block special file
Message-Id: <175612966482.55174.12405819858243003502.b4-ty@kernel.dk>
Date: Mon, 25 Aug 2025 07:47:44 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-2ce6c


On Mon, 25 Aug 2025 17:32:05 +0800, Yu Kuai wrote:
> By default, /dev/sda is block specail file from devtmpfs, getattr will
> return file size as zero, causing loop failed for raw block device.
> 
> We can add bdev_statx() to return device size, however this may introduce
> changes that are not acknowledged by user. Fix this problem by reverting
> changes for block special file, file mapping host is set to bdev inode
> while opening, and use i_size_read() directly to get device size.
> 
> [...]

Applied, thanks!

[1/1] loop: fix zero sized loop for block special file
      commit: d14469ed7c00314fe8957b2841bda329e4eaf4ab

Best regards,
-- 
Jens Axboe



