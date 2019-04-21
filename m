Return-Path: <SRS0=4R18=SX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8745EC10F14
	for <linux-block@archiver.kernel.org>; Sun, 21 Apr 2019 18:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE2E2080D
	for <linux-block@archiver.kernel.org>; Sun, 21 Apr 2019 18:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HPZPeyZR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hc8KiS9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725888AbfDUSAt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 21 Apr 2019 14:00:49 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:23950 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfDUSAs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 21 Apr 2019 14:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1555869648; x=1587405648;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=pw4uThmUznol5VdbKDc3pW+iQNa8xKtk6oKGYwUAOl4=;
  b=HPZPeyZR+L3CPn4OgwtgVF6cwhYytmzdqWO3PBwmzk/s4AFWLas42Bpg
   qADyEl6kzJkGdz3zB/aPlwo76IyRHOdSTxmjCVZCOUTqooy1Zs9qTSutD
   r5sRHjeF6WDgxkbGuMHpokUQ/GiBcFA72dZbU/aHC/NZn7itXkzl4NGIr
   gRHp3uqFWsHPP6jAk3jAKCWP3XIvNr8MmztMFq5lMENKnAJPsBNthSx15
   AsXLF+V4whQjREv2aKLnlfUM0surdOVF4v0MPddgiP8vixQIO559BRNri
   P0PuDLrX3vNaXoPyuGR07l/wwu+58QyGvTbE/5Ob/ts5KX6fbgE/Umwll
   Q==;
X-IronPort-AV: E=Sophos;i="5.60,378,1549900800"; 
   d="scan'208";a="107678516"
Received: from mail-cys01nam02lp2054.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.54])
  by ob1.hgst.iphmx.com with ESMTP; 22 Apr 2019 02:00:47 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dCgFz1PC6iBkYn2Qr+VdP1fyB5o+3zSy2sSZcGsWTRY=;
 b=hc8KiS9ipvmgzLNJPKQKph18T1wYMZPRfjAOW3C+xnw/qEILANsOf0Y7oQ0igGhlKjuipaBcJuQTY89INUs3/ZSgnqTk3MnRuBSKd4HAmYVTHkv4RUueaEE7+Cq42dC4uv6g+YEwg9OC30NVOetcCmLnd3nfHoKhTOR8V1pX7f4=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4816.namprd04.prod.outlook.com (52.135.122.202) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1813.11; Sun, 21 Apr 2019 18:00:45 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c95e:c178:8d66:3703%3]) with mapi id 15.20.1813.017; Sun, 21 Apr 2019
 18:00:45 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Coly Li <colyli@suse.de>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [RFC PATCH v2 09/16] bcache: add error check for calling
 register_bdev()
Thread-Topic: [RFC PATCH v2 09/16] bcache: add error check for calling
 register_bdev()
