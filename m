Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DACC388F9
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 08:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50EF4206D9
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 08:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=wdc.com header.i=@wdc.com header.b="S6L4j7Gc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="S1scTDIZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgKKIXt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 03:23:49 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:13306 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgKKIX1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 03:23:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605084079; x=1636620079;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=hJy7xIXWCeZvKUKY5HnYxTCu7A0A0ki0Yesy9DsE/Ag=;
  b=S6L4j7GcPdffh1RTj91wVdABzt6kir1q3TjTPyQJu8/gVahkP9L31Fk4
   bg9b1gZ91hDKodaKgv5noFS+NnkQOltLZG2t+Dm13ETzaLSKqLxUaUw0W
   JhA+23z0ATjmFn+HSUG/tTrmq3wt1KUMhgng5CfMiCXIGSjm4a6Qgflp/
   rtwm40O78jXmwWQIQTc136xXOAecK+GbqpfFblfp9+iOjmK9n+kp9HVmd
   /d2jCHGYEMl6Gn5QpQjZf5EcvGhacWgYeilZiB031EyA4pD29U8BUmDBh
   DxpiGMYE+tt2XursH7LbJT1I4RMumXBSZP3m/LaW7v8YMmyWzeP8zfpXI
   A==;
IronPort-SDR: 6cgix9LqovI1RN86zB2fheuKVhuixrmiEogTcwKJbMfPg6QtfvEGz6sfVdhEW2L5ghcgfaEIxy
 uMziDhtfA3AbsHEs6Jz3dSRsYaauEaT5TZeChNtxEo2Keq+G//E6WJX7vRlAzT7Tpb+wByJjMD
 2U3Xnav+sFfroxZ8wLT52GLCdeCOLBgGgXPa8WoeLPHX65YuPINlHF6c4Wp6Kh84rSRQnZsrRb
 IlfH0vHfg0HSnKGbcHq8mxQ/90Hj3/H7V6u25elhBPOGjSG9Yj1kTLpp5HfvcQRR/Z0kEGqADT
 W7s=
X-IronPort-AV: E=Sophos;i="5.77,468,1596470400"; 
   d="scan'208";a="255928551"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 16:41:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jCd7YGvSEPrZUDsGsDi2c41l/A1utCtxx0Best8F/YQ6+G+vuOoHTJXHNWaPPF3Xa54XHJtTLlUnU+4Qpsdg4NNimMe9ooe6/KBcMOWBgRVLqLHUH+cROc9d27cPnp2CbzAU4s9bvrz8m7zXBKyNgOUn9yT4z4KR4SyLv0oSnTyBXcG0c2ixTQGIY14gQyHesy3GiMJJ7o/rWWgkW3fRmP3F1TjoNDqovgXiOTbUzFqzN2yzBQG1CTKpO9lwF9AVXaNdC09g/8mjyTowhuM31j+eI21RYuoTtphR8Ez4to+DypxQ/7oYi+ZfUEenhcKn0X8mOXcjCNI1ZipPBMIzcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJy7xIXWCeZvKUKY5HnYxTCu7A0A0ki0Yesy9DsE/Ag=;
 b=BkO+dTJD+ki62hkrS6rryX5oyeG6hneRjsN43dpi+W4x5L6GgqVYjPTsiwuVubcKuhOEm0clJjZkp7MAaXwkqL0MsVWcd5YzfBy7ty12DdcTqWndileKKb3HDZX3x+rin0tzrjCSiUCkwySdwtn5ShT7ItypSO5fuTFbMUPNqq4EItqjZ7nbGBKbrKj13Efq0VlHixjcLiGzCRkfOI2hcfdffpoqXRsXTD+Yx/w4O1FUfP4MusOK3LnGigrhs2t/u27kZ/mXurE4j1imd20mguNNdeUg9qu8JmUVKj6adzk9+Nbu7t2DGJOaOLcTxdmMuVuSyIRcV1hhtYF+J6pHTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hJy7xIXWCeZvKUKY5HnYxTCu7A0A0ki0Yesy9DsE/Ag=;
 b=S1scTDIZ90pJDUrP41qA+pyBV19h2SJs8jdakAge5gTuxeeGS2j3p/nY4VLd4al9aj3S72a0ktcFlOeN2TMpVVntetTHyk/domkb95K+iPVb31DAc/7p4NrlYZdkZAy8IVg+uiCJ85GQ5ckovqLNcw5Ctv/xhcp3EEJdFZhk7JI=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4739.namprd04.prod.outlook.com (2603:10b6:208:48::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.25; Wed, 11 Nov
 2020 08:23:23 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85%7]) with mapi id 15.20.3499.032; Wed, 11 Nov 2020
 08:23:23 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 8/9] null_blk: Allow controlling max_hw_sectors limit
