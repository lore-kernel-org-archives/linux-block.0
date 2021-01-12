Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E867C433DB
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 17:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 525E423107
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 17:50:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731303AbhALRtn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jan 2021 12:49:43 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50484 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbhALRtn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jan 2021 12:49:43 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CHhqU4084670;
        Tue, 12 Jan 2021 17:48:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=LaYMYmFBazu6rgt78i7ijyWIA1QSrTdzkOJH9Vb/Gvs=;
 b=g8DO47JgwPZtGpzmpi1JwrGqpz3yynQyUaLEOTHDszxjjKtWzzALH41u+0M9SzzJaJmc
 KAkbYxIIcpR9v/ZsOd4ZOAr/ZvkVng7+vXwggSzDvNsTxvYuNGZCbbxPqYqTOU2LNYrR
 FmsDgh34GW5xwrbL9VHCuf5scUZOKAasplGH5UfdJ40EGCMuZ1/F/UeAr19g3ipTVAf6
 KfBONEnO4oLFlKjb+nx54j532gUvqO3xzV/6a3mVbt7yHXbneq7yxhkWO4akoktpfTyT
 zd5MmBa9bI0moxW4nG2spFzNt0TG1Q8JrO0+X3Vgnz7FaxBJ/vcphbzTqPssssqU5jS6 fQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 360kg1qmrp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 17:48:56 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CHk2ms048184;
        Tue, 12 Jan 2021 17:46:56 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by aserp3030.oracle.com with ESMTP id 360key5brr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 17:46:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LLisHdVISBNWE2Ch0mWxrgfJvX2IOrARpv8ILH74Q+7B2aygCROhoUUNY8uTaqBuvxhawOx/yF/amkk+nAdk92wNIouIpbY7XE1ASXF15docdIxsjPOm22TV78pwNKrkDyUqlq5hiZ4XwTeXqGxKZbCcjxSZLen6GiFhbn369hoBHcwyKDZw7pIegqBUTcC0+RTOXnx7voqC2GaA+JdTAUiVCc7up2Y1pMfRy340TFJj/or3UfHGeixv1wRd/EScG225uuXmfpmS9npLi0l4QZrFOjFKKmIifMVa/7+9oouKZNvyZGnWcBu1aYUgKMBLFeNHmcSPGXviDOVoQl06yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaYMYmFBazu6rgt78i7ijyWIA1QSrTdzkOJH9Vb/Gvs=;
 b=NFrgQMsl/DcfmQzG3ifq7hwuNydSeeBs+oiqCuzz+r3+ZHuE+ikC30l/V4xZ04evuVOKoL5PMrHVYGfHH5bzUNFVypUoptLJigavj8S0auhzGEvjWRm+YlaCDwuUGoS71zQJV2LDiI7VRwf83VbI3pD558GA+LOUvEGRDDXbQMCRCEQfcaENAoElQqxTxrfHU8QRI42fRQQYnTL9xhdwatkQtpSqUo6316D7WGZXEo3XgU6mLz6oJ8LkJpz47wW3eUoGtgA9aMrOnjqJOajewbgiTG+DYzyDwaR6R2uQ0zdSBGoiO0VUtaW/EQUkuV0B8C8hrYrWJQiFIBcHZjztTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LaYMYmFBazu6rgt78i7ijyWIA1QSrTdzkOJH9Vb/Gvs=;
 b=dP7SUR/NjBruLKF8Ai8PWg3T6hORPPyAlWwQGusb1fHQXwTL7NfmAw27mL2gNWKAKtUIGxO3BR+RlE/CyP7xxE2kEXMgzaI9BFHaJb/e1amPRDPlnxNdi0lWWFxg+kZ4yDqko9zsC2gc9UWFav0ptHH7D5PL69l+5cIUEW9ggjY=
Authentication-Results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4614.namprd10.prod.outlook.com (2603:10b6:510:42::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.10; Tue, 12 Jan
 2021 17:46:53 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::54f3:a8aa:a2cd:a3a4]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::54f3:a8aa:a2cd:a3a4%5]) with mapi id 15.20.3763.009; Tue, 12 Jan 2021
 17:46:52 +0000
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Feng Li <lifeng1519@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Li Feng <fengli@smartx.com>, Jens Axboe <axboe@kernel.dk>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] blk: avoid divide-by-zero with zero granularity
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1pn2a59u3.fsf@ca-mkp.ca.oracle.com>
References: <20210112152951.154024-1-fengli@smartx.com>
        <20210112155502.426331-1-fengli@smartx.com>
        <yq1v9c25bm1.fsf@ca-mkp.ca.oracle.com>
        <CAEK8JBALYE0_OzfhrppF38=dD7HKSn-U0ggPJTGgx5849Gfiiw@mail.gmail.com>
        <DM5PR0401MB3591FDAC44CD5665D6CEBDC39BAA0@DM5PR0401MB3591.namprd04.prod.outlook.com>
