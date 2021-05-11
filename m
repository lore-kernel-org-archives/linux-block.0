Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19FFAC433B4
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 05:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA69061278
	for <linux-block@archiver.kernel.org>; Tue, 11 May 2021 05:05:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhEKFHB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 May 2021 01:07:01 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:31913 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbhEKFHB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 May 2021 01:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1620709554; x=1652245554;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zValreXr8qZBkvz/+/WjgoZFm1YoDclPvmla5otPJzs=;
  b=DjfRq2RHnFA08efaWoB5vquMXlBmQDA5FzB4evexMu2PFJ72B8A4AO/d
   7PosVv4WzftGiqT5GuqcHSOBcfRIQybzyAFSG9EEO9M55rjp+I1kD6MOf
   ncMkMO6jLHZBgMvnn06jxB2/OoEP9kt3ZSEjyjaGNNdUWm9XkjLbNr7B/
   rWN6jGDoF3Gy6298I63kzaTBkcjdgy/v0Y9l6k1RrHglYIIl3IIXJlki6
   na3wescjFMthlVD7VBmsJIohHZatfzlwy/TxkP6Z+/Gl1Ogf8ePIej17h
   mA7U0U7CZRI0RkcaSt4uiDNK6Jctv9t/39bHG1kRpyhwLqLm1VhItY1Iu
   A==;
IronPort-SDR: G6+WhNCUNhiAAmiXGpOp/lYagyGg9kjBppE8svbGzBcaWE8AaAD9GWETT8JOaZsG2W+YU7dJVZ
 Zi9JLlmucVAeqQjqhxWtcCDwujOghf/l2rnBAsjsQlQC0xo88hjz+pjX/3ej6G1twogmPeCk/8
 egaHPaBJJ4stAKdrJ9cTG2IY/gICC+UT9373Q2A7X6Tl5cUkzJXy4/YSy84cOYYUA5FTAsQjcQ
 ARByCBIVwYLmSy67aFBn3esKrb+BTXocecwmbvF71KCupf8hXgfCSdPfD+E4csL86zUQO95Kei
 FrQ=
X-IronPort-AV: E=Sophos;i="5.82,290,1613404800"; 
   d="scan'208";a="172275889"
Received: from mail-dm6nam12lp2174.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.174])
  by ob1.hgst.iphmx.com with ESMTP; 11 May 2021 13:05:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SrtooDmrTeRpaFq0gjt1IbhtaK45XfivMQxekXkeP8bJZMmdIV4B5CXFYbvKWvDB5pQQ7OKJ4JTAKxT87ZLX2aWB6XYyOC0CmQVYNPyJwklzhhlv1ZnnNY5RKwM20Fs9lfgX5KHTPvoRQlS1PdjqOAE1TkZHstAUtx6Y7JPZFEK1jphBuG7yysCCqzPLk5EngvQTS/x+Z2B/IrSKg62qldgqJLMruNGptR893YeezYYPC0MDsj3hwDi0K4o73Oo3a6MkFTboKMrpLl5Hcr0Rpjmij3t4Rkct+AbcPh3sX3GaWIgyY0CB7z3KzIVM8yjUSRhjd/GFM16vGpMD4SwJqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUzw0rsTrXGoiEWhGeACKurhKexvLz12tqH+Y5T5n18=;
 b=c0QD63GbYyz32GWLgtzk2WnXy25Voa4uNv/Ux2JOfiJSLs2tjMu4SP9t0Lgs2xIPHu7NvXpafL7V7vU/UCYYixymytbmuaNgPTisjZSI82BnhbXo+A6BqaH0Q7LKHKb83q8+b2yaePd4RQef8QuL6lIjxFYGoI+XiTdWOpx6GeO6FZ/4EEIBtsElFte33K9RSW9avWRn97pO0YxST/szVD9KvJ6mo8vRF4CF5egHu5gwjFoh8RDEHPPwVO+lgjBL4VJ6dxyfgYkqG8FgOnR6tujzpDf1z9h2uMcvL/8W9MY7eCUL9EYMIw4S0Gq3keIZACL0GV4g60T1je+Swf/6ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XUzw0rsTrXGoiEWhGeACKurhKexvLz12tqH+Y5T5n18=;
 b=um0qzysWBCrkh04vXhzYD789VPs4p77Qvn2W9eu4qd+zLHIcL6kff0Y8CTTX6O4S7qeZtJXBIBMrfgt1IWlPuIifFp0Qpa4y1PzDr7qVd/zEZmbDIffXMN3PteFzqOvC649Ifs/HMQaf1n5kab14vOjfJJRBKkXe5NEwkjDgvzg=
