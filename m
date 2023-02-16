Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178E5C636CC
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 08:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbjBPITv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 03:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjBPITt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 03:19:49 -0500
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4725526CF2
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 00:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676535586; x=1708071586;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PdDjYMNWPKeOLtNVypAslBMz2vKcoPyVE4btuOlZW8o=;
  b=j0LZqkeeppaYB8CxlO4N3fnnvqJOYyi3maP3c4azkryOpnRXzdy7zWUj
   yrIXJXgK3aOwFY5VM04SVDcnSLqE8A03soeKbIPFMUzeI3sygduaA4Q91
   vVsGFKbldcVQKaFvEs93xz+0mKccVxmVbgCBa86IjCBANjVG9UlpYQDfT
   OKO710NIgtSuZWnf+MkMrrUVSMg3iwBiDNjvPevFGaAy49HgsLMASzvER
   NV3H6oS5Qez0AOoyNHNj9ykuDaYARjRxtR9W4FKX1MdhxZxZub5tGRkQj
   PHhOlH35b3L+1Hh8NVGldslPIkp/Izwe1PNFxAgQ1h9zgR/bagfpXN92N
   A==;
X-IronPort-AV: E=Sophos;i="5.97,301,1669046400"; 
   d="scan'208";a="221737314"
Received: from mail-dm6nam12lp2175.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.175])
  by ob1.hgst.iphmx.com with ESMTP; 16 Feb 2023 16:19:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcIaxAhLF8GhDcOVWYESURq8iTV03o8yI4IGe95Z5sqJEFemv9Kp+CUXmeAyOt0XYYywf78edxhxWdi6fSWlRaWjrF9dzz6UQhrIWtviaY7nQoo4ipNYbaLB5RSiMCeJqITzpoAFiFxDMUee/XTz0GJpkw1DQgQS/LelOnUVMSyLvGS6cjGapPkgg2Pp4m6f1aRoJVDtnSGcs4DVMzxmoak9M3m7cTjrrGA2v/fWmSpVnE4JB7PTDU0R7fHrA/OcO/+Vucmn5slo6cjzyoKJbO+6l93jgryiHawGnO7tvpUo+EBoevKARveem8Ex+41uFB/KDA94Yrk3bD3exZqzHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9xU1kTdbx6Yzm+l7XYvd9SM8H684OW6gg8gzf+qASU=;
 b=TD0frpAnKLXdeJQmKtS1la4Id+EsME9KozodGqnizDN4BSh+aF7LBvs+/MLeC9o+i1ia1qUEJF9bO6TH9vQtxntBf+8N7davPOyK49t56alx6zcUUwsR/aVw1+f5n16P8yOg477tUagIy6CLNlDcMVyhA1i8sTLVsP3v+18AqWYNnDc93s8qRsPpgE+YusxdxZuYaVWS11RLgHvO5SwqEDGENKgO7zJ6KNUH19eYChPpSvaOaOX9pSyWV9h0C+VApEuy39d3OY+wgPstweES1JfXkkMCo/T7yb0KxgiwiX70ei8T3gDh9XV/T2iVDBR3r4tMa9xHOxG+k8eiOknpzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9xU1kTdbx6Yzm+l7XYvd9SM8H684OW6gg8gzf+qASU=;
 b=E52Zr4AzKEW2vZ0200E99hlzwKSL9MsRHpLClbcwd2epiUM65LKgBOXoW7xM6Xe4tVfENOmXj+8Wtx5RgypityYWs2JODIAc8hKxxxbr8KOcgfkVvKqaQDe0GIhOSAy3YF8HDKGOk/Wh8Gtq917KFwsnxzP8iou27DDd6UHjFBs=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB8423.namprd04.prod.outlook.com (2603:10b6:a03:3d8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Thu, 16 Feb
 2023 08:19:39 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f2ed:2204:b02f:9bfa]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f2ed:2204:b02f:9bfa%5]) with mapi id 15.20.6086.026; Thu, 16 Feb 2023
 08:19:39 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH 1/2] blktests/src: add mini ublk source code
