Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39200 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752160AbeFFFm0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 Jun 2018 01:42:26 -0400
Subject: Re: blktests block/019 lead system hang
To: Keith Busch <keith.busch@linux.intel.com>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
        osandov@osandov.com, linux-nvme@lists.infradead.org,
        ming.lei@redhat.com
References: <838678680.4693215.1527664726174.JavaMail.zimbra@redhat.com>
 <1858098161.4693883.1527665214701.JavaMail.zimbra@redhat.com>
 <20180605161853.GB16899@localhost.localdomain>
 <20180605172112.GC17057@localhost.localdomain>
From: Yi Zhang <yi.zhang@redhat.com>
Message-ID: <1cbee034-d237-104d-bf5a-33e373821301@redhat.com>
Date: Wed, 6 Jun 2018 13:42:15 +0800
MIME-Version: 1.0
In-Reply-To: <20180605172112.GC17057@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Here is the output, and I can see "HotPlug+ Surprise+" on SltCap

# lspci -vvv -s 0000:83:05.0
83:05.0 PCI bridge: PLX Technology, Inc. PEX 8734 32-lane, 8-Port PCI 
Express Gen 3 (8.0GT/s) Switch (rev ab) (prog-if 00 [Normal decode])
     Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- 
Stepping- SERR- FastB2B- DisINTx+
     Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
     Latency: 0, Cache Line Size: 32 bytes
     Interrupt: pin A routed to IRQ 40
     NUMA node: 1
     Bus: primary=83, secondary=85, subordinate=85, sec-latency=0
     I/O behind bridge: 00009000-00009fff
     Memory behind bridge: c8600000-c86fffff
     Prefetchable memory behind bridge: 000003c000200000-000003c0003fffff
     Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
     BridgeCtl: Parity+ SERR+ NoISA- VGA- MAbort- >Reset- FastB2B-
         PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
     Capabilities: [40] Power Management version 3
         Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA 
PME(D0+,D1-,D2-,D3hot+,D3cold+)
         Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
     Capabilities: [48] MSI: Enable+ Count=1/8 Maskable+ 64bit+
         Address: 00000000fee00118  Data: 0000
         Masking: 000000fe  Pending: 00000000
     Capabilities: [68] Express (v2) Downstream Port (Slot+), MSI 00
         DevCap:    MaxPayload 512 bytes, PhantFunc 0
             ExtTag- RBE+
         DevCtl:    Report errors: Correctable- Non-Fatal+ Fatal+ 
Unsupported+
             RlxdOrd+ ExtTag- PhantFunc- AuxPwr- NoSnoop+
             MaxPayload 128 bytes, MaxReadReq 128 bytes
         DevSta:    CorrErr+ UncorrErr- FatalErr- UnsuppReq+ AuxPwr- 
TransPend-
         LnkCap:    Port #5, Speed 8GT/s, Width x4, ASPM L1, Exit 
Latency L0s <4us, L1 <4us
             ClockPM- Surprise+ LLActRep+ BwNot+ ASPMOptComp+
         LnkCtl:    ASPM Disabled; Disabled- CommClk-
             ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
         LnkSta:    Speed 8GT/s, Width x4, TrErr- Train- SlotClk- 
DLActive+ BWMgmt- ABWMgmt-
         SltCap:    AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ 
Surprise+
             Slot #181, PowerLimit 25.000W; Interlock- NoCompl-
         SltCtl:    Enable: AttnBtn- PwrFlt- MRL- PresDet+ CmdCplt+ 
HPIrq+ LinkChg+
             Control: AttnInd Unknown, PwrInd On, Power- Interlock-
         SltSta:    Status: AttnBtn- PowerFlt- MRL- CmdCplt- PresDet+ 
Interlock-
             Changed: MRL- PresDet- LinkState-
         DevCap2: Completion Timeout: Not Supported, TimeoutDis-, LTR+, 
OBFF Via message ARIFwd+
         DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, 
OBFF Disabled ARIFwd+
         LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-, 
Selectable De-emphasis: -6dB
              Transmit Margin: Normal Operating Range, 
EnterModifiedCompliance- ComplianceSOS-
              Compliance De-emphasis: -6dB
         LnkSta2: Current De-emphasis Level: -6dB, 
EqualizationComplete+, EqualizationPhase1+
              EqualizationPhase2+, EqualizationPhase3+, 
