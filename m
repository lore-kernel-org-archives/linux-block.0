Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D30F314A89
	for <linux-block@vger.kernel.org>; Tue, 25 Nov 2025 11:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764071840; cv=fail; b=UeS9DTzm1FZiYqwRxbOZvSzVh4t96/mTE2aIyRfaLcF6enfbyQCC1F0OnMI/ZZ2SqMglIkeWpbvkXT7YWYEGUXk2awawTgZnct5CblZE6Y6ZF3uDlhpBlq1Q2AIYHFys4F0BpbY8vE+SgakpmYdeUi1486Q1zXyv8Ek+yDQMiCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764071840; c=relaxed/simple;
	bh=YAfThO3n3SPuN+sfuMh7Jn4hQJeQvcT7av5oBYnC5/s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nHNnmYP7qZC6SgqsrDAVPRi0qenu22AqhxKx0QfK1vx51qHeJvn/M2tVhj606XE8JzQGWf8ZHGCj2r1xECwr7Ei8WEXyZAHgS8uHtIwXHh0R6VtGRDd4rhv5fEsDJRdo4V/OrEzqV4BgWeYe7SvSAsU5beXaKZlnEZplbmHDExc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=osPvyhaG; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=XV411+24; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="osPvyhaG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="XV411+24"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1764071837; x=1795607837;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YAfThO3n3SPuN+sfuMh7Jn4hQJeQvcT7av5oBYnC5/s=;
  b=osPvyhaGjhlBr27okp4WWoJkfTNynuvKDEdq3e35VctwtEoBdtW0opL0
   Tc7kEFIKdXR9JAfEkWbs0UbzmSGJbcikAVLOF5cwxQ33mCVPS8ZI+Jag6
   VSRZ8Q2TeRfyCDLGVU0RI2ztAcB0pR+QtR8okQKq0tcBQfrXtOqgBa/ax
   4f/juTjVL96rVrGSpt9+R/Kf2fV38WiYB452bcPFjN0i6pfXcAWApgb2a
   nDyqsd00xy1i/iaz/LJeG7TbiJ573cbc9eKjsZGbSRfO7rQl9affdRPpR
   UQ3ZwkyYCkD7ZD98Z7xE3xrQGA4vDFPAcPiqF4NEoTdJhVdCgB16aTUo3
   g==;
X-CSE-ConnectionGUID: KBn8VRn9S9iujzTIjqMrTg==
X-CSE-MsgGUID: 41bYks8TQXKNcQtwiOQ7tA==
X-IronPort-AV: E=Sophos;i="6.20,225,1758556800"; 
   d="scan'208";a="132700572"
Received: from mail-eastus2azon11010035.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.35])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Nov 2025 19:57:15 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VtGfuH1c3H+3DlFLMCPlheY8Q7XojWdLT+7gRtVqXT+DCrOy8PRI2i6MtslsHPh2iVizENB8o+3fSW2io2zD3gy2SsMXnvNB9vzlnvfGIsBO0oM3g+brb+HBgiA9i6eNLWQdYgJKIxSlH+k736MZrMO+B1stQgWdt23lX0vkR98N+rjxwE9EN6GMj2KEQVumbQrPw7LGxjO+rU2GJ3bxr1kHMQssVFpmEkh92qtQaFl2SItrzJn+NoOmwWFmSDY98sb72zOD17LYffI+czlL+cmM2LyUvSRbGz2neK1f9G811SLPBJGmSZzE6kTXwDfCwS7cYW+N+I/fYlYpnSLdsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CjrQVGiTL71h4AnLDUAxecA30jkn2Dq6JkV+qR1ZrmQ=;
 b=VqoVXuYLI6yf1sswcIesYRAlXzJ6ayYiFtvBHSYdOOt102SyKjaQkc9bBDLp+fU66Q2JypbZXwklOrbRxR2RUqlGquuTjXM+fZZSojl96s6E6ifLhiSoVOdwe1poL1Or7gJU2xzpHYFe3DPCSh4R0ATM3uPYR+31vvpnltW2LR042dS8iibnk/ccjhKO0AgNiA32aB7UH2P9L+GNAWZUsXLG6v5H79KRYveAFIvhicQbuODLJhb2VXBWWCnA8FufyG3SGGXo0qUO0yMGAIPqHc36ELcdum3g2K+FG/LoZPqmjkmHxAkqGUcndgixPdvQs9cqa1mEs2oZwI5zZR/tBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CjrQVGiTL71h4AnLDUAxecA30jkn2Dq6JkV+qR1ZrmQ=;
 b=XV411+24fRMaStpQnT6gWrdxO9FG94FV4taCFAsiBGNgazsNxSHANmZeOQKWfviwtCwHA3ptOlpIX3eRVxazr7iC5ynkKMhWRBEN9eOQLAjzNxqHLMJEAOOgL2rMEuLMUnSU/wlIXOyfITuJJ+Ov0AQRxaVsehtpj81Soz2sxOQ=
