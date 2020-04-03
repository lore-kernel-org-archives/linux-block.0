Return-Path: <SRS0=iNmo=5T=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF47C43331
	for <linux-block@archiver.kernel.org>; Fri,  3 Apr 2020 17:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E5F42073B
	for <linux-block@archiver.kernel.org>; Fri,  3 Apr 2020 17:15:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRnV96g6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgDCRPr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:15:47 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42536 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391022AbgDCRPr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Apr 2020 13:15:47 -0400
Received: by mail-qk1-f193.google.com with SMTP id 139so8761086qkd.9
        for <linux-block@vger.kernel.org>; Fri, 03 Apr 2020 10:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fUWELD5SV8bxPQCRNQ9kZEOE/DoXXWPQ2inGCUBvAoI=;
        b=CRnV96g6ygvqf9wGhuudLeNmFMFM7fGtOA/VMn54jDol4fqBWqsCbX5phfYX2DaWjS
         Fg/6LcQAMfVWvuq9/eueaXifeXbKlWb+ApVIu54TwZLuJarKA00zMdPbKZRU42SU9xmM
         Iykf1XR/kn2RRKg8jBPVa4LrHVmNvyYA/2cZM8XZZoK6JJfvQDP5IxlArUoqDxwmM+9K
         jMVCRsaBQKrym0XXoa1/EsrGezde49RGGXnqGFmiRWZcDBjDgrCGLNgdBYq3UyXrNuVg
         gmZBQ0kAp6mtmnEjvSG1Q6XEqvW5G6w/BMzFYobn50CaXI/T64Hm8raIxZLyb8QcvtYv
         eF1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=fUWELD5SV8bxPQCRNQ9kZEOE/DoXXWPQ2inGCUBvAoI=;
        b=QCtaCQawLitTdkySZVESz3P8oU++bu4vo2+LVd+R7qhc6lFf50rGiYTtepJ7qxqwXz
         ZVTv3oKzB4WYZSmxRXIvuNRVmP7e14oPZmeKmX9/5QuBrjWJ7VcGniif7UFt9odkjsyD
         X2j5b2QcGckigfMzNJW9sSOEpWXzcN2CfdnPr9hdRphDRRtnhvbMwEaBe+ngPD0V8EkB
         Y6jhEJ88Tc5l+s/OmxinM94J9WnQJNFgyczNU2feQQQXdvfiIYyF/cERmJrcLex0OTsN
         hoZYKUVfNeDnl/IQwBWiK9uYpvJcGzbhIHLvBjIGZWUGn/m1wNq3GcHuqpPXidHNspIT
         zTtw==
X-Gm-Message-State: AGi0PuYwblxXtU0FJ8mK55KzpN3sXjEGaxoFAY74TZHd6v6S80d6mamH
        eOtaaLLEweS1AtoElb9p5vmbiydT0Bk=
X-Google-Smtp-Source: APiQypLx7cZ5QXGUPKBpKJm5QxHmon+RGMr5vp8vQGDLg+jiCPXE4jJM5Pepu9xZN17NdXj9NL8jUQ==
X-Received: by 2002:a05:620a:1f1:: with SMTP id x17mr10203564qkn.60.1585934145987;
        Fri, 03 Apr 2020 10:15:45 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id v1sm7025822qtc.30.2020.04.03.10.15.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2020 10:15:45 -0700 (PDT)
Date:   Fri, 3 Apr 2020 13:15:43 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com,
        Alasdair G Kergon <agk@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: [git pull v2] device mapper fixes for 5.7
Message-ID: <20200403171543.GA92499@lobo>
References: <20200403154213.GA18386@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403154213.GA18386@redhat.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

I updated the tag after my initial pull request to include one more
fix from Mikulas.

The following changes since commit 81d5553d1288c2ec0390f02f84d71ca0f0f9f137:

  dm clone metadata: Fix return type of dm_clone_nr_of_hydrated_regions() (2020-03-27 14:42:51 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.7/dm-fixes

for you to fetch changes up to 8267d8fb4819afa76b2a54dca48efdda6f0b1910:

  dm integrity: fix logic bug in integrity tag testing (2020-04-03 13:07:41 -0400)

Please pull, thanks!
Mike

----------------------------------------------------------------
- Fix excessive bio splitting that caused performance regressions.

- Fix logic bug in DM integrity discard support's integrity tag
  testing.

- Fix DM integrity warning on ppc64le due to missing cast.

----------------------------------------------------------------
Mike Snitzer (2):
      dm integrity: fix ppc64le warning
      Revert "dm: always call blk_queue_split() in dm_process_bio()"

Mikulas Patocka (1):
      dm integrity: fix logic bug in integrity tag testing

 drivers/md/dm-integrity.c | 4 ++--
 drivers/md/dm.c           | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)
