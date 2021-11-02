Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4784C433F5
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 08:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8CBA60C4B
	for <linux-block@archiver.kernel.org>; Tue,  2 Nov 2021 08:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhKBIbZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Nov 2021 04:31:25 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:4885 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbhKBIbW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Nov 2021 04:31:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1635841726; x=1667377726;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eCo6TQjiZZ3ShVSvsZkB7oY6/+baCmIE1QOXwDRHR5I=;
  b=KfbETr/DaOiu/OCj/b/1mtyClPd64S8WhBLagVR19RafSG5Etc3riQ2N
   8NRNSm1EurK7IrcjeYIM+E0/cFOwV2/xGBzHED3bMNlDAAFbBFGOBVAyC
   +Lnu2EF9cvhTr8D8Wgw8n3X2KIsEHDkkSGUm00zEl1LoOVXUomccTCWiG
   6JjhEcooJxaVB53qrl11HqP7hKYumfIkttESegbqW1soCtJ5gX15rQikQ
   rDSehaJuXo0COOm+JmJbYC9JJO+gSY7e02b6ZL26SN0VCQff3M/Ryd/rf
   Qs9PsOxJ7BfhR0mK7arWYiNHDcSXB/48jW0JfgUsz26R2NSI2dzOmltUU
   A==;
X-IronPort-AV: E=Sophos;i="5.87,202,1631548800"; 
   d="scan'208";a="184463439"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2021 16:28:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gnsU2kND0E7C2My1JSoRvP4JLPsmGcs1mBjx7SiDb+pSq0COut5A3xmBTp3bujM08FS7v38uQkxprztO/KE/HHlQIUlAGNgmkYTp6wVF0uaHJrdudlJaQURGLmo41kkqa2II4g5tbwbM6QvWoglI59BZ9TBSjlqGNeg8edMJ60J4tE73yMno3XVJRpctj4rJM/R1enR0rH+OBz/PsHd92CKFQH6SHxzcuvHrya+Hdyi15qq3l/+uCiDuz35Mos14IDRCNr10SM8SahWVuXWRjQZFNRM53ZZYw3KpGuN8QVHbywDDy8xRjzLcxPDIU6Z+b4GN60HLU1evdGFwxO6EAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ab9Y2iT5zPC0lZgLXutiBV3EB3ENOs6GEb8gcMsoKOg=;
 b=lj1UJYbQeloX4Gqsl1ey0yRXV7YvlgxbD8cYZ64xu/Vvrw2yAgc4mpJK00lKNTFz4JF2oUH5OjjD7hyTIE6/RtsLVyz2wI9IOJiScD8PmUgcMobV4JHA3nFI4wyU9DkOFWHvnq2Lj5ReLbEKlLP/46S41pdLD2Tyq05Fq/ytppbxOOTVzagmPDXmPzSznqtCYJbPV6qPQ6oWX8R1HEujxMHYW8TV2N2dPsqnDv51tYzW94dtygrfuiJdeYKt42zxi3MHMDS87CviMD2WXs0+2uaWWpLShjw6/koK4wrJ9IN9Sq86rWSAyvfr53N8hUxUbMHW+8iAKlwWp8S4GKhDjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ab9Y2iT5zPC0lZgLXutiBV3EB3ENOs6GEb8gcMsoKOg=;
 b=tx/5gNNd0I5UP2DJdjmMw6XgCtEdmYekf1sTCiGLPNMofDIncTT/eSDKEpPVL5NobBlsHsek4qyDVQDLUEjPKDLnCsql1jB+UCgbyeXVm0zr2EQZ6gNLS0KCCYX6iu6DuIFtkILZfkemLpFqMewtCSbEMq0G+jgd9d3qN6rhaJw=
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com (2603:10b6:a03:291::7)
 by BYAPR04MB4200.namprd04.prod.outlook.com (2603:10b6:a02:f5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14; Tue, 2 Nov
 2021 08:28:47 +0000
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::49e:8e59:823a:fb61]) by SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::49e:8e59:823a:fb61%3]) with mapi id 15.20.4649.020; Tue, 2 Nov 2021
 08:28:47 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [bug report] block/005 hangs with NVMe device and
 linux-block/for-next
