Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C40C4361B
	for <linux-block@archiver.kernel.org>; Sat, 12 Dec 2020 21:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B222422509
	for <linux-block@archiver.kernel.org>; Sat, 12 Dec 2020 21:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407939AbgLLVLY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 12 Dec 2020 16:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726898AbgLLVLX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 12 Dec 2020 16:11:23 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63B9C0613CF
        for <linux-block@vger.kernel.org>; Sat, 12 Dec 2020 13:10:43 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id 4so6538941plk.5
        for <linux-block@vger.kernel.org>; Sat, 12 Dec 2020 13:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=YDIL1OWJux8kqFywdHcSaaYCNtcsRhJ8ufBRDzoygHs=;
        b=q0k0mgbxLDrOr8fWb9LDoJQoeKIEmKgWGOYo/aXTOXpH7v5hHRYWQDMOv+0YuHw5sF
         6RmgTA6r26Fmo+T4/LqZ3fFWRXPgvScrkkJvVHoXq0IHSXn9ogXY6ZzktsyHoGujMwQA
         pNsiWiF2YXJPL/ECBb+kqGYJFFiV9yhS2cu1hYuNvtMRk9krCUUhDqdUNHUafz3/4gj2
         8kd635Ztfko9c9CYtntTL+7PKfm6LLOrEi/vso+wRwXbSybymp1TwmgrpJT2iow9m9+1
         8aNexmQqk5u2h2V4yviGVkBhJISqwpteAcervABELL2j2bdhvCM5itlTSWdWUnFCAuGP
         rbAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=YDIL1OWJux8kqFywdHcSaaYCNtcsRhJ8ufBRDzoygHs=;
        b=ZozyLCbvX7MoZ8IPqtAj7PJE45XK5/4EcvofD1eG9LDV3CHTw3CVaxVp1d7yDYDuNE
         oeLJMhbAPgUCpyaDVO3UGho/nWfcP+juqQcF8vIEHERwq8GjNT1nFuLESYhPYpREGmzn
         xnN5RVg0Lfj4XkvlGrZqgzbQTaBUiJ/recO1L/LNOAMNL3H+BQ6xMLp3yI4TjV3GXb/1
         DxXqLgtyhZeotv19qaKkWuVn5kYtNkG/vJ5b4wGHhb2rlAXkzLGLtbmtzc+tmVNkcaGM
         Xpi+8FcbYcQuHUuHkXimNxlY/JWr4uTxACAe0ZQUAymIJdHgGiA5NKndifSRbaGsePPl
         pTNQ==
X-Gm-Message-State: AOAM5319z7iAeUAOfLlAAiO9PModGnmZXAakC7q1pUiY34wr1z2UjX6V
        I6XtodWLSugHgrZSdWQdL9azxfp7YR50xQ==
X-Google-Smtp-Source: ABdhPJytXDrjj/GJAN0skVFIA/9pldglUMtXvk2Gsy+EY9P6nBpbHNrRkozVVUDJtXOR3AIKAp3l2A==
X-Received: by 2002:a17:90a:f412:: with SMTP id ch18mr18980247pjb.69.1607807442926;
        Sat, 12 Dec 2020 13:10:42 -0800 (PST)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id v17sm15606926pga.58.2020.12.12.13.10.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Dec 2020 13:10:42 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL v2] Final block fixes for 5.10
Message-ID: <3cee02fb-ded4-e773-a0a2-a296397beff9@kernel.dk>
Date:   Sat, 12 Dec 2020 14:10:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Mike and Song looked into the warning case, and thankfully it appears
the fix was pretty trivial - we can just change the md device chunk type
to unsigned int to get rid of it. They cannot currently be < 0, and
nobody is checking for that either.

That said, this should be it for 5.10. We're reverting the discard
changes as the corruption reports came in very late, and there's just no
time to attempt to deal with it at this point. Reverting the changes in
question is the right call for 5.10.

Please pull!


The following changes since commit 7e7986f9d3ba69a7375a41080a1f8c8012cb0923:

  block: use gcd() to fix chunk_sectors limit stacking (2020-12-01 11:02:55 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.10-2020-12-12

for you to fetch changes up to 6ffeb1c3f8226244c08105bcdbeecc04bad6b89a:

  md: change mddev 'chunk_sectors' from int to unsigned (2020-12-12 10:07:50 -0700)

----------------------------------------------------------------
block-5.10-2020-12-12

----------------------------------------------------------------
Jens Axboe (1):
      Merge branch 'md-fixes' of https://git.kernel.org/.../song/md into block-5.10

Mike Snitzer (1):
      md: change mddev 'chunk_sectors' from int to unsigned

Song Liu (6):
      Revert "dm raid: remove unnecessary discard limits for raid10"
      Revert "md/raid10: improve discard request for far layout"
      Revert "md/raid10: improve raid10 discard request"
      Revert "md/raid10: pull codes that wait for blocked dev into one function"
      Revert "md/raid10: extend r10bio devs to raid disks"
      Revert "md: add md_submit_discard_bio() for submitting discard bio"

 drivers/md/dm-raid.c |  11 ++
 drivers/md/md.c      |  20 ---
 drivers/md/md.h      |   6 +-
 drivers/md/raid0.c   |  14 +-
 drivers/md/raid10.c  | 423 +++++++--------------------------------------------
 drivers/md/raid10.h  |   1 -
 6 files changed, 82 insertions(+), 393 deletions(-)

-- 
Jens Axboe

