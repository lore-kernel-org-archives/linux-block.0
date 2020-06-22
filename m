Return-Path: <SRS0=vyV1=AD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23830C433DF
	for <linux-block@archiver.kernel.org>; Mon, 22 Jun 2020 07:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC4CE25307
	for <linux-block@archiver.kernel.org>; Mon, 22 Jun 2020 07:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="U9Z/HjNF";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SSbThA3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731290AbgFVHDa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jun 2020 03:03:30 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:18401 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgFVHD3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jun 2020 03:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592809409; x=1624345409;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ASWmxR4PxEvEID8xjnCCfnMf+wux4tjHDSqf+2TgCF4=;
  b=U9Z/HjNF2mhzlDW6K1+SkC58poBYJ9C7UubGtoqtDp8esZR9vvSNyDUO
   AALebYBME8aQMrSp0YujKqwuW4ZSXCDtiNXVirn5rLINWiy52TryvFObN
   TIspFgSfyD5QoRsDURZ39h6NTCVjxmtlrkAAe9FV7aCaAe7CAPvRAR8Z1
   l+ZGhwdyPePJIX5jYD6xdbefcuU9NPIfnUpbL78wxIW1fyfofiFPDpjiC
   pcjP37qcyefLHxIcYmE+tA7Uojzg7An+I/GDDt3ejdK5stCpEQXsTbr8A
   DauIDtPw9qlUOfDIt96f337rjxpZQGZkqwDNV4gmXD+DLRSvRC9Gr1dWk
   g==;
IronPort-SDR: LcFiLrh7zpdzLEoiRZ5sWSAqH3q0AJ2GgqbPXG/qL8iQ2i2t1lNFWKHBNgFcqVZNCrglLWw5LI
 Q9Gyoqz+X1bWimXVHu30CRk3iStLHlqXtvLrJFtC54O0Hb+tXXFlDZk3936eOqkvTJD7azMejD
 afyfqxF3SRlX/1xZNv8xStsxBbHZcgTsQZg7FRVnRvG0t2Imk8o1VJ+WhqUxnd0WcFuRRnOqK8
 7oCS5QiEOuo/F58GLhDPmO5qDigopQfItdZBb4/zU7NPJwSuWu82UvK8905+G983oH29BY458l
 oxY=
X-IronPort-AV: E=Sophos;i="5.75,266,1589212800"; 
   d="scan'208";a="141961006"
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2020 15:03:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8J8CMLRvkwUD2+7am7wEqMl2+zReTcuocPg5s48bbMXq5ZcCbAwav1rMTYQGwPzf9Fa+KDRAgdHuMGkoqE6H9BrQfCcvqvn1Bb0E97G3cTkfMAgH9IoZyCoOiXMe4nIsyl9WuTfKu8lh8UT/W4vu1auvWyA37mfcaMP5uBeUb+AFJER0YM1OV2tUjACHHIDkrpZxu9FtWcDY7NqHMw184wix7OHtx2Stc46QqSygYGOyOXfFii1bcy26d5ZijK22X1KwauU2b9hHTUzQNduOg4cItQg6ayWPpUQdIWvEQxc7Pyxi24AbGFpxlECadzTkRFm3Z7OHzjdAbTVZvn1ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASWmxR4PxEvEID8xjnCCfnMf+wux4tjHDSqf+2TgCF4=;
 b=B2PlSJ2Yqot95ZFUyw4EC70b6iDAPWCIuiwKLMi/Um4pcQjvfia6xgL697VbL5ronvu5+wKgYg5T9XzeHGzPzi2GBze7iqbkdPld2YykT2JocpfolteVEQKB3whGUnLm7De71T+aOLKBsPTgbbJd6tg3KZy2E8IdJIAWMYaXkhgRvSUyt6JF1wdY1BNQ11rf9SAWxTxe32PFH2idG3nfiMYi0WzlfxE5YndRZNrQAREPE6E3rttqqeoUbSPqs65xWNK9ewIf8+yioRYr6OauNNs83qwAE5pfvFdb/N9QsyJ/9t3eNPyzopsHgaP2qhDUhQy6QeQdJRoOh3ADgwiJnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ASWmxR4PxEvEID8xjnCCfnMf+wux4tjHDSqf+2TgCF4=;
 b=SSbThA3ADibJlsUP5ddDD45kWLU82ccnywzdXrgbA3664K9bNwfaOcdEhuhpqS+2nedCYpatjGOHY9MsawClov0IeQR/IWclJhnIXh/NYtnFRqVCmaBobamlMYIM90CTAboKnrlXO/wQ4dmFDouEKdKm0zaJLM00abVfgyzXJio=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5327.namprd04.prod.outlook.com
 (2603:10b6:805:103::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.24; Mon, 22 Jun
 2020 07:03:27 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 07:03:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Daniel Wagner <dwagner@suse.de>,
        Dongli Zhang <dongli.zhang@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH] null_blk: Move the null_blk source files into a
 subdirectory
