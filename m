Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEE52580EC
	for <linux-block@vger.kernel.org>; Tue,  9 Sep 2025 08:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757407449; cv=fail; b=JayGuHIpoBmNXG3Wkm6oDerw1LGiVLYukkUA05XXY+OtcsasgZwRSe77PABp3vOqKDeIpvZHdcrbzhPirPf/Z1wCkibICqntpY1FPCgb2qYC9E8+x94r1RR5B5dPzV/reaxPtp98OO1du86P73vQ3NL4ZQzUh1kwVy6iwKR6udY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757407449; c=relaxed/simple;
	bh=sV151gCICGqYgJqlkY7kQbdEOK0mW/nrAb1i/OkAJ9c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OTHcJ6LLTbhXscTuIVEP18jW6zN1IfCopvr6VG1zpWPLIOOtUrykYRaxBDZuzjDi2jZz7t6qLM99DFSi6rdShtdTnSrGZOeMTuc0NkbHs1Dr3KFMywgX0mKNei8jj0DOZfQLyPlseSthYUVnRIIbtbhYo361WSJpMZCalXIgSFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ai5J76uV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qibJ6C0y; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ai5J76uV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qibJ6C0y"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5897futj025862;
	Tue, 9 Sep 2025 08:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=rrPkQSsoio9q611NLJHb0BzG7uxlU3LBiuhBPRKQdIY=; b=
	Ai5J76uVDwak7LiI41e1xwyLay2aaGic0HxgB3WuaSfyfGcuDNg05vCyu/VIZBCC
	TzUsgu6NoVf4GjVrvbA3yfIFLrVMpxDr7HX4T+ZKeYLAuJFPzTEOk8QDWpvNti8e
	t/vvRm/R3qjJbo62593MBUTzNdbHZCRaGyWyfB6+IOeBgNoIQ7svun2BkGu7oZB1
	SWWwlxv6INe/MWz+DlxsEfbfQUxX8NkWMcOst2Wf6Rhd3bGoU+0YTZkyweAmv381
	kseehdHJ/FA2JrkZV2Y1Doi9/1sINIaRJewBK8eo3HhI8RFbctxYaiHCAAWcq6WD
	PLz9I+3tr+Z+kPZbrJ4UNA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921d1hhke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 08:44:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5896xo8L003088;
	Tue, 9 Sep 2025 08:44:00 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2044.outbound.protection.outlook.com [40.107.93.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdftwf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Sep 2025 08:44:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PKv/WIhqa+WHqgfeHD6ihH+8Tpq/0fbu0l50fPXFawaCVgXjOFEZTsNMdb5UVqiL45p4oHPL6LyOou+O4IEZVr/9MNCgyeUNCeHWJugbi2dr+Sugok/5sRbcvf7jkEHMXWZ0634RsuYX9rqaBnvEwNkX+V8FXtoCzK0UBOYZ7IrLNu/mJGyJx/2bvgJhoeRto0RUwMfkpjygcw5k2DJmLrFa7itUEIPnpXFiMjQy1JAjA2LRlsrM5T4/d8osOtL9KDEMI2a1cD5OdJ61NCLfCc6FZsZ7p0Wk+AXfEd763DhhgDXoTBEpA+meCNCVKmo5gV91ygqFUfZcsh4KXTvuog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rrPkQSsoio9q611NLJHb0BzG7uxlU3LBiuhBPRKQdIY=;
 b=lKl6oqBAMmUc//8kdDMLGrLU2FiEpQNiIVchnyem85OezYjGsUIhCTGR7A7HGroW+zgJpPC1ds4jkh8QHnpt1axZbDEe/Ji7dxf1vElCNeXhxA60UZywwNHbivrpJLhV9s72LNgJBpMP7jB8YZ8WjEKeZpn6xbBPq4PjUboGz90Itaze4NoiPmiI95VT+55F8I5I5j8BdjJ718bFV6BEBRuOouDE7AANzPHwO11mWmgG688NKMq4txnO4+gg5iTAQmBgp7yV8XJGs4aDRTMHiMI5sENj/Nke+YH+jTm9cTYpnb/OZsMpcZstM9+RW4wIPtebkcZVajqW0JfWYH0QSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rrPkQSsoio9q611NLJHb0BzG7uxlU3LBiuhBPRKQdIY=;
 b=qibJ6C0y7/zeaM7bK34035t+XPu9D8i3/rBV34O0Wg1igWyEvMZsYYDyXO7GsvLt89KGhwQW6HNcpNxqOWLo96SS8B8aMlCK4Yi009zrE0LoP2rqPGWnvfBhmgIiAPO3ksbsuJjqvNrBquJW9kSAEUnGULADzDYYTMlw9bGqdiA=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by DM3PPFDEB3189E6.namprd10.prod.outlook.com (2603:10b6:f:fc00::c4f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 08:43:58 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9094.021; Tue, 9 Sep 2025
 08:43:58 +0000
Message-ID: <b4b28858-0d55-4d98-99c8-d872e902515e@oracle.com>
Date: Tue, 9 Sep 2025 09:43:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: add a bio_init_inline helper
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
References: <20250908105653.4079264-1-hch@lst.de>
 <20250908105653.4079264-2-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250908105653.4079264-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0059.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::23) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|DM3PPFDEB3189E6:EE_
X-MS-Office365-Filtering-Correlation-Id: f9fd40e1-5bac-408d-7c13-08ddef7d0467
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGxyTUhmZ0N1VlZtekl1MW9ydERUU3h5WlFTQkxHTXhsTVM5Nmo0Z3hvdVhJ?=
 =?utf-8?B?cVFQOU5iUjk5OG96d0dzN09SUDB1dXh0VjBHY0Y1aXgrK1NtTmlOL1hveU1K?=
 =?utf-8?B?dTBJSEV3dTV3VzUyMjMzZTN3SWVuYWhVM1hNN04wUWVDeHdERE00Q0I2YXBO?=
 =?utf-8?B?UDRZcHR1UFpVenZ0anE3QUdRZVB0b2RiemtDcFYrRGlsN0l2T0wrTE0weFRk?=
 =?utf-8?B?VElnbXRUSjFDQkJlYWVkZ0xWc3NCN0JreWU1WENmakFSdVJ5a1ZCV3h6RWdy?=
 =?utf-8?B?MVN1MHR3V00vNUVtb1lBUHFWa2ZtU0tWdUFqeWxMdWZ5SnBmRzk5cGRHZXZl?=
 =?utf-8?B?eEczV0NJNEFuZ2ltTFRBRXpRZmpZSVNoenFjWUc5a2czYzlsNW5yeDQxNmNN?=
 =?utf-8?B?bXhhTlordUkrbHRSLzIrb1N4WUlqdUc4elUvaFk3U002S21HWUIrSEdZSitp?=
 =?utf-8?B?NDRUM012WlJZejF2ZTQ3K241dDJrdmVkdXRCNFFyOG8yeVIzRjBXNHZlcHdr?=
 =?utf-8?B?bDdnT3FXQkZFVFRoR3QvVlY5Z01FbE5SSVo2RmdXbXpoM1ZXcjU3ekpRaWFG?=
 =?utf-8?B?eGpoVWN1QXZ6OUgrVC9RMG04Q0dmZ2wwb0tudk16OFR0d0U3SmlQS08va0xT?=
 =?utf-8?B?cDNrRENnTk9ldnRvcnVFUHNMWWQxYXBUUmVxSXFJYytndVJHZTlCUGswWDZs?=
 =?utf-8?B?MHJVeHREVldoZ0dYY0J2bEZUbzVZczhvQUtPQW9ZYUJmYUNSRG9EV1ZRc2RC?=
 =?utf-8?B?Z0E0RiszVk9nZ0FkWUV1OC9GY3ZnVW9TRlF5Y01iSlhlNlhkMFNmUk5nNVlE?=
 =?utf-8?B?ZkZuOENCOHJTeHBVamxWY0xicksvRTR2VGFoWnZJdElaY3p3ODRIR2xwYnJn?=
 =?utf-8?B?UHVyam9GVXVETFo2WWkyTDNsaWRQM0tmdnJueGNYY2VydnJOYWRjWDNldGN2?=
 =?utf-8?B?TkJ1azFBdExpdDJnTk9zVU5hS3o1TU5vTHZmOXpqYlFpQ1ByMnprVjZtL001?=
 =?utf-8?B?UXk1Z3BSeThLTmgveUcya2M5T0UzMHFDelYveFJ4RGFTbGx2eENiTitUcW1Y?=
 =?utf-8?B?cWdrNTE1eTF4NkRCOFZzMlpWb0tTamQ0V2JNQjh1WDJ3V0oydVV5bTZ4Tit0?=
 =?utf-8?B?ZlY4SjVvNE5CbEExMmNXT2xnZ3Y5M1piQ0NuVytDcElMTEFuSnh2eGlwanF6?=
 =?utf-8?B?YjF5dzA4TXV5VFBneStVc2xVZHh4WW0yQzJQVUxtYnFzNkpIeWQ5TVVjWnNw?=
 =?utf-8?B?SVN1NmU4SElQdFJzWXpWTTdmMUhKNy8wb3VoK0VoNHdTWXd6ZnZxK0RxRFJ3?=
 =?utf-8?B?b3RUV2xXRUFDNmsxdGd5ajIwRFhuVmVISXdrckQ0YzJNeDNOcFAwQ2JZWW44?=
 =?utf-8?B?UE5wNDJqdmNwUkRHOGpvSmlYTjhtOUZ5NnRaM1dNd1RYYmNnN0FPVHVlaTl5?=
 =?utf-8?B?d2NadnE0VVZrdzZER2JpeGowZFg0RjVQRXI3eHlIb1o2SmhZWk9uUnNVcStF?=
 =?utf-8?B?OUR4UmhWdDVES05DaE9aZHg2SlBHcWx1d3pHb2dzSlRTUStKcEJ1V1VFeS9J?=
 =?utf-8?B?YlhwZ1VNRlpRU2cxVVN3WVN2QjRTdlNld29OckF4ZGlWSmw1MUc2dDlQZXdn?=
 =?utf-8?B?cU04TXdwUzRxSTJjbzlDNVRuOTZsN0UzMnZ4U0FFTUp2Q0t6eFpQM1B6SXZR?=
 =?utf-8?B?Y2EyTXYvYWhjQ2pzU0I0OHUzR3NkRzk1WFR2L1Vyb296UDdta0VhVXRlVmwy?=
 =?utf-8?B?UnhtdmJ3ZFY3eVNZZ0R6a3VzOGNDNWhNTG9ld3ZjVGF6WlpDUG02QW9SdS9W?=
 =?utf-8?B?WEVsY3ZDM0pPS09zNy9LWW0wMmp5UGVRMnZ5bktvOUN4ejFReGVxMWsvUmpp?=
 =?utf-8?B?TmtqcWFhUjBxYWFjV2R2WGlQdVNyWjI5YnJSOVEyV2llY29waUloNWUwbWtN?=
 =?utf-8?Q?ySO4jz1SAPw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWtVYUEydGxiMTAzeVdqakxrQXplRlp2RnduRWcxY3NpMlllb1pFMDdOUFc5?=
 =?utf-8?B?VGJCeHVGeWVlM1U3MWVubnBXMlc3QlBuRys0cXB1emF4WmJ6UnVQSFZOengv?=
 =?utf-8?B?RmUyTFZsT21RenlrYjdoWmhQemFDcHZMamhHZmViTm45dE9tWGtJNm5Hakl3?=
 =?utf-8?B?UXFidVJxSE13Y00wOTBIVlJ4bVNjcmZKWEozWHJZbm5PeXZDaEU0Qy9kVDI4?=
 =?utf-8?B?TzMzdG1Pd2ZING5jekRFMDVaOG9rcFlpaGRVNDRlRTZmM3V6ZS9sdTVKN0hQ?=
 =?utf-8?B?TERTZW5wTXk4ZWZWL2xDcDI5QkNjWWpwRk81K3pyV2lQb2E4cVpOWHFjY0Y4?=
 =?utf-8?B?OWEyT0UrblY5VWtYL3BZU0ZnTUdtNW1PS1dyMFRWaGdYMXVTYjVLcVhxNTNS?=
 =?utf-8?B?QzVpcDVLclBDaG5sT3dnZUl3SWg2MCt4UVRHZGlxZmJROXd3cjJiTkIzd1g3?=
 =?utf-8?B?Q2lVeU5rZXB2d2tEVlBWMU5PenByNkVMYUx0QmFJRDJNdURsS0dncjk3R2Mr?=
 =?utf-8?B?VEVKd3hxZG9sblUwTlI5VS94RUpZNUh5YXRWeGRkWFMrbExVMzduRWpITFFG?=
 =?utf-8?B?VVMxTkxCV2tlOSttaEJlMW5BS040UUxkLzBKdTd0Nnp2V2V4cFpPdDViNDRv?=
 =?utf-8?B?MHl3RDZXVHhPdU43cEs4TnpSaXdmTDEwQUs2aXRIQjRkQ0ZMNUJCNHJxdWdO?=
 =?utf-8?B?KzVOcCtLeDFaRTVDU0o4ZGpmb3FacXRQTWt0a3d6dUZ3bFRNNmxEU0dsamtw?=
 =?utf-8?B?WEtoaG1FcGdXOGw5em1lcjhGNFRGNjY4MXdQOEJFYUM1RFVmRnpubU4vQjZq?=
 =?utf-8?B?cmN3SnZ2VjV3SE5sTFozREZjUC9NMUxtRmhLdVRudHkyeVZ4Wk4yWXFOTTJD?=
 =?utf-8?B?RDYyc1lzTUp0MVgvcUp0K0FTWFh6dmZHdkZWdWNncVpKR3g0ZGpKNHlMZmdk?=
 =?utf-8?B?WlRPREFPWDZtb1dDN0EydTVJeU9DNUZFWjQ5RTI2R3FpOGJ4d0dXNHdkbmVM?=
 =?utf-8?B?TjMrcTBVS1dxYjhKMHRNZ2V2VXpRb2FENnNiNXNUODNlNXB0eDEzQzNLRzE1?=
 =?utf-8?B?UmNoaHUvSTRUN3NTVzY2c3FhWnc3dFZGSjcrMUNzS2hXYmFXVnU1WmhmSGVw?=
 =?utf-8?B?Lzc3MmJpdXF6dHdrZFRNazlQSFd4S2ZzRjUwREF4c0xYbXErUyt1R2doRHQy?=
 =?utf-8?B?ZFZvQWM5YXlsQ2IxRWVUZXQyM200WEwrbDlScUg4SXV3bmlqb3JmREZhYnpS?=
 =?utf-8?B?M054ZVBCcFQzVFlxcWVEUHNuUzR2UnVlQTJISktMa0p3KzZneHhVQk5aWjVR?=
 =?utf-8?B?NUs4N3lxNUxvdC9vSW9BYjdIcVkxekFBTFgyWmdteW5LTFdNVVZWQks3RE4r?=
 =?utf-8?B?R3hkcXhRUStjaFlFSDVDS1ZkalJZZU9mZUkwNk5acnZOYjBHdWI0bVZ5THE2?=
 =?utf-8?B?MytmVEQveXNobnB1di8vOXlxSmVCUjI3ZDdLTkZacisrdzM1T3BUSkN2OHU1?=
 =?utf-8?B?NFhvTkM4aVF1S3hldDRLZU9oY21UMjVoM2lEMGhWbUdkRmRBQ3oyR1loMys3?=
 =?utf-8?B?c2JPY0RiaTh6MU9NbkJZTEpJeVpLVENUSmdNazRhRFk2U0JHZjlJSERjdzF0?=
 =?utf-8?B?azRPWjZSNE9rb3JTZThNcU5TZVFNZGNoWTMxRE9YNmxzb1JjcVMxcGx4WGRm?=
 =?utf-8?B?WnlLRktpTXNoTjd3dHE1ZjVYc1VIeHRtMGhLYlp0NEhtQmtuVU9sZUUrdzZL?=
 =?utf-8?B?TkpGNExFMVl1YnV5Qk0rRmlNKzFESnVUNzh1Z3NqVFExblE0Q0EzK3lkazl0?=
 =?utf-8?B?YVloazJWdW5PK0x0OEZmM041WmNVZG5WekVGTW15UjArYW1keWVwaE9heklt?=
 =?utf-8?B?czV3cWZTYWVIMWtrZkU4WkgwWk1RdzdyOEE1V0JhSDRYaFB2bDJCOEUvVWR6?=
 =?utf-8?B?T0VDbVVPSlVjL0E0c2RlK3JvZ3lnMDZVVkh3T1loNURGRUd6cTEyZXFJMkFz?=
 =?utf-8?B?M2pMNlZOcmRRVWFQQnN1OS9BM3h5THNHTlBDY3lCZUZJVHBqUFpza3JvOG9q?=
 =?utf-8?B?dUZhcVFqalRZcnRKRUNkUU1FbjNkOXd1bWloUEtMbzhYK3JXVDF1ZmlyeUV0?=
 =?utf-8?B?ckx0Y1g3YzQ4Rlp2TzhNWlBHMXR2RmtXQlVzZXpTMXhCRUkzWCs5aThlTmdN?=
 =?utf-8?B?alE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	uX0QzB2TaDvM4YIDQf41M9eIVcQxBs1baswDIidEmSr8J5+caJjPdxUKLocbNzbRlqtkib2EG72EZeOWofa7/AMil3VNKX7/4fQDc4LwTINDJIS/es+LgLBbLPpzmHw72+HAIoMvK48jwvLJ8cK4ExC0HIKTiY2xeCZsDq7Qdlq4xiw/pcb5s1bgmgo2Va/Omd2xfArrCHOFhjweg1aj45temxYH+aVTpSllKhj+wA8Twgk9II4fQo7pegjV+rsfhyHi4n9tjXocqIsSXQwcOqQnDy6sdW8fa0QZV2vOe0JE99+mVeBixzKVoTD08qxz5sZ6fKC28HPRei9AghWocEjaV953d6ZlvsyvFXpj/9PRwYliH6tZqfBAGj2KsnwLJUv32c7P17+Tqb6BfEi85CXP1mpJjjtu4E6mphxCJrhIXveuSAx1Ns2zqCZ5hJijD+uzLVRJdJhhEBtLaIt++K3PSexzJU0sRb0UEG1RFJbNx0Hp/3YCFM1imU0aWb+oIrD3cbupZQayOlPAdb4HLcgfZYciWv3ntJEnKfVxpVB3esoHuI8gqBiM/dcgswFsc9QCg+8CghXjQIbmybttnaRCvhSIGtKV10Fzxm5s/3w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9fd40e1-5bac-408d-7c13-08ddef7d0467
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 08:43:58.2419
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 31oJ58eD1kvvbh6s48wzCR9GiQsmUf/TbN5JACBUkyaYolCYOkP2ZXkKDJ+RQBx4y1FoS2nJfOj52mQ5/S0rNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFDEB3189E6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_06,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509090085
X-Proofpoint-ORIG-GUID: n-Lof1aHDd-0bZCohr3kYKFlzo4Yi7CZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MCBTYWx0ZWRfX453/7Xni6py0
 +Farsj3jpFW97hPJ6KUI+bBX4XeF+fdaYH3l8oF9JoYCzP4yT4+gfTeA4+vKkRkVOoRaOvtY3rg
 OxIf6fbzy0iPWbee8vHMPjZP0EFxarpaKox2OyKwxC3Oig/VENT136zlowN/tGe7MR6l0NK0EYk
 9CUFTLfNdbGVPXdWOcyXvwCBQLN7jcP9dZNLjuKJ8ZHgUcH9mpmC9S4CoLA8Cei6bVrn8rO+75K
 L5V9lARhEnRikOAK0o/bRY/SfOgjiIDYYtm8TSEFSW2M902M7fmyAw7oHZBczfRZ8nmN5lbtwaX
 A32IorDUavRMWNU8ERuwq3FySr6r7lXDfF9wW3TFMZyNrQAduBY5MxAD8orNavSy8VQwD2YjewU
 UcSd2E8ygeEyLInfc2A1/1M1F3DlSw==
X-Authority-Analysis: v=2.4 cv=d6P1yQjE c=1 sm=1 tr=0 ts=68bfe8d3 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=55diMWIhe3c9AULVe3sA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12084
X-Proofpoint-GUID: n-Lof1aHDd-0bZCohr3kYKFlzo4Yi7CZ

On 08/09/2025 11:56, Christoph Hellwig wrote:

Reviewed-by: John Garry <john.g.garry@oracle.com>

>   void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
>   	      unsigned short max_vecs, blk_opf_t opf);
> +static inline void bio_init_inline(struct bio *bio, struct block_device *bdev,
> +	      unsigned short max_vecs, blk_opf_t opf)
> +{

I suppose that a WARN_ON(max_vecs > BIO_MAX_INLINE_VECS) could be added, 
but I don't think that we generally protect against such self-inflicted 
programming errors.

> +	bio_init(bio, bdev, bio->bi_inline_vecs, max_vecs, opf);
> +}
>   extern void bio_uninit(struct bio *);

