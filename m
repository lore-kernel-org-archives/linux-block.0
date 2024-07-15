Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2918928F0
	for <linux-block@vger.kernel.org>; Mon, 15 Jul 2024 07:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721030150; cv=fail; b=TqkGdCOnHhCBRx14u8gvGce+ljm0CeU2IxyiVoZ6dpze+nTWoT7XX6/k/NYlv9FsQF+BOmK7z9ijtvbEa1AX7mw/oG2A6U1KnFS8erZv1XOEwnslsf5kuoGujHxYALJC9gOnr7DlQ7f1AoCAMrm8uD2O3v4ul49+bHvIoXeq17o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721030150; c=relaxed/simple;
	bh=fgHO40F2cA8PlX11srCISlDkEvjwRpeU6ETzwyEXJKw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mHU0sFY/g+Xr33fv2kvfYPRAn0F0nlFt2qBhnjYQYwZQKFFixKQXBd9aNOOSGBdycFOwMi1f4R1mjdEB1x3U/+69Y+Fr9t6OmLEb5tUaf4qmfF38tXBKtPfkUh2PUsQXUVoFPeBOkVEJYzouShoey+smDRUZF9z95yiDFWdyNH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZgpMwTu6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=V0k/GMEd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZgpMwTu6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="V0k/GMEd"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46F7tTR9007511;
	Mon, 15 Jul 2024 07:55:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=G7+hVzexcdv907OCDerau5aTmmOlWPM4v4yb7CsOUfE=; b=
	ZgpMwTu6ZqD4iV2JlclaxP4RI9TvER5Hp/ioTVu5xnhTLzXOBXnudI6/mRYhgaLe
	9mPLQoKMyyJN9lcaSd6mVGqMkf3xada9ZnDIkdxt6x25L0Sgwxae2fA43QU2cboQ
	IzmClaLDIF1nxyo9LgJfZEToRb5FWRx3QJXz3Bmqe3y+cOVeBP2H6mrifizVFWCL
	+hwrqFhinHEKlD4+pxqR1IYah2NyxajPhN9YE8q6AnBL4pWX+rUiHdikq9hfj7LQ
	u0LeotKAfgsxuJQRzyAVSa9QEYY4mskrGrAO457bt0M/nJlFKCz9bMuV2wffJ+K/
	bwSXW139Kk04RG0nwggmYQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40bhmcjbhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jul 2024 07:55:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46F60Bsw024305;
	Mon, 15 Jul 2024 07:55:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40bg16n09u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jul 2024 07:55:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e8pLzpnX1/F4gvoi/Noihl+DN0XsiqZEY5ihcLf9zwlfkr282TSjXtyzat1itmU3P8VePXLejwIc+PEE60nSzsQfrvm9GOvvjZ3I9ECwSfb8TQK6Fg5viYdskqBqidV9yrudWSkp5t/rUKCZgAOgqNh4SExEc2z4xxjehjlQN4YL9fCcCVxkus85Uv3iS0qziNJrXS2P+16YnE2QcaCF6dJHsa4neG4LccHq11ZwKUpngnb8KyjiMpFYc9W71/aiLQv7Z2UUSgLmXcAoRCc0WyNNnCAhYYpRaT8jbW7ZUSeKv7D4bvl1tNVJBVkkhw2feSzu+OpYNgV+8TKJTL9cXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G7+hVzexcdv907OCDerau5aTmmOlWPM4v4yb7CsOUfE=;
 b=Kb6sxTaWXxICiEgHPn0eROnASN2xVW106S6cphhwbLU7IoVPA9Vy5IFXHEGIeBaML2c6sKz39TY/+5BJ02nVgkTul7Ifo8MAlJDmKDn7eBFTfPMkMJ69/+JJQ1oJHfXQoszhYS02suRLrJpiku35D5uFQ9CC5sXdC9+VrngzKmobKJZs+TS5nuchXcgu4G9UDGgEqlMMSyOZQxtTzYngp17RI7RqLd3BKryfMYfr3mTEwfP3JGcWuI2GGKMWd5R8gNII8Mi1/+1gRE/L3JwN6Fw7YEVV/l7qUlIha+y14u3xzmq3o30GRIdaKJDcwsLlL58V7tItXi7D2Ra/wzH7HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G7+hVzexcdv907OCDerau5aTmmOlWPM4v4yb7CsOUfE=;
 b=V0k/GMEdMAm+GFoPUdFXzhInYWTwkDGSEQ9bfaDuE9ybKXXE0Y0qVuZD2qjkp1KOrEaOAVlVC8cSYyOOzHfeRN21hwQF/+sObOJ20O05NvGb2a8tARUy0ItCuS814JmLHkF9YrQ+oFm5Y14FYOEouA78wmcFWSFAY9ZQ62YQDOo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by BLAPR10MB4852.namprd10.prod.outlook.com (2603:10b6:208:30f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 07:55:39 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 07:55:38 +0000
Message-ID: <5c0073c0-bdf8-4b23-aa22-516ddac0c1a4@oracle.com>
Date: Mon, 15 Jul 2024 08:55:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/12] block: Catch possible entries missing from
 hctx_flag_name[]
