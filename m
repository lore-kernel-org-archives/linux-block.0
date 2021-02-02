Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C65C433DB
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 09:59:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BF8B64F55
	for <linux-block@archiver.kernel.org>; Tue,  2 Feb 2021 09:59:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbhBBJ65 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:58:57 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:22574 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhBBJ6q (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Feb 2021 04:58:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612259925; x=1643795925;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=Fmla66jI+xClHgOWOgOvvjZbnf2BaqRxGEIXOHq425dHql6pVmzhlY/4
   6viprNU1gbc/sZPfXulvGrVSqeupqqNvVM9bsyy1AsalLrAgoefiIquVL
   Jy08EB+9ev8LYEEkw2fiQcM0AQogsef1RQIY4FYM0mYKiph+HIj0J5ivp
   +i7zJkEy/dWoq77LqxgpuySk5aimIiNbWJ8ei/UWoqNQUqJloquuWDw4R
   gbwHOn2EtD/v6/dMLrw47l4p5aqFdRwDfLqlnOrtnkHrDC+tkmpSd2e+e
   MH6bUJJtRl+tUKkyiFUcrZ7dATiScs92SHfB/x2IsDpWspKHCtUVg9sMU
   g==;
IronPort-SDR: Df45tE/24qjxizHdoHHCHucVr14StYsoM3WSDEMVCj6P7l4b8RcUibViB0JS3fnU/NSl33aBeK
 jqHuBfoFTx5Wo1MBDojUQQMSrLYf3t07eVk56Os0+Wjm5FB6NqkrvbITT24F9aN0lAEJAEVSzE
 82X2CuYzxAE/jh4nDQuPy6nhMYoy4V8rLlICa5FRCJiwgG+lvO0+l/G970IRyJXdNoOAtZD5BC
 MbnW1HY3gco+FLRgM2pcCrNzprjlRqVjRARzPr5Skwexcse7JgytkjNKD89UWn9F/Uf5rwssNS
 FJw=
X-IronPort-AV: E=Sophos;i="5.79,394,1602518400"; 
   d="scan'208";a="163354509"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 02 Feb 2021 17:57:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TNX/z5xNnYnDd8+E2H+A6iqVaVDYnghNxo2ymCqp8m2iWvPI4H4ewbhZTOeSktgm0qt+8fa7Cu1RuHqf4CIWaTUimPHYMqMO1YYeeIubju2neyk9zQkZeT362CpxyHkAd5v4CJpV6ZwEG8WBIWTm6h5sJ0FvhkIilALY+2UhXL0l1r07d2UeQ7ot7+RWyEdeZBa0RRgQjlNGnj9jK8zg9mgQ1E3hwpou+l9aTcsEhFcQIQf+qanTgQpynDbL403M0KoEDOITTfaxjKjwazL8GN+A+C96E+G6wmmphtWj4PvR0ABE6OfbCIZoBfn5ulaEV/HRXU9vvHVD38GCDEZAjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=lRb+exBbtmVLOp7wpfaAIvAB5y37leEaG0ntFLw6BOzYMsXqLA+il7fK76HRYMy6IENn5zh/ODNU3+IE60cGrA4eeozotskAMQsaFqzEUGhHh75DYDSoG1UkS80lqNwe+KUui+wIMAwaXeAnSkg7Ocjao1sPlTQlXulOGdOEvKLcoueRzCVjePWz76bN47aRMcXhFukxMgFGALiiNHFquZS0H7FB4+4Si7oRis8sybfYs0U4qAC/L2qhksrInx1W4e/2JVhNg8cYWPPJTRu9PKRFCBd9BPXey5TpdWjJLAI2bcnNQ2y+5IwY1EgNQ7B4jbgLsL00qSTCS9vYXqLe5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=L736CYa4bMi+IYa5WNUGqLtBEFzqNvJTwnrkqrh9bYIqzJZO84mqwu08OA96kIsF+t4Qp6toO+LO9SzT5rEym8jWtJqspCRdZBrTCzg0KXicpl3Eg39czoFTCE5FZG4XNsvzWzfdi4kKspEVAjTVmPMV/Dcd7EM+T+u4v9VYqks=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3679.namprd04.prod.outlook.com
 (2603:10b6:803:46::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.22; Tue, 2 Feb
 2021 09:57:31 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%7]) with mapi id 15.20.3805.024; Tue, 2 Feb 2021
 09:57:31 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
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
Subject: Re: [PATCH 4/7] blktrace: fix blk_rq_merge documentation
Thread-Topic: [PATCH 4/7] blktrace: fix blk_rq_merge documentation
Thread-Index: AQHW+SP3Kl8hNcF77k6o341WuWWHzw==
Date:   Tue, 2 Feb 2021 09:57:30 +0000
Message-ID: <SN4PR0401MB3598BAD92530A628EED041B69BB59@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20210202052544.4108-1-chaitanya.kulkarni@wdc.com>
 <20210202052544.4108-5-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:7173:b327:67d3:fffc]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d70edd8c-bdfe-443b-5b87-08d8c760f4cf
