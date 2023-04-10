Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23326C76196
	for <linux-block@archiver.kernel.org>; Mon, 10 Apr 2023 23:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjDJXHM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Apr 2023 19:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjDJXHL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Apr 2023 19:07:11 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B272100
        for <linux-block@vger.kernel.org>; Mon, 10 Apr 2023 16:07:10 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33AJU7Vn002835;
        Mon, 10 Apr 2023 23:07:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=ulNn6v596Rj0XLp7a5sQtOO6P26cH48W3rxaEc+5cS0=;
 b=vT8U82oPyTyjvv70A9iXux2QT04YKvJzNRAFeqclh6IKEZM83fafgAOtaU6yqUX72Yev
 5dwF5tJ2wKPqfmB6q97j6OQTniN0pSSexA+i3FZX+JPMb9CjddDEEw831LuTIgXEjyef
 QNqMl/Rus4Mr+2D5gakRZ1PP9gX5u/svJfoeo2tTEvkBOLdVQaI5AfZZacMn6VnSrD1O
 GGUDiBH9zQZAttTKOSP46S6FtSyUuQ6B/pXHsiGYeRY7uOMRoyp5j8OtZlyqdgz3EOkQ
 yrBbs4V/zkp/5zBXw42AKAa9jT3BFmVpgEEbWj64S4LrB/Nhfya2hJojMQovxZXJ+jLy MQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3pu0bwc1ag-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Apr 2023 23:06:59 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33ALq0xx038384;
        Mon, 10 Apr 2023 23:06:58 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3puw85qprr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Apr 2023 23:06:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDkHrOAPG8x6g4cj4POp/xpFr6hx2NkBE9W43eIXllfiHzMjdtiVdqGlHUWgKl28HVgANnpRdLJjK6wR2YYBU6vuSFQs3L0dx6tk7eiMAi+fC4KF6iY0rX6dZdmMJVqP3KoOHtQZIYzWFf1ufPSef7h5TFyMLJYrC83r0KBO6vpwadH4be737FmiFYLafuvtrIbpNY2oSov8l0Zrwlbi2I2z9QVHSGgoqVtZiG28DfnMxPaOW0wTAOemX0gm5GjUUkWsBxor0NyvHFDzYI/ToRrP/3cHa7AWQm37B1tG39RDUQaGUa3XtzKZlGgNBdFGc0z4WCX/UX+kBKEfDOyl3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ulNn6v596Rj0XLp7a5sQtOO6P26cH48W3rxaEc+5cS0=;
 b=Eezfgy8nSgtn9VHHk5hqROWQXwKSTy91cccvkF3Ti7lobhfuKTA7ShypJNcstZ+S50kkb+lHSMOaT30PXf3/6OakdbaVFMfBDazg0ooF0G3xO6b3XmmQKG08tj5LRspZaEKHAPvRd7JxGL9+6XWqCVS20SeeWeDL2e4jNgfIUhGGCjVJco/d1Ic3HIrSCNGyRbnc8eAvNGnXR9kxhST+AdW6nVpCo92bm1uGye4h/nFJS0DQYmBwcfY+8jjDNBqiZk5ZRLET6k6gu3PM8r+cZkK5bKAQMldOWSPAepwqvnaKpD+AFQc2zfFwRUb5x1qyKU/a5llxtKxM+vsyv4eYGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ulNn6v596Rj0XLp7a5sQtOO6P26cH48W3rxaEc+5cS0=;
 b=q5eAoJ2ibXDXq1/13h/d1y1O3llZ+UpXc0pouJRJEikiEC3hMcsysX6PvAErAGJSlOp+cwWaHL0WT296r9eHE6klr+YRHu5ubma+6TaoU3HgYrwHwmV5LJVccbrByMjT6sncLnAhb4zAdfOrbJjWr67cVNF39VOt+fnBHiTH7Hw=
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5)
 by SA1PR10MB5712.namprd10.prod.outlook.com (2603:10b6:806:23f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.38; Mon, 10 Apr
 2023 23:06:55 +0000
Received: from SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::e206:6854:c7ed:225c]) by SJ0PR10MB5550.namprd10.prod.outlook.com
 ([fe80::e206:6854:c7ed:225c%6]) with mapi id 15.20.6277.038; Mon, 10 Apr 2023
 23:06:55 +0000
