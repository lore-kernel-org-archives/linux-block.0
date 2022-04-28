Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AAEC433F5
	for <linux-block@archiver.kernel.org>; Thu, 28 Apr 2022 00:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiD1Amw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Apr 2022 20:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiD1Amt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Apr 2022 20:42:49 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C2012AE4
        for <linux-block@vger.kernel.org>; Wed, 27 Apr 2022 17:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651106375; x=1682642375;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=NJMiUJazQdD0Yo5wdGzLM5mCaVShwGe94Tyybgtn7fs=;
  b=e3+VUiS6/erY7bQsyBiA8OsXgsPjWyjSNtDE4B32xiHVpOVVC7d75o2D
   l8uNdyhSBv+5va5EHsx93odQkSzOw2+h0LOmidfrxJiiill/TJloF54ye
   raAuBYPkaVs8W6j8WZeSur6AqdB1BbwEgg4qMMw0a+iFg2RPaVESBdqFK
   mtdFM9Ap2wZyY0wKXJrzM4Ik2+mJdiyMuQD+/XgRTzAIcuKioEjDb/0/m
   kS8FHd1RBuPGY0vZlDV4lz87Mo1Oq8zsqlioe0RTIRcamoTxYi4z+QqIx
   zbXRpgY+ggRnBcyfXzrcrtz4ijZeGM7exkoejNxFYosVRcR5U9QYNpepD
   g==;
X-IronPort-AV: E=Sophos;i="5.90,294,1643644800"; 
   d="scan'208";a="203877111"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2022 08:39:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kP9i5bGD/rnXi1xvDr7JSO6XPo4hLVpDFVrRSBD5MBfQQyoym//O6OZhJYNOu+mLQ5CV5DkOBB8YPqBHEoAPf5R3/gtdN/4It5SlcRbuutvq6x70c5v37/TUyecbIpsxqfgAcEV381v09v3Int4g7pCJM+4nccKg9aCkRyZ/8QfTIc4F6PjVABR6P/sBY3e7HmPPMuZNiEdYTsOkynvjZhsqdRazNFOrUN/WKJV5/f2VhQjSlfKrCG9OGhm5Kv8KeGHzeghlIixuUD+BhxXb9Thye2hzV9K9R34Y3SS0oFkZnrU8kijh7y5cvKBgJtm+gg7xoHwzspyDKXICzlPfRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJMiUJazQdD0Yo5wdGzLM5mCaVShwGe94Tyybgtn7fs=;
 b=kAK0JS9zjsG9huov/hLFSZJ7JYilNuHc/qRVcFPBeD1FaVcvnCSbcEAYKDgTHLti8S7VfCXIHSSxVb2NkwgfO3qVGHZFLiAYW68Ih3n+uHcurrEBANSqE3R5pa7LDDiluSlEj9qdtedpd6xmETYI1YXcoQlZ9tqbVG7LJ6iHnVSlyr4D+eIwlIHHCCP0RVPEYXaHHzGJF1rZNly5DwhEcz41U+7lKVjpv/cCZrmauNsW7OdLPbnaFhN5aRfiu7Wk7Iziy0NBijCInPnp3w8AdVicZenPVzIrSD6LeNA1lT+MNqPa+R53Yz1NCdmhlQVdNFyNUO/JKq5qQcP8lTWBQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJMiUJazQdD0Yo5wdGzLM5mCaVShwGe94Tyybgtn7fs=;
 b=srgSPyufzEyE5Rlv6k8Hd8hGX2DmMtZ2sxSbx79q7CigO3Gv75D9R6KDzd8JeGYf2u3g1jmh8vXkwO99J9I08UepIaOPXlj9krxJ1yGFC6KXRfvZYAZ42P0RdNjLQQ1lpIU+LK2acHdZTathMggE4ungpcfWj3Ucc8UGSkzoCCw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH2PR04MB6757.namprd04.prod.outlook.com (2603:10b6:610:98::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.14; Thu, 28 Apr 2022 00:39:34 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2839:2ab4:7871:416e]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2839:2ab4:7871:416e%8]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 00:39:34 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Omar Sandoval <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 3/3] tests/scsi: Add tests for SCSI devices with
 gap zones
Thread-Topic: [PATCH blktests 3/3] tests/scsi: Add tests for SCSI devices with
 gap zones
