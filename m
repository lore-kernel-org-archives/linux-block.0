Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FE3C433DB
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 05:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4741C222F9
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 05:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731893AbhALF6r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jan 2021 00:58:47 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:20110 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbhALF6r (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jan 2021 00:58:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1610431126; x=1641967126;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=hbM3AjN7Es26AGdELvxyTSp87BMWF623toeJonijovA=;
  b=Er7tU5k5zEDpP8+VfIlR5pfVlTuAINjjrsyQS+nuIQ2WFNU/6RIR+OH8
   xJKk4YBK0wevYT3cGdy9JD9PM6uWmdKiQnlCgDdnw9W7aBQL3kz5Bu8no
   2jy2GZZw3teLSyqTNYwe1KVQffkEpzV6Cyftm8zb56zeIycbbZHIrDrjH
   oMZx4ZjZ3HKvSlnLWj76K4LD0XD7uh67kR4wDVOE0lhUB45TQkumQH0WG
   xmx8kkArhbrp6tcd1jsOBuwbymT5zCeaPn9e36SAzT4w8CbACS0ZluyjW
   bLRhEicFMxiUC/kgS7KaQU7bYk66nhH6fjsAMrgQ+sbMSoGglVBVZ8xwc
   w==;
IronPort-SDR: vX3C/+5sZ0DrB8V8fJDwffZj6xXyHx4CutElPurB2OX6NOxzODz6PuExAtN6cFWAlsi5OzpzDf
 4t1iAUUBesvmevPltMjMncts370PLIexW4jU8L0QADuwoasvgpP44gQLpuZEb4hu4P0KKs2PXi
 zBhvVILtb5nS1zqKBtLthhhdJWahcl7AiPE+X04Ap0ZGxeMyVRW+WMMXzNBwFuZ4a3xvebD9pP
 Ne9i1P8u3qf7FDgCXH6yaDnH+xd96Tqg3Sgedxy70RTE+ks50MvWNgfwkLbRv+Pj8469mvqPx/
 CrY=
X-IronPort-AV: E=Sophos;i="5.79,340,1602518400"; 
   d="scan'208";a="267510132"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 12 Jan 2021 13:57:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYWL/4OYgBGiclSghZPMzCUvmStVJWQJ55h3fBJ1VpXhhS+X32FLI+6Kv0M9zp9btOe+T2fRKFbEIRHS9FvrQLwyIxdtHMY4TnICJfuPaSpxo5Ew4sH4juL2prkiCsZtYB1cXS0LPaSJIqnoEur9Nvu/w27v8Y23ogc1QFZkONArs1+W3UvGzQ8/kHH7DtKltttA7lF8aD1imn/KZwgdaWgG46TkOtLoRW5CFO6lK/HyLhXpZatVdjCACpnXEi38jzVOoYvJl3HqTW7hNZQROTRrlj8zf9ZKVCP7jnrFn90qtWIYDhNHEepbxqEdMNLdAjUmOa8NHszdZYKJirUaXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNoudw9NCr5HK6jmTKNKBroJMpKA+M95mUDptQrhoMI=;
 b=lB2ySwZvpAtDMheo/Y4Cl/Dk0EN9/ZY++kw1k011168/65XjQ5dsQg/YF5wqqn0qcly+8xp6a6tYHE7iyWzEzmND6U/K2cFdKsqHc8OB9A4eVfJLlL02J3/e+xHgNMq/kMtTWu0zmwuuetueJrZCh/TVSm/m26QYB9urIoHS7gn1Cfc9lElluZRsJDCkwdd4DqXfn2aFlonNtkPjPEFq3iS1zAgRv/Tg8LlYBC3QjpomMiQ8XcpieLqgK1qHr5MgLi5fu90WhipLUWlnufSUUyfJMCut00/Vmzs3Um4gT4FNQ8NvTP2Hyfd22tyoZ0xJxQ89ZiNzrBsrwaf1jDAezA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eNoudw9NCr5HK6jmTKNKBroJMpKA+M95mUDptQrhoMI=;
 b=g3uYpgjSNI3JJlfwkGRM13XPJt5UiVjyG7kPi7BjOHOgDeC++qMoQZiPHK7Xk70wqoW1Mpe/n15sCYRjJoIusI9RIS48Wikw60L+ZeeMQqQuLEK7xUsjo/hOxeQy9CdY4xKm6gzAjZ7X+tfMfgGLoIy0Lnnzc+SiSS3hQoerClU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB5254.namprd04.prod.outlook.com (2603:10b6:a03:c2::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Tue, 12 Jan
 2021 05:57:39 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::716c:4e0c:c6d1:298a%6]) with mapi id 15.20.3742.012; Tue, 12 Jan 2021
 05:57:39 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC:     "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
Subject: Re: [PATCH V9 6/9] nvmet: add bio init helper for different backends
Thread-Topic: [PATCH V9 6/9] nvmet: add bio init helper for different backends
Thread-Index: AQHW6Js+dLnOabsb902jm/8Qx/tj3g==
Date:   Tue, 12 Jan 2021 05:57:38 +0000
Message-ID: <BYAPR04MB496575ACE95FA2E6EA31AC8286AA0@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210112042623.6316-1-chaitanya.kulkarni@wdc.com>
 <20210112042623.6316-7-chaitanya.kulkarni@wdc.com>
 <BL0PR04MB6514DF0B740BE6F4AB3141AEE7AA0@BL0PR04MB6514.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b8c747ce-a44b-400f-44da-08d8b6bef7d1
