Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DB5C43460
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 01:56:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA0326108B
	for <linux-block@archiver.kernel.org>; Thu,  1 Apr 2021 01:56:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhDABzv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Mar 2021 21:55:51 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:49181 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbhDABzZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Mar 2021 21:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617242125; x=1648778125;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=rMNHdgSR21NzW02Fmkql6sDq5Xjbq0V9NCt7ydD9mV4=;
  b=jgxrKkCqWcqz+r2c0kPJeGLeT8UCCW+GmHVwcmIZcYqUnAgh2Ugx00V9
   ik84jbbCEx3ppIh8An3/vEEtjFT4O1FZsvZtwqdcxMO9vBDCVzvQ1MEke
   7A9aQouA+3XYzKMiyhpRWF7Sd6slY8iBtixzR2BUgjDn+JTV29vnjCe3d
   R0pSfwOaOyZ8T6/2DtU+BXIYtPLpAzx+8kESDMrAUrBrMDwI71vO77WHf
   3AQt5jWk6FbdpNhP3WQLRFJeJ+hlk1Va5zBOzaZUM1zXlt38gLbnhIduH
   HOVWVh/bgJACOjcyeQWwrKG3poTD3gPE1JSwr9tEQ0APo69kFrvEmGXeY
   w==;
IronPort-SDR: SL7UVc7A9oOaKriVhYqK6sBBhxTynq5LubGHRIOwf29gwpXuxM4yViZwJ3bkuuzJiI5Z339cyf
 l8OimVVW8DAX/P+Hlvsfa+IzKrPqMpo94rl5lrI6ygkSXm9bTpPmx7rdJanhrbl4lS6Go+waYe
 sm4K39w+d7CwShMkc6whtAGNunmF71teDEY29zdFZcRAXHvK9XmlwfhxICFmi0oHNz07BAdBWy
 p0+TOFIAuwfQ8Tb55yxd9Et9PdkLDuGwdxyY382OUoTXMTEYnq8pa/IDCQqc4UuEbw1Zux6KNa
 g50=
X-IronPort-AV: E=Sophos;i="5.81,295,1610380800"; 
   d="scan'208";a="163511708"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 01 Apr 2021 09:55:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FMr+233usxBK/vMLLG4jF8YirQnaUUQeSy8tcq13TSL8SXRk0umTy2bGe/njRoo/OJSxFb72OZOIuGYR+RysAIIy+tSooIzUcvwp/xFLt+ED74VvVnAjEQhEbYkk5dWW5ZM11NShq1VRSb2XDKT9uCPi1ELbOMbMbArDoGjVSWuspZpChpt/gbcTkfl/nf1iH22SoqmxMyJRrS04wMoHbULwbPYqPuXI/GkYAXV6V/iUhKeLSmL5DRUP8sa+BXfqXh419eSCO8CJoBMmNR1qCglo/dsL3boEU/Bn01CunVcU/EieGng1yNprlP0QP5iN76tDBf71jacdomoRP24tCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkguBf1mEY2/AGo9VnEkieZIZwawA62Sd2i5ZA8WqDw=;
 b=e7ZqEXsYaPpVQtEs2Qdgs1sMXqFaWzyNHXt7iAb63kLuisOdtDhQvVpf+/M+D8FFVx518CQJqKW7J5vOJXMpOlgX6Y+Lbm7jMI6An+0eXgk4BrOGW6nbAzNsfb6BVAwxRvQ/GK0YjDBYKIPJiytdMgL48VNt7Wtot3X4bQU27XuDq31Czg390DxeJufXY9iYJt5qvR98uh1kNTvGN9FOWee4w+WqTuhec9xCdJ6CsF/iF5s9AvW5w5fgJ73vI4WAKrOH16m7qDFO2jum1sEcyOkhhpl8OjYAZvR5URxJMhYpJdhFWTIY8a8qlgUgkZTg/iHxQK+gKchxRC3hp0a8iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkguBf1mEY2/AGo9VnEkieZIZwawA62Sd2i5ZA8WqDw=;
 b=wG44zouNdHe1CCo++ct+ctXcejca+BpYBoERfDmT5WhHxnJwbgIaz4S04/ETbNyWXyGk3uGq9KZnradc0+R6i8Qblth3GG1HasQopWAJ8RvE4GBcES1SxzCYjpqvbj9C/Qb2dvS1afrTa9v3ZI99PxdYwmGEreZVRMfKbgZoJqI=
