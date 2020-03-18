Return-Path: <SRS0=4fFE=5D=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B16C10DCE
	for <linux-block@archiver.kernel.org>; Wed, 18 Mar 2020 14:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051EA205ED
	for <linux-block@archiver.kernel.org>; Wed, 18 Mar 2020 14:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="csFpSbBL";
	dkim=pass (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="P0gZqPq7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgCROt1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Mar 2020 10:49:27 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:9354 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726643AbgCROt1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Mar 2020 10:49:27 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.42/8.16.0.42) with SMTP id 02IEekbD005682;
        Wed, 18 Mar 2020 07:49:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=fO46zx6kgpq5b3wugWg8hvj68hK42nKVexAbck4slIc=;
 b=csFpSbBLHEEFQNn9gMeeBAah160vSuov4Vx2k+F65C+tXn2pQySgDsyrehP7kqu9tfTj
 GJDuu1dQLrv0pq66q6xhNK5et1lADcDGyJCFFIgW2W8f58EJFHRlHVMin99PjfR5YXxP
 v1kTXGSVT42bU4wnKp5NdXpWNzQrIUdcNDs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0089730.ppops.net with ESMTP id 2yugve18w6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 18 Mar 2020 07:49:22 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Wed, 18 Mar 2020 07:49:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOq+RHrzBNiMiQu3SWEtPDPA04a6vElOmvg//gBRAIpCLbJ5/yvmErNSX3fsvNfCgzwVAI01ySgSPkOSUgpvBcB2x9ilJYyYiF6JPYpGkLmu8un0stYDa20iDnTL1+lTWAlYcmg+k9Sx0NvqaqUK3ZWHjSxSLC/Q83cqyLhyEC36QbFhEb/lhUFgOca2w2LQg4npDyO/eM/lUTYL2bhOCd3oa/lyVSNvKILGwW296P4jU2Z+8l7chQ3596sUDc6repb8PBi/bPV1IzM3fX7+Y5gOpZyQtSYlsevd7Fy6qWvV0XeFmhei5ARyewMaKw08NQ02Pox8j2m/tFTZV2whBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fO46zx6kgpq5b3wugWg8hvj68hK42nKVexAbck4slIc=;
 b=G90z/r4szyY2ahpNXujwNW5sfGyNMreKCpnCruYnwG6Tmt+UrVs3vcao1ZuE3OhYtoG2GboDV0kCyq/B3VGCtINtEFT0Q3g0aMSvhlKH0a3xDAOx1KpQGVqoz5fmn+x+A+6O4um4y76xDjagTU8Sh9bY9bvXpKN10QTc9q1uas10DiRAWied+rH2dCue2D6vUEEKA8NRZpi5AFxUEAAh1NP+0ocRl0qlzOHhcyIHXePFdGrxYSR2QraCMJMc+L+56yCKvE/YQryVerYX9SmODLpag5XXxW00+ZdvzBYv5Mk9grZP8BXIBNxvJOJ4ftDiykb6SmsB6lNVSLc1oIkFhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fO46zx6kgpq5b3wugWg8hvj68hK42nKVexAbck4slIc=;
 b=P0gZqPq7SqPkmKoloG5cjvwX97tMC41CTQ3r2fI0V+NJI2WyeKktav4WEngTJzsC9aW5oagSSngYpEWK1qXiqpaXij066SN4IS2BMSiDY9zBA2iHuZLIEBLSPUVpZd9jsNAqfbc0kRvrqwBStBNrh9j9KIlqcATwLYXyOPGEYwo=
Received: from DM5PR1501MB1957.namprd15.prod.outlook.com (2603:10b6:4:a5::17)
 by DM5PR1501MB1975.namprd15.prod.outlook.com (2603:10b6:4:a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18; Wed, 18 Mar
 2020 14:49:19 +0000
Received: from DM5PR1501MB1957.namprd15.prod.outlook.com
 ([fe80::ecd4:9578:4cab:197c]) by DM5PR1501MB1957.namprd15.prod.outlook.com
 ([fe80::ecd4:9578:4cab:197c%7]) with mapi id 15.20.2835.017; Wed, 18 Mar 2020
 14:49:19 +0000
Subject: Re: [PATCH 0/7] blk-mq request and latency stats
To:     Jes Sorensen <jes.sorensen@gmail.com>,
        <linux-block@vger.kernel.org>
CC:     <kernel-team@fb.com>, <mmullins@fb.com>, <josef@toxicpanda.com>,
        Jens Axboe <axboe@kernel.dk>
References: <20200309205931.24256-1-Jes.Sorensen@gmail.com>
From:   Jes Sorensen <jsorensen@fb.com>
Message-ID: <050b90cc-381f-819f-239c-0b7b8b39cb67@fb.com>
Date:   Wed, 18 Mar 2020 10:49:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
In-Reply-To: <20200309205931.24256-1-Jes.Sorensen@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR20CA0021.namprd20.prod.outlook.com
 (2603:10b6:208:e8::34) To DM5PR1501MB1957.namprd15.prod.outlook.com
 (2603:10b6:4:a5::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c0a8:11c9::1053] (2620:10d:c091:480::1:c882) by MN2PR20CA0021.namprd20.prod.outlook.com (2603:10b6:208:e8::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.21 via Frontend Transport; Wed, 18 Mar 2020 14:49:18 +0000
X-Originating-IP: [2620:10d:c091:480::1:c882]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 527e8255-3955-4f77-3762-08d7cb4b89a5
X-MS-TrafficTypeDiagnostic: DM5PR1501MB1975:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1501MB19759BCED9000A0706696DADC6F70@DM5PR1501MB1975.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03468CBA43
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(136003)(346002)(376002)(199004)(2616005)(81166006)(8676002)(81156014)(186003)(16526019)(66946007)(31686004)(8936002)(66476007)(5660300002)(36756003)(316002)(86362001)(31696002)(478600001)(2906002)(66556008)(6486002)(4326008)(52116002)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1501MB1975;H:DM5PR1501MB1957.namprd15.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aQpAawYE0hPpMLVWiRzB2fWo2+IIW3NPXu+yCK5ugXQpTRD+7fAbp9CCopHeryR3cJORC8fFLWTG1w46A4nUFYSAwAdJ6ZacIrentDE/kmzW7p8fVoL6pu2pp6qYDv+Brocmq3hSrATrSuIU6ZRIs3FNzqvVVcaOUqlxuHFMPT9fDLuE2g8nUFxFYv28c+LXswwV6j3nPVWRVWGbrE/SVoZPPlGVpPVb7VNxvqPnN1bHJWD7GoGzCdhJs0BZAJYUnVM16WqMbRjDpbY5VCz4MatboCvxrB26m0PKiM6gcrWb6cCkx1PpAzv1LqosTn7KctWnl91IKkISsWKjdm3k2E5TizrhUYjnRKHgavTlGy8a8qmidbMf1QHexJwoojJEAxVjl7o0/QulF3dxBWAJnk1lK5/PzvLmQEsXtH7SQrUNU02NlnnAiztQvC3bV7P3
X-MS-Exchange-AntiSpam-MessageData: CXDcGgE5Ij/hJi3UcklUDgkDV08YO4Q5DpitawWimC9X7JDiwQ/6tt4Fw0UQjw62ub1WBF1xmkpOT3LWM+cRSE0S8Gs07Zgjfqi90+wqyFqPTn23pY80VhEzDqDNI8/avlSLhT0E2FwVWK9hnWppVEsodk12bM+rtG/O+KKgIzNNiXNtNrcy9m52Xfmq22E3
X-MS-Exchange-CrossTenant-Network-Message-Id: 527e8255-3955-4f77-3762-08d7cb4b89a5
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2020 14:49:19.2444
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrtGdr9AmAcrgq/ksAOxnanSJnUikWgWXwyDHzhec1ozfs21tmNrFIJYzATmzb73w8VxG9BLcAEm2shbUS4ksA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1501MB1975
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-18_06:2020-03-18,2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0
 priorityscore=1501 clxscore=1011 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 impostorscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 bulkscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003180071
X-FB-Internal: deliver
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/9/20 4:59 PM, Jes Sorensen wrote:
> From: Jes Sorensen <jsorensen@fb.com>
> 
> Hi,
> 
> This patchset introduces statistics collection of request sizes and
> latencies for blk-mq using the blk-stat infrastructue.

Hi,

Any comments on this?

Thanks,
Jes


> This was designed to have minimal overhead when not in use. It relies on
> blk_rq_stats_sectors() and introduces a sectors counter to struct
> blk_rq_stat.
> 
> For request sizes it uses 8 buckets per operation type. Latencies are
> tracked in us precision, and uses 32 buckets per operation type. To
> not blow up the size of struct request_queue, I changed it to
> dynamically allocate these data structures.
> 
> Usage, request stats are enabled like this:
>  $ echo 1 > /sys/block/nvme0n1/queue/reqstat
> with output reading like this:
>  $ cat /sys/block/nvme0n1/queue/stat
>  read: 0 0 0 8278016 14270464 29323264 120107008 2069282816
>  read reqs: 0 0 0 2021 1531 1377 3229 3627
>  write: 4096 0 3072 10903552 9244672 6258688 16584704 2228011008
>  write reqs: 8 0 1 2662 898 311 375 4972
>  discard: 0 0 0 5242880 5472256 3809280 136880128 830554112
>  discard reqs: 0 0 0 1280 515 196 4150 3717
> 
> Latency stats are enabled like this:
>  $ echo 1 > /sys/block/nvme0n1/queue/latstat
> with output reading like this
>  $  cat /sys/block/nvme0n1/queue/latency
>  read: 0 0 0 0 4 101 677 5146 1162 2654 1933 832 657 52 8 0 3 2 3 2 0 0 0 0 0 0 0 0 0 0 0 0
>  write: 0 0 0 79 2564 2641 8087 6226 1580 4052 498 332 385 365 382 279 323 166 109 119 188 267 0 0 0 0 0 0 0 0 0 0
>  discard: 0 0 0 0 0 0 0 17709 698 15 0 1 0 0 3 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
> 
> Cheers,
> Jes
> 
> 
> Jes Sorensen (7):
>   block: keep track of per-device io sizes in stats
>   block: Use blk-stat infrastructure to collect per queue request stats
>   Export block request stats to sysfs
>   Expand block stats to export number of of requests per bucket
>   blk-mq: Only allocate request stat data when it is enabled
>   blk-stat: Make bucket function take latency as an additional argument
>   block: Introduce blk-mq latency stats
> 
>  block/blk-iolatency.c     |   2 +-
>  block/blk-mq.c            | 110 ++++++++++++++++++++-
>  block/blk-stat.c          |  18 ++--
>  block/blk-stat.h          |  12 ++-
>  block/blk-sysfs.c         | 195 ++++++++++++++++++++++++++++++++++++++
>  block/blk-wbt.c           |   2 +-
>  include/linux/blk_types.h |   1 +
>  include/linux/blkdev.h    |  13 +++
>  8 files changed, 338 insertions(+), 15 deletions(-)
> 

