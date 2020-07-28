Return-Path: <SRS0=YNow=BH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB6DC433DF
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 10:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4BC720786
	for <linux-block@archiver.kernel.org>; Tue, 28 Jul 2020 10:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="RvvmEwrJ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NEfPLQVd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgG1Kqo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:46:44 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:43555 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbgG1Kqn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jul 2020 06:46:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595933202; x=1627469202;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=RvvmEwrJaoCwwsF/YB8owa1RE94Dhmsd0RpB5r+NJmooPIOc1D0flgdb
   5bUr3T8z5cjcV1V27TYDwHcaOwwfqnFWEvvaFK7gKNQ+3kQeI4a3Lhyod
   h1jEYqjlzL3VXUruquiIw2Iq1rAG2prcmpHHNncjV2aDtPeB/po5RuXTB
   UTzgbEGITG+7KVkJOrJy4aUMjhvM4sP9zhzgEUqt4hLFMZf7dPcj9kJn1
   /9aYstKDCwy8cnBSoS0/V1o7ETVntaZCOopvPtLJHVSPTIey7EJP4/PDj
   M3HLImuxj03VPWuIri1BhlpcbzlraHPQ8qkdL80umwxzKWyEGf74LhUMS
   g==;
IronPort-SDR: mCwWf1AZLgrSqfW6uzGqsCO8PKpwO9N/+yIjlC0/4oGyE30CEBOiDzCOCvCor7TmIaZ9p/nyEU
 r3lid1wH2ETaFgcK1y3iiSFvGfSpSlE5E17KSn2Zu8vqKu+4CLNiZXKJLiCCIgJhqwZYVjHrBu
 vJF1O9fxYc5RnGmf+sFDP1jE/5VZv5+iRy+0IAzYLoRQp81k8dvFdW6BCULVPLrXQbyhaEvSRi
 AUBcDWT4CqxumFDO+ZhP0kWEUIvFH93oUq4Sb2QVsH4XeaScFyFVOaXOgoYz41ITIFyV1fECh7
 wsw=
X-IronPort-AV: E=Sophos;i="5.75,406,1589212800"; 
   d="scan'208";a="143545212"
Received: from mail-sn1nam02lp2051.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.51])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2020 18:46:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aDU7KOHbV1fyNGmnjIyJJtQfNc9Q6yHqPdr3nxetEuxO1XCz2XyDl+5fTetjR46J2IgUW+EZnYJOvFrs2WTZ7CxHWnuOkqFnqvdisr7oUrP8BdKJT0hIkuXkBVJZZDBy82piGaAciulxsQwcNjWQqm03KBVmbGmdBNKykFR7siEyDJrPbyENHq37EblLZE2J2ouBcNGjPdXDYgz5K+XOD/y7iAetFrYJVCYqSAUcU7BXR0oQ92tj1VQDWrW524NouNfSnFybR5Db5J7AgcIN7GeIFsT1U1k+u9gh3mVorAC/gvacFaWMa8/9sOEQ+T0cP6f7p1CZEC2VOU3h/Svcpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=cV0OqI0hYwLfXdLmaKZS/Qy5509mEvtgWyrUUP2jFXcTnJFE6sNFfnYySp1MGHeOj32Sr52Lz/ARQYoRAkJrxfyOEuJXVeFK6/JweBfzBdB1yOM6QPkBp1rf6Bd3zgazEmddLkq/JZ4S1Bhqoxdhd8Pgxo0sPXgcW5DUF5zNvJDiOsI8/ABLFoI87j0e1mXehLjxMzuU9+mp6TjXOva1baZlgHgZ+nsCnmsHiLvaG84pknIjmn3yqVkNHgr5HVyQnB+mPbCjQQTigKLOUApXqqh96V0ZQXRDM1APplGqfQj2uFmt6mD9kln7RE+0YmnhwHWxyUufUDgmHXTZSNb3Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=NEfPLQVdqx5AgXrH8d45CBuiC9/xAFbeKrA0NPEHokOI3SCvNH6LAinUlHtofQTgVrIMzS2PuGTaqtu2CygCoRuQUQxNKMuC6O0R3Q5XdPdr8c5nXDSL9gnzWWeynYSbrgA3QWG6cC0/gOCRHyJdPIXG+3Jt8TZM2NFTSRt4rPQ=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB5325.namprd04.prod.outlook.com
 (2603:10b6:805:fb::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Tue, 28 Jul
 2020 10:46:40 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::2880:af03:9964:fa17]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::2880:af03:9964:fa17%6]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 10:46:40 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@fb.com>
