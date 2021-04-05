Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5911AC433B4
	for <linux-block@archiver.kernel.org>; Mon,  5 Apr 2021 17:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2469561396
	for <linux-block@archiver.kernel.org>; Mon,  5 Apr 2021 17:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238879AbhDERlG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 5 Apr 2021 13:41:06 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:56398 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbhDERlF (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Apr 2021 13:41:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1617644460; x=1649180460;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=lG4z5D6sQXIZPmRtiEsqI6nlAjR2pRRLW/GaLY+Z1GA=;
  b=ZGzMH/6xQaHjQb2FO9eIwY4Cqw9JglXqcitRlwUlyFAMjGUkj6Q4Dpmp
   DRqTF/A1PUnV9twRekcNK3K5yG6xSPVo9OMGZn2z3sgkroFK+qh1lzViE
   6ZBsGG0XF63X9nTi3SeWxj+kMufltS2aZM7CUrWE1y4i/Su4ott9z6YRb
   1fi919xRchWUGfEOP0+Cag1+UESip5iiU9zerNbtC1nEcX7DCOs2BP/qk
   Hf2KjGcAGmNweYwHlEBwDSXD3mxdAyMoiU/etHQebmyH7ydRFXcCwnvVj
   zsDe3AoGspKoLaYgTE6Ld3ivIKZHM+OapL2my0Ts+FRqAw7yDms1jKctC
   A==;
IronPort-SDR: B9upPskGgcDHxD0pnvauc27VOQCQSoiYJkLkasWRPesHCnsHAAbesUiuQdOrdI5VVGyqZHwoCo
 9ueK2knVRXdj5k4mu3qonLl8equyAW4v+9tzWVVOZqw4OGn65ipljVSgLXkYV4DpcG2xbvkyNr
 FN568oi4EO72APYsD3eVNHtC5eNt3s9PcM7bcUO12YwpRnNOKGBtkSA3Yd+gK0mZT68c4V6+CP
 O2MfjNKQketIq0rlIE+wa4eTCn7IcL1KPVUoVzSPzGeP/6HF+289WomnEDZmrI8iURSY2/sjU8
 Sjo=
X-IronPort-AV: E=Sophos;i="5.81,307,1610380800"; 
   d="scan'208";a="268240188"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 06 Apr 2021 01:40:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axd1ADyTChE1eu75FvhMer17CcweZMQ8vPH8hgNdOgX2s2XgX5I0CBL+0FGGU3ipHXKp2c27Lftz0i9G6Vi7UfFE1Ajfjtn24gcZG4rfwBS7uNUP+FDG1FvmTIp+HDxFsChrE2Uk1mQPrzlaP6cfF2df1AfIe1Xc1v3w+JW9/JVjwuJy9N0a30r8sQrFVr2HaGqdEHoRvNOPjzSjX/+YBUFTLN/01IChNZly+4qsB6PsWfA8rW3b/Gg5vLEFTtSM8LdBEwCpL/2N3htdW1GLR0SRXQ9qB4Zky8Pgsyyye69c7o9VBSMilnB0q1s84UoRq15EWKLawnvv4zKFKrqI7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrq60Uo+NgjvNwFk8/zghgkmF+3x80xsN7U5V9hn0HQ=;
 b=QpHWSb9yp4gnMjoaVjlkfNmuRIIgZUmIGBlgHTXx9H2cYmKn/OBVb1oUkP22dRzlm7QzxNZcvH0bie6OssuOZd22H+on8IB4tcBKRK4QgKPCZKfVr2BajrRlvMnRv0RONJiFIxRRlfEaWHETqeJ3xVs5+ysRHbKFgbcks3jqijbcat5HKuHngxcXDzV51N0HB9xBpDTRepnYcQ6kvYDwm+qgvTtyUjLviCsVV8F0eiJseDptR9O3ootMDCVUJXxMkOed8zMeJDQfvXaGkMmGiiY04kN8ztcp/+y4uWsX2Ov3/Yq4dZLHvHeF6jvxpjkrdcS70WRX0w2haPRc9Qvulg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zrq60Uo+NgjvNwFk8/zghgkmF+3x80xsN7U5V9hn0HQ=;
 b=YTn4DmgM25PcFmY1o6f1heVMwIwOMYhWSNf2PNPSYmjBOcp1Mwvei6jMgPWCVXkRSaLalhOilW13GBIEY1+8uVnr4Xr+U6l/zOGH+Ut75tM3Q8OIPQsEdCPk1cWi8uuQLClOWJrbaXoj5XNECdgAagLLq8lRnqEFDbn9GKswl5o=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB6101.namprd04.prod.outlook.com (2603:10b6:a03:f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Mon, 5 Apr
 2021 17:40:28 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.3999.032; Mon, 5 Apr 2021
 17:40:28 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [PATCH 1/1] block: add sysfs entry for virt boundary mask
Thread-Topic: [PATCH 1/1] block: add sysfs entry for virt boundary mask
Thread-Index: AQHXKh5w9wH9mlHQI0S4J6hC39P1ww==
Date:   Mon, 5 Apr 2021 17:40:28 +0000
Message-ID: <BYAPR04MB496587F8FD4C96FEE418E78286779@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210405132012.12504-1-mgurtovoy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e399846-d138-4d12-6425-08d8f859e6e0
x-ms-traffictypediagnostic: BYAPR04MB6101:
x-microsoft-antispam-prvs: <BYAPR04MB610166AD6ED212223001852686779@BYAPR04MB6101.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uC1H4OW7DeIUGCpw69Sak2NeJHhsG4K8FLRXGZdRb1bGXnrK4b5xnF/t2sfhj1wDqa1LSTXywm2kgfdUBdxI030zaCgpkOOsnLnAytcG31pR1U3d1GvXffAukyaCi7i+vkR63l5tQVmCq8hlhS7ZTg19qM8kbs686y9JNA/1Eo1/HoyIK4xEV3hhAgnK6gFoIdRTwjQGHWuR529etXusbsm14GRz6TCwoorJuxu1qcaYPEglkBJEXJVtJCjnzHKsxFx2bGCGDGEIaOYVbCnCXBOZgIYMQy9OCVpBBT/ahBt+ousKfXkw8SG2xi24XAWi+lq8baA0Mslyt6aBQgGALm1eO6VY4gL5ftWjoV+41Ko5oJou3SkAk0Vze6jIhfMQoWMbto8VGPE7namVCwjwZZdLQJG73c910rf+RK54xui7ocGRVXj68tgo2fIld0cH12vXyqFe7Ha6ZLACl/Q5cQ8OtJiZyJyUslX8fXqzPys0uDiJvQfjAcXO9dv1fnIw9dxlfuBeOu3vBPqyn/H9Dm2Nf6YSVOTZCQJxH3y1Cyca52P1PKEyrIHL+CFmqhaRAW38muH+J99pR0+c7tJweO5l5fa/TLJmMWFRHSlPGMYlaR1u6Ksp8k8U/rDBh7slH5wd+Yldz+DGayjvgO8NkpaGoPfiSx7qpx/lCSTbHqM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(376002)(366004)(396003)(26005)(316002)(478600001)(186003)(5660300002)(66946007)(2906002)(8936002)(6506007)(71200400001)(52536014)(83380400001)(64756008)(38100700001)(33656002)(66556008)(86362001)(66476007)(7696005)(54906003)(4326008)(55016002)(66446008)(53546011)(6916009)(76116006)(8676002)(558084003)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?Kp9KPu7oyvUJiNbGPMSvmtAGH2kRBPHWquQeaghpaZxsFdOmwB2C7Nqjz8U7?=
 =?us-ascii?Q?FciQIHCorxVAP5LF9HCKGLUpRyXymokb3Ex5hX0OneIMhUixTE7sVo0ztysA?=
 =?us-ascii?Q?WylqW12eaDghhsNNO8lJub3ortdmPedxz+hDaZxscHFSoau/jMU8g/KS661p?=
 =?us-ascii?Q?nhWFRwRCk6oOgvgmy4LAa9XfnWDII9eDf+WNEmEIbwl9G2Tlci8W115APMsr?=
 =?us-ascii?Q?j+qkvF69BoLl4gnCsAqC1i55SFSrR9xsm/sbUDHtzfAtrNSpGI4m3B/a5JG7?=
 =?us-ascii?Q?Oq928zHs/dfNS9Md1kufcNhFG4ZdAVRJsejAm4XRwSJFAEuZ7c40Kgx5/n9h?=
 =?us-ascii?Q?SF8Eun+X2GfDQgUodNhBnoYPGRwjZnCn/OqZRVlQgCWwkMCiKXKjnuIg5wES?=
 =?us-ascii?Q?tSEpogNPiBZzDfu/HiJ9zjL/l9hOSzxSdxilNmcjuv0e/qzls/XEYBad7yF2?=
 =?us-ascii?Q?dECHaviQhF6iS2U1Zi6NKedVUnVwBYAjJkXKdZrY2kcmBEsiT+SIrSPVo4Wc?=
 =?us-ascii?Q?kUpD8aj8PFK6oPcZ1uSAoE81lj6CJR3UT8so1mqZcL2BMTBZgUAQAlk+d9qo?=
 =?us-ascii?Q?0jrlyX2qB72TY4M0o12dNp8pmU5Pxg1FCB+MoNoM4XY4ohAoCOh8kXCjVehe?=
 =?us-ascii?Q?NDhjnqjYtuBCQllNK7LhXgD4gOZnUoXmhTk9lNHh3Rqh8ufevazOh69UmP7q?=
 =?us-ascii?Q?7qCYFgcSuAsuQdEqFNWDpADQYVZGhcsktKdz68JigiG7mZUnrebqWof3c2V3?=
 =?us-ascii?Q?ysn8mzIBW/OkcbP2uDFBOFK8cMLZfpAZ1iueCEgQKTL6Yn/eEnLcSanSzABt?=
 =?us-ascii?Q?2cmNvvH/VgNUtLKprZSd1cq/AzYS70rtjNfhG1F7MF9weANyyXC5Sqy8OEb0?=
 =?us-ascii?Q?Qb+phV+0pholV9X5VGPcXT0KoN/+iyVtF2AmUj9nrCSWNSl/KtQMeRrpoyIC?=
 =?us-ascii?Q?8vYr/qfS2Vw1Vzk6zQ8cMzlR14Kq7eIbnKpQHKYHE9xsci2VDaQ8mWY+S7bX?=
 =?us-ascii?Q?eImI8XJfAZqxSvHbA+hXmSsxwvgA9CaNXBAPtr4mZDQvikB/x4ZDOunCGhIt?=
 =?us-ascii?Q?jOl6q+ASmDn9/v/wmBTluZ1tuiRmTym5io0mw3E5V7ipHxpEHrGny0Z2scrA?=
 =?us-ascii?Q?l/D+sTkoA9B6F73TvilZUTcWNNhg7ZMg7Q8K7aewqk7zHV1nturHF7l8cdm+?=
 =?us-ascii?Q?NobMzO1MadUROFYhso2YbUeoZM8C0oz+VoBLZMMDL4Q3aDs7+BDehGwl18eb?=
 =?us-ascii?Q?sEkV35+W6IMuqM+g+ww58xtmprMSl0WpMWzTQyY+culxwgTFIqRMjvPX/jr0?=
 =?us-ascii?Q?3VGyd8FNlKDI2ggqX9In/TR0?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e399846-d138-4d12-6425-08d8f859e6e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2021 17:40:28.0819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kcsLRje6ev3abuoyDTZ2kAmOk076gsv2O6f2te3utXL6fEP6CeB1I6Ap4LC5LHuYQSjUx/T+sCqQGCvKCVUqVloaq3EE3neMtZ19y9y/NBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6101
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/5/21 06:20, Max Gurtovoy wrote:=0A=
> +	return queue_var_show(q->limits.virt_boundary_mask, (page));=0A=
=0A=
's/(page)/page/' ?=0A=
=0A=
=0A=
