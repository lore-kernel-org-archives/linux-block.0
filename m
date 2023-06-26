Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF9CEB64D7
	for <linux-block@archiver.kernel.org>; Mon, 26 Jun 2023 23:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjFZX3c (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Jun 2023 19:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjFZX3c (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2023 19:29:32 -0400
Received: from uriel.iewc.co.za (uriel.iewc.co.za [IPv6:2c0f:f720:0:3::9a49:2248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 954A0FB
        for <linux-block@vger.kernel.org>; Mon, 26 Jun 2023 16:29:28 -0700 (PDT)
Received: from [154.73.32.4] (helo=tauri.local.uls.co.za)
        by uriel.iewc.co.za with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jaco@uls.co.za>)
        id 1qDve1-0004ue-Kz; Tue, 27 Jun 2023 01:29:17 +0200
Received: from [192.168.1.145]
        by tauri.local.uls.co.za with esmtp (Exim 4.94.2)
        (envelope-from <jaco@uls.co.za>)
        id 1qDve1-0008VZ-AV; Tue, 27 Jun 2023 01:29:17 +0200
Message-ID: <18d1c5a6-acd3-88cf-f997-80d97f43ab5c@uls.co.za>
Date:   Tue, 27 Jun 2023 01:29:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: LVM kernel lockup scenario during lvcreate
Content-Language: en-GB
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <549daeae-1180-c0d4-915c-f18bcd1c68c3@uls.co.za>
 <58b1c8ae-dd2d-3eeb-f707-3f20513ab9e3@acm.org>
 <102b1994-74ff-c099-292c-f5429ce768c3@uls.co.za>
 <6b066ab5-7806-5a23-72a5-073153259116@acm.org>
 <544f4434-a32a-1824-b57a-9f7ff12dbb4f@uls.co.za>
 <a6d73e89-7a0c-3173-5f70-cd12cc7ef158@acm.org>
From:   Jaco Kroon <jaco@uls.co.za>
Organization: Ultimate Linux Solutions (Pty) Ltd
In-Reply-To: <a6d73e89-7a0c-3173-5f70-cd12cc7ef158@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Bart,

On 2023/06/26 18:42, Bart Van Assche wrote:
> On 6/26/23 01:30, Jaco Kroon wrote:
>> Please find attached updated ps and dmesg too, diskinfo wasn't 
>> regenerated but this doesn't generally change.
>>
>> Not sure how this all works, according to what I can see the only 
>> disk with pending activity (queued) is sdw?  Yet, a large number of 
>> processes is blocking on IO, and yet again the stack traces in dmesg 
>> points at __schedule.  For a change we do not have lvcreate in the 
>> process list! This time that particular script's got a fsck in 
>> uninterruptable wait ...
>
> Hi Jaco,
>
> I see pending commands for five different SCSI disks:
>
> $ zgrep /busy: block.gz
> ./sdh/hctx0/busy:00000000affe2ba0 {.op=WRITE, .cmd_flags=SYNC|FUA, 
> .rq_flags=FLUSH_SEQ|MQ_INFLIGHT|DONTPREP|IO_STAT|ELV, 
> .state=in_flight, .tag=2055, .internal_tag=214, .cmd=Write(16) 8a 08 
> 00 00 00 01 d1 c0 b7 88 00 00 00 08 00 00, .retries=0, .result = 0x0, 
> .flags=TAGGED|INITIALIZED|LAST, .timeout=180.000, allocated 0.000 s ago}
> ./sda/hctx0/busy:00000000987bb7c7 {.op=WRITE, .cmd_flags=SYNC|FUA, 
> .rq_flags=FLUSH_SEQ|MQ_INFLIGHT|DONTPREP|IO_STAT|ELV, 
> .state=in_flight, .tag=2050, .internal_tag=167, .cmd=Write(16) 8a 08 
> 00 00 00 01 d1 c0 b7 88 00 00 00 08 00 00, .retries=0, .result = 0x0, 
> .flags=TAGGED|INITIALIZED|LAST, .timeout=180.000, allocated 0.010 s ago}
> ./sdw/hctx0/busy:00000000aec61b17 {.op=READ, .cmd_flags=META|PRIO, 
> .rq_flags=STARTED|MQ_INFLIGHT|DONTPREP|ELVPRIV|IO_STAT|ELV, 
> .state=in_flight, .tag=2056, .internal_tag=8, .cmd=Read(16) 88 00 00 
> 00 00 00 00 1c 01 a8 00 00 00 08 00 00, .retries=0, .result = 0x0, 
> .flags=TAGGED|INITIALIZED|LAST, .timeout=180.000, allocated 0.000 s ago}
> ./sdw/hctx0/busy:0000000087e9a58e {.op=WRITE, .cmd_flags=SYNC|FUA, 
> .rq_flags=FLUSH_SEQ|MQ_INFLIGHT|DONTPREP|IO_STAT|ELV, 
> .state=in_flight, .tag=2058, .internal_tag=102, .cmd=Write(16) 8a 08 
> 00 00 00 01 d1 c0 b7 88 00 00 00 08 00 00, .retries=0, .result = 0x0, 
> .flags=TAGGED|INITIALIZED|LAST, .timeout=180.000, allocated 0.000 s ago}
> ./sdaf/hctx0/busy:00000000d8751601 {.op=WRITE, .cmd_flags=SYNC|FUA, 
> .rq_flags=FLUSH_SEQ|MQ_INFLIGHT|DONTPREP|IO_STAT|ELV, 
> .state=in_flight, .tag=2057, .internal_tag=51, .cmd=Write(16) 8a 08 00 
> 00 00 01 d1 c0 b7 88 00 00 00 08 00 00, .retries=0, .result = 0x0, 
> .flags=TAGGED|INITIALIZED|LAST, .timeout=180.000, allocated 0.010 s ago}
>
> All requests have the flag "ELV". So my follow-up questions are:
> * Which I/O scheduler has been configured? If it is BFQ, please try 
> whether
>   mq-deadline or "none" work better.

crowsnest [00:34:58] /sys/class/block/sda/device/block/sda/queue # cat 
scheduler
none [mq-deadline] kyber bfq

crowsnest [00:35:31] /sys/class/block # for i in 
*/device/block/sd*/queue/scheduler; do echo none > $i; done
crowsnest [00:35:45] /sys/class/block #

So let's see if that perhaps relates.  Neither CFQ nor BFQ has ever 
given me anywhere near the performance of deadline, so that's our 
default goto.

> * Have any of the cgroup I/O controllers been activated?

No.  Kernel is compiled without CGROUPS support on this specific host.

> * Are the disks directly connected to the motherboard of the server or 
> are
>   the disks perhaps controlled by a HBA? If so, which HBA? There are 
> multiple
>   lines in dmesg that start with "mpt3sas". Is the firmware of this HBA
>   up-to-date?

Very good question.  The host is a 36-drive bay Supermicro host 
(SSG-5048R-E1CR36L to be precise).

Internally it may be using some form of SAS extender/HBA, but there are 
no externally connected drives, and from my knowledge of HBAs these (in 
all cases where I've seen them in use) they're used to connect external 
storage arrays to a host.  So to the best of my knowledge all drives are 
directly connected to the mpt3sas controller using the SAS bus.  
Unfortunately there are some SATA drives remaining in the mix, but as 
these fail they're getting replaced with NL-SAS drives.  This may 
(obviously) have some negative influence.

These includes (the drives that were busy from your assessment):

/dev/sda    4001GB SATA 3.0, 6.0 Gb/s (current: 6.0 Gb/s)   p3:md2 
p2:md1 p1:md0
/dev/sdh    4001GB SATA 3.0, 6.0 Gb/s (current: 6.0 Gb/s)   p3:md2 
p2:md1 p1:md0
/dev/sdw    4001GB SATA 3.1, 6.0 Gb/s (current: 6.0 Gb/s)   p3:md2 
p2:md1 p1:md0

But not sdaf:

/dev/sdaf   4001GB SAS (SPL-4) p3:md2 p2:md1 p1:md0

If I understand correctly from what you're indicating, 4/5 operations 
were SYNC operations, with the fifth a read op for meta data?

                 description: Serial Attached SCSI controller
                 product: SAS3008 PCI-Express Fusion-MPT SAS-3
                 vendor: Broadcom / LSI
                 physical id: 0
                 bus info: pci@0000:01:00.0
                 logical name: scsi0
                 version: 02
                 width: 64 bits
                 clock: 33MHz
                 capabilities: sas pm pciexpress vpd msi msix bus_master 
cap_list rom
                 configuration: driver=mpt3sas latency=0
                 resources: irq:24 ioport:e000(size=256) 
memory:fb200000-fb20ffff memory:fb100000-fb1fffff

lshw reports all drives directly below this, I'm not sure how much trust 
to put in that.

 From a fresh boot:

crowsnest [00:47:53] ~ # dmesg | grep -i mpt3sas
[    2.844696] mpt3sas version 43.100.00.00 loaded
[    2.844977] mpt3sas_cm0: 63 BIT PCI BUS DMA ADDRESSING SUPPORTED, 
total mem (263761276 kB)
[    2.900278] mpt3sas_cm0: CurrentHostPageSize is 0: Setting default 
host page size to 4k
[    2.900290] mpt3sas_cm0: MSI-X vectors supported: 96
[    2.900294] mpt3sas_cm0:  0 6 6
[    2.900490] mpt3sas_cm0: High IOPs queues : disabled
[    2.900493] mpt3sas0-msix0: PCI-MSI-X enabled: IRQ 45
[    2.900494] mpt3sas0-msix1: PCI-MSI-X enabled: IRQ 46
[    2.900496] mpt3sas0-msix2: PCI-MSI-X enabled: IRQ 47
[    2.900497] mpt3sas0-msix3: PCI-MSI-X enabled: IRQ 49
[    2.900498] mpt3sas0-msix4: PCI-MSI-X enabled: IRQ 50
[    2.900499] mpt3sas0-msix5: PCI-MSI-X enabled: IRQ 51
[    2.900501] mpt3sas_cm0: iomem(0x00000000fb200000), 
mapped(0x0000000047ba3e2a), size(65536)
[    2.900504] mpt3sas_cm0: ioport(0x000000000000e000), size(256)
[    2.956709] mpt3sas_cm0: CurrentHostPageSize is 0: Setting default 
host page size to 4k
[    2.956715] mpt3sas_cm0: sending message unit reset !!
[    2.958301] mpt3sas_cm0: message unit reset: SUCCESS
[    2.986679] mpt3sas_cm0: scatter gather: sge_in_main_msg(1), 
sge_per_chain(7), sge_per_io(128), chains_per_io(19)
[    2.986892] mpt3sas_cm0: request pool(0x00000000ea746c3a) - 
dma(0xfff00000): depth(3200), frame_size(128), pool_size(400 kB)
[    3.008136] mpt3sas_cm0: sense pool(0x00000000f479118e) - 
dma(0xff780000): depth(2939), element_size(96), pool_size (275 kB)
[    3.008214] mpt3sas_cm0: reply pool(0x000000009bfc1ea9) - 
dma(0xff700000): depth(3264), frame_size(128), pool_size(408 kB)
[    3.008227] mpt3sas_cm0: config page(0x0000000088a84930) - 
dma(0xff6fa000): size(512)
[    3.008229] mpt3sas_cm0: Allocated physical memory: size(8380 kB)
[    3.008231] mpt3sas_cm0: Current Controller Queue Depth(2936),Max 
Controller Queue Depth(3072)
[    3.008233] mpt3sas_cm0: Scatter Gather Elements per IO(128)
[    3.173296] mpt3sas_cm0: _base_display_fwpkg_version: complete
[    3.173585] mpt3sas_cm0: LSISAS3008: FWVersion(03.00.06.136), 
ChipRevision(0x02), BiosVersion(08.07.00.00)
[    3.173589] mpt3sas_cm0: Protocol=(Initiator,Target), 
Capabilities=(TLR,EEDP,Snapshot Buffer,Diag Trace Buffer,Task Set Full,NCQ)
[    3.174415] mpt3sas_cm0: sending port enable !!
[    3.174806] mpt3sas_cm0: hba_port entry: 000000007848ca98, port: 255 
is added to hba_port list
[    3.175771] mpt3sas_cm0: host_add: handle(0x0001), 
sas_addr(0x5003048016846300), phys(8)
[    3.177028] mpt3sas_cm0: expander_add: handle(0x0009), 
parent(0x0001), sas_addr(0x500304800175f0bf), phys(51)
[    3.183121] mpt3sas_cm0: handle(0xa) sas_address(0x500304800175f081) 
port_type(0x1)
[    3.183221] mpt3sas_cm0: handle(0xb) sas_address(0x5000c500e23ccd9d) 
port_type(0x1)
[    3.183319] mpt3sas_cm0: handle(0xc) sas_address(0x5000c500d7e872cd) 
port_type(0x1)
[    3.183417] mpt3sas_cm0: handle(0xd) sas_address(0x5000c500d1800469) 
port_type(0x1)
[    3.183515] mpt3sas_cm0: handle(0xe) sas_address(0x5000c500e2bca685) 
port_type(0x1)
[    3.183612] mpt3sas_cm0: handle(0xf) sas_address(0x5000c500e23ccd3d) 
port_type(0x1)
[    3.183710] mpt3sas_cm0: handle(0x10) sas_address(0x5000c500a7b26111) 
port_type(0x1)
[    3.183807] mpt3sas_cm0: handle(0x11) sas_address(0x500304800175f088) 
port_type(0x1)
[    3.183905] mpt3sas_cm0: handle(0x12) sas_address(0x5000c500e23cd02d) 
port_type(0x1)
[    3.184002] mpt3sas_cm0: handle(0x13) sas_address(0x5000c500a7389019) 
port_type(0x1)
[    3.184100] mpt3sas_cm0: handle(0x14) sas_address(0x500304800175f08b) 
port_type(0x1)
[    3.185511] mpt3sas_cm0: handle(0x16) sas_address(0x500304800175f09c) 
port_type(0x1)
[    3.185609] mpt3sas_cm0: handle(0x17) sas_address(0x500304800175f09d) 
port_type(0x1)
[    3.185706] mpt3sas_cm0: handle(0x18) sas_address(0x5000c500a79abd8d) 
port_type(0x1)
[    3.185804] mpt3sas_cm0: handle(0x19) sas_address(0x5000c500a7bb5add) 
port_type(0x1)
[    3.185901] mpt3sas_cm0: handle(0x1a) sas_address(0x5000c500cae2efc9) 
port_type(0x1)
[    3.185998] mpt3sas_cm0: handle(0x1b) sas_address(0x5000c500ca9fd351) 
port_type(0x1)
[    3.186096] mpt3sas_cm0: handle(0x1c) sas_address(0x500304800175f0a2) 
port_type(0x1)
[    3.186194] mpt3sas_cm0: handle(0x1d) sas_address(0x500304800175f0a3) 
port_type(0x1)
[    3.186291] mpt3sas_cm0: handle(0x1e) sas_address(0x5000c500ef616e61) 
port_type(0x1)
[    3.186389] mpt3sas_cm0: handle(0x1f) sas_address(0x5000c500ef616d3d) 
port_type(0x1)
[    3.186486] mpt3sas_cm0: handle(0x20) sas_address(0x5000c500cae2f5a1) 
port_type(0x1)
[    3.186584] mpt3sas_cm0: handle(0x21) sas_address(0x500304800175f0bd) 
port_type(0x1)
[    3.187276] mpt3sas_cm0: expander_add: handle(0x0015), 
parent(0x0009), sas_addr(0x500304800174b8bf), phys(31)
[    3.191107] mpt3sas_cm0: handle(0x22) sas_address(0x500304800174b880) 
port_type(0x1)
[    3.191206] mpt3sas_cm0: handle(0x23) sas_address(0x500304800174b881) 
port_type(0x1)
[    3.191303] mpt3sas_cm0: handle(0x24) sas_address(0x5000c50094aca809) 
port_type(0x1)
[    3.191400] mpt3sas_cm0: handle(0x25) sas_address(0x5000c500955eb465) 
port_type(0x1)
[    3.191498] mpt3sas_cm0: handle(0x26) sas_address(0x500304800174b884) 
port_type(0x1)
[    3.191595] mpt3sas_cm0: handle(0x27) sas_address(0x5000c500a6782f2d) 
port_type(0x1)
[    3.191692] mpt3sas_cm0: handle(0x28) sas_address(0x5000c500e21f30ad) 
port_type(0x1)
[    3.191790] mpt3sas_cm0: handle(0x29) sas_address(0x5000c500955ea88d) 
port_type(0x1)
[    3.191887] mpt3sas_cm0: handle(0x2a) sas_address(0x5000c500a67837a1) 
port_type(0x1)
[    3.191984] mpt3sas_cm0: handle(0x2b) sas_address(0x5000c500a61aefb1) 
port_type(0x1)
[    3.192877] mpt3sas_cm0: handle(0x2c) sas_address(0x500304800174b8bd) 
port_type(0x1)
[    3.200396] mpt3sas_cm0: port enable: SUCCESS

That at least tells me there is an HBA and an expander involved, and 
we're looking at firmware/bios versions:

LSISAS3008: FWVersion(03.00.06.136), ChipRevision(0x02), 
BiosVersion(08.07.00.00)

https://www.broadcom.com/products/storage/sas-sata-controllers/sas-3008

Seeing that the card only has 8 ports I'm guessing an HBA and/or 
expander is a given :).

And various hints that newer firmware exists ... but broadcom is not 
making it easy to find the download nor is supermicro's website of much 
help ... will try again during more sane hours.

https://www.broadcom.com/support/download-search?pg=Storage+Adapters,+Controllers,+and+ICs&pf=Storage+Adapters,+Controllers,+and+ICs&pn=SAS3008+I/O+Controller&pa=Firmware&po=&dk=&pl=&l=false

I do make note that we've in the preceding weak had a lockup on another 
host that at face value looked similar, which runs AHCI and SATA rather 
than mp3sas + a mix of SATA + NL-SAS. Unfortunately at that point in 
time the priority in getting the host up was extremely high and we were 
precluded from taking time to gather debug information of any kind 
unfortunately.

>
> Thanks,

No, thank you!

Kind Regards,
Jaco

