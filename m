Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADE5392837
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 07:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785395042; cv=none; b=nQKdqag3y1qrtoD5+SNW28X/Ec/Oq2PgCNN0XY90ZV8h/Z4hCICcP9sdhiB0QU3hExjX/av0T57VuNZrNggt+ssVDNsAAdMXm0lnXGlJGGtTaSjFf36GUVk4l3jlJ5qYK5j1EiISKVbj9EgBO7Qg51kds7F6Doso75JMc+Q2BaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785395042; c=relaxed/simple;
	bh=ZEoFDRdKJkaZHcFnJ/ZnxZn4DtJcz5dwb/qiVw90Hj8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nyW+ApvO6w1BjhgLqsh4h9eh+fIOyRxcUbgBlUXTnjrrj5k9LpfBwfkp2SqQxX6iXiPqtr8yV6o2uAau/biU31Z3e4HvRWGfT4T7U6+99XZQuvx8RLKgO3KwYlJ/nMsgVDzTYop08yRe6eKz86bV5J174NSPjAJlh8UtpbDXnFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=UCAOFlRP; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="UCAOFlRP"
Received: from pps.filterd (m0167071.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66U6XSok1885616
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 02:59:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=7lnM
	AQUAxGl0d0xuPXIIpzK+l0m5WwNxFhJZwOOAO20=; b=UCAOFlRPJWowBl3rU040
	SwZ/JO6HqMmh7w10K/pEOvfmU0vwubvQfrY+WMvRgG4Sga5moOoHKNyIzkVd5Dzu
	jqfahkydSebUt3mV4LY6uMauUWmZDaLaVG6DJ8zuquGQHjwda5DXs/HyE6Xiy76v
	8X3qvA6KXU7iaDGIIoDgLC6lxS2+oXXqSPwjDJUXSy22sYMka8CJlsgohpQfkcTW
	LpH4yJB+C/7+PoeS6rF2sFhJdG/fD89iCJNYXO8aOs2edt3Xj4Q0ig8B38u3LCbU
	WIuh7wRAr4Xj+4p4ZfApoiz+Gt7hx7vC+MQhge5/0L0nuYJb4SXiEk7ZY7OWpx4g
	Lg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fqud416pu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Thu, 30 Jul 2026 02:59:04 -0400 (EDT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e8004d60eso399293385a.1
        for <linux-block@vger.kernel.org>; Wed, 29 Jul 2026 23:59:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785394743; x=1785999543;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7lnMAQUAxGl0d0xuPXIIpzK+l0m5WwNxFhJZwOOAO20=;
        b=jgBvGMnl/QngWsgf8Md/WY/Mnq5VhUNJUomgoxLuc24dE67MU+JzGQeLs3FBnb2cU3
         xJgG67/2lY8+rZIM/aKzM0JOKx/my7ph2zN83BS6CkzLxDpzGI+byu3SkTxPwfCblwCh
         p8Dgiy+plieRwjv8gDA6P4Er3RGFzPtLb5AZL5ivlHPg6p9zPsB0n5W7ofKYeRCXC1Q3
         ldAH+xfX7QVH2lIqN54Qp6vS1gTqLhIXnn3fZSDvDkkxNhcMKxMUELlzSDY4wzA6syoZ
         ErQsX5dIoUsGIh56yqskhQ1GIPheEFABFwS8/fDMovWz3SXaUM1L5OfZxsvYPeoRgap6
         YZMg==
X-Forwarded-Encrypted: i=1; AHgh+RolXLaXzft2N4UHF0IZvpvSO+CzLZjbm+0W13Ttfd1wueLWuUBQJ7cXOSIm+1dz/90maeyY3HwhnTbBlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzVA8JLHPZNBIQ8zaTnzOTn/mExWx0pgbIo2O5/rpODj5OS0X92
	qj5FEOVX5vr0UYfqSzT9XIWSD5nYt/Nr8mQX+R1swR29kysCmYti15Nemzo8enqONHx377ethLU
	3MApUPNoZzWNVvjDrLfIIemJudEjFHC1nvg5+n2uc7UAPgWcL1+DwNReYfmdp
X-Gm-Gg: AR+sD126W6QobjbYSovtr8ViuanOj7lv/NgCPIvI5ny1aMwZAQd0FKUivRPQXItlL+v
	tbTiuAOjjDgKhhG4mIdjY9W2TT7eZQboLXLL4e6sQS+DVjrHzbb6h+ZiwDqllMvzQfe/56pCFJV
	gLGGO+zODwYRsjfFts8hBjxDVjRiCk4uhGWxFo07AkFvszdto8Y9JBvA+QlsBAq89cUSa4jWNzr
	Vyh3cUH7Lcy4j0sQecEiTXE2d6kLzP3cAFiuDZewcbsqAGT4XkW4ywGJcUbZf2+tWCuiRlQPb8v
	UJtFOOae4eOXwSf3rWnj760jv7Ottm45dKq6NiLiOW8qFYXHBYWAMX/0nHtQefU5AfKqVjoGp3X
	qx7Av9M6UJ4uVFy9WJ4yLeBOAEXtu3CMoTF97gtKrort1RA==
X-Received: by 2002:a05:620a:1a05:b0:92b:6805:9175 with SMTP id af79cd13be357-93486af1e68mr113647485a.61.1785394743696;
        Wed, 29 Jul 2026 23:59:03 -0700 (PDT)
X-Received: by 2002:a05:620a:1a05:b0:92b:6805:9175 with SMTP id af79cd13be357-93486af1e68mr113645485a.61.1785394743228;
        Wed, 29 Jul 2026 23:59:03 -0700 (PDT)
Received: from [127.0.1.1] (dyn-160-39-33-242.dyn.columbia.edu. [160.39.33.242])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-933d3221bc7sm349752485a.7.2026.07.29.23.59.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 23:59:02 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Date: Thu, 30 Jul 2026 02:57:54 -0400
Subject: [PATCH v7 4/5] buffer: set BIO_COMPLETE_IN_TASK for dropbehind
 writeback
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-blk-dontcache-v7-4-3e8e6850068d@columbia.edu>
References: <20260730-blk-dontcache-v7-0-3e8e6850068d@columbia.edu>
In-Reply-To: <20260730-blk-dontcache-v7-0-3e8e6850068d@columbia.edu>
To: Jens Axboe <axboe@kernel.dk>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@infradead.org>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Sandeep Dhavale <dhavale@google.com>,
        Hongbo Li <lihongbo22@huawei.com>, Chunhai Guo <guochunhai@vivo.com>
Cc: Dave Chinner <dgc@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
        Hillf Danton <hdanton@sina.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-erofs@lists.ozlabs.org,
        Christoph Hellwig <hch@lst.de>, Tal Zussman <tz2294@columbia.edu>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785394735; l=981;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=ZEoFDRdKJkaZHcFnJ/ZnxZn4DtJcz5dwb/qiVw90Hj8=;
 b=b+UxIQsoik7/2fDHnDW0olnU1/qVCDwC00Ozr0+zhh1d0+inVyiX96cXmklJSMAHbamG5lxnQ
 vFMiJx13/y+CaUo/njnCuStF0po4vXeZjTMmpT6DPvkv37PX9GBWJ6S
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: AtD0urRxFJVcL1uhZbXJ4pra5SyE7F0E
X-Proofpoint-ORIG-GUID: AtD0urRxFJVcL1uhZbXJ4pra5SyE7F0E
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDA0OCBTYWx0ZWRfX4BHFUf+bXVFW
 XQBgKd7bwOQHG2GpHGkk1rff6dtnC/THU78QelihMdbyPlusmBPe/j59U7d70r6pvm6VFJ7plQF
 z4F3F7ZdYN7ahAVmRPChFvCUXW7x+ld8pEK6rWYQ4f7pdrBC136u
X-Authority-Analysis: v=2.4 cv=b4KCJNGx c=1 sm=1 tr=0 ts=6a6af638 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=GaPK54s0Se3oFqK5NkZy0g==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=79PYxaXUQd1wl-QFWJnA:22
 a=WzT6SMHhq-VMa0lE35UA:9 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDA0OCBTYWx0ZWRfX/GF9Kl2q4Yek
 m7UIrxThkLyHGfDvAu5DkcMogdku5isZpUdZGVrG0zIp/Glg5Sr/EkcsqCZ1db8JGdsoFCmPaIA
 GMaeO1uceJTcfRAA5p/SWCBshcJfzf3pox/TugT56CNsvx1yvAFiXTDpMMuGePchW8lzSeb/yUd
 inJFa1IaNfN5HSWrtJLSuZ5yZcUxSsJGiNUHioKYE4T1pAj1xqHjrSwYhK34MgewP7Am7g0q6q8
 bTtcvbgAfHVZvGfSXOugyIklOq8tBzYIleHTaSKefXVBV7v+x1wdNPZmzVMLnGrObLOYc3SCMi3
 y1zhzObSJ3KzbeG8OeDEynLywQwT8GOc9NNXdHU+O3tmg60QoBC5qsmuD1ySnnGHD47kBaMD9cp
 m3mRKWvD401OuXbsZr+rNg6dJfliuG+zEwfO/idfsF8AJZd5rLPGzytggf/KhiY/sKcDlhTJXlF
 ImsGdFE/Za763dMo7XA==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11859
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=10 suspectscore=0 spamscore=0
 lowpriorityscore=10 adultscore=0 bulkscore=10 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300048

Set BIO_COMPLETE_IN_TASK in __bh_submit() for write bios when the folio
has dropbehind set, so that buffer_head writeback completions get
deferred to task context where folio_end_dropbehind() can safely
invalidate folios.

Read completions are not deferred since dropbehind invalidation for
reads is handled synchronously by the reader.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/buffer.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index 9af5f061a1f8..6f099847240e 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -1203,6 +1203,9 @@ static void __bh_submit(struct buffer_head *bh, blk_opf_t opf,
 
 	bio = bio_alloc(bh->b_bdev, 1, opf, GFP_NOIO);
 
+	if (folio_test_dropbehind(bh->b_folio) && op_is_write(opf))
+		bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
+
 	if (IS_ENABLED(CONFIG_FS_ENCRYPTION))
 		buffer_set_crypto_ctx(bio, bh, GFP_NOIO);
 

-- 
2.39.5

