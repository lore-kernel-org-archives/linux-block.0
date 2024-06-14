Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69826E5ED;
	Fri, 14 Jun 2024 09:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718355854; cv=fail; b=ctcaCK8skWVwgQfP8Xv1a2t6yyCDIgtVXDwmw3bMSOUTy5Vp1Wmd/QX0SKfXxJMwWwW3F/zyVErhtgRyOxwR9NULClglzft6h5z3LSHnMzlL2LIAvr7uSMFn6rskEGRDPaqoY3h1efUvM3pYK1iFf53KbXhJhu2iiVlnDDwOsEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718355854; c=relaxed/simple;
	bh=3PApisPb1y5fyD2vV7+p8lFnlHzE6/hFEpEPBBQUgd8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O5uvU2+BqSN8X9ZUIsOtxU7VDH2h9mkI0dMfuCbF9Bo3BwQ75+AENIL/kZSAGei/zcSa3SuzhSRNCU85E+xP0DkvJ9cU57pb7DEGIsCLFnu+Ff06WhLmEpmIDC2O4Mng0c8PRN+AWmHpxOFu0FfdTO9sfcIixkego4BZ49Igylo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Wm/KzpUJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QQ66QBi1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Wm/KzpUJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QQ66QBi1"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45E1fQla022828;
	Fri, 14 Jun 2024 09:04:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=h559c+Qu/VZRVT0432jz4DVyJDWOcQQaE5fCUcczRmY=; b=
	Wm/KzpUJDFzrFGUfvIdpmlcyJRHrbKoGaDYW0TKxfj/ZSlfGVzfuszZjbcNKq5qh
	PKsSBOrwzdveu1tNDZF/R6HpkUe3xhKsBOaQGWxDyNzpJmn2yMIQkuwkPyJeyCE5
	57SUH0fjQL+SXCeI0zMn/gZ9o0MU8iww8xDWEHwcd/jqJrA2jWtsBX+40P64D2o1
	Cu1j4U/a5RrQ3DjiA2sXBQtppNGGt1e10Fple9kXWs+ljZ8X7C5qnwj5uiv4KrkO
	p3cCnq2BzQya0gCfnfy11FhfWHRkE/rHEmtysILbUyiCLUpNrmpjctwI5+xuzfzN
	N64UK7xoCV7X5DsKoKLA0w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh1mkaaa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 09:04:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45E7JjcV012525;
	Fri, 14 Jun 2024 09:04:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ynca28140-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 09:04:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgNWpWESBwyLkutfnClQTU34ouPYD5bTZQewvSzKODO0yA243oVm4i5h0TpNw0cTfRL9pJvqxXrmXa7q4LpHW+m4dlzOR01dZKxFadRZDdRAuDW00XPgNc/TcTdZjNbinpkaP2aoCp29tqvCtktxO+h6/vSd3jz3MWIpbjHTX7eo5ZNMmvwulmWgQo4+e3bNW51DDR5ELnZ8Qww3RBJrsqjPMkzMbHaPvOEXzzCS+odjGY6Ip7DA3nLwU+pMtBsJnIF++jVgxXjnjX6dCsKB2CIdZ6b7IroU0fgvv0ddnfRWsKNRRTu+WJ36ORITn5JhFKehlt9UHb3apVONUzjIfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h559c+Qu/VZRVT0432jz4DVyJDWOcQQaE5fCUcczRmY=;
 b=jWv7j5VCSzqAuU5NMOnsCbsr8ZFKYV5LFsStcA+D6Jy6nz56ZLIUkJ5MOoKZjqgi6jrdE4Y8lWMA0WfiXE31lBqvpRz9x1/l90jbdpN9/OPkcad0hXm1otI1FxoDa0eZ64EdtUMAcYfFcsFzh+GxXF1Kc+bwBPoU/4JVBbcb+8iVK1gUYArxDqGhKXufsGDcQnRV5VoVVPTRiA1zUPPfzKFGPJLSS3se4/bRMQ9BJbsDOqr1yUIUDNKrug+7ehXxIk+Hx0WlMAfp4WQbatUBe+ozdD6HDUMP3xfpCaEUaqfWKITrZ5WvleMOiiAO5155PmehYq9oeZwgZCjJqzbnVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h559c+Qu/VZRVT0432jz4DVyJDWOcQQaE5fCUcczRmY=;
 b=QQ66QBi15tsH/5eVfumrzxgx3WyrA6beWh6FEzRMb8hgl9bEH5snJLJ5VS2EK1oRxUIgCB7Hw7UpwO3nNiqRh8zxmxskNjC3QLqadn1c/gh0IOZYtVbaYGx1Rl9AhXfMvhF/HkNV2/qFX6LU9YUUZQv48Ix917Zp8c2ghPaHt1M=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4600.namprd10.prod.outlook.com (2603:10b6:510:36::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Fri, 14 Jun
 2024 09:04:02 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7677.024; Fri, 14 Jun 2024
 09:04:02 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, paolo.valente@unimore.it
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jiapeng.chong@linux.alibaba.com, hch@lst.de,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH 3/3] block: BFQ: Refactor bfq_exit_icq() to silence sparse warning
Date: Fri, 14 Jun 2024 09:03:45 +0000
Message-Id: <20240614090345.655716-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240614090345.655716-1-john.g.garry@oracle.com>
References: <20240614090345.655716-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0040.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::15) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4600:EE_
X-MS-Office365-Filtering-Correlation-Id: a83ccd39-3111-426a-4a59-08dc8c50ef75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?nCUY9Mr8KDShRF7u9wLex3cziCgnkaVd2+//MgL9nmXMLXMGzwQfqESsqbDw?=
 =?us-ascii?Q?226vI2IKDWUcXrB5XSrULLbsAU2U5iWuF+8qWlZP4blN1DC41Z9MkTfWPIOZ?=
 =?us-ascii?Q?ZKMfKAGnmhoDMbenrMzqmWCyCPNzzjEg3v6os/QLFris+SS2vTVJGNTzt5O7?=
 =?us-ascii?Q?bLrf3YgEyVOSyDB64++vCtCYUtm64YUnwWXirVQdSR02v9wdGU+X6RQBoxb4?=
 =?us-ascii?Q?EagZh+QRSlyl1xjINr/xx8gWhI10E5OwQOhVl4Ps5BXSklQexLPYCGeWJKGI?=
 =?us-ascii?Q?QcNxeFWV2Mo4DgPbxM1gvE60s77Hu/O3dhd0+eyIkbLWbEayU1WOo7XHE4BA?=
 =?us-ascii?Q?24W8t+t91DKSJxM2sgVM6Vqcmar3yd12q2VCDTzIljQg1wHJNf2DVWosu+C6?=
 =?us-ascii?Q?MayvA/oaq1mdDYdinOVWOeJfrek5perpHnsrC5aoedUML6QWhx+/wtSvetkk?=
 =?us-ascii?Q?gTbCUoRtcP3RsczLoeHBDhizRStDkxpvvB8edIrMwux1TYJao05LIPdGhUVE?=
 =?us-ascii?Q?T0gcs56Egw9gBYq7QV3DmtLEOhqs87sKI7p+knO8nVmz5M5Q0GrCi+jv82WI?=
 =?us-ascii?Q?L6QXDwQv+tE/cMYcFAEeitjS8zVNB3RXWwFRf9lfXX+uwb3CUwNDwtUKKUp3?=
 =?us-ascii?Q?Pek/e8oISIu8S8gOC4TeC+eq3taMI1PqBvyhdH1/dQU/19Sg/OW6C5vCgrfi?=
 =?us-ascii?Q?SKOUX22Y/4u2LnchNK9HH6uL3t6pRp/lITSAW3296H08qtLUzLELRDjkeN8b?=
 =?us-ascii?Q?WZpTn1PKo+ugGUZhS6mybNFp2+YZ/T1iSoP7wrsp2zpjwgRCXB/p8g90zecU?=
 =?us-ascii?Q?07JcbnDqUbWmKHdoj5VVcfoSyJ8fY8ot7I9q0Egko5QlNwqeNWiMEARMCq8Q?=
 =?us-ascii?Q?GuNbKCQowVPjRLhGAN51HYWTzHcZdtqtOZN8oVjzyPS1v2EpwEt1hYLmpsnD?=
 =?us-ascii?Q?dN/8jpvNsMMZj4tU19daneiPyuu87qHciPgAGq5bVMkwjR7VpGlyHKqKt5Nb?=
 =?us-ascii?Q?1r0TiRGpvolLkPGrTjhihuy4ki32dDyqwxxI09SmsCRYIdrs8zyt3gf4ZlPI?=
 =?us-ascii?Q?M9s0nP5Zks/QOMzX6HpJEefrbGmgYwNeQ/GILj9cfGYEx2OwdBqJ4gvu31pv?=
 =?us-ascii?Q?mcFrvdJNxIU+WzPWNbzhHDf2WlXG9TB1PVRV9oc/R4QT5z/7yNiL60KHiYKH?=
 =?us-ascii?Q?3o2o2EO+59E5wm6EYYOK3uefTH7HuEyTPF2mMA7hiJKfjnDovlLpXv+SWvEy?=
 =?us-ascii?Q?ILSvpJMzh4cK/jgQGx7ZEh/iqoPooTZAY4NjYA37XcGotjfNrs61bgOc92Rh?=
 =?us-ascii?Q?CrYl/uOEI2U3DE9o+8XQqmlA?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?db8vgU9EnMQsGfB1aSIlqerX0179HhzPZ6G9v5y0s5GjwSaZO8i1zGgj/00p?=
 =?us-ascii?Q?D2cgRzakNJ+g61oPfhyRqacD7H3OAtj3oKsh8VYy1aCFQ0dvfi9Q5cBE82V9?=
 =?us-ascii?Q?YNiHe3wK2bhlB/5MEzdHRZr4UPzV7QkCgjWV7AWWlrIuxQ5FmQlAHPVYSi4J?=
 =?us-ascii?Q?6KbJOooHuVs9hCvPoo7Nyrt+0iTKrHt6c3/nuT7lPhsPMGlTSHTkpZzytRoR?=
 =?us-ascii?Q?1Ny9/ppxdeVnLRezw3VcTZy3XAoz4MOqVX1ZFInUhAFYTXZix+zQ/ZeBVoid?=
 =?us-ascii?Q?JYHe52T9o8G6UNgGG2e7gAbnuwI7FHcK4O9d0CybbvvIcwWosXoOJswSRahp?=
 =?us-ascii?Q?YVabpBxAKCBzuBUXpIJPxcw1d6onAF/MwRh4/Gc/olghmoc6GgsG9Ap1kIc7?=
 =?us-ascii?Q?pr8F0jWibq6O9/ms1kNFEiDaDsL8KzqoTYyFwz+R79UxlEXSQuzMPYby7rS3?=
 =?us-ascii?Q?1J2Krsn6w81sBfibus2j6RYniqHAdziJqE7qErtJbWK67pjaIMFsC7ywtFF3?=
 =?us-ascii?Q?8XkiBsgWmhJWHAicVTB+pz65dIebRxbcXuybS4WUGXWB1EcHuGnmr+/BmHfi?=
 =?us-ascii?Q?w4dBHg6Ffj25HgyTvZQA4gdSLc2VVHpVZO8R3gMsIV9j8ud+Zzb3U3Sjc1nW?=
 =?us-ascii?Q?GYof+axjRbxbmNTPRqcc9wBNW4+VM93PlwRQmCOAWz5Gsd1WsSRzbkA/+tlg?=
 =?us-ascii?Q?oRfOf/yg25SpabxCOWMPy+lW7tD13vlvMJgLBHJPWWX+c9xVOL1+qDDDVG6z?=
 =?us-ascii?Q?dXGRth+8u7rL+LDYHXSsBTWZVWmUGZFrLymJl5jKGPMKunhg+7oa5SBWuDU/?=
 =?us-ascii?Q?yubpgtsLU6MDy3Pee7NNju+PVxrKLiFEqo60YdrZL8y+n7aHTNr0geNOlSPQ?=
 =?us-ascii?Q?2LM+0Ax42vHCFGQ7IBWzGf/pcchv7MVayKz0ahg6uSBBJyNc0rlk8y4qubcp?=
 =?us-ascii?Q?P5NF0r9OD2Fet5itGeiSX1t2brOOEblelp8GeRrsxg+Z7OSQVAlb0AK5NYO3?=
 =?us-ascii?Q?QNXvuzJnLXihvIViHHTaNWGT/aB1dTtJO9ryFF0lylyEA4SNLSiPBD54lTKu?=
 =?us-ascii?Q?d1jFQ/naO2s/sDflVf/b00+MWIXObHVXJx3er/L/3nGFpzy0Kqr9ZgQmbHII?=
 =?us-ascii?Q?cj8BtJFVLxyeXGt/jV4N23FZLmfVeZ7Q1Ss+raf6yGE8gKvRx0LERZjqHAer?=
 =?us-ascii?Q?9E2RSJEjmWnnm6RZJz9ms00OcW7ORy5lNv1ItBQvQJuQo4ZAJ5k00Dp02ADq?=
 =?us-ascii?Q?weXyuHJLZHPnqpmVPwE+DgKSaduL/pSL+F1bsL3P68a5x4CsvBS07QQ0BgAL?=
 =?us-ascii?Q?dwC+bUGiyjhnQeX6oW41UNiQGW8otxQcDh5F36f0UydKniyVrBb/HNH4KG+a?=
 =?us-ascii?Q?+Iu7AEgCN4wpLdE2hknP+v7hFK33yRdXCjDoNJr178n1zU0GyDl14owqMG2C?=
 =?us-ascii?Q?IQLnFex5YVASZ253SaHhnjU+XiLyOcPAdfgNxZfNUXQQuhk1GIoM9clNjtSM?=
 =?us-ascii?Q?SPKloUyOEgF9s81pebLBuw9SiS/lCbiYbZd6lgjApjfpPugTqWtb3W58w+X6?=
 =?us-ascii?Q?nh3ucEmqVPM4b7YTS3iwM6xL6ZwrBd0WJalgPqUQ9oaiHw7KVmWaEAgDOcF/?=
 =?us-ascii?Q?nw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	lqEI1hd0DyfoYe9Khg3vPPyPNuNbPsWRIvWqpecFZ46K2515HAI9f8UaZiwT2nzappCKApNulKIJuc7ZYPYQI4whcxpkotl/FUtEaWsfNKI7BAfbFb0pg8zBnfMJINjAsQnMKj5X6M3Y4t4QBni3TO/dXrwlEN6IvdYzF6XwU/kTINPsCX/T2+9vNK3zJoD5z3z9QdMGPwmVndwDJhRg9RymVwupwnhcMODRswcp3MKkvF9HGmwMJHkVcy+EuaULvkwFN+rZK/ff1gtiGgR14VXITN4CmF1/UngpPo9z7T0dhhYcRQe2tmI0CW/bsllsC02C4aSHc9pYqIi5xWIslTnTHJDtPy1Gw7FgxY0dXOvbtJH14WXWno0f+RDrOYA8yEPGzF58h+ZmOXeyFi0sdcc90ftrhcW+Db/DAxXvteTT0wCPLvuFhgCV+YDZ8ZGBlA4q7Yi+5SvGI5X5AFNl7El8XCjEJhSpULOwz6NmfRG0Dvxm/HQeYKLh7MK8xfUwSfngy8Wur6mQvOAP9zIMG/StlJVX7uJs8vDR5PeQpdSCutPtRQD0kNBdOAUqUPiBKqDXEGTGmQ9OwJV4VAZNWo8WP8ne+E7atQbIhqVrBQ4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a83ccd39-3111-426a-4a59-08dc8c50ef75
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2024 09:04:02.3899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L4prmE9CKqJUwj6X5bf06AeLJGMR/jhGp9cPoGq6gWb/Lmyq9A66I3I05WpNqqaxpqqG0KmfQThAIjXDJNkC6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4600
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-13_15,2024-06-13_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406140061
X-Proofpoint-ORIG-GUID: 5h1Pv9gOmjZo9F_WFoCQO1LyyLBMieuV
X-Proofpoint-GUID: 5h1Pv9gOmjZo9F_WFoCQO1LyyLBMieuV

