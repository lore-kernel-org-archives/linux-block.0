Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38D8C433FE
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 09:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF35261244
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 09:11:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237309AbhIOJMb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 05:12:31 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:17099 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237229AbhIOJMa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 05:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1631697071; x=1663233071;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=NQB1fFk3Gf5KFKZ+8yP9NG2SspsD8xamnhW6vyexjEW0MLzJYNlIcz9L
   DZYC+Yd4SrW6qOMO6YMFip9hx8LiCOtZsB5Y4s76QpEY4Si/3Fy/tsQ+G
   N20NTTFerMVOgqvNvHm5oLiv38PsIV9xyRST4YVZzxdtO0BQ+oDKyVzBG
   wfo6C8KFsuBp5J344L8V5ajKQWa+Pwk2aPv+hf2T91+1e4fUG4qFftOBP
   lXbQHvuqSBj06ikMspYDZDv0KEDp7LpEmaxKNLVFDmjHHprB72yCAmftg
   XpTaxeYAzQg84CVVg7uyDdfFqCVzCQxQ4/fMD2RTT7xqQRkQcGKo2LHBh
   A==;
X-IronPort-AV: E=Sophos;i="5.85,295,1624291200"; 
   d="scan'208";a="291672412"
Received: from mail-dm6nam08lp2048.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.48])
  by ob1.hgst.iphmx.com with ESMTP; 15 Sep 2021 17:11:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXBN1TgoO3s2T7LDOOn7t0rJmkhf3CG0mFNGB9jAZJ+mdGjLrh90VhMH8f9CDMJRHPYoL7Fsu331tHI8NncfWtEjoFiFeItu4j8+tNLt12zgE3VAqZnGvbfjXQaY4z+un2xCorQAAHhL0i9TyV0nybOj9IDC/iTogjfI0lbYBbPD9fwGs13Tn3tvdYJDbrFdJpmzh8deZAkn23bIl7ek5AFmTy1tXSG4MnzRuq7GjF0WHbfldUKvtckX80cQCp8x3r3QZ9qkfs5D643N03ymn8RVQqsT/DmYRhy4wfeRbO8qessrQKk6t8/+fIaaYnHY/WUUEwBTU8QvV1SO5RGu1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=GJAUfIcTYhPh/OUuTwptqFzm+Lzb8a5tJxCBbpao3N5NAYYGuzC/Ltf4lTnoyFDXffOhwK/0CHsp3h6y+HBUFy/PafyGYxER61qfbihAH548WyH2NW8yEgR1q5+NBZMoa4Ak2p4KOJZl8taHVAxuS8DaEZf8A43YNt7W1xFKSN3spOUgXMj5fEjTiElAR087eS5AxV+VYVDROOngRV9n5fE+SCO1dMrvSiyxj5Q5WuZaI1AVLkHV++TQEYInt9um4+ZTZXhehpgqZUxax1ieAuYfUoeGAWit8o0PSgansRkwdXrLTTKSDbT9/MdexO6xdW0pbGGiu1mAJB6uGdIEMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=oKSBdDPJHxJjMnFkNJoJeIB7ggt158jqfoa0SeZ6f+mPT8qHbVQeGBab5y2UnfZ0OQNj+hA5TUbdXgFbdo3rCulaF4Fu9tsvKfIemr60bcS79I0Oq1wGWfw0k28liG7aFbDb9Zfpxehv5UqtjKzBNRfbSwTdX6UrRuRr5vDDYtc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7270.namprd04.prod.outlook.com (2603:10b6:510:19::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Wed, 15 Sep
 2021 09:11:08 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::5d0d:3d52:2041:885a%6]) with mapi id 15.20.4523.014; Wed, 15 Sep 2021
 09:11:08 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 02/17] mm: don't include <linux/blk-cgroup.h> in
 <linux/backing-dev.h>
Thread-Topic: [PATCH 02/17] mm: don't include <linux/blk-cgroup.h> in
 <linux/backing-dev.h>
Thread-Index: AQHXqfz82ditZXtBwE+ETkTfO+7l9g==
Date:   Wed, 15 Sep 2021 09:11:08 +0000
Message-ID: <PH0PR04MB741671342F4793A459A946E29BDB9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210915064044.950534-1-hch@lst.de>
 <20210915064044.950534-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4555bcf2-ea6b-4592-5e21-08d97828c13d
