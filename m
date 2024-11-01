Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918AAF9D9
	for <linux-block@vger.kernel.org>; Fri,  1 Nov 2024 12:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730465308; cv=fail; b=GqDQatf+6M5iU4QSIblAprjvcgnVfNUN5E+/pJsiY3/CX6Qw602ooVWQjirCaBv1N04gCz6PzHAs0v0wFMw41mGjZFRXJB9bR5Zsy/gGBhfWs+T/DVsJwhYxZUThzBxQ9fr9bYuaAgkuT30frosZGzTrH41n4mTz7PP76VO41AE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730465308; c=relaxed/simple;
	bh=ItvwhAv5N/znh8tBYxiR/wSUwmjOdj9ooXnJmxSrUvA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tNYhh4T+qmV/7vQb5UNulp76/qoi0K3P0/49iOvoyEX8DL9P0HOpCQMBLmXhl+G30w40ycriUBJmiZdg+lbAEffxIg2Q9U6lCTIqoaAZnp63oEWympHDjqPnkGyQE88PyWX3KfavH7j7SCvS2dq2b7sCavdrVcSjDa1RHENvcZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=pQ7u7tKM; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=RpcoKjqH; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pQ7u7tKM";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RpcoKjqH"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730465306; x=1762001306;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ItvwhAv5N/znh8tBYxiR/wSUwmjOdj9ooXnJmxSrUvA=;
  b=pQ7u7tKMDr/ozLvwD7Oh7FuHYVS10lSWEko4IPTiy7YjTAVyK/JHfiJe
   uMxrRALnH3nSb5rfaIiQPor0wDouIYHbhCmh0TIZgXuZthYig/U9wgbQ7
   iKsce7PRJKIvkHYD8r0f7LNCwpw+nbsmZhEHoqoD/7w2BOu0VmYUFH7Xr
   cXHNi7ZfHA9JIO9h5zhtifpN38CkFvVEb5MRQ++RXzcM7oP198EN5yOh5
   WHuF9Cvo0mRny5JrcAiTmSbSg2VRBD6pQl7aZEcxi95ZD2O/wRw3Ae+z3
   0uOH7YDz/Pynv0WXftw5IH5GRHzTcm7Y4uwBBN1gH27ER1HF5Ikq1iXDf
   A==;
X-CSE-ConnectionGUID: nt0cKtsHTE62j7FF5WbPFA==
X-CSE-MsgGUID: wXin9YDXT+OhTjCDOTwBow==
X-IronPort-AV: E=Sophos;i="6.11,249,1725292800"; 
   d="scan'208";a="31413715"
Received: from mail-westcentralusazlp17013077.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.6.77])
  by ob1.hgst.iphmx.com with ESMTP; 01 Nov 2024 20:48:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mtt3RIssqgXn407FemvJ6/C5Q4DWnHzee18JBX6QCN0N/NdfwQKen02MH86fFbE6Tx4j4Vn7cl5nu50BHBAsAUPmKo2Mbh6OzNDVSJlNvJbIT0kOYGa7Otyn8vLgpct4mUDorbzAOSnXvMbe68kSt9oIyBgB0jqpvJDM0EGYTdBJHuQRgwXmtBlKx9jVdo3wMHCJjh80L9Ik+tqhTb+H/QTsLCrs2V7J9dem+OBKU/lXbeXcThDpvoQk5xmU4KEJs8vaoFB6SR+XyvUvIviH0HLzoSFlt3N/7X37z+PmssYc4uubdV5+IV4AA2e55Y1ytgLTStcLFnbnwMxPLj3zug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VfGlRjE5edqa6r5ez4HWmO9gqV9w/SZe3tPhCH2jMig=;
 b=BPnogKff68AbXCSxcAc3Qr7KCbz4hFTmypi09wyJt9co0qPe24MVQwACzSe7i0Lujr6Ilu1zRZm83aD7duH4MtLprL+/2M9SLqqMUcbqqF2kfq6qUlCEeHr00cpO3KWgFlBagI0bDGdKmhyvmAfIMif9w9YnqdmcZ15hJtd5NCUmfx7aDtGiLA2p9Cp2FBmDIvfWzBPeYUNpPadrJyhaspfmHHATNTTiEUGZkNK6GAEN30J/Dwi+bdmOnxIfjyNga839NFUxzhyfwVLeqbmXgi9Kfarub/31I8ZugFQyXgxgcqHVDd+bbO/gyVCZjLwhMRLXdpwTtCbwmb5u81bnPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VfGlRjE5edqa6r5ez4HWmO9gqV9w/SZe3tPhCH2jMig=;
 b=RpcoKjqHyn9dNuZr7yza/T1OtkVBWE6hqwAj8YK9zwEaFhqHkA5n7EAfSws8m4MMjyU9ZJ+Q+V/so2VCWZ7jt9QM8zZRTiqLB1oCBYM6zMH0gBUsS+960YD+Swjsxn0csAsrVskHrkaa8cwSpqIFq0ei6gPoDaA5dMzv/aUXlWY=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 IA3PR04MB9500.namprd04.prod.outlook.com (2603:10b6:208:502::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Fri, 1 Nov
 2024 12:48:15 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.8114.023; Fri, 1 Nov 2024
 12:48:15 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Li Zhijian <lizhijian@fujitsu.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] common/rc: Uniform the style of skip reasons
