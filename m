Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 606FBC3DA78
	for <linux-block@archiver.kernel.org>; Tue, 17 Jan 2023 12:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236999AbjAQMuf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 Jan 2023 07:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237002AbjAQMuS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 Jan 2023 07:50:18 -0500
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC6239CDA
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 04:49:15 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230117124913epoutp02c8d93d4bfba43544f254899418845e7b~7GYbp-UuD1944019440epoutp02J
        for <linux-block@vger.kernel.org>; Tue, 17 Jan 2023 12:49:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230117124913epoutp02c8d93d4bfba43544f254899418845e7b~7GYbp-UuD1944019440epoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1673959753;
        bh=NFP5bhMYw2BoELtsjsTDvcZqnupdAURBEsccxofZyps=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uSdRRE2IQU+TI76ZyklYRImBxAlu1VK9XMquSAo/uWHTx+I/kEXU44Mw9072mCyet
         FiUr6dZKfrwYO3YhJ1Fc34MXqL7I0d5IQcvi+7NsT9vhlr0li6VDm3FENT53Ud98n9
         GB/88MKdtp80DC73jNbPRa+T1PbyyitasUWpeInI=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230117124912epcas5p42eae3252699f5582d5f04d8605361cbf~7GYaVl3OB2238522385epcas5p4F;
        Tue, 17 Jan 2023 12:49:12 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Nx7xf4kqRz4x9Pp; Tue, 17 Jan
        2023 12:49:10 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        68.64.02301.64996C36; Tue, 17 Jan 2023 21:49:10 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230117120752epcas5p2f01ed01d190357f35dda4505fadea02b~7F0Uloy_f0796607966epcas5p2I;
        Tue, 17 Jan 2023 12:07:52 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230117120752epsmtrp2007cc1b2e2562d6a09c19f1bf8b54abf~7F0Uk5Gyd0039200392epsmtrp2c;
        Tue, 17 Jan 2023 12:07:52 +0000 (GMT)
X-AuditID: b6c32a49-473fd700000108fd-aa-63c699462ddb
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A2.00.10542.89F86C36; Tue, 17 Jan 2023 21:07:52 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230117120750epsmtip266a5a6500675c6da0ba497756b9229d5~7F0TN4btH3229332293epsmtip2f;
        Tue, 17 Jan 2023 12:07:50 +0000 (GMT)
From:   Anuj Gupta <anuj20.g@samsung.com>
To:     axboe@kernel.dk, hch@lst.de, kbusch@kernel.org,
        asml.silence@gmail.com
Cc:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH for-next v1 1/2] nvme: set REQ_ALLOC_CACHE for
 uring-passthru request
