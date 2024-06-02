Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA81A224DC;
	Sun,  2 Jun 2024 10:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717325841; cv=fail; b=QIiMzWmxm2Fyq6dbCbF94dooMNu4EOzRPelQclhgvxix0YYUgLk43/PHTy4BCn4PrvdTO7c2Bq0MoYdMv0Enkmn89uBEiNO6HlKSXRGO6v+pN7uZbiQFsb4icB7BRzXbNFMJ6P79jSWPUP9v9jMOHZ7OW7dCKj1IEbik0aCjEZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717325841; c=relaxed/simple;
	bh=5zLhooXENdFHGV0zpKwhiTuf2cAb9YB5JZNlfVTgjd4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oK10xvki0+mIVIwI+w/S53Nyck5OTnvSYhIywyi8wqUAMRm1dxicFNBK89Pnmmlew1PYPihjJpYXEBeovj6noOrMFndvb4m6tY6GmUKRD0RiSp5BP+Znar4tx3K3DGlzwhvhWDfVY9jyuCuS70A+BoawnfP0W5R+cuKHVcDaSlE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4524uwxx030931;
	Sun, 2 Jun 2024 10:57:12 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DDfp+ZGO1685zi6LLnyu79ayBV1RHue4YnxK/I4toHfk=3D;_b?=
 =?UTF-8?Q?=3DTtIUytlmZYEM/btVdAa2dF1AWJdptr71xVKYMFDe2yq3J/wOjZAiGLyEf9My?=
 =?UTF-8?Q?ZGMxj5pB_lX0KWXV6HiDr9EpwngTC7oM2PnVQdBgeVDJWudt1mZz6bUzauaUWzv?=
 =?UTF-8?Q?/SnU46T6BMUFPg_Oj7W/Fr9/cIJN7Wk1iai9cBp7OqtaluhyP1FPkozFqiw9bdj?=
 =?UTF-8?Q?OKCyQORsJYJzJMwULjRf_bIxjUE0tV424tEqEN3XJcvmCUovoW8EnUVEdyA/6st?=
 =?UTF-8?Q?1M5LunE6juuoVSM51WFRBunk/X_VaJZ4dY1K5ZYzoq3b/zQYrjWUTqJ2elX0pnz?=
 =?UTF-8?Q?E1pjVWaSxPCGwr1bkuCIfLsvK+9n7HQe_dA=3D=3D_?=
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv07s97h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Jun 2024 10:57:11 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4527LwST004448;
	Sun, 2 Jun 2024 10:57:10 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yft3bweeg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 02 Jun 2024 10:57:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3GthmRgLX6qBVJ9ZR6OCvK2le7OkpIOPhprk1hoO/TZsJdk85FRf/X+VCS558PSr5b3YYRFwtLNQC+6iK+hBW0i6Slmg+JoZU9C/9/u9VJFUh4voRNqm9hbOCKxj8Wzx/ldYLI6pLZjYlnPOzwuaWUYIRsWAqnCb0Z1pBq44TLdceUIIl/dXYEPu9DULxIU+FboQjcnO42XDj8CZwiPRN6QADpoDxnCq5ofHX6lDerPq8hn3LdJ0Cj+IK1RAsC5AeBZkuLIzF6Qby0npo54N+HFY01aWp8Fq8wxGHjMu/e4jJ3o0onXAZOJ8l3LTMGQ8e+YopUa2or+Cbpv4OYgwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dfp+ZGO1685zi6LLnyu79ayBV1RHue4YnxK/I4toHfk=;
 b=ebsMvKZj3lDVfulo1D/6mWkknrPd0mBkBaOZJGHJG3hL0NVLYGzPiM6LwlLxcHCDNAc2/5VGoOzfUFez28wbMDyA/3MjE2jsxvWbQzJZaNQKgal1jtPEVGIfbaZAxg4iqrQZTLf/L119c+l1WuTwVJxHfXkXDZpNK3XPzCU/kI3VKgLU9ZZBWpi+pHylgNMejHjpMWR2EIISGcFM//PocH8zpHoLa5yLZPcnTU22rnwcF9sQw3+E7/l3Lm9h2nfszRo6JicgFNS6HoWsP99LQtDd8Be7r/SGW+J2Y8Il9f2uZU3i31yquNYW4z7yOEvgx3Y2Dg6L4boPEddTNOgrsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dfp+ZGO1685zi6LLnyu79ayBV1RHue4YnxK/I4toHfk=;
 b=N9yAxwjAZnYyAe6VxpqcM9pREOgZrb9VqhQ7YfnlN2Kp4zFxioe8Tw6/AaYe9iOc07SJobtcR/yfj/oMZzKee8lSbPrt+uqiNuYR1avDZtVP/6QSue0rzLEIxCwOJBwehPadlWFM6N73Ekx6JXCv/KUgi3bESZbrur8tfntIZWU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB6764.namprd10.prod.outlook.com (2603:10b6:610:144::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Sun, 2 Jun
 2024 10:57:08 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.7633.018; Sun, 2 Jun 2024
 10:57:07 +0000
Message-ID: <d6999fef-aadf-494e-ad58-f27dfd975535@oracle.com>
Date: Sun, 2 Jun 2024 11:57:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] null_blk: fix validation of block size
To: Andreas Hindborg <nmi@metaspace.dk>, Jens Axboe <axboe@kernel.dk>
Cc: Andreas Hindborg <a.hindborg@samsung.com>,
        Keith Busch
 <kbusch@kernel.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240601202351.691952-1-nmi@metaspace.dk>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240601202351.691952-1-nmi@metaspace.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0307.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::6) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB6764:EE_
