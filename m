Return-Path: <SRS0=Mrne=CG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9235C433E6
	for <linux-block@archiver.kernel.org>; Fri, 28 Aug 2020 10:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD1F0208FE
	for <linux-block@archiver.kernel.org>; Fri, 28 Aug 2020 10:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Yr6uAPwB";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VBAAEN1h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728218AbgH1K3Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Aug 2020 06:29:25 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:62179 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbgH1K3V (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Aug 2020 06:29:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1598610559; x=1630146559;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=YTNLctFP4pX0DEZBklLe354sIUBZmCvqpepS+f6I0Zs=;
  b=Yr6uAPwB9Ow4Fom2CfN3iDGlP2stZYCnwhaxyFClCyZOXU7oPzrYdYoD
   MMHgI1qXYvg3v5TD8Wiix3/a+0yfG0k9niPz7d3ooUU2xQDUdmeKrTZF3
   vHj9nUY6sdWpt4IiXBhfVVIZE8sCNrtJQ3JayzPc/ftvGJCC1HG46GNHV
   e5EEiATXtTd9lVyAOUY7wyIO5CpS6cMnF39Bg17fJs8mQVpLqjQdbVS1y
   1Mqlu9NbqUVDQ1oNPMlilYKkzveeU6NQvGBlhcYxeYuAD56h+433wmUH0
   p3qe3rbHieUJ75TffAdhZpIn2IVdf4cugHR6Fm4PRn3U6oD3w7jYaTMYs
   Q==;
IronPort-SDR: ZGJPNbtI3I2Myj6BkEhxhGLDMgTOVzld9HMMjz06J4yWtdeSn3SmhVHBuh6miHu8BjvQcmu2jJ
 kTZkqa4RsYWkeIkMjxJoSKGo4IgM3p19v0eje1guJ24GAg++/WgcjgL5mrE6AydUsW7CWRzwQf
 P7WG+ijls8D+bAOux8w9FoqoQTLsmKrkR+eoiVhRU8uuEGg8TYyo3X2oQms9wLPYBo0/cOrWGw
 f72/x+Zd7U5uHD18PutFweaU2WITGDUJeh269L6U3ViNMkVh1mgSdXERAoHRM2cos9bZvHQGCO
 Y5o=
X-IronPort-AV: E=Sophos;i="5.76,363,1592841600"; 
   d="scan'208";a="145993125"
Received: from mail-bn8nam11lp2170.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.170])
  by ob1.hgst.iphmx.com with ESMTP; 28 Aug 2020 18:29:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L57ppxyUJQ1wz8heEvd0K2bkAICE4tyvyGZBSHRI8M9kqRa2HitQl7vCyPpnRLSUQ948AHoNs8SwebRhPjRSxupXl7Mwroad9w6CNNa5gXc8fuCF3Z6ockYNaWf+npWiCmDb/LlJw0SOXnmddTDqrKJGQHmTXdjIGvIuLj23v2XWDd/0PxIP2/5v5Os+3wA3LDFqgDUM5yjs7fKDXzk6NFfh4V1ceA4F0F5m7HAAQbRHWlKEpLlezDRQsGpzuImCQ2LBsKUUwqrxscv00y6hTS30CbMacjB7awb+xVBGli9DAZp1hYRkP1XOigq0WmdmXLJylx6tTdUiF8Gwh2A8lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTNLctFP4pX0DEZBklLe354sIUBZmCvqpepS+f6I0Zs=;
 b=aP8DFL+wWYXoISNnXw40zm1iIpqwzENGBvE5MQyMH7ip21bQ3d59mt5dW3GnY+cyHxvcb5dxfGuqYjxzIcDo7uAQM+Z0sUyOcKjBwwn2xSKzZF95KYPCtLDyEsqc0ZBGBVaP6ZVuthxLZYvNzQPn7/1fFUv+L16nj6iNKbbUdpHH8+7mFiM/LtraL+mLpx/95A2B7ofgm8IHIRkbKJcg8NxjEtci2h6IGp/ImSm0VSiiGrVMhkd2bf05i4lvHjDgdgdEjSg5sbHD8daJVDm/mhXDb16cgryJvmDFtJjsK/rI/2WkTLlHOXX3s1uzERv+Zq4wF7BVgM9zvyY3354Xnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTNLctFP4pX0DEZBklLe354sIUBZmCvqpepS+f6I0Zs=;
 b=VBAAEN1hwBNTp+evJWvpxOkWgbXc3bSXkdiDGNeYekMoJ7lUeq70M9/V+U8z9s5k1ZIhCf/bSszlqfM0iaoUg0m7lAiVZbDeK8CEq4apYdiJjSpG5DMvhhWpzsHJe1FF2FnCQBvDOZhHn0lbdXL9BkMuRpNMuv6p7Xyxge/wNy4=
