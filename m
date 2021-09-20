Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72763C433F5
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 13:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50052610A3
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 13:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbhITNBk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 09:01:40 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:24617 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhITNBj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 09:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632142812; x=1663678812;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=ZLOoo6qxY6hDWoBHSQkR5rhIpa9sRHv6YdolkvSXd/05moEPcHR5dWpp
   p9K04yc2VPgCHSMiWiLs1zDRsRS7pRWCobZfV7U/YOX0DbTd2nBKHs8Uv
   msyDT2ERUJutuj0z81lhBatxp6bMCBGibOt2/+01vq+CH2fr7fpsZQbA9
   /UAh0D3veTaVhHpOj/6SEzkXWJP+HApiMqz+XJ04U/xbkYhaobVr/pkO8
   YzK0B5aRDctomx1ukX8FGM40Z2XWal456Zssp3ixy0oEW2l/R/ECUZztV
   xj8cUetAMM26URJsfSioYStNx3mDYUFptgxNFDDBrq7nJ8RV7DEw2Kidl
   w==;
X-IronPort-AV: E=Sophos;i="5.85,308,1624291200"; 
   d="scan'208";a="180456475"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
  by ob1.hgst.iphmx.com with ESMTP; 20 Sep 2021 21:00:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yx4c5iOwwJD1ABJpAFGs+Nskq1CMmmCfMqHQqCezsEI0sZP2djM9PD8JthNyxyyJ8YYsHe0npEb+08I2c5MoJJgPlYPOagS2JukHp0HbFW2Tq4oTfGOcaFr7EaFJ4JkH6jP0bhKPvZC9OhkCtsLVHeSDGhXf3k9vxZQau1kl7wV6WXRbfGE8QWsCsFBev5w1Bh1jeoFMV+m7nXjZklhhF9kOIxTLLjUv2cUEzMEMdBGSQ53hryLbQdUEXx1i5qmGW2mTK72P0vPdRHXLfnXinw5ePWXSfVN1Mg2RTvQhqUZvSYuzkgE0CzAo1/PUwXsvquUMvPy3ZF17QDQjNwS+Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=RUGBKtRY8FTopemku2dWvXBehHcq1xCchZcl4qBYcnInlEQ+lWkdLRtydOAhiHPY8wo+HHljw7OKF7CQfYW2NdefyBufQSRTNut4HZAlpT9frVvIflUxP6s9NTtOH7NKK4q4Ic6qP2LtODVb1gCkE6j86uAoATiWStIgZ2KO/QJEjcEIq9Ge3SM4tZ9ZyxhZ5bogqcT7LwKBpXa51L9sOYmeQKUNBm3hUFvgR2eAAwmhTpBGQlaTjqpWBVQOVdwjNjT7neaw7RREwtp7AtrX/WQ5ehXG+WtVkzgVuECPdXuAP5ZdL4iomMukqYVlBak3OkNSkPhzfVCfoQElmThnmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=q6qpi6P9y2Iyhx55bvLp+65K7bZCTLHYRc+uGqyl19luUzVsZlp248zFt0NiRXztB8W9FIq0RCOZ0Gv0CKvSqqzc0kSV/TZgdIzObF8POzQzSpW9ur7c7CqtRF0l/MhfSKj6QahkbbcIxO9u90Tl17hqvaRWzknv9IdkNpTfJKw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7448.namprd04.prod.outlook.com (2603:10b6:510:b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Mon, 20 Sep
 2021 13:00:11 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a%6]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 13:00:11 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 11/17] block: remove the struct blk_queue_ctx forward
 declaration
Thread-Topic: [PATCH 11/17] block: remove the struct blk_queue_ctx forward
 declaration
Thread-Index: AQHXrhzYh7NB7pwcckaVCI8Lpq2JoA==
Date:   Mon, 20 Sep 2021 13:00:10 +0000
Message-ID: <PH0PR04MB7416248A61CDE9B1C4795E669BA09@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210920123328.1399408-1-hch@lst.de>
 <20210920123328.1399408-12-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55461ecb-ab93-4c6d-e44b-08d97c36948b
