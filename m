Return-Path: <SRS0=bR5W=TJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD320C04AB1
	for <linux-block@archiver.kernel.org>; Thu,  9 May 2019 05:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F49620578
	for <linux-block@archiver.kernel.org>; Thu,  9 May 2019 05:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Kks6DIwP";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="MKmzLEbq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfEIFvm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 May 2019 01:51:42 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:57353 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbfEIFvm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 May 2019 01:51:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1557381101; x=1588917101;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=IhJAxN6mgT8IPYw3b82QbDmMSDWJiijA4EA4Sa+mG3I=;
  b=Kks6DIwPzW7y6zzkA5e7CY5oyq/V+3egGeYB7MMKOLFw72UWoMBG/gFD
   cK85x1mWpmke6C8DQ7653s8s0yWEVHcK5aqHq2yGtL9Zj/otDq4KhcSyl
   nhZY52IGcgVbOdXW5paawmRavr1hAsQvbG6QgUcBo75//0z9IDZvtBMNU
   hEKzgqPJsYG3wnMgy9HLFlOnWcqXmLf2Bmp5xH93wE2EuXESHHWc1nVGL
   W+AkO6DZo4hpPjaBUi9KXe1859bbF90d6Zy3YlxvdKVWv9HmQ7OMcw8+8
   8mhx5SCj/sVboLcNHEV/HdNzexHhxiNp9Juauj71j7uh5q2onAr8S3dDA
   w==;
X-IronPort-AV: E=Sophos;i="5.60,448,1549900800"; 
   d="scan'208";a="107861922"
Received: from mail-dm3nam05lp2050.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.50])
  by ob1.hgst.iphmx.com with ESMTP; 09 May 2019 13:51:40 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KwLzioC5hqtC/3ZGgmW1lAGhsRUq/PDHVoM851BrC4g=;
 b=MKmzLEbqTP8lAoZIFMF8k0G2EWnvGzBWj0TfMqUhPBUmJ6YeFhEgQia62Jjs4cfsWxLUxxoI2kb0zuPEAUsBGNB/Osw4UiApondKoV08HCrNuVwez2n81dLCXb02yZRDv9Gj/8V0ZHSIRJFm4IM9SsiewIcgRz/2vyjgMtiXe3w=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB3839.namprd04.prod.outlook.com (52.135.81.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1856.14; Thu, 9 May 2019 05:51:38 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::c4f:1604:178c:d974%5]) with mapi id 15.20.1856.012; Thu, 9 May 2019
 05:51:38 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Minwoo Im <minwoo.im.dev@gmail.com>
CC:     Omar Sandoval <osandov@osandov.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Keith Busch <keith.busch@intel.com>
Subject: Re: [PATCH 1/3] nvme: 002: fix nvmet pass data with loop
Thread-Topic: [PATCH 1/3] nvme: 002: fix nvmet pass data with loop
Thread-Index: AQHVA1Q6zH4CttIufkWRxlafayMhPw==
Date:   Thu, 9 May 2019 05:51:38 +0000
Message-ID: <SN6PR04MB4527510BF05DCBF27E0B6D2F86330@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190505150611.15776-1-minwoo.im.dev@gmail.com>
 <20190505150611.15776-2-minwoo.im.dev@gmail.com>
 <SN6PR04MB45274C423AA7C3CC3DBB5ED586300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <a66b775f-9a5f-fefc-ae29-c86678e66463@gmail.com>
 <SN6PR04MB45272BEB18B3ADD95DCB42AE86300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <cfa4d48d-ce13-0ace-cf5c-a3d0d1f4cca7@gmail.com>
 <SN6PR04MB4527FAD8076A5A5610F6B66786300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <c86fe09e-9964-123a-bc17-e9b9e6a80856@gmail.com>
 <SN6PR04MB45273CEE5FE1DDF38677980F86300@SN6PR04MB4527.namprd04.prod.outlook.com>
 <CAA7jztfU+AdUHp5xo8ssjgvXiBFBXJt0PyQTNA8VQU-T-SpKQA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [2605:e000:3e45:f500:eee9:536e:c194:4e76]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a5b32db-f531-496f-8f2f-08d6d4426780
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:SN6PR04MB3839;
x-ms-traffictypediagnostic: SN6PR04MB3839:
x-ms-exchange-purlcount: 2
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB3839096D446B966B987751FE86330@SN6PR04MB3839.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 003245E729
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(136003)(366004)(346002)(376002)(396003)(39860400002)(189003)(199004)(52314003)(46003)(478600001)(53936002)(5660300002)(72206003)(55016002)(966005)(9686003)(6436002)(68736007)(71200400001)(71190400001)(6306002)(256004)(14444005)(4326008)(14454004)(229853002)(6916009)(6246003)(25786009)(53546011)(6506007)(6116002)(91956017)(52536014)(73956011)(66476007)(66556008)(64756008)(66446008)(186003)(102836004)(486006)(76116006)(446003)(476003)(54906003)(7736002)(316002)(99286004)(7696005)(305945005)(2906002)(66946007)(74316002)(81156014)(8676002)(81166006)(8936002)(86362001)(33656002)(76176011);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB3839;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: m5+a/rZAbZI1hkt7CP3qtUgvOqrmcsUHjgGQbX/nOTU/UiuYaUnNx60AQgnBJ+KE4/GswLCUwwIoC4bSnVUx0YwKuc6tfrORku96DA1cN0bnty1OCJ5RwgzJmGYWjAIq9cCzwNLlVZbz9dZqHW3HRPf0OJGHO+CUeu0IaZiKcryDVEPSrXUsaF38rKV02P/9zX4iuK7OtJiGbccXRQvdedfEJYUFid3YU2V/ggY5PG4wAEe1wEDo5ul69nZExXtQtyLNLj+CrKLtpyDqvz1E/2plKpLTfsqPo10KX6X14GhVW+ZJpF0ic/b7kmx3HJAyeMXgmYH1VdAL5/6aGDSzpm5mD6CvImuaoxFJGKYnmCM7JaH/LDL2OP1d5R+sLobfmvAtqh2+5CT6TjmHS0XObeLtGniZHx4dh2D0iqDW1fM=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5b32db-f531-496f-8f2f-08d6d4426780
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2019 05:51:38.7621
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3839
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/6/19 4:24 PM, Minwoo Im wrote:=0A=
>>>> I wasn't clear enough.=0A=
>>>>=0A=
>>>> It doesn't check for the return value for now. What needs to happen is=
 :-=0A=
