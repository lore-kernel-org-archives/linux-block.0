Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2269E3DA7F7
	for <linux-block@vger.kernel.org>; Tue, 31 Mar 2026 08:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774946669; cv=fail; b=WZkdCCxN4PauqFRQtd7rmt1equdJMlPt+n/ADMrl7VMo0UKQeZtGDvIbSzJQvKrYrhHES6+U0/6Z80jtQdRxAXkRMHl67nx1Z7IMTAhcMWccVnLZ2uT5nOW391z4K3IFVcLFdcwJPPngElL2nNkTC8M1QOGXZg0KMmRaxXLC4bM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774946669; c=relaxed/simple;
	bh=eI4rBYAZov2mAOGN+4IrGuBOh3Ry8Hm7DsuNuS92eD4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TcxzeVVrteZ8EyAF3evwnFVJKkotj9giTU4I0RjmLxF8+Mc94MB3zBZRr0knxqfy/CqaGY0dSMNgzL4Npd1xfNdeGKqVkBteDUkBY4J8iHcflNKyUp/xQ32XbRXLogydx3g0taLHkiRqYgH04IEDjL9Sq3vza/aw/qgUBOdDF8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=nBkfq0/4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TTkesrhM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="nBkfq0/4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TTkesrhM"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62V0cEaQ3173443;
	Tue, 31 Mar 2026 08:44:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qQPS8XMHujLRpslnj1dpsTxvUaE55pvc+LgpirBCWKY=; b=
	nBkfq0/4bwIrDDULgm+mi2I5tNvEorRlhQMHxZMhsSyC/deNMUHalwFyJ4xmHFCH
	epQpAyPVmj6GdHP8YpOI9sLAtdeoKxZOXh5v3HY4tG2FW4EEX4Hr7B7ExAbBuw/r
	DabQSvFlVdbmwcWAjJaT7s8frrpfUiyfD58BsWW7JxKgGbHyCuaWEiiCu9DHynhf
	BiYc61IBeuEoM8Rh0gs11SdsgFJ+ZhiemsqG7NjaN6g700QkgDSAUW7GL7bo0BpS
	S83zChwcrqWLmnQ1SeWRTxay3OPYGgBbCKfFsG8dPVGeRhWGeDSDo63W614N97xx
	7cY5DyitruBpJmiC64qEHA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4d65jwbsxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 08:44:13 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62V8Nlwa020545;
	Tue, 31 Mar 2026 08:44:12 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011057.outbound.protection.outlook.com [52.101.57.57])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4d65eg6dmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Mar 2026 08:44:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=StZzM/hEy8tCOK4w0dIokLGLmnGBlU0n1fWEo9Bv9CxxDmd5F+4QkkAxGgQbMJ1SEMAIWH5rU+le9BK4sc9tg3GG6f6FjOHXXlDyc6fgu5VO8fq88SpoBd96ARboPlC4yS53NyzBG9Ex8+RMIVqYP9uwPACxgMLwaewj7h9aum9MjYuOLqB+exQ5uW4wy2KgA8oNM1bD9OQu9IUZ07bT0JpwiVQgMj8QLUXskBCPGGkRvqDIADVLSe3OAgL63DAOrLIcZgJH5KDn3SUoGpM+wZqpjHBsJzWW1F1hJQbKfaDttH0zxWiQsSGq+unTmZIq4ntmfrciWG2yQmyUdmHFQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qQPS8XMHujLRpslnj1dpsTxvUaE55pvc+LgpirBCWKY=;
 b=fdASdpvpDhiRl2XEWphSJ+82qxE103NzYegSOIKteqDnRuY+TAvgh0Fn6gS1jiKCTqaJoQZNnNi9UtYwKWU5Ma3vUJkMrvimneFGc6H3oKH5N23OUF2nwYhQp0c7ZGhmKoZHE7T1e1L5HbZaTs4Ym4B4eUwrqY81RVs4vUhtorMxlDTK7s5CGznh+uY4idbiztk3drFcIX0BQLqGW5Ig+yliAco0vMSySco1zS5zkMNq061xVzT4t/8fA1Awqg209orJA8oAfkfg8IoJt+Jk92wiQEBin1jyL8wcE/TOC7DvNpPhj41YXU7id2Jnd8h4sobyY3inIxmpWEhd+LEVeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qQPS8XMHujLRpslnj1dpsTxvUaE55pvc+LgpirBCWKY=;
 b=TTkesrhM7aP2NYoQjx4rR+ThSW0h2v8S7cdmZWug7BdXMo4tSd6tFFCQ+k7IAkfJeNd580CTf5KHo7B1D5ABXIMQ3K+PHF+sRVwiqRrwAjvicY2WrsznWRb1BcxjGvX5LVE8aSIotA+/WjfyPugdqMvFt6TtU66zDwLLICFiXJ8=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by BN0PR10MB5048.namprd10.prod.outlook.com
 (2603:10b6:408:117::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.28; Tue, 31 Mar
 2026 08:44:10 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::5266:1601:5598:3f0a%5]) with mapi id 15.20.9745.027; Tue, 31 Mar 2026
 08:44:10 +0000
