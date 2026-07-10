Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1383B9929
	for <linux-block@vger.kernel.org>; Fri, 10 Jul 2026 21:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718897; cv=none; b=HuCLwRDqRtZm+1MPZbJASH8o13Mi+SZCMxxFyiMub/PkPE9IvbK73js39gm5ozsKCL7E6rqvxBGzYYM1lTEj1O/xLUwIzVAST0lHUnGPECZDpFOhlKZkPYUmD9lD8YoAjJhLHyyTZMGlHVdJcfJG7k6uq4hmGakSXaSv+4fXbD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718897; c=relaxed/simple;
	bh=n2w5pQHzE35AR6TnfV7ORKw+ncS2Q9mT+qP/FgUqjow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kd4bdT6y1MQ091rLo1HV90VjRCmVX2sdIwmliu9fpwagn4LWNSYX6nKXsJZicazjsuAJWVHWRi+ckHLGVNV2PozPmfDlPWkXaK/zcpGMAujHZ8BYFCp25RcAeSfYwvac5TbM5pKzkYrhwPODf2QlBh91CxaVgYI0nG2VP+zPzVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=bjlBOBXa; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="bjlBOBXa"
Received: from pps.filterd (m0528005.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AK48Ct2308652
	for <linux-block@vger.kernel.org>; Fri, 10 Jul 2026 14:28:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=xbr3xRrdEjq5YpoLpex95WcD7awZQdQFrPVkkLo6Th0=; b=bjlBOBXaxPmZ
	taMTueFN/916+1wq+fhjXOM7KAsyPxo2qAlaQG9HBsDCq4qbJACRHn/PD9RQtdsM
	wpj7PdKHQBvhWOVroeblT8MbKHLej5qc2OiI//a6pwYU55F5OK53qXoaMYv4fuz5
	SjRwXALhB4ta8Atiz7nVtCD5bHDxNsUgq0XQeiUF+LmziSSjOcaxku8rVIsxcMrf
	8HjMcjQsNNqiRuX9EseS8iEqmUtA7LZSEm5I/imHbDNvAm+z/iXi06cNAFtGENb5
	e60lsKLhW91vc2BCX/VF84iyjUIfm2LpDQbiUknZ1T1s/KlWX6WsZShrW/lkkZpP
	qJdubp5w5Q==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4fa9djk6cv-8
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Fri, 10 Jul 2026 14:28:14 -0700 (PDT)
Received: from twshared21331.34.frc3.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.41; Fri, 10 Jul 2026 21:28:09 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
	id 4F6D924F006F5; Fri, 10 Jul 2026 14:06:47 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-ext4@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-fsdevel@vger.kernel.org>, <linux-xfs@vger.kernel.org>
CC: <axboe@kernel.dk>, <jack@suse.cz>, <brauner@kernel.org>, <cem@kernel.org>,
        <jaegeuk@kernel.org>, <aalbersh@kernel.org>, <tytso@mit.edu>,
        Keith Busch
	<kbusch@kernel.org>
Subject: [PATCHv2 1/5] fs: add direct io attributes to file_getattr
Date: Fri, 10 Jul 2026 14:06:42 -0700
Message-ID: <20260710210646.3576365-2-kbusch@meta.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260710210646.3576365-1-kbusch@meta.com>
References: <20260710210646.3576365-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIxNSBTYWx0ZWRfX6MW6I4uMuH9J
 8rQZrml1PQ5Zjvvuac5N2AxahhTU3eA6PrXHClK3w1tSp3gejD46f2A6TDkZ+oLAOrTbq6S03Yv
 hXuLbFDkfJ90FQ2ptfTGO287TrzHD08=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIxNSBTYWx0ZWRfXxDT9weIZtFl/
 v+qAQygLpEZkPbS918rJMI15eJ9F0I/lIiyiHEB2s/3gSctLGjb0pfSd1Gs0DsDRkcpnY+yeS4y
 7vxLJWSRd+Yhyx0HkwVmN0BhjnkB8Wgke924vmhOEC02oIKcLcfb6HR2FxpLaU4tsNAZVVq5M+W
 A3JGvT1qNsWfvlPQynHls94Urw3NOYbf0yOWnKfg8rov8eY4vUJKfuITdNbD/gpsuYs6j6Aeiyc
 OaTRmvHQB3nrOQTBi8JZJaxYotdyDIzKtWG9oMSNhhfb5DekQ8ZQSpYlwoUWa1Eos63zPfayj0Q
 IKMdvHt4vHWVy+IJ9uePCzDkMTB5leOyTOSjMUSOPzHZlQNPkkldJtq6A8tmnmQWrJgEd81Kcr3
 ENjgPfLBxa//gM+eHOpcxHeU1bo2SASjjyZni7892G9HRk77+wmYSuh3OPpGdvRla51D+JZz3hJ
 K6pVl/hz4kAWF591Cxw==
X-Authority-Analysis: v=2.4 cv=ToHWQjXh c=1 sm=1 tr=0 ts=6a5163ee cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=jCddH8ec0KUNCymVuxII:22 a=VwQbUJbxAAAA:8 a=q1EBQPuWEeZjY2uRj4sA:9
X-Proofpoint-ORIG-GUID: hfm9IA03HPWuJCD1xWd7sX61Eof5ijQd
X-Proofpoint-GUID: hfm9IA03HPWuJCD1xWd7sX61Eof5ijQd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_06,2026-07-10_01,2025-10-01_01

From: Keith Busch <kbusch@kernel.org>

Direct I/O imposes alignment and layout constraints that come from both
the filesystem and its backing storage. statx() reports some of these,
but not all, and it can no longer be extended. Report the complete set
through file_getattr() in new struct file_attr fields so applications
can know the constraints they have to work with.

The fields are valid only when FS_XFLAG_DIO is set in fa_xflags. When it
is clear the file does not report direct I/O geometry, for example,
because the filesystem configuration does not allow direct I/O, does not
support file_getatter, or is using the legacy block sized alignment
constraints.

The new fields are defined as follows:

  - fa_dio_mem_align: byte alignment required for each I/O memory
    buffer. The starting address and length of each buffer vector must
    be a multiple of this value.

  - fa_dio_offset_align: alignment required for the file offset and
    total length of a write.

  - fa_dio_read_offset_align: the same, but for reads. It may be
    smaller than the write alignment allowing reads at a finer
    granularity, but will be at most the same as writes.

  - fa_dio_virt_boundary_align: alignment required at the boundary
    between adjacent memory segments of a multi-segment transfer. The
    previous segment must end on that boundary and the next must start
    on it; otherwise, the kernel will split the command at that vector
    if possible, or return an error if not (the accumulated length
    is shorter than "offset_align"). A value of 1 means there is no such
    constraint.

  - fa_dio_offset_align_max_vecs: the maximum number of io vectors that
    may compose a single fa_dio_offset_align unit. Buffers too small to
    reach that unit within this many vectors can not form a valid I/O
    and will be rejected by the kernel.

The fields are read only; file_setattr() ignores them.

The fa_pad field is introduced as a reserved field to account for an
implicit padding on 64-bit architectures and to make the struct the same
size for 32-bit. It must be zero to keep the space available for future
use.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 fs/file_attr.c           |  7 +++++++
 include/linux/fileattr.h | 10 ++++++++--
 include/uapi/linux/fs.h  | 10 +++++++++-
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/fs/file_attr.c b/fs/file_attr.c
index bfb00d256dd56..b37a55f54a449 100644
--- a/fs/file_attr.c
+++ b/fs/file_attr.c
@@ -110,6 +110,11 @@ static void fileattr_to_file_attr(const struct file_=
kattr *fa,
 	fattr->fa_nextents =3D fa->fsx_nextents;
 	fattr->fa_projid =3D fa->fsx_projid;
 	fattr->fa_cowextsize =3D fa->fsx_cowextsize;
+	fattr->fa_dio_mem_align =3D fa->fsx_dio_mem_align;
+	fattr->fa_dio_offset_align =3D fa->fsx_dio_offset_align;
+	fattr->fa_dio_read_offset_align =3D fa->fsx_dio_read_offset_align;
+	fattr->fa_dio_virt_boundary_align =3D fa->fsx_dio_virt_boundary_align;
+	fattr->fa_dio_offset_align_max_vecs =3D fa->fsx_dio_offset_align_max_ve=
cs;
 }
=20
 /**
@@ -145,6 +150,8 @@ static int file_attr_to_fileattr(const struct file_at=
tr *fattr,
=20
 	if (fattr->fa_xflags & ~mask)
 		return -EINVAL;
+	if (fattr->fa_pad)
+		return -EINVAL;
=20
 	fileattr_fill_xflags(fa, fattr->fa_xflags & ~FS_XFLAG_RDONLY_MASK);
 	fa->fsx_extsize =3D fattr->fa_extsize;
diff --git a/include/linux/fileattr.h b/include/linux/fileattr.h
index 58044b5980162..3d5384c79398e 100644
--- a/include/linux/fileattr.h
+++ b/include/linux/fileattr.h
@@ -17,11 +17,11 @@
 /* Read-only inode flags */
 #define FS_XFLAG_RDONLY_MASK \
 	(FS_XFLAG_PREALLOC | FS_XFLAG_HASATTR | FS_XFLAG_VERITY | \
-	 FS_XFLAG_CASEFOLD | FS_XFLAG_CASENONPRESERVING)
+	 FS_XFLAG_CASEFOLD | FS_XFLAG_CASENONPRESERVING | FS_XFLAG_DIO)
=20
 /* Flags to indicate valid value of fsx_ fields */
 #define FS_XFLAG_VALUES_MASK \
