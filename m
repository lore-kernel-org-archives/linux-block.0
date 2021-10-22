Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB4AC433EF
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 09:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 466F7610D0
	for <linux-block@archiver.kernel.org>; Fri, 22 Oct 2021 09:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232038AbhJVKBT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Oct 2021 06:01:19 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:13434 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbhJVKBS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Oct 2021 06:01:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1634896741; x=1666432741;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5bfhU9GGYQw8zv21dVtghFg8ahrjGb3NK+s0YP/h4Eo=;
  b=IROISTPWFM8x/MhkcFe3BfwTh+6ixCA2zj6T0h2x6BgCZA6k9iJ+zbQu
   8Ah59TkcH9CoB4srP4SIpc9RFIZITEFa8k/tAHDDQzFSDmWGxpFKVZ+vx
   HZgtczFY3y+p4qjeNwPLwoYNw8T7bi9b3c0jhERbD+EfqSNP7Qqm7UkOJ
   OgPZ2ya5sXwsz0+8F0My6BNLOl+QhQq1YEFDfP2P7KQIefxR+CBZdjCNo
   WTYAh6lVbyXAxYQcVNhaC3CeOq+ngCdHj6o8tks+cS8knTzBnDycvvz5o
   na6nLevjFnnpTQGyDMTJwcLCAP4EN+y9PMZmmQrMayTDQOYC81uEE1Z0S
   g==;
X-IronPort-AV: E=Sophos;i="5.87,172,1631548800"; 
   d="scan'208";a="184543493"
Received: from mail-co1nam11lp2171.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.171])
  by ob1.hgst.iphmx.com with ESMTP; 22 Oct 2021 17:59:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HJqYKJc2nEQ2Txq1QoIx17CRRmbiGqMuxYgNprtBT6j/ynKFWAuaHt/28sDXq4Lmt1pOigpy5dmyHU4KUbI48rVJRX4cyLFxNXvFR/LkQCLo56FCpm+saLxGvUYW5NiVxnuuTym3r8n2LVjEdyNowDsmkLZhas6k5vlBeT1xYd48RxwsWOfsesx4mUAWYs6cDhU0+G7vtyzkXvFCyM4fFnNFiya76BFbtTvY1pfH+WEbf94FqXJlP77QOptjH+U9ZEA3L9Gjw/H7mkeMRw/KqxpQcC7N6Wr/0/y+Z4KtKx8n4J5fmjnXk0OervXNXOZ57FcFtcWFczolggK4Y/FYFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVxkhl58hvQbbsAyqyv1QGbcbkDxyzECmyyJlFDYf+o=;
 b=kfzfCugTE6Mid/C5BDCHaKAnoqlQUGzIb08oJzH21yXVTx8cQDegIbz8ApkMbOnk+Dyhbx6EKTOdIpFop0Qjzvkd9wOGnmrJF7giqzz8Y37hutq5h/r/1oEa+LRwX3Raa/iwRJIhK+Wruxb6fxhs3j7AjuU7toP8n9VxcuC0JJlCLC8v6zrIt0NOeezTp6iwpnumYJKuAiSHEfuSd7kHWvlZeY3iqPaw6q61UKwVG/4Zttrk/rGy1Jyo1kZHrELtLuQ0CqhNCqbm2A3Rh/WLeQ8Mgb93m1DO7EAM3p3D3CdHKVpWSjCM6qa5L518/zfqcHs5W2qy12M0p94kGnrRRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVxkhl58hvQbbsAyqyv1QGbcbkDxyzECmyyJlFDYf+o=;
 b=PWOoF0Iu3Mz3LxFTfFZlXSS/A2tqYUiCl4hts3hTeVtw33Y6ZWIAqv3vrF71uVd84i+hk2o/vLMGfu1v8hroiSyx57pj99jNpQjU3/nW1G2Vov9hlY6E/Z37pcgkl7RtWtEVNpWrrUAbpEAcixkqEKUHbRVDo9J1N105uZ0ds8g=
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com (2603:10b6:a03:291::7)
 by BYAPR04MB3943.namprd04.prod.outlook.com (2603:10b6:a02:b3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18; Fri, 22 Oct
 2021 09:58:58 +0000
Received: from SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::30f6:c28:984d:bd79]) by SJ0PR04MB7184.namprd04.prod.outlook.com
 ([fe80::30f6:c28:984d:bd79%5]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 09:58:58 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Pavel Begunkov <asml.silence@gmail.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH 03/16] block: optimise req_bio_endio()
