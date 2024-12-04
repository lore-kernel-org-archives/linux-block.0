Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C00149E00;
	Wed,  4 Dec 2024 18:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733335353; cv=none; b=W4ptzcmY9Nl8q2juSV+SHyOHGd7jJb1Pw0T1j0EQJVJQLGBBRJnfXzdfZ7DWl8+j4NCfWmZNpK/7al1gD0pRpbN0MaDGFBVm19Cz32Cm6otsjN0vNp5tPCNNis1N+72Lm1/NpCJkv2t08iIrMyR15TdnrqAam0EWH5XRqev2V4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733335353; c=relaxed/simple;
	bh=FD0/ht03WRBQ73VDBnTDMvETY2iUI2vT16e4cTuLWOg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Uw8jKGYgJ9smjiD045nSm9HZxslWp1cuntgQnneHb33KTbAJtCtFAfanXiFVX1e4Yi/uDGM794jQTF71mkWnmSHLt9+YhcPUlUye1bFkg9F2eKM1x/EkXKtXTbWWOWuDLKzJt9TdzVuGHoHiQ1vYBBWdRRbRLvQk/0CtEFxIQzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/4LTYQ7; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/4LTYQ7"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7253bc4d25eso90896b3a.0;
        Wed, 04 Dec 2024 10:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733335351; x=1733940151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Yo8oLvFvp2Cdm2QkdpOsus4N8Of9qDc0gvg/6YYERto=;
        b=U/4LTYQ7/aNc/luj3MVee/0n5xy+94dsryg8WCeCSJnweTR/0lVGkI0GS34rje5Bcz
         dbImJpSlOxQ2NPkbp4Swfv0hFbqFVrJF2Wt3kJ4lcpYpx8s2Mnadk3n5r6pcOnXQd45z
         Ki7jtjVqNk1+9v35NQ0bYx4E0OE7FeHXp+ZXfIZZsW/+SmrO+B8yrcaAa2YW6X8c4M9O
         8UrYJ5IP4Kjetq0KTUYsA1VoYAqUuWXfUreb/FXN/lCPSahspN5tgdw4OnFQ+rAg5zRq
         bSlylGzZ8eSKgU4+5DuoBdML3iflrzXGwg32M/Bjbc/Yywp6bakmZFwjDUncUqdnIXpM
         HGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733335351; x=1733940151;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yo8oLvFvp2Cdm2QkdpOsus4N8Of9qDc0gvg/6YYERto=;
        b=h5k6pHh1PoZkckJjV//1lZ/jN47jeNmEZkUpNQYycUw7FVgmzxxiVgCwsa80XS8K9J
         1dxsk1Y4AqNhAh67vZMD5elXjXM0O+4aAT6pBXUYxrxk5bBf2Axw7R3N4/Jv/by5ueWs
         ojCEhGN++iVJ8S5ISjoPBYsIKOCwcd8zTiaNC/2WZm64xPz4Ugrp8UevZdbFN1yfu89Z
         yJiGcvyn7GnrtH3BvVwpIyxFt9YGR+xtjFwON+syg0b54iOtnWm1s270BZUylMligwZu
         zyMJ5d9qe8fBZywv2pAzqYILPTDLd8E+FPqjgZBUXqQiDdjb6/HbsAkHBI67+9hHgPrF
         USAQ==
X-Forwarded-Encrypted: i=1; AJvYcCViLUqUAM7bfVaf9OeuvnBYiZsK7aOGyMFeQX3UUAxlBm2pUukD2n6lnDF5q/7Dr8zcAtCfmSIyEKZC0A==@vger.kernel.org, AJvYcCWUgydJxNXbedrDAeaIlJ9K7drtI7VzIVbguO6OLieSazm5puajJ1R0uYiPTZu3dkzSzb5FosJtl/yc7UnY@vger.kernel.org
X-Gm-Message-State: AOJu0YxhvZLRCPGU92PozAPrXtPoyOfx4COYGk7ZzaJXpswhtqcs9x9u
	WwSMK3jUsFV1Ho8Ywpf5wVjPf6CWe3MMg9/NkstHZDyZcsNXkxCd
X-Gm-Gg: ASbGncvlU1ctNferwXXOO+kb7ZJbzijPmy5QoxMH5WcGf90zDZHppirYwp2RF9H1gvL
	fYyJJsuQ1Apege48Q+MXbqgq1e+z3UzEo7OZ3vgXYjf/4AmxfiF0Jp6vGmRRMkmjs+i9rx158wi
	IsXdMIFsAySbkHe5wt4oAL6Y7EbVtRwJ7DkxbcZI96OSAQReY3GXkaYzf/FkHFgv7fvarmbPSnw
	yrGcUkDWvM9XiO+AzKFyZ7ZnTttzldaltwkU3Q/VQyBjKupyQz6xYDlxzcy3kTZ0Cd/YhY=
X-Google-Smtp-Source: AGHT+IH2CjLl7GpfCImh5nXrWR251HH3lwwOJlzvSb3HK65i5oIna5wpFc6Xf720CRDjEYag1bQMfw==
X-Received: by 2002:a05:6a00:14cc:b0:71e:60d9:910d with SMTP id d2e1a72fcca58-7259d5a971emr384560b3a.6.1733335350874;
        Wed, 04 Dec 2024 10:02:30 -0800 (PST)
Received: from KASONG-MC4.tencent.com ([101.32.222.185])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7258947b48fsm2064736b3a.47.2024.12.04.10.02.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Dec 2024 10:02:30 -0800 (PST)
From: Kairui Song <ryncsn@gmail.com>
To: linux-mm@kvack.org
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kairui Song <kasong@tencent.com>
Subject: [PATCH 0/2] zram: fix backing device setup issue
Date: Thu,  5 Dec 2024 02:02:22 +0800
Message-ID: <20241204180224.31069-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.47.0
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

Kairui Song (2):
  zram: refuse to use zero sized block device as backing device
  zram: fix uninitialized ZRAM not releasing backing device

 drivers/block/zram/zram_drv.c | 9 +++++++++
 1 file changed, 9 insertions(+)

-- 
2.47.0

