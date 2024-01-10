Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA5717E4
	for <linux-block@vger.kernel.org>; Wed, 10 Jan 2024 02:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="c0DEAdYs";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="d2DMiU9D"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1704853155; x=1736389155;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=fJMJJqytD15zaSvjFvYVR+evNWunxnqkIOu6vxcEhzw=;
  b=c0DEAdYsB3X6PMoOSDphJxLNQcxuhtYaYkQQ4DaYrQcAghD8eG66pLFb
   +QZc4hiIN8hT5rK7xC0rJOZIzCY/EakxmpKgJQG8IuSDpRD2Wc1Z2s1ta
   KQy7rSuOIqPwwAoJIrEPx45H6V7NbJTayuSaCcH9c1iZbRjKWpH4IfLmv
   68952aV5xpsg0rdTbHYVdyhKGzz+JpyoZwicP0DLYCEe0iCOZ3Tolhlce
   2N2ixKNMjypAgZcV+tdqnb09OXLOZWMoYlsEd4nKz6f7LD8xe0XEnG42c
   ubUAgbYz9JZ4nP83S3KPwfCng5P2KXg5ged02ygvZB3nPPwwjWyX42CnY
   g==;
X-CSE-ConnectionGUID: KDpfbM6iSRSua/r4YZ3BcA==
X-CSE-MsgGUID: SNVTPFAZSLmDtO9pFvRqRA==
X-IronPort-AV: E=Sophos;i="6.04,184,1695657600"; 
   d="scan'208";a="6294365"
Received: from mail-bn8nam12lp2169.outbound.protection.outlook.com (HELO NAM12-BN8-obe.outbound.protection.outlook.com) ([104.47.55.169])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2024 10:19:10 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJUs+AU55/3nvDKwAtw+D5h+B5QdhNlBE+Aq5RYtLUbBrkhjw74MxfLPdDSVHvcYIz5WQVcSr4CG8m+XC+zrThCbddUVvWW4ZBZOV+vBExEj9E39Txgbz8XNCa9oDcTqOztVFlzLekIAqwWGcLzY4cwjRfCYN67T+7YN7AM48eJo+9EgV6f31TdyqpvBvGGvgjDEgbqUZA1tkNc1GUVzbig3BzlxcUGdQq0BIeoV5YqHG46wB4juLsQ/Z4ELg4cpxClPshbSoy9rvG09CNIj2BqiGF0vgtns/SCBTffMcAN/QPV9VAgykc4+5Guemnqaj4yjgTGV0bDuekT/vmUVtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jBh/Tam1uFaZcr2jbEz9oCoQMOVHc5TrY1f7d3f3pos=;
 b=i3LisGf5KoyfSzF43vj7I/rtSMyvfEeE8RwWmTCP3jpsnagmWCnh3q1NMmq15UU1rrhtSSgDzLTddh0XtJp/cMVTM+4aGD+Yyd0e/+higr9s2plzpgD2DtIM4XKwnWRf+nZ6Okis95hgJlGmgu8RkOGTPfpjAKcU5T3QcJ0y44mmFF5tF8+B+tI12ANsFVoh+Ns0INijCyPqHNnVWYALLzAstnR4sAnNXNw+10kMWIcCjuyOEBeEUngUe0nBGiLX3MpX7TdtlFycDJ0Dumv1/LHEp7vbDdkdgVRwyloqgs7cgMr42M4+y7BPDlATz0/uhS04XRybORqDv4ZHMhZ2wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBh/Tam1uFaZcr2jbEz9oCoQMOVHc5TrY1f7d3f3pos=;
 b=d2DMiU9DtQVdhnkmBM+F0MK++cjIdzeyrRfaH5NxQvXkZp7CCJaCqmVRoO/1s1K45LUI473dkjznxb6JMCp1WbBxuHbMDQxWUuzJAM4Bcm7hd7zmWWW6mJ21OGr8/SsgpGuta7KyjhNbCJb2F7t07qp+slZFdwaNlKv2KPaohjE=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB7446.namprd04.prod.outlook.com (2603:10b6:510:18::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.21; Wed, 10 Jan 2024 02:19:08 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::81a9:5f87:e955:16b4%3]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 02:19:08 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v2 2/2] block/031: allow to run with built-in
 null_blk driver
