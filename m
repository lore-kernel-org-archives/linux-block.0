Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDAF9C432BE
	for <linux-block@archiver.kernel.org>; Wed,  1 Sep 2021 21:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC4C160F42
	for <linux-block@archiver.kernel.org>; Wed,  1 Sep 2021 21:01:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244663AbhIAVCw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Sep 2021 17:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239759AbhIAVCl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Sep 2021 17:02:41 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F020FC0617AD;
        Wed,  1 Sep 2021 14:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=xF9PVD7Ak7b7GuU3fNOPsWCRtdNWIk6mhEkq/XYjRic=; b=IIPX+4lgHPMvrA2kWbqHJjbvcO
        Og6N+aQ91JcErUj3gisaqoYlJpzMIxKNZN9Wpuhq3xsO9tTuVzfn+iCL/tvt/HzjFq/ivq07Ig0XT
        MCOOSWx1O2pGcHxt6qkScHqJZT1pKtJjPJQy6jjBUxu1oK2ATkt4qM2+L6dETjyLNE2k3GNZLsiGM
        TEI+8NPoQMC4Q+R+WEx41PvIHQRWRluMsZFLvSjaKneNeiLRu0mFN8jE/JurNBwqJIcDoJSVQHot0
        OEAFjW3wIh3/ieurXo93Wle7XQmI6ch24aZ/ZImvIln4KkvKm+Bej+6O1o5ocbCVL/aQaymiFOw3y
        +AvcMSlg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mLXLR-007LWL-Md; Wed, 01 Sep 2021 21:00:29 +0000
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
Subject: [PATCH 09/10] pf: add error handling support for add_disk()
Date:   Wed,  1 Sep 2021 14:00:27 -0700
Message-Id: <20210901210028.1750956-10-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210901210028.1750956-1-mcgrof@kernel.org>
References: <20210901210028.1750956-1-mcgrof@kernel.org>
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

