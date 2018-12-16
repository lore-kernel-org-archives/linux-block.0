Return-Path: <SRS0=nu7S=OZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A05C43387
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 23:54:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26FAB2084A
	for <linux-block@archiver.kernel.org>; Sun, 16 Dec 2018 23:54:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DaI6tTiq";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="PHRpkWq5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbeLPXyR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 16 Dec 2018 18:54:17 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:62439 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730719AbeLPXyR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 16 Dec 2018 18:54:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1545004457; x=1576540457;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=N+EfXCaCqCuxrv9emVwi/Fv1cunz9J16dWBEhYr68Ao=;
  b=DaI6tTiqRB2cvAvJEvvqRTRnRQrxq+xikEGwqCiMdbtmkmBX/NfCuesc
   oFypojTbx46wGJj9gZ0Ywge0R/J/DoBv1fg/zaGUdQwX/2PKY1nHi+23i
   SgNRvijYu3IBbExH85D5eSzMUz7518e7oH+DhzATAv1aSsuhBm6RSBCWM
   iVnG8+vv5/mZjZOImh9s74rZBzQc4mA9w+EXZmkukoZiUcSzzy4E0wwqi
   q162N5nTZ+S9QnYjQKjL7H54ao+Q3THC4PdNUJqU8GxTTqsXuArAjZVWA
   K9W277qVRYG0+PUp10LKd4yU3tjQHj0lnHhIc86PVzwIU4F2wYjbrVjOy
   Q==;
X-IronPort-AV: E=Sophos;i="5.56,363,1539619200"; 
   d="scan'208";a="96719593"
Received: from mail-sn1nam01lp2057.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.57])
  by ob1.hgst.iphmx.com with ESMTP; 17 Dec 2018 07:54:16 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHp/kVmg4VtWQW0qXLx+tN7MjkeZnxvsQCGmNc9nF3U=;
 b=PHRpkWq5quKie5qZ2aHOyCDtFHceAaB7yI/B52nKRVsbVZ8XND2rzNMjtt9Scyh1Y4jf6igiJmCaSzNvlLt4XE9OV1eqk4gP0StlOcGdHgKyH8dhdTyyi+nJMFl8cPOJkeopdhiS8BaTdegyUeYG8+uCn2Vzk1IlBTFnv02b8yg=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5286.namprd04.prod.outlook.com (20.178.49.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.22; Sun, 16 Dec 2018 23:54:14 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::957b:6353:d3c5:1b8d]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::957b:6353:d3c5:1b8d%2]) with mapi id 15.20.1425.021; Sun, 16 Dec 2018
 23:54:14 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2] block: update documentation
