Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD69C56202
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 08:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAF8C20857
	for <linux-block@archiver.kernel.org>; Thu, 26 Nov 2020 08:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="K23CHlx9";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="G7aLFU89"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388628AbgKZIHJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Nov 2020 03:07:09 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:51074 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731457AbgKZIHJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Nov 2020 03:07:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1606378028; x=1637914028;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=NMkXzWl9vqOqhQsbPNbe2yXwV5dxbO7x4kmD3Q+Paig=;
  b=K23CHlx9hmGxwshCFq/OUEKyv9MsTQF4/QX3e5conIDtSOSKNE1aTeV1
   Sm9BIjxlBwhaA4+0rHIQJUwb3fMe+/qfqa3Vc91OEQlNDOpu8qrHUPHvh
   lEVz83dLgetfpJrjUgwLqd86BhRUG775FcViBLwfn+UqBSneMz31+zcFY
   BcKMXrGO/EpSHkfIDD6fZCuBmmjZzn+vVnL+c+FnXse8l+UnOeWsU8BWz
   RjNmV4f0ZjyFd9Ra2ZMD4jZgXbCF9iCRy60gWBq7iGdK6DrMcCJR93S9b
   hrKuEqo+Kjd8j1iOiw+5/nBO19i8zumBhrINEU0YMW13b/Fcd3fJ0eAYh
   w==;
IronPort-SDR: CQLOfUfPTizXWGJSe88qeHedkSCVb1eHtgFMYVyvjlv3Tz3hR8DwZsp8u+zgMLCX3EUT72SxIp
 WkoX7+g8TpUE69hEZG6qqauAh8pur2ZA62rjNzZW0muGI8KLoR0gyGJSVlW8xfz6aNgJlqB7Mw
 3ts8tBLif/qwp+7mu6coQW5WjHrITyMyFFYGjJzAa/rJoCFws9xH40uIz90+l72E2mq19ayNKS
 fCX3szNTfFnaoyRghCQR83HegeBl0o/mKqTklguK1M9v93k59q3Jp103Z0XnclWaI7mp68G+Th
 EvQ=
X-IronPort-AV: E=Sophos;i="5.78,371,1599494400"; 
   d="scan'208";a="153609522"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 26 Nov 2020 16:07:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DEVo4DJgDfoDCHzndjYASaHfHsIQ6Jlsz+1YuH+/jdgqkwgGwL4jzCrClkZqJFRNtyFyLNEXAkkMUVJEG16CULHc9J8LGtnJY9aZqwS/Pt+11LUFnqMLv/hbDW0DVHA9f1yuWwh2pWl+icT3i5D5mYIMHmGi3Vx0/xaruYn2M3WEBhjOHb0NPxFEuwPsjafpPjv6MnZKcVJWagOrZAmGqoeyQPauuUfOPIWUpA+CgS8k+6cTZo8tN6Z/5XYiHWvlQ+WaNMZF+FuPu0kLqpMi3AuC9DJQzjmDU7HpQVwPCzuFUyohnv/0lXpZJlamsNYhSO9urW2fG4KJlBHmSprcUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGZifd9A6U1fpeko8iHtjlVvtGtx6USj/eCs+c3Wdso=;
 b=dlfkZwZOa6czr12A+ymvyc5ys2ZuQ+V9+hc8L7w0E+RUFUjNVCErfX+woIxq28OhdlxVpfLy1icxiqm8bHfef2LnZ5BUEj94ouaKz4pWPRZt97fIzBxgkgkAs7n1QpEQ7c8RHfOGPktBldUZvMmdneNHdPRCrJ5bYhJwupP6T4DTdRLMa3VVMzjjZv1YOQr/Q38Am2fyK0Vy0d880bO6l4j7qL/sPK5qFFkZ2qUs/gIhB7JwbQx8JbVpFXu3FSj6F/pg6rvfO0N81XV8bU5U0cgw4B3eltY6/1fQbwMEyyDGqZnBIF1fmlnxLhPCOj+Ikrvn92c1z9m0eyVYsi0OFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGZifd9A6U1fpeko8iHtjlVvtGtx6USj/eCs+c3Wdso=;
 b=G7aLFU89trXu0IZNepT/5Ca5Asr+oq9OfhehPzFknmJPJV/rm6B5WWKHX8Of1pwdpe2dCFATLarHiTCT2M+R0EyiAVzZv1VwWKm13FwUUyaTo72wEFBLe/Lsy0idZrEvJ79Q6V+SKQNPFpNIdyoxbcFQglNHis2Gka8Q5w4mTFc=
