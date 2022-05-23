Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E11FC433F5
	for <linux-block@archiver.kernel.org>; Mon, 23 May 2022 01:09:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbiEWBJc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 May 2022 21:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231186AbiEWBJ3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 May 2022 21:09:29 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65BA377C6
        for <linux-block@vger.kernel.org>; Sun, 22 May 2022 18:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1653268166; x=1684804166;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+wpOkFPyRj8DikM3FDo+MXnfaIic0qOjw2KTmmv+8i4=;
  b=gHF4+UWg4ffRQYiXvPnagWiVGJUT5iaiXRl3bduxGxfZ3+ye6N5ypAMJ
   wLVSp02df24RBcv5lBEoGkXmvuId6MiezZS+C2CLD7HUxSxOtYLHUQdYB
   K1YxmopBhQybq7TNW4rV5LROgnPpyWRjXrmRZbRIvVWLaANix/GAxIRZk
   8XHD/BUcR8/GcWh1TTKlWWEg5TzDthcBn2v9FZQuymhu2UjgoH81YTJA0
   YNeS4LL8tZ1C5h82k70pOxTH5Hu+9UUlOcytbFAa7TZBn8UMZdSTwjtjI
   Aguk/b3daGi2JLFfEivZ9wIIyDjLbda+c1EdaGNEVyeVe4x8HSVxLXYrd
   w==;
X-IronPort-AV: E=Sophos;i="5.91,245,1647273600"; 
   d="scan'208";a="205968309"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 23 May 2022 09:09:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NW3kNCr+n5jWx3auVY5nghfyzxAvFpfYvzL0R9qoJXQrStz811TWtqsT9v5Ns3/hZOUrhGcbbaDdmXMS3ivQcm4r913KoFQfXC3Ch7RI3kO9dV9xGUMsnFMIr649UbEYJ5Bn6y9i/ug9Le2JB13m237tMejVeIE0+7Od7emeVvkeGwp0MISuky97/PiRf7kP9zBZzuzgmqQxe4Q8jCF1ppdwDrNd1S04OuFGV4u+MX+wteaxE1p+GkGsFkUyjpICmjaPi68qjauTSSLjq2xpSEjgoXRTJnTm44sgBConk7p+An1mqFCf8tHqO9BZpw26SUWlY1oUqbinJlTEmOq0Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=miz3pxmU5ebppMVgwdiDnQ+hj/Jy1osvbizma5cEx/k=;
 b=XyNhFpFSf1h477epFHnwqMwuZybCtFEpWRp/YQJaEB6N6oIDxlIyyuuX6ExytRvHFWhfriSOoJcDL6imIKYSFAcUXFUFhnQWL59AE/G0zS9ZPiehkbJkddJEm7pV0aWaBBEP5pfSUyzLjO+eJMS88QBiviv1mBwqL2F3zFYOpHcJEimzftPmR7nfvHhN6FhXBdeWQLgJxnCjQKl/FSd1gIgm7/zJp5imn79fxNEqWFus9jg/kVAqHCN7OLbbsA6jQQCAWWjvaRFvfvLjkpWbqHK+JYwaqTbSEJ0Orwqlwucb2CcmkBTPvq/lExrTCPdbI7CSndd/GNiclGn13hfQrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=miz3pxmU5ebppMVgwdiDnQ+hj/Jy1osvbizma5cEx/k=;
 b=F1CP0NSxIoirAT9I4hZSkq8tEOHjrFNBR2pSjMCHFkHxgJW1aCUGh/pZ4xHHx2M+PwUXfptJ1I8t8oCddUr38TghGWRAvUdG3O08ZyDdOsODySrf+9+9gZWfE02GFSNOCTBFUqURylq4jcIWnn63fGiktASmqQCk60O2hzb+P78=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SN6PR04MB4255.namprd04.prod.outlook.com (2603:10b6:805:3c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5273.14; Mon, 23 May 2022 01:09:24 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::39dc:d3d:686a:9e7%3]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 01:09:24 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Xiao Yang <yangx.jy@fujitsu.com>
CC:     "osandov@fb.com" <osandov@fb.com>,
        "yi.zhang@redhat.com" <yi.zhang@redhat.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v2] nvmeof-mp/001: Set expected count properly
