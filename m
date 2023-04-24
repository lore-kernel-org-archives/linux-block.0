Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B006C7618E
	for <linux-block@archiver.kernel.org>; Mon, 24 Apr 2023 17:07:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbjDXRHB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Apr 2023 13:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjDXRHA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2023 13:07:00 -0400
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 774734EE4
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 10:06:23 -0700 (PDT)
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-74e00fcdec6so247998185a.1
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 10:06:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682355982; x=1684947982;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7yklLbqlcqtrLAi6NPm1yED06AEzT2zgjyK/N8/omp4=;
        b=FjS2JPJ45PvtyKcy6zVPL389K/PimGwq9yYm5vicIdud8Ay5J3FN2kP9Cu8Bvk21Xa
         E/KDSxuYqxIUtP0/Kw6qTrHo4uB/P1U/XWL6z5pjv9V4Dh0A4QOUbYAc12lCm5SRMxmb
         0ggEvNtEBWEUhY0Hie3Zs5kcdRnFmLzHF1fHZuqHmKwFX75EjxQc1m7/sFEa7FFxNlYR
         fT+lrcAy+dPxoh8hQcWrSq6GvJLbXv+b4bKcudtutzboSKGd/dRMYu4QPxf1lIMA9dCL
         hAsoUipD7IU/U/0sYsJVQpqiCr1JJHpFKh9TMpVd2NzP+L+NGyHawQXxbp2nnUklig9v
         aEtg==
X-Gm-Message-State: AAQBX9f4BJ06fDKIB/bgmL2KfLrlTA9MTdU3qJc/oGLvE9lBDgBzwpC+
        fgUG0IonL5VpvYBi+s5iNe6n
X-Google-Smtp-Source: AKy350brVxKaGhLDydvLKmragyduatuEbwboVV80UVjcEanKSaEuXYLIfGeTGTYCa2/6OOHlbVAMkg==
X-Received: by 2002:a05:622a:44d:b0:3ef:4100:cd0c with SMTP id o13-20020a05622a044d00b003ef4100cd0cmr21666840qtx.63.1682355982319;
        Mon, 24 Apr 2023 10:06:22 -0700 (PDT)
Received: from localhost ([217.138.198.173])
        by smtp.gmail.com with ESMTPSA id k2-20020a05620a0b8200b0074a6c29df4dsm3695999qkh.119.2023.04.24.10.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 10:06:21 -0700 (PDT)
Date:   Mon, 24 Apr 2023 13:06:20 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Benjamin Marzinski <bmarzins@redhat.com>,
        Joe Thornber <ejt@redhat.com>,
        Li Lingfeng <lilingfeng3@huawei.com>,
        Michael =?iso-8859-1?Q?Wei=DF?= 
        <michael.weiss@aisec.fraunhofer.de>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Tom Rix <trix@redhat.com>, Yangtao Li <frank.li@vivo.com>,
        Yeongjin Gil <youngjin.gil@samsung.com>,
        Yu Zhe <yuzhe@nfschina.com>