Thread-Index: AQHYWphulqRQoKoXKEGGt1AQMOSHiA==
Date:   Thu, 28 Apr 2022 00:39:33 +0000
Message-ID: <20220428003933.jgq3yznlhquacf2m@shindev>
References: <20220427213143.2490653-1-bvanassche@acm.org>
 <20220427213143.2490653-4-bvanassche@acm.org>
In-Reply-To: <20220427213143.2490653-4-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5c72ebc3-18e1-4357-dd97-08da28af90dc
x-ms-traffictypediagnostic: CH2PR04MB6757:EE_
x-microsoft-antispam-prvs: <CH2PR04MB6757603CFCECB7F7D718B772EDFD9@CH2PR04MB6757.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wnkqlcAupFFiiuT6X/4CTTsMGB8tWjG71P3xXOFeENguqsDpA67u+k9sE0jn5gdsOXh3w77Z9LJYff9zmGyU95ZEYylelSR5EKU1AaNMx+BHsW1bh1Af+G1wUMLS2qxs0Iqx1Bq08XgUqHwX11kRpY6Ux3FqeHSl+LhDxN8TI2uyPEAif3mrFcWbjbEfZZU03WOBJEPAI57v9tkwBWineVANXlwMbfmGfUw1VY9SVnpq9UVNhZX74/ikwCjPw+C+r2SiSqbvuTRDtTuA4/+pfJrT9mpRHWLeOCWf9sjURUOe/i9nzEgZQmajBUW70IVM1CL5EWnmQkBwV8uG6YWe+etL+KUiEIb0dO7f1NOetkaqFFWn1WXGA+vJxRxkgk5or6PidaTSaePWxVEBMRk1UppeXB9wOEEMVdhcOlsDV2a1WnbPf8DuxoBN/EYJhD60TUmgsiBP3qjEdnqDIo1s81zdIIEjel4EMWw/BOAyJb5v0fFSTqzIVKH6E0DYincvEziG2e45WHTCvH++mitwzyiVpjGRa6RsV2vKTI034WNHZc9e67IIvF10Dp+gLK81AaQDlcDo5xrvq+imdU+f1BSJs022IS6u5lsUuHRI8AMEti7XiTs9hl9ocP8YXUqL6Y8JuKm0rPasVTG0LLtY50N1R72bApiVkrKVr6s4CdFjcAFIqj8MU0JTZ/6oqPZHOIRo4iCk3DboqsyG5Dk5CQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(316002)(6512007)(66946007)(9686003)(6506007)(64756008)(1076003)(26005)(186003)(54906003)(66556008)(66476007)(91956017)(76116006)(86362001)(33716001)(71200400001)(66446008)(8676002)(4326008)(4744005)(44832011)(5660300002)(8936002)(38070700005)(38100700002)(508600001)(122000001)(2906002)(82960400001)(6916009)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?l06ZsUg65DxqSK96blIO6pt01xt7C8S/+KTlUy+16aQ5EGmVER6DMUBQXRnc?=
 =?us-ascii?Q?d7nUNOzj/sZGGSwKUCSsGNQ1TOQ93y+ljivN9koZRzPHO8t7OnFUnUUKfi9U?=
 =?us-ascii?Q?j9ff7ZV4eWYwOxBhYU8RE1f5rA0GCyS93b8Njf+G+2QtiiD5BR4ms76XeyL1?=
 =?us-ascii?Q?q7MZktBaENNuv17ZwkVMsAzzVHNm15++KLce3FktIiYhPD/ckodUWTJ1YHQ2?=
 =?us-ascii?Q?oeoXfilArycWx4IUkDsztYZopsB4RL6VVSuRqSZT1LQFTbWf4ESHO8cUe8a9?=
 =?us-ascii?Q?KMIY7Aahcg+Gl9E0D00aVsqlRgAU3JxpbopHNWIY/5cEowWpN7d7p8s5uCyi?=
 =?us-ascii?Q?1u8TWO8rhmdBTgBUb6GJrstJ/aKinFTjOHTWf9S5Jt142fS3ULXdcxyLh/DC?=
 =?us-ascii?Q?LZYF3kdFSQmhSz/L8+1dAVqBROIglf+xqZcLejLKLr22H6KRE+shNS+6Q3nu?=
 =?us-ascii?Q?5FLdc2+U2SZqhfvO+IEUklMVoWhIznEdKBDKaMi7e3x3VLlUMqcSL+2BuBzb?=
 =?us-ascii?Q?dVk42uiCmrfonKwc3uqZDmPhErYrP++ULiJGUeGGMIZFeUP+RjuhXT8hXFBq?=
 =?us-ascii?Q?aa0YmolORHNckUl53u+UEICpvFyBcDFifqrH5jqYoPA/rnVKr+yPTs49OgV8?=
 =?us-ascii?Q?Wmvr5zyRHGBdzcGCQgFonoFQuLFGPM+bKoLvbnQjoQMIhRAWClbpR4sCFo9t?=
 =?us-ascii?Q?lHI+F1TbNzTxD4y05SBV+rB0XRENhLqiV0iJ3lOF5uClASyb1OlhIPTSuGUp?=
 =?us-ascii?Q?wu0H2ek1oq+RpMg7Q+RHbqOVxv/MUnBoz9tNh9SzBquPIm9xflO5/ULtEAnq?=
 =?us-ascii?Q?HkQEfHo23qe0CrUKFGSvgfOLirB3obvRp+4ncxezoAPjI1j5B0a1R4tJaebk?=
 =?us-ascii?Q?DZugzst4wMyV0WlEsN+ofIzPgp7cYlWZre6yV7A47cdgVtdsUTNsZ0oQhppl?=
 =?us-ascii?Q?1Xc3JT1QyTKvup4YwBcP0sggpWI/9+oAEoqGztbWsY2uNkqHVDqw2nAG/h3b?=
 =?us-ascii?Q?2aiQ6xPudmbPGBLkiJkJNQeXzZPI37K9AIl+K8BNUlLtCAPFaACp5KB5GOMX?=
 =?us-ascii?Q?asBtMZz6N6UZuXnYXtHDPNqKxR12W6iiqu1m6N9f/rSXlpD55KaM/u+mu18r?=
 =?us-ascii?Q?8xEqL1LZZajetFaG5yTwDNNV1Beudz54fwFXvcfaV5GCxkh58w1Qi7//Xlk5?=
 =?us-ascii?Q?bh54RGk8CclmohV+o2+bLP0qzjuRaJ4OXIp0viLmZGdMyZYp50g+TLIqWI+2?=
 =?us-ascii?Q?wvyU3NEDJsurNyidCk7g1Vv+FFy8daYikWMuM6DKjHc7rsnG5ruWi7w2bIIk?=
 =?us-ascii?Q?gzTCRWVtot9xbr2uXSUINpmqij5nochDA0PeL7YeD/U9P10MHpIxUyzu4BNN?=
 =?us-ascii?Q?YfjxF/6xM4ymfzoi8l7f2Ud94La33M6T8Z2TXUrW7VoodzqDhrwjk8zuaViO?=
 =?us-ascii?Q?Vh2Q8gejH7I0c97lqHs3tR/jvhql46Jb8uhVwfq0f7Kf80u6cAovzMDRbG2T?=
 =?us-ascii?Q?ECDf1pA1WyjcPLCMF7xiJTGItK790Xgq0BX6OkfJjvzPla0Eg11OA/zEZyF9?=
 =?us-ascii?Q?AINef5fPqdqDmcIFk3yOfxTq6r5NBCpuivOasCbQU+iHwigdb7uH2+kQV2WZ?=
 =?us-ascii?Q?UUuMhSHIyaWOgPengVTfN36h1G2XGmsBrERuIHHX5Cd5RulQfI9jQKURTum7?=
 =?us-ascii?Q?CqzdO5jNtiuN7wY+GVIhgQ0RiGSy4jgjUkBxO89IE6CmInaeUJT4YhEfUBg9?=
 =?us-ascii?Q?DX/0QNH6qYDXa5qKcdwYTrroy8bKQxqoUXBYByF8tEnNrggcU5JO?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C52702751D103149B12CF643C859AB59@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c72ebc3-18e1-4357-dd97-08da28af90dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2022 00:39:34.0659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kL6gHRmLojsgyYHIB7GtOXASnTjUyLGSrCtF90abJVq0yxznQ8RLeO60jvOgyJ18XPtTOUGWjtemdeq7VOosgmZO+WNrOmT9ZyPEY4C9jBQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6757
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Apr 27, 2022 / 14:31, Bart Van Assche wrote:
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Hi Bart, the desciption is missing, so I expect you will add it later.

I think the added test cases fit better with zbd group rather than scsi gro=
up
since the gap between zone capacity and zone size exists for non-scsi ZNS
devices also. What do you think?

--=20
Best Regards,
Shin'ichiro Kawasaki=
