Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC7DC48BD1
	for <linux-block@archiver.kernel.org>; Fri, 11 Jun 2021 02:35:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A10961364
	for <linux-block@archiver.kernel.org>; Fri, 11 Jun 2021 02:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhFKChR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Jun 2021 22:37:17 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:27201 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhFKChQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Jun 2021 22:37:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623378919; x=1654914919;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=axlX/Irgn1dsoSDqjEEBAzBzt/ccDb4md2gtWDJcu1g=;
  b=GlyLeaU4YPpqQ8KQ2u4tpGRDnFrHqMbf6gADXFdH0/Ee58Jx6hCeF9HQ
   Z2S2kR2MH7kYsqScr8RRGH9ozGnP7VS5PqP24dkhzlh/gGscdE+knZtWQ
   rTg5G5lZRn1MhUD/1KfmCk6mj2vq2cBSNDjRQn6aJzYZ2ZLpmoqEyLdwB
   DrD59xsSjj8qmQaJS+cFOiKxa+wJl0hpyBu5BBcgVKonJnFyePpfEHs4c
   qrwyomGlgsvMuU+q/hsBNxUtkKDhHyAuCV15hW5CKyLDRtdkXRokKoMqe
   M+QLtki3wMnkXJm7iH/Hogs3In6QdbhgwDMktu1CCayj1CCT9zqI7qAsy
   Q==;
IronPort-SDR: MPA9sUKWKYuv/FOMJGKhvXytX61ZuNSY7ZgCcDOF1I8aON/dOXQ0bFXjRPc9zQ8quDY7tDubSr
 v1K7tAsWcvEejktqwS+eAmhdNETN8cYwFivVfYoAEIGRK0CAaN+5IMWKkWiwayoQnXQlS4Y7BG
 uF4s6mzwjdyQaIgCHMW4M1wfrawrU0jBfM5GSoH7yMFn5W+Err+eBxUEygDpGdIfI+cd3/OgHI
 bQWebEGHVJH0GrtQULC1ZZv4Yq1C4Tk3nWb+gIw78SiIeBdnaE3Efk2eSikDrmNEgp9doPdKUb
 7xc=
X-IronPort-AV: E=Sophos;i="5.83,265,1616428800"; 
   d="scan'208";a="176301001"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jun 2021 10:35:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dWYRAiWCiS0uWqLkEIZNz9l6qXgpPicWCHirG3FMVQ7rUYtAnkbiklD37oy3W4p9y8iKfzlSzyCIWFXwDO8+up1yfu97H8X2lN/ZuS0sjq5W2C1N1WNwCaPNtllhMRBGZGs3/YEEC0wRcSuGYP87c5JTluwqkeahdButdKxurhC8rM532E8NbdcvH/1NbjoiEekv/PSgknLRx8+tABOc+Uz0HrtBYY22pOZQ/wM3G5Jc6m3vqpRcC+fSHref3BMR0Qq2WMzqlupsaQkHtMP+6qZTswMhhm0l0/xB1rt7wpbAR4jB+cvyvtKqae7Q7nr91v+72VjmascjzRRuoDeOYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8Ia32k5fp5RbRuBM3QOFhY7occXEsSBdjP8UjG4M9w=;
 b=LVb/QNgzJ+uBXHt9RwfVvLO4pJH1PIdGhzoXZrfMyCN1hpRvBo0ccw/PSckaM1tqN33bA9YO7cbS8vu0RpFF+3LSwvZWBT38flVTWGY09BpLAaVbpK/RSX+aoygMH4RmHKiPJ5WFvz1slhC+h/12ImHp2IEhVr12VzFnBs65N4YyLjoDkUqjGakzqIyJDex8u2tZUKfj9kP31pnaRgzkYULk8c2YfeM8z+/qAAqfBPVlayzXRBFGqTRoOI8qXBsMHGH3vlOsLBV7KoBUdCz2nhTWc/NnK5P7w6S3kF3RygOryrRbsqlZqADp9OZdItZq8KscV59w5lGUpNf5VzdC6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8Ia32k5fp5RbRuBM3QOFhY7occXEsSBdjP8UjG4M9w=;
 b=ZATbRZEwQJ9hpPqGkE6D+AExNo14meNxKnNi+hy1jerE+QdftoeQbihHIZ/SK0fLBSwx0kqItp74P7Vo+9LxXyCy47sMWRXbB7blOqFLp1hLezABWEy8bzDKCLOP2g3jKLzc7IEFLSrc8Y3deCEA9zrdri8RUonpD+N27WJWdBA=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4520.namprd04.prod.outlook.com (2603:10b6:a03:5f::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Fri, 11 Jun
 2021 02:35:16 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4219.021; Fri, 11 Jun 2021
 02:35:16 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Wu Bo <wubo40@huawei.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH V15 4/5] nvmet: add Command Set Identifier support
