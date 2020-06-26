Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471CEC433E0
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 15:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DEAF20702
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 15:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="frhNObIC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Sxu0U2tq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgFZPyz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:54:55 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:26540 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgFZPyz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 26 Jun 2020 11:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593186895; x=1624722895;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=frhNObIC0EKlqjW1yj5MK9ugwW3ivQZeP+XXHdMEw4c29FhlT99La/HM
   n4HkYykHd/DBdA+KJ638xK6gD5XvzOOyFfHPqzfYUZE6aeUAeqHIkCY7t
   KtRpIPAarhsiQypVlRVWZArPVwdZv7EXp/6puqCDgAjLY2Ti+uRZk3iNI
   rDfFjCiEjAoqwywNH4uwuA/CSwcs33BQIkOgkLBiL75ugVJQjiHQMWmjW
   OR/w5d9Fb7b8HBql0U55FTbl967wPS5PyQGRm2eFu9guxNQBUoe7yCEY6
   FMhJFVp0lUdRuRnQP0MyDrkfavhCMpht7mRlWtS4B/46xys3fj4qzplLW
   w==;
IronPort-SDR: zEAJA50IeuOeaij23ephmgYqR66L5tGV4KhjElkEulvvlkq6tZHsXrzRNC0A/oaWxD8fNPoGMV
 PQvsgRzG/mhIgY2ek8IZZgO5skOVuaXP4japjTfeE4bu4IN+smgy210W6prPP2blBtfyYfo4vm
 XEOWQktST81EZQyF3YWYuthuFlH4FCrLyz3keRZmYwLOT4EZ3+3ozwWTfgfsw0UssBNB+AhTL0
 SE5TafHmrwV4V05JGrLBs8Mgmz5RnE7PdoOqh5EYq6HOASmbEEx1Kd775VwBdZIWc+rWr9/0AO
 lrw=
X-IronPort-AV: E=Sophos;i="5.75,284,1589212800"; 
   d="scan'208";a="142376042"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 23:54:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QDb+HtJnyxrK9TxEHdoG/+8LUqXbZI0EQr72r4iajpJl7fR+Cl7hnbP/kb56/goJ109prHCiF+5elBRZSQQaCEe5Gi0zdTdTFznuaGPDFQD1U6o89NofhLaKOxf6fMIne8mNBfRkWYdWGehH7l0lT0smf0zPMyRvnBRg7ac/CAiF9XkwQOnBVDf2tlTec58BgueelHCqvfV7vymbDLsK0MxoGjyJxRaYX6iGzhGalg0C2w3Qzqcgt/lNBFA311Ylep1qCDH6DnUOrIwDpe/ocl8q4sQCRtJGhtnQ5dSyxxX1pVJoO/pNqv9yOdghh3H63Ze0YrIE1MOFjd0+t0uYbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=GAQG2pNkHZhht+qO6QAU6HSdJXLEqbCo5CQcKz6Wdsu/phMmqFI0H9aOdqMrp2eahPodJVbreClEn513kWdAlRkBZlpx8ZXTFxrK/mKY+gA9StGU75ik/nqkv3KgL8oNVgWpw1Lbc2Iq9ZkIR9k6OsQWKnD5EYx9AGMwDhKZ+QgupIVGtImhRBQIG52ofpmC1L5/sRqBg5he124wH0xx0NgyQ4eKk3aENWHWtakEZbDbtAunmTmneSuVadqb3Hxk9NGpbBNHQHVZRlQ4m+FyXWEoRI6Io3OD+5AmTZqOmw2stkME7Cm2+oYZxeWnA5GrDN7RUykTFqbh9TMkTiscKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Sxu0U2tqMwW51ufIFAvvdbyfJVuOUoff0Aljc2Be1jTT4EV0YK6e7TtywL0xShUnUTrZdit5uwdlnMRmOkFdp6PB2XC6VIanGLWRkQ/yj/5IupV8nW0sqSWYIZGNwAJ77WEcXEK148blWsB1LMbkv7Lm9qdjYPICgu7q15K6YU4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3966.namprd04.prod.outlook.com
 (2603:10b6:805:48::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Fri, 26 Jun
 2020 15:54:53 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.021; Fri, 26 Jun 2020
 15:54:53 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] dcssblk: don't set bd_block_size in ->open
