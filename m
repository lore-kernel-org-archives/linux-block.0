Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB3CF1EB5FA
	for <linux-block@vger.kernel.org>; Wed, 28 May 2025 04:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748405711; cv=fail; b=kXAUKB9GCrdrEDUha5HfqRwqnOIyDrgUGvFrVfhq5L/7Z4nYx+vZejq0TdSrRU6pL6C4x8FCWLUeihghcyu0BAeI+z5QgsEWhBm3w0+pqSDef5CAiKGTuwqDSqHUBcSdOWINEM+deAPBAtAe5pNqo9ablSquPkXUrKywYkkf4ro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748405711; c=relaxed/simple;
	bh=PfcvlQ+7zPGjA7tje3kOggsTunUH5bZRvR7RUEqwCS4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VmYLK4kA/sH4P3+uk0nijmjlo+Fd8BtkE+PEFW24KwfvhAV3qtMS0+XJNGFbyrCWGKefg2M+0yFhsaMDFuctsLgdh+tGYSxWhS7x7xLK+1I2vPgWhAH6/5dqt9BU5xnF/7IpjQAXE0f/2U8oFDVFNg7m2G0cXhwF9h8UHpbPbDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=OR/uSsMR; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Q78y0bpR; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OR/uSsMR";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Q78y0bpR"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1748405709; x=1779941709;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PfcvlQ+7zPGjA7tje3kOggsTunUH5bZRvR7RUEqwCS4=;
  b=OR/uSsMRvVEh5MIzx2rFa2Jg6bqm85si4agdJwHZB5Zwsp5XlYhBBMkE
   EnE6dpGEOrTdhQ41CNVqBJB8lMEcK5320ORuaXmmUxS1hapw/SzfDAXQS
   TTaSUzXH1SjqfKa4v0491gkbwNHTuGgWY/yDW89ACj+ysSJuMYV9edXU3
   bIwX+yJH8DlBbFd8q1Bkm7MRnwpSy9iHJwVn00ujM6BYzTDcNwlPFAnOk
   8JPvmcFfmL7UFF/QvRTVQrqTksEMs9E12rfLUFwWtSOV52w6ik5tP3z5h
   cKhN9RzoZ44lVZRMKfzRXoF9J7qlZndHFLK1xloI2Kq4wwb66DbsJmbvj
   Q==;
X-CSE-ConnectionGUID: ZrHolNN0R+CZmf5pHBb7Yw==
X-CSE-MsgGUID: fNkJ/fEjRTGI5w0F6Ql7AA==
X-IronPort-AV: E=Sophos;i="6.15,320,1739808000"; 
   d="scan'208";a="83317510"
