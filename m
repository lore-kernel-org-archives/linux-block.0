Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D4CFC47089
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 03:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60FC2613D3
	for <linux-block@archiver.kernel.org>; Thu, 27 May 2021 03:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233702AbhE0DK4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 26 May 2021 23:10:56 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:29375 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbhE0DK4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 26 May 2021 23:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1622084963; x=1653620963;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=LEtu+39UvNP0P5IUhDxHuiseE4id/7QozULyOJEKuDA=;
  b=UtC1vLzH5YHB7F4eYqgreOv5/d5cJqoqFlHiyKMNruz4wq0EhQaaWL9a
   R6P37L0POpZp2dVLaJrk+NwrA6P9IYXawKigHwqYyQRipOF+MzYgFF6Jm
   QLbqmrRnPJ/QCshASTCOVfTRyfIw2UwQyHMu7dRMvROMHICCUSZlhthYx
   mnq4Oss+yee4atZVQi0MOqDE6i78ZhLgXZ9/urYvPbhTrop+hkYdibtAO
   MvIXIL1PvPXO1Md2Iy/8zlURzNMnxA1R0rBGh3BUpfQWcBs8mXe6Vqu9x
   5Gc/nCZPtga05sjMWMDQEa4mw4ljFcuL+zLbUS0+DRqsyQLcWLqHTyxUi
   A==;
IronPort-SDR: kDBiEOFmglS5c3QnTZm822ZzUAADEbwy5hxm0K2EXBy6wJmXP/VUei7kO9ivqxjpcf0yIijMQc
 88Fgah7T01rI5nJ8PyDwEboqaYVRxuVL5lfp2CZa+9H6ub3UGHIzWKFcjavCitRXx+Vdy89fr8
 6kvzwU7gU6pgWC4BwAVkNySDy9OZ2G3XUMkNxSrV3N5vBcP+EZaUCLOqeUspfefTVeiEukSL59
 qFoD7IRm8L/DTWbCgdE9hnWbCVrWeu8SuITnc2tHZQbx9zKi0eUmBduz93Ie0ALa1Zl92gpfdZ
 WM4=
X-IronPort-AV: E=Sophos;i="5.82,333,1613404800"; 
   d="scan'208";a="174271636"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2021 11:09:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N6F+I0rR+bos0f99aZlbufRILGRmZTr/9rlpALxMJmGMGk6C00OzXlXnfoaLSWz1XOMybB4FtxLrU9Nwsqqzw0lhjBUNVJCSsTIeKnzAbgHEAg+WyjsDCiILCpT9Bj5fV9tAgYPS6drzFkgxRlEGA3vaXF3+LMrCGSuL6d3qULgwHdCPPkaAl4P5bZXfhSVYov2bhxcBdBG/pQl3jxoIPjbkquvh2mlSJ0tPExvbcw603rw0hQEc6pNrNmQD5UoEDEL0mtDWhkN9VPboEACPEXiOVeGNsz0P0Eh/jKRYRbM0C4GvYzGkWUzSIwfNHrukoAKD9KesX+Bu45U5XaKnhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2pmZkJG95+VZKo8gOxE0LZ4hcur+tiNGiBe7GEXCTA=;
 b=DvRyonb8HPpp7nT29JHyyXC5EnEhlx4+ZLqMfUN8oRtUtscYma0ahRCm/1B00Pf8BSRbouhrjDs+bJ/GXLojsMS/TbH236Bq2m76Gro7uZt1f+3nfgqj28V2kdGdW2zMU3QBg0eJo+nz29yObUZ+J+cQdkFaCb8izEfRdfQvtebx11ugq5kkTt7KEUvlO7YZ29rhN5+D7pZsUsHrWLXlckLT8lZRYb/0rDnH9Kf1AJ2PppDNBUfch6DPRiPHTMIWdBGTcjI/ZZI7cTIU6yij9eZEdmXIpwbIDdGtjrF4OGWtlt5jeNGR4jiqtxUpSa3xOXsd9NmigFvwzyZd8KFHiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I2pmZkJG95+VZKo8gOxE0LZ4hcur+tiNGiBe7GEXCTA=;
 b=GVk180V60fHbjw83B6w+DqlGmeR6uBeKZA6YrzkUQtu/91lHxeVrAY10sM96tdEliU2eEhSgJJrhnb3aUFawgL0WIHJ3l6KPYsOXmfterrR62ABDirHtgDWCCTac02IF9kFzHgaZfoHJJOIWzKZIGDRJ4LR88eUAmAcgfTyLnO0=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by DM6PR04MB6496.namprd04.prod.outlook.com (2603:10b6:5:20a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Thu, 27 May
 2021 03:09:22 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::64f9:51d2:1e04:f806%9]) with mapi id 15.20.4173.020; Thu, 27 May 2021
 03:09:22 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Adam Manzanares <Adam.Manzanares@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH 2/9] block/mq-deadline: Add two lockdep_assert_held()
 statements
