Return-Path: <SRS0=ZSeo=EM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1B2C2D0A3
	for <linux-block@archiver.kernel.org>; Fri,  6 Nov 2020 14:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 069152078B
	for <linux-block@archiver.kernel.org>; Fri,  6 Nov 2020 14:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="FHoM1SEo";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="B5Uahglb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgKFOYP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 6 Nov 2020 09:24:15 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:39386 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgKFOYP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 6 Nov 2020 09:24:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1604672654; x=1636208654;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Z0LG2bppeiPm25kIuObEWxF5SRsKBQthjUK//BVwzVk=;
  b=FHoM1SEo101QIBiujsSyOgJhYeeoHvF/CD7/AMRfAT9kL9sqiOkgbBRc
   xBDJ744zqhaefelTrc4xANq6WzOYjE7riV+yvoBm/rW5U0wnF+C24Kyrt
   x0tV4TdCLoA+1KWUc3125IoKNCDHa1T4gv9QivC9dBmJDHtOTAD5UwruF
   uohKF2wwzyp7OHSfmyigBSQDm/2bU/f7pHDaVZQUebNCxv9RqCD4wvlPi
   qY64XaDjIoS1lcDwcxJZtpeigMQf0qlwJIO1xNjXWj1y8Ltsk9LZZrMI3
   EkwQP5/BsJajjXnqblQPcHfFQFwWiKbSBtl2TonbPyqPxPUvnKb/gQw92
   A==;
IronPort-SDR: adzy3wUIgo6KHODpIGUuoGmYo2q81PKse9yXrdQlDyuHnqQcgcQJFwvU+o7eZfGrfxW0r/fSjt
 KhQQgczbdVAy13C9d9yvKwFCROnUfbY8conH2SZrmzDu2xXYxR0KT7tVyw287eVoUQKjocFQqg
 TKe49FT5dhkwwBxBXB1DNuv84hBEHvi/N806yDqf94+3SjVYRhynuRQRPNPCF4oWfgVxk0gOnh
 Ct5K+XBqYS+jxLOjD/y6n1BPGhJw/Iyf5w8PME43aCHFarrXqSGsU2QXgCcrMxhhvh2Q6cjvr/
 nOA=
X-IronPort-AV: E=Sophos;i="5.77,456,1596470400"; 
   d="scan'208";a="152138133"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
  by ob1.hgst.iphmx.com with ESMTP; 06 Nov 2020 22:24:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GqVcGFnKfX6WMkqVpXMCprnzqCduH5DklfGMIJn8hNsNyVAgVRvbt81H2Ss9teaf7OKMdsHSzRBqKb47a+seBo3gvJ6Ozpy7dNorT9lUiDBWVkC/nwQI3MFV1I7KvaGdZ1Kz3rB9QJxco/wa9UAaPfwOASggTO7yV654IuxkWvLZCOxRDPjRxPru9oxgDU+ww64G+GZRKFCF0tsr/n0ko6ZsHFRZWaWQxETxO3p7i/w2oSsvaJLXk3ylbv1PQMUU0sLYC/IJCAV0PKOxZOUKKMyOKTQd4htFlEK1Wb/FxhS2I4jAt1tP/jAMTP4ooIe7wyqMVmpTXR2cjHZ/2n6H1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0LG2bppeiPm25kIuObEWxF5SRsKBQthjUK//BVwzVk=;
 b=jPKlOK0WH3uBZJmIP4TWn8R1IxUGWp8ZxRTspsNjGUA5pkPo9XeGSYsIfqkFzEFnyTedW38cNmvMbo9v9hVNNZqrBeJ0VRK28n5Zc18vz4zqBGvFCQ3ryBJCdhRZ0jEy5QkcGR4Gm4YFshMJsqIGe1tMnxUUNvoHrj94weSvuzjlTIDMoxSyPOsrI/gK5fFfQc0lHiRv8oTV8oyn//hdfdb9uWtk1K9r+WB60bDHd822uY3SCyCZxCUMWXHdKUibTUDIK1U/nVRzlfkqzId6j8B26MPExLEuq3uYrk9LxMprzfzbew40gcqoWAw/RdAgjCQR1Cl9OcOoKxrjgu5GgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0LG2bppeiPm25kIuObEWxF5SRsKBQthjUK//BVwzVk=;
 b=B5UahglbnTO2wRrT+0BDWDinUxDh5KM5yWawM0kGxkI3TIrTOOlK0snfMbvHI0Ef4knlWCt3UXR3j50/7berwZRTi9yoz2jbohM/BrfYZalq611pYFmF1cDstvhdG0zOb7/nlmJxXd2b7eFMJZ8/to1eaSMSglzWzCuPnNlCNA0=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6479.namprd04.prod.outlook.com (2603:10b6:208:1a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.28; Fri, 6 Nov
 2020 14:24:11 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::4c3e:2b29:1dc5:1a85%7]) with mapi id 15.20.3499.032; Fri, 6 Nov 2020
 14:24:11 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] null_blk: Fix scheduling in atomic with zoned mode
