Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7091CC433EF
	for <linux-block@archiver.kernel.org>; Mon, 20 Jun 2022 04:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231288AbiFTExk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jun 2022 00:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiFTExj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jun 2022 00:53:39 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A560ADE9C
        for <linux-block@vger.kernel.org>; Sun, 19 Jun 2022 21:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1655700816; x=1687236816;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=MFKzwE6SdGl1CmgD1DD7rS632SgRD2xKuqBr+0Q22I8=;
  b=jajkjZ3StS11e4dfOIwcaaKZKhrI9U+Yz6WL/jg/SqbiUGrJEKxzDwjS
   fjYQ+jrwhwwq65Giepr3X1XwqwRMKTbHwJMT41FYFnhkNzuPvRfbgGZAS
   hdYrnVgNvfkev8F4kGsOzkIlZkJYOcXDlg15K0+plZU58/yhLjGJ48VU6
   /hUf4JkV1eS8ZNVZjWOPxykLLt/lWBmayVilfcPAR5bB84HM2uriG4ITT
   2YpMLlCsUcMlkefw6wxp4JufzePvQ969SSImmAfJniKB4C8OEioZ7oT1B
   s/Zs4Mpv2PcQ5yaxgb9BszToMSfPFx7FxgmzhU1zhNNPfTZwWkNaLF+yL
   w==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650902400"; 
   d="scan'208";a="208451796"
Received: from mail-bn1nam07lp2046.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.46])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jun 2022 12:53:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AkDIT0JDWAlK9AdTNEQx6Q//6L7jZVMcanSpMR7FnUmpQo4WhTTiAs1rKuMa9oPRx8VFn6q7GXyd9n52TUk0VZ+Wcav02ZT43D8g6NObmS9mPQNVCIhJhzRPgznBLbdvMnvh94culR+70kuOlbKVUIrvleXsTrRq0brbpwxmqS2unfi4CFq8twwMvGBtKjBvdCWDYB/ruvb4+v7/wQB0H7dvR+yoinXNMG9rrUkI5/zwPzhD8W8pKtbAI0HQf7LLOSUqnHITjUKWlcB02HvvQsGEfcOqfPOZuHeVoHPGm63Kr8PU5cnwLbBGJZsXFVnWnZWENHUjwApp4F200rw+vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFKzwE6SdGl1CmgD1DD7rS632SgRD2xKuqBr+0Q22I8=;
 b=DqFCC1ADJHwEJeCTNoj2WJh675T8smDTRuigLTrCl4QVOOkv5XWul145pPTRQSzTyhacbX69TrPgQJ75/zyWJpSaUw/SO/sJQ91XQPqikzP9l6rr3rXJMbv5+EMj0vgUX8hDmujTok3DiruoYWZ8hwq3LMuQO7yatxDVsCFw3QvNM/9MQdWftxnNrSdqbq9UJ9KpscaT9mNMQZ47M6MIXgarvNNwY/vrjQokDPEw8VwU/Tlb+34AEcCp5eMEQ2/3k2Q9xSeJZKQmBHB8jV3+r5cq4YPdFmfYB0LqThJpTuKEJ2ghPJsHe6cuyYm9VnJFaLH7P5rx4dmxMZJHZMQLuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFKzwE6SdGl1CmgD1DD7rS632SgRD2xKuqBr+0Q22I8=;
 b=Yr7j1XlRccr6NQZrpwscA8Weki5KMgrd+mi/E5dye0GdzVFsq+BfxYD7CUuQWM8e/KfHN95kkTqv24xGsuoA7980RTcX8ROn4Z9nFsnIRlajhuv0qg4ZkVLrEPWuBYIkgQGWWnyv5oUMkF7D4/B0e7s7cKst/Z6qMVYfz+WQKQI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM6PR04MB5897.namprd04.prod.outlook.com (2603:10b6:5:171::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5353.14; Mon, 20 Jun 2022 04:53:34 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5353.021; Mon, 20 Jun 2022
 04:53:34 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC:     Jan Kara <jack@suse.cz>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH blktests] check: ensure to suppress job status output