Message-ID: <513efc55-6df2-4fbf-821d-a1f320397a2a@oracle.com>
Date: Tue, 31 Mar 2026 09:44:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/6] scsi_debug: Support configuring the maximum
 segment size
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <dlemoal@kernel.org>, Ming Lei <ming.lei@redhat.com>,
        Doug Gilbert <dgilbert@interlog.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20260327211349.2239633-1-bvanassche@acm.org>
 <20260327211349.2239633-7-bvanassche@acm.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260327211349.2239633-7-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0030.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::10) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|BN0PR10MB5048:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ab9853-b99e-44c0-3683-08de8f01ad53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	bmwAIJFo/JMy8aPyjXapx4IH03lvWv4MR4KeMT8ng0gk12Dq8Sw09H4qwUxAEqYhR0C4iHFgH/BW+P0Nmox2vb01yjn3FcOXFlRZDihhj1KPW/JOkkLilY6RmIdu/WXm3KESVpGfqm9C9A0qjpoVCgHjNb/HTn1PiQ0DsBcfW0E/9yk/Ru0Fm8I+bptjhX/579MRuIqS4avKLzkRc7BSwT1MDOcxXfn42khQ3Dnk7/Fcgija3aHy90kpcmpx4UMdulaKY22SlQaoLQhuiBQbkZU+BTvTMuZE2tv/RHs3hVYSmIG8gtGiPvoVR5EtoaDvMlujsfurujZXwAbiQljegRV2qQoJtDUnFp2vVXKAzjhYOYAuXdV2s5TpLCE/CxAVAmgX78vvq1aTw+HRi/QZKh6flYdfJoI1uGXeC7KQ7xg2XS40Kdn2del180kmuu7rTJBJM5Thgith7nwPYKgIvySU1kubPA1ML2p9p0HNbPOSyuNGToL6P6VWRPS1Gqio6RdlDbLSjqJ33Wk6+tpnp+KM1/co9rsat6nYhVOj5F6ZiJ9juSp9xmPHrQLEgoeM4WbY7jsJ+Occh2VhTsgnyw9BB3dP21oZTJPs4RGM3g7nljFx2goq+Z8UNNuowiPCeUmTlEJ8w064juAutjmgh2YNE91Qf4xYtpVVed74xYqH7xQmcYJGTOLyjVbdfrmX3c2tdKl71uLdWr+bml/uUVk9iYvmTcQ4VifV/rO7hd0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bmxDanJZcXdVeldQNGMyVEhBTWxlNWVMa2g3R0haSEM0K1pxZUhTZk9nNFY0?=
 =?utf-8?B?UXVkaGk5OURsS1Z1bUE3SDF2OU1POHUvZ3A1cnF6dFlsWWtkaXBrTDRsdVNF?=
 =?utf-8?B?QXNYQlkzQ2lYVFZqak5oT1g3UHZKVkZxSzZVTm90TUV1Y0p5Tk5oSm80WU8z?=
 =?utf-8?B?QUI5endSYlAwZFJLenpid3Q4ekNLY09rMnAwdytNOW9jUEQyMzdsYzhVYXRS?=
 =?utf-8?B?eDRLemRnYnJPcXk0bjcvcS9WbEI2eXgvdnNwWmZ4UEpXV21UNFJXQ3FBWkQ3?=
 =?utf-8?B?TGRHeFNjRmdjdWJiZmJEVWNRS0UwblJ1cjJlZXF6WmFWWHc0Y0pXZ1ZoVEha?=
 =?utf-8?B?a0lvaWh3Q3dVYnNBRVBjcjRtZWhETGkwaU1XTTNxNFJmZFlQZUR3Uytma0h6?=
 =?utf-8?B?K01icDhMbG9FcG5YMTNNSEExaW1LMndlR01DazZ4M0lwZzIvUmorV1MvcDlL?=
 =?utf-8?B?ZnBpNHM2anZNV2hLVEFUUU9HMFpzVllCbU9pZ2FQKytnQmo1aVhrRVovWjdP?=
 =?utf-8?B?U1pJZHE5MjhnNVNtbitHOEo0MzJKNGF4NjdSSDBIajZHU1ZUbHJSWEk0cXRW?=
 =?utf-8?B?REdNa0ZhUERSZWZyNHllZVQva25QbzdJY2NZbzJ1R0hGcGNhZ0EwRUtqWWVU?=
 =?utf-8?B?OGd1cU9ZbGdTWStnQVhZWmZJZjA2ODl1NmZINjlaOUpCTmJyYjBZdjZlSTE2?=
 =?utf-8?B?QnBmQkV3dFcvMmdNWVdoUURTQVBFVTRnMGk5ZXBGejB5MFY5a1RBMjFyTEVC?=
 =?utf-8?B?MzJlVlNVZ0M1ak5tN1l2cXJpK1A3SUdqdU5yRnZRUHZNWW1lZVUzcHBzMjc4?=
 =?utf-8?B?MW95dTF5L0dVbHpRVHdSZTNnRmsrM1JrekZQZ1JRcy9WUk5ac1p6SWFDV0hT?=
 =?utf-8?B?U2I2cFNGaW1IcjE2alhnME13UXpxdUtrWXpFM29jMkR1ak53TzVWREVyNkMr?=
 =?utf-8?B?d0NQdWEwVDU3U09BWWZ0QnBaK0VsR2dxa0lNKzNyVXYrZ01ZYWxYV2ZnNDl2?=
 =?utf-8?B?ZjZPNXJBcm9IQ3R3eHN5NU9PbEpJZk1DMVJXN3hwT3NpOHUzbnZHRmFNT1E0?=
 =?utf-8?B?anN6cWVFTXBQdVptMGhYVVluc2lzUWdSWFdHN1paY2tvSWNIdE11WmZZWW9L?=
 =?utf-8?B?aGpGamJ3SVZVRzl1VmRtc29LUDZFWlIwTGdjeVRnc1FtQitMeG1SOUQyTWt2?=
 =?utf-8?B?WFFXOVZ3VjFtYTlUVlFGeEwvejM2dWtpVHRnMGFmU3hLWGc3cHhnSnRJSVFT?=
 =?utf-8?B?b2JFdHJUNThsaWNWb0dMM012aU9RcjZmUnFZd0ZnRDRoeXFHUWhEMWV6YW5s?=
 =?utf-8?B?WWpZcWhVSXdnMnJMNnAwRVhITHluU1hoc2hlallCTENGMExGRURSWEVLNlB3?=
 =?utf-8?B?T29zSDAwRXowNS9PMlVKcE1tZXNURENSRlowVTN5TlNjOEY2ajM0Z0RDWmJE?=
 =?utf-8?B?Q2tVVStKMzk1ZVNWcjk1SERlYWZtWVpIMnBldXZYaWZnNkQ1WVUxcFp2VjJT?=
 =?utf-8?B?Tzc1OTFPbDFCZjlveHR5L0M1OHpiQnRwemNVbzJjZjhjQVZyVWJ5SjA0eE00?=
 =?utf-8?B?V0c3bklEVHNndWVLeHRiaEJwZ2JCOFdDdHR1Um00c3ZmMER6cHdBdDJqWXJn?=
 =?utf-8?B?Wlg0c0tCZW0xM1lydDdXbDdrdklka05qby9jTmdKOC9VMU9KV2xZTXVEREdt?=
 =?utf-8?B?NEZ0NjEzRktQOWxabVpZd1BDaVRzK1NSRXV2aGpMSzJPZ2lBWTFFMlcxTG03?=
 =?utf-8?B?cXFWYW15RWRacVNvMHZ2N0hHck1hanFMQnR4Z0FDUlU4d2FRSUV2eGhkU1Y4?=
 =?utf-8?B?NTFzZEd3bXJZazVZTnozTGlRUUlyZHdOUDFNaGF0T3psNkhpWXZBdTAyUk9x?=
 =?utf-8?B?WGFLOFJ3dWpDb2xzaElWL0RGQVRORUM0V0IzRkswUjA0RWhlN29FbittdzdX?=
 =?utf-8?B?U282Vkg5a3pCVjdCOSs3bGU4d3dhYjAwK0ZRa3dtTmRQZmRJcUFSR1BGWjV5?=
 =?utf-8?B?c3lVMmlpdGRJYS9xMkl6VnBQMEVKeC8xRHRYOThWSXkweWVsZXIxN3RWTjBw?=
 =?utf-8?B?RnIyejJRT1dpSTZNOFZsUTExbnhrRW5iZGdlcEtNUnJtWW1pNjJRbnFSWUFw?=
 =?utf-8?B?NThzYnBpdUwxODZaWjBlUUxRZ2IrZnY3WDdoV2ZJZWlydFVrODZjRDdGVTdF?=
 =?utf-8?B?U1MvR0pJSFZXOFN3MFVkOVJzTUQ0M2ZtWWZBQzc4UEVibG9zcndqMTJXRjgw?=
 =?utf-8?B?dW10akM4QVBlczZMOGhGYStuMzJIcm1tYlpURDZKQjZLNGU0NTBwTDVEaFFv?=
 =?utf-8?B?QW1EWWZhN2RIRmU3eUQ1bFdLTkFFYjU3bmI1UDlYLzJ5Tnp5ems5QT09?=
