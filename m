Return-Path: <jonas.rabenstein@studium.uni-erlangen.de>
From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
	Scott Bauer <scott.bauer@intel.com>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] block: sed-opal: unify error handling of responses
Date: Tue, 13 Mar 2018 14:08:57 +0100
Message-Id: <04455788aa86e6d2e8cd09e24f64c23af5070c08.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
In-Reply-To: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
In-Reply-To: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
List-ID: <linux-block@vger.kernel.org>

Also response_get_token had already been in place, its functionality had
been duplicated within response_get_{u64,bytestring} with the same error
handling. Unify the handling by reusing response_get_token within the
other functions.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
 block/sed-opal.c | 28 ++++++++++------------------
 1 file changed, 10 insertions(+), 18 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 22dbea7cf4d1..5a448a3ba1df 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -698,6 +698,11 @@ static const struct opal_resp_tok *response_get_token(
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
@@ -883,18 +888,10 @@ static size_t response_get_string(const struct parsed_resp *resp, int n,
 	const struct opal_resp_tok *token;
 
 	*store = NULL;
-	if (!resp) {
-		pr_debug("Response is NULL\n");
+	token = response_get_token(resp, n);
+	if (IS_ERR(token))
 		return 0;
-	}
 
-	if (n > resp->num) {
-		pr_debug("Response has %d tokens. Can't access %d\n",
-			 resp->num, n);
-		return 0;
-	}
-
-	token = &resp->toks[n];
 	if (token->type != OPAL_DTA_TOKENID_BYTESTRING) {
 		pr_debug("Token is not a byte string!\n");
 		return 0;
@@ -922,16 +919,11 @@ static size_t response_get_string(const struct parsed_resp *resp, int n,
 
 static u64 response_get_u64(const struct parsed_resp *resp, int n)
 {
-	if (!resp) {
-		pr_debug("Response is NULL\n");
-		return 0;
-	}
+	const struct opal_resp_tok *token;
 
-	if (n > resp->num) {
-		pr_debug("Response has %d tokens. Can't access %d\n",
-			 resp->num, n);
+	token = response_get_token(resp, n);
+	if (IS_ERR(token))
 		return 0;
-	}
 
 	if (resp->toks[n].type != OPAL_DTA_TOKENID_UINT) {
 		pr_debug("Token is not unsigned it: %d\n",
-- 
2.16.1
