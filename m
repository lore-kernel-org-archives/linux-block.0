Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008DAC433B4
	for <linux-block@archiver.kernel.org>; Sun, 11 Apr 2021 22:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C89F1610CB
	for <linux-block@archiver.kernel.org>; Sun, 11 Apr 2021 22:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbhDKWNb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 11 Apr 2021 18:13:31 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:35937 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235718AbhDKWNb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 11 Apr 2021 18:13:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618179194; x=1649715194;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=hgMMVTAXh/2u6pFhXTjn8tag6Nm2vAmvjr8uDyZ7bnU=;
  b=Iz7Zb1WBbGuHacF0ORjpCheMU54DQnJjWPSrina14x16IgwL5yLRLcc/
   jG6QBDx3YpofeWCvRHg1pD63Y86R6j/iNZLhCZ3OCn4O8IvbzOww04qc0
   e3WLmUOb/24TLt7fsccWyICFuOZvqAju+MDphp4b7LLqcgwOr+56mNTeK
   F/vUBBWgIqW2DVbPQy2IoE51FiBPssftpUsAzVzIA/aZSmHQblJydX7f+
   UsSnG7lEBA3c1GXC7k0tv09prPZpuBtx1ZwgJHc6Svsg5CRrwIpzEzm2U
   yZt4lDDKM8palwxKWdca6hiXqVD4w/33zJVk+D7smYlqJM4dLFgU3xi5L
   A==;
IronPort-SDR: IYuB9PNIx2OyI5D9bpJJsClhEP0sD1kZm3qJlsYYR9CjyFlwBhtjUzufuxbhZS6LYau7LWRP3T
 5fQs5smoOpcs8f30bhAC+beJ2vr2uZELH2mMw810Rgg8cUtUBWJbnVplFWTVGNvTJbLjV5azXG
 rQlFPmBnD/m29PddEPWzf+Fv12s+uzGgwpe+HND3OoIEDEGGRS8LwV6FCmXP9qvISqSlyD+utR
 +rwYSy37i9Ry5S2Elxt94UtlX9PS7qm6IoOL164FGXWbPnMdO/+ozS8LOkh7URcNWrhGVU6wBu
 Vko=
