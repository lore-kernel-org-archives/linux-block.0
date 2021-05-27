Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F9BC4707F
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 08:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E3EB61028
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 08:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235496AbhE0Ip6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 May 2021 04:45:58 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:30566 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbhE0Ip5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 May 2021 04:45:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622105065; x=1653641065;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
  b=XL1/PwGacE7cx0H9ypDUCzfnj/qgXPRPv8b9Qiq0+NBFURs2CB2maBjz
   01BCZLq+ULIsoHcC5nkUMyr2xywXRaQPLKWQsIfz9EeK4ucEMIGtALGXY
   61yi7PWIUu/K0WGZE069TfmQz6Il6sPPAthhGxLPfdqd+j7M1OKU6zb5/
   46ZN9rEKtS4icJjPtSD3OqF+LFp2Kk+GeyT8Ysllca8pAFHF8Sl3LRKCi
   UJsCW9aXSogSRk6xb6/bO9qUzE70dp/dFta/3ZCPpQyAhRTn0PJQPJwL5
   lC3NARS9//LHSsw4aqfepu820i6CEiE23BJbi1zPSk2leds2aeE6B8sjJ
   Q==;
IronPort-SDR: viIFi/4zxhVSlv6L4p41Tv6WnUEazpIRUWBgkuWg/lEDxkK4l6toEr35gdMphUwTtZlMfFW764
 BzqMt7QWjJRQMRtOXptjU42TYJG4EP8j3pOH5vezfo0qTCFV6a5oe4a1sZ27gZqPONFqVA4OI8
 wQpy3ygcbSreHiPZVZmZ0NGHl1EPdWtKEQUXoYgc/wXZiEGuW7E415Wfb/m4VEyzcLvgyLTtjE
 u8XYJZ4BOrO0o7o9bcl+3h6ux6sgEprTvTVEotA8NrODPLLdFcMbfj0pvZgcYW/tHYk9gPu+AD
 hw4=
X-IronPort-AV: E=Sophos;i="5.82,334,1613404800"; 
   d="scan'208";a="280942569"
Received: from mail-dm6nam08lp2045.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.45])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2021 16:44:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYHgyCtwzlL/+mF+QEoYoLBEaK/frXKhQmYB8g3QVgIcqkdCJaPZFgLLY1aZMsShFEF5MoZ6Z2qKPzQjxfe9iAP3fGF1IKNvi78td4vRXCW/On3i5bWydUffJTVq1HhEECezjRx+a1Qz+8yjAM6xTHNzSklBmlrk4fcrQlmSaWhRMFYaNf5wEUzIpmrbf36DZunt6gPPnHwK8qchn7crn47HU9NXUgcjrfHahj9WxCv+Nw1erZxXu3O16+IeEUp76wK5SwWTYjD5uQ41X4S9Of1NmlMJRnnY+Yp/nq+X/DSocoC4VTpQs29Qtl2mnP2gcg888TJ2Mz7t1PJyPcPpIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=m+/mpooL04rcQqYcULW26n724ZSCULgGqtK4TlCqJ11+vX+Pd5rIGDvWWag3ePS4jplizcdS8b41d1JTVBpXUbK3ZwXq5MQSYfiOzlTPIQxpj/awAF4G6qFghu9ReD6kaYZxsaeSJ7h9aqXk3Dr4tmdBCSTHcMKgBx41Yyin8xGU7u8tiunxfuS4KrIqMO6DBLbtrJQ7EirNkKLx9VtwJliHHmm1Yc3X8w8uhvYjBGVNz4fEuMDKQ7WWgstIYn0mchEl/TGfF21wB9VKXB592Nf+0nEH313kDHaGm+9rCFRbbzj17eyEOeVNHxJdnUTAo/iDmZpWkoauBWPs3mYASw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=x+8h981cF8ccHm2NvLthnpwARlfWUj2KEELnJNuile/T9RbgDVzRlkJfIIsr/o+1ucFQVgW72uHvKtcMsi2P6k3xwp0dljTHxWcSuP/uFVnNcLow00DBa+VKx5Bg/DL+KvSHvbpYj9hTQAG6VJohtW8I5HLe1lXmRZTmZj8ijBQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7622.namprd04.prod.outlook.com (2603:10b6:510:4f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.24; Thu, 27 May
 2021 08:44:23 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4150.027; Thu, 27 May 2021
 08:44:23 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <Adam.Manzanares@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 3/9] block/mq-deadline: Remove two local variables