Thread-Topic: [PATCH blktests v2 2/2] block/031: allow to run with built-in
 null_blk driver
Thread-Index: AQHaQujnpRNH2s3KN0GoD/i6keHycLDR7HKAgABkg4A=
Date: Wed, 10 Jan 2024 02:19:08 +0000
Message-ID: <7auicy62muu22xsd3adbvrljq3guvbdzgkbafxva5du45jli3n@wo4f7f6ut5eb>
References: <20240109104453.3764096-1-shinichiro.kawasaki@wdc.com>
 <20240109104453.3764096-3-shinichiro.kawasaki@wdc.com>
 <4a6b2848-7792-4e11-9fc5-482b8e4e020b@acm.org>
In-Reply-To: <4a6b2848-7792-4e11-9fc5-482b8e4e020b@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB7446:EE_
x-ms-office365-filtering-correlation-id: 2699830f-5bb2-4323-b86f-08dc118286d6
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 f8R9N1NbBRj8WnX2YPlWNSn2CyOehcQ3yYj7UeNvq/jbreEYJmzjUTtUjH/E2FT2dd9++qmBWbcxeCe6F03kNxZLUkD/JonTw44rg9bNdEYVfeb58mNvpAwjPe1mVRzp95BossesyzfW2jhVp5jCxSwYk2TWn8oilJdsuItgUCWojxvHbjd9ARlmEAUf/BGxIqSaJ/9sljILepdWx4/FBWQBaR3MtEU0Jqxs8mpCdE3AWnbEvetw7+HUvolH+xlQZBbIkeKT6BWRfZMLVcRD1tgkJvtu02GODvCiPN0VQiHmeeSBe58K3xle2TzEvzcLw/LmguWGyizCv+yyAHKAtikeE9WlUr4Z5/aGTBVCXWCyUdOGvBESjgHAAV8OH7/BWuOKyjipVS4rDDXBXnI4qt9QblIMzxrDwi4O91xUqxcagv9bBS0rMfHdt4alhnpa/d8M9NBKnc9/Kz6mn5CVpZabR6k2G8J3qnu0C1l1AKLvCL2U6A16okzP3vBFKJ4w2lOFjc7p8YAyjvJv8oD9oWWFldlcxdG5SONex+rm8RLLl66krgy50TXFEqMp/ysb08zt5BulIV+sFu+V9Y34ZkD2Sb4oEozRAkp1BqwfhwXfKGafUpdxvrApQ4T6kwWl
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(136003)(376002)(396003)(366004)(39860400002)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(53546011)(26005)(38100700002)(6512007)(9686003)(71200400001)(478600001)(6486002)(6506007)(83380400001)(64756008)(2906002)(66556008)(33716001)(5660300002)(4326008)(316002)(76116006)(8676002)(66476007)(44832011)(8936002)(66446008)(66946007)(38070700009)(91956017)(6916009)(122000001)(82960400001)(86362001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uueWiu0cVMZzXFzm7GT+sWb9ge1DO8YrKNxe7crvnn+wrwxpQYBG28CGlgEX?=
 =?us-ascii?Q?A4pQWujM8366EqFbsO8S0fnUEy2jxSerSboq8xTs5CZ6H9gjLYt3I3V7u8xr?=
 =?us-ascii?Q?E0BcL8WZoFiOrp19zgCznrJf3bXJoQARQzNbhuVprBHflozsodY3SQAIVj9X?=
 =?us-ascii?Q?Puo9UEE+oyPbrgJrq/SR4/5t69KaD2Vk1DEtvtWATu6Ju+S/3JDTUqIbseCj?=
 =?us-ascii?Q?d0Q3ZDo/1WiNa9HUZathZ2/0GoWNmYgTUHD3jqIo7eE8VIGk1B5OR8oYAVRQ?=
 =?us-ascii?Q?MYjyPY3234MItUeZm7VNj4qdLcqKyz5Q/LH+pO91wJJessUkcYKiv9U3Aa3k?=
 =?us-ascii?Q?aakpJbGi4YwdZJfT0CkxhNrtdLvdtQJe8K9iutODk64lLD5x42EJkzuTwbFR?=
 =?us-ascii?Q?NjxmTMFAsOd1UCdK+v3DSv3+cIfgh5b/UgokG8mLwfJnSHmVXGorst0FHf1X?=
 =?us-ascii?Q?5KC87n0qeYfylnObeg/cTeodVkIZCxYbfXREZ9aEVCcD46CMSdMgx+6ZPYMb?=
 =?us-ascii?Q?aclvyUScxgjAQmV3TDXrfspVcMiPaHgUtNtdKUSNSxYt40shmHJKpgWlvKTf?=
 =?us-ascii?Q?AWGvNM0n+9f3MdzQdr0PuICxDxA/VkMgku2QO7JxzJJkJ2uJ22PGea1UrSwr?=
 =?us-ascii?Q?2+kucoPPUTT686/UpIO5Laf/gVoeiDqTcv1hWiSfwS0hLmxRu1hKNLC+MAdT?=
 =?us-ascii?Q?DLYbqyUtMHfmntTNXAb+BWZiUxYmGsiRFk92Zvz9UISY7GlJfb6xDvJHjvdo?=
 =?us-ascii?Q?cNq4ydOLUfkQWIGFCgZ/m8TseBFEAj53mNDuRbosqfX1PohIq61uNzBkCYQL?=
 =?us-ascii?Q?Bj2FURQ+f8GUzu25K+DUfS/K0cexjJtPMFdUPTu2DG7l0CS1rcDjgARRt2Im?=
 =?us-ascii?Q?EkKAELq5X0ekDIdZdreJmMCBqfjJAvST+qgM4Dw0m5hjqA6r1InnJQapLShK?=
 =?us-ascii?Q?xbQuBNQcYffwIbwzfw8mV/Zz4Jz237Dn1/MWFJOit4IHelz3e3e1xCcs5/8d?=
 =?us-ascii?Q?4cO3K/s4OtNyRU4fYJb7rUZTeO7QH/HBZCIypKVV7taqqiWyf8uITlcn0/EV?=
 =?us-ascii?Q?Jpplqmf3vMb+W2oJ8cMFQMn58NmJIcMZYMOkSErK0In8NVoG4Ie91PZoS9Ic?=
 =?us-ascii?Q?UAFuzzcZd9NUHyt+WOTy9baoaoVgc5YtYwQyWYdHaLNE1dxiBgTIxKj85BS4?=
 =?us-ascii?Q?vOrWxU+D4BVKCSyV7K4F484gqOUHeJKy5UBW49QYJ1sOYDT2CDFFlqIgAifu?=
 =?us-ascii?Q?y6xktljenLj78eEk0Uqbt4ji2uLwI9+HyuGnp4FeM04r4g8/hZams0AN+dCB?=
 =?us-ascii?Q?HAZOfwUxvioggJwMMeWZEQkRvI3OuC9l5MnqUYZubHRXQcF6sxweYBwQUiXf?=
 =?us-ascii?Q?wL1eWG3Fxvlk11Lv/wJTT9FwncwIovlIfS8If+M3HiFRs3nUrU2o+vDXYOL/?=
 =?us-ascii?Q?ogxvJULPMoKRLjeZVhUa37FM9xDKWxgYZrtfE1NSzC9T90ZFIxzvUXU9j4CG?=
 =?us-ascii?Q?Gkg/DRYs61bEDV+JGcsEK7Z0KLtLwSbpVuliiZ6fRo7JcLQcOhh9GSkH6f43?=
 =?us-ascii?Q?I30GrAxiPmWQ9oYrD+y/3Tixxj2cVsaT4yJz9+LrVFaCYDVgo/7ugvFJlkrq?=
 =?us-ascii?Q?6k7QtyuP/c+9UGyuhAdjsgo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E754DF9D2BD5564AB889119E9BC1DEDD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CgqONZbBwhWc8DTE2Awkmy/KXUcI6lFDn+WhAi+Ck1AF2uQjk5crkgj8KRqH6vRuRNotnzwamPALum2oY68vw+lpc4sUP4ncNfcVopKwLXCPOWKbo+tLZ3EPBAiuyX1LgkFAksDr8IW71PJ2B49xucbFn5sACx7riVQhjrbyVmpTAiUGBSXlpdYvg/PeWa/mfH/nEWDoLKoYfhEgUd6M6a6nINnhfUwuftihcaLWyLF5fc5XzjaJh2ydruTbH+1TOTTvnqCse1ByKT/Yg2q15rgviiTcqBNLxnhxx2K9c6wB9NO1+AHx7d+2TGVW/pYlkA7iGA5P4qwOUilZoge8TTrysI3jvxjCLO+YuKEhY6TcYShPBFNnjaN70d4yCQhe1Ibl/1gH2TKeIdYXZR5Oni/qQyt4Gl75BFA4FlU4e0N32OEdX8C1YgEOyAx37QB0+Q8jueEouAYY4RxYG51AJ7f4qi85reAeGLqopInfCQ+ilxj3sLj5a6MkieQUKljjiuLi2Hg9yd2zp82yAmAjqUHlZzhG9AwGrwpDXf9RV3yIrNNlWTLEhgUsaEYbSyz3dfCsS0TL31GQl9XL2E31iALQk/CsPG8r8kmtZCKPyx5f1colQCSZzxN9DZ1v8l3z
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2699830f-5bb2-4323-b86f-08dc118286d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 02:19:08.5092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TugYEIEh3dVPSayhXOIR4t4G6dng9Hw6y4KAoGdsEPJpM0wuZywk7H4rKSbujZBp+k/eAZTHgTfpJAW/HDFDJ2YzVUvVT/jJyaWBtpX9k7c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7446

On Jan 09, 2024 / 12:19, Bart Van Assche wrote:
> On 1/9/24 02:44, Shin'ichiro Kawasaki wrote:
> > The test case block/031 sets null_blk parameter shared_tag_bitmap=3D1 f=
or
> > testing.
> > The parameter has been set as a module parameter then null_blk
> > driver must be loadable.
>=20
> It seems like the word "If" is missing from the start of the above senten=
ce?

With this sentence, I wanted to describe current implmenetation fact. Befor=
e
applying this patch, shared_tag_bitmap=3D1 was set as a module parameter, n=
ot
through a configfs file. So I don't think "If" is missing.

>=20
> > -	if ! _init_null_blk nr_devices=3D0 shared_tag_bitmap=3D1; then
> > -		echo "Loading null_blk failed"
> > -		return 1
> > +	if _have_null_blk_feature shared_tag_bitmap; then
> > +		opts+=3D(shared_tag_bitmap=3D1)
> > +	else
> > +		# Old kernel requires shared_tag_bitmap as a module parameter
> > +		# instead of configfs parameter.
> > +		if ! _init_null_blk shared_tag_bitmap=3D1; then
> > +			echo "Loading null_blk failed"
> > +			return 1
> > +		fi
> >   	fi
>=20
> _have_null_blk_feature loads the null_blk kernel module as a side effect.=
 The
> above code relies on that side effect.

No. Regardless of the null_blk module load status, _init_null_blk() should =
work
in same manner. Actually _init_null_blk() unload null_blk (modprobe -r null=
_blk)
then load null_blk (modprobe null_blk).

> I think that _have_null_blk_feature either
> should unload the null_blk kernel module or that a comment should be adde=
d above
> the above if-statement that explains this side effect. Otherwise readers =
of this
> code will wonder why there is an _init_null_blk call in one branch of the
> if-statement and not in the other branch.

I think the inline comment above was not clear enough and caused the confus=
ion.
How about to improve the comment as follows? I hope it explains why
_init_null_blk is called in the if-statement.

        # _configure_null_blk() sets null_blk parameters via configfs, whil=
e
	# _init_null_blk() sets null_blk parameters as module parameters.
        # Old kernel requires shared_tag_bitmap as a module parameter. In t=
hat
	# case, call _init_null_blk() for shared_tag_bitmap.
