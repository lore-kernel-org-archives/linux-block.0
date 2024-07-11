Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13015150992
	for <linux-block@vger.kernel.org>; Thu, 11 Jul 2024 08:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720686261; cv=fail; b=DAcjdhLB7zdwJGMfaR4BCyc2bU9Gduy97e4H/ISW1ps0l3e4higbAZ7chpe3pYqTBdc7asf+6YojJ48eORnlYAABjfoBeefmnzxrmiBbBl2pqJZE1+1/6glQDrUMx1P1dI//+asQ8yE7+Evv2Ype0ld9Gskr8Z2niAYnP4CTJjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720686261; c=relaxed/simple;
	bh=tRlh2GaW0xmZsR+/NGXxMCdO38vsSONYJnH+PQjIy1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FG0z45cuYequSuPc5BN9WiMEu3YCyHJPODMkF+XobxcMOsR0HvgDX1IoPfdrZDkykkOIubUqAJ59TQHBF7IvNTGkk8XCDhGVcg9hojORpzkiX4KTD4hGejsip8Wb8bESEsY6+Jtk2Jf1DNzg3WLSmDy29pvkFNXve2oQivKn4lY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EP8T0hn0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WWOWZ/Cu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EP8T0hn0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WWOWZ/Cu"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46B7tY3M006699;
	Thu, 11 Jul 2024 08:24:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=5pKuWepva3ECrNRNIFO+HeL54rfBMnwtvr71lcFJzHk=; b=
	EP8T0hn0JrpC6zyHDwy4rVCaaIpNxFbzF7pmHyWqx6+TkwV8dWsvjnzsOfoLwgj0
	/3F3LZE1SGz+au+dR1e9n4RbR+YZ/jcC6RkmSZpkgliXaBvGcOf8m+lxv/WXXNmX
	1iJ8uiscwqHQv2Q7VZcOnQ7AnuIwfOXQhLXscg58N0r0ClWjXJ/nymFT29cNwhRp
	1MGXKkr4rJhg/cpRSeK1Qb/FhLIeeAM3EUo41ozVnzdVl4sdmutpTYC7pjS7u9CS
	oc3nAheauIHgAsvaVjAp9C9OsF6So34o0gRHNboFcRLh4HOb67cotdEPGTPTKluf
	395r9MFK0Laz7idDWE1Ftw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wgq13r2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 08:24:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46B7OqKx010950;
	Thu, 11 Jul 2024 08:24:14 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 409vv5e5bb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jul 2024 08:24:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OHGOFCw3y+TnduMWeQaPqfz5pQEXHQLv4+BMJypxtWTwd/vYiA1ooL2Izap/StOu3+eorUxB2TIElCMNS86eMxp5+jtK1c64PT66mljdUlTZO7xgIz1AYt6jod6dT7b/RQ0d0e878w7xP6+Iwad5qcVeuimz12WZHdWJKgMFC6EHs0tkhK/jbYuvSju83uzuiaRcf5W+JNwVk4BwkvIg2CBcqipw93iarwMX2T84rjrgJxjpjaoVE1bIDikKZ9xwsmvMAjY8RRiN6As4sFnTxh0Ex7lCJVeTQ6mH1SUScE18IXv08ztOtHWxUr6xfdQ4XOTwdFEGPtJ67YtaPYr6Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pKuWepva3ECrNRNIFO+HeL54rfBMnwtvr71lcFJzHk=;
 b=hRELAxL2i19vUZO+YfL8d/gSNFW80oNY8djo5IlHrVVcNLVIoUW67VuaCOWH7Wrg59aaSbFh68JETXmcrk/FhGihXmx3aUvWWm6L6DYBjuz5Q7y90j1OUyJAzBG14h4EivFgd6I4EQLtR/5mQTVyJ6Un/8zc9mOUfD+5NlZmGeQmtJ+if5V8XZlQ4CXzAiavbB2Ne+I078RlCd+hWbcfCxMzVa4DvqKXUxsS+ohk9k//UYNORrAkspzbOS3aznUueYctgC1dsax4MZ4fEP9EYH6VWc4kQchiqav6sAyx+9MysjfcZ0rXyKHnueJcDRwH+xRl7Iry5htghjVMVjNS3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pKuWepva3ECrNRNIFO+HeL54rfBMnwtvr71lcFJzHk=;
 b=WWOWZ/CuaLaW2INTOQcKPE8IccVyrQJ0VE0ROeukBnKEzrBw8Xwe95Z1VUnLYZQk4EM/pvemgQdtp6Rj09KQQsMhuNmLvax1nZ0evfmL0/HDZQFp+oc5oJSRzLHGrAN3BipD2uSqVRn5vKbfJqNGxWOV3FuCKCDUUHU9aW/ttKg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH8PR10MB6672.namprd10.prod.outlook.com (2603:10b6:510:216::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Thu, 11 Jul
 2024 08:24:11 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.016; Thu, 11 Jul 2024
 08:24:11 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 09/12] block: Use enum to define RQF_x bit indexes