Thread-Topic: [PATCH blktests v2] nvmeof-mp/001: Set expected count properly
Thread-Index: AQHYbQ6PWTWInQpfsUS5qcjfUUQCvq0rqV4A
Date:   Mon, 23 May 2022 01:09:24 +0000
Message-ID: <20220523010924.e2knqxecrkmaiaqi@shindev>
References: <20220521123020.90046-1-yangx.jy@fujitsu.com>
In-Reply-To: <20220521123020.90046-1-yangx.jy@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 55efffa1-ca93-4997-f001-08da3c58e08a
x-ms-traffictypediagnostic: SN6PR04MB4255:EE_
x-microsoft-antispam-prvs: <SN6PR04MB4255A464B21B021C378E76D1EDD49@SN6PR04MB4255.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9z2lscX9ceXzCe59SlYpwB/02IWLY+CND3n719IKKGsgWpIV+PAz4I2GMtgk1lQMQH4KImIMchxCoUik0RTa5zKCTYITpbYYrX1a8AAFo3XLELi3y0Hi3hO0tr28G1u0eivpTnxzEqTsn+/fpw4JvbAtquCkkNsEAT8NygpyTnaSAFyxocrhpI26blNYw95qvETznCGaOvrVyEIvDEt+lYIo3LvlsbR0Qd1uETvmyU78pqKR4JZdf1oAYCHoQI7ZpG0jzJYXr0jhhy88qzmLQnWzfie0cMT7gLSbS+urWV5xYWDlgVLV6Y2PJ1Z9ivrrX9EuMJ3KNFqDHJsSdqwYRRkS8+QGgloclL5k6BoyiZMKeKAmEpwYorSMbeHHsAaujU90J8Q4NJYDPLVsgtiJdjEak/tcnWHLiVM+6V+lI1iiWT6zHfY6PKVEfZJ5E5a+JObVO2/ptXT+FsqnXWDaa/Xwnm//Znx5w13vWO3tmpUh/WG8G7GXup3s/cYRbgrNJpBOkIXtvzJAlLNTHQK07I1FjE1LkbOWMZaVZfjR7w73TkZg326pZ3Zc8lgabefCWqXABQ24Az2qEaaizQQJO+tSmcVgPvdjVO76e6TPNUWNIp+ZeW4MkrzzSNhd1SNlgBWqM72jgmPHWKQQO7u4vH7DrznUIlMpg0BdgB6BJJYfMKcEf8wuQSNLx/J09/9kzi6gtaZ90+eHzNq97pcVXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(508600001)(71200400001)(6486002)(6916009)(9686003)(6512007)(54906003)(1076003)(316002)(2906002)(6506007)(186003)(33716001)(26005)(86362001)(64756008)(8676002)(4326008)(66556008)(38070700005)(66446008)(82960400001)(91956017)(5660300002)(8936002)(38100700002)(66476007)(44832011)(4744005)(122000001)(66946007)(83380400001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dF0BGZThM9j1FnjBziGn3m78BOGI6lH681tCyOJRfid2LKI3rKU9OH+J7bjE?=
 =?us-ascii?Q?H/Lm4cTPTaGwAD7YMvFtk8UTaU/6HPX1OJX/I7L54SJhjh/QThidlVWfzk61?=
 =?us-ascii?Q?tj3YkhvETYNdUF1jyvEmQ+Kb68/fZpzm9QSuC5XDUs8fmtOTKPCDX77BxODS?=
 =?us-ascii?Q?2aS/61CpyWEAHfqKZPTHJt6ShnlL/6A/tk2NyhBSoSlyH0oBo42gif6Ly23S?=
 =?us-ascii?Q?wp+NpxP74JaSmeS6sOgPRy92IeqEXCjsu3Jvoy7Qm7Q52ZYmEN7uITVExmKg?=
 =?us-ascii?Q?tF5DFUkERm66YxwekUQEDFnONHHl4XODJVDdjHifqWt9XZ2HdEG9CoSyDtMZ?=
 =?us-ascii?Q?bxmXNpxJcoag7p4p1T0T7wv+xo6BePk6oM6dyWQVHekE3jqcEzb176a/R70f?=
 =?us-ascii?Q?UpJUWCvXdL8KQ4SvZKMTUFJVYLRnAmOdtp1U7YZgEHC4E/q5hDW6ofdqNt9M?=
 =?us-ascii?Q?g3U2H6Rr97y3JsAxg2QCZbtvpk2D1+A9LaxwPAd2IMra9eS0gxUjtuBB/OOz?=
 =?us-ascii?Q?QXkR9yp7U/+k9vRs7YxgePq4jTHWDawuGO+k2Gok5/ju6VfKUR+D8IFbCVsV?=
 =?us-ascii?Q?TNFV2OWPActFkO2uCsNvM7dY643ob9RFHkjGbkiAa7zd7IGMYUf5p9WhpT7/?=
 =?us-ascii?Q?LQv+K7Eif/uJ8B6HifuOdNp8oor5R1icfNvQl2V1pKybqOe7lBxD8niOrAj8?=
 =?us-ascii?Q?cQUmvKp5d3iPLaC6khuc8OO1fUoJXBTYtuaj1ua6opjMDCOfyie1RKjrT7dt?=
 =?us-ascii?Q?pSl++UetQCNS/gu5mZqukfsBc+aYtWurPfM+7EL5SHy/nYU20Qn/06FLTHm1?=
 =?us-ascii?Q?NZYcmNA6N/Ylo7hZttn1zuwSLXxZw33c4sUkVn4vvxDBn+C8ZUqCBqUET2T9?=
 =?us-ascii?Q?73iKYORY2IFTYkUK3DBTJlGmNhmBRmgmtWjFSNWKEcCZy0wmYZOKlCz0Pnio?=
 =?us-ascii?Q?sehvL1zqHKGgIGZdEeDzKatxMHa9cSpQbHkXiN4qDf232XUh+KaBHjP74S50?=
 =?us-ascii?Q?mqWuwyvpnZqbQ62EoHkKBGX0C1/LcZht3p8PmIIqbrYvscRj/O2OCDFKL4E4?=
 =?us-ascii?Q?LwaKrN7SWD+T791t8qkANhytzaSDB3bAOQlaWlaGgTfgzaKmAEteNWY3jZTx?=
 =?us-ascii?Q?Iiatbo4cyzMlyE2SAuxCoHDZOKosSN97iCSAH0PUye5XAvnSCvOHsChAYW8T?=
 =?us-ascii?Q?iu/yfkBRa1mxWPjWFEo2xKUB6h6bpR9Ep+yejpvCIedp14iSdyQXAlh/Lh1e?=
 =?us-ascii?Q?v3LNWg3mO62uBc2cZElpW2PWjGSNzmSLD6LYwHhhSwxDdO/JZWYFWP1VJzlr?=
 =?us-ascii?Q?f4wJv2g0zbkQfO63Kq9HCOrW3ehPqt0vVIHCYdfrK2Yl9s8pKrlR0L6Kh4/X?=
 =?us-ascii?Q?CDiQd3dynCH66OcgMVq0nPIlnI2e2yWlTFm3mr2HxE5OMVekCgLW3txYgzOQ?=
 =?us-ascii?Q?0g3MT39VyCAEoksMTBK0HOhOe/Ba8Tzmty/XLv4TXSgmrTtVDAuGLjfMt8y7?=
 =?us-ascii?Q?HAG/kQjhf5TVn2p1v/CkGbjqG35G9BLjfL4UvqFUGfM/PfJTPzJqN2ML6Z8t?=
 =?us-ascii?Q?Toof1nZmQy/eYnsi3tJvuJw9tnSa+6VjH+3dTqkCmwlkkvVH5VL1+3yPK5KM?=
 =?us-ascii?Q?QviIoytXTU+zjRH+q/QE/KLrXZL29R7GIsq5/pRHPrF9SqIdhb0EMy9aXyqZ?=
 =?us-ascii?Q?kbuJhOVCnaaZ8HgYXXVd6+5yMOUJ9fl+Sc6tjoPUfMymF5VRPqXfNaCkTNb7?=
 =?us-ascii?Q?mDICfnkqTuTXZ5xaHwDiywgeTLiw5G4EmfqUdbIPKups86x4AnEx?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BAD46EA2BEE9964882CE9FE1BC57D435@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55efffa1-ca93-4997-f001-08da3c58e08a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 01:09:24.7868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hSdsDTwCoJG2a/B6Rz+ZZS2jRYQCFZN6SD8HybIGZVO/UtLgVzFVPBcOuD2iuGlLZ0iXeqDgAl9quLrx5CKHXPfvU5dSb/yVMk220ioR+N8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4255
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On May 21, 2022 / 20:30, Xiao Yang wrote:
> The number of block devices will increase according
> to the number of RDMA-capable NICs.
> For example, nvmeof-mp/001 with two RDMA-capable NICs
> got the following error:
> -------------------------------------
>     Configured NVMe target driver
>     -count_devices(): 1 <> 1
>     +count_devices(): 2 <> 1
>     Passed
> -------------------------------------
>=20
> Set expected count properly by calculating the number
> of RDMA-capable NICs.
>=20
> Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>

Hi Xiao, thanks for the fix. Looks good to me.

Reviewed-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

--=20
Best Regards,
Shin'ichiro Kawasaki=
