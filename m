Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D98FC4708E
	for <linux-block@archiver.kernel.org>; Tue,  3 Jan 2023 08:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233081AbjACIGA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Jan 2023 03:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjACIF7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Jan 2023 03:05:59 -0500
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA3E2A5;
        Tue,  3 Jan 2023 00:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1672733158; x=1704269158;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=CiLH5y85lMjS/oy5PrT2JXg2fnQA4syc97aBjKMPWHc=;
  b=CSWyvPDKJ+DvSzW5NQq9QoNfYK+zQZRwx6LsPOsZC8HYOnOqHCPNbOf9
   mP5UI3E+r9mN4omzZLPSEKAANbdW/Wz9JhpR39vpvmNEDxehGlrj/Lqpg
   4boI94BDEdSip+kO7LZFv6HYvIKIBEtyQ4B2bd8lW1GQuqdcRNyXNXWkD
   exxfTDLErDHZvuxIGeAY/4vKm48ZaxTyuD05j3f6Ek+fIiOxbzNm8okfV
   qt5LydocIMOVAzBqiJOP+PzpcTBQsrDyzD5NLj75HUb3TIEuTmjAyWTRW
   ylevGRgll3LoMTmj5YZYbkGiL2hZVdb6ZPDJGPh+7dha+fqzobqfsXasT
   A==;
X-IronPort-AV: E=Sophos;i="5.96,296,1665417600"; 
   d="scan'208";a="219802830"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 03 Jan 2023 16:05:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=biGGoEbuAdeEo+pUkjqQuesO8WcKzguAiufc/StdaBrTEojeUERxUbHGYzS3tr2nTQ6BTZhA7997w6x8wABYKI6is/iF0mzR+4Kcjkc3NXlEi+eV+MOW46mVPq0igZ9hNU2Z1eu/y4WpxI4KLJPv3AHE8L9YEk3eD2fEto1QGme3IXyuJ7A/TNz+svf0WoAJGs64xXuKohkMCPmNL4EAJetbgiTbb3bVx5OJo9j7v6xf/2irtVp9poGPoQcd4hOqTg+qjhWm1CaxynD1SwSmCKcXFE+IjLMCEncbosg6LKPVqD+FMLasr9xy26mMR3pDMaxFRzqSgM6ef46g0HYODg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVD9wOcl/8+iAeQ+pU8CCVu+4lLJ0piRVzienO9PX3s=;
 b=W3cKvJYXLL1roDO/UKDxU8lz0dceH2aTX7iqnlFgW2zoRZSlvAqGm5BCD/xokVeb8MTW3kTCoLfxkykx27DfHNDwIMV4Y3JFZenDG6sMIKddjOHf/coLqbe7Sh359oS0R5EWNNDuFTIhxLQ2hvSOSOAoAqRYPninVdr8ZgGcrcm/lsTlewx6jGfUF2tOEZJgTEu+cDU5Tul6aB3qJag/DuqnDcsxbcxsCNrr0x58PxLnzy4t6fUtZbii2cWSTTOqoIccybBNgcVLwLCAZE8qo0mpz/enPdI3h0PRVdYBOqQieJtFfO/83eDXBuz3kHjmLGbeKDkv9qKrMhpiOsD1jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVD9wOcl/8+iAeQ+pU8CCVu+4lLJ0piRVzienO9PX3s=;
 b=amefihVmemOqyrADtuBt5Tsvv5baH84sYiYI1empN6ZveZZ4iAqifa7FUqsgFGWQhGeWdANBV0sCXJ+nPtukUfNMfR9keqBlfQR3sQexCPEJfegVGMqI6G+38z1SWKV59riwcN7YJC6nwaKxup653GXd7zap20q8Hg1GRZdWfW8=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by BY5PR04MB7074.namprd04.prod.outlook.com (2603:10b6:a03:22f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.19; Tue, 3 Jan
 2023 08:05:54 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::a65a:f2ad:4c7b:3164%4]) with mapi id 15.20.5944.018; Tue, 3 Jan 2023
 08:05:54 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
        Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 1/7] block: add a sanity check for non-write flush/fua
 bios
Thread-Topic: [PATCH v7 1/7] block: add a sanity check for non-write flush/fua
 bios
Thread-Index: AQHZHzL6SgMkiLYtRkCPdJaLJwZx8q6MVeIA
Date:   Tue, 3 Jan 2023 08:05:54 +0000
Message-ID: <Y7PhyHWFL/tz6bn0@x1-carbon>
References: <20230103051924.233796-1-damien.lemoal@opensource.wdc.com>
 <20230103051924.233796-2-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20230103051924.233796-2-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|BY5PR04MB7074:EE_
