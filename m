Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51312C433FE
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 12:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39D0860F6B
	for <linux-block@archiver.kernel.org>; Mon, 20 Sep 2021 12:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238896AbhITMyz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 08:54:55 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:24089 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238955AbhITMyt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 08:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632142402; x=1663678402;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=AM/5o0ltmb60cANZqMktiHtoLQgNWTojcpAlix22LEpZkzvIC62sqeSL
   YZY0Q0IbuOUc463TD/7KwUrprQlTqNvms0yOa5FILJxLrVvAu/QJSaIM1
   PRP2zG/BVUeZKG3v6JQHtyHkInwAPxqEb1QLjYg+sIxTcYCRziv9zESOE
   IENvPuH9btRwI3sCRwFFpeGQZZtgyB3Xyq9PcRJIlZ8kc1R8ajoFBYplg
   OAUno4YilntOA0o9kKJDDJpCH3S4OmoEKXSqD0PnNFqMrR4GLd+7QrefT
   /U+tBwr6ATF1Bq9RPENI2NgdCIlhmlE4NHjqCAozPIoq6AT2AFvjn1Px+
   w==;
X-IronPort-AV: E=Sophos;i="5.85,308,1624291200"; 
   d="scan'208";a="180455957"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
  by ob1.hgst.iphmx.com with ESMTP; 20 Sep 2021 20:53:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KW/fZZ2taoWwl2rFjFQIiRypIJML7g97+giu1DpFfl7gJ3etKTsI4EQqKBW+C1T2VDsMBPf2by/voTfR1a8u6fXd/Sg9X+X7oqz9C4I0AjecViSswfLGzK/E2tXdRTUUQOchyBJbeV06gdlntxtiC6U9HuVeci6vrUyz8/7xiTKS2tm5aCq6/PA181sC83OqM4y3C3gysSyHhFfH0JTQCr+DeDCmWrwaRuAXGQbzD2aUrtusoyKtskmH3Rvn4kCMKkt07/G9Bmts2O4TUFFUyap7Z22FkJ3S7YBjY5QDQF6Lxr6bw4CLBdApNRpFSCKmiOXD0AWKS2xQC5Nh26WgHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ce+FdOn1tV/k0YrlGkf6TlcrpzcmUG+vIbLyigTFSGXqCO7udHOACmCyRO0hWdRlt9Q0wYlBFrrr7onhZ0g8pHmzdsVi3bLC0RWppfVnfm9L0lwMi+dx8Y77WJ3C30w5v72dH0BQWeg+kmQGur/IfrJBzNACXr08c1FJ7ddq4uiF9rPmAfq6rEfDebjq0JaQmtktWAoqCxOmNZm6LlVK6UlLLgBOht5zz1FwWS7vHmdAjn5OcOMaZOT9ZYm/zcV/UhA5j3dMyZYPXFQNx3BL4YJeJ2Ia3dWIcz48+rE+G1T61avATxzThOwioHGDu9cQ+Fem9qxlrZTdlX3UjH/SKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Ho+nxbCVP+yygv+GHC3FfwgAPxuNJlr2MQqwoHMmG2it06IBM7jHpydPDLefi/arIZ0McOQ9gNsN6R2hPOaVukUS4truWGKm5fTEGXoioZjpBTPPDVNESw+L5W2B3OZ3IN/KKieyUIDKGjz6RhSuXDOZpJi2vLFVnZqBfEKgCXs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7256.namprd04.prod.outlook.com (2603:10b6:510:1a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Mon, 20 Sep
 2021 12:53:21 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a%6]) with mapi id 15.20.4523.018; Mon, 20 Sep 2021
 12:53:20 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 01/17] mm: don't include <linux/blk-cgroup.h> in
 <linux/writeback.h>
Thread-Topic: [PATCH 01/17] mm: don't include <linux/blk-cgroup.h> in
 <linux/writeback.h>
Thread-Index: AQHXrhvQgoxXj9kev0mcFaXkf9+Z8w==
Date:   Mon, 20 Sep 2021 12:53:20 +0000
Message-ID: <PH0PR04MB74168D617C1374106B585ADD9BA09@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210920123328.1399408-1-hch@lst.de>
 <20210920123328.1399408-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0f74425-65a2-4fb2-5a58-08d97c35a008
