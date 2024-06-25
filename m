Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A231B7F7
	for <linux-block@vger.kernel.org>; Tue, 25 Jun 2024 14:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719324672; cv=fail; b=fmEHY/Ztq7xjrJwBpPXmV52/NxfUDIXlWb/xKvv6ER5zEROiWegwc0bjlrjS38KvUDthMsroSmU35gGER+APyaeOKctqoKdcHW33dtW6lBrbt9OVHzzjZ+TrN4qkQ6/HcuPOyY27PkYWKvMaX20Kclg3gp+KR3weTWFbzUKcZik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719324672; c=relaxed/simple;
	bh=pwceriFwG+J96TXb8Bgt/8hgbOtyzH0xcOESjGiH6Ng=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EVizI0l4TJAY/0Kt8DF5vz4PlewyJf35d9gBmpVkeK79z96ZouwfqyUxLF/Hzxo6TRf/mHa6NFYqGm781FnQXCJnmhi7HEVfPKWBtqcf5ESv+82GPTYefCVZVnXhJghI399gVI0XkBFO9Dj6ie3uGzLZ8CyGbtKi4WcYQJB7iw0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kaRBoRx0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KDivX7Xj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kaRBoRx0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KDivX7Xj"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45PD3X7T018750;
	Tue, 25 Jun 2024 14:11:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=n1fcE96FSpl4kVOvOLbdLIpgL362eBEX+uQfZZIRzPw=; b=
	kaRBoRx0fXI/6YSgjHqp8bVvoNegYvvWX3lldTs+iMOY5agBvbU4b+OXp1jBEEAf
	GFfTbPEWyyvmVs15G2tEtSj1nGppgiVDmPEyB03cJrReYz6Ckpf3/q6fxkSA3Wg3
	gBNBd0zacHArhzR3JnOyiXunF2pW783WC3jNSu0nENEa/lrd0yKT7lIob7SGOl6r
	cZ8tGS+gR8pcghf8Ggwurszjz795GBrFD9hOfaeXpBCEi0VVot8DovU8htsmlQtA
	k80XfafCRgUq6H+7I2qyyL+VoJoce35K/t3H97nHHCM5xRTkrR4BSpIgsN6du16P
	kE1XPriYcnN6E4QDaqBz8g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywq5t0u6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 14:11:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45PDns2W021530;
	Tue, 25 Jun 2024 14:11:05 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yxys4hge6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jun 2024 14:11:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FukqKHaARlhRcfktivTNlXuCJBQkCA8rx9plA/VUpB2HL8NapuKInjWyaLoqMDGg4NNUbY6EI53w4I48t7ZhZh0b/vJhXLr9Vkpcu8hBZDGUINKcTRvxp3W+thL2JgMysUCsReyXglOGehX5RtICSNzKf1p6xNocUTME808nAO2Jw8w+TNfYtaq+2ZvsRPuUSsFDLBTOSAo2NRsPqJV6VA01qCBCL8TCWMkC8+YA6ci39RDqRpeqf30tRXnfbr9zBXg6a0pTZkyvCcFuzN05JATtpkoTE+nAd6ZeMGOW1Cpg50UrY7VnAWAnFfgI1BkXOkkFub11mHAK0hEdcasHCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1fcE96FSpl4kVOvOLbdLIpgL362eBEX+uQfZZIRzPw=;
 b=NB1Hhqb1hh4DnVazInpP7zliO6fY/8uh1W7HpyKy6CXK+pNoAnTq/JAPKDdua03J3TQbhQKQ7wrPPsoJ0Ki04h+SrTo5GOivh/X8+cLS+XlVNFs0Rw8W7UN/TZ/LR5IBqoQlE8GyX45DG4J8Fst+5vC5lUeIkY/e9ghmm0rhDEdMkSzzzbBLBGyaI+wm7Hh0tINZ66RY+AG/1YX0WFyZdmWX7dNbkuv7Lg4Xb7XMhDWm6AZT3hmNS6fA/DHS1b8fZv8vc/iv/k1mhgoU//M0OouE3kha4R7HaZDjM+YxrBUMOONo/RREUcc7BZaunDXoPeJJs4T9p11yARKyHJv8sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n1fcE96FSpl4kVOvOLbdLIpgL362eBEX+uQfZZIRzPw=;
 b=KDivX7XjPN8V/nI7muceDvMv0dw22ZaLECFBDjmY/Bieyqwr6Y6QViWsmM2pRdjd+01cQxiX+wO8V0t/x5Vo6js6U7QNqT3Umzoc0d7Jpdr2oaegbyUKPnJe1RovP5iqjEmUS5NFmNgC5SQ4ml7qVXW0idzFsBtvnRw8sY066YQ=
