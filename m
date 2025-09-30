Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0B0366
	for <linux-block@vger.kernel.org>; Tue, 30 Sep 2025 00:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759191832; cv=fail; b=gJq3xJYjG6I2nrEPO/mPRkSjRK8yKuLbbfC4Pe8uaoLeT54u/egXOhe12RgZsdlXoWrCyBbwUsWRvJ/DhrUb96uxe8waXOaazQ85SaNnj2V4aRCz32jRLcESd7UiQ9QYjmXVjOrJt1Q4u49QIVOECw7Dn475VG89wbqcAAfM2rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759191832; c=relaxed/simple;
	bh=ZD/es+mCIEiizmAr1KCI3u1F/DhxXCp64cbEiPFpoLE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LgLE1EDPme0CrHnY711YaJP1++wccArt0lrLrnRphkyd6cCA9HPSrUjbGfqv5+YdkxFkzSOq3DJqkS4smGMU9XFLb3DFEHYbibbb5vzmuglPFSrSSP/ZVm2urktXqIWROYgFutTjBqTyFtDmEDc/+qRFajzxX1aws0WrE1IyQgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=ec4ds04l; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=csos/PMx; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="ec4ds04l";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="csos/PMx"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1759191830; x=1790727830;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ZD/es+mCIEiizmAr1KCI3u1F/DhxXCp64cbEiPFpoLE=;
  b=ec4ds04l/qTxVRoKBzmgHI1SlqCyiVCpTKu/PtujEMsHQsY4eprmTWD/
   oSJWXMjaTMDUvAy8FxlemMJVZmkL4Jjr99Cf84ZZIpqdLb7VbwRyp8PtT
   seqadRt5PlKSordXrXK2dTW7FbT6zqK4yCPzvQcQ6arDDPb49PxyuMP0T
   LMoRKnEszBHgAzmHrjDkQbsZcRhKpv+gWwZsQosRp1qMdq+R/gTotS5nE
   5Ix9NbBk3BmLhCo0erHIqGSi5CV33f0VnLPD83dybmBOaAjWr5U+C7sAJ
   /RoiLqSRukTjV6EKyb3Oej1QYKKUx1Hp/KTHOOVBik1wV13lzbsPy6bLe
   A==;
X-CSE-ConnectionGUID: o6BLe2lnRRi+wrGBrR3EZQ==
X-CSE-MsgGUID: J9O+IE/pQ9igwaJwmn+WOA==
X-IronPort-AV: E=Sophos;i="6.18,302,1751212800"; 
   d="scan'208";a="133062139"
Received: from mail-centralusazon11010021.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([52.101.61.21])
  by ob1.hgst.iphmx.com with ESMTP; 30 Sep 2025 08:23:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEVnwfu+f7XyPxSqC6GBS4+8jwFU1rWXO3D2moGJCtYzsh6VYggT6TqsjsDkGZE+V3sOYu/bszopSC3nAl5OH4zZt61LIxZvwL0ib2PxITRtIHK6FGSHo75suiOXQgqU5MfuQ4CaSCRGAoYcNyIxnrHBx5lQ+kSapcUqbxYWIANimDf8BmUk/TK1FTmkerj85aLpIy/cS/ZGCgD/bMrtCKoifiG0rZy3pCTtu5ZcvcP4WeK79CGE1tMMhJzlpKHPNwSIxP+6iGdYRVtubxvS3fQKLvBRVwiB4N+hDpjJBTnykKVJnhcoN2sFuFF+1NkpAhqm2kzCaCizDYu95ZfzuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZD/es+mCIEiizmAr1KCI3u1F/DhxXCp64cbEiPFpoLE=;
 b=burJwVGXYmMmgy7ah3NT/WQjLUu660nP+xkvKnj3S6pWJzVPAHgdGbr0D7RMQ0Rco2Mg8R5xrm+yzldv0C0N9mHhphzaIRT6rKKQrWMJt+EqoSv/KN7giUM3uE8PLekvvasPslJ8OL5OK+uhQZ50JZpoXngcaQTXN6ePr9KGT7HrUJXX3KJMNoU2tm5T9s/wcOfbHwL18SXOw/VEO1nSeSD6JIZScujAnNCbSHaBb1bN1KBMKqN7a/UzXOw3lcRuzK1d/PqhSSR9Z6z3j1JTKftYnKsQfSgyCGPv9ZCW8C74M1UKXCXRXiUHdYbg7PLUfPkrhGUBva0fZ8MS3+gxVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZD/es+mCIEiizmAr1KCI3u1F/DhxXCp64cbEiPFpoLE=;
 b=csos/PMx2yldiDeAf8jRNj0SZP5gaYpFUZe7kHy3Fa7fS3idSCF+5PPKyyHfE4/RK+fxEu66scaySM/b4sE8xm+cpf6E8Uk71Y5HenicGyx7n4/AIqXyhfWv7yzZcwfinG11wphtusHJv0S/TF1tsmTXqfytNUZLqJnt7J3ANNg=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by DM6PR04MB6474.namprd04.prod.outlook.com (2603:10b6:5:1e5::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Tue, 30 Sep
 2025 00:23:41 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%7]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 00:23:40 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH blktests] md/rc: use --run option instead of "echo y"
