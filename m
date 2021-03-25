Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D5D6C433E0
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 03:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22BD461A1B
	for <linux-block@archiver.kernel.org>; Thu, 25 Mar 2021 03:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230080AbhCYDyr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Mar 2021 23:54:47 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:38608 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbhCYDyU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Mar 2021 23:54:20 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12P3nX3m195314;
        Thu, 25 Mar 2021 03:54:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=KNg5yd3v0Xdt01dn9QROhE+ukOHrPFMurcyyRgeptuY=;
 b=MSiMc9ex4YMjh3sWQegv8MBdqsiLVmab6p4syBw9Ojp+EZ5dovZpXYMeM5dhDxu2EsY+
 /dkHJeL2mtr6GhX9ElvLzkgkNLcT3vgKuGGpSi9GJTL0yZJjXBl54+8OnyTjtiTyn46L
 Yt/X40Dea/+eo1oJJV6NclzPy1SsLFshwz+EMbolrCAAvdAHGNW1ZBdF6jMeSoKoesLF
 teS/SfCxen9rEmoyAS9DIhogqO8zq1I9sIw6gQ3fPGSPsiMLy2Og2oqEh6/o/qC5I1eX
 0VAX9vdRhAlf7mwOAP2yyrYzMYjBjBKXgtO/ymkQR+Hzk31L+HCNsIDDIvchjwe+bJZH kQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 37d6jbn101-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 03:54:10 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12P3oEZ0041011;
        Thu, 25 Mar 2021 03:54:09 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by userp3020.oracle.com with ESMTP id 37dttu5j27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Mar 2021 03:54:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjJWHs76mxTXJZAFfhf7A5E95/jc3EAg6UXzmvmOCYTSj0bSSCkIyU0jOMGhiyULpp0TOehUXePDzi3CNLtuCDum+03E19806WDw3g3mHlzwEWuDaivgB1OsKvv06QG3ZfSyZ0CCw/JnmrYYwfIFXfba/G9MRkaoxFpWfPrZ3/+6uwMoEofENWXnwjn8v1EVKwQCjVwS23Lh3U+J9YCRbI/M6Hx6woCH8vFdV7Jp709KJqw0hPyC0xRmsEc+f7xupKjz1fJ6nEZPVngDd1iyRjwo6IX5yo2WdxP9DuoUP6GhXrE5RkAq+YDLRlYadYnrayoE6zBw636wr1Hdjtg3GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNg5yd3v0Xdt01dn9QROhE+ukOHrPFMurcyyRgeptuY=;
 b=QYjPogkSAjW9KncacVPgS8E2eBhXqFanKPDIZtrWCgQdnvbGy17KBbQmRzQ1WBXkrcwjJMTnUMqQ0JB5xvlzj7UZ+H9gmQ63N+3NpC2FWbKHS0oRe9wB6h+AOB88jRBk+M3ZG8ey59XS+tUFcQmIQdn7NmhK0Df+1tBh4++4781mPjdw8wHSqQjt9DlMh/9kj73+lcXwt3pvGurrUVtvPaxgBAns37+RSvlKYtD6lkOWinYdwaTjSb6MNPJubIZ/eP/nhB39tXPvdCYl4Avix6Zsxx2ejEbun5hB8TUAMR998FdYMqvdXnxp0CBsmolEZ1cBE3J+AarSLKdcxFALXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KNg5yd3v0Xdt01dn9QROhE+ukOHrPFMurcyyRgeptuY=;
 b=iR67wTaIsmdmXo0BRL+9bj1OQ0KKRKXj1Jo6dR1W5/rI6Tq7jE8ojrWgVjE+fNNDUsNbiE9TFSHT/Yc45/XbI1MAHFpX65zftZFqt51BtQCB7eQ0rXchBZx4hvIBIt3YdfSyLBzpT/4YG7NWsrI06p5yTJuZaDkHcd/FdAsapms=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4774.namprd10.prod.outlook.com (2603:10b6:510:3b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Thu, 25 Mar
 2021 03:54:07 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::dc39:c9fa:7365:8c8e]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::dc39:c9fa:7365:8c8e%5]) with mapi id 15.20.3977.025; Thu, 25 Mar 2021
 03:54:07 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Omar Sandoval <osandov@fb.com>, Hannes Reinecke <hare@suse.de>,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH v2] sbitmap: Silence a debug kernel warning triggered by sbitmap_put()
