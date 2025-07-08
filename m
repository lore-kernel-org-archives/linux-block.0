Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E4B2DCF69
	for <linux-block@vger.kernel.org>; Tue,  8 Jul 2025 14:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985414; cv=fail; b=jim6SVdITaVMiswJFp17BjlaLQfPsGL32jTTOxsuwdO6HjpuMkeFtHxmQbdpRfLWVxtTz98niyjyRqqN555B2FA/SODj7hbMCiFzaTUGZrCs5PsW4n6a199TiIEVk/1nJpEtMNJbhyMFFm8+bhowYNqr8jx5WHiZqDf/AP3T/Hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985414; c=relaxed/simple;
	bh=VFugk6Tb08joBbjqePROAFp3X2NGwVfjFCT6Ka51AmI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=F3D8F0LhYhUMKnRaRB9baL7OSpWmhETWartFQ+w2Xg+BWTP9zmhsCjQxlY7J+AbyPfXNWPJbX0jsRRzsJAKG54sbEWjbQp/0jLjWp3p1DwIKUEB9mscrQyjo4jFEQ9Yf1GTRJ0REHjwgHTaDPqXPMYjfqbd8fRvj4UkKM4462hw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=at/g1kO9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=At+pVA1a; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="at/g1kO9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="At+pVA1a"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 568EHFm4012713;
	Tue, 8 Jul 2025 14:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ULFFWSxoisgEy30jf49tHBj896CkTzo34MNquJoIDyc=; b=
	at/g1kO9p+64a8VGoDMS/S6gKqFeKBGsxWS4/2pTyuGmPLC+B05ZfD4BGMz6sZQe
	oa88eJImidoreqBHdqQQtnFTUF8d7d3fUeSHWi388XW10DnlOH4RwSQwlj2GDKyG
	6lx0Qy2exjpBnG0nbHdHwpipu6krMhgd0plDFgZntDttuZ2OBWkBF42OXwog1Ye9
	MmsU21gRDataEMqBOY0eFt34ekZG4AfaWZ1/zv4675slA0u97EGovVVxzTGYa17u
	itqZeSqRC+MnM2gBes1SnVVBNmYPKaCay3RmgxeGl1XezuWS28m8BUsB1aEBR7n0
	HbhZbsywOR2kew0FtAJqpw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47s4y0821g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 14:36:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 568DLNqQ014017;
	Tue, 8 Jul 2025 14:36:50 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2070.outbound.protection.outlook.com [40.107.244.70])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptg9q98p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 08 Jul 2025 14:36:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pBXYRM+zRDJt73+GKmw37LhHjtKtGGd4deLxVou5pFAyd+2uEEiqIdKu65SS7EPB6kE6+BxuoJWFNchdCJwIxyBhM56jSiSKTnRIDu+BQ9lSfKUsgWhYeFTr2HGM3od/tSOvB2jLkXguyGAgKEDiIQmTWbP9GiWlrEvUzFQRmMxeHdiEgohxSfRlIkftF591cD4E9tho0t/LoGb1iVMVmLcI4f1nkLD6HRBd9slzBvQUK7VUBOijbdhxLWvCxSwNJl6HdSO+LinhaREzDoT8ZBhCb5QHl4k9/f4LrHXN40lxWaF+Wcq6JbYgBq1KB/zBle7NcWG+oq40sAe9UKhtFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ULFFWSxoisgEy30jf49tHBj896CkTzo34MNquJoIDyc=;
 b=Z9I7bv7SZ7pJ96Z+Um4LlEy/jNdaDYAmm/NpJU9drdoZs3olYPaAJuWLKIwjORnDeCtLLUpf2CiOsz3IZWRzw/WC3rS7PeBRrmmJ00kfvBqXsMQ4oq7NUsPTyZGYSZLWlSk7X7sAskcHhWm6P3TYVmy2DJk7ljXFHq+sMQTah72rUlljHHaJViLswt7n2vmOZVdp/pUM8aXpNDVCJngAWe0uVLi9WKlNPFBIboR9t5Fwx44IffEA5B9Bj3EojT5VjHS6RiAbovhl5nQGU2XEZla8NW/sg32FE798FxfL9EsLlSVz1eBOlmhDwc2eOMMzfD+UAu1CymYP+ZdYq7jwWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ULFFWSxoisgEy30jf49tHBj896CkTzo34MNquJoIDyc=;
 b=At+pVA1aihGdiea7J+72j/q1RYnMr2ooPQcXubkJvNPM+csNiOi9ZRD0R2jpMGxOIbsYsjsYO3tfLjmrXVBdhJGg3TRg1b6pAuIe+j406P5GprVoQP7nDEIq3EgYPraHlw+nCYyzP9JUH7zPxlijA1IDw5tVYkUr2pX1QlVWgPw=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by DS7PR10MB7324.namprd10.prod.outlook.com (2603:10b6:8:ec::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 14:36:45 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%3]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 14:36:44 +0000
