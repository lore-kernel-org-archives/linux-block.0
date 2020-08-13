Return-Path: <SRS0=n79e=BX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F24C433DF
	for <linux-block@archiver.kernel.org>; Thu, 13 Aug 2020 02:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC67B205CB
	for <linux-block@archiver.kernel.org>; Thu, 13 Aug 2020 02:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="rCktyjJp";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="e7LzsNjE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgHMCoG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Aug 2020 22:44:06 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:57793 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgHMCoF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Aug 2020 22:44:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1597286645; x=1628822645;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=7Saj3vK9GvYJ6JaaUfcijb97ZhO12VrO14UD4Bn5wCg=;
  b=rCktyjJpUREFahNyfeCoQIW/Gr+pGhU7QSBnZz1duDp0GtNJeAtseOr3
   +kh1UQum0pxPejlzD8UwZw0Y/fejiuaBDjQP6flAj4yNxnsNIr6HuGUvv
   3AIssZE/D/WsD+lHSK3R7wzGy3MSGuobOWuu6edVexXDDLNBLkDdaBKB0
   61FyIQ5d57YMCI1x/Y/kwgq8goYWpJvxceXqGuXDObxcVozzp4yt4SqJR
   JTI2EZcOKAfdhkzdbGrBqa0M3HDnoGKqnTGQ5AE9/C+ZuUHoXjniwB7RI
   t5mtEaXES01Yy2zkC2DbCm2bNo461JOS32h9AQJnFw1asCcVQyd79w6NC
   Q==;
IronPort-SDR: XRmiyo9hMnhuOXtfjxfoTV32MEL2TN1OS20JrxgctMMkvn9QNukwAeBjE+xRf6b9h6ZICQnZ0b
 30/xNLFpdwhQH5xt4/ghiIZ+Jz8dqRGKzEyyyKn79G1eY5gwhUaX4/nlvW3gXNajSC3WezfQ3Y
 U24H8A/c0d4iEyya2SIgMre2Sr8qTLSBDNARk4VAeI2Tjv8t+AOSgNaH+CQhs1q315x4kVjMCW
 Rv6mmbQgL3bUezchoqgUYZbyhU5TVPizt0UX/VQVMf4rmcIKvkNjIYay+rbEVRDcP8gso0gOiy
 MIM=
X-IronPort-AV: E=Sophos;i="5.76,306,1592841600"; 
   d="scan'208";a="144812413"
Received: from mail-bn8nam11lp2176.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.176])
  by ob1.hgst.iphmx.com with ESMTP; 13 Aug 2020 10:44:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/GNEWDJCxqfv17lp8sQjV0pduCe400wJw2hejw+nQjRUsvbjuKU+90Pxxyv3hZN7dPuOH/Q+b6DL/BHgg9LwIxJDossBHY7W8RNVmlde80WtA0z6JGDVeOShfgAq7dYBcGA2yoAK0FqOlbpIkeRqOqaJVrzhdeqLp2xn34+G7uK55VQoa5Pfx2Jhs9xATxusYBAvgRsNGAxcXAa14uz9kkHJqqewZCNgtiQkp91MdrgnBwLFergHEeuDJv9DniP3fKZjWbYwM8zx4NRDnlPgq5vkvBBsCL14DhUDShZzXt+1ZU8K/pXrVvGMpejjkEftkhKmyfsjG577Lpfhcow0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Saj3vK9GvYJ6JaaUfcijb97ZhO12VrO14UD4Bn5wCg=;
 b=TWQxsaX00161K7VIEdHpenPVkAT1FD9atYFqJezdSRnW8YLWqiZupWiDjVfwNJjnlrfSllJUAulFNYFIsJh/oeu554QJikY3w7IIjSpwnHfPqfQq1vZoHH0LZiD6XvLMJvR7bilp6GhiXc2H/evAiYxl7eEOlWRgiPS2uD58cSdqBV7BhqZ4N9MMrOailHHHg/yvX9cSV0VoRWXSquqCjRYXrf2IYnKSkYqQ6cP0WRNvl3OCBCqxCbVlWBYM0pfPhtB/JDkvvSlhMmmCoX/uHpn4MbPXdp82O38mH91MAQD5xfbIXHVgr9gv4NSrdCsjfZ+TqgQ2GNJU/8tg6p4LVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Saj3vK9GvYJ6JaaUfcijb97ZhO12VrO14UD4Bn5wCg=;
 b=e7LzsNjEosXA+5XifnVsRwfpbHzHwONLzbX1xXqrX6d7QvKDAHqrM41HewNc/yyHrCJJaojpvuCG8owMSeZkrngeW38lEo30queWwMqWGuSzM/W66cXz1+rLBxwSSJlm8BJQPAON8MzrwRDkVVtuOHzEDCnGu68z27HFOk8tuUA=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6899.namprd04.prod.outlook.com (2603:10b6:a03:221::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Thu, 13 Aug
 2020 02:44:01 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::98a4:d2c9:58c5:dee4%5]) with mapi id 15.20.3261.025; Thu, 13 Aug 2020
 02:44:01 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>
