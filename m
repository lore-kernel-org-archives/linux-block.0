Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22F7BC04A95
	for <linux-block@archiver.kernel.org>; Thu, 29 Sep 2022 08:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbiI2IfD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 29 Sep 2022 04:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235552AbiI2IfB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 29 Sep 2022 04:35:01 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162AB201BB
        for <linux-block@vger.kernel.org>; Thu, 29 Sep 2022 01:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1664440498; x=1695976498;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=VJ2whY4Z/1LTa4LZWaRK0VfwNn0VD3yK04mnSredSR4=;
  b=h/1m4/2iW5Yt/reJZB+N0G40A/Ss+jo9RPLxzzstXlLLAv8gOhoc5HFs
   NrGabwn3KyKexjLRpiAYCmQsXpjhcjF6bFM3+LCbjmzrCT/lQXPnD79sN
   t2PEXwvlkBUfCF/p6CVS14UWdKo/UcTNsIEQPhj8WeEbtrBo+LooeuW/X
   TWmyXxz2G2NUwep5W5faKDSbSK1fb6sIGSDFfLMqFXfGOTodJIkY1yEgV
   fIszUP+thVROtBYzD0ZcjDmbdtAz2KSAZidbn5VNuKNyNBk9GLuaOWBzn
   zXzmW8XcyJ4AuiTRyQ9zd4ZyvWL1SKvor0BuGLEpbuvbY2w3OZtFr3YOy
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,354,1654531200"; 
   d="scan'208";a="324665400"
Received: from mail-bn8nam04lp2041.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.41])
  by ob1.hgst.iphmx.com with ESMTP; 29 Sep 2022 16:34:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9IwzlRMSDAUSGTnw4lUX3uQaD/pj4dAmS0BEJL0jeNQSsXT1qtaHuzrlTAEuGBbbjGEUcTakEPllCL2JvE27J8AjRw57Av4xq7u5dWg65nJuBSUNf1Uzy2SqBpcDILxTmnAiI24oPZU/5BN3+h3hNn02x5jMTkg5a97bXxoP+f6LhD7dwt7XrQqB3ZxlUquxIME0PucKdzR0A3joq04RwgdR7KqlM78YA+UGFhoBoBaRVt8ciwLQP+XPrppSE1jI9dKVx+rNz50HEfnKaall/Sp9mS41Gd4ZZ50kwfV6dIrquzA0ndbiotcuR3ukUt7AqUiWqe1T9PVKP75G35ATA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5QEGfHUwhDQhbbPsuJkaFg3yrNSa4KrFx0hUBWlCWe0=;
 b=YEcQbKMqCibew2gGAMSaN+8O46i+IgfQTZFVLYIRa3ehctnTSoYjxvQXgJhgducD39Goo7yJ9X68mN3GgoediM3LQNnDqrAVzIShTllO1wlWW8ubIXuWed8zsVd2e6+D11FePLtYMyhWz8AC1OfwDVBRwG9ja0Xo+Eb1YeJJnGGDl7EWd+BuIGMNubUhhFQ6iSyrLKW7L8AiDs74HoXXokBuZBWB0t7JSRwGRLSmjAATiMwJZVKFp122gS7l7y1aepep1f8ZYq0+/q95YXifgLW9Uc7tJBT4cc18Hneu4ssFo4ZGw95AZhYHazgvSs7ZWXQoqAknz+5NHlEWDCcR7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5QEGfHUwhDQhbbPsuJkaFg3yrNSa4KrFx0hUBWlCWe0=;
 b=Qas0yfJFHPvR2bN4M3qOvJoYG9vC5vSJlGe79yWpLFMzjjwTtsEf93X8Vu4soHcU+FEro+X5n5b7yE7fUaV3vV99TeqxkzZeyYE+ua5n5zzCbBwETg/t1MVi0gP8AO2ZqFxKIwKNFaHmJ+wJ4kDcSMb+fELVABJy7bXoOvcHMcw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB6099.namprd04.prod.outlook.com (2603:10b6:408:55::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.20; Thu, 29 Sep
 2022 08:34:51 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%8]) with mapi id 15.20.5676.020; Thu, 29 Sep 2022
 08:34:51 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Pankaj Raghav <p.raghav@samsung.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>
CC:     "gost.dev@samsung.com" <gost.dev@samsung.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "damien.lemoal@opensource.wdc.com" <damien.lemoal@opensource.wdc.com>
Subject: Re: [PATCH v3 1/2] block: adapt blk_mq_plug() to not plug for writes
 that require a zone lock
