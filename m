Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C23C48BDF
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 08:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6947C613BA
	for <linux-block@archiver.kernel.org>; Fri, 18 Jun 2021 08:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbhFRIyt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jun 2021 04:54:49 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:40765 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhFRIys (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jun 2021 04:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624006359; x=1655542359;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=TRk9wi6AKLw23motMMPWKQKFGNEV4yz0mw9Vq3fa9U0NqA6PrC4iHsOw
   EVeSbWolc4Ti3IfQyZMcijf4Y1tgV3J4SCwErLnjAwzFHR1/+KrDZchUr
   4+uKw0BBjUZJaZEjpHLwAU8lc5NjDRtSa+14tE6Z2Iqewty9mxN2fAoyV
   0wZ7IJoVMcDPTRHnxeecW0W2UgQDwxxWh5OoKHRS6JA/Q5h0FOt1mEDx7
   /PAsQeeYMMLkPVKKiYMPo/YemmckuoLhme5P3ut0iw8ieE2dYj+r29Nr/
   rRwwm8pD4lhgTSkzOsP9O3OsY7n4yHNe1nTELGIm6rZk5jxCO4A2socLW
   g==;
IronPort-SDR: CFxfn5CD/8tTBGILWXORxIs1YlLNHf+q3kIYxGHq/JxTYEoWzxtrRqmFgx7xtW87HfLbDHmzUC
 rHoMZk/+iaJBtnm5KS7J6RSyxH9Lr+KkN9gX2YcAT7DtE0SyGAE0nE3lK5sgywc31yvl/9CYiY
 AE+g492wdlsKSMeSf2vF0P2S0GfUS8B0MAPjP8O8/1VG8aK32xAykM0pO4mQjtR45zM+2Vy7aU
 2piG9gYsKMjtdz7/wF44GcOypoOEqtjW+kHLiWAE6NLoV2QkaltV+dxjl91MK6eFASehyOy/2K
 AIY=
X-IronPort-AV: E=Sophos;i="5.83,283,1616428800"; 
   d="scan'208";a="283764504"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2021 16:52:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEVK0VU26l6hwfcmPGB9LpP1sfYSfw9v73YphBspfGvTZb0xRAqc0c5ervGb7mUNinsXdowveh9aJObKKaJ31HLuoIRKBTVBS0IORGgTrsetp/c0Jnm1CRBmay/BK+j+otrs5YaV6Xmo+q3TuV+IpD6dV0ZilO4BNp6DkcCV9Ft5yu+jbXkNg41isSPXivfgPk3WcYoO2ai6RDju8O+zQuRHgwbR73mypGWWzC8MEDOAtHOx0Ei4zjCQyhuOJx3mMGfe02zgz9MWXkM8SR5cdtbRg8VvNBU/HMzvEsjZjOFZxmGac6hQOZzY/i2XqyVhM8R0QKf81L7gMQP1dNNKlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ccYygYNroIe/HWInWacM/0MctDfYNYOMPvbOzcEONsUKegBEeG5wjsgGWctbpMcSrVE1fhUYIIJwSw9u80BiDROUu4NpyAT+DZ38Glu8UWdSicFAtmfUoquveEH1bJNe8kx68mGygiOz6uATH1/0UJiMJ0J354sOup7g5vpz4uW3UrcqA3PPxTfslWF4Zt89Ju8LiAuwTVM06cx9/4S2xZhVxxl5d4IatU0hk503+eK+aAiUIHqLAuqRbPUNa7FDderWjmfyU/MStdMNB8n4AMUedcDKdS91Z6YprY1Sq2OqHRt085RjX+1V+PPH6yj+qTK7r7zAK1B7wAGecBVcSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=c+mIo/Vjicx3p/w/2/XzrmVamIvMOe8PPzT6upYEfLsVrR/jIuaDns808nIS5xuj4vpFEcU5/Nh6XT+cluwfFuyEGptVDKACsGbTVgO7k5L7StDf7mvQdqvGboUpcNQ/9L3MDEaN3Mkigd1B9lSqS3qSnfaXxNkOn/GEOSEfiMA=
Received: from SA0PR04MB7418.namprd04.prod.outlook.com (2603:10b6:806:e7::18)
 by SA0PR04MB7291.namprd04.prod.outlook.com (2603:10b6:806:e6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Fri, 18 Jun
 2021 08:52:36 +0000
Received: from SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::1558:a76e:d14f:a80d]) by SA0PR04MB7418.namprd04.prod.outlook.com
 ([fe80::1558:a76e:d14f:a80d%9]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 08:52:36 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] block: Remove unnecessary elevator operation checks
