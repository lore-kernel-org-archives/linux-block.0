Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FD9137772;
	Fri,  5 Jul 2024 19:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720209104; cv=fail; b=okt+3xhSD+blP5ECcL2rTde09srYU3pcAfeQj7Im+Iktx/LUdGsR+3xQ73UhQH0wsKAIhAhBL7gsj0WQzrywDqP+rh66+uD+doc4YHFN+JMhTQvbajDEG/H3IEh6bIGjFd+MZIV0b0btaDc0icPccrpmPBS+vG6zR2nw1w38Unc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720209104; c=relaxed/simple;
	bh=vOaWnAyhmqdmFbfuZ+L6+ZJ7w6ONjcQm8dAhcpBMwg8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HtaClJDY4NAlmSUGkhb7rplrxwA9P497fNLCogljYqpJOIj60YL0kqddLtMH2rICz4a37GrneYjBXIuNqEJqx7YoLzVArKK6fx9qlHq271+wnZYDiJqBXhUO6J5yVjzoA0/iSasS7SZj5iRlnfVF11lX3R+NRJj52Yt8+/3/0kI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Pn2NSTwE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Uu+kYrFZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pn2NSTwE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Uu+kYrFZ"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465GNHZI008619;
	Fri, 5 Jul 2024 19:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=pZZA9tcdeOUy/hZsISw9H88tBhHSjuswrzX5anPTcEg=; b=
	Pn2NSTwE4tig8p/9OiWJOVwhviUzaP35HrgwyAjluAh2/mcG5d+48MVEH2akNizW
	jF6Y1aQp+g4KaGrGjwwAWQbQsvC4X1KkyZX3/CSvmHf5o9xA1sKHYZJmO9H+8Rit
	sFHi7gG4L+mj/i4wIijnOMUur1U+yVkdtV/bnp3u22RJvmAhtQmgROzhSundAlSg
	gewS+T5+Q9YIyRW8OfMO+JPlsODnbXAJAlvi/g+iyBDHRxXKuEoOigi7BIh/z46z
	tFT71Wu8096/WSv3ycmECPBWaJ/BzbEmwfhJYkZcPTuscJy7FuR1ln9nc03CUfmT
	3nxBldUi5HrtMp9/obmf1Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 404nxgp0xu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 19:51:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465JWfj9021461;
	Fri, 5 Jul 2024 19:51:27 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2047.outbound.protection.outlook.com [104.47.74.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qhrusf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 19:51:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nZH0KZAXV6DqjjmZa8v8S8axrXZB4tjK1fYX52ewHsI5v1L60yHjF3MjolcXgc9L0S/AW6Q+vMH6rrHmdGs7GsJFMw/epihREThG9qAxslfZE+AcDzgkek0CCPfohFlqzx/kbfy9jEn1YalmkTzlnPVBEC1C0Y9vvUvOsLP9uVhsNptlRwoD3JTZZ1A00GVJTKqp8I+nM8Dx/gsYJEJda0B0pl1/wyvKVtJUfyPdeDBtPPb9H9NnFfl+J11CJQV/3AF6TPmPbZ1GTG4seZpr8fW3iUPfcJNK+zNEyuO5ZCFUPTBWX/vUhtso9sfWpjFKAQINAR8W6F695UMyUtDlxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pZZA9tcdeOUy/hZsISw9H88tBhHSjuswrzX5anPTcEg=;
 b=nXAOqHIYnrUN7mxEzaHd5u7QDWycgIocGP78cjyivoXe+cXNDejrAt/vE17yxmooZ3ah6a4Kijt89FX6FVQwiX4OHlSvomhvijZq63+RVMueOzB+NfqvJbSf+pTfkqnFT/PYy+VKSkqDLddi1mk104p8eXDVpg4XIGdgjwjeOuEecMgvF9rpXMDesKykWQyQiIWS61T/QV0XVbajzXAXcW1Ld5BsVa9/02RK8pdZBo+xjw6tFnfPZdoKZNPz3/BtRLNTTzc/zK3LV/P5Co+3aHYLzXnWaUOWYBYu/iLyRax4Jw14LXoFz/tAiz5EgU6tTVgvjcWM011VvgOqcInCQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pZZA9tcdeOUy/hZsISw9H88tBhHSjuswrzX5anPTcEg=;
 b=Uu+kYrFZfIsDiW1SBESpCyUtZjj6nm1IGr/FsOlQGFutAdKOxWSdInD8QkkhtOJbJ7zpOiFYSGuulWq78jBIdYcFpj32gkaHjdWlc9QzQ1SmVEBuE+qGIc8qZdZRHlU/eXvgkt9/QvarsSUKfYEccFWxMeABiOvypmVmtOcALxw=
Received: from IA1PR10MB7240.namprd10.prod.outlook.com (2603:10b6:208:3f5::9)
 by DS0PR10MB7363.namprd10.prod.outlook.com (2603:10b6:8:fd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25; Fri, 5 Jul
 2024 19:51:24 +0000
Received: from IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1]) by IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1%2]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 19:51:24 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: "hch@lst.de" <hch@lst.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yukuai1@huaweicloud.com" <yukuai1@huaweicloud.com>,
        "axboe@kernel.dk"
	<axboe@kernel.dk>