Thread-Topic: [PATCH blktests] md/rc: use --run option instead of "echo y"
Thread-Index: AQHcLpdTUe3q701Qo0qMVsb2wA3WmbSq48GA
Date: Tue, 30 Sep 2025 00:23:40 +0000
Message-ID: <lz7f7ttzllgj5jj346r7lswq6u2uyclggx2acenxqg2y3r3tth@q6m4avhzcka7>
References: <20250926034033.176349-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20250926034033.176349-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|DM6PR04MB6474:EE_
x-ms-office365-filtering-correlation-id: 26a14837-7ae4-4388-6637-08ddffb79b4d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|19092799006|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?aKJ4t+bNTyeSYUcmb1st8e+pG0BBqJPSt9/OrsQakxK1SRoJiRkfvHY5173i?=
 =?us-ascii?Q?9zm3fMDqbIHMYHtK7myHwbyMexzOsLMVf4e4+2oIFdq56JRDb7g1y6bY24+l?=
 =?us-ascii?Q?/0sysXgcshtuEpEXYPYv9X80Yy8RW+mVuQmqW4j1I1jLQx3/0uQzXnmswzKj?=
 =?us-ascii?Q?GtYfwXdZnl8dYN7B04U7OtVXp68b0js+nks44I4bHZNsb8E8bdurOllb+e/U?=
 =?us-ascii?Q?0yYik96t4hAAlgxw71yypp22lPXpwDtKcawHsDl57ycKAA+sDTcGrHYXuH98?=
 =?us-ascii?Q?LrU3sJQ8KlTc4NOEuOk58HxnIXX2LPaeUXJp/dxBDErSphXW9r0E36j61jUv?=
 =?us-ascii?Q?j+G0SlmSpZ+3xBAqvkdbhEWgWYyrccRYzTB60gFwV+13hYUNy4tGZXSneHTq?=
 =?us-ascii?Q?17+EKRtxoOxBragB4fZGS/kOgKNt+bsb3qfmTyS7ELhhHKZFMAbF04gpDp19?=
 =?us-ascii?Q?PQ9h58j7YvhQCOz3XDgOpP6kX9qhFtSKpx8k3M1WH9Dv8A/sNDHlTb4yrjrT?=
 =?us-ascii?Q?6e1ghzHMJiV2XfiArEgsUZWWtCi0mz1siL1emUkXRIQuRqZ/gDkM/MpToWuH?=
 =?us-ascii?Q?bkHr4/z+ytzsSR/ZD24BKFfWwbIE5YM/BnjbVKfgycA+pPCugtyinjDK6JY+?=
 =?us-ascii?Q?TiTDHHSJ8ZOiVAuG7WflNTq77xH+OfXjVu2TAHeH5DQG8C7ijUpzkXWQSZRf?=
 =?us-ascii?Q?z6m9XyXcZN64JSGiqvlUQfNw8eNkRdbvBgqFr+2riXzctuxPpZ9jLHcnk+6U?=
 =?us-ascii?Q?/bNpBcp7Hl1FUADUpqw0ySGRZVNompuYjOqOiUH/x/8TjNjV9A9TlOTidA4N?=
 =?us-ascii?Q?NijPwiBkbI5sinhB7bhy9KN0WS3JzDBsTbEJRLMhCX9V2VvXAxqlxpst9oaq?=
 =?us-ascii?Q?AeDHaxwW2hloGmZKRiKHAhtxO491Wg9ISAN2zM6+o9IrFwmQF5uo82BbRKgM?=
 =?us-ascii?Q?Iq+CAo+6q/ZqCFs4FhHaJPjAVYaDI/JbQC7E96VKco05z8y+u0OVRVMVsfEH?=
 =?us-ascii?Q?wzSZKf9Dj2Xijv+0EBsPHt2gQtUlxxLR1NTPUt/PiUOQAe6npHHG9UVlFCfM?=
 =?us-ascii?Q?f+xeRFjaGlbrT29TohZ4gWiC8oCFEydHb8rW9c+7WVmrbJCtm3GId+hpnh77?=
 =?us-ascii?Q?6IZut5yngLtjTmtkmu0joemH+AV2ZapfWZZtCxB31CL0J3MfVD9AK8BB/i67?=
 =?us-ascii?Q?jU889zsemYBBm/LbFoFJ0/VK7GdEX5YO6FGHuiKp2+KSNdN9yF16OvloqqcN?=
 =?us-ascii?Q?tBubienmEZ6AgGUSiMUFs/PHWJKHouIp0b3iQxN+K9Rp6EsRNmFpsz8qqy4w?=
 =?us-ascii?Q?+xTa39QadBkCqZEixn5VHpdTxJ2xuhJam5ftEvp4R7+Lx9NKzQ4dHGutTs5F?=
 =?us-ascii?Q?/P2DSa4imwIZk7tSNkw5p5A5sSlRWKnfZ/4/zED9vdwryaBHGSA0Lt2YqlYK?=
 =?us-ascii?Q?l1MhK9dfCpJUnXHXf9bWTAAn0r0a17KYikN1vgB8+o0wjUsh9Y26yx9o8BPZ?=
 =?us-ascii?Q?X8/omgbKSC2b6t9wLYS93dM+r/kyaeSIYxn6?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(19092799006)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Yi0BmI0+tr6/JnrAGFzDBzS1xfkawj0AcyobCLc3VkYqGn18Ki2LP4F6SZKh?=
 =?us-ascii?Q?PGbNavf0vt6NvFO9toK1TrbDTMrRxryb47b/blSTOwzDO8WL+r/pO85WAmms?=
 =?us-ascii?Q?VmPs1hP0TomBavKtjCo/dqBW6c0br2la9Q2JO2+XDIEAKb+ToPgR8zU30qfG?=
 =?us-ascii?Q?/e3CvZgF2yWqMbPNHWkWtC6jHzrx77b48rb2VJ3NTY8h/YKYxJipkEtz221b?=
 =?us-ascii?Q?OzUgbeAksURU18jbqLdsFMX9aPgqXgBmWaXmSYfFtfDHZZEZ50ZuBHgKcJXG?=
 =?us-ascii?Q?KEBaV0NotyfmOzlOMFOrf/Dh0eZ71sH8PY3WS6i0cD+xdSOjloQtBPmeZEUg?=
 =?us-ascii?Q?9gJtGNPz7AJepioykLeG9eLw+/2aJkufh3eqzyLIEScHKdha8ogD1w39V/3f?=
 =?us-ascii?Q?7SemSgn44Sl0d/W3bNQ2kbs8K3QebmM7jlg7Te9skM89XovjYs6USqrsm2Kv?=
 =?us-ascii?Q?eoLLUgAxvOKZIoyNFwHz+WiWTCOJeqvCi+hlhewrjTW/H1nqqrl4JvuJL54q?=
 =?us-ascii?Q?YmJLj16o+1h7orzQD1HyBtovRkASZYICAwCnrDktT33lD3wydk+nbYwuRxJk?=
 =?us-ascii?Q?iF4YmvgMx1otAZQ+BozJqoIIfE9rDr1BCc+unzjkwqhPxOsz6baAT/sx41Ey?=
 =?us-ascii?Q?hzfeXarlnSn0KHvBhTArE354o9HH/PKBnZTD52tii3xUEV77SwyOTyCT2Vdk?=
 =?us-ascii?Q?8qIaOwUFSQ9b3IiSRS2+W2zxrCPmghBSTgsx6DNw7oivxMlPj1A3gUz7thd2?=
 =?us-ascii?Q?78hbnbkr3sjiflsgngcAv39s1j4j6vfp3F10ZzlOTuA8LQPmr9TXc51PJmFR?=
 =?us-ascii?Q?q937hLlSQJB0v3kduCKGQj6rQx7wdPqcGC7lum9kbrvbOrU2nmYmt+t2ySCb?=
 =?us-ascii?Q?ORW9ZH5mO2cSYuHtkYilE7xLlG/T6snvzE3+RPX2ssNgrZpH39MjdkWFB0vE?=
 =?us-ascii?Q?zblr1R59LJ0RjLW0SX84qEFtEukBCq9AaKZuazUphv1ORi/heneQSMtVpTWr?=
 =?us-ascii?Q?+JR8SAbeZxT3z05GsYFA5mVJ5LqfjrdzsVYyrvND0mJTQj2QNOKJvkZewVDo?=
 =?us-ascii?Q?el/0NTrPAzr7D4+QCr4u3pk9bCXtZaKJ40cUD7ch1t8AxjwOj3XMQ1KCAbEP?=
 =?us-ascii?Q?XTQIrSRFO+AHDJ19hajTqQNZWEGMDI17D1I0Cwd9zm0KU/TQbr+/KbXIGiE6?=
 =?us-ascii?Q?BTTNuTrhk2GxYMSKfQlKctOkDKvoanOk6B+wy18MyiWEWDwUUYGvRGrUvE98?=
 =?us-ascii?Q?5ZZr1vo5D5GaEf8ZVzVoHWoRvQIWBqryBFiCGzg5mKnEd35Pl1eIlZZoUeDu?=
 =?us-ascii?Q?QLik1vRw7PLUI+MarMBaZIB27mAQ6yP7Gmocy3zLeZdvuOJC4nDD/YVtxBVe?=
 =?us-ascii?Q?NWAg1OCEdqwex+lDbNBV5ye/UW+PEdxxBGtZrT9dP5AS+7eRh8jxGxp5rDmN?=
 =?us-ascii?Q?FrJuPYGrrKka823AMNwRIEh1NHVkXbB+SIE2nNSwteDCV4k4xKFKHX8Ivo/K?=
 =?us-ascii?Q?dmhvxpZIn05MH1VhkWckodJ+FgTubWxwVMZr5r5a0k1T4QcnYecrNx3ZOV78?=
 =?us-ascii?Q?2JoJAFkU6jeidxbhL0Do/Psq+BFV9UBp1EIcqvb0txwT92CeR+dwqPju+JAr?=
 =?us-ascii?Q?iG0OGhQCpPHBFzq9fH1hqyk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0FBB12DE5CE40940947CF4531A259C8F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6AQeG8xs2d8xPpZGSquBZWMq3qO1AGS4bpCw9bCQ75N9X4nhsRDoucTYp7aGru4uQxe+lsgNJjP07W4IbQ5zrZD8ZnAbkL1dmCZPQVvZH+rKmBDM0Neg1fRpwzwNGMT7dE/jSq5oPaz/bbPYUCDo8PuV07ERciZ+r00nzlvgzIj/b/8La18T5YVlfkzCxxmvS1PuF7gBBxma9H3jshNOwlQfVr3UElk7LU8fiIx6ENO+9ztPp41ChGYQrQxvrva86VHATSHjjzMI6uGK1/6Iye+ttsjd0YAEZp99f7yeitK7vxKkf0Na7sBVwirv8dXhmY5wtkRhCA6PXd+WAYMJ7HvsXZduL13o6HwLDOCKFtAkjP7OGAOkGuJUDB16nzhWVvILguQEFJx4rLhCevCu49+OnXIqS/p/GWL3+AWIwymcvQzG0kLbRO9PUDyfayH/dvi6y5Y5YwcGLNMNZQps2UzBSxY9WQ8uB2Kg4yXAS3zO7nYAbtBiTUZ2qdFonmlTE383rpmxeAjVRT+FlsdjjkCEFm+J6WAvNGZPNuMtvpp8sAYeu3PUigMbtQm3Nc8yXAJ0fp9Shom4EgJv1FLV3CP48dM5LCcM8MizLHmEACVD26yaIEP1uDhN+bOX03Wg
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26a14837-7ae4-4388-6637-08ddffb79b4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Sep 2025 00:23:40.5967
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MzxKpopAjJ2bkfs7BLdBEJjsxXUm0Rx1QPU19WGFqPhvxLrdBiWWMun5TZpqeloG6L82f8F4/wwAAygbiEN3Gkdu28gExd72gYs56JwdnqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6474

On Sep 26, 2025 / 12:40, Shin'ichiro Kawasaki wrote:
> As explained in the commit 0e7aabe55e8a ("md/002: use --run option
> instead of "echo y""), "echo y" and pipe no longer work with the mdadm
> command since mdadm version 4.4. The commit fixed this problem. However,
> when the commit cefc4288c469 ("md/rc: add _md_atomics_test") introduced
> the helper function _md_atomics_test to factor out the test content in
> md/002, the fix was not propagated. Then, md/002 and md/003 do not work
> with mdadm version 4.4 again.
>=20
> Fix it again by using --run option instead of "echo y".
>=20
> Fixes: cefc4288c469 ("md/rc: add _md_atomics_test")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

FYI, I applied this patch.=
