Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C596D7318A;
	Mon,  8 Jul 2024 09:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720430244; cv=fail; b=mUvFvcm2yUkHM/N+6PuFzJUJbESm/r5AyWr2N4ufeQWjU2VTnOLtOYvE1qu4xx5RduXccX32tHMaDqiZ5YhuTI3aFsGQb0DXiUmmrEeHhY1BKLfLRVZc4dBNvPIUB2T+7fjpH1u7/hlApKqOXhHOXVBTPov93t3eVsM2SCljExQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720430244; c=relaxed/simple;
	bh=N8Fdwd/uZcf1fpS7HVApvXC0RRgMRwjmopzGOinvZTI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SfqkG2N+UtRgl4acWy9Kmvf/BR5TWRHfkGWHy2d5TL4deqlEPr1bbCsasPARsCD6/rHBGPKzjCiRo1S7GctY95T3YohI1dvnCCi4ClkCybn0ULnCLhn7csIY9L/9+tQket3a09/t07kqhwW903zPVOyz7K0HvBrUk7lpe4HbY/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MM/QWcEi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BcDdy6iS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MM/QWcEi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BcDdy6iS"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4687ffJV011980;
	Mon, 8 Jul 2024 09:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=tr7FY/2db9YsQPfXlk3ssa7WIQSMOzgNKUP9pLpTgRk=; b=
	MM/QWcEiM1KPjRRtp3376kE+jJpciPIuh3NHes1yA4SA1RBe7Z3jI1ouKo88GrUd
	5gnx6dcBwRTvOMGDIisdyON3E1l7OSN5DTJqaqTvaiG9jzv3LyUuoJA8vUlyYuny
	vvEHQ181vXxpJOFsRpZu9WVSzIQIlgbi8G3yE8taKSJjWhKq+s9nEdavLkAqlRay
	GgDAoD4QJu/AEbQkIljkGoz9VD9HdemIiS72bLCWCYJwC9mQRQU54GM8AxUcq61b
	R3pv/MRVLsHU13H2QJV1B3zGZGZaX9DWpEiblSxqNQZk3Pe5PlR6yd5dDMWwC7ny
	kSpdwNAWcqQ2bPvlpCMgWA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wybj6r6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 09:17:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4687FHQb005608;
	Mon, 8 Jul 2024 09:17:03 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407tx0vxf5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 09:17:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCTYsB0/O6n0ZNupuTbWqfuSu9JYKLr/QHpY+c7HHLRoyAy1kXzkyebvQzhdr45JaaWwfi/cqlthWieFZu6t+GAuwllAs014GaOOImY03d2n6edOvwOOuq730QqnlkX5XE8SVTVAJIiDuA9ZBidSUfFA/AKlIyUJxJsia0P5J0RY4N5cx7O5sVhkFlFpgC0Mr0my5DNuUfr4L4sou0GSbvejXBpsB+jiuBH8kTNpya8hg0H+sWCuT5MTJhByMhVfFPt7v0zHW4VaVScOo41Ai6+ikxS2FqWJKWLdYUtznWDcwLkXC1QaD92Yyayux5btrtXf4/FVguaFG18kov+KgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tr7FY/2db9YsQPfXlk3ssa7WIQSMOzgNKUP9pLpTgRk=;
 b=Na9C1gOZZIJubsV6eLfUzQ+A7kUtmYOvyYV/9fna8+/JoVWu+cLOp7JLcXy4XlleDGTHx144sJZQUbMCtCKvSO9VicV+zW3GlD2cTzIEA+DnD8MWGNnEMCvtdJ0Vrki75F04dZcFZgq9dO5qudSAnHmRFvl4sXrSGKyEi5LbxHZk/SojMKoHxxu843OsT8djug0w6KYF+ZPTIheLceqZR/XXf+R9+JvV8EcYqSX7BBTRpI6/ksGu1Mlvx63lYSYST6h2oggbeVd4X8zfE11t+tvTV/i6A54/tmMjstSPt+xRX75zPka6tWh8qmzf67wWWGR56UOiKa7cjqCmU2Aftg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tr7FY/2db9YsQPfXlk3ssa7WIQSMOzgNKUP9pLpTgRk=;
 b=BcDdy6iShX3u0FZK34GIZPF/oRA6SGW/IgBWRMvVeHZ1WCyrfRA46xe1PKKJJjY6CtKD2/wIBFwt8SxwOhUXLQ4+HYFcZ/ZWLWv5E+8ziH2wh2CkNvmfHk/R6tc/7Czh+d7LaxPRaTBpoG7r5wHL/1yAoHqQZYt4MFDqnmryCAI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6799.namprd10.prod.outlook.com (2603:10b6:8:13f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Mon, 8 Jul
 2024 09:17:00 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 09:17:00 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, mst@redhat.com, jasowang@redhat.com,
        xuanzhuo@linux.alibaba.com, eperezma@redhat.com, pbonzini@redhat.com,
        stefanha@redhat.com, hare@suse.de, kbusch@kernel.org, hch@lst.de
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 1/5] virtio_blk: Fix default logical block size fallback
Date: Mon,  8 Jul 2024 09:16:47 +0000
Message-Id: <20240708091651.177447-2-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240708091651.177447-1-john.g.garry@oracle.com>
References: <20240708091651.177447-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:208:160::34) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6799:EE_
X-MS-Office365-Filtering-Correlation-Id: bfeb0657-6cb7-47b9-a823-08dc9f2eb8f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?7fwXHlBDApuM5eOll/+veY+U37L35g7pGsR0/lpxjj4JswuCdU2rlQCchAe9?=
 =?us-ascii?Q?JOFeIPFbEqLT+BABcGHoUwlt9diJaBUGRT5Qt89x5qJZzwSMnb6oerkYYG7U?=
 =?us-ascii?Q?Jcy0Gqw2c8GpaRVtHsJnH+V9q7qpqa0NQNh+nLfzHOtMdvdZYEXes12i8Dwg?=
 =?us-ascii?Q?nLqxPsKgLiOsDu/+DAhavJHZm7Nr/Dv/IX2F9q6aboyemEP94ZGovwbZpqeT?=
 =?us-ascii?Q?XiSKEzduEX4tafhQeMkj0vgOZPQ5EsR1V9e3VxNA0KesCdalwJg2Ddj7/Oy9?=
 =?us-ascii?Q?F2mpeMVWgern0txnbWRhulD3VjwCYr8mhoBCMox6voUvIGaokGyoVMO6xT73?=
 =?us-ascii?Q?ncJWdfDUwQ3Bc/JkCxpqTMe3axmlQuy3PfeG6Vf2qKGReOaj7qpGDqtk7YXW?=
 =?us-ascii?Q?Qi4i1Z9wO+TKgbJOeKSnDOljXsPNk/ifLbAtS61Rt1pknZCocPCxu5YI0ZhW?=
 =?us-ascii?Q?9j14d3rS0vXkBD6mkJb4VgjfKHf4w0tH3XIRWhQJIWzFsLvLpbb7Ie5gc2bE?=
 =?us-ascii?Q?Nxwp28nki9SEp740DKi4fsMhfC/4GFFOkDr7sUQ1/wy4yEwlAXtu75SsczOY?=
 =?us-ascii?Q?z4BRQznXcHZW8uSDsC7N78jMD7hjqNPuQUUKFULcHDzZ0yoeWHCOpzoah3L8?=
 =?us-ascii?Q?qAj3YBVJypnHD0OghC9tXxyHBCZq5DHU5+UkCKnYyv5Ti323yVu8pRSENLUF?=
 =?us-ascii?Q?5wQnmMaSDui2TIzIWOcJQIkOJ6gTeyirLPrMy4fH3sT1qUGNl3/Cfj0ht3Yy?=
 =?us-ascii?Q?22Gx1CxTwEZe1w21djsI/8tPRSjUoZyMIz3xliLIMmEcwcsPlHbA/yj6LY2H?=
 =?us-ascii?Q?TeEwt7Vn7lPJ9sdGVrEOvK8U6NqhGVTzqirqD9aj+Le00MeI3677dfOdjiY6?=
 =?us-ascii?Q?z3Zs5yWz4Z2r8qrMxvuL7hQZRjfjV5ZE+7Kjm2+RIBrnDUVwPN/t9zGKlvgZ?=
 =?us-ascii?Q?GCinDuewZIkT42nPz8hSUXRTO3b3dETyRwrpy5LlWjPvjsHrRPX1131/+aQc?=
 =?us-ascii?Q?GCikhlcis+FS/Kqob8/GGWVmUjd7idsUmABIcIARiEIxSaEZf9e1MAziLNGg?=
 =?us-ascii?Q?Q1yQtfYOAntqwJEWPcj5qSnM3iLNnoXa2z5pzHuhEfa20vjAncP7TTOJC/es?=
 =?us-ascii?Q?3Hc+tTCsT7uvVGcHJmWgRRhxKNpxSTD3Ammqa/rXjwNVgK6AbYKj9A5ikVEB?=
 =?us-ascii?Q?w/whjrcLgFgSqwnW9rERwI63r01yYMVDGqaj2pBzGTr1Kn7jmEfHnee+8Ukp?=
 =?us-ascii?Q?QFTFazNeHqqVf6dEK8jF3YTogTcxwkSFREJyjFMcnbhx3K87Gx12w6QPceD0?=
 =?us-ascii?Q?XarRwsTRZvH+DNMOi61GI4/nRg4zAL20Wbpv3hMCrj9ZsDAWiGowL+A4bcgC?=
 =?us-ascii?Q?XEU+GZsPiNy+vlSeAGIk7+q7gbmg?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?c1QCwW1WXkqH7HCIFSrgME86IFPjrb9i6efOauUcEDLOov2EeU1eltyUYTze?=
 =?us-ascii?Q?iA/aOBpYsYi8dRF9LLfghmExGxm132K2ooQBWSYE5Q3PNNKH7tMVQiffcKDx?=
 =?us-ascii?Q?/G6pPg9WfzMFwY7bimr1afsPz7w2Y9RjWn1r+m8tG/RhzMXga3T8EG8U728G?=
 =?us-ascii?Q?oGA0OjZlKNQNTEsMXUI3IsA/31XuAvpz1skKyDVjw6RD0XDckaDTyEw6TejJ?=
 =?us-ascii?Q?HlAdtJbUZYqu8qEAI6fPXnU+ti3B/11zFH2PuK2YG8rZOkQLckRmOuTCNxo6?=
 =?us-ascii?Q?ZscZc7eoG5ZorQFKoqPK+xqaaV+WDCrkS0jA37/Mm36LDtBlXjorzGmsC+z7?=
 =?us-ascii?Q?3MqJNPZei1UuJjvgBq9xfeHhn+72yUoHQEzI8bvyPKVe5U+gOYZbVkFp8sQh?=
 =?us-ascii?Q?OVXvCgbEqeGgZn6xmoXlTGuVGkbN/NCjMenaYuu/yDN4xP/StIeJ8zk5gCM7?=
 =?us-ascii?Q?sqeoZH3HKLvwvzoZVfSiiZwJDSlIZTMJ/UM5Q+klMi362SRq4GSLhKPAWwo+?=
 =?us-ascii?Q?HHgfunq9LRrXj9PBfyNLO7MbzALpuPJPeM5Uovd0qOXHHMTEJ8tOFy74sgVC?=
 =?us-ascii?Q?ByfrT0Dh5BEyHvg0ZmywTjjxqJ5y7h1k+fhwO3O2NmIe6gwzNSfNPI27Xlio?=
 =?us-ascii?Q?0EKMaHnvpgBUJroTTBU3qJm25jma8A9FjHJN/9S7X5yW95fNHvuDIF/fO0RM?=
 =?us-ascii?Q?lAd7MLI0CjtN8q+wySZUksRf10rF5t1HTUbWQKbQ320aPAZi+vOrJFSlTJpA?=
 =?us-ascii?Q?r0aiEb3Wa2jxS5WLsWuGue05i4bkj3PNijP/rwAa/9RMRQwhuIXqeujAnFTs?=
 =?us-ascii?Q?endF3ZcxifNgQJW7AiipTXCHYNQ3NiN26GPRFgd13TApCzA+PMwjmM//M0dQ?=
 =?us-ascii?Q?P6+0Tr9AO4EHMR8QRgk3qNHHGyDtSBr9NyD3IslMzfGYxMlSiw0cPRPF9nxT?=
 =?us-ascii?Q?H+qQzXLFf9D+wB0fmImIl5WgZYXWu/vAK/bpHcOWAZWUOxGMQVPudzqvhY0l?=
 =?us-ascii?Q?v551tQR+AH60azqb4Shau6qwLsX/RGoW2VZ/qjtWhtfGUJsKQwbt8qtjt4Jv?=
 =?us-ascii?Q?4BaHBUJxlXc7koxi5B6HcMW/Wgi5ko+0d35oSpsdIiIYY4+Gt5zs5D6/8aeA?=
 =?us-ascii?Q?ICouVXjXFMwx4tQlGs8GYdwrnO3e8mbTAzmGWg0N3GpLdUUQORfeIpVouzIA?=
 =?us-ascii?Q?pgtBWdUTelQL7mZm4XEqjcWjDvbODJ510uFdnsqGnj+v7UzVODlbHmttTNlu?=
 =?us-ascii?Q?UQC9KpGEivuZwkiRskibMaGUKd3zVONyyTv5hIVpyDlHqPV7hF/Zct7geR93?=
 =?us-ascii?Q?mbNgPLFbbn+u0j1WGZZlHEA3OIEqO2S3FEowCTYFp+tOHWBrTl5pyYx2J8D4?=
 =?us-ascii?Q?vCmWWLWvU0855GwLVcTZKvsOiMw9DuNgiAsyrzc5ZMZSIU7gcqjvc7SzTJ0s?=
 =?us-ascii?Q?gV/z3Oa+yYIK0MTFY4NUsHrq3JCslb6RmyTMsnOJPBWlXSZ+9X04kF5mAbyx?=
 =?us-ascii?Q?279hjFuWl/Aqd/D1AwOoK4jVPPC8LGzLlAIP0pd41ajI3FROwxZmyaaLp5a1?=
 =?us-ascii?Q?+9+srROl+FoIHkL7EfO7EAd4A6TqsHmurb1QoSbNeX/E9Rx0kHjyX+i+ztyV?=
 =?us-ascii?Q?kA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	kkFK6bp9TxXyGQ4mRwCFED2eAsTdFmrbN89dSk8R1DQZdd+MrbHl+exnE2kVVwc8eYKZhE+FjgufsHFdvgczlbRgzv2YjqISxTsdt2nwZQ0Rs1h4uUos5TmNcA1ecCSnlX+SdTgGsKFczgXZ2y1z2nw8Sgajeu9aRUhgRTUyI2ElD4XYg9mI01WUcTlm3kN4hgUTuRpiMQMt4bF/EtQMYE6/ooITns83h+DoqLUyLk+Ln1uetEXp+yUyYX6Ud+dLaKJtRACiVedAGEMNPKGJydS3bX0FvRUDrlwkT+dJqoyGs7K+z0yAsWyzlEiaV92NhLQt+ns64yXS/T6dQg/WsQhX4Qznbgp746j+GHIresANN32+02YYFBB0uMndW3nEkwMC438yQsLqjZjGk4uXzyyUm/oIDHI5vSljifC7On4qJokFhPxy1RXfad1QjnigypmiW7Ymx1Yz3tsLrJwytHTkUWZ9muU1CtoFvo/QwJrrfhpPOyGLQ9xBQj8x7vVz9Njzh0o0mkQXvv8+KRXjuDSufn2gevhhj/kmCwSVGGQexaf6WhkOTYsgcoNtFL2rlHsz8FiCE+6uaLOUNSxSTZctmJIoijZzGmhKK5SLCG4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfeb0657-6cb7-47b9-a823-08dc9f2eb8f5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 09:17:00.1120
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vD7c4Lg/iNCzI7gBBGU6ZSVT1XTaWDH8n8KdPczyd6paamhx/W8l3bKOosQhaCC1DiXyLUZK8dTUsj1NwbpgTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6799
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_04,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407080071
X-Proofpoint-GUID: cotluPGEYHfrfq6TGqhtpcXqohOqVo7y
X-Proofpoint-ORIG-GUID: cotluPGEYHfrfq6TGqhtpcXqohOqVo7y

