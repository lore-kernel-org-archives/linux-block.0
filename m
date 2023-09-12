Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AA39CA0EC3
	for <linux-block@archiver.kernel.org>; Tue, 12 Sep 2023 04:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237732AbjILEBc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Sep 2023 00:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238345AbjILEB1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Sep 2023 00:01:27 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E2CEADEE
        for <linux-block@vger.kernel.org>; Mon, 11 Sep 2023 18:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1694481954; x=1726017954;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7MLyPvwvq2ZyQVJzGopKMAhSk1T6u/GhY9D1pHkVTyc=;
  b=DSZnmRxBnS13Dxk037OMhN63US1ZhT7/R3d5vXu7EIQWfB89UKzZREac
   dkeuncVij8RMtq9X/Q5Fi2XOvfLLAPE5v+6pzWypqNpRZ0YeAcZSW9QU/
   66zqWdx+XNZV9BzTzmE27/m+LMUHKWgXOyxiU6SRmIizM+0vl0wl6soDB
   Dxe8epA5C7q2jIAKXHCIFjf6SWnccatneZE/pMNraJs7bG8wCTcgYb5/x
   k3HvnYnisf1RnRYZvAzH4n7hpPN95bgL9PuyCmUvrZaUXQ7aJ6hfoGxPo
   uKJ3HBusJrmXP+kVmoFtVWAftHMbAaxjrvUop/640uwFqcinjslD3lkfy
   A==;
X-CSE-ConnectionGUID: JXlRLcpXTaWFG0QeZ32Nvw==
X-CSE-MsgGUID: lZ1fmP9SRQC+E1tJzOl9zA==
X-IronPort-AV: E=Sophos;i="6.02,244,1688400000"; 
   d="scan'208";a="348975610"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
  by ob1.hgst.iphmx.com with ESMTP; 12 Sep 2023 08:18:42 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=efL/2sMFgtTOoWagBY4BYYyTbQq0no21sfLr5iZLtPqHzbZTERsBljI8BLA/Tnc9fk7HqsNC2TcnyUilwN3qlCv+9UFUL0hiJno3HqXFfCr0PY8XWrF29yHCN7o2aBNtC+dAK2QrtvWVDgRrw/wVmEFmsu8FZie75CjF22wLYTkujvzSwYD1COiL1T9diAC6kNRuLq85WTyh7hQGH4DiZvg/A2gEhw3o4S4hyCb4NVXNEy0KSYLVnBzVyjfe8d3aa9Eouij3Ti6l3vq3xjWoccK+D3/AKiBYK+LVmvEhWvYBWA87x7NDgH67urcuuRJHiWDZMobS2zLRZjmJ8PUhIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7MLyPvwvq2ZyQVJzGopKMAhSk1T6u/GhY9D1pHkVTyc=;
 b=MPrfj+p7rhnjCkT6Xy1jOet0OeDO4mnoO39EtAMgrpv2LBQhYEYeQWeFLLLT8WuFL8YgSLuUudCcf/CwWi39Ch5a6ihzO7Rwxcik8N283DQPqQD1T0wSNplnPJ9fJwZg8HMpYD2Zpf/KG5uTxNEG40YUUrmJCrRv+7EArrEgbCnXjeiGWP0b20sQ/DvzkpVps/tBmpj648UPKGwNA1TG/NpBqcYsILQmtaALMW1ERWhF8cnDrGWMt9nM8sssrFleQB17bLghOt0cWBHS6+/O/j6GuaWaQxS5hJmjono+eRhn6RfuKrlyvveb1oV3FCE2puZJ1E4Npu2Nf67i66A+kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7MLyPvwvq2ZyQVJzGopKMAhSk1T6u/GhY9D1pHkVTyc=;
 b=TyeeYsVH+pdo9TvNZnM8Mt6POVn1AYTC8L2nBPjp6P5C7NPJ2wgo5HOYjFuHeHSGxRy3waOBx7rAddm6HiK9CYZY/qcjoH2qEa7z3f9IPxFh9TAcbrHwf9dsHHXBfDVODZut+An7Kjk8rFN9cTDNCoJ98dk4oLPNZ398i+AlaWw=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 SN7PR04MB8603.namprd04.prod.outlook.com (2603:10b6:806:2e4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.11; Tue, 12 Sep
 2023 00:18:41 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::f92a:6d40:fe94:34e9%7]) with mapi id 15.20.6792.016; Tue, 12 Sep 2023
 00:18:40 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Daniel Wagner <dwagner@suse.de>
