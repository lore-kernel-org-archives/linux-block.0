Received: from mx0b-00364e01.pphosted.com (mx0b-00364e01.pphosted.com [148.163.139.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F52489FC4
	for <linux-block@vger.kernel.org>; Wed,  9 Sep 2026 22:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.139.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788991527; cv=none; b=fLRjJzwZgMRNRD6jynA1T4kqH8ZUqQLMzHPneXm0QO4BCm38i6FIvGXXozx9I28m098caX+s90ulfE0mEIZQAYEFdZ5rvwQGoVzCeP7vL5T3khoI+KYxfM4UpALto+EzdRZkjK8VZKGh8pugUA95fiiqxYPlZsm70AWEUz8dlzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788991527; c=relaxed/simple;
	bh=gUvUBfvXAIVgjCzdiwV3/TF71eqAveqNX7ByY2W7Bng=;
	h=Message-ID:In-Reply-To:References:From:Subject:To:Cc:Date:
	 MIME-Version:Content-Type; b=MyhNQqRKH04sUyTTStq183kSl40dbRyIvWSpvG1+8n2uhm1Jx9+I/8si6nZCGKMEuGfoFB7WMN5xSNrwsoHFC/ZlA45b5zmIf3R/X5T2m1ByEGsTgkTM4hMkPQzwJWhpRFh0nnCeUljSlSezTbMpp0rIPvhUdfVsPvW+BZ1oArA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=U440jBa4; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=tgGO+if4; arc=none smtp.client-ip=148.163.139.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="U440jBa4";
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="tgGO+if4"
Received: from pps.filterd (m0499198.ppops.net [127.0.0.1])
	by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689KYgwT1655849
	for <linux-block@vger.kernel.org>; Wed, 9 Sep 2026 18:05:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pps01; bh=l0kN
	/rDFN/f55aXR9L0fwoeC0Cq8ZY3zyzxNrCxyk5Q=; b=U440jBa4zt5XZQqSXjr3
	h6a8uj+m9eq8F/EPCTVNZhUwxBp7mVm8Js5AJ99ZaGjCfCQ3a+5hjjc4ZFOGf1+l
	LSPY76FSfg90vUn85AWJLfncpdaFJtDTXdgpdX+e3KzhmPsdcxNelLrqKNDXfG7z
	nkBryH0eX8CbCYWlbbisAN3gGmRmymvUYYSmdsxRjG1BdmeXViIPSmpJ6bO2arzm
	gSJfpLEC1ohfcupjxAwkI7V1zAvUxu3Tw21smdXH39M8CRlRcxg3GHYbBPK62HtF
	bGoIZyqxVYmXobYdtgkFHLzPrtPSjh4BvLbpGYLDNKJYjf3owKXHDDDGuYLOP41L
	ow==
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com [74.125.224.72])
	by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4gkcxxsynd-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 18:05:24 -0400 (EDT)
Received: by mail-yx1-f72.google.com with SMTP id 956f58d0204a3-66cbfb7ec42so11259311d50.1
        for <linux-block@vger.kernel.org>; Wed, 09 Sep 2026 15:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=columbia.edu; s=lionmail; t=1788991524; x=1789596324; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:cc:to
         :subject:from:references:in-reply-to:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=l0kN/rDFN/f55aXR9L0fwoeC0Cq8ZY3zyzxNrCxyk5Q=;
        b=tgGO+if46eWNe/HJIYYTuffi4ReZnwtixyoVGGFlwiMniBADIFuYF9KmAqgIZYr39S
         jwypkyBFYFllrVF913ECxr3EzA1JrUs5gKq1gvLD2NNiQRQg2Gn9RpYKqmAP42CFi6xP
         g20N8/oK6h+oO1wPp3Vo8xwIVBjzN49925Cz38O1MOntQL42muP61v6SK4sdrVgqEmFq
         0GB9OPcK3F3bmlDQC1NriF+eki76fiu0YTvHcx74Npfei02EFNtRZMK5bWMjcoXbVX2o
         ZwSVXCwe+kzggmf4NcykTX89nAH1r7DAWu13/cwufAQsY0o2baIcDb52gE6bpCY8fDZV
         HVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788991524; x=1789596324;
        h=content-transfer-encoding:content-type:mime-version:date:cc:to
         :subject:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l0kN/rDFN/f55aXR9L0fwoeC0Cq8ZY3zyzxNrCxyk5Q=;
        b=YZU5dkBLjl5RJnLDa7aFwv4V7qBVjAwb60ryr/FMJt6AOcLFljoPGPOpyUbY+v6ek8
         qmHvMOKtZyEuCmfOGhtDgWyRrAJmotpVXoFGktFa+UeeLTJpwS60uofFWX7PLVkaeWj3
         RZtz2WSHfOEZK+XFsiHviShCA+pnLs9iPRlQrEDSO7Vk+Ygb+4x2ReFjuUQbhIonMxBJ
         LJkmqrLnKtRfPkQobSIK9uE8l5p/wgBxG3WKNldyx7XOAmJIYcZn9gkPBKHDoErgzs9q
         V6CqzqK1Zvb8sYZhCPt58t7Jeq10ILyIJsEwUgeh7LjEKuDVcJPjWznlDRwMZNB99YEZ
         +N4A==
X-Gm-Message-State: AFuF++n1KfvYcKRzMJSL3+w55T4Nm2YRlJnvxqslnuCmCY4idrYfZ9gl
	sXqVab2y/Rielx8YWq+fnZb1kqCBvdIOFL9+jXnaWxLuom8MM7d16H7Oiv6StQkfKQsouoc27IB
	QieMFf8+zURZ+2FnHgH51BZMw5gW4K6eJCZGKL4qxyfis1aOiZHzoBOW9ZaZP
X-Gm-Gg: AYBFou3HeatvvBVneUWjunjvU2GOMyZeYmSyChY80Wnk7rzxMhCdgzl2iPydsnNCGON
	oNvo3jqrDGec3MuoV9GGAndwSNKTgvqFxTR33yTnenw/lFSTMA74dS69lQY09HxLprBGb2Q8Exp
	FvAhfo3YKaaBmc+ENCSijMU21s4wGLWTJ+gAfQs0ADBkQ+2ULLrvDE1wjTrVeUOO3psfFP6OkHE
	dKGOfF05eU2qdsKrndr98xYUEAEcoTaH+xIN2ZfwfkMLEH80xHucObKhWuJkixgnpz9OdfpC5ZW
	6e9AVfNygTlmZ5lRyR9v3Hv+17D+UQZ7MFkAo4Gx5c0uVNFccCsG9g+rSOZCri3Rk9ZefxcVeaW
	MOqTgSpI0MaIRceWEvdokgLH19fGHbBPegbp9xFU5hy2ej3a+
X-Received: by 2002:a53:c847:0:b0:66d:1c78:5dd2 with SMTP id 956f58d0204a3-66fb5a6d546mr10813811d50.37.1788991524052;
        Wed, 09 Sep 2026 15:05:24 -0700 (PDT)
X-Received: by 2002:a53:c847:0:b0:66d:1c78:5dd2 with SMTP id 956f58d0204a3-66fb5a6d546mr10813779d50.37.1788991523534;
        Wed, 09 Sep 2026 15:05:23 -0700 (PDT)
Received: from [127.0.1.1] (nat-128-59-176-193.net.columbia.edu. [128.59.176.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91040693f75sm154018806d6.35.2026.09.09.15.05.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 15:05:20 -0700 (PDT)
Message-ID: <20260909-blkdev-fixes-v3-7-1a5222c6e8ad@columbia.edu>
In-Reply-To: <20260909-blkdev-fixes-v3-0-1a5222c6e8ad@columbia.edu>
References: <20260909-blkdev-fixes-v3-0-1a5222c6e8ad@columbia.edu>
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH v3 7/7] block: remove dead metadata handling from the async
 direct I/O path
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Garry <john.g.garry@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Keith Busch <kbusch@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sashiko <sashiko-bot@kernel.org>, Tal Zussman <tz2294@columbia.edu>
Date: Wed, 09 Sep 2026 18:05:14 -0400
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=b6EncdGx c=1 sm=1 tr=0 ts=6aa1d824 cx=c_pps
 a=VEzVgl358Dq0xwHDEbsOzA==:117 a=fJxgZNdXt3opHMdyAp+FXA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=BpGzv1V74M3SfeTrGa8v:22
 a=IE87Obj3e0A1gCLlgTsA:9 a=QEXdDO2ut3YA:10 a=uujmmnXaIg8lM0-o0HFK:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDI0OCBTYWx0ZWRfXw/vLi7JjE+Ah
 dVwSY8HxMYJKiTPA95SiqNaL4d3TqIx5QUrtuy5JgyHva7ZQFAXmEIa2gwFinnVRiNZF1uDAeDK
 WCuQZh7KAo9ES6w6CNN7J3A1npjsvfHF8QmnGuN3cE6o2mtIUM4s
X-Proofpoint-GUID: oEk_ANcTsKp_tt9--JHyYTxPrQz5UY7s
X-Proofpoint-ORIG-GUID: oEk_ANcTsKp_tt9--JHyYTxPrQz5UY7s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDI0OCBTYWx0ZWRfX03ebyD8mI+lk
 kHdx5Grhujw1k/y0ZpjlnhNy8LuJGnYcBvenEs2kIkIRFgkRcGe7tFpOl0LQi0IzYCqejVFGxMw
 zsyPVuaiE6WXoQDkEnyNXbiJfx/LwfP8EzFFvqyHJU/0k2KgyENrTnzWQuY69kzAvjiEtjdEN9E
 udxaLc81wWuFXxaPAIKgHKK5t1f94DABc+ExQpuElHh+T+Yoa4f4hiWNxzVaG02WmIqptG9IhNg
 nonC/meKobFoxb0e7G/RRxcMWQCC7XpxZn4MQkqoSl7swJ8fG8FKH4ScDrvSDdGvSOf6tE8wpXY
 bbtlP7UnfMFnAZ2O556btNpWgghrPM/mOl/u+DgxQQDIy+wpezcmCgjTaC72FlmqifjbZdqVXxA
 9kHPaTl76sB/SIvmlL0FKwp/yCacgo+/NuMlE33g4XTCGdE+SXXsc/qlnvaQsW4S2HGmA3gp8dB
 p/i4aSS6cytgrOhOv5g==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11900
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=10 bulkscore=10 adultscore=0 suspectscore=0 lowpriorityscore=10
 spamscore=0 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609090248

Since commit 2729a60bbfb9 ("block: don't silently ignore metadata for
sync read/write"), blkdev_direct_IO() sends every IOCB_HAS_METADATA
request to __blkdev_direct_IO(). Remove the now unreachable metadata
mapping in __blkdev_direct_IO_async() and the unmap in its completion
handler.

No functional change.

Assisted-by: Claude:claude-fable-5
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 block/fops.c | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 0b614d76d128..6a86bffafa7a 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -306,9 +306,6 @@ static void blkdev_bio_end_io_async(struct bio *bio)
 		ret = blk_status_to_errno(bio->bi_status);
 	}
 
-	if (bio_integrity(bio))
-		bio_integrity_unmap_user(bio);
-
 	iocb->ki_complete(iocb, ret);
 
 	if (dio->flags & DIO_SHOULD_DIRTY) {
@@ -366,13 +363,6 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 		task_io_account_write(bio->bi_iter.bi_size);
 	}
 
-	if (iocb->ki_flags & IOCB_HAS_METADATA) {
-		ret = bio_integrity_map_iter(bio, iocb->private);
-		WRITE_ONCE(iocb->private, NULL);
-		if (unlikely(ret))
-			goto out_bio_put;
-	}
-
 	if (iocb->ki_flags & IOCB_NOWAIT)
 		bio->bi_opf |= REQ_NOWAIT;
 
-- 
2.39.5


