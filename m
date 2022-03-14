Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA33C433EF
	for <linux-block@archiver.kernel.org>; Mon, 14 Mar 2022 05:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236152AbiCNFZs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Mar 2022 01:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236061AbiCNFZr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Mar 2022 01:25:47 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EEDE26CB
        for <linux-block@vger.kernel.org>; Sun, 13 Mar 2022 22:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1647235478; x=1678771478;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=q3Ic3qdvWga0JOSyHY69/Yf0u97yO+JIWDQuTRSHbLY=;
  b=dRLZkd9LSz+JV7SYs6nZXdkl7tUycbBqYTM8VizsGEOAtMQtlW88pkiQ
   AdBLFR90pTfmNX/IWZrQYM4Y/enHhTsys1UCLDIHUr3hmbM0KujHV6QpH
   efIUdGI+Yf5thZjnuPfQRaHoBi+/xaicdvh6Z/cMtlYvk5CZM/TGxJG+i
   Dr2u/kHzIWUIALW8PVjrL15PvrFwQNYGrWui5gn1QDvhJKmpHzuG2felN
   euIp1dN5wHBuHLntlm7qmU0pk3OeOFKGti+Cgcwxdbj4XYp9KlfY+gVKO
   1t8iJMK93/ri+7X0pya2suNy73hoVRvGfZlFIdLHlYqiHve6Wp6/QFOKT
   g==;
X-IronPort-AV: E=Sophos;i="5.90,179,1643644800"; 
   d="scan'208";a="196214573"
Received: from mail-mw2nam12lp2040.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.40])
  by ob1.hgst.iphmx.com with ESMTP; 14 Mar 2022 13:24:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BkbBBwIf9E2F/HCuZA31Im42rrBggZp2UA77bkWNzAEMHHv2e4GoaiEyFKTe6eKjTCXi0NLsyvbeW9HCMJzVcZcnIHHIZMM9mxf8rndP7V5Wzw9v51zdWOL4Ol0e4UR6DbxKwFe4zHsnlxSmxEqQhLXa6p1GnNhSymP1pntiELtftiZhlvLy9NNrqJNzWKChX0XrD9WMGYcGYZTZfJdmmLAH9Raz7/Lvr+X6nEYc0QeyxiNQEfrVnLyC/+DkQYVU2bPJIsc9W3bmw1iNwkbQWBPTYZ0VsBT4FEphoWU1yiqT2ZZPswhpyZNPjWd9ogds5zFl7FtEeaEru+N8EjY89A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VlS0G+trmm2wNrLn6KT3Xs7zrImXO45fx1i8UTfCTUs=;
 b=jUqxva+RrfO8JToKd/9C7uyQtOHovSVYelGixIIPBdjd4ySp3rP6rtrgeiIr86NEejy4PeuyWniuNx3IDvH01q96ws3jxg8V/VT2edUNH5NJIWG80Nbwzi+JuzpavWEaV00YAU3zyqrWCvAz+aLu57a1spUUZgrMZTGFzHrfV5GPdcKFeNnM0B0XaB8Y6jGU+xAk53Y7nqd3xxEdXLzP2WyATdxnQ5iOrrRtSjVYWAJGmD4NDSM/gg5MBkOHenFngbdxCKG+PWCUTvSXLVqmwwkUGPLrqrsgqu3kKIhMl8c43gPlaA8LgB/Rse2SqgZl9iJree/oE5ytn4Ki5xAp+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlS0G+trmm2wNrLn6KT3Xs7zrImXO45fx1i8UTfCTUs=;
 b=NZ/m8VhONjpzEwuCQ6gRpdp2nbJgtAZeRTQRQpWrfe52NsS5Rupxonk9AkLycGKGBeiY76dFYzM9jQocvEMnB5R6jltHxRsCv4A3tb6rseDLYjD6YiSQ/cSBWaHFZLjHnCxgzMLHNHqc5F3ooEHQTL2cSmZYlMdw168PRQhcqVI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6091.namprd04.prod.outlook.com (2603:10b6:5:130::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5061.21; Mon, 14 Mar 2022 05:24:35 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::954d:a46:a727:c47d]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::954d:a46:a727:c47d%3]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 05:24:34 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [bug report] worker watchdog timeout in dispatch loop for
 null_blk
