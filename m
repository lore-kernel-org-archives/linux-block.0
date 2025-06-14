Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CEF22F774
	for <linux-block@vger.kernel.org>; Sat, 14 Jun 2025 12:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749904480; cv=none; b=Z1hYpFBquBpTYr8KU1qFwnFldDFoIGtkUrd0wzY9R2ByFjlPFPX2Yl+11CxOC7XJ73et96p1gDGqweKtEvpk/DCxk4nU6udEG4yibfi7Rftd/2km/uO9Z1j/0VnBVzyXCJQUqXL+NkFSAo3zPn1rMsSidWoJdjxxrunVxmiBI7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749904480; c=relaxed/simple;
	bh=VX+XtAT+jJ5S1upOUHmx7SZIs/72FUPcgQNwsRDMXuU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=aigj5nkicQ0WpDp4q73RTWjGq7z9rROVTLBh09vj0px5YwpOvUqApkpvsHqzKuo2paqa0Oi1jUNTgY+wYV9qmdYPlR72DAQDrpv5n9UeWGJagMrJrct1fssdkmAr57UKj6UDRubs6j1k/SCxVwT10dcr+WaJ6Uc0vHL38chwobU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=KrIhoaR2; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="KrIhoaR2"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3ddd68aeb4fso26388425ab.2
        for <linux-block@vger.kernel.org>; Sat, 14 Jun 2025 05:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1749904476; x=1750509276; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SywJsvbggTSjCIuisg1ArgoQy9nJ3XfLIWVK/3VWyM=;
        b=KrIhoaR2i8fXct+2uisTb+ik5kwRya2u0magg0z3VSYogiVv29NWMnGleDp8fURPkn
         u4E/B9lNcwVf4JzKHxW5DxJraoAMf1GGp8oPHz5CFE3Bsi2a/fCbaG83/DysAP9UIYtN
         IVuCIGokymgsNULMKEVuCUoPub8uPzY81CLLuBkkTXtID4qGhtpLIaSiCPtKd3YxKpbz
         7G5f+nQxsJTjXiY5GEQeFz7tEoJSjUia6mViGu+vN5kiXdJc2163P2XRQShtewXl7gh4
         bnw8o1cApnzuWGIaTvt1ySpUguvRLTGBmdS58JEIRuKIdPDni7PNHr/oPlhFbMmOV24c
         S4vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749904476; x=1750509276;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6SywJsvbggTSjCIuisg1ArgoQy9nJ3XfLIWVK/3VWyM=;
        b=oxmw4yFhmkc9d5sNdice5ya9s6NQwyZb+RljnY+/+aRCtT00F4Q5lycrueFfs7HffK
         jbLfOlq/Lq/JyIHAJPGnt5jY5Tr4K4+uXXlSUbeMM4NvzStwjgV+o1+p/+kik5+O8IMD
         e/PtvEfQUNhbKx1JgAeIZGm0EbUNWimtzxSI1a/f0hPl5Pp2zAvNOqRZsVEcCSAPFYDK
         WMg8tI7pCENsC9PDwb4rCJMKVZQG9AdMqp0P8wSV8dwEbyWUH0A+TckwKsOTIT+bGzw8
         qvLb4s5y9306/iyoWLk2I9e5QkTQdo4He6i9WJBbR3UWBZ/f2X+gOXrOIkkRth5JXmUn
         MpCw==
X-Gm-Message-State: AOJu0YwLAmLHglMntCbUTLV3MdyqPhQ97fBNYGhebTy7iAgUxs9RQFZO
	r8Cyz/qpaeaCLVSFlnwG+88FqL8BZVZEva1Oh6iTsUwfLKBH+ABrU2kvsy4gGMbNEXJPMBGvaP0
	DzL2C
