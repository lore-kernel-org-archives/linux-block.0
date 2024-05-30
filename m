Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C11A2D030;
	Thu, 30 May 2024 16:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717086527; cv=fail; b=cLswCGsHeGAfoGtRrBkV8VMN2DBAlFuyiyBcd5EAB/PUeCSPFBbQ5v+yEOTDIbDEfRrOofcUmGT3hUqcZPNJJvEyvKYDDTbQrVOrPv4IRdJ5NRMOKRqsDgU8Wj5/xjS9x4ldLDUS9GD5RGe2fJXNk0O9wBggpPAh/Xd3wZPejdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717086527; c=relaxed/simple;
	bh=DOIZFr4yqxmvRVK/+Kh8GokZ68+pHhvx9jwStqPDYaQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QYpxjh3FaqSEgsEeLtxKYOdkbHMSvjo4wtqw2dXSNiUr5XYE5oheli6i+Wb66yFEmgb6SnTopHwWwi/UIujBGINxDRW758C7QYcZdQQEcK8S4DByGJaMV3/67enIRe+E6YXWfcyaHvuH/yUo89hHcT5/vg+HeX50wfIqPLEDTNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44UFTW67018614;
	Thu, 30 May 2024 16:28:30 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3Dwx1WEcWF2DANlnMwkJsXIK/fXQsH9RR+w07qIuSI/90=3D;_b?=
 =?UTF-8?Q?=3DVFU67LQwMpkZPUC1z3zs4bsDLLZtglxm8+K0TKI/NjH3hBjCdDUZ4qAnYlJx?=
 =?UTF-8?Q?cLRQdDeU_DT9JN8MplTLTFQlygnPqy0y4EV1oUViVaQ8hV1Cf0go0AsUauD1nTi?=
 =?UTF-8?Q?DLWcL5qvZF8aR9_jIGl5g39RJP/Sid36Fcp+fseVsVFoyGGbZI9jUoZoUCboPbZ?=
 =?UTF-8?Q?aPaF0TXYh7xVbbdHeV9Y_jD08LO08O8iFvAPI42pdc2vj3uXdJscQBdi66Qk798?=
 =?UTF-8?Q?p+wYzWo2HcTxmJUSZ5iDMRpe7A_J3htQDSqjDRzy6RK8YVFFKYAN8twOSLSQw/Y?=
 =?UTF-8?Q?AF616o2aMXZ6a5r/JQthm0XBgC/2iclf_SQ=3D=3D_?=
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8j89bdy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 16:28:29 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44UF1iAb024126;
	Thu, 30 May 2024 16:28:28 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yc52e3ndp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 16:28:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KEvWvhC8DkD9GZcpBvfX6sMPisIExX9+QNRn0X4oL/QvS9lJYOPNqdwnrwEmLdO0EgnbOVdVWWqrCZZ7q8q+RsmDUESaNsUVS5y5Pxvv4yD5gzQNJTp+o4QPsD3rbz6ShhhKjuGs/dSDsNYK21hbpuiip1qoVwiGlffA7X6+pf9sszZ2pZN+EMNLfOwrZ2nWWj7+5ewFbx0NW4ZsQt40aN6Da6wQQ5ajgXxSVU0d/e3U8vax+Lb/w7X05vEUSqouSCzuOVHVzpsF5XncbDWNyFBq3DoAfCIIBVZro1fmX7t3LeHvOTHLMSBfe2xETvRTsUHKA4QXFnzg0jKgipM5zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wx1WEcWF2DANlnMwkJsXIK/fXQsH9RR+w07qIuSI/90=;
 b=DuMzfebnSvJiTxphKOhcnDhofBIM69f50UlDrQ+WVE/nBYHaHNTiXcoBXwpxFcVEdFZpaRVjWsz53qDuyiKAzHBFmAkKSvgx8LJIROHTuoYcyX+hwEote2Krie/nxZA/jNLih5kdnVwCSqIoRVSnPE8eI0ylCSG1anztrq0i6amN+m5nLEOmsuUSUkxCfcy8oQteyyGWaLejftRXwfPnD5jFhVPKEzi8OLseqn1ZCYRcIH3EzkC09lO50GhRQ35DboZPu4p0MfLIPc+/k7gFkceTNuBOpoLwMYHt8H/VRO6NVZR/SxIrwpbD1a34pB5/alhtGADPRNveMH01kDXtMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wx1WEcWF2DANlnMwkJsXIK/fXQsH9RR+w07qIuSI/90=;
 b=J4vpdLXVFULLoy0UC9qngqYSE6C19317nsuRH7OFDIWDS+nJVCeYoe9LLnP+k6/vx6ZsZ5i9ZzkhJLvLnRTqwJ6iW7YSwvtHvlyrMEW9zWess569mvZlmZ7fVzdMgXM5xYZuYRsJL0zEVAFeXl0ybXJQmxsoJrocjL+YeySL33g=
