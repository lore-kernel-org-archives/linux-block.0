Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AC51C862C
	for <linux-block@vger.kernel.org>; Fri, 18 Jul 2025 16:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752857741; cv=none; b=Pqa4JgzhG+nR7ZAaA66S4M/lfrWZ5IgEq4ro7nerQW0FN9W3AXs1JwnlYMR1qj/95LxYVzHU2PrN4ReDUSXMnYSwT2PrrRHcDhXl5Sr/MN0l7SDn9+IXzdHHKOtzQcO/jO9NleGTXztls655J332IsK6XTSvONwZxYVeC6rirpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752857741; c=relaxed/simple;
	bh=xB92aoVRLNGCxtzT1lOuWPRc8zXYoECWUAdkEf3ZoUo=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=lwSdfS+7jv0ZDxaKCYkB56Md6WvCdrOYExTDpGzIRXN9CKBD/iV6J55n0S9Z6ykpDfcrusBzTPZAHmxrsVY9IwruZNE/L5M5nmM0ZYo9BSzN8/s3XkXFdqABFKTH9getx9jCS5JoFEePkyfcJF+5/2GBqGlqmxBviLK36qcRTeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=0LqlZ+jG; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="0LqlZ+jG"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-74b56b1d301so1682845b3a.1
        for <linux-block@vger.kernel.org>; Fri, 18 Jul 2025 09:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1752857738; x=1753462538; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYGdSi1wF9Spg1hLyFNHzVFHU03XZvkGlrjLFkz7QsI=;
        b=0LqlZ+jGJjhJfZguHQIzQo8TIBQasMN0rCY3Q8zpyns8uZ9EtkkMxgHgCZ5DBeQick
         8eSRwiJ3mpH0rel1kljNATVakHsXbzC9PDDcvs2tjTSeI4dds3FeRCr4n/gE6xc+UL1a
         MN2bp7P/54lVfronDCrHkQUxQOzzwnwp0EWi0gN4ekUuGpTJRn7eeHHWJGmzwPvM+Ibg
         PY9sqS6CWPXPBXfzAQJHDZcaNtJS6N9o8c4WfzMV7gxhT4KBJgIV/AVCRE9BKRk2Yo/i
         /Sc2WrSiIiovdALx5pCc2NPf1pbKPDQqOWuskuDoai59jef2do3SZtK1rqEA+CxGESB3
         138g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752857738; x=1753462538;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KYGdSi1wF9Spg1hLyFNHzVFHU03XZvkGlrjLFkz7QsI=;
        b=YfUfKxb7qoXFWhgYRJx3cYHvnZBsKbGSqJdzqq6sn+OraFabNH0V+iAfdMy9sAXGQZ
         RJuemJ57XvUQQRc8TKK3kkOB1lXJZaOjrE1O/21piUqaDNmUxEMj++tg2xnfji0sLo3J
         LwAdVcvNnSWcBwb4fRjZzZ0LAjYXfkprgr8Z0cHm5+R/JIj+WZ5d+lwWPEbjcDNs6qjN
         s0jNn2FOu9BsvDBJDbdmmLlYCksZBu7DDOe+FOk8Qyjb2jho7UXbpsJBunTUxtPvt8vv
         KF7iWbjaBVyyiNnre2DkK3Fqb7cIMIp1P+ZiNDzRpSGuOt62h6XNc05CzQMq0zHUebnD
         /Dlw==
X-Gm-Message-State: AOJu0Yx8uuDlN03uifyBsgdfP5mj2UIugtv9ic7gxRfheAOtSI87GZ5v
	adcKg9hhHnro0kGnq7ZkHjcbjzOIM/TzkruwU3+9LcXmBHC0Ty9ZyxshyXp8bRl8IbOC6LIhZWY
	u9HDe