x-ms-traffictypediagnostic: SN4PR0401MB3679:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB367941D93CA15999F4AA855D9BB59@SN4PR0401MB3679.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CGjqwDFfWJ09kJsEz//1NNnfC6HoP2x8GPJ1Fpzc4F/7zUmtytna+HdWfWzdGF5Gx/mRjBQGk3zlCaMXSyj1mIQjzZj2kYMdKa80wFH3YuAnwLO/+7MxGP6ELwvbOhq1zKeo4mdVpJQcWKUJT49eITPWRnmo8T/xYExpqca+2kDgEvSetqxzDbXm9n6cKLx4YpR3juwxSzzr1cD+WVAP9U33jfoWJfwHjJqhAKkhR0nV4KmyzOnpeTJnG/x8mEXkuFluWuPPfzQ1QlamePmHk9V1KCg6nqKY6E818uyr3eJ+4p65M7nlaSIuo0aVquDdQurTnDhJfMXSgYf/M8SqEWIYVo6DPNlVyPta9Fgamae/mUr5abO7EYPHemxEeP4TtKH7UcM9HXsxvv2aLg5h0fyzTGqLOwUXwXPdqPREwAOkpKkGFjJc4kHhUukm6p7i2weevDaEm2tmPNfYvFZG4iQcd85xA3hO+8wZJBZz2b3xas5wYFi4V6pKtD12jDNlNvzMT5E3s6+W/lDaQFsIbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(376002)(136003)(39850400004)(4270600006)(4326008)(66446008)(7696005)(66476007)(71200400001)(8676002)(19618925003)(66946007)(64756008)(2906002)(54906003)(110136005)(33656002)(9686003)(52536014)(558084003)(316002)(76116006)(55016002)(8936002)(86362001)(6506007)(91956017)(186003)(7416002)(66556008)(5660300002)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ul7XY2g8MC624nJ8gJs/qxidxt/7hRZQAC7/0W8sJPqmqObvtEmJ1qczeF3A?=
 =?us-ascii?Q?7BP+wbbFEBrFSNksIzMKXqvWTGyvrfPim75yyt2bIGlhm2mYCCiCEqVShfD8?=
 =?us-ascii?Q?LflEQTonYEyrebruMVlyHuyhMp3wqccNq4sCIArWaCesUmuI2VJYGafqnV2L?=
 =?us-ascii?Q?gxy/SkPUk6GFfekYbbt897h4bXVALo3Sr0RBq+RhM8B019BwqsG3UtRbyaD3?=
 =?us-ascii?Q?qJ4MEu8ShyXeOkSrgFvU/u+/m2Y8wkphVsbDOy9FmAEu49hMpb23Gxpx5Rvm?=
 =?us-ascii?Q?a0SzLLN4cp9HqI3DOeziwOD7cJEbKAFfNQ9gA+WwSwg3kn/EPOj90F3zxm3f?=
 =?us-ascii?Q?Vik+OaFD7qqoMAT8kgvzgSKs1tkOcWx1m6SsvLHQ4PecLKZ600+9eNPGvZlv?=
 =?us-ascii?Q?XF2OoRQ0Wz5q2Wbz64ZyyxKh2cSx5rcXUhXdSj2rfYxtVEgTeTiOB8Wvg6il?=
 =?us-ascii?Q?LvgabvhirtfvAvLx0SEgiFzTVg97yDg1eKcfBdLrr7hq3lEL5ktNpUzRLc4A?=
 =?us-ascii?Q?1qzjqiDYoSdcE3CRk2bAFhUOx29h0/42i/FVWwsOCTyQJFipk7XyTLAeHMO9?=
 =?us-ascii?Q?PSkPl5A18BMBpRtYYPdJg7P01phsxuIGXHJOUZY6wNs0hfZuOkCypYbkMk1B?=
 =?us-ascii?Q?/Q3wRzNPpPZA4IoJCIcwVqMu7c2PiE3UdA+a4kTRi7vQDHfnI5gDctS9j98I?=
 =?us-ascii?Q?UjarGLfcSJ5KKmb1kbfwecn6l89PuIOw62WrPI+nEcCAyh5OBoPJnuANqaxs?=
 =?us-ascii?Q?orNTgEvz0L+QwSi6NihGaFdDLAVBKQrqZtU8kPbRpV3CBt0RIt79hFcYn38X?=
 =?us-ascii?Q?I+a/K2lWmJE0t0XAbfN/EcqqZVZydvC8mFqo7bD6ssueE7p3If1Q6jARiFOQ?=
 =?us-ascii?Q?bRaMdvNLl79l5+MNxQTl4hYJvZXzqhKuu1u0IWZrhutmuwfr05rSGAadacFs?=
 =?us-ascii?Q?wOkjTAzHPYuFZ9ssxgsCndyoGJODCPbhQ1Gu13yDNfL5907NVXB1VUjisJ7H?=
 =?us-ascii?Q?/2Zgn1r1ZgkfuOKwHepzQTax3nWeqVK88w5XArf2Mt1C4UN4G300ciKV0fT3?=
 =?us-ascii?Q?6quUbpkWtkvYT/RCrxjB8uVWNKaaplMGCRLAD4RkVGyumjiD53gFBKZ4aMKm?=
 =?us-ascii?Q?6Q3tQ0hn1yCdQJvF1OVgS4aom7rJrmPpyQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d70edd8c-bdfe-443b-5b87-08d8c760f4cf
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2021 09:57:30.9593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JWHuvMwNXNXXeQ8TQR9OVbsjQeqfTCucrDbUwIk849AYuduHCTeMKV16YGWYAyu6mCZTkWVC3zw1qnw6OB6Av+74WTUdFiygMD8MK61xEgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3679
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
