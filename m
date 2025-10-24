Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E210724B28
	for <linux-block@vger.kernel.org>; Fri, 24 Oct 2025 01:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761270350; cv=fail; b=S6pmgRge71NF2psSD3/9jCzM/ubVms1s5fxU91qTfbYFlmOBoVU82AK2DoeqgWNtAzDuWEzvnwKtWDNda38XdECmraJLI5YHgOkAMbVRiEAZhRTpWVVArx7YDtjXay5t5mbnjlANqEBzo8Cbhf3hYZW9I9ghrLQePnPPwwKto1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761270350; c=relaxed/simple;
	bh=UqPuPZkIbFddTZAUXm1mZ+GlysabumoZEyt+HAqj0tQ=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=e8KVcgfGkeRsPFIGg7M7duhvPCEEwWKvfNJ4AMb634xOS0MNa8pkXU52O9Pf1C0+Dte4VwZNoEeaWN4k1g1Hdw2h/uzCi2UElfb3RL1C83NvuJQEN0Ng4mN/cMnN0Z0/sBO24CdglD1+qXz42ex+DL7KZ0dX/58yfZv4fyxvqlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZB8Rg8zS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eTVcZnbQ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZB8Rg8zS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eTVcZnbQ"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59NLNLaR016877;
	Fri, 24 Oct 2025 01:45:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=KDfI5bTA5/DImsZYbH
	MHqkUVURnmGoHyobxaoP+M2+0=; b=ZB8Rg8zSKZgJEnKxrQ7p929w6Bezea1PIN
	sG9/PBpRsQS6eSTvLopEBmRJCPFJCwZyszPvtQV5izlbn26CLuy/9r4NnaGL2+K+
	6Zpkhy3jEKC1T5TRAAUzdCLQIW/6OCTF/8zUru1dghVq/wkq8exOO51Jveta6t3h
	5UUpSkveLs+L74CEkCUK0E1SWpoHT1ciS0bcxWi4WP9UvZdGi69coh84abxdKFtZ
	NTjjHAtz7NDyNqwlRfsR4gq2CdDIdc0Q1REi/2+WgkZSwTJSVNtHYNELhJ+IGu1g
	Dus80kOHI+T61daZ0gUzZEGS6xFQXrHeyd36aJFdB8Z6FGX4R4GQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49xv3k3u74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 01:45:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59NNMLDk012752;
	Fri, 24 Oct 2025 01:45:33 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010027.outbound.protection.outlook.com [52.101.85.27])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bfa33y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Oct 2025 01:45:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rY3vJkwAqnhYRrlepEEPWBMknP9cs3P6kUHbHWYwBCSKHx0XVTVXGv1wDq4s0XPb+d7Mu3SRkp1NuQ3Ix5ukBnMY6x2fxQtMWpGFhom4osC2cc3DMtzsvz2Nwl+51KQozeCPCJgBplQOTVCTiq7WPkYTyBcqACCBbUatjro/tMI+rJzBsS1bpgxcCn04otDqaS6LKZ8vOjuY2bWzy643MZd3iK0VU76kZNJ8sa6sGvTJpugiRN/UesUJ4xZEcc36pzHYw9S1E/w+C+XQ69yhUGIv/7fba4MZ72sv86gUO7gtVGyXfJ0FO3yXO5cZQboTFHtiueC/G9prkT2+ztl3yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDfI5bTA5/DImsZYbHMHqkUVURnmGoHyobxaoP+M2+0=;
 b=AbgdyBljdlm2i+oavgZ1DpLvxmFc0IvrwMKrYSnUMCyuwm+a7/AkUvyTnO6i9fI4RZ2uwEf5r7kwGkpn1Oo1EF6i0/2B0hh3Pr+WQ1Ny//wnhCAJv7TpwcrG9TWy9wDmTs8r9UC1Eonkhu+m2sA57U0TD4+Ea/Tl/9OpfducZ6zMp5GOdbwE9zlGJlzt9GZcm6e0709cu9NGY1WlI6h3kzeK4uwaFV5FIMu34cA1U4cH+rjLQpNYltCXB/3bM4bFf2fVvjPaSc1dK5pGRQ7nCBTNREZ0EVSbVfoo/PtnPjlDennNtZmM+M6twK0CJ2/DgVEsEaqczHSpxNLH1uybKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDfI5bTA5/DImsZYbHMHqkUVURnmGoHyobxaoP+M2+0=;
 b=eTVcZnbQA1ANp4OXHyfdb3YsjgUKei821vJDdZ7r8nDhvN2SeZeSf03L1lMEBBH70+EeCep52smyawwQjoBs/SWu6SoQfJpN2h64qPZ/+AGdyj9kFjqcx7oahHirkQ0yZ085sEuYoyTMMlrqrQoXmP98Z0MM4SDoE34AF259ffc=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by MN6PR10MB8069.namprd10.prod.outlook.com (2603:10b6:208:4f9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Fri, 24 Oct
 2025 01:45:30 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 01:45:30 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew
 Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin
 <roman.gushchin@linux.dev>,
        Harry Yoo <harry.yoo@oracle.com>,
        "Martin K.
 Petersen" <martin.petersen@oracle.com>,
        linux-block@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 2/3] block: blocking mempool_alloc doesn't fail
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20251023080919.9209-3-hch@lst.de> (Christoph Hellwig's message
	of "Thu, 23 Oct 2025 10:08:55 +0200")
