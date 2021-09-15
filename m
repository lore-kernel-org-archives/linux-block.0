Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54513C433F5
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 09:15:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B72F61246
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 09:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236974AbhIOJQ2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 05:16:28 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:39480 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhIOJQX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 05:16:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631697304; x=1663233304;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PtETIS9hE1LyDy/AvugR1ahK7SPS8ppi9jK7mY8ZTYw=;
  b=iv+u8RWWbSvy1ylPbqjOUv4/sCuHFyYjTP/k4xgxmWRWQJBOdkkaMcbb
   jXNKtUNt4CzDG75xTky+M/WUOEuDDMcv0KVBqzf9pimCIEB0G9MmuKctP
   aecDuBpQcL+i4PAd0mr9MuQsmtncjEbihKze9rtS3COM8lY0GRrMOl2SI
   bDUpr/HownLrcwLh6uf71PIMMxVyKH7EtXJnXmsZubyTW6cfDUlEIJtZF
   oteHlO0016OZ9z4viCZo41qlkmYqLTi8LX1H7xOJveQ+bFAtL42WoVWMd
   rt+nx0G73BIsPfMOMhVkDxdN4f5TKNxGNI6VBzIcFYJaA8WXrCiwizxfU
   A==;
X-IronPort-AV: E=Sophos;i="5.85,295,1624291200"; 
   d="scan'208";a="179132836"
Received: from mail-dm6nam08lp2045.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.45])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2021 17:15:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lm/GERpJwzM5LPnjQnDMXm09hfO/Pr9nVbcuKHwzUz20z42YsZ6vhPRc3I7zoKM3jlJfg2+AfjEbpwgC6YDYLs+3f0Kf6TQg9tccPFfIKq5FNJ0lg2NW6KpYkdaofMidryjPfONo6/lD46uk9ZNOTjCON8bHoVcOJgS5cu+/Jz93DCbcslZIGou5ujYhCtAZkc3Ea36e7glfHhKT5XM5CP+x/kJe/59D/o/+ureimrSoS2NI1oJJIeL7wDTA9S/Vh4YsU1nKGI0GN1pcx4xBYIvFUL56TO6Kh2wWnl+wEMRZS62TPBhWLR1Q9D2w9sJMpVqRumTBqCzeTqPfoQfvVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=oRlEiUHNxHqotoD40TqW2pS4rnRy7U4QyuyUN3AOJbA=;
 b=dtFVS7u7j9BJdN1o6nNm6sB+HW8//RBnTbvZumbmGheVezVIu3tAK3WrYuXuVhG5cCKgnTFFkqWWKhcZfut2dKAV9TvhtJzLB8WpPCJ6MZMdWvjURdJcjqSTYe1lRUQKywErHbZevrk3aNyU4YMtCOQkBlzZGSsgJUHy74zB8XOZEnKqhEFhtwuHOIlmO+ZhR6ywMLT2druDkDEbo8O8RmTS24yj9h3o20ci55m3ztlwCq6+YhSgZQCWpPOSuSB+cpxUBFe/C1f+uct77Yzke5jjf4k0oulHadBcGIZXFtg5/vu3UFvlbNM/sQevCMCC9PKgoGd4ODqxc6aVZ/StCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRlEiUHNxHqotoD40TqW2pS4rnRy7U4QyuyUN3AOJbA=;
 b=YhDQKzTKQThnp15M/VdsVQFapWrB5owc2TV+4B5xXUuBIyqwTiA9SqxyfLq++Axre6yfJeghmNoU1tu5EVVrplH+yxdjv4xghRiY69OGqAyE5GPfMT7FlCQAILmB0ekd48CBoErC/bOOh781xtk83a+DJoFbl7ZHKVAW5d67SYk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7270.namprd04.prod.outlook.com (2603:10b6:510:19::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 09:15:01 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a%6]) with mapi id 15.20.4523.014; Wed, 15 Sep 2021
 09:15:01 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 15/17] block: move a few merge helpers out of
 <linux/blkdev.h>
