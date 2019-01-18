Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BBDAC07EBF
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 17:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBECB2087E
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 17:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="HDaS0UsW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728372AbfARRsV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 12:48:21 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41145 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728335AbfARRsV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 12:48:21 -0500
Received: by mail-pg1-f196.google.com with SMTP id m1so6377577pgq.8
        for <linux-block@vger.kernel.org>; Fri, 18 Jan 2019 09:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bVUTMn2xHeJxO5HjLICoQBfiuMUo0/1F3Ld+r7/1Xv0=;
        b=HDaS0UsW4xAO2+n8tNF7z0ToUvJ5B6PJdKDdqdv205CCKVEFJ7cTU9m4YKZsms/RdI
         ludezaN6OO/lIorCl7q4l74RUAb4Q3xYCpq/yenU3RR9q6AByJQClRtBnmsx0/ZRtYLA
         vZaqiVpcJ0HgmWYwB9KIxBTYX/1S2lqfCMcl45Udo3r5yN32fTBv1hQ+G7DARIHOum05
         YTfuYQVJQMmPxsgSPvQV26gvyqQtSi3nw5N2lx7TwINIpXNDQjs4Pj65Surm8P9jX5aP
         fzhhIWj3N6PWsylbLjFuNlP5qUH100L5ZJjZADy8z8mRaFcBqUJ4C/V0p5rG0l/sblXK
         egAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bVUTMn2xHeJxO5HjLICoQBfiuMUo0/1F3Ld+r7/1Xv0=;
        b=NR+PA98MPqWMNcQhgpP6+ZIJluqS1jTe1sP+Oy3KO6zhC24p1rbVOWNztRIVgffbei
         K0rF9Z6AiCbGBlxJeWIOM44EhJ21SF5ezUb5wL2ESFGT7C0PWyXLLKIdfjPWRJMgxZdR
         6Q66bK6Y3Xu7fyqSPDulwi/QV8pFcblKzigRuWGIMjTFfC1c7l7NcUuM9Bo4WGjd4cFD
         f5MWhUvjYBkYqFSRy5ToqK6wLgAdBeXtaiRzesHAGLPjfJKkISLHvGjjptx4DkeQPNEa
         njxQqA8NO73an/Z/fMzx6NylXQw8DDz5o5S8JnoujDMCeUoWhoMAEFOEfICinFGsE5Jz
         pSSg==
X-Gm-Message-State: AJcUukdWGLMkjFTjLU9bYggck3uXxTc0Wblo9ENZ6AOQHcHxUbYOJf3/
        fdjdQgWQKoXEH7ePJHBen+JX3wh+RuI5xA==
X-Google-Smtp-Source: ALg8bN5abUs7ynFwEtFLn8YIng7Z9SxCxbvVWdMY0PP5zFH+Y3IAh70BeP535CdF0nmMfgm21JdtqA==
X-Received: by 2002:a62:1f53:: with SMTP id f80mr20268201pff.92.1547833700079;
        Fri, 18 Jan 2019 09:48:20 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id j197sm6170110pgc.76.2019.01.18.09.48.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 09:48:18 -0800 (PST)
Subject: Re: dd hangs when reading large partitions
To:     "jianchao.wang" <jianchao.w.wang@oracle.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Cc:     SCSI <linux-scsi@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jan Kara <jack@suse.com>,
        Christoph Hellwig <hch@infradead.org>,
        Joao Pinto <jpinto@synopsys.com>,
        Fujita Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        Paolo Valente <paolo.valente@linaro.org>
References: <f792574c-e083-b218-13b4-c89be6566015@free.fr>
 <398a6e83-d482-6e72-5806-6d5bbe8bfdd9@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ef734b94-e72b-771f-350b-08d8054a58f3@kernel.dk>
