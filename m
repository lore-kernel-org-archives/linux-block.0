Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A82B341041
	for <linux-block@vger.kernel.org>; Fri, 20 Feb 2026 11:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771585284; cv=fail; b=r9gXGiB3HetLYUv3I99nR7OwGiYVigm9dMnHQf/L5f530W2+AkjKWo1fo6Yipsv+WKRagx1kBo7EJK0xD3lmwWUc4cnce9lglXSCx/kHnv7Suz1NlsFocbOvIUEwkMZadt2O4yqqHkzYmE2jwOrotbUWvQgQKilOHh+GyaujWLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771585284; c=relaxed/simple;
	bh=ozx1EGvfSb3L1vwAi9506gcKM6erziuEHt1qfu4GXyA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Md6FTx8HyvudZ/jFRKyjmx8Q4Jz3+YHksqgoLF1sQGK9YWa+O+CHPNpARr/OnBufseTqvZncpfzcJLUEsl86ml5S0IofUQxZZaRI0OI8Bc5LpmNgumS7mlYqxdPSqVFNrUqwVIkjxwtgY99V81Xe9xcm1DTphxwU+mL4qPdbopQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=KkbEfDhp; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=rEJ+k9z8; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KkbEfDhp";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rEJ+k9z8"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771585282; x=1803121282;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ozx1EGvfSb3L1vwAi9506gcKM6erziuEHt1qfu4GXyA=;
  b=KkbEfDhpcFlfq/zLcv1sumkaZSUrhtBKsS6ZSpGxA+WSC5YgzM78diF8
   SBcBwUVaOOcCoI8S2C5NtZ+IRHLyMtkO15IhmPmJ3Vf3lTQKFD5gh3YdJ
   PPhwNsAdzTcXjfhChH0ksKaSSfF8s1bDjhezklfvkg4jq2fICAm4OSXgh
   PbqlWvkqx6mWY/7S7tcNqM+p0xMGf9Vxu+YAfyn97a4+hoZGHYRcGWhr0
   5pLUeUVHn3orkuiFoMnj1IuhjwcdUvQaWlOpAQLa0Z5J7L4E/V8Wb+oyC
   9QgIOVdoRcpEbvoHBnSqwNhfeu9FYUXKpS1fHFmSFLd9jMmRkHXNc+Mk1
   g==;
X-CSE-ConnectionGUID: 4yF7PwqJSaqOYYFEN2R1OQ==
X-CSE-MsgGUID: n/Gw62DZS8CFbQbMHshPrQ==
X-IronPort-AV: E=Sophos;i="6.21,301,1763395200"; 
   d="scan'208";a="141084435"
Received: from mail-southcentralusazon11011000.outbound.protection.outlook.com (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.0])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Feb 2026 19:01:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kQCWjRoOF97tp5ULBJF0NsDICDiRNC2BskzLvAs7AZAvWQMXJhkb9nHvf3qE9q42KCqnLMNc5qyf5eAZgFOfry7PzcLun2cdwdB/k57mEVcpu71Bo5ys9PojXQuhh8kqrnKF22fmVUaeqpsSl0pGluACJy4d1jQ7Ab5/YaEXMv++hm70nIgXpd8+c1RU/HL2ure5CgxP0w4IX52MRXone+IZaifk40JnifKANABbTlivxWV8BmY8YM13ib2e9kV+GDMTySKfTrt8iPp84imgMTDuU0lKLmAhj7w4WUOQ++hTgcAKZMsmhy1w9E3UVHCAxrh+XuE3kP4KHnDCUc/GNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XdPMXjSNk9sojZAJJSq99uAHxaZkn0znynJdjceu3B8=;
 b=brlzin/FpDsDUw1WfI8RW91VEusMdI7fvtZJ3RxsK0K27ljeHZkddksB1i+Bu2e/HR/nvfg8Q996+3kepLw0v3KjHpdo/rTUQaIJ6i6gAm4naA+fzrvl8dvXiAcrm+ZIWMOK1EIGt3GQsOEIvYTnWcw0uVr4NoLqrZtyP8kr/WippCrLfcj1jHeaL5n9jB6zsbLVuzt9hbIzRbQKizBTOAUAgu8EThIl0uozOWjvQdSnAkeAnArI1mMXiymVQNvYzKiaFiw6EUHQOumAFrB1PwmjdjjTXngtXGc1GC6FM8RQR50izESnacfEqqXn2YNqqUNzKxtS6n0StnMz2kOQVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XdPMXjSNk9sojZAJJSq99uAHxaZkn0znynJdjceu3B8=;
 b=rEJ+k9z819kxtYJJOsWK4tkN5tr2Ecuwh6GqwYAdx6UbyRW5X5kOXCFGddcQ8Cya0jpsT/LxFMSpZ0ueETNiVmge5TpfN9Hlc6lZU3EJzUQZLg2CrlQtYHTTDdox4RsR6DQe6eiLQ2kROysanSa5fWckm2RDVa5vZH8a77/2OpY=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SN7PR04MB8740.namprd04.prod.outlook.com (2603:10b6:806:2ea::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Fri, 20 Feb
 2026 11:01:19 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 11:01:18 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Damien Le Moal <dlemoal@kernel.org>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Wilfred
 Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH blktests] zbd: do not handle write pointer values as
 numeric for full zones
