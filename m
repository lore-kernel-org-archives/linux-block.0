Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907FBC6FD1D
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 14:00:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230468AbjC0OAL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 10:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjC0N7d (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 09:59:33 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78BD40D8
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 06:59:13 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230327135901epoutp0421b5d4ca283023e53737b0521b828a8a~QS2EYmDTS0779307793epoutp04v
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:59:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230327135901epoutp0421b5d4ca283023e53737b0521b828a8a~QS2EYmDTS0779307793epoutp04v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1679925541;
        bh=PmGBCink2s/KKS8aWrG6OksE85FpvGu72fOnYCwOWPk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OFhFS08fD9TcziJzfV+GL1uX+RJViaEBotTLTJ7JkYvWzNacW+egq1ZD/Unt76TlU
         BudIrBs8CkQdN9M7c/prtF+fqjH3/9pGytqHu1F+wGq8JST34qL9ey24p5FnNAAgQj
         kPhdZp56e/ifD79lNJLMtrtjl8/WD+cJlMC4GPlU=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230327135900epcas5p1cee0334d3368e4a6dce0a0161b4a8799~QS2D7h98j1842418424epcas5p1-;
        Mon, 27 Mar 2023 13:59:00 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PlZDM4Wgqz4x9Px; Mon, 27 Mar
        2023 13:58:59 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        8E.98.55678.121A1246; Mon, 27 Mar 2023 22:58:57 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230327135856epcas5p1813b616f545c41009c1926c14267b116~QS2APpB-O1842818428epcas5p1_;
        Mon, 27 Mar 2023 13:58:56 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230327135856epsmtrp2dcd3173f06760a34c5c5c21307ed7ad2~QS2AO-7q61801018010epsmtrp2w;
        Mon, 27 Mar 2023 13:58:56 +0000 (GMT)
X-AuditID: b6c32a4a-6a3ff7000000d97e-a9-6421a121e39a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DF.AC.31821.021A1246; Mon, 27 Mar 2023 22:58:56 +0900 (KST)
Received: from green5 (unknown [107.110.206.5]) by epsmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230327135855epsmtip23b73faa515be5117e61db5cfae8236dc~QS1-PbvAG1057110571epsmtip2t;
        Mon, 27 Mar 2023 13:58:55 +0000 (GMT)
Date:   Mon, 27 Mar 2023 19:28:10 +0530
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     Keith Busch <kbusch@meta.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        axboe@kernel.dk, hch@lst.de, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 2/2] nvme: use blk-mq polling for uring commands
Message-ID: <20230327135810.GA8405@green5>
MIME-Version: 1.0
In-Reply-To: <20230324212803.1837554-2-kbusch@meta.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdlhTXVdxoWKKwdS3Ahar7/azWaxcfZTJ
        YtKha4wWZ64uZLHYe0vbYv6yp+wObB6Xz5Z6bFrVyeaxeUm9x+6bDWwe5y5WeHzeJBfAFpVt
        k5GamJJapJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQN0gpJCWWJO
        KVAoILG4WEnfzqYov7QkVSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO2Pz
        1ndMBZONK24sWMPewDhfs4uRk0NCwESiZdZfpi5GLg4hgd2MEgv6T7JDOJ8YJfY/2cwK4Xxm
        lGg/dJsRpuXekdtQLbsYJRY19LOCJIQEnjBKzNzkD2KzCKhKzD17naWLkYODTUBT4sLkUpCw
        iICixHlgIICEmQXqJS59DgMJCwu4SKw7sgFsCq+AlsTr/k9sELagxMmZT1hAbE4Bc4lzb1vA
        ThAVUJY4sO04E8Q5P9klnr8UgbBdJFae38oGYQtLvDq+hR3ClpL4/G4vVDxZ4tLMc1C9JRKP
        9xyEsu0lWk/1M4PYzAKZElNfHmaHsPkken8/YQI5WUKAV6KjTQiiXFHi3qSnrBC2uMTDGUug
        bA+J2S/2MENCZzujxMRt05gmMMrNQvLOLCQrIGwric4PTayzwKEiLbH8HweEqSmxfpf+AkbW
        VYySqQXFuempxaYFRnmp5fAYTs7P3cQITpJaXjsYHz74oHeIkYmD8RCjBAezkgjvZm/FFCHe
        lMTKqtSi/Pii0pzU4kOMpsDImcgsJZqcD0zTeSXxhiaWBiZmZmYmlsZmhkrivOq2J5OFBNIT
        S1KzU1MLUotg+pg4OKUamCruJS5cJrnbhF/p3qRPBtu0nmWcu/T+bvuJD5PYnSXm7rtgX/2v
        WHY5887OTd3Vq392zpR78ojZIPmWqItG3+l2acaXKz8I8xccW2T+OXX6P4ad7c4yMyq+L/p+
        4e4zr+ZDDzbmF+1Ny96p4Wu9S/Tyb/8Xh/5JGt+X1Enl4w+UutPkfeXz00mH3mhGbvUR0voT
        cb3fL/TNmrwS44nPWB+n8y/UnjBzpo3DmjNP4rrb1oqesmnf7+pnMvHthwfsxyqfP7/hq1I/
        pT3zivqLsyt0Dotccco2Wnv/wsMbZTMN/VRPakV4TSir6A41ZjnMyDVnzbZ9z8qbQ7bNOBub
        phTLFGV5XqjdLjJ2wfOqSW+UWIozEg21mIuKEwE6LXlUGwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBLMWRmVeSWpSXmKPExsWy7bCSvK7CQsUUg6kXDS1W3+1ns1i5+iiT
        xaRD1xgtzlxdyGKx95a2xfxlT9kd2Dwuny312LSqk81j85J6j903G9g8zl2s8Pi8SS6ALYrL
        JiU1J7MstUjfLoEr40Lje9aCQwYVPbsvsDUwvlDrYuTkkBAwkbh35DZTFyMXh5DADkaJm+f+
        M0EkxCWar/1gh7CFJVb+e84OUfSIUWLOlyZWkASLgKrE3LPXWboYOTjYBDQlLkwuBQmLCChK
        nAe6BCTMLFAvcelzGEhYWMBFYt2RDWCdvAJaEq/7P7FBjNzOKDHlZC8zREJQ4uTMJywgNrOA
        mcS8zQ+ZIeZISyz/xwES5hQwlzj3toURxBYVUJY4sO040wRGwVlIumch6Z6F0L2AkXkVo2Rq
        QXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZw4Gtp7WDcs+qD3iFGJg7GQ4wSHMxKIrybvRVT
        hHhTEiurUovy44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamDaaLjZ4Ulm
        soTS+90N+jsYuhJrLOTXrdmh/Lj3hcnK6N/6TosEt0ZVsn8y3nDy5a9XE995PmcT/lRjP9f1
        zvd+p2KpY9v+7lybxh27vj5Q/f79VxHcusEia+YF1KdHhmREXog+7RI56VnCEZvDGTFNnef6
        eUyWnCy5/P3Ww0VKszQPrlh08+3BVo2/Ffe8Ll5/JB8r1LadaeWriP7l8xuddk7XjVOUf128
        NG1dnPuttsIuS/Gmyk2+sid7Ql1U2ZL1JG5/M+dUYFk0JX5ibcx65iDx8M5FC7MmfxPlMon6
        Lv3++vlCY53nl9ZK+MgmCf/TUTsQoytqFPiP547308leouHxy/4dS5r37vezBUFKLMUZiYZa
        zEXFiQAKNq1L6wIAAA==
