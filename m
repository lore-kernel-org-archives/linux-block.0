Return-Path: <SRS0=73YH=66=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DA5C433E0
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 04:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49A4E207CB
	for <linux-block@archiver.kernel.org>; Sat, 16 May 2020 04:10:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bTWhPgRH";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ZxFclZgj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725807AbgEPEKi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 May 2020 00:10:38 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:45941 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgEPEKi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 May 2020 00:10:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589602238; x=1621138238;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=HU0Ntf9VTGUKQb5Tqc1VTzHBIQPGP+Dlg6ypgYnFQ5E=;
  b=bTWhPgRHo9laGYQ7JwEgwD6JZSIjMqnhCHo5g7nbzuKiQpJjYQrGqwKZ
   XlTQWVbY1v22nX2Kl/+QlmouYGkjxF4q2D29dsIhjnLPDWSawG4MgXbSW
   9enOJETnm58+vCawB2iFmtRaaDV6GycrVgU4uZJvyKYL0bb2V27BpjcN6
   j9KWnVda7PZLKqpw4qNsKIEZuxBTdw3lzkJ1Tv292Azd1t5pfHXwU4rRc
   GY3n/3N9lwo//0hN1Ceh52Co1WPlpUBe97RJBg/p9kxRO8FIZVGJ7SwUt
   ef7bYjNDqYLo0Vu+WqbQbWxOajj94ki6nNhHBnE3YVFypx9Jer86Pz2LM
   A==;
IronPort-SDR: aFC/MkhHz/Ae/IXe3kvEVfTrEoaP8PR/KMR4EHzuNxWwKwIA7bgS+raocwYVu6FnyeJSWlG1h5
 PE10JOjxZEe+h2Jy3bcG494cavlugSS9esdffoHRd//6yIwUTIKsswAIpyiwt3IXCZzjylKlpV
 H17rN/Nka3KsdYXWLHR2ejMS6wmGUahYobDx2Tfb00IDS4w03WJwRPExhZlw1dFn2PVmBXJBkH
 Nfg6P0CIaaJS38Ggj+pTt8wke2yUTcP1+3Yv2leZYxbmyym6hWwZOS2i7pO08GVgzLiejm10fp
 ASc=
X-IronPort-AV: E=Sophos;i="5.73,397,1583164800"; 
   d="scan'208";a="138168966"
