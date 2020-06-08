Return-Path: <SRS0=X1aF=7V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5C3C433DF
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 06:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0F022076A
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 06:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Qp4ZbMic";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="K1u7x+rS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgFHGm3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jun 2020 02:42:29 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:7773 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728785AbgFHGm2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jun 2020 02:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591598549; x=1623134549;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=GPvVZ0bXqojqRFs3FaKRH8YtiioJNr3FQc45FF2w5w0=;
  b=Qp4ZbMic553gm1GvDEIK1snIzfehBCyPLB3kV6kut2PB0/qwlkHtxYbj
   p/oO/LaOStk8KFTg3uK9p4zzc0NNyYwiGV9oQDKiEne5f+nbyDEZ/ZsuK
   FNhFtT2iTd5hRuM4eSibDqaicGY9JlJNaLOzZFUbT43ExIAz5ADJDrk3B
   VK3jrYsciqoroaigne6npiaXQ7sWz6KU/aBMkVX6xhsA9ninqH4KGT5ny
   siIpThO+1+eZYcUbQbY3GABVJ3tB4CC3bSDaQR+G9cxRPaCR9r6ox+sVX
   nzvtEmO9EVObyXBcePNf6KFCJ2iWztlxMNykjNcKyBg/g1NICwx3r9sIu
   w==;
IronPort-SDR: s6sBMKpEItbSkM7xwwSHajZ77CtB5Mser3ZeJf2n7X3llBUYkFmDOqKjJ42N+Wgku676NqGy9a
 Pmu4+4YTAq6+WRI6egqpYSuOiZhY/Nw1bobkrFY5Zy75M0rl1shokfSYNS1dfxBWcBCeJAftv+
 CQ4BU9gX4okThZM0Uwd56MfmjOk+hiXk7JI3W0pfFtU2aTwtoCwtLIHA4dnyZsp3g26YGL7ZII
 hw8gvgVKEwyoGPPMw2yNoMpBGKh5+ubpees8M0QlnKcut9pF1DE8LsKSgEhYpjpXSzykEO+EuI
 /p4=
X-IronPort-AV: E=Sophos;i="5.73,487,1583164800"; 
   d="scan'208";a="143749018"
