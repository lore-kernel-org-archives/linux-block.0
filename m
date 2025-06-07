Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14D43FBB3
	for <linux-block@vger.kernel.org>; Sat,  7 Jun 2025 12:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749300902; cv=fail; b=JvPd2LwJJTyRIhKI/kYRHhcl8DC8u/Ph7KR4Tjd8GVRPLjKjwZAlt2/7VPu11A6W3fqlyUbxuWF8d7lmgQUuKDdr7Gu2Y8E1+S3ktZMHJOKrSLzSVqZz0fasuzR3GJa1DN5GRNrxbZV/wSPlPpJe2Nu5Apyv6RGyA9DZq2h4VO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749300902; c=relaxed/simple;
	bh=JZKjvt0+TZWCfmQmF6riVIg8SFfyXSsnRTPURszrtgs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PL0hT7b5g097pOLZRxpw0nzDZ6q51sNXvXVsSyLNyW4ur6EdfJSJsifPXQJwBzoB/bEDLu6QFS2yqlomIj4pcadFKpPIkqc50w0jOvWcbo7xYX3+5ezc+VsYw/v3T2K1dKoYMHG/brh6OFrJOvZoqzhZ/rljvtzn4CQiggx2EWo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=REohtalo; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=YnmZDxj5; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="REohtalo";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="YnmZDxj5"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1749300900; x=1780836900;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JZKjvt0+TZWCfmQmF6riVIg8SFfyXSsnRTPURszrtgs=;
  b=REohtaloVC2c1nU3OryaaDBQnptSRoQTHnEeHoknfEuGxDFCtZkEOerA
   AHFi3h0HyBs76h0JrfaDKlW8eAZIWSO6P1tSkyDhqT0R9g1c0yRN3QBXQ
   vQ8WADrADGfZqEU/aX2OQvPUDBRW5gi2wPDYFAt6QAvo4ZQXXbGBO41oL
   trlKyBCSZhhaftrMqwJUpKdXxbQdVy7H94JaV1Bm7ZlCjOon/xWnEznB0
   69ECRYf1yhCcmOOhAeUmCI9e2o43ky51Sa/+V/D+furu8Oq6UvWtzOMX2
   xgTJbv06U+jhbBk7vOiuj9vLGpv3naSaAimU3wRjUv4Z1a7+X1UdT+YN1
   w==;
X-CSE-ConnectionGUID: LuKv91NESB2cDsY9w2xe3A==
X-CSE-MsgGUID: VytAyrO3Sn67QKPNJA3ihg==
X-IronPort-AV: E=Sophos;i="6.16,218,1744041600"; 
   d="scan'208";a="84164858"
Received: from mail-northcentralusazon11012054.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.107.200.54])
  by ob1.hgst.iphmx.com with ESMTP; 07 Jun 2025 20:54:53 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wa4N7H4vmRBwLIJTxL8tyDXzwgPqlmAJwc3rqWdQO1pBJ1mx6aVROcGuhX6lWS7D7xj3eX5o97mxZguaMbS6zmYtYElm8sjeADuVefIDkDG+biW0w+xdBtvBSWSNcOhbAkVrVjwMV0GvvLd+VxKVG0k3/JctMkumC78k8FJVt+vnvz2Wt27rLqEVdRst1T+1Di/bK2Wh+rUMIvEM7THDRsd18XEGn217HEf88qfPDxIYmfAh3sHzSsHzii4L2jl3LuucEx68jBcrKgmrRMat9aA1TVkLKSkecNIvAiCgPT8Gqvps8TF6KqeUr4NFrhMbANcgTegZeBVsEahA4C9SVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smGMVC12/Za2NJ0lV6ewzNVmE8wUANZxHVULD/bA0/I=;
 b=dudxPhtAwow3uAS8rWZ1lw6VAPJ+gMM5qU+E0pMKEcS7K4MflVIQs3LjHOWxpYdsqqimPs8Fu6xYIwHnu4mHrZEyA89nUjbdSb60gVgT5ysiZTmK9+772JmJuw9kPaqEWgsgoIdsYnKhRDfcgafviZt9zUmJZJBR/tj4R6S0LxfQD3Gw3lclykEhkePwyufEibGyITZ8YQWD0Y1D7ADJ9Q8RXbDOckEWFFzXEZay3FWTEBtaDBUMyjtHUJhvTN0WNiPFEikFGaKh0JgnUubnw/CAxzoRunK4DxgtLi04g858oSs8tp8CdjIofsC55UEnOeyXUyYRjKzmP75zB/imuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=smGMVC12/Za2NJ0lV6ewzNVmE8wUANZxHVULD/bA0/I=;
 b=YnmZDxj5dXHTwh9uhJOrZdb5qw17pRRLqncI962rMi8GAH6Tyj2IXir5TGNDo76yh2LJKfwbqZlbaXgoPNoCfJ+KVejbueuDn0UknyMLYL4X5puq+5WwZ79lCj99KHBq4s+2zU+sEQkM/njnp7p51O+efRbU24I1kRv+kxPzndI=
