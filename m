Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 383C0C43334
	for <linux-block@archiver.kernel.org>; Tue,  5 Jul 2022 10:56:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232079AbiGEK4n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Jul 2022 06:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbiGEK4M (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Jul 2022 06:56:12 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3844167C4
        for <linux-block@vger.kernel.org>; Tue,  5 Jul 2022 03:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1657018540; x=1688554540;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=36suKY36O6rbcxfXBfh9rzCgFNSA6PP2LXAv/Sx9yqY=;
  b=l1gcg8qOfoIGQhFgEVcgTAxInAGj9Gva65aGOc7ldtvXJZtn3d2ghfdX
   Krpl1C7DG/k/HIB2dM7Ja+7hpSxxHGm4cuuiAF7iwvvmNmRL4fdomfchP
   b2ZqizV9+0UNO0vAPL5W5Auzq3KJIqVWorcv1yunUMt76yZc+MLnq8ckG
   hw0B6Vyikqwbzo7uSKFlOK9YiwrCMKJHUH3G+pEfddleeUaBPd4Evj4Nf
   JXcIZGU9Zkzy64cFdJEXNn8KE95OBn+KcQ2ox7lfKJsX2uc3Mis7Ikicf
   mJeFVbQ1KcWy4eEDZHgoo+AairnX97J30Zp5xpeYDczcvxHqkXC2eAVgh
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,245,1650902400"; 
   d="scan'208";a="204843811"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hgst.iphmx.com with ESMTP; 05 Jul 2022 18:55:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DaQep/YLuxVyFLmsXIJmWBhWIXw2eSfns+GL+4FcAM1uDWb5geXp9Unh6mizTGaX4H13sgujemPtEifIf19+LVcbS2CB09zrc8y7xC/mKEPOFEVHdYnxxVFYtxdruObauIgdteqAs508PKcgG8pLYR3IgIIJOc9Ss9HbcwtCE0SVBhEdLMJ2hLH9Np1pxI+wdSB0Gl89OoK8c3SCfsieuJh+tvnI8aa3SnIxzHwC534p+aZm8bVVLqbR0/tqLBhpgANUEkWFOb5ovh6zJu37BPvtB9dUIfWjyii1NBsuChV8wLgk9UiTaBFilrVWWUTKBOkchEsW0pEFghzZCcI/YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36suKY36O6rbcxfXBfh9rzCgFNSA6PP2LXAv/Sx9yqY=;
 b=guIbh/qSLTeJTKJvywq0K5ihfa14p3rLNhLPafp0kcrDO6NthAbnZUc3YRwovAdoCqmVsSLoopDIw1yBXjcTsmbUSZoZYCYBFkz6za5XRH/MzwHrHDBOppnk6dgucg5QugEhhsfHKgy1Tq4/ZF5Gs2p7cgMX3UPNvGGl+MKocwhzwy+bxru2501lvBK9EpzkRjxX/++VakX7KoOwjiU3Owj5PYVn3pQMLh9OPVyZDarMWo2gF0edSh/e160P9JOtVuCWhVeL1N68X/cgn4lL5JkhL4Wgyi+qBfAlt/R1zybwkfGnqpRsvPY5n039xxT8WQvlb+HmpbQV628yEof3Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36suKY36O6rbcxfXBfh9rzCgFNSA6PP2LXAv/Sx9yqY=;
 b=DTYdOmtUA1uHnqYcirStnFHkNf7x+TM/jxLa54NhZhKP/w/uWrV7YxoUmw6i3WFMPU4nkHXD890rvjYsbSeB4Ca3bOJopu/ZQAogcki/VOhoJIy/8wNJKcNflV7U+F4OkXIZNgd7p5qsrivx0F4KC+TMVTZLHBZqdNq8Rx6aqQo=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MN2PR04MB5872.namprd04.prod.outlook.com (2603:10b6:208:a0::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.15; Tue, 5 Jul 2022 10:55:38 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833%7]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 10:55:38 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: blktests: print multiple skip reasons
Thread-Topic: blktests: print multiple skip reasons
Thread-Index: AQHYkF3CbIn6+UHqqUaQcGpiq+iSvQ==
Date:   Tue, 5 Jul 2022 10:55:38 +0000
Message-ID: <20220705105537.hdjmbq3dcok3srmj@shindev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3a53922-913d-45f9-6fea-08da5e74e561
x-ms-traffictypediagnostic: MN2PR04MB5872:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Rfb2o/Jl5PowHuFQcNVtTXPqaUte70C60fXvHQRUEpO3YXW5ZeeqiBAUZQF6+VwC8MqUa17zi5VsC1XDJV9ZqF1B/4H9+LHt7nQfmmINDsEMY3yYeTZOzECz+FVeLlFJmnaAonnmi06JRJ0u/t3Tpc+7nsWH8YWq7nVumHRwZgbf6y72BR3s7Kpd5tXWaW+mOlr7Lq4ip9DxfU2CiyzCzENcerx1tsz56ofIOSpAzWvqlM6lPFV0CUuOgPBkEW+QomuKUIwngtDsnKqIWyf39Uo+RDjbrKBINC08pOyOJYUcxffa6UiCeUnQgBUZhuSrQnhG3QZEn5u+tol/z7aCQDoalN+3e3ZKn1DCYBNiQ8u4HL24tMkRLf33OrVJZoeOSgRrWpJG/E0uj+r4rj1PdjUhev0iN6QQ2puhXzFoEPOcanPOilB3Arj3Yofclb0VSGZdzTvr0NIRVz3GnCCfN/WePwVmMzeodjLj/LU3NAeWWxwGIfCGEt+E9E019YrhrXvDM05FAcX/BNrPBaqXDTgJs40bZyV3etKW7Iq3KmjzjmEUTxg2OQvBhSc5Rb11MwPrjbeoN6fi63JgRp5yrHjmo+KYNg7uRVb1ajWJhK58Ln5Hr+kXyAD/FQVgYup+oLz+HEUiiGcyweKEPRJ1NenbzhQzKK4Y0/WXhALtGIarVyWzUdi26ppwj/3hyOeDjBA7KaehlL3svr6kQutW79QlIjbxHuapIAlJtw/qJxkA/0WvMU1bKVwH65sHwiX2pu2EYbFvXjAdUs0qPFhEGPoUzE9eoEK7VjxLrYTOIysq77bDCYuCdU7YBAttCEwNkyOVl7Dw4uq6NgIMajKhRv8x4cy9RYj9EUcNiw4wofg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(376002)(396003)(39860400002)(346002)(136003)(366004)(66556008)(66446008)(66476007)(91956017)(66946007)(6512007)(26005)(41300700001)(71200400001)(83380400001)(8936002)(9686003)(478600001)(8676002)(6486002)(966005)(2906002)(76116006)(44832011)(4744005)(64756008)(5660300002)(186003)(1076003)(38070700005)(82960400001)(122000001)(33716001)(316002)(6916009)(6506007)(38100700002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?L8j53GddZQmlYbZQk6WFFcjTaT4NKIVHajZpFf/OASNpUm5DMFpswuLhbBdf?=
 =?us-ascii?Q?gp2nO4pK+mCnQV6rnmiYLu4tTZkpe/PYSAJtttJAOgB2qq1f+sot6gj2NrUQ?=
 =?us-ascii?Q?7dgV1jsWMd7p4oV2T6hOt7kh/QF6e7Vxyyq5N9gMD7uUaTm6l9frX/ckL0dq?=
 =?us-ascii?Q?/BIvqlzZ/fP6OjxKL/Z1nrmmzlH6bZfI2K5DA281K5X99FGh2JYKmbjEK8sY?=
 =?us-ascii?Q?Lh0hJIW6dazrdL67lutba8YG6gBD2g8nck1DXesfIQNI0IlIMMCiwYSLPock?=
 =?us-ascii?Q?xCwJrUoR+x3E16zuDXZE+OUNecCoDhyDS56VHMPnVolzuYB/V2A8MaScojp1?=
 =?us-ascii?Q?qHrmzL83UOFO2NPxyW5i4Ot708O3akux1467jZ1N/IRFrZ65EcR9qZ5M+xNB?=
 =?us-ascii?Q?DkF+0wy2Kot6fQ/lT6ZIUpHg3SUs6YnuBheN+OdJ8Tw/IQrY1A4N10P2CLKI?=
 =?us-ascii?Q?tSx9tX1JJG/TEx1AG7Phr7xOYpbH1v6Pg0rlqAYPIKwTDGMJPz0BmXkQZKgR?=
 =?us-ascii?Q?mj+qizs4WXQYHfoPIpmKH0CNiBy62hmgB2iuTWXc70hM8g268I8V2ysQV03w?=
 =?us-ascii?Q?tn0UbwWEZGe+RN8NqBZBuEoDCh3BBrZNYK0Iig5Vwuet7xBMEuVyQhMfIU0H?=
 =?us-ascii?Q?/H976vvnLUJqlwztr2956ohFFE7P5LGuBJVOYTsaPOIuGV7t6LUkf6UJ+cfj?=
 =?us-ascii?Q?mRZzURBrKXRkqvmGJkH0YAOarcTnkN1IDiuP71jc7XQZ/r5Z8W70lfE3Loqw?=
 =?us-ascii?Q?pVMWRg18pf96MtcJp+jTki0kEyUTI/zOUv0MXLy0FsRikASxq1zkDKMkr2cA?=
 =?us-ascii?Q?laLAjMJN86ab2OWnokxWEHT9DQuCk2HZKXb02AvnT+v37c2qxPN+QUGvuY6D?=
 =?us-ascii?Q?8H7TPoJPCNaxTOFvdAesVk6G6JRhQkbyjmdAYKllCnP2AKUFcqC98xl/9EGE?=
 =?us-ascii?Q?r/OOjYtHSt6c/5iko70WeErlg0CoM5E7Eon797tns5j2BqZ/Sxmyi1FszL8W?=
 =?us-ascii?Q?50+n232oeApD1LynEVeCfPuJsD/OFquJRd5naOTDh7vGKq5WaIOzNH0EVcFI?=
 =?us-ascii?Q?ZEP0v5ZA1F1sYeyeCrUMV5+Py3WHRb5ZPj/j1LmeG2gxnlszLgBvzkLf6RT9?=
 =?us-ascii?Q?B9nYuj2uiI4Zn9FM+VJi4O7H7xgdaacN3qIPEoN402tqE+CIljIpguyHt3iN?=
 =?us-ascii?Q?UIDwvoKuJOrD4vVRNyJdBcIu5ZkayQ+4sUivuVd8GZy47KjCPCOP08HlNHjp?=
 =?us-ascii?Q?UARt43c4q2u6Us1dZjtJhoD+p80WZNYjDA55BXVgNkRMv0DPybx0s7Dcq6CZ?=
 =?us-ascii?Q?YMho2gp5BhC1baRnL6mhiLB1ugKVs3aE23MbBYURRIcDbq4/oBuO5xeAsgST?=
 =?us-ascii?Q?NJBUuvahFrv5Jf4Ys+LtbmviCA2ucRHiQV0cmTK9BcXYTI7zlgPmUYid97Nz?=
 =?us-ascii?Q?xYYBFdWG6vMs9LIPPQcS2I1mM/huTCfielg5uYirpltycYBjawEJ4l4NhmQE?=
 =?us-ascii?Q?XrdHAtSMlfUGCZcEG4XFIL5xzMoZGoS+74kghS3u1OuNbVimUbcdrTp2g87t?=
 =?us-ascii?Q?q8fcKLFZsxwKkL3i/0ALghKGPe4RFevPtwO6BsV0a+AQMNtanf3tGdtd5e0g?=
 =?us-ascii?Q?47lvG8m+qZCnwptS6mTluj8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7A2ED6C2D4D5B048B045EA30482EE89E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a53922-913d-45f9-6fea-08da5e74e561
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2022 10:55:38.3775
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C+qk1q6gcYZbPgL/938RxbIvlJaBnU9CN3qT35lhcIyGgd4tsNXpH9UmtADvLynwHRS7yDow8FLcuMjuOYYGs5+qNo9PO4um6y6GhS/QtjM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5872
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For those who interested in blktests:

A pull request is now under review [1] which suggests to improve SKIP_REASO=
N
handling. Some test cases or test groups have rather large number of test
run requirements and then they may have multiple skip reasons. However, blk=
tests
can report only single skip reason. To know all of the skip reasons, we nee=
d to
repeat skip reason resolution and blktests run. This is a troublesome work.

With the suggested code change, all of the skip reasons will be printed at =
one
shot run. Handy. On the other hand, it will change the way to set SKIP_REAS=
ON in
requirement check functions. A new helper function will be used in place of
substittion to the SKIP_REASON variable.

Just in case you are interested in, take a look in the pull request.

[1] https://github.com/osandov/blktests/pull/96

--=20
Shin'ichiro Kawasaki=
