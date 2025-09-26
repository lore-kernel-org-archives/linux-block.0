Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7A818FC86
	for <linux-block@vger.kernel.org>; Fri, 26 Sep 2025 07:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758872154; cv=fail; b=jzw1guC3YNQYHo7zbGu91i6KuAKoVrjhguFB6X2tNHpGl+ZfPlOAlQQtoMm2JI67lEIMFfaLd7jekFye3yW1cVKUmaKedBGIKQ+s8uVejXb9/kS1FOSdojQidipRGiVRNxad72ujD7HJCDMmlQ4YmLs1VX3c64L2bmP0GRwHGH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758872154; c=relaxed/simple;
	bh=KmFonpNwo85kijB9lSB9dWg6mvTtbor3529/NDQ3uZY=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XteUrdevnJhrxO8ovyAsEc7vSBLwbcE1ImrdJqYAlrGBOGkWO/ELCBLLkvSdaPS/34h4b+4hF7mSIu+ELjqx94BL7aSk8EHGnFPP3SGM45y7sTI/JPWp7JaGIxiTKpC4FAN07ELGuyBSZlczmAf3AUo9e5pHww9pGlmkF3qIw1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=beKsW7K/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V/fzbfhK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="beKsW7K/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V/fzbfhK"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q7A2Qf028208;
	Fri, 26 Sep 2025 07:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5hVOd4WydQOWKHXWWQP/8uNiJwYWTGBqUL802MW9LEg=; b=
	beKsW7K/lyziaAt9irlwDrqkpUhSM9u0Mit0TBorCsHmXegA5U7nFQpKDsAI3QhU
	POdr/OE42Mu2cMAQb+jwbXWki5WLn/wutVb43Qvkoa2Zi2RldMmYkydWHbyEgRSc
	wHIj4zCsGfJDRsEgCsdSJALRL8zN3bPiPxagf51m+5PHp9fkRGYTewdQzYYPJPuY
	9ScZ9a5kLEJrYsvE7ijbY146ymbkIGqa8dMTbduwMUdqsxOKjw3o8WNqpCdxUzR9
	HnDPK7Pb+0rHdA6aQjoHITa1mUV/9vaCOSM7PbligRD44Q6LjHsxxK6bnaaE1cq6
	qeEX/lFQWDdObmLUEsQxUA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49dp6nr1sj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Sep 2025 07:35:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58Q6VnqL021147;
	Fri, 26 Sep 2025 07:35:50 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011044.outbound.protection.outlook.com [52.101.57.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49dd9cqkdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Sep 2025 07:35:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pSc0ggzCrLd4QLXU3cyuRByVpoyu6aile6TEUfo0wGavoR+hsBLBvgFSMAGCJCsfWo3OtN/EDbc9eSxKXiQEVxB7luxo65SvgHXmS7iDg+Ej0EBRGeUmSl+pyBqrbCExJRiGfiis0yY28Ebs0ylSPU061KSe7tEy8X0kz5EmFMPONwjbnbp4UqFPKK6gsZWKI8kL3M+cPkzo6SyEYIQUfYqXvMUI8VTeU3zMr0tMuol7ccLiNoYiEeqqmbFJ/dep27OcWg3tOqB7SS9UfmlHjXCg/yOcveuWQUSbWXemD0qv3vnA88NkggnrxTNW0hCnqACWUhytrbQVQnwo0s17vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hVOd4WydQOWKHXWWQP/8uNiJwYWTGBqUL802MW9LEg=;
 b=iYNZ3T+M3kVI9YmIEQEj4Yw3w3Rq/P8dyn5v5RSn6yTrwCO8aMy+WZo6fvL5nR1H5B3MZR6q7E+vE2aFF3cf75riPaKGuMgTK1dENCPWoEztWt0obglwZ9RQLJX3gUVYPHepEbmrV9hRquVeEcaKekBXLa5yUrrBmk/ObCMtmDlNyqobqoVbwxX7+xJbF+yXq7v//5udwLZBwl/BsOq8EcMzziSOyNBINycwE/xnjDv59EFEmAZHkS6hzTuX4ObzuqnXD+OKUDCDDYGny8lYdNApZ0EUWhSmprD6lYFN47zhGWs+xWqaBajqgOs8wyO669Vt4FRUel8HS2RpY9Y3PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hVOd4WydQOWKHXWWQP/8uNiJwYWTGBqUL802MW9LEg=;
 b=V/fzbfhKVrH6VR5rRiquEjK9XIAhcjZxwjYw7cM9hwBq2KyvWPpHqMjdCTYhr2ubG9RJXmyIeL2NfgPqpBs/OKOnlovBSn6mZ96w2vYBaqkQrK0vsExURSLoXMe3coZd3Wz8hu8Kjx51WcGv1Mee5bNaEbBrFz71rytPhBGE72g=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by BLAPR10MB5154.namprd10.prod.outlook.com (2603:10b6:208:328::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.13; Fri, 26 Sep
 2025 07:35:48 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9137.012; Fri, 26 Sep 2025
 07:35:48 +0000
Message-ID: <96c2c84a-9985-4434-a995-6f814f103964@oracle.com>
Date: Fri, 26 Sep 2025 08:35:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] md/rc: use --run option instead of "echo y"
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
References: <20250926034033.176349-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250926034033.176349-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::12) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|BLAPR10MB5154:EE_
X-MS-Office365-Filtering-Correlation-Id: be46f5a9-9ad9-470b-b754-08ddfccf4f94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?REdnWmEzN1ZuSVBsUElWdW9IandBNlYzbHdZKzlNNkdaSXpqRWlacjR1Tjg2?=
 =?utf-8?B?VXRLTVhJVVlVOGk3aGhPT3plYzNpU3ZGVUhhL01qOUlZQWw5VGwxTkZoMlRR?=
 =?utf-8?B?RFBJS2YrWDl4cmUzeHdXWWs2eG03aUNTa25qT3dGZkxWNTlnaVByL3VNMEF3?=
 =?utf-8?B?NHB4UkIrZkhwbjFwcCsyYkkzYUh1ZUhZWUdtcFBCRGJsN0grcFprRzJoYXZK?=
 =?utf-8?B?b24zNnViMi90ekp1QlNWWStuSlRYQlpmVU5hM1FHaC8vVGNCRWxWNGluVEpD?=
 =?utf-8?B?d0JPVS8remhqTjlvRmdPV2FSVUI3aWkwQUo3Z3ZocnJFYjlJQW95MFBFT2I4?=
 =?utf-8?B?Y1Q3WFh0SjBIRHM3d1lXOXgvZnRhTGtyaTk0WHYrVTJWNUhlblQ4RkdDVEU2?=
 =?utf-8?B?Q0tSc2QrYXBGdUpXMHl5eGVhVXlpdDh3cUNPN0gxUzV5SllTV3JGYisrdjNR?=
 =?utf-8?B?N1FVYnVZTEh0aU9NWTc5VEFyd3crNnBwRTZDRkVnUTduVFY2emRqdU5XNlM1?=
 =?utf-8?B?ODNQQjcrYTUwSnN0WFExT3dtRURXU1RZMTg3UDhKaml3cEg5WTJmYXFBZE5z?=
 =?utf-8?B?cUExUzNBckJLbyt6ZVhPRmF0RWx2UHlOdk1seFpYWVh5QTFJR2hDdjVOSkRR?=
 =?utf-8?B?MzI1d0pVQVYzRmxSWVBLalZONVVHNVVMWW5QckUxMFE4ZFZKY1hJT1dyRldI?=
 =?utf-8?B?dk11SzIwSmNOZ1d4UjcrMkVNd0NMY1Uvd2FUSGtqaThhODErdTNOZHJKbzI2?=
 =?utf-8?B?OW9yeEF3NjlzdkxkY2x3MFVQeEYzb1ZpS0FTNE54eUVVcktjZTVZS1A5MWdY?=
 =?utf-8?B?WlEzUXBUMnlXUDJva2ViRDA0TktKMXRPQ0hXdlg0cEhvc0Fsc2dMN1hxRFkx?=
 =?utf-8?B?dmFmV29mbURiOUVGUVNPN1lIUEk2Y1cwSk16S0hhV3paUTZVZldqWkxHZjV3?=
 =?utf-8?B?YnJKbWtOSjh2ME5QQ0xvVi9nNnJhZmlUV2t6M2VFT2dxOW9jWkc2dmswU0V1?=
 =?utf-8?B?TGlXVCtGWEQzZk1uN1pMR01oUk5Iam1PZDhFM28xOE1reER4TUlDQlFQUVpn?=
 =?utf-8?B?c000Z3VOYWRhcnBydjgrTWJRdkZ6Y0djVzZtYTA5MDJQMHozNis0c0xjYnBo?=
 =?utf-8?B?UGNBWDhuY0RwdDRHaUVOR2FRZHlTdGwzaHExZmJMR1pEcS9QeW9yYTkrL0l1?=
 =?utf-8?B?RjlYNFRHMm4wL3dRK2IyTzJiMTNOSEtOMW5QYWNLWXNROVlFNlcrWnBPTTBW?=
 =?utf-8?B?R2VQazkveS9tYXE5SEQ0Rm5LSm1BbERmOXVEYXBIaW9nMDV5ejJpRFpMQkE2?=
 =?utf-8?B?Z1p4RWorZG9yelFxT3ExbmUwelZKNEd4Q0w1OVRRNDQ2SWtNRlNRL2ZNZFVK?=
 =?utf-8?B?cG1NYVJEWit2WnFhUGdQTkdUSlF5N0VudzI4L0VxRG1QTXhLYnloNDcwckpn?=
 =?utf-8?B?RDBKQ0tjdU9mclAvUnlITldMVXpiWGNQZmo1K0RJOFZWei9qVlFNTG5WVzNi?=
 =?utf-8?B?RmVyMHFubVZPYkYvdEdCSkhLVFQ0OHVnaWV5QmhRV004djZmUHlvMnlKenJK?=
 =?utf-8?B?MGhVMnNKWUFIYTlGQXQxeFFwb3ZEZ1pwdHlsTnpnWGVUbUpRUGhiRFZ3MWRI?=
 =?utf-8?B?bTlmRS9xMi9kR3BlRTJwbm9BWlc1bWh2M3hSUlhuS0QyYWdETEprTHlKdnJN?=
 =?utf-8?B?MDlCSnphbUZPU09ocitBYXpySm5ZNHZ3bjFSbDJEcTNua2Qrbk1KenZscWlR?=
 =?utf-8?B?SXJMcy9JVitiaE5HdkRhRXlOOWRiVXY3U3lrMmcwUytUSUpudnU5Q2lJMnRq?=
 =?utf-8?B?NkJiOHZEUDMxUFkrRGFrYWpaMTc4NkFsSEdwMUZsSTBhOVBOWVNsRGVheWJm?=
 =?utf-8?B?TWVCeHFpa1lOZ0pYaFdjcDQwUlVoZDI2QmVZSXIvVUVTSVYxcGFIMVlpcjVw?=
 =?utf-8?Q?UDU/hWYN9MG89sm6AsdFKaH6tLtLRSiK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RTFxU3pyRkh5TWF6Z2VkdDNjSXdPdE9WSmZORU94SUtaTHBOUUIzd2J6cldt?=
 =?utf-8?B?K0lkQkV0enJjcWxjKzZDcXBYNDREcUk3L2ltUFQ4MHNkM0sxUjJFZkZodkVM?=
 =?utf-8?B?Y2NkTW8vRXJtZDdKbnlPODVCUFRrdmUrU1ExOXlPRjVLMDQ4eTVWb3RXQnF2?=
 =?utf-8?B?YTUwVjlmSy94U2VkOVE3cjF4dlIxTTE1VWpWMUdzWWNpVHpvTGJHZW5DNWZN?=
 =?utf-8?B?MFF3dFhQQnhMb0pSM3pyZU5WdnRtallha3haWGdPTWMvb0FsU3dVUitZc0FO?=
 =?utf-8?B?a0dsdkdCRjFKTWg0M096TnV6RjBTT1RWOW0yQlkybXFFMXJxb1N3c3ovMmVa?=
 =?utf-8?B?cy9adXZXaVRVcDI2SEZWTkVnN0hBRm9wN3J3dDhxc203blZwOUZqekhENkxn?=
 =?utf-8?B?Yk5YdURWVXJuRDlWZ2xRdWVNSW1LOEtGa3p1Z2ZvbEw5eGk5cFhBVWY0V0k0?=
 =?utf-8?B?MW9yM3hWa01WQkg5azUxSUN0Ky9sVDRFWEhEbk82SElJKzdBUExrekVESUIy?=
 =?utf-8?B?ZktPSlJkNStUZVlVTHpTcHBETldRMFJTdE5aRGNyaFAxbDFPc2VCR3FCZE5s?=
 =?utf-8?B?REpKZlRPUEt4Uk1GQ1AycGxKK2pZTkwvYTN1Zmx4TnNJVXpGcU9xRGRZbmZ2?=
 =?utf-8?B?KzlzR1pRRlpFamJ1VFQ3ekNkcUhORG5XZEtFZUZndlNUbUNZMEIxNDQ2YkNF?=
 =?utf-8?B?UStLbGhGRDdkYWRrWTE1OWhCb1VlaFppamxlZ0VMSnBxcDBPQkhjQ3pRc2x0?=
 =?utf-8?B?NDhWL2RpUEhkRXN5WnhYRUdBanI5RGlsSHJGQ2ZzeW9PWlo1UlhiRnl3WUFi?=
 =?utf-8?B?K05VZkhKVXJwbDk4WXRsMHNNdTZLZUpBcTZEaGtKdHZqdm9wVkxnNlZQdFVT?=
 =?utf-8?B?R2ZaTkM1ZjZ5Z2pSd3ZGTnJHaHpwTkMwdDJNT21rWlZMQVF4MXN6YmpPcXJP?=
 =?utf-8?B?N3VvVkNEdjFpdXlya1dTVWt6S015U1BIN2M4alpxQ2tyVE1Md3dWRmdCM0Y2?=
 =?utf-8?B?WlZzRlNFaHRUZTBlV2Z1N04weG5nT0J0azJIcUNvVlQwYW5wdUR2ZU5mZ2Yy?=
 =?utf-8?B?b3I4dVp3WkYyTUFiNW9OdlgzQWFlOXVQNWF1M011VHloN1J2LzFHSTVYU1oz?=
 =?utf-8?B?QUhEcmc2ZWZRTFk4eTJVSlhYaEhoTDBOOFJWNjdQRDE4bzRCMHdkaWxiSGlC?=
 =?utf-8?B?SFpJZFJRWWU1M1ltNURXNU1uWUVveW9UOXNtQXViQ0pUWnE4NUVZV2dUQ01D?=
 =?utf-8?B?S3lpVWovNkNNczhFOWNzUnJjbmNxR240MzB6bzlaSWx5L29keSttUHBmWkd0?=
 =?utf-8?B?RitCZU5Ua3c3dC91dmFxNk81VEdmOExpOERQRU84UzU5cjdCemFDQ2dHMkg0?=
 =?utf-8?B?UEVONHp1NVA3UWRNbmVvYUVxb1B4RzUyMGw1MmxTUU16YllJTDBqWGV3WUJq?=
 =?utf-8?B?UFM4Z05GQ1BEbHVPMUZOeGlDZS9qb1pLSlMxTUZjT3VrVmhhNHBhL2FkR2la?=
 =?utf-8?B?L3M2Z3VpdjU2MGx5SlBwVFF5UFJ5WXZIZWFRRWhPMkNZaEt4dElCdngrWnpG?=
 =?utf-8?B?WUUwZG5ENFFpb0hZbFhtaDdzTkx4RnBybXlNakEvS1lzbDFVWnBHclFmMHIx?=
 =?utf-8?B?eXVaczB3Zjk1cXRoaHZmTXVkeXVRcFVlNzF6QWZldDhQTlV3aGZSZmtZU2tZ?=
 =?utf-8?B?WEgxbFNTeTR4Z2RPSDhucTFGQnZPZVQybmI2NmI1UEE5cGdIeSs1WExVS2F6?=
 =?utf-8?B?SlgwOGs1MkxRVzk0OFpPVmhFOERIQndnY09hM1ZQT25QTkVLTy91TDNiNm1s?=
 =?utf-8?B?aFdtTWNlak0rdG1yUXRpdytRbU43WXh3RDhkSzY2cHdDdDVDRExKaU80Y1VG?=
 =?utf-8?B?L3gyVElCTVRkSXd5UFBaMDlnemtFQ0xFRFR6VThBam43M0J3L25lRmQ1NjNh?=
 =?utf-8?B?amxPV2tpakxqczduR2lFUURrNlN3OU9CeFBwdFUzVnJ3bVJYb0ZzU3VBRlMz?=
 =?utf-8?B?R2ZCZWZMMGk4MlNTS0VwaHN2S2tYRGFtU2luS0p6YzZENnlYc0kycGNqNjEv?=
 =?utf-8?B?TElUMktwREtIRWxFS2Uwa3RBSyswT2w4cVVDMkJiemRjZ3NTd3RTQm05RzhQ?=
 =?utf-8?B?cm9Bc25XVGlqRkxVOEJIRkpLMzZzZmdsejFDWVVWZ0dJU1dyaVB4eWhHcSt1?=
 =?utf-8?B?cGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iVItBxHiOejgiPEJlcrqLtKwHtt847tG7q4gxsZShpv9zAFJ/S4TC/Lmne8UlejOPKUhTlDjUKAIyR6bVzs2P3CFuyRjUmnyrRqar+9zKpWiryeJtx15hzpiGYV6XXVWdT0+NKCcXPMl3SIWoDFDekx4g8zn2muFyZi/75WLJk3lZ+z4UK4B4mnLZ1he7jX+ixBWryeqYUp25O5yAd506ULJCwxP+aGCjJGmUorSDGYbK/aApm6B7FqTDhnbpM5R6aA7EHqBByE3vuu2YmOCXiLtcYueyTai2iYsqHsR3D2VLgIDYz3lzcPRnU06IGVfNBbe9l+I9uFIZkiFCq2gla48/QgD/2sOsl/4OfXDvYVzqRFbUy+DhGHavXOzyCDku531z1N2cddkYL7izm84K4KWbPSKGmMgS+Jq9LHzh5DzbD7goqc3Y4QDSYIE3CfdEyVDJvHolOd/CsB4niUISADZh7ASm7tFCrTLD/GGntQ2WJDyg7JLXpqJ4aCt9XZePTEF4mm9IofAV0BRc/lC3BFjO4E9TmTgLUrnnbF8onRa9I3BQO1kuT8W7VkyvgB+3PI97UbF3BiPwCA6eFJDuUH77awuf2OkbCtTwP2pzQQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be46f5a9-9ad9-470b-b754-08ddfccf4f94
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2025 07:35:48.2389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3nV3etpAjtavDej7OAAb4G+AkpnTVdbb5lNY8Vr9AhvAAKVgRzf0cEYoDFklxXI8j62buSSbT+7xEO6V3Buo2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5154
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-26_02,2025-09-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509260069
X-Proofpoint-ORIG-GUID: hQ0MoDi105jQ3bDcQUoZlgvqeGNGq938
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDA2NSBTYWx0ZWRfXwGhfMhN0uNXt
 44A7NdrGH13GUB7Jfoqtd67sSf95Hhz3A4PvPp1JyLJ+jUMNGcRHm4YbUU813WovE+qdwptDRPt
 ObfWCPSMxAfHPipV+UZi73V3U/9mRtwG63331KHJ5qlAFy1QTzlAAiQHARjk/1EDxavlmAE+URw
 KdMPSGNvELopb7vg1lmPdK26UTHxJ1f3a8XaTwgBgyvqPAPSy4aK8hC7dtsoC34Xx9a8k1Xi9UI
 vR2JUCFGqbADZqV1xMfhKGJld7LvFgVEsI5AZuIFGt1FZCZ5sXfWs74z18AlC/cWL/TJC35xSrV
 1KYujMjUc76vyjX8rqV8+dfWTRe4oAihmrMqLliN1Xq8lk+XOeQzq1C49udYdP12shcGmhgH3Wc
 oBV4YlSOHufI5hprV+H6H4Ntz7NRrWYbgn31y83eXFGBJ+MNh88=
