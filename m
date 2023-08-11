Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D0CC001B0
	for <linux-block@archiver.kernel.org>; Fri, 11 Aug 2023 02:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjHKCAs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Aug 2023 22:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbjHKCAs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Aug 2023 22:00:48 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31D02D5D
        for <linux-block@vger.kernel.org>; Thu, 10 Aug 2023 19:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1691719246; x=1723255246;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=ZJVGq20hyaUTtPKqzEQCGgI2TVPiSHyECDAsQbrfrMs=;
  b=iSCljUFHuMYSt5njL70ZHmdQqnVzGgekXn+6qQ5JEDbvbB2FaF7rt6vl
   RE0NCH4jChXPyCGv26bQgBFTS6ZilF8oFP2uCxZOnOF2/xGGgS5bm+6I2
   fYt/hOyPgTJqMbR8SueIhlB/KPBSDV2HaU7J8pLxfY0q8qV/J8rS/TBXy
   KaJuWZ3bLZaW9NehpjOlZBnRjoxMZUlZWARMnnARsJlHc5WLqAxHtYr32
   LFkKbJ6HSfSrjBZW2xyoCKC2SCvrw/y55l0+1DyT8Z1WDZCdLmqGw6fD6
   m2BBRWtGaJSWn/Lj4WPBLt6LPq4I0QBq54DDcpDZWLAzadiilswFEnLHe
   A==;
X-IronPort-AV: E=Sophos;i="6.01,164,1684771200"; 
   d="scan'208";a="239005797"
Received: from mail-bn7nam10lp2108.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.108])
  by ob1.hgst.iphmx.com with ESMTP; 11 Aug 2023 10:00:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9IFfNpllGicpyaTLdwxnWPCsSjD31ZxA/C3K7wbXi25DnXg8p1xqbtam4yOogOdraD87LOtHxTf2iVxl5A8frtrR4FKmfi3yLXOTHP7dQj7CFXEPYQLmrMAlAVsGcIXqbVwPaRxHXEvxRei6pC5CpyGQlxXtPSpYYOHTD6I2YIJZLhBgLMlnCBwAYPXzB/io7tJkiALOK+DLniLRiYWhhIxJiEERflWqw601LlMjql7glkuqDfi2KNeeETa3OH43f+n/NFoGjmB12wtZiNksXrZnoKGFkm30k5N/WSrRXOoOzXnW7raqchsvg2kpcDoyAefY1jC9+b1OdxwlEKQAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZJVGq20hyaUTtPKqzEQCGgI2TVPiSHyECDAsQbrfrMs=;
 b=nmytoSbFmzU6gODAL6bLYNj5Hh+H6oky7BW2Oure/YLAdxu+l4WCMxL+wbM3a2j8iYKRs7bEcvBm/sA+gtCS4GmyY6J00doE4YMAOCJDi2s31S8jaAVmtBdp8+jyOi+KgpT/qmH3dOBBCXnuzPAvatYqF9e9mpVOsHkSOrkwhaLh1uLG65QaaHWEoVjqn7MOpi6jNyZj9jKyT0DpIYOonQ2ZSsfF5rbdShIiU1kgjffTtHJSohMZfFpl7Kqpx8v41n0h+PtjktXVhtbQyAy8zWryYaivtlP80ovlTEzmAK8EoZZGP8YoBHvl85GI/mTF4XjnlixQpqqxk4x0Hh9QOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZJVGq20hyaUTtPKqzEQCGgI2TVPiSHyECDAsQbrfrMs=;
 b=DX6hI3y6x9FMoCzfQaj+TUoCfvlJRJeuIpSmFLheUAWrnI6VAleRUHJganBnyq0h1eFviId1Mn7Z/HoVnSILOzfEjYnNXAmelhc8KgtWGACrn0X5FSnmpmJzO/UYybgsswo79k0wFAN9kzbTCpmvj1jyZ8eTtRo9otmcB5GEGWI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SA1PR04MB8495.namprd04.prod.outlook.com (2603:10b6:806:33b::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.47; Fri, 11 Aug 2023 02:00:44 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 02:00:44 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] block/004: reset zones of TEST_DEV before fio
 operation
Thread-Topic: [PATCH blktests] block/004: reset zones of TEST_DEV before fio
 operation
