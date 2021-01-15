Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35158C433DB
	for <linux-block@archiver.kernel.org>; Fri, 15 Jan 2021 23:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1E2023A5E
	for <linux-block@archiver.kernel.org>; Fri, 15 Jan 2021 23:45:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbhAOXpY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Jan 2021 18:45:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42849 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726607AbhAOXpY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Jan 2021 18:45:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610754237;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=sztDEIT7Qou2qZs+NWtY5/x6eSQzoXLIB+h40Dhyt4E=;
        b=JqzFYhZ1BWNkD8/R4x4XIS4LO2edcJ2L+LDXDnogbwuN0rmBDinLT+ATRt2yAON+ZKC+Gk
        2d1EoftOY5ai5JdqA1sPgkkkCav/LiGRCCoZcKeSdItWz1Ck0dZgF+1dI1qAJa6953qlHG
        WJ8XC2vG76KTYrJaVShGELhgDvUpSEE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-277-Cg_cGCfHPTuDts8OU42Vag-1; Fri, 15 Jan 2021 18:43:53 -0500
X-MC-Unique: Cg_cGCfHPTuDts8OU42Vag-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B5037E745;
        Fri, 15 Jan 2021 23:43:51 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 794DF60BF3;
        Fri, 15 Jan 2021 23:43:48 +0000 (UTC)
Date:   Fri, 15 Jan 2021 18:43:47 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Akilesh Kailash <akailash@google.com>,
        Anthony Iliopoulos <ailiop@suse.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ignat Korchagin <ignat@cloudflare.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [git pull] device mapper fixes for 5.11-rc4
Message-ID: <20210115234347.GA1931@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62:

  Linux 5.11-rc2 (2021-01-03 15:55:30 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.11/dm-fixes-1

for you to fetch changes up to c87a95dc28b1431c7e77e2c0c983cf37698089d2:

  dm crypt: defer decryption to a tasklet if interrupts disabled
  (2021-01-14 09:54:37 -0500)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix DM-raid's raid1 discard limits so discards work.

- Select missing Kconfig dependencies for DM integrity and zoned
  targets.

- 4 fixes for DM crypt target's support to optionally bypass
  kcryptd workqueues.

- Fix DM snapshot merge supports missing data flushes before
  committing metadata.

- Fix DM integrity data device flushing when external metadata is
  used.

- Fix DM integrity's maximum number of supported constructor arguments
  that user can request when creating an integrity device.

- Eliminate DM core ioctl logging noise when an ioctl is issued
  without required CAP_SYS_RAWIO permission.

----------------------------------------------------------------
Akilesh Kailash (1):
      dm snapshot: flush merged data before committing metadata

Anthony Iliopoulos (1):
      dm integrity: select CRYPTO_SKCIPHER

Arnd Bergmann (1):
      dm zoned: select CONFIG_CRC32

Ignat Korchagin (4):
      dm crypt: do not wait for backlogged crypto request completion in softirq
      dm crypt: use GFP_ATOMIC when allocating crypto requests from softirq
      dm crypt: do not call bio_endio() from the dm-crypt tasklet
      dm crypt: defer decryption to a tasklet if interrupts disabled

Mike Snitzer (2):
      dm raid: fix discard limits for raid1
      dm: eliminate potential source of excessive kernel log noise

Mikulas Patocka (2):
      dm integrity: fix flush with external metadata device
      dm integrity: fix the maximum number of arguments

 drivers/md/Kconfig        |   2 +
 drivers/md/dm-bufio.c     |   6 ++
 drivers/md/dm-crypt.c     | 170 +++++++++++++++++++++++++++++++++++++++++-----
 drivers/md/dm-integrity.c |  62 +++++++++++++----
 drivers/md/dm-raid.c      |   6 +-
 drivers/md/dm-snap.c      |  24 +++++++
 drivers/md/dm.c           |   2 +-
 include/linux/dm-bufio.h  |   1 +
 8 files changed, 239 insertions(+), 34 deletions(-)

