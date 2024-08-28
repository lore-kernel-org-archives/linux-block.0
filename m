Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCF8158D7B
	for <linux-block@vger.kernel.org>; Wed, 28 Aug 2024 07:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724829361; cv=fail; b=E497VEKACUfmzD3MDqbOFN1mnUJa5kHKpe2fQowW3AxIfPX1+VLFGGRtD52+zP6WWCQejewNzBlTlyz4ZuW7iqYPxcQfPEzQEfXeakUfmpXWIF4Ed0stLR8WD0BwnXeQirGQVv4P1Q47CO+hiFSOvmg3cpj8wi4VQVS9enXIskE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724829361; c=relaxed/simple;
	bh=OMn1ppSGjprwRtEpdBItPvf7Hefek8Ygjo/AcB79LPA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cU5h9JaAhHdt87EfLSL1uo4LKzCqbahyq4nivqwzGkJ0A3IItLJa/6yE/Bg0Gph6FtFOrlYLU6dBxC59g5SR91VV1v255soCPD3aUQJGBhu7ZUQ0J2mfM5ngnAhvWKfXz/sLFhmp7cm70M1eb0W3aTBANnPktuIfwkC//wEffzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=Z5bfs4H1; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=epfSH3Cb; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Z5bfs4H1";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="epfSH3Cb"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1724829359; x=1756365359;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OMn1ppSGjprwRtEpdBItPvf7Hefek8Ygjo/AcB79LPA=;
  b=Z5bfs4H1xjHLR28uiv2hhmq3ZRR3KHpzGGk/DJ1VBsMpUThkr/XFAM26
   P7ghMyuXltEqaTS93KqudVn4ynlmyOoROSrpQ8UGu5qYBd+63x5WQYj1/
   eFSQXPk0HnsqpE9f4Vogz4ByfBgMCTq45mTI+70/2bpfjgGVsI0cAvW0T
   0fPqZ8CsU7iQN+NOU3lIDHdTK2FhIy7UBamoMsJLOK8o2iLsJov2sS6E1
   bniC6pw1WGkJkovHUxee+VX+2SaZgefDAS5nZJp0Ow7XV9wu/gU8x12ip
   lNj7i3cUTQJZw+JrtLJgnFAFx5biF71lCoZk+fILI0BXXHxzS5l5lJ5t7
   A==;
X-CSE-ConnectionGUID: H5Or27CjSj6q/r1oJ2mdMw==
X-CSE-MsgGUID: 9mRTk5XGSk+M8SHhs0Kj3A==
X-IronPort-AV: E=Sophos;i="6.10,182,1719849600"; 
   d="scan'208";a="25696237"
Received: from mail-southcentralusazlp17012053.outbound.protection.outlook.com (HELO SN4PR2101CU001.outbound.protection.outlook.com) ([40.93.14.53])
  by ob1.hgst.iphmx.com with ESMTP; 28 Aug 2024 15:15:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nWB8007bJ9J+KKKF1KzSm64atZtgmhhFN6cj7D9U1CMJ1ibI5sf4PFlpjxwpUd2hL2QQuAjgS45FzQRNJayA09YN5KZmstd2kS730LvFiOQBbIBK3ikTjrr6J3JT0LYAJEo/v9GAwdN1uM7dRqcpqa74RjGnYFsnYBOwsjwUDrXs+72r8pzQ+2l5Y2JvKCWPcHC7cx1KrlhNPwKjlB+i84C1MjTZZTkPXFLhwG+RedOXjeP6WLOgu7er2aAT7sHibXzJZusJfZV7KE7kQXDXQI6j9fEqXRlU4C98KOHMrtBOxqBLmntuOV4NPWLnnAyFNOovhdfKXZyXfDZdlkDgxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpYdexHqzyWlydgI3HaxSkRkvu9Kyb9JQAoWVcdGUNQ=;
 b=oEp6P0r9AGTA8JEoX3QOu4g3qcIqtf1LMQvb22mQJsGUF4nVIRdpgLpIjjNgOUFt8/flU4gh96ux7hcCVV8MCJZm598zJZjF3PgYkcYcnKlY/t0WVQtMQomHaJMc0XhAr1ILt0pnrG+sYeVMkdaTl2cJZwSLhVD/19r7DudyW9E0moyyfYKWLoXtyOcrhaPFiDGT6yuVAe7RD+jb2LA/xVSwN52j6cEC5K9ay2OHY0mWFn2ZsoXOkUND87qFCsb05vsr85vlcw3pnhEpdKAwoVGh7yczCKPR9zNM52ouDFQvl+pqF2S8A4lIzTpCJ0Iiqjf6h4D6E4u7SOmJ6Pjjrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpYdexHqzyWlydgI3HaxSkRkvu9Kyb9JQAoWVcdGUNQ=;
 b=epfSH3CbNXvhMSD//RS4pO4DK1HTu6OBu1sxqEpNLSRE+0mNQjqe07p+ZftfFQM56Wurirrl/M3S/1zCvsTcJcKEQ5frYdgmfUbFKa+zgzW+B4KR7Grknter5NgcFk+x5lnEU9UXoh/9iq/RimIS2w0UIMc/4gsS0iQhvx09J+c=
