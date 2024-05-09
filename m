Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D4015CD7D
	for <linux-block@vger.kernel.org>; Thu,  9 May 2024 13:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715262660; cv=fail; b=QDT5Q6hifjSk/ldjTwzoLmXYcyy0FYJch0eHCBTITlmZfX78PK9ilW9hw5Wtxdt39wD+x/WFgYHI/UXlrHO109JR/DD4rB+mNkpdq8kfk6N9o5KQSsxWBm5aFNYbsvcDHKqEBHYSQUTaDDPOe4Jon2YcZJHTWO+FmtmAJFuvtw4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715262660; c=relaxed/simple;
	bh=lZhBnM7tREgzBW79/oX9Z/WH3CX7HPA2mdtuRlD9RU0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hxcSDcrddaXGscxpKE6gto6rpPwUz5CAh0VXoZQ4JKWoCh/W0hOpcqGCp8+Rj2YNNsJIpuvzLM+xtwL7x5ic+ZAVd00mx7usH7onBhJU7Xjo3UNN0/ZojqxBFHJvfhb2qYqUK0UQyuBWGHQ0vJr91KrkZs8A7138ubkUoKBAsj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Eh4fH2Gv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aFk6Y6Gf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Eh4fH2Gv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aFk6Y6Gf"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 449BlJ9C024435;
	Thu, 9 May 2024 13:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=uLaYdosUbKTE0HEP2I4x+m1nvQ56cKLa0/jjdfYtVnw=;
 b=Eh4fH2GvKt/2cF2qujVzAHOh/7Wz3QVWieDSes+fjes2rLriehP0K7PWwId0nPf6vlKG
 /mATl0Y+Sjl+1BfvHlfHrpfBcTKrrok4KE7uc2hsVBUKgckH/amJHsXGFWpwea4NiABk
 bKmSOQZD6j4pjteUqGiRWAflK7LmyCiJyKWtWCfvpDThMQf3E/aj+ykwMmukOV8qCJQj
 Bt7jsp/k6WgYdJdIvehJ9CD0H5f5Z9qtbUwYA3HInTiujLW8prZFeyw7Rlprti0d0CNz
 V2pIPzBHTXlfn9BCPrhNetG0Hca8sd5uOG22eZBS38nosLBN1X7Nqm63+ahXyx5QAKV9 /Q== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y0wwtg98j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 May 2024 13:50:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 449CH69Z035529;
	Thu, 9 May 2024 13:50:51 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfquc8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 09 May 2024 13:50:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G09Pws0CRXtswB/3kB+o/1qoEyNc1zryPpsnKyG4CpwSQkH7emzDsVXjV/IDI5+yYMfpqbnb+7GpTrPYoDjyoynDVyFg4/QrSSKJngpYR2WnTHw8pMhgLJHmSL7pg5Ggzjsfd0t+MbpU3JNmUrxPOacCGHrEOLnkm9sOdx9vHamSLIqjOEn2+seDFTBkZh2lf9O5BtFjNWD0WpiREerJ/pTH4rS4Rmo4gZ9fsY0ox7n6QlfKs5pmsN0Wiv61yS9i5Fd8P/g8axFjyhyBHxouxX8J6FkpQ0drOfsSh9+net7Rz9t338Ad3G/ubbcmRWuVofR/q4iYxpBT1WrLeN7azg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uLaYdosUbKTE0HEP2I4x+m1nvQ56cKLa0/jjdfYtVnw=;
 b=TCb0t3tOwrE465oKoOm5ADOKCD/Oog5bHgH7Z0ipFTKkogaXi4r7JlbCkaGgMvdJpGVXyhMOyLR7zpYLenBU6tQjklbTs0Sjt8CkuX2C5kir+5QIwI9xGPi+PxLvibWIwzhXbj+bRkxy0s/b//1DH8ugJLmTp26IoY8cHN2kRgJiZ0uKUzTFJt5bb2wJWZ/F5q63n04/l66yjmsIWYerbCuh3LLBUVYX+SoqxLFoAF3AYqNclAjRkXrjGKTVxMp15MWtxRpxiwSFm8Zwfvn/WcrRGLnWHfOcf+q7dwO520bErYdBSfcGG4b5EHU0OFZSjXbQX7STOahG+hM56a33iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uLaYdosUbKTE0HEP2I4x+m1nvQ56cKLa0/jjdfYtVnw=;
 b=aFk6Y6Gf3uacfnjVgB/yuRiYdckCWHh26Zf5L1UjxfmPXvvbBmrNc/sBbYBQKJlNHPVfEeRmIcvRtS9VnquPpTQ5r4QbITeR9xnY0vIHz44zxP/Jx2La4v4qsHuOYGHAQprTMPZk0fkAuCSD7A9XnJcK6vqNaACwtklIUH6uL3E=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM6PR10MB4395.namprd10.prod.outlook.com (2603:10b6:5:211::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Thu, 9 May
 2024 13:50:48 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.7544.047; Thu, 9 May 2024
 13:50:48 +0000
Message-ID: <4bc6ab52-31b0-4e1c-96d1-2568a43af7b5@oracle.com>
Date: Thu, 9 May 2024 14:50:44 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: work around sparse in queue_limits_commit_update
To: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk, linux-block@vger.kernel.org
References: <20240405085018.243260-1-hch@lst.de>
 <65a7c6b1-ad4e-4b27-b8b1-44d94a66bf7a@oracle.com>
 <20240405143856.GA6008@lst.de>
 <343cc769-b318-4c2d-b08a-0bc752f41f78@oracle.com>
 <20240405171330.GA16914@lst.de>
 <293dbd7b-9955-48f4-9eb4-87db1ec9335a@oracle.com>
 <20240509125856.GB12191@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240509125856.GB12191@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0071.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::35) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM6PR10MB4395:EE_
