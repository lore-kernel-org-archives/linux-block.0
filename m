Return-Path: <SRS0=4R18=SX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B42EC10F14
	for <linux-block@archiver.kernel.org>; Sun, 21 Apr 2019 17:43:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB9BD20833
	for <linux-block@archiver.kernel.org>; Sun, 21 Apr 2019 17:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="kXJvha1X";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="U/0ViQTn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727828AbfDURnr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 Apr 2019 13:43:47 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:4162 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726786AbfDURnr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Apr 2019 13:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555868653; x=1587404653;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=zDW+mRIfX/rlBEjdQiU357fQlX02Tt4em0/n2Xk9lLM=;
  b=kXJvha1XMzv52G4WQZoG8oxBcgiOrTnYrS5TqeF1b+xPE6w/+08SSm0B
   82FqbhJoPpw65ljnciTOStuIkx3btEQZIoeRc1qAWO+E2uLgy9yFimc6X
   7brrctg0i2zz4oSDTHCPhuZaXXhrvE7gKFctfWl13xseBP8ibSRHm9len
   ZdodFXLwmZddqJ8xUBmF9PIvn0XUOobLVwRjKlq30+YZLx3FgGAb4VsP5
   QTQue1ZJ5i/3UyLReqTteAfBhRbYchBMmPKHiNgiA1323gunyDjveBkDT
   /HY7slxpvGtO3dEDEs7gE+KKpDoNQ45MZihCEnSlVX/CzGKBWjf9/TBCL
   w==;
X-IronPort-AV: E=Sophos;i="5.60,378,1549900800"; 
   d="scan'208";a="205557710"
Received: from mail-co1nam03lp2059.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.59])
  by ob1.hgst.iphmx.com with ESMTP; 22 Apr 2019 01:44:12 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5sq6EfelGR33NPWTJ1QT/vHbERqH3zw6EilMlTs5EXo=;
 b=U/0ViQTnjw0ZUImdK2Wo5ZqhMAIn6KrDARJt9AwoZB3VL1KGaBJI0IkpvrxF1bfRo+0lVbfIZW7RaQ+dl+hPoKOQvSvqQQ/Maf2XZQbbjbXOZJpiR0d5mVATofb5GgkC+KUYMKy4hkHjR01FuyvZRiofhS4sJv2gZ815eP13vpk=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4846.namprd04.prod.outlook.com (52.135.122.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.12; Sun, 21 Apr 2019 17:43:44 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703%3]) with mapi id 15.20.1813.017; Sun, 21 Apr 2019
 17:43:44 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Coly Li <colyli@suse.de>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [RFC PATCH v2 11/16] bcache: add comments for closure_fn to be
 called in closure_queue()
Thread-Topic: [RFC PATCH v2 11/16] bcache: add comments for closure_fn to be
 called in closure_queue()
Thread-Index: AQHU9t0dHQH3Imco9kiUWDcfnElklg==
Date:   Sun, 21 Apr 2019 17:43:44 +0000
Message-ID: <SN6PR04MB45271C55E70F0BDEEC3940A186210@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190419160509.66298-1-colyli@suse.de>
 <20190419160509.66298-12-colyli@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ef5d068-2417-4468-abbb-08d6c680e68c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB4846;
x-ms-traffictypediagnostic: SN6PR04MB4846:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB48468450D72C4D8447A1832686210@SN6PR04MB4846.namprd04.prod.outlook.com>
x-forefront-prvs: 0014E2CF50
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39860400002)(136003)(366004)(199004)(189003)(486006)(26005)(99286004)(6436002)(5660300002)(186003)(316002)(86362001)(66066001)(81156014)(8676002)(81166006)(229853002)(476003)(33656002)(52536014)(446003)(305945005)(74316002)(7736002)(8936002)(2501003)(97736004)(3846002)(14454004)(110136005)(76176011)(55016002)(6246003)(2906002)(4326008)(9686003)(478600001)(68736007)(71200400001)(71190400001)(6506007)(53936002)(7696005)(256004)(53546011)(66556008)(66476007)(76116006)(91956017)(64756008)(73956011)(66446008)(66946007)(6116002)(102836004)(72206003)(14444005)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4846;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: FqreEOm3YKZx672gglCbXE+whzbEYbT61VsNth2lhU4tzPYLENxeQs7GCajGaffRvWF/FAjMbe5YOxldWSyQiCRc2SHzDT3s1Nl7ZRLeNPuW4oRi9oDf786P5Av1o2jD4odWK3aSrOjaXUvYQatEHoLvBgcDnrm0yH+bItOvXcuL7cJY499bDybLzqwmNuvK/Bq2t4GnYtMxzty2dxw+6rSmtqe2rl6s4XMop+fjKTUWkJ6gExI81S5QIbW9I7SJAiw7nKxaIlDbbWXr+3wJWGC8JlpHiQEKgJ3VxI/U8FywmzNZoyR+Yk27Hqjd8GNbJ6/UxhNXeDT7RliZo095D+Mj7+bcwVjDswIWRAWt9kYziD0+Dr+uRHQp23AgCuFHtB71CJM3i5UP7ev7pPqXCmjCx6dV6SqZyL8sKQJ+d+c=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ef5d068-2417-4468-abbb-08d6c680e68c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2019 17:43:44.3954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4846
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 04/19/2019 11:24 AM, Coly Li wrote:=0A=
> Add code comments to explain which call back function might be called=0A=
> for the closure_queue(). This is an effort to make code to be more=0A=
> understandable for readers.=0A=
>=0A=
> Signed-off-by: Coly Li <colyli@suse.de>=0A=
> ---=0A=
>   drivers/md/bcache/super.c | 6 ++++++=0A=
>   1 file changed, 6 insertions(+)=0A=
>=0A=
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c=0A=
> index 83a7cb0e0e45..9b41e0b62cc0 100644=0A=
> --- a/drivers/md/bcache/super.c=0A=
> +++ b/drivers/md/bcache/super.c=0A=
> @@ -662,6 +662,11 @@ static const struct block_device_operations bcache_o=
ps =3D {=0A=
>   void bcache_device_stop(struct bcache_device *d)=0A=
>   {=0A=
>   	if (!test_and_set_bit(BCACHE_DEV_CLOSING, &d->flags))=0A=
> +		/*=0A=
> +		 * closure_fn set to=0A=
> +		 * - cached device: cached_dev_flush()=0A=
> +		 * - flash dev: flash_dev_flush()=0A=
> +		 */=0A=
>   		closure_queue(&d->cl);=0A=
>   }=0A=
>=0A=
> @@ -1677,6 +1682,7 @@ static void __cache_set_unregister(struct closure *=
cl)=0A=
>   void bch_cache_set_stop(struct cache_set *c)=0A=
>   {=0A=
>   	if (!test_and_set_bit(CACHE_SET_STOPPING, &c->flags))=0A=
> +		/* closure_fn set to __cache_set_unregister() */=0A=
>   		closure_queue(&c->caching);=0A=
>   }=0A=
>=0A=
>=0A=
=0A=
