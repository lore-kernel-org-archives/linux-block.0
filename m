Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDBCC433EF
	for <linux-block@archiver.kernel.org>; Tue, 28 Jun 2022 08:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245343AbiF1Ixf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Jun 2022 04:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243231AbiF1Ixe (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Jun 2022 04:53:34 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0499B2D1CD
        for <linux-block@vger.kernel.org>; Tue, 28 Jun 2022 01:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656406413; x=1687942413;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=p/u4EH5ovUK2KJWRv1y/Z6lQ0p82xO1QOEkVel9cLI0=;
  b=I9djG0x/g5Rit/etPXiFcqN9nHuxwegkLY6IsWoTYqnF8HCnmfMOvTTV
   6XmU4+C/PPH5XcMjMZFD/DbHNZYGPZ/v/F1o/fzdtAQXC67VK57b4D4Z2
   gg323rXiWmUkfPTGY5hh9VHVNP3yOehgCBVdOUXz93UjoMPuqXkYG9ffT
   7FtaloTYhxnNg0r91ppqN/TWbHk4G3GBgcB8PpCPIdcQEoQzabwXDkWcb
   ThDVKkvY2NCEjlW9aPExekJiSrxOd2oEaST0uzPdt2LuZByB0Jm7E22qo
   IoIrTKwl9qBioXlRGFYAqamp6Q/NkEhTc5YuBRzCkTe+V86o50NVKEEGo
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,227,1650902400"; 
   d="scan'208";a="205008161"
Received: from mail-bn7nam10lp2101.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.101])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2022 16:53:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIRbJMIcu5fjr7kxYk4JhkJDeYNI0+AuuYA7e6Jf2VpKHZ35lbulzLb66/hja+eSGkw5Ff8DT4Cv8vN9zq3b7QrolSx65gTCGlXJXuWxpo9cP4VSV26erF8rDtwP1v8YzXUfw9SfcFfX3mSHdtfZPxpC1f1xVbHOJoriMGWoItJCfMsUladJiyss2QaTzzC8ytTHMX2kPbnYDwx+4eQvXawRh0yD6yvMquRroBIyJbo6cPhRJlccm7JRNDWOyeYRvXuFh3v+Jrjmd6gLB6zHYYua0QUQ1o1kfAYDPAaNGUaCboTIt0yrzofs0JQ5g1PWSo18rXsBP1gp9PbCS9Cxjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgWb6DPpnZy+cnB0Wq8eMKlD0RTq+DeilgRdpnwZ+t8=;
 b=FWZwE5j2yGqRqoN8xBuLqwc6m74gm9NFJVWw1QwbSYrxtZdgMCwz86T2oc77ENg39df91G/tS2eOzBurgE7wARSUJWo+JkSDU/1BuT5osjnMjT2veeHPA31/8JxFj12bo41qQgTLfmrnoyQrB7oMv0hNZbzPWEj8+lNGy7LCItz9Q09NGopXhRAgrkMJIOmgCffNCvCzIa2a1rswbl5iVv9U7weH8gYjnv4I0ByJKVISZMWY7QAm/tHoWVdWHJK+ldkiEBo4DTVDWN2tsihiJ5wtZXmUyjBB1nDo7cgfHz1Dx9IxTHtx33229zkErgL/i1aCA9Z6SJZ6/f+FugSKQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgWb6DPpnZy+cnB0Wq8eMKlD0RTq+DeilgRdpnwZ+t8=;
 b=LSb8D3thfAMeTC7t64CXeTXJMwla4Oh78R+VGhKbLFpHeBFctzGK1XK6k6tjoymckSM3gS2yrYaaz1db+ueIxbLug0oFHv9mOVqhgrxnpBFhMbo77HsCXBByFl1RK5TAkQ9I0/NAn/1Ypc98IzknQv0kwx+cXSqnkj/C/pXq7qQ=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7278.namprd04.prod.outlook.com (2603:10b6:a03:299::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Tue, 28 Jun
 2022 08:53:31 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 08:53:30 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v2] blktests: Add _have_kernel_config_file() and
 _check_kernel_option()
Thread-Topic: [PATCH blktests v2] blktests: Add _have_kernel_config_file() and
 _check_kernel_option()
