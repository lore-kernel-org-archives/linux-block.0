Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C330FC43334
	for <linux-block@archiver.kernel.org>; Wed,  8 Jun 2022 10:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236744AbiFHK0k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Jun 2022 06:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237188AbiFHKZB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Jun 2022 06:25:01 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EEAE12D178
        for <linux-block@vger.kernel.org>; Wed,  8 Jun 2022 03:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1654683341; x=1686219341;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VEWwvO1Et6jjNH25/6XKxjMegDFrD/BLPPQWvPPvabE=;
  b=PnG3OkHMEe0v1OazNoNTKX6Kdt/ZocHSc/RA8mfPbJ89SDpNBNzSwC1S
   G1E0/EBxcU9BdlXZQ086YN3XixDyGU+lrdvJiItz+hw77TY5Vw7Ng6XDc
   +bfjwFZ/FNxyugaw1AI/pmPAWwMOZs5M8JJQz31Nz+WEoDQ3m1LoNtzP8
   AeschaK0eC9gSqPl+RsYRAzCSxfI0GrOg2WchZ0Cv2DiKPzRw4+jgrpKI
   VPonb7tQbWWbItFejnnwvCTzQZTAQs1Tp58udZJ0KTwhz4Bn2OvOk7mNP
   6PCKlqYce2M1h0wvItWoWfPtYoPuFuK58IvsByGVBLHxwdUxK4sVznq9Q
   w==;
X-IronPort-AV: E=Sophos;i="5.91,286,1647273600"; 
   d="scan'208";a="201311650"
