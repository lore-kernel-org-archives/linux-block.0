Return-Path: <jonas.rabenstein@studium.uni-erlangen.de>
From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
	Scott Bauer <scott.bauer@intel.com>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 04/11] block: sed-opal: unify error handling of responses
Date: Mon, 19 Mar 2018 19:36:46 +0100
Message-Id: <4a20f9848927d0f654491136e4821f2adab131cc.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
In-Reply-To: <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
References: <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
In-Reply-To: <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de> <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
List-ID: <linux-block@vger.kernel.org>

Also response_get_token had already been in place, its functionality had
been duplicated within response_get_{u64,bytestring} with the same error
handling. Unify the handling by reusing response_get_token within the
other functions.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>

diff --git a/block/sed-opal.c b/block/sed-opal.c
index efe5d2a7f3dc..30f6e46518a6 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -697,6 +697,11 @@ static const struct opal_resp_tok *response_get_token(
 {
 	const struct opal_resp_tok *tok;
 
+	if (!resp) {
+		pr_debug("Response is NULL\n");
+		return ERR_PTR(-EINVAL);
+	}
+
 	if (n >= resp->num) {
 		pr_debug("Token number doesn't exist: %d, resp: %d\n",
 			 n, resp->num);
@@ -879,27 +884,19 @@ static size_t response_get_string(const struct parsed_resp *resp, int n,
 				  const char **store)
 {
 	u8 skip;
-	const struct opal_resp_tok *token;
+	const struct opal_resp_tok *tok;
 
 	*store = NULL;
-	if (!resp) {
-		pr_debug("Response is NULL\n");
-		return 0;
-	}
-
-	if (n > resp->num) {
-		pr_debug("Response has %d tokens. Can't access %d\n",
-			 resp->num, n);
+	tok = response_get_token(resp, n);
+	if (IS_ERR(tok))
 		return 0;
-	}
 
-	token = &resp->toks[n];
-	if (token->type != OPAL_DTA_TOKENID_BYTESTRING) {
+	if (tok->type != OPAL_DTA_TOKENID_BYTESTRING) {
 		pr_debug("Token is not a byte string!\n");
 		return 0;
 	}
 
-	switch (token->width) {
+	switch (tok->width) {
 	case OPAL_WIDTH_TINY:
 	case OPAL_WIDTH_SHORT:
 		skip = 1;
@@ -915,37 +912,29 @@ static size_t response_get_string(const struct parsed_resp *resp, int n,
 		return 0;
 	}
 
-	*store = token->pos + skip;
-	return token->len - skip;
+	*store = tok->pos + skip;
+	return tok->len - skip;
 }
 
 static u64 response_get_u64(const struct parsed_resp *resp, int n)
 {
-	if (!resp) {
-		pr_debug("Response is NULL\n");
-		return 0;
-	}
+	const struct opal_resp_tok *tok;
 
-	if (n > resp->num) {
-		pr_debug("Response has %d tokens. Can't access %d\n",
-			 resp->num, n);
+	tok = response_get_token(resp, n);
+	if (IS_ERR(tok))
 		return 0;
-	}
 
-	if (resp->toks[n].type != OPAL_DTA_TOKENID_UINT) {
-		pr_debug("Token is not unsigned it: %d\n",
-			 resp->toks[n].type);
+	if (tok->type != OPAL_DTA_TOKENID_UINT) {
+		pr_debug("Token is not unsigned it: %d\n", tok->type);
 		return 0;
 	}
 
-	if (!(resp->toks[n].width == OPAL_WIDTH_TINY ||
-	      resp->toks[n].width == OPAL_WIDTH_SHORT)) {
-		pr_debug("Atom is not short or tiny: %d\n",
-			 resp->toks[n].width);
+	if (tok->width != OPAL_WIDTH_TINY && tok->width != OPAL_WIDTH_SHORT) {
+		pr_debug("Atom is not short or tiny: %d\n", tok->width);
 		return 0;
 	}
 
-	return resp->toks[n].stored.u;
+	return tok->stored.u;
 }
 
 static bool response_token_matches(const struct opal_resp_tok *token, u8 match)
-- 
2.16.1
