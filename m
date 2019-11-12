Return-Path: <SRS0=0oGL=ZE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F692C43331
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 00:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAAD42184C
	for <linux-block@archiver.kernel.org>; Tue, 12 Nov 2019 00:04:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="XCe3KPUN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="BUl+9dTj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfKLAEQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Nov 2019 19:04:16 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:34757 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfKLAEP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Nov 2019 19:04:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1573517055; x=1605053055;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=NtodjC1Q41aL5Lxr3vS3S6TXR2QjcheNHZjk4RnA3mY=;
  b=XCe3KPUNj0Uody/vceyRtmFWie9asg+nsIRtXfwsGvkzYHr0UX/ZtURS
   +nrMwyp+tTOGjVFmN2QihLRKfNRCRjlhpWI8YIxupjCGbfsJrcdcegUcn
   H1mfUOcsJoXhyi8GZExmyXHH/yCLI71pQon2zSc4uUe1PEdB3XHHZGh84
   +HD4NmB+07vaxirwn8T1AdwRCWSZllXx/2H4SDdMrNuvJtxgth1EqGAs9
   /uagibLS+HxA2ZFTxolU+fgAlr+plNGc40Wz5sS5Hjc9zVXS2MSjV7b2S
   pCk4qUm5eJ3Z65c6zS2vxQ/fITghlpxhYhzQ+s1C225EOCtR/4ege4/Nl
   Q==;
IronPort-SDR: ZYGUhGKmZ6IiUuzhiS1XWpa1eyGwGpRFC0embRWxR0crYxPHaHMSn6Au/f2WrxRnVqrTnBwDy0
 1NvgrAYcwaL5f39MNEdEucY7FsZZn8Rm4vdmS1p0hCwxu5Bbc0Ykni+KQJGxrmKzySmDARChnD
 laDcPwK3zbThiZ+jqZo323BNcZCHoWZkeZyDQQLqXNEPj4xXfgGIfOZaHmOCZ1OSHkAlmMJuyv
 83kqnKS6fY/71WHzSwGgTVw3BLjeJtAIdXtThmylXF7v8OwMJCzGdoXOt3nKfJO3jDoQ3duJnr
 9EE=
X-IronPort-AV: E=Sophos;i="5.68,294,1569254400"; 
   d="scan'208";a="230002274"
Received: from mail-co1nam04lp2057.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.57])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2019 08:04:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XjWZ03WYLui1zp2+PX/SBe/xYibc+ehT1cv7NPTIOy2O8L4n993/DZWhX/d/BKui3PXgHitoPU4neH4slRrpgl4nFAPJT/Ykok1sU/m+qg3fyObpsT9zQV1ASO15WgE+X+b4bpAEspWIJooSOWnS03Ykupu+uADERD/ofagfn0pcHo8+BlXvNfUAo+z0GzDFfMptEcaC3ZIJ+Po+YEtLs2cDo86Hevy8yoZLNz6SgyfgXVJHZlc5tz2Y5ZAPsXMgGjwhax5y7IBd+/MWZ3i8MkejEc2SS3qgPLiMUwf8HpONaR2nqqRy61CieyMbKUb4se/DTvte5XMSEHi0KUa+Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxNWsSmSiMs+UxbcXyao19GrdyC1NTrMAPdmaBX67Nw=;
 b=S5BugrfNpY3H920gKnXeNcPzCEgeVk5hXHCtIxeG/x2BM98bkdPdvtbsbvyv1p7LDa2cOkmAd5oqDJe8YcH/sdPWk/2M/794oMRiaSIKW6ws/sOMXcKpIh4Mp9cDATten+SV24Qyv7e5aumkeTEXCkS3TzleipAyT+6wxG7c4mwY71EIlyzn5M9c91q8w7KjuJmhGiQLCblRw9VCnsujuEiHakTfXF9BpSG3gxUAxgiWSY8o5B1+uwVWfuqvo8HFv2NOa6dexae4zREkg4IwO8ItrMcCqAHeJlRznEyiZAQoaY5/QBSrAvjm6ElxZ2VszY22QhkyD61LMd04rex4eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxNWsSmSiMs+UxbcXyao19GrdyC1NTrMAPdmaBX67Nw=;
 b=BUl+9dTjkXUDL1nPGCSzMG1QuTSsTfyfiqYzURaDLTfFkCqS3rK+BjtJGIcn6TkWJdziC3Qz03xBanUcXi+2rkgo1sRXfJqqnAHoz9SSMTtThbtuzypKSLAAbQOxwuQoqbu/EyTmISCRXsFUUVB1xpqD9RuPtt2vRqKkfKBNvVo=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB5301.namprd04.prod.outlook.com (20.178.49.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2430.23; Tue, 12 Nov 2019 00:04:13 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::4176:5eda:76a2:3c40]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::4176:5eda:76a2:3c40%7]) with mapi id 15.20.2430.027; Tue, 12 Nov 2019
 00:04:13 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH V2 2/2] block: allow zone_mgmt_ops to bail out on SIGKILL
