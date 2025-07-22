Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40008242D89
	for <linux-block@vger.kernel.org>; Tue, 22 Jul 2025 11:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753182258; cv=fail; b=OPgtQE4jQ0NKji0B3ajr8sw2NJTsdODnCoYm8iuq36aAnJ1cotewZfZQlg6KfarUBhK4oEGkkwaAYAxpt/wvAFUjUmW24/2UQWtxLVwxST9pvPWce16A9+kJj/uHwC3MdE0Fb5vzt5shMjy0sxbBjbanSZIGmitNvoUYYLEJFkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753182258; c=relaxed/simple;
	bh=RWbpXEr13fJkOhU57C6oq/QYLVbx8NikvGbgglNogWk=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=NZHP/VkxTw+wlw+I94Sbcn2JP68nPpkqKCZrrl0Lj9KGvyGTrZ86ZilxdwBqIaQVVNdZffCA/VGWIP2Lf73v0alePhlpiVAUK4jNGEfMujCS5MchyoS0Ja96QIeUFwYmoGzaVfk2h6FsvjTCiv9ck+xxqHCW6vmaVoEDgjhcmPc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AaRah0Jz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=lntxO7+a; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AaRah0Jz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="lntxO7+a"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56M5TCNS021355;
	Tue, 22 Jul 2025 11:04:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=nhe72UKhlej5qLfD9v
	NrgVmkCKMx0yG28RTfJwl4uaY=; b=AaRah0JzRFUrIg3H16+Ud0nN/1qmeUvd5R
	Upow2xHvqawYhc85imluZEZXHpTUAmqI2EGqTXhCVmOCL9GV/AeXm2kFqpF3JQCN
	HO3Gm1I0tK2JloxqI1FLWcnVzmvRjb08WiYjgx2DK9uj+5Y1lHdWZz6ZuKcgM4++
	rWCGJcIJkaXzR5XReRyY7ucYGGeYu7rgdTFBpFg3WR1Va9obmG2GiOFZGR6s4zJk
	fjbQg8QvWXNaeo2QIdKgpatzcaPPFD/vXecWecsOtwi6LV6JOyCH3os7Fumr7FEZ
	l/P7NnWqz/rdb5EaxbQFeSnrxn+qq9TwCMTam+cjqg4djzPoPzfQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e9n2t4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 11:04:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56MA4LG6006053;
	Tue, 22 Jul 2025 11:04:10 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801t96b8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Jul 2025 11:04:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QHrWSFAl9EzVy+60RnMVQs+zdljb2bcd0SzVv6OsJXTmiFW2EUexNIn3KRi3gKR4OIzM3bphCsHCSfJuxD2pee2pwKxVwsMfliy7GAicGXGiLFuTm8q1vrq3C8apfrooyWsXkOAXq3F2WOvyb14Kpkp682JCf8GOgWjDxwilWYEzjj5jm/HpRccyRyMbYVvsg4MYxnTT31wtnPKFa7w7IE+2FwB9GIu219jN5IcYM4waxaIoLPYPMzSi1OZs2UrwhRSTihAWZIlRZApWU2EzA/Oi6I8NobdGxLKvJHKtrMwlbIQQ/oa80p1x12hqybX3qbWryAjwvhdSyFp7RK2Kzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nhe72UKhlej5qLfD9vNrgVmkCKMx0yG28RTfJwl4uaY=;
 b=ncj0kxCb3HC2oyXoyfqIcdm7isqt3iumr/ErbRP8f5eOAX/Ic6ro4LgC09NhsxFJdpQJB0b3qF6fcQZ+gkyi81PUU9ioPIRb0F9bq4smAJb2FGnRQZbmMtNSC7G4O0DeDLqV/mfJmNPwhhNjYiCvO1yKqpq2RTmryFIWvs5mjkA2MBHYUm5Cqy4AsLjPy+g//K5SqMDBsGgOqHRFGM30dsgtdpSG47KvDoa4O0rJLvmQaJN5/QUKgMF9+k4qSgvPCw/cZkGdFqwAcykiAbkbRewnQLwfydLQhU6sHGu05a+nyqunbhES8M53HnH56Teiy72IAs7S02wgKyCk+LBlDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nhe72UKhlej5qLfD9vNrgVmkCKMx0yG28RTfJwl4uaY=;
 b=lntxO7+aEM9aXT2tLdpvh3GkBNNcjJeE4/ASDEZ1Hke5L0Lcy4yCTcVkddOn6zcYt8lgUt98gr/R1gHji79Vc7evU6ZPEkPM5pw7sjAYYcx2NwuCgSPF4A45iVd48HjPVsQQXVPyLpcnOrXT/pNkA6FmJTPbI4+CyC1kOjhrjDw=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by PH7PR10MB7851.namprd10.prod.outlook.com (2603:10b6:510:30d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 22 Jul
 2025 11:04:07 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.8943.028; Tue, 22 Jul 2025
 11:04:07 +0000
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: vincent.fu@samsung.com, anuj1072538@gmail.com, axboe@kernel.dk,
        hch@infradead.org, martin.petersen@oracle.com,
        linux-block@vger.kernel.org, joshi.k@samsung.com
Subject: Re: [PATCH v2] block: fix lbmd_guard_tag_type assignment in
 FS_IOC_GETLBMD_CAP
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250722091303.80564-1-anuj20.g@samsung.com> (Anuj Gupta's
	message of "Tue, 22 Jul 2025 14:43:03 +0530")
Organization: Oracle Corporation
Message-ID: <yq1freowkq9.fsf@ca-mkp.ca.oracle.com>
References: <CGME20250722091328epcas5p4c8707b75d657da9e0590ba634977d71e@epcas5p4.samsung.com>
	<20250722091303.80564-1-anuj20.g@samsung.com>
Date: Tue, 22 Jul 2025 07:04:04 -0400
Content-Type: text/plain
X-ClientProxiedBy: PH7P221CA0057.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::20) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|PH7PR10MB7851:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b99e18f-9337-425d-4b3b-08ddc90f7a1c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YOiAHBO773xJE4QUWPJP8lvtSNwqC5eu5Eou77dOO+9lz8vFMlgIQOxZki4b?=
 =?us-ascii?Q?aVpecW8Y0YjzEUdCzUM+vkgALClIsuj3e0fn2nCiARCBWhQXbtKR6IHs2UiS?=
 =?us-ascii?Q?Ytv7i9Buxc0cagbFLzazWSaXhHgcmaG6424V4W1ZNP43MiA9qm8Y/5DCcAyf?=
 =?us-ascii?Q?kGm2A+hSPi6mSg5ZIW4P2GbxQgI6OtTPANjn2YCOvmdIFl4R8LJr91hjLv93?=
 =?us-ascii?Q?2MD37Kh5ySNX3U6C93DTf7CO7Z5XheFynBfq47c/+q78L03m+EsTjo4/Jn5B?=
 =?us-ascii?Q?hs3x4s+fOtuLCtD14tui5itgimyPHt6F89m0l4Jj8kM6GKpCx4/Dojl12sye?=
 =?us-ascii?Q?64XuzpS4sJq5vXSQU74lEl3wX6ROTPEApG0aNozgbg77NwanWtU8EmBXmdH/?=
 =?us-ascii?Q?ubtn9LkJf5Ws3GhTlea58xpOBRGRl9kmtJOl4s0Xg1GdDh33HKNAspORAdIl?=
 =?us-ascii?Q?EjLInfXXIbIa5yESaxUP+TBa6gQ0KfYBNg973XzpXa4wHeuGkQDXR4SrMJlP?=
 =?us-ascii?Q?T4hb3pOTFK6gMigI8OH71mYnllRjiOYkSQ40pjviJIazpLWk0CXw7K2hk6Ip?=
 =?us-ascii?Q?6JvOWLMLp6rqnK13uxqiANVmIaN67UmJwMxyTKZNfk7dxzH9s9JvTOPjs49M?=
 =?us-ascii?Q?Mjg8AHOFLD0Ha0Gm9+zTlIfpoygZ7Z1b43JPSBNrv367A1sJ3nssB3MDvxE5?=
 =?us-ascii?Q?Yf6dS+gplZwEXeZXKrSNLFqzB9KOZeiOz2fHGETBMpcmqka2eFOcGK90J5v5?=
 =?us-ascii?Q?olPGKR4u5v/YzSik10ROZvBavrEZTcv6zM7911zqf5LHte7auzsYwlqpIo12?=
 =?us-ascii?Q?RLUazOXnVat9qYFJ+fTmggNBejpW2i+uQcpenuyHCrNtEJ5uGqup6texn9zY?=
 =?us-ascii?Q?JkfOxXt+/Q1bpZWOp5uJc2rffggpPVF0r9vNkRJeVmGMtgO3o88Y6TcprtHa?=
 =?us-ascii?Q?n3h6hwK62VzKz6JMaI1pWfYsTScxQlgo70DI+qbaOjqj9lGCL0orOPHbYsZg?=
 =?us-ascii?Q?4FkZDBZqsML2Y9cSf0dKWl27nw7tqdWw7qUvc9bHoCfQwNllINDqMjztLUTq?=
 =?us-ascii?Q?o0n/neOoT2FCQwLdnAG1Uh3PqDpglnwKtxHC5cc7+qav6MrJkourXVK9H6w7?=
 =?us-ascii?Q?XuKItsZ8X/R+nt31jRKjkLXhmadXZ2jXY0u7JVQCEFPinSx8ABiXNvebmAIY?=
 =?us-ascii?Q?6+odS1DuCCKoHSdy4wu2OVHflozUAOfP0MfqZvZ09uAH/d1hGTdNmMIHU78h?=
 =?us-ascii?Q?k+dUo67zp5SIWxBoFpWvCWaAlba/ZsaMk/smsqnH0UtLbFsmO/TV1xxYjwX4?=
 =?us-ascii?Q?y2edaGGcSYJUNs6o66QXypzbb56TIeclSqBFFz9nKBhGx1LLQBUES+j/BX+a?=
 =?us-ascii?Q?i4xdYFJGUDremcqGfnPflyzzJ5uXdwZWD0gXT7oK0edL09fvz8OgNMON4WKx?=
 =?us-ascii?Q?p9CHRni9Apg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XLgJunWlnm2I8ewAe61E6Bj/TBVjyFL7nfhb2HIclD9zvECOmV9X6v9vDsKq?=
 =?us-ascii?Q?oeMSyTAZUSI2OATyjr2ODom+L0wyZ7vmAOA/MQ4t2cJ0upyDv7rNBtAqd1kG?=
 =?us-ascii?Q?o1QEs7/DBFe6T4fKV2qP9HuDcETR0pjkqb5DjEi9DlBNHO91kgCc9K1WhE6Y?=
 =?us-ascii?Q?+4z1fMVMB12RG1+u2gbuEv3q9jOMOHAxY8lMvi6fPPxNUQKtfUwrjgJwOzxm?=
 =?us-ascii?Q?7g6/IS9SKjyNydA8addeD6wKo1EFrVlj7vmrtSZhJGslFtH6qexUm2ZmZ0gP?=
 =?us-ascii?Q?WjQLBd1V5yoJNrwoT3FCL8WYdbg/SJW/P89WfXgcN4fYNweB4g+19XXOA/41?=
 =?us-ascii?Q?YC7nYzeM1Ow3kEeMpv7lDXkvtKsjvT4jixEX56dvOVrzT98HlL2IR5FMIabT?=
 =?us-ascii?Q?iX29zoYz4GmTVbXL18qsBiXIWVW/Vxm7RWeKhbHb+zfp/BhpgjaJ3/mvhzbr?=
 =?us-ascii?Q?RSwsXaw+EvDBwTD8Q3abWU1AZ8/l8bOFq/NNvA4e964sOL9hp7yukyZlNkko?=
 =?us-ascii?Q?OzkOwDVO6JVpiznmOcsBvcge+Dksv8qXVmUsgA9inG0u9cIqqowlkMjVH1Ft?=
 =?us-ascii?Q?k4mW+ZUYhTdgwpl9vcd1m5KDFztka62QWbLMlszJA8zI8J4f5JwbcHjtXwaM?=
 =?us-ascii?Q?M0NGjt8yqDR0Z85O8HKB8sfwix+J+TnMscd+bu9M88FzLzr/gthA6B4m76d6?=
 =?us-ascii?Q?H+D7WYjcxbgylVqe7obIJQgEcQYC6XlpVn3ILAayan5V3/MGVGzCJZpjyjWM?=
 =?us-ascii?Q?0SPjC7g2D/q/DhlnKiQG+MSbh1vrA0oKcr+DcRkn64z8mXSuHZJmvSVnun+K?=
 =?us-ascii?Q?tuWQpn0CaIlLvs/ISVzyZWBY6lX06+pbve9hZU0No0NOG0xTdAHHN9FsX7fN?=
 =?us-ascii?Q?xhxO1S9FDd8upDz4hGVFhe/s2sDrZ+mNozM74gIl4LmRUlXL86zy6cKPsXIW?=
 =?us-ascii?Q?W9SYIp3RU0iqkb9Zzi85ORJHQQNhaes2yiTKQ53f+5qriewa8lNIq73R81+l?=
 =?us-ascii?Q?PCaHIyWuzzDJnSmqNR5fhdiqGP4U1LVF8Bg8Qgn+0PlcPRVsHrD0Ds0eqenV?=
 =?us-ascii?Q?Sdxfah7FlIQfQnlIwjM554JzrlrFLbkyeHjoiqUeiQLoarnhLXqN+s1CRBIM?=
 =?us-ascii?Q?7glrF2/on994ogG//O0gcSrlTWxQQTaE4ioib21BZGpgO3WXSgOOEYz4GDYg?=
 =?us-ascii?Q?yiENCVkyYxH7Ax7LMDgSGM0GTtKOQ+S0nv8orSf93rZmAl2K7uP5+uXPDrfa?=
 =?us-ascii?Q?8L/ew1Jf87Q2QI1MtykbiavhsLOq3PTolYFH1BOCNr+JxcLXWOgulx50kQUJ?=
 =?us-ascii?Q?6GRtwbXueCdvpw++OqGTByhWigKmZrnGO25CVvGnhueoeXQls8liMrmnknYC?=
 =?us-ascii?Q?nuySK5OqlW+2qNtMDcBGyLH4sYSc/zlvpTWAMz7jIOIXKt2+2MnVLFZEU7TH?=
 =?us-ascii?Q?6h6VWUk/CrdDjx85E4aXbsDJfaTTmJX87tbQbGUx5vhuIFEFY9K769JWPbWQ?=
 =?us-ascii?Q?ORBohId/e/274HJ/AVWie1JTw7DOBkHAeqVQF9JvP4Hl8erxh+GZ9KHfcG8e?=
 =?us-ascii?Q?9ZpMG1qZt40oXFlHbkL2Fsn16/vy06f6Bh3zpGkFmv8MkqsAMZUWER7EQoIg?=
 =?us-ascii?Q?tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5jymHy7qGxbmunenDQiLtWvE4WC/fvvtdrSUTkt9s/qjPBihwVMQDRz9e7IKoEI6MiFiLQWTrZsfUI0r4mXDcaokRGHNaWCYPK1zCWgeB3QGhQ7kHiWaH810ZTOFqDVEftsNYrw0p8pUPmI5o5uXbLFSZpttSNHZks4nDLVfvmXCxuwvkhP3zxJFzMbL/H/Ardd31/F3DMaOdqapPxAdN1wfG94j71rV/oWsoss7yLndqnnbaorvC5YKbpjV3V/M3h56q9akoPlxH0lnu8IB6nhwfEwGjZzMBE1pHTmVmYnrIdB+WYUKA7iH85XDyAP3wM07esMwkn7/McZbeEes5X+fXskun9CVfnOW4ry8hqx4dsGecLF3gdl2jzfhrCEP+FSTC4Qc+r3Yo+nsEeRf7AYHT4N2kp1K74Z2nzZ42R6kgm5dGfytDa+tykufot5EXSjh5PYj+ZfFFvppwklLk2taEFyFXlD27DwNDXBN2wZt/sLclNwsrYdDwazAj3wIMAMJQBFCfVvMZkgjjEJyj9mcJOIyE6MQTtv48yL15Qj7rA/N30X5GvuicgyMyrJK2k7A+GweTtbLISZcCP1qUN0HIqzZVoxmumj/R6T9xB4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b99e18f-9337-425d-4b3b-08ddc90f7a1c
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2025 11:04:06.8401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F9OD42BbTiKxbqxofzCTkDSCysRV0Wyed0hcas2FzME53wddBiyM3rqcU6fWbfBFcJZ+qQXMzdaW6mDfw84K61FUCZuVyyv4nk6WaeM6zSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7851
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507220090
X-Authority-Analysis: v=2.4 cv=eqbfzppX c=1 sm=1 tr=0 ts=687f702a cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8
 a=Bmu7LwvuKv61xYFECN8A:9
