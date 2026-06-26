Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCBD3A8743
	for <linux-block@vger.kernel.org>; Fri, 26 Jun 2026 07:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782458525; cv=none; b=XIMPqT5tYSsVlv8Ra0AUcc2ogTeQE/PSvZ6eNdms6R6SCxinDIxVxpI3CGUDT5Yw57zWK1T3q+Pm32CmklcJ+h6Oy6Edb2oUzmgcmHryVI9jD3COSI1XZVfPyXbkB+z903ctJdsa9KiM0zml4QHOFik2ajiiFiuwzf+1KmER5jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782458525; c=relaxed/simple;
	bh=hvkUXnrf186fG5huo4YpKDWnHCA6+38941VpmMR2GTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYsuhaYuJa3NP+tSosWfAicqERaUMiG2sXQH89EmuAmlJhXQaUeZRO2yWNMSNxMYqsg1HYTs1ElmWdChhq+iO9EUeG8pncrMC3enk79/S/vtM/y7jb7AKNCnDZjTZXFpN55/yVIIuYruxqJrKxcxM4Xmx7WSrcaW4dgfkhnzKVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn; spf=pass smtp.mailfrom=lzu.edu.cn; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lzu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lzu.edu.cn
Received: from enjou-Legion-Y7000P-2019 (unknown [172.23.56.36])
	by app2 (Coremail) with SMTP id zQmowAB3EgqCKD5qV_E4AA--.354S3;
	Fri, 26 Jun 2026 15:21:52 +0800 (CST)
From: Ren Wei <n05ec@lzu.edu.cn>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	kees@kernel.org,
	hexlabsecurity@proton.me,
	phdm@macqel.be,
	objecting@objecting.org,
	akpm@linux-foundation.org,
	yuantan098@gmail.com,
	bird@lzu.edu.cn,
	roxy520tt@gmail.com,
	n05ec@lzu.edu.cn
Subject: [PATCH 1/1] block: partition: aix: bound LV name formatting
Date: Fri, 26 Jun 2026 15:21:22 +0800
Message-ID: <6f381f63ccfe458e15067fd9b9428884cb8d5f97.1782407859.git.roxy520tt@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1782398104.git.roxy520tt@gmail.com>
References: <cover.1782398104.git.roxy520tt@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQmowAB3EgqCKD5qV_E4AA--.354S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1fCF1rtF4UJw4UKFWfXwb_yoW8CrW5pr
	ZIkw1UGayxGr1jkas2gFyxuw4rJa97JF17Kr4DGw10yFnrZ392gFZ0y3yjvw1vqr9IkrWj
	vFsYgFy8GF1DArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBY1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
	w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
	IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2
	z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcV
	Aq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j
	6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64
	vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxkIecxEwVCm-wCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
	x26r48MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
	r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6x
	IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAI
	w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
	0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbGQ6JUUUUU==
X-CM-SenderInfo: zqqvvuo6o23hxhgxhubq/1tbiAQ0KCWo85NQP6gAAsM

From: Zhiling Zou <roxy520tt@gmail.com>

AIX logical volume names are stored on disk as fixed-size fields.
The partition parser reads them into struct lvname, but later formats
the fields with %s. If an on-disk name is not NUL-terminated, the string
formatting code can keep reading past the end of the 64-byte name field.

Limit the formatted string length to the size of the on-disk name field
when printing AIX logical volume names.

Fixes: 6ceea22bbbc8 ("partitions: add aix lvm partition support files")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zhiling Zou <roxy520tt@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
---
 block/partitions/aix.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/partitions/aix.c b/block/partitions/aix.c
index f3c4174e003e..de19c19c85b2 100644
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
@@ -273,7 +274,8 @@ int aix_partition(struct parsed_partitions *state)
 			if (lvip[i].pps_found && !lvip[i].lv_is_contiguous) {
 				char tmp[sizeof(n[i].name) + 1]; // null char
 
-				snprintf(tmp, sizeof(tmp), "%s", n[i].name);
+				snprintf(tmp, sizeof(tmp), "%.*s",
+					 (int)sizeof(n[i].name), n[i].name);
 				pr_warn("partition %s (%u pp's found) is "
 					"not contiguous\n",
 					tmp, lvip[i].pps_found);
-- 
2.43.0

