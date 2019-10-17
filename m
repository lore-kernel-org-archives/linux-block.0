Return-Path: <SRS0=WMYH=YK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1DD6ECE58E
	for <linux-block@archiver.kernel.org>; Thu, 17 Oct 2019 16:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B307421835
	for <linux-block@archiver.kernel.org>; Thu, 17 Oct 2019 16:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727856AbfJQQJD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 17 Oct 2019 12:09:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60350 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393817AbfJQQJD (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 17 Oct 2019 12:09:03 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6DDB010CC213;
        Thu, 17 Oct 2019 16:09:02 +0000 (UTC)
Received: from [10.10.122.251] (ovpn-122-251.rdu2.redhat.com [10.10.122.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CCF815C1D8;
        Thu, 17 Oct 2019 16:09:01 +0000 (UTC)
Subject: Re: [PATCH] nbd: fix hang in NBD_DO_IT ioctl error handling
To:     axboe@kernel.dk, josef@toxicpanda.com, linux-block@vger.kernel.org
References: <20191014063610.7741-1-mchristi@redhat.com>
Cc:     syzbot+24c12fa8d218ed26011a@syzkaller.appspotmail.com
From:   Mike Christie <mchristi@redhat.com>
Message-ID: <5DA8921D.1050604@redhat.com>
Date:   Thu, 17 Oct 2019 11:09:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20191014063610.7741-1-mchristi@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Thu, 17 Oct 2019 16:09:02 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Josef and Jens,

I am nacking my patch.

It looks like nbd only supported sockets that supported the shutdown
method, so I will fix the test and do a patch for nbd to warn when
unsupported sockets are passed in.


On 10/14/2019 01:36 AM, Mike Christie wrote:
> This fixes a regression added with:
> 
> commit e9e006f5fcf2bab59149cb38a48a4817c1b538b4
> Author: Mike Christie <mchristi@redhat.com>
> Date:   Sun Aug 4 14:10:06 2019 -0500
> 
>     nbd: fix max number of supported devs
> 
> Before the patch, if we got a signal in the NBD_DO_IT ioctl, we would
> call sock_shutdown then return immediately. The patch added a
> flush_workqueue call in that error handler path, so we now wait for
> the recv_work to complete. The problem is that some sockets do not
> implemnent a shutdown callout, so when sock_shutdown is called the
> flush_workqueue call is stuck waiting for the workqueue to break out
> of the sock_recvmsg call.
> 
> This patch just moves where we create/destroy the recv workqueue to the
> nbd_device and removes the flush_workqueue call, so we have the behavior
> we had before where when using the ioctl interface and we get a signal the
> recv works will be left running until module removal time when the devices
> are removed.
> 
> For the next kernel, I think we can do something more invasive like switch
> from workqueues to threads and use signals to break out of the recvmsg call
> (we had recently removed the last signal use for socket shutdown so I was
> not sure if we wanted to do this), or figure out a list of sockets families
> nbd supports and implement shutdown functions for them (I did not get a reply
> for that here https://lkml.org/lkml/2019/10/1/1323 so I'm assuming no one
> really knows and and I am still digging into that).
> 
> Reported-by: syzbot+24c12fa8d218ed26011a@syzkaller.appspotmail.com
> Fixes: e9e006f5fcf2 ("nbd: fix max number of supported devs") 
> Signed-off-by: Mike Christie <mchristi@redhat.com>
> 
> ---
>  drivers/block/nbd.c | 33 ++++++++++++++++-----------------
>  1 file changed, 16 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
> index ac07e8c94c79..ee40799712d4 100644
> --- a/drivers/block/nbd.c
> +++ b/drivers/block/nbd.c
> @@ -222,6 +222,8 @@ static void nbd_dev_remove(struct nbd_device *nbd)
>  	struct gendisk *disk = nbd->disk;
>  	struct request_queue *q;
>  
> +	destroy_workqueue(nbd->recv_workq);
> +
>  	if (disk) {
>  		q = disk->queue;
>  		del_gendisk(disk);
> @@ -1177,10 +1180,6 @@ static void nbd_config_put(struct nbd_device *nbd)
>  		kfree(nbd->config);
>  		nbd->config = NULL;
>  
> -		if (nbd->recv_workq)
> -			destroy_workqueue(nbd->recv_workq);
> -		nbd->recv_workq = NULL;
> -
>  		nbd->tag_set.timeout = 0;
>  		nbd->disk->queue->limits.discard_granularity = 0;
>  		nbd->disk->queue->limits.discard_alignment = 0;
> @@ -1209,14 +1208,6 @@ static int nbd_start_device(struct nbd_device *nbd)
>  		return -EINVAL;
>  	}
>  
> -	nbd->recv_workq = alloc_workqueue("knbd%d-recv",
> -					  WQ_MEM_RECLAIM | WQ_HIGHPRI |
> -					  WQ_UNBOUND, 0, nbd->index);
> -	if (!nbd->recv_workq) {
> -		dev_err(disk_to_dev(nbd->disk), "Could not allocate knbd recv work queue.\n");
> -		return -ENOMEM;
> -	}
> -
>  	blk_mq_update_nr_hw_queues(&nbd->tag_set, config->num_connections);
>  	nbd->task_recv = current;
>  
> @@ -1267,10 +1258,8 @@ static int nbd_start_device_ioctl(struct nbd_device *nbd, struct block_device *b
>  	mutex_unlock(&nbd->config_lock);
>  	ret = wait_event_interruptible(config->recv_wq,
>  					 atomic_read(&config->recv_threads) == 0);
> -	if (ret) {
> +	if (ret)
>  		sock_shutdown(nbd);
> -		flush_workqueue(nbd->recv_workq);
> -	}
>  	mutex_lock(&nbd->config_lock);
>  	nbd_bdev_reset(bdev);
>  	/* user requested, ignore socket errors */
> @@ -1656,9 +1645,17 @@ static int nbd_dev_add(int index)
>  	nbd->tag_set.driver_data = nbd;
>  	nbd->destroy_complete = NULL;
>  
> +	nbd->recv_workq = alloc_workqueue("knbd%d-recv",
> +					  WQ_MEM_RECLAIM | WQ_HIGHPRI |
> +					  WQ_UNBOUND, 0, nbd->index);
> +	if (!nbd->recv_workq) {
> +		dev_err(disk_to_dev(nbd->disk), "Could not allocate knbd recv work queue.\n");
> +		goto out_free_idr;
> +	}
> +
>  	err = blk_mq_alloc_tag_set(&nbd->tag_set);
>  	if (err)
> -		goto out_free_idr;
> +		goto out_free_wq;
>  
>  	q = blk_mq_init_queue(&nbd->tag_set);
>  	if (IS_ERR(q)) {
> @@ -1695,6 +1692,8 @@ static int nbd_dev_add(int index)
>  
>  out_free_tags:
>  	blk_mq_free_tag_set(&nbd->tag_set);
> +out_free_wq:
> +	destroy_workqueue(nbd->recv_workq);
>  out_free_idr:
>  	idr_remove(&nbd_index_idr, index);
>  out_free_disk:
> @@ -1949,7 +1948,7 @@ static void nbd_disconnect_and_put(struct nbd_device *nbd)
>  	mutex_unlock(&nbd->config_lock);
>  	/*
>  	 * Make sure recv thread has finished, so it does not drop the last
> -	 * config ref and try to destroy the workqueue from inside the work
> +	 * nbd_device ref and try to destroy the workqueue from inside the work
>  	 * queue.
>  	 */
>  	flush_workqueue(nbd->recv_workq);
> 

