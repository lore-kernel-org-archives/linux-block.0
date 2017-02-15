Return-Path: <jonathan.derrick@intel.com>
From: Jon Derrick <jonathan.derrick@intel.com>
To: 
Cc: Jon Derrick <jonathan.derrick@intel.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Scott Bauer <scott.bauer@intel.com>,
	Rafael Antognolli <rafael.antognolli@intel.com>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCHv4 2/4] block/sed: Add helper to qualify response tokens
Date: Wed, 15 Feb 2017 14:45:55 -0700
Message-Id: <1487195159-12599-3-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1487195159-12599-1-git-send-email-jonathan.derrick@intel.com>
References: <1487195159-12599-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-block@vger.kernel.org>

Add helper which verifies the response token is valid and matches the
expected value. Merges token_type and response_get_token.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
Reviewed-by: Scott Bauer <scott.bauer@intel.com>
---
 block/sed-opal.c | 61 +++++++++++++++++++++++---------------------------------
 1 file changed, 25 insertions(+), 36 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 77623ad..00673cf 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -591,48 +591,25 @@ static int cmd_finalize(struct opal_dev *cmd, u32 hsn, u32 tsn)
 	return 0;
 }
 
-static enum opal_response_token token_type(const struct parsed_resp *resp,
-					   int n)
+static const struct opal_resp_tok *response_get_token(
+				const struct parsed_resp *resp,
+				int n)
 {
 	const struct opal_resp_tok *tok;
 
 	if (n >= resp->num) {
 		pr_err("Token number doesn't exist: %d, resp: %d\n",
 		       n, resp->num);
-		return OPAL_DTA_TOKENID_INVALID;
+		return ERR_PTR(-EINVAL);
 	}
 
 	tok = &resp->toks[n];
 	if (tok->len == 0) {
 		pr_err("Token length must be non-zero\n");
-		return OPAL_DTA_TOKENID_INVALID;
+		return ERR_PTR(-EINVAL);
 	}
 
-	return tok->type;
-}
-
-/*
- * This function returns 0 in case of invalid token. One should call
- * token_type() first to find out if the token is valid or not.
- */
-static enum opal_token response_get_token(const struct parsed_resp *resp,
-					  int n)
-{
-	const struct opal_resp_tok *tok;
-
-	if (n >= resp->num) {
-		pr_err("Token number doesn't exist: %d, resp: %d\n",
-		       n, resp->num);
-		return 0;
-	}
-
-	tok = &resp->toks[n];
-	if (tok->len == 0) {
-		pr_err("Token length must be non-zero\n");
-		return 0;
-	}
-
-	return tok->pos[0];
+	return tok;
 }
 
 static ssize_t response_parse_tiny(struct opal_resp_tok *tok,
@@ -851,20 +828,32 @@ static u64 response_get_u64(const struct parsed_resp *resp, int n)
 	return resp->toks[n].stored.u;
 }
 
+static bool response_token_matches(const struct opal_resp_tok *token, u8 match)
+{
+	if (IS_ERR(token) ||
+	    token->type != OPAL_DTA_TOKENID_TOKEN ||
+	    token->pos[0] != match)
+		return false;
+	return true;
+}
+
 static u8 response_status(const struct parsed_resp *resp)
 {
-	if (token_type(resp, 0) == OPAL_DTA_TOKENID_TOKEN &&
-	    response_get_token(resp, 0) == OPAL_ENDOFSESSION) {
+	const struct opal_resp_tok *tok;
+
+	tok = response_get_token(resp, 0);
+	if (response_token_matches(tok, OPAL_ENDOFSESSION))
 		return 0;
-	}
 
 	if (resp->num < 5)
 		return DTAERROR_NO_METHOD_STATUS;
 
-	if (token_type(resp, resp->num - 1) != OPAL_DTA_TOKENID_TOKEN ||
-	    token_type(resp, resp->num - 5) != OPAL_DTA_TOKENID_TOKEN ||
-	    response_get_token(resp, resp->num - 1) != OPAL_ENDLIST ||
-	    response_get_token(resp, resp->num - 5) != OPAL_STARTLIST)
+	tok = response_get_token(resp, resp->num - 5);
+	if (!response_token_matches(tok, OPAL_STARTLIST))
+		return DTAERROR_NO_METHOD_STATUS;
+
+	tok = response_get_token(resp, resp->num - 1);
+	if (!response_token_matches(tok, OPAL_ENDLIST))
 		return DTAERROR_NO_METHOD_STATUS;
 
 	return response_get_u64(resp, resp->num - 4);
-- 
1.8.3.1
