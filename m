Return-Path: <SRS0=FZnh=BK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FACC433DF
	for <linux-block@archiver.kernel.org>; Fri, 31 Jul 2020 01:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F130F208E4
	for <linux-block@archiver.kernel.org>; Fri, 31 Jul 2020 01:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kJACQqxO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731085AbgGaBmn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jul 2020 21:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731064AbgGaBmn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jul 2020 21:42:43 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E197CC061574;
        Thu, 30 Jul 2020 18:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=7xnznT57paybRGNTfjq23CVGn2vEvJ96RH5mR+ZNIfg=; b=kJACQqxOIV6zlkUhSiDVh5psQn
        AaU7vVjNkjqRTCIjvJMcr5Dgs87vv+/QHlXQXBkFhy6iyIfvRAT1c9okkdrARnSL6OW4Sct00/Elb
        kgFwichpDlQ1hVNfK9jGQw7fO05TyJDFp4OYcbWYV6r4pameMTOYWdu5T7WKGnyHTnBYbjXTvO3bf
        awKhIqJGRDj4ICm5D1nsphBcKmjFUxKtQVxueGmawQZGATgjtN/sBeleoD59wwN116JVLvngL48rS
        ILZ9NWsUX0tj6TCD+TRDKK+feki2w+Dhm/eFml7Udo2KVsKM7PfJrjgwCMpZRdODITl7nzCENYYU6
        15m7bMiA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1K4G-0006bc-HK; Fri, 31 Jul 2020 01:42:41 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: [PATCH 1/7] block: bfq-iosched: fix duplicated word
Date:   Thu, 30 Jul 2020 18:42:27 -0700
Message-Id: <20200731014233.6418-2-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200731014233.6418-1-rdunlap@infradead.org>
References: <20200731014233.6418-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Change "at at" to "at a".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
---
 block/bfq-iosched.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200730.orig/block/bfq-iosched.c
+++ linux-next-20200730/block/bfq-iosched.c
@@ -4714,7 +4714,7 @@ static struct request *__bfq_dispatch_re
 	 * some unlucky request wait for as long as the device
 	 * wishes.
 	 *
-	 * Of course, serving one request at at time may cause loss of
+	 * Of course, serving one request at a time may cause loss of
 	 * throughput.
 	 */
 	if (bfqd->strict_guarantees && bfqd->rq_in_driver > 0)
