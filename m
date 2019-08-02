Return-Path: <SRS0=5K92=V6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008F8C433FF
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 01:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A66552080C
	for <linux-block@archiver.kernel.org>; Fri,  2 Aug 2019 01:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="f7WbR+Ui";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mxuGTpRy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390600AbfHBBFZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Aug 2019 21:05:25 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:11320 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388659AbfHBBFZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Aug 2019 21:05:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564707925; x=1596243925;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=DPNUp3wP8iSAnme59B9J3F/k1MslOMv8bGjOzHBwCkk=;
  b=f7WbR+UiorqwNjcwHbXJoGglnxEU3fVOS13galha6MnAs5RvHplfvwVG
   z0PcbkRMhWsTYwF5u46m4ggn+QNI6G0PkqfksRdtFRRoU7c6cp5veeJka
   GPDrTZsGCGIq8RJ2JSQ1vAiq3dEJZIOQcJCgYUjxSObUi0a42aocvqL90
   wpKZ4T4HUAAVugnEQW7Jc2u0OkwaU9e2mn7TmXhf3yDbUK4L2TOs5ayyJ
   13oyFKTTb5rceT8c2hxJ0MskFi1nrCwWg/ktRiqnvYhmto0ZezR/xkEJN
   k1Cab7U2d7JYxQSvUCxOw6jMtsUxh71WwdiSusJogbHcAEyoMXuRA3SWc
   Q==;
IronPort-SDR: OscYp7mNKiQnr1dShgubNuPQOwPGn41E4afAo5v2lEGfOUAWY6ykzkBNB7Cbk9LyKaTHMTBVhK
 dr1nFN1yjKxrids2N8weqoTOalKbgdsb5+w9VM93aMw4P285j/FicDQ6DLUFt7wkIy6pYnElGn
 cGFBClWQRK1kwnlPRLbwYxG5CkorWXxQ2035Q5TeJV+MPVBc+ZXVtkpISeoH5Y20k4aj8Qoa3k
 C+Kt9Ep0gxFHwdap0xpvrPgFrgEIK6cm3HlMFBltsJHev9QUt7qZWqd3+p8q4eroegn47dzTiL
 MiM=
X-IronPort-AV: E=Sophos;i="5.64,336,1559491200"; 
   d="scan'208";a="114757713"
Received: from mail-dm3nam05lp2052.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.52])
  by ob1.hgst.iphmx.com with ESMTP; 02 Aug 2019 09:05:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WLbT+wE0sbLdJn30G2CnhMz/iXje1lDGhO2TcHj+gPWTfX++JijZPjl/gGydct6k1VhGkDIpx8cD3YRthpl9yADpw2KjfVXKV5W+m0TfYIp1LMP32r84H12LeFxNNW9Uck+FGbY4hPLc5iRtOevI/CF3a6xZN7uWncJ+QrGI1AuTfFL7QoQlw3skJdpru+vSUOICc/CaB6rsSbzmL9KriPq9MpPNu86TaWUrUDlUlziGZF8iOAkGR8TkwDKW3Bvx6AulOqxgWAl9wCIh2qUVUwDBBG0Q4x+3iPNdk8zwfOSOi29Mjw7SkrBpWNCMdL6TowK8Ljr7UoKsbWHsSADmCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPNUp3wP8iSAnme59B9J3F/k1MslOMv8bGjOzHBwCkk=;
 b=HgEU2liiYLYBRpU4HwD1SQnNcGCDeqsotAZS4AffD3z9/MUyCpYlIZKwmP5/KL6UghP7onhUdIOy366QUR0prgdTkTZwIC4ze1NoLWIi9FU5GfjsKhlLd197eJnLsbDdsQrTbYZyPqg89JtyMXjO+4PibK6RQc5nZuboVGYqTvjtGN/wFzOaCRsE11swqJLrtXNuW0VEhEhz39zut+dcmyslkwzfYcxkfXTdVIBrPsPKsEH+K7y1owjvIT4VCgMSsxVctjpc23jBEer+zIU0C6SvXvhyfc0z5QhDfRxozJFHSPI7eenKhFBGyVZ0JudTz/ekgjc74joKQcBV5+SKBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DPNUp3wP8iSAnme59B9J3F/k1MslOMv8bGjOzHBwCkk=;
 b=mxuGTpRyfM0xKQOqpClDHP0FW7OP4ObBPOC455zZ5dlMZGks+qX+ZI9Eyse6c+o1+RqvtrcZgFU5wZXD7TbrJl3qQDp+cW/iEIEGURSFgFSza6sa85Vak7vVq2dXST93qkEee9IO5EDA0y0OdFvwjmo5vYixiwJGCSipq7ViYFw=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4103.namprd04.prod.outlook.com (52.135.216.10) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Fri, 2 Aug 2019 01:05:20 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2136.010; Fri, 2 Aug 2019
 01:05:20 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Masato Suzuki <masato.suzuki@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] block: Fix __blkdev_direct_IO()
