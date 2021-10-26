Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E795C433F5
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 05:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C7BF61078
	for <linux-block@archiver.kernel.org>; Tue, 26 Oct 2021 05:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbhJZFXD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Oct 2021 01:23:03 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:59715 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234436AbhJZFXC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Oct 2021 01:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1635225639; x=1666761639;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vq0x3NyZlmd/QIP27hl8h0pqq/O9S6m/ZbRUxlU/hgg=;
  b=qoJtg0NWZEDyfC995efCUlHjOsbYgWLotnCCV0JdSfU719Bue5y4GU74
   8XGTs4iYof458jeEiZS/IryrlaaIp2zsDwKXX2olqzh2zc3wKj02fxcsv
   jU9FLYoEqW2pGrEH88DRnXyxzbZf50XmDMEcde0SPSvKviPAl+vVYK2ow
   MCk8mqUDp0t+TaOh/avxX987/OSHlNo3ops9qtD2Rj6DvrjMP/VOXqR56
   fgGAvx6UN+kpG0vfNVjWBM+7uioIwZI/o116rE2BCpFysAENbGGKwx0f8
   3PU6Pm/zO18EORxpMclKgM4tOgnCs5D6W/RaoZB3O9xDfVvA0s44zk6kO
   g==;
X-IronPort-AV: E=Sophos;i="5.87,182,1631548800"; 
   d="scan'208";a="287716811"
Received: from mail-bn8nam08lp2041.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.41])
  by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2021 13:20:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxTYWta7p5h0Q4a9BeurHFGCe3egz5hGuu1PrI3dU1lPA0Ao+eg7zRztd50Iice0a7+h5730qbMIb283aA+rtr1e4XMUMJGLR8wi9dWELviLV52Tbhgl0fKjXbo/C2BIaJfRtDt1IpV/Jf3eyavTRBGrdI43Fpwo5JRgnZrfcyB2HoXXZ1oOa88TaAG5zQyGRuW3W8NWtqmCHdJLEyCfI2a6HjC9+RlIDWYcsGEfIwqZdceluwgQDnbZxPkvV0lMCCsgc0F26UnAU5j55nKJUJTDGFN+3URfsGQZGTiHzfiyNJ16F+oZnsvlRlH5A8HZTm3WyTpZAdIPXJu0uX4KYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVnG7ypY/ZZ3NieKwm3EYAZpxBjBoARjU/uWs5z4+6w=;
 b=ErmTuSzCZQ9W4DwVmEx6lNXSqNXxk2o54LTjSBorEH2+IxnCQ+7Cfs5m7V3nuA2++NqYry4gZ7rplgXjYL0PqL0HD6vA1CnCJ6AgwHz4unV/A3/JGfPZFrFBwmmAnWYWNnPJ+SRFgXKvCkqHTwNCOUneGsO6bJKQpLNbQYnbspf6cL0GgYI3UvQ6DSZrBzUqe3FdFW02RUmTGrKfyU29Q54pxZc7U22UHZXFcz4+q948YRhe5YjUeQuZGlKHcczcdVi2q/utc0aL8vmqtNUaJSqF+ZdXLxvheYys+4kmwZWioRlvpyqo2HI3YoQVysCHE7wcnFDXVfPgpqegVrkR8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVnG7ypY/ZZ3NieKwm3EYAZpxBjBoARjU/uWs5z4+6w=;
 b=ESDnCN21IGs9OGckwiyNZXP8ZIXb9r7BOonSjGJDqYIZ8p9p8pcECAlANEy2An33JWQuRoUpERmberd27U5L/0lnzBU/w6k5qAAOGdXUm2LMWM9ZVWX+Svd5DGzXIwZFl0cbY64rvGme4ZameyFB58Xa/lRX6quRQLF6NTDU5jA=
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com (2603:10b6:a03:291::7)
 by BYAPR04MB5141.namprd04.prod.outlook.com (2603:10b6:a03:51::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Tue, 26 Oct
 2021 05:20:36 +0000
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::30f6:c28:984d:bd79]) by SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::30f6:c28:984d:bd79%5]) with mapi id 15.20.4628.020; Tue, 26 Oct 2021
 05:20:36 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 2/2] block: attempt direct issue of plug list
