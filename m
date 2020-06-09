Return-Path: <SRS0=iQ6z=7W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E899EC433DF
	for <linux-block@archiver.kernel.org>; Tue,  9 Jun 2020 00:00:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBA5120801
	for <linux-block@archiver.kernel.org>; Tue,  9 Jun 2020 00:00:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="du+aQSTi";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="oFbE4iD4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgFIAAl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:00:41 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:33775 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731752AbgFIAAf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jun 2020 20:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591660836; x=1623196836;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ERtaMgP1oo0S2OBx/YSiH65PxBFkpsSszpmiv1Ps0as=;
  b=du+aQSTiSTC+r0OfaNWn5CYIa4m43SU+pqtMLH7/dDgAi7MXeP29Ropi
   yT3YsA/h/ubHYKJO7BZhSvQtlvdkQypBvq8yZZr3xTdofxsNZW3AgruOM
   asbkQPkrgUzcKuqqfc8iIxoBlxajamgPtnaDxrMJgppVf0z5l7q0hRDyJ
   Wsgi+tFcDJ7MrFrUXv14smt+9MrKB6helorukCm502Qzcm5oFFuQOb3/j
   8cjbEdJ1df3yCzeTs4fveVAcNE/ZAYnvjmjc58N6eGi9AzXuP6ujYcwKj
   62B8ATDmjjzavZxWtzlUNDGbNcroXsbFqN20qxfWVQumrKT6rNUlqUV3f
   Q==;
IronPort-SDR: 3Mr/7pmvvkU2zyAfsEhjo8WTlR+ucCIP8HuvFBzzgcZ4eY4dq60VLvEoL0BIC2Ziyw/K1wL4rB
 t48Jko5Z/5kuIxk2E9llJi2wVizGifpqQu70TERg76sb+rsoYaw2Pf+z/uI9Nsu8Hu+DPlfFtO
 J2cW7BeC7QOPqY7+TEKbOXkGvZjnZ7tLlp7JXnU6V5U/RHuX68qtjoAf/YKQn90SIVD9+5IcgA
 ebecBVN+3zZHmN3yK3ZIB7dD5syFWaTlNWqGaUE5TYqzjAiExqjCRyOQEWdpW3BFaad+X53PAZ
 rcU=
X-IronPort-AV: E=Sophos;i="5.73,489,1583164800"; 
   d="scan'208";a="140910882"