CC:     Yi Zhang <yi.zhang@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests] tests/nvme/031: fix connecting faiure
Thread-Topic: [PATCH blktests] tests/nvme/031: fix connecting faiure
Thread-Index: AQHZ4T2oqmvmMH8z00mCjjVD3irOrLAQzBEAgAAc5YCABJLXgIAAFVmAgADJtAA=
Date:   Tue, 12 Sep 2023 00:18:40 +0000
Message-ID: <ggzlskxy4o24zsr666g2rmbzgyqncbmo7szioqxdxn4ubtmekw@menj45s4ym7c>
References: <20230907034423.3928010-1-yi.zhang@redhat.com>
 <nrfuja62qetxqxzwxuxhjve2u4r4reofcpo43zmg6qbbhjjqkp@ratsu2kubymb>
 <kflpcc7u4wksuuo27gcrjxwsqr277b3phpnbbbjkdaniycmttn@f6t4dadmvqih>
 <swd5rjag3soiz5b6fkktk5vncfjtb4wemrbtl4fwkpcx6uodg7@5wnw5gf6luz6>
 <ndeue7dj4w4w26tndeya2imsct3s4c2ay2a7zpylfvahizn44t@taagv26xb3ha>
In-Reply-To: <ndeue7dj4w4w26tndeya2imsct3s4c2ay2a7zpylfvahizn44t@taagv26xb3ha>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|SN7PR04MB8603:EE_
x-ms-office365-filtering-correlation-id: b7fc017d-23ab-452a-aeb3-08dbb325d12e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2f7iEV+9AOmqK6oSsPuvMXAJnm7dvXoCzal64qtON7ujgeo9IJOIOd4d9XNyfM55ySqf8p9pHnsqXZ+8rcC7KzpHABE06xw71fFskv43TDkhCheQmTARrmtOAi+fyNFmaO7Pey4n1KSPuy0ux7A0HxzVuMJ98yjIlsMSjrvJjGeGpKsVi3puFC9NQpNvyUXulQu4P22yUYasJOmMax5uWgFQdJ8JpnC99DgumybmvzHxs9amrymu15sApmmz4QPeuhvmWt1FMAVDw38QGFGEMZm5qQsy+wbRpfhYMUhyKa/SqgV9yQkhz3KcZtRX67z0VFxfWy1vwJvxsqeah58rwS7QfiYr+E6qfAXWt7fu9bc2Lj2JemOTR+LjMiGvkXCexw2luI93s5C8IlDhZquvPT+4YMDyEmJEY4rc1LOn6WWTPQsa0dozLcwxQi0NdzLnq34HPBMNfCbm6oD3xeQI8Enx+MlaFkereGaXNwT9Zr3XXLsZ64fT4EpvVpQszCi+ZscXJPAI8t0U9YCGZsoTaME8Nf+Xm5Otr8N3tzfO2M2pSENJfHHM4+x2d/f6rzLr9neNnPFMz7tKetv/OycP/2Sy+NFdvRrjRwPdAv+P9HsFnUi4A4A4PkHTVAolJgy3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(39860400002)(136003)(376002)(366004)(396003)(186009)(1800799009)(451199024)(6506007)(71200400001)(6486002)(83380400001)(6512007)(478600001)(41300700001)(33716001)(9686003)(66476007)(66556008)(316002)(44832011)(2906002)(66946007)(54906003)(6916009)(66446008)(76116006)(4326008)(64756008)(8936002)(5660300002)(91956017)(8676002)(26005)(86362001)(38100700002)(38070700005)(122000001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?YtwBypdUTyX1PJgDZcCprjNTbgMk6xruI71htCdHA2O1e9+Uo9GCv17geydH?=
 =?us-ascii?Q?JY+wkWFh/IT5Fkw7dhJkhi2FnLRlBFJ0JHF5roQtar8sFVeqSaBXRjgNseNg?=
 =?us-ascii?Q?Kr8iEY1dmjTn+C5nqW+BzDA7fFokzRShthgmij8Lx+pwOs91pN1JXCywnD+B?=
 =?us-ascii?Q?G7FqWSf/wSmLj/uuiwX8xeUlTU6N1jUpX/KMR+2fs/mSuORxwa+Mt6nJpYt6?=
 =?us-ascii?Q?JAFr0eaftM7r2qs1rstPOoHRJZGHBcckoxRIM8DZeclh9DfXCGfjyw0sWi94?=
 =?us-ascii?Q?bi1N0o3Qzsk5f2iVsixyTeXC6Hh3qyGYRgRkRSm5d2rFP+60g6jAuFU1zjg0?=
 =?us-ascii?Q?ndU/0tKOnrpPPMY9k4hbaaPJduEanXRXn5dqTBFCZ58S7Wz89ovnHsWQquV+?=
 =?us-ascii?Q?sIkXZtaT/cZRp0y5jLoOv+lRMMvsbyj4VUxl4XOZOYc1tzv/VThYAxQIqTOQ?=
 =?us-ascii?Q?qq2oEb+RgOZlJo204K1rk4nnEVAk0Blxj04FBZAiKBknnkVosiCwZyShpiCg?=
 =?us-ascii?Q?T5gun0hgGICPUO4O1jX3xlQVOSZABXwyFYL3wEMbhoJnpUM2VsdlEoqMGMO2?=
 =?us-ascii?Q?WznalxfOL5YLx0M1mdTNmjTlRUuwE1M448AV4IgXksaIRePTGysPpHONzKjh?=
 =?us-ascii?Q?qd0+8v1rjgNDy1GVWxFavS+uGTWZke1EXRRElGe8rHA8COApGfhHDidPuCrI?=
 =?us-ascii?Q?GI1dXQHGhp+P6TYfzeLEj1t794UjKuswz94ju4FXTnsI1U/IzbUxazFhM4ee?=
 =?us-ascii?Q?JuLtCSqfV1yxzwDt3om60soET7wF83p+aaFXZhDOV1pUcQJCkTeJIvPLa/vt?=
 =?us-ascii?Q?07n62xelXlyH4OrQlhkwemNakqUcTRINBpjAP/SXnjI/mmbNzRUY3G/2HV9L?=
 =?us-ascii?Q?9ud9lzrXyAXndeoLuLNqhwtFX+j41XiAJVtFEZzE50HwwNZYp3f3o7dh7EmK?=
 =?us-ascii?Q?kenMKPMRPNchmCUcDBmfR+7iDRWWSUV6IcZJzpHj1x491Efe9fQt0LqNBDbD?=
 =?us-ascii?Q?FUK/q0dYUjsX0daX370pggNMvDNYIzgF1SbMvx8GZptxJHvpukEPZ2YY73bg?=
 =?us-ascii?Q?3X1oSx0jXfMps5HVG+d3vQGBd3/ILfVL8hUoamMbaW76WdbkOuOFiG3P/qB2?=
 =?us-ascii?Q?wfK9CI73z2TthULR07X1iTldSYHM5hbZMoyrBNrTv/o+Ktz6sMdrY9ezz4Yc?=
 =?us-ascii?Q?QCOJR6XJ+wu4XzsMj18kOXA1UmbEtfYVSMMFBStMzS5ltYcEeH4AiywqSDeG?=
 =?us-ascii?Q?m9wpDsEyPmMAHyu8/Iw/wDZ7nA8EMKUQ5BYDjGD0x3D4IAV39dkB1p2Xf02K?=
 =?us-ascii?Q?SCslW6aUeu1S3nMX6rFaGOLyU0f3m5lJKybh0KGgjohCc7O/LUwzBPRF4tlA?=
 =?us-ascii?Q?dZekhGN26WLIe40Stx3rbjFb2dg0NU7HP216qz6ZUezD5bQjKyBJ8QVnC2SZ?=
 =?us-ascii?Q?cyYG6UZtQa/Tpk9aXFv7v5WIJJzDcxRh5vr1XV1rqfjhROYEGCIKK65WUI7k?=
 =?us-ascii?Q?Cofv5wW7N5jHea4B+3bhsqvp1oCgwB6ZFoNWeJrChmv/Mh9dVtgmccS3+voJ?=
 =?us-ascii?Q?vhcwZLu9fvO9eMryIt0CGg9FcSMocZwrAi1tde6IaYFoMuXtGMkFNGG4qGNp?=
 =?us-ascii?Q?JzAPOkIVepCk8+RlDp6nZCU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5D3CEA7E546C85449D6B08FFD7C2F105@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: j7fhQ8+JnLK1jo/scOdhIoWcZ+uKaZSWy9Bu3WJpb8geHlI/arLyKw4sxpXcW27R0UQh4L1vQw8RhPGDA4upnWuxQkErYg1Xy2QvnZjzoXLwPge9PZ2DVW817ad5OK7z4KSbsWRSwBpjNTZ4rgAra6RgZgM7BoQBMeld0DRRdWHTv7mDljKFLacW8qxyUnnxtMNVcAeE8MWtgyiFGVW7FYRALKD8bD8U4Fy+0aUqKw+I3a6REd7icC8jp8uhs/0IUet3t8+VW9UDhm2PRYfm4lsUklSWtc8vczLAUFxin6SFrsM4WgvYlhFD/KOihCFLqNdEoI9JmoSvB169nnXuhF+E5GAwSpRYg0oNdNlOoTBSz13lNb6VYBr4H/3Pp88OoNkEun2ZRaDhGrMpNh9aPVrLsf0EUIFNzxmfcWjjZ6mj3qpCiMDpBkixAue1ehp/dnjs8lxGHhJekekuiIniWx5ZtwdZ3DtxlSFWOLXBFi4QNrEcCk8jMKFdVgkNuoXA/4R+lCGwQKZr7Dq7OjP2U3I7Ndk5j0jQ3fNPjxQRj6DCudZUNXPhjuQCDleKRSniZSIQPqjQnE0p1iOXS7ioCfzsJjhRT7UihAnmOMVpl1a+i/Vjwjp3qIKibGC30/wxh20rIk5hgandgIlDCdY5z4LNyv5woInip3YEfdOVXp/6FlBnGqH7XBkqjFPiNQ2neN0HVJJ61CMHfdzUz/DGmcZXv8ug3/UM0yMt1bEIsr8fugsXgJPnTTKfGuEaTzgDPWOz72de6JgWp+OIAH0t3ZJpYU2EL2ZRrrEYj4IfG0XJrzZo1jRqiNdXcQHSzWE+NWMm1cqwDqkJQd7mhZssC4Daw2pD74CJxlxYOEqpHgCALBg/KAlIPD6Vc4PHyH8i
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7fc017d-23ab-452a-aeb3-08dbb325d12e
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 00:18:40.7274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o3vObA/tiiTS1d9y1HAmZeLegHY8yaLKMULkllAh7SFP+mI5H1sYoxj4wjVgCY+O4ekCM7DoS4Z0rF5LBt95282FhxPqC7A98y6WCUnDqWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8603
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sep 11, 2023 / 14:16, Daniel Wagner wrote:
> On Mon, Sep 11, 2023 at 11:00:17AM +0000, Shinichiro Kawasaki wrote:
> > > nvmf_wait_for_state "${def_subsysnqn}" "live"
> > > nvmedev=3D$(_find_nvme_dev "${def_subsysnqn}")
> > >=20
> > > We could make this a bit more generic and move it into the connect
> > > helper. What do you think?
> >=20
> > This nvme state file check looks a bit complicated, but looks more robu=
st than
> > "nvme connect" command exit status check. Do you think that "nvme conne=
ct" can
> > fail even when "nvme connect" command returns good status? If so, your =
approach
> > will be the way to choose.
>=20
> Currently, 'nvme connect' is a synchronous call for tcp/rdma but not for
> fc. 'nvme connect' for tcp/rdma will report an error if something is
> wrong but not for fc, because it always return successfully.
>=20
> The nvme/005 is exposing the behavior differences between the
> transports. My long time goal is to address and make all transport
> behave the same way (unification of the state machines). But as it
> currently stands fc would need someting like this to make sure we are
> not blindly reporting success just because the 'nvme connect' call is
> successful.
>=20
> This type of check would make the test suite more robust and better in
> detecting errors.

Thanks for the explanation. I agree that the nvme state file check in
_nvme_connect_subsys() it the more robust and the better.
