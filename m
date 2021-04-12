Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 414D0C433B4
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 13:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 111E66109F
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 13:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239787AbhDLNvn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 09:51:43 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:29563 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237043AbhDLNvl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 09:51:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618235483; x=1649771483;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=Cro//+s30GWPMDPTPMGBS1L/sphOy7YZHRoB4l8N60Gfb60Adaj7W4Bu
   3SMy4FhG2yefKfhPgisN6EQXK7kg7tLFYP4lhCRW0huw8r3TthVVjR1mv
   Bg+lLHlNch9jKxEly7HK2syh0RtJZfxU0AKVnOBWmkiHOz2fIDPq7kcH+
   iIqnCmIplHSuI1ieJJANzdKyjBku3TL788rYfRn8t1bJmF2LWS6hYCJUs
   /H5es+smZZQePEC+NNexfLX3G2QNVOxL8DHHkY+vcYXBHYPzoKYElwsxr
   xFNq5wUkq/sGbcQhptT7IfgPZX5eOvq/iMuKzg2QZQ/ZcL/IFdoweY25e
   A==;
IronPort-SDR: GilmJVNQOBIcrkuLn18kMWZzGcwUAOhlBghgHbkCRujwDSJbYYSRhyZVRy9fPmreWWjsUf8ZHk
 1rNp8JRHFouBWvSP8ncmLyuXZOKVRznLfoBZRQRKRWmQkAdaX5m7EuTSvHtxl+tlNsOG8gu/qT
 DLQqd+P/d9BFkQV3stRHmUZfCpqyHLjtEHC6YaGK3GZTDAX5LIIE+F7/NuzrV/uZQI9C3tLcbH
 JZ+f4naPMuDECSfp2UqzMcpbYFWv/NaWL3i6jx43nV8dSgG3GAb/FkF+bt8bq57IiqjQtSKf3g
 9NY=
X-IronPort-AV: E=Sophos;i="5.82,216,1613404800"; 
   d="scan'208";a="275394414"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 12 Apr 2021 21:51:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CmO1SCKn7Bnvkgb0pZn/aFnrY5EBnYnRaMmK/ea9TorI0JHKyiM+/dqv6kHgBk4b5NmB3lX00TWYCSqIyZqtfwN4QzezkYkAFJQEDpmhNv5m7eJ5wZNs+E6ne5YeIJnHEPfkg+c2e9zcTIbcpF6qwD+7zkb3KiKnq9QNfrMQ7rMi7Rp/g1Ryb2red1J4pu1Q3I9F7s+LzChraTJxCzdwl7qfzeMJ5L1dbgBaNR598/LuAmN6xz4HtUDAJIOl0nQOfTzfR3jhVezuugdCV42Cs+jWzxltddfXIDZKzNy4kCmNdrK+hcy6vU/XEx3jRQDZdV88oXHVY+PXofLCPKEVUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=MnKefF0Z3ItRnsLvY5SfTok0x7Glt/vHXFlkJrEAdnEPLzyQa1iNdppDNv3OhACMbG5Kqr8F9ls3ydu5WWB3VPE/sPhl077epAgChRSWC3AfztTWjtlpRuYrjfPDs6XB0eBozR+NSFnM5cMQ2iNlX6m+2LIOvUT/+GZ9y/K6CjGl1iF6MTFNZXwROzgShkN/pe+tu2YP5KPf243nf1IlWTuPFU2OJvArLXBvaOnpPKR13J1LMNv/UA1VsZKJMYwmEnYPl3TdH5mG9+eOxaiLqHu5/YdJlyJGtafTZIoFSQXfr4DVEh3+OM7sQaNbdZnj1ZHwOtMQ2iG4K6amQdhNgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=vfWwNqg4JpH8YMTKN8GUk3CfSGcMWsvfz4eEz1UrFbXa0DH8DWt7EFMuHEmnJ/FIpQcB5pqbjJXhCrJ2KMVIXGG39fh3MxqmXlI9XJY4KKBG/zJIjQr2gOK9sziI9hETM4JLcyTceVW4QOH5yozsLb1QWuKf9vMNAhRlPVHmXNQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7142.namprd04.prod.outlook.com (2603:10b6:510:c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Mon, 12 Apr
 2021 13:51:19 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::695f:800e:9f0c:1a4d]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::695f:800e:9f0c:1a4d%6]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 13:51:19 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/2] block: remove zero_fill_bio_iter
