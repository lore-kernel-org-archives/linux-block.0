Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E694595D;
	Tue, 18 Jun 2024 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718726994; cv=fail; b=Zi8fx1RVAT8gkl6/RDkBepkpxP+O6GOtpPNYdTRgWbZQm2TUElbNQxEcxVHbNJoT5VnLl+VY9vi4g5Dd4EH7UGw8FPHbSqoxEIQ65od3GE7qUzM+88491ERwe6zLrotEhM9RXhDGmKophOk5h+foo7Y+tEe90GjzGjxlxOzOGE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718726994; c=relaxed/simple;
	bh=vSo9jXsRAR6c2XUv1hLRZY9JIi1pVf2VaQGxfDKsy/s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EdT8p5Y4dywjaT/roW0BtQOdpFtDY86ZUy2/QmehY3o+hTJ1HtsKGTEEMNw9ZdOcAGYf4++MVU0WYDdUaFgraQIN6pQZ3SAfJwy9BKs5DN7B0e5KFGx69ymYyuDZPy4+Kv2pnv/UzEi48m/eTtQynR5Q6K2OjeE92GWXlF425gw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VodUDLHd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QT4qvL5Y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VodUDLHd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QT4qvL5Y"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45I7tQ9G026653;
	Tue, 18 Jun 2024 16:09:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=vSo9jXsRAR6c2XUv1hLRZY9JIi1pVf2VaQGxfDKsy/s=; b=
	VodUDLHdNB71mZqTfMfcCQLpjAlbnGTUgWRVjL7LO5qhmHa2EI7uimMgHMvfZhrQ
	9EH+RupJHob1aFykmSE78mHVMpsbNUSbr0C0jfg3FyyyulvWqiIT4YBSAD4KmEpr
	o3rdDddpA7gTqnGbquh2G0DZzzMy1iO4J01Scdiv1BoAZuVC+s+m7MMfwOlURLw/
	0053Ro0UxnjjA5XbsrupZXvvjNK263Spnw8VCi2AlCiYmystTIbFsXLLVnslgVVb
	MZjg8XnGpUQtu4MzeuIERaqsLBrlvjdOzx2N+24yuULExhLfXkhB3TWRU8okczwW
	2jO1mcRkSQxTeD230f71kQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys2js5855-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 16:09:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45IFpsnH034687;
	Tue, 18 Jun 2024 16:09:35 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2048.outbound.protection.outlook.com [104.47.51.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d8b7ks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Jun 2024 16:09:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nmSddQZBXsZTNGPvMVKKkCrOgt70pp6GhuvzSrtczkI9MX7sAtDBeA2JnaLTjAD+qhMDTP/9RBZe0Q5GlhlpSG12w3ga8cif6rZO/PA2V4kdtLKhoHi8ICIXEYFHsqGXw6Fcu+tcRaQH3sF28Vrv8O8Be7NfZz4RjLYUE2kSG33XmEz+TdCqJPDVWkhVMTsWPZXizR+Vj7t6i2mNMF9w75jZjRovvc6tpvdTu2177NZaxGYZR0xkUWQqGW5/VGy80hpcx+gmHJ+M191SGzcs1Yew8zmSSZhEoIdzCubrlTU+tn60CBWamdkQcUrk0eK/jMSEv922P6peEDsU+1ZZGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vSo9jXsRAR6c2XUv1hLRZY9JIi1pVf2VaQGxfDKsy/s=;
 b=jynyf/DYgOEQBBt80K8xWOnTddvETgdDf3cwgmTvQoKthNesb8cH7V0YhBky3V6n6QAKcmMrH5L1G5cW+1pILFph3XO23RmalgjW2xDp5MKVy5WeNtJx/DwdrDMYmDx9NU4yVVBziFmdNioLqsF8qbzdm4iVzUMkWEz0nXGCoMOs/RI2X13nSMqG5q4zJl6VnC7fcJ2iEtjLNiwzSv+eNoLjQw+WElFW8E64fT4TYICwrqHek9Zv2MpTpnPY0T1a8eqcq3nShEJ1hn/5+0btyMH5KlCN6DvI2ovKf0TK5/BVfp7E/rQcyxGF9Z5pl1Y6OCUfqHKHWnmj2q9QYd0Hcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vSo9jXsRAR6c2XUv1hLRZY9JIi1pVf2VaQGxfDKsy/s=;
 b=QT4qvL5YtSDMknxYFxogJ0ZYiA8WPJQCHADIqzbOlkca/G6Aj/x68M32vbqQWdM/RYjITKWHbZmh86Fxr1n0X0LCAhPc4VqHLDyiSkacSjUkosoMGxJv7DtD2Lioj4PB+3Yv5lz/mDh4Mr1wy+WrKZ1yGmj1/z15J9qF+VUY9No=
Received: from IA1PR10MB7240.namprd10.prod.outlook.com (2603:10b6:208:3f5::9)
 by DS0PR10MB6702.namprd10.prod.outlook.com (2603:10b6:8:132::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 16:09:27 +0000
Received: from IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1]) by IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1%2]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 16:09:27 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: Christoph Hellwig <hch@lst.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yukuai1@huaweicloud.com" <yukuai1@huaweicloud.com>,
        "axboe@kernel.dk"
	<axboe@kernel.dk>