x-ms-office365-filtering-correlation-id: 52d25b82-5986-479a-6a16-08daed615644
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DDSEi3wWurLvuJJ5bVOOtqF18YZ/yb0TnjIF/UgsQIzs5p1dvd1doxMZSOaLQsylZqQpGoB/Z4K926lap0bIl53CzlkFdpt5MqMRDiFjMfgBthqkJpJ2RQeMFvw0ZE18PIxfR/7See7wi4kZ/514VWbg3fe4dZ2VAPVHFirBCCdfhcdbQtzMABjRC425rDdJ6r7xkM0Fw8wOmK+Wkm0vo29nws7R8B3u+NIILNhxVWUMAZBS9AwgZI4+/1BGyStvpCStYZVlTthrvufWcAVBx9UE5qBNIXLGAoPmToYS5j9dpl2FfRd2eolrSAoAarx7aJkTvRS7Tw8SwN/u3+Cj/i7VZiOhw95D8Ni8erQE4Q0WjStLGtjbmNGL7BPXFDGgjjuwypMG2e7IhD2VnBklJi0lY981K1FB/Un/Dra9J1/qi6ZdtPRd/CYy2M7QdJElvmqALruV1o+8yMsPUCw50TTBJDhA5GPIl6OSABuPeBKy/hpsGwCD7Rm0les14hfjfBkGyhQFwQZ8tqkxJSpiMV2oc0ZgDBOvGColMMM9rG0quVT8BsYoCLcTvjd42ggXvreaqRXBa2M1JUZKU/qfwc8oCl50yQfK9adJ0zfuUbA0/uI0xE8hsiK7Uq0PcrXBQStbbcjSvQQKUP33zOs0TQi1xY+t8bkmyVDsAy8ny965juKEDGapX7H+rJYC8TnLxjMrRlMMHDxUnRkM09dn+ZykjP6FUTdl7jnqitA0scc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(4636009)(366004)(136003)(39860400002)(376002)(346002)(396003)(451199015)(186003)(9686003)(6512007)(26005)(38100700002)(38070700005)(82960400001)(83380400001)(86362001)(33716001)(122000001)(64756008)(6862004)(316002)(41300700001)(8936002)(66946007)(91956017)(5660300002)(4326008)(8676002)(66446008)(66476007)(66556008)(76116006)(478600001)(6506007)(6486002)(54906003)(71200400001)(2906002)(22166006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Lx0YMWG7+CFphy/DUMYg9y7XAd7ituYjhEofn5WBEE4HtqdjTT7sJbi7FX2K?=
 =?us-ascii?Q?FM8uTDC6e/NcLzLk4GN2shGM+rVVLIBdtmfpx0yNOy1x9PhwHXP6GtGXXsIP?=
 =?us-ascii?Q?S+6r+Nus8rZ/jTPOwhkEj1Th8xJQnLm6KDh4Yr6GZhx0s+m+cKLnj0KXFzoW?=
 =?us-ascii?Q?ETxDGeJ+C3pyRdy0pwJkPm0skX25Ycjn4ygDv36rf0aoYalauwSps5Q2VF9q?=
 =?us-ascii?Q?+oIw9wj1YhJ5gE5eVgNvKlis7fTnZtTowpShAN7sclBigq/uJZOrxrKqX3tY?=
 =?us-ascii?Q?Ylk8aUbjvggkx8ZBwpdWFQprTtgeHA/KKj1M81K3FUKWSu1gTJDI4II32GJT?=
 =?us-ascii?Q?+O9bWKPlw7Uoe+o42PztbVJolJi9RQnX7i8p42lfXvmNi8YMigCoPs7xhjP3?=
 =?us-ascii?Q?aR8pG6EYPWcL2B+5X4SwrULNeO1JvUvwIaGxQsuLjQBsEmWBQIAuvvwHxXpL?=
 =?us-ascii?Q?70NMwPNUS7dr1+AblvctWYKcfLaJ2vLkRiDWMl813YeWYaCuiTDfkZz1y1lW?=
 =?us-ascii?Q?wiDA/yFHeNj5z1yyLnLd51gd5QjiDKvJDRXtypFho9Ik3KWTY5T2xbdMLyEJ?=
 =?us-ascii?Q?BLDtl4FUQuIzdpaHNsgcWyRrOv9VT4izizFgkLRrpeNcGepNIFvKGA1A2lQ8?=
 =?us-ascii?Q?d6QEeyrBycMzCwCZO4r+rFhW5n7lL9N2uUdkk/8uSbHeWRzVsGI7Kg4FmTas?=
 =?us-ascii?Q?o8Lo6WEosuEPk1TJCdnbunfRgsE0MWxi7ACvhBOFVq8rM9dZ2fYq/KBwenDo?=
 =?us-ascii?Q?7nTpoqs9qG13gBKk+Wea2YnYbzLE1+rCjseDvPOUy5r7Blc94pX6m9+ZLKYy?=
 =?us-ascii?Q?a8zyBFy8mydFMgaoEkXb4MRLY0HNfUx39sZl/Kx1WRNn/Rs85PAI3ZYqU0v4?=
 =?us-ascii?Q?VtFJjXEGFXTUakR1lKWOEkBE82wwr0nAgqIChpTq8ywHpCg+ZFBtCKgz3xV/?=
 =?us-ascii?Q?gVX+LFhQTNthxMbLHmckRG12ThrG6J9atmiWPz5Tos6YPfOmS5hPs+afEkK9?=
 =?us-ascii?Q?iEUljO5nwY022kC5fs1VWDaxORSDQjE91N+30aY8dvXg5rzrEGtuRKu8WGvK?=
 =?us-ascii?Q?oOA4NUMgFOvbk7l2HcyuEcRB7lM1Vkhhj8JxTWraEwoKjYZX1YjufdbZLgNs?=
 =?us-ascii?Q?KLMFnvhO7mgMNIkb2UHwZ0Ix8FmJWTryPIaulCzXDPUAnpjx520khb7KStVB?=
 =?us-ascii?Q?GYCLHMOsXt8KmZ42yFlPMLdWe4wCWON99NoAgWO6Z0GLN0+jePbMrk+1QPdo?=
 =?us-ascii?Q?i5+cMy89tOCGqhzIh6O+FFaeHR0VyuyPMSB+iYu7ebWwy3GaH+OLM8oLHosm?=
 =?us-ascii?Q?AgAiNQV48sZEZaM5iVKauVcZb4ZtIFKdmgIleV6RXle2nksmXyZ0NJdF6m3R?=
 =?us-ascii?Q?cMMrlOSyNmoO7+sRV44MAnoK70UpDD6XHQv6TH3oNwpoz06H+RFrW90S4IVD?=
 =?us-ascii?Q?CMTGd1h+CKk2cV0XbUJb8DMNTufpTWtKdOHhfJHffXCH2atgFGMwdf6TeaXf?=
 =?us-ascii?Q?oCfy0EKrJpJSar4ozFCjPY95TlWyGUOfmPH5OvALUD0PEgz3KEKoHQvvT+YV?=
 =?us-ascii?Q?uBi92yY7HM+j3qxRgd8hiacaqeNF4fY/PRWdEYcgk2BNFqUpFO3ikC3vXvar?=
 =?us-ascii?Q?+w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CFB080A0625AE04CB2D11137E1BC2B59@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52d25b82-5986-479a-6a16-08daed615644
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jan 2023 08:05:54.0968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yJPfpfw7tnGnQXwkcwr0r4DaDmEvmszGuLf3SZG0h2e3xUA36e4/FehEv1U1tfhDKwelaPZrtRxVzwWT/UZqkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7074
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jan 03, 2023 at 02:19:18PM +0900, Damien Le Moal wrote:
> From: Christoph Hellwig <hch@infradead.org>
>
> Check that the PREFUSH and FUA flags are only set on write bios,
> given that the flush state machine expects that.
>
> [Damien] The check is also extended to REQ_OP_ZONE_APPEND operations as
> these are data write operations used by btrfs and zonefs and may also
> have the REQ_FUA bit set.
>
> Reported-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> ---
>  block/blk-core.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 9321767470dc..c644aac498ef 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -744,12 +744,16 @@ void submit_bio_noacct(struct bio *bio)
>	 * Filter flush bio's early so that bio based drivers without flush
>	 * support don't have to worry about them.
>	 */
> -	if (op_is_flush(bio->bi_opf) &&
> -	    !test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
> -		bio->bi_opf &=3D ~(REQ_PREFLUSH | REQ_FUA);
> -		if (!bio_sectors(bio)) {
> -			status =3D BLK_STS_OK;
> +	if (op_is_flush(bio->bi_opf)) {
> +		if (WARN_ON_ONCE(bio_op(bio) !=3D REQ_OP_WRITE &&
> +				 bio_op(bio) !=3D REQ_OP_ZONE_APPEND))
>			goto end_io;
> +		if (!test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
> +			bio->bi_opf &=3D ~(REQ_PREFLUSH | REQ_FUA);
> +			if (!bio_sectors(bio)) {
> +				status =3D BLK_STS_OK;
> +				goto end_io;
> +			}
>		}
>	}

Hello Damien,

In a previous email I wrote:

> It seems that you can have flag WC set, without having flag FUA set.
>
> So should perhaps the line:
>
>> +             if (!test_bit(QUEUE_FLAG_WC, &q->queue_flags)) {
>
> instead be:
>
> if (!test_bit(QUEUE_FLAG_FUA, &q->queue_flags)) {

You replied with:
"Need both. If there is no write cache or write cache is off, FUA is
implied and is useless."

Did you change your mind since then?


Kind regards,
Niklas=