X-IronPort-AV: E=Sophos;i="5.82,214,1613404800"; 
   d="scan'208";a="275329337"
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hgst.iphmx.com with ESMTP; 12 Apr 2021 06:13:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAFcGclDcTyuG9IOaQU+yPE0j+Y+t+I+YvdI82Iz1ySmJWJLGkwlpuhPALZMHvqDnfSLieuYpmcqaABAeCiyok/eIBb0VVoYGQu+dlqMo4Jfm0LEFxZcyRTaPqjaTVmmMmRFd5tkB6Y76ihw63OytuOMIt/6xKKQnex2Ze1XCevFKgRSRNpaJMlxvy2FNPiwcl9fA14v4G8xvi8MrxvDWA7WBcud5hKfzUGghbyUGU3SGeMRidilIo4/zrgBMsY8fdw0i+UOMVoJxaPS/6MyN/znWF+Cq3dMJE0WdrqMZSoFy4wWbWOFvIFV/fhRSENWFyP2400DKF6PyQe11IvrDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1K903H7lmk4kh6jpRrkgBtmueh0OC4OuG1MWtXg4aQ=;
 b=NOGY0R1pUivxMQ/BGaQsnXPat8FJqvgoOI+8NA1ecJ/k+phr3V4JQdltzu6+tTwKpLnx+wyP3ujW6NbGURewk3NY4u91owaJ/L/NWj7/iJju3SXrz6MXgQftfI6pb6ilt4ku3ESQwyW9ACj0uFj8jRdvn9L2zO+wkEfKL+2OiRq0VijBDdLQG7tj417nhDfdUrcaIn0U2oFAsd6Z8+N366UXGEAtYT9g849Bp6mlIFh8uIGlvs+npoIosD57q7lyKq4cDrkU4oiFdJ4z1E34nTvVcrIsBJ04KhkKE5vbYfw4bPRQcX/khnR3nZlIJ1PKFFXxqd5SuNTJ7jbBjFU3ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1K903H7lmk4kh6jpRrkgBtmueh0OC4OuG1MWtXg4aQ=;
 b=eL6aUqgZSUU1bvM9NeMGtWZZa3PD4Y0rakpfrBe5bXglolwB1VloW7IwY16TgMektplfopddU2gwIo7g7dS8g1IOXPU1DLUlmaRnOgMDNC5r52uSNg6sn30lnaO4eZHD1pBHwagC1jcxp3zLm0NVxwd3JhQcWa4iEjlzZi4Wvww=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5333.namprd04.prod.outlook.com (2603:10b6:a03:c2::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17; Sun, 11 Apr
 2021 22:13:11 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4020.018; Sun, 11 Apr 2021
 22:13:11 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "oren@nvidia.com" <oren@nvidia.com>,
        "idanb@nvidia.com" <idanb@nvidia.com>,
        "yossike@nvidia.com" <yossike@nvidia.com>
Subject: Re: [PATCH 1/1] null_blk: add option for managing virtual boundary
Thread-Topic: [PATCH 1/1] null_blk: add option for managing virtual boundary
Thread-Index: AQHXLu/rAbrjsWm4B0Od2SoOOt1rEg==
Date:   Sun, 11 Apr 2021 22:13:11 +0000
Message-ID: <BYAPR04MB4965A0C75CD1F8AE3F73472F86719@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210411162658.251456-1-mgurtovoy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 05bf8a20-b351-45f3-bbb9-08d8fd36fea5
x-ms-traffictypediagnostic: BYAPR04MB5333:
x-microsoft-antispam-prvs: <BYAPR04MB53334A3BC0AE5BBA8C9E53D986719@BYAPR04MB5333.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: j7qROCFAP99w6p9s0/JCPgX9zbk9IuSlMedm8Zgf9r5Egk0CwBxHkeyID3kvIwk8L5PkiLpFstRe/o/sy2Qguod/u2dZL+mQUSrxhDNkiYfcpUIIajb77iqyjlsx1xAWrC/sLacuq9lGZ/bJv3+j/0NoDNls866e/cSf3itaLj+9VQeGzl4StkaxSPKGuRcsz6lv4O/DgkA3FlCYtc/EhgslEQ/jTsvXRsvnTnmf9Pct1U9/4TmGynmUvX7C8732hcMJ+G6CwX1THxhX2lH/nltZVh2hwmoMLKhmO2byvx9aTJMcepf3ccPsEuuYG/j7yHlooEpFBHIti5shTpaQGZPzVl4Fcw4JeaelWxWr9V5KQVKKUEU+35xoXkAp8imNlWf10pZic4fJvFDhMDflNUXsddX2WsOKJpjyMCJQBKDbYXL6Ipghsw59K6rCRyBJXY156KCx+2NMxc9J4bETNbv9oz9n6icuUVHG01f/eghMD4XFQBsOe6ZLCDdUvjXmhRnvMYy1rzVYpAnzArPsYq42WGX6zZZPdv+j4j15QagMICE7Bt/RGEXLFDK2hCVyH5OtSAJiuj89r+rKzHlhh57DmXEOquRdpx2xIMh3lfk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(366004)(38100700002)(7696005)(316002)(71200400001)(2906002)(26005)(52536014)(66946007)(66556008)(186003)(76116006)(110136005)(54906003)(8936002)(86362001)(83380400001)(4326008)(478600001)(33656002)(53546011)(5660300002)(6506007)(55016002)(4744005)(66446008)(64756008)(9686003)(8676002)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+F11pJ/ngqKTNVbhoesb75I1mTSMYjncHYVAAFVp2LGYrnOpozn1iH26kAIt?=
 =?us-ascii?Q?GHRs62gdGceyCDIH+7uGns/QGOh5Z8OPDgR14pGkjb/MAlJcsuJuVByoGdi4?=
 =?us-ascii?Q?IJpuLYP9yAjWN92upCRsouk0wb/Ze8oynnpJeOyUkgBEsp/wiYdie+sJsvJj?=
 =?us-ascii?Q?91jcmuJdzN7sEHbjebbv/djvpSSuWy7Fvutr8IGM27PcNMWfWknWUi+N7u8V?=
 =?us-ascii?Q?lxQodjOsCb6QWO58pQY7CxrS1dYRzt5QI9k+WM4lottMXQdwHE9qvL1GSpIx?=
 =?us-ascii?Q?oAgMhjASxk/EZOt3zuXLY5EffsytrE5IqAss5vETDBnO2SXcd9DlH0p8PwWK?=
 =?us-ascii?Q?f0XI+a/Vlqmq4liH/qbbPL3G0tnjOtTmgooDQb/OmolFegq+M2qEehTqM7ve?=
 =?us-ascii?Q?3tjhDqlsH3L/A1PBWNYooV6GO8XJ/J9MHYmLQS5OrwP7aLFxqfe5YV6+Lvyb?=
 =?us-ascii?Q?tT6wUrTW2MfehfaIubLfW49XtVNxJfa/ClitHzTvob9kAY6qEjTpWNDHuPif?=
 =?us-ascii?Q?J5+Qd8xSykgL5lU/vW+DhQh81wX1P4Wi9IJAFnzDMf6MWDt2dRz50giEyJzv?=
 =?us-ascii?Q?6eyJA2LNNR7+GceKfS7NpbgMLgf8jXvb5hOhj3IlaPBp6OfrmIEl7dyN87ID?=
 =?us-ascii?Q?0eVSkFNg1fsA1G2aGRCyAfIb1cXvvPszhvRVrjrIkPbVLaIXso1U/Himyppj?=
 =?us-ascii?Q?P/KxWxQf/2ZSoM2rgee6ZTAGJnHrqlcM/vf0UCQ4k47sSC/4H728PlK/m+8K?=
 =?us-ascii?Q?c5GkEaaNnn/Dm/EZWD12pXfrL4PMOReccjj/Nhmh4SVGDHeHTg+ziE4ym8SO?=
 =?us-ascii?Q?ck5NXhjB2SsZZWcL79GjP2WAHlQSDs7RuEQxhhmocaD+LSYg+Wrz6xpP19rb?=
 =?us-ascii?Q?EgorZgtnzbNz8dgyarZQ1CNqOsEG5MNo3bsIPNP7XeYhm04PgKXheuAwlZij?=
 =?us-ascii?Q?aPYU3FHSyqzELVIel0b2e8VionsW4Ogzc9rEesrbglS5aJICx6JULXHeut8h?=
 =?us-ascii?Q?Iqm6NYEylJYO58xQXRaLN3E4L+wZv3g3YF4mONkF3KZ3qqOk/5Q2EDOq4E58?=
 =?us-ascii?Q?P6qFf33KAh7KbG8IbFCn1Dxmk0d0rf8figGMa6FtfAJSZ61z+QMT/WZVtEXk?=
 =?us-ascii?Q?YKwiQ36Ohyv87x+M4jacIR076Ju6vYTQgKHd8lj1E9Qr1h/08oxPiD086/xH?=
 =?us-ascii?Q?4ReHn1AxKN8sg4Jnn7UDStic7PFBIY7ndPj/sC4NVnlYpIgrsdVozkjds544?=
 =?us-ascii?Q?6OHnC1CVZEAc5P+7Ks4trv+s9y3IiFKZaMXRVm/21fjeHhZK7rumE3/Tsv0J?=
 =?us-ascii?Q?tNqBXlJ2VEYB/xhOh1WGdHrP?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05bf8a20-b351-45f3-bbb9-08d8fd36fea5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2021 22:13:11.3341
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: imVRbm3EXItxPJj/l6QHzRVjnNdLKuBv8KwLTdM7ooA219f7KVCoTuHz2OKtPzJep/1xQ4WEPIWU5IrkyX0QTlrg6GU8zQrHZUSiB2gwy/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5333
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/11/21 09:30, Max Gurtovoy wrote:=0A=
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c=0A=
> index d6c821d48090..9ca80e38f7e5 100644=0A=
> --- a/drivers/block/null_blk/main.c=0A=
> +++ b/drivers/block/null_blk/main.c=0A=
> @@ -84,6 +84,10 @@ enum {=0A=
>  	NULL_Q_MQ		=3D 2,=0A=
>  };=0A=
>  =0A=
> +static bool g_virt_boundary =3D false;=0A=
> +module_param_named(virt_boundary, g_virt_boundary, bool, 0444);=0A=
> +MODULE_PARM_DESC(virt_boundary, "Require a virtual boundary for the devi=
ce. Default: False");=0A=
> +=0A=
=0A=
The patch looks useful to me. But this will unconditionally enable=0A=
the virt boundry for all the devices created from configfs based on=0A=
the module param. Such enforcing will create an inflexibility when=0A=
user wants to create different devices for testing with different=0A=
configuration (e.g. virt bouncry on/off) with single modprobe.=0A=
=0A=
=0A=
