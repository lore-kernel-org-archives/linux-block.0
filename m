Return-Path: <SRS0=fg2o=QN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9998C169C4
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 16:17:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88A8220821
	for <linux-block@archiver.kernel.org>; Wed,  6 Feb 2019 16:17:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730548AbfBFQRK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Feb 2019 11:17:10 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:25058 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728861AbfBFQRK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Feb 2019 11:17:10 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 2FBF413F88D;
        Wed,  6 Feb 2019 17:16:26 +0100 (CET)
Subject: Re: dd hangs when reading large partitions
To:     Jianchao Wang <jianchao.w.wang@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
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
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <f792574c-e083-b218-13b4-c89be6566015@free.fr>
 <398a6e83-d482-6e72-5806-6d5bbe8bfdd9@oracle.com>
 <ef734b94-e72b-771f-350b-08d8054a58f3@kernel.dk>
 <20190119095601.GA7440@infradead.org>
 <07b2df5d-e1fe-9523-7c11-f3058a966f8a@free.fr>
 <985b340c-623f-6df2-66bd-d9f4003189ea@free.fr>
 <b3910158-83d6-21fe-1606-33e88912404a@oracle.com>
 <d082bdee-62e5-d470-b63b-196c0fe3b9fb@free.fr>
 <5132e41b-cb1a-5b81-4a72-37d0f9ea4bb9@oracle.com>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <7bd8b010-bf0c-ad64-f927-2d2187a18d0b@free.fr>
Date:   Wed, 6 Feb 2019 17:16:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <5132e41b-cb1a-5b81-4a72-37d0f9ea4bb9@oracle.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 23/01/2019 04:10, jianchao.wang wrote:

> Looking through the log
> https://pastebin.ubuntu.com/p/YSm82GxhNW/
> 
> rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> rcu:    6-...0: (13995 ticks this GP) idle=e16/1/0x4000000000000000 softirq=155/155 fqs=655 
> rcu:    (detected by 4, t=576151 jiffies, g=-391, q=18)
> Task dump for CPU 6:
> dd              R  running task        0   677    671 0x00000002
> Call trace:
>  __switch_to+0x174/0x1e0
>  ufshcd_queuecommand+0x84c/0x9a8
> 
> The task is in RUNNING state when it was scheduled out.
> So it should be a preempt (the path is under preemptible rcu).
> 
> And I wonder why it is not scheduled back for so long time that rcu stall was triggered.
> And who was occupying the cpu all the time ?
> 
> Would you please try to show all running tasks on all cpu ?
> 
> echo l > /proc/sysrq-trigger
> 
> In addition, since the rcu grace period didn't pass, a lot of things could not be moved
> forward.

# echo w > /proc/sysrq-trigger
[  517.619818] sysrq: Show Blocked State
[  517.620542]   task                        PC stack   pid father

# echo l > /proc/sysrq-trigger
[  530.692149] sysrq: Show backtrace of all active CPUs

# ps -o pid,user,stat,args
PID   USER     STAT COMMAND
    1 root     S    init
    2 root     SW   [kthreadd]
    3 root     IW<  [rcu_gp]
    4 root     IW<  [rcu_par_gp]
    5 root     IW   [kworker/0:0-eve]
    6 root     IW<  [kworker/0:0H]
    7 root     IW   [kworker/u16:0-u]
    8 root     IW<  [mm_percpu_wq]
    9 root     SW   [ksoftirqd/0]
   10 root     IW   [rcu_preempt]
   11 root     SW   [migration/0]
   12 root     IW   [kworker/0:1-rcu]
   13 root     SW   [cpuhp/0]
   14 root     SW   [cpuhp/1]
   15 root     SW   [migration/1]
   16 root     SW   [ksoftirqd/1]
   17 root     IW   [kworker/1:0-eve]
   18 root     IW<  [kworker/1:0H]
   19 root     SW   [cpuhp/2]
   20 root     SW   [migration/2]
   21 root     SW   [ksoftirqd/2]
   22 root     IW   [kworker/2:0-eve]
   23 root     IW<  [kworker/2:0H]
   24 root     SW   [cpuhp/3]
   25 root     SW   [migration/3]
   26 root     SW   [ksoftirqd/3]
   27 root     IW   [kworker/3:0-eve]
   28 root     IW<  [kworker/3:0H]
   29 root     SW   [cpuhp/4]
   30 root     SW   [migration/4]
   31 root     SW   [ksoftirqd/4]
   32 root     IW   [kworker/4:0-eve]
   33 root     IW<  [kworker/4:0H-kb]
   34 root     SW   [cpuhp/5]
   35 root     SW   [migration/5]
   36 root     SW   [ksoftirqd/5]
   37 root     IW   [kworker/5:0-eve]
   38 root     IW<  [kworker/5:0H]
   39 root     SW   [cpuhp/6]
   40 root     SW   [migration/6]
   41 root     SW   [ksoftirqd/6]
   42 root     IW   [kworker/6:0-eve]
   43 root     IW<  [kworker/6:0H]
   44 root     SW   [cpuhp/7]
   45 root     SW   [migration/7]
   46 root     SW   [ksoftirqd/7]
   47 root     IW   [kworker/7:0-eve]
   48 root     IW<  [kworker/7:0H]
   49 root     SW   [kdevtmpfs]
   50 root     IW   [kworker/u16:1-e]
   52 root     SW   [rcu_tasks_kthre]
   61 root     IW   [kworker/3:1-mm_]
   68 root     IW   [kworker/5:1-eve]
   76 root     IW   [kworker/6:1-eve]
   77 root     IW   [kworker/7:1-mm_]
   85 root     IW   [kworker/1:1-eve]
   93 root     IW   [kworker/2:1-eve]
  102 root     IW   [kworker/4:1-mm_]
  202 root     SW   [khungtaskd]
  203 root     SW   [oom_reaper]
  204 root     IW<  [writeback]
  206 root     SW   [kcompactd0]
  208 root     IW<  [kblockd]
  209 root     IW<  [devfreq_wq]
  211 root     IW   [kworker/u16:2-e]
  214 root     IW   [kworker/u16:3-e]
  224 root     IW   [kworker/u16:4-e]
  235 root     IW   [kworker/u16:5-e]
  259 root     IW   [kworker/u16:6-e]
  380 root     SW   [kswapd0]
  509 root     SW   [scsi_eh_0]
  510 root     IW<  [scsi_tmf_0]
  511 root     IW<  [ufs_clk_gating_]
  512 root     IW<  [ufs_clkscaling_]
  551 root     IW   [kworker/u16:7-e]
  635 root     IW   [kworker/u16:8-u]
  656 root     S    /sbin/klogd -n
  674 root     S    /bin/sh
  675 root     IW<  [kworker/4:1H]
  677 root     R    ps -o pid,user,stat,args


# dd if=/dev/sde of=/dev/null bs=1M & while true; do echo l > /proc/sysrq-trigger; sleep 1; done
https://pastebin.ubuntu.com/p/Sx4hXRbHby/

What information can I provide to help debug this issue?

Regards.