X-Gm-Gg: ASbGncu6xPekba/TQXJe6A8KV81Z6MJJoXmUqkBqfA/cdHLKWzoeQJViAWAMTDw3Ict
	iDbclYMjSFzAxSWUt+WYHMRS5eJtzLb6nUTZ9jLSgm3Sg2YDK9a6rV1GkT3ruJ63mnx0t+Dq/Sv
	AKbJnzEtoyemAbdn1wsss+37bGrWmhiq6s0XZnZ7bX9pAvTzCMjyW2dngIAHaYL9zAC9+fJKPXN
	1YggBj9cJHI0fl3Xn7qXGY+CSC+klHzcr+4G15pMoXNPfXXo8zDQwBN2HWezXPNH2f/J9uQreUs
	n8IHx8IbDuzfnfl935uYAWp/LUd3Qn4xtkBgD+aIRQqXXDlSDj7amSS1w1E=
X-Google-Smtp-Source: AGHT+IEaiPwwzPHzaWlx/J4m+J2n0HdLLTS4fB5QMCwhJAbpJP+NUrVySeiwZG7is45kNSLn4wY/ww==
X-Received: by 2002:a05:6e02:154c:b0:3d9:6485:39f0 with SMTP id e9e14a558f8ab-3de07c539d9mr32242745ab.9.1749904475953;
        Sat, 14 Jun 2025 05:34:35 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50149b9e067sm778433173.53.2025.06.14.05.34.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Jun 2025 05:34:35 -0700 (PDT)
Message-ID: <250c7955-0561-4bd1-9108-b3ff0ad236fe@kernel.dk>
Date: Sat, 14 Jun 2025 06:34:33 -0600
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
Subject: [GIT PULL] Block fixes for 6.16-rc2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

A set of fixes that should go into the 6.16-rc2 kernel release. This
pull request contains:

- Fix for a deadlock on queue freeze with zoned writes

- Fix for zoned append emulation

- Two bio folio fixes, for sparsemem and for very large folios

- Fix for a performance regression introduced in 6.13 when plug
  insertion was changed

- Fix for NVMe passthrough handling for polled IO

- Document the ublk auto registration feature

- loop lockdep warning fix

Please pull!


The following changes since commit 6f65947a1e684db28b9407ea51927ed5157caf41:

  Merge tag 'nvme-6.16-2025-06-05' of git://git.infradead.org/nvme into block-6.16 (2025-06-05 07:40:38 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.16-20250614

for you to fetch changes up to 9ce6c9875f3e995be5fd720b65835291f8a609b1:

  nvme: always punt polled uring_cmd end_io work to task_work (2025-06-13 15:18:34 -0600)

----------------------------------------------------------------
block-6.16-20250614

----------------------------------------------------------------
Bagas Sanjaya (1):
      Documentation: ublk: Separate UBLK_F_AUTO_BUF_REG fallback behavior sublists

Christoph Hellwig (1):
      block: don't use submit_bio_noacct_nocheck in blk_zone_wplug_bio_work

Damien Le Moal (1):
      block: Clear BIO_EMULATES_ZONE_APPEND flag on BIO completion

Jens Axboe (2):
      block: use plug request list tail for one-shot backmerge attempt
      nvme: always punt polled uring_cmd end_io work to task_work

Matthew Wilcox (Oracle) (2):
      bio: Fix bio_first_folio() for SPARSEMEM without VMEMMAP
      block: Fix bvec_set_folio() for very large folios

Ming Lei (2):
      loop: move lo_set_size() out of queue freeze
      ublk: document auto buffer registration(UBLK_F_AUTO_BUF_REG)

 Documentation/block/ublk.rst | 77 ++++++++++++++++++++++++++++++++++++++++++++
 block/blk-merge.c            | 26 +++++++--------
 block/blk-zoned.c            |  8 +++--
 drivers/block/loop.c         | 11 +++----
 drivers/nvme/host/ioctl.c    | 21 ++++--------
 include/linux/bio.h          |  2 +-
 include/linux/bvec.h         |  7 ++--
 7 files changed, 114 insertions(+), 38 deletions(-)

-- 
Jens Axboe

