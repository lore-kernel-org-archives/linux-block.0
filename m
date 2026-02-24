Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A573043C9;
	Tue, 24 Feb 2026 07:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771917074; cv=fail; b=d3Y9mZe5mPZuKfrpgukcLTOj/QVbaeyq2IXlrXk2X4J0Ho61tgaZC7/8Icdz9g2oILkQSViOq4hauRHZoYrpIyU/6NAXeYInlb81ZrjBe7rZJB2LN3dAMWD3yHeSAGSPxiSC3TfILbcvFZs/MXj1dly0a0uW5LNNA6io8PGTCFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771917074; c=relaxed/simple;
	bh=yMeWZ7yRJpRC5//gBqtN1BdaP+OqrzoV4ZIwwZiizG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hnlDy15/d3t8VioqvmtEngWt6wx9ch23K8654Bp4JEtFFhrOuUH6GVJd+KBvlocqK9Zc0vJUFWhTm2WASVEVn+oldJva5qxg3cl2PUwY2r0lbSGMGcAOk7XGt4h0SjBVGJCulmRBynkxDYDGWpBuqpJUunfX51IyRVOZT9c/Yqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NgJ+7qsl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NBVp1pLY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NgJ+7qsl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NBVp1pLY"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NMv9Pc2589649;
	Tue, 24 Feb 2026 07:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=RDSiMg3oPRRmgKAP3MCcdYwsFO3yQAKoV/i/Ws9Hu+k=; b=
	NgJ+7qslymc6ROTGSECIkBggbhF1HM4CIiFSKPSQ7cF1KOjMv1bWUprizUPdQ2Ju
	m4V2ChNbQXv0pTCKFkmma2MUlQ2HJUGPzdg7Yu6k664zC9FxESXAVHmf/zu+Y1N+
	oWkLbQpXAP3+qcm0KIdu+9QfbOodJao7YsVgcmDujFm0qrFE989+iuKElDLK8sjo
	EYBR8BaBKoVPM2y/yl3D37U1WAPW6u0AgPzOA/TBUesmzfm02kbKUmzKsJr9gUrV
	c5cdH2P8YTLeHunA0z+l0eY+ipHuxbBWupDwGdzVBPRpIeQ0M+Gc+5Gbd8dfEb5L
	oCr30HHTGcGbN5a5qhv0Aw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf4k5un6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 07:11:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61O4pWJk012411;
	Tue, 24 Feb 2026 07:10:59 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012012.outbound.protection.outlook.com [52.101.48.12])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35dkfcp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 07:10:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YKwJZ9whzlWH/Qk/TRIZ5qDYqutQEXYI7DA1130Q3MDcAVt4SoPAlNmhtCh7Bb+CAjTeGaSCSHs83h1ymgGcbPi2QYBiKHSFS8zgN9vtljs6yVu18rc9FqZoWjpgbevlsGsqlg/ESyBRigWA8kfjb+RT8l2R+lwjqJiOCzGnmIQ61j/7KOMetypJaPbX3ktX2/4sJ+ORrhOaZCQJsNvjEhJ7KVOeyVr0QUa5T45mCCx3QCBHsJvr/ZWkxKQvrCNaPn//xCCM167SVzQttbGCowfOfF7ZStu5KNEawgl0bRRC0nSiMJszkpyRwQFO4iIOd2k3R1ku5Yk46M0N9stcww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RDSiMg3oPRRmgKAP3MCcdYwsFO3yQAKoV/i/Ws9Hu+k=;
 b=X+tRBQ/2LzO+IANIjzXorcuKmIajisK9Bu1F6DRzDPU3zEnRr2oLQPb1PGz7iZ80w7woni5eRQKk0W2F2dvGJKCEtpO+loGQYJfgmIOTy+23ptCDq/dQ9q2Dqiu/FJxsiXt6QC8GVcKCnoqkcROi0HXzs7Gq2oZIpKi1LIU1Qs1rPKASZtZWJ+Bbhp2mlj52Pe506kXoCsw0cfxvOzp1Buv0A3j8qt9HdhiPZmMmVCMDQ02ZT3rlwd31JPGoBjRPSkW+KIgxkh+YHOX84lyc45QrDhOtXmpBADaG70LLN381+gu3GUbutMhyvHLUmQAlSA/rba+PcRYG1yQbxqcNZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RDSiMg3oPRRmgKAP3MCcdYwsFO3yQAKoV/i/Ws9Hu+k=;
 b=NBVp1pLYDFXACjDI2C3moZT82B1cNGv65i5f0gdpjdRN3gKX9SMc67rDsqHe1UBJkl9Rjs1GnFxjZ9BtnoEv1BcGqxr46kFspFZWMjRN4YOc1xbRSUEFNDARfgQG8bYdynXCMVBSTyuCO+fdrwZa+yDFtmtsP2/aYTJzQSesmvE=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA4PR10MB8302.namprd10.prod.outlook.com (2603:10b6:208:55c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.13; Tue, 24 Feb
 2026 07:10:51 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 07:10:51 +0000
Date: Tue, 24 Feb 2026 16:10:43 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Hao Li <hao.li@linux.dev>
Cc: Ming Lei <ming.lei@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [Regression] mm:slab/sheaves: severe performance regression in
 cross-CPU slab allocation
Message-ID: <aZ1O82QsjwZVTvzc@hyeyoo>
References: <aZ0SbIqaIkwoW2mB@fedora>
 <wprja2flkybpsmdpnihtxp4usbl4fdsayarg4sitnyn3leis5e@vdqas3zhqndw>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <wprja2flkybpsmdpnihtxp4usbl4fdsayarg4sitnyn3leis5e@vdqas3zhqndw>
X-ClientProxiedBy: SL2P216CA0123.KORP216.PROD.OUTLOOK.COM (2603:1096:101::20)
 To CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA4PR10MB8302:EE_
X-MS-Office365-Filtering-Correlation-Id: 22e235a7-12a5-4331-708a-08de7373d78e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?R29lYmIxNlNjZzU4VEVGNDAvU21Md3EzN3NXQ3RpM1FVclJLbWQ0Y2tEeTFI?=
 =?utf-8?B?OTdhT21QeWJHZXR2ZmZzZmlzV2I5UTNJSFZEclRFQXF4cVFmQmhPTlk1OVNI?=
 =?utf-8?B?ZzBmSGJGMDU5MVlBcHZTbTUvQ0J4UURhUCtudGZrbmZ1Vkk0eld0Vi9Tck5X?=
 =?utf-8?B?Ujg4d09YdXBkcXhpR1VEdEYwbG5kZ2lZeFlNcTBvcXZzQStqNEJsaU4wbE9j?=
 =?utf-8?B?MmtsY29mdjVIeS8xbnV4cGlxZk9IVFdOTVMyQmdHTkdZeTI3eUxQSVZ0ZVVo?=
 =?utf-8?B?L1plS2hTUWhJRm1MWDM3YVFONHAxS0JNQVEvalU0MS9pSldvYVNpQnd6bVFr?=
 =?utf-8?B?dFdvZTl2bkMybXhCTjFYU29DMXdxdzZ4bDhmemdrRlptZW8yUmtSeU9FUUJ4?=
 =?utf-8?B?MUdvM0JMbkJGRVlFdUtOdWYwMTBjOFRsS3dIYWw3SzVaQlpjNGNNRjZTS1Iv?=
 =?utf-8?B?SnllQ2lmdUN3cTNZYUN6VmwwS0hEUGpYdjBmWXltSFJGTDJrRVA1MEU5TzRM?=
 =?utf-8?B?RjUremtQZmlRQmlqOGV4R2xCOG1iZVNucFVTeHpQVGZGa0RleXIyNHp4ajNi?=
 =?utf-8?B?SmgyQUQ3TkFwMWkzdGtxWHMybi80RWhDUTJtd0V4eGcwZlViMEJBWmpWWDlX?=
 =?utf-8?B?djVaKzR2NlpFUHlIQm1BNDBWSERyUCtodjhoK1Q4YmZ5RTUyS0VnNjFmb2xr?=
 =?utf-8?B?eVJvZUFjV0NaaUJ1LzFac3pLR0didTNXUmxvZEVtdnlUK0V6cFJrbFB5ZGNT?=
 =?utf-8?B?d0FTNkIyd1ZuT0toY3hJS1N1QUliQnlFdGtIbjVuZzN0aVBtYzc5SEE1YjJD?=
 =?utf-8?B?dFJ2N1pSZ2RuRUJZc1dpM20wWmtZUjJWS0ttN3BDamJqckFmTXpRdFlQSkE2?=
 =?utf-8?B?NDlYWEU5OVFNd3kzdktCVmpqZTlqV3RySmIyZHZBS2JNRjZzc3ZKSXpyNFlF?=
 =?utf-8?B?eW9XakZnV1IySjdacDltNTJ5dVd6NzRDZWNxSTBleDc0ejU2MzdENit1eFNh?=
 =?utf-8?B?NGtXWEFadXNUUnVrbGdSRE9EMG1hY0hNSW8xdjMycjNzaWFaeFFqYzFlMzRi?=
 =?utf-8?B?MkVnTS8rQkx2K2V5VktwYlJoanNOeFUvZlBTL2xVQnVoVzUrdE9jblJpL0hZ?=
 =?utf-8?B?em94Q2V6N1c5QU1WeVlYOC9sSS9RcmJCeE5PakRrTnBUdDVSbXRCOUJ1ZXNE?=
 =?utf-8?B?TTNJREU2TjdWYzRqSUtFanZJdnhhRkF1SkFpTERZNjFBM1k0N0hIUGlSd0Nu?=
 =?utf-8?B?dHhXSFZBdDdBZHdSYWJnNmN5NE90dDJFd0NMZlZkQUpHQXRuSXdwMWVhRXFH?=
 =?utf-8?B?Q1dOSXJDcVZyQTIyK1pLdmphZ3VSOGhuMExEY2Fsb2pWZnFCdHJpbGZ0SVpo?=
 =?utf-8?B?UTZQbGpkUG5xSzZoOVVGZ2kwbEdBQTYrV1MxNTQvTGc5eUdxSVdyN281UUd0?=
 =?utf-8?B?a0Z6OUdKUVVBZjJuQ2swZTdtbWVVNHhEVnJtZGZqWWhNTkszS1FFSVdMQXJQ?=
 =?utf-8?B?K2daWncxNkc5a1I5MHk4a09FSVQ1b2htbWIrV3c3MHJSa1NJSkp0dzZhMWVi?=
 =?utf-8?B?cGFUKy9WVFMwUXg5MzRjdlRxY1NORHVJNWN6YnZRcFdWVitaUy9NZkQ2bDZI?=
 =?utf-8?B?VXU0eHVVaVBkQlA2YjIwUXI3eXFkYnE2UWIvVzdyMTJNWUxyNmFUQ2FDQkU1?=
 =?utf-8?B?Y1pJMWwxZVZodzcxU05IVXVuRjZqbHhGZWx1NkU4b2YzM3pmL29PQVcxQnly?=
 =?utf-8?B?RGdyTFlOWmFJZ3Zlb3hmelJUb3JNUVJUcEEwajZnengwRi9ZMW85dlFSdnlH?=
 =?utf-8?B?andkVjljSDVoSnZwRjBxbGJ6T3hVQzVQRmhDckhuQkNPWk4xZmx1eXBoYlV4?=
 =?utf-8?B?dWdQM0IyNStPOGhMM3NaaW1tellVVHZ5UkdvODl5ckNsQVFxL0hLQ2kvNmlW?=
 =?utf-8?B?K1pKYWJYVG1MRW95Ti8zVjYzdHVTUEwxTVVCRW91T1hiTWRtZ3prZXh1L2Zq?=
 =?utf-8?B?WGdhRGVLZDJwYW1kNlFLS3RzbzhTbWdyZEJjTVp4Zm9uTHRlalFORUhSWC9V?=
 =?utf-8?B?MHpWb3o0SGdWUDk2OHoxbDJIL29MaE9CZ0RmM3BuWnpzRnFXc0h4Q2oxYnpn?=
 =?utf-8?Q?9WRA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlRjOHA5TGdUWHJnUlNYWnd3b0RyQTdaOE0ycHNuK25kYTVKYXBlZEdaRThT?=
 =?utf-8?B?WmNZeUNOY1JERkVZVUtXNDhkTWYvNEdUTHhVZnhSbm84dU56WS95M3QrVHpv?=
 =?utf-8?B?RmVZMUd6QzdNaGJUTlZmOU5lYllSdlNnYmlPWm81QlBLYld2VjVpb2FTQnN6?=
 =?utf-8?B?cEY4aDZzY0cxQ3pETUppZFpkeWwwUk0wcGZCSkEveTVwdWdaR3hRU1VYV0pF?=
 =?utf-8?B?bXBTVHNtQURKRmU2T0pTYnU3RlVJWmRkQ2FyVjNoc0JQOVhQSjJJY1l4N0lp?=
 =?utf-8?B?TjBDR2VveFI1RlE2czdEbEIvZU9mYzdIZTZaM0ZxQ01OQzRsZDdJbkUyVkRG?=
 =?utf-8?B?SVcvdlM2RHFWdlhjbGMveXkyTzduOTMreU52ODA0ZzlvbzZ3YU54aXdpKzdX?=
 =?utf-8?B?dnFFL0xibzZwa1JObk81SS9XRUFCQVZ3MXpudENlMGE1VXhFK05POW9UejNJ?=
 =?utf-8?B?R0xlWlhnUVM5MTU3YytLanhDbS9zRExBdGhrL29ncmxjeDhNY2VSZ1lPLzNS?=
 =?utf-8?B?VUVEQjEvd1M2MWdwaXZwVkRsdVhoeEpQK2lDQkNIbytnQ2Q2SGQ4K0xtcTI0?=
 =?utf-8?B?WG8vOGJiekR3a09FK0hwK0lyOEZLUXh1QmV1MThIMVdwOVRHRWt0K2dmY1Fh?=
 =?utf-8?B?M3ZhRjhYK2dGQlZ2U0dHUTdSaTVOMGI2dWNMbktkczFlNE9sVlQ5RTFOTmdU?=
 =?utf-8?B?MFRlYjgxYzZabTFlQ2tyLzZjNUhLWTRJMWFkbUt6MlpFUlhHT1JjRzBobm92?=
 =?utf-8?B?R2hRMGxNaUU3b0c2L3FiaktIbFlhV083aE9qd0pQVkN4U1N0L0wvNGx0UEJk?=
 =?utf-8?B?dmVoYnhPMGw2Qm5Mb1p3eUxZbWhsbk51SmxQUnphUkd4ekxwdlM5UUpNUGt0?=
 =?utf-8?B?Q0cvTUMrVWZrcjdBMG03Yzg3OXMxakJLcXhjT1prVTd4dlpsLzl1TlJZaVg0?=
 =?utf-8?B?QkRVS1NjeTJ1dHFlR3phTlhJSWk1TENaeWFrSDNBalNESVVQanBzb25PS0dO?=
 =?utf-8?B?aGVPbTJERk5PSUJuR2N2N0swcnh3OHkwT2VzZHRyQWptSGdpcVJYQWRpL1N2?=
 =?utf-8?B?NUFkVUcwUDlrWFpQdGtaQ0hGcGU1UDNtZ1E4Y1F4Sis5YjQyY1hieEgyMW9K?=
 =?utf-8?B?ai9IdVdqQ1dSOWdGWDEzOWozMFQ5N0Q1dUg2dThvS1d1U1didk11ZXJXOEFY?=
 =?utf-8?B?aTBXMlpCbU1BNjVpZnNieE4ybFlORHA4dTFKY0NreTNobVBPekNQK3dyZEJC?=
 =?utf-8?B?MlEzb0dGZ2lJa24rUzBiWHF0emMyWFJ5eTgvUUM4bi9kRlg1czMvMEVDOWl4?=
 =?utf-8?B?L2dKbm5mQWU5N3F2bXByL1A2TzF0SEVqTXlZRDlXZkV0NStLTXBqOEduYkVU?=
 =?utf-8?B?N3JPT2h4NGxyZmcwZ3lqQ3VTSDVHZE1FVFNzM3pmNUIzU0FtZnRMdjdTbFdS?=
 =?utf-8?B?eVEybUt0S2xXR3N3UERveEFjVzIwMld2amU3ZXpmcVAvTGkwY2U3M2Y1cGtU?=
 =?utf-8?B?bXoxclBGbWZHTHFCRFB1ZTZyb1NVOGZubWhqNm55b0F2M1pNQ3lhZWV3OGlP?=
 =?utf-8?B?QnVzSDN6UEdnblV2aUZYeUtNMDZBcUh3cEQvdldKRkg4RHBLcFN1NFR5Qm5x?=
 =?utf-8?B?SmFwYkFBbCtUMzdvcFNBalhGK0QxV2ZpcE8xSnlkcmJldGV1dkZaK3YxY2hq?=
 =?utf-8?B?Tko4OFhIS2p5clFsSkFzS3NJNFJXb2VMU2JuRVM0TjFldWpOMTNWbEt0UGFN?=
 =?utf-8?B?cjM5cXhZM2FSN2s4b0UrUkpkdE9KRkpSK28wVWpBZkc4aHhvWUt5UnJRajRq?=
 =?utf-8?B?K2pxcWlNaGthZFhtcXpiZ1lDN21GZXhocW9VemNDK0hxeUxzQWtTYy9PODdV?=
 =?utf-8?B?VUdQN3k3NXJiTjRjeCtMYm9COE04Wk45YTZadHJDWkZudGY5dS9KU3R0aXlj?=
 =?utf-8?B?akFicFZQbHhGR3lrTUhUWVZjRzVoNms0NnFZc3VkZS9rVkJDNmtZVklGRW5Q?=
 =?utf-8?B?R2RSNFZrNlBiSWF1YklGUDV6MXRjakZyT2NWSnYrK0dxS2cxaW1oZHphcWpY?=
 =?utf-8?B?cnlmTXVrbWVQSmN4TFFJblVDUDR5Um42QkN5QjJhNExtVlYrTEhtejBMTm10?=
 =?utf-8?B?aHlQSWhaSjc2MUFIMjlFL3pJS0svOWFsZThhSGtMVklsYnQvYnlUT2JFRnp5?=
 =?utf-8?B?Q3VRNGJuTW1ueWpkVFIyY0M2Q0pyNnFKYlcraVBNQlQxTjI5TEdySWZZb3ds?=
 =?utf-8?B?Q25NdUh0ZGVSR05wOXZDUnk2Z3AwaGxKSms0ZGV6SEdXMFpxVEg1c1o1WEdo?=
 =?utf-8?B?RHNwWS91ZEdEMVJNb3g3dlpwTFljUUJMNys5V3UzMlFzM1FlcHZlUT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zLwMBTD5Pp1tRPZ2xFrCjCrveX71nPSwjzcIlGdEKGT0CfF2/la05beLU+cV/J4C4SrY8+xMi7UklGG9TcuzAkwX92husWJomzXE1IMX47zFeO/grpj86Jq4TrZcHJz6JEsiYVI6/MZTIv31hqOLqqzPl31ZI9P3fNRCgvHUn1gVpSuPEN41y6x3TpUon3Hg5wluVNs23LiGdJouZpYeM+T2+jy4ieYBUSaXa+2Zh4UNH9HhWqnvHsY7wLks7pdjFy4Tv1IkvgfTw2YzKZnjV0EnL24ODhREw7oAB617BoRwrKC9PZKU39cFjNipc9SC1IiiALYGrXw2X8BYfWSakqZ0NPQ2s9gz6cbSPR5OjgEby4D5paO8dlzAEZTYSDnR3GKzLXwtrNsYHuNPTsLox5EAJrX5poQTFvGow1Zfu7cN6NCELJuL/6YyyURknW04oVlvadNJ2VP+XnmnyJgIUBRwTMUu54znxExNSkInt6wY0I8OQhYb9eXHdL3WM9rFxA5X0CkcrUSNkSTIXFx9P50ib3NByxYEMc3USZMjs4qpW9108P2AjdTVARGyDJOQgwfJB12474MdfvsxuiR+BWTIaJlPX/0rZVFm+6IuGJA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22e235a7-12a5-4331-708a-08de7373d78e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 07:10:51.0715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Agmnqaboz/s3g+b00PdYrotrRG0h96TW243yqplQTBwQcgWAiT9nGdhHsUVP5VI6WXS8FTU1HJYyG2Oej/BTwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8302
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_06,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2602130000 definitions=main-2602240060
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDA2MCBTYWx0ZWRfX6BDkTh5LGUBw
 7xGwoDz92+oIE+qfxNCSmufOT8UCSaqa+tYwX7Z6kKoiQAFTCSYeWtuOHflU9UNETsR9UpMMwfR
 JZd+Dq68B0AA2YPq8tLA6Tt0rzhegehIKeo6cfrOjhtAdAitAQZddeJ0WwX2+pALq7/A1yLvb2s
 nG4NAbzbgyVGP1FG7iCFgGsSexBJH4JAtp3zexEduwPEgRPmdT3pQfl7FdZTzTIFbBzPUzjIEoy
 YaFYdyCmcdKpEWdnybpG5WKmli7i3lxDi1AQ5J4TGEQRFXLOOBBNo0BIQbgKmAqWOU4eznT5pJc
 vG7j4b28Z123fL29QmhUdvX3WPbn5tByC/oIw3JxfJOGSTHF5oIRrM80fRXwJZTjDNe5WoevNC0
 vxFw9nFUq9p+9bODN33G+quWhTz9z0b61VsLfzyToa1KMnK41nTttde5wbeSsnd1GbLtVsYb77o
 dADbKHLQSvsGo2nJ+xx8rm9SEtFOz/Zzk4C+/8fo=
X-Proofpoint-GUID: IypZWYipklKFjXslQ7-UbDu1xjB6ZIjq
X-Authority-Analysis: v=2.4 cv=b9C/I9Gx c=1 sm=1 tr=0 ts=699d4f04 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=LmOHflMwc7jHcjTWKWoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13810
X-Proofpoint-ORIG-GUID: IypZWYipklKFjXslQ7-UbDu1xjB6ZIjq

On Tue, Feb 24, 2026 at 02:51:26PM +0800, Hao Li wrote:
> On Tue, Feb 24, 2026 at 10:52:28AM +0800, Ming Lei wrote:
> > Reproducer
> > ==========
> > 
> [...]
> > 
> > the result is that the allocating cpu's per-cpu slab caches are
> > continuously drained without being replenished by local frees. the bio
> > layer's own per-cpu cache (bio_alloc_cache) suffers the same mismatch:
> > freed bios go to the completion cpu's cache via bio_put_percpu_cache(),
> > leaving the submitter cpus' caches empty and falling through to
> > mempool_alloc() -> kmem_cache_alloc() -> slub slow path.
> > 
> > in v6.19, slub handled this with a 3-tier allocation hierarchy:
> > 
> >   Tier 1: CPU slab freelist         lock-free (cmpxchg)
> >   Tier 2: CPU partial slab list     lock-free (per-CPU local_lock)
> >   Tier 3: Node partial list         kmem_cache_node->list_lock
> > 
> > The CPU partial slab list (Tier 2) was the critical buffer. It was
> > populated during __slab_free() -> put_cpu_partial() and provided a
> > lock-free pool of partial slabs per CPU. Even when the CPU slab was
> > exhausted, the CPU partial list could supply more slabs without
> > touching any shared lock.
> > 
> > The sheaves architecture replaces this with a 2-tier hierarchy:
> > 
> >   Tier 1: Per-CPU sheaf             lock-free (local_lock)
> >   Tier 2: Node partial list         kmem_cache_node->list_lock
> > 
> > The intermediate lock-free tier is gone. When the per-CPU sheaf is
> > empty and the spare sheaf is also empty, every refill must go through
> > the node partial list, requiring kmem_cache_node->list_lock. With 16
> > CPUs simultaneously allocating bios and all hitting empty sheaves, this
> > creates a thundering herd on the node list_lock.
> > 
> > When the local node's partial list is also depleted (objects freed on
> > remote nodes accumulate there instead), get_from_any_partial() kicks in
> > to search other NUMA nodes, compounding the contention with cross-NUMA
> > list_lock acquisition — explaining the 41% in get_from_any_partial ->
> > native_queued_spin_lock_slowpath seen in the profile.
> 
> The purpose of introducing sheaves was to fully replace the percpu partial slabs
> mechanism with sheaves. During this process, we first added the sheaves caching
> layer and only later removed the percpu partial slabs layer, so it's expected
> that performance could first improve and then return to the previous level.

There's one difference here; you used will-it-scale mmap2 test case that
involves maple tree node and vm_area_struct cache that already has
sheaves enabled in v6.19.

And Ming's benchmark stresses bio-<size> caches.

Since other caches don't have sheaves in v6.19, they're not supposed to
have performance gain by having additional sheaves layer on top of cpu
slab + percpu partial slab list.

> Would you mind also comparing against a baseline with "no sheaves at all" (e.g.
> commit `9d4e6ab865c4`) versus "only the sheaves layer exists" (i.e. commit
> `815c8e35511d`)? If those two results are close, then the ~64% performance
> regression we're currently discussing might be better interpreted as returning
> to the previous baseline (i.e. a reversion), rather than a true regression.
>
> The link below contains my previous test results. According to will-it-scale,
> the performance of "no sheaves at all" and "only the sheaves layer exists" is
> close:
> https://lore.kernel.org/linux-mm/pdmjsvpkl5nsntiwfwguplajq27ak3xpboq3ab77zrbu763pq7@la3hyiqigpir/

-- 
Cheers,
Harry / Hyeonggon
