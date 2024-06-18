Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AAA34C84
	for <linux-block@vger.kernel.org>; Tue, 18 Jun 2024 01:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718673924; cv=fail; b=i0bphnn3bLeZczJ1DVBzDZ7nckhx7WarcTDMe3ohec2ueu953XRFxfwXy7g9tmoQ46JSumXk1qgWX+yWPStAEunYrpA+FicLkek55icimZiVQyAQCN4+AmnsXkUH1tKbJhHP/jiquo4eDZdLUkH57VXKOSU7aFzBfsrptb7grB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718673924; c=relaxed/simple;
	bh=aFWQAXgat3i1Ikm85enN6PrbOmXlSXvtrbY5ROccqJk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ogXJfLAZzBIfubjGuoTUIw6T92tSdG63KkYgPBeb3yvuRa++SpXywXoFt5i2iYWXX8qeb8PbIKA7PcOazEqQu8PZYyLnLqX10EAF2vmBeC198VIoH858MLbKj2gesC96aYsHtXQqWyNhOfXBjxi5B/P982+WEmRyPs1IEryOUeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Doek1MJc; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=I+5bs101; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Doek1MJc";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="I+5bs101"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1718673922; x=1750209922;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=aFWQAXgat3i1Ikm85enN6PrbOmXlSXvtrbY5ROccqJk=;
  b=Doek1MJcXfZsVusVjYwZtOygQ+ddPhGXdJoTC5OoQK1EClcqkEsDW2nJ
   6HilWkRBWshMY1cXHl2qawX5CUCdw8Jr7EdzghBQphe/WCVkkI8Q228sl
   k0IZ3CUx6HbVgg9DmBmceGDMer++8m/Akz/NQuWwgmGV8aEkgu7Va2+hn
   /Ezz19JNShh0NF/jRS+END/7sIPbSMAqx1GJYjL1ZWvZqCaEx66f1Rujd
   8fSbXm4LQr4F3LcNPK3knUVIVIzIEnAYLQlzVJTzwtriPiDS8T6lQwY81
   g10ye/cnfEmxkPrHNN+Vv5qbJEF32x6GEBXv7XDfVDGMIu8Z3RFH1vFMq
   Q==;
X-CSE-ConnectionGUID: bYCyNjyaQXGiJ5WlGEjB4Q==
X-CSE-MsgGUID: Yodkc6XGSIy3kZtcHYBoGQ==
X-IronPort-AV: E=Sophos;i="6.08,246,1712592000"; 
   d="scan'208";a="19661211"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 18 Jun 2024 09:24:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YA07WYZnuayMW4lEhaEiCM8s+TDZWQ/TuLpW1HNOgbnf6jkbfFegJnLgG99377HgROHX5NIdjN2slye/8OHh5Nmgue8yrDZ3J6HCAhUljuBSFBICJX/alFCy3goHmo4EdFKM/A4aUgpVEcTjWwilErgkuYi4ClaxZqycHXAQvVXscpELfMGHA3sos10KSoLMJGP0o6tcH1Q4OyBcE1A4wg/RHLG5x8yLQzhR/YA1TJzh+De6J87RHndjzyhTrnaScy3IyNNZ10MbHQD9yp0eaIxM0gbGYcg4GywShYnYxMi1FjVyCVboku+9hZiUniY7Xm1lS9WpU4kthVY5ni7yWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pj3GBEelMTDLLwT6NXSOgKxQsFNxm21rLab1Amr7QaM=;
 b=JYUN0ZNwmWkdzVGUZyp05yT19nglYIOrSdu6axs37X2rbNPS/GO3+4W+WWJRGwz3AHalS5D6wa8BccFQTLUF/gVucbAJnxq2FAWIaTc9L9882uOY5GI/7TOL4sVv49HuWgwJUfpdVSw3v0CwWTKlkXWJ2sQtfMz5nqgyzh70LSLjy23GMXL72XbBoEn5/ZP3lo2VpMaVt1ZA9E3VNdhGrqikaC71QATwTk4vjBpSbPMVL9k9eSqyK2nRe+4KQRZ+31zoYxA9TgIgecTRYPjwvSoDbxAhRuM/sL5OiqGX+ZSE8t0slRC8LQdFUg3LErMo86f38+cz07WTSvQyg5cQuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pj3GBEelMTDLLwT6NXSOgKxQsFNxm21rLab1Amr7QaM=;
 b=I+5bs1010WD/8tFRpxhmNIuG6GJxF0h5RuGIZGAb6qCcJcdmbQ5XJC8LXudlHzF6wfIdFDgcRbKmPHLnbZjrZjCfgQESWKLh/NuZigf8uWGwzunFIrQNpxXc3Gy5xD2X4yfTLnr2ge1l7t4TXi2VBsXPSGbHHFnNbRMGOnes2vE=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 PH0PR04MB8526.namprd04.prod.outlook.com (2603:10b6:510:291::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.30; Tue, 18 Jun 2024 01:24:07 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%3]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 01:24:07 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Ofir Gal <ofir.gal@volumez.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, Daniel
 Wagner <dwagner@suse.de>, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH blktests] md: add regression test for "md/md-bitmap: fix
 writing non bitmap pages"
