Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AFA19306F
	for <linux-block@vger.kernel.org>; Fri,  9 Aug 2024 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723215621; cv=none; b=GRT49Lg4LH2raLx2w6wFfbgzB0XQYB7Ar9hFvDv/wtFGQC7mkoV6bEK6wGsrt8tdbr0ImYdIG1OePtHWWdzFUFYDfmtaRaGf8nr9HcF8QzmkJTG50eBCxofNmBhMCYL73Lf05jczpa3OAPZmSQO4YMr9VVz563giBHay0/ZsXTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723215621; c=relaxed/simple;
	bh=/qp6PF3pa0MpI2HSzGeh9ftvwJzaHN8BV8V/pKyw2Ng=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=T8L//v2pMQEU04XIQBvFIfnweYCEW05osayeKifrSz8h0LJQ+kd3zdi3eznCdyKmKVji6aKe8E7rTPbQHy9cjIURIHYu98NNYzKcqjilbEkEi9oTX1Xv2rZG17qrP0YpGAEo61jxddBuNICeDewZwk/SrLaWiFjlvaMEp9oZGaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=OIEbtZGb; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="OIEbtZGb"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-39aeccc63deso1060195ab.2
        for <linux-block@vger.kernel.org>; Fri, 09 Aug 2024 08:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723215618; x=1723820418; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PbruoYphIt2LOWAoMbWrsERKtX3GRrMmqjT6C2LpNbc=;
        b=OIEbtZGbzOyx/41FrJuI7d5L0msdwZf/WxiMOdEHEm86uupUadxpFFliJj9BKhdYVB
         iIy0mR7Gk1y8lyFFR5BAhkl1BmUQ6KCsiuYVweB5KnJT5uzuBdApN8Baduu+ys2+852W
         VYrU1pth3ogjY2Ks+OKooB3EZmqWMPhx2dApGoCiMC7RLdnWFVFOWtuWSQnl3FGZk1Z/
         gT436zhz/pYAObwF6mMSv4LHaKTGD0eHyviFJF99FLXSq7hRw35zm2JGNjx9S1129SE7
         N9VowmjQtDYlLq92unQVSs1RrhY8lqQt/ceLhRlkV564ZqsW4VQqTeOKGRL0BVg2etAR
         JXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723215618; x=1723820418;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PbruoYphIt2LOWAoMbWrsERKtX3GRrMmqjT6C2LpNbc=;
        b=eZDB9I2AgKbYk0oBX2xu0LhOElNK9MhJ78hScNNcN39SX+PFt7By9IX9dwX4BpfAUa
         IIbjXlfwdGShT4X2PMVsAdfGKivtQD51X6DW8jtqUVCPkUakZHj8UhnhC+E5Ohwog6VK
         IuTboH+uuR+UeNGyMZ7qnxH/HenmETRRRz9f0BX9SSGhsFiFAEeelz66a0XRWHtmetrH
         HVPGWpwF6XzTGxfkQ/ikOPxO4pqJbP62Vhx+3B+r1vGxC2/GupFBYS4nbtEWPMdaCnqr
         gmJrP0wM4FodmCLNhNgOjwxBE9LZ+fysPFwuQ++jL6SwZzY8iWWFWFmNWhDPguByZmt5
         N78Q==
X-Gm-Message-State: AOJu0YyZm+Ptc6e/6fPtdpZNbG58GXTmphg7q9MJG1l3PU+p4zodLi3C
	/+9Ix3MTwb6s2/pIwj47X2u8+8J1fISJ6ud/s6GfaM6j9oVqWFdW9LCQz4il900K8fXg8X9g7ly
	m
X-Google-Smtp-Source: AGHT+IEtJ0RGy1Ve9TgQYxcw9G321vA5Fw/qM7Fudf9z5ohz24NBYXbSuTZiTsfaH5IwV9H2Ijmjwg==
X-Received: by 2002:a92:c566:0:b0:39a:f26b:3557 with SMTP id e9e14a558f8ab-39b81359911mr15346225ab.5.1723215617269;
        Fri, 09 Aug 2024 08:00:17 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39b20ab5cc2sm65164725ab.44.2024.08.09.08.00.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Aug 2024 08:00:16 -0700 (PDT)
Message-ID: <4e41d24b-fff4-4ec6-b963-cc1b8fdf64a0@kernel.dk>
Date: Fri, 9 Aug 2024 09:00:13 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.11-rc3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Just a set of cleanups for blk-throttle and nvme structures. Please
pull!


The following changes since commit f6bb5254b777453618a12d3bbf4a2a487acc8ee2:

  Merge tag 'nvme-6.11-2024-07-26' of git://git.infradead.org/nvme into block-6.11 (2024-07-26 08:06:15 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.11-20240809

for you to fetch changes up to eded04fe3bdad9b11bc82b972b4c6fa79f1726ba:

  Merge tag 'nvme-6.11-2024-08-08' of git://git.infradead.org/nvme into block-6.11 (2024-08-08 12:27:40 -0600)

----------------------------------------------------------------
block-6.11-20240809

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
      blk-throttle: remove more latency dead-code

Jens Axboe (1):
      Merge tag 'nvme-6.11-2024-08-08' of git://git.infradead.org/nvme into block-6.11

Kanchan Joshi (4):
      nvme: remove unused parameter
      nvme: remove a field from nvme_ns_head
      nvme: change data type of lba_shift
      nvme: reorganize nvme_ns_head fields

 block/blk-throttle.c     | 11 -----------
 drivers/nvme/host/core.c | 18 +++++++++---------
 drivers/nvme/host/nvme.h | 13 ++++++-------
 3 files changed, 15 insertions(+), 27 deletions(-)

-- 
Jens Axboe

