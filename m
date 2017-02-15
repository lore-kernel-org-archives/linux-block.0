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
Subject: [PATCHv3 1/4] block/sed: Use ssize_t on atom parsers to return errors
Date: Wed, 15 Feb 2017 12:42:06 -0700
Message-Id: <1487187731-10293-2-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1487187731-10293-1-git-send-email-jonathan.derrick@intel.com>
References: <1487187731-10293-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-block@vger.kernel.org>

The short atom parser can return an errno from decoding but does not
currently return the error as a signed value. Convert all of the parsers
to ssize_t.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 block/sed-opal.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index e95b8a5..77623ad 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -635,8 +635,8 @@ static enum opal_token response_get_token(const struct parsed_resp *resp,
 	return tok->pos[0];
 }
 
-static size_t response_parse_tiny(struct opal_resp_tok *tok,
-				  const u8 *pos)
+static ssize_t response_parse_tiny(struct opal_resp_tok *tok,
+				   const u8 *pos)
 {
 	tok->pos = pos;
 	tok->len = 1;
@@ -652,8 +652,8 @@ static size_t response_parse_tiny(struct opal_resp_tok *tok,
 	return tok->len;
 }
 
-static size_t response_parse_short(struct opal_resp_tok *tok,
-				   const u8 *pos)
+static ssize_t response_parse_short(struct opal_resp_tok *tok,
+				    const u8 *pos)
 {
 	tok->pos = pos;
 	tok->len = (pos[0] & SHORT_ATOM_LEN_MASK) + 1;
@@ -665,7 +665,7 @@ static size_t response_parse_short(struct opal_resp_tok *tok,
 		tok->type = OPAL_DTA_TOKENID_SINT;
 	} else {
 		u64 u_integer = 0;
-		int i, b = 0;
+		ssize_t i, b = 0;
 
 		tok->type = OPAL_DTA_TOKENID_UINT;
 		if (tok->len > 9) {
@@ -682,8 +682,8 @@ static size_t response_parse_short(struct opal_resp_tok *tok,
 	return tok->len;
 }
 
-static size_t response_parse_medium(struct opal_resp_tok *tok,
-				    const u8 *pos)
+static ssize_t response_parse_medium(struct opal_resp_tok *tok,
+				     const u8 *pos)
 {
 	tok->pos = pos;
 	tok->len = (((pos[0] & MEDIUM_ATOM_LEN_MASK) << 8) | pos[1]) + 2;
@@ -699,8 +699,8 @@ static size_t response_parse_medium(struct opal_resp_tok *tok,
 	return tok->len;
 }
 
-static size_t response_parse_long(struct opal_resp_tok *tok,
-				  const u8 *pos)
+static ssize_t response_parse_long(struct opal_resp_tok *tok,
+				   const u8 *pos)
 {
 	tok->pos = pos;
 	tok->len = ((pos[1] << 16) | (pos[2] << 8) | pos[3]) + 4;
@@ -716,8 +716,8 @@ static size_t response_parse_long(struct opal_resp_tok *tok,
 	return tok->len;
 }
 
-static size_t response_parse_token(struct opal_resp_tok *tok,
-				   const u8 *pos)
+static ssize_t response_parse_token(struct opal_resp_tok *tok,
+				    const u8 *pos)
 {
 	tok->pos = pos;
 	tok->len = 1;
@@ -734,7 +734,7 @@ static int response_parse(const u8 *buf, size_t length,
 	struct opal_resp_tok *iter;
 	int num_entries = 0;
 	int total;
-	size_t token_length;
+	ssize_t token_length;
 	const u8 *pos;
 
 	if (!buf)
@@ -780,8 +780,8 @@ static int response_parse(const u8 *buf, size_t length,
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
