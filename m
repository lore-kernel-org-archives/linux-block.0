Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D420C433DF
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 19:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A97E2070A
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 19:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBz+3CU2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725792AbgFZT3A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jun 2020 15:29:00 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:52412 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725768AbgFZT27 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 15:28:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593199738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=Jcm1BDWWyjIRk1f7YdEql8B5bvJaP4t/Th5WMi2ZGog=;
        b=VBz+3CU2tw5Or7CvuUs/QjdUzlUjoGGNIlxAniPuGydvCPGRERTTtJNBG3z5oTsoRIsYc3
        KulklFlT141nojxA3GCrwcnjgWDA4V8jbEEVvkIz5AOy1rJBwmAyEZclD+pJ1Dz5D2EaQO
        T9KNQe+hYSfS8JQdTXEXh9j96hbcLbI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-eLtdpE8vPUKGAJNIX4H2Kw-1; Fri, 26 Jun 2020 15:28:53 -0400
X-MC-Unique: eLtdpE8vPUKGAJNIX4H2Kw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5EF8D800D5C;
        Fri, 26 Jun 2020 19:28:51 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2AF578202D;
        Fri, 26 Jun 2020 19:28:48 +0000 (UTC)
Date:   Fri, 26 Jun 2020 15:28:47 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hou Tao <houtao1@huawei.com>, Huaisheng Ye <yehs1@lenovo.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [git pull] device mapper fixes for 5.8-rc3
Message-ID: <20200626192847.GA11459@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.8/dm-fixes

for you to fetch changes up to d35bd764e6899a7bea71958f08d16cea5bfa1919:

  dm writecache: add cond_resched to loop in persistent_memory_claim() (2020-06-19 12:32:24 -0400)

Please pull, thanks!
Mike

----------------------------------------------------------------
- Quite a few DM zoned target fixes and a Zone append fix in DM core.
  Considering the amount of dm-zoned changes that went in during the
  5.8 merge window these fixes are not that surprising.

- A few DM writecache target fixes.

- A fix to Documentation index to include DM ebs target docs.

- Small cleanup to use struct_size() in DM core's retrieve_deps().

----------------------------------------------------------------
Damien Le Moal (2):
      dm zoned: fix uninitialized pointer dereference
      dm zoned: Fix random zone reclaim selection

Gustavo A. R. Silva (1):
      dm ioctl: use struct_size() helper in retrieve_deps()

Hou Tao (1):
      dm zoned: assign max_io_len correctly

Huaisheng Ye (2):
      dm writecache: correct uncommitted_block when discarding uncommitted entry
      dm writecache: skip writecache_wait when using pmem mode

Johannes Thumshirn (1):
      dm: update original bio sector on Zone Append

Mauro Carvalho Chehab (1):
      docs: device-mapper: add dm-ebs.rst to an index file

Mikulas Patocka (1):
      dm writecache: add cond_resched to loop in persistent_memory_claim()

Shin'ichiro Kawasaki (2):
      dm zoned: Fix metadata zone size check
      dm zoned: Fix reclaim zone selection

 Documentation/admin-guide/device-mapper/index.rst |  1 +
 drivers/md/dm-ioctl.c                             |  2 +-
 drivers/md/dm-writecache.c                        | 10 ++++--
 drivers/md/dm-zoned-metadata.c                    | 42 +++++++++++++++++------
 drivers/md/dm-zoned-reclaim.c                     |  4 +--
 drivers/md/dm-zoned-target.c                      |  2 +-
 drivers/md/dm.c                                   | 13 +++++++
 7 files changed, 56 insertions(+), 18 deletions(-)

