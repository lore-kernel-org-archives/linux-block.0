Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D905913CA91
	for <linux-block@vger.kernel.org>; Fri, 12 Apr 2024 14:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712932386; cv=none; b=PFFNPmO4szQUK5CpCsrIYb1JhZFLBVgZIShGX20VZJxL4UXd+GGm8H8DJ7iLXcgwJ+PNZLXPY99bqa5feVhumUo3XX4GeXRYQ7fwPKJJQeejtsI2naN3x36WCpPA28ZxPN2ry0jbcHzpkrJQM7x3jDw2PK+c/tFkaQtKvZ8tG0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712932386; c=relaxed/simple;
	bh=VVOpT9HwxORdHB2frWGih1hsKfYhPqfrT8OpAak0vH4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mP6x3nB9eA9GI68knZS06tlQ9x6+p2oLEfUqYZJJEhXLSIRb9zqBA0Dvtg1O5Yc+P6Vmm/+7e0nYsRuODChXSxnFg2SUdORcKhWDUFFg1iny5qVOSeoz0h4Mg5EqyF3UYYSUGt2XJd0M61WPVe+PBx6fLJrNkmujpjaiUSLhwTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=XXY4vSI2; arc=none smtp.client-ip=209.85.166.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="XXY4vSI2"
Received: by mail-il1-f177.google.com with SMTP id e9e14a558f8ab-36a29832cbdso1417195ab.1
        for <linux-block@vger.kernel.org>; Fri, 12 Apr 2024 07:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712932383; x=1713537183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEvIA01ccEiylf2OqXaKsMDULTARVvUOpRx4F7QaXDY=;
        b=XXY4vSI22POPx2le/puLBftnv+ghML4JIEzhK6mYRM68xsfxmlQ1Nd8DiDrL4gg83j
         RuNefdcpRuFXmAS65uv3XSV0A6brP339zPkwLgab10V7nlqe+b3NOLYPmeXCEkb3tsPi
         N2xxKH+TYNiRgAcQvW/JA1t+0yM7C6+XPA7oiM6eQfqDTtsw11a5ESLVnhBTXvpsJ5O8
         BBQGQWDr/HNOtd/SfybaJZoX7f2uU51TREFcBU2j7NgBVsn2HUsAr69OpjiO5uaeb4pw
         B6v4EHSQvrE0JhJmeOkaf65H3/qlDL92/pilgwkAMrHMhcdjNSLoKN7Pd9QZOpTNgXMh
         HqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712932383; x=1713537183;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TEvIA01ccEiylf2OqXaKsMDULTARVvUOpRx4F7QaXDY=;
        b=CLAxfLRvFuYQh7RI89nhC3jlUF/A2TQZI1jrVwN6HMZmHZn9TssErSLABAuQdkebLV
         NVOj//FSdSxyYP4YoWFT9xK/MVWI+BC2beEahOiTbToO3d1v3ud/fyPoS3PsHNfp6woh
         E6eNyxcWyjY8h4KsT7veeZQencYm4xdugKDg4nGG9NPMNDybwZcR7csiKaw46lq9fQfZ
         UA6Sm6V+di+gp5WaSOvQW2XRePXsyImLDesnzHhJBU2woMFI2lpcxYYEk+YFvnWeeDFQ
         5pSDTjaZ5NsH2zpaVV+qdKf1xeRjzbYGE5NStCHIJHcivCwmqOVMtgswbh35vXzuasKw
         nhJQ==
X-Gm-Message-State: AOJu0YweCcxra9ksJzRkH/PagZYi11jIFqoRk2SX/EpDwqf4leug9vJw
	PkbprbEjPKS91S99Kt8dOrQ3PdSUQVqyXUqBcSC26PBQ5KeUpADswbynwz2jNHU=
X-Google-Smtp-Source: AGHT+IFuOwMs94z+EWLqxi54BMVGSTglNGLYHzzX4pMeSJ5gWr1AHUM/fCT7qyUTcJbydYEGfuo6lw==
X-Received: by 2002:a92:db46:0:b0:368:974b:f7c7 with SMTP id w6-20020a92db46000000b00368974bf7c7mr2877286ilq.0.1712932382948;
        Fri, 12 Apr 2024 07:33:02 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id b17-20020a920b11000000b0036a19d1e733sm1002825ilf.35.2024.04.12.07.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 07:33:02 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: johannes.thumshirn@wdc.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20240411032349.3051233-1-yukuai1@huaweicloud.com>
References: <20240411032349.3051233-1-yukuai1@huaweicloud.com>
Subject: Re: (subset) [PATCH -next 0/2] block: fix cached time in plug
Message-Id: <171293238229.82435.5231159966660263187.b4-ty@kernel.dk>
Date: Fri, 12 Apr 2024 08:33:02 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Thu, 11 Apr 2024 11:23:47 +0800, Yu Kuai wrote:
> Yu Kuai (2):
>   block: fix that blk_time_get_ns() doesn't update time after schedule
>   block: add plug while submitting IO
> 
> block/blk-core.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> [...]

Applied, thanks!

[1/2] block: fix that blk_time_get_ns() doesn't update time after schedule
      commit: 3ec4848913d695245716ea45ca4872d9dff097a5

Best regards,
-- 
Jens Axboe



