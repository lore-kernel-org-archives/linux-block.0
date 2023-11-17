Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="C9UxTl/L";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="aBfx894L"
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFFB11F
	for <linux-block@vger.kernel.org>; Fri, 17 Nov 2023 00:46:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1700210779; x=1731746779;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=441oIKKuyrBYkvuKCRQHo46jLWPvPRK52ifaaWnpQyo=;
  b=C9UxTl/LuU8AVB6ksDN2TD/T5eJUQ4QcjYbujfE7Ekh//EcfABV3INQ8
   TVpCdC+9zTonXNtd07st0+Ebrj5plTWFQP/kcMSk/ZiYRiLUNhis2Cxe9
   RQX3xsDd/AVxn8+z/U6wCjaExJ2hI4ti3kjRNNtI9uzII7eSWcEnWBGBW
   GhK8d4iqBcai27QuNifQ7NC7ZJAy8MK5MZsQjRzX/L027JiiFyinbYRyr
   b0IJCbXkfpZAhO6ceWLUj6ZJNzc05t7/B5CpQCnlwaMQeoVbdZnlK8iKa
   xbZeY5ZaoRy6jp0oJ+uBnCD5HSNddjj7ZZxNXsSZ3ole1qMQBKGIaarRl
   A==;
X-CSE-ConnectionGUID: yIZeJZmTQ+SZdUKl1Gz8gw==
X-CSE-MsgGUID: TT2pbd5zR8SkWOuY5l3cEw==
X-IronPort-AV: E=Sophos;i="6.04,206,1695657600"; 
   d="scan'208";a="2603828"
Received: from mail-dm6nam10lp2101.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.101])
  by ob1.hgst.iphmx.com with ESMTP; 17 Nov 2023 16:46:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGMtYtVdeCoJ2RYw1NmqKyfBIvVOiJWJIX/Hc3Glfxk7R+ALZzQwlgh+/OjCfhAReyqeFZb2dnRhVTv4LuavlvaxSlcatlO+XXoW07tIeAwkCM9zYneSHJ8JysD7RFAICYpaOgINXOdyp/+XQqALTYWcXl/sl052GnyZesSh3H+4BZnRC8/p0YZ50IfLBKT902DsCKsRL3OsJkSviwvX0U4qkB1QLS+WMktYVLGV7fhWQOubQelg9fhxMcG27W4+ehqXl4P865QOh14GBFHQy3hfiNIobkU/mbXCEBJtnbuEgvF/nFhxnLQrZqpZ1MPrqSibNwr6BRIYsyQgb4fTtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=441oIKKuyrBYkvuKCRQHo46jLWPvPRK52ifaaWnpQyo=;
 b=S86wT7HZejUGxo7qHdrSHS0uYiuTgLDkWyytzqRXc1zCKS9Ub6X5kkC9oI9LFjPtb8s/fRLXXWxDlwhrkBHOTV15/l1WRwzOacWjBnzttjSkyCozMNmiQ0sAwtKrJKS1JFgXae4LB1rgCfrTiNXXblC5wJOhTK3risvnAtdZ0tqPpKM4fJB7KSoulz9xbjqjhYc1q6iZ3cgIZ7isnpzrcErEzGrbpFvlZlxXQ+1C593C/s8aYvL/NkPR/PFdbbXox3uHhSicpVrEmUdpHBh4H240UrkBUnE7Du0xhBqAGQZjNj+vgBqQORJ1PQg66BhG7dCFG3NxEW5hKx91adXyyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=441oIKKuyrBYkvuKCRQHo46jLWPvPRK52ifaaWnpQyo=;
 b=aBfx894LA15wfoe5dCFA4YwW74iuj0klA8cKWPeGSwucEA54DdVSVM/TcJdt1Swk6YtozRWaSrTtBMl+coGQVyGq+tZuneOm06/DoUJD+SB/0XcoyDUBbxSBEGicN4/Q2aEUD8w53DlinJOrgf5w45+MyvDaJSLaZqIrGW33PH8=
