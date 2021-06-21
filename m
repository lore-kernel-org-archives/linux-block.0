Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A28C4743C
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 20:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BE466115B
	for <linux-block@archiver.kernel.org>; Mon, 21 Jun 2021 20:16:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbhFUUSi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Jun 2021 16:18:38 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:31056 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhFUUSh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Jun 2021 16:18:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1624306581; x=1655842581;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Kplc/Ff+NQtC7vi+5MllnU5lAn1d4b5/AUQ6uJ7x2bo=;
  b=AEqmkwz1zCWzh2puZHgoanKwyhYbVCpLCZGdsjB4YsUYdJkn+D0gsced
   bhFrXAQyIf3Goc+fVAqmk1OSiZMAUV9sXSSqBMY3EuzA6HSh4Wukaoij7
   KfsFZ0GEEU10eeZDkiqJ0YUDQkAjyYthC198wXNrfKP2nb0yJ7SLZB3WE
   0oUI/SE+KyEfj0WCwpPgrp+yzKO94NHYlcQz98lGAdyhPB/wfHx7JudcN
   J3XyJefnnGkX7zYWv+T2oBB9HmMm1N31xwTIJuLkfZSgKgmwbzxAR2keg
   SL+hfYT1GTTV2/pYdwpEp9H2ze2PZfXQwRuPtp1SojH/W2w7CfTXSYr0/
   g==;
IronPort-SDR: pP3owMRUhPLj6LS1ZujXVQ+2rlP94ZyaOtw+wYPVw9nLLRls7Ti4FcxntClzEhh6g/nd81dwT1
 gajbycLeeGJ8GGuW5ClG4SPbrJrxd5Cri/lDVUlJmHnYngGS326LzFaf5A6mj+JMtR8yKOgX/Z
 U7NmKx+jg+Qv4uB820nHDmoxka/zqniVzewqFXBPQ5dqKafKpGHjWb2INkQs/VUk7tkAtmUzjZ
 ipm86qRdccVD0ynsaNp7oNHSYoM8CpReevpkqtCqyT+rdMqGOiG745066ze8wjwm/KyBEr/oiK
 yHY=
X-IronPort-AV: E=Sophos;i="5.83,289,1616428800"; 
   d="scan'208";a="172519108"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2021 04:16:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kH4GBNQ1nBKoGKHM3sFbXXzB8hjBRO9REqVKX/ScWfzBWg0xBZ92B6KxRhzmvc8MXAjBvr7Qb/jDuo8ckAMGjcl1UTyBr3DGZXYGqaNuyoiI91dAVyVkYfqmLtjPCEUS0VCwNpQe33hnD34B+DvTrjB3Y6yp47BaYBmTrHDi6h1NNbdG5T/2L1xPakDEKOvXlN4pzEThdLrxuA+plejwrfGBMB9D4zCHIiNym0zWsTJwk4LKI42UfP4FHB+kE6UBgaXoueeJHUXAES/tc85KZYWt/eOxfRu7AeZNr9iW4f/wpgkSU6FJM+vmV4CjuOqmI2zqV6YjU7kKqLNnnySJLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kplc/Ff+NQtC7vi+5MllnU5lAn1d4b5/AUQ6uJ7x2bo=;
 b=P2U1CC5eLYx5fNE9cdEIUNvHLbQOLymQYobhi/HlPZkxJmehe/DyxD81Z+Q9A+8SI5AmErp1MsJ9y7wKhW/VRB2Xm2MrkZ8zQyqrd1m9pTZ6RSZGWnGMCxBaUpfGUi1DRI1xrBGtqUrtyM3a/OUJhzhyQK80zUOEAOn5bFX2a2EicPbfmPoJV1W24HCPksByO2t9uPh3CsU5xS5KTfZSU9GY4prhUkntS7drBmkVU/lGnar5In3Koyk31wbwbYsR4kkV4BmHqzXYr230uHK8j4sButnewqL98vWVFuFNQMPIzNbFD3Pv/DjKDQ00dVgfSV5F1zjZbQl2PoWNRsckwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kplc/Ff+NQtC7vi+5MllnU5lAn1d4b5/AUQ6uJ7x2bo=;
 b=kmCoCmwWBtyuYJZcM2VB3c4oLOuuJcrCRqBip/jmfcXrs+o34EYpcAtjeStmKULb4ZH+y7C/cYh3gZK+lEX6efqL7jRSehDo3rKLWuk5Jfjzt8TOJWyx6bcUd+hO9WXMeaX+53DhTXIn08bOzji9a/zeh6Egf3rGkdyniTErLHw=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7693.namprd04.prod.outlook.com (2603:10b6:a03:32b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.21; Mon, 21 Jun
 2021 20:16:20 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::6873:3d64:8f9f:faf0%7]) with mapi id 15.20.4242.023; Mon, 21 Jun 2021
 20:16:20 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 6/9] loop: move loop_ctl_mutex locking into loop_add