Date:   Wed, 24 Mar 2021 23:53:58 -0400
Message-Id: <161664421198.21435.17203173588010712545.b4-ty@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210317032648.9080-1-bvanassche@acm.org>
References: <20210317032648.9080-1-bvanassche@acm.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [138.3.201.9]
X-ClientProxiedBy: MW3PR05CA0029.namprd05.prod.outlook.com
 (2603:10b6:303:2b::34) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-mkp.mkp.ca.oracle.com (138.3.201.9) by MW3PR05CA0029.namprd05.prod.outlook.com (2603:10b6:303:2b::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.14 via Frontend Transport; Thu, 25 Mar 2021 03:54:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 859cc422-7635-4c06-04d0-08d8ef41a3d0
X-MS-TrafficTypeDiagnostic: PH0PR10MB4774:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB4774EEC94D0C8D3DCA1AD8D18E629@PH0PR10MB4774.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hmfgtNL99XrjyWmBDamMrHm42CGcci30YQ4umHbJWBA39/6e+P9Xl8s3C4G1D6VNpQJdSbCAeQ26NKSrgBcfcXUrAhI5M1q+zZ4XTLoHdHIde/YmILkKMtHsr8Z6UipUs380gn7awxLLeYoxWEq9K/JXhJPadNGEXfXSAb/OulJ56vuHwYz/ZJpXQRqzc544QBAsK2vzFlXWTggPAGzrxjGe243lZpi7aNGEMQeLSh9jVMkVXhEcWhKHhKk5W9sEVRkWgmFBx1vl5FibnUDtGE925Qc38xE3Cu35zQyL1nYSB5b2M3NYRXWsyVG/rJcfTnXykd/xFhfw333cTQy72wrHsb0kWcawyr1DMX/4dieYNTtevao3PjGYApV+QOcg1/4DLEHD9QeQjTT2X9Vd7jIrC5Z+uIrxoKMwodjzGiO28p/Q/nqVjIICY4Uipd5AEr5zf+MmjL5gC4vSBWzDMTJ3Tl0XtlriNlocruQS9Uy7qTtetyygULBgJ+mBZeXffHMHEUvUAZzrAw9PKmvtdlbgVyABZ7G6GhWyQBh7p9z01U2L5y47+Z9m3CuJh/AqRA+6NE19rpPRdFwcrQxtoJdvZ8hgEEVCf0G5yOJiKnbOcY+HwYxq+BPn1LkiQA7PXNqhCfPpOZ8zkPFrf+aTUIw4QCNTWl5XHAyrXhbVDawm23im4nj53GbpCmUS58tnuYIlB6jGKokyx9SGmhM3rulHJ5SxZD2c20B0c9kCfYo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(366004)(39860400002)(136003)(54906003)(8676002)(4326008)(86362001)(103116003)(6666004)(36756003)(966005)(4744005)(38100700001)(8936002)(2616005)(2906002)(16526019)(186003)(66946007)(956004)(66556008)(26005)(316002)(52116002)(7696005)(83380400001)(110136005)(66476007)(478600001)(5660300002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?M1crS3YraUVOZU04czZJNEwrMWYwdUUvaWxVTGJJWFVsUzNDOW9lU3I3cmdu?=
 =?utf-8?B?SDdQd3JuOWhHQjhMeWFJb0JLc1RSQUV4Y3dnTUVMS0hHSGsrVGdmTW5YaXZG?=
 =?utf-8?B?WlJkdmxLaXo0eTloTllxa1VHTVZ5TXAvaTh4QTgxY0hWbWh3KzhSemw2Umli?=
 =?utf-8?B?NUp6bkpTUGF2Mm5hK3R2NFBPbFQxYmpVSGRJVGdnaUNMYzJyYnZnTWNvczlY?=
 =?utf-8?B?QTZtYTlOdGo3UUFaVGdhVE1SZnRkdC9XSDJCUk0ybmJGZmNEM1lkQ0xkUzEr?=
 =?utf-8?B?OE1VNEc3ZG00UCs0Vmh4eVp1KzlGQ3hnQUFiRk9Fb3o5aEJCME9tNlhNcEpU?=
 =?utf-8?B?RjJPTVZzdW5yTHVsUW9lWkxROTZJc2haOTd5ZUl3Rjk2TW9GdmRjVnZISFUx?=
 =?utf-8?B?eUc3bTVyRFdKZFZ4VWRqQVJhR09XcEJGT2w5a3I3bUNCcTVJcUhkakNrdWdw?=
 =?utf-8?B?ZllJcHNMUkExMmRFU2NmM005SVUrTnlYdHk1R1A5dXBLZi9GM3RpV3BwMGpw?=
 =?utf-8?B?K3ZiSnM2emZhQXRHdnErWTJubUFiL1JSeFVTMFV0VklCNGNucmlQTDFhK3Zh?=
 =?utf-8?B?RHJQdFIrbEhaaWtoMjRQcjB6amxPYUNyN3BZRS9PZmpCVktQSkVvYisxRm5D?=
 =?utf-8?B?eEJMeVJoL3BRVWo2VHNwOWt6TEYzQ3dXRXZ0c1Y2TGV2NVdlWlV4L1hkMStR?=
 =?utf-8?B?NjE4QnI5MUFrNG4wQ0psdzlEZmJHbmFJUmRuaDAwSUdhRVNJYmFhNjVuWWxi?=
 =?utf-8?B?Y0czT01vOFpTVTVNMXZBb1dHYjMwU095QWxZZTd0TThzT3VyWEJhZk56cUNj?=
 =?utf-8?B?TXdNZUhla0p4cEtzVTdjUmRDVHRLMkNRbTNPUkFHSjY1aFdTTUZUM3poanI3?=
 =?utf-8?B?SGJvYUpXYk1ZZlJIL0pBcmVmTkxyVEV1aE9xUS9tOXd3amx2SEFxbHlsT1Nu?=
 =?utf-8?B?NmhicjYwaVYwQ3VrelQ2NUJsWEMyWkRkbDRJa0ZMWlFCK29xYTJUeEhRalpa?=
 =?utf-8?B?aG0yZlM4LzhrbHlSRkN0clppbGx2TjB0RkpKOUxuSTJyNUc0MUY2SjArZTZk?=
 =?utf-8?B?a3RtUWRKcXRsSHVTMC9BUVRRZ1FCY291ZWpzNjVDc2FhVXpTR0d5VWdhVUJZ?=
 =?utf-8?B?eDlkdE5XcDlGVFNpanZDL3dsRlh6MFRTL3ZWU1NsSUNlVmh1cytLU0EycjJC?=
 =?utf-8?B?TVhDYURsR1c2cVhHakRybHNmd21vQUI4WXFJUVM5TGhDaWR5NzlnWHpGSVBx?=
 =?utf-8?B?UnFPWms1alhOTDd1UlNrWGJ3cG0vSStWbWVJNmsvWk9QS1pFMUxCT2RibW03?=
 =?utf-8?B?NXJvSGVzSTNDWm8raG1nbWRxdFRacUNLcW9tOW44a2xacTBBeUxqU2hFRDdW?=
 =?utf-8?B?SzhKWjdFSzVqTEF6RHdhMDZYbkliTmZ0N09zVkdqTHp0M283UXMzU1VIR25U?=
 =?utf-8?B?ZFR1MlBJZTE0TW8yNEdrS212MXZnVzZVdDlRalRWdnAxblc1ZFF1WEdOUTNY?=
 =?utf-8?B?T3l1ZFpGKytudEVNZURSaEozajc0eUpTWjdtUmhRcm9oK3pCY0ZGTkpWNkRP?=
 =?utf-8?B?MG5KOE1TQjQrWmU4aEdsNWhHUHMrUnh1RzdDTXQyeVU3clZpWlY4b0NFcWtw?=
 =?utf-8?B?b3pWTCs1Vk1mdmZybnNOL3VTVGRiWk5KRVN0RGVpQWI0S0dFODdyTjA1aW4y?=
 =?utf-8?B?Ym1sTytqWUJpbEdVOXk2VlFoVG5TRzNrbmFFTVo4UWIrRFZkTTFFNkVUZVE0?=
 =?utf-8?Q?DUn0Elw2FO4swUv3nLDS0KLzd3e6ljruF7b1Z5X?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 859cc422-7635-4c06-04d0-08d8ef41a3d0
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2021 03:54:07.5287
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n4qo/5/c1SO0OvHgA8ngSCJmmABW61ItRX+fYDisYersEx3cy8BUyw52e6LEUeHU+nhW7eUnKbA9zGfCd4RfzlnqM/Rz1zR2lIc+/D75xSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4774
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103250026
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9933 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 adultscore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103250026
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 16 Mar 2021 20:26:48 -0700, Bart Van Assche wrote:

> All sbitmap code uses implied preemption protection to update
> sb->alloc_hint except sbitmap_put(). Using implied preemption protection
> is safe since the value of sb->alloc_hint only affects performance of
> sbitmap allocations but not their correctness. Change this_cpu_ptr() in
> sbitmap_put() into raw_cpu_ptr() to suppress the following kernel warning
> that appears with preemption debugging enabled (CONFIG_DEBUG_PREEMPT):
> 
> [...]

Applied to 5.13/scsi-queue, thanks!

[1/1] sbitmap: Silence a debug kernel warning triggered by sbitmap_put()
      https://git.kernel.org/mkp/scsi/c/035e9f471691

-- 
Martin K. Petersen	Oracle Linux Engineering