Thread-Topic: [PATCH 03/16] block: optimise req_bio_endio()
Thread-Index: AQHXxytuEAgyhBAT6k+CgrSiktXh7w==
Date:   Fri, 22 Oct 2021 09:58:57 +0000
Message-ID: <20211022095856.2ymvvuz3xrtcuyw3@shindev>
References: <cover.1634676157.git.asml.silence@gmail.com>
 <8061fa49096e1a0e44849aa204a0a1ae57c4423a.1634676157.git.asml.silence@gmail.com>
In-Reply-To: <8061fa49096e1a0e44849aa204a0a1ae57c4423a.1634676157.git.asml.silence@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ae9d763-9a21-4c27-b1a1-08d9954290e5
x-ms-traffictypediagnostic: BYAPR04MB3943:
x-microsoft-antispam-prvs: <BYAPR04MB3943E14BF40B3F5EE9FF01CAED809@BYAPR04MB3943.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wjLbaHOIrfVSQSs18mpyqWDr3HPAxyfkIxJ2E9458+jUlO6P4b+D2xcpSjExL6jFtNMGPayaicoCMw2nitywgAO3wi8cc8+1iyGb8qIxZUc7hWls0UF81mmRuAtZeOaWFIZmFQhGZg2a8NF8dZop3aejQPMACIq7hnvPE268aFf0DJqTb3MZ9d1RfSenJ8hWe9kSIdgO3nUWSic1w5S+EH7OHwHRHDgxsWmvBIoIiJMQOa+DSgJm5mjlzjk+by2HYWyRtKwPEQdo/LV4fzAWPd2g6GkRunWcszBepBpapVDRpRGDElGUD0TYIkk0ViUTk5x0UXfhn6CWSF9WaVZOVoVg9Qu7ZAr1fUq1ZKpD02M/wjxuwAVvdLksj3okg/+ziC7DAKmpl4iJQysyKxqhjbhkOK+zGsxJeKqZuVI/WaJTaoTVQOkhuqJgB9FtaNn3vCr6E5z/f0BjVATiDbalkFIRrNCCwFbQOMl9ljJqF7XaMF4fKdBHwrOLRiFnNcfyETGUtA1LdQu+bcse2IcmOPHGLM5JnozBHzJdzZBAv/xZPG2I6UM4AYaqmPJp3q/uyn54umrIQXYO7mdGjhc+JkB+TgPdTqWBPXwIPjbbL30Ij+sks0g6pDAS+WCl9Zsw/zvfUAWp8Ubcuj1dlfK1YYl11UKil5h//KuA2FxPbTi4tPmzUQMoHbaRMtbHj/YJtykVOIKYTHuH63Lh6gWVvg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7184.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(1076003)(6506007)(86362001)(33716001)(38100700002)(26005)(8676002)(186003)(6916009)(4326008)(508600001)(44832011)(91956017)(2906002)(66556008)(66446008)(66476007)(71200400001)(6486002)(9686003)(5660300002)(6512007)(64756008)(76116006)(316002)(38070700005)(8936002)(122000001)(66946007)(83380400001)(82960400001)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cvsKYJ4JuNEnpe8KjflehZ8FRoviR1SAMcmi4/lHEFL7EzmH68p5rnKTXzO5?=
 =?us-ascii?Q?8ltadEe7Mq1du8D3BIIIPoKdOwuH0KJgbHD7h257pp2sFbBc/12qGQ9IFGQd?=
 =?us-ascii?Q?zsJkxfLTwgGnh5QDIEso7vrfX9K3/GdkmHPO781Zoq2cd+ADobDWYa1TfyiM?=
 =?us-ascii?Q?N0Upo1HRKEcupyhn6841Ky8CDmVz8mNyZVegVCwPURgcHTNI2MRDMevCI0H5?=
 =?us-ascii?Q?SLlCWXnuY+oDSVNeXuxEs/6G4WUfDBjTXjUr1A4P986YlP0PGGEyewyu4lj2?=
 =?us-ascii?Q?VEYDVzARMDulVwZ69jFA/dRdktR6sStIS5WTa93n/IXL60qpvwOpDqcZR+AZ?=
 =?us-ascii?Q?0CBY6smh920+UUJX+AVAhAYUUvX5Gm2cgehIBsaorlPLKCnMbHvq/Axnvkz6?=
 =?us-ascii?Q?TBQnk9GDk9ed2JyfbDktycKQ2Cbx0epohBcxtMcKIMNej6y8L5x7oa9Fh1Ay?=
 =?us-ascii?Q?yxB8Fo7TK1BdqfDm86yEXnAHoLf9jqamLPvD9UVoTJbdFJpU+LvICwSH2U/i?=
 =?us-ascii?Q?/y+eQsYVkcDrViXklKcZzKTqVGCzX3M9IRx7VM8KVgppeFGSPTBb0TV+eru9?=
 =?us-ascii?Q?i/pZMP8HD4kLnhSxYvQcH4X7IGiPUfIWRq/kUFtVg4D/HiTL5NjkgqaRoHP1?=
 =?us-ascii?Q?hBRvJyJX5x0ngm/rbXDG+op6UuUyibkff1PWRFmtLSppc3ngohEgW8FgZS/q?=
 =?us-ascii?Q?8xqGmBltDe4tiaavrMx6xjE3dsFl9DEzskCUkPs3uc3T8eR9h1mrmIOsc4nC?=
 =?us-ascii?Q?ljzZioj3N9A1HbPGqTJy658ziXNG+BNyBlrGafPH+gO9KawdBdUIpNHid0ip?=
 =?us-ascii?Q?4wyErTDzogQcIYn8J+hlri+YUtqBg6CLDZfFPkC1uW8EkDJ9f+bjvHa9ApvT?=
 =?us-ascii?Q?hDKIPATTdPCK1DWakwrsy8XgpKdfvgjoSNuqP0uFG0gAUv4CF4pcCziqwlyo?=
 =?us-ascii?Q?/Q35LuagtvdzG5f2L89uESlSGKD9LFYw90bGnZ098PgaWjtqXXU/XrCGJTxD?=
 =?us-ascii?Q?YtiSFXJ5mECKV5lJsglMYtU+UjW70xQc/ki9/Xhn7W2C6HRP66eJG6kRvogi?=
 =?us-ascii?Q?Ncn7ZT1XLmsrF5EzLKXJG1MRglcWbRfFa/M4qBSEq7ITNcKgSWxtU+Ej41OG?=
 =?us-ascii?Q?sRIhYi2jYQKI0PVG1+1NXZAN3KlXJV2mC5L4rxky89MGM7QUn2+whx2X2gjt?=
 =?us-ascii?Q?cRD07tPlcjhzz6g90TI84YgPn4ntcCxqvOTpdXf+Oj+xya5POgHW3K68fyiH?=
 =?us-ascii?Q?MtNJGZWlryHkF4LpVdBW0IkRs2fwU3vWMnSup814qQ7UshfcC4FxqHqgMchk?=
 =?us-ascii?Q?Wj3Pem01fXKDisIIALT17fQt5lfd4Qrtfz98bENbM8dKtso4ufEzFDcOGUPE?=
 =?us-ascii?Q?qM6Tk9ohwUmjKGTzjM76pCqLAy5+zm5ha6YCDRmOCHatsn92isSGGT3/8iYd?=
 =?us-ascii?Q?A6Hp59dogRfCL6CplFuol8KSqIo4EYu93G5SK6FLMmV6bDTE+sdbNQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EA6BA2F255F9D048B11AABE9EAF6B23E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7184.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae9d763-9a21-4c27-b1a1-08d9954290e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Oct 2021 09:58:57.8837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: shinichiro.kawasaki@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3943
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Pavel,

