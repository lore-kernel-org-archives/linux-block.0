Return-Path: <SRS0=X1aF=7V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CFAC433DF
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 06:40:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D69C2076A
	for <linux-block@archiver.kernel.org>; Mon,  8 Jun 2020 06:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hHx8FkZV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="I4QY4roh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728773AbgFHGkn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jun 2020 02:40:43 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:39875 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbgFHGkm (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jun 2020 02:40:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1591598455; x=1623134455;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=fnLUIIa7jnsjIWaodVfXMMXoz+M+SFAOKSIFeQYYYAI=;
  b=hHx8FkZVPvObuccOiNezSH0TGliInt10q6AQTGs4MYbau+MXIN+RVnXe
   q5ImJWM9O3pPEGvjS6mdKEQbmRD16AZbneKI5r56YiJy55ZrCOl8T6/rZ
   iPOgLj/IJdaGSgtshRECbf8W2UsNQRfLB+c2LpLNqyKuBAqq74NRN61c8
   XVzq/U50TkSnqk2lUCLKw0ujqI4RdX9yPizeljJdR8Rnmt5a+f7MTQe2z
   x7aLHfR9la2nOvZozkYTDH5TkfD11D3DTiBxrSLG6y+/ExUhvsSY9BTPp
   7lo5scbl8OOwuynmkHhi99rzT9g3hMpNjvpZc6bAifzskLWv8CyNL5MxM
   w==;
IronPort-SDR: R+/gsrF7mv1z4i911+FRiPK9CLvUOTtU3sCokb/hmDIDzWd5qapKKr1uhHxpxIEr4bkZnByHxR
 HrHQLsXjBZcrge09rE6GUCsozCm7wjYSYoIzYrt3pebB8JpVpzmltiM9HLp/nZt28PcxRYK21e
 c6hW+3ZMA1EGRE9bKpbANJoFDXTtP4XhheqXGJPZ3Na/7l+WW7rodcoEzxYLuFFuaiK4iLMi6W
 v5IqkSdFvhPiheI/YdHmnpmjYVuiH9HNVqxBwB7Cu/I0FkTGBIJg2/REgaAXAKPwcHKrwGHpCV
 9DQ=
X-IronPort-AV: E=Sophos;i="5.73,487,1583164800"; 
   d="scan'208";a="242328770"
Received: from mail-bn7nam10lp2103.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.103])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2020 14:40:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gBVxzisOBJqK0UvP8iZ/S4kp4HpC27cPAwRWhed3Mg/rzYUdULzm1HKxqQDNigsqHR1aESa5GvzDwjxkM3jaHy3fu9zzvEyG0pjb02PnCScQcyDMjGQP6cyusy7xzlwkrYD8dZpRoASH+2YYFWSy6Y3KBfLUSH/TF+9jePMX6ocsGxj9skhIZP9seJyi8J7KE2B4KFKozK/Bny3aGG6MJiZ9ZbqylsDXRGQYMMLeMOsqJ1vvYkRovyTZhZTaIQwYiQ0c/R+RA+KjGw0vdJPihErxf5YEsGWx5nV7MIdsfv7sHCUx1MuGdEqEnlwUTu9MeCM+trh1qvP0/8x+eOGNKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnLUIIa7jnsjIWaodVfXMMXoz+M+SFAOKSIFeQYYYAI=;
 b=R2/Ae+3aiKnNz87oMwM//b9XxPP21D+tOmlNvWSwCPhr/5LNJP7ORIrzIeMna6KhwbZj4pX4RqZgnuIE0+yuEQQ9YXd60z9zey9VxxqGg+pqkqnb0spZBTBr9DinMVwkRwlUhubOKAvKdT5hn0M93uwv9NbqUYSm+ccj7Wa2D9iQ9/blo84H7yC7g8t8bKW8L+UCbM11F++FpVNucuvPtma0gSnwZU4qiT7+y4dvxyJBaMuuoVeAFMToCCaSQvCqP2gqge6jXPztZPfR6cp4TAie+DIRBdDQVkEQ1cOw41C30Uq4+ROcs8JQuIKASFP3+T2bPcaNPrdVv1X8CgnusQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fnLUIIa7jnsjIWaodVfXMMXoz+M+SFAOKSIFeQYYYAI=;
 b=I4QY4rohkaQ5DTTnMR3tV+dPmfiZMR2tb/tW2irt6xraTREOigN1SsPVtyVhyKmDxkwkiWBDjr+TpJfnvIukhJ67tUs3p9hj4MGpZtdiJg1/9fxlfY2lUiuyxoYQvEv+aFDq0V1AVdiSdseRgCcPA1DotZw+N6Tr77V1ow6BgrQ=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6104.namprd04.prod.outlook.com (2603:10b6:a03:eb::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.20; Mon, 8 Jun
 2020 06:40:40 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::4d72:27c:c075:c5e6%7]) with mapi id 15.20.3066.023; Mon, 8 Jun 2020
 06:40:40 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     harshad shirwadkar <harshadshirwadkar@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] blktrace: put bounds on BLKTRACESETUP buf_size and buf_nr
