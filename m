Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17669149DF0
	for <linux-block@vger.kernel.org>; Mon, 20 Jan 2025 08:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737362022; cv=fail; b=MOMOKiLrgSm8M61q7+W+XFwIGrhvVXWHnlHuD26C3DsZq1Ltw5wMQKIz/hflpBvEK+6+9qdmom0WIYi6kBMZeidYUYeLgiUCwHoOSENP4RHBkTy1RMIGSmaSWubBXkUxtyq05Dnt4VnvKbxy1mcp6Lt9TgYANLICJ+Dz7JuHfaw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737362022; c=relaxed/simple;
	bh=/JYi6+OIScs937nl0/Vfd9rWLu6eG1Sl7Cs4D8VqesY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QqBl7HTq2yRhyBab3841lrrm6TVUYKNccP1etOUJ6ZNfWXdVC4w5ain8XxRThKsByKS+P0yyKuhpBg5QvWIW8YV/fixpyfJd+7qs1S/UVbVTCAC87FysoK5rev4wI7QRvY1gq5IVenSjhxRIFbpbTTGtvxSKII0BAwCFypn+8+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=S6WEm8s3; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=NNhlFHuO; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="S6WEm8s3";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="NNhlFHuO"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1737362021; x=1768898021;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=/JYi6+OIScs937nl0/Vfd9rWLu6eG1Sl7Cs4D8VqesY=;
  b=S6WEm8s3KMs1lMnL33EvZ/A2Zlq27XwkgTF4yKjXNREfED+LPzZDarjc
   s8FxMFocZoJY9KajhilbepeVrDb+4dlaStV82yXPhWho52BthVmuLGF4J
   Ak/HUoPSSsnYDYsTZHQ/yH1ahJ6SD3cwRnQCPBertneUwYyhvvcDDpxeJ
   2R8HC5RbG1t37n1853G7uQvtMYyrRgRmI1DmBj+4yI9PePVwlDqql+xKl
   s67zkawuz6LdGMZ5VyYYyy3bpaSfNt0uQSPaHKsqz8+fS9XtOxKlbJ1Ib
   gFM0hG2pf4YmwUOfU//xfpvDYdBmKFJAjpuxnZMbwjiz+c83T3zqNyLg1
   g==;
X-CSE-ConnectionGUID: W6+CUqCETgqgHBw7iR+fqw==
X-CSE-MsgGUID: 3zJU8J/eSbKwB+D6w+feQA==
X-IronPort-AV: E=Sophos;i="6.13,218,1732550400"; 
   d="scan'208";a="37353243"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 20 Jan 2025 16:33:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dFr2+lJlGSkImn+Ank/D5TSbUDyZhwU/I9cHIcGlUbHjiW2eEZGx+5w87cqSpy0NvTpu3wPSCxvi40wphxzqY09fgaWGGP8RDe5m6bEwGa77y+akdsBVDv+H19FUKPXkOAhk/Y6IPFsjRRFqwrHJibq0+wxiNqG18iL4BX9oYQdWj6VJIq2AQUQyu7QcfOmYz+ZOpBcmeLZ/1aj6GOUfS+1ygTu9w/qC007RQZ86Je4g80Gge7Jq/Gs/l3KqmNHk9tXrU5qgCK+xNLvFcw/3IU9EQ4hk6FWjKPKzaPWZYZHt5ztzMQKxczw7TdcG3pJs4aKcURXbUybNcdGhSNdqJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZscLFkb3aJRKOTOwQqbj9SucwwbShgR7RZrVLgxAMDw=;
 b=nuhmJuTd9qH2n2+N5xs6KqRTeJDbT6jcaJ2Dg83sQB+IHQ3o1SgwWyQ0Sc1Hefl4X3E9VGkbvUrk98R5Gd+3ACXTwp4B6JjE39k7Lwabf1Lkhb5QhH8AaDRfTwdjREnJ+anRkxw72Vc5o0WDv8dO6khYbBt3li/cum4EPv+uhLlnZQDH8bxjuCNFhDadVWVKmm/Mr9YvnAARcVNpbZS2o9+Lecm4jqguo/G5K9UWbGcQC/+VKyw4MsJVzPq+OifK37sKaruP0gVfMGRYtsb2o2zeILBb0sHWdZPYSUi45mp+3hkqhlnj88yM8DayH/X1tEM3hQPlrI9caiXXDi0n8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZscLFkb3aJRKOTOwQqbj9SucwwbShgR7RZrVLgxAMDw=;
 b=NNhlFHuOuuvvz4uOrY+D7khb8oLzQQdMM3tcWtDNP4wYl2+eNIIqQNEQkPzCsy6Ck1AuY/IFXfIovQ1CzXg6ZhesROkTlyyh7onLjLJqeA5FpHv/NX54o5uD7Tt21oJ51NHZIUFPrPnkuRb8UU8NwS1wFlOYR/2i4kIdILAqXvg=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 IA0PR04MB8833.namprd04.prod.outlook.com (2603:10b6:208:489::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.20; Mon, 20 Jan
 2025 08:33:32 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%5]) with mapi id 15.20.8356.020; Mon, 20 Jan 2025
 08:33:32 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Jens Axboe
	<axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH for-next v3 3/5] null_blk: fix zone resource management
 for badblocks
