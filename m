Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D927D1F5437
	for <linux-block@vger.kernel.org>; Fri, 30 Jan 2026 03:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769744994; cv=fail; b=Ndc7m5H4ZPWzqPbsLZkFLsFklJfR8YhIfKaYyBC8jJ36GAtbbIpzqWD+CpCOKaFxmAUNI6nAco49KZNoOxUGJFKMKx9utzm692e0P9tx5LE46/xVgZ2LJwhKQkScKLlSKq4ROdecME0ur3Q7TRVNlPxJb2amPFuqgMfoKLColWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769744994; c=relaxed/simple;
	bh=0mHejiLpaouOtjwvo6zVCeCnNCQh9E9W2dRNdUYXVyU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sXre8eNAPs01BazwasXyMm4vtVvFNzuQrW5n93rBDzUgMpbodm0WUWIXSz7dtXhcTC/YaxBHEGvZXElk+izjSi0RmyMh9tZhJWKwJ44fQp66OcdNnr75DPtUjQZj7hWTUdvgnM+IYflTPXYMkDA84ZJQ3SQXKcLze7f1wOFEsxE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=grUIOsex; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=bD9DpQyK; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="grUIOsex";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="bD9DpQyK"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769744992; x=1801280992;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0mHejiLpaouOtjwvo6zVCeCnNCQh9E9W2dRNdUYXVyU=;
  b=grUIOsexx/HkXXI8ACAUlkVp7te2wgB8xSBMf1yTYbhv6iAjSLgu8Qum
   mVsHGT7Izt0TWEMte1aWMAG6jQpEDJkXK/E90sedfnsBop7KObZLp8nNI
   mFodtW2nvq9IHsat0tlveS5g9X2isr5sMREDBsdB0D2QRJw+w96/uaydP
   OMMkCiwN0pmVrEGH0zd651JmztnYMS8W6vhU9Yr3xXkbdJc6m1PQEOlp6
   SICo2ZXcJMQg+wG/wIHQf3e2S2t66wSKkQoVmJwpqzkma7DK1v9rNFqRJ
   Lb8wFpaTKnXbSlBGS6BEOIb0UXoD6DFFG5t57sah6JoP1C16eff5Y8ATN
   g==;
X-CSE-ConnectionGUID: 3cS9YWy8QE2vKGJI3JbMUA==
X-CSE-MsgGUID: +WpzPBr6TtGE4trCUdIOqA==
X-IronPort-AV: E=Sophos;i="6.21,262,1763395200"; 
   d="scan'208";a="140922543"