Received: from BYAPR04MB3800.namprd04.prod.outlook.com (2603:10b6:a02:ad::20)
 by BYAPR04MB5879.namprd04.prod.outlook.com (2603:10b6:a03:112::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Tue, 11 May
 2021 05:05:52 +0000
Received: from BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::6052:9dde:2486:109e]) by BYAPR04MB3800.namprd04.prod.outlook.com
 ([fe80::6052:9dde:2486:109e%5]) with mapi id 15.20.4108.031; Tue, 11 May 2021
 05:05:52 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        John Garry <john.garry@huawei.com>,
        Christoph Hellwig <hch@lst.de>,
        David Jeffery <djeffery@redhat.com>
Subject: Re: [PATCH V6 0/4] blk-mq: fix request UAF related with iterating
 over tagset requests
Thread-Topic: [PATCH V6 0/4] blk-mq: fix request UAF related with iterating
 over tagset requests
Thread-Index: AQHXQ083BdicgrD1B0CPNWzyxvFGxKrdwAGA
Date:   Tue, 11 May 2021 05:05:52 +0000
Message-ID: <20210511050551.3m62ut7nfz2gvqgh@shindev.dhcp.fujisawa.hgst.com>
References: <20210507144208.459139-1-ming.lei@redhat.com>
In-Reply-To: <20210507144208.459139-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 350273bd-c68a-44dd-ce04-08d9143a7351
x-ms-traffictypediagnostic: BYAPR04MB5879:
x-microsoft-antispam-prvs: <BYAPR04MB58799281C08022CF2B74FEC1ED539@BYAPR04MB5879.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SgrVz1dcDpd5DLcnLikDY4SSwnoFxO6+bGXJm4hkXpNlCIUFen5q9e6TC772TtWCqTfN8wbRmk3GapCZN+Q2YIQQyPR6FwBv8HwQTCHujlrvtaZrYjWyOs9IbnK59z9CjcpaDCAjdwxxPDUz9ogE8/eNV4tjbCl0M8jFJuZbsHwpS0v0J8y5xBxi/dbxy7JdF0+x45TDDotYTt959faSHk77IN9H6GOE0tTWqKnlrAhik40bwi9Z5vYuMMepPjbBpWnoxN/X6yIuHmA6JZBCpcdo5yBSCeBymiT8QwqMGSY5n27lH36jNkfYgMbbigfLuQOQ3e6vFJvoyqj4gxtnOY0eOFMiJdo9vpJxENXEYhMw6bdsc0gaKTPACsH3K6kkJT4Bal0BEfw/X1GbAaLM9UJiItE4XS1ee1rUJSihPsG8W///jKtggS0ztQbLMF9NiYuPnUieexaGD+10pZc0TM/qxPxPo82NYEPK2Dos9GVGL/ykCZ+nXuZJmpiuAQMuZxbI+Cug4M4luW7Z8XQ0HzU8SCk4QNU7LqkpxGhXsHtD8k/udxsPsTJAIGnx8nAQuwEDGjRpdMmlTzhm3H3Rz9YQU1d1wIQ9eizXz6QgS98=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB3800.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(376002)(39860400002)(396003)(66556008)(71200400001)(66476007)(66446008)(6506007)(83380400001)(6916009)(8936002)(44832011)(186003)(2906002)(38100700002)(5660300002)(122000001)(86362001)(6486002)(45080400002)(1076003)(26005)(66946007)(6512007)(91956017)(76116006)(54906003)(316002)(478600001)(4326008)(8676002)(9686003)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?v7jaMOsGLDpb9pD5l1nNVMsnNxqmj5puWLKTu5iAgF0+0crFJN+VBCB4ufOv?=
 =?us-ascii?Q?do/FGvfmPNLn26y0vFb8pxILDaNYJo6KU6wG7idv9O4jR0czPT4N62pFla9z?=
 =?us-ascii?Q?4QiiJJ/32jga6TF+CPOey/TRsqLYAxmIkZ/Dgs+OOyBRCdiUEpLizoFisFNm?=
 =?us-ascii?Q?ymJn1qOFAtAK6dde2DwFjL0uxPDwKsiSv9Ig+3C71P7kYSjGm6AvqFgY/g6R?=
 =?us-ascii?Q?cWc0dHBST1UhbPzl6ozriV0qNB7KQ0MRXS3lcecSlE35Lq9gSmmt4HXfkXLO?=
 =?us-ascii?Q?dADybOsoWCTgOzjzHSPiksOowcQ3VeKnihmUiwfHZT8CEUGa3vGmBbu6fC2I?=
 =?us-ascii?Q?9enBdqTs7vXApVGebOW74Jn9I6CVjQSj/1evE06BqVuhZtwaBA6mPBVSI4dX?=
 =?us-ascii?Q?RdoMb0YXva4bUBWKQVvGZCnuAVBpjEFeMXHAyAXDFQxgOLvvtkF+C0N0FJdm?=
 =?us-ascii?Q?DZg4NFZY+CHwjEqDx6sMD86ka/AgX7VAeD+1PXQYHyd4zAjx1zYhjSM/M8zg?=
 =?us-ascii?Q?GMXxR9KEb2VEGtk/U/Udcv/NUUYIStLjgjmNf72U6jIUu67ab9zVlGTkNXJ0?=
 =?us-ascii?Q?yawIEM3VO7hlxWNwdSDrQ0pDx9SiysooHxeki1ccbXx3wSzU2KnCfvTqXP75?=
 =?us-ascii?Q?o1yQ6kioIe5CKyqhA1Ihh1HYGy6Wrt8xVeKU3h7edP8CzFB1DdeirHRq+jZN?=
 =?us-ascii?Q?ffPRpDzTAOrAM7JlJ4tMJbLBfuP3wQNuSLuG5JZLCko/HRzEqoYJKNpcKW+K?=
 =?us-ascii?Q?DDISaMHrOPRsIENMnNitqrgIlnXlLxrhUNx9t1HjtZ/+jZ3DWACzqZ2vh0K0?=
 =?us-ascii?Q?JUIlfsXKTD0ajN2r9T1A11kfP+mOfnVl5buXmiAf7jFMh0ZzmbvJDN4a9YIU?=
 =?us-ascii?Q?HIJu5eVqYHEWCgdkU0j3WLaVrpAvOFsIbSTw65wlHixkw3nbEtj8VNlDXZ6A?=
 =?us-ascii?Q?tjju/ftSMV6thRgsS2bmsHPP9FjCGsBcti7GGXuRina0Qm9dWeSpJq7eStNR?=
 =?us-ascii?Q?s0j9NTYNSnQlJwntBflGFSrsLKnqOsHh3cMoriZJkZk+KpFKIwrGpO9pKEEp?=
 =?us-ascii?Q?aKrr5CJJ00LNniIzfTtz2r1aKfadpG4Gl6qG7SegERVJdOMQM6mxsj4NLZrP?=
 =?us-ascii?Q?Q84AQqhvbP8DikkoGUhH+B2WgVV4OugaMeb8sCCY1746unNBqNBhJRIiw1+I?=
 =?us-ascii?Q?x0wRcGN025mabPUfijSHabDOLAMvkloZkBH67aWAgOLiTGLmUwO05mWS0b8v?=
 =?us-ascii?Q?O2OMTCIep6eCJqrujHHmsUIDHIzvaWpcMB7duTVKwnScvs0wM4861IWxDKNb?=
 =?us-ascii?Q?aDw3rwY3KcycRE994jLzLqJmMShtJcU0N6jnheiuBrExKg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E5AA09545BC5A244AA6E91C7E969862C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB3800.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 350273bd-c68a-44dd-ce04-08d9143a7351
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2021 05:05:52.3776
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DPXHXwH3Fxejx0TIfAEcYWexZt/yOOIlcyg9NYVimXMCPNSYunAIFXDPcC4Yt36iA0nQTWzfQ1jdMvhFBWBFbEp3XLTOQ5sQUv9IAObiv6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5879
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On May 07, 2021 / 22:42, Ming Lei wrote:
> Hi Jens,
>=20
> This patchset fixes the request UAF issue by one simple approach,
> without clearing ->rqs[] in fast path, please consider it for 5.13.
>=20
> 1) grab request's ref before calling ->fn in blk_mq_tagset_busy_iter,
> and release it after calling ->fn, so ->fn won't be called for one
> request if its queue is frozen, done in 2st patch
>=20
> 2) clearing any stale request referred in ->rqs[] before freeing the
> request pool, one per-tags spinlock is added for protecting
> grabbing request ref vs. clearing ->rqs[tag], so UAF by refcount_inc_not_=
zero
> in bt_tags_iter() is avoided, done in 3rd patch.

