Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:46859 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751500AbdB1Iri (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Feb 2017 03:47:38 -0500
Date: Tue, 28 Feb 2017 16:35:08 +0800
From: Fengguang Wu <fengguang.wu@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-block <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>, Jens Axboe <axboe@fb.com>,
        LKP <lkp@01.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [blk_mq_register_hctx] 29dee3c03a WARNING: CPU: 0 PID: 5 at
 lib/refcount.c:114 refcount_inc
Message-ID: <20170228083508.fgcncfhksclb2dei@wfg-t540p.sh.intel.com>
References: <20170228041117.hbqqyczf5bnypqmc@wfg-t540p.sh.intel.com>
 <20170228081711.GW6515@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
In-Reply-To: <20170228081711.GW6515@twins.programming.kicks-ass.net>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Feb 28, 2017 at 09:17:11AM +0100, Peter Zijlstra wrote:
>On Tue, Feb 28, 2017 at 12:11:17PM +0800, Fengguang Wu wrote:
>> Hello,
>>
>> FYI, an old blk_mq bug triggers new warnings on this commit. It's very
>> reproducible and you may try the attached reproduce-* script.
>
>> [    4.447772] kobject (ffff88001c041f10): tried to init an initialized object, something is seriously wrong.
>> [    4.453395] CPU: 0 PID: 5 Comm: kworker/u2:0 Not tainted 4.10.0-01216-g29dee3c #2
>> [    4.455534] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.9.3-20161025_171302-gandalf 04/01/2014
>> [    4.458252] Workqueue: events_unbound async_run_entry_fn
>> [    4.459708] Call Trace:
>> [    4.460611]  dump_stack+0x19/0x27
>> [    4.461652]  kobject_init+0xda/0xf0
>> [    4.462731]  blk_mq_register_dev+0x31/0x150
>> [    4.463990]  blk_register_queue+0x205/0x250
>> [    4.465217]  device_add_disk+0x1ab/0x710
>> [    4.466384]  sd_probe_async+0x11c/0x1e0
>> [    4.467544]  async_run_entry_fn+0xbd/0x220
>> [    4.468760]  process_one_work+0x4a7/0x990
>> [    4.469938]  ? process_one_work+0x348/0x990
>> [    4.471168]  worker_thread+0x342/0x8a0
>> [    4.472300]  ? process_one_work+0x990/0x990
>> [    4.473540]  kthread+0x188/0x190
>> [    4.474557]  ? kthread_create_on_node+0x40/0x40
>> [    4.475850]  ret_from_fork+0x31/0x40
>
>So this was pre-existing wreckage? If so, that needs to be sorted first.
>Because if the kobject stuff is broken, there's no way the refcount
>stuff can begin to work.

Yeah it's old bug that should have existed for quite some time.
It's not quite related to the refcount work, just hoping the new
warning might serve as new clues to help debugging the blk_mq bug.

Thanks,
Fengguang