LinkEqualizationRequest-
     Capabilities: [a4] Subsystem: Dell Device 1f84
     Capabilities: [100 v1] Device Serial Number ab-87-00-10-b5-df-0e-00
     Capabilities: [fb4 v1] Advanced Error Reporting
         UESta:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
         UEMsk:    DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt+ UnxCmplt+ 
RxOF- MalfTLP- ECRC- UnsupReq- ACSViol+
         UESvrt:    DLP+ SDES+ TLP+ FCP+ CmpltTO- CmpltAbrt- UnxCmplt- 
RxOF+ MalfTLP+ ECRC+ UnsupReq- ACSViol-
         CESta:    RxErr- BadTLP- BadDLLP- Rollover- Timeout- NonFatalErr-
         CEMsk:    RxErr+ BadTLP+ BadDLLP+ Rollover+ Timeout+ NonFatalErr+
         AERCap:    First Error Pointer: 1f, GenCap+ CGenEn+ ChkCap+ ChkEn+
     Capabilities: [138 v1] Power Budgeting <?>
     Capabilities: [10c v1] #19
     Capabilities: [148 v1] Virtual Channel
         Caps:    LPEVC=0 RefClk=100ns PATEntryBits=1
         Arb:    Fixed- WRR32- WRR64- WRR128-
         Ctrl:    ArbSelect=Fixed
         Status:    InProgress-
         VC0:    Caps:    PATOffset=00 MaxTimeSlots=1 RejSnoopTrans-
             Arb:    Fixed+ WRR32- WRR64- WRR128- TWRR128- WRR256-
             Ctrl:    Enable+ ID=0 ArbSelect=Fixed TC/VC=ff
             Status:    NegoPending- InProgress-
     Capabilities: [e00 v1] #12
     Capabilities: [f24 v1] Access Control Services
         ACSCap:    SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+ 
UpstreamFwd+ EgressCtrl+ DirectTrans+
         ACSCtl:    SrcValid- TransBlk- ReqRedir- CmpltRedir- 
UpstreamFwd- EgressCtrl- DirectTrans-
     Capabilities: [b70 v1] Vendor Specific Information: ID=0001 Rev=0 
Len=010 <?>
     Kernel driver in use: pcieport
     Kernel modules: shpchp

Thanks

Yi


On 06/06/2018 01:21 AM, Keith Busch wrote:
> On Tue, Jun 05, 2018 at 10:18:53AM -0600, Keith Busch wrote:
>> On Wed, May 30, 2018 at 03:26:54AM -0400, Yi Zhang wrote:
>>> Hi Keith
>>> I found blktest block/019 also can lead my NVMe server hang with 4.17.0-rc7, let me know if you need more info, thanks.
>>>
>>> Server: Dell R730xd
>>> NVMe SSD: 85:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd NVMe SSD Controller 172X (rev 01)
>>>
>>> Console log:
>>> Kernel 4.17.0-rc7 on an x86_64
>>>
>>> storageqe-62 login: [ 6043.121834] run blktests block/019 at 2018-05-30 03:16:34
>>> [ 6049.108476] {1}[Hardware Error]: Hardware error from APEI Generic Hardware Error Source: 3
>>> [ 6049.108478] {1}[Hardware Error]: event severity: fatal
>>> [ 6049.108479] {1}[Hardware Error]:  Error 0, type: fatal
>>> [ 6049.108481] {1}[Hardware Error]:   section_type: PCIe error
>>> [ 6049.108482] {1}[Hardware Error]:   port_type: 6, downstream switch port
>>> [ 6049.108483] {1}[Hardware Error]:   version: 1.16
>>> [ 6049.108484] {1}[Hardware Error]:   command: 0x0407, status: 0x0010
>>> [ 6049.108485] {1}[Hardware Error]:   device_id: 0000:83:05.0
>>> [ 6049.108486] {1}[Hardware Error]:   slot: 0
>>> [ 6049.108487] {1}[Hardware Error]:   secondary_bus: 0x85
>>> [ 6049.108488] {1}[Hardware Error]:   vendor_id: 0x10b5, device_id: 0x8734
>>> [ 6049.108489] {1}[Hardware Error]:   class_code: 000406
>>> [ 6049.108489] {1}[Hardware Error]:   bridge: secondary_status: 0x0000, control: 0x0003
>>> [ 6049.108491] Kernel panic - not syncing: Fatal hardware error!
>>> [ 6049.108514] Kernel Offset: 0x25800000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
> Could you attach 'lspci -vvv -s 0000:83:05.0'? Just want to see
> your switch's capabilities to confirm the pre-test checks are really
> sufficient.
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