Thread-Topic: [PATCH] block: Fix __blkdev_direct_IO()
Thread-Index: AQHVSFLzGnfcCVN4LE65o4/UfXYJWQ==
Date:   Fri, 2 Aug 2019 01:05:19 +0000
Message-ID: <BYAPR04MB581699C381CE35C34DE45EBCE7D90@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190801102151.7846-1-damien.lemoal@wdc.com>
 <19115dcc-8a4b-8bb7-f8db-e2474196a5d0@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1297a95-dded-42fd-01d5-08d716e57d3a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4103;
x-ms-traffictypediagnostic: BYAPR04MB4103:
x-microsoft-antispam-prvs: <BYAPR04MB4103DF82E4E77F68C0528A16E7D90@BYAPR04MB4103.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 011787B9DD
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(396003)(346002)(136003)(39860400002)(199004)(189003)(33656002)(476003)(305945005)(74316002)(446003)(2501003)(4326008)(66066001)(316002)(478600001)(186003)(68736007)(14454004)(486006)(3846002)(7696005)(7736002)(110136005)(76176011)(53936002)(71190400001)(53546011)(2906002)(81156014)(8676002)(5660300002)(8936002)(26005)(66946007)(66476007)(6246003)(86362001)(55016002)(6506007)(229853002)(102836004)(66556008)(25786009)(64756008)(6436002)(14444005)(81166006)(71200400001)(54906003)(91956017)(76116006)(52536014)(6116002)(256004)(66446008)(9686003)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4103;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: S8iIK2tGXFcJUBWhmlVZMgfdKakfDTpAXAV2BeII+cK0I1RalA9eIHId19FzzCGqoDzi0NoSdfipS6x43esocZQXmVz2t1sof0KmxLNpiLAkfZBmWGtnq9j6q5vx8mYxT/472pEb3w2IqEtvcuPFHrdRDz6f1TZSt7xVrmJaucr+nVg1iDP8oBaeRMH3dmpz9IFFRvIKRG5UitJpAwAVkO+tzvxuApCwNuD8zXDMU+7Y4kD4biF+igWyIfdKrE7HiTeuVacXUEFR60W5i6CKAJHBV+RoBGySgxLYTs+crjIh/qJeiJed/NUcO1MHpFcSYqNbWw2G7t7t4FVppnSmmOOkGZKFQVG9mwpUOb+Z6sqXUqZ5gI+lLi4RzTRxMQLCfa1C5lat3gaCUOinZvt8kejJFQhRJ1thSyBfYe1zy4M=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1297a95-dded-42fd-01d5-08d716e57d3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2019 01:05:19.8621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4103
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/08/02 4:51, Jens Axboe wrote:=0A=
> On 8/1/19 4:21 AM, Damien Le Moal wrote:=0A=
>> The recent fix to properly handle IOCB_NOWAIT for async O_DIRECT IO=0A=
>> (patch 6a43074e2f46) introduced two problems with BIO fragment handling=
=0A=
>> for direct IOs:=0A=
>> 1) The dio size processed is claculated by incrementing the ret variable=
=0A=
>> by the size of the bio fragment issued for the dio. However, this size=
=0A=
>> is obtained directly from bio->bi_iter.bi_size AFTER the bio submission=
=0A=
>> which may result in referencing the bi_size value after the bio=0A=
>> completed, resulting in an incorrect value use.=0A=
>> 2) The ret variable is not incremented by the size of the last bio=0A=
>> fragment issued for the bio, leading to an invalid IO size being=0A=
>> returned to the user.=0A=
>>=0A=
>> Fix both problem by using dio->size (which is incremented before the bio=
=0A=
>> submission) to update the value of ret after bio submissions, including=
=0A=
>> for the last bio fragment issued.=0A=
> =0A=
> Thanks, applied. Do you have a test case? I ran this through the usual=0A=
> xfstests and block bits, but didn't catch anything.=0A=
> =0A=
=0A=
The problem was detected with our weekly RC test runs for zoned block devic=
es.=0A=
RC1 last week was OK, but failures happen on RC2 Monday. We never hit a oop=
s for=0A=
the BIO reference after submission but we were getting a lot of unaligned w=
rite=0A=
errors for all types of zoned drive tested (real SMR disks, tcmu-runner ZBC=
=0A=
handler disks and nullblk in zoned mode) using various applications (fio, d=
d, ...)=0A=
=0A=
Masato isolated the problem to very large direct writes and could reliably=
=0A=
recreate the problem with a dd doing a single 8MB write to a sequential zon=
e.=0A=
With this case, blktrace showed that the 8MB write was split into multiple =
BIOs=0A=
(expected) and the whole 8MB being cleanly written sequentially. But this w=
as=0A=
followed by a stream of small 4K writes starting around the end of the 8MB=
=0A=
chunk, but within it, causing unaligned write errors (overwrite in sequenti=
al=0A=
zones not being possible).=0A=
=0A=
dd if=3D/dev/zero of=3D/dev/nullb0 bs=3D8M oflag=3Ddirect count=3D1=0A=
=0A=
On a nullblk disk in zoned mode should recreate the problem, and blktrace=
=0A=
revealing that dd sees a short write for the 8M IO and issues remaining as =
4K=0A=
requests.=0A=
=0A=
Using a regular disk, this however does not generate any error at all, whic=
h may=0A=
explain why you did not see any problem. I think we can create a blktest ca=
se=0A=
for this using nullblk in zoned mode. Would you like us to send one ?=0A=
=0A=
Best regards.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
