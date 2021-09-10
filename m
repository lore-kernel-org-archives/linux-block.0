Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E48AC433EF
	for <linux-block@archiver.kernel.org>; Fri, 10 Sep 2021 02:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D44F60555
	for <linux-block@archiver.kernel.org>; Fri, 10 Sep 2021 02:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbhIJCmw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Sep 2021 22:42:52 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:48502 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhIJCmw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Sep 2021 22:42:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631241701; x=1662777701;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=FU/d/KCgD0+4EsTUOrKouByWEjAvJSgMgwfOjkurrA8=;
  b=bYP+DrTmhJLaa7WRCKTvoanq3cpHgZCr3nk6azaabe77L7KJwpqXq6Nn
   wM2mYKYv6ikdO8PCiZHfJznS3IH6D1674gWxVJ/iSYqCfMyW9SnwfgAYe
   Dk5jZ/x33Ojf/F+GkknNWYUmVqinN0Zg5OcNpmAZTQjarXtyOivL9ulAj
   YACClQ7cHEn7KmoC5+Sfz2AWebNzeCDfbim4ODUx+Xy4imtVp8ktt4vVl
   pNDwMZTHZuVZNxg0lhaMm6IDr9l39GODPGv7+qROs4wXK/2REWA+97Yi2
   9THvD+WY7gIU+/mk6c9Sr4qHN/HDqX+AUGl7BwFPnKsMBLe2mkBf9PBq5
   w==;
X-IronPort-AV: E=Sophos;i="5.85,282,1624291200"; 
   d="scan'208";a="283438273"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 10 Sep 2021 10:41:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SF6BYdWXngom5S59TGaedglOgmiCj9NduXEdD3XssX3iS+D0oDo283FXf8WuoxFgA6MyIiwtdAud1Tfysqvl2XF7j4azRXf6wihWpZbY6Lg97+HOCKbM4uGqRjobmiZWI/acFAgoy+eO4AvbhpTkG8nC2zxdoHLrxQruZ3RsUXJAJRLkgf+O98Sju9z1/KpJ8vZJ480A+ku0BhRufmmKkipfThVMtp06Af4iKVBrISb71ssrx9uXX7MkR+DcM4+9BTeX1crriqvhuZ0xBTaCBsie4fSjl8BCp0ruPIOJ7Qd2MyIhQe3tAYfdDen5jpj8U3tsVdOSB0rSToqtJCAsNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=CuLt6wqR5ZZ+0cUHUn2h2QsY3bsoEd4Bgk3F6Z4qcH0=;
 b=WdcasKLjUw8g6nVULoUOmFyuWKNzaFRPLKM3nbhfZ5rrOl7xSQUhsa3AO8aoIjrfUxIv0JjgTzFSDna87lMY+Ti06CShfPqs+eNWNeYNeCuwYfPwjkkto8oc/bfPqeZNShwf0ZBYnRsZigPWks2apZbRHBp0jTTFLK/wcWlGm3/28cfLQZ+xpi8Vb1iV6oV0soDdu7LsPxBPybAsgeMSATCxG5mkMbWYXgPuEZBDBQdhap7qS2OHpST/ap3Lk02sydLXzdH6m3Yy+4ZrBwed2VYjTRhdB5KQFINiaZdnEDJNqjCfgtpPnJ/ax06ZLKoyjufadCnGM00EXWFqSRiFcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuLt6wqR5ZZ+0cUHUn2h2QsY3bsoEd4Bgk3F6Z4qcH0=;
 b=PjtOl8dkRe6GbnuFF90cH/CDEkTMxmfG6xkiDW6dmucop2NBzNTtwOdTtVabtjetK08yhE2GqvJcw1BPWPybldaBJNhD6TO7/65vp+tSlRJBPNC+K4yPQ/OKykolbv0AWfsDfUWO/SNorRHgzRyt618RQZ1sR81oPb/prBrpH7I=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM5PR04MB1180.namprd04.prod.outlook.com (2603:10b6:3:a8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4500.16; Fri, 10 Sep 2021 02:41:39 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::7c0e:3e95:80d3:7a70%6]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 02:41:39 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Xu Wang <vulab@iscas.ac.cn>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-zoned: Remove needless request_queue NULL pointer
 checks
Thread-Topic: [PATCH] blk-zoned: Remove needless request_queue NULL pointer
 checks
