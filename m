Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A52EC433ED
	for <linux-block@archiver.kernel.org>; Sun, 18 Apr 2021 04:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1798F61352
	for <linux-block@archiver.kernel.org>; Sun, 18 Apr 2021 04:17:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbhDRERd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 18 Apr 2021 00:17:33 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:2354 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhDRERc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Apr 2021 00:17:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618719427; x=1650255427;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=IcJ7QyyTjnMfs1zY3byoGhcpSrzK7W+Uw2YgC4/ja1k=;
  b=jTYj2U9yPZxGEsqN8efDFVvIhKEryKy0xzyV50hO6EjNfqBcAkYg6ROZ
   P2d2TZ/Pbq2iItOLMpQ4dgh5mym4Xk1KwXnBIIRJUcb8+IBthJEM3ycvJ
   B7bk9mexX0rLS4sZVD3qJ5DX0raF2Wu2MGnyuDx1x2UyQMDJc5fY/9mLW
   4M7LgOh3i9Re+1pLRMrU8unJPQjZvlX/55Dih7MIqhp0MNdRgyMAVRZua
   OnKHZgVxFgNbsGjFK1sq68DECqeINoVWHiom2dazH9zZk3/NQO40mBRwa
   rOfIZTpAqEZmyBtahl6rXK9J/Y3uwV/h2L2ukRmjW4ADuzLUA0CvCUozu
   A==;
IronPort-SDR: fQZ88z3tyd++AAOowb/vYCSHndAHflTGqTz3sa3QlzB9eY/pcZ6NkRVQ905uvTAKPZCOkI3LrY
 MqYrNEU42x72mTyZLulUBWsIs83we68LHVkwsp10tgA87EhSUxB2Yizue4ir2r7HYVUzAF3wRU
 KRbdJXqDoKYjBWUfGVQpV31k3Tmjo8B61SKA8HNMQIL3TB+jVOHsELuTWJIZuyuz4lGa70OPm6
 JkWmqLISFN2QEeOc8zeq6Oie7R/UdnvdWNhU2ovfb25McftCSTNILXC9s1AgAGJ8E6LcCRuYuE
 RUw=
