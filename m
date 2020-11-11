Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B9E0C4742C
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 08:06:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 167E420786
	for <linux-block@archiver.kernel.org>; Wed, 11 Nov 2020 08:06:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TKViFuqj";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="k6cqULjs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgKKIG1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Nov 2020 03:06:27 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:25702 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726233AbgKKIG0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 03:06:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605081986; x=1636617986;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=TKViFuqjbwO0QeKLdJz/tnKkWjVP1v4CoEVgvy4IaS6rXDBAoFSLNHVh
   2HS9GC30ruzyjWOV7IOToAziNDpao5Skf6top3fXKmCYT5VAotkDwl8z2
   1Cm5NYHrrt+Ws7UHuhSoqCjZcGUVBbV2MNjDUakdSGB/b06D04oqvCeBm
   M9Pz4/xkET2HCYKkEcw4ImMYmEZPUQYNsdMndhpg61UEAwdTjdyHcYaza
   /S9VB11HwSuPMoUsrBQoXTP2uWKudmEKtAjgnEPKJLPWYP/1LpeJAUXUD
   /IXdmmELWaq+CP6nrynIApWW3LqjGtJPaNzv4puWL+iN7gntXxoUVwjQ4
   Q==;
IronPort-SDR: /iNcUDBW1rlgDIaBrq2JBgq5MKENFC6bYoEY7VmI1qo0fjsZcYDmkoJ4XLYrDyvdEU1ldeQvn/
 al3PrZQxuMdy8jBbYn16OovKgcSxYvL6SRtm+0PDIZYEpFiFvxsHsNA+YdOqLKEEuPuZk2CF5b
 YCsXS1qob0gvrHAXkN2vCHfxB77ctNEHRVy+E9CIQj6wQkIvnY43QVACejDbYT1N1BmecuW9/f
 Oa1ALHwjiYmrZA36mutak+H7cAYAHEThDRutFgU8RYoIlCMePXCMvj7qe2escuCs+LQR+/Tr93
 aNw=
X-IronPort-AV: E=Sophos;i="5.77,468,1596470400"; 
   d="scan'208";a="156849894"
Received: from mail-dm6nam12lp2170.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.170])
  by ob1.hgst.iphmx.com with ESMTP; 11 Nov 2020 16:06:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h2q50QgOl99Yv+E1I1ozvjPpXJFk2UxbeE40IlUX2vikMyWdBPzaErKZvRcyEHeITgXXu5Ud5swcwcfANMDjGLaGxdrsuc+W/YeAC5f4yLv5VP6InrZwbfCg8GqiTw8st2GKnfE0T79g2eX39XcQFFt91aDxjac7JwS3WRBmD2+NGBbKq88wAKKSJdz8f/oRXi19qiuOfwg59Qq/AnDJ1D5SgrA53xc2GvukIe2lG8iOq4me9nekTQOw3M+fEgSPJh4g1IMpTQyBnZgtkp0Ew4Zi1uierEx7KtQl94bZKwzvBRaxUbv41Um3rxMFF7nZIddWP3LrUBpfGB9ClDeUSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Y824GDX4oD01fgDP/9/9Md6BAmHRa2mr20K96ch4HZbwQBU/jyE0Cg75aj4ENybba4Lh/G98EWcXDHu3iBaGcg2sXujYCaK7jJt7aEiYfYG1F3v2OeADS+lTC8YsgFR+pRvmMDkWyD8EROrW9u2i3ZBcgOmK69Na7Xor8lVKLb7P9L6O9T+yfgj8gogT72FFhE3AQhtQYRaFVZVutGboFzfLTYHqzNchYKEl+qrV0YrI5NHsZLQKKPRfw2L/WGRJBpBFT5KCd9JsgDvRNiVGfu2s80qyE3/x0vPAwtztPIA2teLSrKsSRqC4MC/QiGfZddXzlG5Pq3BxUISW5c1giA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=k6cqULjscQD3KHtSqiYbiQnJUD3R6Hn8VnId86PKdEC5ddF0tECDSNNrM/Dkxv4rWfgooVN7k7zVrkj6qG5Cy6PYH8uhM26UmdutaLlhS7IBfY/IrlNmNdqBwplL6ygletnfPMColsl+Dp2xUqy9RfAw8HCgN4imfqvmn6e0jH0=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3677.namprd04.prod.outlook.com
 (2603:10b6:803:45::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21; Wed, 11 Nov
 2020 08:06:22 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::619a:567c:d053:ce25%6]) with mapi id 15.20.3541.025; Wed, 11 Nov 2020
 08:06:22 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v2 1/9] null_blk: Fix zone size initialization
