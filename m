Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A50C433E0
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 04:18:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F26F23133
	for <linux-block@archiver.kernel.org>; Wed, 13 Jan 2021 04:18:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbhAMER6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jan 2021 23:17:58 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:65307 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725957AbhAMER6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jan 2021 23:17:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610511477; x=1642047477;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=+k09t0bD/PijyhvnYyDuMixGOBz6d3hs6k71sNw5NGE=;
  b=hcCRaI5bObQcPOQEyhtoIpBbTTEQBwANKHD+1dQvtFlbq4J9m8TTRA0D
   CjFjWrCythWPpWt0nie/QAmVrCB/2ikV2bmnfGsZiOVHLYDzB9Ped1+nN
   QbnKaIS4xESwql8nEg3lqeK3l5i6OPwt0pLnM8mOVodJD4D92bhqH4RWv
   yBjnVZJh/lbQDgfvsmFH/vugak7lw6Qwb+lme7v1xuKABYMxYAqBsuBXw
   PZ5hlL/Iz8WM5usT/f2dlcARVCUXk7IxE5b2a/bo7qdSRFpjuOlnxSUbq
   f9qXvqi0lb9O9r9juk/Sghh9uiC/bPklqg5inYMzG94GOPvOXZHKQayVy
   A==;
IronPort-SDR: iPNILWbO2NN5lgDE2DS+ZLSUiOVmJsRbI3YOwUOpCIoRLMPlLyTxHbPeE2/DYcqx6htJruCJcu
 Wn4vt1px5GsY4dnlF3xqbyVzSilePX26HtmZQOUAwI2RVY24K4uxCXIvnM++Z+IMFGDcg8FhGu
 BLqpDnSA/gsFxdfFN/0c1QrCSX7BN5fZnRm+bGDpfIzD0FfFdIMo+veXTC4CwNfvy8e6+V/s5M
 hNkDV1oja0wFQndieCO3825etnOJmR+AGgamWUVFpCyA4mqSGNzYEfHgzLGCPqRnYULbd6SVLL
 ME4=
X-IronPort-AV: E=Sophos;i="5.79,343,1602518400"; 
   d="scan'208";a="267606044"
Received: from mail-mw2nam10lp2102.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.102])
  by ob1.hgst.iphmx.com with ESMTP; 13 Jan 2021 12:16:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYyfbtD8u3QBp2OfnyQ8pdWres7GyMWEh/WeKWzE7CL3AeMbKWMfCEmYa+kMUlC9X5SSoC+m+7LbhyTAew0OR77lN5JAOgEFWyMKLHNcZs2g1YvSQtMj/ZGLEjLa0g34KyOfblxvwsWZPXzat8G+4v1m+5idEFhrSmO06O+rf+lL0RUoI8a28Lmx3fRLKYZ0Ks9f12DfIVDOSG2XSY9f1j1hxwvWy1hnUE2ZJMMR5EbR2SpBP8QAz/GnQsF7RJgecCqkrHw2clqmzPU/TPvndrdhx/1UwN+TRjlaiURX82v+06nWT74GVy269SgSkd+iK//kkmAt9Tl1n6WYDenfjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aav66NQi/DWK12whZJruaJv3xluGbxjHZREyRBlG4c=;
 b=J1wdXWeK16GtyhmB9qS2WXi9kk1s/rz7xjljfqJs6II65MCEZasiPD1HBcIHFKKs1K9bLQygDYArEIk3fkrkBLIQVxif0j5FNGiC1gDOGoqKrTHHDsvOpm5F1L5yArTSdhkB7+xhjM3hyNJ7wK2UY7QMtbYP4h7sgRFiMG0NzxSVS2mvZwPcSSdqjTKuLqLKUAnyQT3Q+L8GJkPVUWwajJMbyGKIVVZ/dCCSGyqqPng7dyQ9dr2oUPbvfuD+bLdjrXrXXOH0x4RJVgsWKHD9EKvbBjs122IIWrzBsIDu7/LHojI5x7EkiXMCpmMXL6u8lXj/JHJdd7iH9rq63/QDsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9aav66NQi/DWK12whZJruaJv3xluGbxjHZREyRBlG4c=;
 b=HbF6fxdpZczC9qfybSsKgrOlhol1O8U6TA8sXQSvAlqtuIni6+y073CPYgAgVkJ2GyrDfUBQu8sK3BEharEt5b89HYcekRCbFlCeLUKAH4SRollpkYJl53v+BbydkQY+gl1C1CX4h8k/ZobTWB5v6AS6ur7furO+ZvDsQzDkSMs=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BY5PR04MB6884.namprd04.prod.outlook.com (2603:10b6:a03:222::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.9; Wed, 13 Jan
 2021 04:16:51 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3742.012; Wed, 13 Jan 2021
 04:16:51 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V9 3/9] nvmet: add NVM command set identifier support
