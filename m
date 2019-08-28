Return-Path: <SRS0=wI0I=WY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B07C3A5A6
	for <linux-block@archiver.kernel.org>; Wed, 28 Aug 2019 01:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3576720856
	for <linux-block@archiver.kernel.org>; Wed, 28 Aug 2019 01:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eTJeQOCS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbfH1BTE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Aug 2019 21:19:04 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41604 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfH1BTD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Aug 2019 21:19:03 -0400
Received: by mail-qk1-f193.google.com with SMTP id g17so967254qkk.8;
        Tue, 27 Aug 2019 18:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SoFd8qgQZjEfBsnsbadeJBnYco4ASHLN4YbXvQwMM8Q=;
        b=eTJeQOCSY0iPkTnfTwqOfwyqQA4rd7bTaZFe2s76GrYPTD3sRR7zaHtU4Gkvg+iLvE
         /2So9eSs07/n+u1iC5IeIQtH8Zx9YdFyJPxUhFq+vg84sqCDCbl/nGOaJXfmA7CjhCNQ
         LorAP5U5KLlF/2t3XEOABuuV/I6jxGQtgMYaaZEQOcyn9/KZKNSga0hH1wRGXNHnD/C5
         DVFOX7jb9TJS3EHvE5OH3WmVuYoRLnek6V4KIgd9etJtVGQoJ58fU0NhiM6VrrX97lLQ
         beUjgiNbLvFfN4sOP+XXcsmiRNHZdgH9WZN4UW2DM4keGjjwWAw0z/totNjb/nUAVCep
         JZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SoFd8qgQZjEfBsnsbadeJBnYco4ASHLN4YbXvQwMM8Q=;
        b=b+lx2xEY6r8drsZQNETAMy9tlVA21UXfGuDL62EJFOnVVYYw2ZstCxrZLpmqprMlJn
         fYXgs4Kj0k/TUwitlQMy7pgKHdxhKR33Lwra3L8OU7hfqkgGjQzbCQxlE3Nc41BSd6/Q
         3hBRCyp1xqyM6ST/mvvx0JEDGcFKFY0QBYCcxOTSu9MEdc2FyrnvvZlKLAc7cjQyUA6K
         BbrWoYQ8NnsCvBcmFBLiWOkNxRWyBzR2V9T6SqJ6Q/R529iwF4Id7x2mz+87kyAxA9HA
         Pypn2B/o91zQo1nqg9gI4/ntqh7z8SkadXs+kJ9YCIhDl3n5xm3Rho8ahuRf6Oa6m7j1
         3vrQ==
X-Gm-Message-State: APjAAAV77nvPJC2Xu6wVpb9eAPw+c0dpkZqvW6KZgidfDQkcKEHk+/CB
        PSDDm2L/r4q9vCf8VyC080+ggwC/q9s=
X-Google-Smtp-Source: APXvYqze65PaY6Hqlb9yF6VxNs2+lHagYbybvwZbmViwPRUTvalEjSx8eYRmdiI72FQlH/u3/BZfhQ==
X-Received: by 2002:a37:9d0b:: with SMTP id g11mr1550134qke.460.1566955142095;
        Tue, 27 Aug 2019 18:19:02 -0700 (PDT)
Received: from localhost.localdomain ([186.212.48.84])
        by smtp.gmail.com with ESMTPSA id c201sm499231qke.128.2019.08.27.18.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 18:19:01 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk
Cc:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Hannes Reinecke <hare@suse.com>
Subject: [RESEND PATCH 3/4] Documenation: switching-sched: Remove notes about elevator argument
Date:   Tue, 27 Aug 2019 22:19:29 -0300
Message-Id: <20190828011930.29791-4-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190828011930.29791-1-marcos.souza.org@gmail.com>
References: <20190828011930.29791-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This argument was ignored since blk-mq was set as default, so remove it
from documentation.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
---
 Documentation/block/switching-sched.txt | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/block/switching-sched.txt b/Documentation/block/switching-sched.txt
index 7977f6fb8b20..431d56471227 100644
--- a/Documentation/block/switching-sched.txt
+++ b/Documentation/block/switching-sched.txt
@@ -1,7 +1,3 @@
-To choose IO schedulers at boot time, use the argument 'elevator=deadline'.
-'noop' and 'cfq' (the default) are also available. IO schedulers are assigned
-globally at boot time only presently.
-
 Each io queue has a set of io scheduler tunables associated with it. These
 tunables control how the io scheduler works. You can find these entries
 in:
-- 
2.22.0

