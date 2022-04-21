Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9068CC433F5
	for <linux-block@archiver.kernel.org>; Thu, 21 Apr 2022 00:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbiDUAFo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Apr 2022 20:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiDUAFn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Apr 2022 20:05:43 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A143B013
        for <linux-block@vger.kernel.org>; Wed, 20 Apr 2022 17:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1650499374; x=1682035374;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ANJBhzEgmi8rJnleKjciXNT0U5JjsneQQ8IwKRgvkw4=;
  b=B9ngJv3DOIKtoO2PXTlBpiciqSWen2lm567lsiQCozNHL+QPGO4b9pz3
   f6DSFQnaXy1+GfS6hPvdB7lAzLUyGOuhV1qAm8Z1JX3cLoWVdsUhmsQw6
   JKesz/X2i8PbxfmMNd2qv3X1kNssMi5nz0/Iz5s5JpC3dG9MSTmwf4w+l
   U8Dc20X7XlHkJFFwlLGwF0aG3pkvlRuFU5HdtDmGuiXEALYJ33w45d5lB
   q2OMH1KoWscD0B9mRhZUGaL2T3vP4KX3dUT31D286Y9GVTFE10FnrchnS
   6zq3aqXHhAutm43+u9OZQm9bS9YvSoxBwf9WY7+ZiQxrYIOkXBwUNepTq
   g==;
X-IronPort-AV: E=Sophos;i="5.90,277,1643644800"; 
   d="scan'208";a="198410221"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hgst.iphmx.com with ESMTP; 21 Apr 2022 08:02:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WDAcla4DvMjvtqnaJie3GQyLqyXVzlErXLGKui1l4SRvDJsXqSVwsw5Y/IGMjKWyCHYXKWnUYV8YPfATey5sOHabqryJNT9K2bd/ieJYO/KYbtyBkEQAhH3uCdq4qIwAbnvqCw6yI1+2qVeu2EpO3TL7nnQxp4TKGxx97bH10+6XS0ZhSUCTCIpPrLRzX8nDXia1/XCWadxIllvEcy80ji4yctV9xIKnxHltZi/QXVtrrOIQHUEthTramKYL1yfrup+rt8pZ+18njxRrXWPwrbSQm6ut45N3o424HAEZTS2m5v4VecCEND6MZpPUsiDDbrBYQWFggGO7MlQ1fnZULw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQYSYHThpnFNx7bq0QukqpCIe+9Vr15sx2HNckZj4Zc=;
 b=LnUORFVzGGurV+fIyGn4W0fgm2ddoCtxnpHC03cHKAiHv0Ns+CPciw5n32oDfME9n5TvZwL/7HI5JjP0GjWfCvdZNTxxBuWcU52KxTbrLbIcDtMRYOucCEWW0v6cwo225yVOiPouKjr4QYegmDlWAKDTcxP/B0vYmnTnYBDxYL8uCmDHqohdf748viSDe0opEFT+NW3NM3t5xO30EVBebm1RcGGTHEZ7vzSi2RVALKR95Aethr8zBfnx4wM6cQtihAaQnwOEVnfazBEcBUcw2vSOrqZ7TC1oPx98NpiNvn/B1AomqVIaRBrVCX9eH0XkOAWprKxE71dSB/DyaDBKIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gQYSYHThpnFNx7bq0QukqpCIe+9Vr15sx2HNckZj4Zc=;
 b=EcpoycJtXZbTplgCj6Y16zsc1g47jR+63jC+ZQjl+2RqyyGGVcQM4vy1LhzvMRur5bGWfZB2auFm1zLBtAknfQaWZJ3IDfJix/PInjazffX7HODP8GZtRz05G+Sm5oyz3JyTvqFVX0lXboUtAXLMBy9n7L03vbYJrV8cbrEF9Zw=
