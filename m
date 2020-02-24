Return-Path: <SRS0=9TSA=4M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63D73C11D2F
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 10:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2122080D
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 10:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NkHhz2v3";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="J8+eGeIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbgBXK6H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Feb 2020 05:58:07 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:12699 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbgBXK6H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Feb 2020 05:58:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1582541886; x=1614077886;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=RkmyvFhAtwkLjFeAZNJ07PNEgr89RStpanwayKT8mb8=;
  b=NkHhz2v3wmD8hFFdYvppJzHVK1cs8m0IbROh4bvdxKwC1lNqln3IBlza
   5Yw2pJKeuUGFTck3Ngw92HoIbcoN6uosRVxalGTQm9kfIisfST7MvY1/V
   lSyxSHo03RCFFmJDTtP4BCzShET9ktU8n3P2vYZw6qmWEk177yKnxgU88
   /j/jSdmVX9MFvn3pqWGGsx7dx/VriNpyaRuLCj/PZEm9IV4rpcA/+nVsv
   4kH/p5t5cX3o8qc1vAwG7h9m5WbDvsGBQl97ZUqp2oLuBSA9rBBngdOmk
   4QPMVc5zjPYUpHkwSHn5gIWTnWJEvBVDcY2/k/10Cw87x+3xk99SDdjNl
   g==;
IronPort-SDR: oYCUmp+hrCih1XmxbzQTB2Bf0Oyn4BHltibxJfVqVzvIVesr5n+orOiaxMlrUH0wJF3pMcbksS
 QB+E8Lp5BqlcefiQuW0esnvakKXh426ZRKESKxnNvXens9OIzyAKxVdGJowVB84Wi/8D/iGQ7L
 Hzqc+vH+2d0MLl4WOvgB5en1cM2ownc0tMwXI+YtZc+WyGFcc0SvVMkFXIqNPj6OWEEE7TrbXN
 PnCkTjCTIHnr4dTJOSMPLbGkCWuzQhTHvaib5H27neNC10vdPZeYVUY41JTRCEQDbYm8dn0bT1
 KI8=
X-IronPort-AV: E=Sophos;i="5.70,479,1574092800"; 
   d="scan'208";a="238708776"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 24 Feb 2020 18:58:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FiLvRc1QqhuaWLumoDJv6zLtQvjIbAVZ9CIECs8z1UXnsTqSSht/cAfydGp17q/LM4985Fo/SQSXMFh5fFG+rfjoDxXX4md/2cHF8tPxtbyhWdpeIQ347ruqKOt95887/l+WsblBDMiW20+2rxzTyb+XtbfUR4x/mryeinDzwBvIjoQh7m5G/cUe1eQeEG+gFeN++4V9xhOQAwAxQZVnfx8feWnhFLqhJXOBS5CtUO4GEoSQrDtGVkKSE/ukzsKEXqWDJyRLR+v787BAIsgD43Qu7/ilc8EramoEqqUMuSbKEzR7TmsNECBUawGNIf02HIiMvcD2gfJ3nkhWBgDqpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkmyvFhAtwkLjFeAZNJ07PNEgr89RStpanwayKT8mb8=;
 b=ScXpFyOfpaAOV1OQ+XRtjSMN7t4ROBDLxUoUI5UZ3MJS42GOQ+nKhN6u3Lpx9qFicEtVmo1Tc0RZOpt46UKxbKLoIkSgtjpmhzxvwcn0uxsW7Fe/bg+fv5XV6MsxfadeyZ4C0VhL/cFAXVPRsqclP7QT5FnqJvWSzgHEZmHQZtFhzXrqPcZYHTs9oobWQT9JUPKefi13k/MfxxCbF1QygrEp8Hqy3pc9AD0kQg8OoAGu1srAlHfGX52C16UCYTnyR57ENL5C/4d+BCZLYuNVOWbiiO59ZtQ2ZMl13qQtmqK6dUgnHnqD2q4j8luUzCWGYvgIG/e3sNqHl4JQCTmZhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RkmyvFhAtwkLjFeAZNJ07PNEgr89RStpanwayKT8mb8=;
 b=J8+eGeIcLYiV53Ek4fmbxaQbyv238T0SfnIWc92ZECwCib6BS8yXvHPTBOUeb7LJqcIrv8EeyaKlwDRXWmRT2z1Uj336rR+VGamy0kXQjLDmlxtR3OlhdOvmRU0OkTR9VijD8HsoeOUJvvC9MjP/DsieKGHm96uagK5/e2HYydc=
