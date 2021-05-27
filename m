Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9B4C47089
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 03:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B623613CD
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 03:03:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234333AbhE0DEs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 May 2021 23:04:48 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:8598 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232802AbhE0DEr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 May 2021 23:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622084595; x=1653620595;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=KnbVLZBsX43isGSj2qiFxAMNOaS+/cxNFqwWmo6L6qU=;
  b=ml1cdeGpNCLkd/9KKGbnXL0mRppFmMSxS4scL3et+/05n+9jrS9+qMm2
   BnTzUw8YnKj5tf7u6F3Ce5bkJfUkW95RJ2prdOLNLjBcAq3IhJIBbGNOM
   IKquFb8KsB28Om0pHthUovrx0KL6q2FtnLbpcp7AQ1k9R8PzlTb+FGsg8
   ySN990Bm4Uepmni25IiNHeNFgvn6lE7X8igIaIDPi9q03APXidmjuPdRk
   X5wNYenNMQW4xR7Xorxja78GCwAph8BRE7jonu61JJai+tOivwQd80uoC
   9R3HKGNTOllZSJj8+wMLKqdW6NMBV43dFxGCvJJNGK7/J1OdRiJncRlQn
   g==;
IronPort-SDR: UJNsNXQgxExP+ic/yusLiWs9XDuQArqbuuMYtWlBbyZ6hTm4/f0YURLCAEQsgQzWYsUQwtQDQj
 skLAWsHGFwBSq8GHpVKa9Gqx6G0IcQof0vUHmx+rNHX0tXXfNXVTK2eFdSPFXGMQHWMvpsziFW
 MIsh7Sz7ZFkBBC4yWLk8tT//UanuDCWu+tlfRWD3deSYYPPQXXVfNkbORGqfFdA486dG5JH7dj
 6Mu+Cfo4z7epC0F79aBtDrpsbQyAmY85gj5yzTcpxDhLeBAyqeMW9sdccnQqHjmOQCzB/lJUob
 GTo=
X-IronPort-AV: E=Sophos;i="5.82,333,1613404800"; 
   d="scan'208";a="168885855"
Received: from mail-bn7nam10lp2104.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.104])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2021 11:03:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nIiu0+rkwl8E/Vz/OblpdiyYMBye01AHPlw7CNlJ15GnQWhPMZlgdXmK3m0+vuciIsHFfw7nHr/lip5BvgVijZb/iV/9fy6dXoGkOTllty0ah44E5K+zMacLg5roMkyUSMdtl4P+k0etHo8oW4UMxAtrTaU3NyuS9/K4O+2nQ9PYrUAV/3+i0x2zCo13XqdrxAL70u4XnFa2X9OyD0EoEAUl58q/M7rk5Icn1zxmXylXcsRwKRAH0O9LSFh+3y+4loNSikeUcXVUIiveOA6tO/lD1puhDcpBEah2QLLQs8526lCJ6aAYJXyYfv7obNee8qYUWIxsf5PhK7017eq6Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnbVLZBsX43isGSj2qiFxAMNOaS+/cxNFqwWmo6L6qU=;
 b=fpMwD0ebmbUnntAmRFNHAB9UFteas556r1Oq8f4+HwXLsdgGUVhZPFXSF7Aq6zhaKztqq3lS9Ih9oGMHvq7O6TYQ5LFB0+i84psbqIhyUIMS7Q7DGJUN+J5NF8wwla2gFN0f+NIes9cr+RenyyUu9mCgdxEl6++z1oa/xUgG3scm6Z0uQGk8rd8WA2uL445OvyDm1RkUCjsQ7zLU+dgcqjKDDB0XRImK7auXMedDBzEdQ/1jDzf/A8qacOTCEFWmnxm08X1zpqIulN9xAafWM/S8geR4kpqNSvybMmL6tbvYtvBthhURHh+dHiMjtGQzcRyV8zYSySlA6g0IsZIedQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KnbVLZBsX43isGSj2qiFxAMNOaS+/cxNFqwWmo6L6qU=;
 b=Mi7vjK32maiVDsnXW0dYofCWTPimXaR6hSHoCvyU3mYxsYcuRFmATjiNA8E3aNkjWLdXf5mf5kvE7dtI9pKAGX/YeOXDkoCHxYGrKsB1uRmbN7ZzJKcmSvIH3Tlc3aoPk6wnRfilrvU30xHeUD6IfnOHRQnlgy5ARKcvHfPV9O4=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB4137.namprd04.prod.outlook.com (2603:10b6:5:a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Thu, 27 May
 2021 03:03:13 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4173.020; Thu, 27 May 2021
 03:03:13 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <Adam.Manzanares@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 1/9] block/mq-deadline: Add several comments
