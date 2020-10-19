Return-Path: <SRS0=eZc3=D2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4994DC433DF
	for <linux-block@archiver.kernel.org>; Mon, 19 Oct 2020 14:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0566222D9
	for <linux-block@archiver.kernel.org>; Mon, 19 Oct 2020 14:32:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Oors2B73";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="zMnhZT7+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729346AbgJSOcy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Oct 2020 10:32:54 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:45969 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbgJSOcy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Oct 2020 10:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603117974; x=1634653974;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=7qxObor5pTFUmpAmq0TYZzqbERi98Xvb+60Z7s1mM3Q=;
  b=Oors2B73f8ECCaFry/+hsqg3AyUNDq/hfQnzMftNc8YDckrsSkvlB5jx
   Jf/lL6Id4BTM98IFxXW+jn1U8sP956YdfOG2UHYWHkta5iVW80xJcrBcT
   moMDroNRFP1MYqDKL9YwKb1ANSW9KuZOUhNflMgYCT2krb+RZfTuacpUM
   k4NkF6w8Mqwp4y73/gsHqzRN8fgWzRHaT7SyBaQmqPzyuzDPL83ZFFqF/
   unEbA+W+1CWqDqEKxovkrj1789ZLrhhe9g57NAl5OCVBXtwJyXzscAAVc
   CxAhsEkm1lRDUcrUo6aheZuo2jXYRwPxu7TmKtGBPhdpFUFaNALHUozMY
   Q==;
IronPort-SDR: JL0yp3vdUpowbLJsdn04rS31nHojnZY3WLqlcPpp9+dUeRi6Kwf0UxBb+TLh072lSyIcd8QARb
 K+VwtQt5nknWxQkPE8oyDIewIqsLMtfE/RTUySqBMKp5hu1afWSIhF8RhCaTjIDaQWGMx5aKKu
 RZVXnFXxGvqAqqP7/tCZHSQalqh7o0DsiUsIgY9SiF3QbIr440iIhaTueH4mxj45wSBGq/HbbW
 OgJ63tUnUFUsTW1VZdsQexuoX+dSj9JLW2PRDZ55ASXlKCx1L5TZTDRU/xVK8Hyw093O/mHBd0
 D6A=
