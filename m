Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75A5CC433EF
	for <linux-block@archiver.kernel.org>; Mon,  2 May 2022 18:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbiEBS5X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 2 May 2022 14:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbiEBS5W (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 2 May 2022 14:57:22 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73356322
        for <linux-block@vger.kernel.org>; Mon,  2 May 2022 11:53:49 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 242IcMu3013665;
        Mon, 2 May 2022 18:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=PTN6fykLQ+no0G/zKcWpg4A98sb9ojeO6R7188bSF10=;
 b=wzqXudPtnNRIuoCFbjKYMEKwAhc8A1lFXaO/S4L4fks7YchUluCV/BvGjLpop3/W80R+
 MoiJwmkfrlCZTjrCccc5C5RKrWgRtlcDCqhTAbwgVhNK5VNfQHvBjx4Ci5CVCxW1JnjX
 X/zlgafu9GybnUts0BoawpLax+ThC3Acd60u0xHf6zieWCJHhBbh9Wt1QL6sohWCzqr/
 ZRsrFi4gDFWTV4SrRTGMw5qkp6Z54W4ASQMx77gjWTR4A32Nm5XcGyxM+SCAKneG3Td8
 fswhC9cwuKCFhav+DrxUmuMZ2KLfedKmpus5q+Yet6qtDeiHV4K66ZPh4UQZNBA/ZCJV Sw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3frvqsc2qx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 May 2022 18:53:41 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 242IoOwP022927;
        Mon, 2 May 2022 18:53:40 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2046.outbound.protection.outlook.com [104.47.73.46])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fruj8ad2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 May 2022 18:53:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Aa5oop9cHRwY2nOSrVqSRIlU3iHG8gxk7Hhc3FyTT2uKPjI54WqvaT/nwa+LeLF4DZiFaiPPqUZ8XMonhuY5LjCWJMt5QPtXuFh3MAjEfR16ZqeRMH0xelSStUdpivs/98qLRYN+62o9jXbJf9JmpnOARSe7YPjvRx7xjH1rGDvfOpc/JqpWbyNmR7NR3HESLkwI9Qqsi/JGgDsq3SiGoUYoCsQ2TGfF3NYiJutxcqr+vCRu5eOpjFU8CW2/RgBAZdm4XGEKyjIR67oz4Hfxe7E46WcbSFScd31R5oK3R6fDrL3y053YCVCrFa7LN0TfjnGIW643F3jVxiYFzHWPhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PTN6fykLQ+no0G/zKcWpg4A98sb9ojeO6R7188bSF10=;
 b=mUaTbvKA3ZlPS7pQoAVbMOn595vMGN/LZIl3jEzo74g1XwxSo9NIvsTs1dqsKusrY7t0suMUKxjbezajIOYBV8XdU2tdN/8tOQ3A7iQUH3nu9NKqGvmtBDEx+mV7DhKgkHPCy5pi/ukxpq0rQTUK3frxoWaohKkW5yi1MnlauleH24wUaX9BFt5ziYnA9h23VrMJ/c+g6jJXysEMKk/53ozHkRxz6V+VckE0QfFmXFbhXeJsaQwyqO8JX7GS837RrleQMKU8qnJABh9LTyBZoTR6WIc2+4Q5adfUAcbQFlm85CxUj+jn0WGPZUTYHJSptMINyFa1gwKm2oPkRScXhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PTN6fykLQ+no0G/zKcWpg4A98sb9ojeO6R7188bSF10=;
 b=MfuJOpkVSDBnWC+ChT+2Dvq5W6X5QMjpughdvdx2+BiSdagzv+hq2Sy/ZIOLIAw2Yw5rH/dO3G43ln1tiOK9tjXPMCiKBCZ2USVpVtZpZA9G0sN/4zEBvB9KBhUmyfZG8xIewliKnADoFSfjP+Ja5KBI6AShHlbK5M3jW14wi1Y=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB5706.namprd10.prod.outlook.com (2603:10b6:510:148::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Mon, 2 May
 2022 18:53:39 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%9]) with mapi id 15.20.5186.028; Mon, 2 May 2022
 18:53:38 +0000
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Hannes Reinecke <hare@suse.de>, Omar Sandoval <osandov@fb.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "Khazhismel Kumykov" <khazhy@google.com>
Subject: Re: [LSF/MM/BPF TOPIC] eBFP for block devices
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1h767epmx.fsf@ca-mkp.ca.oracle.com>
References: <5276e9fa-a253-6195-e697-60b4ff6e9bc4@suse.de>
        <87y1zjq14c.fsf@collabora.com>