Ming, thank you for your effort to fix the UAF issue. I applied the V6 seri=
es to
the kernel v5.13-rc1, and confirmed that the series avoids the UAF I had be=
en
observing with blktests block/005 and HDD behind HBA. This is good. However=
, I
found that the series triggered block/029 hang. Let me share the kernel mes=
sage
below, which was printed at the hang. KASAN reported null-ptr-deref.

[ 2124.489023] run blktests block/029 at 2021-05-11 13:42:22
[ 2124.561386] null_blk: module loaded
[ 2125.201166] general protection fault, probably for non-canonical address=
 0xdffffc0000000012: 0000 [#1] SMP KASAN PTI
[ 2125.212387] KASAN: null-ptr-deref in range [0x0000000000000090-0x0000000=
000000097]
[ 2125.220656] CPU: 2 PID: 26514 Comm: check Not tainted 5.13.0-rc1+ #3
[ 2125.227710] Hardware name: Supermicro Super Server/X10SRL-F, BIOS 2.0 12=
/17/2015
[ 2125.235793] RIP: 0010:blk_mq_exit_hctx+0x21b/0x580
[ 2125.241298] Code: 00 00 00 31 db 48 89 44 24 20 85 d2 74 54 49 89 c5 48 =
b8 00 00 00 00 00 fc ff df 49 c1 ed 03 4c 01 e8 48 89 04 24 48 8b 04 24 <80=
> 38 00 0f 85 8a 02 00 00 49 8b 87 90 00 00 00 48 63 d3 be 08 00
[ 2125.260747] RSP: 0018:ffff888110677c08 EFLAGS: 00010286
[ 2125.266674] RAX: dffffc0000000012 RBX: 0000000000000000 RCX: ffffffffa4f=
3710f
[ 2125.274500] RDX: 0000000000000040 RSI: 0000000000000004 RDI: ffff88811f8=
0c4e8
[ 2125.282326] RBP: ffff8881483c0000 R08: 0000000000000000 R09: ffff88811f8=
0c4eb
[ 2125.290153] R10: ffffed1023f0189d R11: 0000000000000001 R12: ffff88811f8=
0c400
[ 2125.297978] R13: 0000000000000012 R14: ffff88810c506038 R15: 00000000000=
00000
[ 2125.305807] FS:  00007f6dc4d4a740(0000) GS:ffff8883e1480000(0000) knlGS:=
0000000000000000
[ 2125.314592] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2125.321032] CR2: 00005566b34e55f0 CR3: 000000012c33e005 CR4: 00000000001=
706e0
[ 2125.328860] Call Trace:
[ 2125.332013]  blk_mq_realloc_hw_ctxs+0x71a/0x15f0
[ 2125.337338]  ? blk_mq_map_queues+0x20c/0x650
[ 2125.342317]  blk_mq_update_nr_hw_queues+0x4cc/0xb70
[ 2125.347905]  ? blk_mq_init_queue+0xb0/0xb0
[ 2125.352709]  nullb_device_submit_queues_store+0x10f/0x1f0 [null_blk]
[ 2125.359781]  ? __null_lookup_page.isra.0+0xd0/0xd0 [null_blk]
[ 2125.366243]  ? __null_lookup_page.isra.0+0xd0/0xd0 [null_blk]
[ 2125.372697]  configfs_write_file+0x2bb/0x450
[ 2125.377676]  vfs_write+0x1cb/0x840
[ 2125.381783]  ksys_write+0xe9/0x1b0
[ 2125.385890]  ? __ia32_sys_read+0xb0/0xb0
[ 2125.390517]  ? syscall_enter_from_user_mode+0x27/0x80
[ 2125.396276]  do_syscall_64+0x40/0x80
[ 2125.400553]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 2125.406308] RIP: 0033:0x7f6dc4e3f4e7
[ 2125.410590] Code: 0d 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f =
00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[ 2125.430036] RSP: 002b:00007ffc7ee29928 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000001
[ 2125.438306] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f6dc4e=
3f4e7
[ 2125.446132] RDX: 0000000000000002 RSI: 00005566b34e55f0 RDI: 00000000000=
00001
[ 2125.453957] RBP: 00005566b34e55f0 R08: 000000000000000a R09: 00007f6dc4e=
d60c0
[ 2125.461783] R10: 00007f6dc4ed5fc0 R11: 0000000000000246 R12: 00000000000=
00002
[ 2125.469610] R13: 00007f6dc4f12520 R14: 0000000000000002 R15: 00007f6dc4f=
12720
[ 2125.477446] Modules linked in: null_blk xt_CHECKSUM xt_MASQUERADE xt_con=
ntrack ipt_REJECT nf_nat_tftp nf_conntrack_tftp tun nft_objref nf_conntrack=
_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 n=
ft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_=
chain_nat nf_tables ebtable_nat ebtable_broute ip6table_nat ip6table_mangle=
 ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack nf_defrag_i=
