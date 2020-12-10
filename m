Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95483C4361B
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 08:33:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E76623D69
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 08:33:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbgLJIdY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 03:33:24 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:54848 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729887AbgLJIdY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 03:33:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1607590334; x=1639126334;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ECHqHlDDj1RTm3vjnx6FwQosCKKx0ObrbnkVz0s2BCs=;
  b=pUCdmPIv8lasB64kBgHUFipQ52n5u+9BXQtTeLfm2ENTMQEPpSdOhIwl
   h8J6/cuEYggNasF+DOHSaYARx5IhnaGFmU7SvH1KyZyfPBMV9B3xqKkpb
   skuU19jDQ3pcTNymaKhOkgBRx1YEooTNmkTjPQQl1ScnBaJUXpMtuDTLl
   mszuJXwdOk5uJW1z2h1X2Pb4UxGY42IaxVndQ8WWi+h3qqypJqRsdGb4C
   PnIyvr+7CMgyT55ftqFuwsxED7v0z1NUQv1nS0LHGcscCXKiKTw6yaIkc
   DoH+xFzHPxUn6FxQCpi0oUK2ks8hCh3c9RFI2gCIaAb5JoLsgdraM2HoT
   A==;
IronPort-SDR: 6L9mss6gMJ7kgJ3Ndtn66DbT1LATHU3t/6XJu8W9Hdp3kuSy0ZMzlfpTpxvgLt1jh9Pfj4ukg/
 PLOClKgN8Myv7B2B8LC0O0+9ZM4Q2pRIm3CkJJoH6FL8c8kyP+j15Sx5uNgmLJaDdGaZpihWcQ
 CDqMphLRBtE8LaVQdVRhsnstfTapD8xJEvGf/z2T2HG3+oNJiuluIrZwKDAJ9J57zXBRolSWCT
 S5r6pCk27ScmPuCKgMXboTzyFz78wxJKSyUz0mjTNllyff8Z/Hk2Tt0cy3Pi75qNyIBWllzQVl
 9YU=
X-IronPort-AV: E=Sophos;i="5.78,407,1599494400"; 
   d="scan'208";a="258567016"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2020 16:50:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGjvkoPbAufadXk8xbljR/YDWraCl5hcZqEsZive8FoMkRG3piI+xdMzpKp+ORncqO1IdiQe3kpPRBIi9KcGGiXoXLlnhLsO7EcJ1wmFRBQv6krYVauK7xhfK+odz5ssDFWC3HcAjrMWwra0xApLsK/Frws5WKKF1WNiGE7ksLuV8OFwe8In10DKQ93hBM5/e5M03S+AA4y8Sy1u/+tmomw8zUG4OPc7SEHrTSWuvBJkuI2Ad1tRrwJz68WgLVI34WfIAz9198Kv4GaF89B/w/uvWCswvNnErddr1LuytPEotSZgRVP3YwBpkOGiua3gWdlNYHJYVeispjo9Vdm+Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECHqHlDDj1RTm3vjnx6FwQosCKKx0ObrbnkVz0s2BCs=;
 b=MH9+D8GCiXtCZdZs9/mj9AelcNwurZZ2CfHCPMllwH3HFhKKdVmHcdj+0BjD3+M6c+WXFSJZi1fDajNR2iq/SV8VywYM3HAAkXS7h6XJNmH2pMVrqlvQQjRaF3cAMfbj3IjK37IL1az2JF1c2Epigos0hzvBX0Bz9MMWBY3R4GOnXF2Ln8NID1KfNwz7W7hlkAtvLxwlD5PdTBJDaKRwO8LyfGWx3M4A8Va0rxnmzjZcY+jgnnaVBt4ZAyMZshzHghHA0aLLX7ddI6o8VcYV1ySE8PAAfmgZkQN1CSvubAmrG0rrtlzM7UZSxCq4+4QTRWFXqmmfh7oJoqrATDEAsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECHqHlDDj1RTm3vjnx6FwQosCKKx0ObrbnkVz0s2BCs=;
 b=GPoBF5j5TTSRkWuFy2Ol9N1nE8XAmAKtE6Sv7/yL7lH3dhe57fETDL/PO25r3dePYtNxT5Q5INfDot4027BnaJVDJZYYjQ9IKFVtzc9GNBtvII97DMjqCgqJzoKNvAbJus7PlsX45uby1FH6CvvK8DGgaN8MfhCV4ouoJ3Wm8qI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3885.namprd04.prod.outlook.com
 (2603:10b6:805:48::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.12; Thu, 10 Dec
 2020 08:32:16 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::65d7:592a:32d4:9f98%6]) with mapi id 15.20.3589.038; Thu, 10 Dec 2020
 08:32:16 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: small MAINTAINERS and copyright updates
