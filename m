Return-Path: <SRS0=At5W=25=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14035C33C99
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 02:38:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBF702070E
	for <linux-block@archiver.kernel.org>; Wed,  8 Jan 2020 02:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="jjkL2Mr4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="iGpbmHJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgAHCiG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Jan 2020 21:38:06 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:41692 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbgAHCiF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Jan 2020 21:38:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1578451084; x=1609987084;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=8o4lerwHSabHihoBEA+aC66lXc/bFyssekI6hEX8D7M=;
  b=jjkL2Mr49m46zNxKnlc2P/a8z6lALqHDpNLpS36avlPRRdXtUpZZHc+9
   8idBA9dCcVOap/aDs3oLmrYvFz3dGHqcbeD2lfk2qzRfqgzojXCCDuKr7
   yMY/aMLiAHXq3bvG4IseMBnXrG2NpdB9N9Nw8jdfj1fTBHD7PQsYOj9ea
   TVaSbNtMraoCDo8wU00ciMrHFDZdG8KF1s9RtTCvsXSbho8jsQBWzJybt
   BAA5IMou/7D3DQQURtcUPpmBnK/nWU7DuAfUlhLXuSgtpVYZY/FOf3RzG
   v6QjBcjcy7t+YXDbYIB/cLPG/da6JKy4o/eeuIvG2JvrBHwQ+YywBjEC/
   w==;
IronPort-SDR: s+krGjKX+i4Z0E8C9iwHytqo36/1zkqhGdbPobf8vjrSOLzDuRU/1n3y2aEaHe7eP0UDQ7tVxx
 LlD0J2eP2GukTVj5Pjv2nB/z1EosxrQLAigAF+RAnl1MWgzA9eEJ6qM5C29O5hrXdbqCjdjcOO
 yjkZkUYazR72vPAqpWEYddLa9ULI1QylIgJZ/VaK4z7LZEFWLi89Gv5K24dq7w0zZPXaDTKUlD
 8Nw+m/tr1qFxwgGHeLHbJQexqYvqrhZPuB5OWfzz8dyU1hG4bFYqmqAVvYTy5Lf6jhNgOWxJQr
 45g=
X-IronPort-AV: E=Sophos;i="5.69,408,1571673600"; 
   d="scan'208";a="126929727"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jan 2020 10:38:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RIJtQa545ZI6ox7MoUj/iVtDXhFkKFEkz4Cq6N8KrdMStDs78ph7cMH5FasIbbEpKCK7SWxtev2nbSVU7eeRXz801kLJuViNgrql0RSFHMrBgUthUP2Rtmc2DKGYqOwpp/44VsMyJbkHS2q+hXXe2X0lkUQlPI/IsFhypgIW0f4Tg7RPrp8W2PWlb5W7zFWXazlV6AYgy3G2Irzyt5v08Xz0AOopvhUX3geuq6idjlOohj7l894Idw/iE9HTLP/AHlfd1dftND6aC7YIDT9IaTqQb4eTc5xkabk5IuHgSOm0azfQRX5su8lyIOGFaCbwDXU5jaLH2yQJWGC5H4nkTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ku5WocPy8GNqm08g/9b6cfcC23D5ScfIiyG1VKz5F9A=;
 b=UpdLzoNAsumjHRV78dqY2acKWleLM5UFvacJlMXlKTXKSLMLJo/A8kyD39Zutcxr7n4QUNZDTgk6sLvLvHOhr43hLIgjPaiczqyb/0DvFb3Wq555y0enZsklloeCFNBu5K+ZpY9hGek1eCzUYLAOsQ6yvuG6wk6Yhfog4dc0+RRrz5EAOFHzrqNJhoPvbfyyrU3E7XX8zJUPEVILPg2abEBIerk8SAM0svxTCY7hq9/k4hUWWG1yizS8RBnrhhqKXTF0Op2ap2t81YS3X7/MpOSCiqFf28eceJNJ7hDvCOJH8XGF8IXcK+IT3RFcX0/XPdWhPncdwDqdOY9mfyxRWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ku5WocPy8GNqm08g/9b6cfcC23D5ScfIiyG1VKz5F9A=;
 b=iGpbmHJMYpjZEKQXNy7pTDFyPlsusP10AhtmT0GXRk3TDcd2O1kt4rtFJOGknRhMgKKPqQ1LuY3oGYW0t4duu3vYYp+aw6U3mT3cRw6bMyjF5VM7ARfPTcPtKY80haweuUwihh8GxDbULrPOGkpxUGPUYjDHyPnVDtI+Y+twU7s=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB4390.namprd04.prod.outlook.com (52.135.204.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Wed, 8 Jan 2020 02:38:03 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2602.016; Wed, 8 Jan 2020
 02:38:03 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] block: fix get_max_segment_size() overflow on 32bit arch
