Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA55524FC0D;
	Wed, 19 Feb 2025 21:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740000078; cv=fail; b=HSGjBV+fduvNNHHe40yPdSj+omuXb360NV9CxBdj95uYUcCol0+5+GLvR7P3oLEPtjhPFsuv9LG6wv8NVbClCOPDZLrRrJVuH1DxPiDxdIO9e4lk1ogjfDTGVYZV5xVE61mC/5xgnvWBXUaBl6fGKNazMEugbHsrFhAcLfHuPTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740000078; c=relaxed/simple;
	bh=cP5zbScfA9Bv83QdyumItroc4NPbbP/r33+/kvAox/0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=L+ry4YrRw3om+KA6eT11RJHgTL5ffQXYJCYJ/yg3zy34YtCWI4stmNZhgn4lExfI9VkQdtW3lShe16X/LVFV1rkhtvTG2N+vz6MbEYHNLJH8NvBByck4pD6fm4xwSfPFMLpzZmYLI/DTjixUhP6ZWN0RN0vsnN4a5OJ3StSy7eY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Y+ovzMM3; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ssyfVFeK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Y+ovzMM3";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ssyfVFeK"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51JJNgOZ010549;
	Wed, 19 Feb 2025 21:20:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=aXFzahnVUpxbZxyOFbl+qbYFdH1ZSTpxczbZAYEaH6U=; b=
	Y+ovzMM3YrdqpT/+aiPS2Wg6Wg6ABxLhfhSEWJtZbFLent9KCguZ7qKvM+l35z4S
	zTYGgz8XBllrB7KR5d34fwzGxniC+0VngaxiRhY9mtwLGC7NV+Z+gRB61QgitAuh
	KbNr6SreGIv7QDAcWBRgNy0R4oRNudrt+iDd/xRIkJhEyubgRa0FKraudUwo3yET
	L6fA6+jF9wEq8exqQ6x2fLXTvm4HhmfwW8++T+eP7qY8TX9cHQGwoDsl+frOLd9b
	y14OMClHX11MbYH9X9/Kj81bA4C6RXYPRm2ZB2MyFZcBRCqsY1U6+hpGw2u8TQss
	rexNDBUl4rYNZVo+McH3QA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00njquj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 21:20:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51JKhvHc009838;
	Wed, 19 Feb 2025 21:20:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2042.outbound.protection.outlook.com [104.47.58.42])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44w09d2750-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 21:20:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s2tpBVqu9wRJhNUuhHlDPo3jMgZdVJIdvXFEvG+8lBqZlcN+ccx3N6x6rau+XhOEHRZqjZ1jMWVN6ma3tOSrPVdDqD2A6oO0fTR9oTx74jA9Hx50q3tZfs6IEdQAkKR/0BF0EnydvdafrxK2yKKXIWs0MCHo0t67bgxIAXrPUv1DupTQDP7wLf57R7ENMJPcNYnyLCJLcya4W83D9yEh3Qhdmoz0jHgZrx9e/R+uG6yP5DnYZT5ELUHOpI7WxQMQlTtHJXV3HP7H4efgGl2MmfNk6NDOTC99iXzTDFtZtdVIpFUYE028DNSbfKJaVW/ANJB7S8ReO0rR8qJSVf/mQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aXFzahnVUpxbZxyOFbl+qbYFdH1ZSTpxczbZAYEaH6U=;
 b=vmqx2m6lmLlr+yp8QSZsBIkG3nSC0oO4a0dGj+y1CaKECuOxdJH+BkHDAepngPU8H2d4K0q8JjNMkJuN++0YmsDedz9g2KawMLqNd/6h/iJlkvHeaBOvfTOUg8CIP6WpvOekYnRH8j6THqdVUGGvEbyE20cYBMAEyh6DsmA83ocJ+57BbklJB71TgZCUCtcqscKwi4Qb1tI/0CwQObnX+Pph2BOuE0vQKz/8tyVh2JmPcQdx51slJoAxLp7bQMox1axyP/dg3aSuhHHIE2C3YBV1yc2xKmOE2rFcXDxbq4GpKrG5QttuhPXXzID4SLf68cbhppUNNaT7phBZAq5aDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aXFzahnVUpxbZxyOFbl+qbYFdH1ZSTpxczbZAYEaH6U=;
 b=ssyfVFeKgrv2f8/bPrb02Jg4ixwAZo1hcztkR9XM6Or74T3D3io/vjDY5TlOPMh2tRyFve3Wl9f3li6jQG9eKi/FyrSC/MVbvL/n9he7lI8H/wIiIsLdFCJg0dRug/hXzZXQhltup+Rbs3Z/G+YzNgYIg/6QgUDkyMAJvhkeka8=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by SJ2PR10MB6962.namprd10.prod.outlook.com (2603:10b6:a03:4d1::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Wed, 19 Feb
 2025 21:20:50 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb%6]) with mapi id 15.20.8445.020; Wed, 19 Feb 2025
 21:20:49 +0000
