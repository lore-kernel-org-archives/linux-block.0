Return-Path: <SRS0=jAbK=VP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E010C7618F
	for <linux-block@archiver.kernel.org>; Thu, 18 Jul 2019 20:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB4C20693
	for <linux-block@archiver.kernel.org>; Thu, 18 Jul 2019 20:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q4BvHllC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfGRUxL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 18 Jul 2019 16:53:11 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33813 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727762AbfGRUxL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jul 2019 16:53:11 -0400
Received: by mail-qk1-f196.google.com with SMTP id t8so21626923qkt.1
        for <linux-block@vger.kernel.org>; Thu, 18 Jul 2019 13:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=sTtEMGmTL9dvBOIINcDJDROlyszLu+f4o1mt2HA89Y8=;
        b=Q4BvHllCoPJSweP+7DCcl34sOCk6W/PGwv42xJI4uBfiDxUSkOSihSNDqnXNNxqUZy
         qMFTZyiQgNtbewc2ZlAo2oki80fXQRy5h1IMblhZmD0G9TLmEILLgTjMYWJHBzQcKowm
         mRxgbc1B1KFUyhk7SLAsMXdEFV9XSNvn8qjtx26sumDgRTD2ImoAqV1zTc3XUvbCUwNo
         Jm4EAb+Zds++P9SMTFNp0BvIbgglXGg8+sFVhZqbnaoWgJwFyewIuJIX1QxIhKfcu4Bj
         NVtbNMnD5mn8hRDAheGSdE+SaEkJX7aGtGvzaRPOVJWBr5VJBXm9lK7/6RbzmM1D+wT0
         5ZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=sTtEMGmTL9dvBOIINcDJDROlyszLu+f4o1mt2HA89Y8=;
        b=cWAi3pgtfo2BG+oTOJi5vYgMCYk4eH0kq47lsAn/P6s/4pbJzor7cKpuhAVXvwsBZ/
         TBJ4N2DqVlInXrQlgM9/ODlDlwQRdIkks60X80VnKRiUWmXPzPV9NCOcLuOfx/GtONRC
         E7yfu3A9Y+kh6RuMYIX3VjGNmZPp7kNFzItcUDHcA3IQ/p2X/9YCOu2ECnj8MAiMQYdk
         yP0uj/bQMKQZiWp+lXrWoNmh1MJc39GNwtltqowSbBnrjIQIKnEIzebx8RZ+8Wsexp5/
         QMuOSMsG5Zm+ulcO3PmVJRUeAnAM0r3O6/gK56ueT3RtuMtHTwuBY4Z49ggGflv9PrKr
         qrUA==
X-Gm-Message-State: APjAAAVJrQzROvoh2FDX7noT0Dzeud6XcyZvTLRMwdrjSP1BrJmKfFey
        ZPUy+cKhRniGFyhr8JKbVHQ=
X-Google-Smtp-Source: APXvYqzL460vzQs3RYhC2KbahYwOAjAf8YqVKcN/lSlunc8G7XzMbiLmiXegKwBO4GPMY5NSUQJojw==
X-Received: by 2002:ae9:f016:: with SMTP id l22mr32580980qkg.51.1563483190040;
        Thu, 18 Jul 2019 13:53:10 -0700 (PDT)
Received: from localhost (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id a135sm13148396qkg.72.2019.07.18.13.53.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jul 2019 13:53:09 -0700 (PDT)
Date:   Thu, 18 Jul 2019 16:53:08 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Nikos Tsironis <ntsironis@arrikto.com>
Subject: [git pull] additional device mapper changes for 5.3
Message-ID: <20190718205308.GA65274@lobo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

When I sent my pull last Friday I had overlooked some email that Nikos
(cc'd) sent that same morning concerning review of my dm-snapshot
discard changes that were merged over the weekend.  In addition, Nikos
inquired about his dm-kcopyd subjob size default adjustment I had
requested some changes on.  I've since dealt with those 2 issues and
staged 2 other small fixes (to dm-zoned and DM core's printk wrappers).

The following changes since commit bd293d071ffe65e645b4d8104f9d8fe15ea13862:

  dm bufio: fix deadlock with loop device (2019-07-12 09:59:37 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.3/dm-changes-2

for you to fetch changes up to 733232f8c852bcc2ad6fc1db7f4c43eb01c7c217:

  dm: use printk ratelimiting functions (2019-07-17 13:09:32 -0400)

Please pull, thanks!
Mike

----------------------------------------------------------------
- Fix zone state management race in DM zoned target by eliminating
  the unnecessary DMZ_ACTIVE state.

- A couple fixes for issues the DM snapshot target's optional discard
  support added during first week of the 5.3 merge.

- Increase default size of outstanding IO that is allowed for a each
  dm-kcopyd client and introduce tunable to allow user adjust.

- Update DM core to use printk ratelimiting functions rather than
  duplicate them and in doing so fix an issue where DMDEBUG_LIMIT() rate
  limited KERN_DEBUG messages had excessive "callbacks suppressed"
  messages.

----------------------------------------------------------------
Damien Le Moal (1):
      dm zoned: fix zone state management race

Mike Snitzer (2):
      dm snapshot: fix oversights in optional discard support
      dm: use printk ratelimiting functions

Nikos Tsironis (1):
      dm kcopyd: Increase default sub-job size to 512KB

 drivers/md/dm-kcopyd.c         | 34 ++++++++++++++++++++++++++++------
 drivers/md/dm-snap.c           | 10 ++++++++++
 drivers/md/dm-zoned-metadata.c | 24 ------------------------
 drivers/md/dm-zoned.h          | 28 ++++++++++++++++++++++++----
 include/linux/device-mapper.h  | 17 ++++-------------
 5 files changed, 66 insertions(+), 47 deletions(-)
