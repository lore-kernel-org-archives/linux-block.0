Received: from mx0a-00364e01.pphosted.com (mx0a-00364e01.pphosted.com [148.163.135.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91E13AC0C3
	for <linux-block@vger.kernel.org>; Sun,  2 Aug 2026 11:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785669305; cv=none; b=ibObJGGk/wgELoCBR7GZ8WbJgH4r0vxwhW3KG2jwGIMnAiSkPSyqI53MlaChwCS7HydZOXF8ylwp1uFkJR8qdQXlxWsighzrQjax68lwzDuTnJeIDMA6e3boJNOGbl7JbNRhwjJhHClOKgAiZK3TH0xZPWSucAwmq3cX1u2IK2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785669305; c=relaxed/simple;
	bh=nqi5SVdPgj60DLFNV8hMjaRd+M1KFnZMQ4Z04XcbmX8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=TCYoTusVJl0t9uN+E0KY2FuAMp//6o/BCePLOFcu4U1QiRvFgfjiL25IdW7FwnO/BbtUTEcPyqtLTHn6r8FbX8tCKyqyJ3Z3Q9XfExk2UMLeK1FdvRw0Gw6OvpYkzAsqsa0VpddfPge0JImovFMoIUUjtJeNyZU7V3S9egZaXTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu; spf=pass smtp.mailfrom=columbia.edu; dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b=BDBkrbYr; arc=none smtp.client-ip=148.163.135.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=columbia.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=columbia.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=columbia.edu header.i=@columbia.edu header.b="BDBkrbYr"
Received: from pps.filterd (m0167072.ppops.net [127.0.0.1])
	by mx0a-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672A0FR73146342
	for <linux-block@vger.kernel.org>; Sun, 2 Aug 2026 07:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pps01; bh=OXHOQJXSYXpIJM0xdhOE9lspGw
	2ZMSlGLW2FlW8SCII=; b=BDBkrbYr6PIV+rfhIgek7RHchg1+Dyg9fS6UPkkaZf
	VehfN8TL9oyieCGPmxryoffga2fKUtcW/Lg63Wrlc4G2BQ1jtN0nrpMntoK5PXpf
	thGjYtVz8K3v62uoyTZLVbXkKDLRctViJxA1kRweKntokcrf/qw7taizzBnFanR2
	xYOkDxOomAv78zrnsbyB9QwWjNo71oDfhLU+z72HvDaYxwlxy95beuJic1BHiLws
	HqfdAapO3qgD3qfczK5cvSYQhfoErrLu9iuDp6DZC46dFuEC09tho4wmKu/nlFeH
	SzwUG77QAo6diIxKmORs0UyEW7IC8rAenov5Igetwm8Q==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com [209.85.219.72])
	by mx0a-00364e01.pphosted.com (PPS) with ESMTPS id 4fscyp4957-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-block@vger.kernel.org>; Sun, 02 Aug 2026 07:14:54 -0400 (EDT)
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-8efe7db1c42so28041316d6.3
        for <linux-block@vger.kernel.org>; Sun, 02 Aug 2026 04:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785669293; x=1786274093;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OXHOQJXSYXpIJM0xdhOE9lspGw2ZMSlGLW2FlW8SCII=;
        b=QwO7O1bjAxypSgfMWB6lqnWzkrv0EiT+58WoZNS03ZFEhUmM7c5tC5tiD9TpWyCZkk
         WyPKNl0xgSavo1zkzW/S1hUt6O35VebBghQLgiOxYkqyb19yBzEP2vImwqMPz16DJfKr
         qRd1r9uV1KrIkKZnKgMpgb2nSeLqntNMQrkhY2TAKQZy2ANB32X1gK+fryTrBigoHKhK
         erAkIshYpRGqWfumJWJAugVAiSE7AQe8vHEtNheOSv/X8YPbMheWenGTkKvF1LlfXmKv
         CQOGO1C4ZI7hpXfniLqnxpeHwfyAjO+znIEeqWlQI+Pg8AyNeXizrecF+Lrteq//1A/U
         3QsQ==
X-Gm-Message-State: AOJu0YyPSfMFVjMfQMcvj5RZXZJd9E+NSdOE1iaTSsyFMgt9p/zSPF9F
	kP8BygGL1EdpCDQcWIZTq3KRsBpwbBwKnrlhpA1apbUxGAI8iU/v244t4GQ2HgwYOWunZrNyFNL
	D2FdNY/8agplAdgNQuwhLlvCX0vmDHgsaSqTBuIsowhztLgLvBcMS8IkBZkZn
X-Gm-Gg: AR+sD12NVly2Sher58Lz3zV7Hh6iykxsp9YMdfE4OYLQ9YfMZq9stwpniCBVT8dIFoN
	o818SYSgtt1l5YkzoJu5uZXLZXpnb+W8PI0XQ0VNRgwFyxApjA9u2hd+P7DTlAMFps9C9K3vZia
	gfJzaJIi9aqeRAW5fAr0dB2bGrox1wGb5jyVIamTe6OKQex1ZTU4ebFKxNIU9C05NBv2HO5CmVk
	HqpaJvhRln1/Jpb+UklGfMjbbIKv/U3B9StzwYCRwWfuJ94KKZ8Xn+tITYLxLYcvWIUcF6PfIoy
	DRKb0wwMzSJzJh6bpsxARtUAd3zrbV8Dq45gNm/+B4nYPoIl9KUrdSFOchY0I76YOHP80BSRSMx
	76Z+exLEFxk3DHVMI9YX2pLBZ9H+o6d4sGYuzt5xcqjf/xWMYZWQ=
X-Received: by 2002:a05:622a:1e0f:b0:51c:21d1:3852 with SMTP id d75a77b69052e-52b5676001fmr131469911cf.5.1785669293672;
        Sun, 02 Aug 2026 04:14:53 -0700 (PDT)
X-Received: by 2002:a05:622a:1e0f:b0:51c:21d1:3852 with SMTP id d75a77b69052e-52b5676001fmr131469531cf.5.1785669293198;
        Sun, 02 Aug 2026 04:14:53 -0700 (PDT)
Received: from [127.0.1.1] (CBL217-132-158-98.bb.netvision.net.il. [217.132.158.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49807b917efsm208062155e9.11.2026.08.02.04.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 04:14:52 -0700 (PDT)
From: Tal Zussman <tz2294@columbia.edu>
Subject: [PATCH 0/2] block device write path fixes
Date: Sun, 02 Aug 2026 07:14:25 -0400
Message-Id: <20260802-blkdev-fixes-v1-0-a82fc549fd74@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJEmb2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDCwND3aSc7JTUMt20zIrUYl1zc8Mkw2RjQ5PUpCQloJaColSwBFBHdCy
 EX1yalJWaXAIyQ6m2FgD3nb7rcAAAAA==
X-Change-ID: 20260801-blkdev-fixes-771b1c314ebb
To: Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tal Zussman <tz2294@columbia.edu>, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.14.3-dev-d7477
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785669291; l=1456;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=nqi5SVdPgj60DLFNV8hMjaRd+M1KFnZMQ4Z04XcbmX8=;
 b=d9AErRvGwo1lUJ92LIPfsJlRo3HzhJudn+bijpjys+m3YIMM2zOBVnOksQKR2piG5erwJROsu
 cSe/4U3lOddBYzLDF3b+YWpbR681o2wTmRG7JhR86uZDto0tkuujKID
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: BODg6PlvK7Y7GMwuyVVaLzXGDc6x8IYm
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAyMDA5NSBTYWx0ZWRfX2ZwC8Awiga32
 K7nCBBB6EWlSXb1R9SWfD6yBoa0BdIVMHcynQekoNSIA0o5LQWCBqU1SgcPzB/2ppnInYzOLKsW
 6tXgQF3cPyuJ9WMD7ghydjjAl9go8l78O2QC3kvnx2Ni4yyNEwLF
X-Proofpoint-ORIG-GUID: BODg6PlvK7Y7GMwuyVVaLzXGDc6x8IYm
X-Authority-Analysis: v=2.4 cv=LJ9WhpW9 c=1 sm=1 tr=0 ts=6a6f26ae cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=C4zMR0+CEq2lM/mtmjScOA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=x7bEGLp0ZPQA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=SsB-OO3BMngHh3ZO9fOt:22
 a=VwQbUJbxAAAA:8 a=VfL1AaAevc5-fGJ07oQA:9 a=QEXdDO2ut3YA:10
 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAyMDA5NSBTYWx0ZWRfX0AosIAHXz7eR
 B4h3ND638x9Myn2pP3luQwxpO4MBrlo0R7s8yNVEqHCHXRj/ZYsf11POoxfy6jCR+lfK7jZis8c
 5Ak4XM695U8PL/aQd3Tz9j2XY2yaBRrYfDX0VSQ4kRp5+nY/8PRgCk3lj41OV8P6C3LNlCWmV3k
 ksojgMOec9HVrVwy+pVc6gixVz9yfBuFJbl5p5mZ/bfM60PTj0UgL7ClLxOrBvv/f6xzg36h2DU
 n3CPDnJ+E28LT8VvHHzmw4exbDV1vV4RGDaAPMLMrHAOtCtEvgJOqvqQRVkoc5kPRqw3H8SQV6x
 Ep+bBL3gcyOPsZlVqTGSm9U0rR3LIjJxRjDyouz8Xzxgm5V6N2WU5vvaOFQJsXstpY4UOjneYsK
 3BqgpVjIB/2HZ827XldomqDhZbFcBZcTLbUgkSzvvOW42E64M9N2nAqHhz9E/kd5iasHUMXw30O
 P0EPPvDa1xcAqYPDk+Q==
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11862
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=10 phishscore=0 bulkscore=10 impostorscore=10 spamscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608020095

Two independent fixes for the block device write path. Both issues were
found by Sashiko during review of the "block: enable RWF_DONTCACHE for
block devices" series [1] and are independent of it.

Patch 1 fixes silently lost mmap writes with CONFIG_BUFFER_HEAD=n:
def_blk_aops uses filemap_dirty_folio, which does not set the
per-block dirty bits in the folio's iomap_folio_state, so writeback
finds no dirty blocks and submits no I/O.

Patch 2 makes blkdev_write_iter() take i_rwsem shared around the
buffered-write fallback for a partial direct I/O write. The fallback
currently runs with no lock held and races set_blocksize() changing
i_blkbits and the mapping's minimum folio order, which can trip
VM_BUG_ON_FOLIO in __filemap_add_folio() on kernels with block sizes
above PAGE_SIZE.

Both issues are currently unlikely to be hit in practice due to the
specific configurations required to trigger them.

[1] https://lore.kernel.org/all/20260730-blk-dontcache-v7-0-3e8e6850068d@columbia.edu/

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
Tal Zussman (2):
      block: use iomap_dirty_folio for block devices
      block: take i_rwsem for the direct I/O write fallback

 block/fops.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)
---
base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
change-id: 20260801-blkdev-fixes-771b1c314ebb

Best regards,
-- 
Tal Zussman <tz2294@columbia.edu>

