Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B4916C875
	for <linux-block@vger.kernel.org>; Wed, 12 Jun 2024 08:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718181470; cv=fail; b=NL35cTfJt2i52zhPMRRs4oJbfcTOW4tH5khJVGc6mjinOVq921BxiJLUO2LdOU/XBjkmlNbJvl1eDyGv4AZZT7yJfBEgtwcnhGznq/I0W7LzTnHJWeKPNuvcDTWxH20geg8hzC16B0kjXb6W5IuYktnQX5E5PYyQ0OwbyGy/EjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718181470; c=relaxed/simple;
	bh=/jEFPRx4zWy9MbNQKKmqpnxVSq3pX6lD/fnnG8Fmtw8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=flX9Flvh0nJpHeW0IOg31jYmJKeQigKzitRqVfrDKw1im2NcB0i6Zie/LtLMnv+cO/XtciNC7nF8brZ3mu+Ut58jQWJsqI2xR2b/mlqGxHsj1HUbBcQHXg5SliIUkDsE7gsV75k6zoICZofsS9E/hQxKgEZ39PER3FA7zOHTvj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BfAdY7Ri; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TxtpUKFd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BfAdY7Ri";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TxtpUKFd"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45C7BQV2008921;
	Wed, 12 Jun 2024 08:37:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=F+P8Xl3LIoeMcgl9wa15OrRQNTkUb/qAX6p+rw/o9C8=; b=
	BfAdY7RijqByVTdFcCUIYRAjKXkyXsp1u24V1fZbsTY4eZtwVcoP6VnwlKHJjAUr
	hPAdMylZyijG+xBaXDuLc8BGNdkoAo5yKT52bt+Ugw5XADS3ZEjhPNWSg/K6Jgoy
	XrBoL9IeDg+ndlzIxu40dNF1fc8V71X3cQ+H5IFVpt7DuE2DNgPwQ6z2Qd4hbjl/
	03JqA2JdOtDTIAeSzi0JuybCtyFWUQlH+2Qu08Q0blBpZAlq9JGCtrlHcnl+k36I
	EQd1nKZEs7nQDnPyzdDMxnpn3aQbJI2P//PAHbriZXQYywPJlhdyCbu/QclmdOvg
	Yl9RLYkvpzy2OR6KaaNkXw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh196m32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Jun 2024 08:37:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45C7s5dN014236;
	Wed, 12 Jun 2024 08:37:40 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yncev4ndh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Jun 2024 08:37:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JBdCxedGpwV9V7yT5HJcbHoUrjoDY1zG32eWE5+ZVr7TFqGscCpp+OZ1dCcExBNixXa0JhAp5F/Y35wBH020MDYR3MIK8uf7m88mxN4/U99EF36kVJapPFGsj5QNkcUCYTBVX/+Cx9Jhfc0UqZoggTDJ+d5iFTQU25zsXKdsYFdfMNnN1alM8hmHiANMECazy0BC0TGf1yaRhkWUULfAp57Mnw5YKfKIK9FYol19Ir/olsvkIv3NSHcrM71pZZ6NpxneEFRHt3uxbas5LzlSpZs7HWs1XXt9b91UguB0qXoQyAsycKkvQdxYgNUXmZMUuQau/eMGbyIp2M5d4st9DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F+P8Xl3LIoeMcgl9wa15OrRQNTkUb/qAX6p+rw/o9C8=;
 b=ETBmPSvgHjrku5kriq+WTw9EzOztwP2LeKIGjRNXh3ItfUwCbpWxFfVg2J5CWyQDZukkla3yZvnx/7m7nHgYVLwLZpiWT4i/Mj8jpZRUWKSFtjW2pm/lMdxPC2/Y4+sQfwz912IiTdux6Ay084hfivUcKQ+WZYjKX+q5cxzikMFbmW90FVdgge7LeAHJP4TibhHp1RMZIJj8zfL9KKzFarTNB0RX2I5zHsrtPCBYG8vUhVhbIejFaJGMMCrc43jONCKteS5PuV0dg85NUPI1Q+AS7K37sM9DAImuItgwX+CilqL6fs6KOYrd5F8Nzse3+7czZ8sqNnFZHv7Hbfhiiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F+P8Xl3LIoeMcgl9wa15OrRQNTkUb/qAX6p+rw/o9C8=;
 b=TxtpUKFdNB8BQhGf757nh/kg34meDAWw59WlCejYbdf9xN2IFN1hxRtL//xF3B0MpdA5KSnHA6WmnrbH6Dv/KXC95gV+veY/pKHuIcxXEE5GlYBO0Y0ucbRdByXR9o0wEvjbI4MXz/yY/cfMf8Pm9N0xEWh1ERJxTgrHfoUjFsM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB6766.namprd10.prod.outlook.com (2603:10b6:8:10e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Wed, 12 Jun
 2024 08:37:38 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7633.036; Wed, 12 Jun 2024
 08:37:38 +0000
