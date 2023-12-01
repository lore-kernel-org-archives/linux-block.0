Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="m1MoYpTX"
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DC8D63
	for <linux-block@vger.kernel.org>; Fri,  1 Dec 2023 10:56:50 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7b359dad0e7so30075439f.0
        for <linux-block@vger.kernel.org>; Fri, 01 Dec 2023 10:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701457009; x=1702061809; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RaPpNI3dJ5XgBvFA0xtopHr0eNG68QWMEeY5q0YqXyU=;
        b=m1MoYpTXZUTwZVA5VZIngj2PqLLq+JncVh87yeFitMGnAfkB3Qf5gdF5xtWXPcsQ0Y
         IgFIe2FTZOVrr3CGKpu3TnFqnM/3y8R/4MdwRMOJ1zfDUORF1iTTXVzM6gvda8b5Mp+S
         Hg/8Hw/gntf/TT40A60Gj7Ic3MdML3moTWWdsrhjiQO1tcDcpPai9eKAjvUkrwV8axki
         M1pUHNrRLf3d+aVLpFrT66uKemmn0AdR9cdfUWOPy1XwpXi4zcRWCpmNmM2ZtiuTl5da
         KScDp6XiBRfFacYkNKd2D7s5IjFQj2/a8jq992HVDc5SyGEXMTMzafvmo4f6233oEPdq
         4Hhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701457009; x=1702061809;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RaPpNI3dJ5XgBvFA0xtopHr0eNG68QWMEeY5q0YqXyU=;
        b=QiEE59Gw+MYlEZNLEGKXEB3lw5ZuMuNCkCeHippBS/3KGvG22siT8kCLrb55GZdy6M
         y4TKjeOO7Li4erl8Rw6eM+ZOwuQEOZnd+7nIBOBaDgFc5nOh45MZ+hf9JCFAZd1PXgGS
         a7lWn0fbrdXQOgWqTHUI1csbVu4pLLR1B0VDHISxOuecNaybcvQjBYL6+kJOemHmiLc5
         8BIEKwKSsOV+jJ9I7FpEu7YV3Jg5kAfV02MMTioGyUnQy+1oJ3fGjYi9waBxAVgGQPC0
         jOJ85kWnDK5jkqrIU8eZWmeTu0wR4+sw+WCdbB9USSfV56zEqzjp1UXCj/kmAJUK3cln
         AxyQ==
X-Gm-Message-State: AOJu0YwVuO+qPC13waQyV8wLXOBctojblPrLLk2iFln3EqFMlsdE/qMS
	2TT4ISVepu24PQ3W/ngQhW7Ekd8MWn2/QfqaM0MIXA==
X-Google-Smtp-Source: AGHT+IGP+A3otgrOeDepvc8GTF53NOylXDwDRTdij8Gzf3KWaZ7ZOCwfFucUGe9r478vsIpAYgm20Q==
X-Received: by 2002:a05:6602:1309:b0:7b4:284d:c8db with SMTP id h9-20020a056602130900b007b4284dc8dbmr150580iov.2.1701457009678;
        Fri, 01 Dec 2023 10:56:49 -0800 (PST)
Received: from [172.19.0.197] ([99.196.131.174])
        by smtp.gmail.com with ESMTPSA id gs26-20020a0566382d9a00b0042b37dda71asm1015204jab.136.2023.12.01.10.56.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 10:56:49 -0800 (PST)
Message-ID: <201079c4-7084-4d94-bbde-7e3c536b801c@kernel.dk>
Date: Fri, 1 Dec 2023 11:56:46 -0700
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
Subject: [GIT PULL] Block fixes for 6.7-rc4
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Set of fixes for block that should go into the 6.7 release:

- NVMe pull request via Keith
	- Invalid namespace identification error handling
	  (Marizio Ewan, Keith)
	- Fabrics keep-alive tuning (Mark)

- Fix for a bad error check regression in bcache (Markus)

- Fix for a performance regression with O_DIRECT (Ming)

- Fix for a flush related deadlock (Ming)

- Make the read-only warn on per-partition (Yu)

Please pull!


The following changes since commit 0e6c4fe782e683ff55a27fbb10e9c6b5c241533b:

  nvme: tcp: fix compile-time checks for TLS mode (2023-11-22 18:41:14 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.7-2023-12-01

for you to fetch changes up to 8ad3ac92f0760fdd8537857ee1adfde849ab0268:

  Merge tag 'nvme-6.7-2023-12-01' of git://git.infradead.org/nvme into block-6.7 (2023-12-01 09:09:16 -0700)

----------------------------------------------------------------
block-6.7-2023-12-01

----------------------------------------------------------------
Bart Van Assche (1):
      block: Document the role of the two attribute groups

Ewan D. Milne (1):
      nvme: check for valid nvme_identify_ns() before using it

Jens Axboe (1):
      Merge tag 'nvme-6.7-2023-12-01' of git://git.infradead.org/nvme into block-6.7

Keith Busch (1):
      nvme-core: check for too small lba shift

Mark O'Donovan (1):
      nvme: fine-tune sending of first keep-alive

Markus Weippert (1):
      bcache: revert replacing IS_ERR_OR_NULL with IS_ERR

Maurizio Lombardi (1):
      nvme-core: fix a memory leak in nvme_ns_info_from_identify()

Ming Lei (2):
      block: move .bd_inode into 1st cacheline of block_device
      blk-mq: don't count completed flush data request as inflight in case of quiesce

Yu Kuai (1):
      block: warn once for each partition in bio_check_ro()

 block/blk-core.c          | 14 +++++++++++---
 block/blk-mq.c            | 14 +++++++++++++-
 block/blk-sysfs.c         |  2 ++
 drivers/md/bcache/btree.c |  2 +-
 drivers/nvme/host/core.c  | 34 ++++++++++++++++++++++++++++------
 include/linux/blk_types.h |  4 +++-
 6 files changed, 58 insertions(+), 12 deletions(-)

-- 
Jens Axboe

