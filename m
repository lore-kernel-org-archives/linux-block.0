Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18512C388F9
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 18:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E72F20797
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 18:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="m9PbUJEl";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="b9hJ5vRd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgKKSXG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 13:23:06 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:51913 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgKKSXF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 13:23:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605118985; x=1636654985;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=m9PbUJEltkXiUh2ABX7YkfD2WJSy+txaZrENFV8CBLc3ySb7VF3C95Q+
   Rel/RSKNqe2krHqKg5tnpnwZ9qIyALkO/u14bsuxehaab6ZYNvF8kNepZ
   6ti2I97tqNHyS8gmf7Y5I4gJmA7zZJduX+JT74zDYXS9meq8RyJwZGD1V
   PJaDpxr1raBUQcclTsEBq/9B/MKc9CmLduaceRvHQTyandG4Y4AQpo9xK
   ao3OI2O4CjlOvrTF8Hw2F5DOiI/THYa4cvYpytJAZ63YGsaK2K2I3go2g
   bUO9MCs5sXJZX5Qh6SJaXjOAHcvELC1KRgEX6Ynz25kGfH4n59kQ8EZbr
   w==;
IronPort-SDR: 0s9sw2dUJ31/xI6rZlsDU0baBbD+QmwLc6ZplowpFqs1u9BpSzAeTHBpMG6sr6f6kqpEnxWjli
 wMOIDv5Mdyj3FbgAhhVBtYssn+WoIswqCApTXvXM4A4ScUe9FF3G6Pf5m2mDZpxwDjMd6TLCn4
 aiCXNEzjjQIMTsp4mi7iG4M4JrK5z9bHYwEbILuRfkbKDvY/iotmO86jROI/wXyzcbBW8za3ol
 iW6PqFF7/7vkIlH6lNU+z5ihxJLMX4ZAKHWC1Wuwe4VF33BTmAotC/vjfj3/8SqU6yqn+wnQMv
 /hU=
X-IronPort-AV: E=Sophos;i="5.77,470,1596470400"; 
   d="scan'208";a="153603963"
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.42])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2020 02:23:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZKLxf03GdJPfgaa/MMV39RE39c+57Ujjs2VIePvA3c+EOOAqma6SgZzyOBm6vB2IiMUSLJ/xTmRjyEq7BC4pDeYKRqCWHUzTtnIbgu6FKLcLRlChRyvFspFDqPcdDU1xjzj1E/i/lkl+L2giKSWz9ETpMPqyA+pT+nl9yUUxsMzK3u82TRH2GYRUw8v0njIZJQSLqnnRcF24zf5fwST4EVyNZ61hV0OmCRz2m+FsLRcrb7lmJ1NLPxbjw2bKaQtS5PblZe6zjejvJTnS4kwNJUlAxChkFdBzbztoPtobnHWn4rZwLGjLVthyRFC67KfiOkLCBS5E9tq2S7hnZVdng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=T/t+/31+OdVZvu06RIWmuHyLJS7iNlDekHVtRt03ZGd28BGgZUTGOuGdlfuHHjQjeCUmojjaYybMCetYFo8dIFzwJEj2sePYUmq2K5CvdSk3foZmM0+kApZzDAXShlC0KNVwuYOybT/W+91IC5WzKwaHBtArvJCwGGOhhfh+SGqGlrbNoppcm4W0/CsVPiK9oO+tmXFTbB96s2EdXqvYLiOTtTzATY3yj1Q0S2QJSlB1nO9IGkzBgDcN4YS7GwN9vJwcwZ368SNP/S+hSUIvqPXx/cliIOWV03Ofj18HQiirpFZahdZ1FGUR2ssJdi9S61JZrIdFLhsHj8+cjaQszA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=b9hJ5vRdGnl4srAo4sHkvmVTHpHjueKMFmgRoBDwxZejRat9UhaZeEAisdEzfanA+g6uPNNNMek2tRXuij3vf0WK0w8lbAyVpYQF3vIeqJhc1W7yidQp1otjJivLi2UyQ6DpF3bjE3kjQGOUTv8z9i2RbKlJO9lPao7UZWXD0Nc=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4399.namprd04.prod.outlook.com
 (2603:10b6:805:30::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Wed, 11 Nov
 2020 18:23:03 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 18:23:03 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 5/9] null_blk: Improve implicit zone close