Received: from mail-dm6nam12on2068.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([40.107.243.68])
  by ob1.hgst.iphmx.com with ESMTP; 28 May 2025 12:15:02 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vmg8lWs/hOp0ibIGS3TPp889gcuVUxw2cqrF8w+3QpsZoaVgkzniet8WMxbru9pgjXplJddPNDLSP+EU2Z8FtLJCxbJ7s4UDKq8QjF5u1+baTWobC5sEEvQVwRYnY8wcg6SBUx6mQYWOLe0y7S/NpOtOjS/dgO3c/HW16Jg5FRs50qT18HUDCB5N3OXYvCncINqS8qDBkrl9LuwuPD5OUcWuE0qioCgFoHBykGr2oO7pCSwZoPXmXOsk6dyzlLkLndI4eLsHphIinv+raI5qkNSLMgE2RDIpuN1psaJ33sIM2ua13xYjXhaTrZf62He3g97kvCrjlB49b6j1GD+6cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8I3qx+wpfrG1ne4h88XF2M59Jz1FHmuQxUI/KKFKeq8=;
 b=YObSxNgDG55iSDJ38O9GT/SXTB87JEc2vugh0YmhMn6PQ6lpjr9BSQVUmLJiYXQPmukizjcclejcZC6PP4kfKV+9qiHwnpspgj2WtA2gSWk0ofiBx3EsHxjq1jtbE7+kOi74nROsggIw+wCZvYAecQk/1ebZP5x0Dii9eSl8+3lqNjhtLus6pZwwpyjXk3Lj5CKny73z1fDLVO9E7Mv10d4Jzwb9Yu34KJ4eEYKJcAQp8djNwoB31dAIcJuATM1U7YRZv5iO1AqFsrtolbJp5XdCmBFes/Y8qQIqbIwamFIVMV7KTaqHSLuiFD+VFnJJxbmTjNu2sKFCNzNE/P2n3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8I3qx+wpfrG1ne4h88XF2M59Jz1FHmuQxUI/KKFKeq8=;
 b=Q78y0bpRPRhgHochAuDCZ5Skifa4M1+QYvKbPQ4xP2Nk4LBs0JcW3xzjzm/QLIwj/AZbOh4ik2HMye7T93FS0BvaDx/RicamxPhuKvaRVtnl9ImLJ+qExTiIx0g/7P6KuFGShxD8wKMZCs3QsMQZbZGQTkrUoZVCBBKtBTJqjU4=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SN4PR04MB8400.namprd04.prod.outlook.com (2603:10b6:806:203::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Wed, 28 May
 2025 04:15:01 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8769.025; Wed, 28 May 2025
 04:15:01 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Bart Van Assche <bvanassche@acm.org>
CC: Damien Le Moal <dlemoal@kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, hch <hch@lst.de>
Subject: Re: [PATCH blktests] zbd/013: Test stacked drivers and queue freezing
Thread-Topic: [PATCH blktests] zbd/013: Test stacked drivers and queue
 freezing
Thread-Index: AQHbzALLtqOQN1PdUE6hMcTwgzbaO7Pkl3UAgAIPjQCAAM8gAA==
Date: Wed, 28 May 2025 04:15:00 +0000
Message-ID: <fggaqqc5dxwbrvkps6d6yj34a6isbcsr7cxepg64bppinpk2w6@dkmleb5pncjt>
References: <20250523164956.883024-1-bvanassche@acm.org>
 <vuyvx3nkszifz3prglwbbyx7kekatzxktw2zhrpwsjnvl4zqus@3ouwvtkcekn6>
 <09211213-e9fc-4b59-8260-dd6f8e9d9561@acm.org>
In-Reply-To: <09211213-e9fc-4b59-8260-dd6f8e9d9561@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SN4PR04MB8400:EE_
x-ms-office365-filtering-correlation-id: 8f24f7df-6ac6-4b45-3640-08dd9d9e3721
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2c1VZyr6E078DH7qpvw+2xFlLhlxe+Nzre1GJ79PpkLhKdwEXswLOR+zCRCO?=
 =?us-ascii?Q?BUu7D79RzS9NjiSRU07rRZWWTlqvJToBoVmc9EiLe1/nzeRfA59STzrih5x3?=
 =?us-ascii?Q?cZCdL6ke4ggPr7KQwQDwsrKqmJcTdsVsITeOHJ66uyft3Rt9N2mCS3MDmNt4?=
 =?us-ascii?Q?hKrEU1BlHJZCm0aPBZmyUB82Y/5IUsaJQnYruGia2V8GjN1DZtaAhWjn9l5x?=
 =?us-ascii?Q?7gk4gM8yUTOVWTcei+PsRsuyWOi3/SBFVHZmAd2mXC2o8WNOZL2c01D2Ql00?=
 =?us-ascii?Q?nyIj2kecmmMfBlvAGZsIppJOXTCOM7tUwGKiWuDbCJXNAcGsybKIWhZLX5ys?=
 =?us-ascii?Q?IWx2VBCXXqs3/Jem3fSSymSKIrn6c+nS9VTK8d+jqRFZOEL3VkCiF3iqJFJC?=
 =?us-ascii?Q?UTLVcmyhmTtu9snMSr8YK8Vz6AGAL1wSALpwvq/Z3kQHNgkn0HuCYk5FFhNS?=
 =?us-ascii?Q?ftHZz4p8dv3OUWCj7vFK8byt4ujpuQ7AyBOlhsaMeW5bs9cuxqn/XZ4tSU3T?=
 =?us-ascii?Q?WvRYXRWMZw7ZNbUhPLxZITjIdLjVSm9B6TtR1RyNHiPXUARwcETWt2eoKUZ7?=
 =?us-ascii?Q?gkR30SXEFIhR7Nz0h2cz1UhtxlW03JWkMx9zJt75HWq9H+6YsXqgu2p8CY7S?=
 =?us-ascii?Q?rCSxbaJGZfYHfCmx8u1rT5p3V4nyAmshLLwXtHrPzbxixulISjwJmjBGFkGT?=
 =?us-ascii?Q?7gCtsaoqIVpIT2dMlaOIuWu34S2nRVukHAhBYD8C9uZCrkQTE0EMcSdW47D5?=
 =?us-ascii?Q?LvS+Jw6H532QCFvaE4Ch7vDBvXZnP6DWLHVrLXsc509qRUMkCFT5rTcwcBEv?=
 =?us-ascii?Q?+7OtpM8Yqm5pw3RCOsxr8szHeS/lM9tNRpM8EY8lJ8ZP21wGbu7jJdHI/Tvd?=
 =?us-ascii?Q?fSV6xMJ7rgMxOKmq7g+cRsnCbqBFWmLSMlhr8Mr+gFFMIQ8WW6943AKQyvC/?=
 =?us-ascii?Q?jdcrCfRoQUllHn+sWYaT0KtScM400bm4D67kx4uNKZKYSLSOXYv+2Q4wdx4J?=
 =?us-ascii?Q?0thEBfchuApYGczaql+eEAwjov9enNmWM/W3GOfn1I+5jVdzt+ecNnntRxSA?=
 =?us-ascii?Q?H3SUiW/PI7ATjCW7mPMiJfKX6q51fmSuZQKBHCqwAZbqTyoq/aCx6utOAQyZ?=
 =?us-ascii?Q?yQNxgvWDe0130yvR1hVcT8X5PuHTqyjCsZAnl57bSRaE3Tg4gm9pm87LqgXd?=
 =?us-ascii?Q?8oGSSEkYR22ECpPXLeW9H+V9kIKiuUcL5zdPOBSb8qL3LY7f+uDERV2KQxdu?=
 =?us-ascii?Q?+55BeltIK+2+U6VeIYLi1de0eqH2xjF3oWhPjeMm4n9wKkcuadMuNHPmYJ5D?=
 =?us-ascii?Q?BwNxfGw3JX2cbEwj1Hlh5D9IxevfEvniZ3XWQtYTELjscNdYZIH2H3zsFdnp?=
 =?us-ascii?Q?yDCcdidjq+Zlf/zOJP2NJUOiQOFu6IGSRHwACjNTfr2NDrzQK133tfEopaQg?=
 =?us-ascii?Q?abgooMZc9KvqWdbMWoregTqjWEKN7babNVSLaWys7JBOxIJVnPFxTzgeUxTI?=
 =?us-ascii?Q?VdDxYZEt89azSkA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gmreOII+s5UPF2fQUh5UhLfGTVeyFH0FQrWslMF86RN28rhWem9GSAa5mUaf?=
 =?us-ascii?Q?shwvqy3Iq3SEEemEs69g/8bMp5mYWbpgP5dvvCQ44YSAaWJKMcfGb9jZ15UK?=
 =?us-ascii?Q?muPoo76U6IWITyiqrF/hdog7PRrn02FRahg7zWIbOPKH9F9PJTK8G5nYhOaM?=
 =?us-ascii?Q?k1fN4MMN1sXIu9Q4wQXn77sqVlhPeL3UgABjU0wCcf82ffQikoJTBnat7/PB?=
 =?us-ascii?Q?pSwG4Pp76oylssACGnUbLA/LnYvDV5QEH7jyKNNYvmPJqRtbjHASRKBsCs+a?=
 =?us-ascii?Q?5SwNnqyN7gDX7c8TXJxWOwVgIjnSPRchDiFbNssQGT996exyOgHnflARCkPG?=
 =?us-ascii?Q?Frf64MC6QZXkVVnrsA6tSiTEjx8N3h1TSLXpVF46OFPo5blP/VnPauREPBbz?=
 =?us-ascii?Q?PDc6CcBZXkd6bJBUjdqPebW4fq6QVtBIgNqxiAkS4Rk1YSmQFpZUrFokcg10?=
 =?us-ascii?Q?nNJNLQRAlLZVhT6ohrwDAaAFhWoxeiSxsRkt597DZmYrFcQd3uzxm2omchVj?=
 =?us-ascii?Q?xYcgAPjugo/WQ1tioJFChp6zjrYGnXi+/2oZSD49vQaV7lmpOYKBFKjJKB8Q?=
 =?us-ascii?Q?mIpPWMnF0BFpngw6qa7SEbdUwS7Y3FY/07mkMGqnnHe8QvS/S0xtgDVxRpe6?=
 =?us-ascii?Q?70XiJCXSTfDmIrurXDV8d64N0Gze10ogUVlaTNqdXPYiP16LZurs/A/U1/WD?=
 =?us-ascii?Q?RcE/WOpvOnF4/g9UYkxZ/7pJYRsQv1VpyKlxU55TvA+474S2X/Xts1rdpnUC?=
 =?us-ascii?Q?33n2OdJZbeXP7fkrh33BU2fO0bIbh1l2RPejgeR6Xc1XW99jPvuTTGTg8C59?=
 =?us-ascii?Q?GCsp+Kw4bcRkipgTqU5JgqzZ8pQAZjnwkFDv9jDWW9uCnlWejDy/Y1HJXnRW?=
 =?us-ascii?Q?5q9JchKkon7ghkznrYuMraKMO7CRfwwuCKxiORz3bD5IgX6lsEyVbsTWqAtK?=
 =?us-ascii?Q?9SMUXqlTHYof0D4igffmOWABFxrU7xrLzGA0rr72d27t4sJfTdwjoanAi3y4?=
 =?us-ascii?Q?+wxeYHbmYffenPkJk8nBKc+JjoiKBIr+RJPi803EQMmUcapk5tnaN2xRfYqz?=
 =?us-ascii?Q?yMaTATbfxgePMU25xAS30sP6Gsacb9E8BxJ520Sh5Tsqq5dXsMsZmfJRyz1U?=
 =?us-ascii?Q?zLdDV4XScEWIQPr0pgBxdvki/dbQSiAxPaaPFPwzoBG1Cgqu2hTjBSsFj/2w?=
 =?us-ascii?Q?XNEOl8Pcb1x8Ssi1pycaBWHlxOQ/L3o0WU/Ug4tMQDn1xiOekLppUcIhblOc?=
 =?us-ascii?Q?ANktsvDm63Wouml9PnNQP3MCZXWT0SmmPMMbx9iAlQaHu7CsLtLyJLTThZ3f?=
 =?us-ascii?Q?AFdRXB/MsVySLTnQInfw81EquVyY14oQ+XlNOBx6k0Wu6ZPDEX7lwpqvEdt+?=
 =?us-ascii?Q?iWmD/yybaF0sULUWS9ovliSR8XHvkL8zENBethJs51XpZ2D5r6AgbI8dzRXZ?=
 =?us-ascii?Q?Fng3oBknTO8nwyDzP8ni9GCTledt+MH3g5eJFoTLjSEPu78dvaN6jGywNzVT?=
 =?us-ascii?Q?svZWebM0huCqXpbDjZV4zOOsYgudeJkN4TH073MMMAxMw8F5lST+n2sDkxW0?=
 =?us-ascii?Q?aECghRMj/hTeheu1LRWTBza4lzwLgKNcB53TkRK8aSxrL6xfS/v+znmd2EJ5?=
 =?us-ascii?Q?yBFhRjsUEcmrKJGuDuMzra4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <78381F1F7F0D1848AF55ECEC808BFBA3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QbyDRxlI5m4lMq/agK+Gb4LteRH5uTp9URQe4NYp9Tf7aTg85POydBe/NSGDUGhuErrWp5MZmUSVR6Kvxqy9jWN90051CutZe6pU+m9ttFIe6mVKgSin+BV6udsU8YNMCwT9dS7uJMvY0cJ3Per3ZvuyLjuHFfUg2NCQw0PUwi6zJJFatIzFM+VKmf1XpWB49VN7w66/TQ9Ae7f9Ur+urxG5BXEe6TmEuoOZ5cNekWB0DL/B/rwBxwqE72qF8rBj+GKuflOodiDjc/QqXuQdespGHrcTvhGbz0kVsjeiO9viz5ZmgoJaHXQ0mRijV22kGrtmFNinNFb8IrxXLTFHA9h/OQGnRM71RvcgVx4LtSljX9eSZd/a3ZNxj60QM1UVAdC8Bx8KYvN8ISzXE4UaiD+jcV3uNYrfYeDqPZoHg9HG0rRkzjbw0GO4J+plzM2ex3935ZnC8//Id1/EeiRNMTDoHAOHxbLFsADG1As5Rix/NAs2aaB8rzl9OTPLzOJRcrStV0KBGhCqIZtKsYcsfvGVEabbXUqfIe+swlvM2Xk3kHVTnCZl4e1oRHTYavIcB4BamPkpdEEB5k5ViIYCU+qc53l0MeFJsDmY0AU2K/xmSDdDZ5HKNUe3s/fzoDsE
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f24f7df-6ac6-4b45-3640-08dd9d9e3721
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2025 04:15:01.1522
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PNbBPwy221XzWLo5kk6sLZYlTMYqp/in272txcNJG5c1rbqEzQenu+i73kvz760V23VJU2oDmSBld8+ZQdsCfXtQ3sTRvxcJedXRctYMjuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR04MB8400

On May 27, 2025 / 08:53, Bart Van Assche wrote:
> On 5/26/25 1:25 AM, Shinichiro Kawasaki wrote:
> > On May 23, 2025 / 09:49, Bart Van Assche wrote:
> > > [ ... ]
> > > +. common/null_blk
> >=20
> > Nit: this line can be removed since tests/zbd/rc sources common/null_bl=
k.
> >=20
> > > +requires() {
> > > +	_have_driver dm-crypt
> > > +	_have_fio
> > > +	_have_module null_blk
> >=20
> > Nit: the line above can be removed since group_requires() zbd/rc checks=
 it.
>=20
> I prefer to make such dependencies explicit. Relying on indirect
> dependencies is considered a bad practice in multiple coding style
> guides since it makes it almost impossible to remove dependencies
> from dependencies, e.g. removing "_have_module null_blk" from
> "zbd/rc".

I see, that makes sense.

>=20
> > > +test() {
> > > +	set -e
> >=20
> > Is this required? When I comment out this line and the "set +e" below,
> > still I was able to recreate the deadlock.
>=20
> I want the entire test to fail if a single command fails. Debugging
> shell scripts is much harder if a script continues after having
> encountered an unexpected error.

I see your intent. However, "set -e" and "set +e" does not work in the test
case. As the bash man page explains, even when commands fail, "set -e" does
not work under some conditions. One of the conditions is "if the command's
return value is being inverted with !". And the blktests "check" script cal=
ls
this test() function in the context of "inverted with !". To make the "set =
-e"
feature work, some changes are required in the "check" script to avoid the =
"!"
statements.

You may remember, once Hannes had requested this "set -e" or "set -o errexi=
t"
enablement [1]. I had tried to support it and faced a couple of obstacles. =
Also,
in LSF blktests session a few years ago, Omar noted that he did not enable
"set -e" with intention at the beginning of blktests bring up. Then I stop =
the
effort for it.

[1] https://github.com/linux-blktests/blktests/issues/89

Said that, "set -e" is a good practice in general. If it will help blktests
contributors including you, I would like to revisit this topic.

When I had tried to support "set -e", I faced were two obstacles:

1) There are certain amount of places which trigger sudden exit under "set =
-e"
   condition. To fix this, dirty code changes are required, and this code c=
hange
   will need rather large amount of effort.

2) When a test case exits by "set -e", it may not clean up the test environ=
ment.
   This may leave unexpected test conditions and affect following test case=
s.

Now I can think of two solutions respectively.

1) Apply "set -e" practice only for the limited test cases. The new test ca=
se
   zbd/013 will be the first one. With this approach, we can keep exisiting
   scripts as they are, and don't need to spend time to modify them.

2) Use ERR trap to detect if each test case exited by "set -e". If so, forc=
e
   stop the "check" script run to avoid influence to following test cases.

Based on these approach, I will cook trial patches for the check script.=
