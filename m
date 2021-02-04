Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B27C433E0
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 09:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 699CF64F48
	for <linux-block@archiver.kernel.org>; Thu,  4 Feb 2021 09:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbhBDJ1q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Feb 2021 04:27:46 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:44070 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbhBDJ1p (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Feb 2021 04:27:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612430864; x=1643966864;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=s8JGLE15kurjY/er6FcVTxCksJnQgvE4efb1nQww1Dw=;
  b=H+qIqZR77MwDEQehnQS/2+io9B15ZejXAYAyDodpU3G2qPYNnqG7QTas
   /7EBlxxNt8lR5gYd96xFyyGsWICgTPkUsZ6ZvEsu11pZCo1QKvfiKyL5B
   1CDvysvWY5IWQapuOa/DgAzRcr790mtLEHj2CkTVf8byhr39NCTDKRX/V
   k5B0gSoqjxyL6Ekmk2KztP/QulJxOJ+ExdCthvC+WNymX684ERkIuznlv
   /iLJOMu+Snsl+hwvCbEhsh1IXzfVy/UcbyAO8H962OiV0+e4nEWtw38lv
   Z+7URP3uju4PEEqIPeNBufc+IMJ4NfhsKc4RP4JriLLk0w54qkjK9i3HI
   g==;
IronPort-SDR: 9SXN6Jg+/Ugh7DRlCCs02hxScNS44k4dAIBOcFt0b4M2eA+yq1S6iQBkzLXF1NLxlXQIXStnSQ
 h1ETghct32u1gPEz/whxwIckCkTac3gRo4YS/d4nW6X+nWOyCc8k6OASbsr6N18wAx97BlUVj2
 UJ3xdrQVGT9JYDa/TSitxfP4Zhb3g/lxkOp+7Oju/0YstNtjgXB0oR/PfmfcFOGlekDB8a+XcX
 jOLRYaxlbE8Wa0kWn+yIo9mf59uGszfo5GDrkgVMexXCpxTJfwLa3qhId5Ss6N0MZlFULni5IL
 kSs=
X-IronPort-AV: E=Sophos;i="5.79,400,1602518400"; 
   d="scan'208";a="269532490"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 04 Feb 2021 17:26:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ux0aEneOcF8orqFAFDP64+kARL+kj0b1aG95668VKok/PAr2ZcpGuEClXatklE72EKr3fLaGvVF6bcd3aO0Uk0f/T6I5ZnllFfhFlf5VUsXO+PR6Qmnw9j7brmPOWBPwBUygkhC5lIWwWywIn4C7p7shkNUi+z3K1EwRMnPYOLtn1yErzqbdrW/CBQYaXoLGz3jZcbTM8Cwtwy1iG+sVhTY8xN0ARLmHZNdY5/LXDQHDpONy48KFaZqbv9Tuih6GN7yi5YPwVeutmqsYwWl2K2NbRwn5GAfjuzUxfZC140/5yfMkAChlUjRhj2fsmRmg1v/XyAFbx7rLxepa/NlmnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGl3mAoGaEHGVvtyFda4WY7sYpCX2c4cQIEdoEsCe7w=;
 b=QrWep42t17HKafFVRJcWAfTSAztTPU+QOgax+/Gf3EXOr1gilJeo+r1YH37m+CNxuFF/LJgdO2T+hyzvx5p1ZdoBNF1b72Jix1KHdLU5X6WKxtKxagP4tbmOEuG6D61Qgv1ME4mQMAT/7tIzD2y5RBIJDHQ5ICP58s0SDS1ijDfhA5ANfIYwS323VCYckpZCODZdDcg3Zeg8FNZCDJ6dP8YiPp84c5UGhKw1tLrnXkyxr0c9CT60M7mHYVIqJwaUaDsv5nz6BxqMMWs2z4IJULQjZZPjSV8Yn38jMqV2Aqw8ZtXN8OJYYlViGFiEZNBSg4wo/uB0fWQCEIFjv48zbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGl3mAoGaEHGVvtyFda4WY7sYpCX2c4cQIEdoEsCe7w=;
 b=OUq4OI1hp2jKHVsh9ss89PF9cfZl3s0wSfj2tWJIpfMOg2IBuPkU5Js5vuJOo8JXm8ln3yDPH9C2ivy/sTK+tTUPfGE1UE+A/9VmtzthSKM1UpBi95fsOCeCW/8+vWgN7RgZ8AOmtYFY9SbJxwWe++ZdrB1/RjEW4C8rajMot3U=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6415.namprd04.prod.outlook.com (2603:10b6:208:1a4::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.17; Thu, 4 Feb
 2021 09:26:37 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%8]) with mapi id 15.20.3805.024; Thu, 4 Feb 2021
 09:26:37 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