Thread-Topic: [bug report] block/005 hangs with NVMe device and
 linux-block/for-next
Thread-Index: AQHXzvtCAnSg404Q90iJ/hTDak5dVqvunZKAgACtRQCAADgYAIAAFuyAgABPfAA=
Date:   Tue, 2 Nov 2021 08:28:47 +0000
Message-ID: <20211102082846.m632phnsaqnwtaec@shindev>
References: <20211101083417.fcttizyxpahrcgov@shindev>
 <30d7ccec-c798-3936-67bd-e66ae59c318b@kernel.dk>
 <f56c7b71-cef4-10be-7804-b171929cfb76@kernel.dk>
 <20211102022214.7hetxsg4z2yqafyd@shindev> <YYC0ESdW1+B/dDTs@T590>
In-Reply-To: <YYC0ESdW1+B/dDTs@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5c87322-2ab0-4c31-92cc-08d99ddaca52
x-ms-traffictypediagnostic: BYAPR04MB4200:
x-microsoft-antispam-prvs: <BYAPR04MB42005DF649ABE4BB3B3E52D5ED8B9@BYAPR04MB4200.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5lf2amcSiyxZlDPWSH1pmQsfalSa6C9Otq4Li8YNaxLthZ7foFGEA7JrGfROZNoalK2J75WoEeMLfx7Z9oxx/agGxJPv5nWhMDR1p3Wm8vdvN8MaKxlz8g3ajZNb8kYc30jWX4vELJXBW2jyJPyikyX8+FzqZGoPnobIyAhyXWQ5mfgNxucwfJ/Euo+tazg4VJzrtcKck2DtZfdf4G7dvv+mFFVAXN5T+2E0zGHrBKEZ2m/d5rHFz8KHTtV+qjMIJ/In/UPLhaR8ItAJLy1Ywf8nUMUEdBqKZusqQvNVZpbSHJqsAplL15XRqj0nBPyUQCFrvoMWnhW4QcBRyvLDEvmMn4XEgHGLymc3oGvwrtUzjAefcb3QiLOKylK1154+y8dGbbPCfmTaHCCE0InL7ukq7NSkQHv0osvaQW77UtarWdTyX4SATaerRlGADHl4slGaJ7A00KRnmJqPOYyWpfs1bzk06AhkPwHIKHKCIwySZETzfWwg+pQsnb0mI8xPrHYRIf8pzchM7yD9LYrCJZGjKLXI71cSff8l/4Qxp1tYzyAU86mJ0tpANPdKdYW/ClTGU2UCd6XaDz0j7XYb7e/ABGLuPBgzhGmRto2HuKEtP00RF8PcI22lqjtxDai0FA0CaW/gX7NPlw42UGOBbpmbhJR2lzJxGKlf0EzBWvq/Z+SrYokuvuylggsYEa+fd1NWLaKz9H2xvB1OlnEhDqA94WNmWrx1LWN8Ehyv4C0++YfGSFiF3MnEpXVUam2I
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7184.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(5660300002)(26005)(82960400001)(186003)(38070700005)(6512007)(9686003)(71200400001)(4326008)(33716001)(53546011)(6506007)(2906002)(8676002)(91956017)(76116006)(8936002)(316002)(122000001)(66556008)(66476007)(64756008)(66446008)(66946007)(83380400001)(38100700002)(86362001)(508600001)(44832011)(1076003)(6916009)(54906003)(6486002)(458404002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WJBEn42MrLRpFQDZQdxnscNQfBPjUaWAZCBW28HP8cFXCAkfXXh8s9Aw2mxo?=
 =?us-ascii?Q?n7sZ5YA2hpLreMXM+qtH3BVgLjI6KPAazOWUEbMNCiv0EFtF4Rp81+X9neC0?=
 =?us-ascii?Q?0uM9zsYlKXVC4/tTjtuZRKOsud7t9wYhHQK9q27TYghslZvo5IiAZbEcLhfC?=
 =?us-ascii?Q?NxFVQY+BGJQ/nk2ePPJjR/exyD1hkBOIB/tS89Rk0PqPRv32Cg/0xh6kB+4r?=
 =?us-ascii?Q?bpph8b8nH5bbrDqYmyasfgEZedWp6gjTeNAtprORXoYBOLHrlw2ZfKumbFWp?=
 =?us-ascii?Q?4dThMn/wgYW86XdfhJ8yV+yWfTUAkFVzghLc7WAe3hwSDGWf3hzoa0gmmy7p?=
 =?us-ascii?Q?4uBMZLgm++J71NRV0AwP5Wa2Xzm9h61qVCtDGG17qFOVyTJA2EFmBw+nag9V?=
 =?us-ascii?Q?16R1S2lkdoLROtRG2GY5XeTWJSt7mpNEEB+L1db6UgTCX8qRU353t1WZ0PxG?=
 =?us-ascii?Q?q65aPwM/Sff6Qe+tbgAG++Shy6meinyIzhK5iAlbgy/XRCMhU4OOfVRcRlJl?=
 =?us-ascii?Q?SAMNumb+bnCS2AZNeqWNPp04w18qHTD62AfVVzL0dC/RvXOiYEZJcppUQNgi?=
 =?us-ascii?Q?SeA3l4kgivwXpQNrONOAtRhSPBX66GjlL0k6cs5PP3oMQkA0gvoLLvUzdke7?=
 =?us-ascii?Q?SNf3sGrC3/M/q4GfmnUobshtMnuVyk5DvEpRZu2rx0Efy6jjfpq0GVld1hO+?=
 =?us-ascii?Q?xpgQCEqvKghasvVxKZqhbpHW4ujcdCwB3Wx3mWlcFx9iGFqafhij2S+Mnyqt?=
 =?us-ascii?Q?CLDTkAkO35AStzwZRf2fBh9rtgYVpxNS2tB/YexM3vNVFdLsj8hoacaj9GDk?=
 =?us-ascii?Q?iskMztejPOSdpudC0fTXnBDzN9cjMk8YGeQ5MR3eiEXurXD7BASUmCqIG2if?=
 =?us-ascii?Q?3a3hK3ftrW89RStCrJNICCrNKG1nOyhnyvrtIbl9PCb/KxrGFO4rJHCkHVog?=
 =?us-ascii?Q?UP9CeIZSRQPnyD2u+xzl8taQ+7l5747+yEoZUUU0jzLh6y8fZrw13ujCafPZ?=
 =?us-ascii?Q?tTuZiU7sIcciaX4J+HCTKCbZuC2OYLV51aYYDSocG7txnShl73v9zMVlM1Zg?=
 =?us-ascii?Q?oC4zbWs8p7h7T76kvQYTyrvcg9y0KpXN8YxPx8tfXxqfyf5RDd7SuJN6zcwE?=
 =?us-ascii?Q?bpo1AJiqjppotQqS32XpIZn+WTTkYdk2REddePv6kw90wJldJIUSzOLL7JA2?=
 =?us-ascii?Q?PfJXiWlyScSV0hyOLj3R/gIUWZ7qV8CeGR3sGn9mxlT56vL/ayyOU3Xm6r/e?=
 =?us-ascii?Q?FYe1xe8KlMgfmGMOfHYmjW2pxOHnfxxysJHi+uVEyspL+UCIbMgNbB5aUmIQ?=
 =?us-ascii?Q?f2fOVdF9Cnulbi3DfmDjO642xMpPZvpjoXyv3FakfirpQ9qlw/YQrqZYGD9X?=
 =?us-ascii?Q?SV4Pu7lr6f/4t6ay0cOWxvpqMGFw1wPrDE2I0f3km4X8pnDLSsbhcN8rBKwU?=
 =?us-ascii?Q?4DK98PWH08eDvcYG+im3CBCBPekz5qqdpl+s1W781Qa2P6Bxq7RLflbGFFx1?=
 =?us-ascii?Q?FApHZ286XwWC56fkeCzjBPrR4IqJUGBZv4M6lXb8DaE2e2UjR1Pg7YzUS71I?=
 =?us-ascii?Q?y4V8owQp/upY0MzZrHeriHiVM82Sc+aNThIAXLXaaoSVl5gHp4eyJS17C8td?=
 =?us-ascii?Q?s9YOq+ftaj1cbjCPWOOWLK1aPnevQ2qo37vduVghdmxg5N8U+7lDyP76qgvq?=
 =?us-ascii?Q?uS5hU1lY4odcLElIK3baEhw+9JE=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <486567E2005972418610E04B1BC21543@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7184.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c87322-2ab0-4c31-92cc-08d99ddaca52
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2021 08:28:47.1002
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K3MH4VpYOG9l4b897R3atU/+XroOksOL9opsAlAzMcCj+3+/28t3q4EoaxbjqeR7yxwFRN/aYqa2+8gVvk+tFSo626kos/qiaVzqrMWcLN0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4200
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Nov 02, 2021 / 11:44, Ming Lei wrote:
> On Tue, Nov 02, 2021 at 02:22:15AM +0000, Shinichiro Kawasaki wrote:
> > On Nov 01, 2021 / 17:01, Jens Axboe wrote:
> > > On 11/1/21 6:41 AM, Jens Axboe wrote:
> > > > On 11/1/21 2:34 AM, Shinichiro Kawasaki wrote:
> > > >> I tried the latest linux-block/for-next branch tip (git hash b43fa=
db6631f and
> > > >> observed a process hang during blktests block/005 run on a NVMe de=
vice.
> > > >> Kernel message reported "INFO: task check:1224 blocked for more th=
an 122
> > > >> seconds." with call trace [1]. So far, the hang is 100% reproducib=
le with my
> > > >> system. This hang is not observed with HDDs or null_blk devices.
> > > >>
> > > >> I bisected and found the commit 4f5022453acd ("nvme: wire up compl=
etion batching
> > > >> for the IRQ path") triggers the hang. When I revert this commit fr=
om the
> > > >> for-next branch tip, the hang disappears. The block/005 test case =
does IO
> > > >> scheduler switch during IO, and the completion path change by the =
commit looks
> > > >> affecting the scheduler switch. Comments for solution will be appr=
eciated.
> > > >=20
> > > > I'll take a look at this.
> > >=20
> > > I've tried running various things most of the day, and I cannot
> > > reproduce this issue nor do I see what it could be. Even if requests =
are
> > > split between batched completion and one-by-one completion, it works
> > > just fine for me. No special care needs to be taken for put_many() on
> > > the queue reference, as the wake_up() happens for the ref going to ze=
ro.
> > >=20
> > > Tell me more about your setup. What does the runtimes of the test loo=
k
> > > like? Do you have all schedulers enabled? What kind of NVMe device is
> > > this?
> >=20
> > Thank you for spending your precious time. With the kernel without the =
hang,
> > the test case completes around 20 seconds. When the hang happens, the c=
heck
> > script process stops at blk_mq_freeze_queue_wait() at scheduler change,=
 and fio
> > workload processes stop at __blkdev_direct_IO_simple(). The test case d=
oes not
> > end, so I need to reboot the system for the next trial. While waiting t=
he test
> > case completion, the kernel repeats the same INFO message every 2 minut=
es.
> >=20
> > Regarding the scheduler, I compiled the kernel with mq-deadline and kyb=
er.
> >=20
> > The NVMe device I use is a U.2 NVMe ZNS SSD. It has a zoned name space =
and
> > a regular name space, and the hang is observed with both name spaces. I=
 have
> > not yet tried other NVME devices, so I will try them.
> >=20
> > >=20
> > > FWIW, this is upstream now, so testing with Linus -git would be
> > > preferable.
> >=20
> > I see. I have switched from linux-block for-next branch to the upstream=
 branch
> > of Linus. At git hash 879dbe9ffebc, and still the hang is observed.
>=20
> Can you post the blk-mq debugfs log after the hang is triggered?
>=20
> (cd /sys/kernel/debug/block/nvme0n1 && find . -type f -exec grep -aH . {}=
 \;)

Thanks Ming. When I ran the command above, the grep command stopped when it
opened tag related files in the debugfs tree. That grep command looked hank=
ing
also. So I used the find command below instead to exclude the tag related f=
iles.

# find . -type f -not -name *tag* -exec grep -aH . {} \;

Here I share the captured log.

./sched/queued:0 8 0
./sched/owned_by_driver:0 8 0
./sched/async_depth:192
./sched/starved:0
./sched/batching:1
./rqos/wbt/wb_background:4
./rqos/wbt/wb_normal:8
./rqos/wbt/unknown_cnt:0
./rqos/wbt/min_lat_nsec:2000000
./rqos/wbt/inflight:0: inflight 0
./rqos/wbt/inflight:1: inflight 0
./rqos/wbt/inflight:2: inflight 0
./rqos/wbt/id:0
./rqos/wbt/enabled:1
./rqos/wbt/curr_win_nsec:0
./hctx7/type:default
./hctx7/dispatch_busy:7
./hctx7/active:1024
./hctx7/run:5
./hctx7/ctx_map:00000000: 00
./hctx7/dispatch:000000003dfed3fd {.op=3DREAD, .cmd_flags=3D, .rq_flags=3DS=
TARTED|ELVPRIV|IO_STAT|22, .state=3Didle, .tag=3D-1, .internal_tag=3D192}
./hctx7/dispatch:0000000077876d9e {.op=3DREAD, .cmd_flags=3D, .rq_flags=3DS=
TARTED|ELVPRIV|IO_STAT|22, .state=3Didle, .tag=3D-1, .internal_tag=3D193}
./hctx7/flags:alloc_policy=3DFIFO SHOULD_MERGE|TAG_QUEUE_SHARED
./hctx7/state:TAG_ACTIVE|SCHED_RESTART
./hctx6/type:default
./hctx6/dispatch_busy:5
./hctx6/active:1025
./hctx6/run:4
./hctx6/ctx_map:00000000: 00
./hctx6/dispatch:00000000c0b8e1c9 {.op=3DREAD, .cmd_flags=3D, .rq_flags=3DS=
TARTED|ELVPRIV|IO_STAT|22, .state=3Didle, .tag=3D-1, .internal_tag=3D192}
./hctx6/flags:alloc_policy=3DFIFO SHOULD_MERGE|TAG_QUEUE_SHARED
./hctx6/state:TAG_ACTIVE|SCHED_RESTART
./hctx5/type:default
./hctx5/dispatch_busy:5
./hctx5/active:1024
./hctx5/run:4
./hctx5/ctx_map:00000000: 00
./hctx5/dispatch:00000000aaf1e364 {.op=3DREAD, .cmd_flags=3D, .rq_flags=3DS=
TARTED|ELVPRIV|IO_STAT|22, .state=3Didle, .tag=3D-1, .internal_tag=3D128}
./hctx5/flags:alloc_policy=3DFIFO SHOULD_MERGE|TAG_QUEUE_SHARED
./hctx5/state:TAG_ACTIVE|SCHED_RESTART
./hctx4/type:default
./hctx4/dispatch_busy:0
./hctx4/active:1023
./hctx4/run:1
./hctx4/ctx_map:00000000: 00
./hctx4/flags:alloc_policy=3DFIFO SHOULD_MERGE|TAG_QUEUE_SHARED
./hctx3/type:default
./hctx3/dispatch_busy:5
./hctx3/active:1024
./hctx3/run:4
./hctx3/ctx_map:00000000: 00
./hctx3/dispatch:000000008b07d5e1 {.op=3DREAD, .cmd_flags=3D, .rq_flags=3DS=
TARTED|ELVPRIV|IO_STAT|22, .state=3Didle, .tag=3D-1, .internal_tag=3D128}
./hctx3/flags:alloc_policy=3DFIFO SHOULD_MERGE|TAG_QUEUE_SHARED
./hctx3/state:TAG_ACTIVE|SCHED_RESTART
./hctx2/type:default
./hctx2/dispatch_busy:5
./hctx2/active:1024
./hctx2/run:4
./hctx2/ctx_map:00000000: 00
./hctx2/dispatch:00000000c4887013 {.op=3DREAD, .cmd_flags=3D, .rq_flags=3DS=
TARTED|ELVPRIV|IO_STAT|22, .state=3Didle, .tag=3D-1, .internal_tag=3D128}
./hctx2/flags:alloc_policy=3DFIFO SHOULD_MERGE|TAG_QUEUE_SHARED
./hctx2/state:TAG_ACTIVE|SCHED_RESTART
./hctx1/type:default
./hctx1/dispatch_busy:6
./hctx1/active:1024
./hctx1/run:5
./hctx1/ctx_map:00000000: 00
./hctx1/dispatch:00000000efe38e4e {.op=3DREAD, .cmd_flags=3D, .rq_flags=3DS=
TARTED|ELVPRIV|IO_STAT|22, .state=3Didle, .tag=3D-1, .internal_tag=3D0}
./hctx1/flags:alloc_policy=3DFIFO SHOULD_MERGE|TAG_QUEUE_SHARED
./hctx1/state:TAG_ACTIVE|SCHED_RESTART
./hctx0/type:default
./hctx0/dispatch_busy:5
./hctx0/active:1024
./hctx0/run:4
./hctx0/ctx_map:00000000: 00
./hctx0/dispatch:0000000015147095 {.op=3DREAD, .cmd_flags=3D, .rq_flags=3DS=
TARTED|ELVPRIV|IO_STAT|22, .state=3Didle, .tag=3D-1, .internal_tag=3D192}
./hctx0/flags:alloc_policy=3DFIFO SHOULD_MERGE|TAG_QUEUE_SHARED
./hctx0/state:TAG_ACTIVE|SCHED_RESTART
./write_hints:hint0: 0
./write_hints:hint1: 0
./write_hints:hint2: 0
./write_hints:hint3: 0
./write_hints:hint4: 0
./state:SAME_COMP|NONROT|IO_STAT|DISCARD|INIT_DONE|STATS|REGISTERED|PCI_P2P=
DMA|NOWAIT
./pm_only:0
./poll_stat:read  (512 Bytes): samples=3D0
./poll_stat:write (512 Bytes): samples=3D0
./poll_stat:read  (1024 Bytes): samples=3D0
./poll_stat:write (1024 Bytes): samples=3D0
./poll_stat:read  (2048 Bytes): samples=3D0
./poll_stat:write (2048 Bytes): samples=3D0
./poll_stat:read  (4096 Bytes): samples=3D0
./poll_stat:write (4096 Bytes): samples=3D0
./poll_stat:read  (8192 Bytes): samples=3D0
./poll_stat:write (8192 Bytes): samples=3D0
./poll_stat:read  (16384 Bytes): samples=3D0
./poll_stat:write (16384 Bytes): samples=3D0
./poll_stat:read  (32768 Bytes): samples=3D0
./poll_stat:write (32768 Bytes): samples=3D0
./poll_stat:read  (65536 Bytes): samples=3D0
./poll_stat:write (65536 Bytes): samples=3D0


--=20
Best Regards,
Shin'ichiro Kawasaki=
