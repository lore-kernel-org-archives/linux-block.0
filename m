Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C151D63C2;
	Thu, 20 Feb 2025 11:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740050669; cv=none; b=duBDOxJdWscezMMKcErOYmR8xgBFoZWn8mxu742MHKf4jAhdpV5J4z7De8FHW0SjYsaNFXYDZFvHKNM+K/GUtDbdhHCMuhQlFQyMVb0Jqe7yYuTpuBgAwXQmiHd5WpdRoCXbqdmbS8MAEeYO/GmUsW6I1MyVBN4wqMyS6/6jH78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740050669; c=relaxed/simple;
	bh=3gQVsIaY1Gje2DshsrlMQvPw0RC6SxRb/rjXb4iKTPg=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=eWmcYxz0Q5i6VrSB+aTNk97ACbmpHKqu8hBVAb7NjASZ1B1mIp1AvbkDOtePMtvxyE7M2cfoNX0LpRXwFWFFjx4DiDbyLbB6cg0CnMm4hMNesBJnW2IUEjxtumPrgu+J698A5Pvj4cKtymp5X1QkveW5bN4DDS6bFkaz2vxZ52I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Ndgjq2lm; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Ndgjq2lm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1740050661; bh=I3AayOI06ZXPHvLQzbfOoOrK37jI1skTr6cV0Rb3/v8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ndgjq2lmRbWJUW8OQXs+K2fQmc4HrOeFiHInnbPdFDAZOPqc56vTwt1BN1HNLZPN5
	 zom7da5/67nTyaJiY1l8/w1rHO+xadNL3kOcaBOK3DBcGijmcA0JUBD09sDQBN+sWI
	 5KVHcIfG8BxshmpgVc1lzlFtqz4bpuALokZ+FYn4=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id 612AF204; Thu, 20 Feb 2025 19:24:18 +0800
X-QQ-mid: xmsmtpt1740050658te0mjy041
Message-ID: <tencent_7E9E541BBE4B3C1BCD256EBA87BB8733E308@qq.com>
X-QQ-XMAILINFO: Od8VqZhFMB3NpFN5jcht+OpGQADSv30N8aJjMena15vZCairXLfL/PdTwYJhcp
	 tKjRWNc1neRQ4rxzCQndfoOtVHYFquYcLA6EvEI11E/ATQwbi6bC0f41S9J+8hsDRLX/NUxYxQdI
	 mO7J4f1j7u2QGIg+t/0lHznHzZreP/2GmOPTgKrql/KBcikraHbJgM7uKVQBX8kwLyyZQG1YgjTH
	 PAWL4YFXC017McrL2U4AjXrgBwAO1bLkdgEQpaW3XkeFwpbUnQT1XCitDSQh94l7hOau//b+u4u6
	 x99G+3csNe/fOBXwsrAulkUD1zrmf3sTN9N/3K4LVCX3plFIOQd4CUZrJNQZbpHkhj+4eq78+pl/
	 a6TFGlyojb029zxBECP8G8zW8BXDetUAev4rLdVfArP0CNBLY174FPMYdQh87PUS1fDibb40pdKQ
	 oDdgDWXWNn5o4v0jT7k1ukUUwUIcLli7sEu5I5TiTeEuHAmCPaJiWt0C81CWzj+K+7NIHN/HZ+p1
	 5aVX/T4kNAHMrhd5rXqyKtpWMRWXDlO6FREx0dykdeKjTOZACJG5I91/fJt4ANR2if1It2VZoZjE
	 3f1+5j4MEwvgnOEvFNwbdQ0b6B8N2MkO8FPRfPf5kpTInByIQViBhHcXl3fxYOvG5Os2dpho3urK
	 H5t5qeE3+5rjqYVY70sM7baWOwu9MiJnz/SVZu0jy9U07V+T27HlIVxit9ErvdRiCj3K6YOoU8ef
	 m/EueJhmUnqdnNTJFmAzVgRh/zXif0/PsRK/dCEtS+K7W6ACdk1P0lKmQ7KStowI0q/qbHOK8CJF
	 +bHbXnQ1E/eTJDLMk/Gxe6L9pw6Z1UVX941nVbDGIIbbzwHkCpqnN4Fl7aC2fwNlgvGvLqTFL7OZ
	 2o42MhkZyK1zPVizgAE+Q118UizkrC9gpa/grncZ26rnMiA3tAYdpf790DPmmTZf33Oewx/vIRsK
	 W0T7NDLjE=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: dave.kleikamp@oracle.com
Cc: axboe@kernel.dk,
	jfs-discussion@lists.sourceforge.net,
	kristian@klausen.dk,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH V2] jfs: add sanity check for agwidth in dbMount
Date: Thu, 20 Feb 2025 19:24:19 +0800
X-OQ-MSGID: <20250220112418.2310880-2-eadavis@qq.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <740c57ad-0cbd-4498-8ec9-46a54b204e3d@oracle.com>
References: <740c57ad-0cbd-4498-8ec9-46a54b204e3d@oracle.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The width in dmapctl of the AG is zero, it trigger a divide error when
calculating the control page level in dbAllocAG.

To avoid this issue, add a check for agwidth in dbAllocAG.

Reported-and-tested-by: syzbot+7c808908291a569281a9@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=7c808908291a569281a9
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
V1 -> V2: move the check to dbMount

 fs/jfs/jfs_dmap.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
index f9009e4f9ffd..62f55e7ed840 100644
--- a/fs/jfs/jfs_dmap.c
+++ b/fs/jfs/jfs_dmap.c
@@ -204,6 +204,10 @@ int dbMount(struct inode *ipbmap)
 	bmp->db_aglevel = le32_to_cpu(dbmp_le->dn_aglevel);
 	bmp->db_agheight = le32_to_cpu(dbmp_le->dn_agheight);
 	bmp->db_agwidth = le32_to_cpu(dbmp_le->dn_agwidth);
+	if (!bmp->db_agwidth) {
+		err = -EINVAL;
+		goto err_release_metapage;
+	}
 	bmp->db_agstart = le32_to_cpu(dbmp_le->dn_agstart);
 	bmp->db_agl2size = le32_to_cpu(dbmp_le->dn_agl2size);
 	if (bmp->db_agl2size > L2MAXL2SIZE - L2MAXAG ||
-- 
2.43.0

