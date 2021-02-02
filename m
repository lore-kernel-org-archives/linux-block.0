Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53CBFC433E9
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 10:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3DB664F5D
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 10:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbhBBKth (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 05:49:37 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:25474 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbhBBKtc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 05:49:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612264045; x=1643800045;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Y+0DIRZ5Mp22I33l90n9dbXAhAaC+qlMBWzrB3uHeYo=;
  b=VHvUJ9timkXmP4ErCL9qWt2xHz93hhZHSXEl5mBFxzKtEkOsJVFUOYTs
   xHhd5Y7qxFFA5lUeW09eOfQc2Q10cU/dmzpY9MCLRzCxevjl3frmejxal
   +KWzX0W0NXb6y0JBtPGgW1kTcpiXb97tB2WQqPjorh9oa8BoHS87RqWgV
   8QuDFA6Xc8UNv/wXDzodPAdGBOfXM3zAbzSJ7s1EbTrzR90zxHGPL4Ps8
   7jgVv9rTeHFj+K87LreDsE/jVsgTNatciP7c8UmxABNQ8qbiGRavMpxCN
   GMBvdTQj01uTd5kg+OtK6stUwbLlsvp0OgDO/NeOp75Tbt9Ao/Pvjsfcd
   g==;
IronPort-SDR: Kf4witEwlHk+GGJGwh0vzr9mq4JRfKTuuMroS06LxfxWDy6HG5zBn8snn8iomCkSXxNOefKU4a
 e5MfTvTfySMjyRSRGQlzMxi2+V0Pwz0CBa4DuLh3fQ0elpUldtwH5J6u3+uDZX0ET/TmJpdRYu
 72Gc9atN7WCcAytb6L/R/wy3TqVhTZJSnEdz2+J1MO0FFIP7ee0r7Evum+6baQ2BXaF4hMBD29
 D6MeqV1p3oYuXNwA3IGfreRMh4TT/YE07tYf+T72DLxybTXR1wJEpF9Zev4/M+Lvny49Ml/3Q6
 MzQ=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="262988860"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 19:05:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkxRrW0MLJe9YpIHX9ybk65RtWLaiVPSbJ0xLnA/wowiuAiHOp9rzwhDxpGQMi4LppA3QhDrYuIEqRw45qI0hu3OGaMrvfvIXDbARdp9o2iqWRjn3rflhDHvu9lzJ7u7D09y7gVuSKnlMAH8/c5gh0kzbYDWmWstIey6jyP2IK/eOx/hZOs3ym3QxVHogasVhjTS76DKs3HCiOHD0bYi+DJx2YOEc9TuOsDruGkxp9E6PwWxyqPq0gb0stV9Y5YSdzXD2ub5c6M0QZ5ybi1xK3FppH7chawtS2EdQoYK/A/X/tsD+Kawacp6Ia/ibxUl5iWzY22uhXLDHSunTklUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+0DIRZ5Mp22I33l90n9dbXAhAaC+qlMBWzrB3uHeYo=;
 b=FX3H6RSn++RRg+eDWwLERfTaCu4pe4nkWhMplbl/zZ0lImhIMm+c2ceAknEFi7AMYaYh1dcEGuYmojc4OBbAKdTWTEkDtlm3QR1hFecAQsLFAXAwTFLM+ahvmhoqwA5+OPzNy+gfb/G5b4Nopry+QFIhjHh1Md3d7klLfbEh1o5LHd0fUh7h+dq6DyHhVcOzgaeL8EpEKuyS/bjRQQ1uRZi0Gk8y8iKk+ALqD9qUKwBwG9z0V/PIk1+Hd2T2fIdBx7uxyA55LQgIR/C3JmE7h4BnVpuJ5PyfzPIVGJCA8rW09wOeA+QlcvFZ/A/LzP15cjxBhf+k9MJdaNnj9+yIDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y+0DIRZ5Mp22I33l90n9dbXAhAaC+qlMBWzrB3uHeYo=;
 b=wAGsZ13vSg1oTLxNzpFhCUlElDv3KDi3lPqxWeGqZpQJazlRYlFP74rJPrbRwYFtY4BTSTV8G0pczN0lx69WLfJHuR01S+9RurGibXvnRMDMOAWw+rvUtIIQz/7gCbALbNe9WEw8JPr0m4WfqFjPGGDPyOo0bKaTZ4WY1Du7qig=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SA2PR04MB7577.namprd04.prod.outlook.com
 (2603:10b6:806:144::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.17; Tue, 2 Feb
 2021 10:48:23 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%7]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 10:48:23 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "danil.kipnis@cloud.ionos.com" <danil.kipnis@cloud.ionos.com>,
        "jinpu.wang@cloud.ionos.com" <jinpu.wang@cloud.ionos.com>
Subject: Re: [PATCH V3 0/3] block: add two statistic tables
Thread-Topic: [PATCH V3 0/3] block: add two statistic tables
Thread-Index: AQHW+RFTSDkOJujhA0eSKVTKq9aWJA==
Date:   Tue, 2 Feb 2021 10:48:22 +0000
Message-ID: <SN4PR0401MB359830835C1F9ECEDF7ECACA9BB59@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20210202031009.11584-1-guoqing.jiang@cloud.ionos.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: cloud.ionos.com; dkim=none (message not signed)
 header.d=none;cloud.ionos.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:7173:b327:67d3:fffc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e4718e1b-ed44-4b55-32e3-08d8c7681004
x-ms-traffictypediagnostic: SA2PR04MB7577:
x-microsoft-antispam-prvs: <SA2PR04MB7577E121264343473958E3159BB59@SA2PR04MB7577.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pLx1wRzyl3j6TGYiVth23Nsp4CGIjNTsig2HoG9LJxuqkQuazKU/Ai3mWyH5RCFXMyFCdM+9bI0euuKcMVag/yckkw/Awi9QfnDZ8EP/Ahj6r01sc+FRx0PmzlHUPpDHEAqFYFB7NSj0V7rh2vrllooobftDLVLr+7PdPVzgU5q65aQMd2B2se2RhAcxXZ7joQWD9POJRlYnNIkG9O3gpQDDVgAVujmfBYx+0Vir2ud6KuFsi9ir/uKj7LjRwZue/C6yHtFVXJmpvnH0lpLD9Ks/pWI0aAz7j87fwLmE5vQYKJ7cc+zZHus9MQFd/nk9IytfZh9OO3wd5qAxurRGZreq/kk1R8E7WlgWzZkI/+jotVlYc4F/Zk3NMXGKTTA+KBOXcYNA8raclmhDKBjQPR5liaTJUecjCtLG8gX4f3vFRYZLG/oB6sfZ548mFOmOqLjATnVyhKH+l/HORu+dkgblTHTKN26kDMP3gfU7XDMnTdM6hRIYyus9oRbDmlSoXhaL5aLJeVW1GGwDMvKYlw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(39850400004)(366004)(136003)(2906002)(4326008)(316002)(110136005)(71200400001)(7696005)(9686003)(55016002)(54906003)(66446008)(91956017)(33656002)(8676002)(64756008)(186003)(66556008)(66476007)(76116006)(6506007)(8936002)(52536014)(66946007)(558084003)(478600001)(86362001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?OUaMxomNJLkwhYTVzahHh7fX57cAOmauNFxDruM5cYqtq0NZaTiia2xtczMv?=
 =?us-ascii?Q?63P7BlsB+yJus5t4YbYGXQl6PO67gNwD+mmdMpaKE3Bk4/FI50jAC+n4ym/X?=
 =?us-ascii?Q?Nawo5Op3SE+DpSOUp7zDUadMxaJ/xDopLph440Aam/B15h8Vse9/4q1zgd1G?=
 =?us-ascii?Q?kUiqW4kiPu//AlbuiygGOXLPW0rBaIBEePDAMwwS/tlna8J0TpotEIxgadjH?=
 =?us-ascii?Q?O1v8cOzEEjBcCN60FkcX+qSO6JfC+O0A1K6LDvZJpHK4CpaDrDKtJMVB32EV?=
 =?us-ascii?Q?Jq05+yrM7FlHxHFp+wIIwZ7JpvqLRoXPuYoVJyiOH37FhvjcWq6mhpNAYhxq?=
 =?us-ascii?Q?ipWLqaVxqgNdnugKZjOtPXl+M2ZJ6+hLtVvDUfx2iaV/RduvE28d/8DX2gYF?=
 =?us-ascii?Q?9zJ6mOgecFf8+uDRIg/DJWhEfwlbTV0PwIQVqIhILVlIVSrTQrcJlWZrZVvd?=
 =?us-ascii?Q?9BA2GhNXVjwxHGJqbtDIMsBL5uNq3LjdKGdr6X/8ZThZfxvFRVbunkJHkgFb?=
 =?us-ascii?Q?GQY8K9juOs7pYUzX6oRNQQdUKiAk37xklNfS1pehFE7If/MpS2821OZXfnou?=
 =?us-ascii?Q?EzeDXMfm/AcDzw2aW1apk0L5mwwwukyAneZUxDFH8tvrVA5Z0fpJwpuLWWle?=
 =?us-ascii?Q?kiiKo3ly9Pjhho72yIXuIy/BdRO61DcJzf7hFnbOoJlY1AM7iW7CFrJcJ+eh?=
 =?us-ascii?Q?X8FUucUX1UjuA4gH41nIDzlhJmYwgAktkaaHUE3nvJ8c0QMXGNEYEtbyOlnp?=
 =?us-ascii?Q?vqrq5VutD/dQOMu+ZYdNs9hkatRk4ixAEFdQPe/11JC4x746HQplmf6wYuON?=
 =?us-ascii?Q?noZScamKHNmucytcVhPqrDZg5tbsz9LP3pNow029Ln6CGfkYJjI++ZnbNuea?=
 =?us-ascii?Q?gwEB6Y1e+v23QKipIELj6kYhFkM1ciExH+6GjWCMD0stx1U+wWVBdNS9XOXy?=
 =?us-ascii?Q?PTtU8IwIiwSjcgpUIRZZQtj4CQyYUAJTKuVkd0n92xxm6dJfxNbio8VHUDD2?=
 =?us-ascii?Q?BU3lXqA05FLXEefI3bY+Ne1uAstRcthEvOaSRhbDsd79f6feAFpWVuCqT+Nc?=
 =?us-ascii?Q?IIlsA69inrdEcg2yKF1mM1aHp9If2/aM2xgz4C2d/JIxLQ8/4k78wJAsPVl7?=
 =?us-ascii?Q?AnDTBkQ/52MhuCfbCuV8DGuP3cXRQV/1+A=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4718e1b-ed44-4b55-32e3-08d8c7681004
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 10:48:22.9473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x3k5AxhWeseP6SJOxrSx7AjnxxczkqljwWHLgLdwRGP0KF1OBcoSPoWrdd8f+BLt4sE2bnJazuSeD2oC2TgVrRw91i6Ds9DBZVk6o5U0CwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7577
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Not a huge fan of the function names, but I don't have a better idea either=
.=0A=
=0A=
For the whole series,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
