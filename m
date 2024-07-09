Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B152A14534C;
	Tue,  9 Jul 2024 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720516193; cv=fail; b=kNOaToL7b52M3XdFl5miZ+CXd2+pTaIG6762fUCjD0yY+IwN3/loaZ5U501yccJTwgouQaTJPG0R2jK27x/njNoTskeg0sXOlFfMyTta8yDHU3OhVGTMq+7uyFDFEZY3csFIaPPQwy25T+FbQwoBWmRsRxj8GQ7+ujiGCcwf+zU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720516193; c=relaxed/simple;
	bh=VaDPcPqC4Po4T/A0syvzYChKp5enOG/TKLchaevzQyk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qFE+9U7H65AkGlPQ0vZh/RfquF3whUreW2MKAGVwbqVsK+F1MUx/e0+EPciaz8IG10wu8rnAOHE6BBrZycIeVqVtbXvB6lRN4ED1w0FXMdG8uU65LH5Nt++uSerEo0qSfohNs27bdliWuUHHXcIA7ro5YA7u+8FgN7RboZsxwGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TNBRqGl7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nO/k3n5G; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TNBRqGl7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nO/k3n5G"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4697tU00016137;
	Tue, 9 Jul 2024 09:09:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=hmRINGISYiOOF8hWIaDa3lTPCBmycelhFECqCbHR4qU=; b=
	TNBRqGl7rNmMyN3PqwxVxbcXjIhQQy0fD6IiIDqQfrdxjT74x6wlG2lM1UZIXd0h
	4IrWoJmfx1ZLXL9U9PjW7wScUCZpfCt1pdKfhjnyRKYaiulaenTWKguyAt00wBMk
	iPFpB7OHNigrmXdJAI2cWU9z7oN9bVvAAzzzb0buhXPb+qsgG/itPdxcNgXn/mCK
	VwTgJhn8E2GY27mWU2O6Lt+vUOOm3NTV9/eo8bPy2R81o2OsBywafQ2S5jhnQk7v
	Nfmamih3tXeN0iEWih56fYkcINmZof22SUJ7sqG/HnQerB45a6Qt4hePPtu8iVtF
	KPs2tRyyjpQETJJAg5nvJQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkcceya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 09:09:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4698CYVd007496;
	Tue, 9 Jul 2024 09:09:32 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407tu2wv4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 09:09:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IxlZxTHlOMj9t4m3wssu25SRVrKAgwD1O1C9mYqIjXOwmm4DY1Cp1t3V2jXkhrEq9BMtfQuCVm1E9KooGMKat8FUeDd4vNnDiqHWuLF2oQSZwRy87PZ8yxKPgoqdZAdRq7LMmBTbQPEB/hFEqEk8vmBORSVxz+gGdjtE6mSYEBq2Z+LrFPXZCVbZwrJfIcF7vgDUF5ZGil8xWir5z1RRZRvKNQcjIWShCby+99SrPnfXh9AXqX5FPYBtWRShYONuHj7+i0EKYPOoiIqjBjWEIwSc5Xfy77CgpKoqHEeHToUkscfnlnyQBFboOhElzF8pTKkk55RLUhiYKZ0KAa5dWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hmRINGISYiOOF8hWIaDa3lTPCBmycelhFECqCbHR4qU=;
 b=OXLAh+7wLc36JcWRPOLwtSEaoLuYCprAxPlePnHupCCjvH48f5B9FcQZdt3TPVvh1rT3Sj+HpjUpZa60MFOY83AUGhb4wI16PFuHmR9OTfbSlWGcaltDZDaR80i4bXX4m03kCefJQWiOjw8wOHBtzgrhbzDNMi+6l7Fi0zHF4fRIKQCD/4YDZLa06bSpy3eLoWDe9l4AIiocGr7l1nMxhxeKDwEOEcJD8ygZUKcp/xutTzRPhCn1++FXlYwtAcGgUvioVrqiVMiRtmXW8Tg3RR8p7C7SWQl2qNCznGXmqFlKAyPNsYUwIj3yAB9lGt5TjcCxy3CdHYBUfHjUEgRvJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hmRINGISYiOOF8hWIaDa3lTPCBmycelhFECqCbHR4qU=;
 b=nO/k3n5GUf1hHjrZx6G7VZkOzW+x3y4NA4HjVbGN6Zk+STeE+jWtCjdCtdD7DFqhWCVbsNFIfvkTCZgMy+l8zJ/EyhZKfy0EqLcdB5A1L5qAdeCh9AqYrAu1b9W1dWApJQVIkvuPfR8uJREuuRnqZEGtg5JcQaAX4RlnbiW99DI=