Thread-Topic: [PATCH 1/2] blktests/src: add mini ublk source code
Thread-Index: AQHZQbMmz/+Gl6q8Gk6d/h52HlK6E67RO2sA
Date:   Thu, 16 Feb 2023 08:19:39 +0000
Message-ID: <20230216081938.oyc6ys5zo3bayrqw@shindev>
References: <20230216030134.1368607-1-ming.lei@redhat.com>
 <20230216030134.1368607-2-ming.lei@redhat.com>
In-Reply-To: <20230216030134.1368607-2-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SJ0PR04MB8423:EE_
x-ms-office365-filtering-correlation-id: 79866295-a867-4fff-1e16-08db0ff68c46
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OuQ//8Wvao/eKhakBagmzfxV2yvavVwsJF7pJeOKE7jcoLyE35Do9KM8XKWZTHE27FoFEyceT9JfkaQb4p5+RyzXy6axRs8+0+IkGGQzCv9hNqXKTrpIKQBmIdvogvLfXFLz69XEWrDdH4Kp0/Xc4udyqty7CsbviI42J4J8eWEl2iRr8BKaxFJMNG12iaWo1B7wl6qwdM5e7tsNYFQFg7YEhHUH08C5g4Z5n2W6QTPeGGh+RmiHj4bEE1Zr8eayhxgbcRCeBWwTZIy+XaSIVnJ4Ig9d1TBNhhvpux5IAdhazNwqKKO+IHr9TyZEf30y+/RB4CCse1q5D+gkAzRIYiZNK1GNr26kUXOw5lfU4AKAUjTwsvmnIwoUvypECz9cvSl+wOg7//t06QVfVqDV93aZpn8W6/VSxD9V5Ty1ztug+o4/3epUwFqXcE4Nzw1A68Jovyu0mm+l9Ea4B7mv51y4R2K9izcHw5Mf0+lAFwtWwR6li9ICzm79V7ugdRdsBVrp9mufNJxLlaB8gDfq8GL6ISPfFiL6e8Bqw8I+feSfTmTffO71SdQshceGYjN7kBt3atA36+6593kpLnsh5005RHJ04a65uC+c7A8gCwLPtUCghnuhCcM+GEpJnVtjl35ua1PsMfME26QfRXEWNx9eW0Af+MxCZ+spb/VsY4iUJNh2GzJJQBmWG4SAaAXeBX4n0uqQAq84fnAp/BSM9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(376002)(39860400002)(396003)(346002)(366004)(136003)(451199018)(86362001)(33716001)(316002)(83380400001)(6512007)(26005)(6506007)(186003)(9686003)(1076003)(8936002)(2906002)(38100700002)(71200400001)(44832011)(5660300002)(6486002)(122000001)(478600001)(41300700001)(66476007)(64756008)(8676002)(91956017)(30864003)(66446008)(76116006)(66556008)(82960400001)(38070700005)(4326008)(6916009)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?iHTHr7V3mGp22pXwDb69SdXVTBwUgK+YINXEORRlCV9wjkbe2AXqKy/55t4a?=
 =?us-ascii?Q?Cfn2OnhYeZ7jQAueTQAjIKjTecOMixAmMqt6f5ru9mWIOjWxrfoNk4tFTEkV?=
 =?us-ascii?Q?NYt8Pp5LZdAzR2ECz6arBxRXoduXZDC0DvVtuAfl+IOb00ZfA4iqnQf+pNh+?=
 =?us-ascii?Q?GBYfN8okS1gSrJyfrrIj4nXO3jRmkPx2BF9lbvPSACB7LtEF7U5XUTiVHadc?=
 =?us-ascii?Q?Z6xduWBUgvqzsQytSQn6iRPik8jFZjZLuILF53WEzgVfzvNPjn80Batd1Wbi?=
 =?us-ascii?Q?Hh62bcKXN8N0edh4F7WAMIQSIkGzNRsXXJfPzrHQ3WmW4BLfutzHB+yVe+Nn?=
 =?us-ascii?Q?RvoTeAwrsvrEvf2NCbabAA5mhQkhaT56Z09JD5WhHJe57ZCuZjN18CVWfzRv?=
 =?us-ascii?Q?WclcMhtM1qkQEiyaql7ReEaJOORlife6VbH3ZMsDKHQRVPz/fG9vbWXqXq6M?=
 =?us-ascii?Q?iozg4UrkOjZWpUhXlobE6taHb64E0MtjlYQN+Y3zqVwDQqLD6uOMBjboqB7I?=
 =?us-ascii?Q?EsfVQnZbe8fa3Ku7NpExheUj8VVjKFuDh1T0HUPckJVn16RCErJMGyqzCig8?=
 =?us-ascii?Q?89bpwyo7Y25W8GOF9tS/0sjqy0NGQlQi2m2UwErwUVsyC8NhHUGVNdDmCw/S?=
 =?us-ascii?Q?cox21XoECbV+PphXDepycnAFZM68NEmqMP0XbiG7OVRZXnLCAIZ+KVhIhslC?=
 =?us-ascii?Q?9Ks7PNPdWqv4KRqSqTmKGUNX1F6p8D/QOdruFY0AOMTF0nRCbE5fJc1UKzg9?=
 =?us-ascii?Q?Wtwf9d2jTOxKpV542PBmawc84r6VRAGrdZJFSHticxsx26YoE6ooAO0HY42U?=
 =?us-ascii?Q?8T7bHa2iALTHa/BoWf4akccsP8peNUSlq9kZ3CVOProuyRlhbK+xPFCsDfSS?=
 =?us-ascii?Q?W23hFyPrDoXUUOB02YE4LSdT6ULWHTEBV7XRgjgUM7V7v0H16Pg5w3gWqKPT?=
 =?us-ascii?Q?A1iG5rDcCUiDAjD9BAEaN/af1OImHFVe/bO5pTsjsOiREPRnP/mNoeo/DvyE?=
 =?us-ascii?Q?Usz4yakJRtjyXIeWWrw/281MK4WABJKr2YPGivBw+zGT7nGjXrmVQfBzbT59?=
 =?us-ascii?Q?cYkcv4rviF8rI4skso3zO3z1OPR2nvHjHtEST+w0rd92e7nIlyDM6FawIWZn?=
 =?us-ascii?Q?ltoWP8qk+gcIa6Cqvla+5mN9hSqBjbWJUL/FLAUlD/lKdcMMswYOP3DVpJ+I?=
 =?us-ascii?Q?6a0JmQ25a6VjSax0a5JKKOEcYNGnRcYG3q0zv4EOjqV3RnyO+exPd8p4gPe5?=
 =?us-ascii?Q?xwlMn5ksG+kzlUBzRUDVMyydMQLr1jJSgT1XP35wM0e+RnidZZzc/NPPW9DQ?=
 =?us-ascii?Q?WWFfgqBkwgUBAtKiXKqudMO9eGtMVVLuWaewmDCXf44Xqz7t4mISHwJkUJv4?=
 =?us-ascii?Q?tg69MtQU9icGzw6zKGmI2AbpSZ8ZnHeiSdtxEEdPxhIBdTTDxINaaDuUCfUl?=
 =?us-ascii?Q?m7uagcY1Rev/ixpjGY1Pftaee4pzzjjl2WjjeiuqLH0NbBQqiMGJ+cRN5quv?=
 =?us-ascii?Q?hJhAB5Ed0pMD+ZU1gi8viwBzq1NLvsE6IVEJPmfQSfNRcgZGWFtheyBuOtSm?=
 =?us-ascii?Q?tvAred4W0xiDFL1SAAwEkLNIeCPVYWYUZagB/qsHnArCg8hfItW+cioWgY6P?=
 =?us-ascii?Q?LAE8onq/72KPDMW7RiDckeQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6A93E11714C0134B9AE01F37B536C4D3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: N7VBPCtS7ikYQHth+4juHfwpy28sSs5JIe5xOBI7vMzVwB51NymQzaF3UknbLtJiR12ajRdGfJlCJy3p80H/vHZM3C4EZD4zluRXGCf4Nsz2FKK0wXntlO87UVwwwArIIUdDtCJeqIldh3FX/GxefARdWRTv42wq31BZUT9AZ9WG3AFoaVhMV7tFegBAd2eP72V1IC0RcG9h6QKKPbz7Ehos5fmbfJz6bGvAWPZWne9N6wjVqKz+Ufl5ZVAJT+CMsfQPPjkCpxdRUt7Jnx10krhXwrziF/yDW7TtGk1/sHtQ+1uH57r9d/Le4uCJKaM1Ne8P/U6IjgAaXnjys0tbqyaNSuZC8f9pRElWJUdxbBa8a1AgBlV6cRsm9IobYiX1MD5+jNZvmWVTfzcKeZxSP6h8dngVTS/4GS29Ax7Jn3tVZ+S60bLW30hdb1jBnLvTjXy4T34fPSaqtmOYesVgBkfxA42LQg56XAXUPBEbNgKmQBaDkNb6khWJxawT+WhnevJVReetD6yA/2GLhq1vuAuBNAXJL5rWCYB941Dwt9WAONMtJ2gEFmYqBFZholpesxGtujVcGqPbE4RDAo0igQwkbTa9IUe7ZyM6LhFhL58PmWEMtVexk5dBwmAp0bxIaAvVj2np5NQLN/6RerG95fSyDu+acyiFMG5gefTs+VCk9TYTA+f0ia3TIkyuZ6PmuQ8VBGTkpKDrBFER8L2SYIa5XXWRunmWVUTGEq5zQmabMZ0kkFWKqJ7iiQoAujHaqzCUzD0lUy8X5RPUHLQHj/d2uJkYOT5JOljzKuoCOcP54nKwvfNzX+8ZTN48ITtk
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79866295-a867-4fff-1e16-08db0ff68c46
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2023 08:19:39.2678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1hY0m5ZlCD9Cw6GHPtdLxvaVbbK+gyKOiFKN8a3Vr35qH5u5pEsX9DyvM5809eVhUBnFrFhF53U9zTzo/9M1JgnzbEFZmaooyHNVVupCfEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB8423
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Ming, thanks for the patches. It sounds a good idea to extend blktests
coverage to ublk.

