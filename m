Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793602035;
	b=JG2LWwL/jBTJ24F4XQ2l+5ol4upSW/rrlVX6j4PgVcymZOS0fcmxFAV79E2Yw1+JUjCo
	 lXeJ5V6mqxVx9KKhO4U/TlNgMxxCeNWm+xZ6CY8DouYi5gHoZBkBsaQ3V73LyxFtGVm2S
	 icgLczr72C/wyK+vg60Hc2DEi5/dqsDd43Gx+9YmkzcTYs5/NrUGwrqRK7jPaD1KFhTWK
	 1gAtNd2wT6PgDBkDnVjg///rDAa6zyiVKGFCabs4EreHciUF0MZGN5oWaNxwobYT7w6iH
	 5iBqxLhH4ffsoR/m0N+jPKlgfnzJh3T7Sgw03ZgFnplopaktrYOaajciRv4UXGAxOEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793602035;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=TnrMdknEv6+01oL0Xur2PpAkSyjvMCEFKEns63Q5Zd8=;
	b=UunMFj0L7OJ9zPgtM7UlcwuEGhD//WW9nvHz7363dm5uBcSQ1mb7ZTXfmIkEnqcr278x
	 9uJGV1H+l4ul+xcQUtLZOv99GDrUG4eg8MCG0Q4Jj0FDgGA7e8mF01vNlO4A2rlkGGUj3
	 oFWq8FIBYgLLAG/KdQ6703vSKc28c084cX6fX6oC4qvyfsAZtVPTWcU2+8iDuua6/fRBa
	 BjO/xe1exToGPkfF9qyHdMBdY0MOHkpOkNh1ekLDYTE45dW5hiJcQoZkN4Npz61I9LPXF
	 CIB5lvMhlUTMNsTpg4fYd3EM1IMQK+5KiV4oMHtRS1SVZJyie/EAOWPF8svnTWRm4Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	arc=none smtp.remote-ip=113.46.200.217
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1281E60A5BE6;
	Mon,  2 Nov 2026 06:47:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1281E60A5BE6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=TnrMdknEv6+01oL0Xur2PpAkSyjvMCEFKEns63Q5Zd8=;
	b=nA8/c4knN0gt8OeFroEFYi6VYCKm+HRJnef6DLxi2pyKv8NoGqn8kSLeJeGB8TpwTC69QSWlh
	xZ/SautLTAPhPSKzGvRbq27Hs1kSi0uu1lTH9mw1X1mKJju+cTh4w9VXqfi8mMOGWTqLahYoyno
	+B4MyshgB5/XnC2oyboSh10=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4jJ2L43mp7zcb0L;
	Mon,  2 Nov 2026 14:46:36 +0800 (CST)
Received: from kwepemr200011.china.huawei.com (unknown [7.202.195.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 5915940575;
	Mon,  2 Nov 2026 14:46:59 +0800 (CST)
Received: from localhost (10.50.159.234) by kwepemr200011.china.huawei.com
 (7.202.195.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 2 Nov
 2026 14:46:58 +0800
From: <zhangqiuhao@huawei.com>
To: "Richard Russon (FlatCap)" <ldm@flatcap.org>, Jens Axboe <axboe@kernel.dk>
CC: <hewenliang4@huawei.com>, <yangyun50@huawei.com>,
	<chenrenhui1@huawei.com>, <wuguanghao3@h-partners.com>, <wozizhi@huawei.com>,
	<linux-ntfs-dev@lists.sourceforge.net>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] block: partitions: ldm: avoid overflow in VMDB size check
Date: Mon, 2 Nov 2026 14:38:17 +0800
Message-ID: <179360149774.20265.17257530536010482220@huawei.com>
X-Mailer: git-send-email-like-python-script
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr200011.china.huawei.com (7.202.195.32)

ldm_validate_vmdb() can accept a VMDB whose declared VBLK extent
exceeds the TOCBLOCK configuration bitmap.

For example, these fields on a 4 MiB image pass the preceding PRIVHEAD
and TOCBLOCK bounds checks:

    disk capacity =3D 8192 sectors
    config_start  =3D 6144 sectors
    config_size   =3D 2048 sectors
    bitmap1_start =3D   17 sectors
    bitmap1_size  =3D 1024 sectors (524288 bytes)
    vblk_size     =3D  128 bytes
    last_vblk_seq =3D 0x02000008 (33554440)

The configuration area fits on the disk, and the bitmap ends at sector
1041 within the 2048-sector area. The VBLK extent is 128 * 33554440 =3D
4294968320 bytes (4 GiB + 1024 bytes), so the VMDB should be rejected.
Both multiplicands are u32, however, so the product wraps to 1024 before
it is promoted to u64 for the comparison. The check evaluates
1024 > 524288 as false and incorrectly accepts the VMDB.

Cast vblk_size to u64 before multiplying. The check then evaluates
4294968320 > 524288 as true and rejects the out-of-range extent.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: zhangqiuhao <zhangqiuhao@huawei.com>
---

Based on Jens Axboe's for-next at
70866cfa169d5ee149364267289e71d50f9a7ae9.

 block/partitions/ldm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block/partitions/ldm.c b/block/partitions/ldm.c
index c0bdcae58..d5c133a33 100644
--- a/block/partitions/ldm.c
+++ b/block/partitions/ldm.c
@@ -458,7 +458,8 @@ static bool ldm_validate_vmdb(struct parsed_partitions *s=
tate,
 	 * The last_vblkd_seq can be before the end of the vmdb, just make sure
 	 * it is not out of bounds.
 	 */
-	if ((vm->vblk_size * vm->last_vblk_seq) > (toc->bitmap1_size << 9)) {
+	if (((u64)vm->vblk_size * vm->last_vblk_seq) >
+	    (toc->bitmap1_size << 9)) {
 		ldm_crit ("VMDB exceeds allowed size specified by TOCBLOCK.  "
 				"Database is corrupt.  Aborting.");
 		goto out;
--=20
2.33.0