Thread-Topic: [PATCH] blktrace: put bounds on BLKTRACESETUP buf_size and
 buf_nr
Thread-Index: AQHWOjNJLSEx3mlm6Eunc+X8pDtzsQ==
Date:   Mon, 8 Jun 2020 06:40:39 +0000
Message-ID: <BYAPR04MB496523AEF4C84B7BA2D2680486850@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200604054434.216698-1-harshadshirwadkar@gmail.com>
 <49a4c410-6d42-46b3-adde-1d0a8fc6b594@acm.org>
 <CAD+ocbzdh0eq+wBQ-DqUUw_Gvwc0xv-FbBUNS0aZfpn+eToUEg@mail.gmail.com>
 <8787ab94-4573-56d4-2e59-0adbaa979c4f@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: acm.org; dkim=none (message not signed)
 header.d=none;acm.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 28de9f1b-5ba8-404f-626d-08d80b76dc2c
x-ms-traffictypediagnostic: BYAPR04MB6104:
x-microsoft-antispam-prvs: <BYAPR04MB6104426969C4123F7D851C6686850@BYAPR04MB6104.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 042857DBB5
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BeWsTCW8y9I4fYe6vtX7IxvcE/CeaqPOjNClo4AZU+PRq3pUw+Zihq53T9yT08uwjv46APSg9iSm6L6ttRbt0LJQRqutkUENfCqKj4mEAJRntXzgWsOH0bB2Ry1Rpnr4NBzLIbQq5zg+4yoR2qjapgvlQXAhfNzZLPnUB2I3ezrm0ljQ4Lvb+EASfdR80hHyvHPvziN35gUP4KQL8I+iZTNoMgciWlsZiv3eF2O3yRbstU1KTBZpXgb1d6RFrZ1UPCOP80DUdiryGbehQKSIDvGA78qJqd4zLicg1ufDrfeYWMJa9uE6vQG4SHpRsHsj9wrRYz3OPgloQeYW8J+IzLmMO4EOXmjgOB3MrX2575Jnip8aLB8wJ269YeQrJW8M6FGswNNtLijnNI9yotnLIQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(136003)(396003)(346002)(39860400002)(52536014)(26005)(8936002)(8676002)(4326008)(4744005)(478600001)(54906003)(5660300002)(966005)(66446008)(66946007)(64756008)(71200400001)(66556008)(186003)(7696005)(66476007)(86362001)(55016002)(76116006)(6916009)(33656002)(83380400001)(2906002)(9686003)(316002)(6506007)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 70pvhNoHjswT7Dvmh2ziYHdx6z14kUni0bAx7CVgqhnoqEI8Dmeose1ZbKlpPJbKP4qC1t3ZIUHE8Wfgq1pDx7eRVrjlIokQi3Vd0KQDCIHc09HZC1W5EzNQs7R0XE0mwXlSbgVyx+HXVpsWF3qI7gv7s8YP2dR//bfIUoPBl8sjCjKlSdbBscbH1azuSsrIhAWWCx1LgeeML9pvenLVe4RwtfsC7mrgZHyF+gdgdoUtqno+vEtTBwZ/sXakiP5FqShEroifgZDaMKXU45+WBcc+6zTMQbPjPDrF6F7Gxmh8AC/QY5RGSzyaneAnqFo06MdJ//uUtBK7DcyxGZXFKG7rhe6plDyhPZRk477oWoqhS5aLtvls4Z/drLDWUa9lg8fGZDst3+JIB/KShKDxn/PMZhS+OYeW3Oa/Ug63zBPdyNhtuaWX0Myt9k0Je7KXBduC0Nad7nxvmZHn3monDewakw4EK6wNSlrLpFCA5vs=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28de9f1b-5ba8-404f-626d-08d80b76dc2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2020 06:40:39.9928
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0GW65fHsBuMZclfHo5JH6w/TYLqhg6HqLaZKJ54y3Yt900xf83VMw0nhDPWM0U4kHpeR3VYdia1TNT2Q1rARWyn4RDTL06gGAc7lt+tpz7U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6104
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Bart,=0A=
On 6/5/20 6:43 AM, Bart Van Assche wrote:=0A=
> We typically do not implement arbitrary limits in the kernel. So I'd=0A=
> prefer not to introduce any artificial limits.=0A=
=0A=
That is what I mentioned in [1] that we can add a check suggested in =0A=
[1]. That way we will not enforce any limits in the kernel and keep=0A=
the backward compatibility.=0A=
=0A=
Do you see any problem with the approach suggested in [1].=0A=
=0A=
[1] https://www.spinics.net/lists/linux-block/msg54754.html=0A=
