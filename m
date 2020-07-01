Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA9DC433E0
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 04:38:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8348420747
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 04:38:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="B06wfxNp";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="qyg0qfwe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgGAEih (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 00:38:37 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:18587 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725272AbgGAEig (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jul 2020 00:38:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593578315; x=1625114315;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=cuGEO4fle2UoInyyHlEgXUS389i2IU6a6WmniBX/1QU=;
  b=B06wfxNpDUw4nnw+HXVWPQCxcB5sGgReN/CGULcOtt/yxOseF0TOqe2b
   Xxdlq0Sizl6rHFBtTqRpEyLlfOj/u2i7yCCb6KJlNnowpSVEk56eBr1s9
   A2Wnsp3N7NVQGh73VwFIaksujvMq7/iwWF6CL3EcCROvcWAyhm95yOXC9
   YkoNbe0Hdn5kcE2pS26VYvnQJ7wOTUsTu0Q0NlHof9xRYDiXOSyIiT9yD
   48FLWYcs8ks9s+MohZQjarNVJYzbHBXvpjyfFqbKwN6DywRJiNeJC3TUW
   NOJOxdy129SPsD566YZla5cvlkrSRvWIkZ40KiQeMjBwGhxEswRNXwA73
   Q==;
IronPort-SDR: F8/BEa7lOjs5Hk/g/KKN+hai27PSzZdYe8ZPy05g/b8ZebWDKrh1L14hzveAwsK+iif4gmP1es
 NngwuhoAw6dys2J6UeGzWYCwgjA5XVxbgLmIIPxE5bw3OvbCxzwjk0ZjSd5n4IxGPn/kUxNtl2
 kL11PgEqgrx10kua4KFSIxF/KgzStKI6NEa4n5zuE/4hqlqAO8Kb51yRLNfIFlWQ8/p84uAmtV
 NYz8lMoCPvm/crM/Tr0JrDu/QnrMsO6FCIG7ryyArpEoU2tBkja981Am/Q+MHNcjZwdhoPQ3JU
 NXU=
X-IronPort-AV: E=Sophos;i="5.75,298,1589212800"; 
   d="scan'208";a="141341381"
