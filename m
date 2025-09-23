Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9481C314B64
	for <linux-block@vger.kernel.org>; Tue, 23 Sep 2025 07:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758613896; cv=fail; b=NgQaoIB/D6mg7TYhruNyYc/PgQfzX5UjjKRrr6T9u44QyrSWOwFVImpKZQuRCkdcSWWlu2uSQWZh/x7ctbktAmYax5opItrTkbOsiVfmg4BBHSOjCQGwKdqI+Ibu540r7jhtp/680TtG6vgf+jj9TInW5cEpMSAN23g6RZVOCDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758613896; c=relaxed/simple;
	bh=9xelq8ujOMXn1Nlet1SxdmRA8UjNDIVib5DTt7iilWo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gRcKm10kEogxQZcxq+iHk7b+ef1a5TG6W6M1kW6vi1vjjjIu/hj/ULsvi52DlMyWk6aSzf6oEeIYStfy71Hp5ms+Tt/x8FZGk9p9gvTfzRhhAK572xodtYbCtVtx/03XHl7uurfHHDmNFsnJ+hbxlxOYBrNWehmQImSo4qAz9jo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e44bO+TZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Asjkt3Q7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e44bO+TZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Asjkt3Q7"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N3FKvc029568;
	Tue, 23 Sep 2025 07:51:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=PHnhlw6YA7bhOqwAlLXSHdGSK5hM7/1XE2XBoMC/+Ts=; b=
	e44bO+TZdFRhAaunQQd6zrhmyNIzGB3xalqmK6EpCzURYcSUxyfHz+UbLRQz+wr3
	DnNuFrHkYnNXKuesEpmZkMOeW8SVnB3BWPT85Bwe5GezoZUL8t0N3pBx6WzDpM9h
	ujnm5VAIuK8TEREqOWi3vd1Q3N3umOSKnMOkg5K7Dc+90OIz39+QZXvWuTWn4vP5
	3hj7CWDYq3ussERAF95FsNWvQhoDjYCYjBdwnMjjaPN4V5gDtd030DVgkx/4n2Ly
	1uy6TggjzjZvCUD4OOSU0qzNacicfkhXu3y1Za8+sR6wUSOgKqoN+vDdRFtajToA
	xQ1s1BCEhFd/yMY8T3IHDQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499mtt419u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Sep 2025 07:51:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58N6ciBM030540;
	Tue, 23 Sep 2025 07:51:17 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010034.outbound.protection.outlook.com [52.101.193.34])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49a94xyrdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Sep 2025 07:51:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lPCB+AIIb801E8XcyjodwHwct0YhzLMebqB0llVOLCOGxtjcpuIPZChb99Ou2+UW8pTTokIASK4XKFQXcuQ2pJ/Wva+HJ0pWuO/nuvicLi6B+DDy1QUTb9jf90PbYCaexgac8ZixM0qjd3BNGM9kz3WG4qdeA23m20xhn9XDkTd+4SgFD0gHUyDHsLS7/He/8WX3nG0ilUVssTJ0yNnXapDx3eP247fGVm+Nx197Z65nRUw47o33vSiXifv3T+VB94pf49/mtHFCFxsybkJvc3nimlXIlJln98YTFyFdPnupxdbS0rReIY57+f+LQCh0WKzBVplP9MVpalfLQOwRhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PHnhlw6YA7bhOqwAlLXSHdGSK5hM7/1XE2XBoMC/+Ts=;
 b=aHRZSZDGUS6PPf0il7Po2OTukQEHNedIo+eUIzDiiPnMGsCNK97jftYVM6jdI/OSrBJumIAlByoE2Ql2AKt2lmStoMQ3sHKfdFgDu6ki+pX5PvnBDAQZnKIQi898JDL/lE3hOUCFpzA07hUTCf7zqZDtXlrvPzqCFhrI0s74DJpcqZBGRD+SNHmrSOGEDs12RFS8NGbWICP2PjTUHaFPl+j+ohW6F3kAjgjzIECgSIr0L5XcaMGIx1L1StU4p3fuK0vDldcHUypbxH8Psfdd6dU6PsLRmsUCTvkDIiMrQLT4BxsF/xpVGL/+v9W4cSgpj+YX1QLtaihPXFmHwiInMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PHnhlw6YA7bhOqwAlLXSHdGSK5hM7/1XE2XBoMC/+Ts=;
 b=Asjkt3Q7oKY+UlA0c0mQSoqcXogd9g+n0oGYRBKw8CHCrYgjhNHGRDvZtDH78oc0iO09g1vG6Q028aFIQ5RUjR38U+Xq0/g23oHK/IoYBSXHtUpvX0IdSVfKW8d/gEQu8sA5CaIOy0YJXIcRr6lN6PyWIGQeixwiqLMgDXXm3+s=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by DM6PR10MB4202.namprd10.prod.outlook.com (2603:10b6:5:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Tue, 23 Sep
 2025 07:51:14 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%5]) with mapi id 15.20.9137.012; Tue, 23 Sep 2025
 07:51:14 +0000