If we fail to read a logical block size in virtblk_read_limits() ->
virtio_cread_feature(), then we default to what is in
lim->logical_block_size, but that would be 0.

We can deal with lim->logical_block_size = 0 later in the
blk_mq_alloc_disk(), but the code in virtblk_read_limits() needs a proper
default, so give a default of SECTOR_SIZE.

Fixes: 27e32cd23fed ("block: pass a queue_limits argument to blk_mq_alloc_disk")
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 drivers/block/virtio_blk.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 84c3efd0c611..f11b0c3b2625 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1250,7 +1250,7 @@ static int virtblk_read_limits(struct virtio_blk *vblk,
 		struct queue_limits *lim)
 {
 	struct virtio_device *vdev = vblk->vdev;
-	u32 v, blk_size, max_size, sg_elems, opt_io_size;
+	u32 v, max_size, sg_elems, opt_io_size;
 	u32 max_discard_segs = 0;
 	u32 discard_granularity = 0;
 	u16 min_io_size;
@@ -1291,44 +1291,43 @@ static int virtblk_read_limits(struct virtio_blk *vblk,
 	/* Host can optionally specify the block size of the device */
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_BLK_SIZE,
 				   struct virtio_blk_config, blk_size,
-				   &blk_size);
+				   &lim->logical_block_size);
 	if (!err) {
-		err = blk_validate_block_size(blk_size);
+		err = blk_validate_block_size(lim->logical_block_size);
 		if (err) {
 			dev_err(&vdev->dev,
 				"virtio_blk: invalid block size: 0x%x\n",
-				blk_size);
+				lim->logical_block_size);
 			return err;
 		}