Thread-Index: AQHU9t0mf9RVOj+rPkuuKiseFAOKBg==
Date:   Sun, 21 Apr 2019 18:00:45 +0000
Message-ID: <SN6PR04MB45279113170759A73CFB40AB86210@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190419160509.66298-1-colyli@suse.de>
 <20190419160509.66298-10-colyli@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bb7d7c41-fdef-4d48-21a9-08d6c68346fe
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600141)(711020)(4605104)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:SN6PR04MB4816;
x-ms-traffictypediagnostic: SN6PR04MB4816:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB48161C34B2E8DC70417AC7F786210@SN6PR04MB4816.namprd04.prod.outlook.com>
x-forefront-prvs: 0014E2CF50
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(136003)(346002)(376002)(39860400002)(189003)(199004)(26005)(102836004)(76176011)(86362001)(2501003)(256004)(14444005)(186003)(53546011)(6506007)(55016002)(9686003)(53936002)(6246003)(68736007)(72206003)(8936002)(478600001)(71200400001)(71190400001)(33656002)(4326008)(25786009)(5660300002)(97736004)(66066001)(81156014)(81166006)(229853002)(14454004)(73956011)(7736002)(316002)(110136005)(446003)(8676002)(6116002)(3846002)(74316002)(486006)(91956017)(76116006)(7696005)(476003)(6436002)(2906002)(66476007)(99286004)(305945005)(66446008)(64756008)(66556008)(52536014)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4816;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 0H9B33lLEKwlpMuhrysN2/eSi7J4pcoJPHxrsDTV7iYUrniuv+eoUfBfSiqEHnUALuGpl+NGMAY92ij4yjvHbOcMpJbnAhRwGiYCvRtgGYAx+NiTTkdoOKk1y0WgUvY4gj9572y/jGXnqtg1BVTulonOnqUyXEU3miKj5OaM9dKXjnDh5tBDiGe8FIC+S/UXJOGGTSDCl1j4PmK4Zx6bu/wyQkZSC5BPmXep+b+EedrOXERCqz9j2oreeGU7zObYTlGSZUy/3lY9HBAFH/moOj9VUsVKdPqi1oVAJ9rv1FBii6h/zmEemN3w+aMFxbg4+UuJ6/rI7DW9pMutpL4+/OCWYSnHBtes8fUMwLuPDXhEjcQ7XKmBGa9ph0jgGR6ESFoO+eoQarG/JdZdFXM82qCGJPASiJEmz9AwYDskcgc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb7d7c41-fdef-4d48-21a9-08d6c68346fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2019 18:00:45.2828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4816
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 04/19/2019 11:24 AM, Coly Li wrote:=0A=
> This patch adds return value to register_bdev(). Then if failure happens=
=0A=
> inside register_bdev(), its caller register_bcache() may detect and=0A=
> handle the failure more properly.=0A=
>=0A=
> Signed-off-by: Coly Li <colyli@suse.de>=0A=
> ---=0A=
>   drivers/md/bcache/super.c | 16 ++++++++++------=0A=
>   1 file changed, 10 insertions(+), 6 deletions(-)=0A=
>=0A=
> diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c=0A=
> index 400af446c372..a435c506edba 100644=0A=
> --- a/drivers/md/bcache/super.c=0A=
> +++ b/drivers/md/bcache/super.c=0A=
> @@ -1281,7 +1281,7 @@ static int cached_dev_init(struct cached_dev *dc, u=
nsigned int block_size)=0A=
>=0A=
>   /* Cached device - bcache superblock */=0A=
>=0A=
> -static void register_bdev(struct cache_sb *sb, struct page *sb_page,=0A=
> +static int register_bdev(struct cache_sb *sb, struct page *sb_page,=0A=
>   				 struct block_device *bdev,=0A=
>   				 struct cached_dev *dc)=0A=
>   {=0A=
> @@ -1319,10 +1319,11 @@ static void register_bdev(struct cache_sb *sb, st=
ruct page *sb_page,=0A=
>   	    BDEV_STATE(&dc->sb) =3D=3D BDEV_STATE_STALE)=0A=
>   		bch_cached_dev_run(dc);=0A=
>=0A=
> -	return;=0A=
> +	return 0;=0A=
>   err:=0A=
>   	pr_notice("error %s: %s", dc->backing_dev_name, err);=0A=
>   	bcache_device_stop(&dc->disk);=0A=
So register_bdev has couple of goto err; calls where kobject interface =0A=
is used directly :-=0A=
=0A=
register_bdev=0A=
	kobject_add=0A=
=0A=
and=0A=
=0A=
indirectly :-=0A=
register_bdev=0A=
	bch_cache_accounting_add_kobjs=0A=
=0A=
		kobject_add=0A=
Here we return -EIO, we should catch the error code from kobject calls =0A=
and return that error instead of -EIO. Any thoughts ?=0A=
=0A=
> +	return -EIO;=0A=
>   }=0A=
>=0A=
>   /* Flash only volumes */=0A=
> @@ -2273,7 +2274,7 @@ static bool bch_is_open(struct block_device *bdev)=
=0A=
>   static ssize_t register_bcache(struct kobject *k, struct kobj_attribute=
 *attr,=0A=
>   			       const char *buffer, size_t size)=0A=
>   {=0A=
> -	ssize_t ret =3D size;=0A=
> +	ssize_t ret =3D -EINVAL;=0A=
>   	const char *err =3D "cannot allocate memory";=0A=
>   	char *path =3D NULL;=0A=
>   	struct cache_sb *sb =3D NULL;=0A=
> @@ -2307,7 +2308,7 @@ static ssize_t register_bcache(struct kobject *k, s=
truct kobj_attribute *attr,=0A=
>   			if (!IS_ERR(bdev))=0A=
>   				bdput(bdev);=0A=
>   			if (attr =3D=3D &ksysfs_register_quiet)=0A=
> -				goto out;=0A=
> +				goto quiet_out;=0A=
>   		}=0A=
>   		goto err;=0A=
>   	}=0A=
> @@ -2328,8 +2329,10 @@ static ssize_t register_bcache(struct kobject *k, =
struct kobj_attribute *attr,=0A=
>   			goto err_close;=0A=
>=0A=
>   		mutex_lock(&bch_register_lock);=0A=
> -		register_bdev(sb, sb_page, bdev, dc);=0A=
> +		ret =3D register_bdev(sb, sb_page, bdev, dc);=0A=
>   		mutex_unlock(&bch_register_lock);=0A=
> +		if (ret < 0)=0A=
> +			goto err;=0A=
>   	} else {=0A=
>   		struct cache *ca =3D kzalloc(sizeof(*ca), GFP_KERNEL);=0A=
>=0A=
> @@ -2339,6 +2342,8 @@ static ssize_t register_bcache(struct kobject *k, s=
truct kobj_attribute *attr,=0A=
>   		if (register_cache(sb, sb_page, bdev, ca) !=3D 0)=0A=
>   			goto err;=0A=
>   	}=0A=
> +quiet_out:=0A=
> +	ret =3D size;=0A=
>   out:=0A=
>   	if (sb_page)=0A=
>   		put_page(sb_page);=0A=
> @@ -2351,7 +2356,6 @@ static ssize_t register_bcache(struct kobject *k, s=
truct kobj_attribute *attr,=0A=
>   	blkdev_put(bdev, FMODE_READ|FMODE_WRITE|FMODE_EXCL);=0A=
>   err:=0A=
>   	pr_info("error %s: %s", path, err);=0A=
> -	ret =3D -EINVAL;=0A=
>   	goto out;=0A=
>   }=0A=
>=0A=
>=0A=
=0A=
