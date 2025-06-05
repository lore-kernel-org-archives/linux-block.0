Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A51B202F83
	for <linux-block@vger.kernel.org>; Thu,  5 Jun 2025 12:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749127976; cv=fail; b=cYeX342c3vPjlt64Q6b2j8O3DutrTFuYQ11cLPNX1sd119QiIWrh1T4wkeen2UH+6i/tD0JFYAZlVi3HU0kCn1hGD6ePGWVZGaGrGwjDLKnPP8XGgtNzwYvC9Kv5zIMcJ36QxDoKGfbN6kxaFyRvsO2kjaXsYAqHmZqUTeRB6QY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749127976; c=relaxed/simple;
	bh=P5rP03E5O4g6PQzTHc6sWB1S75mdulnmGw6s3JCZ1mY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=OHE8hIdXuplm+thJwO/d7POTlbiSxN4Jku3V6sPIdhrtzvE4maodmhDn+0RFo9xL5ZbaGlUIsg4iU3mxZBvN4oCbATS7EcicLUmML8HTBCJ1hdfW2CsRmHCZ0vBFK0hVVzxzLw8xq0eGCVWs8KI5ptD+BwknbfXtldWSUN0vbzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oMcFJ+yH; arc=fail smtp.client-ip=40.107.94.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oMcFJ+yH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tvH2ChfOtcWO3aLTd6z8Zpg1k4bTrEJDd/gqiB0KqFNrRg7La1HCQk7KgX+D8Dgry9j9RDTsgvyo4YIQ5RrkFQdxR0IrI3mR9okTs7xHzHXmUyAgzzYV0TFfLhJF8YenZsYrbrhEmGVg6HzmmVdaKIWW7jWZazgYJnAH8zZHNMNo8XthKkFZM1nw+8BMFeicFRKMa+hVdTAjcsTxLD545VOxAk58yJN0oVfPW2JNK1kTnHqrvCHYyfY2VzPMjujF8sA6qdzaTHMugFkfE+5eV4q4INvruKFe8W1tuhWjzlNlyL752n6ml9zTEwE0UIkSQ/dSMx7XT759QxRojn8s/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5rP03E5O4g6PQzTHc6sWB1S75mdulnmGw6s3JCZ1mY=;
 b=HGvYtNRfZATRDq/z333bP70zdbI4bX5nJRlPsUyNmC+S//mSHk6dUrTwBJROouF1zOtxc8s2NcFKBzz53aSqOKj3/2LFTwHvsluX1i1WdEX3IkhdV2NlyXeNn5ev6gXV8Zx5UEY8UDkDYpPDbud8xqRqBXaMPjK+sOgVXSZ3RzmfN7JsLaX2nmHuQlGc5otd7fORlQp0e2T3ycEDHzlf0Trob+DNYAanXglmrjTi5cqOA9OOiQOOjS9gcW4ha6q1BBXJvAA4YrhBjHrRbDazHke/th5Sh551VqXx2U5ozgy+F1DyAeYri37bpsrwniK6f+uKkh42k1Kn9URZRS+7VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5rP03E5O4g6PQzTHc6sWB1S75mdulnmGw6s3JCZ1mY=;
 b=oMcFJ+yHWD8oXLt4xZt34mGXz9P6BBd1O/g7EQ/jAAVxNlbLCkhL6WisxhZAeBGhW6Vt9cij0wJMN01wIGefvZ1Uljoix4oWZWNeGdNqa6OR/BSe/nv6H8VQ8wJDcoekJmnr3PoLhdq9+T3D7nLip4QcEySXhZbqd4oFs4FKTsncKwi4mieYeToFUrvl4gSTn1S+z1dKyth34Yjh2dkUPo/ZSV7B5mKr07uzrYqkMX7fsivP+/y6cWxmxWz0UVhRfsmn7Kx/lGItLFiVUa1mEG7kUVlIND9EPt9CZYQk+Di2SleWwdJ/t9URzZ+J6QrsniAbA8X1bug52eONr648pQ==
