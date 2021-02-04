Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB99C433E0
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 09:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D277964F4D
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 09:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbhBDJVd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 04:21:33 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:46329 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbhBDJVb (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Feb 2021 04:21:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612430738; x=1643966738;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PKZfT6La0dWbxsXwR6w3fbGvYvWmI2hlsWkqAjGVW0I=;
  b=FRvjrNTkZd5+8hoGDd7GDDRHb+lZHFGrin8r2eXjaSjnjlbVMnpf/+TO
   +6t6PjCYzXF9AYnPpqcvWAOiDONC27+Q4gvRo7aBQodAyJ0yh4U5Avwpz
   yipCECQev4Ggf8Dy2Jb1V3akDHG5IwYDovl1rjwoAh6qkvpHhqyhoBJzO
   HZGTZpQ0SKL8zjUx+zVaqsfTq13kJ3HznRPZs+MdQEssAMZtmCPHcHOvh
   Wd0WwLsAnGlMv0/lD/d3OoUBgTiltnhI3DVg8Lf/7mcY+11nl2cMf+qKP
   mz7NA326XGgMVWSZpmXkoEFuyMq5cgwuSrOYatq/8OEVwOGErUobuSAe2
   Q==;
IronPort-SDR: SYCkShpBnNK8RmWW/EHsd4Sv4zbiFVJE14yzaK6UyyNGwUrngs9gXklTFua0eesObiteb+Oa1w
 FmBzoM6gbN9NmBn20xHZ5riMv75PCd0eH33NOpRPVuN5rjdvFn5y6io73M6zzcTa0Mf88CaVzj
 Yw58cd2TBKIoRy5Si6pdKLdK0jlD1Xb2mDcvqAZxtVRQiG3jLLcxaWNQ3xypfmajF2PsevU2Bz
 sEg/uWvgYArSPLIATosfES+oeSMGgU9SE9lTSpYbeyj41vhbgcYtnNdqN4tZdqiowJcgmtIVjM
 zJA=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="263194892"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 17:23:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OwnGVdnHCQpBU4+OxlAgSLw91QThkeQOhYh87SqOfGV/ubSeysZt2KYPVF1OhZytTCaDTvtNJlLbLuAmk0WOTK3P3n5aIwzL4evFkx3iAr065sZYzPiTBdsRxxsQ4umRaeaolZOLWg9Wg30o/6Zz87hOtoKgEqXtKxTxVs9etkh8OSP6w9PblZAfVrztpVPHQxpK5wJ2mFTsYdRp62miSsa64NrNluumnensnobYg2ZKI/NlpXWlk0EDek3JbixxGf3BZgeYMRGQ6md+lyBV2voHXdB5gadF06dS+HnudcgH1NM61zGRZLt+4790QOPBNhigJgFrbC0EhAsBDTvcdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKZfT6La0dWbxsXwR6w3fbGvYvWmI2hlsWkqAjGVW0I=;
 b=WbdqCUep1NTP9eYHkSUhDKOXTfKJgR/yY+3NBv4OKuxPbM8ctr6BCpjE/ddidx9wErsJvS8z1OV8MCuLS9r88Gk6Ep0XHbVi8coWZPzkOaxjgpObjuztwbTQsh2hgFQBfk8e8x1NxRBbzOuMHSoMeK4qyl55esS7QFleheCsSsL4GRGreQ+QLLghpIMBZeGYL7XUTtJg23i16FlhGyUCUZrpKq+Pn+XkmIG/hh4zkUWY9lJ3d/sLjjuJPUGKAUyciHYyvlixYtRySEtFoR0mSoW5yJxTzlgcPTeZXq8R9hql2rff1EWrBAewW1zVzvvlTrjrN417ygfR9vqsgJ4PFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PKZfT6La0dWbxsXwR6w3fbGvYvWmI2hlsWkqAjGVW0I=;
 b=ec9CClTDR9NilJvmsZqnqqFjSujLjo4kpvq2QeDVss+H63Rcv3YY3KZ0+UDQpcS5jNSuhjVw9pApYS2sSpXwxeo2pr1J6CvdxO69L2nyjbO+cdPYHsXdTTbvJUZtCV7YfVJ4SpIs9DSSYLPGkCINsmm2eyMmc6MG4sUZXDwUURo=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6415.namprd04.prod.outlook.com (2603:10b6:208:1a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Thu, 4 Feb
 2021 09:20:22 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%8]) with mapi id 15.20.3805.024; Thu, 4 Feb 2021
 09:20:22 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH 2/2] block: revert "block: fix bd_size_lock use"
