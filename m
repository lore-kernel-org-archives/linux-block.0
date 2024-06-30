Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9425F39AF4
	for <linux-block@vger.kernel.org>; Sun, 30 Jun 2024 09:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719741350; cv=fail; b=pwvvqZTti0w0wBguJ878nLp3XAIwKJeU2B8nEW13Sye56KiVOXjR6KnPTSn96IBY8N1NAoGsgkuURBo38rWjLIOUaq/zzypM04iIpL15OOiqp75haUM6ZZGXYkJtUy4GooydhivWlG1QATkno/89M4ACf06jyBYJqCB3EW/D2D4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719741350; c=relaxed/simple;
	bh=ZgWmRQvNv7ywdodTtcMobDkI2pveJ6Wwb7AdBFTBB2s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VcEn4F8f3olCK34jLcuuTnLQIVJ35xPabDuKLw5utWMzq4X2YJ9IvJEk3JgVhb6yoC1Y8WSmueLGqAzIBdsOZPVAGJKzxdrszPLslHqBXbEj0EVpcUcp+ji9nrf/78MyohzBrbdDb/LkP/EvKhlrLcbpxhRn/6ueSvewV06NeaM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kxRW6I52; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=J26v2AH/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kxRW6I52";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="J26v2AH/"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45U72Xlq007537;
	Sun, 30 Jun 2024 09:55:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=EQvnehYu27+rDhBsqtFj2TDhEdD/BvBrxL8ExBuBfWs=; b=
	kxRW6I52rDlNvB5wDdkyce6a3nm1zIkqWv2zPYw2TDHrChPIN2jAosTaN9frMxQd
	QgviJ6FD9ap10evL8ReG69/+OpXpvNmAm9aWKEwNlIlRDAumlL5XTR+puWipxKiM
	JcqiATB/W/ZgzeQZ+RPLqErPhmmupSMxdAbHAyGahGery4ZvfCCjY08pXzGDaoCG
	QOynbrPl+QScd+mHnp309x7gcXIRMSA/LprWgW1Kb/D4f6NPVTdAtgVE+2ZGEXJE
	ez5B+ozoobM6wh44j4OUQbtv2CDQDfYSfAeKC88oOnw43yFihtLNI2I8xmVkfi4X
	zU72xGrkbs+1cZaZ3w6nwg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4028v0h6rd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Jun 2024 09:55:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45U6IB3p010555;
	Sun, 30 Jun 2024 09:55:21 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028q5hev7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Jun 2024 09:55:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKiRXUhWI+jIirvbvp0u245/b049oDQmY91LGDzM8XXLvAsgy84zI/RNeg5TlhLYhMWYokH8Nt/41S4UNpWXBJB6VHjolFq8cXSgJujgnXaMOdSA1Ec9EizwVa3SPJ9I53S1HQFLfgpIubaF36uqmijwRf6Fo5YFUtfo7RxQik01ptd90PySNPmhCPz0DQNih7bdFBidRTo5tD/CGzJHCJddwiwRRFXnUALB3rLTaBhmh1kINPWWGIDCzo1vxHmJuKscN0WbCtfZ9917u21xw4HGe+tpCnBXo98CqEdSO5wXX+gTOLGCHznTJl2yzXkrpTDftmWLuaiBK9kwFRzj9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQvnehYu27+rDhBsqtFj2TDhEdD/BvBrxL8ExBuBfWs=;
 b=f+h3xQA4Ch50i5SyDXskfshiQoEGS1MBN7GT7/LVTOTlkOSvKg65wIBN9oPdme66SkZzfVMrKXuKWIItEMK+TGv4WiKeFnQFQYbDt2wlEbtZT3X9SsQk8I7hQKCy9JBKAtsEorAQjRxSFSJ7QpPdR68+yN3cM9TrApayXkDZ0OveR0wfEj8NwTuv9hvk2+KqgBI7mortixhilZ4spB++NJ4+lyZ92hVgwx7f0euhTaOW+8AQL5QKL8X46ztC/Waqz4UQKQmj8qbts4wyA6/VKL5JLWQ74MME+CLCggPjcWH+nildXJ+3bw5bY8DUMhwUR9m7ADWnqxf+n1Ptlh/yzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQvnehYu27+rDhBsqtFj2TDhEdD/BvBrxL8ExBuBfWs=;
 b=J26v2AH/R3XRj0O1z+b5LVPSMcqF2/qPlzh7h5Rpl6otx998PSqsi8+rgrSc83fo0wvelUNCreTZhiRhxpxQOZ8ZRnFl4kqY6ef7xoy9sw8JXeWiPaRF3iH19HTakHvzBejTIvyruIB5WDtKNP4oN3uzmMP9AEUBl7pkq16RM/4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB5743.namprd10.prod.outlook.com (2603:10b6:a03:3ee::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Sun, 30 Jun
 2024 09:55:17 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7719.028; Sun, 30 Jun 2024
 09:55:17 +0000
Message-ID: <2455c846-e232-4e6e-8ba0-cd9de0cc7b03@oracle.com>
Date: Sun, 30 Jun 2024 10:55:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/15] virtio_blk: pass queue_limits to blk_mq_alloc_disk
To: Christoph Hellwig <hch@lst.de>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, virtualization@lists.linux.dev,
        Jens Axboe <axboe@kernel.dk>
