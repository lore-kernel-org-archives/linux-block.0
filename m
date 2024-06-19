Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC9078C71;
	Wed, 19 Jun 2024 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718785316; cv=fail; b=kkNvpJ47xI+Y0jP5rYmkJQP6y4+tWHT/t1f0r0lKrzYg9mimjfhaTAsoXxXjBnTqIz/RYLQ9oeuR3p9ztghIVXgHr9frQa8B3w18audB/N2fVVPUT+ehfuMFcsNNwWZlsehGph+pnO3LP3JBJjtIjbUf9gPJQkaERRwFvH57N50=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718785316; c=relaxed/simple;
	bh=5q1/0R5KLGBTQA0MOT+oUF6pMTi3UN4xZRLiHj+fbKs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Zsy+lRN6vlQQ7nmh4nOYeFsoNb8SMhkCmkfT18wgbKvGWKasYOo3xR93s1jLUei9qnwkriN+7Xx7hPv22UZrSlVlsASs7ICTQ2yzq+7D29LvZ/YZwbC1CQtQPC/lpAKZ8GJ8MmSCPzBi4IzNT2pEchk47UR44IxrEJokqD42/sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gancKDfm; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gSUA+pTp; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gancKDfm";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gSUA+pTp"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J1tW7g031296;
	Wed, 19 Jun 2024 08:21:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=+1p7adT6Z971bILDbpTQx/IWYgATyubey+yJVEAkFfc=; b=
	gancKDfm4qBVGo/qHDp/uW5l7T7C+HaXhA39fzDYdq4JOZ1khiSNPUmL3+lDHB3S
	IcVd5MPhNJgcfi3FKIoMyjKlsmnS2ZewiQxmcYfEh0xo7/5DVPGrile1kLwVkZvx
	gA5zrkkb3jvCnp+4toa2L8wvozrl6C+D3bQF1hlA6N7nU6GpQ2aEXouZhkaWG/6C
	X1U2hwK2pKe0xbz45zb+sVBbZ6uPIK2TTd7qvNy21L/WKHXt6QMruL3EFxTaEeUQ
	ji1C7MMB//PR+uQkY4ET8AriH5OLbPEvVfLU0wVQFKcxytfKRNJ8rLcysD1UK1D3
	FYcbur9hMdi6JqVBafMd6g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yuja00qrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 08:21:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45J8HVK6030653;
	Wed, 19 Jun 2024 08:21:38 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d90q9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 08:21:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L7NaKDz6SZgcnZb4JDgbSDrVTwNVEAhLmCpi0B+0ZiMX21tGgT6AcnkdQ1VC5wUm7aJgSxq/cafa/9vdRr7uLKl+qZl+LZIGzb6dBveam/Edy/i+1EYV8FzmDymsvHmWcX2pCwTcH6QodhmWjy1TJsjZbsXhOsgSTzqkE8NhmCBRSDMRExEWVFP2q9ok8lKzbS8CK/qO7kLXt3s9v2JNF0+/JVwI415++dPi9M1vxar7y+GLg/ZmwhmFcoACR0hsVf8qrIRYmlvxqAvUvqbeHWQbQGYxKdYiUEd43IuGQCoIOQ1331I7e/BIoUoyNimCOThhZSKSHJaUov2IZKzrxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+1p7adT6Z971bILDbpTQx/IWYgATyubey+yJVEAkFfc=;
 b=BA9CeW9H6uW+POa22kV6oad2+koy0TDYw6IpYAFVq6Sl9dLVgmJ/M5lmovEzask8PfdUlhOW7M3d5bvE9jAwzsmvj3A7QDriqs2zNG74/6Nv3GjKFkgDBSUOatFqIGmwjATDsokpdxcXrirHSsB5U7AZmBuO5Wbecs52e5h9AXChWfSxN62q6Y6n9NScnEVeExQt4t0gIAY8mZzj6EVxTgNWm9Cb+jgYXkTZ91U5vczX02ZDyUjcVd1FqZMHBWUkGHbd9b+9zRib9sgVrbhvNQgoZwdGMQ2JYEd+kKSwfaFDTsjVXPjI7xIr+zxuLgEgnlJ4HdpmxBbXoPmQQsCDEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1p7adT6Z971bILDbpTQx/IWYgATyubey+yJVEAkFfc=;
 b=gSUA+pTplKv+vnjpRrZ/RdgNSnNvwkff6e3O7aW0Fo1vIFiBfJviqZWZ/yhE/YGdvw1N4GadtP2RiTtN3tX4k6mqeAEB7/y4JJO0X0hwfpAWxeBVKTpr/feOgkAFkEx3Q4+brsVD4cODnH2txasOQUuUz8TVhDypyF/1mBMAEQ0=
