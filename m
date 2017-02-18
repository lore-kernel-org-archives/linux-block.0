Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:42880 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751191AbdBRAAg (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2017 19:00:36 -0500
From: Jon Derrick <jonathan.derrick@intel.com>
Cc: Jon Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Scott Bauer <scott.bauer@intel.com>,
        Rafael Antognolli <rafael.antognolli@intel.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCHv2 1/5] block/sed: Use ssize_t on atom parsers to return errors
Date: Fri, 17 Feb 2017 17:00:25 -0700
Message-Id: <1487376029-22662-2-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1487376029-22662-1-git-send-email-jonathan.derrick@intel.com>
References: <1487376029-22662-1-git-send-email-jonathan.derrick@intel.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The short atom parser can return an errno from decoding but does not
currently return the error as a signed value. Convert all of the parsers
to ssize_t.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 block/sed-opal.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index d1c52ba..4675fd8 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -706,8 +706,8 @@ static enum opal_token response_get_token(const struct parsed_resp *resp,
 	return tok->pos[0];
 }
 
-static size_t response_parse_tiny(struct opal_resp_tok *tok,
-				  const u8 *pos)
+static ssize_t response_parse_tiny(struct opal_resp_tok *tok,
+				   const u8 *pos)
 {
 	tok->pos = pos;
 	tok->len = 1;
@@ -723,8 +723,8 @@ static size_t response_parse_tiny(struct opal_resp_tok *tok,
 	return tok->len;
 }
 
-static size_t response_parse_short(struct opal_resp_tok *tok,
-				   const u8 *pos)
+static ssize_t response_parse_short(struct opal_resp_tok *tok,
+				    const u8 *pos)
 {
 	tok->pos = pos;
 	tok->len = (pos[0] & SHORT_ATOM_LEN_MASK) + 1;
@@ -736,7 +736,7 @@ static size_t response_parse_short(struct opal_resp_tok *tok,
 		tok->type = OPAL_DTA_TOKENID_SINT;
 	} else {
 		u64 u_integer = 0;
-		int i, b = 0;
+		ssize_t i, b = 0;
 
 		tok->type = OPAL_DTA_TOKENID_UINT;
 		if (tok->len > 9) {
@@ -753,8 +753,8 @@ static size_t response_parse_short(struct opal_resp_tok *tok,
 	return tok->len;
 }
 
-static size_t response_parse_medium(struct opal_resp_tok *tok,
-				    const u8 *pos)
+static ssize_t response_parse_medium(struct opal_resp_tok *tok,
+				     const u8 *pos)
 {
 	tok->pos = pos;
 	tok->len = (((pos[0] & MEDIUM_ATOM_LEN_MASK) << 8) | pos[1]) + 2;
@@ -770,8 +770,8 @@ static size_t response_parse_medium(struct opal_resp_tok *tok,
 	return tok->len;
 }
 
-static size_t response_parse_long(struct opal_resp_tok *tok,
-				  const u8 *pos)
+static ssize_t response_parse_long(struct opal_resp_tok *tok,
+				   const u8 *pos)
 {
 	tok->pos = pos;
 	tok->len = ((pos[1] << 16) | (pos[2] << 8) | pos[3]) + 4;
@@ -787,8 +787,8 @@ static size_t response_parse_long(struct opal_resp_tok *tok,
 	return tok->len;
 }
 
-static size_t response_parse_token(struct opal_resp_tok *tok,
-				   const u8 *pos)
+static ssize_t response_parse_token(struct opal_resp_tok *tok,
+				    const u8 *pos)
 {
 	tok->pos = pos;
 	tok->len = 1;
@@ -805,7 +805,7 @@ static int response_parse(const u8 *buf, size_t length,
 	struct opal_resp_tok *iter;
 	int num_entries = 0;
 	int total;
-	size_t token_length;
+	ssize_t token_length;
 	const u8 *pos;
 
 	if (!buf)
@@ -851,8 +851,8 @@ static int response_parse(const u8 *buf, size_t length,
 		else /* TOKEN */
 			token_length = response_parse_token(iter, pos);
 
-		if (token_length == -EINVAL)
-			return -EINVAL;
+		if (token_length < 0)
+			return token_length;
 
 		pos += token_length;
 		total -= token_length;
-- 
1.8.3.1
