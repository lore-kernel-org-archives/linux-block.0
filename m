Return-Path: <SRS0=QnQz=SD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E53FC43381
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 02:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4545C2086C
	for <linux-block@archiver.kernel.org>; Mon,  1 Apr 2019 02:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731529AbfDACjV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Mar 2019 22:39:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45072 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbfDACjV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Mar 2019 22:39:21 -0400
Received: by mail-pg1-f196.google.com with SMTP id y3so3937447pgk.12;
        Sun, 31 Mar 2019 19:39:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8MmP8Zc5bQcKFV/FBcYEVuUdGFDUrOPeKVTppURLdH4=;
        b=cO7+unwwI285GEBeytaFOyuhzD1OkZFD0d4RYBgz114oRB3p0c8gtdID2gmos9uQY0
         deGaXCWEyJL8MRr0RuJHc93Gv0aOyyoH9NukNzmz13S4DsaAtFRgR17513dNrwi5T//q
         Unwtkrp02GqDPirXkaYRX2AvgyMNeYLBKTQHkUrEXSRpPqVWhZolZg1IjRCcqUk5Q9Bz
         WkQoqJo4J7yKZzdQq8xJNKWZI85pv3b6AAgPTwoxJCugN6sSz4PSHlPZmZZyI1j0jldQ
         IBdPra+Bh/NQtaFLR/iFup5atwhHHvAdgjvOaxxqSEDwNvKAB8aR3nL0c8hV2frLGc98
         7+0g==
X-Gm-Message-State: APjAAAXse3ls/2Nq9ffJmuXY3nGefSaY+m6rDdYdsrMHBFyIqwHzSSvm
        tAp2nZiqd9lYz/Jfzwg2P80=
X-Google-Smtp-Source: APXvYqxiwjc+ICMdlVwBmm/HH7lmPf3zgJ1Rl/S4sFWJzWL1XzYT8/e72cqNwxhhJ0pqltyTTenoIA==
X-Received: by 2002:a63:1749:: with SMTP id 9mr56458429pgx.94.1554086360278;
        Sun, 31 Mar 2019 19:39:20 -0700 (PDT)
Received: from asus.site ([2601:647:4000:5dd1:a41e:80b4:deb3:fb66])
        by smtp.gmail.com with ESMTPSA id n26sm25982716pfi.165.2019.03.31.19.39.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Mar 2019 19:39:19 -0700 (PDT)
Subject: Re: [PATCH 0/5] blk-mq: allow to run queue if queue refcount is held
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        James Smart <james.smart@broadcom.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        linux-scsi@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        jianchao wang <jianchao.w.wang@oracle.com>
References: <20190331030954.22320-1-ming.lei@redhat.com>
 <10c8ed10-3c96-b73c-18d8-114773b1d675@acm.org>
 <20190401020036.GB30776@ming.t460p>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <a64684d1-c3dc-b10a-1a03-0a8b2d01b331@acm.org>
Date:   Sun, 31 Mar 2019 19:39:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <20190401020036.GB30776@ming.t460p>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/31/19 7:00 PM, Ming Lei wrote:
> On Sun, Mar 31, 2019 at 08:27:35AM -0700, Bart Van Assche wrote:
>> I'm not sure the approach of this patch series is really the direction we
>> should pursue. There are many block driver that free resources immediately
> 
> Please see scsi_run_queue(), and the queue refcount is always held
> before run queue.

That's not correct. There is no guarantee that q->q_usage_counter > 0 
when scsi_run_queue() is called from inside scsi_requeue_run_queue().

>> I'd like to avoid having to modify all block drivers that free resources
>> immediately after blk_cleanup_queue() has returned. Have you considered to
>> modify blk_mq_run_hw_queues() such that it becomes safe to call that
>> function while blk_cleanup_queue() is in progress, e.g. by inserting a
>> percpu_ref_tryget_live(&q->q_usage_counter) /
>> percpu_ref_put(&q->q_usage_counter) pair?
> 
> It can't work because blk_mq_run_hw_queues may happen after
> percpu_ref_exit() is done.
> 
> However, if we move percpu_ref_exit() into queue's release handler, we
> don't need to grab q->q_usage_counter any more in blk_mq_run_hw_queues(),
> and we still have to free hw queue resources in queue's release handler,
> that is exactly what this patchset is doing.
> 
> In short, getting q->q_usage_counter doesn't make a difference on this
> issue.

percpu_ref_tryget_live() fails if a per-cpu counter is in the "dead" 
state. percpu_ref_kill() changes the state of a per-cpu counter to the 
"dead" state. blk_freeze_queue_start() calls percpu_ref_kill(). 
blk_cleanup_queue() already calls blk_set_queue_dying() and that last 
function calls blk_freeze_queue_start(). So I think that what you wrote 
is not correct and that inserting a 
percpu_ref_tryget_live()/percpu_ref_put() pair in blk_mq_run_hw_queues() 
or blk_mq_run_hw_queue() would make a difference and also that moving 
the percpu_ref_exit() call into blk_release_queue() makes sense.

Bart.