x-ms-traffictypediagnostic: PH0PR04MB7256:
x-microsoft-antispam-prvs: <PH0PR04MB7256842945CB9DDB92C544239BA09@PH0PR04MB7256.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: in1q+g9VXObjPBJ/pBXNumBzcST5ri2xwWGhHIiltfOm0iLKnskLW4G8HlzbZgXDXgCh2ImHIEYQzb1+9EvqSOwG5m+GWPGI5aOPAdpoYgAblD20x+OhLqDnG8ml5qLVWtP/UJ8jt9pyKgR2NxbOzqv6Z1V0UUCQeQ10iuewu7r3lG9nWIIGGu+8G6IQruxkqdA5fio+jjqOdaZuvUBd2QU/UL4AuH8Avrv+n/i3JmbtNizyhoNj8p7LDZ6lu67DoCBZZncN/E/vfzTFfjaN5DwR4uK/CtXK96rdCMI2jRc/xXzkjLbPmxi7F95ukxnZFjs5UFIXIVW3qBVr54nsGkcb50Gnssepz2GREbU4JT/D4m3CM+q3kVNO/R0pZtF7qYuau/4VhgfWVJZNJ8r5AOYZt4kXgL3rgs6MAlCSbQQQ0GYY4fGmNJWlzFVnr1WXPmewQV92HQjAOimRMp1XKWgXoefBHKk+oJsecysyrui7S5IokV3JIkiyE/dPrOyLP7gmqclwNBjRE7z+UC1+xGotPNoGynweZ41m0x7dkqOIA2iPy4jMBkob5E1OUYcgYWTGl89uHCsTLhpczeSYuQm8BB3NakyNvehzgJTu5/HEHMtwo41j1NJbAB9EHJE4AB5kQNKfCerqwVy33r9HUPLmbAmVw/JxLVSm5//axVnD4WJ/n0aMOK2EkVR7/2XCV7Go9PoQjOvRf7oBZ1NeXA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(64756008)(2906002)(4326008)(110136005)(122000001)(5660300002)(8676002)(66446008)(91956017)(76116006)(316002)(8936002)(558084003)(54906003)(33656002)(52536014)(9686003)(55016002)(508600001)(19618925003)(71200400001)(6506007)(4270600006)(186003)(38070700005)(7696005)(38100700002)(66556008)(66946007)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?nAq68i2k2AghzVy+J63HeZwL67rVMWbEoEQBCJAShbwHccczjyN5kCZKuwf6?=
 =?us-ascii?Q?Hukeiprk8OtKKJnxvBvjPYKzLOe1XZzvYWT2xDvD/PN/I7wcyILmHtXf/B97?=
 =?us-ascii?Q?KCDe06V0AiekEs0SlMmpK8IjArqBEH89Eb6rcMfZ14uAtT+imhbVg5PSDqoH?=
 =?us-ascii?Q?I9gBE36IVMLScGPUdHjgfBOtesXnk49Z6yXcBVzjQA8jkQcB/g2ZcH4CDRTJ?=
 =?us-ascii?Q?L3M1lRLYTfQmzLuBHeAzi6oDHx8u33q5WzmdM1eaF/xA4INxtf0w4sa8hQG1?=
 =?us-ascii?Q?R/FVLHDsL4d/Z1+oRwpJyyWCqV78ZLgoE81SVnTsnTYT5LDq0tBLG1sfylwK?=
 =?us-ascii?Q?RlPPwKesHjZdJIMxVNlKZzmGOrU238Yz2dH5e9dv+CWl9IcCKLS505IISoi0?=
 =?us-ascii?Q?MzKwReTb9rPmRFyVocd/CG8YsQBZdV6DkWY/GXsMbKz2FL+M3FdLSuofF7r9?=
 =?us-ascii?Q?zKoHRMlVr7fE+eGCXkSNnnWg5StIi4rONeLvKgfpWtdnEOEVru4u8ibsmyF4?=
 =?us-ascii?Q?uJNIDV92+diqCgnjC3VYAPmqTUBpoeLDZibEyXc7FLtYG5UHhX5WsDzd66Bv?=
 =?us-ascii?Q?6n2UmivPd4yvX2MCsEKGLTIwrmP2HHVm3amSrGQLThilJibsxRXuRuOW/62A?=
 =?us-ascii?Q?Oe9YoTfkV+3WqXtsLiAuLJpN2vRWkNTJrLqilHj97Mu/FThy1hm0melmFh43?=
 =?us-ascii?Q?9GMTSfKvQ48FhQVUvF+UfaQTXHb1w1d9TQZuRi4VPcvAN58m/Trb8CGbh3Gi?=
 =?us-ascii?Q?6fbhgnPxMUmV2qSC3C6Ha9sqtDJ75ik5IbRwEAu+t4sCWLO2n7TgrQFaGnrQ?=
 =?us-ascii?Q?JuyhmWEKFCHYL+dRJMc5Nd0PLpRsiEaN2s6hKWTj5pW8jY50RNRfqMVesFH2?=
 =?us-ascii?Q?O5LzD+jOPL6q3mgIkOno4KojAr3mgvXXrDodtmgRN9wns5oLcKro/3RHwIHC?=
 =?us-ascii?Q?IkZ4irdrUbrdAq+fvWio7cDN/d9PmZ4JD3jYMIQj3XRXqa5twNtISG62NKNm?=
 =?us-ascii?Q?sr1tBqkltQbaeA5SZYBqcZSD7Wz4d3Qrpdsc8LqT4KZ//FRG1fiMqlk1ordg?=
 =?us-ascii?Q?FiDscFv2R0TyESP5sAEOrRMR11he+xNCtbKBFyHYHSHX7DI0Abksr6GHOYzS?=
 =?us-ascii?Q?51qsM9YryF9i6sTWCSyKwVUCiYXrlv1lx9llBZURFtgH3mlV0bfJ505BTeva?=
 =?us-ascii?Q?RB/hWQy7e/Nd4mBErrfDkwK3t57Lr0m0sgFClXcF8H6gdbrQyjdldlUORIgP?=
 =?us-ascii?Q?Syz4LCmG2RNnIAbwYbl9srEsjDqVU5zALcovT77KHsH8Lg+b+2UrgbD/1m+g?=
 =?us-ascii?Q?wJh1uui05tyxvFmdq6B5N3LzUhrJD7JLznAyKFsUYRVEcitocS6JQECnYYmH?=
 =?us-ascii?Q?z63zdwknwQ+/XY9wkVWbG5z2v03CjuJe+9389ZpzVn1YttZEcA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f74425-65a2-4fb2-5a58-08d97c35a008
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2021 12:53:20.7597
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cWW8n69gZHEjsytTsA4QA4kAX7LXgIFGNkK5gqLYao3vHG+umKaqX6ZinC2BEWke5EgcBcvb6NtLmeUEQhU+DtWIvJMT+1utNQwezLCSXu0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7256
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
