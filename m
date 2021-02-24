Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77789C433E0
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 20:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B9D760202
	for <linux-block@archiver.kernel.org>; Wed, 24 Feb 2021 20:31:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235116AbhBXUb1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Feb 2021 15:31:27 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:2150 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235211AbhBXUbZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Feb 2021 15:31:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614198685; x=1645734685;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=AtovU8JDMaOsycVlqS7Yezm7wLqL0nsSaX3pzzN6jQI=;
  b=DFw9diW35cOpV0Ky3tjNYmTcnl3qCmtck0/ptCgFQLS2/pIKHe1XPfUv
   CHUoXQ7r92mRcVMmcxK0tXouuygpTJ6s56eFTgbbOJsOqZICQX//OJph4
   +NTnyPK9pmGktMD5kytoUdBjbaRh1AJvo/1S0c8JzmpgjmIKUHCDeYQRS
   MOWVtb/o3utHXstiOhsTnMOhqcwSqEolpnTGhNU0ygeIwBrZ8eYOXr0zW
   FkNftRpQXWwEfV7ZDiYmsrqxkJR+S8aSqfityYfjp+T8Bk/2QZD4RlYVn
   H2M9BG6tY71sxAqD2CSKKscJltlDEjPLocD5CY/vqXjaXLsUmhA5DZ/Vb
   w==;
IronPort-SDR: 9r1CSmV3EcPvrBLwVFENs0MJFsPK+LoJM+jWtg6e0a4bZJhID0h8x+fMRFApyX5Q98QTL1o8hz
 4pwtPaqfzhvygHaW4GxvygwHlmgGMdmvjxokBzlJRwd8zZBEO/p3+/YP3JIaGX8Pe0xpDHb3wi
 lZXg8OTXYCfT4gjeGv/632qwHEux4X1KpCZZ9LFQK10DFhhuAGUDmniJkAQ2kZCcpCYEU9YQYi
 mABSZh33qn9LlNqZkdsHQ8IciL4e8mjRVtLYUgM1IvmnLwRE9590h7+m9E3QOU59LRyPb3TEB0
 YgY=
X-IronPort-AV: E=Sophos;i="5.81,203,1610380800"; 
   d="scan'208";a="160714332"
Received: from mail-bn8nam12lp2172.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.172])
  by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 04:30:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bcZTRhKLv2+t8b2WY1dKybQxqUFOiXkjaIq2hDpbQ58BPc0XapwD47WmhD4rJ9Qoj9l5kwE9kt1F5l7aUNjGZk7xknGBME90W7ns4BXeL9WDBIsJ+j/zxr1UCDR7pTVe9G0uDJEbq2rDSdRL5AWHHYZsdyQSSu+YrxJHwbbLSd/BwR4pdOuSrgn+pmbhFg8XKp9vjCfXBSDg1N+8GVkADAhZz047UQe5lu+ZQNysEZWNsPDvc81nJi2ZfKbkWX2Bw9c2qth+Mogeh1DVJzZ43w2ucyZBkegCB0JQDiPHThpd49ILvabwYxJRLzsJE+JuVAqJ/ohyfrzioakn31a9PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtovU8JDMaOsycVlqS7Yezm7wLqL0nsSaX3pzzN6jQI=;
 b=Y4zIZA79471uG89skluH8wjdVa3uCtxY0D78sWrhYBZbtDgyghMubuaPmB6arASPZV+jrmf+V8DIDhY3VcEy9xjS5CKO4fA4rw14j3bGJEz6sx/ILW0Vq9SuCeiKLJoixKM24uqw20PHrZyFX5WnkMV1JGIDJ/f9PeDci+OovRfJZCFd13/d8och8u8OUKwjMRiH098s0BJ3UvQtnrcfjaslL99zHWRENsoxUMKG0mxmnjE0dsUqSpFCb4CFXYsjJ9NsfTum4AkyfcSFLEvqJpIeAVKreyDGf8M/ziJBOUy0uvLadUz957XpXqeJIxKbfhscWQmTCjUfDdj/GWxwnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AtovU8JDMaOsycVlqS7Yezm7wLqL0nsSaX3pzzN6jQI=;
 b=zFscJPPjoF1JB/RubvZEzVy5YL6wuVARi6LLIsx9CLBVxuUihUTtDeaWIrhYuXPRZzbvnbmD1ldwBuSYQcX56AnSONhHMXotQM2ySmn55/FQ2qTb8lyrq03Hn6ALPiPjNld9pnGYb2jEoJ5/mCPguZpn1XXSUZstvVC6x5gdrYE=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7550.namprd04.prod.outlook.com (2603:10b6:a03:327::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.31; Wed, 24 Feb
 2021 20:30:16 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 20:30:16 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     Jens Axboe <axboe@kernel.dk>, Satya Tangirala <satyat@google.com>,
        John Stultz <john.stultz@linaro.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 2/4] block: fix bounce_clone_bio for passthrough bios
