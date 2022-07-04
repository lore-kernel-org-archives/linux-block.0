Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1306C43334
	for <linux-block@archiver.kernel.org>; Mon,  4 Jul 2022 11:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbiGDLrl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Jul 2022 07:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234348AbiGDLr1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Jul 2022 07:47:27 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ED5E1262E
        for <linux-block@vger.kernel.org>; Mon,  4 Jul 2022 04:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1656935208; x=1688471208;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cUnadFNPDnAJ98vpiDLwYTUnh+gJrG1uCt18IvszrA4=;
  b=kh7xBvJ58mUpf/+44DlbbmSPdKzwAEIXqZTJWAhPOuzVxZCovY+330w/
   JzZ0N2UzYUZRl93WgAKjoo2qpD8r1UE3lVh7v7TL2pCKTqHSgxn3/g4HA
   W/V9Hv3mEFdRN55F/Xze45Uokzzxt3WaTPOVFDbyO/HxcL3qf7wpS3ZnK
   4QA5HcBmnnLcPVuu8VqSZhSPyFjn4lT0VTxg/boNs0fVxOhs7g7YWb4yK
   pQi7A9vd34yeiLiV76pHWd95ZTGPEYBwvhFLPaJZ72uL3ouCvF/CYeywd
   dXp6SD2SDOCwVrJnGInUlel7LQ1WKkrb7MT2YZhoY/Sw9R0awaoH2Q9k8
   w==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650902400"; 
   d="scan'208";a="209654396"
Received: from mail-bn7nam10lp2100.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.100])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2022 19:46:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eruajfujsaXVfe7sezOK+pujx+o6hgQJTXPWRmkDIT6SrO+xBCU/4b/EpLQVMY7U8ipv37WAbQW1ZiJ3vrZaCI+u7Mm0BDSwLjuSK71WoIKAJqTvDn35o/Nldvr29pqww4u06Nv3/H9ewcTr49y46RIKhvJPS6yf3ZH5UmmmN2pmYIYJ24qjcAQUwtfSGFoUblNoeYEwaMEIpIazJI1v2ExGzib5bfGIr+yP/6sGREW0IuuGP1KyV9UjWOF9aMjQOhbuB6I1dKXDu4GbA6QUiurHKRpZu2x7+7aHTYBnNsH7wd+jPvXNLrxM6v5dtuBlqRKQ/P8Jv5iB8dj4Ea9paw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cUnadFNPDnAJ98vpiDLwYTUnh+gJrG1uCt18IvszrA4=;
 b=Kxt38J/olNQlwXsagJaoPBwouXdlMKhDp/P4vG+Sq7zRDLXbOSAVyP/oUxlxPEwJ9HVygyB7iEb19TpvJw2OZkSq5bgJokHtRw7pD5NzkrIOviGp4qT/M/W7MgWxK1QT2bg4jDILlIKFuM6pU6IyG1ZJEiBpczEhEzqc6rbrykzSX+9rwr+gl/xe8MKlp+Ds0fdlg3LUEon+vwrHuDXsTIyV1tGTGtgbqafzcPZ4k5MisN1V7FGw3q+ofYAN5xWzs/rQasUMp1qM8md6hCCdnO4b4a2R9qN5xo9gh5wH3TpZSqQAtbBk4LnHhbRdVLkt6S4nGTn57lbBIxVYKoJUXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cUnadFNPDnAJ98vpiDLwYTUnh+gJrG1uCt18IvszrA4=;
 b=PwA/6l7gcraPTlZLCHQPVdJSEhY8sPZ2x60kwWJOgUxNQs4zt0QsDPDbVsjPscctEMtxuo6+Vl2EumyQX0WHLKlqw+MMF8ZTHuYaQCZvH8AgFS4ju7QxvgpBPzkNEfJdb7lManfX3PfuR58kBmMt/74NX014SkuG9Wiw7Wx0X3Q=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SN6PR04MB5455.namprd04.prod.outlook.com (2603:10b6:805:101::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Mon, 4 Jul
 2022 11:46:46 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::3cc7:ac84:d443:5833%7]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 11:46:46 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Yi Zhang <yi.zhang@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] block/008: fix cpu online restore
Thread-Topic: [PATCH blktests] block/008: fix cpu online restore
Thread-Index: AQHYjwg096RdlhMAIEKAAwKQivwDX61trWMAgAAYh4CAAFN+gA==
Date:   Mon, 4 Jul 2022 11:46:46 +0000
Message-ID: <20220704114645.3amspqzi5f3vyulx@shindev>
References: <20220703180956.2922025-1-yi.zhang@redhat.com>
 <20220704052008.jegtbiposiy5aipg@shindev>
 <CAHj4cs-aOQitbv0cqmW7v-Qii8YJvHMCsqUEkfwEFheBQnDUQg@mail.gmail.com>
