Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591DE255F39
	for <linux-block@vger.kernel.org>; Mon, 25 Aug 2025 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756149592; cv=fail; b=FOVwl+3ASI2EaGippy4g2wM/cBPoKx7CMdl8E2Z216ATjpn66rIHlLsVTJh6h6XA4X9cnUW9szUgxnMBtAN4x6zJf3Qauu/IsD/oaHIpm226Ph79B7saZdVyPMer+HC27VjlyA/gi3i6zbwfzGxc7wj418cJB+AbR3VEeR+slR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756149592; c=relaxed/simple;
	bh=a/O39najxvELW7xN2YOVcjwYLbE4qwA0cFjNTIUVS8w=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=Q3hMgW6Dy0r1I2FZS6Ai3/yO+t2rumuEkCFOEa6KyAncYK8etzKLSo/XrwFs/B08HmdkDiW3PrrmV7flOfrs2dfEIPPHKm5qXPxuZsFtK3I5R2FniSQB5ON8MUH+cHk0DJl3L05ByQ69uMdCNGuDiprOwchgWWvgURuAP+74MBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pwDxCmgL; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BNogteJK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pwDxCmgL";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BNogteJK"
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57PHuRZN012493;
	Mon, 25 Aug 2025 19:19:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=PIhwH1KGtKvsDNkGgY
	B1QvrHR518Yu+ooAxBpqBUMDw=; b=pwDxCmgLE7tt99Ggh2tHinxnVJxGc8825S
	SrwXshUs4gEKTRlLOpgrKuLne+uedLolxLhIvnfeZB4d/MgoRnkC2vUzhoHs9PJT
	yeNe7hVmiknBhSHRTT6K7QsNOWZxlStpTUvKViXk/oq2JVIdVLIndylcZaNyECo/
	gK5sT3UjusV+ZNg0LbdgzeWQ1z1z8zhB76CwE2uuABwcHKXs/hlAaylCy6QIVDqK
	bPnyTnBNLXF3j7YTRCfj5gEXYYJ12m46KpjKbXzz0KCnNASYI3XdUpCYA/DPY29W
	+vf6sGZYlV/XIJZplODAClmc+Qq4VlwUWpNxSq0EJTse31G5lGTQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q58s2yrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Aug 2025 19:19:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57PHmTVM005016;
	Mon, 25 Aug 2025 19:19:34 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48qj88v21p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 25 Aug 2025 19:19:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSchQ/juIf5OyPcF7rpc0Lr0JRP+H4RUBtnb5NIM7JpbmY1Z3gSGC+bSEtYkyjwPwVzc/mEBsvQ3OIqR92BGtoJUfV/2bW0h/UHymXHfXF8Ui0Fj54oz5I0AVPBwuBJGkKNYHOhV6bymAEFlUPH8hAAdGXRWPT6kRnWwKsDIXc921DWGlg/j6mSk4l6X3vVMDBd3eJbrifhgXLnaslnbb/ERBfNpbe1oXp1nk18EbhB5oxrMleDDiDcoCiC1ba/+mydUDwqLmZwY18oFBDewDoyK6zW+P4x/n2nIZSldHjInQyqrgW87PljewoOZlJbe3oz1uximUZ8S7gg0OefWQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PIhwH1KGtKvsDNkGgYB1QvrHR518Yu+ooAxBpqBUMDw=;
 b=yYDnJwDSJ996xCQQaMK6whe6Rz3BbnZVcEtma91MPr0zjBvnuWL2ZpSv7kcHA4XTcrglwysGpT7AXxbOCKeessPYYptd3pd7CO52V0ynxhFadWV+AU2phc+Vyj3gN6bYr8dAHX2ku5X1N6w0nOIEPvZbkRAWA1LFNPwlZpFbUNpecURBzHbrmzsQDUKD7RsVjWx3NEr1IHI+D7NtKxLXMUVrGswRaKB3Om/T9eMZKMLYsfUWo49ZrJwsa2zyjlS1Ng/GhAakCcUbp+644YCUw2Ox3KWEHywDQ7pC2gAnc89lMBioD19Dp2Ro4bO0L+hlb5oXQb8WOZBBqKkfrk/NUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PIhwH1KGtKvsDNkGgYB1QvrHR518Yu+ooAxBpqBUMDw=;
 b=BNogteJKg5VXiY45L+nO+Fp3sBucdeEmDrF9ssv/3jDMWGsgNP757Wba0pGmHOZ0MQF0VXk23Sw2ovFP3+PIO80CuhTAKz23fEik9bwyiFmqjecCxMnpZHAZOiAC3ulmAbPeqGJ2+EMqvNi+cYg+jik6T3lsOxHoWuFqPrbyBoc=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by CH4PR10MB8028.namprd10.prod.outlook.com (2603:10b6:610:23d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Mon, 25 Aug
 2025 19:19:31 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9031.014; Mon, 25 Aug 2025
 19:19:31 +0000
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph
 Hellwig <hch@lst.de>, Nilay Shroff <nilay@linux.ibm.com>
Subject: Re: [PATCH v2] block: Move a misplaced comment in queue_wb_lat_store()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250825151424.1653910-1-bvanassche@acm.org> (Bart Van Assche's
	message of "Mon, 25 Aug 2025 08:14:24 -0700")
Organization: Oracle Corporation
Message-ID: <yq1bjo3qkeg.fsf@ca-mkp.ca.oracle.com>
References: <20250825151424.1653910-1-bvanassche@acm.org>
Date: Mon, 25 Aug 2025 15:19:28 -0400
Content-Type: text/plain
X-ClientProxiedBy: BN0PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:408:e4::26) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|CH4PR10MB8028:EE_
X-MS-Office365-Filtering-Correlation-Id: bd134aff-89ef-45eb-7440-08dde40c5182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Dwjr7mrSUuCeZVSka40HxE5HL07nRZGngHeg4GY47pbmZUifvvLS8qHqHRdX?=
 =?us-ascii?Q?KJ9PjXn4zZZ5eRlo3SZfablB6yvw0bHEJXNez7QbD2nozF/V/4ciE+rdaACQ?=
 =?us-ascii?Q?xlISKZ7JrlCZUCs91ULkpvWeSNv1y1B0Ogm5T74g/80Q+jE+yO2cITUj9rTX?=
 =?us-ascii?Q?f4t8Hsl5EaiQZUVH6WiK6hVOwOLoRdrCeOVBGcAGlsyLenLUH20s3KOiN8Ll?=
 =?us-ascii?Q?wAYrlwgDI3gtmOY+Mqwt7SWWubYkRLwBh9DkaAB8vxYWQ+lX0QkHNbMBmBf+?=
 =?us-ascii?Q?UvOL1Q6CaGpCy3quFMfeSBNhh8O7tsIQXwf/oA2ArnHsK/79P/vC7faq1kD6?=
 =?us-ascii?Q?8GS3y9+BjblMS651yOLSAMWP+bMGsGozQsqafmiCL2HVrUmHOHj0NUM+v5HW?=
 =?us-ascii?Q?uMYNwERNfhPJOnlsaLz0VdL996nakt5f8dsgrPn99VErv5xWFaaF7Ybuw5uK?=
 =?us-ascii?Q?SEOVfMzoH/UbJ4uiNe8y7jAX2O1Sp4/Ohu18NE3UmHOfHGvv7okoA9ygXaZd?=
 =?us-ascii?Q?BCsSWWcdoVlVuHdri9NEwRKapwqPNM1wBgYJvqP04jA5mrL9K8oX+/uafRq1?=
 =?us-ascii?Q?ZaWtz2wKdpSGHVCW/wfFjTcl4SNKuf5tHGF7fgEob8uCE8x39O76J1vSxdIc?=
 =?us-ascii?Q?9Vt8CaZL1UqDfi3HjHVTXJ9cI7OvAyB5M/JqYtLNVZvNm4zQsnfSHJwnXLfp?=
 =?us-ascii?Q?A6LW5BMQNH4mIh6hUwskOnXq2r2jBApQ6af7yduWE7rInjJcekhzUHbUb+E0?=
 =?us-ascii?Q?nBPtT7GtT9pcqAznc3iWrzQKHYKSFVzd0I0z2PdFz9xu59IAQeMNOHE3Q6NG?=
 =?us-ascii?Q?iYN2dxm46sIiCE5Gc/7jcyNM/fhfszgkmwfthfCStv8ngn4RcEimGdwA74Lf?=
 =?us-ascii?Q?XSEh6sXkyvk1TjRULoKCTkSXxHksjRxxJAjAQvvudY5AlHKuDNEZf+Xe0+w9?=
 =?us-ascii?Q?/obYvnWUIL93udsGubwqhX7PWpqI+QeDTVILoaNQn25r5W+dNyzjvH9N7PM8?=
 =?us-ascii?Q?ho9YcviEeOsHd5a8wmHqjs52A7KvJ0PpsdyglA/MdGLeuaTHTSSHHVPMphvu?=
 =?us-ascii?Q?/qZjTgHGoZunq09WrEd6m5YSybbAjHS+DkwJ7saci1DKVvYm2W/jE/TyJcn5?=
 =?us-ascii?Q?QAhZJCf/DrF4PlVuoZIMdaCnyI+rxvnUF5124S25LdF0zKWUPBx7pgaSKEgp?=
 =?us-ascii?Q?QNeB4rGst2LB6DyzMqj2ITkrJwEmwat4s+DwXKnYmFQJBkEkuYiZbIGmnaxR?=
 =?us-ascii?Q?ItePcNMioU/1T3icJDSAqyiUYWF1KRMFhWWF1MIdt5HUBFQrtFBen8aXyiyM?=
 =?us-ascii?Q?OSutb+jVvG6C7qzByF+7obO4q/ij8oxILQaZcPth1KuNYLk16nj819B9IfbM?=
 =?us-ascii?Q?VaPn+Ia+WpaliCd/jMSLqfwySgo0vQzhBxD0PazQyGMUBiVC92vKQjSyafqi?=
 =?us-ascii?Q?weSCP/+3ztA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aRW4/hBdgwsahPuLJUqiPqGgRH3KcDW6O6FaPExlq5AEQ6vQoRYDeGreJ3ow?=
 =?us-ascii?Q?dlIs5Hw+SLql3BM8NkWA1YolV79srhHAkijJzs3IL3VSLkfTJIOawSgpqRnd?=
 =?us-ascii?Q?U0sJ5OMFS6erOvgGYeMygMN6/pUnwFu3brmZqjJl1+Ti/cRRCgYLqyfUy52F?=
 =?us-ascii?Q?ctNK6KnIYeL32+MxROq2HAmhemZDb9IZGs1QbbDyluy7j7FC3JvaGujtHld6?=
 =?us-ascii?Q?lZgXoerjtuc4Zy2CPSv1FQR1hWMwEH19W0wwuGE8Fv2x30GonuhkPuHPw4Mv?=
 =?us-ascii?Q?N/K0dJCUo8RpdkMl4j/pBUPRYAPKx0TB5QSznWQkj1CzCk6STLB/DLLQFEai?=
 =?us-ascii?Q?RAHud/PX3IM07YSEIBG/irr5ttzWcdwh50ZsS9sQgv7gJCYxFbXpKetIHs2+?=
 =?us-ascii?Q?D3X6Bj4kdRkPmUjlW+bBgLx7w4i4tA/1W7T5TNmtLasZimKOcEFWSDwpAGw/?=
 =?us-ascii?Q?p/+M1bTpb+yV/LqSy+kgKI98RlMmJVwEGKRNlkil//S7OsSQuK9Y+zX47rO8?=
 =?us-ascii?Q?PYHhPzKBE7X/41algEojMeZZldSZlVPlAgWxUbwTQXeMy48oFjQWe/Lo4gt5?=
 =?us-ascii?Q?MWUJuwv0JGpxggzdFcxbdRqZ21oTuBVJ7kOC2uTHm+f/WjHdW6XYgmi2QXmZ?=
 =?us-ascii?Q?6x/bwDPoGKENpmb6Z0bqVQTd7O3PKUXrheORGS1YWmLoDk+F7uiP+5ukEX+2?=
 =?us-ascii?Q?6TnnJKskPyaJhU3KeIO94immMM1bRzb8UIJFGAH9BYdOi6bQzbxCZ7B9IGt7?=
 =?us-ascii?Q?9+Wi/Njznjjj9glhm4Ij2FUQwL5RpwK2dtiDaImXOnSntT0C+p8Wm6Jp6CZq?=
 =?us-ascii?Q?zdp40qHQpv1X5qhqPFaWoCTHBR2Nvv/2phBejN2WtRgpTe60uh3RaucDzd4i?=
 =?us-ascii?Q?r9aj2F1GZ7Pz+1BuLSaOkYwXvSbgDTrOEURTWAmgFgxhmAbqA4dwVS4fjWzq?=
 =?us-ascii?Q?TPtR9zuEgxw8rUfagIfhXAB+3+jz4rKdE3pg3lTvzdx3OlrDH5qUGfajUEVx?=
 =?us-ascii?Q?6gXA3oAnW3sLLxql8qG2Iov2gl2MG/NPBEmKUkjOg7cCn+z8Q8Nh/jETVklg?=
 =?us-ascii?Q?1rkQuXkr3zMb2pI789JGVQOYH6IWbUyGlPU0VRXEuy6yhy8rMqHNfN5e2C4i?=
 =?us-ascii?Q?Bl53MuhZjJaZa4tnKmrD8Wgvcto4UMgudYPdb23ew5ID/2sQWPcC1eAZbLsG?=
 =?us-ascii?Q?RcA9Ja4qbrWexJD7diAaD8eZXS+CvHZGEcaEb19VACKgUtRw3PwUvc+PU1On?=
 =?us-ascii?Q?tlmuOpSwBOLwi8Z02GYg95QZ93BoJbI9QoeLX+ZmpBkQZRbBKSfb/sYOONzL?=
 =?us-ascii?Q?3pF5Fmqz8nSeR4e7WB1ws1qtqLFO23mQoAH91PAEkaYUSbffxsnP1/tPRmZ3?=
 =?us-ascii?Q?hdXZCKmNve8UlNj+u0YbUCDj9LyGED+ggcPjGgxrQHn3P4p3MV/YtSLDAvAs?=
 =?us-ascii?Q?OnjDhdG9ijLf1QIeMY9JAV91ovjKbkbXRKsgMHDBr6njWjH0q4rLV6lTkf6k?=
 =?us-ascii?Q?W20KtOV+uTItoUjeraI5N2w4Rm/Y/v9S5DlKCEW6KAzFFbstHA8N/lDIYqSa?=
 =?us-ascii?Q?67pwZCECZgYrwOppO2uyPrvc8sCxGExaXlEyRnP3ORdk+Tzu5VV6YddSbuVT?=
 =?us-ascii?Q?iA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QQ5DPrjHrzYM6gYpcQv4R22OAovxc/a0r39wa9z9AqIPwJoO+b0w//VL5Yt0Kq4Hl9gfYOjkohjtgtlzAA+rgIq3vRCjCKA9oap5JMsHMSXiwotLIP6iQlAS9xKey/ypQPEffMmQAVecaLeCFrcl5Ob5IYM13jFS5uz0W/8iC1vCV1BB38Cogc4LiAtNCkI83qqdMYHoM0oAbiwT4INMS2yUC3FD83c8IO0yv8lmqyDV0OJ7LimSjtrLFN129O66e4kPn3Vs3zrWhWXfXrhY4Pq51xYVY8ptMJTYfoh+uI4YQAl11JVU6sDtm3AF83rHv4Qy6acGuDgdOhxEqEWKRHrlY99GcKGI8qehrUaw6rhSmF8R8Vwoqu8k63iIO8w9zuwN3kFUEER0qI5FHRAp97dHlmTQ7lsv6oxP5At5WHB54iz4jrBm8p6+y+ItA4T7oZtCQ/qMpROSMrqBExoiPcJPJpCqyYgEReJAlIBY5Vzxk8lrpZ1xdP+kbWstVASV3ZTXZpYDmnspAVqkd/qXCPkG4Zty2izkAbpBREusTWNZcN6ABYli1L8p11xsejan1IL3mvu+bCZwknP6CCjYdz2xr/MOg0wjB2T1y50oPDE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd134aff-89ef-45eb-7440-08dde40c5182
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 19:19:31.6134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m9QhLDUyB6257MH68+UZKM0YOEoVRU0/YIw9VMPJMgY0SalQB6GeMsM8S2aMvRKwgt4c7BDftJ2SAdJwsTq6q6JxYtBUIrJX1yoVu4gkMlA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8028
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-25_09,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508250174
X-Authority-Analysis: v=2.4 cv=J6mq7BnS c=1 sm=1 tr=0 ts=68acb747 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=jqGgoK1tQoaFpatg7mwA:9 cc=ntf
 awl=host:12069
