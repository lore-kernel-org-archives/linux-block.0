Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF6454758
	for <linux-block@vger.kernel.org>; Mon, 22 Sep 2025 10:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758536702; cv=fail; b=hJrKtnGy8MZW6en5/DN2vgHb5PPMag0zHpevhGzMUQrSsyLTgHj2W3lIY6GXp/0Cy7dPOndFN3v7C3T7VJEZx9UdBsnzGCSlr7+1OEv0Hs7LmNVWHap/aP/rZCHULHAwyNrtUbDa+HnY+GyHW5r62wPVX5i4xWK7YMrV7IrNTBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758536702; c=relaxed/simple;
	bh=vYNR+enU6qx40mDtQ1UVJLK5zZOV+NVE1cAFRsP+JUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=j8bYihwHUb8qMBrlFReACLUM54b1POHMv5112YuZq9b6FK4BLVe2n9iHVI+8FiMOyknFymgkVun2LkI0sHmzQ4QpPkiLB7YiTwKNSkDfGFb/cnXnZjE8fOkw5X+WwWLe9yOL6GTGXJ/ao3kPkZgwO2SKlxTs+E3zpbQWwkdz1GY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xs/3cN3o; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wlwoPSDK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xs/3cN3o";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wlwoPSDK"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58M7NPto006558;
	Mon, 22 Sep 2025 10:24:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=QCWGl7mnnfh3vfca/JVxdusBTVK/tkddmetfiukdxtI=; b=
	Xs/3cN3oNbinGKeTixA/22UmNrQzQIgncvftvG0mpgoVE4GaCPLkw9XoA/lqlcHv
	bNdMmMTY9EUxqSBV7XXf4VHZP1FA6pOa7uP7sWvpQr/HQ9Dyvnl2EE9xZtbLwQwm
	nxJjOp+zx5y7NmIn8+ERJwOED0X7fyLZv/oIPbbm0nuETlSv9N1bbgu0RpZD3Mba
	94wTRsJsCiFl1PaMWtIQrVGNHNTHp2sST++zE2T1EQCJP7JUrF4DWkRLElOOAwsT
	0sjPK6FhSE9bsIMvSLaYuoZf/jBCKENVhI8IK0HM+SFTr2kv/ntify9ImLtBt2yE
	N8Tw+9UGXt8wsZaAPnw71Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499kvtt419-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 10:24:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58M8HAVj026008;
	Mon, 22 Sep 2025 10:24:58 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010040.outbound.protection.outlook.com [40.93.198.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 499jq6upnk-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 10:24:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O4caKMxPp+FDlLmVncsHlMnWbeGecNbTyJwnWiPIG7in0DGJdm5krND+sJTZhR5Z95gxUcl7p+cO0yfBY/5cmviRNAtoW7X5emLYe+PW0F3ipYYGaKubqnbihSEq+NCguYBRisFj1NEYn0bAByrQBaYf138fWjPeVYyubu6eagOc2gsUCZGvi9E2WPjeUCN5rbF0Dxv4hQH4axGLbFm7p82IH1KujX1F0PidFqcZwp00UeGpIB1Z2WY0KhKkqbkmpTIuYcyEo6T5fxPZnGFJSjVZQ7EJSLXwLcLFZzZIdgmJtM0KnMuNHZxfSnuvGXI4dRhSk2NBlYVPYrq3WzNUSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCWGl7mnnfh3vfca/JVxdusBTVK/tkddmetfiukdxtI=;
 b=hrWihbYbJrjqpUJ7oUgPd5jLfE2C3kMtRgVMa7ep/6pCfCFiBEPzAAHxbXntzIcfGZUu6SH1/cylhXK98mxCdVUPsI9+qzgQv8Pr2GilQccn5NmdDODOlR1S8bS3IRzMyNYdZa2Vsyw2/yIcKyKTyBAodoA/+Rh2yCJeifRe8YuJpfViaewwsCGGhgwqsykUx3MWpbJIgVTeSI65rWKD7+uSWq3HREaWXdv5sOxOqXnwrnaVuA5/xK2L4hDBCRpAuwMTaGL6GKaHZjT5ta8AlXFHepct8CUnW6O3xNbIilEMiU/BF9kUd/wjFBWOdWcReUjJ6AB+mAP8xEXNEAgKog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCWGl7mnnfh3vfca/JVxdusBTVK/tkddmetfiukdxtI=;
 b=wlwoPSDKa1p+iuLYXSHaXWJJenkqzY7YPDGb12dloU7soQOZftd5T8UA/mq1bw7npYqLS6U1hSiCJBKl0mROiLGSCyXQwtKmRuqtRpXc2Fwr6XDk+va5YdhgSpT/zonnSx0W2vQwudOuE6jtE9uxz8oAbJAE/bOLr9lT1S60VG4=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CH2PR10MB4293.namprd10.prod.outlook.com (2603:10b6:610:7f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 10:24:56 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9137.012; Mon, 22 Sep 2025
 10:24:56 +0000
From: John Garry <john.g.garry@oracle.com>
To: linux-block@vger.kernel.org, shinichiro.kawasaki@wdc.com
Cc: John Garry <john.g.garry@oracle.com>
Subject: [PATCH blktests v2 7/9] md/rc: test atomic writes for dm-linear
Date: Mon, 22 Sep 2025 10:24:31 +0000
Message-ID: <20250922102433.1586402-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250922102433.1586402-1-john.g.garry@oracle.com>
References: <20250922102433.1586402-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH0PR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:510:5::24) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CH2PR10MB4293:EE_
X-MS-Office365-Filtering-Correlation-Id: dae1e6b6-c646-4f6b-b13e-08ddf9c246cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Hk9GqV0fKkjjFQjivrIMlMXMLQGTkpLnxgRjhrYT6PMw5iSUU/G0mStkOjI?=
 =?us-ascii?Q?EM2mwjE1rcplVYc/UmTyqGZ3O9Wlvm89Dd/bJ1yrddpvN5MalQO6vP7EDb03?=
 =?us-ascii?Q?o8GkQ6NXwEgu8LOnExKBWZ0gFJZKVFORwMhCu+dtbD3Ofrso43QgY3bnSbgH?=
 =?us-ascii?Q?QY1BzRdtYwBabI+7U2x5tosycgwz+xjXzoaQWBsAE8xsJc6VByZzDS7Nt4YZ?=
 =?us-ascii?Q?JrKbaTaArrF6jVYO7OYycHD47/Fdhr0sHebhDBzbP8ZVgmHdAe0eFESgqPMl?=
 =?us-ascii?Q?kV/elz6uPB8xv7ufC2aZFe+Ymy2Ark/0aumg/woADvWQEj8ipnFGYJHrju7W?=
 =?us-ascii?Q?y2Jn/4vG3tajQU76hkfdH506dPSbLnrq1BY//5jjf6mnBHOitcRiMqht4Lu7?=
 =?us-ascii?Q?R7lYBsoIUZkVCHsHG1r4v4VtxACqY3Y9Gt65TN7X/gqnrY7bFXwrfUjtmFMS?=
 =?us-ascii?Q?CsipHG+2BiCmdq1BbJnFDXEmX13vrVOHkbdk7bPx78benn5pYwP2Siqgfvtu?=
 =?us-ascii?Q?EoEvl1ONsU+vGaBgZuAg4vjYh6vsQjc9CV3xSOXYgclsBXPDBhiZlTtDT7ry?=
 =?us-ascii?Q?n4lTTcviYjrbCdMAeRdxgHhDy5QxpTe3+yK9aOM+Zkig+cal98ruMEnSn7vX?=
 =?us-ascii?Q?OX6cwyX4XzF/NjMRBdBu/vniefWVyEkaayfFlidTVpJ4cb1NSTZ8iBPaddl/?=
 =?us-ascii?Q?BiS/0XdtfabY+eKo/5eo1RJR6wsrB7zz/fZgM88CI1SfkLhSNjZEHOHWZofL?=
 =?us-ascii?Q?LG+986cl5fJpMAM4IPHYNPNwpigs/UGYHu7J3qsTsnsxYMktARs46nX8nKk5?=
 =?us-ascii?Q?Sf+dHAms81DWrvr7oTVf2wXQUI/P+2CbjE5dlL1ATK+QDP9++HzY0b/FIvOL?=
 =?us-ascii?Q?CLXkk5SV26PizMzZcNbPwNtlzDZxrdgzQbVyPm1HvHUV+V70JM1B1Rc2nREV?=
 =?us-ascii?Q?+gKlKAfSbgtvVPrNzA4+WGu73pqLGJM6E+ntG/uFDuYfWkWaXl6REW2M0a0D?=
 =?us-ascii?Q?kKvRpjlkfU58mtzVkW3mVW6y7aLrSJ8vwfFI3CFf0iBonthu7tsOX3iBeXDo?=
 =?us-ascii?Q?zyzCN8zaH3wavDBtmLh2NWy7khST+k2w4UCS/4dKmYnsKIsLzJn8MI0P4G4p?=
 =?us-ascii?Q?Ukb/nuH/Hg/S4wZ8KpzHkGdjJWIDFlclvC1KD6AJKkPRMAkWarJy2tgfkKBQ?=
 =?us-ascii?Q?DMwh4pGZ346+8JqI46lqoc1dahicQfVujKXNmMsgprcasq5mI0u9AbSUQuRN?=
 =?us-ascii?Q?BY2YXEG/v9YuK/pU/iBiSzwrh0HdMPtskbJrsQfrADHdK/PvkVMdXZo4tkKm?=
 =?us-ascii?Q?qcMQ2ntPBFCu/DxcQPJHRo4t08prdyeeBh3KhK/p/DR2+2Glclh5aa8K8wcm?=
 =?us-ascii?Q?yPzp13vjuOQ7m2KhBWWSvGPYqG4gq1sJ79av02BqwdUTg7IgHnb/6rFE0e4d?=
 =?us-ascii?Q?ETm2WFFjfgk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ppDwXjY+rXwUWL6Kyhso6C3Vg5E42Nf1YxJiuCEgBDSe/3TDuWLDZvzRJXPX?=
 =?us-ascii?Q?IuBoFPqlrdKwX5uo5r3LY1muomgrTyrTjUrTljkcAlDBNuYuyIV/jggW3ygq?=
 =?us-ascii?Q?yj6uzb1VDnU6213/Dq1WmNnKVMudJMlJkxMFVwaQT/Q1zkZ9vaG6nM4NcjJF?=
 =?us-ascii?Q?ZXce663W8ITEhlEgFQJquFih56tmy3+AG7DLzbAqtT9IPkj/RDl5rKqGjy1d?=
 =?us-ascii?Q?ZRHKwLqkpVRv/nwnEpiNwdNtqo2gRoEZCshUQ80gcFibcxmd9skS8R6AxL0f?=
 =?us-ascii?Q?qM942k0TMETpixxeY7KMkd9TukYvxS4ohEgQnVCuo+b5KkF1nRUjerOXI+8h?=
 =?us-ascii?Q?TJJ55ilof6z7w1CfYsbLhKFKOZ2luMHS6YSOMzme+ByRspilVxXX5aBJqFpy?=
 =?us-ascii?Q?y+zFYVcyORLiYNX7FFByfXdwnUh48r9SReCp2z2/Rc5ur6lOxNhViv+2LytR?=
 =?us-ascii?Q?LoIYzK0Lp7QzOuXugtgAqeJ5jLBL1uQ/IgXkpYs+9aKEPdnE1ewXntmg+85O?=
 =?us-ascii?Q?PBtDtVyZf5fAhnxGPe5YzmrpOA0N00TW4iLUNptMv6YYBopLRLHxiLE0c+HJ?=
 =?us-ascii?Q?j8LCSG9FwsNCubdVBxphWhIUTg0DnxRdwjZo2abmrfZXpSb6pCDsE098apX+?=
 =?us-ascii?Q?tjhWUOS2qVyW7duh3mgWsWpUblHsjtYqEKw+gOYrMXrqlWs9IxoQ+ZA16AcV?=
 =?us-ascii?Q?JMJLCSVDKmHeJS7CyfId0khAqEQSfAKVX/oQ8l0bOB7QPvq3+Ip0WBb7NBs6?=
 =?us-ascii?Q?llpvRPsTogJVl9BgeJvC5dNM3wGN7phqN89zOKb6AoV8u88tVIKmdzDcI4Rv?=
 =?us-ascii?Q?GvXxwIXIqFGN5+t5F4/uNpk07F31G86gyvWI1zXwelbJfPbSPw3PZyvVnKkO?=
 =?us-ascii?Q?qA9U5l4SatFXBZgfb2RP2r3QkLtAl51+/UduUdHwTJw0aQ3I0kvSz6hr2nlW?=
 =?us-ascii?Q?bsrPhncz73L4cAenGDOVH/Qj8ga9R5o0gChwfrApFLHBxGUfh+jCrbymrgv8?=
 =?us-ascii?Q?A/E5MZ2u+xENisU0PhKUOmUM3gp2u5zOpU4TqbdO29hx0kXeIdi7Z8kieKif?=
 =?us-ascii?Q?lVWDwr9xAgnQj8iudLi/pxOCX17G9oTGdqIHzBRvEmCdBZtmXK5LXJci56Xl?=
 =?us-ascii?Q?D0vMIHMMtQwWB8niaiqmu8DJvVBc3d05wFFnbtePrWO/QOdhbp1v6YADmebF?=
 =?us-ascii?Q?asvzl0hrEArpsrQ6mrdJVlKbQDNKUYxmKdQ+ohZpj57E4psgtVGUOE9N7fL8?=
 =?us-ascii?Q?hRTpxp/PXESIZc8BCq4HmUM2w1A7tIOSplTERjP+4ibnhOtqeeTgErWUhTMr?=
 =?us-ascii?Q?3pIbgwpC8Ftec17Okzze+fsP3iFEvFm7AxTxzqpENYGYOXpks3Q8uszZUwE3?=
 =?us-ascii?Q?p/Xl7BGLqi3KoZFiSBr09i/NnlHXt9i1b+2wvTl5gdH+TQkvbdXk/gw7kV90?=
 =?us-ascii?Q?dB7nRbfimFd97/l90q0/W1x1ZRySJ/vJ+KiwOt0Bl/2Azm4JP7m8fMNPv/zj?=
 =?us-ascii?Q?lV7aZEO5BgGatl5mbrwwhUdsOl22w59i326QUql2SUSXDtvGYKz4UzGRKbhj?=
 =?us-ascii?Q?QCxUqR452sRZFc7UREo6PA8d4I0Ic+1AkYJfM+JJKjXZpj1N8prXEcum3VKA?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EeqNAbU4OvZ+XH19qaYyNv9fVWC4HqYIHStSuFPqQTSqqv+4r+r/M4Cdf6zzx2S/CXxn4nq5DHDn5poPwUfNTweitdV9CJCJWkxOdffcy9yEJ+Rm1PJRdkkzfFcghCQZz1MokI2WT0EB6WjXkUIKYgOOk3eGxI4TFcHWLmbcswjU8yoSgKV+hYl+955k8VyepCZ/kjRpD13jrDtAPi8vraOxA87C8Be1Ifz0plSpxC9RFfE70BKloWzHpMwBXuBCMVdCKS+4n1rs27r/SKQ7Z7Dm7/qrDkAmAzHZYmnEqp5mNMaVqt7x4iRhwhg3onXc5eKl8Ckc0zzGlfhmxmiI60mqKjrtT+OdMbwNoMfUt7wuaAlh+tbtc0JNqbaLTFdYQM1AXOn3tEl3bFL89B8gwc39Pjv4pdDB6se+5ZjwTh5eg7hT5Obb/c0z6a+QmBYQ2Kj0chYX/rnJ3Cvwu6y4wbC/HO0iQTAfNC6pTAxKtrfKUzrX1uzSpv9zcU+t0U7iVPRRvZSFweUmDmJkXAdE+FBucs9yLcafdK9KBn902b7th8IArWJ+qxebuWcKNN1+SDiowcPHVnAX6uw1q7juRUYxr9O5K4BACsu6gwpJ23A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dae1e6b6-c646-4f6b-b13e-08ddf9c246cf
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 10:24:56.5148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BSWASsQx/1TC97vTC5PpOaGk7EuBLERpXlCXIb6SCORGBNHaeOvidV/wrVc7lpEoMwEhj8Jxzef4/oD9qVRrBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4293
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 spamscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509220101
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyNSBTYWx0ZWRfX8xff+Dcu8vEC
 /QbJ8NUxr8opYAMF6qfKPZf6mSOa+z/N6EFld8WGa+/tBYVdR9135KnD2tnAKzRNrY2J72cvgrB
 9C7qk6qZjTLwAPo7RHFU018CLxctvmGlLFkFOB3sE48hSOdy0Iyx2FomKZ2fx41VyA0B8cBk3iH
 4EpmeWrEJR00juaMyhSZpG40CUFsLlbQq8S4wSNFJI74eZiZTzKInpwrt0Yo55Jsl751TKmjShG
 qU1+txAYjyo7AwDcS+yF2y0jRDAvA4faVK8fclBflOYDZRMe61BRA5fRo3FFcm4ViZseAc3jj4K
 LVFODvCchfeKTNRUoOV4WiUx1HQEKdB3oTHfDcPpP/KyasCiIavLzMa2THjS2yv9q6JTT/eirT3
 nm5XEBt9
X-Authority-Analysis: v=2.4 cv=UPPdHDfy c=1 sm=1 tr=0 ts=68d123fb cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=WlR-zH88GhaHN5wt96cA:9
X-Proofpoint-GUID: RxJuulr0pEF3dfnUY6LArDfIaTVLi7mI
X-Proofpoint-ORIG-GUID: RxJuulr0pEF3dfnUY6LArDfIaTVLi7mI

Introduce testing for dm-linear.

We need to use device mapper tools, like vgcreate and lvm.

dm-linear does not require any chunk size to be set, so only test
once.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 tests/md/002.out | 13 +++++++++++++
 tests/md/rc      | 41 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 53 insertions(+), 1 deletion(-)

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
index ee5934c..3209402 100644
--- a/tests/md/rc
+++ b/tests/md/rc
@@ -19,6 +19,9 @@ _stacked_atomic_test_requires() {
 	_have_driver raid0
 	_have_driver raid1
 	_have_driver raid10
+	_have_driver dm-mod
+	_have_program vgcreate
+	_have_program lvm
 }
 
 _max_pow_of_two_factor() {
@@ -85,6 +88,13 @@ _md_atomics_boundaries_max() {
 
 declare -A MD_DEVICES
 
+_get_vgsize() {
+	local vgsize
+
+	vgsize=$(vgdisplay --units b blktests_vg00 | grep 'VG Size' | tr -d -c 0-9)
+	echo "$vgsize"
+}
+
 _md_atomics_test() {
 	local md_sysfs_max_hw_sectors_kb
 	local md_sysfs_max_hw
@@ -147,7 +157,7 @@ _md_atomics_test() {
 		raw_atomic_write_boundary=0;
 	fi
 
-	for personality in raid0 raid1 raid10; do
+	for personality in raid0 raid1 raid10 dm-linear; do
 		local step_limit
 		if [ "$personality" = raid0 ] || [ "$personality" = raid10 ]
 		then
@@ -215,6 +225,26 @@ _md_atomics_test() {
 				md_dev=$(readlink /dev/md/blktests_md | sed 's|\.\./||')
 			fi
 
+			if [ "$personality" = dm-linear ]
+			then
+				for i in "${MD_DEVICES[@]}"; do
+					pvremove --force /dev/"$i" 2> /dev/null 1>&2
+					pvcreate /dev/"$i" 2> /dev/null 1>&2
+				done
+
+				echo y | vgcreate blktests_vg00 /dev/"${dev0}" /dev/"${dev1}" \
+						/dev/"${dev2}" /dev/"${dev3}" 2> /dev/null 1>&2
+			fi
+
+			if [ "$personality" = dm-linear ]
+			then
+				local vgsize
+
+				vgsize=$(_get_vgsize)
+				echo y | lvm lvcreate -v -n blktests_lv -L "${vgsize}"B blktests_vg00 2> /dev/null 1>&2
+				md_dev=$(readlink /dev/mapper/blktests_vg00-blktests_lv | sed 's|\.\./||')
+			fi
+
 			md_dev_sysfs="/sys/devices/virtual/block/${md_dev}"
 
 			sysfs_logical_block_size=$(< "${md_dev_sysfs}"/queue/logical_block_size)
@@ -385,6 +415,15 @@ _md_atomics_test() {
 					mdadm --zero-superblock /dev/"$i" 2> /dev/null 1>&2
 				done
 			fi
+
+			if [ "$personality" = dm-linear ]
+			then
+				lvremove --force  /dev/mapper/blktests_vg00-blktests_lv  2> /dev/null 1>&2
+				vgremove --force blktests_vg00 2> /dev/null 1>&2
+				for i in "${MD_DEVICES[@]}"; do
+					pvremove --force /dev/"$i" 2> /dev/null 1>&2
+				done
+			fi
 		done
 	done
 }
-- 
2.43.5

