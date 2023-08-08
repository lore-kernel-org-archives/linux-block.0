Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8B9C04A94
	for <linux-block@archiver.kernel.org>; Tue,  8 Aug 2023 18:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235353AbjHHSKq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Aug 2023 14:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbjHHSKQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Aug 2023 14:10:16 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224CB160AF0
        for <linux-block@vger.kernel.org>; Tue,  8 Aug 2023 10:13:16 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id ca18e2360f4ac-77dcff76e35so58083039f.1
        for <linux-block@vger.kernel.org>; Tue, 08 Aug 2023 10:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1691514795; x=1692119595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1xgdjvkQxVijWbFpP8uJhM1tLO0HBMYe1Rp9T5j7G4o=;
        b=3L68oROO6/P+x4DieRmyILLhNDjO4Pbz+rBQrf/yei5wsAV419xuIZykv6sG9WMlc1
         CzZGwOSa+nM3NQipZ7rAL8n2YtcHS+vNDqdEycGqYS0JYxw0U8wY85LzXWcypwVI/ikM
         0sJu5pKhBH28TpaNoGH2nKWTwJwfCrYRVJqWMqZ7zcjHgyqz0zxyKYpVSwu8CVLU7vB6
         lu5xo5N1e4nrKAbWJDA0CQRTn7TrZG9CQaMuizArukbUyuTswxLwbXR63QSBY0Xs0ZiO
         MJQaI8Y8NTUJPJm5Z3aWo9ZVolNMKHFSKXPfKm7aIX+cFK+Hto8J9jX+Jn3ZAJXZMUgp
         5Q6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691514795; x=1692119595;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1xgdjvkQxVijWbFpP8uJhM1tLO0HBMYe1Rp9T5j7G4o=;
        b=UpAFN+29kpAqWOxwr8MFa8ldYf9JVCzEpr2M9K/kIHsnddGZ3AxIRm48EftgiwUqBP
         2pd4cK/eOPbPMhtwmnQaJt8QnUVtKojmUJKFx91jgtRYOJ3z2VKU5s7anreopPgx3SJW
         DNky6ArOboczuwKTaAo5quwU5hS8h5DRd7G7PAefAVRM8NGOJEqVDMb7I47LCbg7SJ+T
         TjMpRubb3987hTiST16AZRigTRuOl3TvAAW6s8C669QOrUOzG0XVIMrzujlm/6lDr/5n
         U/lVazYUBJGq7fByvwbDKX3bLRMdYh76FFGliQlzuCsEwi/rB2L2G1R5PoNmqzHR7Rbv
         Panw==
X-Gm-Message-State: AOJu0Yye788yUJiLJV+ezIzANh7DwXlcOYh18mC6PD1p5JF8kq5g+QkM
        VWnuJ+yRnWaopLIo8UXNFr0ld9TS5bu+mP5PxHE=
X-Google-Smtp-Source: AGHT+IEYMMnRodJXQspV16SzXsFP8YixEwcE0qefwrXya/rqm2XTZNfimho6EZOT58TJMEQOu8/3nQ==
X-Received: by 2002:a6b:1490:0:b0:790:958e:a667 with SMTP id 138-20020a6b1490000000b00790958ea667mr296825iou.2.1691514795091;
        Tue, 08 Aug 2023 10:13:15 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id r25-20020a02c859000000b0042afec5be53sm3222955jao.153.2023.08.08.10.13.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 10:13:14 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/2] block: don't make REQ_POLLED imply REQ_NOWAIT
Date:   Tue,  8 Aug 2023 11:13:10 -0600
Message-Id: <20230808171310.112878-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230808171310.112878-1-axboe@kernel.dk>
References: <20230808171310.112878-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Normally these two flags do go together, as the issuer of polled IO
generally cannot wait for resources that will get freed as part of IO
completion. This is because that very task is the one that will complete
the request and free those resources, hence that would introduce a
deadlock.

But it is possible to have someone else issue the polled IO, eg via
io_uring if the request is punted to io-wq. For that case, it's fine to
have the task block on IO submission, as it is not the same task that
will be completing the IO.

It's completely up to the caller to ask for both polled and nowait IO
separately! If we don't allow polled IO where IOCB_NOWAIT isn't set in
the kiocb, then we can run into repeated -EAGAIN submissions and not
make any progress.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/bio.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index c4f5b5228105..11984ed29cb8 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -791,7 +791,7 @@ static inline int bio_integrity_add_page(struct bio *bio, struct page *page,
 static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
 {
 	bio->bi_opf |= REQ_POLLED;
-	if (!is_sync_kiocb(kiocb))
+	if (kiocb->ki_flags & IOCB_NOWAIT)
 		bio->bi_opf |= REQ_NOWAIT;
 }
 
-- 
2.40.1

