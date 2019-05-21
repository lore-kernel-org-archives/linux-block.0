Return-Path: <SRS0=jUAw=TV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59135C072B5
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 23:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FC6217F9
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 23:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726017AbfEUXis (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 May 2019 19:38:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48480 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725797AbfEUXis (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 May 2019 19:38:48 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 448803086258;
        Tue, 21 May 2019 23:38:48 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EDFF660C78;
        Tue, 21 May 2019 23:38:45 +0000 (UTC)
Date:   Tue, 21 May 2019 19:38:45 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Michael Lass <bevan@bi-co.net>
Subject: [git pull] device mapper fix for 5.2-rc2
Message-ID: <20190521233844.GA31426@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Tue, 21 May 2019 23:38:48 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit 8454fca4f53bbe5e0a71613192674c8ce5c52318:

  dm: fix a couple brace coding style issues (2019-05-16 10:09:21 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.2/dm-fix-1

for you to fetch changes up to 51b86f9a8d1c4bb4e3862ee4b4c5f46072f7520d:

  dm: make sure to obey max_io_len_target_boundary (2019-05-21 19:15:20 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix a particularly glaring oversight in a DM core commit from 5.1 that
  doesn't properly trim special IOs (e.g. discards) relative to
  corresponding target's max_io_len_target_boundary().

----------------------------------------------------------------
Michael Lass (1):
      dm: make sure to obey max_io_len_target_boundary

 drivers/md/dm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)