Thread-Topic: [PATCH 2/2] block: attempt direct issue of plug list
Thread-Index: AQHXyik1fmcfNAtqKkq85KdLXlrYzg==
Date:   Tue, 26 Oct 2021 05:20:36 +0000
Message-ID: <20211026052036.xdsw6ejx2e2n7jhi@shindev>
References: <20211019120834.595160-1-axboe@kernel.dk>
 <20211019120834.595160-3-axboe@kernel.dk>
In-Reply-To: <20211019120834.595160-3-axboe@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 306038dc-06e8-4280-7caf-08d9984057ca
x-ms-traffictypediagnostic: BYAPR04MB5141:
x-microsoft-antispam-prvs: <BYAPR04MB51412622AD7173EFBD1268E4ED849@BYAPR04MB5141.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:126;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LOmFglEAQhcBj2xzPX6molrU9CAHU0+SZkwWrrAieVa7+s6SGN4P7k4eC5AQjhVo6LnwFagNIzGXKnGPQ/q5LY63QZsiE8mK7HbzjdPG1zcjtOFcov/P0z62DxCOZYIhVmr6xW4W/KcAof0a8ew/Bx6T7RoNQyO5vSLOkxT/0x9Bn/l/G5ATr8NfolZe6Uj97X5KiDB7N8sX3kV7PQhVODV2tRMKGVvkM4zqlA8s3sVIsCkpAefpwS/2cm/YqA8JBLVAn/+7eBwoCeA4cRBpjhD3iIGAEZ6uCMlr5ZB+ZJGHOCM+PUxFc6Kx4OTtV+zd+bNr9WUqmVkW+Ek2tsinfHpRNvMZle2I0+z4AifDnCPI+fokvTcbydtFjadg5lE3RkJwAUKCQDy0PAoPauNRputf7rrSXK3GNeCUDYkfhdB7wzkQCiD9klzBIh+okV4yESkoL7iW5Wz7eaJAFp+/oAKpTjBpawLFQJW3I0SYAS1FG5OymkjVL2pOjs6pyP6sILqr1/+POunx/IDLQQ+nXNrjMBka6HLcN3wirwdiRQ0IXy9ovtNLOC/VFcrLTjrHSMhBp8w3udpXOgUR6V5hKy8M/j3dyxTGnJD3AQK18xQaW+o3XkQlwLqKMG4kEql4Va/nzwp174S1MdS4ZswchKB+kOFA5djqCjYsp3oHGfd85ZV4EyeNTHNPxHKqfv2O9z07Pm1DW7pXEII5+AW2uA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7184.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(71200400001)(26005)(6916009)(508600001)(6486002)(66946007)(316002)(44832011)(5660300002)(66446008)(82960400001)(38100700002)(86362001)(66556008)(6512007)(122000001)(4326008)(76116006)(2906002)(33716001)(6506007)(54906003)(9686003)(8936002)(38070700005)(30864003)(45080400002)(186003)(1076003)(8676002)(83380400001)(64756008)(66476007)(91956017);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WjZePxVrqA9LwRfMuSjPGm1tncJD4PWlqIvm9YwBUiiO5a9Yu00WCMZM1s4+?=
 =?us-ascii?Q?0qUIsfBkRrsNjnt2SqxTbQbIEY9Y5ITSFewXhy4mQ26N/Ru1TRlFX3Znq1vl?=
 =?us-ascii?Q?3Dvko11cygohf4+Hr1ZVcfh9EIsoQAvoNgrBGfagFs1XpRFa9NDv9+lhEJ+G?=
 =?us-ascii?Q?oXtngIf75G11WpHxW7BvTe6xc3Ud/agDE8tZ+yffz6SXlrEvz/c+mXl7zQYM?=
 =?us-ascii?Q?+tiWmf4TAWoBKCtjyeg19KeMSpUI/Og8cM/rmTrJeHFlwPMZPRUoG+2eervU?=
 =?us-ascii?Q?bCDTdI2wfy9XH8ZPz70kUBARzMke0Jn5r1Slpf8a1H7BfvCRcCXGPC67ZvM7?=
 =?us-ascii?Q?uxRSmbY7O1GW4nefNCmcNf/SIGymWfmZJn9MhjunC/FTapgbt2Gbet4eku0S?=
 =?us-ascii?Q?X6K/xy65lONQl+ixiwwX9uUlrBoy0msmrq493Aupob8fKeZi81admUO0a5eb?=
 =?us-ascii?Q?5h8hm0Wmv4TPQyjbhrT3Q8ZLFtdc0z9S6fZFOyhyd3IryNEjertadZybj5eb?=
 =?us-ascii?Q?xwB49j+541G5qdR5tWowuz+WW22fBvK7fQOBjBM5jkCCC+XCqi+GdGa9HzRc?=
 =?us-ascii?Q?h1d1GehnNKzkfHig1C0uBPl7AVPnyZyyou+T77ZFtOsEPS0gJAzR/LmKJgTf?=
 =?us-ascii?Q?khyQnIL9+WGKqFEkbVdxF6iuPqZYaSTC3uOBI/VygI1KEoA+r0aTVXY6Fke+?=
 =?us-ascii?Q?gk9KHR8sJS9hO8djGLa9RurLWjyzHj8kOGPCQyMxvjORDvMjHCKPTNdWt/AH?=
 =?us-ascii?Q?6LcMeR+LFriOz9CByXCp8k8BhWXhbHUUZQBcFGq7dVPgN9yv3YpVobpHyJLU?=
 =?us-ascii?Q?3VXsBBVUtQUR6P/AXtjHGCxCosHx63mtbjI3EPGAVOB6+Ej6JEUOVfvXr1Ub?=
 =?us-ascii?Q?A3Ag/xHqVEbS8+Mj9vsklfkgHMiTSoS9RVlQ2fINMI5WQyI4hxPcrtuAKbNm?=
 =?us-ascii?Q?+6IG2MgY7RQaQpHT+MUu1eJW4G/5BrDXZARAMkTQ8A7cqo3NFFYQxiwMl5Mv?=
 =?us-ascii?Q?9GCYexD5QxQAe5nEyE6LyN0sEamnxHLfiKLD/EmljYxFwCCRAC0pEvTfXgMd?=
 =?us-ascii?Q?XIfcXva448jtmBBPcT/itQ5AvXvPCyg9obgMvc5w3cNUx4KfuHwi4QPWdcPY?=
 =?us-ascii?Q?KbXgzzW0cIEl5+P5NYpvAre9t6o1sY+cWW2zeB6/TVtIPCg190/pkCd4GBOe?=
 =?us-ascii?Q?MAcmimEJAH0q2lOjYhygcmTWu+3IfqNOsVqPO2hl7StF8Eme/iA2xvzGDfz/?=
 =?us-ascii?Q?iJoyL1JwrGXBaD6OzYs2Jlhj++7zmPa7oW9iD8tq1rv0zWIX2I+tYZfN6GUm?=
 =?us-ascii?Q?57YjWMpqdnYCYfWNz5/x48gmRdGUwukH1qfUSvmjasUxvHmbm6t5VDapgp2j?=
 =?us-ascii?Q?onkxfgPtfMiQaq/FwT4iY+Nd11THsQOg2HTrveU7a71CENntz3pmNmYaQ0Rr?=
 =?us-ascii?Q?LPRb9k7NrgcGpzxdRWY62yXyxFX4Bsetlq1+xr/+goaqYhWIf8UVr3KI4V2t?=
 =?us-ascii?Q?SJtHg7gj2YjsjxBd9+ttIhZDILoWIakkNQNK6+1gbFWinA1pYCefn7KZkgTs?=
 =?us-ascii?Q?HuCa4+2PF3UZyUdliqxOUOE06tNNb/mqTTx4Cq7QPazeiQNohrlGb59tgUFa?=
 =?us-ascii?Q?OlX0vaggrUjz2VJr/C5df8D8yrKbLIB2OTI5/QwoAfUbUh6RiMpvo2VO/8Pt?=
 =?us-ascii?Q?nm6hlyojmh9R1qRxoe0F/smh4JE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A2D2D86458C20B4EBFB17A8C1E180AAA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7184.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 306038dc-06e8-4280-7caf-08d9984057ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2021 05:20:36.6249
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hAs+Zbc3ntCuURT3wJaSksqewNNf2MkTQBaovbirkiAJ9Td0xatPeMWLAUSejWt+T5CSACwEJ4LXbd/YvvCXr0SJY2NiGJSlrzLN9bQ/UJs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5141
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Oct 19, 2021 / 06:08, Jens Axboe wrote:
> If we have just one queue type in the plug list, then we can extend our
> direct issue to cover a full plug list as well.
>=20
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Hi Jens, I tried out for-next branch and observed A WARNING "do not call
blocking ops when !TASK_RUNNING" [1]. Reverting this patch from the for-nex=
t
branch, the warning disappears. The warning was triggered when mkfs.xfs is
run for memory backed null_blk devices with "none" scheduler. The commands =
below
recreates it.