Thread-Topic: [PATCH for-next v3 3/5] null_blk: fix zone resource management
 for badblocks
Thread-Index: AQHbaTOWPfBrpGPdekqJvhtw7so2Q7MfWZGA
Date: Mon, 20 Jan 2025 08:33:32 +0000
Message-ID: <ltwae3kgwvmx37pro45rwenlmescfbcpt6zd6r3fx5o6z5fweq@6cx6tfnw2aw2>
References: <20250115042910.1149966-1-shinichiro.kawasaki@wdc.com>
 <20250115042910.1149966-4-shinichiro.kawasaki@wdc.com>
 <22e5c5a8-ad31-4a0f-a64e-33b34075a97d@kernel.org>
In-Reply-To: <22e5c5a8-ad31-4a0f-a64e-33b34075a97d@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|IA0PR04MB8833:EE_
x-ms-office365-filtering-correlation-id: 0eb4064c-db3e-4885-c1e0-08dd392d1f90
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GBe/NIwNg06JMQ7Ms4St/sZ2Mqrjg1xb4PEfVNBJ/TIL9kF3nx2kt1uiZqNS?=
 =?us-ascii?Q?6lme/y5dSMX7xKsrrp//ndeZtYibwJv5rpRYVL1EyO1SSRTOiwAHcatuZ2z6?=
 =?us-ascii?Q?0QDYbYWm0lk/MWMgpRXhZ0akuzyaNtp/H6EQwnkkVfYB6kPJieaDGeXXdNbK?=
 =?us-ascii?Q?426ydxH+ZaXjTyl7kuzDu1GuQuDpfAGyZVGf5vdAM9JbUhZ+APBFWQNzLs0J?=
 =?us-ascii?Q?gVBc2gu5Ybh4sbGs3Bfch+5FB7xHbbY569zJgTvrrfIslEuPoGeX2m/2m1Ln?=
 =?us-ascii?Q?RbwNaNf4oWBWvJfvdelGbcvXXDcNYaCHneKR0ktv/Wrb8LckpKuOfN0JmZ3A?=
 =?us-ascii?Q?v774GhN+LZdWMOQiJ99XLmXmo9YPoB44D+yVkFBDmuseq8ZeGt8mI81BX4mm?=
 =?us-ascii?Q?NaILeb+ZeKlXC1TXJoQsD9RnMrA8CloEMndTFyKzWHykI47suOF0+jyqlx6X?=
 =?us-ascii?Q?OrJrJDceAvEw/YysTHq0zqqgbA44FRWP99BicAVl2cbRHury2gbmsw1y0nBK?=
 =?us-ascii?Q?jMXwWxJyvA9Cc/Myb6t/bjebF8Ao9xQQ7UN4567bFMj1eoqX1z1ylQrHv2Qb?=
 =?us-ascii?Q?9tki6QbQ/tsjI6pLb2Pno/idOyAgWD0tNsjc94+WU/J3woyXZBzFMIvoZY7e?=
 =?us-ascii?Q?iGX6mQFemswNA+LtEVYtuUI8P12rg75NoqSqsNtEgUXwS6aZN83xCBxESJ4c?=
 =?us-ascii?Q?5CETRJdBVHBRrY2FASLUBpvuwKdm6lK7MhNsrPfwb0jfYDzzSRqn2XHHg0MZ?=
 =?us-ascii?Q?alJG4TFSwWp6hWLjWdFGsTXqD4owOiHXMliQDdWCVbCr9ZkOZ6sRU9JM8AnH?=
 =?us-ascii?Q?DLzC+4NAolQObAqHdrWokJcH/ZnxWHK7ErYG9a0qTgElAwExpMfFAKhpMvzZ?=
 =?us-ascii?Q?A0xjkr66vNg0FIs2LFkzQ+jgv8p4xXNXhh0DbcLZqpgtJVYADB0qcb2qMHH/?=
 =?us-ascii?Q?Eoib9r2LYZDgMIzsrIVEaiJu7uybSoSYlzBoSwW+Ngzu3n3469+Zb/Vop01v?=
 =?us-ascii?Q?kfeK2baozkzvEjKCuC40y1YO7xoe9FQzSLzZTwZmEZJ8PoR1ZO5GjGiCVQ8X?=
 =?us-ascii?Q?BJ9McWP8htBIDV42vz3PBEIFjV+pbPq1Plx5gL7KC7Y671xfRRDImrVPURV7?=
 =?us-ascii?Q?IaJB8cvnfDBJ3afYav5128ZPm6MzBGQiTZ9/DvI/Gu7nyNFHeO9CDDW83ufL?=
 =?us-ascii?Q?+WJG1Uax6GLUzDrbbqS774AAG+EWAm6HSdWEgBq6ObxPlUEWe+jTQt8oCODD?=
 =?us-ascii?Q?irsIYEveeZKLCPGF9kI47PyZxRNIxTIHAfV+qNbf+HAJVMhn1tFqMw0T350B?=
 =?us-ascii?Q?rx84Nl/jY6jsqwx5gTpemAOljobvjoj7WlSwkOfmLOjW+8cpD0En+TeStFvS?=
 =?us-ascii?Q?sFpLnIvU/iMdXebkrn+u4kKilnyGBbzwoHdAgAPwYt5NmAeM8SyubEkYu/Ly?=
 =?us-ascii?Q?j9fZ3obr3Lbd3VDBzFXKM5Q7hw4HEBkS?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lJtvmb8XBpLWcegbysBbchO1DMOJu4/7ukRfylIyh9tJxFkwrldaxICVIQgA?=
 =?us-ascii?Q?amSPnImPa8QFyHqHOrCqs9pyeKUMhox97oaP+wr+11GesWWMmar4NjyNOMiz?=
 =?us-ascii?Q?AdYVETempQsoWsc3Jb7VGuFR9eC7+HOg8vA1W3plyDL3TXWCTPFvK4sLyOyW?=
 =?us-ascii?Q?gv2nNR5o4tb2iP1avMA9pnwxz457rgtn6uW66hEQFx69y3mXGmzymqbDwrm6?=
 =?us-ascii?Q?1Jhhe9Wdwvb0wFnJaozOgjVdL+aekS1yCZmJ/DzztWEGtE3d9abZopFWqgdB?=
 =?us-ascii?Q?CsKuy+YrrnFQx3X1dZ9NIC41ME1+TUgKyVDQFdBaFmvgP1b3KfP2xhTIqEJP?=
 =?us-ascii?Q?X6yCsO+HlVvKgaDZffNzz9Vc6JLcp+2QEQ/iLOCGPd6BS1AeQoAbDzVAolwH?=
 =?us-ascii?Q?ODI+cCPYXAbRwlw0iyyQRPq0/HdFTYk+YV0nTocBJUzZ0wW4U1LxzTZTUBE3?=
 =?us-ascii?Q?neF1OcrbGXsXiZ5rAO1FLURM9v2Nze5+wyRo5Y50rOCa6471og6y5id/eT10?=
 =?us-ascii?Q?RjxB1DVrNuhGbPeYVbySKB/9z+sOWDBgwDV1gYFfp0T9A4ApoLPUcSBQDuaR?=
 =?us-ascii?Q?IU4M4mBXGQhkSVP000FOVSfZ2h5DmLZUSaca9P9FsNW5+HA/kyU1QDowplAp?=
 =?us-ascii?Q?gsC9hGHubV0F/VikH3ode2gjrUbB8hjYaUW+l36TfsZJgJVjgSx0TgeEqxSk?=
 =?us-ascii?Q?3arLYuKqe65hevx33msu8/zqdnPmZ7Y26jsDc15uvnZnVRjQIJ/YldestzZw?=
 =?us-ascii?Q?NE9iU3keqBPcu33OBsBxuUYRItWT49Fk5HleHBgCFiJPZVPDx69ZeXqxa8q/?=
 =?us-ascii?Q?Rw1XFwbDk4LHxaPxb95hRmY90oCYCf+MM35wEIwZGOSPsXKkhwqDcuPiP1zP?=
 =?us-ascii?Q?f+537WgZPkltBR8DY4BOusFx0lmpZGqxjY4INbO8LBAwHEEVYeMnkJiGe9rj?=
 =?us-ascii?Q?gtgn5viZQ2Exv00FGQjnWR7L2pdW6jIXDHur+wEHHKx4cNZV0FWjW90Kgh91?=
 =?us-ascii?Q?WgR5ZY5u6BItGff6JmlHKbLycQ61PKwd70HGenD6ykWOCR0wGx7aqOdD+DHs?=
 =?us-ascii?Q?jwkYyAA/kEW3iqKS7Uj3DK/dZifMcwjB50WpZj+KSQ3RkipJDGskXfnf/GW8?=
 =?us-ascii?Q?Tm/FSDqXhKKQMeeOvlQ3Oun4O7UPxRDT7i74ngd4mupHDO5tuZoyNASmdPnb?=
 =?us-ascii?Q?Gf8E0L0TZIEViTxtdVj57b58YDinuHxDUGr1zjSGYtgkjrGja4geHV4TizVU?=
 =?us-ascii?Q?xMish057VG64QIg8zZKQD4x6+IyLaq7xdcW0nzxdoiPFycyMwcxv4iW8ZpEE?=
 =?us-ascii?Q?eyKDEwbvyfYkbQjP25p9BPf7+QL1zypoQ+TTT3ylxxcCsSglmK2zsUOn9OAG?=
 =?us-ascii?Q?witbjHhfE9Iw1IZO8WI6QYUe8co7uu2lYRGH/ARhtMr9rhpM/I0V+HGzCQJ2?=
 =?us-ascii?Q?+OjcLVrzV1Ki+FFptD2UKONvOfZe5lQbhSFhy1fceSP4wceYKv9FTZFJEySr?=
 =?us-ascii?Q?rK1rG7rXhE48niGszzRQwAs83/VQfaKhRum0XNwGxuseP1roIDbbIlOafKLy?=
 =?us-ascii?Q?KpzN1Ko6snsaJww43Wk6q5Y+JmRgRgneHE12g63xPgG1dSsC7X07COsKqO1f?=
 =?us-ascii?Q?GY9nWWlBKETeIsnYqqpsFtA=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F93738FDA90DDC4B8400BED5E4DA86A5@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NOxufTl2xnyEuBmnV94FbjSyaxo/omHAkZ3Tgzv5Rfm/47zS2Re/RFXsYVy1yqsRglfVlqP3iKCXbGr2Qb+X0DFD5bwZ23FMFnUQzuVlI9ZEIAkZnS00JHgdxY/vOImkWzxIlsXHJe/oxH7j/sash9bpGR+sxaz8ImvWnO2pSMiE/VXSCN62QUMJQLDccXd/jbc5tZQsNiGeFjmJ2VXdk/B8Laz9oNdKb2MqxzvPV1JoSpkhSoSKZtaQJ+T+dDc/CxcRJEA19E1VsU1BghWGCiRS1Vv2uoqcpxlVg0jMDr1W455z7AGZ9OpSZSzSpbZF7xZLFDWbnk4B3gWz01PuYH53Eg8FefpWzJfC6lmGYTnDpAxU5oQUPi8VfaZA6ikY7RecqlMGm9r4O3xYETWEaaDwBDn3x4LVN0wtdf1TSdaYdCv9ykSXjvXy7zWqPX30HRWVMI06bWbtAYbyVopfU+X4PrB4WxhaKkzvKpNB/GCN0wbK55xflWG8XrgwBPUI1XWvqrXM68hi19lxxhIv7hbPKy1o8jEiN4zGMEaB7UFu++IpjBCMtgOK4AxnByAZSFm0cfgWAwGt8osv+yjdLZU8HuYYOwZPrSzpiQ893tlIDWPpbG4EI6VCDhWfMohI
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eb4064c-db3e-4885-c1e0-08dd392d1f90
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jan 2025 08:33:32.2214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4yOE5r2DwrTPudtjj5MBgS90PCN2s4woNPeYzoTnjXPtpj9QhqkNRfM6qCsijIQuYj0J0pIBTk2qmyg0AHWEBuuSqJ0efShEXc9N9sWdUSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR04MB8833

