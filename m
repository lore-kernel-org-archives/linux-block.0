Return-Path: <SRS0=4R18=SX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DBE6C10F14
	for <linux-block@archiver.kernel.org>; Sun, 21 Apr 2019 17:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10C3E20833
	for <linux-block@archiver.kernel.org>; Sun, 21 Apr 2019 17:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Q20gpZm9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Z4pWNurU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbfDURwx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 Apr 2019 13:52:53 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:48258 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfDURwx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Apr 2019 13:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555869173; x=1587405173;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=moSYFJDFPPjMpxbhqLbD6FytShSrWt+RnP/H92rqDzM=;
  b=Q20gpZm9GZCqSQ03Wb2EzdI23wQket9BEiGHDnEQlNi65vEcjEaSD70C
   9Vaycj13sHkllfvWFEHldF+NB5z5l9K51QYCMips/bxFoGi5B3nFQNyar
   TQCOrXAe9Ltm/53z3VhjGYfq0W7Fx6CaRV5Yov70nAjIZpRftFde1DUZI
   21YTlFdWDZii9SyFcjbh1DlEeH0J5gdGQ2O7GY5qhWffHZbW0o+hnvQ0R
   tb7amjdoiixuzbUShc1EzM8E7fdbsKI6xp9TXXL9i9/PVxeyqKpfOE+o1
   0x3pxA4gEh/IvNWpxvYObHAJh3bn46defeOWYpiU5ale0TC8T6jQbi61h
   A==;
X-IronPort-AV: E=Sophos;i="5.60,378,1549900800"; 
   d="scan'208";a="108188178"
Received: from mail-cys01nam02lp2055.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.55])
  by ob1.hgst.iphmx.com with ESMTP; 22 Apr 2019 01:52:52 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T+PfsKijfd0og39yfnT6GVO0Acaf9O6nzxLERYvL8h0=;
 b=Z4pWNurUrHOhDV9Auq6KaVR6p3t/xl6dHi/aSrBBhOhD87Xr0HQVF2leHEjTzm4MHAKFpoBTGMg2868Kp4fuv3TDL/qsWMFwsTSAj+5WvYNN4mNuqAhjX9g8SUY9U2BsjGRXUihtkC4RYjdZgYwJkkDQQVda1LdDY9bkmZKN+gw=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB3822.namprd04.prod.outlook.com (52.135.81.31) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.14; Sun, 21 Apr 2019 17:52:51 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703%3]) with mapi id 15.20.1813.017; Sun, 21 Apr 2019
 17:52:50 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Coly Li <colyli@suse.de>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [RFC PATCH v2 07/16] bcache: add comments for kobj release
 callback routine
Thread-Topic: [RFC PATCH v2 07/16] bcache: add comments for kobj release
 callback routine
Thread-Index: AQHU9t0qhc4pNiBi/UqK15favPi46w==
Date:   Sun, 21 Apr 2019 17:52:49 +0000
Message-ID: <SN6PR04MB4527A75662BE15841ED5F56286210@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190419160509.66298-1-colyli@suse.de>
 <20190419160509.66298-8-colyli@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e43010b-3638-40e0-b2b2-08d6c6822c3e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB3822;
