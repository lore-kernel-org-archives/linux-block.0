Return-Path: <SRS0=5K92=V6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFEFC32750
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 15:18:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D388204EC
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 15:18:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmOflGoz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbfHBPS2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Aug 2019 11:18:28 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44656 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbfHBPS1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Aug 2019 11:18:27 -0400
Received: by mail-qt1-f194.google.com with SMTP id 44so43204382qtg.11
        for <linux-block@vger.kernel.org>; Fri, 02 Aug 2019 08:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=gdngyBtdu0hdLvbeSbTye0hHvs2AeGgWPnp7xtpz2pc=;
        b=bmOflGozxI+mphcODY5j7b5BFsfrSWy3IStln5jlsCHG22r0XXLXiVYhg3h+Q/ybO/
         EEZE/oPaI7sHjS1wktwJ7ClVppB8cnwh5yjkEgbM7nx4Tss6EGDyAUiETkxpD24cXwhO
         ++aTWhjhQ2cm+8LD+9pI4hHmL7z1WiWgKx2BwffkRRaxPCp1CJ9jKL/SLccBSMNpkrmJ
         PV4lk3QGGl5ZgxYVCTNPHqwUWKWuDpVaECx+Q2O49rPl9BBJ4p1RstF0aS7KLYMOfqub
         dueOfDsMkLu/3D2IUF3/EAG1V3hEEJaBNA0/bBbfnTeoBEeJUaB2cMV0aNdih6iqBLSh
         1UVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=gdngyBtdu0hdLvbeSbTye0hHvs2AeGgWPnp7xtpz2pc=;
        b=acQFwrtTkcnMdf4xPMw9/4yB+RzkPG2fCHwJhp6XW0845jztpNU4Muax9AuGFBxKKU
         kctJ1jVSJyd7zE9Nw2UuMLgrgIkPEc8Tm8qhFIJfHxlepbJrcf6BSI3kCWgQnpUXIxIb
         CjlLnJHctfQRLPeOUrdQlGdbTfTN6Ncj7ULyPKu+C3+r68HHTognJ9ZWaNm/yx6b+mFG
         GDVas7/tcb6gTxzPfamcW9Se64KGI+a7WW7dLqWIOOrG6Zwt2Jr3SGBewZh0/ZJyJ9T1
         fXh6OI1sxI/INU37JD21Xlmc9A8h1RgB7EKQ07BTxeKAckEfsuu0iABQoPocZdos4kr4
         pQpQ==
X-Gm-Message-State: APjAAAW/Av5tka4IkCwbfdDiM01IWnX5nfy296j1dC9ZSPPgIoEESACA
        +HkTKblqKwng9C3owvcKn4M=
X-Google-Smtp-Source: APXvYqzwf8ISub3zZQgY3MRTVRb9eZqoBIKiw7mfLgYH6rV1oSYEitDAJeImj/PmBE8fAIg+AtfRmg==
X-Received: by 2002:ac8:2d56:: with SMTP id o22mr93765389qta.171.1564759106857;
        Fri, 02 Aug 2019 08:18:26 -0700 (PDT)
Received: from localhost (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id z33sm33924524qtc.56.2019.08.02.08.18.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 02 Aug 2019 08:18:26 -0700 (PDT)
Date:   Fri, 2 Aug 2019 11:18:25 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Pankaj Gupta <pagupta@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [git pull] device mapper fixes for 5.3-rc3
Message-ID: <20190802151824.GA86075@lobo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit 609488bc979f99f805f34e9a32c1e3b71179d10b:

  Linux 5.3-rc2 (2019-07-28 12:47:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.3/dm-fixes-1

for you to fetch changes up to 9c50a98f55f4b123227eebb25009524d20bc4c2a:

  dm table: fix various whitespace issues with recent DAX code (2019-07-30 18:59:24 -0400)

Please pull, thanks!
Mike

----------------------------------------------------------------
Fix NULL pointer and various whitespace issues with DM's recent DAX code
changes from commit in 5.3 merge.

----------------------------------------------------------------
Mike Snitzer (1):
      dm table: fix various whitespace issues with recent DAX code

Pankaj Gupta (1):
      dm table: fix dax_dev NULL dereference in device_synchronous()

 drivers/md/dm-table.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)