Subject: RE: [PATCH V5 for-6.11/block] loop: Fix a race between loop detach
 and loop open
Thread-Topic: [PATCH V5 for-6.11/block] loop: Fix a race between loop detach
 and loop open
Thread-Index: AQHavt7cOaAV6YkZe0CoqpeNXC+BJrHNtGww
Date: Tue, 18 Jun 2024 16:09:26 +0000
Message-ID: 
 <IA1PR10MB7240E5709D1EF80F64E7CDC598CE2@IA1PR10MB7240.namprd10.prod.outlook.com>
References: <20240615012138.120364-1-gulam.mohamed@oracle.com>
 <20240615044519.GA28679@lst.de>
In-Reply-To: <20240615044519.GA28679@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7240:EE_|DS0PR10MB6702:EE_
x-ms-office365-filtering-correlation-id: a9e509b2-b950-412f-a7ee-08dc8fb10719
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230037|366013|376011|1800799021|38070700015;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?gkr/LUHwasXsWAwtmkvU31TcSCkSaRajO6qeppBcVh1EkS8SKXCcNu1qiJJK?=
 =?us-ascii?Q?qVOgLu5cta1YywzGeTH9/igKRq6WWIgLp559arrMu/51uGmZze+xEynYV9/F?=
 =?us-ascii?Q?1PHdS1EwxsRxcKb4jPt3CvQ6WT9wJ7UF0IaUVhb+eqz/7sZuEDwaMgEl0T0y?=
 =?us-ascii?Q?8dcpnlZeht506GysnJn183RZu0Y+6itx/oFbDE2bNGupxokSTrOeIUnNm6PN?=
 =?us-ascii?Q?w0ntO0uNyg1E7cNeqGUUkiMrwTuWsxW3AhJhLnwKeeGbVmzfhyutyiKE0G7K?=
 =?us-ascii?Q?yUBo2j9pZRpxA89+xZe8ACpZDEPSm2r0k6qq76Of2/Y+J0aoosAqwv4E/SJ8?=
 =?us-ascii?Q?Rn4cSx0kddmohuRCgUizm4qu08vCmzxvLfJpBrsnFNz6e7r1c581o3Gs0Hlu?=
 =?us-ascii?Q?yOGwRMs7D/KsVav7nkyUSqzYgQrTwUZ3A2neJMSyMcMmV+1/cslQZ6MGpvEU?=
 =?us-ascii?Q?567ceBMXOxlgikjNSSqtMgQ8M1KAzNa5kvzcND9MGcv3dn2x4SjWFo5r0q8+?=
 =?us-ascii?Q?9ELQQ8j1FoYH2Wo8RzUygwvVMEFrS5FU9d7pFPY4HwRp1rqIrPSoQYe9FlGP?=
 =?us-ascii?Q?GKRKNQutzAop1kQs5lp1LQIeTZPfzttWstkpC+DXQXepi6z+WglRGiu3YrWq?=
 =?us-ascii?Q?8Ntbajme+/Ezam2FiDlc2pjYAPZHN2rjSv7hHguqzjP1HYwln6D+r3P6ekBE?=
 =?us-ascii?Q?zQ3zX8XtcG+eR/2SK77mcuH+AaGJAU9VHcM9o7/fzo/FAtWhLbkDLmg9M7V3?=
 =?us-ascii?Q?jtCf7vSRsgh0yq6PvAbHPjvjqUHbVj0lYbvYuggZzLC8yPKv0cOciCqIt5uK?=
 =?us-ascii?Q?bAIoxpvZdBXI9KaKbOfNwnro3VG9aT8PhOKipOHO2V0YNhljapP6S9dcCoOd?=
 =?us-ascii?Q?Jss67BQh/62weE2A/oQIytr4C9W4IKXuHEJumxuKI0xrkDKb8EKYB/6IgJBD?=
 =?us-ascii?Q?VsdbMtMy/cRbXeObk5o/eh9njju+z3lNKL5jTdrzB9VaqI3gtiuEhG61LRi1?=
 =?us-ascii?Q?vOEm4/FEP5yUwx2lO3TzwTm6MfKyMPoBN0d3xDQRBz/ZMcqWi3/k/ru0JaeM?=
 =?us-ascii?Q?qU1+aNjXkpF2T5bIHumWFbU/5QSB42X7o8gaXMYMZxBeU/lvQHqhvuBTzKri?=
 =?us-ascii?Q?tGG3V3alJ8nd05efOftpUbd6vel4lHNKKu8YEBX3LecgcDdVCaNMSRZGqQN2?=
 =?us-ascii?Q?Hz38tO5vtba5IqIdWmElvw7wT92kDYyjriDv0QBk8HBkTEWA7lpcixnqBcNO?=
 =?us-ascii?Q?Rh5IiAtE/BNg3MI72zIRY6sSj0ojWrjQrtTBDaji6qBSRqgXpOSG2hFCFVCZ?=
 =?us-ascii?Q?xu8optFw1uKjb3SV5Eh4qQ9LDZ5c8/opA4K/zTWRmmrTjk8iMJ6PdvQgXLut?=
 =?us-ascii?Q?L8+Pf6Y=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7240.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021)(38070700015);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?+O+3GX8TDT7gvNZCfMDoqdJeWweyTXR5qCBpjFekRttlv5e7JmAwnh08QXHE?=
 =?us-ascii?Q?tAbPeWRknZFBZ/uMZrX6L3mu2VF5+1ArBtOA9L3wKGOBYUIy2WyneByFDMSx?=
 =?us-ascii?Q?Dgw2XDtLdSKvm+d6OkRnJYR6LjW/5L/yaVQvicZprVnDSb48tZaiGAC3RAnn?=
 =?us-ascii?Q?DV8HKhSPtPnCcVUme+FmC9UXr4CvBZoQpc2Y2tnGwpvc/+jNRgD/TOJBquui?=
 =?us-ascii?Q?2fhA03UVubjnoaF2Z/ngBZggWNxYOwIXZMcpJyifS5jy/o8E6FNEDKFRBHBG?=
 =?us-ascii?Q?aKQtS1tn2242elh/+9pbj8axfCotD4CGKHQq7AFG/y72VJPifJL01uc0TVrV?=
 =?us-ascii?Q?te44VTeSJeZYnh0CMIRTVTklfTj6dQwbuUAQ8FMEoR8sIwF9HGQvmtUyzKR8?=
 =?us-ascii?Q?f7JWZU0lmVn8QHIJQwrBRWHPIQR3sTuS+TYt4Inbzeb7c3NR/wS+LpPlNCIk?=
 =?us-ascii?Q?WGyV6lqwIcamaIpJAA/Lzc4UjKoOUa9/7J7i4RSLJVA5SuUvftAEXfR13kQw?=
 =?us-ascii?Q?rpe67aEf88WVGJBHc9BcNNS3Mtj8rP3Gc1wh5itQfvqzPgLIyo0Wn6p+IMb4?=
 =?us-ascii?Q?HMSapo4lXmEyMUFHRN3Q3sa6zCm4QbI4M9SWF5EMtByMF+so9Z4jpoMNCutk?=
 =?us-ascii?Q?91UtDGpfGEDAhYeUKq2wAMndz6iD6blUj/fRAjiMDKbiD1UG02rl1g3K/t9/?=
 =?us-ascii?Q?2+JdoS+lDfLRwmfQDjLF4AXRnMPltGY2BfJ31cIWLYN05cyQmAQ3cD7cogAP?=
 =?us-ascii?Q?KiQajr5VAlMzhRNd65kKCodbsPvqIAscttsQgcJUTmi415DkilY5QkdQLQOh?=
 =?us-ascii?Q?HFS4r4hPA7B+BWeq2H1l2iQ9In2D/z4ZuweH8PujTH0aPDxOhYhC5p4o0Gue?=
 =?us-ascii?Q?md1jADU4T+SLZp9NbCi0GzsXlUl5wWP24tO52WuRINVfhWZ896LvcIOrybBU?=
 =?us-ascii?Q?zyERkouc7Dq7LaRl2nNWzUYefLHoUx8BfhmJTxrywGT+3v7KueFuqKmtZ6ee?=
 =?us-ascii?Q?35nZFibnWg/kL6rJGGa+Tm9CDVCVpWNheVrcUTRqfv/EfOkWTF5IywKuMrjA?=
 =?us-ascii?Q?PuYWTjfPoNnjrv9e5kjvk/RWDAgn0PC82vwWe71pR8IT0E22/jDUyCSgtz2P?=
 =?us-ascii?Q?F/6PyhiYBAZV0KMbXiENCKJABShSZv8UE6ALjRjhl0/K7yvDE0YJyrJLpWKj?=
 =?us-ascii?Q?ajkQAodjfr3hVJNuU5g0chHxeGhkwNu0vxXRvgmLMiO7yo1BNXYflDooEUov?=
 =?us-ascii?Q?NVEVAGgmgKg8tedvXprYDUIvAAuCNxgdodQAFHGd5ZrZwGDa1CkVzERJt5+B?=
 =?us-ascii?Q?540N27lvwCXkA09JSp8+cJRHWNKkVCgIRzpHU0HFROet82dM2Mm2iD1hKQPZ?=
 =?us-ascii?Q?qIH3EiU7R5nyUnuqKqVbl/xk9ZrEIBG4ezgUU1wT5HMr+wQVpwK3nBHAByDM?=
 =?us-ascii?Q?pjPBpU28rISnCfBljWa5xrAk+O+TECVC7+/SxO+tJhR7Y/jGX0m/mg2Erf8C?=
 =?us-ascii?Q?RHFOjJzqhIQTmpRUNUC11g+fSCYIPVBsYkq/D/BQxJ9GHb7UVx8XqROK/tUI?=
 =?us-ascii?Q?ThXZED1H3Eb6U6sxAX+JoeHHT8nc4v8I+i2DHrgb?=
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
	t6lfwsq4l9yrBag7tkXGIQCeEUHH0ynX1gb6K8JClaIVWXE4LRqE9vX8Emq2K2vwm99o7e5+wqovkCHemF0H1lPebecBEdc0U8x8pGv88ovDGZA+jFM+RcnoSLguINMIkCQOBobfmTx53jl1HP2X7yoIrjY4LnWSwPmh1GcR8NWflOIgilXrHBj7di32DP99UmzIK5KsK8tFgHp6uEMTbLq2bouabvYSty4RzQkhP/BvEZl369syz/ZUJiM9jIK0Fw+rIU4Sx4LqFA7RMjTBt0cak8Jjco0b/q452HToZNgaHcWxAzSrylrgg6WZkVmxP9NiP8JA0V2SXUgc1W9K9Tc8cR3J+YbzzqBd7lMG2Wplkwyb6klwwSUH5/pZnb73IQWLDh20zPwzuXFNIlBSJqXE0DOt3U/FIq3B3tDv+eEA0HcsYXYoCDfC1wsXzJtzod1O9g6HYiPqE/uGOsT5nORCjR7WRvF3NffgMli6CFylZiQnfza+hOJOg6jSk8fNve4EGshoYcH9DqLWLg9faosOv0jSoQ8dcJ/g7cfefHAAVisgA8bqsSlx9xphTn1IOBy5qDW9neg0wUtc0PUjRH0MXqUIFZVxir4BnJXxnvc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7240.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9e509b2-b950-412f-a7ee-08dc8fb10719
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2024 16:09:27.0371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SbcjIM7u5mQjtpnXWKBmnVolRllgGvqrWbw00j55QZ7Vik+y94tNTGCYlTEACErkdWHX2DuY0zp4Pfsn2RHrswdLcoOy661ezaIqE7VIr3M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6702
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-18_02,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=873 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406180121
X-Proofpoint-ORIG-GUID: 7uttEYju5aqwlSLvx6Fm9S9GI2kGelIP
X-Proofpoint-GUID: 7uttEYju5aqwlSLvx6Fm9S9GI2kGelIP

Hi Christoph,

> -----Original Message-----
> From: Christoph Hellwig <hch@lst.de>
> Sent: Saturday, June 15, 2024 10:15 AM
> To: Gulam Mohamed <gulam.mohamed@oracle.com>
> Cc: linux-block@vger.kernel.org; linux-kernel@vger.kernel.org;
> yukuai1@huaweicloud.com; hch@lst.de; axboe@kernel.dk
> Subject: Re: [PATCH V5 for-6.11/block] loop: Fix a race between loop deta=
ch
> and loop open
>=20
> Umm, so this is back to not just doing autoclear all the time?
>=20
> What I suggested was to go to my RFC patch that still does the unconditio=
nal
> autclear, but which sets rundown when there was just a single opener.

Actually we thought that there could be a race between openers due to which=
 disk_openers could be more than 1 and due to which the Lo_rundown cannot b=
e set. Hence LTP test could fail. But if I understand correctly, I think th=
e LTP test is meant to run separately without any other processes opening t=
he loop device. I will send the next version with the change which sets run=
down when there is just a single opener.
