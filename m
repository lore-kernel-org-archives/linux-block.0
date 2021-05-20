Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869AAC433B4
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 19:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 692EC61353
	for <linux-block@archiver.kernel.org>; Thu, 20 May 2021 19:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbhETTrK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 May 2021 15:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbhETTrK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 May 2021 15:47:10 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6583C061574
        for <linux-block@vger.kernel.org>; Thu, 20 May 2021 12:45:48 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id c20so17475742qkm.3
        for <linux-block@vger.kernel.org>; Thu, 20 May 2021 12:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=HHJU3Q306ITmLSio1GcF/N7+OjoVriUxfio1f6Xoj4s=;
        b=Q/8sn+orlUwXqzqStWjxYCQMV0Lar9tzoBq9u8IEK2xjFFKXp9OhyAnjsW6ALFlZSQ
         JEH6EyAnhp7U/4ejgggY7+3DAizj0ap41oUMnbUVGt8Xe63SjnSbpIkY5AeeoXTvPMeN
         6kRm05za9FFv7NbvfYh9E3WsHrz92+eYrVWKAOu3ajaSuWSSITj2miBSMskQzYwcylA/
         ndPjduXqIhaSqdnn2gdyeuOCyfjgbUEx/soIOSjGxSzMtW9tMbQ8s8QJMuiDG1Imgjyd
         Z5gKXhwe0uiwAxmkAntpQyqWF/VZIqnJt05bENMABXrV2N2v6qwd/Lkzwq5vAW7NJDHw
         M56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=HHJU3Q306ITmLSio1GcF/N7+OjoVriUxfio1f6Xoj4s=;
        b=LbSirdxctQ6yCZGUrfPoY34dNxDnoIE/rCiZnwuFDMKlZm/huvou/iieKbb7hoZr8C
         VOjgaf2gl7lGi6nNT2uy3oTj3lGwCSZI3xYOEVHctFcavB9jozOC6p2MiQWxMeLOy7q3
         vJnOYbLHvbav/zMruN477A31Zfa7xHzVmEo4lFfuVRiLYS00rIdfQFFWmzwrroTRWNBr
         bKK+n+cpfc8aDyUIiExg76t/4fZBekCdkr/AYcxEZoxyOBvwnhn+K8vXan579SAO4mMq
         DnZ9iGnq2RAWi3KhMD1PLSI4UF75jrKNnxBFPN5lYgP0RAVAxSOl3ILLq+kr/vkGGb5c
         dkgQ==
X-Gm-Message-State: AOAM532QvKgefEwINqxPFQnMQJfzFQfSlHFPlBxgFB1+ICZvEYUnR+SP
        7vjfep6lc0ZZYcIk6nEUi0EI7QHmwFA=
X-Google-Smtp-Source: ABdhPJzmUfqcOPKc6TrGlLiQX15KKLZNOun7zl5sdHXRTtunYckGLbsgOQEV8MJehPCse+DHFLyRIg==
X-Received: by 2002:ae9:c016:: with SMTP id u22mr7105608qkk.114.1621539947905;
        Thu, 20 May 2021 12:45:47 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id g64sm2809749qkf.41.2021.05.20.12.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 12:45:47 -0700 (PDT)
Sender: Mike Snitzer <snitzer@gmail.com>
Date:   Thu, 20 May 2021 15:45:46 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [git pull] device mapper fixes for 5.13-rc3
Message-ID: <YKa8aq2SgXzX7sva@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:

  Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.13/dm-fixes

for you to fetch changes up to bc8f3d4647a99468d7733039b6bc9234b6e91df4:

  dm integrity: fix sparse warnings (2021-05-13 14:53:49 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Fix a couple DM snapshot target crashes exposed by user-error.

- Fix DM integrity target to not use discard optimization, introduced
  during 5.13 merge, when recalulating.

- Fix some sparse warnings in DM integrity target.

----------------------------------------------------------------
Mikulas Patocka (4):
      dm snapshot: fix a crash when an origin has no snapshots
      dm snapshot: fix crash with transient storage and zero chunk size
      dm integrity: revert to not using discard filler when recalulating
      dm integrity: fix sparse warnings

 drivers/md/dm-integrity.c | 81 +++++++++++++++++++++--------------------------
 drivers/md/dm-snap.c      |  6 ++--
 2 files changed, 39 insertions(+), 48 deletions(-)
