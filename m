Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9244DC433ED
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 11:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68B616100C
	for <linux-block@archiver.kernel.org>; Mon, 12 Apr 2021 11:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238780AbhDLLyd (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:54:33 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:27267 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237792AbhDLLyc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Apr 2021 07:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618228455; x=1649764455;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=pExbfuA+Vyy1XkDuVpeXPgjhoDGChbNVIkyZXBHKLDg=;
  b=aXMDy9tNWZlATvjxDtX+qXixLdnUkE4tnsde9UQL9VFGhzzhOOzVkkLv
   7CHb+aQ1GGoK2m4cS8MvixEPSwbjHTBT9N34S43LdyBIZol5FSXny5R+Z
   S+o4wEs3BaIQUEHkYvxNkM1GUFMzpIfRzcNTLGSBWaU3HmUJmOgnZUNZu
   BkVUvopDeRyJfxhTUrmcklnH5v4epjrt22UFADLWcXrcNoua52ugQ9Cs4
   1vtSze41jVXWuvXpeKqdMBNMZdu2peC+hqc56eZFdrbO+rm8unFBjgYUq
   xqYsirkTaCy9UXd2nybHwgtskus1KOcpMuh0zGpO6+lNrDH91KIUFByJg
   g==;
IronPort-SDR: /NQhdt/OvCOp6u7Tul20/A+5L0BmxIIiygc2S6b8Dg2nSW3oZwbwNoX/hmW68fE/Idy2ELhYnt
 Yh4sa+Ht8ORuM23c6EYenqjB+ziHB/IVkU953vow1PXeSUh/tefytzc8wG9AX+uoTalyif6rFZ
 S/opTbo+0WA9gEit5FAoTgYgtJOp6K8WZdhwIzGnWiWGeeh6/Oa8bIVjnhDQ6b0k1eQWDA/HVg
 UmNDGuEvKJrhdNzg+0m+7PNSBCrxf7Exm09crP4fxyKbgpX4aYaZmJSMdrJ+eR9hPbUUlinQQS
 2Hc=
X-IronPort-AV: E=Sophos;i="5.82,216,1613404800"; 
   d="scan'208";a="165312965"
Received: from mail-co1nam11lp2177.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.177])
  by ob1.hgst.iphmx.com with ESMTP; 12 Apr 2021 19:53:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lX3bDM1tOHkzLGcOyicNDTsRQwtkSTLmtoqic+mufIrvvTDrKOSk1f3kMa54kBAlNO8sOeNI0ZJBQdmBxtPJLCY8CsEd0dycWetzn6/T6RPeWDuJZ0wL1wTznmT8CvXM772IrbSsuh5ZH67TA1Y1T1i2URRpwuugDUVcgOO9ET7SeTFZJLd62G3s4+nhlO0NmnUzpIUQScdeI3g03JkWEb/sNHE6hKPcEhipt/2G1pftnpS4gx/lJKmXKeFr/gEki3QTVm67KFhrD+rrEZFTPDY95yGfEIh5gZg5Tp90R80MRtU5SCW8T/iV64e5Svb41+fqyeupSvTbD+Z7UYFYng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m79kraJvt0RqqjzmsUG3ZiFI6AEC4WqYQjlm+YZ9YMk=;
 b=clfUK09rBRmnKAjG1264U5nmHVO/DlVuMMQNvZhsZ+qXWTS5raw9sh85ZByOFaFskV8ym/whmZluabLPl8uIHP6pBFl0F49XIFerJGMgapA1Wjs3w2B4mXZW24TnTdaSTVlv1NZy3Ri54YuJJ5ieAdQ4h4CxUIN5r0GYhfFMy8RTnt7Z9QTMPVDzvdfnRMND8GcMLzm08pdWCRTRRs/u3jvQ53EU6EttnnKGiyUzLlLiHZ//JgExRGRF5ZmiEZ/1pOXqofyF3RSzg44/jNNfdvGdF0swDMz193H8RYH/+fIf5UMDu2C9rdW6tLPv2WdWtLSnU6BulbcuNcr6ZVjl1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m79kraJvt0RqqjzmsUG3ZiFI6AEC4WqYQjlm+YZ9YMk=;
 b=AwOtdjVocRPAVROs02btLRVQPxYBx3FeTSB8h+y8fwucS/JJJvqSxHDBNvzIlvgIz5S1Qtcv340OGjJcniIwpCj7f5ZCiXKeNSBhw3SYdq3xH30J5krqV27nMzXE/vGavM3G03e/PZQq+GFmPhANrLUqfnEQroVJIHJHWfKPdHE=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6733.namprd04.prod.outlook.com (2603:10b6:208:1e0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Mon, 12 Apr
 2021 11:53:45 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78%3]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 11:53:45 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "oren@nvidia.com" <oren@nvidia.com>,
        "idanb@nvidia.com" <idanb@nvidia.com>,
        "yossike@nvidia.com" <yossike@nvidia.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH v2 1/1] null_blk: add option for managing virtual boundary
