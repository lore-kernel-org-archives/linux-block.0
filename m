Return-Path: <SRS0=LVe3=A4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD1BC433E2
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 09:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58EDA2070E
	for <linux-block@archiver.kernel.org>; Fri, 17 Jul 2020 09:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="eM/t8OBG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mVwH/pGJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgGQJTx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Jul 2020 05:19:53 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:37042 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgGQJTx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Jul 2020 05:19:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1594977593; x=1626513593;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=WURbqQkIAchkXHJ4EuzaSW2/jklyTrQES+5sjI/IErA=;
  b=eM/t8OBG+nLfgLLCgXUD8X5Z4+4FyJ3LU70LU+jsLbdjLrk2r6xMujSC
   Gwo2LvfnruM/9kY4W5c+c8oZtMqM+B0WZeWwDz0QbMXiZOHMOuspQLWut
   ALAksASJnHrT2a9NF/xyvux1SzK+Fl28TDO+uvlsuDixOJndMlgCTegX6
   FLy3p+E5lfr6S8rfvdOMNbFPzaGuQ1mXxqeyBrI7nlji7WtrV/EF5WVBg
   VdUTvNjINXPHNVxDmpwKpZMdI+Mv8ihjXHrUlqpxHoPFgnKpzlLG1pNCh
   qI4rV8WPUVLltA3b0IxkdfTjGKjRouVUZKrVCzi+an7q9XDqlGkio/gA1
   Q==;
IronPort-SDR: 73A5NtzEQ6KyTe8YN8ODnzmBLZgO1NhJ6Q62krR8bN76+K2860yNHDygFSBQUP2a0TXIOm1+uN
 22dPIuJ33kvvv7mrz8InF+g7hwELSEgpsf8JxCV6Ekg3AHOI/k4C9yna6433tC1aAwsB9DQdR1
 vyK6OOCSENLtpccuWO1WQni0b5UKNOjZsWxcQwXsG9mvXF3cKWzCJGXJeYyzJQ7+FgTBh+1qZn
 UKalVJtEPWXh9t792GA+zgMvZgjwV6XtmXrZgDLYhkT2BorA9Hv3EpNfERYTlNCmNm4B1ZZoJR
 wGc=
X-IronPort-AV: E=Sophos;i="5.75,362,1589212800"; 
   d="scan'208";a="142823107"
Received: from mail-mw2nam10lp2106.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.106])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jul 2020 17:19:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuRRRZfUBFPwbm9Fj8ooNShCQjoubQSDM/B9vwqbGzfv+CmZKuyCyR8tYHTxHWWwq7dKAGkNjjPZ6txTaeAw3OHbRwWBCl/ZD7kH3ApsN76PV/J/ubvuD4+nDoENvzO9ZSNFldvnRMP3pcLmjE26PKsHo5uqHKF9uji8jCFcM+GU2PMWdE7lq1ALyNXUVU1+RYyxOLLSl3vUQJGQ6Db2o1hU0Sv1rpKsZI3x0lLLDrJnsBxoN8FhV0zDdx/BciULW0Qb9TSDaixjd7cYfRc7ZivN1cCnZtYfXnKweTc++gPXu3XpQ8nHqYQY/bQ/tQDwQJe9SszWzIM3YrDjD/ShnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8vqqfyD4SWKJsFNpVg1gz97UYmJUd9Cxk7bzOFtDZE=;
 b=oWVwygYoNt03dqQZLkoB2Eix7UwmUpPsGXIEHYAMrT3q4LKnkrph6U2dMOHkXa8Ek98kI0FW4iFvTbWc3yY/CR3vDnTP0pR9DU5P0+e0caWuNzFS26BVWsDrl+X49+wb8HdaWchxUoCiZvSWXsxPp5ogYuPx6FWdmgSukZmiW+qD+I/D6vKHETztAmT4oMI+oUF6Fwulu9VP6rc0FyYQAQjCfSbO3WJ4WXy8Gw3DdX5+zljIxEHXkp5Uu/j7ttovGcY3fuJElsIMKSy/I8JtJPyk4FZZNaYUS6YtnWnkkS4s6FcowbVEKIPNVia1noHYd3Vq5uTbczmHOA7xp6dekw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8vqqfyD4SWKJsFNpVg1gz97UYmJUd9Cxk7bzOFtDZE=;
 b=mVwH/pGJNQVVVUi75ps3OK597BNeyKB/TakP2zXdBfelZLwb4TO16oSB0XpH9epvZfC/FGZgtV/UvPqB2+bkdCxQQNQy5semfuwDpqrn+6My5Y93lQEYPqh2yIDXJCwOWduZIJw5nZJFXLC55rsBVk9/Y7akvConurKcrxhCziM=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR0401MB3633.namprd04.prod.outlook.com (2603:10b6:910:94::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Fri, 17 Jul
 2020 09:19:50 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::d9e5:135e:cfd9:4de0%7]) with mapi id 15.20.3174.022; Fri, 17 Jul 2020
 09:19:50 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "hch@infradead.org" <hch@infradead.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: align max append sectors to physical block size