Received: from BN0PR04MB8048.namprd04.prod.outlook.com (2603:10b6:408:15f::17)
 by BL0PR04MB5155.namprd04.prod.outlook.com (2603:10b6:208:5d::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 21 Apr
 2022 00:02:48 +0000
Received: from BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::bc2a:d89f:8522:625f]) by BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::bc2a:d89f:8522:625f%4]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 00:02:48 +0000
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
Thread-Index: AQHYVHNmSGa1G2Gr0kCPcyfebm6VRaz4iqaAgAA0kYCAACgWAIAAlhCA
Date:   Thu, 21 Apr 2022 00:02:48 +0000
Message-ID: <20220421000247.lrwqgzolwpbeuwow@shindev>
References: <20220420045911.914393-1-shinichiro.kawasaki@wdc.com>
 <Yl/TjWYle8mOOwlO@T590> <20220420124213.5wc4umnjrlvu6zbi@shindev>
 <YmAhRtOnezJ2EwBl@T590>
In-Reply-To: <YmAhRtOnezJ2EwBl@T590>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6aa81e1e-9755-4e87-4a04-08da232a455c
x-ms-traffictypediagnostic: BL0PR04MB5155:EE_
x-microsoft-antispam-prvs: <BL0PR04MB515596A98899F875B208AAAFEDF49@BL0PR04MB5155.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aT/l72FMJHZQ6kKJqRBNGEyI1v5X0yQq2fBukvYe/V9Jhhm9Xwh5v3PRme2PdLNeBJ5FcJtruZ8k2Q6/PALwOxMg5fdV/oOehbfUCtUQIE/ui8LfE/a7/1Q3ec4PLku4DD6IYuAFBh0ZwHUBzVspT2888jmmWycJcIWEFdvqmzCaYyTDuRU5h+NIgFn64AmD/LefwKT9rffRdePxxEqc8mZ8bQNsOtVIKD8nl3vodcFTp4elGcKiTtqNuKsnEHW8RlFcYPjKScsu5vBz8R7xV4gPkYbA3CmCufg97OdvQc/Sr0Wat3cFgA/LGihn5GwOEjZdVvM5IQWofOojEPyu8uTf+c+u7mQo7Dgsln9TzV0IjQ+cgIYxecoboEIHO7LsH9ll2uMqIgObfpu73tX1tbUCCQ6sdEwD9tuwdrwRVgqLGOGbsSIIs3mEUUv02QgUstFPVxJxUaoMqc0e5i63noE4m3m09wDuwvwshU/4Kb0ymPmFUK/hMEARQRVTx8Q6r5Ww3HajJyB09CRQbuJJLEiS53hxe1kODhbSZnCzn6nsU2A7AxppknTQG+V904EPrVPk8R5XpdDiAapwOQH61hQza3f8g4xazquykSnB7RFZhiXYT4BODF0zHHmQ7MR0sPqGNi6/K0yo8DnAzRXefnX2wp2V3KcXE+HGU4QisOkxO85oQFbkCw3VFylTkHAQDnFTlFTyq5uM37/FX+VsJmU4mvJ1ndAQ2d93Ib3llavBFvcu0UuCE7zLHm6e63W+q/hTMff7ZBtHlOWsOekS5OSTW+RKWHBUOFB6cDodrvk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR04MB8048.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(33716001)(8676002)(86362001)(38070700005)(6486002)(5660300002)(966005)(508600001)(38100700002)(91956017)(8936002)(4326008)(71200400001)(64756008)(76116006)(66946007)(66556008)(66446008)(83380400001)(316002)(6916009)(54906003)(66476007)(6506007)(82960400001)(26005)(3716004)(9686003)(6512007)(122000001)(1076003)(186003)(2906002)(44832011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hLHJKhcV2S/bkw13nL31RJmsqai12mATNkIf24k+sYhH5Jnq6p0YPuDEFDx6?=
 =?us-ascii?Q?mUuybfmD3p26EZwlZbrnxdvvJ+wLcLoWg8/Snfovy8sy/r2SXXrsn8HFLjtC?=
 =?us-ascii?Q?nCZBUNJWekrbWy7VuWVhNTsaiNffgUjVJHb2/DYi3OTrckX5B8ZYU5csvzh2?=
 =?us-ascii?Q?rYJVclNbHtF5RGlA3K2yMD2umNgFpi0GwwpGeu8TCcRSs4r6VEI8UDD+H4uN?=
 =?us-ascii?Q?ic8IIFRJYSB1hcPTcRBtJI+88h2VuWvAKdknLfPDR4j5DXaOSqlnRV/wXVsm?=
 =?us-ascii?Q?AUwyHzcbj3NbyrOlbIxanhehmXH4dsUyN9CxuSEEakowyubH/voGyrKEstoY?=
 =?us-ascii?Q?nL+Ome1+STFF71R46sl3jqV61/NJNsRXYKMxKO23FMB6QWzmGlsfC3oSsh4W?=
 =?us-ascii?Q?QxtNaKAgz1VRnPzsocMErkdayuVwtyZKS4lPVt/i1qVqrfNNMjbPcg3BaxBG?=
 =?us-ascii?Q?ibZtf9bSgu0rJTcWEQ8QUGyqDJqILXUGyx6v+q8f62R7QwFC8TRkzVNFF3yC?=
 =?us-ascii?Q?fALCR+gFZG25j6dB/2HuDoUmOpm6OxvJL4x1bXzTk4buTCLCRONQbGzJ2Iwy?=
 =?us-ascii?Q?0lhDwfJeQz7XyPJkVYMGfVWHCOlB/SPr5Yqj/vHDYih0ZlHH93NrpjFfbMLe?=
 =?us-ascii?Q?UnQ4Ctc6PpHzh4YHvi/capWeCD2qt9iKljBb67t0n8VbvTdfJO6xH8nWwKtL?=
 =?us-ascii?Q?r265fa7FhYySBwpgjLFwXHcWwlUM2WXrfl3Scu31Z8pdj1Lff7b8WjsoWgXE?=
 =?us-ascii?Q?saNXo2zPbE3EeXZ3pBh11pD+N9RITQTneKwAkC+oryfUzOvtZ5B8BnKBy92S?=
 =?us-ascii?Q?U341sol26afCxjnFcnsbxgEBlemzYeJZ7wiVQ4qjIM0q3gNxR0rGx1lNcdcp?=
 =?us-ascii?Q?xlSlRS/Pyx7qH+Sisnt69psVwUVilrMDRcxZyJXmwRbQ8LN9HRu8GcLg1m37?=
 =?us-ascii?Q?dE0ZJLiGS2Fr3AdFJWuyz0m6T9XPjFcKXE/naL7rpvaE1VheruYMJJz7PQcc?=
 =?us-ascii?Q?d2zhh9k/zxbaZ/UYhIaea906/SklWgrlzyye7sxqS4+wo3AAh/fAyfDFxiFT?=
 =?us-ascii?Q?zKM2cIfZMcMDPsqE+WzzoyoCRw9HLKEv6xqpcJcleBrEHbEc6rt18UtKJbyB?=
 =?us-ascii?Q?ufCsvdqWFzAQkiB5pKxICA2x47warWxk9Xdo/CVz4KykGKfL5kW/RZhduxOF?=
 =?us-ascii?Q?qhe08xeNDa9istRIw5DuAorgW2EW9jaLRwJItZX0/II2G5PLnpFPJz9Fuf/H?=
 =?us-ascii?Q?oDlhgDG/oFAJsdlFo9kybp6F+iU+NK+Mfd1i2DbEh6S9MyqBXyxAss3wVM7h?=
 =?us-ascii?Q?91nsGyZAgfbx6iFE4zRWfPwWW2/so8hkJKPyDhD+tgExn5ZIeFO6menfgz7w?=
 =?us-ascii?Q?8z0MEMEx8rdCynbor4xnbbMMYs/dk0V5G7b6UmCQn7HOWW5d3g63SLC9JRC0?=
 =?us-ascii?Q?XbPxB6XHi+4KCOp1/fMM9c3Q13RZAF0mzwhdpj1vs3vbbpaB6CfKxShcjiWP?=
 =?us-ascii?Q?bu61+KqJsKBKuZ3mr5VjsGfwXA5e46sf3soHEYPb1OCyyzxSQxbN6QixWZZI?=
 =?us-ascii?Q?nzT1KCYK5DRxvR8zWXldwpYkewFDONvf4JxbCRxjE0Vy4kSaJO8YWnxLYz7Y?=
 =?us-ascii?Q?2toaxEXBsz5KYaV0IS9Wl6NEZpXklkf8jxM7fMNP7fVjtGdUDVUQXj5VEKi0?=
 =?us-ascii?Q?ciSvn3xuK1u7vuHIZBlxGy5ln+P1Lgmxp9Qfh9+awMDRxLrL2p3plS44T7/T?=
 =?us-ascii?Q?rqSL0LQ5JjCOGeOeH1eRiQpLrfKAm19tZiJMk7ctYhKJnspo80sf?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <305CC2D2AEDE4C45B7BE2D250A8C1B16@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR04MB8048.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa81e1e-9755-4e87-4a04-08da232a455c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 00:02:48.4996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ADsI2lfnwj4rs4XBgGWjut5kUhYVf7kayxsHMsyLi7m9elx+EDYoS1t15QLZ+zLnssyOfTn+OdOnC52GRYkVL79K/MMfCXTSYUyVFuJybIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB5155
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Apr 20, 2022 / 23:05, Ming Lei wrote:
> On Wed, Apr 20, 2022 at 12:42:14PM +0000, Shinichiro Kawasaki wrote:
> > On Apr 20, 2022 / 17:34, Ming Lei wrote:
> > > On Wed, Apr 20, 2022 at 01:59:11PM +0900, Shin'ichiro Kawasaki wrote:
> > > > The test case block/002 checks that device removal during blktrace =
run
> > > > does not leak debugfs directory. The Linux kernel commit 0a9a25ca78=
43
> > > > ("block: let blkcg_gq grab request queue's refcnt") triggered failu=
re of
> > > > the test case. The commit delayed queue release and debugfs directo=
ry
> > > > removal then the test case checks directory existence too early. To
> > > > avoid this false-positive failure, delay the directory existence ch=
eck.
> > > >=20
> > > > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > > > ---
> > > >  tests/block/002 | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >=20
> > > > diff --git a/tests/block/002 b/tests/block/002
> > > > index 9b183e7..8061c91 100755
> > > > --- a/tests/block/002
> > > > +++ b/tests/block/002
> > > > @@ -29,6 +29,7 @@ test() {
> > > >  		echo "debugfs directory deleted with blktrace active"
> > > >  	fi
> > > >  	{ kill $!; wait; } >/dev/null 2>/dev/null
> > > > +	sleep 0.5
> > > >  	if [[ -d /sys/kernel/debug/block/${SCSI_DEBUG_DEVICES[0]} ]]; the=
n
> > > >  		echo "debugfs directory leaked"
> > > >  	fi
> > >=20
> > > Hello,
> > >=20
> > > Jens has merged Yu Kuai's fix[1], so I think it won't be triggered no=
w.
> > >=20
> > >=20
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block=
.git/commit/?h=3Dblock-5.18&id=3Da87c29e1a85e64b28445bb1e80505230bf2e3b4b
> >=20
> > Hi Ming, I applied the patch above on top of v5.18-rc3 and ran block/00=
2.
> > Unfortunately, it failed with a new symptom with KASAN use-after-free [=
2]. I
> > ran block/002 with linux-block/block-5.18 branch tip with git hash a87c=
29e1a85e
> > and got the same KASAN uaf. Reverting the patch from the linux-block/bl=
ock-5.18
> > branch, the KASAN uaf disappears (Still block/002 fails). Regarding blo=
ck/002,
> > it looks the patch made the failure symptom worse.
>=20
> Hi Shinichiro,
>=20
> Looks Yu Kuai's patch has other problem, can you drop that patch and
> apply & test the attached patch?

Sure. With the patch, kernel message is clean. But I still observe the test=
 case
failure:

block/002 (remove a device while running blktrace)           [failed]
    runtime  1.276s  ...  1.241s
    --- tests/block/002.out     2022-04-14 11:29:04.760295898 +0900
    +++ /home/shin/blktests/results/nodev/block/002.out.bad   2022-04-21 08=
:40:01.776511887 +0900
    @@ -1,2 +1,3 @@
     Running block/002
    +debugfs directory deleted with blktrace active
     Test complete

Before applying the patch, the blktests failure message was as follows:

block/002 (remove a device while running blktrace)           [failed]
    runtime    ...  1.570s
    --- tests/block/002.out     2022-04-16 03:58:14.627621791 +0900
    +++ /home/shin/blktests/results/nodev/block/002.out.bad   2022-04-16 04=
:14:35.471134592 +0900
    @@ -1,2 +1,3 @@
     Running block/002
    +debugfs directory leaked
     Test complete

--=20
Best Regards,
Shin'ichiro Kawasaki=
