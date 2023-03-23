Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1644C6FD1D
	for <linux-block@archiver.kernel.org>; Thu, 23 Mar 2023 10:48:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbjCWKsn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Mar 2023 06:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbjCWKsY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Mar 2023 06:48:24 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F7B38E8A
        for <linux-block@vger.kernel.org>; Thu, 23 Mar 2023 03:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1679568380; x=1711104380;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jlPLwZQrCv9w8Z42kaPi+pKe/D0HaGnQbCeT1CgGE+4=;
  b=XEzhfUY1FHvDqsbIRgwQFPCQMYta8Fh0Lew6m4rfG0tsD8dGPQ5RPqev
   BmRgjsF5TtTjx0Cl4+xJ6KNJP4kjmtU63rKvBec+CF0LeElqKdXKsuE/K
   wWQHXelx9x5igtSNUvi+w35G4GPiA1Ymay47gcIFVuVQoq6N0cSI3AYBH
   7ngEmTQLkfUZC4I3mBIB7OPjEhGi4xAeCx3htmMmOuBbJbVvdrv3t4Yok
   22jl7bGw1KAAT8HiqVQpwTFDYlW1uowsyUkICGZMrl9qi2688cf6PaXPk
   Pxwa3EQNWPoeRlcDmpj7orksG+dwIyu6m+kQbXymeMpLqGweb/YlDXBI3
   A==;
X-IronPort-AV: E=Sophos;i="5.98,283,1673884800"; 
   d="scan'208";a="330739064"
Received: from mail-bn1nam02lp2049.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.49])
  by ob1.hgst.iphmx.com with ESMTP; 23 Mar 2023 18:46:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuZxEuBS5mmob0OMXPAlZgo7YjIk+sB0tJr5ifyPVlNHUPVbPI6c6OfOQ4sC0g5noksUTir+NkHGOgU6actCHqRl2UM3T7Neij3ChDmCyO3Atc8Xl7+43VjkIwanPDFxOCdpMOO/xPlU1/cITFRuV/h1tCBha9LTbul8JDhoRSTJfka0QT+JwW9frf8Pk1EuTYCMqItoBZrHIdRdz3kYfaVJfkMambw5Fw5pM/KgnQyS+JE7RA84tkfuHnS5bRqkJtCqBLG74RIqee2q7gF5J+3fLIvFgBh7sOoN7kmIS5ZLqxJ2889VS/RsBzKcfmt/FQPOsAwT7TglAxa/awDWig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jlPLwZQrCv9w8Z42kaPi+pKe/D0HaGnQbCeT1CgGE+4=;
 b=NHKizmPw/+BgNDvi42Fm10ueLKouIgGbtlQz1yFmBt1oSUVnjxo/Jd+8bqC02QHgykxTg4SLr8khVhqFvDKBu2kOkVcEehSkqXmKbZ6UCsqEeIGz41JiL+KFLvo97RRbNXmo08MVHwnchvT4xG0K+u709qUeIO5hAZHl1FmnMQ2hyztrw/RdWyedv7aXtqLQXvZGpwLVLJXSQnG3xmaZ4ZqCBabt0D3e/d1y0lxyqK/JsbbC7/By1V9ZVEGIVisoT50uhGbIRFQNpFX6djOcl1/OMbjMCaLn8FmJMeQlIks0niWi90v2mV6pL+AgXyhkI26nfGCp+jgT3ljHs+zvGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jlPLwZQrCv9w8Z42kaPi+pKe/D0HaGnQbCeT1CgGE+4=;
 b=HP/3I2RWo1Qcue8Syta0C+PSFyjIID/1Te/CLGAMHA1DQk7g9QbZWVPN1PnnchhP30o9at9kbvkczGtUMVGtGyui1dxxvuOBkV3g409bJ7kaX5u/hdCNbgZQuR/ZwLk7Bl8ii7htV7Awbo1J2dbjleOhPDonEs0iNnMNS56vZmE=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7431.namprd04.prod.outlook.com (2603:10b6:510:16::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6178.37; Thu, 23 Mar 2023 10:46:17 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529%7]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 10:46:17 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH blktests v2 2/3] nvme/rc: Add nr queue parser arguments
Thread-Topic: [PATCH blktests v2 2/3] nvme/rc: Add nr queue parser arguments
Thread-Index: AQHZXKd12oGCQgIg70eJR0jc94HIXa8IMBWA
Date:   Thu, 23 Mar 2023 10:46:17 +0000
Message-ID: <20230323104617.lcmfzmock7npn5us@shindev>
References: <20230322101648.31514-1-dwagner@suse.de>
 <20230322101648.31514-3-dwagner@suse.de>
