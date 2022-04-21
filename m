Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DEDDC433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Apr 2022 12:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbiDUMHs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Apr 2022 08:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382985AbiDUMHr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Apr 2022 08:07:47 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 401A0117E
        for <linux-block@vger.kernel.org>; Thu, 21 Apr 2022 05:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650542695; x=1682078695;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3k/6/RYH8cObOpF0FW7eHOaKej4BZMrikRy04GH1894=;
  b=DwQkXjZp0UBxHIgNx3FXn8SkVi8/BGCeWpuUz90RhIA5/OC0/q2YXsMb
   Lw8EFdNIWJWA2O3ma4BoXuPi2354Cr/A+mrZM9wkubLrN3CXX/tM3It0J
   05kS8Hkypy/MELvBcW2A85rHbcxg9ZKcNw3G/m+mWW27JuOzw+V3nDXGr
   DmjgUUNEZvd9xkEAjKfygKM/5ilREJkiiAv3RM9pheY642OvjW1fB+DqN
   zcnOFVR1HY7LY8iyoCJyGRjd04TUsAHXG0j/H74Robaqahwri4MdeuSGp
   n5uqlFX4IAR2AdG81lgpol0WcutvaNcDS9s+tYJBTmbAuC2r7T68o5wYA
   g==;
X-IronPort-AV: E=Sophos;i="5.90,278,1643644800"; 
   d="scan'208";a="198463140"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hgst.iphmx.com with ESMTP; 21 Apr 2022 20:04:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fZsegZqzI3rSae7+JjIuBx7Zm0kEvPeftYN5AB8AO8ANNkkm8qNtLZr937ywQBLa/oiG9OT5QKIB3z1E/GZuchF3bD/wEdLtg1o4TJASQ41AII3ON9BZ7hBbcLlQDx4rgboRUHrYv2xgVV/YhGCHvWhjqB8Qs7teJTf1PNHKLaC/zCLXUD1MtrYSlwqTYELwH/mYx0pNAFWQAM1IGiAZsqiP0knV+O2mNlThXMFjhan/J/Nw15OOoKdJ+6Dr63c17GGKGX3JPxb9DsQq98uE8zBkudhDTgKFzzrnuXftQlbBNw8Aj54Dw7xtaGpB+wWPy5KJYxbn6VwDU/Njygryeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ug+iPVcDR05mLxDu7FZRahGWX6Y6bpkuBHAGNDB/6nE=;
 b=bUHL4B5aAiqPK+240yD0lAs1nh7JDAgyln5nTiSRMIIufBileV1GybRZ+ZS9Bl7Z413grMBDLYoBHOrtBHpb0AIanSHtkCdj5TiIn37+/QmPZ8bQNOlxRfF2o5wz0HlJo0N2Kj1I7VT/868tpFenGsVuJHoFlUqvH9g8FZUvebOeA4U6B+EZVxhzc1L0J389+5lYXWE68Di5yTuWdibPq8/J8JPdANrwluhLrmJmrhSdxqiVchy8j5hSNMaUSmlz4m+3JeTQ3+xklT62fFTRFllQNp/Ey1VMpFyOBAEe7jSA2K7JarQ3/hy342Mw63oaoZWOJ1WRJ2NKrJtO0Eqmkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ug+iPVcDR05mLxDu7FZRahGWX6Y6bpkuBHAGNDB/6nE=;
 b=RzKXzoV5VhQ+T6gJhSOPBGmb7aIdGMyUjUpTXQ/pkqXVq1Cvd1VrIkrtEA1DGWqiZkmgvWVG6Fj4Tstr1dIsRCZZbN9PuKdPb9NPopQQocOM0IpPKW66+MsYTmumced6I2mp8MlJPQysbwpuBdsbdTFkx/msbxuzQJ8Nr3zfJr0=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MWHPR04MB0911.namprd04.prod.outlook.com (2603:10b6:301:40::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Thu, 21 Apr 2022 12:04:54 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2839:2ab4:7871:416e]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::2839:2ab4:7871:416e%8]) with mapi id 15.20.5186.015; Thu, 21 Apr 2022
 12:04:54 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Omar Sandoval <osandov@osandov.com>,
        Omar Sandoval <osandov@fb.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH blktests] block/002: delay debugfs directory check