Thread-Topic: [PATCH] block: align max append sectors to physical block size
Thread-Index: AQHWW1k90KwUXjQMWE23AxcUX8lDNA==
Date:   Fri, 17 Jul 2020 09:19:50 +0000
Message-ID: <CY4PR04MB3751D86F13E852C1831FB3A0E77C0@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200716100933.3132-1-johannes.thumshirn@wdc.com>
 <20200716143441.GA937@infradead.org>
 <CY4PR04MB37512CC98154F5FDCF96B857E77C0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200717075006.GA670561@T590>
 <CY4PR04MB3751DAD907DFFB3A00B73039E77C0@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200717091124.GC670561@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3c48a64b-9dce-4959-e372-08d82a328f0b
x-ms-traffictypediagnostic: CY4PR0401MB3633:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR0401MB363388BC8A013C9052544CEAE77C0@CY4PR0401MB3633.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Iyzikibw00a9bnlgP3ZeW1f1uoMigtyF4O7TqhLAsAEpPdBXIQzwPT31hjVd63jVXUDXKRvirIwoTWHMDS9nTdAoFAIcDS1yTA0rRKgeCQiGJ2WYb3khUzaf5TafYKFk7R666bfuc9AL4n/HCJg4H4E7zfxrjPtnbDBbbIHtR+Ml3jr1jmxA3xO9KjmLfwBjw6vYxMDRvtwfHVaFYycAlnDd7PddmeW5UcnGw+SMSCSdg4NKk2mY0SbT9z1evdICb29Exqs3yuaxw0IHnaSaWYat8bGUdgcd5zON90YJ6LPxmkffjXt8So6GJvGUeHnQtBphXkcoe8ICxZgozQvymQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(136003)(39860400002)(346002)(396003)(316002)(6916009)(26005)(8936002)(4326008)(186003)(9686003)(91956017)(5660300002)(76116006)(52536014)(7696005)(66946007)(66556008)(66476007)(66446008)(64756008)(54906003)(71200400001)(6506007)(8676002)(53546011)(33656002)(86362001)(83380400001)(2906002)(478600001)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: WlSqrQeES2ALN6z1GJonJjXnuQQxliSLPcjIyeQJS0tPdvg6kbxMe9T9a3+ske57F3LwZWDL7Ig7DkCYxYDpqh/Y+piz52F4Lx0As30ICTtxJXcjjq/L4nxvi6VrwlSOsnPRihara4i9r5xuSFP1GNgfGxrlKNRCXNmHUfUzcD83UNULrXhNj4xgKN+WAlufOQOHVYnJMjYVhxEhCjyQRt4bDEjVbJpFCTa3ruDIKJL0stJcY2ywNj/V+/oAG6Tj4JyMo8O7QQip5siX9eMvezAfAxm/kxSTKQggL3ZByo49rTjIhoNl99VH3rai/LeHYO75Yi7g8rnkLYwuoIht/Jmxch8aIAPSnRGnDCvB55LEZrPqWd3URcV3lX0Ryq6brvJoKoGYtJVEbrxiJTo1j6Mj33W2i2NdUZhHdhgGmXsqrS5rRWXBP3SBIrp/FSfFQUp465hvbyppf57G+j4S+7TCvoxgn4/Vn5P4FzcjnTEIEwExtvhRISW6oiG2FNbq
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c48a64b-9dce-4959-e372-08d82a328f0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2020 09:19:50.8398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: brerJqE2Ygt7t5j/lFUgnC+D3smEHaPRBjsqphkgAINSyZi4DvtqlysFc9r88rdUF63dv7eOd5tVE/N8kBo59Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3633
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/07/17 18:12, Ming Lei wrote:=0A=
> On Fri, Jul 17, 2020 at 08:22:45AM +0000, Damien Le Moal wrote:=0A=
>> On 2020/07/17 16:50, Ming Lei wrote:=0A=
>>> On Fri, Jul 17, 2020 at 02:45:25AM +0000, Damien Le Moal wrote:=0A=
>>>> On 2020/07/16 23:35, Christoph Hellwig wrote:=0A=
>>>>> On Thu, Jul 16, 2020 at 07:09:33PM +0900, Johannes Thumshirn wrote:=
=0A=
>>>>>> Max append sectors needs to be aligned to physical block size, other=
wise=0A=
>>>>>> we can end up in a situation where it's off by 1-3 sectors which wou=
ld=0A=
>>>>>> cause short writes with asynchronous zone append submissions from an=
 FS.=0A=
