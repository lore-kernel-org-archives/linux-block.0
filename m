Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E33C61DB3
	for <linux-block@archiver.kernel.org>; Fri, 13 Jan 2023 12:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241642AbjAMMpS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 13 Jan 2023 07:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242031AbjAMMoW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Jan 2023 07:44:22 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482C9FAF7
        for <linux-block@vger.kernel.org>; Fri, 13 Jan 2023 04:36:33 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id u19so51949467ejm.8
        for <linux-block@vger.kernel.org>; Fri, 13 Jan 2023 04:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8l6YI6ll5WTtemsFOxZHnG0tRV3sgRpFSwrNSjhQUI=;
        b=n5fyYkdzH0FaufBTIPFRKPuo0z+AnNGqgMIwP1N9mikuhruiPj9WRKliJKtqkJNcSH
         jdCwrwklvxXlnybHa2UFVFEhVxo4yxnl8RG0yqtoK6PM/qUzfFALdh3BP1L2UPVBR9o/
         w6zxIZEnL5J2sKJYA0OPCfypQ0p9FVxHHUrz6Z1/JMdUq1spCP7LrSapSCEMuwGCHe8s
         HGX+lofy0D+Q+QodiXTM0nZKzf/sIpaOtXX8WkCVlMaYF2cEEk1uvCC20PCV1+9TJe7q
         9hzSbMatiM8L1ARpqUspUBtbv9iuXjfy6N1xV7yn0VoH1DnxioqTPvTQdYkdND7Ap/8M
         BVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w8l6YI6ll5WTtemsFOxZHnG0tRV3sgRpFSwrNSjhQUI=;
        b=CCiBymwJDFC5YVeQ+0jQ9rOpMbJz4ETafBEpo688VYO0jzuDwYWBaMELdUBTN7vc+c
         tm4p//l2GlV2ksE2NA/O9Hporw9TJZ+V7gIjW5yE9KVDECun+4/M61N3IBZPVI0F+V4x
         ZcKsmG5AybbxZt5GmDUq5z7x4Idf5y8WFxRsNs1p0sP7XwNtj9emKJqA4ULNeujvaqVg
         oRIkU334h7dwBknpUo9QKyHGA2LtnX4wp6kefud4JGJ38CfjviALQyFfKmLifGgY5Hmg
         /lio1YwN6FkGbiT2rvV1S4cFS85dI/8ib/DGnqYaYKMlpZzErLEbDeNFBnkfsKCe8aNF
         KIsg==
X-Gm-Message-State: AFqh2koFue0foVq1Zr5xtHi+mzAXlQ6LrZYEZjS6903uferW4u1sD0gX
        m8wnsP9f2gl03wiPGC+0I3O8Hg==
X-Google-Smtp-Source: AMrXdXu44yUl9NgFIBf8qhXToOixwyuyGJ/Lw4hHpgVpqAff1RfeVl1gcgrTKjFSUgjeQWYdT5EfWQ==
X-Received: by 2002:a17:906:3993:b0:844:de87:8684 with SMTP id h19-20020a170906399300b00844de878684mr78074081eje.46.1673613349021;
        Fri, 13 Jan 2023 04:35:49 -0800 (PST)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906329100b007c0bb571da5sm8402496ejw.41.2023.01.13.04.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 04:35:48 -0800 (PST)
From:   =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     drbd-dev@lists.linbit.com, linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org,
        Andreas Gruenbacher <agruen@linbit.com>,
        =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Subject: [PATCH 8/8] drbd: drbd_insert_interval(): Clarify comment
Date:   Fri, 13 Jan 2023 13:35:38 +0100
Message-Id: <20230113123538.144276-9-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230113123538.144276-1-christoph.boehmwalder@linbit.com>
References: <20230113123538.144276-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Andreas Gruenbacher <agruen@linbit.com>

Signed-off-by: Andreas Gruenbacher <agruen@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/drbd_interval.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/drbd/drbd_interval.c b/drivers/block/drbd/drbd_interval.c
index b6aaf0d4d85b..873beda6de24 100644
--- a/drivers/block/drbd/drbd_interval.c
+++ b/drivers/block/drbd/drbd_interval.c
@@ -58,7 +58,7 @@ drbd_insert_interval(struct rb_root *root, struct drbd_interval *this)
  * drbd_contains_interval  -  check if a tree contains a given interval
  * @root:	red black tree root
  * @sector:	start sector of @interval
- * @interval:	may not be a valid pointer
+ * @interval:	may be an invalid pointer
  *
  * Returns if the tree contains the node @interval with start sector @start.
  * Does not dereference @interval until @interval is known to be a valid object
-- 
2.38.1