X-MS-Office365-Filtering-Correlation-Id: cc5db009-c108-4207-3aec-08dc702f0831
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?MFBiTFN6VzR2UXQzRERtTmN5V1A4TzY0V2V2M0swM1RVUDNBNUFRejllZEQw?=
 =?utf-8?B?M1RWdmJGL1hxdVFoNS9Pbm1hQ0pnUUphSnRvZnlJYXFiWW1aWXVNSEh2dlhJ?=
 =?utf-8?B?RExTTHpaYXU5ajFUNlloL1ZwcUZ0b2NOaGNpT2F5RzZNckVvTHJ6RXBXMlV3?=
 =?utf-8?B?TUR1WkxPREtTN1dtT21kVTBOZEpqZmREZ2RHOERaRTJJZ004dGhVeStzVS9i?=
 =?utf-8?B?V0xjWEdhRWR5cnhrc2thTGlEWGt2Y082OWZ3K2tQQWJKNm1Xa0pWdHBtMVNz?=
 =?utf-8?B?RVEzaklSUDB6dWpLTmlPd3BCOU1welc4U2Vnb3RHNGxrYzZYbk4ybStoNjdQ?=
 =?utf-8?B?bDd5dnovRCtqanFzSktTR3pvMHlMT01mUGN4b2NISWtaZFNiUWNpMll3RkxL?=
 =?utf-8?B?aERTdFprcy9oQXBqOThmb2ZZMm1YR0UzV3lIMFdZY0toZXRyeWxBdWVVR0ZZ?=
 =?utf-8?B?QVk2NHlCdjdCajZwaUZScWVEaTZzVE9XS3B0azBzMG15c2VNUzhoYWJ6dk5z?=
 =?utf-8?B?bnZrZGlKUFdvdFE2cXBKWmR2ZXBOSzVicEFoSlAzbGpNSWdEUU4waWlhNnF0?=
 =?utf-8?B?Y0diaUE3cWlWWGUwVE9RTXd4bmo5cTZFWnRIK2lpWW5rd3hHTHZLRDF0bHVO?=
 =?utf-8?B?UjBBU2g4ZnpxbUFaQnN5KzF4YldxQlRidEFFRnlLSFdSZDltQUpycmZ0OW5B?=
 =?utf-8?B?MFM5dit2OURKcFUyanAvT0g2bldTczljZDVyTWcxUU9BbjhqNXNJQkE2Ui9U?=
 =?utf-8?B?NHdHMlRmaDM0WHB5WElvZU5oTUZGRGFyYjZwZENNVGhacnV1alUwdk13RTVl?=
 =?utf-8?B?VFBoSVUrUUNVd3N3cU5hZUMvTEpoUFpDUFhGVjFiWVJrRzJqTjAvUXFEdWJN?=
 =?utf-8?B?c0ZIMWJ5eFFsb1VIeWxROE1FK21PZzVHYnRDT2s1R1JjTk1kd0dNUUJWVms4?=
 =?utf-8?B?SXhLZUsxVU9WODlCOEptd3dQUjFlZjcxbGcrWVJHVkw4N3FtNXRBcjZyWXMy?=
 =?utf-8?B?cGMySnJ5RGFzUnBiRGRVWFo1VjVkbTh0QXJ4Q3BrM3BuZDNzSDlkcGR4aWor?=
 =?utf-8?B?TFBScUxTeUtGVTZHd3NiTDc2Skw3d1NqQnk2RDA5WVlLOE1jejB4ejdhOXgw?=
 =?utf-8?B?K2VxRy9GQ29iK0pERU5EMEZuUHdQRFNZRnM1aGlMa2Z2azFBUzdPbFJQMCtL?=
 =?utf-8?B?bVQ4aTl4aGpoRE9ZSkdHU3Brd2N3R0d6N3Q0VUxLa0d2YldXQlZVT05DVXU5?=
 =?utf-8?B?WkFDT2IzMitiSkhHakVualU1VHVTV3MzN1ZhZWkwODNXUDFQNTRNWGxqaXkr?=
 =?utf-8?B?TWp5Yk1uQU5DbEJCUjF1eC9PZElKRFZNMk1mUWlSUHZvbWsvRWRhMjExRUNI?=
 =?utf-8?B?MGNLcVpud2N6UVJzSWF6dUQ2N0JiR1dJMzZPVEJPekU0bFRsN2JvckRuTThJ?=
 =?utf-8?B?S1EydlZndU41RHljdjNWVWZncnhNakt4NkM5cnBTbTJ0eGVhOHoxTjlsaVhG?=
 =?utf-8?B?Vzh3S1JWRDRhMVVPaFJRUFVaU0NXYkhGaHdDZW5LdXNmRU1aVWlvYm9zeDlt?=
 =?utf-8?B?ejNJM251Rk1rN0wvd2R2QzV0TytURG5Eb3MzdW15cUdkL1JlZzgvSDlhb3BI?=
 =?utf-8?B?VFRYNkkreUw0YXZqUmg4NUFMVkI4WXJWY1ozVjhYekNOUTgvZy9uVE1lZFZF?=
 =?utf-8?B?dUNtd2J3a2E0ZURsSFEwWStBMmdnODk3Ri8yZytlMEVqckg0d3dMYjRBPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?R3lkNitvVVlka0pRNGxCZlE0dWVBZjA5VWNBejNsbEk5dkx0cEFZMkRKbGw2?=
 =?utf-8?B?NHFrWmZyRkE3VTJObktjaGxBUlpCQ096MkhOaGw4YmdHelNES0pyOE44amZF?=
 =?utf-8?B?ZXcvQjdYWUw3ZEFuNUdvZ28xd0pxYUZRbUtZVjUzdFJBdHlGanllUjI2UkJ5?=
 =?utf-8?B?MWVWME5WVUVsMzFvUVM2dTVyRmdHczhTdFJVWERDa2IrL0xLa1pTMVlvbmxX?=
 =?utf-8?B?TFRLbVJNV2FxWUxIeXJtTlJrbldYMHlGY0tUR3JBMG9UZVE3empBUCtCcFVt?=
 =?utf-8?B?YkFvOEViY0RldytyYVNIdGlPcFVWVFFETnM4N3B4dk9IQVhQL0RMMEJzNy9u?=
 =?utf-8?B?dlV1dWQ4Y2VFQ0ZBVUJnVUx2S1paNi9xNjczYWtvbFUvS0J5TDBlV0NrSjdm?=
 =?utf-8?B?R0U0bGdKREtuSkZZV2R1SVhyWlgwRktYS3ZJd01aVEJjZzgwY0k1SVVtLzdH?=
 =?utf-8?B?TjhlY1dRZGQrTWdDRXQ3WkZBd09CMUV1QW5abFhoV2svSW9XWWlSZVdBRHNF?=
 =?utf-8?B?OFUzOHZoekJkNm9IZWtTZHdwY0xQelgrN05qZktKUXlNNlFrbHB6ZG1kcnFK?=
 =?utf-8?B?dDlJMHJhQmZkTlVTcTR6eGRoRVl6Y05ubFZWdXBOOC9xVDEyUWV2aGgwR1Bk?=
 =?utf-8?B?M2ZBOWJVd1RpVnBKZi81NTl5VHVacFZkNGd1bEFTeDB5NGw3RTlIT2xRY2pD?=
 =?utf-8?B?QmlZdzVNZjV3cEdxNDZwVCsyNE1hL2J6MW94WTlFTUdRdTllbllxcjVLRjJ4?=
 =?utf-8?B?ZDA3L1hyb1FiRW5aaWh6S0JvNGIwWWFZWmVuWnU0bEVCa2xjL2h0OHRzV2Rt?=
 =?utf-8?B?eTZaS0hFNFZKVnZETHNENGI3aHo2QjVVSCt3ekh2ek1vVTAyNG01T2ZNQnZV?=
 =?utf-8?B?VjdZd1RQdDZlWkxxNUxMMXczd2cxdjdQMW9pV2VJajRRYVBGcXRZVjNRQXkz?=
 =?utf-8?B?VGVjMmFNTDNDMFo1amd2VjFKbW9UT0JZNlg5eXM0UUJWTnBYcVh1VXVNN3lU?=
 =?utf-8?B?bmpjYS83a0hQdWFOS0NqRjFlWGlHTG5yZXJnWkNDRFJrS3pGQkpPNjRnek9k?=
 =?utf-8?B?NWo2c0lCK0gwcUx0UUl0eWoydlFaZ0U3REYzZFVGNDdMaGJvZE9HczhxdHV5?=
 =?utf-8?B?UitYMHA1TnVjYWo2NUhyc1hvcGVtTjFwT3RHNmxuN2UyWW8wOWlsbEUwbVpR?=
 =?utf-8?B?OXpheVFSY3FKY3FOTGZYN2drN0dpNFd4eHI1S2d5NHJzeDMxb1NGbXByRHNH?=
 =?utf-8?B?ZXB5THJVK1dObW16MFFiOEpHQm1mVHFFV3IrRXovVXNMRE5kUm1pZm9pMjhl?=
 =?utf-8?B?K1J6ZUEvNzMyNGVsaDVCVk9GeFRpMGpmNkhqeFVvYlF3bTNBRE0xYU5BQ0ZQ?=
 =?utf-8?B?bGMzQmQ5cW4rbGk2dzJ4dUJqWGlBNVdVVHkwZ1lSdjVCSkdJZlFIYTdIaEpQ?=
 =?utf-8?B?VFprbWpLTUR4TE5NNVhKK3ZqVzBZTzhMMURmRzR4N21pR2tZQklsT0orblF0?=
 =?utf-8?B?VC9JM1FUcjE2VHo1WjB3T2NvN0J5MkhVeU0yUEpwUHB1OWtncWFON3F1UCth?=
 =?utf-8?B?UitUcXNCYWNYaENWaDRpZGFnUmc5YzhLNVQ4azZCbElBSy91YlB1ejVaVDFz?=
 =?utf-8?B?NFNMekJ1MWJ5RisxQThEeFFlOHZSVlZ2SUNQV2c3SGxoQThocDNKNGJGdmlW?=
 =?utf-8?B?b3BBWWY4N0tWb1pndGxkekp2a2I3SzBpa1BmWHJsWFRXQm1SRGVhYUd6ZHRE?=
 =?utf-8?B?R2llMFZlNTN0NkwwQ3JaTVFlYkhTbmF6ZXNsT08xejZER0tvNmw1elF4NkJm?=
 =?utf-8?B?ZmVtWWlmY1J4K05FQ2g4ejdwN2d3bzBEVFJsZTNGRVhOcGpKZlh4NmtMZ2Fq?=
 =?utf-8?B?bS9KTGJwQXlwNUFXNXMzNkRHVjI3YWJXbktFdnNCeGJIZHNUVEZqWG5XYW5r?=
 =?utf-8?B?OXg2TVRRNk0zRE05QzNKMHo4SnZ5VUVGU2pKZVR4NzFKa1hXUjllSVduMXVV?=
 =?utf-8?B?bjZicXZ0ME9xemtlYWJpWENzVVNKU3IyeUZ1dlB0L0M1YzlVY3pPTzk3eUg2?=
 =?utf-8?B?ZjBDL3lQeUxpZkFMZUorRkw0cXc2cHJacHZiRHpjdk11WlFyRDdiM1M1REpY?=
 =?utf-8?B?aXNTV0RuR1psdk1rZ3JmWm1BaTF4cUlQVjVYcU9OcjAzQ00rRmI0R25IUjFP?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	erYBHsMHvMbIa7jFymu1imdrjRVUpCE7D1XXVa57cVluK9rVcbAVmYoKaV63cjZBp8GJSNIHP4lHqtPS5DoH4hs8kaj0s+KumWzfAqUQ1c9LmSxDiF08X+61UbaHKA8xOd24RcSIDbOVfTjv/vJvlEI4dpCc0S5J6H7cYHBdL8OYwd3vd3TBoz4AujAkqv9l5j2bnIbpzPHAYm49T7FaV8qp8/ZObNmWxAkK3J41YezI+NWpGyIuQmxnq9V3MtitRGMXgSjmB+u3KOrHo4fj7xg3hjx9mhLr99THjjgtcjHuFSgPfAcEKSNOZVe1HlBhufKYGn3+7czxBKYsjqv1rC8nig6LQx2d5M+4cvfSWaceh5a1iturhDBO8Cj0h2Z/TzmSQeOzyxD+YP3ehySyjs8lSDTUoDAYNlHezeV6uRqjmc0wNpsMhW4Sblx/Et3o/Hdh37vOgGlmNGucKud4E5krX2WLuzM9HjFxD79WKKgiaCjoFmFAwZRdGNTrnS70kdZSbickShZp7nw/AR2iI4TVdk89MpEmpU3YiwisdNs+F9S/p1bQzLXK15r+yjnrtc+CDbwGHKiaafBvX2plT/wR6IraPEdRfoA4BU8ZBhk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc5db009-c108-4207-3aec-08dc702f0831
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2024 13:50:48.5535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 03V9rFDlPlqsyZebvfoV8uVxWB9pI0r/E2ZjU26iTiL8JX1arKkX05DlLV7NnQVobCQ45eaNhYt1XJo6qJXK7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4395
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-09_06,2024-05-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 adultscore=0 mlxlogscore=852 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405090092
X-Proofpoint-ORIG-GUID: KbtXlfvIIs75-360JjI9Sxb0WJcjzOxK
X-Proofpoint-GUID: KbtXlfvIIs75-360JjI9Sxb0WJcjzOxK

On 09/05/2024 13:58, Christoph Hellwig wrote:
>> A reminder on this one.
>>
>> I can send a patch if you like.
> Yes, please.

ok, fine.

But, uggh, now I see more C=1 warnings on Jens' 6.9 branch. It's quite 
late to be sending fixes for those (for 6.9)...

I'll send then anyway.