-
-		lim->logical_block_size = blk_size;
-	} else
-		blk_size = lim->logical_block_size;
+	}
 
 	/* Use topology information if available */
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
 				   struct virtio_blk_config, physical_block_exp,
 				   &physical_block_exp);
 	if (!err && physical_block_exp)
-		lim->physical_block_size = blk_size * (1 << physical_block_exp);
+		lim->physical_block_size =
+			lim->logical_block_size * (1 << physical_block_exp);
 
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
 				   struct virtio_blk_config, alignment_offset,
 				   &alignment_offset);
 	if (!err && alignment_offset)
-		lim->alignment_offset = blk_size * alignment_offset;
+		lim->alignment_offset =
+			lim->logical_block_size * alignment_offset;
 
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
 				   struct virtio_blk_config, min_io_size,
 				   &min_io_size);
 	if (!err && min_io_size)
-		lim->io_min = blk_size * min_io_size;
+		lim->io_min = lim->logical_block_size * min_io_size;
 
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,
 				   struct virtio_blk_config, opt_io_size,
 				   &opt_io_size);
 	if (!err && opt_io_size)
-		lim->io_opt = blk_size * opt_io_size;
+		lim->io_opt = lim->logical_block_size * opt_io_size;
 
 	if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD)) {
 		virtio_cread(vdev, struct virtio_blk_config,
@@ -1422,7 +1421,7 @@ static int virtblk_read_limits(struct virtio_blk *vblk,
 			lim->discard_granularity =
 				discard_granularity << SECTOR_SHIFT;
 		else
-			lim->discard_granularity = blk_size;
+			lim->discard_granularity = lim->logical_block_size;
 	}
 
 	if (virtio_has_feature(vdev, VIRTIO_BLK_F_ZONED)) {
@@ -1453,6 +1452,7 @@ static int virtblk_probe(struct virtio_device *vdev)
 	struct virtio_blk *vblk;
 	struct queue_limits lim = {
 		.features		= BLK_FEAT_ROTATIONAL,
+		.logical_block_size	= SECTOR_SIZE,
 	};
 	int err, index;
 	unsigned int queue_depth;
-- 
2.31.1