Date:   Fri, 18 Jan 2019 10:48:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <398a6e83-d482-6e72-5806-6d5bbe8bfdd9@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/18/19 8:18 AM, jianchao.wang wrote:
> Hello
> 
> On 1/18/19 8:10 PM, Marc Gonzalez wrote:
>> Hello,
>>
>> I'm running into an issue which I don't know how to debug.
>> So I'm open to ideas and suggestions :-)
>>
>> On my arm64 board, I have enabled Universal Flash Storage support.
>>
>> I wanted to benchmark read performance, and noticed that the system
>> locks up when I read partitions larger than 3.5 GB, unless I tell
>> dd to use direct IO:
>>
>> *** WITH O_DIRECT ***
>> # dd if=/dev/sda of=/dev/null bs=1M iflag=direct status=progress
>> 57892929536 bytes (58 GB, 54 GiB) copied, 697.006 s, 83.1 MB/s 
>> 55256+0 records in
>> 55256+0 records out
>> 57940115456 bytes (58 GB, 54 GiB) copied, 697.575 s, 83.1 MB/s
>>
>> *** WITHOUT O_DIRECT ***
>> # dd if=/dev/sda of=/dev/null bs=1M status=progress
>> 3853516800 bytes (3.9 GB, 3.6 GiB) copied, 49.0002 s, 78.6 MB/s
>>
>>
>> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>> rcu:    1-...0: (8242 ticks this GP) idle=106/1/0x4000000000000000 softirq=168/171 fqs=2626 
>> rcu:    6-...0: (99 GPs behind) idle=ec2/1/0x4000000000000000 softirq=71/71 fqs=2626 
>> rcu:    (detected by 7, t=5254 jiffies, g=-275, q=2)
>> Task dump for CPU 1:
>> kworker/1:1H    R  running task        0   675      2 0x0000002a
>> Workqueue: kblockd blk_mq_run_work_fn
>> Call trace:
>>  __switch_to+0x168/0x1d0
> 
> It looks like the blk_mq_run_work_fn went to sleep with rcu lock (preempt), isn't it ?
> Can you share the symbol of the following address ?

It's UFS that totally buggy, if you look at its queuecommand, it does:

        if (!down_read_trylock(&hba->clk_scaling_lock))                         
                return SCSI_MLQUEUE_HOST_BUSY;

UFS either needs to get fixed up, or we'll want a way to do something like
the below.

Marc, can you test this?


diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index eaf329db3973..e28c3420a9d9 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -412,6 +412,7 @@ struct Scsi_Host *scsi_host_alloc(struct scsi_host_template *sht, int privsize)
 	shost->hostt = sht;
 	shost->this_id = sht->this_id;
 	shost->can_queue = sht->can_queue;
+	shost->queue_may_block = sht->queue_may_block;
 	shost->sg_tablesize = sht->sg_tablesize;
 	shost->sg_prot_tablesize = sht->sg_prot_tablesize;
 	shost->cmd_per_lun = sht->cmd_per_lun;
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index b13cc9288ba0..4e266af2871f 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1902,6 +1902,8 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
 	shost->tag_set.flags = BLK_MQ_F_SHOULD_MERGE | BLK_MQ_F_SG_MERGE;
 	shost->tag_set.flags |=
 		BLK_ALLOC_POLICY_TO_MQ_FLAG(shost->hostt->tag_alloc_policy);
+	if (shost->queue_may_blocK)
+		shost->tag_set.flags |= BLK_MQ_F_BLOCKING;
 	shost->tag_set.driver_data = shost;
 
 	return blk_mq_alloc_tag_set(&shost->tag_set);
diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 9ba7671b84f8..9ab354e43630 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -6981,6 +6981,7 @@ static struct scsi_host_template ufshcd_driver_template = {
 	.sg_tablesize		= SG_ALL,
 	.cmd_per_lun		= UFSHCD_CMD_PER_LUN,
 	.can_queue		= UFSHCD_CAN_QUEUE,
+	.queue_may_block	= 1,
 	.max_host_blocked	= 1,
 	.track_queue_depth	= 1,
 	.sdev_groups		= ufshcd_driver_groups,
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 6ca954e9f752..30aa7b6c4342 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -339,6 +339,11 @@ struct scsi_host_template {
 	 */
 	int can_queue;
 
+	/*
+	 * If the ->queuecommand() ever blocks, this should be set
+	 */
+	int queue_may_block;
+
 	/*
 	 * In many instances, especially where disconnect / reconnect are
 	 * supported, our host also has an ID on the SCSI bus.  If this is
@@ -584,6 +589,7 @@ struct Scsi_Host {
 
 	int this_id;
 	int can_queue;
+	int queue_may_block;
 	short cmd_per_lun;
 	short unsigned int sg_tablesize;
 	short unsigned int sg_prot_tablesize;

-- 
Jens Axboe

