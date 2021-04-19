Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57235C433B4
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 22:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DCC461008
	for <linux-block@archiver.kernel.org>; Mon, 19 Apr 2021 22:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbhDSWUX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Apr 2021 18:20:23 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:29566 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbhDSWUX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Apr 2021 18:20:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618870793; x=1650406793;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=eH0CuN1lNET1oC/UrH7mVvlY7Ln9Nn84+Rm52+I3Ntw=;
  b=F/OVM9uoR2N3l9OBZ7CdW5k3YYO2OqZJZHUEQ3qjZprxrHXxdPplmwYg
   K5ykYBkBhlkgydaliapxYKCAapRxUNPnc7ca42GcNAIWEmPEQa/IcICcC
   kTpnxIf4RhXtX6YESiyzZwtZfC5SwAKqg+fYscL14U1aAEa+C4P2ygYHX
   g548jgG2MfHJZfqi4II+P0GmrMvUkYEM+nFZpsnYV1KaGGu9kqPW0MsRl
   2aCoxeEixbr9MFbfjekDJnjaXyZOZ06h4yCKaocaQj7YrunmO7m1X+26A
   z27wB0RmaADzjwHyxrfmpOran/ZrQ0tIyCc/KzUdgKyuqCqtUZU+2hIF7
   A==;
IronPort-SDR: iyDlGO8GJfLFb7+t7ZlxUJDOABxQxp0T8yifInCaxMJWV+/bgwNnUh8KeVKKQoLyKROY+N185f
 7J305Wk+mzdN0m467Vj4bYcsXELNsWPypr/eSOcXFFhT6lzlgjHExO+Yl7ikXP6Bvv30H/2jLO
 HrJHZyROazaPrBYKem+0k0TbG5bDoIz7grtiiVt4LuhC0yRRJNLvA6vyraLMU4gqXev/iNssob
 hO8D5zu9OSDpKfe13eqPj90u745Jlnl7DvBsLLPFEVudlhVSwctz9Jd+WRv+mwBVIrHEh3FkzZ
 WAQ=
X-IronPort-AV: E=Sophos;i="5.82,235,1613404800"; 
   d="scan'208";a="170013069"
Received: from mail-dm6nam11lp2172.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.172])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2021 06:19:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MRBHwtRPE3sYGvE4CyKbC/eTBr16mKB5T8DXWkLmuqcepjcEmu+y08zNveAL8yJuVhYvvQG8kLXHbcRjYJocz4MmuoulMJ5SXuoio12eqpfa3LzLlxyNByVnzpPrc7h7IjtbXOAqSTzIj7RmaWbJlQIvxjor6TpPQBQ8AxXzYEzsGBE4FuOY9LoBLGTTr3bktIcQI/cRT6QFNbecR+DWS4KsQ5BeGPB9GIGm+4wzdhl7Y4CMzF3kzeN1PsNxQ9IQRvXsHxRuCNlfu6d7Ymh+VxWwqHd8fHOn6yFoIT52FrquLFRwfME4dIbx8VxkGuFpz6ZiWwtRn3lkVI6gVAVoZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiEjacOmPlRc9Hfh4HCd19MmSIFUK4QV7204TK+SMOw=;
 b=jLaKUGl3rx7n46VcrO/q2hpXEgGd9H7VHV95ZyCBw0xw+2D7kLqsQM2XXNgU6Q81nNfezVE6y1BHh2Xi1DxAZpyTTmGu2vYA1DyqscT4b/9l64l9QuiHEJc8hedxo2rYfcZ4ItxOtbzrEkfi6F3azT9lpeV9X3yXSEmNGvOYfcXfihTa3/wt4r22j6BfeXVbDyvCphEZTx/SWDKJ3SQ0GwDu4XxJJtApTCdLvIjYCctybabv0w6Y6Gd76NHR5zsxBEKu/dOa6H1O03Rp3WFzILzMsHIUt1R/wb0ZkOxpCq9gaF77yNGXMTG7XdcjRncqbWHikW7kWoRVYhBlMtewWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SiEjacOmPlRc9Hfh4HCd19MmSIFUK4QV7204TK+SMOw=;
 b=AuLds7HwuEdLPM0AyIhGvzXW5xEUx8HlbiFtTQGQ5eBIkSy7nEsTU0HIlW948YbuSNDhxLPiiZK7fJpBR3sm5iyFtKLOUM5YXc2fOcOQlk3pT+oK7OsB6pZiKNLvj5+KjBOOWpjJ1Ob1CNoKpsgriYhtfseQ1WDbYGaZ/T9TORs=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4232.namprd04.prod.outlook.com (2603:10b6:a02:fd::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Mon, 19 Apr
 2021 22:19:51 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::c897:a1f8:197a:706b%5]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 22:19:51 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] null_blk: poll queue support
