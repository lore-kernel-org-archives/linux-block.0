Return-Path: <SRS0=h0yA=YL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AE9CA9EA9
	for <linux-block@archiver.kernel.org>; Fri, 18 Oct 2019 16:08:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A84721D7C
	for <linux-block@archiver.kernel.org>; Fri, 18 Oct 2019 16:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405727AbfJRQIh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Oct 2019 12:08:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55980 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727834AbfJRQIh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Oct 2019 12:08:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 549FA3071CD1;
        Fri, 18 Oct 2019 16:08:37 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A315B600C1;
        Fri, 18 Oct 2019 16:08:34 +0000 (UTC)
Date:   Fri, 18 Oct 2019 12:08:33 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nikos Tsironis <ntsironis@arrikto.com>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [git pull] device mapper fixes for 5.4-rc4
Message-ID: <20191018160833.GA5763@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Fri, 18 Oct 2019 16:08:37 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit da0c9ea146cbe92b832f1b0f694840ea8eb33cce:

  Linux 5.4-rc2 (2019-10-06 14:27:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.4/dm-fixes

for you to fetch changes up to 13bd677a472d534bf100bab2713efc3f9e3f5978:

  dm cache: fix bugs when a GFP_NOWAIT allocation fails (2019-10-17 11:13:50 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix DM snapshot deadlock that can occur due to COW throttling
  preventing locks from being released.

- Fix DM cache's GFP_NOWAIT allocation failure error paths by switching
  to GFP_NOIO.

- Make __hash_find() static in the DM clone target.

----------------------------------------------------------------
Mikulas Patocka (3):
      dm snapshot: introduce account_start_copy() and account_end_copy()
      dm snapshot: rework COW throttling to fix deadlock
      dm cache: fix bugs when a GFP_NOWAIT allocation fails

YueHaibing (1):
      dm clone: Make __hash_find static

 drivers/md/dm-cache-target.c | 28 +------------
 drivers/md/dm-clone-target.c |  4 +-
 drivers/md/dm-snap.c         | 94 ++++++++++++++++++++++++++++++++++++--------
 3 files changed, 81 insertions(+), 45 deletions(-)
