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
Subject: [PATCHv4 3/4] block/sed: Check received header lengths
Date: Wed, 15 Feb 2017 14:45:56 -0700
Message-Id: <1487195159-12599-4-git-send-email-jonathan.derrick@intel.com>
In-Reply-To: <1487195159-12599-1-git-send-email-jonathan.derrick@intel.com>
References: <1487195159-12599-1-git-send-email-jonathan.derrick@intel.com>
List-ID: <linux-block@vger.kernel.org>

Add a buffer size check against discovery and response header lengths
before we loop over their buffers.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
Reviewed-by: Scott Bauer <scott.bauer@intel.com>
---
 block/sed-opal.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 00673cf..383d5d6 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -340,10 +340,17 @@ static int opal_discovery0_end(struct opal_dev *dev)
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
@@ -713,6 +720,7 @@ static int response_parse(const u8 *buf, size_t length,
 	int total;
 	ssize_t token_length;
 	const u8 *pos;
+	u32 clen, plen, slen;
 
 	if (!buf)
 		return -EFAULT;
@@ -724,17 +732,16 @@ static int response_parse(const u8 *buf, size_t length,
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
@@ -743,7 +750,7 @@ static int response_parse(const u8 *buf, size_t length,
 		return -EFAULT;
 
 	iter = resp->toks;
-	total = be32_to_cpu(hdr->subpkt.length);
+	total = slen;
 	print_buffer(pos, total);
 	while (total > 0) {
 		if (pos[0] <= TINY_ATOM_BYTE) /* tiny atom */
-- 
1.8.3.1