Thread-Topic: [bug report] worker watchdog timeout in dispatch loop for
 null_blk
Thread-Index: AQHYNF+T3Cwh4555b06Tjj5eYItVAKy4YrkAgAAsjICAAAHeAIABJ3+AgAA5uACABGx7AA==
Date:   Mon, 14 Mar 2022 05:24:34 +0000
Message-ID: <20220314052434.zud5zb5wqrjljk4b@shindev>
References: <20220310091649.zypaem5lkyfadymg@shindev> <YinMWPiuUluinom8@T590>
 <20220310124023.tkax52chul265bus@shindev>
 <a6d6b858-4bee-10da-884c-20b16e4ad0de@kernel.dk>
 <20220311062441.vsa54rie5fxhjtps@shindev> <YisblCKgf6xC0/ai@T590>
In-Reply-To: <YisblCKgf6xC0/ai@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31319bfb-52f2-4898-d554-08da057aed22
x-ms-traffictypediagnostic: DM6PR04MB6091:EE_
x-microsoft-antispam-prvs: <DM6PR04MB6091FCBC0F8DEA6F1163B981ED0F9@DM6PR04MB6091.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P2UwIY18UqmjUQ31wloG1zPhkouSxlnaljwNWxm9n0LmOUIaNYa42MZScUMvfXUn4oARDKvYwq0JdkTNNNv0PmWuHrbWCbIUnaEWhyDtXYO5gPgX41H64Hgh5c/gom5zU3WMphc4ZE0qB3XWsI8F8dzNVceqVJsVU8VX7+GkAVIJbsSrZA+Z1h7rLiXEIT/pzrzRNlpHmsFnQ4ceepzPMLFFDknYGoOM0pvpEYyZ3C0ovKZJUPxNfSgPAMvDBNPPU/hlgF5WJM7JWyw7DILLbV8wVpqDf/R3fWeqnzLfgg++gkVEDDczdD/k9yY83ZbSS/W4fmMcdnaJTfe0tSX6NY6dfJUXKMslYiXW6/IzGl6Hc+IpyQZ1N/nJg02WJ2MKq1VMgygwwRXlA8qzSQjnOqcZdB3KqWiFBSBmb5bty7L4xyJ0cOh2C94dRX8qz/Q5qEuNQy+ZlbgACP3ZUhnzky5bCkQqff1JWcW/out/WGWvi5Uxt7yB5sGGOYphcWRhLd67s2o5OIniueXUs5BAUhy8zvw9Spo5xi33Oan5vrZ23zy8b0VqBr3XctKjE1IxAXthZwVMmweTTed7qjTS8Qf6q1GHpq1Mp7r1fUThxQS3FoTmIB89A33MifUBeBWv0xudDXbJylxhkT83PHVL+amx/u+3C7ecTAacBT1A74AgRwqfP6boNyB/5sBv/Pa1aPL6l4J6Q1u5EXIQpukudIetDSWtKrytsQ+3/jMhmY4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(5660300002)(6512007)(9686003)(44832011)(2906002)(83380400001)(122000001)(33716001)(66446008)(71200400001)(8936002)(38070700005)(66476007)(66556008)(4326008)(64756008)(82960400001)(26005)(76116006)(186003)(8676002)(53546011)(66946007)(38100700002)(86362001)(6506007)(91956017)(316002)(6916009)(1076003)(6486002)(54906003)(508600001)(309714004);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?z+PNNJiCpfUF7RjS96NRHSjZHFgDMb6ENLjrNJUerdlsNxNNAdsqctfCUrOL?=
 =?us-ascii?Q?HJ2Du9Y6XlX4/v5D14CtJLskvkQUdmf7gzP2Q+J5PFFMEYRtUNNuOZW8Im1X?=
 =?us-ascii?Q?3SU/JGV8zy1mbUcQkUlkBSI1IGGN3E0ZyMarZaG8poR33QDBTVMfiNFyJd1N?=
 =?us-ascii?Q?rf7Lr86J2afUrbsVFTT/TG3+CE0/zXVLMIShVfdCNeiDF92d4JLl3yqL7ZiS?=
 =?us-ascii?Q?Ib02DcEjQCXh3D9X3MLLJuCu5c2iW7tI4/nlei1nKKJpWtgSab5IVzQKzBV+?=
 =?us-ascii?Q?CRy6tc0KQY1aZYq7Mdzxr/MIDl/7TjxmvRT/wa0Q6ALUpT2NdFvbhFXjCN+J?=
 =?us-ascii?Q?ZqAfVuoVD77qt3ocdzsGw7/BWfbFmvKPxKcaw4UsvgZF8iw5ecQ1jijVv9O1?=
 =?us-ascii?Q?IifhGpl1KcMyJH7MyVo+pkuqkxm3QJf9Xuj7hhToMFP7V/1DDzEoJe1gCo8x?=
 =?us-ascii?Q?xKCSydspaNJFfJT+m3PY7vLdnVjRqoSd7xJFTpj51yooH7KtYmBdNicw9AnG?=
 =?us-ascii?Q?6EAYLWPUfZ4QRZWpszHAZZi80/hQxlOhqQ7giblv44LgvMdMDEpDF/jqecPI?=
 =?us-ascii?Q?pMHFKjTOoTXS6CEYta1os8XyOypUgr9CSsisVhxNYa4Q8v7VfB1G4PNyOo55?=
 =?us-ascii?Q?mvOsIVqdT/ew+LNT573heLHoGXWHT96HBy7zlh1UBJAiojGyZTswhR2dlUuy?=
 =?us-ascii?Q?RAYUFDBIN9lxvpRZOKwHqX4UW7VsxllXPrMDg8mJ0jKiR6624JCrVTCQHbSR?=
 =?us-ascii?Q?dXmBUnsFwAc0GLG0E48v9cfcCL43vE+q5+mk4B5WoXqYJo2Ol7uwJfeThxpg?=
 =?us-ascii?Q?E3NOG5uzt9XP3y+H1Bt2EIDrTmkjWCH2Oi9iNpadAT5Oo2Z30h1Rc34CDaiy?=
 =?us-ascii?Q?GBsKdp6RumAWyr0gq8dvMAdXt9wXWgBGtEi9+v856Bx50yFW1R9RicHk2N3l?=
 =?us-ascii?Q?Rpelm3f1tSm9AA//1r38r2GvhX3Ykw9RoOipfdeCDo3LiFDwvaOI/bzXAUUp?=
 =?us-ascii?Q?FqHh1P4xkAut5g7juAQ9WbYv3ayWr9Dc71nYRDowJ+QcSnowcEjxVX/UmHA6?=
 =?us-ascii?Q?gCwWzBWpq4lorUhjSEd1bfIbHWabeinRC7lIGSzrFS/j1r5cgGFtbl2kXCD2?=
 =?us-ascii?Q?lCz6LU22cJOmXoZNg1mmaoJgytCT0Y6KDzLMQIGeJzRaxSp5/ZpxRceyyBbP?=
 =?us-ascii?Q?tg3oSv8esQ/aFszEGEHCp+BQWFESrOA36gYjQSigq7WEORZ5WZ+nEYpCdOIX?=
 =?us-ascii?Q?/u/UQ5VE9LjpCrQG+/btcrjmhavlqVN5x7s2xVQ/7Gcp8nforvwtbe6RojPM?=
 =?us-ascii?Q?mfr3IdxfXcGy3bvbc9DFuyq0snhWDQpzP9dzuRaTZH5r9XfDVqF46xBzo/wF?=
 =?us-ascii?Q?//n6gptXgPUjpCx8A+q/tajCzmOGpMM7mrZ0HCk3oK0MJNAVr57qP422xR34?=
 =?us-ascii?Q?VUBB6qN+ei/gHa0gbQvluUQqoMgQ3rjybuWZcbcum410q6q2uWc5R+yayCAH?=
 =?us-ascii?Q?FUmQ0nylMtzTRac=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <311926B859CD3049AE6B7C1966CFFE7E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31319bfb-52f2-4898-d554-08da057aed22
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 05:24:34.7885
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +8Ps86hvboy4TMxJFh0wTZR0QwUxxPSluXWoH4mdo0hve589exPGde9jVwUPc8TYb8Y+ojkHwjcLXZ1qNfjY/A6A5JWYylimkvq5qzw/cjs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6091
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mar 11, 2022 / 17:51, Ming Lei wrote:
> On Fri, Mar 11, 2022 at 06:24:41AM +0000, Shinichiro Kawasaki wrote:
> > On Mar 10, 2022 / 05:47, Jens Axboe wrote:
> > > On 3/10/22 5:40 AM, Shinichiro Kawasaki wrote:
> > > > On Mar 10, 2022 / 18:00, Ming Lei wrote:
> > > >> On Thu, Mar 10, 2022 at 09:16:50AM +0000, Shinichiro Kawasaki wrot=
e:
> > > >>> This issue does not look critical, but let me share it to ask com=
ments for fix.
> > > >>>
> > > >>> When fio command with 40 jobs [1] is run for a null_blk device wi=
th memory
> > > >>> backing and mq-deadline scheduler, kernel reports a BUG message [=
2]. The
> > > >>> workqueue watchdog reports that kblockd blk_mq_run_work_fn keeps =
on running
> > > >>> more than 30 seconds and other work can not run. The 40 fio jobs =
keep on
> > > >>> creating many read requests to a single null_blk device, then the=
 every time
