Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DAB2C4707F
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 18:52:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BB62613D4
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 18:52:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235262AbhE0SyC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 14:54:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbhE0SyC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 14:54:02 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90C8C061574
        for <linux-block@vger.kernel.org>; Thu, 27 May 2021 11:52:27 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id eb9so655572qvb.6
        for <linux-block@vger.kernel.org>; Thu, 27 May 2021 11:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=irFDTmhfj5+mUVkDlWzm45eHLPkDZVXsNY0Yh4yvFJw=;
        b=B2Vno50b+KVzrQ4rqN8eP1ghuEtK/8XNra8/vuCGe6oktf6StT+YIIdvhSHyvJtvrc
         H6S1EspJTJFuO55Y+oWy1vhT2f4xF/4KGKF5yI60C679T54RfcKm2RfTuk6Q2MPV7IZb
         d2FDLGGeNJDlG+zPhd6YJGzgKczsFbVt7YsWUO9bDMEj9913aOdYR/1AD8CwkCloySiU
         Wg8buAeOByXwatatbikV0ekmko1sSPIV89CiUPoOqowbGsW/pkdve5zY5iRXm+dlM+sk
         FmLoz8pbMSA4jIk1nB+y0+MZ2TsYpklBc7EKnsAk0H+poO1YPOpgu9glKEr3AnER5FPo
         1BJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=irFDTmhfj5+mUVkDlWzm45eHLPkDZVXsNY0Yh4yvFJw=;
        b=XkEbQkxvIdV7tO2aotjDpnn6TyJekNnx0kaC+fZ5/ou2sxuxFT2fJOe2JHtMzyjynB
         /IszKq9lBuIFWpHFL+NlbfM3ze1vDb9DNCxioh6i1wPOufPIC2bJolJnqEzV9wqDJBmV
         w7XuAenDaXjEURCtFyVYeir1ariJFPnpa8DYhO/vuWQpOXLlV7kmrfK67KzycLDKBqYf
         LBnwBUTaEKEkFZfAB+SmDx85Ye9lL37d5cFdH94aa5bLBRyT1ObLOptWB5oi3cRIRz6k
         xGNKzoPyNBqjK4Ao0l3972QGvDCr6v2cTa/CrwVl16M+h8+rBpVQDlxB4sVa9ss+GWXs
         dXrQ==
X-Gm-Message-State: AOAM531vIkdYcVwhDRw2swZ5gt7HlVzb+GyOuP+RHWqDIGicT7OZBDxN
        xVEki+ks28IqarpeC6MFNgw=
X-Google-Smtp-Source: ABdhPJwInFMBWXlkNnFR9FRuaRgbtnyYV/fylItuyWAkS+lZHcG75OJCcPhS64Js4i72av7+Sa+RXA==
X-Received: by 2002:a0c:fa4e:: with SMTP id k14mr5243918qvo.51.1622141546756;
        Thu, 27 May 2021 11:52:26 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id d200sm1934340qkc.44.2021.05.27.11.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 11:52:26 -0700 (PDT)
Sender: Mike Snitzer <snitzer@gmail.com>
Date:   Thu, 27 May 2021 14:52:25 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        John Keeping <john@metanate.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [git pull] device mapper fixes for 5.13-rc4
Message-ID: <YK/qaSCdhqDlKh1l@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit c4681547bcce777daf576925a966ffa824edd09d:

  Linux 5.13-rc3 (2021-05-23 11:42:48 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.13/dm-fixes-2

for you to fetch changes up to 7e768532b2396bcb7fbf6f82384b85c0f1d2f197:

  dm snapshot: properly fix a crash when an origin has no snapshots (2021-05-25 16:19:58 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix DM verity target's 'require_signatures' module_param permissions.

- Revert DM snapshot fix from v5.13-rc3 and then properly fix crash
  when an origin has no snapshots. This allows only the proper fix to
  go to stable@ (since the original fix was successfully dropped).

----------------------------------------------------------------
John Keeping (1):
      dm verity: fix require_signatures module_param permissions

Mikulas Patocka (2):
      dm snapshot: revert "fix a crash when an origin has no snapshots"
      dm snapshot: properly fix a crash when an origin has no snapshots

 drivers/md/dm-snap.c              | 3 ++-
 drivers/md/dm-verity-verify-sig.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)