CC:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v3 1/7] nvme: consolidate nvme requirements based on
 transport type
Thread-Topic: [PATCH v3 1/7] nvme: consolidate nvme requirements based on
 transport type
Thread-Index: AQHWcCKL/VmK45q8o0W2fAix64guxg==
Date:   Thu, 13 Aug 2020 02:44:01 +0000
Message-ID: <BYAPR04MB4965FEA3D90723128ABCA41C86430@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20200811210102.194287-1-sagi@grimberg.me>
 <20200811210102.194287-2-sagi@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: grimberg.me; dkim=none (message not signed)
 header.d=none;grimberg.me; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e45a6348-6813-44b7-e08c-08d83f32bc65
x-ms-traffictypediagnostic: BY5PR04MB6899:
x-microsoft-antispam-prvs: <BY5PR04MB689919B039E96BEACD14F21386430@BY5PR04MB6899.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4502;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B0PmQAzc2rSxz1cjN41/4N9mtv/GVYBBywp1lZ/IL5Pl6b4biabG2pXKoP8W30e/3koWyfs6zUfovIRMxySvJfPVzcd8JjbWuTrHt6GosxikisVup6xb2ziPRg/8DKS7J+E8bt42GHXa45x0AFLrcb/FxsamEFEaEia6zXs7r3OVEZHq2qdKiL7yeFSch2mlIBstGwtz4ZWv5r+3J3pcUQMkH8Sr/dUoQ/z26aXZOvipOfi/8IAjIBr4HxYOLxxGCwHZxSz14OU0GCKSLM5l0TUZWH9DBdlm4n36flbsVuA8hok8XRBaSC+GR9EW+bOzk68TH0gl7Ui5Y1spaFujxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(76116006)(66946007)(26005)(316002)(86362001)(8936002)(110136005)(2906002)(71200400001)(5660300002)(54906003)(186003)(9686003)(8676002)(55016002)(4744005)(6506007)(4326008)(33656002)(7696005)(66556008)(66446008)(64756008)(66476007)(478600001)(53546011)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: q4A0cEArJMbrwFdLo7+prrKPkukZcIOOPL9Zn09fsWAfQdBRULynzQ/IvRztno1ZvV+kmOP4Cuo6lDhOl52+S/TruOQ5oK5+sZCk9cBY2S817xjDpI//8emptlciSXt9Np1+XafZQ6uZgmD+SDh+kzNbjGqmSkK1s9KnfZJSyzuPUwr6mX9u3XvHgcuzYZv9lyi7oRXDrSsbq/2qw+beIGqRjS4xRAoYf9NTbbzcc8WlCbbJYV97bW4qCmHTZy+bu9qondoA5o7KhnA+cHlXpVC9pRvn2fa6HrhsD8McflZTjJ5C3bexaxhtT+yjwXSHkVIfcOuNZcAabW5Hn+aEm3om3TN1JGGNw3NJoH5obg/wbNRoK9ryb0XKSGRybbenGKMEHfXijHKpI3Jd3u8uBYtPTqItbg0jlfvFW65Lp2/+dLsrqRFzb2kKjF3L6EOxqqgslh5GHHJsG18ljoVP43KT0lySPgLXQnHkwsUMeau4CJ8iOgXWYFnOvDRS/pQnB47wXvPYehd5jNz+bi153nyBMeJVGqHxGZeQ7j5RBAYW1r9f31wYeTWOB1T4IY7aVRmMzrybLuANhmP+kFHBuguU7/PbsX5AVp0I3S7ehr/POeocfiAPC3RqLA2dc/xPcuhH4kVam+0rSIsdgEr1qw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e45a6348-6813-44b7-e08c-08d83f32bc65
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2020 02:44:01.0825
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 36rxFm5r3T38Zc8TZorRZEdmGEuPQmpUikxVlSkU8Fy/6Bydo3Rx86YFPS1w1DxX9e7/I+NnVFuO95+ZMMPjC6sIB2607eyXJdNbxX5LgTI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6899
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/11/20 14:01, Sagi Grimberg wrote:=0A=
> Right now, only pci and loop have tests, hence these are=0A=
> the only ones that are allowed. The user can pass an env=0A=
> variable nvme_trtype and check for the necessary modules.=0A=
> =0A=
> This allows prepares us to support other transport types.=0A=
> =0A=
> Note that test 031 is designed to run only with nvme, hence=0A=
> it overrides the environment variable to nvme_trtype=3Dpci.=0A=
> =0A=
> Signed-off-by: Sagi Grimberg<sagi@grimberg.me>=0A=
=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
