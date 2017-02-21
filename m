Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: Jon Derrick <jonathan.derrick@intel.com>
To: 
Subject: [PATCHv3 1/4] block/sed: Use ssize_t on atom parsers to return errors
Date: Tue, 21 Feb 2017 11:44:33 -0700
Message-Id: <1487702676-10658-2-git-send-email-jonathan.derrick@intel.com>
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

The short atom parser can return an errno from decoding but does not
currently return the error as a signed value. Convert all of the parsers
to ssize_t.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
Reviewed-by: Scott Bauer <scott.bauer@intel.com>
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


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
