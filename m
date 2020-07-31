Return-Path: <SRS0=FZnh=BK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F92C433E0
	for <linux-block@archiver.kernel.org>; Fri, 31 Jul 2020 01:43:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB3F221744
	for <linux-block@archiver.kernel.org>; Fri, 31 Jul 2020 01:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t7N/7Kpw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbgGaBnM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Jul 2020 21:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731098AbgGaBmr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Jul 2020 21:42:47 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A600C061574;
        Thu, 30 Jul 2020 18:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=esxQlXFemcr0J9/J6h/Xl8BkBKuFSpvLIp+w4lZ9qpA=; b=t7N/7KpwTpq5qJx9LprrqN/Kf3
        Hrze9bqHB3RVdqPZScC522+mOAFrdjNwCQlrF4ZDQjU7U2NmSd9spXtTaXUhDdqz7+lASI07zQeRb
        +JxfQyhHOdsAKACK5E9HtFcpuQKqNygrIavrHINMuXV5t29AXBG7Zl6Y6Cx1xkSwmBo5azaDWPYzW
        K6eFxzD9lGGPBggVZnGFsLqVRoT6T94Iq/KpJBsamfc/l8PbeBaH58HxGdYJawM1I5omZXCzh7B5k
        wuKim94L11iAMn3PHqN5oHSL2VY7fWKkYcHbS7FFowaF0xsCjFovLijN4B2VIXRosgDQtNLqXyBHw
        f/89Fkrw==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1K4K-0006bc-Ps; Fri, 31 Jul 2020 01:42:45 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Subject: [PATCH 3/7] block: elevator: delete duplicated word and fix typos
Date:   Thu, 30 Jul 2020 18:42:29 -0700
Message-Id: <20200731014233.6418-4-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200731014233.6418-1-rdunlap@infradead.org>
References: <20200731014233.6418-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Drop the repeated word "the".
Fix typos of "features" and "specified".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
---
 block/elevator.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200730.orig/block/elevator.c
+++ linux-next-20200730/block/elevator.c
@@ -95,8 +95,8 @@ static inline bool elv_support_features(
  * @name: Elevator name to test
  * @required_features: Features that the elevator must provide
  *
- * Return true is the elevator @e name matches @name and if @e provides all the
- * the feratures spcified by @required_features.
+ * Return true if the elevator @e name matches @name and if @e provides all
+ * the features specified by @required_features.
  */
 static bool elevator_match(const struct elevator_type *e, const char *name,
 			   unsigned int required_features)
