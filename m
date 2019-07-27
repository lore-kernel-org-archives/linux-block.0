Return-Path: <SRS0=8nuL=VY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABBAEC433FF
	for <linux-block@archiver.kernel.org>; Sat, 27 Jul 2019 18:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D2932075E
	for <linux-block@archiver.kernel.org>; Sat, 27 Jul 2019 18:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KH/OvWIZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387962AbfG0S0e (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 27 Jul 2019 14:26:34 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32996 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387945AbfG0S0d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 27 Jul 2019 14:26:33 -0400
Received: by mail-pf1-f196.google.com with SMTP id g2so26012497pfq.0;
        Sat, 27 Jul 2019 11:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RjkXG5uPl3123IPCJ1LrmIpwjc6x0Cj+EAGqCch/YfQ=;
        b=KH/OvWIZKvQUdTPhFIXpeJIQPKe1cfxOkTI4r/Sll61Wa4DonEcUie1g6Nbjk9OTnv
         rAHoekJJC8mwPDmjU0aWW1izRTRlJmZrVgDApbXLwYmU14jWpapWN3EfGul8qZW3+/eW
         l34zMEEdkR3jLoe1yRFAJ/7yKacvRD7w3V14KfSoJsS5VGlxVbHwbFnHZEnBCYkMqOdt
         wvph0cB/O8igIEJ9xRb32sQfoySI/QsItccAec8iDVkFUUPhLon20wD4Gdh2FTbBcPDS
         BpduM5U4R+kPat/8dBAvIKB2YaEQDrgqByYWSa125McaIEfEGorl+GmV+3Hv/RXdEw69
         7xBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RjkXG5uPl3123IPCJ1LrmIpwjc6x0Cj+EAGqCch/YfQ=;
        b=m125GFasOV1vyn7V8SUjv+3+MJd4y4j9lwa2foed77Cg3h9qu6RkN3zBiurdX2E49P
         IDSCGkUJd611NTB0sS/+KSskmS6lK3rmKg1jWxpYq+A4k6sFm2wXwHAaM4HSw+ytqqqA
         7o7EGl8BhD1cqm5cYQQPZISHygpQIUt1oopvMi9TU17u+0MOjuDTfkqzsr8Fdo/Omxyv
         wjOIIMTDLoBkvRZFSepRq4rquAzb61IgThy9i1Str5TAZ1P3JbhYohMF3IeSkpnL7tUN
         If+5R8R9KV7/6jVptPTYsI5mjA6KoLbfxp0ORtARPC5y7fbQqBepTctpt5uQQtZLVRBh
         YBwQ==
X-Gm-Message-State: APjAAAXZGT9Wwk7v9btdIqJ0GUxBVioOK83REvKYJvPF6SCeDZ0AzpF6
        dTb9lePTKnf1OfgJwbjoUBJhS+mc1is=
X-Google-Smtp-Source: APXvYqzMS3yzYOHNKX3Gct/upypOjPdfcg/SxQhT1Lu3OEdAkErw5vmLdBkqr/Uycii0t1Kd4MjZIw==
X-Received: by 2002:a62:3445:: with SMTP id b66mr28577192pfa.246.1564251992636;
        Sat, 27 Jul 2019 11:26:32 -0700 (PDT)
Received: from localhost.localdomain ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id w4sm75161780pfn.144.2019.07.27.11.26.30
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 27 Jul 2019 11:26:31 -0700 (PDT)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Klaus Birkelund <klaus@birkelund.eu>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH 0/2] lightnvm: minor updates for lightnvm core
Date:   Sun, 28 Jul 2019 03:26:24 +0900
Message-Id: <20190727182626.27991-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Matias,

These are a minor patches for the lightnvm core module.  The first patch
has been reviewed by Chaitanya and Javier(tag also).  The second one is
just printing out the error which indicates the given target is not
found from the list.

Please consider this patches.

Thanks.

Minwoo Im (2):
  lightnvm: introduce pr_fmt for the prefix nvm
  lightnvm: print error when target is not found

 drivers/lightnvm/core.c | 53 ++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

-- 
2.17.1

