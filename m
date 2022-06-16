Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0935C433EF
	for <linux-block@archiver.kernel.org>; Thu, 16 Jun 2022 04:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348280AbiFPERC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jun 2022 00:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348986AbiFPERB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jun 2022 00:17:01 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7549A59BA1
        for <linux-block@vger.kernel.org>; Wed, 15 Jun 2022 21:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655353020; x=1686889020;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QANxIbjnWINgESBtuF3eo4HjIIBiHJl020WSdvlAtDE=;
  b=AY3qrnMawhaEOKfastmXakHA4FDkGSjYYbE9WwDdmjSvcUOizHvlIU7+
   UueudAYew4m1Aq5Y4LuqL0oIe7/M+6g5u4HYsEUKlh7pg8/O1cniHkdJx
   qVl7++ZdUAEHys2BvmoR9jYy/ldC4z8BMsRIIejFWmrn5V9FglI9yzDIy
   pLV7vc3rsAIfixqRwEOFhjlBOuun1DU+q9JbsT3L6V5wSP+LV69Q5FLXT
   WMvOlGQrfr9D2XnPJpq41u6FnEnvQPlPgdwkJLjKOZW6NMINJFCdw6rnZ
   fCTynA004gNgkU4WtJw9i6jn8e8uJQwoNXB0zGQU5EI+N5Xims+RE8C7W
   A==;
