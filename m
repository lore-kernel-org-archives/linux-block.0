Return-Path: <SRS0=ouS0=TC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2960EC43219
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 03:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDC122081C
	for <linux-block@archiver.kernel.org>; Thu,  2 May 2019 03:48:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="WMnAr0Y4";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DuO/S+eF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfEBDsI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 23:48:08 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:29906 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbfEBDsI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 23:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556768887; x=1588304887;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=8AQ9L64aUgedxAtwH+xYNvpnx3z1lHluxnSnPZZ+zAA=;
  b=WMnAr0Y4Zsaycaho89oBm7NvC3uVFUw/6JJZP66G2d2vzAHPudVu3yq7
   Pp1WKlT6q9Ndj9c2EYOjsI24piIZh5pYdpiT88sW9oTO/nbAI6lmoH+zC
   kMNf/9FWzVA2KzwiJgBGfFoXZ+CvNAhgfTn7t4TG6e1eYagpEp4nTDyMl
   xN3cMX9/bgwqBdhlkC7/sLU+vYB0BTaqf3zqcSYF9ej1Hn3qdQGs+dR1y
   Z47kB8zRlpthjWvYQfhZv1Tq5A1caA8C5vWSH3jrBBE+LBWGX5+n4swoo
   qAsVtEEPoogfokw3HudH/Kwl1D6Pm4GxarQiqwSE+fOWaGO1vDsgdZQrP
   w==;
X-IronPort-AV: E=Sophos;i="5.60,420,1549900800"; 
   d="scan'208";a="107317476"
Received: from mail-co1nam05lp2057.outbound.protection.outlook.com (HELO NAM05-CO1-obe.outbound.protection.outlook.com) ([104.47.48.57])
  by ob1.hgst.iphmx.com with ESMTP; 02 May 2019 11:48:06 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8loyQDDQAHgttTqBzTfPKVSalPGthLmZQi5Ec2eDkQ=;
 b=DuO/S+eFWOMQBU23don1dseoichwy1WGG4oJYXli52Mvbp8BWTwgxTgjIxOw9J8HW/5K9P7WL9t03M1DoYQZkr7ap8o/cIfNnjx8wTfs/uSy6oQPy1YlEcfIR86U9I3NQL0oAjmXKQfm9jUH/w/JmU8N33EL9BNFX4p/jqobQPU=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB3824.namprd04.prod.outlook.com (52.135.81.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.10; Thu, 2 May 2019 03:48:04 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974%5]) with mapi id 15.20.1835.018; Thu, 2 May 2019
 03:48:04 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Jeff Moyer <jmoyer@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [RFC PATCH 02/18] blktrace: add more definitions for BLK_TC_ACT
Thread-Topic: [RFC PATCH 02/18] blktrace: add more definitions for BLK_TC_ACT
Thread-Index: AQHU/9ZflYOKr2HcfEmIiXJzp7+3Bg==
Date:   Thu, 2 May 2019 03:48:04 +0000
Message-ID: <SN6PR04MB4527EAAA4A15EA59EB8134D786340@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
 <20190501042831.5313-3-chaitanya.kulkarni@wdc.com>
 <20190501123104.GA17987@infradead.org>
 <x49sgtyxrhv.fsf@segfault.boston.devel.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f947814-e141-4989-0695-08d6ceb0fb8b
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB3824;
x-ms-traffictypediagnostic: SN6PR04MB3824:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB3824C447316AF6CABE2E851D86340@SN6PR04MB3824.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0025434D2D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(396003)(136003)(376002)(346002)(51914003)(199004)(189003)(6246003)(81166006)(53936002)(8676002)(91956017)(81156014)(55016002)(71190400001)(229853002)(478600001)(71200400001)(6436002)(25786009)(9686003)(5660300002)(66066001)(66946007)(73956011)(4326008)(52536014)(76116006)(8936002)(68736007)(66476007)(186003)(110136005)(66556008)(2906002)(86362001)(102836004)(99286004)(316002)(26005)(33656002)(7696005)(72206003)(7736002)(53546011)(74316002)(76176011)(305945005)(6506007)(256004)(66446008)(64756008)(14454004)(6116002)(3846002)(486006)(476003)(446003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB3824;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: cHif/uVG0tvBnsoh5JPBLOO7Zn/8QriWR6nYNTcsAvzwD+d8a0EgOT/YPC7CCMgfCar8eU6/yqWLvcbP2YOWwkH3vTHjSa/K9frBITmBfWZ/tU03ICMpQ+43KRJ/1xYstrr30Vry4Z1yBAW7g+NyY/9UgQArg57SKDKRkvkHjpd21yBLxgtf59nPkNSYk6gR9no13PeCZlU33YQpGWkLlBLSfKmKqHpiYzq4Av1mZfL/7T2RxQujhMHkCT5D8DFn7ZHV9Q8im0NRQlq9YTLEVSSxMAbZkym7xnZ5ujwwp6web+GSD7H7vSYGdNBSLtm2TsSUCrY/unJms0QSG6KL+59LTJ6CffTTHxeYkgpvK9HLYCitwhru9lceIHJGrqcczFti4zcXXgcDAkPn6B7a+mTnI1eyk4cUcY4w2nLQZu0=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f947814-e141-4989-0695-08d6ceb0fb8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2019 03:48:04.7601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3824
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks for the reply Jeff.=0A=
=0A=
On 5/1/19 5:56 AM, Jeff Moyer wrote:=0A=
> Christoph Hellwig <hch@infradead.org> writes:=0A=
> =0A=
>> On Tue, Apr 30, 2019 at 09:28:15PM -0700, Chaitanya Kulkarni wrote:=0A=
>>> @@ -104,7 +120,12 @@ struct blk_io_trace {=0A=
>>>   	__u64 time;		/* in nanoseconds */=0A=
>>>   	__u64 sector;		/* disk offset */=0A=
>>>   	__u32 bytes;		/* transfer length */=0A=
>>> +=0A=
>>> +#ifdef CONFIG_BLKTRACE_EXT=0A=
>>> +	__u64 action;		/* what happened */=0A=
>>> +#else=0A=
>>>   	__u32 action;		/* what happened */=0A=
>>> +#endif /* CONFIG_BLKTRACE_EXT */=0A=
>>=0A=
>> You can't use CONFIG_ symbols in UAPI headers, as userspace=0A=
>> applications won't set it.  You also can't ever change the layout of an=
=0A=
>> existing structure in UAPI headers in not backward compatible way.=0A=
> =0A=
> Right.  The blk_io_trace->magic has the lower 8 bits reserved for a=0A=
> version number which is checked by userspace.  There's no way to=0A=
> negotiate a supported version between userspace and the kernel,=0A=
> unfortunately.  The version number is checked for each trace event.=0A=
> =0A=
> What you *could* do is to add another trace event with a higher version=
=0A=
> number that includes only the extra data.  So each event would be split=
=0A=
> into two: the original event with original content and the new event=0A=
> that only contains the new fields.  That way the old userspace would=0A=
> continue to work, as it would discard the trace events it doesn't=0A=
> recognize.  Newer userspace could handle both types of events, and merge=
=0A=
> them back together.=0A=
> =0A=
> There would be a ton of warnings spewed on stderr, unfortunately, but it=
=0A=
> would at least work.  I don't see a lot of value in the kernel config=0A=
> option, no matter which way we go with this.=0A=
>=0A=
As you have mentioned this approach will have a lot of stderr, I was =0A=
trying to avoid this scenario. If everyone is okay with this will make =0A=
this change and resend the series.=0A=
=0A=
> -Jeff=0A=
> =0A=
=0A=
=0A=