Date:   Mon, 02 May 2022 14:53:36 -0400
In-Reply-To: <87y1zjq14c.fsf@collabora.com> (Gabriel Krisman Bertazi's message
        of "Mon, 02 May 2022 13:45:55 -0400")
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0077.namprd13.prod.outlook.com
 (2603:10b6:806:23::22) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8de6aba8-fbdc-43c7-e212-08da2c6d118f
X-MS-TrafficTypeDiagnostic: PH0PR10MB5706:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB57061CB7B84DF8C3553F83938EC19@PH0PR10MB5706.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S5CZc2LM+gjdisnjcD8WQEWEamJt9cwMM3+Vhnpj1kINpw+eJ2XB55YaOAbtH8C3nca9nwTaiJ0N83QGb3wcveZ6nHiTcbXM+fJ63yPYC/O7TF1VsAaxdyr6l9JgCATod/DhDdur8HgikbV4cQxq3oHVziiyKN+9JpwlX7oMT0maqPjBYh7rDj96ipxTWqqmtvf5H6NYkWdGK4dFs15LmbJQxtVsmyk0Bco3pg6Nxss548SpbomFH31zcM3iurJ7dpoG+cGtJ7waOTPntIG0RxJFOB88qLqLLIzJX5f8jE12e9E0F/Wq4XhIZdGj+rRYRhypK6M5Yo0YFQtK5YL0R0vjJK6zaoHywxRRfZx32j4ByS7/0aSAAbywMTpWQhxlWhSlQMwO2PDTWPa+MCEcGhP57C/9BvXV4oQ8e7OcNuukMCLbUT2tiFUQWV7zi5TniAQ7lNfQvCHQPLhY82lPOtmH2XimPRehfMckJKM2Ng24IMYAYFDVm9RUiU+gLyvS/bJnim3BsOcxSofh8kRaCt3o42SJ+FOnuc9A22CNp0ySTCd+WwVYj1taaglr5MZSDeDlaoqyk3v0vhL95+DqM4UtWQ9qP9+QJ0yEs1yQpf7UtdKyXxJnyGeZcl6Tq4DfwmLcpYJ9OTl8Xq6LuvjNvp0TSW8a2qyc/eGWKTO5LBMCvFq2fjEf7RnLvbykG+oDhyJ/GBdL2ER0mH7dFdNX0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(38100700002)(86362001)(186003)(5660300002)(508600001)(4744005)(36916002)(8936002)(26005)(6506007)(4326008)(6512007)(52116002)(8676002)(2906002)(54906003)(316002)(83380400001)(6486002)(6916009)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WOb1m1M9sKuGuPfr2i0edsfSw+rBwZy/brN3cjSPR7hQs4TUq4duHuevQ+F6?=
 =?us-ascii?Q?Y9n/svXMOdqndouJirR4iqSlnTCcRtjuPJPQzJdPVu2HUeh3+JGgOlPnWuXR?=
 =?us-ascii?Q?UXM5861xhhsI0dk+D/cE2zaYAa9yu3djJWqbqJP+mR7C59colhuw9WxiVzMQ?=
 =?us-ascii?Q?KSKGiA7NojopZFuTRj9EN9CjjUHVJ2tpVeFsr74T5+4SOfkluJJKVSyQUsk5?=
 =?us-ascii?Q?yMQl71vPwRDbcFr8F66gVujK5ZR7ycWY8TdJqCd+ilXV92Wui6k+92QznJ1e?=
 =?us-ascii?Q?dpRpXafwQYIwwujEpBYRhC6Cp9pNDp/SyLTigYN2gMap6rykM/6KdxIdBUgy?=
 =?us-ascii?Q?AkLnVkUpvMpCtLa/CNxJsORh22LctkfMgBWLcldJ7bcUhbU6LtGt1Qsl9S41?=
 =?us-ascii?Q?dHTcyFQNCvNBIkMfcN4FRfBPhXD9ABI2Ng4OB7mDxTOP3oRmJDY7dP3IlQNH?=
 =?us-ascii?Q?cleJJdyXv5uUx3ZYGWEABYk6jPKA3Nwryl4sI/D1LcgopxbE36GjWzbMj0zK?=
 =?us-ascii?Q?DAWFR/ACmQ7hdlC7Tqr+MpWxepSRKdP20mXB8NBeyoMQTEtn97BoXbAaWNTX?=
 =?us-ascii?Q?bUDk14Lgk+wjqf6TnO9bl3YkE/2rN3bzKtlvMNQinEmlZadRWUCC41XaUNrd?=
 =?us-ascii?Q?PvP6RDdGmOwsLmYLo81UHjrGwMTDgAs0k5oi3y82l2EYSKna//SFJzhNJVFD?=
 =?us-ascii?Q?2zZdu4PzGnIwnD/Di5swtOkN+y533OxjZdwXXUlJw+1V1+BcVzRJuSoCGuqw?=
 =?us-ascii?Q?L1vrT5uROct95blcR+0iTSQLLtPMyHnBHoa30e8bVyJKe60D0zf646RpJ9UD?=
 =?us-ascii?Q?idPu9cDxmqnOoJu9Fkoepy4WtMBTTXBCRk2qakO/V94vz66FP9fC/eF+O6W2?=
 =?us-ascii?Q?4ynb8buZHZqGBZyv/UOZ+8oMOLN0eXxAPbB10kpu+q/UCL3X8cyMqvHF833K?=
 =?us-ascii?Q?PGvjBJtvHx6gISkqh8pN9o/690BVdRcq6WX0Fj25iZd4uk94T8+MxNghi7C3?=
 =?us-ascii?Q?9i7mjAkKOOhqN8iaVmn2Qs+bPu842fH12HbZbwdEMWQXwdhkT5dB3I/d8TEy?=
 =?us-ascii?Q?z50/T8P351JZv0BM3UnvCYfny0K1roJOf7toYctXfhvQHWu9A0GNIt9tm2O/?=
 =?us-ascii?Q?C/5l/BEOOd/rz758kXdIfZFVFC7QCYSnUCbjdFO66ZV342d97QHZ+RGwXMLt?=
 =?us-ascii?Q?Luju7K4k/djuFDRpZvY85VEJLRop1+dxNK3uzsKfO/KPW156n1AJrJZjgfEF?=
 =?us-ascii?Q?qJjFR21+YWZegQUYn269o4Srjsik9AvPD/G9PpyJ6dt2uafqzhORNTf4SJLD?=
 =?us-ascii?Q?U6ySfyABCCTZ+4h7gGmNRKY1YU0N0Uy2IyTR5FaAMbuhA4HrE7kkwkERayJ4?=
 =?us-ascii?Q?0RomzwG7FqS4bsCnss2z0EV17OiMaurD8OwhepP5MuTi/Yq3ErW6Mx7b/Z4O?=
 =?us-ascii?Q?zxQRWu+i4cJwsEKCWKu0LDCe51v0bKoilyROuuZYny6AsvA6gq0bD0yyFi3S?=
 =?us-ascii?Q?zLb+mar/ypSsN4wAts24SNemYNC9Bf7wj3TRiouR8LEtfXt3XjaM4irYOGoJ?=
 =?us-ascii?Q?noiLhAPMOKxwFnTxC9uN6CAOYSrHGauGwbDZY41Z8BWcDkGf2TcIxve7nMgV?=
 =?us-ascii?Q?2qC8J8Miev3OhP74rdWYNG+K3lWUTKcba+TRVpf8tXSjxnBMw4XTnTQY+J35?=
 =?us-ascii?Q?QQ2uWioxqxDHTR3JxoN8p7xPfGV4Izi0uFaVBX2OnOfUQePXw6gUePuvGkFz?=
 =?us-ascii?Q?3b5bwRu1ofL2niaXQjG6C/kqNZ+6F8E=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de6aba8-fbdc-43c7-e212-08da2c6d118f
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2022 18:53:38.6858
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tHl13MS3xHMAUMRy6JX05Hnl7E6sH+9hMMPuOKPA2gVnK5N95VOzF9dWjlcPmNzjrv8Qo7snUvPUxmVJCWpTPK4rb2dmwKAOL/+Y/+Hl8k0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5706
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-05-02_05:2022-05-02,2022-05-02 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2205020140
X-Proofpoint-GUID: zQR9uPcxGuQm-3L7lePGrsYVN25-UbAV
X-Proofpoint-ORIG-GUID: zQR9uPcxGuQm-3L7lePGrsYVN25-UbAV
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Gabriel,

> Cc'ing Khazhy since Google might have some applications for this to
> filter IOs based on the blocks being accessed, in the context of
> safeguarding specific regions from accidental overwrites / application
> error.

We've been working in this area too. It possible to write BPF filters to
protect block ranges using should_fail_bio().

-- 
Martin K. Petersen	Oracle Linux Engineering
