Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010177D3F4
	for <linux-block@vger.kernel.org>; Wed, 25 Jun 2025 04:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750825695; cv=fail; b=A9qMdkoSiHF+kcrZjJVGZTlOUZOAdusSPLcCnu44okSoI2Kh0M8UaLyD/dUQMMIHVudg6wWQ2Wq0g7HAhIDoJ07vNkyr90yn51pSwhK1zQW1yDBEOB74y0CegjwsUsS3BbRL/fitzlTax00cjEBvPnbdd8WRtNcD/4LbLtWWIy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750825695; c=relaxed/simple;
	bh=lOc5hmpXpaPv/ctZqwaJJSyAfRFabajP/Xpb0sg6bQ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UDy9CTUfv7N6iRT7jmLklosI/x5xdlilBN9FKlZn3mZ6jHHGHyg5WZxlszV3KwltIkiuGOx7o8naxGE3LuXHc7Lowk8Jm9bsacWEjbi/yA5BK+lyljzgB4+fCm+wRKQIkm4eKB5fEmDFU7LjmSYQ6d2nnL8X93Z4DxIAUJFf/mc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=shfqTdY8; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="shfqTdY8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPnFVrnhuvtzOp/YryNY/nXlWK51QGlrfCzWd5LukmR5TlsIxlUJPuqJF04ImpUx7juV+HUcyQI0UmQyNGhOiv690Y5ASML//OsZgtbcSUavUqyfs9O97FMf2fO4DKK6JyBaHQ1Trx+sOJG5SUu395fsne1jATWS0LBQs8syeNu/mAPisEWhkfDZrTugR/20IRt5R5taNiPLmRsOr+fh5z9h+x296JgM005XQduPDEjKmYVsJmhX48aqc584jm+L0qWU9dZ2OOwIGkdFVsmZqpk4+/uyoba0FPgOrVtWzJtznqwMn5FmdHk01GMQKoLmvEwU9Bxr6qRybK6SIfX5bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOc5hmpXpaPv/ctZqwaJJSyAfRFabajP/Xpb0sg6bQ4=;
 b=DTIhH5UrcwZ18Q9+qJbGSPaN6mp4o5uWkTmI+BaCczIUhCtYau8V4SLROg0WztlajXqKOtleH0YIIo77t6ZdJUMsnHr4fUo0lSPzkDhTTLRq3aFVNxTpjaA3fTyqyz765KnJiGd2UNIPA6E/uc5AxA0YJZE6/MPCLf4wUv78iJNqLL8Du3nG9P4W+7j/JF0mRXXe48HgY4lsq+zgG849OAQVZB4Dobx2IOsX4Q0FVwuGeK8VgK4xF9U1NW0dQM++sHDRIe3UXqX5WAXOWsQzIY2aizJfsixpYiumNEmZrqvfJUjs9fx9IHjSfHbhz1EH7al32ZO3OdYuvRQpmoejCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOc5hmpXpaPv/ctZqwaJJSyAfRFabajP/Xpb0sg6bQ4=;
 b=shfqTdY8cxyGJHHWK0h7ZGKuOYQs7Ie1BE/KlxLvud17k+y+qOACiUv7TEFAI+dO0fj4Ak67M5YFJTBtwAs7pyqWkDAJlb/qyK4dblvsNVk4U3orI+H8Ajx0Gm7BSdtGHP0EZj4wfa4LaqCSVSxEK3ER7Syeq2CO9szt/gSa9LbMsSjzi5PJ+TSe58BrdVxjVLhgQlq6dVEFPd3nkLz09xS8P9sFhJoBH/0gvTvNdEc48aBqL1I0UBNuIBC+OG22PLUbIZiCg02s3YKDbRj9+bmg86p5No9pVE5rlzMJw+6q1FiarwMCw0kSOBJn7+2e/b4diCLXQs6fZqUD5+7pRw==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by DS7PR12MB6143.namprd12.prod.outlook.com (2603:10b6:8:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Wed, 25 Jun
 2025 04:28:09 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::57ac:82e6:1ec5:f40b%3]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 04:28:09 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Christoph Hellwig <hch@lst.de>
