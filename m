Return-Path: <SRS0=YBka=5Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CA8C2BA2B
	for <linux-block@archiver.kernel.org>; Thu,  9 Apr 2020 11:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2422B20B1F
	for <linux-block@archiver.kernel.org>; Thu,  9 Apr 2020 11:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="N75DFp4C";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="p7ZsLFuj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgDIL1U (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Apr 2020 07:27:20 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:7209 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726470AbgDIL1U (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Apr 2020 07:27:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586431681; x=1617967681;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=N75DFp4CIQvyoTKaay9Bfxc7DuIYuqz6w6KrFBwwNVinzX31dSszqga9
   osPMCf52uMk/lmJRX45R2yLZzo7D0KnqMz4sOSTik2iSAj6T3jBMftm9m
   qWYB8ZfqO2YmYHOk+DBrlNJ5I3FKVCs5Ti2cicomcs8dygU0UmeX1HhyP
   83PRykCOP/DQcMWQE3VT7PVIbZVxuZ/iNHt881OLoNvCWErqv6MTut2g9
   iYO9hxVEHCCQl+HkFJZt7qEvzY6Jt6BnUPNFj44XzgFec4Ozj3inIzN73
   ca0PRS9w09/XY9aVIncT296HHmpe1hs9XVsLClSc2meDKDdXtJ++RoOYM
   A==;
IronPort-SDR: 0DDdgVWcWgVgGCZaukeiAnf7k5mWpCAHaCSkixGV8y/DKuVtEXth5hhIEkg4TYP6mvboIKnsTc
 uLGj3+z/s9k9ORoyR4HVw4UGT3sx0k81j6allf0hVoWvYAKWrKjBWhvMQPWT0FBI++mttcFiDV
 /agBPXJxmqdB3fS4iNNU+VqGe/HllEhJk0RJMbz2+De4f2+93SJLQmMHSNUhFZfsFG8UQXeBer
 XQ/aTdVAuQK8clTKlnE4ihSXa8GC8CJnk88FEn6wqjqHrlhvRPgEvTfFiBo0GgoUCtbw6dBRo7
 8sk=
X-IronPort-AV: E=Sophos;i="5.72,362,1580745600"; 
   d="scan'208";a="237300214"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
  by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2020 19:28:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCdR0kKMT6XrXW6i40Li332SHnMYufe/NPkFPP0KtEDkr/DV6xjnLdVB/Kwe6e62rvQ+y0y/w5Dc+QO9MFEO9cHCRznVpuxxR3d+ZOSDzTLWkoGmlCd/ZGjDTYXnXZRDypbCPL/RO4k+RrgaXyF8yVjMRKJnZdqysw1ScGjfSwPnU8OtzY3Yh88hxh9iPiAsbDFaqFt8UvJvCEUqfVBs+LN7OfFlM4eQ0e2wixIo/4s078PzNjFk6hGmhGfA6stYRJgOlddtJ8E13qHEIEkfX/njNM3n5Noy++GSQyilZoQUrfkjeXGYPIEIEg73T6qaMx5KVF9hd/34XnKODrtrSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=aHvvBMhMXchDdFKGs2ABcrZ9RXZ2MKHEpGA7xUHcQVzFkyPw8mSng2pU9pYxDUytF7MuE9YhmWfkJm6r+wD1OH4avfUwHk1I74Ut7bg5inIfexr7YeAWSsIvrzvTequISr0C63m3oY3tmpdiW0Hi1oGHAcN3JoVmkgLDA9slkzEchpDp33Pd1TPRKxkOf7XjYUaOeBAF5c1Cx0azv2PeXzRvrT21H+kUjkCVMXVg+G56psYTWuJEFtue2G6OvZaPYxamaykrFBCimd1eqAfKSnOafsHTHueCOn3J302h/BnxfYoIHM1yZkDGUrD7v8rnO9IFI6OkryFvbuosexVEbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=p7ZsLFujQEd+t5H+2melX2ET12DB0U4Sc5XExcaX7q1REbjFScIsfwp0s+WUvMp80eiOPI0TyVPFYRPhpFBPh/L1kRR64V9D/w/ZOuFZeKP4kWY1EgqiVABteU9HA4uo4LVdRpH+eJ3o0Y7axI+32gDojQc1sOrAh+mRlqOeBx8=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3678.namprd04.prod.outlook.com
 (2603:10b6:803:47::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.21; Thu, 9 Apr
 2020 11:27:18 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2878.018; Thu, 9 Apr 2020
 11:27:18 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
Subject: Re: [PATCH 02/10] block: pass a hd_struct to delete_partition
Thread-Topic: [PATCH 02/10] block: pass a hd_struct to delete_partition
Thread-Index: AQHWDd5DPQ0fMg98V0eqFtmGzBHrLQ==
Date:   Thu, 9 Apr 2020 11:27:18 +0000
Message-ID: <SN4PR0401MB35981DE8550350FBEF2887699BC10@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200408194439.1580699-1-hch@lst.de>
 <20200408194439.1580699-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7b71a7d5-a1fe-43b7-69af-08d7dc78f69a
x-ms-traffictypediagnostic: SN4PR0401MB3678:
x-microsoft-antispam-prvs: <SN4PR0401MB367830156E0953608E604DC99BC10@SN4PR0401MB3678.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0368E78B5B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(376002)(396003)(366004)(136003)(346002)(26005)(2906002)(8676002)(66476007)(52536014)(66946007)(91956017)(5660300002)(316002)(81156014)(64756008)(6506007)(66556008)(7696005)(19618925003)(66446008)(54906003)(76116006)(8936002)(478600001)(558084003)(55016002)(9686003)(110136005)(4270600006)(71200400001)(186003)(81166007)(4326008)(33656002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ryoFCi+ubY+A0qb4KTIOF3YDhM2bR/rKL0RhJHJXQroSCDzI5dml2SXrzq0ljUh7NFbJfWD2/FHfi33+/GSjE06KX21vM57ON5BTpnHyvfFLXXKchdgOw674f2vNcFNDMBS/IhLrr1vLjft/td0U41aRe133G2pGx33qi2yCW+F0p/w8bwp95U2+pczHcw1o1NVHaeaC9b73y+PqPH/BvFFcfK6gDLdLjJF8Y+OmR4MC80W4UMxvEKdJr62NqGpjvLqpyJqogAwWly8nS75hZVm3Y5/mHVrSz5RosuZi23JBMaq8naBDCSzNNXRQmmRgLHfcSQ1be4mS1SyA+lG/4xXyeMDF8/Z5l33KT/2g2PrvFaQx+Ok3MUYWIcHDC8KifRZ6uQii0GOOrOVUMrtJCLGPQ/u+IGJMyJ9bOXvyfXh3AVZHG5n3/7eTBQTifECu
x-ms-exchange-antispam-messagedata: XmUsQ3KPS/NMhHi750dED6FcUY/l1xXqO1ZlfntwX2Iw7MDU64aIwoE43QL0Gkod2+9OkEln95qp8QWB+x6hGDKLGPCgpBC/OD8GSaMwEjKM7VT/7EZJJ0t07HQ9emRIemxDHh4tLsWrMr48gLJDrg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b71a7d5-a1fe-43b7-69af-08d7dc78f69a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2020 11:27:18.5586
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a0iRLWwuD2mbEHvo1qYdO1tRAqLB3j0wa5qxwO7Qo/IV05AsGbwlvTfosLAYpCHiCOKHf4reC0w036FZ8lfibg7TmgfVQFyH3oLpYkBl/2Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3678
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
