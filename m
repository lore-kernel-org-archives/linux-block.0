Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0285C433E0
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 00:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B90EA22EBF
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 00:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390588AbhASADs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jan 2021 19:03:48 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:37312 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390500AbhASADo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jan 2021 19:03:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611015660; x=1642551660;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=1m+d636XtLxRoxG2CDJh8lHnU6PrdbGhTT97oaj/FQ8=;
  b=dt6u6yBjeywCSSB+mQbXrERvIWPHlN959QPIlqlAOXxcb4PTT1UjecUY
   o5hXX3W3o1+LH0Ka52+svgURIBHjDG+9LkvB0rYsHuJqoJBWoqH4XR4J+
   PDHyZWrnD68p5Qg+l5AxuNLW2QjV7FNLCo14VfCz9c3WORrJOrhcSa01E
   /QAUPvW5a7oMTXUs/fN20g7bJFfVGtaylkvOd7TKyVZcjM+kypiXZ0Wbd
   9YUEYFTZp+Dg+2nfsm4Z+fmoE8IGSx7AbWz6mrdJh6TG9YghxaBuY77z9
   pOAQ/HAcwSO7/fo30c0Q90ykzip9yUFybnn70E22hzLVlmQ9gskNLQPYO
   Q==;
IronPort-SDR: 3kytadyBBHmFGtkPPcaCyIsG6j63TGEU0m8IToIBaDe1qQC30qZfkJDWdfxJkQ3VX6abizmDL6
 pMT5YvL1iJA0yl7caSTow/LAQrOf7joawAW2EKVj1d5srErGw/oZpBfw9HpY2vrXDNummUALhR
 rYOK1qRxo77JUrB8+5URidQZfDXUqp0g+L2cPlrVcHTxyQx5ycVNJvh6nERiDbAOvLBEm5l0/n
 ndEzFCCucXxxJlNLNhpMTwo3xfuzQN3WUrzPDWLzf2LVG3lYABVmF+w4K8+x/j/lQiKpjK3Dl7
 OVA=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="261701279"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 08:19:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XgVONU09WmqsBymRoH1GbA2Jua0p8XiYAWDeEOTu4HkrzXCSmAZzJBHo7LWQQ2P1qeI7UrMeF1WfDEfyqREYo5hjqFih43ExMcFcfQaR9v+4AFWwCijvJwoOj8pHykPbhhrF3gVFJqBFk1xi9R7h1mxuSbYRCtaSVzUMy+lqn3PCpP7UkH1U1XMpFVzDeOVDWLeQn23/5yqczJJWF/ifwFTD0WluaK7GFp3s59gsya9mUER+jEURy9DdfefSlyQ3f3ycOOmDQ4YWHMF0GSMjWLnrdJfOiHcgxNZGrZclMZ2A6I6LNkvlm4oV3iWSNRDQO1ruixFyebqWNgJz8LUgdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FMsz5t4cYvMaIhggzTWdGifSEHIq5QT3NynPLs9pL8=;
 b=dDUaPI+X1+t7SDx118Ed7r7rm/jOO1nl/s33NHb+84Ny9I/XioTzfWecTLayffU0p6aq/xHhrM+1WlN7kF3VyMbyFPW73U6JnYITJQH6ja8s9HghArB8cvvTBONuf40mQQhLGcHkQHv8q/diDN3o+7Yl8jzhdwKmKIpQrSWCxyBF3AzrSaDbdhvmq1Ie94aOYguLmptNkLGda9tfQnuBoFPWRz9ZwrFn2rpMpjLCmYdg1vwuw0NnQk15Jm78MUULEuy+AJxP9Fjgq5bKTOgHPU4l4oOoQJkBvpupPUNu0XVgK0kua78Hddoz+ER2oBSouX4p9BvtE8ndcTMAy3472w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FMsz5t4cYvMaIhggzTWdGifSEHIq5QT3NynPLs9pL8=;
 b=CykjQLQKB8uI41+L30NM3eBXEG63qCjpD82itu3tyd0/ZUdDEOIOAEUDC0KcHV9o67l309EZHmRR8eDqNUyHXaopcik7pX/DrwImNHAGoN4vh/xdM/ylZ1Qpw909ebQPgIEQDS0+TAXGlA6i1157Po36NBVOCeoQ1urEc8pu1FA=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4529.namprd04.prod.outlook.com (2603:10b6:208:4b::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.14; Tue, 19 Jan
 2021 00:02:35 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%8]) with mapi id 15.20.3763.014; Tue, 19 Jan 2021
 00:02:35 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V9 4/9] nvmet: add ZBD over ZNS backend support
