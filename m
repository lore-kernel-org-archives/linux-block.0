Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C95FC3DA7C
	for <linux-block@archiver.kernel.org>; Fri, 30 Dec 2022 11:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234719AbiL3Lyz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Dec 2022 06:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiL3Lyy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Dec 2022 06:54:54 -0500
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AB762F9;
        Fri, 30 Dec 2022 03:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672401293; x=1703937293;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=m3oeuzJPLayxPppbaG+lkWboQZT8lL/iZ5Tq5tFK3kA=;
  b=V7ruEGWHUQ+W3aUvsWoakusN/u57TQFBmLMZ4xbC2H6+DdflQLNCDq67
   5Cn4lktEpwYFoUh9BbHBQLcHbOIYKzGRj/7PVxp5kM5qUpB4RUQXKQ7VK
   v8eHlSEVVATVn9KA46ovb0EdyTN/2atWnInwGX7X5hPHVKR0fhYSrUlKy
   rLWG1OqxzbMzv6zECmevz3Gav308ZAUZMbMMvo2jRkJrHwEegOmOVfzvf
   3vCeKArRURxDgtyHF1eUH0s1PG1lJxzjmIN3H6jTTRqVACQ07G8U6jLSP
   u/cFDclOfGNbtrj9IrcT2hx5azyQA711cncw7lndhUZXA3Nkhv6v2q4CG
   A==;
