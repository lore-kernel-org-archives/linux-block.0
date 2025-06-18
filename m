Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7C61210FB
	for <linux-block@vger.kernel.org>; Wed, 18 Jun 2025 09:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750237606; cv=fail; b=F0OI5YIwwxbK16kXUn9iF6oO5YHs9hVMgDBrf6FoJF58+DXT1Tx5fJ05uFDj5guUcSpGiCTZB64WyIXRn5+5QV42QyTQ9hTHi4VPYY0PYuU7cuOrPRvEGsyqypwGtEnPfMsA6meWAhf8Z/OHhY0FCUlt6zd+rqPegnwMyc/ffgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750237606; c=relaxed/simple;
	bh=PfY6rXGrsBMVZ4jw75lUH98DPtjNW1sVvEdc6pmF0pE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LOxyHLVsoNqrDqRJMw/c4jMYQb+ySOV4KdGz/cEBTMAwx0DIQvxC+oVstM5z7+NKmOjM/Eq1VG33MXVflPoK/ztOYBXLkzccROzTI51W46OfRkHtyHM6SrtjgPGEqM96nCKeFA1DXeS29rJMaidYkgQwUiIP4nve3reft5FVN2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xi7pqXBq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ShGESJu1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xi7pqXBq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ShGESJu1"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I8fdpi002724;
	Wed, 18 Jun 2025 09:06:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=98jtuaafSQj1M1o815hkwT0MfNqKFHUagfKAjamAQpA=; b=
	Xi7pqXBqsJMVNhaV5pFeRymt8b4aCpIqzLuuPNHZIeN8uYl7gNZXlkxqcp/RN5hX
	GK2RCHHI3PT+FnLV5DtHQ4NOc8Ta3nlnSl+QYDPWz5jkqPDcJ9WTT8LNnOeg8+EQ
	begqCNhldP7nm95m5jMQuXJ8D0m09YjzG5grtkMSCXQ8IpHBjN3Qyn3u1t2q0S9P
	vzxssJ4kbgjH8+L3mmrLmXUDObt2B/NvS4iEgD3TcOhU3XkLBdo+Aza0MfA4HBjt
	xrQACrCdmB/Qnv2/vrZdslG03x/WWWYQYclYsX1rfulRUyk/DOQ659z+07vRfczl
	GVYzKEcODDZ7xHhcOmxRXg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4790yd7b90-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 09:06:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55I7WNMI026041;
	Wed, 18 Jun 2025 09:06:35 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11012018.outbound.protection.outlook.com [40.93.200.18])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yhgnert-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 09:06:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u5UqtWf6skwFbbhHMtcmv82kLiPD8fK+laAYu4aAUX9XamHRma7SwOIMHYH4dAu6k1DcAPqb11sIiADHpeJZudFXnw4Zj32uNBH+MIgJeeQcQGUblOfw7/v0NJNTj+IG89Pd7PNtA+kv782UbUitrRCwXeyRg2UNN28j5xPZaFuU2amRhmlGzG0MCE3FosF//VJ/8Pcl90qlJ11obtTRaHYk16el8Aba9j+/aHquxwQBpUiA7UNFdRPZczKKfoaBmn7E1gvL4gqH414zOc+/4YodE3UqnwdBxRcDIPbTc2fZjEc92oFiLmsYvVvf0wAATQpx93GwjBZ3+jQFqwnW3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=98jtuaafSQj1M1o815hkwT0MfNqKFHUagfKAjamAQpA=;
 b=Y4CrCdHHvybPn6eW8F0SXAyceQl0CLxyB/OwcvkoyYVDltN7XTk+ES+v1Lg5u02NcTKLOe7hQu6U17nCz1AnYx2eAm5cmbOpiZ900WIyyFkK4HTmJxIo3Hts9vg9sCxbj+5drJtZda96UmSzLzJoRpl6KDexF/usmnV2j6MXbDK7+zM8k9pUM1wC9fYP+QGEWsOW8FODsDgawfTNvaBNskJXBLktUky572+EXZT/oaileKCT2iZl5eJxMYDqdhXsXQ/oIKXCaejYzyFpaVzDEIf+vUwG7uWrU6HCTNTNfjdR4w/OeReo27m00e5JwssyR1p+N9JLXUUDNNfzWDJFVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98jtuaafSQj1M1o815hkwT0MfNqKFHUagfKAjamAQpA=;
 b=ShGESJu1GztZ+KEfA313Twbd6Zgj7LXDSlsfMfIXcS651ut69SY2UH2Mz4SGBC6klap1ryAAPndgKX9Fjhxt9/o/2k8h+J4sU0wHP4pMku957nMG1wM9fBNJOdOOIh/b+ioKPnPzHfGRZ1n6eh+GDRw37i2pV7OuGI/SSv0iX0c=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ1PR10MB5979.namprd10.prod.outlook.com (2603:10b6:a03:45e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.28; Wed, 18 Jun
 2025 09:06:32 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 09:06:32 +0000
Message-ID: <acc347c6-5b75-40e0-b9c0-ba70819bdcd9@oracle.com>
Date: Wed, 18 Jun 2025 10:06:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] block: Increase BLK_DEF_MAX_SECTORS_CAP
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
References: <20250618060045.37593-1-dlemoal@kernel.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250618060045.37593-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0014.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ1PR10MB5979:EE_
X-MS-Office365-Filtering-Correlation-Id: feab330e-3a2a-4134-a6d9-08ddae476b1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MEN0b2V3RkJkb1JoK29CZktDTmsyWXR4bVJMRXZ5WmtoWU02ZytKbGRJWTl6?=
 =?utf-8?B?YTlZb3pjWXlEMk5ZY2c1anZTUU9qY1pybWloV0VVV1cxVUVpSXppdWk5SWZW?=
 =?utf-8?B?OTNoSnFZelVZZEN2NTRMMTBrc3k4dnkvTzh2VnpZOHJRMlo0dzhMdDg2SU5w?=
 =?utf-8?B?U2lmL1EreXBwSndEajd6OFI0SHVELzI1SmpkUC9kVVIxZjVaMkVpTWg3TUhw?=
 =?utf-8?B?eEtqWHdmZHowT2hQUVRxaEVZeERMaTUwSzFKcHlwZFJhOUkwWFl5WXk3NWY3?=
 =?utf-8?B?TmpIb3EvTS9MVE44R2NUREFQMWUwci9hSkRqYnhQNXpPRmVFQzZMTDEvV3l3?=
 =?utf-8?B?REN5S2FGcTdBZ01MaDBHT0QxSHZqQlowL2JTNVhCSHBsTWE1dkw1bXJITzNI?=
 =?utf-8?B?Tnh3YW1TcEtvN08yZVdDa2N3K0xZemZnK3BRMEVLV05sQ01XMzdsa3FmeEEw?=
 =?utf-8?B?MTVzYzkzV3BWNHBtL29tSWZZNkdyR2xHQTdMaHE3bmJkMUluK3E4eUh1enhh?=
 =?utf-8?B?SnY0MTVjU3RmY21lZWdrQjE1NDA2dEN4R0F5S1J0UW5icWpRSldOK2l1cEJa?=
 =?utf-8?B?OElxWkxRdlBUYXYvcWNhS1R1MDBMTUE4SUg5U1I1cFROd2MyNTF3K00va2pn?=
 =?utf-8?B?RVpOUGNGTEd5YURhdVZsZlplZTR4eTRuM2NncVZYYThHWmZoZWlhZUFSZ3k1?=
 =?utf-8?B?TW5HM0kyaUxPTWVJZmcrcnArMlNJYnRCckl5NW1JbGlPVFRsbjBxaXpmQXVX?=
 =?utf-8?B?YlBNcXU5b2dmcmhmN3NTZjFQTjRHZTNteVZRWHNCQm45SGlyVGhrVThQRWFy?=
 =?utf-8?B?YVBsT2pETGtPNERYWkttUzVyYnNaS01tLzFFczg3K0VDR2djSnhzNjVmUTcz?=
 =?utf-8?B?M2tjTVh2RDV0Q29abWdSOU1yUUE3NFVqa015OWZUb2FVK3VvY2o2M1BENENJ?=
 =?utf-8?B?YVRWNFRYbkNCQ0xBWnZJNGg3cm40VlAvem1kTS9SMisyMU5keWpacWFjNm1n?=
 =?utf-8?B?WDNYc2RnQnVqSFBhU0hIMG91TWMvdTJEMW9SdnhlcDUyNTlBWkNNQjUvVURL?=
 =?utf-8?B?eVdmeGtyZjdvWERzQWI1bjJ0V011aDI4dXgrSTRyZm9tNnZtdmw3SEpMQzRU?=
 =?utf-8?B?Y2p5UlZjUk5iRXVGNEVuRklzRkZNRElvSUYvc3pySmZPUU1QSkZtaVU4MEpQ?=
 =?utf-8?B?elI5dFpPRVhOSG9JOGFJM21BcStRWE1xSWY0Z2pIam51UXNSQkp6SGIvV1pa?=
 =?utf-8?B?Njd0MW1UdGtQazNhdWNRd0tLcDFIVVJKTTRXNWlxaU9rd3RIb3k2c2k3ZnVL?=
 =?utf-8?B?RVRuZ3ZnMFBqRGJOOWg2SW9MZVdlQktMLzd5TlJQTTRqMEpJbUV1dy9kUSto?=
 =?utf-8?B?SGtlT3ZFK1lBQjhNcTBtcGVDd3VEZTN3V1pua2lPdndKeWFYMWY1TlRHREQ0?=
 =?utf-8?B?UHFnUGIwQmdEdmFXOFVFL3BIMmh5SE5CTDlkWjVqV3ZwSkNPUGllam90N0hZ?=
 =?utf-8?B?bGZGcjQxdE4vTVNrRERzd25GSHlJZkhITzZCcy9XdDM2RFYwWXcram0wNWIr?=
 =?utf-8?B?NisrK2NRQzhuamFYZlUyQjloaFhQMGxpUVBuTFNyQ0Z5WkljdGJJZmRlT2lJ?=
 =?utf-8?B?RFRiNVJVMnVic0MyZ0xiNkVGcjNZOVlZK2dXN0ZsTXJUSGxncU5rdVc2KzRS?=
 =?utf-8?B?bUFGNHFvVDRoNDdJZzhSaEloTGx1bFFxajIxMWd1VDZjeUtWWWlWRldmS2JD?=
 =?utf-8?B?ck12SVZjc2t5RGppNzA0SWN4N3JQNnlVQldtZE53aE4rSnU3UzUrNit1ZFZS?=
 =?utf-8?B?NWt3L2JDQlNIdzdEM2p0Tm0zUnR1ZHo1T2pVU2EzWU5WVGZYWE0yUnhSVVgz?=
 =?utf-8?B?SXhCZXlWN3ZJRzhUYUl1MCt6QWVic0ZzYUczZE9zQlRFWFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d0pkNndvZENiZ1hZZ21KQzVWc01vVUd4UFptWUhVbkE5R3VoczUzczBEbjhl?=
 =?utf-8?B?bWdEMm1EMGlJWWE4ZUNmVUVuMnZQN1lCb2hQbzlHcW0wRCtTY1VkV3BrRExT?=
 =?utf-8?B?VG15SXVMcC9ocmhDa3pvQXlGSFJYbVZXdWJoSHJwWERJaUdiTTY5elZ0TFJs?=
 =?utf-8?B?azkyZE5PWmtLa1IyY3JzTWpVaHl1QUpEOFRGNUJGdkRWa0JzaHhmTExaN0dI?=
 =?utf-8?B?eThTdlFOU3ZnN2h4MjhwT2s2UDFyWGtxSmIySDNRUnU3Ny8xUk1pV0NOSEtZ?=
 =?utf-8?B?RHJNTFpoNGs1S00wSGE4SmNWMGdvN0tSUmNJamYxdzVTTmZtbEwxbVRFRU1r?=
 =?utf-8?B?N2U5ekMyMC82UW1MT2o3ZmFNdWpJVitzL3dJTWxNYjE0K3VBQmV0U2tLYnB5?=
 =?utf-8?B?emdnUmNrNjF5YlptQU1CR2pTa0IyODBhTkFMNTM1V3hPN0N4VjhXRWlTUnho?=
 =?utf-8?B?UkRvdnpvOG5qRTRINjkweUZsRVdhMlRIU0VXNjVaaHUySGt5VHNTd1orVExh?=
 =?utf-8?B?Q3ZGUEx6eElZd04vUkFxUHhYVUNrVHdzb2QybkhEVGdHN1NJQWp4cnFnRHpK?=
 =?utf-8?B?MmJMSlNOaVpZOW01Sy9OSWpIWFdPY2Y3KzRVVU5KL2R1dVRHTGdPUjdGSDRj?=
 =?utf-8?B?dzJMWVdRSG1qVCtQUmdEMFJaMDViK3ZVU21DZFZxbk5ENiswRUhMakdYa2Q1?=
 =?utf-8?B?eGFKQk95bC9xNWN4M3JzRGRGS1dRT2hVNlgwbFNBT2gvc0tZcnlUaysyeCtN?=
 =?utf-8?B?ZC9pTXpzaG94dWpjUXU5aE03ODl4T1J4TWtBVTd5MmVOdEcyV29VUGdzeWhV?=
 =?utf-8?B?RVpYRHZoVC9PVVhwbk9sNndQR0FrSTRsM2ZTTG1iZ2RKa1FxZHl1d2N2aEpQ?=
 =?utf-8?B?bFljQ1cydy82UjV4dTdOSUEzVXVHSmR3MmJsT1pQU08yUkFGaEFxYW5kL0lk?=
 =?utf-8?B?Y05pRytDR2k4dUo3SmxDYUlyRVpySkxyWGJ5TVFuM3ZKRWpmSlhIOUsyM3Zq?=
 =?utf-8?B?NVZyTFh2eEdXSVNVbldEaE1LN2xVR1pNV3RxeWhUY0VqQm1vTmlEMFlxMk1t?=
 =?utf-8?B?c25RNG5UOEF3NFV0MHI4RkQwaGtrRzVmY1FZS0FUUi9vVmNwVHRteUhJVG5s?=
 =?utf-8?B?ai8xVzBXNncwUDl2UkdhUyt4WTVBNWxVRkk1VHZwS09ocUdjcEdWcU92cHRQ?=
 =?utf-8?B?ZFJDT1RtS1FyelZDSDl4blc3UWE3VTBtbkxhZDBVYldUcTRLQ2ZTaSt2R0pB?=
 =?utf-8?B?b0xYVHM2Uk9LV0JFKzNKY3MxZnk3UGVWbUlSMkJJa0d0bDBQSnB4UG1tZ1NS?=
 =?utf-8?B?V1kzd0VMbzc4YUV1eWczNWExbzIzVklITk5seXl5Sk9TSlpmS3VwVm11Y21u?=
 =?utf-8?B?ODUveDl3N2lDd3pJVWQxYlBmbXcwa0NJQ0RGZ1VRQkc1ZGRka25KTVBkVW1W?=
 =?utf-8?B?R0RkMVlMUHdiK0Zsc3c2THhVcDQ0bVkzM1ROK0VXMWsvYUEza1F6aDFLUVpw?=
 =?utf-8?B?MXBrVW4wd2ZFMmRLZDFoeFNyMTY2K09xQmJwT292MWMzS3RLZVc4eE5MeWMy?=
 =?utf-8?B?WTEwbEFxU2lZWk1JcnhZVVVpcHpxTEc5cnl1Y3E2cFhoWkRrb2l4NWhnZ2k2?=
 =?utf-8?B?Q0JBbEs4aW50Wm9oSFNSV25ycXIrUW5uTkJYblF0eitQalpzMjlmQ0Z4MFpW?=
 =?utf-8?B?SXU2ZmdNbXpZZjFLVlF2UWNRMExoRVBvV0s4cS9od2d0MVlvNWZCdUtzMGhO?=
 =?utf-8?B?dll3ampWVy9KbDgyai8xdlRXYmVsazJkeERGUVBYY25TOWlJUE5PTVhnZnJW?=
 =?utf-8?B?b1cyT3FkY3g5RnJWVUpaYVhLNXJOV0Vxdk9NNjJxZG1mMFVtOUlFbEZMUGov?=
 =?utf-8?B?aU5mNExlZ2pGOGVybm1GeHNOOW9pTDAweE9iK1VoZ3AxUldPSlN3c0NSSnNB?=
 =?utf-8?B?WGxJblk4SmRXdWJKV0lmTmpHc0pERm1US28vRnlLQzROWVRRL0FsRFJJcnor?=
 =?utf-8?B?ZkRwS0FOWVVmRWZBemdTaS9WRzZhU2w3R1ZsbnlNK0FYMGZ3a1llNU50VlRK?=
 =?utf-8?B?dE9FeUptQkdTR3kyZTBvUU5IYkJTUG4yZmNTbU9XVlErOENWUEczUXVUb2x1?=
 =?utf-8?B?aXFwUzlDZnpGVnk0eUpsTTRia3QrZ1p0MURtbndOVFQycFdGSitVek9SWm9K?=
 =?utf-8?B?RVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PpMNQImnFs+hSxNyVr/t/RFzGqjHgZl6BTy38p4mHjL3O7Bi+E8zcLo7Wh9a7Zepde52J586svJ83rLoDpcVtfZwz/Me/efUQt+KImwB0HHLhQWHqQpY1LCuVZIFOnN6gTR+v+aqy6fibZlaJXnuZl23OhgOK9q1tlV3MfL4QQFuoPNl/3wZrCVj+BnkqYq30c5mXQ028ZPX3hqR8CdbEy4iIzKozQCPT5Q7vL1AjVxSsnajuiDMtlB27Cdkdn7veTDGSaaUCzmUkQukshwLholN9LKhpeOUhViYZ940ccoHKB5k8jIoxGLEJJejnbUCYFmfPyrq5g9c43KbqOSIY10drGKs40ISPlEf5ELC/ryLvXv8+WLar/hVT+gEE5Q3d3T589KkDDH0ZL874a1jyY/sUQKdt9JDvvsh2OyDoDl3LOtIOgwbWj3Eplx8Pnfb3811jKjXO+b/5lOD2uOlWjX5B4o4TL5+YNgQsA/4mVjCl8dbbobKb8CAJ/2X9A6ABnNfEyebvL4d7K23XTehe791WZxnIZUwZV2BkkEjISZPOxMkvt5M+7XOmmvu5hClEldoJX+w7oa6d4F4SHUwNO2Opi2alflZfsoig3MgXU4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feab330e-3a2a-4134-a6d9-08ddae476b1b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 09:06:32.5087
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: faegJuacYvtMdJ9QW8w0jNbRnPVNWfDlWVvM4ruejpVMlhz3O9Nreq+uBwZMzJ6WC6lIP+qa36KaCznYFMhY1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR10MB5979
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_03,2025-06-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506180078
X-Proofpoint-GUID: 0iJiR-fQ6hr-_HvaVhviaG2K2mJZ8W3z
X-Proofpoint-ORIG-GUID: 0iJiR-fQ6hr-_HvaVhviaG2K2mJZ8W3z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDA3OCBTYWx0ZWRfX+/Ro2zly2egL tpb1FWtp5WvRK69UXkAUCC1PcEXgdZSvBXBSX8/B/iLVQYJre1Vw64fep9XBO4VF3XBV7g/lmFd E7jTE3E06K2fYFNegPISeLLMU5kYbfPzhJhC+B9TnleREf2TIvfQrOLRv7OyB0fnRlTx8ucSVnz
 vn2MHohbzN4nhJlpHmU44ePJqLW2tMCVDTEhTTVSUraWuFj5Y8amD0WIMnLEjdI5JQhKXAFyU8E c227YiGTB8zOXG2pOzQP6Se2Z/a+3zbomziv2GIxrrnxkuV+KVc9IttRzuZ06hDsFTjD79k4foc 0tZ5PC/i4yrwIo9nPQmOW5O69e3nH8vdaa+M6SeT9LwdKlQ/RHkV1s0eNCq+ItX0he1SdAgH1W0
 0KzHQdvhy31RRPxOKcua4M215mtAOUg+5/urw2f8i9J0IfWfeF0xIPS96vSvdT+zL8GiQeDz