# modprobe null_blk nr_devices=3D0
# mkdir /sys/kernel/config/nullb/nullb0
# declare sysfs=3D/sys/kernel/config/nullb/nullb0
# echo 1 > "${sysfs}"/memory_backed
# echo 1 > "${sysfs}"/power
# echo none > /sys/block/nullb0/queue/scheduler
# mkfs.xfs /dev/nullb0


Referring the call stack printed, I walked through the function calls. In
__blkdev_direct_IO_simple(), task state is set UNINTERRUPTIBLE. Way
down to might_sleep_if() called from null_queue_rq(), it is warned that
the task state is not RUNNING. This patch adds blk_mq_plug_issue_direct()
call in blk_mq_flush_plug_list(), then the call path was linked from
__blkdev_direct_IO_simple() to null_queue_rq().

__blkdev_direct_IO_simple() block/fops.c
  set_current_state(TASK_UNINTERRUPTIBLE) ... current->__state =3D TASK_UNI=
NTERRUPTIBLE
  blk_io_schedule()
    io_schedule_timeout() kernel/sched/core.c
      io_schedule_prepare()
        blk_schedule_flush_plug() include/linux/blkdev.h
          blk_flush_plug_list() block/blk-core.c
            blk_mq_flush_plug_list()
              blk_mq_flush_plug_list() block/blk-mq.c  ... this patch added=
 call to blk_mq_plug_issue_direct()
                blk_mq_plug_issue_direct()
                  blk_mq_reqeust_issue_directly()
                    __blk_mq_try_issue_directly()
                      __blk_mq_issue_directly()
                        q->mq_ops->queue_rq()
                          null_queue_rq() drivers/block/null_blk/main.c
                            might_sleep_if(flags & BLK_MQ_F_BLOCKING) inclu=