Thread-Topic: [PATCH 2/4] block: fix bounce_clone_bio for passthrough bios
Thread-Index: AQHXCn7OJI/CTrREs0mLHn5pM8I59w==
Date:   Wed, 24 Feb 2021 20:30:16 +0000
Message-ID: <BYAPR04MB4965996FCBC586D0738F8B98869F9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210224072407.46363-1-hch@lst.de>
 <20210224072407.46363-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: de36d3e2-7944-4c53-e252-08d8d902ff06
x-ms-traffictypediagnostic: SJ0PR04MB7550:
x-microsoft-antispam-prvs: <SJ0PR04MB75509775FDDF2FE8CF8268C0869F9@SJ0PR04MB7550.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r6mr8dtksP8ojasuiqzq3DXKPG/cz0bM/1scI5RRQcWV05B3DqwYdY770mrRwffoEqZYowhK6GrxRiBonLRpdQ3ZZ2HU3Oy/LQA9WJ9tPYPJkvZB9sID1zX+HwxZKinQ/kLZENsq7jNimT7dKVVzyL742Ucu/M2HaF8b8A5RjKcw5N5dMjcRcM8D/XMljYofW32aGz8jX5sg5VcO4un7SO25/xfYAug4dr5Fb3xUsTdf3f/VQqFBdoNLVtHpem4gwoMqlVVrfEUClEkn6Ht66mJZcMgy/X5xgznETNxp8k5jg1/NO2YfLAyfj0PbiDHOtlu1BtbGl/BPwQP6aGC0x8Jo35FrBHpDzulwOn8sZUc1X7bgCBJAvUUHObpR0/VfoPMpLqaHf7eN1TlY1JEcYOefWnhEPIQNAWgWgZ4CfsC3v0M/W2etCnCEpQnRtV6iLSw3EBbuyJMbGjfGnHF9/kqiz2cXozuDCuOR3tsdvhVpRQEVJM+nKp25zpJhNAG/VUJe/KjBtsBwiu23tLmkqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(366004)(396003)(376002)(53546011)(86362001)(83380400001)(186003)(7696005)(4326008)(55016002)(9686003)(6916009)(8676002)(26005)(8936002)(478600001)(71200400001)(33656002)(2906002)(52536014)(66556008)(6506007)(66946007)(4744005)(5660300002)(54906003)(316002)(66476007)(64756008)(76116006)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?75o4N7a1trwx/G34Z7Cbhet5m8NRE17x3hDHLmGENbdetN7AenSYDlDW/tU6?=
 =?us-ascii?Q?JUJHLmp6nqW6bYHjroiMEiDKfOZSXo0rOdcozLNF+uQJlTCbx4vR4m0NNt7O?=
 =?us-ascii?Q?AYc40Vx6Of03FeusMmgFb+DzcEOJcH1XfaZSI2PgsiNcmx9QWIkFWCuxaUEi?=
 =?us-ascii?Q?7jU6WDPZlY79YMTXHm8BLoTK455J+9bL+dxk2WZns/EgaTXQujT1zY8zPZPf?=
 =?us-ascii?Q?DvfVcbcVxXld8mc7wsz36vVsMpyHyxX2Hx8tvV6UI3dpyQiaz5qAxKVr100S?=
 =?us-ascii?Q?1yVviY4qZFlLzZPbpz64yapxO0jy5ZGTOG/qKhvDZDRv1wORlATUW3Z6RPaL?=
 =?us-ascii?Q?kIj/UYTsoIFrgwupGMKTlwrbfR2m4KW4j9SMiMJnpjHDIjaiMgVGVlIN73ta?=
 =?us-ascii?Q?p74xaoLc9FPgqfChnGHuUBpSOTln28S8ctyjNqJ+EWemkrzqGu6JYW7Hzlz0?=
 =?us-ascii?Q?6WcH5uH7ZcEW3WvqllVcrSpEVtvyQqNDEe06clOVSTtLyfy3H21zZPmrrUR8?=
 =?us-ascii?Q?ESBn7RdPeIaxSiKoJH6W/ivmsrtymeKFgPFNu612lI/pmdU/QmibLAB+GjEA?=
 =?us-ascii?Q?wpHKJYF4CJeogYBWhz8x+qqMO59r5QZ90Hh4L0yC85S3pRDPNwQpvnnVOTYA?=
 =?us-ascii?Q?p+VgQ2oQRfFdBKWbJcVT3QHn6x29VqWSzQtDVfcy1B7UaUbR+HfYykFGJRsy?=
 =?us-ascii?Q?iIQzLfGfVpRMNvB/5tGg3uNsvWR1SpvtXc+neRtuufx7gS4sB2RFbgoZA0Bv?=
 =?us-ascii?Q?rqoFDKivPWTe4WNf2g49C7gikx/YaIVXAx/lOoBOWXh1KNsk0VFlHg7Q01la?=
 =?us-ascii?Q?6/1GqWTw0isPZSP3cKgrJfnBTbhT/SHjUh3MX8996lLeq2MewNU1iK0ZN3Os?=
 =?us-ascii?Q?9/lp3g3YSJJayX4gLT3t34MheOx16cCp0vkuQsEQuk3TRXXPgV4X7dKMbu3o?=
 =?us-ascii?Q?+u0zkWZDgStVUago7NsQ8RSXdIs+dycrbkG3HD/qsDqUF1DLojRZ/zOd6stj?=
 =?us-ascii?Q?RWaCZ6OnEw60q5zFGEmNmL0Gv7x2HWcVtajhxtT1R9TU/9TUj++ISrTPnzAq?=
 =?us-ascii?Q?B/M9dfqUQLVVQqxLD4cRCIOFSoAlCwpu0V0C8M7gAQrRlI6FWpiurPHBkDoA?=
 =?us-ascii?Q?fUnG4l5XGGRqqdPi9V48ALlx95y1J7T/1NKyyprotmxiVFHIkKhCAkElt1Z0?=
 =?us-ascii?Q?cnJDmlwVuDDBCeHlqRr0auPPsuvLUQxlZ/yHcjDyasg/+o4zSjHf6cO5DbLE?=
 =?us-ascii?Q?jN3DeXv1TrLAUVTFKCiAsoJ57Ff9W+JSWHUskginrwMFOAHh8HSb2nJL21DU?=
 =?us-ascii?Q?SOs+mou68Mqb72pd6yzwukVE?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de36d3e2-7944-4c53-e252-08d8d902ff06
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2021 20:30:16.3329
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Z9R3ZhluoMLVoofHCBwTIcXmKHdg2wXXPuUtXxxdED07Z9cmu2b4qiVjnnQkH6MdyhwmKLXptNrbPFepQwEO+Xsj2gfo8m4k1SAus3eCeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7550
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2/23/21 23:29, Christoph Hellwig wrote:=0A=
> Now that bio_alloc_bioset does not fall back to kmalloc for a NULL=0A=
> bio_set, handle that case explicitly and simplify the calling=0A=
> conventions.=0A=
>=0A=
> Based on an earlier patch from Chaitanya Kulkarni.=0A=
>=0A=
> Fixes: 3175199ab0ac ("block: split bio_kmalloc from bio_alloc_bioset")=0A=
> Reported-by: Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