Regarding the commit title, I suggest this:

   src: add mini ublk source codes

The word "blktests" can be placed after the word "PATCH" as follows:

   [PATCH blktests] src: add mini ublk source codes

Please try --subject-prefix=3D"PATCH blktests" option for git format-patch.

On Feb 16, 2023 / 11:01, Ming Lei wrote:
> Prepare for adding ublk related test:
>=20
> 1) ublk delete is sync removal, this way is convenient to
>    blkg/queue/disk instance leak issue
>=20
> 2) mini ublk has two builtin target(null, loop), and loop IO is
> handled by io_uring, so we can use ublk to cover part of io_uring
> workloads
>=20
> 3) not like loop/nbd, ublk won't pre-allocate/add disk, and always
> add/delete disk dynamically, this way may cover disk plug & unplug
> tests
>=20
> 4) ublk specific test given people starts to use it, so better to
> let blktest cover ublk related tests
>=20
> Add mini ublk source for test purpose only, which is easy to use:
>=20
> ./miniublk add -t {null|loop} [-q nr_queues] [-d depth] [-n dev_id]
> 	 default: nr_queues=3D2(max 4), depth=3D128(max 128), dev_id=3D-1(auto a=
llocation)
> 	 -t loop -f backing_file
> 	 -t null
> ./miniublk del [-n dev_id] [--disk/-d disk_path ] -a
> 	 -a delete all devices, -n delete specified device
> ./miniublk list [-n dev_id] -a
> 	 -a list all devices, -n list specified device, default -a
>=20
> ublk depends on liburing 2.2, so allow to ignore ublk build failure
> in case of missing liburing, and we will check if ublk program exits
> inside test.
>=20
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  Makefile            |    2 +-
>  src/Makefile        |   13 +-
>  src/ublk/miniublk.c | 1385 +++++++++++++++++++++++++++++++++++++++++++
>  src/ublk/ublk_cmd.h |  278 +++++++++
>  4 files changed, 1674 insertions(+), 4 deletions(-)
>  create mode 100644 src/ublk/miniublk.c
>  create mode 100644 src/ublk/ublk_cmd.h
>=20
> diff --git a/Makefile b/Makefile
> index 5a04479..b9bbade 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2,7 +2,7 @@ prefix ?=3D /usr/local
>  dest =3D $(DESTDIR)$(prefix)/blktests
> =20
>  all:
> -	$(MAKE) -C src all
> +	$(MAKE) -i -C src all