Thread-Topic: [PATCH 2/9] block/mq-deadline: Add two lockdep_assert_held()
 statements
Thread-Index: AQHXUpPwwzE12pJw20OCIUTAxtdVAA==
Date:   Thu, 27 May 2021 03:09:22 +0000
Message-ID: <DM6PR04MB70810E819DE6B0D06199B1DBE7239@DM6PR04MB7081.namprd04.prod.outlook.com>
References: <20210527010134.32448-1-bvanassche@acm.org>
 <20210527010134.32448-3-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.60]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e66e7c25-2a1c-4742-b2a9-08d920bcd365
x-ms-traffictypediagnostic: DM6PR04MB6496:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR04MB6496B24AB4DB4669B8A43ED2E7239@DM6PR04MB6496.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o3jh5u79MhNQ6l6n8nYbUZ8UhkV/SK27me1qAzXb4lIcAbYe3+OnSsP8ZeGqYjto/e7zE97PEo/nsAJKczw4AvQmRxRbnl+59h4Rr6WkDnX7s8qbLWf94Jk+QhN7e3GBK2z5fJ5f5YCR/s1P3bjroULO+AhL7rRIx2BY7YDtZ3CSNU0rmUJgz5ecRcmZzdwi1eDujYjeZOdtVZLl85ZZqeAypobVLqElfomn0JWDgYyZyB9O4Qrc8OItcuRm6EermyfmwWAinOffK9L9Q4QM1SDoAxhre2RMajJmPoZnKaQjTYpefn3X+WFGW/Q9NmkSzDX84ZxKbw4WKXVzaU/xWxJsGukrwe1OYMh7SuXCkjIaq5Ic52e99823DYmVchsUiNPjJr5Gb0ERT6MeoTE/48GM/0ZtoMfJ3A3e8TI3bd19Q5yCY8Et27uJq9Lyu1/+6xNlYL4f4Q6MVwD1mZrBFmZzk9HPoG7X8L33j5HKHfHLARWIcpdk11IywNMVHHmMFrP0Vn28ABxzYDuzAa5zjy4KcBumMasep6XaZmwat1RNQXbizbfdg6YIcF5bcIa41dOsbqF6M2IaPSaUrAQTxrANxG4mAL2c5EF2OyJ+2xY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39860400002)(376002)(346002)(110136005)(316002)(54906003)(9686003)(2906002)(7696005)(8936002)(33656002)(71200400001)(26005)(4326008)(5660300002)(86362001)(55016002)(186003)(478600001)(91956017)(76116006)(53546011)(52536014)(66946007)(64756008)(66476007)(38100700002)(6506007)(83380400001)(66556008)(66446008)(8676002)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?OVDpRVNJxXtOQCO8T3vi+LOyvVkZd98mvoO4OEihvhdgVU8n//A7rg/n0RME?=
 =?us-ascii?Q?f6uV8iUbE6+5kpAPGTX8viyOaQrFkFsO9almAiXxep4zzn20mDcxjgWDZEch?=
 =?us-ascii?Q?+yYNXLUZZ0UOaAWTenLmnKADjlAAxERywk05NyfBSr1RMli/ek8cRbrV5Vsq?=
 =?us-ascii?Q?htDy33aG406N1cGPc3lg18YWu1UoOJ87akOSLD6oC+DnhEqkG18hQqO3DN/L?=
 =?us-ascii?Q?NAV3mQqxTKyM0w8l1H+8erkkV2ShoGqLuHAeKVyqV815Z9NP63BqPTQ3LA1x?=
 =?us-ascii?Q?/CQNLrpT2E+7b1SQzz+Z75lghgQeXOzgZXBuhlPAkLo/nz7DjmMFeOSXE3Gf?=
 =?us-ascii?Q?s6ggWQ0gJI2M8wWTBARFodjDFSVPNwmXUDBWaT4LxgQ+rncltQ7mOMchlAFD?=
 =?us-ascii?Q?8OqTmfRDuG5rNk+uBbQKDxEy8rJz4wKkOPq946lcm/nxJj7kftLcXs5h6wWd?=
 =?us-ascii?Q?wFI4N1OUuvfSOOaEaPsoJENXP2thpEFnwiL/vss7g3kN7Ud5Aykcr2TxmgN/?=
 =?us-ascii?Q?aHTrcZRYXJqS0MW4r6e/nVv5e65tdj/O8ncyfZP2UPKMwchyHuY7e4fAy2YV?=
 =?us-ascii?Q?AGMIh8RJzFo3aBt1Oo+IpuUlmH2VnnI2QnFT0pozO4ddktGFv4b0LsFKPn57?=
 =?us-ascii?Q?uGa6XbY7C5bBRAOHNhNEEWqoEi6UzS+kPvB2m+0GcqZK7CaOlKupaYTrXD5z?=
 =?us-ascii?Q?5VQywW2Yh0bvGD3GyI3Iva4bJ3E+hnO3sTiSiu7ZG/v4t83bEJq1lOTFc7gF?=
 =?us-ascii?Q?Vxy+K4vrNrb7UVGE6hSxn5pRtm+Q7tAj2Svl3kHWqg0JpJXfpt1VMB+J8R4D?=
 =?us-ascii?Q?PGyc5PuaTrIlwpBHcL3m78JsIUEJF6fxhH79eRaNbkU94rT+wa1prNZXN/6O?=
 =?us-ascii?Q?ItyDiJaCrOIPJFlGHNygx7/Tk6iqQbuC1clTEn5WG0K0oJgkAuoKccK4MUQV?=
 =?us-ascii?Q?6RJw5Uq+l7b3clENE1xCcGOtFbJfyY+wSPUebpjMU8DVpsGfuJd+8pEdKKB4?=
 =?us-ascii?Q?w+rXGt5I/sLV2k6JT+FFqxhm0ryLjQq++6rhXjmzBO+ntiOQohKfejgP+Nqo?=
 =?us-ascii?Q?cRNRppxCkGSi9UQeWf0pND0y1lZefASRvDaslffNmG+Ic5mAFnAkSEfv6E++?=
 =?us-ascii?Q?pg6je1K+VJz6dMY2bae52BwFqdkSS69XRpNsBG8YVh3Yd/5wugip3T9enh4f?=
 =?us-ascii?Q?iykr4UsXc2Eg38tTZWgP20ZxS0iZ5voa4aKC7YMf4ywsFW8FI2LxD565/2Wq?=
 =?us-ascii?Q?Q4KhO9L7DQKnUBBb8d7op//oHHA0XDptizWnSONZ56fJXFenXAEaoOrkEUN5?=
 =?us-ascii?Q?3zEMyWPM3JXyEWQUDitYiU8iI8lFQJ/9peWNq6T6CI86fQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e66e7c25-2a1c-4742-b2a9-08d920bcd365
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2021 03:09:22.0780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BQ2SDq9t9gZcW7hfKqhx/rtsF1fAKe9wb98sxuHSjIaDd37vF6BEg7DviY/0qWT1Gy+DYZqnaodVCtvBkw7Hfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6496
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/05/27 10:02, Bart Van Assche wrote:=0A=
> Document the locking strategy by adding two lockdep_assert_held()=0A=
> statements.=0A=
> =0A=
> Cc: Damien Le Moal <damien.lemoal@wdc.com>=0A=
> Cc: Christoph Hellwig <hch@lst.de>=0A=
> Cc: Ming Lei <ming.lei@redhat.com>=0A=
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>=0A=
> ---=0A=
>  block/mq-deadline.c | 4 ++++=0A=
>  1 file changed, 4 insertions(+)=0A=
> =0A=
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c=0A=
> index 64cabbc157ea..4da0bd3b9827 100644=0A=
> --- a/block/mq-deadline.c=0A=
> +++ b/block/mq-deadline.c=0A=
> @@ -279,6 +279,8 @@ static struct request *__dd_dispatch_request(struct d=
eadline_data *dd)=0A=
>  	bool reads, writes;=0A=
>  	int data_dir;=0A=
>  =0A=
> +	lockdep_assert_held(&dd->lock);=0A=
> +=0A=
>  	if (!list_empty(&dd->dispatch)) {=0A=
>  		rq =3D list_first_entry(&dd->dispatch, struct request, queuelist);=0A=
>  		list_del_init(&rq->queuelist);=0A=
> @@ -501,6 +503,8 @@ static void dd_insert_request(struct blk_mq_hw_ctx *h=
ctx, struct request *rq,=0A=
>  	struct deadline_data *dd =3D q->elevator->elevator_data;=0A=
>  	const int data_dir =3D rq_data_dir(rq);=0A=
>  =0A=
> +	lockdep_assert_held(&dd->lock);=0A=
> +=0A=
>  	/*=0A=
>  	 * This may be a requeue of a write request that has locked its=0A=
>  	 * target zone. If it is the case, this releases the zone lock.=0A=
> =0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