Thread-Topic: [PATCH blktests] zbd: do not handle write pointer values as
 numeric for full zones
Thread-Index: AQHcoZpuHx3dJkvkcUKqX6VWCubLK7WKjCsAgADhGYA=
Date: Fri, 20 Feb 2026 11:01:17 +0000
Message-ID: <aZg-EXnRWuDY_BRP@shinmob>
References: <20260219122229.174539-1-shinichiro.kawasaki@wdc.com>
 <2c3d9a18-c1fa-44d1-b5b5-0d436f5c3b2e@kernel.org>
In-Reply-To: <2c3d9a18-c1fa-44d1-b5b5-0d436f5c3b2e@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SN7PR04MB8740:EE_
x-ms-office365-filtering-correlation-id: 3d8edc73-5308-4925-d73f-08de706f5fc4
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|19092799006|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4iM8TJgcgVMBapkadx4lnMVgFnoC8TMtUTKJkV0stH4FIgXz7dyJn/XHjOSb?=
 =?us-ascii?Q?+TCRwIbMsFQZ8HWcJchTm/Y3z/i4VEb1VV/TQwrxLaWPpiPxkRb72goM3LAt?=
 =?us-ascii?Q?CrwYEDhOEvHEfjSbSNJ/CHR/1BdqjdfW4x/Z7ikKPssaPm33a/En5oTonBhu?=
 =?us-ascii?Q?8kbXG2/fisuysWCdZ0Y3ksmI4KGTfZZ/XJQpQyO2cEhW4vUT7awb36fBzoVE?=
 =?us-ascii?Q?zqQ4p5DcGuF4wAuv4Tv01MEUxEsTcrMunk1cfWlBIOhORdDqRENVK2i4LJpn?=
 =?us-ascii?Q?CjY4dSa+SgqI9z72fGdGI9l+boz/DxmVZNN4JtRclEGMZne3Gdm6NaGVWrzj?=
 =?us-ascii?Q?wRt5KxCgr1RX69PK4CYb6omJs02NdW+B0NfW55VDGLFRSqb9EJnTW2020Up+?=
 =?us-ascii?Q?I1GqEsmHW4zqUiJM8nkk+q22UgKKZPv+ho/LIaUxhas70gAh6hSauq2UcYy1?=
 =?us-ascii?Q?DKCs3c0bKvWK0WkS98cm5xDjO7Z8tPvNVVM4OZRFkXGIStoKdL7K5qqnY35z?=
 =?us-ascii?Q?AWpcVmCy7bLTKut5MQiuKmfJwguA+AF3YIUlEz0IoZFPx2eAZvZ0O2vEsmP6?=
 =?us-ascii?Q?VryhKb2RDAloESpEx/jesfXgKdlifXypDZhk0y8JYYqAq0TslzBWosWlyyp/?=
 =?us-ascii?Q?UBbEOTOE91BCz5uLw5TjF9+l/9u4RubMtXOLFihg9NaCYvCkWfd/NrJoL9Bd?=
 =?us-ascii?Q?IpZ8ZuRTaoFQhBeFyOxEp/Q80NuzU/CAWIybDVFW4IVjRtfJEhJbf8BfxzXL?=
 =?us-ascii?Q?A3w53fsKUVIy1Evt9ADVbRnrcuw4z6mUPoPr3eB2JdRUqhR+wUZ/wwRH82PA?=
 =?us-ascii?Q?cJLUZfeip/BcA/xL5iyGMXzGXGSssNFW6Dgre1I9FqqmcS2mJwNPryhwbluv?=
 =?us-ascii?Q?/Q/eAhNtukM8+hU0u0skEDjypVdsX+P6pTRUuum3QsnDlSXczkngENeDRsUo?=
 =?us-ascii?Q?yDTsjSOy4ALNOIjo+sLitfPQbY1soD7hhEdfDYxaAu+QJde7g1kOEh6kPLng?=
 =?us-ascii?Q?u+3ZNm5iMtbq06yJCa+cnXgREG0/G+k6kGmhnzM3ecqCGGc95qFBb0oqrQ/k?=
 =?us-ascii?Q?tSXkY+iYdWAsV2LXa1fRrGxRjkySnCDzI8vda6OwY4EyCDLYKoiJm8eU+Fvj?=
 =?us-ascii?Q?QD99opjfdCLF8rYhJAS9s9lJIxTCsXXn2g0tK293CrjhtnkSOOVv0Z2MDP8L?=
 =?us-ascii?Q?scUJ7xPMCh6eGMOwY8oFqLBUyFeaXQyFpZy5j3K8M63Zyl9/wOsh+2s672Sa?=
 =?us-ascii?Q?jNBf15Ce9gq3km1NPfhVakC7l8EU9FL1Vp/3izuZ5k6pZv9zBgH1gqX0aVm3?=
 =?us-ascii?Q?y8JhZ5C1K0pAb1OArv4/d19dOcNYy3gNJ/YcJ4Jv9URrDDdvOZHDSKXiA5vq?=
 =?us-ascii?Q?7mbIYtAbSOM/n6Btj4YHy5XFeu5S10FSTVtESTpYRGM6MeRQ30zx08vdyVUp?=
 =?us-ascii?Q?CeU6hrXpwDsk4xlVkqU4sgwS+l3MfFdK10Gqo2KlmeZnCTaZPORbQ876zVlD?=
 =?us-ascii?Q?ZBeuoZwjmoyOUT3mZ782K2uGktJPO/pS6dyHZVpk4Xu+HntCxub66W8WH6GJ?=
 =?us-ascii?Q?7zd1FZGATtIAryPHfUc/Kq4GxixCdkVC1rzLlziqx0BxH+kGHbWtwGWpcnP2?=
 =?us-ascii?Q?2vBgFy1PwpGiVpRWH4656Rc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(19092799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NZ66QY9dBU91Cgtb336np9MNeZdMsmpxS7Qy0nE6Nqw9wtyEfw3Ei+05kR5g?=
 =?us-ascii?Q?zh3hWX4Bj9BKpgqAiU9nZrBLZKZQPp6N3y15Pv4wylASWIhEwOKtWOX0sXPB?=
 =?us-ascii?Q?GEn4DXycFvucYAfIcRilFjQjK9c841ciwcHpUiZIsn+sg4bCuB2V/+l/nGgi?=
 =?us-ascii?Q?7evGMXxNNx32fvFkLqwIHaLqjJgvvvbhLZ7mQBFDMwQvveheM6dJtI9inkTm?=
 =?us-ascii?Q?/Z64QrKS+IQR3x06/wG2IzOhHynglw3tkZquRYjsfbUYu3w5cRhE+egQDBo0?=
 =?us-ascii?Q?MEVksZJ7DJZp9a0CA1e3T6aTbb5gzRTfkEdGtkRj3YIt8pNAw696ccuXjAT2?=
 =?us-ascii?Q?1j3yUlj5qstIJK9KA0nDUMpvLU2kkOy04L8UY8SSkPUetYarF13G1fWFXGHq?=
 =?us-ascii?Q?Sm3qIkRSKyQ8b5d5HF2sDi50dPC7E/PJxxBAjThQTqwRLODipzh4H46/EvB8?=
 =?us-ascii?Q?4oXpi+7RbtjlAeldr9jYa7suHf7zTYoOpwe4kBQIgiPmrXYJXzXZ822/BcpS?=
 =?us-ascii?Q?ZLSid7fkqPzwIEHIUJboZGiidrIz0lX1sIHH5Vkv8I1yO+oaBMJJxgSPbpc8?=
 =?us-ascii?Q?6YZxt6gwlR2uEwZ+JwMsa4UmXgH1cwGPOoWaE2MRl9T1m28t03n/jloJVofa?=
 =?us-ascii?Q?TXXuKD0cArFGNugX8Bu4gPthglaxPWHHXYJz8gLsofTlxdD2kjZ90nDlqmN4?=
 =?us-ascii?Q?E3j7kYuOiW0PvdlbPvAe5aSM08G6gED/xEvf/qKcZXqb4LbrLNDBeCRGUx35?=
 =?us-ascii?Q?nQg+EKnMp/RBduaah8EYOWtDu5DyaQ2cjGab48wlKdgsU00Czv95KdItnjPf?=
 =?us-ascii?Q?cE/n1z+X3MOSSUpNSdLvCTtSLIl1wVaGqUQHJcSlrkquDOOI/Yzw004bR58s?=
 =?us-ascii?Q?pN71uEdf/7f1jaobnLbG0sHHAGofBRhB37V0yge2wHBx53gHhZPQw1V+MQPr?=
 =?us-ascii?Q?4xAhgfi/nl8lc1winmZZwPqw2zoWGZeskuz1WO66o41hiicBFg/uS2YNVT1x?=
 =?us-ascii?Q?xJgLzLeQuCR4CYzg+eA9rmnGZE4N95b3E/nN3vQ6x4PR3oHBLXsIOd61PyHp?=
 =?us-ascii?Q?d5Koee2gE8LVk1PKwjNfF/yeUMNAsZjJpXxE2HpHcHS9xMTgx91SdTiTUp/A?=
 =?us-ascii?Q?Vq56EGT7w8G57goH42vumtXVnU0OwPQpC5O3LFlY71tVm5DwitTqM0FDiiT1?=
 =?us-ascii?Q?GIFKuQCuBD5TMfn5pDQ/O8jO7E5j5FYfsDKsqqc9ztjKtbMwrrvgKAKNNPV2?=
 =?us-ascii?Q?X76tf+zDS1zp4W03pd/s1vG1hoJ5ByPnbXtvZVGAwypzjIy+u3y4Tq3CX4uY?=
 =?us-ascii?Q?u6hr4Ks3820j22tb2DQVYTmzlDCACdUjyrp/s0n14iYY+Qv45TuCpqzU2d49?=
 =?us-ascii?Q?yJA2dhqFu8apRKKoHy+T5SnjNJYO679T1qzwNVBmKsCK6/mLrsXeIvzbCq8i?=
 =?us-ascii?Q?/XXhKCjk5VJKoXnU0Od48gakuTfzN5xKZC/9aC2zn61wXxSBuSHYyyBwX65w?=
 =?us-ascii?Q?Nd9XmQICP+POa4xi8Arc1vKlaPSwiAhydToilFoHmr2QWJgLI1pJqcj2lKRs?=
 =?us-ascii?Q?Oy7LyN0judLVD9ehMDMu+cW0880Jg5+/NZZ6W2pW+WyWscTMMgi1ut5CZgNd?=
 =?us-ascii?Q?1ojRYzfVntWeqvUUcUjFqiXpgkbcUbovi5YVoOEmi4KCVVmNqoKyKYXHjYdx?=
 =?us-ascii?Q?4mfPg+zw3i8QkkOJFvVd48kEulEs+9FQaIhDhM1MMW5Y19EDJGQkrMb/nk5T?=
 =?us-ascii?Q?re5/ZN35dPIi7A8NJrBM3luLc7cT/c8=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0C7A1FDB8FC49148BF0A07EC349ECEDB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9jTbvR99kKjDJsa6cHIUAgEc6F2QuZBuntThgRbHZsgXa0rxNOljGRLeZ/iotL4OpjGCpibEd94JGSsWd/mtU68HxEixZlccTZx8EoND9MO3+1PNqW8BLyErH7Cv9bY0ueM97lYVSqWzzT1Tf47Ht2gUuwiy0KLulE76aAqH+gpbhvR30m+ZuuVZmR6bfS1tdzVZiO4VQoDAoXMxRfYNtS9oDdmEOemDTfZTRkjqrAESsbd4R+1MAa8nsYocKE4iH600SSXa9Ma9YBITtilRI5LUX3CfHWu8IyGvbJQXNPNzKkPS+B3BTvdrlygM8I+64RG71gWa9IKrSIv2Pyowbil/T4k8HUH2Wva2AswLk58dJM6zEJnHUDrszkwKhuKwf6JHC+HdozD6DZeb5pKvgEoJMO1CkK3UpEu+0Tmy2dwhvHDB1NlfyTz+wZSNU8jqUZ4/ZUIMM8xfur3DEWsHY9kLI4jRtFneeKs31JDv3LpxwlqgAjxanCAP+x3RWAtLZ5FECGIjCGhrOiG2/oXmQS2HVOyPXqGHbW3CWEOmWc2z+dsYxXtYoozVwWVHK/7xc7EuMoo39kdPY3Gpjsk+5rPsrPn7IpO+z+0pEmCiX36/cvWOrGshiHYxH3NWBi0F
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d8edc73-5308-4925-d73f-08de706f5fc4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2026 11:01:18.3342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WdnDNnhg92AUhhc7uymdhQJNTuDJwOHfD57CNEjqrQdC3Ftu6fH9mkL4RPZJhWwfydVmO21zAGu/rTt7IPjTm8G5IQ//alHtjS5BffgcMes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR04MB8740

On Feb 20, 2026 / 06:35, Damien Le Moal wrote:
> On 2/19/26 21:22, Shin'ichiro Kawasaki wrote:
> >  	local _IFS=3D$IFS
> > -	local -i loop=3D0
> > +	local -i loop=3D0 cond
> >  	IFS=3D$' ,:'
> >  	while read -r -a _tokens
> >  	do
> >  		ZONE_STARTS+=3D($((_tokens[1])))
> >  		ZONE_LENGTHS+=3D($((_tokens[3])))
> >  		ZONE_CAPS+=3D($((_tokens[cap_idx])))
> > -		ZONE_WPTRS+=3D($((_tokens[wptr_idx])))
> > -		ZONE_CONDS+=3D($((${_tokens[conds_idx]%\(*})))
> > +		# The latest blkzone reports 'N/A' as write pointers for full
> > +		# zones. In that case, do not handle it as numeric.
> > +		cond=3D$((${_tokens[conds_idx]%\(*}))
> > +		if ((cond =3D=3D ZONE_COND_FULL)); then
>=20
> Missing handling of readonly and offline too. These also have invalid WP.

That's right. And I noticed that the latest blkzone reports "N/A" as write
pointers for conventional zones also. Then the above part will need to chec=
k
zone type also.

>=20
> Anyway, why even look at the output from blkzone for this case ? The WP i=
s
> invalid, so its value is "garbage" !
> Why not simply something like:
>=20
> 		ZONE_WPTRS+=3D($(( $((_tokens[1])) + $((_tokens[3])))
>=20
> or just use ULLONG_MAX/-1 for the value. Any value will do. Doing so, you=
 are
> not dependent on what blkzone displays for full, readonly and offline zon=
es.

That sounds good. I will revise this patch to -1 in v2.
