Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18921C433DF
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 07:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6F62206A1
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 07:29:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="QwqQBqd3";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VgxaW1Ki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbgGAH3F (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:29:05 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:15390 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbgGAH3E (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jul 2020 03:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593588559; x=1625124559;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=QwqQBqd3wJM1f5UdjJXABEbQ8WoBI5tu+aVklXKsq3gPhwNbOKZInRsm
   QnWf9HFo59xgG/KW7zUu0ElW5Pz+9Qfpz3/Hl4+TsxTgMLyGwT27I3epV
   5Ug+dYGyHRopxK6viKCrw1ZhG3hPtm7tPWOOlrBNgQS2XKkOUuA+9SjTv
   aa/wKNIfXwI6tlQJJv7UE3UZ+bpV6u6fxLd8igeebMhHQpKjjRjaHXL3p
   /90ozpe6fcWrF7eVL2kNiafu6GH2XxC2xx/m2ajQbIbfGHCNfY8cbWzD2
   Vc8cwIipWu8DlotUSw94kIqkcpGR1ddVbh9NKiDwkOQSnU0Vg7tYkml0e
   A==;
IronPort-SDR: tzhoQbMd+A/UI96yU45prAHDg1Z7nGY8Uat48t9eoaqMWVZfxI6Dtpfqrd/Sih8CDw4c9gEXvQ
 sLYF9p9Tb057MZzrO9IGw7Z+F27++8s86HCwCSo9LpaEn8zjCm2ryrwdQuqx6Ul4riFVfXEyP+
 PIOYUJ2jsLyj84YWHKZ6CEt6K0JMgWuimJkx3/uGZbxXfwgXXwJUurbPAQoXGGloKxFQdO+0oX
 VRIAQv8JT37npeYlKKrqkNSItRl45mnm3AeG/UpsgSFfy/mMscmxc4nNdlqnvpi7rtEZSLqf/f
 RXo=
X-IronPort-AV: E=Sophos;i="5.75,299,1589212800"; 
   d="scan'208";a="244377996"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2020 15:29:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TAVQfRKhQb7ArxnF2k6v92ZyAR/eEH0D8b747nXeDVn4sGSqbAqWThiLeA7Sdqmm94BcadZRId5epjG5Q8p946k9uv/cFSXU8ccf0ALEmbmeoj47hajcR2/O6oW/RCX4AKdPELpFcFLuDNgYhUDjqFosnd8YWPiP7zTcSHBOnnrBHD65PruXprcGYby4QAuCGJ3CufbsCfcMzPKH3qM1uEJQh5mU65h4lt+w4KqPTxowPFu/sa3EirBTMGd3QtMt+omOonqgatkJSOZCHM3Ac9pU6c2Weq9TpXnLUHd/TcjjVK5+GZSNLdaG0GvmyGKRFwEAOQV/BLOafh9capOW5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=QSoYbHEaTYgYH4EQ2C45eej+IFLXz802soAPrdtbstrWbLqOfUHN+0VfqeLDLrLG8ymxAzK8JquaLsWUViSMRWo5vRr/hhyGxuSmuXE97wCoVYw8H3uD2t3ahCphHKJLEBcxtIuCVOMP37ExuuUGdL5peflBZ9CB2gbrUjb2v7nsMpWX37lZmB0M6JBocGSJ9VjChTrpC5OaC7mOX0zv81SjtsNCVqTGYiusOUXs3Vz5eimJ2GEC8X8lMYc90FcJ1DxAmJoso32kVngLiIULvRu7JxINcqY9F+Rx7srgOruQdFyrXYy46bIS2JIhJIfSzF0go1rCWqkmXh14xwxwAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=VgxaW1Kit5FFiZJlZDHyNd8QEFdiQNexwe9vRZztPuwRAMOrDitX8zHOPoSN1802ZqqVQjj1GlmJHA8nzjM/DkgdLK5xtbc91Cenhb35DgiVjceTqqq1cna5IBZpkKtarNhGUArMmVGfNQx/sSzebhRaGENdnkwffst8xv002cQ=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4544.namprd04.prod.outlook.com
 (2603:10b6:805:ac::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Wed, 1 Jul
 2020 07:29:02 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.028; Wed, 1 Jul 2020
 07:29:02 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/7] block: remove the bd_block_size field from struct
 block_device
Thread-Topic: [PATCH 4/7] block: remove the bd_block_size field from struct
 block_device
Thread-Index: AQHWS5Akc6dIcjoyvk6e7/M/YgKGBQ==
Date:   Wed, 1 Jul 2020 07:29:02 +0000
Message-ID: <SN4PR0401MB35981FDF25C6B201965E967B9B6C0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200626080158.1998621-1-hch@lst.de>
 <20200626080158.1998621-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:85ad:d97d:6da7:d614]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7d1becbc-4df9-4e2e-a47c-08d81d906d90
x-ms-traffictypediagnostic: SN6PR04MB4544:
x-microsoft-antispam-prvs: <SN6PR04MB45440438AEAF44FECD3D69A79B6C0@SN6PR04MB4544.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7echXKs/3Q94F/9Klh4H8z+HU7S1lrbIT+6qyxihnxy8R/LXqFvQBcBkLEHkHqqL+iIyaVzDSEftUTjqt56hqP3qK+IP7F3H377TQyou7y6h8cRwnxwPz4kl1voFpxjTZDGWLAi2rLe1K1eLQJ1c+/4dsYVDZ6CF89HUHdBzn0AtkW8ydWYDOpJbOzcmKnoBlbWVNhmrPnAMlK40WfbjNUby8Ko41vkrT4ITaWFtA16++G9hL3isgqGAHWSde+2BYhUP+27DnfsTI6M2KU4RmKQR0zW8tnydh5PiTdSSzGwrY5A3+IZGF6LW6gtY4kQ3xmIDiCY/XnuNbofI2LpKGg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(6506007)(71200400001)(316002)(186003)(2906002)(558084003)(478600001)(4270600006)(4326008)(19618925003)(7696005)(9686003)(55016002)(33656002)(52536014)(86362001)(8676002)(66556008)(76116006)(66476007)(91956017)(66446008)(66946007)(64756008)(8936002)(110136005)(5660300002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 5WoJOl/VYe8nogRSADl8TioeZLFWGx9CLZkj9iKs3v03VKIl42XMtU1GlYcxiVfcrZwRUr/DMRVzGxrLGfzipcUZMVEYtDT9drS1JVvmJEk1ZUZdvyCcMlk/k6JcWw8ErMZT8P6FC0C0TppHTVW6GKA+7niQIGyyd2XFx/92MpHW4Y/qSs9c2ySabbsafWwjbHEjS0OP/v3Lu0Q0VY4cwa7Van1aY8aVCafibtG9Ustv8e+730+2oDoAnqvgYJ/VubZ88+WeDgJ684LxXqZx0MTj13u5DzqDzNn+iuLeezQZ6cXhBz9T/O2rekzpSoO5bK/bHSNdZcHxN76Bhldx/ojQX5W2M9nQPmlj48XqyKn/ugjUF8TwwfpeWWKm5/u7n4zYzwnb5mDmZ9+/4XZYItch0VuseBSbjPjtNVafZrNz5FpG+6aSrfNKUrblc4MS864+Z5Z2XqIoVk+J1xJ7lo7yWjdwhVTyKZYQgAqdzRaGaKZbM8JNM5bqo524ROhzrwWS0QTHF9Qhububi4L+54HK+ymjBp+5iJP9/3hOHiLgQfNB5kzJbePV6NIrmPdO
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d1becbc-4df9-4e2e-a47c-08d81d906d90
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 07:29:02.2118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dnXQKwZr1k2HVpLLTBJs1HV/v2eFKFUVLQ9F2LpYI+InL1uZqazAFaLQAthPunDzWxsntlHU0IGMoAe9U2n9IQTiZzHvIs41QtzLkY82Mmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4544
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