Received: from mail-southcentralusazon11011012.outbound.protection.outlook.com (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.12])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2026 11:49:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u0VUUf9vDckYnI6bGE1QIu9PjwWrZPPcPr7UXpg8ik88UM9FQdE9FFmxt2CtX0b2269mi8g0TwCVqm4Z5T/m/Wzni3Su2pq0XiXwn5IK6DMy9EFOplIFRkDXaQrT6PmIIwlGmwOvUwnA7+5/Rhvh11K0SlbNyzUZgiWIjOx1O09t3QKRQG4XrsifiEBxPTIR6ZJbemWaeCFZ/wgmY+7iKo8nasVvQdK8G+ZuGsC2hiTR/4tKMVrOArwp7cxVRV2NME96E8cU+IZMWW3i0aV4CDu8rmrMohcTNCjevOg62XsKFCAYTPMl3wb4p5htZbcG9p4u0r4o2AF4YIWetPnoOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9HEyR9Gb96dXIYdRhQ/+7I0Fw973pFTi20V4ZVbGio=;
 b=yi7PsQ7LnHf5Oqi5+KTWfdpFgr3WsiHEN0WTgujaxfMsVVxrhU3KS4d8EzMOMNlwfNSSGxNJSzqeLdk+E3CHQNf7euhRb/wsKmS8Z0A7fCVZ5BlCwmC7nCEchW0hVZvMsajBj+SRDqUhRsgSs2LeSKUvyvpvFeXujqnm6JjqkDmOn7v1xx3Qx4aQXXyU/II1wg9HeL7q/Mm+ZAyW4/NyIIt/uqwT1syND9Sa4G+TfOwCLilezEeafkZACy+g8neiTaQDhalGEdO656Qm+qv5odVJ1yizyck8dvLWbWpl0VRffKvxxl42HQXNC/zTo7ugfxRX8h+DXLzzfQSzgxvuIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9HEyR9Gb96dXIYdRhQ/+7I0Fw973pFTi20V4ZVbGio=;
 b=bD9DpQyKD//b3NQ+n3oNec/lVXhoT6gkklJXu+LfF6PvDx1sS3GFe46TbWvM6n3crygt3SLTp6USmTY2Nxgyt8Jv+54rwi5TQ/dTBd/5H2C8P8neYGGhTbSZYWpYsSIVMT+sdsBe56MZnT7imDvxwDa6ZrPxi41oDPohrGRrHZI=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by DS1PR04MB9162.namprd04.prod.outlook.com (2603:10b6:8:1e2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.8; Fri, 30 Jan
 2026 03:49:44 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 03:49:44 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "sw.prabhu6@gmail.com" <sw.prabhu6@gmail.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"vincentfu@gmail.com" <vincentfu@gmail.com>, "joshi.k@samsung.com"
	<joshi.k@samsung.com>, Swarna Prabhu <s.prabhu@samsung.com>
Subject: Re: [PATCH blktests] nvme/067: test io_uring pass through for NVMe
 admin queue
Thread-Topic: [PATCH blktests] nvme/067: test io_uring pass through for NVMe
 admin queue