Thread-Topic: [PATCH] null_blk: Fix scheduling in atomic with zoned mode
Thread-Index: AQHWtCw7QeWr2UE3BEOjKG7Bm7c3fw==
Date:   Fri, 6 Nov 2020 14:24:11 +0000
Message-ID: <BL0PR04MB6514DB612878FF671BD3BFD5E7ED0@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20201106110141.5887-1-damien.lemoal@wdc.com>
 <20201106141926.GA24218@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:89bb:1cde:d92a:2dcb]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 57303b91-90d0-42ee-db03-08d8825fa1b1
x-ms-traffictypediagnostic: MN2PR04MB6479:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <MN2PR04MB64790D94D485C806C56209F7E7ED0@MN2PR04MB6479.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XphA0I/u+d6EDurkOKxsTuQDWFIcpR6ObsLzUexD/SsIDqCkLBIxfnH0A4gM1Ug+mR+R51dHxqdIairEHkscqsTHwKvrs+bXiYchEL1IyHbVTZ7Xx1sMxzQjFOBv+ee146ALpVmARS8WDXz6iwmP7RZcr6gJ9tyCqIoHEv7haGTToYLC4WPlEHBV3S1Rrwq6c13toZofnuVcfl1Q6aCCtF0eGf1dTIuGnlIKOkX+QjSyaD7sRprwFcH+o28giZgbW4bvNGnp25FZX7CfJsCesdt5Ys9e29xeSZyvJ9sFCr6yfIQL2ByrUSksBmJ9Ef9CT5r4D4re7V+706cA5k4Npw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(366004)(39860400002)(6916009)(4326008)(83380400001)(6506007)(76116006)(53546011)(52536014)(558084003)(8676002)(33656002)(5660300002)(186003)(66446008)(8936002)(9686003)(66476007)(54906003)(66556008)(64756008)(55016002)(71200400001)(86362001)(316002)(66946007)(2906002)(91956017)(478600001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: yrJ8uSe1/kJUZTamwQAOp+KTXhJGswqPOVS89QRd+AkdmjFogt86IabNOFbQdYMzu/tXtUNtTxaNxPMoUnBUq3rMfULh64qVHaCG5Pp/6PTOUY6uzOdislKQQU06rAT/5dKBA2AylXxLuMP7O9Dma5AmocrQw4pRWhK04pKdK+me3E25666eASpQBVgTyJzwJ+em7KG3jv2NGIAE6CGWxKl15MzP1grqtrtg6R8d+lJp8y31XLFAm7cJSbKRFjuAdu+Muyi+9p2fiiS2vaaqaofEAn+7u6kNue24M5Ks0eE6f3W5QIO0WQCeXuHH/YSyLLWExPHXIc/88x7B8S2DR6d4Tj4UBJLoqj7g++P1skYN+/ssRg8v2ikaVuYqEFhA2PHRlPS4yWPlUcut4PvGQ83oIe3F2OKckRGGXtcbIYPKlClarMv5fzH/YHH0NyhKCqUiXb1yP6abTJBm7cVNr/2P7JAqnqqI2/IkX5r7GSwJsW9+9DtI+n7m3mDiwhE1CXZQcAA76Vqp99nqGti4Cq9mPZnSZL/nQauRm687wK5CiIXqlJnKMDiteHhZXkZuQbcBrzTyG0wIRR0V4Ogp7Z+aFvwYqUc+5qvZM9Wgn9pc4e8zqR1SC6GcoofyoB07dgKb/KURDPLNDZLn3TqoiW+l2pVBf0GaoQF2eHbkIsnwdrOQwi7r2yZZEX1Y5/HAg/tBTcuMk9H9T55PhvrtrA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57303b91-90d0-42ee-db03-08d8825fa1b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2020 14:24:11.8604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4e9uXz6Hc83r21wZN7AGieI0GrVnzcWlo/ZmxzdIuSMZYTH19+z+ed3WuwBg7vYFqclmecFjzbabbfoDaPuo7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6479
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/11/06 23:19, Christoph Hellwig wrote:=0A=
> Looks good for now:=0A=
> =0A=
> Reviewed-by: Christoph Hellwig <hch@lst.de>=0A=
> =0A=
> although I think we should address the global lock for the=0A=
> !memory_backed case rather sooner than later.=0A=
=0A=
OK. I will send something next week.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
