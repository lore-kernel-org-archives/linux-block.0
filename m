Return-Path: <SRS0=q4M6=7R=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BC63C433DF
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 07:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEA15206DC
	for <linux-block@archiver.kernel.org>; Thu,  4 Jun 2020 07:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aM2i3JB2";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Au54IFKa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726364AbgFDHKo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Jun 2020 03:10:44 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:56804 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgFDHKn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Jun 2020 03:10:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591254662; x=1622790662;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=/WbtNaRGFX/6xF8+1iKy4hKHxW0PDQmaJOk8xlO5b38=;
  b=aM2i3JB2ifQHc2KIMAu2TVgqla2qLKMx05+Q/vVkfGGGmcabB63wTg2H
   wIf5dO+xrwQbdVRlJW9VMCaYKPKfRCZ6KyXjptsgbomU5OFtvkmzWaBG6
   lLrnd0TVW5SE3BBg/dVw3jBMV3QJNtFtD/p/ocr/omTR1LzSfYjt2CzlE
   h8uLsZItKwzxWjCiztYhiALho/vGbwGn9Bk7JI55BVfc3udvXEzmcbY7A
   BpO8zfHbe3Z7+0lIpSQD5zFj+SFFHUugF6o6ITLD+w8wyTVmZbrL0MMp4
   pxsecKU0uYASdl9gWXeEKTVMaHA7P9FPyXIC7F7QzIoi3An7YzyHk8udH
   Q==;
IronPort-SDR: gsFOQBMiGT6b5d61/azd46fPUxBBq0vyosmh+Gt2YiWdAXYS4BywPUe6ygtamCc4J8Sn6JTwbo
 7F/fuK9I50L7ALxNXzlHfjwklnn3oAbWss6r0v1TAzKi62SyPzM1uV8YoEcc51+2Io2UmWruvm
 Fwssto9ji8/DSjxumJ8n/6Cf+7tx3DNOC1Sle8fWwEs19T+QRsJqwm0/3UJmoNOMTHRG/6iwXY
 x9SDV0fJgNOwOdmOZgQ3pfrajvHmmE9dDB2HdO6Xx4evmB9dIP30HmTnnuTAB6H+k0Qup1lvLG
 juk=
X-IronPort-AV: E=Sophos;i="5.73,471,1583164800"; 
   d="scan'208";a="242048979"
