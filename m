Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F2723370F
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 14:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753800825; cv=none; b=Z0QGLiBIi4wNr3JBsING03ysY/z+bhCMuJL96CEeUOpo+q5tPAdU2ghd+H7vdxcVHtYbAdIlU5MF5ipLPXYT3TqF8o6jU/Zoift4KjUQsNP2fBYjQUOSluhCH+Ma9V970/mS/yY+CzbyjBTjQbuA0Z4wkP90xa4g/Nsaao1h7dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753800825; c=relaxed/simple;
	bh=45Te4q1HVPcQ+Er4Ku2+Yvhkl+PUL7mwQtTUchE9WjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=T/uZkNY05Ea9pzKHZVI6G0s47cH5LqLRwvOWJNQy191UFp0RUz1SHJ74+2Dipfq/MAmxH3vmoceIm5iDIxcWtDV2GMRrgk0fexnasF3iiNiDx0JpN7k4Vsb5ne6uQbOw/u+tbVDnCk76dk+Ya74IkqFAT86KbPFMmK4cIlswkho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=IyxNEHUC; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IyxNEHUC"
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20250729145342epoutp0268a1149b2ec0b2af3f56cce42f630c22~WwI5B8mQd2641426414epoutp02R
	for <linux-block@vger.kernel.org>; Tue, 29 Jul 2025 14:53:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20250729145342epoutp0268a1149b2ec0b2af3f56cce42f630c22~WwI5B8mQd2641426414epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1753800822;
	bh=xC7UXOv1rhGb8UfKqRRqLmbySIHlleIULickZaPtMAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IyxNEHUCSxTsBYduBZ5A3K4Y7TQcaUSCHPI4XYCQBvisOd2vDGEGIGB3K3IOTch6n
	 vWYscbNHjEkt92TBfqqPJMHWzIwIFYixAhUq142MAZwDkkW0+SvlMqRKNluOteLUp7
	 gKEcvnhSQo/2mbva3PdiHHUdiT0hQJtPHoqtuu70=
Received: from epsnrtp02.localdomain (unknown [182.195.42.154]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPS id
	20250729145341epcas5p423036684b82cca7042ded9a2fc56364d~WwI4jvTKT1518815188epcas5p4N;
	Tue, 29 Jul 2025 14:53:41 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.86]) by
	epsnrtp02.localdomain (Postfix) with ESMTP id 4bryyr6wpQz2SSKZ; Tue, 29 Jul
	2025 14:53:40 +0000 (GMT)
Received: from epsmtip2.samsung.com (unknown [182.195.34.31]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20250729145340epcas5p162878562c0778b1ee7b9c9bd7d7e6615~WwI3hivIb1769917699epcas5p1s;
	Tue, 29 Jul 2025 14:53:40 +0000 (GMT)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250729145339epsmtip28dd6c6e9a4be199f3b2168331422dad9~WwI2HllmO0477304773epsmtip2I;
	Tue, 29 Jul 2025 14:53:38 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: kbusch@kernel.org, hch@lst.de, axboe@kernel.dk, brauner@kernel.org,
	josef@toxicpanda.com, jack@suse.cz, jlayton@kernel.org
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [RFC PATCH 5/5] fs: add set and query write stream
Date: Tue, 29 Jul 2025 20:21:35 +0530
Message-Id: <20250729145135.12463-6-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250729145135.12463-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20250729145340epcas5p162878562c0778b1ee7b9c9bd7d7e6615
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250729145340epcas5p162878562c0778b1ee7b9c9bd7d7e6615
References: <20250729145135.12463-1-joshi.k@samsung.com>
	<CGME20250729145340epcas5p162878562c0778b1ee7b9c9bd7d7e6615@epcas5p1.samsung.com>

Add two new fcntls:
F_GET_WRITE_STREAM - to query the write-stream on inode
F_SET_WRITE_STREAM - to set the write-stream on inode

Application should query the available streams by calling
F_GET_MAX_WRITE_STREAMS first.
If returned value is N, applications can choose any value from 1 to N
while setting the stream.
Setting the value 0 is not flagged as an error as that implies no
stream.
But setting a larger value than available streams is rejected.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 fs/fcntl.c                 | 33 +++++++++++++++++++++++++++++++++
 include/uapi/linux/fcntl.h |  2 ++
 2 files changed, 35 insertions(+)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 36ca833e9a0b..ce89393f8dbf 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -422,6 +422,33 @@ static long fcntl_get_max_write_streams(struct file *file)
 	return vfs_user_write_streams(inode);
 }
 
+static long fcntl_get_write_stream(struct file *file)
+{
+	struct inode *inode = file_inode(file);
+
+	if (S_ISBLK(inode->i_mode))
+		inode = file->f_mapping->host;
+
+	return inode->i_write_stream;
+}
+
+static long fcntl_set_write_stream(struct file *file, unsigned long arg)
+{
+	struct inode *inode = file_inode(file);
+
+	if (!inode_owner_or_capable(file_mnt_idmap(file), inode))
+		return -EPERM;
+
+	if (S_ISBLK(inode->i_mode))
+		inode = file->f_mapping->host;
+
+	if (arg > vfs_user_write_streams(inode))
+		return -EINVAL;
+
+	WRITE_ONCE(inode->i_write_stream, arg);
+	return 0;
+}
+
 /* Is the file descriptor a dup of the file? */
 static long f_dupfd_query(int fd, struct file *filp)
 {
@@ -583,6 +610,12 @@ static long do_fcntl(int fd, unsigned int cmd, unsigned long arg,
 	case F_GET_MAX_WRITE_STREAMS:
 		err = fcntl_get_max_write_streams(filp);
 		break;
+	case F_GET_WRITE_STREAM:
+		err = fcntl_get_write_stream(filp);
+		break;
+	case F_SET_WRITE_STREAM:
+		err = fcntl_set_write_stream(filp, arg);
+		break;
 	default:
 		break;
 	}
diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index 87ec808d0f03..dd3c498515ce 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -65,6 +65,8 @@
  *  Query available write streams
  */
 #define F_GET_MAX_WRITE_STREAMS (F_LINUX_SPECIFIC_BASE + 15)
+#define F_GET_WRITE_STREAM	(F_LINUX_SPECIFIC_BASE + 16)
+#define F_SET_WRITE_STREAM	(F_LINUX_SPECIFIC_BASE + 17)
 
 /*
  * Valid hint values for F_{GET,SET}_RW_HINT. 0 is "not set", or can be
-- 
2.25.1

