Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AFD208A9
	for <linux-block@vger.kernel.org>; Fri, 10 Nov 2023 17:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="iwAhFJxx"
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3785244BCA
	for <linux-block@vger.kernel.org>; Fri, 10 Nov 2023 09:35:16 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-7a9541c9b2aso1148639f.0
        for <linux-block@vger.kernel.org>; Fri, 10 Nov 2023 09:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1699637715; x=1700242515; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FK6H9/shJFPYAh7yx0NpzY5QS+Vl84W4kxGcwUcWeXA=;
        b=iwAhFJxxahGLBdIZnrxeT1vcTPsk/XpeZ0jrgNPB2wEMIM/0Kcqt5Tfr0sy0xqVT7j
         lQ9LiBDN4Rv5IX+jiwtcXOQS64+YHPI/3c9PmGHFESTHTH5ReU0Wr8aEXfWyu0b5rFbO
         6PrQFBQg62gDQZ2nwCfhTbY65W+48FRjh2gMCNdworPqaUhtKMXsu8HiVAIJ+e+6ScEn
         zPHHPMGzjaWXRVDI644JgsI1/IcsWMHlPAXwJVOQYjm+OtU059mErR6gv8EwCxFJOJnm
         UjOfhfCByREtO9+aKQViT5JZgS18d0CqDS+2jnsBsPZ8A7W853jeoX9BqiEQ0JB1/CpY
         iuzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699637715; x=1700242515;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FK6H9/shJFPYAh7yx0NpzY5QS+Vl84W4kxGcwUcWeXA=;
        b=hZwUGRKERTn7fJ69RQAwty4GXzvh8Hn/gXgiylqGTo7+gWBWFgcqcmHw/YXvy7I9Wi
         DBje87caMzMnnxI+ipT3BDRSfbj2IkX0COvL4XNp285vs+nLRq0YZVkVgGcd+RFpX9EQ
         +7b32pJka3BxN1EYF/8cekHer2IJI7VM87fWs/ggkOGmgitkfJKnJHV0A5nF8SYEPtxu
         qpd1l6gVLaH1koTg5Lv9F9CmOYbJhqam+QW8ffXM9UxrEhNj0uoQfwFDEwF58o59VKlx
         X/0lSOfbyR2ij9lS2/G4IH8cdQGUolB0n3I37GpaTjapVRfY4iUYymEg2kmQ5UVkA/O7
         8jZw==
X-Gm-Message-State: AOJu0YzJaiGMkgpTvYkqbizIi5YewfUeGdo8WV+Vn+5mWsGr/Ty78hNP
	CS+WCKauMXIf7gKR5WvxZj2u8/3A1MNo403Mcm1TLg==
X-Google-Smtp-Source: AGHT+IE6b8zYWQjfzbPZ9YLNiIsve40Y32utPcOGrDoYP0wR1eWwHpCJOdnHPs6A5y1LZjOJXAHJQA==
X-Received: by 2002:a05:6e02:1d8d:b0:359:489e:82a with SMTP id h13-20020a056e021d8d00b00359489e082amr97324ila.1.1699637715483;
        Fri, 10 Nov 2023 09:35:15 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id bp28-20020a056e02349c00b003574ddd6cd2sm5382595ilb.74.2023.11.10.09.35.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Nov 2023 09:35:14 -0800 (PST)
Message-ID: <c57188c7-52d4-4bc4-9cd1-7d9b25faa872@kernel.dk>
Date: Fri, 10 Nov 2023 10:35:14 -0700
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
Subject: [GIT PULL] block fixes for 6.7-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus,

Some fixes for block that should go into this release:

- NVMe pull request via Keith
	- nvme keyring config compile fixes (Hannes and Arnd)
	- fabrics keep alive fixes (Hannes)
	- tcp authentication fixes (Mark)
	- io_uring_cmd error handling fix (Anuj)
	- stale firmware attribute fix (Daniel)
	- tcp memory leak (Christophe)
	- cytpo library usage simplification (Eric)

- nbd use-after-free fix. May need a followup, but at least it's better
  than what it was before (Li)

- Rate limit write on read-only device warnings (Yu)

Please pull!


The following changes since commit d2f51b3516dade79269ff45eae2a7668ae711b25:

  Merge tag 'rtc-6.7' of git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux (2023-11-05 18:49:40 -0800)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.7-2023-11-10

for you to fetch changes up to 37d9486874ec925fa298bcd7ba628a9b206e812f:

  Merge tag 'nvme-6.7-2023-11-8' of git://git.infradead.org/nvme into block-6.7 (2023-11-08 09:19:16 -0700)

----------------------------------------------------------------
block-6.7-2023-11-10

----------------------------------------------------------------
Anuj Gupta (1):
      nvme: fix error-handling for io_uring nvme-passthrough

Arnd Bergmann (1):
      nvme: common: make keyring and auth separate modules

Christophe JAILLET (1):
      nvme-tcp: Fix a memory leak

Daniel Wagner (1):
      nvme: update firmware version after commit

Eric Biggers (1):
      nvme-auth: use crypto_shash_tfm_digest()

Hannes Reinecke (4):
      nvme-tcp: avoid open-coding nvme_tcp_teardown_admin_queue()
      nvme-loop: always quiesce and cancel commands before destroying admin q
      nvme: start keep-alive after admin queue setup
      nvme: keyring: fix conditional compilation

Jens Axboe (1):
      Merge tag 'nvme-6.7-2023-11-8' of git://git.infradead.org/nvme into block-6.7

Li Lingfeng (1):
      nbd: fix uaf in nbd_open

Mark O'Donovan (3):
      nvme-auth: auth success1 msg always includes resp
      nvme-auth: add flag for bi-directional auth
      nvme-auth: always set valid seq_num in dhchap reply

Yu Kuai (1):
      blk-core: use pr_warn_ratelimited() in bio_check_ro()

 block/blk-core.c                       |  4 ++--
 drivers/block/nbd.c                    | 11 +++++++++--
 drivers/nvme/Makefile                  |  2 +-
 drivers/nvme/common/Kconfig            |  7 ++-----
 drivers/nvme/common/Makefile           |  7 ++++---
 drivers/nvme/common/auth.c             | 23 ++---------------------
 drivers/nvme/common/keyring.c          | 11 +++++++----
 drivers/nvme/host/Kconfig              |  2 --
 drivers/nvme/host/auth.c               | 13 ++++++-------
 drivers/nvme/host/core.c               | 30 ++++++++++++++++++------------
 drivers/nvme/host/fc.c                 |  6 ++++++
 drivers/nvme/host/ioctl.c              |  7 +++++--
 drivers/nvme/host/tcp.c                |  9 +++------
 drivers/nvme/target/Kconfig            |  2 --
 drivers/nvme/target/fabrics-cmd-auth.c |  2 +-
 drivers/nvme/target/loop.c             |  4 ++++
 include/linux/nvme-keyring.h           | 10 +---------
 include/linux/nvme.h                   |  2 +-
 18 files changed, 72 insertions(+), 80 deletions(-)
-- 
Jens Axboe