This -i option to ignore errors is applied to all build targets, so it will=
 hide
errors. Instead os ignoring the error, how about checking the liburing vers=
ion
with pkg-config command? I roughly implemented it as the patch below on top=
 of
your patch. It looks working.

diff --git a/src/Makefile b/src/Makefile
index 9bb8da6..c600099 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -2,6 +2,11 @@ HAVE_C_HEADER =3D $(shell if echo "\#include <$(1)>" |		\
 		$(CC) -E - > /dev/null 2>&1; then echo "$(2)";	\
 		else echo "$(3)"; fi)
=20
+HAVE_PACKAGE_VER =3D $(shell if pkg-config --atleast-version=3D"$(2)" "$(1=
)"; \
+			then echo 1; else echo 0; fi)
+
+HAVE_LIBURING :=3D $(call HAVE_PACKAGE_VER,liburing,2.2)
+
 C_TARGETS :=3D \
 	loblksize \
 	loop_change_fd \
@@ -18,8 +23,11 @@ C_MINIUBLK :=3D ublk/miniublk
 CXX_TARGETS :=3D \
 	discontiguous-io
=20
+ifeq ($(HAVE_LIBURING), 1)
+TARGETS :=3D $(C_TARGETS) $(CXX_TARGETS) $(C_MINIUBLK)
+else
 TARGETS :=3D $(C_TARGETS) $(CXX_TARGETS)
