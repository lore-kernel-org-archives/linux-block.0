Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB462620D2
	for <linux-block@vger.kernel.org>; Thu, 17 Jul 2025 07:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752737646; cv=fail; b=jX9hEF+amZOhVBo/cZhnyX9fUjGR0lFM5Ql37emulflxoQ+RQj5m/4kNJHUqscm5rv8jZR5EQRhXYf68gsFv6w8BIIR5fQFroegC0HPRdwiifiX8/bw0bWzkfHJTFHMY1PAbBl5QqdbsUv2aCKcZonJmv0ZVXoeP6czghKVTTuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752737646; c=relaxed/simple;
	bh=JBTskWyYLGU1QjmJeXzrq65cBba45yjXaUdybkLUMGI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OZ8id7NCJy35QbxnQMeqRMjbmVg/kZlH+AsDb3FxE5tlBjutKRk80koAkdxsA3T5g0sYsvLaiw2q6DF+/xqSMv6ZgdL8pTjdBYKySVfjArQzLWPPuhQdWv02L0P/qy1LQPJakNJdRwaNFLB4++N/zEdm0awF7eD++waVNyG0XgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=oYb+VA1L; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=mqbtYegA; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="oYb+VA1L";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mqbtYegA"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752737643; x=1784273643;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JBTskWyYLGU1QjmJeXzrq65cBba45yjXaUdybkLUMGI=;
  b=oYb+VA1LOTM/jCkn8h9IvsWINnZiQgEgfMWt7qYyvyonkJg7FToncYT8
   Gr5yEhftQ8P9R7MAAuJshA1gVwIiAYve1VDdvesUmvssNCT5CjHQKfSxq
   78eQogdWZ9Zm7nlqE3WahDnkQDyXrwuvvC7vXFzsQ9YhRPlPV++MBtYWC
   4gIq4stRYeOo4NKG0yfGaQTuQl8VM4exVaS6/+k4UgMNlcSsbHat5tTAI
   eP7jLrbm1iqUrWy6iC0vDuUgBvou0lDrkTDcZPV4D1pczsyXFFu1CoxnA
   +S4ETPs7xNSYhrionmBTwOx1k8oCJLOSjtwTLXH9ryHNkj9vF38t/YvQr
   A==;
X-CSE-ConnectionGUID: UtdFkrdmS4+OwhEv6jFiCg==
X-CSE-MsgGUID: NYRoD9vDS52xkviOmvsvKg==
X-IronPort-AV: E=Sophos;i="6.16,318,1744041600"; 
   d="scan'208";a="94143419"
Received: from mail-westcentralusazon11012070.outbound.protection.outlook.com (HELO CY7PR03CU001.outbound.protection.outlook.com) ([40.93.200.70])
  by ob1.hgst.iphmx.com with ESMTP; 17 Jul 2025 15:33:56 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iJf+MfaWRd657PkjEKDRTo8THyvExrDfc5gT+s/n7Knh6tPCqDY26P8YJE16AZA6uyO57VH033MkcofYt19PVD6fXzoEH5vW4x6Da9tiHWFqk2zZd0c9Ua19tBTxAaHdJhiEQG3Mexn/UEaTy7qrf/sXtVedx1PPATl7H87jevv+ZFRvJDR4Zgj63hLxwxKqgk2xC1YR7uBaqiTfBBuhdAn/3PNvpbLkSCB1Yn+IY54MuNewzyz6TP7MwOOMFzAjgvKx+GolDdvRs4dJpyPj8hZOJprEDLrcswUYcHWWJTodFCrUuqcY6MU/DqyLC4JdAAqLLQ4QaiO0RU9fk/f7SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JBTskWyYLGU1QjmJeXzrq65cBba45yjXaUdybkLUMGI=;
 b=olc5UwGmvQ5si/d5bpAwZX0y+G/nke+2A9YzNX9gTrMIcZPS/GeW4/zyyipmC802HbYLWexa7ESNLn1/r4LgQAEhVzMGKbPOm7l4win7fJwjp4iMFxAEAnZZViiiwcFgu1ZNUQS1LMGNAqAyohgsFH0bbcFF3M/ngYcEt+k4lotV2oo91GHgnfZ9K7ciHisqDk5ImzeVQ+HcJP8OTQgJMILV/qgrbjfjbckzQsCNj4BJ3kNJcmnUks1GfHlmHIrckxqPKLAhdbcCAv2L9RVo6sCMPG5Y7D52PSBfJoIcCuO9+Y7QaSqaeXsDhgRGCitseYF1dekWIzW1HJR30KTN/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JBTskWyYLGU1QjmJeXzrq65cBba45yjXaUdybkLUMGI=;
 b=mqbtYegA2QieaLvT24ruf6q2syJgSsFjXXIjCJSPiVROUJrl9FcGuh+iuTja8ZhBZivS6jy4ZCANZuczZRLSohF5R5SC+DPzlJj9F3oX653yxnFuu2WSVzGjCBOpiM6zukw99KO/bNypBHBiimNaFysPAMMnWjJNTxiEnFbE2j0=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by CH2PR04MB6792.namprd04.prod.outlook.com (2603:10b6:610:93::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 07:33:53 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%6]) with mapi id 15.20.8901.018; Thu, 17 Jul 2025
 07:33:53 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Yi Zhang <yi.zhang@redhat.com>, Bart Van Assche <bvanassche@acm.org>,
	Gulam Mohamed <gulam.mohamed@oracle.com>, Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH blktests v2] loop/010, common/rc: drain udev events after
 test
