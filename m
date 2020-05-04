Return-Path: <SRS0=XB/C=6S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE3EC3A5A9
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 15:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF52F20721
	for <linux-block@archiver.kernel.org>; Mon,  4 May 2020 15:31:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ijtIdzTR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="gcz9aO85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728880AbgEDPbN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 May 2020 11:31:13 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:34414 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgEDPbM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 May 2020 11:31:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588606290; x=1620142290;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=PAT/8UiFSYA0jv0Z/tE+/ObmqBNqcGu5ghcBJUj4h3o=;
  b=ijtIdzTRjf4PqJgxo1V1ASxevuO2hV3HiKx+UCNTTFctRNJQnPXlJDyC
   k6WubuC6oaf4XhVa061ip6aulBnUAzjGndgmLp2gDt+Cia0HBlFy4Q/JI
   msUCe+gvNjSkiILtExQFm/zpi4yDyf1ZegHLFZHJ+SHzmk1GPhNqm1b0S
   WSg8tfiQ5wELEAV4tvpluAdUD9YbOHyxEL/D1YWM338d1J9Vav49sPcuv
   9LFTHLAH1Jyce2Z/JS1a5zHK+/qJB6ieNeLTyHqmWIxAwowRtczeEYGgF
   Kp8uviZJ7MB2VOWqcau7iMTSIb3KnyROe2L50U2JsDMJzY5xSM5rK4acF
   Q==;
IronPort-SDR: MgT0SjDlB3hSmxJ6mRF4q6eBV0an9iw1ZlWbGxpBurPCnjLDXfnjGYVaeBU3srJRWhnvg58Vl2
 A9ZnYufIK59evVWdw4dhH9ViGiFXNgy4QwcaYtIuXv7mh0ZoAO/JGs92LfR4vDjBF3LIncMdc7
 GfxFRxg5KpfKIO5+ww/vlH69DvenuWzQQ0FQlTZ2EnSicXRvCXoazIwwkd5xSg+LhJBwY7jY1T
 bVaIyYj+/uV/Ym5WTEdcIeMTYx/nHCFZC+lBouO8a019s71ZK7inAtYQlZGRvcxjE2CNPujsho
 0Ko=
X-IronPort-AV: E=Sophos;i="5.73,352,1583164800"; 
   d="scan'208";a="239494057"
Received: from mail-bn7nam10lp2105.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.105])
  by ob1.hgst.iphmx.com with ESMTP; 04 May 2020 23:31:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JQT5vlLsBd1LhGY5dHeEGat+lXDZiHZXINiIDLalBPABoWfnLWqEJGPHP+Ul2/iRKLz4fg47c1I0j8IZpd9R6tiiHRoL+wbz4MQ5FrM0cWIwAT8FACwnLw2jR4U/kLTFmDZJNygpSTtNbjtbxWf56HIIEjvTPckjGQrDIkg45GsndYAYHSB3bEoMt63IDjrHpI0kQRsLMi1NcbPYHcqh8LXwBtkIM/C8xofzPswjuKsfgt+xHeklpQzA8og4fV5yY+IsqoOGFLeYL4XoTmfKklEyLAcwJio72wYt9UUSxrpDkUeMpv91ofLFwJnMAlZiooHhtGx3qwR44vrAzcuDXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqE65i5gwmcFTtjTBLGjFFu/+J0sYaHUljdn7TPCEd4=;
 b=hBIlT0JbFAeo1hA3nSg7gCQyvXxCBsKAvkXosaSXrqkgb328boWVPpgoNipwyd5o3ZL0BM4auDKiYznagg1xpHAlACbKWx+GKkO+AVqp1dBTpMjqfge8qvNZnTiAk5kr4t8Z4JC09E8AtagSJKok3HSUnd1cmR6LOeSXQeRDm+F8se9N/EoTiq3/rm3TgF+lmWs1Hs8R7vF0olIO7YhPkXBxucZY5VEc5vjg6MGykOK4L0Mm5enscDLkXpI7v+mx7g64by+MQkTw+RV6XRkdvU4+79HtQ9xTDOSJ+SgjW1BwPDSt4cYvYi7oUcGVy2UEcIbPW5Llm2tnpKwmRKVyaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqE65i5gwmcFTtjTBLGjFFu/+J0sYaHUljdn7TPCEd4=;
 b=gcz9aO85nUJe9osvrPBcYAvfiCfTOo9PTv8+l7E+EX4COJ7DBkdockzK07lrr2v7BOHc5KX5/VWMq2MZfyEp0D0EelntNkhNtQGbBojJZk7rscsN104mgrwDI2EQW7eY5zuZiPCQpxkAsHjy9zvBGG2EvFFkcfEOELhfFElRGE4=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3583.namprd04.prod.outlook.com
 (2603:10b6:803:4e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20; Mon, 4 May
 2020 15:31:09 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2958.029; Mon, 4 May 2020
 15:31:09 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] block: drive-by cleanups for block cgroup
