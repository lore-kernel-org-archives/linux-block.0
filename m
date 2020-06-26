Return-Path: <SRS0=+Sn3=AH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E5F4C433DF
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 00:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 179812075D
	for <linux-block@archiver.kernel.org>; Fri, 26 Jun 2020 00:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="q/cINmuG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WuGX7RoH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgFZAD0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jun 2020 20:03:26 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:28087 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgFZAD0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jun 2020 20:03:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593129806; x=1624665806;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=qWHLUPU7VlvfXCj7Az3PELwm7YHNsuy1iPc8P0eXU64=;
  b=q/cINmuGKJT5rNOclWUckb2L1TVkvnYCIapEn4vYNCnOz0E+vxFOgxhh
   j0lzLTE5XjNT9047W1rFJ/L+3hUx/gXAlFRAeASzNxfJc9YXr5/xoxeiN
   yu3ciEBwmqviMz79YlKZhoxR479xRf+2ObF+mwwzsgFp0Dz6yrQPZHcI5
   F07Gr6xEJsLVJfBsooupKXGZ0yF1JLEh6dY7p75yXrAz/JysnxbPCKv5E
   kN0TxPIHUYlXcdQD6203V/ll4l7Df8mJYKpUGzWe4WJrCywuLTnIvt4Yj
   xeIF2lOgzfAx2FnINM2Pj+FEcgoBbhNs4bc6+RzVVO6xA9UBdqlp7QnlC
   w==;
IronPort-SDR: C0oICe3DWO7u6D6wXpFCGH4gtMsNoL5GmJmZ4B7DZwu29Fam+kobqiBFD6iOsEA8GbuSnkHp8e
 MvyAAalahUgJmcxU5RzPrZt2VaiTBTk4HVElPtHsG1SftwBNCkpTQgrYWXrIm542nKajSCA2qq
 keiRyTQdOHIwMpFQxdCF9gZ4R9UZc5dkLhjiHFB1u3BdH5uYj3u4uMA+rUPSmio+0Y1x9l7npU
 yVxJoCiqkjACfbrmuq2xAsHN2+NRyy7X5M4jMUBWpWLYTcSMBQ3S/5wtAtXuxEKVznpH+76py5
 nak=
X-IronPort-AV: E=Sophos;i="5.75,281,1589212800"; 
   d="scan'208";a="141191995"
Received: from mail-co1nam11lp2174.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.174])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jun 2020 08:03:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nYXht2hurvY+8gmBRhpYAgMcJ0KC51vp7hCiJVeLAWXgmsJY4VpQIPKYgSBTTo5Ai0Wi9I6icRhvM9bQh0/kOJY66u3IE4pFA8HABdvbOJzjVwvp/4dR1ibBEpJCRdnqRtDd/ypI2W6zFcsttIpt8OILh/W8OKeRD9/IeYPXBAEfh7gdaS6rgNHiT0iFuGZkMz+ZWsiPEtCe2zTovE/m5bG3fzqSE5IKr5YSwxmbpZi78sDRaDXoz4ij+ad/PZ73dk2KTqK7ct23Z/I9uv35sFNZVdaoI36jTLiURB37u2qnBtZWKK5g+pvxgiCpgiRaxlcSnThfdXf2FN1ybg0Vzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hdz+Fi3UVdFvKI/vit3dmNse7TJNsTqPDS3gFpHBLg=;
 b=W5/CZctxmkzjAEryfryzArTxvFThlpcPFqRO10C00BKwWaJAVKUJfcEQvXleAc8/VYOJKv/2xii9jYvPSFzB8CASLVgoVD0SUjeBQVQB4T+FujLM4ubvPlfFYJRmh2/BgrfzMAjc7iAJqmWpOa+2c/GwlAisayFmNytA3Z9POMeyXih8f0ZdiGqtpwr13b9W7uLwTfUYHUc9YNHj19oNdJRa8twE8EU7I0b6L6x+0tU4ypxwYJcU+yPUCFR6/Qj5dOhzcs3IpK7csTipZdZqmvdn0mvmG63ENbbkiReFnJ9gce4ZtAAeMOTg1GFlg8FdvBjXpt+xKDFr3pXEOUOJ5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/hdz+Fi3UVdFvKI/vit3dmNse7TJNsTqPDS3gFpHBLg=;
 b=WuGX7RoH2QVXj3m3ygKRK+irqcuhRlZVALu13fbVycIV+HcYwOUwh+mg4OBjRmeYjg68h/PsHu0W0ygVaD6xwhegwg006Lne1sUZ1aiFyNFoAtOXak61Gjcky8yTKSEVoAKeUofExKi2ePXgHacxe5B/+jZQs33EZ9XDxTrZf1o=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4039.namprd04.prod.outlook.com (2603:10b6:a02:ab::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Fri, 26 Jun
 2020 00:03:22 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3131.020; Fri, 26 Jun 2020
 00:03:22 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH] blktrace: Provide event for request merging
Thread-Topic: [PATCH] blktrace: Provide event for request merging
Thread-Index: AQHWRLAMNttH7JUaU0CGzcROGKdTgw==
Date:   Fri, 26 Jun 2020 00:03:22 +0000
Message-ID: <BYAPR04MB4965F7EDDE0D7B0CBB9F5B6086930@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200617135823.980-1-jack@suse.cz>
 <20200625195148.GA24389@quack2.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6ff62830-c84d-46d8-ccde-08d819645786
