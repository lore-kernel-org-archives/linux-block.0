Return-Path: <SRS0=29BZ=6O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E95C47247
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 22:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 403E52074A
	for <linux-block@archiver.kernel.org>; Thu, 30 Apr 2020 22:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UyxCQW6z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgD3WHo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Apr 2020 18:07:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34001 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727058AbgD3WHo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Apr 2020 18:07:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588284463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=dlZEfhEIl8DTbcuWQbNOzSJ2+cSVmGQTcZLVtWMFI2A=;
        b=UyxCQW6zY5ESXqVJ1BkcmNDZP6k+Hlm1iYqxQSJQvkTjCtVYnAfe+hhiT7FnOD0IFoKb6s
        oHh0QZPxmk6ioFGMdHTkaLlVqCBHMaF0vzgupem9pisTqfwzmoPV4c4ZZJL5HQPJEp6vPd
        RFmA3jdZPOOFenHutKDHXAwfdFyAqHU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-Uu_2ari7NHa9uS1hrDHySw-1; Thu, 30 Apr 2020 18:07:41 -0400
X-MC-Unique: Uu_2ari7NHa9uS1hrDHySw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAEBC835B40;
        Thu, 30 Apr 2020 22:07:39 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E201E5D777;
        Thu, 30 Apr 2020 22:07:36 +0000 (UTC)
Date:   Thu, 30 Apr 2020 18:07:36 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Milan Broz <gmazyland@gmail.com>,
        Sunwook Eom <speed.eom@samsung.com>
Subject: [git pull] device mapper fixes for 5.7-rc4
Message-ID: <20200430220735.GA30584@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit 8267d8fb4819afa76b2a54dca48efdda6f0b1910:

  dm integrity: fix logic bug in integrity tag testing (2020-04-03 13:07:41 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.7/dm-fixes-2

for you to fetch changes up to 5686dee34dbfe0238c0274e0454fa0174ac0a57a:

  dm multipath: use updated MPATHF_QUEUE_IO on mapping for bio-based mpath (2020-04-28 19:51:46 -0400)

Please pull, thanks!
Mike

----------------------------------------------------------------
- Document DM integrity allow_discard feature that was added during
  5.7 merge window.

- Fix potential for DM writecache data corruption during DM table
  reloads.

- Fix DM verity's FEC support's hash block number calculation in
  verity_fec_decode().

- Fix bio-based DM multipath crash due to use of stale copy of
  MPATHF_QUEUE_IO flag state in __map_bio().

----------------------------------------------------------------
Gabriel Krisman Bertazi (1):
      dm multipath: use updated MPATHF_QUEUE_IO on mapping for bio-based mpath

Mikulas Patocka (1):
      dm writecache: fix data corruption when reloading the target

Milan Broz (1):
      dm integrity: document allow_discard option

Sunwook Eom (1):
      dm verity fec: fix hash block number in verity_fec_decode

 .../admin-guide/device-mapper/dm-integrity.rst     | 15 ++++---
 drivers/md/dm-mpath.c                              |  6 ++-
 drivers/md/dm-verity-fec.c                         |  2 +-
 drivers/md/dm-writecache.c                         | 52 +++++++++++++++-------
 4 files changed, 51 insertions(+), 24 deletions(-)

