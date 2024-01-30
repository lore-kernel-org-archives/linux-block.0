Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7D36A006
	for <linux-block@vger.kernel.org>; Tue, 30 Jan 2024 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618377; cv=fail; b=X5+daf8kQfco9aXf/nfEzvu8r0DwQvGfSVvgEw6a23OcEi76BdL3PMROqIEhHAmF++EqT9NYDdN6sE1uSd3DcORQUnK8BVw+LC1rgD79SuhxZ6Jlx7quTDImlCgt4a+ud2sEiBmUNZMakSEbN+QZ0bmUHd8+lTZWeUKS1/CDBQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618377; c=relaxed/simple;
	bh=C+w08wxzPFABNMbbHjGJ9PJRWbEOZEAg+1jwOQYSHGg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=guiJ6+HsZd+wLKb2zUaqHTI508CPoz4M3cnTrbmEJGRJQhI1VtoUV1bZYgZy9yKqOhe6q3JOnGZhILndvuQpcgdUMMnRNTaCpduDAdScluFJ+x5uR5k1nHzQ8wm6HOOvutvtvuvvMnX/Ikg8CyEtYv5zo2Q00QQlPV7jkcqjeiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jfeenGNv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZartAj95; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jfeenGNv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZartAj95"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40UCA8lw020821;
	Tue, 30 Jan 2024 12:39:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=maBu4CsRUZkC0tUeWY0Dd8a32z3lMYxQVj9fPdn9mnI=;
 b=jfeenGNvlyfrCKcn24o5m6i6j1RaIJZ3cCqVly8xdybvIsU7p4C47VoHPFWstApLaJQo
 atTkyYZyZtqswMAQCR0kgko+pIqRC2ND+cQ/3hVF6iZj56VIgSwyPXUP5ZnZvVTNb4rf
 hJc94WDNF36WXkru1yWxLeneQI6EoVjoeE/JhdiWRFYf8f6mhiCZLwi6pUCHhi0Span6
 mJbHgdzlcP6trC7KVYb5SDL0IgXKo8GhnEmKjJAGm3Ad3JSAK6pq3i5Qnuu9Tap6RXky
 AF95E7mqRBUjW6cY+FbVk5DTNYggfeMIdMSNZMc2H5KXWkJtkwTSpRx3RrsXOMKu4NHF Dw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vvtcuxkn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 12:39:01 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40UBxPU4014722;
	Tue, 30 Jan 2024 12:39:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vvr9db7yw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jan 2024 12:39:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLo3KjmXC0RV7nOvCnw/1cxolOnrXmZDvxI/OLrRp2+cCCttXP48BbrTRwrDhlPN2e/NfA3PxHnmRgCBfTBejYh/+Sa7ycakwV2CI0Fmv5CoTFxscyV2wacWxg/zX9HY05ODuQbkzGpPM22XAI1FeuVXB2sIZsncRvV4w+dNCpwMMKqg5nORicYb5/WE7U6Rh+SSp1uNoLfJ9r38bDjdIIOzRZHUjIOREZNbaOjY4Gz7AHe3k2IZQcJmBsd5EZwkVtFb3w1iCjDuV5CjN7wHBd/XSI5foQdl5IKlkYwXpmsfe8cbACIbls61qyp1cmPPpR01lSaEDy/4A0vB9yEcMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=maBu4CsRUZkC0tUeWY0Dd8a32z3lMYxQVj9fPdn9mnI=;
 b=QXg7Pg+L2CwIM+eysiG+E47qJAv0aFIi9qDB5MhJ9HQVVQOMDlzieSTnuGHnUFLTPHBqjpkOTgQda2wr35UXT11FoCx9FMBHYKBDrc/kmKNiVI9BrkH1kMFzj6Fqj/37qaPC2WGSCI/wJBpYeWfjkSSxbyfOuIksKVuH8aErblq9zzIYsqIrSbhv3cqRels0gNAZVbv/0empoKKwUHdxU0he79Qea4njXkW/wNZOquueHfH78rscRmXngZFEStymA2/FZ6GtXSHWSuWVryZhjeTTY87Djg7gs3u7P7SrZTP7TbQ5XWxGSUctDQMzUEWCwHrHH/vJp7OWLgeQbcePIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=maBu4CsRUZkC0tUeWY0Dd8a32z3lMYxQVj9fPdn9mnI=;
 b=ZartAj95P2Gn3Tmyldf94ICCmxcNov18DRnCrMbzvkUtxSPb03toJbjCc/4pWYg0/QC1L4rLUMVi1+Y/QHVH0VFilre2t9aoYsdh9sjH31Y1t1w63YEli9iDPNJpel+uQNIF/UZ4hCRnb/1GoweT/KCSKwLXhA71XNEP6/bD55Y=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7138.namprd10.prod.outlook.com (2603:10b6:610:122::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Tue, 30 Jan
 2024 12:38:58 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::f11:7303:66e7:286c%5]) with mapi id 15.20.7228.029; Tue, 30 Jan 2024
 12:38:58 +0000
