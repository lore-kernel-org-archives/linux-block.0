Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55994C433DF
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 07:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D9FF206A1
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 07:31:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="gTkJKz0Y";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="LdMrOYCF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbgGAHbB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 03:31:01 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:15551 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728159AbgGAHbA (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jul 2020 03:31:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593588665; x=1625124665;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=gTkJKz0Yd07n64vOmfVRFRm25TktPO+oWAE7MbdMao6RYa7o05FYy8hl
   amP8ZlI5drnsGEwht1cNHaBZBeZqYOvog5/LFhTUz3VmyNJxCYWbFUjqp
   Mc8jMhkjZcuT2oB51qEoxmfBjmdMVuaF2TdLbYpigGkoDvRn5N65Y94WP
   rRuXpsTj4X6X64g7VZKVBzGEuuZoasVTAq2I7QVbrUooF/Mks7XnYfa+y
   lSO8Js2R6WYctF+/Bcnhn4g4pwLW/SIzDn/ovRg7AhoyJMj5hVzHwswuJ
   hw5JNw4XBeVlgG/+H0niwhIa9Yjb3sdPsPsjddXsD+K9hRMzJJoWo50dT
   g==;
IronPort-SDR: 6HHA0EkwzpOlEFLHBP6eE/Ik1LdS5qW7sffFkKIynGU2s+HVbMoWphNWGXtXZAlxz5oeNYHZ/q
 j0xlthJI3F/7jzQrCaZtXPqef4ifczabAmgGn+dBxqpgb1s1jPieWjxqa68vhOpJgOjOHEZrlq
 qEmYddiDV65lUHvrGVVcA9MLvC3Hhgl6kFw/3e69e68937wXN04e1b8V5V4XEsLlGNftBdZlkn
 NJAX9Pj9UPpTaTD4sXu47DZwSLfy8eeiLcexxQ2rUNLbKG69SOoTsR4qGKs4EmhTXKClWXqbKt
 uJQ=
X-IronPort-AV: E=Sophos;i="5.75,299,1589212800"; 
   d="scan'208";a="244378112"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2020 15:31:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LIGQDXeZUEa/sWe45Q4zAwH3NWtDMqksrl4LJooW4xeWESGKfgBvkU/FnD7YooYsuGYIoxhiDwTQKZvgVb9A3osqgmrVUJWZQY0INjmOEgqLFRAbvm9QvCHSXKDZMQ4DQvUiuXiltYO6yjBB65i2u2kn7Kj71f4govUcbYp1DrjkbTh9Ly/NIX6y0XI+GL7Xu0IbSTv1MCxCPPYZ0g3+GnjSGp39ATTs86U6HYedtDG0Cy11mfMWs8Qaogfyrgjn53hjjFq7Cx7xwAfxz05uMwjizktePxdrayJ/6shcdsL1dETgIpAhpivUWAffysyo16D4cAa1nAIc6lDQQO4FMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=eFmoUNKh6PLAq/ULyEf1OHZ2Ry873He0RSEmyhey0+7MY06vS8IxTqoJD+rTry9Rh0hbnbMi0xAPMV/hemR5aL7OqkcFTSQ/l2omt+J8EtuH21t9jX7gZUOJjEUzWJ5i67Z2ZQ4mZ7olPDJHkhjpr1pLbfTY5Ksm9LMkEFgd+sy2ItIzKIT8MHqGOPqpV/lUta1ko9zPkqozfJmOPDZkRitOCRlvBkBq0W0L7DiJYI7EqhrdvXKBDab/O6QYbI4Gd+4LpgJgusspO9411gx/PtHML/SbHVz0D8HGP57qaRo7HsV3F8MrMyMYFQMbnR5zo6voSXmpBaBQ+ZIP62DJVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=LdMrOYCFdC6/iCCGLUxcg+yyXFqFebZLLZve9dNiqkGx97Bf1lDS77xmnWwLsTp1tmp1xdmvGoqV/Xish/BhtehwX+1/yvBabN9VhH13IkJDZyz+RJel9Ld1yM2PZwI0Psn9tDWjdmYhzxqLRas0PPB/N9q0RReiTEoClR0m49o=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4544.namprd04.prod.outlook.com
 (2603:10b6:805:ac::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Wed, 1 Jul
 2020 07:30:58 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.028; Wed, 1 Jul 2020
 07:30:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/7] block: remove the bd_queue field from struct
 block_device
