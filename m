Return-Path: <SRS0=ALdW=7C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86CBDC433E0
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 17:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A18C206B6
	for <linux-block@archiver.kernel.org>; Wed, 20 May 2020 17:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wgOJa4rL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgETRMK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 May 2020 13:12:10 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43052 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETRMK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 May 2020 13:12:10 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KH7xe3033671;
        Wed, 20 May 2020 17:10:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=441KUsS5znB+BeHNlW1GEywHSKEiEYo07aCjPvH8Z2E=;
 b=wgOJa4rLoYavZgjXOiM5LSnNLl2pbPyz+Cal4iZrwZi1+fT6LwLS2q1+4sLcFxfKXxdD
 F2q4H+/MR5EOSYHNNMLuFOzgOTZm48raHnXlAaiua9qx7WvJTjOmC5foSVErhPfsd5bN
 rt7DsgGOfqfZ6mU/w5OfyJ3+n1ga0o4f9xHhx4wjs1A/8gLCkQIs/WXotSIuOn1nSZs6
 RolldPezRQDE4WPnxdfHLb/R8HTKSU8Xpqyk9KSE7OFk3c/0+IrC2ksM9a9YiE/zqzhI
 LbAGHgWlGBzDWzDNTPHKfuVc56+o3GoPo555WPsAptVtYYG39ZyEGajUVbQQ7Sxxu+0I Yw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 31284m4b7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 May 2020 17:10:52 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KH8R8G027160;
        Wed, 20 May 2020 17:10:51 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 314gm7dpwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 May 2020 17:10:51 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04KHAnQA011835;
        Wed, 20 May 2020 17:10:49 GMT
Received: from [10.159.242.116] (/10.159.242.116)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 May 2020 10:10:49 -0700
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
Message-ID: <af81f03c-cee9-f1cf-5002-48df43e824db@oracle.com>
Date:   Wed, 20 May 2020 10:10:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200520115655.729705-4-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9627 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 phishscore=0 mlxscore=0 spamscore=0 suspectscore=2
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005200138
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9627 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 mlxscore=0
 cotscore=-2147483648 impostorscore=0 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005200138
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 5/20/20 4:56 AM, Ming Lei wrote:
> During waiting for in-flight IO completion in reset handler, timeout
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
> +		if (!dev->online_queues)
> +			break;
> +		msleep(5);
> +	}
> +
> +	return frozen;
> +}
> +
>  static void nvme_reset_work(struct work_struct *work)
>  {
>  	struct nvme_dev *dev =
>  		container_of(work, struct nvme_dev, ctrl.reset_work);
>  	bool was_suspend = !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
>  	int result;
> +	bool reset_done = true;
>  
>  	if (WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING)) {
>  		result = -ENODEV;
> @@ -2606,8 +2622,9 @@ static void nvme_reset_work(struct work_struct *work)
>  		nvme_free_tagset(dev);
>  	} else {
>  		nvme_start_queues(&dev->ctrl);
> -		nvme_wait_freeze(&dev->ctrl);
> -		nvme_dev_add(dev);
> +		reset_done = nvme_wait_freeze_and_check(dev);

Once we arrive at here, it indicates "dev->online_queues >= 2".

2601         if (dev->online_queues < 2) {
2602                 dev_warn(dev->ctrl.device, "IO queues not created\n");
2603                 nvme_kill_queues(&dev->ctrl);
2604                 nvme_remove_namespaces(&dev->ctrl);
2605                 nvme_free_tagset(dev);
2606         } else {
2607                 nvme_start_queues(&dev->ctrl);
2608                 nvme_wait_freeze(&dev->ctrl);
2609                 nvme_dev_add(dev);
2610                 nvme_unfreeze(&dev->ctrl);
2611         }

Is there any reason to check "if (!dev->online_queues)" in
nvme_wait_freeze_and_check()?

Thank you very much!

Dongli Zhang




> +		if (reset_done)
> +			nvme_dev_add(dev);
>  		nvme_unfreeze(&dev->ctrl);
>  	}
>  
> @@ -2622,7 +2639,13 @@ static void nvme_reset_work(struct work_struct *work)
>  		goto out;
>  	}
>  
> -	nvme_start_ctrl(&dev->ctrl);
> +	/* New error happens during reset, so schedule a new reset */
> +	if (!reset_done) {
> +		dev_warn(dev->ctrl.device, "new error during reset\n");
> +		nvme_reset_ctrl(&dev->ctrl);
> +	} else {
> +		nvme_start_ctrl(&dev->ctrl);
> +	}
>  	return;
>  
>   out_unlock:
> 
