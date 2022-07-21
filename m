Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85EAC43334
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 06:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbiGUGb3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 02:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiGUGb1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 02:31:27 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C508BBC31
        for <linux-block@vger.kernel.org>; Wed, 20 Jul 2022 23:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658385086; x=1689921086;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=GJbsfMEoOMFwZYZNs9JXKvbq4CBYPardQEBVXp14Tyg=;
  b=pzlL0pOrMZWKbZ9lZ7tniWaJuQSLgBwbf0Ei4wQtOj/eEMrzYFQEg7Fu
   4cYZ4PAw0gHfdXW2Kmsu7jBcFLX3snvSmIv/4iCwU+bVdHQy0FEvRRgeD
   ArrAV+skMHCpYbGkSmiGrQ61QKm5YcdlqxrF/eBwPqQmGckiOdzWDWXY/
   ATY6h5dXKGsVK7bhoyD1Dik36keTSCvUAoaCpehf3fqRHEruW69dmVxFD
   s2Xw9rjPj6ANRsXiaSLnNojTFDb8PQg8F9p3G9VQmhra1dQXTAERINDBU
   J+z7QlaQuxq4nteuc8lqcIOtCfsKv7V7kIzr1qxkq1PDX3sEaB0jaODUy
   A==;
X-IronPort-AV: E=Sophos;i="5.92,288,1650902400"; 
   d="scan'208";a="206517932"
Received: from mail-bn8nam12lp2174.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.174])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jul 2022 14:31:25 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UMJeHOSyKnJVVbFGTBS+ap+wOd4pOMtevLk759eg6PmOaNf5H9FfHirodLGPcOfIkeNUEDFtzeAgqIC43ibvF93W3zsXBfcRFX60YpNImCC/vorISMbSC3fqt9PnzObUAGvpZoyiQ8Sf44cLb9/8zcr1aNsZwOD1RDALqBkQ0Xukmhg66IJyriNoEs/mBrUK3b1mj6GU6kL04zXnT1nCb0DD982F9/jPY6aP5wtWvrpO9Cxn2JUbM1UCWCOHSLqOPcGnVvVrmyjH9p/vIwC7V1yfO7naL4Mw3n8wyhj81MSVc8JfBYcmitQzorrHDtquJfc3qRso3RGlp0UkBRoTaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GJbsfMEoOMFwZYZNs9JXKvbq4CBYPardQEBVXp14Tyg=;
 b=QcoKjQ5x0fzNDRAW2dHM55Sjvz+37HWF6yV0ywosoDitiso8F9HvEdhPNsUwDzY1pYwyQbzCtECpNGrf82YcEU+tB8rhoEPaHR5UR5fA+2glBcNMyscoLQWf+LAliiJmaW1vWVwTSQJiZsH8HZRI0OrvISyC3h+fmrot1PqkGdBCslNhRrf/Q7k9FLiyNsOaLWrDEOyPH/P9mhNE9SQktdkdtQBiMqZZABST0qGBckotNGSn1CG3cJlhHiv3iykDjqprog1T0i1/9mEy9F9hqCnLf2CI1BUArYKqgxVTRq6SILMA3nuyJOGmWlpsQwYJnG19mg1ySkbhyigDVa0Q8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GJbsfMEoOMFwZYZNs9JXKvbq4CBYPardQEBVXp14Tyg=;
 b=JRKc2Ct6mvkRTHTlQADcQMloW3kYyCUQpnm3iXtVG72UDZk7LGdEGdef+1z22sn9NvQX/clBCxftpAhVUGYCeGYnetk2KtU2n8s0UTaWhjaJS7QkeGTF5Ej+FxoB5Su6+N5Vj6HKyWULrzxrxmdVjMb0Yp1CQqXp44IDu5pONCc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN6PR04MB4878.namprd04.prod.outlook.com (2603:10b6:805:9f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Thu, 21 Jul
 2022 06:31:24 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5%7]) with mapi id 15.20.5438.024; Thu, 21 Jul 2022
 06:31:24 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 4/5] block: move bio_allowed_max_sectors to blk-merge.c