Thread-Topic: [PATCH V15 4/5] nvmet: add Command Set Identifier support
Thread-Index: AQHXXZijvZKt+TuY7EiYul/aeS4qHg==
Date:   Fri, 11 Jun 2021 02:35:16 +0000
Message-ID: <BYAPR04MB4965DAB9078B76AC9CACC8CA86349@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210610013252.53874-1-chaitanya.kulkarni@wdc.com>
 <20210610013252.53874-5-chaitanya.kulkarni@wdc.com>
 <923a0c0e-2f5f-e2f7-aa3b-b4feddd754b2@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fcf69259-3a9b-4d56-8873-08d92c818c46
x-ms-traffictypediagnostic: BYAPR04MB4520:
x-microsoft-antispam-prvs: <BYAPR04MB45203A1A8E20002160FE7ED386349@BYAPR04MB4520.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fib6znNN/ScU461nXZxl6hDdd0H6BYx+F/au1ujX/7pwu82x49aw5bEKb5EAKdkZku5q0RVSiWuOL8SvDCVp89an8cx5iINLXoCWb6U2STC8JXwbQ6+u70G1JEVvnh4dvgrvSvOEVKqK50k7E7LhHtyLjYfYkaax4snFuPIoNhR23e5NY5Dx3ayU9wSOPxC1bIPXYewhIxpwhcRKI8McDF3Gj2/nZ4IhfRLbM2lNQbK9NOpx8gegGPuuyxb71u1d4haRjMVZI4Wstr2yxTctRpiyQqWS49HONZq8hYPovbHPX7syxF43tKFh/Hb01koIr60uKMR6JxaWE+GwaDcl+ZzrmgH70hF0sAO/aZgqag8IddLkCN2rNWqLn0UcraKLxt5mUhMxfFpdvbOHVRnauXRYFUL/EYQ9jS0queK7KTyUJsCLq8KWssxLBhRJM569vpAa25FZfV/QG5qG94SPEBKPU51IMzNyLKqiXvCPCF8Windw5j7GtbTYZD+XCsC8Ji5ZK2GmlQD3zCneIfwSh+oG/OspAL6W5cSv/iFoz8sMk9zoLTbPXVBoPaizjFtlpNXGnFHXGKtBkO9+ueRxdHC++8fq24amqe39yd/it7Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(316002)(33656002)(38100700002)(55016002)(122000001)(558084003)(86362001)(71200400001)(9686003)(8936002)(5660300002)(52536014)(64756008)(4326008)(66476007)(66946007)(76116006)(8676002)(26005)(66556008)(478600001)(186003)(66446008)(6506007)(54906003)(7696005)(53546011)(2906002)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?F5wMFWvGu74C2uWfiGFGMhtjgqah+AudQBcmrCBY1LVw8VIDCaUB1xna57B9?=
 =?us-ascii?Q?axA7RKTci0i2Fjf3nzOza1xWaI7fmoo4FATY7Qyt7Is6/kAe2KggVeZL18Dq?=
 =?us-ascii?Q?gvG6E6lQAIW27clvSQTHoVtVEaHMZdpQGitNB0NimwuwywvasORcDJ33d1sM?=
 =?us-ascii?Q?9C4sN5yn1CAeRhEt3GDZgIGy0tDySGSMsOe7TIugjPPoxMh+eDlw3Do2B/bm?=
 =?us-ascii?Q?WtcTI/5WpUUmAHCWvsgApvVOGSyhaIXnxaqE59hdkJBjX4nBl13sphpxU9GG?=
 =?us-ascii?Q?QADP8qsclveqxHt5V4UO8zIHXY9quoyJxjec5YSZ3ltEENmHLb4v2w4ujcLg?=
 =?us-ascii?Q?o2k1OMKw7apXAMy5CNSxSvF5trw2zHPaNhu+/70KYJgiwmoTY7/nkasUbNRg?=
 =?us-ascii?Q?RaamYPAsaqeooNb+h+q8ZAjJp3KRX7Ops83q76YTiPLDx/IDede0q3crQ2+W?=
 =?us-ascii?Q?7gQ385VjK4J4Lsi0R/8BFNEaVe9vTAjlBbv5aHCT6TlRQw8n3Rrk6AzxvVCB?=
 =?us-ascii?Q?ZP0CBa62CRfF9NLpvEWJ5ikYivzyM14UfAG45FiZdc1ZKikKYZOlrEZiJsYb?=
 =?us-ascii?Q?eM5DHKMD9c1vplDSii2HNjwAhi2D7EB58PJnmmpUAV8lwLkZ9Z8Q9GvDYxr5?=
 =?us-ascii?Q?lLTJfyMUB29Qo9PrNG3iXD0BgM+6TT8+RibOpr180V21nG7aZE0A30VBmei+?=
 =?us-ascii?Q?x1AwQdXvAC26b7Z6CU5Dgh1Kjz6jGLmlMYLmk6wj9fJO0T+u0cJEcamurSxX?=
 =?us-ascii?Q?nVH8yH56YcOEZbtjnGu+1Kw09AZzMtpuolzXTkWJA2VquKFrodtQbCdpBVin?=
 =?us-ascii?Q?BUu8oCq02crTb4X+ejXTD8MW0Bhz8Ih6OKqvvG5fvp5syk450vrXKMNucrxs?=
 =?us-ascii?Q?LQ+5aB0bRBehjSmGi/xDm1fjbsHOC36QrzZAAl3SjFYfOUTX5FKC519EUZZr?=
 =?us-ascii?Q?CPtJ8ZO6VN/Rhcz7fYBHuXbORxtWJiKiVC6fYmp/Z75GCHQS49Pz5Hu3itzO?=
 =?us-ascii?Q?XIebqjmdyKfYLYhFWbAiv/ly8tTBXjlWjKdw39wlSP0qK4dfxST0BxPRkqC2?=
 =?us-ascii?Q?2IfF4KnP8+SpmIpnZGcvPnnPmmg8W8J8w869DfOSCTUfwy+badXgVTJhsLE+?=
 =?us-ascii?Q?yQrq2726OEiMfjcp33mQ2dtCT+jWJ83ChCHcqLjoiB9r9wSvuHisu7JjyXSr?=
 =?us-ascii?Q?zit5Ye6o5ZnoXpyaNbPJzV6dIRoyrVeJjkZ1TuzBy00RrJZjo+ioeFrn7JQN?=
 =?us-ascii?Q?8VfMPgUxcC4rLYg15wpbOsSq9Xl6Dd08+nUmLphuCSK+gEg/FTr4IL3loNA9?=
 =?us-ascii?Q?0QywalUHG+dGugcblaaInmZG?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcf69259-3a9b-4d56-8873-08d92c818c46
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2021 02:35:16.4542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vf/8PuWyFcykCYmPe1Iuv4nNBo62S+2aqlvlmfk8R0yvw3UVk+sMKWUoAdAAT2pBCl0Y5CUucy00xKaq4lNP7SE1FR/T2pslDbiBwqUMsVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4520
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/10/21 19:14, Wu Bo wrote:=0A=
>>   	case NVME_ID_CNS_CTRL:=0A=
>> -		return nvmet_execute_identify_ctrl(req);=0A=
>> +		switch (req->cmd->identify.csi) {=0A=
>> +		case NVME_CSI_NVM:=0A=
>> +			return nvmet_execute_identify_ctrl(req);=0A=
>> +		}=0A=
> Is it missing to add the default branch here ?=0A=
>=0A=
=0A=
maybe for the consistency=0A=
=0A=
=0A=