Received: from CY4PR04MB3751.namprd04.prod.outlook.com (2603:10b6:903:ec::14)
 by CY4PR0401MB3633.namprd04.prod.outlook.com (2603:10b6:910:94::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Fri, 28 Aug
 2020 10:29:18 +0000
Received: from CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2]) by CY4PR04MB3751.namprd04.prod.outlook.com
 ([fe80::7d15:9936:4b3b:f8a2%12]) with mapi id 15.20.3305.032; Fri, 28 Aug
 2020 10:29:18 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Niklas Cassel <Niklas.Cassel@wdc.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] null_blk: add support for max open/active zone limit
 for zoned devices
Thread-Topic: [PATCH v2] null_blk: add support for max open/active zone limit
 for zoned devices
Thread-Index: AQHWfHkH+20N/yg19E+BQ9ptEBewKg==
Date:   Fri, 28 Aug 2020 10:29:17 +0000
Message-ID: <CY4PR04MB375160276B09E980D1B1158AE7520@CY4PR04MB3751.namprd04.prod.outlook.com>
References: <20200827135018.63644-1-niklas.cassel@wdc.com>
 <CY4PR04MB3751526DC5833902749EBE48E7520@CY4PR04MB3751.namprd04.prod.outlook.com>
 <20200828100655.GA71979@localhost.localdomain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:1cf:fa0c:32f2:7362]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0fd13f0d-85a3-4d5a-e645-08d84b3d382c
