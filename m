Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5E3EC433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 12:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiFWMd5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 08:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiFWMd4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 08:33:56 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB9413CFD3
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 05:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655987635; x=1687523635;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ti2q0wk2ZWYnRbkB1WgOD+HQBNawNjCWpHEm2xXI6EM=;
  b=Qen8aHTtjckIycMcAMceuobYrEYYElqHQ54JR0D4sVF5sVpc2GyXSl23
   nXYlONXeI/aVv90Qkq7aEBMInb8YZWvtXjWPrNLAMENE0oaZsK1e34vg5
   OyAl8MIugzfqKInQzF4AUgHz3a5Y7C98HD/ijrlro94ShvZuKljIVTnz8
   F+5p2dKcwein4/SogpmLrTvaVJYcJX7SxaB+OLrN7wYu024iEdEeNsWJg
   TKZJ9TRGRo/Is6wM/keaRwtFCwy8PKpbHYYxKIliEhcN1UKyTRRQLLXSE
   RQzjSJFmbeY+tj5TEhddhRD7yGx6JvQ5j0Cbn6qmzS8t/02S4E3BFWT4a
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,216,1650902400"; 
   d="scan'208";a="316023466"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jun 2022 20:33:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DF+4Z+fgro0YcjlXTR9PY82ql92zENVApSgKGjyj1fiR43tK3ayrlrkn1tMG7QLTRhDw4Xo6XCHcmpHG9LHhB+hu4cWv15i6KpnHNXWj1tLfqM89GAfniK6qAHZ86c/mwVIqtNkd4VdBc7pjiWmDaKzShnKg2eG6NY7LsO+s9Z+0LgNVTKvyIDNqGNSg/suQ8bY3HwnGVFbxikNnyECFab1XPbUG9NdqNqa2d6TlEFvmgYfcR8CsU3QsnGIz82myMCh23ywyCdFKjfWkEHsH3Up7LB6Hxo7KaHlykNOHRk1qd7crK8Irkl8m9f9twVuN0iOLU8CrQfhG5sU3dzaXhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ti2q0wk2ZWYnRbkB1WgOD+HQBNawNjCWpHEm2xXI6EM=;
 b=m6FkzwWqwKSg0xzl2sfPRNmy0BMNFnhWRZCj9loXB2UizcG/cJ6GapQXPju651hufpzenzLBlegXoOO0ZqydSGHpvToGiVNRDjfHxmKk/iFb7iw/oFMLc8xxNF0mxydborJ6Xx4adGlTcEAnqgMXdMZE7xk44+i1sCzOOVVr8JU+SqqKPS8FZY0IO3700uIWvdsjdDSmlp+rGssJ3XuGlVlegxyT4FlKr6mWtFGjxw95quQpn2jn5X8OlPSnjvC/fqpDUINBu/xsz1/6rcc2Nz+9BJabwQ3PCMYbYmZafKAzDDLnRccFOpTcYZ1xqkVm6QymlK3lfLanOZH4oGrdjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ti2q0wk2ZWYnRbkB1WgOD+HQBNawNjCWpHEm2xXI6EM=;
 b=VM4jfWMauqCnrGuF/Ub83WWzzWsewWL/nx1JjOA491O7WuSNnMcoO5MmysHTwmIk6WX/QADaIkE/9rM0o25Mv7phxEEA9+7Ii83lRapQcVqqAFgQgh3b7KoxkKLoyDeZ0LAJhB5QxNlPMAKnq65ok+HhByc0eeVwF8NBh2ykGMc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BYAPR04MB4776.namprd04.prod.outlook.com (2603:10b6:a03:11::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.15; Thu, 23 Jun 2022 12:33:53 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5353.022; Thu, 23 Jun 2022
 12:33:53 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Dylan Yudaken <dylany@fb.com>
Subject: Re: [PATCH] block: pop cached rq before potentially blocking
 rq_qos_throttle()
Thread-Topic: [PATCH] block: pop cached rq before potentially blocking
 rq_qos_throttle()
Thread-Index: AQHYhYkGlgdmJpOCC0mS4qhKsmFu+61cswuAgAA02ICAAAgIAA==
Date:   Thu, 23 Jun 2022 12:33:53 +0000
Message-ID: <20220623123352.xhncr4rzdcmpg5i4@shindev>
References: <65187802-413a-7425-234e-68cf0b281a91@kernel.dk>
 <20220623085559.csg72pmamhwgkcbx@shindev>
 <394d2490-def0-30c0-7341-983bc93b8c57@kernel.dk>
In-Reply-To: <394d2490-def0-30c0-7341-983bc93b8c57@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5ed475df-6869-4690-257d-08da5514a225
x-ms-traffictypediagnostic: BYAPR04MB4776:EE_
x-microsoft-antispam-prvs: <BYAPR04MB4776F82C12547C0C52CCBF80EDB59@BYAPR04MB4776.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tzaimr6kpa/eY8q0tK32mu0yo4NyRnbyQaF3ubk8kAFtNIdoePOnq5KrVlFxjg4r8YeYM00TQV/kNDNrOXgYiPhN534woTCZbVEpEE0AoASbxP8iYppc+4SlJ0u11LHCFEI8RRAPKKa4D44TuU7d8FgXYsNwLfqCE6h1bYvh8ZFDTPPOl7vPXoEmXobToDwsIqSIfpxHxL4BV6zOqHde3X4ZJd+4QftVLmEHU4PNtEh/sGUe7vm/bkPIEYwQtarI1itxRri15qOzI+fEhob7DfUURvlz4X58J6FS7XbrcQGHwrgGsg6KzDY6mkiSZofe/S/+qCnVF+zxmVjEZZd67q+uk7Y7eYeOVtfXU5WGV5Z8zlCbvw/KNN9I7YyfH8wi/NxQASKQyS9vd8JY1fh+guRqTHl9cTB95ysm9WFsrNM1IS8gi5cpcWvg37VDbf1Dtng6fC8BHQNGg8FX9C7H+AdfQn36DGqWYsCDXij3q2vsoyqJTzu0hngkoMG3XoHZUafCj63RIZWOPTYn3WBgtmEFeHKzxrCAYEttgjEbxY/vqTL8za8aTzwRZy2Y6HFLB5v2greH4c2d3dcFTPhDD8pXee2X7uhMbW1QrxU72o1ZD6MFtun2DPIGOJFyTP0/IIqFiY+Wykc6dWqL7e7D6m0axomnm0kl0Msct7iGimeyzvLjbfa6sTfHK6rjbTO0xvyL7m64B32djAZZWP+0upo6atOJNIU5fyTUIdJqp6pRalcl8k1is9VOeIfhGyxIJ7RHZRbejIeTwyEGNmpxbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(366004)(39860400002)(136003)(376002)(396003)(346002)(9686003)(6512007)(316002)(82960400001)(71200400001)(6506007)(33716001)(1076003)(26005)(44832011)(2906002)(41300700001)(54906003)(38070700005)(6916009)(6486002)(53546011)(478600001)(66946007)(8676002)(66446008)(64756008)(66476007)(66556008)(4326008)(76116006)(86362001)(83380400001)(91956017)(5660300002)(122000001)(8936002)(186003)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?enpSclGYOWC/ttM6k9aMaxq+O+pVhfRl1tsvnB//GoL7AdQDAge0Y7qjXCOI?=
 =?us-ascii?Q?f0RGqTmn/36GBPoOjETWwgcDCCEep1h8K8khBPumfhdAgtofye6GeuneZ1W6?=
 =?us-ascii?Q?n1ze7M6x0V9u3RlP5GUXIDH3ZGJBqTTqkjzNLTeuotyJ4rHmOudaFNJbTNal?=
 =?us-ascii?Q?pcJHlLTxAuXMsJBE3ZUHN8Cl2JCHcBsspVjhJBgrzzy4X8+SSUD83mG9OMDT?=
 =?us-ascii?Q?JsUTT2GH3WPLh4BTuEeINYQQPTxjlboPX5GQJ1zVSRtRv1wnaslqu7XClXd3?=
 =?us-ascii?Q?nuUYeT01avCsJDK7tIfebIgTlvPir5NT5K/VQWxa7q9A4HUC6uhMNPSW/fJq?=
 =?us-ascii?Q?V8B9zXnM8UGy6vyPxYsvHZaBr4pCcs6w52yD/p64i4ZpZYhV8hBnvtrl3GPs?=
 =?us-ascii?Q?nwaPrJaQTPibFobONna8dwRaIPRYWlENuxIHs3ZejY4Tep4DjWVkXbEXxdpq?=
 =?us-ascii?Q?l1KMYOqd0nlEXVSCfYKbZz0HEk0K7yD+ICtw1uOrpRp7RBvYhaSmmgBXn9Wa?=
 =?us-ascii?Q?A7FWroB4G9+O9ERoJLLDZsUHI8AdzIjqh9zMonZPqQcejNamWfKXU/EAUWBH?=
 =?us-ascii?Q?/1xpKw+aMFczdhrCaBnCCX0FYroaDjeYuTpLc/SujECDzijKmlKXWeuUN0Gx?=
 =?us-ascii?Q?VoB+IOiBq07U6eT5V74wLpxbTYKde0G4fxBV4OlKbDYHRHpZEN3pli+kK8IL?=
 =?us-ascii?Q?0MQz+aCfU2QQtoa/eBXEFpJ4uy8Hd6pXYiYwR1j5spijMryj9hTxuUJfjlPO?=
 =?us-ascii?Q?n4n8ZFOCE0HUEEdzcJnqDGVT5J7YIJdAYAHh3CxJyOqSSmS8tlMlZBzslOrm?=
 =?us-ascii?Q?xMEtC3pJzLmJSlgzwukztKBBqkl88cHSFK3zbRYw6/iwFH4k32BVxKo4J3d9?=
 =?us-ascii?Q?Shy/lmKUrMZv2Sw1SU4Rcev3WLAWoBUDvCx97ZkzdNKjxymD9eKspMuI3qPv?=
 =?us-ascii?Q?8suAzKlBVvvkcTM0/VH6XEqlW7A73xIcjv3+JL3MZAUMkVpLRMuaSki+yE/U?=
 =?us-ascii?Q?lSADiLnwkcAQI6kTtLQahJ/ge6cEthKpXaBwCU0hU1ccdOpCWs0pEPCsX2e2?=
 =?us-ascii?Q?BRgQHFY0bBJLyUjVflmT5ZGSuz9dp4bD1Lx6difQvZyQQuketv/Gu7Nq1/rB?=
 =?us-ascii?Q?8ozORL3Q3Q7TCGQoGqrpM6ogXx1zDz023OPq9IRX9C4wNjtb5zRMws7H6SdM?=
 =?us-ascii?Q?rERcJSZuin47oE1lCyJ8JdVxwsbtgTEwFI8XtyDUItVQanKOMJjpKW6HY3ve?=
 =?us-ascii?Q?z+GUR9zPuU5kWxih6fL+K2OoKY2lKx9YKByeBE/+3ilzd8P2mkqzXxuN/7zW?=
 =?us-ascii?Q?6RRyfd3lQUedPS/xC064nzY8H3FEi9FySdrDhzHe/ojD094ZFYCEWy38H3zj?=
 =?us-ascii?Q?8AfZhS6GWXEzYolSTEZmarCKl1EQuK3RMZZ0S8jskF38eZpTMlAFK0Lg/rME?=
 =?us-ascii?Q?3Dqs44al7mQ3HcHWI9L2N70h0+VeHZ2MICA6JvehxVd6E4Qmwn7vN+UD02tS?=
 =?us-ascii?Q?yMuOJ2TyjXqDPu7ruBvq7+VPCrX4PJy0tijBGsJk6R9XlCz7spIiSCo7SX6L?=
 =?us-ascii?Q?BQSMqidNn2v20SXgXwoHaXdghSrAMvoaHb3Avx1J9jp7iN6Vm0XpM+B54sz2?=
 =?us-ascii?Q?fjj/e8XzJw7+zriLh3J9vIpe7y9d3/XvUcmtgSx6vtfJsj0c5k8/GpVYyx19?=
 =?us-ascii?Q?BBw0ZW73/Iq4/uEgJjtEVVfLJ7IfNe0fgVVEiiAXLpaQl+8+rjJNCLx18/xy?=
 =?us-ascii?Q?eQvc+TWXyLj3fYB6tvZWFoIGGK72ehiaXV8iVxS6hLZUjdOCymFK?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A439297951F39B4DACD6DDF15F846A3E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ed475df-6869-4690-257d-08da5514a225
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2022 12:33:53.4084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h2/ZoTljHgIvljtf3GVRgLwz5lMgKP43pjfClJA/mzU+yxOS+8XIMDJ9UmVt4YlxJ1MMKvGWa5gKjPYVsZMvQyHrSOm+gzNr8fVwQqC3KwM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4776
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jun 23, 2022 / 06:05, Jens Axboe wrote:
> On 6/23/22 2:56 AM, Shinichiro Kawasaki wrote:
> > On Jun 21, 2022 / 10:07, Jens Axboe wrote:
> >> If rq_qos_throttle() ends up blocking, then we will have invalidated a=
nd
> >> flushed our current plug. Since blk_mq_get_cached_request() hasn't
> >> popped the cached request off the plug list just yet, we end holding a
> >> pointer to a request that is no longer valid. This insta-crashes with
> >> rq->mq_hctx being NULL in the validity checks just after.
> >>
> >> Pop the request off the cached list before doing rq_qos_throttle() to
> >> avoid using a potentially stale request.
> >>
> >> Fixes: 0a5aa8d161d1 ("block: fix blk_mq_attempt_bio_merge and rq_qos_t=
hrottle protection")
> >> Reported-by: Dylan Yudaken <dylany@fb.com>
> >> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> >=20
> > Thank you for the fix and sorry for the trouble. The patch passed my te=
st set:
> >=20
> > Tested-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> >=20
> >=20
> > BTW, may I know the workload or script which triggers the failure? I'm
> > interested in if we can add a blktests test case to exercises qos throt=
tle
> > and prevent similar bugs in the future.
>=20
> Not sure if there are others, but specifically blk-iocost will do an
> explicit schedule() for some conditions. See the bottom of
> ioc_rqos_throttle().

Thanks. Will try to create a script which triggers the schedule() in
ioc_rqos_throttle().

--=20
Shin'ichiro Kawasaki=
