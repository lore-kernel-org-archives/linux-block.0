Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C088C433DB
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 12:12:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C2BC61A0D
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 12:12:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbhCXMMX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Mar 2021 08:12:23 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:48531 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbhCXMMW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 08:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616588007; x=1648124007;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=1hRmhCrYyL4ULYSyrfrwivu306jPVyBsOQn8BI4tq9Q=;
  b=oXA+A2fKqo1B0ZcNYZklMn1wuuk4FFuCvslnEb+7RpkBcUiNBmAYaKzu
   XUOFWhH8YMXQS57C92ZUGPIyANo73ggsGLxyjtO57ntQNZMm7xDz7Zkzr
   hGM5CV5itzOPeuP8UGW2ZJw+7w3K8jGbKhmOET0lU6CcFWWUvslJkc4cL
   jf4Dq+QMPOvC0aR6uEUWn1AUfiur6OpzKZYGTyPk/K5qvx0gGqy+mLNlb
   oRwRD0xOnNM56fGG/e/dGhq/7novWUyNaYzCbGzsXjmQGTooAaUXFFqOS
   0WnLIPbNZIwPzC5UHJ7KevTZLwpysQwtyXLAqKgSB90D+ruoeuYEi2ebp
   w==;
IronPort-SDR: ExZSyYJP6tEOaslTCHQD8YVuSUr7zIvyJLWdWUw2UZDT+cBk8WtryUe+ceq94ELpQnCLBo8Xaj
 yDUJiJFwEoagG5+Pru5mwicusoxCeqOY1s41BnWyklBmooXMgnb3WPVCfJpJuhXWqbdL+biWRJ
 /69DDPyAz/5u2DW3oND4YIvXUOzDtM0p45m+epZ/LnG9BGivoW2TzFy6+NTnRG1/gUEMf070Hb
 GGQcy08FQSG5KPE92X8/657tz5HoxB39jU+cytTcK3vqGDrBXIMSrPWpmzOsFQUAYEs/uEKb13
 N+4=
X-IronPort-AV: E=Sophos;i="5.81,274,1610380800"; 
   d="scan'208";a="267313412"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2021 20:13:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CeeBBofXAY/UaWJ8SBHyAkf4q2V6vVmUe7Gepo+eauWS1zoHXb/T+xDO+zD2FyZFdFOL05cPLH/l52iZ21WwTYPcb+WP+19OnfykicHtep8vcdexyx/AA+l+YdClgAhJynETyZBQwEJiFAoYkm7UYzekAQN5W7Z56pIpmLz5cLFtVpFes1gMVP4qA8zuGUtQZnpyroQBDvRkzqpkXLg6rzIGhQLub70QgLgL5as6AJ3jqWO6vpneE2FTeu0FtWXZVrNPkyIL6tF9mxtihzEHkk2E9y4jrxJs93KW7INGd0xZGQWRBY86nqBgG/EpPLFi8GQIUQjPc2sMP6EUyh1+mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxNjXAXSJguXT20eDjRvcnVLTuC3FmPpgKSKSXAzHDU=;
 b=HGS832eSCRfM25HZjl1fZSQaCTtH2/tMIKF8O0Yh94JME5p7ajnsNmU7Yyww2AvLZwcF9lS8sMn4ue05opzWNGeXY+Qdh3udHFIhSLfq7PRU4UjvCN95eqNIcNwVsIx4LtAdmpjagRJoeYFi7WMv1e2ossKj1gxFFj/KZH4r+y/XY7DmV3rjpJCDeDHztQnrW8bRXxN4fXqkCI/XGp4H1zfcLTLI374HyDX4rLhbonZqKl88uKwtwWLct49mV0FP0BSqUa4OzTUvX/Fv2r1ztAx+PT/iGvS84EdjFPL+V4Ge2qPeNGMXu2F/HA14AtpnMGeBHcW44rKwKoN8KVGQ1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HxNjXAXSJguXT20eDjRvcnVLTuC3FmPpgKSKSXAzHDU=;
 b=dlWpRnmAhLnvH+abixbvodYYkDjwTy8m8bNoMtqEdCE8pk+W56j9PkXrDBx1fRrBKayfBaX26PXFqYbTJHizkaqvf9p+43+ZUr5CTxAEyTgVLba6fdAZUvIqqZyZ3z6XtZj788zzs3FcxQN/ofFIVnMcfNoSFx/dL6bZrLHhV64=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7239.namprd04.prod.outlook.com (2603:10b6:510:16::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Wed, 24 Mar
 2021 12:12:19 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725%7]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 12:12:19 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] block: support zone append bvecs
