Return-Path: <SRS0=8+4U=63=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDFDCA90AF
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 12:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB06E20740
	for <linux-block@archiver.kernel.org>; Wed, 13 May 2020 12:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="avJPgN1b";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="px3E8Nnl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbgEMMKX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 May 2020 08:10:23 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:58079 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728379AbgEMMKW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 May 2020 08:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589371821; x=1620907821;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=avJPgN1bVBLhBy9o0umr0FR5IhCc4JCExwicKOQUf0FA14i+blbJ0Acb
   hZrFJUOU1+qnCE5nS+SADR8/bxlPTCPe9apIuIA8Y2g7EJZtKwMvpIqAx
   X8PDY+j9FuBoip5MjQpo/FBoeHKiNDTzD6YAvO2a8hfDrJvmaJuKOvcfO
   /i7YqMMR+Br66asSXki+qEyKRVVj8Ly4ul0qVh7uMfxT3dmONGSY2EvXL
   EXetMqfskl39mb0uS68LXMKT+EYj3kQx78OpEWiPJiTWzvDLKoQMhNpnl
   v0n+LAe0gdVlh88DbrxxIgNcdkmr5x4YccE7YCYLrb/bK4qFchWqEZ6S1
   A==;
IronPort-SDR: ixtEXcuuoXMnlk0/KvhNZgQH+ZJMjw6K2aYyy1W2wQmpx7Ezd4smBqkqcAdHSTjSF9e/ZHLD9a
 mNlDrE5nkDfVeymsd+XVBV2U60QvqyDz5KcOqfUXiFixxYqJE700lpZrqZqyZb2S1GjMCm4hJu
 CBruHh19J5jyuhYf8+rf4RcPMijFEE2LHyHFUjNVWxLdSricS8UsrO7g4cPaAPb+SJjuVgluAJ
 eowhQSETHzMgCJXpiWgGmXJfbvaICdEac8zIwnioVOQSfvGuwAOkfGGRLdktRvh+r0264eSZXW
 VvM=
X-IronPort-AV: E=Sophos;i="5.73,387,1583164800"; 
   d="scan'208";a="246519819"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 13 May 2020 20:10:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LOPqR7ztRBqdbQp5fTABe0E9n3CAHqeIuBc8rzaGJ7UIXRIQJN6Zyi6CP/0NuaHY/ABMfJR+/lEGqy/pKvs42tf7LKOno+l7g9YR79Y4VhRqONsB6jiAaHv8MDFw2yhknbHGf4POL4ntAvCe2J3u6fi/9PVQJcLo3c8MwPHAj5jRJxk5VlngFsogjdAcIMamOAeTdq4eiKtI3fR6FAK+r/ex06vhlqEsctg89FNJgRskB9kNiNzuedLz/QJoA3q+rN4ybyfNQB991bWPUKHrvrTUF7+OPgIYmRfD3PPs52Yq9HoxJhVuOmg+AvYBCOVEPHWO4zFP57r8fEVpgMUpYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ftm4TfL4XlKb3lmZVCiY3AJOBu9Oey0nIma91UB8oc8w2UrjIU1JWtBQc07dRGwIzkBtBoihlxVBVQJ5aEG2iyVRLB8dLk7eiL57t8UKTDRtIrSZgOBMtQOwuACnWgyGTZ/6Z+0M6v5ai8tRF4WN1szjh7fwOZQCmauw9Z4SsUH9eEB8VnwvqPDXcrcuNQYQoIiko0uTgSJu+6shjjar9nNiKI0qI//yDE4azM/awYkJ0lyUDIK+sn3IWiqOOm0v66jmA7f5QWZ1So1RMO+2qarm5GyPUca3m4AwUt4zOLoZlr3iOILs3MTHmo7QMhjfyjNwT6rDaDlOBsRjQP04JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=px3E8NnlxklyzU5MUplQowRAViLS2vr8Os7pC9r4BHIw4jwWCMCm4YkeMQCid9lqLC2/rBx4Z49HFsUyUpEAkpSe6SL7i90QR+HNsWpLw/76lwFyEFyLPd/lWKVEIoNKlcNBhVDdwkJKxmpBPlhSybC32hpInT7tjNqZCnBOLec=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3661.namprd04.prod.outlook.com
 (2603:10b6:803:45::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.19; Wed, 13 May
 2020 12:10:19 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.3000.022; Wed, 13 May 2020
 12:10:19 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 3/4] block: don't call part_{inc,dec}_in_flight for blk-mq
 devices
