Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06857C433B4
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 05:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0194613AC
	for <linux-block@archiver.kernel.org>; Fri, 21 May 2021 05:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239373AbhEUFMS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 21 May 2021 01:12:18 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:63070 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235591AbhEUFMR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 21 May 2021 01:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1621573854; x=1653109854;
  h=from:to:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
  b=c727sfLbdJm133Kva3RFeiWWUyUGQ3TZpm415jR6miHQCkbbGaB2KsIT
   E6cZ2LsnqTW8vyu6pLA8wbSo/KL470dLtfE/BeF0vFBvN1CaWrcJLVzc8
   Ic6TOTKefHZLy9FNlDvTUA1aHI1APl60phLo3RIbC05wuRohjTZCY7Jad
   Kkv3RPEASmvjEA6nsp7TJAi1/VakQpRPiyZWDaA2lJWAElMDnguHvqLGP
   HpoMe6Yxt4TVnayoTSD3pwW8Ul8cse+xZrK4Aw2H0G9RfgBWKpKauPMQ0
   f70eBuHZIVMqTIhj4x+gi26r+Rhw4zGp5Z+9gLlOxk4gPigcFcrNiNj4Q
   Q==;
IronPort-SDR: GJwPQQnvHH7uhgVSBoYtV4FOnAFg5ITvLjgEz46Isf9HyCMUP4EHc9tZ4Smkeo/CtOPnc8bJmd
 AN1vliAmCH1b6oPQw/YXtBqsLw1ozh44GO5viMrni+Y45NBi8Q9+IFI/BQ5/apURFjoweIsf4m
 u41LsSlbDCH7sMYKFm8toyw6+058YSK7O9Fe+bg1kus0N3uZUtOKkLpczZSvf6bWw4UAa5dZ4z
 XF6OSADnc2KzCdyATJuBRvdaWZpIfHhdX/qu5GLw7OGw3WAb1eakBvviNTgFLsmy6vHlhYhvBW
 nyc=
X-IronPort-AV: E=Sophos;i="5.82,313,1613404800"; 
   d="scan'208";a="173604640"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 21 May 2021 13:10:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jicru7ZoHONsmFxAVEIUyfCS+x/8u8LzEo5ucQfDu3z0wSwbasMjPTeyhcGU69jA2Wt9c2irhUYa8vPLzfcZfwCX3HPRuwHGZnf3FsMUReGC5B/aXwhq5LGAZ60zYAtZ7hBMZamsrBVAhxyNPRk2dRefy/oCIUkP9XacMcJH0BdBuCageAglcrEQmNLAlMwQbBEvXLLi51kIhU2Q1pI+a30PTSb2+X8UFSzYSzezcFgzvoujjne8yB8BzJP9aGoFEG8mfXcyE7t1YhoJDZMeeIIvdWSQEfTtbDn5WgWsAA77j4gP0Y7WhFEY81kjJBWC3Jbf7YEoDbdHPB7X/Q6J2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=bXbc0ETLJSxf+Lb++y0ltiwWtui03XKQ9RocYEt5RDSXdWTGdW/JgxaIR5cX8KXFdw0Z/0rvSC2MxFDHTyjfyFMcM0onaOvisKOXg1EzoevCUfoHmyzCzY4xTsVYCR2qYhVBqUi9FZKn3uWzs9iFvUsGX/7MWl/Xn7A85+3keyZbhkP47uR81skrc418vGVMUAK1oZ1KTuhkSv2hK16tFxES0uauSyH41GxHWcf3JsNY5JE8sYcIuDFil15kaWt+opNwIEp6we7wUt+mBR5EY5AyiDjd1CoRfT7sw7yquuDHBF0sGiVhpMJCCKsFjNH8pfZ4jqL2tTiSpaXLYGze6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i73cQScyOXtQNhKCgBM0j0yco6YrKjuowVHgFUDbKic=;
 b=El5VsyRVMrAS+VuiRii1dbZFaK8norQvxRY8j2/kNKlh7RB02+3Ef0moQSE2KL3MvLhAZ+fvAWoPti62DBaQ/hD7YVS/HT38SK1VubRjHeCPnPGrKuLVJuLWG41gcssvbDFvegVXCiyKARqnR9ty4NtGKL+mvbDPwHaEAFUzR8E=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7544.namprd04.prod.outlook.com (2603:10b6:510:59::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 05:10:53 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::99a5:9eaa:4863:3ef3%4]) with mapi id 15.20.4129.033; Fri, 21 May 2021
 05:10:53 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3 08/11] dm: Forbid requeue of writes to zones
