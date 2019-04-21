Return-Path: <SRS0=4R18=SX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAFCC10F14
	for <linux-block@archiver.kernel.org>; Sun, 21 Apr 2019 17:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4431120833
	for <linux-block@archiver.kernel.org>; Sun, 21 Apr 2019 17:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qoEFijJy";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="k/XNz/Gy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbfDURvB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 Apr 2019 13:51:01 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:11201 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbfDURua (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Apr 2019 13:50:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555869030; x=1587405030;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=3StqboS3AIcTQUbCg5nhO7xH5/CLgxiTqDCUF7nSs98=;
  b=qoEFijJyXfS0qJPNPOeJ9Jbk/Uuly6fKJTxd4qLdPwdLisxvrFXqk6MO
   GhvmbZO/653jssyQ0r2CjD+3hfkvSB9jkBUN9xPhIdunrwlDefLwq88Ok
   piewYKWeEMwSknenAW9foaXU27NF82CVm8qvL2Q7Trpxdg0Rf/8QiEty/
   mD4oCC/yU6gxxMXQH6O9Y+b9gZX20XFos37Tm1K1WHo3S/VevXCZooQsw
   UMqc4RgA97lcGcriOrRjsc6oSH+fTTdJZhI9v7n6sSsSl7K7cDMDV+Wmp
   xiRubdUZSxisGLng2giGZqYDh+omVigLKrBCzpTAhUtF8dQggDJMzrT6h
   g==;
X-IronPort-AV: E=Sophos;i="5.60,378,1549900800"; 
   d="scan'208";a="108188146"
Received: from mail-cys01nam02lp2052.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.52])
  by ob1.hgst.iphmx.com with ESMTP; 22 Apr 2019 01:50:29 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B9/u1XGZRvrO/BOHEiRtWX6QyQMCabiO7HJD+N8IEYc=;
 b=k/XNz/GyvJv6SU2LxfkbjWNrF5xaouL4IdlU1veZJx9d366dcproAXDBlSNNNgo09oUByq0vdZyFrv2LP1rh1EufP17ykPoJVnIG9N2Qm+N+7FzZHOYAPys0AwcgFXPlLQiqjRBiQrLRVYbeEyKbENzPWsBLpe5NKYUn9nNeiJs=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB3822.namprd04.prod.outlook.com (52.135.81.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Sun, 21 Apr 2019 17:50:28 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703%3]) with mapi id 15.20.1813.017; Sun, 21 Apr 2019
 17:50:28 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Coly Li <colyli@suse.de>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [RFC PATCH v2 10/16] bcache: Add comments for blkdev_put() in
 registration code path
Thread-Topic: [RFC PATCH v2 10/16] bcache: Add comments for blkdev_put() in
 registration code path