Received: from CH2PR04MB6522.namprd04.prod.outlook.com (2603:10b6:610:34::19)
 by CH2PR04MB6775.namprd04.prod.outlook.com (2603:10b6:610:9f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Thu, 26 Nov
 2020 08:07:07 +0000
Received: from CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a]) by CH2PR04MB6522.namprd04.prod.outlook.com
 ([fe80::897c:a04b:4eb0:640a%7]) with mapi id 15.20.3589.022; Thu, 26 Nov 2020
 08:07:07 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH 0/9] nvmet: add genblk ZBD backend
Thread-Topic: [PATCH 0/9] nvmet: add genblk ZBD backend
Thread-Index: AQHWw53ElH89gtWC4UOrc4ORrjUAQA==
Date:   Thu, 26 Nov 2020 08:07:07 +0000
Message-ID: <CH2PR04MB652216EF13A129EDA3BCEE31E7F90@CH2PR04MB6522.namprd04.prod.outlook.com>
References: <20201126024043.3392-1-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:7477:1782:371:aeb9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0e8c59e3-2741-400b-9715-08d891e244d0
x-ms-traffictypediagnostic: CH2PR04MB6775:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CH2PR04MB677511938466FAFB269BCFACE7F90@CH2PR04MB6775.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RpzzrGmsTvKKtSo2J2ERnqjsZiHJGEw++w7W8f48GFth3kgee8l9NW2rO9zlLqIe8F+Kdm2kE49pUzPRXqELkrNSB5AWn4a9yDhBJPEMWnTIWzrkE/0ySIH6In+FSnB2mJQMK1npFPlpP0zfXeW5bNBRJO7OW7Z4ze0zRGxeyK6YfVXVosc/w7/uWbWlrtbKjp6K+SkGb5iZepn5RYhpJba63RhFFAuztvDETyxe/kret20bM9+Pmrg3gQck32eVhNfVFSDCNqRHonSiyVWNCuKWqPngiHrASOcmKPYxQMQHk5oqM/WRe9up2MwoB9jzDtIQ+F1LEDOOkcwr3/hgGQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR04MB6522.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(346002)(396003)(366004)(5660300002)(66946007)(54906003)(2906002)(64756008)(66556008)(8936002)(8676002)(66446008)(316002)(76116006)(66476007)(478600001)(91956017)(4326008)(52536014)(71200400001)(6506007)(55016002)(110136005)(33656002)(53546011)(9686003)(186003)(7696005)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?UCZaStuTZ5cAlUwsueZFkdWEp44zxCEv/ldgUOajmB3znRHSmhMOtkdf03G1?=
 =?us-ascii?Q?MCB1Waswe0hos/aSkhQzI7u62LiOBMerhvWBC1madGQQ2PbAs0dgWvjq2+QZ?=
 =?us-ascii?Q?KrpvgbIZK4ZmToXpphdp5xBFw42Xb4jcTyc48yykAo+DqitiyQiKUcWMVyV+?=
 =?us-ascii?Q?Jt4Z/dPOxjTUafzhiS6i72/2hXFWIRv/pcsIzwKvqJATnAyrY9hVPKiaJA8S?=
 =?us-ascii?Q?Uh4oQnV7DMPnKff9CG38dEHyd3BDlxwG2K69iAYxHyvhANPvHBupiU+kJuvo?=
 =?us-ascii?Q?DpdhJft8+dBU0Q5MJOt7A4al3spMgphUOA1bEHZPA0PBhEeYNhSHetHM/RUH?=
 =?us-ascii?Q?FqbH1TiI96OAkAdMZZ6CnDMlsvszacI7p8R0iGU3AjAHDJuApggPU9T5qSss?=
 =?us-ascii?Q?3hO6XRXRGe2Zmwc7dXyOuVlC/VvH8205jcBqOJ6fQ+FnXT3C/E3qu39mf0Dh?=
 =?us-ascii?Q?KByrKJpyg/fkx8cjKKRZML7FN/lq4UT43JgCMNbA+gWHU3bfESkCEkIfdl0M?=
 =?us-ascii?Q?9fYEsefKPJScHRJzzQqvjQSYO6otHgeKBYAqnNZiz4lgYu+QWJG9o9IoEnDz?=
 =?us-ascii?Q?EBNuAtUMHUrdy9jNaaJMGeDwsY6YySYKBj/HFlcgBB7fffu+4hIbItuTBkOR?=
 =?us-ascii?Q?O61LKMAKhC4a9tJ2lbuwiZOqQ4+Ee9v6mPxrIbwq71+2FOnxxx6Hblq8m/aC?=
 =?us-ascii?Q?2fgrZq5mhBJ1S5cAXMNvlxiuueCMmv6B1eNAoOJuNvWN9RU+eDyWARFgcgkm?=
 =?us-ascii?Q?BGmPX7GtiTscHPRKBXSGQa0iEidYlWxAKsUJB2EVkWW5tJu1wDu2QZpccMqW?=
 =?us-ascii?Q?Vdw4M/Stq5nOFrT48ZQw3sFcbaVY9coXm8XH95xltNK5Bg2RpWmyMxKCtafF?=
 =?us-ascii?Q?yr2v8H1uORxAi4A9mz2WijRMlXVwaadUPX0D7JlT33vLJ3TsltVZW9W+cLiE?=
 =?us-ascii?Q?SLeyOntypY7SE6GEzL0AnClaSgokI1B+aL0et07JKihvWBoEG19xMeMIE7sp?=
 =?us-ascii?Q?R2krcD7TbfqPUVSXQo6eadEH8MejKDY8VqVDECOgKrbgv2yFVJ5ruVHML1jk?=
 =?us-ascii?Q?dBWfd6zB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR04MB6522.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e8c59e3-2741-400b-9715-08d891e244d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2020 08:07:07.4967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IZBVij10wCtwDqRIJbO34fc3YvqzBOza0Gx0i2pKyTdGJ03Rjc1l3oQmsjWTZH4szcf+Q6BjDBzn0df18d6x1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6775
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2020/11/26 11:42, Chaitanya Kulkarni wrote:=0A=
> Hi,=0A=
> =0A=
> NVMeOF Host is capable of handling the NVMe Protocol based Zoned Block=0A=
> Devices (ZBD) in the ZNS mode with the passthru backend. There is no=0A=
> support for a generic block device backend to handle the ZBD devices=0A=
> which are not NVMe devices.=0A=
> =0A=
> This adds support to export the ZBD drives (which are not NVMe drives)=0A=
> to host from the target with NVMeOF using the host side ZNS interface.=0A=
> =0A=
> The patch series is generated in bottom-top manner where, it first adds=
=0A=
> prep patch and ZNS command-specific handlers on the top of genblk and =0A=
> updates the data structures, then one by one it wires up the admin cmds=
=0A=
> in the order host calls them in namespace initializing sequence. Once=0A=
> everything is ready, it wires-up the I/O command handlers. See below for =
=0A=
> patch-series overview.=0A=
> =0A=
> I've tested the ZoneFS testcases with the null_blk memory backed NVMeOF=
=0A=
> namespace with nvme-loop transport. The same testcases are passing on the=
=0A=
> NVMeOF zbd-ns and are passing for null_blk without NVMeOF .=0A=
> =0A=
> Regards,=0A=
> Chaitanya=0A=
> =0A=
> Chaitanya Kulkarni (9):=0A=
>   block: export __bio_iov_append_get_pages()=0A=
> 	Prep patch needed for implementing Zone Append.=0A=
>   nvmet: add ZNS support for bdev-ns=0A=
> 	Core Command handlers and various helpers for ZBD backend which=0A=
> 	 will be called by target-core/target-admin etc.=0A=
>   nvmet: trim down id-desclist to use req->ns=0A=
> 	Cleanup needed to avoid the code repetation for passing extra=0A=
> 	function parameters for ZBD backend handlers.=0A=
>   nvmet: add NVME_CSI_ZNS in ns-desc for zbdev=0A=
> 	Allows host to identify zoned namesapce.=0A=
>   nvmet: add cns-cs-ctrl in id-ctrl for ZNS bdev=0A=
> 	Allows host to identify controller with the ZBD-ZNS.=0A=
>   nvmet: add cns-cs-ns in id-ctrl for ZNS bdev=0A=
> 	Allows host to identify namespace with the ZBD-ZNS.=0A=
>   nvmet: add zns cmd effects to support zbdev=0A=
> 	Allows host to support the ZNS commands when zoned-blkdev is=0A=
> 	 selected.=0A=
>   nvmet: add zns bdev config support=0A=
> 	Allows user to override any target namespace attributes for=0A=
> 	 ZBD.=0A=
>   nvmet: add ZNS based I/O cmds handlers=0A=
> 	Handlers for Zone-Mgmt-Send/Zone-Mgmt-Recv/Zone-Append.=0A=
> =0A=
>  block/bio.c                       |   3 +-=0A=
>  drivers/nvme/target/Makefile      |   3 +-=0A=
>  drivers/nvme/target/admin-cmd.c   |  38 ++-=0A=
>  drivers/nvme/target/io-cmd-bdev.c |  12 +=0A=
>  drivers/nvme/target/io-cmd-file.c |   2 +-=0A=
>  drivers/nvme/target/nvmet.h       |  18 ++=0A=
>  drivers/nvme/target/zns.c         | 390 ++++++++++++++++++++++++++++++=
=0A=
>  include/linux/bio.h               |   1 +=0A=
>  8 files changed, 451 insertions(+), 16 deletions(-)=0A=
>  create mode 100644 drivers/nvme/target/zns.c=0A=
> =0A=
> Test Report :-=0A=
> =0A=
> # cat /sys/kernel/config/nvmet/subsystems/testnqn/namespaces/1/device_pat=
h =0A=
> /dev/nullb1=0A=
> # nvme list | tr -s ' ' ' ' =0A=
> Node SN Model Namespace Usage Format FW Rev =0A=
> /dev/nvme1n1 212d336db96a4282 Linux 1 1.07 GB / 1.07 GB 4 KiB + 0 B 5.10.=
0-r=0A=
> # ./zonefs-tests.sh /dev/nullb1 =0A=
> Gathering information on /dev/nullb1...=0A=
> zonefs-tests on /dev/nullb1:=0A=
>   4 zones (0 conventional zones, 4 sequential zones)=0A=
>   524288 512B sectors zone size (256 MiB)=0A=
>   0 max open zones=0A=
> Running tests=0A=
>   Test 0010:  mkzonefs (options)                                   ... PA=
SS=0A=
>   Test 0011:  mkzonefs (force format)                              ... PA=
SS=0A=
>   Test 0012:  mkzonefs (invalid device)                            ... FA=
IL=0A=
>   Test 0013:  mkzonefs (super block zone state)                    ... FA=
IL=0A=
=0A=
See below.=0A=
=0A=
>   Test 0020:  mount (default)                                      ... PA=
SS=0A=
>   Test 0021:  mount (invalid device)                               ... PA=
SS=0A=
>   Test 0022:  mount (check mount directory sub-directories)        ... PA=
SS=0A=
>   Test 0023:  mount (options)                                      ... PA=
SS=0A=
>   Test 0030:  Number of files (default)                            ... PA=
SS=0A=
>   Test 0031:  Number of files (aggr_cnv)                           ... sk=
ip=0A=
>   Test 0032:  Number of files using stat (default)                 ... PA=
SS=0A=
>   Test 0033:  Number of files using stat (aggr_cnv)                ... PA=
SS=0A=
>   Test 0034:  Number of blocks using stat (default)                ... PA=
SS=0A=
>   Test 0035:  Number of blocks using stat (aggr_cnv)               ... PA=
SS=0A=
>   Test 0040:  Files permissions (default)                          ... PA=
SS=0A=
>   Test 0041:  Files permissions (aggr_cnv)                         ... sk=
ip=0A=
>   Test 0042:  Files permissions (set value)                        ... PA=
SS=0A=
>   Test 0043:  Files permissions (set value + aggr_cnv)             ... sk=
ip=0A=
>   Test 0050:  Files owner (default)                                ... PA=
SS=0A=
>   Test 0051:  Files owner (aggr_cnv)                               ... sk=
ip=0A=
>   Test 0052:  Files owner (set value)                              ... PA=
SS=0A=
>   Test 0053:  Files owner (set value + aggr_cnv)                   ... sk=
ip=0A=
>   Test 0060:  Files size (default)                                 ... PA=
SS=0A=
>   Test 0061:  Files size (aggr_cnv)                                ... sk=
ip=0A=
>   Test 0070:  Conventional file truncate                           ... sk=
ip=0A=
>   Test 0071:  Conventional file truncate (aggr_cnv)                ... sk=
ip=0A=
>   Test 0072:  Conventional file unlink                             ... sk=
ip=0A=
>   Test 0073:  Conventional file unlink (aggr_cnv)                  ... sk=
ip=0A=
>   Test 0074:  Conventional file random write                       ... sk=
ip=0A=
>   Test 0075:  Conventional file random write (direct)              ... sk=
ip=0A=
>   Test 0076:  Conventional file random write (aggr_cnv)            ... sk=
ip=0A=
>   Test 0077:  Conventional file random write (aggr_cnv, direct)    ... sk=
ip=0A=
>   Test 0078:  Conventional file mmap read/write                    ... sk=
ip=0A=
>   Test 0079:  Conventional file mmap read/write (aggr_cnv)         ... sk=
ip=0A=
>   Test 0080:  Sequential file truncate                             ... PA=
SS=0A=
>   Test 0081:  Sequential file unlink                               ... PA=
SS=0A=
>   Test 0082:  Sequential file buffered write IO                    ... PA=
SS=0A=
>   Test 0083:  Sequential file overwrite                            ... PA=
SS=0A=
>   Test 0084:  Sequential file unaligned write (sync IO)            ... PA=
SS=0A=
>   Test 0085:  Sequential file unaligned write (async IO)           ... PA=
SS=0A=
>   Test 0086:  Sequential file append (sync)                        ... PA=
SS=0A=
>   Test 0087:  Sequential file append (async)                       ... PA=
SS=0A=
>   Test 0088:  Sequential file random read                          ... PA=
SS=0A=
>   Test 0089:  Sequential file mmap read/write                      ... PA=
SS=0A=
>   Test 0090:  sequential file 4K synchronous write                 ... PA=
SS=0A=
>   Test 0091:  Sequential file large synchronous write              ... PA=
SS=0A=
> =0A=
> 44 / 46 tests passed=0A=
> #=0A=
> #=0A=
> # ./zonefs-tests.sh /dev/nvme1n1=0A=
> Gathering information on /dev/nvme1n1...=0A=
> zonefs-tests on /dev/nvme1n1:=0A=
>   4 zones (0 conventional zones, 4 sequential zones)=0A=
>   524288 512B sectors zone size (256 MiB)=0A=
>   1 max open zones=0A=
> Running tests=0A=
>   Test 0010:  mkzonefs (options)                                   ... PA=
SS=0A=
>   Test 0011:  mkzonefs (force format)                              ... PA=
SS=0A=
>   Test 0012:  mkzonefs (invalid device)                            ... FA=
IL=0A=
=0A=
Weird, this should not fail. zonefs-tests.sh creates a regular nullb device=
 to=0A=
