Return-Path: <SRS0=s14/=AM=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09085C433DF
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 12:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF43C20780
	for <linux-block@archiver.kernel.org>; Wed,  1 Jul 2020 12:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NHQeQoeG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="aYIm8CN0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbgGAM6I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 Jul 2020 08:58:08 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33503 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730271AbgGAM6H (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 Jul 2020 08:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593608285; x=1625144285;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=+NSP6oAw/fZq+MzfBYJyGjZ6TKTSRXO1FXV7tb5R5MM=;
  b=NHQeQoeGE3+4CFOCsYBPwreUnewaUwPoyHwsbHe8InZfgGUzx9AZ2jJs
   jRUH9esfVaKsiaYsz6anim0HkwP4JinkmUfn5EBMJ1PW7IsTrCTcaTiIA
   YboBi/2MvPy99jzdLb9sv6b0OaATmRuOJ4z9IexRQX/IoOk1zPsm1BKsk
   YIs/YSKVSvbLQovMqgL5Gcc8EWiJUfh8DxkYiSu7WpV//06XcPgU3edX0
   eLO58kyVy6rYY1Im7abjTXLDZirwqzfvacxzF40dmxVbdD4SCjDa8esw9
   5BBdmiug/DANn8GiiE7CW5WICV8jFAc9BdMXjClYnF0hSl1j639ZPvmkT
   w==;
IronPort-SDR: RxrBIC5qbRuWsKrPilhZW8aattTMl7PTGvQQzRSTOuFQ50gr0net6dKzSJhMIVfAPyvTxzRoir
 YWvVSGtpI/SDFBPIjOnubvrUKuUiYi4bGObQqFtuP6HDLeC9Ppj8q9iODKIcsS83etMyjWDVZg
 X7RZPommofBFk+2OuGtmQGjLKyrybXarQEICC5n9DhyJ2DtYevZIWjJT3u3Mc/QcaOOpyit4MA
 C+wXYRE/SGxuM2BQbM6gIYx8PqOq9MLNCf9GO6rJd//vAeIHNkt+lY18V2w50Uszlm79JLs+JD
 L4g=
X-IronPort-AV: E=Sophos;i="5.75,300,1589212800"; 
   d="scan'208";a="142729947"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 01 Jul 2020 20:58:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HQgkN+vh6WaGyLae9CiZTGhIE6w1ZnETHAhSQFzgj42pX6myq5rhSXnVIHxKxV0MRlAJrZdSbAJUECQp39TiAWQmz91pSKwNI9hh8VrCelaaxyQtdOliQ/w5kixuFg97PJDEW/0e+WLv9zmWVkLSAH/bVY+wEdautaJZQyCyzfE4UeRAzZ53K5l+xfOWDVTgLXNY3eZBzMZd+XXrJgpjJJkE6HyHvU0zj2NGy3F/FXfFCiK/Xf2qq4avTxSvZpn/QxqlF95XewVtnxatEvk1xdigL4jQXlI4J3xgpTi1tspnizauEiJHa1/1lifxGoBJLlvc4kCYssUa11VMx6+iTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQwNgU9nwKn16mzwrGzvkfQV66ye8zvsxSn6mz34yrc=;
 b=mW10sx4p8muizwHV24Erx2qRSJ3bvOui9141Rrh9JD2qF+tnueP7DOBhFft6kzklHS3sr+ZgF0KVc7jZbHHMkffRZstNQavoqEpf8uSTYBqTdXvZQbNSGcr3DXdjHEA/ZW3qL0AJjtP+PtbXsaIVhgPl841AgW1KyMCcwgkam+VGMENJ7rQ17Zqr+pi5FS1mLTaTtCpE/gWh7GhGs6NijfG2soUuH7i90V/TALf6FjOYBa2b/z7ppefkgb1+bieuDcOW2PQtwVDmubHKr3c/pp3ON5HKK4U9qM8fVECCsQBDHslOg7BSJNqyhBsD+EWC89s8SGRGm5d4eMzQKox8kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sQwNgU9nwKn16mzwrGzvkfQV66ye8zvsxSn6mz34yrc=;
 b=aYIm8CN0Z0MGUdtXwX3tJC8ODFL28mk9trkUtenrmBzUQk303UR0B7rx33Rpuq8TkphEmC/B2mB0uM7Ypy2DMz2xGwMK6ID6gyQdd2kMr24VsGn5GcI2EoO3lBuvAiLLo09aQYpYp3hLv+BXwtXs33vMXRuBFf61FQfCJqIy75Y=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4927.namprd04.prod.outlook.com
 (2603:10b6:805:93::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Wed, 1 Jul
 2020 12:58:02 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3131.028; Wed, 1 Jul 2020
 12:58:02 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blk-mq: streamline handling of q->mq_ops->queue_rq result
Thread-Topic: [PATCH] blk-mq: streamline handling of q->mq_ops->queue_rq
 result
Thread-Index: AQHWT5C1K2bA7yjCXUSjLNzS7f2EoQ==
Date:   Wed, 1 Jul 2020 12:58:02 +0000
Message-ID: <SN4PR0401MB359843ACC22084451B7135949B6C0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200701101617.2434985-1-ming.lei@redhat.com>
 <20200701125409.GA13335@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1515:bd01:115:56a6:c821:2683]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2b210261-0818-4999-5b64-08d81dbe639e