Thread-Index: AQHckMhSqqipvaZGFEaEdN6JpYLG77VqFV0A
Date: Fri, 30 Jan 2026 03:49:43 +0000
Message-ID: <aXwh2TKBhSm-c_0z@shinmob>
References: <20260129023754.685508-1-sw.prabhu6@gmail.com>
In-Reply-To: <20260129023754.685508-1-sw.prabhu6@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|DS1PR04MB9162:EE_
x-ms-office365-filtering-correlation-id: 498eac79-e0d7-4957-be59-08de5fb29af2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|366016|1800799024|7053199007|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hGz8K5/Opgib4wSA5qddfhFayZ+ywirX9XNpMQA2U9z/oQqzHa3kJ2S2dvq4?=
 =?us-ascii?Q?Sg+P7YldQn5FR6tlNeWdm3S/JmJ47o+Q+LpI/kpZ5KRfOYisCfw3PqDN5Wbs?=
 =?us-ascii?Q?06iVnVYH7C5RcTveGvSgD/RhAOddv+qpO4wh8/UHmplO1VzhLJ3GzhzKts79?=
 =?us-ascii?Q?HkXsOzvu7XoKk51P0Wjl3kQfjDevZoIRJUqJlh0Iods51NTLkl+scPsNU7Bk?=
 =?us-ascii?Q?UyB16WCOuraWmy8WomxbUKiFrAlLVaVldhN5DXD8lE8yV2aeES5qBBJaeW+5?=
 =?us-ascii?Q?IjxCFyUwJ3QNIdQlaIQJo/93TZl/8uAi8RJY46NV4A04b6Wpd1IB28iXcxQY?=
 =?us-ascii?Q?R65/WcA8VvvBciNWQYs/pl/nor8DoFdNJU0KPFHpMFFtflT6KExdJwU07Y/X?=
 =?us-ascii?Q?fRekeUXC5dwoPm7aE7pmC9t29I4caxhW+hDmjVTEPskUqfn2EECg5qtbxHLt?=
 =?us-ascii?Q?yiZ3f9zgCYR2608o/HOJQ8cgJvGbYQbYz0x8SygdMYXW7udA6WPrd1xLnUyc?=
 =?us-ascii?Q?lcM+UQL9S8JS7WN3qNcdsTRH2NqxZpYaKrBWjhpYEdWVkTKRFFr3FWS/z1Oc?=
 =?us-ascii?Q?H+Ao3OYt7GSpmQINKZHbp3hoVu/ixnOUwwLliHwfRRIQIMG4EUPsmdoDg0LZ?=
 =?us-ascii?Q?AMnXNOCHXDYNMMWsISvSTC8lrou/QxpVGJ5+zAIUL2GYBwgrvmDq5GREZhb2?=
 =?us-ascii?Q?xpGk8lmcs3FDVTei+R4S/eQkOgAEbmZbdPG3DwVW3twQkWT/dUD33C3a1lzo?=
 =?us-ascii?Q?hWF2M7PnrnPdLj80rNvzU41vPA6AIeR6loeWjYCjYiF+PAzOdL9NmWaeOznm?=
 =?us-ascii?Q?icBWNbiMv+6v8SJ+UrvMbNpxeNHZA1x8MoqggG7Wk56xhGpM4smKCA3S8WXZ?=
 =?us-ascii?Q?513QpNDdazwchutAwsbmUTHfxCua6yYCU4LPprZL2VpEMHGN2dWFf+aiJ2i4?=
 =?us-ascii?Q?eQv6X8pbrRBl0KACbXDom3N+8c9r5YeZ+7GtgntCRlImjRSFSpqzxfzN7gQK?=
 =?us-ascii?Q?Ty4LP5E4KrVuBOucfI4y7Us/EpnONzUR+b1tMv/Lp5xCGZd1vgvrv1nBHGpt?=
 =?us-ascii?Q?QG4uqKjvZtzDheuD7fpjYAdSbyLFhKzJymgYZ02WpFrXR7bHcxT0/UYrIiu9?=
 =?us-ascii?Q?gRxdPLaq66AF2VTEUSCI4nKAzFDHS27Vy3QgnuDRO14xPMpu4D8m9vqvwYY7?=
 =?us-ascii?Q?G1/FOoY/QGDcZjgbhUEhAg6o32E4SETaJsHiKrcL1Py626fdUDsUqW2xI3Ps?=
 =?us-ascii?Q?nu3KsTtQmfp6PLd45Lj7Ri1O1p4cMi9ZodBPCWeveJhFEvks5ZtHW4miPzh1?=
 =?us-ascii?Q?WfLRBYAE61R+OXi6V2auyFigqgENGrecYTOFQpKHBHoFSiO2kD79XwppdzkW?=
 =?us-ascii?Q?4mpGSH5WIGyImksydtC4CjMm5oAhrIg0BFU3KYgjJfwGbyYzR7kMCN2T6Qzs?=
 =?us-ascii?Q?KsWWX9oSP2V7DQBj44yBJXdlEtT0L3+zdnkFVUpY+qXIw9n0Ch+tmhk2bqZe?=
 =?us-ascii?Q?bnLUwmwmXL/Zdp45MWRX2LEUpqA3RAtgiM2ltXBay17a+Y+i7+ZHLw7R9EnK?=
 =?us-ascii?Q?6ed6aZoIuf7VOZ4v/4/W+cuZXENjuvIp4w/UczVXUa5l6/Zy4uBXezjvSg4l?=
 =?us-ascii?Q?wLdi3ajzbjbTHaZ6X+9UWCs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(366016)(1800799024)(7053199007)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Nh5eg12ff9/gpxpqgJ/S5sjE+yFX3RtcdkxQX/avS+cqMVW5Kv0ivUijZ2Iz?=
 =?us-ascii?Q?EC8oGlupBAZYj1gMr+3gOBGbxWsAp81bDROo74D4cihpFVsZetAyyG6osh6B?=
 =?us-ascii?Q?ZT6+0cVJs7r+MPqGtKyZM4PIOWBgHZFg69sslwfAuIgv73hStkOtSh4BFYe0?=
 =?us-ascii?Q?ntMvm8vxgTOWh9AyQZB9NIgseoecERCHR+VVyN8Xp3B0EHFg5ArCYdeiLuh7?=
 =?us-ascii?Q?NsTW/q6ywwcf9Fg3Td4OotBqkxxlnbB6c9EIC9bNpKZVNjjqJWuy68QLwOdT?=
 =?us-ascii?Q?MdXpkA/v0iYOeL89YekwEqkeWyiVYK93qDB7QfaVjdmCdf8FBrQM6FgbDZux?=
 =?us-ascii?Q?+Iw49Zqlu4qX73MW/XjnoJcuNqQs+xirmqSNmfZDJscnBC4K1jl6ZHe8LRTz?=
 =?us-ascii?Q?k7brwam2mLzOaPmBbmM7F3RJVV5v1RX60WPEG9agTh5VXseFua7zs01MmU9e?=
 =?us-ascii?Q?ZZ9B7dYrIb8O/ZQOjMNnxYrpEq2WOUunu4KJV/in7mVy3eiI3w1ICZ61hvcb?=
 =?us-ascii?Q?AV+tj28GrQCcmpjPRdWYD4OkdPJXDy1heO+nyopZWdAk3ALB+kaH6jgFFCun?=
 =?us-ascii?Q?L7BIh6jq2UorBupDIzNAGMcodR7xPfU4qCYWi6RsbgXRp2uCBaqKjZLHhoM7?=
 =?us-ascii?Q?Pg5Cm8gQCdEqAzhKMBfrue2CLCo2sS7usZhld2n0fTU1UzAki2z0h5Jbjp2U?=
 =?us-ascii?Q?M7K+qUnoiq/jXHOJaU22OENmIDZ7wz5K1L2OVJFxyEVTqxB08d6l0Iq6pchi?=
 =?us-ascii?Q?DOAb8x1W9jViwpnGEZlqaIU28EMKyyE2mo+/D6FcXpFXjWhcsprkIyl9ENVC?=
 =?us-ascii?Q?fNxomBBLe4Lcuvs+c1vGUD0Ip8c86+RsR+65U82FF3u4tb8yBZSLhUGaEBZW?=
 =?us-ascii?Q?8PWSRL/nx+86aumj5jNxTeVIO3KpPHrm4Ys3A4VKN2ckqQRhWTyTJ/2+YrZm?=
 =?us-ascii?Q?iwNfehFiglVsH50LNNy3b4NhCPlUooyPgcgZc+XyMLeY/VurzvAWZzMD1E5u?=
 =?us-ascii?Q?2tcrpreWT81oRr0aNlpnca/J1IFUAj9riT2J1ixFxBlLnxg9AOUaBtUvmjmk?=
 =?us-ascii?Q?xb8v/PQAJyXUiuaR7+a8/8/6scYnhU63QJMaFlo1Je9onXsUwfwxoXkcFWgH?=
 =?us-ascii?Q?NBh3WMMaIYC9UjYUaGnoK+wMJ9ykAKXOjDfBtvCnr503iXDuNGayShO4EzxQ?=
 =?us-ascii?Q?Rt6VBLX0BsVyyI9p8O1iHkIypy8JGTCIQNC2rXGBtgrvi0Mmd2B7PJsQqkAl?=
 =?us-ascii?Q?euPX+Oum/DoTZWHzHCjP+NDfGRnZZXD8IjL798OcTa/RkNwPtXocDPyJJV43?=
 =?us-ascii?Q?nTUeKlj8yL7lKOYMdS6E3Jw9UVi6fioV5es08RxcLyDQCDIR058WDP5t7W50?=
 =?us-ascii?Q?sRPxtmlmGgNMr+Vav/hyxF3T3ZXA38sTYlVRIxyb7v4OBa5N1nmXMS45zThR?=
 =?us-ascii?Q?nFzA1Z1UO3LGzibINTiZSPadmOzqkjdTuxRn/3rF9GxUUGUUmhIoQ0Yj1zdY?=
 =?us-ascii?Q?17yU6E/UlDWF6coddgUeYht7J3RuYc55V+cu+lVdeMalqncvFR9oaH3p+5tM?=
 =?us-ascii?Q?RBahz6JtHI5nna7v+yNkFczjhoeMR0BQz8VZTYr4hqgCrJQFa92QTLaPIMqg?=
 =?us-ascii?Q?vI9nXzFy4gRTSYn4Yduglz0JCR3HKTeo6uBY40mmoEG1wNiT8q61RgshQmRg?=
 =?us-ascii?Q?35kzoNmukKmnP8CVP828Zgyc+xHY5DWeW9xPmzfLAFJ8XB3yE9WFhqs2eRFn?=
 =?us-ascii?Q?yxWzCQ5ivazCrAk9ulMvdfTh8m5duCI=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2358E96C344CD8449A4AA88DAC23CECB@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/9YoT4bIIOc5DdDEIpljimUX11yAANmrvg7uBZwYjVWEA9RfkF2w3m+lV4xXi42WP5Kqz6ju9SHSD29MILcplb9pVGE1yCY12pbkEBNeLss3CzpYcX2hZ89LJrYLZK8bcTmqBbhorZIoMM/BWTKjCpVzNYH1TZ20cGLM+3lTZI1DDESvv2xSZkPnjODAFXiJQ0eUf/IDlJbXWNqOtgzsJfsP1HjzqHXOwg6TVpI8HOIbsPlnioju42VLhVXomhxxQTU6N8hNAEvkSARFokA65svkGUUF3h61Mzjj/hJ0+p5koT1B0FNS02zT3+i42f8agAnZ4BqtjC00kr5iR3R63reFw8R93JvUHpfDBTgveciLkHAShiB3Q54Wizz86PowsEzJyCdl4DvmMRcpkiClFGO3wxzTMM4u7y0kK7hWrApxw/ERHMxueOoeDDU07ugQa3sT/oHiLo6EG3WsqKcaEWJvS/iyGIsfWrd8hviP5qtF1nMlN4YVj/6OssJ+lJt5A99GZ8ugU/WQeT/1nBIqLmIXmyJW4NtG/SGd9g6TjBDLkU11DHFALIX+j+3rAbMjzzTvgme04ISMZ3MiTKDDE95HtEf8qfiL9wnUZNbQbXQ3B6r1T+muGGusj/RTwyTn
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 498eac79-e0d7-4957-be59-08de5fb29af2
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 03:49:44.1214
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WlSmHvqFOJM/orXkoB6/AjWrzt5PLdLeLF5XPXywkCllpYmvIdB8niUIgvmwIFhGt0ICv4XXgk324lbNYkSuTGdQPIsepbzjCmjdZX9FRkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9162