Subject: RE: [PATCH V6 for-6.11/block] loop: Fix a race between loop detach
 and loop open
Thread-Topic: [PATCH V6 for-6.11/block] loop: Fix a race between loop detach
 and loop open
Thread-Index: AQHayR2JSOf+1W/UnkG1CxXEGa2wWbHg4dcwgAK7AwCABPni8A==
Date: Fri, 5 Jul 2024 19:51:24 +0000
Message-ID: 
 <IA1PR10MB7240AE0551BCF41FB1A69FD198DF2@IA1PR10MB7240.namprd10.prod.outlook.com>
References: <20240618164042.343777-1-gulam.mohamed@oracle.com>
 <202406281350.b7298127-oliver.sang@intel.com>
 <IA1PR10MB7240DE46976A3B027DE5484998D22@IA1PR10MB7240.namprd10.prod.outlook.com>
 <20240702155020.GB1037@lst.de>
In-Reply-To: <20240702155020.GB1037@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7240:EE_|DS0PR10MB7363:EE_
x-ms-office365-filtering-correlation-id: 69e21119-be4f-4200-86df-08dc9d2bda2a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?Ao8ESgO/vr2Gwf4OTG7ttenMXFHhZFC3MuoAeRwoD+3iCxKuczG5iAhWz++K?=
 =?us-ascii?Q?ZN0DU+IniFGNZwHxtBIApZTI4hWY3X+oXSgMOAGNnvOI59DaeKTYKNhkEnNO?=
 =?us-ascii?Q?bQ1lbn4BoRFsYnI15nC4u0AkA3ohBjadeI9S8RBO2O6lvBP1hILbrbOOuiQM?=
 =?us-ascii?Q?vFWpUAS0qvZ7/4JtsonaNWFcYZtjEp80/kptVMfIviRXa6oVnkmEpNk8mEe1?=
 =?us-ascii?Q?WyCGAreZtwlszwm1FkQMcjdy/FWWmYNig1C5dFjFRdtpX5L2M/+CgzI9hIjt?=
 =?us-ascii?Q?/nzONY8+66oMoC4DlekaiW68KFwTt8VD34YjuBlTyRybcCrRfIRI9O3GlIvH?=
 =?us-ascii?Q?d36+nTqr8cXDLqo7uQ01/3Keo0KU4YYq0pxqOBreSYEcSGiv8X9gfrmWcM2p?=
 =?us-ascii?Q?vXqUziHHHs5qay/+6H/yPHBjO5+LQxYGDI8qSTwSsOdiwzvB0lhpnBJKld5t?=
 =?us-ascii?Q?n7wu+jKgTK32SV8xjWd2NSlWzHJqBxwUs4wZYdt/k5Sq2A68AD1DRoahBHo+?=
 =?us-ascii?Q?FlupajE1NGYqQXv8sP98G3KexTTDlQF0llYnZ4GF19lUQ3AY4sjXiUZ/sOOw?=
 =?us-ascii?Q?PrRXXJ/ObY6EdTz5B8SqKVAkFoWcL08n6GrQ/Nq+pq/jOLJNYWceGXEHyru6?=
 =?us-ascii?Q?CHC0J2RMk1wB3Pme/xwYn/2y9oUV20ShyWPhYuJgX/RLSJgQ61bf39CxNTeW?=
 =?us-ascii?Q?oFTszbvdpayY8fZn8Bi3LJwsLUJyDhuBAZxK8t0M2UEkZLQAkSPD2SW/XGT2?=
 =?us-ascii?Q?aNVthCU/S2O01YsU+3TcuJtv9wwH90z+OHu4Jp2SW20EwIS8lzrn9WrvleHz?=
 =?us-ascii?Q?LekMg83qoGXN4AToEFqlQEicK69t+kT2IJH7prw2L2sfJVVNPoPwsaQG9259?=
 =?us-ascii?Q?yL8tcGv2YUxgy4DiSC5CosIu1cVHb3biiw0gB3PPqjM3+xDGIdURsQhHnIv5?=
 =?us-ascii?Q?EYeZDGaob/BsepbywmRFON1kIaTyHLFWzXM6/Mh9Eh9KuTDXlEIGcvQhR3aw?=
 =?us-ascii?Q?kFC7RiftVCPAF5XlFUJMpkFNZvZUiEnrLqm3dJTKqo52DPniiqvUfsEc9ZFY?=
 =?us-ascii?Q?q+K21X20yHyPRU+7+l9d6KhNhgwUc+Eb6CQy9grw4HS/z5ota+I5tBKKJn5M?=
 =?us-ascii?Q?/wIr4YOthhvDTsar8IDCqZ6NXT0xbfGnKEXvA5y6gbXkucxrgNQMQunagpQ5?=
 =?us-ascii?Q?I5H6FThM8dlkuhtaEEsOh9x8nZ9ud0W1EZkCC1a+hfyaTD4OqO5HCuBOlkY5?=
 =?us-ascii?Q?7hvIZhwSNAQDdRpEInfkH66xhz7EFiLWigyJc/sQRn2/Mi768anBZ4ZG0C63?=
 =?us-ascii?Q?FeOHhAhk6Z7M0MbOaIaEDgaNSJ006ALvg5UnP4lghwSpduB6bVoK6YpWRZSW?=
 =?us-ascii?Q?wTC2JAueOBQz+suw6PGGkY0eITYoKnEWPiXYkjr0OYWpkLBklA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7240.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?LUYhWT3cgceswB3n2PQcTPpJXEfVFDLP4jyYVPx33Gq147RsUH7NsQ+eURah?=
 =?us-ascii?Q?dwNxfyodDskC+Bsf57PNv1PN5NcZeRBGG+y4x6+Ls0XnvYpcnisfqv1w8ulo?=
 =?us-ascii?Q?EqgnzGBOzQjvZmKlyOIF3BM4es1VtkQnfmE5Jm+q+Bo/HqmO+5hBiioTYQuH?=
 =?us-ascii?Q?0dnHgdIu40mTtPKZPT3l3oVc9JE8lpTc/mgOuNqnqissy5o/d+fKGLxAFa2N?=
 =?us-ascii?Q?I7AtTNdEsMVsY5NQIr86EUiWVGm/6AGcEbq8RiBq7k8jj+u5JGZUdDTagpkC?=
 =?us-ascii?Q?kLl5MY1lcASGhl/zJFX83CHwFG5X1YNyiZi1oOY5+gwLQjH7gFR/rtHj1yNa?=
 =?us-ascii?Q?b8CyxQ52MSHwoS1/UZlaOAVgESFr1DovKS77Hr6YLxIHPbX8rNQQgZHC+ggD?=
 =?us-ascii?Q?P2P4dApT02ZX4BjWjcnNHNLud4jewJEnjV6Y96nApOGgkcVnagQiGJMifU3t?=
 =?us-ascii?Q?pfNn0lRmDAD3H69qfbPsVRDKFD+gZNjRe5rtWaCwb44Pel17CiPZtU0Rrkq4?=
 =?us-ascii?Q?bsPK96woaa7T6ey69hSQhKbYAQAm9jmOzVTEuFrbDrgsXQW0hfaiUhayDOkZ?=
 =?us-ascii?Q?ULiayK3kQ9DB8CKAMpBXy7jkZ7w58Da45rI1NC8PvnZuMGddO8OCnWHToFWa?=
 =?us-ascii?Q?BTzKucMTzgb2FAKzhFydn41ZRFZO32sc6zpFYnZbNwvqb+oYmc5oByBnEX4G?=
 =?us-ascii?Q?q1PVzxyGa6AzIp3R+t9zc17U5nmwe41M4ABXnlNnFST8/9Xv++HCLzv/WPlg?=
 =?us-ascii?Q?9WA3nfpOnOaoqEp6BkN6YwpUo+gEBrOpPAAqyELgpBdSxuLUv4/R8ZaY6LtQ?=
 =?us-ascii?Q?jQAtl/bbVQuIdaxat9V5qNBlLB/tmSGBdtTpygOq4Gz777RU1Y4sw1yvpWSn?=
 =?us-ascii?Q?Ek6EemwSqEfwfQNqEvT039aZ5GszGa7nyGzc6j7lr5O/eebqAO9PXfNNsDFv?=
 =?us-ascii?Q?slwuKRjSdNVXw0EiB9jb0J3OMUilI0EXnf1NApqGYn+iGuds6AzRgmzVsKsT?=
 =?us-ascii?Q?G9fcVplrJ4esQ9wYfbfsed3xCiA8jdjwtcd4AniG82BCO9QoPW5+SoyLEfTI?=
 =?us-ascii?Q?WP5SgRNU1S0E9SJeN2lzP1gBP1qReERUgjozCDZGnT3JUvfe36/P2PP37DTQ?=
 =?us-ascii?Q?8mFPSpiWEQR9kaxTb41IZv0wYZV545vgp+N3xVuPs2kdESXqdKp6xH/NEaEa?=
 =?us-ascii?Q?XD7eVXV8gNUgc9B9viMZXef6uoiKNThxsaUZlmGE6lRbcqLlVp0m0hOS+aSV?=
 =?us-ascii?Q?x1SgQX7FUBjOs1IVmYjAwVYAZLooBUtOlqVAGu9ktQRBZWx1BVDreWJ64Rhr?=
 =?us-ascii?Q?8HVPuGvGXlOuIS6ZHVDTXZKKT6RPLKIEI5mYRTIxh77GYxpKzF7otSfvprJl?=
 =?us-ascii?Q?NGqOzfI2wVulh6lqj7c9f0cYLuSY/SWg822Wt4eNFwZ4uzAlV/O+2DiNOSc2?=
 =?us-ascii?Q?VkAJKov9Sv/cUKQHVD57XCPuuFW70G3qsRmUHnmhtrrC5GLg5jKeBRAul8jz?=
 =?us-ascii?Q?TK8ovLEDS8MRgwllL8lCBc0KGeBHiOhdKda2Cft7F+azj5+GfoenZxs0Vs/e?=
 =?us-ascii?Q?ccBc2E0wNNqmVuaUqbBvvBMB+4HQiTaYI7+mB0fw?=
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
	+Z5lAdHX/CUKqlahhZeR8faAecoGYqZyBDteM0taayilk1oJfRfz3vjdBhaTkCvveMVISPQDFaZS/Vg6rV0WP+Xos6OE1OfwzPp1yRYzKkAq97iMLO1zxQXGM5kO5ZJ1ti/E8RKKzylyzXSCLxQOIwydC4HyN7iPJs/wEcDbfJ6LqzepV2/JB25ab5KHbiCtv6OWXIkdw3JLSS3YCzsA9IUJ9gyy/QbACUq6Yp1c2FGuz6ByrZgdO4pLAt4MlXANqmKA0E9fSN/IUsLUNZ4INXCS9VrWiXwcNUIq7BDRyxzu9jkNtnDCXIkbmuieviaoRi8+Yt8Yw5QVHniRUOeu+SgDg6eE1oHBCSRGF92wbkUn9cnzMpwGNavYI7jFdy4Eq/p7EKgz7wBsivif7XDJPR3ULAHMwTi0iDpapSYuKi8R2z4DXmqxwDQ2HLqrLe5FZM0NrBMLkzCqlFAibG39tj4uZN8wcNqjpUhrYfb0ypvwn6i5WP3TAZMpcNiYdl2OVAsHedPv1GutZApae+vAc4RaWYotskEbhy1XHUrsKsnBdrsjuQP5XQcTFblh9p6FmHZwTTDz1wRW9/VZ0SxKVt8qP3AmzrnmnnX7A+aXy2E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7240.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69e21119-be4f-4200-86df-08dc9d2bda2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2024 19:51:24.8572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z1pTN4428tetHrbBm+vZm493cFoemPJVaHX7yRkxxkqTtaJqrfq9MDnCTgS3MMGR9bHOugre5x8RcURkshuPjQWq5p07wvPgHayXFns/cwk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7363
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_15,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407050144
X-Proofpoint-GUID: pcrbaNkDdqu-AbziErmOCuxsQHc4_lwk
X-Proofpoint-ORIG-GUID: pcrbaNkDdqu-AbziErmOCuxsQHc4_lwk