x-ms-traffictypediagnostic: CY4PR0401MB3633:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR0401MB363314AACEB451F828939A32E7520@CY4PR0401MB3633.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g/xAWQtDtEivOU5YbrXxOmyRBfoKTIaVuxhQVG32gauYQyXjvf/3ZeekOSRXlhR9aCY5oRqk8IWxqLj1G+vncVkfvn4e5+U3rFPwPhfLLoTtjUqQc3MmLXm2IkUgt4gQNo64Ky3BHj1fASotvu+SPGf1X5w+n9BZd1/ZLOCMsWlVSV/UQT0IUHgmJdAf30pVNT2+IUmXt8bF0tM7XkKryxyM/Pbf0hBQgrv7QQrMGyp5F3fDUiCdzcWTmQWKxgO9N6NNs9wuDsq/usD1mXNHgcuKLALeQmCjWXMQw/fle5i3i8qP5s6mIHfy3LRhZ6fPyfwWNZEzb2yMAHfzArHkRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR04MB3751.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(2906002)(8676002)(66446008)(86362001)(66476007)(8936002)(91956017)(33656002)(66946007)(83380400001)(64756008)(9686003)(66556008)(76116006)(55016002)(71200400001)(186003)(6862004)(6506007)(54906003)(6636002)(5660300002)(478600001)(53546011)(52536014)(4326008)(316002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 9t/zuncCSbSAshPTVdBffbbA4H8mUj2WB4WyMBzFg/XxZUgM+9eCAoFj4DQ2jaMPAoLAFmwTTBi6Dw6Pb6jXS9OFHVstoyylpH1olWhSNqSUjwdWvZqkNeFRohOwE5BepY9cW/7YhrrWJtkKeMAn08tJ34O+rh6GBF3yZG51IL0d9uJTGsA83xEJmybLWmi7eU6kifSSQNrvML8iSCWmqaT4O11Crs1ph/LhQe6tZXWvQSR9/sE/x5IIjeEoUOAn53mb2grs+DNR/kHMFQU15+n0WkQu0p2dJifX3USjiet5XM4ml6KTiUFykKi97wi0sznEbQv9aVGH9sEy8hYCZgiyhrp+oxynmfL5Iqm6I/uGqgt4NdVG+CJYyhyntQjsCcm1hpOXQyf71H70Fv2q0CVRQQCKugHP3Yn1DeRS2wa44N91tBlamZUDR4CF6H1rUvfJ59r1j0sa+p5RwOjeBYj4MJ4DBxnveluI+dXcBIglKgU0oiXZ3ImmyCeH6NiD5wPHq1MxT6+1ExLw2cSzOUmP7XutX++FNkAaBKQKgv4ePnn8ik4/hRd+i8BFht8t4jPeUTwkCPxJsgDXg/rj5C+hSUEiQlBqht3ii2vexDbp4OPmmdk6Jm8sxJXLflY1ivxmAntgw3aP3piUOOQrL8ZLVaRmhxblR2vmR+Pf3CQz9jPztVlM+Al44pyRQgQXZ+QBab0wT9gkAsZRIfa7Kg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR04MB3751.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fd13f0d-85a3-4d5a-e645-08d84b3d382c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2020 10:29:17.9050
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1n+Xvy3wSeVtSbuRxVbh1sAIFKSFEQdZZ9CW4Parf5yIHn1xkYO7akIb2s4zML3FV6U1+QNlMzKf1dMIlJRJVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0401MB3633
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/08/28 19:06, Niklas Cassel wrote:=0A=
> On Fri, Aug 28, 2020 at 07:06:26AM +0000, Damien Le Moal wrote:=0A=
>> On 2020/08/27 22:50, Niklas Cassel wrote:=0A=
>>> Add support for user space to set a max open zone and a max active zone=
=0A=
>>> limit via configfs. By default, the default values are 0 =3D=3D no limi=
t.=0A=
>>>=0A=
>>> Call the block layer API functions used for exposing the configured=0A=
>>> limits to sysfs.=0A=
>>>=0A=
>>> Add accounting in null_blk_zoned so that these new limits are respected=
.=0A=
>>> Performing an operating that would exceed these limits results in a=0A=
>>=0A=
>> Performing a write operation that would result in exceeding these...=0A=
>>=0A=
>>> standard I/O error.=0A=
>>>=0A=
> =0A=
> It is not only a write operation, also e.g. open zone operation.=0A=
> However I will s/Performing an operating/Performing an operation/=0A=
> =0A=
>>> +/*=0A=
>>> + * This function matches the manage open zone resources function in th=
e ZBC standard,=0A=
>>> + * with the addition of max active zones support (added in the ZNS sta=
ndard).=0A=
>>> + *=0A=
>>> + * The function determines if a zone can transition to implicit open o=
r explicit open,=0A=
>>> + * while maintaining the max open zone (and max active zone) limit(s).=
 It may close an=0A=
>>> + * implicit open zone in order to make additional zone resources avail=
able.=0A=
>>> + *=0A=
>>> + * ZBC states that an implicit open zone shall be closed only if there=
 is not=0A=
>>> + * room within the open limit. However, with the addition of an active=
 limit,=0A=
>>> + * it is not certain that closing an implicit open zone will allow a n=
ew zone=0A=
>>> + * to be opened, since we might already be at the active limit capacit=
y.=0A=
>>> + */=0A=
>>> +static bool null_manage_zone_resources(struct nullb_device *dev, struc=
t blk_zone *zone)=0A=
>>=0A=
>> I still do not like the name. Since this return a bool, what about=0A=
>> null_has_zone_resources() ?=0A=
> =0A=
> I also don't like the name :)=0A=
> =0A=
> However, since the ZBC spec, in the descriptions of "Write operation, Fin=
ish=0A=
> operation, and Open operation", says that the "manage open zone resources=
"=0A=
> function must be called before each of these operations are performed,=0A=
> and that there is a section that defines how the "manage open zone resour=
ces"=0A=
> is defined, I was thinking that having a similar name would be of value.=
=0A=
> =0A=
> And I agree that it is weird that it returns a bool, but that is how it i=
s=0A=
> defined in the standard.=0A=
> =0A=
> Perhaps it should have exactly the same name as the standard, i.e.=0A=
> null_manage_open_zone_resources() ?=0A=
> =0A=
> However, if you don't think that there is any point of trying to have=0A=
> a similar name to the function in ZBC, then I will happily rename it :)=
=0A=
=0A=
Well, I prefer to prioritize code readability over following a not-so-good =
name=0A=
that the standard chose. The function description makes it clear that it is=
 zone=0A=
management a-la-ZBC, so a function name clarifying what is being checked is=
=0A=
better in my opinion. Not a blocker though. Feel free to chose what to do h=
ere.=0A=
=0A=
Cheers.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
