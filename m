Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4D6DC388F7
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 04:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 323E1206E3
	for <linux-block@archiver.kernel.org>; Tue, 10 Nov 2020 04:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oCMVQt/s";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="lyf0vVDZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730684AbgKJE5M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Nov 2020 23:57:12 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:11280 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729454AbgKJE5L (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 9 Nov 2020 23:57:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604984230; x=1636520230;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=aHQ9NOEu8/i+bS3tJ+Pq7qRRrUJYAl2mf2bEjjhHxf4=;
  b=oCMVQt/s/9eH0j6ou0GPgHIxkb0CXNlLKoFRv09GcY92UjOwUV++omeq
   Wu1LGkdtQx9j5aCaZb3jxsZzrfbrGj2qFp6C77KnvAriERU0aNUKTC4hb
   YXEScMvEhitY+zUqTyaJoTtAQsL+lo0ugY7j7HarxolYfJqUXHx25YSaV
   Eb6RRPtuexFLHqEJGKznfhA6OPVgfta/Adl5rFA+38txwTRU8KyZbbuGb
   H+yuVpP//re6I7GRZ5N3Mjc22EYkc6+oKYBtEL5HcxlLuwSb6+Ff0mmrO
   jYC5VGr50Kzfppi80DK3ZPqdJadR2S9sVTGkv6o+IECDcW0udZCmEX/Md
   A==;
IronPort-SDR: /qclr3aVeyHNiV1VszgPAnPqjW+cUozyQFIkBNXzZXsZb4kIsVKJys4X5FqZlQ8pf7cieUTRNj
 y7RSqjiTi2NT2eEUfgWrPGZ//b8gzkhHnHF+QCBJGJelRkS/bkdcP2AXaSTgUcBmt8gy2COGBP
 +onn+bzPE9xY09GWDgc118Z2WpBNcLX0RBL/qd/GpoEa1D5ZNbLQcWT12uVzzeGCf32ufPKMOO
 gPZ0ozXOCVa7pQEMlKY+MRZiWOHYfIL1rlQ432ijm1cHG4Qbyl/WrquJrzL//uBeJ+6KJPiv7M
 l6g=
X-IronPort-AV: E=Sophos;i="5.77,465,1596470400"; 
   d="scan'208";a="152348998"
Received: from mail-mw2nam10lp2109.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.109])
  by ob1.hgst.iphmx.com with ESMTP; 10 Nov 2020 12:57:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxhcjoKj7gvv7pBpX2K8Qz+n1pP9vkhpWN+Ikflkye8x9+LOyRRueyQj2emIt27t3RuOuwFZVuysL4tbmWZEYgc4+5Ok/FUV/h3pfD1pjIM2oInOtWtPQFKYU+aqztAkc7dlIvpNxWDoOCXWevXnkcVj+BDMy4GLjqmlTeByLR1caeutwvPQZm6CgIyA0RC9GCmmHGqA7WwLdNWhfe9GQLNEU+VGbgzl5u6ebfHfBXHVZVdDHCKLkaNHfT/nRIs8Sl6KYU+xcHgx6OG8loHJH8X0fVYe8T81owfbXnoMBBIpIGpFabOsd9gtYHV0V2Ixji0Dv3qjmzoC38KgcEIrlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uwuq288BuvnPpTfLsnAzjYBktqCKD9h7lgDftI4EBww=;
 b=K7+/Nuf8yWmCfrN4zvaCgkYda9Z4M0jCidkp3+X9sH0lP1QxvV8RmT52CZ8MQ6vPNVAzI7Dxe5h3cIFi5EOekZzHSucKlM3mH3yCA10YLtUKUOGXRp7K6x2SsoienTr4W+dcA72VJuQQZUx+GCP/BJQuV7Bh0bPm8AANa4Chm5SOB72ALwBTfqpX1F12FZxV2cwAJCs9dkY2HBDFa7vj2mHgrEgSkZGP3f6i7R2fB953rfFZjdFa5Wb/DlwNGfiHe7zWKplONYba0GeX6UVq7jROGqy29mV0lYPNo0LUEr2M6cZXMse9FYpCXlMtTpn0hhg7YqHyaNyL7DeoBplrBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uwuq288BuvnPpTfLsnAzjYBktqCKD9h7lgDftI4EBww=;
 b=lyf0vVDZnGA2K+Wg9gDh9GXUJzq5uSehV+cljhESgwlYcdVRw6iXd5ZbNNRVI1s2gtDoY6LRG6vWkZ/8j1Tm6trDNZawu8gEdjF46WJd7wwVvegTpGdR9ETOOm4M5K+W4r8OGify9kQnFlq3zVHnvyvNlTzxkAD/uPkZGSTizG0=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB5091.namprd04.prod.outlook.com (2603:10b6:208:5c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Tue, 10 Nov
 2020 04:57:08 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85%7]) with mapi id 15.20.3499.032; Tue, 10 Nov 2020
 04:57:08 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 6/6] null_blk: Move driver into its own directory
