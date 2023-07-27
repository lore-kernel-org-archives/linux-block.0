Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB8EC00528
	for <linux-block@archiver.kernel.org>; Thu, 27 Jul 2023 01:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjG0BkM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 Jul 2023 21:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjG0BkL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 Jul 2023 21:40:11 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D93C1FF5
        for <linux-block@vger.kernel.org>; Wed, 26 Jul 2023 18:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1690422010; x=1721958010;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=HwZbqIQU6ezuDMKA5/e1kKcwpNxHv8/jdGuzALR9K64=;
  b=Xys2p7k7Pv3d4iPkC0vtixgoueiWAFO/SGmj4DTyfGjtUWoPJIbqtqke
   pUPem1aqqUpYsRoK05IRm/hniLTwtn+nKdQTp5fAjAfsdEVowbSrZDrzY
   9x5YfRHSXoDYT2XxlkHoGZWN5iKLAUjY9qV6ATC4wd67z6CDsFtbjrRt2
   M/dawMr58TLTZWeS7ICGZaIzLCGOlGfgmml7EPUMZ9+Ex10Sv7F9VB3y/
   8qZhSd7rvRyxjNAH35kbvpC53RkK0Dro9S6Q27spXBphfFE0CkKERMViW
   8sr+6GQDFNPw6+Xig5f1XzMvpslqKeDBA4BAj48AWZkz91kCzri2o/3jS
   w==;
X-IronPort-AV: E=Sophos;i="6.01,233,1684771200"; 
   d="scan'208";a="243831771"
Received: from mail-bn8nam12lp2171.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.171])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jul 2023 09:40:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hy4oiCwM/lshjPhczGH0vthN9Bl1gZpMsI9Yrr6iD4lZX/KGEYLLyx14AW6qy8owFBd9itnkagqXNwhwBxxWrg1vbRQLae7b/mEzBLfNIC9iKBskY3Zsmn2stdSRoXwR+1fN9xNI0QZQMacsySJ7XacdtgouU0gBJoNgN3T1IfVqBCYVfIAJiZa2NlK6wrPzvCyMFquAthn9gJHj0u9Ae0TXlBzpLO+qUiq3eiwXXePDiMYjcjLUc94a6YKNi8wsrLLv8IEmrnDQNRoS6M0F1mHDcORSs+IwZcBy5AAtNEAQiqXsP7U1bgO6kEtlViDpg2FgqGrdhL5uBz4303O6nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwZbqIQU6ezuDMKA5/e1kKcwpNxHv8/jdGuzALR9K64=;
 b=Jr7G3tzvCEWUb8iMteMJ3m4x/rzw91RUYFSdZXuwViQFxlOKp94zn7jzoOBLWQRYKovHQ2ZlGO2Iti5lV9ZF0EQRjrctvk72e36EGmQsSuDSZAUhyA0GVbUPxXVPXePxjZbMCAK24ukJL5q1MWL2qGphWBR9VAfH+JskHtTy01ifToDyLjF0PT3sZvpmvThqgdewB+53CD1b5S6kTUs60kVUqco/J3+/fDGcVzA4FCzdeaW5H3QWjuKfxCk19EZyV3HfbwFPgWeTC8ltyOogZlSTXB0GJpdrVBKdB01r/d4MfisPf5nuEc+BcCHDOexpWhnsEtJ3Qb1XdDFmepY/Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwZbqIQU6ezuDMKA5/e1kKcwpNxHv8/jdGuzALR9K64=;
 b=zpjh3KcKXzTDqewhVvIlDZsc4PlK3EmxxEu027oQg6R0FdJR1Vd6cDDjyiRVB7iUioTEMuAyqPR4+5vyTlXOa0kt+0SOd3C+y/lneR8p19RCuFbm7PTBZ3HMivQpqC1OFxyov73IEfUJXoT5UN0wmJeCZAWAdCcWzLKHBNnkrsU=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CH0PR04MB8180.namprd04.prod.outlook.com (2603:10b6:610:f0::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.29; Thu, 27 Jul 2023 01:40:06 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 01:40:05 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests 0/6] fix failures with bio based device-mapper
