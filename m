Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC01C64ED6
	for <linux-block@archiver.kernel.org>; Mon, 27 Feb 2023 05:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjB0Flh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Feb 2023 00:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjB0Flg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Feb 2023 00:41:36 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070AC113FE
        for <linux-block@vger.kernel.org>; Sun, 26 Feb 2023 21:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1677476494; x=1709012494;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EvdSWmqxQSQYa7g51a2ylU8m32Y1qD1INPw6Kg+ZMQ0=;
  b=akcDnQLcwQf1G9KTgvLyyA16vK8X8UOKXW361QWPEvS1uCTQk/wlxafy
   93IY102oIGvguu6MiEJZM+Y5EAJB1N1T+dXIqLlfYpw5bWzayP70dinHu
   ++4qV35xszJ5qAlCvm5Z3Pr9m7GNgigZvpuimgfirzjoVXr6s73+aHxJX
   UTqHv05o2Q0//pNlCxBZ5l5N+X8cf5inQ0Bi+aG6pMm5tCKSTs94HCIUV
   oLjxpPtltbgxzQrlPJwE2Pzjooark41u0aCiJ3cuVgXHeDpE2oZiOn3/A
   CE2DoB4NWAq4lwJBfbNAsb6xZjkfvMhpj25pApJbFS+ugFcG0YPH/0wGc
   A==;
X-IronPort-AV: E=Sophos;i="5.97,331,1669046400"; 
   d="scan'208";a="222579184"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 27 Feb 2023 13:41:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mUojJgGF0+4sw4QkuoA28NG3dYdfZ+ImaXEc3e7w7d2dTCIzDy8pW4CFP91NKkzJUh1br3PFSKg6BCT7PSAjkK/tsB1QU18WGhhpTBAH+nj3gK0fjC2vyf5mWF4UOERLFVtFMaZrlmfc4Ng3Gnxqy2Z4LOhh3KK2NjynH4Hwn1KIQ3qqXzAkkBYbzt2ZFPJJNlw39ikHCXqo1PCbmKWlULTW04/N/OJn5ZAYyMTq/sWkcOV+bZxW4ZL8vVDgCQIWxsD4miWbXkqMChNW1DUYGsLsyiAV8/ydZLf/6/+pU/cCXG+2UDWj5sYQqprDV4INOHmSHi7EOFC9ropl1oUMyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAlvwMVgAbsOsKW46Ni88X0oNgJP5CtnKOft4vE7OFw=;
 b=DA2gY/RZFepdYfjPa9m9R9LLWVB3zaa2Vaa9Kt+0HLE5zJ2wxQHVEZ6QHiPU/0tA3pxjgyMM2t8h1H/0zwYtpp2N9P/vD//D7wCtx7p6cXlP1E+jH00rA4svmDUc+O7Mzg1iv020BP/v5zfDOrH6icAKTOLTjlMVzh6dCM+azgJjdOh0xQwXxHar4wlsXF91KP7398/3cuF16bH+d+mxY/LQjxaFx6jASn3+YGenexVk0l183Og0O7wdcLZ+yGYANrwDPEKiWeFMwoumM39ZLAUNGIpgPfaD1MoKEORJnP1f98rfL/6KbeBQLQTH4a73wmX2Su8jtTXFr2C8aDjJ7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAlvwMVgAbsOsKW46Ni88X0oNgJP5CtnKOft4vE7OFw=;
 b=mAc4ki5cRd3NObAyi56IYppVJtJf87azE4X51cvX/ue5gJBJp0g9F3DzSlumpnBV3E66Qy2J4aXr4mdAoG+Zy+mAanOTDZrCs2/fs+NdINEPNGpcbZBp3QDgBbUm0ycYGzeEfAMHMpm19bQcGf6D1p9BPF309OZrZskicC424P8=