Thread-Topic: small MAINTAINERS and copyright updates
Thread-Index: AQHWzsonTtGsB4gVNU+DbuEKDT3YJQ==
Date:   Thu, 10 Dec 2020 08:32:16 +0000
Message-ID: <SN4PR0401MB3598676CCC04E8EBAA0A66C49BCB0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20201210075544.2715861-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a0702368-88fe-4898-540b-08d89ce61a22
x-ms-traffictypediagnostic: SN6PR04MB3885:
x-microsoft-antispam-prvs: <SN6PR04MB3885F5332CCF424878E7ED469BCB0@SN6PR04MB3885.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B9Og41TWIDk/t1TeNI0/5OX17Hvdzw567BSRZAnjsNBcOrxJXHlnPVZ1fvxCGxUwbuXzKUKx0Mb3VojuTmiCyiG1jH1w1ab2tTsapLxlHjBxpqoGJFfh2+TS4kn8IMPfNayj0xscCZvJ1eQVt2IZftaclG43EPsVbEXXfbj4avQ8jCOj05D6N71mE6F76H+9UED6mc1yfuyvRxaHlnGL1hA/v2ZDH5rh6jYJcm5+XEVp+6ZXRvGJX2hnJegFDdgJkGimkaFvKP7G2iEibx7yIEmUne45BcwX7kD408LAwfMAktfaXc+f1kcmkKc3cf630xPUsnjFLE+XPzVhFvnEEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(66556008)(71200400001)(76116006)(83380400001)(4326008)(53546011)(110136005)(6506007)(5660300002)(52536014)(91956017)(508600001)(55016002)(66446008)(8936002)(558084003)(8676002)(64756008)(26005)(15650500001)(66476007)(186003)(9686003)(66946007)(86362001)(33656002)(2906002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?NtE4l3Bqt6HBSXX1shhMFaGy8GKf0ac8CeCJzDaf8frmmfUiv18eH9srYBgP?=
 =?us-ascii?Q?osa3Eb9+vkLXKq+0LYOVkCxadgMLU9HGiIISK/5J7lFhdoXQXCvgaM+kUZwK?=
 =?us-ascii?Q?KZliDmqSYGcDy98SLanJwCzdqXEvfHm0Oh2uIYb8XasQv4wByrze3tKCqcmx?=
 =?us-ascii?Q?NsiLgyyA5ThS2rK9aASV1jnceS5iKuy+LQwAklOPsJ4SvTZHzV9Dbnlbger6?=
 =?us-ascii?Q?sPw+wYBoBGXkQyjK1NhUFQckaQ2kruOzV0OWm7I3fwNxmyvtLoOdl0PsWRs6?=
 =?us-ascii?Q?1KUJAACjfZOB6PNqx4LOKkn+6CoJG1SGZ+MPVMK1QJkWkJ5cBe6/82CwfHBk?=
 =?us-ascii?Q?8CaU86KGX6E65ou6LIcTvnQj8M1N1M+c/IaB4M5iv8ZjhtDnjCZe47/0aSNM?=
 =?us-ascii?Q?IyIhtgzp8Ch7bn9pbKS+PIL56qtYiNkQGfIGWZuSMw0prci01JdI8nW3gX74?=
 =?us-ascii?Q?mWAmLVPfppa8jkz6zva0xtZShrR2b5ro2RBKUs9BXjdcSiwO7HNXFnv8SVvJ?=
 =?us-ascii?Q?/qV3a0g6SNVsx5LKUDnAVbvOBYzIagFOZkM2V3uswWl7X5yTjSZrTTt4+u4q?=
 =?us-ascii?Q?Yt4SSvBH1invJPigjFg11z7WsjgBpBrNA7GX62aEWeYL/84Q8CWak7xmAXV3?=
 =?us-ascii?Q?Ew/QQbymv/gJTpxgrrTp4Nhb+oX8PtwO14o7Ah3SMxKaQvw43zcESg5JNto/?=
 =?us-ascii?Q?a1YHYSjRBw4I/benAJlRbpDAZ1SyjIegRZEzuIi3NkcwEYIKxC2goIu74qVH?=
 =?us-ascii?Q?ScRYHhODkpuhVksDtD71QxzVW+0G6zA8BYCXqIyic7y2EKF4yqG+kM+fOzto?=
 =?us-ascii?Q?IVUfOqGlK3qxKwEEpTQ0tolA8e8iRF/G5Susco1x301Fz+WzwgS4/gBcXmfn?=
 =?us-ascii?Q?AJULgFAozpc7o5xU/nSO9kePbTwB2flthqyOjUZ/+dCXxF39UnpdVcNjUzmC?=
 =?us-ascii?Q?ZWLDg5/x4Z+i06gGqfbyyApmmKJwJf86O+ps+PHUY2P6h54cJeTrFTSHsMGX?=
 =?us-ascii?Q?E99l?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0702368-88fe-4898-540b-08d89ce61a22
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2020 08:32:16.6534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BOLYAzoQy4E+Mqhq8I0c8tXlVnae5FuJj/L8A/JEP30uG7yZQjOzB/xbFJ/fYE2sZLqUdKP5sbBRq4CpbPfaZ45kzQgC+13XFvbXL96jcyI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3885
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/12/2020 08:57, Christoph Hellwig wrote:=0A=
> Hi Jens,=0A=
> =0A=
> a small touchup for MAINTAINERS and Copyright updates for some of my=0A=
> larger rewrites in the last years.=0A=
> =0A=
=0A=
Looks good, for the whole series:=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