-ALL_TARGETS :=3D $(TARGETS) $(C_MINIUBLK)
+endif
=20
 CONFIG_DEFS :=3D $(call HAVE_C_HEADER,linux/blkzoned.h,-DHAVE_LINUX_BLKZON=
ED_H)
=20
@@ -28,12 +36,12 @@ override CXXFLAGS :=3D -O2 -std=3Dc++11 -Wall -Wextra -=
Wshadow -Wno-sign-compare \
 		     -Werror $(CXXFLAGS) $(CONFIG_DEFS)
 MINIUBLK_FLAGS :=3D  -D_GNU_SOURCE -lpthread -luring -Iublk
=20
-all: $(ALL_TARGETS)
+all: $(TARGETS)
=20
 clean:
-	rm -f $(ALL_TARGETS)
+	rm -f $(TARGETS)
=20
-install: $(ALL_TARGETS)
+install: $(TARGETS)
 	install -m755 -d $(dest)
 	install $(TARGETS) $(dest)
=20


> =20
>  clean:
>  	$(MAKE) -C src clean
> diff --git a/src/Makefile b/src/Makefile
> index 3b587f6..83e8a62 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -13,23 +13,27 @@ C_TARGETS :=3D \
>  	sg/syzkaller1 \
>  	zbdioctl
> =20
> +C_MINIUBLK :=3D ublk/miniublk
> +
>  CXX_TARGETS :=3D \
>  	discontiguous-io
> =20
>  TARGETS :=3D $(C_TARGETS) $(CXX_TARGETS)
> +ALL_TARGETS :=3D $(TARGETS) $(C_MINIUBLK)
> =20
>  CONFIG_DEFS :=3D $(call HAVE_C_HEADER,linux/blkzoned.h,-DHAVE_LINUX_BLKZ=
ONED_H)
> =20
>  override CFLAGS   :=3D -O2 -Wall -Wshadow $(CFLAGS) $(CONFIG_DEFS)
>  override CXXFLAGS :=3D -O2 -std=3Dc++11 -Wall -Wextra -Wshadow -Wno-sign=
-compare \
>  		     -Werror $(CXXFLAGS) $(CONFIG_DEFS)
> +MINIUBLK_FLAGS :=3D  -D_GNU_SOURCE -lpthread -luring

In my envronemen, -Iublk was required also to avoid a build error.

> =20
> -all: $(TARGETS)
> +all: $(ALL_TARGETS)
> =20
>  clean:
> -	rm -f $(TARGETS)
> +	rm -f $(ALL_TARGETS)
> =20
> -install: $(TARGETS)
> +install: $(ALL_TARGETS)
>  	install -m755 -d $(dest)
>  	install $(TARGETS) $(dest)
> =20
> @@ -39,4 +43,7 @@ $(C_TARGETS): %: %.c
>  $(CXX_TARGETS): %: %.cpp
>  	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -o $@ $^
> =20
> +$(C_MINIUBLK): %: ublk/miniublk.c
> +	$(CC) $(CFLAGS) $(MINIUBLK_FLAGS) -o $@ ublk/miniublk.c
> +
>  .PHONY: all clean install
> diff --git a/src/ublk/miniublk.c b/src/ublk/miniublk.c
> new file mode 100644
> index 0000000..dc80246
> --- /dev/null
> +++ b/src/ublk/miniublk.c
> @@ -0,0 +1,1385 @@
> +// SPDX-License-Identifier: GPL-2.0+