Thread-Index: AQHZxs4J2EJyrcGDEkaJ62l4MkKe4a/kYamA
Date:   Fri, 11 Aug 2023 02:00:44 +0000
Message-ID: <6rsl2bz27ggfmcxbs2zucn334haokvyug3d67cxwzsqi7acffx@o5q4pddywlmq>
References: <20230804122007.2396170-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20230804122007.2396170-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SA1PR04MB8495:EE_
x-ms-office365-filtering-correlation-id: d296980b-a9f0-40ee-725c-08db9a0ec5e5
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iwZi52M2boDnV45NoT3YWPg/8iIac0ZX3/819d0h4Oi7FZhYhk5FWgUGP5o9OsECsPnGIoqrOAXputKyNksMJptjijwfhozgaaHSSNSJFx2yNOU82wtKzX+0zWNWcBMPuWUlivsVIdfqfTTpGTrz/9VS4BtV/YSrUhU3eNbArCoohyuBhor9DdX6SCyLliOgOTB9iOEulZgcwivEz1a0fdMhKMHqKoC3pzGDlI8kTfzg62nvs3AwhxcwFdYNv7N+f4zU9O/lsE3P7hfXZy3DyP8/KEoYxdVGzmTirWghAJQ+1BW+1+RgCAiSd0X7HcWCe/Hn2OHSU4ORy1+k5LAUN45vsWyLdm0oR/5T/f/h23uTNt97FOiSFrbCLVqHsj4ZpCkZJitBtBLLYDv4u5H0QJu3tPEZonDVGQc33es154VHns7ZU9na3A3SVHUtQtPd+d0ZCZ76gVaR2W4YFTA4IkOZWhOFXse6uVkJlCAs7zx+OquCQeEUVD6T28x3Flww/YE1hCcfn3ARR13Krv1nZGRNfleconlh5yTxHyE057NG23krhqj0a8m76r4qXWgZ9vT+FxXNWRkjMUTsir0pnK7gMpBsdWxUhsxm2gOJbA2Lh0ULl05tPBpe4wYgK6Fp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(366004)(396003)(136003)(346002)(39860400002)(376002)(451199021)(1800799006)(186006)(6506007)(6916009)(82960400001)(9686003)(6512007)(76116006)(86362001)(38100700002)(91956017)(122000001)(64756008)(478600001)(66446008)(66946007)(71200400001)(33716001)(66476007)(6486002)(316002)(66556008)(26005)(8936002)(38070700005)(41300700001)(4744005)(8676002)(44832011)(2906002)(83380400001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?V2H4NLyu9QfPB2L0VOsPde9gdgH2msZXBp/2yh6kEW9424Dd5Q+LLIh6MbXp?=
 =?us-ascii?Q?tLMFRHzwU++pEQecXk9FPhYTKS1Ut4jBF66Yb5v50W+W9mk0dwiQ0ZXu1dwP?=
 =?us-ascii?Q?oIB6TOcy9ir7BXWfm6ynlC9jhwNq77pAO50RCbtyFu901cATfxZEJZviJ/tq?=
 =?us-ascii?Q?z2J4ANgQsc0JuzthAO1bXN6SCmrHeFt+W1vVSG5eAIiPyEqzZG6oo2uZppFt?=
 =?us-ascii?Q?dTt6QFA5GOyvoHUQ0z9jOcvrEpsxETH362Hv8N7f+c4u9y9Wsx96R/4DvBB/?=
 =?us-ascii?Q?5Us3RdIiy+awL+mMRomgtlMI9nzm5arAc3LK8N82225cNgjrgOqyvIfdxFXR?=
 =?us-ascii?Q?tETxfIhzSvbEgXARlKkzRE0EwR1/z42o2yrnVNAvOS+8c/LdL01meyGkoLK5?=
 =?us-ascii?Q?TpaiuWXzdpJd22CXVXRwYLwpn0fo1gXEaKemZFfrAS00MhlhRvrxNpHdiQ1m?=
 =?us-ascii?Q?48WzhtwBwoKZ8OyTchzHgRIz9v+Nrw5v8pQ6t38ZaI+6wwKpEEQeddj43j95?=
 =?us-ascii?Q?wtn9n3BzqOmhcsWo4ewCytOe4svB1n0bS0KLxwm2X67E3h+b04RtTHS0aPZj?=
 =?us-ascii?Q?JN9gNpd3wcEvRjN2w/Q/L0IremrDL9cTpIxOTeMIhxhMGn3U8wu79bEAzDYf?=
 =?us-ascii?Q?cZVg+0jdHIj0uGWViMmmvGkTBcuHdi+ZSKWKzzOhEeFQ5Z57ZRrYw11jtW46?=
 =?us-ascii?Q?MGzel6ANRDVMNjwRJbZUWJy5Jmi/iBCPOd1LeO9Nm9K97831KnOLeptXUdg7?=
 =?us-ascii?Q?Zqa7nBWj/b9esYitYs+tPF7m8jUb3PGYMnfx6BJBIfUy1LdDggUPjXkjUbWe?=
 =?us-ascii?Q?ZvAItOROnRpWyodYQ3d1TA2wv/IukypNWoVvfFO+412BxB0mvHIWpWDmOGHx?=
 =?us-ascii?Q?zWx4tnjwDTCpb+K8Sgb6UKLly5ytvrlvPkz+L5qJPoTwpoyom8vwj4L+zF25?=
 =?us-ascii?Q?jbUq7L22q1WYvuJ/w3ebyZn1Ri14X34S6OvdW2YY50ulIaM0JH3y9jSNpFQF?=
 =?us-ascii?Q?7VEqhiv4bVreUe6lYWsE/51fhlQdyMnHKO4k6L4xo84cCvApeIqGRNzvqLQ8?=
 =?us-ascii?Q?y95zGIfxr3qdZxs3m506jV+XUE9hoxjak8Vx92h6HH+3sMxcBEKgKSU92Azt?=
 =?us-ascii?Q?VTIalUuzekH6e15C6dPh+iMcpsW4tYWzh0l23wEPrdBU7Rnh5Co0GwlKfj3d?=
 =?us-ascii?Q?0SdX5Na9IU08fABMsKPWLNhhbEIxeOSc4V5mKkzVF3739P+1Ez/CSeo27l/R?=
 =?us-ascii?Q?07yoLNjNT262fWvcynnQ5CV+f0QVzKXqo4BbNzEMGVtA9AVjsz02Hyqzglxa?=
 =?us-ascii?Q?j4iiAgPRfG77w7nXDMiNXm4oPWkK7ELKfha1e9wu6m4GIUxwLa+Rqh02pamv?=
 =?us-ascii?Q?Y1eu7vH88F69qdnQD0rLttAfMNysXvi43wJ83iwgJmpCi93YDbDug6/WRbKZ?=
 =?us-ascii?Q?l2CqUt68TzAFMrsawLcSJghZGLIkR7nuqkbd8sGr7Pi8y6Yl4GfejZ+F6yCf?=
 =?us-ascii?Q?aOzJ2JorPe49O/EbsR4zIFab+3xE5yK+87twiTZGtoAPksNikB8jr4zhm8cm?=
 =?us-ascii?Q?KFE9R/1ykXaYSl3cFHfAVAsc13BhvpO/HD01k8t2R3mQ9nCDi/40AKZrhLZk?=
 =?us-ascii?Q?fsEo6FbJEBhPp1cGkf0Aihc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0E72A541AA0B7C4EB89EB89C125AF320@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6WumTdMG/DLztvAzPVS/xpom64WsTpvjR3cl8ql5Eva8CgpMm53HHKxtGzVNXHXhlFjzCvxSkD4HiOyyQA11bzWTTACXyrLA2ldjx3DXRozU+VbHCh4lu0+gnOVjMw8s4vJCqca3PLx3mpc8DNOCpVgS7ggvCj0P+Ct4mp4VbODreNbHT94ovOGMdbljmyXaSDDnEXpA3m3UFOs6+U0EffoD2+Bhj/mTPf9ZJc/xFcOYt3qcu57wahldPAQurCPwLbQe0H3cO5SnFSxvmNoO5nCQjjifrThs1/IGN5Eise1ivtohF2cHuYb+XqC+166IjlOEknNoRcMY+0N6oTegwMisjG5F8A9iFSnKVdMQP/jJo994BcSjj8maKw2UJytE3lmOjGuz5RUp0DC5XkTCVpTuVCh/qxU54JZg9M9KrbesSXWkyNhk43Zd1DFbog1wi/t4AEOLR4LzRLmSy9jBumW9lpbeKjUqtwy4fHB8DM4NHXb/CTcpxJEF7zcbXqw28k73pxN+kRE/7m8oTGOqKGN09jlGEpdVBfhgODIwsY9Dbfjj96tA324H0oGoEkYaZEcrjiuaAjOhX3GO3c+AMy0Ws+bVwNYRerXeMGI+8dERCqogs7bDic5aCeYK/rGPbNtmw0Z0clnttsgoG+mNVUE2YhdxcvtQbDFUJE8C9W/S7nRGO0BGMGXRn+ZybiB35+YI5xG83aRWSlLeFee7u+yNSUx/0s3tbjyjT2Hcny4rsOMK6rvwajvgd/V6//JHSncd0LP+kNMtuu18oFrDmQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d296980b-a9f0-40ee-725c-08db9a0ec5e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2023 02:00:44.2895
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9V3LCkuPOgdFyY1PFM8zWhySWcpz2m8xjTcONCxJV/tCmt0x0J3YaYqT2foa9Ua/Y4h2bdGlC/vpZhWsh88ewNoEA5YOr6hxVCEI9v0ETy4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR04MB8495
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Aug 04, 2023 / 21:20, Shin'ichiro Kawasaki wrote:
> When test target is a zoned block device with max_active_zones limit
> larger than max_open_zones, fio write operation may fail depending on
> zone conditions. To avoid the failure, reset zones of the device before
> the fio run.

I've applied this fix.=