Thread-Topic: [PATCH V9 4/9] nvmet: add ZBD over ZNS backend support
Thread-Index: AQHW6Jsz5Um6YbJoj0ev+CR8KYF1Aw==
Date:   Tue, 19 Jan 2021 00:02:35 +0000
Message-ID: <BL0PR04MB6514A9C41525B7514AE129C5E7A30@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
 <20210112042623.6316-5-chaitanya.kulkarni@wdc.com>
 <20210112074805.GA24443@lst.de>
 <BL0PR04MB65145CE93F2AAF66158A3D71E7AA0@BL0PR04MB6514.namprd04.prod.outlook.com>
 <20210118182515.GC11082@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:65ee:945c:c1cd:2690]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d7400678-3334-4d87-d055-08d8bc0d86c6
x-ms-traffictypediagnostic: BL0PR04MB4529:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB45298AC1B35F42F7702D22CDE7A30@BL0PR04MB4529.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TU2CdH0LwMDY3eRDwlyZx4jY41PvRAiI3QGXfAEZMDSrt451dHvx+JCu0EmTVDl8zuIKQTk8F7WH7fyMd3WDTbdCwV4GFQL7XrMYFa54nNBti+n61gqIPgRNapqQibK+yYClNMlrQAlRhNbJ/fr9PasO9b/vSshBDvJIboi0YJW3D1mwbfNBD1zi42vJBRo0hdze1RwZaQ2b3freH+I1AZrKJG8ln9NdGgaZoMXpOnsgkHkkBYJDMxAJLkpFWPr9Hsj7nk0tYdEG5OelW0wbD1iP4g5Hplz6ldv8fplJBGtyCJBpif1pkjKjc2+AYbm+TivVEmmV9QQjAMQ/Nr+Dn80fOdhNqOIkxmSSpDEFGftiS5KxbjRgetDlopN3moHeqFLQhbNX2t2zoKsJ/SWtt6VqKqw8cmuB3KoOkKE1nG0BVMeUujJsVS08dKCZ2DIZ6+6J/+6sJA6fA2Mk+Tb0i0LFwMZHJuXZjknlw0jLS1rAei21VxdZ+USzA4dMEAHKYtqhjtxO83ACXgsPGrbV9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(53546011)(6506007)(71200400001)(64756008)(7696005)(186003)(55016002)(5660300002)(4744005)(54906003)(478600001)(4326008)(8676002)(8936002)(316002)(52536014)(9686003)(2906002)(66446008)(6916009)(66946007)(86362001)(83380400001)(66556008)(91956017)(66476007)(33656002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?koi8-u?Q?ZZwGfn3qF1DBWL7tGSF2qCFbl9NlfgM023EzI4+hePUAXvTWVE932dtdSNgtyl?=
 =?koi8-u?Q?cwgOn0AmxQzVMJooOpfeA/IjNtBACrV8A2hDK+jtGIPHVP2MBD7r9TNM3X8oZO?=
 =?koi8-u?Q?blK34lH2pAr1CZVOfzUijgKZjXa2IWIkIlID44vZ/KFOhihH3XtSZoHoVJGq8+?=
 =?koi8-u?Q?hnXVOSI/ktvEM5qyQ/CpOAjEygpT3GbKqAL3F3ILvsEMKVthUL4ex1Z+jY1zgE?=
 =?koi8-u?Q?glcHQWlCiBUjZjaTT2QR4SLypiHdGcmZ3sATrc0WiXR1MvmfFTNGY+u3e3jv7X?=
 =?koi8-u?Q?YH4tKq8bf8lR8wlDwxautakrz441Q3BFcRc7zYC/hflVH1CIdNJruSO4V4UCQE?=
 =?koi8-u?Q?lyODPJBTNZ9RN2giWmp+m5HwFK5xYB7CdDN9CzC0s8MMQd5sum9EVwM9yhIFBd?=
 =?koi8-u?Q?/5yR8Eum/PD/244aRwJCzX6iCDU6rF7bBQeXNaY+OtinQ3UTistKS31xgzZqFM?=
 =?koi8-u?Q?Nv70aGRBw4wzGSIuawKZgTZwnoKQjwoeOYbasM05SCJzUREVAO87XeK0aPbmZc?=
 =?koi8-u?Q?vzcKrRm0fHCNLXLtwsBL02RwqrlfpFXoffNtKHmIzuMm8Ec3zXzwDeYn9nLy9r?=
 =?koi8-u?Q?wjBvp7OuJNCfNeq0vzEBgbbTstt83W9jmKGsFLrhvT0rxYQXxRW4+KSx/dEYUk?=
 =?koi8-u?Q?UYGrqFGZ9/6E7fgducWhgmrJ4wTeUpSFzMD1yhMgDkUlHvWdBpYInadJYZcMxa?=
 =?koi8-u?Q?KtCc6tW8jK4ByTSa8jXgLM37H1cMqpajRBmUlo8PYgR62A9O2B0jLb/CIGztry?=
 =?koi8-u?Q?aOlWwwYgZT438sPwfYvkIrFTvbVRtbjiR0rFudhrN6TKhORBc3+h187ms0fyQB?=
 =?koi8-u?Q?zGrbk4HnwWKLO50G5Pzpiyyriv+GGtQl0dsfWZci/lZfaNxMewAzcYNFAmsmBL?=
 =?koi8-u?Q?RQnUCnhCkeREcy1ucF3nqsd6COQ3QBHvABJsTWHMSOQbeVyXKWvFjy1xatA/yl?=
 =?koi8-u?Q?MTrLoMTsemoKQPKhhDNRE3c1XGlVu9QhBSpt8cK0RU710FecznrwO5DFfHySj3?=
 =?koi8-u?Q?ZsH0bZCsyZpgnc0sVLTphafW+hEimxj8fTyOteeHyn8QLifk/8LkBO1/G+vPw0?=
 =?koi8-u?Q?FhkARHuf9SCUoiOfn3MLy0hx4MVUclP4Gw22e+TELQpe1N3pknFMkJM+qA=3D?=
 =?koi8-u?Q?=3D?=
Content-Type: text/plain; charset="koi8-u"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7400678-3334-4d87-d055-08d8bc0d86c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 00:02:35.3473
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6jUFYNpqVSLDjQbyryDcAbm/23vMv6V9ExfI/DoJ8J+hKrt8yuj1PPCkMBLyFp39foXZT+CGr/etIHRdYNIaiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4529
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/01/19 3:25, Christoph Hellwig wrote:=0A=
> On Tue, Jan 12, 2021 at 07:52:27AM +0000, Damien Le Moal wrote:=0A=
>>>=0A=
>>> I do not understand the logic here, given that NVMe does not have=0A=
>>> conventional zones.=0A=
>>=0A=
>> 512e SAS & SATA SMR drives (512B logical, 4K physical) are a big thing, =
and for=0A=
>> these, all writes in sequential zones must be 4K aligned. So I suggested=
 to=0A=
>> Chaitanya to simply use the physical block size as the LBA size for the =
target=0A=
>> to avoid weird IO errors that would not make sense in ZNS/NVMe world (e.=
g. 512B=0A=
>> aligned write requests failing).=0A=
> =0A=
> But in NVMe the physical block size exposes the atomic write unit, which=
=0A=
> could be way too large.  =B6f we want to do this cleanly we need to expos=
e=0A=
> a minimum sequential zone write alignment value in the block layer.=0A=
> =0A=
=0A=
OK, good point. I think I can cook something like that today.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
