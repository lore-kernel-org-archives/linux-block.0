Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F319BC43460
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDB9B613C2
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 07:37:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235316AbhDFHh4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 03:37:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbhDFHhz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 6 Apr 2021 03:37:55 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72EEC061756
        for <linux-block@vger.kernel.org>; Tue,  6 Apr 2021 00:37:47 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id r12so20339896ejr.5
        for <linux-block@vger.kernel.org>; Tue, 06 Apr 2021 00:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WQDJlaw0FtQm0N9dNhdmtBw67bwGouq09B/Vh9aj0v4=;
        b=G6sj94IIoTtt7IxmOGmJiXpTDYpwa0kvxB6wvAOg5C+LtbIs52DCng15hf+DFlyB38
         rVqLdBAO2DAAsmC/mGWFuUtLEwAUfdx7/xZhmXpbLcxPyOu9ylDno6jYEiptKz14ZLmk
         dOl6LLY6ULoK/2kOb7nvARMhTxbWdwmm0a56PE8Ua4wb09FI/cmNdKMwlYz+EQ5GvKeL
         r8eb18fkkwmA5v9WUB9MRXjF2ZNM02fUhS6UD3JuQyahArlWIiNlP2LST4THF0YgjSje
         2AWDdNYO/m2be2Hp7ktAVh6xiep3Na6qQhbkQzGWFoG8FpI0vBX3KFmlIejHx9G3fEuB
         LHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WQDJlaw0FtQm0N9dNhdmtBw67bwGouq09B/Vh9aj0v4=;
        b=oOVI/4U8DpWz8picghGQ2E6J5qRy6PhKJYMQeSkWzwJB2gU6WsyAMRUKuVSMYPRr7E
         hPaH+idonE1nCITuu8dBvJ9Y6NVFcY+w7Jav3+mr758WzuJnMF+mhNPO9KrtW7dpzhuQ
         RsvMXLzpYM6oTSXbMNC39KYWoXaINOrF1wITSTbhIu7oIi7CI87mScJbSHO4OwQ1VknO
         N9MHnq4h9sP/RDhB9k+8qx4fqE2EoQM96/wuCAyV+wKTQoCxdjReDtEO7TOF4NDBaN3F
         elFzQRtNqIyRc2pe0ekgyhzSi+yy/pC7914H/fR/81gy1kwsIODjZaCy6YzvyaC66evz
         XE5w==
X-Gm-Message-State: AOAM533CQdX69oFxlLGHNCGwFXzmj3Z1I0drHOSsdY1mZbcraqUCUKFt
        IUooIGZbEf5a6HF6RLCw9JvZdeFVr9Kgf5pc
X-Google-Smtp-Source: ABdhPJzNhg99FKLftecF7uaQKNlLMGFGYAm8LAv+c6Dxo3BIxf0CQPx8YGLQzibttwuEA2Rs09orCw==
X-Received: by 2002:a17:906:a51:: with SMTP id x17mr32914560ejf.25.1617694666608;
        Tue, 06 Apr 2021 00:37:46 -0700 (PDT)
Received: from gkim-laptop.fkb.profitbricks.net (ip5f5aeee5.dynamic.kabel-deutschland.de. [95.90.238.229])
        by smtp.googlemail.com with ESMTPSA id o6sm12843305edw.24.2021.04.06.00.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 00:37:46 -0700 (PDT)
From:   Gioh Kim <gi-oh.kim@ionos.com>
To:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org
Cc:     axboe@kernel.dk, akinobu.mita@gmail.com, corbet@lwn.net,
        hch@infradead.org, sagi@grimberg.me, bvanassche@acm.org,
        haris.iqbal@ionos.com, jinpu.wang@ionos.com,
        Gioh Kim <gi-oh.kim@cloud.ionos.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
Subject: [PATCH for-next 5/5] docs: Add RTRS/RNBD to the index of fault-injection
Date:   Tue,  6 Apr 2021 09:37:27 +0200
Message-Id: <20210406073727.172380-6-gi-oh.kim@ionos.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210406073727.172380-1-gi-oh.kim@ionos.com>
References: <20210406073727.172380-1-gi-oh.kim@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Gioh Kim <gi-oh.kim@cloud.ionos.com>

Add new documents for RTRS and RNBD to the index file.

Signed-off-by: Gioh Kim <gi-oh.kim@cloud.ionos.com>
Signed-off-by: Jack Wang <jinpu.wang@cloud.ionos.com>
---
 Documentation/fault-injection/index.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/fault-injection/index.rst b/Documentation/fault-injection/index.rst
index 8408a8a91b34..669d146af874 100644
--- a/Documentation/fault-injection/index.rst
+++ b/Documentation/fault-injection/index.rst
@@ -11,6 +11,8 @@ fault-injection
     notifier-error-inject
     nvme-fault-injection
     provoke-crashes
+    rnbd-fault-injection
+    rtrs-fault-injection
 
 .. only::  subproject and html
 
-- 
2.25.1

