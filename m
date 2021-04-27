Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CEAC433ED
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 04:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B110A613B2
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 04:30:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhD0EbM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Apr 2021 00:31:12 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:51489 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhD0EbM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Apr 2021 00:31:12 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210427043027epoutp03423b29169e6daece859bdb8ffbd779c7~5nLGRh7yA2431024310epoutp03Q
        for <linux-block@vger.kernel.org>; Tue, 27 Apr 2021 04:30:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210427043027epoutp03423b29169e6daece859bdb8ffbd779c7~5nLGRh7yA2431024310epoutp03Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1619497827;
        bh=zsAEe2UM/YQLcOUMYfuF+XEPWoJK78maiwdiWvjhsKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FV+Z9TxhGpl7SKC5KDmCzD8xSjeBTZ0mVGP/nPk6sHu9nWovvjMlL7CyVY/1m8TEh
         DFsiFsZw42mtW1lbvgTZDkRFjp0CgSdJGJkOYAE4bdemaEfASutOLl4QvOYuKs46W7
         iXat4ISdWnmU/1tgClC/hs7S2BW9S+ROtWr3vBM4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20210427043025epcas1p492b21b083014fce6c880ea17d2e59301~5nLE1CyL70154601546epcas1p4W;
        Tue, 27 Apr 2021 04:30:25 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.161]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4FTphw0jG8z4x9Q0; Tue, 27 Apr
        2021 04:30:24 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        C4.C4.09736.F5397806; Tue, 27 Apr 2021 13:30:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20210427043022epcas1p47f11139bc1e08925bcbbdca79e5c8e36~5nLCCS2ec1536315363epcas1p4u;
        Tue, 27 Apr 2021 04:30:22 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210427043022epsmtrp1222555b2bfd88cfae1f1b8c4249d6065~5nLCBjdCX0057500575epsmtrp1V;
        Tue, 27 Apr 2021 04:30:22 +0000 (GMT)