Date:   Tue, 12 Jan 2021 12:46:49 -0500
In-Reply-To: <DM5PR0401MB3591FDAC44CD5665D6CEBDC39BAA0@DM5PR0401MB3591.namprd04.prod.outlook.com>
        (Johannes Thumshirn's message of "Tue, 12 Jan 2021 17:36:01 +0000")
Content-Type: text/plain
X-Originating-IP: [138.3.200.58]
X-ClientProxiedBy: SN4PR0501CA0096.namprd05.prod.outlook.com
 (2603:10b6:803:22::34) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-mkp.ca.oracle.com (138.3.200.58) by SN4PR0501CA0096.namprd05.prod.outlook.com (2603:10b6:803:22::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.4 via Frontend Transport; Tue, 12 Jan 2021 17:46:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 78b0b1e2-d6bc-4eff-01be-08d8b7220bee
X-MS-TrafficTypeDiagnostic: PH0PR10MB4614:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB4614F8CD1F88EDC0A8BFF7E28EAA0@PH0PR10MB4614.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PskM3j634n4VRI7EiR1yz1tqgJgeAT0F/2xWhjuyDZEEMbxSITkBWOx+xpyLSwzzWl+nreyxDc9IIzPlPRVimPl80M8q+KF9uq9csMugKngF8OE1yhcR68KNY1HpEDUMDptxOWRwzN4jFrw/DLLjFaMKVz2GvUGkQCMKTdkvxj4kWORqtTG6eZQpymwIFjgw3xYKZE3tEMfGnfGAQ5o/TApS+cvVm6viotlKHl1i7xN12+dBiCTwi+tcVIXKGG7IjgTTDsNP4mM4GChFw/tv8Qm+9kAZVvElM17YqZDWXx7hlX1G2B0eSHzs1ClI34HE5P2uYzZJvejaE2gD2w46u1FWzfYY+mkWalwwN0f2SASKuFYZxr4kjZTSNfDI8H/WLAxN2T2nUiVr3UdE+IKevg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39840400004)(136003)(366004)(346002)(376002)(4744005)(5660300002)(26005)(54906003)(2906002)(956004)(8676002)(8936002)(86362001)(316002)(4326008)(52116002)(83380400001)(66556008)(66946007)(7696005)(66476007)(55016002)(16526019)(478600001)(186003)(6666004)(6916009)(36916002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?GLjuMiEBpsm++lbbog98EWxWWlSd8nd6zi4RvMC6cu4igO4UvtX/HXMGDUKe?=
 =?us-ascii?Q?00DN82VaKrd0GRsWhpZ30ZcbNAOEbYUXPnDO1sTlQeC2AcgwqWHiwe20xHCu?=
 =?us-ascii?Q?E3MUGwsbR2b80MtQi+s8YArUtcuGcqq31t/AMF644SsUbs16IQzUhzu9hEUY?=
 =?us-ascii?Q?Uhv6dFsaKXHswRYWMde4lTkKZmUpRbGDFCQgs9LJ5fAyzHvHEAPKprTX/6F7?=
 =?us-ascii?Q?QbRKIbxT/2VJPzUU2Rib3HVoYtJRPKdwSRUQPpWO2KpxHjSzcFZjT34Bf1y/?=
 =?us-ascii?Q?kjmc/9zuQTW4D8rvIJ1GsSMGVB4rVF8P3Y+oJmGistAmFiqLwF6MVQCLZrOV?=
 =?us-ascii?Q?RPTpxYKdJ2ptS7WaTmih22W8eeHIPFI2EqTKJwYftNpHHoTG8732dFIun+e7?=
 =?us-ascii?Q?OCdWrtIbXraARG72ePNzGhddYe/hUQV/WOPQI6mksIsipVKl6Dk75PsEz2JO?=
 =?us-ascii?Q?+U/Mo/VecJ9EdH8UVWH7m7WV+oztcVyD8xpncZd6jGP5Ts0qGf32QIx8cM0T?=
 =?us-ascii?Q?N2MUGRbSzzYGcqn5O5IYPMZxlG4o2B25tUsdcE70v1Iro1RkdLtDgYImQ0sO?=
 =?us-ascii?Q?S/3fTb2o69p2VSzNRljDELIz1qgzwxSLSKsUtIaEUe03zCnanZKrWocQOzoQ?=
 =?us-ascii?Q?bIm5mJi+dz16ajR08vL5Hh5tXvNjF8AwoSvIZX+PnRdwCUdFqd8U9qHHcucz?=
 =?us-ascii?Q?VnBMxnQAqcHk1hDpGnshcGQ7wN4OFsNtv+c+O2T9cNpFA4oK6KNBtkvzCLOA?=
 =?us-ascii?Q?xRG+Zi41AP+A0v+sBG/QhUBXLxLZiY08cElPpYWLIHP9eaRy2kjCKY2ycrtv?=
 =?us-ascii?Q?xoemRf6wl/YcmPxiqRZfjp+ehUmxFd3wPD1B468iaRf3TPV/pPQNIN44NEI2?=
 =?us-ascii?Q?ehNGE4Vopm8nUbXblGKpKC3DZVbpfzuIdukKN/T0cGYWXOYZH4FODqWMlmmC?=
 =?us-ascii?Q?/uCPbkcGzPawvWnFvbIdV5ElVcrRznQ/CaBBckcvUhtomaJdL06ZiBznI7IB?=
 =?us-ascii?Q?xSLW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2021 17:46:52.8907
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b0b1e2-d6bc-4eff-01be-08d8b7220bee
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UJJuCULuNo27qk5m4j0vRf8L5zPAdw9BQX1XifRJVISQkzFSge2+I75ZJQhFQ6iEl0mLbclYLlY8tRQUrHYjC4KmaMiR/yc7ezfgpPAu+Sc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4614
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120104
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120104
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Johannes,

>> I use the nvme-tcp as the host, the target is spdk nvme-tcp target,
>> and set a wrong block size(i.g. bs=8), then the host prints this oops:
>
> I think the better fix here is to reject devices which report a block size
> small than a sector.

Yep, Linux doesn't support logical block sizes < 512 bytes.

Also, the NVMe spec states:

	"A value smaller than 9 (i.e., 512 bytes) is not supported."

-- 
Martin K. Petersen	Oracle Linux Engineering