x-ms-traffictypediagnostic: PH0PR04MB7270:
x-microsoft-antispam-prvs: <PH0PR04MB727036455494609B3B8F2A479BDB9@PH0PR04MB7270.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5XfiUSxeMQTa/59aTfbLzvm9cAbSQ9A9usS2NHJZyrw3DwyqMvXlDGl6dx8dcP+yp2KkceOCEKCtpM6QS67ihI5DhFPSYXD2VWXpqUw62kNqmn7UiZnGHcqAxUcf80YUogxfUHG0LL38iJ/7AhHRiKTE3gGyPWDIiQ7m5VrrewMj/fMVxXr2/hJg3KndxhX1n+hJCACGcOwsleEBRNEmLRPjHPqRHDuN/bkl2FDY6F1vF7Bivs5jlEIal646zySLZRezzpDRWWprPUs8wYwJLp9WSpmQeHf8KDxXv4yg/WXQ3B5jW2mKCYVFrSHkYgQ1tp66XY1anc0yhveuyXNAb/9pBVWNg637o9J0HNqVwoeMjPC18U2SZ/DdAGviKDdSLACBCYumL6wC5i1/ykQ9kIkz9UgaXiNXmiObeF4xuN4p2t7SuddIb2+BjGKge1PJChACP9Uz3vbxjEGaL3snYJNCFtP7Fx8iofg63IoVLAI/uyQ6zr5pjrS/qRNsMgK1xGaSMeKhoBojcx1jtBt6v2A0aGwFDgRyzM04mXPajgYA4A08afJjeEpQLpeieng2wA6+YUwInluj7hg1OralNGfRq+oGxMSQyNFnrLqQXJeUYU9DXUoyb6hbxkarihpzw32MfzYVoNQ1Pnd9xzmZaJjdkcfLAF3T2hopA0w26Sm0yDJISi2IcLfib+n/GYktOg0ysmmrnGiY69GURxT+kg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(558084003)(66946007)(66556008)(64756008)(66446008)(71200400001)(2906002)(91956017)(76116006)(66476007)(8936002)(6506007)(38100700002)(7696005)(8676002)(33656002)(186003)(4270600006)(122000001)(110136005)(54906003)(9686003)(316002)(55016002)(5660300002)(86362001)(38070700005)(478600001)(52536014)(19618925003)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wjwicvtbOjapE8QNJ4fBlZe8nd8UyhfQtabdJBLMT58iySiYDIMu07z1pv9k?=
 =?us-ascii?Q?Z2TxsM9XlT8rBIvmpRirDDexOdeGKfhgRZqsRu0XZ3nVbcbjs2eqGBBfvScQ?=
 =?us-ascii?Q?TPjc+NJ2gCCr8LGhXM2YhbpS7IAGbYPaHKavFhRZn93ymTFw5ISAhVwolSAO?=
 =?us-ascii?Q?d9kAELDwTsU+5k9MFp4Df1frV5aMCEzpYfQv1cv31MMWKSe7OgCn7gJiuv3E?=
 =?us-ascii?Q?NWjg3w2L010oQpYMGDHltHLxAbJejOgkBVtkDrsqt4qvY1gakP5lQmInhiRk?=
 =?us-ascii?Q?nmkq45w4j579jXEuDkw3oZahNq7GDmuCy2Fs+0J6m3+sMv2Araa5qu2cuBRA?=
 =?us-ascii?Q?h0EOPtSBd4Jhvzz24KVyfGP9rf3M1g2SYkO8490afui7+w5y21q+D2X+pRsc?=
 =?us-ascii?Q?B5lYOzWb6MDD9EQHfvv2sLsHRbTzyekOoZnBqeHZJaYLtb2v5aNC8NFFhZ9R?=
 =?us-ascii?Q?nijwlsNMAV6oU52lGlYIjgZQ8xHhXlyJdFBPxQNz1rsL5YKxIjgHMccrL32n?=
 =?us-ascii?Q?s6drKDNTHPOhUdIkyoUvVC7Wnv2eT5zzs+NVFkwCKtQUPqZuZk08j0rP9Kqt?=
 =?us-ascii?Q?BW6xrCKeCr0ILICtHBzg+41rqe0j8H7jxGLnRjLqGvZD9kWuxqKKJL0i0JYZ?=
 =?us-ascii?Q?TrWwptspux9mlR9+0fHlUWBYUurg4Bx1xWZKC1OWz6D8T+DJYcgaveO+p/nz?=
 =?us-ascii?Q?RQfHk4xTqWKfy6gJ4q2nG1OZhEM4fJzxjV1k4WCWkN97zbAmOKRD5YvZ7JKg?=
 =?us-ascii?Q?+sXUuOq/0bVZN7NUWEl5rC8TVowOqa6v7Ta6RdtI7dVomQm42l4OCBlF6qbZ?=
 =?us-ascii?Q?g8Jg5cVrwZ7V09TJuf6fCdnbGv9chNHUD89tjwwZgT1YK1SNlpDJMBAGpiMx?=
 =?us-ascii?Q?NBhnxyLi6Z9RIZNwuLiJiDErIST1mIcTswypvJVT5gQgXXJ0I4YGuf9zmS/I?=
 =?us-ascii?Q?cqHdRxQRMOnkxHhAXmOCl8sE/8RJFBQp80i9m9YmWn0ZAlVYXnapY1xtWvUa?=
 =?us-ascii?Q?yS7gEMyr6oBHUfLfveVjIvBoRPRKW7XnY/GGhEH3LOR81Jw6I5PA+JFAMlHn?=
 =?us-ascii?Q?Wp7bP60SdNPdoDbPDb0QfYyved6FOPiUnfkUVnYilHEHOW2M6XCN27iWal2i?=
 =?us-ascii?Q?Y/wsGiEyg6sy06bIgtYZQFcswwaXN3zwvj2oxCZUXLSyBH4H1e1Swc5XRt54?=
 =?us-ascii?Q?4zgmIZRUBkIOcxCT5pY4AuW8IxmGI4O+2tuUE9znmeyHvRRIy+jvgFkqtRgU?=
 =?us-ascii?Q?vGk+J/a+16k2Kf1ZNyUgkizPutvy8aM9TgQ3pczM1LTiXq3JUxE2u00NE2nx?=
 =?us-ascii?Q?4WXG7lELm/NvW5o6BxZfADq6if6xL7Xcj54Vkc1ar2/8tWjUdBa642hKSeZA?=
 =?us-ascii?Q?tP9gbnsWPHgmBH4ven+yHoriy4qHdFeSmCojJxfZ4hRr6bcQSA=3D=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4555bcf2-ea6b-4592-5e21-08d97828c13d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Sep 2021 09:11:08.3903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AM/AlRmfdbZVbfJnxM0b49BOEVwkPaUhk99qJXd9/goytF48j2BPNUXzeTlwrttPbszn9sczrTjwxfeO6C/gc18PxGPKBtJL4ThicrHEK7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7270
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