X-AuditID: b6c32a39-8efff70000002608-56-6087935f04ed
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DE.3B.08163.E5397806; Tue, 27 Apr 2021 13:30:22 +0900 (KST)
Received: from localhost.localdomain (unknown [10.253.99.105]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210427043022epsmtip1b5bbcd550bfa9e066933aab1fd600fc1~5nLB0HWmh1113011130epsmtip1h;
        Tue, 27 Apr 2021 04:30:22 +0000 (GMT)
From:   Changheun Lee <nanich.lee@samsung.com>
To:     bvanassche@acm.org
Cc:     axboe@kernel.dk, bgoncalv@redhat.com, hch@lst.de,
        jaegeuk@kernel.org, linux-block@vger.kernel.org,
        ming.lei@redhat.com, nanich.lee@samsung.com, yi.zhang@redhat.com
Subject: Re: [PATCH v2] block: Improve limiting the bio size
Date:   Tue, 27 Apr 2021 13:12:24 +0900
Message-Id: <20210427041224.8400-1-nanich.lee@samsung.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <68e4c8f1-1dc6-7dac-289c-5a7595af8d15@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAJsWRmVeSWpSXmKPExsWy7bCmnm7C5PYEg23XGS1W3+1ns9h1cT6j
        xbQPP5ktVq4+ymTxZP0sZou9t7QtDk1uZrK4dv8Mu8X1c9PYHDg9Ll/x9rh8ttRj06pONo/d
        NxvYPN7vu8rm0bdlFaPH501yAexROTYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqGlhbm
        Sgp5ibmptkouPgG6bpk5QHcpKZQl5pQChQISi4uV9O1sivJLS1IVMvKLS2yVUgtScgoMDQr0
        ihNzi0vz0vWS83OtDA0MjEyBKhNyMr7v6GYseCVe0XVHrYHxqFAXIweHhICJxLUNUV2MXBxC
        AjsYJXa+nckI4XxilPh45iIrhPOZUWLCvQamLkZOsI7FZ3eyQyR2MUp82TuZGa7q5Iy1zCBV
        bAI6En1vb7GB2CICYhKXv3wDm8sssJpRovXmdrCEsICNxPKXu9hBbBYBVYkP+66BNfMKWEnc
        mN7OBrFOXuLP/R6wOKeAtcTTg+ugagQlTs58wgJiMwPVNG+dDXaFhEArh8SKHfdYIZpdJJp3
        vWWEsIUlXh3fwg5hS0m87G9jh2joZpRobpvPCOFMYJRY8nwZ1KfGEp8+f2YEhROzgKbE+l36
        EGFFiZ2/5zJCbOaTePe1hxUSlLwSHW1CECUqEmda7jPD7Hq+difURA+J1b2XWSDB1cco8X3W
        N9YJjAqzkDw0C8lDsxA2L2BkXsUollpQnJueWmxYYIocx5sYwUlVy3IH4/S3H/QOMTJxMB5i
        lOBgVhLhZdvVmiDEm5JYWZValB9fVJqTWnyI0RQY3BOZpUST84FpPa8k3tDUyNjY2MLEzNzM
        1FhJnDfduTpBSCA9sSQ1OzW1ILUIpo+Jg1OqgUn9+8Qu8xfz+o7e/XVLeQdDwYfrB++s4qgP
        md2o9XTZ5VUKS9eziKenCdY9VHU806QZ8WTRlG1zY2Z/mqf+d+2yBIf9swTulr2pXDPBY9rU
        iwv3Fj7LcAs0ui4p/lHtaWig3peCFd0Hvib6fY8R2tO7rELqiF1e+S5LN8m27n1pM2bvVziX
        3TR9vvJRP9tF/ZrZfwT3GpT9z2j6HKT86Oeqts2L2+XunebWb/567lhKk9I8J8s3HbYdx/V/
        z2BdsjJm8emN8fydEhdFJW7m+Ba//cwkOKN/27ptRutUHKqOnloRasr6ZbKHUmrf7yvv+rhD
        dle4P4vcfjMycqVOqV7kVpWYSc94s7Ti9vHudzihxFKckWioxVxUnAgA+hCefzMEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrGLMWRmVeSWpSXmKPExsWy7bCSnG7c5PYEg1WrDSxW3+1ns9h1cT6j
        xbQPP5ktVq4+ymTxZP0sZou9t7QtDk1uZrK4dv8Mu8X1c9PYHDg9Ll/x9rh8ttRj06pONo/d
        NxvYPN7vu8rm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBnfd3QzFrwSr+i6o9bAeFSoi5GT
        Q0LARGLx2Z3sXYxcHEICOxglbq6bywSRkJI4fuItaxcjB5AtLHH4cDFEzUdGifeP+xlBatgE
        dCT63t5iA7FFBMQkLn/5xghSxCywlVHi7b+lYEXCAjYSy1/uYgexWQRUJT7su8YMYvMKWEnc
        mN7OBrFMXuLP/R6wOKeAtcTTg+uYQRYLAdUsv+cNUS4ocXLmExYQmxmovHnrbOYJjAKzkKRm
        IUktYGRaxSiZWlCcm55bbFhglJdarlecmFtcmpeul5yfu4kRHPRaWjsY96z6oHeIkYmD8RCj
        BAezkggv267WBCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJpCeWpGanphakFsFkmTg4
        pRqYDBs0S84KfX4/d1HV0apswQdzGw/Uh32RyPCWbtCcvs/kUt3h83cn/9l0qG9m7rwd4XxL
        23NaT/4v9P21adWE65X7b82afJStN7jYwHtPzSypN/waS5i1fuzts2SWZJ2xPbRlyrElQgsE
        dUsaOc7Z1UzYXsL1/+zeqz2XmpO339yhPMEl6smlv7t2O0b/3Twje6da5c9m1YLDutmxO4v4
        GX9NfhxtffRkXKVPafOUpEKzPSn3LxR2H3WwOHAnNaG+82oQ7y6j3IBXO1NfPnzztjHBfeal
        ja1VZ6ebcpbeWnTb81itndaePfHHne5FRjVLrr8atprFTujvFEl7C/67t0XXn9xyuk9tCf9b
        l3W3xZVYijMSDbWYi4oTAVROGnzpAgAA
X-CMS-MailID: 20210427043022epcas1p47f11139bc1e08925bcbbdca79e5c8e36
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210427043022epcas1p47f11139bc1e08925bcbbdca79e5c8e36
References: <68e4c8f1-1dc6-7dac-289c-5a7595af8d15@acm.org>
        <CGME20210427043022epcas1p47f11139bc1e08925bcbbdca79e5c8e36@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> On 4/26/21 5:28 PM, Changheun Lee wrote:
> > __device_add_disk() do not call bio_max_size(). I just imagined bio
> > operation on disk without request queue. Disk can be added without queue via
> > device_add_disk_no_queue_reg(). It might be my miss-understood about it.
> > I didn't check bio operation is possible on disk without request queue yet. 
> 
> Inside __device_add_disk() I found the following:
> 
> WARN_ON_ONCE(!blk_get_queue(disk->queue));
> 
> I'm not sure how that could work without initializing disk->queue first?
> 
> Thanks,
> 
> Bart.

I think so. But I just asked whether queue should be checked, or not.

Anyway we should determine which pointer variables must be checked in
bio_max_size(). Candidates are bio->bi_bdev, bi_bdev->bd_disk, and
bd_disk->queue I think.

Actually I checked "bio->bi_disk" at first as below. It works well.

unsigned int bio_max_size(struct bio *bio)                                                                                                                                                             
{
	struct request_queue *q;

	if (!bio->bi_disk)
		return UINT_MAX;

	q = bio->bi_disk->queue;
	return q->limits.bio_max_bytes;
}

But I removed bi_disk check condition after applying of Christoph's patch.
Because I got a feedback that is not needed more.

Without bi_disk checking, booting was failed like now. call stack was below.

[   13.341949] pc : __bio_add_pc_page+0x120/0x190
[   13.341951] lr : bio_copy_kern+0xf8/0x20c
[   13.341953] sp : ffffffc012e23950
[   13.341954] x29: ffffffc012e23950 x28: 0000000000001000 
[   13.341955] x27: ffffffff209fa140 x26: 0000000000000200 
[   13.341957] x25: ffffff888d151400 x24: ffffff8919479830 
[   13.341959] x23: ffffff8919479830 x22: ffffffff209fa140 
[   13.341960] x21: 0000000000000000 x20: ffffff882db2f300 
[   13.341962] x19: 0000000000000200 x18: ffffffc012e65048 
[   13.341963] x17: 0000000000000000 x16: 00000000000002fe 
[   13.341965] x15: 0000000000000000 x14: 0000000005bae400 
[   13.341966] x13: 00000000000019f2 x12: ffffffc912fb2000 
[   13.341968] x11: 0000000000000000 x10: 000000000002784d 
[   13.341970] x9 : 0000000000000000 x8 : 0000000000000000 
[   13.341971] x7 : 0000000000000000 x6 : 000000000000003f 
[   13.341973] x5 : ffffffc012e23994 x4 : 0000000000000000 
[   13.341974] x3 : 0000000000000200 x2 : ffffffff209fa140 
[   13.341976] x1 : ffffff882db2f300 x0 : ffffff8919479830 
[   13.341977] Call trace:
[   13.341979] __bio_add_pc_page+0x120/0x190
[   13.341981] bio_copy_kern+0xf8/0x20c
[   13.341984] blk_rq_map_kern+0xa4/0x154
[   13.341985] __scsi_execute+0x88/0x1c0
[   13.341988] srpmb_scsi_ioctl+0x264/0x444 [scsi_srpmb]
[   13.341990] srpmb_worker+0x134/0x5f8 [scsi_srpmb]
[   13.341992] process_one_work+0x2f8/0x5b8
[   13.341994] worker_thread+0x28c/0x518
[   13.341996] kthread+0x16c/0x17c
[   13.341998] ret_from_fork+0x10/0x18

I think "bi_bdev->bd_disk" checking might be needed too.

Thanks,

Changheun Lee
