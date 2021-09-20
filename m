Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2D4C433F5
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 12:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6120160F48
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 12:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230074AbhITM6T (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 08:58:19 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:44139 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhITM6S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 08:58:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632142611; x=1663678611;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=DhbLtnaSUfK6CJ5MdAWv1v0r8unTVkfTHc9l87IGVske8XoFDrWKpv6F
   hsQ6R+vxzEnbBesEiHiq4msl6Ly2/gfnrudE6utDSzG8E7w3CBobQMr9N
   FFuF+M8RiQMF+HQOx6c+r6VIw8Iensz8n1BG8cCZ/E3oxMq58GnNG19JQ
   xBJzEj3Abj1ONnS1DqaoLIwZ1+4gB/t1e5bffJ27T+lPbyxuqnyE70/d3
   eH3DlyYvXnpCCGW01GiEUMKoZQwjliCYI0tz6CwqTaZAjPmMz4YmdGNiH
   5E0sy3PPeEh+mg2YLZsHeRtk7JGcUkALy6Uzu0dF2Jwuorm8VHn2rDTK7
   w==;
X-IronPort-AV: E=Sophos;i="5.85,308,1624291200"; 
   d="scan'208";a="284245721"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hgst.iphmx.com with ESMTP; 20 Sep 2021 20:56:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RUmoSk8ocZwG+RhsT7JpFD1OfPpVQim4tukTcFmIX4STc56BT+q9OBE0mdD9b79yNmq1s8reU/HmzkHm7Mw6VmWmxy/xDro8RCTDUUD0dicHZlPlgB4IxbTuMvxHKiRB8lW9/KozJWIVAUPUh0f2YetLVFUCvV7IWlH6qUUhyx3qGzGmYNARiTQbpCu96dmi1gRt0GJzK+AdLtZhoQ8VUi10/G+R4B6NLU8HT8JinnG+6Y82niMTL6XQFH+A3rADcNSi4rRUBYTd7OgN33hLkvojv6G7iFwYkdom/J8pBPLv4cXRerQQYwcBjSaRNB05YxmYczuaQvf0tk9rfdw2KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=BaAifxOb377xKLBL5b6Pz+SKNRIUfK0NePyUWCItcKuv6E+GuumnmqzHdq8LQIwBHexM5Quv47NcqLghStbbSqqo6tcPISti1dgaxPOBuehirKbu36s8GPpjRPo5r2+qmCN0kTfGxSoj9xy7JmVqTF+Dhm2naB9noXDftiEOVnQLRzjMZLjR5RiFk4eliOC60suF2YDD9yu/xmkV0NNUZvoz+Vuhvq94+A7oW+C6fcdLzHcypIaQv1VHHgYepFy3qw6XjYG8OBBbwoFew8yfsELqLdJ68dQyctE9sKSQ+CYHj7GHgZAzlDdjsrK+pUh/kyU847W3ooa523W7BGVj1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ukH4X/HyDnkZiQVXW8bX+H7Av2N9LrUvWgeSb5x9WTTqrbOinj0TGIkJZgP9uIcLavS6MxaznEnyPzJI6wz/IwL1MpUVBC8UzaLpA/P9lgCM59bnW3GfQENPhfUdRhfUpfceqpUEHsinF1CSybKLoUmvN8XrRdh5KDDTcVo1W1g=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7654.namprd04.prod.outlook.com (2603:10b6:510:59::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Mon, 20 Sep
 2021 12:56:50 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a%6]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 12:56:50 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 09/17] block: remove the unused blk_queue_state enum
Thread-Topic: [PATCH 09/17] block: remove the unused blk_queue_state enum
Thread-Index: AQHXrhyy7g5yv6tuPECptb0QH5HJBQ==
Date:   Mon, 20 Sep 2021 12:56:49 +0000
Message-ID: <PH0PR04MB74168411B5DD620BCE85DBF29BA09@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210920123328.1399408-1-hch@lst.de>
 <20210920123328.1399408-10-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 361bdbba-bf91-427f-fffe-08d97c361caf
