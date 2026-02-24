Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A12213B5AE;
	Tue, 24 Feb 2026 05:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771909248; cv=fail; b=eXBmMqhi7ig8UpONphD47v2PZPoXtVuYJLwo3a/sgxJ9dtlkAVqF855YWbGYUwLDKDuLmEgzab0pkZ1xtVZ8OI2GmgzGecWJKYupXgufDr9/Fd1ndwVBZ9JhWl/LDneRnZrUjtlCWhWYmdJg5OaA0Xibsc4ZMczQp7E06hYMSyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771909248; c=relaxed/simple;
	bh=KfhgO3oXHF/YkKchoKaaXkuVcrxnDJYGBWJWWmZYL8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VUc90VSdi3gffRAg1SzWAcpq6PFbZztQ5EysXKD0QvogA+rdQF0ccNGY9PIchLdKFpmR1fbTe2xE3hFvv4/pM9hDcnZ76G+SF2jEyVndb1X0N/vIRhVv9g3/vEe+lrl8erzoHfYEnPRi86c6CqRJrxumcKk0y2zMyXWOoVql6ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RwKSIpGC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RSF7fR7+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RwKSIpGC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RSF7fR7+"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NMvHW63045670;
	Tue, 24 Feb 2026 05:00:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=59Aq+F1E8ESnf7mfASE+qpN3ibeBc8LQLCWDWXZXqqU=; b=
	RwKSIpGCctjLf53mKY5Yjec18iiWRLJxJcIe53MC+wDSfFNItyYxgp2gkv7Xanwk
	0BK3l4pe3zdYaygI4jCTXQpROproHRahp3bhQipzpEEQ6nJ54cgs6cUexyfwtLbf
	VDPZcLx6gdmdz++AaqEksLHEvfnNe2/uNWdpH/l45BNH697rW78m7zYBzMATvLla
	OfDEXIuverIr58kbpZVmswlYVwmCb3k54hq0VtkxTt7vXWI1vNijTGi4JV/6Zr9n
	7vhZa9HQP+UhHahUWoBC17ITSnqyxkrezbpfDNyZwF1XOTPKmvoxyptjHsFzZYVA
	xJLMzRZdcu1bHBC3D+PE9A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4arbkq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 05:00:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61O2HOap006389;
	Tue, 24 Feb 2026 05:00:28 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013060.outbound.protection.outlook.com [40.93.201.60])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4cf359g8dj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 05:00:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oJ0sh/+I2GSWUyl9USzxUWsm8hdf48Z/N47De6FL5WlUKA75zW7m7YwdeqvK4Xm/hoeV4twvbvBwFpRc+tsC6jKaEJ3f0GQklfvajJYIDbj/As7khUWYV1mACg9NcOnkp5B08NJ76ldeQUfI1NKQceOJir2dbMgKPCDzsGoNvvH00roTSDp9IpkHHrNKhJGB58yGmyBkiepyfhemHGhuO8pjVeJngfRnr6SV7gDnzNXTQgRHUsMBeh4HLxSs0yyYSWruarknDIM84YQQitDPshalzDcQhAARtC6inV+/YhNIqeZ1k4XR/9DvHd4x4eTBCXrT44s5Y70kSqv61DlEEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=59Aq+F1E8ESnf7mfASE+qpN3ibeBc8LQLCWDWXZXqqU=;
 b=hfDWRc33p1DMRDfmTKj+kgcaFyQ0qb8WVXns+5HkfsR+gupfknkaVN2I088g+dQawRK9DvhD2oJu/LSxvmdyJledNeu+5YqYflQuSnrTIqvoWS2yDejz7Ak5sifOi8aW60GNVF4IGZxHZSvL0/ZClSlV9PXs5twYtjFrW/3M1gceOUhWzHNr6DZ49V0y5P8oByOgsLJtQdAhdYYVUTqEkBgigJrsuWZmKJ1fHvL2eNECw+dksny1EgW8FcxCoh+8O+xoTY8DTl/n90xZCff42wiSePr8lp/3xsKwHqstEISptNhmP5TdJ+peEnCXIumZJGCRLW6NRKcJdzqHj/1A4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=59Aq+F1E8ESnf7mfASE+qpN3ibeBc8LQLCWDWXZXqqU=;
 b=RSF7fR7+gmnzHqqCMW8tYjHTeXAYcdpRLiw0p64roDKRcLL+YjzAZK9tHMY9SYmbPA+xq4Wk7Y0qOclXK512iWbbNrKHpWQWr4fh0dX7V7HS1ljaskFMwKjL5tbvUTbCambYetbSawUYCoN4v8gi9+YhMG603Ri9ZOtb1swpIdY=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH7PR10MB6988.namprd10.prod.outlook.com (2603:10b6:510:27d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Tue, 24 Feb
 2026 05:00:23 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 05:00:23 +0000
Date: Tue, 24 Feb 2026 14:00:15 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Hao Li <hao.li@linux.dev>, surenb@google.com
Subject: Re: [Regression] mm:slab/sheaves: severe performance regression in
 cross-CPU slab allocation
Message-ID: <aZ0wX_QuxNTxXHMj@hyeyoo>
References: <aZ0SbIqaIkwoW2mB@fedora>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aZ0SbIqaIkwoW2mB@fedora>
X-ClientProxiedBy: SEWP216CA0123.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b9::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH7PR10MB6988:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ea8403f-2b34-4584-1f4e-08de73619db5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aG5Qc1FRbC9aekRPRW80Nm5QUGMra0MwRGc4NjdLSEVpUGdEemRtWUd6b01U?=
 =?utf-8?B?eDBxandqY1JTWUJyNkNRUmRFVThkTEZLUEhJWXpaMVlKMy9oWTFuOGM2UXA3?=
 =?utf-8?B?Z1V2cHAvOUtRY200RGJOUHFoZXI2ek9WRTZPekpVSDgxN2RscVQrL1NSK0Y4?=
 =?utf-8?B?TFd3KzhWdUdSdFI2TXRCRzVYWkFuNkk2aVIraWtCUWhzbnRsZTh0MTFaSzFE?=
 =?utf-8?B?ZjlucjNGdlRUQ0QwWGhremZPeHoveGhQTStMMWtNbkhlL1pjOFVwam5QK2xm?=
 =?utf-8?B?NXUzTE9XUFBrRWkzbnpoZHdxTFdsZjYwVHVJQlJUbFZpNG1FSitoTGdiZ3pj?=
 =?utf-8?B?ejZBY1JVZ0hYb2NhNEd6aEQ4VVR4V3hUZThSMHRycVB6NXMwR3R1YjRxSk5t?=
 =?utf-8?B?ZzFDbnNvNW05MXpCVk5YV1E2dEZFNFZaQTlGVFBzWWNEVktMTElJM1ZWNk1m?=
 =?utf-8?B?cnFuMFlaK2RJM0xZaGE0YVFleGY2RzViTVg4dlM0U3pYS0MyWkNkb0U0anRY?=
 =?utf-8?B?UTdmb1NiYXQ1SFYvMkdjZWwwMlN5RjN2NWJoWmFNYnhPcThoNjg4eHBucUxK?=
 =?utf-8?B?Nmh4VXVSc2dkSHF5WC9LS3ZjeGFDc1pyWWdmWjIwWTJUMmZmVWJhSVcvVDJ5?=
 =?utf-8?B?VURhSEtzZ3B2Q3M5QmxmREtkbGJ5aFNTSkFNOEwyR3RXdGhDSExxMVUwUWhh?=
 =?utf-8?B?ODhaZUQ4WUxqTGFJNUI5NUVkSFppU1ZubTlJRGtNb1JWMUpMRStCL0gzaGFC?=
 =?utf-8?B?KzN2RU5oa1BrVTNCVWZmWUU0UFpieXJRS0N6ckdhZ1NLREVEUkliOWRPYkQx?=
 =?utf-8?B?RXorUHFwL0hkeWtzaWFuR3JjL3lMUTNSMFoxd25sdmRjQkZZK25NeE0wbmZh?=
 =?utf-8?B?SHBRNSs5Y3dLcThrRk1pQ2toTlVhVk5URDNyWC9lY0ltOFhOR05Va1dzb3Bt?=
 =?utf-8?B?RnJVRHlsb0lFWU03U1N5ZXBpMFptYWx4Z1JscWlPeWs4S1JadFM3ODRxN1Bh?=
 =?utf-8?B?RHR6bVhib0czdUUyTGlrRUxVVmh6dnEyV2swNXNiblNsVVRDbllqMU1ESC9T?=
 =?utf-8?B?cWgzQnE0UW9panhPck1PV0VXeFhFbXpRV0NDSGlQMG5YQTBTdTFsdkRId3RT?=
 =?utf-8?B?Z0ZLNkdheTNydGhuNXdubk4wZ2xFQTRLNklWNWtCY2ZQOHUzdHExcEVGenpQ?=
 =?utf-8?B?NFhPRVROSVFldHFDanltQlFSUFdDZHY2M1BwOUpGV3UrNi9DQTI4TW9oWHVI?=
 =?utf-8?B?akI2a09razBkTHh2VTdHUWMrNzJ2VnhaNmg2M0NUWldCbHNxSWRLc09BS1JD?=
 =?utf-8?B?YThzTERIdzdaaXVhU29rYnd4VlF6MnU3c3Y1R0VzZTh0TEd5V0ltaE9FbXBH?=
 =?utf-8?B?cUpJVElnYXFqbUZTQWRWSmsvNG5jOU4wNkkyWnk2RWtZVStMY3RxWGQ2VVRD?=
 =?utf-8?B?Q3BSYlNpTlU0WTZSRmRCUy95d25aM0NkV21VRE9idGI5QnR6RVRnelhFR3Nq?=
 =?utf-8?B?SFAxbFRyTlNBQ1h4V2JZdUJFN2xsWHkrd0JuRVFoMmdZQVRCRTRpZFRwRmtJ?=
 =?utf-8?B?LytFNXlBbHlBRWt2UGhkdHpudi9DUWtBTktHWkhqWEhmV0VSbll2M3NJbitJ?=
 =?utf-8?B?bjBIMXZnR1p4OTJjak5LNndYeUhud0FVK0xUWERMcXVYTDhKR0w2VEo3Vkhz?=
 =?utf-8?B?ei8yeGczVkpidlhOSU5kdXp3YmRqVHlHQWNNNDU3LzZSbFRKNmY0SGlMdGUy?=
 =?utf-8?B?a08rVzVnZ0RwdnJIMWEzcUx3c1RxNnZqNDZQRUx0RVUrU0E3dHRsYWttVmNr?=
 =?utf-8?B?L1FxTEtTM1p1VFlOU0dNTnZzUlFhY1c5SVJ6NjByS2cybHFySWFlcEJGcGx2?=
 =?utf-8?B?eUVoeG00V2kxOFJ1a3l1ekRhRjNxczEzK2JSZjliYTdlZ1ZqMUpqZ01odHhQ?=
 =?utf-8?B?c012d0tKREhTMEwzcUNNbWxhbmNCdkUyUENIbEIxYjBFbmErakhjcUY2eCtv?=
 =?utf-8?B?TTZtZ3dHZzJmeXZ6VzM4MEs1RFJiSlIvd0JrNUdOQ3FuakU2elhNMDFaN0tL?=
 =?utf-8?B?b3E2aTIvM2h1bVJFR3lyVzQwQ1dzRlpONkUxZmhOd3Z4bTREVkJxVDJRR1BG?=
 =?utf-8?Q?tomo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUUxZ1VMMm0wWElwenE5azJCcTNhYktBWWR1Y1ZhQm5vQ1gveklPTXV0Rnp4?=
 =?utf-8?B?dURRd0k1WGpPWi9sb2RvNHltMENhQkQ4T0RDZlh1Y2tXOHBvaDFkR3ZaaTJs?=
 =?utf-8?B?TWpwMDVuSkR4SU1qeHU2TTZmbGZibUFsR2U4dndSM0c1VS9vVHJDd1U1N20w?=
 =?utf-8?B?eHhmSVUycWJtODl0aTlUSW82eGJYeDZoWHNLcWE4TWdtQnJ3bzNJWUYvejRr?=
 =?utf-8?B?Q1FxZVdQVGpqV3IySnJMOFErTWFtb2RCcE1acXkzV2J1ZlA1Sis3MTV3VkFt?=
 =?utf-8?B?UEhVZVQwRGpVU0R1M092MWczQk1aMFVHc3dNMHdOTThIWU1vWmFzdWJKemx0?=
 =?utf-8?B?UkpLek02QVhLR3JTZjdVZGxuKzZqVW1xZ3hyVjV5WEdkUTJuREZFSDRXQWNN?=
 =?utf-8?B?blIyRXpjU29Na2NFcGQxVjFQRnZrVjlnMTdWLzRvUWtlMjMvSUYxOVhPa2g1?=
 =?utf-8?B?R0pDQXRHWWUwV0Rpa3g1eE1neWl4Z1lPSnlueGFqbDBQVEw2NStrNGxaWHhX?=
 =?utf-8?B?V1ljVlpIWjBUYm1qZmxtYWVuajh4TVpuU2c4NklqTnl1em9GbEU2Y1JPTnZy?=
 =?utf-8?B?aWs1SHhCb2liVkI0UWhLVGdsRW54cjJuZDRsRVYrUGhzZ0Z5QnpsTFNLNXRF?=
 =?utf-8?B?bFE5WjIvZzNweFZVUlE0b1poWkk2UzhVN2VZZVpmZzRwQ0ppb0w0ckxTN0ZB?=
 =?utf-8?B?TVBKS0Qwd2MwREVmSDVxKzVBMkZlc0lvRmVHc2dFb2x4S0xPajUzQW1VT0d6?=
 =?utf-8?B?L1NhbVI2c25uZWFveDJMaG15bE5tcEFMSUFRblR3UkhPYlJhZ3lGa25admxI?=
 =?utf-8?B?TXlJZnEyYk9FL2wxajc0RnVyQ3Q0MGJ2VTBodjYrT0FUblZPN1BwUFB5QnVR?=
 =?utf-8?B?UCtwWFFhRjZMcWNmQkcxQmtyNjhhajNJbXBBS0tNaDIvdE5XcmR1RjR1T1RH?=
 =?utf-8?B?UzBtMThyZmxWQnU2R0dFZFNqY1hmVlpkWElYMlozTzFlQlo5VWFXbU5oS3hQ?=
 =?utf-8?B?c1pBMHR5ZTQ1Y0llbkpkcHEweGR5cWxCcjBNMldRNUk3YzRZSkF2ME55NFdC?=
 =?utf-8?B?ZlRmNVdiTFFjeC9Jc29KQnRIN0NHQTAxUkhOQ2d6SWtYZVJTNjc0TTdhZWV0?=
 =?utf-8?B?ODB4cWZoekdOWHo2S3l2alJXWGd6S2R4WEZJam9yQmloZC9pcFc5bWtvVmZ3?=
 =?utf-8?B?eWhtQlFSU1J0RmptSVk2WGE2bjVJYklSejZSZTVmanU5QStBbUlrak5YRnp4?=
 =?utf-8?B?cFlWNW90OGlBdGplS1M1MWtrc2N2SUtPS1RQMVYxNVhqU1FJL3RtTjNQMUoy?=
 =?utf-8?B?QXJuR1o3ZWJVOERkRFc4MDNQSG11UXpoRGFOL1VtRjEybXdNRzgwc2lyVzZm?=
 =?utf-8?B?WmEyRXhYeVl2NENxUjhPcDYwUnlZdDgyVit1dnhOenIyZ3pwZkRVRVlHQTEv?=
 =?utf-8?B?YWwxN295UkVBUVBDMElHNmZQUHQ3NkRMeFdXS2hrSWFNY3Vlb3Uxc1NSc2Q5?=
 =?utf-8?B?ZXpKOUF3b3IzeHByRUdlZW1WOW1OOFVqbE5DOCtpVUg1ZWY0ZTJDT1E1bVdK?=
 =?utf-8?B?bSthdVVWc2Z5NHIwbjRNVlNYam9tOEZGWWQ0Rit2Y2JlbWRIWGVhVXJZc0h3?=
 =?utf-8?B?eUdHTFJ1VElVWGRGOXIza1daVzlzU1JIZFZFcnRySk9INXVCRFZLWGxhWGdX?=
 =?utf-8?B?eE1QemNvNSt5S0c2cDVnSk85Z1I4N3JXZDBCVkFEd2pmUXlzVXc5bi8vRFNw?=
 =?utf-8?B?VUpCaFJEQ0RmY0dRYnArMUhqc29Vcmo1aG5jeVJlazFqbU1oSDB2TXltdlZ4?=
 =?utf-8?B?ZEdBSEVPTWpHMjNUK3FPbXlvU0IyYnpCamJIb3B2TTUrUExDUFZ6dDgwcFFY?=
 =?utf-8?B?enRlMnZNRVlSN0EzVWZkKy9DYTlDeFJBSzhKeGRIU2p3U3JPSE9CUS9nSVNu?=
 =?utf-8?B?eFJjWDlYZjUwRDFxWk1rRDlMWi92TlVyN2lRMWtZNXhoeFVKVmc4WFR3bXpJ?=
 =?utf-8?B?cExQT1FaclBMN1FOaC9COGE4Z3IyNXdlMWlIN0Ivd3hMVnVhRUR6R29ZU2hu?=
 =?utf-8?B?amxmWDlabnV2alVxamI1clBoZmYxRW5NQjd2UkUzeU1uWTBTb05UZzNaRSty?=
 =?utf-8?B?cGVNOHNCL2JrRHJ5RnF1UE5heldOalRMbUpNWE55Um43RWZqcWR5a1pUUW9u?=
 =?utf-8?B?YzFTdTg0TytHWGxTYW0zYjRsODJjcXhEbHJVNGErZm5nOHNSdko4dWpIVFVJ?=
 =?utf-8?B?dHMzZjQvcFdDUEUzQzNaZUd6REN1K3JXT2ZTV2tDcDl5YVp2aC9tRTR0TzY5?=
 =?utf-8?B?b2hiSk00ZFJjTnp0dmlweTlhcVVuMWRJeWxvTFp3QXNkZTZwRGdsdz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mVrOQaSCvq4qcTI0x5cRph+iPZ8CmhAu2sqYVTtKHuWdmtPKGkgM9E/Ko/7yKqlVLMBfXrx8A/KkeAJ4JbiygQALKUX5GLTZB4q5NWCJr179FtJJCqncbtBW/9MSooOhzv4MF12LoQ/mxdfTjh71MZfWyF6xQycbGtHYqG78ODfrXI9OttYFRDGYAaMQlA0WiyxPZbZ1lNyZniEUAlCLi8l2hnAbNo3mBKUVRmkr+RV0JF4HwqHGxyTT/gwGZ3c8WNBVbtmirmfm/MHcRduU4/p64Zs5fKRwRBhqpQmhfP3ot7V4imqNiLQThlDf9glPazboxd6wcd9d4OW0D4PgI/gKnp4wycEIETp93zkrevuPT872tyQtgKJZPkPDUGUw91GLhjXH/IevlwzpP0QaboaeAqp8NLL0bonsb+mtBbK6jM4SIZ45gmYCyQ1w7Bw7LsTPt3q1qwHL2PSfJGE5Kl23JbtH7vGDs00Pdb+EM9G9nic+sP8O+4O0Au967aZw9UdbjhusTQWsnZFlC1z7SRJZsZrZ3MpdByJoAbiGo3sbrAQDWrPRnfq//dRlXiEoIB7OYOaR8bkNre4QbOFoaAW3wcFiQ3oAlGnDTHSc4dc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea8403f-2b34-4584-1f4e-08de73619db5
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 05:00:23.1270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dvIcOsIAZbOGKp/3cOt+3Zc7jxwsYjjNneb7Ni0LG0m3OHnqFK54b6HcWE3AsJNGFtVtwhhJ7gP+hcFQRV1JuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6988
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_06,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602240039
X-Authority-Analysis: v=2.4 cv=La0xKzfi c=1 sm=1 tr=0 ts=699d306d b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=o1VY4WvCy3Wbkjt97WMA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: CqsJ9n3M5kQFqSZE-o4KEPE4qZSYcC4A
X-Proofpoint-GUID: CqsJ9n3M5kQFqSZE-o4KEPE4qZSYcC4A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDAzOSBTYWx0ZWRfXyY9KEbGKiYqu
 4yDMT7YVUyhxkZ8udN3VEekNpucjBPGmdVuER8x5H0y1zl3cLl+tCBk39gE0Xxn2Vko7K88iOOy
 ZWBA+ulDrvbsQb9slLLSdrdowsYWGiFvffBhFNdhojsen7FhbvlrAZ7p4xIxK0Pt6ZlA1WnmZCZ
 mAmzDkaY4okbMmC4CQSvjN+7TtZAUc8sLKeDxntYYgnijj00BqDRof29p6Moy+5LPnXAU+oHefc
 FccoZ9D6nIYY5ACXupcLrYAtPAiHvMmAkmgBJFXQrkSN8E3TBab3+E2wE60up1l5EJXzuAow6fD
 TrsXo0A8W9Odce99lzx9mwYRMT3sB6qn/lDqmXGuSndAtHxri56D/dP937KeyiqYKnN2YGfLNq0
 NC/Igfu6SR+docm4OrCcqcc4wtg36wprygvEnsIfRtbetBD0cfFtqJCVi7O3zLBz6aIIui91eS7
 r+YdRM7bHU1cafyPHuw==

On Tue, Feb 24, 2026 at 10:52:28AM +0800, Ming Lei wrote:
> Hello Vlastimil and MM guys,

Hi Ming, thanks for the report!

> The SLUB "sheaves" series merged via 815c8e35511d ("Merge branch
> 'slab/for-7.0/sheaves' into slab/for-next") introduces a severe
> performance regression for workloads with persistent cross-CPU
> alloc/free patterns. ublk null target benchmark IOPS drops
> significantly compared to v6.19: from ~36M IOPS to ~13M IOPS (~64%
> drop).
> 
> Bisecting within the sheaves series is blocked by a kernel panic at
> 17c38c88294d ("slab: remove cpu (partial) slabs usage from allocation
> paths"), so the exact first bad commit could not be identified.

Ouch. Why did it crash?

> Reproducer
> ==========
> 
> Hardware: NUMA machine with >= 32 CPUs
> Kernel:   v7.0-rc (with slab/for-7.0/sheaves merged)
> 
>     # build kublk selftest
>     make -C tools/testing/selftests/ublk/
> 
>     # create ublk null target device with 16 queues
>     tools/testing/selftests/ublk/kublk add -t null -q 16
> 
>     # run fio/t/io_uring benchmark: 16 jobs, 20 seconds, non-polled
>     taskset -c 0-31 fio/t/io_uring -p0 -n 16 -r 20 /dev/ublkb0
> 
>     # cleanup
>     tools/testing/selftests/ublk/kublk del -n 0
> 
> Good: v6.19 (and 41f1a08645ab, the mainline parent of the slab merge)
> Bad:  815c8e35511d (Merge branch 'slab/for-7.0/sheaves' into slab/for-next)

Thanks for such a detailed steps to reproduce :)

> perf profile (bad kernel)
> =========================
> 
> ~47% of CPU time is spent in bio allocation hitting the SLUB slow path,
> with massive spinlock contention on the node partial list lock:
> 
> +   47.65%     1.21%  io_uring  [k] bio_alloc_bioset
> -   44.87%     0.45%  io_uring  [k] kmem_cache_alloc_noprof
>    - 44.41% kmem_cache_alloc_noprof
>       - 43.89% ___slab_alloc
>          + 41.16% get_from_any_partial
>            0.91% get_from_partial_node
>          + 0.87% alloc_from_new_slab
>          + 0.65% allocate_slab
> -   44.70%     0.21%  io_uring  [k] mempool_alloc_noprof
>    - 44.49% mempool_alloc_noprof
>       - 44.43% kmem_cache_alloc_noprof
>          - 43.90% ___slab_alloc
>             + 41.18% get_from_any_partial
>               0.90% get_from_partial_node
>             + 0.87% alloc_from_new_slab
>             + 0.65% allocate_slab
> +   41.23%     0.10%  io_uring  [k] get_from_any_partial
> +   40.82%     0.48%  io_uring  [k] __raw_spin_lock_irqsave
> -   40.75%     0.20%  io_uring  [k] get_from_partial_node
>    - 40.56% get_from_partial_node
>       - 38.83% __raw_spin_lock_irqsave
>            38.65% native_queued_spin_lock_slowpath

That's pretty severe contention. Interestingly, the profile shows
a severe contention on the alloc path, but I don't see free path here.
wondering why only the alloc path is suffering, hmm...

Anyway, I think there may be two pieces contributing to this contention:

Part 1) We probably made the portion of slowpath bigger,
        by caching a smaller number of objects per CPU
	after transitioning to sheaves.

Part 2) We probably made the slowpath much slower.

