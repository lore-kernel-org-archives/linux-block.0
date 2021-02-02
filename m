Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B28C4332E
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B083464EDC
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 05:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231627AbhBBFdi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 00:33:38 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:33629 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbhBBFdQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 00:33:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612243995; x=1643779995;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PZ/59lV9LpF9rfOGxKTUln5bF8INrtmaZvfgPIR5Luk=;
  b=fxpCXzskSC+b5eWfyVlU59VYkX/mRc17IuoZ+eyROXTsp0dKaLj/HmRX
   lCQ/yF6pZEOmPsCCeHYaSbLlZIsP9Di2tlXDPvl+Y7hd86zJQdt+9gpH7
   O6TTG6E+XsM8GxQZ5lUAenwMVN+LZ7ObYq+UhIae4Pd5uX60WGTWYpDV1
   pltF9EO3DBnBCdkcGpPmYTxAqUZKd/OVXKXOyIev1ToBIXe+8EKo4DjxR
   ZqIR0HJ0kl5o8SwnGzh+vvRliSXKTSnoZxEyr8zobEK7vmvaSefUKOXII
   fKjJTxwkogvE9Nvkg1IKzrSKHKLMgSjqS4Gqou/N6sTmSgmw7H+oxmirK
   w==;
IronPort-SDR: kpzZP3Mu5OMS5JUKFWvGUqBBaaUmbzlCsPTTCITZfib/3lkKiSaVuPZ7YMF8bQ5TshaITHw8bv
 RE8Yy7ZgJ7hmadGu3kpPjXi1fpx1H25ObdH6joYgu/58koB+ywcdA7AW/eFbgiJKf3zvO4q+0s
 PF3v0143Wl8QNqRbZJVtr1cDbRexy5lxXAkw0P/2XTOb319f1H6+tBqyMiyWbeB2VO57H3Mxwd
 bnBTZmXoBT8/LdLLpyAYEEbCOF5zam4nEe3ov9VNUH0v4QW9noi21xCtbKPPPN/ihtlmEu55xJ
 ENQ=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="269301247"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 13:29:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L+OZk9xh6dWT/smcacxle83VqoEfWzpmzR70HTvF6s/ni3BVqt2nXEz/HtPSLTYxvJzAPFa09sbOaGOLM82I4WBtSvkyk3d+CrNk1FoDmZ0k9+6/qmmt2jLp3JI4KxPPGdelV2uFyyg9LJPxnegJgzL3NXGxzhgnaJjUtwbs/o7gb7n9JLUmEOGHPAhzOqRG2LoY5dhbZGoFltZ4hwRWXjr3JVkO9hyx3KIe0rjdlPSBTUE04DrlYQ5h1YFDr9yDJLjoJb1AfoIpVS8LcuRt/kazep3kca7QZgcapsQVeBSHT8SM5V7+UFiG0KblEdOthvAOXkRAgC1PwPSx3tqvGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZ/59lV9LpF9rfOGxKTUln5bF8INrtmaZvfgPIR5Luk=;
 b=cHpBqCtl8G0+cd1KfTVNerrZms+Gqw/0GvrGoaVediT+pKIuwk2bH3fvk3apQmFUTHIdf0+j/KYEVnIkMawaBDsYwlB4bwk03ihxYMHaD0IG8TZpRgnRPQuFX/+MKh7W9qFRIE5PeGc9Ndj5vja55ULqJT0PePf5pYQmTyO4mUeO5QixeGUdXQwwATck0nUQLpLIdeuxiMVKYsCuG1F2UacLE2HsSbVmCFKCl47IpbPWNWC1wpFQ6OnuXAzNrsit44E/H/VJDxB75Vy5B4m7n389jBvBBGoLfUg7xQoVJ8HT64B9gmWJXXeATDD14sJYreszB0odYgCBN5tkI4zdAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PZ/59lV9LpF9rfOGxKTUln5bF8INrtmaZvfgPIR5Luk=;
 b=l0dSrds5Tn4oMfVmNVKXlLP9aJTeylO1qcj9x2tA+gXpGkqY497ppcjt97+ce1yr4XmzjTHGQjvfQfgDotyGJUlKDXC/fBe8OHhzNPFjVxhNU1QfrBWsK7BmMaNi8q7a1icgkTSZXgeIx6ujqriyvFZy4Z71SbaFmWGVILQPQs8=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5830.namprd04.prod.outlook.com (2603:10b6:a03:106::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.19; Tue, 2 Feb
 2021 05:29:27 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 05:29:26 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "hare@suse.de" <hare@suse.de>, "colyli@suse.de" <colyli@suse.de>,
        "tj@kernel.org" <tj@kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "jack@suse.cz" <jack@suse.cz>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 0/7] blktrace: few clenaup