X-MS-Office365-Filtering-Correlation-Id: 492a782d-17d5-4a7a-4316-08dc82f2bec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?L0EzelFtL3JIdm9PQjZOWUphMWd0MGF5aG1OZ3R4Qk4vVnFmby9sYzh6aEZR?=
 =?utf-8?B?RDdoSDREVW5yWlNhUVl3b2ZaMzlTQm1kSDJUWXZWaDdtT2tGWmtwVG9xQkNB?=
 =?utf-8?B?WHpLTWgrVFlLSE04VkNaa2dldkNJcklYY0VKaVIyVmhaQjA2cy9Td3BNSmZh?=
 =?utf-8?B?OHFvdFZ4NzNDOGxtSjRxc1puZ3JrOTVPZXdnNmZQOVRlWVkvS0FyekZGRTFh?=
 =?utf-8?B?KzBkTGpMRytCQzMzakVUOEgxVU94b0NWZlVRMUlaeGQ5clNKb1RLS1E0TVdk?=
 =?utf-8?B?UlBGUG50bmhHcnVpZlRXcFArVnNwUlJ4RWljTS85dUJHZ3VNUExtZlBQSGQr?=
 =?utf-8?B?UEZmZnJWb2RtRkdXT0dodGprV3RrTWZOMzVkS3NXZFh4ZUQrdldXZW92Rkh4?=
 =?utf-8?B?cExscTJVblhSRDE0UGhVRTI4YUZZR2RuemhOYlJ6WmY1Q0VIRFpob2hIK0ly?=
 =?utf-8?B?b3RKb2JOd2pyK3d2bG1iSk4wYlFDTDUvTllPa2dGS1hqWk9Xb1pRYkJJTHpH?=
 =?utf-8?B?dVVERWhDUFByOHZFeUhVQXFTR2hnYnV4Lyt6OWJLMFRMUHZ4TUM1VmxmeHA5?=
 =?utf-8?B?YXdLUVg5WkhIYlU1SWl0aitJc0dXVVo5NTVieXMxOElFYVhVaDlGN2IrMStz?=
 =?utf-8?B?bnYvUFRmRUZ3UjJLdkp6NGZUWks4UmExQ0EzYk1NUnEyYmVxMzhSaEgxOWxK?=
 =?utf-8?B?ZUJkRUFGQ0grbHBGUmFxUlhjKzNVRHhHQ2dGbEQ4blZJUDFPeFNZVWJsSGcz?=
 =?utf-8?B?TGU2RXFDcWdteitwUGRsOEFDN05oZE1ndTlPOGx5SW83cGhCRTdHNXlla1Zv?=
 =?utf-8?B?SzhScG9kUVBia0xDa1o1NGNubmltV1Y5d216SEhRVkJtOGs2UU4vZUhQUG42?=
 =?utf-8?B?bisvY0Q2Sll6OFRTbFE3dXoweW5aclJBL2xIVnU0RXBJOU9kOHJNVzRtU0tF?=
 =?utf-8?B?RU9pU2hzU0hvZ3N0SnZVbW9GTlB6UXR6M1hwclZsYzhZcXppQzVOZU9IdEJV?=
 =?utf-8?B?enRhWU1LMkM4Q0ZJUHJONG5QcFZwZDBNZ3E0c1RmMndJbS9wTndYRm5YWnlR?=
 =?utf-8?B?NXovVHFpUkhYY3VpYXMrMkNkWDFjYmRCdnpYOGtCYTlIbXo5RVArRUVsdDFo?=
 =?utf-8?B?bnhodGhqVFN4b1RYQWcwZHJ2MG5uWHc5ZWlMSXNLQjJsWC9mOE9XY1BhVElH?=
 =?utf-8?B?U1Foa0hGei9zZ1pVZitzbi9RUWN6QVg1ODU1bVJSTUlxcnFsUy9KRkhveXBl?=
 =?utf-8?B?cTF0UUhFME9rSW84VUpZQW1PdFlJY3M0Rm5mbGRFN3h4S01nVWtTNE9Tb0Fy?=
 =?utf-8?B?UUlOZTIyNENRTXBxOGNibDFXK1dHcmczaXJObWhJNUFTYytSMmtxdlFTWjd6?=
 =?utf-8?B?S1FQNjNUZHh0a0JPQU5CRjJjR2VQMU4wbDduYVdsV09zekY0S3pDdkZXeTFV?=
 =?utf-8?B?cm1CTndUd0Q4eHJOUkorcndTR0RFUGg1aTJEZmZTL3ZxN21Ccno2TVJKNjdn?=
 =?utf-8?B?SXdQTWZYT1h6NnRqcFRXZjA5cGEwS1Z4K2tQcXlVWHhlbnJxWFhsczI5RGhS?=
 =?utf-8?B?YVM1b09nZXI4ZkwxdXpyQTRFRUd3UTVYYlZ0dWhSdEROSFErS1RVeVhMek1S?=
 =?utf-8?Q?2TFbgcOr0bA2/52CD82/TxCtmR1qsIXUzYO929HNMw5w=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R0VJVG5RSndkWFErS0FqeEdBMGFmcmowbnpRM3JJUG0rU3J0c2xGK2VURk1o?=
 =?utf-8?B?MStEWCtFTklDK29hcUV5Q0hXRE42WUkvUitFSUtCdFJJVk1wTFVoQnp5MUtX?=
 =?utf-8?B?aDFlM290Wm9WUGROK09oZHU5ajhKaElleTVqdktsYTQ3V25QOUNKWFc5OGxZ?=
 =?utf-8?B?WitibDJQWjdId3V2THRRaXl3RDBmOWtudWt3dU1XNWk2TWt6OTZ5dmM0SFV2?=
 =?utf-8?B?bWVJbHlEWVJZNWdxbi94eUNTVDFpUUkxeEZHTWRTZlFxOFdJOS9kK0xkR3ZX?=
 =?utf-8?B?U3RyWkwxSHBSb0Q5ZytoSldUMzFaNTN6QXAxRWhVSE5jd2VjY2xEdGZRMk44?=
 =?utf-8?B?djJndGNaTGxBOHJRbmxuY3NpaHJlaEZpL1NGREVJVDlGUkNhTnNxUWRrN0pU?=
 =?utf-8?B?NVUya3YwNVcxd1QxQTdxbmw5Y1BZVWo3YnhVR09NZENjbkZEcXRHRWQ5R0Ju?=
 =?utf-8?B?RGVsSmlWYWh1R01vbitQYmJsNmJzdmtkbHNDalFJLzVneHhBaGMyY3QvS2NX?=
 =?utf-8?B?aUNWOWRjK1pZQ0lGWlovYnVqWG5YdStRVDVKdkkvZ21ENU9RaGFmOXo0MFNZ?=
 =?utf-8?B?SVozL2pEY3BTZzJ4S1c5dks1RlVpMjZpS3NHN2JWZW45dlB2ODNvQWpCTWFR?=
 =?utf-8?B?amJsQVlkWXArTENXeWxwa3FGcG5zQjUxcVV1bXUvdldJVTVFRFQvT3lRYkxq?=
 =?utf-8?B?bWJSTzluOVpUZVNNZnNnZHRuc2lYY0NsYWpBOVlxbnVrcEVmRk91RGtQbzRz?=
 =?utf-8?B?c2hvVFBhM3BDeUsrWUxuNXVvcUlNUjZuZ3g5OS9PVkpPWWQ5ZklWNU9ETWlN?=
 =?utf-8?B?aUJ0bUFENmZTdmdpMlV2NmNDQ0dPdTBYbVBPRExwaVBSMEZYRjVoOVdjeHpB?=
 =?utf-8?B?MytEYUI2LzRiaTN2ZE9mUWE1UHVtWFA0bFZpMk9LNCtSdlkzQmtITEV1YzlH?=
 =?utf-8?B?MHozT3FJa1RFVmxhZ1BqQW94MzU4bHQwUW14M01JTEtwM1VOMURBV3lkQW1i?=
 =?utf-8?B?c0wzckVJSy9Mdy9tZGx0Rm9zRUJ5SWhNdVZsRXdQWjJUZUZ5VlVrQTkydzFx?=
 =?utf-8?B?Q1Rxc0MzRHB2STFVMTliS3hPWnh1MDFraTczYmxFczZLWDVnOTJ5ZDJySDNK?=
 =?utf-8?B?RjBRZHovRG1rc3A3RkE3VkxRVnBCRmJzaTdCdWtzOG5oWjBnUklkVThwclh6?=
 =?utf-8?B?ZHIzazNxNFQyTTdKRWxOMkhCaUNjL2hXMDlYQWJPTGhWWm41OHovbGQ4MDla?=
 =?utf-8?B?MGVrdDQzWUtSRlA4TkV2VHdRME1UVEtUYi9PYytWbWQ2VDBiNndJUi8ySFl1?=
 =?utf-8?B?d3VHVmtlMXJhVGlpbXpXckF4cDZiSkdyOXlOSnVlOThmOWtSTU5LSVNkVlls?=
 =?utf-8?B?OVdPUWlNN0x2a0FjdmpNSDdzQkpBRmxJZm0xTEMvb2dzMGIrbnAySUdQRXB1?=
 =?utf-8?B?bkFPYzQrTFIxcEQyQ0hpM0RYNU9kaDcxa1JSWE40RHd0d3N0ZGdzZ3pDZmU2?=
 =?utf-8?B?V3BNclFBRW0ybTMrY3VGaGIvMTBwczBUSmkrS2NkVmhsVkJNaUE4aVVGVlA0?=
 =?utf-8?B?WlVlSk5HK2h0NnBTVzVRQlVGZmVCSXVmSTFva0RzQnBWTjlEbEc3RkZlWTIr?=
 =?utf-8?B?YXZYdTRFSTQ1RTRybmFCMWZ4b3pYV3EyR3QrdEp6NWJEQlNzYzZSQXVWYmVP?=
 =?utf-8?B?OFlCYXB5bnpzZmhKRXl3MnZQbWRVUlN5dmkySENFS2hjMHp0SFBrZ2hhbThp?=
 =?utf-8?B?RnVJcVhDc0c5TTNmcE9DL1dEM3NJWkF2QnQ4Q2tseVZsR0lqb2hjTEZBTzlt?=
 =?utf-8?B?NDBtVkFaOEl3aU5xNXRiUW1oYnJYQjY3cU5lV0tnWE5iYlcrMHpGUUtNK2ht?=
 =?utf-8?B?N0wyd2MrRHVRSjJRclFSTWFTRDJubm9tZDl4c0VPQnZqUE5takFZU2F0L0J1?=
 =?utf-8?B?TVg3SGRSVnhmTUx1cUtzekRrcnJ2ODI4WVl1TDl4eHFYb2pleXk1eU9DU0JG?=
 =?utf-8?B?K2FWSDFUbkE0ZEhXTUhZWlZ4R3ZwVm5mMTNNbGNKeW9CdTRwVXZNbHIrTFlM?=
 =?utf-8?B?bUZsckFIK09ONW44VHBTNW5RMm1RbDRUTENqR2FTZk5QOGxMYmdobWtSVHBk?=
 =?utf-8?Q?PQ0TMSVUEnjBfmZaUE7Fj3X2E?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	wuAk8jktp4cxgZ4+L27gNOQ0EVBI2hMnzYrKWMDOwRSFC8MnY7aYsWvCAQd4GjiS1U7MQZr97LBNZLOuUCSLPOQAseuGiiotLMa4oN/iqqQMR6T+ZNLcmCNdrMddznithVlUYBmlglgcQGgxepqbHFiBo9zudF8DfLuZ/wQm41VlTyVPrMqN63rnVTpGVPJyxoaooKsf5swAz4bqW7CAaTVMZO7HserpmYljotVF/S1brhGKfDJa+Nd+EpsBuCDh6I7aYwvVTDVZPImhU1+SRioDM+unP7/Luv+x86EJGP+0rkRu+mghM9uop83b85PHb3mRR1fN7PR6tX6Qc7SHo2ntUdxJhAyIM/UW3LUhrSDrJ8nk/3GyrRH3Ty9jJTDZVpLCNDCCv9hMCVXmwwMjg3tNsKCKcEpeA1Tqxj91S8kGIZB86GvJyA1BbKYV08/0MP1kbDGujPS9xHa0zWJtKfm9gU8yXaqAu9K9vUWxH3UkGa8RwoVrzt6aqegafLwlbQ2GkAglZONQDCI3kuG7TvXg33pQQfXEpiwNW8+qSx/teFQzwI74A5pqG/k7PSJCXXOzjKxhUhq+jdmGuje+iI5RIBJ7Os0H5xGiBrfvArQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 492a782d-17d5-4a7a-4316-08dc82f2bec0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2024 10:57:07.6667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ++etkopnzvSNC5UgiTbL/vXKAlBJMdmNPXXahrfZEEJqYWGrMpWR2kRWQPaXJrqzaXMPcpc+Gv55vWBF9PmvzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6764
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-01_19,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406020093
X-Proofpoint-GUID: oK3mfMDXs-Lu2WoJaQmPkh5O03DxLJda
X-Proofpoint-ORIG-GUID: oK3mfMDXs-Lu2WoJaQmPkh5O03DxLJda