Thread-Topic: [PATCH v3 08/11] dm: Forbid requeue of writes to zones
Thread-Index: AQHXTe2jJOdlUthNFEychyxSq0vQtw==
Date:   Fri, 21 May 2021 05:10:53 +0000
Message-ID: <PH0PR04MB74167C27A5E2E12C7CBC950C9B299@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210521030119.1209035-1-damien.lemoal@wdc.com>
 <20210521030119.1209035-9-damien.lemoal@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:152f:cc01:f8bd:921e:9aa5:6d21]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aa3b4c59-c5af-42df-504f-08d91c16cef8
x-ms-traffictypediagnostic: PH0PR04MB7544:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7544D7368EE025464DC381979B299@PH0PR04MB7544.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W4H7JRv/8XlCN+6ez5RtznIT4elbTt4ynVMGNwklMAgrUIzYYBJTH36Qx9535Pmb8asDbSXQf9yGdWpGcqo2LbpQUkqu0xmPNh5yitbv2a8z5RUdHbaxrdNkYlD+owKBVvZVnwQotCcKzxPsawCALhkN/7DftnkghWxuONc14Y+AzsVDAVxbBD5GLXUfD4btybLiDMH38bExVNCgj16tOmTVoafmRihA7MjAFKwbE1rrNg9l1LHbZJcklmfd8VVvkdJVAWO8delrAczkU+Nle6Do1vAC35LqhwH6UGvkAV8a2d7GIa5/oxau8kA4DIG0t4IBgkN2RAFz5GlnZgi2IAsqis7Uqe/J//NpXwFri1sxKJbElMKPzim51NrFVtRDR2Wh3U492si984oYBsP00cKgYhfvyg+feXvbgY+wAFLjQAfDWX1slCUI9D5fxGgdc66ZfDVfQ4cUEEeP1N1yTNX+xULZuENWQ9KzEJ77WqxhiVC0aHRIjBzzdctnlpXLWKxArknB5OTvUG8O5JrXpP8eySzats3Q2/H5jMnmWNgx9bJlWxWw9jgElhjjPLq4ILHYYQZFrYrewo8D9EbvaARPGkXCfiC/0xauMOjIAHg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(376002)(39860400002)(136003)(8936002)(8676002)(2906002)(55016002)(64756008)(33656002)(9686003)(66946007)(186003)(66446008)(66556008)(66476007)(122000001)(6506007)(91956017)(76116006)(19618925003)(316002)(7696005)(38100700002)(110136005)(478600001)(4270600006)(86362001)(71200400001)(558084003)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?rJpQ3jgvoi4miWYGNgKM3E9GVBnO/BYoZaMdSLj7q7U8zy/2B+oobDKRXQh3?=
 =?us-ascii?Q?npmin6tuvUCkR8ESjfLYAGsgLWWu5rHLWLBZ0H9nNvMGx1gdpXYyx/S24OTa?=
 =?us-ascii?Q?1fxlmtzEQiPD9Peedd0/w8kINgCLEr60kUT5hMhowkO4lJZE+LA0gy8weu5X?=
 =?us-ascii?Q?1dhfCQoduaKbT/6ILNnLeingc/Z0tOti/+3kIaTITHbfA+jpcnjI+8X3FHOx?=
 =?us-ascii?Q?YnN7w6Xt0Ly4K7qMO3AtHQRK/mmhcuaGWklB5Vc/hW365ATD//8FdhW6uGdq?=
 =?us-ascii?Q?295LgiTNNUK6+DqU38hk8SleQvKG9G48+gygwZOWvp+6qyw+mLWRS7C8qKgV?=
 =?us-ascii?Q?GG1n1dikeaiNt9gNV5EZrSgGLrimfoewt9y3oxBWFewCMB5wd0TFH5+eaLF2?=
 =?us-ascii?Q?7PmxTDgHyVYcKsCdF111muHOfMQYu+b8pn2WtlQ7POu2mrBX2n5wK7g/Yc6n?=
 =?us-ascii?Q?mv3CVDw92ps43QBvfn8wcfJ5t7A7nmo6p+9yKaRkzdtqnt3+gi4MBl8FrxF2?=
 =?us-ascii?Q?oiYhHUWG/d5E8h36n4+uO7jjtS+p9v+uiixu15PaKsVX/nVgRlZCNYO7GJ5M?=
 =?us-ascii?Q?zi8S4GLktWXm6ax0puni1kQ3FKZq37GX2HbEXCEX3YMdBY2KIqIeITi/FxHm?=
 =?us-ascii?Q?zVNOQOWs1PX44f4k+PmUS1OM9w6ZQ3cdjocAKUXu1fLTaENGb3zXgyL7T3Qx?=
 =?us-ascii?Q?c8YgJMrqdT4RGz4OQnwnVRM72zDp08IH3vgStQotOQ6wbYN7rWEBq89zZ45Z?=
 =?us-ascii?Q?VP1KY6g96NN1WbmSFF9PE7ukO+vERyFYUCxlTBsqfLmS1H+9lB25QTEFMmbA?=
 =?us-ascii?Q?PvURl6ewcM07+aIXnYN+uAUaSe3iiMU4Ps0ZV8v51eSedxPZAsKqUfKP3GH8?=
 =?us-ascii?Q?I41leUywb6MS3YbkNRf8XVNq42HPDL9ZhbT9x7tBhEA4U6S3T3Qf70fPGcvY?=
 =?us-ascii?Q?1FsmQ0jiDnhVdS9pecwsqYoNi7NK5JvZqsZZthT1DYLTA4t+XYfZDOu4NGY4?=
 =?us-ascii?Q?ihwWJJ2mJ8FIrniok1hhCaGm84O4hPEW/FMIh76NIEuPN0VvsrrM+lIlqGYZ?=
 =?us-ascii?Q?XaFFCBpU4WYR7IBg+STNL8x58dHFXu60CksjBY24XR7PkuxmasiXQdL3OXHm?=
 =?us-ascii?Q?9tzeH+MixNjbeRCUdiVbwu74o9ozWozgbKE7tshEA5NUeVK/2lt33ybwL7PG?=
 =?us-ascii?Q?Js9toXf+F98CZxum1QZsArje1KQZDF+IDJQTmO7EdeBUu38fPQIt+6bOSCWC?=
 =?us-ascii?Q?iS67XMxADF5hQpxvFebsJFg/4+t9YQei04rpHdPplGpiXVozdlk8DLcUHft8?=
 =?us-ascii?Q?LUVEbbzRkd1OonrM2x1ac16GTqn9MkuBvXgIZYfRtk/2EG0Gz3/jdJuBMKoc?=
 =?us-ascii?Q?K4G4251TzpsDKFX/cOvXvj21+dJCwiq1LQ2TbppiCKvMMNd+vA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa3b4c59-c5af-42df-504f-08d91c16cef8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 05:10:53.5649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TZ7tacaBXgeu7XgdIkK4FV+avVW3I+DK6MLDngwHgFLxSKCq/SVbb51lAKuBQeJiR/ejRfAX/umm2WZBNTI8d7xVVkm2AROaCU76Yzl6Qxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7544
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