To: Bart Van Assche <bvanassche@acm.org>, axboe@kernel.dk, hch@lst.de
Cc: linux-block@vger.kernel.org
References: <20240711082339.1155658-1-john.g.garry@oracle.com>
 <20240711082339.1155658-6-john.g.garry@oracle.com>
 <cf6cc884-0928-4f82-859b-62407d60604e@acm.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <cf6cc884-0928-4f82-859b-62407d60604e@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0047.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::35)
 To DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|BLAPR10MB4852:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a91d416-df20-480f-68f1-08dca4a38421
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?RFo3WUQyZkNTaGR3eHhwTGF4Qm9BNkZQS2xIN1V4UWZFZklrR0tlckZ5M0tv?=
 =?utf-8?B?L24yWU05M3pSRTBrS0tjNlVIZWIrNFA1eXNDY2FvOVI1NTdkd0RUVnNRT1pu?=
 =?utf-8?B?NEdyQmNwNUs3WEkwUldhWUtCR2hJalRaV2QrMTNpYXUvWDNwL09KanUvWEVH?=
 =?utf-8?B?aXk5L3RMZVVzdFZVMENpNURDckY2L1h2TEVyRWZlZzh4QXNIR0YxMlNINE9n?=
 =?utf-8?B?S29TY1ErekNnNGNGT2NiVWtnaW1KUHo1M0ZURzYwSTlWdHN3S3Y2ZjZ5V3hS?=
 =?utf-8?B?RzFnM0lNZzZROVhpa2NDOElDUmc2Y0tGbDZoSlg3OUd1aTdiZGZoQzgvazZu?=
 =?utf-8?B?VkZrSDNHUVB6V1N4bitiQzhEN3ZvK0I4ZFJWSC90Y1BvV1NOeGlvZjI4em5Z?=
 =?utf-8?B?WVBkSW1HRWpYdW9XR2VkQ1l1dnhyNW5UT210Z1JIQ3B4RkpYU1VVeHFoSWpX?=
 =?utf-8?B?dHBJN3BXaDl3OTRzbkNtSVN5Qm5tVDVuRTNtY2w1ZTkySzFENXRtZ09nQzlE?=
 =?utf-8?B?TGgyOTlVN2dMY1kxekp1RDJ1ckZDRzcwaUkranRuMHhaTWZ2TldCVEF6a0p1?=
 =?utf-8?B?SHg0MCt0c0FjWm1PTEZPR0Q1R2JFTjZrQ3VSc2tid0ZtQ2JocURlai96c2hS?=
 =?utf-8?B?b1Y0b0hGVHdEQ3F4K1g0WFpINUJEYkRlV04rbzVmRTRPZ2VGN2xpd2s3dUU1?=
 =?utf-8?B?cmZqWVY1NjdxYnhwNjNjYzdpY0pLWkRIMXNSNHEvc1B3cm4yMkRKQTR6TElM?=
 =?utf-8?B?dUhzTUNUN29oYnc3Tm1qajdvRFZaTzJUMDAwMmV5NlZmMWRRQVR2MjRrclBz?=
 =?utf-8?B?MEVRM0RaTm1wMVRCU0l3UDY5SFRXWkhpeHZjcUtGYzdlajd4S0pvNEpLOHpZ?=
 =?utf-8?B?aXpmRmlreUppTHpjVnhZZTVwNVZ4a0d0SnhmcXcwK0ZHTWw4aGI1Q0tXaUpK?=
 =?utf-8?B?R1oxeitLdmZldy9adTFBTW5GUDVqSWtkWmRkYS9YUWZvL0lHQkVETFkydmky?=
 =?utf-8?B?cU5MZnNYY1ZLcmxWUjhMeWVBMk5DcFVaOEtScnRRMFpKN3Jza2dLY2FXN0lO?=
 =?utf-8?B?MEJvaVovVFRJcFFlQXJHVktYRjJMaThKRncxak5HZFlPOFZnY1FXaWdEQWlR?=
 =?utf-8?B?eE05SkhWMnZ1c0h2anV5TGgvRVhJSEFvaTg3Qk54WU92ZGtTSnBNMUhveWFl?=
 =?utf-8?B?QjdRQ05Jc2FjQ28rZ2hPK3NxU20xbjVXRzYzSno2dStYeU1uU2xkU2lxQmg1?=
 =?utf-8?B?UmFDVDIrOFY1ZDlXYjlJNm1zd2R6KzFyTlBucnZXZ05Gc3RNOTNxWnpwSExQ?=
 =?utf-8?B?UmRlZE9rdTIxU05HSnVFcDF0bG52d0NJU2h0TkdUYTRPempvWEZ6TzhyaXQy?=
 =?utf-8?B?ODRmcnpuNXNPMTJEQWhxcGw1MmJseGlsbDhmWWJrT1A4NnR1MWNMOTZoQXdo?=
 =?utf-8?B?N0JPUUNJajAyK2d5YUdWdTMway9jcnNhaW9RelN4Y1Rwbnk1bllPaWN5bXI0?=
 =?utf-8?B?TnprSmhQaGxnclgyZFUvY01nMmkzNmdUV0lQMW5Zak1SVThtVlp2ZVdic1Mw?=
 =?utf-8?B?SUZRRFppay9mOWdibHhKT1JnejA4dWlPeVFzMEgzMU9UeW1tOSszUHBtc0Rn?=
 =?utf-8?B?N1V0aGpKclhJTnNrYkFieFJ6cW9mRHZuNWlnakxpbWpndlhMd1lJcTMwbktz?=
 =?utf-8?B?YmpPRXlQTklsMmpTUUQ2RjJxUThjNTBEbFZyOXlVcFhiLzBCM200SkRJVWs2?=
 =?utf-8?B?cDF6RUhDRFVwRURZdVNBL1RJVW5jZzRnQk56Y20ybVJUSWFCQ0t0NU5CbG5L?=
 =?utf-8?B?K2ZuOXJtRDRmTGJ6SGpQZz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?bUFJSWFkUmN5T29WRWhQWjFxQTlwRHM5Qk1TNFFkMjZ1TXVKb0tPanJBbW1R?=
 =?utf-8?B?TkNJNU0xK1ZydXk2NHJVSThqcG1qdUdXc1I4cHBteUlvK3o2cU9pL3ROcG9P?=
 =?utf-8?B?TVBPeVExNSt4Kzk5Q3VMejlDQ3FyTjNwY2E4d1JsZGxSQmRML3JtNExwL2NR?=
 =?utf-8?B?U1BqNnVTODEySlFTdkR1SW9XYXd1bVFFYXJKZlhySXpOWEQzNnJxOGZHZC9B?=
 =?utf-8?B?TUs1VCtwVVZqbi90amhIcTUveEVKSGhLL2dKQjVrTWtOU1gwdHpzRXNjRnBy?=
 =?utf-8?B?UHlMSERPQWZ5WnNXcUhIWm1jNHZOalZsWmFDbFlEbnluNEtDSkszWFJGYVMy?=
 =?utf-8?B?clVXaHZtWkxYREtYb0xMN2I2VFpnV242c09BU21jeG5kK0JJMGsxYUpZYU1E?=
 =?utf-8?B?aFZXN0FRVGZobEVQZGg1TVFacTJBZ1FkaGxrMkJkMGNOcFRXOWlKUXQreHEv?=
 =?utf-8?B?eUdzNmQwRmFzNW5CUFhXbVRHUFNaVEE5bitJaG9GSzdoVU8wcDNXTVB5UkV2?=
 =?utf-8?B?NzQ2bWlYckJLVFJ2Y1llU0orVTd0NldUNDVwUlhoWnltQjRWa1ZnOEdOb2ZO?=
 =?utf-8?B?aE1DMWlSVkErSzltYkdja1gzWnpRUXA3Y0FVM2JGV3o3Vmk1cS9kL3RLWER3?=
 =?utf-8?B?eGNZY1VkSnVEMDhWcTJpREMrZlh3TzkzeC9CZmhGbzNpWDIzeURMNUlGOGFD?=
 =?utf-8?B?MzdxRzE5clNBRjNUVWxHc3I3a0N1Rm1XUjlOb2VRM280UmlrZ3JwQ1pjRVJ5?=
 =?utf-8?B?UlJJV25CVVBjaEdVU2Jvd3d0QUZtMk1ZV3R0Z0pHVXhtbDkvTXIzV0RCZFlG?=
 =?utf-8?B?Y2RjRXA2ei94WDNKbjFsYXhPNWNzMkNvM1ZPeEtkVHhBUWdEOUdwcDNpa1cy?=
 =?utf-8?B?SUZUMDJmQTFCOWg3NDhUVHBJODY2Y1ZyTTJZVXNqejVsTStWeHZKbTRGVmFN?=
 =?utf-8?B?RmFwQThIUm5xaG5mazdDZ1VteSthL2E3SlJFVmVPakNTZnNRTnRacHFiNXdG?=
 =?utf-8?B?UStIdlRHL2VubVFKeE5hOWZHNXRsbU5MYSt0Z1ZNNFNvdU9XbHVUb29laHZi?=
 =?utf-8?B?a1VPbEFzMUliU1JkWTNTZlJsZW5QNC90L2NBbFpNSHFUTWRVNUExbk1ESUlQ?=
 =?utf-8?B?OU1FODhEWFFzTmdMRUhkcWhpKy9JcjgvNm8xOWNVcXE5N3FRckFtRDlybS9n?=
 =?utf-8?B?Wkwrc1k5d2Ywelo0Z21hbUYvOHlhK2tJVFNVeTJreStQcWh1NElNQ2pQWmFa?=
 =?utf-8?B?b2ljUXlhb1QxUStKalp6NGp2RHU4VVdyOVJ1ZnhsNmdDMnhzQllicmxCNlZT?=
 =?utf-8?B?RXNkZFhvN0ozb244T28rS0dhMk00cjVBczZjdzM2WXEveWtlRkZKNU1XTkNG?=
 =?utf-8?B?VVNkQ1Qwam1sMVQvK25QYnRVMWtpZTl6Y2tqVEcrcGkwYncveUFxdkw0N09w?=
 =?utf-8?B?cHNiUjhtYitaNGxXMnNVZkx2RlArdURFUjJWcnhHN0NxMEtpaGx6Q1k5OUhQ?=
 =?utf-8?B?ZUp4bmE2eGozUzRtU1RsQXVZVGtSQWgvMW1RMHZSSXdHdW1VbFFqM0JIYjNV?=
 =?utf-8?B?MWEwV0VsdnVjcEsrQnhyU1I1Y2lGNkNaV3RnQ1crRUMvcFp3eGxYSmJTbEZY?=
 =?utf-8?B?TzMzYzJYbVd0cG1CeTVZalJVcno3OENvRDZOMTgvNGV6WmhSSHVocXpJNGZo?=
 =?utf-8?B?bXFQYU12K0NWcENFa2huKzhxeWxOazBFZ2xuR0hJQUxjK2paTktjcGd5Qnhx?=
 =?utf-8?B?Rk91RjBhYjdML0RTMWhmd0JMNVNYZlhSVnlmRFQ4SjRDUXE4RW5IamZXMzg0?=
 =?utf-8?B?YlV4M0RkVUEvYVhTMVlsbXlJRlJTbmVyNDNhTVA5TCtPSDgwTC85dWJ5aUNT?=
 =?utf-8?B?T290alNnbFcyMXh3U0RDbm1henlnT0cyVDEyN2JzSEV1cjNKWlExU3g4NDAz?=
 =?utf-8?B?WUh2KzJsSHB1Y200SXhqdFdua002RzVvcldOWkxMTE5VMXZiYkVJRDhpWmY1?=
 =?utf-8?B?TGxQa1pudW51U056V3dVdmVJWHViOVMzUHdSVWdpeDFyQ3JFc1g4c3RTYkY3?=
 =?utf-8?B?cThJdEFidk9oMXJMVm8rcWpGd3N3MlV6U3VQaHV1Y2lGT2JmTU85d2YwSmdC?=
 =?utf-8?B?bVZFVUczY1lUN21RNHhRZjlNREdZakRoOHN2NkJ1Uzh5NzRWcVkwVDVZRVVu?=
 =?utf-8?B?QlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BmyyFe0gtz+jE6MMfyl1PYVY3LyItWJwOL1OPQmkvF4og0AmGbiXihyQzKCsqYVj5blxsAneeW1VZ5z0Va8pZPSY1RNiVfx4d9aiwR/1so8lu+k2DSAKxZQqwrKDXZZgFyWMj5y5+ifRybuHOsYh1IQphyhVAJ/XLeFraYb2KVIl81DKorORvyTIN/zoEpMYz5j77VqQlIKw7cZcvBF83zu0GRIyyrkgXzej1dwxp0NZhUfJ3BgzDAuIJ6HHTZbfJF6yCiF2Q5ZZ63sjQ3cf31jSseOEH98KfjpDM2xz3eKgF3Upcd/jjhuxI60hzdpRwFkJ1qvZ4Q6/bmViFpryIfqD4jG28fcqpDC7m2vaF2Rc7U818BMf8wWT6UybDRznAf0LN16sHTCyo9kuzZlE1EDBKUkeRtBEceW4BwduNr1kf7oY7hE/UT+zuxyeGba2s6ClGo/RvXcjC008C5BmVxB+L2tQxPxU6Pqtlsy8qdggO5aukd926GuUgmSHZfQnhjIVMO5cacx3lWuqqQjGCpeW7eVzW8MyRTXGKZ2SavQWcni2jtzAmyC50zKT7mP69dE1WDsjJrUzXABJWbShSGG6mxJ7Qwon8ZjSwhDUV4E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a91d416-df20-480f-68f1-08dca4a38421
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 07:55:38.5499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Kt5LLvlBT6EtQ9VzgtZ/I4kXoXfNwFeKejZc+mzEu2SPQ/6Oj8UQZF9mEtVTSKW9bCxTd//wryT6jGgSIa8wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4852
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_03,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407150062
X-Proofpoint-GUID: zHIWE7S0SqqmVt1_EoTOJSbqahdrr3Rj
X-Proofpoint-ORIG-GUID: zHIWE7S0SqqmVt1_EoTOJSbqahdrr3Rj

On 11/07/2024 19:10, Bart Van Assche wrote:
> On 7/11/24 1:23 AM, John Garry wrote:
>> -    BLK_MQ_F_NO_SCHED_BY_DEFAULT    = 1 << 7,
>> -    BLK_MQ_F_ALLOC_POLICY_START_BIT = 8,
>> +    BLK_MQ_F_NO_SCHED_BY_DEFAULT    = 1 << 6,
>> +    BLK_MQ_F_ALLOC_POLICY_START_BIT = 7,
>>       BLK_MQ_F_ALLOC_POLICY_BITS = 1,
>>       /* Keep hctx_state_name[] in sync with the definitions below */
> 
> The patch description does not explain why 
> BLK_MQ_F_ALLOC_POLICY_START_BIT is modified. Please include
> an explanation for this change in the patch description

Can do.

