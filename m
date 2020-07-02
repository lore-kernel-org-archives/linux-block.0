Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C4CC433DF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 04:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB50C20737
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 04:35:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="AU4nh3po";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="X74D3Ft5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgGBEfC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 00:35:02 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:52408 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgGBEfB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 00:35:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1593664501; x=1625200501;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=wfRWlKpz7KbxcrmG3vi8GQ5gDSUY1SdTbEXujSCPes8=;
  b=AU4nh3pomGR9jKc53qQeYKb4BvQHXWvB4X2sZlar4HWT6886fDazNGII
   b2dAoHnpEymCGQUGmMSvBhUs8ZuCYD1eC2TksAFzV1tAqUmVJ9ALLUXaq
   cYAln7Ho8R6MeycbSQxUzag+zzA2I9zbqlS26Jo1/kuzDFRvThYc24q7M
   4BhYc9j9zvlggB5nfoY1g66S0lZtvg+lngGylD0XHL+o2hKqpZ7pL/0hE
   0DO7s0ppcKeGQVGayYmihkbsP4M8ky/qxpgi8LiT6+T1On/JXdQvtKofz
   ixRoUq4dpC77JcRTBJwApGgBBRhfMbKGw/kZV4kTGIT+W+h5bqE1dBO6o
   g==;
IronPort-SDR: SGVY3hnnSL6G3Xhi+b/rQEMMO4yBBUG1j66gBdBG3fYsCF+JorsU3JFYkP0HNxBm5gl2MB3TgM
 4BVP2a467yF0yLuBGUgTTJ5hmO2PXr2ifEYsLXJL4UkVPIa7toCrnuvfX9/Jg414ZbYwz05cqm
 sj4qcsJ8XoydUjvkhuvu5vbGtCyfSo15Lj4KvQ/aCb3uPT03mJIIwviXyn1R+iFuEtQ1Qf5oNy
 Qwxr9RhPJBHJTuFP3kgbVuLpbsnaVnI/uR8WVAyLiXW3gzBeqpHwyp4ZrZA1/M2S3tj02m34DN
 qOE=
X-IronPort-AV: E=Sophos;i="5.75,302,1589212800"; 
   d="scan'208";a="141449884"