Thread-Topic: [PATCH 3/9] block/mq-deadline: Remove two local variables
Thread-Index: AQHXUpPwLOp1tCA7YE+jXN4wSw4j/g==
Date:   Thu, 27 May 2021 08:44:23 +0000
Message-ID: <PH0PR04MB7416EC49CFE870817E34E88C9B239@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-4-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4621701f-5f83-49ef-ba45-08d920eba0ac
x-ms-traffictypediagnostic: PH0PR04MB7622:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7622CB602DD7EF50CE2BB96B9B239@PH0PR04MB7622.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: foxrjKGWDm97slXOldQY8zGGjJGqW/DIrw0JUSJxymWuU32FbplW3wbrYShSnOFRIj2xqFp4u6F4i2fAXzOBdlgaRgjXkxjsoSfaqfZcTxOkwFQMjDDyXXj3mtcNTKqblbms2QxAzGaZiVstL5M6lS50P+klrkHlhgzK/hmU4lx/ERBf+nflR1OVJBailGoBECJW7XjygeAOxdNkGQJzdO0HYe828NdTFtdOTi4wXQisBHcxnK/51zUy/Q1z21hi893F8YPybcaT55xOLaKL0rSFlkmTMp+kUXRQW7fqqYMKpr6OhFfqctgpjW/mdndF1NYe91pDV2I3YyPluGsQ8PAScfH2TiIvuk3FN2MEXsRN7AkOdQ0og7Ar7PGgSGlkFr6sVUN078mClRFS39FXFfpZmQ6R/OCWeKHESyZBBt/PUX1LLAwIYOYcqsxMjBCb8S+ks4F0XDvgwPi8CB5SKVi6u9ZHzrJnms/Xavo9c+35kidTZYrez3iHht+cgYVpYDZ3C8aZAVY2GMnJqvZ9FzEgqEvxJDwjc2ScaszA+eWG+vPY0/pNmNXtqQR3FG5A5OHuWVkfV+gNnRmeHPGIZ5OnyHQZZ4olsOz4PZNak0M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(136003)(346002)(39860400002)(396003)(26005)(7696005)(478600001)(6506007)(86362001)(4270600006)(55016002)(186003)(558084003)(2906002)(71200400001)(9686003)(33656002)(54906003)(110136005)(316002)(4326008)(19618925003)(8676002)(8936002)(5660300002)(122000001)(52536014)(66946007)(38100700002)(76116006)(64756008)(66446008)(66476007)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1M2XCEsPHET9wYrtHme2Ons1xGyGol3kiYhK0AFaAT4hoQh3/bnnPNjg2BN/?=
 =?us-ascii?Q?Q+MA+u0XVbY10C9O8Osx1HIQwArYPgubmqlgxBa8pg+i7+REQXCfyJ1/JpVF?=
 =?us-ascii?Q?q9kzJolawIDoY1oNM+JE23ysz2GMUa+DBjInDe5GYFjsKrgR+4JR6HQMiiWp?=
 =?us-ascii?Q?Upq7DS8Pb3D+Ql4vylOOwvVhkHBt95qxjbFMbRE55H1VmrgWgZhcvEirjtad?=
 =?us-ascii?Q?5V9iQkphGQOWIxQPlAzxRbHopvJFm/41i5WyaqVRAYZDlagTCJyvytmSS/uu?=
 =?us-ascii?Q?roi0rXB1NnTs8AccXsxY94QUtXHUgrWjJRobvnKAV3Yh3IDqcQw2ji4LPYMA?=
 =?us-ascii?Q?tc7e+AjNl5OlJ++7MUTPaD8z1mrvNZRKIA+cPNuZwUWN+GesdqdEbKqgzBxk?=
 =?us-ascii?Q?WXOMhOgSnYQQMNezLLbtWQk4JsDVVQAVZWWoT9508wSevqZtVBH3ZZlsX1Ej?=
 =?us-ascii?Q?GQxzdt5WzPs3pGt1aJ4bsfQSgI/e+sSOZcjAjDV5xBUVcVkKA0NvFdN+iIw1?=
 =?us-ascii?Q?RpETeQnwagNlnNI+2aLj1nr//aRq6whWXYBvmp+O7I3UwUm9OI5D95VKG1rB?=
 =?us-ascii?Q?Kpozlg7+RpBqlvVNo+WxH7dP4rbNyK2s8zCwcLNSCXvueghkt4KVgVQ3iTLU?=
 =?us-ascii?Q?qOZnegkMv4RDcMwKyCVo9CSZg3y+H+i4LZYzjcMEs5t2kLuH8J+XxYN38gaP?=
 =?us-ascii?Q?VCGtZW05pYMKCig9kBZDP2jlXyDylqFoQgWU5Ed4sa/ARPV5o6oA4wkQ22rw?=
 =?us-ascii?Q?VWdKMqKOfSxk7bWWqqf5vCOFlmL5a+iycvrv1/CCYlUlgbLmQGrOvoGde51Q?=
 =?us-ascii?Q?wvGbtU5+b+HvG1lvwX2E8Ornh17mpUQxIaq2LaxbJHSudZmquLZTq+1+y/1Y?=
 =?us-ascii?Q?aAE++EA91WFoqN7xlRR0HUyj5NMsjKuqh8KalVg9hYDiiI9OoBvAxv2Naeay?=
 =?us-ascii?Q?zNm5MMJ7WMCQCF9W9IestnG8Oaj3qZ6ZdM0QVKkyIrq3hh5FVGd8cCAHxI/S?=
 =?us-ascii?Q?/Mm0tQ1AVXsZYE8BrtgoTyRdT72hn6ReKma/yvILgbeDXZNn5ze7+k4YnKkH?=
 =?us-ascii?Q?vyYTJT4V+U888G1NSc0Ahm/chlQwBIimzhfcUaDtGgdRXbzwEB+8Q5gvUdiS?=
 =?us-ascii?Q?tceQbvZQ3om8ae47jCiJCqHayzu4nakHrbQ3XzjwTd+rkj1KhH5PKscHF6f/?=
 =?us-ascii?Q?DomJh436NOX2xI2VXFVGBPnc3981w1PIBlk9upw6VbGDzPSkXNP2WTgByRWf?=
 =?us-ascii?Q?vFQzIbhAMLCd2jMys4Ko69iILS/pJZW09idWpnv93XUTsr8knscaUtyRwiXo?=
 =?us-ascii?Q?85FqtGZe//G6wEMxNJfPjCjRlDR4lEB/mETnj80V83iAXA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4621701f-5f83-49ef-ba45-08d920eba0ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 08:44:23.3349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kv8kpg1kNvMlf7x/FQnVR0pEcQPLoFPv4UsHEWK7wovqIpZT67j2Om50FfoqXvpVSY573nzJgmAdlVwKMXWlgTPFMgKj4cEW+0qx9zyOS9Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7622
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
