Return-Path: <SRS0=xX0B=TR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FB2C04AB4
	for <linux-block@archiver.kernel.org>; Fri, 17 May 2019 09:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDA1020848
	for <linux-block@archiver.kernel.org>; Fri, 17 May 2019 09:17:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728890AbfEQJRg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 May 2019 05:17:36 -0400
Received: from smtpbgsg2.qq.com ([54.254.200.128]:36459 "EHLO smtpbgsg2.qq.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728169AbfEQJRg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 May 2019 05:17:36 -0400
X-QQ-mid: bizesmtp21t1558084358t8gy0j8q
Received: from localhost.localdomain (unknown [218.76.23.26])
        by esmtp6.qq.com (ESMTP) with 
        id ; Fri, 17 May 2019 17:12:33 +0800 (CST)
X-QQ-SSF: 01400000000000H0HH22C00A0000000
X-QQ-FEAT: vexvRNLUuMr5Q66tSBk2DGZhsfaetyyUqbNmf6ZbtxrufjF9LF47XGVxKjrnA
        orx9duMt1FujDCO82AHbqKGRJ9MwRKUXfaIbIM9NIw9ZVsbL0P38o05eiuY4aiSbYuWerNH
        Vqoa4PgCbJkXaAe47PUXDdimQSzsQ6vEYKPMOeKAezgvwf8NDdxsoqiRpsUXHAwBWD36+VV
        ekc/ALcMLIJwgSWtuliArpcxJxOv8HmUimO+DvQYX8yq8T1kbrl8XieMeAKQRT+nmMzlhz7
        vq9+fwujHBrSbMJYA3YjGLYghy0oKawAZ8ota7eDMH4jYdIPDHfE3TnkA7zfsbqv/sxg==
X-QQ-GoodBg: 2
From:   xiaolinkui <xiaolinkui@kylinos.cn>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaolinkui@kylinos.cn
Subject: [PATCH] block: bio: use struct_size() in kmalloc()
Date:   Fri, 17 May 2019 17:12:30 +0800
Message-Id: <1558084350-25632-1-git-send-email-xiaolinkui@kylinos.cn>
X-Mailer: git-send-email 2.7.4
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:kylinos.cn:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

One of the more common cases of allocation size calculations is finding
the size of a structure that has a zero-sized array at the end, along
with memory for some number of elements for that array. For example:

struct foo {
    int stuff;
    struct boo entry[];
};

instance = kmalloc(sizeof(struct foo) + count * sizeof(struct boo), GFP_KERNEL);

Instead of leaving these open-coded and prone to type mistakes, we can
now use the new struct_size() helper:

instance = kmalloc(struct_size(instance, entry, count), GFP_KERNEL);

Signed-off-by: xiaolinkui <xiaolinkui@kylinos.cn>
---
 block/bio.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 683cbb4..847ac60 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -436,9 +436,7 @@ struct bio *bio_alloc_bioset(gfp_t gfp_mask, unsigned int nr_iovecs,
 		if (nr_iovecs > UIO_MAXIOV)
 			return NULL;
 
-		p = kmalloc(sizeof(struct bio) +
-			    nr_iovecs * sizeof(struct bio_vec),
-			    gfp_mask);
+		p = kmalloc(struct_size(bio, bi_io_vec, nr_iovecs), gfp_mask);
 		front_pad = 0;
 		inline_vecs = nr_iovecs;
 	} else {
@@ -1120,8 +1118,7 @@ static struct bio_map_data *bio_alloc_map_data(struct iov_iter *data,
 	if (data->nr_segs > UIO_MAXIOV)
 		return NULL;
 
-	bmd = kmalloc(sizeof(struct bio_map_data) +
-		       sizeof(struct iovec) * data->nr_segs, gfp_mask);
+	bmd = kmalloc(struct_size(bmd, iov, data->nr_segs), gfp_mask);
 	if (!bmd)
 		return NULL;
 	memcpy(bmd->iov, data->iov, sizeof(struct iovec) * data->nr_segs);
-- 
2.7.4



