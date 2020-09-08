Return-Path: <SRS0=nGx8=CR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EB20C43461
	for <linux-block@archiver.kernel.org>; Tue,  8 Sep 2020 11:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E61AA21532
	for <linux-block@archiver.kernel.org>; Tue,  8 Sep 2020 11:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="TYIo6hAN";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="K375qOZk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbgIHLew (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Sep 2020 07:34:52 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:65181 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730086AbgIHLbl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Sep 2020 07:31:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599564700; x=1631100700;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=KZG/NuTelMriNRCqCes2IB90su2FrgrXyTjZrBRfP3Y=;
  b=TYIo6hANQmJaar2q5obLEaq5zN2AaGgbJvDStc084eykF7w2q/lx0PFl
   lnhkUJy90/8YcBNBMGCeZ+VtrXoOZ4G2gS03EtS0OGbagwdOXSO6kpFGS
   tTB7zvRk90xBqqIfM7t/FbrAjp1lyfkpHFTG5IB/z735T7UjYkjjd1WVv
   PrlTbORt+f14r3rVY81vj8Q/DczQlRhoq6nSXPtCJlR8YmfkxD1BLe42i
   nm94NxXq2JEz20ywbhM9wDbRltnqe2K5latkJZrC56M93NFue/G0XySs/
   xTFASa/piQXUcbvbLoCdbHCoHi4Q7vjop3dM7oEmVcIzdCfJPMBMVGgy8
   A==;
IronPort-SDR: KtpqL0bsZV/25F2/bI0OVMHvTgkyGqj5X7aimNdrBkFZZMIdQ9eIoY08MYTGTaXnSyZIud9iEL
 YZewnfhU41FhHBO8HUh7FDIQq4TxiDHAOqOIy2hQk2CtPWpyEnGbN9Qgj32+dvzs+GarywdgBj
 ZCf8qPOKkpe+aBe8KNStYrOh0+UgJDBhp9S/XdJ556pAhkV1r3eEZ7bOS6O6SS5LqGH8ML5kF2
 b4ReUiDCW4fLvnkKwfeqHq03x32m9H8nFICOoH1Gi/L1EdqbN/1/fG5dKyRTb5dqonxWcbg3yO
 nQM=
X-IronPort-AV: E=Sophos;i="5.76,405,1592841600"; 
   d="scan'208";a="146741364"
Received: from mail-bn8nam11lp2172.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.172])
  by ob1.hgst.iphmx.com with ESMTP; 08 Sep 2020 19:31:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fj5etH2+HSWx5HQ4oBMY7elYbEOiPylqWuSI0MZcR49s6JBAwnko3IxTLC+7/vax3z/5WGJvtQnOd3T2Yhkt3h+oDKXkxP5d6wKZwI7U8npsP2e5+/I/TopVl6ot42hou5H/gom2ds//AGrblZNsPUIJj3dPAVTsrq1b2mpfHMS7/L4Eka4wU54Yf3ZzO1tNa94//RtkB2YbkPD0io5Jp+Tst51Hysz/XiRio04ykDBIUOc2jiwqcEtvPKsv1t7wOxauu8JDN4uiiLFy//ZzyOCK8nHMEdY1BoNXaJRVVH3ca9S+K1t5inzHX2v/O6hMhSoUP0XyzlNUQAuwV9mzNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZG/NuTelMriNRCqCes2IB90su2FrgrXyTjZrBRfP3Y=;
 b=aLCotMbEqZch4ht+D9JtGe4yqFGiSQtSVv+EebtvuHyleXj/M4IGzZvH1ncnFsrsOPdM3McukkVGPcD6We7oVM3GYoP3/STazno06LHSPnPBO+ZMqV9KQicSi4eY/zuycCekeYSaFm7eTjPoft1lz5dIpPP7eVKPl8tgY2U62ANqkCKnf0Lc4teDxzS/JdFP8z/bMRr1DL34Oo68ggYaZO50aoPOBT0i1OtdePlSn3chS47Aqb6STyztV5PyXqc/vBkXyxsecYuTt+nUyXZqXWOlyP5njDnv5swN+EnfNKEnFqkK4jsqxEa1BE3XpgnOmZTLJoy4699LOovruoEmeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZG/NuTelMriNRCqCes2IB90su2FrgrXyTjZrBRfP3Y=;
 b=K375qOZkcO6PPZumoV2S6OXi1sCv8T62bz1tE71Xno9YEQu9yuoe0n9+Au0GiF0A9BHRVBqqlMlXT4eGhq1024Ujogn/NZUKzUHRUfedO51n2JP1WoEoj3qDfgtqLqnL7s8AS5gPPO0YBKTT8urqxseLX1O87TN75oFnpCgfd0c=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4462.namprd04.prod.outlook.com
 (2603:10b6:805:ab::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.17; Tue, 8 Sep
 2020 11:31:28 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 11:31:27 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
CC:     Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bvanassche@acm.org>,
        Chao Leng <lengchao@huawei.com>
Subject: Re: [PATCH V3 1/4] blk-mq: serialize queue quiesce and unquiesce by
 mutex
Thread-Topic: [PATCH V3 1/4] blk-mq: serialize queue quiesce and unquiesce by
 mutex
Thread-Index: AQHWhbhN6y5xdbwP+E+IyHoHo5kJrw==
Date:   Tue, 8 Sep 2020 11:31:27 +0000
Message-ID: <SN4PR0401MB3598BEE7FCB019E3157338749B290@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200908081538.1434936-1-ming.lei@redhat.com>
 <20200908081538.1434936-2-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.205.181]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d9a17753-beb3-4fc2-4735-08d853eab9e4