Message-ID: <d61889c5-a3e2-4a4c-a569-041c9f3e916e@oracle.com>
Date: Tue, 23 Sep 2025 08:51:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: Fix more tag iteration function documentation
To: Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@infradead.org>
References: <20250922201324.106701-1-bvanassche@acm.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250922201324.106701-1-bvanassche@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0609.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::11) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|DM6PR10MB4202:EE_
X-MS-Office365-Filtering-Correlation-Id: 58b69bf2-4973-4d33-b426-08ddfa75f82e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1UvQWhrK0xFaU4wQ1ptUlhta1RFdHMzeDhNc2JOcHhkQTdaU0ZhcTZQM0RQ?=
 =?utf-8?B?amNoOS9vS3ZYeXBZZ2lPSU9NRVRXbEoyMklCdURzbzNMNDVDQ2pYTUFRZ1JS?=
 =?utf-8?B?TlZJQUpRSS81cTk2a1RyQXNFNGQ2SC9TZHpuajRWampJZWRNMVBCYXB1eDVP?=
 =?utf-8?B?TXJ5TEVlUXQ2RCtsd3RSQzJ3d3JjSmYwdDZzWE1vdE5rTGFYKzNPdXNsR1By?=
 =?utf-8?B?RWdZZEl3ZVBRVld3aGRTemQzMFZGbDBHc0o1Y1pPMXEwWTN5bmhtM0RaQ1Nm?=
 =?utf-8?B?TmdIUjVnMy9jQUpRaldhTVpkdkhENlorNldrbDNremxpTnF0UjZlaStPeTJa?=
 =?utf-8?B?SnR6bWJvYlJXSWFIdzNjSkp1U1htU2FobVFsa29SbGRoVmtzeXROYVl6WndP?=
 =?utf-8?B?cmRQRDZZb1lrTDZadjBsRzNkbTQ0YzRsVzN0ZlBmU24wK0JBaDJVNmtKT2dV?=
 =?utf-8?B?UXFHQ3hKME1nUW5vc0lwSEFFaXlQS0RWVXlWaE5sQytIMnJobk8vRG5pV0Ez?=
 =?utf-8?B?UTRBNWp6dDlyTmwrY09KTkRWVFA0WFFPT3pBTThJZDg2OGg0TTE3QmdlRWNI?=
 =?utf-8?B?bUQrV2N5ekpKbHIrSk11eHVIUkZhbHVJTkFHdGpidS9UR3pSd1E5SHlMS3hu?=
 =?utf-8?B?eGlkZndRV1prTnlaNXA5aHlpRE9FUWhuWlV6N0toQW1FZFZXWEI4eldmYUQw?=
 =?utf-8?B?VGt3ajZDb3dyVFVSb0gvYWdHQ2JxUnM3T0dzbS81ejhUMDhkNWNYMHEwYk1T?=
 =?utf-8?B?N2IvMkFqalZuMXNPZVdOM3pjK1dPek9QbXJnZFpPVTNwSHllY0VmS0ZnRGFv?=
 =?utf-8?B?WUxXeEJIQ2JOSkkwQWdvVGFTUnArTmlwVkJ5blBybzBDLzB2aHZIaDhXQXg2?=
 =?utf-8?B?RnRhN2tkWHhhZEV3OVB2U0g2TldxS1o2ZHBSRHpPSGNrVWhjQlBnaGp4VGV1?=
 =?utf-8?B?WUdJdng5RWsxVUlScXRaQWR3dGR4QnoxT2hyVm1HOUl3Q0VzZnVtVkhOazRk?=
 =?utf-8?B?VmlNT0UvaDJNSldnN0dmbXMyb1VaV2JEVUV4RS9GSnJQN1FBbjk5TXNUTXlo?=
 =?utf-8?B?Z0VyaDUxSXhFMFlrUnNsM3N2RFNmWDRoNVNrelo0b3RudTNZSW04Y3B1YU1y?=
 =?utf-8?B?MmptRmhIV05OQTVaSFpZeEM0U255end3aktwbS93R3hsZHZPNHhVaXVoNGN6?=
 =?utf-8?B?R0xGRFcycGxxZk9qVjE2ajUxY3VGVDAvb0NWMitQU0pYUDZ3UUwxcTkxN1ZS?=
 =?utf-8?B?WWF2RFJuRmJwa3dpbmRBZ2Q3K2t6Uko4MU96QVdHN01Sb2dqN2ZVb1BQMjgx?=
 =?utf-8?B?YVpKbUh5d0RESGVRNG5ydTFYUERqQldmbHhUNnp4bTZUZWExNjFVUGVHc3dG?=
 =?utf-8?B?OXBTWENSemZCZWZ3dnNsbDBlRTJldUJsOEJINUtmRE5wczUzbUNkNjVPQWZ2?=
 =?utf-8?B?QWsxNXA5SGRGdEtxM2Rxc21CQmJsYmJpRG03b1hxTTVNOWJzWXdPUlZqNTVD?=
 =?utf-8?B?UldYMDFsYmc4d29TUEJmL2syRXUzdVVVVW1HdzcyL3BhSlNKV3VOMzBuMExt?=
 =?utf-8?B?Mkt2YjdiK0tyV0dlTUIyTm1pZ2xXWml6QS9hdVdkZXFOUm5abi9JbTVKSjE4?=
 =?utf-8?B?eTE3RGkrNDAvN1A3MGoxdmVYaHlJSE5TeG92a3JVQVlIdWR3Y3ExV3VHSHRF?=
 =?utf-8?B?K0ZWTHk1dlJlaXdHbGJIM0hTU1lGeFRWTkZZZUVORnFMZW5EaVQ5YmppWHhK?=
 =?utf-8?B?MktqWjNKWDJvYVhRV3NhK2R5RlpucWhKTEJvenNta0JMSzRvYlpZQkZwcm5Z?=
 =?utf-8?B?b0JTbnN3Vi9ISThzZTI5aFkyd3FiMmNubW5qU1dTMTFxWHNrdGlUN281eDZi?=
 =?utf-8?B?cStHOHVkcG5vSzZxaGQ1eENzSExUdlBaMWlQZW1uMTM4OFNwUzF1L1JNNEpW?=
 =?utf-8?Q?OQQ0mfTV98Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R3NlZ1VSaklWRU9NUFRqU095ZDBkLzBhVVZGUEV5UC8yTG9jbXFwN3djV1Rv?=
 =?utf-8?B?Y1UxbFJmSWFHdWtrNTUyREFCUFRkczRuY0tua2UrTExRaTJhWmdSbVRXeWlY?=
 =?utf-8?B?NU5ObDczYktDWmJleHk0Z05xRTFYcGJpNmZ1NGpSelVqemNTWVhmZGpnZ29Q?=
 =?utf-8?B?Y0dQVEZsUWtpV0RwbHpDekZLZ1NEK0RkUzIxT2JEYWZMVGR4TUUwbDFIbUNO?=
 =?utf-8?B?SVB0ZlYwdGd2YWpvaWpsYXZNS2FUWm43aXUxVmNkVUdpTDVmTTVQaytDQmRM?=
 =?utf-8?B?YTFJRkZaczE3Z2h1d1dQT1o3b2M0OTZDS2dQbHNtandHa0JXd05MSStOSncv?=
 =?utf-8?B?aXluNzVXRE1tblVmazhlTjlDcXZSRmluWFl0R1FqajExSVVwa1hOZFpMMm1Z?=
 =?utf-8?B?Y0Q0RHZuM3JuK2ZTaThiTlN1QThKbHNqN28rd3E5UWtrWExOVDQ5VU1sVks0?=
 =?utf-8?B?clNIV1lEZlVleGIyQXovOUZPaG94MFFFU1hvSmVBQncrMGxhaUpOdFN1Q1pv?=
 =?utf-8?B?Y2tCQnpoeWlRc29hZTFtVVhpK0F6TVkzRHptSzkwWDc4OExTZ0RpL1Z1ekRj?=
 =?utf-8?B?cTd5N3ZyUkUwdHZoSkxtUFI3M1dJeEVRNEp1RW5ZR3dOUXVpcDdwQ1pZRUdo?=
 =?utf-8?B?WEE4UElqWHN5dFo4QjdGRTlGd0VmVkZMTzZnZWJvblBWVmx4c3BkTG5VSEU1?=
 =?utf-8?B?OFFIUlNrRjNJVENNcnVYd0dMNnpJVnVLQ0wwR3hDdVZreUtCd29LcTI0R1RU?=
 =?utf-8?B?Tm14UmlQVmdYL204MVBBRWFkMTNZb1JabXIvT1F1Q0JaOTduSEZQNUpCcUls?=
 =?utf-8?B?UStJbHJYbElEWmNBQWRqRk9EVWx4Y2R0OUhyd3Fpd2pseVp5Nytud3lEYmZV?=
 =?utf-8?B?b2kyRjg2K3BFLys2NlhFWFNDdXhJZk9OUlhhdUkreUlPUDUwdm16VFpyQUov?=
 =?utf-8?B?WDhEeElQa0xrL0dNVjBKNHVmaEZlM1B5eE5XTDg4aC8vZ0JETHE5NkxweXRm?=
 =?utf-8?B?bTl3QmYxRGY3MHdOVzhxWWErZFRjcDVDRHdkbFdhN21USzRDYzJxckJxRTRq?=
 =?utf-8?B?dkdYZnlwb0l6WDJGYVllMG8zcE5SYU1jbFMxMWtuUUxZV3A1M0JCd3paTWl2?=
 =?utf-8?B?TnVUSHY5Nk81RmZ2c2s5Vm5jZk5rTGFHVHJIRW5yUm1JVDkzZEFDY0JiYStt?=
 =?utf-8?B?SDNpZHA4bHh1R0FEVm9QbDdDeWl3Rk5oRFV0MEVqbVhUUUtGZzBWRmtjOEdt?=
 =?utf-8?B?SWVVYjVWaEJaUGp1M3BYRit4enBJWmpORGFUMVdWTE4xY0wxdG03NjBkS2Vw?=
 =?utf-8?B?bmVvbGVBekErZ1BTRklXbTZsRldGamdBdEFXUkJsejVQbU9HbVNvb3ArNE5H?=
 =?utf-8?B?SU9XMVppbmNCa2tGTjBoVnJKZWprUHptS1NPT0RmTUUxb0V3NWh0M0svSTZP?=
 =?utf-8?B?bHU3RnFKc1dRY0drVmxaWEdJOUFod01ObVg2dHgvdnVZMzJFSER4MS9yREh2?=
 =?utf-8?B?ZmdPdTMvZDhMK0RuM0FFSmZlUXFvYjRLV3QrOThpb3c0bEljU2NhMGRwbUV2?=
 =?utf-8?B?WTJJcDV1SXkvRW92QTVud0ZKRUpqNnRHK3pqZUtvb09hT0V6dnpiajRyUlJt?=
 =?utf-8?B?dk9MWDJKdXVCa1V1SjAzTHhvQzlWSmZmb3NoK29MZVVkWVJwT3h1a05TeTdB?=
 =?utf-8?B?anlQdytqd1l0bU5uVW9VcVdkTWJOTFh5YW15OEVBcHp3ZVZ4NkxtOTVaLzZ3?=
 =?utf-8?B?ak9tbkFrZnpLdnRqeWdyeTBnWEdDUVkwWGxsdWJMZXFnRWVQOHRLcnMya2Jh?=
 =?utf-8?B?ZmhUMGF1M3RSZ05oWU9JREZIQjA5VnQzUVRBbWdWdG5iNlZhYzRSeVNWamtE?=
 =?utf-8?B?ZjNzZmkxSThicUZLbzBFNFFmMzdib1hCUFBMdWcyWlBUcVpYK2dlZ0QyeXlm?=
 =?utf-8?B?YTBndzhVa3RvVWNXdlhMS042Ymhialhtb1pwa3N2TE9EcGF1amJFS0dZQTZX?=
 =?utf-8?B?UUptdyswdGJxZzF1VXI0VWNBeVpPLzNWNFJ2aUxZMWlMWEpNNUlMRnV4eVRB?=
 =?utf-8?B?M3g2b0Y0Vm5CcnZpS20wVHd5ODNBaWVyL1hNUHRHWC9QUDFJM204NnYrWjdW?=
 =?utf-8?B?ZWZvWVhoYjlYY3VUQVEzL2picVVhYzI5Tm5UQTEyV1hXbVZGVVFOektsWldk?=
 =?utf-8?B?R1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9NZ3GQUsGdxVROdSSN7qRKnfS+rEH4DEzY276aWtk9ct+DV5N59cwhA6LC1ZbGqZGTMwPFESmg23+aSbXcTsjmMCEsZ0GWNBkWvN4oaZA5kZ+lgmO9TURwS+udUg4XYwmYYryG+ajgFqZHHEzUYjPSwHiVjX6ZrziDUrddNFQWJYGIgLNtppgqdh7zLba+HLkQmConGjPB78Z1mlPxMSDB7BS3VtDVM8oZVkj2Zi7JNBYOVtYawcbhQe+BvmmENG+JxOmektGiFlyTBjhXQlPshArfP/UysvBW0eVVwepUj4Cb5vvRkUUuVHt+lVTz5H1zLQh0HWlsiRieVyz9n3WX43QP75W0OId4vGQEE77UCEMEZQ7+0IF/9EWyZE6nQx1iKAx0ojQ8pLQdhDK4zg2cv6UH4EQ9v38i7l2LOg9nNlhjpjWkdkrmi0zxp79lo29XKqGLPNsS78HGt/4KL1+ZVgMaRwJ2J/g76sOAFjtDQUpCrEAcdAidwoaU7iJP/PeNcjxj+LWw9ormn+2b9RzhsZo02NQyZMB83GZIEizSYBFS/C4xeTRYerjakkJgLzExnCc8HjzLHhoUhxpJ+SI2w1ltij+NNG7TxHCKQVPxM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b69bf2-4973-4d33-b426-08ddfa75f82e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2025 07:51:14.0573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yjT+RDyAL7edekxmM/gUUi0eg8EJZgZ9NFRK+Y9FiXk3DLbc+n7jP7TSjPFEL32O7A6h9Zay+lSgf708xnUpLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4202
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_01,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509230071
X-Authority-Analysis: v=2.4 cv=fd2ty1QF c=1 sm=1 tr=0 ts=68d25176 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=JfrnYn6hAAAA:8 a=N54-gffFAAAA:8 a=czf4lBPfndYUKnitABMA:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:12084
X-Proofpoint-ORIG-GUID: 6BVylHR34ZnMhLP-RM4C94FnVDU4Gmne
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzNCBTYWx0ZWRfX9KUDiBWpFUWu
 8YbcjY2LnlLvRuiTuF0s+34LBKkdqeaO/vTJmMEfzGYNnbbVOciL8ZuqC5qW10TKBxG8j2DpDRt
 YDiiId2nElVBXnPabUQjgSlX3W6jkSNDd7WbPU9c0AqaeYJ5AdqOsnhJM835E37rsyPZfL+EAYX
 xyD8HuPfTOpYwsUAJjQPK7AThq+nDRjZBrEOUVbIm4Wca/FcSIP4oQfP6zHm61mLl27cWzunYk6
 FoanYGERuwoqzmImDX2Vlcblez+BQjqc/Fvwp2opLy0tKGSuybs9u77+sTjxSy3SOpdY1aLaKXX
 UNetojc87DP/qBi7waoxSXmKtjc9W07srzsEZz3YF9XNXGI4WHzYazd8dcciPnEvPsD2WDZD4xj
 ClKNDBqKZ39hYhyaTQ/YCblPq5St6g==