Organization: Oracle Corporation
Message-ID: <yq15xc5yswf.fsf@ca-mkp.ca.oracle.com>
References: <20251023080919.9209-1-hch@lst.de>
	<20251023080919.9209-3-hch@lst.de>
Date: Thu, 23 Oct 2025 21:45:28 -0400
Content-Type: text/plain
X-ClientProxiedBy: YQZPR01CA0190.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::17) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|MN6PR10MB8069:EE_
X-MS-Office365-Filtering-Correlation-Id: d49e47e1-e106-4994-1e89-08de129f03da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?beqTCxvAoPRdSW6kxFOBZhCC3z6ETDjNKWwJuR8PldHvsAVSxh6FZKhEhcni?=
 =?us-ascii?Q?km89JBiLK05jlBkCvpf+CK0WlVbQBEi9lEoiqAOPaZo5KMk1nFTW/xYgZhWm?=
 =?us-ascii?Q?ONKR1JDWMFJoNLsXSdxXwIHoA2EbtQo+azJWGGbYEmdA1tCUWbfGuNBhw1r1?=
 =?us-ascii?Q?suoNU6djSAYb17uDWTJsm5m/RCHO0GcDywZ80Yb1mT6IdMK82RTQFmbD531l?=
 =?us-ascii?Q?gj1QY53Sz8rHhJVV9O4rfmAtPhWWCrdioA5OvMsWAjFxYXSMCrE9i45ZEAzU?=
 =?us-ascii?Q?bwsozORkvGqLGNqs0AVo9d/gyMdxG/7aoqzjyPq2kSAgTtMpH3PBlJsRqHAU?=
 =?us-ascii?Q?rEiBrc2H0ecIrgivXzBegUJaTVVs0/0+GmzIV1jIjNCVBR5XUCX7YcQ0Xppu?=
 =?us-ascii?Q?oiLhQKi5I85u1qExHtxaYGBBiom5+9+YWi4eMJFp4NYhuCdyC1AOTaAdbfBP?=
 =?us-ascii?Q?c6HjDmD72NAm0o5ZRyaPMKi+EqCio2y2w2co2KKq26rRSzd0/pqYx83OYWJT?=
 =?us-ascii?Q?piQWzA0ujlE8N7eW2FDpfuSC9VAj0dF70HXPGsLSgX2GbUJYqX8LnixX7jmX?=
 =?us-ascii?Q?/UNA1Q8Rwj94gjeD4XKJcA70PVy0hwIMXRMDyEiRFP4ubOaZRe9zlJjYjbtg?=
 =?us-ascii?Q?4qCqrMAv74SchkrIpk5/riLKoKzu7O3alKU7pJ+nwnOyo71nPSmsxBQx/1Nq?=
 =?us-ascii?Q?Ohev5LydShROdubfvdScD71tE99x3nHa0iHX1idMiqD7xqj0TiuNbNat54xj?=
 =?us-ascii?Q?AUExXIGZwAad12siyMfPvnFae1RXZ2DM+ineCzlJLAommV9ZHFF8rDK1V/eE?=
 =?us-ascii?Q?i2hpFEHIt5Bb0TUpEevUhcQVWe/KkL5f9PxBtDxNJG+simXoEnWiyq1kREEt?=
 =?us-ascii?Q?AVVeuW0Vl+kF6aAbpFj8s/8xwgG98PPntTzxfFeJeAG/2TrhoHGbLd27GAly?=
 =?us-ascii?Q?H2un8iYfyZAjJQu++lNsfcF2VKNS7LWhYjtQuxjZK8tGZo7Q6OVtiI3vPRfQ?=
 =?us-ascii?Q?pqCsfPPJoACZYjo6uIoSC/9W4vwjd3/5im0sRapKh4HHJ2stkilaAQUIBKlz?=
 =?us-ascii?Q?kpU5LqULoFK4MLI7kWnjqAPg/vdkfL3RF17Y9q6kxCdB8oyWR0MpYioQWKEt?=
 =?us-ascii?Q?RszxdOIUzmyhiohMxPDhvJ7CIfodUI+zpYnTJDEpvzqra24/CvIwsyo2nIvu?=
 =?us-ascii?Q?WFJ3b2Pj00/R3v2sxQHa/lRp0s2pInDOMKWYYLRH6YW1Rn1kZ8N5WpPO+DbF?=
 =?us-ascii?Q?g50pNm3bDjtrmwqH+AzgRqv6++u6IsJSuLDpR694mZEqEnWHebtgraZKij6h?=
 =?us-ascii?Q?9ImdGMfOke/RBMUtH+Ko38AQ8v1bn1JI2PgJi617eif8YJhm2dvdVTHLKeK8?=
 =?us-ascii?Q?lPFlwHhcIPqQb0rewdFKUyLDJMk2uZY5MeiRYj+uNsLGgC6tfATssS9RWb++?=
 =?us-ascii?Q?x1hPEU3UE8lFv8py1BsEHhm5cb98rKai?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ssEJPL68w+bngVJ/9adjytGE6tD9fKpCqslFzxtjL6h5TRqEUVlx5xREupxz?=
 =?us-ascii?Q?Zpm7fxIu8O9h85sa0xdD3gJ/IPl6LnoCIxZGvm/gWIfuKEvrNfn/qRmzR92u?=
 =?us-ascii?Q?kdxx2gHxCL4cBvNfKXpIkhvnbmPOjQC90PF9zWKhtUDnRmDCIbgf6IQ1nQAc?=
 =?us-ascii?Q?G5zsIgAEWc6zxRlb07MZYBnfR6fCROdOGUvwYh4k9j1q4v+Wi/i/GnAKgKml?=
 =?us-ascii?Q?efC0L5SugmXc1Zr86vQFKW+ur8hT8PUWqiEacKN3fYIr/vxYksyB7zWZW0SQ?=
 =?us-ascii?Q?Y24j7i5yT7EWUXUlir+I56guI4Eo9EpkxmuxUJ0wzqRsLOiyD224SzfIrATW?=
 =?us-ascii?Q?KlU3W9RKvEaMnjeU096aVzyg9QfgjGd/COofnZHgOc+yxydPuWrUuOsifqDm?=
 =?us-ascii?Q?fIJwwHfTzYg1TyoVQcO8RSn+5o9RN2wQtKl45FJ7xY0/qkNal8LUADRzOFeY?=
 =?us-ascii?Q?d8lBvMnmK2jnON0lbkfdyQeUVudWClkKvd6wLYsRPNtooU7Jd/NcsixdQdAL?=
 =?us-ascii?Q?Vb6E4CY6HBZ034gUuIsKIjHX247IOKzC+YpW+0wg1LvMJc9KXhxz+cj2atLp?=
 =?us-ascii?Q?8CzQSbjZpdLkrbOb4p6GDTs766UKAuHxGlkItLexTYTPMkOrDY94tap+zUAB?=
 =?us-ascii?Q?F5ticnaYvfahZLB2MmTLyHvpJDAMFEwm8JffgXPtiVgTMmflDbjZAi2PTCBr?=
 =?us-ascii?Q?lMuwQ5vxt1r1DxAQsfnnGR1M38AddP5H+4zEq/cSh3Wqz++JqTNrQD0uESIn?=
 =?us-ascii?Q?5xhPkPShzWFUVfuZZS6DgleJlUJVCjkHzMX8a5LfbP8N94coXXELJygf7f4w?=
 =?us-ascii?Q?3lf0dkXcXCxtiw1TcTjYjbi2UTQQg7fJcRO0Buo8BVAimnOCwC4A7VVyznFD?=
 =?us-ascii?Q?Az0qhd7+B0G/z+9fPW6NMWzDSS89zjeM6YLzwehSckWyy+ygnc9ekDiaH36V?=
 =?us-ascii?Q?hrmCM92nVVfOgIyVBL5UEPE5AGNWEfzdZ44QLtXo9FH4p4vUK1ue5Jtf6u30?=
 =?us-ascii?Q?GhqfAUKjjSoJqegYP414a62Su2Wpriqxx64BTM4D6sd50B7f4TVNrnN7MLjA?=
 =?us-ascii?Q?VONJllNH6PPBoPACCi61H9MAHia5Xtjb0VocxURZ0uYDJwN1aMHKdy+52RL3?=
 =?us-ascii?Q?lEmsWtlLzPOhAEFX7rFAZJutDs97AAa8gGX6yf9PHlYItCG81N+eGaVU578L?=
 =?us-ascii?Q?i6oDrC1CQ4yNQHEO7DRbcWUJqrXh4Up9te7JizUwTN4Z4m+FE5aABtJaMkEF?=
 =?us-ascii?Q?ArALOAzh/SPlMRsyVyNdZd4tNIdO3YGrYu+T2ONSm046mV1TpAn5vRAPhAia?=
 =?us-ascii?Q?mtCgVy25qEfaL2V3G/7s+0W2c71wgKUIvZBJyH2XI7gmrUnI5Ol4Xs4PMN4i?=
 =?us-ascii?Q?VtM5+bwiTT4obP/Xw243KSj/jJjq3l72JbbPcIdsKUciLY3S7FhJBEfI44ox?=
 =?us-ascii?Q?ePCaHcxtAWq63y9Yp9gZTs+oBT5bRJIm39bQxFPlbFiknKHR1xfuMfll9mjo?=
 =?us-ascii?Q?IovXKGKyeR8c/3eVRrijeL00sD6SJW7wMoMjsQWpAOCp+jSKxcwsLbk+ybzO?=
 =?us-ascii?Q?smz3j4WFfzhIOrEPX9M6w3ahsStj+4mGeTbhqW2BXjA4v5OMnw/pXcLRzFxN?=
 =?us-ascii?Q?xA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CiKx4hlKCxbr7z3uyptiJ9T2DtwyKHcOogAzpzP+8xnLuMcDGiiUNtH+1ejuLFLTCWlb3neyR4Z/WehBQw1hm4bz/QNSg/iz8W+Ok24Wv/MUKIl5xPkptL6wLB4npiyaqqg7ltipg6JjeWm/FybXQfn62hvs4DkPVNmb1b/kEnNJwaB7VWmOcuEGX8NRyWjXXN+Veg+ognRwYQKKi5wr4SdZCPSlTIZffioYpT7uaIuKubkXWmci7uTtZH8N6ARG5HOwKbLj30I4l0vLsAfy0EUX1x/pxbf0xSggMLxiEC1XiiV8u7zyP43I3SxXjmnR/sTHv+6m2b2ya6f7sgw6wpxcQBPKVHKtT6NnsvpBxEHM8KUxQ3Qge1iJrokbctq4RTrt2rk+HnCIBn+aCFbyuMYJpEGeeB0nDNUIzZ6rNMR6sTUcE/+JHDhkflh86ukK8+yVi0Rfc8UOayo/LlKLnoR4f9It93nDKPvqqwM+MWxDsQUjx9QJQgTCb5674g0KB6H3ZJHHFivc0o/cez7yshVf8r94yJxZy0Oxse8ngWxh9evDeHJHwKEB8FibVwhNK1kp6/j4iijFeF4SnXLX1HuuQp+VZHyH2lM4+Wbw2Rs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d49e47e1-e106-4994-1e89-08de129f03da
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 01:45:30.8124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9f0yDGBHCjE1ds93Jo5C7LiU+xWW81yaEFqWQ5BixzG2CF81gG0VuVGDhEIvym7DVBG1DJQidUGZ5vVAJWNRKK22W7Bd/3xcKxMvEJ79wNk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8069
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-23_03,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=991 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510240013
X-Proofpoint-GUID: RB727X7vaDnxTt7B6X451b9ddxIrVXYO
X-Authority-Analysis: v=2.4 cv=bLgb4f+Z c=1 sm=1 tr=0 ts=68fada3e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=5bH7z0BLeiDiQMqUfeQA:9 a=MTAcVbZMd_8A:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDIyMDA3MSBTYWx0ZWRfXxG9jDAWnYVqT
 9tZkDnPb/x78ynRuVl9r0Tnx6Muoe6mseUu3bp9v+FQMD15mcOa8jEVcRc3H+jB9l0xHw1i8TGi
 +LJRE7QtnmvHEaIq1JWfHqvVXI2zSlaGNJ9uadFw7bQHT2m3wSJiXPLRkLwKHCyI9dAg+ar368h
 exElrAj99KwzJulhZRHfNgeUBXl4nDDtDcKMhCA13B2CtDnbHtcttM3i9h3GH3wdn2AEHvCn+71
 yunF4tQL/qLBLvKDlJfyR9+2B/7p+m6dgzClEoWStEGHFyGaRdZHnua9sHhp1sI7vcSIS0XL5OJ
 VX1ZmIzGVKA61bDMhqXWvdQV9Smz8PXOMvOT4RUZWLtMiVMdb3QPdFWeCiav1AAhlu3oRQmF/Eb
 TGWlvEVF/pACGJNZTWkBhQDXTgnKmg==
X-Proofpoint-ORIG-GUID: RB727X7vaDnxTt7B6X451b9ddxIrVXYO


Christoph,

> So remove the error check for it in bio_integrity_prep.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
