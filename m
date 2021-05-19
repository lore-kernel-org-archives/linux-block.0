Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D35DC433ED
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 07:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 704106135B
	for <linux-block@archiver.kernel.org>; Wed, 19 May 2021 07:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236951AbhESHS1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 May 2021 03:18:27 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:55221 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236024AbhESHS1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 May 2021 03:18:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621408639; x=1652944639;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=5TuVGBuOUkFTxNMPpXVuVNyzBB5gqJLqJPcrm/kP7R0=;
  b=brjPhJAm/uVWtpzx3N3j6UgAafbSR/rpBG+gwRp+LR9g7AA114J0B4du
   ExCAKF9elc0+u0WW0eUNPg3I4P7m5sC8HeFv7bEBdaom3idiS9ENTtZmU
   CybSL4p8p9EdU7h/AjqprA1vDBJgQDeiJiETtD25cPwUPJ5HrBBUfJeCT
   pAt2Ew8yj1ZNZIB5lbaggKhC11HVlBlTLt1ydx8BSpMjyeWkgFOPBElSh
   n1sJCZdBxUSzJ+TPfUCTFwy586zDEO5pHO51HMl00vV90RVEMejX+ey5V
   d1wsw6RdoXuKAyVDbQw7A2EgMTyYQII4BaeV/gAFgm6mC1zehCbLso6ba
   g==;
IronPort-SDR: TdLQDsuR4fWvcF+30WATnpaMfpEa+UR/jK+hWYW5RX0J73HZf6Ar48abIhYTVCDElwvDRCBHNd
 Bbsr8ZYz68A4tpznksBwxE/v5WN+lEPLi2vPQqhND0Zsgr5DHmssWwuFKvlHRHEvEJj04ZQAWw
 Y0d3wZUy24TE2T2wuoToGv+iXmlSaM4c5n89eo96znqGPOKAkA05fHSw6Uc/oYWRhMLN55CnPQ
 FCQEO31412aXn+Z9T5BwgcjKQP3G72uJ5ftkvIdHFE4fl9agGhDqTI97FnZRM+osw0J1BGlRy5
 GWA=
X-IronPort-AV: E=Sophos;i="5.82,312,1613404800"; 
   d="scan'208";a="272616563"
Received: from mail-bn8nam12lp2177.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.177])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2021 15:17:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGj8j7S/c1eOu4YzM/1ASUg3tZd+eKQ6qr7wonrrRc6iMnnRcCJfO6MOsT4a5m+R326gwjQOff49QXh6iWZVyIKznMljPWcx8am8H9iAsFbczo2g7tXXFon3zgm1xmrafgEmryDXkSqHjpEHFrIB1rTXrFDBARhC620Mv5zWiIIt89VNIG6/gOwy0kpgq8vJjEXjULkVT7F5+feOsxgUGcr5MbA6lwtr4p0vQ4aHZrc0U15iw+sb7cWoLBkfIzq0ifkoqB1dYUMyOI4wQGQ3L31RYvmBYJI9qJ/xjxat3FyVpSQjDTkD8FLgSEBFyKy+4UlO3AugU2neFbJQXUkMOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KO022Km2ZrwAmu22f9Wca8j5Od/3DanJkrFL+l96Mtw=;
 b=ntH14p7pm0hxC8h2C057Mvg5EaH1S00qsubwn2DC6J2wfxHRleciBgBIQ0fJb7h3hXjt60L/nv2zCh1WmXj6revP/pEltu3UFbK9r01mmUqgkR9yj+g0QHsy8ef8OoJtY8uqtreANu+e8f9IGj0EcUw3YXLRGIre1LgrkGZ506JfkVG5ss7gplio4rnnBwLSZPxEvUiFxugBx4FIKJPEDRB1MDharW9sb6sm0KUFjr6gdl28pvLrDEBu4KKPb6/Qd1vvPYuIxyyRrlMNRMMPtcIVYSXDaJ63a/ORQDPathp7XFhiDGoJ8hpAv2QHj0ZTV8p30+7ekLIC+FF1ug6H9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KO022Km2ZrwAmu22f9Wca8j5Od/3DanJkrFL+l96Mtw=;
 b=fYmLPMd28CxyKnZi0j3SN8DbVSA2VrqlXP1aTmdUocizKszrvyesQ+PHaXM3Ylu4aHuNA1T/mDqjD0THbKjuyw41UCk0y30tjuMb6f3iT9mKaVY6WNrf0Iu51CXgkmh8L/fHtpHG8BuvKeC52E6leGNYCWhnw87wzP58tTqttwk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7509.namprd04.prod.outlook.com (2603:10b6:510:5b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 07:17:04 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4129.033; Wed, 19 May 2021
 07:17:04 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 02/11] block: introduce bio zone helpers
