Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6534E19A2BB
	for <linux-block@vger.kernel.org>; Fri,  7 Jun 2024 15:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717775731; cv=none; b=blridm0Io8ZNUDEUJGKJPPPeDHHqFID6Mvr7h0a5kW+sUntx6GKTwfAZh44zlttX9bA4C4dRk4HRpFrcEUxKGZJ9mM/WmcOZK6RiI9PXTcCgPHVgFa7yGcVPGssACERp+7n4MRY/Pok4n768zdH389XFNBgrUg+9UV6sbGS9ct0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717775731; c=relaxed/simple;
	bh=qId0FjRxmeGgUfEPKOzH9C474bBFVAXB3+3I34D+A6k=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=eFboIFUVaL/o7oi+1PWyvit7Sz1Himc8ae39Woho60E3Y5y6vKn6nSbnpmQUi4GwgyjdwOdLXHr3ZCrwGt5lyLvZICuhB7EatyWfJwcuP2MjPQrgERn4YHSejkL9DlzbEorQhq0XkSYOiiHBTmYjnnIDDzvlessBUciDrE0DM+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kfpea360; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kfpea360"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3d206832b84so149076b6e.0
        for <linux-block@vger.kernel.org>; Fri, 07 Jun 2024 08:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1717775727; x=1718380527; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOVmvIaQHTfL5oCv5HY/Kk9ibFtcCyT1yblITpb3Kx4=;
        b=kfpea360e1225ENpvZsDS6CoXrqoVBqJMKZB7TAN2/+RoNmTKc9nvz07i8lGw7NGl0
         pqdjbpLJ39NQXtjZUhwFZRB6vuKX96BbNTKCuMKA57hgzBhJXdfgpnwavdSlqQKYK1uQ
         JzjbtnFnZ2WuU8x96PASkYx4uBbAAraX+2Za/sCr6szEMZtLZsDi05ZNqmg2ojxt9Eg3
         vCXeroBR3CxGWfjvzubOTwoSjfCleRgXbi2D2mCF60tScBFd7k6h66etq84xRSCdkx/T
         uRtvtGOUeOlAmP+M0lzzjV06l9k16VcOELpEvfnKKtyCae4RxUV6cr1IyuoFvFItIksN
         7E3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717775727; x=1718380527;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XOVmvIaQHTfL5oCv5HY/Kk9ibFtcCyT1yblITpb3Kx4=;
        b=CDHL4w9KnjkPn/06cFRoXuPxN30CoOoldNj/P21Fk+r719k3roHdBJ1ZsvbliKmwMK
         q3786ga0g/bTAzAfLfgniz38QEOKOuhJ339fQvZRGUg6/fkaKb8LafEuydW20l07YKkh
         msNPSaTXVS2J1d+rA5ufMVH9ZUJUBNcZMvG4J9b2uMOHjQQQHlcvSNBTcCtDnrsyhqcZ
         UiFN7IJFQYnA8l5eZ63uYiCqoUIoG99cYnIZvXBoxTSEvjb9dwGHrSY+JeNQfljXw7DO
         SqDrZQrl44fCCqCWvMbsL5/7WRfhvStXT6oxIJ/MzWwn+K6B7jvmelb6iobbFWGUUATO
         K7Mg==
X-Gm-Message-State: AOJu0YwK7WLGMrCJ9gzrzRsTI+i4VqdGZupDJdujPReL2/8kVmWwO/7l
	QYC8uL8Y7+bayxW1t7pjQLO0C1/T+cl+r4yXFsFKUaHgUnI+ZQmFEhASi4gyRbrOXAs8OQyZPFa
	C
X-Google-Smtp-Source: AGHT+IHS8zleM9cWMcnmZH/9JdFzYLzudifdKHhuq16DC7DFtdnfAX6LGJ208pDGxNDl3595YnwjjQ==
X-Received: by 2002:a05:6830:3d8b:b0:6f9:64df:b694 with SMTP id 46e09a7af769-6f964dfbd21mr657421a34.3.1717775727501;
        Fri, 07 Jun 2024 08:55:27 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-6f94dcf4815sm728520a34.58.2024.06.07.08.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jun 2024 08:55:27 -0700 (PDT)
Message-ID: <f39b75f0-054d-4a69-b647-53999bfdbf05@kernel.dk>
Date: Fri, 7 Jun 2024 09:55:25 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.10-rc3
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

A few minor fixes:

- Fix for null_blk block size validation (Andreas)

- NVMe pull request via Keith
	- Use reserved tags for special fabrics operations (Chunguang)
	- Persistent Reservation status masking fix (Weiwen)

Please pull!


The following changes since commit 0a751df4566c86e5a24f2a03290dad3d0f215692:

  blk-throttle: Fix incorrect display of io.max (2024-05-30 19:44:29 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.10-20240607

for you to fetch changes up to 27d024235bdb16af917809d33916392452c3ac85:

  Merge tag 'nvme-6.10-2024-06-05' of git://git.infradead.org/nvme into block-6.10 (2024-06-05 12:13:00 -0600)

----------------------------------------------------------------
block-6.10-20240607

----------------------------------------------------------------
Andreas Hindborg (1):
      null_blk: fix validation of block size

Chunguang Xu (1):
      nvme-fabrics: use reserved tag for reg read/write command

Jens Axboe (1):
      Merge tag 'nvme-6.10-2024-06-05' of git://git.infradead.org/nvme into block-6.10

Weiwen Hu (1):
      nvme: fix nvme_pr_* status code parsing

 drivers/block/null_blk/main.c | 4 ++--
 drivers/nvme/host/fabrics.c   | 6 +++---
 drivers/nvme/host/pr.c        | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

-- 
Jens Axboe

