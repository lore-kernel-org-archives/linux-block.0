Return-Path: <SRS0=aewy=P6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28410C282C3
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 12:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE2C620855
	for <linux-block@archiver.kernel.org>; Tue, 22 Jan 2019 12:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfAVMuU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Jan 2019 07:50:20 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:51392 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727936AbfAVMuU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Jan 2019 07:50:20 -0500
Received: from [192.168.108.68] (unknown [213.36.7.13])
        (Authenticated sender: marc.w.gonzalez)
        by smtp3-g21.free.fr (Postfix) with ESMTPSA id 9FFF713F8DB;
        Tue, 22 Jan 2019 13:49:16 +0100 (CET)
Subject: Re: dd hangs when reading large partitions
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
To:     Jianchao Wang <jianchao.w.wang@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>
Cc:     fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        SCSI <linux-scsi@vger.kernel.org>,
        Joao Pinto <jpinto@synopsys.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        Can Guo <cang@codeaurora.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Vijay Viswanath <vviswana@codeaurora.org>,
        Venkat Gopalakrishnan <venkatg@codeaurora.org>,
        Ritesh Harjani <riteshh@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Maya Erez <merez@codeaurora.org>,
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
Message-ID: <0a984885-2fd3-a097-6ff4-ceb920a2d3b6@free.fr>
Date:   Tue, 22 Jan 2019 13:49:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <d082bdee-62e5-d470-b63b-196c0fe3b9fb@free.fr>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 22/01/2019 11:59, Marc Gonzalez wrote:

> 4GB RAM. And the system hangs after reading 3.8GB
> I think this is not a coincidence.
> NB: swap is disabled (this might be relevant)
> 
> On a freshly booted system, I get
> 
> # free
> random: get_random_u64 called from copy_process.isra.9.part.10+0x2c8/0x1700 with crng_init=1
> random: get_random_u64 called from arch_pick_mmap_layout+0xdc/0x100 with crng_init=1
> random: get_random_u64 called from load_elf_binary+0x2b8/0x12b4 with crng_init=1
>              total       used       free     shared    buffers     cached
> Mem:       3948996      48916    3900080      17124          0      17124
> -/+ buffers/cache:      31792    3917204
> Swap:            0          0          0

When using iflag=direct, 'buffers' doesn't grow

# dd if=/dev/sde of=/dev/null bs=1M iflag=direct & while true; do free; sleep 5; done
             total       used       free     shared    buffers     cached
Mem:       3948996      49060    3899936      17124          0      17124
-/+ buffers/cache:      31936    3917060
Swap:            0          0          0
             total       used       free     shared    buffers     cached
Mem:       3948996      50084    3898912      17124          0      17124
-/+ buffers/cache:      32960    3916036
Swap:            0          0          0
             total       used       free     shared    buffers     cached
Mem:       3948996      49832    3899164      17124          0      17124
-/+ buffers/cache:      32708    3916288
Swap:            0          0          0
             total       used       free     shared    buffers     cached
Mem:       3948996      49832    3899164      17124          0      17124
-/+ buffers/cache:      32708    3916288
Swap:            0          0          0
             total       used       free     shared    buffers     cached
Mem:       3948996      49832    3899164      17124          0      17124
-/+ buffers/cache:      32708    3916288
Swap:            0          0          0
             total       used       free     shared    buffers     cached
Mem:       3948996      49832    3899164      17124          0      17124
-/+ buffers/cache:      32708    3916288
Swap:            0          0          0
             total       used       free     shared    buffers     cached
Mem:       3948996      49832    3899164      17124          0      17124
-/+ buffers/cache:      32708    3916288
Swap:            0          0          0
             total       used       free     shared    buffers     cached
Mem:       3948996      50084    3898912      17124          0      17124
-/+ buffers/cache:      32960    3916036
Swap:            0          0          0
             total       used       free     shared    buffers     cached
Mem:       3948996      49832    3899164      17124          0      17124
-/+ buffers/cache:      32708    3916288
Swap:            0          0          0
             total       used       free     shared    buffers     cached
Mem:       3948996      50084    3898912      17124          0      17124
-/+ buffers/cache:      32960    3916036
Swap:            0          0          0
             total       used       free     shared    buffers     cached
Mem:       3948996      50084    3898912      17124          0      17124
-/+ buffers/cache:      32960    3916036
Swap:            0          0          0
4096+0 records in
4096+0 records out
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 53.3547 s, 80.5 MB/s
             total       used       free     shared    buffers     cached
Mem:       3948996      49188    3899808      17124          0      17124
-/+ buffers/cache:      32064    3916932
Swap:            0          0          0



But when using "normal" I/O, the kernel seems to consume all RAM, until
the system locks up.

# dd if=/dev/sde of=/dev/null bs=1M & while true; do free; sleep 5; done
             total       used       free     shared    buffers     cached
Mem:       3948996      49076    3899920      17124          0      17124
-/+ buffers/cache:      31952    3917044
Swap:            0          0          0
             total       used       free     shared    buffers     cached