Hello Swarna, thank yo for this patch. I ran the test case and it looks
working good. Please find my reivew comments in line.

May I know the background to add this test case? Is it relevant to any kern=
el
side fix? (If so, I would like to have a link to the fix)  Or does it inten=
d to
extend kernel code coverage?

On Jan 28, 2026 / 18:37, sw.prabhu6@gmail.com wrote:
> From: Swarna Prabhu <s.prabhu@samsung.com>
>=20
> Simple test to excersie the nvme admin commands usage with

s/excersie/exercise/

> io uring passthrough interfaces.
>=20
> Signed-off-by: Swarna Prabhu <s.prabhu@samsung.com>
> ---
>  src/Makefile                 |  3 +-
>  src/nvme-passthrough-admin.c | 94 ++++++++++++++++++++++++++++++++++++
>  tests/nvme/067               | 27 +++++++++++
>  tests/nvme/067.out           |  2 +
>  4 files changed, 125 insertions(+), 1 deletion(-)
>  mode change 100644 =3D> 100755 src/Makefile
>  create mode 100755 src/nvme-passthrough-admin.c
>  create mode 100755 tests/nvme/067
>  create mode 100755 tests/nvme/067.out
>=20
> diff --git a/src/Makefile b/src/Makefile
> old mode 100644
> new mode 100755