CC:     Christoph Hellwig <hch@lst.de>
Subject: Re: [RFC PATCH 2/2] block: revert "block: fix bd_size_lock use"
Thread-Topic: [RFC PATCH 2/2] block: revert "block: fix bd_size_lock use"
Thread-Index: AQHW+tJcQ7YrsFFCzEqcRekM9SFuAg==
Date:   Thu, 4 Feb 2021 09:26:37 +0000
Message-ID: <BL0PR04MB6514EF47346458D0436CF497E7B39@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210204084343.207847-1-damien.lemoal@wdc.com>
 <20210204084343.207847-3-damien.lemoal@wdc.com>
 <SN4PR0401MB359853B6F1875CF1233A495D9BB39@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <BL0PR04MB6514F0C5971F11B5BC548202E7B39@BL0PR04MB6514.namprd04.prod.outlook.com>
 <SN4PR0401MB359820BA20257B72EDFBA3499BB39@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <BL0PR04MB6514C26DF3AFF2A78B5DA438E7B39@BL0PR04MB6514.namprd04.prod.outlook.com>
 <SN4PR0401MB3598CEF4CCFC248A7729AF9F9BB39@SN4PR0401MB3598.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:61dd:3796:e34d:42c6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5750319c-1d19-4342-ddb3-08d8c8eef8b8
