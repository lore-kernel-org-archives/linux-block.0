Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F11AC433F5
	for <linux-block@archiver.kernel.org>; Wed, 27 Apr 2022 08:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232374AbiD0I5A (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Apr 2022 04:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231827AbiD0I47 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Apr 2022 04:56:59 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDF41C24B4
        for <linux-block@vger.kernel.org>; Wed, 27 Apr 2022 01:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1651049624; x=1682585624;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XwCr4orU7l9P+PK/JlKycfHawvfyb/PLgrgGTtph11I=;
  b=TpwYvUGp7u3A2X0OMiJZa4Ao4AKkLX9nW6YmglRibv+2hkXDd2M2kG3C
   y5xhFmA1BxngMUclsof80OjAlumXTLj5b9JGLUip89Dpqep5XrseK2jT7
   c7u6hIdX4eMMtS6NL2/5EbqJ/e4gjrgSxm2HIbkQ/RBYOzEvuosAsJE3j
   0nuaRpaPKc5vli+pD9huNQiy0Qo9Y+dcwbF3tpThaDkBKdPul4wtWoS23
   SkUK3HOPNbfziorJfMHcPQ2LSq7G48SdxaXj2GUKRiaeZnn9ouWGqtINF
   xmmGiHxsQmOpXhFeFVg2hzTAV2uNMbOUslR7vrVTzF4TkPbt2wybVxigd
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,292,1643644800"; 
   d="scan'208";a="310910491"
Received: from mail-bn8nam08lp2044.outbound.protection.outlook.com (HELO NAM04-BN8-obe.outbound.protection.outlook.com) ([104.47.74.44])
  by ob1.hgst.iphmx.com with ESMTP; 27 Apr 2022 16:53:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdiZRdpl6CBRglmYWMOH0eSERlMVXKTeMPeLabza6Zwzy8LYMZu+nN2c4NSH/oiUgLnYGWtSriNLyNHxTcADALkS3s1uG/xS8ZVdH6FOp0xpRGXeTHWdDrNQwiqVToV1u9LU243x9WCMu+d7vv/DXYwcDMApbqWWi99e2aoA/yvcKj0lCCkYFPWxv7ECJGR1iTRYtsbexSv2RdxcpPhACDzdqylRLdc6V3t3339Ook7+6RI1bKAAPkHRwMoys1x+R6yKfWaapEp4CM78BQyGCPeFxKF0QBpxRy9i42fqYfmRWWwJ4dM330USGMfioQX2yY61afjrrZ7Pk/BamlpMsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YWvuzgoZ+w+7bntqCvvI6rjfB1vtb+3fRB50PIhuZXM=;
 b=YT5f7qpwlp5qFB4CUQq9rjRCPTnfSWuEUU46SYMCsdOHSmPATmQBRKinopykCTFzBgi1lyyrGEjgndIfKTdJBlGo9VbU/zC0MvVcgVqhJtbUeI4+dVRKa8+kjEIxTNnlWj7rx/wcH8CZMkSdHgHsqoX/+2ROHl7ORUt8m+oAkyiedvxPGNbXkV1Wo/qdsuTp7N/VnyiOTkSNyLFs/vP8CMEdNM99cKk3hjbC2zzBh+L3RpgU1t4kXMqJI+0Baw8WiTnXceC5fRAOU+RPeMwNabTmk6YOZvoGfqXSSmsHtFIRwOlKCg5spb2LW4qYAgB8aNJaiuLbgm98psfqAMvIbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YWvuzgoZ+w+7bntqCvvI6rjfB1vtb+3fRB50PIhuZXM=;
 b=i9qgPMA1MBQ9kwEgNmnr6IEmuAi3n2MgJ1zmi/3jMyXpBvFRa0NWF5OuUdeNuhxwCH2IbKjMqJKIFUIxOmCFPdYLkPvUJSwsT7ciRyIZL1KZ9UxQG9AYsCBqxhW7W3kQhRqYRaX8VyhrWuijyQMNNZjlTAtOvsvKx+XAOYA8Mak=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SN4PR04MB8319.namprd04.prod.outlook.com (2603:10b6:806:1ea::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Wed, 27 Apr 2022 08:53:40 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2839:2ab4:7871:416e]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2839:2ab4:7871:416e%8]) with mapi id 15.20.5186.021; Wed, 27 Apr 2022
 08:53:40 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Klaus Jensen <its@irrelevant.dk>
