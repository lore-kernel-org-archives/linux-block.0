Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8C9C77B7A
	for <linux-block@archiver.kernel.org>; Wed, 24 May 2023 08:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbjEXICa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 May 2023 04:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239155AbjEXIC1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 May 2023 04:02:27 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4E0A1
        for <linux-block@vger.kernel.org>; Wed, 24 May 2023 01:02:25 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34O7qLo3025801;
        Wed, 24 May 2023 08:02:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=LjUtuNMeClKYXYxjRyLgBl7ZWO7gq5GEkjU//7PhAG8=;
 b=fhwSEO2M4MQMH3OaeksI3XeyZweefvnF6qDKR6uxhGWJ0Q5Epuf+hw383knjRCJ2yjRc
 k+ROA0W00WVp17TIhbWWrAEIYhxSKNmwUg5DvfCYobmtg8pz9s2at74HQFjBkiSo/QuM
 c6NvrkTe3tb5zhBVtl8yV6uh+ZbNNXRWAUAdoCHJhR/nrXhs2wm8Mp+YrALYsljtnSgr
 LqPxAZYZXqvnzHHAH6B1lXoLGUrfA3xsizTzr060AUBxZQkLrXolOaxUTcBCXN5OPm6Q
 CMHZ3oo4cKqwTrDjxY6iAsNf6SnqjweCeM4E75eDxDoc3T2eKAW3lcNy9ObuMZbjA9wA UA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qsde4t0rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 08:02:04 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34O7gCE1021753;
        Wed, 24 May 2023 08:02:03 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qsde4t0qm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 08:02:03 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34O5u5Dm032628;
        Wed, 24 May 2023 08:02:01 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3qppdk1u9u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 24 May 2023 08:02:00 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34O81v6137028370
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 May 2023 08:01:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FB962004F;
        Wed, 24 May 2023 08:01:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E22542004B;
        Wed, 24 May 2023 08:01:56 +0000 (GMT)
Received: from [9.152.212.186] (unknown [9.152.212.186])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 24 May 2023 08:01:56 +0000 (GMT)
Message-ID: <2ee323bd-1205-4d3e-1ef1-906e206f1c4e@linux.ibm.com>
Date:   Wed, 24 May 2023 10:01:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 7/7] block: Inline blk_mq_{,delay_}kick_requeue_list()
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Mike Snitzer <snitzer@kernel.org>,
        Damien Le Moal <dlemoal@kernel.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20230522183845.354920-1-bvanassche@acm.org>
 <20230522183845.354920-8-bvanassche@acm.org>
From:   Vineeth Vijayan <vneethv@linux.ibm.com>
In-Reply-To: <20230522183845.354920-8-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wQrLNyCx5s87IbfvrCJXdhxc-TaYHCMJ
X-Proofpoint-ORIG-GUID: UoYM_nZvpDLRKXMqOtRwRUNJZ6PInr_W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_03,2023-05-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 malwarescore=0 spamscore=0 mlxscore=0 impostorscore=0 mlxlogscore=911
 clxscore=1011 bulkscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305240064
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 5/22/23 20:38, Bart Van Assche wrote:
> Patch "block: Preserve the order of requeued requests" changed
> blk_mq_kick_requeue_list() and blk_mq_delay_kick_requeue_list() into
> blk_mq_run_hw_queues() and blk_mq_delay_run_hw_queues() calls
> respectively. Inline blk_mq_{,delay_}kick_requeue_list() because these
> functions are now too short to keep these as separate functions.
>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Damien Le Moal <dlemoal@kernel.org>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>   block/blk-flush.c            |  4 ++--
>   block/blk-mq-debugfs.c       |  2 +-
>   block/blk-mq.c               | 16 +---------------
>   drivers/block/ublk_drv.c     |  6 +++---
>   drivers/block/xen-blkfront.c |  1 -
>   drivers/md/dm-rq.c           |  6 +++---
>   drivers/nvme/host/core.c     |  2 +-
>   drivers/s390/block/scm_blk.c |  2 +-
>   drivers/scsi/scsi_lib.c      |  2 +-
>   include/linux/blk-mq.h       |  2 --
>   10 files changed, 13 insertions(+), 30 deletions(-)
The scm_blk.c changes looks good to me. thanks.

Acked-by: Vineeth Vijayan <vneethv@linux.ibm.com>

...