Thread-Topic: [PATCH 6/6] null_blk: Move driver into its own directory
Thread-Index: AQHWtpcVDO3fgjV4zkG3KSp+G6jYAQ==
Date:   Tue, 10 Nov 2020 04:57:08 +0000
Message-ID: <BL0PR04MB651412E090C15573E07CADB2E7E90@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20201109125105.551734-1-damien.lemoal@wdc.com>
 <20201109125105.551734-7-damien.lemoal@wdc.com>
 <afdd6a5c-310f-7287-5eb4-d101a531cd6e@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.55]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 14e3f5da-e56f-4e81-40de-08d885351404
x-ms-traffictypediagnostic: BL0PR04MB5091:
x-microsoft-antispam-prvs: <BL0PR04MB5091170AFBE39BAC342AAA37E7E90@BL0PR04MB5091.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: V8guzDG0SVSOdH8TM2uo8pJWPk376/RI7QQXVMLC86LNmjRkO6+ouIuvt6oq4ZgPuSkkSyWo4/6N2CVRBBPRtMR1Oa9nEGcK+358/t3YNxv4PO2xfE0baf0SO1YbcYZnxpl6qzA41iemjMT7YLOzYABPa9veqfyY/rtz9Lp1u/booEluutvSOe7E7QMNpdvvhi7STLAUm6WnVxUih/kIc68WIxRsSMrd5QldKQ6PD2BGyhxfEuQuo2cJAP1V0vEBgoK1ZTcqSXCBAYMoSZwhsP0SgpAE11HbjLrLoZz0r3y/UBbrSrYYOVozl5vVmXlBau9ijS3FsbnCvJ9nU1arZZeAZZrifzUMUItWo6sIGoEdXIrc73X1xxxFaAdFajBraKH6LEbk+YBbVM1r2AwiEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(396003)(39860400002)(366004)(83380400001)(8676002)(2906002)(55016002)(26005)(8936002)(478600001)(53546011)(186003)(76116006)(4744005)(6506007)(5660300002)(7696005)(9686003)(966005)(110136005)(316002)(66476007)(66446008)(64756008)(66946007)(91956017)(66556008)(86362001)(71200400001)(52536014)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: zJBZt/wbFiHrfHp9O5BnL6IYh0I+0+CE/Cf9p+K9+Tr13zpAf1TsVkIVK8d3qCv9poUe8fJ0E5vSwHHucKj1HVciJE+WAowKlw1olL/Hq3MUaUaccn1M/zaIJ12n1f4eKY8U25YwNiwSu9HwaG5PbSZ7G8pmyoEGPojTcI4rCuc/Vnki1AEFCq8JxYBtaW7lSlmbGKYbGFxAk2NBjUqMQromFTRpBjG+NOZ2E1M243yQSS0SF71f68Yfhqv0K9fFpGxv/0fIY9aOWa5dTh8A8rB2CUinltUt1zDJEOr4ap1Liwe5uFebOM571kWK3IufA09JiQqBmFNZGKaGpUJgI01VIkc31fXF5ESPTyCj5ILcK1SI5a03hsSzh+ODZkMdGaAXYYNG0hVzGsrqloivkQXm2ogAfHIU+KlD4r9OI36irYzigytjUeSGSZAd2f8VzTDxEKhQRXN94C//GK2CvD4tcMHnEkwkjkD58Z/mtxTMBmLnN+fn1LZocaYxXU/60USnSWugwg55EFq7MRhViFMjS6yMvZat9eDE91g5+ZzcnrIODQ5gsiRlntTIhqFIykuD2qQNoU/b+qsnoTbhwPV7F+ge9iDTtQa1cnFdg5v5N48AOSE997NT3qjytsLlwhh1tFpkG2bel0Yr2Oasmg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e3f5da-e56f-4e81-40de-08d885351404
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2020 04:57:08.7289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pZOHyU7GT5KGIDwgeLHZDL/RMT5ismMM4vTcWcsMTfyZBaEjEIAExaUC6u3roxMZUaRpvsah3hKEHUBHq0+mJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB5091
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/11/10 11:57, Bart Van Assche wrote:=0A=
> On 11/9/20 4:51 AM, Damien Le Moal wrote:=0A=
>> Move null_blk driver code into the new sub-directory=0A=
>> drivers/block/null_blk.=0A=
> =0A=
> Is this perhaps something that has been proposed before (see also=0A=
> https://lore.kernel.org/linux-block/20200621204257.16006-1-bvanassche@acm=
.org/)?=0A=
> =0A=
> Please address the following review comment that was posted by Jens:=0A=
> "I'm all for this since, but why not name them null_blk/main.c etc?  A=0A=
> bit annoying/redundant to have them be drivers/block/null_blk/null_main.c=
=0A=
> and so forth.=0A=
> =0A=
> Probably have null_blk.h be the exception."=0A=
> =0A=
> Thanks,=0A=
=0A=
Thanks for the pointer Bart. Will send a V2 correcting this.=0A=
Can I add a "Suggested-by" tag with your name ?=0A=
=0A=
> =0A=
> Bart.=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
