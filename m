Return-Path: <SRS0=aLpJ=QW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76239C43381
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 14:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FC6E2192D
	for <linux-block@archiver.kernel.org>; Fri, 15 Feb 2019 14:38:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732732AbfBOOij (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:38:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41880 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729482AbfBOOij (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Feb 2019 09:38:39 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4E9CF1301CA;
        Fri, 15 Feb 2019 14:38:39 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E67B5F9C0;
        Fri, 15 Feb 2019 14:38:33 +0000 (UTC)
Date:   Fri, 15 Feb 2019 09:38:32 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Nikos Tsironis <ntsironis@arrikto.com>
Subject: [git pull] device mapper fixes for 5.0 final
Message-ID: <20190215143832.GA20900@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Fri, 15 Feb 2019 14:38:39 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit d13937116f1e82bf508a6325111b322c30c85eb9:

  Linux 5.0-rc6 (2019-02-10 14:42:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.0/dm-fixes-3

for you to fetch changes up to 4ae280b4ee3463fa57bbe6eede26b97daff8a0f1:

  dm thin: fix bug where bio that overwrites thin block ignores FUA (2019-02-14 19:02:29 -0500)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix bug in DM crypt's sizing of its block integrity tag space,
  resulting in less memory use when DM crypt layers on DM integrity.

- Fix a long-standing DM thinp crash consistency bug that was due to
  improper handling of FUA.  This issue is specific to writes that
  fill an entire thinp block which needs to be allocated.

----------------------------------------------------------------
Mikulas Patocka (1):
      dm crypt: don't overallocate the integrity tag space

Nikos Tsironis (1):
      dm thin: fix bug where bio that overwrites thin block ignores FUA

 drivers/md/dm-crypt.c |  2 +-
 drivers/md/dm-thin.c  | 55 ++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 51 insertions(+), 6 deletions(-)
