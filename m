Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC53C433ED
	for <linux-block@archiver.kernel.org>; Tue,  4 May 2021 16:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3DFA613BC
	for <linux-block@archiver.kernel.org>; Tue,  4 May 2021 16:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbhEDQNj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 May 2021 12:13:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbhEDQNi (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 May 2021 12:13:38 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB9EC061761
        for <linux-block@vger.kernel.org>; Tue,  4 May 2021 09:12:42 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id h4so6485908lfv.0
        for <linux-block@vger.kernel.org>; Tue, 04 May 2021 09:12:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v4QtfaGRpyWEeOpttGEoGwuwCU8/+wjbWkEbFI1DKy8=;
        b=xNPTrT0PNqf0Qw8c+KbvpzqPpCjDtGX3yVuSHicPqaC8XNqkvk9DC4JEW/6vmsZWdk
         IpWLjIas9hI1O7Z9blr6mxKAdCS1fD5zDPZ0IznMT49CkoYaLTXnBiu0dkYIfvdO9bWP
         pqbem6g1S1atUD4fvQZfFaBE4WQstVoddK74imXD8sQae3XBJWvjLqRpSsJQB/nU9nYo
         hLAQImj7C1mHNAxgI6sHY1wBzkKi7yxDBvwN2r3BU20Z5a5U3AfIcrsPgbczgp0/4Ssj
         /lNeZw0/tCA2TaHeC1DrqDS/HkzmkwjPlW61RJB3O0Zajunv4H9xwiruNynIUPijYKLl
         /GTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v4QtfaGRpyWEeOpttGEoGwuwCU8/+wjbWkEbFI1DKy8=;
        b=YASUyTYcqBOHM7mRd4C5oI0Qmt9xeb66Soj46hsu2/1o9ayJ8wPbkFNrCfFcLfTsvT
         0jlxMu8mVv/963lCiZbgoLbbE/B+Q1wk6EORUDVyBE96tXj2jAk+TO2eUKnNjADDc5O4
         LCvnfzRJdxGmHAOwAzCP/21t82rbLz3Z7tPOvzbFM5Z/t/C14L3IgpxVq6/vJVLAWLtF
         dzc8J820dyoK5mSJ//atTXyUSAAk7VU6/6ziWunYKMaIctvaqzbUmcsUHF8aljkuDOhU
         91UfAv7f5i962pRT7tGmHUH0IqkIxn71TyAsMNt8gccbmeqwBnNsaftf9vIgzoQq6Aoe
         wCaQ==
X-Gm-Message-State: AOAM5307W8FU1jCF8KRMLG9pI5b2rDExbGBfXzxlPo5INb0uKAyH93Ee
        /AC4aMqHRjPg/KOeO59rAK/LkA==
X-Google-Smtp-Source: ABdhPJx1wt6VMGFLlriL4jaDRSlTuppXDkgOtyiEw05YgzMo9uI39oyIeRs69QNapeDY4v085rOv9A==
X-Received: by 2002:ac2:5e99:: with SMTP id b25mr6296576lfq.288.1620144760786;
        Tue, 04 May 2021 09:12:40 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-180-197.NA.cust.bahnhof.se. [98.128.180.197])
        by smtp.gmail.com with ESMTPSA id s20sm164193ljs.116.2021.05.04.09.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 09:12:39 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     linux-mmc@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/11] mmc: core: Extend re-use of __mmc_poll_for_busy()
Date:   Tue,  4 May 2021 18:12:15 +0200
Message-Id: <20210504161222.101536-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210504161222.101536-1-ulf.hansson@linaro.org>
References: <20210504161222.101536-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Via __mmc_poll_for_busy() we end up polling with the ->card_busy() host ops
or by sending the CMD13. To allow polling of different types, which is
needed to support a few new SD card features, let's rework the code around
__mmc_poll_for_busy() to make it more generic.