Thread-Topic: [RFC PATCH 2/2] block: revert "block: fix bd_size_lock use"
Thread-Index: AQHW+tJcQ7YrsFFCzEqcRekM9SFuAg==
Date:   Thu, 4 Feb 2021 09:20:22 +0000
Message-ID: <BL0PR04MB6514C26DF3AFF2A78B5DA438E7B39@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210204084343.207847-1-damien.lemoal@wdc.com>
 <20210204084343.207847-3-damien.lemoal@wdc.com>
 <SN4PR0401MB359853B6F1875CF1233A495D9BB39@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <BL0PR04MB6514F0C5971F11B5BC548202E7B39@BL0PR04MB6514.namprd04.prod.outlook.com>
 <SN4PR0401MB359820BA20257B72EDFBA3499BB39@SN4PR0401MB3598.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:61dd:3796:e34d:42c6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 13f20e89-62c4-4ced-6261-08d8c8ee1967
x-ms-traffictypediagnostic: MN2PR04MB6415:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB64158AB4B1D4458DA35ADAB1E7B39@MN2PR04MB6415.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iWX6gEdOp1tdiBseyujL5Mv0iGQa+eE2uqllO+TX3EM72eS5Y1h9Ba06zL4PBFfyS1z7r4+hNR9qxnzAQGRdIfK4qTJOMZG5fFnRNwV1JVLnBaiBinVz7UwvdkyGdfchvz4VTz2o5v2ySAseFo+uA7tVBrXN8j/fwDla9oEikK3cEQWcjKksgi03f4QibkSBMchswfUg0JJTSnWdCw9hxlyG6Hxr9JP3mHr7IHhe8JcZTeLDc3Nz9qsWqdjUa6yjRfnbNolfqfelI3hoWnSJh7K/ZDb0aMq72VqHPsEL0KD6nf/CSFXwAr3MJ0nUbQ0NudiK6N4sFNzXn1Rb5tDl6nGwkQ+4G19rTvAPdvTqk1an6VPw3ZMZyCiIKR00c7a6+iJDFteqWSJxFByCiLGL6nh8TAU9SBUE5XR6p73tlMULnSF0WZcTdEFTIvj/0zL9brnPmNpT3Yqt1MXGtKV2izuxhCpEJbUIH1QQ90aAFU0PL5HvNa4FAgcfJsrvKiqr7hTNAvYL5IcrwGc4oC0zxg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(186003)(71200400001)(478600001)(86362001)(7696005)(55016002)(53546011)(6506007)(66446008)(316002)(66946007)(4326008)(66556008)(66476007)(52536014)(91956017)(76116006)(64756008)(110136005)(33656002)(83380400001)(5660300002)(2906002)(9686003)(8936002)(4744005)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?j+k+rMxU7W1rWB50y9IqPZbqObyxWlqC8x4CCtXHeI/412G/MkgrmjlJh1oM?=
 =?us-ascii?Q?O25VvG+u03Y625w8HqKfS5x9RjZHhU4oNkHaP6AvsOOkz+nDXxLf2J8RF7rH?=
 =?us-ascii?Q?5YS5pIj1bOluDevfYCYoW76TVO375QI9U1IP33b7foh2S6UA71XFaffPq1EY?=
 =?us-ascii?Q?/78HFFSeccoALkv/GnSWvQUGgWqkntBASXXaJc/eXyUN/OwxzEAIjmS7XCcm?=
 =?us-ascii?Q?ciHAF8Ux/QFnpiJNBVMxZnZCaWtEzux6Yj1sj+R/fwd4bQwrg/lK8fHG8azv?=
 =?us-ascii?Q?hEnOTR2vUNneK8Gkv0qg2GjPKIMwddnUYbysfo2QWUkZOg7V1bMPS4FMqSGA?=
 =?us-ascii?Q?Y8+GoND5HXQ8rsqmtp8LnemUpGrCfw+dBMVB9nG4UTtfrwcSsIHjq8Fpr1BU?=
 =?us-ascii?Q?gwMKd13O9F5tPsQ/MgZi6V4NJjkxIIgPoRw09vSgadqU0r0qOcrJtjPIM5Kw?=
 =?us-ascii?Q?hGLNpiH1Nxn25umfzrBNR587tv9PPEbW3EMiuy+0UDR9jh2Slh3EdX8C8Ybb?=
 =?us-ascii?Q?I8/YtV3I+jfPK269xBIVtjXVvbT0imaxFhTbJo5ATcF6tdr1nMyzpKJam7B+?=
 =?us-ascii?Q?EXleyS3A0PSbjKkGF+FdBz2hOhDCAekFZN+WQQ4PsAf61gHKnWb4lOGfldQe?=
 =?us-ascii?Q?YyQpiaxvDY3xYiD563g530ytGrGt7MBRn8xsb+IkwYtsuc4N9Q5l5If1CKU7?=
 =?us-ascii?Q?OaSQyCZtroWzqYWxqoKYtEIB3dVw4ZuGB3WnLURmoM09mjg6NPg9dF1OgDzo?=
 =?us-ascii?Q?RQbwpkriBich3J/t8ssixP+H7/GEGuYkN31SN9+vAGxcxFA8FvmQjgDx1A3j?=
 =?us-ascii?Q?PeRqDWb3dWOQk+oscGC+LR+5Mr8h8Mh1acWngtY4ugCaZZ3+GhRqJpr3DSkz?=
 =?us-ascii?Q?7gs/2+waVGNqv1mfdByb78R0GBSALEswKlPXy+YVeRWI2VSMVlurlcDvCbKe?=
 =?us-ascii?Q?NZCJBj7vqWs0nMzqCHwPGvmqUphuUGEj7GTStJf44ShnjzDkO1QWHEFPvvhL?=
 =?us-ascii?Q?/vatguOe2YoSulmJx5EzC3Wa+61o7f9vY0KnozAo0rKC3KQn8GdFVVV4w6VF?=
 =?us-ascii?Q?47hwH+/AAocpHagKH9DyWSP95ZLDZiNdq+9AJ7QrZ7Lf1dU6oNLgmB0xxDSv?=
 =?us-ascii?Q?/0IU5jACO9hlnfyxdE5YHkEwfXo+y8YW8BvlhqBUUI7bF0EG+96FGQTLSqAC?=
 =?us-ascii?Q?Oa/j8J42WTbeH47vkvxJL4IR7PUSFEAXu6bKDuzQxhO8BhjMF9yVegldMCGJ?=
 =?us-ascii?Q?mTH9M8DDieS2jnvJaIFzpPk9ZboQr7/YJhfS8+H9rePUFQSxZCl58ZrosFwL?=
 =?us-ascii?Q?5roYYvrZhUBE8aq47/7HkMHt6jSlNzl9z0/HVKsjKx9vpE2QWa1ePCuxrELF?=
 =?us-ascii?Q?cErEoRakb7ANp2v4w/ehi8OB8PvP46/wSARWimKA/wbusmj9lg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13f20e89-62c4-4ced-6261-08d8c8ee1967
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 09:20:22.5429
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jZnSYUQVmdnvH2pgbOjla+Zsb/gswIl3yoajFbunOT+6A+ivLWOz5pbiVt4Fo1tsAXj3G43J0JECP3mMPznteQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6415
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/02/04 18:14, Johannes Thumshirn wrote:=0A=
> On 04/02/2021 10:03, Damien Le Moal wrote:=0A=
>> On 2021/02/04 18:01, Johannes Thumshirn wrote:=0A=
>>> Given that #1 in this series is accepted,=0A=
>>> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>>>=0A=
>>=0A=
>> Do you mean "if #1 in this series is accepted" ?=0A=
>> I have not received patch #1... I wonder if it hit the list ? Did you ge=
t it ?=0A=
>>=0A=
> =0A=
> Me neither, seems like vger is acting funny again=0A=
=0A=
Patch 1 is 111KB... Probably too big and it gets dropped by vger.=0A=
=0A=
I generated it with "git rm" and a few other changes (MAITAINERS, Kconfig a=
nd=0A=
Makefile). Is it possible to shorten the "git rm" part so that it does not =
show=0A=
every single line removed but just the files being deleted ? That driver is=
 a=0A=
single file, so very large.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