Message-ID: <1fffd3c2-a76d-462f-993c-4ec37b222e97@oracle.com>
Date: Tue, 30 Jan 2024 12:38:53 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] block: pass a queue_limits argument to
 blk_mq_init_queue
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, virtualization@lists.linux.dev,
        Hannes Reinecke <hare@suse.de>
References: <20240128165813.3213508-1-hch@lst.de>
 <20240128165813.3213508-9-hch@lst.de>
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240128165813.3213508-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0316.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7138:EE_
X-MS-Office365-Filtering-Correlation-Id: 846e87b6-350e-4ae0-3bdb-08dc21906da8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	fL7o0nmMCMqtlX1+RKT3w2clzLWXlC0OdyrbVS+NYWlx+lMslMWzJIhoBbJ9LdwZWDPLaD38oT2P+w/ZvavtB8DUT9k6NlTVQFOmE3ZzwxqAv4qYSb8DHa/GIs39OEZsu/gwc1tb8VchCe951e6urkR7qgUehql6oZw9HYtO9tKJWcOwM4Ec3+YNqB6DyfEUoaLFX5EpM//cpgnphtXpHbfPGNJynZ5aXsu8MTrUfrPYSHxHByZMQ1FsOf/KbZ4AGT2HeuYR/0bM5AU9uCs53M9/0vB/f1zmfZxYcczPmw5WMN5CA2q91KoVVowFmemyl990bntsLX0jMZOYjk+DadMHiPBTRdmkg5qTlHXB0xGmgPTZTBsvJ1BNvtVguUzCltzgcRToeQB64hfl/5KUlff3zFSCN/ykLwl+qinnGmhZxMYZJfNrXe6csJRUgZrT0shvi4GL6GbAvH5++twuhfq/qzV7VFM30UqQVxQq0Ihu9zMSYz6HxKDwdg6pxhK3hiyQezqZPfA2hoBClnHZK2MPSCQXqLR+x+uzydrnAEF2lKrZQOEOxU1pzUwC4RPqNmn5Ene2uv+IALzK4WV1117U4C+K/C9Y5ao12ST9JViJzZP/bl/i3rLbubwkXjfVt1orRXMy5XUaSwtxu7NZdA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(396003)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(2616005)(6512007)(36916002)(6506007)(6666004)(53546011)(83380400001)(7416002)(5660300002)(6486002)(2906002)(478600001)(4326008)(316002)(54906003)(66556008)(66476007)(8676002)(8936002)(41300700001)(66946007)(110136005)(38100700002)(86362001)(31696002)(36756003)(4744005)(26005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?WVVtTDliMGtNbWJGem9oVUhJaXUxTHVWTkorWmRoaWM2UDB6cHlCZG9QVTVa?=
 =?utf-8?B?UWVpM0pySjFQWXgrS25ZRU1NRGpMVW9QNW5pTERJNklWbENNTG5hclIxWSt3?=
 =?utf-8?B?ZlhSL083SnY2TUNUUTRTeEZjWm5LaDJ0U3hSNUZEL1RKWVBKYjBsdTVQeXJN?=
 =?utf-8?B?THBTU1dVOXdSV3Y0MVVqS25rcjQ5V2tyVWttbnVkNUd3UDlUM2VDVThYcTMy?=
 =?utf-8?B?eXdWU3k4SXFEanVlUk95aU9HcjkyNjB4UUhTMVI1RmI1NkMveHQvUktzRFc0?=
 =?utf-8?B?SGdFWnFUV1dHYjZDYjZYWmNOckpIY2M4akFhTXh5RTZXd2VXeEpGVVJWNkpt?=
 =?utf-8?B?S1FTeXFCT21sS095K0VhYlJKc2RKblNNbXFJVmVraGJIYzIrNnRYL3lzcXk4?=
 =?utf-8?B?OFJhMU1kYXhldXVCQW9KTFlWMU9lQit3dUFFQU85MnBBT090Nm5TbGtESHhQ?=
 =?utf-8?B?VGdpVEIxNXlBS0dTQ1BjdmpxZjNxMTluS2N5MEtyUkZwdUxxMXZTNVE5ZlZH?=
 =?utf-8?B?eDVVYnppRGdRVENRTXpSYXNaSUNXK0dWdE1JQW4rS29WaldvSUo3Umc3elNu?=
 =?utf-8?B?T0ZlcmN1Q3dndFJMY3JERE1pYldPaE5NaEtBQnpnVjFxVnVqT0tYNHdhUEpK?=
 =?utf-8?B?QVZzM3ZSd2UraktVWW03YnpHZ2pZRGlUSFJTQkZRbUJNUW1ZYmhaR29KVy9U?=
 =?utf-8?B?MGxKTVArbzM2TXB0WWVUdkNKV25WZjhFV1JFSVFhRTYvK21YcU56TzBxUmVC?=
 =?utf-8?B?bVlzN3MrSjhwM2oyZjc5WmF3MENnZFJuOVdmYnQ2QmIwTkpVNHk4d0xDUlV2?=
 =?utf-8?B?a3NESnFnZjVIcGo1TzhwenBFcHArRHl6L2N3dllqdEdCNU1laE9LQmcreGlo?=
 =?utf-8?B?ME9USUIzU2RTcHNadTdtTnNVYWZodVN3eWx0N0FERFBGZ3lJTUVibHZ4V2Nr?=
 =?utf-8?B?TDl2WGpRRThmQ29wdnNvT1pBZU5IbnEzQ2JOSk9xd0pmK0FhVnhNRzRkbHdE?=
 =?utf-8?B?ek9qVCtNL0xZLzNHdDZaZ2c2bHVGQ1RsMzlCdjgzMW1TcVJRVnlpSXRRZG1h?=
 =?utf-8?B?VGRhb2xidEhwclJEQmZhSnN4VWdmdHJPdkxBOWhUdlcvdEV0b3NZTWY3ZzFP?=
 =?utf-8?B?MDZYM292bVNheC9PcnVUUnZGMWNWRTBsOXF6cFA2cXNrMTJTVStzU3pEdUdl?=
 =?utf-8?B?bnhsQVZZOFplK3RiTXdmTkNrNHgxeitTVDBTd1l3OS9XTVRURXFXL2FjWVVz?=
 =?utf-8?B?QUxCNVlOSUxoYXBsTy92dVl2U2hveExOTmkzWnRuamJ4UHRYcVpFRkVYUCsy?=
 =?utf-8?B?YmdPU1pRczkzTXpKREw3ZUFCY1hCcklEVWpaQktFdDdWYUF5ckN4MHhSTDQ0?=
 =?utf-8?B?U3JXalA0MW0xSnAzbzhsK200WENqeCthMU5haW9BOC9IcVBQVGNCWDNMMDRS?=
 =?utf-8?B?R2syekhBekI2ZzFqdWJscHZES2V6Q0VFUW9UdDRMQzlHZFc5c2FBajh2Z1lv?=
 =?utf-8?B?UmxETkxKaXc5dnoyOWpvR2RTdmxMYXZzL2ljeEE4M2F3eEJaWThoUnJRUXNH?=
 =?utf-8?B?OGhPV1JIQk53Z2s0M25HSEs3VHh1WjU3djRTeENKVW1uUTdxZSsrSnlOQmxi?=
 =?utf-8?B?TDE5S0Z0YnE0cDlFS1NFRm9aZi80aWoxSHNSZURoa1JwVG9teEp2VTY2Zk5y?=
 =?utf-8?B?cyt0VURvdFVEUElpRC9OVjVEUUlLSUFhdVNYSTBtWUxoRkZHblZlWFRENG1v?=
 =?utf-8?B?cXNXSFc3Qk1Vcys0NENjYnJkVmM5Nnp3ZXkzM0JvS0NudVA3WWd2cWgzWGpi?=
 =?utf-8?B?ZUlsSWwzM2hQdXZjY2tmZmlNekFFZHF5MDY4dGdDeWw1NGNwaDlYSHNFTG9Y?=
 =?utf-8?B?V0l3TDh2OStGc1NpZVhVRkVudnFXMWI1ZTFIa2hTSDg1czFxZEw0NzZad2p4?=
 =?utf-8?B?MFFVV1JYdkFSNVMxVVdzb29kTVEzRWU2S0YwWDhNODFJVDc4MkZLOWlydTB5?=
 =?utf-8?B?cnBVS1cvK3hDcGJKWitMaDA2S2U2NDdaWnlnSUx1NGd3TGh5cjJJZHNISTJu?=
 =?utf-8?B?eFpsSlRsVGtHYkZPOXM1aE5rTVlaN211cmdpY1NqRzBiY0ZvS1BMVTNsQXY1?=
 =?utf-8?Q?Kyn2fugAgUPNlt/MCovfoP2jL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jwn4qsjGdOSjE9+6RQx0C7LNS5YSwjIanS8NGCxasWoVpWjeibrrQBX/Zy+QQ3VxlObbeiRV8rFXWt49OlXV/s5QTkWD67wLATlIHClM6Jm26wqxUfyDFQ66KLVmOHG7ZCvQStf7Ne38nwnBRaQNsOhyXKNT1FMtmJNuhwT/BDJTDZRGAG8D7nI390CGcZQRQVJzQIXtvtA1j3aAhqcayxv04z+UwmSbk++4bcghmDAf+2zDw41YzKQw0SJ2uHE9PBf7FmDzV6nZNrcsBkUecnjVJ8mcT+oTknCegLjHYE7fyjum3yOrINzVGHEMjS5Ry4eQXyXBcg01ZfNC+KPM6Ft5+7s50ThAKqXoSmC/Z6/oA4Ppe5m0s7orvLAy08tAsCcfJc8YMoFFL1Py22kOGdQe4rKppecrsd8d4xVjAmH1XnPpP1TJ0xXI7w7Hn6i9lZTOU786Kw5I5LnAEyzt1oKKx4Dy7bzAoVp3uT47gn6SeUZ07RAZGiYGMfuLTlpU/21PItTXZ+poC9SXEZjURZ3Bg8NZnkMzBRR2BKhxIFmn/JB1oWwOeFauUBe0ZgUQNMXjt2N3FdZgA1Mek2cGETnTvo31F7zD+PPrMLjBU9E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 846e87b6-350e-4ae0-3bdb-08dc21906da8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2024 12:38:58.1065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lMQ5s+Qm4Lg0OR8tI0JL1G/yijEW85uNEy84Vvdp5fZ74cUruZEe90mbAn9iVRM8VtmGcIZ0odFA9kavpahq+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7138
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-30_05,2024-01-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401300093
X-Proofpoint-ORIG-GUID: 7Bs5WlTSeifP-0YSmwWkccdmdiilsQXj
X-Proofpoint-GUID: 7Bs5WlTSeifP-0YSmwWkccdmdiilsQXj

On 28/01/2024 16:58, Christoph Hellwig wrote:
> Pass a queue_limits to blk_mq_init_queue and apply it if non-NULL.  This
> will allow allocating queues with valid queue limits instead of setting
> the values one at a time later.
> 
> Also rename the function to blk_mq_alloc_queue as that is a much better
> name for a function that allocates a queue and always pass the queuedata
> argument instead of having a separate version for the extra argument.
> 
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: Damien Le Moal<dlemoal@kernel.org>
> Reviewed-by: Hannes Reinecke<hare@suse.de>

FWIW,

Reviewed-by: John Garry <john.g.garry@oracle.com>
