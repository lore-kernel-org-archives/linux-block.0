Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187471BDCA
	for <linux-block@vger.kernel.org>; Thu, 25 Jan 2024 09:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175959; cv=fail; b=XgEDE+4h1l+1XcrYKRAi2rqXyCQ2+kso9EBEmZn9ERiiQb2oZ8C5L7Lxi1WP0CTlGnGDe1tldfC/CRFPeD3WTbFBbfJ/GzWUE2qVnWO9aAw5rI32HfQGSQJsxXapb0eE7bg4psR9Sfz3ZRANTeI9hZmu5qGX7mhy95xTXf+mZq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175959; c=relaxed/simple;
	bh=A84NDK27lbzc9BCgQ+2M8Gqi0FsNApIHbrC3vja0Xsc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aBS60idbo0laaJhdFX9H/q1ombO5wcZtXLiqrjPkrNHz5TGd2ea8YtztX7lRuV5VSVyPuLNk77ZX/IQrbzss01+1lq2GoT575zSh96tJvli0qm5FtluTdlDHp38ZpulPUnOOqVoSH/brM9+gb9iuZxThaofgrro6VEHatoHy/lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=InjySGRI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YO0yxE/r; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="InjySGRI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YO0yxE/r"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 40P64Wca024157;
	Thu, 25 Jan 2024 09:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=ehxQd4sbZEsRt0R/XcVgHLGaR9JvlKaaWTbmNOgN3yA=;
 b=InjySGRIoqai3JBDywMhFspofV1TNnKhkyhWaUqSMfC/NW/7/sMkCP5DGa8XOLZ5cWFj
 ekUq6fkoVK9CCwSh34phg/POor/RcxXpkMlGnVOsjFWwFBZCitQGGP+8lgLJk0ZpIhXq
 HFVvIgqeqw0PbFUecWDE3nO0peiHfswHOMuDJn60gza5J3FnUY3VDXeVhsls55EISTo/
 lxbtUR5JQOn/+Oge3pufTGxEzZGanuPkU1CO+cFlV/ZHPcAz6F0RJSTtbUgynSEP++An
 dMyURNvIrimuIakze8jaYAoOFT1lojvMHVFckewDnsKdlVgQMo1XwbbyCSi9gm3TkvSv OQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vr7cuxnre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 09:45:27 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 40P9Ugwd004188;
	Thu, 25 Jan 2024 09:45:26 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vs32u4uc4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 25 Jan 2024 09:45:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLszvRdw0Tv5rW+cjQ+8fjeWdTK1/4LKeAED7ev2GehDQZ3HhCOv8uvAcCtRbEQKtEIHVTEcJRANWNaxteLjNUysf/KxaXElqeVSAVkesijrmiR2teTpPntBglz1TsTgUT1PhcdUujIY1e1PAVv6j83vcS/4iS1tAMbuAMVEv15E/atMwFeBb4p5XcWDLW33npqnVg8TafG2M1WeoFp0f+Lya1kJsj9t7hVxKPYEQFE0PMkok/S1PcGffCnGoqm5+YrxTrJ0JqE8i7MPBXVDAzqI1JFiCiCm1l05wE8agd8jFNBRU8DgoYVS8/7IRzQ6EzPEj8aQFwSgo1WHC1yTFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehxQd4sbZEsRt0R/XcVgHLGaR9JvlKaaWTbmNOgN3yA=;
 b=II9jnPqw4y9V7s++pMN9R3GPTk7VQRebm62XIxCRs2Xty3jK5OoJ4Adv3Bfm1SPdZ3ceuOYzEuaynmoz7XMHs+/Po4jT2oLyHpgL2/vvQkBmCiChdtgEhj52TdMITLadn/1Taa00LLwdZCAlcOOctiUEPNfJ5SfCeJdIF10MrGo7+8W1tR1tPHXZ4MlYKakHqqGRNdiQWCQDefBRG6qJxiy6yaHMgI9dImrBqx1e3xwrtSShF/GX1o74DAUn8noc4P7ILZuuvhHJWU+r5Fs8r/xpaN/aQ6II+2i+46rQRUrfEUkBArTFfLAm71NRzBTs/G3udqR+udyvuGSb2/COiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehxQd4sbZEsRt0R/XcVgHLGaR9JvlKaaWTbmNOgN3yA=;
 b=YO0yxE/r9dBlduvg5xTpOqlHgxUngFleqhjxJpKqzpDHfWzkuEUMA4eWdv35/zABebL9ExwCZkGKbFt+nwyie4vqyy9XAeLslkTrXuN39I6/e/uKVN3MO0lRRQDauW2kNMXRS78G4k8Mx0rhminAk2MzjBNPMXRNy4VD4BnSCZk=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by MW5PR10MB5737.namprd10.prod.outlook.com (2603:10b6:303:190::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 09:45:23 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::c29d:4ecf:e593:8f43]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::c29d:4ecf:e593:8f43%7]) with mapi id 15.20.7228.026; Thu, 25 Jan 2024
 09:45:23 +0000