x-ms-traffictypediagnostic: BYAPR04MB5254:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB525495BC6E75C7E707B4E13E86AA0@BYAPR04MB5254.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ru8hxywBiFYgcJZbk276ymWxFhv0lfj1iu929/HG3EmLL2RK2eCFo/AEQvT534Vah/jQDCeEZZu71TZm83Y3PB6tGN+J6NQY0oRmL2DrzYKHZeu2EtDxyMWvvDdJdYqVCKOZZ5cjmj1rPw8/zHhEbXG65OhWEizcowzfyJwFKKEskQIi9CHV6wAzYOrzJaOusBGhW5/u0DkSMRdh1Z2XkLQEPO2iBLLj4FbxqMluOI7IUWaRNHqsMZjyNUTgZxCWLuEAqT3aXUsdjTZavwfGE7lURqvBrI+ibL138jufXPJx/i/LJL0Nmk1lR9KpiRsHDofXLjjY8LYRFaJn8Na7WUjYQD62fht2OabxLgPHe5I78uerXZL2nbh8fVflmbcBHVScWRZ2x54uV/N20MxHsA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(55016002)(478600001)(64756008)(8676002)(2906002)(316002)(7696005)(71200400001)(26005)(110136005)(8936002)(4326008)(54906003)(52536014)(6506007)(9686003)(4744005)(76116006)(86362001)(33656002)(5660300002)(186003)(53546011)(66556008)(66476007)(66446008)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?DgtXvXvYgLDStskf/FO219DsU7PeOaUf/7NqEhMmEZY7Vjpf2atfzaf8mhgK?=
 =?us-ascii?Q?FHhC6W+TXs0CPQg0foJ8qqg5B4oFa3nnTwNEV29ocDNaRVnBqxw8+tyW4GEe?=
 =?us-ascii?Q?jK6FBuVGxa/OJuZ7eW8eIkNJ517xzmZBu6lcAUai3B9tx+iUz326j7IybI/i?=
 =?us-ascii?Q?TVi6tcW8GnHGMuCUf8qVXcXw2sDVoa/lnI1ioiaWeGI/PHx67dFPOaskNxa2?=
 =?us-ascii?Q?XxYfraa6IBAdzmMPHsbAQaeUkbOBZwCXinCyk5n6gF2VZDNvW2GUCj2mRspb?=
 =?us-ascii?Q?upU6KVwhHl2ScPKfGi1U/DvhUuR8aXZk4YI7zIQs4WH1U2Ra4xLUaK3YtqVR?=
 =?us-ascii?Q?FRFZnW6uvMrBol7THWed+T08/YSOBs6HpTAd8hnvZVqoImkTPMk1gOfMnNOL?=
 =?us-ascii?Q?sa/GmqAZ4riDlprdlxIuqqsuWT1qSMJg4/LleEfGDhn5epTGRP3yrxDPLUUq?=
 =?us-ascii?Q?z42Xi2KP3Mxr1tSa1/deQkrkV5kO+k7cTJPYRL2G/ZDvvhtV0/22aKpaE77k?=
 =?us-ascii?Q?1cM4DR3iG7dRF3g1aLn9JytSpYMW2HTDv5BHyDwszv9Ce+vZ47uMCArsTwaj?=
 =?us-ascii?Q?MPDF87XlWPkQnEuBSctClTDgk5FOoyywgIgvS3nKfoD7Smpdj3rLtYrlGlCv?=
 =?us-ascii?Q?6gJbElYTHIPS2cfkCRmtF64sJR91PbCMeV0miJwALwJIrhpfFGqNdk4ROfOl?=
 =?us-ascii?Q?XdHTkSV98YM73IeKyGtPQ0SrHk9oSogLsSLS7xLKgIPjniTpXKTGQs4vOUJF?=
 =?us-ascii?Q?FevTOMv97w5o16KiZFo/YP7qF45/5ukM0+gy5oua12ghPKoCuSu0F9Rwc+F0?=
 =?us-ascii?Q?uyOSgdSFx6R7ONNQURdseADVOsRT+5PfSQoUS9mXnktdrHnpfb8L39vCxbLi?=
 =?us-ascii?Q?dW7243Fh4vVmF11+Jo6VTJ/dg6fD4Qwa32y2ZwvixDSj4Hc9YVeI9K23S58d?=
 =?us-ascii?Q?B5YIwNaDFc/h7T9tOrWmatf0/dEO9iUevaZTFq26vGHpLLGOchmbNHzWfnrT?=
 =?us-ascii?Q?Xi1I?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b8c747ce-a44b-400f-44da-08d8b6bef7d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jan 2021 05:57:38.7130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oq3jZrbXJUlhDqY6vlUx/AVQTG3E/SBJlSlKkmDSm6UfPXktrW8uxfj4GMk3J6JXc5pPdTfByIlntuNGDlxydB7sezjQodvHmLEFz+2gWA8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5254
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 1/11/21 21:40, Damien Le Moal wrote:=0A=
>>  	bio =3D nvmet_req_bio_get(req, NULL);=0A=
>> -	bio_set_dev(bio, req->ns->bdev);=0A=
>> -	bio->bi_iter.bi_sector =3D sect;=0A=
>> -	bio->bi_opf =3D REQ_OP_ZONE_APPEND | REQ_SYNC | REQ_IDLE;=0A=
>> +	nvmet_bio_init(bio, req->ns->bdev, op, sect, NULL, NULL);=0A=
> op is used only here I think. So is that variable really necessary ?=0A=
>=0A=
This is just my personal preference as without using op we will have to=0A=
add a new line to a function call, I like to keep the function call in=0A=
one line as much as I can.=0A=
