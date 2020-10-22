Return-Path: <SRS0=SOzO=D5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0C9C388F7
	for <linux-block@archiver.kernel.org>; Thu, 22 Oct 2020 16:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D95EF2463F
	for <linux-block@archiver.kernel.org>; Thu, 22 Oct 2020 16:36:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="R/SYES0s";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KWn1OIvX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901863AbgJVQgZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 22 Oct 2020 12:36:25 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:8403 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2901862AbgJVQgZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 22 Oct 2020 12:36:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1603384585; x=1634920585;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JgZHORJnccck41xd8A5410JE2DZoMACZzrTn4lk0UN0=;
  b=R/SYES0sVgsZ7nE2XDQ/FDhwPb0jIHua6yVdemQ5UrpT2wBSlkbRQppH
   XWg5tP3xMYQGnHiRbDnPAgHa7B/ASARxet5kXCd+cRUaQ8TRKz88tGExY
   BDKxmvyg6vqQpTl0XekI6mX+EeeMBUzxdxVUesoLdxUCADKcM2htrPzMb
   G3a2nTqZFka6sZhpxR99oCm7mUUvkvWQ/rto0LVE1RRzTGAvM2b+2wPp0
   KHzmUtQhj8oO88sExoc9c/kyFqZpbMVmMKj5RJu6Ia0Y251euLxs7p21t
   slTf33z/wF6gXi/PCzl4xGQYzXEpdrxnSlXRUK8IOgzeJOWlxtZXmG1nD
   Q==;
IronPort-SDR: uk56uZHRObimQo73CO2iQVWed+Ih8jQFQ32K65WeCvkySWPjLXaX1Bb12tyNOuaIjvwnn+EBQy
 cwCfRDcHsWa8M6M4bgRFPMvaDQmGtAH03cgIz0vC7J1A2zx/W5jz5pLT2ap98hzvFXi+GgKCMB
 cM/+PBwUw9RpqQPxcnPx0amNyJ6PaPteXDbYk0EClqPvy72J8djhmBa/sTWZF7vToK+PAo9I5h
 4RPgrH5j5Ek2Zr4W0V3KsfQx+zUKp5HE1jnLV6ss5OYlM+8ocoe7OLRSXyGk4M5GT12L+9R+1R
 4Es=
X-IronPort-AV: E=Sophos;i="5.77,404,1596470400"; 
   d="scan'208";a="151863502"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 23 Oct 2020 00:36:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxVj9BV2coGMkjo93zm1DkPYqrbC3LD5NSAwSDlV4VTROyIyuGT47B7yzx9m2P0LZ2sNa4DGx1FuHtWh6eos0L++7JVJwQQF22NEJtd1zxBNINXLrMGaJMYSv5paMPcG57EdHMzpkZr62GZdTT49+q6kHkP0K2g5dpk3Cc4FyXHIsQfc7QyJ+g9MWSnaQwLD6wEfFYvG5Fuw5xqC+fL66x3mXD21HnozlR0GWm/nngAXKN0a3Z7gyaEuoRAhweyDbKjkM9qJgUx/hxRmXhPz26amlBD1GZSqs7GqgpFhVnRxvpoYmvBoynOAR6gmCYmuQTd0C1rjIETMISPafWTqPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgZHORJnccck41xd8A5410JE2DZoMACZzrTn4lk0UN0=;
 b=CqJXq+8cYmcQ5eGXJ1YHsm8qHMkAJ8nfk0fjDBddkq/WZhKzY9EA7P5e9Azej2ntLv51AsKKLk3KJ4rwJAfqq9UijhX302wodI00CvSCebAG6QzsjgzhMXfJ7BcW+TP+xXJ46jNO3WlZ20o19lDhp+fdKvBfsxerMCAfPIgwyvNpAAzb+iKn2hDPgACGtc40iomVcdgQDzvxGdV8ku5CP4je5K8EFrbpgZuO6dfipUBOh+kUg36auhi6yeU97mZM8cKxsA04a5DHRHYi+v8lKFQumQoN2FIE//nvntdSAOmIxsW2nW5PXRghqoKAt3/+R83W6fkzfLYj7Ytq7lFuaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JgZHORJnccck41xd8A5410JE2DZoMACZzrTn4lk0UN0=;
 b=KWn1OIvXia2v0oO3Tc4RCpy39ZC3Bl4MnCmMxibWtGIgv5eaPBTbxK/wPYfGYktNd2V2C0zaAezbZkuYK5tAauEe16qbvf3gGXo0DL+/H08Ri/Rn/kBIBsVA5KN0Fzm7bNxhEUs3Ll/Q4PG7jhQXgk0UpGnPeUT0LXjvjdJBrE4=
