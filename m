Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B177C433F5
	for <linux-block@archiver.kernel.org>; Fri,  3 Dec 2021 10:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379747AbhLCKFC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 3 Dec 2021 05:05:02 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:60904 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379728AbhLCKFB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 3 Dec 2021 05:05:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638525697; x=1670061697;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7tXeyBKTj5HTs3lsSQQ/MsNGObJfEi2j54rQUdLi4rI=;
  b=c70lYOw7KK/L73KPGiQbpNmRNH2UZLUPAV1Mi79gSP7f1OP2FzpSm8xR
   fLBSS+6xbT6BwsHFK7j2a4KCM54CHdvyzySqOp49K4Zlsuknd1FeiAMvx
   OjYpoK82YTXheVlu9JCvtizaTQj+oXZwzTMFa64TVHcIZB6zAmZLzqe4n
   Y2GxhmvnQdTdNSW8kiC3+39sxatXqCFNUabwk3lJ/WqPt+ADup7yFRdnG
   u7FvE8KqfdIg5a+F8EgOwwiyqbjM8Nr0TpIrTo+YigLQOeuS9Sbl+qhmy
   Zf3FaimqcsyVQ/PvOqKLbYxztkVqszlWWCW03inZ3w5iztj3KaV52SdNl
   g==;
X-IronPort-AV: E=Sophos;i="5.87,284,1631548800"; 
   d="scan'208";a="188386936"
Received: from mail-bn8nam12lp2170.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.170])
  by ob1.hgst.iphmx.com with ESMTP; 03 Dec 2021 18:01:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkcqrbFAccR1hz22kn5VLEF8wb4JjhxDNClDYvc8EYA2kdzz1JlpLfj7rzOGxGhoQr4m5WKb8dHLdrvHkxa6M/MmDdDYEe+mp2soKVdxdp49NB9uMSoIkga+Pq12eOqdp8vnC4g+644nwaTcONco905jgq+foDzwgE3Sh0R2NkN2lJUSZQ1PLhjcp473FauDxD2xAK6fEnrq/n/bZE/tCosnwV2cenfZBVN8uLUw+V5okinEblZPC6wZFw/I9xN/PGEyWo3YcDW6wKbZjnXUoZf1jCeq6aSNhtDOXbJeao1lHwIIQJIjut+9ZnhYxVF70AYkYDn35KK3/8QZA3c0FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ouMU4w8uLNUXZ4Kx4Tn4e63xJMkWmzW4E/cfl/8cG2E=;
 b=TEpLSwwgYIkxSPrN4prupe8fZCjRWpmIwYIXP0gmdXbzUKS3kudv3DkaxtmDdDQ+uf+MgTrU3HEicKUbpEpIqd5H775hh7I63aektd2ZybZrZHU1DAD6Y+ZWCbX+mZ2d+EGt+lfr8EanGwvw4+X2EOYBD5Ob1SuiwVoQDuCmHFq+9+DvdbUf5Cd+VXRoPGbzOK2CGl26wrlQ27vT/YTkibVZ+l6PA+nCkdTiNij0wte8jUI87XcxtOPc7XmZFGX5VeU2B5Y7HuG/EU5Y4unlU1dhiVaeLPPhDkdADmmf83U/N5PIpXDxy0QqkmZIVH7b8uVhN0H6MbLgGJL4Tigf4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ouMU4w8uLNUXZ4Kx4Tn4e63xJMkWmzW4E/cfl/8cG2E=;
 b=AjwnQwR/KhBCVVQMNEHuAVSlUyqI/jYFLDY9R3qesiDNKnNXRgBqH8yfyl3l/1ewOsErzImtuHD9lnOiPLUvHIMUildLFsPr83pOa9/DOJMPkI9LisTuKzzrtBIvRiAWu9UOpzN05qJ+I35D9VlHcqXXM8vJQyKtrTFMWI/Xrco=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM8PR04MB8008.namprd04.prod.outlook.com (2603:10b6:8:7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.22; Fri, 3 Dec 2021 10:01:33 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::28ae:301e:551e:a62e]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::28ae:301e:551e:a62e%5]) with mapi id 15.20.4734.028; Fri, 3 Dec 2021
 10:01:33 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] null_blk: allow zero poll queues
