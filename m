Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986A71BD9D1
	for <linux-block@vger.kernel.org>; Wed, 30 Oct 2024 18:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730314057; cv=fail; b=OD2EnjztrTsacJ26Jo30AVP9S2qJlLZ1yqM0gU+GVkuafGrZ+EX5lsf7vIrxzoLy1gec5V8m1Nv5LnXJEXXcIbAQ9Py9lQ6+QGXRFMEmL4mrXb96+3RbXxHhMt5WcJAIq7i5JVeuZOWf6IMTy6Uypt79knfnbluTO0PBqJ1MElg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730314057; c=relaxed/simple;
	bh=unAHLglHXgJ/Qe0/TWfPjlaHpVYXPfbef0dK3OymNEs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vt7AX86noOoCQxS5/dF7+zr6jE2wQXhTnMkhe7d768q4fCIpYeHxS96RealuUERo7TMeXJcdxHxMez0gObALWxcdW3hVZ0paOenPR/Dxcp2i/o7jhqhNp3C8hHdxajnJcM7wVZVru6RFy0163Ya0G/apxy7iFkMDPRuCFiMRpRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ouT1os6R; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=SiMNzGdi; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ouT1os6R";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="SiMNzGdi"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1730314055; x=1761850055;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=unAHLglHXgJ/Qe0/TWfPjlaHpVYXPfbef0dK3OymNEs=;
  b=ouT1os6Rx0X49nGjPEQyafM7Iq84uaKKa1aAtIFIXkddq3RgdkGeS6kw
   3/5ywf3+UamnCaswX0DCZb/QTz6eZ/BOi2nOdEBwiYG5jKZTqX628kU2U
   +HGPRkG0RMuz6VVuje4vXrxryOdwOJhwP+vbvaDelaQOuCLDN2ejyECXX
   Y4OOMSz8v4NKKemsT/6pXX3wepx6SjwKaV2AGC1beib+OdGgB95ei3h/9
   cInv3HC3Cm8ngqpFT8O1BnkC7oGUxWG7T+bbKlbH7Zchb0tn1SwwbB4Ig
   n3HGalKnVIwox4jqm0pgxedRYeJ4Gzj8OqyCuf8BNbxaepbvQfXZDNZ44
   g==;
X-CSE-ConnectionGUID: ZZQKPe4rR3WyVvP3Ly7zCQ==
X-CSE-MsgGUID: 8KdL8mWaRyu94ZHlS7ITiA==
X-IronPort-AV: E=Sophos;i="6.11,245,1725292800"; 
   d="scan'208";a="29658880"
