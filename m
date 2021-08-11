Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F197CC4338F
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 09:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE63E60F55
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 09:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234670AbhHKJQG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Aug 2021 05:16:06 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:9764 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236555AbhHKJOw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 05:14:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1628673267; x=1660209267;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=1TMP/nRup3cyyZBFqSbyPyJXWZiE1iHkZUGI5Ko7FCE=;
  b=FjU9lRw3/J5ZjCaDimzFmnmdXnLG7djYyA9s0/Q5qEgglQH5mO5HagdN
   PHbTnbM4VCW68/IMwaKtnYGBUj5V2PPE09lS7XYb6WPaQpB6H8SLePlW2
   3bPnnqJxV8G2/kQ0QbTM184VDFbzHjC76QrwLSlA1bEwfRW0yrwVa+WGz
   SSrem3T3xEpWRQoEB0DfUaVlXJVf3N+iVchLBgHTCB5cRCxfeNvgVDfjU
   nJDL6fjpJH0lp2hEry1AFgVi4JtXrZHHvxRDC4JplKKxUCG0mVl86ySjH
   sMqF4UHAOTqqT1iTNk5t7KFnD6dy0Yq4+//ojB4pi2STrx63r2Vxk8XQ0
   g==;
X-IronPort-AV: E=Sophos;i="5.84,311,1620662400"; 
   d="scan'208";a="181718388"
Received: from mail-dm3nam07lp2042.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.42])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2021 17:14:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R17fysJZkcqIz+vaKn3JmXijy1+YHWxiy1LWKotSOoCLc8uT/Wt6w6cUh2Ikrx6elsgYQUt6S8sU7zMaaTa2q7cgfV0eRbO2sOf2RNg2q++Ap63+PNeMjBwj1rqjvdhQaGfhmGukHW9f+5s7U6bNevBQV4WmfkAE+wbI3QpyA1fZcaFJijckYkx7ujJogMIplX49PIb/2qhIU1XVGLKjB1M+Z94MruDSSwx7OJ+PdXXReRPFaAOQnqqa7mMNZJNZiDLai7Hyn7LKF5bu/R85Xsc3/iIxYzBOTdjoC45debl+KOEoJwYRyJiDMUHycDPCDe9i+Ta5xQk/V/s+iAizuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qk33s+Hw1xyKxI84eqMBm3lWR2Zj7rpn8Y9Q82XFs14=;
 b=Bzw3gux94rAYBZhtZE9U2fJNmy62WLYNs3+91CEVoBylLd4lcNyAdrRH+j72L29VZZKMb5lTD9dLg7I7qF4y7epLTTudwJRBDfdLY/8KmmUeieyNQtYMHHM5QleeY4Foupo4zDg7KRdCmAjuaDZWYPN/Ib2ZMEPwhV+jnLJq9F2xfQAj/6LodMWCvTKwZuBvqviEGdHyzx9QPuNIqNyzFryGaskKEMZ6Sts6FFXKZg7Qq6hHHR27Q6h3uG74mywN0wRA2Wt68Hxqjki/fHkH3dKI6YtY7BGpAILnqhFy6tM1TxsWKsdd0+OUWJcLNcXV76gKel6HPkDoe4besa76AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qk33s+Hw1xyKxI84eqMBm3lWR2Zj7rpn8Y9Q82XFs14=;
 b=ujbWcJerAX4JzQKQpTrjzhv6KghXJcgAPnf9yMZPm16K04kMqmAw2t5qRzpY53BFjvqiy7qT+t+30WvgGUFA73NGuKkXcPcZ7DWMyLSqKZd4lhOe0+OxD5wQ4lUx3e776XW+J6RXKB/sNtspLRRTbXmKkrQXxKyNfpQjx4t2HD4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7430.namprd04.prod.outlook.com (2603:10b6:510:18::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16; Wed, 11 Aug
 2021 09:14:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f1f1:286c:f903:3351%5]) with mapi id 15.20.4415.016; Wed, 11 Aug 2021
 09:14:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v4 3/6] block: change ioprio_valid() to an inline function
Thread-Topic: [PATCH v4 3/6] block: change ioprio_valid() to an inline
 function
