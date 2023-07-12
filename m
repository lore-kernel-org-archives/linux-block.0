Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BAA8EB64D9
	for <linux-block@archiver.kernel.org>; Wed, 12 Jul 2023 05:22:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjGLFWM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Jul 2023 01:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjGLFWL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jul 2023 01:22:11 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E3EBF
        for <linux-block@vger.kernel.org>; Tue, 11 Jul 2023 22:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1689139329; x=1720675329;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fr5i1qgPstWdMEzP7ZdEsi5IPCo2iW1kqJ/WbxmSOco=;
  b=abPTAScJs7AOwCn0WrA9KaIn4Jtd3Ep3E3Bzdq/q3iSfnfFgI5+YP1WL
   ZTgU+HlfQDm/mvQk9lrfFlgGW1ARnTKFzlY3BXURP1zAirzsl0Cju7/Uj
   gnojcQsLKnlH9Z85ancw0YjXYEYiDW55JpDK6nSr5CZIXvOe452yPPwWD
   Toy3FUJc9EzhHjW3f8gx5KB0IM/mmStvnVtoPgqmbNgHhZsFvyd7P8ayE
   76vc2WpAY5lFUI8uzLxO7ekZE0mIJwPI/74uSupR/8zJnDcpqzwRiDr8v
   eb5k6O+wwL9sHuiRNpc6TeUAPe4fMMO0mTa3iGRfxFTQNJoxfLN5/M5Qp
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,198,1684771200"; 
   d="scan'208";a="238139594"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jul 2023 13:22:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mn9NufH4np85Ut1u1Tajop7J8rFtQ6E7l7b/LT/JD80bNgo5xUCkgKTx9XysVALsQIjJwi/bvLGI4BiKV0nIyml5PMM7g05OqUUFYHWmxXIfEWll4VrGJUaCxXl9LJb9+6Ol8sfGii61gVZvw8dtSjppXkPndtg+ghShbuDYgrmeJCLxFDxlxhQzUdVz+eEm8xX2DBHt6qXCmMlaOEw5QiIZvJroiM1CuDnamh1q1m7lsJfS9mkhdSqWO9dHu2p8QgZzZG6KedQHKsoMNc7WARjodA84nSlfCIkTduCR7KmusgLx6a5NsNzcn04QRTMmQw/hUFIJs+qHLMYHSfb/tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rir31Qe8ZAGH47nayTAXH9o8RWdOxklylNzCWeinX1E=;
 b=DjPZ4MR0EyzJg1hkEjZPl7vwgFRBdjXZ5Ot0lB0IgM+t4P3oLZMmnFyy51pJSiPJT1OVSsPO5z5uUBXpApXPXUMZR0J4xK8TH+ik/1EAazDOkrb9l5FKKYtx742WvGtD8ueuAGgpEcaODzCENBCcLLHZH0gWfmSUTURf4PTyNpfE8XC2FrMyJr6aw/Jru7KzaV/cUKwWMuTBi5IvsScr18F/bZfzgalffglIogspr3RXO0zhbwCDHolXFR5ZMZ8xH7DWyjDp+vgP5wKJk22L/LzkAEVsYvTmZDx9yXwWUiM0W9jrvp2xzNBqps/RdMj/yzo052ETtkvaJDfIrpsugQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rir31Qe8ZAGH47nayTAXH9o8RWdOxklylNzCWeinX1E=;
 b=KXqNo0I6krKU9CetZH9n4Bc4GS0OEyWzlem36II2avdOkKwkK6YnQrAOZUk9w/msF/ByGS0VmG3cUQMjRsR/kYQbtBq3JD625uosc1BXJT9jYwiipJwxuE+2t2jvcVOI/lPcqHEWNnU/f8M+ysOMjoZoZ7vtKlhbUQyEMlzGTbA=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB7058.namprd04.prod.outlook.com (2603:10b6:a03:22f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20; Wed, 12 Jul
 2023 05:22:06 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::bfa:d453:e7e9:8f98%7]) with mapi id 15.20.6588.017; Wed, 12 Jul 2023
 05:22:05 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [bug report] EIO of zoned block device writes
Thread-Topic: [bug report] EIO of zoned block device writes
Thread-Index: AQHZs8xrY1lbBaheok6QQEG72lJ04q+06BsAgACxzoA=
Date:   Wed, 12 Jul 2023 05:22:05 +0000
Message-ID: <egblcneud3cfyy2oewcdgvw74p74kqp5o7gh2ghysfinbui7cn@anithj724h77>
References: <5zthzi3lppvcdp4nemum6qck4gpqbdhvgy4k3qwguhgzxc4quj@amulvgycq67h>
 <75043b78-c1f8-5268-ade6-62a75f25708c@acm.org>