Received: from BN0PR04MB8048.namprd04.prod.outlook.com (2603:10b6:408:15f::17)
 by SA0PR04MB7194.namprd04.prod.outlook.com (2603:10b6:806:e2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.24; Mon, 27 Feb
 2023 05:41:31 +0000
Received: from BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::bd47:12d6:4242:49f3]) by BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::bd47:12d6:4242:49f3%4]) with mapi id 15.20.6134.029; Mon, 27 Feb 2023
 05:41:30 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ziyang Zhang <ZiyangZhang@linux.alibaba.com>
CC:     Ming Lei <ming.lei@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v3 1/2] src: add mini ublk source code
Thread-Topic: [PATCH blktests v3 1/2] src: add mini ublk source code
Thread-Index: AQHZRN4GILFJJ+eZuUC9lhofX/G5Ya7dwCUAgAAKEICAADYNAIAEJJqAgAAtsAA=
Date:   Mon, 27 Feb 2023 05:41:30 +0000
Message-ID: <20230227054130.eygpm5e22yejug6t@shindev>
References: <20230220034649.1522978-1-ming.lei@redhat.com>
 <20230220034649.1522978-2-ming.lei@redhat.com>
 <a20a449a-73c1-c7dd-b100-89e346c35828@linux.alibaba.com>
 <Y/h1LQbf+brRw1mo@T590> <20230224114156.yxul4qb323pswteq@shindev>
 <f20ad4c4-fc74-0bea-a07d-8f6c8a028754@linux.alibaba.com>
