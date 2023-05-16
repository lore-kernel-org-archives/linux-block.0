Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF81C77B7A
	for <linux-block@archiver.kernel.org>; Tue, 16 May 2023 08:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbjEPIUP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 16 May 2023 04:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbjEPIUN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 16 May 2023 04:20:13 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C03219A6
        for <linux-block@vger.kernel.org>; Tue, 16 May 2023 01:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1684225213; x=1715761213;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jQf3VwvQXMhuTaqveBuz0siVnX0Cwsw2Gp/mzIY2MKg=;
  b=NWKTad4o7zyXYAdrRVUz5cnf354O+qCLI2JU9GnKM+BhjscllGQHMSHL
   4Dg7mOzgcCqVfrs1u9RtmFj9NBbl2br/AF1nNpC4hwqECbUyGCp7p4RV9
   BQ8bcNunoqDMLVnH79TdJBSUrzc7QTGeovpNRFWFh+Xe0GSU2YXSwuKPn
   l81OwsJPClrZtE+OV89wFUsiw/fzEkNu/B+85OUOJBLYi3IiPcEMmUGEU
   tpHMcUY7zgGFILk2d4dD+twXjY2uqXKQZFcnuMR11YyJlIauXZ2rxK5ig
   fgQHdfKMQMF+2kpku5zvK4JemObNEfTIOhY9SMLKeOJj9TFDLtYIJr6Dm
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,278,1677513600"; 
   d="scan'208";a="230813387"
