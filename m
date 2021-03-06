Return-Path: <SRS0=+JuZ=IE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A044EC433DB
	for <linux-block@archiver.kernel.org>; Sat,  6 Mar 2021 02:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6668365000
	for <linux-block@archiver.kernel.org>; Sat,  6 Mar 2021 02:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhCFCUy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Mar 2021 21:20:54 -0500
Received: from mail-pg1-f175.google.com ([209.85.215.175]:33520 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbhCFCUu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Mar 2021 21:20:50 -0500
Received: by mail-pg1-f175.google.com with SMTP id g4so2574108pgj.0;
        Fri, 05 Mar 2021 18:20:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bE/iCbha/qMZwN1FXZ2u1X/M1nTVjSVo/EJ2I/6t+28=;
        b=hTov3iaztr4fre7YXmoxRnZO7o/x6+n8jCguzCpkuD1jLoGRD0R3/OfivinHirLXrR
         k690l1f7mHWbLz904KVoR2fQDGyvSsYnclnQVJa/CTLUvspBOtqVXpSvg4EyoQgGj/E2
         m6CiO1ywR9/8ihMU8Bsi7hPD++v6PCiIgOfiIF2h13Fn9krHu9tXnjOsVi/YtbamCUcx
         6vSgcj8p2gVu9KyEsrOwjrqVPViBerqjat6tmKQcSqRHgBYjhuHX0v9xiE+te+R8t8KX
         smykUGHaJDncJbTyal5Omlh/ilXnoTJlF+EC88b/G0jP/91AQ3z9Dn4agnnGf42WUaeP
         RBZA==
X-Gm-Message-State: AOAM5321aEPEa3frKcyPiX91mm3E7oSUa5HsSeqhMsbIKXlG7LeIpmPZ
        WOo21RXXWpUfVgQUIkBjN/w=
X-Google-Smtp-Source: ABdhPJwWpjDtFjyqu/hPAadJF4wkq4uEc4gzxquLksXA0IyP+bK54Hnz7Y4gMdaREq1UQmqKxW20Cw==
X-Received: by 2002:a63:440d:: with SMTP id r13mr10733911pga.377.1614997239031;
        Fri, 05 Mar 2021 18:20:39 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id u1sm3642720pfn.209.2021.03.05.18.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 18:20:37 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id B6DAC404BB; Sat,  6 Mar 2021 02:20:36 +0000 (UTC)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     minchan@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com
Cc:     axboe@kernel.dk, mbenes@suse.com, mcgrof@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] zram: fix few ltp zram02.sh crashes
Date:   Sat,  6 Mar 2021 02:20:33 +0000
Message-Id: <20210306022035.11266-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.23.0.rc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

LTP's zram02.sh script can be used to crah your kernel pretty badly.

  cd testcases/kernel/device-drivers/zram
  while true; do PATH=$PATH:$PWD:$PWD/../../../lib/ ./zram02.sh; done

This won't do much, however if you run this in two separate windows
you'll see the kernel become unhappy quite fast. The crux of this
issue was mishandling of cpu hotplug multistate on the zram driver
in consideration for driver unload. However there was still another
long lasting bug present: races with sysfs attributes and driver
unload.

This series fixes these issues.

[0] https://github.com/linux-test-project/ltp.git 

Luis Chamberlain (2):
  zram: fix crashes due to use of cpu hotplug multistate
  zram: fix races of sysfs attribute removal and usage

 drivers/block/zram/zram_drv.c | 82 +++++++++++++++++++++++++++++++----
 1 file changed, 74 insertions(+), 8 deletions(-)

-- 
2.30.1

