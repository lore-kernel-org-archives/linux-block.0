Return-Path: <SRS0=PrCR=AE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DEEC433E0
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 14:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 877A820716
	for <linux-block@archiver.kernel.org>; Tue, 23 Jun 2020 14:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mykernel.net header.i=cgxu519@mykernel.net header.b="cc4nvwBF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732751AbgFWOWk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Jun 2020 10:22:40 -0400
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243]:17145 "EHLO
        sender2-op-o12.zoho.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732698AbgFWOWj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Jun 2020 10:22:39 -0400
X-Greylist: delayed 907 seconds by postgrey-1.27 at vger.kernel.org; Tue, 23 Jun 2020 10:22:39 EDT
ARC-Seal: i=1; a=rsa-sha256; t=1592921232; cv=none; 
        d=zoho.com.cn; s=zohoarc; 
        b=iO1hB5ACJj9KXkxi6OqKHEq9mDl5jmTDO4u9zCytdn4GmpOjmNdng8KBKqnHJKCxgi2SFmN/DadyhkBT1xTAzWn+5pohW0XuSdWgGCDQqKYUmb8ON4KRkFYwOdwWKdEzU2fkBdxmyntpUvh4sq6vfiQCz9hGYcbh9z5mnYvZai8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn; s=zohoarc; 
        t=1592921232; h=Cc:Date:From:Message-ID:Subject:To; 
        bh=+hk5zkj9PP9vjbq6BAp74mbz/t9OLFPJSJSKartuLu8=; 
        b=kce7oSgIHHlXfsiX/lpfrhIgXlcjFl5+4oIa8Z4VLtQo43+Zgx0GnDpDGp4ZNQjCLI3tVVhTzJSdho5x72ZI+YjfGl4e/vpz8mREe0XjrvVUISfhB/qp1E3u+BiyLAoEqD/oD9W0BOSiPf0VPAej+u+VXFRDbtYMB+sJ3YCvZqQ=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
        dkim=pass  header.i=mykernel.net;
        spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
        dmarc=pass header.from=<cgxu519@mykernel.net> header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1592921232;
        s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=+hk5zkj9PP9vjbq6BAp74mbz/t9OLFPJSJSKartuLu8=;
        b=cc4nvwBFxhFOonPmpgGas/i7zZENn7BRHSS0jv3HAZKHqKnuwdgVaocuV4Kqwubq
        nguAcNjpywI+38CC70Q0Yr8L3lm0Z9FmliFChBU9OqhoFUc3KKwPADUF6bw+Jv+NgVb
        OpPBs1NxS8WxZqOOBY82o5Yajz5rMJZHUNehQQTg=
Received: from localhost.localdomain (113.116.158.17 [113.116.158.17]) by mx.zoho.com.cn
        with SMTPS id 1592921230976578.9930700015988; Tue, 23 Jun 2020 22:07:10 +0800 (CST)
From:   Chengguang Xu <cgxu519@mykernel.net>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Chengguang Xu <cgxu519@mykernel.net>
Subject: [PATCH] block; release bip in a right way in error path
Date:   Tue, 23 Jun 2020 22:06:53 +0800
Message-Id: <20200623140653.4226-1-cgxu519@mykernel.net>
X-Mailer: git-send-email 2.17.2
X-ZohoCNMailClient: External
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Release bip using kfree() in error path when that was allocated
by kmalloc().

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 block/bio-integrity.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 23632a33ed39..538c8dc8840a 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -78,7 +78,11 @@ struct bio_integrity_payload *bio_integrity_alloc(struct bio *bio,
 
 	return bip;
 err:
-	mempool_free(bip, &bs->bio_integrity_pool);
+	if (bs && mempool_initialized(&bs->bio_integrity_pool))
+		mempool_free(bip, &bs->bio_integrity_pool);
+	else
+		kfree(bip);
+
 	return ERR_PTR(-ENOMEM);
 }
 EXPORT_SYMBOL(bio_integrity_alloc);
-- 
2.17.2