Thread-Topic: [PATCH v2 8/9] null_blk: Allow controlling max_hw_sectors limit
Thread-Index: AQHWt+nlNadbQU/TKkitMnHT/kAD9w==
Date:   Wed, 11 Nov 2020 08:23:23 +0000
Message-ID: <BL0PR04MB6514902E5303F646BFF30AE7E7E80@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20201111051648.635300-1-damien.lemoal@wdc.com>
 <20201111051648.635300-9-damien.lemoal@wdc.com>
 <SN4PR0401MB359885017B4CDDE95E64C1A29BE80@SN4PR0401MB3598.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:c005:87c5:ced7:ce31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9c258292-3588-496f-50b5-08d8861b0e18
x-ms-traffictypediagnostic: BL0PR04MB4739:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB4739B90DBB563C0FA5349057E7E80@BL0PR04MB4739.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tI9V/QziHizfGe4VcvDtuG+qRrBDfNc9ruWOw6HJHHrXuo4VFghn5Fxrx1RDipAdqJPeA2rFHkIrNcp6saI7f1gzB8c76Him+tdPC1Y0z5+DWFJY9c5y71PueZWqOLV7IFEEb2krKBYJSrfDyeyYyQ6hT4xvMLGLm4dQHdXImzPjGdvFu7YYAjbVQxWpMMhfmAsUECRhwNMphCHD0DZmRUVin+nyYipBM9SWR82UzdFl3eu2c8YZW7amWvmZaHQx+0ccMiaY2aTYIXJpONZz1NBmInw3DrCMqN5MooXXMDHWipFljXHWKcpU7VAOFX4+zrLC8P8QJJmDKCWJCBuF4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(346002)(136003)(39860400002)(52536014)(55016002)(8676002)(71200400001)(76116006)(5660300002)(66476007)(91956017)(66946007)(86362001)(2906002)(66446008)(7696005)(64756008)(9686003)(66556008)(110136005)(478600001)(8936002)(186003)(53546011)(6506007)(83380400001)(33656002)(316002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 6PpsiNUDlaf5Ob/OZcHGD2fCekyBv0wK3UDdq7sMqMSkYH+WGOSbZyuw1RPHxUoaThgicmm4h0WQKCW09Ez5E1Zvnz7cAL6ikMW/36Yqyh1OFBsrzEwSI/IQ56BUX9iPgbTwMMt+kcRuXYBegz8MUx8SqRHJ2Y7NfON2nwhcy5TH+YIGSpDSm3CrlWHYZxEocbSI6sBMe9FppLCAaqTOLazKSpfzmLFsAWbOXrfqH9ab2DlFSBr1Ekwp//LWi6w2Sqz9FwCLkHtc2ouWFdwPIxOJeEx5dopX9aRV5v4Rp84DLEWnDEsXfJoq+vyh6GrCSptJJUtZm6J8j1HrhBEDwQWEe+FfBWGC/1iOIVaJtipJipCtitZCZ61Th9dylM8aStUPrApuM+c4OQn+6GmTmJUnlHEWlQNw9jQeMlSvOS/0QIucBpFoUtenLwBVBy/97m1IcgKnXbkWPaEue+M83ckAkOTnk97IFwqSYZgq0zpjQ435GYX6NLnPViWgZqVejq7rfuWo2NDr1OMghA8yGrQksYjX9tBjL55TAJOFAJZl/BgCR179QtgPlkxWL9xhQPA/Y3l0EsSP23l4T8b1aM22luffmdhY2bNZfQheqUiGqXUZ8tbNj8lokB/DCzqxfTm/iUyc6Sdq8OK7M4j8wD8DzgtpKLYd8Lfd1ybhXFNMh55s0Vw3/m6yED1OZBHYcyC2zEfR33ZxPIoczl/Kdw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c258292-3588-496f-50b5-08d8861b0e18
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 08:23:23.0672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jwbsF5iWqWfb6lKXSS6G8gkjIDQmOsTn3rW6O7poil+9nI3IBkyt8TRpt1LVO9/s0aSCnceiIJkcdr2tZO9NAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4739
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/11/11 17:22, Johannes Thumshirn wrote:=0A=
> On 11/11/2020 06:17, Damien Le Moal wrote:=0A=
>> Add the module option and configfs attribute max_sectors to allow=0A=
>> configuring the maximum size of a command issued to a null_blk device.=
=0A=
>> This allows exercising the block layer BIO splitting with different=0A=
>> limits than the default BLK_SAFE_MAX_SECTORS. This is also useful for=0A=
>> testing the zone append write path of file systems as the max_hw_sectors=
=0A=
>> limit value is also used for the max_zone_append_sectors limit.=0A=
> =0A=
> Oh this sounds super useful for zonefs-tests and xfstests=0A=
=0A=
And btrfs-zoned. That's why I added it :)=0A=
=0A=
> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
