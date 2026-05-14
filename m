Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 964333CF674
	for <linux-block@vger.kernel.org>; Thu, 14 May 2026 21:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778795531; cv=none; b=rbTnm3DkIc7djxzLOjqSYKSVASP/8C0TrITEisybIDqECiA/4rgqitkqy0sAK1pLJq52cN0Dv+O+/DE6uFpMDZmMym/g/7MvKEiqkDrvmgnAYSjd/dkWSq7cQ7PdkZm2ZYqn8RqQACZu9X6CVSLOmR0EluTi6vTBGRZgirQIHL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778795531; c=relaxed/simple;
	bh=5MBJYs1Ny9I8ogr/547ALSAn0Pj03wWQCXtJIb2TJHQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hhZI7mV7NTz1kCKKIoXcMq7QeDxYlRMVWKVhVX3BukI/2j13EzbJ3Q+NHjpPXFp+UdzajdDzC/9pv74oUQX9m2H6eRtnpoZqdSOtkFpPSSjRUC1uyV3XV6y48Ry1ohTN6zKQW0vusVm6Nfmz+R7y2qSeX6i+VayuEeuj1VU+qWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=tBt53dWq; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="tBt53dWq"
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64ELjOAT341163
	for <linux-block@vger.kernel.org>; Thu, 14 May 2026 17:51:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=6kqw
	7BAzD2WWgy7QOAIi6FHWqeO1F7nxlJS1uusq/eg=; b=tBt53dWqDG+4YQvP+yzf
	t08Mdq9u5NAo2gghpSycmflWYst40GFzx5jWQAqvDBXC9c9xly/C3sWSTmVurFWZ
	Vx/VsGGDRmszucNqshm3wKuYSxkPI+S09nfFpFyGxDQmoIdk/ehJcqfaZJa16SKo
	qE7wWfYnudBRXoQ9SXVciqfcnZjxUp8kZW38QhxYqCeyjT3N4YnvgsE/hLQH/PIw
	ADyyyR0CCO781xiYtzXjFkE4qBAWM428/9tks/eHETxMC+c5tnfxoYkysukZ2Cv6
	1ba4WBu8dUZxR5oCYIn6aXy2gCnn0nSX1M45JKGJBApZHLKWxL0oZNlP4l12z1Em
	UA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4e5m22sd1m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 14 May 2026 17:51:52 -0400 (EDT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-90d6fe98316so684127785a.3
        for <linux-block@vger.kernel.org>; Thu, 14 May 2026 14:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778795512; x=1779400312;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6kqw7BAzD2WWgy7QOAIi6FHWqeO1F7nxlJS1uusq/eg=;
        b=cWXHBZxcOl1jpUVrgTeTJgPXl8rGpoiQ7xINB6Vhl9JnjSX6KRhVmniHKRfhOBjWXu
         2RvMBjZSDXUdUG3RXFUQCDLC8V+Uh2Zql1m1WfMBjZTFck+OclHD49Y5Tn+e7rPESKMR
         NsZscj5FsHwMEUOn6yi8h6J82ojhVrITWa/w6HcSwBxXVTaQMgX0aGJgjWOTWfBMyglu
         J9X0hJD9/8dZXjnnkvfJRoAdEZftwB/5+UCZWPmJ+0Q3CsZw4MbFqMwM6s5sRb0MSIER
         vUehBif4+tcNVrqYj3q4kK0HxLtqV0ee68ehgaw/7rs4Ax6tom0XkOzn1aUQWkgRU08p
         qCoA==
X-Forwarded-Encrypted: i=1; AFNElJ86T1JA3qss089sOs9CPQBql218hIwTpuhOqgov5xRZqIxGwdedPoXReE5pdGlT8W3CV3+WpCZrwm9Luw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGvGtVxdwsxOc/otCjWTCoCyJ0AxBNGwkrYY38Nl/6v9vuxRHm
	ERYBuMzN999q5DwaWt3AVfBn4qkkbHZAd0R7PZUVVA9/Vj50ceRdZ22TXMcLV+ZFflP03vCeaR5
	f5WMFiuNh26xtHQlInktA9mgkQSLeyKVu6VSlo1neai+KzavPb3dyc0o7SDbz
X-Gm-Gg: Acq92OHrlFiRu72Y3Np4yhOeXh0w5Gl9a7D45diDrZ1hk5EFRosamVogUPABNAu83mI
	gQpPIeafUur5wtO6ln+eArq89Ar+8cL3bRoeuNihrRow6UClO5iz1I0lErwPWOAesVlI7R9Eu+O
	s1pNnYiMDxO99U+tFPEvKpvmmPgGUsMl0nPYVEGJ7aoXW1sJiov1ghcz6//hKsGjLpmhYmlI1xQ
	3EJm6S1Bj3TjaO8vnKp0qRAZqygOpPjuQiPRO2ExEDZ2rXawPYOEfxvywC+idsucYL+Di+RuUnr
	HypNFuZwJhp9sCqIEsZSntNeWHCu29r6LA4j00mYC9LscPZvMezpsXmF2WpCHS4dqnK51Nuk7IK
	75x6cVhRU5RrEX06Br4NUUWArgqG8eLoz
X-Received: by 2002:a05:620a:170c:b0:910:5637:4bec with SMTP id af79cd13be357-911cd1752admr254277685a.18.1778795512194;
        Thu, 14 May 2026 14:51:52 -0700 (PDT)
X-Received: by 2002:a05:620a:170c:b0:910:5637:4bec with SMTP id af79cd13be357-911cd1752admr254272685a.18.1778795511761;
        Thu, 14 May 2026 14:51:51 -0700 (PDT)
Received: from [127.0.1.1] ([129.236.229.175])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910ba18132fsm354966085a.6.2026.05.14.14.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 14:51:51 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 14 May 2026 17:51:16 -0400
Subject: [PATCH v6 3/4] buffer: add dropbehind writeback support
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260514-blk-dontcache-v6-3-782e2fa7477b@columbia.edu>
References: <20260514-blk-dontcache-v6-0-782e2fa7477b@columbia.edu>
In-Reply-To: <20260514-blk-dontcache-v6-0-782e2fa7477b@columbia.edu>
To: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>
Cc: Dave Chinner <dgc@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, Gao Xiang <xiang@kernel.org>,
        Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778795507; l=3250;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=5MBJYs1Ny9I8ogr/547ALSAn0Pj03wWQCXtJIb2TJHQ=;
 b=9bQ2fojDINOqvoN+XUOT5/4ajyDiEcYRuoe/toJiMW2IYEErMQPP4nWP0kyaFXtYEdFs8QavD
 IoIc3c+yGL9AJoDL8xs3GhMcj/KZ4S3T3QanBUhqIizKxZ8785C3SWR
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDIxNiBTYWx0ZWRfXyB00EUWWOS3/
 WFIKia5LUx65pDexNRMHGWp54oXdakRpaWLgnN1IyjD7tGzZcnl8oMH1Rzs9Q3J6SaZBI+WOYdC
 iBncdKnSXBSeuOe2irncYf2IN6K9i2BbpAWl8yzpjNahX+16Sc5mUzseUR8055mdWFbvMr0nuk2
 z1JXR40uK47PaQHMMfInB20sjRGvd6aba4rT2eicLPj+f9QfimOkRmYkZb0ytPG6K3gdllVQZxa
 ytRX0dQmeOFwHtyzrhn78vgIu36tJktePGkU+RmOsbprzWgUcou9+8hc5VWPYrs/bVYXwq2XkIx
 Hsu8yjQtH243mxMujQAtlhtuDdpPPA90TE94fUH5SqBFTebPbadDRUagq1OdjuKN04T89EHbkKh
 mu9EuMC5TqYZkfnlfHnlkDOqADXEqw/W8uC6iD+Rolk0X4PjhhodXtJgjn9yxD12yeVxx+2944P
 vnSxUk6qgSbawVsjY7w==
X-Authority-Analysis: v=2.4 cv=Je6Ma0KV c=1 sm=1 tr=0 ts=6a0643f8 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nkegbr1AwBRna+m8FBH0UQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=H0jnwmGZIJSlLSF8bakA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: 2IZm0jr76uxYLDymx4vNLu5z6doSqMab
X-Proofpoint-ORIG-GUID: 2IZm0jr76uxYLDymx4vNLu5z6doSqMab
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11786
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=10 lowpriorityscore=10 bulkscore=10
 clxscore=1015 adultscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605140216

Add block_write_begin_iocb() which threads the kiocb through to
__filemap_get_folio() so that buffer_head-based I/O can use DONTCACHE
behavior. When the iocb has IOCB_DONTCACHE set, FGP_DONTCACHE is
passed to mark the folio for dropbehind. The existing
block_write_begin() is preserved as a wrapper that passes a NULL iocb.

Set BIO_COMPLETE_IN_TASK in submit_bh_wbc() when the folio has
dropbehind set, so that buffer_head writeback completions get deferred
to task context.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/buffer.c                 | 19 +++++++++++++++++--
 include/linux/buffer_head.h |  3 +++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index b0b3792b1496..d0abaf44d782 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2138,14 +2138,19 @@ EXPORT_SYMBOL(block_commit_write);
  *
  * The filesystem needs to handle block truncation upon failure.
  */
-int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
+int block_write_begin_iocb(const struct kiocb *iocb,
+		struct address_space *mapping, loff_t pos, unsigned len,
 		struct folio **foliop, get_block_t *get_block)
 {
 	pgoff_t index = pos >> PAGE_SHIFT;
+	fgf_t fgp_flags = FGP_WRITEBEGIN;
 	struct folio *folio;
 	int status;
 
-	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
+	if (iocb && iocb->ki_flags & IOCB_DONTCACHE)
+		fgp_flags |= FGP_DONTCACHE;
+
+	folio = __filemap_get_folio(mapping, index, fgp_flags,
 			mapping_gfp_mask(mapping));
 	if (IS_ERR(folio))
 		return PTR_ERR(folio);
@@ -2160,6 +2165,13 @@ int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
 	*foliop = folio;
 	return status;
 }
+
+int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
+		struct folio **foliop, get_block_t *get_block)
+{
+	return block_write_begin_iocb(NULL, mapping, pos, len, foliop,
+				      get_block);
+}
 EXPORT_SYMBOL(block_write_begin);
 
 int block_write_end(loff_t pos, unsigned len, unsigned copied,
@@ -2715,6 +2727,9 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
 
 	bio = bio_alloc(bh->b_bdev, 1, opf, GFP_NOIO);
 
+	if (folio_test_dropbehind(bh->b_folio))
+		bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
+
 	if (IS_ENABLED(CONFIG_FS_ENCRYPTION))
 		buffer_set_crypto_ctx(bio, bh, GFP_NOIO);
 
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index e4939e33b4b5..4ce50882d621 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -260,6 +260,9 @@ int block_read_full_folio(struct folio *, get_block_t *);
 bool block_is_partially_uptodate(struct folio *, size_t from, size_t count);
 int block_write_begin(struct address_space *mapping, loff_t pos, unsigned len,
 		struct folio **foliop, get_block_t *get_block);
+int block_write_begin_iocb(const struct kiocb *iocb,
+		struct address_space *mapping, loff_t pos, unsigned len,
+		struct folio **foliop, get_block_t *get_block);
 int __block_write_begin(struct folio *folio, loff_t pos, unsigned len,
 		get_block_t *get_block);
 int block_write_end(loff_t pos, unsigned len, unsigned copied, struct folio *);

-- 
2.39.5

