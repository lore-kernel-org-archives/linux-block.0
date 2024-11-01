Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8876F1586FE
	for <linux-block@vger.kernel.org>; Fri,  1 Nov 2024 09:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730452955; cv=fail; b=iflzzePOEj9cO6zZgUOKcWXfTsbHQ+8FnTFdRrgf0r0hVNKjmpxqOUJ05S9eKNpimD/OlV4mNUM4Tbe7W0sdV0IWpkxiasLIGt5F8WwuIe55OrNyblzL5yErlUpXj0RPU+BBD6b7V8mo0iQs+MrYcFxUrEjhkHUCEfQnXuNKOto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730452955; c=relaxed/simple;
	bh=UeQ3j9hCxzyyC8YcNoAl7CzyPgNRSrE3pi3AX628ylU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Y6FG7uEPErI6yl/R385yHBrUdwAenbQTD6tcb0ckReeIbDDWSgxdFNmjm1UPUYr9dJjF2ThNDpo+TmMgJse8JErS2agR+eN8tiGQDJbZuuSWYDExfpV5TzFuObh6Ac6L39+mj4305BArH74zxpWZfvwT+PPpz03fpwAs0VlGi9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m4Ac/zlF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pYrfJwhj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m4Ac/zlF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pYrfJwhj"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A18fxoe009195;
	Fri, 1 Nov 2024 09:22:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=9sTRVpElXsKKh30L
	FrQkpg2yzheXLcBSypmL9UVluqA=; b=m4Ac/zlFm7xiOZ1rWW29jVboc91Fywr1
	OiS+tkX1M/Tr1KzRrMaETuRhwLCOcEtkazyHnza3Mm1JQvpK8uPSe9pt8Ql0kWZK
	K5fPQ7cuKUOtaTosKr3B/gViFS/O4uTSAEXa3nGPiTQhZF+kn6Htb+pOSFG8ILDn
	JBDX3033oN/WBpvATVqmtR0ZDQGcPHMchTbNbV4GiMSWJaKpSz3KVFkCOVPw7a4A
	S1hPk2pskxsb/7FnaXsuhPrtbJsjrk5tAe9rJVLlEReI55VALxUcN57yPE33f8tS
	6qHpk08Ow5rsEr4grajT1r2KRfdG3vokTnSoxjSd7SThCj2ugIIgNA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42grgmm3e4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Nov 2024 09:22:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A170snK011833;
	Fri, 1 Nov 2024 09:22:28 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42hnagc1t2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 Nov 2024 09:22:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yRwvTsmEidrrl16Ut7ELTG2V+zudCzgnWMv7cef4zbwquRkt/8MG6hu4ik7Ox30gfU7wBMBZBysPekrzyTObxSpPWHWV4QVGEECL9AFN35QO2X0u1YfD9LRymFfEvYESzJvY4dbAjPgsuGV465nkqYWoAeNanZl3FOFill0kgbfsN7MjH8+JLBMEjqP58ycMNyEQm3x/2oIp04NQtHFjFv8Ug7g7IAf3DRjcZKQNjdlefeOHMFKtXp5hFGdhJE0EZSX++lTdwjm+9ttCLqOr2zPji3C6hW9CoNrOySDGcJUAm/GrcisyhMF/v2Nuf5FQdICuUD3ltlCB1VB6qL1W5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sTRVpElXsKKh30LFrQkpg2yzheXLcBSypmL9UVluqA=;
 b=xh1Gx8MR1MzaammBcDHtcYA0hfGV/HHDue1PhbsaaxlEaqBViiEXy9ZTkSahS4UA5PwGRI13tPyTQUisJEtRF9YYHEMXqvSBw8Br4dKpgSr/ulbsrE0cGmlcQaXftDt5JsdTi0+yiWRWi2ICd2LEFnEEWXjJ07vkUqM9WDrCE0aAHn4Y0q5BpqTVXHV9g2x+sM13EpqCyHGoha78DM8rlfSSyeKl6Ajj5Dbfl0xf34n8+6PtahlKW7aWuIm/e4lUJuYGAIWfkJyc9azlqbY+uwdE1Zk1odStVNBKBFiOIamcMtCycdi/rXuR4PuN1EQByZGT1l94LUmSZJ4Mid3fPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sTRVpElXsKKh30LFrQkpg2yzheXLcBSypmL9UVluqA=;
 b=pYrfJwhjl9ut6GHF7vNgLcwLbsWLv8NawjM6F4M+rYuUxQW9mpu6d0kOgFjaRHBczoFoaM0ynX2fffJd4QSsQqDRzwnTJh1KqUIrYDyrd0Mfumxj79hw2li2xNWT1xpNGjcGFI9knTZ3FfeVFDjH4mbWCN4mTNAkjniPr2n8iHE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY8PR10MB6729.namprd10.prod.outlook.com (2603:10b6:930:94::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Fri, 1 Nov
 2024 09:22:26 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8093.027; Fri, 1 Nov 2024
 09:22:26 +0000
From: John Garry <john.g.garry@oracle.com>
To: axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH] loop: Simplify discard granularity calc
Date: Fri,  1 Nov 2024 09:22:15 +0000
Message-Id: <20241101092215.422428-1-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P302CA0001.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY8PR10MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c396158-61de-4fd3-f80b-08dcfa56b33f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nq5o5pildlcKwFXzKjePxMAe1xQDWa0WKXbIH9GjD7jX43YW199EMr77+AyL?=
 =?us-ascii?Q?Uj9xpLhrgKdaqm0ogy6MJkOFEebUQktmlWFBLXdozqDW8oYYYs4K4Sj5+013?=
 =?us-ascii?Q?iLmEl/41KFrbGMCzie0mFlztEen1czIGyrR9JYMSBRyJSH7bsI054vW87NQz?=
 =?us-ascii?Q?K6REydQZwjyyyBDOdV2Vvw/townGJQn0fdhw0G34ActwDKbdbX4s0zixKUvw?=
 =?us-ascii?Q?LleOUk83w2hPap9atulr4PBAC6Hl97OJGbv64/3O/VaSVJ4eoPoO6QGN7RIW?=
 =?us-ascii?Q?Tz9+au1WPh6YdM4CaSMIHLvZZp0ms5cHcyPTT2AgJ+Exvpj1qQ+rpMBo5Gzc?=
 =?us-ascii?Q?am2z9hDYumuBvHz+9v3o/gZgWXolOv3kekniuPvbApIE75WLCLvfw+2IhZe9?=
 =?us-ascii?Q?QYyjz8GQQSEVG4jMwN7tYJWUA5ofwy5VLq99Uh2liE1hA4Lms+0iDqhmtC7z?=
 =?us-ascii?Q?LYhzm8h/srH2/3+w3cBg56te7HuHIsqGDSWOzC7Evu4YwoK0O0fvK1A5pY7A?=
 =?us-ascii?Q?WnU04WFYCFconvuJ5Oi6dXIumFYPdlWp7R4UL8rjb5OjvrsmoKVb2YF+s0iI?=
 =?us-ascii?Q?GMAWwKil/AmAkNCdfJ7rMi5tbgiim8TO/LxQGprubDCLisADAJzLENq4OfOP?=
 =?us-ascii?Q?KQwU4hl7WahhZyxBe3xzUAYMS0x0hMWC4fI4ltGtJ+418xPeUibl2NFb3kBv?=
 =?us-ascii?Q?OBrW/KRs+tbFdrziCKWHGNNmCs5/IPx0ijdmY8rn6cgvmAgu4JZ8X46C0rIU?=
 =?us-ascii?Q?QNQkFFxH3BRVOFtJDz+w182b2O5t9BU5w4twz54tYbmUcZ9fEneNfESasGbu?=
 =?us-ascii?Q?AwyoKs0HOALMyrsKEIytu8HKeDsJ5QSjv+Hw8UHu/FTPTsELiNPJrhXI8xfI?=
 =?us-ascii?Q?/HVVO0wLt/PLUspjPgOse8x533JIXoivLJ4IB3B8Z1JWvUxW0Svq6bhPgaf3?=
 =?us-ascii?Q?+l15ZAQZyKmWrsWaqKSCszapufZk2+c9CE6zjc3nL1mN6ykvWxlIcY6AsMsA?=
 =?us-ascii?Q?I5qLgTqDy21H43uxecqd0XArYUc4GfPeh8c6IEBxEvmq7ZQ3MgM5RdWzBRei?=
 =?us-ascii?Q?N19A09L7rxGIrIlkLbMOczOAtgjKx0bb316W/idL+oDU+sbNC8PprSw579fo?=
 =?us-ascii?Q?eLvIAxFjET5eonkEvfeINBsvJh7elEKDbWZfdrZojINg++cIox51WIGf4+md?=
 =?us-ascii?Q?Yh1zHCmosCxYmr3qjmmtw7uM4gp3wgd9UPzIlk0ycZDvoGRahNB0PsTzLyto?=
 =?us-ascii?Q?NjSTipmg3iS+QDTmKJnpVqTejx+SyRa2g3KMQOpg9Jyi/G8PHTgATib1sY/L?=
 =?us-ascii?Q?vOEi5p35Wx6ZUx9bd0RvBKNG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uUIsfjST/BHad0ShtBhQ02TkH9W4jk754IP6R85vRzdJQOs2bUepOSsxZFaW?=
 =?us-ascii?Q?/1++lBqrMc5DVGKwfrJ4AT+8SsYb3n5Z9Azlbrr5QPQmy7XRgkG/UXmrXIbS?=
 =?us-ascii?Q?ZhJ9OicM0HCV9JCek4nyKzl0jKUBKnGVD0yqIzP1661ayU3fQ3DbZHnzpfsM?=
 =?us-ascii?Q?5qQDOEBak9g1otEvN1RZzosW4gKHAq5ShVbBEdKDleyi/Z4MNXfJWZlMC917?=
 =?us-ascii?Q?WJQXJx4gMeLPGW2CSdTSoP6dBtnT5Y5XVIAUD54Q4SHeXkZd1KrHzVx4vqeE?=
 =?us-ascii?Q?CaFrNQqs1VsedTgdPk3+ZhEt0AKensqKWtvE0le+rzzwNdlVuQLcr0qaIvj4?=
 =?us-ascii?Q?XnNu8Rr4pnRp+ct3k7H2al3mf9ksYDfM8lcgiDqIcEQTXQU6ijkzAjF1G0vX?=
 =?us-ascii?Q?kclIYncLNMouOC8W9OKlqcQIPpdDB11LnLttsAsavYc4qHCrLjSw9r0qehnf?=
 =?us-ascii?Q?AWE2v5wHBJOa7jv86dCafig4aBkoGafFNqj6kM3kYMbnXmLgr/r8bBXcR3jD?=
 =?us-ascii?Q?xulqxqxqVRo/KCqezoxlHCowT1d+BuoyWIzsvkmsusEdmCHXwXW5vaNZm+SS?=
 =?us-ascii?Q?gCiSV/Jxz2Hg/DLhp91sClRkZfq6WZWqiFB8iuEiiN+HwX1iNsRkAHkQzBOY?=
 =?us-ascii?Q?mhikdL4c/PF+Rdky+WJ3hN6qOOz8XXtBWk4NDTJMSuZfrdgkG7qQqMhNnJdv?=
 =?us-ascii?Q?vIziNKY9k2r98azJOYO4Udo4I/FvZ7PW9LgFIm+5SSHibm5aRuM9rM7c+qNl?=
 =?us-ascii?Q?A1DVSKFHbDwAN4pkmmrxLZBWOaITyjb+Ri+UpSs8ZFehxNDdd2upW+twymlJ?=
 =?us-ascii?Q?QzCC1U4KnNkm4W6s3MZkVYjkhcpoOzOox2Pk9r+kdyZNWmYegwN5wtMOAGqV?=
 =?us-ascii?Q?2qrmLzWNk9ZNK6z2Dfp5BpnOD8l5i6eGlpR9GMJAU5rdpROpnzpmi84yUt/R?=
 =?us-ascii?Q?foDxv2f/X/h/g9/DO6X00IITkkx18aDDkWMIhvBoW4m+FNTeOAkdSzDOiKGV?=
 =?us-ascii?Q?PTGXnNNcDSeA4ButteOskEtCCFl3XlpEnq3lHNDoGevqBCJH6brjFKs4HEiW?=
 =?us-ascii?Q?lGJBARLcnAwk0/x21Zf1mCyRxeLr9nMksf9RNDr4DNrTu4A5WLWbcSw9aZg8?=
 =?us-ascii?Q?UWPuki+Gc/+PxUaxr+Oc9/pCPRUDA9qtmaBdAJ017GX866+WeQ4FJ5W9VFny?=
 =?us-ascii?Q?m1E2OS9remO8njslBp+AmqL41XDCmxdFzCziebmKtMmmircu3zW6Gu/zh5Iq?=
 =?us-ascii?Q?+o5qys5tO5FfiM8Ck9hByqf2scjOw9mAlZYLnwsOFKqHZmRrvsi3Iqs2484V?=
 =?us-ascii?Q?lG1lJ10h+ybYt99iO4YPFQ+oZY+b37okEnCVZf6No/N4IhrkMhEOPamYeZgk?=
 =?us-ascii?Q?8A2/6KiE/mNGCt50wqeFplPWGTcRuugiw+npNLady620kwf+yTGlPohWiKQn?=
 =?us-ascii?Q?OBjrAUmrxMgoUcnsFwre0bDEsivJq7qqZtLFD+QLrt5NYEhq4y8D4FYZaY0A?=
 =?us-ascii?Q?YUDhm4ru69z5DlEg3721omLW/CGkIjeFzx1E0mWME59bsGnbRVlIV9rJL4wJ?=
 =?us-ascii?Q?AkbxhdhC1pLszaSMj6/dfhbQzugTu6JLRspuo2zNbtugFwnfMNnWI1NbhySM?=
 =?us-ascii?Q?qQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ue9802pdGu6dPHNdEOOccs0h4W9gNvSTE5JFTZS1iZIRh6wLwgZFXGco25occstG5bWLOjax5qYMleI1gddAhP48MV8/c87CEqnm26mG3evQ5AQfH9lOysL8YZrkrefLMlbXAfmc1EcgXWcY3fVWGZC5/gjzauNgD0FLLDd8GFIEOkZ28plKmROg7sR8pEgw4Q6kpHM8Vd1oQRiKJX1me8rWIT5IKRdiM90oHjt8GcKofh3vau8+aFeVGt/y/VF+zIGEy9Wg24OKgVvM7eTPVl9IbebzLckxYdTbE1Krp9tgI+OBoIT8IzFgFexNx9t1DBtFSbdtwkpJMfHnaMEJCmq2XOUSLX/QtWN9gGgFtw4EOMdknxlgyFmbiEKklE/hzK5uuQaNFkZFeQaG3bMrmwL7gGQMZfn5DFkQerxh44rrCSH+jYk4G9jfk906ydtFmmkdghcOYV9HHnojK4MNizuK7/MCS4XxPUYCodRRqimqduucqDvwukkP7Prhi79ELJY3NCGkCiLXszbg0OeiU2Ui2KwMo00nUYkoRbDUWad6Xv1KuY8iTf+4ztU3JqPxTMzGDYfDsGnmRX1zHKGkRGjC9q0N7oKU1NxbCZbhk3s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c396158-61de-4fd3-f80b-08dcfa56b33f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2024 09:22:26.2318
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5AkTdw4pGde9z+CetTA2td1zanHSFhONSsWBbZzcD4B7jVFjR5Unr+lcHfrREPGf3NC+JRsgfnUyC2GgDvyNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6729
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-01_04,2024-10-31_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411010066
X-Proofpoint-GUID: zbUzEGpv6BQqncDGgmC3Behpku2xWz_C
X-Proofpoint-ORIG-GUID: zbUzEGpv6BQqncDGgmC3Behpku2xWz_C

A bdev discard granularity is always at least SECTOR_SIZE, so don't check
for a zero value.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 7719858c49bb..f21f4254b038 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -789,8 +789,7 @@ static void loop_config_discard(struct loop_device *lo,
 		struct block_device *bdev = I_BDEV(inode);
 
 		max_discard_sectors = bdev_write_zeroes_sectors(bdev);
-		granularity = bdev_discard_granularity(bdev) ?:
-			bdev_physical_block_size(bdev);
+		granularity = bdev_discard_granularity(bdev);
 
 	/*
 	 * We use punch hole to reclaim the free space used by the
-- 
2.31.1

