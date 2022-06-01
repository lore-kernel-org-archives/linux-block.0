Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7312FC433F5
	for <linux-block@archiver.kernel.org>; Wed,  1 Jun 2022 00:32:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbiFAAcP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 May 2022 20:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiFAAcO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 May 2022 20:32:14 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D3287204
        for <linux-block@vger.kernel.org>; Tue, 31 May 2022 17:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654043533; x=1685579533;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dpO+EO9hQPmU1fYYPmSWeDc6Th0NWzRbCqJQLVyaSx0=;
  b=WtLkYPtgHWrpIcBWG3t+OvnHrPSfK30dJWWu811lbmC6Dh0xI9ZQy5tj
   /bNTm4+J4OCdcOHWa+kaQljpyAdLfWUFQOmOzLEgPwl3dt9B60AYFEBey
   q/R/pBJnS8oTtnwkvjWbyvWLf9WR+gMavVXcpEZogvc7j8zAfKqBATv2x
   988ukaduRiWEG72/vH7fJrRR91UB+EsKUOH3v+NhHRShpxzQGgVgCCxh9
   OdCb9U4uQfW/qgp8k7JFjx8UOgfNbkIkURRtdiriv7jVT6i0hkfw3apN1
   FAhQh2tDgKS0tC680p/AaRr0i64cpA7LjRiQXPBwWC/jE0bLCJJujMc09
   w==;
X-IronPort-AV: E=Sophos;i="5.91,266,1647273600"; 
   d="scan'208";a="306183316"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jun 2022 08:32:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MNQKy4QaEVCUDDQUOqPIbSQuwJbf19qMVbVMQFngUfRty0QDCuF5h7lGqs1Rwhnz530iYWTe3ECmSQRx/VhQplP7YlYmJVqx6bq49JNtnR6/snV0acBVKfGfYJnKl4LuUVctBxmfeQ7/tZj970C5z2cVew5M2Bov1fAWLpBOKXHW8sH7gYvCZxzOS/M7NZqwtI2hJBq2X8vHvOuKHcV5GsTYQRx1XAZRXD8qsSqSSG20KI5IhZsEiVxE6DU5oxb4OdB634M9yHXs0ZkPU17NbSF7LpTsidUy8xYw21CXhuAIMnzIR0+QiQz5czy9oLNZ9itIUzlXcCWvI6xeGAPy2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKPvWDG+HtBseEOhQDhVKN+JW/5c43U0FQCbulwxSbc=;
 b=A783/Pw1kRPnl9v44ijJkN3TF+Xb4jkXW9pAM8WodBrm6eaKbhQmUDcxjd+i8MiGj/ZFATGSLa+//8X8ioLmoQRzjNCRylPEYusuAJ5zuzx4wk2CIH6UxVrDnyxK21N1j33sdcfZUvBZJuNu3pr425Owi1ZF1ia2mUqYXJg7xj/JMBWKi5E1MqZ/bAi6Rt4XqBenlWXp6EoE2A8owKHO4FIfZv4WsYJ36eW1pJmmiYprbENbkICyVgll/vwKyY+euuLDuY1JKpy7rDjRK4EGG8GJsLZc6EnQBDGSfGT/mH1oJv5NfABl4WEage5GKdv4L+3FFrWxd6TVN5o6+Gn6Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rKPvWDG+HtBseEOhQDhVKN+JW/5c43U0FQCbulwxSbc=;
 b=NsUl4Tu3A5fd3hMoIqE3BS3qY58Yr5KF/0tr1ed/4lE9EPPPKkZP11VMV6sLQo1DpgOHoagd96lsrIi35ZADEGjgIMvB6cMczWcptu0ihUZmvskVgIwsnzYL8Hdw44Mt17m1wOMV2eXSp+VQPzJHsmHtDVeUrWjkT+ZLRYfvPrw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BYAPR04MB6055.namprd04.prod.outlook.com (2603:10b6:a03:e9::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5293.13; Wed, 1 Jun 2022 00:32:09 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 00:32:08 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 9/9] common: do not require scsi_debug support to
 be modular
Thread-Topic: [PATCH blktests 9/9] common: do not require scsi_debug support
 to be modular
Thread-Index: AQHYdCZjIbXE+Sj6HU6lvM3bVmbTw6046Y8AgADMMQA=
Date:   Wed, 1 Jun 2022 00:32:08 +0000
Message-ID: <20220601003208.5wopbxwwq4c3xucl@shindev>
References: <20220530130811.3006554-1-hch@lst.de>
 <20220530130811.3006554-10-hch@lst.de>
 <20220531122118.xrx2bwx4caywez7y@shindev>