Thread-Topic: [PATCH V9 3/9] nvmet: add NVM command set identifier support
Thread-Index: AQHW6JssIxRWomQxKUmbANEjg1SeZw==
Date:   Wed, 13 Jan 2021 04:16:51 +0000
Message-ID: <BYAPR04MB4965017878A807316A0A1BBA86A90@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
 <20210112042623.6316-4-chaitanya.kulkarni@wdc.com>
 <20210112072715.GB24155@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1ee048f2-71af-4c5b-8ac7-08d8b77a0d91
x-ms-traffictypediagnostic: BY5PR04MB6884:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR04MB6884FB5033F4711C3FF6284D86A90@BY5PR04MB6884.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JygwEaPzFRsqfhpMqCo40i5MwYMOGOa1qFlHv0pwZ4q9zrFEg0CA79zS2lnmD4QGUur9PzVgcxtkhFFdOBs/dPeAsnn7q+fGfhrBRj8OlPiX4A9kBO6jiRCLxvpWaCFoUyGvNJeUno7/A7n9WyFEEWEvRs7kX9JdHqMgMTpMZvBH1GqZ1F9vNuoVPd7nAyid/p9ae4ryVl9Yj6nfScbbw452fEt+DRIDYKCSpXum9uViwdALfjGShRym/g/wqAeytEaqFBMkLwZhnuSuUkXXGhHWgTg6R3GsWvlKKMkejlrt/f8eRjwzIA/z+WT3H+aYX2HXLFek+bAj+gTcxJpwQN/jIfqf3CoRzAKvrmouwgEZk3QR+L067rRWCCW8x3D8ymA7r1OX0gOPueJWV2x8cA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39860400002)(136003)(366004)(396003)(346002)(5660300002)(66946007)(66556008)(33656002)(66446008)(186003)(76116006)(4326008)(6916009)(6506007)(53546011)(2906002)(64756008)(83380400001)(66476007)(9686003)(71200400001)(316002)(7696005)(478600001)(55016002)(54906003)(26005)(8936002)(8676002)(86362001)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?OXotQB/jqAyg6XSPUpmvHYXPxDl/dPS6WtGGmnhry/LD7xAiWDrRWMi+/1Aa?=
 =?us-ascii?Q?yOr/36hRslnAhDfY0LVhtCaGb+Gop9hvQY4xvCIusgtRn/fHd5CE/Lv24o3i?=
 =?us-ascii?Q?eqnBeUlMGr10e56GjwQRVVSsUslXoS4waAlXWmUh5PExJj7bqXiKUlV6Eot8?=
 =?us-ascii?Q?Cc0mI0bNIyQVvQUzgJywC/1dE83GydYENRHdPbGwZibZsfrqez8Uz91Fv5Hn?=
 =?us-ascii?Q?JOyX6ySOwG6UDZggubJ8fMH+zvCokUtITwf+rnhQSC6LQYbFMkavYVxIVqEp?=
 =?us-ascii?Q?pnPv9xQvqzjA0ilYIXze88JOd2YHCkVzE5xM8R7gLiP5Y9SQhoDzDqz4br0l?=
 =?us-ascii?Q?7V5FLPMwGhbFMsXEdRcRcrVuBqL/qiyYu3djjTXKLG+xW8jmXPDat7MZal0i?=
 =?us-ascii?Q?SceoMcDKPt3vzPaU9DVVdJ/N0s6MM8jXilj96yUmjWSx16Qr82YbcCy6JHD7?=
 =?us-ascii?Q?Niowg23NuPwh2IvdoIKl7G0P0gExJaaXmkdldgGLrAd3FwOC2Lo9rRtdznMa?=
 =?us-ascii?Q?MXYYazupKIzmyjoXswF2+MqjTuKuA2e9XNGIYZsyFQ6K35gYAECzHd8Ci761?=
 =?us-ascii?Q?QuOnF2/EjkzBe/o9EmL5nHJB/f/85cYE+UmggvWfBO9e9O2ItGHhZxFXO8yU?=
 =?us-ascii?Q?nfHVfHfMfW3q3GL/kJkXsXi0K8r8DZaHVgg99lHOuqzWOaD1/f/adFJOozC0?=
 =?us-ascii?Q?QzOzulLigFu4wcMrAEvPODQ6P2UKD0eoo4tGQNiZO4UMhPtBShPxjMpoA9W3?=
 =?us-ascii?Q?hXJnPyRJHp1GQRZ+WywoqXphDNwnGof9J/ypJtIQ56FhlYpWlp8DTtD8JnLA?=
 =?us-ascii?Q?frAiglVQTr8WfSEhHiGOZdOoLuOUvsmxwR3eHsDEq7ZFtEBg0WlBIfCg7cK1?=
 =?us-ascii?Q?GY4mdThkvr0w7KbC9bQkfB8Lz2c/f1bYgyccfkoO8hokw2hiqNBvXr5Q7YUs?=
 =?us-ascii?Q?Mdid+7uUWfXUV4FFT7vafTa9aCz6RCbjIgL+lvMGYi71iIk075nHPodw0g4q?=
 =?us-ascii?Q?DKY5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ee048f2-71af-4c5b-8ac7-08d8b77a0d91
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2021 04:16:51.3287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 07gPyh3WWI2GlNisDwdc8gL/4xI012/p0y1QJUNQNjq3EHLVX9SiJaGua3isF0v8bUjPOTQx0IJaYtbknTRa5VSs8MZnNU9O9N9aI4ENoVs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6884
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/11/21 23:27, Christoph Hellwig wrote:=0A=
> The Command Set Identifier has no "NVM" in its name.=0A=
>=0A=
>=0A=
>> +static inline bool nvmet_cc_css_check(u8 cc_css)=0A=
>> +{=0A=
>> +	switch (cc_css <<=3D NVME_CC_CSS_SHIFT) {=0A=
>> +	case NVME_CC_CSS_NVM:=0A=
>> +		return true;=0A=
>> +	default:=0A=
>> +		return false;=0A=
>> +	}=0A=
>> +}=0A=
> This hunk looks misplaced, it isn't very useful on its own, but=0A=
> should go together with the multiple command set support.=0A=
>=0A=
We advertise the support for command sets supported in=0A=
nvmet_init_cap() -> ctrl->cap =3D (1ULL << 37). This results in=0A=
nvme_enable_ctrl() setting the ctrl->ctrl_config -> NVME_CC_CSS_NVM.=0A=
In current code in nvmet_start_ctrl() ->  nvmet_cc_css(ctrl->cc) !=3D 0=0A=
checks if value is not =3D 0 but doesn't use the macro used by the host.=0A=
Above function does that also makes it helper that we use in the next=0A=
patch where cc_css value is !=3D 0 but NVME_CC_CSS_CSI with=0A=
ctrl->cap set to 1ULL << 43.=0A=
=0A=
With code flow in [1] above function is needed to make sure css value=0A=
matches the value set by the host using the same macro in=0A=
nvme_enable_ctrl() NVME_CC_CSS_NVM. Otherwise patch looks incomplete=0A=
and adding check for the CSS NVM with CSS_CSI looks mixing up things=0A=
to me.=0A=
=0A=
Are you okay with that ?=0A=
=0A=
[1]=0A=
nvme_enable_ctrl()=0A=
 ctrl->ops->reg_write32(ctrl, NVME_REG_CC, ctrl->ctrl_config)=0A=
  nvmf_reg_write32()=0A=
   nvmet_parse_fabrics_cmd()=0A=
    nvmet_execute_prop_set()=0A=
     nvmet_update_ctrl()=0A=
      new cc !=3D old cc =3D=3D true -> nvmet_start_ctrl()=0A=
       nvmet_cc_css_check(ctrl->css)=0A=
        Check if host has set the for controller config NVME_CC_CSS_NVM=0A=
        as we are supporting default CSS_NVM which ctrl needs to set=0A=
        irrespective of other CC_CSS values.=0A=
      =0A=
 =0A=
=0A=
=0A=