Thread-Topic: [PATCH 1/9] block/mq-deadline: Add several comments
Thread-Index: AQHXUpPiqj4ksB6/MESgnq4jAyhBqg==
Date:   Thu, 27 May 2021 03:03:13 +0000
Message-ID: <DM6PR04MB70818C808C7B62A1B36CED81E7239@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-2-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0736f56a-869b-4bc7-c6a8-08d920bbf789
x-ms-traffictypediagnostic: DM6PR04MB4137:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB4137098A9B775F8855B81E05E7239@DM6PR04MB4137.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:949;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 64VhRZleVhJT5BxpMBBz+tTCbZKp/MsGxWRpKNyN0ruvt/sLSymoRDUNXQK/4xt5KDcXnFjpfm1rVEifxK5gSLGc9aWkSDyfw5LcEu4v5HrZXcL2UyTnXSQmVBRGiq7MaTFxlTO5RR4TkGe7Wji+2XdUDaGK/E419/SYS/9JEAJ7Sbmq/57+P9MbJ+4QVbQOPRbdwhpWPo1vsxG9RBKTZjY8jV3aZVk8o+jRgio5ZkNq5FslaO/PIUDme4Gwa1bqDfUixFcv6CRqi2gNgiZ25TZZmQXwgjzKofnTwSM/KLp/Iur/8AwIcYd2K9k87X2jTFL0HjECKl/Y/ypKFrotrNs7d/ZBiDyqnHz4A/S3DL64sq7HOOQo9AiGCnTTp5b5zk5Be9CS+OkEySIsxpaAPG4ee71jI3BvKskUx27dzlhWzlbAXsbAsASGtwAQ/DaabSFGh1jMiTVszj3kqeFXj41I7lNE1pubcKOHrMjtXd616z/RnzaIyolkibdYzXKdyWpLnhJmDoivism62JedUgnoZqI4eJFB3xkb3h7Q6ogL/qyt/jspJC2d/IKPViRsoBwiBrSreiN9jTVT1zfnW0jBl1/YOcctfemsXSnqDZY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(366004)(396003)(39860400002)(6506007)(53546011)(66446008)(478600001)(66556008)(26005)(66476007)(76116006)(91956017)(66946007)(55016002)(64756008)(52536014)(110136005)(316002)(54906003)(2906002)(7696005)(33656002)(5660300002)(9686003)(8676002)(558084003)(38100700002)(122000001)(8936002)(86362001)(4326008)(71200400001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?UAdAHjAVfJBSZUZkyPHVtadX+t1Vq71aT+cN6fJoADtjZZQDF4tFEjhHYdRx?=
 =?us-ascii?Q?YVrtZdVedcxtb4nuCcS6ZWUgIc+mVkznAW3XUEVg0hx05tZ+rIXyyKFBbiJV?=
 =?us-ascii?Q?pUr3J26zpmJDgwZgQbuNYMVABGGoLJyyMcMJKyKhz7rbONLXEX9c4oBCiZLR?=
 =?us-ascii?Q?4kaJdLvPBFeMiDFVVRSxzef6p1h+/3jYAQVZVZtadBu5RD6pqJo0j9RcrvFK?=
 =?us-ascii?Q?DO7oy1ocwdv3zUCRwB6fsKTK0XFrfsU3B0JT439NkUa+592DgK2obsQtoNjl?=
 =?us-ascii?Q?xzeWvS75VfkieWbli8fFH5lwCZWlrgXXhbgYnRAFhp/IWhI3RQGRa4S/2NvX?=
 =?us-ascii?Q?BHN8tZRoDyaEmHk4S5NHZgPvWFEtcM3oje1cZtFJG0otkUsyDpUg4rosUtw5?=
 =?us-ascii?Q?m16C0uHxDrdkVDFJUB5jbXTKmfo85kbLTdsxKWlcEL8tLc6jfP9vLIZhXLtB?=
 =?us-ascii?Q?TrVOnFMbi+P73CX9vdZNoLR5fImPqLUCKsWmB+lWyRCjyv+zodhUz54r+yZx?=
 =?us-ascii?Q?YOyvbg4TPNUa5Fa7iF7fpTDApDqEyS1NZVBnWh9Y6s5M/8x4lWwc09PfhWUz?=
 =?us-ascii?Q?j861sbNSpu7tpS8wMdWigKUzlHlcOeclbVIfVtwdLLANKzeguvT+LeXSOQ17?=
 =?us-ascii?Q?wfVfNMOomtbemgr6Dh1k2DI/zKmGzFFhkCk/RsLhBvnF26P0yS4/jvfFMkAv?=
 =?us-ascii?Q?+urTIXnR5QmbrblbXLAGt+d470uMussi7aAVcR26m2NOrwNwDnjLwV+/u/lZ?=
 =?us-ascii?Q?BoFpwxv6LzUxdyDteB+2DsJtd8gKBOSB/YutPPO0cerl9wYGbOx5pNtiai0M?=
 =?us-ascii?Q?qpO3cFJUVIyukIoP39/GSBQM6y6n2g9xxrhAFG7WQVKd4KyyTIDmfo2J4P21?=
 =?us-ascii?Q?PEph8HOxXIrZFMitp9yk3qrkc6IGLoM+dtXQvkavzmIJd05Lb0qtXS1FwlGI?=
 =?us-ascii?Q?pzqsSq0X56w0CYxDptcN7LDaXctSbcKjWCykJOXbm4tQDwEb9hjI9Ws5xjPy?=
 =?us-ascii?Q?DqR9n1GIyXG0BBa/7LtUsCL2ZVMVZkK9LK7P1CO53B/n/1aVJB8iU+iy+3NC?=
 =?us-ascii?Q?RQ92S4k6jLPFm9Ngk2xMtsW/CTUxlb1Zk0ZkXE3d9WVMqT0NOJGteUmVPew8?=
 =?us-ascii?Q?ExoRJwqwilvk3TcAbPgYrlsmpIcdjhkY/y1XyTUMa7wnOp0ghvUmJZgprDbx?=
 =?us-ascii?Q?td4Ct9u6ZH/vS41OQftBqTKI0X6CY6tLhjaraSMHtpwamfgV4iBPhI3WExEa?=
 =?us-ascii?Q?Rpjf0dMP8ylxYSaOW64mA5wNquoGS6i+qXpxfRbNS9v7ptl1wMUUIDqJiHah?=
 =?us-ascii?Q?1DOsPupNlGEuVmJHgFAwHyo6KuDvxEMQa+84AulpA/DW5w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0736f56a-869b-4bc7-c6a8-08d920bbf789
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 03:03:13.1977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RuS1Z59rUCCg19zZ3XAHg7sonaTIbwgflt5RyPh+SxwZh1Kbto0E0PGjiKCSlsimz4XYs6XwNVfmqv8yU027tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4137
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/05/27 10:01, Bart Van Assche wrote:=0A=
> Make the code easier to read by adding more comments.=0A=
> =0A=
> Cc: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> Cc: Christoph Hellwig <hch@lst.de>=0A=
> Cc: Ming Lei <ming.lei@redhat.com>=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