Thread-Topic: [PATCH] block: support zone append bvecs
Thread-Index: AQHXH9Svt3fpY4sr0kWipTtEnnUH/A==
Date:   Wed, 24 Mar 2021 12:12:18 +0000
Message-ID: <PH0PR04MB741671DD22E7C2975514445D9B639@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <739a96e185f008c238fcf06cb22068016149ad4a.1616497531.git.johannes.thumshirn@wdc.com>
 <20210323123002.GA30758@lst.de>
 <PH0PR04MB7416CEB0FE5E8E56370A0A1D9B639@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20210324071119.GA647@lst.de>
 <PH0PR04MB7416B0F00700A4C9D951AD5C9B639@PH0PR04MB7416.namprd04.prod.outlook.com>
 <PH0PR04MB74168F2BDB61F5E951339B4F9B639@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20210324110537.GA13839@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:49ae:1f03:f20b:3ca]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5ccd7143-3b5c-4639-bf68-08d8eebe124c
x-ms-traffictypediagnostic: PH0PR04MB7239:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB72395DF4C9B53A1C7B98FC1E9B639@PH0PR04MB7239.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:525;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4Zq6g65HJlWu9k80UyZjqVoL13YECbS6n4AHZqFknY19ITiq8W2lUxhtii1Yp4awCFe3ovVEqd9cABtD5kiAo45kNoVSJntCgClcWmapvrwipfM6RaU+f85c/bKlMl3gDDdTdZiD+liv7eph6XeyXg8npAkxoQeAlePl7KT/vrPrSjGH4f9moaSOTWo6vzKd73sLjNmexfPI1HYwh5mi6ZVdLN/78c9TbVIgrq2JijCx5ixr3r4i6KyaTE2Qn/D6P2KRJPafrQ50+bqXwnLlqIs/QRAp6XGhUEgfAEnOxu734gtYr+MxQnnX7HMX0Uc+rQuMYx0u/h7Nl0tn26cCQMDW2/Kv8s+x55LSwIv6Es5cwfRDgHYEDmjO1kpimOHJHk+Tm5+9JQFtgWlZaO8DKphilU+jkhoowp9D0t1NptHuI1wgqb27tt6oIbytXWe5aKHQ2qjv8DBj+oIRVKAHDcBAYk+T+0mHIaKCOFwYZjTg4MAvDf2UAxGEN3v2ULW4HdT7+DdzkhQh0uUQu7lmg34beYM2/xTv3YPNVZAF6ApctVg8FuYRtjYI3g1OaY2HDCZEGlFXt4KbsB4lIE1RPqLnkidDA7RudxxH/wjxfxvlAq/t5i73G4F4fpaQNqDsArLrUyacoeEPjeBHHDQBlw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(5660300002)(83380400001)(8676002)(2906002)(53546011)(76116006)(33656002)(64756008)(7696005)(6506007)(91956017)(8936002)(478600001)(66476007)(66556008)(66946007)(71200400001)(66446008)(55016002)(86362001)(54906003)(6916009)(38100700001)(186003)(9686003)(4326008)(316002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?MMSx+1NkI1AKjXGrPUqM2ICI2XSD/vkFW8qHnj8NitE6RRjo0TLZM2N7h0mb?=
 =?us-ascii?Q?F3faAdhUFd7liF1Nx51p2WLrXjWFukCsuc4t5XZ+dHn4Mxbw4R6dQFV3VdGa?=
 =?us-ascii?Q?1nQoSIg/0jkqIPaxGK8nAhGo5ZQxXjHaIGJwgDGXue/tiKzt5WXPsjWsiD2u?=
 =?us-ascii?Q?liuHKKUhDkUzxnTzrhYU5i+dbN+AjdJdud7/B9WqojtWG8OdTMPiPIitgXa8?=
 =?us-ascii?Q?hKwuU9HGs0l31Ek3oQweXYk3OLUOn2qKrUzrssa/HhnUPVf3XCkNjoFMT6Zx?=
 =?us-ascii?Q?rtL11l1DvG/02lbNSui5DOJvG/UbT0mHQAZx4weCBuo6lTGV1PjDqpvMe3F3?=
 =?us-ascii?Q?iMRUXdkEYshl3wMTk8Q9dRJpN86JYE9zcP4HSt44w5GFpdBbmfFKjno1xZJ5?=
 =?us-ascii?Q?mv9XgOF7y1y7McdQPoNyHpH3/qPOJ+NpbIjoclPoaApGZiula0GstWR/6UYp?=
 =?us-ascii?Q?r6lmVNq7FK/LK4iaVqLR/LPd8ANzz443tvR2uxAAcsP0Np2KV6gWjstQHyy+?=
 =?us-ascii?Q?8eYJ/iW+gjpDEVaXSingRsA2rQIsQ2TvwknirOD8SAoT3fg02/2zP26VTSN3?=
 =?us-ascii?Q?T2RgD8efK5INIs60zhsksDTiiDkBX0LA4mk3nj+4tFzeSrMstqMWKQ8Fk6AR?=
 =?us-ascii?Q?Zs1aMqoO7qi4VxIQ2iyDSPGlK3+pxd7hPfZHX/fTBSRlHDf29pg+4uqu3CUE?=
 =?us-ascii?Q?D2KlQ3QD136b6CtJTCZkgjrnnH4Y8rZa9wN09s+LXQMUz8MCVnzy08i5dbu3?=
 =?us-ascii?Q?w+ONRf541bofK9IWOhvU4Jtl7mu2N0Xcng5ioIXK0FmhjKgVeylXxhe2wUvM?=
 =?us-ascii?Q?xSOoVsNLFBfxy0lHv/5gApeuust1pdUG22zWEOYSSxDx25zd3CM+ivdap9UU?=
 =?us-ascii?Q?98/a60NxlIGdLVg8VP4Bt2zH6k7w1SIGOCKMhw6fT4kMLyounln/cp5TJXyG?=
 =?us-ascii?Q?laR7OENnAq8+qVfJjr2L8xmUvvvPvY4HR3me07vMBiLSt/dA3WPu4V+/LOJl?=
 =?us-ascii?Q?IW48dqVk2MNpgif5s84WsaOyzSGtFwfVMspLpltCi4GtAY8aKGtn3EY+U+2I?=
 =?us-ascii?Q?KNJUIwC21BOA/uc/pqJgA7OpBuzdfb0/cPyzUqhojPrE792h2N2tFO+lVR8a?=
 =?us-ascii?Q?hI2ygPyw2pivk2n3vQInIVizEMbOURYAVCzKCa7dmygbRSCLdUz1pYf6j7ZF?=
 =?us-ascii?Q?snP/HnKcfibk81xpYykMFoX2RoDQRkOw56s2Fg+3vc5qe5/lwu3rcbhR4Nkq?=
 =?us-ascii?Q?tgshhqcIzEpcG9NHTz69IuTvA+rHpSRGUGhrhqTrvK7rJCWYVRMXf8Mj5ISc?=
 =?us-ascii?Q?ExV8B4XEMXZu6t/WyQ5y9QtRiMHHDi7q+EVxy+VJYTEx0ufiiqhDB0HfyH9m?=
 =?us-ascii?Q?ijdilousPt0+vXSi9qWw9+NnyH1w?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ccd7143-3b5c-4639-bf68-08d8eebe124c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 12:12:18.9469
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: upfHU6mgxEY4mGOMIsHRguoNqR2RaLz1hkMbHIBErkKn5/nafiYKokqt7YBVlHX3qIHIJblv4gbBhUc+oLPkZXECYhKn97RdCySqmEwggxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7239
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 24/03/2021 12:05, Christoph Hellwig wrote:=0A=
> On Wed, Mar 24, 2021 at 10:09:32AM +0000, Johannes Thumshirn wrote:=0A=
>> Stupid question, but wouldn't it be sufficient if I did (this can still =
be=0A=
>> simplified):=0A=
> =0A=
> No, this loses data if the iter is bigger than what you truncate it to.=
=0A=
> Just with your last patch you probably did not test with larger=0A=
> enough iters to be beyond the zone append limit.=0A=
=0A=
Hmm I did a fio job with bs=3D128k (and my nullblock device has 127k =0A=
zone_append_max_bytes) and verify=3Dmd5.=0A=
 =0A=
