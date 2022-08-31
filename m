Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECE8ECAAD8
	for <linux-block@archiver.kernel.org>; Wed, 31 Aug 2022 04:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbiHaE7v (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 31 Aug 2022 00:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbiHaE7u (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 31 Aug 2022 00:59:50 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B111113
        for <linux-block@vger.kernel.org>; Tue, 30 Aug 2022 21:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661921987; x=1693457987;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=kDk/ltENv3lkUlRzoiqJN0eaBfj6RO2owM0OIuy6JKw=;
  b=aK/ZxYrfM4oD7Bqen3colJMr3sv8v4odA04uqAU3EjSDhAxt0xgWcqtm
   gHmf6Gir4JfM821F9XUJrX4z6ACQz67yrvpR/B9IeHuNhmH2jRzziCQNB
   7hnXYzKkS8Uoxhxx/aRU8SzAU53rKSYjJgpXxNPZSYW0iL+i8EGwKITmn
   eCFnQo3Pb0M7Ozx1YLJyuxw/8LQk39lwMFBXlViwEzfyIAc77gDrtEEzO
   btoFYyTexcnI0ULRp+HLIdV3TVGG3Z/zro2DypacuhvZEQfyo0+PItg/r
   YdFhCgnv3mngDSnMDBTeuETF5vzClYx75vvmDKMGcRcZ15gVLMp6778rc
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,276,1654531200"; 
   d="scan'208";a="215258617"
Received: from mail-dm6nam11lp2174.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.174])
  by ob1.hgst.iphmx.com with ESMTP; 31 Aug 2022 12:59:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NP8Hzvn9ynzg9xOleMpYo0r90rGaUlMtnRSqRuIoOeWEXG0rr5BjAJoYgTUZ5xL4ThfpPJblnLtTD2NjA0f7tE2ruRvyQp97DaLZM2t3bOx9EWJMgjRT+iOLM3qlCHlAMAWV8XrZJccMLLU2zKNXXtKB2/hgE6cMGO5b3JtxuGXpsS/ZVRk7LHyhvpXM/+8rlOwLv4dookKaRMGYS6a4BvQWXeolzCVkj/MScgjRi+Xe64es6TraQVqSaqF/sZ7CeWHCNSzCgs/3iV46Z27g9HKAGjSlnV/u2hsmguYMXitPFesHMPvpzQiqRTQOYhcysyS/nh2ajMnDH7ja8/N1JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vq7F3IalmoI4gW1tPCzfuAS5D07cHWSslSw8OtdMy5I=;
 b=NtJmz5y7JBL5k6drjIV+FPlEFHUqiy8snOs/xSjlzkfsBj/Dn9PEQXmqnCD9wQ6K72eAnWBmFmD7E9Z25ZmAfjDE/Haqbz05I7FNPIZ9XJqNqjmHNzcfXNXhuBS3cE+rrHoFnoT75knfMP2qoqf1FxVTXpt7BNPP9JPHUcHboNHbxYtv+6WHDlYtR7PXw7EpdtPx0dVIMpygk8W9ADsAzZyrMFkV4lePZQ26jXZJJj5dd579NrThnJFPT74gH6RMkg47N/VyeVhd7bxnClQFgQhoB+6ApY38DH768RxC1o1WJaysB6ikIeceK6BGrD5FXch9ad6s5e+3G6m6eFwfGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vq7F3IalmoI4gW1tPCzfuAS5D07cHWSslSw8OtdMy5I=;
 b=zCoFRwwb6eNX1EbdJIC5kCnIgSQJPq3wqS4JZ4vd08WBJ5H9rdur12uvUtySVCyoX6dqNJzQh+gNJ4N1BihcwItAcnuvmgIplwNN5ZCFSFCqXuncPHBBnsl6y1HRIGi2bL8AmPwNFEnI45TPpPoeVITjLUrF7psu1B+pquyG8Og=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 DM5PR04MB0874.namprd04.prod.outlook.com (2603:10b6:4:3c::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.15; Wed, 31 Aug 2022 04:59:47 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c7e:a51:e59a:d633]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c7e:a51:e59a:d633%8]) with mapi id 15.20.5566.021; Wed, 31 Aug 2022
 04:59:47 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Sagi Grimberg <sagi@grimberg.me>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests] nvme: add dh module requirement for tests that
 involve dh groups
Thread-Topic: [PATCH blktests] nvme: add dh module requirement for tests that
 involve dh groups
Thread-Index: AQHYu4JqMzYWLRy0pU+II16FtTMMiK3G3+4AgAAmugCAADeMgIAAMuUAgAEE3QA=
Date:   Wed, 31 Aug 2022 04:59:46 +0000
Message-ID: <20220831045946.3elujhdydvqkkhv4@shindev>
References: <20220829083614.874878-1-sagi@grimberg.me>
 <20220830044632.j7k45lhdlyvksrxh@shindev>
 <05548286-8d18-e3b4-06db-640c9d6b1399@grimberg.me>
 <20220830102357.yahkv5qfr2ewa7uh@shindev>
 <a5c3c8e7-4b0a-9930-8f90-e534d2a82bdf@grimberg.me>