Received: from SN7PR04MB8532.namprd04.prod.outlook.com (2603:10b6:806:350::6)
 by PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Sat, 7 Jun
 2025 12:54:51 +0000
Received: from SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4]) by SN7PR04MB8532.namprd04.prod.outlook.com
 ([fe80::4e14:94e7:a9b3:a4d4%5]) with mapi id 15.20.8792.034; Sat, 7 Jun 2025
 12:54:51 +0000
From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: Keith Busch <kbusch@meta.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"axboe@kernel.dk" <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH blktests] block tests: nvme metadata passthrough
Thread-Topic: [PATCH blktests] block tests: nvme metadata passthrough
Thread-Index: AQHb1no8Tf5n41CazEGiDdJRWjmp2LP3qcEA
Date: Sat, 7 Jun 2025 12:54:50 +0000
Message-ID: <brqphgz27tsruoz4jyvvc4x6kwmqv2lkotdwwox2njqfku3kb4@2hpbwsti3rcn>
References: <20250606003015.3203624-1-kbusch@meta.com>
In-Reply-To: <20250606003015.3203624-1-kbusch@meta.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR04MB8532:EE_|PH0PR04MB7416:EE_
x-ms-office365-filtering-correlation-id: 661369ba-3b8f-4859-1dd3-08dda5c27de3
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?czHZoHPEVcz4YRUzrryXQfxRTmUJ4V/kthTEdXghes/a/XRYrfPHa2Lb4mZe?=
 =?us-ascii?Q?aw8JjJNAe38nDDZ56LV6RoyS+RHy2Z6x4cYeskNC3iGLIeR9N+EAp0bpyauC?=
 =?us-ascii?Q?46u1S6h4eVJgUIwiVZH1L1eaT2MCO9Lfj2lT8kYuFz9WGkyb7jeDIfqkWuzM?=
 =?us-ascii?Q?3iA4rYM/ysYhHYQkeaxoJjMigX2BT1u777ok3NHiAmPJet2ywiHNaZ6IhYqx?=
 =?us-ascii?Q?StLMhbvRARfsmreSUGbsMO16rSicQttto9x9etxLt1ugfFRjgbH1Ga8IGm7V?=
 =?us-ascii?Q?mPVYi/BdU+LdnVE0abrS94FYqjZzaxaeDEnsEMkTMpEc2ORm4ZdNH6PZLHAh?=
 =?us-ascii?Q?MQCXrkNwgafJ+BowCixm0iMHQpRlOZayTMAw/I1q9txlrv2CCQAgWPQO/jo+?=
 =?us-ascii?Q?u0kG2VHyCFEZOKlSVPNqugMh97+9tgKtGv7oYiyR4qOUwWzH30rRDT3/xhWy?=
 =?us-ascii?Q?Zx0cZpu0340KfVbykVz4nkRkXZXGOT5xwx+MtEKFoOcEhZjbf4BF2QIS2SoN?=
 =?us-ascii?Q?cjOkB7HuLxgQTHFO2wdZCAuySh0wmn+GHzRAKsIlaB2mvLllpF8mJo7pfPCV?=
 =?us-ascii?Q?csm4whoyPfaA9hcTTSUwSlYg8uU90CczQzgexhk7x7IdvW6bcomtyR3VWRUn?=
 =?us-ascii?Q?EmdTr8UFGSu7lxE9dtQkBuLUfsLVbBKun7Tv1Fdin0976IloXE58JVwX1i+R?=
 =?us-ascii?Q?6FHt22k2FGI6XqhUn3BPZPHN2HEHApQhARI+ivXh46eOZHGHDEJmM8EigUJP?=
 =?us-ascii?Q?q+Tc5kdOK5Y6F81JWEGSSHuujLf30+Bf23uxeiQs8CyFNzTLIg4a+EYW74h0?=
 =?us-ascii?Q?c+SflYoO/DlqNEks3pNamXYQpstdUSk3bC2KeTflPBJdqPfRRlZ3jQ5AoMX4?=
 =?us-ascii?Q?fxWSf4F1EZ7b1r+W0vkKxfQgfWvaHITnYsqBfBEGkx1iGMrRfD3d7VhncwO3?=
 =?us-ascii?Q?cV8LpXx3oIZtw7gaqPoiG0+cYWHTi+Lwc+WJWIdgySVTAX1O3TKPGFpEALn9?=
 =?us-ascii?Q?dbMfsVnuaNcKf5cvSiQlgyIE2LjrMEzSlAopxJsxdTGmsQfbCf60fCtyP74e?=
 =?us-ascii?Q?48zUF7ZiN/bCWqV8TiVdzS5xqjT9xsCCFAzZrH8RHa4cVO+/1FpwLg6SKvdX?=
 =?us-ascii?Q?gdhM3ZvLptbS3cDtzYbNsB2kB8wv3hU4NhpiXsvxs+oDDxeGlkTNOKwMNWEI?=
 =?us-ascii?Q?ZhTtCAzYSafom5u8hp5LLkfBxd/1Iz+2YqBFn4r6D5CkS5IqGeNtep7drFhD?=
 =?us-ascii?Q?0xL2CPqxTjI4R9BHA4Gn1Nb+OK+hKNciImUG2aAYs0gj5nZwrQVbVhzWROvx?=
 =?us-ascii?Q?s+DpSLHXK05J/+KUqQr+kVsHy5bgDNET6H7r+na4RLVgMODI6QRLQrSsvHmg?=
 =?us-ascii?Q?ThXLMVr31EnYujZB1IGJeiQfdbB3JBfENj3cqLPxu5/XGzRhbTpjYEtF1RrJ?=
 =?us-ascii?Q?wna86biXPd8P3KBCb88gHRKq9y487Hm6sinlGy1iF4ZLMZr8oQREgQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR04MB8532.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mLAhw44+XN5eWfH2l+gwynVTRkYaN3+V/5BR041iCHBFr6EGrfrMaZLgbNlE?=
 =?us-ascii?Q?5mWqEkCeukmJHbbu9oNLF+50Lk8CS3yVGdMB98HmH2grVAce2/DlqtAuGUl2?=
 =?us-ascii?Q?IDhH02aXhPgakAMiq0+9fqobkHDkL+H/U5i5x05m/C25dgzaegcjukFoDx5p?=
 =?us-ascii?Q?tCDxTe90DApQqkf0JQLdUp5PF1ogrHmg+glU/jayftykpKbcBxvoCrIoXeHm?=
 =?us-ascii?Q?ZfMMvepDuPFcLFff3SnuWZ6eMC0phEI0izytwq3Hq2yZXoExQ+o6RA4L6V+/?=
 =?us-ascii?Q?NUImg+ewGMnz7VzUzbw6tmmltL40K1Z/SxesoMYieH10K9mz+qpW7CfGPv6s?=
 =?us-ascii?Q?rwndmd/ju2FUwjXZHGvopNrltudHVb+lonBlhjmX7rm1A+O+WW4iW7OF7W01?=
 =?us-ascii?Q?+0lJYf4fTKhrr4E7Ngo4TPJ3Q8SeFfcfHYuBybucHXIwpJfhoUKkaBA0qPrd?=
 =?us-ascii?Q?o5rKC332+spNZWN5vN2LydNK4uDBzbfpHJRbI5mOuxqTd47dxS2ZghI0iHMa?=
 =?us-ascii?Q?dJ/L+wMO/mm+G7qmlScVU6+Yc4xlpIpCvP7DFBr9kWSghrtFhiyIIShp8qTu?=
 =?us-ascii?Q?Ulr/ZzWcORcqTmh84ITDAU5ve53pbTv585q82DpuKAxRCVRtvR7Il7QDAplA?=
 =?us-ascii?Q?vXVboxCq+GfMwgFOBCIp8yYw6QGzGSkdBDUvAwuXHiWc7DwrRrPDLQdAnF7+?=
 =?us-ascii?Q?xVlYVC17QVb+KOxDHG/SwO4/o83Q7w5XjM4+CNKSg38TLjEBgr29tITMF9VR?=
 =?us-ascii?Q?1cPcWHs09UlzOe0Y1+237zyt3kh933yM68Cb9GhSB0LwuQPotzx5DMAspPLP?=
 =?us-ascii?Q?Ejl/iRm87+rU0E02KYS9RHMobYt/IaNuAkPo9LRhcyoc9VaSNcon8oC3SujZ?=
 =?us-ascii?Q?W90/vjR0C5w8/XIRSEoIN2EmwC9XKH1IlcrQi0cFwxDyDsDv8zJwLFsS+jV4?=
 =?us-ascii?Q?WtaJrP71AVW8OUFGpsgJwCsLz7IqtamnsNlj1erpxJc/Q0Ah7KOy8aT3KQRw?=
 =?us-ascii?Q?EKyln0XsuuVITCeAm50Ji5DZxYgX1VO9kEzJ/HhE00R7H0UWLy6iUI+ONPTA?=
 =?us-ascii?Q?yv7OkmRazpFdEQzj3DnUhd+jUWjTPGh+k6u8wfY4CLUOkoiMY32OvzJofoVv?=
 =?us-ascii?Q?fZJnrAEFbSB0i/O/j4W+pw2lW2ajBKqFR3rRb+b8tarbZk3eG7Y+9y61emYx?=
 =?us-ascii?Q?CNVYhfXG7Cesprumc16PDkllufLAHkFEcjrHKqnQOmn2WLi7iiQvts7Od6hd?=
 =?us-ascii?Q?HoTk0a1ZK7ZyvyU22MZ0k3OtQMdeWaxwrLfS3lN/KMLQAflDqlpGas+ATEq6?=
 =?us-ascii?Q?8v5ufijBVXvDJTPzFc5w/9x+JJMHFCldlHTwxMikdCSyE3iPCy+g47hotbab?=
 =?us-ascii?Q?LI3BKlobsoGF0vnosyuF/wDENPgzJtzq8Hzkphckz8pxz8tl2EJoN3/b+13g?=
 =?us-ascii?Q?VyjTdfEyDHiv65jvg6K6Vm9zetMiey571iwpHRRQHZlmdLd8C39qWNsoAYZq?=
 =?us-ascii?Q?UPkPEo4If4e7Vh77BmE44vhFjr+Dx3II6ze07/3Uavylkg9c1DNDZJZzd1Yp?=
 =?us-ascii?Q?fC1g2Cpz8K24st/tYIWZuk7wKoSj4O3oAIeUSWjTwZf2sl5RENQKDvUW1lvh?=
 =?us-ascii?Q?Xg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <721B68F77A5A4947AD8B57F064073D4B@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9yf98yFC65WNgjtAHx09gWMpOfASqEg2nIRuEPNuQY89ISDNeYJrmzlLHihiYI0n2jfNAjEsVSiqqVen/D4vGhuFRvRAwmydF5ZWs/ggY4XHr+cCpujPktiMMuMeJYK8l47Wx0FEhVuecqc3ysC7wM4hsBZbgSETA2/Ry1xAFxQcwhE2k6lW6w35lPFAxGsqYNrV1iZMq7oglGhwR5v88xUAfOQCvI2fGOxc85MHnLefe93YDGMgu6yf/Pvil/sh8bkCKZFhNLAjMQRszxBeTtFKJzTGKaSjzrg+QTDwS0YvxMLCYBE0AbGL43sBH6SUWXbLXnWw7/7qmlelv3HFYGyRKMZ+xSZJopxFQYKLUpshG37JJaro9wSu5b6jSDQeNmuiSB8M+n/m7rFe010eVZYaCDPgDKJZ10F/D1F1rrwoQYF8e8UIQID9gKfZ7HQeExfhyyKtLt6rXPz02Qfh+RFVTiYWplrb+2ytnTRVswtnxQ9Vfj70Pr5WpR53cXAB7aknN9UpYgQpQr8ZRWSBAKv0/4wbmNJIqEav+TrxrFcVyeUkLgwF+CKiVN7imSGutXey0j9HBAnYXBhRbl/w7o4omvzb3jIo0/S4fNLpWj72EOECrxq9SKbixPjg+Lxo
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR04MB8532.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 661369ba-3b8f-4859-1dd3-08dda5c27de3
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2025 12:54:51.0170
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3LbJzW3IWJDnzwQCEV0aRQK622bnCaMHOYK4mNBYKIDNgCmSqdl27XhuX/8pn/E7QLEP7s7B4DvMNDSORFV7Y9T1fXKv3Fq6M4KkuCYlSSs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7416

