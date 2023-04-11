Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C29BC7619A
	for <linux-block@archiver.kernel.org>; Tue, 11 Apr 2023 20:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjDKUzT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Apr 2023 16:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjDKUzS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Apr 2023 16:55:18 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB81E18E
        for <linux-block@vger.kernel.org>; Tue, 11 Apr 2023 13:55:16 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33BEx69Y005453;
        Tue, 11 Apr 2023 20:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=1TjZkMlphF8xodysitIGajCufJb1p9OwIiQYcK1F3pM=;
 b=DTwoeo+4VAahP2Puqs7DJJVEfEKoMLQbutjM5b4CtoFuiWsci/4eTLDaGAL4Js9N+lH+
 0EmztcS4fPAdHy9QnwYVt4wSJCL1Q6Mc5zptwWWqagKEAWf8wgCRZO1X35N5bnLGTZiv
 Q3Lh1m0je8BfQBUgRy1gBeBM/H7pRfYGGkENxf9vp/aTHibckV4JhiH86DJpMFl0XFf+
 skopH8jQsrdpQlEv+LD0pLRDaMgmiAVYYcmFHJkSjcFVy9nHevCrWx+QSJntkeYPhIDw
 gtP0KJObL3jadAv9RhKrIXJOoLVNErglq80J1qEV7iTzJDSNOlI6gI/NsvpE9FaRTxyC jw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0e7eh1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Apr 2023 20:55:09 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33BJKXF6008056;
        Tue, 11 Apr 2023 20:55:08 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3puwc4s974-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Apr 2023 20:55:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aOAicWapAYZiKLBxNIjRGSZjN/J2+cL3srRO2VCiBHKTFsUaDVDsaCQGuHl7G/5H8r8LH4qhC2XyJXhHnei6cLEerd9rXkpiJb3R2DT/qrwn9TKqluSOTf2EHtzgH+EGiNzcAuViMhWzZVYlhjOU4EdEnB0B+7FjVyHeuSEpMT5aU7gbjy93Nf8+q/bD0U2supmL2+VsNzLatEOcl9y9gPwWeR3denElwl3As67GV19DcfiTbn7iLrL+iLZY1NYeEsR/fND0RsSpicU8ANiKZlxMAo0w4i1UUyMyVUv9PrWdpdgyvrMdY1P57PbaN2QPbFCcHeYoOlIui3Z9V4iQiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TjZkMlphF8xodysitIGajCufJb1p9OwIiQYcK1F3pM=;
 b=B5SNql2P5x9m1OVceSpgFw6RXTnGYAArYgfZEKepvIocybabg30tkfv2dKVp+1ZUvjOkSl6g2dtFVgEML4GYQHYJ0Qx472jAm361NScRcsKRmFMB6QPJBpHpT66KU0PHJL/d/vI08AUBFNd3JlahechvxNS3NQM0HGcCECQKtBmbHezotaWX0uoowj+lYa3Cqipb0XD3I2QkW0l0QrXcXCk6YNa4YDoYZsPOHOYwmTqyGwip17ZuWXOvf5eqlkHaEu/FsAXlfpyqtz6Pw/MgAbP9bPNpSkdkWCDB33D5PHypJjjUPnYSu1M7ns4BGJaqxMfaHb4Kf37f158XFrFVAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TjZkMlphF8xodysitIGajCufJb1p9OwIiQYcK1F3pM=;
 b=s1b1bFf81bRqtN0nQzvWlQecAkaDMJPvV+F0956TXo0mcd+K1bNB6C5bFMmRnIBwmoH/SlHdkq6NbD24l0DmtG49ALnHkiwPxwUKYhPHMGKlo63pXIxur/huWh53S9GKdbigX1OTnGnoBJHGjjcjRhiMVGnmdWTX8RzWzfoIA58=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by CO1PR10MB4482.namprd10.prod.outlook.com (2603:10b6:303:99::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Tue, 11 Apr
 2023 20:55:07 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::e206:6854:c7ed:225c]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::e206:6854:c7ed:225c%6]) with mapi id 15.20.6277.038; Tue, 11 Apr 2023
 20:55:07 +0000
Message-ID: <c7e8f14a-6c1f-4e65-f72e-6fb92244f09c@oracle.com>
Date:   Tue, 11 Apr 2023 13:55:03 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: blktests nvme/039 failure
Content-Language: en-US
To:     Shin'ichiro Kawasaki <shinichiro@fastmail.com>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <5vnpdeocos6k4nmh6ewh7ltqz7b6wuemzcmqflfkybejssewkh@edtqm3t4w3zv>
 <76983b72-b954-5865-1b34-c88161a7dec9@oracle.com>
 <acu2ak5fwyjnsino5i4ilaeh3xawlkygbxwjjm5tu3ntzxmgbh@zawuclpnlwiu>