Thread-Index: AQHYiflO9DPmi6kqsUGxpMdu1zet561khSEA
Date:   Tue, 28 Jun 2022 08:53:30 +0000
Message-ID: <20220628085330.4uiumau2jj7rbqd2@shindev>
References: <20220627073249.34907-1-yangx.jy@fujitsu.com>
In-Reply-To: <20220627073249.34907-1-yangx.jy@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2df08de-4965-411f-4df9-08da58e3ace7
x-ms-traffictypediagnostic: SJ0PR04MB7278:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HHNIJE/AQEgkJY5qSQQgeTlp2ifJQonFCPF9A4klMcVlxa9pYl4Z7WXUh4MP/mBCrbK1pG8Ha8Zt8+UdgABEXZyeTuJN2emFy001TQdys/WxJkyWhAgFttblrDG/ZRY5xCTOhYz0MrZxdMf0KKKW46LZ3y5sixTmkHJEHrPa97j7KHx+Jd2TmxOG1DgrDo0s0jox0zeDRvMQUR7IkyuYCQqqyMpxWp+JcApco+3O6WmCB01ZeTpsY05PuOW8aaGZDUgmZ0S0lnk0dXeYs+bXgkqCueTniOGBkx3rK1Uz/fpiV7UCOgBe3rsMnGeqB3OgfD8vqyMym4qgA+w4t7AcTz5u5Cw8qB0joyenSODOOBob4bYVqyi5j4JtH0iLLVubeomARU3nzvcgrbWfMOVsi4yWZv4FzBF6R/IYMIGJp61YhFXXZEY4GlB4Uk8bG8gEPWYzIzo8gp0mud43eIcE6Lb2oMQlY+4VpmsiWNzBiJE2qy4UTx1XuxqSxJ3CLWxtxDdTHa5BkAxdIZk85fm8iv0aL8k2Tcf23CMjaf6TGUA1HfSMirOQFodhiTey/bHpzZmGBOBW/vVxjr8X2RpQFrHEodZUXrfAPk6W8/Q+DZR0q8SJoL5v4RIiRZYibB1C8bIIFSnZQIxyCRkTH/57S40j3QTRmE//BN0jVOVBB8clPpOIxrmGH2etB5PYNB6jHwhmdXTICCljEBXV8lvr82Q/wJVaN/x/Y6NgpAXNWGzRwy52SFYo9909wmnt3oeAIfW8mtUU9ba7kGp4Ee2/Plu3GFtXFr+/0rYM6cp1HB0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(41300700001)(122000001)(64756008)(26005)(66556008)(5660300002)(478600001)(71200400001)(66446008)(38070700005)(91956017)(76116006)(9686003)(44832011)(6506007)(6512007)(66476007)(4744005)(2906002)(82960400001)(83380400001)(8936002)(1076003)(33716001)(86362001)(186003)(38100700002)(4326008)(316002)(8676002)(6486002)(66946007)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EHqHQLOWJMGNutMf/CwlWSZUHjKg17hoRBwhYaJY8d3/E7nf03gV3xfHDe09?=
 =?us-ascii?Q?0DOe6S2oahwvW5B7g3zwWUGYi+ROZ/I552lsVfizQLXnYGJYY3d7O3Rjjv0/?=
 =?us-ascii?Q?r8vC/sYi9SOK5lGpp3GFTITq86vOjPErkEprscnbROnd/8vLNPr5lA3hFv/X?=
 =?us-ascii?Q?Zrv69iacZqivOZlynL2OPe9kPn/4a2glLqtFra+jo8qcDYr+YcSYxxVBTLht?=
 =?us-ascii?Q?G1vALn/EJ4VxBo+w6cI+u1ajztUdjeOCNe6OIQi26Qk+X54Ji8xCI3rt7uGL?=
 =?us-ascii?Q?ekfIWlXlTOkAvS0QHwZnqBxbc60brnGS0W9PuUw3cXc8+u2pH9SkNCGEySb9?=
 =?us-ascii?Q?eaAY97i22TlLLVsWV7j1Vogsyv6nEviPniotu4FX359nd71pI/ytQl9a0shs?=
 =?us-ascii?Q?OfDkT4vAmGbai6IpO4eXhrE37r9m50/64wIW2JFNRYJL7ydQwhQLIxJAVBgZ?=
 =?us-ascii?Q?t/LUbMT5qq3NqMM3ikwyC9Q8QpSNDl/vCBQTjRJd3beLTyV6JqOitKyZYkTI?=
 =?us-ascii?Q?9L3rbpsU5p6rWoArI1rKWcxZLnF7/J86UMw6aQ8+iuozZBOhgLIYhwWzEMkg?=
 =?us-ascii?Q?7+/lJRhO/j4/vq9XI0SCr4R5LLtftlE90EhQ9b79Qxn6goUuuAEvQVdDuczl?=
 =?us-ascii?Q?GJ1vFgJ09YkEPeF2hzjsa+0VI6zCtoJTXcqon22F+uab59ORaS7q8ufJBXWo?=
 =?us-ascii?Q?LJywOPtCtmUrMUJt+zUsxVwe5KxplQ2vmj3yVWZNrpSbG0SQIpmS2H5m9U83?=
 =?us-ascii?Q?zoQ5Ii1tJBjzcnQ9uEQllpsFa/fmxj/tMmsPjw4Q8UQcGIqgRvuopaSCu7C4?=
 =?us-ascii?Q?TtUdAO26Dy1qOhsITVZGpHa6R0nVRNHPviz/dRwZZ3efTvg4BPaKEY7PSwuA?=
 =?us-ascii?Q?9qUdVJ3GjytvtB96qLuI6m5MOoQdnBNFe3aeqSqiCODDa9dvvyvbUWWjzJNF?=
 =?us-ascii?Q?UYa+qeAQrWG8BJDzRmXg7KB6t9JKV0+T3i4JNgyqU/RIq6UF3jrG+fD2jecC?=
 =?us-ascii?Q?dQ0ChO+1hij9yeZV6bjKoGa9pdNWoeT2OtiPpAw3Glm9mePlIXKINLql9Kmp?=
 =?us-ascii?Q?0kiNbGI+AVvoj1bIiKDFs0Gp07/93ByicPcyEY08rJ5tnSXf1ODL2lL4Z6g7?=
 =?us-ascii?Q?mB3Ox+3zdXTWvmW4zAS8uoitMho9RBcFu4AXcylaKask5tNDcU7xkJkeHFb6?=
 =?us-ascii?Q?D6x8t5QvPjHZ0agPNzu88bB/h1l1zp1Txer0Urr70hE0VwaJxgdvMJi177Eq?=
 =?us-ascii?Q?MUUPJbw1DFcY6ZastrgE01CA5PotSRulTEb+KCy0NhHR7HhqZpXz22hmainn?=
 =?us-ascii?Q?hF5BpBsjdBNBstNxPWWidt2LbUB+wm36fJl7OhRIFPwLWKoJ0mnfPid0Q/7d?=
 =?us-ascii?Q?a8Dec1gqDg2ENemO3R5jUsL7ROfZb8QMbejTt5gZEtTjjprjRfOgKSjm67p5?=
 =?us-ascii?Q?+TrccY4bG7XU1A/2CYIvxhQLopxCaRjIDlRjiuTLaTWPEFngYacRPoJvfat0?=
 =?us-ascii?Q?fGJFadkrhnNmqMqOF2GSgrrVmfd8Dz7TrhYDTTenBI5Mzd/Lb31SzvVONWaP?=
 =?us-ascii?Q?aHo0KY6MlsW1rgqD9TWmByzs8vcZtxsMIKbLv5TJo+20ObNfK7+f2Aa0lKvo?=
 =?us-ascii?Q?Ncx8x+aPWD98U46oEdbSkJc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BFF40BF5C7A2F04D9190E8670A6A81C5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2df08de-4965-411f-4df9-08da58e3ace7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 08:53:30.7694
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HUoUIoLaWVtoVO61d+6yeh1eZiMUdRQd9oiCi8fFzJg1atx/9o7Dn8NUXJ2+OdVtQvrTvQgxwIvqXhVdVqNr3Kh7ZoP/16JaGowUQsYelEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7278
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jun 27, 2022 / 15:32, Xiao Yang wrote:
> 1) _have_kernel_config_file() sets SKIP_REASON when neither
>    /boot/config* nor /proc/config.gz is available.
> 2) _check_kernel_option() doesn't set SKIP_RESAON when
>    the specified kernel option is not defined.
> 3) _have_kernel_option() combines _have_kernel_config_file() and
>    _check_kernel_option() and then sets SKIP_RESAON when
>    _check_kernel_option() returns false.
>=20
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>

Thanks! I've applied it with some edit to the commit message.

--=20
Shin'ichiro Kawasaki=