Recently I tried out for-next branch and observed that simple dd command to
zonefs files causes an I/O error.

$ sudo dd if=3D/dev/zero of=3D/mnt/seq/0 bs=3D4096 count=3D1 oflag=3Ddirect
dd: error writing '/mnt/seq/0': Input/output error
1+0 records in
0+0 records out
0 bytes copied, 0.00409641 s, 0.0 kB/s

At that time, kernel reported warnings.

[90713.298721][ T2735] zonefs (nvme0n1) WARNING: inode 1: invalid size 0 (s=
hould be 4096)
[90713.299761][ T2735] zonefs (nvme0n1) WARNING: remounting filesystem read=
-only

I bisected and found that this patch triggers the error and warnings. I thi=
nk
one liner change is needed in this patch. Please find it below, in line.


On Oct 19, 2021 / 22:24, Pavel Begunkov wrote:
> First, get rid of an extra branch and chain error checks. Also reshuffle
> it with bio_advance(), so it goes closer to the final check, with that
> the compiler loads rq->rq_flags only once, and also doesn't reload
> bio->bi_iter.bi_size if bio_advance() didn't actually advanced the iter.
>=20
> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
> ---
>  block/blk-mq.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>=20
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index 3481a8712234..bab1fccda6ca 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -617,25 +617,23 @@ void blk_mq_free_plug_rqs(struct blk_plug *plug)
>  static void req_bio_endio(struct request *rq, struct bio *bio,
>  			  unsigned int nbytes, blk_status_t error)
>  {
> -	if (error)
> +	if (unlikely(error)) {
>  		bio->bi_status =3D error;
> -
> -	if (unlikely(rq->rq_flags & RQF_QUIET))
> -		bio_set_flag(bio, BIO_QUIET);
> -
> -	bio_advance(bio, nbytes);
> -
> -	if (req_op(rq) =3D=3D REQ_OP_ZONE_APPEND && error =3D=3D BLK_STS_OK) {
> +	} else if (req_op(rq) =3D=3D REQ_OP_ZONE_APPEND) {
>  		/*
>  		 * Partial zone append completions cannot be supported as the
>  		 * BIO fragments may end up not being written sequentially.
>  		 */
> -		if (bio->bi_iter.bi_size)
> +		if (bio->bi_iter.bi_size =3D=3D nbytes)

I think the line above should be,

		if (bio->bi_iter.bi_size !=3D nbytes)

Before applying the patch, the if statement checked "bi_size is not zero".
After applying the patch, bio_advance(bio, nbytes) moved after this check.
Then bi_size is not decremented by nbytes and the check should be "bi_size =
is
not nbytes". With this modification, the I/O error and the warnings go away=
.

>  			bio->bi_status =3D BLK_STS_IOERR;
>  		else
>  			bio->bi_iter.bi_sector =3D rq->__sector;
>  	}
> =20
> +	bio_advance(bio, nbytes);
> +
> +	if (unlikely(rq->rq_flags & RQF_QUIET))
> +		bio_set_flag(bio, BIO_QUIET);
>  	/* don't actually finish bio if it's part of flush sequence */
>  	if (bio->bi_iter.bi_size =3D=3D 0 && !(rq->rq_flags & RQF_FLUSH_SEQ))
>  		bio_endio(bio);
> --=20
> 2.33.1
>=20

--=20
Best Regards,
Shin'ichiro Kawasaki=
