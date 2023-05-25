Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF3EC77B7A
	for <linux-block@archiver.kernel.org>; Thu, 25 May 2023 08:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239027AbjEYIO4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 May 2023 04:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239544AbjEYIOx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2023 04:14:53 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2F2186
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 01:14:41 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1CEA868B05; Thu, 25 May 2023 10:14:38 +0200 (CEST)
Date:   Thu, 25 May 2023 10:14:37 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <dlemoal@kernel.org>,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 4/7] blk-mq: use the I/O scheduler for writes from the
 flush state machine
Message-ID: <20230525081437.GA22420@lst.de>
References: <20230519044050.107790-1-hch@lst.de> <20230519044050.107790-5-hch@lst.de> <20230524055327.GA19543@lst.de> <f7a7595f-6fd6-5fdf-4c64-b4fff367239c@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7a7595f-6fd6-5fdf-4c64-b4fff367239c@acm.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 24, 2023 at 11:07:41AM -0700, Bart Van Assche wrote:
> On 5/23/23 22:53, Christoph Hellwig wrote:
>> I turns out this causes some kind of hang I haven't been able to
>> debug yet in blktests' hotplug test.   Can you drop this and the
>> subsequent patches for now?
>
> Hi Christoph,
>
> I haven't seen this hang in my tests. If you can tell me how to run 
> blktests I can help with root-causing this issue. This is how I run 
> blktests:

This is a simple ./check run with this config, and most importantly
modular scsi_debug (which is not my usual config, othewise I would
have noticed it earlier):

----- snip -----
TEST_DEVS=(/dev/vdb)
nvme_trtype=tcp
----- snip -----

It hangs in block/001 when probing scsi_debug:

[  242.790601] INFO: task modprobe:3702 blocked for more than 120 seconds.
[  242.791572]       Not tainted 6.4.0-rc2+ #1179
[  242.792201] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this
message.
[  242.793387] task:modprobe        state:D stack:0     pid:3702  ppid:3686
flags:0x00004002
[  242.794724] Call Trace:
[  242.795121]  <TASK>
[  242.795465]  __schedule+0x307/0x840
[  242.796053]  ? call_usermodehelper_exec+0xee/0x180
[  242.796812]  schedule+0x57/0xa0
[  242.797316]  async_synchronize_full+0xa0/0x130
[  242.798029]  ? destroy_sched_domains_rcu+0x20/0x20
[  242.798803]  do_init_module+0x19f/0x200
[  242.799657]  __do_sys_finit_module+0x9e/0xf0
[  242.800324]  do_syscall_64+0x34/0x80
[  242.800879]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

