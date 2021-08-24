Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BF5C4338F
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 21:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6EF36138B
	for <linux-block@archiver.kernel.org>; Tue, 24 Aug 2021 21:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbhHXVgH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:36:07 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:59528 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbhHXVgH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Aug 2021 17:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1629840922; x=1661376922;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hvwh0j6J/wJbbKO7jnKB0C0RhwP5UI4V+vp8di6bv5c=;
  b=nSZu/kb8haSJGtbM28NXLynT5U0H3sujXE0LjE0Csno11bQSfAsv3xGT
   73qCPZRrZGGic4uBiuouvEwDO+O85bY2mMiI3VGqxdthGk4JgN4wFU/VU
   0WkMRotqr5MkNBVG30vX8m84R91ZRgdnBw0LMVMJirAro8qVDkyI+2MZn
   qzgha3Y/fkOPHuNK+Cai4ettSKv6C93gUDSidltrD0tsK+wnxCDBrFeZG
   3++2gUnSSzxYgqzqPPuB2Thww379qNhG62XO/k0v34Nsza6XI6eD2fHOv
   xkLztQ1Ijd/urAAYim3xq1LUquOWDFZ19etjmzuO7W3twM/j/1BMvsKMv
   g==;
X-IronPort-AV: E=Sophos;i="5.84,348,1620662400"; 
   d="scan'208";a="282071871"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
  by ob1.hgst.iphmx.com with ESMTP; 25 Aug 2021 05:35:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSnoqH0lyR+g6k2sOQDfHXhokJtAllMH3QJK1BcHnQZ4C4En1QjYxx7HTFTc6oRCELAEi2QmhFenjAUp/Xvjxqku18MGYt3WS2ZoTcXIujWRqb9/gp888jGVWpuVKA1GMfougN67WSjSpPtmPLCriPgucA9nkzvPwUWqeFeAmuo/oSwjD6zg3hHU6WnatlOQfveDd19hIi2/JmPSqkp1juyQRc9LoRUnM9WM0R+HB+LDMxQydJj/Ox3yeynZg/mVEICXifCC000h5i5CudAEhj3I4SxJJ3EzvchcjjZm6gxUjVSvJQR29kN7EujI90B90wzlO3B9SYUY/oQfV6xo5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VyKNqmH6jyjCQ6gaoEgzKldqfojQWmx//SdB1Wy12k=;
 b=NKPnsU7V/90m3rqnW1wVtxKjUQh80QSCmPQpf/gB5LZ9CSujapta6NdSpsAaBYiyHaBE/trMiaGQdHqIwAqKojeYZs5gv91e9gQMhmXpNrsleTWn39Vf9skIX5+RMaPNDttSkDq/Ht4g5pDv3gVTx+dqBxpIM7OLt9/92SKwqUuCVVxR1bRUf5O8mSfx/MP2v+QVUH4pkn52X1m90SraCok90adnwafAtkKQnkoCjQKo4IFS5Kx12TSPbOMettaKYoyX1HgeAGvONuW5qCU6iJZhjM29W3f4++DacXvME1Y/4b/in0KkCurZyyHWOD9+2QxnEysoL6D8hbsoQ1mp1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VyKNqmH6jyjCQ6gaoEgzKldqfojQWmx//SdB1Wy12k=;
 b=SwAOTQAmgsRqOwyhBa0yJ+Fiq6E0tQ83tW0dmVaeZ1zOmg7XHdIOKRAZvIHU0Ji9/jx8HmEctjuJ0Ob5G0v3HhevIUR3BFRjJqkep+WSGoY/4mDSBjk92r+p6X/EqUARo+/EP7nRx0Wtmdy34p38SCdzbaz4uSuVKSAeVAiH8DM=
Received: from PH0PR04MB7158.namprd04.prod.outlook.com (2603:10b6:510:8::18)
 by PH0PR04MB7447.namprd04.prod.outlook.com (2603:10b6:510:1f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Tue, 24 Aug
 2021 21:35:15 +0000
Received: from PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::ad69:c016:10d5:a3e9]) by PH0PR04MB7158.namprd04.prod.outlook.com
 ([fe80::ad69:c016:10d5:a3e9%8]) with mapi id 15.20.4436.024; Tue, 24 Aug 2021
 21:35:15 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] mq-deadline: Fix request accounting
