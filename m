Return-Path: <SRS0=YXNx=VL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA49C73C66
	for <linux-block@archiver.kernel.org>; Sun, 14 Jul 2019 05:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23EE2089C
	for <linux-block@archiver.kernel.org>; Sun, 14 Jul 2019 05:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="URIjuxhU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728207AbfGNFe1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 14 Jul 2019 01:34:27 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35578 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbfGNFeZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 14 Jul 2019 01:34:25 -0400
Received: by mail-qt1-f194.google.com with SMTP id d23so12448177qto.2;
        Sat, 13 Jul 2019 22:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RiEtXuwgyyQKKHh/Cq1orua9u8lSeD8H9W5KcO5+5qg=;
        b=URIjuxhUrSeD5r6eYElXv86lWGj02SQRUogpbyt5EebUy9lLi1vVK5V9ai+EBinGGh
         5GSLEQmn0Dt32/iQhGYz9rXkkg4nZnv//r5zHNwh4Xz0SCLhQ/nC83olAIIfZz52daqk
         E6pGdmg3FNYqUNQobnb/yK1rqlv8X1/4A8lqwUQItsajAlvds1XrZHkfqR7XjFRv8ROX
         KojQDNE2qnc1cQM6X7F4xlJRM3iJ6nHiiTndHll+VbKxQXSyrmlzx2t9JW/F8+U5p19j
         EjouHIpleyJ1EQ/0wrENUNd9u+KjPbVJGEubcWjwQ63myBpjqOsXCVI33QBPuP24MTMp
         JwNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RiEtXuwgyyQKKHh/Cq1orua9u8lSeD8H9W5KcO5+5qg=;
        b=Rv/4JCsatuvGjnSl9GD20XS2kNC4k59vLMY7rXjHx2xxa9g/S3r5T/p41fHTmCJbOy
         9kALLeX9B3gvJSrnB0f/4dx7cfMyJ9JkxsMWlVYQMRjEddws7q3GF6OKid9HdJSy5d7n
         yr+zAbcCEI7+7Wh7HELAq5wkIsNigzFR3C5Pzp0oC7CFg/UzTdgqJXiJpWeTVT4+XDfp
         NO69gCFIF8f+uLI3acF92VRE8qCV82i+HQ2JmMU6kDq0DQoSLlMfK2Dj5rgPntYl5JkZ
         dhEzabgzvcUuWpNPsXJPUtEXa4EdcSGuxhGuOsQp1pI2WfdK0DADv/+YwlWI0p2AOQ6w
         Nyfw==
X-Gm-Message-State: APjAAAWJXFpPnXdevLNN9tSDeUzAa+ZpNgLpqUo3plpg9h2pbcjTyiqa
        zb67mqSqWSylAvShITTAPRvZSlX93jM=
X-Google-Smtp-Source: APXvYqxdb5Na9D660aYHLala932q4ZitB9tKkTEi8MabrFmVg8ZRuXHozOWofoZLV6HYMZ0KfCnikw==
X-Received: by 2002:ac8:1b04:: with SMTP id y4mr12561490qtj.389.1563082463815;
        Sat, 13 Jul 2019 22:34:23 -0700 (PDT)
Received: from localhost.localdomain ([191.35.237.35])
        by smtp.gmail.com with ESMTPSA id f133sm6308808qke.62.2019.07.13.22.34.20
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Sat, 13 Jul 2019 22:34:23 -0700 (PDT)
From:   Marcos Paulo de Souza <marcos.souza.org@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
        Andreas Herrmann <aherrmann@suse.com>
Subject: [PATCH 3/4] Documenation: switching-sched: Remove notes about elevator argument
Date:   Sun, 14 Jul 2019 02:34:52 -0300
Message-Id: <20190714053453.1655-4-marcos.souza.org@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190714053453.1655-1-marcos.souza.org@gmail.com>
References: <20190714053453.1655-1-marcos.souza.org@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This argument was ignored since blk-mq was set as default, so remove it
from documentation.

Signed-off-by: Marcos Paulo de Souza <marcos.souza.org@gmail.com>
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