We need to investigate those parts separately.

Regarding Part 1:

# Point 1. The CPU slab was not considered in the sheaf capacity calculation

calculate_sheaf_capacity() does not take into account that the CPU slab
was also cached per CPU. Shouldn't we add oo_objects(s->oo) to the existing
calculation to cache a number of objects similar to the CPU slab + percpu
partial slab list layers that SLUB previously had?

# Point 2. SLUB no longer relies on "Slabs are half-full" assumption,
# and that probably means we're caching less objects per CPU.

Because SLUB previously assumed "slabs are half-full" when calculating
the number of slabs to cache per CPU, that could actually cache as twice
as many objects than intended when slabs are mostly empty.

Because sheaves track the number of objects precisely, that inaccuracy
is gone. If the workload was previously benefiting from the inaccuracy,
sheaves can make CPUs cache a smaller number of objects per CPU compared
to the percpu slab caching layer.

Anyway, I guess we need to check how many objects are actually
cached per CPU w/ and w/o sheaves, during the benchmark.

After making sure the number of objects cached per CPU is the same as
before, we could further investigate how much Part 2 plays into it.

Slightly off-topic, by the way, slab currently doesn't let system admins
set custom sheaf_capacity. Instead, calculate_sheaf_capacity() sets
the default capacity. I think we need to allow sys admins to set a custom
sheaf_capacity in the very near future.