Thread-Topic: [PATCH v2 0/3] block: drive-by cleanups for block cgroup
Thread-Index: AQHWHwCa+7Yg+AL48UqGlFI7NvB/lQ==
Date:   Mon, 4 May 2020 15:31:09 +0000
Message-ID: <SN4PR0401MB35986D0947F81F79C330E48A9BA60@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200430150356.35691-1-johannes.thumshirn@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b727942e-36d6-49a8-ee88-08d7f0402b5b
x-ms-traffictypediagnostic: SN4PR0401MB3583:
x-microsoft-antispam-prvs: <SN4PR0401MB358357C5B04C53C1A7DBB2A19BA60@SN4PR0401MB3583.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 03932714EB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i3Ru3R2GNi5rCR5BrvKbHVAFQWQKkOfQdKHe1w15uewrIXR7Ohb3oOA6YIOw2+i9pU+BiQ9XfoW4NW6zew8W55Q4ikkqqP7gbaJInn2fs/WDdwkmMX6AaFOhUBxdB9S0zWYphXR5rslbgqVyUlVqAFHWXwul2ByFlWkGQWGtWoSiS2DTNg9Yenhm7hF95JWohuvg1/w5xB3U3uP7UbqwiCCQisRfW/ZekhCYB2axz1WyVrubpHCyXXhnTj4J2nFm/aIRMhTRizyNZB7kQA67QRs86x34y0Kf/GcbRV3nSSQi3cacNT0fXMYNm/NwCUzjVfk/ISveBKQzarqkL81lV/30dPU1oN2qtxb0FXMhXiG2WVAls8UNaKAXggAFo0eppyPb8ke8/FB00ij3IwhlaHMnOglPUxvvBhmGgPMncd0vvjur0p7pvHUt0OUV0yZO
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(39860400002)(396003)(366004)(136003)(346002)(64756008)(66556008)(66476007)(66946007)(66446008)(26005)(53546011)(76116006)(4744005)(91956017)(52536014)(71200400001)(8936002)(33656002)(8676002)(316002)(86362001)(5660300002)(6916009)(478600001)(7696005)(186003)(6506007)(55016002)(4326008)(2906002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 7j2073Vt/8tthJPN3jn2i8+Xsb8eGKWmcoZ3leYFGHtfUtXnmirYI5ZYnyzkcjBI1iKIbAnX759OskyDLDp10mKwjT/1iu2T8d/9ArPbTjY4qHVrK7U7oVDJ5IJ0QoyNvtVeGt7CL6KdcVu2pYkM6njtEUjyfsTBSKJ5LbzBynWH3kw+hK0faQBx6D+ihqTnzZgNUbRsXA4si5ykEPXYXCra5sJqJIPTar+uH4/hTqo10BzTd0TE+5gOpIcb72nfCOk4/41GLwDe+WP3amSK6T10GzsC+IcomI09lIbUaFJXJrUejcy6pzg/3WewhMtk7PGgJX5AIu01UjjOaglCUw4E0HOPMFTsxmqRMTz5+55jsXpylKEhNVwwumLuW8pRdihWWYCLliWnL4ibhlcF6lwSwZYNiUpQ3wqUv1ICglfiQug6ogGC6HNKJBJFIwjG3sPHYu7SR21ptuzvOKh0S9mnN8EzK8gHKuG18BwMzdZeFcX1gcjeVrpYoi4H3rjkVQ3sFwbr1sQfIQ7oAkU1IP6joPKXfy4MbjIWLXpVLZlzEHZ+r8zgg71H1XG7T41nIyZ5NvK5Y1qwGPbhVmv0bEwgnhMKAG6ZspWHk5jHkZJfE+9iXYUIybuVT9P1aKYQOjjr9L9KEcIBtWHunWF90es6UTSOn0K0Vt+3uf/pkbIvxgXqdUByzL29W0DepttwWLPMi6o6GaGg3S1H7Y2DJ6jk/cu/YUFIdfnpZTbslXnIH3EWw4hDU9AhsuNWf27mQLoA862Amg+gbPoVHsI16Eg3ac8IZMJ2RqExPjMh9A0=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b727942e-36d6-49a8-ee88-08d7f0402b5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 May 2020 15:31:09.1353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1fRofQvHlQwV25uroMoSI+lh46Z7kF7PFRM2imDZjl1ZSzYeq7RS+QaNRfNpaORIV90jEot7+p+itIWvLNh2MTUpkynDtBu1dQHajVKvhkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3583
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 30/04/2020 17:04, Johannes Thumshirn wrote:=0A=
> While reviewing Christoph's bio cleanup series, I noticed=0A=
> blkcg_bio_issue_check() is way too big for an inline function. When I mov=
ed it=0A=
> into block/blk-cgroup.c I noticed two other functions which only have one=
 or=0A=
> no callers at all, so I cleaned them up as well.=0A=
> =0A=
> =0A=
> Changes to v1:=0A=
> - Re-based onto for-5.8/block with Christoph's patches=0A=
> - Removed white-space to not hurt Christoph's feelings=0A=
> - Added Reviewed-bys=0A=
> =0A=
> Johannes Thumshirn (3):=0A=
>    block: remove blk_queue_root_blkg=0A=
>    block: move blkcg_bio_issue_check out of line=0A=
>    block: open-code blkg_path in it's sole caller=0A=
> =0A=
>   block/bfq-cgroup.c         |  3 +-=0A=
>   block/blk-cgroup.c         | 57 +++++++++++++++++++++++++=0A=
>   include/linux/blk-cgroup.h | 87 +-------------------------------------=
=0A=
>   3 files changed, 60 insertions(+), 87 deletions(-)=0A=
> =0A=
=0A=
Jens, any comments?=0A=
