Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04084C07E95
	for <linux-block@archiver.kernel.org>; Sat,  3 Jul 2021 00:20:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D277E6142D
	for <linux-block@archiver.kernel.org>; Sat,  3 Jul 2021 00:20:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbhGCAWg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Jul 2021 20:22:36 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:53041 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbhGCAWf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Jul 2021 20:22:35 -0400
Received: by mail-pj1-f54.google.com with SMTP id kt19so7565969pjb.2;
        Fri, 02 Jul 2021 17:20:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wu/AU7SgeYjnImfzCzIsnZ61JfJarZliNZLAw+nK3/M=;
        b=fcKVRykHQOn1xqvu44msoQxXQ4/qv3/54eYXoJYi2iNCHyJL7dpAQpZreDH5onatfk
         uRrxod5fy9dVMvvWG4yTkf6NbH7Lvon7fuUYx4JC/wRznvhmVCdYokD/VTEUlvRpK13H
         wI6OkefDOTqARrTwR+Kw0gn2kLhcPrlYe8PHqDkuSFFlEW2U62gos9u01voiNorEtktW
         cxC56hgWrCKynvX7HFqa4PswnyHqFUdRONe/9WOZljxLLEknlFR2/Xs7Ikz8EMpO4Y86
         CPOSoYe3aBO+JSK+mL+hpG5lOPsOXulSnUQmBxgkz01HusyPRNPuJ6ZOFAs0DXBeoFDh
         U3iA==
X-Gm-Message-State: AOAM530cUZxAbrUZwMlOUZgLtEvRVjx43mjYYOh9AUNtZc94rtyLpeei
        zvPiW9L8iWCbHa7/OTWFdvI=
X-Google-Smtp-Source: ABdhPJz32bhRF8cSO1QniwwTln8U5ZXvE42k21v2hhFgECFUCtOS32DgDt36JB1X1ttEzyUd8qZMfg==
X-Received: by 2002:a17:90a:6f63:: with SMTP id d90mr2222659pjk.34.1625271602726;
        Fri, 02 Jul 2021 17:20:02 -0700 (PDT)
Received: from localhost ([191.96.121.144])
        by smtp.gmail.com with ESMTPSA id u24sm4814452pfm.200.2021.07.02.17.20.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jul 2021 17:20:01 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     akpm@linux-foundation.org, minchan@kernel.org,
        gregkh@linuxfoundation.org, jeyu@kernel.org, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com, rafael@kernel.org
Cc:     mcgrof@kernel.org, axboe@kernel.dk, tj@kernel.org, mbenes@suse.com,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        jikos@kernel.org, rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/3] zram: fix few sysfs races
Date:   Fri,  2 Jul 2021 17:19:55 -0700
Message-Id: <20210703001958.620899-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Andrew,

This v6 rebases on to linux-next tag next-20210701, and adds a new third
patch to use ATTRIBUTE_GROUPS. This goes run time tested with the LTP
zram02 script. As per Minchan's request, sending this through you.

Luis Chamberlain (3):
  zram: fix crashes with cpu hotplug multistate
  zram: fix deadlock with sysfs attribute usage and module removal
  zram: use ATTRIBUTE_GROUPS

 drivers/block/zram/zram_drv.c | 119 ++++++++++++++++++++++++----------
 drivers/block/zram/zram_drv.h |  54 +++++++++++++++
 2 files changed, 139 insertions(+), 34 deletions(-)

-- 
2.27.0

