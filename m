Return-Path: <SRS0=YBka=5Z=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EDDC2BA2B
	for <linux-block@archiver.kernel.org>; Thu,  9 Apr 2020 11:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B73A20771
	for <linux-block@archiver.kernel.org>; Thu,  9 Apr 2020 11:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="l9S9fzkv";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="sTMn1lTQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgDILd2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Apr 2020 07:33:28 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:26035 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgDILd2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Apr 2020 07:33:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586432009; x=1617968009;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=+e5JmmVWDmd5Y3iuswzjSySds7aBs38lg+A61pBDpv0=;
  b=l9S9fzkvwGV9W/qBPQfBXtbGDZEfOyNUKkXLZtyNTONIuU3vqdDfcqk8
   BFKs75jmRw/7YTdFYDMByhKlLdrvXbXYAn1TndSxaEYJyVs1lpse2aNW/
   AMeFQnxXs3NePrrrDXmtdsL/mRp6LdAa6mc/fncFds9cLAGLJSjYb2mLe
   uug9CQmdrRvTBxkymg9Svz/lbZKaFzcVRHAgBywCcIJVqNUrIYXcct5wG
   yxQZnnqBNoX2AaW+1VKdFObqI6haoDihjBeoCcutT8JMBkonx+k2h/0Fw
   ZD0mI3Ib5Z2zhTmHBdNtCXLQFo/nPmRtEI+WSOL12sONJr13aT2sM4vgx
   w==;
IronPort-SDR: 8OMNh7AjbJSUP2+SleiUdWy4zEFvzfUNriCeIsWAa1Q+HYJI6raXr68gDr1vTpqwyvySy7pxuD
 Tjod2md7kHYlsPF7DKmRn755znGK/TrwDFYv7wBU2fAllBDBEv8sHab6aMwOP2HxExMfN2iw4n
 5bAiRpkYUHGG+iE9ot4MX2OJSoSD+8E1J2cN6RDsg5bPMF0DUt7fC3E/0pKMvpDRvuV+rj36h/
 dBLpqEK8SUI7FmkPoyz+OP5Td3qqCs4DmkX3mfab51NSaqFAy/ZUhZhsW0Lujl/mUT3Nwlk7cg
 Wgc=
X-IronPort-AV: E=Sophos;i="5.72,362,1580745600"; 
   d="scan'208";a="136402892"