> Analysis
> ========
> 
> The ublk null target workload exposes a cross-CPU slab allocation
> pattern: bios are allocated on the io_uring submitter CPU during block
> layer submission, but freed on a different CPU — the ublk daemon thread
> that runs the completion via io_uring_cmd_complete_in_task() task work.
> And the completion CPU stays in same LLC or numa node with submission CPU.

Ok, so a submitter CPU keeps allocating objects, while a completion CPU
keeps freeing objects.

> This cross-CPU alloc/free pattern is not unique to ublk. The block
> layer's default rq_affinity=1 setting completes requests on a CPU
> sharing LLC with the submission CPU, which similarly causes bio freeing
> on a different CPU than allocation. The ublk null target simply makes
> this pattern more pronounced and measurable because all overhead is in
> the bio alloc/free path with no actual I/O.
>
> **The following is from AI, just for reference**
> 
> The result is that the allocating CPU's per-CPU slab caches are
> continuously drained without being replenished by local frees. The bio
> layer's own per-CPU cache (bio_alloc_cache) suffers the same mismatch:
> freed bios go to the completion CPU's cache via bio_put_percpu_cache(),
> leaving the submitter CPUs' caches empty and falling through to
> mempool_alloc() -> kmem_cache_alloc() -> SLUB slow path.

