Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A261CC433E1
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 10:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73F0761A0D
	for <linux-block@archiver.kernel.org>; Wed, 24 Mar 2021 10:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236320AbhCXKJ7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Mar 2021 06:09:59 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:36877 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236351AbhCXKJe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 06:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1616580574; x=1648116574;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=p0FTfnpDhDuRiVPBh2JlMsxr7fBvZC3/zpCvelU8NOc=;
  b=aixovudUnisGWxOYSVDo7FNoG1ae/swQoV0pAV/42/p4G8xCu854skOk
   siazW/8A39QK+DlSamNZ7uQ7trJ5uq22i9FZ5Yb78H2YzTeMoKfSDzzXh
   S3xK0CpIPibknyKG9EtE3Y1w2WgXfvXAzwL8mBIX0hZM9NdE6dolAmb0U
   8dWMJI73QcIGVYYoHNLY/t+lOammE7s10V3XYaVIti2DxwcEKFZQZpiaP
   8UgJEe66BpkTcjmLMomsXQJqiE2e0jIv5sySSOs8PRCUOAEu6kzx+cfW6
   M/BODksdqjYHrn95EE69hUg3M7H+4q2PrMz37xB8weqGGr4jhVHRkiGwz
   A==;
IronPort-SDR: nVnHsf/VLNhhOsw8aZsfknKqorqrsw98wPLqE1bbOM3bQXpEAculpqGu39urY26DV7SpzsYE2a
 IanfrXe7FTJTwzVgc8fVsDxyo4Z1cei0W8DK2lGnWKvrOEaQfb5+9l+JUzljTA6Nvp8CHdhnyq
 Ctc2pQ8caWZbO+QmVF5T+X6Pkc46Af7U00rgJ8ML7kQR5wNSx4M9XnVvMI+1N3n5E9T1dG+zI/
 1KfHDz+4u1oVCvpDDN7Re//e/n5A2vuKeJbLFlaRrN6WvSytsoJpGcKaTkqqAf3IozWhgilRST
 nBg=
X-IronPort-AV: E=Sophos;i="5.81,274,1610380800"; 
   d="scan'208";a="167362928"
Received: from mail-co1nam04lp2055.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.55])
  by ob1.hgst.iphmx.com with ESMTP; 24 Mar 2021 18:09:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hh0OsXtFgKfDbJ7/NzTCkonRUyZ1drjSj2dD3ZvTlyFjUL6WN2VXWJ+RnrwTQaxgTjZ5MPnkzfsP9ilfx/cH/l6c4U6EydBpWPCborBJgxkHpveELRym7IVK9uHIhUI1/L3cy/gemTyQ1Lbj8o6C00N1VI6eyGyuvBYn6efEipn5Nrjk3JJKOUYuZDUxUPpVQwiJ8tQRJPMgDuTJdfrWQ5zHJyojOstmwsDldPWJIFp9ZCHzy67mShmtUSyy551Ey/eJ5KZhaWTrQfYXjMeFL/UmxOKABJuEAD72H9boW27Nwteljb1sTyF1gocqMhSUWOeuhl5ek/PaF9s10O1E9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3rGAP7eW41/MU5RsPqtTPGdzQDhEMIYFUse9POptMQ=;
 b=OHzqAf85kLIncUVmxe+4UHnjK/GmK4+QtcAb3FWdkLEoAdnErypBZZPO3O6acldoh8ShHF9AgfB4HhXJcRWiWJW0Iz5acz0Oh4xniM5bYQ8wFJgjLFM9/+nZXm+6GqD30eZC2KMJb1hXfey7Nez4i02jFoIpdsqxoQoF9LX0gkyTnSmdysG4Kt/bCQdwCXgatw2AE0cYwgyPEh/Ue7QXZ/iWpza+ia1VcybxTEppdSTQ1w7dVNKS28fNtNYb9Gofgfhwytv3cJ+nMnQQdK89xGJyZjBhevKq+h5uSj5CSNdM3KZ//HzmOR4w4tZG3BAO3//glWBE2Ks2zLIg1eax0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C3rGAP7eW41/MU5RsPqtTPGdzQDhEMIYFUse9POptMQ=;
 b=joHkaF+fXkkOphnodRc3zgMKb0MXNyO/FMp7kxY+iD0zCEDACTTq8FSnkoHpwk8sFDfEs0SADo5oYWKXDfC9gPdlDZ7Wt/Pu1Ds+r9WVT94j6GMfIsAIE+pqJ/6hPE7gXOgSPB+LeP39+MyUHiStQqAOAGpx1rUjajuecnTmGjc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7142.namprd04.prod.outlook.com (2603:10b6:510:c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Wed, 24 Mar
 2021 10:09:32 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725%7]) with mapi id 15.20.3955.027; Wed, 24 Mar 2021
 10:09:32 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH] block: support zone append bvecs