Thread-Topic: [PATCH blktests] md: add regression test for "md/md-bitmap: fix
 writing non bitmap pages"
Thread-Index: AQHavY1+2yGNDI7RnEqMuaOkwQh00rHL2PmAgABMY4CAAJv1AA==
Date: Tue, 18 Jun 2024 01:24:07 +0000
Message-ID: <zbeftlk6oti6uh5wx6m5ijvlvjv3xpxoqa6pj6mlasdr32eqfm@vyc5i3gyyj3s>
References: <20240613123019.3983399-1-ofir.gal@volumez.com>
 <cnaunh75p4p45e4hgdaeaqry6whwdc2pqatil5v3oxjitwobda@p2oqftzlwv2r>
 <34ee55e8-a23c-4e7e-b897-cfbcc8337136@volumez.com>
In-Reply-To: <34ee55e8-a23c-4e7e-b897-cfbcc8337136@volumez.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|PH0PR04MB8526:EE_
x-ms-office365-filtering-correlation-id: c51a1052-2e90-43e2-5a51-08dc8f35591f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Ddg0owvZpTRh6pI/ZrfGMoxZJcU4MhrNT3jD3FAk7XRv9K4ndzddr+234bA5?=
 =?us-ascii?Q?eHHRq2E2r29bWkR/M6Cm4R4SkDEyTG+FzzPGCVimjIt9Cy9ysWA5HpJdDaxw?=
 =?us-ascii?Q?Xa3i/5Shwi4vRjzeH3362cKHdi9iuGZIfVNcgFNBe6tsceEBd7tfJpO9ZFmz?=
 =?us-ascii?Q?PJCzpg1WI+GfJCdmoCTkSKPhOq65118hq1o8gpHFNtDTI0nWjd7obh8mOiUs?=
 =?us-ascii?Q?Pn6O1K07cxkoyaVG0ZyqikmzCv0D1usgkkeqCKTsPtAmMbLmWHCvFFHb6Lgk?=
 =?us-ascii?Q?2xCoTQ8qnFa6NxGUPd1sMRB4QZLBW5XfR8PjqnpAddZbdTkLv29OweRxdHTW?=
 =?us-ascii?Q?Y2BRe43haMwfUmjX7CJkmm9m+JB9OiHmd9V55RGm1S9MAqNp009yFkgQ45Xr?=
 =?us-ascii?Q?UJ6e/FJ1JlLLgpYmUs7B7NT4Abz+aM8Sw/b4hGAYfkJnyJGom4pbktCrrwQL?=
 =?us-ascii?Q?4rBqlETw6OVIB+0KKIOofjwa/VPdrxiXuF4JM0WKyvQCjp6iNDbfgL6J5Vqg?=
 =?us-ascii?Q?a1MRH8OlCaNw89PDG/9mk5QarSq6f49AVv/PuCjSBM9mQnHwzmmi4bvDHC2h?=
 =?us-ascii?Q?P5OgnU2O6bfIFHwY/tEfOW8PZSyfDehHcJzlyIpmOmG37OrU0mhFYRhH0Hje?=
 =?us-ascii?Q?EBm/qHD2Z7E7hiijbEgSBPYL9+/CFY7VbpDA18+akOYzzjGs9PRN5Df5MCwu?=
 =?us-ascii?Q?iyfVN1GjchnNEso+Q//9ChkMBZIpyXapUHvebyI/ud8NaBcJo3jeKLbcf9wp?=
 =?us-ascii?Q?rAWQwvTPmx/YX1B3UY+uFby0CMHGqE/26hAO1s04WVaLgI+TqHRx6JraqyHt?=
 =?us-ascii?Q?hJhLBv43QatLSsDnQ2tBVxRNSb6B4CT+faftsp8uzqnfw10SdHgVK4vWj+mX?=
 =?us-ascii?Q?qHEj8YPBLQDx2kj2csSK29Ejlmik3RZNOb7GR9ju3ywEdG4GrChC0hFaEdHF?=
 =?us-ascii?Q?0TeH+i3eVG9yCkvHbA1lY+YFSpZBX2fKg40OI5rUziV1fX54MqsSM7zh+b52?=
 =?us-ascii?Q?LuLWsUbXqXIKS8SgYSGdWaEzs9tQ9K8QxjV+cddz3C6g4Dhpyoq4THvg19+U?=
 =?us-ascii?Q?gyvog6xTh18dzMealwCALoDohD0neESswieVYwnXC+R6NeovW7lfIfAKrZIJ?=
 =?us-ascii?Q?viZTQViNbuAJXHPskzjF365/zbLQBqronjcd9zkbPj9Wrlu1kZ/+b6MpTaQy?=
 =?us-ascii?Q?YOXdKTo1n8KBO4ZFN/NZcuwyGmDkynralcP2Yv0MfcM2iULJEQRIxqZKYJJN?=
 =?us-ascii?Q?S42fdilkWxxyXz8J0Y/gI2VnmrWiSYh+/pb+s9f0HJIuH7ajoC5fBiX9nYCN?=
 =?us-ascii?Q?In36baCkToWB03jJLv8XVu3BUQMTBPOCQXnFWcNkqon2FV8h6uPH+MEIybIT?=
 =?us-ascii?Q?ZJBQjuo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?xH562t4XWOL/sPrfYZJRP2Tbn7LUDdWPr0crukTuCYDpZt2IdmqHoaUFwaEd?=
 =?us-ascii?Q?oG6q79y4lm8RUwyUoP+MFH/TPHy96zhm8rulhcGrxeNXlUynnlDTG7wCyVsc?=
 =?us-ascii?Q?JdYjxwapjpKujbVpNFiuWefInNLmdGJV+5PyzSXRNuparr7y9o6c1XxqA35D?=
 =?us-ascii?Q?U1QPR2BERm8B+lVRrGUsvSYqce+KP1wVLshXA8dQsTw0sUI6dyCjPea1Fgqx?=
 =?us-ascii?Q?ja58H9V0gOrgZRnsQu/dwcJJgPPquZLMPF60gc96sH6xPkk7nU7ggp3hKEJd?=
 =?us-ascii?Q?V18sv8nwEqBPT1UF1bu0NWp3bXgFASobvuAurt5P9YdP/8smf6CemTdkvtuV?=
 =?us-ascii?Q?P3QwIGZV0ztETNW7a8mzFPml06sCHHBoJN4hQbEli5lDNkiQz1BDMZ+liGJu?=
 =?us-ascii?Q?NskHdFkBc4knanIjgAql5oPmDpkMjQJF6Sm40r6Hc1qILLIK5wI21gc3cV/h?=
 =?us-ascii?Q?r0lxFjTwBavexfaq3jXlp86NTr9Df0wqDLf/EzIbbNnfRBthAxsr8D4Y3i8k?=
 =?us-ascii?Q?8JAbgPJR9KdeQLD6h9DwaGZ+9wU/xeFEQm930RpXJSFTXEwANALSEhmDX9P8?=
 =?us-ascii?Q?cCdX2SV2hFTfWtlHSR6K+wT7FtIfY0kyalBi1NuzjHp1Qdou6sYRRK/AA/J2?=
 =?us-ascii?Q?YkQSRfNb9rCYBKwtZVr+8E29kxPb3y8ieX0gXxQdLhSYUSvzsG8vNP7SetGe?=
 =?us-ascii?Q?tvWpVgmcrTuIz/w9vyAUQqp2G49bc2VrLOyT0+fYez2mILq1zwIDG9V3g+H6?=
 =?us-ascii?Q?/KzIaWEupTej/nRWQdT6dQmMsDfwU7hOjPe8lB4BbhE+J1oCZebns8J23NJ1?=
 =?us-ascii?Q?Qx2nwoQpgJRLcrdSDj24ITZSKJ5jnxqE16pvWwX7V9hGBxUeeC3AVDf/Dq5M?=
 =?us-ascii?Q?iaf6zq/DL7mgZrHeKJQbtyIRvqdlBqJi/hOq+r6Yw4UIJ1iGbDz+JTs3zHwO?=
 =?us-ascii?Q?MIHME2dORhSAQLjmS6XsQQZiB00l5hyLuJy2ekl4Q3g3H0fs1hbYGC2vzyIR?=
 =?us-ascii?Q?akDQ7smnQ18R7ibTG3iLxlCinRn0VEpjjmJT4MaawSHJSYvf0FFcjwRv1RMn?=
 =?us-ascii?Q?bnriplRPmxYw4uFPjrJjpiS6ELwYotEf6zo/Ws0upmTvk3emOvJHYIcXs9xF?=
 =?us-ascii?Q?PYEfYYh7uCCJVl7ePqdUI5dx6BzoTvGeeH6oNj8yKRubtZllUaUx+fUsd+4b?=
 =?us-ascii?Q?U8B2LSZvxm3LFPLVrJjCahJ9vCP3EpVf+eISePp/DjzL3x3yxTc2XhVMVva7?=
 =?us-ascii?Q?JBSSW00RusI4gFCCi/al34kB32wzB46nNSJ3v5F8RgIK5hlP5vXPI5IImTIq?=
 =?us-ascii?Q?pnFfPIDgm835fbzUYGsMKC4BqYDP7oFMHy1aNzeteLqy4139rVoqrTJFJfXa?=
 =?us-ascii?Q?G7B+yjgdn1E6SR/eYEWnVHZGuiFcKiAjrNVYtdeE4+jKYdclTE8zYefvmVsh?=
 =?us-ascii?Q?hQNsEfhqVrZXVUl/8fLrfiHnnkJ4wyXt7hu/8NzXI7zibxcm9LXBLnBl4N/L?=
 =?us-ascii?Q?Wmv3iqUmA81ZkcALXhzcPp7dZP2j/DfM5Q0eZgc3Qopi2eWBJ6nreL0PYmAV?=
 =?us-ascii?Q?08yHVnqBUTQk0QEeHuFSPDnNgjXHZ4+M6q9TE+WJJ25HH39BEwzzihUd6BuG?=
 =?us-ascii?Q?duYYvnS8Gi+gZGvVI5MPkZ4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D969841858B63E46BA68ADC4865649D7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wRRrapgybCOUmjPJFzYTZUdjRD5rp1k5+wKbJb/wRfQlXSAYrB0FB+RmOO8HV+C12+TAUhquJLJC7syiOPwoD39EHWFjEBO9jY07SQAdWoIW7rUFA6W5tU9/S2KYIzmOQoXoh18trz2a40ayVlhOwibf52ZaHzgOz8nJaizoJemQHFlFYoldbUcmrbB9mQq9kjg9s8TO5r3lHkGTwj+PPxXMzb8rMi6VSmX2OH498Krc6pbNVrpXx2i/5pyGcdhwmXS6qovX8+VSigKbsa4N91wZVtkHEsZwWuVSWJJZqPcLj2PuilqTT4K2bB6sq7zw5vDwOwAL5eDT1VclESGpY1/VDpojGhHjQ9VLaF0s3YeDQaBnDonFKTgFWBSWxIScvwlNPwkQfchCPDzXY/Qw+Rtz4RNCIKxL2MCa7UEZgB3rg7BbBBw9IxPgBol5+E2/qkdRfcTGvM9l26S2TnQ1QtYKhcvv6Cu20QpMphvrTXIYgU/K+XuNuumeNUr6BNha8o+ORRDuYtpc4pK8e5vAq/L46HX6X4XckjqTspFJVJ/X8yv3NMsd7x8BPf7wITeE9BEkTxtXurM/4p2skSDzJpoFcTfDfuVyCuLcWd02qqrUiDO3If/OKgEiXWcd+7TN
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c51a1052-2e90-43e2-5a51-08dc8f35591f
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 01:24:07.0941
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VuH2HRNFTWEBIaMetyQH9dlJGuHWj2WuZu0mZ6P73T1cs/+3nstfmLQoDkE+LTr3VHb2sPiLMClObOXht/rRCwEgSILU+v8DAN68WGUJu9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB8526

