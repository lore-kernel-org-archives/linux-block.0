Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C7D32E134
	for <linux-block@vger.kernel.org>; Thu, 15 Jan 2026 08:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768464741; cv=fail; b=s5Dks7xKlsqAwu43igncMtkNhlE8wkwB5D0lPEmMJqlo+BYJkFxPxVHA9+kAmTIMr8qBiwzIZLbGe7wbn1Oq9TLDn7iPwdDwF65HnihYFMXMtVAqDU2Jg+kjtl+EBua/tnGgItpu1w4FK5sShQOiG81vNsgXcKnOT38S7y6O2iI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768464741; c=relaxed/simple;
	bh=pQXzDjU7hmYvYOEMdQInlj6nvi+32trWFM2i3dWwO74=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cI6NADaT9uQ19dgJ4PilZnbDzBYyaPP7JZwenPerxpmLN7kCFvUrIkoFROCVZAvSCDG9HXa6KMMDf7EV2DowbZBfMnJSFmUFvOTnWo9RFOdAn6f5k71iZd/B+hXc6uFTma23WMfIe60apmsh6JxI1YHOjmosPvORk93y/ZQ3B9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=F4f2EgWz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=T9mzjyxJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="F4f2EgWz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="T9mzjyxJ"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60F5TNvL1362590;
	Thu, 15 Jan 2026 08:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=CsDmC7YEEuGC376PQdjytJ8fV7Adah/UkREPFY00bkc=; b=
	F4f2EgWzt5asTM20CHtYwt/np+LsCO2PyQ13j/qaAPI4QpZyQ+QLAjoxMJ7Q/450
	GFf7BO+3zEppyYsZKgz9nl7zQ14cCwoEIcDHNQl+BlkkL2dv27ARFNtfNoZHGr0D
	rPosBHA+YrQfBFmyRUoH0j1zoO4tbtTNIyPe3L3jacXfTY/Vz7oKcZEcIfMx7Kww
	ivsZWNjVqQhfJtZij4kp8MZbc7A11y0sVYK3LOpqD3ur92aPx31WIPONRM3WOkWy
	hMsoRJgLH+sFv4t1wkcSJpVEruOW6GmLqYNyXytEcKAA6E4nVWqHqWqA20y34P0f
	/IleiCy8YYY+TTX82kIUGQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bp5vp26jy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Jan 2026 08:12:02 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60F5Psc1011825;
	Thu, 15 Jan 2026 08:12:01 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012008.outbound.protection.outlook.com [40.107.209.8])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7b2c79-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Jan 2026 08:12:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DozkJ0umLMUQoR6RXaTrHb5lQE2UqlNjmhCoSyJI7YCy3mpLYicbxKJ5L1ZACgguZFt0WX2bAEbb6PJ5elE6UTdCD/bOkFMJC8aglOffo/SRghH7VpFuNpR9bONi+CJqmtvnoqcshCqtkC8oZohwPsWBM32y/2IxSIMGjAkL5SIqdpH/aCI6rhZS6YFlZWZ6dbve9LDGU3LPtYn0xt8QfvmpVzTkYCLKsolyKvKcAnlhMJEXLQgkEH2r5kaFQiuXywMr5bAalQC/kQgFVKj9E78ZDGdxC+7mEo6ceZlwsUGptchXEkDlgGzvPE9IseFStEG/eGYNWev9GiEXR8PN7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CsDmC7YEEuGC376PQdjytJ8fV7Adah/UkREPFY00bkc=;
 b=smIzPaJ3e+6sBXc3CT4iOKYYaLDQ+ryxKZnqNXDNG85OBI/1XAX0dvzzXBdmoUnSmhY+OaywkEchvnvY5dvR+ZquwFUnPbo8O0QuRPlXk0FYJWI7um1xWw+C1MJE1xnXHR+WfnBcqTdekzLds+NxRPSO+j2SZ2zsf588qN6v6PTH+4WEhdosKR/EwF26sCumh5BXmP1T1k+9O3FNtaC9QNzAg6t381rwmXRc0r4suMaOvnX+Ptl7Fuvqy1i2OFlMfqKmatuTkBKXC9nOdTA8200zAWfKzRfIMLV3lypbrCNs94rnNBnhCA3hby+/k618sejWeOOqtRDSmFV4O6Z+vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CsDmC7YEEuGC376PQdjytJ8fV7Adah/UkREPFY00bkc=;
 b=T9mzjyxJBachbD8dgEr6TJPcdw2PxsPZ9XTmjvPO7K7N35j50EJHOKPnetOO94Tuo3Nw5yizvMZ6uS2oz2t2yXwlRRqhgoFhO5lUPfhmQCcuJATSpmn6paPLgsxww5t4bC1ACdKQDrMvJs+Iu2ZQIRAKpjAWSWgHt2udCWE1idw=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by DS4PPF80FDA9397.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d2f) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 08:11:59 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%8]) with mapi id 15.20.9520.005; Thu, 15 Jan 2026
 08:11:59 +0000
