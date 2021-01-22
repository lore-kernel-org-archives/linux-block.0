Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EA08C433E0
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 22:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7F9323A5C
	for <linux-block@archiver.kernel.org>; Fri, 22 Jan 2021 22:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbhAVW06 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Jan 2021 17:26:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30025 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729780AbhAVW00 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Jan 2021 17:26:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611354297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=DAlXErXoYsdh4P9tEGe/fwzkeSksiKoICmLL3lZzPac=;
        b=JNCxBH6QS56B2416+G6L3VcbXFNfW8it2B3yE86Bg+yV4+Jgs3dazcQ++j4d8GZLDNykZs
        724R4wSurEdAdQT6BHAdAoNFrhx5xmQfRV4ff9LvUpK5cuCap2MjuNj3UL3sU+GRijGoPC
        UrOO1ZnqLxQmbmFLQaBUa0EBP40pj5g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-ODqThZm2PuKLnojFZrOOvA-1; Fri, 22 Jan 2021 17:24:50 -0500
X-MC-Unique: ODqThZm2PuKLnojFZrOOvA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74AA3806662;
        Fri, 22 Jan 2021 22:24:49 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 486A719C71;
        Fri, 22 Jan 2021 22:24:46 +0000 (UTC)
Date:   Fri, 22 Jan 2021 17:24:45 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Ignat Korchagin <ignat@cloudflare.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [git pull] device mapper fixes for 5.11-rc5
Message-ID: <20210122222445.GA14822@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit 19c329f6808995b142b3966301f217c831e7cf31:

  Linux 5.11-rc4 (2021-01-17 16:37:05 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.11/dm-fixes-2

for you to fetch changes up to 809b1e4945774c9ec5619a8f4e2189b7b3833c0c:

  dm: avoid filesystem lookup in dm_get_dev_t() (2021-01-21 15:06:45 -0500)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix DM integrity crash if "recalculate" used without "internal_hash"

- Fix DM integrity "recalculate" support to prevent recalculating
  checksums if we use internal_hash or journal_hash with a key
  (e.g. HMAC). Use of crypto as a means to prevent malicious
  corruption requires further changes and was never a design goal for
  dm-integrity's primary usecase of detecting accidental corruption.

- Fix a benign dm-crypt copy-and-paste bug introduced as part of a
  fix that was merged for 5.11-rc4.

- Fix DM core's dm_get_device() to avoid filesystem lookup to get
  block device (if possible).

----------------------------------------------------------------
Hannes Reinecke (1):
      dm: avoid filesystem lookup in dm_get_dev_t()

Ignat Korchagin (1):
      dm crypt: fix copy and paste bug in crypt_alloc_req_aead

Mikulas Patocka (2):
      dm integrity: fix a crash if "recalculate" used without "internal_hash"
      dm integrity: conditionally disable "recalculate" feature

 .../admin-guide/device-mapper/dm-integrity.rst     | 12 ++++++--
 drivers/md/dm-crypt.c                              |  6 ++--
 drivers/md/dm-integrity.c                          | 32 ++++++++++++++++++++--
 drivers/md/dm-table.c                              | 15 ++++++++--
 4 files changed, 54 insertions(+), 11 deletions(-)