de/linux/kernel.h
                              might_sleep()
                                __might_sleep() kernel/sched/core.c ... cur=
rent->__state !=3D TASK_RUNNING  (WARN_ONCE)

So far, I can't think of a good solution for this warning. Any idea?


[1]

[60501.340746] null_blk: module loaded
[60519.303106] ------------[ cut here ]------------
[60519.308485] do not call blocking ops when !TASK_RUNNING; state=3D2 set a=
t [<000000005ba5e596>] __blkdev_direct_IO_simple+0x3f8/0x6f0
[60519.320943] WARNING: CPU: 2 PID: 8929 at kernel/sched/core.c:9486 __migh=
t_sleep+0x124/0x160
[60519.330001] Modules linked in: null_blk xfs dm_zoned xt_conntrack nf_nat=
_tftp nf_conntrack_tftp bridge stp llc nft_objref nf_conntrack_netbios_ns n=
f_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_re=
ject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_=
tables ebtable_nat ebtable_broute ip6table_nat ip6table_mangle ip6table_raw=
 ip6table_security iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag=
_ipv4 iptable_mangle iptable_raw iptable_security ip_set nfnetlink ebtable_=
filter rfkill ebtables target_core_user target_core_mod ip6table_filter ip6=
_tables iptable_filter sunrpc intel_rapl_msr intel_rapl_common x86_pkg_temp=
_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass iTCO_wdt intel_p=
mc_bxt iTCO_vendor_support rapl intel_cstate intel_uncore pcspkr joydev ipm=
i_ssif i2c_i801 lpc_ich i2c_smbus ses enclosure mei_me mei ioatdma wmi acpi=
_ipmi ipmi_si ipmi_devintf ipmi_msghandler acpi_pad acpi_power_meter zram i=
p_tables ast
[60519.330166]  drm_vram_helper drm_kms_helper cec drm_ttm_helper crct10dif=
_pclmul ttm crc32_pclmul crc32c_intel drm ghash_clmulni_intel igb mpt3sas n=
vme dca nvme_core i2c_algo_bit raid_class scsi_transport_sas fuse [last unl=
oaded: null_blk]
[60519.438458] CPU: 2 PID: 8929 Comm: mkfs.xfs Not tainted 5.15.0-rc6+ #11
[60519.445781] Hardware name: Supermicro Super Server/X10SRL-F, BIOS 2.0 12=
/17/2015
[60519.453893] RIP: 0010:__might_sleep+0x124/0x160
[60519.459139] Code: 48 8d bb 98 2c 00 00 48 89 fa 48 c1 ea 03 80 3c 02 00 =
75 31 48 8b 93 98 2c 00 00 44 89 f6 48 c7 c7 e0 f2 88 8a e8 04 eb f9 01 <0f=
> 0b e9 6d ff ff ff e8 60 d1 66 00 e9 1c ff ff ff e8 66 d1 66 00
[60519.478594] RSP: 0018:ffff8882707ef5a8 EFLAGS: 00010286
[60519.484533] RAX: 0000000000000000 RBX: ffff888125cbb280 RCX: 00000000000=
00000
[60519.492379] RDX: 0000000000000004 RSI: 0000000000000008 RDI: ffffed104e0=
fdeab
[60519.500216] RBP: ffffffffc16122c0 R08: 0000000000000001 R09: ffff8888114=
ad587
[60519.508052] R10: ffffed1102295ab0 R11: 0000000000000001 R12: 00000000000=
00618
[60519.515886] R13: 0000000000000000 R14: 0000000000000002 R15: ffff8881316=
0a000
[60519.523721] FS:  00007fd79959b400(0000) GS:ffff888811480000(0000) knlGS:=
0000000000000000
[60519.532509] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[60519.538963] CR2: 000055bf4e3dc000 CR3: 000000029e904005 CR4: 00000000001=
706e0
[60519.546803] Call Trace:
[60519.549976]  null_queue_rq+0x3ee/0x6b0 [null_blk]
[60519.555407]  __blk_mq_try_issue_directly+0x433/0x680
[60519.561085]  ? __submit_bio+0x63a/0x780
[60519.565636]  ? __blk_mq_get_driver_tag+0x9a0/0x9a0
[60519.571144]  blk_mq_flush_plug_list+0x5f6/0xc40
[60519.576387]  ? iov_iter_get_pages_alloc+0xf50/0xf50
[60519.581980]  ? find_held_lock+0x2c/0x110
[60519.586618]  ? blk_mq_insert_requests+0x440/0x440
[60519.592044]  ? __blkdev_direct_IO_simple+0x3f8/0x6f0
[60519.597719]  blk_flush_plug_list+0x28f/0x410
[60519.602710]  ? blk_start_plug_nr_ios+0x270/0x270
[60519.608039]  ? __blkdev_direct_IO_simple+0x3f8/0x6f0
[60519.613713]  io_schedule_timeout+0xcc/0x150
[60519.618621]  __blkdev_direct_IO_simple+0x475/0x6f0
[60519.624126]  ? blkdev_llseek+0xc0/0xc0
[60519.628598]  ? blkdev_get_block+0xd0/0xd0
[60519.633320]  ? filemap_check_errors+0xe0/0xe0
[60519.638391]  ? find_held_lock+0x2c/0x110
[60519.643024]  ? lock_release+0x1d4/0x690
[60519.647574]  blkdev_direct_IO+0x9b2/0x1110
[60519.652389]  ? filemap_check_errors+0x56/0xe0
[60519.657455]  ? add_watch_to_object+0xa0/0x6e0
[60519.662524]  ? blkdev_bio_end_io+0x490/0x490
[60519.667518]  generic_file_direct_write+0x1a9/0x4a0
[60519.673026]  __generic_file_write_iter+0x1fa/0x480
[60519.678526]  ? lock_is_held_type+0xe0/0x110
[60519.683420]  blkdev_write_iter+0x319/0x5a0
[60519.688231]  ? blkdev_open+0x260/0x260
[60519.692690]  ? lock_downgrade+0x6b0/0x6b0
[60519.697412]  ? do_raw_spin_unlock+0x55/0x1f0
[60519.702392]  new_sync_write+0x359/0x5e0
[60519.706941]  ? new_sync_read+0x5d0/0x5d0
[60519.711582]  ? __cond_resched+0x15/0x30
[60519.716124]  ? inode_security+0x56/0xf0
[60519.720688]  vfs_write+0x5e4/0x8e0
[60519.724805]  __x64_sys_pwrite64+0x17c/0x1d0
[60519.729698]  ? vfs_write+0x8e0/0x8e0
[60519.733982]  ? syscall_enter_from_user_mode+0x21/0x70
[60519.739747]  do_syscall_64+0x3b/0x90
[60519.744037]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[60519.749796] RIP: 0033:0x7fd7997c125a
[60519.754088] Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb ba 0f 1f 00 f3 0f =
1e fa 49 89 ca 64 8b 04 25 18 00 00 00 85 c0 75 15 b8 12 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 5e c3 0f 1f 44 00 00 48 83 ec 28 48 89 54 24
[60519.773543] RSP: 002b:00007ffe8d456718 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000012
[60519.781816] RAX: ffffffffffffffda RBX: 00007ffe8d456e10 RCX: 00007fd7997=
c125a
[60519.789656] RDX: 0000000000020000 RSI: 000055bf4e3bd600 RDI: 00000000000=
00004
[60519.797494] RBP: 0000000000020000 R08: 000055bf4e3bd600 R09: 00007fd7997=
5fa60
[60519.805333] R10: 00000003fffe0000 R11: 0000000000000246 R12: 000055bf4e3=
b9710
[60519.813172] R13: 0000000000000004 R14: 000055bf4e3bd600 R15: 00000000000=
01000
[60519.821028] irq event stamp: 20385
[60519.825139] hardirqs last  enabled at (20395): [<ffffffff883481e0>] __up=
_console_sem+0x60/0x70
[60519.834455] hardirqs last disabled at (20404): [<ffffffff883481c5>] __up=
_console_sem+0x45/0x70
[60519.843763] softirqs last  enabled at (20372): [<ffffffff881e6a7c>] __ir=
q_exit_rcu+0x19c/0x200
[60519.853079] softirqs last disabled at (20367): [<ffffffff881e6a7c>] __ir=
q_exit_rcu+0x19c/0x200
[60519.862389] ---[ end trace be9623465002e439 ]---