x-ms-traffictypediagnostic: SN6PR04MB4462:
x-microsoft-antispam-prvs: <SN6PR04MB4462EB943DCFAA782EC0C8A19B290@SN6PR04MB4462.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:400;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VUtnWtyCEr0CuJPKIXSmp6NMGUrwmkE905Hgh6jhRx0tTBHVfL3OM6bpwXgASoLeVNKMwSLFdPhG/4cOhGaxIca4/5Jcdpa2Tu/T+2Boa6y3XrNZDksIlYqoZ7mQE4j/pTA2DV4+LK0eUJAotjQ+QnlDpLJi+rf/RZrFOvr1aHZmAA4q55SOZKAfcg4IOVfsU+0Mspmp96CJIOPN6aQguIY8MHIdtBOPNzxCijFSmu9/yGzaZA/dNXmZTifTInHsKOK8qP29SVq1pIEfk40rrX4p/jZ2vyOq9dBE/NGprdRMdVfQeEqVTx893B7rXhEorrGIXRqhOSrkWLYXx15vJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(66556008)(52536014)(66946007)(64756008)(91956017)(66446008)(66476007)(8676002)(2906002)(71200400001)(86362001)(186003)(76116006)(55016002)(54906003)(558084003)(8936002)(7696005)(33656002)(110136005)(9686003)(26005)(4326008)(5660300002)(6506007)(478600001)(316002)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 8UIrj+cVLaRNbnaU1fKx6PI1YG8glVq05TBMypo1IHvC8rUO79Mqooo94vueqhKTIZOU/o1Ju3NXJBEcukQM7RIWbnOJIcODGCeL5SkIB1GcaTF+gFNc6CVUZjFOktUJJueiVDJz/80itipBZl8Yw9E9F0jCIqXmZ6pOtVm0rCewdEdYe71ZmJKUKr/LUGbIR5h5ChT/2T2OUK5+GSrnfKgjSF7t1G6MJ/fS7bcbFJny6R4kh0dnA+RCHfkp+tks+yOxM9qqNHcq6Ktg5HfjkwJtfTOUhT0MLtfiG9TDsrk8qTFEK5jHJD0uP5annVTiwMN3zgFEleDK/UGbHdEvp7Vlo++ffwlf9X4cnuSLB8BVLL1fI4nTtkgCUaYkoXh0jQCqTq3aSYtPfibXxe0xo9HqpcTAuI+jIDNK6b/QrK0gatRaNrLKKXWvfaaKnLp49RQRlu8YHkZnkXfwqQnsYkYCAK9BmXFNe1YF2Gu3qdvMiLyAfso/hlG/mwobjBhJiUi9n2k9UJ2SHcfeazj7QftEL6+tsQk61G8kRsuGM1K+BkeXRxyRsoiq5U/QPj7D/FAq3NbaTj75zF9BLOZtlVyWHORAy+tQssbdoJEn34Dc1xahvwQejKtGRkPks5CONq2gajnXtWROrDIfu702MA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a17753-beb3-4fc2-4735-08d853eab9e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2020 11:31:27.7574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1p+sfMNFcvKfExawYM3WCC0EaJ4vxSJIi1A1n15biR5Tb0jVVkslsQoMNYKVwAFZwJOTjMUf/VCvNlLw72SqLaIDBMewEBwN68ewoqosWGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4462
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 08/09/2020 10:16, Ming Lei wrote:=0A=
> Signed-off-by: Ming Lei <ming.lei@redhat.com>=0A=
[...]=0A=
> Signed-off-by: Ming Lei <ming.lei@redhat.com>=0A=
=0A=
Double S-o-b=0A=
=0A=
Otherwise looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
=0A=
