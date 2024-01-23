Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7445F60BA3
	for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 15:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025425; cv=none; b=LziTxKLOloZ5VxgcYO0+/RTBOKtXER5dbYYwbYQN+046yaeoMzHIWDhAuXsBHyfjh4/PwxPF9J+20nJmPFuHSLRUYEwBBo1PWeURF1B2nFY68+cJIiGE4AX53BpJhi3xY5KY/TgHkoDGCCL8/goLptubDExjkbb2wh/edYxgB8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025425; c=relaxed/simple;
	bh=AaP24geF8IGRtSt63M/PXToa50MRD8//aI+xG8otgCI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SOxa95OZ1mramV1ttSc8U3bCt1v+LA5WHdFuQP6AdrZUeMjnR4F67sXcVJyHR6gUgahlgXO8d+XRjCeipbgoLrvLDXUOKwJLJ3/si49vDlVSwNf7UOzHP6yrOOcbdQWrqv1AiZIcQTl04pVChVPQ7vlp/ExGghcdTdpA+fqM1uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=riQ4Ag1o; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="riQ4Ag1o"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7bed82030faso57913239f.1
        for <linux-block@vger.kernel.org>; Tue, 23 Jan 2024 07:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706025422; x=1706630222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=llje3QQCcfIgLmjM+yLro18lUt9cBa2L6SktSvFiZZE=;
        b=riQ4Ag1oWtuepQpBUmQdkqOfJ9kIYFT7/tXbyijkBGIbCWPrDRA7K2OLtVNM0kxdiF
         QBDSpe6z2MS3mor2EgoTZPlUfypphYqd4XUL7j48dNnXN5ZsFW86JXzyJQiASAGjhJTV
         KgXQLmPUHGK/y6qlmjvqyImWf8HQ+S8V+u76J2jOtyrZV+3p8kAhCQetuoGivWOyL4b4
         vjg+aojAav4xvEFzHyaACIIg1NS/eU3Pnw9Xr/as9mTPO0kI5HE3X+qPdyZES6WRxn4Z
         SttdV85vjfsp6BWHzdIunc4Fh+pkQHNzB3RWfd01mldcg5AH/B/GRzxR2aNyEP/T372u
         bydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706025422; x=1706630222;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=llje3QQCcfIgLmjM+yLro18lUt9cBa2L6SktSvFiZZE=;
        b=soOiseMkRdRun+c0on7tDrRh0I64aqTDs/JpSpSEVKk4vPums1wsV3uw8Y7wN54P+/
         FQhlXkP8Wm853/L4gNHRKlXzCx/qpSKy9OAGSW97zbiUzYVSzstjLCdOBEHMFFLm+GUU
         jg/Amo/GUmFIHS+QXq//bkeBf0smEuP7euMLNWQBFc6wyglUW97wRb5TzyLHISZI1o/c
         +qs4Cy1G6TgdLJeDiZ09tUe/neBsJRQMESOxpwJ1gUUtMaYcLWd9eSzWanErFE+J3Obh
         1j2JIrg2r/Xie5lw83pQEHFQn6073Vu077adM3027iKgipB736lcyRJHbW43oaT+/wpI
         hXzg==
X-Gm-Message-State: AOJu0YyU5SU7JEDUmvrZ28/+ItdwqOanC8rlwtx3MRR/prHBLSuoUQ4m
	tv+QR8QKcuOGsVMtP3EPpcDeuMAuG30+BDQWlWqRk7M1Dsh3nbpa6thAMi4JRjyJDH/tcGQFSD0
	AIiM=
X-Google-Smtp-Source: AGHT+IHnzXr+yl4mKBgGkEQDebXz6TP1F2cEuykTezsEAK2jt26K38kM3gc4dxu/46xr6nynPv+mmg==
X-Received: by 2002:a05:6e02:1a25:b0:35f:b16d:cd64 with SMTP id g5-20020a056e021a2500b0035fb16dcd64mr10136211ile.0.1706025422600;
        Tue, 23 Jan 2024 07:57:02 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id n6-20020a056e0208e600b0036193f4e5c4sm4680769ilt.25.2024.01.23.07.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 07:57:01 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Christian A. Ehrhardt" <lk@c--e.de>
Cc: syzbot+a532b03fdfee2c137666@syzkaller.appspotmail.com, 
 syzbot+63dec323ac56c28e644f@syzkaller.appspotmail.com, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>
In-Reply-To: <20240121202634.275068-1-lk@c--e.de>
References: <20240121202634.275068-1-lk@c--e.de>
Subject: Re: [PATCH] block: Fix WARNING in _copy_from_iter
Message-Id: <170602542154.1916499.2341274393906762651.b4-ty@kernel.dk>
Date: Tue, 23 Jan 2024 08:57:01 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Sun, 21 Jan 2024 21:26:34 +0100, Christian A. Ehrhardt wrote:
> Syzkaller reports a warning in _copy_from_iter because an
> iov_iter is supposedly used in the wrong direction. The reason
> is that syzcaller managed to generate a request with
> a transfer direction of SG_DXFER_TO_FROM_DEV. This instructs
> the kernel to copy user buffers into the kernel, read into
> the copied buffers and then copy the data back to user space.
> 
> [...]

Applied, thanks!

[1/1] block: Fix WARNING in _copy_from_iter
      commit: 13f3956eb5681a4045a8dfdef48df5dc4d9f58a6

Best regards,
-- 
Jens Axboe



