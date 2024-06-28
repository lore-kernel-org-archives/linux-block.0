Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC55B645;
	Fri, 28 Jun 2024 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719585030; cv=fail; b=kKk+UYXajM0spumRYMXjYs58bbOckNOcc4+IDanIu76JVtu3Ac/LEa9O/IhExS2625F6Tl4r8vogtC6I1yNjcNJ9td4wZv6lyceJih/CobU8jUE9hqktTvnamSVJRI6UU/d2O4ZmnE4n8giub1UYrR9DBm/642KzEVTrC+wzzpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719585030; c=relaxed/simple;
	bh=hCna6Z2dUzpm/UNPt8Z27Zi6CAUtHoQ8bwymwbaCHj8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Q6kLhOT0aYP1i4YmbWH4WEc+qDK0sJl3y08HTM2kV+OFpUQk25m+ii7P+VVmtTEN3ZEE8yFBInfxFO6Y9FLz10N/CfGN3nWy8jCxFNAhH75rn/wT0XqNwQOOsh5SOISSSkCY5ZQGUpBr9yqaIBFDrvBPDDmFD+i9L46oMkbYHp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OKy3xiHS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FwXUdJMs; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OKy3xiHS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FwXUdJMs"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45S8MUmm032403;
	Fri, 28 Jun 2024 14:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=nBv68MPA09GJ7gtGu0uuGIstfF8HVo4ZLpWFy4HiriQ=; b=
	OKy3xiHSd4mgbW5CYKDD9ktdUhs36EOhScmv2cvqAaNyMGfC6EVlNgMMYd6C3fkQ
	1kCcAkSBT+TgynmoJYsnH+j8WD3jBgRBaVYPlCyOVEA9j1oH5qBE8j/zlliC/y7Y
	3d17fNP80BgOtEyhasXpZf38ztM4aYVzJoK1dSXIwLvaRKT+h6Hr6YebQsqR+PhI
	Bi32Z0jZW070cHfvGJ0PGkaJDXhc1gD+bedDGm2DXmIuj8U74oSAX0rVNan0oBPL
	w0O7u+lqZ0N5GGgmufep6t02Gva2o92I8BmZY+yKM7o66ermy+rE6kPMPU1qp4+U
	m7q70mCohvosTADwIyycCA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 400ttnc1a7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Jun 2024 14:30:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45SDk1Sj001289;
	Fri, 28 Jun 2024 14:30:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2chv26-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Jun 2024 14:30:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OFjI3244VQ+S6A7o43WX+oqx6pB5/RqsTVbk46veBVdXcSX/wPelYP3wNZcecSXI9xKgyI3VnJCRWL9pJNv41fpFYHrs4P+64aO2Q4iCCKgR6kFJaChy+sbmDYPozf2R0dV/pEVS8L8P9LbrXelfIiijBfFOCrqieFaBEMKnzdaMSUexoJnGfPUzh8lv/pRHEqlS+1oofaLbef56pbVf2gAPIdwNImJQYlTWRPUI5baYOXT1sdUGA4BA9WQD4ozvUUJbbEUZ2Fp6NakoblRtqMrb4DDHRRe0HqyZ5hwjCYzX4WjUNbfvKarZ+4HLIPFipH08to5Y2InFNqMwNepR8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nBv68MPA09GJ7gtGu0uuGIstfF8HVo4ZLpWFy4HiriQ=;
 b=BXtBYmuB1YcCw+nK9fLwyKTF9Zkv6sP9zSHZ0UDPkAcii9hjgPWYMnm4QRNkwlQrLWlZoD/Qxlgr8q67jsGo1Y0gY/XNyncmumBSOWaKxxshPFPAtWIrtmSXiSNm4VeDXPZXFZy8BZ2Uzdi6DjyaSci4SvWjiT7iFdBfAfbGTDhdkIAJTSMJRvnikh6i5rUaOiwo/wpzn0/wWLrZqSoHgijPJ+8VtNu6XzwokK+lonWFOkcWViHslnB2KYajaYlJsXHRu4tnTGI7CMhTX6UENZ4ODRKE4OaaiihxBca71I27xiak+C16gnbrPyEVl8+R1VMpGQdbAKLR+2epYae4ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nBv68MPA09GJ7gtGu0uuGIstfF8HVo4ZLpWFy4HiriQ=;
 b=FwXUdJMsjNlWfT+E00I5PAFkRCktdctG41rsQobWTFHOCepRgQBRBQmSimbyFytNQ+q0x/ggf1JpxGk0HFQ98l5rtqfg/g866IIbiEf32fd62f17+4B0cd4WlEysrie2GZzhXpy5iOQdkAS864x+//hSNmAex6Etw3Hi6qxSpco=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7742.namprd10.prod.outlook.com (2603:10b6:610:1ae::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.28; Fri, 28 Jun
 2024 14:30:11 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7698.033; Fri, 28 Jun 2024
 14:30:11 +0000