Thread-Topic: [PATCH v3 5/9] null_blk: Improve implicit zone close
Thread-Index: AQHWuCq2jSwYW3QE+UGkbMy/TH+ZVA==
Date:   Wed, 11 Nov 2020 18:23:03 +0000
Message-ID: <SN4PR0401MB3598F1ECA91E2CA7B7285E609BE80@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201111130049.967902-1-damien.lemoal@wdc.com>
 <20201111130049.967902-6-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cb765ef3-904e-4194-f78d-08d8866ed3de
x-ms-traffictypediagnostic: SN6PR04MB4399:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB4399942F75E033AE795B65FA9BE80@SN6PR04MB4399.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FHCm9IrlFgh/e5ROvRUOB3W29k6C6PbiDBQLWh+yjs1bUvtAhbu6+eS8lr9GJogAU6EJ+XFTjku6znhRS1dTjKSLNtBc1xntLMH/CnXXjegnMqHWvcRVrb/AGocpYskkFFVY4T1uEcTVoNt6pYTEu44sWwgwK7Ced6qXcsINX+ff+uq6uU4JxNCwobgH9xZFyE6TmDYxpNsx54QlTXRdih/LAr4lv07exbw5zzvryQoZvVQiPpu33x++ogpw3l2OtPAxF/tQUG+ZujdC+ENVsDNa7GPZPyw0auj1UHYv62eLvtFT6uU+V4GSC6dX2lXTBKTzCj6daE8Avo/fG5SdDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(346002)(136003)(366004)(39860400002)(66556008)(66946007)(66476007)(91956017)(33656002)(64756008)(66446008)(76116006)(110136005)(186003)(52536014)(8936002)(5660300002)(558084003)(316002)(19618925003)(7696005)(8676002)(2906002)(4270600006)(478600001)(86362001)(6506007)(9686003)(55016002)(26005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: /OKTcZ+utM8hI6xmeWgAvnRKSyM0ldqsNI3AqHLoQRtj8OTYsBJAFf84fOB0pYQbEEDZAeqLytUsd/l9MUrnGmfMmagNenrBAXO4aQicPOD9hbMEkqjHCEq8dfJeiHmY3+T1sXyIyh5yrgIYl8ormyzq2kcXQ+qVQ9M8c/w+PwdtKKPjaWxweGUHbbzzSKnCPSwF5Ra+rbz11hmk7aQx4EQYcWCZNS/s8mN8MGYLquZtlDtqQuDb0GyIlZkr1UugAvYLMqYVJaPlDBnGrsQocqxvIwJ8nYntCOyH3NMPGdtJDSJLuHZSpq86zKQDxX3y9g74UfeN9Q9ab2iZ6urEcyQJQ1wSB9Thqn4lni6Y6fZbM1DOU/sdd6n8th7iFNcSQQUTdtpTSD70L4NP+zxGsVQeFztxoYjirSvVEN/C9hYppULaUAI6t0K+4KNMq0puBSwHSbunQ4PvEHQAS3l7CWMCOjyKCXn2Uys0Q7itQAC7fackDM8bFVDWstxR7dlLavoIhvByc8qo4evW9A4VYZk1k4Iuo806IaiGTP/uMQMDUiW72gbuYIjbt5Iz/+j69shHsasQ8i5i2B5+6OLkeZCuOpYxzXQSwGHUuRrHsIjqIuNK7OKdR0Q8utkGWrJ8AB78iErcEbbsSATmkRxaoQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb765ef3-904e-4194-f78d-08d8866ed3de
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 18:23:03.1355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Du0FaPCW4qA4Wf45ITDc/BXuizmlS1+V4H3kcIY1V2s35lfMdoeOOQdb0frgLe4CD74LZATt0qqYDWCIOX5VaJmWu8QsTqVjAqrQSZ1NQJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4399
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