On Jun 05, 2025 / 17:30, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
>=20
> Get more coverage on nvme metadata passthrough. Specifically in this
> test, read-only metadata is targeted as this had been a gap in previous
> test coveraged.

Thanks for the patch. I ran the test case on the kernel v6.15, and it passe=
d.
Is this pass result expected? I guess this test case intends to extend test
coverage, and does not intend to recreate the failure reported in the Link.
So, I'm guessing the test case should pass with v6.15 kernel.

Also, please find a few comments in line.

...

> diff --git a/tests/nvme/064 b/tests/nvme/064
> new file mode 100755
> index 0000000..ed9c565
> --- /dev/null
> +++ b/tests/nvme/064
> @@ -0,0 +1,22 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-3.0+
> +# Copyright (C) 2025 Keith Busch <kbusch@kernel.org>
> +#
> +# Test out metadata through the passthrough interfaces
> +
> +. tests/nvme/rc
> +
> +requires() {
> +	_nvme_requires
> +}
> +
> +DESCRIPTION=3D"exercise the nvme metadata usage with passthrough command=
s"
> +QUICK=3D1
> +
> +test() {

This function name should be test_device() instead of test() to indicate th=
at
it uses TEST_DEV. For test(), blktests provides empty TEST_DEV. So, actuall=
y
the src/nvme-passthrough-meta is not doing the test as expected.

> +	echo "Running ${TEST_NAME}"
> +
> +	src/nvme-passthrough-meta ${TEST_DEV}

I suggest to check status code of the command above, like:

	if ! src/nvme-passthrough-meta ${TEST_DEV}; then
		echo "src/nvme-passthrough-meta failed"
	fi

This will catch the failure with empty TEST_DEV for test(). By renaming
test() to test_device(), src/nvme-passthrough-meta returns zero status.

Also, ${TEST_DEV} requires double quotations like "${TEST_DEV}", to suprres=
s the
shellcheck WARN below:

$ make check
shellcheck -x -e SC2119 -f gcc check common/* \
        tests/*/rc tests/*/[0-9]*[0-9] src/*.sh
tests/nvme/064:19:28: note: Double quote to prevent globbing and word split=
ting. [SC2086]
make: *** [Makefile:21: check] Error 1

