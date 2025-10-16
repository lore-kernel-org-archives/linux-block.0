Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74AD1FBE87
	for <linux-block@vger.kernel.org>; Thu, 16 Oct 2025 01:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760577104; cv=fail; b=Elm2KtiFGMM3wc6/Olt7+E0pM/Mo+Jpmj0NqvUqAv8TZiAZXtvU+9T83glafCaGTwa8ZaC+7PQ217kJRaCpz+Ug7de24dQGnVbnwsmY2GtF6eCTNXxivTdn/aIE+cf6JP+D2MoGHq6aS+mQvAoRxs8meBf6W6FiJ1gh/2303v8g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760577104; c=relaxed/simple;
	bh=XYrWnvrQPfUDytkyKmfdcJ0520x+/fqWpb7bWz9VGxs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ssgpPoDtb/MiHTkDKaxQIHRM3kogXTCBmMtw58DWy1RbBZj7cbpTzeiPLuZ6w4nzh6YOluQR5fq3Q3DQ0bjvFhSFaUlYbuDfnnceuNI5J78cRA9OM3mn6dQvZRkMBgtWQZINxoY4PuDl4WCrAyuHVq4PHd5Bw0neKFa7jiKkG/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=B59bCO9i; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=vubs0KjL; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="B59bCO9i";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="vubs0KjL"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760577103; x=1792113103;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XYrWnvrQPfUDytkyKmfdcJ0520x+/fqWpb7bWz9VGxs=;
  b=B59bCO9izOpUl12ktoWrBLu8Cu8P9VQo//xksPuTBcY9+UVQZrBmFCSD
   J2gobIjef2Ovzw1eNUELSlI/odG6F/Q9f1NP/KFt+h2ELEcyBB0ZnJv+i
   vFcEXZYHGPBFa7LyZSQDT4xoFtejufAHrpItn2Z7YKsntjvrJZR4H/zQK
   ylit1+2BKclDyjclGsVTCXDJI5tEv+saFSjtlN4UtOSukCn5GiHToznhY
   JzWScAWrtQhXWeJ8HrgYrF1jwstjzwr6ieZ2Q7w4PZjI5tu+BVKRevSQw
   rH0Z0cyOmYxupjmM0y7sI/3inh0LcmPXHeDeXrqrjfh0ytJj4ZAK8fabd
   A==;
X-CSE-ConnectionGUID: /0zfwunzSVaBVb2YPAQSVw==
X-CSE-MsgGUID: 1AA3lZlgRhCjTCMIX2COkg==
X-IronPort-AV: E=Sophos;i="6.19,232,1754928000"; 
   d="scan'208";a="134249998"
