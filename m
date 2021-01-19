Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B9EC433E9
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 05:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BDBE221EA
	for <linux-block@archiver.kernel.org>; Tue, 19 Jan 2021 05:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbhASFIc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Jan 2021 00:08:32 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:2152 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389511AbhASE6S (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jan 2021 23:58:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611032298; x=1642568298;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=C6Sum0tDWkK2t161g9op0Ii5SSQdIowhORsJrmLENns=;
  b=o9eslw8Uzu4p2M3evIPEBwJ4DhBAbxtIVTy7f4WrWZdIsumBu8ENNFcy
   JIph4+QPcAIHkbxO4LojMqyB47tsK5JiE87DCjjI3Euwu3bZW0mCYFH72
   NcSj2HYFZ1a9yD743wbHNzhF5DJPIW/ICj8gKd6aayqhuu/1P03ebOXXD
   GOrhQxP3r7G/qLcFS0DTIMCWvWZbTgUdWnRXS9mJwPT1HtkC1a2kSs3t3
   0iYGCb5c0/huGjhv9xiYuy5ASbaE12EP+Boz+NE0HCelAsaJiUBSrBvFa
   YSizzXj5rarFBosZgCcdgkc3vDModrOJoU0azIlwihxjXRoU4hodIu/BQ
   g==;
IronPort-SDR: H/JSZoZggzAoI2tYdsiuOi1f/5BoMwN9gEIEnlCrTnBwqhcKcDSKIOkzb22bcoR7zrjsbOoV2h
 kSV6paYPxneXrObAfi8P9jOyNDscNcoyW8ZtMqsSj6TGNX1+hLlab6bSdnTm13qcpF8+JHlPMG
 HtSPJd+1sBVGcMMLZTRy0DNcgedGhgG2EpR1ldOqaU3XHBWwVrTPxrfXcgUMn2OsXpOCDeUazu
 RYmRkzRwjs1KOTSy4LxHBTd1DKGRQD8PvG7rvh+oRjIqydt8BfbGhi3ljTOPQj5+9XZso1kFEx
 w0s=
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="157763137"
Received: from mail-dm6nam08lp2042.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.42])
  by ob1.hgst.iphmx.com with ESMTP; 19 Jan 2021 12:57:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JUvcDbZyJA4sK77yJlNGGAywCq0H54Bxol0dNMaMUfQkg2TbtuIXWPpvDF6bBKROSJCw06vRhhHJOFdpRisFWJj2Nx6E8KN2jL7sYwfRe60w6cQwwfu9ZMHcyJAQoVrACvUNbC/q+2A3ByFYsVRnLRwPdvwGdNatueBQ53Cvjqc54spP5aAWs4v17C8A0tqiNwXOJEEH1pfQgxjcl50WTgLuvPioV2IivwrS1racQJB2MAylG8u5+H8JoMiaAwIDzByT6zz2iCMsh7UJiaRprFcIsAe3k4SPRKAv0Lbz1yW20QfOEFh3U6z2U9vo1zBzlBA6tdqoAF1od3wonlR5ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6Sum0tDWkK2t161g9op0Ii5SSQdIowhORsJrmLENns=;
 b=ggzMDuGsgmsDMy2P7v02TE+uBVXE3vUXCYaTXtiX6GfQnh5fv6lc42RKRJ9pNT0jGX6vQo2tnutU9/J7MQwkNQQTWPlvueGi+Dn3TpppBM3kmOEypMfMmjITHgvjBW7S7MkodvECKkN5z9LYFmladgrbZti5WrJ6dNJcAjS4rYC/V99vnW50/vj+TcqdNaFeRhf7x4WkN6m8XE0+aUwPL3O6iNC4SsSBeg+A1Ngzv6QTeVxAD2Qb375x8MgPFzJWgUvZOlyJ8IMA33mjEEIxXXWGeExUCL7G+uKIUbt42fVrT/Ln1GwPKaI2CJgshPsbQbIMLT/h7MYYhKI3O3hyqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C6Sum0tDWkK2t161g9op0Ii5SSQdIowhORsJrmLENns=;
 b=JNYuNIC8vF35DVyWzLdu6b2b9dO0C1hTNrGEo78nh2vdDw0NQsyzNRzWAXe5dScA5nbKZIMLmnhnxEB/kpc+I2T7xbvQq2on1zXzSZwVBJscdDWJ3orkLMQVlwUGxwiUu2ByCvu7XJN3M2brLQ2/Ysvhy4Ifp8JrbFM5eR4KAj4=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7694.namprd04.prod.outlook.com (2603:10b6:a03:32a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Tue, 19 Jan
 2021 04:57:03 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3742.012; Tue, 19 Jan 2021
 04:57:03 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH V9 5/9] nvmet: add bio get helper for different backends
