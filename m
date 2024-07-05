Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E0413A88B;
	Fri,  5 Jul 2024 16:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720195619; cv=fail; b=EfWpXUpAYuN/vwfmQvZoLWvM1dge2i/J7yyB7w7NcZzk3js5BK78cvV8NzZU/GOG6R0YWhSKUuovY25WKfFcTyU1TOSVe3TVGg39qFENRBhsKSmi0duw9gBvPOOTCjsaugjoybkGosj2lLFZNmzbAr6n9yGF7O4I7cviLl6x7fE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720195619; c=relaxed/simple;
	bh=K4KExWRtlfo9sREMkP5s/LN/Lir9919QFhBJ1LeVfTk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Bsdn+GgB0s8qxHj2cX/W3iKWtmu6OPhThA7InjKxn/DNoUxRvW2XYWz1kxup3BrJ9dPnyTetY77HDwkQszxEdCgryJgZBX41fzKHHruY31R6ueioWs2W7FzL01cT8NGvkRWDDZw8kIOQmEeDlZbQd9POS8V63/sPYAmbn4DXbC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fwU1U70d; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0QMaXETJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fwU1U70d";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0QMaXETJ"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 465FBVDU007925;
	Fri, 5 Jul 2024 16:06:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=4R4uH3hTAykTo8RQTfV3WLTPm5MRZMdxN6EQA7OLl7U=; b=
	fwU1U70dpiCcz2XAg5K0GwxS4gpz28wv1rLqiHCxoV/gIydPFMinRhoox13mrnjo
	LIBNDGI9FUcBYwzDgTVt7x1RkFCMlmgqTpl09FFX5Ep57BCAnwy76FA8GKJrtTlt
	D2ufnIMMcS950p3m1fmd8Rm51d4oOJ889olm7Q4UMUwxMN5e9Ku1Gk1Rx/vIqWFK
	3P/ljRswPqPxySDSXQrVmxXAb8jO6dD+lVQBFEd8dbesNvCrHgPHkFH+AyDB1jma
	0LTlUcL1Rqe8gBjOLL3Bu9IekHEv/NMNhPZa0I4Myj/SMUmjyidDS5joNdGzK/aE
	jc9AVLJ+qJ5YYZ5gZnGZtw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402aacmagv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 16:06:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 465ELVBR035759;
	Fri, 5 Jul 2024 16:06:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qb9258-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Jul 2024 16:06:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m0Wjt87IUZTQiC48v0dYoMO4kZrU/I5cwKAcINU6UGy0WOSEZzxv6Tjra0KBHLA46RpwiDumywh7i/+zgJ2QyhSLqx2wiGJhtFJINIBhy8QNafolHmOtun9duk4AfkUdL2QHi7RuIf2T2Wx4cV9ftDTFjHUjukwHqPWZX+GgLJ0eQ5nO/sAnJ0WCwJ98ab+kGgKnWCtSxAZncVyodyfPIQOJwSh6uY/BAoNLs2kmz7byulRzXXYk02v+/nFHOHHw1PK9tzniQ1C04I4ru2PCjIhTAzVl1ZdJw34IG2S5iocUgYXdGBcdNseeRYrIUCmwDM8alA4ObceWgxa67uoGYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4R4uH3hTAykTo8RQTfV3WLTPm5MRZMdxN6EQA7OLl7U=;
 b=PtHtKdYIR1hWyvkuXVvztMAdCB8xGJwJQlJWEljjDWRM/a9CCqwXscn4h+VFBxtMX+LuArWHEe/Y3dfcVuNjwMqlhEX4eWmx5WvNw4aY2j7HBb1FA4Fn7KarbAThDS7o7V0rm7Rx7TsP5kCXu7HdFLBE9RLIwuMjdDGEqY99rWIYP0tGMGF1cV3E/omlY8bYJbRYD0nr+E0YyowG5aftrL/+GaZTOB8AyMBC4R/wOmflZctN6jNdSraiujOfSRDSvybvVdMLa5RkS3VP1UV6svT+AAqYlkvcC16vRN+xsQ7WZjq7LJtdAwyCyag2Oh2/YcqmIwhIglmY9WbKKP4yeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4R4uH3hTAykTo8RQTfV3WLTPm5MRZMdxN6EQA7OLl7U=;
 b=0QMaXETJwCEC65s0F20MZIjjAdHXAZFZBur37eoteBTQIxlX4EGIFlVjf5aNpmTp5CLgVENQfBv585aF/mh7Dlw8p1tI2zPh2+e21BFMOX79Ye9VQ8B+D8uKnK82xE/c2HGG7fte8fNzwzP0ef47tcMiYWVPG1WK6MjgG4t8ZS0=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CYXPR10MB7974.namprd10.prod.outlook.com (2603:10b6:930:da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.31; Fri, 5 Jul
 2024 16:06:34 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.025; Fri, 5 Jul 2024
 16:06:34 +0000
Message-ID: <e7cb798f-6a3e-4406-9aae-e9c4b54135fa@oracle.com>
Date: Fri, 5 Jul 2024 17:06:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Validate logical block size in blk_validate_limits()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: axboe@kernel.dk, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
        eperezma@redhat.com, pbonzini@redhat.com, stefanha@redhat.com,
        hare@suse.de, kbusch@kernel.org, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev
References: <20240705115127.3417539-1-john.g.garry@oracle.com>
 <20240705112922-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240705112922-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P192CA0028.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::33) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CYXPR10MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: e225d205-0cc1-4c72-67ea-08dc9d0c7141
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?VVNOUkRIQlFzTkhYSW1VY3p2L0F5NCtoc0VFZC9ET3FyUC8rZloxaDlLbGVM?=
 =?utf-8?B?RUZjb0RvL3J1eEkxM1Q4V213N2dwK0VVV3pXaHhLYitqcnUrTUd4SVY0R09x?=
 =?utf-8?B?cG1VSDBGVlR3NkRLUjN1NWt0cW51ZzFXWWJpQjhLekRwc2k1eDAybURhakd2?=
 =?utf-8?B?SWpGMXZsOUdYVHNHQXZINHhyMG5ON1h4SHZkY01xeTBEU0tWaWxoMlF0d3Bl?=
 =?utf-8?B?YitVUitIays5V3dHUi9hYWtjV2R3V29HMTFVaDJsbnlwdGYraUVoMzczUmx4?=
 =?utf-8?B?Q2xObWpiaFovVmt1ay9hSTE0QXczMmx5d3NZQUtxTnJjckx0UkdVazVJTGRy?=
 =?utf-8?B?anRSZXYvZEFrTWdJOGV3UEI1NVY0WEZpZmorQ3Vla2tMWU9XRWNEc0VQTnZU?=
 =?utf-8?B?bnV3RUY5SlFTY3dQamoycFdaVXFPeSs4TmFkL0RSWmtZU2tIREYyK0ozUmhS?=
 =?utf-8?B?MXJCRitMU1NtTmJwZEM3Z3JmejBFb3dJYkFqdndLQlhRVDhvSWxEcTNwVTZY?=
 =?utf-8?B?UXdNMkpzRldVSU9BQklENytxWTF5d0k4b25rQ0hhNjZGS3dBeERlTHNNNXdJ?=
 =?utf-8?B?L3kwemFwVktYMmNjdmFRUm5nRVRTaSttREFYWDY3MGZNN21pejI0bTF2S24r?=
 =?utf-8?B?Q2drYWJpYXNzZHJ4c1pxNnlOV1l1QVBUL0V0Znk5VHpQUEJieERSRXdsdGYw?=
 =?utf-8?B?ZFdzai9ibmZwSmZoYk53a2R3eWxVeUZoTmN0OXZSVE9MME9yR0lRVDhYRCtn?=
 =?utf-8?B?dStUbi9pV3ZrVkJ1eGNGcFlSVnRaUHRzdFljSmd2b1VlNU83RlY4ZnpUVzlo?=
 =?utf-8?B?MzBIRDlOb0QzUnlzc24xU1B5UVcwZWlHVnhFNTR5THN2RXRmNU9qT1BGTGlY?=
 =?utf-8?B?OGxsUHdTV0lLQzdHWGM2QkF6bk13ZGIyMXhNUVRrMFQ0VDIwd1dqbGEzV1hr?=
 =?utf-8?B?VlJzVUgyR0sxVmU4OUVNSGlFeWpEZFVHbWJTVUl1aDdWMGZhalIzb3hsOXFk?=
 =?utf-8?B?ZFhhSmRtZytZMm1ic2h4bm16d2tNZk5udFpyL3p3VVBCK05oYzZXa2FpVjlx?=
 =?utf-8?B?ZDRlNlRFUXZOYndHR1dKNnlwZEN1U2tHVmJNZkNBeDdtVkY2QXUwSXBUaUpi?=
 =?utf-8?B?bmhNOWJZdWE4ODJuUVFxZzVYSjMvVGRieXhtdVRzZlZXbUhrZjd5VGhiMHg2?=
 =?utf-8?B?c0loako0RWNkVFZ2SmovQ0YrOGZ3aC9meEoybGEvVUhmcTlrTDFPb0dMS0ly?=
 =?utf-8?B?TytsYnV1cklDbDRQaXRpQURJUEZBbmxrZ2luemw4elVsUnpEbDE5ZTNiU011?=
 =?utf-8?B?elZ6OGFReGkxQmhsNWorMnFmcDJ3aElXaEJJeDlBV0dlbSt3K09zSGNQOUVm?=
 =?utf-8?B?OUowTGRSbzJteVpVZXdWNXBGYmI3cWE1K2xqT2V3TDZyNGRkRkQ5SlNyOENT?=
 =?utf-8?B?cHZuNTlTQ1F4U2xReWJkdWV6ZCsxSk9DTkxCVUVUa2pqMitRZ0lZaFNPaHJT?=
 =?utf-8?B?alFaN0xIR0lpTXVCbnhyRGtvYVJCRHF5M1ZrcGh5eUxpcThUaUF1WGo5MjZJ?=
 =?utf-8?B?eHBjaXVkQlU2bnVESkRsbGh3TnVEV3FLTDl4cHJvZ3o0ZHpJV1F4elpVRDVQ?=
 =?utf-8?B?NERlc3czNmxOeXJsS1IvcFF4RlVTZWF5czdMeHNUUVpCanhCaVhwbU5Gak5L?=
 =?utf-8?B?aFcyY0NlSzhhUDEzNjROeDUzWGVPZmZ6SEdyVzlKRkVqN1RUMWYwNU1wSnFJ?=
 =?utf-8?Q?hTKL54p+QMnn2hdMvg=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?aTJOOXQrai8rRGNyeWw1cUN4SGZzQXZEeGtScU5MWHV0blQ1Si9lSzkzdnNQ?=
 =?utf-8?B?N2VQcjhzUVVscXRjdlRwOE53RG1jNm5pUVV1T3NxL1JvbXhOUWdIa2wrem5C?=
 =?utf-8?B?OXdCRWZkclJsQ3djWk9JZXo5cDhRUVZpY1FHL2FqVmlxUW1tSHB1d0lDcjRY?=
 =?utf-8?B?LzQ3RTh6SndJVmM0RUJreVlIREtLcDVIa0ZLY1RSUGVBUW9FYXlCNlZVY3Fy?=
 =?utf-8?B?bWt2dEg1eHJFSm5pY0gvbXY4SWxTUXVyazJoUmduNkk4dW9GTHhjYVFXSjhT?=
 =?utf-8?B?enhyR2ZDZU9mam91V0drMDEvT3MxeUMxNTR0RTdVanBOeHJoTFp5aFBMSHNC?=
 =?utf-8?B?NForR2NBQis1Y1J5SERTOFludlU0WU4zK0xZdkRiWUtKZXBDSFRIbEhGY0tv?=
 =?utf-8?B?WmI5anhkSVJGUGg5emtyUGVhclgzbm43RkRHWklCY0dDejdpbEJ6eSt4cXd5?=
 =?utf-8?B?N0xBZ1NUMTFsb05ZNlhVSjQ3RWQ5ZzhPTnVKZUIvVnlZdXV1VFBnWFhCVVQr?=
 =?utf-8?B?MFRib3BXM1VrTEtaTVpyNDVHTEtHaGtYYzFvVjNDZEFaZ2QrZy9wUzVUT29s?=
 =?utf-8?B?TmpkYTZrUWZ2UUUwVmc4RXRtcWg1UFBvNklYTW42dm81NzVFZ01EQ000dFNY?=
 =?utf-8?B?YUFmQnY5Z2FhUlN5Yk96L2czZFkrdTF1ZjNtWnErM0lIWkx2M1hEdktZY1d6?=
 =?utf-8?B?aXJnL0VBOEhXOEMzZmRWNG03OXByYkZ5NzJud1VjTWxSZ3N1U25zdGN3YU9L?=
 =?utf-8?B?VmdtZENuQ25kdWhHb2lUM1NSVU1Yc3RNNGphK1ZBbjVsUGVFWHIyV09UdVlJ?=
 =?utf-8?B?S1lNRmpCcE5RaWxPQW1LeHRONUJ6c0t6amt2WDUwSWV4MFpNN2hMWEtuWVhN?=
 =?utf-8?B?N2h6R0JqeUZsWmxZTSsvZ2RjUEQrZVZxSEx1TVRFT2RLZUdlR2taQzVXUGlB?=
 =?utf-8?B?ek1YTHZVY1JZTG1MTEdTYitldHdhVUhsVElSUjZDdXNCdU5XQnQyam42QXVL?=
 =?utf-8?B?UEE1ZzFpR004eTBtck1jMHBjYkhJWnNPOVFjOGlJUExTZDUvc1NMMGFER3dv?=
 =?utf-8?B?SStGU3B3cDlMaGZZbVVjUE9wTFg5ZWxvZElPYjRTTVQvT1l6SDdpYXNtLzV5?=
 =?utf-8?B?RzVzUGZtOFVOTSs2NFRQSEZUa1F1OUJVM2ZVa3AyNXk5b0RSbi8xUENTOXdL?=
 =?utf-8?B?TlJ6cE1wbHJJSHRQRHNQNE80UzVtT2JaVW02UXhYRzJHQ2VUSnliOERCL1Yv?=
 =?utf-8?B?Y3VkeGZaTldTRHcyUFY2V3J4Y1hGRnNiSHpsV0lyeWtjc3dTWmhyQ0ExZzhp?=
 =?utf-8?B?WlBWRWVoTVo1dW82czVLRDlxVm9XRXN5YWVib3hXb3VJdG5YdWtCd09zRjRU?=
 =?utf-8?B?aERWQnpPMXlqdU54L1ZWenZFN1lqSTR2eTR1N0s4NzZjck5uckdzWitvbHdZ?=
 =?utf-8?B?RzQ1OHVjamVueUlNTWthbnhNSjlKMVZZUmFBR3A2NzNYc242YU5XMi9rZUJG?=
 =?utf-8?B?WksxOVhlKzRSdVMrNUd0RWRUejhRT0Q3RWxKMUpyNVVZNFN1a0pqME10T2tk?=
 =?utf-8?B?d1MwMy9NL3UxR2pRTDBYVkdVMHRIc1pkRHMxaC8wRXdPak9SUVZpVHlLUGJZ?=
 =?utf-8?B?ZkY4eENNcFBWREprdEdQcmJzWGN1T0RYTW1vR2xNL3QrZVBGRmNaYlVNallR?=
 =?utf-8?B?Z2MxZVY3V0l6NEQ2V3Bwb0FjRXBwcTRoNkpQWk5NemRuOFZvWTdMYmphY3R3?=
 =?utf-8?B?NnFWZm11NHVCR3JoMUlFYjRzU3JFMVJlcFUzeUVmbHpIeXEwNWNMdHFNN1dy?=
 =?utf-8?B?Zk8yS29QcngzRnptTlBKVjVZQWI0OGhYTlBUV0llK3YzaTJzUDk2TThrNEc1?=
 =?utf-8?B?dXB5OC8yV0kwMmVMWm15WEttSy9xSGEwS2tiblkxa20raWNpa0FVcEVmREUz?=
 =?utf-8?B?UERRSXFnM1hmcFFDaERuaG9VdDNreEJ0Y2x5VER0VjhnblhDM0ptdi9zRFBn?=
 =?utf-8?B?OXNSM3dnUnRLeVZDUXl2aWdyVnBTOVZnWXhWbHNReTZ0cHVicEdqUUd4TUZO?=
 =?utf-8?B?UGYvdVpoemNTeFkvL3FhVTZ0dVVaRWN1YmFVWVJ0NFpidnBrYThXNldMTVBL?=
 =?utf-8?B?STVweFZ4NlpiMkY3akJGcHBwMW15bTE5MFUvQUtFVGEyYTFkNCtpVVdUNjBn?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	N9+MAu6wsAe4xOWnF6zI/3kszz//NcDZV/jNKj0vhGoYMIGfpHEttk5nti5KTfGKnWPZmhAFudvPZbHDr7URRVUtM5hpyXNNgTwPT0fcnVnN5PzU5BGYtdT9soK/ECc5YQXWs0hhfJ0nadx9GQe1NWTDASua/WZs/twEJyOXc/A7dFiEEnPOEVkrbM62r1vMh3iYF0vzWfEvd4SI4K8+4SDVIAFxUvfaMcjfw+ZwXmuItkKAPbeiGKShehrqgwEbozn+4iEQfWj9mDzgJjSWj4Z7Q+SH4fAfduH7lyq0Q0c0DnFTUU5jHU7LODnlEbp0cFyEHBXvcVH0WxJbAOXGWJvUJV1wwzDz4RuPeXyJ0ZKa/AOQZapLzsHFpUDvkT+tW4I2X1PJF3t4qKGqHbcM82/xJ7sSXC9U0SlvcuAuSIbmYeECnoiWm+U8D5kPbPae9ZgKDMV+hrqsCG4pHBT1VtKv1XrbmnX452fbjMZsPFyKbm+Ht/K/PzZiZc5o85icejlmDX5uENlEaisxzZ4j8IXHny4vumct/VSdy8BTZxdHjQj4DJi8vegNFWEO/vgr1fq7g7YGbO2ZNWG7vSpTyX9lgL9g0S/AZFUHCQyYvrg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e225d205-0cc1-4c72-67ea-08dc9d0c7141
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 16:06:34.7165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4Ux0Qhdy1A47kZDKg+QZvvFURQ4T4szGbNRuTowElm3mFLTMTG/NdwrWMsB4smJsGUDoUAO1nQPjvYYR+Rw1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7974
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-05_11,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407050116
X-Proofpoint-GUID: FBmK-OCwkwlm-Frsx1ZkdGK8RH4USdsj
X-Proofpoint-ORIG-GUID: FBmK-OCwkwlm-Frsx1ZkdGK8RH4USdsj

On 05/07/2024 16:29, Michael S. Tsirkin wrote:
>> [0]https://urldefense.com/v3/__https://lore.kernel.org/linux-block/10b3e3fe-6ad5-4e0e-b822-f51656c976ee@oracle.com/__;!!ACWV5N9M2RV99hQ!LzUcadOhRalf0I9KR0o_PEx2_Igd2az2Mpv6IdBkLGXLb4E5G9NHZFpm89oJbvJuJbdRQ4W2E2Y6Hg$  
>> [1]https://urldefense.com/v3/__https://lore.kernel.org/linux-block/Zl4dxaQgPbw19Irk@kbusch-mbp.dhcp.thefacebook.com/__;!!ACWV5N9M2RV99hQ!LzUcadOhRalf0I9KR0o_PEx2_Igd2az2Mpv6IdBkLGXLb4E5G9NHZFpm89oJbvJuJbdRQ4Wqz9meMA$  
> virtio bits:
> 
> Acked-by: Michael S. Tsirkin<mst@redhat.com>
> 
> I assume this everything will go in gother with block patches?

That would make sense. I hope that Jens is happy to pick them up. I'll 
send a v2 soon, addressing comments from Christoph.
