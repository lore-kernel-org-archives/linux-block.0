Return-Path: <SRS0=At5W=25=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C3CC33C99
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 03:02:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF01B20880
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 03:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="iuA1aJu7";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="m29+QaBC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgAHDCn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 22:02:43 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:13490 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgAHDCm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jan 2020 22:02:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1578452584; x=1609988584;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ZubeUBlrKdud0WIDvwYjCBLiG4CE4bclQZh2TAUZfQ0=;
  b=iuA1aJu753rRTYkzlMOSrtQq4LWQncFzoQWhLfsVCGJAy8ho3Glw3WNP
   5ZxcnnJdDS0C3KNrbV9sxTP/C59RRdVP4QqBlfCeEmesDhWy9ZRVsqaja
   omm6n9XRTt6NwxQ0oUbmxW+vJ0WhI/mzw1nuewOa4XLI0Z55TuSCYspHG
   +4Hv7uV7VMvRz+Br9lp3dbuBJ+Z+GUEyxlo8i3TpD0GikGPmM8gDjhnCS
   CRvyu+FPthnnzqeixBfYKEqnKL04KFINE6dpYJJ4x3snLgJ9fzymQ8yE3
   UZkOjCwaz9BaMaR/bMyX1Rt1PmMyfUZdynjzl8/ZUaB/ktjFEgaCvcC8U
   g==;
IronPort-SDR: THTZWhIvT/AHFkQmXuag53awRmwQWtA7SJgeIGt+RXYeFTkA6+XC/vZDZcF4deRxsUP7dT0Dxt
 /EaJJbwIahclPolQXa+Qy/0XWxIJWYGuSAQ6mzaz6Pp37x1C5/tR4BFjo424j5hNPYaRi0Lh/3
 DzvwwWnCoT1tFVmWTl4LU3pcoPkiAYV8tyywn6JoS+GeIZLZGxazPndpNNaT9JQbaBgQJZhAWe
 VhT1u2ayZ78QgtOF6kw0SDr77bAeDFqmzFWzmwoyYnTY5X4mppLX9t0keMfstHpl2riw4NCjyZ
 pbw=
X-IronPort-AV: E=Sophos;i="5.69,408,1571673600"; 
   d="scan'208";a="228613896"