Thread-Topic: [PATCH] block: fix get_max_segment_size() overflow on 32bit arch
Thread-Index: AQHVxcKPgLyHDZ/rAEWFpb5xuR+TFg==
Date:   Wed, 8 Jan 2020 02:38:02 +0000
Message-ID: <BYAPR04MB5816C3DA0641956670F2B323E73E0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20200108012526.26731-1-ming.lei@redhat.com>
 <BYAPR04MB581614236B3088415240723AE73E0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <a5fa8b59-6685-d914-6163-1d515777300b@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a04dc643-2790-411e-8e48-08d793e3c8af
x-ms-traffictypediagnostic: BYAPR04MB4390:
x-microsoft-antispam-prvs: <BYAPR04MB439015AE24C34FAD710F4C47E73E0@BYAPR04MB4390.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(346002)(376002)(136003)(39860400002)(199004)(189003)(6506007)(5660300002)(316002)(8676002)(478600001)(7696005)(33656002)(9686003)(110136005)(81156014)(8936002)(81166006)(55016002)(52536014)(53546011)(54906003)(4326008)(76116006)(66556008)(66476007)(71200400001)(91956017)(66946007)(86362001)(26005)(186003)(66446008)(64756008)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4390;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WOKAIsjTzu0/cubKStI4LNtfKhnw4rgq7AMprfhDMrt1IOCyYVxYBWYsubT9RWKZ5hXsRlKDlok3w2yITnOGpGxVJ78+S+JhoU7mBNvX9q0XIXWcEdXen93rauodLuYwbHDi2/wEUWnJdY5TOss+f8yzKqpFnnCwxztUeVhNmS5CgZ0SeyMh8ZNNcP7I3BTs2Eyih5sfIkRTFKGljUzAePWYFYu5BSAN4pfvH+hOnKXpulC9eeAe9Sp+sccfdNAGwk925Wu+iKmD8wXDhXzrut2wl35aIkSEF2XnQM2yYlSf6SREp1qx+X+dsr6UAAgx9vzlUPMTWnpTbsNcyWJ/JelmrvqN9E/odyJ00tji+94E/VxFJZtUdNu7ICRs0fUBBjd3Rj1vKd01QAp4VDZHW9PRPLyEyJgvH9TXWwysvibKm9vlqpjTwkC88m2aYP5O
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a04dc643-2790-411e-8e48-08d793e3c8af
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 02:38:02.7853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FhqBkHvY/GlQ6tOsM8DePENDJ0VRqAU6OLrBxWOCuhGbvDu5aJeJq7hNyCSeqpc2VZvcY2MbqJEgs6XWJdxgvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4390
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/01/08 11:34, Jens Axboe wrote:=0A=
> On 1/7/20 7:06 PM, Damien Le Moal wrote:=0A=
>> On 2020/01/08 10:25, Ming Lei wrote:=0A=
>>> Commit 429120f3df2d starts to take account of segment's start dma addre=
ss=0A=
>>> when computing max segment size, and data type of 'unsigned long'=0A=
>>> is used to do that. However, the segment mask may be 0xffffffff, so=0A=
>>> the figured out segment size may be overflowed because DMA address can=
=0A=
>>> be 64bit on 32bit arch.=0A=
>>>=0A=
>>> Fixes the issue by using 'unsigned long long' to compute max segment=0A=
>>> size.=0A=
>>>=0A=
>>> Fixes: 429120f3df2d ("block: fix splitting segments on boundary masks")=
=0A=
>>> Reported-by: Guenter Roeck <linux@roeck-us.net>=0A=
>>> Tested-by: Guenter Roeck <linux@roeck-us.net>=0A=
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>=0A=
>>> ---=0A=
>>>  block/blk-merge.c | 4 ++--=0A=
>>>  1 file changed, 2 insertions(+), 2 deletions(-)=0A=
>>>=0A=
>>> diff --git a/block/blk-merge.c b/block/blk-merge.c=0A=
>>> index 347782a24a35..b0fcc72594cb 100644=0A=
>>> --- a/block/blk-merge.c=0A=
>>> +++ b/block/blk-merge.c=0A=
>>> @@ -159,12 +159,12 @@ static inline unsigned get_max_io_size(struct req=
uest_queue *q,=0A=
>>>  =0A=
>>>  static inline unsigned get_max_segment_size(const struct request_queue=
 *q,=0A=
>>>  					    struct page *start_page,=0A=
>>> -					    unsigned long offset)=0A=
>>> +					    unsigned long long offset)=0A=
>>>  {=0A=
>>>  	unsigned long mask =3D queue_segment_boundary(q);=0A=
>>>  =0A=
>>>  	offset =3D mask & (page_to_phys(start_page) + offset);=0A=
>>=0A=
>> Shouldn't mask be an unsigned long long too for this to give the=0A=
>> expected correct result ?=0A=
> =0A=
> Don't think so, and the seg boundary is a ulong to begin with as well.=0A=
> =0A=
=0A=
I was referring to 32bits arch were ulong is 32bits. So we would have=0A=
=0A=
offset =3D 32bits & 64bits;=0A=
=0A=
with the patch applied. But I am not sure how gcc handles that and if=0A=
this can be a problem.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