Received: from IA1PR10MB7240.namprd10.prod.outlook.com (2603:10b6:208:3f5::9)
 by CY5PR10MB5987.namprd10.prod.outlook.com (2603:10b6:930:29::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.38; Tue, 9 Jul
 2024 09:09:30 +0000
Received: from IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1]) by IA1PR10MB7240.namprd10.prod.outlook.com
 ([fe80::962f:da30:466c:6a1%2]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 09:09:30 +0000
From: Gulam Mohamed <gulam.mohamed@oracle.com>
To: "hch@lst.de" <hch@lst.de>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yukuai1@huaweicloud.com" <yukuai1@huaweicloud.com>,
        "axboe@kernel.dk"
	<axboe@kernel.dk>
Subject: RE: [PATCH V6 for-6.11/block] loop: Fix a race between loop detach
 and loop open
Thread-Topic: [PATCH V6 for-6.11/block] loop: Fix a race between loop detach
 and loop open
Thread-Index: AQHayR2JSOf+1W/UnkG1CxXEGa2wWbHg4dcwgAK7AwCABPni8IAFlXdQ
Date: Tue, 9 Jul 2024 09:09:30 +0000
Message-ID: 
 <IA1PR10MB7240AC320F4DBC43E73E758898DB2@IA1PR10MB7240.namprd10.prod.outlook.com>
References: <20240618164042.343777-1-gulam.mohamed@oracle.com>
 <202406281350.b7298127-oliver.sang@intel.com>
 <IA1PR10MB7240DE46976A3B027DE5484998D22@IA1PR10MB7240.namprd10.prod.outlook.com>
 <20240702155020.GB1037@lst.de>
 <IA1PR10MB7240AE0551BCF41FB1A69FD198DF2@IA1PR10MB7240.namprd10.prod.outlook.com>
In-Reply-To: 
 <IA1PR10MB7240AE0551BCF41FB1A69FD198DF2@IA1PR10MB7240.namprd10.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR10MB7240:EE_|CY5PR10MB5987:EE_
x-ms-office365-filtering-correlation-id: 65ff5abc-9df8-4e90-ae4a-08dc9ff6d72e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?Y6/lniQCvpoqRAixDYvValZREJuS8sN2QkSCVgFxCKYaxSAl4LZ/L2YNiQjl?=
 =?us-ascii?Q?U7Vyyh7hik6GoSsv8PbU/V31BoIwlDNFD/brA74VTng8Hdx4ERzrmbgdWROB?=
 =?us-ascii?Q?4/u9+QKOP92mn+M9djSKZTylpLHCx1/O8y1iixw8p9lmTAPQdzKMf/EeevuP?=
 =?us-ascii?Q?8dvfAGFYO5hnRqoMzPHSLNFZbOwZysPGUoqq/ta1WAV6lMjYNeGBAhTniJ8V?=
 =?us-ascii?Q?fl4fC85QuYJgRtAqYUnlsX/IePQwY2Dzfa/7HItoKYKUDIDsVL5BW+AQ1nwW?=
 =?us-ascii?Q?T5808pAVs2LGOB5LiFDvSSfAmlSAk/9n96Q6mqmNLjpNzpxZvlb7RBxAthPE?=
 =?us-ascii?Q?ll0NGq3XiEBLbvSf6lpsAL9w4dTVSKb/McSN0HjRzhZurGG5nz9DWA0+UB3O?=
 =?us-ascii?Q?UA2XZhd5PC9c6tO1NIEnWE/8CfKa1IdBS9fQDq4pUa2BtR0cqoXgXFmAgBde?=
 =?us-ascii?Q?6ECL4JAC/+aGLey6ifkvZ7WPHI+s+jGe39Xzl5r/Kb4Usosf/k8I3vHsElJA?=
 =?us-ascii?Q?Tbn/1PIrMg2wgYN2f8rfGXBPpU8prN0Vm7RuYRzlOZ6rGHliA08cDnenoNhH?=
 =?us-ascii?Q?PaxYf5PIANTAfD0I/FRfqk6Y7jpH/QiR5rZJanzXgY3OqF5WFP6VvBWu3PAX?=
 =?us-ascii?Q?rxobVWDWRYvLEdUg1jBW2KbQDURtgdAmY4m48B2t2IX7LB90kaj8vTSLLygY?=
 =?us-ascii?Q?UGC6evA6gauT7H1nq4uDMocCJ5GBEKVVz+64stRiso+FDGzT3Wx0mguxQ+kI?=
 =?us-ascii?Q?Tcid5aHHMaP4HTUYovOHQVoSpJXtwVGj9LRqbboPeqEcyPLs2ry0YUcGcACF?=
 =?us-ascii?Q?aNqnW2t5ABNEaoOM/J7QCO04Ao6daAPg3pSLUSnqpboqIXNZ6BHCPkfiglY5?=
 =?us-ascii?Q?sepjR+NFK66WVA2YbJeyiqxVs4hCDIa+YWuY/wzzT42/6KjUuw1nqYpXdb3N?=
 =?us-ascii?Q?qT/vnuYfwqB+ps8VXiz9ghjV+RuxfKRusv2qoh+2OKMyzZ3C5vli2IBE1Rvo?=
 =?us-ascii?Q?/EtzkCPWFTcWqiD4r0KSVMcu7BhjLf/sRg7DKYUNz/5bgVLbcUs0yL86a50x?=
 =?us-ascii?Q?ZN1KXfiXkRQyMfJ1CQgwi6BjXpA3yocsKH1kECT+NyOgHOYb77ZSYLtaOrmW?=
 =?us-ascii?Q?tajM4hKavzL29fJAxohN3Y3HwxY2mB+ipKEzSggu2Yg6/btmsquQuH5giST+?=
 =?us-ascii?Q?bU3RJM7VlvBNjvPGVPmXNaN6t7FqFXSTMbH8szhWz+7RaDa+iDUD6oyLU3u4?=
 =?us-ascii?Q?2u9EYOqULWXCRhrxmo4Z073rxhy1Xu7KaejJYXnCkEpwZpNb5mU8ZqhSmZGu?=
 =?us-ascii?Q?YiyTGK2Nq/pxbeb8YgzWHeWS47vJLfSqUjlfCIKOt42oQejYxXksnsmStypu?=
 =?us-ascii?Q?FVjYtrpsJtuuJQCeYE2SjvbpOwF0unzhplQjAoShOXAnx0jjlQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR10MB7240.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?8mkn/bC+IQVv1o0p1GatyTQgziCdxlmvpubsIrjuvoo4Xw9lu9YrQQpxMTTT?=
 =?us-ascii?Q?kqVKA9EFbHIPVrccHJy+ULr1zSNPGQj4M+yjgPnyJKz8gVfUgsNGd8e7yi5s?=
 =?us-ascii?Q?/Nrp6fORr5Y6cccDDGLGl/xwcJxr7VJCSbPvhUFjCHzGe9ghjHFt8vCrP3du?=
 =?us-ascii?Q?ESDJhJtxFQbXzSY2knJoCESLMaoc+2zwL5USWBww0lvukppO3L/g+899C/sg?=
 =?us-ascii?Q?cJrLwmRI9AoAkD+2WdyxLfi53jNVcea2ExNd5gBjCUlEUoV/YiaEjpPGY/FP?=
 =?us-ascii?Q?yAOek13esppj+Sfc09iBCdx764evvE4LvQ5zuf4shcTS3MolSQ0AT7Z1cG8U?=
 =?us-ascii?Q?InSaYpigUFkRIZgKMUSzSuW+RVmiKe0VFMe1LbwOGKYUluG1rgRQ7qMnf6li?=
 =?us-ascii?Q?Cuk2u8zv3Otw0o/LEFfkOs6J4Moik6+r4JxQfcfzE++/1828B2Yd0ezT04Ho?=
 =?us-ascii?Q?uD5M8v6dMJ/G+Ma4jummTO7gv3/xbY5osWHgIFIxDBWoodk/2wzAj/jzzqqs?=
 =?us-ascii?Q?c2ie1nYgfZd/DQmoTsKwjV/dFVY32z4QdcfWtcP7NWa+1XLXLLVXJ3Ot4LMN?=
 =?us-ascii?Q?R5o0RTb9fErGps2qKHArtT+UhLmdnYmsK11jbt8WbNssu5SX10XIIFazplzV?=
 =?us-ascii?Q?C7J8sE9u2CTS4EA9zbu8hdjWxe4MDSag7N1gxakSvjKcbHs4gXLaNLUUaH2e?=
 =?us-ascii?Q?XAn9z5g7jvbZubvLWNIxRfL7992eEMqlq+XAICti1XwaQxb9Du1TiYl7rMnj?=
 =?us-ascii?Q?39sSjPKQ8L7jOishDkANkTH0/2O07Tj9jLr+dn9SOHU3BYP3NyujLGdzK9gG?=
 =?us-ascii?Q?aMf9XNqPbRVjtOeJCw2i+hMEXdVGID/UK77QWoKZRbD6Ha52wVzZaPjcVDS8?=
 =?us-ascii?Q?yViH9pn3xTJsNrkIIALpOnE8KuCigI9KQ4b/0ACtl+VXoDPG0zuobizaO71/?=
 =?us-ascii?Q?hAh65SmTpyWaL7EXRTDfLCkqdNmXKt9DkCHUNu3a8KJnyTlfLgGWrju9vq/f?=
 =?us-ascii?Q?1fkc4q+V8jvXRheu/NdL4Vgge8pn4F6kGRXW9gMKw76JIRXyRFkb/rj4VqzQ?=
 =?us-ascii?Q?WLzQQMFL9er9vKOLtgkVlpibJBUWpEZNiwsc/Ns0j5WCMkInluYfiveU8/lc?=
 =?us-ascii?Q?tUJ43hE60CpZw8j/zOzd//h1zz7/2rdirgl/IAUB6RACF+P9zfDJac5+Kq49?=
 =?us-ascii?Q?6xmuZ1H8cg1Hj3A8R4MB/QDB3ZcU3Idnr+3VyB2FiXPRC3JNdyc/kVBCqtXd?=
 =?us-ascii?Q?NCiVZSHsYpLe8o834xDRehJvlEPAPGShg2QCt500qMCAQSRSLvvFYta9cpG6?=
 =?us-ascii?Q?LIdbjDiFF9uU0CQRZbQ3EzcK+91sR/T8L8C6mf1B/hGvW1U5vXVFG8fpuYo8?=
 =?us-ascii?Q?WIAl7HrPmrYiNJ4I8MAhrj9quFUclaA6Gq/F9ziVDyt7U89uVYEDdOUDOTMX?=
 =?us-ascii?Q?C56UimkEwcVlcrSt5wSIP5uICYgmbjjTY5OslnZLu4DuTY9f6bQQe3yNQM0c?=
 =?us-ascii?Q?GFvRXZ3oUeHnSpS44t1TjorXvxigdsBmerpWbjkg7229tRJ+MFxw9tdjaoUl?=
 =?us-ascii?Q?4Pg8Gt5aRW42UWVEYJHhmnDq1bytFZ0c6hkDJGCG?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	z4pgcoAhoqqXsaef3YCNdm5RXmr1nRPkXeTkG16Wai3p6Rr59L4nUmBwWRGMTa1TOhhDI9S0xR1IHL6koJ5Qnz9E2TBcbN2uUrPh8M4TwPJpxY++qq7Op5iBsvlljTFyX8MVBN1JxKOzaPhHVn8r6PEYxjTsqTk5Uvo9PN+QlWIi0+jMQU0Y+7KrX5CKEhPr5yYkB5cxRaUyqCAk4ges1/r4Urbkjzja+iLQtHlGUEaGk/2hn0smaOs6XWnDvmE56zE9Jf3riYnqb5y2P7IvtiIQVwHTff0DUI8rqsM4ntLlWL79fOYdezPZM6tbTg1BubVVigA2lkzfH6MEE18yU7GRZiH8u2xSKot0qG+SQrNkm4qi27izSzMJyc+BWnzjwP1Gk+7ycivFeZklkXUpPF/uef2EVGUNfzfdm7K4RCmxzXUMFF1/fKoM464IcfQpunO/epMCGyJhhjljI3hArSw29LMdZRLtxvHEMq2g3GUvytHA0TCmDIwAdE54v0kBY7gyaq6R6YfFhf+wsRQMevz9S0VG/8/IesQcPAApQL5vrqqnCA2ROoTKMp6epFPM0mGPSsZkFabZKqD7VSdENwlKOo/mxXuYeJng4lKT5io=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR10MB7240.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65ff5abc-9df8-4e90-ae4a-08dc9ff6d72e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 09:09:30.0675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9wQBeBhNmhS5bIsIcQaS9FYM8YJNfJ4bAQ0iIq9xg9bPjgquQW8WefufQgx8nRIiILscRxYVmYUmx2ifEkDcKIZdNhAZFxzywhfGC+pwIKg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5987
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_15,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 adultscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407090061
X-Proofpoint-ORIG-GUID: u9M4txOz_5zO4qgiHVQ3GXDK4J3KmVZd
X-Proofpoint-GUID: u9M4txOz_5zO4qgiHVQ3GXDK4J3KmVZd

Hi Christoph,

> -----Original Message-----
> From: Gulam Mohamed
> Sent: Saturday, July 6, 2024 1:21 AM
> To: hch@lst.de
> Cc: linux-block@vger.kernel.org; linux-kernel@vger.kernel.org;
> yukuai1@huaweicloud.com; axboe@kernel.dk
> Subject: RE: [PATCH V6 for-6.11/block] loop: Fix a race between loop deta=
ch
> and loop open
>=20
> Hi Christoph,
>=20
> > -----Original Message-----
> > From: hch@lst.de <hch@lst.de>
> > Sent: Tuesday, July 2, 2024 9:20 PM
> > To: Gulam Mohamed <gulam.mohamed@oracle.com>
> > Cc: hch@lst.de; linux-block@vger.kernel.org;
> > linux-kernel@vger.kernel.org; yukuai1@huaweicloud.com;
> axboe@kernel.dk
> > Subject: Re: [PATCH V6 for-6.11/block] loop: Fix a race between loop
> > detach and loop open
> >
> > Hi Gulam,
> >
> > On Sun, Jun 30, 2024 at 10:11:14PM +0000, Gulam Mohamed wrote:
> > > With our latest version of the patch V6, the "kernel robot test"
> > > failed in the ioctl_loop06 test (LTP tests) as in below mail.
> > > the reason for the failure is, the deferring of the "detach" loop
> > > device to release function. The test opens the loop device, sends
> > > LOOP_SET_BLOCK_SIZE and LOOP_CONFIGURE commands and in
> between
> > that,
> > > it will also detach the loop device. At the end of the test, while
> > > cleanup, it will close the loop device. As we deferred the detach to
> > > last close, the detach will be at the end only but before that we
> > > are setting the lo_state to Lo_rundown. This setting of Lo_rundown
> > > we are doing in the beginning because, there was another LTP test
> > > case failed earlier due to the same reason.
> > >
> > > So, when the LOOP_CONFIGURE was sent, the loop device was still in
> > > Lo_rundown state (Lo_unbound will be set after detach in
> > > __loop_clr_fd()) due to which kernel returned the EBUSY error
> > > causing the test to fail.
> >
> > Before we'd end up in Lo_unbound toward the end of __loop_clr_fd if
> > there was a single opener.
> >
> > > I have noticed that a good number of test cases are having a
> > > behaviour that it will send different loop commands and in between
> > > the detach command also, with only a single open. And close happens a=
t
> the end.
> > > Due to this, I think a couple  of test cases needs to be modified.
> > >
> > > Now, as per my understanding, we have two options here:
> > >
> > > 1. Continue with this kernel patch and modify few test cases to
> > > accommodate this new kernel behaviour
> >
> > That would be my preference.  Any code that is doing a clear_fd and
> > then tries to configure it again is prone to races vs other openers.
> > It also does not seem very useful outside of test code.
> > But if we end up breaking real code and not test cases we might have
> > to go and bring it back.
>=20
> Requested the maintainers of the LTP test cases for the modification to
> accomodate the new kernel behavior.

The LTP maintainers agreed to modify the impacted the test cases to accommo=
date the new kernel behavior. They are asking the kernel version/commit in =
which this new behavior is included.
Can you please help in integrating the path into the mainline?

Regards,
Gulam Mohamed.