From:   alan.adamson@oracle.com
In-Reply-To: <acu2ak5fwyjnsino5i4ilaeh3xawlkygbxwjjm5tu3ntzxmgbh@zawuclpnlwiu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR06CA0050.namprd06.prod.outlook.com
 (2603:10b6:5:54::27) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|CO1PR10MB4482:EE_
X-MS-Office365-Filtering-Correlation-Id: bbabbb81-aecb-48ec-5d59-08db3acf07ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i769QyFViBPiuA56uw4Jq+fhm8QjsuWGa6lAqzpl4fBDMoNUyAWFfTy1CBiVl049zei9qRafKX2ir6ojKP6Urd+6XCACIsS2+eg/qTFS1iutbdW7s4SXIb+G3+u5N07f/PEzwBtgqn+KEp8fZ6gNiYYBbkMW8F5lWnLJq9QYC/uDt8MDd4MJVOZOfMacuzCU2SJA0mVB20c/5kv33j6IsUn8hJXPH6IDijVls9V6qtYZbS9xkYMUouWpiaIS6VF4jGZ2igy8JALgvIT6BSA4IQFOuJTpm/UDh2OQnM3fiPM7Sx3l0LjL2MsxISC0A83k5xNfdDkaafM3g6IRIOtyasdyw+HW0SwWTXd2lAxnlhe6cS9UuycVc411xJX7x/Kb7N9c2pYi4I7JuZ4SGjeEf4MFADFZYRC3OyoLE+qFR7eGxLTI0l8QReEImVW1KvmDG5g4DZkY4Dxexru+Qn7/ra6i4QVk2btyDZWUErv4lm7AxOwcvvQ1axUaHLEi8oNGY4iNRNNW4xUHXF/BIqBuyhbGNFQUeDriPtMuQZBeut4lLmV5h8FdNdooD7hz6Kdo72KgBsEaZfpU8DJtV5X0s8gC8qwqySyEvE/Tf2PpfPCkP6APMbhdKquGBJd+l6uT
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(136003)(39860400002)(376002)(366004)(451199021)(478600001)(53546011)(26005)(316002)(9686003)(6506007)(186003)(2906002)(5660300002)(4326008)(66946007)(8676002)(6916009)(6666004)(66476007)(6486002)(41300700001)(8936002)(66556008)(31696002)(83380400001)(86362001)(36756003)(6512007)(2616005)(38100700002)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXhyTzVxdEdPaFI3OTJNRDJtNkRLMGVMSVVJNUxHZTl5YlNhOEwzeGNSc3ov?=
 =?utf-8?B?YU9qMitQOVZ1am40NXBGUFlHbndhdFV3V242MVd5RE04Z09KRmJqWnNkMXF0?=
 =?utf-8?B?dDk1QlJ2Rjc0aTlUY2FTbnZFQVkyYzFQajRETjZwMU1QeGpZdllUT3czQThH?=
 =?utf-8?B?Zy9GMG9LRmd4ZENqa05Qd3lvbTJ3NW1zY2NIcWdFMlpVREJjTjFyeW96MThW?=
 =?utf-8?B?c1c0SEV0YWxXWjkzdEVYSXdTcDZpVzlCZC9ndmkwRlhMdTRZMTd6R0lkWlBm?=
 =?utf-8?B?R2lLSk52d1RKTlgzbDZYWGpFMDJwQ0tqem5lV3NRN1lkeU5UTUFTTEFwaHFx?=
 =?utf-8?B?Q0wwKzR2OWF0N0p3VHVYWE9IU09zUGF2MDJrV203Y1BvUWM5bnROc0lnWWMy?=
 =?utf-8?B?dW1PMEpWOElXNjk4MVlyQTNlTlpkYjlRYzRNZDllOGRxQ0x3UzV5c2FIWnFo?=
 =?utf-8?B?MWhreVFITVlqTlZLbVAwQUZUNlg0MVM3SEVmditsMkVQaWJRQngyYXV0aklE?=
 =?utf-8?B?cVBXQ01xSEQ2a0Z5TGJnQ0pHOGJQV1k0akpsVWN3MDlWRzhFSGFpTzhiNzJw?=
 =?utf-8?B?OGlTV3NBQXJDbzVGbHNaemRDeVNPd0ppN2pEdk1jUjlXSDdHc0pqTDRzZjlF?=
 =?utf-8?B?T0ZlRzdqL3JMQUVYVGg1MkJCU0twd3R1bERZMGFNSVVQMkFvS0RNbFU2Y0Vq?=
 =?utf-8?B?QjhhQXdQUG1NcTJzVWJZRFVEVGFDZUc0akFhTTJDMmJBRlQ4U2FrMDRNRzRr?=
 =?utf-8?B?YytGYWV3YlRKMHcvVlgybGp6USt2V1hhTXJSK3NKc0t1TEJmNkFtK1ZEVURC?=
 =?utf-8?B?VklkeGU5YW9yTm9NVVNhazUwdXY4cGtDWEhnN0ViK0ZNbDAwSGZpdU9aajl5?=
 =?utf-8?B?Qk1xYmVRUnpIUzRqWG43K1oxZEVKU0FBSzNsVDBWSTVZU2JOUjNObkpVTTd5?=
 =?utf-8?B?ZkdDYkxmcGtWaDFNZ2FIYlJTTkJjOGRoaWUrSW8vM2FMRys3RzFFcmxnRlIy?=
 =?utf-8?B?TkR1MURqQXFvQ2pnb09IbFlNWDF3TWsxUGxEUGtXRW9YZ242Wm50Q3g3d2d5?=
 =?utf-8?B?c2NwRGluU0FsbzZOdzhkSTN3amNiV2ZDby9IRTNFY0RYbFY4Z0RkRFl5d0VZ?=
 =?utf-8?B?ZnRRUDA3OXhOc1RjcVpObWlEZ29raFJxOVpqaWVsb3o0dTM3M0svT1A0WmNS?=
 =?utf-8?B?eVB5bUlVVTkvMUFxMmcrTzgvVnRHYnFvdURGUi9XZVVvUkpNbVUvSGNVRnIv?=
 =?utf-8?B?cUUvVlg3alJuVUl0TFNOaHhZMTFuRzhqMFdOZnJ2WWIzczdEQ0dCdXdQNStO?=
 =?utf-8?B?dmM2aUhySmUzemlzTjNyMXRFbkdqSThIR3IxKzNJWk5WeHRRRDB3YWpQVkNr?=
 =?utf-8?B?MUJKai9TRklkS05VcWtlamQ0T2ZzWnd6V0tPOFpIZ1lDKzVxeFJ6dm4vTDFo?=
 =?utf-8?B?Vjk1YjQ4bmk2RThlSFlYQ2kvb0N5RmErc21RNXVSaDVuckZvTzdEYmFOZ0FS?=
 =?utf-8?B?cmpOTUxXMUV1WDdzV3VHRG41Mk9INWM3OXorck5MQ1JvSEcvVjdiaWtKM3FD?=
 =?utf-8?B?WFVmbVFxd3dKWk5vSk5GaEMrQVBSTzV2aVV0Y2xXZTA0dTFFOEdVbUFKZm41?=
 =?utf-8?B?cmJHN3VHM284S3l1SEJFSGVYdmcxdm9YWXF3V2pwTmM2UWFmWW9xUC9rRHR3?=
 =?utf-8?B?UHhyYld3WFpWRlBqQWJHRlFmZkh4TGI5TGtiNXoyZ3ZKWndncmhDYlZIUWtl?=
 =?utf-8?B?QnpINVJXRUd4emZYOE90NkpHM21uUTdVZ2RNajJJVXYyZTNmaDdoK1hzaGdB?=
 =?utf-8?B?YjJqUkpLM0V2T2VqaG82RnRtWDBNY2w4Wm9FR2cyUmQrZUwzMDY0WkpMYXFx?=
 =?utf-8?B?R3hyL2ZuNmVpMXppb0piZnRJRzlWa0lVZlYxWW8xUDljc1JEQ0pvMG1NSkVD?=
 =?utf-8?B?QUhyN3VBLzErV0VYR3BZNkFPTFBtZDVJMndYWUZLeVh0WTFlYUFLeEdmeWdY?=
 =?utf-8?B?QUNnZGRFTjhoek40TXh1QUN6eVcvN3JiZjB2MlBkWGE2UkJwSjZJQjduQ2ls?=
 =?utf-8?B?SXR2S3o5bmdUNzBLWUpkN2c0OUFTOHBRWEp3ZmhoOTlZcHhjb1FFOTBDZUIr?=
 =?utf-8?Q?fup7iTXN4AJIEPC1ITmPgIhuR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Qk73mzgIkBYSHiexmfKac21tVWmva8+gnvalGdryy46UU358deG/x7WCgq30/NqRSZCA9q3tqSOz+SMEjxjZkrjyZxtojMN3fFBnifoP1LFaZz/eS4E5UmuBjVd0N5yeyGLbeiyBS7XrLwr25+cyc4oqz9Oh04OqijPTPk8pUnEiT2naVbuHB/ApABa7cKB0wtbydaTkInFrHFB8FGxz0NK0GMonL2mjDtbrRlb54pFWzmhh+DsziHHZJ2DlappYxHBNe+Au1jIaCiSafuG1WXdGj9VyAlpbSdTlNH4f+hii758xM+Cut3uSE7hT1bn0VIwcFgxqWW3i6sgI5xc9ZLj+iY+isfTCZJwWsxgPGug1oY5g7Zku1xKWhvr8rCBe4T299Zd+3Q7w69pbKcSfmkuOoOHux+dj9GsZmeQYku7yrL8WH+IAKLnJnwQUQoXjpfYpO5JZ9iNC6TDnLwzpCiSLRwUG1fnx7lXF8b66Tksh1YZQbDwpkQhwcO4cr4t9azcGyigeZdGOp9MexPj1Jm4wdE+NqNVW0RREylKRO/T5G7yFqoP/Ha2XLNGfYIyIc5l2KfJ8p5Ypl0Fb76xaZ4hjSUxLdD0dg9ZbvtOh15TiXCfR+YgKW+jQaz9lRkb1xTMLaLwEms1Mv4AAAfBJgNwyCK7Qz2jAab4eBXM7NmWkQE9sO0nQfeR4snfqL8no6wae6SLYqgUvJiipQx+RkhQAQbKEoLjjpa5DEIdguA7ShHb/z/LSCrAeXoBby8vikEfh+fLswHhSPNrkIba4da5l/p5BCaO3TReULQFUaZ8TgQ+amt18VHxZkCDOmirsE6jczGdPQgurzTfgXrzqKT07y8ve9uBfLq2z2XD0kUU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbabbb81-aecb-48ec-5d59-08db3acf07ea
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2023 20:55:07.0618
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5oqDH8yOJ0HxMPLnloRKbxEW0OGxMtiOGqjns/KUqHXh8G0olGNpsXt3P/sLZObNaq6cSJmFLZZpVtx8/6KONA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4482
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-11_14,2023-04-11_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304110188
X-Proofpoint-ORIG-GUID: IKL1DDgFap3DAZlR0oVHBn53Hk75FTeX
X-Proofpoint-GUID: IKL1DDgFap3DAZlR0oVHBn53Hk75FTeX
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 4/10/23 6:27 PM, Shin'ichiro Kawasaki wrote:
> On Apr 10, 2023 / 16:06, alan.adamson@oracle.com wrote:
> [...]
>> I've been able to reproduce it.  The sleep .1 helps but doesn't eliminate
>> the issue.  I did notice whenever there was a failure, there was also a
>> "blk_print_req_error: 2 callbacks suppressed" in the log which would break
>> the parsing the test needs to do.
> Ah, I see. The error messages were no printed because pr_err_ratelimited()
> suppressed them. AFAIK, there is no way to disable or relax the rate limit from
> userland. I think sleep for 5 = DEFAULT_RATE_LIMIT seconds at the beginning of
> the test will ensure the error message printed. It will also avoid the "x
> callbacks suppressed" messages.
>
> With the change below, I observe no failure on my system.
>
> diff --git a/tests/nvme/039 b/tests/nvme/039
> index 11d6d24..5d76297 100755
> --- a/tests/nvme/039
> +++ b/tests/nvme/039
> @@ -139,6 +139,9 @@ test_device() {
>   
>   	_nvme_err_inject_setup "${ns_dev}" "${ctrl_dev}"
>   
> +	# wait DEFAULT_RATELIMIT_INTERVAL=5 seconds to ensure errors are printed
> +	sleep 5
> +
>   	inject_unrec_read_on_read "${ns_dev}"
>   	inject_invalid_status_on_read "${ns_dev}"
>   	inject_write_fault_on_write "${ns_dev}"
>
Looks good.  I tested it with my environment.  When we get the passthru 
logging in,  I'll be adding more tests here, but I'll have to do another 
sleep 5.

Alan