>>>>>=0A=
>>>>> Huh? The physical block size is purely a hint.=0A=
>>>>=0A=
>>>> For ZBC/ZAC SMR drives, all writes must be aligned to the physical sec=
tor size.=0A=
>>>=0A=
>>> Then the physical block size should be same with logical block size.=0A=
>>> The real workable limit for io request is aligned with logical block si=
ze.=0A=
>>=0A=
>> Yes, I know. This T10/T13 design is not the brightest thing they did... =
on 512e=0A=
>> SMR drives, addressing is LBA=3D512B unit, but all writes in sequential =
zones must=0A=
>> be 4K aligned (8 LBAs).=0A=
> =0A=
> Then the issue isn't related with zone append command only. Just wonderin=
g how this=0A=
> special write block size alignment is enhanced in sequential zones. So fa=
r, write=0A=
> from FS or raw block size is only logical block size aligned.=0A=
=0A=
This is not enforced in sd/sd_zbc.c. If the user issues a non 4K aligned=0A=
request, it will get back an "unaligned write" error from the drive. zonefs=
 and=0A=
dm-zoned define a 4K block size to avoid that. For applications doing raw b=
lock=0A=
device accesses, they have to issue properly aligned writes.=0A=
=0A=
> =0A=
>>=0A=
>>>=0A=
>>>> However, sd/sd_zbc does not change max_hw_sectors_kb to ensure alignme=
nt to 4K=0A=
>>>> on 512e disks. There is also nullblk which uses the default max_hw_sec=
tors_kb to=0A=
>>>> 255 x 512B sectors, which is not 4K aligned if the nullb device is cre=
ated with=0A=
>>>> 4K block size.=0A=
>>>=0A=
>>> Actually the real limit is from max_sectors_kb which is <=3D max_hw_sec=
tors_kb, and=0A=
>>> both should be aligned with logical block size, IMO.=0A=
>>=0A=
>> Yes, agreed, but for nullblk device created with block size =3D 4K it is=
 not. So=0A=
> =0A=
> That is because the default magic number of BLK_SAFE_MAX_SECTORS.=0A=
> =0A=
>> one driver to patch for sure. However, I though having some forced align=
ment in=0A=
>> blk_queue_max_hw_sectors() for limit->max_hw_sectors and limit->max_sect=
ors=0A=
>> would avoid tripping on weird values for weird drives...=0A=
> =0A=
> Maybe we can update it once the logical block size is available, such=0A=
> as:=0A=
> =0A=
> diff --git a/block/blk-settings.c b/block/blk-settings.c=0A=
> index 9a2c23cd9700..f9cbaadaa267 100644=0A=
> --- a/block/blk-settings.c=0A=
> +++ b/block/blk-settings.c=0A=
> @@ -311,6 +311,14 @@ void blk_queue_max_segment_size(struct request_queue=
 *q, unsigned int max_size)=0A=
>  }=0A=
>  EXPORT_SYMBOL(blk_queue_max_segment_size);=0A=
>  =0A=
> +static unsigned blk_queue_round_sectors(struct request_queue *q,=0A=
> +		unsigned sectors)=0A=
> +{=0A=
> +	u64 bytes =3D sectors << 9;=0A=
> +=0A=
> +	return (unsigned)round_down(bytes, queue_logical_block_size(q));=0A=
> +}=0A=
> +=0A=
>  /**=0A=
>   * blk_queue_logical_block_size - set logical block size for the queue=
=0A=
>   * @q:  the request queue for the device=0A=
> @@ -330,6 +338,9 @@ void blk_queue_logical_block_size(struct request_queu=
e *q, unsigned int size)=0A=
>  =0A=
>  	if (q->limits.io_min < q->limits.physical_block_size)=0A=
>  		q->limits.io_min =3D q->limits.physical_block_size;=0A=
> +=0A=
> +	q->limits.max_sectors =3D blk_queue_round_sectors(q,=0A=
> +			q->limits.max_sectors)=0A=
>  }=0A=
>  EXPORT_SYMBOL(blk_queue_logical_block_size);=0A=
=0A=
Yes, something like this was what I had in mind so that 4Kn drives get a=0A=
sensible value aligned to the 4K LBA, always. However, with the above, ther=
e is=0A=
no guarantee that max_sectors is already set when the logical block size is=
 set.=0A=
I am not sure about the reverse either. So the rounding may need to be in b=
oth=0A=
blk_queue_logical_block_size() and blk_queue_max_hw_sectors().=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
