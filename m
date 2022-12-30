Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1655FC4332F
	for <linux-block@archiver.kernel.org>; Fri, 30 Dec 2022 07:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234570AbiL3HV0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Dec 2022 02:21:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbiL3HVZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Dec 2022 02:21:25 -0500
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F1C17893;
        Thu, 29 Dec 2022 23:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672384884; x=1703920884;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZsXXBSCThpH4JcUgzRBCUw+ZiiK0tZ+CwgZpqCBHAlo=;
  b=g4wKVww0ulmyD8iZtySu7QBl2AMQefXXwlRJpRUOgUt9UdJSEpO4Z5M2
   jJyU2NsmCYJCeZTDiBj4Nd5YoqcLoe+f8bYBAm1yM7pPynyoxOguqT8WQ
   5EK2b9PUzrPMmgMODTC+GW2a1nt+NAtXl4WJQMV7+FKZxwNLh5NUAjx96
   7m9grI8g+S08wHckdRDzVybj/74UwbThvqnkCENY8P8Q0pnXr2CxMV7kS
   nXVEurP8z7v6q7MdFt6NaUE7hGuC6zqYZRcMEC8NP1kQg8SpnrQbJPfWA
   JNrG97hXlQWUeU7v965LJhjVGdThTMy/XiZ4FVyrt2YC3M/EtKwB8844L
   A==;
X-IronPort-AV: E=Sophos;i="5.96,286,1665417600"; 
   d="scan'208";a="224802402"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 30 Dec 2022 15:21:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+i1XMDHwlytyZLZyRDmZmnbulqew78kqy4CNhhpmuRIa6OlzzXFI7dpsT7xbGHDOsdThnZm1IU39M/61cI1v2LxsPjmGfN4C5lquMKEfKLk0OjM+VodIAIU4isS8AHnbzAFxiuj3ypwbF8FWAbAeDrrcmeLyB+uYyQZKXPSDB3+8u/0PPQzP80MB9nn99SvJnrP81wTrdc/dxMjnvvf9APQ5T/VX94jRKFcHOaTUfDJptzt44ECt6TPc4FQyAAZdkE0M+jj8gqn5rbqNNMXj6mi8Dp/lduP8S3mXMYCVPi82kYsHzpJCrqLJgI2fon62aPlvx2WsTmHCAOronKjMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bhRRQyuBRpd5wsJvagFlsSSe19C7kH+67ZypVESguok=;
 b=HGFbo9JZnzFhL68lgYemO/6f2UoH0iIih4Y/na+AFWQdlJQn/VijLDIaNrwgV4ruI+VuqH4OPDZgR5O2VOEJcQ7XuzdCFwAyTTDIr5TFhW8RJ5T9lxiF2VLXjO3MpQ9Y9uKKkoZF7el47y8UWFXv1ueo/+I0aQ16x8tIi+D819zSoJcLc+RxKAW5jBQYE64ER+o6aBeNtX7WzxVhQjwYcApZIz9bucG50VGc0udLBcEPgnVnnxVKagIpPXyGZRPUSLfnRvVVGePww1pJNtr86eyxseJUPwyrVAz+eQqQeTzn7CxN/K42VOHFsFiq7bgkjPkvTHrdIPkUNQaW9zItGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bhRRQyuBRpd5wsJvagFlsSSe19C7kH+67ZypVESguok=;
 b=XgLLrwnvSp+Txzgx92z30ne+3xzah5VDPbZZftaxtaT3+tpvrAdWSXVLCmu2/sn0uNX0GnScfX8aLS+yz0X0SM6phy3IBOojx6DpEsHnYH1sKWGboUgAPybQZ2B696jKSwuxJ+F7R01EvSqYQNJyB5PKPxR0FrssdK4JuJfPcuM=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BYAPR04MB4744.namprd04.prod.outlook.com (2603:10b6:a03:16::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Fri, 30 Dec
 2022 07:21:17 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164%4]) with mapi id 15.20.5944.016; Fri, 30 Dec 2022
 07:21:17 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v6 1/7] block: add a sanity check for non-write flush/fua
 bios
Thread-Topic: [PATCH v6 1/7] block: add a sanity check for non-write flush/fua
 bios
Thread-Index: AQHZHB9Ok06D9ZhTTEKGucvq46Ne/A==
Date:   Fri, 30 Dec 2022 07:21:17 +0000
Message-ID: <Y66RbGFWKektSKBC@x1-carbon>
References: <20221108055544.1481583-1-damien.lemoal@opensource.wdc.com>
 <20221108055544.1481583-2-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20221108055544.1481583-2-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BYAPR04MB4744:EE_