Received: from BN0PR04MB8048.namprd04.prod.outlook.com (2603:10b6:408:15f::17)
 by BY1PR04MB8773.namprd04.prod.outlook.com (2603:10b6:a03:532::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Fri, 17 Nov
 2023 08:46:16 +0000
Received: from BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::58b4:c149:69dc:1d2d]) by BN0PR04MB8048.namprd04.prod.outlook.com
 ([fe80::58b4:c149:69dc:1d2d%4]) with mapi id 15.20.7002.022; Fri, 17 Nov 2023
 08:46:16 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
CC: Hannes Reinecke <hare@suse.de>, Daniel Wagner <dwagern@suse.de>
Subject: Re: [PATCH blktests 2/2] nvme: do not print subsystem NQN to stdout
Thread-Topic: [PATCH blktests 2/2] nvme: do not print subsystem NQN to stdout
Thread-Index: AQHaEg+FMVRgmKM0Gki2gPcIHXaUdrB+QOwA
Date: Fri, 17 Nov 2023 08:46:16 +0000
Message-ID: <ovns2cxrupdqgi5tjw3nxzemisywet547eiblv55ig2irsigdb@2no4gxmotf6c>
References: <20231108064753.1932632-1-shinichiro.kawasaki@wdc.com>
 <20231108064753.1932632-3-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20231108064753.1932632-3-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR04MB8048:EE_|BY1PR04MB8773:EE_
