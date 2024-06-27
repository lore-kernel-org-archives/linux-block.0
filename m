Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D69B1304A3
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 12:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719490559; cv=fail; b=KbrXR36Jpy4HmsGkGm2eiEWTTacRzG0HytfuHQygklUvKXFjZjr5tGt6WZhnJlhpDiD4SRpMFZzioG1TzEpfdObtYtKyZLEZXmf6OqYrePj0v2vlG2YZfpz/4DWhqFWz2oOpBstL2+d2dLT5YeTLt0GyL2CbsiumlrJseaeaQRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719490559; c=relaxed/simple;
	bh=W/PSV+k3f2DkP9H4jKFd9ItYpPBZSYlnRZSLaoGdtRI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FZmvmo4IT80+CdQg85jN7ZCtBoK1PGTwfyWQHna9z3RFC3MP2PdjMZnLylZuaUeftRDJLmd5lr3YNyO+0yUlPX5XJsarJ4ZUJqRywOArNm5d0pcZnYAPre/qqQ2aUGLH/Yr624tgoDFU9cWl81UD0r7gmdC2s57QJis2mxm4yMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JLDDzPrD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cRxF34Pl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JLDDzPrD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cRxF34Pl"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R7tVEW019308;
	Thu, 27 Jun 2024 12:15:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=/qy0KJyZPXD93YvDXbaDIg0BwriAMBvYM6BguRFCcGY=; b=
	JLDDzPrDATmd0W1cjFNvBwiJ7J4OZAPOMgTH+RN0Cmutu4HxszqtCJJ66itKsyMk
	szjy960FYE7pE+njEd40VXSFpw8MCUhmsV0HC63+jkN/eUkRdepT5b+5tqksB11h
	GXxqKcldTpRpFeCU4Q6DUZDM37jlFcUcGdMCZKY7HDRruvPuH1l1c7P51rSSKVDs
	GI1b8gS08EeJi7h0jq+2dSRtICrI/MFR3s/GafN8UFqAXcJmwNEMeUSq8hm/wm7D
	pgm8vRv/lrs0lgARLH3vzNplw7KwQl3spkH0mI0dQj38aGt9A+14N2yXGY3H0W+E
	x5rjqarr+Cy4u6Kzf/NlEg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywp7sntwt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 12:15:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45RAwiMa021450;
	Thu, 27 Jun 2024 12:15:53 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yxys78f4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Jun 2024 12:15:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PO6i3APC8TJm8bA4dtQqMMwKJR5izKUjSPlJmh4at1ti+YFzl1bClK2PnENcRbt2pOe9BNjV5rl1T1ZrLDHnMUlki2Q4TCcJvjch4VPnkRNiCWYRd2q5e7iAGeozs1WkL/n/6kVAQRiDAPnoAE7n8yARhvkQHMcKLMhwgY1TgUp/4QsVmmjQJiR8Avve5eORwIY/YK/+URKI0ZNHVFR7SkxHK5lV2MpE9mlyvGKc4WsGYKLZW4mvNfNfhO/G/E0Q6axXcPUeLCqKyZixD7FBl206o5dhVZAjKBQf3b8lG2kxldKWyUX/dDAVJT43yNlnNoLx/ULG2+8lEzSiReQ/tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qy0KJyZPXD93YvDXbaDIg0BwriAMBvYM6BguRFCcGY=;
 b=jtW4kZ4iXL9pz97nMk7brNkbhNNaQxI689a4eOd3xfDB1Vln134NdvdgSPJTK3NTpHe238fwgghZtnEOzLvXqd+SIWFEX7jX9Cwzf5cQTrP+MHdb1mMbGfBzg+bVPWc1mhBaBIoi8H1SkdhNsUc/QY0BzkBtPTKdQx0eO7ktgVDBwaRD7TWeYDW+SFTbiknUg80QaN173y+9j1clp0RSX5qcctar31REVSKYS6o1pwKlKYopw90+WiMfo/c9d4M3qJxu8OEmovqongP6Y9Svam7WjUsfhIA496Nho2Ydn6U7wtJOJue9yQewlYRePaghxP84Wcmo4qD5SB0Wm1gChA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qy0KJyZPXD93YvDXbaDIg0BwriAMBvYM6BguRFCcGY=;
 b=cRxF34PluQpGTgWHDiojeo+M96tNf3LSzCEBm+49TcjHwGWnxNg0A4y/M6Vkp/EtWZQltC7aLt0Z4mz2KWaedsXZpT+WvVWE5VV/vkAzROMNGEYgV2PiWXYBSLR0BbEpZhjd6gfyCDcFG1aPYzx59m/44YSPxJOH6ZC6r1W0LrM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7068.namprd10.prod.outlook.com (2603:10b6:8:144::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.32; Thu, 27 Jun
 2024 12:15:48 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7698.033; Thu, 27 Jun 2024
 12:15:48 +0000
Message-ID: <777c466f-e583-4669-a4e3-69a2edc16232@oracle.com>
Date: Thu, 27 Jun 2024 13:15:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] block: add helper macros to de-duplicate the queue
 sysfs attributes
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20240627111407.476276-1-hch@lst.de>
 <20240627111407.476276-3-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240627111407.476276-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0021.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c1::12) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7068:EE_