x-ms-traffictypediagnostic: PH0PR04MB7448:
x-microsoft-antispam-prvs: <PH0PR04MB7448CC112852ACD68D4149689BA09@PH0PR04MB7448.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PbiAYInXk2zfiKvvkSvO6rNhND20yGpUAGwMg8cSW1qbq3isI1olLAeUIPqEmO7X9qqasXWq2H0cjjXrky/sB2cbymL1fR81SujIEISPjzjmfY0Rbf60F1tlhaAtKZ90hA6KQAQxXNk6wGvVfnsJiKfq6FRwD/CLXXINJceB0Oj2RwbOvctIcIlS0WuvfzQyuLOtwicHMeLr+IygrBSXemc9WVIpiLfmd6DPh37JS1U4U1nmQculo9uH01kPvNs9ofPJXwCRRrgKVpApxBqKKi5trb7zRlyDCAMuiFmhgbk7Bu+WSNIUF8nvJcvqcacSAMn/ArLyEt2of6lHNuvlvatz+OA2BnE0czdmnJXMQpsJW1OErGn4iSgkl8PGVsm6ZfpfZM381vhG17ymzDvlJd9Klwl1HsVNFgrqLM6yd6iD07onKrwwtlEaiyEtbrCqBrVCgIJVf56xm7Q6vIUFk5osXuGihznCppwQiizlkFfBxETbLsE/47WUmrl9S4MqZZnt7L+K7iVWUYnMFPC6dzFGGCeeGU3hz0Vlwo3yJCNKusmNFjOwbSUFWWqMDoi5ugt4+lCBU7vIjA5OQxHQbk754Oi3V84p95dQPDbtGMgDb3cf6uFK4D2i01qsmqHjMqHLPrf70hcefuwhGqKgjmCI0V58pLX6DL7GEOaq9U5J+r1duKm54/JwzGUK9l02Y+XoxbdDNY+7rDsmrXGLnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(54906003)(110136005)(52536014)(33656002)(64756008)(9686003)(186003)(19618925003)(5660300002)(91956017)(55016002)(2906002)(7696005)(66556008)(38070700005)(478600001)(8676002)(66946007)(38100700002)(8936002)(316002)(66476007)(6506007)(4326008)(558084003)(4270600006)(71200400001)(76116006)(66446008)(122000001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SGMI8R7z9OT/dlROzHN9KEclTJRUo8Z3eV2vcFRfrEhMp7/PqUDtR2gUIDmf?=
 =?us-ascii?Q?v63x1Au+rzXbOq7g9XWs1WOpogLuQ45zZ9rH5TMIGCDns84g/iOFOjr79zOb?=
 =?us-ascii?Q?anJeycbkCZhAFSxvjamN4yu9PKeYD0xdq1erpZJIDrKOHRQOiDzFh7259JAP?=
 =?us-ascii?Q?Np7nBz/LbvTpKLSEUYEOodGj/kNnrF8ZgVfe3Dzfxa3gDOOyFu5H5S36K2/T?=
 =?us-ascii?Q?wPfUwW5kPlRx3wzA9VSKjzEhi1t2bdpep6lKK5zspXMCbaDR9vyG+FHER3FK?=
 =?us-ascii?Q?QzYEy58NgsguuXqcRRy69ANssM2Jf7RfF3Uy+/E71aj0OpmLw0IusGuWTwkX?=
 =?us-ascii?Q?onrigCOMfk7AN3LF9zT8dwYPPyL07KSXWWOkSDRsW71OrySuLpV4Ps3W4qfP?=
 =?us-ascii?Q?DxSEUgV3FKUttQ24UpCnok4lXGnJxljGyA7P+csYVUZws/Kp2aX6xU4gUhdB?=
 =?us-ascii?Q?rG+n3N5w7r8Kx6+8EaFjJ05DZ7rIQwXAajbx7iP0MehrKhPCeCyWQ+7Am8Ot?=
 =?us-ascii?Q?CuHF9eQNg3GQPaJPI+rNvrPvQoo9fXkzo8YaSRlW1l1S5wEAdk8z7xPMo35U?=
 =?us-ascii?Q?8gpQz6k79CNe1f485n0XI8Z+UHDz7h2Aau+7HTLdVFlJzEM4huRFSl8LdjDM?=
 =?us-ascii?Q?tPTMcxTVlftmljjmvldmCl5z5slkjMv5bbo01yH685bxOUBZ47DJKjDsv4d/?=
 =?us-ascii?Q?FP271aTVzSvxACmCay/JUAG6ZDCZt5GbCslyk188j1WyjFxuma6XT4uA/rSZ?=
 =?us-ascii?Q?dlZPy2ZeUiV+h2w9RTv1fhiLV9hbOwv4tSOax5wF0DBSIeGGci0ZvHGw+lS8?=
 =?us-ascii?Q?iM7n4JorG//zAoudtH3HsrhqJ3uslNGoYAmmpDkm4ekzWptPq9yW13QQzwKV?=
 =?us-ascii?Q?Vmn1S0MKYNJyu5myl0t9Y9F2UXRtF6hMqhIXI7cYtJfGYPUN3xhS+Pb1ABWB?=
 =?us-ascii?Q?2gtzid4x8gllBNlax9xOvUDABwwgavAkGwxCNfURjzII/Ge5trShBUp4j69X?=
 =?us-ascii?Q?jyojHT6EOV3K2hl+aa73lUprJEWncEaVWiCVgxTMSnHZJCZAEtzrmQa83MWR?=
 =?us-ascii?Q?5ixW4ik5xGolRXqnrpzE6GLFGBoIuW9v+CH2NHROn076SjrKtsruAGS9GyKf?=
 =?us-ascii?Q?DDTF8JPI8QML70//Rir2HRKRN0Q9tZ6LxacxNjduETpv9c+axc1C9M9Kp9gb?=
 =?us-ascii?Q?qaakWEogJrvqvtZy1+LtSH7MLXWcqZeF2FLf0Vst0/bvdK3lweUtlts/StKR?=
 =?us-ascii?Q?7iR5Hx//jkNf/XQeZqam0diOv+GeC8XHwiTPPe1dIhn2rl4u5M3wwsT0f0CM?=
 =?us-ascii?Q?i9HCxpIbZNo3tWc0Y/9jyU3Vu9z1U34An1mnjARcOfW7Ym1DDArKnu9sxhTi?=
 =?us-ascii?Q?FzHoUry20o31Jhi/x2q190yUj66zV449wyyCgeoTkFkfF+c8Dg=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55461ecb-ab93-4c6d-e44b-08d97c36948b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2021 13:00:10.9829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4s05xy+Wsz0pzvRjKdyypVZQgkKB5PW9DJ9Ow0R4xhgzZ6jnMqPuYRCHOwUE63VIuW7/OlQhzr3gq+J+YsuRx+Tn3Xqp5hYBqtdhLAlf064=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7448
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