Thread-Topic: [PATCH 3/4] block: don't call part_{inc,dec}_in_flight for
 blk-mq devices
Thread-Index: AQHWKRQ8tbdYNkK0NkWIseSoHFImRw==
Date:   Wed, 13 May 2020 12:10:18 +0000
Message-ID: <SN4PR0401MB359873B37AB025FE7F19887B9BBF0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200513104935.2338779-1-hch@lst.de>
 <20200513104935.2338779-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fdec8038-62f0-415a-2fd7-08d7f7369aa9
x-ms-traffictypediagnostic: SN4PR0401MB3661:
x-microsoft-antispam-prvs: <SN4PR0401MB3661A2E01DDA1A8341578E0D9BBF0@SN4PR0401MB3661.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0402872DA1
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QyYYSqHWCbT6AUqAGW1pZE4erL1h6aHIg7M1EKI8L5t8ywgsNOMPIaP43c638nO1Um6HNEVfUOxi8hrfrXS5mOA5Ft578gwS9NhpI4ewdOJguQKN8pSJ8QWEz6VlB0GxB/dmXjIOmrUJdW7X/FomW8PxiKb++q6cBRdkEd/2rhbCRlxSgVTaEENt+cR6mvSNSqcJXi2B8sw48a4PiRCA5xqFYw0usgvGqD4aYfzSx0ZTujBgnsbdyouMj0HS4WZBptvczUVZfgEBYGJ30kGZU7Ya+1K3dl+Ir3e8CJeFAjEGZ6mwEOb6tLq5gSI+tdZNk1xlRqsUUlQs0cDzQTKuolimrKI4gbojA3O0n+sDE3mg50MA31WGFIszqe8ekcawNtb52gv9AljyJDRRQZsjaRzLwrqTvDLnTMRcSpYe75xqEfDSHgqe+SJyP+WOARAup5xX6G/BzZ/NtOxN/gib3UBkN0fo10HdErt3RQ5/Uhz0pRyUdoj5FSS6/GhofrgVqcb8WEgVIf8Z9Vrk0rswnRZl4kpD0QatHU5gyA1HXgN/nOfMlglsDxmx8xJQQ49H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(366004)(33430700001)(9686003)(4270600006)(55016002)(6506007)(52536014)(76116006)(7696005)(66556008)(66946007)(64756008)(66446008)(66476007)(5660300002)(33440700001)(71200400001)(91956017)(186003)(316002)(4326008)(19618925003)(2906002)(26005)(558084003)(33656002)(8676002)(8936002)(86362001)(110136005)(478600001)(142933001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: tCNizVBQlFkwwM0TtvnDIZVZkjOK61c8qkuFRMBHZ2PqGmdTy+wYsgCscDFTwvI9Mtn4/Nmvhxmkv/KDLTQFkP3DP6GAoi7QfSVE67M4yVosG4LNMWaRig2jWKIh7RckPAi2Hd1ZUB9SzWrLKuo2JbZ3fE1SNfU/MPq1WAbFeHJQKuuy2KCHAI6Wda40UM+ikXU0VgbO3DSUL6XLeOzbllkqrvbM14vPg7BCSDPfT1Nfu88IftFTIrOD7cGhB8rvGIgIinVEkzHasy77+fysZZOsLYuTn8VVHm8eb8CUzzvbpPjCvrzjgSFN/zHWpc1IONOjFdOdAVrfI9lAryFBlgQa9aM1c2Z0DJazrwGjK5JDZqLXvnO4ll73OFWAJmSOmim+HjMvpAJjZIdAc/qnB4rsipeHjXz/Qdg/xdDP8dddUBE66VeiguIbETAzefhOYKO60Bafc7PpCJXqpUL0fhD+EsXL8+3SkZ5n29s3y6AEx/KADH8UHIKXgFVfBTqw
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdec8038-62f0-415a-2fd7-08d7f7369aa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2020 12:10:18.9909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wdSJz24/KyEC/ZPPtyvg4DJ9DcIlwhBjNIZt3L3otBgvEiYOKyOO5G2VP4Qr8BKcTKCNxDFanVzQVzaZMxv7U6SIRdSpSxLlWcEJ43ZCoN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3661
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