Message-ID: <1eeca326-9403-4483-8b03-36621e79db81@oracle.com>
Date: Thu, 15 Jan 2026 08:11:56 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: Annotate the queue limits functions
To: Christoph Hellwig <hch@lst.de>, Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Damien Le Moal <dlemoal@kernel.org>
References: <20260114192803.4171847-1-bvanassche@acm.org>
 <20260114192803.4171847-2-bvanassche@acm.org> <20260115062613.GA9542@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260115062613.GA9542@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0545.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::13) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|DS4PPF80FDA9397:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a99560-1a0c-4a72-de8b-08de540dc1a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WFhZQk5WYVlxdkNmWGx1K3hYMExXOVNWaFBxbjFVeEltMHZLRlBaa3hPdFR4?=
 =?utf-8?B?aHJLaEkzSGQ5cXZkeldYU0EvZXo0bE5jZ2t5UlJWWS8wVVZxOTVuZFJuZmUx?=
 =?utf-8?B?ZVVUZTZBb0ZCTm9wR3BwUUl3aVorVmFkbkxDM0psL2FEYXd2ZExESzlobm1R?=
 =?utf-8?B?QkFhY3NaRlhOMXdBZzNIZk5KUDBMczNuQmdHWEFIR20vaHAxUlBqbHg2VlZX?=
 =?utf-8?B?RlkwZUZ1MThMS1JoSWpkQkNiRGxMWlNMNlAveG1EcmRHYkhwWHF1YVhITG1u?=
 =?utf-8?B?UTZpUjdVdE1oOEhHQXlYZzBxeTFpcTdscERGc29ZODNNbjlrQXFZZmVKSko2?=
 =?utf-8?B?LzhvN2tCbmQ4eEhxay9vU1JaVmZNVUFJQVIzZk1PazFkelNqUVRrY2hBNUtR?=
 =?utf-8?B?WEVITUw5RDREbUZ5dkZnemVvb2x4V0hHemhhSG04QXhFajI0Q2hVeVMrWEE0?=
 =?utf-8?B?VHNWRlNvNXpXNHdoUGJPY0tKeHhlcXFIeVFrUnk3RXQ0czMzMG5aMDZlTm8v?=
 =?utf-8?B?UFJCd1JEdzRyK2dGRzlNa3VZbVVPKytVRXVHYzl6SWE2a2gyQW9RTHZCNFZL?=
 =?utf-8?B?bEFncGZpTUpNbW15OE9Qa1NITmtqZzEvTHVUTEJtNnRzRlZnaWhCdDk1UGgy?=
 =?utf-8?B?YjBHbEpZb3c2b1lqUHByeGQyNmFHUFFzZlFLUnNrQy90NTZ2QlpNV3p1amEw?=
 =?utf-8?B?MEpCZHZ0SnJxZjM5MGVMNFJvcURQaHo5cjFXeTVCY1dLV2FGMEFKdTd2WTF1?=
 =?utf-8?B?NzRLTk90N05KUCtZNStpbEd1SG5ZUzlTNmI5TG96NUNBeDl0eWVLWklxaU1w?=
 =?utf-8?B?T0dsNFNPTVNVMy84Z1p0NEVneWllc0NkNkRsSWF2aFUyamVCOTNSQUY4Zmxi?=
 =?utf-8?B?Q2NiSGc4VFNyRG1yL2lRSjZnN3hoMHhQM25YMEZkR0Y3RkVuazA1Njc4SjFT?=
 =?utf-8?B?QnBZU0g2OFoyU1pqUk5NcmRpbHJsa3c4T0ZqUXFMcHY5SXUrOExYdjVEbUNG?=
 =?utf-8?B?WjlrK1doVE1iaWgyZFdoR2M4L0h3Q2pxWlluTnIzbU1IOVA3QmdHUnpSVmFx?=
 =?utf-8?B?T3Y0TUJCeFZaZjhvUVpHVnRmb0JlRmxWcXJ0WEgxS1ZnQlNQbCtjZU00bEZH?=
 =?utf-8?B?RUhRejhZbTg5VGFsNWRvM3grdGpNc1MzOUVnTlJram4zU0YrTzd0ZjRRVU8x?=
 =?utf-8?B?c1VaT0xyRkJpSTNQNnNDMWNCQ1BTaU02Zk1BbHI0eTZmVCs0S09SMUJrRTVz?=
 =?utf-8?B?bitqd2lVNmQwNlRENUd4QWVjYXZhSGlkbU5rd0Z5RDBMYU5RMEh2ZFJGWVp4?=
 =?utf-8?B?Z3ZBbVVMSTIxbTd1TUlRZ29lN0xqWWI5RkpPays3UWNycERaQkJrZmhXcCt1?=
 =?utf-8?B?U3hjZ0JWS3FiRmMvYlQ1dVlJa2FDMWpxZ1VidWQ1Wnp2NTZTZzlJNnVOK2V1?=
 =?utf-8?B?dm9vRmtFTmJhZ1dUOXJuNUVBVVNKY21CVkVDQzl5dzUxK3NwT2Izb0I5aGlU?=
 =?utf-8?B?QVhxT0dPdk4zNEVYcG9MZjk3bFFYZ0xNWXJwMnRhTmxjWm16bnRxdDIvUHQ5?=
 =?utf-8?B?WGtFQnkyelhYUWd3YWpnUWJ6dmo1NWtmZEVIOW5KRDNiRnJ0aklieVhLb3JJ?=
 =?utf-8?B?aVE5ZU41VTczVUg4d29tL1pqRmRsUmVoaUxDdjY3Nmg3M2dmNmlHaWo1eFA0?=
 =?utf-8?B?UHVQUFY2OFY5M1lTY3J0b3NJOVEvT0N3VGtsUkwwTGdOY3FMbVZmQVh4cHUx?=
 =?utf-8?B?Um4rdVV5azdHMUV4L2pSM3MzVDdQL245cThhUEtyUjhkMm9PdUdoS09vZ0tl?=
 =?utf-8?B?TFczWDRYbkJCUGtaK0dHNllaMkpTUVJZQWVha2t1U3hlanVPbGpQS0ZkYjQ2?=
 =?utf-8?B?OW9meC9FS0JDazE2VTFwQVJpY1BmQ21zOGRVTlFTVnNRTUQxRGkvOWRQTGVu?=
 =?utf-8?B?ZFlVUGtidjRiZjE4OXFqd2w3RlBVTXB2TlA5RDFQWE1SRGMrYzVnQ0dzYWVp?=
 =?utf-8?B?Z2hQUktmZkVzUXppUnFtYVJwVmdRekpjd3lJVUFhUy9iVFFxOENBUmVkczY0?=
 =?utf-8?B?dFh3bFhiUGxjbmtyaGxBYVI2QWJpUHVaQUorMFhGbzFOa21Wc3k5N25EbFhP?=
 =?utf-8?Q?i0ak=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUNydm1kOHRKL2wwZ3Q3Q0VzY3VzN2srUjNaRk1lUUlLcjlQNXpNV1ErVmRo?=
 =?utf-8?B?Y1h0dEg2c3hES3RLMUtpUGJTWHg3aFZUVnYybmZXZnZidSt2akVQZkhhaEs2?=
 =?utf-8?B?RWdxRnl5TTNYb2ZkcTFnSHZ4M1VFVXZIanE2RkRNN1IrTDI0YXJiYkl6ZnNV?=
 =?utf-8?B?K2MxVEF5NUpEVktldmh2ZTdtdVhJMndpdGFpbnN6dzdLUmR0ODkxTG9Ydjk2?=
 =?utf-8?B?bSs3M0dwbk5FSHVjNjZYbGxRVXpUQmpLV21IWkNtMzBoV0JIaDUxeE9DTC9N?=
 =?utf-8?B?SVpEQ1g0YmtSTjhDQXlId1d0ZEtwNjVvcE1FRmxraW1XWkRsUkVkTDJDV3hw?=
 =?utf-8?B?YXZJTktMbVVFbmtjRWFyZnZpZE9EYWxieUdUdjBFVld4REZQdmRhVWQvREM2?=
 =?utf-8?B?WUFQZUgzWE8wank2a0NseVhRS016NWY0WU1UK1oxUzc5VmpJQTNmY0ZFenc5?=
 =?utf-8?B?SlhhSWh4NUR4WmxJakloYTd2YXNiZ3dtb3hEbDNhM3lreGRxWDB1VkpLdE9m?=
 =?utf-8?B?SG1sZEYwd01WOC9KQ253UWlHUHhLM1VZMlA2VEl3TkkrbXd2d2tZV2ZPaDhV?=
 =?utf-8?B?TDM1QTFjWTRXeHVQWkJuQ3ZUZVB2Y2t6dnE1MFVxZW02K21RSmkxV1ZDVHVV?=
 =?utf-8?B?U2I4K3V4Yy8vQld2c2lRaXNSZEJrV1VIdlJiNWU3amoraW8xRFBEVXNyQllr?=
 =?utf-8?B?ejh0dlM5OXhIc1NSSEFMMCtsWDVRUE1tejl3Zy9mU2YwTCthbERkNkt6S0dU?=
 =?utf-8?B?czNpaEZVN2F1WVp4WkhQQW1pcHAwZG9GR0llYjNaNy9vNkpnMHpHL0x4Smxx?=
 =?utf-8?B?SU9mNy9ZVVcxdHBIUVpGTyt4cHc1MnZ4aUcwQ2ZGTnZpRHdDV3FIOGJqTVJX?=
 =?utf-8?B?bnhsN0liZkFJR05VMTQ2T0RQQmMrVjhwYnpud1NoaHV3TkcybGI1ZGxRVFdv?=
 =?utf-8?B?cGZBYzVUcy9ySkg2SFNOQTJ4clV6NHZJblFxU3kwaE8vY0VIUEw2bEhkQWVz?=
 =?utf-8?B?ZkhHOHF6R3JzNnYzWFdQcHcxdTE0TWoxb0dUUEFIajJXQ0FLdkxxV243Nmhh?=
 =?utf-8?B?VEw2ZS9yb2ZzZU1VdHFKOFBpeVI1YXlhNjJtbVhWUTM2QWMwcGczei9CaVlk?=
 =?utf-8?B?cXJlRW9NT3lwTE80dHAzYUtQN2ljZTkxZTJuUHZWK2FwdzlFUjhPQWZYOTEw?=
 =?utf-8?B?L1E2S1lyUjJjeUoyWWlOU0pueHhKR1I0U2cxanQ1dDhIWFlock85VUc2SVNl?=
 =?utf-8?B?ei9MekdKMmc5OTV1S2QwWTIrbGxRSStMdXRnOXJzZ0pKL1BoaGova21DSWlh?=
 =?utf-8?B?NHg0YTlKVmZ5bnA1Y0tidFcxbEdIbXovTGlSVTBSWVdCSHhXMXRQa3lJbkpH?=
 =?utf-8?B?WGhQMmZqWVYxWFNmdXZPT3pQZkx4elMvSlVGRXUySzVDcWRac2FOTTdlUzBr?=
 =?utf-8?B?c0ZSTThtZXpDQjBleWt2TGEvdG84UnQydmRLZzdzTHEwSnF2SFp0bzI4Qk1E?=
 =?utf-8?B?Lzh4SEQwOWM4a1ZyaENPVWV4ZUxndlhIN0tiMmZ1T0lJVDdXbC93TVFmMmR2?=
 =?utf-8?B?QlBiaGExT2dpN3ZMZlo1M1FFQWo5ZzFDQTJDN0tzNlZQQVdJMEJIL2VqUWhT?=
 =?utf-8?B?eDN6R00zMWNpSzEzaUZ6cmVDdkxzTGQxNHhDUmZWMmcxSzNrUUZtSkh1eGwr?=
 =?utf-8?B?d0QrQzVWOWhsNXM3Ym1EUFc0Ny9UdVpiL3FxOHNTVlBvRFN4bzBieGpqZDhW?=
 =?utf-8?B?dTBRMm16N0ZCNlBtMkNIb2VSSFd3MlhsZ2tTNXhuYzlYOTN6NTl3Zk9NYzYv?=
 =?utf-8?B?eWhHek9qZjYyNDJ5THVBdnd4WXZ1VWJ5cmJwVnczVWJIWThjNURONXNtZmhV?=
 =?utf-8?B?NVB1OHpDMU9JYkJvSmJ5TVZ4TEtTdS9PZ0lBM1BrMHh6aFNXbWR6UlFsRCt4?=
 =?utf-8?B?blJoUUhnTGxKNi91SUh1VGpia1RVUjJJT1Z1dklzL0FkbUM5VS8wOGo3RE92?=
 =?utf-8?B?RGdqUldCTVNwem90M0JYa1V1ZFlHTWNBTDM5S3pLVG1id0ZLRUV3Z1RWQ3JC?=
 =?utf-8?B?WExZVGhIL1ZxUEsrRnhCa1JtUVAwaUYvbVNnN3oyTXl3QThpNkZnMDRLcTFm?=
 =?utf-8?B?SVFDQVltQnhJSUJKcCtLdXdmajFiZVR0NHVLa2xCR1NsSXh2OERRbzBjTE42?=
 =?utf-8?B?QWd0Z0Ewc2xLdUVoZlE4NU1EVUJSeTdFdGo4d3VPb3U5aXk2alFWN2d5Uk10?=
 =?utf-8?B?NTg1WEdBM2dJQytqWmdRZW9DTXY4Rm9Hb014SXpvMG82TUR3UktDMm9ZelpF?=
 =?utf-8?B?YlJWMkZmSzVIOUpSbDJBd2xGUTRlTlowTXI3cEJSbzA1SmVxakZGQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	e3bPPYiYaX91MB7xEUGlvWKNGuNrMQyj+ysJ/+x2aTRBKw2BkS3DZQVXA+S1AWIyvKxqJ5HMu5YzP4KfoZS8ThIkvLY9PZfOMCUoO7xAA7dHsOU6UUfTB14hP5Ns1IGzdse9BSHwSd2uLLugRBIAIoCOpo5o6+dU3oF+htmgaMnkJNNkGQqUoKTCpMgwWDMeNMWomifcQ5cqPP/7O6NCVeNNJHD/IAC+Rx/yqpHjm2C16kjvHK2bcY5q6jnk9aNIxZowPgMau1sCHM5vX/vo89sMM6UsWyRcWnnG48No/AeRup3OBUq7ICZRH1QjvBw90LS81LM/bHTMZTsZe/V8onpupJClCu9KMI3HdcB1ad7Yajr0F8YI9LCDHYsktWYKPD2Or6p/lXaz4t2u+fbV7SEN97K1NiLOdDanYlGx0/oAzt1W5NzYlxOFAEUn7QvEfQWFDcddOZMS6FMOy8QCRGzN32+FfGFwIjQGZNEZ5N3nD85IIWDWHS9uu6Pw893uftWEKubePtVyk+/q33m9j4rGnexN78+zgbQJlYIl5HS3OUziis/h4PxTHYQkNhomryimolir6IpImOhQ6MWm4LSSMbiWy4Zee7iYBpNsoaE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a99560-1a0c-4a72-de8b-08de540dc1a0
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 08:11:59.5823
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6MpsYN7YPgR/SMtxKPHHkzmO2behdIOSGQdd7rNM3jBijGWWa/+hISADmyfyIP8tFHSFaK7ZhjhKG6rDM/NsgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF80FDA9397
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_02,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 mlxlogscore=760 adultscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601150055
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDA1NSBTYWx0ZWRfX1sh7GmdF44f8
 ZFdHk8jW3cZWUlYT1tcpXUoRPpJ80BBG/o/ww9newfxRT5XI1pLggEIzMi2mA2M9m8ApfR8b2S7
 dydz88lsulSh8ba4b6XG6kJAmOnrQnIphqoE7Si8jJL+Nbgjr44CI2SECeyqk5jnfQG9aZxMO9l
 2k+DQ1ZnkvB3ngYRLT16Fky1scnk5WLFUaCAwnhXY0sd55JpzHyrnW+UU5EJOLWCJAw15pn879G
 ZEYNzxHkhlFawDZS/tL5QdporeHUC1poqFh2Da8TmBPM7iPVppaVdWnyqygTUFha+30C8JNtAJD
 OdePbJE/5/1/p2kh3FEWSA94AtG2dKOg7FfpOQMRigTS6RtaUaSsENGdmJaJl7TCL+MUgGjvnfk
 LF7b2fTXHS4qdj+07GFyOBDU/LYg5N/D5Tcil4K8jvsbBkWMXonjVadn7QBN1t8zELEGzuORrMq
 z2/Z11+yD2xuRdAp0Dg==
X-Proofpoint-GUID: UqWktzgG92FjEA8d5w0vie7UnCKTOydc
X-Authority-Analysis: v=2.4 cv=aZtsXBot c=1 sm=1 tr=0 ts=6968a152 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Eyyq-92m0pXGp_0lqWAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: UqWktzgG92FjEA8d5w0vie7UnCKTOydc

On 15/01/2026 06:26, Christoph Hellwig wrote:
> This is missing a commit log.  And not really telling what kind
> of annotation you're adding.
> 
> 
And we removed these previously - see c3042a5403ef2.

Does sparse now handle mutexes?
