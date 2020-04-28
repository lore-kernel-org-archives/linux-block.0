Return-Path: <SRS0=S1TO=6M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD8CC83000
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 14:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42AE4206D9
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 14:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="IV05BtxV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="C/FR62e2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgD1OX4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:23:56 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:51923 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgD1OXz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 10:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1588083849; x=1619619849;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=jzmxPBMt4WAzC+HJzVX3qxj2UEye7xkPJZnNMrAtEA8=;
  b=IV05BtxVuxuujPj2xR1P4oA85/TOiIOmIVqANNpOFUMYDuWBuGPN1h+B
   zTx8pGUzrJRgZUoHDcV9rX/2rLvkmmmIUg0V+EuWNEmm5azjadlU65IbV
   +3wNhQb/TyD4Jk41CjufOvSEJa/ONtvs80UGi3TSjFqmaIQdlcfarfa+q
   MBpS9B96AZhrBuhNM/E36GMr5rW52Tk1LBR5MtYZz5nlBPTx0MUzpjSkI
   LZQuoQIB5KZSQd9D5qE9vXHmbGo0jhhfrlsByrhrJOnbHV3yW/DP3OJIj
   /AO2vN4H5kXi+/KCXiymgRB3oJtz/Om851qMPjPO6JpctDL7HPGy6lYRW
   Q==;
IronPort-SDR: X90+vV177kyEf29lNOq1G4eENK/LCKgaZR11gQxnuBi/eekj3lk4ceGRJKIj5A+mTGmaCmcRaG
 SJYcbpyWl339Bp1FZqe8LSQwfwiJBHYMUtC/E5E2kVkIpZZBr6Kr6+7kbHOdDDaW/IyRrLRP8L
 bMWHpLOJ4keDpjL/YLqAQx5Da8o8MIyDPiREuMMkl5G8ZE5sc32nEplu7Esj6PyTCDlCrAaPw8
 YjtGibLdeZVFkIt9hkYlN86EgzFdKMjh1dz7BJvJ+2/Dgg96a79buk3nkPK+dfzflEDyHdH6TT
 mFI=
X-IronPort-AV: E=Sophos;i="5.73,328,1583164800"; 
   d="scan'208";a="238910044"
Received: from mail-sn1nam04lp2057.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.57])
  by ob1.hgst.iphmx.com with ESMTP; 28 Apr 2020 22:24:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FeXW9uMN5GFWZH0g3Ys2aTb38gW7RWkPUCxxoPtgeUGlxpFscSv01WyQMIPEiIxPna/pFlzVJBJzCubSkbBb4gDKx8hgyhsQKgy4+MpEfkzDKMx4U/K6GCwms/aC9IidPqausALQSpcVegWkJ97J3dhJHUuIFgNQdgBbd767uKbrWC2n1ePAL6y6ywpPuAWUmB99SVQXcnm+RLRq9lY33yTHuQgHBubqWkV2h0pa5bVrIt+uvLiyHFz/QbKcj/igjNDlRkKrOE5Z5bF+RHHq8x3qOIPkuC5iElmsNEBtgX37p9N2MpvuQzSkBcBzE21FeSnsjyxRll7836hI13qOdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRCizDaC4920CSXKQaEvGzQwAo/nknsVwXX8AHr2irA=;
 b=njGixScKvIHk4B1wOSquMmhc6RNuHN6A/e08+Y0ICGLUJuOD9bz6gKARNdE9uimNgnowC8uYQEewGq4BrDPe0Qk2myw80CJChsswIAP9CPYXUbqwKc96ZL8yeZtnLk/GZF/B7H0Lc90YQy1r1FC9nmEWqSJ5QF5YjobUUNO9KjyHFroAz1XTECMdJNMF0+iy8vGJhnMYga6vkjzecLXa9v81vBq/g1ZNiVEROro+N+/PhjXBx+77NGGvI7egMbFt6rh40CXEMAWLa4C5k6drz+xcq38qHb1rmTuQHOa8eSZGA203bHiT660ol3d/8ltwiwXHDcaz3V8q9TQAUvJXdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRCizDaC4920CSXKQaEvGzQwAo/nknsVwXX8AHr2irA=;
 b=C/FR62e2aKtHOtO4Vuo1rfkclv2AuHeCRt4dXUhEmuLbGHj6W8Nv3Xk2U/Bp6dV21PQ6XRxcOVLSeMlQu29Y4y+sntV5B9oqlAtt/K6VOKo/pJdNl9lLr7i6f1WvGaQnNFVD+hwZF9km67Ip4G+FMFeRlF8IvUWtQH+lFYXoY4Y=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3551.namprd04.prod.outlook.com
 (2603:10b6:803:45::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Tue, 28 Apr
 2020 14:23:53 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2937.023; Tue, 28 Apr 2020
 14:23:52 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 3/4] block: replace BIO_QUEUE_ENTERED with BIO_CGROUP_ACCT
Thread-Topic: [PATCH 3/4] block: replace BIO_QUEUE_ENTERED with
 BIO_CGROUP_ACCT
Thread-Index: AQHWHVAY3CgTxU7Ag0e6wj1uAt5W9A==
Date:   Tue, 28 Apr 2020 14:23:52 +0000
Message-ID: <SN4PR0401MB35988020B036B6E1A2D974129BAC0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200428112756.1892137-1-hch@lst.de>
 <20200428112756.1892137-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8352d41c-5d1b-410d-824d-08d7eb7fc719