> > > >>> the mq_run task calls __blk_mq_do_dispatch_sched(), it returns re=
t =3D=3D 1 which
> > > >>> means more than one request was dispatched. Hence, the while loop=
 in
> > > >>> blk_mq_do_dispatch_sched() does not break.
> > > >>>
> > > >>> static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > > >>> {
> > > >>>         int ret;
> > > >>>
> > > >>>         do {
> > > >>>                ret =3D __blk_mq_do_dispatch_sched(hctx);
> > > >>>         } while (ret =3D=3D 1);
> > > >>>
> > > >>>         return ret;
> > > >>> }
> > > >>>
> > > >>> The BUG message was observed when I ran blktests block/005 with v=
arious
> > > >>> conditions on a system with 40 CPUs. It was observed with kernel =
version
> > > >>> v5.16-rc1 through v5.17-rc7. The trigger commit was 0a593fbbc245 =
("null_blk:
> > > >>> poll queue support"). This commit added blk_mq_ops.map_queues cal=
lback. I
> > > >>> guess it changed dispatch behavior for null_blk devices and trigg=
ered the
> > > >>> BUG message.
> > > >>
> > > >> It is one blk-mq soft lockup issue in dispatch side, and shouldn't=
 be related
> > > >> with 0a593fbbc245.
> > > >>
> > > >> If queueing requests is faster than dispatching, the issue will be=
 triggered
> > > >> sooner or later, especially easy to trigger in SQ device. I am sur=
e it can
> > > >> be triggered on scsi debug, even saw such report on ahci.
> > > >=20
> > > > Thank you for the comments. Then this is the real problem.
> > > >=20
> > > >>
> > > >>>
> > > >>> I'm not so sure if we really need to fix this issue. It does not =
seem the real
> > > >>> world problem since it is observed only with null_blk. The real b=
lock devices
> > > >>> have slower IO operation then the dispatch should stop sooner whe=
n the hardware
> > > >>> queue gets full. Also the 40 jobs for single device is not realis=
tic workload.
> > > >>>
> > > >>> Having said that, it does not feel right that other works are pen=
ded during
> > > >>> dispatch for null_blk devices. To avoid the BUG message, I can th=
ink of two
> > > >>> fix approaches. First one is to break the while loop in blk_mq_do=
_dispatch_sched
> > > >>> using a loop counter [3] (or jiffies timeout check).
> > > >>
> > > >> This way could work, but the queue need to be re-run after breakin=
g
> > > >> caused by max dispatch number. cond_resched() might be the simples=
t way,
> > > >> but it can't be used here because of rcu/srcu read lock.
> > > >=20
> > > > As far as I understand, blk_mq_run_work_fn() should return after th=
e loop break
> > > > to yield the worker to other works. How about to call
> > > > blk_mq_delay_run_hw_queue() at the loop break? Does this re-run the=
 dispatch?
> > > >=20
> > > >=20
> > > > diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
> > > > index 55488ba978232..faa29448a72a0 100644
> > > > --- a/block/blk-mq-sched.c
> > > > +++ b/block/blk-mq-sched.c
> > > > @@ -178,13 +178,19 @@ static int __blk_mq_do_dispatch_sched(struct =
blk_mq_hw_ctx *hctx)
> > > >  	return !!dispatched;
> > > >  }
> > > > =20
> > > > +#define MQ_DISPATCH_MAX 0x10000
> > > > +
> > > >  static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > > >  {
> > > >  	int ret;
> > > > +	unsigned int count =3D MQ_DISPATCH_MAX;
> > > > =20
> > > >  	do {
> > > >  		ret =3D __blk_mq_do_dispatch_sched(hctx);
> > > > -	} while (ret =3D=3D 1);
> > > > +	} while (ret =3D=3D 1 && count--);
> > > > +
> > > > +	if (ret =3D=3D 1 && !count)
> > > > +		blk_mq_delay_run_hw_queue(hctx, 0);
> > > > =20
> > > >  	return ret;
> > > >  }
> > >=20
> > > Why not just gate it on needing to reschedule, rather than some rando=
m
> > > value?
> > >=20
> > > static int blk_mq_do_dispatch_sched(struct blk_mq_hw_ctx *hctx)
> > > {
> > > 	int ret;
> > >=20
> > > 	do {
> > > 		ret =3D __blk_mq_do_dispatch_sched(hctx);
> > > 	} while (ret =3D=3D 1 && !need_resched());
> > >=20
> > > 	if (ret =3D=3D 1 && need_resched())
> > > 		blk_mq_delay_run_hw_queue(hctx, 0);
> > >=20
> > > 	return ret;
> > > }
> > >=20
> > > or something like that.
> >=20
> > Jens, thanks for the idea, but need_resched() check does not look worki=
ng here.
> > I tried the code above but still the BUG message is observed. My guess =
is that
> > in the call stack below, every __blk_mq_do_dispatch_sched() call result=
s in
> > might_sleep_if() call, then need_resched() does not work as expected, p=
robably.
> >=20
> > __blk_mq_do_dispatch_sched
> >   blk_mq_dispatch_rq_list
> >     q->mq_ops->queue_rq
> >       null_queue_rq
> >         might_sleep_if
> >=20
> > Now I'm trying to find similar way as need_resched() to avoid the rando=
m number.
> > So far I haven't found good idea yet.
>=20
> Jens patch using need_resched() looks improving the situation, also the
> scsi_debug case won't set BLOCKING:
>=20
> 1) without the patch, it can be easy to trigger lockup with the
> following test.
>=20
> - modprobe scsi_debug virtual_gb=3D128 delay=3D0 dev_size_mb=3D2048
> - fio --bs=3D512k --ioengine=3Dsync --iodepth=3D128 --numjobs=3D4 --rw=3D=
randrw \
> 	--name=3Dsdc-sync-randrw-512k --filename=3D/dev/sdc --direct=3D1 --size=
=3D60G --runtime=3D120
>=20
> #sdc is the created scsi_debug disk

Thanks. I tried the work load above and observed the lockup BUG message on =
my
system. So, I reconfirmed that the problem happens with both BLOCKING and
non-BLOCKING drivers.

Regarding the solution, I can not think of any good one. I tried to remove =
the
WQ_HIGHPRI flag from kblockd_workqueue, but it did not look affecting
need_resched() behavior. I walked through workqueue API, but was not able
to find anything useful.

As far as I understand, it is assumed and expected the each work item gets
completed within decent time. Then this blk_mq_run_work_fn must stop within
decent time by breaking the loop at some point. As the loop break condition=
s
other than need_resched(), I can think of 1) loop count, 2) number of reque=
sts
dispatched or 3) time spent in the loop. All of the three require a magic r=
andom
number as the limit... Is there any other better way?

If we need to choose one of the 3 options, I think '3) time spent in the lo=
op'
is better than others, since workqueue watchdog monitors _time_ to check lo=
ckup
and report the BUG message.

--=20
Best Regards,
Shin'ichiro Kawasaki=