X-Authority-Analysis: v=2.4 cv=XZGJzJ55 c=1 sm=1 tr=0 ts=6852819d b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=T9EhDzJh97HtSWJvMMkA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13207

On 18/06/2025 07:00, Damien Le Moal wrote:
> Back in 2015, commit d2be537c3ba3 ("block: bump BLK_DEF_MAX_SECTORS to
> 2560") increased the default maximum size of a block device I/O to 2560
> sectors (1280 KiB) to "accommodate a 10-data-disk stripe write with
> chunk size 128k". This choice is rather arbitrary and since then,
> improvements to the block layer have software RAID drivers correctly
> advertize their stripe width through chunk_sectors and abuses of
> BLK_DEF_MAX_SECTORS_CAP by drivers (to set the HW limit rather than the
> default user controlled maximum I/O size) have been fixed.
> 
> Since many block devices can benefit from a larger value of
> BLK_DEF_MAX_SECTORS_CAP, and in particular HDDs, increase this value to
> be 4MiB, or 8192 sectors.
> 
> And given that BLK_DEF_MAX_SECTORS_CAP is only used in the block layer
> and should not be used by drivers directly, move this macro definition
> to the block layer internal header file block/blk.h.
> 
> Suggested-by: Martin K . Petersen <martin.petersen@oracle.com>
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

Regardless of comment below:
Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
> Changes from v1:
>   - Move BLK_DEF_MAX_SECTORS_CAP definition to block/blk.h

it's only referenced in blk-settings.c, so I don't know why it doesn't 
live there.

However it is co-located with enum blk_default_limits and the same 
comment goes for members of enum blk_default_limits. I think all those 
in enum blk_default_limits could potentially be moved to blk-settings.c 
after Christoph's work for atomic queue limit updates.