Received: from mail-dm6nam11lp2173.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.173])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2020 12:10:37 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jfQc3IPeITOFhrxhjDbN5koTR4+QwWgMe1CMheNSnsG+e75rqxRQoGCAxztZmsabWSSipE/bgQ2GqcvFhJ+AW+iFCdbdRgZ4KUKkscMDujz9JeMf20IdhEJboelsEBPRK4vmEOD0OpyhzeBKSlQAKuAM+HrjPfVgXvAfHVm0XJcZ8lBMTgeCNuEvWNuVjJadbLs3VJ7BdbKeSI7KOm7svXQQ0wybG4UjOHEy6Hk4tPrQ+iGLHmr9aD7qJmMyK8j3TKHyq5TYRkN4+TLDG/h40i9XsdCO5Q/Gn0p+txf2WzzrbnAutE3QNuM5qmRNPLbGfq67ReKdMJo2TC7dfA2KCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HU0Ntf9VTGUKQb5Tqc1VTzHBIQPGP+Dlg6ypgYnFQ5E=;
 b=VYsyWbwAS1165TRMZOmBifjSvhFyDCnJVt1ZPGkfRjvd9Jp1ZZ3hfcvQF2Ip2Gabsb6T3mGQdeCxTj9roWRj/WNJ3M7MjuOzetQb9q+XBKGQCvSmtmi5mn7+QmIjXIW5HhVRgW58yxGafCPEWlPd5HEMDP26hBKl5wVKaLGHBBXny6uqy4vLTI8GEZYyEcqOJs+OsxWGyEJK3tI+sxj+c1aCuc4Ia+rTc2Fg82GSjOAOcFgd22KRCpLrXUtqH5mcChstQvOczpStXzhSSrZxNa7hHFVODq62zsAYz4utTwC6wi5TtBRQ32MEp9UQ/+oV+85+myDxAyZCh+e2yrENbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HU0Ntf9VTGUKQb5Tqc1VTzHBIQPGP+Dlg6ypgYnFQ5E=;
 b=ZxFclZgj4Buopw1SsPx4+qZfbgfuQXZ5vLuD9tFNkTGRH87/uKYIEt+dzsI80O4knzA7Vt5y37qxFsgr2/D3yDf5hJ0ZatQhIdNFEKsfDuY4rIZ5pVbLL5RI0qDh5CatNHMmCRb5ZmqxdScgUu5UszQ3hWtblspiLDZyXGIivEM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4711.namprd04.prod.outlook.com (2603:10b6:a03:14::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.26; Sat, 16 May
 2020 04:10:36 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3000.022; Sat, 16 May 2020
 04:10:35 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Paolo Valente <paolo.valente@linaro.org>
Subject: Re: [PATCH] blktrace: Report pid with note messages
Thread-Topic: [PATCH] blktrace: Report pid with note messages
Thread-Index: AQHWKT/1Ul/n0sqGAUa28s0H53v69Q==
Date:   Sat, 16 May 2020 04:10:35 +0000
Message-ID: <BYAPR04MB4965CB18C496B0410A927C6F86BA0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200513160223.7855-1-jack@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b3918a2a-9112-4a43-54f1-08d7f94f15c1
x-ms-traffictypediagnostic: BYAPR04MB4711:
x-microsoft-antispam-prvs: <BYAPR04MB4711C0456AC94D5978170D1E86BA0@BYAPR04MB4711.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:398;
x-forefront-prvs: 040513D301
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BoMc5ivyALIXHgTdJ4/vdlci4d3P3nA0QiHTX4PiZwdgdxBchO0FU07gztURTs4PZelDM7qm7yHA/UYeVMw3SBNvYAfe0U2anP2TvnVYF4A+rcvsallRDNXQbpmMJIzpKYOb04q1Vdq+W3zj1XjuLK7KOPnVe6Y/O3YNq+NQf4q/nRM8k5x8F8fvB8T2SFQ1mUfQ+8GU0dVhAI98gy4AHZFEaoU12ehrXbHUxW5xRM0z+iOtp8GYqDOxJgLqGbwADEaMK0fxCt6YOT7lv7wo5efa9sjUBZO1n4Td/24xBpbHDbcHyxCH6kZ1Q9ZXAXZByO+lKAsS7qQpdudIi/QFuf5vKlLv+gUKtTyR1I4NILjCwcwi+dFMeNNBn4AFRXB8+jhuMnB7df0VGMRSyRzqcsrft3AbtU8tB7Vmquw2Tubwz+/bJAN06KjdTjUyXf3l
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(8936002)(5660300002)(33656002)(478600001)(7696005)(71200400001)(186003)(86362001)(53546011)(6506007)(66946007)(76116006)(66556008)(66446008)(66476007)(52536014)(64756008)(26005)(8676002)(54906003)(9686003)(4326008)(4744005)(15650500001)(110136005)(2906002)(316002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: OsuBAJ+Fl0JacBKV3dV7WQY4WL+i2/ow84xs9fAx/NWZB+XyI0Lpi5xmSUF6wV4F0UaBylxeDNH60QnCwxB+nNkjHmJ5Hi/JbU4gJ9yyb7lmOG7OFvPvy85R0qfrMAqAHr0xdiShTbSWUQPhBS5c96xL74Ac2eovOrFYuhiNAdc7HguUcrWd4Wp5k2qk2mVZb5KP58Ve6Os0aYPQrqtmDNpAgeFSjDRCFNpcDL1T0e6JoMwsIVuAOFMk6oWzGBIegGEmyN1Gu2vSsMfVd0kPXqCmyjTsPJJANSvEms+CRjFmsTjuRgFfO6bNBGcFjo14rvSRDuSM5rZOnmv7oP0QPHZrbowlxk2HL4aCuAAhQ/oJvaEeBSztzb6J4uUHWYUgVOqD3IcIFRdwc+r0OG5s//C0Hqs878LDdDyxgx8ht9saVCh3clQa/2+owbqHo3iQ5aHbRtJTN99SnZZu8tYJq8Wj4VWvUCY3Imc9XmS5xw8=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3918a2a-9112-4a43-54f1-08d7f94f15c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2020 04:10:35.7199
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Abyg7lxW23c8Z9Iggjoh/JOWCGqLxJtl+i/RaXBslTHmsuE0VANeWRDCyLy/5i4HEuapOip9kJSgza1GoX9a7sNWEQ4TjiWdcm9WcbV/lfc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4711
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 05/13/2020 09:02 AM, Jan Kara wrote:=0A=
> Currently informational messages within block trace do not have PID=0A=
> information of the process reporting the message included. With BFQ it=0A=
> is sometimes useful to have the information and there's no good reason=0A=
> to omit the information from the trace. So just fill in pid information=
=0A=
> when generating note message.=0A=
>=0A=
> Signed-off-by: Jan Kara<jack@suse.cz>=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
