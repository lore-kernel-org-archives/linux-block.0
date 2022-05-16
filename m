Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A134FC433F5
	for <linux-block@archiver.kernel.org>; Mon, 16 May 2022 01:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239028AbiEPBSI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 15 May 2022 21:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236470AbiEPBSH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 15 May 2022 21:18:07 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7BB2C10F
        for <linux-block@vger.kernel.org>; Sun, 15 May 2022 18:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1652663885; x=1684199885;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qdUCKJK26H4hIyZ0uEp+MW369ZTd8txoZ1hJgbUqObM=;
  b=DG5lzg+ItDbP27Sr1PRquHjQhKT6NjYwTHfeZ71ovNvHBa5OxuLOmSmX
   fMd3g3d41pBMsksFhoY0JLZVuCqeyCNgiGluBRwI4i2Y/ToKN67QEwKr9
   KuNThRYJ2o/iqNphqjsISwNhNzZUw1hNGxnD9btz96hGY8zbztImmuzRI
   UmvuBgEtlYe54aP9lL8YxYaulLTgMHZjsHEbSAbAUJcPhxPK+0N9p9DeA
   UuzNLMR8Xo9pblk2sTMskSh9x28WE2pJBpOkGQUNHrLH5iGh246bLuDXM
   vgeOApsptsBzVHmZePp4t95tdu+oEUwREUC94GqyRY36G0e2BJkTsgNdv
   w==;
