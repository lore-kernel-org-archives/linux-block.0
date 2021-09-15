Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E27AC433F5
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 09:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24C0E61214
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 09:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbhIOJUp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 05:20:45 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:23526 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhIOJUp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 05:20:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631697566; x=1663233566;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=duBWfaky4L4VFH6xnlFCtXGqkzdj0no/LdI6rVRgiRZwMwEh0iRNkCCO
   QGfbJ393oYnVxWc8bpG1nldqXVDv+TacIxTVfkR3U5Xrj5K+aPyZvQlis
   r7yI+iLOvbkDmz9gaXCUluPMQpxeRUGktpPA+fFhu/VLCUv4ZIc2rLIeM
   iwre+NKCpiOv/v2leWZncD7I/csksUQwIWWEFqa1MBDSHaJWRAKzoJYjE
   U+piABlLMvzUlD11dRvV2yGhn1IiJwIhdJ1XCxmnn6AbEqdiIC4bXvudc
   oX2fLBTtTm3gATxvwdBzC39wD4XIW/NeFr4MmNM9pIv/KStE3feDxQ3Er
   w==;
X-IronPort-AV: E=Sophos;i="5.85,295,1624291200"; 
   d="scan'208";a="283848959"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2021 17:19:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVCnKY5KyFTzP9jpEeReiQCEwbOBmfEtkpPbayvu9OCW8MKvmSTkQuxdq8VZfxrqwEFIClWum3K/lNvX305No64aptETHU1OxcCEKfIgJ/EfOEisZdMbUbl/0asuVwS2ZvRfDiu2/ZSNCRYMg6s5f01J92XsvYW0WTVoUoJJvn1I5Bc25o258y4TdnSiEZ8uEd4OZ74Ga72wZ6eb4LsvQ4rNM0D2PUBpQtCrq0PW2dDMXhtDPw19urgTVYZ1/K4ybfDOzfVI8sGNSKQ1oOSpQqbsyy2wFcX9pdt/29qxypKrSrG0cHFjiZ1xCBWYlP0AAKlwxfuoJsBZHWYJmt20Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=m/TROgjBE/zjA/isqjTAp/Qf5Cyl9HY8H1D3Qt3b1hA1bYkcgazR/9ztiCwfMgAcU4U33yfr6Utm57AJy8jVVKFeVhAM53U/U+Ikw3MYGNA1sSXUAP0VLBir7eoAk/h9xOH51g3lzQkyR9MDkrD7fsJDqN6jJRcPRkNLVmBflqFbkpS2BVtR36eTGNeugXk3nGKww5TA6gxdWYOeHmKDx44VulfDnHY0+N2C6O+JfsfiDkHtOIvwinNsp6o89sCo3HUHnuFTffcDMCu9y9VFSqHDCuIPJPZ00nupZAURf+ikVA13ANkGvDp4vsv+DYgZkhSE8Slw51gUIoL4EUP+mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=EGmju2YnZtZSxFj8k+ykJsvbdj81ZokvT8igfwIE6Fm7qhy+y2e6iSd+U0ru7/Dq+iwo2uzeZfBvHOicalgeDUqcRXC9yjxkogMjfVVecY07JTtvWtK2Yx40d9YHBh6aPFVrw20zuRjP8EpAQXH/NqEbXi3zaDgltlXispaFvw0=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7624.namprd04.prod.outlook.com (2603:10b6:510:5e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 09:19:24 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a%6]) with mapi id 15.20.4523.014; Wed, 15 Sep 2021
 09:19:24 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 17/17] block: move struct request to blk-mq.h
Thread-Topic: [PATCH 17/17] block: move struct request to blk-mq.h
Thread-Index: AQHXqf7WIVQz2fyyAUe87zcDEv31/A==
Date:   Wed, 15 Sep 2021 09:19:23 +0000
Message-ID: <PH0PR04MB74167AA2C3AA6BBA25326AC19BDB9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210915064044.950534-1-hch@lst.de>
 <20210915064044.950534-18-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf7dfcd4-ef51-45c2-18e5-08d97829e89b
