Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B167EC433F5
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94F266101A
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 22:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237777AbhI0WFj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 18:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237829AbhI0WFU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 18:05:20 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32E77C0613EB;
        Mon, 27 Sep 2021 15:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=xF9PVD7Ak7b7GuU3fNOPsWCRtdNWIk6mhEkq/XYjRic=; b=FxboHMaYTcRPE6zSL8vDgOO6A1
        ZCQ+svz3/6fefs2Lhugt0Op+bLzO9Ihpq6RVFUUrAOCcQdsbZUPyuJFe8Hr+/aGTgEvWmXWEM8QT5
        OC81f0y4y/mjk8iXsaLmjmQ+Mfv4eXQW+8+dpCL33TiCeFDnVbQM1Hd8+8Vu4EHTYfnXjz79LEhC8
        FqHYGalj4UbkZE4F+apAdWMA+9bon9LkH0kzB8T1olRMvIYY3ye1qnjFAjWuHd6d+jk2lC8m8puJi
        C70TU3J3wPHgJS8n735wS9nVwvZnGKnwBALAkYCePhdYPwyD7z9L7nHiSxJpGZfHklm1In1nORh98
        xdgDNseQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUyhC-004UJr-N6; Mon, 27 Sep 2021 22:01:58 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk, bhelgaas@google.com, liushixin2@huawei.com,
        thunder.leizhen@huawei.com, lee.jones@linaro.org,
        geoff@infradead.org, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, jim@jtan.com, haris.iqbal@ionos.com,
        jinpu.wang@ionos.com, josh.h.morris@us.ibm.com,
        pjk1939@linux.ibm.com, tim@cyberelk.net, richard@nod.at,
        miquel.raynal@bootlin.com, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 09/10] pf: add error handling support for add_disk()
Date:   Mon, 27 Sep 2021 15:01:56 -0700
Message-Id: <20210927220157.1069658-10-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210927220157.1069658-1-mcgrof@kernel.org>
References: <20210927220157.1069658-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We never checked for errors on add_disk() as this function
returned void. Now that this is fixed, use the shiny new
error handling.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/paride/pf.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/paride/pf.c b/drivers/block/paride/pf.c
index f471d48a87bc..380d80e507c7 100644
--- a/drivers/block/paride/pf.c
+++ b/drivers/block/paride/pf.c
@@ -962,7 +962,9 @@ static int __init pf_init_unit(struct pf_unit *pf, bool autoprobe, int port,
 	if (pf_probe(pf))
 		goto out_pi_release;
 
-	add_disk(disk);
+	ret = add_disk(disk);
+	if (ret)
+		goto out_pi_release;
 	pf->present = 1;
 	return 0;
 
-- 
2.30.2