X-Authority-Analysis: v=2.4 cv=ZuTg6t7G c=1 sm=1 tr=0 ts=68d64257 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=JF9118EUAAAA:8 a=yPCof4ZbAAAA:8
 a=BTADzoUDu-xvLFfMw-AA:9 a=QEXdDO2ut3YA:10 a=xVlTc564ipvMDusKsbsT:22 cc=ntf
 awl=host:12089
X-Proofpoint-GUID: hQ0MoDi105jQ3bDcQUoZlgvqeGNGq938

On 26/09/2025 04:40, Shin'ichiro Kawasaki wrote:
> As explained in the commit 0e7aabe55e8a ("md/002: use --run option
> instead of "echo y""), "echo y" and pipe no longer work with the mdadm
> command since mdadm version 4.4. The commit fixed this problem. However,
> when the commit cefc4288c469 ("md/rc: add _md_atomics_test") introduced
> the helper function _md_atomics_test to factor out the test content in
> md/002, the fix was not propagated. Then, md/002 and md/003 do not work
> with mdadm version 4.4 again.
> 
> Fix it again by using --run option instead of "echo y".
> 
> Fixes: cefc4288c469 ("md/rc: add _md_atomics_test")
> Signed-off-by: Shin'ichiro Kawasaki<shinichiro.kawasaki@wdc.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>
