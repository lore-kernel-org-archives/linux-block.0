Return-Path: <SRS0=kJV6=5Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 692F0C2D0EA
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 15:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C20220692
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 15:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbgDHPOT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:14:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:52082 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727126AbgDHPOT (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 8 Apr 2020 11:14:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C3FE4AD72;
        Wed,  8 Apr 2020 15:14:16 +0000 (UTC)
Date:   Wed, 8 Apr 2020 17:14:16 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     John Garry <john.garry@huawei.com>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V6 0/8] blk-mq: improvement CPU hotplug
Message-ID: <20200408151416.ecpcpsq4psdbkufk@beryllium.lan>
References: <20200407092901.314228-1-ming.lei@redhat.com>
 <20200408124017.g6wizq5bljzwb2gq@beryllium.lan>
 <d441e96f-2450-6fc7-c5ab-b8bb9f98f3be@huawei.com>
 <20200408131030.456mq6kjxscex7ql@beryllium.lan>
 <fce90f4b-1d23-a352-c48c-d80253b7a4b2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fce90f4b-1d23-a352-c48c-d80253b7a4b2@huawei.com>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Apr 08, 2020 at 02:29:51PM +0100, John Garry wrote:
> On 08/04/2020 14:10, Daniel Wagner wrote:
> ok, but to really test this you need to ensure that all the cpus for a
> managed interrupt affinity mask are offlined together for some period of
> time greater than the IO timeout. Otherwise the hw queue's managed interrupt
> would not be shut down, and you're not verifying that the queues are fully
> drained.

Not sure if I understand you correctly: Are you saying that the IRQ
related resources are not freed/moved from the offlining CPU?

> > > Will the fio processes migrate back onto cpus which have been onlined again?
> > 
> > Hmm, good question. I've tried to assign them to a specific CPU via
> > --cpus_allowed_policy=split and --cpus_allowed.
> > 
> >    fio --rw=randwrite --name=test --size=50M --iodepth=32 --direct=1 \
> >        --bs=4k --numjobs=40 --time_based --runtime=1h --ioengine=libaio \
> >        --group_reporting --cpus_allowed_policy=split --cpus_allowed=0-40
> > 
> > Though I haven't verified what happens when the CPU get's back online.
> 
> Maybe this will work since you're offlining patterns of cpus and the fio
> processes have to migrate somewhere. But see above.

At least after the initial setup a fio thread will be migrated away
from the offlining CPU.

A quick test shows, that the affinity mask for a fio thread will be
cleared when the CPU goes offline. There seems to be a discussion
going on about the cpu hotplug and the affinity mask:

https://lore.kernel.org/lkml/1251528473.590671.1579196495905.JavaMail.zimbra@efficios.com

TL;DR: it can be scheduled back if affinity is tweaked via
e.g. taskset, it won't if it's via cpusets

Thanks,
Daniel