Received: from DM6PR04MB5483.namprd04.prod.outlook.com (2603:10b6:5:126::20)
 by DM6PR04MB6793.namprd04.prod.outlook.com (2603:10b6:5:249::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.25; Thu, 22 Oct
 2020 16:36:23 +0000
Received: from DM6PR04MB5483.namprd04.prod.outlook.com
 ([fe80::c8ee:62d1:5ed1:2ee]) by DM6PR04MB5483.namprd04.prod.outlook.com
 ([fe80::c8ee:62d1:5ed1:2ee%6]) with mapi id 15.20.3477.028; Thu, 22 Oct 2020
 16:36:23 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCHv2] null_blk: use zone status for max active/open
Thread-Topic: [PATCHv2] null_blk: use zone status for max active/open
Thread-Index: AQHWqIqwkAV121eYrEaqkPjMkL9Cd6mj0d4A
Date:   Thu, 22 Oct 2020 16:36:23 +0000
Message-ID: <20201022163622.GA62838@localhost.localdomain>
References: <20201022154739.1694152-1-kbusch@kernel.org>
In-Reply-To: <20201022154739.1694152-1-kbusch@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [85.226.244.4]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 016fcc40-47b1-48ae-e729-08d876a89d0d
x-ms-traffictypediagnostic: DM6PR04MB6793:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB67936D6AC44CB4AFAE17374EF21D0@DM6PR04MB6793.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: smqrG0ylg0YIT005l+GKxzB/JpR2EDrhzDI8Z2spc/fuUqsRC+1rIdcTNooZ3vaqoWHce4tKaHTPTZgkJCshNNQHgA9yPGmERzkW4ds2NV3Xu/bHAL/xImPWp2MfFeUT5uAjK1RBnpm1jt1WH30AkprMgWE3VI/FXN6rxYT1QnmG8w+7h7GacxK0sj1u8IZQtAmRNBDC/LCn/sq2fh6owiqwd8MFner2+BAA918MmP8btT2jTfz3glw/ML02kOdJygU9PJ7vlXIfQbVVI4kBc7C6fhnUv7kOPymTBx5RzQR6H5MRaNCAT1FYRQLx4rDeA+y2pg+Glxv29VVEUor9GQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB5483.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(33656002)(91956017)(66476007)(64756008)(186003)(5660300002)(4744005)(71200400001)(6506007)(54906003)(6512007)(6486002)(66556008)(9686003)(8936002)(66946007)(83380400001)(66446008)(76116006)(1076003)(316002)(26005)(478600001)(86362001)(6916009)(4326008)(8676002)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: hYfDl+IkCF3MQ+1fmRP5N6kdUK2nTLVnfR7VpSuW/cXOAs2X40p5staCkQ30xsq3Ksx6UnS40+OAxX2FeUQambOAPyhgK/2GL3BU1CeBdIV7G8wkPU+56tQneMkp9nd2jEVd603r8qwasgoZgHUDdd5XShaNr2YP7nuiX+BfhPQqfI9z7YXR3VMTNR+tSQy97rLFK44tKalSRoR0ixi7o6WInFAbA58bbWuvjvW/NNEmp4hanry+4NLjLdbSw+fkyL2jz66BA5YP5uN7YL7IQFZG4gzefFQqOCis2bYnWYCVy64e+uQeH8ZQn6AJA50xGAb0+ZgyghSgnA9fW5bRm3IgYkWf9xfuo5ReqM7jXBiSNN06DKzkbywKAZr2X23ReHFMKbQbq/Fqsy6tsnNVvArIqT6X9qxkHtbXJq55Hi1F8zMT3dkFI7lB4+o8fWXkOSnTPqB4fl9rs1rmzEGOb5RmYtzEovUeChvPagjzHp1eDBraQiBV/UdGeEub97p5mlDHxrJOksZIvN9BcYl9gAn23ihE5N5Uc7Zjr/h0xIwPtKafD9RQDb9cs1lBe6p1OyV/ugZeZOk+7brmFFLF1AnSQZ3HS2aT7BJ2xdRCEsq/bMA8nKE+cM3/byjs07mMzHFKSD/eA02R4vf/+DbWHA==
Content-Type: text/plain; charset="us-ascii"
Content-ID: <296E4ECBCA9D7A42A0F050579A414EF4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB5483.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 016fcc40-47b1-48ae-e729-08d876a89d0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2020 16:36:23.3802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eABqBPmTclxiDug2bIsWkBwZZtcYtFoTNvrF92XF/kDLBYeoeSxCnZ9eQ6CZ1PDLqOOvwtCojyhZAzOPgXzkaQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6793
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Oct 22, 2020 at 08:47:39AM -0700, Keith Busch wrote:
> The block layer provides special status codes when requests go beyond
> the zone resource limits. Use these codes instead of the generic IOERR
> for requests that exceed the max active or open limits the null_blk
> device was configured with so that applications know how these special
> conditions should be handled.
>=20
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Niklas Cassel <niklas.cassel@wdc.com>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---

Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>=