Received: from mail-bn7nam10lp2107.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.107])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2020 14:42:28 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TdM+yAbwc8FNd+QWToarPvh4sqDbh3mrKKzNDy7r4PkR8lSs1yE+zhcQ2kIrBABhNSNCqVnfbyQKb2ivwQiSQSNuHkjVIdjcHYma7jbZZACehlL73ZuldmU1wSrdgdWeI4v9RKdsgfxjQcWxgzgXT7l0EbbT8DL0OSTV1ZbMLws84xKeUQMXXgdIyEtlT1VdmBellEQqqNM3TeZrEUHaoaSr1Yrf3WEhfvLjw2bqV2LAzTRk4monXPs4Qm/l4gEcfXOzwbHx8pzc40DSZUC1AB3mSqo+GbdRZRywFL0APzSQTbBLlnbepgybxlWW+hP/7MMC2TqmHXdZWlKvjUI/Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Eb/IA6Pzajc1WPD7gcrIK4TpOm/bv0mA3Ld2ZifE9E=;
 b=lsjgv1lQHHPlzpoPwxINI4H8FCddnu4XrsU/wcZlvHchEomekzb0icYDbYD2hk6ziKTlaw7Z/9Tn/mQFjo8LVKkG+d6XBsJMgYXRdS3bVMVOsAK1I6Jqwrax2Ul+SqQLgGeF++gLMqLbUPH1qBOCbj4YUfSZ4bRuYCdhuCpqIv1neS6x74b4lTp8C9NXjGy2CG9r5Dwn+/V4Q8L32xWj7wF+vGV4VNp2M4KzzOWm5wZWqAPkXUDiYL+S6AOHNTq1aKk00qlDHiK+ShvyNbkkuvu2N2W/JsLU1wFvGHpebcqOCEZfEmNF1XmaQJHwj5UD/pGP98b51P+VLdu0wj5sqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Eb/IA6Pzajc1WPD7gcrIK4TpOm/bv0mA3Ld2ZifE9E=;
 b=K1u7x+rS/wFLOmtcgW4s1zrFmWQabUsKUFVKXQFIp/S0AtjU9Y7+E81VXNJGA8G9jhGl2AgcHOK0bVKUxMpB7MGtGI1KCmvRy17qZOFA57t2EOiOYP84hlyES7hrK4UebkKkD6fB6sqIiXWVhfL7xkw8geXLienWvenQOZncUvo=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6104.namprd04.prod.outlook.com (2603:10b6:a03:eb::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Mon, 8 Jun
 2020 06:42:26 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 06:42:26 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
CC:     Bart Van Assche <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blktrace: put bounds on BLKTRACESETUP buf_size and buf_nr
Thread-Topic: [PATCH] blktrace: put bounds on BLKTRACESETUP buf_size and
 buf_nr
Thread-Index: AQHWOjNJLSEx3mlm6Eunc+X8pDtzsQ==
Date:   Mon, 8 Jun 2020 06:42:26 +0000
Message-ID: <BYAPR04MB4965A54BFB25EB875514BA9586850@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200604054434.216698-1-harshadshirwadkar@gmail.com>
 <49a4c410-6d42-46b3-adde-1d0a8fc6b594@acm.org>
 <CAD+ocbzdh0eq+wBQ-DqUUw_Gvwc0xv-FbBUNS0aZfpn+eToUEg@mail.gmail.com>
 <8787ab94-4573-56d4-2e59-0adbaa979c4f@acm.org>
 <CAD+ocbz+p9Yp5+JxQOUJJExVZeWRKQybn8wi0O23dYH30bUdvA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e66f642e-1557-4dba-fddd-08d80b771bc1
x-ms-traffictypediagnostic: BYAPR04MB6104:
x-microsoft-antispam-prvs: <BYAPR04MB6104436D061FF9BD2091ABA086850@BYAPR04MB6104.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 042857DBB5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0C+8SLh6osh9RsYOCutvE/06m6xKqOTBuLbUE3xJDDgbWnWel3jyfLwTPS5TcgRA/xoLiLfF8STPygVJJr+HDlvE6K57+Bget7Pw3Ql0dhAAPbVW8TP30wzA0pBi7V5cOcuv0ZOZy5sfjoPayXkj+pmf9maAeNCnTTkaN0qSYpuCWLrT7C1u/IAU2xPOhjpc4TfOoCtpE2ztRUJB/nj1WAS03V5eTVx0vcRes4NfHmI/C4/NT/dLFVWulxlUDRwHXbSqxFcnOBGPh4UUIIHcTshp9atiws8DcRljS/NVGrQ9VfYODNucxL1IkFKIlfK17EzrtGlI2BPLKVoi2oFJlw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(52536014)(26005)(8936002)(8676002)(4326008)(478600001)(54906003)(5660300002)(66446008)(66946007)(64756008)(71200400001)(66556008)(186003)(7696005)(66476007)(86362001)(55016002)(76116006)(6916009)(33656002)(83380400001)(2906002)(9686003)(316002)(6506007)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: SQSawaEinIQIgvyyPshUQ/S91s6E8shii0FBwO1LOCth1aQMGt+RGZ1EcyD+/dEywTirOpoC++LnBWEBXLVced0nA/lfSAcfi7nbNQt1rNHiXq3UcCSBK7WQIJ6ESu1eTfb8UVjYBmrQPzpqkfProJJqRLiYQFIeU5CgDVk86h0K/9TUUG+Po24wjh69e2HNShfCPYwfaoWbQZQdyzfXoBjGNVhJvjnJFaVd9ZYO4c1IZkth2MqRmAdad6/Hcuix6bEzVwoVzQ+WABBcBJ9PY3ZUKjWKsU7f34ircr4BoqtkizEp/L6ENswSvmgtQayNSwZvcdkOpKT9fvGa+AhapxlnF2XHAGx0zBaH3fdanxYGjId1Yov0Bqk038DtrdQ6A95fUsQ42P5NB709+MZkvApSJ2iacALkXLRA7q2chWm327IqlswOK5rEOnp5F5OH8JLkwiip3mEye9PTb5C6bXbk9RH/uZiJc56VzSLLSHE=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e66f642e-1557-4dba-fddd-08d80b771bc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 06:42:26.6747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hdx6dxFqTtzuoDK6c2ug5xxOFiIKWkvdUAiTellmCrl9v7GmX0bEC9DqTIsIdK9FPURbOlSmQtGDkGpoNY9xcwK+8pNCx8xgHPd1PUtMQ14=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6104
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Harshad,=0A=
=0A=
On 6/5/20 10:40 AM, harshad shirwadkar wrote:=0A=
> I see. But my worry is that if we don't check for bounds in the kernel=0A=
> in this case, a non-root user who has access to any block device (even=0A=
> a simple loop device) can make the kernel go out of memory.=0A=
> ---=0A=
> ...=0A=
> int main(int argc, char *argv[])=0A=
> {=0A=
>          struct blk_user_trace_setup buts;=0A=
>          int fd;=0A=
>          int ret;=0A=
> =0A=
>          fd =3D open(argv[1], O_RDONLY|O_NONBLOCK);=0A=
> =0A=
>          memset(&buts, 0, sizeof(buts));=0A=
>          buts.buf_size =3D ~0;=0A=
>          buts.buf_nr =3D 1;=0A=
>          buts.act_mask =3D 65535;=0A=
>          return ioctl(fd, BLKTRACESETUP, &buts);=0A=
> }=0A=
> ---=0A=
> =0A=
> I understand that introducing artificial hard-coded limits is probably=0A=
> not the best approach. However, not having a reasonable sanity=0A=
> checking on the IOCTL arguments, especially when the IOCTL itself=0A=
> doesn't require any special capability checks and the kernel uses=0A=
> those arguments almost as-is for allocating memory seems like a=0A=
> vulnerability that attackers can exploit.=0A=
=0A=
Yes this is a problem and needs to be fixed with keeping the backward=0A=
compatibility as per pointed out by Bart.=0A=
=0A=
I'm not aware of the applications (apart from blktrace-blkparse =0A=
userspace tools) which implement block trace userspace interface,=0A=
can you please point me to the application ?=0A=
=0A=
If so those needs to be fixed also than imposing hard limits in kernel.=0A=