In-Reply-To: <f20ad4c4-fc74-0bea-a07d-8f6c8a028754@linux.alibaba.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR04MB8048:EE_|SA0PR04MB7194:EE_
x-ms-office365-filtering-correlation-id: dbae0a77-24a0-456c-a30a-08db1885473c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tNu8l6a43mT9YQbJBnFrIV2jtwsquAbEQMdiw5WkFCqycw4teFBuVbR4hYIC2ptXtWhnr6gZdz3sNAUxfghefmczmLRB3yZ7uoZ9gLbK2gJDcnpqobSKjJRccd+5WtBqkIQdOdy1wwnAbdToX/ugB+oWf9JurxNe3Fq5Z02S6PGLulMj46caFR3t3a7bo2URRSRa6AHUINDt8vUq10I/fnaH0HbmGG38NzqxCgr8cIm8SNX//VtDtKpolOz9jOI9PWeBUNTvF9miaXW/OtpAVMN5nehWLPix/xOBlRbu/NdwKkaJGC3UcVabe/julBJPLEbXbrllnhjH/am63Ufgmk13HuHpmyjLhTBvdWecR+P6v5dfUsnJn7FoxJXKjrwke8xZv8hyoy5wIHItHnn+L+iCAoTOVwYv/z3Uf1ISIVUk9k+q6gcW2V6XopaF0zwprhZjodfSm8LK4lgFyLWeRBOGhtkkBohfQR76Frxy6ezoG2Q7370ekIddlfc1GN3f2J0KFfKaxdyMqyEDGjvMEKh4KHUfwYbJiBCIUIcJF9PUVHqO0jZ1+oGK7NV3V2VGbQtGUa4TVt8A4ra1b7r5f47u7SqAtGs/BGxulg7CkRVIMjcvHz0G2ducx94VFGXPqGkXKzoPp/bVwz0owhbpNPpVJ9BzkVrAgoEnkFIk8Vekk96CtIGy3UrkMqekVIe5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR04MB8048.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(346002)(136003)(376002)(366004)(396003)(39860400002)(451199018)(9686003)(76116006)(26005)(1076003)(53546011)(6506007)(6512007)(186003)(2906002)(41300700001)(38100700002)(66556008)(38070700005)(66446008)(8676002)(122000001)(5660300002)(66946007)(6916009)(82960400001)(8936002)(44832011)(478600001)(4326008)(64756008)(91956017)(33716001)(86362001)(54906003)(66476007)(316002)(71200400001)(966005)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?IA40u5mxJPn/QV7GH5dZ0/KqVCcA5cQp/Vl6B5loNWlgmiKU3Ung5Dn3YL90?=
 =?us-ascii?Q?lehpUw7B3NTcAdudgY4MKpV/qxi14gxxhljH788zqP6zupWyx8xI3dd8vfXD?=
 =?us-ascii?Q?EMr5ndC7MQJk2XLKQBpafKht4iKuudqrH83I74kZcaWVyVtojvNkpfw0q/cq?=
 =?us-ascii?Q?vDB31fbgxWee5Wm6LT4o7hbExBrOehL8ss+cUOHcmg0PDpnRVBOpK+C5PnQ6?=
 =?us-ascii?Q?XVH0bICufhvfeVwbUWM/py1cnqYdU9rezahyY9nVcdVgztxgGQkhHKMCn45y?=
 =?us-ascii?Q?nt4hMg/1VPEkD/ZduTa/Or46s6IeQIrZcYgGrMCzHSH615tvP5Mh9tZuRgOc?=
 =?us-ascii?Q?Lj5XaoJgLDncrLC0YK2wKvCRjqSvn/mp2l/rIsd7tnYZ5c6zZhZ3r48MgCq1?=
 =?us-ascii?Q?4aHGkVaj/rPbhSGS795197YYVz5NNo2zugDwbHeiTrNMFBGUCX8yFw8HwrHm?=
 =?us-ascii?Q?tqSyLpElQv5KlmOuLH8iSaUo7N+Rz25j0iTXKegxKYFUKeIZGSbDFvEDW6Qu?=
 =?us-ascii?Q?sFJtccKLpx2N2hwcP0K9E8b456gNMck/5k8Vsl2iOXaC0QlrDe+Sy3DKunO7?=
 =?us-ascii?Q?RJ7drWj/QVE1utxTeSMdDlc17iqWmTaZP4ruwpzQHrQ0QDRkI4r+jTVixp+A?=
 =?us-ascii?Q?BiBQEFPG+8F9jXPzxIIos3b/qJedYCKU7jfnyhJ1ETDtlX2BvkyalIS/aoP9?=
 =?us-ascii?Q?1L1yzZ8oYHVmr0CGnOn2zOX/S6+VMz9MlSEGIf1PyYgd8OzEChr/ZJISPvXC?=
 =?us-ascii?Q?CX2LL8BEU2BNowOOX6gki/OIcUP+CplNlM81Josq1l9zJ/GBpR4BBsxDQEqs?=
 =?us-ascii?Q?sZgpgdN7c1ygNnUE3iaAjDxntZvXiYsROM9JNtFtCVq3nCIGPO8kYM1U09ov?=
 =?us-ascii?Q?gU1oTXf/ZhgL/TPYJxBhDDopq+8H8cEtt2bWGh7cknf+wJ8/kvu7ot/tUkgF?=
 =?us-ascii?Q?2d+FRRobjCW59tVNf4N0tOHB4ZVsTR8dhfxpaOWPuxMMpVhAx/p0/32WLFmb?=
 =?us-ascii?Q?iaFQkiP4sJMdLFtcUBuZF0/6/Jjm4lsL4NW7tlDPxQApwV3yWR2L65CCCkOl?=
 =?us-ascii?Q?mEZXB9QNjIUDePmTaQ8M/hnbGBgps9z/Yqwn+m8RlIKTgCnC2uLudu2TK7w7?=
 =?us-ascii?Q?/EPjYZrDamY6IVlV5C6Oaam94+nFQtBxdmMReO9tPaHKfVNA/EjZSGf/n/+D?=
 =?us-ascii?Q?hawMsM1spdezPZLl1DKtVodwnL0EKtkxoxQB74A/SSABDZEXErQwRzzzbsD4?=
 =?us-ascii?Q?4AUJmyi9BabiD5wLigNlzIY/xye+1WYb+XNlSyMSKL8YjT7LyIaFc2aPm0yn?=
 =?us-ascii?Q?RjoZy6FQP49AOSjQ1ukxoKFSEmSdVl7gyIH6H33Ao+xZePkIQHTD1QmTkCIp?=
 =?us-ascii?Q?KJnKbn0Bp332nRfrSBPQ0UEG2BAUJXH6k3D/oYSaih3ZEtCYUd9xBFshW6fl?=
 =?us-ascii?Q?V457ocXgFhOawIIuAlVGr2HMWRQ5/12eJpPLiN6bDtFByzvRR7T8SWMFBvQw?=
 =?us-ascii?Q?B0sMy1fRr5hB2GMzAx3L+OH6Tf8BKsGglThrXFLWviakDUh5KsLO97HuR2Re?=
 =?us-ascii?Q?XRA0kLeNnovUg7Q7FNA5aPvJZIVgKli0KC0Yz5lBX7D6e/iL+WCJTGL/SUL2?=
 =?us-ascii?Q?BjbUG8UmBjqaYzlrq5xxNoA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <828407DE466C6F4C807546102A41EF26@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0HCUacoVlnt88ky0D+XlsMn4G5pzgExlB6NQM3CESIH0bPTF+VMpCppOpab45vwGtHLvOAXIsX70g+ndNZ5iZPgHAj9w/16qyQ+ZEXzAOw2dRdqzMWVxmX2tzcxuvzapxbpfEMRY9u6i7DkNaIB56PGAC+rr8zMSzL5GwGzZ6OFHt0OFkYI1nDuNIzM91XIMp7feHBzrelz4nyjjro5CpVaD+eMWkNVnE+k6cr9zE2MZ0yINOIWVUDN0sjQ2bXx3kPt3W7vTWM18eBvxy3Wto700noJYVJwCJbnvjh/Z81948I5kioH6OnTbcFPfVOEt5I1J2REHnETiLh2/zhTkLqk+i0JIZxRToUINOofP+T189OW2t3sdcbd+k3S1Pa5pslG6AJGkgdeV2ma5UhVTu2aqYecNaPvyyuX5I1JVjmwFV4NJh2pax/M6G5ZvHaKP/xP4BpHoefjrT+6+qoaW5T2oK7z82O//crZxCuNhzyarKq/mIyIFrZYDjCBmQ7yD49tDANR7zR/RnmYqaUuJDgshA/Rq+X+llk83S4gDw2zSssU/GTIeKtlmkCspOk1bnUrd8Uu5sIFW5+sUQ038zuytQkD9uplayc074GlSICAXvMyslaRLAa4hnxkAp2EKQTYvO//9RNgBzPIO71atK1TvYA2WAQz0ZPZ2n9LD2WjI2O2DM/HgEufqOvP5LE59Mlf57F4eO6yQcNwEpZzXPCswwnyhVsSSTgYP4DaQSwdPEVqD1t3tMz/q/mtqxCrpVQHHC8hk/T+LHs+2Bd2bFPmkrlGvqsp3YPaBH0fzqL6GpHujlrAqpgRv4ZwSOJtez0A/erUVYGrFE8ukb86/8eJy7DGYjBZCxCcBsk5PsRw=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR04MB8048.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbae0a77-24a0-456c-a30a-08db1885473c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2023 05:41:30.7618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ST+ZT1Kmxp7cuZZavAtMgN8T2wzWl6zo1S7l2U1rBPDQV2YgCbk7P0sd6vuxUnKIqT1bQDoGcF7wKwlt2TacNfVIDpDwiZlKtAH9fkD79H4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR04MB7194
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Feb 27, 2023 / 10:57, Ziyang Zhang wrote:
> On 2023/2/24 19:41, Shinichiro Kawasaki wrote:
> > On Feb 24, 2023 / 16:28, Ming Lei wrote:
> >> On Fri, Feb 24, 2023 at 03:52:28PM +0800, Ziyang Zhang wrote:
> >>> On 2023/2/20 11:46, Ming Lei wrote:
> >>>
> >>> [...]
> >>>
> >>>>
> >>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> >>>> ---
> >>>>  src/.gitignore |    1 +
> >>>>  src/Makefile   |   18 +
> >>>>  src/miniublk.c | 1376 +++++++++++++++++++++++++++++++++++++++++++++=
+++
> >>>>  3 files changed, 1395 insertions(+)
> >>>>  create mode 100644 src/miniublk.c
> >>>>
> >>>> diff --git a/src/.gitignore b/src/.gitignore
> >>>> index 355bed3..df7aff5 100644
> >>>> --- a/src/.gitignore
> >>>> +++ b/src/.gitignore
> >>>> @@ -8,3 +8,4 @@
> >>>>  /sg/dxfer-from-dev
> >>>>  /sg/syzkaller1
> >>>>  /zbdioctl
> >>>> +/miniublk
> >>>> diff --git a/src/Makefile b/src/Makefile
> >>>> index 3b587f6..81c6541 100644
> >>>> --- a/src/Makefile
> >>>> +++ b/src/Makefile
> >>>> @@ -2,6 +2,10 @@ HAVE_C_HEADER =3D $(shell if echo "\#include <$(1)>=
" |		\
> >>>>  		$(CC) -E - > /dev/null 2>&1; then echo "$(2)";	\
> >>>>  		else echo "$(3)"; fi)
> >>>> =20
> >>>> +HAVE_C_MACRO =3D $(shell if echo "#include <$(1)>" |	\
> >>> Hi Ming,
> >>>
> >>> It should be "\#include", not "#include". You miss a "\".
> >>
> >> "\#include" won't work for checking the macro of IORING_OP_URING_CMD.
> >>
> >> [root@ktest-36 linux]# echo "\#include <liburing.h>" | gcc -E -
> >> # 0 "<stdin>"
> >> # 0 "<built-in>"
> >> # 0 "<command-line>"
> >> # 1 "/usr/include/stdc-predef.h" 1 3 4
> >> # 0 "<command-line>" 2
> >> # 1 "<stdin>"
> >> \#include <liburing.h>
> >=20
> > I also tried and observed the same symptom. HAVE_C_MACRO works well wit=
hout the
> > backslash. Adding the backslash, it fails.
> >=20
> > I think Ziyang made the comment because HAVE_C_HEADER has the backslash=
. (Thanks
> > for catching the difference between HAVA_C_HEADER and HAVE_C_MACRO.) I =
think
> > another fix is needed to remove that backslash from HAVE_C_HEADER.  I'v=
e create
> > a one liner fix patch quickly [1]. It looks ok for blktests CI. I will =
revisit
> > it after Ming's patches get settled.
> >=20
> > [1] https://github.com/osandov/blktests/pull/112/commits/dd5852e69abc32=
47d7b0ec4faf916a395378362d
> >=20
>=20
> Hello,
>=20
> Sorry, I am not familiar with shell script. But **without** the backslash=
,
> I get this error:
>=20
> $ make
> make -C src all
> make[1]: Entering directory '/home/alinux/workspace/blktests/src'
> Makefile:5: *** unterminated call to function 'shell': missing ')'.  Stop=
.
> make[1]: Leaving directory '/home/alinux/workspace/blktests/src'
> make: *** [Makefile:5: all] Error 2

I see... I googled and learned that make version 4.3 introduced this '# ins=
ide
macro' handling difference [2]. I guess your make has version older than 4.=
3,
isn't it?

[2] https://lwn.net/Articles/810071/

Per the the LWN article [2], the fix should be as follows. It works as expe=
cted
on my system with make version 4.3. Could you try it on your system?

diff --git a/src/Makefile b/src/Makefile
index 81c6541..322eb1c 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -1,8 +1,10 @@
-HAVE_C_HEADER =3D $(shell if echo "\#include <$(1)>" |		\
+H :=3D \#
+
+HAVE_C_HEADER =3D $(shell if echo "$(H)include <$(1)>" |		\
 		$(CC) -E - > /dev/null 2>&1; then echo "$(2)";	\
 		else echo "$(3)"; fi)
=20
-HAVE_C_MACRO =3D $(shell if echo "#include <$(1)>" |	\
+HAVE_C_MACRO =3D $(shell if echo -e "$(H)include <$(1)>" |	\
 		$(CC) -E - 2>&1 /dev/null | grep $(2) > /dev/null 2>&1; \
 		then echo 1;else echo 0; fi)
=20


--=20
Shin'ichiro Kawasaki=