Thread-Topic: [PATCH 0/7] blktrace: few clenaup
Thread-Index: AQHW+SPgXruOrF0GFUmZJ1DFyhiVNQ==
Date:   Tue, 2 Feb 2021 05:29:26 +0000
Message-ID: <BYAPR04MB49650544EB1213F56AD8766A86B59@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210202052544.4108-1-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2bce9039-1041-4241-369a-08d8c73b81db
x-ms-traffictypediagnostic: BYAPR04MB5830:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5830FB6845957FB8EFBC3BA986B59@BYAPR04MB5830.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XzdQdNeFg6nLC1fCc+YrR8yFhf/I0OZHlF6/MTfX4BquMLq74ioz0mrQw04J0YVuNo9KUrnlvjKgrrAX8IwzM5X8QPtzuzsz7OnhDWoBdreCInWUzVpa1LQ28Jht5zRgRScP5Mn/GRIjKynuXFWuuactdGfQ1jgfbIMewQN2MBsUuu7RO+k707tmkJv6ajZ122PQqtqIkGpF8iosw53SYQgijEuYw8hRARCTnZACGhcgSAHQYn/aR0pzSkCmct2ZDWnUciUS3Rf9MN8h1OQAt2ABtlAv41zRzOWr33QoS64W71nw3PG+qJr9kK13V88y0UcekKaIIexT9gj2+AINTq2eVHvCu5D9BVN/KCMW4L8EXv6gfr4d/eOZBodaiAZqCbbodh2BhlsAcXQjq/MhnGLdNNcZ014K+pSUFnRpjhe2HBIBDSlTvDcl+4m3I3RYglm6kkM9bciZZ0ZXiYDraDGKdd6QOR4DaUAG62LgFLoYfsrs9UePsY0ZIjCKkhgP9pIFCgu8+H70K6eJJhefYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(396003)(376002)(366004)(136003)(316002)(54906003)(9686003)(478600001)(6916009)(558084003)(76116006)(66476007)(66556008)(33656002)(66946007)(66446008)(64756008)(4326008)(2906002)(83380400001)(52536014)(53546011)(7696005)(55016002)(8676002)(26005)(5660300002)(7416002)(8936002)(86362001)(186003)(6506007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?zwJjJZ6/ITZeCTaGQDT7Ja24wJ6v4k0AU1c+f2DQBRuhgtusetg/bELv9bxO?=
 =?us-ascii?Q?aS6cnrjwoXBQdQbq+DYSd/oG38wAqJ+g4ckZp4xyok4XrdqBh3RL9NA2ZNgn?=
 =?us-ascii?Q?PnqqORXU0lddee4RaQDFP3DLioKsA/PU1jRPlVYnmObLp70CySVPqeTrOHHn?=
 =?us-ascii?Q?YpzGRH4UYPUs1NYL8er/5yPlcM/afL8XAi2HRI1ea2yWpA7yCH1DMvmt7fdL?=
 =?us-ascii?Q?YKDJ+eGhhytR8RzYMhh3K1WP0/ji7v6wORNV/KvkI6muzRprhWPj1ix9y64n?=
 =?us-ascii?Q?6pPerTSnE8lCteNazMtVnV/fse9EcZewx6zzdia27Vn3is34e/r2q+lS3+zS?=
 =?us-ascii?Q?C0MswO9h5mkmGr7MFyrVBB1WF7EcEb008cXThH2B9BYG3PiqqpsyGTCv/UNU?=
 =?us-ascii?Q?6mITtqrRUAKDV6BoP7L8qNmQfoc/Ed7D9AHX/m4/aqdkxv1dNxhMGyV0dmGJ?=
 =?us-ascii?Q?ANcjn+tkeVPTDnOdfYmLM29JPt5XSKDjoid/UyjyT/RiaDcOxgN2AGqrtrVM?=
 =?us-ascii?Q?ftSdR6PNQV/+btdk1aD4kaNJMls2B2VL+6cq0+2lF8+onR2pmFDg6gl27e7d?=
 =?us-ascii?Q?uXD0KNr05q8cirUQOS9FLRm5TEjrSp0Ys1Dls/p4WUgHbkPedcUfFzluR29V?=
 =?us-ascii?Q?br+YsdbvFsDj8Chr905SyTGKC9MA54zhDNYMmKJRmHWjO/zJbugV62ypgUEB?=
 =?us-ascii?Q?D2MmVeIDH7vBrFePVuL1XiI8LK/w1Uj5PL34wWmRgVAR1JFqEhUwgwiUP0Ne?=
 =?us-ascii?Q?MbS3YfSXHQtSkKFysjr+bg4U6NDAVD5hdg9qzMpKgjeEC9cm60xoF+lMkwSm?=
 =?us-ascii?Q?/pGyCWAjTL/1WR8FY9UDjSpqhd1AEERHdk1TQycTY1NQicCK0gg4c/8YNvOa?=
 =?us-ascii?Q?D2NpEQ9gwCsneT2eGJUWsDYeogW4b+osSJibwsddRtsZnMFVm+/BzS0OApuT?=
 =?us-ascii?Q?PRr+ttQXAiygnQKP0HA3XzEpkkiBEkWvEY4Ya1f7+6QVv5wIcNp0XlNeYlfN?=
 =?us-ascii?Q?LMt85ZiNlW6piigztdqje0zs9HgQHrFFPr14mZR2y5CX56LrwGgLmY0z+16k?=
 =?us-ascii?Q?rYTwjlsJ4Y1w820dkZn6K+fjdVoLLw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bce9039-1041-4241-369a-08d8c73b81db
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 05:29:26.6771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6KWfebAKk8dsQA+fpE60fM3klovuta12M193LdfMuTLsOXazTneG7tQ8rzWzWPWwexZB8Ly1O250XQkHigIVBDZ7Fn6ofYRjlFAhMItkQ9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5830
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/1/21 21:25, Chaitanya Kulkarni wrote:=0A=
> Hi,=0A=
>=0A=
> These are few cleanups for the block trace.=0A=
>=0A=
> Below is the test log on latest linux-block/for-next.=0A=
>=0A=
> Last two patches are needed to for testing.=0A=
>=0A=
> -ck=0A=
Looks like this series got sent out twice, please ignore the first one.=0A=
