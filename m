Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFA8C433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Apr 2022 14:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345831AbiDSODp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Apr 2022 10:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231682AbiDSODl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Apr 2022 10:03:41 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354C213CC8
        for <linux-block@vger.kernel.org>; Tue, 19 Apr 2022 07:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650376858; x=1681912858;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ApxL9oRICkNfx9q0Lu9tCdeWk8rcv65n6cvcXvzEl2k=;
  b=Q9kCKIggWpnORHWZSP5A4IIi6odQkTvh8bC/F261/EjPfu8IBl6ilX/u
   1xBPdHKeonHoYmBXI55VcDoojgQQpwE0dLOMOmc4w3IKQmVwsmybPGPWJ
   F7rSOC8tueX3ypboslsyOtG23WyJPbvXSNA/xpTkLz06Suu58/4Q4qZPa
   yf5H3JJOrJYFVMWpgiIRe+Bq7nKQ0UyvSA2UZmjv1wIaVIX4F7UfQEje+
   VF4foPpO9Yat2oOz86lKAeu5HjoALRpQVLo6Rr8eYPoGSNpEvNdEY68TD
   czTcoRro5v2/xtX+n6y9Kyguh0wQzAJ4oGXbrPpQrmUplkg01KfdKNQbr
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,272,1643644800"; 
   d="scan'208";a="310238176"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 19 Apr 2022 22:00:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6nBrMIwDnD96kcrffjCuQMKyYhWD+cxvHe0UBw+RLAO0qBkWoDdb3qKVK+E+83OM0QGyHyiQooAD8ypkHcnEFTheA9afw6sJsBg742mEJam7Ep9pzrtRo4tNLqaOaATsUDypQ6LLFaaQxfBPtVQHwYxcpcLaEmFLdac+xQDbJcmVS70vsUiqYMiFNheBpEP7vk66aRwxUPBVT4TPfwaUmv9aDYdQggZq+HMafLZhZKXLsJ/UiJVMmCTPKcj8166Z3NAtkujC3d8ZqYu+ivvhg0ee9bnlLBedSnijZMjXlhr/mMwrjmUCzG83B1f3NkvrGA7nSDSc3oEaGDTcDVc2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ApxL9oRICkNfx9q0Lu9tCdeWk8rcv65n6cvcXvzEl2k=;
 b=cgXhHwRAuJ5X59XKmiN3/tbXjdsmWu96X6DrokXaoz1ykg480R0TJwYUWNyaGoi7fwo8q+PIe+PBRLdqqj+Ds07bWO/rxCWRRuR0P3yrj+FhS+sS60VreTP7bKzEZtVQwikHavzP6ngktZQLLEd115osHx5vbekxdpya9XfMl0iGctwgd7jPWdyoVeTXvTzhr28Ta/jlnCqLLl5hxHuyTHQVig57M+v6S6QiEaXMlbKJIKuvXfVQq1dCPDZVh7Tw+CdWzLjvPxb7m2E3ztEuT+7zkoHSfiSxNW0k+g7N6PatNiSlU44Y/zdBav9idl7OjulIeS3vOYKFs+2k28vPSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ApxL9oRICkNfx9q0Lu9tCdeWk8rcv65n6cvcXvzEl2k=;
 b=TBn7pDh/ckXwDhpBGCun2OOOTHt/wDlrw2MD6H+oAqyOJxsKnN+cKJtn2GBEAKlqcuGR7/nZPW6XckXDKpHIYdZbo+gU2ouKSwEEcFKvkL2O3EXwhaoSHx5jXkb0jHGGYp4Bi7ZyQs4MW+tsnChEkmH0qx4zPRRLLQQXWsLqqps=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB8387.namprd04.prod.outlook.com (2603:10b6:510:f2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 14:00:56 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::6cfd:b252:c66e:9e12%3]) with mapi id 15.20.5164.026; Tue, 19 Apr 2022
 14:00:56 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 3/4] block: null_blk: Cleanup messages
Thread-Topic: [PATCH 3/4] block: null_blk: Cleanup messages
Thread-Index: AQHYU9y/kclrinLRx0aVG1qPzbpQ0w==
Date:   Tue, 19 Apr 2022 14:00:55 +0000
Message-ID: <PH0PR04MB741614BBD55F620C78FC47C29BF29@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220419110038.3728406-1-damien.lemoal@opensource.wdc.com>
 <20220419110038.3728406-4-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57973c2e-065c-428e-cbbd-08da220d0638
