Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7467330B14;
	Fri, 14 Aug 2026 08:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786694678; cv=none; b=hv24QYWExn4M3PW7kMwsB0UTiZNdxhNmIIP3hgeYlbX3ltROuTSbP6aNvRqIBzd25JWdinVPxX5rhCAv9ErRvYZW8hy/mxaaj1OQ18868Dbs/LQDq9ykJkejI9UugtO0PMPLMXAImUa1r+Dj1rvscX82wXmVTR2+Ei8N9WCNGdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786694678; c=relaxed/simple;
	bh=u95HYD6XaLfHpXtWgf1LmANWJLtFZOWSd3+aicrI46Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WMrPfc9jmMyS1KeIOFzN3vGx1igAdAaqA2Xw/QbU3NXj6GtzNsNqYxxf6yCpAhSDRcqDSHh9DrILMprIOQuZl0Lvw4EIDkjvj5XuWlPWhVj3MsZHHtKPzliFdEcfyAoghU7CQDDQZsiyv+bR1YfkX4uH57UglOpqU5l0NDhtf94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-01 (Coremail) with SMTP id qwCowAA3DPAOzH5qIMueBQ--.61286S2;
	Fri, 14 Aug 2026 16:04:31 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Jonathan Derrick <jonathan.derrick@linux.dev>,
	Jens Axboe <axboe@kernel.dk>
Cc: Rafael Antognolli <rafael.antognolli@intel.com>,
	Scott Bauer <scott.bauer@intel.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH v2] block: sed-opal: validate response token bounds
Date: Fri, 14 Aug 2026 16:04:30 +0800
Message-ID: <20260814080430.22496-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAA3DPAOzH5qIMueBQ--.61286S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZr18KFyUAr13Gr48uF18AFb_yoW7Jr4fp3
	Z8Kw1rAFnrXF13tFs3uF4Sq3W5Ga4xtFy8tFyfWa4SyFZxXw1rtFWFkFyq9FyUt393Jr1x
	JrWjq3yq9r48XaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26r
	xl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8
	JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUj
	d-PUUUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The OPAL response parser checks the containing subpacket but does
not prove each variable-width token is within that subpacket before
reading its header or payload. It can also append beyond the fixed token
metadata array.

Pass the remaining subpacket length to atom parsers, validate every
header and token extent, check the declared subpacket length against the
supplied response, and reject responses with more than MAX_TOKS tokens.

Fixes: 455a7b238cd6 ("block: Add Sed-opal library")

Assisted-by: Codex:gpt-5
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v1: https://lore.kernel.org/all/20260715083504.27022-1-pengpeng@iscas.ac.cn/
- no source-code changes
- rebase on the current block sources and tighten the commit message
- add the coding-assistant disclosure

The token grammar and all parser reads were reviewed statically; no
malformed OPAL response was injected.

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
2.50.1 (Apple Git-155)