Received: from mail-bl2nam02lp2050.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.50])
  by ob1.hgst.iphmx.com with ESMTP; 09 Apr 2020 19:33:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nO3bGFREvHMIck1Gj8R1jhDk1iqFjrMLuUEz9sLn8neBul9DCYhgQiXKZCOpBe3/o/vEbE/siOEp9Y7oArGwYhFf4Gcx2zNCGjR6dLHJVf0l1w3QrGRuAn8BxKoi2GCA4TOsYPznbPkv2B1mlMN+LNRDPQ5j5yJLIWBDA0UCCMSMtzCUpU9AUIilxt8n7pEFtYC0cyk01kImWD99VSIQkslOqcsR5K5oNjurscRfyJEBfZ6y/yOYjGgktNf4vUU6PRmBETTTVbTsuk1qqWbqAzCK+l8BL7fKcGASvW74nOqgcJIjbtIvKIJeoexVaL1IS1gbIHU9lfq4kqd/K596rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d42mzT0cKxbulLwQMa3HC7EFnEGNESllLF28s7MKrtk=;
 b=PPC6E3aQazwZH5xPtZO/n8nLQql5vo3nreapJMcUf/LV2g0swj0TkdS+WbX4BoJw8IFrw+HKqIoyl+vP2GkRpemMTAL1RNuk+y5dZzKnvQJOVhlmZ+7VkDreeCHXWS/di8NMvnRoYnrdaXdmpx06vl6VccmNZSNXTMcYjuEtCWrAhOrprbBhVRdHV+xx1ymeo9WgQTRFiHbw2FnLXdXzn3Bpl4Akr0fbz1YEWNbCJ6Tlfh2gWYnz0AsMjLYThRICvOGv1KFXJdxR9s1GVxW1PGPmg1Fd5pTu3kWSWqJwJaCVNME2dqI9TfM95dhfdtuiG2aT8YTG2iWKytQyc5vwbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d42mzT0cKxbulLwQMa3HC7EFnEGNESllLF28s7MKrtk=;
 b=sTMn1lTQnOR99kUc5rzP7iKXkOr6HsuVuRZNml1w3ESOg031gZxJrUAHsqlNx/Zw/imejP9MMy5EVj5Sh9MJx+eQQH+rVpQrPSi1XGsw6bwPMvYLvP75GbOdqm6k9NV3SaIM136m3g8SiMXBWaVwLLJOMQALHmGVoSjuZermD74=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3662.namprd04.prod.outlook.com
 (2603:10b6:803:47::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.21; Thu, 9 Apr
 2020 11:33:25 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2878.018; Thu, 9 Apr 2020
 11:33:25 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
Subject: Re: [PATCH 05/10] block: remove the disk argument from
 blk_drop_partitions
Thread-Topic: [PATCH 05/10] block: remove the disk argument from
 blk_drop_partitions
Thread-Index: AQHWDd5DPQ0fMg98V0eqFtmGzBHrLQ==
Date:   Thu, 9 Apr 2020 11:33:25 +0000
Message-ID: <SN4PR0401MB3598977E7D85FA660AD5A4519BC10@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200408194439.1580699-1-hch@lst.de>
 <20200408194439.1580699-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5c540b4a-67a7-428c-41b0-08d7dc79d104
x-ms-traffictypediagnostic: SN4PR0401MB3662:
x-microsoft-antispam-prvs: <SN4PR0401MB36620ED4CF76B0BF5D2F97319BC10@SN4PR0401MB3662.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1332;
x-forefront-prvs: 0368E78B5B
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(136003)(376002)(346002)(396003)(366004)(39860400002)(66476007)(66556008)(66946007)(91956017)(76116006)(33656002)(316002)(110136005)(64756008)(66446008)(5660300002)(53546011)(8936002)(6506007)(81156014)(8676002)(54906003)(9686003)(71200400001)(4326008)(4744005)(2906002)(26005)(478600001)(186003)(55016002)(86362001)(7696005)(81166007)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mRhtEsDHI5Efpa4PA+i4x2E3CCsRymxc4/lzkT1UL0JBWvMuvSY6yy5eSaZY9GPgWon6Ay/3Hc+KMP60QuVaIuxSex995mr7YWpOp6VO+K40CG0Q0BFsW/C4vYu1FwIpq/c58rWqX9WUXMJdHDAumGbgS+LdBhgQJzjvlAhxjDB83+4Gvmeb+uDbWzePMbrlwf5DdyPODFQHaoj2d2IAq/nSBlb19gs5MipuJj2wOnvns/J2gPPWJth4Ub8JTc7cA9Z/zI0HMIqyh0K2USK9uDr85j3tIEAgq6IPkzW3lQrAi4RQsxN21jxZY5BxEwTBu7SHLR9ZuKlbH0jQOY/jLjbFmd/jgmRuvtEPEcO1jWn32eecMVpSkXxLNaIbDMBRVX0vtr1to/AQJtjNN09DxljdQsBT415z4LlygjOZZ1Au85hkDFl6qjTCk3nQ/Gf0
x-ms-exchange-antispam-messagedata: E4XruPzp1VnZbxqQ3H9kxUcDijvgyguiqTydkrkWaazAz7vLumzyQMg2xsBtuD87MapaFhuWak6e88wW3KSwT/pZ9NgMLKLt3QbUbFK/IfY126ryeWc2ezieta38RKjPFPiCSfBVlYlW50/dmZU4rQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c540b4a-67a7-428c-41b0-08d7dc79d104
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2020 11:33:25.0825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bmpzzyu9SgZ7YRF82dLm24bvNDk80M38BWXHieFmGiITkzev1AIzu3cRKH//E7Rf47i4sy1jjfmjIHvDjuOhhbXredmDEyVM73f6QTsS6JU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3662
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 08/04/2020 21:45, Christoph Hellwig wrote:=0A=
> -int blk_drop_partitions(struct gendisk *disk, struct block_device *bdev)=
=0A=
> +int blk_drop_partitions(struct block_device *bdev)=0A=
>   {=0A=
>   	struct disk_part_iter piter;=0A=
>   	struct hd_struct *part;=0A=
>   	int res;=0A=
>   =0A=
> -	if (!disk_part_scan_enabled(disk))=0A=
> +	if (!disk_part_scan_enabled(bdev->bd_disk))=0A=
>   		return 0;=0A=
>   	if (bdev->bd_part_count || bdev->bd_openers)=0A=
>   		return -EBUSY;=0A=
> -	res =3D invalidate_partition(disk, 0);=0A=
> +	res =3D invalidate_partition(bdev->bd_disk, 0);=0A=
>   	if (res)=0A=
>   		return res;=0A=
>   =0A=
> -	disk_part_iter_init(&piter, disk, DISK_PITER_INCL_EMPTY);=0A=
> +	disk_part_iter_init(&piter, bdev->bd_disk, DISK_PITER_INCL_EMPTY);=0A=
>   	while ((part =3D disk_part_iter_next(&piter)))=0A=
> -		delete_partition(disk, part);=0A=
> +		delete_partition(bdev->bd_disk, part);=0A=
>   	disk_part_iter_exit(&piter);=0A=
=0A=
I would have probably added a local 'struct gendisk *disk' variable, but =
=0A=
that's personal preference I guess.=0A=
=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