-	(FS_XFLAG_EXTSIZE | FS_XFLAG_COWEXTSIZE)
+	(FS_XFLAG_EXTSIZE | FS_XFLAG_COWEXTSIZE | FS_XFLAG_DIO)
=20
 /* Flags for directories */
 #define FS_XFLAG_DIRONLY_MASK \
@@ -49,6 +49,12 @@ struct file_kattr {
 	u32	fsx_nextents;	/* nextents field value (get)	*/
 	u32	fsx_projid;	/* project identifier (get/set) */
 	u32	fsx_cowextsize;	/* CoW extsize field value (get/set)*/
+	/* struct file_attr dio alignment: */
+	u32	fsx_dio_mem_align;
+	u32	fsx_dio_offset_align;
+	u32	fsx_dio_read_offset_align;
+	u32	fsx_dio_virt_boundary_align;
+	u32	fsx_dio_offset_align_max_vecs;
 	/* selectors: */
 	bool	flags_valid:1;
 	bool	fsx_valid:1;
diff --git a/include/uapi/linux/fs.h b/include/uapi/linux/fs.h
index bd87262f2e349..a49572fab3726 100644
--- a/include/uapi/linux/fs.h
+++ b/include/uapi/linux/fs.h
@@ -229,10 +229,17 @@ struct file_attr {
 	__u32 fa_nextents;	/* nextents field value (get)   */
 	__u32 fa_projid;	/* project identifier (get/set) */
 	__u32 fa_cowextsize;	/* CoW extsize field value (get/set) */
+	__u32 fa_dio_mem_align;	/* DIO memory buffer align (get) */
+	__u32 fa_dio_offset_align;	/* DIO file offset align (get) */
+	__u32 fa_dio_read_offset_align;	/* DIO read offset align (get) */
+	__u32 fa_dio_virt_boundary_align;	/* DIO virt boundary (get) */
+	__u32 fa_dio_offset_align_max_vecs;	/* DIO vecs per unit (get) */
+	__u32 fa_pad;		/* alignment padding, reserved for future use */
 };
=20
 #define FILE_ATTR_SIZE_VER0 24
-#define FILE_ATTR_SIZE_LATEST FILE_ATTR_SIZE_VER0
+#define FILE_ATTR_SIZE_VER1 48
+#define FILE_ATTR_SIZE_LATEST FILE_ATTR_SIZE_VER1
=20
 /*
  * Flags for the fsx_xflags field
@@ -261,6 +268,7 @@ struct file_attr {
  */
 #define FS_XFLAG_CASEFOLD	0x00040000	/* case-insensitive lookups */
 #define FS_XFLAG_CASENONPRESERVING 0x00080000	/* case not preserved */
+#define FS_XFLAG_DIO		0x00100000	/* DIO alignment info valid */
 #define FS_XFLAG_HASATTR	0x80000000	/* no DIFLAG for this	*/
=20
 /* the read-only stuff doesn't really belong here, but any other place i=
s
--=20
2.53.0-Meta

