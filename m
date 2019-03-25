Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76297C43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 12:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CE802085A
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 12:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Drz3epJW";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="DzWJk9lD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730899AbfCYM0n (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 08:26:43 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:61066 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730889AbfCYM0n (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 08:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1553516802; x=1585052802;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=QV/oHXdX+wyxPQAvmd7H9VYOo7mavSmvgfBMM8p7d88=;
  b=Drz3epJWmjENbDFpIhZRP1rY3hspgcPdVcBLbLxiZIo9ndL71BaLdR0B
   uNbtSMxFBCXpBmydd8+BuVDL6WHhEfYJQAKVuDik8YDyOQ5pYGSYt5OxZ
   x+6+VLQrminJuCNZESA+PNe5bLMBtF40On4gVFrFEiUA4QSaku/7iLxWS
   FQppfgy8J7sZNS4X+/q6XnpGs8hxrVXQypu91A28u4GitJrGoINe7gfav
   KfsyYTHNGppziQvfwFFD3HGnrD5qPvTvM/r4WnCRKaeJ24TGHZZUNvQBd
   Az9lW+ZkQ8b7QTM396xleNf+3vEVmzKOTUG5KzwP5Ta8I8l79Tv7r1Awp
   A==;
X-IronPort-AV: E=Sophos;i="5.60,256,1549900800"; 
   d="scan'208";a="105894841"
Received: from mail-by2nam05lp2054.outbound.protection.outlook.com (HELO NAM05-BY2-obe.outbound.protection.outlook.com) ([104.47.50.54])
  by ob1.hgst.iphmx.com with ESMTP; 25 Mar 2019 20:26:42 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZFX3LuGU/GT3udWTqeoBqXcg5G7vpQkOeXPvZ8c+a0=;
 b=DzWJk9lDDcSNdxmsqnPrExecYC/EutOEICqh1RphUgC1PMO9ecHR2RUT8UY0eLU/Fz3/DLgt0AfmKu8i2ukbtHFJz1qfJjyV9AAZOQxL6D2I1PPMHly06J1Is9Nq3Aio9mkz1u9/4v5F2v9JfyIf2cHEeGbmvSjmAMd2hOZm/io=
Received: from CY1PR04MB2268.namprd04.prod.outlook.com (10.167.9.7) by
 CY1PR04MB2009.namprd04.prod.outlook.com (10.166.191.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1730.16; Mon, 25 Mar 2019 12:26:39 +0000
Received: from CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::68b3:fe7a:76bd:6c33]) by CY1PR04MB2268.namprd04.prod.outlook.com
 ([fe80::68b3:fe7a:76bd:6c33%6]) with mapi id 15.20.1730.019; Mon, 25 Mar 2019
 12:26:39 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Yi Zhang <yi.zhang@redhat.com>, "osandov@fb.com" <osandov@fb.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] check: add zoned sysfs node checking in
 _test_dev_is_zoned
Thread-Topic: [PATCH blktests] check: add zoned sysfs node checking in
 _test_dev_is_zoned
Thread-Index: AQHU4IcKjy157LlJ/Um710EEqlYAaw==
Date:   Mon, 25 Mar 2019 12:26:39 +0000
Message-ID: <CY1PR04MB2268E117640C7A672F0F1F95ED5E0@CY1PR04MB2268.namprd04.prod.outlook.com>
References: <20190322081228.21898-1-yi.zhang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=shinichiro.kawasaki@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2085082-115b-4746-2569-08d6b11d2196
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:CY1PR04MB2009;
x-ms-traffictypediagnostic: CY1PR04MB2009:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <CY1PR04MB200934183907E565DF6BB719ED5E0@CY1PR04MB2009.namprd04.prod.outlook.com>
x-forefront-prvs: 0987ACA2E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(376002)(396003)(136003)(199004)(189003)(102836004)(3846002)(476003)(6116002)(316002)(106356001)(105586002)(229853002)(53936002)(6436002)(110136005)(25786009)(44832011)(486006)(5660300002)(52536014)(33656002)(446003)(9686003)(6246003)(478600001)(55016002)(4326008)(26005)(81166006)(99286004)(8936002)(305945005)(4744005)(2501003)(7696005)(76176011)(81156014)(186003)(74316002)(8676002)(86362001)(68736007)(6506007)(53546011)(14444005)(71200400001)(2906002)(71190400001)(97736004)(7736002)(14454004)(256004)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR04MB2009;H:CY1PR04MB2268.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: YuHRLLEUDMMppUxgnDJmnrZp2Wpvb/MVWwDy61jZiwNEAb5jI5W1rwq09hqsNIfH1zuRWFRWNytCAQGdcAYHEdiz5xruL+RmBmuOLlv7+ns96I1oumN7ILoHyzl9ginK4Vr1Zj0eltI3G+gaSmQLR2wlS8SSA5C7BuiqW0rDgKiq7vrPHpvJmDoCbE2ATzlCdNftEttkuTUw7M+OXZFUvY+vcJr419B660tbaB4bHWN8NPg3hRndTdHX4y71wm70HEk+Rr5y3y1PMZCBum3K3yZNueLQu3Pq/7fBfyNDsTcl++roMOy2Q6OzEUa6Vg4rfJGZ1+ylKW6PVkco8F3A2L0TLGU9Dcd9Qi01ntRviN1YVGzjPnFBkVG8TLjvJV9FtYtxe+XN0c/uYbJL0pIl+dVO7cyqL54n8sHYnGbhfgI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2085082-115b-4746-2569-08d6b11d2196
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2019 12:26:39.4689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR04MB2009
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/22/19 5:12 PM, Yi Zhang wrote:=0A=
> Some kernel may not have zoned sysfs node, e.g. RHEL7, checking if=0A=
> it exists first in _test_dev_is_zoned.=0A=
> =0A=
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>=0A=
> ---=0A=
>   check | 2 +-=0A=
>   1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/check b/check=0A=
> index f0ca382..459104d 100755=0A=
> --- a/check=0A=
> +++ b/check=0A=
> @@ -405,7 +405,7 @@ _call_test() {=0A=
>   }=0A=
>   =0A=
>   _test_dev_is_zoned() {=0A=
> -	if grep -qe "none" "${TEST_DEV_SYSFS}/queue/zoned" ; then=0A=
> +	if [[ ! -f "${TEST_DEV_SYSFS}/queue/zoned" ]] || grep -qe "none" "${TES=
T_DEV_SYSFS}/queue/zoned" ; then=0A=
>   		SKIP_REASON=3D"${TEST_DEV} is not a zoned block device"=0A=
>   		return 1=0A=
>   	fi=0A=
=0A=
Hi Yi Zhang. This patch looks good for me.=0A=
=0A=
I have prepared Debian oldstable environment with kernel 3.16, which does n=
ot =0A=
support "zoned" sysfs attribute. With this kernel, test cases that has =0A=
test_devices() function and does not have CAN_BE_ZONED=3D1 flag are skipped=
. This =0A=
skip is not expected, and the patch avoids it.=0A=
=0A=
-- =0A=
Best Regards,=0A=
Shin'ichiro Kawasaki=0A=
