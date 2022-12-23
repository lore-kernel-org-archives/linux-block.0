Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9861C4332F
	for <linux-block@archiver.kernel.org>; Fri, 23 Dec 2022 13:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236142AbiLWNLy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 23 Dec 2022 08:11:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiLWNLt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 23 Dec 2022 08:11:49 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF18DFE3
        for <linux-block@vger.kernel.org>; Fri, 23 Dec 2022 05:11:47 -0800 (PST)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20221223131144epoutp021db1de5946760c1317501c13654eec11~zbj9Qjgbu2692726927epoutp02a
        for <linux-block@vger.kernel.org>; Fri, 23 Dec 2022 13:11:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20221223131144epoutp021db1de5946760c1317501c13654eec11~zbj9Qjgbu2692726927epoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1671801104;
        bh=ys4cNgNp+Lt8cfq7z2qs4gP/1oOPjeqW0KDkwBWr2pA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SEDGK9jmge3Am5iaJUDQF1wQ48rcSM6kSFQtb+Iu/8uenYdDfRVD8IxxVu8n0KgFR
         thtIglVNIzpY1od77eMsNuzbT/+cjcK3YyqM1z0iRwFyP4KJ67oDGCz98fSbqjOe47
         71e8o97r8ePOxQMD2Eql6G0fwEKJANDtedhJlX90=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20221223131143epcas5p17ba48ad59d2514f2201525f307deafe9~zbj8M19Dw0259602596epcas5p1d;
        Fri, 23 Dec 2022 13:11:43 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4NdndB4RYYz4x9Pq; Fri, 23 Dec
        2022 13:11:42 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AD.25.03362.E09A5A36; Fri, 23 Dec 2022 22:11:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20221223131142epcas5p2f30d722bd9c9465b8807de9746492dfa~zbj6rpxnz1431614316epcas5p23;
        Fri, 23 Dec 2022 13:11:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20221223131142epsmtrp2ad4ddd606899055ec19d09a6a32bc442~zbj6q_M312168421684epsmtrp2h;
        Fri, 23 Dec 2022 13:11:42 +0000 (GMT)
X-AuditID: b6c32a4b-287ff70000010d22-e7-63a5a90e824e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E9.33.02211.D09A5A36; Fri, 23 Dec 2022 22:11:41 +0900 (KST)
Received: from green (unknown [107.110.206.5]) by epsmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20221223131140epsmtip1f2f6acb40018f29c521633963b0232de~zbj5bDVaT2911429114epsmtip16;
        Fri, 23 Dec 2022 13:11:40 +0000 (GMT)
Date:   Fri, 23 Dec 2022 18:41:37 +0530
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     osandov@fb.com, j.granados@samsung.com, anuj20.g@samsung.com,
        ankit.kumar@samsung.com, vincent.fu@samsung.com,
        ming.lei@redhat.com, linux-block@vger.kernel.org
Subject: Re: [PATCH 2/6] tests/nvme: add new test for rand-read on the nvme
 character device
Message-ID: <20221223131137.GA27984@green>
MIME-Version: 1.0
In-Reply-To: <20221221103441.3216600-3-mcgrof@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnk+LIzCtJLcpLzFFi42LZdlhTQ5dv5dJkg1XH5C3WXPnNbtE04S+z
        xdL9Dxkt9t7Strgx4SmjxaHJzUwWh+9dZbF43N3B6MDhMbH5HbvHplWdbB7v911l8+jbsorR
        4/MmuQDWqGybjNTElNQihdS85PyUzLx0WyXv4HjneFMzA0NdQ0sLcyWFvMTcVFslF58AXbfM
        HKBTlBTKEnNKgUIBicXFSvp2NkX5pSWpChn5xSW2SqkFKTkFJgV6xYm5xaV56Xp5qSVWhgYG
        RqZAhQnZGcvv5xesE6j4/b2ZrYHxIW8XIyeHhICJROfR9exdjFwcQgK7GSW6tt5mg3A+MUp8
        37yIEaRKSOAbo8Tm/VFdjBxgHXtOQ9XsZZTY9OsFK4TzmFHi5bfLYA0sAqoSU7Z2M4M0sAlo
        SlyYXAoSFhHQkNg3oZcJpJ5ZYDmjxOm9O9lBEsICcRKn97SC9fIKaEk8/bSHCcIWlDg58wkL
        iM0pYCnRs3cqmC0qoCxxYNtxsEESAn/ZJU6u72SFuM5F4uNZF4jXhCVeHd/CDmFLSXx+t5cN
        wk6WuDTzHBOEXSLxeM9BKNteovVUPzOIzSyQIXHwzSNGCJtPovf3EyaI8bwSHW1CEOWKEvcm
        PWWFsMUlHs5YAmV7SLy9sY4VEm7AEL22rHYCo9wsJN/MQrIBwraS6PzQxDoLaAOzgLTE8n8c
        EKamxPpd+gsYWVcxSqYWFOempxabFhjnpZbDIzg5P3cTIzhlannvYHz04IPeIUYmDsZDjBIc
        zEoivFseL04W4k1JrKxKLcqPLyrNSS0+xGgKjJ2JzFKiyfnApJ1XEm9oYmlgYmZmZmJpbGao
        JM6bunV+spBAemJJanZqakFqEUwfEwenVAPTZfbJB7+r7uvpNZA4t/yxlJzI+mulS97O//2a
        KYYpg2/iwXsK+0xdfzY+2On857TcmX37DilkblOqybzGPO3g3k/+zFu0e6LZLGVPdk2cMHPq
        ujU/LTP3NJ94q21UYvhj2q93eSc/NFtLW89vv3P4Yum8XzOCPmRYigZsKbtgd/H9ZsmLH32t
        05y83ZyKVmY+5T/axFu9sNnPuaK4n/HIpL7L+jluZrkbGlZ5//4QkhC/+lqAuD6bScW7h9Fx
        jTzXY88fCZ8999zTF209wlMPv17HN1E1Vd1EbtfToM0xLd7z11eoVvxI4PurLX/4fIInU9D9
        TUt2ipZNt3OUfceS7ywVf+Vo2hMnhsDH08/pKLEUZyQaajEXFScCAISG09QiBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrALMWRmVeSWpSXmKPExsWy7bCSnC7vyqXJBjtPWlmsufKb3aJpwl9m
        i6X7HzJa7L2lbXFjwlNGi0OTm5ksDt+7ymLxuLuD0YHDY2LzO3aPTas62Tze77vK5tG3ZRWj
        x+dNcgGsUVw2Kak5mWWpRfp2CVwZ3yYuZSt4wFvx6OF/xgbGtdxdjBwcEgImEntOs3UxcnEI
        CexmlLi25jpLFyMnUFxcovnaD3YIW1hi5b/n7BBFDxklts9dCVbEIqAqMWVrNzPIIDYBTYkL
        k0tBwiICGhL7JvQygdjMAssZJR5/SQKxhQXiJE7vaWUEsXkFtCSeftrDBLf4wvavTBAJQYmT
        M5+wQDSbSczb/BBsPrOAtMTyfxwgYU4BS4mevVPBSkQFlCUObDvONIFRcBaS7llIumchdC9g
        ZF7FKJlaUJybnltsWGCYl1quV5yYW1yal66XnJ+7iREcCVqaOxi3r/qgd4iRiYPxEKMEB7OS
        CO+Wx4uThXhTEiurUovy44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamAS
        3d/GvUorWMgtI9c0ObFI9oA9827nxhzTJtci/RIx9WLukik/TeRurz78fWJkS3w507nGtR+O
        uU/NNnbKrZ5cstgvVIUnwrfcfkaw2/4fisVex8q8pyfu955vp5am7jPz1b+2k8GLpDx0bBdu
        DeH/Xv3isLmuX0Peu6VL1fYc2CyldGZGmodo6v7c01t0lfJ2T9P3sjNdc66EPVk23ODFm662
        VXZidn/rTp068bPIxzU9P+/OjN3Kc7fm3n26JPpc1PftLY75Svu0phRVaqnFLJ4VsG/i/9L2
        yQmzq5Qdn62RucDjXZJ/uTc8KC74hVVK3eQ7PSLvlq7V+mzirb7fgO9SpvPlIk0Gran3lViK
        MxINtZiLihMBtGllTfMCAAA=
