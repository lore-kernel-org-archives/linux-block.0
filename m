Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439BDC433EF
	for <linux-block@archiver.kernel.org>; Thu, 27 Jan 2022 09:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234704AbiA0JKD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Jan 2022 04:10:03 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:44855 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbiA0JKD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Jan 2022 04:10:03 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220127090958epoutp01709f3e52e32957bd0bd9f3570d81e2d6~OFYqO6ajJ2386623866epoutp01x
        for <linux-block@vger.kernel.org>; Thu, 27 Jan 2022 09:09:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220127090958epoutp01709f3e52e32957bd0bd9f3570d81e2d6~OFYqO6ajJ2386623866epoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643274598;
        bh=Y+mWWUq5KrIW95w80LpiEX3FY+7449CWTNZyCE1ubCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jpZuhEP5rXZgAYVno84DaBPK4gwDjy1U6iT81KCg3PoW1EZ8oJD3NDNgZFf6DfLLF
         Edy6J8pPy+J0zoquunykWoqYsXWnLRixBizzrHB6ag/qhC6w3/K69t/7VneTgzNmrG
         nATX1ggz7WX9/5lxq2uFTpeacIF4YolXF+71NBrk=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220127090958epcas5p22a29fe390f28a73902c7dd8e5ed0d0ee~OFYp1au9g1368313683epcas5p2K;
        Thu, 27 Jan 2022 09:09:58 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JkvtR374Kz4x9QV; Thu, 27 Jan
        2022 09:09:51 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        40.81.46822.48F52F16; Thu, 27 Jan 2022 18:01:56 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220127083035epcas5p3e3760849513fb7939757f4e6678405a0~OE2RZ22Lz0624606246epcas5p3V;
        Thu, 27 Jan 2022 08:30:35 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220127083035epsmtrp29b6f9a511985f6d578fafc10a2f97212~OE2RY0-GU2535825358epsmtrp29;
        Thu, 27 Jan 2022 08:30:35 +0000 (GMT)
X-AuditID: b6c32a4a-de5ff7000000b6e6-f8-61f25f84ff05
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        76.85.29871.B2852F16; Thu, 27 Jan 2022 17:30:35 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220127083034epsmtip2a5684ee8ff480064e7093359d8634df9~OE2QcrSXg2260922609epsmtip2o;
        Thu, 27 Jan 2022 08:30:34 +0000 (GMT)
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     hch@lst.de, kbusch@kernel.org, axboe@kernel.dk
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        joshiiitr@gmail.com
Subject: [PATCH 2/2] nvme: add vectored-io support for user passthru
Date:   Thu, 27 Jan 2022 13:55:36 +0530
Message-Id: <20220127082536.7243-3-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220127082536.7243-1-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmk+LIzCtJLcpLzFFi42LZdlhTQ7cl/lOiwfwluhar7/azWaxcfZTJ
        4vzbw0wWkw5dY7TYe0vbYv6yp+wObB47Z91l97h8ttRj06pONo/NS+o9dt9sYPP4vEkugC0q
        2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6AYlhbLE
        nFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToFJgV5xYm5xaV66Xl5qiZWhgYGRKVBhQnZG
        w8yXjAUtAhVfV+1ibWBs4u1i5OSQEDCROHryIHsXIxeHkMBuRomZF66wQDifGCVO/18M5Xxj
        lDjYv4YFpqVn7neolr2MEptXT4ByPjNK/D44G8jh4GAT0JS4MLkUxBQRMJK4/TYGpJdZIEzi
        UM8UsDnCAi4Sna/ngVWzCKhKXLyqDRLmFTCXOPb8GCvEKnmJmZdAVnFycApYSLy68pAVokZQ
        4uTMJywQI+UlmrfOZoaof8QusfKlNoTtIrFt5nQ2CFtY4tXxLewQtpTE53d7oeLFEr/uHGUG
        uV5CoINR4nrDTKgf7SUu7vnLBHIbM9An63fpQ4RlJaaeWscEsZdPovf3EyaIOK/EjnkwtqLE
        vUlPoe4Xl3g4YwmU7SHxe0k/NDy7GSVuzH/HOIFRYRaSf2Yh+WcWwuoFjMyrGCVTC4pz01OL
        TQuM8lLL4XGcnJ+7iRGcKrW8djA+fPBB7xAjEwfjIUYJDmYlEV4hrY+JQrwpiZVVqUX58UWl
        OanFhxhNgeE9kVlKNDkfmKzzSuINTSwNTMzMzEwsjc0MlcR5T6dvSBQSSE8sSc1OTS1ILYLp
        Y+LglGpgUrogG7DiUfX2M/8uvPWNsi5wyr75euq2ldIsP/68W8NwfdnJGdVFvlufCt/elLSr
        texyfkOge7HanDyJQ94Fayp8hSdOuHzqYse66NdxvxP4tUOUes2TDM1lrrQ/b7l7dn6Ys9Ye
        811PfqR+T5nywnxSUvHTf6tqZ/E/vC892ayfOb5lwz6j+aLzdviwJ3J5v9EzeZmzJzB67dfb
        B+8Uhh7bdVv/gON1G6/f6xn6a18wdV1S6LvmJbFmic7ldSlHOh4d3e2rdcpe46l/WPIzl808
        IbvzOJIlfQxqTBKfHJp16crRBpW0XH+JW0bfWDyiviR6hCj9T8vOM58ow/Ve8qdDXvuDx0nL
        ZNwFF5VuVmIpzkg01GIuKk4EAG2ywxQeBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrELMWRmVeSWpSXmKPExsWy7bCSvK52xKdEgz37NS1W3+1ns1i5+iiT
        xfm3h5ksJh26xmix95a2xfxlT9kd2Dx2zrrL7nH5bKnHplWdbB6bl9R77L7ZwObxeZNcAFsU
        l01Kak5mWWqRvl0CV0bDzJeMBS0CFV9X7WJtYGzi7WLk5JAQMJHomfudvYuRi0NIYDejxJQt
        h9ggEuISzdd+sEPYwhIr/z2HKvrIKLH46B7WLkYODjYBTYkLk0tBakQEzCQWLJjHAmIzC0RI
        HNqwiQnEFhZwkeh8PY8dpJxFQFXi4lVtkDCvgLnEsefHWCHGy0vMvPQdbBWngIXEqysPweJC
        QDUXfl1jh6gXlDg58wnUeHmJ5q2zmScwCsxCkpqFJLWAkWkVo2RqQXFuem6xYYFhXmq5XnFi
        bnFpXrpecn7uJkZwMGtp7mDcvuqD3iFGJg7GQ4wSHMxKIrxCWh8ThXhTEiurUovy44tKc1KL
        DzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamBinrxH6UzykrqH33Z85YyJ3XNngeyJ
        J7xcUuWilqIGDD25euritn7tapwV6/O1dBYd237n+P5nsrp3VXisv0WHP7kU2yx92MKkxbnV
        P/rLArkPEo+b3r8I1vJTufLm8KVSpRjTyK/621bJ15l9PJLU98K1YzpvbkDOP6XXFkVmd9Y8
        ee22fG3dh1VPNgQXvgi6cX7miiDu5CCNq+khv1w76lPXvfQNW1CndHChldUPqVc1vcw2Op/7
        zsT4hOi213ttZWfP97zyhbnioZ/p2u83epY6HFoScuFW8+fCbudrrz6EfDL3nTy9UHH96olW
        7DdePjj86LO9f1LA+ZWLd6Szngpvn/Tj8Uc7wyK3FjslluKMREMt5qLiRAAcp0Ge1QIAAA==