Thread-Topic: [PATCH blktests] common/rc: Uniform the style of skip reasons
Thread-Index: AQHbKcGM5a0C2OpAq0i5lVuFPgfJFbKiZR4A
Date: Fri, 1 Nov 2024 12:48:15 +0000
Message-ID: <5v2sr2wuwhuobpiq63whqofpeyjyhw2nnk3r6c2f2u3egshrjp@gnxuykxjtzpm>
References: <20241029051551.68260-1-lizhijian@fujitsu.com>
In-Reply-To: <20241029051551.68260-1-lizhijian@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|IA3PR04MB9500:EE_
x-ms-office365-filtering-correlation-id: d0f40288-d1f7-4fe6-c1f5-08dcfa737400
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?/6s9CV20xafFuBCXVPqbI06z7bZhWOXQdVoGhj61G++6dkdhQYOrkZgCNJZa?=
 =?us-ascii?Q?VLIasTDkV2R7KcthPHQf3qA+necPbqGi8p9FxCXyeWCtBZghwNJDXZpsF28O?=
 =?us-ascii?Q?IC/PDunOMnPhoChxkD0EWZgvPQnBoWlZyH1NJFLqN6cOzbw9Emj8LNfR5xVZ?=
 =?us-ascii?Q?lDIokCY2I9pihgzDEa+sqbnR9Ucgd3+Q2I71CakzFKVG5PnoY2W0doxVSE2S?=
 =?us-ascii?Q?jxNlcrqeFxtk7nd19zOpdXyFFds7u+ARtNrF1qzz4An2fm4dfck7NNHjOXXA?=
 =?us-ascii?Q?J2cjs+3GJA1+aE0zTT4pHuE/SWQSFKrUNGBc2cl4o/psnIoip7GAuJqajaIO?=
 =?us-ascii?Q?r75622eEOK4oOR9bQYf8LwDBI53uZRx3T9MK3zuPX3JyZWaAvM5XG2/T9Mmt?=
 =?us-ascii?Q?mZzbVUq3qXwKnVFLKIo90okZyt83jISqM5WsGP6b5j3R814F6JOgWIwQmQ//?=
 =?us-ascii?Q?ymRVVfiS7sVtZiuLsICoTAEkDdiN89bydzYhMa0cjCRClWuoBsEC87cZ82kW?=
 =?us-ascii?Q?8Hd8r1aM4qbwCwQdjq8seZYVYL354Rcy7/Ja3YmXnL9fOfkU7/qRwFgT/ls7?=
 =?us-ascii?Q?ZjpOzFp1vP6tqHKF2i79u5qv3ZSWdZW9ZpnYS7ZmaouESoOHN9aF8fxcOs3R?=
 =?us-ascii?Q?rD0uDK+MsvOz7E6pDwwJ7K3TXqshGjT67nGdSgRzeCX3+hyMewzkws+5kz2r?=
 =?us-ascii?Q?Uwq46FtsCwufQ5G/dQYhs4w+x3roejF7SQcrSJ1qn9INJoMGUlyALUDKXNrf?=
 =?us-ascii?Q?bzlcWO2NPZR2KdLhU9vXHwJPiqJBpr1kHLiTex8cWctACMITuYC5zoylK6VQ?=
 =?us-ascii?Q?AfAHf3o9Pz3RwlCNVz7k4FjkqTFu3WidwnOqRGyps6qlRJ90lQMDfTpPeYvm?=
 =?us-ascii?Q?XYY8IeY50kcwSEGoZtwwBm760O1WDxroM+olX6U8LS8JvM3qbtRUiGjhuLZ1?=
 =?us-ascii?Q?LJ1oNqpjdi7qHwQ7TgH1OYS19pWkQtKARfuzWZRwAtKxP90843DHv4Ad2NHy?=
 =?us-ascii?Q?ZRWnssTIVIkGLe/ltJkPv3dgP9ck5FceHe2xYSKJN2im0LxCJS5JbMDMkbH9?=
 =?us-ascii?Q?r7PAK9knQHmHuMBsE8vsx6Cx1M9Yw0kjPrUHT6le8jFRvnEGz2RHZufG3LP9?=
 =?us-ascii?Q?SkMM307OpSWCbbdicNfON2n1hOs0TiOnSfnEgCJu7XDk+0QnCS3gzrCAXGfc?=
 =?us-ascii?Q?75nBYyxlgyuk12Udv8TNyAaNcjgajBA1Xyvo/Dxp1xhY6sXBLlrB559MMU5Q?=
 =?us-ascii?Q?02IxEQMV8Qt3GylOVBlPapGY4iy0WclK6RQ80Ic3sEeT1P/6/g2VzOx8jtfY?=
 =?us-ascii?Q?WjDvKhtG9w9084HXPDkimpUhVdwVltWsxv+GFB+n6e+O4b/Ll8hzmd3quAbd?=
 =?us-ascii?Q?N/Pjd+I=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?huEIcSqS7Wg6pzygMtX8Gh578uWJHyxmbWLylVJrVadG8iTwY2QVhujc/eTu?=
 =?us-ascii?Q?XbeweSv3Q9PfOaK0sjELD79q8QX4oBNkvmo/f/klW8lJRLLV0Aeph3EFAWtC?=
 =?us-ascii?Q?s60iCn9dNB9YREeUYAJ9bdERoendPztBBtkpn/WSBxDDmePUKOfCsqu/6fy7?=
 =?us-ascii?Q?FhA6bYhvyg3IF/Tht7NrgoYfKU3MNS/M2CzfzcaP6JRiGEVy6vtlYoDwrMg9?=
 =?us-ascii?Q?89Z5gPTd7m7bwh8nlS+zB7R6dZSacbqMWEUQy6zHa+uhUHP3rSsVe7hZo12I?=
 =?us-ascii?Q?w9uyLckGe/omkLtxmrJwa4iLmOX8rbWtfhGsmYzWqGltiKuK5J7OdchADDlu?=
 =?us-ascii?Q?taaHTZf4K13GRygkg2UyLq/v4nhe/l/X+KdOLyZJVoeDEkleQJiahQOKYn4D?=
 =?us-ascii?Q?IyF4T4CvQauRtxYJA3RtTHUZ5PEcmod1L+xE1caFJ+n/kqXknfuxl9ijERNa?=
 =?us-ascii?Q?aebMJMTVGpQi9y01giLC8A0YsBjg0aS24C3MFjmmnxBu4V6mlqAS7S9QcOXL?=
 =?us-ascii?Q?Vm3DrVlqcpMNHIMqfE5G5hmcWMEJjylVn26wwUA8OrKKpCAX5TPrpbkL1/oB?=
 =?us-ascii?Q?1a7hMWLtvliSy5lzJp6AfMPUiWLxGsc3c4MTX8LCcZdDgVYcpbhn8jczlk55?=
 =?us-ascii?Q?B9/M7FdshvCb5k+FwdguDM6qv32cAHzMToByTNWHGqV6TCHSdIegCOC4rZcc?=
 =?us-ascii?Q?Bejb5vcLHNhHmEK81SeAESt49YhayB1wg/izDuPKMkljOEmfx5vjBrK4D0TI?=
 =?us-ascii?Q?nn4Rr692aBt7EPWxJV3Bqk+amO/efIVdBROothvWKWsDl2gkU+faCHxBfwyn?=
 =?us-ascii?Q?KrsAyp7C9jEOhivTEermhXluxgp/bmA/uPobj+Vyphi95jBJ657up4elNi+I?=
 =?us-ascii?Q?9oFohwku3Fi8LzsEqUhLoy6dIjqeV1kjSTUMdyDlPDp12RMgrG+hcM/zt6QJ?=
 =?us-ascii?Q?wotBNBw/FbWC2FPjH6xHbgqypalnxtkYmx8Fxl7WZwhZdiSpU7Ie9RjtM776?=
 =?us-ascii?Q?kUIkF81cG5Hbb5kaxFF4TgQH8u1f7SsjAUu+1FO4QfiJGmnrMbglY7x0syK8?=
 =?us-ascii?Q?ACTulXCHUdfwuipp1vjEYo/H4DX9yFM/DtbSdIaDWoqjeKzIzrNECMb36b8W?=
 =?us-ascii?Q?YOFLPFPI+n3Iq2SvVAPuzIUqX7tmTlUZxe+nH0NcA2cR48SrOmfvprCaOF2i?=
 =?us-ascii?Q?f/z+CnMUwgSIIu7V5CZhsStNsoxk3V6D5ZNQaeAl3Nt/Yiv3brldARPUFk4G?=
 =?us-ascii?Q?Sb9H5F0raf7UvUMmOSCMIPtukDIEwEQW6OcrZ8eEESD4US/E11pbDKX1nU2j?=
 =?us-ascii?Q?Hltvj4gkqzVmB35jr7TL8BnKxd4lNaGQvx/tw3MF/8rKMKD7npe01G6kjE7q?=
 =?us-ascii?Q?np9q9d7c2/GDD7GifYPKX5X2Jrjapti5y1YlwjlVjCpgS4gSpBdV/x/eA2KN?=
 =?us-ascii?Q?UJQ3MjBF79vw39zskYUJTpmCSDqYTWQcVgmcAyqXbL4vxvWLlu81oIPIXw0X?=
 =?us-ascii?Q?ezeaOK5MyejRXtM2vuAKR/58rEk5jUqdB3zw30YmqBo0z1jx02Icudh3dx/2?=
 =?us-ascii?Q?IvXfqXue2m+r0TN9JR3ac9RiZ/4yNzp0qYQ9OaNKXEestwrszOHYGqWzhOzH?=
 =?us-ascii?Q?HJcPJ3Bz8ofWrQH2iQMJnJ0=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <43A930BF872743438BABF8D76449770C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XgQtJVFaVBtIod40UNmsjJQoT1v4VtozTtFWxMMjhiOR41S9Q/OKSDmxVx/pmzUk1HO/Urs49R+P+l+VD5KDSeKHi5w976UHrf/FUmTFxoiKOVuayHY1KgDTdImr4t3pnCxZPpvgZmv9FBZJYT9xZHOVZQRkHXw4RFegXehytB5ZNioXVcLkh5UdhySAe6T/0XAMMdKj4l5lXB8iG8k6GlE5dChGwG/Hd4euDxBjrPPXkDdv8/uo/4bE4T4JFqIyMxb39K8aLJveL0wmv90LNoN1I53pqYSoPsitoTy6CPKIfFqqHqchEKVFw0ix5wie0FbR4Opj4KUpLGuRJUaylGtAgJp/JHXW77XvvqjUA6CP5O6v5t4hrSzHwZGPNROevaZPalkt8w5hXMZvIFVVHnJ3O1fJyewkVb+56KuCojcWT6vl9anrOg0BMj7NJnUmuca8ZwCpKC5QjZQB9phvPwhSsm6lf8EGCnTc8bBBMKeHXPgnkoPm2Pp9E6F6QmUPJLbTzx2QFjm4Jn5KxICSfxPA64DEr0Q1nUJqqagynpawte39KP3LKFIvvj2JUQX4XrmEVA9BNoUOfGXvxImuihiDvmPgskgcnaDcLeZ151Zw9my3Uy0ox7OEyy5XDg3I
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0f40288-d1f7-4fe6-c1f5-08dcfa737400
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Nov 2024 12:48:15.3651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Vun7ygrXhTXf55BVE/663pMYwCmtnhVW5s9mFJphUsWWuDM0S3uLeW086CeeQwdzucV6MZtMTXsV4MmAYpQWpkKUqUuGxu/4qVMb6B3IHv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9500

On Oct 29, 2024 / 13:15, Li Zhijian wrote:
> Before:
> srp/***                                                      [not run]
>     driver scsi_dh_alua is not available
>     driver scsi_dh_emc is not available
>     driver scsi_dh_rdac is not available
>     dm_multipath module is not available
>     dm_queue_length module is not available
>     dm_service_time module is not available
>     ib_srpt module is not available
>     ib_umad module is not available
>     null_blk module is not available
>     scsi_debug module is not available
>     target_core_iblock module is not available
>     sg_reset is not available
>=20
> After:
> srp/***                                                      [not run]
>     driver scsi_dh_alua is not available
>     driver scsi_dh_emc is not available
>     driver scsi_dh_rdac is not available
>     module dm_multipath is not available
>     module dm_queue_length is not available
>     module dm_service_time is not available
>     module ib_srpt is not available
>     module ib_umad is not available
>     module null_blk is not available
>     module scsi_debug is not available
>     module target_core_iblock is not available
>     command sg_reset is not available
>=20
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>

Applied, thanks!=