X-IronPort-AV: E=Sophos;i="5.91,304,1647273600"; 
   d="scan'208";a="204054193"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jun 2022 12:16:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MkB04E9yiCu/OxrqH1WYpOWj9DqNG/5DNpiSwims3ElYStGjdnByQe2pZ8DDu2HM3ApE4a+pZXnpNtk+l38Abcq7w9dTLzzQHfEG9pH2OgiHTbFS6b9q+NfMq9Fpw+665ZfKrVxrcgY5xQjDPaFU/ch+GPlhTVH3M5uD4S7/lDif6j0VCqL9mHTiqk/7hSwcyMDMZ/O7QRM1MC3ct6xdnPMXYy2jSA6QVT5TBAfcgFVICaN7mc+jIWI5nAmUxDHyNmfXA6QZzDn8+ZUzs+tzx6dQxyHCmWWx3OmtXBS62btijw40SCe1OB1hgO2cu9zYQyiy+9RsEURdcych+U4YYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QANxIbjnWINgESBtuF3eo4HjIIBiHJl020WSdvlAtDE=;
 b=OQAlti0tfIvASGoGoSwkX3LlS6YdVKo2MH6kh8KrObhuJw2N4+vv9lajBWbOszj+jC2NXOIrIa2Jgy/3VHLTi1ESAVHOxa1/iMJwBsg8farJyzTqRHqYEQ2g5TQTPrvOdp3NWkCqNVX4illglkiYIwEFdiBTsuHtJhIOrKG0FWfTz6PM8CMzEUUUQRIcnC7ANxe8ts+Li3M9OdOScBwC8R6ZIPd9PB2LhMmOeoe+DWuXA29gu/xXoWzJ/zCxnQsyshVXPVt+A6743b8gbDkMU9CdR/cg+rZblD3Lhzhfq1AiYZ9q9FgCov8b/MJUEVuvSA9IZmU5kh7gYGCaljZ3UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QANxIbjnWINgESBtuF3eo4HjIIBiHJl020WSdvlAtDE=;
 b=xBPCj4UpRnK9pPywp5LvB+evIAngK34tIhQ5ScHd9AR+mV1d5XSadtATy2BYbWXYocNbS/s65RBMNbGnkKHay9hzT5uDsUZRMEzpirGggtIa9oS1JqqFm1K3SOcJBuWcsForLvAaAYs6i38YTNDm3J2kyMUnqEUJFe9v3qQxmY4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM8PR04MB7766.namprd04.prod.outlook.com (2603:10b6:8:3a::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.20; Thu, 16 Jun 2022 04:16:58 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5332.022; Thu, 16 Jun 2022
 04:16:58 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Jan Kara <jack@suse.cz>
CC:     "osandov@fb.com" <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blktests: Ignore errors from wait(1)
Thread-Topic: [PATCH] blktests: Ignore errors from wait(1)
Thread-Index: AQHYf70MEAYM8410bECfhVCFN0sjpK1O4uCAgAF5zACAAFWGAIAAvimA
Date:   Thu, 16 Jun 2022 04:16:58 +0000
Message-ID: <20220616041657.gls5xevqwy7qi3qv@shindev>
References: <20220613151721.18664-1-jack@suse.cz>
 <20220614070454.5tcyunt53nqf3y7q@shindev>
 <20220614131803.hwoykpwzfh6pxmda@quack3.lan>
 <20220615115014.nm3utxgvq2hkhuzo@shindev>
 <20220615165620.fs4yilch7nlcjmrl@quack3.lan>
In-Reply-To: <20220615165620.fs4yilch7nlcjmrl@quack3.lan>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: caa0b7f3-3e45-4803-3bb3-08da4f4f0e0a
x-ms-traffictypediagnostic: DM8PR04MB7766:EE_
x-microsoft-antispam-prvs: <DM8PR04MB776650B2E2360732F68005D5EDAC9@DM8PR04MB7766.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j2c79nshjE++zviusS+h6H7NQG1Ar8A4YNkHdkXDpfZz1xORqX4I/p+01ZVPJH/FanOK52f+gJIWXG5V4b7q6Qi6GW7//hrmQfMw65qJkpW/WEj2mJbAP1N8W6pSRLcBAUOCgHIJQvJqKJ598jTu2f940SPp7EPn9NXTNmqnyZfRZLX9LPFEZgzyZmfv0r+hIuqIjNKEOgiXuN8IQk5/N+4QmjrDWIHfraL7hAmfa8FwnVgojPPj4GAOLCpo/CLcvZUKfcTdZg7WaJ0ZX1hVfyfroD/x5Fl7opG4dnbOmscO7rHr/+gRfNFO4rrdzfZNbL2Ew9tq6okQgcZirwHENCGxumAYY0ZgG3Tr6e8DYz1eD715IIYiOd2LecUbHnTbaIoNLTPLb5uV1sNc8oAK2t6QRsrNmTu/4feSnYK7nq4xuILGYLX+wQ6O0xwFXDf1UidhPkBwx4Rnry5jJ5DrEerOptWchNpAm//+X4vFxErVGyXAMKYT1JDp24Daihd16ZWfPg8lz8+BMpfWJIwTcsgBRwbSA4r1vGMVA85vUN3eluvEt6dHmuXX1WVN0u0jj69o1nPIn1Y79gF3S6GVxTIOrU5IFDNdxD/jP9zE1JQgwlNzvFBvTOahE6tiqJUcFgah6JK3hget9ZJJ/fEh3GctBZAMCwcRC4RExev9usxkqpRoS5oQM+Dm6mukqXhKGy3l6eiRYWr0XR18gziTmg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(366004)(6916009)(8936002)(1076003)(54906003)(4326008)(8676002)(66446008)(66476007)(66556008)(64756008)(66946007)(91956017)(76116006)(86362001)(316002)(38100700002)(9686003)(6512007)(26005)(82960400001)(6506007)(71200400001)(508600001)(122000001)(38070700005)(6486002)(2906002)(83380400001)(4744005)(5660300002)(44832011)(33716001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?B3gBjo6N9gQfxLE+TJWONrGEBwibkpltcAf/bDp6+aJb/ENULhlV9vHmCIQQ?=
 =?us-ascii?Q?DBC1QCwlK9fU9xM09m3dmq+T6VU78qPplyFVxcovE03AWf5iaLzT1frnDJ85?=
 =?us-ascii?Q?qARxAz5sI0tF0yy+kWsRbJclhuWGCdsMMwIZXoxIR8Nu0V3NGLCVs2MSxSEe?=
 =?us-ascii?Q?zEPM8KkTgEUEyyMVHtoKF3U53/8+J54+d3nj/rx+p86Y3sb/rG4qyXOdb0dN?=
 =?us-ascii?Q?9G+6J26N6TO55xofSRgflVj9o/Njm7gnPXM6BUI30ZOqGIGEQWkdqXRypSoc?=
 =?us-ascii?Q?+P4AJIlqVtkiIec48ra23fh15KyKP1n9u8VWprSeKwFfkBsanCH5mY6Xsm7B?=
 =?us-ascii?Q?SXT0shejuw2rnJOanmQbHx9sHvub6GVss8fZRZwUTqceDMfvvy4m4KZx1iuU?=
 =?us-ascii?Q?SJagIlpHXYwNjpDTB52GoQ/jF4+5TQu5ojFviB/hd0i2PkB0gY4oaczUR6na?=
 =?us-ascii?Q?EjxaJJ2LqlTySSVnzNUhOYCFbytUxhO/jGg++TtU21AUwo2yJ0wUfUEC38JK?=
 =?us-ascii?Q?7iKqrDyaacUa5oJcEIuKhlxesNjBGWUh0gxscWy12tjIpFsbjuPSqs4sw5MO?=
 =?us-ascii?Q?bLEopw7bbYNMHuhNIrcUI3CXs/xo96CUCw8Bk9iEHmXzF8S0iIzey40xbmfC?=
 =?us-ascii?Q?Z7bK/lw1iWICb1mD3QxQsdRajUHtrSaMCNIFTJzqMNOj/ro089ChcxMJwxzT?=
 =?us-ascii?Q?4Fsrbaja21zzACCLvkTXlyuRlUmF4nDVzrKj/glZAvH7BNjPgZV/jnSp/vPz?=
 =?us-ascii?Q?4bhc6M8tJTSv1LL0QdJeVw+Dvt4MYy6dx9cdpUy+b96XououcTP66VwTYCf8?=
 =?us-ascii?Q?j0KiovnUbJqW4ToF5qmH4dAAqE8zpwiXvS9AH3rvoW8aj7PTSfhfAqrD+HZB?=
 =?us-ascii?Q?YRebONq5EIMAl8iL+TKHVu6tKPsH3P+7RNUtnpqUODcAidfzLdiFvtnB019Q?=
 =?us-ascii?Q?2H3RRLtLL65+SbezlFdI+EDuIHK0QMg5mJDNS0VQtgUSXmh6djq+2CZSGsrz?=
 =?us-ascii?Q?lvBBWlp2ovnKN5CZTxtPKu7AUoaQZNIzEQb4eIOu90sU8oh8jo02kFaLHX3E?=
 =?us-ascii?Q?YWJ4R9jrrXIN9RnZTZUgZbA4vma5NI/7hR8a2Ed4XwOtZ9OUFlyST9ckjrPS?=
 =?us-ascii?Q?F+tgvZ6pKI6SzH/Z3WYhih0hBahuuxzyhNZUt8s7NXKMpnUeTkV71IpuMmYl?=
 =?us-ascii?Q?wuIpz43xecl+LR/+EvTn+qA16qIZzUiqoKllZgQIWfdkvJUJqDrBQ4u6Z9pk?=
 =?us-ascii?Q?ObSleSIHBnkO1YP6cfGQmGKLYBnr9lJCEEMAgHM0DqKgnklabvOiEhb4Qs9I?=
 =?us-ascii?Q?Nb6FF65la9BYALSsf46KYkN243+ABrOiHFYMY3qRaXdn0oRe3SHgRupVgVvj?=
 =?us-ascii?Q?dZynjoKK8LJZHxNEUQxi9auul6IcA/rQ1ZYh8BNIVd+Wjk1YLJR4ZjRVkGyp?=
 =?us-ascii?Q?hosxTkVLeYs95LoR/Zj2Hw+8Urktg9MwJE8gMXbTaQJJnExa5Nv+nAl+Onhu?=
 =?us-ascii?Q?FXqUUdpSOXRcqJU7YFygxMZiCvwLwammmdp9JgJpjBoalcTilnO6TPqedddw?=
 =?us-ascii?Q?5cMsGr7TXNlVJ5B3HL/ULzigd1NVvLiPwON8/6CSus+qsMi9lITsQd50bZL9?=
 =?us-ascii?Q?WfGBnSxt3MtMYpHITsgMydbFtM5/8l0sW4mU2Bhf6bRLg2ulgaoQ1l9p0OlG?=
 =?us-ascii?Q?c7Qb1uKaTfgKGryhGLVOmSk3uq1cU6bHapgier41BjZC4vNvcc3zftiR6AZg?=
 =?us-ascii?Q?IXG9ZN+58BuFXiVvNtANHh4nJfouJxMddx03RF6Toj82V986NMt7?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EE824120A97AED49BE165BAC54EA9B94@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caa0b7f3-3e45-4803-3bb3-08da4f4f0e0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2022 04:16:58.2752
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4Qk2keWqP4bOY89RjfTvhTWebr1evVDbTNZd02AH8QiYROp23p4XJKmSzp/WI4a6Ju/l5hxfKUMeU5DGvXHgn8lcm42TaxFABH6EWdpG8jc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7766
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jun 15, 2022 / 18:56, Jan Kara wrote:
> On Wed 15-06-22 11:50:14, Shinichiro Kawasaki wrote:

[...]

> > Your patch covers several waits in the block group. I suspect other wai=
ts in
> > other groups may have same risk. Instead of your patch, could you try t=
he patch
> > below on your system? If it works, all waits in all groups can be addre=
ssed.
>=20
> Ah, indeed. This patch fixes the problem for me as well. Thanks for looki=
ng
> into this!

Okay, thanks! I've posted the official patch to go through the review proce=
ss.

--=20
Shin'ichiro Kawasaki=
