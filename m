Return-Path: <SRS0=YKm5=AU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C603BC433DF
	for <linux-block@archiver.kernel.org>; Thu,  9 Jul 2020 19:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C135206DF
	for <linux-block@archiver.kernel.org>; Thu,  9 Jul 2020 19:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lf3s9mHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbgGITno (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Jul 2020 15:43:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38265 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726220AbgGITnn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Jul 2020 15:43:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594323822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=xvaxmbOlZU1EzpA00wnb1ksDvCN6QOIcMsxAj8wMLM8=;
        b=Lf3s9mHLsiLRhJgTUHFf8ERQZejZExDw1JrCa2Dgq5/R8Ci6Srxr0Z1ecm60L2PRIvjN+e
        KtF+/H6Jk0CxZ7yxlxO9ITU/PAS2m7YWE74Te9r8JuFXXHCT5loFWuPqUVw2ppuQow/rYJ
        JcggTkf7wE6U5fU1kvwNAVX1xyY2J7w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-5gDELEINOxi9o7m_RKnbkA-1; Thu, 09 Jul 2020 15:43:38 -0400
X-MC-Unique: 5gDELEINOxi9o7m_RKnbkA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2D94F1B18BC0;
        Thu,  9 Jul 2020 19:43:37 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E117C7981F;
        Thu,  9 Jul 2020 19:43:30 +0000 (UTC)
Date:   Thu, 9 Jul 2020 15:43:30 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Michal Suchanek <msuchanek@suse.de>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Ming Lei <ming.lei@redhat.com>,
        Wei Yongjun <weiyongjun1@huawei.com>
Subject: [git pull] device mapper fixes for 5.8-rc5
Message-ID: <20200709194329.GA14653@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit dcb7fd82c75ee2d6e6f9d8cc71c52519ed52e258:

  Linux 5.8-rc4 (2020-07-05 16:20:22 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.8/dm-fixes-2

for you to fetch changes up to 6958c1c640af8c3f40fa8a2eee3b5b905d95b677:

  dm: use noio when sending kobject event (2020-07-08 12:50:51 -0400)

Please pull, thanks!
Mike

----------------------------------------------------------------
- A request-based DM fix to not use a waitqueue to wait for blk-mq IO
  completion because doing so is racey.

- A couple more DM zoned target fixes to address issues introduced
  during the 5.8 cycle.

- A DM core fix to use proper interface to cleanup DM's static flush
  bio.

- A DM core fix to prevent mm recursion during memory allocation
  needed by dm_kobject_uevent.

----------------------------------------------------------------
Christoph Hellwig (1):
      dm: use bio_uninit instead of bio_disassociate_blkg

Damien Le Moal (1):
      dm zoned: Fix zone reclaim trigger

Michal Suchanek (1):
      dm writecache: reject asynchronous pmem devices

Mikulas Patocka (1):
      dm: use noio when sending kobject event

Ming Lei (1):
      dm: do not use waitqueue for request-based DM

Wei Yongjun (1):
      dm zoned: fix unused but set variable warnings

 drivers/md/dm-rq.c             |  4 --
 drivers/md/dm-writecache.c     |  6 +++
 drivers/md/dm-zoned-metadata.c |  9 ++++-
 drivers/md/dm-zoned-reclaim.c  |  7 ++--
 drivers/md/dm-zoned-target.c   | 10 +----
 drivers/md/dm.c                | 84 ++++++++++++++++++++++++++----------------
 6 files changed, 71 insertions(+), 49 deletions(-)