Received: from mail-bn8nam11lp2176.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.176])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2020 12:38:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ALoyM7czyZGvTP9oV95mFLEyRGz3S8C/HH7i3jUtxRrgymbLMn998VkR/Clemql5VKxVPvu79vMAaUVlochYDIq/ce9a7kVY36MyVvCtS98gVai0agUSbJKWPGHHtmMPQjS2oWgS0+5KDMha3oqyNEjsjATil7hsxkYXh4Ty+Zayk+sv9XZPXezvgMEKLj/u7S7yzrl1TaIWkbkOKzJ0crxdCI79Le2WJVICpc4ILq+BqTJusxFYW9iDtfz2JdZMWFC4QjXBuImA9jRx66SJEqxs6pSyKx3pGirBYNGzkuEMglMDA9wJsOmN3OYNuBKv57H4gBYnwJM/oWWA+Jk0kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuGEO4fle2UoInyyHlEgXUS389i2IU6a6WmniBX/1QU=;
 b=IYLWg9jJp7OHC8O8B2QLXJG/Gwu6X/uwjWVkOiuud4Hlt4j6YKs5E1K2LDrDqe4br48Xf0e2J5lRbaPRnyM5qHmfA8Htlbg74MRvMFsHs6DE6RVHZ0pRT536hTlMrMuivEU+LL/6EoBUoTAjoqopK2oDjprlDgyp43t8g7j9m/80CFJEZuofBT/3HUurHrxEN6liF47vMv7DF02QaOOuH8tqqYSqQqMd8qEj90UTe8zbVrkm2vhElZxGrCYhoO1atA6OwnkLbnOYZn5epKmdpbYWEQ0rIiKC+t3psH02haj/G1QvaMSAR5ngmACoyUgiQKl9MPVlp/xSABhqqyB0sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cuGEO4fle2UoInyyHlEgXUS389i2IU6a6WmniBX/1QU=;
 b=qyg0qfwervc2CSmrH2XbA+mbZDt/WQoEOAmueUB+JQshj3rDYD4Qlx5WxAk9g5BaYIbZbCWvRqDRf62ZeiIOVNcV0XyNEO0ZcH8OP9lVDjjV+f49EJVvxXZNnG0os2FEDZceb7pNDE8ekO9fm7DUkKyHkPiLfJEKG88sSLfnK/k=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB7124.namprd04.prod.outlook.com (2603:10b6:a03:22f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.26; Wed, 1 Jul
 2020 04:38:32 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3131.027; Wed, 1 Jul 2020
 04:38:32 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "jack@suse.czi" <jack@suse.czi>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "fangguoju@gmail.com" <fangguoju@gmail.com>,
        "colyli@suse.de" <colyli@suse.de>
Subject: Re: [PATCH 09/11] block: remove unsed param in blk_fill_rwbs()
Thread-Topic: [PATCH 09/11] block: remove unsed param in blk_fill_rwbs()
Thread-Index: AQHWTm9GGu+q+vMGqEaJRxsHge5g6w==
Date:   Wed, 1 Jul 2020 04:38:31 +0000
Message-ID: <BYAPR04MB49651D1104ED9F0BA2F3F912866C0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200629234314.10509-1-chaitanya.kulkarni@wdc.com>
 <20200629234314.10509-10-chaitanya.kulkarni@wdc.com>
 <20200630051247.GF27033@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 042b2238-f138-4906-8e9c-08d81d789bfe
x-ms-traffictypediagnostic: BY5PR04MB7124:
x-microsoft-antispam-prvs: <BY5PR04MB7124EC51C3C4F074996B003E866C0@BY5PR04MB7124.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1751;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: z2699H2/kJuQjR6AzqgOse0tNXVsx66Le/N4pEePIYl8eMfMKhSuVKMS7SNExMl6vdmKLkXBQnktI88Q4t7g4cxzQ8B0KooV4ltaMpKp+jO+QT4oe2LTXBAUoZsNrAEfZ18PbBoxF4WCfiPQS56Bl7ADXIjjyuo0avboLVUR8rr68s2euTagypMSNrNCoOw3DtR9c8oL/bkFD8jMkFXzxXwfYPCA8Pv0zULlammqHPsywk/46yZznukZ6DYu862PE9E87QzEwQA4epANtlIsGz6sNyzQQEWjGhLBbSLzSDyXiLoBY0n1YGeKsTk+PYoTqu7pA58el9y1rbjdX38YAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(6506007)(8676002)(316002)(53546011)(186003)(4326008)(26005)(6916009)(71200400001)(54906003)(52536014)(558084003)(33656002)(5660300002)(8936002)(76116006)(86362001)(64756008)(66446008)(66556008)(478600001)(66476007)(7416002)(55016002)(7696005)(66946007)(9686003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: X/J9H5Me2UyM70yk/2F1ZGBYrbQs380W/WP1U/TkA11NMeO2+DseW996MhTB344UIuea4lHyTfE51e580S+MJ2QDuawxIj+T/YmB4Gf3/Yiyp3Hz9sDBfr0Qeve7cHojTXrc+peIeDFa4w9kezdmVIXwzket+RslwJkSl3TE4sDTcoQcLYm44SF+Ol6kuqnA/fWQMoerAA2ObEiq88cFdU3npSec8zro11s3rfUEen4YslGqV0OPItiuzCCrzQ2YY0uuwE6TYGf4aRTVGdo5OLH2Xyv2Li6/d15CT88xDhqoC4X5F6KO9nGTd/k1EvOUbeeI46/2nEfCmiVi+csucgLmcEeERMg6e96i06WNp3xqp4PLC03mIzex5r8ZwJhNbXavWGpd6lAqmKyuhOFFwEzoTYr6qDfM+veUqnyRIvNa2eC0IsGqRhThc1zpy6IzxJ58x+QLsk6k4YFhNDgix49WVBuN1mRXHluk8e605zs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 042b2238-f138-4906-8e9c-08d81d789bfe
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 04:38:31.9459
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OiDP2WOPB/xozrWFGXfvTOISvrjLbo8DmxdFG/PJMq1wzI0EAjTRrRDp1F/Xk20HX1s6nqWiQy0n7Hhrmlf4sz0THvD1ProeKDcq6Z1J86c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7124
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/29/20 10:12 PM, Christoph Hellwig wrote:=0A=
>> +extern void blk_fill_rwbs(char *rwbs, unsigned int op);=0A=
> You might want to drop the extern while you're at it.=0A=
> =0A=
=0A=
Good point.=0A=