CC+: linux-nvme, Daniel, Chaitanya,

On Jun 17, 2024 / 19:05, Ofir Gal wrote:
[...]
>=20
> >> diff --git a/tests/md/001 b/tests/md/001
> >> new file mode 100755
> >> index 0000000..d5fb755
> >> --- /dev/null
> >> +++ b/tests/md/001
> >> @@ -0,0 +1,80 @@
> >> +#!/bin/bash
> >> +# SPDX-License-Identifier: GPL-3.0+
> >> +# Copyright (C) 2024 Ofir Gal
> >> +#
> >> +# Regression test for patch "md/md-bitmap: fix writing non bitmap pag=
es" and
> >> +# for patch "nvme-tcp: use sendpages_ok() instead of sendpage_ok()"
> >> +
> >> +. tests/md/rc
> >> +. tests/nvme/rc
> > I want to avoid cross references acoss test groups. So far, all test gr=
oups do
> > not have any cross reference to keep them independent. How about to add=
 this
> > test case to the nvme test group?
> I don't mind to add it to the nvme test group, just to clarify the test
> checks a bug in md. The bug is "visible" only when the underlying device
> of the raid is a network block device that utilize MSG_SPLICE_PAGES.

Good to know this background. I suggest to add the last sentence above to t=
he
test case script header comment.