X-IronPort-AV: E=Sophos;i="5.91,229,1647273600"; 
   d="scan'208";a="199213225"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2022 09:18:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ni6UQWCqdJxh/gHubJ4usbRCgenGAaJZiGP7cD/MPeGQqRE+/Q6r65L0AbJi09uMmXnrk+VqiT7hhdJU06LHSreWJQT6MyDmfv/k3HXVgzrsh/P7IcDYXNXlyqVVPKCr+/MQemvM8S+j5rSgKYpQ2k7yA9wR37zBzSOv28DVc2l8Nc/gsuqRiUBQWOvXm1r09LRJOt0FHy/etSKXXAEAsDEgY0EKgPjqh6cliLx4IA3T6kzrQbpTTEqwWnO+zneKwd1SKmtn18+AqUID56IRxvO8ZxHcFEUa0p+DolW7rR2SyDWrmzjpPv+CzIVtqGS/uoZT5d+l2CWQJmIrQMHNcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNCec+l937rnHu3TIg1dTrjLUu9V7FGiOs+X96bDK/o=;
 b=euniNgtWGvJUcFW9U+kimpZWzdCaq6CO0GQ8/AfJM4I6JGZ2ziH3s3uxu49/JeH/NOOyqqv9rGvxPFdwH/3kcvPsXfF2X09esOQti3y4z2nLHiKmICSXvkQjaZdMzc6f5M5NNLrx0xyIiyMMTvVKhQ6ylQaeR4cJqQhwCbMng0fENpO6gtUjRC+Tm1vf74pwENJHKujl1W7KbTAdeBA13Nc1s0CWbXA9esh/oGW1DrjoCNZri4koYCRwl8FKxaXM8l+rWPCSH2VEcpVrIgImFZlNqzA5/GryjHtCYCQzFec8pnDC7yJ0836P811NQpp3mYEm5DXgQcpzaR0cQX6iDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNCec+l937rnHu3TIg1dTrjLUu9V7FGiOs+X96bDK/o=;
 b=DvJFbW76n5peQbQKAtuQQZ7tE+asJHU1P5/9tR43zCpf/jais75tG4snZrHZ52zn7vHy/qwexKlD9IxjT+kH3WoTj23Z9hrxC3UE/rVrBHwGm0W/MiUjryZq7tOeYvNOeIN6x44J+qgBfUcf0L8AtiMmEyZrzBaiJ4HoflPUNmg=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB6795.namprd04.prod.outlook.com (2603:10b6:5:24f::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.16; Mon, 16 May 2022 01:18:02 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5250.018; Mon, 16 May 2022
 01:18:01 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Alan Adamson <alan.adamson@oracle.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "osandov@fb.com" <osandov@fb.com>
Subject: Re: [PATCH v3 blktests 2/2] tests/nvme: add tests for error logging
Thread-Topic: [PATCH v3 blktests 2/2] tests/nvme: add tests for error logging
Thread-Index: AQHYaMLJl+FZRGYalkCWCcCCOY7n7Q==
Date:   Mon, 16 May 2022 01:18:01 +0000
Message-ID: <20220516011801.ktysc6ilno232xhw@shindev>
References: <20220513155252.14332-1-alan.adamson@oracle.com>
 <20220513155252.14332-3-alan.adamson@oracle.com>
In-Reply-To: <20220513155252.14332-3-alan.adamson@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa19f2b6-edad-4069-d5a0-08da36d9ebe0
x-ms-traffictypediagnostic: DM6PR04MB6795:EE_
x-microsoft-antispam-prvs: <DM6PR04MB67950A1110C8CCD7F9B3D891EDCF9@DM6PR04MB6795.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: urB0Fyc6z6OkqJdcF6iWwA9jH4m9L6KsOLFWEtU/XEP8zRcnRQPADhDDndp/8a2V3guLrJm0bFZyr2hnke20WIPvqSDnYmaMTaYNiT2U93CIihlvngUtvHTeCwSCs1dRrjCB4X6T2Qs+TQf8FHoCmVhFcQllhfuA7Gz0vSntuz8QVjtZ1/6gPwBpjbIgTSqwQwCjeNumRYbmuFPgEeH0xClyHTYEI6ngazcNPj3sfJjOh1zbAYsX/IGsOHNiAvu1fnMBK53Ag3WHQvcYwD/Q+QVLBSuU4bG/Mvew/2q/J0i8TgQaEmOm6Hha8AAc8QyqPH8lSG26xgpZASURVuJl7X9Zkq8BP0DFPJWpjgzYtjYVEyRxC5KzC1zGKjY+QqaVZqfv40uOPqC88sGrf9lXhjGGjI4SCHE/vFZZZRXhnuA9dg4zANmV2I7LRqt1Rt0VhZjjAy7Aadd1GC4K+CndnBMRIV+Si/z3c7uxyqM0Zy4t8wWwJXzBepiENJUNnW6fkNugeNx/5VNYNeYyVCKRGzq54d1KA8CPs89qRk+rLIfaltqTrXzTW3G3tj4c/irRGbyxlQJyD8juTWUfqYka9HoeJQphp8NlX4PX1Dx05xxaEA9OZ8MwOiADLH6xR78kt73e1NtqIjk8DLbHjocfhyJe+l7eH2ocV9VMKelmmapnSlV2HOqQ31vhmli4Erm2VsPbkzabmwUcF03KIu/X1w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(4326008)(76116006)(66946007)(66556008)(66476007)(8676002)(66446008)(9686003)(6486002)(33716001)(91956017)(2906002)(1076003)(82960400001)(26005)(64756008)(6916009)(54906003)(316002)(6512007)(6506007)(71200400001)(44832011)(186003)(122000001)(8936002)(83380400001)(5660300002)(38070700005)(38100700002)(86362001)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hShPbOyMHp1QdlXYOckTexVN/769JeZWh16p6xBfvQUnRY2OrG5J04ozYNB+?=
 =?us-ascii?Q?Ij2szGL+jXMUXUouewRWWIRrQ7dHaFBj7dSj+2nyyRpsLik/xETE9royQ1oT?=
 =?us-ascii?Q?DpBn7U5/sVY+DJGnEa4viXqZcEkAdzK7evRCtgvMFeXJmmmswQH2xxXk1sVb?=
 =?us-ascii?Q?UEzTfPyCe/EA3BWjbGGNRnR+wbFncuXtUeDTkGG07tiVJogsFjuqU/OtvsOs?=
 =?us-ascii?Q?swYkIMS9mkIBo3IZZz541wIfu78jH51J2tx00eih292yQSKOATuK56K0xcW0?=
 =?us-ascii?Q?8X0EEw+CYav8P3NkXIsaLA3aMhiQN1PnzttRgwPu1+gtcHnIvFCMBJ65wDme?=
 =?us-ascii?Q?51ouJMgbAuAR4nb8yOLYuTQ9WGbF/rNZdkAh0nhngRg3Sml3+hRiN+A8Q0WK?=
 =?us-ascii?Q?RAZKHlb56DH3marFYcg9YbPMVkpQZrGgreKwQ8qoIaOK/zAYJAvdLy71R2VL?=
 =?us-ascii?Q?GwK/tpyT/BQZKO7F9159ZcryQp6Rfh5hAkbrE6CENNuETEP5M0vXdd2ejfbx?=
 =?us-ascii?Q?49XGtvqv9nkh2pe4URJ5hywoQBoQZz8f85zYZpWeBGr3ZxF1L/p1590Nndq9?=
 =?us-ascii?Q?51JOYv8q7fgKIInThD/wzoEvdcMho5sPA9iu/F+Lzf3p19UEbc06ZXulynp7?=
 =?us-ascii?Q?uTAuor/h5pJBgA5GJXaL94wuK/D62tlHitx0DNgFttnK3xs2TLql2j0uc9iX?=
 =?us-ascii?Q?6iBT/BWupmUBPuA9s9UhPhRAIJ02qku1wnmUK1huB3mrPldz0MCDQKupdvuN?=
 =?us-ascii?Q?suFDFEac0fEuovTx5wDq6Tu113IOhKIcB+PnftP7eITbEnTp9E3V9Tftie3S?=
 =?us-ascii?Q?nWM6YheEkSNCuFq3GQ5ymhsu2qHI1P3O4SO38dyMHbk0r3mdFkuZSmYpWAhD?=
 =?us-ascii?Q?2AW6HdqvO3biMo9O4/2zKvCulAECfaB1OFrj7MPyN5FCGm6lb4e8t6vhVKHw?=
 =?us-ascii?Q?BRZ3A/A1xMBYnziVE0zdeLtrpTNVNb/Z1Y5lqcL5iYskUxz0PzqlArhjJOFQ?=
 =?us-ascii?Q?3zOWAlowIvOa6T8WesmLNoeECwgFbFU9zBwFhqFhPidkv81p8fH0rD978G+K?=
 =?us-ascii?Q?RXVyCABeFL28CXZrFjqbs8a6BluVpiUn+2y0C8gQuG+hbENzVF2r9utXf4Ez?=
 =?us-ascii?Q?UWPig+wElk9HZhDkJOiyAKMqvuZg3xdbFENv+Yyq3tSF8gQkTdjIRR0AJca3?=
 =?us-ascii?Q?te1lsYp6r++oGj0HxpfwlmWAM61k5z6cAuLXY9ra/SJOJxwIehw3SFU7SiKC?=
 =?us-ascii?Q?DztZ4mN+5IOrK8yXXmubMXbbrnxObnsCoffsd4eF+kQ1w+tF0/oyolfbi3+8?=
 =?us-ascii?Q?NUz8VWZxsfW1xh2amkczSp0Ylp3Um8DNMVcqH2TlNDTZfQiJ8n/l5SoEKSNV?=
 =?us-ascii?Q?QtHkdylIJNuAGcK5e7gbtlwM9OuQ1TYvYLhxrOOhP3161Gcu+H945tZ+gF7g?=
 =?us-ascii?Q?SGjTqoYH5irLAYjIBztJy9kt9HCkdBEchdAkO3GWMuPl7JR6/6PEbIGy9TxL?=
 =?us-ascii?Q?lQY2YsFjYnro8bS9PC0ib9LHBfrH8+XBdXypDw1GmcF5tHtU6sbkjOsyb7Ud?=
 =?us-ascii?Q?6x1Xu6klZlUQ1bnUqq3cghrNOwdjs+E3CBOnil3KpMKKmXlsrBoYfOOy12Gc?=
 =?us-ascii?Q?iDH9JHT6MmD61HNYcCQZCBIyV+cUZh5LX4F5dSwKTR+p958rf7PWU3E5RNJc?=
 =?us-ascii?Q?T3dXJojIM0ICqV2xONSJR4+lwRb+DtGywQb7wTRbQA/P28jgxzPvh0/rlpPM?=
 =?us-ascii?Q?bB+6BP7hVg64bRTCAUuk4YxEXi5Zk4l2hyeimNcIj6uCX18/cRNT?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <851C46BB90D76D49B8B1CC38B506656C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa19f2b6-edad-4069-d5a0-08da36d9ebe0
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2022 01:18:01.9061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PqkUijM/VaJs9N9soRAt2XnwujB7JLQUmN9xRCpXa/Dw17UrLDeGoEch5zoG3MzQiSPveBiLLbklYeE184rKVhNfmYFDewRxLpYg95YeqRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6795
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On May 13, 2022 / 08:52, Alan Adamson wrote:
> Test nvme error logging by injecting errors. Kernel must have FAULT_INJEC=
TION
> and FAULT_INJECTION_DEBUG_FS configured to use error injector. Tests can =
be
> run with or without NVME_VERBOSE_ERRORS configured.
>=20
> Signed-off-by: Alan Adamson <alan.adamson@oracle.com>
> Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
> ---
>  tests/nvme/039     | 152 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/nvme/039.out |   7 +++
>  2 files changed, 159 insertions(+)
>  create mode 100755 tests/nvme/039
>  create mode 100644 tests/nvme/039.out
>=20
> diff --git a/tests/nvme/039 b/tests/nvme/039
> new file mode 100755
> index 000000000000..dd216cbb2ef0
> --- /dev/null
> +++ b/tests/nvme/039
> @@ -0,0 +1,152 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2022 Oracle and/or its affiliates
> +#
> +# Test nvme error logging by injecting errors. Kernel must have FAULT_IN=
JECTION
> +# and FAULT_INJECTION_DEBUG_FS configured to use error injector. Tests c=
an be
> +# run with or without NVME_VERBOSE_ERRORS configured.
> +#
> +# Test for commit bd83fe6f2cd2 ("nvme: add verbose error logging").
> +
> +. tests/nvme/rc
> +DESCRIPTION=3D"test error logging"
> +QUICK=3D1
> +
> +requires() {
> +	_nvme_requires
> +	_have_kernel_option FAULT_INJECTION && \
> +	    _have_kernel_option FAULT_INJECTION_DEBUG_FS
> +}
> +
> +inject_unrec_read_read()

This new function name looks a bit weird for me. How about to have 'on' bet=
ween
the error to inject and the command to be injected? Such as,
'inject_unrec_read_on_read'. Same comment on other three inject_*() functio=
ns.

> +{
> +	# Inject a 'Unrecovered Read Error' (0x281) status error on a READ
> +	_nvme_enable_err_inject "$1" 0 100 1 0x281 1
> +
> +	dd if=3D/dev/"$1" of=3D/dev/null bs=3D512 count=3D1 iflag=3Ddirect \
> +	    2> /dev/null 1>&2
> +
> +	_nvme_clear_err_inject "$1"

Nit: let's have one empty line here.

> +	if ${nvme_verbose_errors}; then
> +		dmesg -t | tail -2 | grep "Unrecovered Read Error (" | \
> +		    sed 's/nvme.*://g'
> +	else
> +		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Read/g' | \
> +		    sed 's/I\/O Error/Unrecovered Read Error/g' | \
> +		    sed 's/nvme.*://g'
> +	fi
> +}
> +
> +inject_invalid_status_read()
> +{
> +	# Inject an invalid status (0x375) on a READ
> +	_nvme_enable_err_inject "$1" 0 100 1 0x375 1
> +
> +	dd if=3D/dev/"$1" of=3D/dev/null bs=3D512 count=3D1 iflag=3Ddirect \
> +	    2> /dev/null 1>&2
> +
> +	_nvme_clear_err_inject "$1"
> +
> +	if ${nvme_verbose_errors}; then
> +		dmesg -t | tail -2 | grep "Unknown (" | \
> +		    sed 's/nvme.*://g'
> +	else
> +		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Read/g' | \
> +		    sed 's/I\/O Error/Unknown/g' | \
> +		    sed 's/nvme.*://g'
> +	fi
> +}
> +
> +inject_write_fault_write()
> +{
> +	# Inject a 'Write Fault' 0x280 status error on a WRITE
> +	_nvme_enable_err_inject "$1" 0 100 1 0x280 1
> +
> +	dd if=3D/dev/zero of=3D/dev/"$1" bs=3D512 count=3D1 oflag=3Ddirect \
> +	    2> /dev/null 1>&2
> +
> +	_nvme_clear_err_inject "$1"
> +
> +	if ${nvme_verbose_errors}; then
> +		dmesg -t | tail -2 | grep "Write Fault (" | \
> +		    sed 's/nvme.*://g'
> +	else
> +		dmesg -t | tail -2 | grep "Cmd(" | sed 's/I\/O Cmd/Write/g' | \
> +		    sed 's/I\/O Error/Write Fault/g' | \
> +		    sed 's/nvme.*://g'
> +	fi
> +}
> +
> +inject_access_denied_identify()
> +{
> +	# Inject a 'Access Denied' (0x286) status error on an
> +	# Identify admin command
> +	_nvme_enable_err_inject "$1" 0 100 1 0x286 1
> +
> +	nvme admin-passthru /dev/"$1" --opcode=3D0x06 --data-len=3D4096 \
> +	    --cdw10=3D1 -r 2> /dev/null 1>&2
> +
> +	_nvme_clear_err_inject "$1"
> +
> +	if ${nvme_verbose_errors}; then
> +		dmesg -t | tail -1 | grep "Access Denied (" | \
> +		    sed 's/nvme.*://g'
> +	else
> +		dmesg -t | tail -1 | grep "Admin Cmd(" | \
> +		    sed 's/Admin Cmd/Identify/g' | \
> +		    sed 's/I\/O Error/Access Denied/g' | \
> +		    sed 's/nvme.*://g'
> +	fi
> +}
> +
> +inject_invalid_cmd_admin()
> +{
> +	# Inject a 'Invalid Command Opcode' (0x1) on an invalid command (0x96)
> +	 _nvme_enable_err_inject "$1" 0 100 1 0x1 1
> +
> +	nvme admin-passthru /dev/"$1" --opcode=3D0x96 --data-len=3D4096 \
> +	    --cdw10=3D1 -r 2> /dev/null 1>&2
> +
> +	_nvme_clear_err_inject "$1"
> +
> +	if ${nvme_verbose_errors}; then
> +		dmesg -t | tail -1 | grep "Invalid Command Opcode (" | \
> +		    sed 's/nvme.*://g'
> +	else
> +		dmesg -t | tail -1 | grep "Admin Cmd(" | \
> +		    sed 's/Admin Cmd/Unknown/g' | \
> +		    sed 's/I\/O Error/Invalid Command Opcode/g' | \
> +		    sed 's/nvme.*://g'
> +	fi
> +}
> +
> +test_device() {
> +	local nvme_verbose_errors
> +	local ns_dev
> +	local ctrl_dev
> +
> +	echo "Running ${TEST_NAME}"
> +
> +	if _have_kernel_option NVME_VERBOSE_ERRORS; then
> +		nvme_verbose_errors=3Dtrue
> +	else
> +		unset SKIP_REASON
> +		nvme_verbose_errors=3Dfalse
> +	fi
> +
> +	ns_dev=3D${TEST_DEV##*/}
> +	ctrl_dev=3D${ns_dev%n*}
> +
> +	_nvme_err_inject_setup "${ns_dev}" "${ctrl_dev}"
> +
> +	inject_unrec_read_read "${ns_dev}"
> +	inject_invalid_status_read "${ns_dev}"
> +	inject_write_fault_write "${ns_dev}"
> +
> +	inject_access_denied_identify "${ctrl_dev}"
> +	inject_invalid_cmd_admin "${ctrl_dev}"
> +
> +	_nvme_err_inject_cleanup "${ns_dev}" "${ctrl_dev}"
> +
> +	echo "Test complete"
> +}
> diff --git a/tests/nvme/039.out b/tests/nvme/039.out
> new file mode 100644
> index 000000000000..162935eb1d7b
> --- /dev/null
> +++ b/tests/nvme/039.out
> @@ -0,0 +1,7 @@
> +Running nvme/039
> + Read(0x2) @ LBA 0, 1 blocks, Unrecovered Read Error (sct 0x2 / sc 0x81)=
 DNR=20
> + Read(0x2) @ LBA 0, 1 blocks, Unknown (sct 0x3 / sc 0x75) DNR=20
> + Write(0x1) @ LBA 0, 1 blocks, Write Fault (sct 0x2 / sc 0x80) DNR=20
> + Identify(0x6), Access Denied (sct 0x2 / sc 0x86) DNR=20
> + Unknown(0x96), Invalid Command Opcode (sct 0x0 / sc 0x1) DNR=20
> +Test complete
> --=20
> 2.27.0
>=20

--=20
Best Regards,
Shin'ichiro Kawasaki=