References: <20240122173645.1686078-1-hch@lst.de>
 <20240122173645.1686078-13-hch@lst.de>
 <4f515e0f-f370-4096-85a8-907942bb41fe@oracle.com>
 <20240629051958.GA15371@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240629051958.GA15371@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM8P190CA0001.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::6) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB5743:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cad2883-45d9-44fa-381b-08dc98eabe8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bzV4NkJxb1JmY0lmVWprODlleE1VZVhVLzU2eGhraUZQbUkxeHNpWXJEVlBh?=
 =?utf-8?B?WVZtWkI4MFJIdDBWd1ZyNTQ2MnZqUGtnNlFNeXhUSkhWRzlOdlptYmtSK1NV?=
 =?utf-8?B?cllmalU3T2srZHJpN1RVaGhZL0FiZHpWdlF1VStTOUVJMW8rQit0WHFUM3Js?=
 =?utf-8?B?MHNRMWdsbWFabVo2Wi9tamRJQXRYTi9yNlZkejR4VTgxVlJ2cjB5WTk4dkho?=
 =?utf-8?B?OHBGNngrTnRRZy9qYitoUElmd2dlL0w4MlBuZ28zS01KU003cTNWRlJXRGFI?=
 =?utf-8?B?YVVqZjJzYTFJMWxodFhjOWJmNWJIajB0anRnRjczQk1nbGRwYnBaUko4cnhj?=
 =?utf-8?B?OVJNczFyZ2ZldDZjazZiZ3RoTTVyZjBlZ2EwcFI5RlViL0svVXlsZm1XRWs1?=
 =?utf-8?B?cU5iZXowRE5vVVBkMERRbFk3ZnRsajVoeG1VSXVUK3hWZnUralBOYlY0Z3Fs?=
 =?utf-8?B?RzJXanpXWHU4T2FTZWhyRjBjUmh1VXZ5cW5hMVBGdElLeE0xd1R5elhrazlG?=
 =?utf-8?B?OHlTVHlUeTU4VmN5NE10c2dWb3U5Wkdib29HMW1ERG94L0VneG9aZmw2cTcv?=
 =?utf-8?B?aUhjWk1FMnlUVzJ0OUl3UDlvZG4yaXVjZkdXZmduYUkyTUZZUXBQZmlVRXRF?=
 =?utf-8?B?Rkc5VVdHRzduOGZYT213QVEzb09raFFVSFF6eHJBR05DQVVsNDNwbjVJTkRL?=
 =?utf-8?B?Q0NtQVdOdEZBTXRUQmhQdnpURmxFdjJDYkZGUW5pcFBqQ2dQOTUxVmtjaFd5?=
 =?utf-8?B?cytFQlJ1RjdqRDBjVmgyU2ZTNGhzaWtCc3dQeUJjVnJ3YXZ0Z0NnWkhvWnMx?=
 =?utf-8?B?TXpSVHNPalhHSTFKUlVhSm81ZU5hK0JBOWF3S1hXY0R1L2huRGdGWHpwdDFa?=
 =?utf-8?B?UUtWckw0UGtuT3V0QlVUSExJRnNxNTZzOWY3aC9aRDVEOGVOY2FUS28rVnJU?=
 =?utf-8?B?TmtCRVo0aDA5alc4disrNUZrS3JUODJIYmw2MXhUQmtndlp1cncvbVAzNWF0?=
 =?utf-8?B?dkxuNFpCSVp2UHQ5TmxxamJYRkh1TzJjc1NEV3VMb2NEblh5VVM2NjBzUnJz?=
 =?utf-8?B?TWpjdWN2YkR4bW5CbC91WTRJZE5kUm1ZeEVEbSt0d3UrSEFwNXQ4eVhBQUhW?=
 =?utf-8?B?andqMU9VNldjVXhpZ3pIWm5UNmx5QTFzaWVTREh5bXlSSHJiUklmSFRGeE9F?=
 =?utf-8?B?OElWTENIaUtRd2pONXJqZTdlK1FwTXRwb3ZNYkxPNk5lelV6Si9mUzh3Zmw2?=
 =?utf-8?B?YWZuQzNqRTVSRUhQd0FrU1VXK2NVWE81T3ROR2U4MGdaaXpFUkdEaGNSSTZw?=
 =?utf-8?B?WHBYL2lDWW85NnJqWHpWZ3hVTGlnZTV3NnNLVzF2UmJObTFvTDBqU3VnZ3lh?=
 =?utf-8?B?MXZzelR5VE1rUG1tZE1LYjNuejZrUHUxU0FuYkgvL0prN2lXWXBxMll0K2pa?=
 =?utf-8?B?NWk4NlFuNm1ONFdNMCtza3dhWHdoWEwrRWovRFBVZitoMVp4TG9WbXVQUkRC?=
 =?utf-8?B?TWNqbUROUlRONFZyQ0pXV3p2Wmt0dlpvdVVpQ2tIbVB2YUtId1Boc1I5bTUy?=
 =?utf-8?B?UFoxNzh6RjhGM1BZcTR5dVZNZlpUa1V2empnM2ZZU3VtRWlxY0ExanhUMUh2?=
 =?utf-8?B?dTBYeVp3WTM1TGZKcmRUNU9wdjgzVXU3UlcweDZkWnlpcWlJbWU5aXpNMzdC?=
 =?utf-8?B?UlNhQllNcFV2cDRhYWloU2lvOEJ5c2JxRDAzRGVsSTEzMktpaGFCdS9LdGVK?=
 =?utf-8?B?L3p4bFZPaDNpTTl0Qy9xV05PRlpZZ1hEQTBudFhuQ3REWFprU1BCdCtMMVlC?=
 =?utf-8?B?azNHcVliMXQybkJ2UDJhdz09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?K0wwWnFDY0dsVlZySlduT21TZHpGNG4yNVZONGVGeXZJNldXNThPa0ZwaVdk?=
 =?utf-8?B?RzU3OGlLNjBIMFlTdmVISzZYUmx2eWttYmo4OFFxcTNrd0FkbkdGMG1iUXRk?=
 =?utf-8?B?N3FrRE5UQnZDdDVUSDYzUGJMbTlWQWF4WEU2MFJNaTBsTVAvK2RDcnpYcUI4?=
 =?utf-8?B?ODhhZnpib2t6MkprdjRWNzYyVHNubDRVQmp2Rlh6MWtyandQVmZBdjFjTnhZ?=
 =?utf-8?B?cEVsU25EaWlKcFZQUGFwQnpiZFFTSmpkNHNuenRnWjA3WU5GVExsQUV4U3M3?=
 =?utf-8?B?OXdpY0lWNnhNK0ZPdVNwVGNQVExvNmxiZmlnZkk5ZUZ1cjZCNVpOcG1ZaHZG?=
 =?utf-8?B?UUMySytyekFmRFl3V1ZFaFFzbzBnNVZJTmQyeGpOd3dRa25nbDJFc1JHZTZP?=
 =?utf-8?B?dVdRZ0FCYTBpTjl4blAwU00rN2dyeEZqUGVoVElwbjhPNVlGQUxiWkx0M3pk?=
 =?utf-8?B?dDN6MW56ZFlyVEdQcGJxaFJWd0o5a3RjMTNoK0VwRFp5bERNeldMTzhlWFFv?=
 =?utf-8?B?VjUybUwxT09uVWFjZXg5VFM2SzhzRVI0emM1QlhDY0NzcmExOU4wYXpWeGJV?=
 =?utf-8?B?RUpmTFFZWG1uMVREd2JKd2dLOGltYkcxM1JEcVo0akkzNjB2Y3FOUG1nWmZm?=
 =?utf-8?B?RmZRNFg1dC9XNC9HV1hkTWo4SXI4MUJmNU9wazVLNVU1Zjczd0tMSnFGNzN2?=
 =?utf-8?B?S1RUeE1aazdXV1dQVzNSeE5iaGV5K09jZ1I2M3BJa2ZiYUV1bDM0bGZzWWd5?=
 =?utf-8?B?VllxMjE5RFk1dHlDWTgyYVhuTm9meXZtZUJtbkVqNE9EQ1Q2dzVJWVl0MDA0?=
 =?utf-8?B?THpHdzVOTGl6L1Riei9GSHdxa0YvNTQ5K3UxOVBxSUFZWnpseWJ2UHpCdmFE?=
 =?utf-8?B?MmJwb1lUZTNrLzgrSGNaM1NRYjB3SDgvR2dGcXd2M09aNjZVVjVVdVk5aGxW?=
 =?utf-8?B?Tng5U1lOK09NRk5kMmdpWG8vV2NEcERVK2I1Y0tmVzMwcENjU2VXRGtLUlps?=
 =?utf-8?B?U05VcTlKLzFCSkZ3bGE3cmxLMTBOU1l1ZXpydEhWa3JlRjFHdlpjSURFK2tv?=
 =?utf-8?B?WmhEcE8rOENjd3ducXFoSWhXamM4Yk01WnM0VmFDSlB1NUx2NVRwQWZZaXo2?=
 =?utf-8?B?a1JaV0ZSVmRIZHhFdENHVkR2ZlhadXRLbWdFc1ZyUGVaYVJQbnIzdUJaanhu?=
 =?utf-8?B?RlN4OFhuMVlYbWRMMSttTWw5djd5bzJxNzYwbXUrZDNMSjArQTF0NXpFT1Vl?=
 =?utf-8?B?RXlUZkFwOHZ6YXR3Mm5uMWF4QXlOTEUrWjROM29ncmtlOXcrclFjMHp2RkpE?=
 =?utf-8?B?cm51MmJvTXlmcjQvOFVKRmF1aHBrN0R4MnRRWEYrOEVUam82MlNGbmNyUnlU?=
 =?utf-8?B?ak9SK1EzNXZ4eFRleWNycm95VDB5cWM5aE80c3IzWVZwOE9HZHpBMlFPMWIw?=
 =?utf-8?B?TUtFSllyNzFac2FFMy9WYXlxZlVYZXl6YlpzRkFDOEFQcnhYNS9FSnd3dGIz?=
 =?utf-8?B?dDVFOGxPRDRVdVJqVkU0a3dnV3RRNkYyeTR2aElSRzlvSUxyQ1BaVEhhZWxS?=
 =?utf-8?B?bFVoQUgxM3BaZjJTVktqN3ZFTURxYTlITUR2enQxRFVsRWlqTnFicjMzRHVH?=
 =?utf-8?B?bndVZEg0M1NES3RZMFozWHhyc2piK1ZDc3RKdG9PbmN3TVBpbGNnRG9teEIx?=
 =?utf-8?B?K21KVnNCMzExaDlzVE8zNVNyOEw0Mm8xNGgrY3hYRnZXSXI5L3Y2aFY2c1Fz?=
 =?utf-8?B?SERqSmhTTFFIdlhJL2dpWXIvSkFWbGJNcUo2cXQvKzN3WE5pdGNVem14WEQ0?=
 =?utf-8?B?RjJxVGhsZjQrMm8wUU1ETG9nRFlPVWlPK2MwUHNvT25OWVF5YVJERnRKWXF4?=
 =?utf-8?B?YmRUZE92VlpwQUxXdW43YWdsLzkvNEZXMzBsdkE0aGIxWWxxbHlMdWJYY2Vp?=
 =?utf-8?B?ZDRMcjhlbTVWejI2Yk9TZnBYa0lJT1RXK3EvdlFOYjNCRVRSemtSemRXeVY0?=
 =?utf-8?B?bVFnSjNybFNPVjN6WTFHOFNaMHVHUEdvekJxTW9sU0srbkhvK3YvcFZHK3px?=
 =?utf-8?B?elc1NkdRTndZS3REckVVS3dXOFVtd05tWmw5clhoNEVEREliQmZTZGR6WUo3?=
 =?utf-8?B?NkpvM2NndjI3TzY5ckM0d3k2eHY4bzlBVlM0eS9UTnBrbEF2MVdDZDc5anN2?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	GwFcVtEEffmVG6U/yh6maX1s9cH8f2bZ8WUp8yDZRsfvRBX6Bi58VX88NbJTkpLwFGB6E+JCa/Fe1UkiE23KR9pcpp3hzC8krXUOBRb98nC0e47ZssK9fYVNVX9Yc0q2XPkZ8pOFyqmjBO234HPcheG1a9A60WsTUuYtMVePUq1T+XSdA0ObuRdX700h8pGbvojOk+MtVvMjnLId85bop1qR6cUHU+jgkTqhnnRXvh0O9OUcdMJO9FASl4ARLdKK/0w0nYomE0jbYxROqaCLk8hVL4zr7o1GhcF38+JFBuXc/csG9pA1yH+S5VyA7pO40Eq8BYmKZbBsrT5oF1IwsL8rFGp/edYxweJkA94srBSu/gmBHh4ZUGEc92yBs762+4+qtq3kQztg77nAAiXLPPdQ8F8AWxxhu3OXkBwzBhkoxn0DweGRXY6jzxxQRUIvEPv0dFpfBF9WmJtre6+OfKbAf/NBHLEFAZZPzWTIha6zsvaf0Gzw98cYfAQ5GENec9nCPOBaH9v7of5XsYMA5bJgRfBe5lpZRwlDwFbfggw79lTa4l5LCnb91r879pAXYCIR07qP7F3xb9y0tD5Ta6j9rCY6H9Apu0rZyIwrsxc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cad2883-45d9-44fa-381b-08dc98eabe8f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 09:55:17.3079
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: damH5nOWNaoQXKYy3wmQjjA8xyr1dcOx9mZpu/eIs5iRD/rmu8OnQHWHn1yRMq/kI2/UZAiUqeemyy8tpEYjCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5743
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-30_08,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406300077
X-Proofpoint-ORIG-GUID: 2JkIONwFk94xSV_YtFs3ZH0TqxRA9qiZ
X-Proofpoint-GUID: 2JkIONwFk94xSV_YtFs3ZH0TqxRA9qiZ

