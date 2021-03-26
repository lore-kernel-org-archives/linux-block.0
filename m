Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F2E6C433C1
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 19:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D562C61A18
	for <linux-block@archiver.kernel.org>; Fri, 26 Mar 2021 19:20:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbhCZTUY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Mar 2021 15:20:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46163 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230447AbhCZTUD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Mar 2021 15:20:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616786402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Z81Ypc23TuFtZGYioa+2yM1EqVsFThHSAdxN7dRDHCo=;
        b=FkXVpcHze7aoEFOCQE0AUAYgzeiYJBdfenPnLspgsyjOExCNwSd7CnmzJn+dhdYkIhyZUW
        NOU+n2QRP2tdurXTr1HTYFcKb3+DpaMxVnixnvKzV0xGB0kJQRzkfApNtiFHh1OlfafO+b
        YX2wNR19OoJHy/8blQOGm1E+o/C2ciU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-173-T_81PrasO1uwo0K_VJrFDg-1; Fri, 26 Mar 2021 15:19:57 -0400
X-MC-Unique: T_81PrasO1uwo0K_VJrFDg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D95C839A42;
        Fri, 26 Mar 2021 19:19:56 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CC2ED6062F;
        Fri, 26 Mar 2021 19:19:52 +0000 (UTC)
Date:   Fri, 26 Mar 2021 15:19:50 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        JeongHyeon Lee <jhs2.lee@samsung.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [git pull] device mapper fixes for 5.12-rc5
Message-ID: <20210326191949.GA24195@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit 0d02ec6b3136c73c09e7859f0d0e4e2c4c07b49b:

  Linux 5.12-rc4 (2021-03-21 14:56:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.12/dm-fixes-2

for you to fetch changes up to 4edbe1d7bcffcd6269f3b5eb63f710393ff2ec7a:

  dm ioctl: fix out of bounds array access when no devices (2021-03-26 14:51:50 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix DM verity target's optional argument processing.

- Fix DM core's zoned model and zone sectors checks.

- Fix spurious "detected capacity change" pr_info() when creating new
  DM device.

- Fix DM ioctl out of bounds array access in handling of
  DM_LIST_DEVICES_CMD when no devices exist.

----------------------------------------------------------------
JeongHyeon Lee (1):
      dm verity: fix DM_VERITY_OPTS_MAX value

Mikulas Patocka (2):
      dm: don't report "detected capacity change" on device creation
      dm ioctl: fix out of bounds array access when no devices

Shin'ichiro Kawasaki (1):
      dm table: Fix zoned model check and zone sectors check

 drivers/md/dm-ioctl.c         |  2 +-
 drivers/md/dm-table.c         | 33 +++++++++++++++++++++++++--------
 drivers/md/dm-verity-target.c |  2 +-
 drivers/md/dm-zoned-target.c  |  2 +-
 drivers/md/dm.c               |  5 ++++-
 include/linux/device-mapper.h | 15 ++++++++++++++-
 6 files changed, 46 insertions(+), 13 deletions(-)