Thread-Topic: [PATCH v2 1/1] null_blk: add option for managing virtual
 boundary
Thread-Index: AQHXL4IHFAxkXYtHCkCk1nHAVaPlYQ==
Date:   Mon, 12 Apr 2021 11:53:44 +0000
Message-ID: <BL0PR04MB651478ACAD2BAD942E82DF01E7709@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210412095523.278632-1-mgurtovoy@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:1134:9421:2151:4ee3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e3df61d-8e8a-4ce9-b655-08d8fda9a02b
x-ms-traffictypediagnostic: MN2PR04MB6733:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB67331C1377ABABE2BD0F2D7DE7709@MN2PR04MB6733.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LGW/HdAG8jqcgNQda7OVnLsg/nun/WKXYiC+wWA17P1IziF2vxIdLcjDpEWOuDJoVhvwWhl5AVfaC2HPnOVgVYzVyuSbqyLVt+JSG1eITUaL/wVsOWKV1wQQL8c0Z8PG6mO8LqurxaJl5oWHh2jVdHM2frvRovq1+YuHzUx0zgP4ZoYFHK1O5SgGq1Cz2EPRgpRW2Taydh9Y1uul2UGrDSUYPZ7w4/3yDl9tkhsI0/mX5StQ4PZTOD90Np7dA4kIojqu/gbI+6H2ugjwuKwc9JlmKEXO2CJUM1WPMMU1uy3BvsAS+uQSYEClNPxxXxXHtOW1upu6AmbgoWKK3FeS0GVJBgpwYreBO7mcqJERbzUqzG0J5BlISJlTZrLSYCZW5IhfuSPRomPLcZauzP9AGIFyESCFhW/9Zb3WMMTJnsbNLP5VaotympbDj0Eojz1yMefom5LxF+TO5MpRMDtSJUBOBqEu+iCl6pdNi4KQccLRy8yyYpbFjhIRBpbE22+Nq8I/Oy8OvCS2u+C0QngreMgUUyQ7gyiPD3in9zevW16IWTVvLstdqSb6j5Nn1vK/tMmLC7j9DANO9CeeWmSXvgEcUfZ+c7FGAdHW1cpAnjM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(136003)(366004)(346002)(39860400002)(2906002)(38100700002)(83380400001)(8676002)(186003)(66446008)(33656002)(66556008)(55016002)(66946007)(66476007)(64756008)(4326008)(52536014)(7696005)(9686003)(5660300002)(76116006)(110136005)(54906003)(91956017)(71200400001)(86362001)(8936002)(478600001)(316002)(6506007)(53546011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?6T3G3vZIUA+Smn57MOvnqxT+AqGSZeRD+IngpxF4PZEGkkrN4bi/WsYHTVtM?=
 =?us-ascii?Q?/dTHFP5mu8ALS4Lt1DzANe4LJsLoavTJnkeIuJncCwOtm2Jt8mGOfhOWmL74?=
 =?us-ascii?Q?NUDip6CKbaZJ7HC/44cOX+52i4OD1tAHSmqHSwPGkG+iQbtUmPT0qrH23Jwf?=
 =?us-ascii?Q?cDr9QRxu8Rf5dkwJhRQf6WFkrMZh6ghxys1aE9b7338QvhgP8jMhSflS1Zt/?=
 =?us-ascii?Q?VP2a3W4BRXlS0BibopzXVaM6dfnhRar7mwoCMu8yOyZ8LXDtls7tgYARQngE?=
 =?us-ascii?Q?E844FoC2YRL/77YSEkvkOdyB0xneDO6Up6rws3ec4WzyoZR/6w+XXLoaETwC?=
 =?us-ascii?Q?K0dD0BmjlOxGuiGCBdb1xuqdYYJOrufGyaL7WsoGv6SWkXidiFRMmS2eahF5?=
 =?us-ascii?Q?MqhBAsoGs7ZzgaNIjRl4hrBXiA6gxaYzCR+D61CNS+X8ad9eMVVeHuDn0Lnv?=
 =?us-ascii?Q?XlGG6mJLO0XnuqfPEhTyWq2HgfJeDJi42EOKx/KsCDr1qNRSyr7jsSCNaw+J?=
 =?us-ascii?Q?59I5/fqGItWSzEw50AXqYaYaewB1nPA6XuN9IDBmPT7nGbOBCsEy3N57rimI?=
 =?us-ascii?Q?HOjW1Z4N0AOvCSXhYNpH6bKGEBBJyItuB7ScMRJsgrd7tAHaEnMAXbIc2WZw?=
 =?us-ascii?Q?NNZxOTrUZUWw5aN6YClajeZSJFBoL0fAEq5kar9fUZ4bzylyJmduPELH7pLa?=
 =?us-ascii?Q?jMJryAHBODM+qQY2UDLS2O13Ad6Eui+eFk3Anj4UqQOVJdTFyQlhWUOWO7mD?=
 =?us-ascii?Q?ULcINLdewWaIxLQP9PASMupNSF11o0JwKo1u8bpWIIUe55i8XLDQDLPl2Rv0?=
 =?us-ascii?Q?3NqQF2tJKRndZxatXeS6vemqwEJSi984SFxGhrhNlPcCEfzEwmcOr7zbEQh3?=
 =?us-ascii?Q?0Z/6vWl1X/DJPRa+76jUjIE81WeZHaKIZPQRE08qJdWqxndcJzwoUkImc6Je?=
 =?us-ascii?Q?1ZnuWdg2pY9syoKad+gyIA980JSOVbqI6hGECCZGFHigIc88wt5eHWHoDVjK?=
 =?us-ascii?Q?eQl+dUxmQLcHsduF3lrt8048bPyzx3qhkN18mpQ1jX2w8i7vXV8xzapGMG47?=
 =?us-ascii?Q?Zlywvg7gsGf0msYWEoNJNN0PKNGwEvoWT6lzzvHINAbltArd8dwOsSGlMcfV?=
 =?us-ascii?Q?g1QZYtcoB1ZfE2EY5e6MAxBgrq9VA4mjxaywtUQGcor1nCPt+I8JPfMiUlr3?=
 =?us-ascii?Q?IJDBqUlnXcpfTJfqgi8UTkeUsmsetpPI4y69pDQtxX5TriQf8cH5KCzMl3FQ?=
 =?us-ascii?Q?pPh7w1ftXXbNrU6k7ujJC3dpsWXhr5RSb9R1L/6XkFhr3swqYfNKS8K0+h39?=
 =?us-ascii?Q?YmM0omIEi2Nr4WbMQTXwOxM6Clw8wQ7yftu5yePgbEM63o52pkkTsG5HqejX?=
 =?us-ascii?Q?ZgBpziAzQZSzh6o8Xaf2LkxNcdehuKAzzNx4Rx84ISzTOkd9Mw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e3df61d-8e8a-4ce9-b655-08d8fda9a02b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2021 11:53:44.9981
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4bH8vTSBQG/py+Rpua07m91SPGOHE50ApRU/FAXXSYdbo2OWjAgXShR/J0xplcuPtCupKs92vRQB6q+RCm7XXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6733
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021/04/12 18:55, Max Gurtovoy wrote:=0A=
> This will enable changing the virtual boundary of null blk devices. For=
=0A=
> now, null blk devices didn't have any restriction on the scatter/gather=
=0A=
> elements received from the block layer. Add a module parameter and a=0A=
> configfs option that will control the virtual boundary. This will=0A=
> enable testing the efficiency of the block layer bounce buffer in case=0A=
> a suitable application will send discontiguous IO to the given device.=0A=
> =0A=
> Initial testing with patched FIO showed the following results (64 jobs,=
=0A=
> 128 iodepth, 1 nullb device):=0A=
> IO size      READ (virt=3Dfalse)   READ (virt=3Dtrue)   Write (virt=3Dfal=
se)  Write (virt=3Dtrue)=0A=
> ----------  ------------------- -----------------  ------------------- --=
-----------------=0A=
>  1k            10.7M                8482k               10.8M            =
  8471k=0A=
>  2k            10.4M                8266k               10.4M            =
  8271k=0A=
>  4k            10.4M                8274k               10.3M            =
  8226k=0A=
>  8k            10.2M                8131k               9800k            =
  7933k=0A=
>  16k           9567k                7764k               8081k            =
  6828k=0A=
>  32k           8865k                7309k               5570k            =
  5153k=0A=
>  64k           7695k                6586k               2682k            =
  2617k=0A=
>  128k          5346k                5489k               1320k            =
  1296k=0A=
> =0A=
> Signed-off-by: Max Gurtovoy <mgurtovoy@nvidia.com>=0A=
> ---=0A=
> =0A=
> changes from v1:=0A=
>  - added configfs option (Chaitanya and Damien)=0A=
>  - added virt_boundary to feature list=0A=
> =0A=
> ---=0A=
>  drivers/block/null_blk/main.c     | 12 +++++++++++-=0A=
>  drivers/block/null_blk/null_blk.h |  1 +=0A=
>  2 files changed, 12 insertions(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.=
c=0A=
> index d6c821d48090..c35872cc5f37 100644=0A=
> --- a/drivers/block/null_blk/main.c=0A=
> +++ b/drivers/block/null_blk/main.c=0A=
> @@ -84,6 +84,10 @@ enum {=0A=
>  	NULL_Q_MQ		=3D 2,=0A=
>  };=0A=
>  =0A=
> +static bool g_virt_boundary =3D false;=0A=
> +module_param_named(virt_boundary, g_virt_boundary, bool, 0444);=0A=
> +MODULE_PARM_DESC(virt_boundary, "Require a virtual boundary for the devi=
ce. Default: False");=0A=
> +=0A=
>  static int g_no_sched;=0A=
>  module_param_named(no_sched, g_no_sched, int, 0444);=0A=
>  MODULE_PARM_DESC(no_sched, "No io scheduler");=0A=
> @@ -366,6 +370,7 @@ NULLB_DEVICE_ATTR(zone_capacity, ulong, NULL);=0A=
>  NULLB_DEVICE_ATTR(zone_nr_conv, uint, NULL);=0A=
>  NULLB_DEVICE_ATTR(zone_max_open, uint, NULL);=0A=
>  NULLB_DEVICE_ATTR(zone_max_active, uint, NULL);=0A=
> +NULLB_DEVICE_ATTR(virt_boundary, bool, NULL);=0A=
>  =0A=
>  static ssize_t nullb_device_power_show(struct config_item *item, char *p=
age)=0A=
>  {=0A=
> @@ -486,6 +491,7 @@ static struct configfs_attribute *nullb_device_attrs[=
] =3D {=0A=
>  	&nullb_device_attr_zone_nr_conv,=0A=
>  	&nullb_device_attr_zone_max_open,=0A=
>  	&nullb_device_attr_zone_max_active,=0A=
> +	&nullb_device_attr_virt_boundary,=0A=
>  	NULL,=0A=
>  };=0A=
>  =0A=
> @@ -539,7 +545,7 @@ nullb_group_drop_item(struct config_group *group, str=
uct config_item *item)=0A=
>  static ssize_t memb_group_features_show(struct config_item *item, char *=
page)=0A=
>  {=0A=
>  	return snprintf(page, PAGE_SIZE,=0A=
> -			"memory_backed,discard,bandwidth,cache,badblocks,zoned,zone_size,zone=
_capacity,zone_nr_conv,zone_max_open,zone_max_active,blocksize,max_sectors\=
n");=0A=
> +			"memory_backed,discard,bandwidth,cache,badblocks,zoned,zone_size,zone=
_capacity,zone_nr_conv,zone_max_open,zone_max_active,blocksize,max_sectors,=
virt_boundary\n");=0A=
>  }=0A=
>  =0A=
>  CONFIGFS_ATTR_RO(memb_group_, features);=0A=
> @@ -605,6 +611,7 @@ static struct nullb_device *null_alloc_dev(void)=0A=
>  	dev->zone_nr_conv =3D g_zone_nr_conv;=0A=
>  	dev->zone_max_open =3D g_zone_max_open;=0A=
>  	dev->zone_max_active =3D g_zone_max_active;=0A=
> +	dev->virt_boundary =3D g_virt_boundary;=0A=
>  	return dev;=0A=
>  }=0A=
>  =0A=
> @@ -1880,6 +1887,9 @@ static int null_add_dev(struct nullb_device *dev)=
=0A=
>  				 BLK_DEF_MAX_SECTORS);=0A=
>  	blk_queue_max_hw_sectors(nullb->q, dev->max_sectors);=0A=
>  =0A=
> +	if (dev->virt_boundary)=0A=
> +		blk_queue_virt_boundary(nullb->q, PAGE_SIZE - 1);=0A=
> +=0A=
>  	null_config_discard(nullb);=0A=
>  =0A=
>  	sprintf(nullb->disk_name, "nullb%d", nullb->index);=0A=
> diff --git a/drivers/block/null_blk/null_blk.h b/drivers/block/null_blk/n=
ull_blk.h=0A=
> index 83504f3cc9d6..5ad5087ebe39 100644=0A=
> --- a/drivers/block/null_blk/null_blk.h=0A=
> +++ b/drivers/block/null_blk/null_blk.h=0A=
> @@ -96,6 +96,7 @@ struct nullb_device {=0A=
>  	bool memory_backed; /* if data is stored in memory */=0A=
>  	bool discard; /* if support discard */=0A=
>  	bool zoned; /* if device is zoned */=0A=
> +	bool virt_boundary; /* virtual boundary on/off for the device */=0A=
>  };=0A=
>  =0A=
>  struct nullb {=0A=
> =0A=
=0A=
Looks good to me.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