>>>>=0A=
>>>> 1. Get rid of the variable strings which are not part of the discovery=
=0A=
>>>>        log page entries such as Generation counter.=0A=
>>>> 2. Validate each log page entry content.=0A=
>>>=0A=
>>> Question again here.=0A=
>>> Do you mean that log page entry contents validation should be in bash=
=0A=
>>> level instead of *.out comparison?=0A=
>>=0A=
>> It has *out level comparison.=0A=
> =0A=
> I'm not sure I have got what you really meant.  Please correct me if I'm =
wrong=0A=
> here ;)=0A=
> =0A=
> First of all, removal of variable values in the result of the=0A=
> discovery get log page=0A=
> looks great to me also.  Maybe those variable values are able to be repla=
ced=0A=
> a fixed value like port does (replace port value via sed command to X).=
=0A=
> =0A=
> But, it also depends on the outout of the nvme-cli, not return value.=0A=
> Anyway, let's discuss about it with Keith also because he discussed it wi=
th me=0A=
> few weeks ago,I think.=0A=
> =0A=
>>>=0A=
>>>> 3. Check the return value.=0A=
>>>=0A=
>>> nvme-cli is currently returning value like:=0A=
>>>      > 0 :   failed with nvme status code (but the actual value may not=
 be=0A=
>>> the same with status)=0A=
>>>      =3D=3D 0 : done successfully=0A=
>>>      < 0 :   failed with -errno=0A=
>>>=0A=
>>> But, ( > 0) case may be removed from nvme-cli soon due to [1] discuss.=
=0A=
>>> Anyway, if nvme-cli is going to return 0 for both cases: success, error=
=0A=
>>> with nvme status, then test case is going to be hard to check the error=
=0A=
>>> status by a return value.=0A=
>>=0A=
>> This should not happen as it will break existing scripts which are=0A=
>> written on the top the nvme-cli in past few years.=0A=
> =0A=
> Agreed.  But, please refer the following comment below ;)=0A=
> =0A=
>>=0A=
>>     It should be with output string parsing which=0A=
>>> would be great if it's going to be commonized.=0A=
>>>=0A=
>> No, we cannot rely on the output string as this problem is a good exampl=
e.=0A=
>>=0A=
>> I'm not sure returning =3D=3D 0 for error case is a good idea. Checking=
=0A=
>> return value prevents us from writing unstable testcases which are bases=
=0A=
>> on the text output and allow us to modify tools as specification moves=
=0A=
>> forward.=0A=
> =0A=
> Please refer a discussion on https://github.com/linux-nvme/nvme-cli/pull/=
489=0A=
> Keith and I had a discussion about the return value of the program itself=
.=0A=
> The nvme status value is composed of 16 bits value, by the way, the actua=
l=0A=
> return value of the program is in 8bits(signed) which means it's not=0A=
> able to carry=0A=
> the actual nvme status value out of the program.=0A=
Isn't this unsigned ? as pointed out by Keith ?=0A=
=0A=
$ cat a.c=0A=
int main(void)=0A=
{=0A=
	return -1;=0A=
}=0A=
$ gcc a.c -o a=0A=
$ ./a=0A=
$ echo $?=0A=
255=0A=
=0A=
May be I'm missing something here ?=0A=
> =0A=
> If you have any idea about it, Please let me know.  By the way, I really =
do=0A=
> agree with what you mentioned about the return value.  If it's possible,=
=0A=
> I would like to too :)=0A=
=0A=
How about we instead of returning the NVMe Status we map the NVMe Status =
=0A=
of the program to the error code and in-turn return that error code ?=0A=
=0A=
The above is true only when command is successfully submitted from the=0A=
program i.e. no errno is set by any library calls and failed in the =0A=
completion queue entry with NVMe Status !=3D NVME_SC_SUCCESS.=0A=
=0A=
For your reference In kernel we already do this detailed mapping where :-=
=0A=
=0A=
1. Please refer to the drivers/nvme/target/core.c file where we map the=0A=
errno_to_nvme_status(), the reverse mapping of that function can be done =
=0A=
with nvme_status_to_errno(). Of course you will have to add more cases =0A=
and do in-detail reverse error mapping from NVMe status to errno and=0A=
return that errno.=0A=
2. nvme_error_status() we map NVMe Status to block layer status.=0A=
3. blk_status_to_errno() we map the block layer status to the errno.=0A=
=0A=
With the help of 1, 2 and 3 you can reverse map the NVMe Status to errno=0A=
and add that mapper function for nvme-cli which will be consistent with =0A=
the kernel NVMe status to errno mapping.=0A=
=0A=
Now you might find some cases where you cannot map all the status codes =0A=
to errno and for those default cases you may end up using something like =
=0A=
EIO, this is still better way than having to return 0.=0A=
> =0A=
>>=0A=
>>> [1] https://github.com/linux-nvme/nvme-cli/pull/492=0A=
>>>=0A=
>>=0A=
> =0A=
=0A=
