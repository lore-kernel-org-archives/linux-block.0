Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC3D15FA73
	for <linux-block@vger.kernel.org>; Tue,  9 Jul 2024 13:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720530260; cv=none; b=qo3W3vBoa5aMU2TGCATEgaiceZMh0qvRs14w6rdc6ydruQU+iKUBO7nNjYK1BU3pKr5vVV5SxhEDz1OmL5YmFsu8gjCyLJr2zUQI4PgVgVuf9yz0N3SEn/99Bhy5h/VTFjc3A7zBRcFNB/mc7AEdCqMFtzyNjAVQPc06LsCkTEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720530260; c=relaxed/simple;
	bh=hvhpy66Gc8oejRX39juQpQFCclZDEUiL26OSBUg4mZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fXyqPbWsEZxmbA2KvW43yrY5OfQHPxgAlfV2cIEvYd8TpjGJiOVewYJn7fO2gx4KhamOmG3KVayNlB3s4SK+31Nz9xlHw/c18LPJDdiOPYHH3E2KmST5NLG4jcD2gVI7yury1ZpNXce/FfKVwPTS+pjSFGp0rwAeDdehLziq/fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YI6thhKT; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YI6thhKT"
X-Envelope-To: axboe@kernel.dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1720530257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xfVUwPRPdY2A+8L+N0xioepstag5VyQiEpJ3XEOu87A=;
	b=YI6thhKTugepeStXCE0hzsFOYKlB4zXoqzBkf7qS+awMcFu5QxtlJW6afy9rS71Xj4XOBs
	Uybh0C+m3YHO0WZpTpjIfD1ljPHnTDDPrGy84ryVwzZFvsrYDVU0g5PMSPL/xcYes04l6N
	BWiTvn0wlq4hrAJnxoNEnZeSqM8D7rI=
X-Envelope-To: dan.j.williams@intel.com
X-Envelope-To: gregory.price@memverge.com
X-Envelope-To: john@groves.net
X-Envelope-To: jonathan.cameron@huawei.com
X-Envelope-To: bbhushan2@marvell.com
X-Envelope-To: chaitanyak@nvidia.com
X-Envelope-To: rdunlap@infradead.org
X-Envelope-To: linux-block@vger.kernel.org
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: linux-cxl@vger.kernel.org
X-Envelope-To: dongsheng.yang@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Dongsheng Yang <dongsheng.yang@linux.dev>
To: axboe@kernel.dk,
	dan.j.williams@intel.com,
	gregory.price@memverge.com,
	John@groves.net,
	Jonathan.Cameron@Huawei.com,
	bbhushan2@marvell.com,
	chaitanyak@nvidia.com,
	rdunlap@infradead.org
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Dongsheng Yang <dongsheng.yang@linux.dev>
Subject: [PATCH v1 4/7] cbd: introduce cbd_channel
Date: Tue,  9 Jul 2024 13:03:40 +0000
Message-Id: <20240709130343.858363-5-dongsheng.yang@linux.dev>
In-Reply-To: <20240709130343.858363-1-dongsheng.yang@linux.dev>
References: <20240709130343.858363-1-dongsheng.yang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The "cbd_channel" is the component responsible for the interaction
between the blkdev and the backend. It mainly provides the functions
"cbdc_copy_to_bio", "cbdc_copy_from_bio" and "cbd_channel_crc"

If the blkdev or backend is alive, that means there is active
user for this channel, then channel is alive.

Signed-off-by: Dongsheng Yang <dongsheng.yang@linux.dev>
---
 drivers/block/cbd/cbd_channel.c | 153 ++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)
 create mode 100644 drivers/block/cbd/cbd_channel.c

