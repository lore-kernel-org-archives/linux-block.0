Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EEE3ECAAD8
	for <linux-block@archiver.kernel.org>; Thu,  1 Sep 2022 06:35:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbiIAGf6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 1 Sep 2022 02:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232883AbiIAGf5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 1 Sep 2022 02:35:57 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F6D5AB436
        for <linux-block@vger.kernel.org>; Wed, 31 Aug 2022 23:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662014154; x=1693550154;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OeOWr6r4VESMIOq2VzeK52lCdu322uIILgchgkk2vMo=;
  b=qBw1/F1RfRdV6vH0ROrlW6Teue+uOUL4UQH5mHqaayEeAulLUfMAVpbY
   jrqFylnZ0JRPLz1Xp8/qVQK320WzIQcLww6eIwAju5ftw3dwCOfxPQ2tD
   X06QDxZIfqqg5aMzrjG4Pef7+NDwP9Z1cc0LiIfqi6XqDyV5xEUvJJ/v2
   eoQByi9R+fIZ/KmBH97/flwR0nBQX/LqB8TudhsCAZM3po7sxTAt+w3ua
   KnqMEc1Q+YhfNMku0WdS4etOrFWvAx2YVh8tl5mXg0HvNTg/CEDmy++6k
   sV6wyIoPyrfdgjipkWsnqpmAn5UxpgB08614xRKEAvMkYkdzIeo+id0mj
   w==;
X-IronPort-AV: E=Sophos;i="5.93,280,1654531200"; 
   d="scan'208";a="210198222"
Received: from mail-dm6nam10lp2105.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.105])
  by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2022 14:35:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RiGHVoKHr0lTedvYKzHe2LNRmqrRRyrdasgpuGM6p428oiJKbRPXQHMARVk1QBKnMlmr1XwAKZnT+FzyYQywKvkAXyvC2u1FOTRT5JjRo4Trl1SL4u70zuZB3+dNeniyWzGN1it7fmcnHNQ0ncK8CvDOhxmf637CDRUkuCt9/6q/50LGJCh0VnIW5O21CMMTPyNMqRSs8lDn9+pTxgHU1IcK0dQdYBklmG5Uc6ENBHRXyH7bpu5Ss1X/zsMtRy3Ne+y9+X1aB0AwZIhQXnEEY+pNb4vRVFgr5glVLMEvK2OOkif+RC/x6RqW6O0dUjBS/a84//fbcpd4351XB7in8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lGkSsfjIutp+dvfyVy9xrKEvY3QneA9nMNpc3zHlbM=;
 b=e8h/lSeAnwlRFZliH/we2rYdUGpU9rt0hTYeJnxAhr58XWCkmTwijqj7sEcH7U8CaCTg/z6en8OK+v8L3MG7erS8JVGRpWWNE98kvIWl9zbJ1wA33dunjQdFVeOC+Jz+T6rfpCd5WwwuMQ1JiQW/fmlOTLkA5muEaoU0yNNUVZdr6YBNBrXl8HASJsUwd8XFJDUr1Qank/Cd01J2zJAGmldRyrLYyqw84u652j5pd7ZhvenUmCZgmrs2W8KeB7tuol5GVRebQFNV0m5/eZTpsTqUvCMWWAVehyLMsxjjM8j8/SSKLwuS875krUe3tMegUZV+6sP50htlESGKESTRfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lGkSsfjIutp+dvfyVy9xrKEvY3QneA9nMNpc3zHlbM=;
 b=rk0aAiQvNdD0NOSq9uq+ac9NqEpqrZQBJN5mBvJabUZIE47A9m4YlibWGzU2VRbO25B13jHTYaRgzY929kLS3K7A1tUc3vs3O1b/PIM3wj0PWGNRJlDvF9RzpL8mtCde/kzG5g8RING7nR8uwVU3pYl1S8wKvnCW9oQYAmPFsWU=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 CO6PR04MB7794.namprd04.prod.outlook.com (2603:10b6:303:13f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5588.10; Thu, 1 Sep 2022 06:35:52 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c7e:a51:e59a:d633]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::c7e:a51:e59a:d633%8]) with mapi id 15.20.5566.021; Thu, 1 Sep 2022
 06:35:52 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Chaitanya Kulkarni <chaitanyak@nvidia.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH blktests] nvme/043,044,045: load dh_generic module
Thread-Topic: [PATCH blktests] nvme/043,044,045: load dh_generic module
Thread-Index: AQHYvPphkzvOf05a+EaJL4zCIKy3WK3I06oAgAFMiYA=
Date:   Thu, 1 Sep 2022 06:35:52 +0000
Message-ID: <20220901063551.djziyblzw6g2cxwd@shindev>
References: <20220831052729.202997-1-shinichiro.kawasaki@wdc.com>
 <cffbbd55-0560-4ec7-7f88-aae0d71676a9@nvidia.com>
