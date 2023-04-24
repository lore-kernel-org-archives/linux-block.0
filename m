Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAF2C7EE20
	for <linux-block@archiver.kernel.org>; Mon, 24 Apr 2023 14:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjDXOOH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Apr 2023 10:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbjDXONv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Apr 2023 10:13:51 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960C3107
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 07:13:49 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-760b6765f36so10476739f.0
        for <linux-block@vger.kernel.org>; Mon, 24 Apr 2023 07:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682345629; x=1684937629;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D2dqFAr0uElSnoskeLJl2bfqtgTrLTcd9S44U0MhBvs=;
        b=hQF/OpWkcSQ3vJwUb03Z26aALNzdIYKPcdUFv2fPM6IEtEIvMsLKR/4kurL3DcDozg
         3TaAmIq6iQ1kmb2I5QBBzKUo1/K0+6W/7RfuIY4nGSzKQWHBRTqyde8S/RBOW1FH+ZYx
         qxpzgguSkgweHVIyP/Rrn3Gqedzd/8+2CHl2nNiXr3U9vjZPhlb9OzziY4pFHOXhgOJY
         q+iKypVeiGCLt1XOU7lRH96otG0xscJdGOBQ1KQyWidVozVLVG0+s0IYxjvmu67CvWil
         UuTZpJp6xXYUnoKvAiCFFf8sJ4RVVdVvON6cxiJ4fohJ69kmrdrdrv5vg0l90xNgx103
         6l4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682345629; x=1684937629;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D2dqFAr0uElSnoskeLJl2bfqtgTrLTcd9S44U0MhBvs=;
        b=bWIs8vseHOUFkshgqsel0i+d1UvKB57N5aYOlMxXjsAJB/U0XkBWdpdWTUFt0jZdO/
         DFQ11woAHxYYrHnxtBsLLHNvSoPlIH5M8ApFO1jZEPtlzm/+9eKtNNQrXiXc+xxntVm/
         mxGc5aAS9J3JsAibbYmx7YV11qNGC97PIQNCW7U/aLSRZ0hFAvSAz68UYdvvW5O4sIet
         tKO17bHT16SU3m02RHdKEMQeO8ktuXAsqQ0eynmZh1Lq5eLy5ppY5r16YXXWDVneBUdW
         0pm2g/xs00Ix6pZVlaCYP7JT2MinqqYQaWicjxHG1Qca6aynOiS37t0XZn5tX+9Fl1Yw
         XxDw==
X-Gm-Message-State: AAQBX9fgA5Mjx/+SXG+YZ+vdHoxTDtmCQRXjjQi1aJE9L6AtvluJIy/3
        u6DwdUCFHihyj5554q9kx6zueg==
X-Google-Smtp-Source: AKy350bpY4TkQ1XPnqESUX28bbIp/wWlfig08i+KFE1vJZch4Knha82UyD8ZZrbD4ImlW+bJAh+kfw==
X-Received: by 2002:a05:6602:3807:b0:763:b34f:6f7b with SMTP id bb7-20020a056602380700b00763b34f6f7bmr4353973iob.2.1682345628852;
        Mon, 24 Apr 2023 07:13:48 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id l41-20020a026a29000000b0040fdd2a623dsm2965133jac.138.2023.04.24.07.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Apr 2023 07:13:48 -0700 (PDT)
Message-ID: <324c9567-9cac-c64c-b133-205f651edb2f@kernel.dk>
Date:   Mon, 24 Apr 2023 08:13:47 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [GIT PULL] Block updates for 6.4-rc1
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <360c9052-38c9-ae6d-2bdd-206482d75132@kernel.dk>
In-Reply-To: <360c9052-38c9-ae6d-2bdd-206482d75132@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/21/23 2:00?PM, Jens Axboe wrote:
> Hi Linus,
> 
> Here are the block updates for the 6.4 merge window. This pull request
> contains:

Forgot to mention that this will throw a trivial reject in
drivers/block/ublk_drv.c due to this commit:

commit 8c68ae3b22fa6fb2dbe83ef955ff10936503d28e
Author: Jens Axboe <axboe@kernel.dk>
Date:   Wed Apr 5 20:00:46 2023 -0600

    ublk: read any SQE values upfront

going into 6.3-rc late in the cycle. The resolution is straight forward,
I'm including it here just in case (though I can't imagine it causing
you much trouble).

commit 5a3c8eaf1f50321138a7c282332a034c2ef4cba3
Merge: 6ea31a32652e 55793ea54d77
Author: Jens Axboe <axboe@kernel.dk>
Date:   Mon Apr 24 08:09:29 2023 -0600

    Merge branch 'for-6.4/block' into test
    
    * for-6.4/block: (118 commits)
      nbd: fix incomplete validation of ioctl arg
      ublk: don't return 0 in case of any failure
      sed-opal: geometry feature reporting command
      null_blk: Always check queue mode setting from configfs
      block: ublk: switch to ioctl command encoding
      blk-mq: fix the blk_mq_add_to_requeue_list call in blk_kick_flush
      block, bfq: Fix division by zero error on zero wsum
      fault-inject: fix build error when FAULT_INJECTION_CONFIGFS=y and CONFIGFS_FS=m
      block: store bdev->bd_disk->fops->submit_bio state in bdev
      block: re-arrange the struct block_device fields for better layout
      md/raid5: remove unused working_disks variable
      md/raid10: don't call bio_start_io_acct twice for bio which experienced read error
      md/raid10: fix memleak of md thread
      md/raid10: fix memleak for 'conf->bio_split'
      md/raid10: fix leak of 'r10bio->remaining' for recovery
      md/raid10: don't BUG_ON() in raise_barrier()
      md: fix soft lockup in status_resync
      md: add error_handlers for raid0 and linear
      md: Use optimal I/O size for last bitmap page
      md: Fix types in sb writer
      ...
    
    Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --cc drivers/block/ublk_drv.c
index 604c1a13c76e,253008b2091d..afbef182820b
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@@ -1261,10 -1254,22 +1259,23 @@@ static void ublk_handle_need_get_data(s
  	ublk_queue_cmd(ubq, req);
  }
  
+ static inline int ublk_check_cmd_op(u32 cmd_op)
+ {
+ 	u32 ioc_type = _IOC_TYPE(cmd_op);
+ 
+ 	if (IS_ENABLED(CONFIG_BLKDEV_UBLK_LEGACY_OPCODES) && ioc_type != 'u')
+ 		return -EOPNOTSUPP;
+ 
+ 	if (ioc_type != 'u' && ioc_type != 0)
+ 		return -EOPNOTSUPP;
+ 
+ 	return 0;
+ }
+ 
 -static int ublk_ch_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
 +static int __ublk_ch_uring_cmd(struct io_uring_cmd *cmd,
 +			       unsigned int issue_flags,
 +			       struct ublksrv_io_cmd *ub_cmd)
  {
 -	struct ublksrv_io_cmd *ub_cmd = (struct ublksrv_io_cmd *)cmd->cmd;
  	struct ublk_device *ub = cmd->file->private_data;
  	struct ublk_queue *ubq;
  	struct ublk_io *io;

-- 
Jens Axboe

