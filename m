Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EFB8C6FD18
	for <linux-block@archiver.kernel.org>; Fri, 31 Mar 2023 03:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjCaDpu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 30 Mar 2023 23:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbjCaDps (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 30 Mar 2023 23:45:48 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38DB18811
        for <linux-block@vger.kernel.org>; Thu, 30 Mar 2023 20:45:42 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230331034530epoutp01ff4e376f5d2fab00ddf3bfabae4a5e22~RZDjDkj3_2582925829epoutp01R
        for <linux-block@vger.kernel.org>; Fri, 31 Mar 2023 03:45:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230331034530epoutp01ff4e376f5d2fab00ddf3bfabae4a5e22~RZDjDkj3_2582925829epoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680234330;
        bh=qXm9+lNTKVwcC08AAqvFdB9h3bkhkjCTK1uWYH5vW8A=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Ycfn1SJ8UpmFwGHJKphCpWGlXdZ1ebS/3WybBJ8lDFhThQQAzoDDqbrZkPsHB50Ks
         Tp1UlgtVZlN1ueHe+3jgG3zr0TkN3FcggMMLt/ZUjzdGXxWRgdkyAOQaBmKc5sujx8
         cqapLAzs4KCMlTnieQsH+rVGlV0NPRfsYX4K5cnI=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230331034530epcas5p104e81f25088a4f42736831711e2c4765~RZDi1Yxx11867618676epcas5p12;
        Fri, 31 Mar 2023 03:45:30 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PnmQd36FXz4x9Ps; Fri, 31 Mar
        2023 03:45:29 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D2.D3.55678.55756246; Fri, 31 Mar 2023 12:45:25 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230331034524epcas5p31c3793c0c2071846ed82ff0f1369e90d~RZDdY27nn0975909759epcas5p3j;
        Fri, 31 Mar 2023 03:45:24 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230331034524epsmtrp1692c2b7d44fcc90eb2b1dfb3776be603~RZDdYAzYs1855118551epsmtrp19;
        Fri, 31 Mar 2023 03:45:24 +0000 (GMT)
X-AuditID: b6c32a4a-6a3ff7000000d97e-f8-642657556a6d
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        BD.A6.18071.45756246; Fri, 31 Mar 2023 12:45:24 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230331034522epsmtip145a565caaf9a7ee372cd47b6e4902503~RZDbWQp631781417814epsmtip1u;
        Fri, 31 Mar 2023 03:45:22 +0000 (GMT)
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     shinichiro.kawasaki@wdc.com
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        mcgrof@kernel.org, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH blktests 0/2] nvme uring-passthrough test
Date:   Fri, 31 Mar 2023 09:14:12 +0530
Message-Id: <20230331034414.42024-1-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGKsWRmVeSWpSXmKPExsWy7bCmpm5ouFqKQcsKTouj/9+yWey9pW0x
        f9lTdosbE54yWuyb5enA6rFpVSebx+Yl9R59W1YxenzeJOfRfqCbKYA1KtsmIzUxJbVIITUv
        OT8lMy/dVsk7ON453tTMwFDX0NLCXEkhLzE31VbJxSdA1y0zB2izkkJZYk4pUCggsbhYSd/O
        pii/tCRVISO/uMRWKbUgJafApECvODG3uDQvXS8vtcTK0MDAyBSoMCE749O/96wF35krPjak
        NjD2MXcxcnJICJhIXDv+m6mLkYtDSGA3o8TO0+fYIJxPjBLH76xhAakSEvjGKHFrThhMx/NL
        HYwQRXsZJa696Idq/8wocb73HVCGg4NNQFPiwuRSkAYRAXmJlbObWUFsZoFKiRVNB9lBbGEB
        S4nJLcuYQGwWAVWJNd1nwWp4BSwkbi9fxw6xTF5i5qXv7BBxQYmTM5+wQMyRl2jeOpsZZK+E
        wC52iTcvf7BBNLhI9C7exwhhC0u8Or4FapCUxMv+Nig7WeLSzHNMEHaJxOM9B6Fse4nWU/3M
        IPczA92/fpc+xC4+id7fT5hAwhICvBIdbUIQ1YoS9yY9ZYWwxSUezlgCZXtIXPh6BWyKkECs
        xJdVtRMY5WYheWAWkgdmIexawMi8ilEytaA4Nz212LTAKC+1HB6Ryfm5mxjBCU7Lawfjwwcf
        9A4xMnEwHmKU4GBWEuEtNFZNEeJNSaysSi3Kjy8qzUktPsRoCgzVicxSosn5wBSbVxJvaGJp
        YGJmZmZiaWxmqCTOq257MllIID2xJDU7NbUgtQimj4mDU6qBadKNxV29GifLdphtMClx8ui4
        PGFGXFoF7yHu04VPqpfas4haeoX5Cf5ctfXXw9f1l6cHOU+b+L2DrVn6pGiYpN2UznfcO/d2
        cvFF7js8r+yjvGZf589PbLMmOOVVRrsYKwgx356/TZnjstfu156LnbfGfGVsevqzbNfSh07J
        d+Ytbi87s9RuK0/uzksLp0aLH4uef+Amv1GsfUJGzSL3A2cU/3ple0qKMe/Py9EpKt9w5sW5
        229nFh61NBXf2du7L0qff5uI3tLboq8m/7YvLTvor7KTzajzbCLXjj98OfVnJ8gud/kelGj7
        XzOW4/B2HYmVMmtXf9YwE/8pdjjXMn7mlJsmYQdWi8w5pplwQYmlOCPRUIu5qDgRAHReU1T5
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrALMWRmVeSWpSXmKPExsWy7bCSnG5IuFqKwZvPBhZH/79ls9h7S9ti
        /rKn7BY3JjxltNg3y9OB1WPTqk42j81L6j36tqxi9Pi8Sc6j/UA3UwBrFJdNSmpOZllqkb5d
        AlfGp3/vWQu+M1d8bEhtYOxj7mLk5JAQMJF4fqmDsYuRi0NIYDejxO7Fv5ggEuISzdd+sEPY
        whIr/z1nhyj6yCjxcclZoCIODjYBTYkLk0tBakQE5CVWzm5mBbGZBWolps28BWYLC1hKTG5Z
        BjaTRUBVYk33WbA4r4CFxO3l66Dmy0vMvPSdHSIuKHFy5hMWiDnyEs1bZzNPYOSbhSQ1C0lq
        ASPTKkbJ1ILi3PTcYsMCw7zUcr3ixNzi0rx0veT83E2M4EDU0tzBuH3VB71DjEwcjIcYJTiY
        lUR4C41VU4R4UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpg
        Yj6jVFO53+tFWWzb2buiWeq//boeR3iFfgybzvnlfbdTvhr/ks/O83w6VT/fLz927npU6Dn7
        +x8k4h0uv1q60zXxGJ9XRt2k4zu387zY8brAwNWyaH3T7CUXfXgV2CQ1tr+9mB7FtPmJK2fA
        DPdZh9hylxzwzOiec//20innTp4Nd3tevuvrft1lwVnr+eQCPjFnZWrs3NPBubrqzdV866vT
        19z44nXiY1q5LOe9vasdiiWbt/zdGcBol/iH95Ulj65Hs+qbgy4HX7+bcyT7sNvjRXOmPo/i
        vX1P+5J66fT5M7k+H1gqcD+Wde13Mbv3l//Y8V1ft+Te5HTHwm2Bs7aKxrolKuduKqlkm85t
        q6LEUpyRaKjFXFScCAA6WN08swIAAA==
X-CMS-MailID: 20230331034524epcas5p31c3793c0c2071846ed82ff0f1369e90d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230331034524epcas5p31c3793c0c2071846ed82ff0f1369e90d
References: <CGME20230331034524epcas5p31c3793c0c2071846ed82ff0f1369e90d@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Patch 1: contains a little helper for fio version check
Patch 2: contains few tests for uring-passthrough on NVMe device

Kanchan Joshi (2):
  common,fio: helper for version check
  nvme/047: add test for uring-passthrough

 common/fio         | 14 ++++++++++++++
 tests/nvme/047     | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/nvme/047.out |  2 ++
 3 files changed, 62 insertions(+)
 create mode 100755 tests/nvme/047
 create mode 100644 tests/nvme/047.out

-- 
2.25.1