Received: from mail-co1nam04lp2054.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.54])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jan 2020 11:03:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYNVpivEEseYYz/AlO5rdVN8cMqDu3PkecKHqmoq4p/5F4ZwaTTmNWrJKWoH6/OhLX+8hktv2+QF6g664sGS9BWp7tUA6Czv0LS7JhRcA8CuaP5aF0BiZBcjKdBpQ7Q4DMk3Jw9yC0n4+eUR0aZEj9kNJz977M/L1B/ifSSlyIzYwz1EpVfFDI2QsTvRtVVCeMh0PjADNnuftFHYulNn5xcqQYevY5TRDe8ISKIEOBb85umn3q/lQt9EtPfiekRnUe4MOv9TRTGsI1hEyjUrSdvYbuqbubHtGQZJN7QHakkHGC0SkoBbJTl2LDS21WyUNF3SHoD2WboafpWfFqviTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsJ28PNwdPg+87dWN9n7O7Fuwp8+ohMaLk4pf84AVPE=;
 b=FGewt62d5kqoQ6ZtHcGLuW1FxAialuSw/sEJ1BGXrgMr9+oKb8In4YT/xyaJxmWVd7frrKTOrdtNQRrisKsUDqBOiuzB1bjO5Ujx+Gmbtimok9/ewS44T3yOk5P0mAin8yeXRqCemzCx0YyuaL4QgG1E42SvHl14+mO8/6qnqzLgKMMxlZiG7qOs7XSto/yUA5wQKVcyTPtcvXq6WY5WkOpqyn4XjOTu9iECRRZ7H19sWWZVJetoIEiSx5qdOCe0mcg11yIOJ6N3F8wa7FDKZOt5HxagEW3TDaQdJaQDWwGLGwdlI++kGXWF3kY+tyXkN5AjlGVJuEFGw4Mu6TgDAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IsJ28PNwdPg+87dWN9n7O7Fuwp8+ohMaLk4pf84AVPE=;
 b=m29+QaBCgyRd8wRTFMeR5FnEj+hIhy1YC4FEKB1IabLtD6xDgmgm1iQY/B+gOsMifQCf7cWxoGyam1nUCN4fbxYNgSAKm5Wz4uqsBKSe+BDh6ZB60DkvPpmgJk4fDGBk5bJNsLktc1D552IkOAsZPtr/iUfGPvkfhGuRR3aRPQk=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB5464.namprd04.prod.outlook.com (20.178.1.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.15; Wed, 8 Jan 2020 03:02:40 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2602.016; Wed, 8 Jan 2020
 03:02:40 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Guenter Roeck <linux@roeck-us.net>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: fix get_max_segment_size() overflow on 32bit arch
Thread-Topic: [PATCH] block: fix get_max_segment_size() overflow on 32bit arch
Thread-Index: AQHVxcKPgLyHDZ/rAEWFpb5xuR+TFg==
Date:   Wed, 8 Jan 2020 03:02:40 +0000
Message-ID: <BYAPR04MB58169D07BDF7A03FC2493F4EE73E0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20200108012526.26731-1-ming.lei@redhat.com>
 <BYAPR04MB581614236B3088415240723AE73E0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <a5fa8b59-6685-d914-6163-1d515777300b@kernel.dk>
 <BYAPR04MB5816C3DA0641956670F2B323E73E0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <be4b6c8b-b05b-edfe-0e42-a43015f8295e@roeck-us.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dfd30512-a30b-4120-cc0e-08d793e73969
x-ms-traffictypediagnostic: BYAPR04MB5464:
x-microsoft-antispam-prvs: <BYAPR04MB546404A06ACB5795B74B2E98E73E0@BYAPR04MB5464.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(346002)(136003)(39860400002)(376002)(366004)(51914003)(189003)(199004)(55016002)(2906002)(81166006)(81156014)(33656002)(8936002)(8676002)(4326008)(9686003)(26005)(5660300002)(186003)(53546011)(316002)(6506007)(110136005)(52536014)(71200400001)(7696005)(91956017)(64756008)(76116006)(86362001)(66446008)(478600001)(66946007)(66556008)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5464;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p7LCR3blAHHDgq5NlVTkZfoh/GvJnlcpgT3jI2P7VhAbgQKUNCCYeOolMcjSbLy5flsq025E65OHqYz8okhW9Ph4EYQHRG2193jv4OUfNfJTCR+3nEjYmv4Z8mtzLgViRKKMWMyNYDaqmr21OFlyKIRE3GtaR4k3nMMR/HKn6RbpgyisyjClhSDSvN6kvCfdQNmxEPZO6SRR5hcayO81BJnuQ22AqTJsI3gLRaz2ADNSLyxdlGlQrMy+0kaf8zMpiaW2RNW9aRW9t3NJQNI7eK2pLmbj7E7jXM+LzSw1hzDTbRB1pAKRllMPYzj52SW0pD6EXkNGOPycfmCoH/yW+gFyFwOCBHrlzZNSdq8uTK1xaajA6dRGR7mmlv7Jpl2IMeS199kR0aOuRYmQUmToQbePUjEOiAxRYbEtKBpPUHxtoNMcta6MfH38G8OU17CZjhCOOmyz6BKseIBCPSIXfnTwGLUc7NSKviHYeP1MmFmLk6v1fZY8jDcSYBVxyFPN
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd30512-a30b-4120-cc0e-08d793e73969
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 03:02:40.3849
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cdLOu2y3LGnqKgoHOvFqEWNY6KMELrkLO8negg3yS780bI6mgMUJIdsl9ucysokAjafWkGp9+a39NTcz/oYFYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5464
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/01/08 11:59, Guenter Roeck wrote:=0A=
> On 1/7/20 6:38 PM, Damien Le Moal wrote:=0A=
>> On 2020/01/08 11:34, Jens Axboe wrote:=0A=
>>> On 1/7/20 7:06 PM, Damien Le Moal wrote:=0A=
>>>> On 2020/01/08 10:25, Ming Lei wrote:=0A=
>>>>> Commit 429120f3df2d starts to take account of segment's start dma add=
ress=0A=
>>>>> when computing max segment size, and data type of 'unsigned long'=0A=
>>>>> is used to do that. However, the segment mask may be 0xffffffff, so=
=0A=
>>>>> the figured out segment size may be overflowed because DMA address ca=
n=0A=
>>>>> be 64bit on 32bit arch.=0A=
>>>>>=0A=
>>>>> Fixes the issue by using 'unsigned long long' to compute max segment=
=0A=
>>>>> size.=0A=
>>>>>=0A=
>>>>> Fixes: 429120f3df2d ("block: fix splitting segments on boundary masks=
")=0A=
>>>>> Reported-by: Guenter Roeck <linux@roeck-us.net>=0A=
>>>>> Tested-by: Guenter Roeck <linux@roeck-us.net>=0A=
>>>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>=0A=
>>>>> ---=0A=
>>>>>   block/blk-merge.c | 4 ++--=0A=
>>>>>   1 file changed, 2 insertions(+), 2 deletions(-)=0A=
>>>>>=0A=
>>>>> diff --git a/block/blk-merge.c b/block/blk-merge.c=0A=
>>>>> index 347782a24a35..b0fcc72594cb 100644=0A=
>>>>> --- a/block/blk-merge.c=0A=
>>>>> +++ b/block/blk-merge.c=0A=
>>>>> @@ -159,12 +159,12 @@ static inline unsigned get_max_io_size(struct r=
equest_queue *q,=0A=
>>>>>   =0A=
>>>>>   static inline unsigned get_max_segment_size(const struct request_qu=
eue *q,=0A=
>>>>>   					    struct page *start_page,=0A=
>>>>> -					    unsigned long offset)=0A=
>>>>> +					    unsigned long long offset)=0A=
>>>>>   {=0A=
>>>>>   	unsigned long mask =3D queue_segment_boundary(q);=0A=
>>>>>   =0A=
>>>>>   	offset =3D mask & (page_to_phys(start_page) + offset);=0A=
>>>>=0A=
>>>> Shouldn't mask be an unsigned long long too for this to give the=0A=
>>>> expected correct result ?=0A=
>>>=0A=
>>> Don't think so, and the seg boundary is a ulong to begin with as well.=
=0A=
>>>=0A=
>>=0A=
>> I was referring to 32bits arch were ulong is 32bits. So we would have=0A=
>>=0A=
>> offset =3D 32bits & 64bits;=0A=
>>=0A=
>> with the patch applied. But I am not sure how gcc handles that and if=0A=
>> this can be a problem.=0A=
>>=0A=
> =0A=
> Type extension is well defined in the C standard.=0A=
> =0A=
> The underlying problem here is that mask is 0xffffffff, and=0A=
> page_to_phys(start_page) as well as offset are sometimes 0.=0A=
> In this situation, mask - offset + 1 is 0 if offset is a 32 bit=0A=
> variable, and 0x100000000 if offset is a 64 bit variable.=0A=
> In the first case, this results in a wrong maximum segment=0A=
> size of 0.=0A=
=0A=
OK. Thanks for the clarification.=0A=
=0A=
> =0A=
> Guenter=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