Thread-Topic: [PATCH blktests] block/002: delay debugfs directory check
Thread-Index: AQHYVHNmSGa1G2Gr0kCPcyfebm6VRaz4iqaAgAA0kYCAACgWAIAAlhCAgACQJICAADmdAA==
Date:   Thu, 21 Apr 2022 12:04:54 +0000
Message-ID: <20220421120454.5qwzxh2gsoyjoygs@shindev>
References: <20220420045911.914393-1-shinichiro.kawasaki@wdc.com>
 <Yl/TjWYle8mOOwlO@T590> <20220420124213.5wc4umnjrlvu6zbi@shindev>
 <YmAhRtOnezJ2EwBl@T590> <20220421000247.lrwqgzolwpbeuwow@shindev>
 <YmEYEYdO4SkNv0lc@T590>
In-Reply-To: <YmEYEYdO4SkNv0lc@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c640b61b-8c20-4184-4b07-08da238f25d4
x-ms-traffictypediagnostic: MWHPR04MB0911:EE_
x-microsoft-antispam-prvs: <MWHPR04MB0911050346AB500568C4AC39EDF49@MWHPR04MB0911.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rrdxqmjv+4/o6nQXqhLUxTrH6pcEVOeJeDFhB2vXKSkEoeo4jOBDuGKAtbhWotoXIPh1VoLxj3vVWjBFB94jtzugLW8nAjD6y1aferKncMAV0HjeAj57Pl53yvmWE9yLvbrZQAZWcPfXcv5hah1NFpgpLp9u8nTjt7tgcQPF0etv8jQvxjeRTGHNEJDHYFHpiOhGy3E8AxDzjmOVr7Rp4M2NPMaI3ROX1Yq9h2ikSVKqmMOg5ATZ4vwWGS86/Las8ssHIghjfSf9ejxzevOUhReAHuXRQC1X0k4WRh/ZdMLdlLaTueXHXVeDBf6aR0J0zmqkq4rp4ka2megqw9/vnGcVQA09VRP4bEiemFSbNcThnbCbsc2+GH/27u/czD417Azhd/A505fiiNtn0a1H/x/S5OvwXCWFIAW8oPoVOG7RG69sT8npPgdLbs/etwkOmD/iCCZFVHMsrNIiF06ULEJNNDhjV89nWbHGXCHPfr1l6yT/L3scvVkI8JiPI2Rmro/hDT4oair8gaJKh8ZGsPtPEsXfVKxkP65iTPbumpourHmEv4Or+BkrGDa4ws5BhPT2KvJ18ccEBIJw0ekrLj/gf5rMnz2qjLpU/5ACQOBqmKKSjmoY45xsD4j34zqE1sWch2eoAnjq0eVt7gzPpavNC/yUkeYbkLKhHMEP8dzFM0ve5KaxK8q+WA+rhIpQz2+sf2P+UWDfN5OAHS6SZvoMYhIJ2hc3QBgsJufVSC0uxAdwdVR6O/RM5NIdwOnqPoDjHJzYo4Lx4SDQlXN2UOxWz5m5hc6wlxkqulWYu7zZsq19fWGVOQ5opAtL3eYNmfudlTRQBspElI2kWRWytA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(33716001)(86362001)(82960400001)(122000001)(38070700005)(38100700002)(6486002)(966005)(5660300002)(508600001)(8936002)(2906002)(44832011)(71200400001)(316002)(6916009)(54906003)(76116006)(91956017)(66946007)(4326008)(8676002)(64756008)(66446008)(66476007)(66556008)(186003)(83380400001)(6506007)(1076003)(9686003)(6512007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5u00C4gj8OUEC9QgCXUgQNO4Zpr18HWsyNzyVyjnuGSzjwaG1O2UeGQ7N3ik?=
 =?us-ascii?Q?EaiVmWCm3ibZARjLFe601pSNNTIU/nuZgu3BYYwPsaLUPg1UK2tg/9dLTbvz?=
 =?us-ascii?Q?A0F70bYsUqAYwWpUvpw9O+N8+lnQ6xoUypGSh+xE02Pw0+yzw/bOwgcU/uxx?=
 =?us-ascii?Q?Tm3zfer6SvahypsaceXdzu4dGUj2iTX4vb5w4xCTwSVuOwmGqXPYbxVwET2t?=
 =?us-ascii?Q?OkcCjat6oY9FumM0cDL2SIFGFeXsdkaQ5dYaR6aZeSSNxXZ/xd0HsQhzgh2G?=
 =?us-ascii?Q?aesd3Qimu0Ogam8Sx1MQMMj1ysRgMWk6edD5EH5Q7KdQTsg6NIE59LOVtv+N?=
 =?us-ascii?Q?5cBOamvFIQziBBIdl7PpyfoDfcwM6L5U2ywRTrAVy7kAzZHtmHcoY12YA5Wn?=
 =?us-ascii?Q?UuQdgOeaHn0QvJsoQOrJeefRxyUzhXyRpXqPvszAY3h/dFnmvW0JUuJN3pNZ?=
 =?us-ascii?Q?KMc6DY3qdMyAxJujI7AB2Kior0tgSlJSYTDSwkljHndHaS4b1MZB0yc9GnGA?=
 =?us-ascii?Q?bypcOTW8y7xQF4uvwtbanBcARgyI50TjMqjY90z65sOzuc143fx40wzUGdSq?=
 =?us-ascii?Q?x1olZ2gLSanQHzyrPFu/rU/3mOP9hYAlY6r+G17P9XtR5m88OC8nGCHZPjDQ?=
 =?us-ascii?Q?JMwnsLklcnxp0D3AzqhJWKIZUCk7Xo+EzgmqgxGIM3Rtk8XtETG74OERCQiU?=
 =?us-ascii?Q?uWTnVx/GYCQHkZjRa6ZjCJ3w6sbIwvgilvgKHGU1R7HDbTnC7WWV5mdkkjl9?=
 =?us-ascii?Q?bPGOYNzvRwjWfJ3oOnwjoof/y4i28D2dxVMcrlNd6FhAkXtgCfx4fSpbLs1H?=
 =?us-ascii?Q?RfNztKFCsSyTvSWkBLeMMuqsKqXMmEB1KOX5uQRMlBVyKcDb4PWobsPI3JmZ?=
 =?us-ascii?Q?3X8FEZDxE+aahrl0JBxCSSipYuQouy0jzQEt13Wh6upp0WIXjajsE2zKQwmT?=
 =?us-ascii?Q?MpMnQ7XCBwIxBoKIszGklvBGj6M+ptSOXdkHEu3M5+58n/JAZva+johUdI4Y?=
 =?us-ascii?Q?hlPUBDh5Z7f81ypEVmI+1BB+CXWyBJjMPpiDDyq2nbb5yfRXG/UV7vllkBWS?=
 =?us-ascii?Q?4tCdCbvW9UqDEf+ZfEDxP61PjwBVnIbwoavEcJ5kkrI7hfVKorkgsQv75Qe4?=
 =?us-ascii?Q?+OCiH7z9cTZ/Tcums5QwRPypb9igh5F6Xu+RAR/BpUcyCQNfjiDQu3unmLgx?=
 =?us-ascii?Q?8+wBj1qwPlh2cXs3gx1VJISPropS47+uBGYo12OVREwvGcPBhehlxXUzjzMS?=
 =?us-ascii?Q?z+CdBpFYdj2rc7E7czYKsvNErYJuMsRCsSYAGSrzu7ZHoQGO/N118v5IU++u?=
 =?us-ascii?Q?NSkjCA0d05IwHhEGk0rNg+W8BRUyxtjOp5t7QapAl509YDLhlmUQCy60yLs6?=
 =?us-ascii?Q?xfQV+TQdfdNl64sv1ZunviTe4Cw84InkMg2CEPSNcql71s8IlkX2j8dtAm6Q?=
 =?us-ascii?Q?WrHhU8ggLiYJg8KiEEO3u12CyTHc6UhQymJEW4ii8tvQtrUoFbSdGnSy+T6K?=
 =?us-ascii?Q?WmW3knELoJBnJIp2IQPZEtmcFx2hlTNrQ+RYBPedZ3H+b/8qSNb+7EM7AkEz?=
 =?us-ascii?Q?Ot6PVdDNSqelFN6dEbDXiQb2PdsnTumTIT6FoiZ1d0sO/D2daYlY8xG04qGV?=
 =?us-ascii?Q?XgGrGmzxhOikN3H4nHN6LRQAIhXuSWtxjrL5O22Fvtno7Cwt+/Y7IPGZSEO8?=
 =?us-ascii?Q?LgzeiY15cnM80QP5SglQTcvVr+0MTc/QFq0SpnoGawVy+wY6q94ZgY5a+YkG?=
 =?us-ascii?Q?hellVBT6qlnACVJ/OWaXK8AoSRgZJLFjgNknkDDFR1ejVSqhKlpX?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7F49BE81DA047245B8E14B5E2CA01B46@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c640b61b-8c20-4184-4b07-08da238f25d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 12:04:54.8155
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HBGx7wewm8yyTxXZiD0GNqY58BR33WMISh0gtaEWXnSAsVLQp19kW4NGPyO97NF2R2z4AqG/ZY9Sqf1rljGXXrxNNHJUROIrlc3C1+mIjFQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR04MB0911
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Apr 21, 2022 / 16:38, Ming Lei wrote:
> On Thu, Apr 21, 2022 at 12:02:48AM +0000, Shinichiro Kawasaki wrote:
> > On Apr 20, 2022 / 23:05, Ming Lei wrote:
> > > On Wed, Apr 20, 2022 at 12:42:14PM +0000, Shinichiro Kawasaki wrote:
> > > > On Apr 20, 2022 / 17:34, Ming Lei wrote:
> > > > > On Wed, Apr 20, 2022 at 01:59:11PM +0900, Shin'ichiro Kawasaki wr=
ote:
> > > > > > The test case block/002 checks that device removal during blktr=
ace run
> > > > > > does not leak debugfs directory. The Linux kernel commit 0a9a25=
ca7843
> > > > > > ("block: let blkcg_gq grab request queue's refcnt") triggered f=
ailure of
> > > > > > the test case. The commit delayed queue release and debugfs dir=
ectory
> > > > > > removal then the test case checks directory existence too early=
. To
> > > > > > avoid this false-positive failure, delay the directory existenc=
e check.
> > > > > >=20
> > > > > > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.co=
m>
> > > > > > ---
> > > > > >  tests/block/002 | 1 +
> > > > > >  1 file changed, 1 insertion(+)
> > > > > >=20
> > > > > > diff --git a/tests/block/002 b/tests/block/002
> > > > > > index 9b183e7..8061c91 100755
> > > > > > --- a/tests/block/002
> > > > > > +++ b/tests/block/002
> > > > > > @@ -29,6 +29,7 @@ test() {
> > > > > >  		echo "debugfs directory deleted with blktrace active"
> > > > > >  	fi
> > > > > >  	{ kill $!; wait; } >/dev/null 2>/dev/null
> > > > > > +	sleep 0.5
> > > > > >  	if [[ -d /sys/kernel/debug/block/${SCSI_DEBUG_DEVICES[0]} ]];=
 then
> > > > > >  		echo "debugfs directory leaked"
> > > > > >  	fi
> > > > >=20
> > > > > Hello,
> > > > >=20
> > > > > Jens has merged Yu Kuai's fix[1], so I think it won't be triggere=
d now.
> > > > >=20
> > > > >=20
> > > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-b=
lock.git/commit/?h=3Dblock-5.18&id=3Da87c29e1a85e64b28445bb1e80505230bf2e3b=
4b
> > > >=20
> > > > Hi Ming, I applied the patch above on top of v5.18-rc3 and ran bloc=
k/002.
> > > > Unfortunately, it failed with a new symptom with KASAN use-after-fr=
ee [2]. I
> > > > ran block/002 with linux-block/block-5.18 branch tip with git hash =
a87c29e1a85e
> > > > and got the same KASAN uaf. Reverting the patch from the linux-bloc=
k/block-5.18
> > > > branch, the KASAN uaf disappears (Still block/002 fails). Regarding=
 block/002,
> > > > it looks the patch made the failure symptom worse.
> > >=20
> > > Hi Shinichiro,
> > >=20
> > > Looks Yu Kuai's patch has other problem, can you drop that patch and
> > > apply & test the attached patch?
> >=20
> > Sure. With the patch, kernel message is clean. But I still observe the =
test case
> > failure:
> >=20
> > block/002 (remove a device while running blktrace)           [failed]
> >     runtime  1.276s  ...  1.241s
> >     --- tests/block/002.out     2022-04-14 11:29:04.760295898 +0900
> >     +++ /home/shin/blktests/results/nodev/block/002.out.bad   2022-04-2=
1 08:40:01.776511887 +0900
> >     @@ -1,2 +1,3 @@
> >      Running block/002
> >     +debugfs directory deleted with blktrace active
> >      Test complete
>=20
> Hi Shinichiro,
>=20
> Thanks for your test, and the above issue has been addressed in the
> latest post:
>=20
> https://lore.kernel.org/linux-block/20220421083431.2917311-1-ming.lei@red=
hat.com/T/#u

Ming, I confirmed that your latest post is good, and provided Tested-by tag=
.
Then the change I posted for block/002 is not required. Good. Thanks again.

--=20
Best Regards,
Shin'ichiro Kawasaki=