Received: from IA1PR10MB7240.namprd10.prod.outlook.com (2603:10b6:208:3f5::9)
 by LV8PR10MB7941.namprd10.prod.outlook.com (2603:10b6:408:1fc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33; Wed, 19 Jun
 2024 08:21:36 +0000
Received: from IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1]) by IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1%2]) with mapi id 15.20.7677.030; Wed, 19 Jun 2024
 08:21:36 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yukuai1@huaweicloud.com" <yukuai1@huaweicloud.com>,
        "axboe@kernel.dk"
	<axboe@kernel.dk>
Subject: RE: [PATCH V6 for-6.11/block] loop: Fix a race between loop detach
 and loop open
Thread-Topic: [PATCH V6 for-6.11/block] loop: Fix a race between loop detach
 and loop open
Thread-Index: AQHawiDxSOf+1W/UnkG1CxXEGa2wWbHOvoGw
Date: Wed, 19 Jun 2024 08:21:35 +0000
Message-ID: 
 <IA1PR10MB7240896628D86A86E91DE9E798CF2@IA1PR10MB7240.namprd10.prod.outlook.com>
References: <20240618164042.343777-1-gulam.mohamed@oracle.com>
 <20240619081601.GA5434@lst.de>
In-Reply-To: <20240619081601.GA5434@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7240:EE_|LV8PR10MB7941:EE_
x-ms-office365-filtering-correlation-id: bf2359c9-3b0f-48fd-d46d-08dc9038d5df
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|1800799021|366013|376011|38070700015;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?bCYm73/RVw4HVBkBbKeKLMEOjGqyHmORK3BFYwOfIEB/ANmW/I9RVVk7QE2P?=
 =?us-ascii?Q?wEemcE4TmDaWGgc9m64zRDJjuaEKoZamxR5q94NgBgpRUjrIlB7ZaAT/3CgN?=
 =?us-ascii?Q?HpG+k2zSR/cyZjTnJsRCbb9NKRcTFnIV+2s/2L1lqXpqbBIl1YfP1dNtKIrQ?=
 =?us-ascii?Q?/kQ2a82zROP0CkpyW6ds+9LZ2O+2mlBtWCHyxipCEIGRQRXf9ZHkq7jxgLj1?=
 =?us-ascii?Q?rKMj3LffpwgMicZR7YL4NXYepxQfsF79rzOkhbLiL1Zmk4oSERHOMu7O65U/?=
 =?us-ascii?Q?ZqE4ehKctvEOGXwOPqM4Om9jVffSlbX1dQLXosIlD7t/drmvCKdAXGpinazi?=
 =?us-ascii?Q?SRuRvdiJlhPpAhpioekwkNvQ9v+gdhCm8QHmveiNFau/6zp22XhSek12boY1?=
 =?us-ascii?Q?nNFOAIilES6V/vmtruxz0BTOZ/pQ4ttdMm5G1o/AK0f7TCpEC50moX5CBaKM?=
 =?us-ascii?Q?iD6H3+4QFOI3eLnIoDjBvxh/q9nlwOHlXgCnkk9ZnPKrtkt1JCFo6wqEXyhI?=
 =?us-ascii?Q?HCrBEZkrviA2wGTkWcofSap5+EwVQRjcO7GDVl48splknI2ysa5tfuMrzcel?=
 =?us-ascii?Q?H1xGhLw18ADGHXzJwI2YoB7wTvqFdoU3dXSu3zi/Ip4VqsOXIvD2RfJlWOEU?=
 =?us-ascii?Q?ztP8tz0fTibRCUnxHF94uCYeoMmAMgxdX+0BOGPx9Fcv5eXCQ8c9Uv8UT/kP?=
 =?us-ascii?Q?7QdcQwrg8h+MLwtzV9Qbch1U3KkZhlKNpgFSmEWsV59XGZRs71cil3PXud9F?=
 =?us-ascii?Q?9JUBB97Uyjv5qIqsbmU7iS9153dYnEQK2FaaA54N/+IIiUnzeeqIyCXokNnJ?=
 =?us-ascii?Q?Ap5QuFwg0ktSK1QLjPbb9IEeAMD8E1NgrXCgPEz5eW9D3p+friYu0GNxYHyx?=
 =?us-ascii?Q?lce9hJ/hiBIetUsSROdiHG9vJYTXPyMusF2ZoZ4/+wFUqO3luerdzPkPS2dx?=
 =?us-ascii?Q?qkic+1+BDm805aTbTE1KERtnds0nmzHJI4RtalyIfP38GKX+snumKqs5/wgm?=
 =?us-ascii?Q?hYMeEnPG117WxeCeNJoG9kpXBeZVUfT6GuL+2g5IzamnX98eQO3+DFOhmA9c?=
 =?us-ascii?Q?ch6+Jfg1LI48gTS2J3xrz04StEeHUbqVnC2GboI1pNyuUZLmQ+cbqSbdAEts?=
 =?us-ascii?Q?NpGVm9lDiLRHoLrD0ZVR8uYgqposQ6AmIYYniV/s6Vev5h594SdUjRpCus8m?=
 =?us-ascii?Q?04ovgLbkFMcLNlqNtuyX/CpAqHmQEZcjiD/KyvfEkHslqlU5t+AO5lUnJbUn?=
 =?us-ascii?Q?LCkH2f/cv/RlRhHsYh2+KH+rF85HLow8TbYUHH6OArIWaKt6ohQVtp8sF8rR?=
 =?us-ascii?Q?ylKKx5jiHbPETbn29Rn3YGrAeNknz+fYiZYmUooQLsXSM6TpFFsYGQCGLO84?=
 =?us-ascii?Q?AhlGRGE=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7240.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Qcx0bBiQ/LdA+ZbDIgwf4+PeRUjsdsp0x0yrOPSM38gMQb0wFTBxK6PGQ+oU?=
 =?us-ascii?Q?o7x9U3X//gMCEHp/qLycVJfSMy7D5XiM2t7fHys/ZIjefTBGPeJicABnKFn8?=
 =?us-ascii?Q?QKz2jkPq57QN7Gy1X8jgCpZcdD+aNyR5uhh8qJ+0muI7ejiICrKwe9b0oUro?=
 =?us-ascii?Q?RGsXq+Pja8b6YvjeMdjKioG4p2ITB5YlYCtpdesL7ehqFpiKqr8tF4YCyxo6?=
 =?us-ascii?Q?1VtsS44kFmawmKPZFRlLHyHcJXh2A2PxDjXLmNavN7IOIRmTBpkIUMuacZgf?=
 =?us-ascii?Q?lRTej0sEuBVXvlpLlAUfK6y/fx0aP5t1HKBtTKNxkj8pXMbI11oejJLCw8qT?=
 =?us-ascii?Q?uDRJK5qoDujJSFBv1l30zW86fSWZnJK04ozNcJTWd1wYBAC4DsqWBAgzxbw5?=
 =?us-ascii?Q?KTFxry/ESzouILxI4W9AMLFQWEi60HJ3AEFU928uLJSC+bJz0Zm09th3qvzH?=
 =?us-ascii?Q?atBYPBjJ9c/tigc5hYTXf3crlVDVfBZ0XkCAH1Hsuh4LCvKXihHhYh/RdUwx?=
 =?us-ascii?Q?4vkEaUZpF0gPTVgwGoP5vDXjQZPN6I+kjlt11CwNYVWWRWsk3NbzpdSiTJTe?=
 =?us-ascii?Q?zvdIJ+hhKURu1uXoX2oLzC3W5QJXfi+LbO7t/EmAZffn5+fkVQbdDzgPI7y5?=
 =?us-ascii?Q?VTnusAl1rhTBuY7MhkXynq39beMlQDAnf/H5LzBxLpmX7W+z47Qchy08za57?=
 =?us-ascii?Q?iUKUVnS9eDSciF1RqWTnyO1avB1mbHTjocPy29EBXUwe1Z6Cs2gw49yeyXdm?=
 =?us-ascii?Q?YrCzsgmxdK8DvzJX+GiZJS2jMfEoKT7FDgdMFmAJjPXUaz8oFWSY5U0Ed6pf?=
 =?us-ascii?Q?SH9gS9PBimLNlJ4kUc4o3hs3AkKuexVsQM8ykiOD7tLS9Osh6YYSTC24hLt/?=
 =?us-ascii?Q?sCVasKQhuRHY1hC+ESNDlIdz0/cQbgPM39ZJq7hM2BU8/t30T2NUcWj1m17a?=
 =?us-ascii?Q?c0YofVPjDpwI5IDqGEMs6XrNZvYXGne3Kp4ifOonOxURArjcKaEu+/QcTmIH?=
 =?us-ascii?Q?7WBuI0DrCAuP9Lm17fab0BFo4x1bMomdsqJgjFD8g9P0Rr/0uLWGSJk3CAEH?=
 =?us-ascii?Q?DUJEQMtVgLbY1fr4+UKeQu5u3TZ/cEyIT969cT7ku1ShAxbKAsNABZtheLcM?=
 =?us-ascii?Q?tDjE8MxdrA1n7VLKrLF4/hzxPpurFvk00rj7QKF5uaY0tPfjGyb+fx6Dv/ni?=
 =?us-ascii?Q?9jvwqDYH8ya4wHla6HsLxcbaE0/TTKB8+E5hWiPG9Te+aOtg+omoup+MRqUc?=
 =?us-ascii?Q?2Jh7oePOrejsVuyzBitD6T2UcT1bomJYu2IjhTLfgU1ktliI1GnXh0T7dnXh?=
 =?us-ascii?Q?SS8KqjGlS+x7JYTq/9hP349xoxJFunIkjAjSCHj6FYkKhsQfOVYalQ0TSuwD?=
 =?us-ascii?Q?IDA505elougSdDdt5+bJ/peT/oCwbPojmKtrq+3NN77zE3sK63IUDVIpRQus?=
 =?us-ascii?Q?bORCo6KFrcwb3WK38AFp76SxMISx+fdMrlALz5XMcz+s/O9KFSa0ij1C/EIz?=
 =?us-ascii?Q?Lyk5nRt40DQeeVpi1qtlDro7kxpD/6oKokxSyDcV6rEirqUmOTxX8xAuDxzq?=
 =?us-ascii?Q?bcmL9y+634lC5+6MwDFNZMcP3Q4wFrFwNSYW2uNl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	I28/IAIWbqlcKN+OFI2A40M1kkvOhAa11Oyw0fuv258kiJ3AqonwtprLenhvyxnNzWTTPZaCoDhAZD9ynh0E8xUdCn0Ybb3w1PfPxzHhQdxVCUBORNwd0grpgwk2st7HetS2+D1dCGnqNit8fhK4KEZiMLeWplT0TFycV5sj6A8w07U4qASKYNfz5OpXUnlwgyTyMFpxkUOOCUUcnRCBHPU3NBSaMSL6QB0TnM6ORKdNi8GGfploI5GTRwR2/Ko+LeQbDumgMTc+oUddApFBZO7Mzn4MOSG0hrXNac7BJheoClDFEJESw2r2BdTrVwOs6mywuXw5fESzj4XExaEwqa2yGSiLG1qlTqceB2LMkl+eeipE/X/2pZYMRSyic+S+zIiMsstfCs4YtcxoQoR7t7hHCV/j7RPawS1eTkuajUYjG9xPPfu6VxYLUl3z+PFnox70VtofPxZWKcBCUR4PUXIJ0tCiYJcjaJ03SwBQI3i5iemdtLCRlbeDoGy+KpydlgGz21xhOhT3t4Pc+B/nrcbphVuNBTedPGLsaG519YxmWGJRRn83SQXW0628KbZ7+OYZdTtGYtdnP4DADgXjgeQ5zDADo5PjNPnRgzCk18Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7240.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf2359c9-3b0f-48fd-d46d-08dc9038d5df
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2024 08:21:36.0180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o3yxpbGF7inPi71NyuYhIhg/vQNOQYlh0waDacJ/JaOqPYzpItlyzCEzAGbHWK6TY5DWE9nHA8y82RoxFbfwWtIyoR7GTsDUnFbKSZUQ6t4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7941
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406190060
X-Proofpoint-ORIG-GUID: ewnQqIXmRUvjDMh8nY07QESutQlteNOi
X-Proofpoint-GUID: ewnQqIXmRUvjDMh8nY07QESutQlteNOi

Hi Christoph,

> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
> Sent: Wednesday, June 19, 2024 1:46 PM
> To: Gulam Mohamed <gulam.mohamed@oracle.com>
> Cc: linux-block@vger.kernel.org; linux-kernel@vger.kernel.org;
> yukuai1@huaweicloud.com; hch@lst.de; axboe@kernel.dk
> Subject: Re: [PATCH V6 for-6.11/block] loop: Fix a race between loop deta=
ch
> and loop open
>=20
> Do we need the re-addition of the open method to fix the ltp test case?  =
I
> kinda hate it, but if that is what it takes:
>=20
I don't think its needed but I kept it because your following comment in th=
e suggested change says " switch the state to roundown here to prevent new =
openers from coming in":

+	 * Mark the device for removing the backing device on last close.
+	 * If we are the only opener, also switch the state to roundown here to
+	 * prevent new openers from coming in.
 	 */
Please suggest.

Regards,
Gulam Mohamed.
> Reviewed-by: Christoph Hellwig <hch@lst.de>