Received: from mail-westusazlp17013074.outbound.protection.outlook.com (HELO SJ2PR03CU002.outbound.protection.outlook.com) ([40.93.1.74])
  by ob1.hgst.iphmx.com with ESMTP; 31 Oct 2024 02:47:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RgdQjpHUlimh+1y/MCx+FLE0GD9es5DGM2xlWTCXCRcOyLFqOyuE+amqI2dtGOpZp1b30WKj+p2er/9W9gIWOlCg8zSuN9DIQqtA0jz6ZIRbmspk72vfuy4X31ghIOt7UXlydxs/lzjvVPAzB7uTSKSFSjExiKkm1d/ORmPNxaRMziwfE4SNZM7LVqWOKPiV1LIYFf5nAc6EmqAKbrAb9kyGFrQlwODoyPfqUiOrXrnNxlOFA6ORH3rGpshG0vabdhptQvfbr0ksSYPw/VKX8yjIUi6Q7l+EB0HFmgIiHkYW+hSMEz1L9muOo/zqE+lGZSCKyZjQdYH7gsbA9kE9MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unAHLglHXgJ/Qe0/TWfPjlaHpVYXPfbef0dK3OymNEs=;
 b=RDUHrIi0yPxT8632ONRgAs87Y0dtp5H6xOd1tmrPP4Ldn14uwfzHIWlAdzCZN+dQQRb6YFgplJUOsfnprC4b67gzs6M0xqkkY9ouHkXzwZFzf4Mx+EQPJiS9JlRTCBYbcRr9bFisB87c4YEUHt8OqDEtRJ9mWxFKvlnCwkXuA+4OdXR6mAqB6+it76SHLS/+UmVpkZZD5WM2wOBbA+zl/g2K9bX5koaHHx5sCF43J4SmraGfoh1wW/4YqRcUuW12v/8IOy/CMJ4I3G4Lc+mHgrEV1ynHpSVh6DXszhdW1Qt85i7eoSp7DpN20SRAtD2E6ZPNRSe+n0MyWQd7XCndQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unAHLglHXgJ/Qe0/TWfPjlaHpVYXPfbef0dK3OymNEs=;
 b=SiMNzGdi9YplFT6goAZh4suZGlSZsdl0lGi92BA6Hhg3ZpHR+oZW9CI20MCXWTDUm9qe71MC6ykJWJgdT7wf/YdFjtfTm+5SgU6SFd1CIWKDpbhdsX9/jFJvEnC8V7ZYhvWixu7RQuPOG0r06XI/DppXs/O8pNxQc9gn/a5wYUU=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BY5PR04MB6900.namprd04.prod.outlook.com (2603:10b6:a03:229::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Wed, 30 Oct
 2024 18:47:26 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8093.027; Wed, 30 Oct 2024
 18:47:26 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: Chaitanya Kulkarni <kch@nvidia.com>, Kundan Kumar
	<kundan.kumar@samsung.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>
Subject: Re: drop some broken zone append support code
Thread-Topic: drop some broken zone append support code
Thread-Index: AQHbKotD7rvQuXXiMEG0URcxXJRLmbKfozyA
Date: Wed, 30 Oct 2024 18:47:26 +0000
Message-ID: <8b043769-d733-418b-a418-f558d0a21c2a@wdc.com>
References: <20241030051859.280923-1-hch@lst.de>
In-Reply-To: <20241030051859.280923-1-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BY5PR04MB6900:EE_
x-ms-office365-filtering-correlation-id: d8bbc504-1db6-4779-ee64-08dcf9134c9e
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?STF0Y3l1aWhvTEJVQjNuQkRvcHFJc2h3U2VzUXdCSG5kZlc2cTE3TC9qYjUy?=
 =?utf-8?B?VG5BS3FDZGRsbHNaUHl6TnlOMTl1elJBRXhsT0ZuTWF3WFE5aEhYYVJpQ3RB?=
 =?utf-8?B?dkpoWW9RTUVxNUxpNzNKU3V0TmJLZWQyQ2ZHbjhFNHV4T1RSUkNkTVJXemJI?=
 =?utf-8?B?ZWFHTFZ4WkoxNTJEQkY3QmZDc0lMbWhQakxPSzhvMWVvTlF1UE9oRkF6cUhH?=
 =?utf-8?B?WTd1YjU1MXlabTlBeHliVGZodEE0TFVXaEZpamhRRUxkRzRmWW5uaDB1WWtt?=
 =?utf-8?B?ZnRBSVFoUnREaEtvSGdUQTVCeU1qbjNNWUVzWUlRVElpVE9aM3BOOVpmV1g0?=
 =?utf-8?B?ZHZSalJ5dVI2ek1kYkVnemVRSUxHTDVJY0graFdMazBWZFgxTVVlaUVRRVVl?=
 =?utf-8?B?bHg3NXBaMzcvTksxaytYYkh1UjJMaWJQWkNFNW5rZkRKQmoxRzVwS1ZwVG0x?=
 =?utf-8?B?eFJNRisweTBCKytwZ2lQbDZKa1MvZ0wvM3R1Y0lNWU5vZ3pUb1VwSzd5bVlS?=
 =?utf-8?B?NGJ5SXFjYTkwaHVEV2tGVVhwRmhyVVArdU9EYy9pOHlBYU8xNDk0cHV3M1dl?=
 =?utf-8?B?V0E4N1pFNkJhaTIxMkNzYllPclBwTEFFMytBT0RpWEJHY1JzcVRFRnNxMTho?=
 =?utf-8?B?b0FueXJMeDY3QjBTL2l1UUgxTzk2TElYL1p3QXlUOXFZN01XTE10amJhR2JS?=
 =?utf-8?B?Nit4cjdpaTg5SW9wWUZraXZ0MXlDZHMveTF6WDUwLzNLaTl4VEtBZWh0NDRC?=
 =?utf-8?B?b244cGhrdnVUcGZCaDc4M3FMc3E1aFBndm45c0F0MElNdzZORkpnWVAvcWUr?=
 =?utf-8?B?cEk4T2pVWnpZSWZEVTBnRjIwYmlWeVpmb1Z5YUVLeVIvdnd3U0I5WFlFcHhs?=
 =?utf-8?B?M3JYTlYzdHJ5Y1lXb2xEVGxTNVBvYXpoYTZZckl4RUlaeXZ1M0tpbmd4bGdE?=
 =?utf-8?B?ZyswWE56S3FaZFJJbmx5Q1VzcjRYdlFwU0RmTWNLU3ZGK1VIMXJRSm9ORlJa?=
 =?utf-8?B?T0w3T2tZV0FMTVVmMEZzT1ZPYkJIakw3dWZEN0lCZmhKcXVjU0hrMlJwL3hD?=
 =?utf-8?B?b0FKSEJWeEpQajhCOTZ5MUQrWXpFeTVrVW43OSt2SnQ3VXV6RVIrUDlKcC9K?=
 =?utf-8?B?djNBM0RiWWFBdU5iY0hyS2lrSFJuUFpqbHhGR0hERU1EaStvWW1ZL3NGZ0R0?=
 =?utf-8?B?U1VNYTNHUThnL3ZXdjVGWk1JTU1pTkpCd2JtY1VYZFVsc3Q3MTcyYnZMcnVh?=
 =?utf-8?B?bVZ0emg1SVpoS3M1VFVsU3RIdHMvK0YzZHVubnFYVWdOZjlWeW1NekMyc01I?=
 =?utf-8?B?SmF4eVJRM0pwSWNzN0hkNXJYd1ZzTWl1anZoRmRHZFloUzlja1NPVGIyc2RB?=
 =?utf-8?B?akMreEhjeCtEbzM5ck8zRmRrTi9WTWtWMnFLK2hvTzUvZENoTlJUNk9jUU8v?=
 =?utf-8?B?NlZJcVpwdmR4RTNJMFhkZjNIV0FZN3NXdVl0ZlJPQlcvMU1QU3BLU1VzczRS?=
 =?utf-8?B?c3J0bWo4UG90SHllMjBzTWJ3c1c3RW1DeWVTc2gzeS9NK0Q5ajYra0FOdmti?=
 =?utf-8?B?eUlicFpLd0t5NXVCb3c1REtuYTRad0s4VEQzN1FyUjFwZEt4Ui8xclh4R0ty?=
 =?utf-8?B?cy9WalNCZUc4cXNkSzVvdTd4a2g2YlNTNXAwL2xLcThWY0lYQ3p0NTVINVVy?=
 =?utf-8?B?aldFYlpNVXlNdFJ1SnMwOWZITXFJUXFaYlFtZ0ppa1VUMWE4b3E1eE80UTQv?=
 =?utf-8?B?OWRsK0NBTUtzNzFRaitzdllFMGNCRnlyc2N0Q3p0Y1BSN0VtM2xkT1NDM1Nx?=
 =?utf-8?Q?AR5hBd50t37bJDLuXBpsqYqq2ZqgGQuh1snyU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cko3Y1VPVGFNcTkwUU5DeldmQTh6OVRKa0xMUlBySGszYjYxVHFHdnorSzJY?=
 =?utf-8?B?ZEQ4NWI2V1QwalRUd2xtQXgxZnlleVJGR2VVbVB6SU9reG9MbldlL2hUUUhF?=
 =?utf-8?B?QTR2dlNabk1WRnU1cjFTOVJiUldhUjlOK0hzV2Z1a0RMWWhSNS83VWNzMmJj?=
 =?utf-8?B?czYxNW4wd3lkZXFTeUM5VG15TUgwMzkwaThEbTNXby9XVjMza1lGRHZqaldz?=
 =?utf-8?B?OFVNcERRWmxndDVXS2FoSEROZE1mcmNJUFg2WFlvNENhTHFqUGNpSXZYOXNS?=
 =?utf-8?B?RGNOcWhCZ0d2Z0gyMld2RG4yWWhmelFCcmhBbEcraEdGUWFhZEZjNDd6N2Zr?=
 =?utf-8?B?aWtla1drcEVveEJ1KzdqWnlyWE84djRQRnN6MG9lUElQRnVPQ1RRL1ZGT3ox?=
 =?utf-8?B?NXBtRzB0eFpZa2ROOVA5WFE3ditPOFJrdkxiMDdIOXI5dSs3WkEzK0gxTU5J?=
 =?utf-8?B?R1M0U2pnNlJBRENTNTdsaEFyVkMxTVdNK0RYekNtUko3SHZMdXVpN1pPMVdF?=
 =?utf-8?B?S0NIT1BjRVpac0Zpck9FR2s4OTlxVkdTeWhMdys3Qk1nNUp1S0pVQkFpTHJE?=
 =?utf-8?B?ZUJCUHdiM25BdUlhdStTMktxYStPdEg4Zjd5cjlsK2pnekhFazFsNDhzdlhv?=
 =?utf-8?B?VVZIVWliVFpTdDFkU252ajNFM2ozVTAyeU5qTUkzYit0bFR6d3BoOGFKeS9F?=
 =?utf-8?B?YUtYUmEzSXB0WmFqSDZhNVIxOVFMZDk2eEFvRittcHE5Ty91QnBid3BKWFRy?=
 =?utf-8?B?N3VMU2oxSmVUa1FMUkpMT2lGZ1NmbXltY2EvaW9VNDFtSVY2MThYc21zZzVV?=
 =?utf-8?B?UnFwWHlIWG5xU0NPY3ltSDN0QjJSOVBxa3RTZHcxcFdveFVZU3cyeWRXQnE0?=
 =?utf-8?B?MDFZOWVuRWZPellzcVRwcXM0a0dRZENsV2ZuU2pHaGd4dXNIa284clVLOS9T?=
 =?utf-8?B?TXRFMFZ4cy9zN0o0bDA0L1JTak4yU0V2R2lGZXZCejdmRmZHaHE4YW1JZDZ3?=
 =?utf-8?B?R3FNUGdCemgvTnZ0TTFaVmJDeFBpOHZ5WTB1WjM5cUc2UW5ZWVZuaW83UTFx?=
 =?utf-8?B?YjVnbllPd1JsQTlWL211a3c1UzVDdjdCT0FtbkpGaTUxTEhtNEg0UHZITi8z?=
 =?utf-8?B?enZOV2ZMaXNPUUdqQU13d1J0eFhmYUhRbHdGOTNEeVpyOU16NFovY0RmcXJE?=
 =?utf-8?B?V0h1bUV3TDlFQThFdjVIVG5WTjA1Y0pLUEdoSXB5dE9VOUFFMG9XZU5xTHZa?=
 =?utf-8?B?Qk9SM2YzOUtqQW9mVFB4YURpTHNjOFhMVVJCUjVNS1gzcUtQMnozY1A0bzBy?=
 =?utf-8?B?YUNNTnpKMkxjWE5pR3NQcE9SUU9GazUxNW9POXlEaDU5dHZjWThyLzNNb0lB?=
 =?utf-8?B?c01GL1ZBd0J0WkdrNGNWV2R5L0kzWnNDeHhmQm9TWXVBNFZIQTdsc1BxVDVo?=
 =?utf-8?B?V2J3OFZlaVFsNDJMTWhhMGxhcklIcnhVTmhOZDBmZXdYNkY1QjJTNkQ1R25y?=
 =?utf-8?B?ZDNYdExrWDkrbnRjSk0rQnFVeEJSY3BUWStuSWV5NGtaRU54Rk1RNktYeGVS?=
 =?utf-8?B?WTlKNG53Y1hyR1RlMUtGRitpUVk1VldmdkU1blNvZ09jbWtaSi94VHVYd1lK?=
 =?utf-8?B?NkR0WTEwZ0kwc0VpYm5uNy9uWWN3YU1Ra3RFUWNsVitUV096SHNIQ2tia0la?=
 =?utf-8?B?RXkwVERlWkZjWDF3TzA5UEtZQnNnN1p1aktIcDN3b1c3TTB3VHcwY0s4QlZB?=
 =?utf-8?B?aUxrUzlHQTRtUURQUitrbzBBbEVsdnlCSXJzQm1hdDNyQm9CakdzQXM1elVo?=
 =?utf-8?B?TTMzdGFDK3lNMG5icC9ZaUZEYVEwZlBEbTc0dTRmL2wwWVZQYnZ6K0JSemlP?=
 =?utf-8?B?QmdwUnlyNGdFY013V2N2OE5YQWZRRzVnQVJQN3kwaFVOOFVvMG41SDdCNUdt?=
 =?utf-8?B?eER3dkN0Z1NFcUpVdXNrRlp6TG84S2dOb3V6M1Q3SkJCclNCZVhYcGUwRTla?=
 =?utf-8?B?LzFwOWRPTVBBVFY4VGwzYUVGNW52NmJoZmxKZEEyMm1uc0IvK3cyZTFiRThJ?=
 =?utf-8?B?OFRVM0JRYXZsSVVVbTJnRDdsODFYa3Bid3AwUkt2K2oxUHNYUmEvdk50dDJW?=
 =?utf-8?B?SW9sOUsrdS8xa3MwckZRYkNkS01OQzE4TTNJVHlaNStaSVAzSnN5QkNGUkVT?=
 =?utf-8?B?T3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B6490B90FA9C446932C8AD7E75DBAF3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8xi2sgzeBQPOxI4/qPxpBl4Dqmvp8FG3yXQrIZ/ZJ9gvXeFTZUjotiD1DjS/Is0SFE2d5CBPNf6syt4ZvrphDl8+8SruCGUKbLbJIBnDPdei3hQUGX4SNjHuecbxq9Ww1+RZH/5rcyHjB3XqX7QxTbukdJzFnuxsfjqkFaaGrtG2IZKOpViySN5tGuIUnMHzEFxqsDRwav3k1rBa+gBzt1JcyJLbApJmOd+w+Ms/wNmhAf2xrmOdOglM/b+CAnXvLVE644FyxgG1VJ2k1g7xWd7EaPYyqC/o+539x4APXFmVEmWPhmbwdfhJ3Ge3OEof3XUyRGXbxb2Ns7/9KqasMPDT7stmxcwLtN1K64BVk+1jvrInG7JPp/v6boTy+n1whqzLROpeaKTrRAFpMz6n1J5OxUtxC4p6cl1WJWXkqZJfZwZoXJReIyTNL+h8XEOtWanJX2JKWYLGEhMFOIZzW8ZRAK+Jlx6hM57jXqfqaN53g1L1Lk0cYZTmFaUJ9iL3qwY52Evd25AkdjUe9lvkkA5FELJY8iD9iKWvVRKzr7X3BcnUIgqKg164GeAKX8Sld3ukDMYWTdM00te3c9zhragWKf2GTYzUxZl7frEJxSDlDi3GBqxDg16IFL0biQ68
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8bbc504-1db6-4779-ee64-08dcf9134c9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2024 18:47:26.4793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7OP8sImsVhcb74qZLnMEV5kScqYuLsH7LOzACprGywXwn8XGeTNh7cHmSWPcCIE/h0IzgleefjF8uWeBZ7Z547nF4Nwh/nADFdbtb7X0Wyc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6900

T24gMzAuMTAuMjQgMDY6MTksIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBIaSBKZW5zLA0K
PiANCj4gd2hlbiBwb3J0aW5nIG15IHpvbmVkIFhGUyBjb2RlIEkgcmFuIGludG8gYSByZWdyZXNz
aW9uIGluDQo+IF9fYmlvX2lvdl9pdGVyX2dldF9wYWdlcyA2LjEyLCB3aGljaCBpc24ndCBhbGwg
dGhhdCBzdXJwcmlzaW5nIGdpdmVuIHRoYXQNCj4gdGhpcyBwYXRoIGlzbid0IHVzZWQgdXBzdHJl
YW0uICBBZnRlciBzcGVuZGluZyBzb21lIHRpbWUgdHJ5aW5nIHRvIGZpeCBpdA0KPiBJIGdhdmUg
dXAgYW5kIHBvcnRlZCBteSBjb2RlIHRvIHRoZSBzY2hlbWUgdXNlZCBpbiBidHJmcyB3aGVyZSB0
aGUgZmlsZQ0KPiBzeXN0ZW0gc3BsaXRzIGJpb3MgdG8gdGhlIGhhcmR3YXJlIGJvdW5kYXJpZXMs
IHdoaWNoIG1vcmUgY2xvc2VseSBtaXJyb3INCj4gd2hhdCB3ZSBkbyBmb3IgdGhlICJub3JtYWwi
IGJpbyBwYXRoLg0KPiANCj4gRWl0aGVyIHdheSB3ZSBzaG91bGQgbm90IGNhcnJ5IGRlYWQgY29k
ZSwgc28gcGF0Y2ggMSByZW1vdmVzIHRoYXQuDQo+IFBhdGNoIDIgYWxzbyByZW1vdmVzIG91ciBv
dGhlciB6b25lIGFwcGVuZCBoZWxwZXIgYXMgZm9yIHRoZSBzYW1lIHJlYXNvbg0KPiBubyBvbmUg
YnV0IHNlbWktcGFzc3Rocm91Z2ggaW50ZXJmYWNlcyBsaWtlIG52bWV0IHNob3VsZCB1c2UgaXQs
IGFuZA0KPiB0aG9zZSBjYW4gc2ltcGx5IHVzZSBiaW9fYWRkX3BjX3BhZ2UuDQoNCklJUkMgdGhp
cyBjb2RlIHdhcyBvbmNlIHVzZWQgYnkgdGhlIHpvbmUtYXBwZW5kIGNvZGUgd2Ugd2hlcmUgdXNp
bmcgaW4gDQp6b25lZnMsIGJ1dCB0aGF0IGNvZGUgaGFzIGJlZW4gcmlwcGVkIG91dCwgc28uDQoN
Ckxvb2tzIGdvb2QsDQpSZXZpZXdlZC1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50
aHVtc2hpcm5Ad2RjLmNvbT4NCg==
