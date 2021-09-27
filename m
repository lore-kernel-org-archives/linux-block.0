Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D448C433F5
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 15:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 033ED6044F
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 15:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbhI0PzT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 11:55:19 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:42935 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235305AbhI0PzM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 11:55:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1632758015; x=1664294015;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=xYXvRSLOMMSPpMGbv9YEV8WzvFXSjDD8p3OFBE9EwLM=;
  b=d03A+CanyquJcfeZWQT5Dno4JQ3JpvK6206ggG8f0v6/aaxUmBBFZFG+
   Vo+o25pbznW66KYbJo/3Y6sF8M4Ul0RBI8pc8NrT/7tKyMEip3B2Gzsc8
   1RkiIgy3caw7sytDSUZe6Fr3C3Nl6l4p+nDisgXs03Z4UNkayZ8UQqpMU
   4Tn60Zt+ZFkDsIG1pzaUivMOSqt9E4Yc/5sHUNSbtiqm9nRFQzt1x7vkN
   Qkba2RFp9N84ULm+spdhQTRV2aw0PN1GNJ0EYysMDFunSOXDRDBJTnfLS
   VlVgyMolU/GifiGfHFEPecvV08pxIYQJRrsmIAR+Wwzo62EHaYbtIrmr2
   A==;
X-IronPort-AV: E=Sophos;i="5.85,326,1624291200"; 
   d="scan'208";a="181691835"
Received: from mail-bn8nam11lp2175.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.175])
  by ob1.hgst.iphmx.com with ESMTP; 27 Sep 2021 23:53:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DTFYxT56Bp4AIeNR08LIqR0t5HFYVIqxiOhgAVkuNiDKR0UG978+HTR9DdgEDOkFf8Tyt0bgalZXmzNwHzYfbJ5+XVGUMh7YwzY5jCtvd1lFm59wYbsMo6Wq0hVj4vc9Fn5g3UQa5I9lAj+O7NFQqG0ylnb8OBmZ1HEsDbsm9pEdDFuPyNfyLDit9mrHrLd7bRMh0QfUp3z0x9xEh6k1wsoK5HMXvPOC6NJwfNoGljnPESvpqa1SeK3qQ8lls0qlyqx9/iSO/Evd9sB1aGLHSpmXXEkKnKxRtJkrjs3UZy3aqVjrJ6lc4JmDOADuQcvT0GQg4IecQFxrYZu/n0E4sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3Q3NlMtxb2qRAs8NP1SbANV5zHavtWgoNNjJqrQdDb8=;
 b=KzZ1ovJ92yVGlSpIPrnOwXNpLCrS0JucJUHAGLNktR1r1/ei5pEfyd3Rg+Zm/t/MXXitXIVKJ/a2F4ynLCGkpG+2w6vHUxfLxZk98c3qLRtCM2c9RBJvUr4Unjh4lTMs02zdNcaE0Qi59H91o+geb11MAR3L8JAWFnuuSyFqkuqNIlyMX2v1Cdu6QxcANiUAjGniQ7DFYgGF/ttQjpO4yDdyEDJJ2pOPJnOE3PfXQXgeFM8gZI/j3ib3k6LPsx1VBBk3An9rriDDRL4jkFCIjgdWLOJqm/zll3/C5J4TIUPPkPTwhwW7zj+OjBiMtfTSqm0Z7YYzy54BTGYC2ocqRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Q3NlMtxb2qRAs8NP1SbANV5zHavtWgoNNjJqrQdDb8=;
 b=aoT0uaBQ2X2ut/oL3Toyv6w5QZHS5ehEC6NvifaWjCbD8mdl3pwP4Y4n++K0XWKXC7ZAS4Ixh5OHD8na/bCcSsetPNKUMcTX1khbwdMNNPyQnrMSpfayV491rpzRDL2jdPdaron4VW6fJZvrLNRuRdluCp0r5dr2KD84biBcqXE=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7287.namprd04.prod.outlook.com (2603:10b6:510:1c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.14; Mon, 27 Sep
 2021 15:53:29 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::3d04:c2fb:e69f:27e8]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::3d04:c2fb:e69f:27e8%6]) with mapi id 15.20.4544.022; Mon, 27 Sep 2021
 15:53:29 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH 1/4] block/mq-deadline: Improve request accounting further
Thread-Topic: [PATCH 1/4] block/mq-deadline: Improve request accounting
 further
Thread-Index: AQHXsNKIpzsVm8czS02ZgK0FDLFxcau4DfmA
Date:   Mon, 27 Sep 2021 15:53:29 +0000
Message-ID: <YVHo90gFgIpvjdSW@x1-carbon>
References: <20210923232358.3907118-1-bvanassche@acm.org>
 <20210923232655.3907383-1-bvanassche@acm.org>