x-ms-traffictypediagnostic: PH0PR04MB7624:
x-microsoft-antispam-prvs: <PH0PR04MB76246D8AE77BB40E2DB3B7AE9BDB9@PH0PR04MB7624.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6mJsq/TzWpDT4nHeByRMhbLIZBkYG05555uwU7aDqO4Bwp/55g/PURZNw2fO1bL7ABF/XweOvp+36qnU/y39C7JHgO2Mlo9eJCbpbBTqhe90PjPcXRt2toAOBxxdhb4mwYlQhqFwMaOMvfWDsyMe/y+0IsMaWCa2sKOk1N1701PGwE94Tdp8lyZkON6TKRMuiYPOReJP0y3zZGGs8XCJjjRCwwrgI1XN2Z+usuFvq9uzbC/w5h5GDVUssgDytNl24w3QevyYLphrG6b7CJw4VphH2VaZsw28h8hxtzN5rwaPSr9GAEcmIW1gYP4Wrtc/DG0G2K6nJ0pSliJiRmHGTnP/XNDEHNCls8gz3OZ/BchHXOW0KoY+wZhlspaKcYn2TaNRk5tOkCEPmy8GZkpEpks7oXUkCk1xTpqo8wKT+FCdeuU0bHHToe/dRyMlS+NC5xez5o1cjnXsDTK+4ky+yBntCSG0vkE8rMRqO26Aa9XjG0PbYCoRc5SMDWHuXoDbWjBNfthpStwrsDkFS4pf+4fXd5QZQW1GWQ9e99UdaU13BsS60Hb9jVAr0qSvUqGxWzTXW4Yejjf0px1+YJMWHu6SZ9Cr7YX2BSmvE18OIjRMbLWq7wFyBlzytRBq/9iHHfNxxNRdgu1yTsIZft8xFQFvQ9UdgAFZw27qXS5inL34GVHl3k1s+37SJBop5OQe9Kv6Ud2EsOCpxzI7Ocv/kA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(396003)(366004)(39860400002)(38100700002)(4270600006)(558084003)(5660300002)(478600001)(122000001)(8936002)(9686003)(38070700005)(71200400001)(91956017)(66556008)(66446008)(66946007)(8676002)(86362001)(64756008)(76116006)(66476007)(2906002)(52536014)(4326008)(186003)(7696005)(6506007)(54906003)(110136005)(19618925003)(316002)(33656002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WNz1rcdgnyoPt5m8yUBgFzcmKT1onCE9ux4QxQii6UTg4sZuF7Z4pb34UQOm?=
 =?us-ascii?Q?Zher+DbjIaanoty8kFiVkprKhwPoYaDqIe4+et4autdzWWBSDyGZm+ZonimB?=
 =?us-ascii?Q?gAlBkdhDm928lBbP+iqJr5LN/NGxbv3qc5Wcc+swbEp95I+CkrmAkxVxSSBC?=
 =?us-ascii?Q?4VBlsQJpIDRuQQMnEqLGwYrYPyZ0nrRXsOu7QEblCQVZF1LN4dJImlSeiCGq?=
 =?us-ascii?Q?8JYTAk6Bc/2OCRmLhOJ30M4JbGa+k0vIPS5z+DuzVex281nyH02cZVfpWJ4I?=
 =?us-ascii?Q?R3FCRBAfr2JYx4T5UetGVqauXyGs0ncS4MpaYIW7/6mcDg/7D6QYMKHHgI0W?=
 =?us-ascii?Q?anwU3nBlltSXrSyRhkLHOljAymK2/X9VazJpJxqDDC0Zql8X/EXzb4U6v2oF?=
 =?us-ascii?Q?lM2VbmFAgmdTVOYNqvvW4lX+4ewOEfXNCbpxG6+CPQUZRVXeowqkY8NzLYXy?=
 =?us-ascii?Q?9oQCLYImfyjJuw99UpCmBvDDBmVaqditTF7eQc6oh7znI3qmt1JdJ+KtpSSI?=
 =?us-ascii?Q?Eie9T+Co5aFw27mCZnhsms/ebbutA5Le+Q+lzwXc6lbW5VD+3A6r01t99gz9?=
 =?us-ascii?Q?14ZrnasaqiZpTN+SrCqQtCUn7InNafldWlxSk6x2CA5Z9rL+CK8yr6/CWiSh?=
 =?us-ascii?Q?vnp9/pGNflH/hj1BWcJ656flQbDs0/MUi2MQsVFtCXACPz83DtiClZdFux5p?=
 =?us-ascii?Q?CO1V7rLxpcU734CpZ6HS6B2NJpo2/4sFOgYpI/13XyWr1eswsXn7fROrgeoS?=
 =?us-ascii?Q?D4AOU4JybVT2XbTBbrl0aybjY6JslZie9n0y4LjLtt/5DGjSZVe9XcrTXX9F?=
 =?us-ascii?Q?iO7yPukldgwWMiLxTgOBOwIPc97OjlVw8nOSAxjQ6LSdTowXUOGLMrR6dRPg?=
 =?us-ascii?Q?/VvyilmSUx+0jpm0JG4x9/0GdnRM2QgEB7zFK1MdpYT0J7Th/t70C2uNtuR+?=
 =?us-ascii?Q?RjvtvI0SC9InJJQA1yRMqrGmIQnggiABlAN+H0yc6u0MI+nmiDc+bsmdiJc1?=
 =?us-ascii?Q?T7oVKYlD1UqlMs6T78gXFu9njT/ExieCpbC9yN2MN5vzdbiz1jau17D77O9b?=
 =?us-ascii?Q?RwqK+fhm8Uo0afJHHy/3KflPWGeUQ5zDSPfkyRYmU9XujYpY3Vvi0goVjKAf?=
 =?us-ascii?Q?xx6XXLRa210mFT9AJ8BUH1VoGN1F18l67dCisLCTnShfnvOOjF0pWhXniT/1?=
 =?us-ascii?Q?6vl/KASArXb0S0G4xdG4G+ugbYfQk1bQGa7Xsrtm8I7Q3CpRx0j8XDzKYhrd?=
 =?us-ascii?Q?dUJIwUZSyj0FksiBd/heJPQBfIZp00/vq3Yv3+ECfO5gBXQ80tE1yKWieXmC?=
 =?us-ascii?Q?e7//DW3PCbzoNwDe0BKPivgZRgN4FRXgeFqfcd6U75tWlR6g39MfiCPYHgfF?=
 =?us-ascii?Q?LYKCIxTLI4r0woiXIVzGf5vuNVQk4zu3GPBPUFXZlZ3WDojuhw=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf7dfcd4-ef51-45c2-18e5-08d97829e89b
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2021 09:19:23.9334
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FvJBY4zuwbt0snr4/DDTHk/AonEGPUR01LqQWf7SGL8NDUua21NwfZzE/yFCTYmBla/EfaZweELat3RhjT4Ua4euku8jQ37HROcSZfG2R0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7624
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
