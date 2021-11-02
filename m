Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D077C433F5
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 09:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B90C60E8C
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 09:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbhKBJF0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Nov 2021 05:05:26 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:63267 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbhKBJFZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Nov 2021 05:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1635843770; x=1667379770;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+8pHVA35fp8hIZPnx+HBL2lTz0XB6sKmF6GSVkTEbww=;
  b=XBRvEAoXc60/1LUDplvVTzkRb8ig8ckypmpZhh6vRlhxCb206KjI0mRy
   hwBWCp3G0gMQEib0N0zhF+fxgf/DGS4yCnrGUMPY1J6TAXPjxzl0vb4c4
   Xj3H3oD0gKokdGWlixgVJFufZQljhDJrQPsO6K8ts4dxENTEa7bajXi85
   EC82Xp68+49sC9uZ8La9uH7ukk/h/HtPotfjXGgs3gfJ7EqWISs7tdIMm
   4+oJLDmBg3igxj6W+M5qGOUzGOe17p0NR+RA525gToRjyDZuV+KJTdU7u
   dbev7dmjMXIRCPXRTWfJ3F/QvpTVZvMWDYPBVR9AowDaB1XEW2hod/sbp
   w==;
X-IronPort-AV: E=Sophos;i="5.87,202,1631548800"; 
   d="scan'208";a="183475572"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2021 17:02:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YpYPR7rgszCmDZE2YG1W9du9tirJDflDvguKSyFgUNzLSC3zC3r6iMkJ9XlV4WOAMPTU85G+q5G3BkZAzPbzKjE6N1D3GDgedPrXOb/TgmxPRjq1r1jQz/7KLZejhAb9lCryRF8MnNrtrPNq4ioHZoHqqytex9GLacN5zBRJ+Y7w4h0AFpSgsKpZICBT/023684qBBBnhq1WRQKJRvzrUY3NHrTB6dKlLvPtlYq8/e/Sz9nVHZvtW6OEW5vD5hZRZbnwlcdVCTFHmFv3iig1T0IXWKBttho4sw+sZuJ63R2ctILM/aVp+7ne++qGsXBOZc9MYHwknDdxkAt9y4Z26w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlYsxRn+bo+p75g7xz/AwaVYkJLXuIDDgN8iFhXciHU=;
 b=TIYct3wkQwzjOQDvi3MfKZC0Bm/H+su+otf9lvcwTaGC3Ja2oO4tGVZkU9oI7lOYefPvj1KgSfgz8MV2M4yr9ShSEAd5L8jxPqJpFK0QCR8k3LsFjEQ4/PxzcDRV7YV2gJ7Tlg2+hBBgCE0nSJZWAUGaXbQnHCgy1F1hQS55iA72xibA2D3oPVTdyFWRJR5gR8zHF2JLItctPKkk9OzjuhpOPGMYdA+Nsv4epa0qs5TK7dugYHMsgztolYAgZdHXCVrzeIE6UWJRzGwu1AOW0tXQNJ3RMHQTb8Ljl/hlc6A4dRJwI3tJrQmFcpDDuQKp5JtMBHtawk8Q/5CE52v8Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlYsxRn+bo+p75g7xz/AwaVYkJLXuIDDgN8iFhXciHU=;
 b=YjwOdFrLV1qXlmg87Ky9xk0OQAgpgV6GUYc/E1b4qA8ZHFpcteng5UDjOXrcHDrT/iJXjKl5eWc6Ma9B6T/wrVzXPl6k2irTbpO17atkX53Ba6MBdA0WUicAohzdBkLDwnJCBgxd8baZ+zxjW0FuxyUYK8Kgvph9zXLRf6aGjgA=
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com (2603:10b6:a03:291::7)
 by BYAPR04MB6183.namprd04.prod.outlook.com (2603:10b6:a03:ee::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Tue, 2 Nov
 2021 09:02:47 +0000
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::49e:8e59:823a:fb61]) by SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::49e:8e59:823a:fb61%3]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 09:02:47 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [bug report] block/005 hangs with NVMe device and
 linux-block/for-next
