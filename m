Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF58C7EE2E
	for <linux-block@archiver.kernel.org>; Tue, 23 May 2023 08:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbjEWIZU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 May 2023 04:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236232AbjEWIYy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 May 2023 04:24:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A766BE6D
        for <linux-block@vger.kernel.org>; Tue, 23 May 2023 01:22:28 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34N6F1R2000710;
        Tue, 23 May 2023 08:22:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=Fqzt4cBDtjVyWaXbtdPnukR1wgNrGg/7aC40HsoTUK8=;
 b=kFS7YvtUkKon2ixmv10UTOidgswxQ4Su9/Js0DAP08gewZKyFjesecTfHN79WuQSmw/l
 gZ5/68PBRXBMrK6bJEpuiATCZeGyDvUM5bQTxdsWZvDx1avwNqsMvej3ELgRGGdAX4TG
 zd7BXKwhdNeT9lDiFHPAbuqw38RZvk4CZlQ9D/TgnUcywObXX30bp9pwn1CyfQDUFoTb
 ChFWlCA2tHXnEB4ig0rh81qhEiJEdAotfhwxLq23pVa4AGO+IVaJ8Qpswq/tSXQmNJO2
 9AtMT2V1as88lTULzEQfZg4y//Zwf/Js8NjUSWDjPZ5GcUoUcvPFHgRsBpFPzuCHTgdm Ig== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpprtmh4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 08:22:19 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34N6ojUj027219;
        Tue, 23 May 2023 08:22:18 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk2d8hep-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 May 2023 08:22:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g5QrWiYT182xQqOYtgNJsH0MeGzNjosxZ4qsGmfCkftkFNkYM4QslgNRKatpCsdPrQNKeDxoz+ZtfoRzu3eYgPnEOH/k4G5SvAhSr5RDkGltPPmLbcQ7l7DO6HfELeb5XIl9VKowuvI8VR2gAkIuDrMgPT9O3Ga4pSZmR4v9MNiYeuWOCgr/d9E69mPDtkfSkZdHiyPJPD1EruhA0WXj1vO+uWTMLWc13evxe3FpEjGiAUs0dPwNjlEhWxVzyB8gyNWaOUf2ZI4wB4OwiObtc4AJgZgaO5lFN5Bj7nfm9iZjYh2fqRHEYasL96z3NzikjTnJOf7Aare8632VxdoNFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fqzt4cBDtjVyWaXbtdPnukR1wgNrGg/7aC40HsoTUK8=;
 b=ko7jLNjWBygdpsJlLymM9MhWPP2Z7fhy6yshlyh+cdIigsoj7tFSfD+Wv4AucGxcRxhDcSnD8rsXRPNrpuoW/FKzTb0tcjfl+UYRPJiuXcR8sXNP+ube1P4zeb9VXqLGsZCCAaUhkrY8iqzhKDOA2VSA+3REX9Qsiv4zp9BhLaskewqwRFOwmvh3E5W9dKuS0yTonnBARwgR2+dff8gZ1FbgDg9dkOg+9RjXb6ws5cyMgtTPljdFTPPT+LFtovB4cWBSfoAZQUa/Jy/2UYUOqgcwfhvj8wAYAKdNHz5jd1TgMlYWNxvxE9KYd/xw6NT2SkkSc5ce6wRss+iBTY6jhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fqzt4cBDtjVyWaXbtdPnukR1wgNrGg/7aC40HsoTUK8=;
 b=iZxMWEd9BwqcnWRwI+PYS4WpqX8ooziSK38MwCM3xMUdaw8EwglKYMR88+tKivG3TSYSTjN5lwRXWU9FZs86kIKnZJfYHmvxqHF/oyhpuAIG6NWhhD5KVzZ/xc3UIiu6XlRpweH94tcDPtYWSnGEkHWbb/kl9GhSPHILN20NNhA=
Received: from CH2PR10MB4312.namprd10.prod.outlook.com (2603:10b6:610:7b::9)
 by CO1PR10MB4770.namprd10.prod.outlook.com (2603:10b6:303:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.29; Tue, 23 May
 2023 08:22:16 +0000
Received: from CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::cd3d:1d7:c4bd:d290]) by CH2PR10MB4312.namprd10.prod.outlook.com
 ([fe80::cd3d:1d7:c4bd:d290%2]) with mapi id 15.20.6411.028; Tue, 23 May 2023
 08:22:16 +0000
