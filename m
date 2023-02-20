Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19545C636CC
	for <linux-block@archiver.kernel.org>; Mon, 20 Feb 2023 13:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbjBTND2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Feb 2023 08:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjBTND1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Feb 2023 08:03:27 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01BF59C2
        for <linux-block@vger.kernel.org>; Mon, 20 Feb 2023 05:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676898200; x=1708434200;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=6DAfsIpeOlu5bnvxDQDgU2MgR/5Kv0McoxOsm2iWUPs=;
  b=PK8zSIh+LU/urXtW2P4XXTC3Dp0aYa8X68Sy8olkjJMVnv0+H5IXJs3e
   owxoVwZX0TpvFtofeVBx8XeokCkVrdksJ+ZZhf0e0SozRxVKNgiz58XzS
   gvc4m9jEWjyF/695u5++DbFVBLUO8B+iI/KJq8It1ps4km7HpjnSOsdnI
   Po/ZtRh1vxikUm/Z4NhRsAogXb3typ9oy2KjLW8Auf9Te84cuIZUsaUuc
   T+yzCDWQ8x/RH1VX/lOM31ZePDauvio5DVDmBpGe2zL6EAXyH70vnZE5C
   rO/0v/fFsWRRjn9Lh+TWdyFAfruzzCk9Z9XSOJn7a1SiZc9+xNNSEXJWQ
   A==;
X-IronPort-AV: E=Sophos;i="5.97,312,1669046400"; 
   d="scan'208";a="335702675"
Received: from mail-mw2nam04lp2168.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.168])
  by ob1.hgst.iphmx.com with ESMTP; 20 Feb 2023 21:03:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjQ4sgm1BJqBDIfthikO8AO4nL8mlEp5N55aFzOoAgkTcX5CP/QkBDPpF//6gg3eT5kyroGR8ilLZMFkRABqFS7bSb8ZqGTFv4QjgItaIZvze51knfwp1AAzbURWmXaO8D64D9v2tqIm2AeqsS8hdkTPB9bbg8SdWHFktqSlj+ZnzQRm1REZ6Yn0ynV5h69idbRK+eECYVru5NELeYQWlsGARMywo6Eih52X4HPKWC6Lu82S5IwlN5s8W9jx1HloQuVtJyFHmIBSS68wCszqcmD7uxtGPswJXCKU6L2iaTUt0q+0DKmMPi3aGnwQfdHwQCaetgHVuAxpRia0JK2FWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XqEiGexYHdl1E9mkjsREOiOh5HJQ6cWdZUZngJ2mCBI=;
 b=geU4gXprg2gjn+RD0s6xYhiSyffas0gdY/AfmSuRJrQ9C5zdr4WnZTC+8m8IqszrzOz5wsiDecD5Fitkb/30DGlm+yth4Jq0yxF/ulQnetE7vwrcaYotTXuZ8An9lOeJBzegMqUH+P7GQKMGhU6Lu42JHJecAhI9Y4r10or0tlQ4MvRiqPbUYPz3uAvtlfVPPRdOtuy2ybWt6skGRt4/Nvy+tTZ0cIZkytwDtfWx0OcrDCnncED66YuQMM2kgv7q/VtTRBkPPIVcSeWSsDr4Np54wKYiev0nDfKRGZ3g4EhwvYGn/1MIUK1zTvsyXTdMDmbmb7R3htlzKbOFDRDr/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqEiGexYHdl1E9mkjsREOiOh5HJQ6cWdZUZngJ2mCBI=;
 b=SecZ+h5SrebrPcE3czdxVbvmWXaIssBHhRM8sEhC6dFS1nFfAaxbczkomzPOnRGvvb3g3GLQosRbc7WtPGW2nbNjmBgcAsf4KKe72OhUtAJFu3TAVB2ocYxaRi+hX1b/3Vnqn5b3vLhPlJhMx9xchWwLgSeFZNqpBfsKEa4tDBo=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BYAPR04MB5718.namprd04.prod.outlook.com (2603:10b6:a03:10c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.20; Mon, 20 Feb
 2023 13:03:13 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::1b90:14dd:1cae:8529%8]) with mapi id 15.20.6111.019; Mon, 20 Feb 2023
 13:03:13 +0000
From:   Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     Ming Lei <ming.lei@redhat.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v3 0/2] blktests: add mini ublk source and
 blktests/033
Thread-Topic: [PATCH blktests v3 0/2] blktests: add mini ublk source and
 blktests/033
