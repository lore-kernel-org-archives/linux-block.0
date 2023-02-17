Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D1AC05027
	for <linux-block@archiver.kernel.org>; Fri, 17 Feb 2023 14:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbjBQOF5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Feb 2023 09:05:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjBQOF4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Feb 2023 09:05:56 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7F2656B2
        for <linux-block@vger.kernel.org>; Fri, 17 Feb 2023 06:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676642754; x=1708178754;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wHF0pulLdjy2nIAilYg66pZkIqRw2rbql/tbL6+fTrY=;
  b=ZtxmPSYInBVbNE/fPbNJ2KgBdDEV8/eOekrTPkSMDqyIH33viIbsCLvV
   UmW4QK8Cfa+Y7n9/t+N3QgulOuVXeyDSb7INTlaiFtpyC1HCMGXkKRkO3
   5+KGRQh7GmOQD9+PKmvdYXidOpoZ1DD/0pMiWAQbRFRpHKOTo8DdTHa52
   vb0G/Lw09jpY6TTHZPRBDyMY7FUKFe7CqGAzzU6IFEajnytOZVpH+GOfI
   yOdeEOgfWEJjA5p/Wxcib0bBgxHS5dEsj1ZZMuGZR4rfxFo2BknnE9WjT
   szfX3jAm0eGkPxYxh2ySanri+4Pd6Y9jKqC0RfkM2fIIZ4oXonLFz9ubY
   A==;
X-IronPort-AV: E=Sophos;i="5.97,304,1669046400"; 
   d="scan'208";a="335542802"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2023 22:05:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gOjO0e33+Ic+6XANZZky0+uRjSwn2Gq6AVZfZcoTKc8FDJuU1wIjWt1HB8Rw7xWEdiuI2AnkdA6P9xx+slASm+SbqL6zmCOKo8wWKQbxjrLhBRthvzvbDjgJqFnp92oq3ybbe0UTIfFjyKKIzJE4+MtjlSZwJUDbg36Bv7gdUi32LdN4JjtB4rpm4QkWLghE87zi2s3RM/sJsWxbnnHJkD8VcvUT+fRhRInQ6A/zZlWF8st61iLKMV2rFQU6wWSP1MPlqX9DSNOrgRw49QULCzTsbp2WK9PzYWDdrDabWJ6zbeMDzQTcapPew76lIaYn5o1EqqTh06ex2vN9y7eSAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RYWF11IPuCCVWsRrK65iSsjS66OlEtncDF56giHgoCg=;
 b=HTSp1STakSGpmUZtKGVooikAQTwrW9FZHpQoLUtDZCO/YUJRnuGjSnRbESrFCnntlBW4EK5b5NPOUMb4m6nb6ip+J0ThiyuMGZUWQGEH4byawswM6ki2ZJFo7YB+VuuwqH6wlEZo7vbFN8qZTIVEq3nGe4l1LBMgyMAExuDUFLWlQ6bSLohXCh7Uj9fG48+1K0fSAjKpArQufBWd6+MtEiTmnm6f9NSo66TuADXsmqxaj/1rQ/M/a3goB/oEjx6b3+TD1clmpanjv9kJu+h00cYaGfpeQ/vyKaaZOQERfiIMWWJSDmZIuvZ4Os23Hca9MNzWB3bCv5+es4KBh/2c+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYWF11IPuCCVWsRrK65iSsjS66OlEtncDF56giHgoCg=;
 b=rsguui+2yu4c0tsBm0n9YNvoqRUi5TxR72oSCnstqF+0dyIXvExd8xXCyEE8R5Kt+gQiaZENJ6yjRD6bWdz7UFeJZHUcZY4AuZ97QbbvrexQz9qHfiMbZ7XYbprTD0CBstn6doMc50237x9+SZUVbQRlZt+NHUabV8S1ONkXdys=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN8PR04MB5697.namprd04.prod.outlook.com (2603:10b6:408:77::33) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.21; Fri, 17 Feb 2023 14:05:48 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529%8]) with mapi id 15.20.6111.017; Fri, 17 Feb 2023
 14:05:48 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v2 1/2] src: add mini ublk source code