X-IronPort-AV: E=Sophos;i="5.82,231,1613404800"; 
   d="scan'208";a="269253507"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2021 12:17:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FuYBTbEy8VvflwGlOotEzYcCqjW+b/32quhSz5i+CSQDFbfH7evT3fI0CrKw6aoIBTke4ys1K9+wv1xr1s1XxFVOX9lbRLpxN76evKE0WZIBARnaTwxqkO2M2hE9ENrFW1DCk+DWU506O5+D6d/jUyUxNiZFLcvE9UJeufXrMuQF2CenFQ/gG6O5dpjgi5vuu7Yuk2eZ3Lv0nCK30Y5pGwIU+llJYR50kX+fs6wZJq8B7c2XrmrhNK7EfogtTOhKjJ43HSdHJJBvB8QlzLY9HyNlUB2ulnzpj0tvWqrgp8d76cHr30ADJcdQTpfardiXW1eqUhJw00LpqeMLaGjB1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcJ7QyyTjnMfs1zY3byoGhcpSrzK7W+Uw2YgC4/ja1k=;
 b=lWNRxtNjCugAIJFwptN9xR1rCiVbh7IWW3Pg5A8q7O173STvFV4mOtPqBGfP9uAL6fIge9uWsIw0VqhnmH3pII+d0f8Q0l0yrgNFFNVWLTLb/1Aq6D+9qDojg+TWlj8c5nyGujGk5CEm5tJuBRO6alPXyo5x1W9QxFoQw8Ga0lkfHrY6SluiGtqPtFDjDAvrXgqbrRjUGU2yPEy2NXfQ18yJ9sTqOJ19wIrXtMX6CO0ufm2bZe2RmogYXJ+oW/uSn3lsdFzsS+Y1rR2qLPwSqIC8aT0To9tsjw1NCAfcyRTQwmyEwzrczNf97d6lLmpXgXrxwTCNorvqhZ2YIXSG3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IcJ7QyyTjnMfs1zY3byoGhcpSrzK7W+Uw2YgC4/ja1k=;
 b=bqOOazOlGps305aJBuyvMO9SukEhjH/UX8bRCpIyU2CT3lfzo7wOGI5vyiIT6QWI5ALYnjUvmn1Pyb5c3jfHyu1xg6PMulDCrFXnFBRzfP/LWecW16BOkTP6ZvGBSvJfHutBrjbVdMti8+EjrAAy8bdjVpbI5FPZJtIp9kpnw8Q=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5432.namprd04.prod.outlook.com (2603:10b6:a03:d0::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Sun, 18 Apr
 2021 04:17:02 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4042.019; Sun, 18 Apr 2021
 04:17:02 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Keith Busch <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Yuanyuan Zhong <yzhong@purestorage.com>
Subject: Re: [PATCH 2/2] nvme: use return value from blk_execute_rq()
Thread-Topic: [PATCH 2/2] nvme: use return value from blk_execute_rq()
Thread-Index: AQHXMuEi2EYT+Eyr1kS9R63Bgvvp9Q==
Date:   Sun, 18 Apr 2021 04:17:02 +0000
Message-ID: <BYAPR04MB4965DCAEDDDB22F3BC37F09B864A9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210416165353.3088547-1-kbusch@kernel.org>
 <20210416165353.3088547-2-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65266de9-643e-488a-1084-08d90220d17c
x-ms-traffictypediagnostic: BYAPR04MB5432:
x-microsoft-antispam-prvs: <BYAPR04MB5432FA25F55FD26710C2EDE8864A9@BYAPR04MB5432.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2803;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rZiAQlgPygUrwMRjICoOLVjuZevPK/WoerNUMV1GeqgaHgFT7QH0td9xHom4Gamd5BII30/qtJeDSFyyAwFlQHNd2Jx7eMqIXiOBaLshlJmXKw8IBEFW6wD01w263gP/jnoOI7CiYdZyEzkSkQbxiR82VeoXy3CwF1cXe3TFiVIyBLTXGXEUG2Qdk8/fZlXKtcbgN5XHw0tdrsakrIkoePJuLt/1tjGGbMsbnwJX17tCseZM5IQrxT06j00D69Nd1dL9yuhGXw1hDb40QbrR26yMvNsAIfiszV8K72v8Y6uGngI+vFzmpOpJmqFm/0e45ROQNgCoCF/ZNjWlzynm/6LZYwdX0gaQruAcGs51uKI0V0IYGTY7HscHj7F41OlwoRMzzPF74jSMLVEUd8Pwm2mmO7R/tuDbAP/GTqC9filn6hFlto9MykFzvKTg3YfzlZZurvzQfMzwKF+sufpVF776LS6Sqe5aXVMRan2CM0AraFlP9l6V4OvsrlIbFSpICv+LroFsEqbHoFWUOL6jq5Eh9X1XropJ4dyFFku97PmLXx1K4IQKT9+lb7Z+fa7zAQDRCHEXQw6pkHioip1FhcnI/cWlthR8G6MRFBXyrLw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(8676002)(4744005)(76116006)(66556008)(66946007)(71200400001)(64756008)(8936002)(4326008)(66476007)(66446008)(26005)(186003)(478600001)(83380400001)(5660300002)(33656002)(9686003)(55016002)(7696005)(110136005)(6506007)(2906002)(316002)(38100700002)(52536014)(86362001)(122000001)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?XlTOizD1wTpj3T9l1LZ6s57lag4m+0gr59YCHDFCDJB6CDobrZX6QHAhCD28?=
 =?us-ascii?Q?y3tO/pr4ceb5DeDbd38ffaDg8y51AYXargd040fXJ/SRVPPWoFQgcjWPTBgJ?=
 =?us-ascii?Q?lpAwcjbP8pAejmgLAit0YiMq1tYebuyPpfwVb+LdmDzePeuNBm+i7v+PnGt2?=
 =?us-ascii?Q?jNpblI4bz+wSsB2MA9/3fHNzSjBhfDV4wfCYLd5PLwAsigJv0JQj38s7Q9Ek?=
 =?us-ascii?Q?XRr5QIp7EZ42Y1MKcOAvUhLffQAYT51BMoqfL3REufDlURHhLFcuRRcC5Jn5?=
 =?us-ascii?Q?XW2MnW67Tf1XVN4CH02JC8Ft81rXbeSqJWsHr+yhmz15DGtwmWaKK3wSegJW?=
 =?us-ascii?Q?G02E0pG2u9CvPQlHjH6WIZUYF5nzkETsRlF9pmrvQJO8ZRLtujKAN7NNdRf8?=
 =?us-ascii?Q?cgTFlFj72QKEik+KT1gzPfq5jozcRjXu/JTBU7GIUaO3NgHm58zje7F4m5iy?=
 =?us-ascii?Q?CmAZUt9cAe9nwLyyCI0G1EPGD/cJz3x7GFGDG+661pAiORGeotsAcPDoFn0h?=
 =?us-ascii?Q?Nds+EyEYWAR5Jkaz8Y016wpqtT5OVafy8GnvUJcKcLhooqkzFm06BzGvUSkw?=
 =?us-ascii?Q?0lUAnYyAyki0jivXIEoCdubLHquJWFYfTGFcX6UZCmCNaHZ3Qv30XepowJEu?=
 =?us-ascii?Q?BgojDO/G0c17CUbwKbx1imtIwvZgBkFBkP4yV8zh+eaC/vO9BuyjvRaQYGWq?=
 =?us-ascii?Q?1c+Jv6oGIqxN5Gbf5TuA7VLhhNFjCiek7Fx9JaQF+pHJqNhNsxEuOQUvIuH3?=
 =?us-ascii?Q?d6lp8F5nuCAWHRx3X4FjB5xuJVrVIzQ68kMFlNTYqXayUbPfYpO7+vZjfpug?=
 =?us-ascii?Q?7E1WOx7dz+Ow/2OFTm1yn1E1/M0y1RTviOkAaAFMyrWVBXuidJ6DLVaX8eah?=
 =?us-ascii?Q?T6nFE/HerVUdQCSQrdRm6t+TURKk5Fe7h0kYpBAiDjrWmmyBw7M0i4HPbBXR?=
 =?us-ascii?Q?Wnzsl3/ILXZI0e/t6RWc/mR1bhHnRqi0+m9NpdlNEidlMqgaQwTCTUuxu0Es?=
 =?us-ascii?Q?AIPddEA2uBSx7kbSEUwJl4IDLZj2SUaHRVs2+KVxuBs1zmdW4S7wB+2cHiG7?=
 =?us-ascii?Q?zlJCH7QFqxluKtsopb7irbMy/2cfMtNtRI3/+BxxAgvfjv0tXFqCEl40n8EZ?=
 =?us-ascii?Q?K8NtLh4ZnRT0uC12HTvwykXNotKiRKGAEK7yFQHB2p9oROk7aP44SxvQ4ftR?=
 =?us-ascii?Q?ANdBqZp085jWaPBhwuuKYe5TLEveri8/1de9USX3c8ciY7QfdVJ90y/G8Wbl?=
 =?us-ascii?Q?6QQr6y72e7mFRZi8YCSaMKBSI1HKlgKokGCTzdaF+wSjx7UiexayvQMkVW0Z?=
 =?us-ascii?Q?75IeuUGGRThlZ3uCH+pbq+XK?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65266de9-643e-488a-1084-08d90220d17c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2021 04:17:02.4884
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Jyv7yEIZtBZUlt2swVe/Pd1vRUskwtuuxKIKm+4prq/nLGGUsMjKHvcERwYnAu9YtA+Pp+LppprqgdZhxXpu4g9AMYLNOg5C69b9AtDdvQQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5432
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/16/21 09:54, Keith Busch wrote:=0A=
> We don't have an nvme status to report if the driver's .queue_rq()=0A=
> returns an error without dispatching the requested nvme command. Use the=
=0A=
> return value from blk_execute_rq() so the caller may know their command=
=0A=
> was not successful.=0A=
>=0A=
> Reported-by: Yuanyuan Zhong <yzhong@purestorage.com>=0A=
> Signed-off-by: Keith Busch <kbusch@kernel.org>=0A=
=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
=0A=
