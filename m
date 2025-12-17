Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EAB33A9D7
	for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 14:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765982189; cv=none; b=nFTBUmH6FHM3g8s37IOjBYbqVova7RIZPRpkJxLGZ1eBDcZ8NfJ9uh75HCvzOj5pYJiVhV5nlgIBwiqDgLWXmIP/4Z6tOchZF5+MFJH8gfCkHjwPG3WUgH5CWEWIILAWJRmTqljf/+d9u1MHE3npUXudo5D1gP3JRxoeNBtBKOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765982189; c=relaxed/simple;
	bh=K0RiY5AfyIg4L6r90U3kXhMr9PutSmMQD4Hxb8eUnA8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=f2X/0oUtvltiunQIUGLWp4K7WwQjIRmgWW0Ei3H3pt2hS7Ga53Tc8wMA04Q7M4kD4Z4t/x5Exvx+TStaVnepMLQqH0z4f52ielC62jixTZBeAo919NsfKCIy4wKYyn1lX9ohE5miBmzHG07ybYTyCw8xe0rrtmavUBtxtY3InSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KPB62hWa; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KPB62hWa"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-657c68a08a7so3196777eaf.1
        for <linux-block@vger.kernel.org>; Wed, 17 Dec 2025 06:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1765982177; x=1766586977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJZ9aWMriNQy+1BZbcxf7ApYBa/N1P8I6lx3TtaJ4mo=;
        b=KPB62hWaudJ3fQJoyG67ivvT+LGjK2WBxvZ5e0v3BeYVMqJOwc9hzghRwq7mS/5D2i
         XGi0fkhi/O/tOVK5ovGr79N870CL0Ve4T/C9D2QvKfl5lJiMOCuRMlpqsYtQlwSuGL7P
         kJnl8aVPgA+pAfGUiROiOuFbpWPfNB1s8dBPA4Q5noRKdZIMnIsf6kfraN27Duvoayld
         Ua5GS7vDvOfhI0v9r2c3+mBCIGtvxSRQxfdD52o8AQo2dM4+XhDuGAqr9N+PYstu5V2v
         EjF9Ka5HAEdk4gk/YdG+GnK8nEh9TISY/kkBoxJos/ShWL8x9hNxHHriS02wsdeeaXBn
         jCXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765982177; x=1766586977;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DJZ9aWMriNQy+1BZbcxf7ApYBa/N1P8I6lx3TtaJ4mo=;
        b=L8IzrnStRhDl3p26qvpEw9qRSaBkFR4C9IKHQHw38AsS2wjFGwetFKJMlQ6mCPSDSK
         x0TWx6khHZupvr8TUbKOMBROu3RAGRB/YZTAXX3Za5z6RJxt0n2ssMdwFZtuNZBXPQWC
         +YkZ9MK8ozuv+6PePinXE0LUk+mNKLU87PGTLc95acOPeHAwP5gsSCysijXlugFfpRK3
         agGc4pb1yDjrsfOGw3CHOVkVA51HPqkrDm5II5lSQlZEyDmAmmO59xJ97wn0iJC7jf1q
         wH9gea+i6IGc6VhDo0x4vI9XixGjo7imgGN8vWbmRFG+xJBKa07vPNyGfvnWcZGG8LDE
         0iOA==
X-Forwarded-Encrypted: i=1; AJvYcCUTuw5k9gtO9xcsvp6mgRNd2ovec8PHChvlq8w+TQGHDlxPUQF39/4kjqV06qgaIW94UI6X3/+4+l37xQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCpk/5BlwprHb65VFisI70tSm+H51xLXCKP1ed957Tvq01UfnW
	O3FX8SoA4aN9j5HxbDVORFUihu/HLeTQKAALNg/ZSD6+A/U0aos5fesJs2rizUgn02M=
X-Gm-Gg: AY/fxX4VmLE4kxpAISos+UaXkR8ppsb3HOUfjsqUXymIGo1YtvegLl5DmyyvKQ9yHqv
	24PLDjArLrzE8IJnpha9HGgqrNnql0JiHmNZ50UDzv8cCh+kEgTPxvz2d2f5+qhKTWmTAsx0ozH
	/jrxoggfs2Wxt9QE+lYJ5s8ttX4FzxyUPGT3LF1TH50lCkxpV/aQoz4tMXbqYm8T0kNNhS1xDky
	tJBvbvqLH7csAViE88EZarFQE7a3quPZRLAqR7CwNTgYyaRhAUK7n2/SfYGXupT+/4Dj3XO9QBM
	+Rh9sstXITucMnpmkNmsfdz5aF0zxv0CGfJjavWmt24byAWw2EFsnA0r8mZPZAvA/1GEwEjCm8d
	JsMmJX837u+YR1ZNdMkx8hEB+vU+jYA8T4Ngmrwv442mAB9ACAGntzdyDz8nbJ2ZlBwVNEGnpmZ
	bUvGE=
X-Google-Smtp-Source: AGHT+IE7whak2dzU39sLk9L0zhKeneNE1PL2Aqh7mvSlD/lOISSawIUVs93E4o897CUL11b8hEKQ8w==
X-Received: by 2002:a05:6820:2004:b0:659:9a49:8f8a with SMTP id 006d021491bc7-65b4576fe5emr8028566eaf.79.1765982176991;
        Wed, 17 Dec 2025 06:36:16 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-65b867ae255sm2141700eaf.1.2025.12.17.06.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:36:15 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: martin.petersen@oracle.com, stefanha@redhat.com, 
 Deepanshu Kartikey <kartikey406@gmail.com>
Cc: hare@suse.de, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+660d079d90f8a1baf54d@syzkaller.appspotmail.com
In-Reply-To: <20251217014712.35771-1-kartikey406@gmail.com>
References: <20251217014712.35771-1-kartikey406@gmail.com>
Subject: Re: [PATCH v3] block: add allocation size check in
 blkdev_pr_read_keys()
Message-Id: <176598217497.7122.17206763785166141358.b4-ty@kernel.dk>
Date: Wed, 17 Dec 2025 07:36:14 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Wed, 17 Dec 2025 07:17:12 +0530, Deepanshu Kartikey wrote:
> blkdev_pr_read_keys() takes num_keys from userspace and uses it to
> calculate the allocation size for keys_info via struct_size(). While
> there is a check for SIZE_MAX (integer overflow), there is no upper
> bound validation on the allocation size itself.
> 
> A malicious or buggy userspace can pass a large num_keys value that
> doesn't trigger overflow but still results in an excessive allocation
> attempt, causing a warning in the page allocator when the order exceeds
> MAX_PAGE_ORDER.
> 
> [...]

Applied, thanks!

[1/1] block: add allocation size check in blkdev_pr_read_keys()
      commit: a58383fa45c706bda3bf4a1955c3a0327dbec7e7

Best regards,
-- 
Jens Axboe