Thread-Topic: [PATCH V2 2/2] block: allow zone_mgmt_ops to bail out on SIGKILL
Thread-Index: AQHVmNWfhNCln3D7akCNHrBihoMmUA==
Date:   Tue, 12 Nov 2019 00:04:13 +0000
Message-ID: <BYAPR04MB5816865D212AD49866689ADAE7770@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20191111211844.5922-1-chaitanya.kulkarni@wdc.com>
 <20191111211844.5922-3-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.8]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0e5b76c5-73bb-4ce7-fae3-08d76703d9fd
x-ms-traffictypediagnostic: BYAPR04MB5301:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5301247C15624DEF8416C3D4E7770@BYAPR04MB5301.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:561;
x-forefront-prvs: 021975AE46
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(366004)(396003)(346002)(136003)(199004)(189003)(71190400001)(256004)(5660300002)(71200400001)(2501003)(478600001)(6246003)(14444005)(9686003)(486006)(446003)(91956017)(6306002)(966005)(476003)(81156014)(81166006)(4326008)(76176011)(8936002)(305945005)(7736002)(229853002)(14454004)(74316002)(8676002)(52536014)(316002)(66556008)(6116002)(66446008)(3846002)(66476007)(64756008)(110136005)(33656002)(76116006)(7696005)(2906002)(86362001)(6436002)(99286004)(66066001)(66946007)(6506007)(53546011)(55016002)(26005)(186003)(102836004)(25786009)(6606295002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5301;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g8vVN22eygzr1bsbTbZfXQUjbaRk6sHcKBMqSwt8p9EEUyyNQNaN+aOheA21Hhc8XqwquYCvag73XHOutUzsqiU8tAFGZ3wkUuJxOrFrMOT6MmzOPekDZhH9jm/veaOCsgr52tAj17ARcV1TI6lNAdr3hXYXZntAt2LcgGKbu80BmYTwzKcAJ3o0a3nl0vUmPOI37UDBpEy8N9aknAIHi71L8WoEx+unFxBZvJxy7SfBMv6EMLkgmRfZP6W6tNW0iXCBVBWEwzgPl70NM0EwkeYaFkn1SZ1OBXBY3AXKPZogbdom4HneSus/QRGA/3hW+M3ypKJuquFgEhfKDOnq/cyvHtnu2QSDTXThvC17zz1V8oQAwuC4l731g2OErvMEnnlG06aQtb2Xj60Db2AFCvFbWNW60jqmqwQvoxaPnUind4K5OS3B35/7VWb7d4x1IRQAbOjBDrBzbGUywadSbFD33/4ZUGiDr1SOpBzAyck=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5b76c5-73bb-4ce7-fae3-08d76703d9fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2019 00:04:13.4339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 19Y27IFJRZva8cRj8iwuzPkVNpGRBvas2yPzgNUpAV0cGebyFCd3LunU2fFWRTxwwQJwUVWGf4A5ZCeYZ736XQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5301
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2019/11/12 6:18, Chaitanya Kulkarni wrote:=0A=
> This patch is on the similar concept which is posted earlier:-=0A=
> https://marc.info/?l=3Dlinux-block&m=3D157321402002207&w=3D2.=0A=
=0A=
May be reference a commit ID here instead of an URL ?=0A=
=0A=
> =0A=
> This allows zone-mgmt ops to handle SIGKILL.=0A=
> =0A=
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
> ---=0A=
>  block/blk-zoned.c | 5 ++++-=0A=
>  1 file changed, 4 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
> index 481eaf7d04d4..8f0f740d89e8 100644=0A=
> --- a/block/blk-zoned.c=0A=
> +++ b/block/blk-zoned.c=0A=
> @@ -286,12 +286,15 @@ int blkdev_zone_mgmt(struct block_device *bdev, enu=
m req_opf op,=0A=
>  		sector +=3D zone_sectors;=0A=
>  =0A=
>  		/* This may take a while, so be nice to others */=0A=
> -		cond_resched();=0A=
> +		ret =3D blk_should_abort(bio);=0A=
> +		if (ret)=0A=
> +			goto out;=0A=
=0A=
There is no need for the goto here. You can return directly.=0A=
=0A=
>  	}=0A=
>  =0A=
>  	ret =3D submit_bio_wait(bio);=0A=
>  	bio_put(bio);=0A=
>  =0A=
> +out:=0A=
>  	return ret;=0A=
>  }=0A=
>  EXPORT_SYMBOL_GPL(blkdev_zone_mgmt);=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
