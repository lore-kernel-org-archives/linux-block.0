Return-Path: <SRS0=TUEB=U2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A86C48BD7
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 18:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E70F2064A
	for <linux-block@archiver.kernel.org>; Thu, 27 Jun 2019 18:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfF0STN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jun 2019 14:19:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55250 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726514AbfF0STN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jun 2019 14:19:13 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5A67A308FEC4;
        Thu, 27 Jun 2019 18:19:13 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 94AE460BE0;
        Thu, 27 Jun 2019 18:19:07 +0000 (UTC)
Date:   Thu, 27 Jun 2019 14:19:06 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Gen Zhang <blackgod016574@gmail.com>,
        Jerome Marchand <jmarchan@redhat.com>,
        Milan Broz <gmazyland@gmail.com>,
        Stephen Boyd <swboyd@chromium.org>,
        zhangyi <yi.zhang@huawei.com>
Subject: [git pull] device mapper fixes for 5.2 final
Message-ID: <20190627181904.GA10850@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 27 Jun 2019 18:19:13 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit 9e0babf2c06c73cda2c0cd37a1653d823adb40ec:

  Linux 5.2-rc5 (2019-06-16 08:49:45 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.2/dm-fixes-2

for you to fetch changes up to 2eba4e640b2c4161e31ae20090a53ee02a518657:

  dm verity: use message limit for data block corruption message (2019-06-25 14:09:14 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix incorrect uses of kstrndup and DM logging macros in DM's early
  init code.

- Fix DM log-writes target's handling of super block sectors so updates
  are made in order through use of completion.

- Fix DM core's argument splitting code to avoid undefined behaviour
  reported as a side-effect of UBSAN analysis on ppc64le.

- Fix DM verity target to limit the amount of error messages that can
  result from a corrupt block being found.

----------------------------------------------------------------
Gen Zhang (1):
      dm init: fix incorrect uses of kstrndup()

Jerome Marchand (1):
      dm table: don't copy from a NULL pointer in realloc_argv()

Milan Broz (1):
      dm verity: use message limit for data block corruption message

Stephen Boyd (1):
      dm init: remove trailing newline from calls to DMERR() and DMINFO()

zhangyi (F) (1):
      dm log writes: make sure super sector log updates are written in order

 drivers/md/dm-init.c          | 10 +++++-----
 drivers/md/dm-log-writes.c    | 23 +++++++++++++++++++++--
 drivers/md/dm-table.c         |  2 +-
 drivers/md/dm-verity-target.c |  4 ++--
 4 files changed, 29 insertions(+), 10 deletions(-)