Received: from IA1PR10MB7240.namprd10.prod.outlook.com (2603:10b6:208:3f5::9)
 by PH7PR10MB5880.namprd10.prod.outlook.com (2603:10b6:510:127::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Thu, 30 May
 2024 16:28:23 +0000
Received: from IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1]) by IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1%4]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 16:28:23 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: Yu Kuai <yukuai1@huaweicloud.com>,
        "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "hch@lst.de" <hch@lst.de>, "axboe@kernel.dk" <axboe@kernel.dk>,
        "yukuai
 (C)" <yukuai3@huawei.com>
Subject: RE: [PATCH V3 for-6.10/block] loop: Fix a race between loop detach
 and loop open
Thread-Topic: [PATCH V3 for-6.10/block] loop: Fix a race between loop detach
 and loop open
Thread-Index: AQHasjX5BcKZBLqJYUSK6DxXy7BR97Gv+AGg
Date: Thu, 30 May 2024 16:28:23 +0000
Message-ID: 
 <IA1PR10MB7240D7FC2FC1CFAC98405A0B98F32@IA1PR10MB7240.namprd10.prod.outlook.com>
References: <20240529200240.133331-1-gulam.mohamed@oracle.com>
 <06c04f8f-5e67-ca57-6764-32d542cb3e90@huaweicloud.com>