Thread-Topic: [PATCH 6/9] loop: move loop_ctl_mutex locking into loop_add
Thread-Index: AQHXZoj5c3D0ZQRSZUK4UjGuvISO/Q==
Date:   Mon, 21 Jun 2021 20:16:20 +0000
Message-ID: <BYAPR04MB4965D0D42028BD92F4C9406D860A9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210621101547.3764003-1-hch@lst.de>
 <20210621101547.3764003-7-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7192c4d6-2133-43e0-f349-08d934f16f57
x-ms-traffictypediagnostic: SJ0PR04MB7693:
x-microsoft-antispam-prvs: <SJ0PR04MB7693AD0E376A1E143C41D7E4860A9@SJ0PR04MB7693.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bJ++wMgtP2948BBV6o4NEurxYPD2b+wLt6GOyYlJa22f2Gf+Z4aMk+zjxXXH4ER2WpKjTOrjBPxE4hy3PGVpzhyjAY4Cz6BrRzTeULkyRx0fNya8QOmn46DV1r35seeoJ9cUdbpBPBgeST5aqBByIAMx2totXfGjpCA85yNNEokiIvTAxE8HwG0AByV8l9Bw2wN60ZxgSeYW9E6pf+vsklScOz4lIlmFkLSInnhwtZoAV/+mcaw0lCFw0Q3My3QDY6aHmcqiTJlLHDxuWgVWou6k1cF27/M8leAfnFgfk+6w56WaVGkoyLXUxCQ5xXrGGSEznr8OECzTHqIXVRsuk/EkNwzXKR4CJu3g2czLTK0qPWf+vr8j50cz+57prJrcMvE7I8oDYXDd7LbR8Me5FVSKkwOdD+0DZ+7XFSAz627YkDEYNF4pNZeKtp16YWli3Mw+0zLcaYKHn8G74rhJ4SsSbiyXvSIejVbTZ2M+xg/1SHwllA0YZacKHeysC2Yz98cEHkX8AH6gq8SFa348988/XRhUt+c5mXJYbv81V519Aao68LA+7ex7ExndP0UVsfrnQgpXJ+BU4woR4lFctwZ1lMgnWsF/r3wxzunnVHI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(39860400002)(376002)(396003)(33656002)(53546011)(6506007)(5660300002)(478600001)(26005)(186003)(86362001)(54906003)(4326008)(66556008)(64756008)(7696005)(110136005)(66446008)(316002)(66476007)(66946007)(55016002)(558084003)(9686003)(76116006)(8936002)(2906002)(52536014)(8676002)(71200400001)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ot5yBK1ovQxrsQDxHAx71c3SkUrpovtZnCeKeQMdKQSNAXY2t2SwFcbOUs5K?=
 =?us-ascii?Q?EWwmIGEpwC3X8dvP3DGBkK1zlfQAYBjySB+nPUuVXChlO7GwmYrfvUW1z59R?=
 =?us-ascii?Q?EK7mZysF3JbXq9YNUoZab4hKQ1QYx7Gli81UNhpHHLPL8nfjfv5FA8gD7SLZ?=
 =?us-ascii?Q?m0YPVcLZw85Qp164oers+zbTJCNJG4slwvk/MEGEngiYKinVtm5jqebWN3TF?=
 =?us-ascii?Q?Ge5YspPYibOs2kQJ4976O3FcHv5GxyK6ZJHHJ4rpirBIVA1xCIyPO0nFyGRW?=
 =?us-ascii?Q?WeSSco6YUfoEi5EB9llz5ZSYKxnB3eaBK5yGpUKeGnFIltKP497kt/uPyVBo?=
 =?us-ascii?Q?tsQwcIieoRB4zzeDutHxngeK0PeZRUYxGjYmCSqPgvVsXPhJfZB4jP8u6Wdj?=
 =?us-ascii?Q?ev2IU4jj/Bh3tQXyJsdiu79/brF6x2AsJoDULtosoRgg0rIPuzH4WCer3wBE?=
 =?us-ascii?Q?IQDnlhgRmKN1iOZFYKqiAUGtlTMw3WqVmxzvtHYB2US4GNnA1XjofXD1Zcg6?=
 =?us-ascii?Q?RmjOzEPS6GccnPR/1sMFZrw6A2E2KaIvN7M3YxstoiH6eU0HpEvPLpTO/7xa?=
 =?us-ascii?Q?LJyOiof51c0XOPL+dp8K8dbXOpeYEPFG4E0If0baaRsPkrXahEGexUIluYbO?=
 =?us-ascii?Q?mQkf1i4m4juYsY0BhQ/sbQKBrTUHpNIgiALWsYGHF7hlEr2Wunx5fchSCUu+?=
 =?us-ascii?Q?PLuXcPnNeqgt/qSt2Ljj7GwbWqCCLQmE6QXOCS+9cCgGMrmAt7uF0vnNoqWq?=
 =?us-ascii?Q?x/MJLmrb7P1xCguZfHtde1WCBAhiF7q6AxtfsibkgfYEoYcDtCA22rB4+vZu?=
 =?us-ascii?Q?lRHyf+5GkD/nuUtowB2EEyCHnHW/kivPbZEog7X+Ubzm1SHNUXvVOoI3zG4W?=
 =?us-ascii?Q?GSgqTmcGDY3QHjlf3gFBusqCEUJ936QFjqw2CmqMEDTv/AXzn4t7Ni9+wXM3?=
 =?us-ascii?Q?G3veUcv8kTdJ5yRVURVx5gCo7Xl5hh0w+p8KWkCiQS9Vg7KQvYq94DwUNVHD?=
 =?us-ascii?Q?DEW+U3zSwIVZKfkwXiFQ3TM/k0ROupbqYWo7/lXitlN4UpRBpBoIKIRhklQz?=
 =?us-ascii?Q?7R16fb28sT/NXNPEFVIyIwZvpE3q20U3N2/fs/QWmLrpKjL3SO99m83cvJVh?=
 =?us-ascii?Q?gxb0lAciiLEms/3q+LCjB9lnggPqdKh/7IpkAX0HOY4bgPd8Yq3aznwJIjIv?=
 =?us-ascii?Q?6Tg+30nPFa53ZvmyoMim9bj8oZuKcSrEQMXQHN+ezxo7eBi12A6hdVlbUlby?=
 =?us-ascii?Q?8Zqo1mOIZFrZlukpyi7kUFy5WMdRcnV9a32tNYw1prhoaBa87fa0S1bfeIrd?=
 =?us-ascii?Q?Pug2o7ywxvHN8pBzna0hJobx1R7ORtdX+OVl+Be94xNq3w=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7192c4d6-2133-43e0-f349-08d934f16f57
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jun 2021 20:16:20.8284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XpUqAL/dTGGHnepDpMb5pNdgrMHmudRBAmoqI4GzZaxnhEP2KmEeRD9uQGYsGqvvkL8CI1B/71g8EPmfm/+pbeb9j4vXi0QM7wxBlBsyKn8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7693
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/21/21 03:34, Christoph Hellwig wrote:=0A=
> Move acquiring and releasing loop_ctl_mutex from the callers into=0A=
> loop_add.=0A=
>=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
=0A=
