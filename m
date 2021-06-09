Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4255DC47095
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 04:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B13861249
	for <linux-block@archiver.kernel.org>; Wed,  9 Jun 2021 04:14:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhFIEQS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jun 2021 00:16:18 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:11180 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbhFIEQR (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jun 2021 00:16:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1623212064; x=1654748064;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=X58b7pKIU6dA0KmQWz4shLt5mieVjHbpoN1u75OdI4k=;
  b=l1cHsA4+HOi0c9TRxSfGSDrBvgl+vqthmVpkFqlf6YPbOBixUU0xwVXc
   rPUucCI1CcshQU6okcZ6EiZqL2X1KsQkZSApRw4xNfPHjfp0CnumDFWAh
   gNB72sdhcgjRB6+z0LwNrcAW5zPuCp6oQ2GcP3uSPKKS8ZPISV6SiutwC
   hfVlK2/S6pb9dJ9p4muGtLxDbzm8jwMKc/H1+L2fCBVlbzhfkdtVcs/gT
   mPkbv8+6YTxaslmL0NiWH7H+KhGfE4nVsrd2ep2wuXQ21ER/txrDIdtbQ
   YxYnxFVIq8R8mvkdE/8qdLYFwwk0hl+1QxkrjIzkaD3hCGf8YPUsFaotR
   A==;
IronPort-SDR: eDgUl8Wb07UOcciCAGqGOO0HlmNeaV8nQV0IMO0VX0vfS9wW3yTYEATFV6uX2H1WO/qsXr4Nz6
 514aAIfwHTqbUAMq/acy+z76+FTLliA6JLN69VrcwBRqcMDGi3cpId/wqGqdHeUQ7tF0pd8x+M
 mBf44udgJFx6dz+ZrnfhD50hZQ65T2aWYRbZ9rNn2bcOLAgsDZGq9qAugRK/8sHDkdqXMG6In8
 d/xJffkQiPyeAuaTYTfC8FYN85LN1QqmE1W8oFXSm+3IrzAEhFo775bmQ1GDQtEEDjUJuGAjcv
 xCk=
X-IronPort-AV: E=Sophos;i="5.83,260,1616428800"; 
   d="scan'208";a="282681171"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2021 12:14:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GRkO/0FuEYQJ/fDSiHjrQQ+KXUaJR6BAJ36eFOzLHIb3JaWfQgLUMMdfmfxYzUbyhxiIYVSEvdJPI/hojCOhkD8daqveeYCUszaAWyCWvfQRpJV3N/uyAeidhc9Cl7zSYB9jrkWyjnWfEWy3qF/LViWfoh5LqIAfDVITn3QkfF/pONrkjTYvQGnqInZyoUIqXyAkvC2a1UZf9o6XXr7gdS/0fRampWYTVJuGLHAdWtLPZCZedv+OL28CeU6OoUyxmaN+XCLZA30V1C30TVHzTXmonv0UEpeKawJSgtXKhX7znz1Ak24PwcSvVfWRvu4Ztm+tXoV88xNeRTsojn8hZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndMsIZ28CEQM83k8ccDna/zUq+OuxOhLb7B+LzgNUl8=;
 b=JqCbCUBH6qxDwejQCDc2GJhDhejHgNQ7riOLZCejOxvg0bNRQCdAur7LZFFh6z99/LzgcGiJdVZR6wHa2yk2RnAObuBhrZXnVZvLbw5qUqkAB2rCQJ8NRP8bD9B8dqE6Qg+ASCmp1X+wsZAJ+oUMoG0fsJWrsyQzU80/Y1+f+sS2uCpvJErkAqmwEmGnOrOlOKz/wvstQDaTUUL9mKVUtOR5heVyJdTojK6g410b2s2y53eqcxaMTpBUGp8MboLsTwjhPlbon/UdyinpI5zbRK/r18M6hwOjOX/z+ahPzuUw7AQjlFJ7vizK+ULTH88A4uwnk3PBHorkWirvVzcvRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ndMsIZ28CEQM83k8ccDna/zUq+OuxOhLb7B+LzgNUl8=;
 b=vm2j8TTsl3hopNY7HlqDO3LD0eQ5Vo1TLEEUmw8dbZCxXBmJvDDpUNyetech0XyUeKl+4lSYua1oNH9IAYFZOll2J3FAFWZcSadYQmRZ6LVLLo09xlK2UES7aPXhkjKVvUFSiTiGPXCLX+NM6De4HSFhOfb0EN1duYMevmEGe5M=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB6395.namprd04.prod.outlook.com (2603:10b6:5:1f2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.24; Wed, 9 Jun
 2021 04:14:22 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4195.030; Wed, 9 Jun 2021
 04:14:22 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: Re: [PATCH 01/14] block/Kconfig: Make the BLK_WBT and BLK_WBT_MQ
 entries consecutive
Thread-Topic: [PATCH 01/14] block/Kconfig: Make the BLK_WBT and BLK_WBT_MQ
 entries consecutive
Thread-Index: AQHXXLsS0hI15kOvj0ug/VQNmyEsnQ==
Date:   Wed, 9 Jun 2021 04:14:22 +0000
Message-ID: <DM6PR04MB708138EE51DAB588AE780CB5E7369@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210608230703.19510-1-bvanassche@acm.org>
 <20210608230703.19510-2-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:513e:a3fe:98aa:a7ae]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fce95b3c-c728-4499-908d-08d92afd0f8a
x-ms-traffictypediagnostic: DM6PR04MB6395:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB63955AC51305131A12734D4CE7369@DM6PR04MB6395.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CMzVp48xOj/V5cOwX3nPx2xcbsYUIFV3eY5r++PFbrIsgXPkqoLSPjpGU5GVBktYagLUObau+iG+2/6a3cLO6XcNZ8Z+mbKHtn0cKLI/BN2vAlYKQNUKZP4nJe6or8mYcwZaVAYNMGQAb2VuIxDUJtyFK187DUmR+wJUcY2gkcg3YgvSAJVsHM4VuPCqhNrELzHOlad6dXdqUxjFgdRca/aQs94DaT27DB9QhEV6+qG0aTV+kuzAtpaxaoQfpRH2JQKzbRE5beV/UDXpOJO9tv+qOoneT8HByfMQFhyQF1RFNLrtcYMMkDsipUVNwLABYre9r+duH6lS/t1aeZ2Mcr145aOctcHoYPz1VQHrry5Q9j5UFMyC3MuSD9TwHpv3NIt48IhebHn0BUgrSyjUeGDiZzDaDzp2cLas4q/Zp9DwNhSNub7UwFEpBhSPIgk3pUX4VhDmSnmUE8Nz1qVpbIrNYKB7JF571KwoKrAPvx6J1WPj5TDkLU9tfft06rz5VjckAcHJ0wcuPE/bDuaW0kQd92GyqIvZTOfJk5GFIj2tAJ0Yd0LDHoloMPmHyWZbMiXL80dgU/eGYq6X+y5iakX/OfZthikzxPl46dctOkY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(376002)(396003)(366004)(110136005)(316002)(54906003)(38100700002)(91956017)(52536014)(66946007)(66446008)(66476007)(66556008)(76116006)(64756008)(55016002)(9686003)(2906002)(122000001)(8676002)(71200400001)(8936002)(5660300002)(83380400001)(33656002)(7696005)(186003)(4326008)(86362001)(53546011)(478600001)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3SgwZmSbei46014EEAGaQ2t0AveerQ5KOIw7E54PBFt1LXLmlmTjrAxgf0qb?=
 =?us-ascii?Q?WglMp6hC6X22K2yfJOO9RZQn/WZXUv9W2AM/vGlO9Taq4jOaXzRkI2CDqwnK?=
 =?us-ascii?Q?4wwEw4F9WyoywrMubX5DyRUe9ieltYfCAAcAnSHxdu0myuPs7Bb7f360cp9H?=
 =?us-ascii?Q?og+5srmZBLkzRUy4UQ3YslsQ8AgON0Q8UU56UR669HuNOydKfz5ZKHpzn9yp?=
 =?us-ascii?Q?Iej7f6ORNpJIsqLgNJeItV4sJI1vz14AGSkJdejyZnlIBKcXadzw7ctvwzhN?=
 =?us-ascii?Q?WcQ3SM+0aDSOQToHIDX3LvfBRcCIyOj6BOK7E+h8PgCC2RzcL9fagif9syyu?=
 =?us-ascii?Q?v0zVEOs54X+jJV1v2xoIqEV9NO5EP81Ns3Sv7aPS6ruqeXHXIk0eFXZ/5Ou/?=
 =?us-ascii?Q?loGYwJr20xfujFg5vHvJhtSP0JcxwGcg6wdFctPXmAsHNK0jEIVHXRYpJbyY?=
 =?us-ascii?Q?+8zu5ethV3IGEyZa1eg6/ozPUdgfk5wZ0W1OPTzAa3MrXqFGi6qqtksPQze4?=
 =?us-ascii?Q?ZxNurIv8qcEYkk/ff3iB6/iKeYL64YBM9eWPna5mD0d+gZSdMPxv5t+eC7iJ?=
 =?us-ascii?Q?5p3WXOPiQTyi/fQO1+0qCkJVomGiGkoWz3K2lqAyjWqqB+Bq6Da854EaVCbk?=
 =?us-ascii?Q?S4qnmZr6u+pCf1YeVURP3cxser6+tOsDQJciDm03WL3gtwKgj1Jf6/EuhNrY?=
 =?us-ascii?Q?z9nXUwENt5TXs9ZXQbbOjIdHx0oDEJMnJJ6LX6bxEPzfQYpj/Rjg6PsrejBT?=
 =?us-ascii?Q?ZiTZhSIUkhIF3Z+CDN9IzeQTtI8/s2BjKrAah1clFyPIcGo36f2jW5ZfDZZ6?=
 =?us-ascii?Q?HHAoW54gZPRuWIf7j5NFptHDZNyMXBaWAj0O6AU9jMQvyfgUB/lt9LlpxtHM?=
 =?us-ascii?Q?B6nySOUUqasvkknv3C9v3F+XOxMpDsTZtKkbpIbnAO/uWtGcwLiC2sTm+XKe?=
 =?us-ascii?Q?+IYMMqHuAqhukxt42bYsgDF2dY3SejCc2U+bVLJm3gDcON+zSJW4h7j0fDbx?=
 =?us-ascii?Q?fnJN+DhtRWd+x77lyPwx+E5tJPrC4vRkCQN65JBlO6thAdMh/ZZqUw38sPKc?=
 =?us-ascii?Q?6DZOfUOozM23FfotEz6IWnGy9aU+5ph6oDmBdpSHt7AfD4jeE0VS9lAtXOaH?=
 =?us-ascii?Q?SGc9dQdeVwxJ6+Vr2tLIO1v7SzvFoLV/6EvTHMnoE0+MloYbnA0bbx1AE77a?=
 =?us-ascii?Q?CES/i5P4wknTHh+bAaCgB7bzWWlsX89A324jPrWdpigHOKYMnRlSkNkhGT9v?=
 =?us-ascii?Q?MXsfueiRtZ7rrQ61I1RrINf8XB/vlhsns9smSrtKEqrtXpXzbD+cx7RCm6NF?=
 =?us-ascii?Q?C+iQOs1xIIEulnG4++KRAzbO9vNqdlpe/uTzNwogfzh7JSm0ZsznjQga97DM?=
 =?us-ascii?Q?97vwilkB1xrdtlOe+QNLc/Iuzai1cmvFFOlI0JFSKV6pCbW5xg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fce95b3c-c728-4499-908d-08d92afd0f8a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2021 04:14:22.3804
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jCg86ybCDCxHSpOanaYQDPUKR8KoLQbdnwm9lJOiXiRcQbL9XrMMZwiR5rr0EJpUA1+b9Fsmw3TMFZ0LwXICsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6395
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/06/09 8:07, Bart Van Assche wrote:=0A=
> These entries were consecutive at the time of their introduction but are =
no=0A=
> longer consecutive. Make these again consecutive. Additionally, modify th=
e=0A=
> help text since it refers to blk-mq and since the legacy block layer has=
=0A=
> been removed.=0A=
> =0A=
> Cc: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> Cc: Hannes Reinecke <hare@suse.de>=0A=
> Cc: Christoph Hellwig <hch@lst.de>=0A=
> Cc: Ming Lei <ming.lei@redhat.com>=0A=
> Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
> Cc: Himanshu Madhani <himanshu.madhani@oracle.com>=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
> ---=0A=
>  block/Kconfig | 14 +++++++-------=0A=
>  1 file changed, 7 insertions(+), 7 deletions(-)=0A=
> =0A=
> diff --git a/block/Kconfig b/block/Kconfig=0A=
> index a2297edfdde8..6685578b2a20 100644=0A=
> --- a/block/Kconfig=0A=
> +++ b/block/Kconfig=0A=
> @@ -133,6 +133,13 @@ config BLK_WBT=0A=
>  	dynamically on an algorithm loosely based on CoDel, factoring in=0A=
>  	the realtime performance of the disk.=0A=
>  =0A=
> +config BLK_WBT_MQ=0A=
> +	bool "Enable writeback throttling by default"=0A=
> +	default y=0A=
> +	depends on BLK_WBT=0A=
> +	help=0A=
> +	Enable writeback throttling by default for request-based block devices.=
=0A=
> +=0A=
>  config BLK_CGROUP_IOLATENCY=0A=
>  	bool "Enable support for latency based cgroup IO protection"=0A=
>  	depends on BLK_CGROUP=3Dy=0A=
> @@ -155,13 +162,6 @@ config BLK_CGROUP_IOCOST=0A=
>  	distributes IO capacity between different groups based on=0A=
>  	their share of the overall weight distribution.=0A=
>  =0A=
> -config BLK_WBT_MQ=0A=
> -	bool "Multiqueue writeback throttling"=0A=
> -	default y=0A=
> -	depends on BLK_WBT=0A=
> -	help=0A=
> -	Enable writeback throttling by default on multiqueue devices.=0A=
> -=0A=
>  config BLK_DEBUG_FS=0A=
>  	bool "Block layer debugging information in debugfs"=0A=
>  	default y=0A=
> =0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
