Return-Path: <SRS0=HKcR=2U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB40C2D0D3
	for <linux-block@archiver.kernel.org>; Mon, 30 Dec 2019 18:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 750A0206DB
	for <linux-block@archiver.kernel.org>; Mon, 30 Dec 2019 18:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WOZ2e/CY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727490AbfL3SPO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Dec 2019 13:15:14 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:36986 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbfL3SPN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Dec 2019 13:15:13 -0500
Received: by mail-yw1-f65.google.com with SMTP id z7so14377269ywd.4
        for <linux-block@vger.kernel.org>; Mon, 30 Dec 2019 10:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m3u686E/hmF+VtDj9EoqD7bRcan0QOItr+D8DDAaZ+k=;
        b=WOZ2e/CYDeC4Km4RBLUIrqdfpkRmN0WIoEGjtljRfhTeo0TcFgO4rHJjNTIgtADfjn
         utWhOpu4EtsXWI8Vpc3kLOugtnO238Yqi5Wv2JXysbl3fMbzpSMgnrzULTtdiBKcTnIM
         3B1OODe+8ZGya+a17drnzvag4B8onAZhGWy7oTZFdI7riDGHcLtIQIJ0lLsvrZM07+Wk
         FB+iDEw7C01H+E2w4O/oltLF/tAkBRmbgGp0tEYOr5x24y9F1qlGcQJ7LXBluK9OKwUp
         42ClzMe8avffwPK08G5+N4rv1t+zmzqUothiCKWTWotkO+EM+VdC0LXYdUGaY7R8LmRD
         CS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m3u686E/hmF+VtDj9EoqD7bRcan0QOItr+D8DDAaZ+k=;
        b=mThpsPJ5S17W9MlUC2yBj5C61FfcDF696n7YxQr+EXpR2VdkVzXTqLjwkbzswGDQXr
         0xE5Snxg0Us+d784E1ehigK5UwxxgoKfPW7XHHZdWHgpxgUBUZO6JIuDGs0joxSHIHPI
         rfU2VvSgFL2COuk6i6nQys+9lsI+AxgnNpILBIYMEiNk20qs2yoXvIw3oxalWDWwJ0IX
         XDobF2uxHNwELoKDB6DZeHBmi0GtXyqWt/B355Tz/bVel1yYD2fxVDqP4A4IVf11C7NH
         YAcyX3weAsZj/c76qJlts+o8bow80EgfgLsQfFMJoigz3JTw3G5nu0egs6FH9TLUNe6j
         h1Pw==
X-Gm-Message-State: APjAAAX299rTrX9+9yZBd90VXsDEyCG53UT5AtlDKxxeSkkuUyZY4LGk
        Vpsqt8Gu8/671GduJt+uF7HftW6Eems=
X-Google-Smtp-Source: APXvYqxD6hHqkhNBmQflw9GW6ZkedYycIitg2YlyjlazHbv6n/CkTg6RzGR9xH8R0zb6e69hNRW0pA==
X-Received: by 2002:a81:d549:: with SMTP id l9mr51614724ywj.417.1577729712356;
        Mon, 30 Dec 2019 10:15:12 -0800 (PST)
Received: from x1.localdomain ([8.46.73.113])
        by smtp.gmail.com with ESMTPSA id u136sm17879910ywf.101.2019.12.30.10.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2019 10:15:12 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/4] sbitmap: mask out top bits that can't be used
Date:   Mon, 30 Dec 2019 11:14:41 -0700
Message-Id: <20191230181442.4460-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191230181442.4460-1-axboe@kernel.dk>
References: <20191230181442.4460-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If the tag depth isn't a multiple of the bits_per_word we selected,
we'll have dead bits at the top. Ensure that they are set. This
doesn't matter for the bit finding as we limit it to the depth of
the individual map, but it'll matter for when we try and grab
batches of tags off one map.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 lib/sbitmap.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index c13a9623e9b5..a6c6c104b063 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -46,7 +46,13 @@ int sbitmap_init_node(struct sbitmap *sb, unsigned int depth, int shift,
 		return -ENOMEM;
 
 	for (i = 0; i < sb->map_nr; i++) {
-		sb->map[i].depth = min(depth, bits_per_word);
+		if (depth >= bits_per_word) {
+			sb->map[i].depth = bits_per_word;
+		} else {
+			sb->map[i].depth = depth;
+			/* mask off top unused bits, can never get allocated */
+			sb->map[i].word = ~((1UL << depth) - 1);
+		}
 		depth -= sb->map[i].depth;
 	}
 	return 0;
-- 
2.24.1