Thread-Topic: [PATCH 4/5] block: move bio_allowed_max_sectors to blk-merge.c
Thread-Index: AQHYnESK/HOQlDXdYEqfV80l+o7Iew==
Date:   Thu, 21 Jul 2022 06:31:24 +0000
Message-ID: <PH0PR04MB741657AA4C6612601C75C60A9B919@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220720142456.1414262-1-hch@lst.de>
 <20220720142456.1414262-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94a028ce-5adb-40e3-07c0-08da6ae2a222
x-ms-traffictypediagnostic: SN6PR04MB4878:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xnvxPs1hLd1l10Z8RmAU/X3obYwT4V5uZtJMo0Rzjw3rl4rsjtpholwiMbLK3B28NGl6EZOCIkJ81txdIayUU057l/sKHLQevqKWIen8pEaxQkb5KbMErcYNWsxUK688Rd+zEqxNuvWB+4NQgXz2LpJlxzYkCYvFdTsMRPwjb3X3cTMhHjK3hTySDN4XVE4EQJb1o9HPzifEw9FU2V2YFOSuEWkibItdWdvmuz9DjNNTZ2nigtmSKGeIBWyKG5lqhtsEm0rG1tahIVS0fFemoulhTrDj08YiCP0YPVQ2IfFUOWIrA2xZt/in92pjAN8Fb4BwOHvH+aTMhepw0MGXXgEDWJL/FS3LhjuVN6OV1s7OF3IfzuxjYMIMhExAeu8k/yywF/aDiTsR/z9eaAdvIrMn7YkJgASylNG+AJGf0D9J27ETpGKO1MDr/tYLRUFDU3hQcir3D7k93hvO01cskO3nGkJku3WI0FRB0F2S6dtE/Ucg3AVBQTXrMa2lVwxxOgFSKlp2VFx1wTjRK8suJs5ig30gj5rD0HwlcUUwmtdlFCPIg/WgYyON5yOyPSIi4/Qe56Lgnfxz6xc3opCAqfYab7o7FQlPMMuVRihowb9ONhDUoVw+Xf5kcPGMf4MF/CmaGZI+CI9hmsth6XhWNF+muAjWkczLP0EN2/v24nSIxbgpvmUOQBjGu+120EXFlhc+/J6n1iDJIngv6QqXygDRWo8rGonE98mEhKRPqc5k+hXqUfklB2XcbjTMTUDD0cnPUoTDg/sIECZ0msOHORZ2vsETVpSj7/2Vn5Ds/UQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(346002)(376002)(396003)(136003)(122000001)(38070700005)(33656002)(38100700002)(86362001)(82960400001)(478600001)(52536014)(4744005)(8936002)(5660300002)(316002)(4326008)(110136005)(71200400001)(66556008)(8676002)(64756008)(66446008)(66476007)(66946007)(91956017)(83380400001)(186003)(76116006)(55016003)(6506007)(53546011)(7696005)(2906002)(41300700001)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WBKw+uwkRgBylmwumZJmMKGoP//d/0dCSuAThGxMqqyep5rKszXvBiCAqbgL?=
 =?us-ascii?Q?s2S5u+s5whk+WtqrdM6V7X0BPP8LOC6u2w1aq2NmH1KTPASxFaTRW5i+hSON?=
 =?us-ascii?Q?SsEcRbftJsKdgox6wij17mkIXC035p5MxxPVGN740VAAKiestecp0PchVN0C?=
 =?us-ascii?Q?C2PH/szo7wKkpDM661koXPigbW0ILqisx4Cv0opB4e+9ODq+xLiSreEYQuXQ?=
 =?us-ascii?Q?XTlnNDfNXBSP6NDGZdHLW/QAeyU5x5OKA7p7w7z6dOlaVNeIFOFOzo8u1LIk?=
 =?us-ascii?Q?KBynH4NA9PyM4mT+11CcabDzjcJjYAAYyL0o/UbOelMN511q9EAmVMcpG9Pl?=
 =?us-ascii?Q?nteckBmgefd3l+rQ8gHwy9M0gma4jArHfhXYHmdp/LFCY2R/KSdmlW3I4qZ9?=
 =?us-ascii?Q?WRh/WyS6AJkNlrmLQNLgI/1Nw1WS6vp4tgSVUwEAxFeyA28t4tCZj8Op/AQK?=
 =?us-ascii?Q?ViQXyBinV9OgdApXCkhe7GzW3eqOtu3qV9uGqAGQKM+eKZHx8qEg5UpBHpQh?=
 =?us-ascii?Q?2dzacpEYUHr/ITV3K+9dxcPfaFBHmerpRJB6C7KbAhHCJuoiUpRoWDX25R63?=
 =?us-ascii?Q?HIDvy6Py4ENy9b8k9+tIh7uMNlngskzqUn/Gnj+DoDQMJy98Daf3/pzOuBfT?=
 =?us-ascii?Q?Cv3Fs5Xy8MSg/l4VJ6+A7D2pb3Sr72z1FII5JWdGnPz390hqvzFRthvX5cZ+?=
 =?us-ascii?Q?ljxM5BEUisdy6nNgC7ZCAiQ3Emz1Mbd4+kAkrzxleOyR7bXKd+cGqj6e2h2B?=
 =?us-ascii?Q?CjWi2DXc7cbWZmEZwFW6X9V9cEZUcUzdfNmgHCsyQja88CR2XCp82keT12pq?=
 =?us-ascii?Q?7cKjfK6VmvzSVBd5Cxwm7xoCRnG18qHEUoYLkc7djtzL1u7EeOcbyQRvcyYG?=
 =?us-ascii?Q?zFrZdjvRscIyD3qoM//iA0c/We0dxkqfOdxbywOSTN7U7JGCrTWWuF+uOfbq?=
 =?us-ascii?Q?WSF8h/6yvPmmXDIePeqEypTPPkfFKTC2VTsX/7DMqm4JaiJZBKISW0UYgmKa?=
 =?us-ascii?Q?dqZ1RW2wSrIU87PBS9GVsovkit2McfZMX9f5+WI96/kDKtoKO7vHij2BrYs5?=
 =?us-ascii?Q?NSO9amkyMjIkbV9T9nrVXxV8+v5DQnWDu9FpjOgsRl2OslzO4zrXTFGbdOnt?=
 =?us-ascii?Q?qD+UwwQ9Q+7XfvbqRA+dwM1BxNx029HeWCmOOC3w23Us1C5On+jMvfLF4lgI?=
 =?us-ascii?Q?U35MXIlvK8FM37obOsaZAWubIOzsg6rJxkzs9D9+dH7ecQFSfGzontVSbHE7?=
 =?us-ascii?Q?QuaQE7bB3BaCyx7h8mRet/U33MImUqCMK6tImOBGcpyCZlMgkuzzAIF5EIVF?=
 =?us-ascii?Q?n3Gxm2F7SG5cUpnBrDOvjUkSDLOUMN+LPmJGmuQH6Dx1Zj9DnYJGtL3P5IH2?=
 =?us-ascii?Q?pBNeYkaPsP05J4kqc9UCtdzOERAWjQW4kSCmX34dicBYgjOCSLg54J7zok7M?=
 =?us-ascii?Q?tgswIKJ2XLX8B8VCY5FIBtSJh9Gy/VLV1c+gZnUAbb/us7ireSCzwdCaf9UT?=
 =?us-ascii?Q?PObfOGHMQYuLDLOotq9niDEEL1262XwhiSnnP7T6McFY20Qg8jF8fI66xgAv?=
 =?us-ascii?Q?Dwc8PGpRaeHvQQq0ycfBHzuXGf0eDLeBR/73oLHimnealGpjL1wbqk23gaCS?=
 =?us-ascii?Q?5HUbLLmjxIdFKE2Zjp5rx6/nuLn7Bl1V5wyA5jqAcffTuVq8+I6Nrb7bOaw9?=
 =?us-ascii?Q?QZcaxP2teWB9rA1pES+WTU3FJRY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a028ce-5adb-40e3-07c0-08da6ae2a222
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 06:31:24.1170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +HqWcXFejeYWiF3JDMZlCPviEpO2cOATEhoQGQXFw/quNvlFZUn9/vhh8r088wvzTrsrnpy6qWb+AzcQT2LFr6fE9CnSMmFm1cYGl5xcYpE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4878
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 20.07.22 16:25, Christoph Hellwig wrote:=0A=
> +/*=0A=
> + * The max size one bio can handle is UINT_MAX becasue bvec_iter.bi_size=
=0A=
> + * is defined as 'unsigned int', meantime it has to aligned to with logi=
cal=0A=
> + * block size which is the minimum accepted unit by hardware.=0A=
> + */=0A=
=0A=
Not your call, as your only moving the comment but 'to be aligned to'=0A=
