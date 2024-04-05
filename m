Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D34516F858
	for <linux-block@vger.kernel.org>; Fri,  5 Apr 2024 16:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712335417; cv=fail; b=bIZNZKVC+6ImLbEIA5hyZG4IjweKUEVDFT1M3k1Uc2/KzlSPK6NcA1IlCAjEwP0I6W7s3Xa0swQfV2+CA7t6Nxct1NLc+za+iTeTEBBoDU7ps+NODRcfZ9Pl5TTw1e87wz6w7hqYhkB6eWl4a9bPFO5VRK5aUpHe8s2YOsdvg1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712335417; c=relaxed/simple;
	bh=KsPzs3ekSUuF8ERo4DuXNUh6uaa5VxEv6nt8veCH78U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ACvcuANfAOGUBvmCImMRMfzHFeb1YzhwSbBNQBNTKBVtu2+cX8CvlX1sfNGIpm30D7ShfxVvBymuawW9nLyxWD+VTCLQoj/TNyogDmpaetwin4aZ0MHc5ckCf26kfxPxDDhf+nDPede434IWb0J1tHS81+seHQuSyqo0aYGWHcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b+Q19qRK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=T1/PT1oC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b+Q19qRK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="T1/PT1oC"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 435F3c7f009245;
	Fri, 5 Apr 2024 16:43:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=pxrWCxGL9BZP+HLSTx4gzlXLcdfn7fjF/figxhnCw2g=;
 b=b+Q19qRKZ/l1GU1HWw96RHDfKDhykgvrqu1UsUNJnbU8MJRuqULeFquZlD44toBAA3b+
 dB8Ck0jR106yDb5wshBS7awHK9uXF4QPRUJjDGTWlFFXE28qeZMs9PNkD0oNh8V60HM/
 5DvA3kSaq638EQhhMm1Zson5hLEHeV8O1eqNOp4ZVBnNdKMDdhUcEjPPVLiseunJ5Ill
 bzcEIDTH2ORZP+OrDr8z2wIARE/7koig8HzQaPcR87imffsz9VPVIeFVNp8efpi6GtEW
 vYjIyDrwPD5EqBmlIEQUgTBnEsEfWsNXZNjRJANodkbxa73gZcXx4rj1cmoTGFdICvXr kg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x9emtky9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Apr 2024 16:43:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 435FmS8U027014;
	Fri, 5 Apr 2024 16:43:30 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x9emp7nv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Apr 2024 16:43:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ACqbJS+Zsmk94pNrrA+CKISXacpwdt3QQ5fz3oc0A6XdDnflNuCGpku1uPzMHcdmjLLJAdUAVnk1cY1gwCChzWUAOa1fTiudB24b09Q11CVLD5i/CsZH1SIzIDLWq+DGF4LinJu6y/yBtYLkvG+JNjzZ4g+YUmcZaUH4lFvkyGlweTVEJPzig2Z9IeHK3cdVfjL+OD68cyWMk8lF373S1Mnqj5S6SXrwxqkkppEquvwtw0bqRRCnBRzzxrl+MsMFVyaM7WtHOxT6ZA6LNerGdEx5aUHc96839iXle4MDpL4wzaf2S3ECqgDWqB+3JC8eq2UHWUV/IHjU55ss3nosCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pxrWCxGL9BZP+HLSTx4gzlXLcdfn7fjF/figxhnCw2g=;
 b=MMt/Ji+JOom2pIHjwOJccraPLZCIylhEx9ziYaOukaNu/M4Xf311hB2ZYSZUxVn3dNZWiMFj5tr8To18KKp1T09QwULq+8yQLErluNJibxsH5zo7RvOhkqbYStYNqo7byqs8kv9jzcgjs8Z06KX6Pf5PFibYx3U/1WKemSuUy+U0ZQLfUmPDtmEElmyn/WmY3kYfDwSithJ7yoXyv778aUqpNYpQ8/4kTKJvmcBx2GDyfO20kpQfFIj1zlBOuyZSo42cAJXU23jzBsmGihc06enWeo2cyUZ4JRuVPCt20Zx5sx+Bcd7rWgX+2DTaRi13TukF2mMC2KqyPAyPKB84ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pxrWCxGL9BZP+HLSTx4gzlXLcdfn7fjF/figxhnCw2g=;
 b=T1/PT1oCP4ieqPtKX/MhEVVgjC4lDufZOWEO7NTZqWb94Kl9tfLgf8aG0amIFL5bcEzJp4Zn4jEJmVPW9rMoOwaboVkJAJRYSRxB5BS64QeLOpId+MHueQYTGIFxR93wrWOdmJzN3hKua90F6r68tJBq8PJf1ZRDNA8kulkpNAo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by IA1PR10MB5921.namprd10.prod.outlook.com (2603:10b6:208:3d7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 16:43:27 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 16:43:27 +0000
Message-ID: <343cc769-b318-4c2d-b08a-0bc752f41f78@oracle.com>
Date: Fri, 5 Apr 2024 17:43:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: work around sparse in queue_limits_commit_update
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
References: <20240405085018.243260-1-hch@lst.de>
 <65a7c6b1-ad4e-4b27-b8b1-44d94a66bf7a@oracle.com>
 <20240405143856.GA6008@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240405143856.GA6008@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0030.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d9::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|IA1PR10MB5921:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	fn2ygG/1TLt9dlO+vVzRqlppYoOFsU9lF8KvsVKIZrrQCE2DAOqaxwXPfIfYIKl+JmaXHjHFUbyqrY74XbUAUTwqjb2dNVzZduNStz6ZV+4wK5QxJ6+s2B4GhYdmd88b71UnNkRTBea6QY7IohIifktisQtDT4efpFBpAQAPg6HIg7DywJWntrkc31z64L6sQ7AvxL+nlhvuS78j9kHBnjLm4IScyaJ0L/tMcyBCk77H+WnaYne5DFsJ+sR6zcb0uX3oHM6T66M7VO+B18vKae6ZKhJwhdAnqHdqjokzg7kvkaBhg2W+SYzPeXHNWwqHxe1ymDOmZ3iJb2TIeRx8u2WxEpBan6zKm6I4gxNpcc7EgDQG4zxtCZOU7xUGubiNwNVmjwgOz4xFiEzWv91oqmovlCa0p5UMQHgDxvg7hZeP/Py6qH4lO/fzdXhgkkowLQ0cU7Bk0EpM0lv/OIUM7/5ajHv/yAVW+HsDQdZfJgnwtNWRvk4zX4jrQsPZAjTLSzfvtcNE+dgU1TNXPTtKpuMipVgD678TQJmF1KLEXTYrGgYlm16Mx2/oqE7SafpttaKdQSn7Q3bWKvG4jNi2UL5HUyuSGp/GHuBjrHYLl6Y=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T0N6OXpSdXZZV0IwYWxpOERRNk1wWUpleFIxVWZTbTQ1M0lWNHFEWUE2RXl4?=
 =?utf-8?B?U1BiOUVPYkNTbjd1WEN5ZmJRVys3Z0E3dlRQakw1dkpQc2lKZVhpdzJTUjd4?=
 =?utf-8?B?MUtMZFFQN1VPWkZiU2RMQy9EdUh0Q0lhZS9NdStlTGJsWGhBOHpVdDZNUHZu?=
 =?utf-8?B?WTkzcmk4YWxwYVo4VWZmTlg2NWt4TXI3di9abitJNlRleXFaelpKbm1HdjZN?=
 =?utf-8?B?aHNDQ3lYblVlRW9EUW5VNWc0RXBwR0hvcEpOaW94aitHamh3ZkFnUWdzbjNY?=
 =?utf-8?B?YUxWVzVOOURENXoxWjF4OU00L2J5bHhLWXk0T0gvS3hqelY1dlZzWjRSUWJX?=
 =?utf-8?B?WFRGV0IyZDBCRjRpVWV3WVhRdXRLbDk0VUxqVVIzMHNWalQzdE9JQVVpUERv?=
 =?utf-8?B?dG1HUWJyTkx0VDRrQmdEWXpLTk9waDR2RTNLYnRGR1RFNmEwNDVCeVM5bzIy?=
 =?utf-8?B?TnFlclJmNkJ6ZFNUU0pMRXRoaExrRHJveFVNdklzOXl2V0pBRFFiUHU3OTZw?=
 =?utf-8?B?eERLOFhPUXZ5VDR1M1FybVphUVA0T3hNdnVMK1Z2MUprcDFrM0JsTHFaWjRs?=
 =?utf-8?B?YmpGT3gxK1dIb3NKcnJETUhza25FS3djdUF3aitpQzJQRXkyVmhMRTRRV1A4?=
 =?utf-8?B?clV5cjNPNFpNT2pBM1h3MkxRbXZ3aEU5eXRCeFYyUUYwek42WE91M3Y4dEVI?=
 =?utf-8?B?aW9FOVpxY1pRS0piQm1kWERZOGV0VEh4NTJXVHgzTjFrYUFlU2k2dFQvT1hN?=
 =?utf-8?B?Q05XZks4b3NmWm4wZzRQT05jeWkwaUd1OEFjd0tkTnJnTHV2SXE5K204MDNy?=
 =?utf-8?B?dGx0K3c5eDVNTldpZkdoZjlSdk5NRWdhY2xTeE1ISnFxb2RUZm5YZDRvR1VL?=
 =?utf-8?B?T0djNEJTd3dxOEJqbWFTR2duMlpFTEozREFCWTV0TWk1Q0ZVb3hSRG12elRV?=
 =?utf-8?B?UWZ2UUgvOE5OVlA1aURXcDduNDlmaklKSDY0Q2g1ZzdqOEhmSGk4cjMxZ0Ez?=
 =?utf-8?B?Yzd0ZnJkNmV0U3FHMWY0Yng0aHNZTmcrQ1hlbnVJejdKV0hCZ09lY1VMbFhB?=
 =?utf-8?B?TmNUYzFZQmpzQ1BqNVdyYzQwWWZIS0ExMHVadW9raHd4S2ppMEhkZVNOS08r?=
 =?utf-8?B?VWVSNEIvZTROaUgweEM5QzB2L0c5a3U0RXJhVm81c0tFRmZwMnRFQ0RxemhR?=
 =?utf-8?B?T2hoMlU3ZWc2MVU4TlZ3TlZJWHlOQVA5cTVYNFh0SWFkdXZSRTc1b21QRHdU?=
 =?utf-8?B?R1BvOGFxTEtxWW05WG9LSTdHV1psdGFhU0lXcmdLU2tNQ0N1blNWV0NNL2FY?=
 =?utf-8?B?ZDdwRDdoTldFYmxSQUczVkhYUDlaay9WL01aSVpMTlAyVkE3dXFQVEtUY1R6?=
 =?utf-8?B?VDZGb0JVMm5MUXNaNGtZTmVIem9xeUV4L2F1WTBVVHY3TFhIVEo4c1EwVG9x?=
 =?utf-8?B?Sm5xdkljVFVVdnZKOUFoM2NGejhYbG5aU1NRRHFTUmw0aisyc0pDNTRUMEh1?=
 =?utf-8?B?T29IQ2JvTUU5cUNpeHk3bmlnTU9RUW1ReUVaZ20vckVIODBFbTFQSDVGTC8y?=
 =?utf-8?B?REtpQ2dkRkVaNHo1QW05WHN4anRkOGtmOHpuaFJZRFI3U3FCcFlqZW12SWRn?=
 =?utf-8?B?eWx2b2VHQ1ZuM0xMUThob0xHZmcyTGg0VjgzelBLaFpOUkk1NVdZaC82cGdE?=
 =?utf-8?B?K2FtVlRSdVR6Njg1cnIwd0JtSGMvRS93MHJMU2plTzc0NUphUnRzWkFvcXU4?=
 =?utf-8?B?QWh0Z2d1NVdJelh6VG1SS2p3MVplMlQxRjU4ZXV4Z1UyTWEvcmRSdnowNFJP?=
 =?utf-8?B?NVRha2ZEZ2NuYXlwVWJRTWpUd3JQbHpBZ2xXM2Rkd1ZKMzVqUHVZcHUvZ3Zp?=
 =?utf-8?B?bTAxdnhDMkFuUDRVSmN0SmxNOUJDQ05YV1M4MEJaVmcyRS9INkMwZEhjb1dq?=
 =?utf-8?B?OGRiQlBRMldHS0FsaE03dFAzL245YmVsRGpUeGx3TzQrYlF5NC9jUGZObmdN?=
 =?utf-8?B?UGNlSlc4aEFHZ3F1ZDhGZWhQWFY3U3hTUU1RUjFlajhzYjlVRy9iVXFFQmlP?=
 =?utf-8?B?aGFDQzFmaFZHVlNSd2xWZDl1elc2MmxoQTdXN1NaY1ByazlTTXl1Nlh3WFkw?=
 =?utf-8?Q?emC3Cau8PLtyAq3WDXgNmYJi3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	OmLPmJ6AbFJIb22HO628qZtiPLL+u3tQntqQeWHOCGabwQgDrGb7msgGngadJdpjFAkF28ReKkzCo8ptTcZ5DEbkPWldtEiRq5FfPzkfbrCFfN0SiHoiRqTDHuUnsYoR+I2wKX5U108hufwJAXcpHN9mWGPfJaJJxoDYUFizyOxpdXOQ08KHEQQjFfrh4s9rzPOnK2oBVumIWGFwfw9VkDbiymCGIuhGkr4WV3uHgL7fspIGNpEwVZATQY7gb5HBFwtqCfH5h9P99oCd9W4k4FzrjXZM5MnnxeIlIDjJR3z5d9Yjw2AMCf97N2zW1uFfkocTZTpIyfRWhwV5VjRkNfBg8QW2uOMDJzLYPXGtbFWC34HjX1n/mVKefl3u5V4lIri6LDvWLE2DwcefidF2VIosZJiQkhtRL1FXi1/jro9zhG/un0yfpYrGIZVoBF8pfxXXHYR9IwCs5e79PYZaWNZJiEOPV8TUnh4aON3BQqD1qfPwLDRwoKM4hA2Bd5mLINiJM2AGhKpxxl5xFxRl9ZvCb7Hz/Kzv4J/ho6PRIQieaZs5JTdhgq/VXJTIiMp4xVLXdY+8lQ6X63szKaFw3G/qkGdV/Qi9fBZMcuGo+OI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ef8306c-365e-40e6-61f8-08dc558f84ab
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2024 16:43:27.6376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lFKSxsWduzBGxPXjolTudW1VZJlh2KMp+iRsJsMKUrY/G0IrxGxdpuhkh5XA09Yf9iidDqMbpbqyJntfghsE9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5921
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-05_17,2024-04-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404050117
X-Proofpoint-GUID: De2LnBnLx36ww8_U-eJ0yxxFIVGEA-7-
X-Proofpoint-ORIG-GUID: De2LnBnLx36ww8_U-eJ0yxxFIVGEA-7-

On 05/04/2024 15:38, Christoph Hellwig wrote:
> On Fri, Apr 05, 2024 at 01:31:10PM +0100, John Garry wrote:
>> Anyway, changing the code, below, for sparse when it seems somewhat
>> broken/unreliable may not be the best approach.
> Ok, let's skip this and I'll report a bug to the sparse maintainers
> (unless you want to do that, in which case I'll happily leave it to
> you).

This actually looks like a kernel issue - that being that the mutex API 
is not annotated for lock checking.

For a reference, see this:
https://lore.kernel.org/lkml/cover.1579893447.git.jbi.octave@gmail.com/T/#mbb8bda6c0a7ca7ce19f46df976a8e3b489745488

As a quick hack to prove, you can try this for building blk-setting.c:

---->8----
diff --git a/block/blk-settings.c b/block/blk-settings.c
index cdbaef159c4b..c9da5549f3c2 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -277,6 +277,7 @@ EXPORT_SYMBOL_GPL(queue_limits_commit_update);
   * Returns 0 if successful, else a negative error code.
   */
  int queue_limits_set(struct request_queue *q, struct queue_limits *lim)
+__acquires(q->limits_lock)
  {
   mutex_lock(&q->limits_lock);
   return queue_limits_commit_update(q, lim);
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 67edc4ca2bee..af5d3e20553b 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -143,7 +143,7 @@ do { \
  } while (0)

  #else
-extern void mutex_lock(struct mutex *lock);
+extern __lockfunc void mutex_lock(struct mutex *lock) __acquires(lock);
  extern int __must_check mutex_lock_interruptible(struct mutex *lock);
  extern int __must_check mutex_lock_killable(struct mutex *lock);
  extern void mutex_lock_io(struct mutex *lock);
@@ -162,7 +162,7 @@ extern void mutex_lock_io(struct mutex *lock);
   * Returns 1 if the mutex has been acquired successfully, and 0 on 
contention.
   */
  extern int mutex_trylock(struct mutex *lock);
-extern void mutex_unlock(struct mutex *lock);
+extern __lockfunc void mutex_unlock(struct mutex *lock) __releases(lock);

  extern int atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock);

----8<----

I would need to investigate further for any progress in adding that lock 
checking to the mutex API, but it did not look promising from that 
patchset. For now I suppose you can either:
a. remove current annotation.
b. change to a spinlock - I don't think that anything requiring 
scheduling is happening when updating the limits, but would need to 
audit to be sure.

BTW, as for lock checking for inline functions in the header, I think 
that there is no checking there.