Thread-Index: AQHU9t0fkN9l5LcRSUSvf2vDaRuhuQ==
Date:   Sun, 21 Apr 2019 17:50:28 +0000
Message-ID: <SN6PR04MB4527BF7BB52847E1E3267D9D86210@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190419160509.66298-1-colyli@suse.de>
 <20190419160509.66298-11-colyli@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d2045ce-34b9-42a5-8320-08d6c681d726
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB3822;
x-ms-traffictypediagnostic: SN6PR04MB3822:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB3822F1E2586DB23CAAC2499186210@SN6PR04MB3822.namprd04.prod.outlook.com>
x-forefront-prvs: 0014E2CF50
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39860400002)(376002)(346002)(396003)(189003)(199004)(81166006)(8676002)(4326008)(81156014)(53546011)(66066001)(6506007)(25786009)(2906002)(102836004)(26005)(71190400001)(71200400001)(99286004)(8936002)(66446008)(97736004)(6116002)(64756008)(66476007)(14444005)(66556008)(73956011)(66946007)(3846002)(76176011)(186003)(76116006)(256004)(91956017)(33656002)(72206003)(478600001)(52536014)(476003)(446003)(305945005)(53936002)(7736002)(6246003)(486006)(74316002)(9686003)(316002)(14454004)(7696005)(2501003)(86362001)(6436002)(55016002)(68736007)(110136005)(5660300002)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB3822;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qGyOnMFi5AmDknnM2x4I9MSYOYWj6jw6g5Cilz6MkwYi/E0lNENWCJZgFv0Hq/+yShD0LyILM3A9fRQLtApg+mzUvKFP4Ykgxulw86lvAi19dqbxVF9af2Wh/6IczMmh6wzmgWOgaQuFiarS9SA+cJSQVkSxZfWWiaOO0mjYcXEO/BQ6sPijQYc7bH2GLVeemp+NbTaKNuhj0JROcif9pOwBHMl1MQE9vYVHtIFDHaq6BndJWnJiuQTeBZO1i6LWct+Tu18it9I7yLYYGZpPaAL2XsIgYHBdH4GHGv+D800sFh3ao/mRZabNY4Km1m5U1OK6q8hqAHeesou9mhlKBaZIR3KbnhN+2Tw8X72ewk3QMmDbc+v2zH7GijUApiwhr1Qa/WElD4yhcavv2J96czKSOF8cc/zL0Vm29gWEkTc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d2045ce-34b9-42a5-8320-08d6c681d726
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2019 17:50:28.1509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3822
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 04/19/2019 11:24 AM, Coly Li wrote:=0A=
> Add comments to explain why in register_bcache() blkdev_put() won't=0A=
> be called in two location. Add comments to explain why blkdev_put()=0A=
> must be called in register_cache() when cache_alloc() failed.=0A=
>=0A=
> Signed-off-by: Coly Li <colyli@suse.de>=0A=
> ---=0A=
>   drivers/md/bcache/super.c | 8 ++++++++=0A=
>   1 file changed, 8 insertions(+)=0A=
>=0A=
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c=0A=
> index a435c506edba..83a7cb0e0e45 100644=0A=
> --- a/drivers/md/bcache/super.c=0A=
> +++ b/drivers/md/bcache/super.c=0A=
> @@ -2191,6 +2191,12 @@ static int register_cache(struct cache_sb *sb, str=
uct page *sb_page,=0A=
>=0A=
>   	ret =3D cache_alloc(ca);=0A=
>   	if (ret !=3D 0) {=0A=
> +		/*=0A=
> +		 * If we failed here, it means ca->kobj is not initialzed yet,=0A=
> +		 * kobject_put() won't be called and there is no chance to=0A=
> +		 * call blkdev_put() to bdev in bch_cache_release(). So we=0A=
> +		 * explictly call blkdev_put() here.=0A=
> +		 */=0A=
>   		blkdev_put(bdev, FMODE_READ|FMODE_WRITE|FMODE_EXCL);=0A=
>   		if (ret =3D=3D -ENOMEM)=0A=
>   			err =3D "cache_alloc(): -ENOMEM";=0A=
> @@ -2331,6 +2337,7 @@ static ssize_t register_bcache(struct kobject *k, s=
truct kobj_attribute *attr,=0A=
>   		mutex_lock(&bch_register_lock);=0A=
>   		ret =3D register_bdev(sb, sb_page, bdev, dc);=0A=
>   		mutex_unlock(&bch_register_lock);=0A=
> +		/* blkdev_put() will be called in cached_dev_free() */=0A=
>   		if (ret < 0)=0A=
>   			goto err;=0A=
>   	} else {=0A=
> @@ -2339,6 +2346,7 @@ static ssize_t register_bcache(struct kobject *k, s=
truct kobj_attribute *attr,=0A=
>   		if (!ca)=0A=
>   			goto err_close;=0A=
>=0A=
> +		/* blkdev_put() will be called in bch_cache_release() */=0A=
>   		if (register_cache(sb, sb_page, bdev, ca) !=3D 0)=0A=
>   			goto err;=0A=
>   	}=0A=
>=0A=
=0A=
