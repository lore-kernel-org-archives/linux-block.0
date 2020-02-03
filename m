Return-Path: <SRS0=KNqY=3X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 848D8C35247
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 15:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F0882080C
	for <linux-block@archiver.kernel.org>; Mon,  3 Feb 2020 15:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="G46blJVp";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="L+luIM4O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgBCPGx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Feb 2020 10:06:53 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:33821 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbgBCPGx (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Feb 2020 10:06:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580742413; x=1612278413;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Gw5MsvHBuK3Nm+V5fajpoUGtCpq9AcqvRE18R3ORbLk=;
  b=G46blJVpCiy3uN/3rciBWx1zysKy3nvCCrI1P5yQs+/QeF3c5zx7JreD
   ArWrOekam94bosaplnzj7UEELnZH4ZHTxzQiGpEzCMmQ5DZgUP2ycIXSN
   sGldmDaOhUCUsdKEcsrWXaXytAOkHeq9nm0XnSQzhgqxxQ6Ki1RTWVIDR
   d6SS66nsAWsGT8n1EGtgdV8WI42PljryuMt54N1vJx/vwoTm5UqUveDNf
   fewVLDPKqyjB/w3YlUq9Ad0Afaw5L65EL+qWOYlyYy28hyNmk1GwOjfAu
   tVBiBBKeoMyD30bmy8sPtIHPjaeBNM5B7xTnBDma2o8UHgsByoaklwlPg
   Q==;
IronPort-SDR: vDhilGK5ct0qDlBHJy+3SP+uj0664bOWwf+lhzqbjI57PlCEha7p6ds0j0Xfp0Xg7TQxnLz3RX
 d64pDv7uQM9eP09ndIwWcsQ7QroTxX683ihp0C/+U1d/LFzG9wM9KK2kKeBfnZotxtYTgJ0NXc
 1u4dhYmr2+fzhML9CmUZ5T6959/d17H+kAmcQFpDmzKinduFXL+bXHqZoOI8LIRl6uTKPuj1i9
 EU6XqTJyYqjEDUpAZdbmZrEbVS21FxZtiDHC7DzEbGK3Cq2JBu7Orxbbn+Run/e4UAxyzJedW8
 p/U=