X-Proofpoint-GUID: 6BVylHR34ZnMhLP-RM4C94FnVDU4Gmne

On 22/09/2025 21:13, Bart Van Assche wrote:
> Commit 8ab30a331946 ("blk-mq: Drop busy_iter_fn blk_mq_hw_ctx argument")
> removed the hctx argument from the callback functions called by
> bt_for_each() and blk_mq_queue_tag_busy_iter(). Commit 2dd6532e9591
> ("blk-mq: Drop 'reserved' arg of busy_tag_iter_fn") removed the
> 'reserved' argument of the busy_tag_iter_fn function pointer type. Bring
> the documentation of the tag iteration functions in sync with these
> changes.
> 
> Cc: John Garry <john.g.garry@oracle.com>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
>   block/blk-mq-tag.c | 32 +++++++++++++++-----------------
>   1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index 0602ca7f1e37..271fa005c51e 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -297,15 +297,15 @@ static bool bt_iter(struct sbitmap *bitmap, unsigned int bitnr, void *data)
>   /**
>    * bt_for_each - iterate over the requests associated with a hardware queue
>    * @hctx:	Hardware queue to examine.
> - * @q:		Request queue to examine.
> + * @q:		Request queue @hctx is associated with (@hctx->queue).

eh, sometimes hctx is NULL, so it is odd to be saying that it is the q 
is associated with that (being NULL)