x-ms-traffictypediagnostic: BYAPR04MB4039:
x-microsoft-antispam-prvs: <BYAPR04MB40399F3329334EBE31FE783B86930@BYAPR04MB4039.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0446F0FCE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gi7QANajK8Ipdj9HQAgb6MhOf2Ajju3Rfz6MWItoxKxfpXneEV4qO4aO/41m0V6+KNGt4lMTn0Ic6Lv2/pfnDHg7rpusdOSV5CusFnB5VPs1w1qATf0yQKzW1pIkXc0igiuy0193od9yufV2O63LxjrYPw5zqkE08CCSzdCC4N2gmycpHyLk5Xc9bLr0bh/gySyoukGUvCy8PaJ7A5JtXufQrEyv9UWvEvC8QlCXIDGgZThIEAkc1KSGwNpK/KcURa7P+5eMLoFI31hoUJx9JqUtM6J3yKY2DZZIamFAShF3aAuiZ7OfwjwzhfxEuSZXxTq8BAqS5olWhwCVFHfVRPOlISFSu7niPLr4FU4+U1oDFJ3/G9iKfl1fxVKcFVSoPDuoLf+++Avh7H56a0U22YwLHjQH8d1g8SfkaqX2zkIHhJx1xy7kwEr/uBA/Y88eKuQ/dTdnVn8xCDY2qaDAPA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39850400004)(366004)(346002)(376002)(136003)(396003)(83380400001)(478600001)(76116006)(66946007)(64756008)(5660300002)(2906002)(66556008)(66476007)(66446008)(71200400001)(33656002)(55016002)(4326008)(9686003)(26005)(86362001)(316002)(186003)(966005)(8676002)(7696005)(54906003)(6506007)(53546011)(110136005)(52536014)(8936002)(6606295002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: CKIGW3gjD07gZsp0PrZ2fUwpXlsW2mTdKZ8AUG7d1GS3UOqUHUI460Svoe6yUWmBHjfEfADurCqFz1vN8D1Qc4e+bzCM8dLm0jZvxRudOiMn234pFrzVxUlBhxtsyrOx+xq8Py8o/p4L+UGwhat4KUcod53PJKi5qElmRqyPb8cFC7Fz2WIHNtmiFdUIyBLX5+TUfZFWq6ndid8BnlSImX+Dn4KHJlvmcYz+hSjzBl6DwsV9w80SA7vqlBWQBu0458PxJcxox0ccDiv5rnof+iZKw7iKnxBxSYSy4f6wPKyzRMAUVIHSqPblraeBOn5iXU0JeSysk7tNNuHw1z62/UICL4XBr4eH2z/lOY/8zBZBVH30LShUk5YszafNdtFBx6nssnRDqn9QAMfuUQYIqedcxPmdAMmRiUir1YJ5X44XR5BQQ4ZMPj15FTAdRYBxtTwDv1vscCdKAfD+hoygHUI3yk3KN9NgCImOdGYfLUw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ff62830-c84d-46d8-ccde-08d819645786
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2020 00:03:22.7402
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RheQrCl2ikTd6Di3jcVuCVIacc0Ma37bWMy3jlxz5rf7bs9sKPKi3W2jsEuqDnUCLxvb2RbQYfqCFvLd/97Ch60SxVDUImJe8zXCV5JaDfM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4039
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jan and Jens=0A=
On 6/25/20 12:51 PM, Jan Kara wrote:=0A=
> On Wed 17-06-20 15:58:23, Jan Kara wrote:=0A=
>> Currently blk-mq does not report any event when two requests get merged=
=0A=
>> in the elevator. This then results in difficult to understand sequence=
=0A=
>> of events like:=0A=
>>=0A=
>> ...=0A=
>>    8,0   34     1579     0.608765271  2718  I  WS 215023504 + 40 [dbench=
]=0A=
>>    8,0   34     1584     0.609184613  2719  A  WS 215023544 + 56 <- (8,4=
) 2160568=0A=
>>    8,0   34     1585     0.609184850  2719  Q  WS 215023544 + 56 [dbench=
]=0A=
>>    8,0   34     1586     0.609188524  2719  G  WS 215023544 + 56 [dbench=
]=0A=
>>    8,0    3      602     0.609684162   773  D  WS 215023504 + 96 [kworke=
r/3:1H]=0A=
>>    8,0   34     1591     0.609843593     0  C  WS 215023504 + 96 [0]=0A=
>>=0A=
>> and you can only guess (after quite some headscratching since the above=
=0A=
>> excerpt is intermixed with a lot of other IO) that request 215023544+56=
=0A=
>> got merged to request 215023504+40. Provide proper event for request=0A=
>> merging like we used to do in the legacy block layer.=0A=
>>=0A=
>> Signed-off-by: Jan Kara<jack@suse.cz>=0A=
> Jens, it seems people are fine with this patch in the end. Can you please=
=0A=
> merge it? Thanks!=0A=
> =0A=
=0A=
I'm sending blktrace cleanup based on the discussion [1], if you guys =0A=
want I can also add this patch and keep Jan Author and have cleanup done=0A=
with this patch included separtely.=0A=
=0A=
Please let me know that is not accepted I'll send my series separately.=0A=
=0A=
[1] https://marc.info/?l=3Dlinux-block&m=3D159296928424805&w=3D2=0A=
> 			=0A=
=0A=