Thread-Topic: [PATCH 02/11] block: introduce bio zone helpers
Thread-Index: AQHXTFqE+W22j926kUe9+IgAVyhqCQ==
Date:   Wed, 19 May 2021 07:17:04 +0000
Message-ID: <PH0PR04MB7416EC127D2BB9639E82E1579B2B9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210519025529.707897-1-damien.lemoal@wdc.com>
 <20210519025529.707897-3-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:152f:cc01:95b:718f:422f:1ec2]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9d9b73e-7163-4fad-252a-08d91a961a94
x-ms-traffictypediagnostic: PH0PR04MB7509:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB75098138189633FA805F36E19B2B9@PH0PR04MB7509.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Z4J8BaFmWYu3s8dPTvNM9N4hSQ2QpGm1JBgb6oh42z8zb/2oGO2pNA8zU+fQPxXknDawWUPCBWW70ZO+0HZ3GS765TZskyvKfv5Q+aCMCS96rjusleynHnX5CpqVHHPYEqvDeh8mRkGZNonDz8s7wrCKTPsdgU9U1J8Nbb7ST1dPnu9QaUc1ePXGoj7tuLEFkPh92QeFJWFJ7F+23KcsQojc3+BMvO/JJNvy9reIbYwemhO6uGAv74Ce2SIMUbNkW3pEe8qNiqryKcExJcKME2Xu1fM6w5F8jPpgS3Pytn8TLJB1DGaIYV7HRLtKnZdY+sfLmkSNVLhqCJNR1dFAXLDkMxPy1SfvE/ctX36jepYgr301mz1TRln+u9R2aW4U37Wh3e6P8qRL9ouQqdvx631SC0mzjYhCEA6BBCMDo19ixEkYl0E0+5paUSd1CbaLkprN6ef+OhaoqcLqzM+MSsU9vtsl5xXYhcnfH6Vv09xtTNfyzl/t4nBkjPt21VipR22o1k//5oi3Vv1+X06eS69gLT+7/wXJSqeuXyqjoEbykhaDrMO0z1Q3I0UbkiOH74nt4H3nqKn0GwyPCn4LXne1qXTJSowYu+8rboTwN7c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(366004)(39850400004)(71200400001)(55016002)(66556008)(64756008)(91956017)(76116006)(52536014)(5660300002)(66476007)(66446008)(4744005)(66946007)(2906002)(33656002)(53546011)(38100700002)(122000001)(186003)(83380400001)(9686003)(86362001)(478600001)(316002)(6506007)(8676002)(8936002)(110136005)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?CBNYk+fQTO1sFmNMEQwkCxSODFhkQzSU9RAcWN+y1qHkHUdO+zXYKAxND4nW?=
 =?us-ascii?Q?lAxtZGa2w/fEY588k+i0FzpzGHuhtvxKTBrlZqJzh2TEzkvVXkpdYBfdWPAL?=
 =?us-ascii?Q?SCjvfjEs+CE0a9XjByZjw0JAwscGWFisfssHSCS7KHHPXIctDxoy700OER1B?=
 =?us-ascii?Q?IDgUE+e1yGBUTAO5Zm9YYvtUOUv9AZUhNKD1U18b8LnokaPaoFVnRPQt95cG?=
 =?us-ascii?Q?80Dlx2aXK+Dwloe3Dp2FlabLO120jNiD+3iC2HnSKeZK9oI6sYTeCHphCSGb?=
 =?us-ascii?Q?Y0VdLR7Iv82gcNBJU7MGGs5N96ypfkEH89+PlXfWFlnrMug+U8LpbtCaIL2g?=
 =?us-ascii?Q?p0Vkz8bPJELtPrduwDKVWHRicxNXX48JLqt4XdKXhgBN3XaYhuFOOBZACVe0?=
 =?us-ascii?Q?ZGbAq/wI4bYq7p3RaIR1rqnHUAuyzkHseBHzyyPPbGIcb/C2eaHUgR7TFZvi?=
 =?us-ascii?Q?lr989svVi//Tc5+L3N7fjBBefcOSaDObqBdmi3akXiTzs6pjQ8ix/CqM/xSZ?=
 =?us-ascii?Q?UrfoY7CUXoD/c028UmYpF+6w9zsvem1dWxybmQyDcNSY0HCUPc+QodzmMnRa?=
 =?us-ascii?Q?m8Eu1k6/Fc5LJpAXhRa5cUJGfH+i8zxcIWWBM1CjQjTlzQXAGE5rsj0IdvN/?=
 =?us-ascii?Q?8cy3GCAAH85ygTPo/3TUYFCFXM0eYHI/oaqaCfAd8O1xEUfRDFwEiSoWYVyN?=
 =?us-ascii?Q?wdX74P1fbX5WgZgajKadV/VLdZjogJ/GjwdSSeuGyyp8zR+gO/N4K0RL8/we?=
 =?us-ascii?Q?gSYQOurZaM6Wjw8BDavlWGeajmZdqeRYfw4zvIlFOJozihzyxHrSP07V14E1?=
 =?us-ascii?Q?B59DuHbBXCLox7Lypoh8NibgyodACZsOqLNWvIuR6DGAHu1JnK3ocOk8bpyp?=
 =?us-ascii?Q?qLPKChY3zwJw+cw8kNwgxf2RoWhhPEtHToP3b7UG4LJeams9pItFIe5kQuEN?=
 =?us-ascii?Q?nKxz2tDFnYRs0bquKLWCaPzqLzhnUDcbq+Ol3FCgkPmk70TzWwRQs2Lurki6?=
 =?us-ascii?Q?vb/gcCIMXVM0jn0XL7Fxmnj2A6M79CJMPByAbRLyDFYoZNzImP/Qg0v1FOj7?=
 =?us-ascii?Q?jbDlq+9kkmIf/qLxTOs1Ft1Q14X3XSVnUuIi5IyRWLZnkJTvu/gr7RvKbipv?=
 =?us-ascii?Q?LkjOtu3sbKV7mJs+O/5yQSf4SN76jZ2UktASMoAavVvr2JlR/nI9NtFuVFkO?=
 =?us-ascii?Q?sAdSF3MM5B95B/VinVkXyjLWp2y6P5+g8SV373dk4LAf5y4OVVK8LxFflfmX?=
 =?us-ascii?Q?uiP07/eK/EtZOkFlO2WYdpxqCyxw1lC9inaKvYfoEWCHDbmi1QsLrfLxthHx?=
 =?us-ascii?Q?AjmArfuCMHPmeZYIdfXS4F0SrJfmJqSeeE+xAipqMApyeYgdSA76tN4WX5c3?=
 =?us-ascii?Q?m9xPB+HV8iSlgCqv3w9SjdBOw/gt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d9b73e-7163-4fad-252a-08d91a961a94
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2021 07:17:04.1166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EeB1jC//xTIL5RudprIh8l0PCEQpIOpFWLsTE7BVY1xJFYQ1dEKdFxlOxCpt31vyYJNwor8LK9yvcka3bROY1cY+gBOj2jB2IIxYUi4YYiw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7509
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19/05/2021 04:56, Damien Le Moal wrote:=0A=
> +static inline unsigned int bio_zone_no(struct request_queue *q,=0A=
> +				       struct bio *bio)=0A=
> +{=0A=
> +	return blk_queue_zone_no(q, bio->bi_iter.bi_sector);=0A=
> +}=0A=
> +=0A=
> +static inline unsigned int bio_zone_is_seq(struct request_queue *q,=0A=
> +					   struct bio *bio)=0A=
> +{=0A=
> +	return blk_queue_zone_is_seq(q, bio->bi_iter.bi_sector);=0A=
> +}=0A=
> +=0A=
=0A=
Can't we derive the queue from the bio via bio->bi_bdev->bd_disk->queue=0A=
or would this be too much pointer chasing for a small helper like this?=0A=