X-IronPort-AV: E=Sophos;i="5.77,394,1596470400"; 
   d="scan'208";a="154758579"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 19 Oct 2020 22:32:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGqvgn2SI0g9l/kXM4CiuhWOPTzYFKmJkA69cla4fb+VuV7WvabofcNSw39M02d/3Ut3JrOugirF23xokbynONfuiroQSuYmFMHjUEIQYq+TrCc2KUraNMnpWBrlkvEoIFR415bknOsF6rizfOBXKDpSSMMj+69h/RG85r/EJHsq4L4t8aTRJSt1lez8ZLBmdKFiZlAveh8WQQmEHPKcdhH6tMf42dOnnJ+ZeCpHuM9x1+rPc1HgOTZ3dmbCke7Bd9/UGLzeJGfPfGaOsTchy9M4Z956Z5dyjEDBbpL0SC+qddP8R4QSgN6KBHCYLXLiE3vmrD+9ej05assHgsNhMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qxObor5pTFUmpAmq0TYZzqbERi98Xvb+60Z7s1mM3Q=;
 b=GgPaYf+BsGhk6RtTOjO7jIwUWm7gM5HaarybN93sqwJjzoBKOnXc5xq2QJKwO/moJYPkayT/8BL/4B5pOc6ts3llu/xwLZdnxC8vLb8TGIZRZz8Iey1rLGUIgEIKzHoqA5Bp5HtTQURXBQSxlw4V8btU3Uiueb1LHvAdNZtdgnWuBv7okQTk0FwoJZ6DYVADDYJNAX5tdelgJz4J2ldcSMPnYGBQsiph68stezVfnqT0/jPOey/dB3xOFQaJKUgTSCGm2r1MPnmYQwZ/TyPHEmvRPsxn7tFwtCeQM6O4cHABBH9dL2Uj8OxfHr4SRN9P/+yNlJIAyiCvz+IOTQtuyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qxObor5pTFUmpAmq0TYZzqbERi98Xvb+60Z7s1mM3Q=;
 b=zMnhZT7+RzH8kpc8iIyGyAu39UuxtoouRdP3zxinW7vE7j2PZcwFUDF6xcG4ALSDQZPZGn0q9Trt/KC5MVDrdtkFc6eutwQf+cT+SC3WO8r9uZKXJKkjndsbWXHuM/AflqfXLDrDMx2jDzSUhpTGgkJgb2RpEtJ/cO3FQsMumFI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4399.namprd04.prod.outlook.com
 (2603:10b6:805:30::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Mon, 19 Oct
 2020 14:32:52 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 14:32:52 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     =?gb2312?B?y9W71A==?= <sh_def@163.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blk: use REQ_OP_WRITE instead of hard code
Thread-Topic: [PATCH] blk: use REQ_OP_WRITE instead of hard code
Thread-Index: AQHWpiS5u5lGkRtbqE6AzUg5EFaxlA==
Date:   Mon, 19 Oct 2020 14:32:52 +0000
Message-ID: <SN4PR0401MB3598973510611B1732B5B04B9B1E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201019135059.GA16475@rlk>
 <SN4PR0401MB3598441A5D53ED264496CF419B1E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <3e965865.5946.17541447519.Coremail.sh_def@163.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: 163.com; dkim=none (message not signed)
 header.d=none;163.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a61:53e:3c01:9550:141d:bfe3:44cb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f522502f-f40f-49fe-e00a-08d8743bdc6b
x-ms-traffictypediagnostic: SN6PR04MB4399:
x-microsoft-antispam-prvs: <SN6PR04MB4399363F27A7F6CCC3D9DCAC9B1E0@SN6PR04MB4399.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n3KqmAn7PrON1qseKuh31z+akujELnXRXlAEQOC2obOzocyVAxQt0G494Td46/BHYQk3/GzMIaylYWUPrXGj2iLRFzaYRP4w/Tk0q0HEqgdjK5nFxLt7/CRzuIUP4ubZ/KScAlo7BIZNWXamha7IImtrbwRkfI3KI2v7ip6n6L93oP8G0ollGBFfWwo1RVj0VX8HTgPJTAaD9pJJaMz5ufYqj4itbyCGf9OfDt5r6qmvSTX0fDyROa4vbywgL5MyHnj1yXnJlAyaX45rDUAGPpPL6THNVQ02G0ApQSpBtnnI37D296GJaniStrzCa08LJoSoGrlPu9cg8xNNl6imtg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(396003)(376002)(39860400002)(346002)(52536014)(186003)(66476007)(4326008)(64756008)(66446008)(66556008)(53546011)(2906002)(33656002)(8676002)(66946007)(4744005)(478600001)(71200400001)(316002)(76116006)(6916009)(91956017)(6506007)(9686003)(55016002)(5660300002)(54906003)(7696005)(86362001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: LVNaZz/uAhcyi48qvVts0L8mjLH2dlT6e/E0zqs1ZASZDuflCfaFOSqhDPc5o1vEcwbkentLyvcPjRf1G5SQGlcMKaXN4ZuQdIR6phw2eWPTScU5JteZxO7uSSq2TRd97+xOv2PrGFAeL5XvFnOiapCqFsiSPoB6zfFhTK2LDpGSWTRY7v0y/1YHsc1082QO21Xl+nhXuPfzSUypqS8zT1DkqmKeTYMRWAWuYHIzc1wLtMgpuzXr+zoJ31ck5Z7aV28TUwo3b0NpCYQIuQZMw19Q9oUpMhCNGWbUJWpHGbXpWzxynRX9/O530xC9/9PYaUMxI0GEUNfQLA/zZB6RigjsXWx1+hFrjRcPz5xoCDoI6nYfDWd84yb5CsfrJPnR0hq2UNWtogxyjScNlHQe75bgMnf9AzGQI2en5SNm04WR7T/HZ10zYdEKJwmdUNpu9A9rlsk90xbL9ZZPLL3Yk6iWT5+05J6UVAeCZf2DcbsJjTPgl7oKL5OdwIblL+R4TpwMQ9ZGS3Ux5cDkJEVre/zqSVnqYPXRJF4N0E86fGWk4+KBIKIMK2WYnkYAaBSA9kQL3I/3II/kLD7YCNvWsvjCWj7JCQ1BhEi3ny8qNodH7t6df+vvoOGKk998ZHUrb18rUN0mZS+QufvYBhMsVHCYSObUBE3x1TOLlZkLliTB+zhFt621mzplPEX0zs2T3AxmV9yEomtV9XbzxTExIA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f522502f-f40f-49fe-e00a-08d8743bdc6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2020 14:32:52.1775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SJ+AFrppUZGTCemr7cuzoayp3+tNkVnAgu8zne0TeKF4Etw48S9+RgkezBja9+tdAumPl3qwaiMc1TPZsnXr8J0b6Xw598mvSHpi3yTlr1E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4399
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

T24gMTkvMTAvMjAyMCAxNjozMCwgy9W71CB3cm90ZToKPiBZZWFoLCB5b3UgYXJlIHJpZ2h0LCB0
aGFua3MgZm9yIHlvdXIgZXhwbGFuYXRpb248YnIvPjxici8+TWF5YmUgd2Ugc2hvdWxkIGRlZmlu
ZSBhIE1BU0sgdG8gZG8gdGhpcz8KCldoeT8gSSBwZXJzb25hbGx5IGZpbmQgYSAnJiAxJyB3YXkg
bW9yZSB1bmRlcnN0YW5kYWJsZSB0aGFuIGEgClJFUV9PUF9JU19XUklURV9NQVNLIG9yIHN0aCBs
aWtlIHRoYXQuIFRoZSBmb3JtZXIgSSBjYW4ganVzdCByZWFkLApmb3IgdGhlIGxhdHRlciBJIHdv
dWxkIG5lZWQgdG8gbG9vayB1cCB0aGUgZGVmaW5pdGlvbiB0byBiZSBhYmxlIHRvCnVuZGVyc3Rh
bmQgdGhlIGNvZGUuCg==
