Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: Jon Derrick <jonathan.derrick@intel.com>
To: 
Subject: [PATCHv3 2/4] block/sed: Add helper to qualify response tokens
Date: Tue, 21 Feb 2017 11:44:34 -0700
Message-Id: <1487702676-10658-3-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1487702676-10658-1-git-send-email-jonathan.derrick@intel.com>
References: <1487702676-10658-1-git-send-email-jonathan.derrick@intel.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@fb.com>, Rafael Antognolli <rafael.antognolli@intel.com>,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Jon Derrick <jonathan.derrick@intel.com>, Christoph Hellwig <hch@lst.de>,
 Scott Bauer <scott.bauer@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

Add helper which verifies the response token is valid and matches the
expected value. Merges token_type and response_get_token.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
Reviewed-by: Scott Bauer <scott.bauer@intel.com>
---
 block/sed-opal.c | 61 +++++++++++++++++++++++---------------------------------
 1 file changed, 25 insertions(+), 36 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 4675fd8..d3d6db2 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -662,48 +662,25 @@ static int cmd_finalize(struct opal_dev *cmd, u32 hsn, u32 tsn)
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
@@ -922,20 +899,32 @@ static u64 response_get_u64(const struct parsed_resp *resp, int n)
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


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
