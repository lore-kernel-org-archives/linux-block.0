Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4581DE891;
	Tue, 29 Jul 2025 11:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753788010; cv=fail; b=EAwtN39+jrbZhInswIrx/gCXM2QUSgGn+F8eLknRK+CrFwEX/C2BsaighNik7pKUfEdBMzq+dkphEW9mRh3MfsMRDLFo4tkaMmrinTheDgi6aLejdWnNi1WC0/pZ2wDNGJU4UR8kX0rGH31OyR3XAfOrwIDNZXz0TyIGLIraIT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753788010; c=relaxed/simple;
	bh=b6NWJWRMMm2EDZrMka2ZVHr/1Y+WRDmHbufqiHexj5E=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=A3yR+dUf9JTtRtbPvXLFxkT3tsLLaugTL6THmuKICJAYIi5Cyh5emcUFLj+b4Fi2sNURC6MzVKuqW3bJccN7Xb4CEf4qDC51fXWgclUQ7LLwM7DnM2umUpK1eDPDcy1njIRcrS7UMsux/x1XDNwaPPoEtFsgwbVW0t/inOg5qvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eOxk16hP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BM83e+ib; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eOxk16hP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BM83e+ib"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T7g1VG011063;
	Tue, 29 Jul 2025 11:19:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=g1OzrbdtTbiZE5JwF0
	Rv5hgQh0d/8luRpk5kXAT6n94=; b=eOxk16hPcVisNdVEOVf8b43OEeQ5zXqAPS
	SuAFex3GS/5g04M7C5wibxtmf+ii0kIxkRqErUep3SDcded/JofuYjvjASj5UIVI
	BbLPfx7gnUeffxmP8DF/Yfn5Qvkuq+llBWh5YBQfi6Oltu0LjvIp4riq86W7p+cV
	P8GC3oTeHSiJ6QTw9IMhFH2I9Tm4/tjpKCSGx4/AOtvBiW7s1CMnD5g3gA8hfu2p
	Yg3Hl8Wb5+mG6V7dUsaXVeIE51PIdXCWV6qnCzluQRly29cEIvpjLkHGvFIauTIu
	9BNAt11/KxrnrI/4Izd1zYz9oBhIz3eQy70lLXjxCpbzRfJTRmpw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q72yfxx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 11:19:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56T9W1uk035146;
	Tue, 29 Jul 2025 11:19:51 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010021.outbound.protection.outlook.com [52.101.85.21])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nfa0vnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 11:19:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3esfkVJj6XT82raSkGLqnxw2QeBerahF1R0H3LhM8kIiNbkdkBly0w9ce8zGqhQ45p/aMtg0s+MuE0gBtAAkoTNBNM6eMV7hgSueOPwgun1ZTa4dnmomSiebvDx4ihkoBEsOCcyHgzhz2dsGHEVzCH1k4RrBdwlrvZTY95Ek8bWgl3zZE/ljzJUJIw/fkoredC19YqZ5+mLcjf7bqtHaVZCoa3st7roBn4lvIT1SrOixuH1jdJY9vd55x50ReDmCLWET7yvPTuRv/XKOIcbJkfkSI3JUfG6ECuv43EOpgwougswvBEfUg28d+eB+uxwx8fd2SAdot36u/Nwgr+i+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1OzrbdtTbiZE5JwF0Rv5hgQh0d/8luRpk5kXAT6n94=;
 b=D1fke0z7WdHGBAAIiz/15Jn3s0msprdq7HqhfXI3lKp8lhvZhHDEK6OCQ3cegvuqvT9wCU027hFjv7XLclskVZReuBJPwCK07RUoPL44Zn4EOR9WSaUHOqeRsCgVwMLI0xxBGG5qIuqJBL6fsZbXzOShJzcNKo+1BrLh1tVOJOl23+0T6eYOKFRZfFNzuHNNofdRJxvcumK/PHz5rzpW59Vx66cmeR1YAPV5ccOjCKfqWgbHTwjlybxixlK+eUuGNBC4PZVortgMa7To4eIntYoZ6OjSJd9XaZgosCb/+lIWSWElfG+fxz6ABv8FKGvoZb+jnI1gBVUxfOhbD1e51Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1OzrbdtTbiZE5JwF0Rv5hgQh0d/8luRpk5kXAT6n94=;
 b=BM83e+ibwa9auSSlFRf1LRu6vUI//tDwNKndAv4FnIJ2nU+TeP2IJPunUE0sdGiqbNxXf6d8HHSfnhOPsmuVoGcOpTk2Tbq3g2gcvAVyNED/r7y71YGDLWdTfJnrAut1Hb6zdGfl7hZguchw2rEFxx8N/9ixsZp71FzjWEAIsYQ=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by DM4PR10MB6911.namprd10.prod.outlook.com (2603:10b6:8:101::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.26; Tue, 29 Jul
 2025 11:19:48 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.8964.026; Tue, 29 Jul 2025
 11:19:48 +0000
