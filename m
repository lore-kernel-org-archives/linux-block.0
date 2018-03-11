Return-Path: <linux-block-owner@vger.kernel.org>
Received: from othala.iewc.co.za ([154.73.34.12]:40150 "EHLO othala.uls.co.za"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751227AbeCKEeK (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 10 Mar 2018 23:34:10 -0500
Subject: Re: disk-io lockup in 4.14.13 kernel
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: "pieterk@uls.co.za" <pieterk@uls.co.za>
References: <16bae006-371f-1eea-56b6-8668249d870b@uls.co.za>
 <828103f7-7550-16a3-d482-8953adc5a234@wdc.com>
 <257ceeb7-f466-d13d-8818-829759eda587@uls.co.za>
 <1520737695.8740.4.camel@wdc.com>
From: Jaco Kroon <jaco@uls.co.za>
Message-ID: <6e2ef6eb-a610-8c52-52d8-a35e4d3f36c9@uls.co.za>
Date: Sun, 11 Mar 2018 06:33:40 +0200
MIME-Version: 1.0
In-Reply-To: <1520737695.8740.4.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Bart,

On 11/03/2018 05:08, Bart Van Assche wrote:
> On Sat, 2018-03-10 at 22:56 +0200, Jaco Kroon wrote:
>> On 22/02/2018 18:46, Bart Van Assche wrote:
>>> On 02/22/18 02:58, Jaco Kroon wrote:
>>>> We've been seeing sporadic IO lockups on recent kernels.
>>> Are you using the legacy I/O stack or blk-mq? If you are not yet using
>>> blk-mq, can you switch to blk-mq + scsi-mq + dm-mq? If the lockup is
>>> reproducible with blk-mq, can you share the output of the following
>>> command:
>>>
>>> (cd /sys/kernel/debug/block && find . -type f -exec grep -aH . {} \;)
>> Looks like the lockups are far more frequent with everything on mq. 
>> Just to confirm:
>>
>> CONFIG_SCSI_MQ_DEFAULT=y
>> CONFIG_DM_MQ_DEFAULT=y
>>
>>
>> Please find attached the output from the requested.
>>
>> http://downloads.uls.co.za/lockup/lockup-20180310-223036/ contains
>> additional stuff, surrounding that.
> Thanks, that helps. In block_debug.txt I see that only for /dev/sdm a
> request got stuck:
>
> $ grep 'busy=[^0]' block_debug.txt  
> ./sdm/hctx0/tags:busy=9
>
> But I can't see in the output that has been shared which I/O scheduler has
> been configured nor which SCSI LLD is involved. Can you please also share
> that information, e.g. by providing the output of the following commands:
Had to reboot, but I trust the information should still be valid.  Could
be scheduler related now that you mention it.
> cat /sys/block/sdm/queue/scheduler
crowsnest ~ # cat /sys/block/sdm/queue/scheduler
[mq-deadline] kyber bfq none

Used to get better performance (on average) from deadline that others,
but I don't see elevator and other options that look familiar any more. 
Having said that I just cross referenced with a few other systems and
they all too use deadline and I'm not seeing similar behavior there. 
Most notably the large difference I see with those systems is that they
use raid1 and not raid6.  Could just be co-incidence.
> find /sys -name sdm # provides the PCI ID
crowsnest ~ # find /sys -name sdm
/sys/kernel/debug/block/sdm
/sys/devices/pci0000:00/0000:00:01.0/0000:01:00.0/host0/port-0:0/expander-0:0/port-0:0:0/expander-0:1/port-0:1:0/end_device-0:1:0/target0:0:13/0:0:13:0/block/sdm
/sys/class/block/sdm
/sys/block/sdm

> lspci
crowsnest ~ # lspci
00:00.0 Host bridge: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7
DMI2 (rev 02)
00:01.0 PCI bridge: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCI
Express Root Port 1 (rev 02)
00:02.0 PCI bridge: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCI
Express Root Port 2 (rev 02)
00:02.2 PCI bridge: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCI
Express Root Port 2 (rev 02)
00:03.0 PCI bridge: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCI
Express Root Port 3 (rev 02)
00:03.2 PCI bridge: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCI
Express Root Port 3 (rev 02)
00:03.3 PCI bridge: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 PCI
Express Root Port 3 (rev 02)
00:04.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 DMA Channel 0 (rev 02)
00:04.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 DMA Channel 1 (rev 02)
00:04.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 DMA Channel 2 (rev 02)
00:04.3 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 DMA Channel 3 (rev 02)
00:04.4 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 DMA Channel 4 (rev 02)
00:04.5 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 DMA Channel 5 (rev 02)
00:04.6 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 DMA Channel 6 (rev 02)
00:04.7 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 DMA Channel 7 (rev 02)
00:05.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 Address Map, VTd_Misc, System Management (rev 02)
00:05.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 Hot Plug (rev 02)
00:05.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 RAS, Control Status and Global Errors (rev 02)
00:05.4 PIC: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 I/O APIC
(rev 02)
00:11.0 Unassigned class [ff00]: Intel Corporation C610/X99 series
chipset SPSR (rev 05)
00:11.4 SATA controller: Intel Corporation C610/X99 series chipset sSATA
Controller [AHCI mode] (rev 05)
00:14.0 USB controller: Intel Corporation C610/X99 series chipset USB
xHCI Host Controller (rev 05)
00:16.0 Communication controller: Intel Corporation C610/X99 series
chipset MEI Controller #1 (rev 05)
00:16.1 Communication controller: Intel Corporation C610/X99 series
chipset MEI Controller #2 (rev 05)
00:1a.0 USB controller: Intel Corporation C610/X99 series chipset USB
Enhanced Host Controller #2 (rev 05)
00:1c.0 PCI bridge: Intel Corporation C610/X99 series chipset PCI
Express Root Port #1 (rev d5)
00:1c.6 PCI bridge: Intel Corporation C610/X99 series chipset PCI
Express Root Port #7 (rev d5)
00:1d.0 USB controller: Intel Corporation C610/X99 series chipset USB
Enhanced Host Controller #1 (rev 05)
00:1f.0 ISA bridge: Intel Corporation C610/X99 series chipset LPC
Controller (rev 05)
00:1f.2 SATA controller: Intel Corporation C610/X99 series chipset
6-Port SATA Controller [AHCI mode] (rev 05)
00:1f.3 SMBus: Intel Corporation C610/X99 series chipset SMBus
Controller (rev 05)
00:1f.6 Signal processing controller: Intel Corporation C610/X99 series
chipset Thermal Subsystem (rev 05)
01:00.0 Serial Attached SCSI controller: LSI Logic / Symbios Logic
SAS3008 PCI-Express Fusion-MPT SAS-3 (rev 02)
06:00.0 Ethernet controller: Intel Corporation I350 Gigabit Network
Connection (rev 01)
06:00.1 Ethernet controller: Intel Corporation I350 Gigabit Network
Connection (rev 01)
06:00.2 Ethernet controller: Intel Corporation I350 Gigabit Network
Connection (rev 01)
06:00.3 Ethernet controller: Intel Corporation I350 Gigabit Network
Connection (rev 01)
08:00.0 PCI bridge: ASPEED Technology, Inc. AST1150 PCI-to-PCI Bridge
(rev 03)
09:00.0 VGA compatible controller: ASPEED Technology, Inc. ASPEED
Graphics Family (rev 30)
ff:0b.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 R3 QPI Link 0 & 1 Monitoring (rev 02)
ff:0b.1 Performance counters: Intel Corporation Xeon E7 v3/Xeon E5
v3/Core i7 R3 QPI Link 0 & 1 Monitoring (rev 02)
ff:0b.2 Performance counters: Intel Corporation Xeon E7 v3/Xeon E5
v3/Core i7 R3 QPI Link 0 & 1 Monitoring (rev 02)
ff:0c.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 Unicast Registers (rev 02)
ff:0c.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 Unicast Registers (rev 02)
ff:0c.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 Unicast Registers (rev 02)
ff:0c.3 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 Unicast Registers (rev 02)
ff:0c.4 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 Unicast Registers (rev 02)
ff:0c.5 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 Unicast Registers (rev 02)
ff:0f.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 Buffered Ring Agent (rev 02)
ff:0f.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 Buffered Ring Agent (rev 02)
ff:0f.4 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 System Address Decoder & Broadcast Registers (rev 02)
ff:0f.5 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 System Address Decoder & Broadcast Registers (rev 02)
ff:0f.6 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 System Address Decoder & Broadcast Registers (rev 02)
ff:10.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 PCIe Ring Interface (rev 02)
ff:10.1 Performance counters: Intel Corporation Xeon E7 v3/Xeon E5
v3/Core i7 PCIe Ring Interface (rev 02)
ff:10.5 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 Scratchpad & Semaphore Registers (rev 02)
ff:10.6 Performance counters: Intel Corporation Xeon E7 v3/Xeon E5
v3/Core i7 Scratchpad & Semaphore Registers (rev 02)
ff:10.7 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 Scratchpad & Semaphore Registers (rev 02)
ff:12.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 Home Agent 0 (rev 02)
ff:12.1 Performance counters: Intel Corporation Xeon E7 v3/Xeon E5
v3/Core i7 Home Agent 0 (rev 02)
ff:13.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 Integrated Memory Controller 0 Target Address, Thermal & RAS
Registers (rev 02)
ff:13.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 Integrated Memory Controller 0 Target Address, Thermal & RAS
Registers (rev 02)
ff:13.3 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 Integrated Memory Controller 0 Channel Target Address Decoder (rev 02)
ff:13.4 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 Integrated Memory Controller 0 Channel Target Address Decoder (rev 02)
ff:13.5 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 Integrated Memory Controller 0 Channel Target Address Decoder (rev 02)
ff:13.6 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 DDRIO Channel 0/1 Broadcast (rev 02)
ff:13.7 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 DDRIO Global Broadcast (rev 02)
ff:14.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 Integrated Memory Controller 0 Channel 0 Thermal Control (rev 02)
ff:14.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 Integrated Memory Controller 0 Channel 1 Thermal Control (rev 02)
ff:14.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 Integrated Memory Controller 0 Channel 0 ERROR Registers (rev 02)
ff:14.3 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 Integrated Memory Controller 0 Channel 1 ERROR Registers (rev 02)
ff:14.6 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 DDRIO (VMSE) 0 & 1 (rev 02)
ff:14.7 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 DDRIO (VMSE) 0 & 1 (rev 02)
ff:15.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 Integrated Memory Controller 0 Channel 2 Thermal Control (rev 02)
ff:15.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 Integrated Memory Controller 0 Channel 3 Thermal Control (rev 02)
ff:15.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 Integrated Memory Controller 0 Channel 2 ERROR Registers (rev 02)
ff:15.3 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 Integrated Memory Controller 0 Channel 3 ERROR Registers (rev 02)
ff:16.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 Integrated Memory Controller 1 Target Address, Thermal & RAS
Registers (rev 02)
ff:16.6 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 DDRIO Channel 2/3 Broadcast (rev 02)
ff:16.7 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 DDRIO Global Broadcast (rev 02)
ff:17.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 Integrated Memory Controller 1 Channel 0 Thermal Control (rev 02)
ff:17.4 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 DDRIO (VMSE) 2 & 3 (rev 02)
ff:17.5 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 DDRIO (VMSE) 2 & 3 (rev 02)
ff:17.6 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 DDRIO (VMSE) 2 & 3 (rev 02)
ff:17.7 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 DDRIO (VMSE) 2 & 3 (rev 02)
ff:1e.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 Power Control Unit (rev 02)
ff:1e.1 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 Power Control Unit (rev 02)
ff:1e.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 Power Control Unit (rev 02)
ff:1e.3 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 Power Control Unit (rev 02)
ff:1e.4 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 Power Control Unit (rev 02)
ff:1f.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 VCU (rev 02)
ff:1f.2 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
i7 VCU (rev 02)

And also hdparm -I /dev/sdm for what it's worth.


/dev/sdm:

ATA device, with non-removable media
        Model Number:       ST4000NM0033-9ZM170                    
        Serial Number:      Z1Z9B7HL
        Firmware Revision:  SN04   
        Transport:          Serial, SATA Rev 3.0
Standards:
        Supported: 9 8 7 6 5
        Likely used: 9
Configuration:
        Logical         max     current
        cylinders       16383   16383
        heads           16      16
        sectors/track   63      63
        --
        CHS current addressable sectors:    16514064
        LBA    user addressable sectors:   268435455
        LBA48  user addressable sectors:  7814037168
        Logical  Sector size:                   512 bytes
        Physical Sector size:                   512 bytes
        Logical Sector-0 offset:                  0 bytes
        device size with M = 1024*1024:     3815447 MBytes
        device size with M = 1000*1000:     4000787 MBytes (4000 GB)
        cache/buffer size  = unknown
        Form Factor: 3.5 inch
        Nominal Media Rotation Rate: 7200
Capabilities:
        LBA, IORDY(can be disabled)
        Queue depth: 32
        Standby timer values: spec'd by Standard, no device specific minimum
        R/W multiple sector transfer: Max = 16  Current = ?
        Recommended acoustic management value: 254, current value: 0
        DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 udma5 *udma6
             Cycle time: min=120ns recommended=120ns
        PIO: pio0 pio1 pio2 pio3 pio4
             Cycle time: no flow control=120ns  IORDY flow control=120ns
Commands/features:
        Enabled Supported:
           *    SMART feature set
                Security Mode feature set
           *    Power Management feature set
           *    Write cache
           *    Look-ahead
           *    Host Protected Area feature set
           *    WRITE_BUFFER command
           *    READ_BUFFER command
           *    DOWNLOAD_MICROCODE
                SET_MAX security extension
           *    48-bit Address feature set
           *    Mandatory FLUSH_CACHE
           *    FLUSH_CACHE_EXT
           *    SMART error logging
           *    SMART self-test
           *    General Purpose Logging feature set
           *    WRITE_{DMA|MULTIPLE}_FUA_EXT
           *    64-bit World wide name
           *    IDLE_IMMEDIATE with UNLOAD
                Write-Read-Verify feature set
           *    WRITE_UNCORRECTABLE_EXT command
           *    {READ,WRITE}_DMA_EXT_GPL commands
           *    Segmented DOWNLOAD_MICROCODE
                unknown 119[6]
           *    unknown 119[7]
           *    Gen1 signaling speed (1.5Gb/s)
           *    Gen2 signaling speed (3.0Gb/s)
           *    Gen3 signaling speed (6.0Gb/s)
           *    Native Command Queueing (NCQ)
           *    Phy event counters
           *    Idle-Unload when NCQ is active
           *    READ_LOG_DMA_EXT equivalent to READ_LOG_EXT
           *    DMA Setup Auto-Activate optimization
                Device-initiated interface power management
           *    Software settings preservation
                unknown 78[7]
           *    SMART Command Transport (SCT) feature set
           *    SCT Write Same (AC2)
           *    SCT Error Recovery Control (AC3)
           *    SCT Features Control (AC4)
           *    SCT Data Tables (AC5)
                unknown 206[7]
                unknown 206[12] (vendor specific)
                unknown 206[14] (vendor specific)
Security:
        Master password revision code = 65534
                supported
        not     enabled
        not     locked
        not     frozen
        not     expired: security count
                supported: enhanced erase
        464min for SECURITY ERASE UNIT. 464min for ENHANCED SECURITY
ERASE UNIT.
Logical Unit WWN Device Identifier: 5000c50086dc88c3
        NAA             : 5
        IEEE OUI        : 000c50
        Unique ID       : 086dc88c3
Checksum: correct

Please let me know if there is anything else I can help with.

Thank you.

Kind Regards,
Jaco