Thread-Index: AQHZRN4A+WOORP2dsESCfjPbi86yWq7XzaKA
Date:   Mon, 20 Feb 2023 13:03:13 +0000
Message-ID: <20230220130311.ilddmkvojgobvgpe@shindev>
References: <20230220034649.1522978-1-ming.lei@redhat.com>
In-Reply-To: <20230220034649.1522978-1-ming.lei@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BYAPR04MB5718:EE_
x-ms-office365-filtering-correlation-id: 28184ce3-ba11-4e8e-41e8-08db1342d315
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fgf2REpPewXkXIs/+UnEonfFmcSkJOCAiFhV6UP5umRMWk5RKzh/KR44Hn4ts+VWjAQMAyrSOD0fCeFPqwj6cmkYKnC4NwtVIBYyKG1jttmaKUGxBzPBHgDdlNObQ3/iqcs7LKEUS3JkU+/E+PbSJEe40bwKs/5lRB2I99qA389GXd5pzV/p1rgdFaAoMi3TP1v3qYXnNZujpN78j4Xl7pnXWjQjNpSbdH/SnSt94zFKHw1WvpPfXctm6ppTpdyB2Tb5oiHBl3gxRqBpuO6z3ydQoF+wD7eB0LV6W83aw5efl0nIcaq6fxiLwt3w/PwhZvk8+PmuX/yhdwxZSUnGIUDlwQLIW1MUYUHMf//hWZYYLC3lkaz0GvcCuzlcByZle61HEF8moixazY1829DjaqI+WD2JjVllDmnFmNJGMo9DAcd/7rLFd0vyGT0IAX8qrbHoM+1C1JODngLs3/9FRFsqQsb2ukowbK64jrKWgQii0FCoI9RHkFSuENDOyv8DRuGb64CLOM/RcFDXCsqPiTrd0v4GnXp4a3ujY9eUxeV5wUpTSKSB3N7c2cLNNsWQdxrHtRPYB6FVs3Yx0Fvdh0dtENcJTK0VvhG+cBKbpbcun4kcfjHfOgm4ryymnS9Z2JJ1LjbwlkyrX1BC+Hd/Hpj/6KS0tJEb2J9wCn3Lo053CDUjObYjuKAW4AanuqjDTX9twmZI86F2oPPwJubvGA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(7916004)(39860400002)(396003)(366004)(346002)(376002)(136003)(451199018)(9686003)(6512007)(1076003)(26005)(186003)(6506007)(6486002)(76116006)(66556008)(66476007)(66946007)(66446008)(91956017)(478600001)(316002)(71200400001)(64756008)(33716001)(38100700002)(2906002)(3716004)(4744005)(86362001)(83380400001)(82960400001)(38070700005)(5660300002)(8676002)(4326008)(6916009)(122000001)(41300700001)(44832011)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?o2lD+hpkz6EZI+HmYUf1yDnPeAwjHRzF8x/f0Qa/kgln1EsDPM3dKAmwven8?=
 =?us-ascii?Q?7gKCv6efkVRUkYMi3t4wWveP7LjblLPlUn6xqUD4ihlttVIav1wKZ0kLD6v3?=
 =?us-ascii?Q?SGUi/HdWKvFPePZtJ2OSWVpVi0Qm8T9EUIakCcqsnu/CeNNLvCGFFbeH2qGs?=
 =?us-ascii?Q?Pa+rZ6TdVpSztGPVPyvSD71Iymchv1Hztpz25/lrgiDpofBmui4Z5uHhfLYr?=
 =?us-ascii?Q?90IEbVOm93ohiMeYGazWdttsb3aWNTEtR18q/SZAbJeSAKmgzN88/TIYfrZg?=
 =?us-ascii?Q?lMawZBOMpUULI+E3OSZvWFN/fvNsOKjsJS+Z5REu9ffWOml41ASEQbtm28qj?=
 =?us-ascii?Q?jOkwxZQepz2d+mb4vqbNDL1MBBAOtYAbppWgfsyocihyOIXvEJCwCLo6wIOj?=
 =?us-ascii?Q?Ynp7yZ97FwQQVa/pT/tLVwS7pp+n9SOXAWnB9pAJktyMpj50pKgdk43lcbfK?=
 =?us-ascii?Q?igQpR5JcWgKO3bF0FzHRwyOJuuV0+MkaldrRrLCHSEvhYDnmqS1iha6LBaAi?=
 =?us-ascii?Q?PsJ9NLFWGSf6ETqjhKslOwdASqMSWv59J8H6MZmeHkcxq6SM2RNbVUgiDY/D?=
 =?us-ascii?Q?dekJpVQpR5nM/kvgABZ2kQHqBDn2ibcrkW1ZQs+Zowy1MNjeMRdWchkcjFPr?=
 =?us-ascii?Q?nCvJUxQquzCGo03aQq9LfzL7Rc1rpPuwVy7CydMYfNcnvBw6kiGtV3m1B7eo?=
 =?us-ascii?Q?Y/ECsfqMtIlKSezO9DXGQv/XN/lKHI9mkxzMVZwHgM4kFfqGwMYrWkCyBkeL?=
 =?us-ascii?Q?r7H6+dXNkFJ8c0zdmMQZdj3PrFnN+DTbsF9a7tp0wipnDEqVTgk3iMsPKckx?=
 =?us-ascii?Q?87ImwXx+1FxxsyzS1JV05lVRYVpktDMAo3ttYtWaIu4UH6ukFxuSQwJG3mcM?=
 =?us-ascii?Q?gelNjJNTBN8vVpRqHUxdX7DeyXdAp2LjsbJ1w366EWwAj58nHi6TEYbrBvPe?=
 =?us-ascii?Q?cg+6imU/eNc8nbLM3giGxPCPLuzC5JwwF4RhHvJLa0LZo/BLCk6IFFmfFC2e?=
 =?us-ascii?Q?BbMr1KuZp1Wz9hat8vIaMwA46jAezWazoAXwQaXgWVAx6gJWC7B+S6HgCtbl?=
 =?us-ascii?Q?LweYgw9yvbOA7lVdsc+NQMgex00QjGK/FWwj780Lg1KtjYCs1bFVmESq896s?=
 =?us-ascii?Q?X71921lwjJZ/bg9J7I0eFx5DwOZWhs2M63lkAjGQi/acCRvv15LjwReHFdIB?=
 =?us-ascii?Q?DAgjm6UZYtiDTzdAJEW75VusXuM/4zTaaCRjHM9kUCodby77pJZp8UnR3Sio?=
 =?us-ascii?Q?VUgP38FxPvRI406Dj6HK4RREpYLPyLhluoRt0WAX+KPrnC+PKPksMF064o9I?=
 =?us-ascii?Q?QnRn4TqzDOFNelEY25zh+YHNLf7+LeASSeRwjagUSmNetPNZKt1uGeUIAuEb?=
 =?us-ascii?Q?ksTTYSPJ15scB2B4T+/mZN/U5R3lJ/EoGo7FfO0ISxEYOfgTb0pWmjuX79Hl?=
 =?us-ascii?Q?CJkn3phzfaRwk2YsxoQWqQYrJF6e6BK97iCj1LKkp6rlBbpvN11a5SUHHAyF?=
 =?us-ascii?Q?NZkhi39At5bOUlp1kBjvdO8ZRVaXBQOhR8ImrshT6wSaGjGRHYyCdgtGKFOL?=
 =?us-ascii?Q?5C0dN2G4jTIrYTJtBsL6qyeFMCl+hpJONt+2ATTeRv7Y8yjbVuHVpEZQeruM?=
 =?us-ascii?Q?WVerT3Zxm7Nk4G76UE00Dw8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4659FADB56E4F14C8587E68B496E80BB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: z7Ef9jvzvizat8nvFtsJcYDZLGAeMO62bdTQY3iaAjjRImRovF/ywJ12zXnvWClJ+fyFKM8BhjxTRAlZu2mPhd3PHQfH4LlmwtDdMAN9BNfMQ2F1WvfRw7QW7rZUp1A+ZcrW8QKfqbiIJYw2ClSjHA3v0JZr1eVeyyI3KVblcalZ3QynSnTsJD+QiDI4fNmKGu1AJQDRoy3y8QZIbS9UEkVuAAjxGRlle04aRsGb/HQkMclE5F0+6mdMQWMlDycrQyLmmmwo3J2XYiYpZu8hGWzKpyxrhdedKlv6IoYZtJLvs8LnINAx7Qqz11xv/sox/t0EQA8HBwdktGCWfPO4PUnDgqvHDnc8VsB2KhXI9GTMyir2viWnRm7IlpmZoDpbM+do0IEnIPg5JGEc2+n3egRHz/ysy3t0BygqLi4HjOGQnSebsW1nnPkgJI9fDS58ItaD8vmJMUmhcdddrTR/ZIrDdghhl6oDoetAwSx5bNV0r7eBBoxECJUWopupT7HGZDDqRF/Bop1b5lmmUqauwyGby/io99nqvrx+BFeCpS6Of3Fkytnuw+Gs0CX8MTyAFphpJP+SEY2SBJ5yNCyke4scvuZoaT9tCjw+BBv72gxNXM+6dqVNuDyAh3vTFWC51V02Xr96eZkcVuLsunJyVljpk5yPkn0f+BLj/MQ786ntt+zz5gSHrUx0pkZBOmtGqG30pe7RJE34ebiIs/fHtN9HekWBB45LOG0mOsPm79uQHcJDHo19kAvHsgr2nITYXZxuacR1rJBXeiKdlRQ31I7+Sd3oWWzjR3gJ48wOXLayvX8whA2CQzut/om2RpdR
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28184ce3-ba11-4e8e-41e8-08db1342d315
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2023 13:03:13.2430
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7M/j10H7FwOgz+rB4/Q1HXMG88fu7umx+y4s7LLrM3DpZkNbY8QTdCyEq/s5D3HfSlpD/pQkaYRSBB0v5lbuboXjcblgdU6eQ8vCB/gGdw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5718
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Feb 20, 2023 / 11:46, Ming Lei wrote:
> Hello,
>=20
> The 1st patch adds one mini ublk program, which only supports null &
> loop targets.
>=20
> The 2nd patch add blktests/033 for covering gendisk leak issue.
>=20
> v3:
> 	- move minublk.c into src/
> 	- remove '-i' in top Makefile
> 	- fix commit log for 1/2
> 	- add 'udevadm settle' after adding device, so that the following
> 	test can be done reliably
> 	- fix _init_ublk()
> 	- redirect runtime log into $FULL
> 	- all are suggested by Shinichiro Kawasaki

Ming, thanks for v3. The patches look good to me. I'll wait for a few more =
days
before merge in case someone have more comments.

--=20
Shin'ichiro Kawasaki=