Thread-Topic: [PATCH blktests v2 1/2] src: add mini ublk source code
Thread-Index: AQHZQnCmAHbTQ26yAEGe2+PRvqXLYa7TLPyA
Date:   Fri, 17 Feb 2023 14:05:48 +0000
Message-ID: <20230217140547.qvpdniixeeurc5im@shindev>
References: <20230217013851.1402864-1-ming.lei@redhat.com>
 <20230217013851.1402864-2-ming.lei@redhat.com>
In-Reply-To: <20230217013851.1402864-2-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BN8PR04MB5697:EE_
x-ms-office365-filtering-correlation-id: ba4d90a8-6184-4512-9538-08db10f011e1
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jacWOzBNx8+qF+hu9vM3QKuJJevbbGgkH92YQWUSh+oGxsXJ6oXdzcbHovsNVhEiQNC2kKycmfhR/iOOvUqc1KoGInSluCCzlb8zUPV7GHmeTONAqH8tRe6EdY4hLjIpyPTjNdW6QFtJ3GAH9yBhV/1O7KDWyVrlfy46HpWrdmGKsxS4TXxwuSIgRTJc9xGlc7bHmAB/rxmr10N7/TqeGB7+Gzd7mM1fc7G6/CCdRGoYJWDGt+UiSHLgggItyVP+tQoQ9yGOYZWkkaNkOTMpFg3GQp2BRKI6Ai73cVNhV01vHQhSJhBXGc0ZqV5E+b/+ACuJujsdRat8Id2cOpy9HTEden2fsslH2L40+KURaGcGI4sP1p3YV7IFny3VLzytqXn4sTVAmSribUl7jlGuWVga1i3xMWEH03joYnyrY+wuRTlbTJno8xPTq6DXbMTz8Us4phoT+Rk/6sO+vOwmXSBdawpkanWTkj4F1amOxDzcgMdfBQw4pZWXDQDmzZ1x8WcueVrtye5g3P6wQYo6A/x7ykFcta/RSVgLtdYjM8vCbKegNsQMrZFQThVhzSbUbjl8JeJsG2vSZJGMml/ZsH7hv59YQyclcD41PuEsgknlN0yZkAsqNnn2Vgl2g380TKYYxXEPr8YkNQrQgxl/8Wvli7xN8vuQwgyIAx7KGe4ab9yJJsaMXc8J3Rfc5t2s9Iei7KPaOWbjz4IiZp/ZsQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(346002)(39860400002)(366004)(136003)(396003)(376002)(451199018)(33716001)(83380400001)(2906002)(44832011)(38070700005)(478600001)(41300700001)(6506007)(8676002)(6486002)(6916009)(66446008)(86362001)(26005)(122000001)(1076003)(6512007)(4326008)(186003)(8936002)(9686003)(71200400001)(38100700002)(91956017)(66476007)(5660300002)(66946007)(76116006)(316002)(82960400001)(66556008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bC4B2+2vG47YSkaoxbrwtp28MXq41yn+vICTzDbZT3eXwXKk+tY4vZCc1jZ9?=
 =?us-ascii?Q?+4Fv3hzVGj4oifF6qLwQRLIRJeUd4M3qkSmbKISikbNfNA6o2KBLZiG3ZJAI?=
 =?us-ascii?Q?kO05Elms1NVRfCC0GP7YdffFZWAxGRyTLYTDS7+fNbwJbAbPLr330aX/ullr?=
 =?us-ascii?Q?OyqasEKFUm9LQA6rApcOo1hDosJ+hR8Q5uhmDtTNYg+umVJi4PGSzGOPjpe/?=
 =?us-ascii?Q?6Nme/n0t9pW2FggDT235gmGn3Uu+/FBGK0TDIT/ENlZITb4MiL4Hto+wpJ2Z?=
 =?us-ascii?Q?yATFwz7ITrVt6krZvmT4+omU5+z9G8Mc2q4rqBd25TUV38GRfOFT//O+VOeq?=
 =?us-ascii?Q?UTIYhtR9jACdcZ1/XQAx+8Mn/opu93UZhsaYAsCZzQ9r0xmBuLLgZEeW2ZSW?=
 =?us-ascii?Q?SxN3/N1EOuWKr+AqRLQymCSSrNdeH3OFzUzqKWiP7qosdQlJy93858PmDrWj?=
 =?us-ascii?Q?ztd14x0NTzG8D3zfGg6hRRXlvt9Zj8sWwLt8GRhK0LwAFMads++kC4Pb8f36?=
 =?us-ascii?Q?msFVFXxFEd/ImKXEQnhD4u4IOZQv3229L2K73d0JuPZGY3ltgL4eWHlLqK0c?=
 =?us-ascii?Q?FgtlUeyDS3vvB6pcqmJ1J/dr1zxDRZPc/Cm6UjmEg3RiQ1KU2FFl+bzpvDXy?=
 =?us-ascii?Q?XvYAdL/qSjn8Hh2aEaHfholpXbTvdkiAJJ5AN4nfzgQhw/AYbLIFQMFCgGZc?=
 =?us-ascii?Q?4G8Nt/MjFuvvWGUtorEfLX77DSAkWvsfK4gJ+0/UFTGjnCg+VaUd/xn3X2Dh?=
 =?us-ascii?Q?kFyTI3BzX/CyndqeEdDFvs4Rh7y3+z4Uq7TWz6yzs9qnShhGupA+OnNe/VU5?=
 =?us-ascii?Q?y1RnvgB+4CMIGyBKDLt6haGQPTWgfSUB94yZqxD0jJfId4cEq6yfbOwtbH+A?=
 =?us-ascii?Q?lu1o9CrPWvkV1tM6psIyf52L74Nuv+Hbj2445A7Mvg/gTE45S2IlY9bdVm7a?=
 =?us-ascii?Q?S3EB5aLApUYbE8RcZOYAsv1I++q7LNpZiwcg2yzNLFsWPhPqM3/B6YNBRd3e?=
 =?us-ascii?Q?pySHQgOY4Sreci21VUkV9CI2ZEdIqkQ6H3zmZWhJ4j9ErBvbhOcZI4vmX4rz?=
 =?us-ascii?Q?Ohzb76al5wwpuWhYlZakk2CUAAexZgSx3oEk7FdRdcdOeKr8B+9DxLp1WmfW?=
 =?us-ascii?Q?t654I/vuE/6vAxxBWzcRqFI2qUfeVDDKOudPUfvjsDW/DVHuw3mkWdVqyKFn?=
 =?us-ascii?Q?CHYl1GMbcxdq6SKM6Nve9LMroGCYlF1TYRum0QgV9GF+ngi86exPAYN3IRZu?=
 =?us-ascii?Q?XHOZM3f5zI2EK6WxSx2K5vZt0E56M8mWubpQk+8i8WyXuM6VC5xPDVhPLGpt?=
 =?us-ascii?Q?OsBuWRpvfue69cIQYwlclGNNCwVjVjJoWKuZctQyL4PjjApNXuOAbf9QdTuZ?=
 =?us-ascii?Q?H69Yu7qSF2udNT8vU0/KoK3gQgog3qR8h7IU9j+997e92NmYN7VMInbH1u0I?=
 =?us-ascii?Q?OLuyEqq+xIQL1YgZeMHxFqxxLNY/vWbDf6UM3ugPgyI7OxLyTCcDMIEFupel?=
 =?us-ascii?Q?dOQWlVyFqli4DslT+mHTwaevGG4YwFs0B8HTt7QNtP5oCDkx/V20MEdR6wXD?=
 =?us-ascii?Q?l0+E5Nnqvofu8m5Pr4PVycBhFBhp/ZnCvGAr8hnUJEejQk9wEVFEps7qf0y4?=
 =?us-ascii?Q?snVCp17xeWbW8luCvN4fHno=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A702C29FDF28034DB7A60DC0FA5D4F4B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 3RKHvz41XpUlhr28eBqnyrVmem6ZFr+eviTv0ptTr11YO4fRwIBIYoROc9rqDLSahwEKqH2nx/fetDjf6lytcBzuj891VdbD+/5HwbceEotDD6HkdqNWsNlTYrpavFGqNgIfxeW7Lb9gclPOmc5JrONLjcJ0wYpi2IsyojGtQx5snulPfSD8K1yjYpy2Cxu2IzXV4BxB/FgH6oyJC2VMhfGAmTjdTHVB7R7ASDec4NcBHuoECRdVTUn7/S28B+l9lAwCkHvHli0x7QPE9//NciZDrcSMz5c4tKm4HLT3WZKCYtO6CtQbNIMNfsl8HsjxMj7f7oIa5f4sWbTvFeour3+VNeRJzXnyZJbi53JhVAP0H5f/XHu11m+vrsQORT1cH6wV+ADMR0wuGoD7/SyFWvv0HFsyi5Oev8oPEsSkmvmZ89lJQIwlo1/kwMSeUVfGhAsd8Nvym0Wsh8UVC4Z+MfzDysFXByTAhT/rgc8hHMnH4UMdxQ6Yrlu1/Zm3Pe2+r0xEbC58qsLie5cHrrYMfSSbPY/3zd7iRWzQZ9FsL5rNx7vUt9+g28rt8NmVq7DPqCHG9g5KYXd3tnkWKHuoIadCZ5zmK60hHW4hYz8l9AOPQiumhivi4AgNI6mwLIZohJUz8c4R0CHvxxEgVRZE387FYg0qw/HzSpKEidPyM0UAhR2wPo5lWuiNVmUFc0gqyCNSC+7ovTPEZ7ya5+YkIdVWzLz13jgaTeddN1qVxURINReY9nfEMHtdCXBfiPFqLPmlc77XZEfXazxdLx3ZwsEIdoiRja2RX9ab0mitYxXKhxuHtAuGroz3Flfi4yVc
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba4d90a8-6184-4512-9538-08db10f011e1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2023 14:05:48.0780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M/a+RAN0WA1B9CqrPSVBYjfaNzmszLwzTQrNYhqWXnp1SlJsl8uC6Jmm8Wostra4o42TL/Zi9xG/bkV9iQe2eEwEMaiEwX5OWSwPUcVsWlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5697
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming, thanks for the v2 series. Please find my comments in line.

On Feb 17, 2023 / 09:38, Ming Lei wrote:
> Prepare for adding ublk related test:
>=20
> 1) ublk delete is sync removal, this way is convenient to
>    blkg/queue/disk instance leak issue
>=20
> 2) mini ublk has two builtin target(null, loop), and loop IO is
> handled by io_uring, so we can use ublk to cover part of io_uring
> workloads
>=20
> 3) not like loop/nbd, ublk won't pre-allocate/add disk, and always
> add/delete disk dynamically, this way may cover disk plug & unplug
> tests
>=20
> 4) ublk specific test given people starts to use it, so better to
> let blktest cover ublk related tests
>=20
> Add mini ublk source for test purpose only, which is easy to use:
>=20
> ./miniublk add -t {null|loop} [-q nr_queues] [-d depth] [-n dev_id]
> 	 default: nr_queues=3D2(max 4), depth=3D128(max 128), dev_id=3D-1(auto a=
llocation)
> 	 -t loop -f backing_file
> 	 -t null
> ./miniublk del [-n dev_id] [--disk/-d disk_path ] -a
> 	 -a delete all devices, -d delete device by disk path,
> 	 -n delete specified device
> ./miniublk list [-n dev_id] -a
> 	 -a list all devices, -n list specified device, default -a
>=20
> ublk depends on liburing 2.2, so allow to ignore ublk build failure
> in case of missing liburing, and we will check if ublk program exits
> inside test. Also v6.0 is the 1st linux kernel release with ublk.