Many of the blktests files have the license GPL-3.0+. GPL-2.0+ should be fi=
ne,
but is there reasoning to have GPL-2.0+?

> +// Copyright (C) 2023 Ming Lei
> +
> +/*
> + * io_uring based mini ublk implementation with null/loop target,
> + * for test purpose only.
> + *
> + * So please keep it simple & reliable.
> + */
[...]

> diff --git a/src/ublk/ublk_cmd.h b/src/ublk/ublk_cmd.h
> new file mode 100644
> index 0000000..f6238cc
> --- /dev/null
> +++ b/src/ublk/ublk_cmd.h
> @@ -0,0 +1,278 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */

This license is new to blktests. Do we need this license to this header fil=
e?
Ah, is this file copied from linux kernel source tree? If so, I would like =
to
avoid the copy and the duplication.

> +#ifndef USER_BLK_DRV_CMD_INC_H
> +#define USER_BLK_DRV_CMD_INC_H
> +
> +#include <linux/types.h>
> +
> +/* ublk server command definition */
> +
> +/*
> + * Admin commands, issued by ublk server, and handled by ublk driver.
> + */
> +#define	UBLK_CMD_GET_QUEUE_AFFINITY	0x01
> +#define	UBLK_CMD_GET_DEV_INFO	0x02
> +#define	UBLK_CMD_ADD_DEV		0x04
> +#define	UBLK_CMD_DEL_DEV		0x05
> +#define	UBLK_CMD_START_DEV	0x06
> +#define	UBLK_CMD_STOP_DEV	0x07
> +#define	UBLK_CMD_SET_PARAMS	0x08
> +#define	UBLK_CMD_GET_PARAMS	0x09
> +#define	UBLK_CMD_START_USER_RECOVERY	0x10
> +#define	UBLK_CMD_END_USER_RECOVERY	0x11
> +#define	UBLK_CMD_GET_DEV_INFO2		0x12
> +
> +/*
> + * IO commands, issued by ublk server, and handled by ublk driver.
> + *
> + * FETCH_REQ: issued via sqe(URING_CMD) beforehand for fetching IO reque=
st
> + *      from ublk driver, should be issued only when starting device. Af=
ter
> + *      the associated cqe is returned, request's tag can be retrieved v=
ia
> + *      cqe->userdata.
> + *
> + * COMMIT_AND_FETCH_REQ: issued via sqe(URING_CMD) after ublkserver hand=
led
> + *      this IO request, request's handling result is committed to ublk
> + *      driver, meantime FETCH_REQ is piggyback, and FETCH_REQ has to be
> + *      handled before completing io request.
> + *
> + * NEED_GET_DATA: only used for write requests to set io addr and copy d=
ata
> + *      When NEED_GET_DATA is set, ublksrv has to issue UBLK_IO_NEED_GET=
_DATA
> + *      command after ublk driver returns UBLK_IO_RES_NEED_GET_DATA.
> + *
> + *      It is only used if ublksrv set UBLK_F_NEED_GET_DATA flag
> + *      while starting a ublk device.
> + */
> +#define	UBLK_IO_FETCH_REQ		0x20
> +#define	UBLK_IO_COMMIT_AND_FETCH_REQ	0x21
> +#define	UBLK_IO_NEED_GET_DATA	0x22
> +
> +/* only ABORT means that no re-fetch */
> +#define UBLK_IO_RES_OK			0
> +#define UBLK_IO_RES_NEED_GET_DATA	1
> +#define UBLK_IO_RES_ABORT		(-ENODEV)
> +
> +#define UBLKSRV_CMD_BUF_OFFSET	0
> +#define UBLKSRV_IO_BUF_OFFSET	0x80000000
> +
> +/* tag bit is 12bit, so at most 4096 IOs for each queue */
> +#define UBLK_MAX_QUEUE_DEPTH	4096
> +
> +/*
> + * zero copy requires 4k block size, and can remap ublk driver's io
> + * request into ublksrv's vm space
> + */
> +#define UBLK_F_SUPPORT_ZERO_COPY	(1ULL << 0)
> +
> +/*
> + * Force to complete io cmd via io_uring_cmd_complete_in_task so that
> + * performance comparison is done easily with using task_work_add
> + */
> +#define UBLK_F_URING_CMD_COMP_IN_TASK	(1ULL << 1)
> +
> +/*
> + * User should issue io cmd again for write requests to
> + * set io buffer address and copy data from bio vectors
> + * to the userspace io buffer.
> + *
> + * In this mode, task_work is not used.
> + */
> +#define UBLK_F_NEED_GET_DATA (1UL << 2)
> +
> +#define UBLK_F_USER_RECOVERY	(1UL << 3)
> +
> +#define UBLK_F_USER_RECOVERY_REISSUE	(1UL << 4)
> +
> +/*
> + * Unprivileged user can create /dev/ublkcN and /dev/ublkbN.
> + *
> + * /dev/ublk-control needs to be available for unprivileged user, and it
> + * can be done via udev rule to make all control commands available to
> + * unprivileged user. Except for the command of UBLK_CMD_ADD_DEV, all
> + * other commands are only allowed for the owner of the specified device=
.
> + *
> + * When userspace sends UBLK_CMD_ADD_DEV, the device pair's owner_uid an=
d
> + * owner_gid are stored to ublksrv_ctrl_dev_info by kernel, so far only
> + * the current user's uid/gid is stored, that said owner of the created
> + * device is always the current user.
> + *
> + * We still need udev rule to apply OWNER/GROUP with the stored owner_ui=
d
> + * and owner_gid.
> + *
> + * Then ublk server can be run as unprivileged user, and /dev/ublkbN can
> + * be accessed and managed by its owner represented by owner_uid/owner_g=
id.
> + */
> +#define UBLK_F_UNPRIVILEGED_DEV	(1UL << 5)
> +
> +/* device state */
> +#define UBLK_S_DEV_DEAD	0
> +#define UBLK_S_DEV_LIVE	1
> +#define UBLK_S_DEV_QUIESCED	2
> +
> +/* shipped via sqe->cmd of io_uring command */
> +struct ublksrv_ctrl_cmd {
> +	/* sent to which device, must be valid */
> +	__u32	dev_id;
> +
> +	/* sent to which queue, must be -1 if the cmd isn't for queue */
> +	__u16	queue_id;
> +	/*
> +	 * cmd specific buffer, can be IN or OUT.
> +	 */
> +	__u16	len;
> +	__u64	addr;
> +
> +	/* inline data */
> +	__u64	data[1];
> +
> +	/*
> +	 * Used for UBLK_F_UNPRIVILEGED_DEV and UBLK_CMD_GET_DEV_INFO2
> +	 * only, include null char
> +	 */
> +	__u16	dev_path_len;
> +	__u16	pad;
> +	__u32	reserved;
> +};
> +
> +struct ublksrv_ctrl_dev_info {
> +	__u16	nr_hw_queues;
> +	__u16	queue_depth;
> +	__u16	state;
> +	__u16	pad0;
> +
> +	__u32	max_io_buf_bytes;
> +	__u32	dev_id;
> +
> +	__s32	ublksrv_pid;
> +	__u32	pad1;
> +
> +	__u64	flags;
> +
> +	/* For ublksrv internal use, invisible to ublk driver */
> +	__u64	ublksrv_flags;
> +
> +	__u32	owner_uid;	/* store by kernel */
> +	__u32	owner_gid;	/* store by kernel */
> +	__u64	reserved1;
> +	__u64   reserved2;
> +};
> +
> +#define		UBLK_IO_OP_READ		0
> +#define		UBLK_IO_OP_WRITE		1
> +#define		UBLK_IO_OP_FLUSH		2
> +#define		UBLK_IO_OP_DISCARD	3
> +#define		UBLK_IO_OP_WRITE_SAME	4
> +#define		UBLK_IO_OP_WRITE_ZEROES	5
> +
> +#define		UBLK_IO_F_FAILFAST_DEV		(1U << 8)
> +#define		UBLK_IO_F_FAILFAST_TRANSPORT	(1U << 9)
> +#define		UBLK_IO_F_FAILFAST_DRIVER	(1U << 10)
> +#define		UBLK_IO_F_META			(1U << 11)
> +#define		UBLK_IO_F_FUA			(1U << 13)
> +#define		UBLK_IO_F_NOUNMAP		(1U << 15)
> +#define		UBLK_IO_F_SWAP			(1U << 16)
> +
> +/*
> + * io cmd is described by this structure, and stored in share memory, in=
dexed
> + * by request tag.
> + *
> + * The data is stored by ublk driver, and read by ublksrv after one fetc=
h command
> + * returns.
> + */
> +struct ublksrv_io_desc {
> +	/* op: bit 0-7, flags: bit 8-31 */
> +	__u32		op_flags;
> +
> +	__u32		nr_sectors;
> +
> +	/* start sector for this io */
> +	__u64		start_sector;
> +
> +	/* buffer address in ublksrv daemon vm space, from ublk driver */
> +	__u64		addr;
> +};
> +
> +static inline __u8 ublksrv_get_op(const struct ublksrv_io_desc *iod)
> +{
> +	return iod->op_flags & 0xff;
> +}
> +
> +static inline __u32 ublksrv_get_flags(const struct ublksrv_io_desc *iod)
> +{
> +	return iod->op_flags >> 8;
> +}
> +
> +/* issued to ublk driver via /dev/ublkcN */
> +struct ublksrv_io_cmd {
> +	__u16	q_id;
> +
> +	/* for fetch/commit which result */
> +	__u16	tag;
> +
> +	/* io result, it is valid for COMMIT* command only */
> +	__s32	result;
> +
> +	/*
> +	 * userspace buffer address in ublksrv daemon process, valid for
> +	 * FETCH* command only
> +	 */
> +	__u64	addr;
> +};
> +
> +struct ublk_param_basic {
> +#define UBLK_ATTR_READ_ONLY            (1 << 0)
> +#define UBLK_ATTR_ROTATIONAL           (1 << 1)
> +#define UBLK_ATTR_VOLATILE_CACHE       (1 << 2)
> +#define UBLK_ATTR_FUA                  (1 << 3)
> +	__u32	attrs;
> +	__u8	logical_bs_shift;
> +	__u8	physical_bs_shift;
> +	__u8	io_opt_shift;
> +	__u8	io_min_shift;
> +
> +	__u32	max_sectors;
> +	__u32	chunk_sectors;
> +
> +	__u64   dev_sectors;
> +	__u64   virt_boundary_mask;
> +};
> +
> +struct ublk_param_discard {
> +	__u32	discard_alignment;
> +
> +	__u32	discard_granularity;
> +	__u32	max_discard_sectors;
> +
> +	__u32	max_write_zeroes_sectors;
> +	__u16	max_discard_segments;
> +	__u16	reserved0;
> +};
> +
> +/*
> + * read-only, can't set via UBLK_CMD_SET_PARAMS, disk_devt is available
> + * after device is started
> + */
> +struct ublk_param_devt {
> +	__u32   char_major;
> +	__u32   char_minor;
> +	__u32   disk_major;
> +	__u32   disk_minor;
> +};
> +
> +struct ublk_params {
> +	/*
> +	 * Total length of parameters, userspace has to set 'len' for both
> +	 * SET_PARAMS and GET_PARAMS command, and driver may update len
> +	 * if two sides use different version of 'ublk_params', same with
> +	 * 'types' fields.
> +	 */
> +	__u32	len;
> +#define UBLK_PARAM_TYPE_BASIC           (1 << 0)
> +#define UBLK_PARAM_TYPE_DISCARD         (1 << 1)
> +#define UBLK_PARAM_TYPE_DEVT            (1 << 2)
> +	__u32	types;			/* types of parameter included */
> +
> +	struct ublk_param_basic		basic;
> +	struct ublk_param_discard	discard;
> +	struct ublk_param_devt		devt;
> +};
> +
> +#endif
> --=20
> 2.31.1
>=20

--=20
Shin'ichiro Kawasaki=
