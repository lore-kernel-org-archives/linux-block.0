Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56726C433DB
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 10:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20E78619BB
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 10:23:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhCXKWx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Mar 2021 06:22:53 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:22619 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbhCXKWk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 06:22:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616581360; x=1648117360;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=TnV0ExGNC8ztYWoBMNSXrHf0UaCUjBhBmTEyjR2HDtE=;
  b=rrpaNbBCgaRZfy8Zb/JdKCa0UfQUU9c+J5IzgLL8JiTIOtvDDeM6pjQ5
   Oqn+CTtiyisuvbyB0Tumi0+wqglGnTYwO+9Oov3Jmagim6tIIA2vlkr93
   oAddc7gvcttatidMdPNCAbQbQx2HtTjlAEJ6lXUoxbUcA2N/xVP3Lx3ZR
   L8EYvBuHwWQKttW2nU4Sk3W4gFrQl0TUkJWWss9Syj4QqR1/YLnJTTQhr
   QaGOah5ecUHO0U5qlVMdjftu4BLkRjIfKKW+zulZShWaQNWAhJ5KGK2G4
   zJA+PplhdOXkZhqA1wrStjIJ7bG6cmi+SoC1tEG6y+b/7eicxtXsHUAyR
   g==;
IronPort-SDR: jqpIEQ8MqvPShtcOHCOwsr2CC2ZRpogeUGsYGzi39TYDkKxbdoPm7VZXSZNO7f1M8OkuTX1/D7
 rLYnNdOW5q4QDKoJn3QOImUxARRO3wYx/+89uv65jV2+DjDN8EhcpWUp4EtzuEhKCDsiDX96pE
 GvUhrz1zi91re8vea+HzPBS+WlSmx2jXAe3TsRddZDR8/52uRX0CNygR6bRL36bpagmsmCQAJJ
 Zmf1tFiZ5sfrvQDYlb+ucha5biDFHOWdRZzpUbJksL6HPy2mgy+rHKGE48EGDaLzMTNK9rbJKF
 oa8=
X-IronPort-AV: E=Sophos;i="5.81,274,1610380800"; 
   d="scan'208";a="167363574"
Received: from mail-sn1nam04lp2053.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.53])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2021 18:22:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDBlV0F5mmWtHjQ+AxhTMhO7wHWM8a9gSDNJWjLzIYZkquHUS4J5xutp4/bGyZUCPW4mvw2hmGWqOvDtf4i45iC//RQ1vYnodSMvevaTqnGjorwVSx0CF66DpKAGE45McZ7gnaxqv/qmvvMfwu1p5BfPOgzKU0QptO9Zm9jP5qoXs57afPEgwlN21j+L8+nO7WA4teAAGDdxAKuiwDVW8k32acQxieFJZXgC5EiGO+VVMzt53a+ieCmfei2abQTv7TipeSsfpZSbDG2G8MRXH11up8I9zY4NBGYonV9nH/p64R45sQlvwwKlZKZU7pGGovg7qe4rH8RehZuAv/gRYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jt0rEEKvjT5aMKXfIyOYHAI2v9ioCg5uF3EAROzzkY=;
 b=Ms0Mwj6HR1CgVQv2dg+E0RIj3XsSL0CvNqWUHsT+t6KRTGD4XG3vQODNrqnX57d22wIr6fMj0Vooa7vLzoEvTd6e9Xn6DoLQh6LKiUwIPNWAcXqwfn2yvgDoQNNs7snK5gwCNlIH/ZemGTt6eKYhqL1F3VHEh1F/XSyd3YAhrxa8zF8WwoRODph9cKM04IBx7auGWJGP6JfXaBpb7SY7VM93Qkq+xcFc3D8oZt1rKRjHfpC3GMTpBMQYWa+draZ4dzDVnPUIBi83zJ355AiPddaurLGeSguO2nzmQFZQbLp7XPS5QdW78YfnXkWmCnX2kCjvd7jEu427LgbFFfBK/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jt0rEEKvjT5aMKXfIyOYHAI2v9ioCg5uF3EAROzzkY=;
 b=qh3uKlSwraSw2Bj+uR37CZkqGgmL9UugVsLnaH58FruNnKX1A/HZ7r5DBtWg2N/R7xUcQlTJaEd9YxPNiIkoTz/ZTljKRnK0wVBLIKvaUcnokkE22foKQrBJjJ6HdSO5Ij2iB0XMtfpFXndHxkM49/WPCFjHGwZnI6JvFHEyqaM=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4915.namprd04.prod.outlook.com (2603:10b6:208:2a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 10:22:36 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::e9c5:588:89e:6887%3]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 10:22:36 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Christoph Hellwig <hch@lst.de>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] block: support zone append bvecs