X-IronPort-AV: E=Sophos;i="5.96,287,1665417600"; 
   d="scan'208";a="219872084"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hgst.iphmx.com with ESMTP; 30 Dec 2022 19:54:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lT8WMWmDOBSswalKY2wXwF/VIfIGZX3P67/Dvl8dtpyaD/MqBgBEl7fs3YwtESUZTYVS0Cxf21ImF2YAP8lTyv2wOQeaKcw7UjvAmTZyzQWcEXW3SgmwZOnWpb/Ky2qi9iARjOcGGm6KQNh8YjMa4f1Ifw51nqa+LdbwJZcp5C+aZ1lwdeY1pjcC3Brs6hYtAOp7lfYuOc6wlkfgRo+fjasgpbvjxFTfz0KvZ78sMVb3w+Gg+FO6qR7dsch3BrQZY2qdRoCLx4tzdAQUF8MKWawkIwZXo4R6I/ZDE4OPfUaFlxlmtOVCFS9JvrGR2TyYt/CWPrjbRnC7Kzn+pAWkFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gU2bUfoGthIM9q8V10t7I1FcbVWpH5P9B145WW8QZfE=;
 b=WKGMo7n5Fr6sfhXX9ZwcGwnUz6pG/VtILe8E0MjxT2EwpzlhUyH6NL0vUkHxNDM0X2YFn3I0JjUEgw5np+twy48ERAqgX27kFyrE+pH7xmJicWtPSGWb62bUJM5G/SYV+uri0BQNDWshcm8cnbQ3npuutb6H8ZnNXohStLx3I3b4gH+GiE9pTiz2I+e2tzwsTIyPBzOkHCrw8wwGBy2rjtCYSuMEuMeS6m5XXG27FmNQ4OpgJXrOeXGzMNEoRFNtrE5HQqrEy2aKC1j7fTxUWpH4ZgmkzUEfxfLtSAPuFlouL337EKxs2pr/3DxiPCR2ZNLdVterWuuiRA8hmDq89A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gU2bUfoGthIM9q8V10t7I1FcbVWpH5P9B145WW8QZfE=;
 b=Qd9AKQSWNdMepwe7cFRMcfZ1lLbJuHwP51NXZyaMwzY173cLCcfAbiukTjfnUZ2klpozwRiX/DHCaz2x0aUzDJs97iVu3Lzn5OwhRQBL+/KBYSbHSeKGqg2880o5wWX+R39sz0dCdouk2L/6u6gPd56vLclKiP8rw3UV5/z372g=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BY5PR04MB6520.namprd04.prod.outlook.com (2603:10b6:a03:1c6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Fri, 30 Dec
 2022 11:54:46 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164%4]) with mapi id 15.20.5944.016; Fri, 30 Dec 2022
 11:54:46 +0000
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
Thread-Index: AQHZHEWCk06D9ZhTTEKGucvq46Ne/A==
Date:   Fri, 30 Dec 2022 11:54:46 +0000
Message-ID: <Y67RhYZFwx/kJ0dO@x1-carbon>
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
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BY5PR04MB6520:EE_
x-ms-office365-filtering-correlation-id: 9d415ab7-ef95-4b0d-6714-08daea5ca5cc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jlJ6+TK18+CRJlrc2yvKv/PL8UUkuskSW15qlXAs0iQuWbMwLEPu/OT5vCy+BedMZopv3z1LTYX3XeiBZ8FJn+mndRZ18HN+Obev69hNzYawC9zEzGfITRYyjmucUDNHEEl/wv7UTpCULc1LyM4fE9FQJDHPnnd/A2V5PoXjNXoqk11waYXynQD/i3OIJNqSgxZo/phaS8PVIbklgwCM3ng5Vdlww7EFYdq3WH1PgKcDcjDrq1vcetuIQxBhoggFKYA07JptGO9Pkw8nvmT0InzMfwukuejLP8hf+vgW47MGG+SNk4sEK8/VZay1RifkKpgw43/GixqkI5eQaFboZkxhOGRrXg59Ea2937aQ4/J0xRE8h1r3sOih0BU6Dzt5fFehBGWlj1y5uD8RJdrWDbCQPBPWRxg9Dhp4XAGJlkfNLB/IxhHysYVWmQbLGOcmQVwL9pXnVfSVgsSMiWzUFRk/tIf9z6fVlSijL/FQR8FSvE4vj/BPiMgpr7U6rI7U3QGN8l4JqE7TRk0ZzVoIkW1uzzwQ3uXBndlfraru0CsxQUn1JlV9GA5PuW31CSxlnaJqW/Oa/s32fmMnU9vatSLYXz2R6+urk3annaCTvFWzI+a1wYMqp3ZvC6jRrVcdGS/lPWDLASH/ZrCirzEjXZG5oLBoNatBXe1egeT6hb0Hxo4/K/oAT43SOyJV+r7aO2AGDkaq3SDRcMB0D0+0vA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(7916004)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199015)(82960400001)(6862004)(5660300002)(38100700002)(122000001)(8936002)(41300700001)(2906002)(83380400001)(86362001)(38070700005)(316002)(66446008)(71200400001)(54906003)(64756008)(66946007)(66476007)(66556008)(33716001)(6506007)(4326008)(76116006)(6512007)(91956017)(8676002)(6486002)(9686003)(186003)(26005)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8NZU9s3436BOYkeQDY4DT5E3MlQMCGKwtDaGUpMkohLDz35skboXNt8WsHmu?=
 =?us-ascii?Q?7ru8+32aFPc9ETFzuSgWsuewa69JSoMpDBRmTj19txPsULsleaDQ++FKaVoa?=
 =?us-ascii?Q?SU5UtHrXXh5ulIrjzlXhqKuWF5i10j9g51yqviUaHfCfBe7phrAW8k6LU+1q?=
 =?us-ascii?Q?oKFOqiLsfgvQhaQ13QY9+a1G4fWA+t4G4F7z0c2vdqrH2RiHuGf8fGApjJW+?=
 =?us-ascii?Q?ewwjRmmxM5vLM0yUW2YfBssCujifOzIfmU2kE2YkO2e432kMt/wfDvUy02RA?=
 =?us-ascii?Q?yFCw1pGP+mQ0WJYcfWXAmsswfW++FfK2kurD+eFNS5Ps9F/QOh1/DtjCwhlI?=
 =?us-ascii?Q?o9GpvUHXvoJxbRzkW3CiE+Wv3lFW6WRoPKQojk+2ophCdlu7ZG+leVFjOdYs?=
 =?us-ascii?Q?dlHe06Wawsbrz2HP1ZrT1C9cUlSzr8WeD57k4vtZd10f1XENnvo7L+Bd5G+U?=
 =?us-ascii?Q?F4WTLobj06gkaZg/UbeChfJMsj5bvDYuBQPIxCLvHFp1ioCV6i0Z6IER7fQG?=
 =?us-ascii?Q?6Ouf6cbZyVeuj4X0FTMx6EON6xZAh6945yA8XBUGEG1JOXATSYJxDVIslwle?=
 =?us-ascii?Q?JIC9ekegJFmoJntULuj6GdXbh2cXa5npdlXUTdN7aNiiT6tQBK4RMQLilDQF?=
 =?us-ascii?Q?uLm2WQXpRWMcEQelAp6NjiXRg/rhiiYtIibshdWWoQqDHhpQ1ww3ZgG8D14m?=
 =?us-ascii?Q?joCopJ4YvvGQPWGCivS9zmyi5Fb7r9l4kBNHCW3DCv6XX10vWky4Sip24etZ?=
 =?us-ascii?Q?oLqnD1C5xc8syiGo7YlwmLGIsuhlc6yUX5ttoZr3IVYaCQDyK37CP95T05i0?=
 =?us-ascii?Q?IemLt+YwiiLE3jAPHa3SFL5FazE4qfxcymm/xNNuCgiCV+vkbsPc50CM8sEd?=
 =?us-ascii?Q?85Ul2JUJPyo7iOyCXsVMekbzIqfk4mulCREjUqZ3spihxIMR8ffspEl6wFs6?=
 =?us-ascii?Q?IQYpx3m3v37m7xlAZLFPuS3DSTgJkkIdYvALYIk9JVqBz/1kJ+TvDF9PaCjk?=
 =?us-ascii?Q?tq4YwzsMdHqFSvQ4Onx5/zHb+8fy5LY3RwvuaRZDISu7E75gjgKFxrErJe+o?=
 =?us-ascii?Q?hnjpd3oaB55vV0s2s/Ji3m2sfB6kHW55RJT0iNDlYmMI1ds9dbF7k29kkkpG?=
 =?us-ascii?Q?nQodc/YJfdBEGdXipSFITa6utlMBRL7QTesfecPhcMcF86kP6Je50TEAP7PK?=
 =?us-ascii?Q?emYOR5fHxnD6wwwoJ6yq1X/4tRrUL/7P3iZOewd++x7GPcW8Fy2y3IoA1STC?=
 =?us-ascii?Q?zISRJToVzfYNBxHkd1UBcm7V4b7AE27bCWrXISNlWjJNRSBKM+yQdSTs1tTc?=
 =?us-ascii?Q?6s2STeSuccF6SvlO0e/05QC2g82gozE8DK6iRWUu+QMW7q6H9LJi+rqWuaGd?=
 =?us-ascii?Q?LSjcjBq/4OPBfly80uZRKCZjjjErXwpvzV9C8YZiPJ5voMvRd1SVQk1seLwe?=
 =?us-ascii?Q?V54F6R/+YDYB8dC654vI9VysdsPO7DwF8uTd2E0WVUDir40YhewdwQeNtLVS?=
 =?us-ascii?Q?bnZi4tKV85xZZsZlCFu4Sm0w0jSb93+VQc9gWlqh1rZBCib792CXw/ocWwYk?=
 =?us-ascii?Q?hk2NB7pjKn599d4GEPcP2+9X/0XmX/oaJDiqh84anCkbeyvWigGYNZh2n4kC?=
 =?us-ascii?Q?Qw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8F1094694AEECF4AB914C799FEBEE7FD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d415ab7-ef95-4b0d-6714-08daea5ca5cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Dec 2022 11:54:46.5404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fIt35q9FQIQokIu6aOSsYo+i7V5pQHsWwGOciawRdcrTU/t5z05G/3wSPdnBMunhBajCSxUMTyCatReXfip+Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6520
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
> +		if (!test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {

Considering that blk_queue_write_cache() looks like this:

void blk_queue_write_cache(struct request_queue *q, bool wc, bool fua)
{
	if (wc)
		blk_queue_flag_set(QUEUE_FLAG_WC, q);
	else
		blk_queue_flag_clear(QUEUE_FLAG_WC, q);
	if (fua)
		blk_queue_flag_set(QUEUE_FLAG_FUA, q);
	else
		blk_queue_flag_clear(QUEUE_FLAG_FUA, q);

	wbt_set_write_cache(q, test_bit(QUEUE_FLAG_WC, &q->queue_flags));
}

It seems that you can have flag WC set, without having flag FUA set.

So should perhaps the line:

> +             if (!test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {

instead be:

if (!test_bit(QUEUE_FLAG_FUA, &q->queue_flags)) {


Kind regards,
Niklas=