Message-ID: <8f8f8f78-fcd4-4e71-8dd5-bae03a627a34@oracle.com>
Date: Fri, 28 Jun 2024 15:30:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] null_blk: fix validation of block size
To: Christoph Hellwig <hch@infradead.org>, Keith Busch <kbusch@kernel.org>
Cc: Andreas Hindborg <nmi@metaspace.dk>, Jens Axboe <axboe@kernel.dk>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <dlemoal@kernel.org>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240603192645.977968-1-nmi@metaspace.dk>
 <Zl4dxaQgPbw19Irk@kbusch-mbp.dhcp.thefacebook.com>
 <Zl6cHI48ye7Tp1-C@infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Zl6cHI48ye7Tp1-C@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2P153CA0024.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::11)
 To DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7742:EE_
X-MS-Office365-Filtering-Correlation-Id: ce6e2d35-1d4e-42b1-77df-08dc977ed135
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?d1Z6M0F1ME0wM3BNYU5nTEFCckdlZisyL1lFdFB1em1yanFaLzVuNThtWGdY?=
 =?utf-8?B?amxVa0h1WEMrdVBMRzRNQi9HdFY3dnhKZnRNZUowdWhWYWwvOUFsU3hnOWht?=
 =?utf-8?B?UVdpb1RESlpISkxucG04cW9zMldYay9BRmxHOCtZOVVjSGJwR0Z4Z3hjQWF2?=
 =?utf-8?B?Y3lQNVFpanppdWNTL2lVZFJFdHhzUGNLNTBHeGRwakxweEdGTjlZK3lIV3k5?=
 =?utf-8?B?d21IbVE3R081QU1NYnBrM3IwcitMYTdvUWYzYmFvN0dZT0kvRGlJSFRUbGdq?=
 =?utf-8?B?QTlDSzc5clRQa1BGbnNQOWVpT0UrOURBbHRsa2FyZVdiaG04UTdxMmF5Znc3?=
 =?utf-8?B?ZmhJMlphbmp1Z1ZOWGhpS1hoMm1nbTdMVDlGcUFFR3k1N2RBSlQ5b2pjTnFX?=
 =?utf-8?B?N3RvV1BYRk5WZ1RuOVhiQ2Rma0Z6SzBtOGV0Y0FxbzhoUVR1bW53azBTQUo1?=
 =?utf-8?B?ODBPL2NGWi9veFFWL3BoaklVN282YTFrYmMwWGMzRHllN2hWb1Z4QkYwejFW?=
 =?utf-8?B?cHZJcStoayt0ZFdmVitEUGkyellDeWJIUTh6b0J3dUtCdjVJUm1KUGx4NVd4?=
 =?utf-8?B?R2ZQR3IyWEdwSnFkRWZ1R0Q0NE5uUWoyUVM2amRISW5mNW5DSlEyd1pINk5U?=
 =?utf-8?B?OWY4Mit4eS9KNDNCS3RpZG1qSWduMGpEQ1ZObG1oUG96SHNINEIwWDhNTjBC?=
 =?utf-8?B?KzVaSDQwTEU2MWplRFZmcEdoYjJ2TFlOZElsQy91RmRsZFhXN241Tm1kbHNa?=
 =?utf-8?B?ZmtCZGFQL0Z5WENwQmtodU9GV2JVUmo2WitiY3l1dmZ6bFgxcVV1WlJUSks2?=
 =?utf-8?B?ZTIybDBBZDZMNWRzZUF1NGJhRGoxbTJJNnF0clVVY0FXYzNmOWNmaGtpYWtq?=
 =?utf-8?B?WUtNbSthMjBjdk9iVEZTZURzdGpRY2MwMUtyYjFqYktwSVNTOWJRSm5GTVJt?=
 =?utf-8?B?cGlsaGQzZUtDZWx2S3R2bHdDenc3ZkFVN2FLMzI2TE8zZmVua0pyQkZlVndX?=
 =?utf-8?B?NjZQcHZnV25PWmN6UHpIWTNvKzV6N2RDN2hEcWxMTXdudjR2SzltQnZPNGVh?=
 =?utf-8?B?YzliMDZpbjBWc3RKdFRDaUYwWHJ2U3RJblNkaDlzeklpRFhSU3dQMXlndDZK?=
 =?utf-8?B?WWxxRzdvbDZFUlNYRldJbUczM293cGdvc2pWN0twQTVkVFp6cmZPMHZkY3B1?=
 =?utf-8?B?aDNvbzdUUTRHUk91NU9iR2xBeWttenY4YmhyZVVvVTdobDZZTXlrNkRjeUto?=
 =?utf-8?B?enNvbzBjNzRSeUpOcXJRMDZ1NzJyK2YycmgrTUpxeWlac3Y5TEw1dVlnTnJo?=
 =?utf-8?B?YWxNME5uM2FOOXhDSThzanFRQVhNVGEvR3BuYVltNkJVVENJaGl5eWpSTjFM?=
 =?utf-8?B?T1NLc1FhTDRnYVhYNHZTNzNCdEllOWFMWUxWZk5sRDIrMTFxbFdFTUhDaXVq?=
 =?utf-8?B?K1ZhZFRiNnVpOVpQVExpUFU3ZkdmY3NCRUYveE9KMnVHZ3czUUVVMkcvbGNa?=
 =?utf-8?B?bzVGK3dVWldacnd5aXdBSGlkME9xZkhxMS9MZUI5WFcrUDVYWjBMMjJkSUtX?=
 =?utf-8?B?UnA2UXk2WDRPMjhHcGcwdFUvS09nMVdrb2R1ZWM4cDNJQ1V0ck54aGk5Vlg1?=
 =?utf-8?B?czlKejBRVi91MWQrblpOVGVUQ3g4TVp5MXdib3daNHFjd1FGWHh0WmYxU3RK?=
 =?utf-8?B?MVlOcDJ4QnNJdlFaVVR2MCtMV2x2bVovMzNRakhjV3Y3eXM3RkJBcnpISmhE?=
 =?utf-8?B?VERnall2dHhiNVIycjZ0RHI1ekRIN0w1T0gwb203VU82WEx3Y2ZlakJUM0Uz?=
 =?utf-8?B?cUZJc2RLMWhsY0FaMWVadz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?NlJiaXJpTjBQeHBzMk9Mb29OZm12RGNFWHVRempjTVJpMGJuaWNXRDFnTFdU?=
 =?utf-8?B?WmlTd2FQUXhoNUhHTzR3MzZWWERxSWUrSlRvb0xTNlFrQnZiSVMvU2lleDBs?=
 =?utf-8?B?Z2ZsNG82NUY3cU1Kcm0rZi9hQVI4eWY3T0lpMFVqSHFhbE43VkgzZzU1Q1gv?=
 =?utf-8?B?eVNOa0V0SHc5YXJjRWo0UmNkL1pRU2U0Qi9zc2NuYTYvNGE2Zlo0N2xhbWdT?=
 =?utf-8?B?Q3pDVzZJMHh3NGNhb0pYTWdybEF5NjMxWkEvNmFVUEwxZkJJYjZYaS8xYjFC?=
 =?utf-8?B?T1FqT0E5VFlBTDdtT2VsNEFIOEh0N2tSV2p4ck1ZNUorRm5ESnZWS1ZCdzB0?=
 =?utf-8?B?WjdOSzR4N2lmWVdZb3BsRGdVOHpkNDJxc2lzVDBqN014SEZsZHVsUldBdTlx?=
 =?utf-8?B?ay9vb2RjUVhyNk00TDA0SHZTZ1VvWndIdTRvSDB3M3lmaGoyWkhER2VmdnhE?=
 =?utf-8?B?YVc5NXUyVVl4aHQyQWFlcFAyam5SdEZBUWkyTUFseDJjNFB1TDBlbjlKRmRu?=
 =?utf-8?B?aHpjcUxuVU1wK0xKRkJOeHBSWUVtWWt5WVgyZWQrYkZsNTJvTmJJS3hGd0VJ?=
 =?utf-8?B?R290V09XT1Q2b214aHhFWkZzQitvZ2ZOK3FxeU1tOS9RN2F6UVpwNjI3b045?=
 =?utf-8?B?YTVzVnd5RVBQTHYrQTFUdEx1cUdueEVFYTd0cjhqVEZGbm1FY2JIa3hFb0Ur?=
 =?utf-8?B?Rno2QVoyTFF5OEdtK28xckZ3WHE2UzQzZWtJUWdzV1NsRkJMR3RZUWx2Vjda?=
 =?utf-8?B?elp3djRzN1IxTEFEanZ4c0dISGhna05ZUzlKSURqN1NET0NKdENDWjZ6MXhx?=
 =?utf-8?B?N3h4bjVadXloMVdZdFo3VTdtRTNIMFVmZHBJQllodlcyS0RoOWZXZVFGUjZs?=
 =?utf-8?B?MVpHSGFkNkpJd0Y1ZzAzSXFqMEFkYStZeSs0QmVwaWlYcFBvRERNZG1hNlR0?=
 =?utf-8?B?cDRTN3hUN0JWamxKR3BwaTBiVTlUd0VHTnRIZEpMc1ZTZHdDdWlRaFRUL09P?=
 =?utf-8?B?OVNyWjNPUG1Va1dHQVdXZkNLbkRjY0RWQXJUb2VZK3BtbFg4YzFoeDNrUCtV?=
 =?utf-8?B?RlRMZUJ0Tzg1Y0lQb3JpYmM4Yk42S09JaytXa1I0SEVxTmFyYStFZWpiVnpm?=
 =?utf-8?B?TlJqRkdGWEdUSCtndENhY1hJQWhDVzBUR21oTnBQSXBNbTg4TFB0YWVpbGVl?=
 =?utf-8?B?NWxvK3lMeXRHWXdzazlUVmUrQXZUa01jUzYrRmlLTVpVT0RKSW9KSUZBREZ1?=
 =?utf-8?B?UTJKTGp6MXZ1QUNYdTlSNGhzU3BvZmltaXZMVFlFZ0ZHYW1GU04ydmtTWFla?=
 =?utf-8?B?NjFRUkVoMmI5NHlBQzRTZVVlUisyb3o0TTQzSHRQZGJWMHk3TCsxWEQ5N0hV?=
 =?utf-8?B?N3FlVkFkaVBXM1N1ckFFTHUvZnhxTlhxMCtMc2RQQkw4Y2paUTQzRzZPOEds?=
 =?utf-8?B?N1M5RGF2R0RmU3dkMFdaN1dWdDFVWXN6UnV1YnlMRjhzYmpldUEzZkwwcno0?=
 =?utf-8?B?cXhPaTVmS0s3VlhTWHBhc25OaThvaUt1RDZyL1BMUHc3VUQ4L09EWkxLemx4?=
 =?utf-8?B?Nm1oVFplZWtVUFdWVWRSdHFyd3EzQXdWdG1SZkIzd2NmV09ieHBSUXBQNWo0?=
 =?utf-8?B?Ni9ERW8xL3NOclB5ajdoOElZQU9rWG5RK2svbEM4d05wUk1sOW9qRnZ1eDdn?=
 =?utf-8?B?VTY1WlUzNENOb3ZlTnRDQmJzVG1OaXY4SUorSjNsUGNqbEd4dnNubDJobDZv?=
 =?utf-8?B?SFIwTFVETVpvTGdsRE9udkY1TEZKS01odVQ4VS9haVIvRUNmb1AzazRzaEh5?=
 =?utf-8?B?V1JMNE83cGhNa0dXd3NOandMZXJhOFVyVEVqMTIyU1VRdUZhMjNwWCszaU5t?=
 =?utf-8?B?cEgzMERZWFU5VjFPYjhUMTZHYVBvcjJXRWRyblJqdW5lT2RrdWUvamJNNVVj?=
 =?utf-8?B?OHgvaFgyZnpiaDVMYnpIQTUrOFNYOXplWXdhNnp1TFJ2eSttTXFVU3ZxMDk1?=
 =?utf-8?B?cU5ibmQ3Z1d6OUpXT1BSVDI4VUxMMUZkQkxDemlGbldiOUx3eXhZWGF5c1hq?=
 =?utf-8?B?b1BadTlnbkMwVzhPT3hDcW5vSTZaaXRyRDBacmZ3bXowaStDcGdCNms3eGoy?=
 =?utf-8?B?UGwrUlVVSlZBS0ZNRFM0RVgxWkZzKzYvbVlMSXNrVWlSWWMrUTQ0WGVRVWpi?=
 =?utf-8?B?NHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Gf/J/PA9mWTCByEOrbDj1kWpwkrFYScnU6P5h4RCAk+rB5+sk0cxtuRr59z4XbNaPYFUFGs8/8oDj1nm7H+Yp8vWMeSvIPsGub9WhibTPcFrRPXmnaq+8RW46xvJx94cc6vd2IUu20apLFdVIq3lX08rrRZpcpoSLVrapcLQQTp3C7jGF3/fXhIli0wWVgwhs/vdv5xq0yqz0rkDoV7Z0ffP0xGr2867RY32rC9DfCfRICgEJMIcK9YTZu6urQ2tM9hsz7BG5JuRgNlZEBFVNxpEB6cUzM28wkkuqcGl0qFzVD6IZ+mCNPVpp4CzyCKulxz4wOGVbCvK2q20HRCUTeZ0RC7RimijICr970rHSD33KI2J8JSvptDcEND3cE5hNu5XSBU1TZ7f0MC1cHeoKkBjE0CCRquNTaTJ/2mQSI5FTocpZ2hg1b7AoJCZ+KjfU3E6hIHxYYjONaThMY5T3HabcN05AqoeiE8M/VC4GkFL8qDN+VcM+iIeDEbzsiGY72Uu5x2YEa/btWkvOmupHu1WIc7+Th4qqkuZvk43qCoCdSipGxVMVcFe/qqS1qdNWcwnVdVSx/yx2iLpmeFRz+91TrGJJIMPBdDG+nHWBno=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6e2d35-1d4e-42b1-77df-08dc977ed135
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2024 14:30:11.5507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j955E7mz6DWZ6L6ZTgkHND9TgCzCJg3eFnRuIjxIx6KwZlF/zNV1QKAK42KHc/Lwj/arqa0CdQCaY+vRCFOY1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7742
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-28_10,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406280108
X-Proofpoint-GUID: vKqcmRr1Nae7WthWMMi4S1H2YSDTtvM7
X-Proofpoint-ORIG-GUID: vKqcmRr1Nae7WthWMMi4S1H2YSDTtvM7

On 04/06/2024 05:46, Christoph Hellwig wrote:
>> It also looks like a good idea if this check was just done in
>> blk_validate_limits() so that each driver doesn't have to do their own
>> checks. That block function is kind of recent though.
> Yes.  We already discussed this in another thread a few days ago.
Has anyone taken this work? I was going to unless someone else wants to. 
4 or 5 drivers directly reference blk_validate_block_size() now.

Thanks