X-Exchange-RoutingPolicyChecked:
	v7MinMssQe0hqRBVYvW09s0iKqK1x45/6S6izufdqAVw2J3Pr8qlFwI6zkWg3T8R5/DJt7O9tnHyLKtjs7pRX3l3NHd05cBO+pBqHFhePlj270+h6PRp5QV6HKqpyQjokC0PzdfBOLBcExCnTyu/Dr34eyswnH67vdon9bIhSyvpVebBNQ68NRp1dxo7d2yvl0LQhrFHNZK5mVRuR4LcCK9oqRcZ6FhGF8XN8ilrvDfaeMXMG6BGL9ssSEdsGNZmWBm2BD49qFwN7mtxDlwvXAeTTVvSGwRj2I3zqnuUQzjkEVuJNa7yInE254dLQpiNeSe71/R8lPFIuvSGtUvspQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kRdPEtuE/bJmuGmDb5qTBJ8FjjIjx3ofvM3nzds9KyqOMk+n6eb40gE03+z5JPUJeOGVIKBoHeVNzEx7Kqg2oEUgWLDFizROuBGE+rwEjCPcixtfUEOR5X4GDBI0hQV4LW+BCr4UwS18Tagl/VfuVXM6QhTl4FO5BE32VnDIG2eXg9uos0HnPwIZa6XDmcJ7Q6dJyKIkW/pCFq6u1fzOADXItzoZAoLTDXzx1rrdNLstqPEy/GTw3RX5skmWaB1C0t99Y6zfIJPFvmkpa36gN5ZXPRbRTLFCf+HGKaBxtvaw+ODkaZgXvSmT1eMTki2F2ktaiDlL6HZciAPps2ZsudtPbOWYXsIesG23Jlu8+rLclR/EKqZLzMDFrMswGa1PMFwKWLUPqh7Az8YUQ1mnLVGdY5a0iD2IvqryxPgB9ZdPioWcefvaCY+944h9WHvNfJD2UPJBWjVeQDBS76rZYJ8Qa0XfTj+zfFWf2RcYtKnVQxGwelWNpSMjAl+OrSfxzMpofHL1qoxij5SKwO/M2ZeXpmOrId2cXbWxniJyYXbkSMSwYXIUxYGw6PrKSCWTN4rqbaemyTwRu7ChHGDYnrC/8LdoFDpInEhK80bnlVg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ab9853-b99e-44c0-3683-08de8f01ad53
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 08:44:10.1103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mMb9bH7K3sojspskPaQingGkMl1jZZctD2JoGDOiP5fRrhOG7dtZpSBNGRcDNLRIp2JTtO46rT6spdgs1t+DPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5048
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-31_02,2026-03-28_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603310083
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMxMDA4MyBTYWx0ZWRfX+A+PJE8sIvpP
 qJRUkxkXEm1pDaEAiaPAisdKWjNfoVJojUw0JK7ct8pzy4UNhQ5SLbpVZEHgUkfnMvlltZVuUA0
 EHizwPn60unyquJj6ncLjR62yIAgrnfOlKcnqIKdbNvl79jTtrajCQA68xQWILhya3GyQCnKdAv
 Z3yL3F0O+fPsv+W+3dIPrf1Tstb0G7uFbAikgP6xVK0DGLQRuZzheGKYwgS7WIoWZQwWOT81BfA
 LfelJeFHVS/HF2ZHZjfKihjwY1YBm2i/rVMOlOilIYaSvMIq8mP2xDt7g8Wl+ykYQKu1QPWAP66
 aXentKoE/y7ohGFCbc1vrASp3AmG+inhO0YvsdZp7c68saCUxCnq6bmLjKpYFC6OEAbtAjXFaBF
 aRI5I6qYixmBzBZR3WAS1OwHtjHFBBUgB7KNVcOOmvRXnLat4dONsEh8ioQrL681tzYAddNb8XR
 yEv4fHYcipE4CNBawGIc2EtR79XD6TsdoEyQvh6E=
