Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1C1C4332E
	for <linux-block@archiver.kernel.org>; Sat,  6 Feb 2021 03:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CED964F92
	for <linux-block@archiver.kernel.org>; Sat,  6 Feb 2021 03:03:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhBFDC4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 5 Feb 2021 22:02:56 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:28491 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbhBFCvL (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 5 Feb 2021 21:51:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612580978; x=1644116978;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=E1DUmiM0ycmy6zwDBnIrd3/oSxgZbonYO9UMhgsBdeE=;
  b=imIcZSk6rCycwiDeX63yqTWwd1yYXMYMNcoiEf6kkNnfe2O4MIVY2Rfw
   RyUGxPl84qLkPUX4zAYhdilHnOZwybVUjJpN9e6p/plUo/EPrX1/9GSUV
   XmzALwERNfUAq5s8+ys67A3XKzgoHBOiexspXkOT8J7IPOGI0gUjKHISp
   3oYvaeWyRVpQ96xYtGSPjd9cruQxx2FR5aHIQxtA6uirxX/Y+NWDgOJwS
   6brPH0n2w753JMqL88WPE9mpA4emOIfxT3RbCgcs4doiCIJXyLbX7H5xS
   Pda+QXFW7NEqyXYqMOWTBlun+8Rpgpmyx1HGALdDAnlTO9opeymImGG3Y
   w==;
IronPort-SDR: +heLSGAuF569tAswn6FmihyTfe97jSvMxnEqfHh8xfWB4PGLrjHZx0QPqVH8fxCF36fbnYdIAc
 vM4hwpRQRec9I4PZ7yt7Yg6fig01wJ9HZiNuNtZubgr/IkBD4vEcWIZLhubsYSTqw9vUU65G9X
 raHq6zbOPy6Qh7LHcl1rdO5MQtTALNK4zrLemKGl9c0gVvIOJq9sIUnaIy9XCFfGWiJE7DVcAH
 B9V+tB27D602qD6/EUf0PuXFL4YKRfLap5K6QZ+AjmQ8/g/LjezEFm756jLQh6pLVnXZHa8h/H
 30I=
X-IronPort-AV: E=Sophos;i="5.81,156,1610380800"; 
   d="scan'208";a="263381810"
Received: from mail-dm6nam12lp2176.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.176])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2021 10:14:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkAUmHEXqTRKHptY+IwIw790fyfZFdmAhuBgo6dKZIjeEwuQnt2wK+GakSCu06+YKTLFK8A1exMNEY3gCVUVrx+FuscOUDC0N8/Yv/7xZhVWmMBFXYB/7gc2mDsMcIi0t7gPGfswLXf47oe/fwzNt2gg0beg6dFnJVUxFyYa/45SeD1c8yGjSaCER7EZchJ3j72CN2tKyQzuq6fIhc4IWrJtRN3qAdqpdS4qoxZxczRGOkjWAy4vIqMtT9691HisZRxfgL7nrdkAPYfKOC9cgvwEUTx9uWzNfAsq/LhUi3E401CUUE4ML6hlqTILRxwYz5y6ExIizKr2B9SHiHRqLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GP3jE1Kt0+R/4r0jbdiTEXQuh4k24f5fihFoDZi/e30=;
 b=R9MFT9Our3N3JgxvQ36T/fIxgV2Cz20YTc2GXMUvofYNL4SThXy9vwV+D9eBSPFRCnp+Wvfuj6V/ZkJJq1yqy5S6BZjep6kQx39QWnHUb3ITqbsjYtZAgoEcl5UcEvwFJz7jVA5HN1tc/3au5TayU6+56geBRLQkhX9Wfr8QJ/A5Q7nwH7NicaCJnCr9OEBmFOgPV6kUjY6nn6BtuMeK3yckxbsy3B8EWsRjqwWc/l6zW3PqCreTob0zhkZehUyDkWTZCgguwFzNBx94mrUz9q+PlyrTS+gM9w7YkpktaiZX+jDoczjgtZcDrmfFkQJL3a7wEi9YlvuQRr4cvClCvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GP3jE1Kt0+R/4r0jbdiTEXQuh4k24f5fihFoDZi/e30=;
 b=iRtGWjyOK/RRH5xP6aAI9RL9M514Orgs6cGvtKCq6uMLMqomguuRwpiRD7DKUGT+48ycVPrjsxh5BJrgLcx8K+JQUDoBjb5HjLKJ/XMtFTkbT/ua2D9+Pz6+BvpnHkem2y/o/+mP9GFmSTxX004leaIYENJUF/Bf8qGwoUjVc9I=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4983.namprd04.prod.outlook.com (2603:10b6:a03:41::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.19; Sat, 6 Feb
 2021 02:01:26 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3825.024; Sat, 6 Feb 2021
 02:01:26 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     "paolo.valente@linaro.org" <paolo.valente@linaro.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Aravind Ramesh <Aravind.Ramesh@wdc.com>,
        "joshi.k@samsung.com" <joshi.k@samsung.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        "hare@suse.de" <hare@suse.de>, "colyli@suse.de" <colyli@suse.de>,
        "tj@kernel.org" <tj@kernel.org>, "jack@suse.cz" <jack@suse.cz>,
        "hch@lst.de" <hch@lst.de>
Subject: Re: [PATCH V2 2/5] blktrace: add blk_fill_rwbs documentation comment
Thread-Topic: [PATCH V2 2/5] blktrace: add blk_fill_rwbs documentation comment
Thread-Index: AQHW+3Il2k0WxjBBhkCev1OBGworiA==
Date:   Sat, 6 Feb 2021 02:01:26 +0000
Message-ID: <BYAPR04MB4965A95FA7DB7B463B0B83B686B19@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210205035044.5645-1-chaitanya.kulkarni@wdc.com>
 <20210205035044.5645-3-chaitanya.kulkarni@wdc.com>
 <3f752068-5c38-3056-bff9-282d1a4a535c@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0f00a3b9-c9c0-4564-f8d0-08d8ca431c80
x-ms-traffictypediagnostic: BYAPR04MB4983:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB498367F9652FF407F35F08A386B19@BYAPR04MB4983.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XvEoApuLGAQZUlDFryew0RFoSRkcb0tOGiPXKCuaXJXV+D6Vwp139ObR5oytdXt9W1457zzRSE9e6z3BH6DCrLuHxmUmWlXjLO1T5ljQxu/sK19+IjtGXxIjgooBlTzukeVfD6+YIFK2kn0qFhnjI0p8aTkRXdnRHnSr6gY6p8uUF2oxg1Wphwc6t7fJ9EasRRITehGIQ9uV64w+EVtAjJbHi0Ho9wO7I1jTGU1jQ9kY79lEJxlflSmTztldHDpI2MtM8alcJFNRczA+eeBwhZWNjAlB6BlLTObuNSMQuxjVH6M7LcCty9NitmplTVF0691oiCt4sfSO0tSQWCIvkGwgIfjGQHfmrhumpaO1Ok6hGhmXAIveMQPZvk6mzFOvHhm5jeySyZv53SQcgo08u7qnnOZfhBsvA3bQHdPRoKnPVQMbKMancE0/2xKiiD8qtKttSp57umaURR5iYerGFzogULcO1/YrtWyZsiwAXktOV35DFyxDuVCSSWaQCOm0Q5ZAF067m8IIkKWmFm962A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(376002)(136003)(396003)(39850400004)(8936002)(5660300002)(316002)(2906002)(54906003)(558084003)(7416002)(33656002)(52536014)(66446008)(66556008)(64756008)(66946007)(76116006)(66476007)(110136005)(86362001)(4326008)(26005)(53546011)(6506007)(9686003)(55016002)(71200400001)(7696005)(8676002)(478600001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?E+VBFSj1kYF7AqtwLBESGiLjUt1BT06TtHqjWh+xp0RbYZkzA//eMuUpQr4y?=
 =?us-ascii?Q?b5cByNdWTZzu5h8FusFM7CypIt9HqTNouHot/k6HRpaWw2lR8J0AfFhh8zyg?=
 =?us-ascii?Q?1PXKmbALhzr5cnfOSTvzYELkviNKkNpKg6wna3Iji7fSDzZXq5VA1bg52wYO?=
 =?us-ascii?Q?4G1Mg9ytdJEl8v2/mr1TINGjKzKdwfy3l/c21A+gQcsHW1YEj6vnbHROjr/0?=
 =?us-ascii?Q?A+lVYhbQwgIRTpllYZ9KMw2TjFJ6xFDTbXhQtXX3EYXMdmY/X5n7XX+Skfbb?=
 =?us-ascii?Q?N/zhSa9xAIojQFU7Jrjo6rd7De7tTmNsQdULotTPU9WSdSYeKY2X00WAjOfv?=
 =?us-ascii?Q?p1tUR/wxjTPOZ1jdIYj3NqxYbFToy3geVOUj86xFm65IihWYyUFyQrYjMM8H?=
 =?us-ascii?Q?tMt6xq5Dc7fzmmv1xCubrimGhrFaQewXxYbWjHqYbacctlxMy8BSwpeCidIm?=
 =?us-ascii?Q?O9tDjH3Fmb72xMx9sgOCx/ZA35Ip3v7VHCimb4Kcm+XJa4YNq/JMwJY7Lxq0?=
 =?us-ascii?Q?ZV3UiPl52suU0X6ycSn5WIlwuMN5hLb9FhHhehjoBOEu13SJtMZh2LP/aahe?=
 =?us-ascii?Q?hVAq05Tn807631kBTmekydbc3OYNcdU2fbkrJ50q2L39DW4N3wGj+smt2nmS?=
 =?us-ascii?Q?+qc+rmCxKo6XoTc5qI/EpHs3/1NHZGbIYWZPX92LOdJyS3ULFD+RcRm9ce8E?=
 =?us-ascii?Q?6rOsOF7Sj/4ft9zk3f5kCs60J+NFlwdwTOXnUgjoBU8Fh+sXu3pinITrEvxw?=
 =?us-ascii?Q?CVRowbQF54abxQty0Y6mnLspkmz+DEhdGwv2E7/oyR3Wv5YAmlo2ZcBgzTsy?=
 =?us-ascii?Q?RpKntVgUggGP+7RkQEH5MTmilJUVKFPKC5ROgp2jKuX0x2kR1tvLMfjNRWMY?=
 =?us-ascii?Q?IGAmI2a5kXFFVCcNmQPAVx0qaqEvds//HFrwFw/IEG9jljJ3Fi2/Xmx7Qf2D?=
 =?us-ascii?Q?uaOI8JBvLu3CcFCvPjzZYLYEqu0D0KbfpVC0NwK12rjRn7NZgTtXAylOXEO/?=
 =?us-ascii?Q?9HLrdfkvMCka6UjyfOXyEWT0Be3uYK9tik31CIk/K/T13lMkUftv0vboUgqJ?=
 =?us-ascii?Q?RWGOKBzw0GhlEqSUp47OWhmCiWmc2GTejqppvU7IEXFPrbPSKzJ/XjPXs2Tu?=
 =?us-ascii?Q?FW6Yn/GM5T7WbFGpakuBGV+ERl+5U6uCJZ09YXNwmuVzILpMZJQndEdPQlwc?=
 =?us-ascii?Q?cNuebsVIJf1Pt45XYxku8rg99G99SP4/G7kBwomydV17Pq29e9rCae9bWs6Y?=
 =?us-ascii?Q?zhn+FgsvS1D3k2SxSj1mlHkr/X1MKXX1tKaliOdQYwuqj+X5q/6//SgywEgW?=
 =?us-ascii?Q?dXOQTEZndutHNiMQ9Bh8aDix?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f00a3b9-c9c0-4564-f8d0-08d8ca431c80
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2021 02:01:26.0480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NiwZVRWNyVD5GKJXb6SXo/HMf9Y37SslWPG6OqjGXrlv/qO+QnlHN8bFjBDOxCcXreZmlJ3FPDyk54HVC+v0he1CDyNrXeyG4DvVdW74VqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4983
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/5/21 11:58, Randy Dunlap wrote:=0A=
>>  #ifdef CONFIG_EVENT_TRACING=0A=
>>  =0A=
>> +/**=0A=
>> + * blk_fill_rwbs - Fill the buffer rwbs by mapping op to character stri=
ng.=0A=
> Hi,=0A=
>                 for any next time:                    @op=0A=
>=0A=
Thanks a alot for your comment, it can be done at the time of apply also.=
=0A=
=0A=
I'll keep in mind.=0A=