Received: from DM4PR12MB6328.namprd12.prod.outlook.com (2603:10b6:8:a0::16) by
 SA1PR12MB8598.namprd12.prod.outlook.com (2603:10b6:806:253::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.29; Thu, 5 Jun
 2025 12:52:49 +0000
Received: from DM4PR12MB6328.namprd12.prod.outlook.com
 ([fe80::35dd:a6f9:6b74:3caa]) by DM4PR12MB6328.namprd12.prod.outlook.com
 ([fe80::35dd:a6f9:6b74:3caa%7]) with mapi id 15.20.8769.029; Thu, 5 Jun 2025
 12:52:49 +0000
From: Yoav Cohen <yoav@nvidia.com>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"ming.lei@redhat.com" <ming.lei@redhat.com>
CC: Jared Holzman <jholzman@nvidia.com>
Subject: ublk: Adding Latency Measurement Support to UBLK
Thread-Topic: ublk: Adding Latency Measurement Support to UBLK
Thread-Index: AQHb1hehSSJqMiAaE02kmq1+310EAQ==
Date: Thu, 5 Jun 2025 12:52:49 +0000
Message-ID:
 <DM4PR12MB632854130D3793D4DF7A892DA96FA@DM4PR12MB6328.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6328:EE_|SA1PR12MB8598:EE_
x-ms-office365-filtering-correlation-id: eb791147-2d54-42c4-6957-08dda42fe0cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?1dPafJT4BQCbL2w3jVyQXNVaztc188vimfD3MshraZ9EUCIeL1sBdCOv?=
 =?Windows-1252?Q?0exJBq8wALR0m/wzg5HEfdfsR3Q8U1Y/FPioEOOFse+jeQtZp/mLZDCB?=
 =?Windows-1252?Q?PN+LOGgKMYqKz0rz8q3tCe4fH6cM8Mp/K5URoBGZeI5pSWhhUwidFvAB?=
 =?Windows-1252?Q?NnFLUogY62wcVoLcBwzS+1mF5C42CwwOnhreTjWEQMBIrDphrq7sw5hT?=
 =?Windows-1252?Q?VOQ8ZYxiUoJtfY0Dvk149ceEVFXDAWXXeklLKJ3TwmxKPCkuJqxhkOTa?=
 =?Windows-1252?Q?oSVeZKmN1qtYMYe9O4Rl2rE5l8cyroII54JFl9lnQ5nKX7w+L0k+tILi?=
 =?Windows-1252?Q?EHvGynH+G8sTVAGrqaygYA+P2Bf3kSGQAK9ZM3s/qPbgXOz5tjP39HLO?=
 =?Windows-1252?Q?OivNXGErSAekBmccoxsKZ1NpK2M/mPwu4/MbShOTEnZ8cvsyM27nmcVa?=
 =?Windows-1252?Q?n/f7NKjC6nijJsAahiFKPdurn/WSw0UajD+udMIg0dlyQocP2BFp0iF2?=
 =?Windows-1252?Q?rW/7F5jDdIlb+QBFZEfhzJc7bmfTiXSVvxCWZhu1H95X45IkHdZOMiS1?=
 =?Windows-1252?Q?20lt0Imy8+dHkDTK5GP1qEkUZgKLW8sj5G/EmTllZNCkt7Pdy//qw+bk?=
 =?Windows-1252?Q?MnObqCvN9jGPD2ge0vfemgdRUam3rPthdLsRhyFyf/vGPvrgAb9uvd7E?=
 =?Windows-1252?Q?5tGsGYtp4FpUhC9yrkW92NTSYJ+gKv4bm79Z8tYy3v8LuEHTMZLbbKal?=
 =?Windows-1252?Q?hELW7URy2IUHAes0tKMMRy5xEted4F3YUIIwvXzk8RR7G07nkczXjtVz?=
 =?Windows-1252?Q?3koB3zB9vN0G8tCeajCm6e2GzICZwF+uXoTX+Oe62teorj4jLyq80TuC?=
 =?Windows-1252?Q?y0QlzUTCeyiX+Ok6BC65icBYZluAQCXN6hm02n2VLGmt1bR/T3fkLXr9?=
 =?Windows-1252?Q?x+dsu8Dz4U+an78VYboa25z6I3gCRx6jIVolf/QAgaIz8CdmPiNFIBAe?=
 =?Windows-1252?Q?yJgn8T+au68lObqKlARHRV4Xw4azImY+YgFCzUQbZb63aYuay9RciXT5?=
 =?Windows-1252?Q?tiYGVhhcc3zdogOMIGjCQ7CY00N1xUe4eYp5Dk+vYTq4h5DSUoZzJYHA?=
 =?Windows-1252?Q?2qKKtk1aoWnGQhg/hFAnv3UA2NEDAUMGQoSeMtRwWF5fCxtoVr44cP38?=
 =?Windows-1252?Q?Jr2szABgetgAVNWWPwRgVLcjbbfxPz4tAtnh76JEC8DPO6fH4NOgQL3q?=
 =?Windows-1252?Q?30GMMuJEX22cfehtNiigNeL/GWdB+IqNS5g1tk5gvf3IWQm+MN9QYn9N?=
 =?Windows-1252?Q?DWR2mncHErC8/1zgLVHXnRpw3FffHCPbICJ71aU/HweqEFq/oyAjtcQT?=
 =?Windows-1252?Q?tXbD7wl+bwqi9vTUGkicZPU6cg/ptIv7v8l0v/ynHC5s5x3WNYw1vGoX?=
 =?Windows-1252?Q?hvpZfC+lG/54P6ygXcXXi8kUDAEVjRWVAS8dZgCZciamJyWE3EoSwL96?=
 =?Windows-1252?Q?WmaKkXSJXBVJqxMHM3o8PQNzABJ83ExtHdll63qEqEBHzSzjTmako+Ak?=
 =?Windows-1252?Q?ZCLK6a1OEiBZ/ENg9JI1s6lYdztJmr+FMj6pfDyi6Kr6ww/RFrevPHn/?=
 =?Windows-1252?Q?N2I=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6328.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?rFH7ymk7f34qBfvrKGZ4xCQKLYSs5QqwogG7Vv9H7rrU7H8QcyyzPDdJ?=
 =?Windows-1252?Q?gaISVYA4XyLqElmQPZx0m7QZjdZtXNpu/lEN3a6Un719vBkzYUbmb3D4?=
 =?Windows-1252?Q?sBXDehCXL8vhNQtvWke6ktV8e/XOjhdNft6RbUABo0Q9BV1wLzUBnoq2?=
 =?Windows-1252?Q?BDHF/mrOs9tIl0m8dt/9mXiS56gLCGN3+xeKv0lFFJWhJPuIehAHLRf9?=
 =?Windows-1252?Q?4UEP5F5+QFL8p2yLtQLhmVrU3Tvf5JDmp1HVu85NoykVkuJcwd6h4V+z?=
 =?Windows-1252?Q?+WvOxcUHILCn9TB1fLEG0AWawAZAKYuvJu6FoXWY5TPdgmBkUxxVDufE?=
 =?Windows-1252?Q?cEDu6kb3Qa+f4JdoCDKq2jj4IGWJn+Ma2326gtrFSIca5HOap9KI0VJV?=
 =?Windows-1252?Q?jj2GX1cuR53jL7625U4Z2XCAKVt+jH38DBUpTK26WrUoyjili8WuGA1A?=
 =?Windows-1252?Q?3muwdkfqAaB2tIEUsubO2TwKe6Xqg6lD/LxmPwPyJ7SqVRDaRVqyFp+z?=
 =?Windows-1252?Q?TEpkQOaA/8rzSaiEbqfaKuNGLvGg2+ZV2V9NL1xlKzyETkY7jEtHZNHr?=
 =?Windows-1252?Q?59hjDF5QSqN/8/8fBA+BMoWtn5IEAdJKOPgSutxEeBno8i16Bh/cgiO2?=
 =?Windows-1252?Q?g/6BgZrd3ae73ps6HVAxnnW+SYf+deegUILLIq9CTfZftXw736NZCcBF?=
 =?Windows-1252?Q?UOrA7O8qVA7q211vH3MjYHlQsAZQ+dsDyLg5aRQl8QBMrBSmrFeXCiIb?=
 =?Windows-1252?Q?OQbWdKziRlj0D6dunL4SgVuft/cvcZUKovvvQ+yVxhCLLcm+mhTYP8+M?=
 =?Windows-1252?Q?StsKdyEn+4poY0IrtJ35hNThUuMRP9qNjwZ9MNQ+xjUJP0et3MhGyUkY?=
 =?Windows-1252?Q?iW7igrqy8CSa235sQwpP8DK91T3roNx4zt3YIUbnkP/TMmqNjYZBP/8/?=
 =?Windows-1252?Q?LZwIW1zLuXu1ajsEl7Lf+4eTHqvN4fPljrFFqEiVwdGsz+KlDKtjFwVB?=
 =?Windows-1252?Q?pbfyOpGH8vqip6MU0TH3kLJfp2Mbq5OTfz+IUf31sKsIM+GDFgbeAR6B?=
 =?Windows-1252?Q?gyQBBwP8q54h0Z/m1br8C89TuWRlI4l6nT1d6mnv8jL1X5uuoej8AUjg?=
 =?Windows-1252?Q?61Tz9tpD1GaPB5KEihBIvODZ1qBuLpFshEgTpidqFyGqQHs3bSfF0VW6?=
 =?Windows-1252?Q?U2LQ+t/HPBdxW/UHG3yDfN8g9cnO1SCm1dzB6Ftq83ERmPZ4WlHFSb/o?=
 =?Windows-1252?Q?3SGTSYB1z+HOG+95pBmhu+FAvXLhFcdMZXDZYHD6uPE2EbaLHUAFfX8B?=
 =?Windows-1252?Q?K/5HtVHA2q2vLRjMgnnwJI2Sa1OKLmFHiIusHgMk1BA7aRt3r+Zc4q8g?=
 =?Windows-1252?Q?Cb0nXnPvIW6ASUWfGlCNP6YXFetYKG010HwIbt0LCShjOOmi+2FO5PQ8?=
 =?Windows-1252?Q?pGpJgtB4XiIImjDUJYDOQzzstFZ5dAPpiiQfEUMOkiGwEPJQN3E7LIjs?=
 =?Windows-1252?Q?sqST3W6ezto9u9xoGJkYgMDoi7O1MN9U8k0eW21+TWW1J5Eze6FXTt0u?=
 =?Windows-1252?Q?Lom7yTFFEW7S3BgsdvmC2KEcwboyaLRjw+fY210u7+T7kIkxGXcylmd5?=
 =?Windows-1252?Q?5B0GpW14AVvbuEErr+qfgqZtoN83Hy4bHgd+ntyBGfWZptf1H26tBh74?=
 =?Windows-1252?Q?khjszRM3vEA=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6328.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb791147-2d54-42c4-6957-08dda42fe0cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2025 12:52:49.8159
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1bU8/ByEtyeWcBBObCzmyybTQGS481prEQAwcyAH3zfWCW2fnQZcSpCpYvG6y+Kp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8598

Dear Ming,=0A=
=0A=
We would like to propose adding support to the ublk server for measuring la=
tency at each stage of the I/O path. Currently, we are missing key informat=
ion from the ublk driver=97for example, the exact time a completion queue e=
ntry (CQE) was issued for an I/O operation, or when an I/O reached the ublk=
 driver.=0A=
=0A=
After reviewing the code, it seems this information is not currently access=
ible. One possible approach could be to extend the ublksrv_io_desc structur=
e when a specific flag is passed during the creation of the ublk device (or=
 by some other mechanism).=0A=
=0A=
We are very interested in contributing this feature but would appreciate yo=
ur thoughts and feedback before proceeding.=0A=
=0A=
Thank you,=0A=
Yoav=