Thread-Topic: [PATCH] block: support zone append bvecs
Thread-Index: AQHXH9Svt3fpY4sr0kWipTtEnnUH/A==
Date:   Wed, 24 Mar 2021 10:09:32 +0000
Message-ID: <PH0PR04MB74168F2BDB61F5E951339B4F9B639@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <739a96e185f008c238fcf06cb22068016149ad4a.1616497531.git.johannes.thumshirn@wdc.com>
 <20210323123002.GA30758@lst.de>
 <PH0PR04MB7416CEB0FE5E8E56370A0A1D9B639@PH0PR04MB7416.namprd04.prod.outlook.com>
 <20210324071119.GA647@lst.de>
 <PH0PR04MB7416B0F00700A4C9D951AD5C9B639@PH0PR04MB7416.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:49ae:1f03:f20b:3ca]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7f3b75b6-5fff-4999-100a-08d8eeaceb95
x-ms-traffictypediagnostic: PH0PR04MB7142:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB714285F08A5E923FF9CA51DE9B639@PH0PR04MB7142.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:612;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4qN8vJ2Z/9QpNuu6QqeeS2eonOmUdbosD+fsPS1iqNaONx/9nJvEzoAFKsn8terZNcb5LZNoTKnI9UAr2sLczL7EINqvImfni19KoFwpWbJdUwdtHHFzuTiAX0vaUxWiiq9gGEP5g+P9jjl1FZfWpomzAArEmlmrCKMx+0Hrt6mwwXZYuDLfw/a8uLRVPx7jN/qOSS2TAwpVoxpgQ23R+ZD/VNWkTwwIm0mTL9K5hRD7mVCCT1qwOlJrSOXIchSVIvvXnAmEsnDY2rTrNmuBu9LiBWIlVhfzRmLcsOnrkdiNTkvZqMAY7bMerb2+bT/WORcutP916pTOBCrO5+iJJgiG/SaBpkkjYJC8+ApldNWmtdDMdRCzK/4Iq8kmaHQ8rJPjohggME4NsF8cjXrBuCmghWiTVcfS8CPzjOrI8JoFs/gdy5es/N0d0mIyGcxDjjfjgC/b+z2RJiOW9dL6iBDE+BCMwQh3SiXltCyitjLseE+2W5S0VSnrxsp+tdsBAwKsRYVWWEgCrmf2iNqTlK2ERDz1a2RMvKDjYbfG8EIFGn0Z2Rrq5mfS3U1YM5lJxpgQyYXvsryrcQN+I/7zB+Yp1l0W9g54Dfwj+223aSSsoM74cCDunq03sCbu66+Eo969CBge7yFrjVGKd5VJLQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(346002)(39860400002)(396003)(136003)(478600001)(7696005)(53546011)(6506007)(54906003)(186003)(4326008)(316002)(2906002)(55016002)(6916009)(71200400001)(9686003)(66946007)(33656002)(76116006)(66446008)(64756008)(66556008)(86362001)(66476007)(52536014)(5660300002)(83380400001)(8676002)(38100700001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?8yAEN4NlgWTz4ViCX1JCbFJdnnNE2+D5BFUapI0E9lSUUSQIljIHJTJEatj5?=
 =?us-ascii?Q?FBZNBsTfe8XaXsvSN/Ko/X3H3jFlEOV+ccoQX5bvm4CSDj3nIQdOQIh+cIFu?=
 =?us-ascii?Q?x1eQOThkxfL2mcZOIFnghP9q1zfIgftmxolRnZyzBA6EjqWpfeJBP8bfo4pt?=
 =?us-ascii?Q?a/HKUiapmq221ctOh0gqejKidJ6voauy9sq+J7E3O7TOBu+5C9L8JBNBBHJu?=
 =?us-ascii?Q?0s1CqLaa5aOwHKS30opZ3IWPWDL9uqj+hTh5aJvdeWnvAoVYG+Gs9J4yVT2M?=
 =?us-ascii?Q?rxyreBs69VD0/e+yP1vRGrFAoZFJAuIPOtpck8zmwQeHwZQIB7PYNAAlXTmO?=
 =?us-ascii?Q?H19MBcoURvQCAp0bFaAMycEn8HpdowlfKFGOZ8SAUttZ0YU8YTjCmIDgVqfP?=
 =?us-ascii?Q?Ejf2SY8AJN/5UJVMVWp0Rtvco95oSrnsl8FC6h7CnvrbUZCTNwD0cthuV0PS?=
 =?us-ascii?Q?lraV9zxyNYV+x1Wbb1hDZi2XBFYj16iIYiN1bFhthLw22e/gheNQJnZch+7i?=
 =?us-ascii?Q?rgwZJ9/bmT9wOtlhD0LH/NqkD1e7s0jPgb2HHhD6kMuLWN2pKP2GmEgg43kQ?=
 =?us-ascii?Q?hDK6B5EyXH6DX38FZCkvzbniEZ2P2LY9/w5Gs76mugjtSRQvaIjP5ByPsG8R?=
 =?us-ascii?Q?9TknND90rtDSaS29Cs9jdk3jWoSSVKgFY34US1P3M3daibDV3JZ+gXNwsBz4?=
 =?us-ascii?Q?P5C5lINNi8UhpXmKixDMMMziJxklYIIXqPyod6E0Gk1hh0/Ga2iBwkICipfU?=
 =?us-ascii?Q?39d+HCnObatqS+25JX8LR6twcgz8si7GiQvjKHQaLn8RLxn8n5xMSKSGGDzc?=
 =?us-ascii?Q?3QvIf6HyCUsf1JY6xoAFWrA6i6mS0tuCqs1XHc2zvHuB1GEaO/5+EiDwluMx?=
 =?us-ascii?Q?KbwwysC3jMKNTMzc+NCL+GP1n5TCZ4sEjPQLmgLbacHEX6pk+uaGgL1nIZYQ?=
 =?us-ascii?Q?lePQzQcJ2PXHvsQaKvYy8qRibE7lQNKJuXOtpu6UlWvY3LFFCnnHMJapl6A4?=
 =?us-ascii?Q?bDpdeKcvhYi+DTWjA1okpKq3tqkNFfRirGQSXw/dgylyfefEUFnnlaLJQBD+?=
 =?us-ascii?Q?KaDLviiyyrQV2BR7EVQOZxkJJAFhDrcuiCJw2p3XDBtWIT9219r0UPQy5KaC?=
 =?us-ascii?Q?eZTDaw+nnYmGfSojuF6wJMLKnEQV8hEKc8mufJfQMoRZ6HDYaNZ+WWBcUJPb?=
 =?us-ascii?Q?Qdn4Fl4fXggJpKMUGPyRaplfLvkDDVCNotnP/wJrKV+47DSvgAz44gy/z0Bn?=
 =?us-ascii?Q?A0UUnOXeMv/68yrfhSqthYtATZgGvr88M+WCU+ahICZXwq+ZhZy2Fkgtt66U?=
 =?us-ascii?Q?iTu5d+R6MrCyKmpdRWarIEb3sTwBTXkWhri5xQzoThJ5iWatgifrCsexqZuy?=
 =?us-ascii?Q?PMlEPSqvvxBwQBh+/niL5yBELA1w?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3b75b6-5fff-4999-100a-08d8eeaceb95
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2021 10:09:32.5532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JUhDG8I4+36JCLH0e1CsZYlUZ8qEiqjFdJX2emnD7aS8OJQXNQLssDHSVY9xYO12ov7pf7Yjfq+0qqZDAFv/Y/zsK3cq/Zz2jveKA7FWC44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7142
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 24/03/2021 08:13, Johannes Thumshirn wrote:=0A=
> On 24/03/2021 08:11, Christoph Hellwig wrote:=0A=
>> On Wed, Mar 24, 2021 at 07:07:27AM +0000, Johannes Thumshirn wrote:=0A=
>>>>>  	if (iov_iter_is_bvec(iter)) {=0A=
>>>>> -		if (WARN_ON_ONCE(bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND))=0A=
>>>>> -			return -EINVAL;=0A=
>>>>> +		if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND) {=0A=
>>>>> +			struct request_queue *q =3D bio->bi_bdev->bd_disk->queue;=0A=
>>>>> +			unsigned int max_append =3D=0A=
>>>>> +				queue_max_zone_append_sectors(q) << 9;=0A=
>>>>> +=0A=
>>>>> +			if (WARN_ON_ONCE(iter->count > max_append))=0A=
>>>>> +				return -EINVAL;=0A=
>>>>> +		}=0A=
>>>>=0A=
>>>> That is not correct.  bio_iov_iter_get_pages just fills the bio as far=
=0A=
>>>> as we can, and then returns 0 for the next call to continue.  Basicall=
y=0A=
>>>> what you want here is a partial version of bio_iov_bvec_set.=0A=
>>>>=0A=
>>>=0A=
>>> Isn't that what I did? The above is checking if we have REQ_OP_ZONE_APP=
END and=0A=
>>> then returns EINVAL if iter->count is bigger than queue_max_zone_append=
_sectors().=0A=
>>> If the check doesn't fail, its going to call bio_iov_bvec_set().=0A=
>>=0A=
>> And that is the problem.  It should not fail, the payload is decoupled=
=0A=
>> from the max_append size.=0A=
>>=0A=
>> Doing the proper thing is not too hard as described above - make sure=0A=
>> the bi_iter points to only the chunk of iter passed in that fits, and=0A=
>> only advance the passed in iter by that amount.=0A=
>>=0A=
> =0A=
> Ah got it now,=0A=
> thanks=0A=
> =0A=
=0A=
Stupid question, but wouldn't it be sufficient if I did (this can still be=
=0A=
simplified):=0A=
=0A=
diff --git a/block/bio.c b/block/bio.c=0A=
index 26b7f721cda8..9c529b2db8fa 100644=0A=
--- a/block/bio.c=0A=
+++ b/block/bio.c=0A=
@@ -964,6 +964,16 @@ static int bio_iov_bvec_set(struct bio *bio, struct io=
v_iter *iter)=0A=
        return 0;=0A=
 }=0A=
 =0A=