In-Reply-To: <75043b78-c1f8-5268-ade6-62a75f25708c@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB7058:EE_
x-ms-office365-filtering-correlation-id: b34d03bf-b1ff-47cd-0ef8-08db8297ee9e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3ayEbX8L4Sj63rNLFbmfOXAuyBBMN7k8XaKvdK2IA+EPoI1qXXVgKC2GVUYqnN5v0/kMslvi10DWxU57ynaqb7eHSocDdy8mNlBvygTZko1+TocxCnomkesKQidhqlUj0r4TAwFqpZDBtFLzQ1D4+rAltHXaIomJTJQV2lsS1n7zyT/c7K7OCOEwRRx3QVw3POWC+jgJ6AGSp/pbscHcszuHvXUG7+e5OQCyGL9h9VZDxsxxDp2JIk1Nulk9MQQYBfN/7g/9IHsq6pKMJNUVgynL5QlWHJcP2s/DxrLoCtU8JcvFvn0WmywdsRk6C3FLnK/hdCLEEbjxheFQQeAM3/B0n/nhO9z/aEwDEeU2WZZIECgs0Baaw/6qty2zWPNpp/alBxlu4Cr870u+1DT5zYnFnOZiMr7HvOlHxWr576aiSVWfCxahT0yoo2Jz8kOQjtbMHMZYBFSV+YXk/KS+Sn7OmJxKncbmKy9r5zWOGkldnCQUrHCikvcGwZi5W0NSVc61IsK7792Jra4TxCd1jZ43JjdDq8i5cWjXlJ/UswQ36XjHcwLjJl/qGaImrb5icx28M/v3eEL+X7U080b02pfh3lPcqG2P7882vYFrX0fjC1UYC0gyaYiR+BTM0+v0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(136003)(366004)(39860400002)(346002)(376002)(396003)(451199021)(66556008)(66946007)(66476007)(66446008)(76116006)(64756008)(91956017)(83380400001)(54906003)(478600001)(82960400001)(8676002)(8936002)(33716001)(122000001)(2906002)(4744005)(86362001)(38100700002)(316002)(4326008)(6916009)(41300700001)(5660300002)(44832011)(71200400001)(6506007)(186003)(26005)(9686003)(38070700005)(6512007)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3bRiwR04hUT58MYlQ1Mkjfeqv9Cj/WmYSf54FEZ3zz8EcR9Bk8U9KgUdu1c3?=
 =?us-ascii?Q?8u1krMFgaLVWblQD2sqZ7xttL5f5kIEO8csTAtrjhrzwiPDanlCU2Q/Y9BLp?=
 =?us-ascii?Q?Se5hy4doCNFg86FPZ2hw4SLl/9fnkIzvF7/JeTxVTB3vvr0qN9j/yNKa4clj?=
 =?us-ascii?Q?eXIFkKwiDu9GzQcA9DMRRan6i8cRjGG4ZCOTi0ZlLAidi8v1yeR7w768NiED?=
 =?us-ascii?Q?cNORcAJKzc4gouI/aPfQJIepZ41JdmlPu/JkFsQ6hR+ssn2douQ07rs+/LIY?=
 =?us-ascii?Q?Kd7OIIU/0bCV5dyZLuKISjNxg3EeaH7cyveF+Fy6oIkeG69mMP6O9IITr5PV?=
 =?us-ascii?Q?2ElYMrOtZ4o5EQD6BYjC0wBsT/nwNKTKfCbyXdkOn3NA9Z51SpKL2oNeRscB?=
 =?us-ascii?Q?upz0M7XOBia7JqF40Q7Y254f+MYYem9YWrnj5Bp2nNlXunTDa0gV/Rtct3MA?=
 =?us-ascii?Q?2dlszdasTZjEoW9O2FevJDFShdLPbJpT2vjz5HFIeMvwwCuctJ1pQ56ApJ0n?=
 =?us-ascii?Q?Io1Q/nU3+XKE+jlNmBiUZqr1srXZ9XAX0M75xQHGsECRviunrfDhjk+NcBts?=
 =?us-ascii?Q?pDzMtqSEZ6vFVWY9EfVAEZbgiJ5DR0jx8ZRGswAOPLPGeF6OJoudYWyKWDhV?=
 =?us-ascii?Q?v4myrzcAErA/o3HkKOApxvVF//M5PiCjs38Aw9OcpR+cuJ9k+289W4som076?=
 =?us-ascii?Q?y9ykNG5+D8ndG2XmepLENuwoxb+P1F03b5g+JNZ0cAn9+fPvbhIN2oONkcXh?=
 =?us-ascii?Q?966kQsezO0O4B46+8zhL6a98uDCpDaAwDOaOW2oW5Nh/a/85XNlVxJUb86dD?=
 =?us-ascii?Q?TUBLY4VRChJB0Mwz6DbYaO4oEmVkpp5N9VrU5pMRwkD+M2rhROUeEwwKbgxm?=
 =?us-ascii?Q?eF7OFphmktXaSS4xcmwqcSGNNxivw1eOCOx5hOX3CY53VJuYtutskYxhoo28?=
 =?us-ascii?Q?PMJEroDRS+ZpF75lHHb99yLe8R+Nh6oVQneoxCQg4UFGoxInf/KuyigFm7wj?=
 =?us-ascii?Q?a7RRIkBKkEbuPvuUHC3xwe6DXfnblRX70weVtrWmInR+4104R66wwGHLowUq?=
 =?us-ascii?Q?Ke54ZNr1VXoB/rqdc5K5D9W5s3nZOeYMdMoDxQF36GvSluL0wbcg87lUedW4?=
 =?us-ascii?Q?7umfkwL5ynvqqu4gv2yHctLlNy+zYIzFl45UzySREvhpzE5MN+yolB8LjEAr?=
 =?us-ascii?Q?xW4ewiVCxGekGef7Ns4Yux2kGtcKkimPJGyxsD27vaIaxgP7aD76g966LK8m?=
 =?us-ascii?Q?UobB29mPbndMUm/HD79tuVOITrOExCrQSPRUGV+BNpi8BLyOrKsm9eX9mpq1?=
 =?us-ascii?Q?Ih4KA2nmVYE8lRwkxFcIntqhVaW626h1BoqBUdO8NkEmNm+J5JiKvEG+21TN?=
 =?us-ascii?Q?R8UfXMKcUJGEF8Xoh5qn8UUlqUA4sekJlHkmUSCKTBznBUYddE8dOEdH2Nf8?=
 =?us-ascii?Q?9L7b1HyEVPkzziNwksIhblUIpZB91qMsSVm5KbjAa+BEyQkOkSmvriQXgiOd?=
 =?us-ascii?Q?s9XSAGjyDneLoA6jSW6Li/02oc405hZ6HHCfvpLszkF0Ez6Nd+E+VGmSR2ut?=
 =?us-ascii?Q?pINRybiwERgaVWUDkUYOTVGw5R1iu2220P5Y0yNw78/NGh/TvJndMBz4zZGn?=
 =?us-ascii?Q?mD0WR8LhMULqjmUmgTN6RX8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9EFCA234BDF70942A23F2ED962C8CD81@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: tno18EQdupL90rf9muaz81P7EOVM0yp+JrnucOqyL/Iz00XSoc18MO5ov+lNdnYMukGfB0jsLsAz5k6o0n4C3UZW1tcFlYZHDPJuVITh+HNdkkbP2sWc6m9i3ofumUMLOc1QV6KcdXY5rlNGGqtJpSI2wd79nV/TmWRY2vmIaxCIqZyUeFdgAbz+j5K62Ip1NqTgOTFMB5yvv4jAZzT7Ywg2DXCXqg1PjR7658/1PRRof2GAa0jWmJHwh3LCsWzp/iSrDEMgWpzDb/whOvuoLB1LMv6hlncgG1sJWKYkoQCqX05wkSni3cR3tvM1i2J1J86Ft2oaHog8Zl83qC2jSEuUb/RTyhge5HAKtqZRZ8fJ3CDE1xcT6bsisiPIHDTrORceL3Wj10gB/a7DgSHeePPhySx7/c+eAyyNYCYoPyUUKvfsoES1rUNH0SnDy20ZKkZf5N+Peu2VZ7+EspD04pGFjNWuL1eCmgwtAuwbmJnRYEIWgl9qVX0M2x3msbyRoD+AmLOivaepY5iD4nUwMV/hsqtJMKeTaSahCa7XYaorVL50UGC7QmjvntEl90PzUIaLgjV7270JwfqcwajtlT9u1vY/lbXlLMnWmooVUPD9TQkd+5caTVD772CtPOTCv9qgweGG2vCk8Qw0LoI90uKXR+REkUWf5PiiYVARrF6PtLh7Wht7IY4t5F4EYaayv2aRMDz5YsikEarlw5EHh7yfbMyFvjgCNWXCiRMF4bz3ayNNNPLqWNqRPWxFOvp2VhKH3jA6WXyG/702/dbYh8UjpGPGsV/E5dorq024qxc=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b34d03bf-b1ff-47cd-0ef8-08db8297ee9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2023 05:22:05.7555
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ndH0Dy6UFG7Q4ORRxdFm5NW9uiPppRTSVr5b0VGZEnIKUSQHfBqZFgTWlHxKUL82LqU/XGBUePanjzNtLU2rsrAIfUaxg++nFgMmpo72A6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7058
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jul 11, 2023 / 11:45, Bart Van Assche wrote:
[...]
>=20
> Thank you for the detailed report. Does this patch help?
>=20
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 6aa5daf7ae32..02a916ba62ee 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -176,7 +176,7 @@ static inline struct request *deadline_from_pos(struc=
t
> dd_per_prio *per_prio,
>  	 * zoned writes, start searching from the start of a zone.
>  	 */
>  	if (blk_rq_is_seq_zoned_write(rq))
> -		pos -=3D round_down(pos, rq->q->limits.chunk_sectors);
> +		pos =3D round_down(pos, rq->q->limits.chunk_sectors);
>=20
>  	while (node) {
>  		rq =3D rb_entry_rq(node);
>=20

Yes, it helps. I confirmed that it avoids the I/O error using a zoned null_=
blk
device, a QEMU ZNS emulation device and a real ZNS drive. Looks good. If yo=
u
post the patch as a formal fix, please feel free to add:

Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>=