x-ms-traffictypediagnostic: SN4PR0401MB3551:
x-microsoft-antispam-prvs: <SN4PR0401MB355185CA0010431071E138229BAC0@SN4PR0401MB3551.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0387D64A71
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(376002)(136003)(396003)(39860400002)(4326008)(6506007)(26005)(55016002)(71200400001)(8936002)(81156014)(52536014)(33656002)(8676002)(186003)(86362001)(9686003)(53546011)(66446008)(4744005)(5660300002)(91956017)(478600001)(76116006)(66946007)(66556008)(316002)(64756008)(2906002)(54906003)(7696005)(110136005)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f+4paJbNkD4j46BBejXcUYsFdfOiOJ/8Cu5xhgbPsmF2IsJ2kqMO73TmQcdnSqqn6DXEP2fCMQZLW+xYQHWLh6ZX9xyyEeNd22uPFrE/0+LLGqZ4SzlaCbPoupwWYIUydDbQnx1x20QoigDPQOZqx4sssYLoekqEOnYdlywVo6vTYCpVDK9cc82928j7C2i2y2YQRDrLoAAdNQ1BAFjitWhpz4O0H0d1vyhCx/8/5L85n3/FqXVCzcmdhnktkqjpSQ5csh2iCq5TPRvAgTYLYHlLhq+b2ZuG/iZSkZHysaKBT3PbV1qGo85G9tnRt9+c21MA7SfXpDYxgqpfudhgccApIcZK3T2sxd8WU7w7HRIfzXBZf6OcYSE4LILiHFYfeZGhhRjoEUqqin0L0qjS9njacFyzjyEiR3HNhHniEZVDF7jCmPqMMZaWHAV63Y04
x-ms-exchange-antispam-messagedata: zYaR/R/lsNamQBnHytksx9l1aGLXj88zL4op5apZ/v2GkDlrGo5xwiUjfgq78HQr0e/6Lgov7eDDSC2NyikP210IfUIoC9CsvWLhbnbpFVl2AvN3iZA4bhQD8YBAJE5IK88AF/ju/O6HyA+yHr4v2mBwsrQJHQn8D1mZ1QJO8RbOWNldJrVN96olsTRB9IbUN5uiI+UrOnAFGRI41ghfxUVozyhu5sgI72T6ukeYUf1NOU5O54T+spbOlI7bFuw9LNrr1SNRKH3QWQnl+GJSaSF+e7u70sj/g3CwUpLNlMtSX2GdFp/aVn2jXkgmgbVFL7XdzjcOizI74mNKGrMrdQro3FlNM+vOc178/pz9YBjyTVqi67oEcfqNpuUpvhgg2Rq62lxuG4Lo2Emq5cMqVfIQZ9hjElfgnC1W5MAlz+8ZNNqlS+Vl6vKRqWjyt5Y1FCipfgXuo+VOEN20CtIMvdtQaPV1m8G8GAO+1YAo3/S3WYeyGqY5p4RRxgSvjh6Jx6B5i44CpehMOu5KO40HhOIri3sWbDtTxHQhfU3adbjpKVrDXzYPnjHPyb1MkT9EwwapJGyMxADntqXtyJw1h6YwT5WOoa+0sFntOITVkj+zTPp2LUFtmhR+rVSD1Cap2b8nZd4+H2wmql/qagdNYY/gxhZ/yAeuGLeHWBC23gB/7kuaAMjlhiHfZJsZPak0g9lN86vqZqK9WYpIHixtiza5dW6JzEMsuE5xNOuiEmEgzbzOHTYAXvqVBct4tkq0cmOC05tVLqkd52l8Yyh/kQVjdF084mF27nDhVvcnh9Y=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8352d41c-5d1b-410d-824d-08d7eb7fc719
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2020 14:23:52.8636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l4Ni64sdYxdiSGQe5MnAu8BJydLttj0QkakP+ypXBRSzAo/gnstePcQPL9MClEcVPlPgq6IrPUL+1uTMfrtWv+MDAkTGxfS12ZeCvQKLDEs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3551
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 28/04/2020 13:28, Christoph Hellwig wrote:=0A=
> @@ -607,12 +607,14 @@ static inline bool blkcg_bio_issue_check(struct req=
uest_queue *q,=0A=
>   		u64_stats_update_begin(&bis->sync);=0A=
>   =0A=
>   		/*=0A=
> -		 * If the bio is flagged with BIO_QUEUE_ENTERED it means this=0A=
> -		 * is a split bio and we would have already accounted for the=0A=
> -		 * size of the bio.=0A=
> +		 * If the bio is flagged with BIO_CGROUP_ACCT it means this is a=0A=
> +		 * split bio and we would have already accounted for the size of=0A=
> +		 * the bio.=0A=
>   		 */=0A=
> -		if (!bio_flagged(bio, BIO_QUEUE_ENTERED))=0A=
> +		if (!bio_flagged(bio, BIO_CGROUP_ACCT)) {=0A=
> +			bio_set_flag(bio, BIO_CGROUP_ACCT);=0A=
>   			bis->cur.bytes[rwd] +=3D bio->bi_iter.bi_size;=0A=
> +		}=0A=
>   		bis->cur.ios[rwd]++;=0A=
>   =0A=
>   		u64_stats_update_end(&bis->sync);=0A=
=0A=
=0A=
This is completely unrelated to the patch, but why is =0A=
blkcg_bio_issue_check() static inline? It's only called in =0A=
generic_make_request_checks().=0A=