Thread-Topic: [PATCH 15/17] block: move a few merge helpers out of
 <linux/blkdev.h>
Thread-Index: AQHXqf6E/Sc21mmP0EOUVbZa6eHIeA==
Date:   Wed, 15 Sep 2021 09:15:01 +0000
Message-ID: <PH0PR04MB7416B9568DB819AA77E4416B9BDB9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210915064044.950534-1-hch@lst.de>
 <20210915064044.950534-16-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5d5898bb-02a2-4247-1565-08d978294c37
x-ms-traffictypediagnostic: PH0PR04MB7270:
x-microsoft-antispam-prvs: <PH0PR04MB72700C651A345B91F477BD8A9BDB9@PH0PR04MB7270.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QTdIf1fqpEbFl3zoQd+1zhwJ/j8kkorzGbGZj70m6yinxHJKhrODyIVYrFhkylRkbp8irEZfcmjm541+nMJTrdjy5fJX2cobyowK9fmX2LZ305oLRGgsAQcbQl2KbD9ga2X5ZAjg32NIbTA/TQJfZBDZ1iwo+wxHR+GJqvuz0tjvTl7orjl3WNoxj2LLuDgFZ+rt70K0RXnVl2y5nir+k+ijUYR/AAeYBMB4LlQlVXr1vhbX3efhDku+7scSBT8QFQKIsVjbWSi+aDaVe9isI+XZG4m8YtcvUnEPCxHcY0r9xL874OMAOyivkrjIW5LqcFYPcmtqgjQSW7vgTMcmfmk4bowgUqATgttKQVfhKhZoH49f6sF95GGclOJxHihFSb6QnHZCMWhwuaTJbbSAq6UTlqB9gJfvfiPuHyk94LN08iV00eG9uniokyna/Agx494HHX63mOoK9MNpB7urPMY3i8ICqr2CuJjKvjGn3GFmhNNcst/x1p5mV2qkA/e3UjUlu03o8SvzxdNqRrkMVu/AccOCQR0XAs+HQpXZ5TvSAC03ADQFPVcJbtZkmWzruzM49xjz6XVtbn8oh8MoEDyVpR/+CouBl8wqWDdao85Kvj7SyfDquMu3RkLfTB+941tMLErFQe2e8+R30R1rmD48dCK68M/AAealMZXeXdpTsZQWTsncPngUS4g+V9PkCrMsscyR0Uanh6Sc9cq7LQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(558084003)(66946007)(66556008)(64756008)(66446008)(71200400001)(83380400001)(2906002)(91956017)(76116006)(66476007)(8936002)(6506007)(38100700002)(7696005)(53546011)(8676002)(33656002)(186003)(122000001)(110136005)(54906003)(9686003)(316002)(55016002)(5660300002)(86362001)(38070700005)(478600001)(52536014)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FrVhwQ+qfkitRiDy7OYdpHsWosaMYCxSBK7oTwW2fAVEyCBHEi4oRI/muptr?=
 =?us-ascii?Q?ybd62+KReGMrjNvnVPqibmdTf3DMIHS9KwtM5OjxWncrbTekscmyL1FTqSbw?=
 =?us-ascii?Q?EUoeK5lV57TNGaZWqtvvapx1g7f5rkoUB4LcNZUQpAPBbnuNq2MGgOZBZlz0?=
 =?us-ascii?Q?iJG1K5Txz2hO03LK5VXbjosDPtK2g7V2nPPQhB5eqjSCj31l/jNYkH7yzFyI?=
 =?us-ascii?Q?PjgDINW6XjuKAcV5KLeybhCEdefCjOuOjej0k943wI4p+9fDOrYN7Ucz6pXQ?=
 =?us-ascii?Q?nVSBxHXOSlfid4t/bPMMhGWCtMuqv+21rbGWX1Pax+B7l/1hagSqv6jmuu+5?=
 =?us-ascii?Q?oJjjZIno6GPNf8VhmYGzEwQ7SvHjND5MvJ/2463QigrVLNrSpanrWfwNbv1U?=
 =?us-ascii?Q?eHmJSvp/Hkyd2tCulele3TAzNih5XXFX/OREbgPxw4nPI9PgpidJF9GetUea?=
 =?us-ascii?Q?OadVzFsWBxomS9KrDf4shAva0Ur14Ys60bnoFdbti1dAr8I79Tlr6qXaZvPX?=
 =?us-ascii?Q?vTmQ6lqttqxZ9fH4BGngDcTDMj/2dDdo23QHekOMmjZOJtOiSCTeYUAaNg7U?=
 =?us-ascii?Q?vPu/wJMwrP4ZU3Ey0GjRIRbeLNmmfGLLKkkvlHPkX1dqv9mD4lVWA9+P/v54?=
 =?us-ascii?Q?koQEoa71WfRtTp5uYuVYD/CtGT9AjDdm1YAbwMzVx4vccLDrRUmvZWXR6ady?=
 =?us-ascii?Q?JYTjAEeTwJ0N/cC7NmYNEUI0hZF7ZC5vcK9M3/+Z/Mgtcvnt3nprd7J6uDD5?=
 =?us-ascii?Q?PRu9TpEGeJiQqpQJkKW6MWQlSZxU7X4R3hTWi/nQubjPjjg8kgGd98XeGmH9?=
 =?us-ascii?Q?OIX9AVKNWVQtarwc+Az8uJCPFAAbWVFUsS7HjyXUTNL+8l/6ZG8asYs1YIHL?=
 =?us-ascii?Q?8LwlC/gisl08BGmsKZRVsIzB9uaRWMsEXwhhGZ6SATPJ9paYpEwbpa0VTSky?=
 =?us-ascii?Q?FDyCWJFMyJDqB4Xm/2pjyJD/a4l7YZQ85lCjO1llqczyWgLtKSFV3aaMIa4v?=
 =?us-ascii?Q?OPUIVm9pUzW7zfGmpC51/bnQKlEHr6mCM6QG1XfnNqQq47UNNKvWxfvbjoMx?=
 =?us-ascii?Q?qpcc4GIbOrl6JdZLaICi1zk72b0/KwPBgbRl1tSJgNrYkjKTWty6hpR9QitI?=
 =?us-ascii?Q?9ny8IKDqlmB9myQUzZr11OHIRJFyjpYOREfpucfibSa9upL7/JHXaPTXhIpL?=
 =?us-ascii?Q?x4mBYDXfz+XyZk1vsLJWSBef/zudpsTOcs1gs7sdK9L4EgonqcweaIDfr+og?=
 =?us-ascii?Q?Diq7zZy+T2thdy1YBvRj9jmAOR3mzbRfgUagtFkIh775qIPXmRtS3vcvam2S?=
 =?us-ascii?Q?xUUOIij9LrNEmZoVuY7cP000lmtPN6VLtCfX8UGKywCFh/BxePzby4LVzarw?=
 =?us-ascii?Q?FqfTQDwbn+DKoI4vqhWu/BJvCJBWABG8OTU15cC4Jln8q5KJaQ=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d5898bb-02a2-4247-1565-08d978294c37
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2021 09:15:01.5972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B75rEkM1M1Pk6Zs3TKWE/1kTEUicKujRZB4zBaOQYKuAkxiYh8Rqa5829+LUu4uQUYU0i/6Vdh3c5TNiwZ0wo2PdJA6FD4UTvHP26jIA500=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7270
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 15/09/2021 08:54, Christoph Hellwig wrote:=0A=
> These are lock-layer internal helper, so move them to block/blk.h and=0A=
   block-layer ~^       helpers ~^=0A=
=0A=
> block/blk-mergec.  Also update a comment a bit to use better grammar.=0A=
block/blk-merge.c=0A=
=0A=
Otherwise looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