Thread-Topic: [PATCH 2/7] dcssblk: don't set bd_block_size in ->open
Thread-Index: AQHWS5Aw6MffRNiiV0aembZZomRl8A==
Date:   Fri, 26 Jun 2020 15:54:52 +0000
Message-ID: <SN4PR0401MB3598F2694FB33E1CCA757E009B930@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200626080158.1998621-1-hch@lst.de>
 <20200626080158.1998621-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:a471:867c:4e70:8019]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c39efb53-81a4-4c64-26fd-08d819e943ef
x-ms-traffictypediagnostic: SN6PR04MB3966:
x-microsoft-antispam-prvs: <SN6PR04MB396653CAD8B05AC141A60D3D9B930@SN6PR04MB3966.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oVrw+oh6YwcnR8vndu5sAr7a/P5pXRjJnCLlbuV7QN43KLNHV4TitzeUPavlrO9BTdxnO65N7xtOkuGTuvYk+o+5KxJYEkQukrWUbR3qbuixjz3surpv4L2BKBT1dYGqFvzYyQ9cO8GVKFSGP8OA0b3/8/dRcz+CjdEX7rVIn2n/+/Uikyr+I3AGQMuslkULNm6GmQGsIq9ynDWJnH7AWQCUCZwL6yTHg/ZdMykG3cllpiy76mBqq2a7XIWMWf+zhbMi6W2GU1gMvioKZAUbflDky00i/sA6wunYW7Q5SWPYLhqaQmp8XvSWWDmY8MZFfx408hz3sfHrDcnVActT+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(366004)(346002)(376002)(396003)(91956017)(76116006)(55016002)(9686003)(66476007)(6506007)(316002)(8936002)(33656002)(4326008)(2906002)(186003)(4270600006)(71200400001)(54906003)(110136005)(66556008)(66446008)(64756008)(7696005)(52536014)(66946007)(86362001)(558084003)(19618925003)(8676002)(478600001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: E17hV2YJQMSbqICwbPxWptm0P6IISmwMH8m7wNw+yUd2G8Jw4eDqIxPLe3jxRK3/3/MAo0Q5AOJdnGPe7ebPQf3DkQ2CdF41FVPWgTJrMrpN5KIv2TqVq8x2Tdkp3yLJshO30HDUsnvfkUmSMmHhMczMkUwyqSdeYfGPWw3A5T6wUUORQOyPV2Ed071dsdJbBj05SIznsWKyU8Y+Xs+AuVcrqd700J5A0LAteAtNNojwbF7N9Z0Ddjw0ojxBw3UOmTVuZVNNi/pTvIHRL1tDQKttg42fqS+O6nH4VJx17/3zyqNkPLJWKpQ/tqGGkBSUx4xcEWK1hZ3OL+HUtufab6KWiGkn5sU5LdgfTESEKeu4Etfjv7wJstYH487a8hbbP+oRP5PDccFOSyGSjdl7cPT8gGle+y7g88MJFxlePaNXt3CGYBpnUub9XPXMp30MBC8TL4H63dcbrRxRcq8/aC2uwdRnMEbWaRXMnCe4gZ34K8VYpYuxlzChdmnuGE1pZAbHoQSqWjN27EnbJaYpVEikROzTOG7OCh1YRiKlCax0ystZ971mpofXt4d1los3
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c39efb53-81a4-4c64-26fd-08d819e943ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 15:54:52.8827
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ocP3S6vKJxtoFOyegwzQJde0A156KdJYdWuoBQMIpuDfR4SKxXYXJIL+H/3zpyvLq08ZdztTH+nANaLB2UFDpNPG1vU9ORTqlIC0UaNpBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3966
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