x-ms-traffictypediagnostic: PH0PR04MB7654:
x-microsoft-antispam-prvs: <PH0PR04MB765419C74ADD39470D732AA39BA09@PH0PR04MB7654.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ug+Ru15W3a6Xasbmvv7CJE7xNyZx2nxZTKunvOH6pjbw3+bX/i3uV+iMixWyUs5uQTot9pkbCcqx7QFU62SbM0BhuxkoYtHp868SG8M37Tzy+K/kLi2ZaNX3BBO0Se0JcD/FueE/Q7RRl/9c1fnsS8FcswYmyxQkEzrMiykOVnHMpv/G8x0Fq5Hlf3l+vs90unAfqns8D6h18RfDyP07nIWPbhMjBuQ2iUZpxmKLwGQFkNprvc5w5LFuWkZpe4imxVkhMpXw3TJPxOzITy9JVe9xXiL65xyIM1BdJx6SMXnAf395H0SOBDcgIVh1L7GGx3vohWhIFsU/V/7bp91xQnMvcEqqiq9sZIWRV4VP8dZ1/c9RXHSWzVJ3hPsisb9BgJ4nGQV2bfNx78zcp+6b0CFkZbpQF7bN/UhCFKpmieCRkpIUCgFO47M9yGH5f7MsC7mKAuCIKXm4Kebbu3ePEstKj1dMYiR+HRvAVHFr+Mhrqhd3+0MmPSlT0Ll9Mbl1EaYljckeNEFJsRzy+fWvi6W+FZSsNEp3yT07XFkIhHggVpzyk1wdfgVeAQaTvPiEAl8uVBXFnbh7oPVA4UZDHbClqX38l78VU1pHUwxecmhKYUB2FtALv138yx89AIlk/dPmGWTPSdgS5kZ994Ixhwxi2bp4pZbSx7bY77S7JOIwu7i1r2VvR1y1CWModDJ0NfGnbFhPoNwrIYbxDMEmIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(5660300002)(33656002)(52536014)(66556008)(66446008)(66476007)(66946007)(186003)(6506007)(86362001)(54906003)(478600001)(7696005)(64756008)(38070700005)(8676002)(8936002)(55016002)(9686003)(122000001)(316002)(2906002)(19618925003)(38100700002)(558084003)(91956017)(76116006)(71200400001)(4326008)(4270600006)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qK2TNaU0cjB659ScThzgrNTWAI+4xFFrSLaF7dzJi0jr0gwXBLbHI4JsHUIZ?=
 =?us-ascii?Q?uRLwqcvmo+mv87O2fg28jQ6ruERDz+iiWt4v+Hqgi3ogtqEwMPn99h74UX+A?=
 =?us-ascii?Q?+7eBGJq/Ipq8QphNgzS0/avOAWH53zIKJ9T3KCX/SBXVdIJNWsUpfimG7PoS?=
 =?us-ascii?Q?Xrx5d7AZ910+9Mi0+a6+MjoykANOi2/fsGBYslXc9bK9O9D7VVdOLy2PwEaF?=
 =?us-ascii?Q?VHAGbxfl+aXI2R5wgNA8G912wFlIQKK0nXNlUtZS+cJs67XSa5Ho5XdnGmTW?=
 =?us-ascii?Q?QAzaNSXkGzE1neB80PGWwDLurKJSs1dbT5QoYtWI76tOABfxUZxjZ1p0WCqq?=
 =?us-ascii?Q?BSnxk6+mGgO43siHRbMIg9vZpeTKlMwSgVXmqCVPbVSBmF4+svya9I+7CIIV?=
 =?us-ascii?Q?P8kk8klc3yRdvLJpELmZSYjNBq1NQSOdyJHKLOpjbz2gp6L4EL+OxPVisXCK?=
 =?us-ascii?Q?9L+mCaLtGFo7J0eDNHL/z1C6qCopLlxUlGfXdFpjUCgahh6qC7IvnI+psh9y?=
 =?us-ascii?Q?3pEwJWjHTBbHkkcXB6LLZ16HwiGWSv0+XVcXF43wUx0/+ciRlCGTj+f/kZfA?=
 =?us-ascii?Q?qe2JYbQLM1rBOa40F7PhDln3N+aTdPEpLJ0VNCs1wnXKAsYFQY3qIwURjitX?=
 =?us-ascii?Q?7nnS1b6vadm3Yl2Po2hbnRmpKTrOhR3Z44nJOrDR82ElzVpcTe2Xd5dR2ayM?=
 =?us-ascii?Q?wCs4WsufT2PtIxHX3bx46rvO4fUIh3tONea6rfwiDkH9pHngdTzGKRdedthK?=
 =?us-ascii?Q?79d3V48Bl2JzJm2b1FdKzAagooQlyDGrUbBRUoT/YcvKCbgfCo5rd6Yf+F8Y?=
 =?us-ascii?Q?5SHWafZZYV8/hyWVI7Jsbh3rfl4irxB56JVQQOMNvbOnfQKFtTtkTCuIP2bv?=
 =?us-ascii?Q?fqSuMWuvSl1i+/gToWRgqzliEwexQDvq4bkYAD4jJErGspVb9hUWVwv1xurs?=
 =?us-ascii?Q?FT5190Z2dG8cZ0eXmeH50sQANAMjVPm/TNdKClPL0lXlYRfQfzjlYhNPGT/v?=
 =?us-ascii?Q?Eguobnikp0NObm9dsFnVsGvhprKngLGI1bY5QDn+SMAYKEGwhP7Wnulq0CNL?=
 =?us-ascii?Q?kHthh+JPtosiopVTKbJgHugyIncl/ooT2XFjtO9vbiB1LYhkhqOszljTy/u1?=
 =?us-ascii?Q?a2uyviYnJnP6dxJ329icqoXsCad8YEf9AD/1D6/u0sK3lsf3HpA5UIdyYAL7?=
 =?us-ascii?Q?ohsnA8ushUFgYdHon6CLzVnApCQVtY2NNRac9Hm5QslGlIfgw1Ch5J18R/oQ?=
 =?us-ascii?Q?wZkJwHsTi8PXS1iQ4XXmJbOM7WZNGKWGIkFE5aR9iuxCKyX9WAmyIdVpmOD6?=
 =?us-ascii?Q?m+r1n2+N7OWmNcJUtx6TBe+87OFBQqsNYBgfhNASfPJZxkLURO59qzpmT2sV?=
 =?us-ascii?Q?oCG0deTv1cBnWh6fATHnuWcwxJ0ohJn3GoFfONxNor+gsCYEEw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 361bdbba-bf91-427f-fffe-08d97c361caf
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2021 12:56:49.9039
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NznMXOSMY5JXkG3Lt3WC2SirTchnPGujfRLywB4j7pwRfflKDUKpDa0xc/+24s3skWv6FbMH3pu2/+RO0wvCfgVnQsY64IMvl9Wxt3gMGIA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7654
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
