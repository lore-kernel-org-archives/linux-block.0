Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F324C77B7E
	for <linux-block@archiver.kernel.org>; Fri, 26 May 2023 02:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjEZCJH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 May 2023 22:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbjEZCJG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 May 2023 22:09:06 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E9AE7
        for <linux-block@vger.kernel.org>; Thu, 25 May 2023 19:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685066945; x=1716602945;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=S2tMkSNY2HpETVypc/udbAgBfviXcb+56jZisHz3zw8=;
  b=iLv0rSZLp7HY3kylo3nuQLU2qvltc1413DkCm6Gs+tWxZO6jF5tOt6hw
   kn5nolUDmbvAyBkSeh5q1eutr19pmLFy8JGlOtseDTTAMqLbdHvhpYuxM
   DwSPpMi8y/E+voPCY3fuWA6uGZm7wrpIVeKKSgORwprBgVcTh3bCat8ER
   6ytgt7XFQY5PeTYt6L/GkmPtq5Be82zN7sozZEanMjPuuDsT29hiEw6Ig
   Vb9qr+wSuhctaiMZCwaUnuCUtHb4MSdd7+PRERNWe//USU8OU58dNvkCg
   umruPgk2wszX6RMaK3K+VWDQeK+4k60Np1KXXMdXcMIFzOeMUlAePZAdw
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,192,1681142400"; 
   d="scan'208";a="343779541"
Received: from mail-co1nam11lp2170.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.170])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2023 10:09:04 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W8P4rEtzjs0ez77uVs6QXpidyHMInj0r3iZMqwUayJswNH6XRBs12R0QdcZz5nN5SqEX9rsIV2DBQW4VPNvF0Ke+Ksk2s/pgFv868Y+jupiIZwalhxAIKpnduwPS4FIx0jYOMH1exCa30OqKr/tUs8bIiVqJR8+ELVTdmSz4Qf4qD9ffRLfo1w8nBS0Akp0j9g/F3WIE/lqoeoIxYPrTreB/IiXqjiDJMOtMD6tPe4VCingkhmx4NxXrhCInDM920gZcFt4kgxUq6Vrnic+TEzUByML8lD2t4rstZbup8nfevY1V+Zm7+/pEmXpbhJR5tfFNSusYaUTkSwwl2aHBCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2tMkSNY2HpETVypc/udbAgBfviXcb+56jZisHz3zw8=;
 b=EeFgBFRDBj0BeufsJ88K2ENDTi7DrwXxENEHzOYvsUAkP3fkO/4Zg2Bm28MHIzZ1a6Xa0Tnt9oHtJIdf5L7TtKs8CzaO5zFDfXtSbtmjh0QhBZTyYyV/995y4gUQqcUcunvLbtE6xzBYHMPjzuM558+res4dY0tsieDkVS5GPpP20yIqqFGbb7d4+yWg3Bmwt7RODCELs2JuwTPIXzAHA/tOgsZXxkcbQWFgB+IeqB6bwgX1f8dj1OiQerfS763DldTiU9ovwN+p8FyianYjry5f2lSCwV1upnaPbjN4ZphJrKhh9LH8h/0vqLQA0Nu1KfsgSgV3YJXmWbSYqU/d3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2tMkSNY2HpETVypc/udbAgBfviXcb+56jZisHz3zw8=;
 b=llNUCTCE3SoEpe3tZSiV9rd59S8gRjDo/6barO239USeQa6SqPm5LTXp9xRz4qP3obLStMGAQe+L1MD8HY0jlxMb+xjOHQ74WCu7bBF0wx5F7av/R1T8DnRTS44NMiYSQOvJ0S7IJ3svrK+G6tkNNaLWImxwvJygb6Cj3eFzbAc=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 MN2PR04MB6301.namprd04.prod.outlook.com (2603:10b6:208:1a7::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.15; Fri, 26 May 2023 02:09:02 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::eb0e:1bef:f266:eceb%7]) with mapi id 15.20.6433.015; Fri, 26 May 2023
 02:09:02 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dwagner@suse.de" <dwagner@suse.de>
Subject: Re: [PATCH blktests v2] srp/rc: Replace _have_module() with
 _have_driver()
Thread-Topic: [PATCH blktests v2] srp/rc: Replace _have_module() with
 _have_driver()
