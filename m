Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154B2C2E0;
	Tue, 12 Aug 2025 03:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754970095; cv=none; b=Q1oyoARY6h+fcR15FOjRKQgmNpbCtDETEIrXymHRxBBe4dGZsakC/VM2HUPboddmzSKUBJXrWTv7Oocy4SZ1AOT1enZlY65jShNW4uNWuCRT0FouB3/xn27G3Ppn5G9KnhAszWCXVECDnLr/yP8oUuBb0n4Cw/GZoHOdRmk/9no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754970095; c=relaxed/simple;
	bh=QgvHaxSeDbIVQUHk12TJMQ6so4DmVH6KtnZCKhWLR8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C9CnJs1HtDVLOeB1vwsv5IGKADhdbP/BAa+lHPrSDQ6e4ceA+QpKvvFlJyXTQ8cPje2tYwJyHapmK2iFKiaczZ0g75xs6GqI6ZwZ9nJ28J+mF5Jtza9z8wVfB8JEKNEXew3bmQUseKLug8GzXMEo+bVRhf0GlAj3wsaHvmP13F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=KSl2CexN; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="KSl2CexN"
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C3Wmeo000846;
	Tue, 12 Aug 2025 03:41:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pps0720; bh=MnGBmYgqbRUxk
	pdO5d15KMIfStl62/cGlh7Nl6XccLU=; b=KSl2CexNxcIULiWRD3y6CT5a+C2YO
	7DmtuwCR69S16aGrxs6T55AmkPy9btdHgNRjknsKaHi/xhnHNLaf1eSNDIW0bdfE
	ANuYlKAJfJZMwswrBq6t0X8OqZDZ5NsXIPDDC7ERpAtS8zJuGf5EPmiJrvxzCXCz
	2YFFtFwwtIZSlY0TthCN1jF7reXWIEzQkW5eeXE94wY21PLpzyFXME4YF54yOKEY
	ZULhLCxzvI3Tys8UGA8Rn76tje8Gobm19NOn89E88dNvs+hWR2IEfi6ssFC0e5/7
	SPn4WGKNvdkH4mEB9Lkgu9jaJK40hH7CaaUmmVIqmQD8WCVK0HeHliXUA==
Received: from p1lg14881.it.hpe.com ([16.230.97.202])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 48ewkrwxb8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Aug 2025 03:41:04 +0000 (GMT)
Received: from test-build-fcntl.hpe.com (unknown [192.58.206.38])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14881.it.hpe.com (Postfix) with ESMTPS id 7E270805E2C;
	Tue, 12 Aug 2025 03:41:02 +0000 (UTC)
Received: by test-build-fcntl.hpe.com (Postfix, from userid 1000)
	id 17C178800130; Tue, 12 Aug 2025 03:32:02 +0000 (UTC)
From: Rajeev Mishra <rajeevm@hpe.com>
To: axboe@kernel.dk, yukuai1@huaweicloud.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dlemoal@kernel.org
Subject: Re: [PATCH v2] loop: use vfs_getattr_nosec() for accurate file size
Date: Tue, 12 Aug 2025 03:32:01 +0000
Message-ID: <20250812033201.225425-1-rajeevm@hpe.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <a8041180-03f2-3342-b568-867b3f295239@huaweicloud.com>
References: <a8041180-03f2-3342-b568-867b3f295239@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDAzMSBTYWx0ZWRfX80kH5S3ZBHZn
 LH+sCWpao2Dw5Qxy21GSNbuaXDO65cMYfxRKGt2L+1NRQnORTQRIrVqXXz8w34Osz3Wl61NisPm
 U9KcZ7DuOV3DqMeIpPRmY3DTDmm7gOQI+cSbhe86R+gkbcRMXs87ksNv91PthCcLstpfTqySQCB
 Y3VQEsCzGE22c9bS/iCqIvPZmmkY0kToJFPeC6n+tETNE9HDn0Tv9xysETiQKGxMPMp7bu+L4q7
 ERGabHanB+3esNQSDZ0vFMciV8TgjuGWRsRbxmdK4RRV1X/miZQnuVgtiv3S3pnJ+bPiO4x1Km5
 prFzjp9t8JlTOKNn4t4Kr7/mfTX5xtefNfTvTN7Z6mblyfMxbh/rb2siadIBnylEczKrgUXZF5e
 qwJsJr9L1jdq1v9HR1sYC37g/TggKknXrg1fQc1uqYHJ0dB4o4jBpoqxbnSu0leofeThR1gM
