Return-Path: <SRS0=gXx0=YU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672CBCA9EAF
	for <linux-block@archiver.kernel.org>; Sun, 27 Oct 2019 19:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C4A20873
	for <linux-block@archiver.kernel.org>; Sun, 27 Oct 2019 19:11:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0vHA63/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfJ0TLR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Oct 2019 15:11:17 -0400
Received: from mail-wr1-f45.google.com ([209.85.221.45]:34493 "EHLO
        mail-wr1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726985AbfJ0TLR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Oct 2019 15:11:17 -0400
Received: by mail-wr1-f45.google.com with SMTP id t16so7664428wrr.1;
        Sun, 27 Oct 2019 12:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TNEcVi7ku8vocu9/kY2FV94MhPt0G4x9ifJKrP4Tqyc=;
        b=P0vHA63/9erXZF1K0ICq7vyJzxG/BBy8XJSMnrsPOZTnAQJ0yNC8L9aRPv4WTGrwsz
         3ryoqu7gaM/EyS4OJvX6s5o03F0ZgznCYrHJfJ3M+tmCtfKpG3GBDpS/fbCa5uS9IsX6
         LiLKQnTI55zbTgjklYKJQTk17lF+tGOwoQkxYND7fC7xn7Z73MBvVo6Mc58L78/o/fhb
         c6Wk7rKwyf413zZtwb59Rw0aJ5/RCCLYTDq7eqiKgiflePf26c8NKsmxw6VN9IdQs1iv
         TXZr0P6uExe79+m3TGsDB7u05VFzI/7Q6mOLd2x0ocopBWf4Tt9JDh4ua5GD0fWL7Jw3
         wUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TNEcVi7ku8vocu9/kY2FV94MhPt0G4x9ifJKrP4Tqyc=;
        b=AV7nUlY4dF4DdY1Eegt8CHFDHJ3uWi6QnF9S6+y36suHcNOjaziDonSTQqtWGM2Lw5
         atV61ZTKXZuBcM1r4Zsa2J64uYPrlZS44//hUbPE+Qm6O0xXPxqSfwPTaxXQlWUE+2wP
         mfpn71EkQFlR5D3+4FEfG8MMJpi5IawPQwGG76vhLlfYfBExZjXn40ON7w0caUvdF5Cn
         xWtWQhKPYfGDMW8wjXzVHVyI48kBjrDlKfzETIGBOC+TVSCnGfr7be+rKCGUQ8m0GF9f
         Xzwv4p3i9//LAi79EYnjED1wGuDSCTgkUsVLFj++mltRfha7X9S4dGRUfzCmxeLu3wXD
         Ipaw==
X-Gm-Message-State: APjAAAVKSvwHv0lv7rwaXq9KlhWx0ZgGhl1bwAqOpepjpZSqujPGUjyT
        vaqk+UVHvyKRo9+WA4/zEOU=
X-Google-Smtp-Source: APXvYqyzLdkk88bGeK8rK1E8aTvITHApFVJLiVf3CDiHvXqwdAa6L9qx+wM/mc2zuWXeAiNKKHfR0w==
X-Received: by 2002:adf:cf11:: with SMTP id o17mr11947103wrj.284.1572203475127;
        Sun, 27 Oct 2019 12:11:15 -0700 (PDT)
Received: from localhost.localdomain ([109.126.132.16])
        by smtp.gmail.com with ESMTPSA id l2sm6130488wrt.15.2019.10.27.12.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2019 12:11:14 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH][for-linus] io_uring: Fix leaked shadow_req
Date:   Sun, 27 Oct 2019 22:10:36 +0300
Message-Id: <47835fb780667714ba2d21e9a00fe69bc9bbef47.1572203348.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

io_queue_link_head() owns shadow_req after taking it as an argument.
By not freeing it in case of an error, it can leak the request along
with taken ctx->refs.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 fs/io_uring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index fa83ea2c16ee..5a48687c4efa 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2413,6 +2413,7 @@ static int io_queue_link_head(struct io_ring_ctx *ctx, struct io_kiocb *req,
 	if (ret) {
 		if (ret != -EIOCBQUEUED) {
 			io_free_req(req);
+			__io_free_req(shadow);
 			io_cqring_add_event(ctx, s->sqe->user_data, ret);
 			return 0;
 		}
-- 
2.23.0

