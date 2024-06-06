Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A4E214F9CF
	for <linux-block@vger.kernel.org>; Thu,  6 Jun 2024 09:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717665082; cv=fail; b=rUKGhplKNKlAUxu2jjzJVS+qRja/kB92J5yNfEtAJLQ+FZCK3HfKTO+X5qCqfGD/kAQ0jutAI2eUyDW0W4qcyP59eDwKlFCQV+2e8HYMFFCedlK1fFkBkU5TOP3Dt52VF1kA5WqeMckFrndhcRe1RkJfTJ1/URzkKLyyjNscO9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717665082; c=relaxed/simple;
	bh=t/fhHHGrME7BIMwv4QM9o1Skq00o1i8a9vm8ubi1n+s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=R5PuVrtFJooVBhminp8MFdznLJXGl1VuWswSKBfWj3Cotu3mUpnvdPwsXnQ+zM3SMPBeeWFnAqPhHDAOnWJPEXqe/3OzlE5THUyuRBKp3tdKOxxl4vz5LG+SoHRO3/VpnX6qZ2irFS15qM9wajgnjXt/+wE2SaEVbhY86fH689M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SndrHLaf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MGvmlN74; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SndrHLaf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MGvmlN74"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4568iW3D020942;
	Thu, 6 Jun 2024 09:11:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=corp-2023-11-20;
 bh=t/fhHHGrME7BIMwv4QM9o1Skq00o1i8a9vm8ubi1n+s=;
 b=SndrHLafqRFfrhdFiTSFXRoUzyX4XimoraLbvY/BgzyuVe2+xiZHSP/KRunUqDRYkNwD
 clu5PZ1bLHQXTQYacoRq8iN83XFi8WRS6DUSmKC8UMhZXVd8D0BhCdhpUrE5SE7TA7+V
 dg9gntoOowA/FLy5SOsg+l4AhACIZVtVi5jut/DsBva9N9Zx8Fb07XXrdZxY++gnkZke
 zyqpuQIPOta5cip7FIAQZaT2fulGVy975bc0Ug64TOR6ZxzfqZD+e4Ebf2luAhUsVpN5
 3JDPmmjIqdslsBXQ3y5oK5I5CRtTt+jfxiRQnD+xbOJ3Ae5PNBGP98xPGnMI2P7RXDon xA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbtwb2pc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 09:11:18 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4567E11b025222;
	Thu, 6 Jun 2024 09:11:16 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrtb9wde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Jun 2024 09:11:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mu0ec/5yAKsVaWH1VhD+/5IilE1JsNfmITKrMlXEF2yzFQ7IM/IDfNB8dZC7nCn5mDmGwzMOVXpGJ4ylDAG2KdoJ3o8fQEQRDwuQizIfh02DcKlD0ucwlzmjtHds3FNS5Z1Gtrbl+lW4wJtdstkgT/Vqx70GyDIkSi4tPMd7hhUIFykXmwbYdc94DzfX0G+cy8XrITBFMEBqAiNl8jgE60CUR60LjSDtYoNmE63fx1vui37hxWM4WzYrsOuCYt0OEkJIqB8ZwOtNh1nqoKrMLCFhonRQaZcSccBVz7CcwgWF+0aWgbhyJNiXQkwKTRfhz4OFA9PAGmGHxnELq/aUZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/fhHHGrME7BIMwv4QM9o1Skq00o1i8a9vm8ubi1n+s=;
 b=gRksYuciWHG+PBdldStiSdVzemW9UAujCuSKmAm98laHaJkGZUv7uroyqQkMODvGztCWV7jr6saYGV5LKIJ2+EfBtIHk/2xEyoMr3kXCFiCP54BW2Z6FfSx0vqCcrQVag0BQX2pqqwBCxq2nRCOFXvoBDUg2+FxMvxeBdGwvZGSyMbPL+uvqZx+jlph8Z67//DmZ2Sp9c2xm9Cw4vMmg84ptzYZqOPUnq+P1YsPwIm+P7gIXBqA7qGdIzSXpsVYWMF8aM2FvEv7lPYLTD7Rl3KoAwEZrBOyy+2mxVDkWvXNtxIYmwunFWF9ni5YvVf0umixuBMI/ouFyxVs5eJxVaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/fhHHGrME7BIMwv4QM9o1Skq00o1i8a9vm8ubi1n+s=;
 b=MGvmlN74LGnp6vnsY8+cVm96JeOA3N7/Yo36QtsBaYbFUXDXo8PaooB3Eh23UEsrPtjazBi76GyltCP7+2HUvRF/E4aqlsn7L7lHQ26MWCsYYmIl3PTtFdwcj9BJcRzPJzI/FzhmZpnE+Q9DByuFeS4+5sn4TbQ9+glIUnR6OVk=