Received: from mail-northcentralusazon11012032.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.32])
  by ob1.hgst.iphmx.com with ESMTP; 16 Oct 2025 09:11:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHw+iXX3TwkRvDAQM19QpTr/GHJ0X82Gv3hEvoW89ceyRHBRMsqT7XdMzagCXv4VIP2l5hOVq506Vsa59ZJQe4iE9GCcLnH/lAYSCHEhoZNZTEaq9RTYqVvXt/+XWy7ngphVwmBC+r+uvpKx4GWo1tPqfgtLrMBx6L6Arsm32v42kYC+ouZF5WB7W8JstOMorDASuZiIhz13TLvjgYa+Wf5CRCs/+zGpCRYDF9XWrirVXjsfJB2dQ0V8ccagsVhQcyoTyF622R6dTAzQWaR3cdTzNzQdJjCX5uk537BcVkM/t07e8VBayJjrtvK/FXNgjKQR3JbOh1csXmy8SBCtVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rFv174SLnr9TqiJFPkXS0woTZH5Izm3OJXFTxippB7k=;
 b=aS9BhahBoF547UznXjezcKDCwi8pVmapOyvZUEBZrKVxZL4pwz8DldPIMTvnwVzAZ//RQlK7tfzD8Dod/OW7z8w5uvHNXAXkKFeV1vH0imB+jJ8dGuZKv7z3QkFgUtLCnTAw4DrkJsGYksJlpALX958/m626dfEh3Fdpad5I7RHxqDa8mUkN+jmB0BzFYGMZlRW6sF3oFDtljS27QXtDLZZ9pXGmiWmcrjDo5Sqb3H8IfisLyPUbq+KoDIonBFzX7vzM5lncyWeH7t1BuBGZGIw/oSit6l44fFhrUQ79qDN6R3mOPh+4cypjZ9KMtVFAuadXlaRB6/OTEy9elhyT/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rFv174SLnr9TqiJFPkXS0woTZH5Izm3OJXFTxippB7k=;
 b=vubs0KjL27uEw6DwkdtRf68oBldz1PtnNYgOpdswph49pw2B9+JdbIgm9kVE1JFkCy4FKJelwHFk2pKb6z5ErHopCUx4z4meNvCG5cwQOnI1StPp+C+2cFReii7/4tzxkDAw2kD1LHjFDYOagQo0D5yUtZlk8BiylrCDLjpXWgY=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by SA2PR04MB7658.namprd04.prod.outlook.com (2603:10b6:806:14d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Thu, 16 Oct
 2025 01:11:39 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9228.010; Thu, 16 Oct 2025
 01:11:39 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Dennis Maisenbacher <dennis.maisenbacher@wdc.com>
Subject: Re: [PATCH] blk-mq: fix stale tag depth for shared sched tags in
 blk_mq_update_nr_requests()
Thread-Topic: [PATCH] blk-mq: fix stale tag depth for shared sched tags in
 blk_mq_update_nr_requests()
Thread-Index: AQHcPggJuZXk1S0J80WOnveIWxZ1wbTD95QA
Date: Thu, 16 Oct 2025 01:11:39 +0000
Message-ID: <oeyzci6ffshpukpfqgztsdeke5ost5hzsuz4rrsjfmvpqcevax@5nhnwbkzbrpa>
References: <20251015014827.2997591-1-yukuai3@huawei.com>
 <5c13a5e3f257ceccb70e3d63869d8a9b6d963f6242b23690cff9d9ca7b9dbdf8@mailrelay.wdc.com>
In-Reply-To:
 <5c13a5e3f257ceccb70e3d63869d8a9b6d963f6242b23690cff9d9ca7b9dbdf8@mailrelay.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|SA2PR04MB7658:EE_
x-ms-office365-filtering-correlation-id: d524d36c-a72d-4881-012c-08de0c50f5f9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6SRvGgyk3aiNG8GWRml4EEb1R95ZkWsoDIxSaRZ80wbjgfJiYz6behDITBsm?=
 =?us-ascii?Q?D0tHLxrkDas/G5pVypFrMQ5X8jc9/qsXltu+Ep/XbvBuepHYbjhK0Aj4YNdB?=
 =?us-ascii?Q?6jXjl0TDsnrTQdvr0bzFrQfO7pgrpq5ErzYK0vBag1EpfxNYes9SQ0qm2Cd9?=
 =?us-ascii?Q?C/bZ/yBGQ/jNCfGJnLXJ/d08HA/qa2yZ9268KT/qWjz3f6VDnscuBaleBht/?=
 =?us-ascii?Q?Fte4rJZPLQAH7f2NPWUOwnLIhm7hAdsVVSDwqiephRgwvQjbpzoPZ3oAml9n?=
 =?us-ascii?Q?ImkQTxAQV30Xlv1fHkYG+LF+0qT0DlXWpaRXyKD74rQSROjdyJ6iHTZ96mpe?=
 =?us-ascii?Q?hBlQ37tZdDQdMQ6WdZ7mr6Ze+fjIC6LMi+5bCG7pQ9AEQjCBIMcMAEMgIggx?=
 =?us-ascii?Q?YgRE0ANuGiSqlde7ceLpAo4u8YarCqGUgfWGQF0anuq+urhBwi5nF04OOd6E?=
 =?us-ascii?Q?Pcw+297AAt8eEkGlikt9ZWfSypans/fTDJqnGGL7FBOiqmhys4+d7gZe3TrF?=
 =?us-ascii?Q?bQr19K+gjOJU+nHiHPZoOvp+p/RZsrMJzdzSKN9elrI+XLp4qCnE1RF+90Ib?=
 =?us-ascii?Q?sq9U1kRsokU+ueksyhrwp9oi8shNF6Ov1Cou5OHA64Zt9ao7xZ+VwglP2eZw?=
 =?us-ascii?Q?rBnW8tVbZqVCqDITX0j5KqE41gVOku/wQn6TbZwguYyXzaexLDQ7t9uY2uS5?=
 =?us-ascii?Q?8rWCnFVZdNUDa58wO18ZFXV6m+MfF1LRu8jaYWuetTaqqXdNI4SqOpo5LQnk?=
 =?us-ascii?Q?nmOX4aDmLQU9n1YIUXR9M1BX9VRpx+hfvb668wc+O5BtkvbQmnJ/WGoZPu4O?=
 =?us-ascii?Q?H5Fq+lGAROaqs85MkwMz9Jcc0AxzYGuPCzn4CKSlDmpP3v1HqrWfODjuv//x?=
 =?us-ascii?Q?HZIfZQBUia9YVyyWgbRXM5ItoKeadgi1EWBfTcJp5o6+nW3QxJ3M7bZsMVhS?=
 =?us-ascii?Q?S6H6UnXUIBA0msM2dzOfVOnUpjtFPFx0o0aCM2d9e7ruhlg7kA6nnnxAZaCg?=
 =?us-ascii?Q?8EjDpcDcGozxfjiLBrz0OrjkBvZh4RUysEqTI/Ba0Yg3TgDP2jDnUphWfdQj?=
 =?us-ascii?Q?dO0nrAVitwNUy5pOz+M5dfO/O8CwB+tGqBd8PMQ38VdQa1LvhsRQ+zUU3z1T?=
 =?us-ascii?Q?SPbFJRH6js/hm7TEDnzwKn2I0LKzKfcpq4bEPnlfSR4S12E6aHaaSWNs28NF?=
 =?us-ascii?Q?9/TV3/e2D+hyOTPsbo0kxkww8djzK9n+EwGXv5BOXYRKFxK8NDrDH80NZWEd?=
 =?us-ascii?Q?Y7VJ9Jn4p8tnjZxUeWm1qqsTUD8KVC3Rkf89DjQkG/6mzGp4wegDJ7UZOmHX?=
 =?us-ascii?Q?TOsYqBwBei9eVuZxxTKXFtTO04UkCEY+lB7gyYawndun1BIcyBWK4t7VEqGP?=
 =?us-ascii?Q?xKw3YqzQVnDjHI1Uam81cIBNgAEwYLaVRo7bGya/sN8o+9RVMauSunx73ED2?=
 =?us-ascii?Q?/Jb/jzwSoa1cVXRrSkp+saPQRVTfwpZFV0g0GgC2A4wmmCn1mXanMyvNBQwu?=
 =?us-ascii?Q?62lUkn4En79kZlzhcj1626U33M0D/EBpz6jev2YY5kmkkxZY853W8yKKBA?=
 =?us-ascii?Q?=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?il8jec5mL5Schx+2KG+dEtNzd+1H4wP/E0/zNmCdgcjKprTJsTXYIxJJyhLA?=
 =?us-ascii?Q?CuSACq9cO8aIvFPlRCllynjtIIN+fjD+aKYoo+hqra1DRvwBiIV6BnDMu4+W?=
 =?us-ascii?Q?JVcoOGgRp8H4i7uICjtBr8T/8IoP7iO7jISYVSdf2EeSLSAFve0d0GmvK33t?=
 =?us-ascii?Q?u89i2MT0cLgJwW68K1ImhggJBXdrQgRgslbpenWuLwXLKP+til/K8J/KLUyz?=
 =?us-ascii?Q?yErt+ShF4bisKV7xbueWmevmSF7nrfx2SetkTkWMaScagQKA3VCqx1BgedA5?=
 =?us-ascii?Q?DeY5qGADNgOlNkbIHSfXc2ca6lrzriaUMx1XI/lGmadhbGi1O4/TOtv+4CXl?=
 =?us-ascii?Q?K2kLDfpqb71MdkFK0SX2F7UOD6NdUJjbgyV7K9v3ZcEJntyS0hNYlon3qEKF?=
 =?us-ascii?Q?+NyIjM0lmnGy+yP3rxFAXcy4OWoWCySWTv6WH/Tzq9Xe9IXsWjQPEm7GoCbB?=
 =?us-ascii?Q?LbHYGOglvkABCLaibItAANkYVgF07Ziyi4QOwJvuq40Ytl2Q50PadIYGuANF?=
 =?us-ascii?Q?tPoudpAEnwVL11becy2ASRrkQmAMbBJZgUHxxJ2ZBdR7kx0JYpqZa2OnE26Q?=
 =?us-ascii?Q?PXoqZWbyH6iCChaAoelyhTbETf4jucpT1ybMdaVJy1f4xsP5jieHGtqFidpa?=
 =?us-ascii?Q?acxI5XSW+IfsbzbzLIRWnBprPbRJaY0uzxw6JKvf3l4GDGWBnmG4ZhH7SpuN?=
 =?us-ascii?Q?StyTGh79Udiifkca9IZcigDaKer+V1HPXbdVb4dAUOaU/TLGk+nu0j3zF1on?=
 =?us-ascii?Q?f4hw5yhmpm/LzxnQrRBYinnoDZ1ln7DSyywC3Qe/ZkuXA4BFrycLY3zXgm+R?=
 =?us-ascii?Q?dtqnYge8dg24vQoNYkfwBArHEHnASDspAT+FTWgL66NwVjxWo8umyLSZXzbD?=
 =?us-ascii?Q?YYtscI9QrSXntsD//bjVIwkSMYk2ngeRpl2AXbtYvuKcZL4vGAtelzQQHczQ?=
 =?us-ascii?Q?s82+D3dQ9cxh2HMnmfZ+2CKn9LwE3ROrER/GpFbuyWnwx/T7HF/vhws1O4FI?=
 =?us-ascii?Q?YGgtRMqdJQoXD1Dv06h3+x0GjIo8j75v6+8hjeOKUWq3iOSIZ46ZCPBNvoLY?=
 =?us-ascii?Q?mlosxw4LDs1WQyDZ4PCULl+YZABMvn/6HRt8XlWXb7bCQCvkUpui6YZQM83b?=
 =?us-ascii?Q?78COYJKvRvJI1sH3lfWDI6oXDWtvSoGz2A7QDkTpiGdy3kqZHxa5FOnbLIyM?=
 =?us-ascii?Q?A7W2cD72zp4gchoPty3DsuJBNbuUb0/S6hTdR1O+5TXEdGHJhQ1m8r6fRj4z?=
 =?us-ascii?Q?6Cm4xNIm2ujvKdsPEPnNyXf6MZmNWf1sLcYWwC4fFJtuctRlsk7t1piPm7Hk?=
 =?us-ascii?Q?XWu8mOZ5IOTY0rjbQMNU2X29F2JZhlJgo3wLKoIThhfnvvIdcEFPv+y7vICi?=
 =?us-ascii?Q?Q/bgV7u/AinLXo+fR03vz32CNd4mnkKfBo5u7lKJcmjqsBfQr3uhJ+JauFpQ?=
 =?us-ascii?Q?+iPWWna8JxNG4uRpvMFQWjlizYog4GObgY2BasVd7Ylop9zX+TBZb40EVtyj?=
 =?us-ascii?Q?RsFXQnpW0NJxFY3vJPEqX9elOl7E6O7iyF7eMUaOQ1kebyiCA8SsOg+PPtgg?=
 =?us-ascii?Q?xjXU+o8go/YU6fSastGHUD6Yah2fB6vNUuXcl+nFcJjbetM0AOILp3koZQV+?=
 =?us-ascii?Q?QYxjYizOfgkvw9Gn19JwZH4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6D657EC941F29A4CB371A74E9A8F3633@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zUowKgRIGiDgQ+t4vScN2bXqZsRbKv3WM+1+gUE5R3he7WQPh5H/E1j6ed15NsTQeKjKay1DzPE1HDA1upcHi04D26csDCOAhFtno9pW1SdhKcacEbqA3dDLfWxiZHgu7ZgCw699IXgDqZNqNhfBwDX6wNKurGAyMXHegxAyhNfGOVOQ6dg6f8a19PxuzaxyAfyy2y9ieJJ+V9oo0FQv68srCOBpadNf0UauOJ4r8GATisqS5NGzitYrmrmgygKrOfpUHqY51Y17M5P+jZLuRa17ymkLZtfOLqiETVWXaRVvPtKslj+sd5s7omMt2Hzy75+8EyKv6wLUROm92mC4KE5vDU0Y7IIxFRSrCq3AVizD2wbpM2YsGYi5LnFSJmKMsUkiWTi3eqSmRh+i5rKUO1VTIecIBLbYKwz7wmO7IBVXRK4AqHyV1Nv3NzMqq4EWuxOawOEW1bfSulbYXvlzzYIM4pvEe9nxDKtALaMsQPGmJPh3hcJbEj09Eh1wKr3EZKUmb0XoSeMbGWaHqpICVmXKL8LXwMxEDViXE86px++4VuccWdWzFaM+0rw+Uzm/0dm8Uu7t61ywwW1JFtJxMN6kwNBUvS/Is6tr2/puo+IbDII7cLXymvgt2VPG5fFL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d524d36c-a72d-4881-012c-08de0c50f5f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Oct 2025 01:11:39.6412
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RrPLBVY8byY1ngRB25rhrYp1rjpbQ7CMR3Wqnys+MJZshzKMAj3dOk2H027dqURRDee2oLZknlfT6cvOJncEgM962lmCjvHIiV5cNMTyepc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR04MB7658

On Oct 15, 2025 / 12:15, shinichiro.kawasaki@wdc.com wrote:
> Dear patch submitter,
>=20
> Blktests CI has tested the following submission:
> Status:     FAILURE
> Name:       blk-mq: fix stale tag depth for shared sched tags in blk_mq_u=
pdate_nr_requests()
> Patchwork:  https://patchwork.kernel.org/project/linux-block/list/?series=
=3D1011590&state=3D*
> Run record: https://github.com/linux-blktests/linux-block/actions/runs/18=
524669753
>=20
>=20
> Failed test cases: nvme/057

Blktests CI tested this patch and observed that the test case nvme/057 fail=
ed
with the loop transport due to the lockdep WARN below. However, the failure
symptom does not look releated to the patch.

This failure looks new to me. Actions for fix will be appreciated. I will
disable the test case for blktests CI.

[11280.536805] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
[11280.537957] WARNING: possible circular locking dependency detected
[11280.538987] 6.18.0-rc1 #1 Tainted: G            E     =20
[11280.539846] ------------------------------------------------------
[11280.540751] (udev-worker)/45976 is trying to acquire lock:
[11280.541614] ffff888100cc2148 ((wq_completion)kblockd){+.+.}-{0:0}, at: t=
ouch_wq_lockdep_map+0x7a/0x180
[11280.542862]=20
               but task is already holding lock:
[11280.544086] ffff88812bc63358 (&disk->open_mutex){+.+.}-{4:4}, at: bdev_r=
elease+0x133/0x610
[11280.545176]=20
               which lock already depends on the new lock.

[11280.546881]=20
               the existing dependency chain (in reverse order) is:
[11280.548140]=20
               -> #2 (&disk->open_mutex){+.+.}-{4:4}:
[11280.549314]        __lock_acquire+0x56d/0xc20
[11280.550023]        lock_acquire.part.0+0xb7/0x220
[11280.550746]        __mutex_lock+0x1a6/0x2110
[11280.551469]        nvme_partition_scan_work+0x8a/0x120 [nvme_core]
[11280.552362]        process_one_work+0x854/0x1460
[11280.553087]        worker_thread+0x5f3/0xfe0
[11280.553785]        kthread+0x3a5/0x760
[11280.554463]        ret_from_fork+0x2d3/0x3d0
[11280.555191]        ret_from_fork_asm+0x1a/0x30
[11280.555918]=20
               -> #1 ((work_completion)(&head->partition_scan_work)){+.+.}-=
{0:0}:
[11280.557334]        __lock_acquire+0x56d/0xc20
[11280.558061]        lock_acquire.part.0+0xb7/0x220
[11280.558818]        process_one_work+0x7ed/0x1460
[11280.559600]        worker_thread+0x5f3/0xfe0
[11280.560339]        kthread+0x3a5/0x760
[11280.561024]        ret_from_fork+0x2d3/0x3d0
[11280.561753]        ret_from_fork_asm+0x1a/0x30
[11280.562504]=20
               -> #0 ((wq_completion)kblockd){+.+.}-{0:0}:
[11280.563805]        check_prev_add+0xeb/0xca0
[11280.564547]        validate_chain+0x46e/0x560
[11280.565302]        __lock_acquire+0x56d/0xc20
[11280.566084]        lock_acquire.part.0+0xb7/0x220
[11280.566885]        touch_wq_lockdep_map+0x93/0x180
[11280.567674]        start_flush_work+0x67d/0xc10
[11280.568446]        __flush_work+0xc6/0x1a0
[11280.569175]        nvme_mpath_put_disk+0x4f/0xa0 [nvme_core]
[11280.570040]        nvme_free_ns_head+0x23/0x160 [nvme_core]
[11280.570907]        bdev_release+0x3be/0x610
[11280.571652]        blkdev_release+0x11/0x20
[11280.572397]        __fput+0x372/0xaa0
[11280.573118]        fput_close_sync+0xe5/0x190
[11280.573869]        __x64_sys_close+0x7d/0xd0
[11280.574617]        do_syscall_64+0x97/0x800
[11280.575355]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[11280.576194]=20
               other info that might help us debug this:

[11280.577944] Chain exists of:
                 (wq_completion)kblockd --> (work_completion)(&head->partit=
ion_scan_work) --> &disk->open_mutex

[11280.580191]  Possible unsafe locking scenario:

[11280.581402]        CPU0                    CPU1
[11280.582143]        ----                    ----
[11280.582892]   lock(&disk->open_mutex);
[11280.583583]                                lock((work_completion)(&head-=
>partition_scan_work));
[11280.584656]                                lock(&disk->open_mutex);
[11280.585537]   lock((wq_completion)kblockd);
[11280.586260]=20
                *** DEADLOCK ***

[11280.587885] 2 locks held by (udev-worker)/45976:
[11280.588645]  #0: ffff88812bc63358 (&disk->open_mutex){+.+.}-{4:4}, at: b=
dev_release+0x133/0x610
[11280.589732]  #1: ffffffff9f31f100 (rcu_read_lock){....}-{1:3}, at: start=
_flush_work+0x34/0xc10
[11280.590827]=20
               stack backtrace:
[11280.591935] CPU: 3 UID: 0 PID: 45976 Comm: (udev-worker) Tainted: G     =
       E       6.18.0-rc1 #1 PREEMPT(lazy)=20
[11280.591943] Tainted: [E]=3DUNSIGNED_MODULE
[11280.591946] Hardware name: KubeVirt None/RHEL, BIOS 1.16.3-2.el9 04/01/2=
014
[11280.591955] Call Trace:
[11280.591968]  <TASK>
[11280.591973]  dump_stack_lvl+0x6e/0xa0
[11280.591982]  print_circular_bug.cold+0x38/0x45
[11280.591994]  check_noncircular+0x146/0x160
[11280.592005]  check_prev_add+0xeb/0xca0
[11280.592013]  validate_chain+0x46e/0x560
[11280.592022]  __lock_acquire+0x56d/0xc20
[11280.592030]  lock_acquire.part.0+0xb7/0x220
[11280.592035]  ? touch_wq_lockdep_map+0x7a/0x180
[11280.592042]  ? srso_alias_return_thunk+0x5/0xfbef5
[11280.592046]  ? find_held_lock+0x2b/0x80
[11280.592050]  ? srso_alias_return_thunk+0x5/0xfbef5
[11280.592054]  ? lock_acquire+0xee/0x130
[11280.592060]  ? touch_wq_lockdep_map+0x7a/0x180
[11280.592064]  touch_wq_lockdep_map+0x93/0x180
[11280.592069]  ? touch_wq_lockdep_map+0x7a/0x180
[11280.592072]  ? start_flush_work+0x5ae/0xc10
[11280.592078]  start_flush_work+0x67d/0xc10
[11280.592087]  __flush_work+0xc6/0x1a0
[11280.592091]  ? __pfx___flush_work+0x10/0x10
[11280.592096]  ? srso_alias_return_thunk+0x5/0xfbef5
[11280.592099]  ? find_held_lock+0x2b/0x80
[11280.592104]  ? __pfx_wq_barrier_func+0x10/0x10
[11280.592118]  ? __pfx___might_resched+0x10/0x10
[11280.592126]  ? queue_work_on+0x8e/0xc0
[11280.592130]  ? srso_alias_return_thunk+0x5/0xfbef5
[11280.592134]  ? lockdep_hardirqs_on_prepare.part.0+0x9b/0x150
[11280.592138]  ? srso_alias_return_thunk+0x5/0xfbef5
[11280.592147]  nvme_mpath_put_disk+0x4f/0xa0 [nvme_core]
[11280.592166]  nvme_free_ns_head+0x23/0x160 [nvme_core]
[11280.592183]  ? srso_alias_return_thunk+0x5/0xfbef5
[11280.592188]  bdev_release+0x3be/0x610
[11280.592197]  blkdev_release+0x11/0x20
[11280.592202]  __fput+0x372/0xaa0
[11280.592211]  fput_close_sync+0xe5/0x190
[11280.592217]  ? __pfx_fput_close_sync+0x10/0x10
[11280.592227]  __x64_sys_close+0x7d/0xd0
[11280.592233]  do_syscall_64+0x97/0x800
[11280.592237]  ? __fput+0x504/0xaa0
[11280.592242]  ? fput_close_sync+0xe5/0x190
[11280.592250]  ? srso_alias_return_thunk+0x5/0xfbef5
[11280.592254]  ? fput_close_sync+0xe5/0x190
[11280.592259]  ? __pfx_fput_close_sync+0x10/0x10
[11280.592264]  ? srso_alias_return_thunk+0x5/0xfbef5
[11280.592268]  ? do_raw_spin_unlock+0x14a/0x1f0
[11280.592275]  ? do_syscall_64+0x11b/0x800
[11280.592278]  ? srso_alias_return_thunk+0x5/0xfbef5
[11280.592282]  ? srso_alias_return_thunk+0x5/0xfbef5
[11280.592286]  ? do_syscall_64+0x139/0x800
[11280.592290]  ? srso_alias_return_thunk+0x5/0xfbef5
[11280.592294]  ? do_syscall_64+0x11b/0x800
[11280.592297]  ? srso_alias_return_thunk+0x5/0xfbef5
[11280.592302]  ? srso_alias_return_thunk+0x5/0xfbef5
[11280.592306]  ? do_syscall_64+0x139/0x800
[11280.592310]  ? srso_alias_return_thunk+0x5/0xfbef5
[11280.592313]  ? __x64_sys_symlinkat+0x165/0x1f0
[11280.592322]  ? do_syscall_64+0x11b/0x800
[11280.592325]  ? srso_alias_return_thunk+0x5/0xfbef5
[11280.592330]  ? srso_alias_return_thunk+0x5/0xfbef5
[11280.592333]  ? do_syscall_64+0x139/0x800
[11280.592338]  ? srso_alias_return_thunk+0x5/0xfbef5
[11280.592341]  ? do_syscall_64+0x139/0x800
[11280.592345]  ? lockdep_hardirqs_on_prepare.part.0+0x9b/0x150
[11280.592351]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[11280.592355] RIP: 0033:0x7fe0e347aae6
[11280.592361] Code: 5d e8 41 8b 93 08 03 00 00 59 5e 48 83 f8 fc 75 19 83 =
e2 39 83 fa 08 75 11 e8 26 ff ff ff 66 0f 1f 44 00 00 48 8b 45 10 0f 05 <48=
> 8b 5d f8 c9 c3 0f 1f 40 00 f3 0f 1e fa 55 48 89 e5 48 83 ec 08
[11280.592365] RSP: 002b:00007ffe6ca41920 EFLAGS: 00000202 ORIG_RAX: 000000=
0000000003
[11280.592378] RAX: ffffffffffffffda RBX: 00005640c8945570 RCX: 00007fe0e34=
7aae6
[11280.592382] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00012
[11280.592387] RBP: 00007ffe6ca41940 R08: 0000000000000000 R09: 00000000000=
00000
[11280.592389] R10: 0000000000000000 R11: 0000000000000202 R12: 00005640c8f=
5f920
[11280.592392] R13: 00007ffe6ca41ca0 R14: 0000000000000000 R15: 00000000000=
00011
[11280.592405]  </TASK>
