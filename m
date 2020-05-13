Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD95CA90AF
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 11:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E768D20740
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 11:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="o1tQP1DL";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="eLsCkLSz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgEMLo7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 07:44:59 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:41905 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbgEMLo6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 07:44:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589370298; x=1620906298;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=o1tQP1DLntNMyJWmb9+Sad4NT2rjZLQ0Y3ApAHy+ut80DIyYSCoDDbCq
   m/MyLd/Ku3T/2/BGdbpkGG2gHy17vqy5ZHn1LcydplOHu5gQ+D6AGVx1Z
   iKEXDVp7D34u4T020NBPl9m3jDIMFMg9EndqKaafC2Pmbx+LcfWavdX+K
   61xUYas/MjsXU70KGGMOlcjxDXOfFXuxjs66CTYbeZY6+Ir+o6Plro/49
   2KJ6aArc5rI3DBkrBMgHsiyf51WGtcEsBst7ZxIeSYlbXLO/ZW72Vw7oV
   EhQ010ThcVCUqL4dzpHPJySN/b5KH9NM9a37nytUnu2NT+DLggFN0ZOxQ
   w==;
IronPort-SDR: Gpk9hIFA+OtT41z1jRQjVS6EipoCXDXB0TJOTULPP+KFf52DdaE2iBq3uQU8mk+AYpr8DBcrh1
 FzNcqsGHJJalb1NuMB6sKChH8v7ijwzeE+O2rTIq57Vgb2Fxu6pXgEaIYCX18xnpT5CTFxG0CU
 wUfFEJpWfci5sieoi4nmBusbMwNG/805NEu3OyNOF9vmUAeE+mbzW1c2sR06l59GRDgXT6/97x
 blY0KzbN0ZkdiGV9GpaQRXVCz9tu+C2CEZwbqVMGGKF47dvqgH+2ks4CrVjZ1jKdcEo1MFy3HY
 OJg=
X-IronPort-AV: E=Sophos;i="5.73,387,1583164800"; 
   d="scan'208";a="137914571"
Received: from mail-bn3nam04lp2052.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.52])
  by ob1.hgst.iphmx.com with ESMTP; 13 May 2020 19:44:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLbHLwRYbksODDomtwewTherIT9USH+mtYhdsvxJJodiOk5TNDEUB2Knww7umFeXQS5XpLkvqlRJ3DQfXEZA1fDVx7Ep1WyWwkoUYqfxzgQA4Dl8ZZ6y4y1JcIaIVeOjD/fEV3y1K8IDSOQsJcgp9a/ElhSn+PKKsSp3oZFVv2LImw6AGE04usfKHy4Nvd/ag2RdwpaRZ7qvII8bALdu20RAqVwg+zLenRmCm3ty8RX465sqetRWEug7SWcY1k2nBb0OceVU595PMSJo4UXshQo3BKzXaNg7ApbdXv9Z3kkzUq3Ktu6az0cYE1KMe2t+KYGb7PQgP7gQG8YLCEtRXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=LlHtgzF0kgzlEQ//kSUQ7N+ZJUNBTIks5JhlvObp7HduT1AnUbNSCyfpFqJotkcpElPVntigU+NbQ/DJy71k/nRb+lCsJ/mp8rsDuY6kdgAKrNOkg2Uk3y/TIN9ANrGuoZpK6L9MhS0K4Jn7efJHrTp0Afki93cunMNp2JLewcQeKSPGJ1RxGg289W216UAoe+ssx2fN4c8wORwAXUNOeR/4Q8eHatFcuYDyPJGESaIJ1GKSeGZhxmWj4kEXFZVQVzLV8sR8UhZaaPpd0edWpAjdleW+0zx1ZFYB8b0pTFEuYnX1J2sRWNic79QhCXr4WnmSNoZ1qmi+i2QoVc2nSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=eLsCkLSzw0GaDFqlrgIaz3N4axyMnW9Q6aP4DDpLRi2phb24b5k7LrvyR3qfPDBqaIQyhs2q15Ec7RyFC8ltU1JggbqrzziHAPOodzuBZbKGqd1l02uh0Z1WGsZNmKi3G386/XNyuzGTdjQINLJOu/27VgFfc3c213npoxAMYis=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3583.namprd04.prod.outlook.com
 (2603:10b6:803:4e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Wed, 13 May
 2020 11:44:55 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.3000.022; Wed, 13 May 2020
 11:44:54 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/4] block: mark blk_account_io_completion static
