Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=124.71.93.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793607169;
	b=BJiTr9ycMj4wlH9eABOXkPOtYJ5TVOU+F260Eolj6zcyi6tY21Uo9Mq1DuilGggLC9wc
	 zP5L+D8DGNz0MxHU1KDeE+N+2d1QfYrMJqRFNIq3qkuwu9zpME6EnByOG+dQheVWboCQW
	 OnfK7LHdNJCU0P8kk4WEd/ff+z7TNcnkD6NmCZic4DWfjQyhLeZfVVVUr72lN09pZp7jB
	 6e1klv+JI2fnG1d7y/RwCU6z8BCALoaULJp/y2O9xOOI6h3iE4QglguLwGjvn1JPqVyOA
	 ZpxPTM7StaqlSgPyR07Cxf/albATKlAGp8JmVjCMiJbLcnqzEZi3Dd5YUWkTm+akX3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607169;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=StNRhS3uLF68vr/22gxVM7chGhzsilgJi6E3RMdsv9c=;
	b=cs2do7pgwxX/KHGGa0VYvCGQQJ1PhE9KmNlWAMov5rq4t//+jfao7HlTY7rTfoyZhODU
	 nrs2p1ePrYtFI58G3D39ZM1Vdl+sL1+tHLV9UYuJEvgjfgJ7baxRb1+0UbVyViDwbv/9m
	 gEyKpov8V2kaMFphjf1kA+F+IOJ/hF0dnJy/o7q0xuwLoSd+c40cxdZ8989Bx8/SvpRHX
	 JtxoFBxj+DX3516eEGDEfTk+ogV1WmR1ncznNdKsJ1kF6M7QsHjef8NwiOHiiJqBezs1+
	 b7rwpqVUnazm6k0Qn6VrSDrSYrPpva3ruvACjOpPzWJb5gKqfaW6AnQ4m7TsajRXZGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=124.71.93.112
Received: from dggmsgout12.his.huawei.com (dggmsgout12.his.huawei.com [124.71.93.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9BDC606A32C;
	Mon,  2 Nov 2026 08:12:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9BDC606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggmsgout12.his.huawei.com (SkyGuard) with ESMTP id 4jJ4F03llnz206N;
	Mon,  2 Nov 2026 16:12:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B839140561;
	Mon,  2 Nov 2026 16:12:42 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP4 (Coremail) with UTF8SMTPSA id gCh0CgB3tfT6RehqnrYcCw--.16409S4;
	Mon, 02 Nov 2026 16:12:42 +0800 (CST)
From: Zizhi Wo <wozizhi@huaweicloud.com>
To: axboe@kernel.dk,
	bvanassche@acm.org,
	hch@lst.de,
	yukuai@fygo.io,
	linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	yangerkun@huawei.com,
	chengzhihao1@huawei.com,
	wozizhi@huawei.com
Subject: [PATCH] block: partitions: reject GPT entries with starting_lba > ending_lba
Date: Mon,  2 Nov 2026 16:04:42 +0800
Message-ID: <20261102080442.3775061-1-wozizhi@huaweicloud.com>
X-Mailer: git-send-email 2.52.0
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3tfT6RehqnrYcCw--.16409S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AF15KF47GFWUAFWxXF43Wrg_yoW8AF15pr
	s3Gry3Cw18uF1fZa97tan7X34rurnrWw45tFW3W3yfKr43ZasrtF9I9ayjkryjqrZxt3sr
	ZF1Ygr1kua13AF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7
	CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8C
	rVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4
	IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY
	0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I
	0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAI
	cVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcV
	CF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UQ6p9UUUUU=
X-CM-SenderInfo: pzr2x6tkl6x35dzhxuhorxvhhfrp/

From: Zizhi Wo <wozizhi@huawei.com>

A GPT entry whose starting_lba is greater than its ending_lba is accepted,
and the kernel creates a partition with a bogus size. The bogus sector
count defeats the end-of-device check, so I/O through that partition is not
confined to it and can access sectors outside the partition on the same
disk.

is_pte_valid() only rejects an entry when its type is NULL or when
starting_lba or ending_lba is greater than lastlba; it never checks that
starting_lba <= ending_lba. For a reversed entry both field checks still
pass, but efi_partition() computes size = ending_lba - starting_lba + 1 in
u64, which underflows to a huge value. That value also wraps in the
end-of-device check in blk_add_partition() (from + size) and does not fit
the signed i_size, which turns negative.

Reject entries with starting_lba > ending_lba in is_pte_valid(), matching
the head-level check against last_usable_lba < first_usable_lba.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Zizhi Wo <wozizhi@huawei.com>
---
 block/partitions/efi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index 9865d59093fa..b31227a13db0 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -458,10 +458,11 @@ static int is_gpt_valid(struct parsed_partitions *state, u64 lba,
  */
 static inline int
 is_pte_valid(const gpt_entry *pte, const u64 lastlba)
 {
 	if ((!efi_guidcmp(pte->partition_type_guid, NULL_GUID)) ||
+	    le64_to_cpu(pte->starting_lba) > le64_to_cpu(pte->ending_lba) ||
 	    le64_to_cpu(pte->starting_lba) > lastlba         ||
 	    le64_to_cpu(pte->ending_lba)   > lastlba)
 		return 0;
 	return 1;
 }
-- 
2.52.0

