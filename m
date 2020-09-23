Return-Path: <SRS0=LQCZ=DA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF415C2D0A8
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 17:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 500802054F
	for <linux-block@archiver.kernel.org>; Wed, 23 Sep 2020 17:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZcLlnOo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgIWRa3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Sep 2020 13:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbgIWRa1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Sep 2020 13:30:27 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DB9C0613CE
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2020 10:30:26 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 16so491697qkf.4
        for <linux-block@vger.kernel.org>; Wed, 23 Sep 2020 10:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3pFkA3pz8LuI0sxqCTepsUeVtM/3MLBYmtrtAxBYd10=;
        b=jZcLlnOoPnmnicnpkDG5e/bPBF9Dx1iCvY5EgVVgkx1o2h5VKsyMInbqrjVXVwyU6U
         RlroSFxkP2iqmCyGWTdICsaBv4JiiBdLG27Pr2YYVztS5P/1wN2gV1NCXbl0YXCRMsUb
         PRqCD2043DCW/B43QOaP5h0CBK4lfdfwBQ8oV8UlCa7pqwPakFKs0Hm6HocY6VxlpygK
         y0dhLptZqZ/MdoeTPCwoIGLjh/IDZOtdOAZ+EBUIhL2WczsI9hgweUwxxdpZ40DoPOU9
         wmWpqV/c+LMgloMc28a6POKzLMXYlkqlakZIsGYXJghVk6IffU1Zl92u3EfpAaD5BYWn
         /XzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=3pFkA3pz8LuI0sxqCTepsUeVtM/3MLBYmtrtAxBYd10=;
        b=htaSMgfwn1EoXA6lCIna0MLk1jnjrhdckgucofGXL91zFBp1GmsAMv9yG/7JwCv/i3
         Nk9VTTdfCbrACoV+vQf6X33eAkGrVejDKtHnyhMbywiNLYnTAhgh8x7/eL3thUkbBiGG
         MMH0a27zy2tEQpZhCBvllsulqEhU+va8bHZtO4HXtvWXQY//H0v7oMXwD2VNzzHXiAcL
         DwcyDk+o5RE5+sokxV2/kQX8raqCVs0N/70qxNqmtrQL/QCu1LmleNOi5VE2m+X++81c
         N8X/6MXHPwXiRH/aQjiVO5yYW6MCtYBVu06swtHTOed8OACjnO/pja5UcL8IVbN2HIxZ
         rFsQ==
X-Gm-Message-State: AOAM5326kA7/36Kwiulm18+6viKGKokP2Io5wn12BPuPGN4/11TZhIXz
        wf8txWByJD7n+K5ZErEhO3g=
X-Google-Smtp-Source: ABdhPJyN48W5oammQkJsRewNb7n+w8HJi128qZ74s56p7dWCVtcMGLLgHWOlZycDTXlK8ObNe+KUuQ==
X-Received: by 2002:a05:620a:15c7:: with SMTP id o7mr925910qkm.486.1600882226026;
        Wed, 23 Sep 2020 10:30:26 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id s10sm396856qkg.61.2020.09.23.10.30.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2020 10:30:25 -0700 (PDT)
Sender: Mike Snitzer <snitzer@gmail.com>
Date:   Wed, 23 Sep 2020 13:30:24 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Milan Broz <gmazyland@gmail.com>
Subject: [git pull] device mapper fixes for 5.9 final
Message-ID: <20200923173024.GA97173@lobo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit beaeb4f39bc31d5a5eb6d05465a86af4fe147732:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2020-09-21 08:53:48 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.9/dm-fixes-2

for you to fetch changes up to 4c07ae0ad493b7b2d3dd3e53870e594f136ce8a5:

  dm crypt: document encrypted keyring key option (2020-09-22 13:25:58 -0400)

Please pull, thanks!
Mike

----------------------------------------------------------------
- DM core fix for incorrect double bio splitting. Keep "fixing" this
  because past attempts didn't fully appreciate the liability relative
  to recursive bio splitting. This fix limits DM's bio splitting to a
  single method and does _not_ use blk_queue_split() for normal IO.

- DM crypt Documentation updates for features added during 5.9 merge.

----------------------------------------------------------------
Mike Snitzer (2):
      dm: fix bio splitting and its bio completion order for regular IO
      dm: fix comment in dm_process_bio()

Milan Broz (2):
      dm crypt: document new no_workqueue flags
      dm crypt: document encrypted keyring key option

 .../admin-guide/device-mapper/dm-crypt.rst         | 10 +++++++-
 drivers/md/dm.c                                    | 27 ++++------------------
 2 files changed, 14 insertions(+), 23 deletions(-)