To: Christoph Hellwig <hch@infradead.org>
Cc: Klara Modin <klarasmodin@gmail.com>, brauner@kernel.org,
        anuj20.g@samsung.com, arnd@kernel.org, martin.petersen@oracle.com,
        joshi.k@samsung.com, arnd@arndb.de, naresh.kamboju@linaro.org,
        anders.roxell@linaro.org, axboe@kernel.dk, kbusch@kernel.org,
        csander@purestorage.com, asml.silence@gmail.com, adobriyan@gmail.com,
        djwong@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: change blk_get_meta_cap() stub return -ENOIOCTLCMD
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <aIh47Ncx5lY1vc9F@infradead.org> (Christoph Hellwig's message of
	"Tue, 29 Jul 2025 00:31:56 -0700")
Organization: Oracle Corporation
Message-ID: <yq1h5yvkzwo.fsf@ca-mkp.ca.oracle.com>
References: <20250725164334.9606-1-klarasmodin@gmail.com>
	<aIh47Ncx5lY1vc9F@infradead.org>
Date: Tue, 29 Jul 2025 07:19:46 -0400
Content-Type: text/plain
X-ClientProxiedBy: PH8P222CA0016.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:510:2d7::26) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|DM4PR10MB6911:EE_
X-MS-Office365-Filtering-Correlation-Id: d996bbec-7215-4f9c-d585-08ddce91d466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iaYSuQC/dqM9VwMfChWTGmSwCBtRYy9vVkGsTj1vkXYl53IPVaUw7v3ZO1d4?=
 =?us-ascii?Q?zlfruIJYXxgkaii1CeMG2SUKvHlZi3yks/Iwv+/GBYIWuU1hmI7uOd+eZ0CG?=
 =?us-ascii?Q?Gjam7rmEDfDsG3uCr+HpjY3hSsmX9euKZAIgPNrR6QcjSukleRTFYS34yDrp?=
 =?us-ascii?Q?4U/qPvNAGb2S6HDzI6AHfQTEuvow2xMcxsmL/qr0p44fU+WHw8cEXlubzSaZ?=
 =?us-ascii?Q?/+zOUgmD+cZaOUEtJ92yCDneYKQdKz7Pbg0IOOKQt7nMwkZ8JFMzyp/DpHXY?=
 =?us-ascii?Q?nGpH0uIRRlDxYedH2NpKd24+rKTNm4TPW/XgMK4WcjlccTUJo4x/t55sSKGd?=
 =?us-ascii?Q?LJ8ll7IhjaXkRU6oWOAZ5bBcFCwKpA3h8MqxF87VyQ5WRoCFxh4uD/fIkgw/?=
 =?us-ascii?Q?SpxUcloUM7b71czQ92Pf8QNV4i/6zQ0Oh5KPVdCQ0Pzuy5B8e8dBuw/apZSv?=
 =?us-ascii?Q?fHxqk+4luwFgc3DCX6IHnb2BOU8yZoTW9Dqa6Bory2NuBvD32ZXolqXBnmif?=
 =?us-ascii?Q?bT8mmZIe2Ibr71OJkcncZE85utii9SX+GbTMUuR074DR1hzD0kxwT0KQ8d6c?=
 =?us-ascii?Q?MxDwNt6ENwfw1nxQWbKyKfCDFnZVE3hWMFzDeNZPa1LFGGzqnmLr1siCwiyz?=
 =?us-ascii?Q?pUPdKacpKStJD9tod2ibM0PpWiv//k9q2K0T+7eJ9M/9qOhUhpF0/8CNkNyy?=
 =?us-ascii?Q?lGcJ7BBZ2qZf8I2F4CCnsGfuQNMTydv4x1l4qFoT9EbhjzxBs0As+5h3SgqB?=
 =?us-ascii?Q?JhAf6B1CHq3lhRDMb8C58MzQ3kaeYzSsb1bsH+UhEZobTav/8456mCNmWXng?=
 =?us-ascii?Q?t578krMBad1PQ9d6WS7FjqfxlkMY5KytnIw5GBvOom+UNIoDCCo7hvR70V2i?=
 =?us-ascii?Q?9/SS7n61ofNpJhf7Y8DPHsYOIdTN9hEkBMuwjJj0KjVpGGrGVbgbFVU/olTT?=
 =?us-ascii?Q?e3e+7w5vGakkBRWRdIHmhLqn+68ubt+Pn2j/s8CsipX2VIJKk2W2N67t7yEz?=
 =?us-ascii?Q?wZs+3C/R+sijIQP4ZoVe7PTXPbO1dh/wWX2nofGR3Avyk7jSWRR6P5fg2IUw?=
 =?us-ascii?Q?d5puSQXGAw0zFDo6AuHH/NubtI6lDdbJojy0f+2d8CoUpmjZqod+qeHldERb?=
 =?us-ascii?Q?VSdAm2a+r1u/7H2dnznMuRbn+zhar3t2p2lt3IeRrP7ZMQ8Cuzr65yAUJz69?=
 =?us-ascii?Q?/OjUy0WohyLNWLRufmMt/0jrt/tKcUhUZe3a4MFGKMMhk+9ZSzf5H6XvlV8N?=
 =?us-ascii?Q?fmMAFVI3VWwnKZm+d0GhV6VhBtKuaCSf+6nUJQHUnQ1JM6IA61EyRpOIUyv4?=
 =?us-ascii?Q?fiSCgy326fjI6neWuJ5RPiCEqsfm+O2/R6G8dvutEjMfF5lN3hLrqCd1aakI?=
 =?us-ascii?Q?cGVVEMziIzoN4EIEt5lMQepPlYgXfknaYwjrJ9yjoximAfm+5tWsJy/2F2j2?=
 =?us-ascii?Q?3d4l+4D3wxE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jO8qm7YffJpcCrlViqW/wWedMXAgdcf6tp7j5zR7KsCQVu8SAkQYDNvx9hwq?=
 =?us-ascii?Q?uXdnCBP1QOkSV0a9vqYdV5Iym0NO2SSf7G+OVVQ+lN/1xlSsjKmIzAMDLUQa?=
 =?us-ascii?Q?On7iVxH1ZTUFr3dB80Hq2dPtuxoHoQRAcDDcEnVZGxAYjmYew19d9uLBAfNx?=
 =?us-ascii?Q?kagf0i9cieoWwPDNuHhvBy2kyydS8odYGzebn6lEYtYDUMrDtg7MF6ZqjZT+?=
 =?us-ascii?Q?0FFUlFohrTnC0mE3USgqFzgnXcnucAyZw3DpOmcZsD1F7y2sLUkAOt+x/vGi?=
 =?us-ascii?Q?PqCKXUyEZcIQWPb2/phifIAtEW1xzl8rtkwyv2+K3Qi1WFYwsUXqDf7QPdF7?=
 =?us-ascii?Q?IpEw3o7qlb2dcy5ifBq9bWhOPAEjpzGDUr6RzS4kt9j0Puqb25DocmQkhXDz?=
 =?us-ascii?Q?On6hCoxvLQ+cN2WFu8C1VchhWIxyna+m0zN37xELYGEyC9WCNnBLa6iJjsiW?=
 =?us-ascii?Q?F4lDFI7i0y3DjSVhyi0S11jmgChB97lWX61uxL10EtVPj9yfLoIuws3TGfiS?=
 =?us-ascii?Q?jnnK6AsBMtaKrc5T2daCcRbK6tQoT0zmX5bBS1gqzOxAlz+IZjcCGaDS6ko5?=
 =?us-ascii?Q?raNhvjc2ndtmkNlfaZynRPby72bsLFz9fUgQw/1J8E8IxTa3DcdalYa8iDhZ?=
 =?us-ascii?Q?lzsF/FFPgKYzM3GN6FmIpAiBwCE+QiilmhqzOLwxX5aGDSRNMBRqoTQ+naAS?=
 =?us-ascii?Q?DIbQF1Yr1DeXhs+0KdAy9fvuLIDwxIi+3+4jxV9T4zL/agYiASrdIeBcn9gM?=
 =?us-ascii?Q?/cd0yWixNt2UPzZyZBjDgiKdKJL5rBoFO6bbEGZPmmSsw2VEl88DYf/Ie+Fi?=
 =?us-ascii?Q?Yuzx9qe4icv3nTv20SZChBU0egNmtlvi+9S//R4dw05Y0pdz25fRT85v7tAz?=
 =?us-ascii?Q?uKgZ7qn+4QKkjdY+CrdSV2IetLeps14hQUQeLmcQQr59B3NnnKVEm8wL8iBO?=
 =?us-ascii?Q?b+nFKt1RpEsrhaL/qWzKDHUhxVfq8Qqjya3IH/14dxmVAVOXlCmEEFtTrn0e?=
 =?us-ascii?Q?RpjCit/Nyd0TmDJYIYMt+C/QrZbUSkwvX9YjD+p3IsTFIQiDux5XSSmRW1QZ?=
 =?us-ascii?Q?4lWC/JyQR2TgtOqcU/x/fRW/RFQIGfbcAdVagX2H3D36tdAotktLsvH0Bpds?=
 =?us-ascii?Q?OQ3Ei+gf6Z+xjnzwuheXQZJRChvHr0Pe6DlU/oVfvLv+9UEnbqUFM46YxnQf?=
 =?us-ascii?Q?HYdv7Uvnffi6vrQxQfqkgKgxuEi2z1UhcOIb65VrzGWHI9L5JqNK9o/C3pO9?=
 =?us-ascii?Q?wm8bttgFSrj8faAJPpqhCX8z8QtFnU/xaBIfbVd79App/g7Nisp0pe8kneWd?=
 =?us-ascii?Q?Err1ZdLCrlEGH7FmR6cNSIn10lfKi5AxL/OhDqPUoydOoONzCgwE8vHRLfOb?=
 =?us-ascii?Q?P9A2gapk4y2ammzOG4r1rHDKTXSLvCq0rNxNz9jLVObL99Hmm2xhxTtDgkXd?=
 =?us-ascii?Q?EmkWQpbypbtOPSmw/lhIv+y7H+sCmZDepVTlGCoS8lUD4sBdAUoKifY1oqs5?=
 =?us-ascii?Q?bAjswIVbVLUz+bLwDKYsFdsCAZQzKfebqvzl+5eSJDX66rwyuIfi2ENo+7BL?=
 =?us-ascii?Q?G07MMN3nhfCyH0NEEdP/paySDb1UUwtbjOhl5vyzcVtnBv8ZcTbVKZV6LtmJ?=
 =?us-ascii?Q?NQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DQPCAn/oK09tk9MUqvYR5bhoyHA3RLmU/Ijp8GU18e0Xl/PgoYVr/sPCCaXqKg/SmSb0kAz/9ns9SYxtGzInIj3qA2UTYosYIDj9b9f9LY6EkNed4hzdq+Y0WfvQNogJwj7ULX3jrKNbeXfR9fqyvm9f5DJiSQyJ2I1asfuD0A9Jh1A71mtzHpxOHEzZGo7i11y46pDDNDRwTys+m61SuEk6kKSefqH/K+9wTc0N7WsCerzGBFvMuo81kqusGA+fWEFUViJ+N/lkoauRgHBp168VdtHf8HeiRtXFL0EVitGSJbG0p6QfeajmqF1KvqX1QXi/4UBmxyQhXRM0Cx7mkGbUpi9SugXnZRnEojg/AH/mjFZBP77aUMiIbi5XspCN9upoFBtt9RkeyFx7YQbnZtiXtgynygreyGCZ/RXcg6WybbATjYRsIceeBqHHdoaiEDLC4p5SWzksZELIRyYgJK4VpBFmaFXySToBil8PUY6ABRU+g18pBf6udhNwFquR3g0sJvrPT8IxeB3lb9+x/X/KJcAIdDzmlgHCxIhtfh8K6zQ7vDDaJoi3C/9RJ+g97B6RcEdOcmBy06/Xn17GJJU8cdigKzy55TFA9Dz8xh4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d996bbec-7215-4f9c-d585-08ddce91d466
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 11:19:48.7321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 49w8jwSkRS48d0aokKcyS8QVT9yBVG7S3MYiZxMSgcrttbfZesL45WOufGaynjyw+IqmQYbL9jriYH1xUBJlnVZn/vhglBTzvcxSnVOoiw4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6911
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_03,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507290088
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA4OCBTYWx0ZWRfXzc/vFGCVsvaA
 dLXy9rejubvZGJTmX9HXHvnQH0f3vRsLvaFZFfUVb0XLYd7Q9rGRymGnFPNw6lAJ8WL7C0TDC7j
 1E6RZrxkdTanjsao3C4pJpDLmSDZHxPETRgN7x4rERh/6XnsC3Uxfi1n6tEYiyr2BsCgdJKIe5F
 23cIKO1ryLkD/P98ccTURvjaEbv3boAY8tsezRUwEYerNGCQoK1dESI0R9OuWEF2cwz+UJZsfyH
 QTTMvDldAHVUWrbLlO2Psv6e26AVTB32N062VTdIHrb7x9MocSQVCDj1hawXjzISipoV8mvY5nb
 iIgOJe4b/7JdffkqKJYpYgtbD0Hw/mObuAG6/dPTz+YCIFELY/vTDa/7D57NmqwQE7QJ4j3OmXj
 1MJTSX0fWJ8o5h2W3CTysE1V7qltDSD7MhLZA/3Mu1ckbZeRw4KBZktIQ7KAQxDuKiwjTafU
X-Authority-Analysis: v=2.4 cv=ZO3XmW7b c=1 sm=1 tr=0 ts=6888ae58 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=GoEa3M9JfhUA:10 a=oLgnYwUxfJG3q09AhHoA:9 a=pnI2m26_WTs5bHz79ivh:22
X-Proofpoint-GUID: GRTimtr2ERBJgpVWsTASBFOH4Xvaq2v-
X-Proofpoint-ORIG-GUID: GRTimtr2ERBJgpVWsTASBFOH4Xvaq2v-


Christoph,

> FYI, I still think we should not fail the command for
> !BLK_DEV_INTEGRITY, but just report no capabilities.

I agree.

-- 
Martin K. Petersen
