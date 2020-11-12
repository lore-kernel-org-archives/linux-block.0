Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C58C56201
	for <linux-block@archiver.kernel.org>; Thu, 12 Nov 2020 05:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11B3B21534
	for <linux-block@archiver.kernel.org>; Thu, 12 Nov 2020 05:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="L3SQPpQd";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hQZ15t02"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgKLFj0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 Nov 2020 00:39:26 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:12269 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728643AbgKLELa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Nov 2020 23:11:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605154289; x=1636690289;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=cSdcgSm7o5jbXpnr7qq2MkQXOzlQK8lBg0QBCAA0oZg=;
  b=L3SQPpQdwDKxMxrWVMGlLl4wXJ5wACg2+BtiTyfpdkjlwkLfNsrfPsSa
   uEGrcJhO3/JmJ6JVzNcYvI5kKBiqv+NTzZtct+151b6j5Vg2VkepBrk/F
   ZP3ojsORnh+wrBn/qkBlJ2iwlqHhy0WXUdUujAt4iynZ/JabvR82cTW52
   Wfxi7kc+cXF9Q/81P1qQP86hq/7uw3LNRYMrSqB55UFgmmb5E50KmXyyb
   1wMxNGmrr7WN9bGjjfMefu7I84hEhH9jgkFrJ/dDA/AKcwqGblqGdxwnd
   xTj8p+ysYG94KgMsk1zoNH6Lr7gj9XS2KkqoCmtDrnEMjiiZ5VpqviwMB
   A==;
IronPort-SDR: lXKVATJJ9fVy1AkJlwkvMjXES9z2iPxbz7PlbBAu7ZZW70F3Pm98QjS8JNkrvSlloMQc9ZTLxW
 XiDHJm5JPAvzomrO5tsOWR8/V0wVCOXJdtbjktUm0ICycBHv3yDnlIU9t8GcWhDYsSfJ8SAMa5
 KKulRYPznkV2a9zDnztuS7yqpZzw8kpEbQ3Yeot15xb4FR8vK9Sj8xlDcJtlASv05506LEzDoU
 WbJc4IVj5oe5CR388sl//XZzg0nl86m+fEuxSY0DZc6mut7mkTmeC2n9MbHoLCdd/Nluq9KQM1
 2Os=
X-IronPort-AV: E=Sophos;i="5.77,471,1596470400"; 
   d="scan'208";a="152545168"
Received: from mail-dm6nam12lp2168.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.168])
  by ob1.hgst.iphmx.com with ESMTP; 12 Nov 2020 12:11:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zx7OzgnAMvbq6cQ9y2Gxnl4z1SnPaSNxGV9npdAKm1okCy7WogT4rB5E6AtRsMhLVg4o9FxF8CV/Pd0ZCf/th3ELui8Km7tw9n5dhPeuni4e6FVvoyfvoia8LpVfKHkiQMIJ+5bSANsE5BVsmoz0atI0BS2dN9WMchUDZnDJbizEnIQvnkdmImVMcLpjc0viqPAkLAuyGW54I9xyOY+UFsv6vYv1fDs8DjCJ50qMkd+z/uenlViTOwIUj+zb25PzrBSYb/8fzBbGxAz2VlK0tgO2MrNsw5S+XrlFhVVXPWF2LxKZ6Y3OSLqGVO/rTVJ5Kv+8yP/kopsOfyTY30pong==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSdcgSm7o5jbXpnr7qq2MkQXOzlQK8lBg0QBCAA0oZg=;
 b=XCX4R1RmfSxyMv6jlDEjfVsimd4r8ekI3Ctnni/s5opcbyGld7vAqUa/WEe36g3jp5MakhzOuu0Am1cwNogBKtRv4yrNLQ9pmC1vPCincshj9lA0trTfOla2nVQ9Wpqe6OehNEPnFakqKm5uiAzTCr6RtkUhiFAkTHd0x2mlri0NpoRaGC6X3i54/FTe0XFYV3cxBJA0mZDENS5NVVk/8ElOXFoSJ2JsfAX9N4Aify0VzJ8LHh0PpYD44eDgR4DLSKm4tWayyKekcVwxcDFUGxihIXluCcEOm07L+3B8Cc2CBI6MIyxCX9d2VQL63ZdC+Tr8ei+FjBUo/7/yCSZwzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSdcgSm7o5jbXpnr7qq2MkQXOzlQK8lBg0QBCAA0oZg=;
 b=hQZ15t024EYYMKHS+yTD+DdIMydYO1oqYyE8TXxcrDmhX2AN7kbcE4Pz7cVTnSA/LHZ5s+x3uSIJVX0mcvUziUTh5ibJJL1TZ/4VWfqckE0gotfy0zNkoZeFOY1RxgKn+ShTldKyaH+YeNjcusWePkogeIbwEMlYXnQYz+QfvJo=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7198.namprd04.prod.outlook.com (2603:10b6:a03:297::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.22; Thu, 12 Nov
 2020 04:11:27 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::99ae:ab95:7c27:99e4%7]) with mapi id 15.20.3541.025; Thu, 12 Nov 2020
 04:11:26 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "javier@javigon.com" <javier@javigon.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>
