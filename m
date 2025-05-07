Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCC523DE
	for <linux-block@vger.kernel.org>; Wed,  7 May 2025 22:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746657415; cv=fail; b=GfSIYHiApiQm+614Vuim+1hmQoGPczeG3Z79sYcSqhWXkCGTcmvwDeJ9M+evEkeEQqmETGcXNlwJ6DIN+suUzLEzoJiJDOIXGTUdurHVRn3LCrp8yRcFOqEqqH5wtG0c7yYa4gV+8X2dSnqd78Sk24VvstOsMzXnA5+RqjmXsKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746657415; c=relaxed/simple;
	bh=ScwhbNQuS8XxYTMizf9UMJ5jKU3axm2fc0XqMyObZ6E=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=QUu02k+kppcrZgFDqwFdlDNyo7ftkEV95512ezkw5OpBdIovj8dY1sYFmYXJbBB+PdHKy6FY6Fwuzu5tVvK026U6ZuY0U43MdRpZIKa9XWXW82e8tabI2WKbzQYEZdncO3WtUBbWZbrjb3SlXL9SvvlLXWl9pf18ef49b/2V0ws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nAyI5IUn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vJZHicdS; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nAyI5IUn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vJZHicdS"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 547MMBFC000330;
	Wed, 7 May 2025 22:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=t8zadr0G6UWz6xqcBi
	fnEVE9ZxoqZ8+IPrQWm0n1XIA=; b=nAyI5IUnyuFW/WvkxWE4eDeyoF/CRbwA59
	jEJRjdQxCkBsYIVoeuyifSj2OIVnJvwRrc8Mf0zj1YzcmZt8ZcKPdXYT4Gv23KSQ
	13sKd2z0umZBPO3HO5wIflSablLBgD3akM9VJ1766+0qe1OdtLdsfdgycHFIyA/L
	vKziElIfiVRTfXORSvW9wlT0verE0aqva5gRL/pPIjR51uwLKMF18Vhkv5XlrKJJ
	+vFsCSyE17pBdeDMDS5zw7kTTUov/sCseZduxpTZ3DlJWz/HpCpxqvVAQWqBA/uu
	zUxcbMvEA/frEDQd2RpEwBv0pQpSQmH2C0mMin0GV+TO/+SUxL+w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46gg8d80n6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 22:36:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 547L6MHw035473;
	Wed, 7 May 2025 22:31:41 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazlp17011028.outbound.protection.outlook.com [40.93.14.28])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46d9kh7tnc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 May 2025 22:31:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjiJ6Pvl0IfSL5GhKdaLmPa18PIb7cqmvDaaHaLcI9zw3HZleYTcgLvF/p7cccNpBpJRbOHQ9ir6q6WSAiz36oW6GxIDDHCpWeTffNsMV+turgMHvxFCPqADrcFqwcgOGYYMCoMCy9kGJxrQcueV6saAw4X80e2n/285ViovNDPk/HVV5bQG8fPnxrCC5AC0WU8O11Agpam2J5bverkl+al/n49VKZG/wpiJ5yIeT+pCaT8LL9SNWDJHwOqq9SZT4aaZinNLM0Jvbt6bemQqtHydyEaLrUUda9UoJhFv+8O+qhdRSjP89hjpXhQYqmylXtNX3CPmck0Q5gC41hEN2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8zadr0G6UWz6xqcBifnEVE9ZxoqZ8+IPrQWm0n1XIA=;
 b=FHwOCHxay84M2ZHvAcG/z263/d+BEergukOZlztOHIQnlv1pclYKzI07CsLJobT/MROrWCnBQ4Oo0qblaLCUYFLQgsHjNcMQRo0ou0X/B8pC2qOR1m8DwJ7NwqKQg5YqCW+dt513vsbY4mF6X1kw+bQbSUZPHPgzKx0eQL1IM5oxMVLXTYqxVTUoGE20Njfj895+1CTSe/RtqZfAKFE++3FHbw0/5nABZtWa/ICY0Sz1pbMr7nDoXYVDT1fphZyxM75KG/cJ7ZegL4+H64reEk4SZbCkLeibl1sKkDDerqxj9QDFnX16WZJi1wAQmzljzd7Q1+ZRYfrGpRnPbxEoWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8zadr0G6UWz6xqcBifnEVE9ZxoqZ8+IPrQWm0n1XIA=;
 b=vJZHicdS0BHrnCG7HRHIeo0w44oTK5n/3+wQcfaDn3o7ePhxHMH7E+MfiYCLVrUcbvhYZM+oo0J5Kga4i49QWUF4lZ5p+L+l+HLhBGskH4CJ6Tdgj8EGAieWVEP8gDt6GvCxaPw7fw9AVplQnMUlKkjhrAcjTA83JTjuCpCbmdo=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by SJ2PR10MB7581.namprd10.prod.outlook.com (2603:10b6:a03:546::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.20; Wed, 7 May
 2025 22:31:36 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.8722.020; Wed, 7 May 2025
 22:31:36 +0000
To: Keith Busch <kbusch@meta.com>
Cc: <linux-block@vger.kernel.org>, <hch@lst.de>,
        <linux-nvme@lists.infradead.org>, Keith Busch <kbusch@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe
 <axboe@kernel.dk>
Subject: Re: [PATCHv2] block: always allocate integrity buffer
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250507191424.2436350-1-kbusch@meta.com> (Keith Busch's message
	of "Wed, 7 May 2025 12:14:24 -0700")
Organization: Oracle Corporation
Message-ID: <yq1msbot6ox.fsf@ca-mkp.ca.oracle.com>
References: <20250507191424.2436350-1-kbusch@meta.com>
Date: Wed, 07 May 2025 18:31:33 -0400
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::15) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|SJ2PR10MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ba755b8-1b62-4723-be9e-08dd8db6ed25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZES91cMzYr5MRCS8qOTSuso7bvAVw3/uqfaO+t1R9u2HfrHjhq1czj6RoD5/?=
 =?us-ascii?Q?XYgvLWbmXjUiBXdVW8Ohl/CaKHNyxRwlkRJUt1dU4vxG34lIvlZC+DzoshV+?=
 =?us-ascii?Q?Nxy0kx8bvYt6wVzmGGsbryJYMiNf5YZyMkW3tMpO/VLLDmYneDnvjay4+uEd?=
 =?us-ascii?Q?wDXOY9S56MnO03xAnbgHGPLMBWa9aESSRBekR2R/Th90kC16jZ63ynKk9fY6?=
 =?us-ascii?Q?sj2Uq8i2t0NmHBvRDBXUXrErvjhV9QMTWXstCx4A27hlCvkDXwC1G9AmtCig?=
 =?us-ascii?Q?h7k1EauHmkG7R6VK1TvdWOyt70aDPY1nqjA/99e2EmhCOQrG6ytEKcbM9hPA?=
 =?us-ascii?Q?ow4Dq4cTApwXuR4fzfI8iwTWPauLrlr4nyZTilBXlf1AzAOOLJ/huQBS7G7g?=
 =?us-ascii?Q?bnur2BFAazkZ6Uv0Iy7VXPh8Q5SpfSsiEASpWT79shiutQM86bE107KosZue?=
 =?us-ascii?Q?YxkRMosMUKPoTbhrzIgfFohd0DE7eI2u6QVwd4wysmwcZqu6f5u7bLxk9Zhx?=
 =?us-ascii?Q?wMzXWEu+bf1V2tRla2M3JE4ta1UCR4RjXvsvBCZqYX4bO4XBqmzotI0zr2cg?=
 =?us-ascii?Q?pOE6PVw4n+fjXWTAslpNUhZlvwwPP7HiKbw0Y6BmltrhQzTU+Ug/blI3bIPQ?=
 =?us-ascii?Q?UCuWUmpIFftSQul4xXIhMPM2lXOVzpvzeab9BAifRfVO7qS81Rze5dTEEaWW?=
 =?us-ascii?Q?nGNfROot3Nz34KGruwtnuHHRm9wOeIp+83GZxCy4v4h+sM36NOjMY73+xVjK?=
 =?us-ascii?Q?hr/ZoSTTggBXZChOgCmvVA8BMNZmOamTgON6Aat6nNwvi5ujiolL1gYujiqw?=
 =?us-ascii?Q?QBn1EoMyzVscxm/WvLXPkO42/sgBqzqgswW1LwYpLI4u4rhaPDXhTGa2rJnQ?=
 =?us-ascii?Q?e+7z81COowubCE2PI3dTLQ5YVLLnjgW5NFU+KeX/Od3JQw88ArXHchJVHh5A?=
 =?us-ascii?Q?XVcajd/WYLqlDEz/hLGrdGHd92mvXUGsAVd9X5vz2xKBif1xSONDIm/turej?=
 =?us-ascii?Q?G3cUW1O3gLGz9iYEQOOhxl/lG6A7srC1XuSyRcGlacdiJj8jTdR1kvIzEanH?=
 =?us-ascii?Q?WbFiLkT/K+hu3SFZmOsb3O5TaUzaK3z38Ms3nBScarlEPlFu+hBqZoBMpb/O?=
 =?us-ascii?Q?BVVI11vcYEwUXmQ7h/7dlWtORuKjBvAMOP7TBTRw+Z8lHrDN6etLv11hxRne?=
 =?us-ascii?Q?h8l0vWWVKGkQcSlntv44X2C3YgQXJa/CE+AWXRgd5biCGUsuwIBmT886pRJI?=
 =?us-ascii?Q?b9XhMspQh07ky4vvhSpQ0Fh6D+y0u1DTEwcZkIufK33asX0ThSr3XO7gxkCx?=
 =?us-ascii?Q?nWrR+kurkgSyXScAMIUlTzvRkFSVniY5t/aABZfImLZAy1ZTSw9w/QYaMlZp?=
 =?us-ascii?Q?v7nZ0K5GU+L+be0at4vGcyS9hI/vlTxAWQEmlVZT1St0gdDS5jMVltmcSern?=
 =?us-ascii?Q?DfdzypsCrUk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Iwr1kfDhBqQnIeJXreah6aFpJcGTG6ohNiseLHXwdubYz4jhOBRIJm54k3eu?=
 =?us-ascii?Q?OkFrMcDFnRMAvF2jDzIa3+YVKEC7YIy2j6npdr0z5U2dhIR4glqZewif1x7l?=
 =?us-ascii?Q?AmH6CeGGWZ2AsIxnO3asqraJ+r/24fVyhpkalFyC++nsu5uKBCPn/+9SjUc5?=
 =?us-ascii?Q?r6wNFVltdgXSv3s5lvWX3iB9/3F2eHpjH0/iRMzv4s5F3cy3kcvkaGfrPghx?=
 =?us-ascii?Q?P3swGU140Q6lJVuCNWL7kYT12SZ5ytQyn9I+ZGWSKCbnYQrBBeMSbQXbwJ/R?=
 =?us-ascii?Q?jT39JHcA/3oHvOVePDzaLvrxXauSoLO+eXbwKtrZH6ZNrWXDbCqJLBdT7Sb0?=
 =?us-ascii?Q?TR/OH52QqrVnOU379n7C1ulDOw/IruHl87FrsaPOQvYNty085qgyVklM/qfO?=
 =?us-ascii?Q?Jz4fgJFhI4ch6pDi6lcoz3tnvs9hjyUN2FZl3vlu868MmPs3/K3Gwe/5Gpqw?=
 =?us-ascii?Q?xiaCIJpjVSuDMrPlebWvFqVM+JyIJq5204/gWDK0DsXOKxezTVOcYOs2PZ7T?=
 =?us-ascii?Q?BafQ+AJ5kHboxwaEuIQMOwWeCQ02ao89YzT6+NXzamfuxcdpUvK9I1fksGSa?=
 =?us-ascii?Q?8QztTVFP6FhU0OO3p7dgzisNWcgWTS4r1WjvB8J2X754khPS7uO1ejxvqQeB?=
 =?us-ascii?Q?iVHfgKOviLhQGX7ucRzIdCe0BWKEcZwzRgq+VJyuLo75cxfKSj9FzrPe7c8N?=
 =?us-ascii?Q?tLbAXEFm/OwbyH0rrLncOwL287jOgPdLV5NUW55MneRi4hNzUiOis6M1bGuA?=
 =?us-ascii?Q?qfrO3iV9CEjrg62HR8pViNf9r4fBnYKD1qf9L67UtL9zAcLa79czc2tSeRgd?=
 =?us-ascii?Q?rQSbjCAYTbxSPq1+D8ZiPHKdmGcpTxiHCSMICK8QuuJtGnNgaZdVmeyOsYsY?=
 =?us-ascii?Q?ujpKmNCSth8FPoi3STKjIBKBhLVnNxlENefyRzLMJ0utu1ibQaj9OROD0SGH?=
 =?us-ascii?Q?9BW4RZRdkYmTwxWQU0x7O0z5hCJuqN3iO9y1CJfyJZ2vYzDi8iQ+9xWq7tpT?=
 =?us-ascii?Q?6mnp0C5C8xw3QZGkjFt/j1yUhNBlzr+4WRN6J0YgJAb4BOmR+3EQnjOjdiOJ?=
 =?us-ascii?Q?H1kaEup+I0Dpkx+Zl9/FbBhmXT3XSxp8dL6Y1XmleiMh8fFVUnEq+BkvAcoZ?=
 =?us-ascii?Q?HlIcg6PaPlkR9y0tKGNVQxPtWn34Bd+5KwyfGa+2JxozMvq5BoCyxqlF+QfW?=
 =?us-ascii?Q?8Uot/h2c+x6Y2s77vDWZ6z3+YGkeX+IeUpiWozOseXhw75Roi5JkGMNcqETb?=
 =?us-ascii?Q?cwV2oW7FZxq4VgKSOr9uFvM/520O1to0bm2odOxTMHUOuEgFoOm24QCSMvW7?=
 =?us-ascii?Q?FssRl/BH8klE+AttY6pzdtQjnAq9+9/GyjRKP42HOd/qT6anwsytl0OEjHKh?=
 =?us-ascii?Q?lAkZp8yDE6JJ27aG3cLol81wrhS4oxwBAnWSpZYeIKh0hXmQ2pbHm4sS2wYE?=
 =?us-ascii?Q?uZi21GhbJJ4+g1BhWDrsvxTX3IX31Hok6C3RJAmjUb4n1mDYm/YE95O4irQV?=
 =?us-ascii?Q?LOtCfpj8cBCtZouFh2aqUFwmkqwj8OxqFr+GmCPv9FhfGcLY1Iqbme4wTkZH?=
 =?us-ascii?Q?ILLMQvpdi8CGibxl28V0uVr0PjyV0fwpO+Hbv7HZspKW8HF3ii6AC91XJQIK?=
 =?us-ascii?Q?og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ufrKz+M47KUc8mTt4VQaZFBQzKreKzEN1lphUo3lolY+XyRf2z1pr7DLMl1VHizg8V2EO9DFVrmDmHzy/WyVWbyxPQeW2UOZAauPKKYoWiAeZKA465uUz2qHvIZ2vRC1MgZyrBGZDLxS7hlJ8LTI7JYRSU0Oq8dSbbxOdORLpKtkGU/NYaitq5GCXnxtUmekgidLEO8CFYSZXVsgPGe0WbLoHrd9KN3VYXyLwab5mclDOWuU0r3m/l47QzI7FjlwNulbuWfJU0Uv6PTdZpo+xkoqXcMPZPcFRwSVW/7UhiHlkhrHS/2aH48KXIhgEDBh5pav9TNXoElsrYcX0erdViye/QZp+T8qbi1Ozwb2IYfkz4wX3ikb2jC2TQT4mmRzULchO4lfIZCFXJzLnmyIUZG3ZxUvQhz1RrRzA/pSqIubSAs/PS5EbdjpvAkX5fGyzZKGPGD6cvUG7z1TqOGMK9JmuEAnHwxS5MDfALspuWd0NpCA7GN8SkjIFpsKVwIaHMxICLi02AYE5ozu48CNHjPy7s8dh/fBPrdqLNUK/520C4YbpyFf6jRxoPNm4jCLjy0g0f7Sl+Kv5QOiX0lA7OlNy8uzhnge7dnrHcVdhCQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ba755b8-1b62-4723-be9e-08dd8db6ed25
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 22:31:36.1032
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Woa1pzzwrsbQqzh5DVOVR/NYK4fZJkRZF6ffuSwauzmeX35ix7qT39ugkvfVZ/Sr1SmwZp6SwaxP/86WlW3ramw7k8Zo/DQ2lAlZMBnIfz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7581
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_07,2025-05-07_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=934 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505070209
X-Proofpoint-GUID: hAHIS1TqiIHCqwLkfz66S9_brzQdoAze
X-Proofpoint-ORIG-GUID: hAHIS1TqiIHCqwLkfz66S9_brzQdoAze
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDIxMCBTYWx0ZWRfX9csMSdfXBVqK ouUBES5Q7TxIX7A1sGg5ZJy2G7xb0nNGRGN86e662OXLLBq6bwgQ+IUp0z0F/UDWqOpNjsTtGS5 bBCplP1aIF3R1FHQMMsR/a79wHYnoQxsKVq+Pps/p0w5bd10zATga9CRFYzpC6tE5TrrsaAJhuc
 K9nSR+TW9hCB8v2wE3F3O2DfsatBffxxsKBxXb33S7I0VUpEtQE0AmYRZm9Zr+GZ8J7015Cqm+N RWmYxe4LmNg+UEP+bwpSa1KCs8B3vW4O1leklnoWfUcb7XWH7KtpJWDBItUrNDltluN5RORHWv0 vEqN+CjEM4gM5N32jSNlBxa73QYIgyeVH/F/m3LI7bRuCZYtuOdHf31rz4Fw6VWjcd02jLGtwDx
 sivkMmepm5BpncfrDbvLK2/igKvep9HNfmgWFoAy9d10OlJBMpm+1q5tqOKjMi3JKQIZQ5aV
X-Authority-Analysis: v=2.4 cv=WLB/XmsR c=1 sm=1 tr=0 ts=681be07a b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=8aR0WUtVvzVFAmfNmwkA:9 cc=ntf awl=host:13186


Keith,

> +	if (bio_op(bio) == REQ_OP_READ && !bio->bi_status &&
> +	    bip->bip_flags & BIP_CHECK_GUARD) {

> -	if (bio_data_dir(bio) == WRITE)
> +	if (bio_data_dir(bio) == WRITE && bid->bip.bip_flags & BIP_CHECK_GUARD)
>  		blk_integrity_generate(bio);

I know that we can't have one without the other currently but there's
some cognitive PI dissonance wrt. keying off BIP_CHECK_GUARD only.

Maybe worth considering:

#define BIP_CHECK_FLAGS (BIP_CHECK_GUARD | BIP_CHECK_REFTAG | BIP_CHECK_APPTAG)

and validating against that? Or a bip_should_check() wrapper.

Not a biggie, it just trips me up when we encode implementation-specific
assumptions.

Anyway. It's probably OK.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
