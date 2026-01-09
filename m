Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322F6366DB6;
	Fri,  9 Jan 2026 17:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.178.238
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767979833; cv=fail; b=kxVXKFPetglMEJIEwTZR6NVJPlCHA9X6ojgXE5GM7ra9clmq+m58WZOCbC08Ok04D0rMToAOAbd9fVAws/RZkys7aBmdX1/qvobZiT4dnFrupGUMqPE+7cAkyKpGaSZMbpbgaw1+48frjCurx5ScZWPvM7+UrZhAE2yBVeQgfYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767979833; c=relaxed/simple;
	bh=iaAT1/hkMTlkagQoa4hESpgP3qiH7TxthhY0oLSnXa0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Te1iO8vX24InnKMCP9OAgfeGVY6LJ8RgziSbN5wtzYJj3LjxOVsrDF5gDSSGRLfrTsPgC/x7R32AKRiMmp1wSsWFwOFG1dO8y0hBYnHPAHGf6Vp2K4COFG6VoygCJd2KXnvoGBeMLu7aF5B909SGwip3G9BQoFsGMWFj82p2tzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b=ClnLSOqR; arc=fail smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=windriver.com header.i=@windriver.com header.b="ClnLSOqR"
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 609HIQ0l2228097;
	Fri, 9 Jan 2026 17:30:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=PPS06212021; bh=1/qk+Ajx3
	wctOkY8rLHEoh3jz/slmtb2HT7AWY2PBi0=; b=ClnLSOqRLOm1P/QV4eO+nK6Ih
	cdfWB9dNyVbTFNaC54kvCrMDRaXHoTf9mhXHozCXTNxYE7Nkc7oVkZDW9KJABwZX
	yGkFqt6PUd/jL1Zrf6S/dxbW5JCDv+IjZj6nRDsyTTLNPFmwZKD1w4C5vznRVw0i
	bLR9J5QI6W7U2tuwUwSFiZAlI0vphURkJ9vDM9L7wUPFI66NvzlMHK1k3k7sfkkF
	6CzJIG8c5G8QYzamZSXKU9/7IyszebJiQ62dLXkIqaToHR/dVhiPxiLOaqT16Z7O
	crbVQEZ0DE8adCUri+M3fzZ/E5kodm09L6YL/dS8SyYXWp/wb9bE3SV9Sl3KQ==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010014.outbound.protection.outlook.com [52.101.61.14])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 4bk5y3g0dn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Jan 2026 17:30:01 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJ4HwyorDypn/+PKr5+zMMXugQunDf+jWND41RqjzyKKmr6UwPMyCHOKIltPwKWfq1IZ/5hwEM5ucn1utQMr2f9S4rbr/oq0W6IZJdkH9FdfVIOD3+9AcfsrOFhsus15IzPltJqwoApz4au7OkZyNM1HOzhgDAx1jtaFOHcuxwlDG+E8gJkxlJoqNOJ4CdiicSqdxOs5Ktx/jpGJB9pWXK0miE1qBggXmbgP9WO3ym+35XwAabh49RYbvcPH7wPDGU2aFFdS+Tf7GdDG9h8mJJ42H4mVGWnJ7rLBOCJWpj0GPA4Dl58Rsli256ffMWOJaneBIfTIYPjA0mPT8lSh3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/qk+Ajx3wctOkY8rLHEoh3jz/slmtb2HT7AWY2PBi0=;
 b=VQR0XhxV+da3fV1raTrN0h1Xq88oItfOSAxm4OYkgHA08mILSXPE8dLGOKhZZ+mOYKeA1soq8N1bcnHz4ML5zsqTchIPIOSMcYWJy1tQp+stpZxGRLrAVBbm3wk4spfPgbxds8YhX3kZgsSgR2PEi9C9j8qHT2eFowQ3FYVeKJh4t5JJLHz6tQFDqnMGC98sW+ZcUp0fXkbCoQb16hP1eSrQyI69KfiZjaM6QVgW+BiLFmqDs6EdJXpI4e3FfwsCDZM97dQXTDtUKi2SZ1El/HrZ0FhAUllriiqAdP/J5WfRAmS0KivAm9nasCghGHQ1vq72CO4vDHU0bXmCUX23UQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from MN2PR11MB3885.namprd11.prod.outlook.com (2603:10b6:208:151::27)
 by BY1PR11MB8080.namprd11.prod.outlook.com (2603:10b6:a03:528::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 17:29:59 +0000
Received: from MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::f711:ab0c:1211:363]) by MN2PR11MB3885.namprd11.prod.outlook.com
 ([fe80::f711:ab0c:1211:363%6]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 17:29:59 +0000
From: "Nechita, Ionut" <Ionut.Nechita@windriver.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "Nechita, Ionut" <Ionut.Nechita@windriver.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "axboe@kernel.dk"
	<axboe@kernel.dk>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "muchun.song@linux.dev" <muchun.song@linux.dev>
Subject: [PATCH RESEND] block/blk-mq: fix RT kernel regression with dedicated
 quiesce_sync_lock
Thread-Topic: [PATCH RESEND] block/blk-mq: fix RT kernel regression with
 dedicated quiesce_sync_lock
Thread-Index: AQHcgYzUYl1jq2BIvkWOyWCvFIwkuw==
Date: Fri, 9 Jan 2026 17:29:59 +0000
Message-ID:
 <MN2PR11MB38853A7EF5D71E2AC4E9AAC4E082A@MN2PR11MB3885.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Enabled=True;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SiteId=8ddb2873-a1ad-4a18-ae4e-4644631433be;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_SetDate=2026-01-09T17:30:57.665Z;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Name=INTERNAL;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_ContentBits=1;MSIP_Label_3ea094ce-8c76-406f-84c8-0af1663f74b7_Method=Standard;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB3885:EE_|BY1PR11MB8080:EE_
x-ms-office365-filtering-correlation-id: 8e2713b9-7c20-4284-4e73-08de4fa4b6a4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?G1W7mlK3Se4lzfOigd1eAr7pi1yaImgyR015MnBtHifSBi59c5MzuzKXYN?=
 =?iso-8859-1?Q?cCvwYp+rENeEnkLs0KTta5nqw1b7Hu47VAdULwlmdcB5VxO8/ZZXk8rfIL?=
 =?iso-8859-1?Q?IRF8F6aoHM5YT03mOtNH++lT7Hax+FfzRE2zyP+s26071vmVHo/go0IBOa?=
 =?iso-8859-1?Q?4Bi5WC2jHKE76b46PPsDdM8ah2SFeUTAZW12X8+UW+cH8nabIsgyIZgV/n?=
 =?iso-8859-1?Q?zMpI81+I9HVfVAuQnq5/z2H9BejEYdrHevCpatSPniKjJ1GSE+RfiAlnby?=
 =?iso-8859-1?Q?kZ6Ze8enN8ffJ/7ci7lG8lxbb+Tinj6fwpiUaxkF0f+zQ+pYWNAtJ/zUNF?=
 =?iso-8859-1?Q?qIsZkdZ70mpGI1zqxNKZOboyf8uiuCIs+9h2brZkTD+oNp3RaUE9fXpTCn?=
 =?iso-8859-1?Q?4xwbFPZ8/Gs+rIYdsSoPKoWDy10tP6GYrSJ932DCUMQ4Ij4/D8BxP52ZR5?=
 =?iso-8859-1?Q?yDP3shqpD70rvowBhHE+8N2dnPxlFgPs5ZBsUs4+CKu+zPMq/P8ArdBr7s?=
 =?iso-8859-1?Q?AfURGqTWrEavyVRMjIoyQCwLFb7c//D7cCkkV9w3Fr3nEiESmqZ2dXtWYw?=
 =?iso-8859-1?Q?R/emIDxTN9EtLWkRJFuzwideepsRHeshAzAPZOKdk4cxby1qzwxWFsOtZl?=
 =?iso-8859-1?Q?0uEByuFrta7gL5uevEd/n2INLsmR1qkCuZfXMh8SZEQCZnhcHZ20+QDxAs?=
 =?iso-8859-1?Q?1wsCc/8T80or0PNTIlY0KX5c3k2bOVCUMoIdUipGpk1fTz7JfUI+GSwrpl?=
 =?iso-8859-1?Q?P2+4lloO44QbtAB58TBfQSoS5PJXD3xFGJ0MejVOhrfvk0XwQ4BE0n4R6O?=
 =?iso-8859-1?Q?9/2BS8Ktx0nIFP++Jpb7Bbq6p0Y+ZIxrzmod9g8PEU9DKG8D9y/9Yzq5KO?=
 =?iso-8859-1?Q?wjRjjCqbQI1U1Nc0M4AL/M8wf21yibWpSUxnMwnf9tJN6qlwl24nUi0aD5?=
 =?iso-8859-1?Q?Dxi2p6vuv0xqItnKSuRQtpSjvaDEJjqCqLolRT1CPNAkqvT9+t3jsAxNHs?=
 =?iso-8859-1?Q?ZRagZ3pfZA6u/WdCisHRqwqPSDANYXOyf8Cvxa9UCxHrQNqF5H/KBIm4v3?=
 =?iso-8859-1?Q?+fvumpmrn3KIzgXZgITlj4nnDPYu7huVffhRunns1Lm7YXLVR+Ao9Apb+F?=
 =?iso-8859-1?Q?I6Ije2Rx1qYTxXzf+2fIoyCscqxEWJi2F5cv+k9qFJ9L9hEDZLuG9y5K1U?=
 =?iso-8859-1?Q?N4XIsgb+apBBvNm9fnMUQofLKwCUnKDUMYZyf1r+P92mG9+TPnxpsq7m5k?=
 =?iso-8859-1?Q?P/aOMcjz3UskJ2KiVSlR+3wWR8NWe8FeXs2svUBm31TX3JR5sETRoZ4X9w?=
 =?iso-8859-1?Q?zwZBhh5/sCJtODrjPzO1zI72nJXTFFyFMDm6BDTHJy/SDB0dJLLrCJm7qk?=
 =?iso-8859-1?Q?ozuGipmPCiAHL+g87Va/6+ApbZv+x3UJuyheCZOf0w1IQU8Y7exohc7ZC/?=
 =?iso-8859-1?Q?G8NJAs/J5tHOKqkcs1/47Skmt2PyQkKQdffNIMzWx63DjAgSouEQFHpF2m?=
 =?iso-8859-1?Q?Hi0Y2SLatmLj19B6qRxe/cRo8FeTkV5fDCU8zWzSN0IQiQCAvv/vS+EH0I?=
 =?iso-8859-1?Q?ltO9sOJGFJEb2RkXva4ZjN+oEFPp?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB3885.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?1P3Z9AwHGN3HsdMfAj0I/tokC04F26fPX3ZDb39vWp/tt+NA3u3KzRCeO4?=
 =?iso-8859-1?Q?nFGTBz66eyPoBLEpft1I01Gnej/jO5GrTuJsapfHvzzFbZs8MD9Hlb2L2c?=
 =?iso-8859-1?Q?W6DhPcQHW/sco0hlSdZKyPf1YvCX/Hn0Ty9lTCUmu1eWziq4ppKvdvHOf7?=
 =?iso-8859-1?Q?DduxTyCoBJv4J2kryHo2HJvnnsn550cmN58hkIuYIT2jQA4Y/Vup88Yw8Y?=
 =?iso-8859-1?Q?aoi5lyZ/sVw/PDDac/v/dauucbJUYFQgWHuGw1NDz4g/7ZFQp3Nd1C+GwS?=
 =?iso-8859-1?Q?P45IyPaomYRSrFkc95oeuYjDlFmUddEGtYxW0wSFy5UKZ9XW2PklYoCLvN?=
 =?iso-8859-1?Q?ELDnoBs8zrsX/JDaWSihYjDpBpsItJTPl8FjPFJfSVdIlEG02Wh/EFlVTc?=
 =?iso-8859-1?Q?dbK0oWrMpTcBvFBbFIz0kd6YfRzAdRYAfm/R99qxq1Ezh8s5SyFEjpUuW0?=
 =?iso-8859-1?Q?E4awIq32CfM6BfBDEu42Tld0MgmdILd132F6CdiEIIAuXipITQ5q89K+te?=
 =?iso-8859-1?Q?18gbpQJfqafSg4+MxLbfL/lltVCkAs3sHRIeOQXD81E0ZHccUYMWRiblws?=
 =?iso-8859-1?Q?zquLOZl93PrnrZB+72Wz+wQc/8Aaf627k/HxWLGyblOlscjRcMdI1/aX1H?=
 =?iso-8859-1?Q?uqNKQ+xMNb9SS671WrjnPLbwKM6Cn5Z2/v5aiy2oTIf9ntrmjqqrrj/Og8?=
 =?iso-8859-1?Q?zPHIWZhwUb04pb6uAKLhqC4IZDxCe3CtUwHGWB10RUHshGmCWQy6tCIVHM?=
 =?iso-8859-1?Q?uaykustbzB4CHvHx7i6udaHznXFQA1T34OJOsmf/OCiTxLcHDxdgO0LCHu?=
 =?iso-8859-1?Q?x/ieB5fEVhQ/mMhxW8Dh76mBgX97HRANork6MRVUKrgx2lTa5/5RtmRHc9?=
 =?iso-8859-1?Q?zRvOI0PavmlqiurlWvm8imB9W69TVqlVQxv3a3lECI601Gs9asdr1bk9VV?=
 =?iso-8859-1?Q?1eIGxMdQQGjsOyngJfTA+jFBK0XlwNxX4DfV7UIHWA33623hHunCYniAA0?=
 =?iso-8859-1?Q?9eZLgfck9Dzw+AWMJsw2YW2pbRbyB7f+bFWGB9CjLLzAMfnkILjGkAWAGX?=
 =?iso-8859-1?Q?dcrJC9iQaN/h04a5OVYLcxvzfxYpq4l9zwjjlgrYhG5tzbecMEJwKB1K6S?=
 =?iso-8859-1?Q?EcEaqF+WnsN2SBAWnSkxZ0G9yrVN2ZZh9VQ27y5Bq4RK2EN96ljqUVwk9C?=
 =?iso-8859-1?Q?70QSxG9a/gt834wZAQv4FRny494tTkrZoUq1yV4GIPafKA8PP5+G+jQ0aD?=
 =?iso-8859-1?Q?scd8x+JDAvzQ4WhIuF48Ry35CpTkOK1lGazIn5JtNQn9egleXipOv/zfIu?=
 =?iso-8859-1?Q?qga9OEsIPCtwY5ljAM5USnDhzxCqrn6EaoT8qfFZkwwuqBvCX1u24wtrGm?=
 =?iso-8859-1?Q?OZlmPsjr19UpWPXb0hbtpIWkKL5G/IT27zsbm/657A5N8+7SSFjsHrQrwD?=
 =?iso-8859-1?Q?cyIjdGW6IOthK6M+n79SEn5nz9SvzX/MnlWiigyTTDzY7EpQ5TxLLkpdXt?=
 =?iso-8859-1?Q?PQWhux1YXtfojCgWbwH17EJLzE+joMMG1mnfEu5xVPN3BV/0i++G001Lmf?=
 =?iso-8859-1?Q?tBcv+pTdtNp9mIkmObagDze4WLRcVcyf4i/PZHgENsUx3nIQ9YGqW/yOj4?=
 =?iso-8859-1?Q?NqWSXNRRH0FIF6xxab/ejuKbG2f0X+m33m08n5RTEQjqcsieLARYDX2LPb?=
 =?iso-8859-1?Q?Y8RsDrE5qYnP+bVsjIITI8KkrDRjf0hG4QzCpLW/Gb1A7mOGQY5KuoAN94?=
 =?iso-8859-1?Q?I4YYgIWYEK6pMFlNtV/g+WEpJ44W/fCpkhutFSbhwD6pKHbLb8yAt1cuft?=
 =?iso-8859-1?Q?vj9HKeA8Sw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB3885.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e2713b9-7c20-4284-4e73-08de4fa4b6a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2026 17:29:59.0110
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l2q1nW9svB4zLyQPBRYTKfDWi+CuoFy5NXVLAnHbo6lniGVdSm5QDWOzY8l+pvwOJUf6yE9qDh1rnGqUOKmiJ57UswetBRDKAKSsWUemEm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8080
X-Authority-Analysis: v=2.4 cv=OtNCCi/t c=1 sm=1 tr=0 ts=69613b1a cx=c_pps
 a=cMwMxZTj1NM3F6QoWJDe6Q==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=t7CeM3EgAAAA:8 a=VwQbUJbxAAAA:8
 a=Cw8VXQZKCj28N06HuCYA:9 a=wPNLvfGTeEIA:10 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-ORIG-GUID: ei_to7mQWK2wuhLO4Quza7VReK5ZbapY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDEzMyBTYWx0ZWRfX0Y4dVop0WA5v
 XtDO1VbNj3PAmOtBZAhHLzjI4GwYOX+nww3JkNbM/HCnk85YPkqnEIsgJ7q1q9l3TbJM2aGw6ps
 Do9PWS4l+0H9poy5pUpucsZxXvRc1ghF6kYxNtdoHjyxVD71EkZODkI25TDndvZbWfkAZ6vTIJK
 puTVuEJ0Qk8kQsuBrEZaCvMEWu2A+/b7LGpUibHGwL6mEQ9817si0zVt54q7EfDPui1toGu+jkv
 FcfTFTDCf8EzWXKmMtMQxrWdOeCzqk1Ubp9ZFIv04OC0s1CviFxtN+Biz5iFFzE4dixYNXSsDDQ
 hpbDH+0Vi+Acm/hea3XS2JfEtpYadv7OZifjkRx5dwl/c+Bpw/LipLSKBOt+xUnnt518oFNRQrB
 ECZUIWzk0RY6RZU0hoEoyg5XHcwVGXIr66vU+/r8Mgl2VV4ZUDUpiCntKV1Vws1qD63ZhKuOAtI
 IKmRoxrIvA91yoHuk2A==
X-Proofpoint-GUID: ei_to7mQWK2wuhLO4Quza7VReK5ZbapY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_05,2026-01-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1011 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2512120000 definitions=main-2601090133

From ade501a5ea27db18e827054d812ea6cc4679b65e Mon Sep 17 00:00:00 2001=0A=
From: Ionut Nechita <ionut.nechita@windriver.com>=0A=
Date: Tue, 23 Dec 2025 12:29:14 +0200=0A=
Subject: [PATCH] block/blk-mq: fix RT kernel regression with dedicated=0A=
 quiesce_sync_lock=0A=
=0A=
In RT kernel (PREEMPT_RT), commit 679b1874eba7 ("block: fix ordering=0A=
between checking QUEUE_FLAG_QUIESCED request adding") causes severe=0A=
performance regression on systems with multiple MSI-X interrupt vectors.=0A=
=0A=
The commit added spinlock_t queue_lock to blk_mq_run_hw_queue() to=0A=
synchronize QUEUE_FLAG_QUIESCED checks with blk_mq_unquiesce_queue().=0A=
While this works correctly in standard kernel, it causes catastrophic=0A=
serialization in RT kernel where spinlock_t converts to sleeping=0A=
rt_mutex.=0A=
=0A=
Problem in RT kernel:=0A=
- blk_mq_run_hw_queue() is called from IRQ thread context (I/O completion)=
=0A=
- With 8 MSI-X vectors, all 8 IRQ threads contend on the same queue_lock=0A=
- queue_lock becomes rt_mutex (sleeping) in RT kernel=0A=
- IRQ threads serialize and enter D-state waiting for lock=0A=
- Throughput drops from 640 MB/s to 153 MB/s=0A=
=0A=
The original commit message noted that memory barriers were considered=0A=
but rejected because "memory barrier is not easy to be maintained" -=0A=
barriers would need to be added at multiple call sites throughout the=0A=
block layer where work is added before calling blk_mq_run_hw_queue().=0A=
=0A=
Solution:=0A=
Instead of using the general-purpose queue_lock or attempting complex=0A=
memory barrier pairing across many call sites, introduce a dedicated=0A=
raw_spinlock_t quiesce_sync_lock specifically for synchronizing the=0A=
quiesce state between:=0A=
- blk_mq_quiesce_queue_nowait()=0A=
- blk_mq_unquiesce_queue()=0A=
- blk_mq_run_hw_queue()=0A=
=0A=
Why raw_spinlock is safe:=0A=
- Critical section is provably short (only flag and counter checks)=0A=
- No sleeping operations under lock=0A=
- raw_spinlock does not convert to rt_mutex in RT kernel=0A=
- Provides same ordering guarantees as original queue_lock approach=0A=
=0A=
This approach:=0A=
- Maintains correctness of original synchronization=0A=
- Avoids sleeping in RT kernel's IRQ thread context=0A=
- Limits scope to only quiesce-related synchronization=0A=
- Simpler than auditing all call sites for memory barrier pairing=0A=
=0A=
Additionally, change blk_freeze_queue_start to use async=3Dtrue for better=
=0A=
performance in RT kernel by avoiding synchronous queue runs during freeze.=
=0A=
=0A=
Test results on RT kernel (megaraid_sas with 8 MSI-X vectors):=0A=
- Before: 153 MB/s, 6-8 IRQ threads in D-state=0A=
- After:  640 MB/s, 0 IRQ threads blocked=0A=
=0A=
Fixes: 679b1874eba7 ("block: fix ordering between checking QUEUE_FLAG_QUIES=
CED request adding")=0A=
Cc: stable@vger.kernel.org=0A=
Signed-off-by: Ionut Nechita <ionut.nechita@windriver.com>=0A=
---=0A=
 block/blk-core.c       |  1 +=0A=
 block/blk-mq.c         | 30 +++++++++++++++++++-----------=0A=
 include/linux/blkdev.h |  6 ++++++=0A=
 3 files changed, 26 insertions(+), 11 deletions(-)=0A=
=0A=
diff --git a/block/blk-core.c b/block/blk-core.c=0A=
index c7b6c1f76359..33a954422415 100644=0A=
--- a/block/blk-core.c=0A=
+++ b/block/blk-core.c=0A=
@@ -434,6 +434,7 @@ struct request_queue *blk_alloc_queue(struct queue_limi=
ts *lim, int node_id)=0A=
 	mutex_init(&q->limits_lock);=0A=
 	mutex_init(&q->rq_qos_mutex);=0A=
 	spin_lock_init(&q->queue_lock);=0A=
+	raw_spin_lock_init(&q->quiesce_sync_lock);=0A=
 =0A=
 	init_waitqueue_head(&q->mq_freeze_wq);=0A=
 	mutex_init(&q->mq_freeze_lock);=0A=
diff --git a/block/blk-mq.c b/block/blk-mq.c=0A=
index e1bca29dc358..c7ca2f485e8e 100644=0A=
--- a/block/blk-mq.c=0A=
+++ b/block/blk-mq.c=0A=
@@ -178,7 +178,7 @@ bool __blk_freeze_queue_start(struct request_queue *q,=
=0A=
 		percpu_ref_kill(&q->q_usage_counter);=0A=
 		mutex_unlock(&q->mq_freeze_lock);=0A=
 		if (queue_is_mq(q))=0A=
-			blk_mq_run_hw_queues(q, false);=0A=
+			blk_mq_run_hw_queues(q, true);=0A=
 	} else {=0A=
 		mutex_unlock(&q->mq_freeze_lock);=0A=
 	}=0A=
@@ -289,10 +289,10 @@ void blk_mq_quiesce_queue_nowait(struct request_queue=
 *q)=0A=
 {=0A=
 	unsigned long flags;=0A=
 =0A=
-	spin_lock_irqsave(&q->queue_lock, flags);=0A=
+	raw_spin_lock_irqsave(&q->quiesce_sync_lock, flags);=0A=
 	if (!q->quiesce_depth++)=0A=
 		blk_queue_flag_set(QUEUE_FLAG_QUIESCED, q);=0A=
-	spin_unlock_irqrestore(&q->queue_lock, flags);=0A=
+	raw_spin_unlock_irqrestore(&q->quiesce_sync_lock, flags);=0A=
 }=0A=
 EXPORT_SYMBOL_GPL(blk_mq_quiesce_queue_nowait);=0A=
 =0A=
@@ -344,14 +344,14 @@ void blk_mq_unquiesce_queue(struct request_queue *q)=
=0A=
 	unsigned long flags;=0A=
 	bool run_queue =3D false;=0A=
 =0A=
-	spin_lock_irqsave(&q->queue_lock, flags);=0A=
+	raw_spin_lock_irqsave(&q->quiesce_sync_lock, flags);=0A=
 	if (WARN_ON_ONCE(q->quiesce_depth <=3D 0)) {=0A=
 		;=0A=
 	} else if (!--q->quiesce_depth) {=0A=
 		blk_queue_flag_clear(QUEUE_FLAG_QUIESCED, q);=0A=
 		run_queue =3D true;=0A=
 	}=0A=
-	spin_unlock_irqrestore(&q->queue_lock, flags);=0A=
+	raw_spin_unlock_irqrestore(&q->quiesce_sync_lock, flags);=0A=
 =0A=
 	/* dispatch requests which are inserted during quiescing */=0A=
 	if (run_queue)=0A=
@@ -2323,19 +2323,27 @@ void blk_mq_run_hw_queue(struct blk_mq_hw_ctx *hctx=
, bool async)=0A=
 =0A=
 	might_sleep_if(!async && hctx->flags & BLK_MQ_F_BLOCKING);=0A=
 =0A=
+	/*=0A=
+	 * First lockless check to avoid unnecessary overhead.=0A=
+	 */=0A=
 	need_run =3D blk_mq_hw_queue_need_run(hctx);=0A=
 	if (!need_run) {=0A=
 		unsigned long flags;=0A=
 =0A=
 		/*=0A=
-		 * Synchronize with blk_mq_unquiesce_queue(), because we check=0A=
-		 * if hw queue is quiesced locklessly above, we need the use=0A=
-		 * ->queue_lock to make sure we see the up-to-date status to=0A=
-		 * not miss rerunning the hw queue.=0A=
+		 * Synchronize with blk_mq_unquiesce_queue(). We check if hw=0A=
+		 * queue is quiesced locklessly above, so we need to use=0A=
+		 * quiesce_sync_lock to ensure we see the up-to-date status=0A=
+		 * and don't miss rerunning the hw queue.=0A=
+		 *=0A=
+		 * Uses raw_spinlock to avoid sleeping in RT kernel's IRQ=0A=
+		 * thread context during I/O completion. Critical section is=0A=
+		 * short (only flag and counter checks), making raw_spinlock=0A=
+		 * safe.=0A=
 		 */=0A=
-		spin_lock_irqsave(&hctx->queue->queue_lock, flags);=0A=
+		raw_spin_lock_irqsave(&hctx->queue->quiesce_sync_lock, flags);=0A=
 		need_run =3D blk_mq_hw_queue_need_run(hctx);=0A=
-		spin_unlock_irqrestore(&hctx->queue->queue_lock, flags);=0A=
+		raw_spin_unlock_irqrestore(&hctx->queue->quiesce_sync_lock, flags);=0A=
 =0A=
 		if (!need_run)=0A=
 			return;=0A=
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h=0A=
index cd9c97f6f948..0f651a4fae8d 100644=0A=
--- a/include/linux/blkdev.h=0A=
+++ b/include/linux/blkdev.h=0A=
@@ -480,6 +480,12 @@ struct request_queue {=0A=
 	struct request		*last_merge;=0A=
 =0A=
 	spinlock_t		queue_lock;=0A=
+	/*=0A=
+	 * Synchronizes quiesce state checks between blk_mq_run_hw_queue()=0A=
+	 * and blk_mq_unquiesce_queue(). Uses raw_spinlock to avoid sleeping=0A=
+	 * in RT kernel's IRQ thread context during I/O completion.=0A=
+	 */=0A=
+	raw_spinlock_t		quiesce_sync_lock;=0A=
 =0A=
 	int			quiesce_depth;=0A=
 =0A=
-- =0A=
2.43.0=0A=