No need to change the file mode of src/Makefile.

> index dac07c7..0cb8d4e
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -23,7 +23,8 @@ C_TARGETS :=3D \
>  	zbdioctl
> =20
>  C_URING_TARGETS :=3D miniublk \
> -		metadata
> +		metadata \
> +		nvme-passthrough-admin

Nit: the name of the program does not show that io_uring is used. To show i=
t,
I suggest the program name "nvme-passthru-admin-uring.c".

> =20
>  HAVE_LIBURING :=3D $(call HAVE_C_MACRO,liburing.h,IORING_OP_URING_CMD)
>  HAVE_UBLK_HEADER :=3D $(call HAVE_C_HEADER,linux/ublk_cmd.h,1)
> diff --git a/src/nvme-passthrough-admin.c b/src/nvme-passthrough-admin.c
> new file mode 100755

I think file mode 644 is apporopriate for .c files.

> index 0000000..ef5c241
> --- /dev/null
> +++ b/src/nvme-passthrough-admin.c
> @@ -0,0 +1,94 @@

SPDX-License-Identifier and your copyright are missing.

> +/*
> + * Simple test exercising the admin queue accesses via  io_uring passthr=
ough
> + * commands.
> + */
> +#include <errno.h>
> +#include <fcntl.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <liburing.h>
> +#include <linux/nvme_ioctl.h>
> +
> +#define NVME_IDENTIFY_ADMIN_CMD 0x06     /*Identify command using admin =
queue */
> +#define NVME_IDENTIFY_CNS_CTRL 0x01    /*Identify controller command to =
a NVME device*/