Thread-Topic: [PATCH blktests v2] loop/010, common/rc: drain udev events after
 test
Thread-Index: AQHb9UFul3T6ICWto0eEFLX2LkpSdrQ178YA
Date: Thu, 17 Jul 2025 07:33:53 +0000
Message-ID: <7znwjjhnudohmteb4c63y5o3crue3oalkb6xpcynijdmmiqnaw@ocvypdmh3upj>
References: <20250715043202.28788-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20250715043202.28788-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|CH2PR04MB6792:EE_
x-ms-office365-filtering-correlation-id: 83bb6b4a-cb8b-43ae-d2a5-08ddc50447f2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mdUVqD/pA1Z4veXF4K1y5u9LsIrvkuTuPdVojruGF9WNuNed35iUGxk8ZhKm?=
 =?us-ascii?Q?vGHCzeGobSoKD6PS5o8TGI73Nd9I/T4Pda3f1EKU09FMbb/7b1kRX6aUz8UW?=
 =?us-ascii?Q?BOCgeKRhPgzof+93OWnFpBI5i4ijkmOEa3gyj5b16mTHsK8Il06GmyrNEbFo?=
 =?us-ascii?Q?GXnbf/iPKJAEvW8IsFQlYfVqskNq2cCNy6nUsiBV9mxfAV5hB0y4wB252yW/?=
 =?us-ascii?Q?0OgKvDf/uFx7E1LPGFUY0DI7bXnLABA9Ood2e1QQudYmzpldh7P0NDkNt73F?=
 =?us-ascii?Q?XiE3FUwgR8qXjugSbfP/QnHeoZtoyEu2Xsmp4TK4yDwrR1sSE4mpspZ305Yb?=
 =?us-ascii?Q?561bpnGF3w1c20HC6GAW9dv9VjrVTX1uWfb3pulHZPVS1CcWpFYOHeazPpBf?=
 =?us-ascii?Q?PKPF92xllHkvAq/X9miKZ2ekSIzGhzIu5EZkvnEhxAnxtXjv560gsFV3dIUq?=
 =?us-ascii?Q?giN/Ju8Kb1Qh0eSqFYxcx0vvjgm8wcYqdZMzchPB8hW6cN8Jl/KhQunEyePp?=
 =?us-ascii?Q?uZqQVPF78YTQqmvUqgBafrl1/SKurWEMFYx/f5kR9Rvm/kJ2naV0gP0I7xj6?=
 =?us-ascii?Q?4UebSyM+dbsfnMovrDCcbaeL0BYQWo8MNG3oimVj1ZuG5/TPuiGJBF6G4H9+?=
 =?us-ascii?Q?ZRuC6hXr3Vgkquyv0/BjK8ZuYFI2C40meqXE8EIkCV9xyAY+2Vaep0e5OIur?=
 =?us-ascii?Q?66xM8sx1JJi0hfCWLQVYjER4Ol26dGDH6UmjKPa+MlRAiJpWxMJue0p1tNzg?=
 =?us-ascii?Q?Pipmz6doMqvG/Bul/glLZpPNPEx2LGYPQQOvuZ10eQKVJ0kuXE2qkF162emA?=
 =?us-ascii?Q?6iwVhJsgyEgD+JiKlTg9Rtw+CQBZcN7ku+BqWIX341BFTxjYQ3WAi7a5BYik?=
 =?us-ascii?Q?sT2qqR9BKc7fqyFJSiY9NbXq8dZB5Kvl/OEGKkZNiTIneJ1l5GhBfHqh0ZIl?=
 =?us-ascii?Q?vFNpm55OC2CPls11V2UlDaeOF6bZbfD1/4M/0qVXD8xs9NIYQXpboWBa+v8o?=
 =?us-ascii?Q?W3mos9RN9cdHxiaaTaw12Z+4VQF85/+zcwncne6wRiE8Jez4aAe8StorLxbD?=
 =?us-ascii?Q?3JXF0wm9Ow5geLABjGn5cC/vF0kOpJLEEoYa6zlrJzjjztXTHw6gVR7QqwNb?=
 =?us-ascii?Q?Y8R6pfEAZ/a2jQxPXucRiW70pKmFDn59+JYbhbKiP11txNE8f/fQEkiZXjTc?=
 =?us-ascii?Q?EfNjiapcdowltavyTS1ZBFu3YZaaG2LaNfq7rljEwKcrv4qsNGt610J0Ax9U?=
 =?us-ascii?Q?LWAa07akh96KzyOiLPmSfKgSZ1v4dCI1D8eJR8f6nHXtj8TZ/H/W5auDnCCj?=
 =?us-ascii?Q?z0OKkr2lJwRSJkDZZvSR84vR/5dBUdjs2LnRLrvkBH7G02bEnLQgeyBM0tUw?=
 =?us-ascii?Q?dnNs6RSI+IDBshxBfKvpjJFWQcW+CMcsPd9Paxn06B+hRixHE9loaEJsUaB0?=
 =?us-ascii?Q?YJ/AYd0pinBMhyI0weaCRaC+urtjraH42wsTG1atq+FSUnjYK+BvgehharHD?=
 =?us-ascii?Q?7feW542LCpZFsOE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NIQtpMYcyqN2zW+ZsgHLUgTq8mYDTMIjfaOvivSyU375kETxPVf9ejSRB/S9?=
 =?us-ascii?Q?e2+AZZbGqO7HbVKNzuwh4129rPl13JHh+OmqfZLjpyH3FDZsOO1z1HY/IglM?=
 =?us-ascii?Q?EtRxVXvDVKzwdwPrp/+O0aeflz2EUDxT9wxdJVZW5NfmJxsE0PJAiN9CctjC?=
 =?us-ascii?Q?Ht55ns4L85ntFYtJdS/sRhvyxtx+5NdLwx+z5xvMqp+/v01Yt1lB4wwfg25r?=
 =?us-ascii?Q?Ss+F9XO0VTgGkcwOW0vC5B3owjvcjhF7U992F0iOJoydScTj66n5XxkTj+mT?=
 =?us-ascii?Q?jUExW2fYUzcxxelumWUoYPAvF0UILyxSjQq7K0tnMbMesB2I5lwcxLkAbRjW?=
 =?us-ascii?Q?0EEAGXPSxzD2FBPKDPxVGWqDqcXtk21GrkFfT5SiswyipAjnj+GjQqEWn1C7?=
 =?us-ascii?Q?JDx1IWDUBgBdAFR4qZvK5Y1QAEeo15FTZcYXwhIUjeWnqxrCpQH4EJWQ7XcR?=
 =?us-ascii?Q?K1s5hP7B6ZWB55jS6hw3Da9AjDu9ZmPq/vQ6LQH/npwVNN2qvseeLCdfpGWa?=
 =?us-ascii?Q?tX6vpiTyEujwrbpfIIahm1bDNHzfwZvTylbM6uS+TzcYiBa0qZt1O07vXs4n?=
 =?us-ascii?Q?mlG+VVdiWPDD/apBevHAK5jbPpcbpF/iary30LblnkTB3mjM/Cbgz3cS579c?=
 =?us-ascii?Q?BdcyKgnNa3kjfVqM1N2c+KDjPQwGCaqfNEvWrckgK/XM4y1MHwbI1Thx/w4x?=
 =?us-ascii?Q?9Sm/QZ6J3hMcsbyzviRxYMA6XBbQaNCdI5zGUYGwYZ8LfB3ib6yVtNYASdYN?=
 =?us-ascii?Q?DkrzKXyzq/e94tjUtnv5flMDykuzZdnpCOVu2Dz0l6G/Py4fHvYmgIlevYMH?=
 =?us-ascii?Q?u1wy3ezY5O7Xs1O9GDTJxdpOiB87+lCMB8iP5gogd877eA6Pds5Cepekoh5B?=
 =?us-ascii?Q?zTZODZ1pb2uWGFjmTy2EKR81w/uDatfu2PrsWRk0ReyVeTZJrmenE2i1tJud?=
 =?us-ascii?Q?nzkjfHWiybRiwa6kfbRXlISgK0eydPYalfS+zdJWlCYisc5Z5Wt8EqPkqS5f?=
 =?us-ascii?Q?wzLO4BijgsPS2vOZf9L1KiQQmD+BpihVInfOVQL8znUkmW5ma01zDDWKQ71x?=
 =?us-ascii?Q?H0nuSdZ+X2ZCj1zXhbf9qKOkPcNxtXZzbwlvjiO7atWrpPygyhQnAJUF+HwE?=
 =?us-ascii?Q?gXRdHJuiXN5NaK/Lk3/E8jwP/fjKh3EW9TYXwRHDYDV6SMvcRs9vA3C1XAPt?=
 =?us-ascii?Q?6jdyfMAZtkJQ9DY0DBmOeeZVSix9tk/73OnOU5BPEr9S0diRF9PA7Dn/RtBh?=
 =?us-ascii?Q?msEAb37833O85qNMnVsGOr5vdYPtG6OfOMjw/uNvG5Sj6LNWLBiA2Q1uIB3T?=
 =?us-ascii?Q?AwAe2xpRz2dTlCq9SpgwQ9PZRbF6GSQ3qAn9Y3OuAFGookDHVjy5lHahIZku?=
 =?us-ascii?Q?Y3M6ZGLEemaGvl1MYYBAOmJcFhMKNXEX/WFrsN97G4GICn+wGGR42IMmT/ow?=
 =?us-ascii?Q?t4mrnBdrtltIeP6clT/37idKHf/l41ZIXnVA6pd9+G+DYwFWJyXtLHJW8CgX?=
 =?us-ascii?Q?Q+V/OwPXNLfiVZQCKY8tw5djVNkyngE+BqgjjLCfl4R4GD/w5AidzDM/61tj?=
 =?us-ascii?Q?aK7QBF27Tx8FHGi/v2Y0I/FrQu102uWcjTiyxpLTrFixZk4ntn6nS89JN9Ae?=
 =?us-ascii?Q?Mw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <563E95BCC8412B41BC7742A750DF42C4@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	b6m2e0F82Ao/R/b5hxfRr1ZdufTE+siDmGqE047Bza0fv+nESstmxlJ8GlaaStCS0RCfJgnowBYBb0F5j96mkZ0W97m43cEFJUnxcUl6/oVN7QRR3UGe1Tz4+L8kke8CfsyVpDoC2Pyv45g9vzS0ItiJCjfeeo8iGPEvy4jrGMg8h4f/LMe3rPdBBf8I2EYQb4doybkaqqXans9SLPwWSdOqABxzUZwvl+IbCIVyXQUQnEf5up+QnXs7kZBXWSbz2TBJV0qUJ9J3REvO9JZezXGOPd3hKnd7PY/OMz7obj1XPEq0Zf4fDuncsWRc5ZaBv+DwB2bARiDH96yfzRI6FZT1aiH07jrf24EWPnYghRtHtDSMXyGleKysdMvwBaNipOlf3Z2uUaR+e7vVHoyedjYqtF+l0yv8Bpwk8kucPSpjO70w7km/mnyL5DtsnfOZOonoQNMqJDXPaVnomkD9oPrlbaUcHnFTjH32WvIBne1x1/fS2udOttc+5tLbY/yMfZzIrfd+kGcHcz1bJtIKhUSUMZPvjc+1ccQKOHrTkYLOz/WouAX+cZDUwxl9x1Rr9DW/1hCoyV55cW617JReMlOnJ45hJws2hO72RaRv4gD8/nueaxRSD4pCrj+kXRVS
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83bb6b4a-cb8b-43ae-d2a5-08ddc50447f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jul 2025 07:33:53.3647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dymd/ON49W0ebxmrKpikM+L70NKb4WMn2oyoC/zgRGW5yZ61c1RjCT7M4/Q0Kug7mmDMeEyiOYDoaX0GNsJPWev1FjmaRWR62zSJkIQNnoo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR04MB6792

On Jul 15, 2025 / 13:32, Shin'ichiro Kawasaki wrote:
> The test case repeats creating and deleting a loop device. This
> generates many udev events and makes following test cases fail. To avoid
> the unexpected test case failures, drain the udev events. For that
> purpose, introduce the helper function _drain_udev_events(). When
> systemd-udevd service is running, restart it to discard the events
> quickly. When systemd-udevd service is not available, call
> "udevadm settle", which takes longer time to drain the events.
>=20
> Link: https://github.com/linux-blktests/blktests/issues/181
> Reported-by: Yi Zhang <yi.zhang@redhat.com>
> Suggested-by: Bart Van Assche <bvanassche@acm.org>
> Suggested-by: Daniel Wagner <dwagner@suse.de>
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

FYI, I have applied this patch with the comment improvement Bart suggested.
Thanks!=