Received: from DM6PR04MB4972.namprd04.prod.outlook.com (2603:10b6:5:fc::10) by
 DM6PR04MB6938.namprd04.prod.outlook.com (2603:10b6:5:248::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3977.30; Thu, 1 Apr 2021 01:55:23 +0000
Received: from DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::882c:527b:8a9e:8c01]) by DM6PR04MB4972.namprd04.prod.outlook.com
 ([fe80::882c:527b:8a9e:8c01%4]) with mapi id 15.20.3999.027; Thu, 1 Apr 2021
 01:55:23 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Yi Zhang <yi.zhang@redhat.com>
CC:     linux-block <linux-block@vger.kernel.org>,
        "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [bisected] bfq regression on latest linux-block/for-next
Thread-Topic: [bisected] bfq regression on latest linux-block/for-next
Thread-Index: AXBfmr8LEfgvZQ/4efLqriWGzme7Kg==
Date:   Thu, 1 Apr 2021 01:55:23 +0000
Message-ID: <DM6PR04MB4972E4D2857500F644758516867B9@DM6PR04MB4972.namprd04.prod.outlook.com>
References: <1366443410.1203736.1617240454513.JavaMail.zimbra@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8fb5e792-a839-4707-bc2d-08d8f4b136d3
x-ms-traffictypediagnostic: DM6PR04MB6938:
x-microsoft-antispam-prvs: <DM6PR04MB6938470C33B5E4D4FE85908D867B9@DM6PR04MB6938.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:843;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xuWN8OKf51wVgGs4gRwnL3bBXtQWPvGVGcvHlF1+8Ntdudt1LwuPyZsbGnAv7JuGQTjnHQm6JF4pofYE0zcAhmd3D7fDvZlBZ7IofZ4ccN2VJXg6nBw3CF3ILkBkgC5RrMhhmqF8HoK2gQB9lqgx3nC4+J2Pbwku8cD3cfYsoh/wZ0ekjEqYzrZVW0phPJb9ofGiR5AfyM4/7dHSP5D/G6zHXCpdDcJqmctI4Rtc/pr2g2rmYaUQhQL+nHoFC9W4i5/PnMJtXGoCuS+Ja0Rvq+SZwBmOvM+fQTXT/bJAGOIkLXOLkWUO+K+iNZBGEdRTo66edfRKgY+DuYDqf4eqKWwVrzYpMnXIE63b1cXaOHPLhtTiTWBv1rIZ7IIhBd37gM70C+2nvMBJXK9QFC6blSsvm09rihjC+bs/X6l0PPYxDreKZWJbyf/gpy+SeDn9SJFyTE0628sRlVUxbkji09Ya52uf/VKpsA/p7w6QeNSZGOipsfw2cHfTNCRt/bBkUJabvHMc8Hs28njGwOGg/xW3NAQ2TgqwQ5N7fWO7Muj8KSiIwaRzrohqbCU/pnQpNytc3+T4G1KiV/AwCzcVizSs4r8INNngu10PySo4sMwGcKFNedmNq9hIGvCBA8gi416H2xMKLml3QTIuPkTDoGmWzlQ/igmLuh9qWdQQ37k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB4972.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(366004)(39860400002)(136003)(4744005)(5660300002)(33656002)(91956017)(2906002)(71200400001)(52536014)(64756008)(66446008)(8936002)(38100700001)(54906003)(55016002)(53546011)(76116006)(7696005)(6916009)(26005)(83380400001)(66556008)(8676002)(4326008)(6506007)(316002)(186003)(9686003)(86362001)(66946007)(478600001)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?mMMMqU4JQW7czSjsZEyfcMapCLa4C8PHX2WPcKROe+643tGYlUBBh2rvL5S2?=
 =?us-ascii?Q?5aVwh5QVTCEMajQMW5/JOegIPvK4aFBMyNf5qs+gG3BDF7OQvZk6nx/BUbYh?=
 =?us-ascii?Q?cDwqMTNKYk5G87okOQ05wvzLztdTxAUf8WXtuMbYfsH0DQZKOt++TPCzX8Ju?=
 =?us-ascii?Q?7pu1yf3C1eO0nR+5QgiwSCMG6LgUSR13R/AXU8SqysB6diPOdwEl2dYCfkIT?=
 =?us-ascii?Q?d0pZIL3+DiowRwvOgwt18zk3Huwpr4VSmnFjEoEJDI9BBU1ZFK5wJ21bp8Gu?=
 =?us-ascii?Q?RbhjU6CETzn5OMnOI3MWV7HZZNN6NQI16yzqEhRINCe8TAV4Zjq2nyOEvWYM?=
 =?us-ascii?Q?gc6JESbYiduuuzwt6J6drmCoW+xs8dM+Pu6N+eYtZe4jcZIKSmkPnkV0A4et?=
 =?us-ascii?Q?VQZlteXHk+k4rCURs9OJUf5we4nLMGHVdXvrZ0l2iafJmN4rDpO1xR6Mb3/3?=
 =?us-ascii?Q?QeAxZ9zxJymrXRxxQp0WwaKge8RnQMm/0MoYOouvQ6n0LmS48wvq2X141zMf?=
 =?us-ascii?Q?NWVFCzxojfAgCHQJ2GEPWF50FpF/mOvno3t9JTxx+x1VQqPrFhEQr9ZA0Hxt?=
 =?us-ascii?Q?7g+kbNvBFd4gbAIZunFkUnx+mc32Tz1ELwoAAt/ORw4gL59jDAdnYEUanLgi?=
 =?us-ascii?Q?62UzkrB8qyCwXNxGtSS2xiBwaSuUxEY5o8kmMkeUR+JH0doVG8Ipz2VzU/0I?=
 =?us-ascii?Q?eeVWMwDFESUuwgwGAOa5jQHAMJp8badMCLCnvrBpl78yu0MVWUWjXa0Idi9B?=
 =?us-ascii?Q?jna1nXrdqFQe0jGNR38bmZYGeiXLtBjsZXFLDmC6fOyXejdyZrp8ryZ4rcXl?=
 =?us-ascii?Q?v2hMBzHO4tNQbCWHbgWGQdcfW10x38FqSjbT2CSxkFIaUChOwANxFC3KO42J?=
 =?us-ascii?Q?vjESWTsLPfx5VIHEcT9XXhahJiwR1DBF5AiF1B5WglxDyLDsiepuK7J86vKp?=
 =?us-ascii?Q?1y/FuM4FjtaHClO8svywi4C9dZydPOS6LE0fy/xkyIew7PL57/usoXdns7gJ?=
 =?us-ascii?Q?AQ6Juv6xrkQdSMx2fha2LVzI267pYgbKo7NVVlaHYqAfK1oepJ9HOSPMKobr?=
 =?us-ascii?Q?r7yIrCAF4228LJFPBxPFxScXumAiGeYYu9EBH/W07/d6bw5P6VMbO3zjRRj3?=
 =?us-ascii?Q?ePVugajuk1bmIBHWxk0xt6G8UyY/rLNheCkaKNDQMtaZ6LkuJdmeBY9MFXjB?=
 =?us-ascii?Q?VJBQKcde0/ERSFOwcZiySFbgwzzolTcTS8jDOzN1/k9DxKgckpjOX5MzKafT?=
 =?us-ascii?Q?5bI3mfxnqsQylqVckZodmHSBskenEtOAZAQnnu+xueUpOeAW+hJRuXy4Gx/1?=
 =?us-ascii?Q?tCcG4MVRVURg7IIEL/AI6Fvj?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB4972.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb5e792-a839-4707-bc2d-08d8f4b136d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2021 01:55:23.7560
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zM7rhEyeQyizreo7ziLeBKOESUekUCLf0m2qjMQdxMuUXfQCbYiqAiW8Pdaak7++E+iPvMNQIAnvXy/ZCCEmKNanS1OTJWzo6va4LCcLhCs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6938
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Yi,=0A=
=0A=
On 3/31/21 18:28, Yi Zhang wrote:=0A=
> Hi=0A=
> We reproduced this bfq regression[3] on ppc64le with blktests[2] on the l=
atest linux-block/for-next branch, seems it was introduced with [1] from my=
 bisecting, pls help check it. Let me know if you need any testing for it, =
thanks.=0A=
>=0A=
> [1]=0A=
> commit 430a67f9d6169a7b3e328bceb2ef9542e4153c7c (HEAD, refs/bisect/bad)=
=0A=
> Author: Paolo Valente <paolo.valente@linaro.org>=0A=
> Date:   Thu Mar 4 18:46:27 2021 +0100=0A=
>=0A=
>     block, bfq: merge bursts of newly-created queues=0A=
>=0A=
> [2] blktests: nvme_trtype=3Dtcp ./check nvme/011=0A=
>=0A=
>=0A=
=0A=
+ linux-nvme=0A=
=0A=
Please add linux-nvme mailing list from next time for blktests=0A=
nvmecategory to=0A=
get better response.=0A=
=0A=
=0A=