Message-ID: <43b6b9ce-bbc8-4c36-abcb-85ed8c1eb40f@oracle.com>
Date: Thu, 25 Jan 2024 09:45:20 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/15] block: pass a queue_limits argument to
 blk_alloc_queue
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal <dlemoal@kernel.org>, Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, virtualization@lists.linux.dev
References: <20240122173645.1686078-1-hch@lst.de>
 <20240122173645.1686078-9-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240122173645.1686078-9-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0179.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::7) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|MW5PR10MB5737:EE_
X-MS-Office365-Filtering-Correlation-Id: a834ff4b-d713-4a3a-94ca-08dc1d8a5a2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ho8/9HvWGnVmVp5o7uUf1ROxkfWutgMEVDVOMZNspCRE2E66gnnv3bX4Ih6pmltfuegdGmhdQQChp6Sj8yIfTzWbrpTFjehTXyW38pEVv0m1NW5vfszyCngtO7Eh9MU5Ps+F8Ia+BF3CUfalrT/BDmqB9CITw2Z0JzkLz5M0pe+JvyyLDmh58GYJT+GhbVt5dfXBOEDePrrYdZHWpr7FQghlw6l4JBLi4ZVvDoqf5lkVaAi8kMLmH0sDjgYVjxSzJWMQKOA4Tg28942+5wBlG7mMQB2dcXtXL/tDuk8sKpjmpVXjJzHqsc4hgyX35Ez7h/GyFgnyHCArIDQ4o8THqcLl97ol8grK9W7bQBLBDBIUHrnQpKryyWKvIL9i3x8ke/oipiir3Rc6zF9Lu8W/PWQIPJ7TT5DwEt83f+ffxD85BCj1jayBMNaRsufSthBdQrcMMH9amXv5yTj3II09C8EYrHCTI5dANJplXeLA7DfM4eyqccPYzZNZKTxwCIPRxV6UwVbj7zfG65esE0tDP3+bkPvXvVWnNC3QjpPH8dtUQXvnDk8/YOD3jL2ceK/02i76d9c2Vzpqak3wG5wEdqiSft/h+FEx0PkSUDi7oHVHhOLcWMqC5x42oscGvwjSTrhhWxYtG/P7+aaWt386oA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39860400002)(136003)(376002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(31686004)(36756003)(86362001)(31696002)(8676002)(8936002)(5660300002)(53546011)(83380400001)(4326008)(38100700002)(26005)(2616005)(66946007)(54906003)(66556008)(66476007)(6512007)(2906002)(316002)(36916002)(6506007)(41300700001)(7416002)(110136005)(478600001)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?RGhHeEpKNnB2bTJMZGZqT3BmeGM3eGlHbHlFODk3YVAranhaaGo2VEQ5b0Yy?=
 =?utf-8?B?MG1RaUUyUmJuTjdLY3hHQnFZZGJhNSt2d1I1VDRrVTZwQjk1b3BCNzdkeDNT?=
 =?utf-8?B?UEVsVVRjaE5FeFJWRUJrRjRqWkRseFVGZnMyS0lSQ2Qza1E2alhFRThMOEd5?=
 =?utf-8?B?aHRUOGxCc1JrM2ZMOEZIUFQ4SHBnVGdTK2xFbHVIcHRGU2lpMG1tVURIRFcw?=
 =?utf-8?B?Qm9sYjRYSGNZbGhVMkVJVzc4djV0cDBNWHFBSzJwV2cxR3BhSE5aTWxMUG9J?=
 =?utf-8?B?eU9YY05nMFQ0RFdhTll4Snd6bXFNM05jN3Q2eWN6S1Q4SFl6QWNxbE55TUhW?=
 =?utf-8?B?c2lMbXl2OVpOcDh3WVlkVTJwbU5kSStma2ZVZEhzSzhEQmY3T1lTV2RQQW5E?=
 =?utf-8?B?K0VrNzdmQ1JHZkZQQXM4d09pUk1ONEpCMDNYTDdpNmQ1cDlQUDF2NVRXa2Zj?=
 =?utf-8?B?REw3NnBmcFFQMlhjeENEQ0d6ZVExWWwyLytnWE5nT3A0dFlzbGUxMXJXeHZW?=
 =?utf-8?B?TnZudko5b0toU0RQOTBwcGxLKzBUMWJqZXJhenprU1pLT1Y4UzNkR3ZaL1ZT?=
 =?utf-8?B?QXpDc2dCOG82WWtFOGd5UlRibDBQTjVLMUJnMWR6c3hzckdmSmJSVkdTbzN1?=
 =?utf-8?B?cWJKcUVqc25OMUlhZm0ySjhwcHRlQk9iQWRjV1JaVmVCOEhVTU9Lb21pQXFq?=
 =?utf-8?B?aG83MEoyTnQ5b0ZkdVFnUGQ5YmQvZktMazJxK0FUT2w4YWJpVUZXZ2JuZGlj?=
 =?utf-8?B?MFVmNXF0bTBaLzNwR2pFaEFydE9aOUVFajYyZjZJNUlpdFh4N3YwcXRjNS9m?=
 =?utf-8?B?azNzWDA3TjB1YjRpUFh1RWVaaGI0UlBuN1NoMXZrS2hjcGxFT0ZOVm9lVmVy?=
 =?utf-8?B?VWRwVkFLUHY1T3dUMWVtb1RjbzQ1SExVZlhqU1p5U01SUUZOWXhsUVc4dG5n?=
 =?utf-8?B?NVVoN1p6R2NWU0NvTXl2em9VQXJnVlhiUyt0WVZzbWpUQTBlVFZPZnJjTU5m?=
 =?utf-8?B?U2tBN0hFUFp4RHVLYjdxdTVGRFVDTE9HZTQ1R0M3cEpIb1VTYnJEN01xZDRG?=
 =?utf-8?B?VGYzRFJGVC8xQ24vdVJUbkgzTGtMdWpTMHZKVkFzU05MempHSTZidTJvd3FZ?=
 =?utf-8?B?am1CaTBORlhyeWhLVzlPM25wYW10ZEpuSkQ4bndqVHVhSnh5cGxqTXVXU0Nj?=
 =?utf-8?B?VmVLKzBBR1g3L094cXpINlg0OEJMdEF6WXprNmxMd3Q0Tk5ia2ZhLyt2RlJs?=
 =?utf-8?B?Qy9RS1JYZXNDbjNCOFFNQlFtSHFKSGxCaWR3WnBtbzFwRE1wWWRab2NjUUZC?=
 =?utf-8?B?VXpnb0dtcUJrNGJKaUVqVWY4d2F6WEk0YU9TVVFzYjhMeUFPUXRXM2s0eFJo?=
 =?utf-8?B?L05LbTFPdUtkQUtyTmNGT3VONXBSYVIrNkJWMGI5OTFNbUhQZSsxRUYwbFhM?=
 =?utf-8?B?OG8rU0hBSUJodXFZSit2YTBGWUxVZE1ZUDN5aGIyYXNyRWxaeVRKd2N1b29E?=
 =?utf-8?B?TVR0eC8wSmpxR0J6emJPZmp5U3VmZk05Q0VSSFBneUtlTGNOMmFFVmpzVFpD?=
 =?utf-8?B?a3ZaSVJIUmFXVFo4ZzQ5eS9CV01UZ2dQR0t2QUYwa1FISCt2cXEvcVFkNmo1?=
 =?utf-8?B?MS9GM1NnbUZiUmtmTGVyUUlPTlhUL3VzWU4yMU1yUjUvL05qL3ZjV0JOWStO?=
 =?utf-8?B?M1VJMEZLaTFZVWdiUEdDREtrYmZhcm1NK3B3SmFtYjdGVGdyS0tOa1duaDNM?=
 =?utf-8?B?ekF3R0Jra3BpUkUvZEhObG9RYUxybWpLT1JxYXdiRXBHdks5QVNFaFRYcnBL?=
 =?utf-8?B?djVlYUFQaTBVbDhucGVSM2ZSZzY1WDRZd2hDTE1MMlZMOWZiZitocVNTR2Nq?=
 =?utf-8?B?L3hRVzdCR3VyblplMHFJRHAzWUs1Z3BSSXRzemgvYnVtTmhNOTlNQkMzU0R2?=
 =?utf-8?B?RlVDRnI0aE5LYVlnL2d4VXFHbE9zUGsvdDh0SFUxMGhObFhFckUybHoveWI2?=
 =?utf-8?B?UUVQT2lHUWhOaGNZSkc2dS8vSCtWTElEK3pqV1VqL0t6WVQ1TnZLVW5mVEJX?=
 =?utf-8?B?cHJXei9xdDdpSFJNOUdldnVFNUlQd1h1VWxwdWM4aGhOTWhUT2xxdVVVOFhx?=
 =?utf-8?B?Nk14WGRVbDc2dUNiaS85c0tGUWI0UU5zOVlPaXhlZzlIdlhNczJGNjFkc213?=
 =?utf-8?B?UWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pZ5wOxVuzLL/lztI1Y07lumq08v8pjKSUk1xCzbuklxDyOx46NeBToxYXfbG7WKW4V2JJT0AK98AdlYKOMsSt976PgcIcKv8QFF1R4/5drauE0ETFEEpn1FStJuSnxAjPoinEgPlh2ArWY9osDtMOGoyyd2TkC+zUJPrmCr1R2PL/HWV9HjzVrYzvDD3Cy275+VkECq4h0DA4re153vy3EuKu8YDvh2R2rWxbjyeVEI8P1DDY30rQk4bJ2bSxCDqhHo6Z/1+7UVy125z172Q5AE8JazqNsJY5dJgpYnqmvuu3fe+df2nSUzFpggW0XWe3GZ51PGszA9KjwcKWlSbcWHAVumy3oj2zNdop4OjDJdm+7zNBEPORJiqpi0Z9ojvSRsB848hAEZV01xIhDpe1wwmWM/pgkjALlxzqkRhAiwfTfDK4cjrTSmBy8+gnzCEE73RGxSF992If6KTLkjsBU+dqiXOpZG6uJQGmpcxLTuFRkhSCzSlH8R58UD8xHZC8ZscEGFdJmV2/kf5m3J1YXo7zaVhAF/FZkf19dMg8SDybHVe/8Td26co3llb2BOpGpfsYajLi8MxA+KlUbCgs5kQ4xk4Kyz597F1qFak97E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a834ff4b-d713-4a3a-94ca-08dc1d8a5a2b
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 09:45:23.8031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L6y8PQmddZbTvnoDCjo5qJK9kgJI257XjBSkTu62Gi3xIwhiZoZ8OXIVSwCpZIvGMyaFjr1LZIyo4ZvgflqK9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5737
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-25_04,2024-01-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401250066
X-Proofpoint-ORIG-GUID: S5g-rEAWX_yiG3bBVcCDYPPHrxblpMu8
X-Proofpoint-GUID: S5g-rEAWX_yiG3bBVcCDYPPHrxblpMu8

On 22/01/2024 17:36, Christoph Hellwig wrote:
> Pass a queue_limits to blk_alloc_queue and apply it if non-NULL.  This
> will allow allocating queues with valid queue limits instead of setting
> the values one at a time later.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>   block/blk-core.c | 28 +++++++++++++++++++++-------
>   block/blk-mq.c   |  6 +++---
>   block/blk.h      |  2 +-
>   block/genhd.c    |  4 ++--
>   4 files changed, 27 insertions(+), 13 deletions(-)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 09f4a44a4aa3cc..9f1af8fba4dcd2 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -393,9 +393,10 @@ static void blk_timeout_work(struct work_struct *work)
>   {
>   }
>   
> -struct request_queue *blk_alloc_queue(int node_id)
> +struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id)
>   {
>   	struct request_queue *q;
> +	int error;
>   
>   	q = kmem_cache_alloc_node(blk_requestq_cachep, GFP_KERNEL | __GFP_ZERO,
>   				  node_id);
> @@ -404,13 +405,26 @@ struct request_queue *blk_alloc_queue(int node_id)

Is there actually an issue in that blk_alloc_queue() can return NULL, 
and we should be checking IS_ERR_OR_NULL() in the callers?

I don't think that IS_ERR() picks up on NULL pointers, right?

Or make this change:


diff --git a/block/blk-core.c b/block/blk-core.c
index 76cd797d9712..a447b0501e82 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -401,7 +401,7 @@ struct request_queue *blk_alloc_queue(struct
queue_limits *lim, int node_id)
        q = kmem_cache_alloc_node(blk_requestq_cachep, GFP_KERNEL | 
__GFP_ZERO,
                                  node_id);
        if (!q)
-               return NULL;
+               return ERR_PTR(-ENOMEM);

        q->last_merge = NULL;


>   
>   	q->last_merge = NULL;
>   
> +	if (lim) {
> +		error = blk_validate_limits(lim);

nit: This is only ever going to return -EINVAL or 0 by its very nature, 
right? I suppose that it could return a bool and we do the conversion to 
EINVAL here. It's a personal taste thing, I suppose.

> +		if (error)
> +			goto fail_q;
> +		q->limits = *lim;

nit: It might be neater to do this in blk_validate_limits()

> +	} else {
> +		blk_set_default_limits(&q->limits);
> +	}
> +
>   	q->id = ida_alloc(&blk_queue_ida, GFP_KERNEL);
> -	if (q->id < 0)
> +	if (q->id < 0) {
> +		error = q->id;
>   		goto fail_q;
> +	}
>   
>   	q->stats = blk_alloc_queue_stats();
> -	if (!q->stats)
> +	if (!q->stats) {
> +		error = -ENOMEM;
>   		goto fail_id;
> +	}
>   
>   	q->node = node_id;
>   
> @@ -435,12 +449,12 @@ struct request_queue *blk_alloc_queue(int node_id)
>   	 * Init percpu_ref in atomic mode so that it's faster to shutdown.
>   	 * See blk_register_queue() for details.
>   	 */
> -	if (percpu_ref_init(&q->q_usage_counter,
> +	error = percpu_ref_init(&q->q_usage_counter,
>   				blk_queue_usage_counter_release,
> -				PERCPU_REF_INIT_ATOMIC, GFP_KERNEL))
> +				PERCPU_REF_INIT_ATOMIC, GFP_KERNEL);
> +	if (error)
>   		goto fail_stats;
>   
> -	blk_set_default_limits(&q->limits);
>   	q->nr_requests = BLKDEV_DEFAULT_RQ;
>   
>   	return q;
> @@ -451,7 +465,7 @@ struct request_queue *blk_alloc_queue(int node_id)
>   	ida_free(&blk_queue_ida, q->id);
>   fail_q:
>   	kmem_cache_free(blk_requestq_cachep, q);
> -	return NULL;
> +	return ERR_PTR(error);
>   }
>   
>   /**
> diff --git a/block/blk-mq.c b/block/blk-mq.c
> index aa87fcfda1ecfc..2ddbefdeae93e4 100644
> --- a/block/blk-mq.c
> +++ b/block/blk-mq.c
> @@ -4092,9 +4092,9 @@ static struct request_queue *blk_mq_init_queue_data(struct blk_mq_tag_set *set,
>   	struct request_queue *q;
>   	int ret;
>   
> -	q = blk_alloc_queue(set->numa_node);
> -	if (!q)
> -		return ERR_PTR(-ENOMEM);
> +	q = blk_alloc_queue(NULL, set->numa_node);
> +	if (IS_ERR(q))
> +		return q;
>   	q->queuedata = queuedata;
>   	ret = blk_mq_init_allocated_queue(set, q);
>   	if (ret) {
> diff --git a/block/blk.h b/block/blk.h
> index 58b5dbac2a487d..100c7a02854bfd 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -448,7 +448,7 @@ static inline void bio_release_page(struct bio *bio, struct page *page)
>   }
>   
>   int blk_validate_limits(struct queue_limits *lim);
> -struct request_queue *blk_alloc_queue(int node_id);
> +struct request_queue *blk_alloc_queue(struct queue_limits *lim, int node_id);
>   
>   int disk_scan_partitions(struct gendisk *disk, blk_mode_t mode);
>   
> diff --git a/block/genhd.c b/block/genhd.c
> index d74fb5b4ae6818..defcd35b421bdd 100644
> --- a/block/genhd.c
> +++ b/block/genhd.c
> @@ -1396,8 +1396,8 @@ struct gendisk *__blk_alloc_disk(int node, struct lock_class_key *lkclass)
>   	struct request_queue *q;
>   	struct gendisk *disk;
>   
> -	q = blk_alloc_queue(node);
> -	if (!q)
> +	q = blk_alloc_queue(NULL, node);
> +	if (IS_ERR(q))
>   		return NULL;
>   
>   	disk = __alloc_disk_node(q, node, lkclass);