Thread-Topic: [PATCH] null_blk: poll queue support
Thread-Index: AQHXM56KmL6kCanFwEqXUyQ/m0BBrQ==
Date:   Mon, 19 Apr 2021 22:19:51 +0000
Message-ID: <BYAPR04MB496554C1F67A051A11FAB48A86499@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <baca710d-0f2a-16e2-60bd-b105b854e0ae@kernel.dk>
 <BYAPR04MB49654A1D4AC52FA3A8110240864A9@BYAPR04MB4965.namprd04.prod.outlook.com>
 <68a28d55-8c50-31e3-505a-2de330914942@kernel.dk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a3099db3-c508-44c4-c4be-08d903814049
x-ms-traffictypediagnostic: BYAPR04MB4232:
x-microsoft-antispam-prvs: <BYAPR04MB4232C5C931CD06DAC6AA75DC86499@BYAPR04MB4232.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mjWDgev14IwQUmZ6xpbieQx76oHN+2qmGMDA0HtZQfUIox90QGzCtHq8KQ3g9jMCXV7lKrGfa+ftTX0Em9FMgJg3zpwVXxd3OlUH82qAzY8h437tZZAC2ps/ao/zN37yDh27ilaqgcGozysBOFQOQTR4+Z0OybtJblDUrfFwZdTMIRLNvMn7k6S6WVzgkzcX1D0DFpjYsdZZ4ef0rQXIkNv/t3tpG39Z+c9zzpOg/cTUL6JK7L2uj//YKoiffi2KRkN6JvAQ9LeNgFDRz5EzYaT1Ux/ZD108iMyiFTRM60lBpy9o/oy61mVVdZygl/31R9fksp3b6uPvUkpeTW53tuWNnqcitdUQ6lyDU/R7H37BFmhUCqeD4mgdnbLjamMpxncnLIKQEos+fkjz9QyizogQRKqO7XAcZRmR+35Hi+I7Q0AV9OEYNkdxdRCXGaHn/ui7iskdjXVqkf2kSQ281eovOhAcAEFxLK3DTv4F/eJfhppNMtXecNoR3XkJmHzbtwDCr0f2qiPWeklVrl1XwOxmf2kRrYnES26ZSMCk5QZk69fqdXIcCgcdGoLx3fuifq4KqvYaVjx+JBtXEgX9NEhaWJTeLDUvTqcV9fisHi4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(4326008)(53546011)(6506007)(66476007)(9686003)(55016002)(26005)(4744005)(5660300002)(6916009)(71200400001)(122000001)(8936002)(478600001)(316002)(66446008)(33656002)(186003)(86362001)(8676002)(52536014)(64756008)(66946007)(2906002)(7696005)(66556008)(76116006)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?1IyvT3CEjcvJV33FDoPjl5JWT6Q7U5LC7Rr2rcqdPI6kv4YTWj7lhG+myxhG?=
 =?us-ascii?Q?Lyc1JkseNPAyExv1earwq0yH+ExCUN2kOw4ySul7Z8g7oWePGgG4d0aSluis?=
 =?us-ascii?Q?3iZKu3UWTeOWH7r4cubcVvV0m1GZ8duSAFx+cmyZeKbI36ttZwQVQ2+giihn?=
 =?us-ascii?Q?LoUdaJqxekMvJiMUysWkBqlGfsTdvRlxRJ0EutFOzXNPgsonrUSnC0pnFQf7?=
 =?us-ascii?Q?yhcc6TX2DDGfpcfjnWpVOojx56EMXFco9bcsBuzf+jsqLU73c3K+hmQ8gyTu?=
 =?us-ascii?Q?551Do0lF6DlABkcuhUC+XY4/uN1HUizYzlT1xmyV4Cfgrdde8EEqst09jHI7?=
 =?us-ascii?Q?//n8QtE8cTrNyV5pmWbDUrfAS8rsSVpWreIToo8FhM1lKLKydpKkxZ+kYjyM?=
 =?us-ascii?Q?ns7POm3FggsVKit4VwUJURI7yKAMtgPh5ygTAygObB3bMhxgcil0wjoOTOhO?=
 =?us-ascii?Q?2BhZLtH52jUu+gBgQii0wKX+Fn7Jeb2idzgNaYbKszpUY7yqY5LYbdsAt3PF?=
 =?us-ascii?Q?VgE32qoLYBy94Sub4FDvFqWpUWjvslhvZAEwT2Ytrs+gYe8F8Hr9OrvN+VWf?=
 =?us-ascii?Q?poy4QxuDEDw6JuFlbce1mdaGa+dU5T3/vONn1TmJb4V9f2I0vvmUP6s/QZbY?=
 =?us-ascii?Q?cSSfhFzJoMxB63kN+cQqJMxKeaBt+2Ep7o9QAXzPAt+IndEtpXlW6jOkiSL2?=
 =?us-ascii?Q?P5NPNcT/8cmkmy4/ezbj526Czg/bHOc1eC4brwnL354NSXvAM4AeWigR73Wj?=
 =?us-ascii?Q?tJgla8+IguIHriE8T/xvKkElDsoSvtRanNB4tSMnXdLfQH1XKuuTn+/6lXWy?=
 =?us-ascii?Q?D/pVPhUcyqnpQWM11r/wn3ihc+K2VuSSMO3naFS2NpW8VwDXa/qZU+HStfd8?=
 =?us-ascii?Q?l3y3dtBMhB5q5n3+OCx0C96Fb0LOCd186Zs05vZ3TzlWetavAmFwOkoUsZt8?=
 =?us-ascii?Q?9tNcR0j92bgc9PJnOAxbRUKT598V0FeS0ZbwYCBJJRpTXd+uYaH8gx1TIkGx?=
 =?us-ascii?Q?0+oy94DcUel6IR9bmbG4ap4zFw+UIEmOUPe4yiLOx7sa2KyO7vYWdPvQ36Hz?=
 =?us-ascii?Q?u4GXP5XLhQV2MlWpeR8WQf8f9hfDflKCBIG9RQehuM4ZaQMjd9O/HvpniHw2?=
 =?us-ascii?Q?IPwsKoYj+FDzGh1ILicJ2xuYLRBT/PT+Vvz91Hv7KuBtRgDq/F1vHGuSTsPE?=
 =?us-ascii?Q?SdESqPvIV+cwRUQ+s9O/qpxvFYeR7hYf4mRjcN94WoDm3Bpkn7k3UYZmVB/M?=
 =?us-ascii?Q?wqfH35DYxcE5xzBCsbWjtyJ002SOo1KNq9448p3zMIpVb5gNr+CjyTl6Kqcs?=
 =?us-ascii?Q?pyev+qNIgVauaU19bT/xKX7q?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3099db3-c508-44c4-c4be-08d903814049
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2021 22:19:51.2407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WZsx6LFZCg01GSUn0GeZM9OylouMoLW2vba+ot9ePzrqsCPr4H4EEWso9mvIKCoGur3aY2DlFHeBy59IrP8W85GZGr/l5GBDh2UYO3a/M5U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4232
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Jens,=0A=
=0A=
On 4/19/21 12:48, Jens Axboe wrote:=0A=
>> +=0A=
>> +               cmd->error =3D sts;=0A=
>> +=0A=
>>                 nullb_complete_cmd(cmd);=0A=
>>                 nr++;=0A=
>>         }=0A=
>>=0A=
>> If you are okay I can send a well tested patch with little bit code=0A=
>> cleanup once this is in the tree.=0A=
> Yes, that might be a good idea. I'll just fold it in, I've got it=0A=
> sitting separately so far. Just let me know when you've tested it.=0A=
>=0A=
> -- Jens Axboe=0A=
=0A=
I'm OOO, won't be able to do the testing for couple of days.=0A=
=0A=
Meanwhile if you apply your patch, I'll send ZBD patch with testing=0A=
in couple of days.=0A=
=0A=
=0A=