Date: Thu, 11 Jul 2024 08:23:36 +0000
Message-Id: <20240711082339.1155658-10-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240711082339.1155658-1-john.g.garry@oracle.com>
References: <20240711082339.1155658-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0042.namprd11.prod.outlook.com
 (2603:10b6:a03:80::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH8PR10MB6672:EE_
X-MS-Office365-Filtering-Correlation-Id: 3382d89a-df3a-4081-11ae-08dca182d7b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?1a4yJBNg9S2K/985n08vp+6bbZTY9HviU1rQn2Nq+/7IUax7Y0QxlO2v9h6l?=
 =?us-ascii?Q?khycOj+HFWKBZm0856uKqWoaMTFJhMXKlYO+sOmU4tB5ryV/fIEAqV0+lpyO?=
 =?us-ascii?Q?Mb0u/XYGusPLUdRWUxnFEbNdlepaYQXE9eIjTIzX9+f8R7loUhX3ak6Dij1X?=
 =?us-ascii?Q?z63qpzcKIB3zGc9j9nehes8MTVCtlPOiuCAzM0+QJbV0xY1z2Gyiml/cjOGs?=
 =?us-ascii?Q?z2zDDKlhL+5e8MPkqeYzFuEQYgbAfGlt+2FU/BYhEgNEOMX8AsI9oTG8ghgz?=
 =?us-ascii?Q?PFCc2y93iLiKctqjUE0vf7CX2tLl72WcdTCLTB8D/xJsdYsAymg/xtSKXD9U?=
 =?us-ascii?Q?/3xA4ucPsa3y0Ry/LiwIOWItoplMVWj14036XtniWzIZKFq/c3Q0xKXn8zAT?=
 =?us-ascii?Q?q0N+O8l6TVWKJM/55gbFF7k3d44IDQZSzbZYO8M8vArMnoEBzigtwueDimp/?=
 =?us-ascii?Q?AaGnvK/koAp96TfDRY599IL5R7vQ3TRLPpcAZbozaRqEUCZHMlBX6XY+sJu9?=
 =?us-ascii?Q?f6kTniPGMMyzMTVhNWvWMtYyEW9om7JPILuXFdW7Cfxzt2pCzqE2573hLCH6?=
 =?us-ascii?Q?FvYV+vxRL0dKhkcOSqVEVk81yqdBUSp8BcAoPi6IAPifVK93bBmTSZIxrGDa?=
 =?us-ascii?Q?OtQkuzKQLjji50gdtfsYJG/cxe1qsDYVvcvDS8NBMJhwEbOH3X/xIZvgyoW1?=
 =?us-ascii?Q?rgQsdveQDrkB5sAQ9g9dbDkEVKJtbhBAd59mf8u6wkA5vcrCgasMcsQBb009?=
 =?us-ascii?Q?C577Xb/M0lVzoUzIRArkFuHxilsQJJcERAWsC3tLh3mK1IFJXcTA4Si7n0h+?=
 =?us-ascii?Q?6OzWDfnqukN1Pf3E6iqPeLH/Nae9MQm19MqUOn2OTp48+MMlsqXXkcmPmJC0?=
 =?us-ascii?Q?Dngf7rjeIeugG6W4wwU05ExvpZyMR1BPDCgqIXdzxhVzuVqygAw+5wXb1+Nw?=
 =?us-ascii?Q?brtJY/n9brwkLRxgIaOVplS2s6ZvjSAOgUow09bnm1MQXiWmAR1IyydHDHKF?=
 =?us-ascii?Q?FnlAW/WSbNkTgXwDOYHGtJBcikR5cpB2igh1U/PI3WsKbqbokvz8eaqCe9vE?=
 =?us-ascii?Q?qFPbgAL9UcA1/ZHwX/+D4gA5vp1520y9Cd/LbJecJ/6FJLA3ZTqC7jswD58O?=
 =?us-ascii?Q?4EDxAefRtyUpN5pjRwsy6YUslcWdYUIctDsvtK9CcrN3txPLNZZ+LggL6Bl7?=
 =?us-ascii?Q?iW0GKQ85+cHfeqOz5z35HqNNu8CG7fh41JzZfVvdsOnZddvx5AjETt34yxbR?=
 =?us-ascii?Q?mwcC0gkI2kQYl776Y+wsZpOeJhteLeqHQuXDl4dkix1GyyZ6FxB29k/9ha6M?=
 =?us-ascii?Q?BqHxTNSOvgncwStgMxjz8cDKZntBJGY/R06q5F8Uc0/wzg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?J/B72VqQY6OfjJ5bFi1q7FY4lz32plGHq2ISSkL8ZtR8VziHinhAXVtJosKb?=
 =?us-ascii?Q?xdDITmsg+LY0DEtN2va1spoaaTZ/2Gy8xd/9QyMU600acvvaJwBS462LBl1+?=
 =?us-ascii?Q?B0872Qxq8JHKoWvjI5g79JVh5MErXnKioY7/IDthlpuBkUsYaYVq22HRldNs?=
 =?us-ascii?Q?a5VWrHwUvlGGucgl7HkN4BgpZkyUtcuKMGmvirsUDuIiPrxGxm6YQiA0xJxd?=
 =?us-ascii?Q?xWe4yQzMyoT5CueDt4FX9NyfnKCqz9fKFOzf9Z+if1L5JM+9hdq8ooz6Q0Uk?=
 =?us-ascii?Q?uFcJTIx6DT94gUy5RoyaSyB7xeERAGGL9HD93IHma5kZX7bdJb0twH7/0g1c?=
 =?us-ascii?Q?4pqfXbHOhDZpBq8tRmXjYPls1+i7+YvEvNerAI95NL3Xz1z4+0/nzJkE9aPB?=
 =?us-ascii?Q?jbihVOxlkgnZ2kyHZZUn4BTJI0ov7WtKC631Bn0L/THffqKaWY8zciCVZbfM?=
 =?us-ascii?Q?9I+Fr9BSGuZR1+6GeaeHDZBo+EntwBZDNfvkV0kJuiRV9F030QcTJ6P1HOtP?=
 =?us-ascii?Q?tOr/AYyjJ6QooVviBGLoDMVReUudAhg2JkEYEdChqZzVTfzBbwtVMCNhs5jb?=
 =?us-ascii?Q?/sD9j6RgCdNy1Ww7K5lgpSopopa/P+wLeKuLZd8J+ZbPMueh07S0DjulVtQO?=
 =?us-ascii?Q?YTq07WgTjFF57kq4tVR0WoL6BjnQRwYRnnaJKw00lMdgR3lOpKI2A9eTm8lH?=
 =?us-ascii?Q?R8uvVhCnfTNJrjz+SO3JyhaMYS12MoKB1nDiIyt46Vzeg0leZJOwmSHeaSXM?=
 =?us-ascii?Q?eoG9jqQONdne+FD8QCXmHzieBzr2lM+CTbl02xD5CtZlKVcugj2qh+bGsxKn?=
 =?us-ascii?Q?3ks1W9lIDrO3VrQiWLF0IlC7wEfCMtdjsy1n0A/G2zcXXRq3XYx6+Zc3jDrz?=
 =?us-ascii?Q?dvDL11XBBrwD94ATY0r9hF4xLC3aCHAZyXID4deq+Dgs8cOwn1KoRESgCvoN?=
 =?us-ascii?Q?RNbss8/I84+0lSiO5UutNey3H4EKQMB5ZDVKhWe+De9WEeC/su9WxaB9hkNx?=
 =?us-ascii?Q?WO5tFxACyDvakCFdjWEPeMV9tlSOb+l7oD/LyUydaNO84YAHUXdvtCPs8+0c?=
 =?us-ascii?Q?e1l1k5rt7Z/VKnVO8RDJaJSX705LCY+agtaPaGMJwUaMmx9fuj6IfX2EvQXg?=
 =?us-ascii?Q?RXr1YEXw2pi7hkpjlSdViVZ/UonX6C+rbw/RI1ng6/NfCWyHmMkeS91PnQJu?=
 =?us-ascii?Q?HjqbAzZbwhcmzQHVZRm69IdCf7zLAId5v773z+HV3NJDrHD2Vv7l4BaS3EYC?=
 =?us-ascii?Q?6pU5cn6DtikAjJqczlf9G7WGvNJsW3jeT+opmAa8AOutfIJCveS6NfJBNvus?=
 =?us-ascii?Q?cyVgOaOoNEuxWq4a7oLGwznRNeycH1UxKZK1iCYh1PM24yGVJvFDLKTkbyzQ?=
 =?us-ascii?Q?eRFvpbeOkiuevslD1WDsSlc4auXZmThlJf+fdwp7PUO5By9Smhaq3ot+Nrld?=
 =?us-ascii?Q?xDkmagetchOn5xYX40mjSmeI82NgvAAhSuZ0cD2gsNElFz5OqtTgudmBlzor?=
 =?us-ascii?Q?e1RH2HkDPc3xdULa08jvWSHptgnTw7Q2OqCRMno30nGEpXgFr+DoWj/hjoYX?=
 =?us-ascii?Q?emTIg97n7PVJ0n56kBjjBLYd8vYtEdmAhgJiqotJFxPxVpc69XCQ3z3CclGm?=
 =?us-ascii?Q?bA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jPAb4aYuRfkUr05Oq+/s7E24vDeOEZKR6dbTf+cQK4Ga7wvxstTcIgpVMmQkM55YEGSKnD2CKkq+aNqK7eZT7F+Phe1oP5TyOtThPbU4tody76jjl9y+2TkGRIOVlsRU+wPkLMkGFDaG+yC6290DdgHQeHJKvJttwV1/Q3zYrxOH0erO6k2dcW17lfMnFKwApxzRsKlvQBhUR6o1lzFgP09WV0Ie/YdC/oOwn8q1HvCAUf9NGTz3nMBGkYlQzmMZU5gXltwcQgnJsGRGjEgUZk6nVMnwssaeCZW0qLNBi1gz0kFnyehb0I+xEb8uu7RhqQ5t8dyeNdd3FcmiGNRokupFiOd8CVQnDGUU5f1WRxR3EDQ6t0kYQmq4OOllPYvwO1AWaKG1nfN/wtJckqs0dwjC7R12lrDzHgaUuoK0hWG2ujGIkfK5Hif2hxj/ntNDR6EL1TeIDuySDTT52WF8XgT+J8nGi5ayXA1/pX2FM8MMhS7Xf1AnsI0fNqYjYcQ4TNbsg0C7MxkPCNeR4hdp9rFNUNBJfcH+BVsJR74hVXWtbaFxISdTLAmJDSgUXt/0jSLkeZ2yL/Xn0AiQJvWGJ9ZVgvy+6Yz8gty6ISq2qnk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3382d89a-df3a-4081-11ae-08dca182d7b2
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2024 08:24:11.7421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zkONXjfJsoq+cU95aerP5d/ueawQZyrg1d5mzuglUU+xEo8N+oQ1K11eSWR1K1Hqsph0/9VUR9zm9zwQ5eiUrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6672
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-11_04,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407110058
X-Proofpoint-ORIG-GUID: oKjVTsY053HLBKVQV9ROphqDaH211zRg
X-Proofpoint-GUID: oKjVTsY053HLBKVQV9ROphqDaH211zRg

Similar to what we do for enum req_flag_bits, divide the definition of
RQF_x flags into an enum to declare the bits and an actual flag.

Tweak some comments to not spill onto new lines.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 include/linux/blk-mq.h | 86 ++++++++++++++++++++++++++----------------
 1 file changed, 54 insertions(+), 32 deletions(-)

diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 454008397e64..4b300f902d8f 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -27,38 +27,60 @@ typedef enum rq_end_io_ret (rq_end_io_fn)(struct request *, blk_status_t);
  * request flags */
 typedef __u32 __bitwise req_flags_t;
 
-/* drive already may have started this one */
-#define RQF_STARTED		((__force req_flags_t)(1 << 1))
-/* request for flush sequence */
-#define RQF_FLUSH_SEQ		((__force req_flags_t)(1 << 4))
-/* merge of different types, fail separately */
-#define RQF_MIXED_MERGE		((__force req_flags_t)(1 << 5))
-/* don't call prep for this one */
-#define RQF_DONTPREP		((__force req_flags_t)(1 << 7))
-/* use hctx->sched_tags */
-#define RQF_SCHED_TAGS		((__force req_flags_t)(1 << 8))
-/* use an I/O scheduler for this request */
-#define RQF_USE_SCHED		((__force req_flags_t)(1 << 9))
-/* vaguely specified driver internal error.  Ignored by the block layer */
-#define RQF_FAILED		((__force req_flags_t)(1 << 10))
-/* don't warn about errors */
-#define RQF_QUIET		((__force req_flags_t)(1 << 11))
-/* account into disk and partition IO statistics */
-#define RQF_IO_STAT		((__force req_flags_t)(1 << 13))
-/* runtime pm request */
-#define RQF_PM			((__force req_flags_t)(1 << 15))
-/* on IO scheduler merge hash */
-#define RQF_HASHED		((__force req_flags_t)(1 << 16))
-/* track IO completion time */
-#define RQF_STATS		((__force req_flags_t)(1 << 17))
-/* Look at ->special_vec for the actual data payload instead of the
-   bio chain. */
-#define RQF_SPECIAL_PAYLOAD	((__force req_flags_t)(1 << 18))
-/* The request completion needs to be signaled to zone write pluging. */
-#define RQF_ZONE_WRITE_PLUGGING	((__force req_flags_t)(1 << 20))
-/* ->timeout has been called, don't expire again */
-#define RQF_TIMED_OUT		((__force req_flags_t)(1 << 21))
-#define RQF_RESV		((__force req_flags_t)(1 << 23))
+enum {
+	/* drive already may have started this one */
+	__RQF_STARTED		=	0,
+	/* request for flush sequence */
+	__RQF_FLUSH_SEQ,
+	/* merge of different types, fail separately */
+	__RQF_MIXED_MERGE,
+	/* don't call prep for this one */
+	__RQF_DONTPREP,
+	/* use hctx->sched_tags */
+	__RQF_SCHED_TAGS,
+	/* use an I/O scheduler for this request */
+	__RQF_USE_SCHED,
+	/* vaguely specified driver internal error.  Ignored by block layer */
+	__RQF_FAILED,
+	/* don't warn about errors */
+	__RQF_QUIET,
+	/* account into disk and partition IO statistics */
+	__RQF_IO_STAT,
+	/* runtime pm request */
+	__RQF_PM,
+	/* on IO scheduler merge hash */
+	__RQF_HASHED,
+	/* track IO completion time */
+	__RQF_STATS,
+	/* Look at ->special_vec for the actual data payload instead of the
+	   bio chain. */
+	__RQF_SPECIAL_PAYLOAD,
+	/* request completion needs to be signaled to zone write plugging. */
+	__RQF_ZONE_WRITE_PLUGGING,
+	/* ->timeout has been called, don't expire again */
+	__RQF_TIMED_OUT,
+	__RQF_RESV,
+	__RQF_BITS
+};
+
+#define RQF_STARTED		((__force req_flags_t)(1 << __RQF_STARTED))
+#define RQF_FLUSH_SEQ		((__force req_flags_t)(1 << __RQF_FLUSH_SEQ))
+#define RQF_MIXED_MERGE		((__force req_flags_t)(1 << __RQF_MIXED_MERGE))
+#define RQF_DONTPREP		((__force req_flags_t)(1 << __RQF_DONTPREP))
+#define RQF_SCHED_TAGS		((__force req_flags_t)(1 << __RQF_SCHED_TAGS))
+#define RQF_USE_SCHED		((__force req_flags_t)(1 << __RQF_USE_SCHED))
+#define RQF_FAILED		((__force req_flags_t)(1 << __RQF_FAILED))
+#define RQF_QUIET		((__force req_flags_t)(1 << __RQF_QUIET))
+#define RQF_IO_STAT		((__force req_flags_t)(1 << __RQF_IO_STAT))
+#define RQF_PM			((__force req_flags_t)(1 << __RQF_PM))
+#define RQF_HASHED		((__force req_flags_t)(1 << __RQF_HASHED))
+#define RQF_STATS		((__force req_flags_t)(1 << __RQF_STATS))
+#define RQF_SPECIAL_PAYLOAD	\
+			((__force req_flags_t)(1 << __RQF_SPECIAL_PAYLOAD))
+#define RQF_ZONE_WRITE_PLUGGING	\
+			((__force req_flags_t)(1 << __RQF_ZONE_WRITE_PLUGGING))
+#define RQF_TIMED_OUT		((__force req_flags_t)(1 << __RQF_TIMED_OUT))
+#define RQF_RESV		((__force req_flags_t)(1 << __RQF_RESV))
 
 /* flags that prevent us from merging requests: */
 #define RQF_NOMERGE_FLAGS \
-- 
2.31.1