Thread-Topic: [PATCH] block: Remove unnecessary elevator operation checks
Thread-Index: AQHXY+WZtFcBOi4pX0S9e72Q/LcT8g==
Date:   Fri, 18 Jun 2021 08:52:36 +0000
Message-ID: <SA0PR04MB74182E3D744EB02ED71B61DA9B0D9@SA0PR04MB7418.namprd04.prod.outlook.com>
References: <20210618015922.713999-1-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:15c2:9f01:4974:661f:80a8:bd3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45ed5c7e-f480-423f-1bff-08d932366ba7
x-ms-traffictypediagnostic: SA0PR04MB7291:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SA0PR04MB72918B7886E7D14A54B54E3D9B0D9@SA0PR04MB7291.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2hR67tVYZPw8riSd8Omdl/pcsRnE6KcwfgzGlRmxCGZ6XW1KE9H/ywEd6IVt+VpydJkDPVYLn9yQHo/okxa++YoGTYNtBA7bOFq+chb9EsrHRnufffDTdoXnh63Bz9c6cIAN2N/SsAkfU0I/82n0tGbBelnByke5QUHWG9mWesk5TiIf3PDXWJQXeiKmUS4KqJLtXZzV/CPX+kpMvPxylbunFf0ixk7FBn6s2vrvjYdhHPWYDMkB3QktXiysUb9BpnIMixyu9732UTsMckBa+oOgUmg+aQXhXWMnNCvqSZuXloxxWQG3m3eTMz/AspMQG4k79vGwtK7zqOImWtGD3z63mN2yAsTZx1aoho5MhjF1hJrz9YuH93TnJKU6JAJWIWunYOTmYuzPPxs/TqMsG1ubbZdI81EJE4RYyDwxyw4+Yxsp61lkblNKdoZw2I6C+dx872mXDH+djlk4Ay+0lM1TwuBBgTa3c2okoKpVUMGe2QzcfyRvk8TKUBH0vLrSzsdEgUtK8LCnpHfXBmQhX6c5NJandUZi4dO58NHUPF1vuudvjWQ1eM78AqXAyRh2BTmmNSMp9ZAuY6U4LL2QLZuvGjqGcflnrDpXw/ZUEnU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR04MB7418.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(55016002)(5660300002)(9686003)(8936002)(316002)(110136005)(33656002)(478600001)(19618925003)(8676002)(86362001)(2906002)(91956017)(76116006)(186003)(558084003)(66946007)(7696005)(6506007)(122000001)(66476007)(66556008)(64756008)(38100700002)(66446008)(4270600006)(71200400001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/kXQ8Pd8PbThMLfIzLLPPT7FiwgpEVlf1esGrvGdaLl91g6JsR7lrVSVfVcg?=
 =?us-ascii?Q?GQdTZIMIt1vyVgfz/MqtWf+sBhJ5ZZrnSc1tk68fHXHidQZjG5WRCSKOYrpY?=
 =?us-ascii?Q?0aYQOLeBPuDxeECtePoHPZytWbOrWqZjACMFxdSAC4TBTVTANfMNFgcVu1qo?=
 =?us-ascii?Q?ZGhZkKWYjvwiuG6KHu++2N0N1QYMrNe2c/v96efsWBZ7dMPdYaYSJx9Iok3M?=
 =?us-ascii?Q?0Lr2W40+oQa/8u2IUQ7b8PrazMibDt2Z/suAmAA4SY+sYBOriY4XTJ5nWlEI?=
 =?us-ascii?Q?FcB3VX5CEvo8VwcTjzvq4Nx1qpsui+Mydcr8l0i1BuluL7VefudOdENgWj9N?=
 =?us-ascii?Q?QC0DRJVNgcbN/P5rhaJYFL7T38vVh4GHPibw6tn+BTxV7oEhFfe/rFJQQsy2?=
 =?us-ascii?Q?w/aYyqMrJSQ/+bGyxOFFVAjeM0Dbq0m10fgIUkgsgKxHvY+d/nXbHWX9xTc4?=
 =?us-ascii?Q?te8sv0hWX5FwcJ+jLmYCKp/VwlTUdIyAaP69QRdBaMO2wJOhnBYkCFH1akJT?=
 =?us-ascii?Q?pFHVaR4d+zCXADFV1tUrxJ3HnQ4QmHvD64hSglrZSYJdBTK2SUunlCaD7tl2?=
 =?us-ascii?Q?JrXy6q8k20RGyxJYI78XKwwk91Gi2r6pOmJ5dfX61TwKq0uEHVtE3rn6arRn?=
 =?us-ascii?Q?ApQ3/JC3hUC7AgrZ6cDDLo2+DVlhyToTlOEOVgSOZPY5yfYOsQBriQfNjnX2?=
 =?us-ascii?Q?2QVWd7q1xPL6nsOsuoOYtBVdwxn1m3p7QrhqEmBlvRSaK+rUkKLVBwFOSOIZ?=
 =?us-ascii?Q?BBWBFX5KgjHsotKF/e0E7aICE9FENAzJstKeQJUmw3yB/69jESSdF2lWoygF?=
 =?us-ascii?Q?eZ5xZ0XfccLS2wTCKJSZGU1UvFaov3Sz3C4XuL41t2cGxRgAAb4eiyWVL68k?=
 =?us-ascii?Q?jLsm0vYldWz/Q7czq4xi+A3B10Pq89xR9ydNEFFurtdWQ7sN2v8Um/BVq/Fa?=
 =?us-ascii?Q?L7Ar0oCtFgOWiHsCwtqQTnXLVRjAvSf2rKSyGGpzODW6pJsMpotJUZrG1BZt?=
 =?us-ascii?Q?mupo2Bt0pys0K9VNWymfLo/3rq6DWgCqWvaWf2ye9tHgt2jKl0TgFHUOgEjB?=
 =?us-ascii?Q?u56fl5P8V5LdN5VvyTgv0uLS8FxUqfW5fPtgsHUFCGMK6EoogDPWBYTEoC4x?=
 =?us-ascii?Q?QwVCDL4jvhWfZkOxljdL648c9nAp7exMXxiEKm1dtBJaHOySj75edM/xrJtE?=
 =?us-ascii?Q?qK1zSdqGJAlkkSFDe8ghOn3eYmmpBRnAh32OnQs8TqDAx9WdfyzZzDx7frVZ?=
 =?us-ascii?Q?PqBQdOehmgVO5LZIXWqoiRxf4si0qjYctADbe+kE0AboamcQ0fSGKHdceSUA?=
 =?us-ascii?Q?OoTZHKvTgbLwpoXY7rA9ZEoxEvwcRkkMu/gf3n59Y3q79MJHGaBqx5+fqoBB?=
 =?us-ascii?Q?8jZs9EX/oY/pEpXo4jnSnT6lZ0GX?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR04MB7418.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ed5c7e-f480-423f-1bff-08d932366ba7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2021 08:52:36.4705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rfl1MJ6envDDWTCCEoT6jJFkun1R32QeQP8TtQuXDVmMcdsEl11faUxWBx9h35oMeQ8cDr0J6x0CUhozjteLCxC7Z/HVUkUlpFKITEQZRrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7291
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
