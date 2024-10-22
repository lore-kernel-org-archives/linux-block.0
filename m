Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F9B1A255D
	for <linux-block@vger.kernel.org>; Tue, 22 Oct 2024 14:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729608468; cv=none; b=cy58jUm5FOGJFbk7RU05PscIYH35g8PsWrrsgqRxNQu8hGbpSQc0XbO0DSPm4zbQOCfWiHlSU71nLZya4eXMPtboyaChOhVd8L2M3VN2BfeJMm3pD2d3jAQFPnB/LIvEPgXYCEPUOqUs8wZUlXo+VF6J7ZZ7a5sVoUwLZ+BsvEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729608468; c=relaxed/simple;
	bh=AUnKd1M3xJOmg0hqJKHoR2GCQfujvFGd8uC2lbtp0O0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=feRWF9WuNR0Lilucy52Y/0yXQUTdL7iuiVCQMztehU0AcL+SK9Fzdqyy4Vjgp7hnIZ6/ebXuoSCibzidrvmYayNyY3wGDLtDdygqWXOnbmhdoz/FxWYob5x2ozK2kGxFSh2K+AZIDGz2XJaYzIiy1wj3/qm2jleSp2rLlMtL5MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QceEMfXL; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QceEMfXL"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-83a9cd37a11so243447039f.3
        for <linux-block@vger.kernel.org>; Tue, 22 Oct 2024 07:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1729608465; x=1730213265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uvAvvPqD8Vbc7iZ14dJm8AwQMGagAK8236HrKhSHbpU=;
        b=QceEMfXLOui1NwL++tUN6xwq+ct9k0FdaM8IuzcaYfbowKPSrrVV1J17rUoqQBrk58
         EO7Umbe7SbrPnupj5acuyQIQp9+TOKoy+poSoKICwCzkdSs6YWxVWAPD1SUriIbb1+gV
         MOeR4hWmXIDXMjLHla4kdb0LoU8If/7ddP9OrE2ZrlXLHL3DoKpg75JpPQePQ5Fs8fnK
         AkOwGFdQj+SQNVCxWyOnfkaDtCBEnxH9L2D7LYEvmS7JygxTWR5q5F+jN/BnPrx1Qrs4
         YZakC9j7khvV5RwWXwaN8zZ6W0wt8DitxEClrKmnKwcTKOABzez3+E3+Ndm7SOAMwk3Y
         Pc6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729608465; x=1730213265;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uvAvvPqD8Vbc7iZ14dJm8AwQMGagAK8236HrKhSHbpU=;
        b=OfJtEy4y3B45Mt8GxsmZ/2Sl8yv5fE92ze6sYOv0Qtw5/5tfbdPewADHyTkJmf7e2a
         9YN2FmLklr+OoagOwJWgmT9+Q2hrpgTT9M7bxoraQ2pXxLgRZ5hQDujyYfcaMs2Yx0zT
         KTX/Jctcj40UfoXpcd5w+Wf/L+E1iv0tcOZLoshv96p0p/2l3nygBXc+G8xdZF4vPOhx
         9RsPJAEhH7tMp70x6hwTDpvKVDUTxLA9fowd8L0QRITGPJnrrSjztZ0mz77Xnbk0eEkz
         5cZMCqC9eVmQA4Xpm/qiv45+wzSLKmhlJLn+9kRq0DMPS83u6ZiHVhiL07e+5WNoD1ZF
         4JMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw7nGsD13tKJ5CHtwDUIfmisi53lEGEhuUqQrFpIIsUloSZ9aXWPhnWoQZHWPvajx4ym0aBQum//+a5g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxi+k10MsxoVXH9VhKwoazA/KAWfXp33zeYe9yZSTIShCDfQWT6
	pIAZ0eGilo23jfzv4iWe0PqRsfUhSAt9pWzWTLt86R90fVAWjpqJ079olM40O6U=
X-Google-Smtp-Source: AGHT+IFMA8/8XkeEa3fN1L/EdBNpDM5BgG5xlJL0Vg6Yh5CEnSh4WlfRGT4N951JDyO4WWAxrEdCjA==
X-Received: by 2002:a05:6e02:1ca5:b0:3a3:b559:5b92 with SMTP id e9e14a558f8ab-3a3f4060be5mr155339825ab.14.1729608465688;
        Tue, 22 Oct 2024 07:47:45 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4dc2a52fc4fsm1600289173.22.2024.10.22.07.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 07:47:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: tj@kernel.org, josef@toxicpanda.com, hch@lst.de, mkoutny@suse.com, 
 Li Lingfeng <lilingfeng@huaweicloud.com>
Cc: cgroups@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com, houtao1@huawei.com, 
 yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com, 
 lilingfeng3@huawei.com
In-Reply-To: <20240817071108.1919729-1-lilingfeng@huaweicloud.com>
References: <20240817071108.1919729-1-lilingfeng@huaweicloud.com>
Subject: Re: [PATCH v3] block: flush all throttled bios when deleting the
 cgroup
Message-Id: <172960846463.861462.5399495567961070618.b4-ty@kernel.dk>
Date: Tue, 22 Oct 2024 08:47:44 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Sat, 17 Aug 2024 15:11:08 +0800, Li Lingfeng wrote:
> When a process migrates to another cgroup and the original cgroup is deleted,
> the restrictions of throttled bios cannot be removed. If the restrictions
> are set too low, it will take a long time to complete these bios.
> 
> Refer to the process of deleting a disk to remove the restrictions and
> issue bios when deleting the cgroup.
> 
> [...]

Applied, thanks!

[1/1] block: flush all throttled bios when deleting the cgroup
      (no commit info)

Best regards,
-- 
Jens Axboe



