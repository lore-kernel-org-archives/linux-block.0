Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8FED512
	for <linux-block@vger.kernel.org>; Fri, 14 Jun 2024 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718381441; cv=none; b=G2KWYdQTzeQsAeGm0+Dtx4NaxM3m0FNoqDLSIpoi6dkN3QeiALhWW1S2wR3K9/YrvSbclE/l78MQxhNn0lB7pWtMiWcmyvoZJq3cW4yBRux223xgMFoiYCvYtdvEjzaKmYG8xCCbhYjB9YbG7LIo3JS9IPbDwYyThzcwkTaYkKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718381441; c=relaxed/simple;
	bh=rSFC4D7aS9EiyGmAhNCTdaGRfp60cpXVRUGWnfTM4aQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=PfnOTOb/pNNFbMNpakDmi5freCPE/HZa33CmPoD7DWhssG7idVvU3ZC3xmjdfwNjAibz3jbTzsoJcYp79AklHT9V8Ma3Ji7qUdY/tS2JStO7RH6zuKOeCi+9hgxQSURTvMMByAeHAkSZoTih0qPxN1XiKmQOle9xHabOzDlubhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=bBL2YCS2; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="bBL2YCS2"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f6e4f97c1eso2110335ad.0
        for <linux-block@vger.kernel.org>; Fri, 14 Jun 2024 09:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1718381439; x=1718986239; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RsV+icbHNEvqK0sIpeuIckx16kXzfAampuuf9lD+vqc=;
        b=bBL2YCS24/mF2jDjt8s2x3/6zagc70iduBcornpqv4hCLNoW/eUKsnrSywUm9r4fMY
         2eO2zkVqak7+P4xkkkE1i2J9uiUJBg6jRpvSCjP0lrIurt1IMQO0iPNiaG6wjhpXIddE
         VxaLT2Ra3OYff0UlfNz72cGkR/GnL8LLUN2GY6z2SMMr6kfdP4S5O6j9yEeRDfaXQU+F
         wwxIhwKEgDcVm1dFkr27ZSeT7KBOLP83XMousipEMG6z5HIXyVBFPfrVOtbHSwOWevJg
         F6gBAnypegdVcgEVLTptn8BqmL2EfkzyMJ/8hidoE99c2ieUe2sSl36u6SdLtRcvenIj
         qn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718381439; x=1718986239;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RsV+icbHNEvqK0sIpeuIckx16kXzfAampuuf9lD+vqc=;
        b=QUpyyIf1xmIvl0Ae4mjqNoKxN1hKtqHuQgqsvPUXPw/f5nLYGUFqw5uEnJqly5SV5E
         1R+ikgMPPJNLqTEcnM5/+ftC6U02xbZdI1cYn6TjlQGRNBar+rAjdsJvvmnhnR1EPoBS
         pb6IinAi1+WKUmnURzAhHslE7wjc7Y4OSFAn8/mOhWczzWM0f5Ph9X4cn7nV81Wc2gFO
         6NO01tX0tYuN/I8qkh6Mi6oVB1BgD+lruh5MqrXfyOABHdD+ssFcHSL6Hv4t4SCiAuYW
         Przcepsvv0qp0TCNlmFAfbicaGOxEFIB8yAswZIQGL1pqByPy5NLXRprB68uvm//jT9H
         9sbQ==
X-Gm-Message-State: AOJu0Yz/EzCfyqMmBwZJ9qmurCRgq7iffdF7Wh3yKCNsqFnshEH5YQ37
	+9fcG7gDd57zKMAaj0mBVVe5oIHdThGKxXbDraYhLzV4/X0ObciJ+SPnT/jruM9aQCyfyf2aMX8
	W
X-Google-Smtp-Source: AGHT+IElLe7J0m419Ng0ttmVvYDqs1DmE8kWX0JsqLjyeYil55cGe1lZzNSliwFBjEVh9SwSW3XGQA==
X-Received: by 2002:a17:902:c94b:b0:1f7:346e:525e with SMTP id d9443c01a7336-1f8625bf902mr34582435ad.1.1718381439466;
        Fri, 14 Jun 2024 09:10:39 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f463f6sm33559725ad.281.2024.06.14.09.10.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 09:10:39 -0700 (PDT)
Message-ID: <2392bf6b-f048-4a80-a9b2-8703ead1fa10@kernel.dk>
Date: Fri, 14 Jun 2024 10:10:38 -0600
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
Subject: [GIT PULL] Block fixes for 6.10-rc4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Fixes for block that should go into the 6.10 kernel release:

- NVMe pull request via Keith
	- Discard double free on error conditions (Chunguang)
	- Target Fixes (Daniel)
	- Namespace detachment regression fix (Keith)

- Fix for an issue with flush requests and queuelist reuse (Chengming)

- nbd sparse annotation fixes (Christoph)

- unmap and free bio mapped data via submitter (Anuj)

- loop discard/fallocate unsupported fix (Cyril)

- Fix for the zoned write plugging added in this release (Damien)

- sed-opal wrong address fix (Su)

Please pull!


The following changes since commit 27d024235bdb16af917809d33916392452c3ac85:

  Merge tag 'nvme-6.10-2024-06-05' of git://git.infradead.org/nvme into block-6.10 (2024-06-05 12:13:00 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.10-20240614

for you to fetch changes up to 5f75e081ab5cbfbe7aca2112a802e69576ee9778:

  loop: Disable fallocate() zero and discard if not supported (2024-06-14 06:21:25 -0600)

----------------------------------------------------------------
block-6.10-20240614

----------------------------------------------------------------
Anuj Gupta (1):
      block: unmap and free user mapped integrity via submitter

Chengming Zhou (1):
      block: fix request.queuelist usage in flush

Christoph Hellwig (1):
      nbd: Remove __force casts

Chunguang Xu (1):
      nvme: avoid double free special payload

Cyril Hrubis (1):
      loop: Disable fallocate() zero and discard if not supported

Damien Le Moal (1):
      block: Optimize disk zone resource cleanup

Daniel Wagner (2):
      nvmet-passthru: propagate status from id override functions
      nvmet: always initialize cqe.result

Jens Axboe (1):
      Merge tag 'nvme-6.10-2024-06-13' of git://git.infradead.org/nvme into block-6.10

Keith Busch (1):
      nvme: fix namespace removal list

Su Hui (1):
      block: sed-opal: avoid possible wrong address reference in read_sed_opal_key()

 block/bio-integrity.c                  | 26 +++++++++++++++--
 block/blk-flush.c                      |  3 +-
 block/blk-zoned.c                      |  3 ++
 block/sed-opal.c                       |  2 +-
 drivers/block/loop.c                   | 23 +++++++++++++++
 drivers/block/nbd.c                    | 51 +++++++++++++++-------------------
 drivers/nvme/host/core.c               | 10 ++++---
 drivers/nvme/host/ioctl.c              | 15 +++++++---
 drivers/nvme/target/core.c             |  1 +
 drivers/nvme/target/fabrics-cmd-auth.c |  3 --
 drivers/nvme/target/fabrics-cmd.c      |  6 ----
 drivers/nvme/target/passthru.c         |  6 ++--
 include/linux/bio.h                    |  4 +++
 13 files changed, 100 insertions(+), 53 deletions(-)

-- 
Jens Axboe