Received: from IA1PR10MB7240.namprd10.prod.outlook.com (2603:10b6:208:3f5::9)
 by SJ1PR10MB5977.namprd10.prod.outlook.com (2603:10b6:a03:488::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Thu, 6 Jun
 2024 09:11:14 +0000
Received: from IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1]) by IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1%4]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 09:11:14 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "chaitanyak@nvidia.com" <chaitanyak@nvidia.com>
Subject: RE: [PATCH V4 blktests] loop: Detect a race condition between loop
 detach and open
Thread-Topic: [PATCH V4 blktests] loop: Detect a race condition between loop
 detach and open
Thread-Index: AQHat9cmzkrqQGQ8Ekin/EqHKtP+RLG6cxFA
Date: Thu, 6 Jun 2024 09:11:14 +0000
Message-ID: 
 <IA1PR10MB7240BC80176D4F5729CE27CB98FA2@IA1PR10MB7240.namprd10.prod.outlook.com>
References: <20240605161815.34923-1-gulam.mohamed@oracle.com>
 <ymanwmgtn76jg56vmjbg5vxcegfng2ewccgntmtzskwl6qx42d@g3iyvqldgais>
In-Reply-To: <ymanwmgtn76jg56vmjbg5vxcegfng2ewccgntmtzskwl6qx42d@g3iyvqldgais>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7240:EE_|SJ1PR10MB5977:EE_
x-ms-office365-filtering-correlation-id: a87edc9c-383e-4f94-2b95-08dc86089dd3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?F7wqjHGXIpq00HM3sEntT8Xm0siOPJDJbACOb36e7GcZIeDSdU9PNR15JmnQ?=
 =?us-ascii?Q?M5o+0Tbbl3shp3Qu7l4mnSOvTn3DAU6nDDxPd+JCmuzltHe9DIMuQkgarfvo?=
 =?us-ascii?Q?PXOi6H0yWJn5z68Tpvv5SwBzNPQJdhLbmbSqhmoIZXT87vqa7p59peSKxqGa?=
 =?us-ascii?Q?tiynsuiL8muXnCBBvP2+GWRsHXGWeKN7ZMunMHWXpdBQ5p3aIx0YHw4VxYvz?=
 =?us-ascii?Q?WuU0Jupd89WYrNB59A9ZqxZaYSFngX/fWViFbMEkDEbCfg7NvNRkhvYWbwuV?=
 =?us-ascii?Q?28kiM3S5fYxCj3F1RIUIPdOwAjiMg3sDlHmRgoxMlo8ik9oGOPhwNzIS5JLh?=
 =?us-ascii?Q?WHcYWSzCB51Bw8XfvyXguP3NFqDK2z6qGvU9YZNTy7Uu6Z7kTQK61AsUF3lr?=
 =?us-ascii?Q?fjjk9k28I+TR1OSLCgWeUDSPXyNLMXM8Hfd/wZuoSC4JmfNKBya4LVenhkUD?=
 =?us-ascii?Q?Mi1nEnJwF1NQh3Y1+HYrmfpiH6c1QHjW9yDjFFnmLLhTFx8QnN8/I4c3mikR?=
 =?us-ascii?Q?X/Kc9vP3k2370pXuWen7CjQFDjqF/+qqq1r0rlvFaKk6CePkqFJe2oDX8VfL?=
 =?us-ascii?Q?PaXx4DDbrB4Qgt7kjZO+nTSpFpBRgdXjDk2GYzufGRh/sT9j5vBW+04POxl/?=
 =?us-ascii?Q?jnhgkMzP/71bwy3CwCmNI9q5CDXzIa+SJOu55lkaHANhrhnDqBRz+vSA2Fgz?=
 =?us-ascii?Q?sJ9OiApWLhInHIbqE3jBhr3xVxcc5pi1VMQSjhcZb8I8zK+sXa0N3fREUQWf?=
 =?us-ascii?Q?1AYkcI/mjp+OWPJPixuCuLqT7SkK4ciSx+GRMcI/sDhZnzjaZZyIzWMSqoWT?=
 =?us-ascii?Q?5kkZgF6iOYl2zbT+wmtCTDrcsjOgEuXiBUlKjui3frmllpVtpCQmA8KZD16b?=
 =?us-ascii?Q?bLU5wYqubJAU33hlD20zv7Ig6JWXn2rEogStiCb4hKueOoyjPeJ0Xrl5eMnj?=
 =?us-ascii?Q?mJSmsfChqeY4ztOb3JOJbIN2iILYKrLSBivX1SLIKl9jHyS3/gAzKx0TZ3+o?=
 =?us-ascii?Q?Ut5Ge2gfrkFSXk8UX64jH48AQWPmmEEQSlBbvRyF0NX35FrKK5Rqp4K4XF7I?=
 =?us-ascii?Q?B/EADw7Lk8VxFa3qsr0A1EV6opqj/1Yst2o7/4RpMcb/1T5XTX2ws81DjAv8?=
 =?us-ascii?Q?GJfyLAEd5ezbcyJk0C2DI1ahuFiUDlcTKX1X1ObK1ZjraWb9f6q0BnQPSs02?=
 =?us-ascii?Q?QC5xVFMrfA2z8WVRb2WHSMPMfZ68H9nCRsM5+2U7EYEwM2yh89iOMyyxTPMR?=
 =?us-ascii?Q?6zxFepQOK4snmbLuemVSeGxhbV5T3aefP0Yybvo0MPIWpwIbgvLpNX6kz9KF?=
 =?us-ascii?Q?AaMWZIGjro0lwY6xgFoTocnruCXesajilUTb+pGc2YH61KmlLiF1O3OUJb9r?=
 =?us-ascii?Q?QkgddI0=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7240.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?j2zp3U99prFYEj9FiyJuHiowm2tC9dn/q8S9u0NiWwVmCIKGP+yJ8b6JSDHL?=
 =?us-ascii?Q?dgTRhAGjOzYg54hrP2v9tkmewSgdTKoMyZITEyHXZ5e945m+05pX3XxGoBnW?=
 =?us-ascii?Q?LrI4X090xpLiOJTDIA3HtkeUtbTNojIhNB4zYQgWpxp63GSECvYi83o9g4Po?=
 =?us-ascii?Q?su9rGAz68IuSmOcPV86OQ0g3v8hu7e5YxA59ZOlg3err6+PHQ8BDlJYKUXwJ?=
 =?us-ascii?Q?3kD/zz5MyMxtTEdZFJA4j61qApf585vTftIauXO45AOeAaZMcmkg3ITKVmvV?=
 =?us-ascii?Q?QllcqIMABZ+olIj5DNbNicZ0XSaa+oF3h44oJ7BdWyDR282BBFUhoQVekFwi?=
 =?us-ascii?Q?DJGDd31jmwXa2L3sfYEzpPAKikrdEhqrL6dxqVTOOXnkX4CIHl2k/fbuSXV8?=
 =?us-ascii?Q?SRM+jmBryQqIZVpVFGb77CL5Blvyzf01wtT52QI6N+aJi9SyUF9ja9+1GGut?=
 =?us-ascii?Q?49JWiOxMnYDSENN/PYj7rxzcgUCmZYA4DLvm9/soU4el/zIfaVGZJpGlhbIm?=
 =?us-ascii?Q?1aplpXWIyKUuuYMAytD+nPsG4y3ttZlgVC6eTiqCJonz2orY9YZn9cAL+ZmY?=
 =?us-ascii?Q?Pn9tejn5HRVv8yQah8I9C0WJEeuPAS/vMxtwkH1cVEm0BW5CuPnsAftFCP8G?=
 =?us-ascii?Q?Sr3GjIx711yJsdFkCfeX6HBOQIhkB7s+Qtq4FllvkC/Q5a8uGeJi8NNbvkYY?=
 =?us-ascii?Q?ag41BBIa1MnqZQ0QUhPPjuPUxVSD4VoxzGC6XaaGlPqONpl1sdwpYqQ1o+i4?=
 =?us-ascii?Q?zFZ8V+cbuJtryCLR4Z9plp1GotD2sr/9NgUB1gKmZ9UdEjhKPLVRuK+GzqDh?=
 =?us-ascii?Q?6LcDmSPa0SSl2GOE82z7MqzHrzW6pEbDBjZ0mv5S5KGcrQ8nEr+WnfOtESB9?=
 =?us-ascii?Q?fJXH+bt/HWOYTHYWy1oTLkiHErAlx+SgUG+FzGk2zJLzntVabgPUHXb0APn6?=
 =?us-ascii?Q?MUCyQm+R3xaOlYodjJX7FF++gL/qPTR0torDYiRC0VzLtULtSvsIyMh1o9yy?=
 =?us-ascii?Q?xvpZp36j9Z/Zelb/C0+l2pOAZ2LIEWO/Z9cLihcZnzlSwGRtSu0DL86Tqat/?=
 =?us-ascii?Q?SIN7s7E7fEuIwne16qbpUYvrRgPynwo+x8tQ3IPB9uFkAavNB9PZRRdTMmr/?=
 =?us-ascii?Q?e+qGmm4cpvrew3Ze02nRadV4IIn7asgwvHw93rOw+SQ4Y+bzP68YVn9DUCxA?=
 =?us-ascii?Q?3Xw3kyhPcgDK1QRyXgKNdRGr/QZPVhA8qyFFIqBYJKUFDoLifwiPXmjI2dbO?=
 =?us-ascii?Q?nvo2HEdsER6Sih3/JXha0ZKO5K/MoFtt7RDl9lt69AjxQ7mzghZhMnXCCvbs?=
 =?us-ascii?Q?g/vBBxzNVYIiE+0n7tfiCCdrHGaeAXL9QqWRsxYvh7GdlpCwggXWgvVwB+7x?=
 =?us-ascii?Q?nPuJaAI03WudK6/LWPC5heSCjyHZ+x/VWqK4IANL7H/FfsZkSuy0U9PtFyWK?=
 =?us-ascii?Q?7vaGVKIxxEn8+SfuDxYuxlY4WRM5/CAqr4Ci+QLsKbQOjXVD5ZblM/vNB6o2?=
 =?us-ascii?Q?sgVBgyw76O7a3r06AeOoqDXcIYUQE01RRg2PjGJ/6hKEYQSug9I3TSpn3B+C?=
 =?us-ascii?Q?7CXUNj6skADFILnS8h7l4Pha+xAVCH/cSK4w5ovG?=
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
	EvzeiGR5/Bm10k4TZ58z1bf7qX+dPWfQ6FeyuR3wpyQwz/56U+mmym9AKlcqaS10Hsh9aJniswY9INh06PQwJRgFFsB0+YoAQ96IscgtqnTHfhb565mqwB3m2iv9VaDDWJQHoJWg0xjAzxvBhFGZxSneOoJ7Qa4ZhZNBdy6t/tCHmGbvxMvoLornbz2pZVX7UHdsAIE68Jj19ZbebDUsoKGCwHfNTpANl416v06ElHH4TtFYKe92x9H9bVDzv39Nuo7JLwGfg8G/g+bx/ReNUoo5JaxB+BX+u0sIOZbz0KAgvp3fLdRY2b1/XXvYKYuVmIC1M+qrZRdlPfadNJwclzAy54Hd5n+dgeNb3bMzzPvJYIUWd1Q3c5XTW25QTWj11LeVrxNCWwyMELJE1j29vPUnfmxRP5F29l4IvLvF2k+eQUUD7ytzIFWqwkINxKiOpAUY4lZcelul3nyQWoDy+me4qmEl5ybYqAUuUMB+fP8EnHNT30NCrjVacv/oNAPwuXLiQw8Gqp4g2FOtK5j8eCVLqvlZHuAwM4cGHcktERl9sX4iNGCkw9ny+kgelaITnfwCrpnZcd60ryAp3Go8QhTN0DtmLXM6kfW3Qq689+8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7240.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a87edc9c-383e-4f94-2b95-08dc86089dd3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 09:11:14.5157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GqC6HMQ1CMOEc2s77Nlyf9kQFIALpABHhCN+cCVLIhq2WLQlYZ6kgjnOmNzXdo19bYUbrRvijjmuZeB3Zm16nwXL1FkzN0arNF98a1HsE4w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5977
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406060067
X-Proofpoint-GUID: xOUiye9WEBcFpzIPjdyXR-EMjURRa5al
X-Proofpoint-ORIG-GUID: xOUiye9WEBcFpzIPjdyXR-EMjURRa5al

Hi Shinichiro,

> -----Original Message-----
> From: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Sent: Thursday, June 6, 2024 11:33 AM
> To: Gulam Mohamed <gulam.mohamed@oracle.com>
> Cc: linux-block@vger.kernel.org; chaitanyak@nvidia.com
> Subject: Re: [PATCH V4 blktests] loop: Detect a race condition between lo=
op
> detach and open
>=20
> On Jun 05, 2024 / 16:18, Gulam Mohamed wrote:
> > When one process opens a loop device partition and another process
> > detaches it, there will be a race condition due to which stale loop
> > partitions are created causing IO errors. This test will detect the rac=
e.
> >
> > Signed-off-by: Gulam Mohamed <gulam.mohamed@oracle.com>
> > ---
> > v4<-v3:
> > 1. Resolved formatting issues
> > 2. Using long options for commands instead of short options
>=20
> Thank you for the v4 patch. Looks good to me. Before applying it, I will =
wait
> for some more days in case anyone has other comments.

Thank you very much for reviewing all these versions.