Received: from mail-dm6nam10lp2103.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.103])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jun 2022 18:15:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SE5LCCV8ASNaXxKAQPLg3s+zzjxBwCYH47xQWbUxmPYrs13FwA8tnjqpp0POU7qmEr+rPiw1EyFBUsycVhpGwY3erQPvaaw4zClhg5JJDpZcI58RwwvR8lgzNAgs0l4pzEYFpTn8wU26TZTG2W61rQ2rHfkQweDgaQd2Qrv1Oym+5Dn5x0lsVjl4igxAUgn20FdTjm34f+LK/dfW11+eihNKix0eFpb5Yey5VO2GmvdYCCmsQbSWq+cwZ7C2xgVgi/6MzgAzG0AQ83AxPh++ZSdNvdEYoN7ze+hJAb708Quv6n4vxbORqEk9KlCpK84ssoKD+rEa0Rz1gqYa93f0NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eQKTbJY2+SwBXBz9X7UIGaxYhRzB2rR/9XiFrhVC7Ko=;
 b=ccgL1calLQZGMD2c7YqguxB3LgD/J434x20qz6Ag24fJPTW5faW6RWPfpEBaQhvAfp0QNmErM9zwjTsZMn7mJBddMzyNBal0A2VakvGPZzB75Fh4hYb0iDG1UEhJvW3xIpiTVp97ylm8m2u8mc5qsNo7XDHOTOKKAypDINu/e2pOB6NA0hKiGuj2i4lfZBWsxlHfRBYTnRd6nZqdS4Ow7DAlwm92+Dsn8LhvpX1jwj+vbJLTM743mETrXCkb+ereC3z+vVQPzXVFqNCLuo3j5sb+nuyR6gmZTeo054I9a8y3JUmANAT+sZfAd9QkQ14bjuPxpP6oUIdK41H4aeoMJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eQKTbJY2+SwBXBz9X7UIGaxYhRzB2rR/9XiFrhVC7Ko=;
 b=Rho5xY5H+etg5hjA1MEPxtG7KkXjys5ciAJL5wpRkJvLLOoekOFzaq2aw1x6v5+CzmpzY9skgelFCLvhKgQ2EAOWw3fiZ9mXvosC94WdAEpYsYbL1uhbzDoM+g0do3eOjQvMnr3FwpX8GG0nixSQCGRvU+9oPK7UfmRFfYMDVgI=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SJ0PR04MB7389.namprd04.prod.outlook.com (2603:10b6:a03:29e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Wed, 8 Jun
 2022 10:15:37 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5314.015; Wed, 8 Jun 2022
 10:15:37 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Christoph Hellwig <hch@lst.de>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: allow to run most tests with built-in null_blk v2
Thread-Topic: allow to run most tests with built-in null_blk v2
Thread-Index: AQHYemzKPkE0IbOI/kCLppMOTeoHba1FTIuA
Date:   Wed, 8 Jun 2022 10:15:37 +0000
Message-ID: <20220608101537.5kdypjs2ltmrgywu@shindev>
References: <20220607124739.1259977-1-hch@lst.de>
In-Reply-To: <20220607124739.1259977-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 508084fd-aab6-4266-51b3-08da4937d534
x-ms-traffictypediagnostic: SJ0PR04MB7389:EE_
x-microsoft-antispam-prvs: <SJ0PR04MB73892AEC770B72F6FEF6260DEDA49@SJ0PR04MB7389.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xqNL9bNyRMxLQL3lSAZ3oeS8Mq7+tltw7+gzVF1YAFmW5GQzPprJHlGRVBnGMV7bcGPvF2w+IEvpUvaxda75fFLE1KPZ+vCfhkI4ENGmY23+Y96+aNQFxwk6y3/lSdOnWg1LM2zS3WUHAcIp/YG8bnKCIkN5fYwLoV6qJC/War0mv5vosy8RTKKSjNO1uo5z9l3fMYF0YLFJXGK+sDvc+7/HeDRYI/N22RlKoaiz5r+TGndQDbkQY3Y62awpk/igMqLfsujbr+UimxLJlVYWCyMJIxsnaKOqQ5ZFo2su3z0wItXx+X++qvt4+q+L3e766WboakdoOJpUWMBWeHBU1HjyY0qfmPpxYkozZY2Od87ntj6L6lzZi0kXBuU5UMykei0aZvvLgRk4c4nC3v9ApWCPeifnHPMgPbfOBOQ6sZS1wYUF7dD9e+tdx2P25T5nIUkwUlRohTBNZ54R0ERxWjzCgE4/47iOi/QBR7RlbEdi+0K25/8DX5bp7UghihErHsXjnBDiLf2l96Drk3JhyU/IPYco4KPiO/GmwXL49JK//0KejsKRX+JnFfhooF7vGzHxICVzJTyD4SQDPZ7HgvQ+vHsOR49xuLDGSJvSXh+WI76HqosfteW5QaKKK7rfcVFWiOcOpjeCmQaJjQkSqGXCl562K9hTi8cT1D8fum9CCHmmAqUk1MuDsR3i1WW/6fKAxfhP90+DJst8sl23U3PD19cvBTz6jfw5LJqlyRsx+YkIqfc7zRFss8SHnmdh
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(91956017)(38070700005)(66476007)(66946007)(76116006)(4326008)(2906002)(66556008)(508600001)(5660300002)(122000001)(33716001)(82960400001)(66446008)(6486002)(64756008)(8936002)(4744005)(71200400001)(44832011)(8676002)(316002)(186003)(86362001)(38100700002)(1076003)(6916009)(6512007)(9686003)(26005)(6506007)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?T1JoF8gvECA0thaUlz2cToq1//O/KmaSSLawBsSf2/PCvCWIATDcf+warVHP?=
 =?us-ascii?Q?mLmEbuebDTxrqBYo7dtxaV7m+fN9Ki2lS4LXGHs04GSOeBxXuvPv01gMF9V0?=
 =?us-ascii?Q?p79MtOk6a8k4YQIeBUIGIQEOQEzBL91L2/zvPY2xqSTudc6kz3c1kjfUHUXu?=
 =?us-ascii?Q?MG0/3T6I+2wl1uLb3lEJoEDo2lU5LjYdytt0FL6aQfiyGWjKe8zJ4iYJ3/Zd?=
 =?us-ascii?Q?BOEYkCWrpP9oo0QzfOn+oty+sNAUBKbgm6MJs4ns9dhV760djFxSkDl2Kgrz?=
 =?us-ascii?Q?XkNAwo69bo9oY7HmBkCbJKD0GXN5z2/Z9YL09U24HblHxndZlTwhj5ekXhc/?=
 =?us-ascii?Q?76sSMAuQtHQvmkkNI4dPUBM8VOO6J8YgJreFB5SZabURkmBPDHUZR8IcqbVC?=
 =?us-ascii?Q?eCRtTbKB0yHGpNdNidVXJaWML8JfRhLPNCUDs5Er5cri5gUKDVuxdTTnO2H1?=
 =?us-ascii?Q?kt8lRQA7rtBWBTftXp3RM4pxfSe/Ccgx07pwXNb4IBa96qaY/ilpYtbtP9Tg?=
 =?us-ascii?Q?kMtcLAr40BUVlCk2DNwFbYdQ08eFAqnHIzAHB7UnArHobetI1+XBjnB3jm4K?=
 =?us-ascii?Q?MzoeQapuaBtfFn8ZtsQQ4flBNFbU+ODK6xDpnEyxxbEQvUAEZciI3v/HYGLz?=
 =?us-ascii?Q?IgndQ2v02kQ0ITjDoPJ987DeQkWE2G6/eDfYmsvDWdr5BXisHJh0z2vV5b/I?=
 =?us-ascii?Q?TQLWolS2dy9RLfNroG6hEkbRsXN4zetKkFlgQEogIyWXnyj5erMywvFWBiEL?=
 =?us-ascii?Q?cdIsy9YApcl2Ha25vYqPpf9zKOx6sn7mn1V4stTu2xXahq57wQ8OFL7JfC/Z?=
 =?us-ascii?Q?VWsynA4ZHsZvnwxUBXLI01umYjgQM8D6zmSHC8y8lq4GwGnsKRRQ7zYukBxV?=
 =?us-ascii?Q?jZbUaK1IokKYr01pCKW6wOP1kBbU21+hmvmfIYehmtskfI6eRCRpCFkcqCGY?=
 =?us-ascii?Q?k/JU2/YrbbuuoU4/QAwVm6P/GJtgf/w+iTmTzF9GGxTa+39yUiyR1xqtTFlU?=
 =?us-ascii?Q?GJCv6WCuZO9DXwmXekOzrIewAmfFhPmnFhKerxxAmGJ8nwxyUTQUoG5FO1uw?=
 =?us-ascii?Q?89zytKJgpPgG0Ccg8v4mLzs/s90omY0WmYnyUD2mNZbEAOeDZoHgdiHeodSJ?=
 =?us-ascii?Q?Di3eAFywfs3ed495YHpcQsSDbXMKXTjRljDydITea4mjC9wA45hZHdbtvyGV?=
 =?us-ascii?Q?kZErQuMoVGzvxIv/cp+KUjmF87fhKLOQ7zdshoSu1TWP5Cknci8Ihlkqf/ML?=
 =?us-ascii?Q?YyGjhOhTu0GVw1TrjcvtEb8SdbfiuzyG6p0qr++XzjOferVIp5KQd6LJ4xhC?=
 =?us-ascii?Q?ZHrAZ8civi8ra5TUEI4GfFTG8BZZvZv9NY7QaH2E3Qw7HhmYx9Z93Mm2hTWL?=
 =?us-ascii?Q?lX926Y6VijVwoTqk0XHMmT2RRw6BElnsHsXJw2wq3Ii3EKZ5ozJvHQlgsN90?=
 =?us-ascii?Q?VO1DCOOR6Wqk621VPYb7viBX38jQ0MNf6AvhMsk3wMXjX0ixJPwC5ck84jzv?=
 =?us-ascii?Q?EUJro6Bub78Y3KESToS7rYy5k9SFeOnQCz5q3MDKizsYp2EPif2CI4WoJ6DU?=
 =?us-ascii?Q?hi95I4K7qXlTfnT/yl9hcwtKWdf8DcCGE4hKVRpSabhj7JW2Sb616S5pk9ZI?=
 =?us-ascii?Q?AXgET+kFki+ZCYEyjS9/Lda4Ga9IsfNRpwAsI58lmH3HZdCer4HGMzhoP38g?=
 =?us-ascii?Q?b7Fc+dImpTLdfjd4qPTaP9Oz586M0PRFgvEVMdmhBWXlYMdBE+/X68MzjXHa?=
 =?us-ascii?Q?P2qQkqlqf7nOqHbInMFIx2kUGOYNeNu4UeB2c/aj48qiR5LAq+5F?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <A5D2EB53580BE0478CEC67ACCAAFA64C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 508084fd-aab6-4266-51b3-08da4937d534
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 10:15:37.5195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wTPCv9VqPMIgBofK8EMT9RftldQrtel7+UiBfcN8oR/OnNQ/KxpkpIUhM/F0KXwq2/hfPIe4zRtzEHR21ftMobm2cv88K8VaxWp1k/TsHwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7389
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Jun 07, 2022 / 14:47, Christoph Hellwig wrote:
> Hi Shin'ichiro,
>=20
> this series updates most tests that use null_blk so that they can
> work with a built-in null_blk driver.  The onces that require
> shared_tags or failure injection, which currently can only be
> controlled through module parameters still require a module until
> the kernel is updated (which I plan to look into).

Thanks, applied!

--=20
Shin'ichiro Kawasaki=