Received: from mail-bl2nam02lp2056.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.56])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jun 2020 15:11:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C+Y2uGNSfeT+82kY3PyOjDFeZ86jDs2/kgJAfOHgkfDWDonpvUhHf2WYzSuuaZVIEZxeLRdI9ddWgXZmW3Kv22F2N0D6nvvTF12MG/YBWB7Bui5YJpL6e5EsnjbJE06ur6lio03BPNy2ylGpMLpl1rohiobC33td4QxkRPdvJh6YO1ahTkjnS8yf1gC4WluxtnN1Nk/isGUoejdBqGBYKHjeYNVr6i+6gM7knLJUT4h9pHdWQTf9lckwryKvIRjCvUuO6MnYYL34NKb7eMVbc9cNEdjPNf5XaR1EIGL9LwBnJRrDXfTu82RG7W9/YyFcglgme4PSdLOCiwYXoh8HbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIqXDnI4bQa/bv+KrWA7zcDth8QJtFusx6F6aEZaHT4=;
 b=Yyt/CKEEaH+Uv6qs1yXGAGisf3hVL763KUB0gmytDMhFG0kanxMHB99Z6lGl6znuQSqcbIlA4wi8ehCFRDeoiQAC+OD/VVqQLDP5xf+uARCb1Y9dfbwX0kSH5aKJruJc5hR7vy+Dk+LukWye8UGwJlls5vBl1B9svfvj1ZmyfTfPzQnb9RRxNCgGxexaR4D9Zac0ejVoO3o7GCUDC+DrAasW8liz6kP70qP5YL/rWA3+9+Cg4HFFBVv7KGE3pFA8Uwbm/IPmpcMpvD5GfWRd9hzBj2L/a3E19DhEQFRhVcrRk4rI6q2uQyiUafnJxbKlYnCwTrBEF0R+AEd6PZ3/4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vIqXDnI4bQa/bv+KrWA7zcDth8QJtFusx6F6aEZaHT4=;
 b=Au54IFKaK63Vz8Gbc09OF3f0B0WV1m5XREyqyUWTFOmQ3RXCy6/tBs+qoHV+NGlcmRikDM+fLF7K1xYD5cIx37Yhp/het3oRxtzVBwiNpk4NI++BI1/GHM4e3U0p+lJmwJLZV12SySraLGPYbAmANctFN1oaLJdBdPJxe7+vPPw=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6023.namprd04.prod.outlook.com (2603:10b6:a03:e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Thu, 4 Jun
 2020 07:10:41 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.018; Thu, 4 Jun 2020
 07:10:41 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blktrace: put bounds on BLKTRACESETUP buf_size and buf_nr
Thread-Topic: [PATCH] blktrace: put bounds on BLKTRACESETUP buf_size and
 buf_nr
Thread-Index: AQHWOjNJLSEx3mlm6Eunc+X8pDtzsQ==
Date:   Thu, 4 Jun 2020 07:10:41 +0000
Message-ID: <BYAPR04MB49657DD3AC2B7E7F4496BF6486890@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200604054434.216698-1-harshadshirwadkar@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 648d28fe-1b50-404f-fefb-08d808566415
x-ms-traffictypediagnostic: BYAPR04MB6023:
x-microsoft-antispam-prvs: <BYAPR04MB6023EA41BCA0C9B0F8BCB41086890@BYAPR04MB6023.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 04244E0DC5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GNOoe+k90H0/9vRnV+21lhy0bPEwjAM8NmQRUM3CbBYX7asgg4Tm45rYVJE2uDTFoIgF5Gsa7tNZ1DX/Bwm/BagxjCFy9yEdjnMEXYwAWY+z9SaEx4j66fOgsW33dF4nqrJnDLU3dP5vQ89OVRXWLIGnFCKikk/TnA5EzMfrh/rT1htT41xG+dYpdxXQ3QpyoGDiIc/Wl1WKCg9/hY6gkr8cvE4+dDd1Ja7hlUAeZ6q704Cy+DMmpIhBhK5g2ait9dVQino1McocDj7/PB68rMrBvpWs+BBSKvv5/2q/Vr750BNX7Wo+SyggIHRJREKFc1jA6r1uoPe0utfer5uiOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(346002)(396003)(136003)(39860400002)(33656002)(76116006)(66946007)(478600001)(8676002)(5660300002)(8936002)(52536014)(55016002)(66476007)(64756008)(66556008)(66446008)(83380400001)(86362001)(110136005)(9686003)(53546011)(186003)(316002)(2906002)(7696005)(71200400001)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 20knY9oz9rtgsbStCBHNQPvaE4sFVphurHdmo4Xmx2Wp7A5LyYGHMfvjZCb9Wi7k/DweRkmsAdn6dAou/QKKTmMoceThyYPLHwdmxVo1C+mlJeds2ZdaXgsoqIflSapn6tqNAaAs70yZ6ddL61whj6LucY0e3O5fhFxRz9m2px+7cnFRyfdR1ay6vA/n6rAY0ZQ671xoVKz6rLxtHuWVTn8+uPTNzxWkmTMYljflRY2oslWXhfJunhjCDc43psWWOj31oWQDl7Wsw5NtwcL3/6ImhDA/XtxDwE8p04lri9p5jFrVh8W+Djtu/XL9D7COLw/viKCi4sXi8QnVnJG8PirNmLY5u72w3QCp4gKpZOIqmaGmLQQmsz+VCxyjWxyoI7RPNtLNTV0WWlHxVoLceMIUc5KUIVXGvOrReLrTogMeKeL/fyQWf7fabrlEiIdLMhDIKcA6mvx3KnKoXQS+akKWEIOtkehu/jK/lhM5I38=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 648d28fe-1b50-404f-fefb-08d808566415
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jun 2020 07:10:41.0708
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M3mffU16FZq4wcvFRnIIXkK65OagwIG3PhyF2C0nS+2nZl2oZl6JbgxaLNKjZngpJ68HlcFRs/TTo9F3kuaRIPwJgrVBYtsHNhcaB+x2alI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6023
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/3/20 10:45 PM, Harshad Shirwadkar wrote:=0A=
> Make sure that user requested memory via BLKTRACESETUP is within=0A=
> bounds. This can be easily exploited by setting really large values=0A=
> for buf_size and buf_nr in BLKTRACESETUP ioctl.=0A=
> =0A=
> blktrace program has following hardcoded values for bufsize and bufnr:=0A=
> BUF_SIZE=3D(512 * 1024)=0A=
> BUF_NR=3D(4)=0A=
> =0A=
> We add buffer to this and define the upper bound to be as follows:=0A=
> BUF_SIZE=3D(1024 * 1024)=0A=
> BUF_NR=3D(16)=0A=
> =0A=
Aren't these values should be system dependent to start with?=0A=
I wonder what are the side effects of having hard-coded values ?=0A=
> This is very easy to exploit. Setting buf_size / buf_nr in userspace=0A=
> program to big values make kernel go oom.  Verified that the fix makes=0A=
> BLKTRACESETUP return -E2BIG if the buf_size * buf_nr crosses the upper=0A=
> bound.=0A=
> =0A=
> Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>=0A=
> ---=0A=
>   include/uapi/linux/blktrace_api.h | 3 +++=0A=
>   kernel/trace/blktrace.c           | 3 +++=0A=
>   2 files changed, 6 insertions(+)=0A=
> =0A=
> diff --git a/include/uapi/linux/blktrace_api.h b/include/uapi/linux/blktr=
ace_api.h=0A=
> index 690621b610e5..4d9dc44a83f9 100644=0A=
> --- a/include/uapi/linux/blktrace_api.h=0A=
> +++ b/include/uapi/linux/blktrace_api.h=0A=
> @@ -129,6 +129,9 @@ enum {=0A=
>   };=0A=
>   =0A=
>   #define BLKTRACE_BDEV_SIZE	32=0A=
> +#define BLKTRACE_MAX_BUFSIZ	(1024 * 1024)=0A=
> +#define BLKTRACE_MAX_BUFNR	16=0A=
> +#define BLKTRACE_MAX_ALLOC	((BLKTRACE_MAX_BUFNR) * (BLKTRACE_MAX_BUFNR))=
=0A=
>   =0A=
This is an API change and should be reflected to kernel & userspace =0A=
tools. One way of doing it is to remove BUF_SIZE and BUF_NR and sync=0A=
kernel header with userspace blktrace_api.h.=0A=
=0A=
>   /*=0A=
>    * User setup structure passed with BLKTRACESETUP=0A=
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c=0A=
> index ea47f2084087..b3b0a8164c05 100644=0A=
> --- a/kernel/trace/blktrace.c=0A=
> +++ b/kernel/trace/blktrace.c=0A=
> @@ -482,6 +482,9 @@ static int do_blk_trace_setup(struct request_queue *q=
, char *name, dev_t dev,=0A=
>   	if (!buts->buf_size || !buts->buf_nr)=0A=
>   		return -EINVAL;=0A=
>   =0A=
> +	if (buts->buf_size * buts->buf_nr > BLKTRACE_MAX_ALLOC)=0A=
> +		return -E2BIG;=0A=
> +=0A=
=0A=
On the other hand we can easily get rid of the kernel part by moving =0A=
this check into user space tools, this will minimize the change diff and =
=0A=
we will still have sane behavior.=0A=
=0A=
What about something like this (completely untested/not compiled) :-=0A=
=0A=
diff --git a/blktrace.c b/blktrace.c=0A=
index d0d271f..d6a9f39 100644=0A=
--- a/blktrace.c=0A=
+++ b/blktrace.c=0A=
@@ -2247,6 +2247,9 @@ static int handle_args(int argc, char *argv[])=0A=
         if (net_mode =3D=3D Net_client && net_setup_addr())=0A=
                 return 1;=0A=
=0A=
+       /* Check for unsually large numbers for buffers */=0A=
+       if (buf_size * buf_nr > BLKTRACE_MAX_ALLOC)=0A=
+               return -E2BIG;=0A=
         /*=0A=
          * Set up for appropriate PFD handler based upon output name.=0A=
          */=0A=
=0A=
>   	if (!blk_debugfs_root)=0A=
>   		return -ENOENT;=0A=
>   =0A=
> =0A=
=0A=
