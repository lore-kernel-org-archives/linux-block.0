Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 500EDC433EF
	for <linux-block@archiver.kernel.org>; Mon, 27 Jun 2022 03:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbiF0D5t (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 26 Jun 2022 23:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiF0D5s (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 26 Jun 2022 23:57:48 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F92389A
        for <linux-block@vger.kernel.org>; Sun, 26 Jun 2022 20:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656302267; x=1687838267;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=F8H3bqibf8GK7Jc9sWpSC4Ygo9x0j2fJYttIiHprQho=;
  b=EGrFxOENdVu5odVL9gST33o976+VovdfhP/MBw78C1EWzDDSV5ecpLUT
   AC9jFb8CLqtUDtOh1b62PpLUdjZg9QE9kKilWVa1AtU9FR9bG/DhuamSY
   QidUKcUpqG58fEzP0joLqbElFzx+dN0u6L83TRcm7N6srRFHqir9x//cu
   /9lgTPPfEQsCJdl0E3TkHPGkAyskY9tOTa9eXs2eKHmn+KMg9UZgfVUq6
   Lm2D0l5o7YGFZRmKfZYqbbFjI0bm3Jg6qR30Y1ybbOmbcLbIxuNwBb+IG
   TIbCTbzH6bOEgX1ZSeV70f86tMPjaYriRT6JfYKk7dwwYXMuYzQsDOK0g
   A==;
X-IronPort-AV: E=Sophos;i="5.92,225,1650902400"; 
   d="scan'208";a="308482130"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jun 2022 11:57:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXmiGouGwMLnq2WBoBSpwxD0fKqgVIa8OQmf3Gzl5cMBzamR7a6gWIvwVptEkkeXqkFXVVYStYwWiyts6phOWF5Luphn2YpfvycZU5fFf0kikhAwd8IwLxupfS3ke/c3IqIsBVli6LtNhlNGyFbB0WauLaXXlPFHtRllK17k38Ah1DjMYQT3G1fXVK+xpTTkVsNDjpVAhNpDBCMr+pY+CzL/iU2JXc8qb0E3R9u1HVzieB0kT46i9l0rPSbaAvYi/PxHokbDnCUEJ3QJliRAF7ztjQis3EL8hWET+SpUnZACPogwONIqs7olb+0y6RwpGsjoiHmOZHvtC98uvDJonA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6oWa8Ys17B0Imas52Q32tXH9exoiFDtozJeAF+ZBU8=;
 b=oMlRskEhfwiLK0poMZBeMFwXMgkgHvURHlgLZITYiflezCw+IWCJJt85zdBRa5gb7wlucJ3o3YbjNBd7Dm+WM8sjLGZahNGsbBn3Luxk6ecUMCJk+sYgahWpYvtIIRbcU0en2vYyRae7qriRjzm5qLg/tFlfTHCpQJX04+Zg7BsAAgYVFISm6zt4EL+7jwTax+DQtBABDjsmgmDFyeNmv9ETVhfOHlLpQckseFUEORHE4cX5JtYFxA8QELGo27ZkEIEUzbdyJt3KoPFCi/KYIDFvi+/I1czEYoIJ9YqA4QRfcOkRe64OMrEIaqIYLdaMaZyU7XFi1xyMgMMV5O/S0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6oWa8Ys17B0Imas52Q32tXH9exoiFDtozJeAF+ZBU8=;
 b=aP1gdeQkiJ0nMQgsR1qe7xH3IdioP5r11nBh85AXOPGTW5zGgiiQrOQ8JzHNDOuz1eDfD0U3lASxcA78ZAlrt29jq8SpCKqD282Zls3/cj2w/a/50ClqclRl5cE658NTWQMJ8V9YZf/RyUaRZAxYTDzqztaNShg2wRf90UMaDF4=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BN8PR04MB6243.namprd04.prod.outlook.com (2603:10b6:408:52::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.15; Mon, 27 Jun 2022 03:57:45 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 03:57:45 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] blktests: Split _have_kernel_option()
Thread-Topic: [PATCH blktests] blktests: Split _have_kernel_option()
Thread-Index: AQHYiWh6PnDd0S4D80eWOtQjtB16+a1ioUsA
Date:   Mon, 27 Jun 2022 03:57:44 +0000
Message-ID: <20220627035744.idl4clbv6fn6fepx@shindev>
References: <20220626142428.32874-1-yangx.jy@fujitsu.com>
In-Reply-To: <20220626142428.32874-1-yangx.jy@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d07b579d-10af-4d61-4fe9-08da57f13131
x-ms-traffictypediagnostic: BN8PR04MB6243:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PrhfPB4+etrbujXJ82faqYQvCakvx6XT67uZY3y0SLzX7gMNj88b9F1+MhSjXjJjaKcHGaZLPWZhsWTh6UldXpUE6WjFbXITQG23skT8ErHUyFM6Htlkme64rQl2D/1bARuVvA03pShO34VRhx27CbehpySRrkmyzao/0RhnMW/O7DGY2Z7/tAtAMyy9rpTZHFS51EwXES1xL8h9Xf5C7ulKSwkIGNso60gL9o9ybLgIsE+AmnR8m0lIhqdUWLG7aMh4LlnWOc0p3uU4eBnq/JZ/ua4WbqFK8sW4RX/d+zVzpcVw2uXaRzFkTK/3fRuEMX/MgH0YKtcILFC7y/OigC/gJb27Usx+uE1SClkUfBa/EnSrOP0xd80oPUcIGLrxG7rd3+IoPnk60dncvdQZXDj9i41QHih5d/W60w1px1WYRxPe8k1fRPFW2klpoWNgh+Kjh6J34JdYYJcbHLHKQuYXF5JIFhOoBKiuWJD/SdQXP7lZDAvGPtyrnY0AW1sVzrRfm89AyffUGJXhXL7pnD0eigIjMyk4CvKSZ/1qKNpawWucecixEyOoMzpGSHspmFzObY8FvYJCW912ofLEePxReBJmA/QgW7XbxzimiT7WvNTqDzBL40DpKzRp7AmjBkpczGzom/Z6UzuGLaNl1YqfIKP4sQb/yi7Vt4OMym2mY3bjCQLtjR9lBZE4v6auI7/jln+bsOonZ/e7yVU/t4PHhWsmD9d+sNGW4jxJCEmTfg5tjLukOsOV8c3uqSTzpeu42A5BoSavxaI1XhxOJtdbEkb+KBSafqzwPFX4Uxk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(136003)(346002)(366004)(396003)(376002)(39860400002)(26005)(38070700005)(41300700001)(122000001)(5660300002)(6512007)(478600001)(6506007)(44832011)(8936002)(9686003)(33716001)(86362001)(186003)(4744005)(1076003)(38100700002)(82960400001)(64756008)(66946007)(66556008)(66446008)(76116006)(66476007)(8676002)(4326008)(91956017)(71200400001)(2906002)(316002)(6486002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?r+WJsGWjZJVdq8+qCtHonhsQaEYNw1vuiqfATzngwZPkUdPGAiUTJ5rWV9CK?=
 =?us-ascii?Q?6UVm69coq273m66+GAY896zR+bA/+D3wFCvd9qLGjW8/69mfwNQZf4G/gTPY?=
 =?us-ascii?Q?YkViPKdRR5xOG4mxtx6gzxaJJSOIzpG3c47Vd3EQne+mLzXxhRAkn0OfXRok?=
 =?us-ascii?Q?S1snbWN5cdbwtzwo6YWuK0iTwHnCGpuywUaHo7sThwo59oq7o8gJfv4jW2f7?=
 =?us-ascii?Q?B92E11ElyMrr9913O5MIaY8F2emIeGMDdyBSNiUPuvVghG/PNpUUWc6JB134?=
 =?us-ascii?Q?FrN705eOm5IYmCabKUSEwt3DOvRCWMpvCYtosqryzurrZ+c8WTQH5+HlZI6M?=
 =?us-ascii?Q?zp2qeVwIu4Nrm+H0z8sSoAnTyWAsKC7E++cuZsjZPvKh5+16itFvuYQ9akuA?=
 =?us-ascii?Q?YuxYYvH1H3KcDnWh1IkHJ1CkpwEqG75npkYkNtdKJSFmDWdnA7z2W43gv5pn?=
 =?us-ascii?Q?KYDVV3kgQhneYYYbQy/2asd8dAhjhEA4V//iKjN0fEvMdcjyMV+9qajIZcHA?=
 =?us-ascii?Q?oAxN2gVc4ej7EFBgQLdhwIPDPNV1nrOAwnrysaYI8ALF9w1R7WpmZjg60rKJ?=
 =?us-ascii?Q?RlPoyB0enMKEEQROUqUuqltlaUgQeOWxOK+3/HK73b0FtgZmclmUTLSr4h+b?=
 =?us-ascii?Q?4gMnVwOw4Xp7HCuhNZJ9BeARgH3ItqU/mPQx/jG6WeITNOTjjaB/bcAYGbK3?=
 =?us-ascii?Q?l181FTxIyuYkqGmUHEsOnnn7KKxuM4F4MTu4Cx5hIBT9iVJ3IPpjbhzGhZIP?=
 =?us-ascii?Q?rxG8fe7Ws6VIQQOHkGqgdEyc5VHJXLMh2rqsPri+3obtr84C1l644Vkd03nL?=
 =?us-ascii?Q?iqmqXAsvKAczER5vQBbElHuT0ZzzxIzr7rDlz4rFij8Cfzohfobf1DI1Mxp2?=
 =?us-ascii?Q?hwdZSpg7KFXuhtmJNMndMup0Y6EgnGozKy3cg7MziOk5Z5ugXVYdSNVU/Pj4?=
 =?us-ascii?Q?C8QTZlWVqvNuZCZ10jc4uWGHEnBdq1gGqXK5PIHMiWDP29/SppgUO5yR8o5I?=
 =?us-ascii?Q?kz+ShVy8GpVjaZl4Wbum9/2E0WHeo2L+DgpQNG+DsA4912JAnSm7Xbcn8DtY?=
 =?us-ascii?Q?K8VV/S5tm6pK4iI+N0fFV5KQiXkM4cjnEOj1y4gKT4TaZEiyPrOkYEkYp2M9?=
 =?us-ascii?Q?QdV9WF+TDhvd8F8Bm5x/TH+5xQjgqIoe34xAPWLU6mxgETEtOKm9DWwFd9ep?=
 =?us-ascii?Q?dNK0I/4gdFM1JvYNYNWOcM7+jw/ueUQ7wP8Jui6Qtw8dTbjTbi2im14xlhUh?=
 =?us-ascii?Q?nIa9i2WbICRXlvCV8Mri+Cb4/gX8Iv4oPjKngDifOCYo3Rfkenqmmuo7VWVP?=
 =?us-ascii?Q?speVl/RGnc6Pk1BlOz+Lw7TWU6mMa1K41GTALgYIBzbSmCj6bO/410W55yyC?=
 =?us-ascii?Q?GpoeW2yDl1e5XnCAmp9OqglApjCF471V07xmJmb7w1lwUgnLuzX5tZEdE4qM?=
 =?us-ascii?Q?NuP2hMPC+W1tgq7LxzangmYRetwjwfQ8ZVT1wLGAkpy4swPtgIkRSOBI0TVp?=
 =?us-ascii?Q?5gl7F0/hGvkzkSH9krTnkv8+4zSFso/oP/wAqolrVJ8nf/TNPU73pxZfOWU0?=
 =?us-ascii?Q?YNLNZNVHZdAfwBsA6jLkcxGIngwUcsdM7rR30gb0J7zZxTmVBHdqs3sTV2F0?=
 =?us-ascii?Q?j8AlW3x44hAkdOWA+WIVzgc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <778BED6BEC15714787C450B6CDA7FF04@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d07b579d-10af-4d61-4fe9-08da57f13131
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 03:57:45.0240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8KQw7kSfyKHS2b3IG3KaPb/RPiqLSdpifDdYs92u71zgY1s1SsRZ40WU/CWF0Dm7Scjxk+7niB6mWYOpdumOTvHc1fJ+IR6HlWgWPO1WCuA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6243
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Xiao, thanks for this action!

On Jun 26, 2022 / 22:24, Xiao Yang wrote:
> Split _have_kernel_option() into _have_kernel_config_file()
> and _check_kernel_option().
> 1) _have_kernel_config_file() will set SKIP_REASON when neither
>    /boot/config* nor /proc/config.gz is available.
> 2) _check_kernel_option() will not set SKIP_RESAON when the specified
>    kernel option is not defined.
>=20
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>

It's the better to keep _have_kernel_option() isn't it?  It will make this =
patch
smaller since many of existing _have_kernel_option() calls can be left as i=
s.
_have_kernel_option() can be rewritten to call _have_kernel_config_file() a=
nd
_check_kernel_option(). To distinguish usages of _have_kernel_option() and
_check_kernel_option(), short comments on those functions will be helpful.

--=20
Shin'ichiro Kawasaki=