Anyhow, I like your solution more. Fio looks good (bs=3D1M this time, to be=
=0A=
sure), xfstests still pending.=0A=
=0A=
> =0A=
>> diff --git a/block/bio.c b/block/bio.c=0A=
>> index 26b7f721cda8..9c529b2db8fa 100644=0A=
>> --- a/block/bio.c=0A=
>> +++ b/block/bio.c=0A=
>> @@ -964,6 +964,16 @@ static int bio_iov_bvec_set(struct bio *bio, struct=
 iov_iter *iter)=0A=
>>         return 0;=0A=
>>  }=0A=
>>  =0A=
>> +static int bio_iov_append_bvec_set(struct bio *bio, struct iov_iter *it=
er)=0A=
>> +{=0A=
>> +       struct request_queue *q =3D bio->bi_bdev->bd_disk->queue;=0A=
>> +       unsigned int max_append =3D queue_max_zone_append_sectors(q) << =
9;=0A=
>> +=0A=
>> +       iov_iter_truncate(iter, max_append);=0A=
>> +=0A=
>> +       return bio_iov_bvec_set(bio, iter);=0A=
> =0A=
> OTOH if you copy the iter by value to a local one first and then=0A=
> make sure the original iter is advanced it should work.  We don't=0A=
> really need the iter advance for the original one, though.  Something lik=
e:=0A=
> =0A=
> diff --git a/block/bio.c b/block/bio.c=0A=
> index a1c4d2900c7a83..7d9e01580f2ab1 100644=0A=
> --- a/block/bio.c=0A=
> +++ b/block/bio.c=0A=
> @@ -949,7 +949,7 @@ void bio_release_pages(struct bio *bio, bool mark_dir=
ty)=0A=
>  }=0A=
>  EXPORT_SYMBOL_GPL(bio_release_pages);=0A=
>  =0A=
> -static int bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)=0A=
> +static void __bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)=
=0A=
>  {=0A=
>  	WARN_ON_ONCE(bio->bi_max_vecs);=0A=
>  =0A=
> @@ -959,7 +959,11 @@ static int bio_iov_bvec_set(struct bio *bio, struct =
iov_iter *iter)=0A=
>  	bio->bi_iter.bi_size =3D iter->count;=0A=
>  	bio_set_flag(bio, BIO_NO_PAGE_REF);=0A=
>  	bio_set_flag(bio, BIO_CLONED);=0A=
> +}=0A=
>  =0A=
> +static int bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)=0A=
> +{=0A=
> +	__bio_iov_bvec_set(bio, iter);=0A=
>  	iov_iter_advance(iter, iter->count);=0A=
>  	return 0;=0A=
>  }=0A=
> @@ -1019,6 +1023,17 @@ static int __bio_iov_iter_get_pages(struct bio *bi=
o, struct iov_iter *iter)=0A=
>  	return 0;=0A=
>  }=0A=
>  =0A=
> +static int bio_iov_bvec_set_append(struct bio *bio, struct iov_iter *ite=
r)=0A=
> +{=0A=
> +	struct request_queue *q =3D bio->bi_bdev->bd_disk->queue;=0A=
> +	struct iov_iter i =3D *iter;=0A=
> +=0A=
> +	iov_iter_truncate(&i, queue_max_zone_append_sectors(q) << 9);=0A=
> +	__bio_iov_bvec_set(bio, &i);=0A=
> +	iov_iter_advance(iter, i.count);=0A=
> +	return 0;=0A=
> +}=0A=
> +=0A=
>  static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *=
iter)=0A=
>  {=0A=
>  	unsigned short nr_pages =3D bio->bi_max_vecs - bio->bi_vcnt;=0A=
> @@ -1094,8 +1109,8 @@ int bio_iov_iter_get_pages(struct bio *bio, struct =
iov_iter *iter)=0A=
>  	int ret =3D 0;=0A=
>  =0A=
>  	if (iov_iter_is_bvec(iter)) {=0A=
> -		if (WARN_ON_ONCE(bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND))=0A=
> -			return -EINVAL;=0A=
> +		if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND)=0A=
> +			return bio_iov_bvec_set_append(bio, iter);=0A=
>  		return bio_iov_bvec_set(bio, iter);=0A=
>  	}=0A=
>  =0A=
> =0A=
=0A=
