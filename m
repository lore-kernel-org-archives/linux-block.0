Return-Path: <SRS0=ADX+=5R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F436C43331
	for <linux-block@archiver.kernel.org>; Wed,  1 Apr 2020 16:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D84A32063A
	for <linux-block@archiver.kernel.org>; Wed,  1 Apr 2020 16:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBwUszcg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732619AbgDAQ6L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:58:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46879 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732304AbgDAQ6L (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Apr 2020 12:58:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585760290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=DV6eq2ea7jGh9ZXDOxj9KRuvur5PVyRGKVBx/V1xwX8=;
        b=VBwUszcggPtuzgHLtJ0/+btmgJuotX5BLOqf+ORH0jUZvfZWEVaFVaRs3X2WGRsVhflOIw
        5ChEYsW8sv7XFXOmNEIKQnhCE63TEQQPkhx16FiX5D4x6/HMViZKUXKwQbv4Oi1ZeP3AuF
        +nKpZDQIe7gsvi9VNenkCKygxTG8AlU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-180-wXdA5X9sMYaLNpn1XKVilw-1; Wed, 01 Apr 2020 12:58:06 -0400
X-MC-Unique: wXdA5X9sMYaLNpn1XKVilw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C2CF61259;
        Wed,  1 Apr 2020 16:57:58 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 96A035D9CA;
        Wed,  1 Apr 2020 16:57:55 +0000 (UTC)
Date:   Wed, 1 Apr 2020 12:57:54 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Bob Liu <bob.liu@oracle.com>, Erich Eckner <git@eckner.net>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        Harshini X Shetty <Harshini.X.Shetty@sony.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: [git pull] device mapper changes for 5.7
Message-ID: <20200401165628.GA22107@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit fb33c6510d5595144d585aa194d377cf74d31911:

  Linux 5.6-rc6 (2020-03-15 15:01:23 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.7/dm-changes

for you to fetch changes up to 81d5553d1288c2ec0390f02f84d71ca0f0f9f137:

  dm clone metadata: Fix return type of dm_clone_nr_of_hydrated_regions() (2020-03-27 14:42:51 -0400)

Please pull, thanks!
Mike

----------------------------------------------------------------
- Add DM writecache "cleaner" policy feature that allows cache to be
  flushed while userspace monitors for completion to then discommision
  use of caching.

- Optimize DM writecache superblock writing and also yield CPU while
  initializing writecache on large PMEM devices to avoid CPU stalls.

- Various fixes to DM integrity target while preparing for the
  ability to resize a DM integrity device.  In addition to resize
  support, add optional discard support with the "allow_discards"
  feature.

- Fix DM clone target's discard handling and overflow bugs which could
  cause data corruption.

- Fix memory leak in destructor for DM verity FEC support.

- Fix DM zoned target's redundant increment of nr_rnd_zones.

- Small cleanup in DM crypt to use crypt_integrity_aead() helper.

----------------------------------------------------------------
Bob Liu (1):
      dm zoned: remove duplicate nr_rnd_zones increase in dmz_init_zone()

Erich Eckner (1):
      dm integrity: print device name in integrity_metadata() error message

Mikulas Patocka (12):
      dm writecache: do direct write if the cache is full
      dm writecache: implement the "cleaner" policy
      dm writecache: implement gradual cleanup
      dm writecache: optimize superblock write
      dm integrity: fix a crash with unusually large tag size
      dm integrity: remove sector type casts
      dm integrity: don't replay journal data past the end of the device
      dm integrity: factor out get_provided_data_sectors()
      dm integrity: allow resize of the integrity device
      dm integrity: add optional discard support
      dm integrity: improve discard in journal mode
      dm writecache: add cond_resched to avoid CPU hangs

Nikos Tsironis (4):
      dm clone: Fix handling of partial region discards
      dm clone: Add overflow check for number of regions
      dm clone: Add missing casts to prevent overflows and data corruption
      dm clone metadata: Fix return type of dm_clone_nr_of_hydrated_regions()

Shetty, Harshini X (EXT-Sony Mobile) (1):
      dm verity fec: fix memory leak in verity_fec_dtr

Yang Yingliang (1):
      dm crypt: use crypt_integrity_aead() helper

 drivers/md/dm-clone-metadata.c |  15 +-
 drivers/md/dm-clone-metadata.h |   2 +-
 drivers/md/dm-clone-target.c   |  66 ++++++---
 drivers/md/dm-crypt.c          |   6 +-
 drivers/md/dm-integrity.c      | 304 +++++++++++++++++++++++++++++++----------
 drivers/md/dm-verity-fec.c     |   1 +
 drivers/md/dm-writecache.c     | 138 +++++++++++++++++--
 drivers/md/dm-zoned-metadata.c |   1 -
 8 files changed, 431 insertions(+), 102 deletions(-)

