Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771D1C77B6C
	for <linux-block@archiver.kernel.org>; Wed,  5 Apr 2023 11:13:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237396AbjDELNx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Apr 2023 07:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237052AbjDELNv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2023 07:13:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088EE126
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 04:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680693189;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sIOO89eJaXtViGOssTxN/xKQuEBfeB9dmnZswKVtRCw=;
        b=LxYL6hbBMxZRjc5KPFMfdobdakkTN0WBv2JE0EmJttjUpmBaCxIeanEPyREqursDfQsJS8
        QNNILabbuGg6x1nKb/Or8l250VYyKsBr8ye+D2sD53ka6VuaigrPzSMOwbqWOBPp3EjH9l
        liFdNjyPZvT2p4pOFgx4f8+QMyjrSuU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-203-XXIHvfQdP2-UNCPXktAzgA-1; Wed, 05 Apr 2023 07:13:06 -0400
X-MC-Unique: XXIHvfQdP2-UNCPXktAzgA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 68AE2101A551;
        Wed,  5 Apr 2023 11:13:05 +0000 (UTC)
Received: from mrjust8.localdomain (unknown [10.43.17.42])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2A3544020C80;
        Wed,  5 Apr 2023 11:13:04 +0000 (UTC)
From:   Ondrej Kozina <okozina@redhat.com>
To:     linux-block@vger.kernel.org
Cc:     bluca@debian.org, gmazyland@gmail.com, axboe@kernel.dk,
        hch@infradead.org, brauner@kernel.org, jonathan.derrick@linux.dev,
        Ondrej Kozina <okozina@redhat.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 4/5] sed-opal: add helper to get multiple columns at once.
Date:   Wed,  5 Apr 2023 13:12:22 +0200
Message-Id: <20230405111223.272816-5-okozina@redhat.com>
In-Reply-To: <20230405111223.272816-1-okozina@redhat.com>
References: <20230322151604.401680-1-okozina@redhat.com>
 <20230405111223.272816-1-okozina@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Refactors current code querying single column to use the
new helper. Real multi column usage will be added later.

Signed-off-by: Ondrej Kozina <okozina@redhat.com>
Tested-by: Luca Boccassi <bluca@debian.org>
Tested-by: Milan Broz <gmazyland@gmail.com>
Acked-by: Christian Brauner <brauner@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/sed-opal.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 38cc02b708ac..b95560d9c5eb 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -1149,12 +1149,8 @@ static int finalize_and_send(struct opal_dev *dev, cont_fn cont)
 	return opal_send_recv(dev, cont);
 }
 
-/*
- * request @column from table @table on device @dev. On success, the column
- * data will be available in dev->resp->tok[4]
- */
-static int generic_get_column(struct opal_dev *dev, const u8 *table,
-			      u64 column)
+static int generic_get_columns(struct opal_dev *dev, const u8 *table,
+			       u64 start_column, u64 end_column)
 {
 	int err;
 
@@ -1164,12 +1160,12 @@ static int generic_get_column(struct opal_dev *dev, const u8 *table,
 
 	add_token_u8(&err, dev, OPAL_STARTNAME);
 	add_token_u8(&err, dev, OPAL_STARTCOLUMN);
-	add_token_u64(&err, dev, column);
+	add_token_u64(&err, dev, start_column);
 	add_token_u8(&err, dev, OPAL_ENDNAME);
 
 	add_token_u8(&err, dev, OPAL_STARTNAME);
 	add_token_u8(&err, dev, OPAL_ENDCOLUMN);
-	add_token_u64(&err, dev, column);
+	add_token_u64(&err, dev, end_column);
 	add_token_u8(&err, dev, OPAL_ENDNAME);
 
 	add_token_u8(&err, dev, OPAL_ENDLIST);
@@ -1180,6 +1176,16 @@ static int generic_get_column(struct opal_dev *dev, const u8 *table,
 	return finalize_and_send(dev, parse_and_check_status);
 }
 
+/*
+ * request @column from table @table on device @dev. On success, the column
+ * data will be available in dev->resp->tok[4]
+ */
+static int generic_get_column(struct opal_dev *dev, const u8 *table,
+			      u64 column)
+{
+	return generic_get_columns(dev, table, column, column);
+}
+
 /*
  * see TCG SAS 5.3.2.3 for a description of the available columns
  *
-- 
2.31.1