CC:     Omar Sandoval <osandov@osandov.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests 3/5] zbd/004: Check zone boundary writes using
 zones without zone capacity gap
Thread-Topic: [PATCH blktests 3/5] zbd/004: Check zone boundary writes using
 zones without zone capacity gap
Thread-Index: AQHWZMfzXYcqA5MSVU65WQt1L+0B0A==
Date:   Tue, 28 Jul 2020 10:46:40 +0000
Message-ID: <SN4PR0401MB3598D645EDDE282A0C9423299B730@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200728101452.19309-1-shinichiro.kawasaki@wdc.com>
 <20200728101452.19309-4-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c7b0d9cf-8705-4835-65cc-08d832e382f9
x-ms-traffictypediagnostic: SN6PR04MB5325:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB53259F024341E15D524915999B730@SN6PR04MB5325.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EVyFb/qjQangP5b5siYfq0dkMS5GXd8s6v34PKICsNMGN//nG9iZcIppToDF4Vnr9TswqVQqxHV9EZCAF+XR6S2GUkX4MYcnuhIILW+1wIlpGR7ps7bx9tPNGmzJ76Lh+fqaNjWLqjGcz99NxEkfq0BhmNHQGMmFpQ290Y/qs8aI1HdPTs4jby6dqE/QsveViyRnWzrDYH0RlGm+VHPofQaO1RK9celiLZMyZHwCsEw3TNO7CfA82Es6I/oPT2tHha/dND51SCSVgMWxwMLFopiKTr3kWYPPG+WnpeuarxyJ03VEPKtW1UtZa45CTiUUYp9XgHH6XueOOYH/ngoJuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(396003)(376002)(346002)(136003)(6506007)(86362001)(54906003)(110136005)(316002)(4270600006)(33656002)(558084003)(4326008)(71200400001)(5660300002)(19618925003)(26005)(66946007)(66476007)(66556008)(64756008)(52536014)(8936002)(9686003)(7696005)(55016002)(8676002)(478600001)(186003)(76116006)(2906002)(91956017)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: u2HH1xRmahsSXZ1mlZ9ORAVccqOtZWaP22UvrkNuffMfhGdwj8KnQASfw0U4CKIy8nodhS4I/f+UTtGmTK4k9dPWqfvdXygWYlJEnvRjR1bSs2/+Qts8qh1Tl17V2y4Z/Wn7vaumC74fqUVZLe2aL0abpI0XFs5jX6t+urTsZf8x1FvBBR2MO/bU4JfC6RemviQILlkCUmo5vqyPvhTydyxFPZ0ssYQ1TTbiLRNa5uQhQybEzZdhT0+H0eFVT3LzcI1CYpJmpOB0p6KQQnq4g8+CuZVQgsn9EBG0/ww3wzQ9RhaX0gY05l3F7YDeTo4cSAy8/fUh8e5T/shzIV8CAXxSmRHTV1OHrk8Npp/xQAQaKmxuSb/NER99WnsZBEFp8nL7hEWO4QbKldPuqbFv7d/fKeJf4e7XI4zapf+ZOx1T7OuvFVYsOfsY5+A8ADdp4LfhK9wLVdgRXhzx0oYBwvGTOXdW4MHzkXtId6+O5Kx7dXO5mkNev9CgEyAzTdnP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b0d9cf-8705-4835-65cc-08d832e382f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 10:46:40.7403
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gZSZvKIPfLDyD3Ac0yEfY1LYoVsrrjRuRAZ6pPaH641ETeNOY44ICXvpYJAofzBNR9f4o2zzFlhczGr5QKDuATzc7SHD1fLhvsofNh5wZS0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5325
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