Thread-Topic: [PATCH 5/7] block: remove the bd_queue field from struct
 block_device
Thread-Index: AQHWS5Am0Ip7QsJkmU60Ivlc7oZ9qA==
Date:   Wed, 1 Jul 2020 07:30:57 +0000
Message-ID: <SN4PR0401MB359896B1FF69CCCF8EB38A749B6C0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200626080158.1998621-1-hch@lst.de>
 <20200626080158.1998621-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:85ad:d97d:6da7:d614]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d50cd862-f11b-4b01-3d6c-08d81d90b28b
x-ms-traffictypediagnostic: SN6PR04MB4544:
x-microsoft-antispam-prvs: <SN6PR04MB4544927E4F52311A6A22A5979B6C0@SN6PR04MB4544.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GlGfapRDhFVpUNV89ns0L30XcHoKx0d0opMULZCmCpskqRYNx6kSp7gC+1Be30cXjUCwthbgAuW2LJhEz5ToS/g18DYKn/0eUeO24fospnn/iLoW5KUyN/4jwGJNaVsuhRnfV7/L7U+fBfcqQ1+HI1ZGvOFL+6kk6NIw4JGw+QgsXQ8VUmcR2GPjd4ZyT40GYGro42tXD2YoQ0qaqtdRT4Bkgzgrmb6v8qn3ssLr1H8KGm9YULuL1XUvnOXKa30FZqwAnUQbx6vjPBp76J0iBWfYZxbtQnDIME/A7q8gJFfN6exa5nDlJVgQ80GcSMrOR1+VPjUdvPvB66VwV4oXAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(6506007)(71200400001)(316002)(186003)(2906002)(558084003)(478600001)(4270600006)(4326008)(19618925003)(7696005)(9686003)(55016002)(33656002)(52536014)(86362001)(8676002)(66556008)(76116006)(66476007)(91956017)(66446008)(66946007)(64756008)(8936002)(110136005)(5660300002)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: VeX8SkEPCLRW1eTlvYJbzfVpwyhRaAUnYoawTgDcYwPmKwNeHynWbw1fyMaZ6gDYeSYpoz3dfYnrJZ4vXpr0BLy/DL72OUJMQws7sk0j5kW5hb6Kq47lDWo/O3Zn2ziRerPrexVs0caTglQJEy//npuPLWJqdu3lHFB/4wJUnDgZZFt/2xsUTMsX60CEoJNd4+bjAX0eYDtmdRvEbliCApFtD8a5FdNPityJVzglTh0YKQElKzzTWRmVrdBexG+oyRUV6XpBaDXBJecqoLapeoZUkie2PyU5Qi0+F4KJu7uy/XtlzigEUC2gFEX1p8JXStxVXV3IZ56KsaOEtaMpoTESx6gpcOmfYY9x/J4nisDasmnOEWEjmroGM95GB4fldVwuYDDXKdlVqXsRcxCHyKv5CCUbF64qfuKFWKid/cLkIOj/2O4ePQinXWzUXCkaoyPkJ38SO0ebjQdAfWs+RhRTlc+G8m2D9Tb85nlU1WhwtkbBGnohM9YwJNUVE95u3DJX+dD67uyZiyLagFKyWoB7osFEC7VO6Qlr5kMSrUIAmakxt7i7x2pJfiSQpF54
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d50cd862-f11b-4b01-3d6c-08d81d90b28b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 07:30:57.9661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U+uMJhdSeBIgL1WOgH0AJ4OUZv4I6eTIra4mIpvnqRnv9/CcRCxjeF3zrv0h+Krd4YRaxrbVL68dp7oNqJEyW8sn9ifJtbOo8PdoCZier7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4544
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
