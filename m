Return-Path: <SRS0=eZc3=D2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBE0C433DF
	for <linux-block@archiver.kernel.org>; Mon, 19 Oct 2020 14:09:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5866222B8
	for <linux-block@archiver.kernel.org>; Mon, 19 Oct 2020 14:09:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="nAI8MLz4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KLwGHSR2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728810AbgJSOJp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Oct 2020 10:09:45 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:17483 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728716AbgJSOJo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Oct 2020 10:09:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603116585; x=1634652585;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Ki44p0C7lY3Gp0xv8oa5Py8ZvXO/ROvffQCfHj98tmA=;
  b=nAI8MLz4HCKyGIUdv+BJH839IY6jw/DdQ84HYtDEJccIjm/RLG2T60Di
   cMitcHAX5DWI9v2zW8zEzIXmO+I3ZWdfPVziaNMsN+HKiV4y4pEmBDdj8
   DCaSrX0t235hb1mYntC/70bp5+xGAYp4Phklh/F9D5xJoLGbem/pIgjeS
   IhUp6QCe1eBVhGhDvewd9Qlh34JRyzCWE+oDBG0jV1ugMszS5sKsK0uzK
   mQNIp638aIAT/gMCSTApb0Wmc8g4M0ZXsSW0Yt5gYMZGtfn2HycgkNWKS
   ghK/CAp2Y7kYGrafRqOEF/z4F+xEUEU8+A2L08q2VRDQfEnS1oKqzEBTR
   w==;
IronPort-SDR: u4O2Y3wRZUDKWEU4BfR/UXYt9WIB/B3Pyglj49Kw3BDRI7rSbiZOdMlMbi9G+ss5RKT40+rm8y
 GVw2Mq5iPFkykP2NfcKHZmrxRI/mQP0HD8UnaIz/Bbj1ai8kvO6r0wIHP0mCayXkrP5PUtUHyp
 8zp4EBTt1hud94ttc4zmy4Zn+EipHdZgs36MR8CU9xJHRps8I9gYm9ELxLGuDeJmMivVL+GwCF
 y9JSV43P4/Tw6rlqquFHjeXY0hQwMghKu4bTWMul5zItRT+ID7EydEe+lcOXHySU7EVdSOO8kq
 XS0=
X-IronPort-AV: E=Sophos;i="5.77,394,1596470400"; 
   d="scan'208";a="154757385"
