Return-Path: <SRS0=/0DQ=4Q=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11722C3F2D2
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 15:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF9C124699
	for <linux-block@archiver.kernel.org>; Fri, 28 Feb 2020 15:06:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="G/2YveMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgB1PGc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:06:32 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:33162 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgB1PGc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Feb 2020 10:06:32 -0500
Received: by mail-pj1-f67.google.com with SMTP id m7so4433717pjs.0
        for <linux-block@vger.kernel.org>; Fri, 28 Feb 2020 07:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MmlSCV1UkvLr/iJG9NF31H7Jmp9fYYp/6LpJItDDNzo=;
        b=G/2YveMeeNIYVrifhL98VUWjo0T0QUYZpiIw88hm6zUyazo3iWoCAWsZhMKNyrOupl
         NeT3l8EEd42B5WZlTtJkMAFjykva+0nd1nvP7vyw5+p2s4TSCcN30Bekiy1ZUbBkthoC
         nf8VR+nddLuWqniiEvgDI0id6NoJ8iNqEZzo4V9awF9k2VcpYhKdUFXjt1wNUbfIDGu7
         /stSIm99kO6n2FK5jUCewbuTJG7OiUowmUelBjfQSwpdrKFcfvPixLgAyrmaIbWiSye9
         jLkOFI/EHAJ5bvNlpa21igx2Zix9G6iq8Qb3P01gBeimfbyOfI9jok+QAZfdEWWm6CWb
         YO/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MmlSCV1UkvLr/iJG9NF31H7Jmp9fYYp/6LpJItDDNzo=;
        b=qgH2FRRzX/iJRZyjHGZrKyqKIxoyF8pZziaDCGBZOxwv6xzSeQbuhsX/TOmzYzNhXK
         RudK6AqfgN5idQqKr0Nn5UdFHv/Q8i9YEe1q+5RR6K9EFQohsCuTT6AEKlXet2s1KcLY
         7nQcPsf0nnvatxX6wdSKZjwk80gzkBSfwMsLfq/b7JPtWZdaFOJqRbMC+xYiKaSjhNTw
         Khciv546SzlJVf2f45KRgtaquVOj48oTRg4MHiGFD5JviH7X5ikfX4/bQdVoIxYtjYPk
         xdQtzX3UFza52Wa/8DfEl3GjuQwlOJdpdF8thT4KHs1odwJJOtXhru5OI1qCezLoURQK
         WIuQ==
X-Gm-Message-State: APjAAAW2flSQ5FX2hBinu20BAmgDMmgnnjYmVZ7KaiLuzq7lcNdwWmeU
        AyHT3Q+m52rYG79ptWslaHmO2Id2j0UOduw/
X-Google-Smtp-Source: APXvYqy9/KPGc6eJMAXdReYIBmf2iKB1/d1KR9yMbHYmemLYJ2TEFyMOjLlvI6BLbvt8DK2S9tL2sQ==
X-Received: by 2002:a17:902:9f86:: with SMTP id g6mr4110588plq.299.1582902389597;
        Fri, 28 Feb 2020 07:06:29 -0800 (PST)
Received: from nb01257.pb.local ([240e:82:3:5b12:940:b7e:a31d:58eb])
        by smtp.gmail.com with ESMTPSA id y1sm7621912pgs.74.2020.02.28.07.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 07:06:28 -0800 (PST)
From:   Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org,
        Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
Subject: [PATCH 4/6] block: remove obsolete comments for _blk/blk_rq_prep_clone
Date:   Fri, 28 Feb 2020 16:05:16 +0100
Message-Id: <20200228150518.10496-5-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200228150518.10496-1-guoqing.jiang@cloud.ionos.com>
References: <20200228150518.10496-1-guoqing.jiang@cloud.ionos.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Both cmd and sense had been moved to scsi_request, so remove
the related comments to avoid confusion.

Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 block/blk-core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 883ffda216e4..9094fd7d1b01 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1583,7 +1583,6 @@ EXPORT_SYMBOL_GPL(blk_rq_unprep_clone);
 
 /*
  * Copy attributes of the original request to the clone request.
- * The actual data parts (e.g. ->cmd, ->sense) are not copied.
  */
 static void __blk_rq_prep_clone(struct request *dst, struct request *src)
 {
@@ -1610,8 +1609,6 @@ static void __blk_rq_prep_clone(struct request *dst, struct request *src)
  *
  * Description:
  *     Clones bios in @rq_src to @rq, and copies attributes of @rq_src to @rq.
- *     The actual data parts of @rq_src (e.g. ->cmd, ->sense)
- *     are not copied, and copying such parts is the caller's responsibility.
  *     Also, pages which the original bios are pointing to are not copied
  *     and the cloned bios just point same pages.
  *     So cloned bios must be completed before original bios, which means
-- 
2.17.1

