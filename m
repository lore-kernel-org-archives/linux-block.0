Return-Path: <SRS0=hu+R=VT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70466C7618F
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 23:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4413E21951
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 23:27:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q8PU/3Wg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727200AbfGVX1o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 19:27:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45860 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbfGVX1o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 19:27:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6MNO7kL100304;
        Mon, 22 Jul 2019 23:27:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=nH/h94l6KgprwBxgjWXlmx9Jit7OQZwgCgUjL3XIoKI=;
 b=Q8PU/3WgHzA4QDiw2OVdtRQqVZOzQxJC6Ax+LGUKvbzRtF14Rquj5Ocozrad8OF3hamK
 zCg3YEg1UI2/gka4cbX8e6FyyqvlbzdUk7xojklQ5nY6wPEjtHugzh8sy6oeka9EqYgF
 7RdxMqglocgxbNRT6jhoewCKBAm2KMVNEN1GiVvdpAYtICl5CAktMBuwulYYzAPmSocg
 ooVQz7G378+JGMNRG3iubrLp/UahLuy3iHUu402LbTQHqrt3KHG9g+wJDcOH5hOJGNHg
 y2Ep2ns9CQ2UD7wcMlJWtrM07IyZP66Ck1H7yp767UkoHdtFPyqJ985TZm/oPgJzVyjw 2g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2tutctadt8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jul 2019 23:27:08 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6MNNtNG196056;
        Mon, 22 Jul 2019 23:27:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 2tuts3avxu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jul 2019 23:27:08 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6MNR7px024371;
        Mon, 22 Jul 2019 23:27:07 GMT
Received: from [192.168.1.14] (/180.165.87.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Jul 2019 16:27:06 -0700
Subject: Re: [PATCH 0/5] blk-mq: wait until completed req's complete fn is run
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Max Gurtovoy <maxg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>
References: <20190722053954.25423-1-ming.lei@redhat.com>
From:   Bob Liu <bob.liu@oracle.com>
Message-ID: <a22e7266-98cb-875d-aa89-f37dd6c34ad5@oracle.com>
Date:   Tue, 23 Jul 2019 07:27:00 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190722053954.25423-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9326 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907220247
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9326 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907220247
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/22/19 1:39 PM, Ming Lei wrote:
> Hi,
> 
> blk-mq may schedule to call queue's complete function on remote CPU via
> IPI, but never provide any way to synchronize the request's complete
> fn.
> 
> In some driver's EH(such as NVMe), hardware queue's resource may be freed &
> re-allocated. If the completed request's complete fn is run finally after the
> hardware queue's resource is released, kernel crash will be triggered.
> 

Have you seen the crash? Anyway to emulate/verify this bug..

> Fixes this issue by waitting until completed req's complete fn is run.
> 
> Thanks,
> Ming
> 
> Ming Lei (5):
>   blk-mq: introduce blk_mq_request_completed()
>   blk-mq: introduce blk_mq_tagset_wait_completed_request()
>   nvme: don't abort completed request in nvme_cancel_request
>   nvme: wait until all completed request's complete fn is called
>   blk-mq: remove blk_mq_complete_request_sync
> 
>  block/blk-mq-tag.c         | 32 ++++++++++++++++++++++++++++++++
>  block/blk-mq.c             | 13 ++++++-------
>  drivers/nvme/host/core.c   |  6 +++++-
>  drivers/nvme/host/pci.c    |  2 ++
>  drivers/nvme/host/rdma.c   |  8 ++++++--
>  drivers/nvme/host/tcp.c    |  8 ++++++--
>  drivers/nvme/target/loop.c |  2 ++
>  include/linux/blk-mq.h     |  3 ++-
>  8 files changed, 61 insertions(+), 13 deletions(-)
> 
> Cc: Max Gurtovoy <maxg@mellanox.com>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Keith Busch <keith.busch@intel.com>
> Cc: Christoph Hellwig <hch@lst.de>
> 