>=20
> nvme-tcp is used as the network device, I'm not sure it's related to
> the nvme test group. What do you think?

I see... The bug is in md sub-system, then it's the better to have the new =
test
case in the new md test group. To avoid the cross reference, the nvmet rela=
ted
helper functions should move from tests/nvme/rc to common/nvmet, so that th=
is
test/md/001 can refer them. This will be another separated, preparation pat=
ch.

To nvme experts: If you have comments on this, please chime in.

>=20
> >> +. common/brd
> >> +
> >> +DESCRIPTION=3D"Create a raid with bitmap on top of nvme device with
> >> +optimal-io-size over bitmap size"
> > This descrption is printed as blktests runs. All other blktests have si=
ngle line
> > description then the two lines description looks strange. Can we make i=
t shorter
> > to fit in one line?
> Yes, does "Raid with bitmap on nvme device with opt-io-size over bitmap
> size" sounds good?

The word "tcp" sounds important. And the word "nvmet" sounds better than "n=
vme".
So how about: "Raid with bitmap on tcp nvmet with opt-io-size over bitmap s=
ize"?

>=20
> >> +test() {
> >> +	echo "Running ${TEST_NAME}"
> >> +
> >> +	setup_underlying_device
> >> +	setup_nvme_over_tcp
> >> +
> >> +	# Hangs here without the fix
> >> +	mdadm -q --create /dev/md/blktests_md --level=3D1 --bitmap=3Dinterna=
l \
> > In the past, short options caused some trouble. I suggest to use the lo=
ng option
> > "--quiet" in place of the short option "-q".
> Applied to v2.
> =