X-IronPort-AV: E=Sophos;i="5.70,398,1574092800"; 
   d="scan'208";a="129535854"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2020 23:06:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q27Yt+t0wQ4g/PBW7UabpOQhRDy2+oAcuQXqUQE5aWjQKLZFNAVcfOJpKEqCbSB1DBLde/2G+KJ/mNlXrJJ1lxv2tMGno0jaFuvLHpVO+6iLC7RuOn7nGHVsD8c8OnU9A/AXStn0EDw6kVRfkUaNQt+/D6AD0kYJK1ziMogs2J5TZOyWsIuTQbXghh6xDYTIoMVCs4PV84OdciWJhQBrzDVK7ja696WhGChBFuwvY2KFBftXNFOclE6Hfv374d+c8lBrKSn3s4rgymFW4ZwwEjEsXtZrETBHifTYZd4qt4K7tIV3PPl0mA9DN8qPLTZjlyxda1+lADbtEeYHaXi9ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gw5MsvHBuK3Nm+V5fajpoUGtCpq9AcqvRE18R3ORbLk=;
 b=ZmgAoIi0uVKhV5x2FfVCXAva+cFBZA/ljSDz9VhWYkl8xYvzNBqpHs8IseU/4a2ro1F1YnTakvdHf8iW52YXd3WehO9FUnBEUsOXRfZ/Hqp3DqC9oT5UAUXYaxbZpVXpmJAfTt7zyf1bCEdpe7HO2CwqF5Z9q8oEVh7WbB9l/WAd89fDSRTxegr4bHPDx589/4W6Sjrw5wk10Q5wSBSi+x7jus0U+9l1fKOiijBs+xjGRCZ8Xi9WDbCX4p38dPitxRBtx1sZCW3URCJo/zUR2U9gbiM7KQB3DLJUdO/EngiMgQY90YJGrMcqiQl3pJYvoHMJ1gURFfwVFGkCAoyKyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gw5MsvHBuK3Nm+V5fajpoUGtCpq9AcqvRE18R3ORbLk=;
 b=L+luIM4OVCd9GthpRiuva35AJoCWCaSje9wpVOUbgLquBNBaoW16obbO7dMlKRE9uIwwh4ERyJq2LaMync72jrhzMGBBG1eWJtA3YzCA4LMAZ+WGD0/QblCbrQ9MXICxE5LXSHsXlsKaBJuQAcAUpejF3OxubwT5Gfg/SVJI17Y=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB5926.namprd04.prod.outlook.com (20.179.59.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.26; Mon, 3 Feb 2020 15:06:24 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2686.028; Mon, 3 Feb 2020
 15:06:24 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bob Liu <bob.liu@oracle.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        Dmitry Fomichev <Dmitry.Fomichev@wdc.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [RFC PATCH] dm-zoned: extend the way of exposing zoned block
 device
Thread-Topic: [RFC PATCH] dm-zoned: extend the way of exposing zoned block
 device
Thread-Index: AQHVxfMPtnSx9ygQV0yw4PguyV00/g==
Date:   Mon, 3 Feb 2020 15:06:16 +0000
Message-ID: <BYAPR04MB5816B2967735225FB37D627BE7000@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20200108071212.27230-1-Nobody@nobody.com>
 <BYAPR04MB5816BA749332D2FC6CE3993AE73E0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <c4ba178c-f5cf-4dd1-784b-e372d6b09f62@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0aff8644-61d6-4d15-e945-08d7a8baa286
x-ms-traffictypediagnostic: BYAPR04MB5926:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB592608C940F0193A1A98545DE7000@BYAPR04MB5926.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0302D4F392
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(189003)(199004)(478600001)(7696005)(33656002)(4326008)(186003)(81156014)(8676002)(26005)(5660300002)(53546011)(6506007)(6666004)(71200400001)(2906002)(52536014)(81166006)(110136005)(54906003)(91956017)(76116006)(55016002)(8936002)(66946007)(316002)(86362001)(9686003)(64756008)(66556008)(66476007)(66446008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5926;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MPj1YlpEHmTX06juDD074v6ytP+Uz/IBaO/BgLjJ3KlKQq2zSMTqCLQ+lKezwBpabbGA1iicgOqX9JMKSYrK9ztiykhJUPbK8hbK4CG9CHig/0ogYk1Y6obpKYIZqLnjyvT/zM/EBJkTwOVZSduTTtph/hIv1K4ZyzCMgH+//InJnIahtcJ7oShhQkjC9JvDZQQbCH/KYQpiTGFoIrt+UhU/eoqcbvcOpa8c90W5cWbinzuYKmw5PGrArXvkw7f5MJUOjXhDft4LYiqsFS2Ayty0gjlpLYrhCAz0T0uqb8rCdn4Gk2SkjhunLI7xSXwZ5pTy2No8Kf0HISZlTxRksh/c6Ygk6WiKyf0iUkXZWIXdgupTn4rzl7tbPSjzFIP4Clp+HesakhCTWVhvMmpcHOVmzG0PE9v9XEx/U9qXL06ykU6Pia8F/us2XK4PETm/
x-ms-exchange-antispam-messagedata: LOAdozyFNR102piNLsaS7pI5puZr5DAh3tYJ16oL22mE4VMWdtmg6iQ9a0tPuagicF+5cCxQpQeeUVn3ntOzRTFkhwCIGiw7IHYTDj4Ua7fKKvFcmaIiVE/kvBQsZknj9Dd2ngjujq1DkYd2bMZteg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aff8644-61d6-4d15-e945-08d7a8baa286
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2020 15:06:16.8888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CWhKnZxok2kb81Oy/N3S55Lfe9irAZ90MWb+uHyP6YVq/7MwvyS3uIyj1/cmBnGtVD7b3aYZVmcf6WynVaWtZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5926
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/02/03 21:47, Bob Liu wrote:=0A=
> On 1/8/20 3:40 PM, Damien Le Moal wrote:=0A=
>> On 2020/01/08 16:13, Nobody wrote:=0A=
>>> From: Bob Liu <bob.liu@oracle.com>=0A=
>>>=0A=
>>> Motivation:=0A=
>>> Now the dm-zoned device mapper target exposes a zoned block device(ZBC)=
 as a=0A=
>>> regular block device by storing metadata and buffering random writes in=
=0A=
>>> conventional zones.=0A=
>>> This way is not very flexible, there must be enough conventional zones =
and the=0A=
>>> performance may be constrained.=0A=
>>> By putting metadata(also buffering random writes) in separated device w=
e can get=0A=
>>> more flexibility and potential performance improvement e.g by storing m=
etadata=0A=
>>> in faster device like persistent memory.=0A=
>>>=0A=
>>> This patch try to split the metadata of dm-zoned to an extra block=0A=
>>> device instead of zoned block device itself.=0A=
>>> (Buffering random writes also in the todo list.)=0A=
>>>=0A=
>>> Patch is at the very early stage, just want to receive some feedback ab=
out=0A=
>>> this extension.=0A=
>>> Another option is to create an new md-zoned device with separated metad=
ata=0A=
>>> device based on md framework.=0A=
>>=0A=
>> For metadata only, it should not be hard at all to move to another=0A=
>> conventional zone device. It will however be a little more tricky for=0A=
>> conventional zones used for data since dm-zoned assumes that this random=
=0A=
>> write space is also zoned. Moving this space to a conventional device=0A=
>> requires implementing a zone emulation (fake zones) for the regular=0A=
>> drive, using a zone size that matches the size of sequential zones.=0A=
>>=0A=
>> Beyond this, dm-zoned also needs to be changed to accept partial drives=
=0A=
>> and the dm core code to accept mixing of regular and zoned disks (that=
=0A=
>> is forbidden now).=0A=
>>=0A=
>> Another approach worth exploring is stacking dm-zoned as is on top of a=
=0A=
>> modified dm-linear with the ability to emulate conventional zones on top=
=0A=
>> of a regular block device (you only need report zones method=0A=
>> implemented). =0A=
> =0A=
> Looks like the only way to do this emulation is in user space tool(dm-zon=
ed-tools).=0A=
> Write metadata(which contains emulated zone information constructed by dm=
-zoned-tools)=0A=
> into regular block device.=0A=
=0A=
User space tool will indeed need some modifications to allow the new=0A=
format. But I would not put this as "doing the emulation" since at that=0A=
level, zones are only an information checked for alignment of metadata=0A=
space and overall capacity of the target. With a regular disk holding the=
=0A=
metadata, all that needs to be done is assume that this drive is ion fact=
=0A=
composed solely of conventional zones with the same size as the larger SRM=
=0A=
disk backend. The total set of zones "assumed" + "real zones from SMR"=0A=
consitute the set of zones that dmzadm will work with for determining the=
=0A=
overall format, while currently it only uses the set of real zones.=0A=
=0A=
> It's impossible to add code to every regular block device for emulating c=
onventional zones. =0A=
=0A=
There is no need to do that. dm-zoned can emulate fake conventional zones=
=0A=
for the regular device (disk or ssd) holding the metadata. Since=0A=
conventional zones do not have any IO restriction nor do they need any zone=
=0A=
management command (no zone reset), dm-zoned only needs to create a set of=
=0A=
struct dm_zone for the emulated zones of the regular disk and "manually"=0A=
fill the zone information. This initialization is done in dmz_init_zones().=
=0A=
Some changes there to create these struct dm_zone and all the remaining=0A=
metadata and write buffering code should not need any change at all (modulo=
=0A=
the different bdev reference). Do you see the idea ?=0A=
=0A=
The only place that will need some care is sync processing as 2 devices=0A=
will need to be issued flushes instead of one. The reference to the=0A=
different bdev depending on the zone being accessed will need some care in=
=0A=
many places too, including reclaim. But dm-kcopy being used there, this=0A=
should be fairly easy.=0A=
=0A=
Adding a bdevid (an index) field to struct dm_zone, together with an array=
=0A=
of bdev pointers in struct dmz_dev, should do the trick to simplify=0A=
zone-to-bdev or block-to-bdev conversions (helper functions needed for that=
).=0A=
=0A=
Thoughts ?=0A=
=0A=
> =0A=
> Thanks,=0A=
> Bob=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
