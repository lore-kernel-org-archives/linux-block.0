Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0EB1F37CE
	for <linux-block@vger.kernel.org>; Thu, 16 Jan 2025 14:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737036817; cv=none; b=sR2RYS9ePAtv+Yq8gQQaBGGDZuQ3hjev7rQqExAWLAlMaMSlnSinaRd3qxRDX1UblkJbld9YCXptR6irIyxFfjEdJVcp58GRXkPliGEYsbewF+FQ4RJw36gSBPczZze33hVYrLNIJ+OIx3+LCprl9StE1nmPy35L3RgeCaljiiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737036817; c=relaxed/simple;
	bh=XkrUTtlKH39hWswXHA3y3nMxEuAA4w1hvpOu95EzHZ8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=DYOT+gAgUCqC+UhoASp/OntW83awBfFaIwkZaYyI8YOdSUMXSmQ5xcwLSai5YafKKeyeFheLhrbmprktPYi7NnQrtwo6aJV6+k+rErozQOyXhKbZitfH2J7Q4f+rfcJdpHqi3Up4Id+97/IEd9RnWvwAawSpz2BxDDohY06xu8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=n1CWBpC/; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="n1CWBpC/"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-844ee166150so27935439f.2
        for <linux-block@vger.kernel.org>; Thu, 16 Jan 2025 06:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1737036814; x=1737641614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j4UzF9fwMyRMRgDkplrGQmvMhEdB/FGisfpMIwMXJ/Y=;
        b=n1CWBpC/YmiBUNQVQFtJ02o1npuGaqpv4XdepOUWjJRMgI+3BdmK5fGu1XWRaxny+c
         Y1oU42KH68qOxFG3J2IPGEMZBu74nGK8pU/Ie9UnvMpkx1vHzsOnHk+iRUcEqhUm9qvU
         Lt/BF40fMrr2aYvgxgmTzJoKUZutX3+TNIcJfLteJ6h+hkmypmWbGKlEe5MUcmX/Th2Y
         eVGyAl1CN9YibhoufwO2F4NAU5kmLeXwkzYkSRpjrDGGIIacU5COZPwsrajF6fC4QC2w
         orvvRw7ryTado6NUl8JAiJjJzqvGt+EEQ/uFLJ8iMIgpt2oXRSr9yOwIxcd7zyVtgNz6
         G0mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737036814; x=1737641614;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j4UzF9fwMyRMRgDkplrGQmvMhEdB/FGisfpMIwMXJ/Y=;
        b=CtZo3Sgg12IytH2cj56LAdzrkgGHTlI1F9usmAK3L5XoK+8WdHFVn4/hkcfmOBGUIR
         WiyAAFYDUaqYzXzKZOVgHsW+L0TK5fAZ40mEPax6A4ss/PYqP+K+Xmg1JkHFi+/AKk+f
         kDsOd7dVLzQ9Zf3f6BgG/yDWr8jBpP7RMRBt97tpBS2+tNfC/ccH+pEDiGNQUQ/1so8B
         eMYi3y5etmsr3eypBo3Gk3mvhSMzkHlHDsUG4VF//lokEjLEoOJvklmnPqfoxO8iJ7M5
         iK2sM1EE7nj5Zg0PNFo2h5w8n404fzyDqOjknDnrCR/b7UZXt5QBHboyVxVWO0iNp3iP
         wxiw==
X-Gm-Message-State: AOJu0Yz0fro69OisJNRys+m2oHkvOqHFtzmGiOqs1/R6c0n3EI2T2za2
	hjIWxMqZDlKv32fpI3q/bhcToKvrRFeNi01WpNXy5X1yZrGUybIxwyWQLC+df8I=
X-Gm-Gg: ASbGncvq89XQ6APpQ8gNeV8FlYnWayIzyKQ7wc7/2A52kxFmlnY4zTZdxBAgWbZA5pe
	UsX8UOaKB3hFpIKV0ZVJqVBZ+fKhjTKUTcY4cWnTAXYAo9pG4x2XSFf6xuvp9s2+CF7xOouG0Mu
	vVmDzpCpTAxwuauBKV5XtTWX/WhPa6VRAodp0CWlmfl1GdlbMhe6IPvVwAJCQkeMsS4kYJotIAE
	znwG1cjvycCWNuVB6jWWYhjthYfsz/1I2HnyfKsDNTuf/U=
X-Google-Smtp-Source: AGHT+IFbkAlyO8S6KytSnrQsF4ahczrXbmlDA+fE4PGyZuUt+HdGamzWILU1jppb9w/kprEw5l01eQ==
X-Received: by 2002:a05:6e02:1:b0:3ce:7bbd:971c with SMTP id e9e14a558f8ab-3ce7bbd9852mr105291635ab.15.1737036814001;
        Thu, 16 Jan 2025 06:13:34 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ea756bae75sm36808173.132.2025.01.16.06.13.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 06:13:33 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: John Garry <john.g.garry@oracle.com>
Cc: linux-block@vger.kernel.org, hch@lst.de, martin.petersen@oracle.com
In-Reply-To: <20250109114000.2299896-1-john.g.garry@oracle.com>
References: <20250109114000.2299896-1-john.g.garry@oracle.com>
Subject: Re: [PATCH 0/2] block: Stacked device atomic writes fixes
Message-Id: <173703681323.10865.17086419533205015442.b4-ty@kernel.dk>
Date: Thu, 16 Jan 2025 07:13:33 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-14bd6


On Thu, 09 Jan 2025 11:39:58 +0000, John Garry wrote:
> This series is spun off the dm atomic writes series at [0], as the first
> patch fixes behaviour for md raid atomic write support also.
> 
> https://lore.kernel.org/linux-block/5a24c8ca-bd0f-6cd0-a3f0-09482a562efe@redhat.com/T/#m42a9481059ef011f2267db1ec2e00edb1ba4758d
> 
> Based on block/6.13 . Patch 2/2 is only required for dm atomic write
> support, so could be added to the block/6.14 queue.
> 
> [...]

Applied, thanks!

[1/2] block: Ensure start sector is aligned for stacking atomic writes
      commit: 6564862d646e7d630929ba1ff330740bb215bdac
[2/2] block: Change blk_stack_atomic_writes_limits() unit_min check
      commit: 5d1f7ee7f0b6362c9148d500aeebe49b64b64df4

Best regards,
-- 
Jens Axboe