Message-ID: <740c57ad-0cbd-4498-8ec9-46a54b204e3d@oracle.com>
Date: Wed, 19 Feb 2025 15:20:47 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [Jfs-discussion] [PATCH] jfs: check agwidth before calculating
 the control page level
To: Edward Adam Davis <eadavis@qq.com>,
        syzbot+7c808908291a569281a9@syzkaller.appspotmail.com
Cc: axboe@kernel.dk, jfs-discussion@lists.sourceforge.net,
        syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, kristian@klausen.dk
References: <674e82ce.050a0220.17bd51.0040.GAE@google.com>
 <tencent_F56949906EED6EC90C8027D0C6DFD2F84606@qq.com>
Content-Language: en-US
From: Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <tencent_F56949906EED6EC90C8027D0C6DFD2F84606@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:610:b1::34) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|SJ2PR10MB6962:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cc8e8f4-ac79-4388-a3d4-08dd512b4864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WE5DUXBzNnpYMURDczRkdmFmTHdJZ0Nhd282cUNwdy9DQ2pYM2lBWGRZZytu?=
 =?utf-8?B?TVJkZmNCMWF2QkwwNWJud3NJK3FybnNTcGJpYUFmcldRTkhKVFd1NzY2Qnk1?=
 =?utf-8?B?SWw0TmtseUJwSzM3NlRub1ZxU295K1JNTmVFREhHcitqSXdRMFNsNy9UQk5j?=
 =?utf-8?B?OXU3Y2JLQ0M4cDNKeXBmMlk0OFR5c3VrcThBSkNTNDJtWnIwcUVsblk1NjNz?=
 =?utf-8?B?NkVGNWhIZTB3dHFZOVNiZmd0VG1jUGxNQU5LU0FTVE93U1d2YnVpVFI2MDFa?=
 =?utf-8?B?aGw3TjliRWJORTJuTUppaG1UYTNHdEhuZ0dWRzI2c29pR3B6QjRWY1hVQzFh?=
 =?utf-8?B?d0RwalhHZUhRcmxXbFBJUFRMRFVrVGNOK0RzUEZkUUVRZEpBQWZpMjMvZmx2?=
 =?utf-8?B?UEFTSTlBenBnMkwwWm9xRlNjQnR3bzJ3ajdWZUZXNVlMaFpnTENZZjFRRUxW?=
 =?utf-8?B?U0lYVTFrc1VDY1A5UzMvR1BVOXJVRm1wUHJGZExYQlU0VVp6NTZHeG90cWk1?=
 =?utf-8?B?WnlzQkNrb2lSN0N5QW9wQ3MvQ2taamszUzlqZ3NNLzVsamF6TmxQcDVZSVp6?=
 =?utf-8?B?bUxZd3NHbWZwTDBkcVRzMGljYm1yS3VHRmh4SGJKNXVsVlVaR3A0a0dtSTNR?=
 =?utf-8?B?NEFKeTZSbGdWOGVETTlMa0lybWI4QU5LYjFEVkFkV2hCZUdQR3Vuc25zbkRn?=
 =?utf-8?B?U3FJYmpzMVJRWVhkd01wNHdYUDdQK0RVRU9BbU5nTk9GUitJV0dmektNdTVC?=
 =?utf-8?B?VGc1NzF0eHdCcENRQTN3emViQk4vSXdOTVBBekZuQXhUcjY5bzkyOHRXZ1Vl?=
 =?utf-8?B?TGRKeXV5amhuUkhlRjNFYUN5MDJiVmtsdVZMVFRYbWNFclFOVVNOUG4zbDlP?=
 =?utf-8?B?djVzOE0yd1pvT1pER1l2UmVHeG9oV0VvVEpnTjJSTFhRU0NjOGVqWEpMTGg5?=
 =?utf-8?B?WHllaXNweGNBcGRpN29JZ3pWcDhRSCtVWWE0K0NFeDZ5WFdLbjN3ZGF2eFNu?=
 =?utf-8?B?Z1RKVHArU1YyN20xbCtQOHR1QUw5MVEydWROTVRVbFpjOUNTbm1oeEI5ZEY4?=
 =?utf-8?B?TU1LTERMLzYycTN3NktoM1p4cWx6aEI1M1ZnTnVvNytzTmlmcVh0V1daVjha?=
 =?utf-8?B?TGFOa1JTMk9uR2pmaU0vbDhKVWtnNWNJZmlkbTVMeThXcDVpZGl5czU4K2E5?=
 =?utf-8?B?clh1UlI5RFM3ZWU4eWNZYnplWU50UDhPMnNhcGZUUlpWdFgyeWZFYmd5amZM?=
 =?utf-8?B?SXF5Z3p3eEdpVWpJN3NUcHp2YnVMUnVXbTNWUTRwZVFiTkRyNFNFZWlIR2gv?=
 =?utf-8?B?ODFTQldtVnFZRHg0WGxDYUZicXlBd1BSQ2ptemc4cnd2VXNKTTBFelpoVnZC?=
 =?utf-8?B?K1h1ZzIwUmY5QW95TDNuTnIwb0wrWkEvT1gwVXFURkgwNUVjK1B6L0xjY0cz?=
 =?utf-8?B?cVdqdmJ1NU8yMmN0MTFXNnJqNS9VQkVoUDJlUHpNTnlUd1lxSVZDbS9keVRO?=
 =?utf-8?B?L2M3MUNVTys0ZUd3VlpBZENCcHFPRml4NU5EN1JQMGgrVWFqK1RXT1JNTlJ5?=
 =?utf-8?B?VVJDK1BMWjhwVk9hckxOQk9HZW1EbjlINndxd1RqQmVtWG9BdjhKeFdBbnhn?=
 =?utf-8?B?ZlF3ZzdyL1hrRjVsQ0MrOXBINkxaUGo5ZFRmK0JpRS9ZREduc2hrMHRLeW5a?=
 =?utf-8?B?aWFEL2x3WEFZQXBoNXN0aGYvUE1hNktuYzdHVFRNWE1iRDc2UnlkMWpqQWkw?=
 =?utf-8?Q?OLegk4F3XYHBkxDguIk9LH06GFMy2gN2TknMFyt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUpadW02VzlaKzYvdDBLVnhEajlrenRzQ3lPamxoQ3ozZXVneTJrb0g3Y3c2?=
 =?utf-8?B?VmdMVklGS0gzRlJDdU5YM1hOTGZpMDhqYWtlQU0rU3phMUhpanpCbFVkVEJ3?=
 =?utf-8?B?MGo0TkllNUROSG9nc1R2Z0xsWU01QjJxWUt2MUs0MzBXaEhITXllT1o2cEYw?=
 =?utf-8?B?ZnBCb0RUYWJtaE9VWWZvZmU2TFFDa1B2RlVVV3FNc3M5UmhyZFZJNUE2Y29z?=
 =?utf-8?B?dFhhT2pIOU1HbTVNc080NkRCQ3puSlRWNlpLN082Z2l0NlFoQ2tWaDhyeG9U?=
 =?utf-8?B?eTBwc0xQa0k3cktybzlpZlY3V2YwWitiWUpMYmRRT214MmRMOWlWNC9zRnJ5?=
 =?utf-8?B?ZW8vUzJQUTR2Yzd6emNWc2RibitqaTd5enR2NXExcHF1MkJnUmhJQmxJQlB3?=
 =?utf-8?B?a2NTS0RJcVJqeUJiSHVCbEE5WkpTOGM0QUQ5UndzVDRURXIvYUdUZUgxa2Fl?=
 =?utf-8?B?bHpXa3IwZ0I0cFdZbGhWd0dyRSsvd2tlc0JQTk5NT3hYd1BlaHpJUE5tSm1I?=
 =?utf-8?B?cUgyT2R5akwvU0pjU1Vxb01SbGVmcVR1TXBqRVM1QWxwa09EazFHU0s5TFdC?=
 =?utf-8?B?OFlROEkrOWdMaHptRndKdTZPZk9ScHVIMzRWbVdvdWNnVEF6b3l5YjRvd2RT?=
 =?utf-8?B?bzhpdmhNWXdkMERNS3FQQll1N2JmdTRlMmRhZGU5VHdZejlCNkFiblgrSEd1?=
 =?utf-8?B?TSsxelBjSncrNit0YlRUVmdEZEFLOU1ETk9lYW9DVnc0aTdEWEM3dzVFbCs2?=
 =?utf-8?B?VEZaWHhhYk94Ui93bWhTam02dkVaVlpRa2N2akRHazZOZWQ5bmN1S2IzcGxE?=
 =?utf-8?B?RndyK1hVUGRHdlkzZGwrRThKYWVzVnFZeS9RNHhhN3ZYUFV2dEdReGVDWDg2?=
 =?utf-8?B?VGxaV0Z2T3dTN1g4WXlmUmFPWEgxWXJTc3RkWEMvR0w3TUo0TExZeXl0Kzh5?=
 =?utf-8?B?OUUzYWVjci9rUDdlUHhvMEFsWE0rcFVmeXJxVklQVngvMUhsWmhmUE8rU2dk?=
 =?utf-8?B?eFFZWXN6dDIvNU02a21QSndZSG10QkU4b1lPR1JINHpaeGhjelZYb0V1b1h6?=
 =?utf-8?B?cG1HUEhrdmFsZ0krTFRmSWN3YTlnSlpTaEhMa3hMcTZFbVQ5bFhSUlNVamk3?=
 =?utf-8?B?UTZlRjBCaDVMc2w2MjBCVk5ZYkt0bmZJWVlyR1Q4RWlUbHc0TVQzYitQa0VD?=
 =?utf-8?B?YU45NGhhTDQ2c294dG9XelgwdXpLdW1McC84S3BJMTY4enMwcmpWdDFQN2FR?=
 =?utf-8?B?WmdXdk55UHR2NnFTdXBubkRHdTY2N0FCZ0k1RUJYay9QTTRIaXI1cUZ0RHB4?=
 =?utf-8?B?a3BqUVFqa3lkbkMvYzR6djBFOEJLYTQwY05zdlFFRUZUcFE5RDN2b3liREFG?=
 =?utf-8?B?OGNjbXphRGQ0S0lHME5EbU11a3NZNFJZUmNHNFJKcEZka0tzbGtaQW03Y2Zp?=
 =?utf-8?B?Z1VpK3JYVzVpOE1BS3Urd0JYaXphVEtKYkZzZlc4UnZPdzdMN0V3UWVmbWNu?=
 =?utf-8?B?RnM4alhEcDJMS2k4dnFoeTR2bDI1ak4reXMyYmpEVUVwM01IVE9oSzZHL0hH?=
 =?utf-8?B?RDRJdTBaZ25FZmxKZUZKYUNoc1R4SEQ5Q1lUTHpvNmJaT3FzK0oydEYxeVVw?=
 =?utf-8?B?eXViWnVOb1dqRVNlQytXemFVVExIYXNNYjBobVlkRkNtYnhLNkJhRTdJaUJQ?=
 =?utf-8?B?QmozNkRvTjBUcnJWdEptVytQdUVwSzFPUjJ0MXVOakJxbVBMSlQ5WmwxZzB6?=
 =?utf-8?B?L3gzSmdLY0RuckxYZmpNUUpyWnZpWmlCWXFSVUFmT0xseUtncmF0a1VIcnla?=
 =?utf-8?B?dzdZNTJTOEx0UGpTVVU2anlvOGFGZXJHUFVSMXVseTVEYTFSMUlCdW15UVdy?=
 =?utf-8?B?STRFaGI4SXdlZ1VnVllGOWNXY1Fjd212NTlPOXhBOTRMdTJhWUlnWXJJWVJZ?=
 =?utf-8?B?SElsRi9XK0VBNUpxa3VmYVVPT2JvS0dZOGhFc0N0UmRZM1hJTmlJNHNpK3Jl?=
 =?utf-8?B?cS9Qa05QaGF3bU51Y1JmVmlacXFzeUZvL09reGU5cmlXWFgydFE2K1dLY2E0?=
 =?utf-8?B?OVpqTWVjNGJDSUxUeFpRMmtIdFZ6QTk5WHNiQnBsdkpmUmFINldFVDBMMjND?=
 =?utf-8?B?MDAweUVJaXl6U3B3L3Nob0dWb0FUaWRUb0QyQXUwQTlJWW9yWGFaMlh2N1Zx?=
 =?utf-8?B?YVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MA6t4HI8+BWbcKId3AwTIqV+vFZsR5BUsb6DN7vQS38Kravl5uPCicTyMWBjNnyQaXQFtvxTOMY2H6/Qc+t+lMH2yCwxVwskjhtukZC5k1Akxui40B15jd7NXX+RVudkfDoKypaBAmDlO64hIdTNqReglMH5iTdZcxXCxKeUEn6Yi6KZKIPPT8B6ww4S+ltoJX9RX6fLQzLU4utCdHjN1JHyOTRjvoVkRZgYvS3T38gHrKY2crMqCUw9a55Nh347YUFVX1XDMTO+hE7r1xcRmB1HvRzG4gfjpYrz6TtNbOeTpQ07rIRqfn0eGtsGYt02HVsnAnV7qdv96XWLl0vZFxcGpNLKnI+/EzE6CF5VS3AKD2tauZ04Ac8IyBzYZNJvwYGkYZNBAlynkMsQno0qF/Mcg3qfbwNue7ZQj93nISyR7LEVV5imYde9cgAR1WnOmNCsgtrEkZpytn1crjWvtvyXbTkIGbr5+x0Ju15O7VbBcm1a+pfayjupu9KBrE+Nai7rWoxKwVzx6CCO6VYicg/q4L5NyohdEEda3R1bRctXtH3wa3VN8WMj3tr+DqZYhz9AZJB2Cy/JHWEoO8CNroKXnlADGdR57f+TOSew6+0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cc8e8f4-ac79-4388-a3d4-08dd512b4864
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 21:20:49.8515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BWBrloe3zqP4dtjy8ozRdulPVjo5NbSksC9Mz2xyGial9zZXOBAWNmFGo1g95cIY003WT6+dgk55N19RZzanPozwYPbygbKmIg19i7P/RGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6962
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_09,2025-02-19_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 bulkscore=0 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502190160
X-Proofpoint-ORIG-GUID: t7WDs98Nbq8B1c0fhLPO6RlNO-_ijF5m
X-Proofpoint-GUID: t7WDs98Nbq8B1c0fhLPO6RlNO-_ijF5m

Catching up on long-ignored emails.

On 12/3/24 4:22AM, Edward Adam Davis via Jfs-discussion wrote:
> The width in dmapctl of the AG is zero, it trigger a divide error when
> calculating the control page level in dbAllocAG.
> 
> To avoid this issue, add a check for agwidth in dbAllocAG.

This value shouldn't change unless the filesystem is resized. I would 
prefer that the check was made once in dbMount().

Shaggy

> 
> Reported-and-tested-by: syzbot+7c808908291a569281a9@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=7c808908291a569281a9
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> ---
>   fs/jfs/jfs_dmap.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
> index f9009e4f9ffd..2377102d9c4c 100644
> --- a/fs/jfs/jfs_dmap.c
> +++ b/fs/jfs/jfs_dmap.c
> @@ -1373,6 +1373,11 @@ dbAllocAG(struct bmap * bmp, int agno, s64 nblocks, int l2nb, s64 * results)
>   		return (rc);
>   	}
>   
> +	if (!bmp->db_agwidth) {
> +		jfs_error(bmp->db_ipbmap->i_sb, "width in dmapctl of the AG is zero\n");
> +		return -EIO;
> +	}
> +
>   	/* the buffer for the dmap control page that fully describes the
>   	 * allocation group.
>   	 */