Thread-Index: AQHXjmI7JqGKWhtbGE+vjERXXKWQJw==
Date:   Wed, 11 Aug 2021 09:14:27 +0000
Message-ID: <PH0PR04MB7416520B7D4C303B80D5280C9BF89@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210811033702.368488-1-damien.lemoal@wdc.com>
 <20210811033702.368488-4-damien.lemoal@wdc.com>
 <PH0PR04MB7416DCAE9D84B4ED25E4C2ED9BF89@PH0PR04MB7416.namprd04.prod.outlook.com>
 <DM6PR04MB708110464CF08693EE8BFEABE7F89@DM6PR04MB7081.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d9941e24-8d52-49ef-9650-08d95ca86b73
x-ms-traffictypediagnostic: PH0PR04MB7430:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB74301462CD083C1621D46B2D9BF89@PH0PR04MB7430.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V/hI1mr6HTb/NyVpsP7POwdPVgDvIS9+1xcQAUy9lOTlo5Nqm+PnPmgh/mwGh/Gaok4QeVyMjtLkqoy85HJNWtHnWeINDodJumZESItd1pJOZUV385tdzjxPrExXHcDIw9rauLXh230UF+65NmStHWbk3dSHvrKgZWGL2IU9vVuERravjqqlzhEeOn1W/gQPeda+hzjJeqN7U/Z/HcwjXbcL7hV5t0dV6KHVmyhRg9fewNYUL1jVKajuAZqVG5pcjPPUZGWvDvRSnfYf5brTzgTbOYFnASjnF9k1WkXcViIluBSQIl42Xu4Me2yPC6SYb3NyjKCd8HgRN+dZ84DyE7D9qkdSPUcVzP3HcgeHKQ2JqY3JU0BnqCc0xPZmX47z20rugDsWxD1NgBOf5ENXXmc2dP3FlD7x6NPRJhUL6hQ2IZMBQPK+8fW8z2Wr3f6WagvixBls8x2znWhwEl6+ddAq7w9/fCnti7pS7IfwhYfDwRiUPVeFcNXRYML3NghXBy4xQd/6X+BtCTR+I4ArvfrU1J088uXEx1hvL/YIcMaLOBn+dxtigxWbbPCgz4/dsUOcUTr9qkBPwTrPckRfLmgJ43Ej8VyMeqjqntiDjW5nQ+RmKSzNxQStrzMpIFrY3FR3tuv6OnKUcJsDy3bDp5gEAoI01U1A6KzafMnhFRGqWO/HoOxoPWJTXbfTHltUQJGwHU0Xq3e4cISmHV3Seg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(6506007)(71200400001)(53546011)(478600001)(2906002)(86362001)(316002)(186003)(110136005)(33656002)(4744005)(76116006)(5660300002)(9686003)(38070700005)(55016002)(7696005)(8936002)(66446008)(64756008)(66556008)(38100700002)(66476007)(52536014)(8676002)(91956017)(66946007)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ELogJYgK1JfZKF/j6WhdJmpu9/TjVl/BtKyqbonfnJ6/dRYIzzBkAX46rIdB?=
 =?us-ascii?Q?VTLGCfF+1r0wGqtFccxfL5UlS6qJh8T7zLpDkz6DXYHQTKvC1IhxPPHGQwyZ?=
 =?us-ascii?Q?HDyWhYn0lZ/xo2Ln6/eKTz27YxkvjkKweU3eE1HMegD4YhqQ4H9cStoYLEak?=
 =?us-ascii?Q?5Yn2i6CN+7dsbNoh4k8U8D3PkHcw5Yt7535OPzZ4PlDez43LFqbAySr9tNNL?=
 =?us-ascii?Q?aY1zYQIeG86qetW7YtM8ekEujm0QRtzmUSsiT3QVsEMrEjDvGHfNeiKuHf1H?=
 =?us-ascii?Q?tpQLUNkG5CGZ1E5SOwAEbghtrGmUPAnkQEGLLvRRTdqh1ELbR3uVEnf7knkH?=
 =?us-ascii?Q?Ji3Fbozxbjgw7NOGyd6t1toOalw6Db45/P+UwURIm2Fc/RBtE0TcijxzDUIB?=
 =?us-ascii?Q?vxVHMdsz2RJLgvneTNKGkA3SQfJj7uC56kmCutP6Oq5uMwQgn4seuFwrKf3n?=
 =?us-ascii?Q?Igzp8cfwW9Jt+3eHzrYRzIv3v37QDrkqEKUiUgE+WWGrniJq3iInOgaG3eud?=
 =?us-ascii?Q?Cc4cXZdEjOc+ztMzJOd7YqeFD1K7cuJuGU+GIxPQfMaM9gb1CdapccO+FsCK?=
 =?us-ascii?Q?J+4x50JNJICy6k63WU9cZ3LIV0hUxQPLUeQUMEXZoOXvsklPkkcllMcLS53W?=
 =?us-ascii?Q?fXv0noE7KKx35TOkX2ylsZHxS7CTF6LQYf982XqHtv/G5wn0xuf0VaQWFdzl?=
 =?us-ascii?Q?kzxFpHQwWBqeBazdfeVsfJQ+Zg/0nmgroWA+wNWgRHJtWubsW02Zr02dxfyl?=
 =?us-ascii?Q?YxYBI6ynXhEFr3EuFVIwPCByAuPnTGMTuA+Yni981QDnI1Gual5v+R7UK1TO?=
 =?us-ascii?Q?xylMwP2XFjmmN31nLpbV6Eonek9fF5Hn3g3+iNKYMq70onXG7CBddMM9Q0dY?=
 =?us-ascii?Q?6CU4zM2junqkPIPoe1P3Xz91GtIplK9+uRT5zvSoXi7d8z7oMB5IgSXS6XLy?=
 =?us-ascii?Q?wXvWmXdP1AuNs5uR+xlZUzY1eZomtKxUWNp/vszd4HV2Vn/XZHykwpsAG2yw?=
 =?us-ascii?Q?l9iz3Dsvn/a95rcfBvFFUhNMPlXa7BRY5RBNlhUSZB/Prst1bKmo9csZsUzn?=
 =?us-ascii?Q?Z6eKS/NLAq+g0of8o1mTkp6OUYyv4cBpswCyEGlelq2e1JQOXRqDPhUmc9bd?=
 =?us-ascii?Q?DyAsjbkjp/mChpcSLfagZThzpxOlNUItfJLcbBeEHRw9PKikByGrRiowfQOa?=
 =?us-ascii?Q?NFtGvdnEBM0MEzGsG6DTL0KDqFdgr2WeBBQKcemxUh5BxK5A3YQSdhwrT2RO?=
 =?us-ascii?Q?1ifa1LayY0uItOyaiBWeh/cE+IpsIYEUYL09DDdaqDdv5HGJ+jxUz3Ofuqqa?=
 =?us-ascii?Q?vjEuLtvMfEE0+cCd8GBUwQ4yhSQFTwy3jvhdzJTHz4CGUqVDqxDrjE+v6iy4?=
 =?us-ascii?Q?G6pYlwl9AchxTWVtxhlbB3hzeyRY?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9941e24-8d52-49ef-9650-08d95ca86b73
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2021 09:14:27.5001
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YG3pWh3TZXT2G1Cd5EjnpdzivbJjyFbMamQnO6iI3YkA8fNzbInC8crUXE/KY1e3ZBuADkDn7zwILGu8qJawyKPmDSfm4yq+6xMCt5aoixo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7430
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/08/2021 10:51, Damien Le Moal wrote:=0A=
> On 2021/08/11 16:56, Johannes Thumshirn wrote:=0A=
>> On 11/08/2021 05:37, Damien Le Moal wrote:=0A=
>>> Change the ioprio_valid() macro in include/usapi/linux/ioprio.h to an  =
                                      uapi ~^=0A=
>>=0A=
>>> inline function declared on the kernel side in include/linux/ioprio.h.=
=0A=
>>> Also improve checks on the class value by checking the upper bound=0A=
>>> value.=0A=
>>=0A=
>> But I think it needs to stay in include/uapi/linux/ioprio.h as it's ther=
e=0A=
>> since the 2.6.x days (I've checked back to v2.6.39.4) so the chance of=
=0A=
>> user-space using it is quite high.=0A=
> =0A=
> include/uapi/linux/ioprio.h is being introduced with kernel 5.15. This us=
er=0A=
> header did not exist now and in previous kernels. include/linux/ioprio.h =
has=0A=
> been around for a while though, but that is a kernel header, not an appli=
cation=0A=
> header.=0A=
> =0A=
> =0A=
=0A=
Ah ok this was the now or never one, I thought it was about one of the cons=
tants.=0A=
Sorry for the noise.=0A=
