Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96099192B84
	for <linux-block@vger.kernel.org>; Wed, 24 Sep 2025 02:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758680403; cv=fail; b=G1D9A2wxeuLL0gUVlZwmGmWO9IjneCypwglxeWvz5kNotRiramCuZZOzbgerHUtFmm1MQ0pqBnbr1m55unc4v0mJKWjC6fqi2XJJaq6vkgYfZlgcybxgQLLEwPLxAk/6/6cXvkLdKPsA7kYWxgFvbXSuX2N4aV1zj6kQPFf9OzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758680403; c=relaxed/simple;
	bh=oKAF1+lm4tKAbD74cUxA6lGJkDNn8H5RUNVLV/HCUck=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=E2PEf9U3IGh+JxxU1rHGfkgq+bfrwnGA6Pf9unZvR2zvDh/rLgqPbLgY7s/RIOAcBKLeEzczLPfnnAT2lTgwuiQN6neZXgPHWNvi2tMeUFIz+yCRpxGtAj1OptWzkcxJ3Hs/skNZx4twyrGPtqrlNRuy4+EGtJXBmGn3JuYwOg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WBMIy2/r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SsrNBjPy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WBMIy2/r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SsrNBjPy"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58O1uNTY016403;
	Wed, 24 Sep 2025 02:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ExKPl455J9t7IVH7uG
	ycu2RiYhD9WE2gPzyQsuK/4N0=; b=WBMIy2/r+PTIjhUzPC1G00XmDJFXOA0kLz
	ASAh3LBboPv4D2ktoi2FcQTpzuY5fV3R4DkUmtR4bMXsq8j2BlE4k5BQEulGpQmM
	p4LJyXyuT1IIcz3GTwDRi5DjG/7rywaqxye4R1RXWt+5yqBaRZljoD+P6w4wwOzy
	mig1n/+p4A0aHsWwkBJxUCM6LD9lxSnlUVZi7kWOPfRnWHXkZz5YfZMcC8A6lBOh
	PqAZqxRFV/FeXiVu4pqOS7H4DFzsEn/zyRiyPCBQoH0K+OWJTGU/NQXJIaFoysiy
	DCNVbn73U5kgNPMUvzfHQaDNxF/UKGSRAv8amq+OtVLNxpLj3mpA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499mad62qy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 02:19:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58O0D3UB002111;
	Wed, 24 Sep 2025 02:19:51 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010041.outbound.protection.outlook.com [52.101.46.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 499jq904y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 02:19:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gtFRGcy5nXyhYqaJ/Xq+SC9LOiVmx0QNfkYpCrka7wFKuixTdG/Lxx++h7i13gA7tDCiFuQmEW48R1+RWC8RsLH3Ko31d2etrPoYUJBUe1ldZ2EaxZMSNrKtR3MndcexvRkotnb8kdJOCDlyVGcWZD2KRLQYTaLd0/kVfZiPS+XOrks8BhE07c9E7QqD9w/rBKiz0Jjh1qhMVTcAb0jCIZKmr/s2h5ooy5vn9W5Z5lL3J2MXACAA6gA3SaSXtlwh6CifSe1Nkojk2bZYPysseFSsHEx6cZ2uv7DBjxKRhqcc+Ymn3EDmM8oqhNQ6f50AyNujNexhc1v2KnaMQMmblw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ExKPl455J9t7IVH7uGycu2RiYhD9WE2gPzyQsuK/4N0=;
 b=KnSEgJ/q5AEyDE15W6htHmL59xMb9w/IRMYgWMaQD7ka7zoU0cyQ8RId8gD7keHIBoC0Bz3RqpKeA6kkmGjdmoBOXIOnjJI/r1+QbJ6pBAbcTCC2zu9tPd3ZrF30mGet6RnDiaEkb2W0+o8z9R2ZTQ2HFBTQCVcN2iSRM3HzyTLkIS3AYkpCxItVt4Hs3o1q3hMoSgKysUCk3oTT6sfpGXfgmCcvnGACFvAxM0TxfJy4FO/XR0Mfr8GJkmev0TIkq5/eqE+ZzIkJ5cpRqWNL997lBczrYXK/N17+JCYQ27FEISu9tf+bvJJccvAaQsvAVDYblGvYVI8R8qEQ/dtQog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ExKPl455J9t7IVH7uGycu2RiYhD9WE2gPzyQsuK/4N0=;
 b=SsrNBjPyCt0OqYc1RuHZ08KohiUGmxJTwmuuY/Wis4k1YxIN/g5/U/9x2P2TEI6Ij61AUuNSGm6W3sN+aREHcKqpfrVFHdugTnxOPz8znYoYryosKVusI9wyJ+MIl/7FOarW3VjoF7jp5uuo9CK7lZQhkbwpFxUHm9kymReWt6Y=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by SA6PR10MB8183.namprd10.prod.outlook.com (2603:10b6:806:444::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Wed, 24 Sep
 2025 02:19:48 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 02:19:48 +0000
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: vincent.fu@samsung.com, anuj1072538@gmail.com, axboe@kernel.dk,
        hch@infradead.org, martin.petersen@oracle.com,
        shinichiro.kawasaki@wdc.com, linux-block@vger.kernel.org,
        joshi.k@samsung.com
Subject: Re: [blktests v2 1/2] common/nvme: move NVMe helper checks out of
 tests/nvme/rc
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250919101028.14245-2-anuj20.g@samsung.com> (Anuj Gupta's
	message of "Fri, 19 Sep 2025 15:40:27 +0530")
Organization: Oracle Corporation
Message-ID: <yq18qi4twwc.fsf@ca-mkp.ca.oracle.com>
References: <20250919101028.14245-1-anuj20.g@samsung.com>
	<CGME20250919101119epcas5p2dd1f96167b7d39ae98087898a19b6a76@epcas5p2.samsung.com>
	<20250919101028.14245-2-anuj20.g@samsung.com>
Date: Tue, 23 Sep 2025 22:19:46 -0400
Content-Type: text/plain
X-ClientProxiedBy: YQBPR01CA0112.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:1::12) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|SA6PR10MB8183:EE_
X-MS-Office365-Filtering-Correlation-Id: 831debad-aa75-4091-fb14-08ddfb10d5f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fgS5QRHKzNqx287tIVPFafCILjcMksyYxTy5j7dhscMgejbPgslAiUV9zdLv?=
 =?us-ascii?Q?VzOMpNABHwYc10ZbxJLYsEYeH6yAd4qHotkVr/PwZOJECVYt1kdDaoAJMDBu?=
 =?us-ascii?Q?aibGx9r0gHC1MMaT17wnQyOhKnh92xwS0mPH2YaTq4fE1dT9V0d5beFwdEzT?=
 =?us-ascii?Q?SSDuIL5L0NcYjrkk7DDns1kHbn1zp3YaOWeR0nTdq5NCgGXmtS1pqWkhOLLD?=
 =?us-ascii?Q?i7e17RvwL7YSc5Ney/jH6lqApGGG3VlBY9YT7P0XfPDr59qvoha7uehqawif?=
 =?us-ascii?Q?BSPW/JNGCbIf0p4WpsSJt/I1d3ZlwzDBHJOJAnrOwOKiYoX+TQsfuh4GmRob?=
 =?us-ascii?Q?sgIC+H4HcM81vTx7jmB9T8eOGQcSKkVDUUL1ipSKVamrtcLwdpjXzfgiw8T5?=
 =?us-ascii?Q?Le9eifc5Qanywx5/O2m/I7IZ5DpFCrGKHB71eoyogLvv2uzO0qSNNuz8nfh4?=
 =?us-ascii?Q?lxnePEsaQPRvKm/pZWyt/M24I+hb0qPJMwbZAMDUjr2jRCqAJaeF+/xLxKtv?=
 =?us-ascii?Q?qXwvRhGvHF6jBOm03UW6pyUDNp+3RR80HstH4d6HeGfXVHQ9ksJ7LgccYbJQ?=
 =?us-ascii?Q?MQHfOKN0345HyBXKSxf57SggGxdc+/ly3fhhRTgayS2AVW0FImCK0eFC5xtq?=
 =?us-ascii?Q?PpmK2ut6E77Qk1ENkQM/b0y9pdFsHsoQGah5AMRTVcpjorf92suWdrPttyNk?=
 =?us-ascii?Q?5SqdhZV01SKn6Ci51FRuMXAlIG7o8ArMU789R6331702pIW10Oiw5k8vVW76?=
 =?us-ascii?Q?cafdeBZ4w8zdLzaBTe7GaQdvIBOXuY+jWhrkpXU6WasfQAzg+HskkFIJohnb?=
 =?us-ascii?Q?xLi+C9KMSuGUkw6pIzWM6tiaP9s27KRacM0G8a23XRBcNerZ8PxYdZJI2iQa?=
 =?us-ascii?Q?EMWYsClQ4n5ExKGRtQfJUwyzUyD3T0FP3qlvzbJyH6rZMx6ljC0n3fVr6tH4?=
 =?us-ascii?Q?I9TZYLNCh/lBiJF/XCeDWqSChJTKLXJxUS1zgUPurLakqNb5YMOFbttBOC3/?=
 =?us-ascii?Q?RRhe6m5aGCT0UbnHPiI/oxN2RPvOn4NEYaSyWCrQZ2HaGJ/FCWlhCOS7yQjy?=
 =?us-ascii?Q?d3YHMQzj0XWDkhpVbdXDG8N5cqNB4RjTEEKvKH1YN+TKbIddcc3Xh0Wti+w5?=
 =?us-ascii?Q?glcRSs8ayOls9874cIPYizQGk4UIQ9BPyHUlsr0/DyYDBORLyjn3OP3yGhz4?=
 =?us-ascii?Q?tZhAXQHpuSThTvsZTPVmKWA2vh3X61kBAMpK9Fmo25J/OPjNJwnTIAePYakS?=
 =?us-ascii?Q?/Fp9+LWX/X1segtiVHDM2fGRaIhTguQrg+2qROFl1Sc5Z4SatEo4iOjH5NxH?=
 =?us-ascii?Q?z/VPhMXCP44g65tzfKhcftk7ud2pKzxko0a1Rkm5igLdMf770xcvVpaR4YMT?=
 =?us-ascii?Q?zrGNiPQNQyPiHHYCmvxVqba7HxCKI83WpL0Q2+st8aEUqB+RuAes0XO6ynIh?=
 =?us-ascii?Q?dfmPrJ6QdZM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IL1l9NWsTkzjgZtpVqeMH/SiYzqxSM5DmGrFpRDA11BHfDQuL8YDML18shpq?=
 =?us-ascii?Q?Ob3QmzEB0s1Q4E0FH9qZ4R8xP1t5bQul/NpT3X6/YL0GX+xGLP0fA3Ak2Y7S?=
 =?us-ascii?Q?wQrw21QNcupS//IyRpS6b1Ff5fOYA7BGmKfDI6Han3GORpuzrlhR/7di3E+7?=
 =?us-ascii?Q?8wTQJ1udnaec0xukn8eCfvbXgyXtyfS/WTw5LB4lQMTX2i23cyrN0ExqhDgi?=
 =?us-ascii?Q?07iznJj3z+H9o1nPS2PGcGCVRhGDUy01Ni3y9KoWkwL61pD5KOSAPeq0d1VR?=
 =?us-ascii?Q?LSYl5DZENW6jN6OQdHxdBlk9wM0GPtx40KwLmEtIX3pqRH/cXRdsHbqdPc9X?=
 =?us-ascii?Q?ZXGyuVtlUJcw5byv5VfXvNssuIs+m+/+dS86sC5GfCWb5gXdJP5+/I3L9kkb?=
 =?us-ascii?Q?6gGIoJOGHigBiO4DAM5fFUqkS4eQkxZYQEKVcDksbReHx3jswhIdAb74Xb7U?=
 =?us-ascii?Q?1jcpKEn0S/IkS5DmmH1YTzJ01sOz95SgVlyW6cCeR4jrJfSvfbvuC7DwmYbS?=
 =?us-ascii?Q?iI05ZDd87aDWY8fv2kmLRExRj8YgL0mFwsO/Rt3AkFvoMHD0Roc4D5qOkvn5?=
 =?us-ascii?Q?XO9DXXT5Awg2nQnnHTbBLGKaPAJJ+22hsr/dsF1hnNFtAhprk9WNxRT14Jz7?=
 =?us-ascii?Q?8O7lN20HBTZqkY3oM2L2I0+2MOaJfScVkSuagkmqgdTVswK2KYEEwGKcAG3d?=
 =?us-ascii?Q?oNz5It4X/i7QG6s5DHvRTxv2IfmnLRmoFhfU6wODdVNuQNBaGsmCMx2HUCYu?=
 =?us-ascii?Q?St0iK96LNOE3zOruNYqHhvg6xScY7mcMqIfbTx+UAybNg733gABn4g1AyCxQ?=
 =?us-ascii?Q?UjLmlXxGrBEwr2IDBupGt7lZ1HtVS60E0DvkkLy2bCty9hu4xP5jkiKBK0bT?=
 =?us-ascii?Q?E4aSCWeb9LBGT9zZLVMDxNEsrPGQutC0Tn94Axu9D1yN8ODVremRGBAA7M8/?=
 =?us-ascii?Q?4XwSu9D1tnw8b2olZ90HUSfyB958USU4mGpCFU2KJ7DU9NNqSuPpo0MDxi7V?=
 =?us-ascii?Q?MiKKLp0Arqpij8PPlnYX6dDK7tRB5WEwH5CPaNd/R93Ik/Geof1lXOQ9a7PQ?=
 =?us-ascii?Q?1XfVnJGVZqrDyTgR41ZP+SQWr2Z7OD/dINb4A4wgf0TUT5z81e+SJ2rg6FrV?=
 =?us-ascii?Q?ZHEjWV1gvp8w5bVRQgRvUxQhiT748u+xHIusvwHEyXvsx1RIiw48ywLdkVIO?=
 =?us-ascii?Q?K+/cTLd5VGZ4BN3wKsF5VchVKtnq3OTRp2pSbvDDLQtPvSej6v4Nc9Mi0GzK?=
 =?us-ascii?Q?gfk5AKyfW71Iq5R7/Sv1ceqjJa5KEQC2cysvmNWrnyxYE0X1g4+K9N+0Yaoc?=
 =?us-ascii?Q?7J5BnKALQkPZX5/IIO3kmWrKo2/4ite7N46jJnBkU0B3LMHfOekY5nPYJQUP?=
 =?us-ascii?Q?PVCvxKHkfxj75FcAsypbE76HFA0nZjwiuHxDugxAG4lZZlv0iPmixGVhlIDx?=
 =?us-ascii?Q?eaLdS27dv3/PAqwrhHIx4RjG9VyVmY405S3Tzvh0UpZZrBTf99MXvS8b5wx0?=
 =?us-ascii?Q?oUooUuyuQqkAptww74OOhMZKJNZPERyNlBSrCtNE7RjvhaRESfjVMeLUNMhw?=
 =?us-ascii?Q?Sc0/Odrx2WoOIoGgvWaufJl/+QvBDHkVig3tDKh4DXMBxyAAdjH5USJYFopc?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DwRcxbzB9y2IwMutTAAQoZ43UppBUtnhbI1PAzETtCh67NT+xpNnuWBRTSKBd777viNkThvohlNTWYFaHN4T4E/VArKZ+zoyJ+9EVepdTBtIFsanC90PJgVPl2wqnU5BM1KsoOeh34DG4gMityn7NUNi/w32/G1bB1z2c14/nNIyEhWiQrSk4cAAZehC0FnQ1iqEKRmu0bjaf4nUbSXbeocvTCyjDJ9ZeyubevOVYkCnCITFhtQpkhEjfxVbpLDs1CX6QNwPAieaYKJbQYfwSddFrPVhu6w1l8la6KFL2eLKajRZmYE9HOubBPOOvUFRsSkhevhXgB/FHt9g9w9+6qAZW1SPTbhSwAtCa6IEXJ3+SeQndqP1Fx3YPy54Hgw5VB2W9Tmg3S83F7HjLZ0YjU/cNzGMo4e2csPXyPEVH9+PrwZyCwHwireVxXod9STUQaJa9NrpAzXRPqfrc3caHwi+EvlL/sOjf0wHn4JtU57j5lfaPCLS49bHvaXGq614/CDPWGw1sAsviNZgk2jbg9FagqG2jx0fnqvTvxcgVyD3SYv0GmijIPV/djmQV78kChXOznngiC4Lr/KvNUTG4Ajjbc6KRqnX74f0sNWiebg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 831debad-aa75-4091-fb14-08ddfb10d5f9
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 02:19:48.5863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SzIZSaaWactZgXxGauoX4JWYwma7lUvVInyO173dC44WFcTo7mTj6zlNiOdwDY42p/1QyaUSYEFO5T+ZJfJG+62Y9PjOoV8DuZwqNm2SYBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8183
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_08,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509240017
X-Proofpoint-ORIG-GUID: IZzsL6Ldn_gzwsa-bR6M9_NLI4h_nE-C
X-Proofpoint-GUID: IZzsL6Ldn_gzwsa-bR6M9_NLI4h_nE-C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAyOSBTYWx0ZWRfX8gec1fNzplim
 1MVnRCDhMZFbwY00Iy7MXCasA9Ce3MAyoOuHa/piQ6IMxE/dunKV4S0zS1GS9ZSvON4eAtKPH66
 o8hoXiKkydIdvpIuiu3Op9i0MFCGTQZOGbPAFbpaZBvTDQ+5NX2yn2IjcYtKfpnx36knz80A6Di
 5mH/wq4NX91X2u5ZiMvLVV+d10R0ACYMlR9Rr3zg2oHUW3jDGAYoTowtJbh8N2fAW2/3sBLtppv
 KfvcG09U+UPKD0TRfNxfNiBCxOrzWYozKsaE3aNfvXGlNoaeVi00p+kzaP66vgvGmlDdk/QzARI
 T3tlpQ4XRJLm1RAKcB77Wn/zn84IxmssRMErbdROoSEqchUrErkznGPIP4x639CH5Rqu5GNBFQh
 sQLaXwPJ
X-Authority-Analysis: v=2.4 cv=Vfv3PEp9 c=1 sm=1 tr=0 ts=68d35548 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=qrwD_XqgW60PPbV7-IkA:9 a=MTAcVbZMd_8A:10


Anuj,

> Move some of the NVMe capability helpers from tests/nvme/rc to
> common/nvme/ so they can be sourced from tests outside the nvme/ group
> (e.g. tests/block). No functional changes.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