Thread-Topic: [bug report] block/005 hangs with NVMe device and
 linux-block/for-next
Thread-Index: AQHXzvtCAnSg404Q90iJ/hTDak5dVqvunZKAgACtRQCAADgYAIAAFuyAgABPfACAAAmAAA==
Date:   Tue, 2 Nov 2021 09:02:47 +0000
Message-ID: <20211102090246.5own2pqinv3lw6qg@shindev>
References: <20211101083417.fcttizyxpahrcgov@shindev>
 <30d7ccec-c798-3936-67bd-e66ae59c318b@kernel.dk>
 <f56c7b71-cef4-10be-7804-b171929cfb76@kernel.dk>
 <20211102022214.7hetxsg4z2yqafyd@shindev> <YYC0ESdW1+B/dDTs@T590>
 <20211102082846.m632phnsaqnwtaec@shindev>
In-Reply-To: <20211102082846.m632phnsaqnwtaec@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ed8e104-08a9-4a5f-9c74-08d99ddf8a54
x-ms-traffictypediagnostic: BYAPR04MB6183:
x-microsoft-antispam-prvs: <BYAPR04MB618342363393420F130A13D3ED8B9@BYAPR04MB6183.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OsRvBCe+VVd4dv0TlG0KCezvE1bCeQfDQ/txKXsCS9vWAM2ymkZLrSg9MhP7XtmRejTq1nu9CkcO5ns/+wtMoiPslH2xvDxjEK6a8tuav93XRedAQtrw/JrxnouB5tTsutbmYxsypN9BSwe0urnlf1j9DofuMCKFXXWm+BxYfAy2fsU9NOppTAjoPnoW6QbilKbCXnNwnpfWdd924bvk3bhSKp26QCIfXX6Wb1hXa6T6gAXGHmIRF9XIHyAf45cA1pmjt5/Rws53ANfAs6KCVzjqFwdNwRPtjW+pCnZuqS3c/PeR9eClHvkOyckJaDC8ZaNpOjp3FXBDHu0rupL/SXYQ0wDOrygNg95CjHu3PNzjx2Do6GTdg5Lz1N8RJMz6ddzSyBAM7oK8Mamy3RTJgj7cjuIIX78+Cefm8Vuli9xzCGScD5MjnBv4VmHhsTThtwaLKYiT63ULMER0zJ7/5dNbUX+Vz9SLnkLV448XNSyKYokHQrUl7TP489P48cW4kRJ9/1rhoNZhj6llga571qMqw9zrHaqwR9JCdXuhIuvKX3CFcrhwCcg+9nYhJLXY5v0mfg9izdUcLoxN8s4L2Ddu4oFy7ODaGH9+Ck1JT8V6Uz0fRDe9gB7HN7aOI78omwzK8GHAi9OS+3iw9R1SsBxktReILqVfFtu4hAIO2R0sHuy8I8ji0JVuAmFaRwvegI+lwyRJwActsEwQykOd7lTGTg2jHidgqUgqP3k6tkWlDDwJfKiNoJAIpVLFwSwI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7184.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(82960400001)(71200400001)(316002)(2906002)(53546011)(122000001)(91956017)(6506007)(6486002)(4326008)(83380400001)(33716001)(54906003)(44832011)(6916009)(508600001)(66946007)(5660300002)(1076003)(9686003)(6512007)(26005)(86362001)(186003)(66446008)(38070700005)(64756008)(38100700002)(8676002)(76116006)(66556008)(66476007)(8936002)(458404002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?mKTnt53eXio19kbgaFhxak9foOUQF2xQyLSS3V/1B+af/Z+09u2tPASopCLm?=
 =?us-ascii?Q?Lokp2iwF196dCCY/4TOPLt2kiI7PixXs4CFHRoLeIeMB8zQRxUeFqzg1IxMg?=
 =?us-ascii?Q?KDl//IUYyP7sEo+FGvPS+bdVG3akC+qtrmqRCN58hXW/+iLPLfHz8Ojk6l9u?=
 =?us-ascii?Q?YMzsMo2gGtDv9krsPRxeTupDuayWIu2TCZY2g9+quPh9gq7l3pU3K4dQGna2?=
 =?us-ascii?Q?Pom+Km1Qn8E3p0ViUgFkVYDspJ+SL8AsohgSQu05l++tm82WJDFpAtGHhMrj?=
 =?us-ascii?Q?xYnJBw1TIQ9MdDvkmIDESvFmO0nhkYSn1MmJXWr1i6BjMcLh95S/tqKmr1R/?=
 =?us-ascii?Q?cCE9AhyeVOo48bB8McmDovUWQJvzHDYJKAcGcVmA7TPSbmMwry+WUTxDyxWq?=
 =?us-ascii?Q?VDadgWL/XfXHUCsFat18CYniEXMsuI5i3tGKsreK8NIFPlcFhy8HJUia/D6D?=
 =?us-ascii?Q?nJei35unNZjOva/7gJDRezhN4zbaSatBp4kh6DLD6CN6+1Ykwowh+/Il3uW+?=
 =?us-ascii?Q?21nDeoqJhjlGriANCW1JpRXVcGuPBM7nbn3emEoarzlQ7PVoUKqhLIjKhZ8T?=
 =?us-ascii?Q?7E4I8Lu3B5Un/DbI5PH2sjf3wIvm7h9ib/00aWTmZ9jeC6HYcHboVCnBx+Ry?=
 =?us-ascii?Q?fnd8FCGRWPrHPexrc2c6xXIxO0ZyRQuPaaf8HDmxxlcsB5GMUNI26cuoE4qN?=
 =?us-ascii?Q?1gOv4aHePGnRC5g/HEqShVSDeCeCf05Bo2pxFV+f174nJJMihH+HdsVAWepH?=
 =?us-ascii?Q?HvM+P46n/LawDBM+BrxJt4zLyHvPf5IeWpiSrlbGPIZrRvo9br2wo1W8XPTh?=
 =?us-ascii?Q?sPNtup+6UJ9TcbXiBmI8E1sGb+LmkIrEQrB53PieoHQmXtVWetahZR6Fid5R?=
 =?us-ascii?Q?yCmWv+YZAHrH2cbV5qI/4m8/gr25gzyogANKOk5Ha7udRF71v9WN0Ai8ehP8?=
 =?us-ascii?Q?4bviQjZBL87oQHS5PUNDe4z2IU0vkbvUnUmBXgVKt+iR0r7yrvkQl9qjSFQ3?=
 =?us-ascii?Q?nhfn9HzqLNlY/FgD9ED/izgAhBS+/QNpnTV3PNeS3R7wST6RdVkauxA8006g?=
 =?us-ascii?Q?e8bOLRn3Oq/lYqQh325MQVgQx4wkNMwYbCgVOHL1aV3QSv8YyPsl0VMgXUkn?=
 =?us-ascii?Q?hxihBpzOGAyIs2CWr1DsGpiTIia31ylpcdNW/kal007RncQNLGwNODVOVJJC?=
 =?us-ascii?Q?wGMDJ972NhLDeg3mCTKmlL3op01s1uiB+gq4mSNt415yZjTNk4dXXyTbd3Ky?=
 =?us-ascii?Q?kaAtahE4BA/oc8mQI9A/wcNFje1M7pOeooXR98Pzx1/HeF9XODPrHeIkMe6r?=
 =?us-ascii?Q?X306mm8bgH9v28Iz2D1F7/gbZdOcYkdm7PDkz1KsL968U450FJ5mXf18+F2/?=
 =?us-ascii?Q?JPdmjNRVJ3yqHICYMSPJj7X1mdZeC+RhCkunF6l0Ro3XSUTu0eV2ezJQFPqF?=
 =?us-ascii?Q?EFIVRiak//Y/6Lz2ZTz3wSB5ERHfAbrtkpcFnp+SkMYb+Ev5mMRvdvBIyNyi?=
 =?us-ascii?Q?gWxePUkLgrdAEwbmmO9SiEZl+I9so+br699r1MjJWOPTXudty2cFmnYAuhFn?=
 =?us-ascii?Q?6LLr48HAgTfWqwE0asBjSrBTdK3JPzSC6+8Gdv02SHAfmJ/EX73NtyQ9GqJA?=
 =?us-ascii?Q?Qrgd5JE5ZHY/QjhR2iFNmgwOxvpbTlHq8FbIDATNy+hOd5QhBcKwWKip8ZjP?=
 =?us-ascii?Q?60rdz+89zZMAiSPqD2yYa1DmGoI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <88150940CF44DB4BA0486C7C761F35AE@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7184.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ed8e104-08a9-4a5f-9c74-08d99ddf8a54
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2021 09:02:47.2718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yexRaCQcuiD7QxEtU81s7y71D/a0RbfJnN/n+rPBgxvryNrLpli2U3L9OOGiAIPz49JUybF44H3jY1VYyMl9gmcaM3xx6YZuLZ3xXXwzS/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6183
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Let me add linux-nvme, Keith and Christoph to the CC list.

--=20
Best Regards,
Shin'ichiro Kawasaki


On Nov 02, 2021 / 17:28, Shin'ichiro Kawasaki wrote:
> On Nov 02, 2021 / 11:44, Ming Lei wrote:
> > On Tue, Nov 02, 2021 at 02:22:15AM +0000, Shinichiro Kawasaki wrote:
> > > On Nov 01, 2021 / 17:01, Jens Axboe wrote:
> > > > On 11/1/21 6:41 AM, Jens Axboe wrote:
> > > > > On 11/1/21 2:34 AM, Shinichiro Kawasaki wrote:
> > > > >> I tried the latest linux-block/for-next branch tip (git hash b43=
fadb6631f and
> > > > >> observed a process hang during blktests block/005 run on a NVMe =
device.
> > > > >> Kernel message reported "INFO: task check:1224 blocked for more =
than 122
> > > > >> seconds." with call trace [1]. So far, the hang is 100% reproduc=
ible with my
> > > > >> system. This hang is not observed with HDDs or null_blk devices.
> > > > >>
> > > > >> I bisected and found the commit 4f5022453acd ("nvme: wire up com=
pletion batching
> > > > >> for the IRQ path") triggers the hang. When I revert this commit =
from the
> > > > >> for-next branch tip, the hang disappears. The block/005 test cas=
e does IO
> > > > >> scheduler switch during IO, and the completion path change by th=
e commit looks
> > > > >> affecting the scheduler switch. Comments for solution will be ap=
preciated.
> > > > >=20
> > > > > I'll take a look at this.
> > > >=20
> > > > I've tried running various things most of the day, and I cannot
> > > > reproduce this issue nor do I see what it could be. Even if request=
s are
> > > > split between batched completion and one-by-one completion, it work=
s
> > > > just fine for me. No special care needs to be taken for put_many() =
on
> > > > the queue reference, as the wake_up() happens for the ref going to =
zero.
> > > >=20
> > > > Tell me more about your setup. What does the runtimes of the test l=
ook
> > > > like? Do you have all schedulers enabled? What kind of NVMe device =
is
> > > > this?
> > >=20
> > > Thank you for spending your precious time. With the kernel without th=
e hang,
> > > the test case completes around 20 seconds. When the hang happens, the=
 check
> > > script process stops at blk_mq_freeze_queue_wait() at scheduler chang=
e, and fio
> > > workload processes stop at __blkdev_direct_IO_simple(). The test case=
 does not
> > > end, so I need to reboot the system for the next trial. While waiting=
 the test
> > > case completion, the kernel repeats the same INFO message every 2 min=
utes.
> > >=20
> > > Regarding the scheduler, I compiled the kernel with mq-deadline and k=
yber.
> > >=20
> > > The NVMe device I use is a U.2 NVMe ZNS SSD. It has a zoned name spac=
e and
> > > a regular name space, and the hang is observed with both name spaces.=
 I have
> > > not yet tried other NVME devices, so I will try them.
> > >=20
> > > >=20
> > > > FWIW, this is upstream now, so testing with Linus -git would be
> > > > preferable.
> > >=20
> > > I see. I have switched from linux-block for-next branch to the upstre=
am branch
> > > of Linus. At git hash 879dbe9ffebc, and still the hang is observed.
> >=20
> > Can you post the blk-mq debugfs log after the hang is triggered?
> >=20
> > (cd /sys/kernel/debug/block/nvme0n1 && find . -type f -exec grep -aH . =
{} \;)
>=20
> Thanks Ming. When I ran the command above, the grep command stopped when =
it
> opened tag related files in the debugfs tree. That grep command looked ha=
nking
> also. So I used the find command below instead to exclude the tag related=
 files.
>=20
> # find . -type f -not -name *tag* -exec grep -aH . {} \;
>=20
> Here I share the captured log.
>=20
> ./sched/queued:0 8 0
> ./sched/owned_by_driver:0 8 0
> ./sched/async_depth:192
> ./sched/starved:0
> ./sched/batching:1
> ./rqos/wbt/wb_background:4
> ./rqos/wbt/wb_normal:8
> ./rqos/wbt/unknown_cnt:0
> ./rqos/wbt/min_lat_nsec:2000000
> ./rqos/wbt/inflight:0: inflight 0
> ./rqos/wbt/inflight:1: inflight 0
> ./rqos/wbt/inflight:2: inflight 0
> ./rqos/wbt/id:0
> ./rqos/wbt/enabled:1
> ./rqos/wbt/curr_win_nsec:0
> ./hctx7/type:default
> ./hctx7/dispatch_busy:7
> ./hctx7/active:1024
> ./hctx7/run:5
> ./hctx7/ctx_map:00000000: 00
> ./hctx7/dispatch:000000003dfed3fd {.op=3DREAD, .cmd_flags=3D, .rq_flags=
=3DSTARTED|ELVPRIV|IO_STAT|22, .state=3Didle, .tag=3D-1, .internal_tag=3D19=
2}
> ./hctx7/dispatch:0000000077876d9e {.op=3DREAD, .cmd_flags=3D, .rq_flags=
=3DSTARTED|ELVPRIV|IO_STAT|22, .state=3Didle, .tag=3D-1, .internal_tag=3D19=
3}
> ./hctx7/flags:alloc_policy=3DFIFO SHOULD_MERGE|TAG_QUEUE_SHARED
> ./hctx7/state:TAG_ACTIVE|SCHED_RESTART
> ./hctx6/type:default
> ./hctx6/dispatch_busy:5
> ./hctx6/active:1025
> ./hctx6/run:4
> ./hctx6/ctx_map:00000000: 00
> ./hctx6/dispatch:00000000c0b8e1c9 {.op=3DREAD, .cmd_flags=3D, .rq_flags=
=3DSTARTED|ELVPRIV|IO_STAT|22, .state=3Didle, .tag=3D-1, .internal_tag=3D19=
2}
> ./hctx6/flags:alloc_policy=3DFIFO SHOULD_MERGE|TAG_QUEUE_SHARED
> ./hctx6/state:TAG_ACTIVE|SCHED_RESTART
> ./hctx5/type:default
> ./hctx5/dispatch_busy:5
> ./hctx5/active:1024
> ./hctx5/run:4
> ./hctx5/ctx_map:00000000: 00
> ./hctx5/dispatch:00000000aaf1e364 {.op=3DREAD, .cmd_flags=3D, .rq_flags=
=3DSTARTED|ELVPRIV|IO_STAT|22, .state=3Didle, .tag=3D-1, .internal_tag=3D12=
8}
> ./hctx5/flags:alloc_policy=3DFIFO SHOULD_MERGE|TAG_QUEUE_SHARED
> ./hctx5/state:TAG_ACTIVE|SCHED_RESTART
> ./hctx4/type:default
> ./hctx4/dispatch_busy:0
> ./hctx4/active:1023
> ./hctx4/run:1
> ./hctx4/ctx_map:00000000: 00
> ./hctx4/flags:alloc_policy=3DFIFO SHOULD_MERGE|TAG_QUEUE_SHARED
> ./hctx3/type:default
> ./hctx3/dispatch_busy:5
> ./hctx3/active:1024
> ./hctx3/run:4
> ./hctx3/ctx_map:00000000: 00
> ./hctx3/dispatch:000000008b07d5e1 {.op=3DREAD, .cmd_flags=3D, .rq_flags=
=3DSTARTED|ELVPRIV|IO_STAT|22, .state=3Didle, .tag=3D-1, .internal_tag=3D12=
8}
> ./hctx3/flags:alloc_policy=3DFIFO SHOULD_MERGE|TAG_QUEUE_SHARED
> ./hctx3/state:TAG_ACTIVE|SCHED_RESTART
> ./hctx2/type:default
> ./hctx2/dispatch_busy:5
> ./hctx2/active:1024
> ./hctx2/run:4
> ./hctx2/ctx_map:00000000: 00
> ./hctx2/dispatch:00000000c4887013 {.op=3DREAD, .cmd_flags=3D, .rq_flags=
=3DSTARTED|ELVPRIV|IO_STAT|22, .state=3Didle, .tag=3D-1, .internal_tag=3D12=
8}
> ./hctx2/flags:alloc_policy=3DFIFO SHOULD_MERGE|TAG_QUEUE_SHARED
> ./hctx2/state:TAG_ACTIVE|SCHED_RESTART
> ./hctx1/type:default
> ./hctx1/dispatch_busy:6
> ./hctx1/active:1024
> ./hctx1/run:5
> ./hctx1/ctx_map:00000000: 00
> ./hctx1/dispatch:00000000efe38e4e {.op=3DREAD, .cmd_flags=3D, .rq_flags=
=3DSTARTED|ELVPRIV|IO_STAT|22, .state=3Didle, .tag=3D-1, .internal_tag=3D0}
> ./hctx1/flags:alloc_policy=3DFIFO SHOULD_MERGE|TAG_QUEUE_SHARED
> ./hctx1/state:TAG_ACTIVE|SCHED_RESTART
> ./hctx0/type:default
> ./hctx0/dispatch_busy:5
> ./hctx0/active:1024
> ./hctx0/run:4
> ./hctx0/ctx_map:00000000: 00
> ./hctx0/dispatch:0000000015147095 {.op=3DREAD, .cmd_flags=3D, .rq_flags=
=3DSTARTED|ELVPRIV|IO_STAT|22, .state=3Didle, .tag=3D-1, .internal_tag=3D19=
2}
> ./hctx0/flags:alloc_policy=3DFIFO SHOULD_MERGE|TAG_QUEUE_SHARED
> ./hctx0/state:TAG_ACTIVE|SCHED_RESTART
> ./write_hints:hint0: 0
> ./write_hints:hint1: 0
> ./write_hints:hint2: 0
> ./write_hints:hint3: 0
> ./write_hints:hint4: 0
> ./state:SAME_COMP|NONROT|IO_STAT|DISCARD|INIT_DONE|STATS|REGISTERED|PCI_P=
2PDMA|NOWAIT
> ./pm_only:0
> ./poll_stat:read  (512 Bytes): samples=3D0
> ./poll_stat:write (512 Bytes): samples=3D0
> ./poll_stat:read  (1024 Bytes): samples=3D0
> ./poll_stat:write (1024 Bytes): samples=3D0
> ./poll_stat:read  (2048 Bytes): samples=3D0
> ./poll_stat:write (2048 Bytes): samples=3D0
> ./poll_stat:read  (4096 Bytes): samples=3D0
> ./poll_stat:write (4096 Bytes): samples=3D0
> ./poll_stat:read  (8192 Bytes): samples=3D0
> ./poll_stat:write (8192 Bytes): samples=3D0
> ./poll_stat:read  (16384 Bytes): samples=3D0
> ./poll_stat:write (16384 Bytes): samples=3D0
> ./poll_stat:read  (32768 Bytes): samples=3D0
> ./poll_stat:write (32768 Bytes): samples=3D0
> ./poll_stat:read  (65536 Bytes): samples=3D0
> ./poll_stat:write (65536 Bytes): samples=3D0
>=20
>=20
> --=20
> Best Regards,
> Shin'ichiro Kawasaki=
