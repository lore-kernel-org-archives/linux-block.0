Return-Path: <SRS0=w0su=DW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAA4C433E7
	for <linux-block@archiver.kernel.org>; Thu, 15 Oct 2020 08:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AA6F218AC
	for <linux-block@archiver.kernel.org>; Thu, 15 Oct 2020 08:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oGUYgHqO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DzaqbLJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388341AbgJOIri (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 15 Oct 2020 04:47:38 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:12139 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388337AbgJOIri (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Oct 2020 04:47:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1602751657; x=1634287657;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=z6OfILx12L8Lt7laGIzbdssFISG4SvQeAxV0tKRyvSE=;
  b=oGUYgHqO4Dn0d6VdGej66UlkER2nY4TLiEW6rUILbTPPratpSakgR7Qa
   CHwn672f5cwyyn90xKrVaz7etxRmQOrk4+TgUEpazVg2/2pzN/OE3bNmh
   jZDXa3P+Ws98wZPzfL78sowa/0IiCqzsFTIuY+4GfU2Eb5wLzP5RCGST/
   0YVDXywcaIK5/1k/0yuZocJwm7Gwf5k3WLiiHWYUd1QeGA3ZAsW/O2X6y
   HIS3hJo2iceXUO6oGcKkdYF7k2+sl+W4SAQBAFW2MJp584nfUgCNMMTQL
   fWYSZTCErATgbh544xjZlTcNFcbtEte4WtBSPNcLEmJfRxgDN+87PYAEC
   Q==;
IronPort-SDR: ezCRQtYq+qTdnFTiWdihTIbMUl00Y4aZLpxYHqmj4xlIINip4lFdo6Hhmw72nCUcMzScONiD5O
 sAsIKtSQUt1CfQkC4jiet3GQnWytVoQlKGQ5wwW9yQd1nrNkcw5cV6mZSltRG8KOKcEMKCz/td
 ywp78kZuQXJF9ozbl3Vv2ZiWuMHijd2O+9bu9vWkA25dWMlSOY+RcAulZ/2Toe9sn1ubbt4z6P
 FnjSRxR0kovylDcPJwq7st38QrfYiMLM3vK2qJBRL270qOvjq22kjydzU/xqXyEvKtRyddaK/C
 VBg=
X-IronPort-AV: E=Sophos;i="5.77,378,1596470400"; 
   d="scan'208";a="259810580"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 15 Oct 2020 16:47:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m+rORMphK8wvQgi3Pj3XBVQwSqvGeplnC85L7MG64+hvKM4yAtjhrU2+5KuEJm434UdnV8NmceswBAdOZyF/SP4WBnCK7XE36Ftep0HEh/W+Jy1S6vwzoHByBgvkjKaogoQg4/FIaiQX72zLElaX//ek4H7GXAwe0zA7XlgJxaKlVgIMG5r5WV5im/mqAbTOUu6HDol0dBsEgeYTsSFBa0UNy1yvz9tdg4aje4xArnM9c1nPBiopQF6LEa0KLjHunJmcTD3aCF072qgg5Ig7KQxsC35omUtSPdLHKpwdG+G8tNV7dvzUmEqTsastU1CTsE2ghkNYAcvCZl594KfN+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkaWqRVh3p+fOArqT7hOBAj0c6lREf0RGuEk12lDKwg=;
 b=Hf426I70ckx2jl4D90llo7Xfkjl6Ypjuo0vDLdOuqKQQ7EdYHBxxPdJ4cybd3ai8iQfn5OB/d4ScL2xMS1LZOW37GXaGzcP4i7sHKVM8fymtpKJkWtFqklbGT8xerygHmNIr7Lx/ZxcUJ++Ki7COKWKNs/x4Wpb+zbDadF3ZK+JTyJL59ww1odmdb0EF7ArD/4ocaEMUv7rCD+MkyEH4fEJ4BsC48bVhv3I9t/FZSJ4g0th/xVUb7OujrCWMrtZgrReNpNTr1tSJ5KEgHnHcyMFbbgYwYgbhIqZhSXb/SN2lGNC8gBZij8trrr8Yc18OIGGiC3jEuBDzEQ7vvFaavQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SkaWqRVh3p+fOArqT7hOBAj0c6lREf0RGuEk12lDKwg=;
 b=DzaqbLJprnPw8zYQ5iLAzQVngtj+dywm1bzKEpoqCzybjSsLV6V1v3AoNs8WOMzZ43EGO52+QzCu/kjfZ+rEuuSYjrKq21SxUlaSpgw6bef8cKd2ooRsre156fL511Hd95gdCzOu8SXcwjOq4uGQ0hBX4+SYu/BYGT3sbrPST6g=
Received: from DM6PR04MB5483.namprd04.prod.outlook.com (2603:10b6:5:126::20)
 by DM6PR04MB6794.namprd04.prod.outlook.com (2603:10b6:5:245::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Thu, 15 Oct
 2020 08:47:36 +0000
Received: from DM6PR04MB5483.namprd04.prod.outlook.com
 ([fe80::c8ee:62d1:5ed1:2ee]) by DM6PR04MB5483.namprd04.prod.outlook.com
 ([fe80::c8ee:62d1:5ed1:2ee%6]) with mapi id 15.20.3455.030; Thu, 15 Oct 2020
 08:47:36 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH] null_blk: use zone status for max active/open
Thread-Topic: [PATCH] null_blk: use zone status for max active/open
Thread-Index: AQHWopYLsbyfVQZEDEaz/66cKZkCSKmYWnuA
Date:   Thu, 15 Oct 2020 08:47:35 +0000
Message-ID: <20201015084735.GA148607@localhost.localdomain>
References: <20201015015349.1400374-1-kbusch@kernel.org>
In-Reply-To: <20201015015349.1400374-1-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9fc451eb-ceb9-410e-0aa8-08d870e6f70a
x-ms-traffictypediagnostic: DM6PR04MB6794:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB67947A87E86D0E61E3DFF471F2020@DM6PR04MB6794.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I3A0VIE+i5cRhuU/YroBRNC/s/jq6JWHBArrS8bH0DdUFNQsBBtLzMw5LNNYy2OOknUf9pf7aRXKr08JiW70CsY/7VuJ5ZNoLMDi1bNd4KtpILn00XPspiqnkl2mHZ67o3jLv4RIDC68ecS3XAdHdZONSNSBappTCQ2dLx5PESq10+su0KlU3GhweUF5gAfOfqcGsT7bjxRcnB4ViO8JpKzCHy6hcvMMozIJ33aSQA/wbWOtnEJmM56hEMENRMQW4Ah5G8JOCXp1pi8KtrHFR0BXSiRHa9xGU+2TXRrLqsVVngUf2Gxw4IN/s99xsZRbFNeV1sYTqsJ3hHa/CUtoeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB5483.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(316002)(5660300002)(8676002)(4326008)(8936002)(6486002)(6512007)(86362001)(9686003)(66946007)(66446008)(478600001)(91956017)(76116006)(66556008)(66476007)(54906003)(64756008)(26005)(6506007)(33656002)(6916009)(71200400001)(186003)(83380400001)(1076003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: navcMQxSfpesqg12RQaqkzlywQFBlZJyCC+w02DXdWx46QgKO3/e+2G6QrBCyqryOG9pc6oH/FM51ACeq48ehoLxrNSjmpJUmf7UGiLhZdy1b8IHa7OgDCZ4loSF8YPH9Z39/UXvTBMO5PDXU6g66OVQYq9/9hypl4dgfwtVgNS6jtp1utJe3nmL2QeB7WofPGMOczhSTSXKcY2QORMiiskRJ9ErlWf31BEC9cKXycJ8PnmqVx13oUAtDLid4tJF3wlMT0Y4pBfYrmrGNkWm2bc4b+0pIUpNjaoXVzgL4y8UwlxQQ5clJzSdX3itdV49Oj6+CRNRMcqZn5n79vTz7Amw2m+48LswT4sp7tuqKst4Bj0naWMblFRsoWMTDQ9HOR3OuZIaN6IeptKlY2D5XNxY6MqFCa+msETOkEmsntZU9W7aZ9+QtIaYuVGUFXy/OE7p225ST47gS8hDCH0+oZ9Zd22Bj3Rz3Vb+Apykqk8hsYx/CHYKhhrfTj9vth6MtXUgoMn97cwiSF+LD1eTuDKnKUz1kXP/BJ26BGFSTurdVR/Q06lmISljDVW/VINRUJbj6dx7JKjI0E/gXR2YO9NX2dIy2cmFMa18/urIZOw29DIwqjklhBbVjhnhP2NF+Ho/E6xm0RDWWxQcku2G4A==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9B1388AE1F695B4AA10E9278F0C0B65B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB5483.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fc451eb-ceb9-410e-0aa8-08d870e6f70a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2020 08:47:36.0475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZtdX321cw06BbhRgIPwc30NhbTw7y3AjIXlkrH/pdDRdwdNtesQrENlzJexQesqxAZ/2tctJDisLS6kZ5o/hRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6794
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Oct 14, 2020 at 06:53:49PM -0700, Keith Busch wrote:
> The block layer provides special status codes when requests go beyond
> the zone resource limits. Use these codes instead of the generic IOERR
> for requests that exceed the max active or open limits the null_blk
> device was configured with so that applications know how these special
> conditions should be handled.
>=20
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Niklas Cassel <niklas.cassel@wdc.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/block/null_blk_zoned.c | 71 ++++++++++++++++++++++------------
>  1 file changed, 46 insertions(+), 25 deletions(-)
>=20
> diff --git a/drivers/block/null_blk_zoned.c b/drivers/block/null_blk_zone=
d.c
> index fa0cc70f05e6..446ab90153a7 100644
> --- a/drivers/block/null_blk_zoned.c
> +++ b/drivers/block/null_blk_zoned.c
> @@ -220,29 +220,38 @@ static void null_close_first_imp_zone(struct nullb_=
device *dev)
>  	}
>  }
> =20
> -static bool null_can_set_active(struct nullb_device *dev)
> +static blk_status_t null_check_active(struct nullb_device *dev)
>  {
>  	if (!dev->zone_max_active)
> -		return true;
> +		return BLK_STS_OK;
> +
> +	if (dev->nr_zones_exp_open + dev->nr_zones_imp_open +
> +			dev->nr_zones_closed < dev->zone_max_active)
> +		return BLK_STS_OK;
> =20
> -	return dev->nr_zones_exp_open + dev->nr_zones_imp_open +
> -	       dev->nr_zones_closed < dev->zone_max_active;
> +	return BLK_STS_ZONE_ACTIVE_RESOURCE;
>  }
> =20
> -static bool null_can_open(struct nullb_device *dev)
> +static blk_status_t null_check_open(struct nullb_device *dev)
>  {
> +	blk_status_t ret =3D BLK_STS_OK;
> +
>  	if (!dev->zone_max_open)
> -		return true;
> +		return ret;
> =20
>  	if (dev->nr_zones_exp_open + dev->nr_zones_imp_open < dev->zone_max_ope=
n)
> -		return true;
> +		return ret;
> +
> +	if (dev->nr_zones_imp_open) {
> +		ret =3D null_check_active(dev);
> +		if (ret !=3D BLK_STS_OK)
> +			return ret;

I've been thinking.. I'm not sure that if we want to return ret here.

check_open() checks if we can open a zone without exceeding the
open limit (implicit+explict). ZBC states that if there are implicit
zones open, we should close one implict zone in order to satisfy the
current open request (which can be implicit or explicit).
However, ZBC does not have an active limit, so it is not obvious what
we should return in the case where we do have implicit zones open,
but no room in active limit, so we cannot close an implicit zone in
order to make room for the current open request.

I think the most logical thing is to treat this case the same as
when all "spots" in the open limit are occupied by explict zones.
i.e. I think it makes more sense that null_check_open() only returns
BLK_STS_ZONE_OPEN_RESOURCE.

For a zone that is currently in BLK_ZONE_COND_CLOSED:
calling check_zone_resources() will only check null_can_open(),
since it is already inside/accounted for in the active limit.
So it doesn't make sense to return "Too many active" here.

For a zone that is currently in BLK_ZONE_COND_EMPTY:
calling check_zone_resources() will first check null_check_active(),
if there is not room in active limit, we will return a "Too many active".
Then we will proceed to check null_check_open(), but here we already
concluded that there was room in active, so here it also doesn't make
sense that null_check_open() can return "Too many active".


How about something like:

static blk_status_t null_check_open(struct nullb_device *dev)
{
	if (!dev->zone_max_open)
		return BLK_STS_OK;

	if (dev->nr_zones_exp_open + dev->nr_zones_imp_open < dev->zone_max_open)
		return BLK_STS_OK;

	if (dev->nr_zones_imp_open) {
		blk_status_t ret =3D null_check_active(dev);
		if (ret =3D=3D BLK_STS_OK) {
			null_close_first_imp_zone(dev);
			return ret;
		}
	}

	return BLK_STS_ZONE_OPEN_RESOURCE;
}


> =20
> -	if (dev->nr_zones_imp_open && null_can_set_active(dev)) {
>  		null_close_first_imp_zone(dev);
> -		return true;
> +		return ret;
>  	}
> =20
> -	return false;
> +	return BLK_STS_ZONE_OPEN_RESOURCE;
>  }
> =20
>  /*
> @@ -258,19 +267,22 @@ static bool null_can_open(struct nullb_device *dev)
>   * it is not certain that closing an implicit open zone will allow a new=
 zone
>   * to be opened, since we might already be at the active limit capacity.
>   */
> -static bool null_has_zone_resources(struct nullb_device *dev, struct blk=
_zone *zone)
> +static blk_status_t null_check_zone_resources(struct nullb_device *dev, =
struct blk_zone *zone)
>  {
> +	blk_status_t ret;
> +
>  	switch (zone->cond) {
>  	case BLK_ZONE_COND_EMPTY:
> -		if (!null_can_set_active(dev))
> -			return false;
> +		ret =3D null_check_active(dev);
> +		if (ret !=3D BLK_STS_OK)
> +			return ret;
>  		fallthrough;
>  	case BLK_ZONE_COND_CLOSED:
> -		return null_can_open(dev);
> +		return null_check_open(dev);
>  	default:
>  		/* Should never be called for other states */
>  		WARN_ON(1);
> -		return false;
> +		return BLK_STS_IOERR;
>  	}
>  }
> =20
> @@ -293,8 +305,9 @@ static blk_status_t null_zone_write(struct nullb_cmd =
*cmd, sector_t sector,
>  		return BLK_STS_IOERR;
>  	case BLK_ZONE_COND_EMPTY:
>  	case BLK_ZONE_COND_CLOSED:
> -		if (!null_has_zone_resources(dev, zone))
> -			return BLK_STS_IOERR;
> +		ret =3D null_check_zone_resources(dev, zone);
> +		if (ret !=3D BLK_STS_OK)
> +			return ret;
>  		break;
>  	case BLK_ZONE_COND_IMP_OPEN:
>  	case BLK_ZONE_COND_EXP_OPEN:
> @@ -349,6 +362,8 @@ static blk_status_t null_zone_write(struct nullb_cmd =
*cmd, sector_t sector,
> =20
>  static blk_status_t null_open_zone(struct nullb_device *dev, struct blk_=
zone *zone)
>  {
> +	blk_status_t ret;
> +
>  	if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)
>  		return BLK_STS_IOERR;
> =20
> @@ -357,15 +372,17 @@ static blk_status_t null_open_zone(struct nullb_dev=
ice *dev, struct blk_zone *zo
>  		/* open operation on exp open is not an error */
>  		return BLK_STS_OK;
>  	case BLK_ZONE_COND_EMPTY:
> -		if (!null_has_zone_resources(dev, zone))
> -			return BLK_STS_IOERR;
> +		ret =3D null_check_zone_resources(dev, zone);
> +		if (ret !=3D BLK_STS_OK)
> +			return ret;
>  		break;
>  	case BLK_ZONE_COND_IMP_OPEN:
>  		dev->nr_zones_imp_open--;
>  		break;
>  	case BLK_ZONE_COND_CLOSED:
> -		if (!null_has_zone_resources(dev, zone))
> -			return BLK_STS_IOERR;
> +		ret =3D null_check_zone_resources(dev, zone);
> +		if (ret !=3D BLK_STS_OK)
> +			return ret;
>  		dev->nr_zones_closed--;
>  		break;
>  	case BLK_ZONE_COND_FULL:
> @@ -381,6 +398,8 @@ static blk_status_t null_open_zone(struct nullb_devic=
e *dev, struct blk_zone *zo
> =20
>  static blk_status_t null_finish_zone(struct nullb_device *dev, struct bl=
k_zone *zone)
>  {
> +	blk_status_t ret;
> +
>  	if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)
>  		return BLK_STS_IOERR;
> =20
> @@ -389,8 +408,9 @@ static blk_status_t null_finish_zone(struct nullb_dev=
ice *dev, struct blk_zone *
>  		/* finish operation on full is not an error */
>  		return BLK_STS_OK;
>  	case BLK_ZONE_COND_EMPTY:
> -		if (!null_has_zone_resources(dev, zone))
> -			return BLK_STS_IOERR;
> +		ret =3D null_check_zone_resources(dev, zone);
> +		if (ret !=3D BLK_STS_OK)
> +			return ret;
>  		break;
>  	case BLK_ZONE_COND_IMP_OPEN:
>  		dev->nr_zones_imp_open--;
> @@ -399,8 +419,9 @@ static blk_status_t null_finish_zone(struct nullb_dev=
ice *dev, struct blk_zone *
>  		dev->nr_zones_exp_open--;
>  		break;
>  	case BLK_ZONE_COND_CLOSED:
> -		if (!null_has_zone_resources(dev, zone))
> -			return BLK_STS_IOERR;
> +		ret =3D null_check_zone_resources(dev, zone);
> +		if (ret !=3D BLK_STS_OK)
> +			return ret;
>  		dev->nr_zones_closed--;
>  		break;
>  	default:
> --=20
> 2.24.1
> =