CC: Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya
 Kulkarni <chaitanyak@nvidia.com>, Kanchan Joshi <joshi.k@samsung.com>, Leon
 Romanovsky <leon@kernel.org>, Nitesh Shetty <nj.shetty@samsung.com>, Logan
 Gunthorpe <logang@deltatee.com>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, Keith Busch <kbusch@kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH 3/8] nvme-pci: refactor nvme_pci_use_sgls
Thread-Topic: [PATCH 3/8] nvme-pci: refactor nvme_pci_use_sgls
Thread-Index: AQHb5Ej2eX7oJg9PaEiN7L+jbEKJvbQQ3hgAgAFlU4CAAQcegA==
Date: Wed, 25 Jun 2025 04:28:09 +0000
Message-ID: <01319f89-2244-476a-be0f-ab0dd74169d3@nvidia.com>
References: <20250623141259.76767-1-hch@lst.de>
 <20250623141259.76767-4-hch@lst.de> <aFlyYjALviyhQ-IE@kbusch-mbp>
 <20250624124625.GA19239@lst.de>
In-Reply-To: <20250624124625.GA19239@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|DS7PR12MB6143:EE_
x-ms-office365-filtering-correlation-id: 348e7dc0-d1a6-456b-c21d-08ddb3a0b0b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?dXBkWVNzYVN1NVRSeDhFMldHNlBDc2xtNnpvKzZtOFFHdGUreTkwZE5rTHV6?=
 =?utf-8?B?S0RQUmx5L1lLRWxiTk9yUzdKM2xHdS9lQjBlYzUva3JCQnVvejVWM3I5aXYw?=
 =?utf-8?B?UG9GMFY2ellNZjZ3TVdGbkxTNjFNcjV2Z2p1Y0gxOENadjliTzRUK0wzYkhH?=
 =?utf-8?B?TGZDNko3bUVxUHZ6NDB4MTBGN2o3MENEU1FIODZIRFBlbzhLRnk1VHMrL3Nn?=
 =?utf-8?B?N0lHR3FHYTE5d3RLSzF1SUMrUUZLRVVhTUNvRlJXclhjQ2dpZ1lVOVgxc3dX?=
 =?utf-8?B?Q2ZUWmxtY1liVWVBSHl5ems1ZStwK0FuY1o5ZzBJV3VTb1J0enNTVjdYczBa?=
 =?utf-8?B?cjhqeGg5TUZEalAvQjQvK0prTFJDUTRaUlJlTk1FaVIzbDVrNFNDUjRoM1hC?=
 =?utf-8?B?d0ljMnByeHM3aXJZZGtJWlZpc1hLTVZsK0lWNERQK2ZrN0dyMmJBd3UxcGRk?=
 =?utf-8?B?bnAyOG1Xd1BSWEV3cTdSeVc0ZnVqRUl4NS8yTStsZlZXaFBvMkh3dHgwMExR?=
 =?utf-8?B?V0Q2M2VtVk5ETVpMSnd1N2kvVnRGRnFFcDVsckZrbm9SYzQzZ1VvZm5lTjFz?=
 =?utf-8?B?VEZjTk44TlRoaWFVRFpIc2NZdGVPVjRpbGtPNkhBSFZNSWFkbU9jUldzTUFI?=
 =?utf-8?B?bWhDTVVycjhLVGxneUNUeTRoOWVkZHNoSG92Yi9PL2JFd1c3YjFOZzM1akE3?=
 =?utf-8?B?QVJrVlRtQVZQam11ejIvK1RSUUkzYk05dmJQa1NROWsvVmFPN0I5LzF2clU1?=
 =?utf-8?B?RFIrZ1hVeGRSdDEvbzVNb2NNbUlEMlAxSHM4cFdicTg2ZTM5WmNtWnVTMXZo?=
 =?utf-8?B?SFE5OWx2L21PZkpIcEZlUThvd0lXc21JaVBoek13SmVkeXpxRmI2TjU3TGd4?=
 =?utf-8?B?ZFpCTHRFNDI0TlhsN3VyTDA1NjhVaUZQWDl0MlJmanhEMmdmOHJVR3FiMTRT?=
 =?utf-8?B?WEd1QytITXdpd0pkTEJxbGMxWDZ3dE4xS2tpeFVpR3VVRFNEYjFBNE1FQ2Zk?=
 =?utf-8?B?V3VKV2VwMDdQdWFWR0hsc1pyRUpKRXRraVAzRXJMcjQvd3lCZXNOQnpmQTVS?=
 =?utf-8?B?dGlRT3M4anpaNWlnZ3J3L28yWFVXak1WUDRTTU1XUEFQb1FRNkNvQ2plZE5Y?=
 =?utf-8?B?YUFYUW9IazMrRTNzVnFlQTJXb24xR2F1ZXJhSVMvNWFwRWx6ZVhIdzc0WDk3?=
 =?utf-8?B?Myt0ZWd4OFdpWUtkQVZpZVdQdmRPOEp4VDhGVlZOZkFBQ2VsTlBvMEZEVU8x?=
 =?utf-8?B?cEFkVkE3RWtvZGxEWjE2U0RIMFVRNjM2ZDFYa1pWQXYwWTJpMk1PQThRZ1dn?=
 =?utf-8?B?WHc5dENOb1FIQ0NtZWs5MTRTeXJMdFlwMGtSUllONTJqbEwrRVlHSHBFUjlX?=
 =?utf-8?B?KytBYzhpdVhuVUc4eGxXMXFZaFdNSXdtL2ZlV0pIa1M0SitNVlpYRW9yemVv?=
 =?utf-8?B?SlpOOHVaZ2tPNnFFS1JaNmxOdHgrY2daakUrM1VNall3VFlpRHY5OUZVK0lP?=
 =?utf-8?B?eEFXdUUwWXVqVzhvbG5Wa3M0T2ZSTHhkQjg0Q0ZQSk9LYjQ5dlMySFNxQXZZ?=
 =?utf-8?B?SnppQjdkM1pFZXhzcTFSK2I2ck8xQ05MVFNidXZjajVBYW5CaGhqUzFDSUJ3?=
 =?utf-8?B?VHF6VURWTDlZdTVKRGo2Wnp6ZkdSeGVuRGVCQmRxS2FSaitNcmhJdXZZQW0v?=
 =?utf-8?B?Ym1BY2VucjBONkF2SHErWlRLQWl0RklDTktFcFNrb0MvcTRSWkdINWE0a1Y2?=
 =?utf-8?B?Qkc2WFUxaHg3aThMa0hDUUw5WEp0S0xpVmxpWDJRa202VUFwSFhXelJwbDBK?=
 =?utf-8?B?UjlDaVQvL29acUtZd2pRVjhoQkhXSU95Ryt2N0Zqa2xzaWc4ekkwOWlGWngw?=
 =?utf-8?B?YTVIN244ZTNFYkVsM2tKUWI5ZldpV0VYUk8rVU0yMlRZQzZweEk1UUIwNmFD?=
 =?utf-8?B?UDFVVzkvZmdTZHVDRS9JMDNwcHlzeXdUM1VTQSt5d295Y2luTytjbE9GTUxV?=
 =?utf-8?Q?ImWQGaXhNOtEqvcXZ6F/sKPVSEC+mU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R0taZXUyZWt2UFVSbjZJQlYvSkZNNDVUcCs3dTZ6cFAwUjB3MC9UNDJxVGJt?=
 =?utf-8?B?dUlVWk5wR1JYUThGVzkzOEM3ZnNacEtvREI0bDBpTnd3SkQ2Rmh6U29ERDcy?=
 =?utf-8?B?RWJCQU8vYVhRQTZxUzZCRHV0bXhpazVMNG4wRVFhT0lPeWQ5QVQvWitCZ1RH?=
 =?utf-8?B?dDZJMDNTWjYrdzNwSFlMVHlQN1JQZ3pZSDVmMzRRSU1ISzhWejZveHNVMU5T?=
 =?utf-8?B?QXk4TCtTL3Avdkx0a0MvMVgxUjNZMUlsRTIzVno0NndLOHVqZUVRVjBNN0RQ?=
 =?utf-8?B?ditUVENpU2l1US91Q3NSd3c1aWtYQ0Y3RFNqdFlCVEFsalJjZ20yaFpCU1pK?=
 =?utf-8?B?QmJOM2JrcG9Cd0c5RUVKTkV0dnUxT3FNZ0hZckdnS2UxTkV5dXp2STRRMHht?=
 =?utf-8?B?cFRXNTRRdkxZRElaNTJkQ0Ntb2xtMk1IbGRDTUhnYnhuUkZ2S0t1MkJHZE9p?=
 =?utf-8?B?WGdtaUp5NkFIbS9xMk90eW5wSTUrMjNHWEozOE5PbDBWMzVDazM1S0hTQ0E1?=
 =?utf-8?B?ZjBYMHROTWNMZmNWY2MzVDhhb0NPSlZNR2thMVA1V0lIcVZQWXVQbW9lM2N0?=
 =?utf-8?B?YlB3dmd0WDNRdzBJWVJzN2dGSzFPTVByVmxxMjJ0dmhMRkp6Wk53bzY5Z09h?=
 =?utf-8?B?Q1VhYkp1Y1d3TEVCd1AwMGtpbkFoVG9jNk13bkZKS0Q0WldlNmNSbGFtVmdI?=
 =?utf-8?B?TjlvU2FNRlRvOTVIYkVPcHVNVmZDV3hGb2lQYi9sekVXRjdTRmtMa29rUENK?=
 =?utf-8?B?cEMrREY1TFd3dlN5b0dKUmpsdFFHRUFzbm5iZEZRUEltb01UOHJMaVpUQzE2?=
 =?utf-8?B?L2g5RCs1TTZBWnJteG15Rm5NMzdMYUhwS1JodHkza2oxNUIzenZmYjNiYytX?=
 =?utf-8?B?MG5PL1lrNXRHWXdxZi9ibHBzRkt2cFJidW1WWkdzRGYxZEtyWXd3MlRpbU5K?=
 =?utf-8?B?dTJMSVJxTlJleldyVFZ0bC8rNVRrdStuOXdFUDRUeGdTbVdvZlg4dFlTK0dW?=
 =?utf-8?B?NmtiN1BwQlp3Z3V0M0RxRXRkWVFTaWFtUk1Ob0VheTRPSk1DM3J3SmljMFlU?=
 =?utf-8?B?elduMU5reEFKSXUvMnFHeEwxUVUyR284eVZuVGkxQ1FiMUlLMm1OeFlzekFJ?=
 =?utf-8?B?R0U3bzRISGtSeDE5a2xYNjIyYm03Q0FmNTMvRTQ2R0VweDBFUk1oVVYzTzJK?=
 =?utf-8?B?ZWVvZHVpVUN2TEt4d05MNGhJK01pZHF5emhZd0hMTzA3NlU1aVZoSWcxZ2o1?=
 =?utf-8?B?WEpFY1pPNE40eDYyNWtndSs5aHR5NWxpUDJvLzhMRG50R1dZWis3WnRqSUkx?=
 =?utf-8?B?eksvQU9EeWlkM1JCSGM3Vy9TUnRHUXp5Z09oelVIRGxkNFVWb2hEQ3d0WGti?=
 =?utf-8?B?VVUrQkE4T0JrankyTDQ5TU5GY2ZFcEoyMEttclFMVmFkZHZKQnE1SDQ1WHBt?=
 =?utf-8?B?QmdIQitKTGpPV09RK1BLZXpXeGNxQklQYXZUT0Z2U1hoQUxaZVFpQitSOHNz?=
 =?utf-8?B?VFZJYkRpdzhRYjFHcHlOTVk3WXlJekU4WnJ2WXR3M2E0T0lHOWo1WXVaQ09o?=
 =?utf-8?B?M2diS0VDVFNMYTNGSzBFQjdoZ3FUYWJzdGFJejFiYUFZSGJzYTlPL2hNU0JH?=
 =?utf-8?B?NjV1d01aSmFvOW1pZTRMRGhvdEZIQ0d6UzhvWDEwc09wRkdvNE42Qm1SNzBr?=
 =?utf-8?B?QjFJWWwwbnVoZkY5NnhyMHJhZDI4ZlZITWRCQUZKSmhocFVrR0cxYXYxMnhv?=
 =?utf-8?B?eU1QRlNkK09pVWR3NW5mck5aMlE5bXJaYjRUUnNOeHFPMTV4Uk02NDFCdy9u?=
 =?utf-8?B?Z1dhQUJYK3NTMHRiNU1mSzVUUWxLeUVCdXFRMVhXMks0SHdpUlovTnhmUVJF?=
 =?utf-8?B?d1JiOHE0ajZBbjRLWlk0cG9zVFVtSXorQXp0YmlaWkNQa0V1TURXM2R2WDdh?=
 =?utf-8?B?UnZrRVFPanBYNWU4dXBvWGJoVHpRbzlkSXlUYnByL2VqdHUrbzl4ajI5WmF6?=
 =?utf-8?B?SWovSy91cndKWWVsSWxUbVBMR1Jadm5VRVVqQ2dWb1FMTGdLbUZEMUhyWjBF?=
 =?utf-8?B?dE5xc0JuN1Z1TzljbTJtSXdoeWVFd1NIRTFGdlNYUHd3YmpGSDV0aisrSEVZ?=
 =?utf-8?B?cEpQaGgwaHk1WEtnai9wY0JFdHNJU2NObFJ0bjQwY1BwWnQ0T3FNeHdTcWp0?=
 =?utf-8?Q?XOasXs8B380ZvURAhsOdINuAPL76q+1ab26ARB7/EJ+h?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F691120E73254644BB927C22C3AF556B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 348e7dc0-d1a6-456b-c21d-08ddb3a0b0b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 04:28:09.6499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JoR+5mikipo1Jj/TdfgTEEEiTq/jbHnZph6jmsZU4AtWp/1hZHy8TNjrKjYXqUHhIQbUrfVGcVuHWlCFS89R4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6143