x-ms-office365-filtering-correlation-id: 6ef73e69-1450-40f7-143b-08dbe749a94a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 f3Py/eTXXO07lN7Wh+N3dilKD0IcX6H+4mMrmjK9h2Z/xg07exNaOHE8yocoF0CWkxy15FWr+NVpsHDHZsXvK+VwXHKPkJSQ+1sourvUM8Q0kwMOH8GDLc0RJ2UadggQjB8WbgvgcBVG28qRAmwucL5MueK0mS4X9iXQV5y/WG0gIjReommqdsMdHVJaV/swVrvhMwo7Vs1IpmwZqcMrxDR7pNcxWcFVBQaCAB29L6GWNxfMN8MDwidYSXLxEYohuBmPebMMHfyn5lAGyExtkYCXKsRhINxgaTkIfu8H0cKE/FtGueHt00WLF+gy4nlBYjoJeJm2BSnNgUh/SLiX6p3mLSmRSILgHhX0oRgbl3YlzCviXWkiTM2r+QP2pSYIFw5KUeg5CCVNYEy+T115g0vCtMulhljr21T5jm1WlwQO5f1DFpygsTyxRqR6IEGXEq3ddOwop9Pk4eN7W+3V+bKtdXgXwbD/wiyTFYYh0Z2bwYKx0OkjIkLXGJuv0jXu74h6nfKS0vhP55kLu4qTu0NMlsvEr0Sm2ruCUqJTGYuqpA4kAnI+yDaMo9PkSFF343wNcovhcp1D/o7HfRZcPnvBKQLldm1wrstfmGDlMCE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR04MB8048.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(376002)(346002)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(71200400001)(966005)(6506007)(6512007)(9686003)(83380400001)(26005)(41300700001)(44832011)(5660300002)(8936002)(8676002)(4326008)(4744005)(6486002)(33716001)(2906002)(478600001)(316002)(91956017)(66556008)(66946007)(76116006)(86362001)(38100700002)(66476007)(122000001)(54906003)(110136005)(64756008)(66446008)(82960400001)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7PkZYH2ExBXqOEICM6bp0EmuPjqStHdnLyy9Ny1iAdQOY1y0Pqn0hVTAEaPH?=
 =?us-ascii?Q?aVa6XtNYWZgwb50NApAW9H11zKn7/VtiEvLjirv61or93Rg7zAbwXwHAxsRR?=
 =?us-ascii?Q?1b0yuC+dvnZxjZs8bUv2Awe4LPGB0vvkl432UTmIVlfm2TEslUuOin+Anqwy?=
 =?us-ascii?Q?U0JnTdPPIGf6gvaOaS37Mrf02FaOxF9/7URaxhhqG/K0Vgulqm39GQ1X+3Tu?=
 =?us-ascii?Q?ZGEKIE7UhKACrLmrwu+x1DkaJlhBMyxQo6McvFLJRxW6zfBGm9Cg4bzuCuNK?=
 =?us-ascii?Q?OiAyTOw17CUQTAQZy29xUjAbVUzoGRtjxsO88mv3GR0rmC+LDFhGNTJtrm3B?=
 =?us-ascii?Q?YGneCcVAZLP9o5plsZq692Zs57QhkBgWgMH3k/o2l6Cn03EIN7YEy2NMV/pq?=
 =?us-ascii?Q?YX1hOd4J4HLlr19G/4CrBM7fXp3iL9Yl+4m1zKpRdSKARgvv957pEJXuntUi?=
 =?us-ascii?Q?XJaT0I6tamQvB9fcBcOjufSlWD6fGhVExGjtb1cU84+Hd3EVmKqEBq5HjXe6?=
 =?us-ascii?Q?hy0nHwmDcR0N0F7RcIm0Mk1SuUAnvkWVhyPH0iETRtPKfVsF+XU7vAwqCgZE?=
 =?us-ascii?Q?JbMEGe7GZT17M6v06oa8nP4MaMqj1Z2rUAfXL1tH0iP04bLl57udTiw72wBD?=
 =?us-ascii?Q?EPLh07MtedNbIutk7QTuwJRfKQXh36MCbtu/DWXEqGAKbHbCui9hCJVCaVIz?=
 =?us-ascii?Q?pLbLFAnNUh1iwg/X9/H14CntvY7PJbAIbx2CWImG2u1klgCLAcgDG0PHqqtY?=
 =?us-ascii?Q?/jEi8rYZ2L1/URxKwYA0eesKDeC9ysBsDRFWBzk1gcyH8PcG+UkroZSLw8yU?=
 =?us-ascii?Q?TgFnFf11vKuJY0poyVXMtD4JsW8nUSEQlS7GRFeGFM7x8M6zAFcThVW0i9+2?=
 =?us-ascii?Q?fW42yc0zbUN988g45fJdrvs3NBaKlSEXPhSEog50ildzqBKpRDsyC0Hq95BE?=
 =?us-ascii?Q?ECegNwiu2lMqTO68Tdtv7G57MlJqTwJNwFFNpWB6jIwbxafQUY4Lev3rI0OQ?=
 =?us-ascii?Q?d63dAhQim8nh3nncsFcOnEDEq8HsO0c1uV5/fp+ugGPeEzwym6r+dLy4tycY?=
 =?us-ascii?Q?CFOti84QgRaC3du5gMbVYcDFZpkh6krpGhSyMwvT1b49ix8q4O4KTioslAy4?=
 =?us-ascii?Q?F/fm7tzc3d3zrKbh5yk9RJAHb7OvTIrdrLZjxu3CVa3+8gt9UIMWzguea7fA?=
 =?us-ascii?Q?nxzmQ+Y6h7SVNb6+bz7L7T/yeMuvMLeSgBjnevQZ1rWMara/1hUN+kElDtaP?=
 =?us-ascii?Q?pFYrnq/zL4x33qBJ648W9llxmcjpZVejr61oDDdUPHAmF/2mgon/nEvVtca6?=
 =?us-ascii?Q?CTdMsPq8Z3bVyDthMTObjqCsFmGZDz6Z1b8lek5FEYI/pedtEgn5pucZIyqE?=
 =?us-ascii?Q?jUWOrg2vjI39pQ/6o7UE8/8h7tgtKyWtz/c70PF4hsWRCDMbZyXNoBqicE8V?=
 =?us-ascii?Q?xCgMT1iapu224riQIMe0clbWEyPqUo3z0oStWB9GX8IkdRNcWsJwQqmBPVeO?=
 =?us-ascii?Q?l3L7HxsbNZs62NC2B56RuxXew4O+LzBeiAjJVrJQwZEitFo3+EBFuC0+GjOg?=
 =?us-ascii?Q?KP5xzFjdMK61po7VeesFZNx2mpYRTn7O5r6beDqDZkQFJdvcdC/Re+7Bh4j/?=
 =?us-ascii?Q?lny7XWKevC9UJPk3FXpvm78=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0B3C89348C84254DA68C23AF7605C22A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U5Pta6qunC8GmqpVQEhiBisAgq9tc02OFd00VU/nV12AZctMn5+oBVTt3XCwFNtD3leujCLi+lncM6sBx7UIFmcAtly5z7P7xg90QOSnwS5F15VxV+1gXHB/bnwMnw6BzyOt4fPed6FysJuVVVZ9wAUvGKY1HKQ1HdwD5VM5f5/R2GZ+qwVjDQdSulE/aztOWrVdiLgfmCmW9zD5YTP8jiH8c7NxSXKRahuvywiFqTFqXRq1EUMvl8vkV5zsAfhvG1TsrGvR97zz0CuOjFAOCh4LlF2/DMFWT09yPfdLf3Nl5rxTYpQyqeHmowzILEN1b7TaQI5kfPsTACzpFTFM/nXGiAjITDtWydO955suZ5puSZ22Fe5m3Ks5O1E3KG+wx4+TVkedx/zSBPPXXuxECmhWnRzGio3HF7zelQCctkeVqbMbddRvNbZnFNp1erwWKZYWEPYUxQEhaBCNjMMNbV1IbHXudsog5A6Xe45Xc6GA0+cbL7TBA9dTt3Axo2lrNEYFUz7rYljwrChdVNTRCAVUM69sCUqb7MCD9I2TdMw3uuqQaujTMNme2h9ey2eKLHGZw9xXa3kM5nF3qKXxjAiHbfRiWpZVHaRbFiO/Edad/QbIzpnNIfFHc/u8CP6FIFVapEBXxGfCTTzfN7kOavCHylX9iXvw0YnCiv3djft9nAJwx5iPw/fiHZUhin76tp5x2KCr82MC0MF0WqsegbaVtxwNzsgbbsbc4vWiJipJAr+5MG/phclX+MLK563xnofuID3J5CdsAn8GTP7TGvZ+nLoJ2gLfDMtj2+yPDsECy03n7CMPX5zHxC+K8+cquujXdhfCqJSU/rWvyDtRnwoSmpQ1E4XO9wUCLGrdQjM=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR04MB8048.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef73e69-1450-40f7-143b-08dbe749a94a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2023 08:46:16.1541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hl26Ds55IsAUgjVsvEMlFXQ9n2U3vgGqxC15VMN6NMaWDeja/Vnfw47prT+7dkbFNUqJ1zXXIru2UzEO8v0KtHNfAzrc7QJzxgoJQ7rPzfo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR04MB8773

On Nov 08, 2023 / 15:47, Shin'ichiro Kawasaki wrote:
> From: Hannes Reinecke <hare@suse.de>
>=20
> The subsystem NQN might be changed from the default value, but
> that shouldn't cause the tests to fail. So don't register the
> subsystem NQN in the 'out' files to avoid a false positive.
>=20
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

Today I noticed that this change will hide the failures due to unset kernel
config NVME_HOST_AUTH [1]. This change drops check for all of the "nvme
disconnect" command output, then it reduces the ability to catch failures.

Now I think it's the better to remove only subsystem NQN part from the "nvm=
e
disconnect" command output so that we can still detect the failures. Will
prepare v2 with this approach.

[1] https://lore.kernel.org/linux-nvme/CAHj4cs8yZ4-BXqTK4W0UsPpmc2ctCD=3D_m=
YiwuAuvcmgS3+KJ8g@mail.gmail.com/=