In-Reply-To: <20210923232655.3907383-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4c4b57cf-c09c-4d30-2abe-08d981cef332
x-ms-traffictypediagnostic: PH0PR04MB7287:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7287BA75C6E37F1CAF34FF37F2A79@PH0PR04MB7287.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YdK1rlPz+ZU5nqBi5tDXkv3/daFa9wKmH8dEwGEtaXLewiwzSAuUDYavMoZG2D9CxZJVrNCuVrdpMj/8b9fDtCVL8g8hjoSnCUNunOpOi8xVMIRYPXRxet7i8DZ3DUbBfa9Yi0MmhWAObzhqrWCGAdX5B8VJE3Nr7C2TCuWP0/j7dZhEMGPP8Ie4uhlmp/0D71MCeIMKJTKBd9NwpzEdbLkoHA0M2/fKsMEHBQeALrKzZJJ0Erw2Dqg4yljZdYZnaKxKbDotJ0cCTWG0he6pwvQor6bVqIGODDamEqINCOvF56uU0QQVHDWuSXDOjDXmTGhAWcdKRfVXw9yTbicBjk0GSy/9EJmvg5+eoitQKKlIQVBPJ6hSJTU9DTFmnO/YEaGLAqnCLgyZHHu6i7hcjLHJKwTXQ3mI5gHu8yg38pTEzJ2VURtDbuaCj17QHd9lHaD9BhEzUVJ60Yv9IXT6g62W4XXJCHwraRBcKia6vNbZCeJRPzbnrv5+dVlb2/i4Ha4hcTRpa3l5xC2YC1a6WadihoSYq7ZoYW6K3IhsLNhhZlxSInEcuLJrJSGXkzgQixkAlXj579Xc48VvBXN8hjv2jvdltw8eenVgatEQFT0u4OhcHbUUrEAEjK08QU+poZ43UHdcE/OzL7HzRNeS4BeofYKimofXSLJ9nUexhkptR3NSYrfQ7f6qMFTW+hFpwef6AZL6W8J209AuDZt6Pg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(91956017)(122000001)(38100700002)(66946007)(66556008)(66446008)(64756008)(66476007)(508600001)(6506007)(4326008)(26005)(186003)(83380400001)(38070700005)(6486002)(71200400001)(6916009)(15650500001)(86362001)(54906003)(316002)(8676002)(6512007)(9686003)(5660300002)(33716001)(8936002)(2906002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ggawVzb+J0GZBZg6nV0FeiP0GyFCKWaNuVlrENVHzu2dzkP5Cn+JCuYugSX3?=
 =?us-ascii?Q?w4mDeTG9u0xRAx4ssAgtRzirCxzIo0bJcCXTurKLOYFHoqT6MhckdrFGKpm5?=
 =?us-ascii?Q?aN80RUUctNc/GS5Cby2GkrqLXmfdIqEjb3L/CGXXqrLUAWyKwbvxNj/3fjQf?=
 =?us-ascii?Q?m/92lhjn8j3ZoX/QroydpshSLaGJ+CvTvIgXf7mOeJNeS/MjJFuhGc3HmY4P?=
 =?us-ascii?Q?8vYJP+7x7JRRki2tfWegYfqUOgVZlFclhsLWNPhg+UMH9iReGMUrw557Srjo?=
 =?us-ascii?Q?1qgcnbC0hjDNwlj1cilkQkmyqZAyq3HRCfVrd7bnkXQj/glsTpmqhAUgDrc0?=
 =?us-ascii?Q?HpFSPJlTgqALLNi4+WK40AVicqDTs0CWvlwfIldQbo0tZkV/x83P/2auDlga?=
 =?us-ascii?Q?cLxSDn7Xe0sSSjFLefmiGQKVSP36tXY4D66AuP+sXcqTXECsSEtpmjlxw+Do?=
 =?us-ascii?Q?05wzuwOuWZT6S31cBAa+jCxVIab2fCDyuxEgN4X/Xkcc/ihHJ1kL7LLJsTtb?=
 =?us-ascii?Q?PXx/63BHVjgN8Pi1pRCIH3wLneP7gBfK4CT8TqSm/PWEDsVWLOvokjvbHq5P?=
 =?us-ascii?Q?DTDQq6OlqPnjlry5u0/7tqbnadklWfWs495xd4Ssuz+dpjnT8JnqPJ7l8qFd?=
 =?us-ascii?Q?fuekSSQ0/a+5AjV2YetXbmw+i18tP85od86aT3m4pD3r67ADash2BnrnzR6Y?=
 =?us-ascii?Q?KjWeUjFbbo8ZGOis3w4Lf4cL0iGmagWPEdwZJbVkX4KRVmocOkgWJdkFuooT?=
 =?us-ascii?Q?vz3/xOo1KzxB/JEY/7G1fWv6y3gF/DEUBuC6q6pgxTqDqcs+fsMt7Tw9UOpQ?=
 =?us-ascii?Q?fS+UTjBDtqjlk6ydE/4QiaRB+KrWv4Wn0oEv/d5OWxaB8Mf1vDLwVziY6mmJ?=
 =?us-ascii?Q?qv2yY39A8rUbktBG7olmAN5DlBnTMsJN98mOZrPk8PAxnW53Zm+QgnWblV5q?=
 =?us-ascii?Q?zUdYWrMvELo3n/QqSqpiT5yXxi+vx4Ych0KXw2BkJhsTnI78yVSGVLOM0rOQ?=
 =?us-ascii?Q?0AmaOgarbMRZQptrEj57DM4ktOD+a21SvJS9G7f5gL41h+QU21fTP0SRzveq?=
 =?us-ascii?Q?2lFyen9JkRxET+fU4K7K9lNwtjW5ipShAsgZ8v2YNmE7JJPxYVQaHkAejFkc?=
 =?us-ascii?Q?3qCBGTxGUjaBeyAcWt+37uSPyXN0XHOLu2igeiOBYwxb1sw9f8Wr8cY7GPXA?=
 =?us-ascii?Q?qZslTxGgZH2BhZT10Wud1k3B2I95qCkoeujiln/RmCzrZ+Iziq3OwcwN0DXo?=
 =?us-ascii?Q?y0RmstONVP3MEj/fpjo+Jsob0D+Z4IqhHDiiMrOWkfcoSlgau2a2Iwj5zsGR?=
 =?us-ascii?Q?6vNlxhatOBpQtJ9a1NoeqqgEopdDx+l/86jwImprQY+Afg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9C5E11654E36CA43AD28F9753144B9C1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c4b57cf-c09c-4d30-2abe-08d981cef332
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2021 15:53:29.1101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FJCZX9G+0My49SmdlHQcwAFI/KgLYhETpnrBJk1/rl1/w8C6rBTlpEVZ33kE2IfYKPTT7zOXphcVrSQc7lR5uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7287
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Sep 23, 2021 at 04:26:52PM -0700, Bart Van Assche wrote:
> The scheduler .insert_requests() callback is called when a request is
> queued for the first time and also when it is requeued. Only count a
> request the first time it is queued. Additionally, since the mq-deadline
> scheduler only performs zone locking for requests that have been
> inserted, skip the zone unlock code for requests that have not been
> inserted into the mq-deadline scheduler.
>=20
> Fixes: 38ba64d12d4c ("block/mq-deadline: Track I/O statistics")
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Niklas Cassel <Niklas.Cassel@wdc.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/mq-deadline.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>=20
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index 7f3c3932b723..b1175e4560ad 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -677,8 +677,10 @@ static void dd_insert_request(struct blk_mq_hw_ctx *=
hctx, struct request *rq,
>  	blk_req_zone_write_unlock(rq);
> =20
>  	prio =3D ioprio_class_to_prio[ioprio_class];
> -	dd_count(dd, inserted, prio);
> -	rq->elv.priv[0] =3D (void *)(uintptr_t)1;
> +	if (!rq->elv.priv[0]) {
> +		dd_count(dd, inserted, prio);
> +		rq->elv.priv[0] =3D (void *)(uintptr_t)1;
> +	}
> =20
>  	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
>  		blk_mq_free_requests(&free);
> @@ -759,12 +761,13 @@ static void dd_finish_request(struct request *rq)
> =20
>  	/*
>  	 * The block layer core may call dd_finish_request() without having
> -	 * called dd_insert_requests(). Hence only update statistics for
> -	 * requests for which dd_insert_requests() has been called. See also
> -	 * blk_mq_request_bypass_insert().
> +	 * called dd_insert_requests(). Skip requests that bypassed I/O
> +	 * scheduling. See also blk_mq_request_bypass_insert().
>  	 */
> -	if (rq->elv.priv[0])
> -		dd_count(dd, completed, prio);
> +	if (!rq->elv.priv[0])
> +		return;
> +
> +	dd_count(dd, completed, prio);
> =20
>  	if (blk_queue_is_zoned(q)) {
>  		unsigned long flags;

Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>=
