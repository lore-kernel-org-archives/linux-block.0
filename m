Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5934286D70
	for <linux-block@vger.kernel.org>; Sat, 11 Jul 2026 07:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783754612; cv=none; b=VEsPBbrEM7f4a92E7MHVvr2fr4b2ZCGwoWek7xfLdBfxmBeVbW7y5TqAaiF3wJRGoTQs++dRmTUXkJmXQe30UEUqN5f0zT4fodukszyf78komePvl6B1jKZNiZJG1XwU4suiqSwt1xu+No2/oeF+Tx6xNevkwzTL3VeiKreTM1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783754612; c=relaxed/simple;
	bh=VHuqIMk/QhoE2wjUH9CV0ZY5h6VRFwQIt+epG0ym8WA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xzhov7xgLftx26U4Um7H2qCcW4LhzAtshwRMCCGoEG+XcIP4hAwW3tJ26q9ob4ZtJQLjQbxaLZvrcgi1lcfWWB7+pNe7WtHyIx76TjdxQwFviVmxtgF4hFUdIbzCcn15cCm9kPnfW1j/Y8ECNFjqInI2o8pFWrNvNWDxm1+Pep8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019 (unknown [123.114.53.210])
	by app1 (Coremail) with SMTP id ygmowAAHKMJX71Fq_ND4AA--.53650S2;
	Sat, 11 Jul 2026 15:23:04 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	kees@kernel.org,
	objecting@objecting.org,
	hexlabsecurity@proton.me,
	phdm@macqel.be,
	akpm@linux-foundation.org,
	yuantan098@gmail.com,
	bird@lzu.edu.cn,
	roxy520tt@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH v2 1/1] block: partition: aix: bound LV name formatting
Date: Sat, 11 Jul 2026 15:22:52 +0800
Message-ID: <c945e129867d9c0b22d673a7e9ee0d14261d4a27.1783669882.git.roxy520tt@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:ygmowAAHKMJX71Fq_ND4AA--.53650S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1fCF1rtF4UJw4UKFWfXwb_yoW8tr4fpr
	ZIkw47GayxGF129as7Wa4I9r4rKFZ7JF12gr4DGw10vF1DZan2gFWqv3y8Zw4vqr9rKrWq
	vF4vgFy8J3WDAr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBF1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2
	jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
	x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
	GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kK
	e7AKxVWUtVW8ZwCY02Avz4vE14v_GF4l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaV
	Av8VW8WwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E
	7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcV
	C0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF
	04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7
	CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUB6wZUUUUU=
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQAFCWpQq1gMpQAAst

From: Zhiling Zou <roxy520tt@gmail.com>

AIX logical volume names are stored on disk as fixed-size fields.
The partition parser reads them into struct lvname, but later formats
the fields with %s. If an on-disk name is not NUL-terminated, the string
formatting code can keep reading past the end of the 64-byte name field.

Limit the formatted string length to the size of the on-disk name field
when printing AIX logical volume names.

Fixes: 6ceea22bbbc8 ("partitions: add aix lvm partition support files")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Zhiling Zou <roxy520tt@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
changes in v2:
- Print non-contiguous LV names directly with a bounded %.*s format
  in pr_warn() instead of copying them through a temporary buffer.
- v1 Link: https://lore.kernel.org/all/6f381f63ccfe458e15067fd9b9428884cb8d5f97.1782407859.git.roxy520tt@gmail.com/

 block/partitions/aix.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/block/partitions/aix.c b/block/partitions/aix.c
index f3c4174e003e..fe2d2cb0c4e7 100644
--- a/block/partitions/aix.c
+++ b/block/partitions/aix.c
@@ -261,7 +261,8 @@ int aix_partition(struct parsed_partitions *state)
 				put_partition(state, lv_ix + 1,
 				  (i + 1 - lp_ix) * pp_blocks_size + psn_part1,
 				  lvip[lv_ix].pps_per_lv * pp_blocks_size);
-				seq_buf_printf(&state->pp_buf, " <%s>\n",
+				seq_buf_printf(&state->pp_buf, " <%.*s>\n",
+					       (int)sizeof(n[lv_ix].name),
 					       n[lv_ix].name);
 				lvip[lv_ix].lv_is_contiguous = 1;
 				ret = 1;
@@ -271,12 +272,10 @@ int aix_partition(struct parsed_partitions *state)
 		}
 		for (i = 0; i < state->limit; i += 1)
 			if (lvip[i].pps_found && !lvip[i].lv_is_contiguous) {
-				char tmp[sizeof(n[i].name) + 1]; // null char
-
-				snprintf(tmp, sizeof(tmp), "%s", n[i].name);
-				pr_warn("partition %s (%u pp's found) is "
+				pr_warn("partition %.*s (%u pp's found) is "
 					"not contiguous\n",
-					tmp, lvip[i].pps_found);
+					(int)sizeof(n[i].name), n[i].name,
+					lvip[i].pps_found);
 			}
 		kfree(pvd);
 	}
-- 
2.43.0

