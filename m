Return-Path: <SRS0=uvQv=N3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E86C43441
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 00:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DBCD2145D
	for <linux-block@archiver.kernel.org>; Fri, 16 Nov 2018 00:01:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DBCD2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbeKPKLJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Nov 2018 05:11:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51148 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726007AbeKPKLJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Nov 2018 05:11:09 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 990D0307D96D;
        Fri, 16 Nov 2018 00:01:06 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CB4FC100191D;
        Fri, 16 Nov 2018 00:00:58 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id wAG00w1U003838;
        Thu, 15 Nov 2018 19:00:58 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id wAG00uAZ003834;
        Thu, 15 Nov 2018 19:00:57 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Thu, 15 Nov 2018 19:00:56 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Jens Axboe <axboe@kernel.dk>
cc:     Mike Snitzer <snitzer@redhat.com>,
        "Alasdair G. Kergon" <agk@redhat.com>,
        Christoph Hellwig <hch@infradead.org>, dm-devel@redhat.com,
        linux-block@vger.kernel.org
Subject: Re: [patch 0/5] device mapper percpu patches
In-Reply-To: <edc963dd-378a-0342-83f6-b364aecb40cd@kernel.dk>
Message-ID: <alpine.LRH.2.02.1811151815520.25860@file01.intranet.prod.int.rdu2.redhat.com>
References: <20181106213458.308968760@debian-a64.vm> <20181107222904.GB24491@redhat.com> <alpine.LRH.2.02.1811071741470.20405@file01.intranet.prod.int.rdu2.redhat.com> <edc963dd-378a-0342-83f6-b364aecb40cd@kernel.dk>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Fri, 16 Nov 2018 00:01:06 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On Wed, 7 Nov 2018, Jens Axboe wrote:

> On 11/7/18 3:47 PM, Mikulas Patocka wrote:
> > 
> > I'd like to know - which kernel part needs to sum the percpu IO counters 
> > frequently?
> > 
> > My impression was that the counters need to be summed only when the user 
> > is reading the files in sysfs and that is not frequent at all.
> 
> part_round_stats() does it on IO completion - only every jiffy, but it's
> enough that previous attempts at percpu inflight counters only worked
> for some cases, and were worse for others.

I see.

I thought about it - part_round_stats() is used to calculate two counters 
- time_in_queue and io_ticks.

time_in_queue can be calculating by adding the duration of the I/O when 
the I/O ends (the value will be the same except for in-progress I/Os).

io_ticks could be approximated - if an I/O is started or finished and the 
"jiffies" value changes, we add 1. This is approximation, but if the I/Os 
take less than a jiffy, the value will be the same.


These are the benchmarks for the patches for IOPS on ramdisk (request 
size 512 bytes) and ramdisk with dm-linear attached:

fio --ioengine=psync --iodepth=1 --rw=read --bs=512 --direct=1 --numjobs=12 --time_based --runtime=10 --group_reporting --name=/dev/ram0

a system with 2 6-core processors:
/dev/ram0					6656445 IOPS
/dev/mapper/linear				2061914 IOPS
/dev/mapper/linear with percpu counters		5500976 IOPS

a system with 1 6-core processor:
/dev/ram0					4019921 IOPS
/dev/mapper/linear				2104687 IOPS
/dev/mapper/linear with percpu counters		3050195 IOPS

a virtual machine (12 virtual cores and 12 physical cores):
/dev/ram0					5304687 IOPS
/dev/mapper/linear				2115234 IOPS
/dev/mapper/linear with percpu counters		4457031 IOPS


My point of view is that we shouldn't degrade I/O throughput just to keep 
the counters accurate, so I suggest to change the counters to 
less-accurate mode. I'll send patches for that.

Device mapper has a separate dm-stats functionality that can provide 
accurate I/O counters for the whole device and for any range - it is off 
by default, so it doesn't degrade performance if the user doesn't need it.

Mikulas