+static int bio_iov_append_bvec_set(struct bio *bio, struct iov_iter *iter)=
=0A=
+{=0A=
+       struct request_queue *q =3D bio->bi_bdev->bd_disk->queue;=0A=
+       unsigned int max_append =3D queue_max_zone_append_sectors(q) << 9;=
=0A=
+=0A=
+       iov_iter_truncate(iter, max_append);=0A=
+=0A=
+       return bio_iov_bvec_set(bio, iter);=0A=
+}=0A=
+=0A=
 #define PAGE_PTRS_PER_BVEC     (sizeof(struct bio_vec) / sizeof(struct pag=
e *))=0A=
 =0A=
 /**=0A=
@@ -1094,8 +1104,8 @@ int bio_iov_iter_get_pages(struct bio *bio, struct io=
v_iter *iter)=0A=
        int ret =3D 0;=0A=
 =0A=
        if (iov_iter_is_bvec(iter)) {=0A=
-               if (WARN_ON_ONCE(bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND))=0A=
-                       return -EINVAL;=0A=
+               if (bio_op(bio) =3D=3D REQ_OP_ZONE_APPEND)=0A=
+                       return bio_iov_append_bvec_set(bio, iter);=0A=
                return bio_iov_bvec_set(bio, iter);=0A=
        }=0A=
=0A=
The above had a successful xfstests run and several fio --ioengine=3Dsplice=
 runs.=0A=
