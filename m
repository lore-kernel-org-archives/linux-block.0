Return-Path: <SRS0=zSf2=RQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EF4C43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:48:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C26DA2054F
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 17:48:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oi/hsEmH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="No71dLuf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfCMRsJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Mar 2019 13:48:09 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:39030 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfCMRsJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Mar 2019 13:48:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1552499288; x=1584035288;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=FED3bd8MxmeO0477KOVZkHsluLHLO5b5c2VDZDnItQI=;
  b=oi/hsEmH4D8HDK9eJrPvqh/INOLjPa/PJYNlDSqKwdLcbLH5x6RzIp9u
   eLWAyvL7YHOgzqxL7kELKAc0sUEttxb51uF7Zz7xQYsS7V+YJxRkbwI4M
   NAWErPvKEp6HcRKXJ2EpsKj2NY4ux4kMda477NxcboqIZrrgt5d46/D8H
   ExgJXPqSAs94EADkcsEimSZ2H3O+6qW/aC0TtQkX+kR/7Byk04VwOb2S6
   3V1GNBkabsS16+ege5vZjxP2yDCX1iNosacqyz5PupV+CuER1sv+n3LWv
   Dq1xHdM5Gf2BtpW6TaAhaR8tOlSDgpqFezrpa79H8QG4kIcg1INHewaBO
   w==;
X-IronPort-AV: E=Sophos;i="5.58,475,1544457600"; 
   d="scan'208";a="104696486"
Received: from mail-sn1nam04lp2055.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.55])
  by ob1.hgst.iphmx.com with ESMTP; 14 Mar 2019 01:48:08 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector1-wdc-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGxE5ezdkCdRLC6VnE4OZOVLXge6WgZzBS/t/WwhKmI=;
 b=No71dLufi3GqxFFv62QZmrNem0k62v4zoYcwvQ0PP1L/ENh5jt8ThywrG2vpKXERsz5q3Qap1vG/AjlVWn9cbO9JlRYSpuHC9lcfHya1CxdA4aOpzeBFtiNm2FByRFY8uPuX9l6dY7sD+5nVy2TtPRcCodLbDMzXAC/YCDDvJWY=
Received: from SN6PR04MB4527.namprd04.prod.outlook.com (52.135.120.25) by
 SN6PR04MB4734.namprd04.prod.outlook.com (52.135.122.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1709.13; Wed, 13 Mar 2019 17:48:07 +0000
Received: from SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::7db4:149f:d1a5:e3fd]) by SN6PR04MB4527.namprd04.prod.outlook.com
 ([fe80::7db4:149f:d1a5:e3fd%4]) with mapi id 15.20.1686.021; Wed, 13 Mar 2019
 17:48:07 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Xiao Liang <xiliang@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "osandov@fb.com" <osandov@fb.com>
Subject: Re: [PATCH blktests] Fix checking multiple modules error in
 _have_modules()
Thread-Topic: [PATCH blktests] Fix checking multiple modules error in
 _have_modules()
Thread-Index: AQHU2WslIh/RLy6KTE6KQH9mIfGhXw==
Date:   Wed, 13 Mar 2019 17:48:06 +0000
Message-ID: <SN6PR04MB4527460F98A4F64F9F22138A864A0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190313070511.8283-1-xiliang@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Chaitanya.Kulkarni@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bc2b2151-021f-4f72-3414-08d6a7dc0ce7
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600127)(711020)(4605104)(4618075)(2017052603328)(7153060)(7193020);SRVR:SN6PR04MB4734;
x-ms-traffictypediagnostic: SN6PR04MB4734:
wdcipoutbound: EOP-TRUE
x-microsoft-antispam-prvs: <SN6PR04MB47344032FABDBA162B74F96B864A0@SN6PR04MB4734.namprd04.prod.outlook.com>
x-forefront-prvs: 09752BC779
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(376002)(366004)(396003)(39860400002)(136003)(199004)(189003)(2501003)(25786009)(6246003)(97736004)(229853002)(86362001)(7696005)(2201001)(6116002)(3846002)(2906002)(74316002)(52536013)(7736002)(26005)(14454004)(305945005)(4744005)(478600001)(9686003)(72206003)(105586002)(106356001)(55016002)(53936002)(68736007)(71190400001)(71200400001)(186003)(66066001)(446003)(102836004)(5660300002)(6436002)(8936002)(256004)(14444005)(53546011)(476003)(6506007)(486006)(8676002)(33656002)(316002)(76176011)(110136005)(81166006)(99286004)(81156014);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR04MB4734;H:SN6PR04MB4527.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: P5EUyd3EFNLAgMeOXcy8nEGDwcwEqfTBYprt5dCL5voHF5QoEUpJE7kXeh/rtCSXENOjn9gZuTtJfYJ94kNuPkxYptC64fCc/lxC6fWHBuEZl2QLvhtGL76ydVA76FV9E2OTBp9CnFf9XPQXYMyTVb4B28rkC4K0NrJrQwoevca4+CALsRxq2RtPpogK5ZNBt50Q1zcU+25e6DaseQr8A/9mMYymwh8U+yXIMc8U+cyLuyq/H8P3rrcUlvKBCCUzjOXunP/AiN+96eHqrZZyvv4ls7NUGbzWYb06s0jZX/XXX7Hp+3z+h0+akOD4hNkQO3Lg24Z4TXEJ4hcZLaojo7/KO4EuN0WefLM3lSJiO7wYHBxgmBK4qa6wKgWEhjGPGAIz9GDWA10cXJDnkJwIXhocW6M717aQ4gPOm+EM6rg=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc2b2151-021f-4f72-3414-08d6a7dc0ce7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2019 17:48:06.9225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4734
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good.=0A=
=0A=
Reviewed-by : Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
On 3/13/19 12:05 AM, Xiao Liang wrote:=0A=
> Signed-off-by: Xiao Liang <xiliang@redhat.com>=0A=
> ---=0A=
>   common/rc | 2 +-=0A=
>   1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/common/rc b/common/rc=0A=
> index 0c354a2..71e27c3 100644=0A=
> --- a/common/rc=0A=
> +++ b/common/rc=0A=
> @@ -33,7 +33,7 @@ _have_modules() {=0A=
>   	local module=0A=
>   =0A=
>   	for module in "$@"; do=0A=
> -		if ! modprobe -n -q "$1"; then=0A=
> +		if ! modprobe -n -q "$module"; then=0A=
>   			missing+=3D("$module")=0A=
>   		fi=0A=
>   	done=0A=
> =0A=
=0A=
