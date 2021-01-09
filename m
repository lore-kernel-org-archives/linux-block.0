Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9B3C433DB
	for <linux-block@archiver.kernel.org>; Sat,  9 Jan 2021 16:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EA37239E4
	for <linux-block@archiver.kernel.org>; Sat,  9 Jan 2021 16:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbhAIQEz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Jan 2021 11:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbhAIQEy (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Jan 2021 11:04:54 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38249C06179F;
        Sat,  9 Jan 2021 08:04:14 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id g185so11016242wmf.3;
        Sat, 09 Jan 2021 08:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4nXYxX9dbuWurmEc3HolnGHKsTnFoJzI5tkjJRNoql4=;
        b=QJ7SpezQUEwTiGipFEoNbCI2yi0aUPB+zDKB21I11Chcdr+lDmxoAYU4V4bAN0mWUv
         BVo89nY8B65l97+4OtJUpZQaNj4tnE+nLqWOI/Ndgxpev+XT6UklG97DEunraVHCbLg0
         yNmd0Fj1VkkitF0FuBAoSsvGkkRkJxObh4LKmuzBBpbtsAm0Af0gdY63nRJ2IDqZDUg1
         pVkDoiqKTe5mfDkgZdVIgcOXsEN+HgqYSbv0CsVz0auRnBlN/L7WwFmKJa6ATwIusLU0
         M96hVz7Wa9RXpxTOMWQvdlepLTjlTSgdZnA5OBVRy/WiebLYLgPFaa8mxz+8Y4m4HF0u
         /t1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4nXYxX9dbuWurmEc3HolnGHKsTnFoJzI5tkjJRNoql4=;
        b=ipZ3QINI30a+k7RM2fk9H8Q10PTxcymgMrxqYiCS29n+S2W0C/FIz2elSdI2g7kI51
         QtwNCw7rZ/Cb/vBafSmOrF+KB5EfUdijMFdjq8ylYOPa6f/oz09K4gZo0Q8vaFp2uhKW
         OPz8di+eYgBBqOiHMQm0Ef76944tBy3LjJHbsFASq9UWqIrjKx/ZD4wzVdMTetQjXaYI
         RDfUnqfxrGRgcnIzrMLVepcuj3afpi9YWoGIGhD31MRE6cTXubviWN0O1clXx9Db8ooq
         XfIRQioUS6iUx/Z3W2OtRyTpqec/Ff7DrNI97JzpueOLl3IX6NGVtNk0PBwKNCRp/RAs
         iL4A==
X-Gm-Message-State: AOAM533WYJU7XshpK74t3i0H3has5rE1Gmqf/Yx8n3DFCx/qCrLACOtV
        KJ5IgstB5ZA6QXiGo4BHdhhGTMoxeuJ0AQ==
X-Google-Smtp-Source: ABdhPJwfIMXxMAe3BSP/M2ADL9lwDIXmQZa4+CHcS1FIt4LSKjy9Aveek7QmF0zZTW3SsdT6SkqsMw==
X-Received: by 2002:a1c:7f8c:: with SMTP id a134mr7810978wmd.184.1610208253005;
        Sat, 09 Jan 2021 08:04:13 -0800 (PST)
Received: from localhost.localdomain ([185.69.144.125])
        by smtp.gmail.com with ESMTPSA id k1sm17766623wrn.46.2021.01.09.08.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jan 2021 08:04:12 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH] mm/filemap: don't revert iter on -EIOCBQUEUED
Date:   Sat,  9 Jan 2021 16:00:32 +0000
Message-Id: <f5247b60e7abbd2ff850cd108491f53a2e0c501a.1610207781.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently, if I/O is enqueued for async execution direct paths of
generic_file_{read,write}_iter() will always revert the iter. There are
no users expecting that, and that is also costly. Leave iterators as is
on -EIOCBQUEUED.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 mm/filemap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 5bc672d30143..2e1686e09425 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2633,7 +2633,8 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 			iocb->ki_pos += retval;
 			count -= retval;
 		}
-		iov_iter_revert(iter, count - iov_iter_count(iter));
+		if (retval != -EIOCBQUEUED)
+			iov_iter_revert(iter, count - iov_iter_count(iter));
 
 		/*
 		 * Btrfs can have a short DIO read if we encounter
@@ -3458,7 +3459,8 @@ generic_file_direct_write(struct kiocb *iocb, struct iov_iter *from)
 		}
 		iocb->ki_pos = pos;
 	}
-	iov_iter_revert(from, write_len - iov_iter_count(from));
+	if (written != -EIOCBQUEUED)
+		iov_iter_revert(from, write_len - iov_iter_count(from));
 out:
 	return written;
 }
-- 
2.24.0