Message-ID: <76983b72-b954-5865-1b34-c88161a7dec9@oracle.com>
Date:   Mon, 10 Apr 2023 16:06:50 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: blktests nvme/039 failure
Content-Language: en-US
To:     Shin'ichiro Kawasaki <shinichiro@fastmail.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <5vnpdeocos6k4nmh6ewh7ltqz7b6wuemzcmqflfkybejssewkh@edtqm3t4w3zv>
From:   alan.adamson@oracle.com
In-Reply-To: <5vnpdeocos6k4nmh6ewh7ltqz7b6wuemzcmqflfkybejssewkh@edtqm3t4w3zv>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR05CA0014.namprd05.prod.outlook.com
 (2603:10b6:805:de::27) To SJ0PR10MB5550.namprd10.prod.outlook.com
 (2603:10b6:a03:3d3::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5550:EE_|SA1PR10MB5712:EE_
X-MS-Office365-Filtering-Correlation-Id: 192ad978-b463-4e4c-89c1-08db3a18475f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LfdIplmEtpcDA3IYjTSdXy8IwhDJohdI7P2VRLnRkSohogBKPO3sJF3gm20GRDok009zw+YsiKYhYFaHj7GpTHPZlvmdl3hFcjrzpQtf+nNL1WtvPYnc2iPEsoeRP6n9FnyvgawJ3ghBvcODxkAV0NxlM3aawiXZoeJpSHv1ACen+ixbyQsg+MDs5nE1jiZx0wNpU16qdcd/o2D7NXYUhiYwMwIV7BqzrDCMQ6HBVH8Evwgpiv2E8W+jDtE3xQwQbuWhqosZ/9Dit0dkGW118pCyhIQtR5qzuSx7lRtRYx5NMD4fkq7oyJ6DXhH692k8we1Xy0w9pqn+P9ppy44F489YtawzR0MfKPsrimoGZhzbwKu0Rv1VE0cLEkkdf7Kn03kpv5buSjQNJkHjQhJfJENTNNhZnP6D+A3rcivudCD2r00VIrA98mVHHbkYrJNP+4V/F3sEKC06x4gnWbQEQEiYgW2Z4zASKbj5tafwHBvMrHsIMgMEWmAPbOzqp00g8TuQU0E1HoQjp2NcTAiyD9PRiY/96486YWwPX9azsHR+xlB2s6EN9Me0irBGRH6sb2kPSGfW+G20kt1EmU7614Tu4avx7KCrxA4nnRp50NAbTj3u0RGyaNwtXtAwhWV+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5550.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(396003)(366004)(39860400002)(136003)(451199021)(478600001)(6506007)(316002)(53546011)(9686003)(6512007)(26005)(186003)(6666004)(6486002)(2906002)(66556008)(66946007)(41300700001)(5660300002)(66476007)(8676002)(8936002)(38100700002)(31696002)(36756003)(83380400001)(2616005)(86362001)(31686004)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0Joa1NzWEN2RGhTVkh6MnFzbi9vQi9VZlhVRzZwM2dvQkdHRm8vNUFjQU5U?=
 =?utf-8?B?aVRHNTRpSFBpUWwwTE4rQkkrRUUzeXl0UWM5TXZ0UEtaNXhmK1ZrcDdTcFR6?=
 =?utf-8?B?MTJxK3F5RldaTWRGVmc5bEVhQTNwUllmN3M2VFk4MVZ5Q2o1a2d5N1E5YjhL?=
 =?utf-8?B?TUI2QU1tOFJJZjBVYUdQNTgxNlRJS1JXY3ZpNXlQd3NlTzNxY3RJS3MrSGRF?=
 =?utf-8?B?Zm1PSmtEYkd4c21mbWJPanE3MVNzam4va2p4T1FXNlVBU1htZkM2bmFobnlT?=
 =?utf-8?B?TUZZd21hbXRia3IyUEdYek1yWTZ3alhRZHV5NEJGVjB0ZHpnZXpBZFg5OFlz?=
 =?utf-8?B?amFNK0V4L0dCVFNxT3FFb0tXdmxhSk5sSE4rY3JnR0tXaXhYdHJkS2NwVWgy?=
 =?utf-8?B?UnRwMWpuTTNDSkR3OUp0ZGFMSy9iZUlkWTJLbHBuY00zNDVvY0lzdDU4b1hQ?=
 =?utf-8?B?YVlmQVpsV0ZET0c1aUpUR3dqaWNLZ1BnRUFlbVFRTmNTWXVhaFRZU3FCWG1n?=
 =?utf-8?B?K2FMU0p2bStNTnI3Z24vNk05Vi9ST20vd1Q4VG1FQU5JTnh0aS8vMHQ1cjR1?=
 =?utf-8?B?WHdreXhQY0c4UEFPQnRUZENVOE44aGdaRnNUd0tZSUV2OVFGQUh2akQ1azEr?=
 =?utf-8?B?Z0tSMWZvRVlUVVl6TXlSZjdGTk5NWXpnZmFJS2YrNWZQTERscUhFR25CUWt0?=
 =?utf-8?B?enFIY2N0aWpNSzF1OVNDUE9iMVUvTkJ6K1EwTnlFNXFBZXJnSFMxMHBSN3J0?=
 =?utf-8?B?d3VhYTExaFU0ZlJVd1VUdWNJOEZuSUxJMjYwKzBGU2tHVVErVTkvL3MzMlV5?=
 =?utf-8?B?c1o1c0cyVWdmbzdwQW13Z3hiWUFiZlh6VkhZR0FNL1QzMFBWZytadGV1REc3?=
 =?utf-8?B?VjBERmpIR3dEUlNka0NXb0craGhmV29IT2lmT1U4MVcySE9pNGNWRkl6Tzc5?=
 =?utf-8?B?N2s2TnliRTJWcHVDWGxlbW4ycTZGam1vT0JyS0tWRkRxYmU1RnE2ZThvQjRm?=
 =?utf-8?B?NHVMcXByRmRrNUxEdE0zUXp6SUFqRzZLbzZYNjJEL1pIZ0NTbzY0U0hHSjV5?=
 =?utf-8?B?N3lmM09TODYwK0ZTOGVJRHg3cUJ5ZVVSM3N5c0lJcjBvRFpheVR6U3BoZjdx?=
 =?utf-8?B?a09lNTBuV3FWTWVNZ1dFR3J4bG12ckx4S2ZrTXZaNFFkcHlrTlVWSFduVVp5?=
 =?utf-8?B?QjZ6cVF4U0ZsUzdCUXdXeVF0dytwY1VYMlA2OEpSOTNyNndOM3VHSkcrNnlJ?=
 =?utf-8?B?TjBKUXdoMDdSNUpTSmlnNkxobEhHdDFMUGtONFNaTmp4cDJEQVZ0V3pLOHJi?=
 =?utf-8?B?SUF5Y3YwVzZ4VFJMRk5Tb0M0MFhjQzdCQUtaS3ZBTE9pa2tqcHJ3WS9vQ2dK?=
 =?utf-8?B?a1M1NnlIKzB4WGErSWM0Y000K2pnR2pHMkpJdUsvTnQzQUdiK2NuUURLV3Va?=
 =?utf-8?B?NkRyeUg1ejR0RnlCcWRaMWEzOUVORXJ3TXRrNW1JeDllaDM5bDNSck5iTkUz?=
 =?utf-8?B?VmZHWGlSQVBPYXNMTVZFZ1dnRE9XeW9zN2ZHNENib1FrOERGYUQrbTROb3J0?=
 =?utf-8?B?b2FCSnI2TFYwd3psMnE3OE5mRXRBandMUWhyZERLUDg2VGh1R29lc2hwYzF6?=
 =?utf-8?B?WkRLZ04vSm9CVG9jWUw5a2FtWFY3d1RaVThzQ2ViOThKSkhvWXM1cUFqWXZj?=
 =?utf-8?B?VlpINE42NXhnNTVIaUdsNWhrZkFFeDl2dDJGRUQyL0Q2c0ZjM0xIL3kyd1Rr?=
 =?utf-8?B?c0h4T0xuRTZ0WlQ5RVFCd095SlF6RUpQWjQ4QXJ5Z1FOcDluOEhxVkQxSW9X?=
 =?utf-8?B?RXpLQkxkWnltYytDNnFJY3NvblZtdDJpWGV0RjZQaFVwLzFyNmExY1hYUE9C?=
 =?utf-8?B?cUVNSW1WMXhZYnFmcjlaLzZUOEpjL3J1TDg5VUlaNW1paDlpYUQ4bS9lSmJS?=
 =?utf-8?B?TXVNaGZlQ3NsUFk4aXAxZmxjSVZ2Nklkd3NFQndlQWhpakNYRHdidis4WWl5?=
 =?utf-8?B?anVUY0JqTVZxbEZKT2RVUldpNHZvWVAxNGRSU0RraUhxSC81andLRGV0U3l4?=
 =?utf-8?B?TWl0aGRrL1dpcWIvd3NyM29LejUrcHRiaitGOHdrUE9VQUkvbXZxTTd4OHp5?=
 =?utf-8?Q?m5uozrfJ0yNWr27mBj9cMcPJH?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OIzdxNsG5OUSKZ2ZXGB0a4xvvIYpI1YMFGrE7T/7gBSWcIloXEutMRv83+wv13MPPFs/NeNqVS8EBaXWdcoyVQTceqHmLhokCUzreJHHffiCNUueP1owgjk9xIcqAXawW8x+OmjZVvBzsysedfTdGqbSmTDHX5WWSbOJoJe9F5LCJrllXUWSQKQCrXyDem6f2fe7hHeBf/B274NQRldXtynRMJayiW+VvL2Q4wGoZjipJ1AU6i/0aK16o7YNVwFqw6JtF9Kj1CDMXi0zxaQlqN6xic7flQ2Xy3Cq6Ixzx70ri0pH2bjsxP6Cqdm9qWye6y+GntoHKTUiAZ4SkoI27VsErGkRA5ws0ofrKbwypcbzC8GKtkEU2emYi6UH3OFoSVDJoRQvBaGjVE1Zi9J5c0jTLzB2V42tmTmGq1ZyKCXIZXQhtbC35vzD34d+FHHVDqN02fs5TlgO7UNlet6jjgBgfVNjFcZPIs8sxEFRaB52+jXoT8GjYEBgIcDvR1bIAt7LQSVkdRnazOGLgAJct+A+1zWuEkqtPkhrXkdSgYKkmhowblioj+znKpLEnY7fnNJV89rZErKXJzx2cdwHGgqBdEyarCWJ6M8vHZBHN5cnichfZQ6n5FoTDSoF5kW4Limup3MVzehHeccZdhRixH5FI/Yip1CaBN1frD8rKotRsoAh6Ed7TY1Rs0y9s0Icysc//TEGrDlxPskSLslEFTmOJOlJPkZlqodK5EZ6euaCusZAO+hQEdEEPzSozMWKUHeMhoeW1csqxpTp9RZRRjjhab0c/6A0+iWF9E7AGOvPhb6UoqY8yGhCzWZwnn3vYSj1p/CvXEbxh5K/MzTDPhN3f5wBpHghk5+w3QOhhPA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 192ad978-b463-4e4c-89c1-08db3a18475f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5550.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2023 23:06:55.7336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b/CyRz4lo7dBuRLMVeGtRNLbrdGx+EmUOa8Bv81dPOESUV1HivT8joojlVeDI7EUbCzeEMkLjy1lNs+4WnZUcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5712
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-10_16,2023-04-06_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304100202
X-Proofpoint-ORIG-GUID: 0YPJhtd9yyXb_cECaQuGvFq7YfWxCtU2
X-Proofpoint-GUID: 0YPJhtd9yyXb_cECaQuGvFq7YfWxCtU2
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 4/10/23 4:49 AM, Shin'ichiro Kawasaki wrote:
> Hello Alan,
>
> I noticed that recently nvme/039 fails on my system occasionally (around 40%).
> The failure messages are as follows:
>
> nvme/039 => nvme0n1 (test error logging)                     [failed]
>      runtime  0.176s  ...  0.167s
>      --- tests/nvme/039.out      2023-04-06 10:11:07.925670528 +0900
>      +++ /home/shin/Blktests/blktests/results/nvme0n1/nvme/039.out.bad   2023-04-10 20:15:07.679538017 +0900
>      @@ -1,5 +1,2 @@
>       Running nvme/039
>      - Read(0x2) @ LBA 0, 1 blocks, Unrecovered Read Error (sct 0x2 / sc 0x81) DNR
>      - Read(0x2) @ LBA 0, 1 blocks, Unknown (sct 0x3 / sc 0x75) DNR
>      - Write(0x1) @ LBA 0, 1 blocks, Write Fault (sct 0x2 / sc 0x80) DNR
>       Test complete
>
> nvme/039 => nvme0n1 (test error logging)                     [failed]
>      runtime  0.167s  ...  0.199s
>      --- tests/nvme/039.out      2023-04-06 10:11:07.925670528 +0900
>      +++ /home/shin/Blktests/blktests/results/nvme0n1/nvme/039.out.bad   2023-04-10 20:15:09.114539650 +0900
>      @@ -1,5 +1,4 @@
>       Running nvme/039
>      - Read(0x2) @ LBA 0, 1 blocks, Unrecovered Read Error (sct 0x2 / sc 0x81) DNR
>        Read(0x2) @ LBA 0, 1 blocks, Unknown (sct 0x3 / sc 0x75) DNR
>        Write(0x1) @ LBA 0, 1 blocks, Write Fault (sct 0x2 / sc 0x80) DNR
>       Test complete
>
> It looks that expected error messages were not reported.
>
> I suspect that the time duration is too short between error injection enable
> and I/O to trigger the error. With the one line change below to add wait after
> the error injection enable, the failures disappear. Do you think such wait is
> the valid fix?
>
>   tests/nvme/rc | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/tests/nvme/rc b/tests/nvme/rc
> index 210a82a..7043c23 100644
> --- a/tests/nvme/rc
> +++ b/tests/nvme/rc
> @@ -652,6 +652,7 @@ _nvme_enable_err_inject()
>           echo "$4" > /sys/kernel/debug/"$1"/fault_inject/dont_retry
>           echo "$5" > /sys/kernel/debug/"$1"/fault_inject/status
>           echo "$6" > /sys/kernel/debug/"$1"/fault_inject/times
> +	sleep 0.1
>   }
>   
>   _nvme_disable_err_inject()

I've been able to reproduce it.  The sleep .1 helps but doesn't 
eliminate the issue.  I did notice whenever there was a failure, there 
was also a "blk_print_req_error: 2 callbacks suppressed" in the log 
which would break the parsing the test needs to do.


Alan