X-MS-Office365-Filtering-Correlation-Id: 964bf1c4-92f1-48e1-ace6-08dc96a2e0eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?a3BqTU4vN1p1NXpIcnBJdlRzUHoreWhOZm1Cc1NibGt3TEZBMHhiRnVBYlRP?=
 =?utf-8?B?YzNWeVBDTkVMOGxPYUIydG0rNVAyS2FZM0pyRW1MWnRDUHRPWklENk56QjRv?=
 =?utf-8?B?OWZUNFd5QmJHOGNDQWxGVitmdlBiUG5oRUgzRzVHN1AzcUhOL2U2bVgrSFNV?=
 =?utf-8?B?cksvVGZBU1VnekFpQU1SODlKbzZKSHdyNldaVVRmUmFtSXIwcFYyN2hEanBx?=
 =?utf-8?B?cHRoTjIzbHUvVDZlaGY4clpDWEJYU1ZKVG1pZTBQekp3eWhZYnI3YkUwKzRL?=
 =?utf-8?B?MXFaK29CSVhWaGtUVEdGZitET01RbUcyNWtkTVZ3a1dyam9BYUZmNFUyWXhB?=
 =?utf-8?B?SGhxdkpxQ3dGUmE4V1dvKzdsSldTaVMxY0w1dkhFbHAzSFZ2d3Q4dUhaNnBv?=
 =?utf-8?B?UXp2N0JPdFdJZktFY3lQK0s2eGhJWUV4MWdXbDd1eHNRWFdRRHh2NW52clph?=
 =?utf-8?B?Tjk5T3JVQjh3aEJxNVRtdHJndUkxSVFUdUtBQU9ETXdEd3N0VkFDOXg3RGFz?=
 =?utf-8?B?OTh3MGE0MWc0ckxNSTBoQzZhaDc1ZjFMUE11SWQ5TE1pM2gvWXI3ZW16czdm?=
 =?utf-8?B?cUcyOGxTV3V1dlprTjBqU25UWWRLVGRjNm83czFrN29pK00zcU95dTZXK2d2?=
 =?utf-8?B?eDhnVUx6Z1pnaWVWck4zTjJRZHlrSTdPdjdHQ3JYWWxRTUhuU2k1NE9QUXRU?=
 =?utf-8?B?VFNobEZrNFVGUXhsRlp5cVo1SE9zZGlIbzBicGlSSjlIR0ZDRWU3bkJnMFds?=
 =?utf-8?B?Tmt4bHc4YnduQnRRWGdjY1krdDd6Wm5sNVl6VERlNUJqVDQyL2hIS1FuTTdR?=
 =?utf-8?B?MkVWMHVIR0JHaEtVbGdCay9Uc3RPUDhMaXZraDhKZzR2cHBYT1BrSXpIa2d6?=
 =?utf-8?B?QmhBUkZJQ2hXeWZYN0NSbVB1bkNjRmlQOGVDWHV3L0hiOVNpejhVMmwwR0Z2?=
 =?utf-8?B?Wk5hd1pJMFUrajY5eE90MHNWVWdjUHpudTFSdENBSU5XdUZlQ01OQ3F2WG8w?=
 =?utf-8?B?RjNGUE9ZVTVmeG8zcmZtZzFxYlRNVFE4M2dxRTdTZUMxbitMZTZYNE9xMlNP?=
 =?utf-8?B?emExSEt4akJGTzV3OFVRTlhBRXRPVjUzRGsyYitmdE5QWlNkcERxTSt6T2JD?=
 =?utf-8?B?RXVxdmV6SENFUEZTSzVwaWR1b1c5MW1qcUNMUVF0UzZCM2hPa2VycUxpTE1Z?=
 =?utf-8?B?RWZWWDZtbDliUk5ZVHJVUFpPQWxDZ2hjcVR5RWt2a1NZcUtnWlpFTzFMakZ2?=
 =?utf-8?B?bTlGV0krbTlBb0lJd0dPdkluMXZaZ2Iwb054bTNIY0NIVHN0RmxkZ2tab0pY?=
 =?utf-8?B?am9nbExQdnl6NnZ0SWNWSzVBQjU5YWhNRk1PWmVvZ0JmYmNlbW9Hbnp1UDZl?=
 =?utf-8?B?OW8wa2tJSTFIb0VRdXdUTEVESE1DWnJFNzFWeDYxNTJnRm80aGVESnF4WTQ0?=
 =?utf-8?B?cmpSNDJlelFEcEVOOHJqZzAzd2tuck1mRXhvU3hOVHUvKzFCTWxpZ2tiTzFI?=
 =?utf-8?B?U1pOTzBhYy9UR3N6bGxvaEErT0ZoRkFTSHdOM0FsRmhPZVgraWhPSjV0R1p4?=
 =?utf-8?B?U0ttdUpTSFRJTmRVQmFiVHFXQnVRSURseVdHbkM4NmEzczVOU3pFb1gxRytT?=
 =?utf-8?B?VWpOOTd6RFhMSUhlUERLV3VZUFovaHY4M0VXS3ZLdjJHQzFHUE8wM25kUDhC?=
 =?utf-8?B?NE04c3N4ZUN3UHBCa2g1amV2ZmltSTFGdjRjUmZrRXVBbmFCZEI4K2srVUtp?=
 =?utf-8?B?Ti90REd3WXlHcjVYTWdCWDJtcUw3eDdxbVh2bXlNMDFTUS9OWktOV3dzTFRS?=
 =?utf-8?B?eEFPdTNUZ01FTnllNmQ0dz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?OWFiUXc4VEFuUUpCK2dDK3g0MjY1QmYzN0x0Zm9mTlhNRE1NdmxKZGhJTlg3?=
 =?utf-8?B?UHZReERUZ0IyaXZnVG9MdUY0RXp5WlJZZDFGeFpOWi81YzRDRUhsbDRsT1VW?=
 =?utf-8?B?bmxScVlSME8yU21aRVFld3kxck9zNzBwNjFhNjBreDV6d0lZc3p5cXYvamZ6?=
 =?utf-8?B?SXk5T3d3OWlCNUhKSkRtalczZW91cjhrdlRJRTRyOEdmb2ZObUdRK21XY2Vp?=
 =?utf-8?B?WmxZQk14eldCaHFnM0kwenFkbGhybVB2T1JQcGd2Q2RnOW5JZVRtMDB2a002?=
 =?utf-8?B?T2lSTXNQL3V0Qmx3VVpERlhPYjRzR1o5Vi84RHdLdnMzV3k5cEljaitFajl4?=
 =?utf-8?B?R0NhQStwZktLamFVS0owN0RuU1JRZFNzQnQ0VnNVUGNFZW14WktUbzhCbDUr?=
 =?utf-8?B?MW04T3pOTUxzRHB2NUhIZjloMU9CSUQ5bGt6L1JEY1Q0ekVwdWcyd09OMXUv?=
 =?utf-8?B?M25vNHV4NGxFOVRPNGRnZXROTkJId0RCNEJuNjdValF3V3NwSmNLc3B3VElO?=
 =?utf-8?B?RkRwYnB3R09UcGs0a2h0TFNmbG1jdFltNFlzV2lHb0I3WjBpNFN1VDROQi9u?=
 =?utf-8?B?TWVla0ZZYTZwaEt6RWZ2TDdHc2hMdUNhaDYzdmRYRnhUTC9SRVRSV3dTTnpx?=
 =?utf-8?B?NUdueVpGME5WYi94WEpEb3N4cXF5V2dYM1lDaHdjTytpNG9YUWxIcVJ1MlBY?=
 =?utf-8?B?NVlNNjZRNHBhYlo5RVFwaXQrVjZUR1dZTHROT01ib3FxM1RZb0ZEQlJlVDI2?=
 =?utf-8?B?Zld5MjAxWFZxaitlQUZmcjh1VENPbjU3a2Q5ZmFpMkVJQVo2T1pjcW5NU0VF?=
 =?utf-8?B?V2F2bG5JdzZRTVBKMEhob05mZStmWTgvSUw5L2k4Y1ZyajdST0phUklud05V?=
 =?utf-8?B?TmRUZHFWNXhIeTRRQmdza3lMOTZEcEhvOEZ2QXBxcmt5SnpCaG8zenVnWmJH?=
 =?utf-8?B?WXMxb1Vma0RXck1uZ0U4dzlGYTVlc3pJalpMbnVXQUEzQTZKOEVuMis0WFpu?=
 =?utf-8?B?c2lJV1l6UlRCMHJJSWxPdXMwWk0rb2JqdHRreFRqVC9yTmpoZFRRN0llaFNH?=
 =?utf-8?B?QTdwUE56bHp3Z056Y09iU1pTbnlldCtQOC9MRmx0ZXhjL291TS9PTWhoOHdS?=
 =?utf-8?B?bmNVdmw3TzdFNGFDL1ZyVit2ZUF6MTRvN3YzN0hKcW9yVVpySGYxVFVwWUhX?=
 =?utf-8?B?U0c2dDd0TVJ5eVE4bUd6bHlFVGlQUG9TeFV2V2RtQzBGRGtaRDh2R3pHZGUv?=
 =?utf-8?B?RElmZHF0VGlRRW82dzlWd0FlNVltbHpzS0daVGJuYUlSY3A2bkdjYW95WFdK?=
 =?utf-8?B?WXNzU2FCRUlzdlUrclFkTUh0Q2ZSYmxXTmpwTERKMjlSa3NIMVJ3TEt2TVZP?=
 =?utf-8?B?THRqOWpJaXBhOHZjNUN2ajZzNVJDa2hSWWtZMC9pT3psRXllNFozR00xejBi?=
 =?utf-8?B?NzFLOWkrV2ZYUFo3UWR5dlVyekpYN1lvUUs2VStMNUhSQ0J6WW0wNVBMcEJl?=
 =?utf-8?B?SG4wY1Y4aHVKVjJIdUxQb2dMMTVKUGVDMndqdGUvajBvOFZaWWFZRDUyT1Nq?=
 =?utf-8?B?ZjMyRGJYRnpjV25mc1hUUlNjN0xGUTM5VFh1czkycHVNczA5QU13OS82dElq?=
 =?utf-8?B?cjBEbkFLZm9SN3BOYjNYV0Ywc1ZxakJic0ZlTU9lZzdtNytWQTdIZlh0c2VX?=
 =?utf-8?B?ajQyRHRLZUZCMnN1U2pISUFpZ0ZUdjEzYnNCcGlQUWFBTVpjSFFEUFR1UTh3?=
 =?utf-8?B?dzdrVFhJRzl3NHUrZytCbXMwMzhtSjNWRG9NQ2pjVERIMktDUWxoRHplajhC?=
 =?utf-8?B?VlBlMnZuaFV5R0R0bFEveXRrdlYxZXRrRCtTVGtNSHdzSlJqWTZNK1lSOGpj?=
 =?utf-8?B?ZElpTEM5K2JWMURiQ09hOTBDc3VrZHVHTGR4eXo4MGFZWXBZMkxMdjgzOVpD?=
 =?utf-8?B?SnNQY0NPajRSOTU4aTM4R0lMNlZwYWY2OWRZQXZ5V2dTSjJWdzZPTnRuMENa?=
 =?utf-8?B?cktvaEp4R1VNU0xKNnhuVUxNMDRBbmgwWHBrdGxPTHhqWURtNzVkQzg1ckM5?=
 =?utf-8?B?ZGFoUDdpbzBiNW5ZdTc5ZUdRTHdaTmRGQ2VNdC9LQXlVWk9JYU9rU3R3Rk8y?=
 =?utf-8?Q?1E3TaYjccCcqmAUT0wMKkql4L?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	untxZmd1wFNGiNqv06qqzl2UA82FN0A8mfDkic8JHBBOGsd6V5vDTvv4ZTL/gHJfiVI4THIa1wRg948WSYXcY1vGGdAlpEC+eT/Se90xPyWPKeNz+sPgMewdyDDbEdbvhQxMvbR+cQE9dWkOVsUzUGzFhXXaBhUgClbYDhwAqpFkK6Bh8buXt1mbNCgYPFVifMjvcd9BZhH1deY2V2EnrKI01bSC/O+Q4RCEygNw9loIkZB/s111PnsRzvUUH5vb3j4CvoCTJG25mdqeAeLt2H7W/2tZSsItrnXBs9WkrSlv6ajdaoRdEoZ92dzNvCJnHRVgpatLuieNrdvtMnG+4l9//uTZowdXMHU6tASxG4kWp3YJUs5zSFfGLR6Orkw+59mwoinT9+ydyK1RZIHfb+MAJTIrXGx8EO2SYdfy5FQ3PlavAZ+p8Mb814DeWpG4fAAx6g3TSCtoqR93ACwS9tkWKcFLbr0fE9P7FZY1QDT3LxyAIgdpMDeudDZvDljnYrk60sm2RXbNiWmH5YF6WjyJuCwSwsWj2bFRhrRSkbSmyqamvPVYVWero+t9im5B9lk0Zdyq+81sHrSKefiSUMc3IeFNzJmTSinUrjhdkPU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 964bf1c4-92f1-48e1-ace6-08dc96a2e0eb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2024 12:15:48.4808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7d1sMb7ImSoGOywF0VN+dU9VBL7hhdtkMsPq+zkByBeZadmF17U1mXnQChVjPx6NwNbM5m9fvCCSgDxhAUik/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7068
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_06,2024-06-27_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406270092
X-Proofpoint-GUID: OTLVybzRAsakua9ESNybBH97KQe_Mc64
X-Proofpoint-ORIG-GUID: OTLVybzRAsakua9ESNybBH97KQe_Mc64

On 27/06/2024 12:14, Christoph Hellwig wrote:
> A lof the code to implement the queue sysfs attributes is repetitive.

lot

> Add a few macros to generate the common cases.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: John Garry <john.g.garry@oracle.com>