pv6 nf_defrag_ipv4 iptable_mangle iptable_raw iptable_security bridge stp l=
lc ip_set rfkill nfnetlink target_core_user ebtable_filter ebtables target_=
core_mod ip6table_filter ip6_tables iptable_filter sunrpc intel_rapl_msr in=
tel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel iT=
CO_wdt intel_pmc_bxt iTCO_vendor_support kvm irqbypass rapl intel_cstate in=
tel_uncore joydev i2c_i801 pcspkr i2c_smbus ses enclosure lpc_ich mei_me me=
i ioatdma wmi ipmi_ssif acpi_ipmi ipmi_si ipmi_devintf ipmi_msghandler acpi=
_power_meter
[ 2125.477718]  acpi_pad zram ip_tables drm_vram_helper drm_kms_helper cec =
drm_ttm_helper ttm crct10dif_pclmul crc32_pclmul crc32c_intel drm ghash_clm=
ulni_intel igb mpt3sas nvme nvme_core dca i2c_algo_bit raid_class scsi_tran=
sport_sas fuse [last unloaded: null_blk]
[ 2125.588156] ---[ end trace 94b8e87c4a29c520 ]---
[ 2125.615124] RIP: 0010:blk_mq_exit_hctx+0x21b/0x580
[ 2125.620628] Code: 00 00 00 31 db 48 89 44 24 20 85 d2 74 54 49 89 c5 48 =
b8 00 00 00 00 00 fc ff df 49 c1 ed 03 4c 01 e8 48 89 04 24 48 8b 04 24 <80=
> 38 00 0f 85 8a 02 00 00 49 8b 87 90 00 00 00 48 63 d3 be 08 00
[ 2125.640077] RSP: 0018:ffff888110677c08 EFLAGS: 00010286
[ 2125.646007] RAX: dffffc0000000012 RBX: 0000000000000000 RCX: ffffffffa4f=
3710f
[ 2125.653844] RDX: 0000000000000040 RSI: 0000000000000004 RDI: ffff88811f8=
0c4e8
[ 2125.661675] RBP: ffff8881483c0000 R08: 0000000000000000 R09: ffff88811f8=
0c4eb
[ 2125.669502] R10: ffffed1023f0189d R11: 0000000000000001 R12: ffff88811f8=
0c400
[ 2125.677327] R13: 0000000000000012 R14: ffff88810c506038 R15: 00000000000=
00000
[ 2125.685158] FS:  00007f6dc4d4a740(0000) GS:ffff8883e1480000(0000) knlGS:=
0000000000000000
[ 2125.693941] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2125.700382] CR2: 00005566b34e55f0 CR3: 000000012c33e005 CR4: 00000000001=
706e0

--=20
Best Regards,
Shin'ichiro Kawasaki=
