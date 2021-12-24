Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B8FCC433F5
	for <linux-block@archiver.kernel.org>; Fri, 24 Dec 2021 00:52:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350460AbhLXAwk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Dec 2021 19:52:40 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:31777 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350452AbhLXAwk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Dec 2021 19:52:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1640307159; x=1671843159;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0cU7E2mLYjeQPohterCmCHeeA0NYLM786yDSOUcABxU=;
  b=CNUcpu2o6bZ91uTbqryDrxO3GZ5ca8AekHPiBOQPO2pQpn32jVycxx+9
   HN9KBGkZW2W0q7Awy9lj6NZwXCW6NcEQJye9caSWjc/f1r2F88dqn4fmX
   SfQCe8mtYZwpKvIpgZHMqTrGR4bj1WwRaEwTWn08SQ53yvhH4BdEINQL7
   Zw/Zki2OVHsjGLKVz51uQ0MLci46InVkGYmWvXqQ9rMw15yZwvXmbVFKm
   6g140UkDR1+8FeJzddrJxBpxkO86YswR7XbubKlF++I8EIGi+F66j8HTS
   HaDc4H1NqSfefkatTZPIe3FI2TysdSJH8LEuVWm5Dr8AVFK7AaH7rikHM
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,231,1635177600"; 
   d="scan'208";a="300846953"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 24 Dec 2021 08:52:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=McBW2/8rRqdbANUDTE3EdlYZFEsWwhn9r7TFC5h7fGL+Fs+UL0ZoXLeUpDeYo7qPJ8iwX1+S7v2GtrBE/20hJ9UIWO6LMh0WLG/PCm3lXzA22QEHXs0LsyYtbLj8ZibPTgcyUXNrX3eDi/umcF5CblBMhJCezIqqCNbmSu25vl2YjFVXPFrWh9+iH8B/8rJ2dtlBT/8R7KtrVkpq0mEZcyos+VoCgj/Ql9L05suGRolau1tvT4sj6Whax5Hyk5a5rsdVMZ3l4HpDUkF5tQv28tsZskPW2r1iFSeaiGPKqtlMlkN/jBqgMBXIU5R/WAWWI+WmbLzhBWpR52HnSpDS8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=80K0YeZovDW1kdHhUsYUAOYnSmIKuGMb407yR+Ko0r4=;
 b=cGUkX4iwPOc0shEbAsXS5sFhEZXK5WIggVijFQ+YXofowFae4BqfrjDO9g91Fnz/lqQfBVY0pZNyZJ500HTPkHl0POpEvp6Uh8FyaglT6teAaHt2d84BYHdq4U0jHIesS07Znr0AzjTo82gCZuI8yqsyHDVYz0x5zlKvI+gZd+3IusG7MCXtZYqdGYF1wOymkgMfgjlLESK+E0Fw5EvXf2XojtIBjyKM+DtIU3+jGNzUqw0mxN1oIOMyudBpwb902Vvedj0CUEJpa19xlOqaLDYUjzQOczPnsZ0iz22qeOiMdJslfO3X+RUQW9CDLT282TmScqawOiFASs8qF/NpPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80K0YeZovDW1kdHhUsYUAOYnSmIKuGMb407yR+Ko0r4=;
 b=rp8DNwa3NsrjDy3tIJKN8ZP3lD2qq1ao9+zyKAikUuy1gvFhs+WGwYFbs23I/cxvRzRX0habniUGdO8xjY1ny8G+AXhGuMBCN4/Dgn3K/a22KvdUCiqHRJOrrmAdHBqV58RpgU0rR31RYPKCx39+pDbqwStGOPHAIzabi2ZyBL0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM8PR04MB8088.namprd04.prod.outlook.com (2603:10b6:8::21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4823.17; Fri, 24 Dec 2021 00:52:38 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::51ef:6913:e33f:cfc]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::51ef:6913:e33f:cfc%5]) with mapi id 15.20.4801.020; Fri, 24 Dec 2021
 00:52:38 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH V2] null_blk: allow zero poll queues