In-Reply-To: <06c04f8f-5e67-ca57-6764-32d542cb3e90@huaweicloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7240:EE_|PH7PR10MB5880:EE_
x-ms-office365-filtering-correlation-id: 39408785-1f03-4587-c4a7-08dc80c58668
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?iso-2022-jp?B?TUplVFd2UkgvZlZmSFkrVno1UzREOWN3NkorNUhpajd1dHBEamxqcGlN?=
 =?iso-2022-jp?B?MURoQm50NnIxUU1wcjd3Uk53R0wwYk5jcTRRZFYvUDk5ekVhOWFYR210?=
 =?iso-2022-jp?B?b0dDL09RanpybXFTVVBwWkpCeEJyR3NKL0VSaFU4WHdNZ1JlQmV6QlVy?=
 =?iso-2022-jp?B?Z0tXd3ZVMWUxU28xOGtJNkFCUkpnYytOejNvMnYxcWRKa3VhUWU0L0Vi?=
 =?iso-2022-jp?B?YS82Rk56K3N5dzhHdjc0V2dURUUrbnFGM2NYTCtKZDg2amsxN3BVcG9h?=
 =?iso-2022-jp?B?OVRmaFg3RGIzZTZGM3F5RkNUOWsvU2trdFRqT0kzd3hpWEhrdVlYTE9X?=
 =?iso-2022-jp?B?ckExc0p4S2J1OHVwa3VFT1Y1TGxtMUNwdUJ6d0FtcDQzdWdzWFlha2Q1?=
 =?iso-2022-jp?B?UFUrOEdIY3llc1c0c21WbS9YRFRhQmNDSmx1cG5FaFNseldwR3pmMzJq?=
 =?iso-2022-jp?B?KzNxd0FpL3hKUUZLZHpRVGtDenpPUWIzQkN6clBlVFRmZjh5eVhndDdt?=
 =?iso-2022-jp?B?NTZFNnA0SEF0dGRTdVowWW5VWk00ZllIaGJYczNiekpESjc1c2J4dkJm?=
 =?iso-2022-jp?B?Z2VOZGN5VlBLSlRScFZ3bGZIeDNMOEhuK01KZmgvTVU5SWZuZGR0VzR6?=
 =?iso-2022-jp?B?SzFoUmZtMjBZS3ZOK1N1RjZNckVvYnFtdnVKV1RUSkJocHg4QWFURjdB?=
 =?iso-2022-jp?B?WGFhRnJBRCtlWjJya2lROXBnRVhOR1J6elpkT2RoL2xoY0VWVm1scDl2?=
 =?iso-2022-jp?B?WDc5dHpOS2xMb3huclF6Z0hhc0tIZnI3Nk4vSHRWaC8yeElGZTlQbE13?=
 =?iso-2022-jp?B?c1BkL2d0L1JqUkFocGFwWW1JZFNTWHlieDh6TWxsNWozRGxKQTNNZkFy?=
 =?iso-2022-jp?B?ZkFBRjFYZmFUSFoxL2dZREJOMSttd3BHOU9mN0o4UkxKOWtPTEZYVTdD?=
 =?iso-2022-jp?B?ZFBISUxrcUR1R3BDSkRMMEQwWjUrWC9xYk5IcU9LVlB4SVk5eWEyNTlC?=
 =?iso-2022-jp?B?T1I5RldZbkJSUDF6enV2WGd1czA5UTdPVVlqbkpjZExwR24xejlmRVJW?=
 =?iso-2022-jp?B?TVJFa1VnUEloazArSkZzV25vTGZKVi9ueUxUSFgxa2t0dVpneUlZdlhQ?=
 =?iso-2022-jp?B?TFFmTGdPS2NhbWhSODhZWVVnbFJsUHRVMlpaMWYxK3BVcVNna3MxSW5I?=
 =?iso-2022-jp?B?V21pMDFzUWMvMnpuZEYxTTMyZVlBbG05dFdKY1Nualh5QUxrRmt3TUs1?=
 =?iso-2022-jp?B?R29lbDdib0NtQ25peEVwNlZYdWtxdkxzTWVid2FmYnUvajhaOEtWdDFQ?=
 =?iso-2022-jp?B?Qm0wMkNyV21hVG1hdTcrS1RQWmY3MldlMzFmMVJBK2dGWUZuQ3lYK0d4?=
 =?iso-2022-jp?B?V0c5T2R1K055L0tFa0xvZjBXeXExdG00bWdjUEk2elJKeFE5aVgvZ2Jq?=
 =?iso-2022-jp?B?eGZaYjA2cFJFUmdlc2NPRk9Odld6bHVickQzWStSMktEUHJuZUFhcEVp?=
 =?iso-2022-jp?B?NGRiTStxeGsxT3R0aEJCdjNHVGVIMFVUTThGQzVFWWFxWHV3MitnVVlF?=
 =?iso-2022-jp?B?ZkRSaG5YK0hONDJpRkxRUHN4RVppdk04ckJ5MFZRdXlBV3FvczlOUUxi?=
 =?iso-2022-jp?B?NGtEcCtiRlV4NlRJN0gzd3RCL3FoMWZrcmNGZElDdTE4aStpSXVjVWgz?=
 =?iso-2022-jp?B?MFV0Ly9CaXp6NFlObXdLUUZ1SmFCQllHb1U5SWpOYUN6ZlBkd1hrYXVK?=
 =?iso-2022-jp?B?WCtEbWtWYmFoRFkrQ24zTUY5OG96N0JmRVdIMGUwQ2ZtQVNiK2xmNzBL?=
 =?iso-2022-jp?B?Syt2MzBLK01hSHRRdlNJZzJqRm1KdzliOXdtVlpqTTlmc2JoN3dhdEQ1?=
 =?iso-2022-jp?B?MmZUYmFBR25VUFRwUnMrdVc2cjNWQ2ZESXgrajhGcjZRcFo2NVZMVi9N?=
 =?iso-2022-jp?B?SFgzRUU5SnBKQTIveG1JT05wbGdoZz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7240.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-2022-jp?B?OUJ2S2VzM21sTXpzT3JoUUM3YkJ3T2psQ0NXVkdBaEg2VHg0TWs3Yklu?=
 =?iso-2022-jp?B?WUFpNUhLUExnMjNRZ3NyODdLUEZwNzFlZmdOKzVtVXlTakN5MXpiWGNN?=
 =?iso-2022-jp?B?ZUY1TVhPNUUxbHNCVzcwbFN2ZHkxU0pZRnQrcHc3OW5Ua0c4cnZuVDlK?=
 =?iso-2022-jp?B?MXNNSEg0ZnV6bGdqZ1ExdGhxek1sWFVVYm9VUFpyeTQ0Qy9nMVYxSGRy?=
 =?iso-2022-jp?B?d3F1QzRRN2h1THVoTVF0MENnUTVDYy96bWZHc1hJYUpyNHk2NllJMEpN?=
 =?iso-2022-jp?B?ZEJuNmplQ01ZM2U5blhOYkNPa241WU10VGJ3b000VGlaTTU4dG5NWnlS?=
 =?iso-2022-jp?B?YWlJR2hoTXBTYTFzbDJxd2lHNjF2QVVVU1YzeXVQSGMwcWR6QjVVdStG?=
 =?iso-2022-jp?B?a2k4Q2xpQmtqamFxMWd1K1gyNTluRlZ0cWRBZ3VaSVphQzViTHlaaXRI?=
 =?iso-2022-jp?B?RDlpRzc3em1pc1A5SFQ1aUNkZnBJb2krQmI3eU9qcS9TTHU4WnUzYzZo?=
 =?iso-2022-jp?B?T08zcWkvS1JwdXdqa1hpYUR0OHZHaHIxNnEwUGlHV2dNVzhKQ2o4OXU0?=
 =?iso-2022-jp?B?VVJJNTIrMXU5Q3FjdlkwM3BlUzhEQWcvRVJ2VVZZSzNETFpXRFIvbzlX?=
 =?iso-2022-jp?B?YTJpMjFFS0FYVkloQXFFb3ZHa1pjNk1ESzZqTlF1YUdoeFI0azR3YlZO?=
 =?iso-2022-jp?B?M3VEK1dGVWhSeXlHdzlYWDFlMkd6c0p0Yi9teHV3R3VmT3kzWnVwZGtV?=
 =?iso-2022-jp?B?blZtb2NXbGJJRXIwSFFXTFRjeTBxNld0T1REd2UxWmNrRG54eWx5SXo5?=
 =?iso-2022-jp?B?ZlRqejcyOEpKaTJLUGY1QTFsdEs1M0c1eXViZFh1bm4yelI4eXB6N2th?=
 =?iso-2022-jp?B?MDlxdkFtOE1oYlZ3N0NvK3FmTjlnaThaUFNXbEpTQzl0VXBpa3NJLzdY?=
 =?iso-2022-jp?B?UlZrQVNqYWpsZC9lRThLaHAwL3FGUkh1em1IblE0VFc1RzU1MjFKcmhD?=
 =?iso-2022-jp?B?NEZwSWt5dlJhMGZ1eUhEb2FZMXpVTm9sckJpTWxuZlMyVE52WURkM01s?=
 =?iso-2022-jp?B?OFppSGhISGlzUE4vZjNRUWZibDRoa0lJQUIvQ2doUDd1NmJLalFsTWZ0?=
 =?iso-2022-jp?B?bGtwbXBBRDRUY0dKL2dsM1NqZkVERnMvckJOSDZ5T1pRZ3ZJOFFGcU9i?=
 =?iso-2022-jp?B?TGkxZUx0MkJYbXNKMXBQUGovcHovdVBoWnlUUUhYakJGSjdEUU1ucU9x?=
 =?iso-2022-jp?B?cjdWOGQ0SDZUNFhWdWVvaGYvZk5ydUJMcEFwWEVFa1ZyQlVjOHRCdFdm?=
 =?iso-2022-jp?B?Q1dJYzh3aGFveUpEN01NeVdKK3dXZ2VhQTd3YjN1Y0ZPVlg4aS9nOUEz?=
 =?iso-2022-jp?B?WWx0c0pWOHRtM3VMUGNCbTVtSHNMQzVDR0FET1E1TEJ4NHBpRmhUTGxS?=
 =?iso-2022-jp?B?eHMxUGQzek5LUXAxbVpYWVplQmFaUG1BN2M3UzhmYm8vTEVFOUlUMXl5?=
 =?iso-2022-jp?B?OFJOOXNqYVZ6L3FZcDNSc3ZBQ3ZxbDlvNTR2aEJ3Q3p4OG9iYWFNVmNP?=
 =?iso-2022-jp?B?NldEcU5QVlFhNWpmL0VqTEs5UmVHTW1oWmI2TG1yTGRyWi9aY3JoZ1U4?=
 =?iso-2022-jp?B?clZpcmpIVDMrWUxzZGk3ZW9WNHIzMlhNTUJYTjQwWXdHQTM5Y2xtdGVL?=
 =?iso-2022-jp?B?Y01NTXpocXc3TEh0N3h4Y0FBODhpRUhXUjRVak9ZUEw2Z1kxUzBISndR?=
 =?iso-2022-jp?B?amprTzZzenlaMHY3MXNLa3FORUJyYSs4S3FDMnlXT1p4U0FWbDBlWmZH?=
 =?iso-2022-jp?B?cVY5anJzdU9vN0puM1czV2JkZ011aHFqMEFlbW15Z2lXTEsyRXhrTkVS?=
 =?iso-2022-jp?B?MGxmdzZqa2Ywd1oyKzJqTkRRdzA5QU5ZYk1WcFY1bXZMZS9PVm1Udnha?=
 =?iso-2022-jp?B?bzlOTURRNmdES2oxNmhIdVpMamRpclRmSUNJemZYU21tNVVRSEJIZnk2?=
 =?iso-2022-jp?B?TTFjR2pHOWhVWW9iY3phYUd5SHgzNTFERWRRS1IwSWFyOTE1bzYwdDVN?=
 =?iso-2022-jp?B?eFpxeUFMVlRjM3dOWWJQT1NXaDJPTXZSQThSY05OQVVhQVRMeTZ0UDRL?=
 =?iso-2022-jp?B?K3owbitPSzdtNWV4RE5Ea2FxbmN6aVZkd0x3VjVnbjh4ZllnNFFGejEy?=
 =?iso-2022-jp?B?WG9HZ3puRWpkK1lqWU1DcGRDdUllVWxnYXg3V2laUHVZcThBUFdhcXNq?=
 =?iso-2022-jp?B?aTYrMHFFV2trWWkwUllWNmxkdWFUSllldE1aUHJFTDVCS1ZraUdtQ2JR?=
 =?iso-2022-jp?B?TjJXNA==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	KkjY4dtcD0lqWHFp5rd8iu7sSqCZmHeDm8xoOy/clVfCA3KDTZRpLqoFbFluSNcm//xoipRavsJJlKGQOs5GFIkxCfZkGgpnihSaZ7+Z18LEoLcupjMXcq11QZt0Q/GqzQjuWs4ihqEBFzkBxN9wwktnABGccYyon+xjBfASNVtspu7A+UtWIZ+BTYJtLWJWuiuwczmHrTl2W23NL+nNNR96Cjx5J16smnVI5p7oiAZBdQZtQGssazbbCkaX/wrjKjOyKl0RDFzqr4uHE24S5f3RrvDTlJL7PY4HuWtDx+gAZ7tRH+0kibH8u6+WGwlfGyxHJ9c1ZidXzAwGq//E2GjJYzl8r7FmCdFFCgUK3eA3nhAo0m96+5iDpl6QF6TaLw/f322b1WyJgggJj2PjdIAAVxwyFOAopDZB7BoBL+ChCLfB1VPxSt1abq1qtkXvXvxLeZWkh0T6kBU3KVzJHEhGIUZAhIGyJDf1HiN+AG3IBKObvtpduv5XbdE9zs7EFqPqJ3SKnfxsPzKuwQFUKU5XT6nniRreMS2SLDdHfM332a7P3iDlgSKDpnPObo0ZXeEaVnx5ChSlTEnRmwqVkfFmgelwWvk7YZMMG9eJbUM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7240.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39408785-1f03-4587-c4a7-08dc80c58668
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2024 16:28:23.1200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3xBFPR3eohJWQDX98rTG6/0KFTcoueuUAXu63hIRR62zixwgXzwOkKCrd7imcf4tx0IFAaz+ZmIfS1HikdViMhBjkQhHmfjf2L1y0WXwwGo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5880
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_13,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405300122
X-Proofpoint-ORIG-GUID: pxRu1eZJjxKarLYCiY_Xse-pnZn0GkV3
X-Proofpoint-GUID: pxRu1eZJjxKarLYCiY_Xse-pnZn0GkV3