Thread-Topic: [PATCH] null_blk: Move the null_blk source files into a
 subdirectory
Thread-Index: AQHWSAySdT/2PVIveEutc1HyQiiINw==
Date:   Mon, 22 Jun 2020 07:03:26 +0000
Message-ID: <SN4PR0401MB35986CEB9803D388E3EBB15E9B970@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200621204257.16006-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1597:de01:e494:6330:3987:7eb6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 66ef2d62-dc31-40e5-12f7-08d8167a5cbf
x-ms-traffictypediagnostic: SN6PR04MB5327:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB5327519CA69D96BCFB0D48DA9B970@SN6PR04MB5327.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-forefront-prvs: 0442E569BC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jiGLXEjAF+4fVCalXgRg+eggFDf66ZYl0N6eWF6fFjdLiogtSGwJaE7UqUaSUSgkf2fZLLyil+xgn3gFTpCq0FVQRbXGvXqSQkJuKAoRILGopcCHCDHzoCwN09l9vz428mszUvHRM6X7E1FDIz3UBDnBXcJ8134gEDayx1/zlRvfVVjd7LqXiX4102lyouDgnP3eYR5hokFstEZDgxCw+prqgblORQYe+PmbxlTNV9ddbDFFRAScBi20n1p7+CCF5O4qADeeQJyZf7V/NSwymHhhiregqpQLtxfkmL15ABkJ6TBEUecEzQRylw30Zr2KP/COhhoZwCT8pwHJDrd8FA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(396003)(136003)(346002)(39860400002)(71200400001)(55016002)(2906002)(9686003)(33656002)(110136005)(54906003)(83380400001)(8936002)(186003)(4326008)(86362001)(8676002)(4270600006)(5660300002)(478600001)(7696005)(52536014)(316002)(66446008)(66556008)(64756008)(66476007)(558084003)(76116006)(91956017)(6506007)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: BJ/Sytt6hmMk9VfJzZwn75fR9MVpPdfpAR9mdXDSkPMoo0Z4NVvWnTJfp5tdJGAh6VZZQ5YEfLX/KwjwIZqxcjv59nGP4xn8vyp1dTaMJszquvi4lrxE2HPk0cz5xPP0q9vopJ521WnCgunQ3US5E1Ma8V2GnZcQDZrVYDSStvRosI/MlcFgQqx1adqTspq7UhBW3sIOEkudFT0UON84mPdmZQFCOjl5RIECRSI3JmFO/7BVrIiQgB6JlRTvqT8QOA2WdpKcADTmwSXfoJA5rzwqTJvnkct3J2ianbwg7u8iFFtJrf3sxMjLRF5toLVoSWz75M57G0qHOkZTwjyE3IVuoyLDblFUFLxCqZYWSZDsn8IlNHoUN/B76Kvz+b/R2yYZY2Y3eEH9RHVQtZcM9Z+ZnuPPE/+RAgCn2kO61uKbO6nX1PuglZ/RHVzxJqMG+J4a/+qKpDWfdBmNiMnwc4W/vMsGFjXLXJO070Es757e8o821SOFAVwDaHH0njeZg02NaB8U+FiIa6Qi9R5eUWwiswOnfAn6Yz9g0J+yyQDEYY137nY10+BbQ13aBZcz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66ef2d62-dc31-40e5-12f7-08d8167a5cbf
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2020 07:03:26.9869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OTbO8Xbdj9er86rZEYxu4yr6FmQHLxLGqXM/suDZ07lwPTQbD8Ka3E8644OEuy+/3IeoYajqHlCuX2d3fuG/XIlo0xVFe4pkB03Voswh0HU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5327
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

With the name change that Jens requested,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thunshirn@wdc.com>=0A=