Thread-Topic: [PATCH 1/2] block: remove zero_fill_bio_iter
Thread-Index: AQHXL6JUJ6zsBU5C+kOYNmOc5eYn8g==
Date:   Mon, 12 Apr 2021 13:51:19 +0000
Message-ID: <PH0PR04MB7416B28ECCE24B0B313653399B709@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210412134658.2623190-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.74]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dd812ef2-a5e5-4cb3-2c31-08d8fdba0ccb
x-ms-traffictypediagnostic: PH0PR04MB7142:
x-microsoft-antispam-prvs: <PH0PR04MB71422AA483CAD8224EB0FC349B709@PH0PR04MB7142.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JXT9nJbhWsbW2njHccekU6ZMalxrl21W6Qrcqo+35Yd30qhsCcvWRQvZ4/WewvrqpD7+rWL5ulwt/zGkR/+780JAt9EKq2tGs6BUAf0/tPfpSAxS5yNvJMUtAsckkY7GojT6dv7+j7lm9sMmqQchJ91UAyzuPoBKhpw36aQ4PVf8cy/aYpQVkJBZpGgyupx2BFBWZbSK/r/8gSKNGh1MLCQNYGHY4JxPg1L+9aKmaO3OrRdNnpPxW0A6OvlpgL1nl7Csnebtdpyqxvtv10auupb8hkP580PzfbHuh1AFndpmEvDmp4V9LRCbS+sqH3z47W7GxzNdNsg2udopJ+lh6qCC7A8y34N3yVYY5A5j56biguCkKHtR7z4QrTSiIzupVTVcQF7XM0Y4+OwFPlQRktgXPNB5+GxKiBZoLc2Sr0AF8i5Q9s0Rm3wBASBzzXJE+YOMcViqcgzihQvuFbfzyHfOE5cqyQpGQp9rDW8hqP32bXgTiEuYgdG5Z2f4TZ9JLjfvEuVAcoIOZmBr76tsuTLQmbgfgfGxGKE1RpZKCI+2DT23ypWKlDp4WTGkmSIZwuiMl55bB2G18xuQyowCuHqe5HHVQ0BRN0O3b4gCL1U=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(6506007)(66556008)(66446008)(66476007)(66946007)(52536014)(5660300002)(64756008)(71200400001)(478600001)(38100700002)(8676002)(55016002)(2906002)(86362001)(9686003)(33656002)(558084003)(4326008)(76116006)(316002)(26005)(7696005)(186003)(110136005)(4270600006)(19618925003)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3rOCULoND5cxFuEHYJ15TDi9AiIQNuBx4UywFQF0mfwweuhMInq478YhnWYx?=
 =?us-ascii?Q?fIHqtAF2YqYybCuimXErXofUdg4y2krk4BM9EWrAeXPAXUfsF22WA7AECF40?=
 =?us-ascii?Q?l+9uGY7LinbcAhy10F2us7zyvs+cn9WgzfD4AzznHYhvRMdjptPmGg/fchfT?=
 =?us-ascii?Q?H953VgKlAL/JiL/p87dAVTbL8x1BkS0MZnCpuZ0lG+U8bSDWyjQSznBPwopp?=
 =?us-ascii?Q?oebDU4gyi7+YCCE+ELU/0rCExC2YUEBO6mj/dqdSSkTP2jj7CqGO4aYPHw0t?=
 =?us-ascii?Q?FmbeSwbdNwPnC3YBY5DuKVuLjRUBj+2XEuHzgbJPmUBRj6z9MKLsja+uPQ5Q?=
 =?us-ascii?Q?zV9lg0PpDuItrZfyJsmo9nhm0S8Yf7WUwuMuU4bS970JR6/zEExdLGgSxyDI?=
 =?us-ascii?Q?zhi028hPTPoZ1xbofKlMlj93LmLsg7+Yp3bBh6SZJGmGlO58WWGZ+D92kkbk?=
 =?us-ascii?Q?UU1b79VtO+iWfpbUnNeYAY308i1TXFBAfbhRYvbhou5E6GVap4DDuwtYZUUB?=
 =?us-ascii?Q?lbsO6CWeXOjMGqBn0mKTlSEph6ujHUHLm83sdTwoAViGe/HSWHCLwfraK+eg?=
 =?us-ascii?Q?XUChS5GzcOp1kavpt/k0b9RS+SCQ9gIBSsPb+daR2+UCeg+b+q6r5vJlvlp2?=
 =?us-ascii?Q?ldkT0b8Wy/3/tYzbgiIWRxb7hmBw5YlbrXRTG7o2eTNAs0jDOvFvW0CNrabQ?=
 =?us-ascii?Q?KhgeFDp1l6jPP5B9ySmeEEFH2KyU00jlvLvbwrcev/FjmOorIWIkxb7+Miy8?=
 =?us-ascii?Q?dflgCfcw5p/zY/51PYrlYvLFFLagLWmAiYySgTspSPUnJ7Iu8WPyJLLsQQ6q?=
 =?us-ascii?Q?uAc582XsV4KiU212FI2xgznop0NZN/6VAtpJkfwp+nMiLnCnE0UpF/ebaXuo?=
 =?us-ascii?Q?XGIvAAoV4UDJvjmq0jrqi1pFKSSwckAUS2jPbevgSYEJJSOBGvpv3hSFeTIl?=
 =?us-ascii?Q?Y1g36VA9O+24E3CYZS19rxrDvOIBcc8c2xe4lm247jS3tzNTa8jJj3tDIE83?=
 =?us-ascii?Q?/xs9rUcaq7T6k57DCXuC8NDgTch4wQj4bwTkaY7KVxuB1tYKjcIahPFccY7c?=
 =?us-ascii?Q?2w2txcBqqNmSKYmZZW9bnC+sjztquwKYq9ozApMF/PLEEyMNaNV7/pTOKwB1?=
 =?us-ascii?Q?n5jjk3iG1QUeoizX9iBR3000E3rbSJQoh9MEHXR44PZLcPD/PB6/XcflfBrw?=
 =?us-ascii?Q?R2HWx6dbvh2LVx0M4Y7CXi1sHZIU0b6rh9okSuBfjeN2uaGswp6eKmjQMgYX?=
 =?us-ascii?Q?SPxPhNNE5lt4BYzlrNoiQ9sxIV/Je0yy15ZccF60j71r8mPVwCBmx7e8s2MN?=
 =?us-ascii?Q?66sWRGQDdYz/OyNjiD/zAQbLcCKURSqjLAuUKxILkPP71g=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd812ef2-a5e5-4cb3-2c31-08d8fdba0ccb
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2021 13:51:19.1558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aFEgQosN9+FL0Sijh1BDj8NZ00a00QsGk/F6eiWdfq4Af0bgNsHFXEmxInOLVZbQXzjmPdL2s3IamGKMJwHFhvA8uyyIEVnCs/LWEf/k+fo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7142
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
