Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72C3A155C83
	for <linux-block@vger.kernel.org>; Mon,  5 May 2025 13:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746451123; cv=none; b=qZqyMh6swRs2FG3T4DIfA83qbYUg9CwYagwFbdu+qT0UkUHehvVMt8IOwTBMxVwUzKM1pb3lZxo+tYHeSNSoN17CGdy7cs/0IW6LFmnv1A30J4U3rC0oOJ0+r4a4p1/Sg6DLSPIs2ntyQl7Do7sehBAz6COWZjEy6DTUvs4A1Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746451123; c=relaxed/simple;
	bh=hq6y8M6EMUE95Dd2vZYn2+Mi6Urpharf4PlwIoJvaRM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PZ2WL++d4ae5Mcf8vwm0BmrYuG3cWOp+qdTmb7GWUSd4v3LW4rilfAs58LCqZVHPpTgCZkvpHeOohKtU0D3GJPyx+BDc9sypPwGj9IfZGPqk7uUZvYCgDEBz5ge1P5IQMNmA9JW9Lxb7qqRj4iUKKLIGssyhh1UpQpEHrE05hjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KpG3C05u; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KpG3C05u"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-8647a81e683so119626139f.1
        for <linux-block@vger.kernel.org>; Mon, 05 May 2025 06:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1746451121; x=1747055921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDW3WfwhykoOAaFUE5Qi/rfnM/P3zdLaSBKS4ekX9wk=;
        b=KpG3C05uiRTi2prEQS6OHNrif4jSNpC2Dv1kUXAsJ3REE+52KzY1+pCvphjRn3Ias7
         pauUCXJwEycdFQ9THBTaCQ8vG/45DZzABkVp9/45RR71aRSzc9d8Xddt9tCrAH073Nal
         k2uE9gthZdaPBnm3mAjq3YzMa9HBW90gZiO+BgyoEacA8dpHrcMkRx1DZdzLpeq+9sIj
         //k+Jx9+tmZKjeYRbHoExps0qy0jLM8Z4CHUm0i5CpiH5BoalDnAS9Gk6X0rTck++YXE
         aNKRpTlETmEVhFuMchBjkd8FVLbmQIfNKn6/IvBgzt8qoiY9/HbpN9Bp+T8MEGC9dOJ/
         SnvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746451121; x=1747055921;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xDW3WfwhykoOAaFUE5Qi/rfnM/P3zdLaSBKS4ekX9wk=;
        b=wEu+v8MQpKoQQxnxJdcdlXElZpNcytHtQNaN5DUItzLXUqWfhYCftppPOZBmVfDKtW
         1iwWVzeQXaY5U74PAyUU7628bky5wyu8ASZMObuC5nxWXBYGojpBcP5DwRC49xYKhJI0
         ExbY3UL8RQV+N+uzzgZP1NYJhxP9CoNPPWm8Q6QFtt9+ALfW/RRyDTGnlWX4p7tlegFX
         aamqT3O8gLGxn76KHb+cDm0Fh8tpt/1+Ipifq4WM4KmbDpn25qTyq6LmmPrZE20TX4xr
         8RqQj+2M8is/3zvYaVARu7i1LICJbbeGnDLS4Ezxl6RQ3pu20CTkQbexmsn8dDmjJGdy
         7/kg==
X-Gm-Message-State: AOJu0Yy7Ci5g8CxoolrARSV5/1zHpiKAG/hJwvoXYm/1/SIj6wV3eEHK
	lHprps7WGL+FCdn3+A+YJNCm7BOr/t5lcS2rzox9ptAAktiaL5SW0Zx6RZ4bL5M=
X-Gm-Gg: ASbGncuk/NppiwCv0o86maPRBBXPxHJXkgUAkHPRY6IozdNWmP4ZspBOZoMCEX8sNTI
	eoRUQdTWsuhyLn5P6v5B4r8qhYnOZaiLafIvAEW56Mh6zuI0EarYCU0rvb93kDEoRfaRGKHUXxv
	ZTa2I2FfL470G4/4WH2KsI7jkrfu0B/iZNlC5DmxyigxNjGnKqqe/xZVKvpbuY58ooIIWizk5uf
	nUorZ0VmIHtBBYdoOa73WRTTanMLOlLGEZvXYJmiEThkRo7HY3ipDchskVp3C2EM17thAvXjURq
	5FNxzFzAIiV96eL3e+lgBxJFyKyNkyrU
X-Google-Smtp-Source: AGHT+IGHA8W2N3EgWWsRLrOSopjkbfgMfdY6WCRlo8VJcrzPhskPG8sYepIh09oj8Q04oA9FNg+Dgw==
X-Received: by 2002:a05:6e02:168a:b0:3d8:1d7c:e190 with SMTP id e9e14a558f8ab-3da5b271b75mr69872415ab.7.1746451121540;
        Mon, 05 May 2025 06:18:41 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f88a945d03sm1742683173.71.2025.05.05.06.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 06:18:40 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: hch@infradead.org, Lizhi Xu <lizhi.xu@windriver.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ming.lei@redhat.com, syzbot+6af973a3b8dfd2faefdc@syzkaller.appspotmail.com, 
 syzkaller-bugs@googlegroups.com
In-Reply-To: <20250428143626.3318717-1-lizhi.xu@windriver.com>
References: <aA-QB7Iu6u9PdgHg@infradead.org>
 <20250428143626.3318717-1-lizhi.xu@windriver.com>
Subject: Re: [PATCH V5] loop: Add sanity check for read/write_iter
Message-Id: <174645112067.1190812.13818039566132520088.b4-ty@kernel.dk>
Date: Mon, 05 May 2025 07:18:40 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-7b9b9


On Mon, 28 Apr 2025 22:36:26 +0800, Lizhi Xu wrote:
> Some file systems do not support read_iter/write_iter, such as selinuxfs
> in this issue.
> So before calling them, first confirm that the interface is supported and
> then call it.
> 
> It is releavant in that vfs_iter_read/write have the check, and removal
> of their used caused szybot to be able to hit this issue.
> 
> [...]

Applied, thanks!

[1/1] loop: Add sanity check for read/write_iter
      commit: f5c84eff634ba003326aa034c414e2a9dcb7c6a7

Best regards,
-- 
Jens Axboe