test that mkzonefs rejects regular disks. What was the failure here ?=0A=
=0A=
>   Test 0013:  mkzonefs (super block zone state)                    ... FA=
IL=0A=
=0A=
Same, this should not fail: this checks that if the super block is in a=0A=
sequential zone, that zone must be in the full condition. And seeing that a=
ll=0A=
conventional tests are skipped, it looks like your nullb drive does not hav=
e any=0A=
conventional zones. What was the error here ?=0A=
=0A=
>   Test 0020:  mount (default)                                      ... PA=
SS=0A=
>   Test 0021:  mount (invalid device)                               ... PA=
SS=0A=
>   Test 0022:  mount (check mount directory sub-directories)        ... PA=
SS=0A=
>   Test 0023:  mount (options)                                      ... PA=
SS=0A=
>   Test 0030:  Number of files (default)                            ... PA=
SS=0A=
>   Test 0031:  Number of files (aggr_cnv)                           ... sk=
ip=0A=
>   Test 0032:  Number of files using stat (default)                 ... PA=
SS=0A=
>   Test 0033:  Number of files using stat (aggr_cnv)                ... PA=
SS=0A=
>   Test 0034:  Number of blocks using stat (default)                ... PA=
SS=0A=
>   Test 0035:  Number of blocks using stat (aggr_cnv)               ... PA=
SS=0A=
>   Test 0040:  Files permissions (default)                          ... PA=
SS=0A=
>   Test 0041:  Files permissions (aggr_cnv)                         ... sk=
ip=0A=
>   Test 0042:  Files permissions (set value)                        ... PA=
SS=0A=
>   Test 0043:  Files permissions (set value + aggr_cnv)             ... sk=
ip=0A=
>   Test 0050:  Files owner (default)                                ... PA=
SS=0A=
>   Test 0051:  Files owner (aggr_cnv)                               ... sk=
ip=0A=
>   Test 0052:  Files owner (set value)                              ... PA=
SS=0A=
>   Test 0053:  Files owner (set value + aggr_cnv)                   ... sk=
ip=0A=
>   Test 0060:  Files size (default)                                 ... PA=
SS=0A=
>   Test 0061:  Files size (aggr_cnv)                                ... sk=
ip=0A=
>   Test 0070:  Conventional file truncate                           ... sk=
ip=0A=
>   Test 0071:  Conventional file truncate (aggr_cnv)                ... sk=
ip=0A=
>   Test 0072:  Conventional file unlink                             ... sk=
ip=0A=
>   Test 0073:  Conventional file unlink (aggr_cnv)                  ... sk=
ip=0A=
>   Test 0074:  Conventional file random write                       ... sk=
ip=0A=
>   Test 0075:  Conventional file random write (direct)              ... sk=
ip=0A=
>   Test 0076:  Conventional file random write (aggr_cnv)            ... sk=
ip=0A=
>   Test 0077:  Conventional file random write (aggr_cnv, direct)    ... sk=
ip=0A=
>   Test 0078:  Conventional file mmap read/write                    ... sk=
ip=0A=
>   Test 0079:  Conventional file mmap read/write (aggr_cnv)         ... sk=
ip=0A=
>   Test 0080:  Sequential file truncate                             ... PA=
SS=0A=
>   Test 0081:  Sequential file unlink                               ... PA=
SS=0A=
>   Test 0082:  Sequential file buffered write IO                    ... PA=
SS=0A=
>   Test 0083:  Sequential file overwrite                            ... PA=
SS=0A=
>   Test 0084:  Sequential file unaligned write (sync IO)            ... PA=
SS=0A=
>   Test 0085:  Sequential file unaligned write (async IO)           ... PA=
SS=0A=
>   Test 0086:  Sequential file append (sync)                        ... PA=
SS=0A=
>   Test 0087:  Sequential file append (async)                       ... PA=
SS=0A=
>   Test 0088:  Sequential file random read                          ... PA=
SS=0A=
>   Test 0089:  Sequential file mmap read/write                      ... PA=
SS=0A=
>   Test 0090:  sequential file 4K synchronous write                 ... PA=
SS=0A=
>   Test 0091:  Sequential file large synchronous write              ... PA=
SS=0A=
> =0A=
> 44 / 46 tests passed=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