X-Authority-Analysis: v=2.4 cv=CJEnnBrD c=1 sm=1 tr=0 ts=69cb895d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=S6esZtKPculU_tm-LAYA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13811
X-Proofpoint-ORIG-GUID: eVjgqrnhuqfbXZ1BoLJLlgx3LmPTa1cu
X-Proofpoint-GUID: eVjgqrnhuqfbXZ1BoLJLlgx3LmPTa1cu

>   drivers/scsi/scsi_debug.c | 26 +++++++++++++++++++++++++-
>   1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
> index 1515495fd9ea..7e5e171bfcda 100644
> --- a/drivers/scsi/scsi_debug.c
> +++ b/drivers/scsi/scsi_debug.c
> @@ -915,6 +915,7 @@ static int sdebug_host_max_queue;	/* per host */
>   static int sdebug_lowest_aligned = DEF_LOWEST_ALIGNED;
>   static int sdebug_max_luns = DEF_MAX_LUNS;
>   static int sdebug_max_queue = SDEBUG_CANQUEUE;	/* per submit queue */
> +static unsigned int sdebug_max_segment_size = UINT_MAX;
>   static unsigned int sdebug_medium_error_start = OPT_MEDIUM_ERR_ADDR;
>   static int sdebug_medium_error_count = OPT_MEDIUM_ERR_NUM;
>   static int sdebug_ndelay = DEF_NDELAY;	/* if > 0 then unit is nanoseconds */
> @@ -1041,6 +1042,26 @@ static const int condition_met_result = SAM_STAT_CONDITION_MET;
>   static struct dentry *sdebug_debugfs_root;
>   static ASYNC_DOMAIN_EXCLUSIVE(sdebug_async_domain);
>   
> +static int sdebug_set_max_segment_size(const char *val,
> +				       const struct kernel_param *kp)