In-Reply-To: <20230322101648.31514-3-dwagner@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB7431:EE_
x-ms-office365-filtering-correlation-id: a2ed507e-267c-4f17-e66c-08db2b8bd4ea
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TShrbAK87T48ICpTZETl1B1hxz7mDGXJr3CXFGpZp5ScTBvRE87sR097BQndWRkN53WjqhsdhPCm/DfhoNMrN3zG8AGGZbkHqo7A3qAu8DCw2T0J1XHAvswricpLLqm/IGqYGfi6H/4bxSraIVUATSU4+MGxyyhTus4xsPT84+94LKo7OAv4U+4pX8cAXPpmUB/MHeu9/ahFmMrW/Qcn9CDrGl3UnA20KHFWOZxNjRLwU00pzzNov26BNgp7+EzOlW2qJgXHTiwLwjulITdLHgWWUSVebMGkx1gZnFhgIhKhIMONNfk3BF5I3+YxuzdS5xpmUUJCS5yx/zsUw2YcNEiT1XUcstTDJOLei2AhEC1phGzDoErqQPxjr36K+a0JXUuVYhvj6JDvkqxp+ghd7DETeB/g7E+ENStd1taFKikaAgwmbGfOwI6SY6oyR1Kv3fhZIBXwNceiNTzGprzPD5TxGjk0X5SiidxbtNVTozsfwkYfIeks7l/3nCVqgBwtyB8TZl0qdmfgJrJaLDdsBXiUGZnlpgejE1MMqouy4TYZVrpeh5BdDVil9Rzo3IT1m2zFludrwFWi9AiqhniLurOLP5gqNtkPSHJwV/1mOedb/NikEDfulDKDtFPqMIBTBeQ9DV+8bMwAFaCLMZYo6D1Qgm+3hB3q+rUD87RzpS58+qIw9TvaUBxgstiuj7aw6OSTc20JPM+IhHcOwMJoUw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(346002)(39860400002)(366004)(376002)(396003)(136003)(451199018)(86362001)(558084003)(82960400001)(38070700005)(122000001)(38100700002)(2906002)(44832011)(41300700001)(66556008)(66476007)(66446008)(64756008)(8676002)(6916009)(4326008)(5660300002)(8936002)(33716001)(66946007)(186003)(9686003)(6512007)(6506007)(54906003)(478600001)(91956017)(76116006)(316002)(1076003)(26005)(71200400001)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?2xzvCrPt6go46YSeGPvS5+EHpJLjWKEfZV4JOSFs4MCFgGZ63theiV1pA2Bw?=
 =?us-ascii?Q?kB1p+l1RbcYDJFeWBKkHUI25+fDfhnCMtslFEUOZev0bbTR4uAJujbm63N+k?=
 =?us-ascii?Q?OOQFz3Wp00DLpNQVoWi3V24erebn+v4LLlGRhUIl3q6/zClmrJ6ogDVzKC77?=
 =?us-ascii?Q?e5dl+vpLh+15VtzEX0bkdxpkiog56JZd7Oxro/o21AIXvCuy1hoLI8SuJV8X?=
 =?us-ascii?Q?qDb18LhVTKJmUmLACmumo7HPs5ucd96qpNxwV2NQSW/hoot4tLSTaZ50dLL8?=
 =?us-ascii?Q?ULUbPPzVM0VuBwsxtGs2aORfl1bDiik1lrve/lI7bmM0YR3MXjIHSAOnNOMD?=
 =?us-ascii?Q?rCvSACmFOT8iA5xZxG/aTCxlSOLK6Lql7cNnU6oLeKMkk3Ze5UX2eEdVAbuv?=
 =?us-ascii?Q?zTD7kDHGty5LVPij07oNKcmbJ7Qj8GJ4/Y4J/Y9NAgh+FI3RfLKtqctM6qxU?=
 =?us-ascii?Q?bWzyj+wZtjmCYoEdpp2Q1IDFxWh0Pdu2TgkQ3r1ku8ol38UToNLillcqBhbT?=
 =?us-ascii?Q?S0M002H/AUsT5rWXWWAKQ1X1FmFmWD0gRvIqENphVbG/ExbcqM7/3t4KCntT?=
 =?us-ascii?Q?a9y1cPb7C6NAHpmxNC/eTodz+r3p6GxsZI2cGzWL5C4Due1GwZ4SY+bimlxH?=
 =?us-ascii?Q?0vsKpPO4KK1V8EEAw5KFiXXRuycoZ6l+ZyMcTyg0Bnm1EmAII9y42A00hRVb?=
 =?us-ascii?Q?0cn3xMLyOqIHlna73ZqJGB6XfUQTVvtBCMl4kdtmOOrFYhvP6IFY924J3vHw?=
 =?us-ascii?Q?kaXb5BfmsxbCssvVaIRvIz0Oa22QlJD+t2Fl8054ky0GjuGZDRlxssBTHlkx?=
 =?us-ascii?Q?8gDs1RmNfrBUBy7gNrX3+ur5KISPdwV4NzMNlkkQsayA/joslv+cnIM2E1T5?=
 =?us-ascii?Q?Ru19JGFKck9uwKl11ab/Oxz+zkNaoBOskT5oph6rn7fzZSGfi+GiXttMsxAi?=
 =?us-ascii?Q?jS9BVeCLurAUpM3xvLFIeA6EtguAJXzqOiwENAGFqrOe/KkPJgqvFlWOlBQk?=
 =?us-ascii?Q?EI++fRtmLXiHsgTbS5ZPFIv3IzU1lCIa1Pu3/WMt5o0ctosSMyREbyD/LDkR?=
 =?us-ascii?Q?vvBq6dQ+Z1FYV15VQjSQsZ2xmdqf/W75u7ECiFTary9+tYmcILQxK83/Lt0l?=
 =?us-ascii?Q?wN9msr6nff6ZfNpRMY0C28y5B9h24ayf2tpgPSYh3R1BIwjE2FATNWlx4dUO?=
 =?us-ascii?Q?PfpWvXIRVxv5PEynZTA7YgoObPrZVEraoRgHKHFi+lTKRJQ+uTnu9HyK6EKH?=
 =?us-ascii?Q?FUSQz84McxuW39Pq4+3K3f6+iuAdP24uChbd/XUETAKLc21/+TLCC+1urxgF?=
 =?us-ascii?Q?UbJWTmYsOVBjB6gQ/P/GMtlBOxMUrh8RcIUOqzVBUmWiMJYifKR6p9FOlYSj?=
 =?us-ascii?Q?6F3/zIKUozFnIXlO/u73ZtJE8Nmdq3pW7eZPp7ZouML/h59G5V17/K59RkOR?=
 =?us-ascii?Q?kFCi0a/qGDYBuyb1p8xYl0TfkTag67kTui6qhLn4TpMeS0tM+mTUhdk2XOtI?=
 =?us-ascii?Q?AmpMuKxc8R5XwGy5k492/Nx/FP0YjfBBsgEu3YnsPa6qtiNRzafTal2ima2V?=
 =?us-ascii?Q?x1FvIr/8XLlJRfogDNuqqGu4e/jgBDUmI9F1X0csvs/GN1sbcR3BIa2Ry57+?=
 =?us-ascii?Q?VhRgCdlkZHIJEWaUt8IMogQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F040E2D9C2E3D849BA3C77D79C981F83@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: uYFKUvKQUUfV6K2aW09F7oTBvUPq5ya50G03Y4W7dpfgy7HbDgWILCSV8E00pfeDTl93uNKc1YpUhvETNGlMJTW7AXeU1ESYAIzDbHyFPDk1dVJ2ABzlVBjDZoS9b/mMZYv1D23FHwfC8quIjLCqX6UCc77eECZ+0rBAwbovQ+HD3Rt/+qa04PiRCc7JMeOB6s/c+7cQn388IO3BXncGMVQCiiVPEsgarTDPVS74U2o57OJ6cwdGEeqOroYJX4n9tUSGugTEqPcP4M1nLIdCJYrWwo9zW4cA/R7ZC7oJDgRIKDAbB9EdrAggi7GMPb/5P27VvPEerj++EcwrcYT4uvTUzA04d3XeD4wcDK6S347fIzLs7EYxUN8Z01Swl1rPx0X1LnB2ESW2WRDZpB/clGl3RpW4qhshf3CbWq6TjmwQPLeAP2qVVJzKzG5PqFpvxYF20mYFd4Ouq+kMYO6JiaSCFeWDQpR5AcwYQG52N9jhGiihyC8V37ESEf7JxylSzLIyNhv4iidQnEni4Dvq4hVj1laCU6R5kA1VTCe60u/2r4+EdtDUp0+W4+o7AoqY1HXNzBzEC7aJS9oHnMuNfjOMY302giAE4Xb10emFFu57MBnf6XYWcUN2+6EWipQoPoBbT6sxwG+dDubWETv/iMiIypWymzRKqH4V6LFDiRE9njrAQo9Z7OebUxl1rWXK7s5+mSPzDJYHPqLf3E7s+pBy2FJNH6rannOCRaUFWe2nlD4pEyd0z9ekYjvIqQfZvlDn0LbwZZwTAh+/8Pvx3gf8qfrzakrFsKPgMm67yNOGhz8BIFoJV7hcMfSerktQO1RpHC4Y22k8eoQK5DQ5t0QX6h3gdcfznOa1BioOOB7wXPjSChTFh3Sk1lMhuU2i
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2ed507e-267c-4f17-e66c-08db2b8bd4ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2023 10:46:17.5044
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1gkffilZS1HDx/fo8bxrf41i4WyqgZz8A4vNlcZWnSUpAYBIL0ymfgq3hiWuGIj3cTW812rkZnSUCPkXSszrWqcoJKNsF4aJoeapAQQwuvI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7431
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I suggest to add "to _nvme_connect_subsys()" to the commit title. Other tha=
n
that, this patch looks good to me.

--=20
Shin'ichiro Kawasaki=