Received: from BYAPR04MB5749.namprd04.prod.outlook.com (2603:10b6:a03:106::21)
 by BYAPR04MB5509.namprd04.prod.outlook.com (2603:10b6:a03:e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.17; Mon, 24 Feb
 2020 10:58:03 +0000
Received: from BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df]) by BYAPR04MB5749.namprd04.prod.outlook.com
 ([fe80::fdf8:bd6f:b33d:c2df%3]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 10:58:03 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        =?iso-8859-1?Q?Andr=E9_Almeida?= <andrealmeid@collabora.com>
Subject: Re: [PATCH v3 1/8] blk-mq: Fix a comment in include/linux/blk-mq.h
Thread-Topic: [PATCH v3 1/8] blk-mq: Fix a comment in include/linux/blk-mq.h
Thread-Index: AQHV6GY41AijzahxmkSuLjEK97vcNQ==
Date:   Mon, 24 Feb 2020 10:58:03 +0000
Message-ID: <BYAPR04MB5749CD5A22BEBE1424AD61B986EC0@BYAPR04MB5749.namprd04.prod.outlook.com>
References: <20200221032243.9708-1-bvanassche@acm.org>
 <20200221032243.9708-2-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [71.6.111.190]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1419590e-523d-4cbb-05f6-08d7b9186bd6
x-ms-traffictypediagnostic: BYAPR04MB5509:
x-microsoft-antispam-prvs: <BYAPR04MB5509EBF8B0C4264B4CA88DA686EC0@BYAPR04MB5509.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(346002)(136003)(366004)(396003)(39860400002)(199004)(189003)(2906002)(4744005)(5660300002)(52536014)(9686003)(8676002)(4326008)(186003)(86362001)(81156014)(81166006)(316002)(110136005)(8936002)(26005)(6506007)(54906003)(53546011)(478600001)(71200400001)(55016002)(33656002)(7696005)(66446008)(76116006)(66946007)(64756008)(66476007)(66556008);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5509;H:BYAPR04MB5749.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: isYsACHqQDQXBrIbEtWL/2/fj6XCMYxOyZF3ZK7P415RrWKoVpVD+ThuLdncY9FNcyJaE8KGfglDkYOWQCubYQNC7aXSZjgsmtFeiSv7W56OwCbbfmWxhkMXraWK74kBczLx5FfkIexz23cP9wxO+El4vexqrU9oDs1AqNWrG+6Pq5OaktY7IPxO+BFxdiY1F+JLBkZMoLOvPsaUOzrsulV+ABpUS5O81TLy0genwa+kfh3TsnM6QYwRm1q22INbenw/RTFRduTqGHRxP79joVTf6mO48+K2yPzXkSA/nJeKXECBThF/S8b9PAg156sq+Uwv+fUyLbFSSgQRnEN2o1H7+6ZLUY9OHjSU2W/111yw53RHcN96+oTO5OwK4iJ6WxKIezKb86OiOoEtQ3dALnbcPe4ogkvX9plELiaF/Ammg14INsy6v6/gr8op8N7t
x-ms-exchange-antispam-messagedata: 1/E20WYaRaMa2VipJur1VUo5tOPeRYSPPYey9JyKbuY5U5o96eC2AH7vis/8I6zotLJ8TkM5iYLGZr5Tq2BRSpJJHjBdVNRH37fXKgPAkxSLNaprG9tmWh0tSsWaGfqeYaTEGhT9JaDVA/lqyFlgqQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1419590e-523d-4cbb-05f6-08d7b9186bd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 10:58:03.4037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RVZxaUSdj1mEC0r1gRPqTENjRupaIfaG0PH6RJ+BMC21AOXWE9+C194eoNwOv4qs2dpucjwXZUqiBzXNGGHP/kRGqvjkYMtF6svLoRphw/U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5509
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 2/20/20 7:23 PM, Bart Van Assche wrote:=0A=
> The 'hctx_list' member of struct blk_mq_hw_ctx is not a list head but=0A=
> instead an entry in q->unused_hctx_list. Fix the comment above this=0A=
> struct member.=0A=
>=0A=
> Cc: Andr=E9 Almeida <andrealmeid@collabora.com>=0A=
> Fixes: d386732bc142 ("blk-mq: fill header with kernel-doc")=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
> ---=0A=
=0A=
=0A=
