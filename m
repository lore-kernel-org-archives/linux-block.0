Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB42C433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Jul 2022 06:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiGUGfv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Jul 2022 02:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbiGUGfu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Jul 2022 02:35:50 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B04F3718F
        for <linux-block@vger.kernel.org>; Wed, 20 Jul 2022 23:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658385349; x=1689921349;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=brA6Q4JlDuFgQXbhQL0AI9wj6NH61CfpiiBuf6rFDvhWKcoMFrX2TMoO
   PiAtwqVCpUha730IzPOrF8KdLPg0PfWz0FCI2GO5kPLmWuyA0JBcgXDNj
   MEIyqtNc6LH0L9m4RGOo88qcPjoGjuodMqxiqMxRqnujVnzW+2dDy2NNB
   styDrcHEDn2wlW1Xey6lP8rdIySAfae0JFmC6bffTSGWcFOJloBwD20Sc
   jeIFDsuuvNFJFKPlWCzBIPksAnpRqdou4akZzhPFNDZ4DETs5tF60xAaC
   Rvf+9V1vSkth9qQrROp8gAitV3TmT2ik7LiYt+PLdJ7MlcxsrQNtw1zXZ
   A==;
X-IronPort-AV: E=Sophos;i="5.92,288,1650902400"; 
   d="scan'208";a="205096222"
Received: from mail-bn8nam11lp2168.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.168])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jul 2022 14:35:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VbOSY9IGjhS+9+AaX4G0whVyz1iKCy3qfiIlY4h60mIXIStrngaJuV+SQxXkQNCS6ecKbZicOEyTsjNRkGtH+oj33Vrp5U1H1G+BmW/CsZ3MTClZctQP6nFbVtukwjkXYi5Cv+Ndu8ZdRzN1E1ECiTeDYABhTbILGidgp8ECxEwlG4yldyQ80Lnqf1/A5NC/0JSa7makFtwo/fb3W6J4HMdcJx8Nv2osIpuVUyV0Li3Y5yHKsyvPlFLstg+3uZP4fBDdmoXTSQVgFsxultklXC9tFBDyMDKdEGth/jM47KdqLgWdp+p2SZfU6L0k2RRAooQZI1UQt/wbWjOyqyEdmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ZFjon2iLK4QyILVPhLiezSgKTb7l1ugSYXkQQbFz4CLRyeO2TK3gRRTQGWmTlg+rmVs+2PwubamSd4Kie02YXRfj801qmF4/HYETRH8XDlHm8w9lR9pGZfkqBLOO4IXOJtWEp0OiXR0RurQUO5DprZaxXnVXheQnxJ1t1+P/nCmLQeKTKI9wcgTlAfFwVevMQulklIhhNS+Zz6R8adH2gvt6FcAn97j6HbS4v8yMzvd9dr0sSGyahI71D9dIYo2MQ1rWXO7chxJqZFZ0eIPVrnAoYmdCbMgx7b3MN1XMyA+5d05Z39FnTF/8LVZA7AUEFFogpiVXqMHJsRxztJSrXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=l8UaYsotYWEEQrVHuDtfAwmkT2zjCbD4uUqvbmfxfmhAZTzHEUhAoBzhDb/gQ7eSypjez0sVrKUPsyzQi+J0yZI1HFgIhpVJnBJfM7KtVA7P4qY8J/aVqHQSm0TgO/VYd/Oo7QaY8nSB+uZobVmmotbYCI6hchi+GwFgoh8fA1s=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SN6PR04MB4878.namprd04.prod.outlook.com (2603:10b6:805:9f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.21; Thu, 21 Jul
 2022 06:35:44 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ccb9:68a4:d8c4:89f5%7]) with mapi id 15.20.5438.024; Thu, 21 Jul 2022
 06:35:44 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH] block: remove __blk_get_queue