x-ms-office365-filtering-correlation-id: 47215e7d-0be1-491f-f7d5-08daea367166
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CZsFWxBLIj9j5JHiF8n8PJJYh/gajwXlW0BIte4DQATPD9f1+zYT3uOCtKs069OTJjFDGCEw/PCkMEtHDW0ArNt7qhfvvjbp/96jAHmFnSlRPMZJOsbOSV4+lERoIbF7/JGgMTGraid5CAebn39t0fbBZdetG4BCSapPt4gASLoTPm5Ndw+4+HCkJwMbDw1gorjgZHjLJxT5f0zdUEFZI+UOnTit4sZEGO6mRDzwNeMEKUkx5Xxr1W60LBkt39sTbHpHBVga/QptTDdmcfMQlIHy/dYlejXn+yF/t7DC/Z2ukStcr9yuraSKZiwq+VyXfZjHMbGUm7OCtPm8cpbF0FrlpyMQfafylXR0DTz7M75jsYjklgvbBqtctSVhIwJeikVCS0Uhllm9sw0T4Jynzzz7+qlVc7mXOWrt0Ls7+yN8ALt7ToLrLsOsm3aJYoOKq2ZoEt2SFFpbVg5O5biNsclpMChKQUw97cvRrPOcGRZbTmXJTHvZ3MFYSiR3XfZFylJ9Vz1qfXEoHOjChqF8mGGamBjb24z1oqUSCgj9ZSkRJ6WMpkvZk76+PDJwb9Qo1kbB25L29mEqSi7kcGmfnBIgtAOdtONPrgDhHKXCRGpZT4v3yZNkwAp7fssWkKxJv9nNsU04UZq55TksS6J0dXnbJow698bPkLikSz1IL4D0z1uY87lJ9dtqT4rnChYB
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(396003)(346002)(39860400002)(136003)(376002)(366004)(451199015)(33716001)(122000001)(41300700001)(4326008)(5660300002)(8936002)(6862004)(91956017)(66476007)(66556008)(66446008)(64756008)(8676002)(76116006)(66946007)(2906002)(86362001)(54906003)(6506007)(82960400001)(316002)(38070700005)(38100700002)(71200400001)(478600001)(6486002)(83380400001)(186003)(6512007)(26005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?SOO6hkWwy1QrWhde+yQQWcz0lCag1nsWtnCEVX60bPPBVPdWFVbNOWi6aeVE?=
 =?us-ascii?Q?NGU+ef0WfSEH9cxB4+FrgV63cfSVQXK9AYvtGM6D0UUCSoCDie6YMq7qw7vv?=
 =?us-ascii?Q?s1voJoFGj6oS9KcBcq/SjTAPAi5tFUw1FiiH/JMO1GgxeOwIv9e8hPfJLUh8?=
 =?us-ascii?Q?/ToMK4v5ELryMdzrmjQlE/WVnNBwW/0AQwIRWoC1ytJaRXbVJNvkI9Suhkz8?=
 =?us-ascii?Q?WUL+B0YwAI/hXy4APqq7qZTEg/5W8hvv6tkF85KVibo+1LcsXfHVCmz99Hcw?=
 =?us-ascii?Q?QYE/NbOmUVhhxTGYjOgojQ7SzQvfCh6U23rRCl9F1YoClBmgM8wUkd11mqqr?=
 =?us-ascii?Q?Xu/O1qjFcNBl2PhsX+NYYPqYF+1ji42VwUF1/nWkPles1LZQmE0AQVRH7S+o?=
 =?us-ascii?Q?3eH9LidqlQTxrAMCs8h+YX7SwnWM8ogh4b8lMUEnQ3HlB+KEhUggQTAHtmmE?=
 =?us-ascii?Q?sqUrznCxCWT3cYVkp9AXHEf+uTfoWRBRWpvY+1hvPi2Pwo0C0BSH65u3k/Rv?=
 =?us-ascii?Q?lMuhfGXbT3i4GSol0Dw4iy3vpbnF92LHdfvX9yGvb4yffAMV+H0IZ9dCXXn0?=
 =?us-ascii?Q?SGd5KxASJcJGhQnBhpHQV46hBUjE33U7YkersnuYmO5dSevwqS+QGmu/j3k+?=
 =?us-ascii?Q?4TnkwDtMcnghTWleHLGx1PCgSS0FcjdOtAQlvQfExE8TJDX3LzcXMmwOiVmO?=
 =?us-ascii?Q?Ega+FwCS0sDmQnEfTnaRN8X6xjqVqI7C3REi6vpFXWkNRuJTjlVxgW+dSow3?=
 =?us-ascii?Q?f+E8TiE5eV8tutksHGADNXqPPE8G1SIOdbSOCCyq5UKETZOOCqBqN8k1MHRo?=
 =?us-ascii?Q?rUzApDFqBFFyj/rE6mJogQrqL/J+GaiUir2Lj9LiX79CYzUVSRmXRBRxv0iT?=
 =?us-ascii?Q?vwAWNWRfkCEPbzQf8KlS3uIrb8gdzZCbG/Vca5lmGPoCk2+FKdp7zc9b8Nmv?=
 =?us-ascii?Q?cXg/q9Os3Y01cgdPxKv6X5GrJ8F/W6nIo1y5cG58rSxrJdMnH+vMqMqmuZud?=
 =?us-ascii?Q?/uZLqtKGYyp8q08Do7ROKhiV5hx1vgb3uNduX+lNr7WYsBXsGalLvEuS/SM4?=
 =?us-ascii?Q?2B/1ZDtUktlCG8SV2Z389IfmJ76rVCJsoWpUTSXlwoQVEVWMyVToL3cIJJBY?=
 =?us-ascii?Q?4hPenwstPJJ/AQADjkSOnm/cRPnXSjsANCtrr44JOjyxg7ehxEqJCWFcIMVX?=
 =?us-ascii?Q?2N5PXpx0LqUZkD5jY2tV+XKP+zyJD2DpVQxIffUltpmywpDtgFPL8mWwBB90?=
 =?us-ascii?Q?aHqHBNTKNWUtrluQnVmniArEdiLRd7sVI+07VPg7TFQP22WuC3oAy61eGOWY?=
 =?us-ascii?Q?51wLi06AwaL9fgGUHQjv5paWkvw5WR4BiYsQRBu0hnLFjrlU+fh6S4zHh4gG?=
 =?us-ascii?Q?jpplYWQRLwP1/pBnE3y2YGNf/l4n2b+71+NJdv8qj9RR1OHpdbv7qmK3GFQ1?=
 =?us-ascii?Q?3qzA0zJXSwc5/t9ieHzR4Gdsx4jHM5OmaTRzlkL5z4Mcc9+wX9ePo93bAJDd?=
 =?us-ascii?Q?UzfEKLcNIFk6gDWTv2wRgokG86Q7/hn/wei91Y4mNRm4CDcPYKIXagKy2wGy?=
 =?us-ascii?Q?Iq8Tnye9oWGyrgyvmonjb9UmQtDqCRlTOV3ivX9ZrNJPS0Sq5YOFpueUoyG2?=
 =?us-ascii?Q?7A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4FFCAAE6627BC148808D5114B02FDFAA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47215e7d-0be1-491f-f7d5-08daea367166
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2022 07:21:17.7584
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JYCdbhft2SbBlivwYcPAjr4tEp7KxNru8dQGAEKptDMl1VG2+RsokWsTtS71AeTe159KTJrvHhS0hEWJi4UgIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4744
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Nov 08, 2022 at 02:55:38PM +0900, Damien Le Moal wrote:
> From: Christoph Hellwig <hch@infradead.org>
>
> Check that the PREFUSH and FUA flags are only set on write bios,
> given that the flush state machine expects that.
>
> Reported-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
> Reviewed-by: Hannes Reinecke <hare@suse.de>
> ---
>  block/blk-core.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 17667159482e..d3446d38ba77 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -730,12 +730,15 @@ void submit_bio_noacct(struct bio *bio)
>	 * Filter flush bio's early so that bio based drivers without flush
>	 * support don't have to worry about them.
>	 */
> -	if (op_is_flush(bio->bi_opf) &&
> -	    !test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
> -		bio->bi_opf &=3D ~(REQ_PREFLUSH | REQ_FUA);
> -		if (!bio_sectors(bio)) {
> -			status =3D BLK_STS_OK;
> +	if (op_is_flush(bio->bi_opf)) {
> +		if (WARN_ON_ONCE(bio_op(bio) !=3D REQ_OP_WRITE))
>			goto end_io;

Considering that e.g. zonefs does:

	bio =3D bio_alloc(bdev, nr_pages,
			REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE, GFP_NOFS);
	...
	if (iocb_is_dsync(iocb))
		bio->bi_opf |=3D REQ_FUA;

It seems that we need to either allow REQ_OP_ZONE_APPEND explicitly here,
or perhaps make use of something like op_is_write().


Kind regards,
Niklas=