Received: from mail-sn1nam02lp2055.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.55])
  by ob1.hgst.iphmx.com with ESMTP; 19 Oct 2020 22:09:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGQo7e0kvzA6/TZcQgAuQNAfWdIe0F+/UFdS9BINHW2fBIzC3TVSxX6CiA/wfxBn+dJMzgrriDL869lOKALnEGWb4YZpRoyHavnntNqLG7m5BU+2vmUDKZspHz7Yjzhj1ikVeaaHcqPdxkNMVG9aG6st2Ukdti3X4RCcHTEuiLO82hLBXWUZE711SanxS5K4VmwRYS/R/OevjBqMGAEuSz/vQTVh9HLjVt1H5aDiQ/fXhYPGF0pxf9jZwODTxrbRIAx9H0kxSLJZWTakMx3tJHfGifWADV3w7j5hHyKo1RsiybkkHV+5wls35DP0s07bCqwF95Isz4aNFNNtfnnRbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3e1q9BoZaQXgrj/pdSk/UP/brJzC73ZPNCKm14V8B8=;
 b=IjRx1OL4Rclhq/em/MRtnNXvkk1S1Zv2DICuPbUyUbDyGy4GqNXfudVSGNzL94z+MRtuiHfi5AbizXByrUVL2PKCzSA3LXs0OZAcPYcLvP2wKsw4InRTVqH+YJOzEkx2jniqP0eXYFFoJSndFwFDrl2DJyADDfslYk6kT2n5Wc9eu2bJDWsd5gfgmjfiir7560ld6DlKwU2+VLiPnR+QewuqVIO0hh9ldDnPy2BBYSYkibZ9XOJ56vZEFTq6lphEmg0QGuba3YXMSIYEPQ3K5EDMj+6XE5QfAXCDAr9qLzAXbEHw52BXgF7WgX9XquasWbVppYKlR3v034JFAkIPnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3e1q9BoZaQXgrj/pdSk/UP/brJzC73ZPNCKm14V8B8=;
 b=KLwGHSR2D3NmAPNuaKFgwwYYr8+q7PwHwdszyO4E4DCgWE15Q1un8V2B6hkQhO8GwY0ovLXlygHiwc4Qkck8oclqq3mADY/q2BzdjeZ46cduotX7+OVFxwZPm0xu32+5vNT1YLdVrSvia1c1oAMK8+ChnDXRNY9X6S1c1FEYuNo=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3597.namprd04.prod.outlook.com
 (2603:10b6:803:45::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.20; Mon, 19 Oct
 2020 14:09:41 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3477.028; Mon, 19 Oct 2020
 14:09:40 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Hui Su <sh_def@163.com>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blk: use REQ_OP_WRITE instead of hard code
Thread-Topic: [PATCH] blk: use REQ_OP_WRITE instead of hard code
Thread-Index: AQHWpiEFu+/IMnkTMUW1yQ9XseklJg==
Date:   Mon, 19 Oct 2020 14:09:40 +0000
Message-ID: <SN4PR0401MB3598441A5D53ED264496CF419B1E0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201019135059.GA16475@rlk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: 163.com; dkim=none (message not signed)
 header.d=none;163.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a61:53e:3c01:9550:141d:bfe3:44cb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 56114b20-50dc-43e9-5ca0-08d874389f23
x-ms-traffictypediagnostic: SN4PR0401MB3597:
x-microsoft-antispam-prvs: <SN4PR0401MB3597BFBD2CD40A35AF1E2CBF9B1E0@SN4PR0401MB3597.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2zWwM6NsGcZaSvUnud0EzyR8EZiE2PL/Skgl9YOKhcJ1hu106q0VONig6+GHwjcD445bAwu/G/j1dZzSJ3WdjmkMhbQ7MLfkjfDGeHKQFSXEni4V7seFDEpm/8RNghhpqj/sGNrpiFwt2FwktvzMwFcJZj5Lz/CGe4zUHlGNb5U3UuvzK86zptua47w0OIaBZKwNUrVkhzkaeGbFtYc8KbhAZg+/hbaJTjDiQx+6VpZOjoj3oAXc3BY+epoT3kj4w94V7p0ORbgcaioVWqF+AN/jRL2SdGuuGtZRr4pPGubXm7IUPm8cCxs1yB3tXgA4Z74iVBGNq5AxakOOA+u0hw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(316002)(86362001)(8676002)(55016002)(9686003)(110136005)(186003)(33656002)(5660300002)(52536014)(66946007)(7696005)(66556008)(66476007)(53546011)(66446008)(64756008)(6506007)(76116006)(91956017)(2906002)(478600001)(4744005)(83380400001)(8936002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: Y/XRuPa5wo/+OFn5qnHPiboocVcl3RePzE++Fecch9P/rVhwsW678CPU6redaYs4heF5zzDH2SkB9ZKkBX2Xn+O6pbmRTYclsnf25nnHpVh12f+F+IHfbtXaC62HgTE/M8jxe8ZdF18k6CM0dFB1+PoEPehcCuCWAIj619EJj5X6MDRiCTVGcM0QqJK5DKb836pB1ckhssUKjaCcQf/wchEZyTkMjXNerS2lbkSY5Fye16IWpjqmhNzAlyz206GmIC1LeOgta2SAyUNVJ7ozBkkON2HB5FPCEqTpbzJDGXX3a7sIyaZ3zfJbTNwA0RJ273JXJ+Msh0R2SpcsfalaUBq5EZis6BArlHU/k9pj/a0UxQxVMu2yjqnrsf9LILUpHxz771kB7pOkdDoa1KLWPdnQ0uXX9pASd36D8Asqw+gQcl0KKrlz1DSxsLhXNihQZPBhxAMmWZ1iOP5nm6nVepFODfczWP1b+JrSWzoTgBrdmWV4njdUzvKfodp70W32yYJ/5gCfe/CnKCJav68ZSUSO00Y9mcBqKOnqaDFup+9PRAHiNktxf/fHX9c7doM2Rsaay9vX5OphC5m7iy4jn9Hol1TpZkp+a5z50hxXcCSyu+lccOTdKBG18wQr9ioy8kTwq9pH4RZ9g2+jac4IM41kYcplZt1mVbZ2S3FPAJ3pDKz0xLRnUP/Xrot0A1CIkdh4ZzmRJv54gGSfM2ylWw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56114b20-50dc-43e9-5ca0-08d874389f23
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Oct 2020 14:09:40.8161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cFEY3tK+OxYvviypG8mHn6xtitpkGRG3GYGsmSyaqyo5QftJn/NiTUKUij6kkv0/X1/WhYl5XYRi49reqtuUlVSXmlKraYGT+pwp/akD4bU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3597
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19/10/2020 16:06, Hui Su wrote:=0A=
> use REQ_OP_WRITE instead of hard code in=0A=
> op_is_write().=0A=
> =0A=
> Signed-off-by: Hui Su <sh_def@163.com>=0A=
> ---=0A=
>  include/linux/blk_types.h | 2 +-=0A=
>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h=0A=
> index 7d7c13238fdb..7b9b02378c24 100644=0A=
> --- a/include/linux/blk_types.h=0A=
> +++ b/include/linux/blk_types.h=0A=
> @@ -440,7 +440,7 @@ static inline void bio_set_op_attrs(struct bio *bio, =
unsigned op,=0A=
>  =0A=
>  static inline bool op_is_write(unsigned int op)=0A=
>  {=0A=
> -	return (op & 1);=0A=
> +	return (op & REQ_OP_WRITE);=0A=
=0A=
op_is_write() returns true for every req_op that writes to a device (they a=
ll have =0A=
the lowest bit set), while REQ_OP_WRITE means a WRITE. You'll change the se=
mantics=0A=
with this patch.=0A=
