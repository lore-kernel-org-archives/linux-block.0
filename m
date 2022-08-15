Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 362D6C00140
	for <linux-block@archiver.kernel.org>; Mon, 15 Aug 2022 09:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241327AbiHOJGL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 15 Aug 2022 05:06:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241184AbiHOJGL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 15 Aug 2022 05:06:11 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB4D2125E
        for <linux-block@vger.kernel.org>; Mon, 15 Aug 2022 02:06:09 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id l10so7037531lje.7
        for <linux-block@vger.kernel.org>; Mon, 15 Aug 2022 02:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=tf1vMIiecR0r0of3sA5ko3/A41BbAyaLyYN5Dj8JeKU=;
        b=NQkuCecGLhbS102+DPU72DqgUZblpJJTYavx0kCqY9ghhzkHsDs6aaKTghbHvwfxd/
         2bL4JO+M7GzVLsAPgfc9r1hW7KmlPa9KPFwrpvhXmGCP7SQzFsPy84gGVhF71MwBh5OO
         e2n6xLg5mGvk0Ak8lNNqHb8o14cyN+GydhC3DvaeUSZblNKZ1o3oC516fOkDnWkr/f9w
         AUDN1ZRTBklQ173+29WJL3Pa1qYYbK1/GEP5vzKTFfBuMUPMjVYmoLVRTs9BRffUAGAt
         m/BDmBFBOk9G9vNkLqRewfcue7P8y2wbav0KqL742KVi9gwXV8P1PJUmao4WMHzUYwUA
         BgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=tf1vMIiecR0r0of3sA5ko3/A41BbAyaLyYN5Dj8JeKU=;
        b=PsoGT8nc9q1RScGz8rHizakv5n/f7MizozBJJzpwDlH9Tht+98gB7Z5QcEezJ0Sr9U
         81ZI4izy9oN9h7UZoNSi5+KcHMHH1T/YtxQt5+VPrmkKVznHpiAfGvJjtLg2Z4Kj41po
         ScXqvGXBNUg+b4iiJsN3AccAl2AlIYTNAndSAZmyoVYIaDLGhfNbGnit5yTNmKj2BTRB
         1Djgif40qowpBfKlZfOU8mDG8HdHZERf/vqaf0/0jFn3tck182Px9D6F9jwqpsdGCwH5
         M4CyAmgWP8fjG0cjO1XdigN+9nzQrW4iJGUL0gCjNzwgwKWdZtISch5AapIJE/qwEXHO
         WrxQ==
X-Gm-Message-State: ACgBeo2Z9YFOgELl3iTX8l0ftMgBPuG0CC/DGuFT/HiicfZjShO0Nrym
        ngvPAu4MqN75U7Y8bZePv7I=
X-Google-Smtp-Source: AA6agR6Yn93L4ph9JdEiNHdR/pHgygC7DusfHDFHibSVk78XYN+lxTzBvG+zu3W1fV45hz3Xuq7uKw==
X-Received: by 2002:a2e:3210:0:b0:25e:6091:d9a with SMTP id y16-20020a2e3210000000b0025e60910d9amr4412823ljy.343.1660554368050;
        Mon, 15 Aug 2022 02:06:08 -0700 (PDT)
Received: from localhost ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id j5-20020ac24545000000b0048b28acab8csm1040230lfm.64.2022.08.15.02.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 02:06:07 -0700 (PDT)
Date:   Mon, 15 Aug 2022 11:06:06 +0200
From:   Pankaj Raghav <pankydev8@gmail.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH] block: Submit flush requests to the I/O scheduler
Message-ID: <20220815090606.lygbriic32tks45l@quentin>
References: <20220812210355.2252143-1-bvanassche@acm.org>
 <20220813064142.GA10753@lst.de>
 <f4e10a9a-313d-ce24-c610-f4e8d072d4f4@opensource.wdc.com>
 <09689854-b7b7-9a5c-cda7-f1f4de42b5fe@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09689854-b7b7-9a5c-cda7-f1f4de42b5fe@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Aug 14, 2022 at 04:44:31PM -0700, Bart Van Assche wrote:
> I agree that blk_mq_submit_bio() does not plug writes to zoned drives
> because of the following code in blk_mq_plug():
> 
> /* Zoned block device write operation case: do not plug the BIO */
> if (bdev_is_zoned(bio->bi_bdev) && op_is_write(bio_op(bio)))
> 	return NULL;
> 
> However, I have not found any code in blk_execute_rq_nowait() that causes
> the plugging mechanism to be skipped for zoned writes. Did I perhaps
> overlook something? The current blk_execute_rq_nowait() implementation is as
> follows:
> 
IIUC, blk_execute_rq_nowait() is used mainly by lower level drivers to send
commands but current->plug is not initialized with blk_start_plug() in those
drivers. So, the rqs are not added to the plug list.

I did a quick test with fio with the new uring_cmd IO path that uses
blk_execute_rq_nowait() and it never plugged the rqs.

fio --filename=/dev/ng0n3 --size=128M --rw=write --bs=4k --zonemode=zbd --ioengine=io_uring_cmd --name=zoned

Did you notice it otherwise?

But I think it is better if we change current->plug to blk_mq_plug() to
be on the safer side.
> void blk_execute_rq_nowait(struct request *rq, bool at_head)
> {
> 	WARN_ON(irqs_disabled());
> 	WARN_ON(!blk_rq_is_passthrough(rq));
> 
> 	blk_account_io_start(rq);
> 	if (current->plug)
> 		blk_add_rq_to_plug(current->plug, rq);
> 	else
> 		blk_mq_sched_insert_request(rq, at_head, true, false);
> }
> 
> Thanks,
> 
> Bart.

-- 
Pankaj Raghav
