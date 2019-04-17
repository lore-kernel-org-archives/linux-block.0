Return-Path: <SRS0=3KWi=ST=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5C32C282DA
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 21:59:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7C8217FA
	for <linux-block@archiver.kernel.org>; Wed, 17 Apr 2019 21:59:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QnYJTlPn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbfDQV7H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Apr 2019 17:59:07 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44776 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfDQV7H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Apr 2019 17:59:07 -0400
Received: by mail-pl1-f194.google.com with SMTP id g12so116204pll.11
        for <linux-block@vger.kernel.org>; Wed, 17 Apr 2019 14:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tWBBchjjxOzwjcmdrQlpFCJ+uhoJn9DvnB44SnIc1vk=;
        b=QnYJTlPnXf3eVYL/BHxf/aVo5liQ6DfI8ZyCOwCUBtPV1NefJNQkaofVH+FwaiIU8z
         XToxI1zsIZ5LQaQv2pdYgAs7GXMUqTkUNCblr8zZet6WaGUVE8EtWdWgzlkf5bxBCqCN
         hc9TWuhpFobbefUZjEwXCC6gJiX39Zweu/ca/cfyEKxhCSAovwIqYwlSWtNWpPxiLfT+
         8JFDyFTBTjpj9i9AenC8a8CoxYgcR+ydfcDSyTMGNDFR16kJs9HQQzP2vRRocqxJ+VUW
         1nTY23/WDg7zzekqXIDGoQiDBNVIvEwkodv1k6hj3KDdRPvyUIcUFA8k1pKYbN8jUUdk
         vDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tWBBchjjxOzwjcmdrQlpFCJ+uhoJn9DvnB44SnIc1vk=;
        b=m9MK8P4jBuhHKD/YMXu8f26fL41hbm0nhPbOMBwYZjEfZZ1OziNy5wAv1tM2cNhTRF
         QbxQmf6dNDS27FqnciLzjmTTAOnkPOAI3IMDVSglOj3AcWchnYxU4bEG0glNlUBSojvZ
         YBj6vHfoJJCeyuhmJE7JPyzHwAx7deSmJ8/51l5XY2BWB0yhy8ERGYgN1R2yVKgzzcPZ
         mVITb3f2CPozA0L88UeAubSp1+nKzsueekh0hlrYGqSeHrG+VAMyN3WhAN4S7iWWN8Jp
         XOnlifkJ3xJJ3oqOPWxZQD0jgc+1xY2T2UbsNe7RFulH6HcJyPgeLswn9dE/1uLLxOxA
         cEeg==
X-Gm-Message-State: APjAAAVHeFp/mu3/0LS26MWk3rI7yjTt9OGR5t0JgRpqjllPXPKhwEkS
        PYkB4saYsQvLPYBoi6Su/4EtNOF2
X-Google-Smtp-Source: APXvYqzfRYhAJKfDw3vaJL7/FgFqb77ESrnzdaaweV4uL/hMOW1faMPkloY+9oAM4DKZp5Q/qdOubA==
X-Received: by 2002:a17:902:7441:: with SMTP id e1mr89383114plt.13.1555538346982;
        Wed, 17 Apr 2019 14:59:06 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p2sm212560pfb.80.2019.04.17.14.59.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Apr 2019 14:59:05 -0700 (PDT)
Date:   Wed, 17 Apr 2019 14:59:04 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 1/5] block: rewrite blk_bvec_map_sg to avoid a nth_page
 call
Message-ID: <20190417215904.GA23015@roeck-us.net>
References: <20190408104641.4905-1-hch@lst.de>
 <20190408104641.4905-2-hch@lst.de>
 <20190415194435.GA23676@roeck-us.net>
 <20190415205242.GA6380@lst.de>
 <20190415210731.GA32723@roeck-us.net>
 <20190416063356.GA25763@lst.de>
 <20190416170847.GA5531@roeck-us.net>
 <20190416171011.GA4611@lst.de>
 <20190416175108.GA9550@roeck-us.net>
 <20190417052723.GA23019@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190417052723.GA23019@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 17, 2019 at 07:27:24AM +0200, Christoph Hellwig wrote:
> Now that I've fixed the sparc32 iommu code in another thread:  can
> you send me your rootfs and qemu arm command line for the failing
> one?  I have a hard time parsing your buildbot output.

FWIW: mmc_blk_data_prep() calls blk_rq_map_sg() with a large offset value.
The old code translated this into:

blk_bvec_map_sg(q=c77a0000 len=13824 offset=18944)
  sg_set_page(sg=c6015000 p=c7efd180 l=13824 o=2560)

The new code leaves offset unchanged:

blk_bvec_map_sg(q=c76c0528 len=13824 offset=18944)
  sg_set_page(sg=c6035000 p=c7f2af00 l=13824 o=18944)

Traceback:

[<c065e3d4>] (blk_rq_map_sg) from [<c0ca1444>] (mmc_blk_data_prep+0x1b0/0x2c8)
[<c0ca1444>] (mmc_blk_data_prep) from [<c0ca15ac>] (mmc_blk_rw_rq_prep+0x50/0x178)
[<c0ca15ac>] (mmc_blk_rw_rq_prep) from [<c0ca48bc>] (mmc_blk_mq_issue_rq+0x290/0x878)
[<c0ca48bc>] (mmc_blk_mq_issue_rq) from [<c0ca52e4>] (mmc_mq_queue_rq+0x128/0x234)
[<c0ca52e4>] (mmc_mq_queue_rq) from [<c066350c>] (blk_mq_dispatch_rq_list+0xc8/0x5e8)
[<c066350c>] (blk_mq_dispatch_rq_list) from [<c06681a8>] (blk_mq_do_dispatch_sched+0x60/0xfc)
[<c06681a8>] (blk_mq_do_dispatch_sched) from [<c06688b8>] (blk_mq_sched_dispatch_requests+0x134/0x1b0)
[<c06688b8>] (blk_mq_sched_dispatch_requests) from [<c0661f08>] (__blk_mq_run_hw_queue+0xa4/0x138)
[<c0661f08>] (__blk_mq_run_hw_queue) from [<c03622a0>] (process_one_work+0x218/0x510)
[<c03622a0>] (process_one_work) from [<c0363230>] (worker_thread+0x44/0x5bc)

This results in bad data transfers, which ultimately causes the crash.

Guenter