Received: from DM8PR04MB8037.namprd04.prod.outlook.com (2603:10b6:8:f::6) by
 BY5PR04MB7105.namprd04.prod.outlook.com (2603:10b6:a03:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 07:15:55 +0000
Received: from DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a]) by DM8PR04MB8037.namprd04.prod.outlook.com
 ([fe80::b27f:cdfa:851:e89a%4]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 07:15:55 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: John Garry <john.g.garry@oracle.com>
CC: "axboe@kernel.dk" <axboe@kernel.dk>, hch <hch@lst.de>,
	"martin.petersen@oracle.com" <martin.petersen@oracle.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"kbusch@kernel.org" <kbusch@kernel.org>, Damien Le Moal
	<Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v2 1/2] block: Read max write zeroes once for
 __blkdev_issue_write_zeroes()
Thread-Topic: [PATCH v2 1/2] block: Read max write zeroes once for
 __blkdev_issue_write_zeroes()
Thread-Index: AQHa+Rof8iMZmiM1k0OquITGJPS74w==
Date: Wed, 28 Aug 2024 07:15:55 +0000
Message-ID: <jxozlplk5fforzhc5hgmanqszw7pb7kuxbo2f23e5xtu3yozdy@tneiyvantisq>
References: <20240815163228.216051-1-john.g.garry@oracle.com>
 <20240815163228.216051-2-john.g.garry@oracle.com>
