Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3EFC3C553F;
	Wed, 15 Jul 2026 08:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784104513; cv=none; b=FnkcoEHvfvpzgmRnrTfV0SfMCfsVmO5jdLendOhBo3DVmhCZ6wqqebNzV7rqAemdqsg8Ze+mK+QX1qADsZ/kxORuNrglGM4lQBLDe6Q1x9lbRvl1wwl9fHGuPUoz29gVyBW2njqHCsdzgprhnsxLRhDCM0pSBhLq42YFVpV5Lek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784104513; c=relaxed/simple;
	bh=1kDYDnFY7sblk4XxBe+wQGbDMmAc27KMGqTRUB+7HQo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K78uHKlpvleXo6e/KvjBpwaLHkKts9kYD/3umvKLEzV1shuL4nmoDevJsPKKFA5Wrw0RcqsCQH6V5gY9shOB6QzUdRChZI2OkuBw1ikklZbKWVR4cE7on2LR8QxPdpUEMKMXMVdSvx3yvQe3oqLnTG9k8DnlI86nmUWZKNJ4Nxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowABXq844RldqLkZHGA--.7528S2;
	Wed, 15 Jul 2026 16:35:04 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: jonathan.derrick@linux.dev,
	axboe@kernel.dk
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Scott Bauer <scott.bauer@intel.com>
Subject: [PATCH] block: sed-opal: validate response token bounds
Date: Wed, 15 Jul 2026 16:35:04 +0800
Message-ID: <20260715083504.27022-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXq844RldqLkZHGA--.7528S2
X-Coremail-Antispam: 1UD129KBjvJXoWxur4UJFykGw4kurW7Cr1fCrg_yoWrKFyUp3
	ZxKw1rAFnrXF13trs3uF43X3W3Ka4xtFy8tFyfWa4SyFZxXw1ftF4FkFyv9FyUt393Jr18
	Jryjqr4q9r48XaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUDpnQUUU
	UU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The response parser validates that the complete subpacket fits in the
response buffer, but it does not validate that each token is contained
within the declared subpacket before parsing it. A short atom's numeric
payload can be consumed before the loop subtracts its declared length.
Medium and long atoms can read additional header bytes before there is
proof that those bytes remain in the subpacket. The parser also stores
token metadata in a fixed MAX_TOKS array without a capacity check.

Pass the current subpacket remainder to the variable-width atom parsers
and reject truncated headers and tokens. Reject a response with more
tokens than the parsed response can retain, and validate the declared
subpacket length against the supplied response size.