I don't know why you just don't have code in sdebug_driver_probe() like 
the following instead:

hpnt->max_segment_size = max(sdebug_max_segment_size, BLK_MIN_SEGMENT_SIZE);


> +{
> +	int res;
> +
> +	res = kstrtouint(val, 0, &sdebug_max_segment_size);
> +	if (res < 0)
> +		return res;
> +
> +	if (sdebug_max_segment_size < BLK_MIN_SEGMENT_SIZE)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static const struct kernel_param_ops max_segment_size_ops = {
> +	.set = sdebug_set_max_segment_size,
> +	.get = param_get_uint,
> +};
> +
>   static u32 sdebug_get_devsel(struct scsi_device *sdp)
>   {
>   	unsigned char devtype = sdp->type;
> @@ -7366,6 +7387,8 @@ module_param_named(lowest_aligned, sdebug_lowest_aligned, int, S_IRUGO);
>   module_param_named(lun_format, sdebug_lun_am_i, int, S_IRUGO | S_IWUSR);
>   module_param_named(max_luns, sdebug_max_luns, int, S_IRUGO | S_IWUSR);
>   module_param_named(max_queue, sdebug_max_queue, int, S_IRUGO | S_IWUSR);
> +module_param_cb(max_segment_size, &max_segment_size_ops,
> +		&sdebug_max_segment_size, S_IRUGO);
>   module_param_named(medium_error_count, sdebug_medium_error_count, int,
>   		   S_IRUGO | S_IWUSR);
>   module_param_named(medium_error_start, sdebug_medium_error_start, int,
> @@ -7449,6 +7472,7 @@ MODULE_PARM_DESC(lowest_aligned, "lowest aligned lba (def=0)");
>   MODULE_PARM_DESC(lun_format, "LUN format: 0->peripheral (def); 1 --> flat address method");
>   MODULE_PARM_DESC(max_luns, "number of LUNs per target to simulate(def=1)");
>   MODULE_PARM_DESC(max_queue, "max number of queued commands (1 to max(def))");
> +MODULE_PARM_DESC(max_segment_size, "max bytes in a single DMA segment");
>   MODULE_PARM_DESC(medium_error_count, "count of sectors to return follow on MEDIUM error");
>   MODULE_PARM_DESC(medium_error_start, "starting sector number to return MEDIUM error");
>   MODULE_PARM_DESC(ndelay, "response delay in nanoseconds (def=0 -> ignore)");
> @@ -9539,7 +9563,6 @@ static const struct scsi_host_template sdebug_driver_template = {
>   	.sg_tablesize =		SG_MAX_SEGMENTS,
>   	.cmd_per_lun =		DEF_CMD_PER_LUN,
>   	.max_sectors =		-1U,
> -	.max_segment_size =	-1U,
>   	.module =		THIS_MODULE,
>   	.skip_settle_delay =	1,
>   	.track_queue_depth =	1,
> @@ -9566,6 +9589,7 @@ static int sdebug_driver_probe(struct device *dev)
>   	}
>   	hpnt->can_queue = sdebug_max_queue;
>   	hpnt->cmd_per_lun = sdebug_max_queue;
> +	hpnt->max_segment_size = sdebug_max_segment_size;
>   	if (!sdebug_clustering)
>   		hpnt->dma_boundary = PAGE_SIZE - 1;
>   