More precisely, let __mmc_poll_for_busy() take a pointer to a callback
function as in-parameter, which it calls to poll for busy state completion.
Additionally, let's share __mmc_poll_for_busy() to allow it to be re-used
outside of mmc_ops.c. Subsequent changes will make use of it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/core/core.c    |  2 +-
 drivers/mmc/core/mmc_ops.c | 42 ++++++++++++++++++++++++--------------
 drivers/mmc/core/mmc_ops.h |  5 ++++-
 3 files changed, 32 insertions(+), 17 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index b00c84ea8441..b039dcff17f8 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1671,7 +1671,7 @@ static int mmc_do_erase(struct mmc_card *card, unsigned int from,
 		goto out;
 
 	/* Let's poll to find out when the erase operation completes. */
-	err = mmc_poll_for_busy(card, busy_timeout, MMC_BUSY_ERASE);
+	err = mmc_poll_for_busy(card, busy_timeout, false, MMC_BUSY_ERASE);
 
 out:
 	mmc_retune_release(card->host);
diff --git a/drivers/mmc/core/mmc_ops.c b/drivers/mmc/core/mmc_ops.c
index ccaee1cb7ff5..653627fe02a3 100644
--- a/drivers/mmc/core/mmc_ops.c
+++ b/drivers/mmc/core/mmc_ops.c
@@ -53,6 +53,12 @@ static const u8 tuning_blk_pattern_8bit[] = {
 	0xff, 0x77, 0x77, 0xff, 0x77, 0xbb, 0xdd, 0xee,
 };
 
+struct mmc_busy_data {
+	struct mmc_card *card;
+	bool retry_crc_err;
+	enum mmc_busy_cmd busy_cmd;
+};
+
 int __mmc_send_status(struct mmc_card *card, u32 *status, unsigned int retries)
 {
 	int err;
@@ -424,10 +430,10 @@ int mmc_switch_status(struct mmc_card *card, bool crc_err_fatal)
 	return mmc_switch_status_error(card->host, status);
 }
 
-static int mmc_busy_status(struct mmc_card *card, bool retry_crc_err,
-			   enum mmc_busy_cmd busy_cmd, bool *busy)
+static int mmc_busy_cb(void *cb_data, bool *busy)
 {
-	struct mmc_host *host = card->host;
+	struct mmc_busy_data *data = cb_data;
+	struct mmc_host *host = data->card->host;
 	u32 status = 0;
 	int err;
 
@@ -436,17 +442,17 @@ static int mmc_busy_status(struct mmc_card *card, bool retry_crc_err,
 		return 0;
 	}
 
-	err = mmc_send_status(card, &status);
-	if (retry_crc_err && err == -EILSEQ) {
+	err = mmc_send_status(data->card, &status);
+	if (data->retry_crc_err && err == -EILSEQ) {
 		*busy = true;
 		return 0;
 	}
 	if (err)
 		return err;
 
-	switch (busy_cmd) {
+	switch (data->busy_cmd) {
 	case MMC_BUSY_CMD6:
-		err = mmc_switch_status_error(card->host, status);
+		err = mmc_switch_status_error(host, status);
 		break;
 	case MMC_BUSY_ERASE:
 		err = R1_STATUS(status) ? -EIO : 0;
@@ -464,8 +470,9 @@ static int mmc_busy_status(struct mmc_card *card, bool retry_crc_err,
 	return 0;
 }
 
-static int __mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
-			       bool retry_crc_err, enum mmc_busy_cmd busy_cmd)
+int __mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
+			int (*busy_cb)(void *cb_data, bool *busy),
+			void *cb_data)
 {
 	struct mmc_host *host = card->host;
 	int err;
@@ -482,7 +489,7 @@ static int __mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 		 */
 		expired = time_after(jiffies, timeout);
 
-		err = mmc_busy_status(card, retry_crc_err, busy_cmd, &busy);
+		err = (*busy_cb)(cb_data, &busy);
 		if (err)
 			return err;
 
@@ -505,9 +512,15 @@ static int __mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
 }
 
 int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
-		      enum mmc_busy_cmd busy_cmd)
+		      bool retry_crc_err, enum mmc_busy_cmd busy_cmd)
 {
-	return __mmc_poll_for_busy(card, timeout_ms, false, busy_cmd);
+	struct mmc_busy_data cb_data;
+
+	cb_data.card = card;
+	cb_data.retry_crc_err = retry_crc_err;
+	cb_data.busy_cmd = busy_cmd;
+
+	return __mmc_poll_for_busy(card, timeout_ms, &mmc_busy_cb, &cb_data);
 }
 
 bool mmc_prepare_busy_cmd(struct mmc_host *host, struct mmc_command *cmd,
@@ -591,8 +604,7 @@ int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 	}
 
 	/* Let's try to poll to find out when the command is completed. */
-	err = __mmc_poll_for_busy(card, timeout_ms, retry_crc_err,
-				  MMC_BUSY_CMD6);
+	err = mmc_poll_for_busy(card, timeout_ms, retry_crc_err, MMC_BUSY_CMD6);
 	if (err)
 		goto out;
 
@@ -840,7 +852,7 @@ static int mmc_send_hpi_cmd(struct mmc_card *card)
 		return 0;
 
 	/* Let's poll to find out when the HPI request completes. */
-	return mmc_poll_for_busy(card, busy_timeout_ms, MMC_BUSY_HPI);
+	return mmc_poll_for_busy(card, busy_timeout_ms, false, MMC_BUSY_HPI);
 }
 
 /**
diff --git a/drivers/mmc/core/mmc_ops.h b/drivers/mmc/core/mmc_ops.h
index ba898c435658..aca66c128804 100644
--- a/drivers/mmc/core/mmc_ops.h
+++ b/drivers/mmc/core/mmc_ops.h
@@ -38,8 +38,11 @@ int mmc_get_ext_csd(struct mmc_card *card, u8 **new_ext_csd);
 int mmc_switch_status(struct mmc_card *card, bool crc_err_fatal);
 bool mmc_prepare_busy_cmd(struct mmc_host *host, struct mmc_command *cmd,
 			  unsigned int timeout_ms);
+int __mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
+			int (*busy_cb)(void *cb_data, bool *busy),
+			void *cb_data);
 int mmc_poll_for_busy(struct mmc_card *card, unsigned int timeout_ms,
-		      enum mmc_busy_cmd busy_cmd);
+		      bool retry_crc_err, enum mmc_busy_cmd busy_cmd);
 int __mmc_switch(struct mmc_card *card, u8 set, u8 index, u8 value,
 		unsigned int timeout_ms, unsigned char timing,
 		bool send_status, bool retry_crc_err, unsigned int retries);
-- 
2.25.1