diff --git a/drivers/block/cbd/cbd_channel.c b/drivers/block/cbd/cbd_channel.c
new file mode 100644
index 000000000000..9a63e98b0c13
--- /dev/null
+++ b/drivers/block/cbd/cbd_channel.c
@@ -0,0 +1,153 @@
+#include "cbd_internal.h"
+
+static void channel_format(struct cbd_transport *cbdt, u32 id)
+{
+	struct cbd_channel_info *channel_info = cbdt_get_channel_info(cbdt, id);
+
+	cbdt_zero_range(cbdt, channel_info, CBDC_META_SIZE);
+}
+
+int cbd_get_empty_channel_id(struct cbd_transport *cbdt, u32 *id)
+{
+	int ret;
+
+	ret = cbdt_get_empty_segment_id(cbdt, id);
+	if (ret)
+		return ret;
+
+	channel_format(cbdt, *id);
+
+	return 0;
+}
+
+void cbdc_copy_to_bio(struct cbd_channel *channel,
+		u64 data_off, u32 data_len, struct bio *bio)
+{
+	struct bio_vec bv;
+	struct bvec_iter iter;
+	void *src, *dst;
+	u64 data_head = data_off;
+	u32 to_copy, page_off = 0;
+
+next:
+	bio_for_each_segment(bv, bio, iter) {
+		dst = kmap_local_page(bv.bv_page);
+		page_off = bv.bv_offset;
+again:
+		if (data_head >= CBDC_DATA_SIZE)
+			data_head %= CBDC_DATA_SIZE;
+
+		flush_dcache_page(bv.bv_page);
+		src = channel->data + data_head;
+		to_copy = min(bv.bv_offset + bv.bv_len - page_off,
+			      CBDC_DATA_SIZE - data_head);
+		memcpy_flushcache(dst + page_off, src, to_copy);
+
+		/* advance */
+		data_head += to_copy;
+		page_off += to_copy;
+
+		/* more data in this bv page */
+		if (page_off < bv.bv_offset + bv.bv_len)
+			goto again;
+		kunmap_local(dst);
+	}
+
+	if (bio->bi_next) {
+		bio = bio->bi_next;
+		goto next;
+	}
+}
+
+void cbdc_copy_from_bio(struct cbd_channel *channel,
+		u64 data_off, u32 data_len, struct bio *bio)
+{
+	struct bio_vec bv;
+	struct bvec_iter iter;
+	void *src, *dst;
+	u64 data_head = data_off;
+	u32 to_copy, page_off = 0;
+
+next:
+	bio_for_each_segment(bv, bio, iter) {
+		src = kmap_local_page(bv.bv_page);
+		page_off = bv.bv_offset;
+again:
+		if (data_head >= CBDC_DATA_SIZE)
+			data_head %= CBDC_DATA_SIZE;
+
+		dst = channel->data + data_head;
+		to_copy = min(bv.bv_offset + bv.bv_len - page_off,
+			      CBDC_DATA_SIZE - data_head);
+
+		memcpy_flushcache(dst, src + page_off, to_copy);
+		flush_dcache_page(bv.bv_page);
+
+		/* advance */
+		data_head += to_copy;
+		page_off += to_copy;
+
+		/* more data in this bv page */
+		if (page_off < bv.bv_offset + bv.bv_len)
+			goto again;
+		kunmap_local(src);
+	}
+
+	if (bio->bi_next) {
+		bio = bio->bi_next;
+		goto next;
+	}
+}
+
+u32 cbd_channel_crc(struct cbd_channel *channel, u64 data_off, u32 data_len)
+{
+	u32 crc = 0;
+	u32 crc_size;
+	u64 data_head = data_off;
+
+	while (data_len) {
+		if (data_head >= CBDC_DATA_SIZE)
+			data_head %= CBDC_DATA_SIZE;
+
+		crc_size = min(CBDC_DATA_SIZE - data_head, data_len);
+
+		crc = crc32(crc, channel->data + data_head, crc_size);
+
+		data_len -= crc_size;
+		data_head += crc_size;
+	}
+
+	return crc;
+}
+
+ssize_t cbd_channel_seg_detail_show(struct cbd_channel_info *channel_info, char *buf)
+{
+	return sprintf(buf, "channel backend id: %u\n"
+			"channel blkdev id: %u\n",
+			channel_info->backend_id,
+			channel_info->blkdev_id);
+}
+
+
+void cbd_channel_init(struct cbd_channel *channel, struct cbd_transport *cbdt, u32 seg_id)
+{
+	struct cbd_channel_info *channel_info = cbdt_get_channel_info(cbdt, seg_id);
+
+	cbd_segment_init(&channel->segment, cbdt, seg_id);
+
+	channel->cbdt = cbdt;
+	channel->channel_info = channel_info;
+	channel->seg_id = seg_id;
+	channel->submr = (void *)channel_info + CBDC_SUBMR_OFF;
+	channel->compr = (void *)channel_info + CBDC_COMPR_OFF;
+	channel->data = (void *)channel_info + CBDC_DATA_OFF;
+	channel->data_size = CBDC_DATA_SIZE;
+
+	spin_lock_init(&channel->submr_lock);
+	spin_lock_init(&channel->compr_lock);
+}
+
+void cbd_channel_exit(struct cbd_channel *channel)
+{
+	cbd_segment_exit(&channel->segment);
+}
-- 
2.34.1

