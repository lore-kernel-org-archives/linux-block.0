Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:42880 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750918AbdBRAAh (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2017 19:00:37 -0500
From: Jon Derrick <jonathan.derrick@intel.com>
Cc: Jon Derrick <jonathan.derrick@intel.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Scott Bauer <scott.bauer@intel.com>,
        Rafael Antognolli <rafael.antognolli@intel.com>,
        Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: [PATCHv2 3/5] block/sed: Check received header lengths
Date: Fri, 17 Feb 2017 17:00:27 -0700
Message-Id: <1487376029-22662-4-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1487376029-22662-1-git-send-email-jonathan.derrick@intel.com>
References: <1487376029-22662-1-git-send-email-jonathan.derrick@intel.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Add a buffer size check against discovery and response header lengths
before we loop over their buffers.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 block/sed-opal.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index d3d6db2..4fc4d7b 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -411,10 +411,17 @@ static int opal_discovery0_end(struct opal_dev *dev)
 	const struct d0_header *hdr = (struct d0_header *)dev->resp;
 	const u8 *epos = dev->resp, *cpos = dev->resp;
 	u16 comid = 0;
+	u32 hlen = be32_to_cpu(hdr->length);
 
-	print_buffer(dev->resp, be32_to_cpu(hdr->length));
+	print_buffer(dev->resp, hlen);
 
-	epos += be32_to_cpu(hdr->length); /* end of buffer */
+	if (hlen > IO_BUFFER_LENGTH - sizeof(*hdr)) {
+		pr_warn("Discovery length overflows buffer (%zu+%u)/%u\n",
+			sizeof(*hdr), hlen, IO_BUFFER_LENGTH);
+		return -EFAULT;
+	}
+
+	epos += hlen; /* end of buffer */
 	cpos += sizeof(*hdr); /* current position on buffer */
 
 	while (cpos < epos && supported) {
@@ -784,6 +791,7 @@ static int response_parse(const u8 *buf, size_t length,
 	int total;
 	ssize_t token_length;
 	const u8 *pos;
+	u32 clen, plen, slen;
 
 	if (!buf)
 		return -EFAULT;
@@ -795,17 +803,16 @@ static int response_parse(const u8 *buf, size_t length,
 	pos = buf;
 	pos += sizeof(*hdr);
 
-	pr_debug("Response size: cp: %d, pkt: %d, subpkt: %d\n",
-		 be32_to_cpu(hdr->cp.length),
-		 be32_to_cpu(hdr->pkt.length),
-		 be32_to_cpu(hdr->subpkt.length));
-
-	if (hdr->cp.length == 0 || hdr->pkt.length == 0 ||
-	    hdr->subpkt.length == 0) {
-		pr_err("Bad header length. cp: %d, pkt: %d, subpkt: %d\n",
-		       be32_to_cpu(hdr->cp.length),
-		       be32_to_cpu(hdr->pkt.length),
-		       be32_to_cpu(hdr->subpkt.length));
+	clen = be32_to_cpu(hdr->cp.length);
+	plen = be32_to_cpu(hdr->pkt.length);
+	slen = be32_to_cpu(hdr->subpkt.length);
+	pr_debug("Response size: cp: %u, pkt: %u, subpkt: %u\n",
+		 clen, plen, slen);
+
+	if (clen == 0 || plen == 0 || slen == 0 ||
+	    slen > IO_BUFFER_LENGTH - sizeof(*hdr)) {
+		pr_err("Bad header length. cp: %u, pkt: %u, subpkt: %u\n",
+		       clen, plen, slen);
 		print_buffer(pos, sizeof(*hdr));
 		return -EINVAL;
 	}
@@ -814,7 +821,7 @@ static int response_parse(const u8 *buf, size_t length,
 		return -EFAULT;
 
 	iter = resp->toks;
-	total = be32_to_cpu(hdr->subpkt.length);
+	total = slen;
 	print_buffer(pos, total);
 	while (total > 0) {
 		if (pos[0] <= TINY_ATOM_BYTE) /* tiny atom */
-- 
1.8.3.1