X-CMS-MailID: 20220127083035epcas5p3e3760849513fb7939757f4e6678405a0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220127083035epcas5p3e3760849513fb7939757f4e6678405a0
References: <20220127082536.7243-1-joshi.k@samsung.com>
        <CGME20220127083035epcas5p3e3760849513fb7939757f4e6678405a0@epcas5p3.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

wire up support for passthru that takes an array of buffers (using
iovec). Enable it for NVME_IOCTL_IO64_CMD; same ioctl code to be used
with following differences -

1. NVME_IOVEC to be set as cmd.flags
2. cmd.addr, base addr of user iovec array
3. cmd.data_len, count of iovec array elements

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/ioctl.c       | 9 ++++++---
 include/uapi/linux/nvme_ioctl.h | 4 ++++
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 22314962842d..3a896443e110 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -65,6 +65,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	struct bio *bio = NULL;
 	void *meta = NULL;
 	int ret;
+	u8 cmd_flags = cmd->common.flags;
 
 	req = nvme_alloc_request(q, cmd, 0);
 	if (IS_ERR(req))
@@ -75,7 +76,11 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	nvme_req(req)->flags |= NVME_REQ_USERCMD;
 
 	if (ubuffer && bufflen) {
-		ret = blk_rq_map_user(q, req, NULL, ubuffer, bufflen,
+		if (!(cmd_flags & NVME_IOVEC))
+			ret = blk_rq_map_user(q, req, NULL, ubuffer, bufflen,
+				GFP_KERNEL);
+		else
+			ret = blk_rq_map_user_vec(q, req, NULL, ubuffer, bufflen,
 				GFP_KERNEL);
 		if (ret)
 			goto out;
@@ -246,8 +251,6 @@ static int nvme_user_cmd64(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 		return -EACCES;
 	if (copy_from_user(&cmd, ucmd, sizeof(cmd)))
 		return -EFAULT;
-	if (cmd.flags)
-		return -EINVAL;
 	if (!nvme_validate_passthru_nsid(ctrl, ns, cmd.nsid))
 		return -EINVAL;
 
diff --git a/include/uapi/linux/nvme_ioctl.h b/include/uapi/linux/nvme_ioctl.h
index d99b5a772698..d4999e3930f8 100644
--- a/include/uapi/linux/nvme_ioctl.h
+++ b/include/uapi/linux/nvme_ioctl.h
@@ -9,6 +9,10 @@
 
 #include <linux/types.h>
 
+enum nvme_ioc_flags {
+	NVME_IOVEC	= 1 << 0 /* vectored io */
+};
+
 struct nvme_user_io {
 	__u8	opcode;
 	__u8	flags;
-- 
2.25.1