Thread-Topic: [PATCH blktests] check: ensure to suppress job status output
Thread-Index: AQHYgTdHc4d9TUA1NUW5U0bLTsrVL61XwPSA
Date:   Mon, 20 Jun 2022 04:53:33 +0000
Message-ID: <20220620045333.2zzbsl4roaosxnwo@shindev>
References: <20220616041214.612087-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20220616041214.612087-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 66f810e5-ff96-4cd3-35f2-08da5278d468
x-ms-traffictypediagnostic: DM6PR04MB5897:EE_
x-microsoft-antispam-prvs: <DM6PR04MB589760057AA713FBE04FDB45EDB09@DM6PR04MB5897.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r+Idd0OXm/SR+KJRCS3FCyU7lQpKSys2K1GMwwDh7K/iwYvf+Wt38qHaJiRcijJ9SXv7JSmnZ4NPpY4UpWQ99CgU+gI6UQvGWSY4uXs8Y/y0UrL+ALzUqemGJ1YtDSUbjcQ1hZPLwz0QsmTQsXK5xKBQDoxhZddkgfs3eyNx5/xQyBE1CA4HmlgoU9cog6H6ctrmtWA4H264fpLUIlqxkIwp8UAntW3mlQmnH/cxgcu9cJfJ3lJcIWNyDRcUBmacuS/dU9guXOqp++HdRpCcQpSw4DMK4FTQBM+Mdz9tkxDyQOd+emcRBQfF+p3iIAnXySedNRwgBLEpE1zYeqz1fb7Y5Z89SLIw17k8VV+JvmVFDF4bNMWfJQDRmPDLg0yg343w1STJGxflc+xE2L3xrZd1wiFwOxqmo3ce1K7qfEAgt5L5bqbQ6BESR4BlkXirovXhKT7eNAqXSTWhLU1weNrj38D502mmkT52FWK/beNIJOD6Vut3LifIkI3ZODGVSZNIkPU1LT8QIG0CYWQ06kG2nj2xG+/zEYgQqu9trwlPNohFd1T9HlcQXkfRWXd0/7E/EkkQWOZ4zRJc5D1q56zZTxxw059aE+UOfbOYG2vp4wqSBJUBWBvtbzpa0zfjs0IXPzUfzsCsWFn0W3vuWGx0kYIxe5jTCeyudxs+Jg91/aF5d+rGxkQk9sdteXTaTQEjj/Hfz0rlHX8ZUL2ApNNwhRv0Rl32aZHsC6WAFSk2U/62AX4QMflQ3YnRK8c3QE7LgYKWZ/xlhU/ezrSQOoQ+gj0KdjIfFlRux3BtT8Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(366004)(1076003)(186003)(83380400001)(33716001)(82960400001)(38070700005)(122000001)(38100700002)(6506007)(6512007)(71200400001)(54906003)(6916009)(66476007)(966005)(6486002)(498600001)(4744005)(2906002)(316002)(44832011)(26005)(9686003)(66556008)(66446008)(64756008)(91956017)(76116006)(8936002)(8676002)(66946007)(4326008)(5660300002)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?781xfumVtS82wR6Mz3eFPu+bsy//U+O33mNuoMcq55CBwdIqUWTcDvxSFR1c?=
 =?us-ascii?Q?QYfSgxivPecvhpto5yz23yXKEgxfp8H02Qhnr4/3OSQOpWGIA9bMr2X4aErm?=
 =?us-ascii?Q?OI/HTIKu9abAK7MrXr/1quyJdCHOxbZ6VVcvjGnHqaxqDWgSJSGjk9YYZlAn?=
 =?us-ascii?Q?kQH19txZF900P+TIicZaErnjcxt7GvYjHp351lQCzYl/U8BB3dMYZwa3u29/?=
 =?us-ascii?Q?FcySys9yJRTmWz8nhQfklQn2sGQiCvn2zHd8xr/8QOBtB4ksPglbKGnHYdJP?=
 =?us-ascii?Q?77f2UUjvVUU0khcnclG7efm0WOBkUTeAPnuTxzalEf3rT5ZssB2apuec8sp6?=
 =?us-ascii?Q?W+IY1oXdsNWFuW5MRpZWEfMVwfxtuXPk103GnVIAKMHx3OU+t1+mvyOZ2OC2?=
 =?us-ascii?Q?397znB57XdiPDEVnvy6SVRYyYwF4twti8ueXys/v5dOuJfxKMyIIAgq3qcQh?=
 =?us-ascii?Q?XjyuYm1abORh/H+vXWdEBDMxjEHV/Uqnx4K/YVaoACiy60nWZL1yB6Jrfa4h?=
 =?us-ascii?Q?krrXwX3m2k72PVagNkztVnDIJNHSahbsPNmLfMYioxCniagKN75poJbUO1Ym?=
 =?us-ascii?Q?nD3bsxaklc6a2/qwSzFbiwAf/bTLLTKnbIOHzDfWO4EEtXtvPI9yf3FmTQCp?=
 =?us-ascii?Q?X30nKrOQSo9C+9r1LFZl/NQ9YFax5pg5SypbWqCyyHES53G7WKyPARbqh/eE?=
 =?us-ascii?Q?K2dJs+XwaxIWZd3YHFjmk7vtzntxHbTcVrF56G+AaLqNN2A3VZlk4xgP35b4?=
 =?us-ascii?Q?rxEyF4LbTRMt43t0vfAZ4t5EnisZ84iovlYKrmNOf4i2k/CG6Yumbo+g0Kz3?=
 =?us-ascii?Q?e2+nbi0NRlh6EYiI9ZvMsVSOYebzSW2Cpx0F8iktiHT5wbztATQoSuIYtjAk?=
 =?us-ascii?Q?/vadrrp0L1Nsnn8Og7OQStQSG/wnCWODJdCIt+FDcK/ZwRV6LAE8GZLuJ+oI?=
 =?us-ascii?Q?wlSr4dpvYmBsIBrUHL93e9fNUnJ4fVCgcl+bANe7agoT4ZyAhNY8MdS/mHz2?=
 =?us-ascii?Q?zpcXHg/O+wuRHuXRh9XD0U6/TEADDOBbHPGsjj/KpdxBdYsaamFrFDYJ/e4B?=
 =?us-ascii?Q?qae4XnUQRqfEIVw3Rk/9nZljDcLyXsQxuguq3ukXYZJPKaVlwZr8lLqtXQlF?=
 =?us-ascii?Q?3tTgJobhxyvRgcBmAChzHD6ISlmdv+ghe0RGdiLpdSdKWTdYY8MdXywhCmWk?=
 =?us-ascii?Q?hGlYW0kR/ed3gK31oUwCzuJKjTzyI8QA6j54YKem3XITlvbFKWtG6r/ZZwy/?=
 =?us-ascii?Q?q6RKgr3sQ/Ds9EnUDJtWg2cXgzlO20aew+O3g8MNXN4qls1fTOt+7FJK1LNd?=
 =?us-ascii?Q?uvrAbOHHJAV8JAsxX0hoGhxBPRaBAnPZ+dBQvhhHdpjBYAOTIFtUG+jhF6gc?=
 =?us-ascii?Q?nUICQJjPQZzZ1mAE5uRO1GA4vOp34HBUFOSvvZ8vYftYxyxB6u+WjEvZSWza?=
 =?us-ascii?Q?adNyzfs7HoaTE2L8MW48arxFZLyPtNpLLdTkwMLZNQGQMC2OaluyDISZRTmg?=
 =?us-ascii?Q?ukNJqVWzcE1pO4EdX6I/Sc+bemrSxFIgB96nnR0gGf6hIAtwXsYEGqhtmQnF?=
 =?us-ascii?Q?OhtaPuZAZsr5DhgCsK8NLuN2XA2HABOY4ml0Za5nWFQ/o3QwcT3YrAOu4wOu?=
 =?us-ascii?Q?SJ0wSVwVbor+FewkDJIxOJOoOx5Vje0gU09GoR5aoby00ithA1X4k40XUDZM?=
 =?us-ascii?Q?zXk9Scy0QhnZbDmtf4AxRSK9LcUVXwrjmHBcYG9IMLVXIl3hfaagb7/zgMnh?=
 =?us-ascii?Q?jr8UKvy3nQolIsE8pIojIkcDdDUTjV6/uSqFecRAKDBs54R84nmK?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D870E31ADF79AF418F37BC464DF1EACC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f810e5-ff96-4cd3-35f2-08da5278d468
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2022 04:53:33.8874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3cb1WAvo5lm1ANKGsyRweVgYXUxudvAfvCedLD4S4tnrDV8owkWanBdL0/MxHKgA/vb2FLTaP4zfhkusEhMFLBmQ79CyZNWF2VDrmoVYFkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5897
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jun 16, 2022 / 13:12, Shin'ichiro Kawasaki wrote:
> Unexpected job status output by wait commands was observed on openSUSE
> 15.3 and it made some test cases fail. To avoid the job status output
> during test case runs, ensure to turn off job control monitor in sub-
> shell for test case runs.
>=20
> Reported-by: Jan Kara <jack@suse.cz>
> Link: https://lore.kernel.org/linux-block/20220613151721.18664-1-jack@sus=
e.cz/
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Thanks for the tags. Applied.

--=20
Shin'ichiro Kawasaki=