Received: from IA1PR10MB7240.namprd10.prod.outlook.com (2603:10b6:208:3f5::9)
 by LV3PR10MB8105.namprd10.prod.outlook.com (2603:10b6:408:28d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Tue, 25 Jun
 2024 14:11:03 +0000
Received: from IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1]) by IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1%2]) with mapi id 15.20.7698.025; Tue, 25 Jun 2024
 14:11:00 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
CC: Chaitanya Kulkarni <kch@nvidia.com>
Subject: RE: [PATCH blktests v2] loop/010: do not assume /dev/loop0
Thread-Topic: [PATCH blktests v2] loop/010: do not assume /dev/loop0
Thread-Index: AQHaxvGqU8FGkoz8g0SYpqchRgg6QLHYbczw
Date: Tue, 25 Jun 2024 14:10:59 +0000
Message-ID: 
 <IA1PR10MB7240EC86C6A11788A324915898D52@IA1PR10MB7240.namprd10.prod.outlook.com>
References: <20240625112011.409282-1-shinichiro.kawasaki@wdc.com>
In-Reply-To: <20240625112011.409282-1-shinichiro.kawasaki@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7240:EE_|LV3PR10MB8105:EE_
x-ms-office365-filtering-correlation-id: 18d3cf92-69d7-4607-5900-08dc9520a3d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|376011|1800799021|366013|38070700015;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?xTYiiIg71xHd0Gs17mdS9QqybFnnybWgYCrnZXnKxKQF+qw1LoCmlFQ6U+ED?=
 =?us-ascii?Q?gQTDxXJ6yYrOTjQ7HUn6yN5uoyuYOLTwap/AV08u3BtCfYAS+lrjXXZzckpK?=
 =?us-ascii?Q?r/BUBcKor7ODiD0oVnl2iNw/a72tcongrsDaRrlEpQVEdvxDi7jtESR2CHGW?=
 =?us-ascii?Q?IIvaessb31hFSKM4TPs+sVgCDBSA6tUFxouI0r6/NH0lBVRKMT/NNcPWWL/8?=
 =?us-ascii?Q?KGJv2caGWmwz9/6aQcs1zmE/RaALShfvwkiv8wKalHBbXuRhZDaRj16Z8ODX?=
 =?us-ascii?Q?9YnAY82b5knGNCYvTFLt9LCsVMhAgO4GweKKWQO1eOxBS6HV2zSTo4TJrBle?=
 =?us-ascii?Q?SRZJvZkUUWd+9kc/0g5Gl+UJ2yZcud2O1sQjTcuywQEu6k8DAuIPLAFW3f3r?=
 =?us-ascii?Q?OR5SsdusN/QgJXZr4V3HClDlUvb3Q6e2MrpF6Q1Qg+VHwFxEk6Rll+BSwT9S?=
 =?us-ascii?Q?bzHEgn5TjDcue+PhhMfQ0CmHcV3N/834pKMOW9jQD+TOou1Dak4Q7tChF/sT?=
 =?us-ascii?Q?q5mQV/a55LD2EwElk1/ezrIKXlmQiLKG2gMEdqaTKFSfc9q36iZEIMRRGKgO?=
 =?us-ascii?Q?5q3lp06cgs/zBsKnRGdUH7UBmiNg3+EEB4/a4DsXfR2I3tHMB9sna2xkSTUj?=
 =?us-ascii?Q?neEW4D4nwEbPP85MsBdvtYY9LZ1JCN7R3HhmeVB9p2vmQ8EPVEklrezXI1eh?=
 =?us-ascii?Q?W+CtfNxSOH96p4iNPaiPVOOYSFeRYay/rQZPCbzhJZ9dapr17tPKJtH6B2HI?=
 =?us-ascii?Q?ZDYwQCiT2WTC0FdyrYM5LqMVkh1iZgy+fou4k6THfxCwO2JpWKIrCXhqeJXp?=
 =?us-ascii?Q?a7h6JlLBdexnqEr+Che5O/cQ7EfiM6YCEilFvvaSX9NslHeWb1kP4R95+4cE?=
 =?us-ascii?Q?n1zxxx7RxlQdpZWRR8p/d+I73OeK4yVFKQNDK4qOYXu0laGD8S+TntCVkOsS?=
 =?us-ascii?Q?55sckf4gf/Yvq2naX4SN2X+Gb+2OTZl+rHmlkG6kjs9g/iKJCYaI0ZrcGSe0?=
 =?us-ascii?Q?zx8P7PVIXIGGnAvDLM7S/y3bnz1UxeG6OTqB3Lu+y+fqyvw7ZUM9ZkT1jK1T?=
 =?us-ascii?Q?kOPMJgU7bGovcsPI/hpTo+0WHxZ7OqTBa38wVWZwQqlkiiyUNBzsC/+4ZCRa?=
 =?us-ascii?Q?n4ndHMeH/86dyvlfpssL8EM1DKtbZ4rrKilmMN62su1TTJrkUF7wim0Mlu85?=
 =?us-ascii?Q?+4wSpgRIcmdp96Z0PBsh6sLo2qv129CrB5g65bjsC03qS1G+M6JWG/LmW7dV?=
 =?us-ascii?Q?iP9CA05u9fxnhdE4uBdhC43dCwgfZfVFaxtB+Tg3znYTGcvrJKyMKYkbNKJV?=
 =?us-ascii?Q?rGkqy+QmohBGV8OpCFJYj3iSZgvJW/aw6RdB1nc5AhmJM8VK5+QI8NzkL1CC?=
 =?us-ascii?Q?2C6AvyY=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7240.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?GRVrLQ+jKsVaxPeYgVw6N7tGt6Ou9oklFzjA9psnJ2EdaSW9iz84BV5XMIlv?=
 =?us-ascii?Q?TtQJPYHX9Ktolrgfq8gUy3uyygIttC1buKWPr3HJz0497hzyyyGVpIkEYnTW?=
 =?us-ascii?Q?qnI3Cgf7btVI8xKpvaxh0exMrLATtK7IMiQamIJJT8R7EhU9yj6zxSelhpXm?=
 =?us-ascii?Q?lvs2cncOvNOcpwy4HMS2YlcJowR4g/yZUB0bUhCKTnzJAoISOkPocFKpQ5fH?=
 =?us-ascii?Q?aAhKB9IaNEeBXMepxp0YU7SWz8H1o75LkBZAelIVkiH0pWMQVuKr1yAtl2fV?=
 =?us-ascii?Q?EtTnZ9w0o3SkSp+MvMmZ8wLVyEinOC0Nl3YzS7eNU2a8msQ/cvQ9bvAdjLUQ?=
 =?us-ascii?Q?rKQWbMAJ3zGX/jqcx6oWCveG7Pyf+69Bu6S+KjTlGQ3jVTem05tzvgXZvmpx?=
 =?us-ascii?Q?iKln0D5gbfzBPdJcZkFLf8ZHh4HDEYnhKlRDPGqfw0FPmjdJf3o1AjifqJhS?=
 =?us-ascii?Q?kBRgNkJ0JF30+1MryZjxrpESv++NOTf73aqiE7Wx/pIiC+LvDGSJP2gdmB9/?=
 =?us-ascii?Q?l6dMKMoyuZQgzWfxEOh63wwBorO/KhJMVx9P4ee6fejXCqBCdlLj5xiSQCpF?=
 =?us-ascii?Q?Z+5LxFpGFMKKIO1wISlCIBZJEHo6wOgo2idx+0ALY7IVwnB11k1o4t29ZOib?=
 =?us-ascii?Q?uNRIIYhvShfOafBNI5nebsmntK6193txkYbqtuTlJgT/vT4aWKoaCsZqsuEv?=
 =?us-ascii?Q?OEWSJ3IYaP6fbK0SsCsr+lKVOtqK7dA6A5e0GlZNYV3HjwHQP4A5TAhWgGsF?=
 =?us-ascii?Q?m+mxxcI5lO4rHcrTMhuo0U6/ToFmlZInvKwFqX3nyD1/Wibaz9rnA1kcs96/?=
 =?us-ascii?Q?m0ctkGS4FXWyIXHMcK1cfjdLgrSLkzTGv5LX5IebEdV9drIm4W+cVClWoc1V?=
 =?us-ascii?Q?siYih+idMx6vyosRm9cgbPGHt1xYJOJQUrfJeuRibwub/1ulDi0XkjKqpg9h?=
 =?us-ascii?Q?rb+7AU919vAkhAh+i6/+Cq0cP8vScm2NRcYKGi3glDCUlCp/i4CzKHo9mfBY?=
 =?us-ascii?Q?qrn16Tp0Rajfg4pdClP3Y64mqHGuOioeFxsZzkBsHf+TD+CEGeTBWMsBwsbc?=
 =?us-ascii?Q?ySk90my9lBci1Wd6Q1Ox9wl+PoI43kx6OYdkQFa70jIKd/L18339uufPwYfH?=
 =?us-ascii?Q?RKsuPNBacmDThtmzHTd/bgyT+qW8sR2GJAAbGH9vy0dXHNN/RV+Zno/RZvtU?=
 =?us-ascii?Q?PRF4UJpYSZhLabqLLVujCWQOIWmvBWABBXlIp/0b0+aTx9a063p3sf3IO4qz?=
 =?us-ascii?Q?R40rSiJbrpHtWt7GbpyF50Wfdo1BMTkg25DZPcwiumfZU1Vcho2+nTpsPrxx?=
 =?us-ascii?Q?NPd5lb4NOQwfKoaWcD+3hkccRhzMTkEQYqrLeLy1AHn1NGcmaOOXCgXfOC6+?=
 =?us-ascii?Q?iq9E5xOZ/S8Gt3DA0vzaxu3Uc5D2Qgw/N7PTupzAISR5McvGJTQjRShi7B5j?=
 =?us-ascii?Q?YdTLB0F3HtoKC6v7Yyee/ej+BKWCYOeu4bBvsMK+mbPz+vC5IHeRQ7ArojMp?=
 =?us-ascii?Q?SzF+MY8BORzBFFFAyvY3ASg5oHBgGjA1b2YiZhFxHy+GfDhUvoobyphkm/05?=
 =?us-ascii?Q?MjdPtwxsDPGInNdIuihy3dFh6wWLd9nfSc/OndWL?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	DQrYOM/cjUi8XQQq7DJKHmFpOghOzBS00tn2D+M0RGSgKInr+755i1RtiBS6boz/MY6foXLvcvwXdXPCRs9SRWpQPCPFYPYOCOIk4L7bC9266mKbWWEC5hJhv5PYeZ66oRKmwvb8oWzbWnMM40LBR7pEqPKVcv6p3o59M+upR0mOjnrSL+XLb6hDdDVhIRg8WzNCHqElI489yZ77k41ZLgNe6uv0oFUhcQLcdATC1mfkFeZeYiB1hfSlPATqR+hq9NxSEBx32mtzgc5DKbg5oBLrxayFPVBWQZFfxJh4i6oH+pVjDnUUoeT0o+Rs5uuV/6XbepV4GqS4HdnWCPgLxFrlKMjzzzwljb7emXzDiTYPGhFFa8ilFWFFYVsFghijFNspFFC7HQr+5E8TRNBXelKDhz+CTPL6zbOU6URGiChU0vXVWMqS2CgJ974cJ6CNcZAfM2ddF6DEllaXbcU2V5oKE6sVpqzqg2PWFcBPG6x+s1wEvmmCz5QfFRL9NOyze3Aw6vHaE60KfD8SxszAK4rrnT4Oj4aZqNugm+fPGwA4IpzRUDZ3emMk3YD6B+VFcOZ3rbDe0g3Su1ub5XKaMvRqFvtiJ57wNaV6+ohlAFA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7240.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18d3cf92-69d7-4607-5900-08dc9520a3d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2024 14:10:59.9519
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BskmyUXedGsm6+3QYkCCa5s9U/KZKr7vJLdBttlBD0eRK+c6ZL037CpxlqVt1dOTKDK4x8gu9ixnzjocF68f3aLzBTW386p3o0lS5Mnn950=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8105
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-25_09,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406250105
X-Proofpoint-GUID: DdJ8JTDAUxTLs-leU-mxXOCsl7Wy4UUa
X-Proofpoint-ORIG-GUID: DdJ8JTDAUxTLs-leU-mxXOCsl7Wy4UUa