Nit: some comments in this file do not have a space after the comment start
"/*".

> +struct nvme_id_ctrl {
> +           __le16 vid;
> +           __le16 ssvid;
> +           char sn[20];
> +           char mn[40];
> +           char fr[8];
> +           __u8 rab;
> +           __u8 ieee[3];
> +	   char pad[4020];

Spaces are used for ident in the above lines. I suggest to use tabs instead=
.

> +};
> +
> +int main(int argc, char **argv)
> +{
> +	int fd, ret;
> +	struct nvme_passthru_cmd *cmd;
> +	struct nvme_id_ctrl *nctrl;
> +	struct io_uring nvring;
> +	int queue_depth =3D 80;
> +	struct io_uring_sqe *sqe =3D NULL;
> +	struct io_uring_cqe *cqe =3D NULL;
> +
> +	if (argc < 2) {
> +		fprintf(stderr, "usage: %s /dev/nvmeXnY", argv[0]);

Nit: I suggest to add "\n" to the end of the usage message.

> +		return -EINVAL;
> +	}
> +
> +	fd =3D open(argv[1], O_RDONLY);
> +	if (fd < 0) {
> +		perror("open");
> +		return -errno;
> +	}
> +
> +	nctrl =3D (struct nvme_id_ctrl *)calloc(1, sizeof(struct nvme_id_ctrl))=
;
> +	if (!nctrl) {
> +		fprintf(stderr, "Memory allocation failure\n");
> +		return -ENOMEM;

Nit: Its a userspace program and we do not care much about resource clean u=
p,
     but it would be a bit better to "ret =3D -ENOMEM" and "goto" to the li=
ne of
     close(fd).

> +	}
> +
> +	ret =3D io_uring_queue_init(queue_depth, &nvring, IORING_SETUP_SQE128 |=
 IORING_SETUP_CQE32);
> +	if (ret < 0) {
> +		fprintf(stderr, "Initialize io uring fail %d \n", ret);

Nit: same, it's a better go goto to the line of free(nctrl).

> +		return ret;
> +	}
> +	/* Prepare the SQE to use the IORING_OP_URING_CMD opcode */
> +	sqe =3D io_uring_get_sqe(&nvring);
> +	sqe->fd =3D fd;
> +	sqe->opcode =3D IORING_OP_URING_CMD;
> +	sqe->cmd_op =3D NVME_URING_CMD_ADMIN;
> +
> +	cmd =3D (struct nvme_passthru_cmd *)&sqe->cmd;
> +	memset(cmd, 0, sizeof(*cmd));
> +
> +	/* populate the cmd struct for the opcode */
> +	cmd->opcode =3D NVME_IDENTIFY_ADMIN_CMD;
> +	cmd->addr =3D (__u64)(uintptr_t)nctrl;
> +	cmd->data_len =3D sizeof(struct nvme_id_ctrl);
> +	cmd->cdw10 =3D NVME_IDENTIFY_CNS_CTRL;
> +
> +	/*submit the SQE */
> +	io_uring_submit(&nvring);
> +
> +	ret =3D io_uring_wait_cqe(&nvring, &cqe);
> +
> +	if (ret < 0) {
> +		fprintf(stderr, "wait_cqe: %s\n", strerror(-ret));
> +	} else if (cqe && cqe->res < 0) {
> +		fprintf(stderr, "Command failed (cqe->res): %d\n", cqe->res);
> +		ret =3D cqe->res;
> +	} else {
> +		ret =3D 0;
> +	}
> +
> +	if (cqe)
> +		io_uring_cqe_seen(&nvring, cqe);
> +	io_uring_queue_exit(&nvring);
> +	close(fd);
> +	free(nctrl);

Nit: To allow goto from the error paths, the order of the two lines above
     can be reversed:

free_nctrl:
	free(nctrl);
free_fd:
	close(fd);

> +
> +	return ret;
> +}
> \ No newline at end of file
> diff --git a/tests/nvme/067 b/tests/nvme/067
> new file mode 100755
> index 0000000..8c273fa
> --- /dev/null
> +++ b/tests/nvme/067
> @@ -0,0 +1,27 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Test out admin commands through the io uring passthrough interfaces.
> +
> +. tests/nvme/rc
> +
> +requires() {
> +	_nvme_requires
> +	_have_kernel_option IO_URING
> +}
> +
> +DESCRIPTION=3D"exercise the nvme admin commands usage with io uring pass=
through interfaces"
> +QUICK=3D1
> +
> +test_device() {
> +	echo "Running ${TEST_NAME}"
> +
> +	# extract the ctrl dev from the test dev
> +	devname=3D${TEST_DEV#/dev/}
> +	ctrl_dev=3D"/dev/${devname%n*}"

I suggest to add _io_uring_enable here,

> +
> +	if ! sudo src/nvme-passthrough-admin "${ctrl_dev}"; then
> +		echo "src/nvme-passthrough-admin failed"
> +	fi

and _io_uring_restore here, just in case the system has
/proc/sys/kernel/io_uring_disabled value "2".

> +
> +	echo "Test Complete"
> +}
> diff --git a/tests/nvme/067.out b/tests/nvme/067.out
> new file mode 100755

I suggest to run "make check" or "make check-parallel" before blktests patc=
h
post. It reports that 067.out should have the file mode 644 instead of 755.

  $ make check-parallel
  Running shellcheck with 4 parallel jobs...
  ./tests/nvme/067.out is executable

> index 0000000..c56866e
> --- /dev/null
> +++ b/tests/nvme/067.out
> @@ -0,0 +1,2 @@
> +Running nvme/067
> +Test Complete
> --=20
> 2.39.5
> =
