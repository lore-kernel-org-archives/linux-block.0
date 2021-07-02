Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3C4C11F69
	for <linux-block@archiver.kernel.org>; Fri,  2 Jul 2021 04:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C371B6141D
	for <linux-block@archiver.kernel.org>; Fri,  2 Jul 2021 04:37:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhGBEj4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 2 Jul 2021 00:39:56 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175]:35751 "EHLO
        mail-pf1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbhGBEjz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 2 Jul 2021 00:39:55 -0400
Received: by mail-pf1-f175.google.com with SMTP id d12so7937770pfj.2;
        Thu, 01 Jul 2021 21:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8LQCWWmZdOvB5Hgy3eHx0fFPp+Bd0TSxJNEfvEAKrbg=;
        b=NOLHApivA39/czx4k6fKG7GmV9tAuSG+djebUN41GaaFCRBLKB2aIo1z8tqHuDwhue
         ezl9klXHmSyvR9/JbZoPuqKUawpkpkS6JaWqMQlUp6Eznk0shuasHHC6mXBAtxARf0kr
         rxaBT7TECB36qk2FhNry3D8c+O1heRP1l3Y1ioM3+mAisLRChN1PceNZseFJFCuHzhOH
         LB4YX521kRIlXqSnbc/Kq46BrpLRlR/sLA/XxkCOfaWaQmIHYibvv8wKKk1/BhdyiWQ+
         yYrTGaL7A4VAiB6Vmjr+JCky8gE3vUQMKmenb0FQvOn0kTUzUFeq70LN/XiBQWGVd4/R
         43tg==
X-Gm-Message-State: AOAM532OU0v2BzNADixta/PiXk669K4f2sYmYYgTD1/Kg20sJ7qOl4ex
        1wvFnqq2Hk6hljcsFG6CJZc=
X-Google-Smtp-Source: ABdhPJwF/DDEjnrE1jDMCfDJlF8LWMrj4AcM6QjZujnVvdVrjxr3nN4S53tGazMyUV4bLM0ItJ+j1A==
X-Received: by 2002:a05:6a00:2395:b029:304:7a51:6f1d with SMTP id f21-20020a056a002395b02903047a516f1dmr3563164pfc.53.1625200643153;
        Thu, 01 Jul 2021 21:37:23 -0700 (PDT)
Received: from localhost ([191.96.121.144])
        by smtp.gmail.com with ESMTPSA id i20sm1634883pfo.130.2021.07.01.21.37.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jul 2021 21:37:22 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     minchan@kernel.org, gregkh@linuxfoundation.org, jeyu@kernel.org,
        ngupta@vflare.org, sergey.senozhatsky.work@gmail.com,
        rafael@kernel.org
Cc:     mcgrof@kernel.org, axboe@kernel.dk, tj@kernel.org, mbenes@suse.com,
        jpoimboe@redhat.com, tglx@linutronix.de, keescook@chromium.org,
        jikos@kernel.org, rostedt@goodmis.org, peterz@infradead.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/2] zram: fix few sysfs races
Date:   Thu,  1 Jul 2021 21:37:14 -0700
Message-Id: <20210702043716.2692247-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This v5 modifies the second patch, the set of macros needed a bit of
adjustments so we can keep the same name attributes. It also updates
the patches to fix all checkpatch complaints.

Luis Chamberlain (2):
  zram: fix crashes with cpu hotplug multistate
  zram: fix deadlock with sysfs attribute usage and module removal

 drivers/block/zram/zram_drv.c | 108 ++++++++++++++++++++++++++--------
 drivers/block/zram/zram_drv.h |  54 +++++++++++++++++
 2 files changed, 137 insertions(+), 25 deletions(-)

-- 
2.27.0

