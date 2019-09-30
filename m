Return-Path: <SRS0=9W5b=XZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04330C4360C
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 02:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0E902082F
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 02:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3iz1f+P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfI3Ce2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Sep 2019 22:34:28 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:34336 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729386AbfI3Ce1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Sep 2019 22:34:27 -0400
Received: by mail-io1-f68.google.com with SMTP id q1so34215367ion.1;
        Sun, 29 Sep 2019 19:34:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YmFhd6XAHDu+fEWlTBA7FA5DXXWrGeJrfMLGeEjdf4w=;
        b=b3iz1f+PSVaat04xn9ki3//MH3GfrI+IF/0VfvPaiWfXDmkzyCy8JWGa8b6NY05CRV
         q7iA90v2+UNhzNglTO9tcYp9VpQ9CE3tW83irrRMj1+D6A9S6WzOgnz1cJ6cPbNg4eMp
         VN5fvdtO8Zj9cGRDvbsj3kbLmqrt0SqP0c6QSeJUeGhrWvFa3YOAI261RfRjGDGUelQD
         fTlR7Y2w+v2Ql7cNAzt2ht65p196+kFTirKPUF2fWISKm9klm/n3ATjLdEmGrlqpahnd
         YjlwtZowLXJaLHJhJ4EOH4GPWazgPaJshSZlmQRAJWrqLjJLEdcdcVc4K0IPEd47SSxr
         nVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YmFhd6XAHDu+fEWlTBA7FA5DXXWrGeJrfMLGeEjdf4w=;
        b=K1xRXkNo8vSLF9oqAv/qeMZ3teWPPYJoDJGp+/ASUAOrcGNnIU309VM9Dko+Rth7WB
         UFRs+3VXZxgDmJXQhHBS+ITXj3wJ9Gfq4VJnvq5CLPdBkpZHpb05Yw7gXRUwpkYaV7Fm
         fF9xe/Mnmvf4rscq9y5kN72cdzEeTsfollsL4vs3tUFDAw4yCTW5TJ3OMcsTOIV9cNaQ
         QAlLYbx6PWViU1DPZRmgViVk0LNwnZy7mW/YBPwSLet0aCJpPMSqeIBcdufZjFMZ2H6C
         C4CSt8imwK/RsYso2Wf4Ni3DVLQJdg8vsyaSzhZfJNwyanpt0zovqITXomS8daYX25le
         mydQ==
X-Gm-Message-State: APjAAAXlIBmDn6ydIoaxx4IDIhEv1Wclzr8vww3ExGloQJISvUqwF7OY
        1qTfgGScWo823X3h25/DYUFY79Z/1Oo=
X-Google-Smtp-Source: APXvYqyedH4c/EmSZe42RT8dzB9J83Bl+7REqbS6Iy62dZc4Hs+mkXrtOkD3nuXZF5/J03sv00mUbw==
X-Received: by 2002:a92:8c9a:: with SMTP id s26mr18297659ill.236.1569810866989;
        Sun, 29 Sep 2019 19:34:26 -0700 (PDT)
Received: from cs-dulles.cs.umn.edu (cs-dulles.cs.umn.edu. [128.101.35.54])
        by smtp.googlemail.com with ESMTPSA id m11sm4460199ioj.88.2019.09.29.19.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 19:34:26 -0700 (PDT)
From:   Navid Emamdoost <navid.emamdoost@gmail.com>
Cc:     emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu,
        Navid Emamdoost <navid.emamdoost@gmail.com>,
        Matias Bjorling <mb@lightnvm.io>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lightnvm: prevent memory leak in nvm_bb_chunk_sense
Date:   Sun, 29 Sep 2019 21:34:14 -0500
Message-Id: <20190930023415.24171-1-navid.emamdoost@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In nvm_bb_chunk_sense alloc_page allocates memory which is released at
the end of the function. But if nvm_submit_io_sync_raw fails the error
check skips the release and leaks the allocated page. To fix this issue
I moved the __free_page call before error check.

Fixes: aff3fb18f957 ("lightnvm: move bad block and chunk state logic to core")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/lightnvm/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/lightnvm/core.c b/drivers/lightnvm/core.c
index 7543e395a2c6..5fdae518f6c9 100644
--- a/drivers/lightnvm/core.c
+++ b/drivers/lightnvm/core.c
@@ -849,11 +849,12 @@ static int nvm_bb_chunk_sense(struct nvm_dev *dev, struct ppa_addr ppa)
 	rqd.ppa_addr = generic_to_dev_addr(dev, ppa);
 
 	ret = nvm_submit_io_sync_raw(dev, &rqd);
-	if (ret)
-		return ret;
 
 	__free_page(page);
 
+	if (ret)
+		return ret;
+
 	return rqd.error;
 }
 
-- 
2.17.1