CC:     Luis Chamberlain <mcgrof@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Adam Manzanares <a.manzanares@samsung.com>
Subject: Re: blktests with zbd/006 ZNS triggers a possible false positive RCU
 stall
Thread-Topic: blktests with zbd/006 ZNS triggers a possible false positive RCU
 stall
Thread-Index: AQHYUEtZsx+sXkXjFUmYoV9Oexcksaz4VZuAgAJdDoCACJZlgIAAKsgAgAAUJoA=
Date:   Wed, 27 Apr 2022 08:53:40 +0000
Message-ID: <20220427085339.xbge32fzwjcf2dl5@shindev>
References: <YliZ9M6QWISXvhAJ@bombadil.infradead.org>
 <20220420055429.t5ni7yah4p4yxgsq@shindev>
 <YmGbo5Pvv9bOMqmt@bombadil.infradead.org>
 <20220427050825.rkn633nevijh3ux5@shindev> <YmjzrLo0/zW3Ou03@apples>
In-Reply-To: <YmjzrLo0/zW3Ou03@apples>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f8c7d480-4bc4-49e5-2888-08da282b6d34
x-ms-traffictypediagnostic: SN4PR04MB8319:EE_
x-microsoft-antispam-prvs: <SN4PR04MB83199F63341779E0FF7EFF0AEDFA9@SN4PR04MB8319.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jZcmO4eIwGg/0iRRxo2ck/lUfKQENwBPbrRuSnG7L+qyt2C0gn90bSGMO3Mswu+gN+M8r4qKJA54+ZGQw3XNM0NqA5UatwsxK3cwPQMmEiNUptXIedwQQIsXCbP7RelbcOBWEyVXSnMUmhvq9mNpoUFdltOzeWC/gmOwMTSnAYWGk6sCHriuw5/Lj2DCs2CPHTRPic2KgsXGu65Qkr6L9bLBGv1yiZ1ZVQytnTfL2xnMGcTvWq9HmT63P2a1MrM33v2Ln2iRM7HMok4GihUYLRDM8df7vyYbLeSgsKBZJv5rZl22pmwfp1QWohGN9jNXrYD/SAwgdAIq+PEYF4zj5VYmrG/MWauiDV0L+bQvlAcp6c6luMpakdlLGgFC6xQVqxAkqPDar6+5CeFFKR9hXI26zLofsfk/0Kjjzj8yyRlkvVbKmRJAlFEJN9e6iH+lqbjFMe+CA6QDy85Z69qBWJwFnIclknXakoFbw5Y/rf8bv/9MYL2Bceg1LUQU12zawDp10wkmx5kCG7JWLJ/fmSXlTl6ZbYcPhJzrtGN9SxNHDcyDVvBlBE1SZo9z1ZO3xPxQSr3w4zkDczSRRgki1CPEhPYAO8Vubqkgm9KF7ejPOUIOUYwNE75sWiGsSBDwMG+treL0X6SNMRJ0lERl/07i8kVr+krNFqMoAzadKmmXC0AqpZXTm81CYew8hep+Y6DLDxRosSw1gx96FxMEjZyiuzwJ9/rJ07IvspVeZkk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(6506007)(38100700002)(38070700005)(26005)(71200400001)(8676002)(4326008)(66446008)(66556008)(64756008)(66476007)(316002)(91956017)(76116006)(66946007)(122000001)(6916009)(54906003)(82960400001)(6486002)(2906002)(33716001)(9686003)(186003)(86362001)(8936002)(83380400001)(1076003)(44832011)(6512007)(508600001)(5660300002)(21314003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6ROm5HOba4IsvjqZmBB70KMI4fzpdJAAfOiSXcZgcqu/ZxzO4pn+wHJZU0Pi?=
 =?us-ascii?Q?KOqIiBYWbXpQ3Ia/bLCxsQEafNoq1VZcYpkUxg1Ka3L9luPE7SGFVjX3PeLd?=
 =?us-ascii?Q?CHdvZeZhc2GBsvYhw83TxEABZQlvg2UbHVfAK0Uuh6mTYzlkWP6EJ0Sal3XB?=
 =?us-ascii?Q?tYAPyPOqNic4jbJtF/KO7/QAQCa8v656EUcuZrJXphyf5sPY6P1a3Cn2Un21?=
 =?us-ascii?Q?FdEN5NedJvq0Yuw/e9I+T5ucOLX6gFzCzQdc09JTwHTbAiDawZUZ7mxG8uFD?=
 =?us-ascii?Q?cxWTnp5GfUmFx0/OTIeu51ILEWGEz8wLY4rLGX+VW6+eybdD55xs89Ty61gp?=
 =?us-ascii?Q?4WYpwsTli+o//v5nmzl2eyagpOVRxd4AOxYe1z0l/oqioDaQF9vDKreP4PjD?=
 =?us-ascii?Q?tCxgToGDMOX6XsuVVPx3lks4GV+D8Y/LSxMIIPL+zIzaMN5hKUfQcY/g7eTP?=
 =?us-ascii?Q?XLMbldWgTModtjt0qo0fpOH/pr5UCuPZ3pRIgmoqM8XsiEqe6gD7qITtaJTZ?=
 =?us-ascii?Q?JhyctVRISClAFM6Hr2btaL4B75J2uSv7nYoikhYJRedIKWlZhkvhaHI1CzFY?=
 =?us-ascii?Q?0wgYfEDcVbT59r5UvMA/KE5jsMZW4qsjWy0mm9AIFZMWAC/sEtWlHPleBR/B?=
 =?us-ascii?Q?/K3qVNBJdv4Fkin76gKNxXQFwUEUvZn4QxpOvHRA6EBqmVzxQ7ESPJJr5Vi1?=
 =?us-ascii?Q?wqBKO0eteoyJkeAFunKK3ZOUv7cHNTOKIOoVP/ZhPk4Pz2vH1hZHqct9eyr9?=
 =?us-ascii?Q?82Q2t+xLyHXrRx04Ea/WcDoMf6IuUFxgMao8pQjXEwE/qTETykr+AdjIky6c?=
 =?us-ascii?Q?4EMgvE2qxdORu8lS4iJTLqCdIlzaFt/RCB6lqAPAOecOAztvXknbBL37c9mY?=
 =?us-ascii?Q?a1tSWXQmtdRMP34mhv9xPvNL9Ro18OR1j3Z4EykLBkKhxWw8TeDwdaBNIUWd?=
 =?us-ascii?Q?HIMTIU6M7S2BdrkZsi04/ZRH2pZ8IaC8zJqQ/0BtA+C6MM+6Uxf7NHHTZDni?=
 =?us-ascii?Q?ZQopTlI9HMebvO+yWJrZkWvREnbIXh3VTTiusNmMiL485o8wpRK4sm5N3F9m?=
 =?us-ascii?Q?02Dse96zcPFNZzksgPTiBsnk8aUHfht5hJiGi8OJ6jv71GCtdxrkWdNEDDsa?=
 =?us-ascii?Q?NBpoi3THvj1evO9UuSamjKipiUsf/FVAUnMfJsQhureyClRQzdgtFBpBpxe2?=
 =?us-ascii?Q?r8iMiMJny7nkAOmLiL9VbVtYMrzA+2UcaEdieh2NXyssoIWjkAK9CQxSv+95?=
 =?us-ascii?Q?r7O78f/D93r8+YIEkRf+Zl954XRZ8kp6kor+lpelrBAWXDwaz9WjH0AThU9D?=
 =?us-ascii?Q?8NEp9tZ7QsVjoov4DlhjS+O/7fHpFQj+mgwAw4ssBcZn+MysZTDRwSakPE4y?=
 =?us-ascii?Q?w1+m8xpB0vkXl9Cub39xWLHEnXylw5DWWypxm8D33aJ2UMQLfe/aArFReb/J?=
 =?us-ascii?Q?tUXGgq23Nhdw8YUtl9jwjkqiHPanCEgtPptJ25qX1vMntKUIzZbmDeuRFZEY?=
 =?us-ascii?Q?bfDDsMl+YpHILUGgCRp5eOrNOM9lre3pZe81BZcB7iy8roj58TWuFVf5fNKX?=
 =?us-ascii?Q?X4o6l/lDbgLlrgrxMV5LG7FlUL8teaec+yUIjiBQK81XrzNRsPyApOv5dJMb?=
 =?us-ascii?Q?0LnAhdZXa8XcT4w0diZfHhsA7UdoAoH2U7gz3RVSW7N1TaSepSuBKHzflWoU?=
 =?us-ascii?Q?btye3Ogv3WMRIyMSwtELnrDdX0LE6LCzgANCl+fd7r8LvxvE4pnkvvQbArNg?=
 =?us-ascii?Q?7zZJXkckQfiMx4sZpEi9XX3aJgGxTXKthKw630Zk8SId2uBiyi2e?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8349D844759C444697562414385E3C65@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8c7d480-4bc4-49e5-2888-08da282b6d34
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 08:53:40.6718
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YIs+5FyrtLjOzlkPrC7z3p5w3JvIADUEHp95xb8RaIJu5REO6lRJyb017t9i3vdCDAPHWemvgy7Xx+rhietH3V1QHbtdP06+9G3TGblHQn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR04MB8319
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Apr 27, 2022 / 09:41, Klaus Jensen wrote:
> On Apr 27 05:08, Shinichiro Kawasaki wrote:
> > On Apr 21, 2022 / 11:00, Luis Chamberlain wrote:
> > > On Wed, Apr 20, 2022 at 05:54:29AM +0000, Shinichiro Kawasaki wrote:
> > > > On Apr 14, 2022 / 15:02, Luis Chamberlain wrote:
> > > > > Hey folks,
> > > > >=20
> > > > > While enhancing kdevops [0] to embrace automation of testing with
> > > > > blktests for ZNS I ended up spotting a possible false positive RC=
U stall
> > > > > when running zbd/006 after zbd/005. The curious thing though is t=
hat
> > > > > this possible RCU stall is only possible when using the qemu
> > > > > ZNS drive, not when using nbd. In so far as kdevops is concerned
> > > > > it creates ZNS drives for you when you enable the config option
> > > > > CONFIG_QEMU_ENABLE_NVME_ZNS=3Dy. So picking any of the ZNS drives
> > > > > suffices. When configuring blktests you can just enable the zbd
> > > > > guest, so only a pair of guests are reated the zbd guest and the
> > > > > respective development guest, zbd-dev guest. When using
> > > > > CONFIG_KDEVOPS_HOSTS_PREFIX=3D"linux517" this means you end up wi=
th
> > > > > just two guests:
> > > > >=20
> > > > >   * linux517-blktests-zbd
> > > > >   * linux517-blktests-zbd-dev
> > > > >=20
> > > > > The RCU stall can be triggered easily as follows:
> > > > >=20
> > > > > make menuconfig # make sure to enable CONFIG_QEMU_ENABLE_NVME_ZNS=
=3Dy and blktests
> > > > > make
> > > > > make bringup # bring up guests
> > > > > make linux # build and boot into v5.17-rc7
> > > > > make blktests # build and install blktests
> > > > >=20
> > > > > Now let's ssh to the guest while leaving a console attached
> > > > > with `sudo virsh vagrant_linux517-blktests-zbd` in a window:
> > > > >=20
> > > > > ssh linux517-blktests-zbd
> > > > > sudo su -
> > > > > cd /usr/local/blktests
> > > > > export TEST_DEVS=3D/dev/nvme9n1
> > > > > i=3D0; while true; do ./check zbd/005 zbd/006; if [[ $? -ne 0 ]];=
 then echo "BAD at $i"; break; else echo GOOOD $i ; fi; let i=3D$i+1; done;
> > > > >=20
> > > > > The above should never fail, but you should eventually see an RCU
> > > > > stall candidate on the console. The full details can be observed =
on the
> > > > > gist [1] but for completeness I list some of it below. It may be =
a false
> > > > > positive at this point, not sure.
> > > > >=20
> > > > > [493272.711271] run blktests zbd/005 at 2022-04-14 20:03:22
> > > > > [493305.769531] run blktests zbd/006 at 2022-04-14 20:03:55
> > > > > [493336.979482] nvme nvme9: I/O 192 QID 5 timeout, aborting
> > > > > [493336.981666] nvme nvme9: Abort status: 0x0
> > > > > [493367.699440] nvme nvme9: I/O 192 QID 5 timeout, reset controll=
er
> > > > > [493388.819341] rcu: INFO: rcu_preempt detected stalls on CPUs/ta=
sks:
> > > >=20
> > > > Hello Luis,
> > > >=20
> > > > I run blktests zbd group on several QEMU ZNS emulation devices for =
every rcX
> > > > kernel releases. But, I have not ever observed the symptom above. N=
ow I'm
> > > > repeating zbd/005 and zbd/006 using v5.18-rc3 and a QEMU ZNS device=
, and do
> > > > not observe the symptom so far, after 400 times repeat.
> > >=20
> > > Did you try v5.17-rc7 ?
> >=20
> > I hadn't tried it. Then I tried v5.17-rc7 and observed the same symptom=
.
> >=20
> > >=20
> > > > I would like to run the test using same ZNS set up as yours. Can yo=
u share how
> > > > your ZNS device is set up? I would like to know device size and QEM=
U -device
> > > > options, such as zoned.zone_size or zoned.max_active.
> > >=20
> > > It is as easy as the above make commands, and follow up login command=
s.
> >=20
> > I managed to run kdevops on my machine, and saw the I/O timeout and abo=
rt
> > messages. Using similar QEMU ZNS set up as kdevops, the messages were r=
ecreated
> > in my test environment also (the reset controller message and RCU releg=
ated
> > error were not observed).
> >=20
>=20
> Can you extract the relevant part of the QEMU parameters? I tried to
> reproduce this, but could not with a 10G, neither with discard=3Don or
> off, qcow2 or raw.

Sure, the QEMU options I used for the ZNS drive were as follows:

-device nvme,id=3Dnvme6,serial=3DXXX,logical_block_size=3D4096,physical_blo=
ck_size=3D4096 \
-drive file=3DYYY.img,id=3DZZZ,format=3Draw,if=3Dnone \
-device nvme-ns,drive=3DZZZ,bus=3Dnvme6,nsid=3D1,zoned=3Dtrue,zoned.max_ope=
n=3D0,zoned.max_active=3D0,zoned.zone_size=3D134217728,zoned.zone_capacity=
=3D0

I prepared the QEMU ZNS image file in raw format on ext4 filesystem.

# qemu-img create -f raw YYY.img 10240M

>=20
> > [  214.134083][ T1028] run blktests zbd/005 at 2022-04-22 21:29:54
> > [  246.383978][ T1142] run blktests zbd/006 at 2022-04-22 21:30:26
> > [  276.784284][  T386] nvme nvme6: I/O 494 QID 4 timeout, aborting
> > [  276.788391][    C0] nvme nvme6: Abort status: 0x0
> >=20
> > The conditions to recreate the I/O timeout error are as follows:
> >=20
> > - Larger size of QEMU ZNS drive (10GB)
> >     - I use QEMU ZNS drives with 1GB size for my test runs. With this s=
maller
> >       size, the I/O timeout is not observed.
> >=20
> > - Issue zone reset command for all zones (with 'blkzone reset' command)=
 just
> >   after zbd/005 completion to the drive.
> >     - The test case zbd/006 calls the zone reset command. It's enough t=
o repeat
> >       zbd/005 and zone reset command to recreate the I/O timeout.
> >     - When 10 seconds sleep is added between zbd/005 run and zone reset=
 command,
> >       the I/O timeout was not observed.
> >     - The data write pattern of zbd/005 looks important. Simple dd comm=
and to
> >       fill the device before 'blkzone reset' did not recreate the I/O t=
imeout.
> >=20
> > I dug into QEMU code and found that it takes long time to complete zone=
 reset
> > command with all zones flag. It takes more than 30 seconds and looks tr=
iggering
> > the I/O timeout in the block layer. The QEMU calls fallocate punch hole=
 to the
> > backend file for each zone, so that data of each zone is zero cleared. =
Each
> > fallocate call is quick but between the calls, 0.7 second delay was obs=
erved
> > often. I guess some fsync or fdatasync operation would be running and c=
ausing
> > the delay.
> >=20
>=20
> QEMU uses a write zeroes for zone reset. This is because of the
> requirement that block in empty zones must be considered deallocated.
>=20
> When the drive is configured with `discard=3Don`, these write zeroes
> *should* turn into discards. However, I also tested with discard=3Doff an=
d
> I could not reproduce it.

I took a look in the QEMU code, and found that that discard=3Don/off option
affects BDRV_O_UNMAP flag which is referred in bdrv_co_pwrite_zeroes().
However, it looks that the reset zone path does not hit this function. Inst=
ead,
bdrv_co_pwritev_part() is in the call path. So, the discard option does not
affect the reset zone I/O timeout, probably.

>=20
> It might make sense to force QEMU to use a discard for zone reset in all
> cases, and then change the reported DLFEAT appropriately, since we
> cannot guarantee zeroes then.
>=20
> > In other words, QEMU ZNS zone reset for all zones is so slow depending =
on the
> > ZNS drive's size and status. Performance improvement of zone reset is d=
esired in
> > QEMU. I will seek for the chance to work on it.
> >=20
>=20
> Currently, each zone is a separate discard/write zero call. It would be
> fair to special case all zones and do it in much larger chunks.

Yes, this looks the correct fix approach.

BTW, it would be the better to move this discussion from linux-block list t=
o
qemu-devel list :)

--=20
Best Regards,
Shin'ichiro Kawasaki=
