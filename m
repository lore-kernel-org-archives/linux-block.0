Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F56DEE14D3
	for <linux-block@archiver.kernel.org>; Wed,  6 Sep 2023 21:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbjIFVD7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 Sep 2023 17:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjIFVD7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 6 Sep 2023 17:03:59 -0400
Received: from bagheera.iewc.co.za (bagheera.iewc.co.za [IPv6:2c0f:f720:0:3::9a49:2249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185F110F1
        for <linux-block@vger.kernel.org>; Wed,  6 Sep 2023 14:03:50 -0700 (PDT)
Received: from [154.73.32.4] (helo=tauri.local.uls.co.za)
        by bagheera.iewc.co.za with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <jaco@uls.co.za>)
        id 1qdzgN-0002xG-13;
        Wed, 06 Sep 2023 23:03:27 +0200
Received: from [192.168.1.145]
        by tauri.local.uls.co.za with esmtp (Exim 4.96)
        (envelope-from <jaco@uls.co.za>)
        id 1qdzgM-00052R-0M;
        Wed, 06 Sep 2023 23:03:26 +0200
Message-ID: <29785264-a5f1-493a-df22-8fa291c3d28a@uls.co.za>
Date:   Wed, 6 Sep 2023 23:03:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: LVM kernel lockup scenario during lvcreate
Content-Language: en-GB
To:     Laurence Oberman <loberman@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <549daeae-1180-c0d4-915c-f18bcd1c68c3@uls.co.za>
 <58b1c8ae-dd2d-3eeb-f707-3f20513ab9e3@acm.org>
 <94477c459a398c47cb251afbcafbc9a6a83bba6f.camel@redhat.com>
 <977a1223-a543-a6ca-4a6c-0cf0fc6f84a0@uls.co.za>
 <69227e4091f3d9b05e739f900340f11afacdd91f.camel@redhat.com>
 <564fe606-1bbf-4f29-4f10-7142ae07321f@uls.co.za>
 <b641b62d42fe890fa298dd1e3d56d685c6496441.camel@redhat.com>
From:   Jaco Kroon <jaco@uls.co.za>
Organization: Ultimate Linux Solutions (Pty) Ltd
In-Reply-To: <b641b62d42fe890fa298dd1e3d56d685c6496441.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Just some feedback:

After an initial nightmare to get the system bootable again after it 
failed to boot after hot-upgrading the MPT3SAS firmware this has been 
the most stable the system has been in a long time.  Not to mention more 
performant.

Thanks for all the assistance, I'm hoping that this can now be put to rest.

The AHCI system as it turns out had a pending disk failure that is still 
not picked up by SMART, but kicking that drive out of the array after 
realising it was not on par with the other drives that system too seems 
much happier, so possibly related in that it's "underlying hardware" 
causing the problems, but could also be not related at all. For the time 
being we're just happy that everything is working as intended.  10 days 
is by far the longest we've managed on this host with mq-deadline as IO 
scheduler.


crowsnest [22:52:07] ~ # uptime
  22:52:08 up 10 days, 12:29,  2 users,  load average: 10.61, 10.74, 13.29

crowsnest [22:53:17] ~ # cat /sys/class/block/*/queue/scheduler| sort | 
uniq -c
      70 none
      32 none [mq-deadline] kyber bfq

crowsnest [22:54:12] ~ # iostat -dmx /dev/sd[a-z] /dev/sda[a-z]
Linux 6.4.12-uls (crowsnest)     09/06/23     _x86_64_    (6 CPU)

Device            r/s     rMB/s   rrqm/s  %rrqm r_await rareq-sz     
w/s     wMB/s   wrqm/s  %wrqm w_await wareq-sz d/s     dMB/s   drqm/s  
%drqm d_await dareq-sz     f/s f_await aqu-sz  %util
sda             50.56      2.98   218.07  81.18   69.31    60.41 
55.99      2.93   698.08  92.57   65.58    53.59    0.00 0.00     0.00   
0.00    0.00     0.00    6.22    8.39    2.50 29.06
sdaa            43.59      2.95   214.92  83.14   58.59    69.38 
36.40      2.46   594.10  94.23   36.06    69.18    0.00 0.00     0.00   
0.00    0.00     0.00    1.56   15.12    3.89 17.73
sdab            44.97      2.92   206.44  82.11   51.87    66.55 
38.25      2.46   592.74  93.94   23.42    65.89    0.00 0.00     0.00   
0.00    0.00     0.00    1.56   16.99    3.26 17.98
sdac            44.52      2.90   200.94  81.86   42.48    66.71 
38.03      2.45   591.35  93.96   15.54    66.09    0.00 0.00     0.00   
0.00    0.00     0.00    1.56   12.51    2.50 17.08
sdad            44.73      2.94   208.61  82.34   47.51    67.26 
37.48      2.45   591.42  94.04   18.53    67.01    0.00 0.00     0.00   
0.00    0.00     0.00    1.56   16.59    2.85 18.12
sdae            44.19      2.90   200.65  81.95   49.42    67.19 
37.78      2.45   591.21  93.99   19.63    66.49    0.00 0.00     0.00   
0.00    0.00     0.00    1.56   16.55    2.95 17.90
sdaf            54.23      3.02   219.60  80.20   46.23    56.96 
59.82      2.95   698.69  92.11   21.86    50.46    0.00 0.00     0.00   
0.00    0.00     0.00    6.22    6.82    3.86 28.22
sdb             54.29      3.11   244.19  81.81   38.22    58.60 
60.49      2.99   708.72  92.14   14.89    50.60    0.00 0.00     0.00   
0.00    0.00     0.00    6.22    5.83    3.01 27.55
sdc             65.14      4.23   196.15  75.07   45.48    66.55 
53.74      3.43   830.25  93.92   30.79    65.35    0.00 0.00     0.00   
0.00    0.00     0.00    6.66    6.66    4.66 27.23
sdd             52.41      2.99   216.72  80.53   34.92    58.33 
59.28      2.94   697.06  92.16   12.50    50.77    0.00 0.00     0.00   
0.00    0.00     0.00    6.22    5.20    2.60 26.97
sde             54.82      3.01   219.59  80.02   40.83    56.28 
61.64      2.96   699.08  91.90   16.62    49.11    0.00 0.00     0.00   
0.00    0.00     0.00    6.22    5.57    3.30 27.39
sdf             54.27      3.11   244.50  81.83   35.74    58.61 
59.98      2.99   709.02  92.20   13.20    51.03    0.00 0.00     0.00   
0.00    0.00     0.00    6.22    5.30    2.76 26.88
sdg             71.33      4.35   211.99  74.82   61.63    62.42 
59.98      3.49   837.89  93.32   65.93    59.50    0.00 0.00     0.00   
0.00    0.00     0.00    6.66    8.57    3.68 28.50
sdh             50.62      2.98   218.18  81.17   71.07    60.35 
56.47      2.93   698.11  92.52   66.92    53.18    0.00 0.00     0.00   
0.00    0.00     0.00    6.22    8.77    2.71 29.09
sdi             54.55      3.01   219.40  80.09   39.98    56.52 
60.81      2.95   699.33  92.00   15.53    49.75    0.00 0.00     0.00   
0.00    0.00     0.00    6.22    5.58    3.16 27.26
sdj             53.87      3.09   241.35  81.75   51.94    58.69 
55.36      2.99   709.64  92.76   74.17    55.27    0.00 0.00     0.00   
0.00    0.00     0.00    0.00    0.00    2.18 26.72
sdk             53.31      3.09   242.76  81.99   53.54    59.40 
59.90      3.00   712.64  92.25   31.00    51.33    0.00 0.00     0.00   
0.00    0.00     0.00    6.22    6.17    0.03 27.61
sdl             43.73      2.96   214.65  83.08   52.00    69.25 
36.42      2.46   593.91  94.22   34.34    69.13    0.00 0.00     0.00   
0.00    0.00     0.00    1.56   15.72    3.55 17.67
sdm             43.58      2.94   209.23  82.76   50.34    69.08 
36.21      2.45   592.52  94.24   30.80    69.34    0.00 0.00     0.00   
0.00    0.00     0.00    1.56   15.58    3.33 17.81
sdn             66.85      4.35   224.69  77.07   51.15    66.67 
54.92      3.31   797.51  93.56   43.70    61.67    0.00 0.00     0.00   
0.00    0.00     0.00    6.66    7.57    1.15 28.54
sdo             71.51      4.35   211.60  74.74   61.11    62.25 
60.45      3.49   837.74  93.27   60.46    59.06    0.00 0.00     0.00   
0.00    0.00     0.00    6.66    8.33    3.36 28.38
sdp             66.89      4.36   224.98  77.08   64.98    66.77 
54.75      3.31   797.56  93.58   55.14    61.83    0.00 0.00     0.00   
0.00    0.00     0.00    6.66    9.22    2.70 28.08
sdq             68.06      4.22   184.72  73.08    2.88    63.45 
58.85      3.61   871.54  93.67   68.10    62.83    0.00 0.00     0.00   
0.00    0.00     0.00    6.66   10.21    4.27 28.96
sdr             43.88      2.96   214.93  83.05   52.68    68.96 
36.73      2.46   593.97  94.18   35.18    68.59    0.00 0.00     0.00   
0.00    0.00     0.00    1.56   15.51    3.63 17.61
sds             43.61      2.94   209.03  82.74   50.47    68.97 
36.23      2.45   592.11  94.23   31.04    69.26    0.00 0.00     0.00   
0.00    0.00     0.00    1.56   15.28    3.35 17.75
sdt             68.21      4.22   184.70  73.03   49.23    63.33 
59.34      3.61   870.36  93.62   23.89    62.26    0.00 0.00     0.00   
0.00    0.00     0.00    6.67    6.78    0.10 26.44
sdu             44.79      2.92   206.04  82.14   36.88    66.83 
37.95      2.46   593.06  93.99   10.00    66.41    0.00 0.00     0.00   
0.00    0.00     0.00    1.56    8.72    2.05 16.08
sdv             65.07      4.23   195.93  75.07   51.74    66.58 
53.77      3.43   830.24  93.92   36.03    65.32    0.00 0.00     0.00   
0.00    0.00     0.00    6.66    7.96    0.63 27.63
sdw             53.09      3.09   242.20  82.02   53.06    59.51 
59.61      3.00   711.79  92.27   30.23    51.50    0.00 0.00     0.00   
0.00    0.00     0.00    6.22    6.05    4.66 27.56
sdx             43.76      2.92   207.55  82.59   64.77    68.37 
36.96      2.46   593.68  94.14   50.43    68.16    0.00 0.00     0.00   
0.00    0.00     0.00    1.56   15.86    4.72 17.88
sdy             53.98      3.10   244.09  81.89   41.78    58.87 
60.11      2.99   709.16  92.19   15.81    50.93    0.00 0.00     0.00   
0.00    0.00     0.00    6.22    7.10    3.25 28.12
sdz             44.19      2.90   200.84  81.97   48.94    67.20 
37.61      2.45   591.62  94.02   19.10    66.81    0.00 0.00     0.00   
0.00    0.00     0.00    1.56   16.49    2.91 17.88

crowsnest [22:54:33] ~ # dmesg | grep mpt3sas
[    2.860853] mpt3sas version 43.100.00.00 loaded
[    2.861232] mpt3sas_cm0: 63 BIT PCI BUS DMA ADDRESSING SUPPORTED, 
total mem (263572916 kB)
[    2.920414] mpt3sas_cm0: CurrentHostPageSize is 0: Setting default 
host page size to 4k
[    2.920537] mpt3sas_cm0: MSI-X vectors supported: 96
[    2.920723] mpt3sas_cm0:  0 6 6
[    2.921071] mpt3sas_cm0: High IOPs queues : disabled
[    2.921163] mpt3sas0-msix0: PCI-MSI-X enabled: IRQ 45
[    2.921254] mpt3sas0-msix1: PCI-MSI-X enabled: IRQ 46
[    2.921345] mpt3sas0-msix2: PCI-MSI-X enabled: IRQ 47
[    2.921436] mpt3sas0-msix3: PCI-MSI-X enabled: IRQ 49
[    2.921526] mpt3sas0-msix4: PCI-MSI-X enabled: IRQ 50
[    2.921617] mpt3sas0-msix5: PCI-MSI-X enabled: IRQ 51
[    2.921707] mpt3sas_cm0: iomem(0x00000000fb240000), 
mapped(0x000000009b390d95), size(65536)
[    2.921808] mpt3sas_cm0: ioport(0x000000000000e000), size(256)
[    2.981165] mpt3sas_cm0: CurrentHostPageSize is 0: Setting default 
host page size to 4k
[    2.981267] mpt3sas_cm0: sending message unit reset !!
[    2.982929] mpt3sas_cm0: message unit reset: SUCCESS
[    3.011138] mpt3sas_cm0: scatter gather: sge_in_main_msg(1), 
sge_per_chain(7), sge_per_io(128), chains_per_io(19)
[    3.011450] mpt3sas_cm0: request pool(0x00000000192e269b) - 
dma(0xfff00000): depth(3200), frame_size(128), pool_size(400 kB)
[    3.017719] mpt3sas_cm0: sense pool(0x000000004e7d07f8) - 
dma(0xff780000): depth(2939), element_size(96), pool_size (275 kB)
[    3.017919] mpt3sas_cm0: reply pool(0x0000000031a98fd2) - 
dma(0xff700000): depth(3264), frame_size(128), pool_size(408 kB)
[    3.018055] mpt3sas_cm0: config page(0x000000003932e626) - 
dma(0xff6fa000): size(512)
[    3.018153] mpt3sas_cm0: Allocated physical memory: size(8380 kB)
[    3.018247] mpt3sas_cm0: Current Controller Queue Depth(2936),Max 
Controller Queue Depth(3072)
[    3.018365] mpt3sas_cm0: Scatter Gather Elements per IO(128)
[    3.186266] mpt3sas_cm0: _base_display_fwpkg_version: complete
[    3.186634] mpt3sas_cm0: LSISAS3008: FWVersion(16.00.10.00), 
ChipRevision(0x02)
[    3.186734] mpt3sas_cm0: Protocol=(Initiator,Target), 
Capabilities=(TLR,EEDP,Snapshot Buffer,Diag Trace Buffer,Task Set Full,NCQ)
[    3.187767] mpt3sas_cm0: sending port enable !!
[    3.188250] mpt3sas_cm0: hba_port entry: 000000007c8cd935, port: 255 
is added to hba_port list
[    3.189417] mpt3sas_cm0: host_add: handle(0x0001), 
sas_addr(0x5003048016846300), phys(8)
[    3.190895] mpt3sas_cm0: expander_add: handle(0x0009), 
parent(0x0001), sas_addr(0x500304800175f0bf), phys(51)

crowsnest [22:55:00] ~ # uname -a
Linux crowsnest 6.4.12 #2 SMP PREEMPT_DYNAMIC Sat Aug 26 08:10:42 SAST 
2023 x86_64 Intel(R) Xeon(R) CPU E5-2603 v3 @ 1.60GHz GenuineIntel GNU/Linux

With the only extra patch being the "sbitmap: fix batching wakeup" patch 
from David Jeffery.

Kind regards,
Jaco

On 2023/08/25 14:01, Laurence Oberman wrote:

> On Fri, 2023-08-25 at 01:40 +0200, Jaco Kroon wrote:
>> Hi Laurence,
>>>>> One I am aware of is this
>>>>> commit 106397376c0369fcc01c58dd189ff925a2724a57
>>>>> Author: David Jeffery <djeffery@redhat.com>
>> I should have held off on replying until I finished looking into
>> this.
>> This looks very interesting indeed, that said, this is my first
>> serious
>> venture into the block layers of the kernel :), so the essay below is
>> more for my understanding than anything else, would be great to have
>> a
>> better understanding of the underlying principles here and your
>> feedback
>> on my understanding thereof would be much appreciated.
>>
>> If I understand this correctly (and that's a BIG IF) then it's
>> possible
>> that a bunch of IO requests goes into a wait queue for whatever
>> reason
>> (pending some other event?).  It's then possible that some of them
>> should get woken up, and previously (prior to above) it could happen
>> that only a single request gets woken up, and then that request would
>> go
>> straight back to the wait queue ... with the patch, isn't it still
>> possible that all woken up requests could just go straight back to
>> the
>> wait queue (albeit less likely)?
>>
>> Could the creation of a snapshot (which should based on my
>> understanding
>> of what a snapshot is block writes whilst the snapshot is being
>> created,
>> ie, make them go to the wait queue), and could it be that the process
>> of
>> setting up the snapshot (which itself involves writes) then
>> potentially
>> block due to this?  Ie, the write request that needs to get into the
>> next batch to allow other writes to proceed gets blocked?
>>
>> And as I write that it stops making sense to me because most likely
>> the
>> IO for creating a snapshot would only result in blocking writes to
>> the
>> LV, not to the underlying PVs which contains the metadata for the VG
>> which is being updated.
>>
>> But still ... if we think about this, the probability of that "bug"
>> hitting would increase as the number of outstanding IO requests
>> increase?  With iostat reporting r_await values upwards of 100 and
>> w_await values periodically going up to 5000 (both generally in the
>> 20-50 range for the last few minutes that I've been watching them),
>> it
>> would make sense for me that the number of requests blocking in-
>> kernel
>> could be much higher than that, it makes perfect sense for me that it
>> could be related to this.  On the other hand, IIRC iostat -dmx 1
>> usually
>> showed only minimal if any requests in either [rw]_await during
>> lockups.
>>
>> Consider the AHCI controller on the other hand where we've got 7200
>> RPM
>> SATA drives which are slow to begin with, now we've got traditional
>> snapshots, which are also causing an IO bottleneck and artificially
>> raising IO demand (much more so than thin snaps, really wish I could
>> figure out the migration process to convert this whole host to thin
>> pools but lvconvert scares me something crazy), so now having that
>> first
>> snapshot causes IO bottleneck (ignoring relevant metadata updates,
>> every
>> write to a not yet duplicated segment becomes a read + write + write
>> to
>> clone the written to segment to the snapshot - thin pools just a read
>> +
>> write for same), so already IO is more demanding, and now we try to
>> create another snapshot.
>>
>> What if some IO fails to finish (due to continually being put back
>> into
>> the wait queue), thus blocking the process of creating the snapshot
>> to
>> begin with?
>>
>> I know there are numerous other people using snapshots, but I've
>> often
>> wondered how many use it quite as heavily as we do on this specific
>> host?  Given the massive amount of virtual machine infrastructure on
>> the
>> one hand I think there must be quite a lot, but then I also think
>> many
>> of them use "enterprise" (for whatever your definition of that is)
>> storage or something like ceph, so not based on LVM.  And more and
>> more
>> so either SSD/flash or even NVMe, which given the faster response
>> times
>> would also lower the risks of IO related problems from showing
>> themselves.
>>
>> The risk seems to be during the creation of snapshots, so IO not
>> making
>> progress makes sense.
>>
>> I've back-ported the referenced path onto 6.4.12 now, which will go
>> alive Saturday morning.  Perhaps we'll be sorted now.  Will also
>> revert
>> to mq-deadline which has been shown to more regularly trigger this,
>> so
>> let's see.
>>
>>> Hello, this would usually need an NMI sent from a management
>>> interface
>>> as with it locked up no guarantee a sysrq c will get there from the
>>> keyboard.
>>> You could try though.
>>>
>>> As long as you have in /etc/kdump.conf
>>>
>>> path /var/crash
>>> core_collector makedumpfile -l --message-level 7 -d 31
>>>
>>> This will get kernel only pages and would not be very big.
>>>
>>> I could work with you privately to get what we need out of the
>>> vmcore
>>> and we would avoid transferring it.
>> Thanks.  This helps.  Let's get a core first (if it's going to happen
>> again) and then take it from there.
>>
>> Kind regards,
>> Jaco
>>
> Hello Jaco
> These hangs usually require the stacks to see where and why we are
> blocked. The vmcore will definitely help in that regard.
>
> Regards
> Laurence
>
