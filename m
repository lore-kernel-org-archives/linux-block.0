Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1712BC678D8
	for <linux-block@archiver.kernel.org>; Mon, 16 Jan 2023 17:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbjAPRgT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Jan 2023 12:36:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234984AbjAPRfz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Jan 2023 12:35:55 -0500
Received: from BN6PR00CU002-vft-obe.outbound.protection.outlook.com (mail-eastus2azon11021027.outbound.protection.outlook.com [52.101.57.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9780F38B48
        for <linux-block@vger.kernel.org>; Mon, 16 Jan 2023 09:11:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBRncqxQh610UuUhlAlYg5m808eWSzYS4AtIQxbjpnWXDFQ6RZK8Q5NKNee8lBu1ogwwc/fIEGAF7fVMfHrbl0MgnHOx0WMtba4SSwmuzszIlWUpsckng35/8ydSXcHe1GWtyzZX+Uch5CZ/IH506cdC95ZrBHpm4lDkuh+br8qyvBS7+KSLs1D2zMj9a3G7UuUfCsmvyqPm9OrZvDl7HX0+C1t1mHVoco34DF8xTvx/yj1OONBjPv7dIXFAhNb5s9Tlolu23tAKTiegySAI5ahtraohYuC4kGbyfgP7Rc4Fcm+QDg2P3nwldlHoYT8JlZjWp5WzqmYgAzbxAoZaTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Tz5rh22WKyg77d5tFAiYOGzPk1kf6uJfrXxl2jZQC40=;
 b=M/TsSMwPPCQN6RbCvS5H6LfYipDWF9HQNDkOwZBwwEScYTcD58xFWNFbIUMXceE9h7RNEqUEASjr4udDztOY2HrCdYmQiZ4V16MGmccVMIZGZM6doe+3udLfXm15TueOvKguaTYBWpDsaJCawZRZzZ/rtR7OmfyP+c0Y4Yb7w1yKkrFelpuiZudbnfK4lGcvX2mHOpnlDKmLppG9DfAZWMQ7WVjLHce+pBAHeEHCFOsVV8gOs8e8b5A99LrRPiwgFNNwAXqPI2PSQpYYiHpQTCxzjtVXhZcTQUuPOxv+cPDHvPmjgN5sMYT3kWIsdHWTwUVrOfIg9iFGJuI6asJbUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tz5rh22WKyg77d5tFAiYOGzPk1kf6uJfrXxl2jZQC40=;
 b=WFKmRCDgTisoX8aazT7c5Nmmj7EU1eoO5cLOlcvlr8rVfT5HBjw+UiMgJk2oJPgbK37YE2d4dHe8dutmfRaD4rt5DBNp7U2ug+dHhMbbrHHe+WqInJ95MnCjt4iR/IRV9tbDISPFFlvmuTuInLVr0yCBqBeocVxZGmosVrLSf84=
Received: from BYAPR21MB1688.namprd21.prod.outlook.com (2603:10b6:a02:bf::26)
 by SN7PR21MB3909.namprd21.prod.outlook.com (2603:10b6:806:2dd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.1; Mon, 16 Jan
 2023 17:11:53 +0000
Received: from BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e]) by BYAPR21MB1688.namprd21.prod.outlook.com
 ([fe80::9a9e:c614:a89f:396e%9]) with mapi id 15.20.6043.001; Mon, 16 Jan 2023
 17:11:53 +0000
From:   "Michael Kelley (LINUX)" <mikelley@microsoft.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: RE: [PATCH] block: don't allow multiple bios for IOCB_NOWAIT issue
Thread-Topic: [PATCH] block: don't allow multiple bios for IOCB_NOWAIT issue
Thread-Index: AQHZKcPU1w6g+r0gYUSvsTLUREweFa6hRnwQ
Date:   Mon, 16 Jan 2023 17:11:52 +0000
Message-ID: <BYAPR21MB1688FCAE25367032B13BD9F2D7C19@BYAPR21MB1688.namprd21.prod.outlook.com>
References: <c5631d66-3627-5d04-c810-c060c9fd7077@kernel.dk>
In-Reply-To: <c5631d66-3627-5d04-c810-c060c9fd7077@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=20dfb61f-75ef-4e6a-a114-6ad38d3ea2a4;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2023-01-16T17:07:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR21MB1688:EE_|SN7PR21MB3909:EE_
x-ms-office365-filtering-correlation-id: 0d77964e-e858-45a1-0270-08daf7e4c354
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IKVzSV4urLBpzpBubUgKUrDMYmtlI52OzPjabms/5u+dj512XDJhbFOeixhbzOJiNPqTUSEnZbYgQSYozhFbUQnu5hqinpmNeWEZUY2QfmUVgGlmoCSW33jnrkF8lcBVgZnPLvsw2DACpk4EHl5Xm2l/kALLtxg6wKhz7PXoMtZhRHZZfxxUsjnSkvGfnBGHPZv5T3/makrXgtGgzLsckUk4a4gRYSbh8qECXMiZmj9Ggs9lOV4jGXqlkVc0OVpg7+23za534HFQqx0Pf96ojWNtmF1cNeQajqRbp+v0Xt/jiKqnE0BCuW4QjN1vTB0WZucAwBqAc6vnHwqMHGxGda+jMCAKVm9Pu/+A3J80HCUQEifXPHPgmhVLHI/EZV5lb4OrmsM+rOXisbUO5EfFVWdo2m6Pb1rhhZ0IvX6Ka8fGQiq6ejby9WsCRsqyjAgimtABfDRSDsSpt+/KT3PMsIGPRPfDSWdwMfUgKiR5rlskovxGburEdAssVZTLa1ZI02C+BAflbcaV5KQ2xUjgylAzBcvYXGbDh9JMSZLL2cZ5AAlHxvrWvJfTh2whA8lIjqX20hNOOUINuhfcOhBo2S3w8Lech2OTCqRwhYCu3qxg/ZOOqgv5xlOUdowFzvPqhUQz1PhRxfXPkRC7bU1MA04Z1w0qFGqBFY1WYpdENSOBTOInkU+cK3w114ASSA0tCftb8ludJSmgcc0KcUJo3AeuchCnFN9d/SmK0I3Oo5q5FXjP7PxMgaDF+zq5oOSdQW6k1PEF3Hww+zdGXGm5oQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1688.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(396003)(366004)(346002)(39860400002)(451199015)(86362001)(38070700005)(8936002)(66556008)(66446008)(8676002)(66476007)(76116006)(66946007)(52536014)(64756008)(2906002)(5660300002)(55016003)(82960400001)(82950400001)(83380400001)(38100700002)(33656002)(122000001)(71200400001)(478600001)(7696005)(966005)(316002)(10290500003)(110136005)(8990500004)(41300700001)(9686003)(6506007)(26005)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9Yes1cQFiV64W31FPvdk6Jv2/+fEU5wjlPUueAX50LcJrj9bs3kj6iZoGAZP?=
 =?us-ascii?Q?sw00+HDHIJ2fpmVKBt0iwbZoG8Q/xVWbMl4pilYpoV+aMMwAm9+6yynwdJ4d?=
 =?us-ascii?Q?IFvikFkhayC7EQCIBJWOvbpQjXq/oSkKfHUWhhcPh4pJy5g8/XKZWS/C/uSA?=
 =?us-ascii?Q?Sr6DxeXRMQ+p1rT/S9osrA9OiOcPpP5nfnF82JbPkk+g8ap8uFWB02ymM5HA?=
 =?us-ascii?Q?QNGqwxhfXBhl+IE4pjhOphNBUm8CRgRlQ7G8W37w8hCdji2VLYskycuth119?=
 =?us-ascii?Q?V7baB2q9wUAwm8vhGxTwKv2GdovlaJgCaZ51zTxhLLDXEbEfXWSsIFwW3qYi?=
 =?us-ascii?Q?S4rpf7JtoNvAx5EpLTib96oaPWChjaZITM7YO7KtnHon5sartXbZciMGOuhk?=
 =?us-ascii?Q?0Yyu46V6Bm9cMAkYdl/RpvI9/mV8/QTM0KDRwBkkX6HROHKFYeRwdD4SvRHR?=
 =?us-ascii?Q?EutS2Y4nmWs+Lo27lFmzw97JfZce2rAsdHTsbQM4jTTVkFWVFBiF3sD52ajC?=
 =?us-ascii?Q?ZrTFnF8ZCh5humqwoWAQc6Ge6/DDKQmroyAUvSL548uvsbphXwphigCfKqxe?=
 =?us-ascii?Q?LX4QEqhYNnxyZy48BOxXTV30M23RReVG91QqAB5r/CY+tZk358oruu3yh1iQ?=
 =?us-ascii?Q?QGz9yuwXsx2kXv7kqRfbcwyMsv0qRsysLqt25mx4KEeNwOrcECXT/hko80Qf?=
 =?us-ascii?Q?9pD+TPR5wAW9Deynuw7QB1v+3vzFr1rYU4q49XDxf4Ynd9r0bDYKxF3FxkBV?=
 =?us-ascii?Q?a40n2U6ami45Jo7NEcsbtU1M2Mw4t1lGAFl9wIAe972igprUZSzN4pkmbu9l?=
 =?us-ascii?Q?RkZkQct/lpqbhOw70QjYFGVpTDUgYUs5eYD9PNanAA7ROeDGFRwmCPjTjEHc?=
 =?us-ascii?Q?RvOqdCfjhlBnfN2NZgladOCweOHVn0JlKA3P5pMQo0+xQYC3BK6pBkiw1Y0H?=
 =?us-ascii?Q?v2BZhaFTe+5JNLe++MacMzaLUIiiCIG2+ea801cFXirRIe75ZYinoskLgJGl?=
 =?us-ascii?Q?kh+Sk4g1oTv8DYX93htzpdwYKtKo9vx0AvOdFwMLBGVIkCWM76yuKto7E4Ns?=
 =?us-ascii?Q?jsctjEJlsajaJHzcNxGJoCpy+tHgISzCxHDn+3kUHC/1TeyNJes+9XB1ipLK?=
 =?us-ascii?Q?eDGmNYaxYiRkanxHOEFRGBAbOWpy4nNeKoaCQywwg4p24NtbPp/fiEpkjysP?=
 =?us-ascii?Q?g4N+dwm6A1Fb8OpTuHPg0bNynpgcq9+pBbFOtKyPhrWfijEs7297Wc2Xz12u?=
 =?us-ascii?Q?ILmRWPJj14o2TZbTjKn+gQirO8WbDq2/MhW8CHvC4/1RAZk4pvqcVv+gJ2rA?=
 =?us-ascii?Q?X9DW8Lshmye+5JHbLXzm+icF6ALPKbwWwK5FPBnIXyvYcMTEKjq8QnmsZY50?=
 =?us-ascii?Q?IMEpoOI1zrWqToXVRSADGWsK9wGUKtCpktr+JMMzcBoZtkAu0PfNh7uywb4e?=
 =?us-ascii?Q?4+z/CUXkENT+0tWMkwcHyF/ZIEA/Q5LFy3bMWhbOz2qUyJbNVE51Y5tgDihZ?=
 =?us-ascii?Q?k4906XUG4Q8dHvcVGEM+RSzGwv2AgiBb5dcJO0XdTDjLB7bBe5r/uCB5InzZ?=
 =?us-ascii?Q?ERlYVlX9BUgoS6xu3KhHhTRsgY7VuITPXs9d89ojjhBCOrMR4/02A8oGFn/u?=
 =?us-ascii?Q?vw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1688.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d77964e-e858-45a1-0270-08daf7e4c354
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2023 17:11:52.7857
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2HqrI53TRKAbrnRaqjhxyITq8Xha8YaoUUM5V7fA71xr+95KANJ/MD2M/89NEeyirvQMbIArym8WS3+OJUx9CerkqeJap6gsVT56ZW+4dNU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR21MB3909
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Jens Axboe <axboe@kernel.dk> Sent: Monday, January 16, 2023 8:02 AM
>=20
> If we're doing a large IO request which needs to be split into multiple
> bios for issue, then we can run into the same situation as the below
> marked commit fixes - parts will complete just fine, one or more parts
> will fail to allocate a request. This will result in a partially
> completed read or write request, where the caller gets EAGAIN even though
> parts of the IO completed just fine.
>=20
> Do the same for large bios as we do for splits - fail a NOWAIT request
> with EAGAIN. This isn't technically fixing an issue in the below marked
> patch, but for stable purposes, we should have either none of them or
> both.
>=20
> This depends on: 613b14884b85 ("block: handle bio_split_to_limits() NULL =
return")
>=20
> Cc: stable@vger.kernel.org # 5.15+
> Fixes: 9cea62b2cbab ("block: don't allow splitting of a REQ_NOWAIT bio")
> Link: https://github.com/axboe/liburing/issues/766
> Reported-and-tested-by: Michael Kelley <mikelley@microsoft.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>=20
> ---
>=20
> diff --git a/block/fops.c b/block/fops.c
> index 50d245e8c913..a03cb732c2a7 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -368,6 +368,14 @@ static ssize_t blkdev_direct_IO(struct kiocb *iocb, =
struct
> iov_iter *iter)
>  			return __blkdev_direct_IO_simple(iocb, iter, nr_pages);
>  		return __blkdev_direct_IO_async(iocb, iter, nr_pages);
>  	}
> +	/*
> +	 * We're doing more than a bio worth of IO (> 256 pages), and we
> +	 * cannot guarantee that one of the sub bios will not fail getting
> +	 * issued FOR NOWAIT as error results are coalesced across all of
> +	 * them. Be safe and ask for a retry of this from blocking context.
> +	 */
> +	if (iocb->ki_flags & IOCB_NOWAIT)
> +		return -EAGAIN;
>  	return __blkdev_direct_IO(iocb, iter, bio_max_segs(nr_pages));
>  }

A code observation:  __blkdev_direct_IO() has a test for IOCB_NOWAIT
that now can't happen, as this is the only place it is called.  But maybe i=
t's
safer to leave the check in case of future code shuffling.

Michael