Thread-Index: AQHXpewHQovrrbMePE2ASlobFxTWqg==
Date:   Fri, 10 Sep 2021 02:41:39 +0000
Message-ID: <DM6PR04MB708112A8EA6B664DF234B610E7D69@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210910022338.22878-1-vulab@iscas.ac.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: iscas.ac.cn; dkim=none (message not signed)
 header.d=none;iscas.ac.cn; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: df6cc822-0b00-448e-a7de-08d9740483fd
x-ms-traffictypediagnostic: DM5PR04MB1180:
x-microsoft-antispam-prvs: <DM5PR04MB118089DAEBB57B2BEC5D8EBCE7D69@DM5PR04MB1180.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I4AWt3g03a8M/6pZFvKBcZUtj2bNejN0QeehyTtYRRfNZBlID+rEF3OEXtJZcjfMCU23n0fHoUH9OrC1CRIV0FEv0lcmE9UijUj3lj+tNKt9aupifuRUD0przd2e9HG37mGxolf2nhqvKqT/OlWIkGTmkOLY34dMWeb/WczFB2O87bbbHnpiyRAlv8EGrI/m+mroUJvrOauKbzIDH45yEbL4cLEuHsCqaXsGtFIIwYR7POrQ5SZimT7A/FZP938TL64H7q4+o8QHJruQS4Hn+yeu9+FL0AGm+GpGZh97Nl8SmJ9RLT+TSKbvnQUoiviv3KuMZwqx9jTKmSii6hehe1OQAWDmvYDN3P6tddbP/0NO/25ZuCg/eEsV7k81d4Ad71bOCYgczQuhAVuIOkcYft3ZbbBzMjUhx2AoO9kjx6Y0UBmaR9H1OP38GXe20l0Gn08SSjloCI1jGthg7xJ4MobNu1agkTF96PscOXxwya4VgkRvmb0uOvufZuYvALfvIzGZ9HTZU1JjFYav0PU+MeBko0WmbMi+XpCdOycvescpghQSOv6x/pMJ8Pz/ZeTLpZiSyAJ8bNi3IPE/DW3pjNeOeUyjJOBHkUVGmu0/6DrR3hVJwmRE4pOt1OLMJF9+KqOrSjQdxazvrhHOakFyYMN4jrf7WfQni7xdV2IWx0C7oT5hoDtJZoQT4TRxy2pIRrqb2H42zXjcYj2HuEbTkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(122000001)(66946007)(33656002)(38100700002)(8676002)(86362001)(64756008)(91956017)(55016002)(66476007)(66556008)(76116006)(110136005)(186003)(71200400001)(9686003)(508600001)(52536014)(8936002)(316002)(4326008)(83380400001)(6506007)(2906002)(38070700005)(53546011)(66446008)(5660300002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YvNb66+hELZrYBRGy3mKelI2AyLnRwW3BUgaaR4sg0phRw+aKrTXGasn68UP?=
 =?us-ascii?Q?a66WzpPB5gbQG56q/U6BsARW/0Pz/JR4Z7XDLELh2E6pW3ookDf1Lout2Pmp?=
 =?us-ascii?Q?GLU58Eu/+ALpFMpwvHFoq6jfdWt2oPSROesVIWVHxMUMvM9ZuiwVKa4eWfub?=
 =?us-ascii?Q?lyA1aIKxEkyDkyRgqUH/JRJUaYP9u7j1aVU1H0/BAKPZcnNwi5GriGovffge?=
 =?us-ascii?Q?ct9yC+KbJVqO8rV+I50nEPYJfXOw3hI6fQ6jDmT2kZJNzSiKG4BJtayLAhZ7?=
 =?us-ascii?Q?RsluMxrSdyWRw25sYwR32S+OJwIc0DAbpL1ehoQD+j+c7TmFjiLVS1zNKLZ1?=
 =?us-ascii?Q?oxuAgTa4/0nragclEjceXjOLDVS61IBHMSVli0Y8IWR66DKCkXeNsOnXooeN?=
 =?us-ascii?Q?mVbInYa3c7IYeE1980CXXs4KieRBSXY0nYRBXlYuODgX6OeEzH/Wwv3JpD8m?=
 =?us-ascii?Q?6CtocBkg9qeqwBZxtzUqqRSuvm4JaCVVEgbqo0xe4Vrls+a4kAGjkH6GK/q4?=
 =?us-ascii?Q?WWNLPdq0CatMHgib/x8nfeQZYYNZx7wVUfZCO58pODhdfEi08q2K671Fh13i?=
 =?us-ascii?Q?swLGifa75AQ4JgL/0r0VeUYHeuYrd9qOPEyvVYNePsWcrm1PGEOpFf1XLzQQ?=
 =?us-ascii?Q?HNG8L5jQzbeDRQ54oxmgcwvTRSNBbS+nrFdwm5w5gtFfRD4uzwfqocmMOQVm?=
 =?us-ascii?Q?Q2zGjVQDvuDRymGULkX8nTq/vUTZ9nnbtV2UmKl0t4K3s6O/E6UEjWQxbeXn?=
 =?us-ascii?Q?YGFIk5oHZm+Hf1HuUNUbASQ6LqA858fS12l1bzj+3iGM3RUMWBs8eArCWXUG?=
 =?us-ascii?Q?EmyBxd2s3ffnRlNy6oqKNcAut1aPH50S1i2ah+skeruKs1QLhPe/lLEjLJ+j?=
 =?us-ascii?Q?3357Mdji6mrfjyKZstQU+G+ye5CvTPJlt105rJ6Rh9Ml64KprgAshGe8ENFK?=
 =?us-ascii?Q?KWwxWgQLkoKlozaXrDBrE4Z0C9FUnV+18m097ge8G3hrMTKFmV97yZ043AKc?=
 =?us-ascii?Q?c2JhQLdeAeAVNPpkczUIgqwfJmLNof+AHL8I7Xwg6WYuRi+YywZXnFGaJ1ip?=
 =?us-ascii?Q?JOIQMOLlRB7Vu63pOFox2maexsNVwYKZQtqMO4g9srcH+l/NhD/PWySsx3tK?=
 =?us-ascii?Q?rgro4SYbAsSsqbrgkN+6a77iwVdz/IPrWJg9rCogZNsPh2ucSclEJ8qBPE/u?=
 =?us-ascii?Q?y/TEGFOzh9fEturw0k5jVpdxHA1FdrUQtev53FLrOwDEK5R+g3/THE69Ycg3?=
 =?us-ascii?Q?2RLUJlOnb5Hs49BkSMglYCEsZJgGxH5H9V0Q4aAwUrkuNLYQ3VODRAq6OuKz?=
 =?us-ascii?Q?2NZt2NgnbC6kwBcUDst8/Kpl+LsvEepojyATre1O4PRiqlT5gSAK8ntMsFpD?=
 =?us-ascii?Q?uPiGORj68dOFr7/wOcvkq2CKc+X1vl643q0D6eSfaqUu5yiT3Q=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df6cc822-0b00-448e-a7de-08d9740483fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2021 02:41:39.0167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8DRGyN85t3r2cMZjam9BVmQ5KkkYokKzNZvfjXiOUHN+GoIW7bWhKQEmcL8w3xWHKW8HoejYGr2vDLGPvRDKmQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB1180
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/09/10 11:31, Xu Wang wrote:=0A=
> The request_queue pointer returned from bdev_get_queue() shall=0A=
> never be NULL, so the NULL checks are unnecessary, just remove them.=0A=
> =0A=
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>=0A=
> ---=0A=
>  block/blk-zoned.c | 4 ----=0A=
>  1 file changed, 4 deletions(-)=0A=
> =0A=
> diff --git a/block/blk-zoned.c b/block/blk-zoned.c=0A=
> index 1d0c76c18fc5..5160972a009a 100644=0A=
> --- a/block/blk-zoned.c=0A=
> +++ b/block/blk-zoned.c=0A=
> @@ -354,8 +354,6 @@ int blkdev_report_zones_ioctl(struct block_device *bd=
ev, fmode_t mode,=0A=
>  		return -EINVAL;=0A=
>  =0A=
>  	q =3D bdev_get_queue(bdev);=0A=
=0A=
Please move this together with the q variable declaration:=0A=
=0A=
struct request_queue *q =3D bdev_get_queue(bdev);=0A=
=0A=
> -	if (!q)=0A=
> -		return -ENXIO;=0A=
>  =0A=
>  	if (!blk_queue_is_zoned(q))=0A=
>  		return -ENOTTY;=0A=
> @@ -412,8 +410,6 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev,=
 fmode_t mode,=0A=
>  		return -EINVAL;=0A=
>  =0A=
>  	q =3D bdev_get_queue(bdev);=0A=
=0A=
Same here.=0A=
=0A=
> -	if (!q)=0A=
> -		return -ENXIO;=0A=
>  =0A=
>  	if (!blk_queue_is_zoned(q))=0A=
>  		return -ENOTTY;=0A=
> =0A=
=0A=
With the above changed, this looks good (please at least compile test this =
!).=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