Received: from mail-mw2nam10lp2107.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.107])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2023 16:20:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNzCeCMe8B2TVLDwkoZAqigdRxkUYAaHRrvn/USWVfldF5DYIy5pqm8QRxg5xfaQxVipkOdhLyl5L4JrDCYSQhR8IdgTOaN+ZmGVyZqsiVt6VeVoTTkhGnbMyRNj+tPIlNkIWP6pCcSmqkpQ/4SV/294kZvoDbDT/E7dN1v1Y7ra/ETJYdtIWuoLjxuBAXYFYvsTCCYx87zBP+///l7gCYTbZZxUuedKC5d6IcpS5NvoNChGoZL+OauX0enwQ/DgpeY2zZM2YoQOtjSMar9ZinHsK/hHwgt1mLWrHjRZ3hmtcT27ILpj/xCpSNk5pakGKOU/uy44fo0vEewq6mhRaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zddvF6HZobjpBqtwNwx25cc590GCd7XS9cxban/eDD8=;
 b=CMdoq3g7kg+CrLw1KLoAEMjuNOjSw6DFw+Od1i5psZYEAZsks3VX2jOtxXLEZZjrRthQPH8VHqkyjLu+a+IBgwkqUuOwB74NjVYFPkArC4mj50Vsf+MlHCRkN3ooGCs+UrJatCMu67ruaHR6AQUkRyinMu9hkiPAQBq+8m2gQeHE1XtSxjAJdAICi50lKaYNW9iCPfF8ndStojH9EPi7Tb4aQxM0pfocvxfctzdEporYlofR1I5Nn+AOOiZbAUoTq3iW+vrJ2huo7awi6MfWdemBCyheHp6kIIoKk7u95hxUUQb5t3luQoTQS8GtMomKifzgF0GAOTmzxxQ6OKU5+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zddvF6HZobjpBqtwNwx25cc590GCd7XS9cxban/eDD8=;
 b=gEWCdkEAGFc8A7ho6hOKTl1QrYT/ohaQBlIuyM1tXDxF05prZ/uSxkwnTNVGnwGtdU2QKtKTVFT3hYo5kTN2D5ynmp4O3SFnO2aLLJh2tPCqg5WDrOsqB41cr13Goi2CQ1hR2jKtwGNmTnY39usyTwn4SpZlq6jsXW5R43u5bRY=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CO6PR04MB8364.namprd04.prod.outlook.com (2603:10b6:303:143::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 08:20:09 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 08:20:08 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
CC:     "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH V2 blktests 1/2] src/miniublk: add user recovery
Thread-Topic: [PATCH V2 blktests 1/2] src/miniublk: add user recovery
Thread-Index: AQHZfwGwOJGvT8DsYku0jvj8POwiKa9coHAA
Date:   Tue, 16 May 2023 08:20:08 +0000
Message-ID: <ghjrxwcxhuyekovkztjgzimz4ojw5nvay6mdszhelgcaotda4b@f6pt55ejepm2>
References: <20230505032808.356768-1-ZiyangZhang@linux.alibaba.com>
 <20230505032808.356768-2-ZiyangZhang@linux.alibaba.com>
In-Reply-To: <20230505032808.356768-2-ZiyangZhang@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|CO6PR04MB8364:EE_
x-ms-office365-filtering-correlation-id: 3c36ca5a-00de-4d9b-e386-08db55e65ca7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pl9waBS2w1WFJ9Ik9p57r83B5pJxPYikLHjl+7qpkYDdHARfUOooXY72BYQTt5gSASZH1tNAgnpBiZ5yPFyHHCaC3EM+Zaq/V8reVuZwV7yvktktRau/vUow7lSFNq0TYRcwL3FjVssLnBvJYzGgxWZxoQjO7ATTwxpzjGI3hBqqg18yEdWXTrxAj2aHZqgdM2fj0f5VPfO6b9wVAlsZhALeoKfb09HsXsnY3dgyRW5H8xeOLlabg3s/x0wDf3+UIWzQOug5Cwb5AuLcMjfn8cjM9IEOHWAmMkz6Bx4FC9NO0J+bq/NfHsfPdeh/dnMnhs1AeUKNYA4E+X/TQyAJn2Owi/+JM0tJCqKMYIwhJl1s234A3NXN1Jk3vOQlxM0ms7dtnN2G+PocGYSknTKi1d8tZ72A2pV+M7UHper7CAoFJkCCO0QPuHP7BcEPu45aKG9F2LtDSoxF8T75ZNgfm1A0sQ3qokkQWr4dywMhMCgzf6Zan5RKhT62X9PX65KlwToO0dU7y/NIn26VriaRtOULNG1UsyVGL47/Ejnc06v15llIOo0iWC+tiqyMRg+2ewEtw6Yi6UvwLTqJ0sreI9o59d7X3T5Smx1NRqO88cxwsnnYe/k28ZESGZcdGmtP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(366004)(346002)(136003)(396003)(39860400002)(376002)(451199021)(6486002)(71200400001)(83380400001)(26005)(6506007)(6512007)(9686003)(186003)(44832011)(38070700005)(5660300002)(122000001)(54906003)(33716001)(82960400001)(38100700002)(86362001)(41300700001)(91956017)(316002)(64756008)(66446008)(66476007)(66946007)(66556008)(8936002)(8676002)(76116006)(4326008)(478600001)(6916009)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AgSk7Kw6p0/mgo2K2Y1WVYPRq9FycRY+fST8ScB2F51ozHPYhubzJWL1GSn0?=
 =?us-ascii?Q?5kJs3ApLCfnffGk8gNentb+U16LYlw2733bTr8MtCvv4/kXipUohMHNh2tSX?=
 =?us-ascii?Q?MtLIwcLciWz8XR1wF1ibhnwonzUJCFlY5i5Dfh5xKmgTnZC2ILNw5tHL8DAR?=
 =?us-ascii?Q?xzu5NSySdZjdeT/2PG/TtBNXp9k6nOEa2dyhiNGVQdY+s90SyVDenZT/kQFN?=
 =?us-ascii?Q?a2cjJihNCksmw2EmJUaIKvemPJeTJeNGy1tdcMPdEUcdkpEy0cby5msugsmQ?=
 =?us-ascii?Q?tl4u7BAVK+Dv5Fvv5Q5FtNc3nN4syyvlnbNjZyNUWhsxzYjomkquCRZhxRf/?=
 =?us-ascii?Q?qmV2EXiFu2/9e2XUseCq33g7UkQ7a0SdxpDEZKVn6Eqq3vQFSMLIvuagZ+p6?=
 =?us-ascii?Q?AHGqeCoKoReHH0aS+UybCFTiIyOfbuXh2srmrKrgza9fWjmkHeDQ8XlLXMFi?=
 =?us-ascii?Q?9HjKWfdZBZkXv1BUiGUdbrefXPPmSGdt40Frf92rYif4K57qD2m/ENbrN5QH?=
 =?us-ascii?Q?6z04NsUnCXcTCUgGiraewg5vamp/JTOcYH4uk5JEwaLZBudgC8Fign61D+I8?=
 =?us-ascii?Q?pHvasY7xTtwUppyuAyeZw5pyNg+EzAt37HSCsS2nmyqUXyBKVfJw5JuiBMQa?=
 =?us-ascii?Q?rU8WRlLFtU+2I/dMEu5kBOyFJn7lemnOroTFomvSgJ4q0Z1xoqyEK+qRj426?=
 =?us-ascii?Q?BamFoV0J7YgdJDLARErkKMosAzz3bSHKOk9ugDqeYBkkAQhcv2jBwM9hmimX?=
 =?us-ascii?Q?yAYAwvKkkh7Vv8JYZN8pihAFjYE8THJUp2PETpG6tfPl8eMdiWudqt6X2W9B?=
 =?us-ascii?Q?GI7T14hRNO4WGHP+DTv6ghFhIG9Q7itTh4wabResj9oZKMEc+NpXilVwg+bg?=
 =?us-ascii?Q?epa3XtexEM/NGpv35Fe2CfP1sKfRMRKH0UeTdb2MpoUIl5QR1Qh5Jw6/INlG?=
 =?us-ascii?Q?jtYHBvvyBsPC31uIhhmXAR8m9cqPwZJ633KY16xc0Nz4Mgm/KJAKK8o7BNge?=
 =?us-ascii?Q?ws68rIQnXxDBNKcw8+WYHdm+1DaBphWJCaDkZ5NICOkLYQYPLU/IkNoJD5za?=
 =?us-ascii?Q?xuSHUkGvXggXil/DsqbMx+8Lw/YEttoIjvYKyXyIhlSfwrdYjr3L9XNvOoNR?=
 =?us-ascii?Q?xX02WJGcYng+CbN//yUdCiK6NW9HAZhLuYbPfy6Vt+thgovhfENVnsXsr5/V?=
 =?us-ascii?Q?CPUoyfdar4VAyKD7GfuAMk8OYDkKhHZYHDnVRZLpMmBLy/rmt/RZyUCws/aS?=
 =?us-ascii?Q?CHpHyz+kkyCzpbIeAyvIxJLTi91mFR9jzDfyUsCcJYCmbAaD/A4stbqUSc3c?=
 =?us-ascii?Q?LAoBTs+B3RiuCmDLGKa4nGY+m28iTI50WhSlLusfJ11WodzQSrTVvh5WY/u8?=
 =?us-ascii?Q?WJKmW+jzxLFfVkKnhJbbgWcZGJN8o6S8teY/QMLhgIOwpFGBnBUq/mGwHHJl?=
 =?us-ascii?Q?I/96OAJtH5iNLvQL018pNYgwK0FmFmP/rfuA6ITIHtAprv6IumJqb7xeedsk?=
 =?us-ascii?Q?JwSHtI4/jY0+fgueoXc8DDNWf4/3YFUE/ObKdI+3g8MW2oYYHmgFMPQNLKHa?=
 =?us-ascii?Q?D/kye5porAUPvflem2a9Pk3Lrmx5Oe5Mk1vulf6flDFI625Xq76r5ocNQl+w?=
 =?us-ascii?Q?bQWGWbgW50PBIDw5V7vxshs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3E7C570A0BA7F244A7D67856B33FF060@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 54IdwnyILa5Ajm7u0WwS5rABnsQ3kyBfYDBdVt9Ggdn2N89Q6GzEWjJ98ceBPm+hY/1SmIgRFrFQzK376W6S9DMzm4RM/xlAwGZ7k9MAAy1GjIjtPuenqw57Xja4rDu5jIiXD8qRusqY1oDLx6Ps632jrVqfqAfvNnw6qT/m04hTCbR+v6KxK2hJNW+bYnTNCnLJ+IdU8KbR3X4eZ/3Sd8Kjmrlz+XditRlBYA+oWd/uBK4rxqFcXhrIp/G638DPoK61OC/Qmtbbmt/OexuEpd1JvhKOY+J6YYZO4fV7bb+lDEgjXz6qpp/A1jusLk3R3Mrrk/6kFU6jjDoqwMJNt/nM2Tp24Jq5XufrItYRjgHyq0VRsb3hTqxiVq9WWUdqoLFcpYh/tF2MDpeGnBc27bAiYiQoZpdHVER33pl29G4PeJYWrZOP3QB/5x9DZ8gPmZ/vETQQ0zCShFUvcvW5Hl4U1jsrYXeopK9SwIQ8ggFwEUok7yPl2cZWJoqegFp1nbnI4XNTaw8p9Ug8sw8EM7Dsp+lh7o5LIrSirpS4RIWYrh24MCn9t61+ihNT4YG0L5ihaJc7FEX3LuhpoE5gapg+SRo+/iNq8oBX8y19DAs7fqbx4bcxAdBhD9lzakNbGUdYSUERAzyf3ECWG0d4xUByGKLtQA+fUEg4jVV/UhonuP3T+VJz3biTTFRQwi2Xv7gOm+gxMyXEiv1FTOOPIO+yE8MAIViL61/AgyWH4zzGxJtf3hqxwxATFfEGFrlUS+i4X5ycZg7bVEgEaDbdk4ODvDtHfpRLsu85r9v3cwnr1YL/R0ym0QT/Q35D5LnjAPhR2he8fmvJdWDBGzmdA5dV1uLvMfyDrsj9LSuyJY0=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c36ca5a-00de-4d9b-e386-08db55e65ca7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 08:20:08.8222
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rvdUspWX8LFEKdt8/gUQQ8AhkrPYsgKTMbwjZSt8d8vkR6Cgt1O2gCXMC2iCokpE/onn4HSJY2GqMpAKg5ObFBqRe/DiMcGPOtHR01d+A9Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8364
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On May 05, 2023 / 11:28, Ziyang Zhang wrote:
[...]
> +
> +	if (S_ISBLK(st.st_mode)) {
> +		if (ioctl(fd, BLKGETSIZE64, &bytes) !=3D 0)
> +			return -EBADF;
> +		if (ioctl(fd, BLKSSZGET, &bs) !=3D 0)
> +			return -1;
> +		if (ioctl(fd, BLKPBSZGET, &pbs) !=3D 0)
> +			return -1;		=09

Nit: the line above has some trailing tabs.

> +	} else if (S_ISREG(st.st_mode)) {
> +		bytes =3D st.st_size;
> +	} else {
> +		bytes =3D 0;
> +	}
> +
> +	if (fcntl(fd, F_SETFL, O_DIRECT)) {
> +		/* buffered I/O */
> +		ublk_log("%s: %s, ublk-loop fallback to buffered IO\n",
> +				__func__, strerror(errno));
> +	}
> +	else {
> +		/* direct I/O */
> +		if (p.basic.logical_bs_shift !=3D ilog2(bs)) {
> +			ublk_err("%s: logical block size should be %d, I got %d\n",
> +					__func__, 1 << p.basic.logical_bs_shift, bs);
> +			return -1;
> +		}
> +		if (p.basic.physical_bs_shift !=3D ilog2(pbs)) {
> +			ublk_err("%s: physical block size should be %d, I got %d\n",
> +					__func__, 1 << p.basic.physical_bs_shift, pbs);
> +			return -1;
> +		}
> +	}
> +=09

The line above also.

> +	if (p.basic.dev_sectors << 9 !=3D bytes) {
> +		ublk_err("%s: device size should be %lld, I got %lld\n",
> +				__func__, p.basic.dev_sectors << 9, bytes);
> +		return -1;
> +	}
> +
> +	dev->tgt.dev_size =3D bytes;
> +	dev->fds[1] =3D fd;
> +	dev->nr_fds +=3D 1;
> +
> +	return 0;
> +}
> +
>  const struct ublk_tgt_ops tgt_ops_list[] =3D {
>  	{
>  		.name =3D "null",
>  		.init_tgt =3D ublk_null_tgt_init,
>  		.queue_io =3D ublk_null_queue_io,
> +		.recover_tgt =3D ublk_null_tgt_recover,
>  	},
> =20
>  	{
> @@ -1326,6 +1562,7 @@ const struct ublk_tgt_ops tgt_ops_list[] =3D {
>  		.deinit_tgt =3D ublk_loop_tgt_deinit,
>  		.queue_io =3D ublk_loop_queue_io,
>  		.tgt_io_done =3D ublk_loop_io_done,
> +		.recover_tgt =3D ublk_loop_tgt_recover,
>  	},
>  };
> =20
> @@ -1359,6 +1596,8 @@ int main(int argc, char *argv[])
>  		ret =3D cmd_dev_list(argc, argv);
>  	else if (!strcmp(cmd, "help"))
>  		ret =3D cmd_dev_help(argc, argv);
> +	else if (!strcmp(cmd, "recover"))
> +		ret =3D cmd_dev_recover(argc, argv);
>  out:
>  	if (ret)
>  		cmd_dev_help(argc, argv);
> --=20
> 2.31.1
> =
