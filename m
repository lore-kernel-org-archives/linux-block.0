Return-Path: <SRS0=iXKq=N6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62028C43441
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 23:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C8982080C
	for <linux-block@archiver.kernel.org>; Mon, 19 Nov 2018 23:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="it2l13U5";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KeFfqHy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C8982080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbeKTKMv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 20 Nov 2018 05:12:51 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:25070 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727583AbeKTKMv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 20 Nov 2018 05:12:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1542671203; x=1574207203;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=aJdlbIYezFwzhlWNYlLjgWhp8+rtGLDQ91dTRwhZYG4=;
  b=it2l13U5aasr7asf1saXn7IVGKbCS/dnx+DVx7ykPMDZIPYuFJJY8Ew5
   i5Zv4uUdwTPWaLV1d9RN48gs9POlWhUaKC9RLnZCn8OkXppyzDUVpINC+
   PIltZUpIWf7+Tm3OAQ1uOehWGHNsiBdn1OLGfSTf9bmcYAg6rAhE6zK/o
   ljsmwHjusvdv4iEDsd4l6AuI03WCVdfvvidBlSYBb8OkV6dvV7vB5gzmX
   mA+BxJ3vI9/7scuKHzBPXgo9cRwXUEFgC09xfqRCajmJ3Q3ORfzYaNz04
   SIo8iwvWLEN3e71Fsq11GEPkoehkMx9ybrwXSNaFWw0tv/Jvw+6QD5XnH
   g==;
X-IronPort-AV: E=Sophos;i="5.56,254,1539619200"; 
   d="scan'208";a="96358249"
Received: from mail-dm3nam05lp0117.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([216.32.181.117])
  by ob1.hgst.iphmx.com with ESMTP; 20 Nov 2018 07:46:43 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/saiGMtRyGrcqmK6it5bnvPS3Em24DoDzdlaCJiv9E=;
 b=KeFfqHy7xE12d1w1iZsqrSEx4VckFVkgDXAfnobW/er473yjFFN0qP53J3HVT9pgXTClD/ZVra/ExDYXqxeqLrdyafCrG8HhjohznNgAQzKssnJhb46ENWSPxUcs/CYCsvcnaDM3LOqqoOYiCyW0nXbl5QMGv6DIBbP2V0CMYMI=
Received: from BN3PR0401MB1640.namprd04.prod.outlook.com (10.163.41.30) by
 BN3PR0401MB1169.namprd04.prod.outlook.com (10.160.155.147) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1339.26; Mon, 19 Nov 2018 23:46:37 +0000
Received: from BN3PR0401MB1640.namprd04.prod.outlook.com
 ([fe80::e1b0:e927:5d5d:4164]) by BN3PR0401MB1640.namprd04.prod.outlook.com
 ([fe80::e1b0:e927:5d5d:4164%5]) with mapi id 15.20.1339.027; Mon, 19 Nov 2018
 23:46:37 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Adam Manzanares <Adam.Manzanares@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 4/7] block: Introduce get_current_ioprio()
