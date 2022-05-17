Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F8BC433F5
	for <linux-block@archiver.kernel.org>; Tue, 17 May 2022 06:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbiEQG1P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 17 May 2022 02:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235729AbiEQG1M (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 17 May 2022 02:27:12 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3673FD82
        for <linux-block@vger.kernel.org>; Mon, 16 May 2022 23:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652768832; x=1684304832;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dVXR4Gn+6idpVc6spFDZdtXt+s8P2/SfewCdQhuj4G4=;
  b=r3xZH03Ra78RM+Sp2Zx+3wj/BVN6ENVNhULBhRaIDVrF6kZ30IK7d5Va
   v/cb3hxzeAZ9NSGEA2spjfTLloBV7BzyXpLo30sgZlT8/V6Wc8NkP4Dzo
   PmcuhbHXqsbdsGsP6nYT0s+2hpo5wgLvSIh3+ACeg6aA4mAdf91fzQyKu
   Jn2CHV700YlDuA16jqDXeaQngH12nw7QLpMxezKCj5Nciqbf0O2ic7luJ
   7osNsaTcCFiZalqb02WvyTYaqvmKdOzTXG1dTXgFEFjHLGvtBcslegonc
   rw6374thPPjrJr4xFsT3OZweI7sNgqFIrvqPrfRTBP/HtJzc0ZOb7zurR
   w==;
X-IronPort-AV: E=Sophos;i="5.91,232,1647273600"; 
   d="scan'208";a="201383887"
Received: from mail-dm6nam10lp2109.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.109])
  by ob1.hgst.iphmx.com with ESMTP; 17 May 2022 14:23:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTu7vsNUOz9nEFGupkLW+Y38ND3XOb2OXBQhrp8AyRotpUbHyi3zY3hrTQd0Wef8J5Z56LK421HQmxgY1qropl5ME93Th2ijvEq/bbmbsoAgXeQ9+MUs6fqBL9R1ReBg8kX+/0lHyUlRwgz6eiREZaS8EFQnmSCX3FXRLCZeYxttr6GzuiVrUn56aeMaInrtRpNYJ1iyJvKhROJ4GVfaRznTRb0+iJ8KSctf1W5qS66te7P9+6yP7c+anTjCtkE4wHMk7dhzZ6d1SZxAZybFULiZI7a/0jngBNqzgxbDUTJWXu5hhuX1aV9x/jjxj9k6Q4VSNHMj/NVaGsYO9dAXSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QN2ey8+wVb6YMA98t1jL02nSQNSkVv3x+/1llXv7oTE=;
 b=RQx7/CjjM+epohY9jQ5yDBoelH7uc3wukMpXCYngFDH0p6yLgHF01bX9m/WPwQ/mRAmuSZ9LoH+jYKonQkHwdE4kWWoVXT3Z/0KBp1O9NQaYK5Tj7pSQ8upRX414gTLNF6esRrKyZUGJqy7dkPUAS27XKEL+mydn6msL6ipVRa9u9LNzpl2K1xYP/vSQrbbC6N5Mop2FDJxhM4tq3xdTrBBTOElDuUk7la2Lxyr6fw/wHh6Ccy4RrvJ0kx/v+WhM+4Xf1BgVIuj5nY+jJ/EgRiAWI4x+VDiYke7TR/6zm+eTgZ1CjIekmAzACtuEXzyyfdavWwGkT+BxZBi0Wj/ENQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QN2ey8+wVb6YMA98t1jL02nSQNSkVv3x+/1llXv7oTE=;
 b=TUsMg1+27HgFiiPeJ6/6IFmY/+VE/sRNP1yqeqxPYUqbFhgR6Yd1sIqhO/8DyZWZF3LW0e3CHAXH8a1MYlPCE/qbIbCnPyW4mZel4FttBArsr2hmskhLB89/UlBl0uebS56GO6fBnAqmXgyAaEITDbufzW14hQ21yVVGUwFTMvk=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MWHPR04MB1182.namprd04.prod.outlook.com (2603:10b6:300:7b::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.15; Tue, 17 May 2022 06:23:40 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 06:23:40 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Alan Adamson <alan.adamson@oracle.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "osandov@fb.com" <osandov@fb.com>
Subject: Re: blktests v4 tests/nvme: add tests for error logging
Thread-Topic: blktests v4 tests/nvme: add tests for error logging
Thread-Index: AQHYabamOT3HAL3Cwk2VTtCzj2xn6Q==
Date:   Tue, 17 May 2022 06:23:40 +0000
Message-ID: <20220517062339.krjab3yfex5fvnes@shindev>
References: <20220516225539.81588-1-alan.adamson@oracle.com>
In-Reply-To: <20220516225539.81588-1-alan.adamson@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cefdb3dc-2768-48fe-f831-08da37cdc902
x-ms-traffictypediagnostic: MWHPR04MB1182:EE_
x-microsoft-antispam-prvs: <MWHPR04MB118220C8E2F4C8044471C1B3EDCE9@MWHPR04MB1182.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wnPAzDT4HEVy7lUipxlIWZyU9jKbf3iEhikHVK8Vgj3DXEjYyz9IIdEmBjsH8BET27dhxyeqrM/bNcL2asgPU9ahAjQNHql7/Vb3SQD5DHfIqtHib/zeHjJkk/2ZN/N8SDGMPzTs2W6OPKPGmVmA0JecnjqMlq6iEVM+5Bo7kZzrL15Mqudjb814gX8J4vv+bRJGjU3rmqC8Athhf49EfFWlj6Gq3JuzEOFu0n3UDBeL6UsEAuom2/zeEtS/B/wfMWyhYMMinhSyodfwQnembCfYMOkSaO16BZd2J8fZ29/Bwmk2TC5+KSs14FJXssfJ4MMHiRRJtaFR/FnfH1c/SPVAs62mZngFFZEiS3UNipkIzG/cpkp4LJliBrRakSdKs01HwJj7HkMaDrBL6lDlbiDl3/tHK+pXvHxYNOdohUBtcLz5dyXY60wko7IdCcLvzT8hXK7SRWcspAn3XKWo81fYcjMfytBJK7D/v2mK9zdV6d5hR1HEaSlAvnntFthkdok8GBBX3fHWyysgFDI97ArfAvzd0gjB5i2P+0/D6P6skXVvj0HNSfIINXw69WfnUCCa0qWeSfBwFLreKcE7LKJJT8FgWTt0yOm3DNRvm7ggPxL2vO3ssroMhKaCjWZUEAy5SeXNAFIBbHihtS2T+rUYbEFq50VmUn9qgxkIsiHxurz4PFHAnkDHT9cD08AANBbh+ktmAqZinh+BaiE5iw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(2906002)(38100700002)(38070700005)(122000001)(186003)(1076003)(54906003)(82960400001)(9686003)(316002)(6916009)(33716001)(6512007)(83380400001)(91956017)(86362001)(71200400001)(6486002)(5660300002)(508600001)(44832011)(8676002)(64756008)(66446008)(66476007)(66556008)(76116006)(66946007)(4326008)(4744005)(8936002)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?JFlW3xfuRE1mVTGNOmyI0SJomY1E2EFiS55snHWZopOqmrcSKJk4SzXln8QC?=
 =?us-ascii?Q?jeSKXDq5Dd9FRjQ1HddK5+BtxRwONGNIdcXjNPG8nxwJqZbeWtkBUmkyGVux?=
 =?us-ascii?Q?xUbCKTLLx7qHt8pabDmu2ZIt4J+fGInvKWzsk9xHBsB6n/YxlrKpGZwsHuWp?=
 =?us-ascii?Q?rrbgK29DcU7vqTiK7p3yaK9TjdTy6UMbtBX/Calec91roE1pmtPDgqpIB8Fi?=
 =?us-ascii?Q?nUtaMSSk88GKY11L8Tj2RjNojnn16clsWccGgrnnGmmwHhEJKr27l/8GLN0H?=
 =?us-ascii?Q?aBSuTFhicgI3aLbTkcctc85n+wt99PrLHxpJty2RZfMn/N0s4Ba2Q777CCAp?=
 =?us-ascii?Q?zX5b7Drt3ok9wXOMr+zHZenoimkybf6ODIW25dQpT+49E1isPSyYDgowN/8M?=
 =?us-ascii?Q?S5gfm8DurpqloHmDMBfh5Pv1cuPgo1+nklyGbObL4XCw7yXsAvSfGdyFJjFU?=
 =?us-ascii?Q?fz1uzf7m+ifjXRLzWgM6Bq2VG7RWtqrv1D4mapQCGIMdlqdIgcW+RaDm8HAN?=
 =?us-ascii?Q?fsJxvHp4zryS2We3Jfyfjh6+64TwIfAOFnUROoL7oEWQC2kAlpWqNQflJJyY?=
 =?us-ascii?Q?yCJVNhr6yPNAUDkKunNoqxLJZTJH8Sd1vh1/T6mSwXyyV+dS8xs0HVVHyqLr?=
 =?us-ascii?Q?67cDEZY2OrGktbvYGK5RUBwIYD3hUPt8oAaP7qWry14bYU1lDiWey9g6TYlS?=
 =?us-ascii?Q?yTbSVmW2WW/Y/+bsiPq75gfP5VnwXlMZ3tX1nDgp3XFhtVtMmeDHZy0ph7h9?=
 =?us-ascii?Q?k0leUYMLJ28FfBtUfusfefEWtxGcJ3mef6HpISlQDEtWCFTtP5G9+23LKYBL?=
 =?us-ascii?Q?rVwhE7PaIguqTNfOx4amkaJFfpD40F3bcrElBZ1g7ua0UHo2i9/hVQChbC38?=
 =?us-ascii?Q?dkmJDcixJUPuGZ3xnJLPVTgG/x5T9jlbMviB9P13fKYXJisGo71BA/ODEvpj?=
 =?us-ascii?Q?ZPB6b+I2SrjOSl3ctMWdGFhzF6Fz+dKjLpn9Yr7j+4zGtdPYBvZrLSyzdN5C?=
 =?us-ascii?Q?SbK7jIzY6YGKk+S6oK1ITx/2N+5mWT2acroIr+MRffILqA/u/r9oPwFyFOta?=
 =?us-ascii?Q?32aEEPebgMj75azYf3aBpWIcj3in5nUywxmgYOqJzX4ey9+l+ylM0ezH4IoQ?=
 =?us-ascii?Q?w+TXXLU1LPkdxbhxVkdEeUMMx2DInGufCpMeEIzvX4hvze+QLj8fVtkVh3Mb?=
 =?us-ascii?Q?5JCGt71o6LJ3c0AWemVtdNnXNA+NuDHasLb9J8Zr+mIZFsfcqD5Oyj3DK+sq?=
 =?us-ascii?Q?pBuTYHtrJNuM/SBCAq0h+H27IFv2gsC2kObFhFzHMkntYeaZrW49GLRsl6/V?=
 =?us-ascii?Q?t8doeG5QV2n6rzYgrI3o4Obyp6cuEkKBq3NA80moKW1oNAWI8v1tZksh9TyO?=
 =?us-ascii?Q?grEIMrXzw6rKfkZtly6mcqAwAbI+81slwb3lp1vCLD/piWwSauo9T5UqGLF4?=
 =?us-ascii?Q?5C6LdHwoijbC4ycIdmvo9xl8NL61NPdIAAdZ/7ViYg681JwVZW0FdQndKKH3?=
 =?us-ascii?Q?DYCvDbuOJ41HUvuE7IOrJM++ZQBRxpShskLkDak0c2eiokaIgpnmpHiPwgLY?=
 =?us-ascii?Q?Yigjnu9HvBQtX/Tu5LkBOoe3nO+7095bEziWW+NVfZxY22EAxOJ9Q9c44V8P?=
 =?us-ascii?Q?XLeg9WGFT0UFqIk1dD1vW73MWhXCx1g5Wuip4tQx/Ebf88w2U93aCg6rY0cc?=
 =?us-ascii?Q?eAqyE1yP5qdj28NTrGcXYPmWxq1HDZcyyaBy3GI7TSBUkyyVt+n7xd76C38e?=
 =?us-ascii?Q?2TkRvD2xazzfdB3dVIMdfR7LdbvtiZCU4NLjDrITHWMSdzy9rrci?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B0A0D7132075CC4CAF958828C9DFC37C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cefdb3dc-2768-48fe-f831-08da37cdc902
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 06:23:40.6428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GDMiM+j5XsI2lWl85oZdwKfcFJy1NLS+erAKwm42R09Q1orZpI/7lCF/6iXwA7I3ZNQcs1QXktj2xNdXdHGACacrj9ubAbhk0ivJLYOILb4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB1182
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On May 16, 2022 / 15:55, Alan Adamson wrote:
> Test nvme error logging by injecting errors. Kernel must have FAULT_INJEC=
TION
> and FAULT_INJECTION_DEBUG_FS configured to use error injector. Tests can =
be
> run with or without NVME_VERBOSE_ERRORS configured.
>=20
> These test verify the functionality delivered by the follow:
>         commit bd83fe6f2cd2 ("nvme: add verbose error logging")
>=20
> V2 - Update from suggestions from shinichiro.kawasaki@wdc.com
> V3 - Add error injector helper functions to nvme/rc
> V4 - Comments from shinichiro.kawasaki@wdc.com=20
>=20
> Alan Adamson (2):
>   tests/nvme: add helper routine to use error injector
>   tests/nvme: add tests for error logging

Thanks for the updates. For the series,

Reviewed-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

--=20
Best Regards,
Shin'ichiro Kawasaki=