Received: from mail-co1nam11lp2175.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.175])
  by ob1.hgst.iphmx.com with ESMTP; 02 Jul 2020 12:35:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbsZT4ZtAzJp15QMsiLE8n//65lAWqe/zyjAD31JfK3rozC7ioeoyQ7JmvYT0PyHfWxwKiacKe5PpJK8N+sP8++EFgsc5sEv7zinSiscAHS3Y6cKU+am3rjEZ1i2qOa9VFDh81wtVzQVoeySv4hQZ50yf3mwIZZmVHSxdFuIETK5v60FctoLTUIVctBCDPLNsfgwPwV0eKQlsPrvmw1G7G5OjHHpkb+e30xbBIgukVtu/lAz2oVzR0iGPMg0DrF3N0e/cU65V4s5xmdrn6bEW4kD8eJ67ZvA12Id2U33dBIBjQq87sLZJSPlXnS7dxKdXZeROrWW0eyGEcclBQpN7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNqfvGqtOEc1QvHvtVzENTjJklWdvd4mWzFz6XL09eI=;
 b=VGAA+bcb/zMmRcG8lMbG45vuovB1k1DfW2x0FJleH8UjW1bqsv7bFVZ+qzXUtpyLIKuvCpmAKVrIx1tls6nl38plwKLoRR0G5ZlLs7tr0c14as5f11az8mtyZVBOdFckuYyPxmW+ZwDhaOhcMX8PyMOUKrzIpesQ/Y4SF0rbDeiNXP56pBRjEMeGBolkTu8sieNoCEkzAPvZ9NY4m7ROfmdxOjDDDnnh34rQPnuWhn173uOMf5jvKt9xWFOfPReTG+wMzprILbxgEeZMXHg6VD1RdRzDS7ihWoREo3RIodCyBQjKeMEwT12fBcaNVDJW1lHQ91ZfKcEwdXIpVxwkSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fNqfvGqtOEc1QvHvtVzENTjJklWdvd4mWzFz6XL09eI=;
 b=X74D3Ft57AhbZVUMKVXNO++ldiUHDFJcNI4jagOFQFfiuqlgovTaFpgCI6O0Pb55GkUE9Tg198oUeuyCqNBnEhWQhUb+zmZ4w4aWduIObs+NOP+zWcvf9jjw2344HQ9gyI5ZYpWeeSWYZzaQUkyuBFTz8JCQCEg8Sg7swP0Wl+o=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6899.namprd04.prod.outlook.com (2603:10b6:a03:221::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Thu, 2 Jul
 2020 04:34:59 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3131.027; Thu, 2 Jul 2020
 04:34:59 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Wei Yongjun <weiyongjun1@huawei.com>, Jens Axboe <axboe@kernel.dk>,
        Ming Lei <ming.lei@redhat.com>
CC:     Hulk Robot <hulkci@huawei.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH -next] block: remove unused but set variable 'hctx'
Thread-Topic: [PATCH -next] block: remove unused but set variable 'hctx'
Thread-Index: AQHWUCMhpt4dXdQlXEeGyjml+rLniA==
Date:   Thu, 2 Jul 2020 04:34:59 +0000
Message-ID: <BYAPR04MB49654DBF16059D009ADBDA4D866D0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200702035445.22780-1-weiyongjun1@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.44.174]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 00305c9c-1ebc-4cac-5246-08d81e414779
x-ms-traffictypediagnostic: BY5PR04MB6899:
x-microsoft-antispam-prvs: <BY5PR04MB68992AB02A03B2B6E961AB94866D0@BY5PR04MB6899.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:33;
x-forefront-prvs: 0452022BE1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mHJHsnv11jZwc5soch57WwMFQIw/fk4ji1vQ4z573eaonTAbGkqb3q3HHSc3mJ0Z4XLu6N+ydZmU/Ahlg+/E5AmmktbMyemtM7ofNJ+q6dLQGSxLVGbXewxufmwP4TEjZ0g3C0TUtC82GX1U2eUuEbXWjyxn6mBymG8pbI4B/GP1FYoHttu7a4ah8oOYUjujv5OWqAJSpRSTL5is8ZCA8XXuoXBviI+P7WOb+49ode9Plpv8BR0FAY4HEq2i15kSJ1F7gACLY9y3pqKk01PQWv6FNDpqn+WWM16aQQ3aimvJC4bNUmqst7jnJyp4XPat
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(346002)(39860400002)(376002)(136003)(396003)(53546011)(5660300002)(86362001)(33656002)(83380400001)(2906002)(71200400001)(186003)(4744005)(52536014)(8936002)(64756008)(66476007)(316002)(66556008)(26005)(4326008)(8676002)(55016002)(9686003)(54906003)(110136005)(6506007)(66446008)(66946007)(478600001)(7696005)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: jAoeHt63k/jdTV4j+HcLbwDSBLryWgShW10/ZFo3SYtpD7TQ1sca0jDAjRiI59OutjMUP8+5Qsd44xTgdXfTIKRuUCpyTeAP2bhGERwwxN2rpnNMCzqMczUySK77dEpOoU3uCOwW3LwtXJFPrQShfiy1FqX95PUVw7XTaRo1OYzsFt+rClRb76GyRS1jakVKDKLKOzEFGJfNvMMOvTB0nbVf8tmTvoFCW+fTXXWuYbg2iMJnXf2azMLxgFNk+UbhTMIHfmGsoebhg0BPpq7KbCiTxWisIs/H8r8qp1FCGOorHQj39bEmTlmGzPpCIbfg7L/jtTbMfdMDzQKYY0pmzdmXcQeD31O1YpyIGsDvnD5StVC50N03ZLs2LrzVU707xgQphIcg2bvOGgNGGrKWpiGNzeElyJi0wTtIo9lIlBJQgbUEkBpCmH7l2+2VtZRbZRmucpS2fWtS3rLz0O10i27gLYCIJsURfV4MWDRHwTAOcN/67W4VTIyC2JqiGts1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00305c9c-1ebc-4cac-5246-08d81e414779
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jul 2020 04:34:59.1996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OV/DSKYbvi7ds3hk0Mbnr6WwdVzN4Y13ly1n0PbPigo/sGQ3yGtUPlOInAfc2GE+SRmqWrRE0XhUve2f3YChmTZQ82t6up1QP8waxc2B+uM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6899
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/1/20 8:44 PM, Wei Yongjun wrote:=0A=
> From: Hulk Robot<hulkci@huawei.com>=0A=
> =0A=
> After commit 37f4a24c2469 ("blk-mq: centralise related handling=0A=
> into blk_mq_get_driver_tag"), 'hctx' is never be used. Gcc report=0A=
> build warning:=0A=
> =0A=
> block/blk-flush.c:222:24: warning:=0A=
>   variable hctx set but not used [-Wunused-but-set-variable]=0A=
>    222 |  struct blk_mq_hw_ctx *hctx;=0A=
>        |                        ^~~~=0A=
> =0A=
> Just removing it to avoid build warning.=0A=
Ha Ha was about to send this patch.=0A=
=0A=
Looks good. Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