Thread-Topic: [PATCH 4/7] block: Introduce get_current_ioprio()
Thread-Index: AQHUf7s92TMpclnBP0aLomS/pkU7Lg==
Date:   Mon, 19 Nov 2018 23:46:37 +0000
Message-ID: <BN3PR0401MB1640BDBE8CF57D4FC40963AAE7D80@BN3PR0401MB1640.namprd04.prod.outlook.com>
References: <20181119035131.11255-1-damien.lemoal@wdc.com>
 <20181119035131.11255-5-damien.lemoal@wdc.com>
 <bd285dac47cfe5bdc7b5182763e86fdd0bda543f.camel@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN3PR0401MB1169;6:v83xERKfPNsYlqwqfZ0R8UzdIKPO+RVAWvwLlhuLQJ6uemTchXfrBQPRmcDiUcNTkTr7sGIKjEvgTjr5m8sYalE1vWxES/QzNgQOrT6xUXR05h2sLu9uSMIWdwaTpxoATFQqF7sBxdUqSNPCt+8C0A5DpZ0cWFACxmOyclmdzYDQpBe4JU4xRqWS8w1F0/0d1qWitLkWdixZl99UbkSaeALq4sWQuvgxBOUNkchZ5xh4Qb+6vMkAXxByPv8y4jkt3iyRrdbzhTW5KAdsNMY0kT6hO85Ojmlsfh8M9qU1WBCGl4LgrqgniYlZu5UOiEPcw7raeVcon3CPrLPZMdsCBxZUhkjZpaS2oCi0ByXqoMaFCnUFvcwcL/qCn07IENhsmIPy6LroUegKUfn7rqCjQ3g8eRc+xbbiS+yzp+zhd/rQOdZQBG3KCSWMLRH7U33hizBQfyp2gGDU0DiM/gfHKFmxSNWiGBO/1uvp0vFVMMg=;5:zdYqaGmhf/1bATIuK70Bkk+sHj3kVjxDSHqqB8QBTGHgi+429sNawSssjn7zfTJqWYrSEUGVi4PM4lP7DQ99h5pLH0NwOKxKzOlk4tFva4xt6J3m72zaXwMuzxl47KQpuB+PTI0oPLSifO7e5oy3qWeh3IIAIUeTOpFSXSJqH8c=;7:lvTQmTMIWHoN+ygZHHyETPgYrtT1t7lLYmEw5lI6Q515P3yf+Il1usoxPWWK7b1xJyF2zi23gzqXNmPpmZOANX9m3Ul9+X8brh6Gt3N6zaHofkheoZ9iJp5DnRouUhHGclgxPeL1lPr9jJw96erFrw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-ms-office365-filtering-correlation-id: 3c001f1a-2db0-4dd6-eedd-08d64e793f37
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN3PR0401MB1169;
x-ms-traffictypediagnostic: BN3PR0401MB1169:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <BN3PR0401MB11699C7E11F7EAA62BBA483AE7D80@BN3PR0401MB1169.namprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231442)(944501410)(52105112)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201708071742011)(7699051)(76991095);SRVR:BN3PR0401MB1169;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0401MB1169;
x-forefront-prvs: 08617F610C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(136003)(346002)(376002)(189003)(199004)(81166006)(81156014)(8676002)(8936002)(6246003)(3846002)(2906002)(53936002)(6116002)(4001150100001)(5660300001)(4326008)(25786009)(6436002)(68736007)(305945005)(74316002)(97736004)(33656002)(14454004)(7736002)(478600001)(72206003)(6506007)(102836004)(2501003)(105586002)(26005)(53546011)(186003)(106356001)(86362001)(7696005)(2201001)(76176011)(2900100001)(71200400001)(71190400001)(316002)(14444005)(229853002)(256004)(54906003)(110136005)(476003)(66066001)(446003)(486006)(55016002)(9686003)(99286004);DIR:OUT;SFP:1102;SCL:1;SRVR:BN3PR0401MB1169;H:BN3PR0401MB1640.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: A++WX8eWA07Vj3ufuSrlQl8DWnBp0Bsq3U/9fVxHtaQkTQL5O9uzen+Fsl6MGWJJSpkFAmKUMIgGtre3sfLDBXLmJoqLuXevOXKx1+CrrGJzL0ug3BZIuwizu7WVDB7Z06Wc3XSULmYT+DJhwBG5eBG1AlvpVfYIxVTV0GDPxG647SlFjOh4vo7cAbgaVOe0ZHL+pVX5EzNw3f94oI0wEBd+jtF2Iz1vEdOH27yMBfM4WJRt4Z585vMSPiV5FNKGcXzpbPRNkEBumyMe9q1unavcn9g7gVH7lNYnkbPuOcAWOnWRSS0HlZ5OTJJR7AFQTg9H1LJ1Czfrp0jt8EhA+pHAXGdfj7iwP5TsoJRTTGU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c001f1a-2db0-4dd6-eedd-08d64e793f37
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Nov 2018 23:46:37.6732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0401MB1169
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Adam,=0A=
=0A=
On 2018/11/20 3:18, Adam Manzanares wrote:=0A=
> On Mon, 2018-11-19 at 12:51 +0900, Damien Le Moal wrote:=0A=
>> Define get_current_ioprio() as an inline helper to obtain the caller=0A=
>> I/O priority from its task I/O context. Use this helper in=0A=
>> blk_init_request_from_bio() to set a request ioprio.=0A=
>>=0A=
>> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
>> ---=0A=
>>  block/blk-core.c       |  6 +-----=0A=
>>  include/linux/ioprio.h | 13 +++++++++++++=0A=
>>  2 files changed, 14 insertions(+), 5 deletions(-)=0A=
>>=0A=
>> diff --git a/block/blk-core.c b/block/blk-core.c=0A=
>> index 492648c96992..4450d3c08f25 100644=0A=
>> --- a/block/blk-core.c=0A=
>> +++ b/block/blk-core.c=0A=
>> @@ -813,18 +813,14 @@ unsigned int blk_plug_queued_count(struct=0A=
>> request_queue *q)=0A=
>>  =0A=
>>  void blk_init_request_from_bio(struct request *req, struct bio *bio)=0A=
>>  {=0A=
>> -	struct io_context *ioc =3D current->io_context;=0A=
>> -=0A=
>>  	if (bio->bi_opf & REQ_RAHEAD)=0A=
>>  		req->cmd_flags |=3D REQ_FAILFAST_MASK;=0A=
>>  =0A=
>>  	req->__sector =3D bio->bi_iter.bi_sector;=0A=
>>  	if (ioprio_valid(bio_prio(bio)))=0A=
>>  		req->ioprio =3D bio_prio(bio);=0A=
>> -	else if (ioc)=0A=
>> -		req->ioprio =3D ioc->ioprio;=0A=
>>  	else=0A=
>> -		req->ioprio =3D IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);=0A=
>> +		req->ioprio =3D get_current_ioprio();=0A=
>>  	req->write_hint =3D bio->bi_write_hint;=0A=
>>  	blk_rq_bio_prep(req->q, req, bio);=0A=
>>  }=0A=
>> diff --git a/include/linux/ioprio.h b/include/linux/ioprio.h=0A=
>> index 9e30ed6443db..e9bfe6972aed 100644=0A=
>> --- a/include/linux/ioprio.h=0A=
>> +++ b/include/linux/ioprio.h=0A=
>> @@ -70,6 +70,19 @@ static inline int task_nice_ioclass(struct=0A=
>> task_struct *task)=0A=
>>  		return IOPRIO_CLASS_BE;=0A=
>>  }=0A=
>>  =0A=
>> +/*=0A=
>> + * If the calling process has set an I/O priority, use that.=0A=
>> Otherwise, return=0A=
>> + * the default I/O priority.=0A=
>> + */=0A=
>> +static inline int get_current_ioprio(void)=0A=
>> +{=0A=
>> +	struct io_context *ioc =3D current->io_context;=0A=
>> +=0A=
>> +	if (ioc)=0A=
>> +		return ioc->ioprio;=0A=
>> +	return IOPRIO_PRIO_VALUE(IOPRIO_CLASS_NONE, 0);=0A=
> =0A=
> Shouldn't this be IOPRIO_PRIO_VALUE(IOPRIO_CLASS_BE, IOPRIO_NORM) to be=
=0A=
> consistent with patch 3?=0A=
=0A=
I do not think so. The effective I/O priority used in the case of NONE/0 is=
=0A=
determined by the scheduler. See the use of task_nice_ioprio() and=0A=
task_nice_ioclass() in cfq and bfq. So using NONE/0 is correct here I think=
.=0A=
Using BE/NORM would render all ioprio_valid() tests useless as BE/NORM is a=
=0A=
valid I/O priority.=0A=
=0A=
Thinking more of it now, I think patch 3 should actually return by default=
=0A=
IOPRIO_PRIO_VALUE(task_nice_ioprio(), task_nice_ioclass()) rather than BE/N=
ORM=0A=
as this value is only valid if (1) cfq or bfq are in use AND (2) the task=
=0A=
scheduling priority and nice values are the default.=0A=
=0A=
In any case, I am dropping patch 3 as suggested by Christoph. We can try to=
=0A=
revisit this later making sure in the process that user land does not break=
 (if=0A=
that is at all possible).=0A=
=0A=
Best regards.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