In-Reply-To: <20220531122118.xrx2bwx4caywez7y@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cfc8b4e2-d205-40d0-8e89-08da4366297d
x-ms-traffictypediagnostic: BYAPR04MB6055:EE_
x-microsoft-antispam-prvs: <BYAPR04MB6055446A00C541F50D180C0AEDDF9@BYAPR04MB6055.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wcW8vhcFaJZUFaAWJFADWEnrTCyqSMq8jgqsxbOCiIFnOiMaA5+qf5AkCsjZbPyqXxKZ3ISRBMyIScMahzfh8hbct69BjO0COHO/aW3o1HIgoceT6KoF6sksi9cThG8D0nbb+FvEUfsLt+RxHhWEQCW9fAABET5z7m+anq+6UwqhgaITfK2BGCuyMaGAnDw6zkDx2En6YlbDLGXTct2DnItMPSYg6rS5EafculJUTzURUIcLmjllmRzMwX/EF5vXw2z3RdONu4U/2tJfewvrpqCB160Q88fJA0I9AXFvBDt2t1GsGd70qpDS02wWXbMx6PQmhLBFQoJ3dZtaVCsxxIDNYEu4k2b3EhrgtaDoGRq4cosy4FicGn2qah5U4k2IvKkBbssK4TM85sD6JjIMTnSr76BbpN5QbdRoos4RJDnzM+J+5qBVtGt6S3DRVuIH+/qX+xggkgEI8SaKZWnNJ5rHEPm3R7q29h9Q4Zugz7gRjZhCGxYXzSCbPWpFptxIJNkQvuRQDjsj9Gnq8QcZi7OO/7s7M+jsl07353+Tu54jjQZcD6DFvEwjiBkKzVo2jwldxAPgavKYd2fllNG8CTOeBLkxBfzzFIqW3y1aEbYpRVWHj+ez03Q0zyq6OjT/OcyMX3cDvuU//4pfUK6pq4cbfSY8GHrbwSUMaSrDT1gnr02iInwf/uvamcmGv1bS7lsW5inOY5AQ3p+n4NZvDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(6916009)(316002)(38100700002)(508600001)(6486002)(186003)(1076003)(71200400001)(86362001)(122000001)(26005)(8676002)(76116006)(8936002)(83380400001)(6506007)(9686003)(5660300002)(4326008)(6512007)(44832011)(91956017)(66946007)(66476007)(66556008)(66446008)(64756008)(33716001)(38070700005)(2906002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QDexdIWNfTtNoUICNOdpwzqaWwPL+QI2PLogaB6zswoVzTldeJ3T34hEpD5R?=
 =?us-ascii?Q?6mkVr428kV2bfcBC21n5qHHs2StbuGeTMjTmBA9EfVnXAb59znrTRFsGwESd?=
 =?us-ascii?Q?9h9P1ryQOqIC2fKuabw57lIXWYdaZ9X5zuJoPRfUuDSTPbYGuEnH3vSjt6Jn?=
 =?us-ascii?Q?A+5FbmCIm/qxsbEmDxo9JmF4xB+kHTwifwWn+16u/+179C1NO4dVPcUz8LLB?=
 =?us-ascii?Q?sPYJVS6U3oPw021a4wvE6f1EfZbbULAYnr9/Ye8Z2Na9Jb42djh4xicp9PaX?=
 =?us-ascii?Q?mA3uxcdeZsZeKIxLqs7RfMY96gktla3jizjwDVpNkLqUDKXukJtyRUJxEg7k?=
 =?us-ascii?Q?uF0/7k1emuVrZjkPRcQYyeuSTgTWrHcwval6lpQPfCSGQJKDQABMWzYBDvBx?=
 =?us-ascii?Q?st8a7qTSx6fiPUBjcaMBE2y5UekpJbz+a9z5qEOAgaNsmRYgNZPhwOipLd9t?=
 =?us-ascii?Q?Y/+qK1UFT4WmOFGKbFq3MGieEZppn5K1zQGXbfAEcEVCWAaySsvFEoZDhxNw?=
 =?us-ascii?Q?WXFyGZirbwnVrGQAxRbwgHw8WbcH7GiST8X0hpE9v04YTA3KrZlJlD2W6Sfq?=
 =?us-ascii?Q?zoWKyP5+9uHq0e9qsxdoxkzR+H2QGoLqm3j9mIq6WcPlm9iHaRNJfl8lrrp4?=
 =?us-ascii?Q?Y5pb6wBtGI3vRKYCltzk1a8BXnVQCtZGdK68STQDXhWwbJppqSVV9CxoFsXo?=
 =?us-ascii?Q?EQrTlSQ1+yUHGxrer6Jr6TkulxwRqClI0MLzxBMFF5QYh458HxIV8zCPW/L/?=
 =?us-ascii?Q?r2UJPAxoLpRAVcSdrsAjQzYs2oFtvtjxZPQaMtubw1Xz3udNc1RMYFVsIPex?=
 =?us-ascii?Q?qicoNUpqa0E/+1JicCo5hSYzQ5b04zd78GnCleRaPIzByPVZTJqvGH0ux2dj?=
 =?us-ascii?Q?JOmQsT9JmwEn7Y1Z+4SdDAX4ah6D+4go4qAqVz9JRqzMtIfFn0RiwzDshpAx?=
 =?us-ascii?Q?oU1ouZqnJ1C4iA/1YwsUdhmcLCuf0Y2bZndaWNRqPJsn56VmEtrNmT3snJU1?=
 =?us-ascii?Q?66iW2l4FI0QGqtyrGpmmANjo8vVN7vu9fA3YiCD6d694001alIuqEUTXluLj?=
 =?us-ascii?Q?b5zfP1HNRvyLx0drWMpYGSMK+tMiU3duIgIlVF5j2LA/qqKF34VayIXHYd8/?=
 =?us-ascii?Q?quZiXXAzyGQ3ORoJnfudzVeDAF8SqYUIMKQMQAN+u7o3NJBSo2aOIHDW28TD?=
 =?us-ascii?Q?OoxFWF0fkHEYdyaXWLoZbDWvn9q4SYEr+zDX2/wJzKGbUx2S8lbSboui2ja7?=
 =?us-ascii?Q?twoCT0FW79Xt9wrmzJkiDfv609cATKHVxN5p/srzwUVI07GyYTw1K1OTtJ8n?=
 =?us-ascii?Q?CccHyCV6pdPiRiJXMiA7hpYBoAti+GHt3STFjh2/sOvwM1L1huUpqi8RtH+J?=
 =?us-ascii?Q?9Z1jlX/Q9m6FGRuEewKeVLhw/JNtOhs52mmlLQWMnjk9YohZ8mEUQhktiYd6?=
 =?us-ascii?Q?7Ur/PzjdA0LkXH6J1xFMt4LXtRbguU8nJPsCpWkfnMJrqshTB+U0fCGfsDN9?=
 =?us-ascii?Q?3ZynXH6FucTqn+0EQvxzxgdG5S2E35RN82tS0VWWSItEojmCgJSHg5vzX5A/?=
 =?us-ascii?Q?2qerK5cgz/+MIsoamtlOiiRWXgy7b2ZjBpFCKZ84GsUjadMELnXoctLgN2tm?=
 =?us-ascii?Q?RELpfF2RULagcJZ6uqjg9cisQexTgVECXod38TfVlAC21zLWcscyrsk2f9yg?=
 =?us-ascii?Q?CYJgN96QKu4BU1t3QTa0pp5X+ORqhzWy76Z/neG2JlXwRjpo+xFguuFno6Sl?=
 =?us-ascii?Q?A0xLAzjrRmsyaTmzEUePAG/06UOVc8QDR2XH2QVPnT1fPo6C1Tqx?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0FCD5B78F6837C4289BA8D32BDDCC04E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfc8b4e2-d205-40d0-8e89-08da4366297d
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2022 00:32:08.8009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Iz6HacO6FVjdmL5yNT0GrPHnadYmW3vs0e4axd9zqCI9xSaZ/SkUZdRHbCLV83I3fq4XeSFKV3fOYWyGMoqgg9jyXS2bpZXZe+cB/Z+WeJk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6055
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On May 31, 2022 / 12:21, Shinichiro Kawasaki wrote:
> On May 30, 2022 / 15:08, Christoph Hellwig wrote:
> > Use _have_driver instead of _have_modules in _have_scsi_debug for the
> > basic scsi_debug check, and instead only require an actual module in
> > _init_null_blk when specific module parameters are passed.
> >=20
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  common/scsi_debug | 14 ++++++++++----
> >  tests/block/001   |  4 +++-
> >  2 files changed, 13 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/common/scsi_debug b/common/scsi_debug
> > index 95da14e..e9161d3 100644
> > --- a/common/scsi_debug
> > +++ b/common/scsi_debug
> > @@ -5,7 +5,7 @@
> >  # scsi_debug helper functions.
> > =20
> >  _have_scsi_debug() {
> > -	_have_modules scsi_debug
> > +	_have_driver scsi_debug
> >  }
> > =20
> >  _init_scsi_debug() {
> > @@ -18,8 +18,14 @@ _init_scsi_debug() {
> >  		args+=3D(zbc=3Dhost-managed zone_nr_conv=3D0)
> >  	fi
> > =20
> > -	if ! modprobe -r scsi_debug || ! modprobe scsi_debug "${args[@]}"; th=
en
> > -		return 1
> > +	if ((${#args[@]})); then
> > +		if ! modprobe -qr scsi_debug; then
> > +			exit 1
> > +		fi
> > +		if ! modprobe scsi_debug "${args[@]}"; then
> > +			SKIP_REASON=3D"scsi_debug not modular"
>=20
> I tried scsi_debug built-in kernel and observed that 'modprobe -qr scsi_d=
ebug'
> command fails, and the script exits at the line of "exit 1". The SKIP_REA=
SON
> comment above will not be printed. I think we need to check the scsi_debu=
g is
> not built-in. As I commented for _init_null_blk, _have_modules needs
> modification to check if the module is not built-in. I guess it can be us=
ed for
> scsi_debug also.

Another nit: the SKIP_REASON value update will make shellcheck complain:

common/scsi_debug:26:4: warning: SKIP_REASON appears unused. Verify use (or=
 export if used externally). [SC2034]

As some of other common/* does, sourcing common/shellcheck at beginning of
common/scsi_debug will avoid it.

--=20
Shin'ichiro Kawasaki=