Thread-Topic: [PATCH blktests 0/6] fix failures with bio based device-mapper
Thread-Index: AQHZuhDIG9ZzXCPxGEOLtktrsRFNXa/M4lKA
Date:   Thu, 27 Jul 2023 01:40:05 +0000
Message-ID: <enf6lrmm3xozoriukkkbpj57mkuc5r7z6h3dlcapvh7zwsdk7w@4irlrgzjevbk>
References: <20230719071510.530623-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20230719071510.530623-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CH0PR04MB8180:EE_
x-ms-office365-filtering-correlation-id: d242a0ee-cac7-4ec2-38b7-08db8e42672c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 02F0qRi2Buto45mziwLz/UU0vpf91RsqL1om990Bs5GMLUXNDrwj8bQAb7Wx8FVBYc7Po34J+No7X46XZYdaJFRqycY5G55TqOHKJ+jzwcbHaYNsYF7gO5oPWmj6VrpNGA7UilxP99MxG2vDr3EqFJUdzXdL+oLRBOcENLH3C/O44KAUMzR3VWpASiMNvY54n0aDa/yWE4j71yntrZXa5FrSXPx3HEKowjKVcWOwo7Ki1f62cai3aFjayo2JiwJfGjbH/NT6U5RnAYHsZYhSvvcS1hMDwH0BTdHz1r8KfW50xzc8WK+EO6G1lwaTF/BlkET+oVj3L4HoKIGveFi0N9Nhw56p0TvrayJ899RKXGnpPfSZNcWjWkZdO6bnLDQNQ+Hp4MXVaPtl+v/4NBoMxZzwNHtOECrz7YEwR275u+yaydbc4SKrsULCU/mYbsi+GwQrGbFdyHOoD0chyiK6oOPaOOILZ8sdspN/Np2fYhSVUXllf7gnsMrQ1YXzzZ3Emj4ph1ZsEa6x8U1vcRxNFBthWKIgpHBMU9Afq+9XCUzpOsHg8x0x5L3g2LJb3L7/ZSFgDIBijMUOjbPR+xAuyVuWGrBXaCYI0JpfWcinRh9QDJHxE9QvWeHh6qcP9RRy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199021)(6512007)(6486002)(9686003)(478600001)(83380400001)(86362001)(38070700005)(66446008)(4744005)(2906002)(66556008)(33716001)(71200400001)(66476007)(186003)(6506007)(26005)(82960400001)(64756008)(122000001)(38100700002)(76116006)(6916009)(66946007)(91956017)(316002)(41300700001)(44832011)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZamDObS8TdpOiN303HS4BCE9RKK8vmkJe23Tt88lLt5azEx4fElWKhPyyfVq?=
 =?us-ascii?Q?LFIOwu5zD8aTgU9XLmdQP/x+w7yZOs8JvXsSKfIr3XceFfPRKXJU/yRU1RSa?=
 =?us-ascii?Q?FT/pSCzxf93Lh+1KzZJlZBRq0bzKqHXDtU2d81rMlS4XNE5pqAby/7yqLMYd?=
 =?us-ascii?Q?YvBkmH1y68InRQCH4/9TQX3LRhpi6zKNKstAeGnRrCm7MpesNTa25DNh6i9E?=
 =?us-ascii?Q?9PIkKuOlk/maBCZMH9HMLRrsEyFBrtS1uo9uX4G4mNLIQtf8j26DhmsgCQc4?=
 =?us-ascii?Q?nQEXElYDRdHmGN6X0spRUMHkvVdTQIsT8mTb+XAiWw65rNzd+jRJxFTPFGeG?=
 =?us-ascii?Q?YWqD1Ql+RsYgaISg+M8x8jvvfbQQf3PDdB5DI4cVhf4f849TL6Bn3qsb3Cyc?=
 =?us-ascii?Q?sZXqHKuw2Y1LyMFlNqvODM6vNhA1Txwi4Ppx1Z1uFNx2Jg5bjE55BfyxoC5F?=
 =?us-ascii?Q?R7BPW/mxiFLknr6+5gmXUjN1W+xBLF1pgfDdk729PwekMPjywmFqAGZ7idv3?=
 =?us-ascii?Q?l2uT/e8dCZqTrl/kkiWFcSET8b0WEVTVykfBWFMxY2GrA6o9TpANhD5VkUYP?=
 =?us-ascii?Q?3UFceGZGbHKjueBKLCgezyzXZZKy4gu7NcrNW4oYXUbNiZTL6YmqAKTaUQSh?=
 =?us-ascii?Q?27Wqjh2kUl0iB4LVpB+uvIvKYJIWEwA25Ir4Nh9yN/x4bqxIwtaQghiTpm7D?=
 =?us-ascii?Q?EJoeHyzSvhdoOga3JDri2vbHspnKrtiAWU1DoGlJPSc+vXYQknSfk2s37/m9?=
 =?us-ascii?Q?U0IkEfC1MKvffZ20/i4CLWC63w4hR72NwZ/itol6i75aNowgnsOdt5yPOtLM?=
 =?us-ascii?Q?ekZFmme2O1ldmoMTjqLjkMj3hONkBR4NPjll5WezG9wBpOL70i03j8cF99Ta?=
 =?us-ascii?Q?n9RGbC/qBc6Eqp6hTnNZltfmo5xCxSoJHgWd1t+7uvhZf7cGDsFyb1c2FwBJ?=
 =?us-ascii?Q?6mVHNUitcZcTTcaoPuf7WqipXJKvFVxU5HY1qIlcG/51yafHBAybPsPSwtzG?=
 =?us-ascii?Q?dNLIWaeUyw1hGs4CZqXo9ZNuKuy6hCnRM+NsUIArHmTB4l1gyf3S2cvJGbPd?=
 =?us-ascii?Q?XCkQpdvjxx9M4ljjQdvqMvLSY0a/1jVxWiXAXr31uMEsKgda/ax6/vbFb7Vl?=
 =?us-ascii?Q?LO0H+LRiuLacITZDLKgvPOGQkzJLHuPS8piN2k7CDoMMoIFenfbb6rZl/hE8?=
 =?us-ascii?Q?/tHFC5GEwL9fZOpqrDxolddPkE5SnVbQqSiEOFXj/Rv8KCFukoNe+lBC1uWP?=
 =?us-ascii?Q?VEHVXjQ9o7OlIa3mtSwzAilbXbRFzuXIrf39p4sOwsBtV1DPYWApM++HmWVc?=
 =?us-ascii?Q?+6Gq55vDJHG6F5UVBdXHCCoPaWy+96UAJiZeUkzQA25Yqa9IjpOJ3P6qQj6i?=
 =?us-ascii?Q?QQ2hbFlXfqOInFkDGB5JkV1929e5/+SFz+lNlU38g9b+esPS286//NOkUCeD?=
 =?us-ascii?Q?OGbyjmM9zylkcRlvVbeQBgdrOKuxzVYlYItpKo+u2aNFZSItZtiA6NfAiDIu?=
 =?us-ascii?Q?9GpcxqPGyuINQarhoaQKeZ5PWY1z6LRsBXuOBZwEPG4Sg4SqHtkdNfRxaika?=
 =?us-ascii?Q?UouhEbceq8zr/iCOI66KBXf8ZxZPwgkXwqC5HsT+4RhRIofcZvU2x5VQUNq6?=
 =?us-ascii?Q?TdMjvMXbLBc0+CW8NAi/2lw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0C6A07A88998D046B7A6AED4E206F8BA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: RcxKw81SDnfM2G4NrXve1GLCObg+1aDjmgy3qxjKlJCnbim0nVCsq5JzaSrJFQ7WAa1VBJb+Bb4MPPAVTXp2tITfFO18zJpAvGx/hHTZ14JnrGYZtrGpdXb945ND0W8tydPhyv+845/PgmmLKjiWdh56LR6tXOkVDy/tIKxO3VucVGDYQ2y82UIifOk23Iq7orUxF7auRlyivqT5SL2D6uSJCZzf8PcWRJhaE0bNeznKF8N+lr02XxblATTM5APfJCcdCdejo7Ms7OLkiTL+3EehgaB0afjdZKcCgktj9xOnrkxW/nSwd9KkqFQtbuYqCfAsyDi3W8QJX/cggiDEbzj6+yt7o16eEYLo/HfSoiI5hAC/iwtXRv+4UlApfOefboc/mnGi46NN3+PEKJQUBZVOpCZoklRqQJI5vCV+2s8PqAuAVccBbQYbmLTdQ3T6nZo5xPZnnM0CZrb+zpKj98vjgOHoEsWHfjhNF64VInDQ42I2NfOVrOsxxZsA9Kne+ke5PVtgilhkDZHJBiNyJ8NXsGIWLP4FfOEd7Fp62pTFv3jbO6evdPdxCkV8yf0Gtx5A5JYKePNA0bJlT2YwvD60NEcwjoix92jNHJq/eyvtYFouXyNeed3R1MiFSVdZUw8NJJq8DrUxKW8Ax1H6jYbJFlLHsw+iVp1mITBVrL2NA6Esg/npUkgmjUBdkDdN5YEncCLFbuljXOx+BCfdqLsoczfeWVo8oxyiLiIghfkf6GkvPNta2HswoPxZJc/ZQ95nY/qLruiEKmVth9wt1Q==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d242a0ee-cac7-4ec2-38b7-08db8e42672c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 01:40:05.2484
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VQyweHz4k1MJ7embIypPB2NEwpX70VK+/NZllyyWyB3i98QbKPKLd2va1LvOa6XH+1zsN2yaw+XRaRu3zxvgw8AHSIsm1aDqYeVpALm2ly4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8180
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jul 19, 2023 / 16:15, Shin'ichiro Kawasaki wrote:
> When bio based device-mappers are set to TEST_DEVS, the test cases block/=
004,
> block/005, zbd/005 and zbd/006 fail (or silently skipped) on kernel versi=
on
> v6.5-rcX. This happens because the kernel no longer provides the sysfs
> attribute queue/scheduler for bio based block devices, and the test cases=
 sets
> scheduler through the sysfs attribute and fail.
>=20
> This series address the failures. The first two patches are preparations.=
 Next
> two patches introduce new helper functions: one to set scheduler to desti=
nation
> devices of bio based device-mapper. The other to check queue/scheduler at=
tribute
> existence. The last two patches fix the test cases by calling the new hel=
per
> functions.

FYI, I've applied the patches.=
