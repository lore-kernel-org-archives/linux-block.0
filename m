Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5535227B356
	for <linux-block@vger.kernel.org>; Fri, 12 Sep 2025 09:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757671094; cv=fail; b=O1EIAJ8FRR+DOuTsxUSevy0Y2bDynxoKLDEZJKWJ6as7jNFYzkKg4UYowT74LR05B2BCwrCrc8VRNjIDzSgo8cZvcqvpcKC/xBOojLkJg6ozgiHSXYY9YxBj/u72xkKOoNUgKNwNtFGaMrCSaYw8ZjqGNA7fgJL36AlKFTEi6Ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757671094; c=relaxed/simple;
	bh=bdZbNTF6YO8N60QAZbTAL0oMoEZXjpnTDG12TrFAq/k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Uv21r6Y+ZqVxRHgvIfOb00SFv6zSQigACJ3ydEfl0/8FqU+7zFYTtTmaYwl+pgZSnjNb52OTAkcKXcCAhlnYfAQsVRzHks9vfX/J/xMFOENYj4AeujXbFGEbQqaV1UCK5sVwd46mPciJ0BrjGqbcwGJ7561FIXsCngI9D2NZ1GA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F8q2cAr/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LAeW+qvI; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F8q2cAr/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LAeW+qvI"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C1tmjS021075;
	Fri, 12 Sep 2025 09:58:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=gUQmWwC64r6PYjC7uv5UionhGfrcffpHI/tH8VicAgI=; b=
	F8q2cAr/1W84g0LxlRXRvNSGH91GE2rXpjVorCWA0yWeEW7XlmSw9SYu5Jsb1KXV
	s9NiJmhAdjsLVw9DlV/QVm5TDzUwvv5ydyubnb8/zuNvnGkdl8nt249U+AhVaiHo
	wEHsmq53EOGLAFhqMsLnN2WK3p3CiuHyftr+/ebzO4hOLiQLcglQ/3jCemvesmxv
	8255BCjsDssZc0pLkIuW8FWYjkeOYQ5NeUyTfbAhtu43cJp9RZd+IUukFdnovrFk
	YvBaJPenw0TLzjrbfyfoxBXu/wmOuscRbzO85JzM7ewnklLOVmXbdugiQ4UMUQNl
	BfZp420xYCC2kbblL/SrLQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922jgyyft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 09:58:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58C9uwir002944;
	Fri, 12 Sep 2025 09:58:10 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012038.outbound.protection.outlook.com [40.107.209.38])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdm6hm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 09:58:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bLpBoz5ooK9S9wDxNd0yEtq2xALK244N6fPBaEFR8zkg1ghuPljRj3llYuXr97wqzXA5WTFAbdv1ANK4fcuHNfBUXhpH1HjGiy6vQaBg7Ra/2zPu3FQ2gZDG8aaJQWTzYVKjpZxYgYCPJEqysvHYJVKpCjZmKUEqY5KL/pzmyemAly8GTdmYI28GWHXbXbVXmtYqV/lM9+Z8v5NC2YJ3Vc4761al4dvBLFzd2AxO7WdqWxckiFeOpvsGx7zwUo+pAnXdCpdxt/nie+h/Z3lu/oXI1X9YeHCg9usz/BnV+vWpoVYDdFGyW8WuwvLLY9CverwX82MCgPdrZIEdNe+b1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gUQmWwC64r6PYjC7uv5UionhGfrcffpHI/tH8VicAgI=;
 b=p1s+j09k+qnpnVDsJDspIVCeQQViazKb3gK1TNQPRXwtic8kYtZcD/GJhBQnmn7c/ZJbE6w00PhGe/lpsj+KbqlXXZT/BrhPHV45F4voQrdGivm6NN1MRURBvGLtfY11u3Z2f5UjzXAm5qnzhoGVAyNSa6b6dEL7WTTfvlKgYy0hGs9R6cXS9hNH/JLs7bNI7VX2IjUK+FiKdhnNckRF76V6EjajCfPv1lyZcBOGDbd8Kv+WqAvWYuQAfivn5qW0FO0iAsB/UbjCiWGXgejrTWFTw9XVvFvU1hp3po9jHOMu6v+7C8fsQIVKjFVzvVdGt/CwAVcveRdZxvXRG+CY6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gUQmWwC64r6PYjC7uv5UionhGfrcffpHI/tH8VicAgI=;
 b=LAeW+qvImFYrB39QbUXOgPBFy5qeFofxvJJNHNkdcG+AqBOj/lnZwna86oVL/5Td3Is2vD6dXExBOnQ7Wp41fODi80HV9Lu01MwZuowIo2GaqiMzoHy+Cl2uNvXkCQ2Yv8eTeR+J6OqpTvjPVCABpaRY5eoZw0X7m7funm0VAUQ=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by MN0PR10MB5909.namprd10.prod.outlook.com (2603:10b6:208:3cf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 09:57:51 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 09:57:51 +0000
From: John Garry <john.g.garry@oracle.com>
To: linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com
Cc: John Garry <john.g.garry@oracle.com>
Subject: [PATCH blktests 5/7] md/rc: test atomic writes for dm-linear
Date: Fri, 12 Sep 2025 09:57:27 +0000
Message-ID: <20250912095729.2281934-6-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250912095729.2281934-1-john.g.garry@oracle.com>
References: <20250912095729.2281934-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR13CA0011.namprd13.prod.outlook.com
 (2603:10b6:510:174::26) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|MN0PR10MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f78788d-926f-4b8f-402c-08ddf1e2d615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5FiW3jO7QgsyO8a1YQfHaS3ZAd4bNx4JxjIeHLECpX4RGEEZd+u0D6DrmqO1?=
 =?us-ascii?Q?ZNENrHdxh6+sAM6zzpc+w5pPVxtcYBmwqRIzBUaRFFOwZqSehehAtc2M74Ea?=
 =?us-ascii?Q?ivPQoXOZfJdlkmu/x6NrwJ279o9WsQlQUfEBlC10wu0D634L2ylxxaCuglq7?=
 =?us-ascii?Q?ho756HvVcavAt9BaQCN+S/pTWicSqxWJDx38DbekOiAFOnRPiG8y0OCgP5Dy?=
 =?us-ascii?Q?aHSuJOHC80mVuwwv19op69t7pafHq2tQcXJ5A1Az4dXf8yzarGXJ7PPYMLSE?=
 =?us-ascii?Q?nrJOFQDHedzkdQf25j7jHegqvnuIck+WSFsPy9/RiLsLt5kAvpT7q2nZtpwJ?=
 =?us-ascii?Q?LB1AwLOn9Vscq6jPlaVHzNUHtMR7PCu1oIG9YZ/HPW0cyFn4VJcyuyP8vCog?=
 =?us-ascii?Q?7a/GUuA50YADWzi/85eSNyoFsrA1IdBAjzem/GErcj3+/hPecbnKIIK7WVi8?=
 =?us-ascii?Q?LrKqupSpXQTQP8NxP1VJ7gmt3QBdBOeUkdNQ3xqTTvbBjyGMUxFrHTqEn53q?=
 =?us-ascii?Q?n1JgkHJtebfYt1R2aPQUreLw0KwhLP9kzQI7nruA53LrAKEaMkBDttVpJopV?=
 =?us-ascii?Q?0EFBbNjBE5Fj3FnXMfhvOCqGWACfHZt9EJcFA/7JWV4hwlrHbqGQLtSREee7?=
 =?us-ascii?Q?Zx2EPGMPZ9BpFSdqSRCxx+VUHlSPbyMc2OE5cYRvv8d0rPFYd93hyea5CbQv?=
 =?us-ascii?Q?Ii3msLvEUtSO2FPZkhVy1GSA7ekNbLG3rHgd27J4gdFztrSYqGP94/7IAXbB?=
 =?us-ascii?Q?2eW5yt1ESCEL+X1RJdELA1+98xXHIM8GLjp2lGoLoxhrju8yReGADIXG642w?=
 =?us-ascii?Q?AItkdxexrXmvZ/KW4UJWFyQIEzMHaT0Ye7qZfyL5UVB4IT8UyeD1TyeDFMcb?=
 =?us-ascii?Q?VFnXpFOow/xqGjTO7WCMikJRPteIm4JpBMch+Nu73ONSeeMJz4IRFYk7X+dE?=
 =?us-ascii?Q?eqvPFGjb9IxPFjPJQ1jAg9U3DRZr6E6uIYzkLNwfpmIuJt80LOjTBIxEKr2Y?=
 =?us-ascii?Q?kfYZsNY3VbGNGHulV3tQQ5o5RAhYkXwy+nDUFefXaixg4/ul0ssih5+KxXXj?=
 =?us-ascii?Q?4Gh7pwRBmB7MqL4i9wSWqUu9fQz5uMBguIon1RGnc+eFOGBJUZwqlPdwVQDH?=
 =?us-ascii?Q?NF/MbnO/hLw4XmCD4HbllOF0vimMjywm8R9PGxLXLXyWmk9++IqHzDXFa/Ep?=
 =?us-ascii?Q?osGjsGNVJA0gNBh1OtoQW5waKS9hNK1at4bvxWW3xFgqemNVrTvjC5+kO6+u?=
 =?us-ascii?Q?X8b8NSYAEwSGrPlGaTtwK9ARz0uybrtSL4LN4zy/PzW+c2ndWMGNTERcPUCa?=
 =?us-ascii?Q?FMcWeuKKOjU/YQsi+3CE37ZMXAypM33CHyYo8ww6nwxsiUUbDkcRxs+2jEke?=
 =?us-ascii?Q?iD6JNsG74THqzIXUd7n3MnnyGNca1WZlDQkb9IeYFcwX7XTqvPxCSfZSNzYO?=
 =?us-ascii?Q?6rvpLeWEUOc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GFdsxt8k+lbJ+dhfzEmcKYCqyZENCvCf9PkQCL5EDJYHVQ5aOxRQvFrzrfjM?=
 =?us-ascii?Q?OuKUjmnZG4AuQqGv16VpbH8rIpk2XTrlSXbU+V78w7n1WJOld6JXId3LxCnL?=
 =?us-ascii?Q?DlQHRk/TzUijYavKieibXGtzC9ipNt8majj33uDXTKbw/EoNU0G8rVEMQVUc?=
 =?us-ascii?Q?B65r2JTkA7/eDrHWAkNLRsxsYAUJ+bsc2ez+k9RX6F+IoUL+WPQ+ACf/+t4i?=
 =?us-ascii?Q?HAMx0KHYRqbRt0gYtHlIoCS/+BWuhcWcffLfd99m9Kwo2/1L6z7JFVx/0p2I?=
 =?us-ascii?Q?fYAvna1KcaPcVTPTnQKw0Fzz8S/dKpFe+hTBhe5z9KiFeWkPIwSYKLDvVq2x?=
 =?us-ascii?Q?kAiB9L+2CG8gw5QZSSMBa7EjaJfvmkbQsPYWw04jXaaK2bxS2wAS5CRpKnZM?=
 =?us-ascii?Q?10cw3w8BF1wsvduM6t14MdrcKtxqSanBBJ5fP0bOEnph46qm3O+ojX5cIGFB?=
 =?us-ascii?Q?R/u+ohBg6Xj/fwzSaZG9Bhoh9HyxiTvhKOl7qLg07gP0Rr4rXkpb1JUAs1t3?=
 =?us-ascii?Q?aSlzt9lE21CFXdefz0mohUJkWhMoF84vo1dfc9FKRTXjDQEf/X52w+Rzp346?=
 =?us-ascii?Q?1EqWlmOPnz6NtIwsqI2CzHxRpALYezW4ka1jCXqHMnh+f9Xlt/vmPkH2nxUv?=
 =?us-ascii?Q?zRgRFi9pf8bJQoJHOtqVL32DZe3lEBKcAYW+3dDP0/gDbDZGWptuf5TmKJpg?=
 =?us-ascii?Q?b/ZxkquhwC5R4bV+JGgAa0+3WwjHh0LQ57dlEs2VbXATe67OxLrVcpa+aR+n?=
 =?us-ascii?Q?+RuCnMkgWwgi5b0BkckHPJ22UcvQHO/m8wBlulEe3j6l61mFWLJrx2ABPYgE?=
 =?us-ascii?Q?oirBXSByfWzgfu9c07A+qT/E3+9Q/o5YRcLykoQ523poDdaNITST8T0MDYai?=
 =?us-ascii?Q?+KlHjyInYMgcQwScSnpdPQBzio5Cggb9hWd1+G7IkermTl7vImTqMVihMlin?=
 =?us-ascii?Q?uXuCERyrdDPL8m00r4c3gIqh9L1ogvuunSq+9iLI8f76D9nxd148p57WooUs?=
 =?us-ascii?Q?UD+36OJcaHq1qzURo3HCw2fkHyO+7hKWPwg5r3yHAoTdbmfQDVi09BXTjU7Q?=
 =?us-ascii?Q?kwSZ42SaxhVms8gK5E+c7gI5dbAuoUiFshloSw48nHAgpnxNGJQxWJofX40L?=
 =?us-ascii?Q?LAKoRaTBArmGOeRSHb2BGkiUy52L0XfmGrVijwQr1YoNkMvI/OYPJMfFqQL7?=
 =?us-ascii?Q?RXAej00Vg1hs8qdcLvkDHoct8zvg9cHJ+BGb8PhPal6bAaa+LmZiiZkayXEe?=
 =?us-ascii?Q?iLxBmYszCnXUQDnEag7165907qZ073q0bL3vfK6i2ZRA9RVvXIfqnE6nXaiX?=
 =?us-ascii?Q?6OM8wbpFK4gtS15iNYmrW6dzVPqtoZqoXopR/4TF1yXWkZ5pV9irhC/5bxDS?=
 =?us-ascii?Q?kDcxgWlr6Fdwp2pXxR2lD8ZSAoOtFsmxr5W6tJsKFEwNxkdgO4YQEXjykuP2?=
 =?us-ascii?Q?0vnC1SVnUPKcnw2Oz8bPyfRzm3cwHMRwcgyU7oEZz5qz0DRRt1x2SEsz3j4O?=
 =?us-ascii?Q?TmcjCTRO7REOjKE0Aa4mTSpUpVP0ZrIWXlg95n+zQ5HQ9yH36WXunF10vjmY?=
 =?us-ascii?Q?fGKtpVQpG3NjaleWVsO+uRD5vR9UDcujLpQSAoq8pYA1yCZ6nG2td3DCV4LD?=
 =?us-ascii?Q?Wg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OOrs8Irhgh6/tLi1zMNsFmAO3BnJ/p/d2iEveW1M+Zgj0OUtfYcuE047FURXqvbe7Zp6zIPQ88jQ1qGCw4/Z3jFQsip+I2IuR7QZLVfeZOII9lb/jk1nZLAKTKgBNrOt4vDBFW6Qr30NW+fcX0j3Gp8W0jnPFZH9kviT12K+Swr0UOlIJRbFX4ulinYJMi8KuFRBiDI38/n0jfp5JndBgKGYoT3rwiZyACOtpWh/AguIdN+73e5+x28yVdjGLihToeQIHDErNMdQHmbDPni68zLdnXRL1mTaGa2xi7KL/uOJ7n+N6r84pzvMNmhsOeZOPvHWeBNxCySIx1yvETJIQayf7IEcXSuvDJuX9iHGB7xsurLmeUNjUom3tA7G4XKM6l2f2kgEUCLbXkrWwep6uRMs6RiyVBkLOEGghjJW7X+JhUDb8NpEAN5t72J/5wmoTo5Yf3VRO+zj3qJIZR9HJRCRdkIikfAjVp7rifmB86YS3KAjp8Dn3h6yCbkyesE7ueDVd5D7ucPQNakV4FhaIS8y/GZAdy1uIaUcn/FQm3P0xyCg2W44Oe1c0oyzmu/lbwFbaV/rQUBa4lvYOmrDnAaAME9gfORHSli8diKxvCo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f78788d-926f-4b8f-402c-08ddf1e2d615
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 09:57:51.4448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d4PefR0WDOtqWU4yircNAT2qLxtlqL5MtjthEQQm30tmQIw46sel9TBvliNfvRV/DFwYrTZUSzzDqvvGVv9aBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5909
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_03,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509120094
X-Proofpoint-ORIG-GUID: BmJzpoEh3C3f_5m5lbpwOE5hdR3k6RQu
X-Authority-Analysis: v=2.4 cv=PLMP+eqC c=1 sm=1 tr=0 ts=68c3eeb3 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VTTeaPD8zcNgvk5ZtQUA:9 cc=ntf
 awl=host:12084
X-Proofpoint-GUID: BmJzpoEh3C3f_5m5lbpwOE5hdR3k6RQu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2MiBTYWx0ZWRfXxnI7N1bzwm4x
 iL22oeOCrsnFijSLme/W/HPgGMSpgBAMAMZTS9qgmG7Bot0RM+GazHrJuZSbghCJ5DKRrNRWSbx
 k7UmOkQaazNjVzXAx1jLMF4rrQlwsYzYXti6klRV9+O0pf1GJ14Q6h5BqD+moW1kEMiWOE9XDSo
 dm66+dea4eQDmGdjK7BHG6uc4EEci9K9E3hnByI3ZffJSPPLBZRcGWiZ150fldZh96zou3MwP9l
 lX08cSmVCEdTsuyfQtOxkLNd8YrwreP+CRz2yBkd7YVkPtF/csfVlDsKwxY8rNkbamdBjMMBawX
 lWgPu1drD6KUbzvQeN5aZ0x1H5zCf3cyz5EMihw8Gie/A2R9010vmktHJUROsKaV0EXmV0RgQRU
 nYEQRK+AiDiTe7pEID5elp2nRzC86w==

Introduce testing for dm-linear.

We need to use device mapper tools, like vgcreate and lvm.

dm-linear does not require any chunk size to be set, so only test
once.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 tests/md/002.out | 13 +++++++++++++
 tests/md/rc      | 42 +++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/tests/md/002.out b/tests/md/002.out
index b311a50..5426cf6 100644
--- a/tests/md/002.out
+++ b/tests/md/002.out
@@ -116,4 +116,17 @@ TEST 9 raid10 step 4 - perform a pwritev2 with size of sysfs_atomic_unit_max_byt
 TEST 10 raid10 step 4 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
 pwrite: Invalid argument
 TEST 11 raid10 step 4 - perform a pwritev2 with a size of sysfs_atomic_write_unit_max_bytes - LBS bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+TEST 1 dm-linear step 1 - Verify md sysfs atomic attributes matches - pass
+TEST 2 dm-linear step 1 - Verify sysfs atomic attributes - pass
+TEST 3 dm-linear step 1 - Verify md sysfs_atomic_write_max is equal to expected_atomic_write_max - pass
+TEST 4 dm-linear step 1 - Verify sysfs atomic_write_unit_max_bytes =  expected_atomic_write_unit_max - pass
+TEST 5 dm-linear step 1 - Verify sysfs atomic_write_unit_boundary_bytes = expected atomic_write_unit_boundary_bytes - pass
+TEST 6 dm-linear step 1 - Verify statx stx_atomic_write_unit_min - pass
+TEST 7 dm-linear step 1 - Verify statx stx_atomic_write_unit_max - pass
+TEST 8 dm-linear step 1 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 9 dm-linear step 1 - perform a pwritev2 with size of sysfs_atomic_unit_max_bytes + LBS bytes with RWF_ATOMIC flag - pwritev2 should not be succesful - pass
+TEST 10 dm-linear step 1 - perform a pwritev2 with size of sysfs_atomic_unit_min_bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
+pwrite: Invalid argument
+TEST 11 dm-linear step 1 - perform a pwritev2 with a size of sysfs_atomic_write_unit_max_bytes - LBS bytes with RWF_ATOMIC flag - pwritev2 should fail - pass
 Test complete
diff --git a/tests/md/rc b/tests/md/rc
index 105d283..a839a66 100644
--- a/tests/md/rc
+++ b/tests/md/rc
@@ -16,6 +16,8 @@ group_requires() {
 	_have_driver raid1
 	_have_driver raid10
 	_have_driver md-mod
+	_have_program vgcreate
+	_have_program lvm
 }
 
 declare -A MD_DEVICES
@@ -81,6 +83,11 @@ _md_atomics_boundaries_max() {
 	echo "0"
 }
 
+_get_vgsize() {
+	vgsize=$(vgdisplay --units b blktests_vg00 | grep 'VG Size' | tr -d -c 0-9)
+	echo "$vgsize"
+}
+
 _md_atomics_test() {
 	local md_atomic_unit_max
 	local md_atomic_unit_min
@@ -145,7 +152,7 @@ _md_atomics_test() {
 		let raw_atomic_write_boundary=0;
 	fi
 
-	for personality in raid0 raid1 raid10; do
+	for personality in raid0 raid1 raid10 dm-linear; do
 		if [ "$personality" = raid0 ] || [ "$personality" = raid10 ]
 		then
 			step_limit=4
@@ -210,6 +217,29 @@ _md_atomics_test() {
 				md_dev=$(readlink /dev/md/blktests_md | sed 's|\.\./||')
 			fi
 
+			if [ "$personality" = dm-linear ]
+			then
+				pvremove --force /dev/"${dev0}" 2> /dev/null 1>&2
+				pvremove --force /dev/"${dev1}" 2> /dev/null 1>&2
+				pvremove --force /dev/"${dev2}" 2> /dev/null 1>&2
+				pvremove --force /dev/"${dev3}" 2> /dev/null 1>&2
+
+				pvcreate /dev/"${dev0}" 2> /dev/null 1>&2
+				pvcreate /dev/"${dev1}" 2> /dev/null 1>&2
+				pvcreate /dev/"${dev2}" 2> /dev/null 1>&2
+				pvcreate /dev/"${dev3}" 2> /dev/null 1>&2
+
+				echo y | vgcreate blktests_vg00 /dev/"${dev0}" /dev/"${dev1}" \
+						/dev/"${dev2}" /dev/"${dev3}" 2> /dev/null 1>&2
+			fi
+
+			if [ "$personality" = dm-linear ]
+			then
+				vgsize=$(_get_vgsize)
+				echo y | lvm lvcreate -v -n blktests_lv -L "${vgsize}"B blktests_vg00 2> /dev/null 1>&2
+				md_dev=$(readlink /dev/mapper/blktests_vg00-blktests_lv | sed 's|\.\./||')
+			fi
+
 			md_dev_sysfs="/sys/devices/virtual/block/${md_dev}"
 
 			sysfs_logical_block_size=$(< "${md_dev_sysfs}"/queue/logical_block_size)
@@ -380,6 +410,16 @@ _md_atomics_test() {
 				mdadm --zero-superblock /dev/"${dev2}" 2> /dev/null 1>&2
 				mdadm --zero-superblock /dev/"${dev3}" 2> /dev/null 1>&2
 			fi
+
+			if [ "$personality" = dm-linear ]
+			then
+				lvremove --force  /dev/mapper/blktests_vg00-blktests_lv  2> /dev/null 1>&2
+				vgremove --force blktests_vg00 2> /dev/null 1>&2
+				pvremove --force /dev/"${dev0}" 2> /dev/null 1>&2
+				pvremove --force /dev/"${dev1}" 2> /dev/null 1>&2
+				pvremove --force /dev/"${dev2}" 2> /dev/null 1>&2
+				pvremove --force /dev/"${dev3}" 2> /dev/null 1>&2
+			fi
 		done
 	done
 }
-- 
2.43.5