Hi Shinichiro,

> -----Original Message-----
> From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Sent: Tuesday, June 25, 2024 4:50 PM
> To: linux-block@vger.kernel.org
> Cc: Gulam Mohamed <gulam.mohamed@oracle.com>; Chaitanya Kulkarni
> <kch@nvidia.com>; Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Subject: [PATCH blktests v2] loop/010: do not assume /dev/loop0
>=20
> The current implementation of the test case loop/010 assumes that the
> prepared loop device is /dev/loop0, which is not always true. When other
> loop devices are set up before the test case run, the assumption is
> wrong and the test case fails.
>=20
> To avoid the failure, use the prepared loop device name stored in
> $loop_device instead of /dev/loop0. Adjust the grep string to meet the
> device name. Also use "losetup --detach" instead of
> "losetup --detach-all" to not detach the loop devices which existed
> before the test case runs.
>=20
> Fixes: 1c4ae4fed9b4 ("loop: Detect a race condition between loop detach a=
nd
> open")
> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
> Changes from v1:
> * Replaced the losetup --find option with the loop device name
> * Added the missing "p1" postfix to the blkid argument
>=20
>  tests/loop/010 | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)
>=20
> diff --git a/tests/loop/010 b/tests/loop/010
> index ea396ec..ade8044 100755
> --- a/tests/loop/010
> +++ b/tests/loop/010
> @@ -16,18 +16,23 @@ requires() {
>  }
>=20
>  create_loop() {
> +	local dev=3D$1
> +
>  	while true
>  	do
> -		loop_device=3D"$(losetup --partscan --find --show
> "${image_file}")"
> -		blkid /dev/loop0p1 >& /dev/null
> +		if losetup --partscan "$dev" "${image_file}" &> /dev/null;
> then
> +			blkid "$dev"p1 >& /dev/null
> +		fi
>  	done
>  }
>=20
>  detach_loop() {
> +	local dev=3D$1
> +
>  	while true
>  	do
> -		if [ -e /dev/loop0 ]; then
> -			losetup --detach /dev/loop0 >& /dev/null
> +		if [[ -e "$dev" ]]; then
> +			losetup --detach "$dev" >& /dev/null
>  		fi
>  	done
>  }
> @@ -38,6 +43,7 @@ test() {
>  	local create_pid
>  	local detach_pid
>  	local image_file=3D"$TMPDIR/loopImg"
> +	local grep_str
>=20
>  	truncate --size 1G "${image_file}"
>  	parted --align none --script "${image_file}" mklabel gpt
> @@ -53,9 +59,9 @@ test() {
>  	mkfs.xfs --force "${loop_device}p1" >& /dev/null
>  	losetup --detach "${loop_device}" >&  /dev/null
>=20
> -	create_loop &
> +	create_loop "${loop_device}" &
>  	create_pid=3D$!
> -	detach_loop &
> +	detach_loop "${loop_device}" &
>  	detach_pid=3D$!
>=20
>  	sleep "${TIMEOUT:-90}"
> @@ -66,8 +72,9 @@ test() {
>  		sleep 1
>  	} 2>/dev/null
>=20
> -	losetup --detach-all >& /dev/null
> -	if _dmesg_since_test_start | grep --quiet "partition scan of loop0
> failed (rc=3D-16)"; then
> +	losetup --detach "${loop_device}" >& /dev/null
> +	grep_str=3D"partition scan of ${loop_device##*/} failed (rc=3D-16)"

Can you please add this also "__loop_clr_fd: " to the grep_str (please note=
 the "space" after ":")? So that the grep string looks like this:

"__loop_clr_fd: partition scan of loop0 failed (rc=3D-16)"

Other than this, it looks good to me.

Regards,
Gulam Mohamed.

> +	if _dmesg_since_test_start | grep --quiet "$grep_str"; then
>  		echo "Fail"
>  	fi
>  	echo "Test complete"
> --
> 2.45.0