This v2 patch prevents the ublk build failure. Could you rewrite this parag=
raph?

>=20
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  Makefile            |    2 +-
>  src/Makefile        |   18 +
>  src/ublk/miniublk.c | 1376 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 1395 insertions(+), 1 deletion(-)
>  create mode 100644 src/ublk/miniublk.c
>=20
> diff --git a/Makefile b/Makefile
> index 5a04479..b9bbade 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2,7 +2,7 @@ prefix ?=3D /usr/local
>  dest =3D $(DESTDIR)$(prefix)/blktests
> =20
>  all:
> -	$(MAKE) -C src all
> +	$(MAKE) -i -C src all

As you pointed out in another e-mail, -i is no longer required.

> =20
>  clean:
>  	$(MAKE) -C src clean
> diff --git a/src/Makefile b/src/Makefile
> index 3b587f6..eae52db 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -2,6 +2,10 @@ HAVE_C_HEADER =3D $(shell if echo "\#include <$(1)>" |		=
\
>  		$(CC) -E - > /dev/null 2>&1; then echo "$(2)";	\
>  		else echo "$(3)"; fi)
> =20
> +HAVE_C_MACRO =3D $(shell if echo "#include <$(1)>" |	\
> +		$(CC) -E - 2>&1 /dev/null | grep $(2) > /dev/null 2>&1; \
> +		then echo 1;else echo 0; fi)
> +
>  C_TARGETS :=3D \
>  	loblksize \
>  	loop_change_fd \
> @@ -13,16 +17,27 @@ C_TARGETS :=3D \
>  	sg/syzkaller1 \
>  	zbdioctl
> =20
> +C_MINIUBLK :=3D ublk/miniublk
> +
> +HAVE_LIBURING :=3D $(call HAVE_C_MACRO,liburing.h,IORING_OP_URING_CMD)
> +HAVE_UBLK_HEADER :=3D $(call HAVE_C_HEADER,linux/ublk_cmd.h,1)
> +
>  CXX_TARGETS :=3D \
>  	discontiguous-io
> =20
> +ifeq ($(HAVE_LIBURING)$(HAVE_UBLK_HEADER), 11)
> +TARGETS :=3D $(C_TARGETS) $(CXX_TARGETS) $(C_MINIUBLK)
> +else
> +$(info Skip $(C_MINIUBLK) build due to missing kernel header(v6.0+) or l=
iburing(2.2+))
>  TARGETS :=3D $(C_TARGETS) $(CXX_TARGETS)
> +endif
> =20
>  CONFIG_DEFS :=3D $(call HAVE_C_HEADER,linux/blkzoned.h,-DHAVE_LINUX_BLKZ=
ONED_H)
> =20
>  override CFLAGS   :=3D -O2 -Wall -Wshadow $(CFLAGS) $(CONFIG_DEFS)
>  override CXXFLAGS :=3D -O2 -std=3Dc++11 -Wall -Wextra -Wshadow -Wno-sign=
-compare \
>  		     -Werror $(CXXFLAGS) $(CONFIG_DEFS)
> +MINIUBLK_FLAGS :=3D  -D_GNU_SOURCE -lpthread -luring
> =20
>  all: $(TARGETS)
> =20
> @@ -39,4 +54,7 @@ $(C_TARGETS): %: %.c
>  $(CXX_TARGETS): %: %.cpp
>  	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -o $@ $^
> =20
> +$(C_MINIUBLK): %: ublk/miniublk.c
> +	$(CC) $(CFLAGS) $(MINIUBLK_FLAGS) -o $@ ublk/miniublk.c
> +
>  .PHONY: all clean install
> diff --git a/src/ublk/miniublk.c b/src/ublk/miniublk.c
> new file mode 100644
> index 0000000..e84ba41
> --- /dev/null
> +++ b/src/ublk/miniublk.c

Do you plan to add more programs in the ublk/ directory? If not, I suggest =
to
place miniublk.c in just under src/.

Also, could you add miniublk to src/.gitignore?

--=20
Shin'ichiro Kawasaki=