Thread-Topic: [PATCH V9 5/9] nvmet: add bio get helper for different backends
Thread-Index: AQHW6Js5srDvdWB7Nk6D2IdsRVTi3A==
Date:   Tue, 19 Jan 2021 04:57:03 +0000
Message-ID: <BYAPR04MB4965673DF0282A743CA37CB786A30@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
 <20210112042623.6316-6-chaitanya.kulkarni@wdc.com>
 <20210112073315.GA24288@lst.de>
 <BYAPR04MB4965361DC74566BD26E3DC7B86A90@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210118182803.GE11082@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:1700:31ee:290:eccb:a9ff:3ff5:aa06]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f36c3dbc-cd83-45d3-9b0b-08d8bc36a9bb
x-ms-traffictypediagnostic: SJ0PR04MB7694:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB7694D5272A76C5818EB39C3E86A30@SJ0PR04MB7694.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BMGkWr0DiwjcmY2xFNrVGkyVB1i1YKBV7Ug35vI2uMyyZSckkTwG4gppWYh74hlp7WJgNk1Wc8hawxDoU3c3i9wepDHPcbUufNZoR9ri1TmlXoRzIkG8UO+mMDckgKqf1a2tSG8EW2F4d3kWlaYy0s1OjANc3z4t8YcVW+OeChe9Iy2gqBo1FZbpH+vNk4Y5SFQPnFEPnC8Unez5J+8paA/ZKfyFGxZJJFfrX9LEhypYtBQ9YTre2Lw3BqvRO5vkRpRUCdjyqi1dYbrbUfudFHJxkDix82iRVa51JHx16YaOLi0w+/p53oVifNXC64gY5X1K1jtA9qzAMcZpa6DgTv0plG2oGFpkXIkdc8UDWRwXp+qb4VzqZpUghlS+GD1PhjQsn23CxMl+NbtLAUaAEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(366004)(376002)(39860400002)(136003)(316002)(6506007)(4326008)(6916009)(186003)(8676002)(8936002)(478600001)(33656002)(76116006)(53546011)(5660300002)(66476007)(54906003)(52536014)(66556008)(4744005)(66946007)(66446008)(64756008)(2906002)(55016002)(86362001)(9686003)(7696005)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?ClVkkDDcwpI4S1GwMDNnVjglhdU/7iisVbF0XIip9DWuEk9o7cRWOJkjHFaU?=
 =?us-ascii?Q?V4uvW8Jtkgcoo9AmwtvvuD2v8+Nfy2/Ze7b7rgIVOUCiqEgJxe5Hif/FtMOt?=
 =?us-ascii?Q?dyF9/XE97x93M0JCkROVVkc4MX4YCEVtZ61n6PUM57fvLv6s0K0dm7ML/QDU?=
 =?us-ascii?Q?RxV23WIG3TasuE42Lbc7Y+7EEpfPmxq1z9+Hg3kodRWsQrqLdjx43JMfQpDR?=
 =?us-ascii?Q?0OaGcOV5f5mW2lhpGDwLKPWjX9VG8fvmZnBS/+2mukgUmFUrf1vh1IXnn5CE?=
 =?us-ascii?Q?F+1qugBnCLmVry0voW3N3HMG6D9h0QxAhSEHyU/fwvjZW+Gski6jjArc03ja?=
 =?us-ascii?Q?FLEgPNBFkOjj8ZlHuKBZDBsEkt3VyicPYUVNIOGERrwOc7ojM2I/UV63C5rc?=
 =?us-ascii?Q?PB5G+4Y7iOMIJsTftsBrAhbMbilLEGLpKw5K7/XFRKquPB4Ry4MfZP7AzwKb?=
 =?us-ascii?Q?QrtlJNrye40GinD5l8TQYuQgNIaXDwiLc9cjbhD5/DmaSd1M7u9shCXsO8Ba?=
 =?us-ascii?Q?9Yg7yFvlRLfwq/c80/p1OS5sQStUW7tco6E7qATzdq8nop7QAAnLEv0FXbMc?=
 =?us-ascii?Q?yqEPs8w9EQS6ElMBnI5ULH+yGfhFshPOVvrQfN9s2YXmEiBSlbaVDyUfmEPV?=
 =?us-ascii?Q?tCNXrTlreD9oAN3ks80wBnm2dcaDokMWUAYfD9Ihj/kllLcpoDNN8zhU2MoW?=
 =?us-ascii?Q?HPTrG1sC0m603Z248ODelj55K5vGOuYaRq/EDAUG97rEzGTRE+1x8OxfWtSp?=
 =?us-ascii?Q?N8hL2qMQvq9SAT1MiGLhJvV6aylNCptiCyoE4K6u80uNy6cDID7JYON/PDli?=
 =?us-ascii?Q?dz5yHt6ODHZWJUelvkt3q/E63h/gk5mto1afqRR8yX5vopwwYGqC7ObzsMzw?=
 =?us-ascii?Q?Z9qoxhHV7H/4uAiRhc0IOVxFAJlu8dKicZnA2G08juMYpT+StS+VM+nQttPF?=
 =?us-ascii?Q?XmyqI8L7EyLMrEZXGsNqWV0pt7hJ9d9dHqF9hGCCP9Da+zQzXhPp4Ew/8zQW?=
 =?us-ascii?Q?z4Jpjk/JSZJA75rK02P2GES9Sw0Pv8y09zxxpaTYMXhD9NnQO8ohQInMw014?=
 =?us-ascii?Q?+xi3BND3?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f36c3dbc-cd83-45d3-9b0b-08d8bc36a9bb
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2021 04:57:03.2864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2dNn3M9nR1IC1gWEWxZWEF6eaXmAR3jjwRO3OkqvmeXxtClUvkg8mOy1fRRSehyTDjnOZT7HN1oOcUSwZt3DB3bHYI7HVKQebpj0InSuwRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7694
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/18/21 10:28 AM, Christoph Hellwig wrote:=0A=
> On Wed, Jan 13, 2021 at 05:03:05AM +0000, Chaitanya Kulkarni wrote:=0A=
>> On 1/11/21 23:33, Christoph Hellwig wrote:=0A=
>>> I'm not a huge fan of this helper, especially as it sets an end_io=0A=
>>> callback only for the allocated case, which is a weird calling=0A=
>>> convention.=0A=
>>>=0A=
>> The patch has a right documentation and that end_io is needed=0A=
>> for passthru case. To get rid of the weirdness I can remove=0A=
>> passthru case and make itend_io assign to inline and non-inline bio=0A=
>> to make it non-weired.=0A=
>>=0A=
>> Since this eliminates exactly identical lines of the code in atleast two=
=0A=
>> backend which we should try to use the helper in non-wried way.=0A=
> I really do not like helper that just eliminate "duplicate lines" vs=0A=
> encapsulating logic that makes sense one its own.=0A=
>=0A=
Okay, I'll drop it, next version.=0A=
=0A=