In-Reply-To: <a5c3c8e7-4b0a-9930-8f90-e534d2a82bdf@grimberg.me>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de91393f-aa5c-4436-1dd3-08da8b0da081
x-ms-traffictypediagnostic: DM5PR04MB0874:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CQ14xXCIb9pYV1WeZdiGRzQOePoByF+Cfl/I69pedSkbWmSoPl4V9fL0Pr1gIhaODasUmoGq46IB0UWMsJ98B3o9egova3Ly1YgE6IEaZZBN3zMmYY+4bwaoGPP5EZ2w5aD+PNmvhTxne4fOi+NwcHaNpfLXCr5H3DWVCOqE1/ZZNElzUK8aaHRTULarEkiK/HgGlJtGVSzmZqWeHDUhoW32gnB2eDI3EAE5moVRDehF+PbFiZuIFm9X7PrFT57901U0WjU3yVt5yx479bzg6khoQO+bQMH+q6KTzQd4USKwVRXGezVIxPAGfy5U/pcNUIMsyl9N0wA7ypCE1TAENtNysQg96hKnVFyUTHidBhECwOr07CLoa3jC5VPJE3qtF0B9l3AC3372ZJZx+B3mBYfQHk6NzbmcNrO+sc5E9NJiYo/V1bvaTuawDoMu6zdnNZi0lXyE3tScPv7Xl1Js/EubrZlEEj5YUwBoeN9LyZBusJShIjvB+eAHzRK1uAlSwHZBpcxOg4u+angkREgp8PsVyGHDqd/7KR0lk/iyQK+xDqeETF7Bg3ObuP/4yzdLL8b22WKBvxsWJLKA5fw/Ru6S8qvkKvxiC0MhmHht+UsBh/CnY6+G+lRrzr4xFTd3nk51mMoN3CQsv0TxhLylcohZQ7MlR6UCJWFzy7/77A1aPGYRGO356+6I4Ve6Kvm3lM4AY3cwipjeSCNBLKSpuXKTP3CVBuvzBDzOE+GV454o7ttCI8TkPEbBlz21A+PFZlVRYy4hLAcck4qO/y/O8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(376002)(346002)(366004)(396003)(39860400002)(136003)(38100700002)(66556008)(66946007)(66446008)(4326008)(64756008)(8676002)(76116006)(82960400001)(66476007)(122000001)(38070700005)(91956017)(6506007)(1076003)(186003)(26005)(6486002)(83380400001)(478600001)(71200400001)(9686003)(41300700001)(316002)(2906002)(6916009)(86362001)(6512007)(54906003)(8936002)(33716001)(4744005)(5660300002)(44832011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?uq/XXnywr5q7KM1/IRdMGxn9BZEbSkUEvExcYJolJZYL/d4AljiNYYwtWEd0?=
 =?us-ascii?Q?R4WbwM6F6VZrULKxhiw4WiaU5+5MYcLFLNEQG7i9lXMvk8C9ebfXXPHVocpj?=
 =?us-ascii?Q?oHhFxDHer9Gr+Ad4A/K+6AEUAaDVJJMsIUz6GwqFzzTzZFlxYJ8g7a+tht4b?=
 =?us-ascii?Q?uZ571ta9WhMTzRRndAZNZYM4TEk39nCH+i5/TXV7ASXbD7wJZz8F1KxFFFo5?=
 =?us-ascii?Q?33NwDjm4OKtlwRYaXt0ZOgCJkTSs1fAfk+xgti/uz/Wgv8/K992q98APMGcE?=
 =?us-ascii?Q?BA9TVnFVHHTi17pB25FQg3oYUGQQS9SbEpFjQCckFYE90afTHa6UoqNXgMjI?=
 =?us-ascii?Q?1Upzr8RJQpHm6u14iQcvqLyG8pqsAn3yBgC8R19pEefUgvSiiLq88ZpxqjXo?=
 =?us-ascii?Q?ac/ci2ku2DSeA91MDXOg4kRn7oGOM1mGIRK5fd2elc9xpPhZ8H+ITRksjREX?=
 =?us-ascii?Q?tKygETZtj/eVgiOzZ9X8a6jYADNdJxIr2CzHFgGzD7GNzpACBlNrXq7AF9t9?=
 =?us-ascii?Q?QUfL3FKW72HsZw438bYz45Pb2s8bnVYIY9XrY1yN4VRimVskJ7Y3syAQEQGE?=
 =?us-ascii?Q?CTIrEVVY/5Gnz7pO98jkl2ovdrOUF13GzgHvPww+CG+7dD8GXKXb62NLOhsz?=
 =?us-ascii?Q?sIMhgBngZeihCxi/FgPePA063NA6oUZS0gPRLaOVTW6SKZnQHs4P4L276Kzg?=
 =?us-ascii?Q?hY3XRkeoSSvauzu1Gn0xNshdYrpwvW/BMuvWoBuuYba617a5F2J9ZJHWUS9j?=
 =?us-ascii?Q?+CUg6Apw4mYb0PqaTujC4kE6yWVB6pU/jCiJXD9MMQYhAnoTXX6jrc+oHuJl?=
 =?us-ascii?Q?O6i1CvqDvMzsGJxrbpxNywJQXT5u2JHmel+/SDmyoKTZ0aY2qSlxccUt3FCi?=
 =?us-ascii?Q?HQ/JlHWJznlMxDTg/TTKeaGvx3HkbbaaeorWv4K5ivaP+Et20bCbFo+iyT0C?=
 =?us-ascii?Q?kj8sHObbMNGS+2hy7MdOVnmWnvWNy3+3+WSnzlco3tpN/7DMgiTVC0oL3m5k?=
 =?us-ascii?Q?NCGpW9S3xh+wnN0YjKlynLnIC6eixEdQdOZD/2OI6XSQO8X2svWPpIwJPSKS?=
 =?us-ascii?Q?t8gZy7T072B0RmHKsffI8/YAzBe2kGK8j69KBDm3po+5qKgFw26XKPgU+c39?=
 =?us-ascii?Q?eLK2IwNRUwcj2JgarMtbjbKw6Wx9HIfyoYRrw2YhBEk72NmZyE6YxAZqoxhu?=
 =?us-ascii?Q?eDVhAI7Lu5MqYJG+4PnC5HSrn7dhaX/hUnFvljDfZ+WikbyLtGi8pE6VxkB5?=
 =?us-ascii?Q?HV7v+IdV9LLexDdIRO/C0Vx/4OHlVpUim2qhEQd33B63OOJAYajIHNpQ7C4L?=
 =?us-ascii?Q?GKneoC4cVJTTSdF3e9yw62B7rh2wiwZtPE8HfflnuHK9/aNWAr6mQ1RjqxSQ?=
 =?us-ascii?Q?6/VSnqSJowFPI7nI4FFh8gVMf/OWEaaBkScHQodAyaSNep4Dny3UdNKbuyI1?=
 =?us-ascii?Q?uGbxMSnISoqW5o+e8g5+cnh8iIz8xAM7umJzp66DQ8S3nIaqK8qDFC1prXEw?=
 =?us-ascii?Q?vS1Z/QsjogfpGan2y5m+/QHjpONzyuyaKaXiQ/aTJHtD29fuHAnR1kKIaq2i?=
 =?us-ascii?Q?xgKXr8mbwCKHov44NVCArQwOf+TpHvixdNBZbLFUSpe0TruWl59k8Pc10xfS?=
 =?us-ascii?Q?K/8X65JqXvqxQQsOl/R39VM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <54EC33B1239BDD44B213E1D8ECD9D670@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de91393f-aa5c-4436-1dd3-08da8b0da081
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 04:59:46.9373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ozcmSWsQBmWdQmCnR2JsUCJJCSodlWpIk1i4JmyZNeLdQmf75THPyRuyCf6XyN1RZBfsbpAaYjm8OebWJeEkq36LJbGtyLDj+EmepAV9QAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB0874
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Aug 30, 2022 / 16:26, Sagi Grimberg wrote:

[...]

> > Unfortunately, your patch does not avoid the failure after the recent c=
ommit
> > 06a0ba866d90 ("common/rc: avoid module load in _have_driver()"). As the=
 commit
> > title says, _have_driver no longer has the side-effect to leave the dh_=
generic
> > module loaded. Instead, I suggest to load dh_generic in the test() func=
tion:
> >=20
> > diff --git a/tests/nvme/043 b/tests/nvme/043
> > index 381ae75..dbe9d3f 100755
> > --- a/tests/nvme/043
> > +++ b/tests/nvme/043
> > @@ -40,6 +40,8 @@ test() {
> >=20
> >          _setup_nvmet
> >=20
> > +       modprobe -q dh_generic
> > +
> >          truncate -s 512M "${file_path}"
> >=20
> >          _create_nvmet_subsystem "${subsys_name}" "${file_path}"
> > @@ -88,5 +90,7 @@ test() {
> >=20
> >          rm "${file_path}"
> >=20
> > +       modprobe -qr dh_generic
> > +
> >          echo "Test complete"
> >   }
> >=20
>=20
> That's fine with me, can you prepare an alternative patch for it?

Sure, will post it soon.

--=20
Shin'ichiro Kawasaki=