In-Reply-To: <cffbbd55-0560-4ec7-7f88-aae0d71676a9@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1d437bd-2256-4000-e56b-08da8be4375b
x-ms-traffictypediagnostic: CO6PR04MB7794:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wuvKbBJU9Tludyz1bZQs5oj/U58OqRPnzl+cHUPF2vP6Ch0tGRQddY2kLpngRsK66/RuOfiivNldK4c0h94ufDXoa6E/MmDCVdCPdH54Kxhe2GhSLY5a4JF29rUbgHvIYI6ZXYyRWHwAF+tcMzLfAaIOIZ1guqmVgtOrqjHsylMIfS4+PiUcKms2UKCzT/p92Tf3ZRVVW4QJyX02WhHNKIV3ae7UVesKayjw2tqM3vfvlN79wjaav4wOLQIQA9zLTPGZqvrV6ACMjRaWGbHerRXOjQVQEP88wZCHR+7VEV+BBkVBP9W7qMscc7mO8SwXpqXqqfATtDwpebQqPn9h1v9+9x/UMaOmzbIKhLpaWx5X7QUjl8BZQgcwUKz7BDpTU56VPMPGUVVhduPVligYN7fj7q7q+oQh2tymQUADYenoYt3UQEOOrVutVJsz3SRjpEiHBcKxfdpr84w2c+xHd2RrmF+zLLIJWOvM5LhCdJo3ieHbh+BKLnuGSuRBo+ZgT3FN/Q0SizPpoKBnisKBcI8iEaE7/2lOCWMt/VXetUJULxpw0RlXaNTwhfjarzsAK8DkwNjhQonXSUF9a/TGRD1X0dWOGgnGhl7cbBkqOWhOv/Ni1tUxBSc1HlXHVD1ZUMD13nsl6ufZl7vB96mmYtKxDgzBz4SdBCEO2SkOnbH216/yhRM82RHTVUc/Xo1Hwr5HZj6U7XVJsIIbXnX/6aaMnGCcNBw8Dmjr4V3ISbNEnvPmfNx2uvHzxtF0mNPtdAiSj3VIlrOKAGxE+PZhVGKfPa8Ztudem65x/FGTkQx4vBpWqUy2EdyQbCiA7z4w
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(346002)(366004)(376002)(136003)(396003)(39860400002)(6512007)(86362001)(26005)(9686003)(966005)(41300700001)(71200400001)(478600001)(33716001)(6506007)(6486002)(53546011)(122000001)(38100700002)(82960400001)(38070700005)(83380400001)(186003)(2906002)(8676002)(6916009)(4326008)(64756008)(1076003)(66476007)(66556008)(91956017)(66446008)(76116006)(316002)(66946007)(5660300002)(54906003)(8936002)(44832011)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?UBzOSERLSudA6SU+Ee3xAqnpFciE2pAYK19KY724YgKN8YFAURQ4K/KpzpE1?=
 =?us-ascii?Q?fiOVwXJhLpO3z8/IaM0owPeSDIc+N2ENlk68afcYJwYJYLExs9vBmKX65EKQ?=
 =?us-ascii?Q?DQKE3PPpfABL6Q/w5bfQRoV8e/JiOJm4LjmEWPuRIOAAcks+gAHJFcrpBam5?=
 =?us-ascii?Q?hCevROdgk64AEML8W4m3x/6+WZFqe7EHMtOPRStOdSTZjPObW6+JJDCM9BVB?=
 =?us-ascii?Q?XZaCk9C2wWHRaAXd/gGgTn2OmyTRQF64Kn2i3HTfjFtDx6GpmhFaHNSGOlki?=
 =?us-ascii?Q?Aa0uhAhZTWCb5AZoUVUF6zAmf5606ug+g8cI42Uyt69yvJnWVAOwqnVdYVFf?=
 =?us-ascii?Q?xDyQlEp3QJvCRAXXH8pj8XMJXv50kSHjJvnV+efgYETJ2rF8Vq3HlNogngK4?=
 =?us-ascii?Q?xAoBxP6Az2nQlJwirp6f0gfVXQjpnek5wP7g8r/Eol9mzxSbLxfXsqxLz7r4?=
 =?us-ascii?Q?ARU7Kz0U80W9XNR8zlkzPOhtnZv6ynaGzXfNXot+b0IQ464u4E2CJBCiKnTt?=
 =?us-ascii?Q?zr7HKTQ6obJ6GU4AsO5rlquAW9pJ/H2GFjG8/SScS+B8h+cRiFhc+bD7Bpoz?=
 =?us-ascii?Q?Qp36MQ3eiqlg7O+CZ5bt5tp9ITvy0UuTc8LcU/5EgJydnORDZB/SoKd9JkNi?=
 =?us-ascii?Q?uDHc8F/Rflq0XR77yt8ihtseeMb3bXKhCc6dYb5RXUtQnSofbSpAgCn5qQbF?=
 =?us-ascii?Q?7h163CjCj774dSox8I1hnNOeS0019QeL0DJueiYU0owtaTp0goEvnsta7baU?=
 =?us-ascii?Q?Fi4I7OixThXNivYB6tqkoJcHcGUK2wohCYYcf/sBSXYU1yzic6I+BzBNgyYh?=
 =?us-ascii?Q?d1RX4RXidmdFQWfYZBcGgxgHkn8E0GwyknOXGpvFHw5ekojwcSeqQ2CE5dnp?=
 =?us-ascii?Q?9KWx/0+t7+46cED6jv+RNja7woJAjQUsnqyiEgJSTTmGPKAiOwvPjcRqELEb?=
 =?us-ascii?Q?olkm60c+5Nc7cLuZGKMlNk9RayaOnk4l2a+RwM397jqmg7UkTAKRSy9zJ50H?=
 =?us-ascii?Q?wR2C1VVAScXqpBmDTk12ZuGQzvkumtx9ywh2VksN4bBCTuS1jua1xVoBorjO?=
 =?us-ascii?Q?Ox73neOsvVUr6QJQrwtmtSFpJlocGowcQH+3IZ//cZkNshrCdnfNb5RpViTu?=
 =?us-ascii?Q?eDv2dBj6wGQawZOMsIzNvTb5786dj1hmZNnm7afVYN2GdHLAlMMQBvH29pES?=
 =?us-ascii?Q?BbY2CHJEJ29kYGnMSDWYJFpJmW1fFHeAwDSmKVTFYyGllX6pzlAZpK7AOf/O?=
 =?us-ascii?Q?AhUgKN1/OwNwWJW/V2T5fyk/Cjyk4rhQjCtQkQmVRfxjwEKKKx0/pl8FPBAg?=
 =?us-ascii?Q?APH/Esrz9EJmv0puIoY2VOd693tVDa026+FbWxxX+O48GVN8hxm06zdkVqve?=
 =?us-ascii?Q?8iM6T6zRdobudMfJl+YrnPDtOZjPkvympmms24u19HBfYNjfTW1pqFLvGQ8Q?=
 =?us-ascii?Q?68iQkEWJ3DMLWRr+ccfamTiF6pcA2kXUlO7v8IBzCA/BTRS27fpXgwiIWcZ6?=
 =?us-ascii?Q?Vlsdy2opmr3pz9qO7WguHYKjwpSQMvAaLUC/gewEwaobaF7/x6NayTARc66H?=
 =?us-ascii?Q?FtP6GZu8WAHXqUEKHXqrpsW1BZ+szXB2sAqvXgSAbZI22BaEGtPQb8EVS7F6?=
 =?us-ascii?Q?2oLJ2EKVdqAMtPnNBY3GeE0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <63E87B6F233FA74EAD46A97B1C1EB721@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1d437bd-2256-4000-e56b-08da8be4375b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 06:35:52.3295
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TRq3gV7ISGZK3ihIf13MYRufTautH8eZirJKu3GmbP+zVR2xWoj1ff3px/UIUs/vuZAfrxxKO/QPHgKDBcpXpf/xfk35oManw9I34/7VaJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB7794
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Aug 31, 2022 / 10:45, Chaitanya Kulkarni wrote:
> On 8/30/22 22:27, Shin'ichiro Kawasaki wrote:
> > Test cases nvme/043, 044 and 045 use DH group which relies on dh_generi=
c
> > module. When the module is built as a loadable module, the test cases
> > fail since the module is not loaded at test case runs.
> >=20
> > To avoid the failures, load the dh_generic module at the preparation
> > step of the test cases. Also unload it at test end for clean up.
> >=20
> > Reported-by: Sagi Grimberg <sagi@grimberg.me>
> > Fixes: 38d7c5e8400f ("nvme/043: test hash and dh group variations for a=
uthenticated connections")
> > Fixes: 63bdf9c16b19 ("nvme/044: test bi-directional authentication")
> > Fixes: 7640176ef7cc ("nvme/045: test re-authentication")
> > Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> > Link: https://lore.kernel.org/linux-block/a5c3c8e7-4b0a-9930-8f90-e534d=
2a82bdf@grimberg.me/
> > ---
> >   tests/nvme/043 | 4 ++++
> >   tests/nvme/044 | 4 ++++
> >   tests/nvme/045 | 4 ++++
> >   3 files changed, 12 insertions(+)
> >=20
> > diff --git a/tests/nvme/043 b/tests/nvme/043
> > index 381ae75..dbe9d3f 100755
> > --- a/tests/nvme/043
> > +++ b/tests/nvme/043
> > @@ -40,6 +40,8 @@ test() {
> >  =20
> >   	_setup_nvmet
> >  =20
> > +	modprobe -q dh_generic
> > +
> >   	truncate -s 512M "${file_path}"
> >  =20
> >   	_create_nvmet_subsystem "${subsys_name}" "${file_path}"
>=20
> it actually makes sense to move above calls into common helper
> called nvme_auth_test_setup() and similar code for the teardown
> nvme_auth_teardown() for nvme-auth testcases instead of
> duplicating the code.

Thanks for the review, but I will drop this patch based on other comments b=
y
Sagi. Your comment above inspired me to think about better solution :)

--=20
Shin'ichiro Kawasaki=