Subject: [git pull] device mapper changes for 6.4
Message-ID: <ZEa3DOLC3GAX/MVx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit 666eed46769d929c3e13636134ecfc67d75ef548:

  dm: fix __send_duplicate_bios() to always allow for splitting IO (2023-03-30 15:54:32 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-6.4/dm-changes

for you to fetch changes up to 38d11da522aacaa05898c734a1cec86f1e611129:

  dm: don't lock fs when the map is NULL in process of resume (2023-04-19 11:51:37 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Split dm-bufio's rw_semaphore and rbtree. Offers improvements to
  dm-bufio's locking to allow increased concurrent IO -- particularly
  for read access for buffers already in dm-bufio's cache.

- Also split dm-bio-prison-v1's spinlock and rbtree with comparable
  aim at improving concurrent IO (for the DM thinp target).

- Both the dm-bufio and dm-bio-prison-v1 scaling of the number of
  locks and rbtrees used are managed by dm_num_hash_locks(). And the
  hash function used by both is dm_hash_locks_index().

- Allow DM targets to require DISCARD, WRITE_ZEROES and SECURE_ERASE
  to be split at the target specified boundary (in terms of
  max_discard_sectors, max_write_zeroes_sectors and
  max_secure_erase_sectors respectively).

- DM verity error handling fix for check_at_most_once on FEC.

- Update DM verity target to emit audit events on verification failure
  and more.

- DM core ->io_hints improvements needed in support of new discard
  support that is added to the DM "zero" and "error" targets.

- Fix missing kmem_cache_destroy() call in initialization error path
  of both the DM integrity and DM clone targets.

- A couple fixes for DM flakey, also add "error_reads" feature.

- Fix DM core's resume to not lock FS when the DM map is NULL;
  otherwise initial table load can race with FS mount that takes
  superblock's ->s_umount rw_semaphore.

- Various small improvements to both DM core and DM targets.
-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEJfWUX4UqZ4x1O2wixSPxCi2dA1oFAmRGtWwACgkQxSPxCi2d
A1pBqgf/W7op3/PdXBI+tlb7j05MEvMaZx0vz3l+qF36SMglaP1yZLZPiU9MCX2V
Sm2t4p7VEn5gAxvmzqa0/pLINC7u/m1IW9O6y3qdOEFAgwJ2st+/yaDqgguN5kiA
uOzecyDfR7n0WU5rkaO2EUneO7MrYweLR3IROFNFNHndl4bVJOafDcOJvmsI4YYe
5PIMHb+AGND+O2lIVOvSiPD6e85trcRWkr2X6DUYlllV3XEaBLke5MP1OAp+o/Y5
MFPfznnuiEvcFAzsBoDebC5j7RBQjHw12Bp8ltZV1ZFbdvluw9q1GD2/uyR5UolV
jmerZXKThV7lRJYqilUmt74Rxl2JSg==
=zPkM
-----END PGP SIGNATURE-----

----------------------------------------------------------------
Joe Thornber (8):
      dm bufio: remove unused dm_bufio_release_move interface
      dm bufio: add LRU abstraction
      dm bufio: add dm_buffer_cache abstraction
      dm bufio: improve concurrent IO performance
      dm bufio: add lock_history optimization for cache iterators
      dm thin: speed up cell_defer_no_holder()
      dm bio prison v1: improve concurrent IO performance
      dm: improve hash_locks sizing and hash function

Li Lingfeng (1):
      dm: don't lock fs when the map is NULL in process of resume

Michael Weiß (1):
      dm verity: emit audit events on verification failure and more

Mike Snitzer (16):
      dm bufio: use WARN_ON in dm_bufio_client_destroy and dm_bufio_exit
      dm bufio: never crash if dm_bufio_in_request()
      dm bufio: don't bug for clear developer oversight
      dm bufio: move dm_bufio_client members to avoid spanning cachelines
      dm: split discards further if target sets max_discard_granularity
      dm bio prison v1: add dm_cell_key_has_valid_range
      dm: add dm_num_hash_locks()
      dm bufio: prepare to intelligently size dm_buffer_cache's buffer_trees
      dm bufio: intelligently size dm_buffer_cache's buffer_trees
      dm bio prison v1: prepare to intelligently size dm_bio_prison's prison_regions
      dm bio prison v1: intelligently size dm_bio_prison's prison_regions
      dm clone: call kmem_cache_destroy() in dm_clone_init() error path
      dm integrity: call kmem_cache_destroy() in dm_integrity_init() error path
      dm: allow targets to require splitting WRITE_ZEROES and SECURE_ERASE
      dm: unexport dm_get_queue_limits()
      dm ioctl: fix nested locking in table_clear() to remove deadlock concern

Mikulas Patocka (8):
      dm bufio: use waitqueue_active in __free_buffer_wake
      dm bufio: use multi-page bio vector
      dm table: allow targets without devices to set ->io_hints
      dm zero: add discard support
      dm error: add discard support
      dm flakey: fix a crash with invalid table line
      dm flakey: remove trailing space in the table line
      dm flakey: add an "error_reads" option

Tom Rix (1):
      dm raid: remove unused d variable

Yangtao Li (3):
      dm: push error reporting down to dm_register_target()
      dm mirror: add DMERR message if alloc_workqueue fails
      dm: add helper macro for simple DM target module init and exit

Yeongjin Gil (1):
      dm verity: fix error handling for check_at_most_once on FEC

Yu Zhe (1):
      dm: remove unnecessary (void*) conversions

 .../admin-guide/device-mapper/dm-flakey.rst        |    4 +
 drivers/md/dm-bio-prison-v1.c                      |   94 +-
 drivers/md/dm-bio-prison-v1.h                      |   15 +
 drivers/md/dm-bufio.c                              | 1988 ++++++++++++++------
 drivers/md/dm-cache-target.c                       |    1 -
 drivers/md/dm-clone-target.c                       |    2 +-
 drivers/md/dm-crypt.c                              |   20 +-
 drivers/md/dm-delay.c                              |   26 +-
 drivers/md/dm-dust.c                               |   19 +-
 drivers/md/dm-ebs-target.c                         |   19 +-
 drivers/md/dm-era-target.c                         |   22 +-
 drivers/md/dm-flakey.c                             |   71 +-
 drivers/md/dm-integrity.c                          |   15 +-
 drivers/md/dm-io.c                                 |    4 +-
 drivers/md/dm-ioctl.c                              |   12 +-
 drivers/md/dm-kcopyd.c                             |    4 +-
 drivers/md/dm-linear.c                             |    6 +-
 drivers/md/dm-log-writes.c                         |   21 +-
 drivers/md/dm-log.c                                |   24 +-
 drivers/md/dm-mpath.c                              |    5 +-
 drivers/md/dm-raid.c                               |   22 +-
 drivers/md/dm-raid1.c                              |   24 +-
 drivers/md/dm-snap-persistent.c                    |    2 +-
 drivers/md/dm-snap.c                               |   12 +-
 drivers/md/dm-stripe.c                             |    4 +-
 drivers/md/dm-switch.c                             |   20 +-
 drivers/md/dm-table.c                              |    6 +-
 drivers/md/dm-target.c                             |   20 +-
 drivers/md/dm-thin.c                               |  125 +-
 drivers/md/dm-unstripe.c                           |   14 +-
 drivers/md/dm-verity-fec.c                         |    4 +-
 drivers/md/dm-verity-target.c                      |   42 +-
 drivers/md/dm-writecache.c                         |   22 +-
 drivers/md/dm-zero.c                               |   31 +-
 drivers/md/dm-zoned-metadata.c                     |    6 +-
 drivers/md/dm-zoned-target.c                       |   16 +-
 drivers/md/dm.c                                    |   47 +-
 drivers/md/dm.h                                    |   22 +
 include/linux/device-mapper.h                      |   40 +-
 include/linux/dm-bufio.h                           |    6 -
 include/uapi/linux/dm-ioctl.h                      |    4 +-
 41 files changed, 1777 insertions(+), 1084 deletions(-)