Hi Christoph,

> -----Original Message-----
> From: hch@lst.de <hch@lst.de>
> Sent: Tuesday, July 2, 2024 9:20 PM
> To: Gulam Mohamed <gulam.mohamed@oracle.com>
> Cc: hch@lst.de; linux-block@vger.kernel.org; linux-kernel@vger.kernel.org=
;
> yukuai1@huaweicloud.com; axboe@kernel.dk
> Subject: Re: [PATCH V6 for-6.11/block] loop: Fix a race between loop deta=
ch
> and loop open
>=20
> Hi Gulam,
>=20
> On Sun, Jun 30, 2024 at 10:11:14PM +0000, Gulam Mohamed wrote:
> > With our latest version of the patch V6, the "kernel robot test"
> > failed in the ioctl_loop06 test (LTP tests) as in below mail.
> > the reason for the failure is, the deferring of the "detach" loop
> > device to release function. The test opens the loop device, sends
> > LOOP_SET_BLOCK_SIZE and LOOP_CONFIGURE commands and in between
> that,
> > it will also detach the loop device. At the end of the test, while
> > cleanup, it will close the loop device. As we deferred the detach to
> > last close, the detach will be at the end only but before that we are
> > setting the lo_state to Lo_rundown. This setting of Lo_rundown we are
> > doing in the beginning because, there was another LTP test case failed
> > earlier due to the same reason.
> >
> > So, when the LOOP_CONFIGURE was sent, the loop device was still in
> > Lo_rundown state (Lo_unbound will be set after detach in
> > __loop_clr_fd()) due to which kernel returned the EBUSY error causing
> > the test to fail.
>=20
> Before we'd end up in Lo_unbound toward the end of __loop_clr_fd if there
> was a single opener.
>=20
> > I have noticed that a good number of test cases are having a behaviour
> > that it will send different loop commands and in between the detach
> > command also, with only a single open. And close happens at the end.
> > Due to this, I think a couple  of test cases needs to be modified.
> >
> > Now, as per my understanding, we have two options here:
> >
> > 1. Continue with this kernel patch and modify few test cases to
> > accommodate this new kernel behaviour
>=20
> That would be my preference.  Any code that is doing a clear_fd and then =
tries
> to configure it again is prone to races vs other openers.  It also does n=
ot seem
> very useful outside of test code.
> But if we end up breaking real code and not test cases we might have to g=
o
> and bring it back.

Requested the maintainers of the LTP test cases for the modification to acc=
omodate the new kernel behavior.