x-ms-traffictypediagnostic: PH0PR04MB8387:EE_
x-microsoft-antispam-prvs: <PH0PR04MB8387983AD91C42D59FCC1DCD9BF29@PH0PR04MB8387.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LIP1deXi0x1oHdWDZnzb47p/ZA1cH+WyTemWZ7XbL9sKw7gfLj1GtBO2R+8k71UwkoiTTRsF3LjP+/MCM+xOqBGMuVsIcPFrqbZRUh/LZOdcFTSZqvCGAfp5JpMDZrqVfRXYMllVzSAb+Hta74PKkGcbz9tf3FqCG8Nwn00nr6zJqlTnWh5Q9tvCHZ0c0J0QHI+jFl2iSc4/tAFkb73Ot7LNYZvRAnU4N26ltP7bZ5w9mFNkq0IrFW+8y4x7wC2H0HnEB2A8ZajI6vUt8S0aevg7FgrdrpG1u/q/2SsRf19RKAC8iZykEFbBNHLSEGG/9FE/y2JDx+RJWjo9aiXfrpNnC8Ui/ZjqB6j+2YNqMOf5i8ePRkywD4I+SQORds+owNjxAS4oviMB2iKot0L78DLtQ39ti600MLuaHqC55/H2Z63d52B3XbYd8CPrBbob4K+J9tT8mJ8wh8bxne4fh4lA3GmM0HSKo+F/BjWsIa8Qyy79LpyhJ6KexdapTcqsgdOAu+FU3wEXA+qxG1uxSXV94Zm99zj7lJFlDro3YfWUVk1aeD1nwJVMnDQMJ/abRvmIz7i3ELQ4vkAtRm/n2x56whzY9D4ijox8lFKaMIKI0WAtepHPJS9DaM98Jwxmj73ZqEocNLorBfMyKQModrtdiVfj3CamCpIatmJOoQ+fVNol8tUenWe7pUyBrFVkWWT1peJuC3VYuK7DXpNJbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(5660300002)(52536014)(76116006)(110136005)(186003)(9686003)(86362001)(91956017)(38100700002)(66946007)(66446008)(66476007)(8676002)(64756008)(4326008)(122000001)(66556008)(82960400001)(6506007)(508600001)(7696005)(8936002)(558084003)(316002)(71200400001)(2906002)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5iJaJ3LMMGzAk9VLShwZPS0aZ3z9oh5AuIE1t0wptct+AcJg9HXR57dF4Afv?=
 =?us-ascii?Q?kdPNLt7pxUBpBNaV0Nk0KUgg9080BJB8Q4xk00OqLwrWFHgZIuaruFaWDo2K?=
 =?us-ascii?Q?sbFQIasaTl4EyJl9f+nF8Bk4yDm2jv1ODNmz5tC/krRJybJS6VbsHvrBfkTs?=
 =?us-ascii?Q?dqYX4LA6SVeCAZmSw2Cx7OKtL4cog/crgu63zT/6LLKrAiXtaRfS0Y60C/1v?=
 =?us-ascii?Q?SdZPiJCbJu5M2WlBhTi6xronOZ48LGRGy5NhOaCDFlObO1zqfV7fZ6r/0LIB?=
 =?us-ascii?Q?ssSmKHddekJQ0BupuolUZEyrqGTaSUD/7X8C+38xPfK0ll3oCX8J/X9hXbxJ?=
 =?us-ascii?Q?4XWpX38gA+BWT6/ykOvrPWAuECMd+wQtcO+aA6AafDoskQbx6ked7OpV9mJ9?=
 =?us-ascii?Q?jI2O3rLTbQ+fhpTylEzgtRGYrhTfspTi1WZu9TJtSRzKRMt+icseTx/76UIJ?=
 =?us-ascii?Q?avHaZXimLiAbleD6+4QjJ4RSYVf8lpVTxIyuTvw0UlqYRdXoGtWjp53pefoX?=
 =?us-ascii?Q?6cmLh7mGGxozE+fFZZZx9Kxa/fxcrtL3LwOWxhxIjuw0DXfVW7SwaysDSPPe?=
 =?us-ascii?Q?oKi43tMu+yZVgfTcW+uz1292RrkW8I2MCZw/6qrMzgnv9xXB97hSvprdyQYY?=
 =?us-ascii?Q?anmpdRnOMLVXQIYakUtasYqfgq941fxBTdaqEeDy2Q7f8GarlIyFdE3MScET?=
 =?us-ascii?Q?dRVUjVYgYjDGe/uiYpYeC6ZrJqV2i7PGdEH+SLRjMv1fWf1yCEc8EJvjmBoO?=
 =?us-ascii?Q?Jw6gYHzPhMG/FqPyrJiXH6TwyJwLZO0/oxFmIagz4cmX3mWgmJ5vuNFcZ7vM?=
 =?us-ascii?Q?389IQNGL9flmGeIgL+6yt4w0JPTbFssQMndIQUTcMRDFLQz9EYzhrhKym4Zw?=
 =?us-ascii?Q?GqJceQLstA8mrfSK4Dlb1Q7puzEnZSvlzml8dABSQO1YBXY3BoMIPQrLcHw/?=
 =?us-ascii?Q?hvR8RL9MaBsMFFwXP7Ty7mrMDPofJqE21LePPCHlvDN4a2X/qmqskaLizfha?=
 =?us-ascii?Q?Lz1xJMlA4Hk+7J4pAXS+BWfBF4vf5IgPNpNacZPk/0HsrheSh33yLu0H3dnZ?=
 =?us-ascii?Q?VU2zbuq4ZdsWJam7zQBq6R2G6h5McN3GgxT4pFGwgD/AEankaT2Ps958WV6Z?=
 =?us-ascii?Q?SLrXHMjwkzRGhNJKcqB2jnH02eWEe2rCQp01TzTIkzDOn/KTnDNVlTFXkiF1?=
 =?us-ascii?Q?nIM5wxR6eFehdZcviqV2vjK6LUTYSd/zf00FmRxhoflKal++PF9vhTa14AKn?=
 =?us-ascii?Q?NN2yqCghhRI9lP12BvxRAnD7qX7LqDKhI1g/hNI+l+eeVMf5mPf+MkFpQ2as?=
 =?us-ascii?Q?sien2K0U/DKxx1ShpKF9O54xZDzC+XO3ksz8RymbTXEuVMq+XkUsEUqSzxEJ?=
 =?us-ascii?Q?iuzPwPLJfSJ+Gj8hJQtwCgGwhv6cFM9WmIm+N2mFb/wZKkZhKLHTdGy1AaP9?=
 =?us-ascii?Q?Nn30X4uDV1byVKX2f7WJp7AcBs4zVxpMhXUd2FyLHMIxfgP5Ox8AQiVXz2jR?=
 =?us-ascii?Q?SyPCLQpyitGssfUlnSh6JJVLRYgm6qwmenKDRgFQKIt8HzsnflC3PO53WvVK?=
 =?us-ascii?Q?3eYKsSIzrNor5mYWIFJsYERPZjDV1eMQ0HANs1FDa6uK7tb+H2AZDsvTLsVY?=
 =?us-ascii?Q?2nF8WeyFrc7gVQUGznez4PeqynDE5RPkHL5j6s7D2H2c9WLkIl5KClasHw76?=
 =?us-ascii?Q?xyFLsdbUQswTKlkerGvsuTOlWutc3r8NJqYlBzK3XvywYzfAWi/MD5MFtcwc?=
 =?us-ascii?Q?ryt/og+1RusXox/mE/EZxXb/b3+6EYD0FBzqgC4jiBM2e7jObiGSu2zylykJ?=
x-ms-exchange-antispam-messagedata-1: pnZclV3TgXcJEv8F9FekBXe/bzkxMtMs9Hg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57973c2e-065c-428e-cbbd-08da220d0638
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 14:00:55.9245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rMvX41VI4hK8c+R+YKqmW2toMlJ8LsMAfjoxmDKu5C7SCpE5Mprjag68aqN3+OY9yGftWTbiy5u/FTNYj1qJ2zyVgjVnZBnHHJcGwk21dI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8387
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Shouldn't that be done using=0A=
=0A=
#define pr_fmt(fmt) "null_blk: " fmt=0A=