--=20
Best Regards,
Shin'ichiro Kawasaki

> ---
>  block/blk-core.c       |  1 +
>  block/blk-mq.c         | 60 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/blkdev.h |  1 +
>  3 files changed, 62 insertions(+)
>=20
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 14d20909f61a..e6ad5b51d0c3 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -1555,6 +1555,7 @@ void blk_start_plug_nr_ios(struct blk_plug *plug, u=
nsigned short nr_ios)
>  	plug->nr_ios =3D min_t(unsigned short, nr_ios, BLK_MAX_REQUEST_COUNT);
>  	plug->rq_count =3D 0;
>  	plug->multiple_queues =3D false;
> +	plug->has_elevator =3D false;
>  	plug->nowait =3D false;
>  	INIT_LIST_HEAD(&plug->cb_list);
> =20
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 620233b85af2..d0fe86b46d1b 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -2147,6 +2147,58 @@ void blk_mq_insert_requests(struct blk_mq_hw_ctx *=
hctx, struct blk_mq_ctx *ctx,
>  	spin_unlock(&ctx->lock);
>  }
> =20
> +static void blk_mq_commit_rqs(struct blk_mq_hw_ctx *hctx, int *queued,
> +			      bool from_schedule)
> +{
> +	if (hctx->queue->mq_ops->commit_rqs) {
> +		trace_block_unplug(hctx->queue, *queued, !from_schedule);
> +		hctx->queue->mq_ops->commit_rqs(hctx);
> +	}
> +	*queued =3D 0;
> +}
> +
> +static void blk_mq_plug_issue_direct(struct blk_plug *plug, bool from_sc=
hedule)
> +{
> +	struct blk_mq_hw_ctx *hctx =3D NULL;
> +	struct request *rq;
> +	int queued =3D 0;
> +	int errors =3D 0;
> +
> +	while ((rq =3D rq_list_pop(&plug->mq_list))) {
> +		bool last =3D rq_list_empty(plug->mq_list);
> +		blk_status_t ret;
> +
> +		if (hctx !=3D rq->mq_hctx) {
> +			if (hctx)
> +				blk_mq_commit_rqs(hctx, &queued, from_schedule);
> +			hctx =3D rq->mq_hctx;
> +		}
> +
> +		ret =3D blk_mq_request_issue_directly(rq, last);
> +		switch (ret) {
> +		case BLK_STS_OK:
> +			queued++;
> +			break;
> +		case BLK_STS_RESOURCE:
> +		case BLK_STS_DEV_RESOURCE:
> +			blk_mq_request_bypass_insert(rq, false, last);
> +			blk_mq_commit_rqs(hctx, &queued, from_schedule);
> +			return;
> +		default:
> +			blk_mq_end_request(rq, ret);
> +			errors++;
> +			break;
> +		}
> +	}
> +
> +	/*
> +	 * If we didn't flush the entire list, we could have told the driver
> +	 * there was more coming, but that turned out to be a lie.
> +	 */
> +	if (errors)
> +		blk_mq_commit_rqs(hctx, &queued, from_schedule);
> +}
> +
>  void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
>  {
>  	struct blk_mq_hw_ctx *this_hctx;
> @@ -2158,6 +2210,12 @@ void blk_mq_flush_plug_list(struct blk_plug *plug,=
 bool from_schedule)
>  		return;
>  	plug->rq_count =3D 0;
> =20
> +	if (!plug->multiple_queues && !plug->has_elevator) {
> +		blk_mq_plug_issue_direct(plug, from_schedule);
> +		if (rq_list_empty(plug->mq_list))
> +			return;
> +	}
> +
>  	this_hctx =3D NULL;
>  	this_ctx =3D NULL;
>  	depth =3D 0;
> @@ -2374,6 +2432,8 @@ static void blk_add_rq_to_plug(struct blk_plug *plu=
g, struct request *rq)
>  		if (nxt && nxt->q !=3D rq->q)
>  			plug->multiple_queues =3D true;
>  	}
> +	if (!plug->has_elevator && (rq->rq_flags & RQF_ELV))
> +		plug->has_elevator =3D true;
>  	rq->rq_next =3D NULL;
>  	rq_list_add(&plug->mq_list, rq);
>  	plug->rq_count++;
> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
> index 80668e316eea..2e93682f8f68 100644
> --- a/include/linux/blkdev.h
> +++ b/include/linux/blkdev.h
> @@ -720,6 +720,7 @@ struct blk_plug {
>  	unsigned short rq_count;
> =20
>  	bool multiple_queues;
> +	bool has_elevator;
>  	bool nowait;
> =20
>  	struct list_head cb_list; /* md requires an unplug callback */
> --=20
> 2.33.1
> =
