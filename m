Return-Path: <SRS0=kJV6=5Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19E1C2D0EA
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 13:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DFC0206F7
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 13:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgDHNKd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Apr 2020 09:10:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:47738 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727993AbgDHNKc (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 8 Apr 2020 09:10:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EA3CBAF90;
        Wed,  8 Apr 2020 13:10:30 +0000 (UTC)
Date:   Wed, 8 Apr 2020 15:10:30 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     John Garry <john.garry@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V6 0/8] blk-mq: improvement CPU hotplug
Message-ID: <20200408131030.456mq6kjxscex7ql@beryllium.lan>
References: <20200407092901.314228-1-ming.lei@redhat.com>
 <20200408124017.g6wizq5bljzwb2gq@beryllium.lan>
 <d441e96f-2450-6fc7-c5ab-b8bb9f98f3be@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d441e96f-2450-6fc7-c5ab-b8bb9f98f3be@huawei.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi John,

On Wed, Apr 08, 2020 at 02:01:11PM +0100, John Garry wrote:
> Is stress-cpu-hotplug an ltp test? or from Steven Rostedt -  I saw some
> threads where he mentioned some script?

My bad. It's the script from Steven, which toggle binary the cpus on/off:

[...]
2432 disabling cpu16 disabling cpu17 disabling cpu2
2433 disabling cpu1 enabling cpu16 enabling cpu17 enabling cpu2
2434 disabling cpu10 disabling cpu16 disabling cpu17 disabling cpu2
2435 enabling cpu1 enabling cpu10 enabling cpu16 enabling cpu17 enabling cpu2
2436 disabling cpu11 disabling cpu16 disabling cpu17 disabling cpu2
2437 disabling cpu1 enabling cpu11 enabling cpu16 enabling cpu17 enabling cpu2
2438 disabling cpu10 disabling cpu11 disabling cpu16 disabling cpu17 disabling cpu2
[..]

> Will the fio processes migrate back onto cpus which have been onlined again?

Hmm, good question. I've tried to assign them to a specific CPU via
--cpus_allowed_policy=split and --cpus_allowed.

  fio --rw=randwrite --name=test --size=50M --iodepth=32 --direct=1 \
      --bs=4k --numjobs=40 --time_based --runtime=1h --ioengine=libaio \
      --group_reporting --cpus_allowed_policy=split --cpus_allowed=0-40

Though I haven't verified what happens when the CPU get's back online.

> What is the block driver NVMe?

I've used a qla2xxx device. Hannes asked my to retry it with a megasas
device.

Thanks,
Daniel