Message-ID: <cb475361-dad3-1be0-31a4-710f4c1ea95f@oracle.com>
Date:   Tue, 23 May 2023 09:22:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/1] blk-mq: fix race condition in active queue accounting
To:     Tian Lan <tilan7663@gmail.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, liusong@linux.alibaba.com,
        ming.lei@redhat.com, tian.lan@twosigma.com
References: <a11faa27-965e-3109-15e2-33f015262426@oracle.com>
 <20230522210555.794134-1-tilan7663@gmail.com>
Content-Language: en-US
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230522210555.794134-1-tilan7663@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0059.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::23) To CH2PR10MB4312.namprd10.prod.outlook.com
 (2603:10b6:610:7b::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4312:EE_|CO1PR10MB4770:EE_
X-MS-Office365-Filtering-Correlation-Id: d6ef7b77-9d5e-40ca-b770-08db5b66d11a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cqBlzF+smAkB0RkemLriaDaAlaOR1/MRfaDi59EqCb+YSGzyfuCJsHueViHKxIZ6WM+ZdXak24ncHui9FEVCJTQPR9+asqimR/vDhkqgVWeD8ACWME0XAHvKzrELuc9W/HTijNR8Jmlowrq5o4qAq+0vhRMSQFrRtZ4ocG/banvX8cr5zKYEP51gMdgoCXwKI62D5l+a21BP8Sy/hA0cK/p/uOQO7nkio5XEWyHdaQLk0eyWhl6jwUZHCsPP48EkVJQDJxvzm0HyMLcysnHhWAwqaqhyvjqyYpYt1ODb9Jtd86cQLNLV8HXmyb9i3FNR8ZgCZW0EoNTXaDekVyvBVGG6nYgqZkb2MPJR8GfF5+XGOAgwv4o9aBJAlQo2gCtVcaM5n7ZuQhLCiiLfObBwt9DMUuAJvdoL+cixO0gvly3h9I4B+IOOcvRlXFm7quLr6Ipcmm4B2O0XYnEmq/TnHEuYTPWL2CnzVyN0qsuuya2s5FBX78SIB/CVxeZRw535E6VR2qPt3FO1aJV3YM359Tcumnhvr2WIkkDUkM5SUPMr+1q2318T5f9FlO5e3kw2PNywGR64O/2lkRZVLiQB6fk65ugwTaF+Ht0TRGTwvUIGZt8Eyqq7lm27EKrZP/T63Tx1jaXfpHYbz4HKaZ11fg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4312.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(366004)(396003)(376002)(346002)(451199021)(186003)(53546011)(6512007)(6506007)(26005)(38100700002)(2616005)(36756003)(83380400001)(2906002)(31696002)(36916002)(316002)(41300700001)(6486002)(6666004)(31686004)(478600001)(86362001)(4326008)(66946007)(66556008)(66476007)(8936002)(8676002)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WHYvcXlVWThzS0FPZU1tb3hTNlpLMUlseWxORVM1MnVTYXZmd1QxRm1qVjJr?=
 =?utf-8?B?VXdjK0NpMWJhMFQrRithL2gyTUMvd0t6U3BlTVA4QlF2c1VQN3JkTEdDOXN0?=
 =?utf-8?B?R3RibFh5M3BxTGhhYXRLSjBkdEJiVnFOK1BzbVBBeWVPS1pld0ZMS3BidFgr?=
 =?utf-8?B?c3J0dHFKNW5nams1NHdrRzdXaWJyd0FVcUkvUDdLbkhPSlRjMUxkcWhTbzl3?=
 =?utf-8?B?bzMrMWkxM2IxTGpwRTA1WHVURzhIYS94cGxLSlRkdzAwSkV2RFQwdzhvejJl?=
 =?utf-8?B?WXdVelg4U1NNOGpiOEhUQVBIMk5lMmtjeS9TOW4yUFBjRnVNVUVhQ3VxN1RO?=
 =?utf-8?B?eXBmTzl2V2V6em8zbjB0TzRheHpQZGIwaHBCek0yeGZ2anErUER0R1YzaDBw?=
 =?utf-8?B?Q0NKbmd4b0g4V0FYT2ZNaVFvaFlTUnZwckcrYlVJVHJJT0NBOVoxNDNXVnFp?=
 =?utf-8?B?akpLUkRNeFluOW9IR1hUWkpNNGR4WllBNkhUTlRCSklVK0RFR0xGSzdURzB1?=
 =?utf-8?B?MlBTTzNycDc3Nm8wTG85enRHVHZNRktGRjBRdTdpaXljRkhIb3BIVlU0dXc2?=
 =?utf-8?B?cjRxcUlIQXNuZjhua1YwNitZSm8yWWZhRzJTbzU3WklpUTR1b1AydWdDcm9H?=
 =?utf-8?B?UmpwMXF3c3pOQ2o5Qmh6bzNLNDlQUy9vdmhGcng0Nis0K0wrNDYwcDZqaGRz?=
 =?utf-8?B?ZVJBT09NWkVIb1N2TkVjQUdQM3VPeDhmWmpNck9NRGc5NHNWaTNxaERQY1lS?=
 =?utf-8?B?TW1DQVJsYVVXUGcyUzRrdjFSVCtTeHMxTHp3SU0zNmlhckp6cjFHNEFsT0xJ?=
 =?utf-8?B?MlJYTGxuSUdLdURJVkEzWjdxd0hpQWRvTEUvVmdZQUNUNG55MlY2NmVnd0tL?=
 =?utf-8?B?dnVpY2V2Z2U0aTI5Z2ViTkljQWU2SW9mL3F3dWlhMDB2TGJDVWtCLzlXZTdF?=
 =?utf-8?B?VEIzNGpMZHdjMi9LVkRKcG9tdERtVmxMOGpuUU81QTlLdGhPSERjV0lMWStD?=
 =?utf-8?B?Q3JpUDNZbThVd01UdVlqTGRXY2VyTi9iT1F5QzhQZ2dMR2hVUWVYLzJ0dE54?=
 =?utf-8?B?QktSY1R2dWd1S0hQLzBORkV5ZVREV2NPaFQ1WDdVU3NFMVkzZHZWcjRuaTJR?=
 =?utf-8?B?MkRTTGNPTld5UHREb2pMQ2RqOWQwc0dFbnE0ZlZOVFBSOC94eWU4MnkxU3RS?=
 =?utf-8?B?d2hWRkV1V2c1TGxKTXlUOHJMbFVBMmJtTk1MZklwdVc0Z0czWnFQckVrMW5j?=
 =?utf-8?B?SHhYVHR0RVY4Z2hSMm5JSFJaNXNSOWFHMkpCUFRlN0luTjl5QU55WjloN2NV?=
 =?utf-8?B?OFBhV2YxMlgreFFyNWdrY0t0Z3FPRlh6ZkFmT2gxNHlYemxmK0xrZ2VoQjJD?=
 =?utf-8?B?MDBKb1grNlZwMEJldzVTQjlCWUNYSHhjMU5tblNLUWZxeCt6RHJhT1M2dEcv?=
 =?utf-8?B?bzJiRkNnSVFOa05iT1hSVkFYVXlUK3laMnVZZUoyMEpHVDJuWjdSN29nSDFm?=
 =?utf-8?B?d3AzR2hsSjdDdUtuMktKMWVyRGtjUGN2MmJOeVR1aWNjWUk5a3h4ZW4waEt2?=
 =?utf-8?B?clcyV1R1cGdaQW13M0pHMk5CVE5WdENaZHpsOUduOHJ0a2l6R2pudUx4Y1VQ?=
 =?utf-8?B?NUlpa2FtSjN5RjIzM1Qvam0yMG9Va3dmTExVRnlGQVJBRkZodjB5eTA3UUc0?=
 =?utf-8?B?Q2Z6aXVDZ2VKNUJlaGI3NEdGMytpR0lvS3BRdi9JcFREQ3psekFnRWxBVVhl?=
 =?utf-8?B?MEU4RHAxZlJNWXIyS1d6RTdkdnRJS1hOOTZuSUIwaDNmNU1aZ2FDTytQblNS?=
 =?utf-8?B?ZGQwT3RHS21pRTVCbHdBZ0ZkTEVrQk1wZTVXVWdrUGlXUm9sdlFSVGppWEVo?=
 =?utf-8?B?ckJlcWZncHptbTk1MWJRVW5ndTNQVGRGdmJvcmVMSnhwVHB1bDdjVmh5cW5I?=
 =?utf-8?B?dERWU1V1d1pWZEN5aDlQcWlvaXJsZzdDOXNqTHdwMy83a1YrS0xJbkNpMlJW?=
 =?utf-8?B?WURZeExVQ25uUDdoUzQ0THl6c1ZEWGVzYlcyTU9NdDNwVnl6eW5UclM0VVV4?=
 =?utf-8?B?SVdIVk9Xc3A3WXlnTVpwSWw1M251cGlTaUZ2eFV1RjNPRTQyMVJoZ1NLMG8v?=
 =?utf-8?Q?FB6xzc1YW/Id5Am5QIInpcoFx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: onBSdWYQYmOB1JbAcDxSRXf4qT6hY8iwtWOwHDsimsGG4yVVP1YjrtYlARuR8b71usNCSGyiWlYihMhySLUvTXd/cMQPJ2uxm4IlCXS2czBbHzzAvPi2P+SeJSdfMHzUjoFUnuzwqOtKEDYrRO5rzkaenXMdxmJlU5LQJfdMsIee1ViTY+gmt+tSu1Haov9hQMcDBX3cxKT4ZiM2QuK9PYSxutJyMnjTr5d2XCPTL8qMN9VWcbxtalNHFsAAxkLHcOC4CmeZpACpjp9n4zIV7e5wnLh9+va0JcypdphztvpU1HBtWoCiLQn4vLBRVsoJQ+CmfuDgBepG0W9cw4ezX/noysWfvkaqUTjYN/aHa8xYchFiNYheqzf3Dc9R64pJI1uXYfG0Cp2Uq9Qdxvt2T28lEZa2Leb94r6/1Aj7o3jM7RRMwjeD2TQJf0Kj1iMsG5aXIyNvJwZviZY7vfXXYTEhGqCjTYFM6pcrH3xB2QO3yq7hsU9rMPgz16qpYEm3Z7R8jFgM2yQK2OXD9KGSrfESEgiyOZkqKI6hOnnbzsBfETLVzNaWAUg3wfyvsOtaGyGxAM7QVsLDrwnhHgrMSb7i5KtimsWPAZiFgGZHacFlHIcmK89aEu4aRkwJ6Jp00me65n8Xk4qQcKFN5Lrlr7xxTvscFb1Vz/fbshg7fsEB2yMoQ2Y572GmSFYLfKFxW5PwY1qzWtfUuKGVojDB59s9nFh2u0nGXA6ffW+iWFgxnOR6p4qwZCARP5RW0ESR1XC8qxREangw2JHwPzWDjDm+oOYuaH8+SUd5MNsT/VJxpAwi+NeHXvOtj+/cm4QYNk8TLCh9ZdKiitr/LvC2h9R/0MsHPWZz1WB+/Lm7XT5V5uqtE39pEMCX517xODTsl00zwMXjshLa232EUcpXudRyVEFlkG+OTBMyTyW7WwI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6ef7b77-9d5e-40ca-b770-08db5b66d11a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4312.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2023 08:22:15.8861
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ACaEfnZbgiKIxiutsnN6PHjq74hiVf/cqBWIoCx8O6B2UkqbH5Ll2Utrt4RbuCH5UTAMa+4mj8PYRqWJfcwsAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4770
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-23_04,2023-05-22_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305230068
X-Proofpoint-GUID: d9gCRatBfNoPfv_xb3xGDp1tOj2M7sP7
X-Proofpoint-ORIG-GUID: d9gCRatBfNoPfv_xb3xGDp1tOj2M7sP7
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 22/05/2023 22:05, Tian Lan wrote:
> From: Tian Lan <tian.lan@twosigma.com>
> 
> If multiple CPUs are sharing the same hardware queue, it can
> cause leak in the active queue counter tracking when __blk_mq_tag_busy()
> is executed simultaneously.
> 
> Fixes: ee78ec1077d3 ("blk-mq: blk_mq_tag_busy is no need to return a value")
> Signed-off-by: Tian Lan <tian.lan@twosigma.com>
> Reviewed-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
>   block/blk-mq-tag.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
> index d6af9d431dc6..dfd81cab5788 100644
> --- a/block/blk-mq-tag.c
> +++ b/block/blk-mq-tag.c
> @@ -39,16 +39,20 @@ void __blk_mq_tag_busy(struct blk_mq_hw_ctx *hctx)
>   {
>   	unsigned int users;
>   
> +	/*
> +	 * calling test_bit() prior to test_and_set_bit() is intentional,
> +	 * it avoids dirtying the cacheline if the queue is already active.
> +	 */
>   	if (blk_mq_is_shared_tags(hctx->flags)) {
>   		struct request_queue *q = hctx->queue;
>   
> -		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))
> +		if (test_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags) ||
> +		    test_and_set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags))

We could also add a bitops wrapper function for this. I don't know what 
name to use, maybe test_and_set_bit_fast_but_racy() - I'm half joking 
about the name

>   			return;
> -		set_bit(QUEUE_FLAG_HCTX_ACTIVE, &q->queue_flags);
>   	} else {
> -		if (test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
> +		if (test_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state) ||
> +		    test_and_set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state))
>   			return;
> -		set_bit(BLK_MQ_S_TAG_ACTIVE, &hctx->state);
>   	}
>   
>   	users = atomic_inc_return(&hctx->tags->active_queues);

