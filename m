Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B381A225785
	for <linux-block@vger.kernel.org>; Tue,  7 Oct 2025 13:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759843930; cv=fail; b=JZDiBG3kYH4wsvOIgqSRLTz/PwK8TSiwjpSgqGl9kAdOFM+zCWQi8oxTzrvyv7wCAZTDs60B4J1QRAjhdgmdnyz44YzNtp9gxhR8JzOHHSjZPODxtxgd8IEDCCrTgk+gjjTWVDwdp+Aj7ksk6XMeJkrRAxq4bdfQX+gtExivqgQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759843930; c=relaxed/simple;
	bh=hb/ghTDtv8qOr5RRlyHzMPxhTyNA4EF1W0h/HlVLm3k=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=BzIsC9RWSaIMtNHkNdKvvDO8HUiUVTzFttpl6YWfWYtoFcTSmKBclXomr0uxmweqmRfp+Ks/lDq9VJSMTxJsPk2DjEMXz30MnjHq5ezakphOWvEAHUL6im9txiNFIeXrMUEteovowVKIi/UumDrTRR78HCCgwufcNwA26Y8oJjU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FZbyMiHV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NfZYi0Cm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FZbyMiHV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NfZYi0Cm"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597CR3Ys003281;
	Tue, 7 Oct 2025 13:31:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=KTRWuMw7AIBxfZCYWs
	j84+L31j/e+64PYc+3Qygo3S4=; b=FZbyMiHVSRk9BQJM17KH3ViPyjnmOmU2fF
	LqJyKvvEKvTl0h466R2H4gZwdNhT35LgwHWMRQTXGzR8jOqLOokmCIF3d+eEifA9
	1O2DIZAtqqygncsA4JmhUXAnIDaB+UqShtczqa5sRDGuX2x8pgZmmNTIZfXprCmu
	gyoKkYRfsp9xuY4W2o1YVUhfqq+LmYpAGCUnAyBmXjIQD52nYa0EcGr2rCFcSMYg
	uxan3yWe5bJ4IjwuOhJ1qGk+e7BpTo/RvxCm7xfhH6v7M1geiL/2HJRHaRXt1PDG
	Dos3iXOFW1nAKBL6fizGwNd3Lnz++bG36C+PVFyAdHKpP0/P6r3g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49n2vmr4hj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Oct 2025 13:31:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 597CI600040947;
	Tue, 7 Oct 2025 13:31:58 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013001.outbound.protection.outlook.com [40.93.201.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49jt18f077-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 Oct 2025 13:31:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S4SlZRI4d36gn5GStwo8HDbkCEvAe40zOo8U+YWNpk4S9vjRNp6xIQC4lJ3XZanCxkyU+UqdHPm8H+acFbhk/kvqC1Yy/83VqGgqPNLDNF14wTaKw5SMMPt3DRYZgLf2YOC2/YqWdfIgruaoTZsjfZO9zYaHXrwv3i8azl4T488Km4H5Pp84hCxay5t0FEVOAL8J8ZpxZ5CIdvp9Zw/ygPEarTbmc0r1JfaT3KriYWe48UbMGl7kgVv/RxxCO648AJxUx9z0qXSriUAR4PxqsMeGKwdUCKcwhoVqYMTiEcfSm5suT8SBDYq6b12zDXiMTxcaXuRAZC2U8t9Cfi+liw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KTRWuMw7AIBxfZCYWsj84+L31j/e+64PYc+3Qygo3S4=;
 b=dRPlbEiegadkcQgJUlF6tOPoGTpEXr9Rx38+CJ5669JGRblgaE6tAQLgHzT4oDbEqaT0ai6CoO8sY+rgXxL8BrguxVWGQuBMrhgBKi9a2ATstATytAbXQNYiMco6Ts9KzTd9J1A3Q7aVwX1P+v1EkRUrrVNPC8Kn4aFH7sdrKr5NXKVogMZBNYlmbkp+VqJbON4nJirZ19FsfTEyVUHLE3f2LxIvueH5kHQMgwivlhdyq56pITSzgp9ET6G1SFtYnvPEsuTRpAPZTUMy4YNJfu2MtnaIUyqC5d071YR97hH7ZCeQBg0LGZo9Wbc6VO8UDbAse1YK/aZBbxlfDsf0yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTRWuMw7AIBxfZCYWsj84+L31j/e+64PYc+3Qygo3S4=;
 b=NfZYi0CmPc+l89f+7gSwG0rEahDQpplggt0bPo5N9Gz9DrBhiSySUDu7bDikalV8IFcIiiPoxjeWHxurWFSLWSrK8vfA6eBWLsZrhGn9ZW5drqSyZqK80Uo/tjSYPgQO7Wyvos2aiDSB3f6wlCVHH3uSiQd8IftngCnoX5tggcA=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by SJ0PR10MB5744.namprd10.prod.outlook.com (2603:10b6:a03:3ef::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Tue, 7 Oct
 2025 13:31:54 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 13:31:54 +0000
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org
Subject: Re: cleanup for the recent bio_iov_iter_get_pages changes
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20251007090642.3251548-1-hch@lst.de> (Christoph Hellwig's
	message of "Tue, 7 Oct 2025 11:06:24 +0200")
Organization: Oracle Corporation
Message-ID: <yq1qzveet3q.fsf@ca-mkp.ca.oracle.com>
References: <20251007090642.3251548-1-hch@lst.de>
Date: Tue, 07 Oct 2025 09:31:52 -0400
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:1::33) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|SJ0PR10MB5744:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d8748ea-a741-4026-acf4-08de05a5e179
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P7mRS1TZvZkZb8AF9Pj8WNjq+EGvG8JOpY6Ob7XkRGCtFM/vqQn/qv6eobuB?=
 =?us-ascii?Q?q9Bato96L31iPjQtA6aOib76KLL78RTMN4cHuimqwKEQsbKpJaDZqUMIiugE?=
 =?us-ascii?Q?ogGcyOYmbGuWzdeFXN6jDRYqOekBSwglxIXKh4SnJZxBVts/LGpVHzPxomV/?=
 =?us-ascii?Q?i4AqDmJYehU6bF6VzA6dYZkusD2FUaqO54wzyJu+xK1n0WPkzfWY8YXyzIe+?=
 =?us-ascii?Q?lectPzDUZc4CSwbyF8nT6kIRJ9Ew8BYn9RPNzs+K6O2E0ZIuN/a0PTegFohZ?=
 =?us-ascii?Q?U/+E6NGRS7qd+50Yc/dfGJx6y/D7ZjQCBQz7STWxVL1zAzMRJMzGBe/It1Ni?=
 =?us-ascii?Q?VLttn2joJxDegOASyzUhqGZsQzciPEoMeltvTVomm08Ef/6QhRxXG4qwvsxi?=
 =?us-ascii?Q?KT77zyOjr4pIxg7r7kofcYgpBbhK0/0kdAJdk1XN1hAEljhOGYJbc1Jj9npG?=
 =?us-ascii?Q?JaPmaqyI38R9yHJKD0TUiC4yT9DERfi8VLtWewon7kn+BxFCt7mbxuHPY62a?=
 =?us-ascii?Q?PDYQfMFsFbKkaloaBLFmktQE5LyWIvzpVCmm8ZsS1DMPmhOU7JOl7WU4WnSO?=
 =?us-ascii?Q?dy7Fy+YmsU3EJkz+aVPoSs66bzRAxtY9AWDw8g1PyXYnVoIMLQW7NEORGUnd?=
 =?us-ascii?Q?Tk46FZiAMu+hgb9J6PPCDuHjX++jgG5fQotDf/Mwbnnzv2sFiBGajEpSLnh1?=
 =?us-ascii?Q?wmg/zNT2z6uIKRmcUG/aQrrsYwqKRA7rDHZtobIloRYB4LlgeaumdkEfzW+l?=
 =?us-ascii?Q?S/jStFFy7xV5KXJAEe67U9CZUbGAXQwquQ9bDRnL9+IIUwwIlXfD+Dmx5o+b?=
 =?us-ascii?Q?TU1Hw5GkXQortOMgY5B0EdjpShgyntYQpc4Z7Z/Y9W0QOIHObd6IBp2ZHOxK?=
 =?us-ascii?Q?asNLXN95zicgRkrCDjf7k1rS2OWuCWa2XcCRgVwqCHo+EvEIrQL348t8q62v?=
 =?us-ascii?Q?dGiAGSXTYv6HChyjSzJs0S+Fa5Z9jxOGQU0n9PJTcQe4Ibga2AA7vidCXcIC?=
 =?us-ascii?Q?lSI6i5JRZeXVpGjeGY0nxfoR+8iUCvAKeuporiHfipEXIq31uM/c0zMErxC5?=
 =?us-ascii?Q?pZrGOyC4XdvEUa11wXY/pMgR/2uBq5boVAe5adJC0ohB0g7DmltUh4SMjJfw?=
 =?us-ascii?Q?DzK0+ip4VYFd/calqlZ2OB80/dcPn5LPipf1Zji6eJQVGkdbSzjqU00g/cDB?=
 =?us-ascii?Q?r4PzKHtwEoWr6lHBr1gYAXMUiX757J9thvHY0DtZ2YtuqOe2bCfwWUP3df+S?=
 =?us-ascii?Q?L9krQ3EEH0qvPJEEoMc7FxInNXK4tfdtnR20EzKcD/qV1Bs9x3xYdRRYSGg1?=
 =?us-ascii?Q?HjpUHuK+1OwjKziqV8f0j4tg+X6eKLk8bVzE1Ji7CU58T9vNvKzGlixmCZyj?=
 =?us-ascii?Q?VwCDTQOSDNw4IhsH+OVv0aWLdHoudGCcPpqTszewJdcnoULCjdUUirLvqPuF?=
 =?us-ascii?Q?UDbvdSom97EBJ5WLGbhyE0gJW+H68pyQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0uyDMRBvGk6NYvMawQpuQh3Q8BT0KHnQrmCyQZ0bAK8AHd5HLBorBmxejbs1?=
 =?us-ascii?Q?1GtxzEyKK3LLvfEFiULvo8B/tA1p6RRFTp1JTGMBhX4zDCTwvLHLq23oxgv2?=
 =?us-ascii?Q?M2x8uyZQLSMf2q8vYLlEGkTn2gSu0U0hx61ncFPPYcgW6SGIHr1K46x8VOTW?=
 =?us-ascii?Q?ogtdj1W6CtjGKQIi2mS5N239AoEfqBypOZFHTIFrdZ87v8gUe/WUhwTq/ek5?=
 =?us-ascii?Q?wWVGJvPQm3BF2zrbq324+0usNXCowHkOLoJ7Y2ZI1RSayYWIhk/9U5ZuQxDi?=
 =?us-ascii?Q?pZItFD2kwF5TyLG4VYbpA8wELTdDee4nOiXSZi7D/a9aqaKFH9xIRZc67PJd?=
 =?us-ascii?Q?bEPuQMMGfoCMMsUkVr7G4enFVj5ai88pEaPlXjKT3jXaDpsN7DwyLw2t7/EA?=
 =?us-ascii?Q?L9hUk4CYSpUUEkLvrDw4gPbRS5PGjuav+TX6NGZJweWOels80hLCwdzb8ysg?=
 =?us-ascii?Q?ZaEBfMf/2jXWTxUk6jHWzSG70QlK42xm6nysAZ83OCBVd3HdMhDA5mcnbUcK?=
 =?us-ascii?Q?TDl3mj4wCKuU5NabanU3wjhjFUyCPbCqfw+WM5+XVk2BSmQ71uksP3qnNqNB?=
 =?us-ascii?Q?uBNUxRh8qQ6BxZIHhtpS5YF9QDHUNuNBS1yjl7DPqaRS43r8FBgvSJvrfQwR?=
 =?us-ascii?Q?jKGmRrypdtRIp7xbg50QFWnC4pn8wt/VG4c1FH1A6JlEsTGxAOHV+erurPuW?=
 =?us-ascii?Q?C1YxRYaxZVoI8jmm/KaTQF+nWknm6iuwOPKcZnEuqAA/CFoMQM39bDRuBm5y?=
 =?us-ascii?Q?nVqRfhmPocapV++zZ8/nBdfa9Xb3IosFqletoUITpPs/hvpoikoP6ix4CkS2?=
 =?us-ascii?Q?0ZRFBcRTRtmkrb06m82e2rznrDhKn8nUwRIJ3P5OB2V2ox0w3r7QseWMtZBl?=
 =?us-ascii?Q?NLNFV/WkI1nI4A45VbmYeN9WVsTiQyE63NIY5uCWsVfg9I24D6IciAfswI0p?=
 =?us-ascii?Q?lNTJkF2Z65EnZJ8Yw4GgpBC3wW1hb5eoFukxx80D0Unn9aywpxBT1WEPiq4n?=
 =?us-ascii?Q?/WaipbJzVs/RQcf7vsPYu+HHOSppOrsRnhzZ5n1dPh52OBM08VarM4kAF6sB?=
 =?us-ascii?Q?tafnX590pxgKT39vdYQAxeMp8KIdz+wUbD5RlWSBT6DagzAWCmcDiVEzhZtf?=
 =?us-ascii?Q?xgz9SaXe5px7ofT/pPh6Q8W787m+ztA+mlZJscEkXWw0bMvnCKyARldfuSmZ?=
 =?us-ascii?Q?W4hswbuOP6gYMJn2YlnLEB9WbHRD+oJQv0GNxDi2CrNoqDPO3z6yDtI7olSP?=
 =?us-ascii?Q?lXoUTYOi5/OC8C8tuAo2hU6GYumOLEOV137vlxiz97nM24FUBacD98QGrtyv?=
 =?us-ascii?Q?kiMjD8L6fAAjvLzLHex3OG+WZmG6efg+SYfX51DguoZTZxr8hHixTv86/xFW?=
 =?us-ascii?Q?3xxAJwrPMcv8HNxJ4/5LtLSgVIGKD0nvHipW+X91xuuXY4F/pgYf8JwNOpIG?=
 =?us-ascii?Q?paD5sIyP++jRW3wcVPfS92d1NEyfDyfFQQLKzB5FdtvUFffPyBLvIVGLKaP0?=
 =?us-ascii?Q?TjOWWJaA0gRw0M1i2seuUgWdqsvqN6CXu4/Y9LNcQ/rrJXcigEBlSwQzqGUL?=
 =?us-ascii?Q?Q53xZLsyIz0mGXeHZ9aXC0mMHntAcCIQ8YHb5PuEqO+AuiKeThtN8ybQPn0Y?=
 =?us-ascii?Q?GQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XehPZrTUbfYSWhwBFdwxUcxvRcoFavt2fIAixxOWjXCsZSvUZ/qs/7AuvGpHIV5n0DaAPKG1pIzHO6VlJ1Y+TuVXTt9mSuDP8zno/I8lT0cvzb46BUDH8kykZ+zKvrrmXt8IPv5WaY2BejDrZgYECJfjg3aK71+t9wkfiKKWewctf4RpHNT90nsh4UHoo49tw4tnkNFZlnXL3kq1zvig3e24AkgEfjdrPLKPisa7ngwU6F30mulQA+h+r+rsxsJLcXiR7P2sVVLwKAg9kY79MLFsRA2Tqy7Wi97Ra7aw94iidCslecDoW8CjiTn6v2iqU9y9jv4r+lwtGzIP4t7tjWXprs0AP1EQlWvZuk0YDP+gkCOh9W3COxyYucINTBuLerGtyDlkYbUcvwAmT4nyou2O60RaFtklR2rsuyDo9QseAV9VFXxPRvqUJkfHQ7s6s0AyotYjlmNrE0ovvg3EUsHWfqAs6kDvxHFcTBGZ2xZN/Fo07xhTbFFgXfhqfgKUiOKpzTTQpKsnF24A4PmlsJUFCLpStb+YQY++RqBPBRc6eULDeZcp34b9QIGoHAlMBxxe1CTbSqQMiv2b+bQtcXXZ/SN8fkqhz/RxohZYTaY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8748ea-a741-4026-acf4-08de05a5e179
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 13:31:54.5356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g4w2VAfpSQ7BCe6UZPeNUjmC1qKzKzUiGbSQFJ5qIfj1Q9qGBCM8Vr9bfAs+PyOY0jHWRnB29jxxybc3JLDwa3hKv8ORMK0INxu67STTOQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5744
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-07_01,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2509150000
 definitions=main-2510070107
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA3MDA5OCBTYWx0ZWRfX9t4AVo7GM+0f
 IbzvEK8+0g0sDMWfgRklkcFwaXLFkx/iBusYECL5X6PGjCZ4p4rZB4BzjdcspN1p2Z/mX+THXK2
 B2VZqcatIunRmucXFCsUl47i9Rc3gHiKIcm5D5qk82f5sWx4Ovj6kuI1oufQwSAHtwWE2Bm8rJr
 eb51+dYMd2eIYV2ecOkcNxcNbwXGcN7+tVri3x/5Jhegjc9cQUAgBUabMAv7PCWX60+tmbG9rhQ
 O6FOYxlCNKziNT8VUxQhqcrPOUGFXIxL/l0TqAJVVRI8DAh0QP0aK6uGGRMv45aIxJt5oqtQ6Tn
 dWSsjqwacg8hfxkvaV6WUJRKhmnmVrj4SkYCJYD0RdXgDpo6WUZC5W3VTOFphq7Q07jerOYojev
 /Uu7O5O+9ttk7rzTENW/dG2IGdjiSw==
X-Proofpoint-ORIG-GUID: 7kGS9fkWUfbbuGxvw-kEXnl23BS2WyW5
X-Authority-Analysis: v=2.4 cv=BvKQAIX5 c=1 sm=1 tr=0 ts=68e5164e cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=sH1x5jTS_Y6LtL2x_4sA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 7kGS9fkWUfbbuGxvw-kEXnl23BS2WyW5


Christoph,

> while looking over the bio splitting issue reported by Qu, I noticed
> that some of the recent changes to bio_iov_iter_get_pages lead to more
> indirections than really needed, especially with the bcachefs abuse
> now removed in 6.18-rc. This small series cleans this up an prepares
> for the file system block size splitting needed by btrfs bs >
> PAGE_SIZE support.

Looks fine.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
