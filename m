Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="D8v0d3QM"
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC3C618B
	for <linux-block@vger.kernel.org>; Thu, 23 Nov 2023 11:54:35 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cf876eab03so2491525ad.0
        for <linux-block@vger.kernel.org>; Thu, 23 Nov 2023 11:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1700769275; x=1701374075; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2+UrJ5L4FGzkh9gcWGq4Fn7Csiw9PuwxzJSs3tcPR9k=;
        b=D8v0d3QMZlKE6rlgyrHzcimZsiP2qxTrS0g99IF5t+hqfnhARpJrFRHoi8s8r9bxg9
         R7KSwsEqs35ytyLNLxcTsFAeIwgMAdoZQbFb5xxxLBTvfN/MEubApigy3SKwrlddwN6h
         QZUOmkz1bVylJA/pPGp31G5kf5Q5338PjVIScPfxVZfirxlTK3JmoQ4fDe29l2wPYPnZ
         CRXUOYnu3UK/QJ1zFMyKgaXESIec/DVHXdF7yMzVV9p0EPnS3KXTX1uQmkHUBWMrikvt
         jOV7bbSVid068UUhCAvYL2TgVqB7+wIfi/qxG4VQ4UPNwETHE8Jq1xEpQNzmJVcjMqAy
         X8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700769275; x=1701374075;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2+UrJ5L4FGzkh9gcWGq4Fn7Csiw9PuwxzJSs3tcPR9k=;
        b=c5emknAKxr3nGqU7poPl22kz5gdxj4KQwCICMrirS6q7JXU7BpKUo1Ag/R6V3sP7lo
         IqGzKyUvGLrMESufu+4uO5i7hFiha2pqhgmoG4LAP6plOplUKkrWrMn6YAYW1LhO6YR2
         ar28G/yxhHRtutbM98DeEXOjpl3EWJGQukEqNawJ8FMXBysXaqowXKeK+rAM94S/DacS
         WfLkpcnPEyb+A/1cDQc1Cph7twigDY5leQEgGTZdPvvqFMLVPrlmzbjOHkfD7K+uMf3u
         AFGI4YLTDNkkX/g7myy0fpsDTuEyHA3q7TTAQQd9kvumER93Xby94rv3wx6lpwk9VdW9
         4G5Q==
X-Gm-Message-State: AOJu0YxkuD76KOrtGlYZHfC1rhOHWS3QSmNIBURfU4HquibctH/5srNF
	gn/h1UiW6ZRUKk3e5g5EjrjjIufEZ7goYm1lUhyyvg==
X-Google-Smtp-Source: AGHT+IHed0yz5FaK5xG13dfWUBgMK0tEcPdI8733vHO3Uq4AkgEyIka00fgSbRDyr7NMcnK8j48tVA==
X-Received: by 2002:a17:902:9f96:b0:1cc:27fa:1fb7 with SMTP id g22-20020a1709029f9600b001cc27fa1fb7mr471533plq.5.1700769275121;
        Thu, 23 Nov 2023 11:54:35 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.194])
        by smtp.gmail.com with ESMTPSA id 2-20020a170902c14200b001c755810f89sm1714017plj.181.2023.11.23.11.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 11:54:34 -0800 (PST)
Message-ID: <78b52c5b-91f5-4c1b-b89c-c942e880ac4d@kernel.dk>
Date: Thu, 23 Nov 2023 12:54:33 -0700
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
Subject: [GIT PULL] Block fixes for 6.7-rc3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

A bit bigger than usual at this time, but nothing really earth
shattering in this pull request.

- NVMe pull request via Keith
	- TCP TLS fixes (Hannes)
	- Authentifaction fixes (Mark, Hannes)
	- Properly terminate target names (Christoph)

- MD pull request via Song, fixing a raid5 corruption issue

- Disentanglement of the dependency mess in nvme introduced with the tls
  additions. Now it should actually build on all configs (Arnd)

- Series of bcache fixes (Coly)

- Removal of a dead helper (Damien)

- s390 dasd fix (Muhammad, Jan)

- lockdep blk-cgroup fixes (Ming)

Please pull!