Thread-Topic: [PATCH v2 1/9] null_blk: Fix zone size initialization
Thread-Index: AQHWt+ngRNCZKzuraU+poUY3ZnCO/g==
Date:   Wed, 11 Nov 2020 08:06:22 +0000
Message-ID: <SN4PR0401MB359826D5F104C52376C17A2F9BE80@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201111051648.635300-1-damien.lemoal@wdc.com>
 <20201111051648.635300-2-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7cdcd47c-ddfd-4c5c-5de1-08d88618ad8c
x-ms-traffictypediagnostic: SN4PR0401MB3677:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB367774B68C1E3E012BA79A169BE80@SN4PR0401MB3677.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LerhErMv9H7g5KG4nFoY/p8iccJz1yGmAYAYYkf+tNYougrLVTxBdlbGpscFzQ2Ad1NmXzK+m7akW+MR6/zaEHxLnYTWTv4B3zvBrz3wJ+TN6mw1bUfCgyc6okrMoXiDInmLy0BXlhPZ7OzvWTK0nEiYuaiAVT8bQcVrXo2AnPvf09MbNWwf52jhhJojo7naxVYKHQPO1p6k49NS/7IKaCHmsmvOUswycjV5fe1usk3HduIrbOo5g7UyFTiuJxEtT7qcABXGMbSTWFBIzY6m/mAOoTq28pXBN+Bc2mY701iPkzG8JBCxNMdKKbazR3aena6CazLbgfcyu4FeNnzZkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(366004)(39860400002)(396003)(66476007)(66556008)(9686003)(4270600006)(110136005)(5660300002)(558084003)(86362001)(316002)(52536014)(26005)(71200400001)(64756008)(478600001)(8676002)(2906002)(33656002)(66446008)(66946007)(55016002)(19618925003)(91956017)(7696005)(76116006)(6506007)(8936002)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: kQ82OU0rdP7bQIRhxywDgULXik4nkL/MUiBJmMS8RWojoA21mAeO10nvs4snghWUwAMh22KflaXd3O/z6Lt0N2lX+Ei/DQ3tFdk4QhUPAXr7LsCXYbqEZ5EpfCXP6OG4P8z1f1ux4EeYcS5jYIgJ4j6uWPTL4RWoUc5YAEef7Jz3nJTXXGIFz0v2DzU5eIfryjoHWztldtGtIzL5HIlo5q1UZQemRrTBr8YUPb5o96Wzj4JVXZ0HWRYV+Y10nwrW5/ai/tx7HcLZWx8668sZ62LSvvMGEyfdG4PPcryg5OYFCM6TUnhceo8k+OzUTn/96SEqjPpZXpDXljIQQq89EHL7Lum+xW81SOIxfpDU7Dsi/SB/k/URaNlYWA6i8R5uCjHGmsC8i1gfPtTFEeUGi1+OFuBoN6rA8ee5+sAANrHsw/4gY1FIk/9Gw2A+7CVaGIsy4fzW+4h7UMVpNm7837cyd4SZtQ34o28GrN/F+8nqjB+IFqtRZ3bGLsYhIVNEXOE1iy25o8EIkEXj9RREMMHhIgTsWlZ5b8qQ0Za//JwUkKYMiSkYEuvoij2ytAgEvdE24gFE2oNjIFkYxuaLIayPtJ1k0StOP88Gw3ci64YfTjCQq/MFoEIeHXVjTvJYbbVWcdYAla6W5bWKMjmygA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cdcd47c-ddfd-4c5c-5de1-08d88618ad8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2020 08:06:22.0527
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q3nfsiGAaIZbw3rzMZVOcoKeEewrPxpfBI9440WiI2pWQWHMvgLCpf5hcQ6c5jaXr+qvgnAaVA4yXDa5jIKt05JUAJL7P2IcmAfabhNSbZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3677
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
