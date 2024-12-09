Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3255C1F0E4B;
	Mon,  9 Dec 2024 16:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733763465; cv=none; b=BJb6slSidserJaARFnte4gGdE6WI4itpkXIZP+pIfNVzH9sLpCYp3sTCgMwFC4lihwtpxvKVABkjl9mWP8BBY8hgOV1t3hjxE7gnIuwEOw8890Z7uMVcsmppN+PkbrLV8LkW6p0pXWK268uAJS4gLbUoMAsGTGLOlv4UKKiB/70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733763465; c=relaxed/simple;
	bh=sb7AVXlwROWK1lMqK7lyHj2zbRgTTECaCNdGLefWzS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qdoV8wH4D2DypeqXYPVNx5QI15FcsTgTVbbeYxJ+6sUqM6lSRhc43AHvUyU2ypY+7X6e2pMb0SduG7orVJC0V72ATvzNpitJDytcTFa/ITok1cILARU/+j1pUPD8OCQAnfVx+CotPLxecKM0rWo9qSIDlLc7IFHNG7W10d01dVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EU55AQJ8; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EU55AQJ8"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7242f559a9fso4668788b3a.1;
        Mon, 09 Dec 2024 08:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733763463; x=1734368263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cs031+LjjX7QEYcyeO9AS0x5okeBcuxN8HhhB19UC3w=;
        b=EU55AQJ8vI1miW5DBFrLeq+c2YOA+RMdOTd+jlj1qXhcfmyVeWNBJFGE7PG4GsEmd5
         troGVskGI5krxj+OynjrzwUcVj1MHrj7TQ7DhuiYOvbde6af6vj3LHSwb/vHmPqnQeRf
         AjS5MPrk/e9tdY+U5plPi/nmEHrvxcI3pXJ6Kv36VULEUY7rJVPEvDGpFOLDpEnmyhrS
         pJv+HMCla6VFaKwN1WlBvARDOfxC+yZWUPB4RXDQKS0TQ5/JMRmqDly+/2qw2SFnOTo+
         NGkGJalqJluL3RHpa7s89xA9Wa0vIYBT5cGYdLgpmBVuXPNsdwu5cgM8fYfMGSpY+/Fu
         cb2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733763463; x=1734368263;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cs031+LjjX7QEYcyeO9AS0x5okeBcuxN8HhhB19UC3w=;
        b=h6+gQf7YXb5a5Km8NSauZq6fIrpJQVo0MbCVDB/mjekY30VtUHAs1qnQIVwIi0WirR
         E2bGP6eqcs7EoA8pwmqMfJo1uvxfO7YKljoLG9blm/p5iMhETcju7/uUufj1I6bqtxzU
         /HZ88d1t6AjyQ14BuUE+j4WO7LvlcmuroVMzW2h6ihdjCpzxDSx0QT+1Q8cpSInTi/s5
         oCehz5VjQKSMdeGZOtIOQ4igelOa+b+1PDr7YmU1ho3bdToZHJ/iLxKwzoIyj2Ef/fkv
         a1NvozJNhqgJlsu0400ffP6xBSUSWK4n6ECrHW1EulyyXtT6hvPQhbLJH0ZOmltoJreD
         iYpA==
X-Forwarded-Encrypted: i=1; AJvYcCUrxBaoXKxghipDA7iHHSKt72s7g/Zq4kl/unKwD15eTNfUm/S8ZUWAvoCYZiV6UXp8QEoKknPSnK/yPy3N@vger.kernel.org, AJvYcCVUFw+gPKKY3gMZfIYnpnoCLoQPVj5im6BszCL8GRVWznq2BE+J1vkwX/FCFEykU/fZSpVYMzzJI565Bg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr6fhhAiPWeRrpNVmK5N5GTfaS593/39mP8SbTOpgcl7YRMz0m
	jPbSbOASVV50fgyu55U+UagutNkj/4Y4ZtXNwakWZmt1Rl8P6jaNI9LXuQeX6yo=
X-Gm-Gg: ASbGncuDPyCGVPpZjWg/UG5omi8yjakhYwpgZI8aHT/6JTgEDnEMlDP8KW80SCySuc8
	7Yqm8cIZle/FQULTgzKErwRTDEN3T6DtVNxH2MwyJU4MXVQok9QrzrKi7bqPgazXWZSI9tCff7k
	3NDkybEUyxpii2EBtC98yVwteISMaxodh0YhvjabfdzLR+/AluJ9Egv8eafKk6f5YNzNjA602jQ
	GTVhL+91AZ0P+YMFBtJjpZnNr7ma+pIHjFobCaFxNWQYdyUSNtGxhm39Hj37UBCFuMQt5A=
X-Google-Smtp-Source: AGHT+IFT3pkLkxmkwXq1KmRuWWE/3LcEAyp+a28TxyNZrMBn+elZurcvgNklUPnITcsfJ+T1KQv2hQ==
X-Received: by 2002:a05:6a00:10c5:b0:725:e309:7110 with SMTP id d2e1a72fcca58-725e30974e7mr9859365b3a.5.1733763463355;
        Mon, 09 Dec 2024 08:57:43 -0800 (PST)
Received: from KASONG-MC4.tencent.com ([106.37.120.120])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7273c7f3f1fsm514201b3a.13.2024.12.09.08.57.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 09 Dec 2024 08:57:42 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH v2 0/2] zram: fix backing device setup issue
Date: Tue, 10 Dec 2024 00:57:14 +0800
Message-ID: <20241209165717.94215-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.47.1
Reply-To: Kairui Song <kasong@tencent.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kairui Song <kasong@tencent.com>

This series fixes two bugs of backing device setting:

- ZRAM should reject using a zero sized (or the uninitialized ZRAM
  device itself) as the backing device.
- Fix backing device leaking when removing a uninitialized ZRAM
  device.

V1: https://lore.kernel.org/linux-mm/20241204180224.31069-1-ryncsn@gmail.com/
Update from V1:
- Collect Review-by.
- Update fix for issue 2 as suggested by Sergey Senozhatsky.

Kairui Song (2):
  zram: refuse to use zero sized block device as backing device
  zram: fix uninitialized ZRAM not releasing backing device

 drivers/block/zram/zram_drv.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

-- 
2.47.1