Hi Kuai,

> -----Original Message-----
> From: Yu Kuai <yukuai1@huaweicloud.com>
> Sent: Thursday, May 30, 2024 7:36 AM
> To: Gulam Mohamed <gulam.mohamed@oracle.com>; linux-
> block@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: yukuai1@huaweicloud.com; hch@lst.de; axboe@kernel.dk; yukuai (C)
> <yukuai3@huawei.com>
> Subject: Re: [PATCH V3 for-6.10/block] loop: Fix a race between loop deta=
ch
> and loop open
>=20
> Hi,
>=20
> =1B$B:_=1B(B 2024/05/30 4:02, Gulam Mohamed =1B$B<LF;=1B(B:
> > 1. Userspace sends the command "losetup -d" which uses the open() call
> >     to open the device
> > 2. Kernel receives the ioctl command "LOOP_CLR_FD" which calls the
> >     function loop_clr_fd()
> > 3. If LOOP_CLR_FD is the first command received at the time, then the
> >     AUTOCLEAR flag is not set and deletion of the
> >     loop device proceeds ahead and scans the partitions (drop/add
> >     partitions)
> >
> >          if (disk_openers(lo->lo_disk) > 1) {
> >                  lo->lo_flags |=3D LO_FLAGS_AUTOCLEAR;
> >                  loop_global_unlock(lo, true);
> >                  return 0;
> >          }
> >
> >   4. Before scanning partitions, it will check to see if any partition =
of
> >      the loop device is currently opened
> >   5. If any partition is opened, then it will return EBUSY:
> >
> >      if (disk->open_partitions)
> >                  return -EBUSY;
> >   6. So, after receiving the "LOOP_CLR_FD" command and just before the
> above
> >      check for open_partitions, if any other command
> >      (like blkid) opens any partition of the loop device, then the part=
ition
> >      scan will not proceed and EBUSY is returned as shown in above code
> >   7. But in "__loop_clr_fd()", this EBUSY error is not propagated
> >   8. We have noticed that this is causing the partitions of the loop to
> >      remain stale even after the loop device is detached resulting in t=
he
> >      IO errors on the partitions
> >
> > Fix:
> > Re-introduce the lo_open() call to restrict any process to open the
> > loop device when its being detached
> >
> > Test case involves the following two scripts:
> >
> > script1.sh:
> >
> > while [ 1 ];
> > do
> >          losetup -P -f /home/opt/looptest/test10.img
> >          blkid /dev/loop0p1
> > done
> >
> > script2.sh:
> >
> > while [ 1 ];
> > do
> >          losetup -d /dev/loop0
> > done
> >
> > Without fix, the following IO errors have been observed:
> >
> > kernel: __loop_clr_fd: partition scan of loop0 failed (rc=3D-16)
> > kernel: I/O error, dev loop0, sector 20971392 op 0x0:(READ) flags 0x807=
00
> >          phys_seg 1 prio class 0
> > kernel: I/O error, dev loop0, sector 108868 op 0x0:(READ) flags 0x0
> >          phys_seg 1 prio class 0
> > kernel: Buffer I/O error on dev loop0p1, logical block 27201, async pag=
e
> >          read
> >
> > Signed-off-by: Gulam Mohamed <gulam.mohamed@oracle.com>
> > ---
> > v3<-v2:
> > Re-introduced the loop->lo_refcnt to take care of the case where we
> > race when the Lo_rundown is set after the lo_open() function releases
> > the lo_mutex lock
> >
> >   drivers/block/loop.c | 31 ++++++++++++++++++++++++++-----
> >   1 file changed, 26 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/block/loop.c b/drivers/block/loop.c index
> > 28a95fd366fe..60f61bf8dbd1 100644
> > --- a/drivers/block/loop.c
> > +++ b/drivers/block/loop.c
> > @@ -49,6 +49,7 @@ struct loop_func_table;
> >
> >   struct loop_device {
> >   	int		lo_number;
> > +	atomic_t        lo_refcnt;
> >   	loff_t		lo_offset;
> >   	loff_t		lo_sizelimit;
> >   	int		lo_flags;
> > @@ -1242,7 +1243,7 @@ static int loop_clr_fd(struct loop_device *lo)
> >   	 * <dev>/do something like mkfs/losetup -d <dev> causing the losetup
> -d
> >   	 * command to fail with EBUSY.
> >   	 */
> > -	if (disk_openers(lo->lo_disk) > 1) {
> > +	if (atomic_read(&lo->lo_refcnt) > 1) {
> >   		lo->lo_flags |=3D LO_FLAGS_AUTOCLEAR;
> >   		loop_global_unlock(lo, true);
> >   		return 0;
> > @@ -1717,14 +1718,31 @@ static int lo_compat_ioctl(struct block_device
> *bdev, blk_mode_t mode,
> >   }
> >   #endif
> >
> > -static void lo_release(struct gendisk *disk)
> > +static int lo_open(struct gendisk *disk, blk_mode_t mode)
> >   {
> >   	struct loop_device *lo =3D disk->private_data;
> > +	int err;
> >
> > -	if (disk_openers(disk) > 0)
> > -		return;
> > +	err =3D mutex_lock_killable(&lo->lo_mutex);
> > +	if (err)
> > +		return err;
> > +
> > +	if (lo->lo_state =3D=3D Lo_deleting || lo->lo_state =3D=3D Lo_rundown=
)
> > +		err =3D -ENXIO;
> > +	else
> > +		atomic_inc(&lo->lo_refcnt);
> > +	mutex_unlock(&lo->lo_mutex);
> > +	return err;
> > +}
> > +
> > +static void lo_release(struct gendisk *disk) {
> > +	struct loop_device *lo =3D disk->private_data;
> >
> >   	mutex_lock(&lo->lo_mutex);
> > +	if (atomic_dec_return(&lo->lo_refcnt))
> > +		goto out_unlock;
>=20
> So, both add, dec and test are inside the lo_mutex, then there is no need=
 to
> use atomic value.
Yes, you are correct. Will change this to "int" in next version.

Thanks & Regards,
Gulam Mohamed.
>=20
> Thanks,
> Kuai
> > +
> >   	if (lo->lo_state =3D=3D Lo_bound && (lo->lo_flags &
> LO_FLAGS_AUTOCLEAR)) {
> >   		lo->lo_state =3D Lo_rundown;
> >   		mutex_unlock(&lo->lo_mutex);
> > @@ -1735,6 +1753,7 @@ static void lo_release(struct gendisk *disk)
> >   		__loop_clr_fd(lo, true);
> >   		return;
> >   	}
> > +out_unlock:
> >   	mutex_unlock(&lo->lo_mutex);
> >   }
> >
> > @@ -1752,6 +1771,7 @@ static void lo_free_disk(struct gendisk *disk)
> >
> >   static const struct block_device_operations lo_fops =3D {
> >   	.owner =3D	THIS_MODULE,
> > +	.open =3D         lo_open,
> >   	.release =3D	lo_release,
> >   	.ioctl =3D	lo_ioctl,
> >   #ifdef CONFIG_COMPAT
> > @@ -2064,6 +2084,7 @@ static int loop_add(int i)
> >   	 */
> >   	if (!part_shift)
> >   		set_bit(GD_SUPPRESS_PART_SCAN, &disk->state);
> > +	atomic_set(&lo->lo_refcnt, 0);
> >   	mutex_init(&lo->lo_mutex);
> >   	lo->lo_number		=3D i;
> >   	spin_lock_init(&lo->lo_lock);
> > @@ -2158,7 +2179,7 @@ static int loop_control_remove(int idx)
> >   	ret =3D mutex_lock_killable(&lo->lo_mutex);
> >   	if (ret)
> >   		goto mark_visible;
> > -	if (lo->lo_state !=3D Lo_unbound || disk_openers(lo->lo_disk) > 0) {
> > +	if (lo->lo_state !=3D Lo_unbound || atomic_read(&lo->lo_refcnt) > 0) =
{
> >   		mutex_unlock(&lo->lo_mutex);
> >   		ret =3D -EBUSY;
> >   		goto mark_visible;
> >

