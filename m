Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC2BDC4743C
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 20:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C95B06023E
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 20:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbhFUULh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 16:11:37 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:21268 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbhFUULg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 16:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624306162; x=1655842162;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=lRRPGhCEr+aMaV2M7+VPgAkzMMNtSGUyF/myyIPika8=;
  b=OukzvCLjrddmffcblSBXGQHZtMorC7wyRvDakB7AGEAQpVwZTz2wM47X
   sOaOlSKzd3xDui3wMRDgKUkXODGh9Uz0dep2291wE+PUzyZ0QsNrI2Ilo
   G8F0GSikKULs1sccsZ4tpTES9jwSJ3NkhjHUQUgU7nZUSh3G3xPBQkeLt
   7cI/3pET+E0E5kfWo62W0oxjpidyR88Fjc2avkQ1jSB0WjsCB4zWqOYef
   yYf5G7wBCMhIESHaWx2kbqKcUVY5IFzCLuBWlKvQh4NbFhxnwDd2UDZZv
   xBehXb31RaE7yBHDPqxhnxbmHt5cO8mK1dhnjniiRhZ0wKfGHFUb+7xf7
   g==;
IronPort-SDR: nvZ2/TFrMhdjPUH/TtiTkNZTaYT3ER/tpR+4RG/Yt8tPJ9NEk1V7LvTLKt13Sqg2tpB77PkQ9M
 yHCEVLfsMe39dXh5ZhXyUN+haDrLEMhs/WdMyfmL53UV0saUKWrEH+wbF7dA33NLbiq0Rmi1vY
 VTzAfytDsd/QwmykECzn6e3Xw+ESyND8e8Khp0vr0GxGHhZYliVfazPdwPIxpdP/3JMGTLTX/g
 o8VCeiT6GORgHpkuw97L6En3skrRCU4Ui7NFqxRacaBgO4psMoox3GXYSmBwoM2hEziMt4yB3E
 gZo=
X-IronPort-AV: E=Sophos;i="5.83,289,1616428800"; 
   d="scan'208";a="173085607"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2021 04:09:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dl7i+Cw5e/bmYeawFuYPJhsNCFuYW9Swi3oZdurdtly+AQzYVHenV2PnMX2kQq8DSol0aUN+BU/9Bll/ofgIXzI6ythFr/7V/FJ54B2SYGj8cCSXT1eC1Yj+VkM72MbMKNnP9VEBCGT8lT0761W4tAUR5TYLds9E4SPOF9Sxgt0LcP/xPaTH37xcrHtmwJaZJfrCiGZNkVCisRR3FTI5cD2SkAqyGY3pEn9nwrtD9UI2f6XfWcr0BM+b+E99N1EF3iKoWu8U4WTvUHEnIharH02NUO8okgulWlQmTsFdQckKvQrl9zQ9BNbdZiydR/2tNdLrSXx2+Motnss0HaDU5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRRPGhCEr+aMaV2M7+VPgAkzMMNtSGUyF/myyIPika8=;
 b=Yf7WSoyigFFhlC+rtq+1c/G/8qPDIH7dXX5epnKKa8FAHdQpl+eQQdeJR5VRvNo3Bto7eYnFblCIJrf24lbuDUPfioOXxnwuadZFMnDAIQll2FeAQnYQqT6aZL7TQlbKxNgO6KPKKf9VUhLL+94/uPrK5fI98GzsDb+FfJ51J5bkjFH4HhJyXVPQa04n+kWasyvSSMW+JIKYpXlo/tWixjjVerxEg7VW1QudBgYgiR+kGlozNH032yE1sZf1Vc43EEIevv8bpOau6TJS3Awi80eJy8ot4aeMQJJ9jJGET5GB5xc1/RBwSDJ50oF3ABA/qe+vUi1XdF2PKPdeqi9U9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRRPGhCEr+aMaV2M7+VPgAkzMMNtSGUyF/myyIPika8=;
 b=cHjLx6vySxUnfxwItDSA9m9Hv/INftw85eOEmPB4WI10MP+ATuOWFKAvppWxDp3ZgnyBG734RlBC2cmhpxoeaVZ2IDcjPOj+e+tlU7Oy1zoevLoEaNPhgagLzSpYqYt1bcxVxKIcOpsjNjcrXvwf1N6M97VcZ1OHsqKl6zDvn6s=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6245.namprd04.prod.outlook.com (2603:10b6:a03:f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.23; Mon, 21 Jun
 2021 20:09:19 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 20:09:19 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 3/9] loop: remove the l argument to loop_add
