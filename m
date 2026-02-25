Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C121885A5;
	Wed, 25 Feb 2026 06:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002480; cv=fail; b=M2g9BmApDPfdQK0WfLwdOQW9NAMCNDpDU6W0xEloyUNqqs23gp95I5ydttHki+BJFggvajKofCEM7HLuuQpo5Pn8ji2QV9H6gH3e9rS+PRchpLQEQklb6/ARaDk04edLiV2SdOQimCnB4vY5uJZKLDRfuXC8umZ78+gVNxElymE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002480; c=relaxed/simple;
	bh=mSsjqAx0Ah2R8+Wd033gWMZO8J3VGsuBU3W27zRuU8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dk5Nu4ad0/MAFMULvLYSYjjcKqexWMCj6Vr0VoSAFwZI/37LrofRDcCBC/FPVNcpdZ5KDc3pyxj3aLcOZMGsyJ2vwoL+hUeuX/2mg1xPhod3i7XxycOYPVldrfmhMhf1mo+l0puWyyUmeb9N0kDdm/vJv5YnobB8JE+W71XjtHg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jjXgK7CI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wsE4rcU6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jjXgK7CI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wsE4rcU6"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OIu3LS3928862;
	Wed, 25 Feb 2026 06:54:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=1dO3rNo8koMpLp65kN
	mvA7uKGgar/BK/LKoJvCIZxpY=; b=jjXgK7CIXojlQhS1PUNmfMtqYYS7DYzWf1
	lhWdgl2sl9w5uPzz5cX5GztEe4OVpyLe2zptrlbg4HsuNk9ndvoXXapFWCIy/NBB
	f/dJ4C3HTPbKSi6t5zCVwqX9og2KGxdV1PZ14HO7quRK+VigsfgQWSJlFXwKE/H6
	k5W2NWwRU26okswmvz8pZe4XwwtFE4UcWp2O9//haJi8fBsdzGfChumST36e2gvH
	HjHCqsJgEiJoIgiUtSGC459JXpGlXq41TcUib/obrgPrTkhjEbEpB4qf3hxzwPTI
	5kd8q9uoz7XG2SaNGOuIo3A7PUletZX+lx8zBE7FVgAnBToXb60w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf58qdhwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 06:54:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61P60SlI038465;
	Wed, 25 Feb 2026 06:54:18 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012049.outbound.protection.outlook.com [40.107.200.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35myaq2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Feb 2026 06:54:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OK2cUlFKN5BmJRsKDY+etGK6Khwfy9t8RiIrnoabRHp3PE4Mha8hUnWuVJ8fmw28nJzLN8UTxOYVPwFjaIVm92M6Qpv1xd3n99ZayG9NA1pKo8LiGe8iktymK5Xe5mBTSBWdFQH6PErTdvk/eiT+0eEIJIq5dwy2TCmi/XXcYhI7jb61pZ8PW3VgsvTHRTqquZVBUZzGqWTMJHsmWiTDsueZB62g0eGH7bA2yl80I8fkGy2LNORPAZw9p4o4SH53uQIGpf9HOTCEGyInN5ojgi5kUpuvYUqFRd5rgl0ksRTZpvP1+b/Zx3qwrW5Kr9TIvpXBwyUwKd9xs1gvmFyKuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1dO3rNo8koMpLp65kNmvA7uKGgar/BK/LKoJvCIZxpY=;
 b=GMjNrMyGLiWn5lH9XGh/+Mv0EdFmwVQkzSs1M9JfN/XStx0VXja31gb2BwT7YSHzYfjRZDxGV1VNG8iY+I0muwn82m37ae+O190lrneNDZhXIK0yFL+SCC/hM1y0RbJzfy1GD+mOmn+nqz9H/KjYjJ0qlU3Ar9263UqLjT9jFZ1hDo1+UPAsYt99XbKZVwqYr/e3yiLrlIrh3caMNlG9sDvxyE+pcej4deQmlRtI3p0N9JgVF2XNirde7TmYcred4P10hHQ6GHUGvTjvOW+s2ZL6nOkpW0+2tnfGtlzNVHYfJ8/UZmgBlTQwEZGAY8nwyVOJVxUwTo2cBmcezgWwUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1dO3rNo8koMpLp65kNmvA7uKGgar/BK/LKoJvCIZxpY=;
 b=wsE4rcU6GKLXx1cY07mAi37OHncbI0qpXVCA0hptjZVLrfvQG2pRjRtHzxIBbvW38f3fCQZtBAX8Z6V8jD2jlH6UFM/lMlvQIzc9ci0qMhHncQLTg8ieFSRfH23xI+pmP6ZaBpzgyqpm6efByJEF3r6EDjLN7ZWwid2WhgAlIeI=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SN4PR10MB5653.namprd10.prod.outlook.com (2603:10b6:806:20c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Wed, 25 Feb
 2026 06:54:15 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 06:54:15 +0000
Date: Wed, 25 Feb 2026 15:54:06 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Hao Li <hao.li@linux.dev>
Cc: Ming Lei <ming.lei@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        surenb@google.com
Subject: Re: [Regression] mm:slab/sheaves: severe performance regression in
 cross-CPU slab allocation
Message-ID: <aZ6cjpU36_EmXslf@hyeyoo>
References: <aZ0SbIqaIkwoW2mB@fedora>
 <aZ0wX_QuxNTxXHMj@hyeyoo>
 <aZ1qRhIGDAR7d56r@fedora>
 <qiqptuqsiaufeasf2xukfzoumiyoau3zfpokosn2amgc6zskc6@vl6ie2h2zj4m>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <qiqptuqsiaufeasf2xukfzoumiyoau3zfpokosn2amgc6zskc6@vl6ie2h2zj4m>
X-ClientProxiedBy: SE2P216CA0199.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c3::14) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SN4PR10MB5653:EE_
X-MS-Office365-Filtering-Correlation-Id: c8343332-a16a-42ae-bfcf-08de743ab02d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qryaFVfXiFqrDWiMk7R6rFtfio3xTfZjAXYYins0Qe6gQqDyVFzp2+XcW0xK?=
 =?us-ascii?Q?eR/Nwt6yb2W7+01wVZuiTEPPLgKClKk84oRGOG3BFdypk9Jvr2L0t154eyd8?=
 =?us-ascii?Q?7oXlTu7sxc6qNDqd/1iGsQK+BijM72Am0I0ReI5bcLekP4ZTAhZNI65VcyHa?=
 =?us-ascii?Q?8UY4St0Dkq3ZTqyRGFO7e2XdP71zZQ7kP7OFuDwHKTqtaR/MIaWmF3oOBJqf?=
 =?us-ascii?Q?V8H/Z3FrKBu1tz4cRR+p/uaug5Dvqjpncv51az91ZJHz1W2oajyjbg/TtMvN?=
 =?us-ascii?Q?REaGGdF1o/0dcGBk5DXzkaIpmnnZNbrF/ubWxRuA3kn+FC/I5j/xLlH8Ol4w?=
 =?us-ascii?Q?16VZxOUX20l3ZSKz2B6M2PZrHKqmMwCfLBHPq4+iprrexsuN3Si1qH0RPVWj?=
 =?us-ascii?Q?pC7Pi1aMOWvY5VzjWdbAoYs8YMOA0O4SvdAbl1OgEim9AveuEB6uP6KttF3N?=
 =?us-ascii?Q?D/gNCkMOZbfqom5E8uPkwcGRkPKaD0FQIdNwo2C8KrWfIY0jkFDqQCtxbstO?=
 =?us-ascii?Q?2fZM3Zi3jmFXTwDaUoyveZhwtIxsh0ab0DIgWJlyb+eElMa3xAjv+LApTw9E?=
 =?us-ascii?Q?hGixrZma2+br4fO00uyH546pr+Bb5sff5V1MxfQxHuqThX5veBRCpCalfjPV?=
 =?us-ascii?Q?ZEBok9KJIe28atO7n1TOzOqsSxe7g6zS7Vf4+ZxRJC3D1GTkZRcqUOHUHJKf?=
 =?us-ascii?Q?vVOJV3Mxl3hyGUh6lbJMuQD1wfDNiu1TSHoBOOL4Gp3ygsXFfYao6+BJv6Kf?=
 =?us-ascii?Q?zUhk7jZSAWGWvdPG+kyPHJ7W15WxIIx3YPL2bl9kJiXyQpZaLBK50SelJVi7?=
 =?us-ascii?Q?E39bYxLTsh528oiaN7EWfkgQzFxNkfQ5yCNaOqkBioyfHRm4cLkAWd8MdsVH?=
 =?us-ascii?Q?sukPR1P1alI6GEr7NyKzoScdVw7iAM/RIt5f2vEyPDco5dvlaUEeeql1uCqG?=
 =?us-ascii?Q?Q+dRbuTsaj3GZqNuUSKhmLQDSyrRqwcWS5dfEsygaiKk9ya7Wqw6/20BK5Uc?=
 =?us-ascii?Q?hacWttuUTKwavz1orI/SlkxVgm/L0o9YbnwrQFq3Gq2JXz1C1l27u9kSFeEt?=
 =?us-ascii?Q?xeJwLsW6n6FQlhQHbwySlxkmHuK31PdkQVey8/WMi1VUbrYyUXsf3OFLQSts?=
 =?us-ascii?Q?Gdl6kUO+hRoUCLcULGYooLVYtS995S6hym0uDOZE0N+Y6w66LHCeKtKdlyzM?=
 =?us-ascii?Q?nr9Pk/mwgLyUAST2kZgzaJAMswSJI4qEgfaj9S3BQFwK2TdGVKLmBPUSJSt0?=
 =?us-ascii?Q?qfpDFAv83c8y98G3aIzwcci5wcxgIZWlcJYJqYGmuYbPsryweHmI0AYyGfOY?=
 =?us-ascii?Q?1jTLFKLxgvzsLwfzDE6jQlovBqI+eEtzolGPQEkAPyXhdAG9juqCLEuaBD/l?=
 =?us-ascii?Q?pD7eVyamXc+HYaqz7DRULxZFK6Dfgp5zIIAgfHnNADvIjftb3/0JaMF/jiK9?=
 =?us-ascii?Q?+jLo3r+JvKdmwa7W3PTL1zTiiFMT8KXtfYUAUAjeT/tajBfwgA4um0KXfcH3?=
 =?us-ascii?Q?hN48OI91DpdHaoR1ibK2ChpdMEHskx/4pFdyGaab2C8/nExkdyB1NKKxyWE1?=
 =?us-ascii?Q?luKiv7MVYmTDdNZRcUY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gIkB53ChXvMKk6EsY2P4E733N6c5yEF5LW8x/D2IPH1AtrpUS64qrjXbSkLx?=
 =?us-ascii?Q?XL2mBWkj4lIg7vcBzqmtj8C7j43242Bmj/OMKIU/9TeihzPiplYRjiPgQ0ge?=
 =?us-ascii?Q?xGa6/QrSwB/r1cgPyEAAQxELoW8eTlPiYB7So450Rz2tOsptYTreG/EC58uo?=
 =?us-ascii?Q?fKkp3X23nvzm+LmMS4B2uTcc0F1bOnCym/Rg3906wnNxUqe8WECRlo4iLdHh?=
 =?us-ascii?Q?+V8dL3pPhLkixGkjrO2hMHpDqP5rHGpZgiHGDw9HFzcEYaEVmnpn3of911me?=
 =?us-ascii?Q?4A3rJ+fERO0pd/IL0+mOPMOBf8lWy0S9A+KyCGerGIo4nUxXQdmBfO54MsAd?=
 =?us-ascii?Q?89lTyelEY2nqfbrvpWMbmUIzsO0Y7kLpotY36M9xWQDEnX3n4jrElRA+CxRn?=
 =?us-ascii?Q?GIfhYKTLzBz4s9695SrB8APfBWC1yRn8/JgyeSXxDE9Kzk2KuBCo00xhFfD2?=
 =?us-ascii?Q?YGpyd1SlZHiqLfa/JQIQ1OUEmUUQszCnd4AGuqWs8d2vFnUIirvK2YApALRM?=
 =?us-ascii?Q?i6ZVnc+cflpfRBAt9Ow5tEaZqN5+f77w49M6JFUWbTEP6ikIxic3KxVbVzmZ?=
 =?us-ascii?Q?IavpkcfUM/ebGUdUMI3K1hpYrc5f7BDDB2LPequb5b4RhcygU0HAjiQdMO3m?=
 =?us-ascii?Q?d464rzNL4hhDM0mQwYDq4nIGauLNsxApX1CR2OaFO6IZwn8Shfg14e4hEvby?=
 =?us-ascii?Q?i2Gw9B7DUcV49DU91hQwmJiGAkHxS7e+qIxHUrzfyeDmDKsEaZ86NAoj/XZK?=
 =?us-ascii?Q?dfA7VXPHmcrvUCaeWJx1PCFYl0UTP7tJQkOO9yq47tHzCmJugKfUofg0Pz0G?=
 =?us-ascii?Q?eyhaKy/j+J2TFmiSAfjZIoEMaeFwoVvpy9s/NU6k89Q5i6WMAIfHQcRAHmyT?=
 =?us-ascii?Q?ZNQQK1bLPCCVQNh5bq4UqOZWjCjQEzlQYikQ4bJh2m7Sh2KnmdeN1oBRZABu?=
 =?us-ascii?Q?zcBfGNyP6Q4QKitzDzyyWlWIjmph3UYK+ckLtlhPUpDeEY2xRpErMI0/NLJm?=
 =?us-ascii?Q?88kn0Di4aLXDWx7lTRtH+1eS7i4jJnXRXuEkYPjooOJBg+ASa7gFTq3ELquH?=
 =?us-ascii?Q?6H8JlOzZtUx45jJFnFKtmfhi4ue3OBuzrU5xegJiqTCfuSAt2t2hivGSPFsr?=
 =?us-ascii?Q?S9SZkeR3kUsxkJakajrhS/i7ovj/I1jKmZdYcDqHHum5pJ+c9oFd+kXiyS/e?=
 =?us-ascii?Q?P4uSDxFAjZkrzkEMLNWIZIYPRh4mI48LmPZb10VPfa9nad3KkPjDRvJX201f?=
 =?us-ascii?Q?pyKcf9yoCwMgLbVgYxMR9auE6fvohDXz4BMGfMcuo5cDe951Iygfz0BQC1Dn?=
 =?us-ascii?Q?Q82dvaLP3ZfEraIgyACFhpK0nSScRY2cJ+OcZI8ydKkxNf8LXDJEIdTpVl1N?=
 =?us-ascii?Q?kkSDmL8Fo+EDcqIvwYbWi/QCcRX4BJGhcsdXZ3n7Tuw4gLTjc9aimhzrq69+?=
 =?us-ascii?Q?lmeDn/Q6h4sVGFp6/Dj0Vmx1/uK+auSZfNe+aeV0cosRNNzQmMeYWR8Ul1Va?=
 =?us-ascii?Q?ZkT14aZhxsWBgG0WlDdMQM+N4h5pOVousYK1zzzOxum0Cmlp7PmV6d1mHSFU?=
 =?us-ascii?Q?M5A/K2xrRdjo6JofFODtG2YL6+t7+YRHA3pqwtV0QuQBLo0za2Ep5XhWYY6Z?=
 =?us-ascii?Q?9y3pBAbwXCUaI10Ds30/hGElTlJCNGN8ASwrQtbDuBPgu7vxegiizkMnsiCz?=
 =?us-ascii?Q?ji9Id8l2F7v4xDwDMiO9jLlTzsA7sqMftlGuIVViKCaaL93no3IwrOsuGwa+?=
 =?us-ascii?Q?vwxZ7FKrww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5pQKTy4uR6SoiPzAf9Y19dSEZ2Ana3/IZZ8R3mBLhSlcIOulyOdJt1rizFp2zojBBoUA3msrTPtN+OrZl+oHWn5B2OGAwh9Iqu223HBiTeFgPIhcAC7wSwPA4/LzqYwCdma6vCVd56zV+/alN3sylEuFCExKq5LD1V0+1sbd38p9gXnFd2TXWRwWxECjIZ/tdxhYecoWvMy5E0zMyBvVoSXABYwKSsfOqiv1WQoaY4JFwXrlTgzI0HPcz8ydwv+Zjewg3WQqkRTH6DJuxDc/YmyU6JYJ8mOOqi6pHg9KR/HyXK1Eq19x8KK5qpAXJgUSehaN5CXg59/sPLzMLPZYeHPMlBWSFW/Y+DY8fx/Rk8LqLy+RhbSrYMP8FNYVTxTQHrMUcHMSS3p3C4CVy62oJHipxp/x9D4T/BMq5e3BC3dw1amfMF/YUIfiu1vvas4tViRPUCP+skolB08ADbGtWlizAWDj95V01E9RiGlJiHrWMTidwOvSSh5JoOju8YkX2Etn0b9XxddiijSRl9ALQNSitJ+5nIzwiYSWSBHScXzsmwIuVN14XtXZwCJVwUacpWN9cTGCULi53NZpnWIYTyWQyUlgLvggzKeqXtnMviU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8343332-a16a-42ae-bfcf-08de743ab02d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 06:54:14.8904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zbHsg9+HCgQT/dLOd3EOx4DcGcwxzm2kWE+SBQpQgx9oMfNiD9VhgIQMnYfiFqcDY0OnTRJt7a3XIIaQRRutTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5653
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=542
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602250065
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDA2NiBTYWx0ZWRfX0X8pLJG9KjiY
 w4l/EV3PPjg+4gkwVJR/+boUN73XV6rOFB6FvY4bPIgSqoJC89jqXAncSWiF0yTkas2tKzuBweo
 biD9Kyjq+Sh9WIlrDtF7Jba+cxjDPf73U7O5oZepjdtyoYXH/qlT88eZFsvCv7EVZ5FqaU04RY6
 NZ04JYfnnltGErgjD89YTcBVUcpteiN8rzPI9Pc1gAJotW0fDCHD/gdJto/BjmciNbTt0mz0DUf
 CHXlf1ZG3k9yIjCmO0h3ZljHKlrYwMNAMcWiZ8ym7zTX0pBgVai2QtXHhxYoGCdn4OJFXMTtWl0
 s9ET2yTjO4e2E8mmAxokLkPAbbIKlXork4jcxQJPnS3XFgCbDvM2zcQx7C/8+S87kPymNTh9oyv
 tY14kSqxCPw/ROyhO3nzs0tlWpfM6SQiSPW5wIDO0NVgmFeoabZJo1Yqo6rndha7UA4Nn+o3tKv
 8MyipA8nu9x3HRLBZMtwuMR/B5Mr1EreaGtCZlNA=
X-Authority-Analysis: v=2.4 cv=XNc9iAhE c=1 sm=1 tr=0 ts=699e9c9b b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=MVFibi2IholTTPE6U_4A:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12261
X-Proofpoint-ORIG-GUID: q6XJRd69ZtMrRIkfBKolTKOc9wwTaheJ
X-Proofpoint-GUID: q6XJRd69ZtMrRIkfBKolTKOc9wwTaheJ

On Wed, Feb 25, 2026 at 01:32:36PM +0800, Hao Li wrote:
> On Tue, Feb 24, 2026 at 05:07:18PM +0800, Ming Lei wrote:
> > Hi Harry,
> > 
> > On Tue, Feb 24, 2026 at 02:00:15PM +0900, Harry Yoo wrote:
> > > On Tue, Feb 24, 2026 at 10:52:28AM +0800, Ming Lei wrote:
> > > > Hello Vlastimil and MM guys,
> > > 
> > > Hi Ming, thanks for the report!
> > > 
> > > > The SLUB "sheaves" series merged via 815c8e35511d ("Merge branch
> > > > 'slab/for-7.0/sheaves' into slab/for-next") introduces a severe
> > > > performance regression for workloads with persistent cross-CPU
> > > > alloc/free patterns. ublk null target benchmark IOPS drops
> > > > significantly compared to v6.19: from ~36M IOPS to ~13M IOPS (~64%
> > > > drop).
> > > > 
> > > > Bisecting within the sheaves series is blocked by a kernel panic at
> > > > 17c38c88294d ("slab: remove cpu (partial) slabs usage from allocation
> > > > paths"), so the exact first bad commit could not be identified.
> > > 
> > > Ouch. Why did it crash?
> > 
> > [   16.162422] Oops: general protection fault, probably for non-canonical address 0xdead000000000110: 0000 [#1] SMP NOPTI
> > [   16.162426] CPU: 44 UID: 0 PID: 908 Comm: (udev-worker) Not tainted 6.19.0-rc5_master+ #116 PREEMPT(lazy) 
> > [   16.162429] Hardware name: Giga Computing MZ73-LM2-000/MZ73-LM2-000, BIOS R19_F40 05/12/2025
> > [   16.162430] RIP: 0010:__put_partials+0x2f/0x140
> > [   16.162437] Code: 41 57 41 56 49 89 f6 41 55 49 89 fd 31 ff 41 54 45 31 e4 55 53 48 83 ec 18 48 c7 44 24 10 00 00 00 00 eb 03 48 89 df 4c9
> > [   16.162438] RSP: 0018:ff5117c0ca2dfa60 EFLAGS: 00010086
> > [   16.162441] RAX: 0000000000000001 RBX: ff1b266981200d80 RCX: 0000000000000246
> > [   16.162442] RDX: ff1b266981200d90 RSI: ff1b266981200d90 RDI: ff1b266981200d80
> > [   16.162442] RBP: dead000000000100 R08: 0000000000000000 R09: ffffffffa761bf5e
> > [   16.162443] R10: ffb6d4b7841d5400 R11: ff1b2669800575c0 R12: 0000000000000000
> > [   16.162444] R13: ff1b2669800575c0 R14: dead000000000100 R15: ffb6d4b7846be410
> > [   16.162445] FS:  00007f5fdccc23c0(0000) GS:ff1b267902427000(0000) knlGS:0000000000000000
> > [   16.162446] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   16.162446] CR2: 0000559824c6c058 CR3: 000000011fb49001 CR4: 0000000000f71ef0
> > [   16.162447] PKRU: 55555554
> > [   16.162448] Call Trace:
> > [   16.162450]  <TASK>
> > [   16.162452]  kmem_cache_free+0x410/0x490
> > [   16.162454]  do_readlinkat+0x14e/0x180
> > [   16.162459]  __x64_sys_readlinkat+0x1c/0x30
> > [   16.162461]  do_syscall_64+0x7e/0x6b0
> > [   16.162465]  ? post_alloc_hook+0xb9/0x140
> > [   16.162468]  ? get_page_from_freelist+0x478/0x720
> > [   16.162470]  ? path_openat+0xb3/0x2a0
> > [   16.162472]  ? __alloc_frozen_pages_noprof+0x192/0x350
> > [   16.162474]  ? count_memcg_events+0xd6/0x210
> > [   16.162476]  ? memcg1_commit_charge+0x7a/0xa0
> > [   16.162479]  ? mod_memcg_lruvec_state+0xe7/0x2d0
> > [   16.162481]  ? charge_memcg+0x48/0x80
> > [   16.162482]  ? lruvec_stat_mod_folio+0x85/0xd0
> > [   16.162484]  ? __folio_mod_stat+0x2d/0x90
> > [   16.162487]  ? set_ptes.isra.0+0x36/0x80
> > [   16.162490]  ? do_anonymous_page+0x100/0x4a0
> > [   16.162492]  ? __handle_mm_fault+0x45d/0x6f0
> > [   16.162493]  ? count_memcg_events+0xd6/0x210
> > [   16.162494]  ? handle_mm_fault+0x212/0x340
> > [   16.162495]  ? do_user_addr_fault+0x2b4/0x7b0
> > [   16.162500]  ? irqentry_exit+0x6d/0x540
> > [   16.162502]  ? exc_page_fault+0x7e/0x1a0
> > [   16.162503]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> For this problem, I have a hypothesis which is inspired by a comment in the
> patch "slab: remove cpu (partial) slabs usage from allocation paths":
> 
> /*
>  * get a single object from the slab. This might race against __slab_free(),
>  * which however has to take the list_lock if it's about to make the slab fully
>  * free.
>  */
> 
> My understanding is that this comment is pointing out a possible race between
> __slab_free() and get_from_partial_node(). Since __slab_free() takes
> n->list_lock when it is about to make the slab fully free, and
> get_from_partial_node() also takes the same lock, the two paths should be
> mutually excluded by the lock and thus safe.
> 
> However, I'm wondering if there could be another race window. Suppose CPU0's
> get_from_partial_node() has already finished __slab_update_freelist(), but has
> not yet reached remove_partial(). In that gap, another CPU1 could free an object
> to the same slab via __slab_free(). CPU1 would observe was_full == 1 (due to the
> previous get_from_partial_node()->__slab_update_freelist() on CPU0), and then
>
> __slab_free() will call put_cpu_partial(s, slab, 1) without holding
> n->list_lock, trying to add this slab to the CPU partial list.

If CPU1 observes was_full == 1, it should spin on n->list_lock and wait
for CPU0 to release the lock. And CPU0 will remove the slab from the
partial list before releasing the lock. Or am I missing something?

> In that case,
> both paths would operate on the same union field in struct slab, which might
> lead to list corruption.

Not sure how the scenario you describe could happen:

CPU 0					CPU1
- get_from_partial_node()		
  -> spin_lock(&n->list_lock)		
					- __slab_free()
  -> __slab_update_freelist(),
     slab becomes full
					-> was_full == 1
					-> spin_lock(&n->list_lock)
					// starts spining
  -> if (!new.freelist)
  ->   remove_partial()
  -> spin_unlock()
					-> spin_lock(&n->list_lock)
					   // acquired!
					-> slab_update_freelist()
					-> spin_unlock(&n->list_lock)

-- 
Cheers,
Harry / Hyeonggon
