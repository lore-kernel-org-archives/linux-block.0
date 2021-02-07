Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3B0C433DB
	for <linux-block@archiver.kernel.org>; Sun,  7 Feb 2021 05:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F50464E8A
	for <linux-block@archiver.kernel.org>; Sun,  7 Feb 2021 05:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhBGFte (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 7 Feb 2021 00:49:34 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:26670 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbhBGFtc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 Feb 2021 00:49:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612676970; x=1644212970;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=catSv9GL89t6YzNiYRnEetDeD8r98QNNyNuzomWOpBg=;
  b=EfgqmgyyxbYffCasWvG0G61zIZguDHLLvt3L1PrKtmGS6rOWh5RToy+m
   /3+3knK1rSkVrTUH5w/oFRVaUALeIyZfbybtfCybJeFoZ6FjGKHXsq1Uw
   bgtR0ybgjngRNgpaRAgzxzhhZV7MMo95srviUVx1vgZewOxEwygSYtCFh
   olwRKgLdw/1B/ybGuZAIts6i7OwQcYyBV9M68ymW0pYj4Iefb90kCPTGJ
   hv7bliY+LPvGg+klF1OqnxZrdeNoW8Gj8x+UQy/bq+lGu2Oof2cmtQ8QZ
   tWflGp9XqrmSExHNf3D6XLA32RZWsj//OuSFXnr5cpBY5b3lw7TYa2WkC
   Q==;
IronPort-SDR: 2tPU/ugxa7VB3ePvEQO2cB5sFg7AfUzpsjXigC2jZnHcY1wqDgL2NSIpIkuVhO2CpEgwpdNMdh
 tYMz34cm4BJuQhkyV2739LEPbpCcSWhOZw9l96f6OBIvytZZtoWl/d1UVYI5jfg2qVeoDwWXhG
 kP+b8v7Tc8+dQGJBHvuUvgmVzxCobujFq/TvLtHxsFkiPy/B4/LjF7jwOBLBwDvcqVHAaw8EAg
 zeSakeAYdzlEj3z0XE761ohh5DLbcbDSnVMGgdVOUvvvZ2pfkTVsPcn5LrddDrbPz7WyZtB+9S
 PVI=
X-IronPort-AV: E=Sophos;i="5.81,159,1610380800"; 
   d="scan'208";a="159361627"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2021 13:48:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBAQDnEyhhjsUDchHvvmCM/5Mp+8Wg5XGA3Ys/dNDD6YMKTUa9kRqcDp/Lwd6MbW7ZXXs2Z4AT0SfpBwQd1RdP/ZG3btNtNZI4HU8xQs37WMv3nMPOCepYdgS6E/1eTxbtiiAmmjnz/jmzjHG2wmDPMLyoze0yK1LWwESj0ajWpqvTYAvnMn9HDWOCoFPO4CuXFD/XBkMo+O1sEG2zZT/A/1KV71oopb9rz0YaIKv+1NXZHVbTaHSzS7DvPrSMZKGbQ6C68ZZa7iwq2OPw1Qo6bAWqiRtmff2tveX/1CsdthGgpnkKlbIewHMUlG5VgQr1zguP9Mv9dQnggwd7Ym4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRFgVR/W9wJFsjP5BvBS7rO/dpMHjolX6KQ6vHKOZm8=;
 b=Do9QouH+usO+by6O/1NfxtG7a3n/Ovl3y/kh9sPJYagOwpTAla9iryTlenp/7I2cjaeN4po5cedT9rQTMIbI6Dcfi6tUSyx4utfpCxm8uisScWnmcO/bMHPEU0qes//I/25eAdc5u9X14hWoI6lJbqxn0fCOFZ0f4DkuwAtHQYc6Rhn0qplZL6ld/YYz7Wbi1DlBH3tHXdac3DY5fWS2IZ10FqdU8i21QDSgGmqqclR5vQmQsc6B9xspRzY7I9E8i5jcsb8mv7Kaz603dB0gLNbQ9r0tIF2MbHKW/q+eSV6iX7l3FnHHf/sTNA3YvSj5sgWkSqtvPEAkNtjA08rAMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WRFgVR/W9wJFsjP5BvBS7rO/dpMHjolX6KQ6vHKOZm8=;
 b=Q5gjRASfJ1g/lT+t4vwSINKbeyfVE2DaYvOofBbjw+qSXLXjoOdXwP98YvsyeouJ9XFCWHwKycj+fnB03d7y9A7Fe4XKA1XhV3YqYGf9oZWNv5LSPnhdmNw1sf7BDAz+S/3ctY7RignVODP2mZUwBsFgqzOMfL/gag+MqJr+3JM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5430.namprd04.prod.outlook.com (2603:10b6:a03:c7::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.24; Sun, 7 Feb
 2021 05:48:23 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3825.027; Sun, 7 Feb 2021
 05:48:23 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Yi Zhang <yi.zhang@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-block <linux-block@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        Rachel Sibley <rasibley@redhat.com>,
        CKI Project <cki-project@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: Re: kernel null pointer at nvme_tcp_init_iter[nvme_tcp] with blktests
 nvme-tcp/012
Thread-Topic: kernel null pointer at nvme_tcp_init_iter[nvme_tcp] with
 blktests nvme-tcp/012
Thread-Index: AQHW/Qz4wyJ1jVpJcE2ugUQsAFy3zQ==
Date:   Sun, 7 Feb 2021 05:48:22 +0000
Message-ID: <BYAPR04MB4965A152E9796C95C72C80D186B09@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <cki.F3E139361A.EN5MUSJKK9@redhat.com>
 <630237787.11660686.1612580898410.JavaMail.zimbra@redhat.com>
 <80b7184e-cdfb-cebc-fe07-a228ce57a9e7@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 22042043-e742-4574-d315-08d8cb2bfb4c
x-ms-traffictypediagnostic: BYAPR04MB5430:
x-microsoft-antispam-prvs: <BYAPR04MB54303FFB5E24F56F8BC8323986B09@BYAPR04MB5430.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rLmuKCPXaw9+HKnQM6ZHWiFfQYWwmyW8WxpCbYazIuDN7DTH0bP3Nsg/LMZmdFqQyYzzCuFjew71rZgP6m+seEtInoTUH7YP+xp6Xvz6OlTCdeLGWeM8V1pJGPsA9lVRT+ixMHxwNtovsIXzZpgBc4WeIfGTggLpZxytpYPGy4Z8k/hzREVd10Ylr2gocv5BQiNMaQ8nzixVLivl9Dk2EhvLY+q64Om65WIf43ogPajd+ylaOhNZAbrSxr3aFFWKeCqgdPJfVeBW+mmTqT7ilHmk8PyWxRgTawRAX6nwacrRVyCauxzkEBhu5JDIi+JQZIFdgO1Vz1mIdwLx6yWge+h5j4ZCfl5vhAr5SwxFu8QvOQPQQDXAeCR2UQIm7n3Ey8IdJaLYTS2XQkN3dE+pLNSImQZizrExV2YkgEaePZjdy8j7R11AqAGckzT+eC0UmTLJ37SroQlU6p+dXmOKZoohNUAYQJbBXwp2D/JJhefKVilhAeao7R6gMLBFfjUB1irTaPdlWVihNoSWnC0PQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(83380400001)(8676002)(86362001)(8936002)(2906002)(33656002)(478600001)(4326008)(66946007)(66446008)(52536014)(186003)(26005)(76116006)(5660300002)(53546011)(6506007)(54906003)(316002)(30864003)(110136005)(64756008)(71200400001)(66556008)(55016002)(9686003)(66476007)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?yZgF375fmWqpuJfbwBFq3fcuJSPM0qOxk6rTsl8w6HKFv3ZhYyoqOB8MLw4G?=
 =?us-ascii?Q?ZIrBX6M6uo0fh8nuszXReYrWWhe+wmmCzBBfn6m+RloeutLq2DSIlebekjol?=
 =?us-ascii?Q?6GDR/3fOvBUyrHGGKkKwoXunzBV9bD9tSB0mo+shE+oWBYM9AaYV0znPnwC6?=
 =?us-ascii?Q?zhAVBkufEcEiLcfe+u5WpS2b93Ea7pe9kU3rkRPnB9gja8ZcvwkiQQkdvHwm?=
 =?us-ascii?Q?6MsHuM9S/DPwr/ixVT48Pz4BQVRxCa0Miya/WepVIL62ySqmb0boN05LrbSt?=
 =?us-ascii?Q?6twQQcx5oqjvQX0yC3esfHucnsQMUeFJrf4DeqfDpoh8fX7b+2CPX6LzsjFy?=
 =?us-ascii?Q?x/VcpSQNNTDJYrTaDk2WyiiNrfp+dHa2mOUnDqPQSB56MZx5QuYwacIXz5gE?=
 =?us-ascii?Q?z1MKAKoTEEcI6BI7d2ORsogOMwECBb4AXdu/YUsYy++De1g7LHHWr9aeM+BP?=
 =?us-ascii?Q?ocq9D+bwmjo6Vix0St3ZHclT1KsO1o4JMYCPwhwkuMv4PkKpHagg8bOljlar?=
 =?us-ascii?Q?QeXAUcTSTxb2I/cYQBslpRn3EOkv6kuG2Y0pMOTa1k5095lipvY7ZKFa2sJg?=
 =?us-ascii?Q?drQbHc+mQPheAfzPODHPIl2KS1b9FUYgJVZ9ZZXAOHXPxC8EtV4kejXPEM5z?=
 =?us-ascii?Q?ZHzRpNcxefnMol/gJIP1kWtRCg7pAaxnZd43cFbtdp6qUy1kk8I93Dc5MWUh?=
 =?us-ascii?Q?R8Ndo1oDDp6SDTTJZLUYzW4sD/jqR19Wu/nJKhEICBXuZLOYRlsvuaT8p0e+?=
 =?us-ascii?Q?bfUzfE4uZCS4AlM38z2x/azDlDd1slncuSwPEbrk8yy/BhAxkGfNPg6ObYtL?=
 =?us-ascii?Q?7UvpgPE5gfPyM7qJALr6FXY8T8O8IYkcOGUU4A7aviNEoZNmpnZ4xwAtTsHS?=
 =?us-ascii?Q?EUEjaJ65Y5UDiVEu37rallUDvFQd2IwjZR0SRHmYmhewVYOsl3isyGVE6Qst?=
 =?us-ascii?Q?xUpZ1fkh/RqMiyt8FcqCINg25eDh2U7E42n6wlHEajMUQj/ogwkSj66Onx9/?=
 =?us-ascii?Q?LupTvK4ONGGrt28xYo1cu07iEwlAeVpcQyIGItzZ/SNpbjqEDdcSLQsbldtX?=
 =?us-ascii?Q?Ix16aSbh6niLWc9Xq0mmn47SkjWXtUi7u58aVKWd43EVUo3Ay1Dz2QvskyqZ?=
 =?us-ascii?Q?QAwoIrkNhuMxHZG1a/qwht3YO/Iw+Hjy5ebzAxoFxx4Qa3VD+Lx3v3DM5wMR?=
 =?us-ascii?Q?KUSvkZhNvSptiHUytIyyGVF3gHauxPKgucEZzJu14GKVaEk17EY+EhXqujgH?=
 =?us-ascii?Q?TK/yZo+HyVB1AKNJA6b1Rux1fnhCvF+mamDE9YvZcBOb8ifZTqnDVVslDwPU?=
 =?us-ascii?Q?o4O8qjCPG3b0XA7fdM8ekFPB?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22042043-e742-4574-d315-08d8cb2bfb4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2021 05:48:22.9975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r6G1D2CaiiIsS6T7ew4nfKyzLmNRd2C7e/5z3YPTv91+KN9ZoVYrpy82dt8ETkISVDmTIof2Pws1qJ9SHwFR8wbLdlpWp6WSH19cw1/9W00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5430
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/6/21 20:51, Yi Zhang wrote:=0A=
> The issue was introduced after merge the NVMe updates=0A=
>=0A=
> commit 0fd6456fd1f4c8f3ec5a2df6ed7f34458a180409 (HEAD)=0A=
> Merge: 44d10e4b2f2c 0d7389718c32=0A=
> Author: Jens Axboe <axboe@kernel.dk>=0A=
> Date:   Tue Feb 2 07:12:06 2021 -0700=0A=
>=0A=
>      Merge branch 'for-5.12/drivers' into for-next=0A=
>=0A=
>      * for-5.12/drivers: (22 commits)=0A=
>        nvme-tcp: use cancel tagset helper for tear down=0A=
>        nvme-rdma: use cancel tagset helper for tear down=0A=
>        nvme-tcp: add clean action for failed reconnection=0A=
>        nvme-rdma: add clean action for failed reconnection=0A=
>        nvme-core: add cancel tagset helpers=0A=
>        nvme-core: get rid of the extra space=0A=
>        nvme: add tracing of zns commands=0A=
>        nvme: parse format nvm command details when tracing=0A=
>        nvme: update enumerations for status codes=0A=
>        nvmet: add lba to sect conversion helpers=0A=
>        nvmet: remove extra variable in identify ns=0A=
>        nvmet: remove extra variable in id-desclist=0A=
>        nvmet: remove extra variable in smart log nsid=0A=
>        nvme: refactor ns->ctrl by request=0A=
>        nvme-tcp: pass multipage bvec to request iov_iter=0A=
>        nvme-tcp: get rid of unused helper function=0A=
>        nvme-tcp: fix wrong setting of request iov_iter=0A=
>        nvme: support command retry delay for admin command=0A=
>        nvme: constify static attribute_group structs=0A=
>        nvmet-fc: use RCU proctection for assoc_list=0A=
>=0A=
>=0A=
> On 2/6/21 11:08 AM, Yi Zhang wrote:=0A=
>> blktests nvme-tcp/012=0A=
>=0A=
Running the test few times I got this once no sign of Oops though  :-=0A=
=0A=
=0A=
# nvme_trtype=3Dtcp ./check nvme/012=0A=
nvme/012 (run mkfs and data verification fio job on NVMeOF block=0A=
device-backed ns) [failed]=0A=
    runtime  37.624s  ...  42.272s=0A=
    something found in dmesg:=0A=
    [   69.198819] run blktests nvme/012 at 2021-02-06 21:32:23=0A=
    [   69.330277] loop: module loaded=0A=
    [   69.333383] loop0: detected capacity change from 2097152 to 0=0A=
    [   69.351091] nvmet: adding nsid 1 to subsystem blktests-subsystem-1=
=0A=
    [   69.372439] nvmet_tcp: enabling port 0 (127.0.0.1:4420)=0A=
    [   69.396581] nvmet: creating controller 1 for subsystem=0A=
blktests-subsystem-1 for NQN=0A=
nqn.2014-08.org.nvmexpress:uuid:e4cfc949-8f19-4db2-a232-ab360b79204a.=0A=
    [   69.399482] nvme nvme1: creating 64 I/O queues.=0A=
    [   69.414721] nvme nvme1: mapped 64/0/0 default/read/poll queues.=0A=
    [   69.448193] nvme nvme1: new ctrl: NQN "blktests-subsystem-1",=0A=
addr 127.0.0.1:4420=0A=
    [   72.381282] XFS (nvme1n1): Mounting V5 Filesystem=0A=
    ...=0A=
    (See '/root/blktests/results/nodev/nvme/012.dmesg' for the entire=0A=
message)=0A=
blktests (master) # dmesg  -c=0A=
[   38.347661] nvme nvme0: 63/0/0 default/read/poll queues=0A=
[   69.198819] run blktests nvme/012 at 2021-02-06 21:32:23=0A=
[   69.330277] loop: module loaded=0A=
[   69.333383] loop0: detected capacity change from 2097152 to 0=0A=
[   69.351091] nvmet: adding nsid 1 to subsystem blktests-subsystem-1=0A=
[   69.372439] nvmet_tcp: enabling port 0 (127.0.0.1:4420)=0A=
[   69.396581] nvmet: creating controller 1 for subsystem=0A=
blktests-subsystem-1 for NQN=0A=
nqn.2014-08.org.nvmexpress:uuid:e4cfc949-8f19-4db2-a232-ab360b79204a.=0A=
[   69.399482] nvme nvme1: creating 64 I/O queues.=0A=
[   69.414721] nvme nvme1: mapped 64/0/0 default/read/poll queues.=0A=
[   69.448193] nvme nvme1: new ctrl: NQN "blktests-subsystem-1", addr=0A=
127.0.0.1:4420=0A=
[   72.381282] XFS (nvme1n1): Mounting V5 Filesystem=0A=
[   72.394603] XFS (nvme1n1): Ending clean mount=0A=
[   72.395463] xfs filesystem being mounted at /mnt/blktests supports=0A=
timestamps until 2038 (0x7fffffff)=0A=
=0A=
[   73.402838] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A=
[   73.403491] WARNING: possible circular locking dependency detected=0A=
[   73.404125] 5.11.0-rc6blk+ #166 Tainted: G           OE   =0A=
[   73.404690] ------------------------------------------------------=0A=
[   73.405332] fio/3671 is trying to acquire lock:=0A=
[   73.405803] ffff88881d110cb0 (sk_lock-AF_INET){+.+.}-{0:0}, at:=0A=
tcp_sendpage+0x23/0x50=0A=
[   73.406627]=0A=
but task is already holding lock:=0A=
[   73.407246] ffff888128cabcf0 (&xfs_dir_ilock_class/5){+.+.}-{3:3},=0A=
at: xfs_ilock+0xbf/0x250 [xfs]=0A=
[   73.408233]=0A=
which lock already depends on the new lock.=0A=
=0A=
[   73.409096]=0A=
the existing dependency chain (in reverse order) is:=0A=
[   73.409885]=0A=
-> #3 (&xfs_dir_ilock_class/5){+.+.}-{3:3}:=0A=
[   73.410594]        lock_acquire+0xd2/0x390=0A=
[   73.411045]        down_write_nested+0x47/0x110=0A=
[   73.411530]        xfs_ilock+0xbf/0x250 [xfs]=0A=
[   73.412068]        xfs_create+0x1d9/0x6b0 [xfs]=0A=
[   73.412626]        xfs_generic_create+0x205/0x2c0 [xfs]=0A=
[   73.413255]        lookup_open+0x4f6/0x630=0A=
[   73.413710]        path_openat+0x298/0xa80=0A=
[   73.414158]        do_filp_open+0x93/0x100=0A=
[   73.414606]        do_sys_openat2+0x24b/0x310=0A=
[   73.415090]        do_sys_open+0x4b/0x80=0A=
[   73.415569]        do_syscall_64+0x33/0x40=0A=
[   73.416075]        entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
[   73.416747]=0A=
-> #2 (sb_internal){.+.+}-{0:0}:=0A=
[   73.417436]        lock_acquire+0xd2/0x390=0A=
[   73.417938]        xfs_trans_alloc+0x19e/0x2e0 [xfs]=0A=
[   73.418607]        xfs_vn_update_time+0xc8/0x250 [xfs]=0A=
[   73.419295]        touch_atime+0x16b/0x200=0A=
[   73.419814]        xfs_file_mmap+0xa7/0xb0 [xfs]=0A=
[   73.420447]        mmap_region+0x3f6/0x690=0A=
[   73.420955]        do_mmap+0x379/0x580=0A=
[   73.421415]        vm_mmap_pgoff+0xdf/0x170=0A=
[   73.421929]        ksys_mmap_pgoff+0x1dd/0x240=0A=
[   73.422477]        do_syscall_64+0x33/0x40=0A=
[   73.422980]        entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
[   73.423672]=0A=
-> #1 (&mm->mmap_lock#2){++++}-{3:3}:=0A=
[   73.424426]        lock_acquire+0xd2/0x390=0A=
[   73.424932]        __might_fault+0x5e/0x80=0A=
[   73.425433]        _copy_from_user+0x1e/0xa0=0A=
[   73.425966]        do_ip_setsockopt.isra.15+0xbba/0x12f0=0A=
[   73.426616]        ip_setsockopt+0x34/0x90=0A=
[   73.427120]        __sys_setsockopt+0x8f/0x110=0A=
[   73.427681]        __x64_sys_setsockopt+0x20/0x30=0A=
[   73.428252]        do_syscall_64+0x33/0x40=0A=
[   73.428751]        entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
[   73.429422]=0A=
-> #0 (sk_lock-AF_INET){+.+.}-{0:0}:=0A=
[   73.430154]        validate_chain+0x8fa/0xec0=0A=
[   73.430681]        __lock_acquire+0x563/0x940=0A=
[   73.431212]        lock_acquire+0xd2/0x390=0A=
[   73.431719]        lock_sock_nested+0x72/0xa0=0A=
[   73.432252]        tcp_sendpage+0x23/0x50=0A=
[   73.432740]        inet_sendpage+0x4f/0x80=0A=
[   73.433240]        kernel_sendpage+0x57/0xc0=0A=
[   73.433760]        nvme_tcp_try_send+0x137/0x7d0 [nvme_tcp]=0A=
[   73.434435]        nvme_tcp_queue_rq+0x317/0x330 [nvme_tcp]=0A=
[   73.435104]        __blk_mq_try_issue_directly+0x109/0x1b0=0A=
[   73.435768]        blk_mq_request_issue_directly+0x4b/0x80=0A=
[   73.436433]        blk_mq_try_issue_list_directly+0x62/0xf0=0A=
[   73.437104]        blk_mq_sched_insert_requests+0x192/0x2b0=0A=
[   73.437774]        blk_mq_flush_plug_list+0x13c/0x260=0A=
[   73.438389]        blk_flush_plug_list+0xd7/0x100=0A=
[   73.438960]        blk_finish_plug+0x21/0x30=0A=
[   73.439485]        _xfs_buf_ioapply+0x2cc/0x3c0 [xfs]=0A=
[   73.440171]        __xfs_buf_submit+0x85/0x220 [xfs]=0A=
[   73.440833]        xfs_buf_read_map+0x105/0x2a0 [xfs]=0A=
[   73.441511]        xfs_trans_read_buf_map+0x2b2/0x610 [xfs]=0A=
[   73.442254]        xfs_read_agi+0xb4/0x1d0 [xfs]=0A=
[   73.442874]        xfs_ialloc_read_agi+0x48/0x170 [xfs]=0A=
[   73.443568]        xfs_dialloc_select_ag+0x94/0x2a0 [xfs]=0A=
[   73.444277]        xfs_dir_ialloc+0x72/0x630 [xfs]=0A=
[   73.444927]        xfs_create+0x241/0x6b0 [xfs]=0A=
[   73.445550]        xfs_generic_create+0x205/0x2c0 [xfs]=0A=
[   73.446255]        lookup_open+0x4f6/0x630=0A=
[   73.446759]        path_openat+0x298/0xa80=0A=
[   73.447268]        do_filp_open+0x93/0x100=0A=
[   73.447770]        do_sys_openat2+0x24b/0x310=0A=
[   73.448301]        do_sys_open+0x4b/0x80=0A=
[   73.448779]        do_syscall_64+0x33/0x40=0A=
[   73.449275]        entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
[   73.449944]=0A=
other info that might help us debug this:=0A=
=0A=
[   73.450899] Chain exists of:=0A=
  sk_lock-AF_INET --> sb_internal --> &xfs_dir_ilock_class/5=0A=
=0A=
[   73.452222]  Possible unsafe locking scenario:=0A=
=0A=
[   73.452931]        CPU0                    CPU1=0A=
[   73.453479]        ----                    ----=0A=
[   73.454024]   lock(&xfs_dir_ilock_class/5);=0A=
[   73.454528]                                lock(sb_internal);=0A=
[   73.455217]                                lock(&xfs_dir_ilock_class/5);=
=0A=
[   73.456027]   lock(sk_lock-AF_INET);=0A=
[   73.456463]=0A=
 *** DEADLOCK ***=0A=
=0A=
[   73.457175] 6 locks held by fio/3671:=0A=
[   73.457618]  #0: ffff8881185a9488 (sb_writers#9){.+.+}-{0:0}, at:=0A=
path_openat+0xa61/0xa80=0A=
[   73.458604]  #1: ffff888128cabfe0=0A=
(&inode->i_sb->s_type->i_mutex_dir_key){++++}-{3:3}, at:=0A=
path_openat+0x287/0xa80=0A=
[   73.459847]  #2: ffff8881185a96a8 (sb_internal){.+.+}-{0:0}, at:=0A=
xfs_create+0x1b4/0x6b0 [xfs]=0A=
[   73.460926]  #3: ffff888128cabcf0=0A=
(&xfs_dir_ilock_class/5){+.+.}-{3:3}, at: xfs_ilock+0xbf/0x250 [xfs]=0A=
[   73.462100]  #4: ffff88881bd54c58 (hctx->srcu){....}-{0:0}, at:=0A=
hctx_lock+0x62/0xe0=0A=
[   73.463029]  #5: ffff888142ab29d0 (&queue->send_mutex){+.+.}-{3:3},=0A=
at: nvme_tcp_queue_rq+0x2fc/0x330 [nvme_tcp]=0A=
[   73.464288]=0A=
stack backtrace:=0A=
[   73.464824] CPU: 16 PID: 3671 Comm: fio Tainted: G           OE    =0A=
5.11.0-rc6blk+ #166=0A=
[   73.465785] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),=0A=
BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014=0A=
[   73.467176] Call Trace:=0A=
[   73.467483]  dump_stack+0x8d/0xb5=0A=
[   73.467910]  check_noncircular+0x119/0x130=0A=
[   73.468413]  ? save_trace+0x3d/0x2c0=0A=
[   73.468854]  validate_chain+0x8fa/0xec0=0A=
[   73.469329]  __lock_acquire+0x563/0x940=0A=
[   73.469800]  lock_acquire+0xd2/0x390=0A=
[   73.470240]  ? tcp_sendpage+0x23/0x50=0A=
[   73.470689]  lock_sock_nested+0x72/0xa0=0A=
[   73.471163]  ? tcp_sendpage+0x23/0x50=0A=
[   73.471624]  tcp_sendpage+0x23/0x50=0A=
[   73.472059]  inet_sendpage+0x4f/0x80=0A=
[   73.472504]  kernel_sendpage+0x57/0xc0=0A=
[   73.472965]  ? mark_held_locks+0x4f/0x70=0A=
[   73.473445]  nvme_tcp_try_send+0x137/0x7d0 [nvme_tcp]=0A=
[   73.474062]  nvme_tcp_queue_rq+0x317/0x330 [nvme_tcp]=0A=
[   73.474697]  __blk_mq_try_issue_directly+0x109/0x1b0=0A=
[   73.475324]  blk_mq_request_issue_directly+0x4b/0x80=0A=
[   73.475953]  blk_mq_try_issue_list_directly+0x62/0xf0=0A=
[   73.476587]  blk_mq_sched_insert_requests+0x192/0x2b0=0A=
[   73.477225]  blk_mq_flush_plug_list+0x13c/0x260=0A=
[   73.477802]  blk_flush_plug_list+0xd7/0x100=0A=
[   73.478338]  blk_finish_plug+0x21/0x30=0A=
[   73.478818]  _xfs_buf_ioapply+0x2cc/0x3c0 [xfs]=0A=
[   73.479457]  __xfs_buf_submit+0x85/0x220 [xfs]=0A=
[   73.480091]  xfs_buf_read_map+0x105/0x2a0 [xfs]=0A=
[   73.480728]  ? xfs_read_agi+0xb4/0x1d0 [xfs]=0A=
[   73.481331]  xfs_trans_read_buf_map+0x2b2/0x610 [xfs]=0A=
[   73.482036]  ? xfs_read_agi+0xb4/0x1d0 [xfs]=0A=
[   73.482635]  xfs_read_agi+0xb4/0x1d0 [xfs]=0A=
[   73.483221]  xfs_ialloc_read_agi+0x48/0x170 [xfs]=0A=
[   73.483866]  xfs_dialloc_select_ag+0x94/0x2a0 [xfs]=0A=
[   73.484513]  xfs_dir_ialloc+0x72/0x630 [xfs]=0A=
[   73.485092]  ? xfs_ilock+0xbf/0x250 [xfs]=0A=
[   73.485648]  xfs_create+0x241/0x6b0 [xfs]=0A=
[   73.486198]  xfs_generic_create+0x205/0x2c0 [xfs]=0A=
[   73.486857]  lookup_open+0x4f6/0x630=0A=
[   73.487317]  path_openat+0x298/0xa80=0A=
[   73.487786]  ? __lock_acquire+0x581/0x940=0A=
[   73.488302]  do_filp_open+0x93/0x100=0A=
[   73.488769]  ? do_raw_spin_unlock+0x49/0xc0=0A=
[   73.489307]  ? _raw_spin_unlock+0x1f/0x30=0A=
[   73.489825]  do_sys_openat2+0x24b/0x310=0A=
[   73.490321]  do_sys_open+0x4b/0x80=0A=
[   73.490764]  do_syscall_64+0x33/0x40=0A=
[   73.491230]  entry_SYSCALL_64_after_hwframe+0x44/0xa9=0A=
[   73.491890] RIP: 0033:0x7f7d6f2eaead=0A=
[   73.492353] Code: c5 20 00 00 75 10 b8 02 00 00 00 0f 05 48 3d 01 f0=0A=
ff ff 73 31 c3 48 83 ec 08 e8 7e f4 ff ff 48 89 04 24 b8 02 00 00 00 0f=0A=
05 <48> 8b 3c 24 48 89 c2 e8 c7 f4 ff ff 48 89 d0 48 83 c4 08 48 3d 01=0A=
[   73.494713] RSP: 002b:00007ffc072e8910 EFLAGS: 00000293 ORIG_RAX:=0A=
0000000000000002=0A=
[   73.495671] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:=0A=
00007f7d6f2eaead=0A=
[   73.496526] RDX: 00000000000001a4 RSI: 0000000000000041 RDI:=0A=
00007f7d6d666690=0A=
[   73.497381] RBP: 0000000000000000 R08: 0000000000000041 R09:=0A=
0000000000000041=0A=
[   73.498232] R10: 00007ffc072e85a0 R11: 0000000000000293 R12:=0A=
0000000000000000=0A=
[   73.499121] R13: 000000003b600000 R14: 00007f7d47136000 R15:=0A=
00007f7d6d666510=0A=
[  111.135896] XFS (nvme1n1): Unmounting Filesystem=0A=
[  111.308034] nvme nvme1: Removing ctrl: NQN "blktests-subsystem-1"=0A=
=0A=