Fixes: 455a7b238cd6 ("block: Add Sed-opal library")
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 block/sed-opal.c | 49 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 40 insertions(+), 9 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 79b290d9458a..c0afd34f8e2f 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -936,12 +936,17 @@ static ssize_t response_parse_tiny(struct opal_resp_tok *tok,
 }
 
 static ssize_t response_parse_short(struct opal_resp_tok *tok,
-				    const u8 *pos)
+				    const u8 *pos, size_t remaining)
 {
 	tok->pos = pos;
 	tok->len = (pos[0] & SHORT_ATOM_LEN_MASK) + 1;
 	tok->width = OPAL_WIDTH_SHORT;
 
+	if (tok->len > remaining) {
+		pr_debug("Short atom exceeds response subpacket\n");
+		return -EINVAL;
+	}
+
 	if (pos[0] & SHORT_ATOM_BYTESTRING) {
 		tok->type = OPAL_DTA_TOKENID_BYTESTRING;
 	} else if (pos[0] & SHORT_ATOM_SIGNED) {
@@ -966,12 +971,22 @@ static ssize_t response_parse_short(struct opal_resp_tok *tok,
 }
 
 static ssize_t response_parse_medium(struct opal_resp_tok *tok,
-				     const u8 *pos)
+				     const u8 *pos, size_t remaining)
 {
+	if (remaining < 2) {
+		pr_debug("Truncated medium atom header\n");
+		return -EINVAL;
+	}
+
 	tok->pos = pos;
 	tok->len = (((pos[0] & MEDIUM_ATOM_LEN_MASK) << 8) | pos[1]) + 2;
 	tok->width = OPAL_WIDTH_MEDIUM;
 
+	if (tok->len > remaining) {
+		pr_debug("Medium atom exceeds response subpacket\n");
+		return -EINVAL;
+	}
+
 	if (pos[0] & MEDIUM_ATOM_BYTESTRING)
 		tok->type = OPAL_DTA_TOKENID_BYTESTRING;
 	else if (pos[0] & MEDIUM_ATOM_SIGNED)
@@ -983,12 +998,22 @@ static ssize_t response_parse_medium(struct opal_resp_tok *tok,
 }
 
 static ssize_t response_parse_long(struct opal_resp_tok *tok,
-				   const u8 *pos)
+				   const u8 *pos, size_t remaining)
 {
+	if (remaining < 4) {
+		pr_debug("Truncated long atom header\n");
+		return -EINVAL;
+	}
+
 	tok->pos = pos;
 	tok->len = ((pos[1] << 16) | (pos[2] << 8) | pos[3]) + 4;
 	tok->width = OPAL_WIDTH_LONG;
 
+	if (tok->len > remaining) {
+		pr_debug("Long atom exceeds response subpacket\n");
+		return -EINVAL;
+	}
+
 	if (pos[0] & LONG_ATOM_BYTESTRING)
 		tok->type = OPAL_DTA_TOKENID_BYTESTRING;
 	else if (pos[0] & LONG_ATOM_SIGNED)
@@ -1016,7 +1041,7 @@ static int response_parse(const u8 *buf, size_t length,
 	const struct opal_header *hdr;
 	struct opal_resp_tok *iter;
 	int num_entries = 0;
-	int total;
+	size_t total;
 	ssize_t token_length;
 	const u8 *pos;
 	u32 clen, plen, slen;
@@ -1027,6 +1052,9 @@ static int response_parse(const u8 *buf, size_t length,
 	if (!resp)
 		return -EFAULT;
 
+	if (length < sizeof(*hdr))
+		return -EINVAL;
+
 	hdr = (struct opal_header *)buf;
 	pos = buf;
 	pos += sizeof(*hdr);
@@ -1038,10 +1066,10 @@ static int response_parse(const u8 *buf, size_t length,
 		 clen, plen, slen);
 
 	if (clen == 0 || plen == 0 || slen == 0 ||
-	    slen > IO_BUFFER_LENGTH - sizeof(*hdr)) {
+	    slen > length - sizeof(*hdr)) {
 		pr_debug("Bad header length. cp: %u, pkt: %u, subpkt: %u\n",
 			 clen, plen, slen);
-		print_buffer(pos, sizeof(*hdr));
+		print_buffer(buf, sizeof(*hdr));
 		return -EINVAL;
 	}
 
@@ -1052,14 +1080,17 @@ static int response_parse(const u8 *buf, size_t length,
 	total = slen;
 	print_buffer(pos, total);
 	while (total > 0) {
+		if (iter == resp->toks + MAX_TOKS)
+			return -E2BIG;
+
 		if (pos[0] <= TINY_ATOM_BYTE) /* tiny atom */
 			token_length = response_parse_tiny(iter, pos);
 		else if (pos[0] <= SHORT_ATOM_BYTE) /* short atom */
-			token_length = response_parse_short(iter, pos);
+			token_length = response_parse_short(iter, pos, total);
 		else if (pos[0] <= MEDIUM_ATOM_BYTE) /* medium atom */
-			token_length = response_parse_medium(iter, pos);
+			token_length = response_parse_medium(iter, pos, total);
 		else if (pos[0] <= LONG_ATOM_BYTE) /* long atom */
-			token_length = response_parse_long(iter, pos);
+			token_length = response_parse_long(iter, pos, total);
 		else if (pos[0] == EMPTY_ATOM_BYTE) /* empty atom */
 			token_length = 1;
 		else /* TOKEN */
-- 
2.43.0