Thread-Topic: [PATCH v2] block: update documentation
Thread-Index: AQHUiG6nQ2II6pFoTEKEKHIRIOFx0A==
Date:   Sun, 16 Dec 2018 23:54:14 +0000
Message-ID: <BYAPR04MB5816A9782EC48BDE63A25B56E7A30@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20181130053624.1910-1-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.5]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BYAPR04MB5286;6:fqs9gtc0x8Hfqo+lwYQy4P4JHFFTBFXuZOPKFbP/T+PlpxDkxFcYOmd9RzPzLeDdvl22eTJJ8tt176i1lVb3FkQqdJ7WvNylsOlzDQZXZmvDP67SblJ7JdQdT0w3opRwn8zx1eRO8AvsBlsGq65YPxVuXeRp8gBXNqGJZ+TxX713GTjdP2LyqKHepgk2+MW9eWPaYHRQ9KLjdt+tsnGI0pATacz70P0G9kSgObz1CK7QdZt7dnje3a1ZvrT+p8zMtTzby9vZSsjxiAjjZYaxN3w6W/7dCQgHJJhgQHjggqRTs9uItVTGVsorHCVQwRqDvQ51y0C6w5HsgYskko7axFfDjkf+bvPXq9h5HCByS/nR6tiksnmGUQ06vSmZp1KA6BvaR3aap5SwnmNZdMkXhkQ0jAjswU7nlKJHL5lYEBpajNTdYxOLeEmVCNMqbfWwqhIgtK27VMnam0Y82cnkrQ==;5:GEPRMeyWbNUbMo2IgiUyuw/yTHeAwj70rIUP4s+EcXEYo2+C7yilXKzfuTTFeLR5yHkKI871ATrMiZVeJBPyb4xM0kXqecxoShycU28jnb9zxR7sk61z2VxD0mCb4jRf+6TjKIGpg4obSlTIFLE+Rq7k2ctSqbn4midnW5LZwiI=;7:2HmEv2RbpzQg+l9f4L7BdeZiL/Dvql63d0i8zqpHHI8KHPgTrKVDpNdbd9esdZrlrgfTGRjSpey9uOGwzLrHeBSUFNZ3BcrOMsydJUqrxh+ZfJh3lXwhSbCOzZt868ixcVKKa3k2pdowcqk2I35IJg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 1f87fcd9-7cb1-4a98-0cef-08d663b1c8ae
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR04MB5286;
x-ms-traffictypediagnostic: BYAPR04MB5286:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB52867C81C58087BB42102F16E7A30@BYAPR04MB5286.namprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93001095)(10201501046)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BYAPR04MB5286;BCL:0;PCL:0;RULEID:;SRVR:BYAPR04MB5286;
x-forefront-prvs: 0888B1D284
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(39860400002)(376002)(396003)(136003)(199004)(189003)(316002)(68736007)(110136005)(478600001)(9686003)(33656002)(2501003)(55016002)(99286004)(14454004)(6436002)(2906002)(72206003)(15650500001)(81166006)(486006)(25786009)(8676002)(6246003)(8936002)(66066001)(53936002)(229853002)(81156014)(86362001)(6116002)(26005)(7736002)(97736004)(476003)(3846002)(186003)(74316002)(7696005)(76176011)(102836004)(305945005)(53546011)(6506007)(71200400001)(71190400001)(5660300001)(446003)(105586002)(106356001)(14444005)(256004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5286;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 3pt7/6si7uy+KE2PhhwglbMH7JwQVYL+4C9km42P+u7sX6FKtMRte+FpGJ81ADMfpDJLY+1/kBUTYs1gTRtneuv5ln8WJYSk9ocjYZHjBk8VjPrrihG11pQlUebuYLv6wsiv7oOQkz77Uu+Od0akT1PVDiaCjr7TRDczcG0ldl7EZb4vjhXOmcI0fifMNCFqnPzzYbdynW739D5BiOrayDQ/hBXdIErrPED0yxotY+RHEnzIvXY0f/Kw3+5eqSa8ubTxXFX0DBpUyRmZW0QP1v9ZjXwf7zG3a/8qsvEnJF+ArvTC2e78cBlx6+nEeH9U
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f87fcd9-7cb1-4a98-0cef-08d663b1c8ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Dec 2018 23:54:14.4963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5286
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens,=0A=
=0A=
On 2018/11/30 14:36, Damien Le Moal wrote:=0A=
> Add the description of the zoned, nr_zones and chunk_sectors sysfs queue=
=0A=
> attributes to Documentation/block/queue-sysfs.txt. The description of=0A=
> the zoned and chunk_sector attributes are mostly copied from=0A=
> ABI/testing/sysfs-block (added a typo fix). While at it, also fix a=0A=
> typo in the description of the io_poll_delay attribute.=0A=
> =0A=
> nr_zones description is also added to ABI/testing/sysfs-block and=0A=
> contact email address updated for the zoned attribute.=0A=
> =0A=
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> ---=0A=
>  Documentation/ABI/testing/sysfs-block | 12 +++++++++--=0A=
>  Documentation/block/queue-sysfs.txt   | 29 ++++++++++++++++++++++++++-=
=0A=
>  2 files changed, 38 insertions(+), 3 deletions(-)=0A=
> =0A=
> diff --git a/Documentation/ABI/testing/sysfs-block b/Documentation/ABI/te=
sting/sysfs-block=0A=
> index dea212db9df3..7710d4022b19 100644=0A=
> --- a/Documentation/ABI/testing/sysfs-block=0A=
> +++ b/Documentation/ABI/testing/sysfs-block=0A=
> @@ -244,7 +244,7 @@ Description:=0A=
>  =0A=
>  What:		/sys/block/<disk>/queue/zoned=0A=
>  Date:		September 2016=0A=
> -Contact:	Damien Le Moal <damien.lemoal@hgst.com>=0A=
> +Contact:	Damien Le Moal <damien.lemoal@wdc.com>=0A=
>  Description:=0A=
>  		zoned indicates if the device is a zoned block device=0A=
>  		and the zone model of the device if it is indeed zoned.=0A=
> @@ -259,6 +259,14 @@ Description:=0A=
>  		zone commands, they will be treated as regular block=0A=
>  		devices and zoned will report "none".=0A=
>  =0A=
> +What:		/sys/block/<disk>/queue/nr_zones=0A=
> +Date:		November 2018=0A=
> +Contact:	Damien Le Moal <damien.lemoal@wdc.com>=0A=
> +Description:=0A=
> +		nr_zones indicates the total number of zones of a zoned block=0A=
> +		device ("host-aware" or "host-managed" zone model). For regular=0A=
> +		block devices, the value is always 0.=0A=
> +=0A=
>  What:		/sys/block/<disk>/queue/chunk_sectors=0A=
>  Date:		September 2016=0A=
>  Contact:	Hannes Reinecke <hare@suse.com>=0A=
> @@ -268,6 +276,6 @@ Description:=0A=
>  		indicates the size in 512B sectors of the RAID volume=0A=
>  		stripe segment. For a zoned block device, either=0A=
>  		host-aware or host-managed, chunk_sectors indicates the=0A=
> -		size of 512B sectors of the zones of the device, with=0A=
> +		size in 512B sectors of the zones of the device, with=0A=
>  		the eventual exception of the last zone of the device=0A=
>  		which may be smaller.=0A=
> diff --git a/Documentation/block/queue-sysfs.txt b/Documentation/block/qu=
eue-sysfs.txt=0A=
> index 2c1e67058fd3..39e286d7afc9 100644=0A=
> --- a/Documentation/block/queue-sysfs.txt=0A=
> +++ b/Documentation/block/queue-sysfs.txt=0A=
> @@ -64,7 +64,7 @@ guess, the kernel will put the process issuing IO to sl=
eep for an amount=0A=
>  of time, before entering a classic poll loop. This mode might be a=0A=
>  little slower than pure classic polling, but it will be more efficient.=
=0A=
>  If set to a value larger than 0, the kernel will put the process issuing=
=0A=
> -IO to sleep for this amont of microseconds before entering classic=0A=
> +IO to sleep for this amount of microseconds before entering classic=0A=
>  polling.=0A=
>  =0A=
>  iostats (RW)=0A=
> @@ -194,4 +194,31 @@ blk-throttle makes decision based on the samplings. =
Lower time means cgroups=0A=
>  have more smooth throughput, but higher CPU overhead. This exists only w=
hen=0A=
>  CONFIG_BLK_DEV_THROTTLING_LOW is enabled.=0A=
>  =0A=
> +zoned (RO)=0A=
> +----------=0A=
> +This indicates if the device is a zoned block device and the zone model =
of the=0A=
> +device if it is indeed zoned. The possible values indicated by zoned are=
=0A=
> +"none" for regular block devices and "host-aware" or "host-managed" for =
zoned=0A=
> +block devices. The characteristics of host-aware and host-managed zoned =
block=0A=
> +devices are described in the ZBC (Zoned Block Commands) and ZAC=0A=
> +(Zoned Device ATA Command Set) standards. These standards also define th=
e=0A=
> +"drive-managed" zone model. However, since drive-managed zoned block dev=
ices=0A=
> +do not support zone commands, they will be treated as regular block devi=
ces=0A=
> +and zoned will report "none".=0A=
> +=0A=
> +nr_zones (RO)=0A=
> +-------------=0A=
> +For zoned block devices (zoned attribute indicating "host-managed" or=0A=
> +"host-aware"), this indicates the total number of zones of the device.=
=0A=
> +This is always 0 for regular block devices.=0A=
> +=0A=
> +chunk_sectors (RO)=0A=
> +------------------=0A=
> +This has different meaning depending on the type of the block device.=0A=
> +For a RAID device (dm-raid), chunk_sectors indicates the size in 512B se=
ctors=0A=
> +of the RAID volume stripe segment. For a zoned block device, either host=
-aware=0A=
> +or host-managed, chunk_sectors indicates the size in 512B sectors of the=
 zones=0A=
> +of the device, with the eventual exception of the last zone of the devic=
e which=0A=
> +may be smaller.=0A=
> +=0A=
>  Jens Axboe <jens.axboe@oracle.com>, February 2009=0A=
> =0A=
=0A=
Ping...=0A=
=0A=
As Johannes suggested, you may also want to update your email address (I di=
d not=0A=
do so as this is somewhat personal information).=0A=
=0A=
Best regards.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