Received: from mail-co1nam04lp2056.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.56])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jun 2020 08:00:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPDw0Y61UHCTQn17SkzL7OEUH1MpPAJ34+nd4X715j98F/1CxZlss0xCcAaHK2o67rLqJoATQgpr2yzN5ygXk9Wmsk1eWfEb49++XnCqv4MBfmpfCILZzRV5HXELqAfHaoOg1JfwmepbGEYzPFBAE77cl826Vcz7BZnsAm5FCGy7EpSiqv0ZZf98deKiVnyZidxhXvPVAiriDaTb7sj4ANOw2f0mqkJURXzx9SXBcA0JDIeYLX5uVbEy12JzRkiAZ/Q6pdBs2eSQ4kbM0gdQPkL5vcA1kXJ2tLWNsRsb74vvUk3u5bve9ad2+aIXRZd6veCuDayH3HFH4Yh1bx70AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5ARtJoUQrvtk9ADRPYCWLcpdsjPIXaQeezWZHDxsy4=;
 b=JolRU/vs8RNElR/JYf8Kqsjs+peRAbOo5bLnEmsq5YG5GdtqyZlgWhEpP+4MvtBs5rmzbpWt+0YQI7FHcyLXMZPPntaz8kisB7juMbNrb3HluaZgMZ7lJj+gEwtYsZkVjfqtGaoZVRt2bjIrT0fz4+R7iTZlpXTPWL1Fi9YHUKxnkcOeOqVZdS68o1mXbboc+qsLodEC2Vps5BY9+chvVC8eHJ5n/nqxl9h3b+IN82UPr47yjcbQfhLNjfRmK1+7iTBgKqC5priJT6eKrGoAjTHcH+tQWaV4Bbm97lozft2wCKDEPMXfcYOxEQWtg8oxTqx3YoGna1eGGY0nCG+bbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M5ARtJoUQrvtk9ADRPYCWLcpdsjPIXaQeezWZHDxsy4=;
 b=oFbE4iD4Ntx56U8IR1avzhDWWqlt9btB6NGIgCWt9ul63SjA2hzFKe/J8LsLtN6N6jhJJKUI/bd5VTksfGNnUuqDt1QBfQWQGPJt58GBLOrWK3hZj+l06hOpkEbTx+IqhqQxQdu6FfW85JfpVBpOX1quyeWeAVhyOUJHskB2W7M=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4518.namprd04.prod.outlook.com (2603:10b6:a03:5b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18; Tue, 9 Jun
 2020 00:00:32 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.023; Tue, 9 Jun 2020
 00:00:32 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
CC:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blktrace: put bounds on BLKTRACESETUP buf_size and buf_nr
Thread-Topic: [PATCH] blktrace: put bounds on BLKTRACESETUP buf_size and
 buf_nr
Thread-Index: AQHWOjNJLSEx3mlm6Eunc+X8pDtzsQ==
Date:   Tue, 9 Jun 2020 00:00:32 +0000
Message-ID: <BYAPR04MB49650B5DBED285893ADE45A586820@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200604054434.216698-1-harshadshirwadkar@gmail.com>
 <49a4c410-6d42-46b3-adde-1d0a8fc6b594@acm.org>
 <CAD+ocbzdh0eq+wBQ-DqUUw_Gvwc0xv-FbBUNS0aZfpn+eToUEg@mail.gmail.com>
 <8787ab94-4573-56d4-2e59-0adbaa979c4f@acm.org>
 <BYAPR04MB496523AEF4C84B7BA2D2680486850@BYAPR04MB4965.namprd04.prod.outlook.com>
 <35a5f5a7-770e-1cbe-10a3-118591b64f29@acm.org>
 <BYAPR04MB4965D2A36AE58C4519DBD77A86850@BYAPR04MB4965.namprd04.prod.outlook.com>
 <CAD+ocbygDJgeAPXodAOLcWJL6SmNxF-AhE=yMCYJU7QyQRgOww@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9846e00e-70ce-4c8b-166f-08d80c0820f8
x-ms-traffictypediagnostic: BYAPR04MB4518:
x-microsoft-antispam-prvs: <BYAPR04MB4518AF1FEB57593ECD7F4E4F86820@BYAPR04MB4518.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 042957ACD7
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ed3lyNWxEuC02O5p2q7x0Glrg4kAW502wwzYaCkma5D1H7GEFyRASmxv3ZdIAaPwPlOWXSuockxEGvORbdkvpsRXPeICFANJ1puqGgKJh0p1ghTGLgKFLFy3YuVR71gK8RFbOjXN4UyNRddRnDIhgE7qlHCLlOZvBWadOkaRJ1FAZZrqkOcbDtQDfawwnPyuG/r9NufEuR7W1UeiC14C7VQj1DE/LOGOU94nstyqOH3BzltzH6P0fD3pTVpK1WSaZrCLu1l/6cefrs+KKO0uEh7H6fGX8s7bdOuioOb8oNW7zbsjz/6iPLgcPYrrO8oKyEnCO62ziLcIA/+vZoAwJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(396003)(39860400002)(376002)(136003)(71200400001)(54906003)(2906002)(316002)(26005)(6506007)(5660300002)(186003)(55016002)(76116006)(6916009)(9686003)(64756008)(66446008)(66946007)(53546011)(66556008)(66476007)(52536014)(7696005)(8676002)(33656002)(478600001)(4326008)(4744005)(86362001)(83380400001)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: VxxBG7+PsACDTH9GhVI+hdWx3ifuqtO7hTt72PXjqt4dTUBMhFi1suKbuJPqSwRmC80DXm919TTACbPHC4WBfNO+mR8Okt3BbZMJ8QEckmSB0dBp+8V4EpWn6xoFRrrPtSa1JkVxC84vm5fAxpFU+zvBxLKMgZ5guBV2Aq4W9kC856ToA6kZ/gCLArzPc6KM8y6iAXFiWT6x7oQiIi2XHjl+JXP94y1VJzIqw+61Tt4UAesNLbL2tUhxdAAQM3vpPTZq3jY61taUv88h4QrMAJiSdLGaLxcG/ps7+2X1pgKTvrrL1LhHZI51sjBOV2yVWlHM5B7vbuIxEWcOwLdkwJaIVd3Zt+TQ8VUkKJiUcJakI8+tlydWuxDIhkAOk2fEWDBwAY5v8FeiE+OXx9pspIM1n7l91cgFS/Hs0NQ8Gu8GQDBo14guSb1YSPWFe47kJdU+bVyRV4b39nU2X2bWQpwgwFpkJBSQU8bZBXO5YFf31McRnGzZsPzB8CQcbnQs
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9846e00e-70ce-4c8b-166f-08d80c0820f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2020 00:00:32.4426
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Jet3cX0IPCxVMuY/qkMO80l81As+SWiA/wuFShXN7sBiPW9+CO7OVinLAj6jh+g/o4hNQbvh2vMNffj1kgncicP3/r6VH2aFde0akODCJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4518
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/8/20 4:40 PM, harshad shirwadkar wrote:=0A=
>  From what I understand, there's no alternative to having a fix in the=0A=
> kernel. That's because, if the kernel is not fixed and only the=0A=
> commonly used user-space apps are fixed, I can always write a new=0A=
> program to break the kernel. So, as mentioned above, maybe we can make=0A=
> these limits configurable via sysfs but we'll need these bound checks=0A=
> in the kernel.=0A=
=0A=
Okay, thanks for the explanation.=0A=