Received: from PH7PR04MB8521.namprd04.prod.outlook.com (2603:10b6:510:2b8::19)
 by DS1PR04MB9093.namprd04.prod.outlook.com (2603:10b6:8:1ef::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.15; Tue, 25 Nov
 2025 11:57:14 +0000
Received: from PH7PR04MB8521.namprd04.prod.outlook.com
 ([fe80::5bf1:37ae:cf94:c7ae]) by PH7PR04MB8521.namprd04.prod.outlook.com
 ([fe80::5bf1:37ae:cf94:c7ae%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 11:57:14 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
CC: Bart Van Assche <bvanassche@acm.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Yu Kuai <yukuai@kernel.org>, Yu Kuai
	<yukuai3@huawei.com>
Subject: Re: [PATCH blktests] test/throtl: Adjust scsi_debug sector_size for
 large PAGE_SIZE hosts
Thread-Topic: [PATCH blktests] test/throtl: Adjust scsi_debug sector_size for
 large PAGE_SIZE hosts
Thread-Index: AQHcWoc08aOBR5cbZkmBaPtwrWOKIrT9bduAgAP4ngCAAem9AA==
Date: Tue, 25 Nov 2025 11:57:13 +0000
Message-ID: <n7n6t7mj6tvd5pyf67ipc6tt6llkuxj466kry5cu5qlnmmdc6e@a2pevotxmer4>
References: <20251121013820.3854576-1-lizhijian@fujitsu.com>
 <cb0d1c57-7cb3-4434-b6a0-592ce370a4e1@acm.org>
 <1c7ea752-11a1-4f2c-8b1d-1b289eabd583@fujitsu.com>
In-Reply-To: <1c7ea752-11a1-4f2c-8b1d-1b289eabd583@fujitsu.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR04MB8521:EE_|DS1PR04MB9093:EE_
x-ms-office365-filtering-correlation-id: 19d86b33-976c-4d99-84c5-08de2c19c5f2
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?zd8dBc8Vuv9eoufYwpsLZEeXGYvn4ZkM+GSZTs0v4LkXoMxQlH6DYMlzPn?=
 =?iso-8859-1?Q?OHSOWwIovrvyelXik+yubV3fZENLqYLXNgIw4W7+2FYnSJrgPq0AeClnz4?=
 =?iso-8859-1?Q?5UrKGF3am32nsqxs0d8akJIp8Sl7kWbUZ3rmkAjwmIV3c5939Q25aPaL/u?=
 =?iso-8859-1?Q?hybhuK5KkFGABR8PRRK/DkWGt0FikmPs4cWHPd+LfzS2UmGl6H53sj15Ul?=
 =?iso-8859-1?Q?7cd7+GNLqG6SJyHA84uyg0WrWz2sT8NzKRCKJ+cPqaedfqiGETUqGCfUD8?=
 =?iso-8859-1?Q?ZKeXUorpNMgGstnk22rMHnzelk1QudfcOz0CTenAtuet3J11wDVBhoU55u?=
 =?iso-8859-1?Q?2iuLyvpYKfOUSNDn46dw5o6SC1yNmk/E6Q8yor6b0tIRv8mv4C0JLn1OAq?=
 =?iso-8859-1?Q?uUTzhu+Kbd/ci/7ak/BDQlDnL03ec28pcsBR+65exaS7cmeQsoe+0PTfey?=
 =?iso-8859-1?Q?CtrdDdwFS2bZI+iQlcAuPn9U0NPx6PNKTT+Q9F3DGdHkLpRR+A7kl7NqDJ?=
 =?iso-8859-1?Q?WcnRBk42snGqk5yyyClqJYYVC2op+ULYcf+9DyBmTjf3sc4TJidx0XrcK5?=
 =?iso-8859-1?Q?Y4VPSLhlzd6bgJIKYdGpT9KMECBpgUXdqoQwv+H8ZmhQmkTb3XosbCdTUF?=
 =?iso-8859-1?Q?niP6rFdAE/e25QLX7AaqhVG86CGDlfXK4uslY1RQZASnRf2c4qZonXuiH0?=
 =?iso-8859-1?Q?ixssbgS3oYzose7RmwyaPqcCdMnbdjS+6M6z9EBz6Pi/ZfNarYYSXJqjeG?=
 =?iso-8859-1?Q?yTMhRq2RX4RWYSvd9RLcio//mzRygeYhZQXASDOLsXjF/GMTkp0dgxH09x?=
 =?iso-8859-1?Q?wCgoureXjSanncLJsYthDmcHkqn0DEgzaMEMxoC8PmTqG41AJDNK+1pCMA?=
 =?iso-8859-1?Q?6DsE2vZm9TZ8eot/BU0Vc8pG5hUNns2h56Mq+h7m8xBs6qjQsI59JnpGo4?=
 =?iso-8859-1?Q?eD1h6qwy0bKcyCk61nxlctMJU+XJ29HW6l+DUeYxDJ+jMwSqVSbfNUum8F?=
 =?iso-8859-1?Q?kkzRaITjb2n+9Uk+bwonBKK5n3o9P+agYSWIncARQ9C7+7zpNFHhJXgoY/?=
 =?iso-8859-1?Q?jJ8lHeiWytP2WJr7X2dWnXYzYFTOVxGtC4m6PVziz7pf0Wu3wme5dVpKRK?=
 =?iso-8859-1?Q?aYNyjHim5VTG5KAq3e8gW8wPu/2+WO/WYiG6yJGsNJI8Yk41vrEZN6VGCm?=
 =?iso-8859-1?Q?LMxh3E1Ah250pAELMKtTdUaRRQM9ckLQN2GUsS+ro4ICSTDVlAtCnbhjfF?=
 =?iso-8859-1?Q?dkQ8cgcwlZaQ8cd+eHdYXTtdnZikwgDNB20mhmpysOcvUfZTZC5IlF6YCQ?=
 =?iso-8859-1?Q?c3eEX2bAmbevFOI1LtGi6ikmhO0TMQoCMJlE3NzptDwAaN3hLvcEO6SxTA?=
 =?iso-8859-1?Q?SMnWeky0icI6vJZLsYHZ6CP8Iy8okjI6WLe16fid1wBw+N8N4P052l45J7?=
 =?iso-8859-1?Q?mVg/YxB3YIfg5Qxt2RZkzYKvuVar1GV1Dbe3xyGPvZ2JbpjlRGIfvzxZkp?=
 =?iso-8859-1?Q?a+2O5YIPzN9E7w663x/AzMXnrdUOTvVWrl1si4Tly+vCBFghULch/ll8yM?=
 =?iso-8859-1?Q?C6e5QbgsnXg5xSoRdMDYXLUbmM34?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR04MB8521.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?NP4zvwwosPB/2G4ABfQzcI9iAYmpLi2kx/4nlCmiwn62JnNI6Vh6PZNgCu?=
 =?iso-8859-1?Q?+4PGzbZXv5fPPAcLVjlJ84uk0L11soGQ4bUbDrt9EDy8UUk35PrqIis4wO?=
 =?iso-8859-1?Q?JcAHPCvkWetsvu7LB+LSqGIKIqS5sY/nA9MsM4vyAnrudcDZiQnNHvn0qv?=
 =?iso-8859-1?Q?E4SW70f3I8uuyZn58bhMiocee3G5KgNBwLhbiV6yDFv/DZojjm8JD6sfZF?=
 =?iso-8859-1?Q?swPjDP9vlJK2/oPfoQnqvnOEX83ots66fpTLtYAWks+Loc63rlkWP+icAU?=
 =?iso-8859-1?Q?Q5NRBcGI14jWGKkbPkxaQCOboby3lDGugbJD1F3QFU0QvoP/DHXYs01lqO?=
 =?iso-8859-1?Q?l1SqBenOIFe3x8EaV622H1c7X7H22o86622ycuuFmWZHmDnR51EGX8xrFP?=
 =?iso-8859-1?Q?nABZ5W61yYMfu2aEznXHL6UB28NGS5TvVOTfUu/xHkSIpYUK25KfPSUiWO?=
 =?iso-8859-1?Q?tRY+f2r6Q3m5V6MzVj0JfOOKhFQvPUiMVEFJ0xqvvxzRntMF3O1w51jFBo?=
 =?iso-8859-1?Q?ZTBoob+EOphV72Y5jI40ijaBhVP3sKjButIT4DvPjDtHx0GLbB6b2eLsps?=
 =?iso-8859-1?Q?+apGmg+43/6C074aYUKOgDPWNoS3kxxjzVlyvP74xhbFNhYzAF/SRwszBg?=
 =?iso-8859-1?Q?6XaAxgFK43LFFKOqV10XdiUCre7OsFO3AweCxQyRQdNrdDZTFKeo87jwxn?=
 =?iso-8859-1?Q?7cNh6VOLPFLrHQVHoRAyiE3bSpW31XWJn9T+Rgjj4pBCz4I9HTO8mjIGDL?=
 =?iso-8859-1?Q?JlZAAlkYzgpYSIi9G465FN1ElxbxCHaJZGJEMuDuzcjPye+KiVrPJJE6Q+?=
 =?iso-8859-1?Q?hN5NuKaVJ42S+e8Uzo+s8OR+wZ6u/9d7ycINmajQm2o0QLSknjwXCvG3lh?=
 =?iso-8859-1?Q?pIy0j0y785HNzO5SDS914nut8m6ET2C31DHkLskNWI6eA4NGKu3miGLYMj?=
 =?iso-8859-1?Q?ZLM3bObXeAq8B5j28UssH/K0iI9z04VJ1pbjI4vFEpngcaS3N1FkzjTkx/?=
 =?iso-8859-1?Q?CMqoM6sDJDyQ/nLuImG91xpTQYY+6IWirQadXTrA5IqYlZ98+B2Wmv2O8A?=
 =?iso-8859-1?Q?+a6JPF8g1RlZ9VdtexPesLUYrxvG1s3BAfmI/I4nykNG3J66CKWh412m7a?=
 =?iso-8859-1?Q?qNFJMu0zFcksdA3ugMEi/sEIFYCA62bljcI8TNTRMjp7VSXw2ViGW2rZzr?=
 =?iso-8859-1?Q?09W0JodUa14TbsPWTdMqDU1RgK0jZP38y9Qo5biD0SjdMooTz2Px3mfMJw?=
 =?iso-8859-1?Q?M87/lpb0MaTfC7u0ZX4RE90C+uCYITq1o9uYhpsnsgS9G8KK1gLsp0gsE2?=
 =?iso-8859-1?Q?e7DdanMtEmuIXZ19T4ruuv07kbRf7T2thDfa8f8c52jkeh4uIlR5L7tz+Z?=
 =?iso-8859-1?Q?cpW1bZDUEIp8snzgTFpoT/RIPw+7noWPqycaeW1DoOY10DKCARb3pcaStx?=
 =?iso-8859-1?Q?bL2qMMYUuvpQgWnuM4N2LvCo3+2ii8+OI+ac4cdjyndBJGKN7HV6mSFaEO?=
 =?iso-8859-1?Q?6RUWYnEJyc7fULpsuyX/7t8wepxCaitY8iS7DytpDf3LcUzYqpPNH6e8fi?=
 =?iso-8859-1?Q?mW2zvpPfPrBeHZDDNxmvFd7Q0+W7QZDBae3zr7CpsaLyIXpviWQF38WdDw?=
 =?iso-8859-1?Q?bV8qMdVItk5SAREyUqjdyu/5AaglrMDQ81Ao4rjNZxcOPa+TB0X45xQaaG?=
 =?iso-8859-1?Q?XEBE5AjrXPsoh6B2AbQ=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <F54A49602D3D544D8312AFD90C162C73@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aQJUbZ4aqtveX13316r9j66HCx8ZYScYqCJ3WdOCQn3HQkdD1EzzDyOt9Q5LzwOLsPGMF7XJ0FOaJjuAd7mJM+kyfrNxmIICKs2dTvfq5atEpZZC+Fh0FkIcDxsIyi6Rlw+peyDecb7ahCDs96XfAl7NckfNCXmX+eJDVZOKWRVQILbUHQJUdmpXhFJw8Jg5kE3YeIHpZ5XM6O2L9aDMmHI17jvDMqVgihzL3iLD4uGUEJk5XJJZoV9V2/+AbN04vNVMImwiXnfivw3teYduPrxt/j8ou5uZcJHoWmzRcZh3en9zJ86OGdFpxDmY96Y/YF6FXrmBYwvdlhM36kQXRMrBHW6E2goCkSlqNEQPxIYf5SeGpLkpdCnTnZ7x+9vZr4/DUEYQ5TOrMqnFQqW/esnpT9CtbdrSbioeLbsl9V//sgVrMBFoi3TGzpPWDzqOHVULgIimWCRkEGYLouZuMUNHX2k6+8uJzruahiMwsbB3jt88N21dDKIcQXJrYtjJa/cibbTDvnoPHU8sFpJErnl2w8C8PdEBMR4a0mViapIds3d9r7hXN6g86Enlrzqteu42Clp60AgRk6S3JVd1+Sz5/ISlHxfwNpA5wNZ74XnITk4EdqBWxXuk96TtbPYl
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR04MB8521.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19d86b33-976c-4d99-84c5-08de2c19c5f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 11:57:13.9486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hNJgg/rww8QaJXiAU8vHqc/t+JD7B3jFOMAo4v1BrvVpQ9k0o67sc/ByA79ifJjKBQXSxbXq3wMcX14CF6U07VQSzcKzw2B/m3T+y8f6jg0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9093

CC+: Yu Kuai,

On Nov 24, 2025 / 06:44, Zhijian Li (Fujitsu) wrote:
>=20
>=20
> On 22/11/2025 02:05, Bart Van Assche wrote:
> > On 11/20/25 5:38 PM, Li Zhijian wrote:
> >> =A0 # Prepare null_blk or scsi_debug device to test, based on throtl_b=
lkdev_type.
> >> =A0 _configure_throtl_blkdev() {
> >> =A0=A0=A0=A0=A0 local sector_size=3D0 memory_backed=3D0
> >> @@ -76,7 +87,8 @@ _configure_throtl_blkdev() {
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 ;;
> >> =A0=A0=A0=A0=A0 sdebug)
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 args=3D(dev_size_mb=3D1024)
> >> -=A0=A0=A0=A0=A0=A0=A0 ((sector_size)) && args+=3D(sector_size=3D"${se=
ctor_size}")
> >> +=A0=A0=A0=A0=A0=A0=A0 ((sector_size)) &&
> >> +=A0=A0=A0=A0=A0=A0=A0 args+=3D(sector_size=3D"$(fixup_sdebug_sector_s=
ize $sector_size)")
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0 if _configure_scsi_debug "${args[@]}"; the=
n
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 THROTL_DEV=3D${SCSI_DEBUG_DEVI=
CES[0]}
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return
> >=20
> > Why do the throttling tests query the page size and why do these tests
> > use the page size as logical block size?
>=20
> Good question. AFAICT, throttling tests will test null_blk and scsi_debug=
 block type, the former will
> calculate the max_sectors based on the page_size.
>=20
>=20
> > Will the above change break the
> > throttling tests?=20
>=20
> The tests still pass with this change on 4K and 64K OS.
>=20
>=20
> > And if it doesn't break the throttling tests, why not
> > to remove the code from these tests that queries the page size and to h=
ardcode the logical block size?
>=20
>=20
> That's a good point. I'm not sure about the original design rationale for
> the scsi_debug part. I'm Cc'ing Shin'ichiro, who authored the scsi_debug
> target for the test, to see if he has any input on this.

The original author of the throtl group is Yu Kuai, and I added scsi_debug
support per suggestion by Yu to catch failures that not observed with null_=
blk.

Yu, may ask you to share your view on the questions by Bart?  As far as I t=
ook a
glance in the test cases, the change by Li Zhijian does not look brreaking =
the
tests. Your comments will be appreciated to make it sure.