Message-ID: <715e7a9b-83a5-4df9-8d47-9cdc92b4c173@oracle.com>
Date: Wed, 12 Jun 2024 09:37:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: work around sparse in queue_limits_commit_update
To: Damien Le Moal <dlemoal@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
References: <20240405085018.243260-1-hch@lst.de>
 <65a7c6b1-ad4e-4b27-b8b1-44d94a66bf7a@oracle.com>
 <20240405143856.GA6008@lst.de>
 <343cc769-b318-4c2d-b08a-0bc752f41f78@oracle.com>
 <20240405171330.GA16914@lst.de>
 <293dbd7b-9955-48f4-9eb4-87db1ec9335a@oracle.com>
 <20240509125856.GB12191@lst.de>
 <4bc6ab52-31b0-4e1c-96d1-2568a43af7b5@oracle.com>
 <e2181429-3f0b-4999-87b7-8fbc8aea3765@kernel.dk>
 <65430500-14bc-4e71-ba40-024ef293bc4a@oracle.com>
 <c9e43ba8-616a-4c60-9cf9-c99c5b7a4979@kernel.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <c9e43ba8-616a-4c60-9cf9-c99c5b7a4979@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0205.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB6766:EE_
X-MS-Office365-Filtering-Correlation-Id: 000c6843-81d5-4242-78de-08dc8abaea81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|1800799016|366008|376006;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eW90Zzc2ZHl5Zmw4Z2JicWlZUHRGV0xPWWk0aWU1Sm9Fek91WU4wbFJYMVR1?=
 =?utf-8?B?WnpEcGMwZjBVaFZoZXFOU1I4cmp5aXAwdWcyU1pORitUQnVBemlmNzdJclpG?=
 =?utf-8?B?TG9VY1A4WWFJWVNzdGZmVHlUSWpVRk1jelA4SFF4UnNFc05FZGJwK0RtWFJ3?=
 =?utf-8?B?anByaDExejVyUnhtcy9YbnJiMFRjTTlOYzVYYmdnZ2hZU1psUXg0elVHS2xj?=
 =?utf-8?B?cnEySmhJZEZaVDM5ckIwdlBCbWtXbGgwVDhhcjZjckNWVlpaWVowdFBRelV6?=
 =?utf-8?B?YXI2Sld0UWVlcXpjbWlFUVVxZE1sSXhrT1pSU3F4ZnB6eStlU1RLbUloYkVK?=
 =?utf-8?B?NzJTTUFMNVdaVlJsYjNadWZ2K3JXTEx2LzRsZHFCNHBqVU1vODdlYjRPVEhn?=
 =?utf-8?B?RUl5bk4xeEhTZkRDaVkvb1pTNnVZQTFrQWF2Mno3KzRhVjZBOUFkbGxSK1hh?=
 =?utf-8?B?UUJJckU4aUNSNFhkN0lqRGNSSWFkZlp3MTVCZnk4aGREUkl2bHFUZ3JUQlFL?=
 =?utf-8?B?Ty9mUnNrN00rWDJLYXc5N05qMXRwcW1WUTdFMmVGRFU4aVpNT2JOekZKZVYy?=
 =?utf-8?B?eGRDOXhqdS9tYVVKVUFDeEpZZkJMQ2tpUFEvelpWUGJ5dDNVT0hwUUtiaDdW?=
 =?utf-8?B?UThNQ2RrenNkdmFOaTdZUURNeE9KcmpDTkRxVFRPL0JmdVQ0Sk9XbXBEM0lK?=
 =?utf-8?B?bk9acU1OaUM2MWM1YUFEVlZ0RVBBQUptM20wWnlDSE5aTXordFlucTBnMFdV?=
 =?utf-8?B?STRJTGJIMVpxTHVIZ0d5b1BlOVZIWFE3OE9udEd2VjZnYTlGN2FydGoyZTZi?=
 =?utf-8?B?a3FsNU9WblNkVjViazZ3RURQbGdQMWJSNVdxbzRVQ08wcnZoZTkzWS9oN3k1?=
 =?utf-8?B?eXpVS1dZeU1SL08wVE8reFlsa2xqeVpic3BrSFBlZXhXQUpVK3VPTjdOTWVj?=
 =?utf-8?B?MExteHZ5QWsxSmUzQWhMYldLUEt4YmQyeVdmVUYxeVNTYUw5bEcvME5GcUhu?=
 =?utf-8?B?L3Q2Zkk0ZTFyZU9HVkdtRHlhTlVQTXNDcCtDZTU0b2dHc3M0NWxITWhEUEF5?=
 =?utf-8?B?TktMY2R2ZU94VFR2NnlmQTgrb1pkSGlqZ3lmRXFKdjQzQ0ViV2UyeTlrZHFw?=
 =?utf-8?B?V0hhTlBtc3VFUHBENlpLN01qMDhLL2dUZHk0c1hOQUxtOUoyQnNSK3pISWdk?=
 =?utf-8?B?RlpUcjFOQmRHZnRZMmFVR2lTTTk1a2NqcEhWRVc3bHZxOVJtc3VoTzc1WTFK?=
 =?utf-8?B?UVdyNVFscnhjQko1NFFMdE5FNEx6Rkdmbm1UNzhEajVtNEMwQnpJalR5S1RL?=
 =?utf-8?B?MGVZWmpXL1VxZzRnczE4SHpEK2dRVFRpWDd2SG9jWkd6YUZSQ3NJdGd1a1VR?=
 =?utf-8?B?T0MwdGEyUVoyMFNoMGFxand6bnk0WWJiS2NOL3RXaS90Y2d3a0hTemFzRGlu?=
 =?utf-8?B?dVMwRlBkOGlES01ILy81WU5KVjFVQW5jSzBCRGh4SnlxT2lmK2M4bDZjcDRw?=
 =?utf-8?B?WFMyNkZlaTUwcWhrZmxjZksvZDVEODVRUVllOHpUVnRUSXJ3R0ZyZUFRNllR?=
 =?utf-8?B?R013ZXRwcW44TWJscTFhamhSdUYrOExxZXVDNU1TK2VCSm5sQzRCU0hhM2JH?=
 =?utf-8?B?U1grK0hVV0haWkdHSXNGVlowVkhsaitLOG55UE80L2lJQ1ZuUE5ZRCtmRmVI?=
 =?utf-8?B?QVUxbERiQ2l5anE0M1AwSnl4bndrVEc5VFpNTnIxTG5TbDkvODdqUnhxUHJh?=
 =?utf-8?Q?VWVJcMVAJDf7FxqR+TsWxXi4IQthu1HXVzuqivL?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(1800799016)(366008)(376006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TlExSENtUWoyeDVrbTcxbUc1REQvMGlGQVFCbFB2UkEySHNCMzl0Wi9CYi9P?=
 =?utf-8?B?YXpsVERFWFNjS3krd3ZhdDYwRFB2OEMvM2lmeCtZR1g2VTBjWldvMmRTUnZn?=
 =?utf-8?B?aTBwajN3eGJRSGVxcllNYm1FNGZhK01UeU5jV0FXQ2k5aGtIQmt3K1I5QkYv?=
 =?utf-8?B?M3hPY1JlaDIvd3dvZWM4UVBqNUE4ayt0Z1Y2Vm1EMEIzeHgxVFBVaXM0VGkz?=
 =?utf-8?B?M0tScUNvWDI2UnFwWklZaTB6Ti9ldThhQmtDeXZBeFl5YkVYa1Q1VWtLY1Uv?=
 =?utf-8?B?WTNydE9ORWhkdUh5c2VDaFJOTlhYQVBvWmFmWTh4bDRIL0JaSkJXNVVKVzly?=
 =?utf-8?B?blc2TFE1VXhtT2M1Z1loYkNqMWtrczRxdDdkeWNsR3VvT2grZU9pQjRkdlh2?=
 =?utf-8?B?YUVHRWtTdmRmS0hxcHBMczdmUVlFN2dXRCs5ZkZESW0ybEFMaWM2aGZwYWxa?=
 =?utf-8?B?b0gzSHRxWUJ3MVdhVWQzVVIwN0lqUzV4ZFR5Q3VYd1NxQUpFWFkyWFlRS1lp?=
 =?utf-8?B?MVdSZUNjSVVuUmh3aitFSTgweFhjbGpwdkVxOW55Q2Z5NmE3eTMyVjBXRGpq?=
 =?utf-8?B?NzdaVXdyUTVoc0xka1RrQTVrMC8xVnFoNkhQb3Y2cGZYWWxsbXU1YmV4b2Fl?=
 =?utf-8?B?N094SjRWYU5BbmYzN1RuYW84K3ZDaXI5NWdJaFpJTUlkZ3lLVUQrcTZvaHJB?=
 =?utf-8?B?QSt3SHFWdjdDdkgwU1RxV08wT2I0TWlpbTdJK1JjdWszT3JMblVwYU9qT2tF?=
 =?utf-8?B?ZkMvVFltNGhTa2FGMmt0WnBydkhnNkdVanl4emlqSE1EdmE4NnpoK1d2NDA2?=
 =?utf-8?B?c2RudWZ5TlhpQXBFN1dJNGVpM1pHd1kxSzB1V3BYWi82azZqaStNaStuNlVh?=
 =?utf-8?B?SDdWQ0lsbHltVjVQTG1PU2dMQ3VON2U0OHZlbW1XNTZXRnp4UG5MQzNRSXp1?=
 =?utf-8?B?MTc4dSsyVzEweVRvM1dXdzA3QUtIWVRIS2kvWlFBeWxCK3lsbjA5L25leDVQ?=
 =?utf-8?B?cWZ6eURXRUJWL1F6ajVwK2cxaDBBTm1LZzgzNFBSR0lRV05JVG1ETmVSV3Fx?=
 =?utf-8?B?NVV4QVFSNng0dm5tQnFrY01PN3pnZVRmemo2Z05GT2lac2RIbWsrU1Q2TDJT?=
 =?utf-8?B?L01kN0QrT2hrY0VKMm9BZWV4OVEvRFhadHNRNlpzVGFiUGYwTmVKTi9qSngz?=
 =?utf-8?B?ZjJBTnJ1dUVROXdkMzcydis4SEJsRU56aHdLbTg4aWlLMU5BQ01uOWhMWnBN?=
 =?utf-8?B?OFZmQkZuS1RweFBqS04wTVRselFtNjd4RzRYOE5JQTFkdmtLYWUzK2N2Ujd1?=
 =?utf-8?B?ZVpQODhNNnNBbkxoRmxnYmtONmwvRGxaZFVTWDU1NVkrNE4xRWtrZ3JVR1Ni?=
 =?utf-8?B?UnBsRWV2N21nNGhBWFVHUWF4QXRqSmVDbmJHaitOVHBtTzNYeVVyM2JvOFhM?=
 =?utf-8?B?b3FLNTFPdDdueG5qd0xYUnphRUVza3JibGtKNzJEcWpYWEFHc2xvbllQd3ZT?=
 =?utf-8?B?c3ZTYTEwKzVhTk5INkszVElvSjZuNm12V1BGaEtaQkxzMGUwVW9lR3AyM3F4?=
 =?utf-8?B?WVFRQm5NUk0xbHdlYk56R3B4MHNiL256cTRYblRCWWNLNzdEcnNZc1BYeEhO?=
 =?utf-8?B?Y1lZaXhpM0gwN2MwZDczOWliMVNWTDhSMTZYYW14M3puN2RqanRqN0NJdTZp?=
 =?utf-8?B?VFFUTnkvbE40eWhIZ0FDS0xYMFl5U1pRb3RlRFFYTklWT0lRM0QrQzY2dzZi?=
 =?utf-8?B?MXNSZyt2VGIxVXY3K0pSUndMdWRMeFdFaUM4Um45QWhYcjRlTnVPSjVPYm9h?=
 =?utf-8?B?eFJuclpad1VIS1BQZzhhbHpCNHA3eFlGOWFlWHEzV21MU3RuWEpSamxqUS9k?=
 =?utf-8?B?eFNoYUM1SmxDWCtxaFVnS2RDODJtMXFxTDM5VVlrR0hGSlY3SjJuYXd2dnpH?=
 =?utf-8?B?RnA3a2ppeU9lVGU1aVBQa3dxMDJJMFcvckFVaS9zYjltTDgvRDdKa0dEMy9H?=
 =?utf-8?B?cEg1VVJyOXd1QWRmUmdsMEwrUno0SFRaNGpTazJxTTd0SHhxakE1TEJETld0?=
 =?utf-8?B?TFB3WmpuYTFCemdLa0d5K29uS0xlZ2wzSktGTTA5cXhOb01xMGNQUDhWbVho?=
 =?utf-8?B?emtsOTQyTU9zanZJMGx1RHpoWEkybHVrNC9KV0FUeHFETGlCRzV5dSt0dExv?=
 =?utf-8?B?YkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	8WkOYKwEITyA0UpGMdnndpB6mFWlnMozS5aI+qGNQDAWuuBbLmsb2lbzWHKcb/fK37PeNKQ1L4G0nmkGR4sWOVUX/3aHJ0TPQ5Lr+V7UXBKXdFIs+xaz6UjIfv16YepZ4zWt+ZX/5eCAgVUmXDOpCttNWdP6xKOFKtOpHGnPjnbgduwWtVmwK6ZvyrNH58mW9PFYzG74fO3vvhlPLM9qbQ/noBKIyVNHmIK6h1zOI/yAIAqvnKXRWdFfbWmlftvqpEIHflCDtCF0/KLlXHCkzSLmvJXL38jSYGICeZYjYd+aaiRFxCgmNPDmftNAZOAHMA0WHt9kz1tpeXmKEJpxhutWlEplQmFfwRxeKymtXqhBX6vx1qe2mVQ348bEHR5gQrKEvNCLGhX9G2LzlDLVeLnbYi+MtKLU4cF75sDEFVS4yzAUvTh1IAQa3BQ//BQuYVMO8+S3Cy0SW4DCHekwcc2Yc/Ifi0DdFvKE+LF/NWmbRXk/Cgdcb5cWN/sEPzmmfQq2DprjBZRn18u+e+egANWtqRh7y8dfyAbc/4mBPSPeRcchXLoN2Tm+4MIvUO4itQKcszNRJvsKoOvNcJcuLX13aseGNyE4QwXXbJqjRw8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 000c6843-81d5-4242-78de-08dc8abaea81
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 08:37:38.4690
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3dyi+TwTzBjFjdXlTsQABTN9lNu47I3PfBgQLYcHBvPjTrQ3Tju5bwxzwMrbJSknSLVVfZFuaj5OQLD/15MnTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6766
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_04,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406120061
X-Proofpoint-GUID: wUVS_DWWeYS7PBY8sI1IB_WuggLUH6jC
X-Proofpoint-ORIG-GUID: wUVS_DWWeYS7PBY8sI1IB_WuggLUH6jC

On 10/05/2024 02:40, Damien Le Moal wrote:

Hi Damien,

>> block/bdev.c:377:17: warning: symbol 'blockdev_mnt' was not declared.
>> Should it be static?
>> block/blk-settings.c:263:9: warning: context imbalance in
>> 'queue_limits_commit_update' - wrong count at exit
>> block/blk-cgroup.c:811:5: warning: context imbalance in
>> 'blkg_conf_prep' - wrong count at exit
>> block/blk-cgroup.c:941:9: warning: context imbalance in
>> 'blkg_conf_exit' - different lock contexts for basic block
>> block/blk-iocost.c:732:9: warning: context imbalance in 'iocg_lock' -
>> wrong count at exit
>> block/blk-iocost.c:743:28: warning: context imbalance in 'iocg_unlock'
>> - unexpected unlock
>> block/blk-zoned.c:576:30: warning: context imbalance in
>> 'disk_get_and_lock_zone_wplug' - wrong count at exit
>> block/blk-zoned.c: note: in included file (through include/linux/blkdev.h):
>> ./include/linux/bio.h:592:9: warning: context imbalance in
>> 'blk_zone_wplug_handle_write' - unexpected unlock
>> block/blk-zoned.c:1721:31: warning: context imbalance in
>> 'blk_revalidate_seq_zone' - unexpected unlock
>> block/bfq-iosched.c:5498:9: warning: context imbalance in
>> 'bfq_exit_icq' - different lock contexts for basic block
>>
>> Actually most pre-date v6.9 anyway, apart from the zoned stuff. And the
>> bdev.c static warning is an outstanding patch, which I replied to.
> I will have a look at the zone stuff. This is all from the new addition of zone
> write plugging, so all my bad (I did run with lockdep but did not compile test
> with sparse).
> 
Can you confirm that you looked to solve these zoned device sparse 
warnings and they are difficult to solve?

>> At a glance, some of those pre-v6.9 issues looks non-trivial to fix,
>> which may be the reason that they have not been fixed...
> Yeah. The context imbalance warnings are sometimes hard to address depending on
> the code. Let's see.
I am looking the other sparse warnings in block/ now...

John