X-Authority-Analysis: v=2.4 cv=aelhnQot c=1 sm=1 tr=0 ts=689ab7d0 cx=c_pps
 a=FAnPgvRYq/vnBSvlTDCQOQ==:117 a=FAnPgvRYq/vnBSvlTDCQOQ==:17
 a=2OwXVqhp2XgA:10 a=zVteXimfv2qfp4qxOFMA:9
X-Proofpoint-GUID: 5dok6cb-zcoeWRy9zEgEn7KtNYpnkmJu
X-Proofpoint-ORIG-GUID: 5dok6cb-zcoeWRy9zEgEn7KtNYpnkmJu
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=977
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 mlxscore=0 clxscore=1011
 impostorscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508120031

Hi Kuai,

Thank you for the feedback on the v2 patch regarding error handling.

Yu mentioned:
> return 0 here is odd. Why not "return ret;" to propagate the error if any ?

I understand the concern about proper error propagation. However, there's a 
type compatibility issue I'd like to discuss before implementing v3:

1. Current function signature: `static loff_t get_size(...)` 
   - Returns size as positive loff_t (unsigned 64-bit)  
   - All callers expect non-negative size values

2. vfs_getattr_nosec() error codes are negative integers (-ENOENT, -EIO, etc.)
   - Returning `ret` would cast negative errors to huge positive numbers
   - This could cause loop devices to appear as exabyte-sized

3. Current callers like loop_set_size() don't handle error checking

Would you prefer for v3:
a) Change function signature to `int get_size(..., loff_t *size)` and update all callers  
b) Different approach?

diff with ret approach

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index c418c47db76e..15117630c6c1 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -142,12 +142,13 @@ static int part_shift;
  * @offset: offset into the backing file
  * @sizelimit: user-specified size limit
  * @file: the backing file
+ * @size: pointer to store the calculated size
  *
  * Calculate the effective size of the loop device
  *
- * Returns: size in 512-byte sectors, or 0 if invalid
+ * Returns: 0 on success, negative error code on failure
  */
-static loff_t get_size(loff_t offset, loff_t sizelimit, struct file *file)
+static int get_size(loff_t offset, loff_t sizelimit, struct file *file, loff_t *size)
 {
        struct kstat stat;
        loff_t loopsize;
@@ -159,7 +160,7 @@ static loff_t get_size(loff_t offset, loff_t sizelimit, struct file *file)
         */
        ret = vfs_getattr_nosec(&file->f_path, &stat, STATX_SIZE, 0);
        if (ret)
-               return 0;
+               return ret;

        loopsize = stat.size;

@@ -167,7 +168,7 @@ static loff_t get_size(loff_t offset, loff_t sizelimit, struct file *file)
                loopsize -= offset;
        /* offset is beyond i_size, weird but possible */
        if (loopsize < 0)
-               return 0;
+               return -EINVAL;

        if (sizelimit > 0 && sizelimit < loopsize)
                loopsize = sizelimit;
@@ -175,12 +176,20 @@ static loff_t get_size(loff_t offset, loff_t sizelimit, struct file *file)
         * Unfortunately, if we want to do I/O on the device,
         * the number of 512-byte sectors has to fit into a sector_t.
         */
-       return loopsize >> 9;
+       *size = loopsize >> 9;
+       return 0;
 }

 static loff_t get_loop_size(struct loop_device *lo, struct file *file)
 {
-       return get_size(lo->lo_offset, lo->lo_sizelimit, file);
+       loff_t size;
+       int ret;
+
+       ret = get_size(lo->lo_offset, lo->lo_sizelimit, file, &size);
+       if (ret)
+               return 0;  /* Fallback to 0 on error for backward compatibility */
+
+       return size;
 }


I am happy to implement whichever direction you think is best.

Thanks,
Rajeev
