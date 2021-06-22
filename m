Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E480CC2B9F4
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 21:19:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE4F961164
	for <linux-block@archiver.kernel.org>; Tue, 22 Jun 2021 21:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhFVVWD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jun 2021 17:22:03 -0400
Received: from mail-pf1-f180.google.com ([209.85.210.180]:40627 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbhFVVWD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jun 2021 17:22:03 -0400
Received: by mail-pf1-f180.google.com with SMTP id q192so570865pfc.7;
        Tue, 22 Jun 2021 14:19:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=li4k0zFz4Rbnkic/yeCKT4iyIkbfif4Sr3XY7eFgAjA=;
        b=hvT1+vgPeYX8OD2MKVDi7zvfeJ4auvO2R8w7IRsXXoxQGlrEHGeb8Jqymk7hZTGXjt
         wHfcG6kDRd1M1eNOIIuqsOdZ3vQPEHCqcj7Nk/Z1jCodr5KCGHkJ66v8o8kySN5azMEH
         6iWzOJA1UiQTl8NKNdFoyTunSM3B3rgO6RhssqR+iTWSNbYWw2CrzWUO3DFEbsfCXdpY
         F7AJQ5pdQ/ue9TdHnN4+FCzpajfmDvPGyPp2L6NkbqEmnFdBOsGJpH5eB4qpjSDuKXcg
         JtCmdk/SYbiO+Q9ZkTttfVRAsUlGFAalz9tbZre8mqAGwI0mTayT+ol/YN/VZPL+q0Rr
         SQpw==
X-Gm-Message-State: AOAM5333Wp7B+iw0S7SPvb6j/k8nfnZghk6UouTAOcDpvzYR7H5EYfNS
        nD/RLOFdaVnWrKPepae+T5o=
X-Google-Smtp-Source: ABdhPJydnzMvSlMQV6C3Lfhw1Ghrt7CTkskM/Uyt7iFLSZSPGKCkYaK8Nx3R5AQ6+tGguYpC5EbbaA==
X-Received: by 2002:a63:e34d:: with SMTP id o13mr579197pgj.316.1624396785861;
        Tue, 22 Jun 2021 14:19:45 -0700 (PDT)
Received: from localhost ([173.239.198.97])
        by smtp.gmail.com with ESMTPSA id n5sm17142565pgf.35.2021.06.22.14.19.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 14:19:44 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     minchan@kernel.org, gregkh@linuxfoundation.org, jeyu@kernel.org,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        rafael@kernel.org
Cc:     mcgrof@kernel.org, axboe@kernel.dk, mbenes@suse.com,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        jikos@kernel.org, rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] zram: fix few sysfs races
Date:   Tue, 22 Jun 2021 14:19:39 -0700
Message-Id: <20210622211941.3754857-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As per Greg's request I've split out the driver core patch out on
its own. Other than that, this series addresses the few minor
changes which Greg requested, namely making the zram_up bool static,
and adjusting the subject of the second patch to make it clear the
race is with module removal.

Luis Chamberlain (2):
  zram: fix crashes due to use of cpu hotplug multistate
  zram: fix deadlock with sysfs attribute usage and module removal

 drivers/block/zram/zram_drv.c | 141 ++++++++++++++++++++++++----------
 drivers/block/zram/zram_drv.h |  40 ++++++++++
 2 files changed, 139 insertions(+), 42 deletions(-)

-- 
2.27.0

