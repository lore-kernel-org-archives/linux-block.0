Return-Path: <SRS0=9MH5=U6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91824C0650E
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 15:47:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6734420B7C
	for <linux-block@archiver.kernel.org>; Mon,  1 Jul 2019 15:47:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="n0taDj41";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="sMf/hSiM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfGAPrZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jul 2019 11:47:25 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:53340 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727373AbfGAPrZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jul 2019 11:47:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1561996044; x=1593532044;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PmujmXN5J8l+gdKZINiaPaCJFNYh6eA3yho+0XhmPug=;
  b=n0taDj41bQYQfRZ2BTugBML+ua1YjNls2Bjqr2Mo0MCR7w3KApctpCKR
   IWW+/tjDJjP6sFdOXi7yjJ9rzPltJ0hyYioU1iICla5H2HsBLwon2Zi60
   hllUUDLs1/DGBPdcF0hZIh9C+a7esAoDuFKnXIcWNJV8S99sloUTHTqhH
   6v5gO4F1dbntFGpSooffMtyCNUZl8PjjJKFP0pmJPYgMdtXbUQ6qemyLE
   RwbNbkJk3ZSVvTtlMi/ZCtXaGRKyXMnzKDUFnzBSFt60UhH2BUUa2JruE
   4u0q+KIG0Bfy48e0GmMHy23AnwaLPva/K73e31q7opK1iOIPf/2dLH8Tq
   g==;
X-IronPort-AV: E=Sophos;i="5.63,439,1557158400"; 
   d="scan'208";a="218348074"
Received: from mail-by2nam01lp2055.outbound.protection.outlook.com (HELO NAM01-BY2-obe.outbound.protection.outlook.com) ([104.47.34.55])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2019 23:47:24 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PmujmXN5J8l+gdKZINiaPaCJFNYh6eA3yho+0XhmPug=;
 b=sMf/hSiMIQhZTlo8H/eBzc3qNu+n/hCs5w2SYJTEG4iBRgq9lh78olZvtOvgTarHKZjZukjZVzSloOwERESwRE+oMHBkdHvvSyxgLKHNnyUMiGGIruXl9TayLlebVJ90jnZJNNtO7HXpIjvwp7K10gTjpl7LBH2omSxrW5gypHc=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (20.179.58.26) by
 BYAPR04MB3877.namprd04.prod.outlook.com (52.135.214.152) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Mon, 1 Jul 2019 15:47:22 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fc2b:fcd4:7782:53d6%7]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 15:47:22 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Hannes Reinecke <hare@suse.com>,
        James Smart <james.smart@broadcom.com>,
        Ming Lei <ming.lei@redhat.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Dongli Zhang <dongli.zhang@oracle.com>
Subject: Re: [PATCH] block: Fix a comment in blk_cleanup_queue()
Thread-Topic: [PATCH] block: Fix a comment in blk_cleanup_queue()
Thread-Index: AQHVMCOeEcoVL1h4s0K5AeqLg6pMvw==
Date:   Mon, 1 Jul 2019 15:47:22 +0000
Message-ID: <BYAPR04MB5749CEB88FC148D53698314A86F90@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20190701154230.202921-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.45.63]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 446aa630-98e8-43e7-ee81-08d6fe3b6842
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB3877;
x-ms-traffictypediagnostic: BYAPR04MB3877:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BYAPR04MB3877E473840975D18C45273186F90@BYAPR04MB3877.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1091;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39860400002)(376002)(346002)(366004)(396003)(189003)(199004)(81166006)(81156014)(33656002)(7696005)(74316002)(53546011)(6506007)(8676002)(256004)(71200400001)(7736002)(76176011)(305945005)(6116002)(3846002)(53936002)(8936002)(55016002)(9686003)(6436002)(229853002)(86362001)(102836004)(2906002)(26005)(186003)(6246003)(446003)(558084003)(478600001)(486006)(68736007)(4326008)(476003)(66476007)(66556008)(64756008)(66446008)(71190400001)(66946007)(76116006)(54906003)(110136005)(14454004)(316002)(52536014)(5660300002)(99286004)(72206003)(66066001)(25786009)(73956011)(7416002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB3877;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 3z1rAVt3kPN3Hkl/So1v3ybQ9e0FZDeWcW+88GSxxqKXl+dksg9HCLCUvT8pEYzoSNBStetiEDkzJpcmwkaW98KYCnpPjBrZY4C3PJBuuHMhbbnuRFB8nH+88i3QfUjalhuYXzFIsFeRjWQTrpcFs7wSA0F+amJgyrCJdd9cEGDUQuTcGd9dU+lqTe645SqbWbsm20k7/nmqwAPy69I6MC2L8bYHOJAtYlMbNevApTknojCBG0nU4eWWl856IopnFRMok/W5/ovZBcz0jVImKdvrcVV6yLYnCPC8mCO2DeEi0+7JOVo2Wd2KARhCS6PZ9sGd56lS/NoKNjQKwwiZET4DcHggjcVg3aNsd3ors26MSrSYC9WCY6wh7E4EQaAz8NK+jNioKYcislKaBInIZ5iyPj3qCh7w2X9UiMZTPGk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 446aa630-98e8-43e7-ee81-08d6fe3b6842
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 15:47:22.3727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Chaitanya.Kulkarni@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3877
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 07/01/2019 08:42 AM, Bart Van Assche wrote:=0A=
> * prevent that blk_mq_run_hw_queues() accesses the hardware queues=0A=
=0A=
=0A=
=0A=