Thread-Topic: [PATCH 3/9] loop: remove the l argument to loop_add
Thread-Index: AQHXZofpFS5SFTD+kEiP1eERDaLIvg==
Date:   Mon, 21 Jun 2021 20:09:19 +0000
Message-ID: <BYAPR04MB49653BEE2EAD6B60E21E5D97860A9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210621101547.3764003-1-hch@lst.de>
 <20210621101547.3764003-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 204c4fea-e580-4bcf-4442-08d934f0742f
x-ms-traffictypediagnostic: BYAPR04MB6245:
x-microsoft-antispam-prvs: <BYAPR04MB62451DED630838053BEDF9A4860A9@BYAPR04MB6245.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kw4Usz/wssPBdlQW51pmFN9KjkRlecaT7KBdYZs9CJmgbAji8gWN852Cq5ait0ekwMKtrefnIZaezK68QgUInaAzARfU0Zu1W5A94Mp+Na0F6XeIUS8zfpm7hyEkifDWrX4Mnc5KKuPZL9wYnstRXSc/lKI9Whd+dhKI9/61YAlq/kuZ19d7oE1mO0JEjmUXjEF6EByFsUeJsfk/wQiIq7+mkRe5bwdE6jjzvBwmfWBfgk/BvogJ1MMIPR0G10vtIyL5PFun0gtLlkU9Pjt+YLmd7kevybkDtWexA5F6F1v+7T3jUwPtkUXEZsNQDTx90QUT7VeqfUQtCTIgMBcbuch7fvNcdlwoLb8CEdttaiVOis4cwEoefqzWfDonJTmNxPsMhzH+oSC2BaAYMKoJwzYqzyh5pFia4jtmdF6/8rTb+m9MdSQt4uWJD3SptFAl5UMzngf+nualjxrx7WMWtys5KIk3Z78W+UqArXZ55hFcdaSKEL1Fj09hq1hK2THLCozMDR7AxamPqCL5HyNavXQ+s+XRpfIPlWz33FQDQPFW0lv7bLYlyjPMxNRSs/deo4LYIZBnZQocr4UkMI2Oj2f85Xat2WAh8QxUHGw8kVg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(376002)(39860400002)(346002)(396003)(55016002)(52536014)(66946007)(76116006)(5660300002)(66476007)(66556008)(64756008)(66446008)(558084003)(9686003)(122000001)(38100700002)(86362001)(110136005)(7696005)(53546011)(8676002)(316002)(186003)(26005)(478600001)(2906002)(33656002)(4326008)(71200400001)(6506007)(8936002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?s5ZWkGuqGflfJ3HwQarkJ7rFC7WIfMyxB5tgdLasjHgtmjxlkW5pfLOFsnpp?=
 =?us-ascii?Q?PQHYrbJLMPDHfrzzngSEYB45rdkj4UVp2GQSKh9jFy8atU0Rir0OApYJN53b?=
 =?us-ascii?Q?uzBGZEgp3cFxqSMx5axaGTtYQjcfGjuT+PEV/yqOCwofQUx8GrMhMtx/CgxO?=
 =?us-ascii?Q?xVRip/LJoTUCeDtycvFrIJiVhzXIhbkgNSsyN7NymzJDXRbgqHnSZl007UCG?=
 =?us-ascii?Q?Gl+RJMrorCPOooOLr6mvDfcNmmc3ZhviCMOZ+ql3/ne3fn4heR6jfWgzROi0?=
 =?us-ascii?Q?PKY5lasLtjY1B/XIZzKczCLHSesYcHaaIJBPaSK/J7lb5hXVBzh6kIhDUfNS?=
 =?us-ascii?Q?ysPAb3x0MlqDzEFihbYw+U6510TnhY/z4Juinf+3kSf0KhrKcGMszPIByqrN?=
 =?us-ascii?Q?od4fXQPGaY4oWAbpuWc3DpM30qnegXqIRnB4otc3vxzqH7yiqp2HRrt5T5EI?=
 =?us-ascii?Q?ZnHrQUId3yvE/+UPvS0i4NKZVG0mz0q2IYjYFcc+vSYBC1MZaaHIR3BHIi2d?=
 =?us-ascii?Q?ypKu5S1dUSM6GNKS7H3fQqEA3/0uDRYdit5B9aA77sBuDxS6FC6BboO6akof?=
 =?us-ascii?Q?d+KS4635PutfdqG/cOLhE7Jbbu3oju/d1caiOUqmyupFCKCBbZhokgKhUA62?=
 =?us-ascii?Q?jaNh3FB99RllHxjsUZB/6sztCRe49FpHE+KZns2ONUysea1CtklhWAiRXARl?=
 =?us-ascii?Q?/Olr7FE3MDLYvt/mVuNCeA8GlPMQ1N9g/bUuikOKL/SjCTiZ9RAb1suKO3I5?=
 =?us-ascii?Q?CN0LpC2PNCuq+AQxoTDL0X90EveS0lUAGziRBUyxe0f4yNW/1tyEcOtbM1CO?=
 =?us-ascii?Q?+HP7k9WTWD/k3SVyYFzl2tUsRgw/pKVpOGMm0cA6XO6Ua8iSVb1QBhpr967/?=
 =?us-ascii?Q?lHley1mEURKucBUsjRkVGkaVj1IjivuD2EYqMKoPJTyaI3HotNKNZRS4Fskh?=
 =?us-ascii?Q?HVc0CyKN7RLLGNBuoIJEQg1eqJq/9izGCPV01CFHDH58fy0gC2T8bMlPDgfH?=
 =?us-ascii?Q?LgdEXploAtG01PhnvbwGMkWX2b/5nr4+X3sQUQ98kjMxGWCaLjNDY4Z9VbwJ?=
 =?us-ascii?Q?FQ+qhavTSsMK2dIlG94UymD6a/XO1XWsBuGDymZkuT+p6nvJOaPJETAvBtWy?=
 =?us-ascii?Q?x0E8KjW6uVhDpYK18Ev76yGOd0gBw5SHO/3zyv6IOLdDh/UUYrB4COtdjEXB?=
 =?us-ascii?Q?DaerLt8xea02fYjXYLPY29F/YSy4BhhxW2f+1P/NCZkOuaWI7ndgMM95OawB?=
 =?us-ascii?Q?CKaJLiXIARd9n7Yu1QjFGnPCPZSu8+Egvg5jVJJVuco1V3KRqnEJJ6r4ripl?=
 =?us-ascii?Q?SeEwxzbJgJzR55s33lCSQw6e?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 204c4fea-e580-4bcf-4442-08d934f0742f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 20:09:19.4966
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ga3GyJW89bGps0HdUS42Fun/z4+3Ub9Awd01sqnaNqr4UKqbTsN9PoHH2PIyL51+2jT2EcXYdP7heH/2Gzg0Fz68uMpQEpmhy5lvwyTeV4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6245
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/21 03:26, Christoph Hellwig wrote:=0A=
> None of the callers cares about the allocated struct loop_device.=0A=
>=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