Thread-Topic: [PATCH 1/4] block: mark blk_account_io_completion static
Thread-Index: AQHWKRQ2CGoQYzuX7kSH4X8DJUoaWg==
Date:   Wed, 13 May 2020 11:44:54 +0000
Message-ID: <SN4PR0401MB35986CD0B5611AC69F6467809BBF0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200513104935.2338779-1-hch@lst.de>
 <20200513104935.2338779-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fd50fbe2-a94f-4426-9a18-08d7f7330e24
x-ms-traffictypediagnostic: SN4PR0401MB3583:
x-microsoft-antispam-prvs: <SN4PR0401MB358345289D5093AE7E9940259BBF0@SN4PR0401MB3583.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0402872DA1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zlq5wWT+YTxps8zyoExlHFAyYC3UmQtcWUpHw3RLMSWD+RWEeccsbv0vgT6f3fH4teL9Uj5pMsxTLrg2tWVBP83H8KErvuotK41uiT3Gaf7KwpmKWPlioDEAY9/oqg++pmUB7mMVnv6A6M9H7TcNfJ6RXZOXDfOMzyv2O54VA9Kjjfw8+pTLU6nLcPqWoLYBLTz9XoXcvv2NTqIbA3+4dmWZSYcorTdXXaDt8YAePYEweCrmqjjFSALkHSdgd8B03ok3inaYDVFYCgNCWtnP8n6p2tz+0LDpiCLOZ7FLnEFyZ2m/IgHKzD7yZLl6/5aCRBW8YJrqv6M+KeYpm49VGS+TWmteYY2ifTVPaYA8CBZhDs6O5bmSGiSGGbAX1reDdpppwPpLVwf5PlW1iK6nqAIkeQNmddtQpmbxAhQtFoDeteQ2g2nrEcKMyXBlvlKgrwyjfjwBGhBywPRwLkJvaYTofDWnuxzpBk7XR7EzBTXjxpmvXV3AsJtRXZGFK4oLJocZ4KyKmvul39eZKX8vxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(33430700001)(76116006)(478600001)(5660300002)(91956017)(64756008)(66476007)(4270600006)(66446008)(9686003)(66556008)(19618925003)(71200400001)(2906002)(33440700001)(8936002)(8676002)(86362001)(33656002)(558084003)(55016002)(66946007)(316002)(6506007)(26005)(4326008)(186003)(52536014)(110136005)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: PnadvXr39SSQskqRDPV66iVB2p1rZUujgvFsUe+yStfNFV4GGskQ3ZVlyxs7OJRLxvvSnCmyry2mpQ5qVXP4hxew635D3qq3/GVYmucGl+JL3wpmEyLXKCZ1lFbbKXuKcJooaV+ibAPAeEvnfcfsPlyEmVotEr/n28WmdrNjP0Ufsv9ICZEYf0TNBf3k0XBhrGlRkzXulJakTXSaVltMSHKiVO/1KXqui/DzvVUIz2tQFz3mswthke9/fDzs9aE3pqw0kG8ez53x8GOB2mTlMM/p5UjCxR6UsP99ruXoPyrAGC03nIGyXbB51uZ3F3lKb/mWLja3HJItQ5+RS4SLw29F09cmN/ABphNatS3jNYfkd2FrLN52WVwwOZbwMKDPL/sKuAx6mgvM9V/kZJhMu8Fa5JalVFjnyPQtooKwCWezWKvMzmRRUVe4kJBg+pDlpujGONfOtx5ZLdi1C/Eesb1Ncsoddzyn2l+b16OGtYwzL0L1E5Ut3SK/KJbZMUpd
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd50fbe2-a94f-4426-9a18-08d7f7330e24
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2020 11:44:54.4609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PxjjY7YmrB1IEB+aYMSoQ6NZnzBCG20YWkrPJt2UGEwmYkio705tij+KAbrXaw+AbB9mM4hZAaGtNEORw60P0XGJV2Oz1I4B1Cz39DaHrkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3583
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