x-ms-traffictypediagnostic: SN6PR04MB4927:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-microsoft-antispam-prvs: <SN6PR04MB49273A3B9BC8D6EA750C4EBC9B6C0@SN6PR04MB4927.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2958;
x-forefront-prvs: 04519BA941
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 58+hJO7BuJtrf4AUG2WHdxteiwJ2Cu3ri3QzlycQugoFm2fkg0VzQweeNqA0NQsYJOkKFm1Wp8ekk2D0Hfv9VBoPGrqs0Wa1xpx1KiLS2W7SNMVxqAd4Migzc3wtvXhNZiL43KsimzPrfKQR+OuTg1A1eYWERDC52s1GuiPOhGZNXB3ibgCqVA2otT1RA4PmNxhXNOAuBcPd8JOA3EsKM/IbsnXlMJzKRZxQqjRDfBbp4JjY5i5ewAGIlT/sgKZdiTkF/akHB4iBdmWKOQa+t9qxde8YkS7G9dcetlQakSLwjNbc8F3YEISuy4A4pjA9VHDuYeSR98HlhHhoFS1w3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(136003)(366004)(396003)(39860400002)(66946007)(64756008)(33656002)(91956017)(66476007)(76116006)(316002)(55016002)(186003)(52536014)(5660300002)(86362001)(110136005)(2906002)(54906003)(8676002)(83380400001)(8936002)(53546011)(4326008)(6506007)(66556008)(71200400001)(66446008)(478600001)(9686003)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 6P2b4DUQyS72DkgSKJ0/QdARigxxVj0sGLO4+hT6QZ8dmKYQSyChKeSRRIMY7ZQnZIN+1Zabpg21FAbhc4fDuF8zqbY5elbfJflf6++Pp/XPx3GU9p8wX327RMPYbRVPIEHBQc7llAFpg5Q37hwCf9GshPdMrEdQagWBYYfrVQF+qvIUSmRW08YNGa45OG5geQ0A8X4dRJqSU9iRPXw6bKS56MipFFfkkj5eOiH/xoEsiOXv7gT5ON1wLYrk8q3TgJNrwi2gWl2or+UJGrkvOjflLyO/QDwIcgKYGtZRdf8TgCrHguyHFX1V3IjOkKRMnVIcoCl8kPzZrvj5SVeBeCOEs/4FH0dzBImuL23MlUftyleNUnvYLXy5syhjZX6rdUaM4OLh3mzztfY4xrPE7iZmNqvNvczfy4WOdim32JxtmT3aTQfbaboErngxjYjYnpEuUTwT5N6HEQ7KD8I/jUqiBAr8VddTek51myuxpVwXQqSF+ywlpuxoBfe/vQMO96g8EFQK0EBDEdh5/VrPrVP1DVcykRIgXwtThLynPpOk1u8UlMMrJLHMFga5E84j
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b210261-0818-4999-5b64-08d81dbe639e
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2020 12:58:02.3610
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wgOOtf32TEha6f6OTw4Gk6UMPp3iqUbPyGCE98Ir/bowT4ovZEv4U5ueWgfldWgVvCRuIFQgCQNf+40Re7Yddkgd064aZ+cjE4BvvWmh4vY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4927
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 01/07/2020 14:54, Christoph Hellwig wrote:=0A=
> On Wed, Jul 01, 2020 at 06:16:17PM +0800, Ming Lei wrote:=0A=
>> Current handling of q->mq_ops->queue_rq result is a bit ugly:=0A=
>>=0A=
>> - two branches which needs to 'continue' have to check if the=0A=
>> dispatch local list is empty, otherwise one bad request may=0A=
>> be retrieved via 'rq =3D list_first_entry(list, struct request, queuelis=
t);'=0A=
>>=0A=
>> - the branch of 'if (unlikely(ret !=3D BLK_STS_OK))' isn't easy=0A=
>> to follow, since it is actually one error branch.=0A=
>>=0A=
>> Streamline this handling, so the code becomes more readable, meantime=0A=
>> potential kernel oops can be avoided in case that the last request in=0A=
>> local dispatch list is failed.=0A=
> =0A=
> I don't really find that much easier to read.  If we want to clean=0A=
> this up for rea we should use a proper switch statement.  Something like=
=0A=
> this:=0A=
> =0A=
> diff --git a/block/blk-mq.c b/block/blk-mq.c=0A=
> index a9aa6d1e44cf32..f3721f274b800e 100644=0A=
> --- a/block/blk-mq.c=0A=
> +++ b/block/blk-mq.c=0A=
> @@ -1275,30 +1275,28 @@ bool blk_mq_dispatch_rq_list(struct request_queue=
 *q, struct list_head *list,=0A=
>  		}=0A=
>  =0A=
>  		ret =3D q->mq_ops->queue_rq(hctx, &bd);=0A=
> -		if (ret =3D=3D BLK_STS_RESOURCE || ret =3D=3D BLK_STS_DEV_RESOURCE) {=
=0A=
> -			blk_mq_handle_dev_resource(rq, list);=0A=
> +		switch (ret) {=0A=
> +		case BLK_STS_OK:=0A=
> +			queued++;=0A=
>  			break;=0A=
> -		} else if (ret =3D=3D BLK_STS_ZONE_RESOURCE) {=0A=
> +		case BLK_STS_RESOURCE:=0A=
> +		case BLK_STS_DEV_RESOURCE:=0A=
> +			blk_mq_handle_dev_resource(rq, list);=0A=
> +			goto out;=0A=
> +		case BLK_STS_ZONE_RESOURCE:=0A=
>  			/*=0A=
>  			 * Move the request to zone_list and keep going through=0A=
>  			 * the dispatch list to find more requests the drive can=0A=
>  			 * accept.=0A=
>  			 */=0A=
>  			blk_mq_handle_zone_resource(rq, &zone_list);=0A=
> -			if (list_empty(list))=0A=
> -				break;=0A=
> -			continue;=0A=
> -		}=0A=
> -=0A=
> -		if (unlikely(ret !=3D BLK_STS_OK)) {=0A=
> +			break;=0A=
> +		default:=0A=
>  			errors++;=0A=
>  			blk_mq_end_request(rq, BLK_STS_IOERR);=0A=
> -			continue;=0A=
>  		}=0A=
> -=0A=
> -		queued++;=0A=
>  	} while (!list_empty(list));=0A=
> -=0A=
> +out:=0A=
>  	if (!list_empty(&zone_list))=0A=
>  		list_splice_tail_init(&zone_list, list);=0A=
>  =0A=
> =0A=
=0A=
Agreed, also the presence of a switch (ret) makes it more than obvious that=
 ret=0A=
has more than one case.=0A=