x-ms-traffictypediagnostic: SN6PR04MB3822:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB3822AA67CE342F495B3400BB86210@SN6PR04MB3822.namprd04.prod.outlook.com>
x-forefront-prvs: 0014E2CF50
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(39860400002)(376002)(346002)(396003)(189003)(199004)(81166006)(8676002)(4326008)(81156014)(53546011)(66066001)(6506007)(25786009)(2906002)(102836004)(26005)(71190400001)(71200400001)(99286004)(8936002)(66446008)(97736004)(6116002)(64756008)(66476007)(14444005)(66556008)(5024004)(73956011)(66946007)(3846002)(76176011)(186003)(76116006)(256004)(91956017)(33656002)(72206003)(478600001)(52536014)(476003)(446003)(305945005)(53936002)(7736002)(6246003)(486006)(74316002)(9686003)(316002)(14454004)(7696005)(2501003)(86362001)(6436002)(55016002)(68736007)(110136005)(5660300002)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB3822;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7kjQno0+0y0No21hyxcZ3va2qkZQc4l89GVmdPc9m8az1crrutl2b1hhxPO8y8Lw8iMmxslhwD4Dj2rpez2yTU/v/pwKQ47csoGG2XJWtJ++nvWBuZTdqlom76JYxtbl2Amm/hyKYkcEf4DvMljox8UU/aRHkXx5J6qunZ48+KymjpIsI4kkD0kOoSgv4R8rX2gHOl0x+SJ/GxXamRKSnBItXPKMFRQ89qGiht8CgsGhAZJcIS21pswRQj69o/tki/ofyHx/vu3ZiidSa3S0NKd947KPz3jWr1kmzHVpm5haKLLBC3AFbL4/MhpTpCspQSCIayTamFOk7ZHXYGyi8NHnZFNddABH352MehFqUkBjlIXGQ4wMgL5sw1dZzMV49Ol2djBaGWymJcyDJUtalR6zcwFcjRStgUFPrO/hr4g=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e43010b-3638-40e0-b2b2-08d6c6822c3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2019 17:52:50.8807
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
Reviewed-by:- Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 04/19/2019 11:24 AM, Coly Li wrote:=0A=
> Bcache has several routines to release resources in implicit way, they=0A=
> are called when the associated kobj released. This patch adds code=0A=
> comments to notice when and which release callback will be called,=0A=
> - When dc->disk.kobj released:=0A=
>    void bch_cached_dev_release(struct kobject *kobj)=0A=
> - When d->kobj released:=0A=
>    void bch_flash_dev_release(struct kobject *kobj)=0A=
> - When c->kobj released:=0A=
>    void bch_cache_set_release(struct kobject *kobj)=0A=
> - When ca->kobj released=0A=
>    void bch_cache_release(struct kobject *kobj)=0A=
>=0A=
> Signed-off-by: Coly Li <colyli@suse.de>=0A=
> ---=0A=
>   drivers/md/bcache/super.c | 4 ++++=0A=
>   1 file changed, 4 insertions(+)=0A=
>=0A=
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c=0A=
> index 036bffad0bfe..400af446c372 100644=0A=
> --- a/drivers/md/bcache/super.c=0A=
> +++ b/drivers/md/bcache/super.c=0A=
> @@ -1174,6 +1174,7 @@ int bch_cached_dev_attach(struct cached_dev *dc, st=
ruct cache_set *c,=0A=
>   	return 0;=0A=
>   }=0A=
>=0A=
> +/* when dc->disk.kobj released */=0A=
>   void bch_cached_dev_release(struct kobject *kobj)=0A=
>   {=0A=
>   	struct cached_dev *dc =3D container_of(kobj, struct cached_dev,=0A=
> @@ -1326,6 +1327,7 @@ static void register_bdev(struct cache_sb *sb, stru=
ct page *sb_page,=0A=
>=0A=
>   /* Flash only volumes */=0A=
>=0A=
> +/* When d->kobj released */=0A=
>   void bch_flash_dev_release(struct kobject *kobj)=0A=
>   {=0A=
>   	struct bcache_device *d =3D container_of(kobj, struct bcache_device,=
=0A=
> @@ -1496,6 +1498,7 @@ bool bch_cache_set_error(struct cache_set *c, const=
 char *fmt, ...)=0A=
>   	return true;=0A=
>   }=0A=
>=0A=
> +/* When c->kobj released */=0A=
>   void bch_cache_set_release(struct kobject *kobj)=0A=
>   {=0A=
>   	struct cache_set *c =3D container_of(kobj, struct cache_set, kobj);=0A=
> @@ -2023,6 +2026,7 @@ static const char *register_cache_set(struct cache =
*ca)=0A=
>=0A=
>   /* Cache device */=0A=
>=0A=
> +/* When ca->kobj released */=0A=
>   void bch_cache_release(struct kobject *kobj)=0A=
>   {=0A=
>   	struct cache *ca =3D container_of(kobj, struct cache, kobj);=0A=
>=0A=
=0A=