Ok.

> In v6.19, SLUB handled this with a 3-tier allocation hierarchy:
> 
>   Tier 1: CPU slab freelist         lock-free (cmpxchg)
>   Tier 2: CPU partial slab list     lock-free (per-CPU local_lock)
>   Tier 3: Node partial list         kmem_cache_node->list_lock
> 
> The CPU partial slab list (Tier 2) was the critical buffer. It was
> populated during __slab_free() -> put_cpu_partial() and provided a
> lock-free pool of partial slabs per CPU. Even when the CPU slab was
> exhausted, the CPU partial list could supply more slabs without
> touching any shared lock.

Well, the sheaves layer is supposed to provide a similar lock-free pool
of objects per CPU. The percpu slab layer was supposed to cache a certain
number of objects (from multiple slabs), which is translated to the
sheaf capacity now.

> The sheaves architecture replaces this with a 2-tier hierarchy:
> 
>   Tier 1: Per-CPU sheaf             lock-free (local_lock)
>   Tier 2: Node partial list         kmem_cache_node->list_lock
> 
> The intermediate lock-free tier is gone. When the per-CPU sheaf is
> empty and the spare sheaf is also empty, every refill must go through
> the node partial list, requiring kmem_cache_node->list_lock. With 16
> CPUs simultaneously allocating bios and all hitting empty sheaves, this
> creates a thundering herd on the node list_lock.
>
> When the local node's partial list is also depleted (objects freed on
> remote nodes accumulate there instead), get_from_any_partial() kicks in
> to search other NUMA nodes, compounding the contention with cross-NUMA
> list_lock acquisition — explaining the 41% in get_from_any_partial ->
> native_queued_spin_lock_slowpath seen in the profile.

Again, the sheaves layer is supposed to cache a similar number of
objects previously covered by Tier 1 + Tier 2... oh, wait.
The sheaf capacity calculation logic does not take "Tier 1 CPU slab
freelist" into account.

> The mitigation in 40fd0acc45d0 ("slub: avoid list_lock contention from
> __refill_objects_any()") uses spin_trylock for cross-NUMA refill, but
> does not address the fundamental architectural issue: the missing
> lock-free intermediate caching tier that the CPU partial list provided.
> 
> Thanks,
> Ming

-- 
Cheers,
Harry / Hyeonggon