Thread-Topic: [PATCH v3 1/2] block: adapt blk_mq_plug() to not plug for writes
 that require a zone lock
Thread-Index: AQHY09fwLEIVTIq9r0qLGq6mvIvdAQ==
Date:   Thu, 29 Sep 2022 08:34:51 +0000
Message-ID: <PH0PR04MB74163ABB55235F755C0A5BE69B579@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220929074745.103073-1-p.raghav@samsung.com>
 <CGME20220929074748eucas1p1145790d433b4f57cc9e9238df480091b@eucas1p1.samsung.com>
 <20220929074745.103073-2-p.raghav@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN8PR04MB6099:EE_
x-ms-office365-filtering-correlation-id: d1116d65-3a9d-4458-7bcb-08daa1f57a30
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: us4V09ddq0OV9NteAi+VkCdPz2RW2Qvvofy6M+YKyhYVszj0TF+vRyjcOH5GFhn7XNQJCMode7M7XUadoRCp710BOjwEu9yqFopDRbvcVf86LQFSyoIMTpoMlyngAtYsoFlW9gEATSxrNZJEB0Y4xmQcoBfSg0g3DvLy1GVPX6WAeKz0n4JMn34TsyxIGFonAmkCWs1Sdz1OpYnDvKBGVWosHf4vyTA+ppwXX1OQa7tpf368HPPqzZATWJzhlA2sUgMbZae748KBJUtr0V2PVawplA+XY0GJFTFaGKBAc4IADCPIgw1HBHW/VPriSojZgrptwR6tRnuZwK1ZQhQGcT4pfrYW4Yh3Fk5Wq6oJKVXjX93xFtps9ZPDGKb2VsmIkg/er9vfYw8uf0SbXY1EUiMSRci14z0yaaGBakB1GO0fP2NG23Xpr/VgLQXPtIo1FbzkVjKbBvJJNJAA1Q5RjMbL87IQg8UwKThIepZ9ELv5iV/ZXj25pRdrGq+po1emmttFC4OHlaU7LU+0yzQiojHGQmgpzCNx6SFqCvkbuhhv5m3AdeimCGuiSc40GT1qaTG8S8t9rcwlheO72hL4ZMNkfhHs22Z9bwm29euvZKEIQYm+KV+K4b+XPePPRo9boR57SpcoUo4JY0j2vA2U9MLMWUpedc4117742TC0uPzUEUsye2eWRWgLKj+7h/g84G6jdfacBZ0QBOyqii5ARekRJRtgZGxJ6rlSX+g+44vC8EXO9blMBQb5NT/5/+fu7FxOt2OURkiOl9mTt/cFKg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199015)(54906003)(110136005)(316002)(71200400001)(478600001)(91956017)(76116006)(41300700001)(33656002)(82960400001)(186003)(55016003)(66476007)(66556008)(66446008)(86362001)(66946007)(64756008)(4326008)(8676002)(38070700005)(2906002)(8936002)(6506007)(7696005)(52536014)(4744005)(9686003)(122000001)(53546011)(38100700002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jKo7nryRO7OmT+9U58R/x5gaOWcMCmZjJ4tKRRUcC8j1Sv0YKBhwC1AQQLl5?=
 =?us-ascii?Q?Cu+64RBcFccw2ehMIpVfMaWUY00cQjkohIBuZCoj79kMM3c8qeZTUsA6Cy71?=
 =?us-ascii?Q?HsGqESt7Px1ygp72jRiqLGmQCp0/imZWVzBZQIrvaHPSne08nJqN9QIchQnA?=
 =?us-ascii?Q?+jjDNz36dxjm+aPr5VpHXwOiP9311kCdLe5MwHyjuMo08kYh915+pAA1//LQ?=
 =?us-ascii?Q?HScT1P+CuXjPVBx0fbFImN5eXMbkwasF7gGC9ZDyT534NKDvNRGsFQ4X58HW?=
 =?us-ascii?Q?6oQFRA1WTCNGZ0zGMKS2ITWFvwIUNSD6rY11nrzoC8qy/9S8jq3ZrVld4HRM?=
 =?us-ascii?Q?YO3Mnnk0Od1TDJydRVZ18TVizSnb6wHGwLWMRrLtZai0q58FM1dQJZOLTNtB?=
 =?us-ascii?Q?GbUXqYTzpxYTfJc3F8W7321ZJ+0wjfEmBuf/1EtDZICrllFXPLUbB6HoUdaw?=
 =?us-ascii?Q?jjPFyFihR3meToZktsB2RVRPcqXICd1dnEmA2QbDIVLfsm9EP0vdMZw1Fque?=
 =?us-ascii?Q?rGso1JFOEea4KnXAOZdrbGsUkBZoSFHAyLIAcGrGAlTbiTJ+z6wFLL8WbEfO?=
 =?us-ascii?Q?ZyhcfBYc0XuO+MgsULHUVNcT6s7nAVE0rfs68qQuxvUm/58T9dNPmDGbneeZ?=
 =?us-ascii?Q?qY0t9fVRmDTMSLm5dg9M1gIV9qegoc7yhVi5Jb0lRKrqxbGjm698KSbwjzdW?=
 =?us-ascii?Q?aPBGx22jqxWHY1QU9welKFU+88M3DL4jspF04r1BcPH4z6YBSlxQU8L0uKtJ?=
 =?us-ascii?Q?tJv9G/1whs1Ub4udlbB07aBEfJumpVaYc7hFVmlNh5ZTlVoT9vk7VJXivP+U?=
 =?us-ascii?Q?mSB+KpAE5EyPWOs2hzvNUG6nH08wszZGlA+dA7oiQIvcTitbwvsb4/O4Pbqo?=
 =?us-ascii?Q?LWYHgww8cud2ZT0SXquRekwtWmeT4lyqUT3vyciJEaxAYow8hdUxv6EH4XvZ?=
 =?us-ascii?Q?4L395ZWsGFSD4uIACbyAPj43aZYG49CPfGmgfLMRgUNGxJVTwvTgQEyZKOzW?=
 =?us-ascii?Q?Pxd50viZE1O32sXO90041+hFuU37ZvT0xLAcTLoNzTRsmwffkAW+9ENWtieM?=
 =?us-ascii?Q?MnLc/nAzWxCFWGv3XiD6k3V9YylGKFYAa8i7GD0Y/2n1vgc0aLlm/9qYl7sZ?=
 =?us-ascii?Q?wRligrM/61S9BIYqQVIgyjfKbX3KU4eqn2qxz0BLJ799f+fqUbLd3pp4rcRw?=
 =?us-ascii?Q?RB+AgrsuItJ3TcOH/IkPnVI7DfGgyxudZEa7sKaKyteQiugGu0iKmh6OJ72C?=
 =?us-ascii?Q?FFUeAiBXsGwWHI1CoIhm1Xrydu6sx88QAWYnjVOQt7UsREKqABPpppqQdqZ5?=
 =?us-ascii?Q?8J5GRtX3l1rFHT+MawyqEPDg19zjYyncFdketBP7HqyA9jnNRoiIa3NSq7Qe?=
 =?us-ascii?Q?YuM27HcXVG5WiGf19sdjSP6lj9LzVUNoKHVws+uCBuKHo6URbXXiq5Vzo4u4?=
 =?us-ascii?Q?N6vgQDXRSF5l7SH/OrW/syUhgxkTLTc0QvFyBhYTNTj6wOHcn3Kar+OgzZjJ?=
 =?us-ascii?Q?XkXOA6U7gS5xYsMc6kRQ8i4KhcI+HvVISfA5pomoO4mp0vVSqi7autl8E8RJ?=
 =?us-ascii?Q?jxwOnbf5+XycncZhw8IXG66n0Ubwfy6j/4d195Kj7LGIiTFgxYm7Haj+Gtxd?=
 =?us-ascii?Q?WMZcUTcQqrpkX8BC2FRq1a3MXg+w5bSPQeXudQvjMWXDmoIday+MXHJlCaI/?=
 =?us-ascii?Q?L5pc4kCUyq/xlmHRK/1XWJ+ac4g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1116d65-3a9d-4458-7bcb-08daa1f57a30
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2022 08:34:51.4778
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XGFnl+xqbYW/n/TbkBkNJT8+ADwjqFlnw5cR7M/NqHt2tFXYfwt0X5lKZw37c8nRzVAvYX51YZ4Z8Jdha9+v4zG7ZXZF/PeBpie4WRHGUKk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6099
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 29.09.22 09:49, Pankaj Raghav wrote:=0A=
Nit: (but I think Jens can fix this up when applying if he thinks so =0A=
as well)=0A=
=0A=
> The current implementation of blk_mq_plug() disables plugging for all=0A=
> operations that involves a transfer to the device as we just check if=0A=
=0A=
                         to a zoned device ~^=0A=
=0A=
=0A=
Otherwise,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
=0A=