Q2hyaXN0b3BoLA0KDQpPbiA2LzI0LzI1IDA1OjQ2LCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToN
Cj4gT24gTW9uLCBKdW4gMjMsIDIwMjUgYXQgMDk6Mjc6MzBBTSAtMDYwMCwgS2VpdGggQnVzY2gg
d3JvdGU6DQo+Pj4gLQlpZiAobnZtZV9wY2lfdXNlX3NnbHMoZGV2LCByZXEsIGlvZC0+c2d0Lm5l
bnRzKSkNCj4+PiArCWlmICh1c2Vfc2dsID09IFNHTF9GT1JDRUQgfHwNCj4+PiArCSAgICAodXNl
X3NnbCA9PSBTR0xfU1VQUE9SVEVEICYmDQo+Pj4gKwkgICAgICghc2dsX3RocmVzaG9sZCB8fCBu
dm1lX3BjaV9hdmdfc2VnX3NpemUocmVxKSA+PSBzZ2xfdGhyZXNob2xkKSkpDQo+Pj4gICAJCXJl
dCA9IG52bWVfcGNpX3NldHVwX3NnbHMobnZtZXEsIHJlcSwgJmNtbmQtPnJ3KTsNCj4+IFdlIGhp
c3RvcmljYWxseSBpbnRlcnByZXRlZCBzZ2xfdGhyZXNob2xkIHNldCB0byAwIHRvIG1lYW4gZGlz
YWJsZSBTR0wNCj4+IHVzYWdlLCBtYXliZSBiZWNhdXNlIHRoZSBjb250cm9sbGVyIGlzIGJyb2tl
biBvciBzb21ldGhpbmcuIEl0IG1pZ2h0IGJlDQo+PiBva2F5IHRvIGhhdmUgMCBtZWFuIHRvIG5v
dCBjb25zaWRlciBzZWdtZW50IHNpemVzLCBidXQgSSBqdXN0IHdhbnRlZCB0bw0KPj4gcG9pbnQg
b3V0IHRoaXMgaXMgYSBkaWZmZXJlbnQgaW50ZXJwcmV0YXRpb24gb2YgdGhlIHVzZXIgcGFyYW1l
dGVyLg0KPiBUaGlzIGlzIHN0aWxsIGEgbGVmdG92ZXIgZnJvbSB0aGUgdGhyZXNob2xkIG1lc3Mg
aW4gdGhlIGZpcnN0IHZlcnNpb24uDQo+IEknbGwgZml4IGl0IGZvciB0aGUgbmV4dCBvbmUuDQoN
CkFyZSB5b3UgcGxhbm5pbmcgdG8gc2VuZCBhIFYzIHdpdGggYSBmaXggc2dfdGhyZXNob2xkIHBh
cmFtZXRlciA/DQoNCm9yDQoNCnlvdSBhcmUgcGxhbm5pbmcgdG8gc2VuZCBvdXQgYSBzZXBhcmF0
ZSBwYXRjaCB0byBmaXggdGhpcyBjaGFuZ2UNCmluIHRoZSBiZWhhdmlvciA/DQoNCi1jaw0KDQoN
Cg==