The following changes since commit b0077e269f6c152e807fdac90b58caf012cdbaab:

  blk-mq: make sure active queue usage is held for bio_integrity_prep() (2023-11-13 08:52:52 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/block-6.7-2023-11-23

for you to fetch changes up to 0e6c4fe782e683ff55a27fbb10e9c6b5c241533b:

  nvme: tcp: fix compile-time checks for TLS mode (2023-11-22 18:41:14 -0700)

----------------------------------------------------------------
block-6.7-2023-11-23

----------------------------------------------------------------
Arnd Bergmann (3):
      nvme: target: fix nvme_keyring_id() references
      nvme: target: fix Kconfig select statements
      nvme: tcp: fix compile-time checks for TLS mode

Chengming Zhou (1):
      block/null_blk: Fix double blk_mq_start_request() warning

Christoph Hellwig (1):
      nvmet: nul-terminate the NQNs passed in the connect command

Colin Ian King (1):
      bcache: remove redundant assignment to variable cur_idx

Coly Li (5):
      bcache: avoid oversize memory allocation by small stripe_size
      bcache: check return value from btree_node_alloc_replacement()
      bcache: replace a mistaken IS_ERR() by IS_ERR_OR_NULL() in btree_gc_coalesce()
      bcache: add code comments for bch_btree_node_get() and __bch_btree_node_alloc()
      bcache: avoid NULL checking to c->root in run_cache_set()

Damien Le Moal (1):
      block: Remove blk_set_runtime_active()

Hannes Reinecke (5):
      nvme-tcp: only evaluate 'tls' option if TLS is selected
      nvme: catch errors from nvme_configure_metadata()
      nvme: blank out authentication fabrics options if not configured
      nvmet-tcp: always initialize tls_handshake_tmo_work
      nvme: move nvme_stop_keep_alive() back to original position

Jan Höppner (1):
      s390/dasd: protect device queue against concurrent access

Jens Axboe (2):
      Merge tag 'md-fixes-20231120' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-6.7
      Merge tag 'nvme-6.7-2023-11-22' of git://git.infradead.org/nvme into block-6.7

Li Nan (4):
      nbd: fold nbd config initialization into nbd_alloc_config()
      nbd: factor out a helper to get nbd_config without holding 'config_lock'
      nbd: fix null-ptr-dereference while accessing 'nbd->config'
      nbd: pass nbd_sock to nbd_read_reply() instead of index

Mark O'Donovan (2):
      nvme-auth: unlock mutex in one place only
      nvme-auth: set explanation code for failure2 msgs

Ming Lei (3):
      blk-throttle: fix lockdep warning of "cgroup_mutex or RCU read lock required!"
      blk-cgroup: avoid to warn !rcu_read_lock_held() in blkg_lookup()
      blk-cgroup: bypass blkcg_deactivate_policy after destroying

Mingzhe Zou (3):
      bcache: fixup init dirty data errors
      bcache: fixup lock c->root error
      bcache: fixup multi-threaded bch_sectors_dirty_init() wake-up race

Muhammad Muzammil (1):
      s390/dasd: resolve spelling mistake

Rand Deeb (1):
      bcache: prevent potential division by zero error

Song Liu (1):
      md: fix bi_status reporting in md_end_clone_io

 block/blk-cgroup.c                |  13 +++++
 block/blk-cgroup.h                |   2 -
 block/blk-pm.c                    |  33 ++---------
 block/blk-throttle.c              |   2 +
 drivers/block/nbd.c               | 117 ++++++++++++++++++++++++--------------
 drivers/block/null_blk/main.c     |  25 ++++----
 drivers/md/bcache/bcache.h        |   1 +
 drivers/md/bcache/btree.c         |  11 +++-
 drivers/md/bcache/super.c         |   4 +-
 drivers/md/bcache/sysfs.c         |   2 +-
 drivers/md/bcache/writeback.c     |  24 ++++++--
 drivers/md/md.c                   |   3 +-
 drivers/nvme/host/auth.c          |   5 +-
 drivers/nvme/host/core.c          |  21 ++++---
 drivers/nvme/host/fabrics.c       |   2 +
 drivers/nvme/host/fc.c            |  19 +++----
 drivers/nvme/host/rdma.c          |   1 +
 drivers/nvme/host/tcp.c           |  32 +++++------
 drivers/nvme/target/Kconfig       |   4 +-
 drivers/nvme/target/configfs.c    |   2 +-
 drivers/nvme/target/fabrics-cmd.c |   4 ++
 drivers/nvme/target/tcp.c         |   4 +-
 drivers/s390/block/dasd.c         |  24 ++++----
 drivers/s390/block/dasd_int.h     |   2 +-
 include/linux/blk-pm.h            |   1 -
 25 files changed, 210 insertions(+), 148 deletions(-)

-- 
Jens Axboe