On 29/06/2024 06:19, Christoph Hellwig wrote:
> On Fri, Jun 28, 2024 at 03:25:02PM +0100, John Garry wrote:
>> I think that we might need a change like the following change after this:
>>
>> ----8<----
>> [PATCH] virtio_blk: Fix default logical block size
>>
>> If we fail to read a logical block size in virtblk_read_limits() ->
>> virtio_cread_feature(), then we default to what is in
>> lim->logical_block_size, but that would be 0.
>>
>> We can deal with lim->logical_block_size = 0 later in the
>> blk_mq_alloc_disk(), but the subsequent code in virtblk_read_limits()
>> cannot, so give a default of SECTOR_SIZE.
> 
> I think the right fix would be to initialize it where the virtio code
> currently uses the uninitialized lim->logical_block_size.  That assumes
> that we really want to handle this case.  If reading the block size
> fails, can we really trust reading other less basic attributes?  Or
> should we just fail the probe?

According to the comment on virtio_cread_feature, it is conditional 
(which I read as optional) and that function can only fail with -ENOENT. 
So I don't think that the probe should fail. virtio people?

 From my qemu testing, it is always supplied (obvs).

> 
> diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
> index 6c64a67ab9c901..5bde41505818f9 100644
> --- a/drivers/block/virtio_blk.c
> +++ b/drivers/block/virtio_blk.c
> @@ -1303,7 +1303,7 @@ static int virtblk_read_limits(struct virtio_blk *vblk,
>   
>   		lim->logical_block_size = blk_size;
>   	} else
> -		blk_size = lim->logical_block_size;
> +		blk_size = SECTOR_SIZE;

I think that it would need to be:
		blk_size = lim->logical_block_size = SECTOR_SIZE;

Which is a big ugly, so maybe:

	if (err)
		blk_size = SECTOR_SIZE;
	lim->logical_block_size = SECTOR_SIZE;

or, alternatively, set bsize to SECTOR_SIZE when declared.

>   
>   	/* Use topology information if available */
>   	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,

