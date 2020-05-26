Return-Path: <SRS0=PnPs=7I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA70C433E0
	for <linux-block@archiver.kernel.org>; Tue, 26 May 2020 05:01:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32D6F207CB
	for <linux-block@archiver.kernel.org>; Tue, 26 May 2020 05:01:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W4001Quu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgEZFBn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 May 2020 01:01:43 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:32926 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgEZFBn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 May 2020 01:01:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04Q4xK9p178309;
        Tue, 26 May 2020 05:01:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=9WxrCvOZXsTN9gQYHNYZAIIlWAdNRw+SugxkPsqYyVM=;
 b=W4001Quu4w6DjgeywAtU+mpYBblPJN9feNv9XfQ546vZLqOdG1xf6UCvHH5iKqpYQN9l
 swix6giqmYbVwmh3xhayJXEcHL6VOSjuv8iE69cDzkiWMZ85ik30/KIN88dD60ntO9LZ
 DEqDnj4NRHAsPNvN+C2LmFu+93fH1Gf9lBLQiGHEgKAinWeWfbZsOYPZb5kbS7H0F9gk
 gYx+hJWoJKB4ZHsBGeYOjAAiFosRe8yqEpFx5hwTNuMQfiwzOjUu84LWjtPLucYhXCsp
 +M8MSmGRPxLa/ItWhrobfmjxAxZozJ/Doa3yoUgr+MBpgKVv27trbsws5Tv0PfvCHcJA Pg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 316uskqggx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 May 2020 05:01:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04Q4rUqN014062;
        Tue, 26 May 2020 05:01:21 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 317j5m9afn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 May 2020 05:01:21 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04Q51I0A009888;
        Tue, 26 May 2020 05:01:18 GMT
Received: from [10.159.229.251] (/10.159.229.251)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 25 May 2020 22:01:18 -0700
Subject: Re: [PATCH 3/3] nvme-pci: make nvme reset more reliable
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Christoph Hellwig <hch@lst.de>
Cc:     Alan Adamson <alan.adamson@oracle.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Max Gurtovoy <maxg@mellanox.com>
References: <20200520115655.729705-1-ming.lei@redhat.com>
 <20200520115655.729705-4-ming.lei@redhat.com>
From:   Dongli Zhang <dongli.zhang@oracle.com>
Message-ID: <9c5ac1e0-b5ca-0f54-5ee3-fd630dbdb8d4@oracle.com>
Date:   Mon, 25 May 2020 22:01:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200520115655.729705-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9632 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005260036
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9632 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 lowpriorityscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 cotscore=-2147483648 adultscore=0 mlxscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2005260036
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 5/20/20 4:56 AM, Ming Lei wrote:
> During waiting for in-flight IO completion in reset handler, timeout

Does this indicate the window since nvme_start_queues() in nvme_reset_work(),
that is, just after the queues are unquiesced again?

If v2 is required in the future, how about to mention the specific function to
that it would be much more easier to track the issue.

> or controller failure still may happen, then the controller is deleted
> and all inflight IOs are failed. This way is too violent.
> 
> Improve the reset handling by replacing nvme_wait_freeze with query
> & check controller. If all ns queues are frozen, the controller is reset
> successfully, otherwise check and see if the controller has been disabled.
> If yes, break from the current recovery and schedule a fresh new reset.
> 
> This way avoids to failing IO & removing controller unnecessarily.
> 
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Keith Busch <kbusch@kernel.org>
> Cc: Max Gurtovoy <maxg@mellanox.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/nvme/host/pci.c | 37 ++++++++++++++++++++++++++++++-------
>  1 file changed, 30 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index ce0d1e79467a..b5aeed33a634 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -24,6 +24,7 @@
>  #include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/sed-opal.h>
>  #include <linux/pci-p2pdma.h>
> +#include <linux/delay.h>
>  
>  #include "trace.h"
>  #include "nvme.h"
> @@ -1235,9 +1236,6 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
>  	 * shutdown, so we return BLK_EH_DONE.
>  	 */
>  	switch (dev->ctrl.state) {
> -	case NVME_CTRL_CONNECTING:
> -		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
> -		/* fall through */
>  	case NVME_CTRL_DELETING:
>  		dev_warn_ratelimited(dev->ctrl.device,
>  			 "I/O %d QID %d timeout, disable controller\n",
> @@ -2393,7 +2391,8 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
>  		u32 csts = readl(dev->bar + NVME_REG_CSTS);
>  
>  		if (dev->ctrl.state == NVME_CTRL_LIVE ||
> -		    dev->ctrl.state == NVME_CTRL_RESETTING) {
> +		    dev->ctrl.state == NVME_CTRL_RESETTING ||
> +		    dev->ctrl.state == NVME_CTRL_CONNECTING) {
>  			freeze = true;
>  			nvme_start_freeze(&dev->ctrl);
>  		}
> @@ -2504,12 +2503,29 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev)
>  		nvme_put_ctrl(&dev->ctrl);
>  }
>  
> +static bool nvme_wait_freeze_and_check(struct nvme_dev *dev)
> +{
> +	bool frozen;
> +
> +	while (true) {
> +		frozen = nvme_frozen(&dev->ctrl);
> +		if (frozen)
> +			break;

... and how about to comment that the below is because of nvme timeout handler
as explained in another email (if v2 would be sent) so that it is not required
to query for "online_queues" with cscope :)

> +		if (!dev->online_queues)
> +			break;
> +		msleep(5);
> +	}
> +
> +	return frozen;
> +}
> +

Thank you very much!

Dongli Zhang