Currently building for C=1 generates the following warning:
block/bfq-iosched.c:5498:9: warning: context imbalance in 'bfq_exit_icq' - different lock contexts for basic block

Refactor bfq_exit_icq() into a core part which loops for the actuators,
and only lock calling this routine when necessary.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 block/bfq-iosched.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 4b88a54a9b76..36a4998c4b37 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5463,40 +5463,42 @@ static void bfq_exit_icq_bfqq(struct bfq_io_cq *bic, bool is_sync,
 	}
 }
 
+static void _bfq_exit_icq(struct bfq_io_cq *bic, unsigned int num_actuators)
+{
+	struct bfq_iocq_bfqq_data *bfqq_data = bic->bfqq_data;
+	unsigned int act_idx;
+
+	for (act_idx = 0; act_idx < num_actuators; act_idx++) {
+		if (bfqq_data[act_idx].stable_merge_bfqq)
+			bfq_put_stable_ref(bfqq_data[act_idx].stable_merge_bfqq);
+
+		bfq_exit_icq_bfqq(bic, true, act_idx);
+		bfq_exit_icq_bfqq(bic, false, act_idx);
+	}
+}
+
 static void bfq_exit_icq(struct io_cq *icq)
 {
 	struct bfq_io_cq *bic = icq_to_bic(icq);
 	struct bfq_data *bfqd = bic_to_bfqd(bic);
 	unsigned long flags;
-	unsigned int act_idx;
+
 	/*
 	 * If bfqd and thus bfqd->num_actuators is not available any
 	 * longer, then cycle over all possible per-actuator bfqqs in
 	 * next loop. We rely on bic being zeroed on creation, and
 	 * therefore on its unused per-actuator fields being NULL.
-	 */
-	unsigned int num_actuators = BFQ_MAX_ACTUATORS;
-	struct bfq_iocq_bfqq_data *bfqq_data = bic->bfqq_data;
-
-	/*
+	 *
 	 * bfqd is NULL if scheduler already exited, and in that case
 	 * this is the last time these queues are accessed.
 	 */
 	if (bfqd) {
 		spin_lock_irqsave(&bfqd->lock, flags);
-		num_actuators = bfqd->num_actuators;
-	}
-
-	for (act_idx = 0; act_idx < num_actuators; act_idx++) {
-		if (bfqq_data[act_idx].stable_merge_bfqq)
-			bfq_put_stable_ref(bfqq_data[act_idx].stable_merge_bfqq);
-
-		bfq_exit_icq_bfqq(bic, true, act_idx);
-		bfq_exit_icq_bfqq(bic, false, act_idx);
-	}
-
-	if (bfqd)
+		_bfq_exit_icq(bic, bfqd->num_actuators);
 		spin_unlock_irqrestore(&bfqd->lock, flags);
+	} else {
+		_bfq_exit_icq(bic, BFQ_MAX_ACTUATORS);
+	}
 }
 
 /*
-- 
2.31.1