X-Proofpoint-GUID: PSc48ggg9pFZhH3FjY26Ewc7ZbwmJe7M
X-Proofpoint-ORIG-GUID: PSc48ggg9pFZhH3FjY26Ewc7ZbwmJe7M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyNyBTYWx0ZWRfX9OVvUzeKkUHb
 gQtR6h0snrNEcDjiCh9x/THrTcnnGEa6WIdS0+0p/ZScO6nr5PFJSiO9vGmJ8k33ulsG7cpQE/s
 2KQ6TlnIsZUqjTUSVqH3SE4+9DC6MYNAIpHRBA6Ym5jsW/Sk+YNDdYgC9yG9I9zgfDCP3RmtzVk
 8bar7kjW2or8Omwnie1JMLEbSfdHRlMUQAMEylb3fLk8ifFdxLBxB8ahcvnLY6Gv1K5crdSW76m
 /kbYO858bKWh59Cu/V6DKp4IrbsCsgKIP5GMsIeg4JkP2xvToQKLZqUCQY4QQuKrMkdYNvyKSmL
 E+auBbQFynrIR0l2Hvdy/7vQGHyZAeAkYa2HWxobtnV7NOGrARs870p2ZticWa9t+lCXm3rVmX3
 COirl045FzJIvUVUh4IwXQ51TTBe2g==


Bart,

> blk_mq_quiesce_queue() does not wait for pending I/O to finish. Freezing
> a queue waits for pending I/O to finish. Hence move the comment that
> refers to waiting for pending I/O above the call that freezes the
> request queue. This patch moves this comment back to the position where
> it was when this comment was introduced. See also commit c125311d96b1
> ("blk-wbt: don't maintain inflight counts if disabled").

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