In-Reply-To: <20240815163228.216051-2-john.g.garry@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR04MB8037:EE_|BY5PR04MB7105:EE_
x-ms-office365-filtering-correlation-id: 7affaded-1b22-460f-75d0-08dcc73141fa
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700018|27256017;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ajYAXyPK97sAvLFEu7DEACAlqcz0JHZJg2dk6G9hYirmXkMuX0MiL8lj/fJW?=
 =?us-ascii?Q?wm1WlEskPamufMHqS9e3XRaePgRF+JdYKlaFLWnRqtWtFnNoqhV1Y3Hy0ZwH?=
 =?us-ascii?Q?+MQ/g6GJ893FxaSyDZDG9Th8b8VnwjHwp7kKR3bITaOdaoi2NUcXzazMfPuD?=
 =?us-ascii?Q?Ntl8im536evGd41XmtToye4nUN6i0ewKf3Wun+whuwixZUa7QFrIs4DOVr02?=
 =?us-ascii?Q?njSbyAs4M2zr6+++i3mpzf5nfXptM3u/ExTEjQpjDJJ86+DqKvFe85AgcskR?=
 =?us-ascii?Q?gA/BHfv7pSbIvydBNCMkSjuxn7/SHBtTCLs8DJo0FHRYtHTtnrB/N6O/wDhI?=
 =?us-ascii?Q?uMTwTpEEOjPUitm6Lkds51MSA31c7m+mPjPrWtsoDlBX01UlszqrOYRg7pVn?=
 =?us-ascii?Q?USSW3hj7Porp1ZdAWnpALk6gmEh+WN9sp8GEoYPRHACpaJ+JK6sLFdTo4MjH?=
 =?us-ascii?Q?bCgSlazTOntuzLzNs1F1MkNx3edLCz3V9tUwGTqRVWA7FFTYPgGQkRez52ZU?=
 =?us-ascii?Q?N2zuKjLZ4L2QI3+4kEBwXkWSQG1GSrlpmZEgJgaapG3rAYROp6HejV1VVxZo?=
 =?us-ascii?Q?VE3GKW+ABu8e14yskd7PD5ckWmJsK71lopa9NWRnoxBCeYnfAVNDjCAqRRFs?=
 =?us-ascii?Q?SX9G01CnJGzU7zKXhv1nsm28cSt2nNQ3Nl9w+N+uBzTlonqPhOFb089OjhQc?=
 =?us-ascii?Q?EGP0lS/It5eR9kt7zXFGhMmloBIUh8bnAKzwctkfi0wsuWArYjos6Tld17y6?=
 =?us-ascii?Q?54ybvuD8L+LBThK0t4O80fTuYTKI74ycQEDJ4L1qEQQPgYlEEaQko1Wr3CHT?=
 =?us-ascii?Q?9EwpDMiEhEE11ICx5uqdN64gmXQPr4dCSkCy8j/NoM03wS3dUcExzCw6jvTo?=
 =?us-ascii?Q?Rv1OV/NZmi8CWi5C8V2vwfdLh4bFvUPsi9fkGfPDi8m0WClnE/Ph2Eaa+Xsr?=
 =?us-ascii?Q?K2TAi+lFpwj4EVm4u9wLkUFrIOSZI6A6/EJFy1I7oEmoGZnwfUE45iiqYf/K?=
 =?us-ascii?Q?47VfrkQHTkkkN+A77Pu9OeiJ8U4NMhoioi7J8N+Uq7rWZXrkpc9g9yGphRcU?=
 =?us-ascii?Q?5Kc+7fqBrW9YoW0of1wsXaE3n1do03L6YTEhUuNRxKoJp38PNid8tkk4i058?=
 =?us-ascii?Q?Tx0+rwcrHlReoRTZNRaj1ECHiOJRftAlceP9ZZcwUcpeMZMEXBmmE099YvRc?=
 =?us-ascii?Q?Adki9ZZMiYarkqLSs0Qwg9hM6n+kfMfeeIq38kVkLwTeXy4sAc02BdU6h153?=
 =?us-ascii?Q?bBnnDSfyp5VpbNoHgxXLzVKcMf1C8k0t8Tv7PJEYIMD+io5U9D/ykHI4Y4mk?=
 =?us-ascii?Q?tK1S4Pl2RZeZtsGS37i6SqjmSBTt1UtSbMMv8KIN6kHi0bkZ3FjNkli1bH/L?=
 =?us-ascii?Q?aRKIqwJAPgoMr9+7DrOb+7uAIiiD?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8037.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018)(27256017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oPxDTdbZRa8TPkSUz3Wq8u9fpb/KolLAguX7sCKuVz4mZ7dw3lAvV4f1UH57?=
 =?us-ascii?Q?liBPHzsbXmx+DROU4xC2+yl/rWo3ZnY9CVxzRNsjgNgNy+rwvNdYQ4kLxYSm?=
 =?us-ascii?Q?lUuhqfeqvLd52w9wrCJ8KqvSITcpqdfHc/uMfQh/tw9DnOteX2j9S8C9Ba9J?=
 =?us-ascii?Q?2LABZwmkPHOnU2s+LM8lck5MBRwbsqc/UPXPwpO+40zE07o47N7GdqnKqCRp?=
 =?us-ascii?Q?47IYTPjsOouDVUyE0Ex4Vhdr60ZrbR5q5HzfJNGFDjqj0wZRhSZdQEuJ+0rm?=
 =?us-ascii?Q?Glq0JwjqvmpR72zB2p/SAB7ls+b3HrQSqMb8+J23YldcQqfsLYxHBowbv8sS?=
 =?us-ascii?Q?ACrXh8hC/AHeXFkWgNqb15yT9B1EfHbBSDWHyBsvAVKjAlcTO8apL57f2RGJ?=
 =?us-ascii?Q?yKz1wsQGeNf6PlvL4krPYEzKo0AYWMUeg9w6EkoAEq/MsO9Wa7YBT3ycMimo?=
 =?us-ascii?Q?l+6GHCHIsTHgYaFNJ3wWjTd1IjqZBTP2Ss/0nWHUuVk3xYv8/7mUYWgkhqnt?=
 =?us-ascii?Q?hDdSVIm+88L1Y2RC1uEtzcAimcYkfwjLzVeJkxAqGvkfRhIXQSNYf0p6eg4i?=
 =?us-ascii?Q?VvTDgh2RmTzICNJB2v4+ZkDUUk+uQ0KSujupp6zGzSPFbRLc3L8cZf9Bzom6?=
 =?us-ascii?Q?XqEzWLcHS0TjmVnpLFdRLiLRVdCHZ+z/fDNhbhB0FX4PJrS+q9BicBrlvME7?=
 =?us-ascii?Q?25yVoWInAnws2GDzh2Jz5+6TYlBPyMztYyMysTST/ObWB5yjd1bnnG1cqXIZ?=
 =?us-ascii?Q?XkBbuCkW05WsuAamcqAWaRbZbVObkkD0FX774aiBG2lcAhMXx89KwZAXleA8?=
 =?us-ascii?Q?W8Y1vvA5uzLv6LJS7Eux0ZegYjUtf0pOan86FojXp36uGS+mHNUyN87wVoEV?=
 =?us-ascii?Q?B8mTllGClb6S1Oy8sxY/ypy5JcSjwNsbChv2fcECVUjAMF8G7IrzdWwY8pfC?=
 =?us-ascii?Q?UwpR2iW9f816kXaUEWdBhzZgjc61JpK9tlnnlTxd0X9MJUQGiRpGGW0tTe/i?=
 =?us-ascii?Q?iCll+Q7QNA9UQbeRZeSEyjll2VnmCcqKGiAGLrf/5KzrgzHDiguXTT6uwXMV?=
 =?us-ascii?Q?QgoP5OBUj9B6I5wPD5ugL0wfmnQAfF8xpN1g+/Na8LR4DAiUVpZY02dtTI/y?=
 =?us-ascii?Q?2nJWNkCAdznpny1rVknQ2g6Pl2qjSfNdv9odiKCqaTv/e+QtB/1FEcM/TmHr?=
 =?us-ascii?Q?9rUgvCCE1ZWdRXXf6M75zjr7e3AXYZ6ZZxauWlwvC+5JoJhTeFE/Wyif1gE/?=
 =?us-ascii?Q?GUMJALaYSus8RZ7jgup+iEraLs29dadeZdFQhqXwocordUNfQ8CJ8a/oGzTp?=
 =?us-ascii?Q?JpChdTnh0vKnMSd0+6KMmvU8ntZeUKXjXIhuP4HBa32jNWaR0AmNETnL1iFH?=
 =?us-ascii?Q?+3absALAb8WE/XHSzxPjZIApyPSvt/NJm9NJb8T3KpkuxyEdJs3I4zZG60EX?=
 =?us-ascii?Q?oPeQNRPnlnW8u5Q0jOlOaRQ4FTpbm+IHoJTLMRT0vqcJ0bW+GXWG9eC3R2+J?=
 =?us-ascii?Q?yofMcUpK4mvh+xXMNHahBSOLxgjdNQtIIZZJvbJqeABOjz73aGYRw/5sZZEW?=
 =?us-ascii?Q?nUG+Qv49vfLIlCPVv+Fw/ibvIpaFCRsOMwzsvVO4d0NULBbzo6WyDwD+IZr8?=
 =?us-ascii?Q?iloCRQkznA6FaKcyP/H1NVc=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2224EF26B8A4044EB4F21BE331E61838@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	np/nQIIU+4bDRPpgVfNopKqZMk0TMLoMWdTySEWW6+xYycU83QlxqhmjsBeKw3e512l3awIpckOjCvaUwTaWS4jMRIaBdjx2xk4IfSXNct888lPul8HG6coevwBxsLHRG/frMnk4oIIJuJjKTZk5GFVPhkiLGt0KYSQ8msKrdNlTp/d24SAo0kRGeiAayChK4K43GRKtLU7ySqzwfiKjvEgvFyOZf/cdRXv8d+EoprvY380JpgGU8rqF6hDBSnN6kRlYzcTOw48LdxRU1bEG4X9/yxaiwiMR3MD+x7BSUV6nlJyV9o8bn0uGinfaT6699f9Q6WL6lLaxvHXAuVAwQFqh6QMAwbLtgkjqTOTg6VClJGsQTDpb9x9y74y8lxAAU8Po8PPHuG+nVNcOPewCCtvqf6bxXFdY8eCv3nPjj7heqrnD2oVz7pHAGjgQ1l25BkHYE5Lq3V4pbf7y4pFgduZJh4JzMB8TvVj9y/m2XWOze9Yw7LSjp7EyM5TyWIMg5HWcp4sbwL1pAvUPlNdzZUY2ogL/y8zrVhC/QgaeQuCBkCGWOiveXUGmaicpIk4jQtRyYApfNMU2jpdMEe9p1JRya+xCoj5+OSBdwadVtOAeHzvc/Wl+md2bKvaCwIgi
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8037.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7affaded-1b22-460f-75d0-08dcc73141fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 07:15:55.3926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SRGRSoQkIMmh4izWnucq+pP/FWZ/BXDB2KHtQUsoQHnhKTnhAvoAIhW+VHipVKAQhjX86679VL/sCVXYmVOLCMXczcUE2GbhEl4NtNZpjdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB7105

On Aug 15, 2024 / 16:32, John Garry wrote:
> As reported in [0], we may get a hang when formatting a XFS FS on a RAID0
> drive.
>=20
> Commit 73a768d5f955 ("block: factor out a blk_write_zeroes_limit helper")
> changed __blkdev_issue_write_zeroes() to read the max write zeroes
> value in the loop. This is not safe as max write zeroes may change in
> value. Specifically for the case of [0], the value goes to 0, and we get
> an infinite loop.
>=20
> Lift the limit reading out of the loop.
>=20
> [0] https://lore.kernel.org/linux-xfs/4d31268f-310b-4220-88a2-e191c3932a8=
2@oracle.com/T/#t
>=20
> Fixes: 73a768d5f955 ("block: factor out a blk_write_zeroes_limit helper")
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: John Garry <john.g.garry@oracle.com>

Hello John,

I ran may test set for the kernel v6.11-rc5 and found that this commit trig=
gers
an error. When I set up xfs with a dm-zoned device on a TCMU zoned device a=
nd
filled the filesystem, the kernel reported this error message:

  device-mapper: zoned reclaim: (sdg): Align zone 19 wp 0 to 32736 (wp+3273=
6) blocks failed -121

When dm-zoned calls blkdev_issue_zeorout(), EREMOTEIO 121 was returned, the=
n
the error was reported. I think a change in this commit is the cause. Pleas=
e
find my comment below.

> ---
>  block/blk-lib.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)
>=20
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index 9f735efa6c94..83eb7761c2bf 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -111,13 +111,20 @@ static sector_t bio_write_zeroes_limit(struct block=
_device *bdev)
>  		(UINT_MAX >> SECTOR_SHIFT) & ~bs_mask);
>  }
> =20
> +/*
> + * There is no reliable way for the SCSI subsystem to determine whether =
a
> + * device supports a WRITE SAME operation without actually performing a =
write
> + * to media. As a result, write_zeroes is enabled by default and will be
> + * disabled if a zeroing operation subsequently fails. This means that t=
his
> + * queue limit is likely to change at runtime.
> + */
>  static void __blkdev_issue_write_zeroes(struct block_device *bdev,
>  		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
> -		struct bio **biop, unsigned flags)
> +		struct bio **biop, unsigned flags, sector_t limit)
>  {
> +
>  	while (nr_sects) {
> -		unsigned int len =3D min_t(sector_t, nr_sects,
> -				bio_write_zeroes_limit(bdev));
> +		unsigned int len =3D min(nr_sects, limit);
>  		struct bio *bio;
> =20
>  		if ((flags & BLKDEV_ZERO_KILLABLE) &&
> @@ -141,12 +148,14 @@ static void __blkdev_issue_write_zeroes(struct bloc=
k_device *bdev,
>  static int blkdev_issue_write_zeroes(struct block_device *bdev, sector_t=
 sector,
>  		sector_t nr_sects, gfp_t gfp, unsigned flags)
>  {
> +	sector_t limit =3D bio_write_zeroes_limit(bdev);
>  	struct bio *bio =3D NULL;
>  	struct blk_plug plug;
>  	int ret =3D 0;
> =20
>  	blk_start_plug(&plug);
> -	__blkdev_issue_write_zeroes(bdev, sector, nr_sects, gfp, &bio, flags);
> +	__blkdev_issue_write_zeroes(bdev, sector, nr_sects, gfp, &bio,
> +			flags, limit);
>  	if (bio) {
>  		if ((flags & BLKDEV_ZERO_KILLABLE) &&
>  		    fatal_signal_pending(current)) {
> @@ -165,7 +174,7 @@ static int blkdev_issue_write_zeroes(struct block_dev=
ice *bdev, sector_t sector,
>  	 * on an I/O error, in which case we'll turn any error into
>  	 * "not supported" here.
>  	 */
> -	if (ret && !bdev_write_zeroes_sectors(bdev))
> +	if (ret && !limit)
>  		return -EOPNOTSUPP;
>  	return ret;
>  }

The hunk above changed the timing to check WRITE ZEROES capability. Before =
the
change, bdev_write_zeroes_sectors(bdev) was called after WRITE ZEROES bio
completion. Then it was able to detect the q->limits.max_write_zeroes_secto=
r
value change by drivers at WRITE ZEROES failure (scsi sd driver does it).
However, after applying the hunk, the check is done for the local variable
'limit' which is cached before the WRITE ZEROES bio issue. So it can not de=
tect
the q->limits.max_write_zeroes_sector value change at the WRITE ZEROES fail=
ure.
Hence, it does not replace the ERMOTEIO with EOPNOTSUPP.

I think the hunk above should be reverted. I created a patch below for it, =
and
confirmed it avoids the error. Now I'm running my test set to confirm no
regression. If you have comments on my findings and the patch, please share=
.

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 83eb7761c2bf..b336d57673d3 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -148,14 +148,13 @@ static void __blkdev_issue_write_zeroes(struct block_=
device *bdev,
 static int blkdev_issue_write_zeroes(struct block_device *bdev, sector_t s=
ector,
 		sector_t nr_sects, gfp_t gfp, unsigned flags)
 {
-	sector_t limit =3D bio_write_zeroes_limit(bdev);
 	struct bio *bio =3D NULL;
 	struct blk_plug plug;
 	int ret =3D 0;
=20
 	blk_start_plug(&plug);
 	__blkdev_issue_write_zeroes(bdev, sector, nr_sects, gfp, &bio,
-			flags, limit);
+				    flags, bio_write_zeroes_limit(bdev));
 	if (bio) {
 		if ((flags & BLKDEV_ZERO_KILLABLE) &&
 		    fatal_signal_pending(current)) {
@@ -174,7 +173,7 @@ static int blkdev_issue_write_zeroes(struct block_devic=
e *bdev, sector_t sector,
 	 * on an I/O error, in which case we'll turn any error into
 	 * "not supported" here.
 	 */
-	if (ret && !limit)
+	if (ret && !bdev_write_zeroes_sectors(bdev))
 		return -EOPNOTSUPP;
 	return ret;
 }=