In-Reply-To: <CAHj4cs-aOQitbv0cqmW7v-Qii8YJvHMCsqUEkfwEFheBQnDUQg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 342ba495-2e15-45be-d152-08da5db2dfac
x-ms-traffictypediagnostic: SN6PR04MB5455:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mBqE4PsuWddoDCFDm1ugZ+U2gijwJrBiTkuGXkau7FCjXAPbztaVTH0dsc6hv+BbrQJNPzJl5Y6WMAgWiUCAQxn3bmW22SdzUJ6TxQxW6uGIyxcEZQQdN8N/bQJNIHvooM5R1hDlkWHbjh2Z1/3y9+W98qUzagvEUNkI4zDGO0lRlDNmHD9A+xft93L+yCZ4RNHqMwLgQIkx2g1CpO1kd1qbGVai77UIb1MTIgbaNEFlMLspChx/163hfBwlhGeDKw10AtMunLKMRpYwYCUs+W1gb54rG1Ga6K+YBvGg/qB5mwhPzjMQB+Jw5/T/XWdBR7EZWHf0oIce0hVUhfdCmrk5wKcX2lCtsdOHdTb+Q1/FeDDXHDimHzwlBKKX8G8yFQVZKIf8QlB9jRlZeaOE2+UysGt3uoBaAbL6AvgAgVdZsK0+uhXeYNtpm6EnhS+8tFtddeT5IBH4CWiTlriIsG5X1lhggze5DJo7Gz7rl8HDW+kUyAfaJAoSFMt6hN15nbFkVZ//qJuEBN5FN1cTVx+AZInjPWJjaXnEgvCclZYoJpI2KJlX3s19VtcdcrEixuk9hP0+vDV51FfL4FovapirH4TuzNi+HHCbc4SGU/RQtWhaqQVmnP7miEXpc9leQtwKTkmKanmyTnFosLlZlL+wO5m9zzigd04Vzeneaq6eN36YQ2LTac8TILBZPPbGQPG+X3WKCG7oyPzCtI4WQbO9fDZvksUt/U6/aXB+yrm1Org8l8xVV7uC/Dj6Elavh0eF6XvpZhQIagVcuhx8FriHzcTF4DM5Ac8PU5jxEYdu9+81VK6VDeHseNp2R97o
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(38100700002)(66946007)(8676002)(4326008)(64756008)(66446008)(66476007)(6916009)(66556008)(76116006)(122000001)(38070700005)(478600001)(6486002)(71200400001)(91956017)(6512007)(9686003)(26005)(82960400001)(53546011)(33716001)(316002)(41300700001)(6506007)(8936002)(83380400001)(5660300002)(2906002)(44832011)(1076003)(186003)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MejCNS46kvwuiP+3bnuJ3AmG3dOLbdg9ry3Dj1DdNWj9DUn5uYJC3xrjRsVc?=
 =?us-ascii?Q?t6MKrSm+cBsY2LjxwLiwtQenkzBI3tNJ7ILFXhiTWMgTB3mbVu0UMr/SdnuM?=
 =?us-ascii?Q?5VtZPTXx4gHjLXnSGRdU0xMjQhNNop9kRxngFBtdoTW9A8jXfaszTaKkTTmI?=
 =?us-ascii?Q?6yrGmrcKNTADFyuja6FwnzP40ObjxWmitFHj1THGU+dan85d/5PPaZBhAsnh?=
 =?us-ascii?Q?cy13x2tgclqiPW+kYuOIejajSYH4xdpgyPyDgemNBdYywzj3r8dhNZIz2v67?=
 =?us-ascii?Q?CjR4bvLJR6rh6MXT3FDOEO9NGTMUw+uzflv8bYUaa0sExOk1g+geY5kYoNiB?=
 =?us-ascii?Q?E9UOKya2YJMStyXQwnP/XIIEQ9P/NirHeLyLWzK9k/uSsqgKwNdc6stAvJ3X?=
 =?us-ascii?Q?JeR5TOYU5zExvhdlXScz6sOpj/nRpzaZEr6ihpuTWLsONk+qTDrPuDgtvNZ+?=
 =?us-ascii?Q?n6VlK6J+fF3gL675uPbSqvwCvtmSMDQj4iow5HjthAhzzPoQnYIG9uRvw0nE?=
 =?us-ascii?Q?h1KzctOdUc0JCWXIlUCXLZWYBsdPBOXSfsGICb3bZJvBcV/QiwiU6ghuil3X?=
 =?us-ascii?Q?RcaI+xweECjvl1XnTY6jk5a3bpcQbXvPeVNV5JTxUhB+ZUc1BPWVY6ijs+dL?=
 =?us-ascii?Q?NXz93hUH19TV4d41YPX2QaOPmo+h5RZr8xiDaf0HqpNwWg46ecfQy4Zen+WF?=
 =?us-ascii?Q?pC262+I/JLlbntE9nN9Wp7qQV1YvnM6SnCszijUAujIhZBIbE+MhUQhkwMkS?=
 =?us-ascii?Q?7vkMuNieaAryo6slIZh2oynbekKoZV8EjlB8mGya2QRTy2l7vnSPB8/Nx5w3?=
 =?us-ascii?Q?tBXWXPuLLihZ3b/QmeKp5lIfzTpoQy3HjiLxDVJN6pM7iXLzgFseaYdduYjO?=
 =?us-ascii?Q?uboRjvwUZd+zxG6a5bvArjCXoXMOw4hqde4F2PCVcztniSgpyf8DSxSxQMlJ?=
 =?us-ascii?Q?c8zCjxEuej4dE1zdjqNNL6Z1x84hrSSF6m3T8M6LHWixl4GBIXnnjC+8rhUm?=
 =?us-ascii?Q?Vou8eyDl8tQhm5A9U4V08I74n9gtDmyALY6hpr7n0AphEu1QfoXBfbsaLhh4?=
 =?us-ascii?Q?F+4pe55w+RWi0kzSY/piWtgoVSwsM/bSngv8SzKsrlfgpj60wr07WMOF0Y6t?=
 =?us-ascii?Q?8pBmnPZ9EF+se+EZm1wYQ0A7ZFVA/wi3JmdXvbWPBmrwrMBIL/6ZnSLioX+L?=
 =?us-ascii?Q?YTP0xxmpIYnEbZS/2llYTCihe0ZouaSDpaj7Ac6MFnvIS7okWbzEKt2SuVZX?=
 =?us-ascii?Q?i3XueGPSBo6S70Zuc9e97uNBWrDzamztde4/hEfUA8273UgXJKa9QMg5cRgY?=
 =?us-ascii?Q?kjrE9nGxMw7+mRGGdbYaZhbzjuwnhglsadwAWOlCgcBw6BoLFH9yDYWOXxU0?=
 =?us-ascii?Q?M4ITWdJ8iHsNpR2dUPxryUQzScGQv7gTuvKW4FGZtG3qy26Yk0VlLG5DRjE5?=
 =?us-ascii?Q?aBXaJrAgpNb1rTKKpmkY6AGmbg34qfpXkVx1EgmD3uwRdK0nbJmTiPffyFXI?=
 =?us-ascii?Q?L0rxUl7FcciOpDGddjggulQ9YUc1+v+lp8kRBzy45plUYHStZQL2NjLtS3p/?=
 =?us-ascii?Q?xeT6UKGJol6JNS1LuTUyEgRBs2pbBz7k2BDbYjyiXaNQuQJxjYyYz7DaVh98?=
 =?us-ascii?Q?CaRdfBo7j9xiKw0vdPXYltk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2A2D91A67EB5164685FEF486B35287F4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 342ba495-2e15-45be-d152-08da5db2dfac
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 11:46:46.4241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /xy2K/DNA8PMKObTjv/j5LJxTNxA7T1xI0IDF1js3ARk4rkoPLYEG/thNtnBDNLg7v6XmO7BX9RZDVHhNB1yVRGp+//lAcKtGmHsJonWx5I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB5455
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jul 04, 2022 / 14:47, Yi Zhang wrote:
> On Mon, Jul 4, 2022 at 1:20 PM Shinichiro Kawasaki
> <shinichiro.kawasaki@wdc.com> wrote:
> >
> > On Jul 04, 2022 / 02:09, Yi Zhang wrote:
> > > The offline cpus cannot be restored during _cleanup when only _offlin=
e_cpu
> > > executed, fix it by reset RESTORE_CPUS_ONLINE=3D1 during test.
> > >
> > > Fixes: bd6b882 ("block/008: check CPU offline failure due to many IRQ=
s")
> > > Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> >
> > Hello Yi, thank you for catching this. The commit bd6b882 put the _offl=
ine_cpu
> > call into a sub-shell, then RESTORE_CPUS_ONLINE reset in the function n=
o longer
> > affects _cleanup function. When I made the commit, I overlooked that po=
int.
> >
> > Your change should fix the issue but it makes the RESTORE_CPUS_ONLINE=
=3D1 in
> > _offline_cpu meaningless. Instead, I suggest following patch. Could you=
 confirm
> > it fixes the issue in your environment?
>=20
> Yeah, your change works well, feel free to add
> Tested-by: Yi Zhang <yi.zhang@redhat.com>

Thanks! I've posted the change with your tag as a formal patch.

--=20
Shin'ichiro Kawasaki=