Mem:       3948996     239816    3709180      17124     190464      17004
-/+ buffers/cache:      32348    3916648
Swap:            0          0          0
             total       used       free     shared    buffers     cached
Mem:       3948996     430760    3518236      17124     380928      16880
-/+ buffers/cache:      32952    3916044
Swap:            0          0          0
             total       used       free     shared    buffers     cached
Mem:       3948996     733716    3215280      17124     685056      17124
-/+ buffers/cache:      31536    3917460
Swap:            0          0          0
             total       used       free     shared    buffers     cached
Mem:       3948996    1037056    2911940      17124     987648      16936
-/+ buffers/cache:      32472    3916524
Swap:            0          0          0
             total       used       free     shared    buffers     cached
Mem:       3948996    1335576    2613420      17124    1285632      17124
-/+ buffers/cache:      32820    3916176
Swap:            0          0          0
             total       used       free     shared    buffers     cached
Mem:       3948996    1565188    2383808      17124    1514036      17172
-/+ buffers/cache:      33980    3915016
Swap:            0          0          0
             total       used       free     shared    buffers     cached
Mem:       3948996    1753352    2195644      17124    1702400      17004
-/+ buffers/cache:      33948    3915048
Swap:            0          0          0
             total       used       free     shared    buffers     cached
Mem:       3948996    1942784    2006212      17124    1891328      17152
-/+ buffers/cache:      34304    3914692
Swap:            0          0          0
             total       used       free     shared    buffers     cached
Mem:       3948996    2226024    1722972      17124    2175088      17204
-/+ buffers/cache:      33732    3915264
Swap:            0          0          0
             total       used       free     shared    buffers     cached
Mem:       3948996    2452092    1496904      17124    2400608      17136
-/+ buffers/cache:      34348    3914648
Swap:            0          0          0
             total       used       free     shared    buffers     cached
Mem:       3948996    2679096    1269900      17124    2626400      17100
-/+ buffers/cache:      35596    3913400
Swap:            0          0          0
             total       used       free     shared    buffers     cached
Mem:       3948996    2870828    1078168      17124    2816864      17004
-/+ buffers/cache:      36960    3912036
Swap:            0          0          0
             total       used       free     shared    buffers     cached
Mem:       3948996    3144360     804636      17124    3089760      17044
-/+ buffers/cache:      37556    3911440
Swap:            0          0          0
             total       used       free     shared    buffers     cached
Mem:       3948996    3388840     560156      17124    3333472      17088
-/+ buffers/cache:      38280    3910716
Swap:            0          0          0
             total       used       free     shared    buffers     cached
Mem:       3948996    3577752     371244      17124    3521888      17040
-/+ buffers/cache:      38824    3910172
Swap:            0          0          0
             total       used       free     shared    buffers     cached
Mem:       3948996    3754844     194152      17124    3699040      17056
-/+ buffers/cache:      38748    3910248
Swap:            0          0          0
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu:    3-...0: (0 ticks this GP) idle=be2/1/0x4000000000000000 softirq=275/275 fqs=68 
rcu:    4-...0: (709 ticks this GP) idle=386/1/0x4000000000000000 softirq=248/250 fqs=68 
rcu:    (detected by 6, t=2018 jiffies, g=505, q=8)
Task dump for CPU 3:
sh              R  running task        0   671      1 0x00000002
Call trace:
 __switch_to+0x174/0x1e0
 __kmalloc+0x37c/0x3d0
 0x100000000
Task dump for CPU 4:
dd              R  running task        0   707    671 0x00000002
Call trace:
 __switch_to+0x174/0x1e0
 __cpu_online_mask+0x0/0x8
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu:    3-...0: (0 ticks this GP) idle=be2/1/0x4000000000000000 softirq=275/275 fqs=250 
rcu:    4-...0: (709 ticks this GP) idle=386/1/0x4000000000000000 softirq=248/250 fqs=250 
rcu:    (detected by 6, t=8024 jiffies, g=505, q=8)
Task dump for CPU 3:
sh              R  running task        0   671      1 0x00000002
Call trace:
 __switch_to+0x174/0x1e0
 __kmalloc+0x37c/0x3d0
 0x100000000
Task dump for CPU 4:
dd              R  running task        0   707    671 0x00000002
Call trace:
 __switch_to+0x174/0x1e0
 __cpu_online_mask+0x0/0x8


Calling 'echo 3 > /proc/sys/vm/drop_caches' while dd is running does not seem
to free any of the buffers. Could they be considered dirty?

             total       used       free     shared    buffers     cached
Mem:       3948996    3067664     881332      17124    3011584      17176
-/+ buffers/cache:      38904    3910092
Swap:            0          0          0

# echo 3 > /proc/sys/vm/drop_caches

             total       used       free     shared    buffers     cached
Mem:       3948996    3256876     692120      17124    3200512      17076
-/+ buffers/cache:      39288    3909708
Swap:            0          0          0


Calling 'sync' has no effect either.

Regards.