Thread-Topic: [PATCH V2] null_blk: allow zero poll queues
Thread-Index: AQHX6Eb7Cs5SXvZ3O0ieh809OWrnVKxA8IiA
Date:   Fri, 24 Dec 2021 00:52:38 +0000
Message-ID: <20211224005237.ryuyjrrn63t7y7sa@shindev>
References: <20211203130907.3667775-1-ming.lei@redhat.com>
In-Reply-To: <20211203130907.3667775-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 807643ae-7b7a-4b1a-9003-08d9c677aeba
x-ms-traffictypediagnostic: DM8PR04MB8088:EE_
x-microsoft-antispam-prvs: <DM8PR04MB808883F9D847EB394CBF0AB5ED7F9@DM8PR04MB8088.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kO8Sh8GgTDfn/3mSZCi8lbpaccaLvTMvD/GsvVt3sEpOh7x6Dh2T3DhUENRv8FDqIB9HYMwjJtf6t8/o0p8eBarJRZC0m7KMEEWQLwlIt1UbcLwH59NJNb3mc4nOyBPxMakUsYxx1Cu9kp2zkR8nHAeDu5Cn8Udt10Obu4/iCa5Sw86YUXdYx38Q7bIf1JW1smgOigdTRAEl9/n6dd+ePO0mQ3YKqIHK2ldeiejziTc1bEZduS/r1rlyVW8yRudaYEPnUJXsRi940KiF1TXRqR1BdLV391A6aFHi+U9B138Le0rAeTJcLPNfmw5qqvGONeEVZ7bXHFRkj7eIkpzypSXUn87TDTuaWq42EPle6GiMLXcjoxzUqgaqVkDLnUJmh4blznrmVxgBEWY+oVBRbMNbQlQ5mJXXvXDB5jyAbHhgxSFKrRwogXTTjUspc4NAcpi/Ge6YKIpJLrXXCAjcjOvIV1yy9LOFZmU1JOS7CjziHUXH+zxTZ3h5rxVX7+jUK5su3Wr90VnUbc5GthzCGNnCVIdw9pLuK++dJ6iKS014lX192Ao8GJS7eSke35ZrVSd33jCvkKRfOs6Lwq2NbjULKw2GG8OjyUCuEFWOKP8zZ6TjbFhb4Pp2Y6NGafDW0QF+xGIhj7qlR9DF+nwAOVtpJDoePc6j9e2IEexkWevKiYx4y9EWqylvxR/qTqthpuBgW94sP4U9j/ldB1wIrg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(366004)(8676002)(91956017)(6512007)(76116006)(6506007)(9686003)(66946007)(82960400001)(5660300002)(6916009)(6486002)(66446008)(66556008)(64756008)(66476007)(71200400001)(38100700002)(33716001)(8936002)(44832011)(2906002)(4744005)(26005)(38070700005)(508600001)(54906003)(122000001)(4326008)(316002)(1076003)(86362001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9IZsrK+jrsJio9IvXmuo2u9xRalvQEdY2AU0YFXjrVK9GWJX7QO6WHtBTT/B?=
 =?us-ascii?Q?gwgnwu5HomtKCisuQRD4/WifwAHut5gi2gecmT0oHvbdDty1M5EIfiN+kVbC?=
 =?us-ascii?Q?DocT/8jIuRf/qdCk0bnZ7HI0/ItHEh1xpriQi5AC0keYyYECqdTami+GFscC?=
 =?us-ascii?Q?P1WPBw/5ZvvaQm++kD+Sw/iMmqGZkDXnQsa/Os67mpQcmDuQBLscs8F9BYMV?=
 =?us-ascii?Q?oPS4IzxJzVHhmlmpRwR104HZflQnCFgEml7bGLd90gZrvfzWMkbTbyhPjqLB?=
 =?us-ascii?Q?9SXMyVx8yC38/9YtsjiCFfR1bd/fgtXsMoFfOZHKobFdV1Hvaa+d0Fw634Ba?=
 =?us-ascii?Q?qawRmIjDEPqW2qySwTAI96bByiSkC+pcNT9bV+697LjpRlNmHSg5a4/BS0ml?=
 =?us-ascii?Q?687x8/8yRDbfLko7PTEgWCMB7pcbFtYh6+j1apxeEM2r/0Esu3UgsKryBqLB?=
 =?us-ascii?Q?y1qiTJWnEUQLJ092csA4I78+8GLC8i+mJEF9DpYRCE9ykLgX96bDFgvFSObo?=
 =?us-ascii?Q?ZJY+AYznL3P2gnHF4m185eNlLvoGLYyB087snalObrgcpC0QCpR8UrLPQWpg?=
 =?us-ascii?Q?9a7wvJhowljBP4iBl0bJcJnxru/J3jziNnaGjNIHajz9OJWS+nlmUYoodmfU?=
 =?us-ascii?Q?q9A9qOXl6nTVLPdjzRdMYVR+fm1O4F8S5HH80jaOS8joDy0yttzGCKLJPijd?=
 =?us-ascii?Q?9irBaFkO4c8ZbHmsJ7nsufU24Lxh9eOs6WWTR/xKSX7rgHD6ScQ4FOx790we?=
 =?us-ascii?Q?9L+dUQa83AAZfKxKanOSpwTderJ3r6OrBngclNBRr56k+DbT9wjAcnXKJHAI?=
 =?us-ascii?Q?ZoSgA6nxH2ZH8mQnMdd/NzyBtOHXrzf2aU4iliDXOyEC4t/GgTWiNXgSSc1+?=
 =?us-ascii?Q?f9HnNWLuzkIrpuBtCLjbEzMUpnVT9gf6T34WaLoDvSBy4tRGD890xP20ubqg?=
 =?us-ascii?Q?aCRYjsFWsysiQtjYTDabgUpBMgASt2uWA3t99xW8gDVoyRMiv3ixWc8c/Heq?=
 =?us-ascii?Q?jTH/M/8uGaEVXhsjbUFDLE00JHsR76Fa6aAsopnszlvelBPJE987QOgikNn5?=
 =?us-ascii?Q?T7N0q4hQuTAVKvT0oYbqFG5ubdBOo4Eg3nHl6yD+0ZgvAmuFRyiuh8Ca6TJp?=
 =?us-ascii?Q?W1foPQmVChCEbOHgKwhPYAmL8LYzYeUmZlqUQ0nCWQcY4m+Xyk8Rx9Psy2Ln?=
 =?us-ascii?Q?EA7PCA3GCTLnYa0QcJfgMcOyDLj42Va4pjoTywV27Uwxw5o4DPnuIEfu8GRg?=
 =?us-ascii?Q?a6j61UnttCtyt8vPDK/AMUsblahcy+hmvQwP1zek+frFXD4XMEgRg+3IdzrP?=
 =?us-ascii?Q?nNdixse3apmaQE0HZ9LRlzq9lIPS6JTkNIy6PRtIwKX2JMP5JgmqdPGKNXqr?=
 =?us-ascii?Q?ViRlzcIU/MXG81Zz8GrTbS1GPqgPa915kgdkB4xrc4Zjra7a6058Ch+t/f85?=
 =?us-ascii?Q?4iOXGrifMGxl1gTaEt4uaFPRiWixOwN7mkDBe1YKDEEzbw288aNFWdYTkNKE?=
 =?us-ascii?Q?VPy3u/dR4HWuDT5ICxgVprBbJJczW26h76WF74FdY8MxbRw4HILNDCA8nV4c?=
 =?us-ascii?Q?1SBmKiativDUqPyjvjim6paGKqvcvm47xQx27AIrzCS2S3CtrX42NlCkKOQ2?=
 =?us-ascii?Q?rPBExd4FcVz3nJ/X6GkYCIY12GIZsatZjYQV3zxJyYHqelu0FZ0xpBePHfn5?=
 =?us-ascii?Q?R7+ayxKXA1eYmXZy1I7KVcQBHmA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3DB510718DCF334FB3CEB69B7D15F358@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 807643ae-7b7a-4b1a-9003-08d9c677aeba
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2021 00:52:38.3568
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ATYP3Q3yT1ZkQaRsstG6JVYAu8WPDgX9Lemjz27h92+VXSdsyrAQhzKSyr56s0QItE20puSuYN17nU4R6txA5jlQL3TeHtKzaCzMCNm33s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8088
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Dec 03, 2021 / 21:09, Ming Lei wrote:
> There isn't any reason to not allow zero poll queues from user
> viewpoint.
>=20
> Also sometimes we need to compare io poll between poll mode and irq
> mode, so not allowing poll queues is bad.
>=20
> Fixes: 15dfc662ef31 ("null_blk: Fix handling of submit_queues and poll_qu=
eues attributes")
> Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
> V2:
> 	- fix divide zero fault as reported by Shin'ichiro

Jens, Ming,

I find the V1 was applied to the for/5.17-drivers branch, and the additiona=
l fix
in the V2 does not look applied to the branch. Do we need another small pat=
ch to
cover the delta between V1 and V2?

--=20
Best Regards,
Shin'ichiro Kawasaki=