Subject: Re: [PATCH] nvme: remove unnecessary return values
Thread-Topic: [PATCH] nvme: remove unnecessary return values
Thread-Index: AQHWuGa34tNj7I/TwE28HuX4CkJZNQ==
Date:   Thu, 12 Nov 2020 04:11:26 +0000
Message-ID: <BYAPR04MB4965213DB3D1F07B7B75B92586E70@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20201111201018.30764-1-javier@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: javigon.com; dkim=none (message not signed)
 header.d=none;javigon.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f0525d8a-a4e7-4473-570b-08d886c1068e
x-ms-traffictypediagnostic: SJ0PR04MB7198:
x-microsoft-antispam-prvs: <SJ0PR04MB7198587424C1BC5C29152C1E86E70@SJ0PR04MB7198.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: P5+tBuyh9koAZ2NjesjHB7c0qSuZ1yf7G6VewoHChvfFRbfuNb+SbXtH+ubAoRQnJnWdg+zRuZafHA0mR1PT0hMejJZQS66MkVgMzzO3vrPPLqwrgi13lSmhFY7M29VrP3+qTop9bR11dqEhkf05FN/5+W7GFfQNpRoywuM6yQh3ovPD5SGnFExLw/Jg2XDuDWlw9JS5wYV6dFCxXvEc/26ozdx+lyi02Gfh62KeQmNPUrVUL1rUQD4/q51T5D8Bo8Ya8m62TMe6Db5ZcBDizhR4+jRE5o4nVgF1eERKl6qIIdt0r5fgFiJYkMTcSnx9FrLlQBPEpBKjN1Jj3U8pFQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(4326008)(66556008)(64756008)(66946007)(8936002)(8676002)(71200400001)(52536014)(316002)(76116006)(66476007)(5660300002)(33656002)(2906002)(86362001)(110136005)(4744005)(54906003)(55016002)(478600001)(6506007)(9686003)(53546011)(186003)(26005)(7696005)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: wQorYy1eE77ChCt891otJX15dTrXOEX//+ZkHirFSbG0q9WgF87GiEHFF6/X4hSTNAAKXv3zpm/XAZSL+O+wv/+egs7OYJthk1IFKCDL1fi7G2kLpzyRMcMHRhLtcGXfaKgSCHspBLDxGNm8W6t1Rs9zwRRHjDMxAjJQtB6HEHqOAXA96X+td4Zfci8YsZHXJNZvwc/H8T4ECCAHpPI77kJihjEjIREMXBiI2p9D11YddZjMN4V7cinDLG05Lts/tSX13fsK0AWJ/QD8+tfampx14WdulKNywR6RrKcKrNfF4xUgzZklRqRcHpGJK2N/fvENHHoFaH+jDEsWddBYwnvvpNzLwIMsaZK9oj74VBE68Jg+LT7cKqxcWW72BVuGPGVYYQt3JsUn511MU1fm2v+AiRsExRlxfliZVOEeOM14FlVIO0eTEDIQBkJmIadw1HQ1RB38k/OyXkiDJ8NmLPREmGLckKJjr8aelzME9Beog8M9jzy7tQgV3zJkv8bFyH6A4fi3SbIJM9UVTxic4QhX2R0Xjb7/m2e8jydfzdZ4UyM/YO5lZp/Il3G8AHxJNhi1TeqPNv+QBB8s4XuRNB8LTBhZ9cmWSYJkyLWjvYBxWYWJ6Umom9RpKGgC0DLe00XaMcPC1JWCIfz71NLOEQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0525d8a-a4e7-4473-570b-08d886c1068e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2020 04:11:26.8227
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jekClhUVKTBKOaJrmtyQKVq/WogXUu7Ivh61g6XnPi2tzx8nUHBfmuLY9ZgLRqI1jDpR+Mo+87WFlv2D2jeenKp0NqvJNxpAQ6M8mcx57WY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7198
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/11/20 12:10, javier@javigon.com wrote:=0A=
> From: Javier Gonz=E1lez <javier.gonz@samsung.com>=0A=
>=0A=
> Cleanup unnecessary ret values that are not checked or used in=0A=
> nvme_alloc_ns()=0A=
>=0A=
> Signed-off-by: Javier Gonz=E1lez <javier=0A=
=0A=
The ret value pattern is used to avoid the calls in the if () which is=0A=
=0A=
not clean based on the comments I had in the past.=0A=
=0A=
