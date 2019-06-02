Return-Path: <SRS0=BT6h=UB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B29C28CC3
	for <linux-block@archiver.kernel.org>; Sun,  2 Jun 2019 01:56:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AEC827801
	for <linux-block@archiver.kernel.org>; Sun,  2 Jun 2019 01:56:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bgDj6bnr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfFBB4V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 1 Jun 2019 21:56:21 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39208 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfFBB4V (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Jun 2019 21:56:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id j2so8498946pfe.6;
        Sat, 01 Jun 2019 18:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dFRs6UlzxSXG+Q0dnImFIWMb2e4XMzrfi0FjaVUS5R0=;
        b=bgDj6bnrD/O6+wNBf6N98DiA6j9k+aS4hgQhGZXbJ/7kYfHTT2aKipFBhzKo3fDj5f
         U6aaUVAKaM8c5jo4P30FfmWkgyZeeZnwi3Suv/rmhsBXZlxkdrqINLR9w0K1xzPIjbmZ
         YmoMOj+ZYSUyk/d3ad5EmxF6f4q46OQ2ds2DsGHvcedcqayLuHTJn8Mw+olQj9BHjzoP
         Gjz4XGIkmngO+/+MMdNDVwdXZ3U6pUt0zGdRW70O+oFIGdcKh3pHWslQBoTOwDs7vAJ4
         PdCrGRFsfNgPsJ9FuKFXJBmb03z1/WDroDAhKERaR/JRoxxemyeUCydWJFwAGQTLmJ5h
         CKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dFRs6UlzxSXG+Q0dnImFIWMb2e4XMzrfi0FjaVUS5R0=;
        b=KT+OZTty65sMs5XojotAWZFz9AIUnZwaNrbDz17yPfi1LK6M7nTOdJJ4HoPAnFXFuH
         bjpda5Z0Fxty82UWb/XLf868dKplYPTypfFvIrSAl/d8nj32m8G4M9a8glAbs1ULBbz5
         xgvDqQz4qNEXLNhELar28cOTzAKiBA5nY5ezzPFq/KN68eanlsD664UJ00BDNN1Dsszf
         kvTsRiJZ7KsMOaBpfU25TqK1x/+U7bZj0S2sDIy0Wi7cthtx/RIIDS3WBxscv0gPe0Kw
         Kpxn2Ue4Pw9pTPOZPgcLdksTkYdvFTKOr2GAOVlUx356IJ6NvBID/y7+mS4/9r/NnSJz
         ml4A==
X-Gm-Message-State: APjAAAU52oK9XFRn4Ya9DrV1Nxl9m6U/kHxCsPCKveSTr6XRegSAsE83
        Q5LmU3V1LTz2cadtTNzAh2xl4umEmbM=
X-Google-Smtp-Source: APXvYqz8cSXunAkBkS0faNTneVq2C5b0KADR8IgcOaPu23drgJCYurYQjGOlgDJYUQbV8aV31SAz7w==
X-Received: by 2002:a63:8f09:: with SMTP id n9mr19253249pgd.249.1559440580456;
        Sat, 01 Jun 2019 18:56:20 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id q19sm10399556pff.96.2019.06.01.18.56.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Jun 2019 18:56:19 -0700 (PDT)
Date:   Sun, 2 Jun 2019 10:56:16 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microsemi.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 2/9] block: null_blk: introduce module parameter of
 'g_host_tags'
Message-ID: <20190602015615.GB28933@minwooim-desktop>
References: <20190531022801.10003-1-ming.lei@redhat.com>
 <20190531022801.10003-3-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190531022801.10003-3-ming.lei@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19-05-31 10:27:54, Ming Lei wrote:
> Introduces parameter of 'g_host_tags' for testing hostwide tags.
> 
> Not observe performance drop in the following test:
> 
> 1) no 'host_tags', hw queue depth is 16, and 1 hw queue
> modprobe null_blk queue_mode=2 nr_devices=4 shared_tags=1 host_tags=0 submit_queues=1 hw_queue_depth=16
> 
> 2) 'host_tags', global hw queue depth is 16, and 8 hw queues
> modprobe null_blk queue_mode=2 nr_devices=4 shared_tags=1 host_tags=1 submit_queues=8 hw_queue_depth=16
> 
> 3) fio test command:
> 
> fio --bs=4k --ioengine=libaio --iodepth=16 --filename=/dev/nullb0:/dev/nullb1:/dev/nullb2:/dev/nullb3 --direct=1 --runtime=30 --numjobs=16 --rw=randread --name=test --group_reporting --gtod_reduce=1
> 
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/null_blk_main.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
> index 447d635c79a2..3c04446f3649 100644
> --- a/drivers/block/null_blk_main.c
> +++ b/drivers/block/null_blk_main.c
> @@ -91,6 +91,10 @@ static int g_submit_queues = 1;
>  module_param_named(submit_queues, g_submit_queues, int, 0444);
>  MODULE_PARM_DESC(submit_queues, "Number of submission queues");
>  
> +static int g_host_tags = 0;
> +module_param_named(host_tags, g_host_tags, int, S_IRUGO);
> +MODULE_PARM_DESC(host_tags, "All submission queues share one tags");
> +
>  static int g_home_node = NUMA_NO_NODE;
>  module_param_named(home_node, g_home_node, int, 0444);
>  MODULE_PARM_DESC(home_node, "Home node for the device");
> @@ -1554,6 +1558,8 @@ static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
>  	set->flags = BLK_MQ_F_SHOULD_MERGE;
>  	if (g_no_sched)
>  		set->flags |= BLK_MQ_F_NO_SCHED;
> +	if (g_host_tags)
> +		set->flags |= BLK_MQ_F_HOST_TAGS;

Hi Ming,

I think it would be great if you can provide documentation update also
for the null_blk (Documenation/block/null_blk.txt).  Also what Bart has
pointed out can be applied, I guess.

Otherwise, it looks good to me.

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