Thread-Topic: [PATCH] mq-deadline: Fix request accounting
Thread-Index: AQHXmQo/gX/I8ls140654nArQfUln6uDLcOA
Date:   Tue, 24 Aug 2021 21:35:14 +0000
Message-ID: <YSVmEWtARsGyrEW2@x1-carbon>
References: <20210824170520.1659173-1-bvanassche@acm.org>
In-Reply-To: <20210824170520.1659173-1-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0108a598-99f8-47e3-7118-08d967470f96
x-ms-traffictypediagnostic: PH0PR04MB7447:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7447224736F75DCD2E955D47F2C59@PH0PR04MB7447.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LZgwOvp/q3CGu6VlwORiIUp+wjz7Zjl/A52HLTKTNh2VVG8nF9MM/2jSjheUpxMPKUTRlCrxA4YRQ09M5U3S1UehFDwkKbPYadiwtDw04UbstclqunPOAePXgCDY0AMqKBOtQ/AZTYDxn4HfXgcFbmBMGkGYI/q+ljPAOFVsca+XPUj4oLJI3C6CjHqsL+u6X2BzW3fnlg0j70q0JIAZ8LEQFSJLeum2lJvPDHcS2YVbYuMXw+xw4yHTQceK58KrZ68fUEdv/HZBYikKnoLl7T7Bedq+306u2bKypWCTwRc7N8JPpCh2SoTc3J4B+ZF+97x6DXxLYIuMfbDh3WC9m9IL/ImcbSlsLv7mfZJSCVDD6Dh9Z9fYL1wH3y9NFw850LYAHonSnICaI4bcuEsY58GtY6A0LABLDiLESqzQ7oDCIPYzVhcNM/Aw+/4AxhR9MPEoOxSu0GVRGUVeJM235FLphKB63vFL5jpLFUBooZ6CzXDt93B87sDj+hLpA9gDoLTwPYt2536ILNl8DWdQ07HCXb0PVNCH5r/pFN6s6h/vClX7rowp6LpLV6T12Aq7lKlI3xVs6OcERBp7xIjuQrUqCOwRmkr6jtmIjXjwuNEz6QZ3YAmP7uTVZ7SnQQfSPBqpxMUMZzRLpKIevS6+3hg3Ngg5e7pQY/j8sRahW/RvkeXEu1QyefIOg8HBNavB4bdu6kGetK5AU31vhNt5lw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7158.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(2906002)(316002)(8936002)(54906003)(33716001)(6916009)(122000001)(8676002)(38100700002)(6506007)(71200400001)(83380400001)(66556008)(5660300002)(9686003)(508600001)(15650500001)(66446008)(64756008)(38070700005)(6512007)(4326008)(76116006)(91956017)(26005)(6486002)(86362001)(66476007)(186003)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lVm29DxGIchJeBZyYI16Vf/B4C0io/gfau4MrsBAPeTUvluREAZz/2HTHqB7?=
 =?us-ascii?Q?Vo9EGhL/5DZkg+EGgIbvrFuZvfJy1/tBDQ0eWNoSRdIOIuJJOeXFBsc735Fz?=
 =?us-ascii?Q?DFGFiS1goZHOM9kcP2M8GpeR2fukQGPWWTayv+8rUnqinKJhSHRMCRynIwE8?=
 =?us-ascii?Q?YWq2JBxbk0HKN0tJfa/qVcovfOtATIGSMFwXhEdNsv2aSw6l7JUpVK292UC3?=
 =?us-ascii?Q?pNKtkZCpU966XpApSLJpRMielrnhDeHvDZxjrxu8sWd1K6YEPR4UqCSiX4pJ?=
 =?us-ascii?Q?DnPPWufHUoIdsG+GRRHIoOuFG6QnwiS6lfcX9yddOdpdfiPHv0mmjCIyFTZ/?=
 =?us-ascii?Q?r8EM7EshdTf76mrKlCZ0ntaoDJjkA1VcB9uWxO41y+pPtb0P+ChFStsioHFO?=
 =?us-ascii?Q?3w0OO1GDadpGI4d75oXeAiUTg64alG2WfChaMbrHBgBAhdcVle/sYbnxMkh5?=
 =?us-ascii?Q?DGRTZueGeyaDutgr6MUEpXutzsGQy7OzA/6w6cths7yDUmjfGWE7ZYeW6Ce1?=
 =?us-ascii?Q?DycrmcYu+rgSRf85Z3bU+dEieztc+/O5Xlc7+Qj/qt7dICUBILh08T3sdgJJ?=
 =?us-ascii?Q?9rfUSnHbYBt4KuC4IzR4UjQFFVZw3oFfYJNRSkBv3XnPjAnlQRWp/gZY1P5Y?=
 =?us-ascii?Q?DeZHupO2eIOt345NnMJjWo3MyFlancjpCkkQFFXsFygupOMazSRBSyZj/cYq?=
 =?us-ascii?Q?r91lbHgZbLFRjMi8gWuhCDzXSeYPy7tuhu1f6QSCnp9z0NQ5hPgOXhtPrJq5?=
 =?us-ascii?Q?h1wgr0Gmge5z/s1JrYYNr5c221WW974br1/5OZuYSatop7Rpg+5DnKoMHli+?=
 =?us-ascii?Q?DnG9whcvrei+1QPHJ39vKMP0ffMbNsBAT2WDRIF8BLm2GC10Gc/8zcZIdGxK?=
 =?us-ascii?Q?xuB/tVWNl1DCHgrq6+zPpjU+y0+ZHMHJDsHFcEStZWs0V4M8lSAfoCj5GaRL?=
 =?us-ascii?Q?3BoNBpE0c4yMa6z22/EM0YL8hMK4xV6ES3un/BrTgtOWvDbgjNVeC/BTLtX4?=
 =?us-ascii?Q?2sgeVVoIesfAxWHzBiij4DzMfxXX1H+9ggYoWBfr4itkx69gRXcbhPwK++R5?=
 =?us-ascii?Q?p/5SFUf3THnKPJ5c2AsndHeZq4WfaUCW49y+b1y1ABhKYuOuBHWVzrLJbQR7?=
 =?us-ascii?Q?obXcb0RP+s5hVWXl3azglhunhlRaGnGduF2PGqV55/b/oClzfjGnY7kOixH8?=
 =?us-ascii?Q?ccXo3iFwBhoX9dC8EMt1oiLc+JFb98X0tOfMnEJWbPPC+CNdLIopFtn+u0VA?=
 =?us-ascii?Q?xkUrXqIMgVnO+tM+G0dduQax+f0SEC8eklcsKlj703exWnroO1ISigqiaqgf?=
 =?us-ascii?Q?7cHj0IbV/MJAGOJyqO/C3xTTq4sfU2QgkFh8l2B3yMPsEw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <258C7E70670B8B42BBB9B2F066953ED6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7158.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0108a598-99f8-47e3-7118-08d967470f96
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2021 21:35:15.0068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Z3UcF54uyillEhrAJ6xhckNkn2nSTPs202nzaxa+NXMHKWdI5zRX5A1CHmJo002T7Dsp+90B7+uuT87ePPsZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7447
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Aug 24, 2021 at 10:05:20AM -0700, Bart Van Assche wrote:
> The block layer may call the I/O scheduler .finish_request() callback
> without having called the .insert_requests() callback. Make sure that the
> mq-deadline I/O statistics are correct if the block layer inserts an I/O
> request that bypasses the I/O scheduler. This patch prevents that lower
> priority I/O is delayed longer than necessary for mixed I/O priority
> workloads.
>=20
> Cc: Niklas Cassel <Niklas.Cassel@wdc.com>
> Cc: Damien Le Moal <damien.lemoal@wdc.com>
> Cc: Hannes Reinecke <hare@suse.de>
> Reported-by: Niklas Cassel <Niklas.Cassel@wdc.com>
> Fixes: 08a9ad8bf607 ("block/mq-deadline: Add cgroup support")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  block/mq-deadline.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>=20
> diff --git a/block/mq-deadline.c b/block/mq-deadline.c
> index dbd74bae9f11..28f2e7655a5f 100644
> --- a/block/mq-deadline.c
> +++ b/block/mq-deadline.c
> @@ -713,6 +713,7 @@ static void dd_insert_request(struct blk_mq_hw_ctx *h=
ctx, struct request *rq,
> =20
>  	prio =3D ioprio_class_to_prio[ioprio_class];
>  	dd_count(dd, inserted, prio);
> +	rq->elv.priv[0] =3D (void *)(uintptr_t)1;
> =20
>  	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
>  		blk_mq_free_requests(&free);
> @@ -761,12 +762,10 @@ static void dd_insert_requests(struct blk_mq_hw_ctx=
 *hctx,
>  	spin_unlock(&dd->lock);
>  }
> =20
> -/*
> - * Nothing to do here. This is defined only to ensure that .finish_reque=
st
> - * method is called upon request completion.
> - */
> +/* Callback from inside blk_mq_rq_ctx_init(). */
>  static void dd_prepare_request(struct request *rq)
>  {
> +	rq->elv.priv[0] =3D NULL;
>  }
> =20
>  /*
> @@ -793,7 +792,14 @@ static void dd_finish_request(struct request *rq)
>  	const enum dd_prio prio =3D ioprio_class_to_prio[ioprio_class];
>  	struct dd_per_prio *per_prio =3D &dd->per_prio[prio];
> =20
> -	dd_count(dd, completed, prio);
> +	/*
> +	 * The block layer core may call dd_finish_request() without having
> +	 * called dd_insert_requests(). Hence only update statistics for
> +	 * requests for which dd_insert_requests() has been called. See also
> +	 * blk_mq_request_bypass_insert().
> +	 */
> +	if (rq->elv.priv[0])
> +		dd_count(dd, completed, prio);
> =20
>  	if (blk_queue_is_zoned(q)) {
>  		unsigned long flags;

Reviewed-by: Niklas Cassel <niklas.cassel@wdc.com>
Tested-by: Niklas Cassel <niklas.cassel@wdc.com>=