X-Proofpoint-GUID: S6R_6F6iAa8Q4WON9O6rQxrm8BUf3w2k
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDA5MCBTYWx0ZWRfXzr/wZsVzW9xP
 p6z6jixdivzcFJoBk3y4B7tpIMpCqRLN88hOUvND90APZun3AYpfhsel3xJ9ySVkpehntmSNn1o
 y40sfvyQa0T/XinZW1sSRmZtQNfrd4DWRKSBDflBCdjCseVzvanqFjkFh5pF+/0RD1mohhym+Iw
 dFuSArKBsGYumuhLvI8EMyhqFeqsg89gT7+Fjkoa5o+TkcmS5wKNZfwvkbSR61fAhY005UvvQUu
 usns9PhMpxiF+TeickNqZ6zdF/uaNaME9Plbufag46bcRRcjGj9BCPFFrp1AzK9Xcue8ujav2X+
 gTCNleUd4F6yNc+OrqbBtftaw8N4GFUSbjR4m+yaYb9iQ72SYcsYWz3IT6/v5L97dc0lbnzpYCT
 4tTWquCqitPvPiytyfDdTY6JYo6OpVZGUv+IielgEt1OJ/qPC196A02DI7Zq100PJqV/2zBv
X-Proofpoint-ORIG-GUID: S6R_6F6iAa8Q4WON9O6rQxrm8BUf3w2k


Anuj,

> The blk_get_meta_cap() implementation directly assigns bi->csum_type to
> the UAPI field lbmd_guard_tag_type. This is not right as the kernel enum
> blk_integrity_checksum values are not guaranteed to match the UAPI
> defined values.
>
> Fix this by explicitly mapping internal checksum types to UAPI-defined
> constants to ensure compatibility and correctness, especially for the
> devices using CRC64 PI.

Looks fine.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