X-CMS-MailID: 20221223131142epcas5p2f30d722bd9c9465b8807de9746492dfa
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----d7wgNpQcY-y3Wxr.o4x8P.ZM-s8jhIouQULCgAQexljrVMsg=_55b46_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221221103532epcas5p2c806adb12a32e259438511a584216c11
References: <20221221103441.3216600-1-mcgrof@kernel.org>
        <CGME20221221103532epcas5p2c806adb12a32e259438511a584216c11@epcas5p2.samsung.com>
        <20221221103441.3216600-3-mcgrof@kernel.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

------d7wgNpQcY-y3Wxr.o4x8P.ZM-s8jhIouQULCgAQexljrVMsg=_55b46_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Wed, Dec 21, 2022 at 02:34:37AM -0800, Luis Chamberlain wrote:
>This does basic rand-read testing of the character device of a
>conventional NVMe drive.
>
>Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
>---
> tests/nvme/046     | 42 ++++++++++++++++++++++++++++++++++++++++++
> tests/nvme/046.out |  2 ++
> 2 files changed, 44 insertions(+)
> create mode 100755 tests/nvme/046
> create mode 100644 tests/nvme/046.out
>
>diff --git a/tests/nvme/046 b/tests/nvme/046
>new file mode 100755
>index 000000000000..3526ab9eedab
>--- /dev/null
>+++ b/tests/nvme/046
>@@ -0,0 +1,42 @@
>+#!/bin/bash
>+# SPDX-License-Identifier: GPL-3.0+
>+# Copyright (C) 2022 Luis Chamberlain <mcgrof@kernel.org>
>+#
>+# This does basic sanity test for the nvme character device. This is a basic
>+# test and if it fails it is probably very likely other nvme character device
>+# tests would fail.
>+#
>+. tests/nvme/rc
>+
>+DESCRIPTION="basic rand-read io_uring_cmd engine for nvme-ns character device"
>+QUICK=1
>+
>+requires() {
>+	_nvme_requires
>+	_have_fio
>+}
>+
>+device_requires() {
>+	_require_test_dev_is_nvme
>+}
>+
>+test_device() {
>+	echo "Running ${TEST_NAME}"
>+	local ngdev=${TEST_DEV/nvme/ng}
>+	local fio_args=(
>+		--size=1M
>+		--cmd_type=nvme
>+		--filename="$ngdev"
>+		--time_based
>+		--runtime=10
>+	) &&

Is this && needed?

>+	_run_fio_rand_iouring_cmd "${fio_args[@]}" >>"${FULL}" 2>&1 ||

Something to change here (and therefore in other patches too).
If we change "cmd_type = something_random", test continues to show the
success while it should show failure.

How about changing above line to:
_run_fio_rand_iouring_cmd "${fio_args[@]}" || fail=true

And thanks for the series.


------d7wgNpQcY-y3Wxr.o4x8P.ZM-s8jhIouQULCgAQexljrVMsg=_55b46_
Content-Type: text/plain; charset="utf-8"


------d7wgNpQcY-y3Wxr.o4x8P.ZM-s8jhIouQULCgAQexljrVMsg=_55b46_--