Thread-Topic: [PATCH] block: support zone append bvecs
Thread-Index: AQHXH9Svi0gC6Qs6VEO4KN+cFFH52w==
Date:   Wed, 24 Mar 2021 10:22:36 +0000
Message-ID: <BL0PR04MB6514B3E696F12787EC596FC7E7639@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <739a96e185f008c238fcf06cb22068016149ad4a.1616497531.git.johannes.thumshirn@wdc.com>
 <20210323123002.GA30758@lst.de>
 <PH0PR04MB7416CEB0FE5E8E56370A0A1D9B639@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20210324071119.GA647@lst.de>
 <PH0PR04MB7416B0F00700A4C9D951AD5C9B639@PH0PR04MB7416.namprd04.prod.outlook.com>
 <PH0PR04MB74168F2BDB61F5E951339B4F9B639@PH0PR04MB7416.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:fd75:82bb:e935:ed65]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7840c165-ac38-42fb-47fd-08d8eeaebe9e
x-ms-traffictypediagnostic: BL0PR04MB4915:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB4915E31829E2FDD292FC128CE7639@BL0PR04MB4915.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:612;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R8qlGG3z9y8DODAXYLg5Zx3WTgpJ7w4r9myZ1nXH9ZAPdS6eiAA4pY1JV6QEO3u0Ktn7DGvWuTCGGWkTqI7i5tYf2+yiPwlN8kcHXT+mCaWpupO8qURnS3ECHRZMYYFZnOIvo53h2lxdkNMZ3HpnyVgUFk3nI+EiJYoD8jo9Z7FbN+cJYEt/7r3eezjydsniWw6zsJAGXwyl1jJGojLV53QfVme1IBdD7RlN3UdcOPIWWSoJpb3BMsSpLBxVKZMIGoFoMsLqBRAsZxk6odxOjKASmnF9WpC/DYMua+LESnntzdRlTJgiaTeeciWCOZg8CpK9fJPlcbpOsGtoBeQrN5aQkFi8j6KFJkIwn5byt4iWOIVR6FhtN6vsypGfziZxb8O3gDJM9dkTQ/lniqjrmNLEQIS9c7lOtwyVAmAbsvwtJHV+iAr6bipBMDQ2NpP/hGEY8Hb8Mk6ioed5SFyNBOFbE5rdQooLCl3DMiDN6FTeXT7P4iRYO3xeOkCoGBrRLbN9lfpvJfkPMM4WgMsaR1HQpByjZI8sV4WZkFQ56nxsYisyP63CtzQeqJgaxdgxPUEOJGGIUsZei7thyPOLc1eXy5nFYdH3Lq49ZmLBUujHznqswxGfijzfeFLHk4RBLGJYlSfQ1QH5oDEeaDJIhA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(186003)(53546011)(33656002)(8676002)(7696005)(9686003)(6506007)(66476007)(66556008)(2906002)(8936002)(38100700001)(64756008)(4326008)(52536014)(478600001)(83380400001)(91956017)(66446008)(66946007)(110136005)(76116006)(5660300002)(55016002)(54906003)(86362001)(71200400001)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?RncrcItKxdcY5nggp2PHagFkJUTXNycMCNZIEc6tNsVELMX98u30m5ntFrO5?=
 =?us-ascii?Q?4c5sjyjr0k566D2kZ2p7Vt8EE2+Cvlz2tm3gHsU2NFWSB2lWtnTt8rjUlxjd?=
 =?us-ascii?Q?wy3YDBX0wxBKc0i3NKLvUaI8TUbUC5zIaUvSEYCouDBWRwP8M4WhZHrsbOJ9?=
 =?us-ascii?Q?h+ZTQyE7AshivpeR8KMNnwoIGp6tI6wkhE0jMGOyBeZ4FW6X/tzAPLC6oVgQ?=
 =?us-ascii?Q?oYpSeWkCA9+b/kcyeKVnJWW0Ke53DMbdxlJFlmRLLIsJaQbQmMEczgYn3eH6?=
 =?us-ascii?Q?BdisNuNjxifY6QPrbsqlLH+J1A4QJGBeGl5bBGHalDjqk7+uUo+lT4+3vQRr?=
 =?us-ascii?Q?7kmKT10z687Iprl1AALq8OAxiLDibpbuktxAdzxlm1A5t3mOKnwZPtruY3tp?=
 =?us-ascii?Q?T+HKnAR5m04s+pZB5Kw3rtmGItcVyBpN8NvX3c7HkN+wROThxGSx1NHFTr4O?=
 =?us-ascii?Q?CBwEM6+3y0QxtCRj+sXjDV1A3wUuaJI6tYwvsM8lgznXV6Fr9wIYvx8lVOOu?=
 =?us-ascii?Q?2cVtw91ISzQhmRwyX+fnjWgz2gcJOLbMGyGQIdUo2kkihZ3LnsdKW9a6Fk8h?=
 =?us-ascii?Q?VTpOEJypi9YNzQbFZ/UZA9kFQBypdVCVIwHGkkMd4N2AdGsKKnU1ihQxyNoh?=
 =?us-ascii?Q?pHG8HFq6kavdctig5u47HXPwJgeJgiHeK71tHXmKcxqd7cOdDQgO6ASf6s9J?=
 =?us-ascii?Q?vzoSR/jKNktGoa1X+l0C+J/a/LzHwaqrvipzwIhDbnHxkvBeCZObpArQ2WLa?=
 =?us-ascii?Q?eweJJAE9U8CcCyCaQHz9Qstk/q2JKZJ5RPJagXnLsayW5VrFD+fcZT+u0/sz?=
 =?us-ascii?Q?luIQJXW1nwDi7D+RgG8wxZwY9nuy1bW+lkLCT04EmLImsJCXGHAnMrXNVs1Y?=
 =?us-ascii?Q?0pRmbbRqxXP5ZJXx47Qk2Hv5q6Fiq0G61eGy7Fx/x3/MLE4wTvU0qCrhqh7O?=
 =?us-ascii?Q?al2dkL3nStz9wVD3wzEZ9+StINzjGxAo05cDoVksYL5CKOj6Z4KvR8DjGVIo?=
 =?us-ascii?Q?fjL4pdiM82KUzVWStwYqFE0052VJewB0a4kDFV1oYs08bW5zJ2gquBBmeOW8?=
 =?us-ascii?Q?IR6dMk2Z+xNW9g8VrddQHX5dBDuTGNtCybCk4aQW3juT5hLR9yFAi8PkHyic?=
 =?us-ascii?Q?1NVViEDzBI1USsT5rA2azbURWZgklGk8IpRvTvNeAr19zf499hulakqMSWMu?=
 =?us-ascii?Q?qJGkpapyov1cBOGBKUKkhSII60EBfYFVY10nOuI6FpNynlB+6GpbdcFs+kBv?=
 =?us-ascii?Q?NE9wsZUk9LZkwiHIVinF/jcAdXGrDykVFRzUNSdMKzwupV6s5EhoofeoSD+4?=
 =?us-ascii?Q?PjahlZ8OEdOEcHEUUv2MvupUW0DjfO0EHQWVtJaRO/Isy6POKB4GfU9k+Fkw?=
 =?us-ascii?Q?nNeISO2Vnlf+gW6BX3mx6OEusPqtubtUaWYW2Z2jNL2kiBR8Qw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7840c165-ac38-42fb-47fd-08d8eeaebe9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 10:22:36.1544
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fdPm0/wd6L4HBWnwf2thGx54HQXfs36qnz48PEuYBSJivcRiv/izqe/DmUnAnu247d1QMeobosxuCcSja7soGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4915
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/03/24 19:09, Johannes Thumshirn wrote:=0A=
> On 24/03/2021 08:13, Johannes Thumshirn wrote:=0A=
>> On 24/03/2021 08:11, Christoph Hellwig wrote:=0A=
>>> On Wed, Mar 24, 2021 at 07:07:27AM +0000, Johannes Thumshirn wrote:=0A=
>>>>>>  	if (iov_iter_is_bvec(iter)) {=0A=
>>>>>> -		if (WARN_ON_ONCE(bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND))=0A=
>>>>>> -			return -EINVAL;=0A=
>>>>>> +		if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND) {=0A=
>>>>>> +			struct request_queue *q =3D bio->bi_bdev->bd_disk->queue;=0A=
>>>>>> +			unsigned int max_append =3D=0A=
>>>>>> +				queue_max_zone_append_sectors(q) << 9;=0A=
>>>>>> +=0A=
>>>>>> +			if (WARN_ON_ONCE(iter->count > max_append))=0A=
>>>>>> +				return -EINVAL;=0A=
>>>>>> +		}=0A=
>>>>>=0A=
>>>>> That is not correct.  bio_iov_iter_get_pages just fills the bio as fa=
r=0A=
>>>>> as we can, and then returns 0 for the next call to continue.  Basical=
ly=0A=
>>>>> what you want here is a partial version of bio_iov_bvec_set.=0A=
>>>>>=0A=
>>>>=0A=
>>>> Isn't that what I did? The above is checking if we have REQ_OP_ZONE_AP=
PEND and=0A=
>>>> then returns EINVAL if iter->count is bigger than queue_max_zone_appen=
d_sectors().=0A=
>>>> If the check doesn't fail, its going to call bio_iov_bvec_set().=0A=
>>>=0A=
>>> And that is the problem.  It should not fail, the payload is decoupled=
=0A=
>>> from the max_append size.=0A=
>>>=0A=
>>> Doing the proper thing is not too hard as described above - make sure=
=0A=
>>> the bi_iter points to only the chunk of iter passed in that fits, and=
=0A=
>>> only advance the passed in iter by that amount.=0A=
>>>=0A=
>>=0A=
>> Ah got it now,=0A=
>> thanks=0A=
>>=0A=
> =0A=
> Stupid question, but wouldn't it be sufficient if I did (this can still b=
e=0A=
> simplified):=0A=
> =0A=
> diff --git a/block/bio.c b/block/bio.c=0A=
> index 26b7f721cda8..9c529b2db8fa 100644=0A=
> --- a/block/bio.c=0A=
> +++ b/block/bio.c=0A=
> @@ -964,6 +964,16 @@ static int bio_iov_bvec_set(struct bio *bio, struct =
iov_iter *iter)=0A=
>         return 0;=0A=
>  }=0A=
>  =0A=
> +static int bio_iov_append_bvec_set(struct bio *bio, struct iov_iter *ite=
r)=0A=
> +{=0A=
> +       struct request_queue *q =3D bio->bi_bdev->bd_disk->queue;=0A=
> +       unsigned int max_append =3D queue_max_zone_append_sectors(q) << 9=
;=0A=
> +=0A=
> +       iov_iter_truncate(iter, max_append);=0A=
=0A=
Why truncate ? the caller of bio_iov_iter_get_pages() will see a shorter it=
er=0A=
after this return and will not loop over to send the remaining.=0A=
=0A=
I think you need a special bio_iov_bvec_set() or you need to patch it so th=
at=0A=
the bio size is at most max_append instead of iter->count. Same for the seg=
ments=0A=
count: the bio must be set with the number of segments up to max_append ins=
tead=0A=
of iter->nr_segs.=0A=
=0A=
Then you can do:=0A=
=0A=
iov_iter_advance(iter, max_append);=0A=
=0A=
before returning, like bio_iov_bvec_set() does. No ?=0A=
=0A=
> +=0A=
> +       return bio_iov_bvec_set(bio, iter);=0A=
> +}=0A=
> +=0A=
>  #define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) / sizeof(struct p=
age *))=0A=
>  =0A=
>  /**=0A=
> @@ -1094,8 +1104,8 @@ int bio_iov_iter_get_pages(struct bio *bio, struct =
iov_iter *iter)=0A=
>         int ret =3D 0;=0A=
>  =0A=
>         if (iov_iter_is_bvec(iter)) {=0A=
> -               if (WARN_ON_ONCE(bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND))=
=0A=
> -                       return -EINVAL;=0A=
> +               if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND)=0A=
> +                       return bio_iov_append_bvec_set(bio, iter);=0A=
>                 return bio_iov_bvec_set(bio, iter);=0A=
>         }=0A=
> =0A=
> The above had a successful xfstests run and several fio --ioengine=3Dspli=
ce runs.=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
