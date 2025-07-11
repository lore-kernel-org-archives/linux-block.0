Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D851A2632
	for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 13:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752241679; cv=none; b=e6nZkny6hX0Z4FqHVSVqAPkVIcA62y5Rx3NsltAzeowQbjp1C2e7C4nBYpLUNp4Jq4nltXmoECs4vfvn+gpXRmxldXJa1rtuMop4WvQ/rFXNevEogqdbxLyGWhGkR1c96S5qqQQZaEBhDpaaHqmAqZLwNnVKgrtjt52szZjF294=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752241679; c=relaxed/simple;
	bh=5u84HIHhuESrOGWvWQVTuBH5D+Lshweo14BDzlTjphE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=E+UXSchFLKltVn45CvnmLebAyXt4LSJYIMYaKJVeHJlE3j33n592ZmakIurJg4Tm6CHISRZw7oCnencA234hEa7xvZ6X/W9Afj7BcLVswZz35kwQT5Hc3jZhfFIoSIyaTC2igGYjLtW+qy2dMFViRuf6Fsz9cDvbDDj+Yue9Kds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rkkfNAHC; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rkkfNAHC"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3df2d8cb8d2so7160825ab.2
        for <linux-block@vger.kernel.org>; Fri, 11 Jul 2025 06:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752241677; x=1752846477; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=maVnG3kN4js766vih4nVNg644PO78+2HpNmHimxFz/E=;
        b=rkkfNAHCG9/5BEMr3+MlAtM1ip0Sg1GoNpDmY7hJyCie6hM/dkJLh9SpISK3Mokh5p
         VhVN37HPBRxl99Rd2s23ffUd/nD3VrRq3pKzcfldnDk6rHLTZm1fLOBIAeyIGFHhAP0O
         zSMGUpmGk0o2KKA2JatcUI/vuGDCisKg4xiFpp0nz0JcP77/dVj0G076bpidoQxcDyAt
         kMcpv8xPqNAHYcAsuGJuPuKmJsa2Y+xBslUaI4crZUdCGj53ixDTL90BhXRMTi6J1YxF
         t9sNCFVpuohYWSQAeM4/ljovyVFsiZ/k4Cxk244wRPwJlxOoefEaCbarRLQ/Jjr7lNRb
         TfBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752241677; x=1752846477;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=maVnG3kN4js766vih4nVNg644PO78+2HpNmHimxFz/E=;
        b=tISxM1mKscuSBX5AA9TRtFQCfQ/Ry3i3ONMWQvhx2QQy4J0oxzmt3e1vtgQyrDx6Gk
         K+/QM88u9W2SzEW1jPbZMZ2kppuLv2E7bLqFPDSa6h1SvqeG7RQEc/iNMiiWteUt5dTW
         0j5/bk/avAzo2Ae5J4osrJotqC1nJ3ysjdnDqfsvPQgSTG2TXjMexB/wq9fbYsSFtGo0
         E8QwH3Yx/LEmpZp1JGQu881SJQLawN0znIzkU9N+qLeW7HxZzHMLiDzWCJ0W/eohwkyr
         BQzzA1g78LqRd+uMPZdiW9uKelf/P4q67QnBvuH/R0znUI+XecP06i4RMiT0QT2NmGt5
         XkXQ==
X-Gm-Message-State: AOJu0YxztUVxPSfYgxsgu4xkI3mCFV7yVk7Cpzt7WKjK4tNRd0tRwQzM
	/7tg/wS0/JtJqbZjE8J4bJ3r9+CcBBY9dgS9cCTUF+OYdLwf0hcnLKk2Qr6xlITV0J+V93U2jmG
	CsR+a
X-Gm-Gg: ASbGnctF6vg13w3G40Uj2tPw8gZ3R1Tr4Jqo0YfdfLHFbMqhm7kAIG57t7ZqHhirIlw
	Q67WRpHoqjrrs7bMLABkPCjs6T6eyuylFofhgqAAngfIumS/oRLymXv+1h16ktqtU668R7KnyA5
	KouZYBc1sT2xioxKsV1aAQylVvuy5UD4fjqVafZ8X+XZZgoShSKKXo6awUlZ4vOUrQc4DP8vXd4
	Wi4sM0O1+xzhaZ56elX6vNw05ri9zT+MOggwcZe5UtKj5FmP+C7N5MP8pVwsMZjFyxtYToHsagz
	eO+zWlJYrsADJaEzzmP2nWWrfq2c/cuzhJ2Nwc01LOmTJrh48xY+L6yp4LF4styqcfcrjgy9EWS
	x719kBxagb4b350yVS/s=
X-Google-Smtp-Source: AGHT+IEmNP9NG69PY/gfLv/V8u2kxOgdYKBNpC7F0CTiibc/m0S0ce+ki+afjWqcHYFLMEMpt2R//A==
X-Received: by 2002:a05:6e02:b2d:b0:3df:4eb6:d04e with SMTP id e9e14a558f8ab-3e253342979mr39570005ab.22.1752241676544;
        Fri, 11 Jul 2025 06:47:56 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e24628b574sm12033625ab.71.2025.07.11.06.47.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 06:47:56 -0700 (PDT)
Message-ID: <623d3918-3595-42ce-8d47-6d232a94a277@kernel.dk>
Date: Fri, 11 Jul 2025 07:47:55 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 6.16-rc6
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

Set of fixes for block for the 6.16 kernel release. This pull request
contains:

- MD changes via Yu
	- fix uaf due to stack memory used for bio mempool, from Jinchao
	- fix raid10/raid1 nowait IO error path, from Nigel and Qixing
	- fix kernel crash from reading bitmap sysfs entry, by Håkon

- Fix for a UAF in the nbd connect error path

- Fix for blocksize being bigger than pagesize, if THP isn't enabled

Please pull!


The following changes since commit 75ef7b8d44c30a76cfbe42dde9413d43055a00a7:

  Merge tag 'nvme-6.16-2025-07-03' of git://git.infradead.org/nvme into block-6.16 (2025-07-03 09:42:07 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.16-20250710

for you to fetch changes up to 4cdf1bdd45ac78a088773722f009883af30ad318:

  block: reject bs > ps block devices when THP is disabled (2025-07-07 11:58:57 -0600)

----------------------------------------------------------------
block-6.16-20250710

----------------------------------------------------------------
Håkon Bugge (1):
      md/md-bitmap: fix GPF in bitmap_get_stats()

Jens Axboe (1):
      Merge tag 'md-6.16-20250705' of gitolite.kernel.org:pub/scm/linux/kernel/git/mdraid/linux into block-6.16

Nigel Croxon (1):
      raid10: cleanup memleak at raid10_make_request

Pankaj Raghav (1):
      block: reject bs > ps block devices when THP is disabled

Wang Jinchao (1):
      md/raid1: Fix stack memory use after return in raid1_reshape

Zheng Qixing (2):
      md/raid1,raid10: strip REQ_NOWAIT from member bios
      nbd: fix uaf in nbd_genl_connect() error path

 drivers/block/nbd.c    |  6 +++---
 drivers/md/md-bitmap.c |  3 +--
 drivers/md/raid1.c     |  4 +++-
 drivers/md/raid10.c    | 12 ++++++++++--
 include/linux/blkdev.h |  5 +++++
 5 files changed, 22 insertions(+), 8 deletions(-)

-- 
Jens Axboe