Thread-Topic: [PATCH] null_blk: allow zero poll queues
Thread-Index: AQHX5+8R3HrF+EUnsUq/7/xCqs+zYqwgiaKA
Date:   Fri, 3 Dec 2021 10:01:33 +0000
Message-ID: <20211203100133.gdut65jrb6z6eodr@shindev>
References: <20211203023935.3424042-1-ming.lei@redhat.com>
In-Reply-To: <20211203023935.3424042-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e450d907-325f-47d0-9316-08d9b643e31f
x-ms-traffictypediagnostic: DM8PR04MB8008:
x-microsoft-antispam-prvs: <DM8PR04MB80089F54365F982F420B862CED6A9@DM8PR04MB8008.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NwoNdIW9WKH7+869PlJSUEi5rRJpagbZdLOS+GmDl+h8k4LIZVE9++hficXp5PMoBi/+B0DO4QMwHnPD95eQU5psb8evO1Fw7ikNu1ClmWn4wO3/L1jsocrKQU6BfIs7Uy+JVnwi+G+lWexSAzt6lvyF1tM04dsELC3Loq7XxJsTVvvnl+v/Wn+j33yoN1dAKCBgkGS5HX4OlbWt78mpF/9+ahSkakJ0/+o9v5ZVhlj014DnALs2QCg0LLiux5AIQ9FS6ooD3jUXErh0wJhN/Shy4NqwyjCktNaV+INfFh59a9wBeVogjem053A6bDBm1nuC3SrERR9Ze8LmxBTnjYVCtyfluEn0PYYb5uX9pH++wRBGJRGwgf3l3F59oHR8mhlZ+KdxWbzMCEG1ZZpBgkkzLmQIR4kMLCFjgsKzvwVOorfTOtK0vH6zGdCqSDIVVPid5jqMp1AzMedzXQlh9rqfBl/2ohxmnicsgnem69CtPW1VFDLof6nNb9xMY/fr5QhErwDtO7YLFAxLn9B+Tdeb+swr0SwON4b4GpIeK0zoZFljSmnVaxruwQMUHtkpT1KY6v4b9Mz/chlBh4pof++j3iNcV7mxEOpQQUcJ9GLv78HRlSd3dblTYsUSklUPbhWEQ+itqmuki4tF4wkoi7fQQvqzH7fUhW8fzGIOEjP3C++QRL04BAQS79gzl3Md2B74+bj8YHuKxWTx3MT6qw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(4326008)(26005)(186003)(76116006)(8936002)(2906002)(54906003)(38070700005)(44832011)(316002)(1076003)(33716001)(9686003)(6512007)(82960400001)(6506007)(6916009)(66476007)(64756008)(66556008)(66446008)(86362001)(8676002)(66946007)(508600001)(6486002)(71200400001)(83380400001)(122000001)(91956017)(38100700002)(5660300002)(45080400002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2W0OOdSa1z7RAMMf5mWsYF+E5L2E2WjEkKQXTXFvFygDMiCmrB48JrU2xZEL?=
 =?us-ascii?Q?Ioh1RqlcLzjFgwLLNS5nCwAyvWlS+QhlTunWYuMCbWfiJyb4m6PwqMfoiHX4?=
 =?us-ascii?Q?+AW5KN4WG9nChzvj9SGfxMPoLc9i+nWV/eV4Q+rfaMj3PvkG/cRGUjA2USqw?=
 =?us-ascii?Q?L/+58ylGNCA1uTFzCWQTKaZyXjueRJQGR1acipAR4z9MUnyOH5+YbDJT/ecI?=
 =?us-ascii?Q?XFnhOHaRDE9LGMcI0LgLSot+MJ7H+Xf/6sUNIJpsHPiWL58jsgudVNfbsv4g?=
 =?us-ascii?Q?qXGiW0074iM2VLf3OmlomVhHxVx2rm+x4787t5nmzIMvUC5AFgAXoyR++HR9?=
 =?us-ascii?Q?kmWt8/LvTwGn3no/zDUONnaQyUjJlXOveWziQOD5BZFm2uJAF/1m6ZticI8c?=
 =?us-ascii?Q?ox6MelTpVEUQ2qtBUyVrHj4S01uEaRrEtVSuq7hFPi0mRpj2aNuWUbAyfvfe?=
 =?us-ascii?Q?XvUFdRNyuzh6IqgJhAQ/8hVuc4nmt7/nVoVhUeE8LPMo68JFCnc5v6kaotTG?=
 =?us-ascii?Q?iMmlSu+ySIAKKT5OX5lxTDBiEuhxq0sBjvsMwXFx3Ekrje6RH6Ebwvt+ig9V?=
 =?us-ascii?Q?1GP5cuUZm6G4vyG8oITHASIw7spRS9C0c2LMD2Z/IaZF63J3oRLYD7PyMuvi?=
 =?us-ascii?Q?Aar61q1TjbAAy6mIWV45TTXO6l6TpiKIukq+M2uhB94QfsQneWxl/GmVy23m?=
 =?us-ascii?Q?J4CHZRHMIaXVtSd5BvV4Xneo2jbomBrDjuVLrfG5iar4Y/FAHFBNRBpT0SHo?=
 =?us-ascii?Q?dUxZl9TSsE54h5kcYrLUln/3a41j2mWDOwS4Wv/lDFSHKmMn6LUzDv9UDeKu?=
 =?us-ascii?Q?P/QAhE9lbMdScrGVs4UKnBVVb2hDU9AkVdLV9h88HjcrrTEN7uMKMMMEc76g?=
 =?us-ascii?Q?gcOKZEm27otxT5R3NEsCNoYBS6R6ZJFteRqh5AlwAfcPByz/eUMYFTA5/Cyh?=
 =?us-ascii?Q?JRx6/zQf+YG7ay+4GQr4RFTy/AfC1fGcuF0vXdinIrsuu0t00ugiTvlo5IWr?=
 =?us-ascii?Q?OXbtpQQcjbhuMjnkMbNTcNTIu/bhsdXUNbdj/D8PZ8XmqOsPoQUU+ywwiGro?=
 =?us-ascii?Q?cp5c11uYPqPO30f/0cHcQRJ6pt1k0qpSzvAOeQDzkSoVPbgNOZGSo04tSdhG?=
 =?us-ascii?Q?2/wVGV2b9H7uMJcgqNIJrFQGQvKPEsl9Pdbj28nT3Dkvji+NJwQ4spX7PXJW?=
 =?us-ascii?Q?8dXiZAnAu85liIIyxOlNgss4LesnVIP+gONwB9TIBvKfIh8TX/Sh/zIEbXSm?=
 =?us-ascii?Q?glF5+nJQ6fnfMLVPmpVRJdTnzawDZQFL70X8qik2NlXiH4Ujn7X0KlbnRpfq?=
 =?us-ascii?Q?VJmaBEowymoUUZsfcfDi1eQG0Ae30sPy5aSO0tMjqw7PWpJY6M577XK4KLOO?=
 =?us-ascii?Q?/CALetTr+uLRBiGtOwgzOwwSbGEqxwk/lRktU5xR1aUqPHQlyY+myam7XPOp?=
 =?us-ascii?Q?TS3/QOEflJdDPeCitxlDGdnhOLR8JlhYedEtN3kJ7UctDu0aq8Is23rn6ddn?=
 =?us-ascii?Q?dJ34TSUztO9rhYrQSW70XNYh5p09s3OBOuuOS8bN3ngsm/U2c74m0uewxWrF?=
 =?us-ascii?Q?fRTAdaYfx1UIWPSdP2J9YvagLSEaX/XK3P7BASe4wKoJTNXDzgaadyOvz4kT?=
 =?us-ascii?Q?8YYw0ORZAt8PJAOH8xIlnrHeqXMQaO7JGEAUTifFEXqTkiUTQ8tptuKHEOb1?=
 =?us-ascii?Q?9fvIu+Rw916pVvnS346B1MVCw4U=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C7BC5C7812510644BD54E9B6493DF0F3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e450d907-325f-47d0-9316-08d9b643e31f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Dec 2021 10:01:33.8370
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NbyTuyKYm9h2kYR0LkgeEULAHUw7zjf2IF04EJekuhCJ8VCswXkY+Z7SgCANXPQ2akfJmmQLzc0VuxUEU0QEhhm1+W0VzqgV7GzsWFteixI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8008
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Dec 03, 2021 / 10:39, Ming Lei wrote:
> There isn't any reason to not allow zero poll queues from user
> viewpoint.
>=20
> Also sometimes we need to compare io poll between poll mode and irq
> mode, so not allowing poll queues is bad.
>=20
> Fixes: 15dfc662ef31 ("null_blk: Fix handling of submit_queues and poll_qu=
eues attributes")
> Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Hi Ming,

It is good to know that the zero poll queues is useful. Having said that, I
observe zero division error [1] with your patch and the commands below. Don=
' we
need some more code changes to avoid the error?

# modprobe null_blk
# cd /sys/kernel/config/nullb
# mkdir test
# echo 0 > test/poll_queues
# echo 1 > test/power
Segmentation fault

[1]

[   78.497149] divide error: 0000 [#1] PREEMPT SMP KASAN PTI
[   78.503281] CPU: 7 PID: 1273 Comm: bash Not tainted 5.16.0-rc3+ #2
[   78.510178] Hardware name: Supermicro X10SLL-F/X10SLL-F, BIOS 3.0 04/24/=
2015
[   78.517926] RIP: 0010:blk_mq_map_queues+0x35e/0x650
[   78.523531] Code: 72 6b 48 8b 44 24 10 41 8d 77 01 0f b6 08 48 8b 44 24 =
08 83 e0 07 83 c0 03 38 c8 7c 08 84 c9 0f 85 c9 02 00 00 44 89 f8 31 d2 <f7=
> f3 48 8b 04 24 03 50 0c 4c 89 c8 48 c1 e8 03 42 0f b6 0c 30 4c
[   78.542990] RSP: 0018:ffff88816584fa90 EFLAGS: 00010246
[   78.548934] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00000
[   78.556776] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8881002=
0a938
[   78.564613] RBP: ffffffffafc08ab4 R08: 0000000000000000 R09: ffff88816c1=
1ad40
[   78.572456] R10: 0000000000000000 R11: 0000000000000001 R12: ffff88816c1=
1ad40
[   78.580290] R13: 0000000000000008 R14: dffffc0000000000 R15: 00000000000=
00000
[   78.588124] FS:  00007f7b8110f740(0000) GS:ffff8886edb80000(0000) knlGS:=
0000000000000000
[   78.596923] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   78.603380] CR2: 0000563b46186d40 CR3: 000000013ade6004 CR4: 00000000001=
706e0
[   78.611224] Call Trace:
[   78.614378]  <TASK>
[   78.617191]  ? lock_is_held_type+0xe4/0x140
[   78.622105]  null_map_queues+0x247/0x400 [null_blk]
[   78.627725]  blk_mq_alloc_tag_set+0x511/0xe90
[   78.632810]  null_add_dev+0x1a88/0x20e0 [null_blk]
[   78.638343]  nullb_device_power_store+0xe4/0x240 [null_blk]
[   78.644637]  ? null_add_dev+0x20e0/0x20e0 [null_blk]
[   78.650327]  ? alloc_pages+0x13b/0x260
[   78.654795]  ? null_add_dev+0x20e0/0x20e0 [null_blk]
[   78.660485]  configfs_write_iter+0x2af/0x480
[   78.665484]  new_sync_write+0x359/0x5e0
[   78.670040]  ? new_sync_read+0x5d0/0x5d0
[   78.674675]  ? perf_instruction_pointer+0x180/0x1a0
[   78.680265]  ? lock_release+0x6d0/0x6d0
[   78.684812]  ? inode_security+0x54/0xf0
[   78.689366]  ? lock_is_held_type+0xe4/0x140
[   78.694275]  vfs_write+0x61e/0x920
[   78.698401]  ksys_write+0xe9/0x1b0
[   78.702520]  ? __ia32_sys_read+0xa0/0xa0
[   78.707158]  ? syscall_enter_from_user_mode+0x21/0x70
[   78.712933]  do_syscall_64+0x3b/0x90
[   78.717219]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[   78.722990] RIP: 0033:0x7f7b812138d7
[   78.727280] Code: 0f 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f =
00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48=
> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[   78.746736] RSP: 002b:00007ffdad700d68 EFLAGS: 00000246 ORIG_RAX: 000000=
0000000001
[   78.755013] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f7b812=
138d7
[   78.762855] RDX: 0000000000000002 RSI: 0000563b46186d40 RDI: 00000000000=
00001
[   78.770690] RBP: 0000563b46186d40 R08: 0000000000000000 R09: 00007f7b812=
c84e0
[   78.778524] R10: 00007f7b812c83e0 R11: 0000000000000246 R12: 00000000000=
00002
[   78.786361] R13: 00007f7b8130d5a0 R14: 0000000000000002 R15: 00007f7b813=
0d7a0
[   78.794215]  </TASK>
[   78.797106] Modules linked in: null_blk xt_CHECKSUM xt_MASQUERADE xt_con=
ntrack ipt_REJECT nf_nat_tftp nf_conntrack_tftp bridge stp llc nft_objref n=
f_conntrack_netbios_ns nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft=
_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject =
nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6table_nat ip6t=
able_mangle ip6table_raw ip6table_security iptable_nat nf_nat nf_conntrack =
nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw iptable_security r=
fkill target_core_user target_core_mod ip_set nfnetlink ebtable_filter ebta=
bles ip6table_filter ip6_tables iptable_filter qrtr sunrpc intel_rapl_msr i=
ntel_rapl_common x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel i=
TCO_wdt intel_pmc_bxt iTCO_vendor_support at24 kvm irqbypass rapl intel_cst=
ate joydev intel_uncore pcspkr i2c_i801 intel_pch_thermal i2c_smbus lpc_ich=
 ses enclosure ie31200_edac video zram ip_tables crct10dif_pclmul crc32_pcl=
mul
[   78.797496]  crc32c_intel ast drm_vram_helper drm_kms_helper ghash_clmul=
ni_intel cec drm_ttm_helper ttm drm mpt3sas igb e1000e dca i2c_algo_bit rai=
d_class scsi_transport_sas fuse
[   78.899941] ---[ end trace d8088ef1fdc436e4 ]---
[   79.005147] RIP: 0010:blk_mq_map_queues+0x35e/0x650
[   79.010730] Code: 72 6b 48 8b 44 24 10 41 8d 77 01 0f b6 08 48 8b 44 24 =
08 83 e0 07 83 c0 03 38 c8 7c 08 84 c9 0f 85 c9 02 00 00 44 89 f8 31 d2 <f7=
> f3 48 8b 04 24 03 50 0c 4c 89 c8 48 c1 e8 03 42 0f b6 0c 30 4c
[   79.030177] RSP: 0018:ffff88816584fa90 EFLAGS: 00010246
[   79.036122] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00000
[   79.043974] RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffff8881002=
0a938
[   79.051825] RBP: ffffffffafc08ab4 R08: 0000000000000000 R09: ffff88816c1=
1ad40
[   79.059669] R10: 0000000000000000 R11: 0000000000000001 R12: ffff88816c1=
1ad40
[   79.067520] R13: 0000000000000008 R14: dffffc0000000000 R15: 00000000000=
00000
[   79.075375] FS:  00007f7b8110f740(0000) GS:ffff8886edb80000(0000) knlGS:=
0000000000000000
[   79.084170] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   79.090638] CR2: 0000563b46186d40 CR3: 000000013ade6004 CR4: 00000000001=
706e0

--=20
Best Regards,
Shin'ichiro Kawasaki=