On 01/06/2024 21:23, Andreas Hindborg wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>
> 
> Block size should be between 512


>and 4096

Or PAGE_SIZE?

  and be a power of 2. The current
> check does not validate this, so update the check.
> 
> Without this patch, null_blk would Oops due to a null pointer deref when
> loaded with bs=1536 [1].
> 
> Link: https://urldefense.com/v3/__https://lore.kernel.org/all/87wmn8mocd.fsf@metaspace.dk/__;!!ACWV5N9M2RV99hQ!OWXI3DGxeIAWvKfM5oVSiA5fTWmiRvUctIdVrcBcKnO_HF-vgkarVfd27jkvQ1-JjNgX5IFIvBWcsUttvg$
> 
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> ---
>   drivers/block/null_blk/main.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
> index eb023d267369..6a26888c52bb 100644
> --- a/drivers/block/null_blk/main.c
> +++ b/drivers/block/null_blk/main.c
> @@ -1823,8 +1823,10 @@ static int null_validate_conf(struct nullb_device *dev)
>   		dev->queue_mode = NULL_Q_MQ;
>   	}
>   
> -	dev->blocksize = round_down(dev->blocksize, 512);
> -	dev->blocksize = clamp_t(unsigned int, dev->blocksize, 512, 4096);
> +	if ((dev->blocksize < 512 || dev->blocksize > 4096) ||
> +	    ((dev->blocksize & (dev->blocksize - 1)) != 0)) {
> +		return -EINVAL;
> +	}

Looks like blk_validate_block_size(), modulo PAGE_SIZE check

>   
>   	if (dev->use_per_node_hctx) {
>   		if (dev->submit_queues != nr_online_nodes)
> 
> base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0