X-CMS-MailID: 20230327135856epcas5p1813b616f545c41009c1926c14267b116
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----20UT-5VtB2RXxRyC_PhwUj8OofNvbA-fDS5AX-3x2UrzL_bJ=_10f0ed_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230324213124epcas5p331ea3c2e2a05ec6a6825e719e47d2427
References: <20230324212803.1837554-1-kbusch@meta.com>
        <CGME20230324213124epcas5p331ea3c2e2a05ec6a6825e719e47d2427@epcas5p3.samsung.com>
        <20230324212803.1837554-2-kbusch@meta.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

------20UT-5VtB2RXxRyC_PhwUj8OofNvbA-fDS5AX-3x2UrzL_bJ=_10f0ed_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Fri, Mar 24, 2023 at 02:28:03PM -0700, Keith Busch wrote:
>From: Keith Busch <kbusch@kernel.org>
>
>The first advantage is that unshared and multipath namespaces can use
>the same polling callback.
>
>The other advantage is that we don't need a bio payload in order to
>poll, allowing commands like 'flush' and 'write zeroes' to be submitted
>on the same high priority queue as read and write commands.
>
>This can also allow for a future optimization for the driver since we no
>longer need to create special hidden block devices to back nvme-generic
>char dev's with unsupported command sets.
>
>Signed-off-by: Keith Busch <kbusch@kernel.org>
>---
> drivers/nvme/host/ioctl.c     | 79 ++++++++++++-----------------------
> drivers/nvme/host/multipath.c |  2 +-
> drivers/nvme/host/nvme.h      |  2 -
> 3 files changed, 28 insertions(+), 55 deletions(-)
>
>diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
>index 723e7d5b778f2..369e8519b87a2 100644
>--- a/drivers/nvme/host/ioctl.c
>+++ b/drivers/nvme/host/ioctl.c
>@@ -503,7 +503,6 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
> {
> 	struct io_uring_cmd *ioucmd = req->end_io_data;
> 	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
>-	void *cookie = READ_ONCE(ioucmd->cookie);
>
> 	req->bio = pdu->bio;
> 	if (nvme_req(req)->flags & NVME_REQ_CANCELLED)
>@@ -516,9 +515,10 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
> 	 * For iopoll, complete it directly.
> 	 * Otherwise, move the completion to task work.
> 	 */
>-	if (cookie != NULL && blk_rq_is_poll(req))
>+	if (blk_rq_is_poll(req)) {
>+		WRITE_ONCE(ioucmd->cookie, NULL);
> 		nvme_uring_task_cb(ioucmd);
>-	else
>+	} else
> 		io_uring_cmd_complete_in_task(ioucmd, nvme_uring_task_cb);
>
> 	return RQ_END_IO_FREE;
>@@ -529,7 +529,6 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io_meta(struct request *req,
> {
> 	struct io_uring_cmd *ioucmd = req->end_io_data;
> 	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
>-	void *cookie = READ_ONCE(ioucmd->cookie);
>
> 	req->bio = pdu->bio;
> 	pdu->req = req;
>@@ -538,9 +537,10 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io_meta(struct request *req,
> 	 * For iopoll, complete it directly.
> 	 * Otherwise, move the completion to task work.
> 	 */
>-	if (cookie != NULL && blk_rq_is_poll(req))
>+	if (blk_rq_is_poll(req)) {
>+		WRITE_ONCE(ioucmd->cookie, NULL);
> 		nvme_uring_task_meta_cb(ioucmd);
>-	else
>+	} else
> 		io_uring_cmd_complete_in_task(ioucmd, nvme_uring_task_meta_cb);
>
> 	return RQ_END_IO_NONE;
>@@ -597,7 +597,6 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
> 	if (issue_flags & IO_URING_F_IOPOLL)
> 		rq_flags |= REQ_POLLED;
>
>-retry:
> 	req = nvme_alloc_user_request(q, &c, rq_flags, blk_flags);
> 	if (IS_ERR(req))
> 		return PTR_ERR(req);
>@@ -611,17 +610,9 @@ static int nvme_uring_cmd_io(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
> 			return ret;
> 	}
>
>-	if (issue_flags & IO_URING_F_IOPOLL && rq_flags & REQ_POLLED) {
>-		if (unlikely(!req->bio)) {
>-			/* we can't poll this, so alloc regular req instead */
>-			blk_mq_free_request(req);
>-			rq_flags &= ~REQ_POLLED;
>-			goto retry;
>-		} else {
>-			WRITE_ONCE(ioucmd->cookie, req->bio);
>-			req->bio->bi_opf |= REQ_POLLED;
>-		}
>-	}
>+	if (blk_rq_is_poll(req))
>+		WRITE_ONCE(ioucmd->cookie, req);

blk_rq_is_poll(req) warns for null "req->bio" and returns false if that
is the case. That defeats one of the purpose of the series i.e. poll on
no-payload commands such as flush/write-zeroes.


> 	/* to free bio on completion, as req->bio will be null at that time */
> 	pdu->bio = req->bio;
> 	pdu->meta_len = d.metadata_len;
>@@ -780,18 +771,27 @@ int nvme_ns_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd,
> 				 struct io_comp_batch *iob,
> 				 unsigned int poll_flags)
> {
>-	struct bio *bio;
>+	struct request *req;
> 	int ret = 0;
>-	struct nvme_ns *ns;
>-	struct request_queue *q;
>
>+	/*
>+	 * The rcu lock ensures the 'req' in the command cookie will not be
>+	 * freed until after the unlock. The queue must be frozen to free the
>+	 * request, and the freeze requires an rcu grace period. The cookie is
>+	 * cleared before the request is completed, so we're fine even if a
>+	 * competing polling thread completes this thread's request.
>+	 */
> 	rcu_read_lock();
>-	bio = READ_ONCE(ioucmd->cookie);
>-	ns = container_of(file_inode(ioucmd->file)->i_cdev,
>-			struct nvme_ns, cdev);
>-	q = ns->queue;
>-	if (test_bit(QUEUE_FLAG_POLL, &q->queue_flags) && bio && bio->bi_bdev)
>-		ret = bio_poll(bio, iob, poll_flags);
>+	req = READ_ONCE(ioucmd->cookie);
>+	if (req) {

This is risky. We are not sure if the cookie is actually "req" at this
moment. If driver is loaded without the poll-queues, we will not be able
to set req into ioucmd->cookie during the submission (in
nvme_uring_cmd_io). Therefore, the original code checked for QUEUE_FLAG_POLL
before treating ioucmd->cookie as bio here.

This should handle it (on top of your patch):

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 369e8519b87a..89eef5da4b5c 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -773,6 +773,8 @@ int nvme_ns_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd,
 {
        struct request *req;
        int ret = 0;
+       struct request_queue *q;
+       struct nvme_ns *ns;

        /*
         * The rcu lock ensures the 'req' in the command cookie will not be
@@ -783,8 +785,10 @@ int nvme_ns_chr_uring_cmd_iopoll(struct io_uring_cmd *ioucmd,
         */
        rcu_read_lock();
        req = READ_ONCE(ioucmd->cookie);
-       if (req) {
-               struct request_queue *q = req->q;
+       ns = container_of(file_inode(ioucmd->file)->i_cdev, struct nvme_ns,
+                       cdev);
+       q = ns->queue;
+       if (test_bit(QUEUE_FLAG_POLL, &q->queue_flags) && req) {

                if (percpu_ref_tryget(&q->q_usage_counter)) {
                        ret = blk_mq_poll(q, blk_rq_to_qc(req), iob,


------20UT-5VtB2RXxRyC_PhwUj8OofNvbA-fDS5AX-3x2UrzL_bJ=_10f0ed_
Content-Type: text/plain; charset="utf-8"


------20UT-5VtB2RXxRyC_PhwUj8OofNvbA-fDS5AX-3x2UrzL_bJ=_10f0ed_--