Thread-Topic: [PATCH] block: remove __blk_get_queue
Thread-Index: AQHYnMv2j2Q3/PiKsUubcbtB/UZFOQ==
Date:   Thu, 21 Jul 2022 06:35:44 +0000
Message-ID: <PH0PR04MB741615B844D3E9C21C7B73C19B919@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220721063432.1714609-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a9623db-7f87-4b1a-6afa-08da6ae33d7a
x-ms-traffictypediagnostic: SN6PR04MB4878:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0JClqeyfUinpir2fWQQEbtc6PvOd7F7z1W1eeBKtNxRFlqX3b5OSkfvq6GdGxVgh2qSyiLsv+TWSXxc7nIuwYodZT3Rw+V2ayectuSufFFvcQxdn7NiVxQXp+GBUO2zfUsqHy/3vvNJMljVhxcSqkvdEg2ZlTujySfC9pCeYKviw9lHJCmNpwTT0OFlJxL87HOovbhcvelJIADB4ZhNUZyWW7Od9nEbamUUHnDIvjCHDrEndP3SjrVE4r4R5Y6eEq+YE4CMH8URE2/DlBthw9dplBrBNeH3zjxAyfUU78D2jeXihJAOGfe+YNMgUjRBZTEbDbvdFC3fKvHGclxCVABbBwL1REvCQG1LfS+9evpoQ/EZUG0u9p7k4wLjJRBGd7Yuc3YoaHE57X7dosos8JruQaAIrkvzoaQfk5NlELp4jrHGZDR3oRhTtRC90OVkY2j0ksTSpGqx/wEFHFX7qwDJkcb7wXMlZS46fJ3By/em9cN2s96H+fMbyHlpCJvjIMmdGxCqewxK+kZicKkjlFfKP/chzmBVGSUKb6N3Fw0UV495hN2JZxPbq/tHru2EZ0j8uRPJAyE61FlnBU8vqBCVBWlC7hN0xhS4p9596FeRtwlMW+9Mi07WwO++vVhEAZq5Cc6jGoLPb1rDwBynMimoYZeIwyyRRfgQUSsF5sEJZrOm0PLtmPBDT5A/y6bWFsaxGsQpMOIk+agnRnWJqORUVNteOchd0DVQ9t19RA8lRRljKXZjr3DVmiC7Ve2W9CK98EDGkf1LbjQ4/IhSXugGt7eYOpyGmAFujNiBdaA/AK90k4pxG7websA1wwJ08
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(122000001)(38070700005)(33656002)(86362001)(38100700002)(558084003)(82960400001)(478600001)(52536014)(8936002)(5660300002)(316002)(4326008)(110136005)(71200400001)(66556008)(66476007)(66446008)(64756008)(8676002)(66946007)(91956017)(76116006)(186003)(55016003)(7696005)(6506007)(2906002)(19618925003)(41300700001)(4270600006)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+iT7ZbeubuccUQTR9oKvCKsC4RFV7DQFo3QTNvqqU8SFub2mEI2KqgPxzj2h?=
 =?us-ascii?Q?VowacocWESK84OT4TSEcfm2oynTmo3UroY3F544+u8PoznPx/Xh699IFginU?=
 =?us-ascii?Q?V9vLd2SRI7KtF01CrS7+ZlyLWrsyuGgQpDgbsl1OsBhkLW03/8L9/TmXfIq8?=
 =?us-ascii?Q?BGO2Oj6HXVwdajONyIaCxyYgqik4vNr1GSx+RRVGRlM36cITM3soLLqzPf5T?=
 =?us-ascii?Q?S4lYAIToaQM6meY6muDiqkgjd+j+xhjpeD/klxJmRDyl1ESsXBWPTc5Yc9BC?=
 =?us-ascii?Q?O20AeV4U61h4vebmjKifK5JdgjdH+4r0coL4swOBuSdzGRXTBZ/2XCo51G/u?=
 =?us-ascii?Q?BkbPp0WzMXK+nCwiRmu1PalHcPEyCrJwZzQStdv0ON0G3GXqNwHNEyIXF+Aa?=
 =?us-ascii?Q?wf37FKBsZZqwwzNEqalNtDdpipmq47VKCgPmGpTOAHjJ9Ir+RkE5HAoWFr3A?=
 =?us-ascii?Q?gLUA6kGODddbl4J9a8GLeeHa3Dpk1lEFSLH0mSwhg82xqg4RWVX6ASg7+YAl?=
 =?us-ascii?Q?uXQgu82YKiShg8dzFrJ9sWuT2JtzJBkPb7r126XfXi5pkELueHXAPArbS24O?=
 =?us-ascii?Q?SR4sYvqWucjzpnf4bxS2qk4qQpRnTg+OVRq2fU7hFx8ENEiA2ET+4VUTEj/h?=
 =?us-ascii?Q?PWxgWFDvRroUd7v0x0AirF6vTYIrPstTYGWCo4f/o5uhE+9lhNe3BrJynx+Z?=
 =?us-ascii?Q?StSFHEzYvVfilixQX8nFoM495hnqCB9Z/s9XSKequO5oCNLl/shKGAujcfra?=
 =?us-ascii?Q?8fX03j9aQ7wiguPhxkxVPd0HUd7Yb/rBaJsSlSO56mdxENCfSkrP6oyO+yQG?=
 =?us-ascii?Q?lcOGT7Qf5bOVEX21yUOocNxNiMd8VSITwGe6OQC34pnVoBfVoscrhd7asqQr?=
 =?us-ascii?Q?U9mS4Nyg1eISeYluYE8vCjzEFP3Ij9qKD5JXHHquz3Stk2o1VU9V9q09/Yjp?=
 =?us-ascii?Q?sqQUNGnJOqRerJzLqyiLWXzCEPWBcKdLYs/I7Z5ij6MnpOc+HtVxdxZodfJQ?=
 =?us-ascii?Q?k6Fvhm0VIL6W67/P5aSy5XGTb2SdmaxOOelnp0EnJWisgykzZ8kVeKnfrtVf?=
 =?us-ascii?Q?mgWh1gFiIB15v3wz0S1Ee9FpRrkN6QqqpmiYoNAq+M3MdKpgRAR498eKN813?=
 =?us-ascii?Q?5ck47w2m+DvS5V6ws0yfq2OEeHEoDoXOHkl8SF2LIvw4uFGtU6BtdyB+5gep?=
 =?us-ascii?Q?JDn6Ed7sZF70M7N/uI6InEXgLuD34PcGBanxccto52jclZj/8V++HJ/+20Na?=
 =?us-ascii?Q?8NmjRS0rXokrRWmzKRmH9Cu6/789F6nXExUcaxIfmt2ZFxv+CIwTPMEBrRxs?=
 =?us-ascii?Q?8OmOwi/fG2G+viwplcn9EYtioolenzWZenC6cFTgRpcmqEEnmVDOKKKqCm/k?=
 =?us-ascii?Q?Nk/+Qvd+kCTgW4VJdOiep+1qbqjPXv7s3xBtE5XB2DOgG4iXVs5vLi7Nn92B?=
 =?us-ascii?Q?UbmXNSwu/26tNYLi/ah5MrkG/8RPbn7Z+XPiBXbUt881eSU9D5LVJV/d7SwC?=
 =?us-ascii?Q?TR4Q9ycgz03V+JS2pc10rJo7ZrCQiXTbUI0hfAo1RNdzHrDgZFigbeKUhxdx?=
 =?us-ascii?Q?li9ZcEGcOSap2MkrIi04QIUeaJz7yIuQXftcjZLX6ES0bvyQe4Noo5HvXvoj?=
 =?us-ascii?Q?Dedt9opQ6xmbLG6ZgcJ8d7DH+ok5KtR3Y8hpXxTG701VH2z0TzMIRw2dnDDn?=
 =?us-ascii?Q?6auvoD3MEvVbQeV3k+gk4uRmjfU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a9623db-7f87-4b1a-6afa-08da6ae33d7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jul 2022 06:35:44.7274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kFQW6SVsaaVsEubt1s3jEK0tR0pBVE1k41CZ5eGUAMKtQQ788mEoKIGO9zwMethht9p9X4hVS/jBIRbzVGu0/uRSazPYQU66kQCUAt8CGR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4878
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