Date:   Tue, 17 Jan 2023 17:36:37 +0530
Message-Id: <20230117120638.72254-2-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230117120638.72254-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMJsWRmVeSWpSXmKPExsWy7bCmpq7bzGPJBvN+KVo0TfjLbDFn1TZG
        i9V3+9ksbh7YyWSxcvVRJouj/9+yWUw6dI3RYu8tbYv5y56yO3B67Jx1l93j8tlSj02rOtk8
        Ni+p99h9s4HNo2/LKkaPz5vkAtijsm0yUhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3M
        lRTyEnNTbZVcfAJ03TJzgO5SUihLzCkFCgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgV
        J+YWl+al6+WlllgZGhgYmQIVJmRnXHi+g6VgKWdF09yHzA2Md9i7GDk5JARMJB61XGDpYuTi
        EBLYzSgx4+4iRgjnE6PEwf53zBDOZ0aJhq7pcC1/J3xigkjsYpT4cucHE1zVjtN/WUCq2ATU
        JY48b2UEsUUEvCTu337PClLELLCQUWLS8jdsIAlhgXCJtfcPMYPYLAKqEn93LwCzeQUsJba0
        vmaFWCcvMfPSd7DVnAJWEh/Pz2aFqBGUODnzCdgyZqCa5q2zwW6VEGjlkNj08TQbRLOLxM1/
        F1ggbGGJV8e3QP0gJfH53V6omnSJH5efMkHYBRLNx/YxQtj2Eq2n+oGGcgAt0JRYv0sfIiwr
        MfXUOiaIvXwSvb+fQLXySuyYB2MrSbSvnANlS0jsPdcAZXtI/Fj+ABpavYwSE46+YJ3AqDAL
        yT+zkPwzC2H1AkbmVYySqQXFuempxaYFhnmp5fB4Ts7P3cQITq1anjsY7z74oHeIkYmD8RCj
        BAezkgiv367DyUK8KYmVValF+fFFpTmpxYcYTYEBPpFZSjQ5H5jc80riDU0sDUzMzMxMLI3N
        DJXEeVO3zk8WEkhPLEnNTk0tSC2C6WPi4JRqYNr6NOqMV4ZyZenKOVHnDMLOmz6RPtgUqBwT
        onL5RLdR5uTMNG2Nfldpnr9BH4V/JH74Lnh2QdS9Zdmx1vZ1Nfne9TMvS5nOSp108s5hXWk5
        r3jJ0Onvcls9C9gNXWPZDnE/vZH/JGvnc71ltgV6G3Q2VLtMrks7onphYri2BKtWjYLDpoSg
        uNhgl9evwyZuMc8om83cMIVx+rWvCfZvlF6EGSg82JGxKWR9mYLqu/Ns8nMXRjX67nTlfRXJ
        u3hTRd0tsZNtMlYPP+mv7P5omC9w/+fyjZvyeptvpq9N64gKkHv9I6ft6+TZhrIHD13eXnne
        1qtves6ZbenNW4+u/6zvx7pkxV+JB718ci8WKbEUZyQaajEXFScCAI8QOdk2BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsWy7bCSvO6M/mPJBlPmsFk0TfjLbDFn1TZG
        i9V3+9ksbh7YyWSxcvVRJouj/9+yWUw6dI3RYu8tbYv5y56yO3B67Jx1l93j8tlSj02rOtk8
        Ni+p99h9s4HNo2/LKkaPz5vkAtijuGxSUnMyy1KL9O0SuDIuPN/BUrCUs6Jp7kPmBsY77F2M
        nBwSAiYSfyd8Yupi5OIQEtjBKNHy+xczREJC4tTLZYwQtrDEyn/PwRqEBD4ySsxsqASx2QTU
        JY48bwWrEREIkDjYeJkdZBCzwFJGicnb28ESwgKhEvv2/mADsVkEVCX+7l4AtoBXwFJiS+tr
        VogF8hIzL30HW8ApYCXx8fxsVohllhILPrQxQtQLSpyc+YQFxGYGqm/eOpt5AqPALCSpWUhS
        CxiZVjFKphYU56bnFhsWGOWllusVJ+YWl+al6yXn525iBAe+ltYOxj2rPugdYmTiYDzEKMHB
        rCTC67frcLIQb0piZVVqUX58UWlOavEhRmkOFiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFIN
        TJvVQ2ZznFtzzPd8z6SsYx+q3TtCYxs2m1p9aVqw4Mw2+cTPO940nOi9L2X8Vf544I1ea0bh
        p9ofDJjPCc+7uvxvoKm0aMZPxrdeaW83/Ui+Kd/eNeXhf+Hn526E+rH/TGrPVrj5f0fHjobb
        fS9LTv0/VXp/+x0JPpnlOvpMNkdXPd2pdcjA6Hjpt6P6/3dOaVmsHvV9lfQ3EV3fjg1q6q6f
        NQvun5RStxRLsDu3Sf/Ws2WXv15jOxyhv0Va+8bOwMU7vZy8Mjx3P33HWi0XsDN9t1T48Yqc
        Q26bGf+m/XTeyO6hrH7/gG7dIp3Gxg83gt6ITfn/LzXKMvuY66H7KRfqFUReL117w2pa3QJm
        q2tKLMUZiYZazEXFiQA+Izvy6wIAAA==
X-CMS-MailID: 20230117120752epcas5p2f01ed01d190357f35dda4505fadea02b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230117120752epcas5p2f01ed01d190357f35dda4505fadea02b
References: <20230117120638.72254-1-anuj20.g@samsung.com>
        <CGME20230117120752epcas5p2f01ed01d190357f35dda4505fadea02b@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch sets REQ_ALLOC_CACHE flag for uring-passthru requests.
This is a prep-patch so that normal / IRQ-driven uring-passthru
I/Os can also leverage bio-cache.

Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 06f52db34be9..ffaabf16dd4c 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -554,7 +554,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	struct nvme_uring_data d;
 	struct nvme_command c;
 	struct request *req;
-	blk_opf_t rq_flags = 0;
+	blk_opf_t rq_flags = REQ_ALLOC_CACHE;
 	blk_mq_req_flags_t blk_flags = 0;
 	void *meta = NULL;
 	int ret;
@@ -590,7 +590,7 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	d.timeout_ms = READ_ONCE(cmd->timeout_ms);
 
 	if (issue_flags & IO_URING_F_NONBLOCK) {
-		rq_flags = REQ_NOWAIT;
+		rq_flags |= REQ_NOWAIT;
 		blk_flags = BLK_MQ_REQ_NOWAIT;
 	}
 	if (issue_flags & IO_URING_F_IOPOLL)
-- 
2.25.1