Thread-Index: AQHZjezNy1+WG3PBxkSh/YVO9hFlf69r0jmA
Date:   Fri, 26 May 2023 02:09:02 +0000
Message-ID: <qt7oil6ajrmbr342n6k2ifsm3emilvjhz6kwpveuilzm32n3rv@4rmeeoqlzuxv>
References: <20230524030643.404546-1-yangx.jy@fujitsu.com>
In-Reply-To: <20230524030643.404546-1-yangx.jy@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|MN2PR04MB6301:EE_
x-ms-office365-filtering-correlation-id: 15cbb539-bda6-4280-df31-08db5d8e2d03
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nGlqssYbJA+gQPBWMjq480Od4vbfPm0Ff3yuMTzaSeWFV7Xrsav0EGDL0Sj69/tX0z45sWVFvOQiryVCY1Vc1IFtOS9VfhbA6j8BuR/kqNAe5zZF10mqJ0oa6NGQV9nCsLf0mbI5J/c0C85Kt0WgQV9gbV5D9uUJZYoUdbpP5egZzZ0DuVhsAJ52TLNj11lkjWc3H7QRPkZx66iOAkK6c08+bFDq4m/k/HZ1o/xxzgyNE17oF8yZwpFTMeL7VwFttiBZH3J/CiTPXbLVO0wmARlKIVENIvlUKHZZVa14imnhRK29S6E7UGzaO35F+/kLvdgtr4iHp3JY3JoNYcGi8wszhwS6AQnGt72yNe8nOfNJ9pKBRm24/MgsiENXQNW0xGO2DXEDqhCdg8HcbifqjR3UZsfar/t0+rJ7HxCdl6aRzoWmkVYE8xtJfLZryTt2VcuWJXub/cIbXESG2DGP56ttfCBwkM7Ha7g3ax3tJ8/LwSa+ItbMZaLz8Q2tN10UQc4R7jGLKncD0LYfyqA00a6AiuyA+vegZdvFUctCCkNTc71Bk6u0VIbASgdTLYfbwWLjCw0iIfiGNjooL5oYuufpNo/F1Mcy9hxVPVqBeCp5uZSTk27Jtz+ILubXS7AN
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(7916004)(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(451199021)(2906002)(186003)(558084003)(38070700005)(86362001)(33716001)(38100700002)(82960400001)(122000001)(41300700001)(8676002)(8936002)(6486002)(5660300002)(478600001)(54906003)(66946007)(66476007)(4326008)(316002)(71200400001)(6916009)(66556008)(64756008)(76116006)(91956017)(66446008)(9686003)(6512007)(6506007)(26005)(44832011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y8iUgIO3/yHmAHekM1T2Q3SkkfQLHWbkY59KgL3HlAocJUXjMzVt5OU+Hfsp?=
 =?us-ascii?Q?Rsc8l6WBxzEsiISHP5TxT5u7mPdkCEGn+NkD9FcYjDmtuhR6xgJoD4ES4JMa?=
 =?us-ascii?Q?JODFdFSwERf3s3oS+SuvAnmeb9tP4TlYjbonKkL9CBPa9yAvqvJHU81Q/cWf?=
 =?us-ascii?Q?0ptwl81NGZHUANX+kll/Kyw50PTE8nCvDjiigOO+hi159TpQG77cuhTFwpkb?=
 =?us-ascii?Q?E5vFWvM3kF1057J3CFRLj9MJLTcm+rNAec91DZnzW3AnTg0qGOjqKhRG6Ex4?=
 =?us-ascii?Q?pSSa4YVSmNFB+NmbIzjzpNjLK27S2I252xd3hiumJgQ72dwDBk4OosNqqMI9?=
 =?us-ascii?Q?rzUdV7UL/uBL/KnQAmrt3cgT+UR1WGVEkOZiDF7Cad1YQJ1lgdYOckLxtN62?=
 =?us-ascii?Q?IYlmlIwltGYT+d1lcV9P5H/y4bTcISUA5noPi8pxPvw1aqdSUkmrG7M3bdoA?=
 =?us-ascii?Q?KDUNGbDp6eMEjyB7hYvvt5/4DKGLC//J1H9kntxben17CLNAXwcXjWjwDBkn?=
 =?us-ascii?Q?8js5tSbCEZ22xABsyFmQt0SlPDV2zcckvzIolIRcd9nUsDoA8CdOP3+J0m0j?=
 =?us-ascii?Q?rHwsBzcbbbcRx2Upz4H7ahVKyH/fxqrWDdS/q4XIehhen00VUDgcOjK9YfBl?=
 =?us-ascii?Q?dDqp0hQweXlI4awzqtBy0+hqtSOXMIBP/SPRx8GeSFSDX27ZbE+44O1i5OsN?=
 =?us-ascii?Q?JSsN7LtmCxAkvLpLpDdquo8ghpcG4vsEFXWq7hOD97icuEQGgJKxmr8QLezF?=
 =?us-ascii?Q?ieWA2lnzHFcxA8sSa1GkgoK6QKVFMtBOmFNI85Ld8qzxc7y89J3k3VwR5Q+I?=
 =?us-ascii?Q?DAekVz0PpzIg/sfrI5mQ75DkW9lTx514CIDe/d/j2yXaY/sTXjDyWPx3nVHe?=
 =?us-ascii?Q?K90/YlVl+cUefOfaU06oFApv4CrkoEF3hFU5+L7XNZUAvo51WcdMbu7Cd3QC?=
 =?us-ascii?Q?1arWc5dXaoDJlAMrMPTPnZ+ITmk6jhmtS8wVBf14mDJaHnzMjapZFi+a6359?=
 =?us-ascii?Q?NEA3MJI/ATEuGna2JIurNV7K3d8edGulqhXJM0Kkgv2PYERXa6f4UUx0U5pi?=
 =?us-ascii?Q?dSkPVjF5/QmzZ31BP91Z8rBoLalzBaUHe5y8dgemr/cl1Fwbathhy/a3kr3E?=
 =?us-ascii?Q?FXT/5tS3Mxh8eHnlob2yGLA99Pq2fCxVg/db4a+uEYJ8M3HJwCSnFCKakkeW?=
 =?us-ascii?Q?cOUm4JBJ+PGJQtX3RZBYciqzNpQlZ4HL1opn2qykkXKUfL8QKN0YIdC7RnqA?=
 =?us-ascii?Q?o5mM1LLi+RHHn0I25uHu17qLHElvvQ/wfy1P/QpT/4XbcI4zVSLKfFToGLO2?=
 =?us-ascii?Q?cSENuCIE7k0ihX/PKNJMmYle6xJ78pI1VGSRclm5uSK+u/DXBhPA2lj0vWvq?=
 =?us-ascii?Q?LAekuLYEgmAnZGsldKwt05biylz2wfATXQvuzkui3mTKe7hsnmzLk+PjsJDj?=
 =?us-ascii?Q?8AAxI7i5+CFDmivUoNqSlGhfJ6ENulbH4eg29YL8lEPVhPwawu1UfUqIRzbv?=
 =?us-ascii?Q?7XiHJ7yHRUysmrogh2+cIeO4GtFnuEGwHnqwzf7LdVmuZ85vbtZags0/qXyq?=
 =?us-ascii?Q?/twgPhqB83NtP64nMXV9YLAO0oYk9EEG5mDrkLsMmwD/E7EDdeL7BFYb4xv/?=
 =?us-ascii?Q?ucp7sQE/FXObqG9vdhfbu/k=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F59D6B451DA1FC418FDAA0281DE11393@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: F2Jy08FgpiAGXRRgWeryNEYwK2o8098md3Oz0oIFMriY8bjIQZXf6kN0AbSliVyyWLusj/05at0Lrv7USpMPcGdnKXFt/zE16lHqwzek5TrYQeNvNGRpmGMnj3XPKdbfaR5mJuvNdenlWP3W5iVwj3EmOwqJ5FGvNMoYs3g83JQaIFv+T7QEZC7yk7gOx7FdwiFYbrx0kq817nPp++luDD3I0XwAj/YF1vCcmB/bO5azyA+PMvubLCO4s7Lh+QhCgcoaq0IRz+F4/sZVXsjS4tq5Pkl56dK5XJS4VlmVCkMuZYemKmobuSn/0xBvKuj49e7MSS/HtwcCBBL/7COB0OWqm0Pusxe7n2RsTtL7dVELGfXEwym589ENjZ50DK7bm7ly9B+6tRmu70g49g3upxydcAAPbjaT8No1AoNEbr8icC1qsfOPbTP53kB86md/TamiFkjMLFOMCvApiRBuBjMVas9XTgmjz8F3zC/d+Gjp5tc1f3m4ZZ1WvxCWN4OrsggcsP9NiPo9yxKx/sw7YXbnY2wAcw7Bf4TlNPe8uOYw0YlqC827xpPaWDJ/kYVCPrdhq2LYvxa4xIjIJj9tjKuioRsqRWXiZMz1Thh33EoPgx3HcqF6foHHb2tcfZ1Z64HQt8HZQTnyyGF8iJtPMZrXlBK4Q0ib/dRr43ImGT9ILnNA+l8Oi1Ka1ajGEwc9ON6SbPfo8OhfSpRgUC/F5fa7Lgb7Wi3BXvZMYdlz7gtr3tOzZXDU6A06H/Oe59SCWasPfuJKCZP6wGUgQAYZw/G82w1MWScXPRnPXjokbzbgqhTKEPwh+qk49rCSOwpx5i4JWlvLMunpk9uurDE46Q==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15cbb539-bda6-4280-df31-08db5d8e2d03
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2023 02:09:02.4644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qo8mSTADWd+VL8cgV5yKuGwHRbSh2r3uGoYsaG4XAqd3gJg1rEfZ6CDv/vbPmR1NoMsFaDjwOrasr144TomRgO+Qn9QpCPKNWQ8f0io0EQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6301
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On May 24, 2023 / 11:06, Xiao Yang wrote:
> srp test group can be executed with built-in scsi_dh_alua,
> scsi_dh_emc and scsi_dh_rdac drivers.
>=20
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>

Applied, thanks!=