On Jan 18, 2025 / 08:00, Damien Le Moal wrote:
> On 1/15/25 1:29 PM, Shin'ichiro Kawasaki wrote:
> > When the badblocks parameter is set for zoned null_blk, zone resource
> > management does not work correctly. This issue arises because
> > null_zone_write() modifies the zone resource status and then call
> > null_process_cmd(), which handles the badblocks parameter. When
> > badblocks cause IO failures and no IO happens, the zone resource status
> > should not change. However, it has already changed.
>=20
> And that is correct in general. E.g. if an SMR HDD encounters a bad block=
 while
> executing a write command, the bad block may endup failing the write comm=
and but
> the write operation was already started, meaning that the zone was at lea=
st
> implicitly open first to start writing. So doing zone management first an=
d then
> handling the bad blocks (eventually failing the write operation) is the c=
orrect
> order to do things.
>=20
> I commented on the previous version that partially advancing the wp for a=
 write
> that is failed due to a bad block was incorrect because zone resource man=
agement
> needed to be done. But it seems I was mistaken since you are saying here =
that
> zone management is already done before handling bad blocks. So I do not t=
hink we
> need this change. Or is it me who is completely confused ?

Based on your comment on the previous version, I checked the code and found
the call chain was as follows:

null_process_zoned_cmd()
 null_zone_write()
  do zone resource management: zone resource management is done here,
                               assuming writes always succeed
  null_process_cmd()
   null_handle_badblocks() ... v2 3rd patch added wp move for partial write=
s

So, the zone resource management was done before applying the v2 patch seri=
es.

However, the zone resource management did not care the write failure by
badblocks. It assumed that as if the writes fully succeed always. When badb=
locks
causes write failure for zoned null_blk, it leaves wrong zone resource stat=
us.

I would say, this patch does not respond to your comment for the previous
version. It addresses the problem I found when I thought about your comment=
.

With this patch, the function call chain will be as follows:

null_process_zoned_cmd()
 null_zone_write()
  null_handle_badblocks()     ... checks how many sectors to be written
  do zone resource management ... zone resource management is done reflecti=
ng
                                  the result of null_handle_badblocks() cal=
l
   null_handle_memory_backed()

The zone resource management part will be skipped when badblocks causes no
write. The 5th patch in this 3rd series will modify null_handle_badblocks()=
 to
support partial writes by badblocks, and the zone resource management will =
be
done for such partial writes.=
