Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE61C282CC
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 15:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E1972146E
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 15:34:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbfBHPej (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:34:39 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:53389 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727473AbfBHPej (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Feb 2019 10:34:39 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 5420E13F8B6;
        Fri,  8 Feb 2019 16:33:42 +0100 (CET)
Subject: Re: dd hangs when reading large partitions
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     linux-mm <linux-mm@kvack.org>,
        linux-block <linux-block@vger.kernel.org>
Cc:     Jianchao Wang <jianchao.w.wang@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        fsdevel <linux-fsdevel@vger.kernel.org>,
        SCSI <linux-scsi@vger.kernel.org>,
        Joao Pinto <jpinto@synopsys.com>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Martin Petersen <martin.petersen@oracle.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ming Lei <ming.lei@redhat.com>, Omar Sandoval <osandov@fb.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>
References: <f792574c-e083-b218-13b4-c89be6566015@free.fr>
 <398a6e83-d482-6e72-5806-6d5bbe8bfdd9@oracle.com>
 <ef734b94-e72b-771f-350b-08d8054a58f3@kernel.dk>
 <20190119095601.GA7440@infradead.org>
 <07b2df5d-e1fe-9523-7c11-f3058a966f8a@free.fr>
 <985b340c-623f-6df2-66bd-d9f4003189ea@free.fr>
 <b3910158-83d6-21fe-1606-33e88912404a@oracle.com>
 <d082bdee-62e5-d470-b63b-196c0fe3b9fb@free.fr>
 <5132e41b-cb1a-5b81-4a72-37d0f9ea4bb9@oracle.com>
 <7bd8b010-bf0c-ad64-f927-2d2187a18d0b@free.fr>
 <0cfe1ed2-41e1-66a4-8d98-ebc0d9645d21@free.fr>
 <d91e8342-4672-d51d-1bde-74e910e5a959@free.fr>
 <27165898-88c3-ab42-c6c9-dd52bf0a41c8@free.fr>
Message-ID: <66419195-594c-aa83-c19d-f091ad3b296d@free.fr>
Date:   Fri, 8 Feb 2019 16:33:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <27165898-88c3-ab42-c6c9-dd52bf0a41c8@free.fr>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 07/02/2019 17:56, Marc Gonzalez wrote:

> Saw a slightly different report from another test run:
> https://pastebin.ubuntu.com/p/jCywbKgRCq/
> 
> [  340.689764] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> [  340.689992] rcu:     1-...0: (8548 ticks this GP) idle=c6e/1/0x4000000000000000 softirq=82/82 fqs=6
> [  340.694977] rcu:     (detected by 5, t=5430 jiffies, g=-719, q=16)
> [  340.703803] Task dump for CPU 1:
> [  340.709507] dd              R  running task        0   675    673 0x00000002
> [  340.713018] Call trace:
> [  340.720059]  __switch_to+0x174/0x1e0
> [  340.722192]  0xffffffc0f6dc9600
> 
> [  352.689742] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 33s!
> [  352.689910] Showing busy workqueues and worker pools:
> [  352.696743] workqueue mm_percpu_wq: flags=0x8
> [  352.701753]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256
> [  352.706099]     pending: vmstat_update
> 
> [  384.693730] BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 65s!
> [  384.693815] Showing busy workqueues and worker pools:
> [  384.700577] workqueue events: flags=0x0
> [  384.705699]   pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/256
> [  384.709351]     pending: vmstat_shepherd
> [  384.715587] workqueue mm_percpu_wq: flags=0x8
> [  384.719495]   pwq 2: cpus=1 node=0 flags=0x0 nice=0 active=1/256
> [  384.723754]     pending: vmstat_update

Running 'dd if=/dev/sda of=/dev/null bs=40M status=progress'
I got a slightly different splat:

[  171.513944] INFO: task dd:674 blocked for more than 23 seconds.
[  171.514131]       Tainted: G S                5.0.0-rc5-next-20190206 #23
[  171.518784] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  171.525728] dd              D    0   674    672 0x00000000
[  171.533525] Call trace:
[  171.538926]  __switch_to+0x174/0x1e0
[  171.541237]  __schedule+0x1e4/0x630
[  171.545041]  schedule+0x34/0x90
[  171.548261]  io_schedule+0x20/0x40
[  171.551401]  blk_mq_get_tag+0x178/0x320
[  171.554852]  blk_mq_get_request+0x13c/0x3e0
[  171.558587]  blk_mq_make_request+0xcc/0x640
[  171.562763]  generic_make_request+0x1d4/0x390
[  171.566924]  submit_bio+0x5c/0x1c0
[  171.571447]  mpage_readpages+0x178/0x1d0
[  171.574730]  blkdev_readpages+0x3c/0x50
[  171.578831]  read_pages+0x70/0x180
[  171.582364]  __do_page_cache_readahead+0x1cc/0x200
[  171.585843]  ondemand_readahead+0x148/0x310
[  171.590613]  page_cache_async_readahead+0xc0/0x100
[  171.594719]  generic_file_read_iter+0x54c/0x860
[  171.599565]  blkdev_read_iter+0x50/0x80
[  171.603998]  __vfs_read+0x134/0x190
[  171.607800]  vfs_read+0x94/0x130
[  171.611273]  ksys_read+0x6c/0xe0
[  171.614745]  __arm64_sys_read+0x24/0x30
[  171.617974]  el0_svc_handler+0xb8/0x140
[  171.621509]  el0_svc+0x8/0xc


For the record, I'll restate the problem:

dd hangs when reading a partition larger than RAM, except when using
iflag=direct or iflag=nocache

# dd if=/dev/sde of=/dev/null bs=64M iflag=direct
64+0 records in
64+0 records out
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 51.1532 s, 84.0 MB/s

# dd if=/dev/sde of=/dev/null bs=64M iflag=nocache
64+0 records in
64+0 records out
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 60.6478 s, 70.8 MB/s

# dd if=/dev/sde of=/dev/null bs=64M count=56
56+0 records in
56+0 records out
3758096384 bytes (3.8 GB, 3.5 GiB) copied, 50.5897 s, 74.3 MB/s

# dd if=/dev/sde of=/dev/null bs=64M
/*** CONSOLE LOCKS UP ***/



I've been looking at the differences between iflag=direct and no-flag.
Using the following script to enable relevant(?) logs:

mount -t debugfs nodev /sys/kernel/debug/
cd /sys/kernel/debug/tracing/events
echo 1 > filemap/enable
echo 1 > pagemap/enable
echo 1 > vmscan/enable
echo 1 > kmem/mm_page_free/enable
echo 1 > kmem/mm_page_free_batched/enable
echo 1 > kmem/mm_page_alloc/enable
echo 1 > kmem/mm_page_alloc_zone_locked/enable
echo 1 > kmem/mm_page_pcpu_drain/enable
echo 1 > kmem/mm_page_alloc_extfrag/enable
echo 1 > kmem/kmalloc_node/enable
echo 1 > kmem/kmem_cache_alloc_node/enable
echo 1 > kmem/kmem_cache_alloc/enable
echo 1 > kmem/kmem_cache_free/enable


# dd if=/dev/sde of=/dev/null bs=64M count=1 iflag=direct
https://pastebin.ubuntu.com/p/YWp4pydM6V/
(114942 lines)

# dd if=/dev/sde of=/dev/null bs=64M count=1
https://pastebin.ubuntu.com/p/xpzgN5H3Hp/
(247439 lines)


Does anyone see what's going sideways in the no-flag case?

Regards.