x-ms-traffictypediagnostic: MN2PR04MB6415:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB64155001701BBE69EF2C598DE7B39@MN2PR04MB6415.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Zh+l4OVRI6expFZkkJhb4lAlBDIIQ8ow17cvkZj4TwXiyospSRJFyCYXePkuqTm/VI/8FYt6yPPsYTj6wCZMzXVbH5zsRYLBF4aMRPJBcpdQaXf7zzdaoTxL3igjcvMRgbXkrjPW0VhiG6BsDv1Ogh2LztgNV67tpx8TrAmUGXEfjbJ8ufsSsB/aK9pJ7FjCAraWgyANA8uAZ0aP79ctsB6c14M2T2a4g/Gsc1c3mHstio7mGdUOxLs3bfTHbBcu49k99mupPJxuBfYF7VCsRQFPhkSw/hyS5dUJvOhWeuRYpPaT+YmhIbz5HUO2BFf46/YSIpoR/nUfgZ3SHm5tm7M27EJBk3gZC7W+XyXMMbGsNMvObvTD2kDf7WKv9e3lE6I3xE3A/aOdOu5Oyvsaz+6/9VQoi8Z/Wq5PX1YWLhcsVp9V/odCNoohjY/ajNNVl4YEHs5LSnPRlCG7+H2j8cWArgJj8UG7x4uU9dfRpdjeI56f6Ax3xxGsmoFKcog/eTpPAeVNJukn6aAuwQzWrQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(186003)(71200400001)(478600001)(86362001)(7696005)(55016002)(53546011)(6506007)(66446008)(316002)(66946007)(4326008)(66556008)(66476007)(52536014)(91956017)(76116006)(64756008)(110136005)(33656002)(83380400001)(5660300002)(2906002)(9686003)(8936002)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?GQQAadwsb2Nl2a3YyDFMLSaCuOYvJNgB0OZiCknJ3QCwG9IkW5sVVY1yo/VE?=
 =?us-ascii?Q?oLdYrNH9RGNcSSTmFx27Rx7i1pSeq5NCvPiYng1QSESekCpDJj3XMLPsuVvX?=
 =?us-ascii?Q?lGH9ZTL+YNxwDoCul6RmUOx8fZwmoj0wLFMNCAbNvBHlipU+FK1A+sUwR+Ii?=
 =?us-ascii?Q?4iTK3wdt1cdW8mh0d6wqgy2Uo7B4zl/jWUXfRCjom7FiRf5/VIUeQ848DvbD?=
 =?us-ascii?Q?HGCP9e6SDIgsv6XOXdA8siMNry2Izktd6t6dMNZffYCQPuSJEr7OWupPflyE?=
 =?us-ascii?Q?AWwl1cl0hAcCeKFWx78WdySIBWYoCdyELp7310r7R094vLNKWOn8FZG9O29T?=
 =?us-ascii?Q?zA73BPaNtNeo18OxDDkb9eCrotHXoYaIWfYEEcd0kHurq0x4VmnhyVS6Oip8?=
 =?us-ascii?Q?Bu/HzepFhRBsiJcvayJiHl+8HYhTLbv/ujuLTZR9XgZ78S4BvNyO2lzUqYyI?=
 =?us-ascii?Q?+hgwnEuJyPcnHyT82mcB9cJTuYcM9w0MoEDFE2VZkvAYJTPpnZifVKtzU6il?=
 =?us-ascii?Q?ggl1V+fQGAEPoLn7n71xMLd/vUs0NW0qvh8FAreID2yAnrADnmlZ++d7X1tI?=
 =?us-ascii?Q?g0PWAFG8tD3mCzBgsIHcHarfRQ5L/2b4z1AgBLOCCkhNS8dTFvN88+JCjRm7?=
 =?us-ascii?Q?1By1PvISxK84mFxRvmwaJqKVN1rmZzygPS9YWdjh4slpohfPOxr1uiNm/IjC?=
 =?us-ascii?Q?etlx5XoCXW3p/qc995rOnvMzcG6KewzV07qxAbBdoTlsvqfxPXf1+33UQ9Ua?=
 =?us-ascii?Q?yhqjU8JB5eRVkYZm6YguMv9HWqpi0wXj5CmLEs8hNOPmH191mFOksatMj8pi?=
 =?us-ascii?Q?tZwVFEi+C8ERXDk2qkVcfm/E9ZlYMD0stKz+qGTwHkh4nCm8kGnD/eO6bLfv?=
 =?us-ascii?Q?iMWgG3gtlbRc1NTVHmnl4TPvE/k2uLjeglWACyrchZU1jXhDnhHMgpQfFLO7?=
 =?us-ascii?Q?xTEobrUkbiq5bm7Xof1bnXDjS6P3c/O5GIWREqMOizMMqsKHvaYVmbhd6rto?=
 =?us-ascii?Q?93U1vHmvSl0fgZl6WcHGTN3XSl/17N5zldZmFU5QylaVHNKR0W0tY6LYwHl1?=
 =?us-ascii?Q?GGBhmsgoxIZJRD62zetdLNVl8Vh2zqeUfIndSy3vxzKlUv75FooQhGePW+tO?=
 =?us-ascii?Q?e+VgAOJZwScvXg2wMoI+5zgmDgKAqPgLENXGyzb+tJU03wpn0B1/wqk9FRom?=
 =?us-ascii?Q?VzLuIfpiBNfdzupYqfewkzjRgz2mhPQNZlsvMPYYVG7blvJvMhzxvfLhIn9V?=
 =?us-ascii?Q?EBZLRXjl4lL81swJVL17rZzU/pqzOkzNkZVGuH/0imray7KmAQbA6a4AMafs?=
 =?us-ascii?Q?wJVh5Q/BJi5FPZX+dT7N1wAztugX7fuij9oJt2SEwPV73vhSnVjP1Zyc9AIv?=
 =?us-ascii?Q?/rY1IEdlSu8f+N2UM42pDyUJCQ/uaBEhdLfvRTwrWhPorI1sLw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5750319c-1d19-4342-ddb3-08d8c8eef8b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 09:26:37.2546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NQdKytVtQ00GocJqaKTDYie28NG5Rh6Qd9WvWjBLiWz2QwcOcGeQEsut7/5xSeOVcLH1clbAWP/DHPAGGk9LWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6415
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/02/04 18:25, Johannes Thumshirn wrote:=0A=
> On 04/02/2021 10:20, Damien Le Moal wrote:=0A=
>> On 2021/02/04 18:14, Johannes Thumshirn wrote:=0A=
>>> On 04/02/2021 10:03, Damien Le Moal wrote:=0A=
>>>> On 2021/02/04 18:01, Johannes Thumshirn wrote:=0A=
>>>>> Given that #1 in this series is accepted,=0A=
>>>>> Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>>>>>=0A=
>>>>=0A=
>>>> Do you mean "if #1 in this series is accepted" ?=0A=
>>>> I have not received patch #1... I wonder if it hit the list ? Did you =
get it ?=0A=
>>>>=0A=
>>>=0A=
>>> Me neither, seems like vger is acting funny again=0A=
>>=0A=
>> Patch 1 is 111KB... Probably too big and it gets dropped by vger.=0A=
>>=0A=
>> I generated it with "git rm" and a few other changes (MAITAINERS, Kconfi=
g and=0A=
>> Makefile). Is it possible to shorten the "git rm" part so that it does n=
ot show=0A=
>> every single line removed but just the files being deleted ? That driver=
 is a=0A=
>> single file, so very large.=0A=
>>=0A=
>>=0A=
> =0A=
> Well that's bad, but how could you remove the driver then if vger doesn't=
  like it?=0A=
=0A=
No clue. Just hope Jens got the email.=0A=
=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