X-Gm-Gg: ASbGncsfXMwEvrmAuAxfy3eUO3ctyoOCvIjN1uTbbTezFJSGTrzSdDZfFFN7ZA1IF0U
	81mYOgB0A7HhQsBvSN92oArwdz1+CATrRj6bQBg3yhsh62PWThz7d0KKb7XzoYfPvntIVwQj3Wr
	4BDMS6zIDjvGnCj2Dn2s/jXxNLLOgtU4UXVIbFX8GPzcPPJYMZKPSYzTCFE1p4k0qzYmGZcqMT0
	PeNKI6fkztX5ZMsQH7jdp+pLCCaA/gY5aB4nUxK7qAghYyUfr6JTJYAQ00B5KNF9PiC5k3tpngX
	KgkYdHK2ZNmfQ2sbXAy1oF+/HpcjVCI74o7VMPYrPnwZvIanMXYS8H6RU7Em9EH/FeVUx6HgTxi
	Jk2kjFmKViu4NRcBU0aD6pYJz7ZrcRnJqsvqsLBw84Tpk/ajkFtrTDx+eFQS1kLyx7Tw=
X-Google-Smtp-Source: AGHT+IG7EeSbuzfX/m+yzaEf4j6tePQ30nm4KctKQgB0cErIZVZxSrPmwWCCNhBUyrBiMfquy4jRbA==
X-Received: by 2002:a05:6a00:2350:b0:742:a91d:b2f6 with SMTP id d2e1a72fcca58-7572466bc03mr15554133b3a.13.1752857737406;
        Fri, 18 Jul 2025 09:55:37 -0700 (PDT)
Received: from [172.20.8.9] (syn-071-095-160-189.biz.spectrum.com. [71.95.160.189])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb67900fsm1541314b3a.101.2025.07.18.09.55.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 09:55:36 -0700 (PDT)
Message-ID: <effd0d40-999f-4590-a10b-4422daf91662@kernel.dk>
Date: Fri, 18 Jul 2025 10:55:35 -0600
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
Subject: [GIT PULL] Block fixes for 6.16-rc7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Set of fixes for block for the 6.16 kernel release. This pull request
contains:

- NVMe changes via Christoph
	- revert the cross-controller atomic write size validation that
	  caused regressions (Christoph Hellwig)
	- fix endianness of command word prints in
	  nvme_log_err_passthru() (John Garry)
	- fix callback lock for TLS handshake (Maurizio Lombardi)
	- fix misaccounting of nvme-mpath inflight I/O (Yu Kuai)
	- fix inconsistent RCU list manipulation in
	  nvme_ns_add_to_ctrl_list() (Zheng Qixing)

- Fix for a kobject leak in queue unregistration

- Fix for loop async file write start/end handling

Please pull!


The following changes since commit 4cdf1bdd45ac78a088773722f009883af30ad318:

  block: reject bs > ps block devices when THP is disabled (2025-07-07 11:58:57 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.16-20250718

for you to fetch changes up to 2680efde75ccdd745da7ae6f5e30026f70439588:

  Merge tag 'nvme-6.16-2025-07-17' of git://git.infradead.org/nvme into block-6.16 (2025-07-17 05:56:12 -0600)

----------------------------------------------------------------
block-6.16-20250718

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme: revert the cross-controller atomic write size validation

Jens Axboe (1):
      Merge tag 'nvme-6.16-2025-07-17' of git://git.infradead.org/nvme into block-6.16

John Garry (1):
      nvme: fix endianness of command word prints in nvme_log_err_passthru()

Maurizio Lombardi (1):
      nvmet-tcp: fix callback lock for TLS handshake

Ming Lei (2):
      block: fix kobject leak in blk_unregister_queue
      loop: use kiocb helpers to fix lockdep warning

Yu Kuai (1):
      nvme: fix misaccounting of nvme-mpath inflight I/O

Zheng Qixing (1):
      nvme: fix inconsistent RCU list manipulation in nvme_ns_add_to_ctrl_list()

 block/blk-sysfs.c         |  1 +
 drivers/block/loop.c      |  5 ++---
 drivers/nvme/host/core.c  | 27 +++++++++++----------------
 drivers/nvme/target/tcp.c |  4 ++--
 4 files changed, 16 insertions(+), 21 deletions(-)

-- 
Jens Axboe