Message-ID: <37df2f62-f5d2-4d6c-903a-de56a6ebc6f8@oracle.com>
Date: Tue, 8 Jul 2025 15:36:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests v2] md/002: add atomic write tests for md/stacked
 devices
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        linux-block@vger.kernel.org
Cc: Alan Adamson <alan.adamson@oracle.com>
References: <20250708113811.58691-1-shinichiro.kawasaki@wdc.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250708113811.58691-1-shinichiro.kawasaki@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P190CA0033.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d1::13) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|DS7PR10MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ff87664-9e0b-4686-57f1-08ddbe2cdc0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjJRd2VDZW5ZVERyTjNJL2VNaTNrTXJFaG9hc2FZUVRCY0hNNXpTd1gwSUVI?=
 =?utf-8?B?SE8zZDcvbEhQbjJSTEJsUVJzZ1M4QTYxZGUwbDEyZFZMR3BKUVZUNTBXQldG?=
 =?utf-8?B?ZllhbWtyc0l1ZGd6aXNMbi9aVnhFN1RTcHJIakx4V2xtaVdyNndiM0c0QWk5?=
 =?utf-8?B?OTN4aHFCNWRzWkVKZDlrUHZGYnlzUG81Q0lMNXRleEdQMHJoUEtncGU2ZFA1?=
 =?utf-8?B?SDVybHk5Qkc5ZmJlNEx0RCtvTlo1TlEwbUVqbkJ5NVoyMUQ4Qk5EOWZBZFlm?=
 =?utf-8?B?ZTZ5bFQvNWFzRCtHS2x3Myt5VEFWVm5kYUpON2owcDVuay9GWUJmVXkrRndj?=
 =?utf-8?B?YXJYZG15ajFXcGJiZVVjMmtJaEpRbDc5S29kTkNyL0phNTRSRXNQbEpYRkJY?=
 =?utf-8?B?bEkwMVR5KzQ0R2dIRGtYYzA4K3JwMmF1aDBNa1dsdkJLcEFiTGdQMWFjd0Vo?=
 =?utf-8?B?K0Y1UHpKQUVwbldjSlR1QUxPM3VmZlJnOTNId1pyU3I4U2lLTUc1Y3NQY3dK?=
 =?utf-8?B?a2ZBRVpXSTNXYk9TOUkxTnZBWW1xWW53VU9hZy94V1ZUdDZXRkxqd1U0NjRl?=
 =?utf-8?B?cjFxeFJ5QnFxc2JJenFyNk9zVlozY3ZPdnNoRmp6YnNYY25aMC9wUzZDdDdk?=
 =?utf-8?B?aThsbVEvSmF6YUJOeFoyS05wNUZ3ZUN4c1pmZTRyRHY1SDJ4blZ0a3V1cjhH?=
 =?utf-8?B?eUUxcEZYc0NFbzl2U09xbmtZNkZjbUh5VFQxczFlRXgvZ1B3a0wxaElHVExy?=
 =?utf-8?B?UVF0VzBmR1JWUExXNE40aDZYRGFjNXAyb3UvUlJGTzFHZ2Q5MmF2anBTZFZ1?=
 =?utf-8?B?VXFwc294S2dROTBOOE9tUzRvWDdZNzNabGtLRHVaTnhVWUtQQXlyMHFDVjQ0?=
 =?utf-8?B?ZUMyS0NzK3NudHR2a3ROQnZHWDNMVkFUMmlCcVBMTkIxYjZaYzRzZUoxcDdW?=
 =?utf-8?B?T2lCdGh0UTZmbUoxcTdYS09kazZGQXJhWVp6Ty82RDZmeWxEWHdvZE53RDFD?=
 =?utf-8?B?MmlsNkxGQXoyczJ1S1dFUlc3LzVoc1p2SHVkaENpTU5YaVNnRG5vdmFqWDVl?=
 =?utf-8?B?ejBnWWJXZE5zUVpRaHZraWNHWTZvMTcvTmR4cnNOdmNyNnpPOWVsYzdYcEdB?=
 =?utf-8?B?YWR6V3F3TTROTk1CRHAvRHQyRXBQa0RJMnNFY3RIaHBOZXZCTHoxUmVrSlox?=
 =?utf-8?B?YkpnZVpjQjU0bGIySDB2RndDSTN2R0lTOGFiUlU0TC9iaENKZ3FtMkhFQVd6?=
 =?utf-8?B?OWQ2TkoyZmUxVmZNWFlibUozT244TllwU25FM05NQ0hXZjRGTjVlUVozV29w?=
 =?utf-8?B?eXRRT2RuTXpoclJxbWtGSjVCaFM0Ukt1QWZQZWxGdkN4YUNTV1lEOUFodHdC?=
 =?utf-8?B?SWtZOG5ML2FUTi9WVW5QTmxUdjNRSnpPRE5PKy9pYTlqWEErTHY4TFY0aXIy?=
 =?utf-8?B?UjNlblZ1bW01K1FxazM1TEkydkF5aWI1T0lURzlKZWg2SW4yK2Z4Mk9Ebm1o?=
 =?utf-8?B?dTJ5RnZOcCtZZ3ZrNXdlYi9YenhLR1RYbVN1RkdlMWZVNUQrUWZ4SWx4WFpn?=
 =?utf-8?B?dGx2RFJabFpGdVNjdU1YcU5pQVVjcU05djVqUDVUTm5ZNy9rR2dZc0NMNTRP?=
 =?utf-8?B?eEVOWXFFVyttWUNpWlZhSWxHL2ZnZDQ1cm9lYUVWS3BVbHlTSGxJM2tGYlhR?=
 =?utf-8?B?dUxSaW5JN1hvRnhudHpBWTY2a1RuRHNIU0VMbTFFM1FaTGt2MjQrdFR6Q2Rk?=
 =?utf-8?B?Qmt4UjlwOXI1ckd3bWs0UlVDbWJYTFFoSUg5cE9yQ0dPdDZRbzBvbTJSbDdN?=
 =?utf-8?B?SFZzWVlWeFdVdmV2V2t5VmpQdDVCelkySk1CbXJEUFV6Z3U2Wk9zVXVncEpk?=
 =?utf-8?B?VW1RbFpxNnAxYjNVWEJxL1JweEJjOEdsK25jck0vRGp2clFhY2NDT2t3Qm9O?=
 =?utf-8?Q?JHXx8jQZNCI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?blNwZHhjd0QzV3puTXlCUVMwWU42V0tnb0ZDYWIwWUR6TEJUZUFjaEJzRk5W?=
 =?utf-8?B?K2x5T1FmQmpSZUtJQ1NpOEZlb05tQ2JWcnJWd1kzR0pxK2ZNTm96WFM1ajB2?=
 =?utf-8?B?czNTU2gzUmNhSE5HU1FsbnVEYUgxZG5USzNyUFJiM1E0K3YrdExhbDA0MHFJ?=
 =?utf-8?B?ZjByYWRUc3pVNnZSZ0piMUVuS0xUQnJJV2RhY1pqMDBvUGdNbVNsdHBwVlRz?=
 =?utf-8?B?YWxRRFBGMG0rcW1RaTVoMGVPbmEzb0NtU1Rxc0tSUGN5OXZoUmwwUStnQnJJ?=
 =?utf-8?B?akdTSDIxWW80d3lQaHh2NVA2UldkbXdRdEZZZ0ZUTUdDaWtieG9TMzBER2tL?=
 =?utf-8?B?eFBFSzd6TkJLNmxNSGZJN2FmQTVIYnVPUjBWMmI1TEhPSGpIWVZMQTI3OFBB?=
 =?utf-8?B?WXhENGpQUGtNMGwzL0pTWUJuOGtnTWduUUxCVEVndGRPditQVGY5WHh0bEc1?=
 =?utf-8?B?aW0yWXVLdWQ5SU9QTFpxS0ZpU1hyVnp5U214bVhHUDVSTGNOcTcyeU1rak9U?=
 =?utf-8?B?SHhaM1FKSnA5ZkwrQlRxUjdycTRScnlqcitpZGdJY2Y3Q000cXVDWFBmN3JF?=
 =?utf-8?B?TnhlcmZBeFlrOW5xbG5SZFowa05TTExTbFhQWjFvTlduaC9xR0lkVEhETlRP?=
 =?utf-8?B?ank3cEtuWlpKZkRuaWJPaEJNanpzVzlVOFEwTkpvWWZzMFhRd3M3dlZCcHpO?=
 =?utf-8?B?OHlGWVpCYi8yRkY2eXdyQjFUc2R0WnhJdkx6eEN4TXZ5dUdhTktYWHZ1WE1N?=
 =?utf-8?B?Wkxxd253TW5LNDhJWE5BTzUzRWxtQmt5N1hwVldjY245K3VDNGlmWVdMU1JO?=
 =?utf-8?B?bUdVTW9EK3RnaW1RRkZnREhyd0gwY2ZPWU5HYmdZZXVad0RDMlBTTTB2aXVF?=
 =?utf-8?B?dCtLd1U0TFBHR0JVVlBUWVVZMlBrWjlQTEd3dzRrT240Q0hZZ1A1QitVWU5z?=
 =?utf-8?B?dTA3R1lwYW02dTBIWUVLSjdDWE91czdnMWFPdWRpOXE5MXJUOWIyTkp0bVJX?=
 =?utf-8?B?NXM2MC92VG5yK1NMaDJPWXVlK1ZROG9mTHhwODFoL2dmNkNmTmRDRHlhZkc4?=
 =?utf-8?B?d1huSXJHZUxjVCttajdqNlhjM1pBdGplU1lYcndZNDJUWW5jUVZycG5IMkgw?=
 =?utf-8?B?Zy9yUXZoQmQwNU14STVYVy9wTTVDRlEwbENZbXFMTEg5eE4xS04zZFEvTmFn?=
 =?utf-8?B?b29oZytnN2Z0TitsS0hCZXhvZU1NNC9La2tXK2hDY0p2dkk1NnBRNjZLUGdI?=
 =?utf-8?B?OW9yN1RXNGlwazZiVTR1NUVpa2kyaGJlMGk0K3FwUkdrejFLeHQxeU0va2E3?=
 =?utf-8?B?WmJlS2MwMVU5Q2g4TGx3bUE4OGRhVHlFRWNYL3VlbzRJeTNKWTM1OUJLR0dV?=
 =?utf-8?B?anIrRTdvMmkrTzcxVUZ4Y1FEcXJRWk9GR2pkTHdNc29XeTVXVE5PbFBmTGVx?=
 =?utf-8?B?MGthME5Da0xBaTJWSjZJTml0YVlMdlEvMXdwYzlqdk90UTRZZzlnOTFCN3dK?=
 =?utf-8?B?ZDFFdThQcTNERnI1REptemkyRFhIR0hJamU3M3ExbXRJdnlReWdENU1EVU92?=
 =?utf-8?B?ZEEwZjMydTc0eXFic25zSldDdHhwQ1NpS1dXOFJ0U3E0S040Tmppc3RJYnBp?=
 =?utf-8?B?cDJCak8xeGlleDdpci9NaVFibGpFa2FJbXl4SGxockxXQWcyR1psMU1PQ3pw?=
 =?utf-8?B?bTBDRUNNSlJham0wR0ZwcmhLci9QekJyY1JDS3NSdkZ5OTVZcFhmMmNXVUdB?=
 =?utf-8?B?dHAwWStQQUoyQzhxTzBRSGE5NS9BaVo3YXFMbDBxVHBhRnZLdkFVbXFFajY0?=
 =?utf-8?B?SWQvVFc3dUNpWTZrWTRFUDBpUW1sVGZsOUNSZ2l5Y0tWbDlHUWRrT1NuTGVG?=
 =?utf-8?B?bEJNdnh4U1pkT2pUOFhoRmo0S3NKZHhrNmY4Q0Nvd0lVZDFQbEp5MlpEdnNH?=
 =?utf-8?B?NUhYNzYzcDBVWmRFSXJqcVNUUFo5THVQOEF4Q2hSNmNLT1hLbnF2aCtDQUJn?=
 =?utf-8?B?RFZqajFHcWFxUmlwYUNDS2Yra2Jsb1REUzltQUZPRUhLYkxza0dPZVdNTmVs?=
 =?utf-8?B?ZHFKRFhYbUkybjBXdk53azBoT1pGL0svM1E2QzJlYjl0Skd1Qk9ubGFBOEJm?=
 =?utf-8?B?R1FBZldLbzlaL01LVUZwMTkvWmJ6b3FidkhGRDY2VWYwSHR1N1E4bnRsMmpF?=
 =?utf-8?B?bkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9gAYba2rokrNLyNtKQOA02Y1jyPGxj5IEMctvEuYFEcpNBNK+HxnCrZ/STYVl04iAEmfmSU7cTrQMLjPb241ydAK36DdyEArivwRRQvtbhwsQ54KdqOwG6w0nK/IQufKPN9ZGiv0KCHDV4dzYpD/32lxSq/wD3t0zUu1lcsCtJKyLll0vh3Tj5T+Or4FUsQq83+S1zVxa9D5ELjRq5GFsDA33VecSsAKSjzdkvKvWeu0Ic38QcPWeNOjq179e7Llu7Rean8QZZ8cS2yvQ6K3+MwB/4Xulo9WPmA5kd6CwE3bQ2krTdyzmJDjWVeAZ96pWr0lM+8bYQ9/6CSGO87RxRa70ZEUPSm6I+FGyzBNWFGxsW03hAUpXMmOEkfTGodeF46wg5fHsJrUKH0JA77Di0xcMFzub3c/pjrCJbziNnFY4E8npL2W1cRN5dnUkxDRMwRjjXsL0BTLnw4f9RrvxUjFZORcKytyZ+l+cBc1D5H2v/ckvHayOBev+gvWFmzo493SHO6IN9ujFdoJDUR/FuV761FB2uGnbuuNjBmdy6DBmS/s9Z/aufmPOKzzDCQDvUYg5kUB3Qu1xs8HrLoYeJlDHd1tAqSSlZoGmllh8wo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff87664-9e0b-4686-57f1-08ddbe2cdc0d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 14:36:44.1078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wjKfQSsN50uv/Mh1+Zdy6ttC2JiW8wQXkAA01WkVlZpJD1S1HEwEjVyL2/JBXpqRm43vEIAeUaRKxdVCcUQRWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7324
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-08_03,2025-07-07_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507080121
X-Authority-Analysis: v=2.4 cv=Fbk3xI+6 c=1 sm=1 tr=0 ts=686d2d04 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=jjLUwymYZhugewzgk4MA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 cc=ntf awl=host:12058
X-Proofpoint-GUID: b6oRDaYQZP2LA23vJpiUu6aHM4QaV5Mu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA4MDEyMSBTYWx0ZWRfX7KKA9RhgIJQz JdSnOn4YsoRM8tKlSTXACLAEFJHxBWFYRWknSmYWDzviRhABzDQQ7bZMRKqhfqOQNSEwTXItHL8 Yz+z/P6RyL/Z5/VMEGuJJ39IjhMEwkXRZEFHt2VvsaSkOCod4WZ3HtAboaUxIR2YU4aNKKIqREn
 09Woq+kOvmSgLFutFrccPZoZkCJbcsTi0rvq73Iv3j1f5u3gEJKhQVzmVt6pn/sDmiEu3lkw+j3 MLX+0FNEn6Rw61ECfiSTL//fm2Nk7JfHXupoDjYHXHOi/9QRLP0yRe+DIdHiN2ywpi9k54QxkvH DGiqhq1CNwt2hROyonVUPRWgjCWxF0+DzAdMimytYH60g18vPQHtiboIu0Jvq6peSeZOIdS+Vjw
 kgQAhDknBQ5FEtTXilAz3p+FhJod5ifaepUncgI/shm4HQKS7hEYGVZzup7MqXF2SwFOJohr
X-Proofpoint-ORIG-GUID: b6oRDaYQZP2LA23vJpiUu6aHM4QaV5Mu


Just a small comment, but regardless of that.

Reviewed-by: John Garry <john.g.garry@oracle.com>

> +
> +			md_dev=$(readlink /dev/md/blktests_md | sed 's|\.\./||')
> +			md_dev_sysfs="/sys/devices/virtual/block/${md_dev}"
> +			md_sysfs_atomic_unit_max_bytes=$(< "${md_dev_sysfs}"/queue/atomic_write_unit_max_bytes)
> +			test_desc="TEST 12 RAID $raid_level - Verify sysfs_atomic_unit_max_bytes <= chunk size "
> +			if [ "$md_chunk_size" -le "$md_sysfs_atomic_unit_max_bytes" ]

you should also test that md_sysfs_atomic_unit_max_bytes is evenly 
divisible into md_chunk_size


