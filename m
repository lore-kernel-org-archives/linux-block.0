Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0847C433F5
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 15:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6DAD61268
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 15:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbhKKPjM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Nov 2021 10:39:12 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55890 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230177AbhKKPjL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Nov 2021 10:39:11 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ABEmdGR017019;
        Thu, 11 Nov 2021 15:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=uH/N5C3ZBul4SNOQoc3jhTbxvRGj96j43L/hOfLt2Oo=;
 b=ssYcPgvhL5ES+veX07Gzgi1XOz7/HlhfuM8VLDc/y2qUp88ONtJRG1O+lykSDy1l3jP9
 rBKK9fIH1XDmgVyddoToCkYk+8GhJoQnj9gdoifkitCNAZAQlFARkOHmVGi00dBKnyvk
 FIEqq9a2fQ9tIje0t7FragFE8lpjtUrOdnoDApN+XWcb/1fIgXSUwmaiSGfCcB9hYXoX
 CtfnPXqQ4qbFzY+BbwQPkKKrSmkU2ytYG27Z/PqtxaSyaO/vQnCJ1U3T1cyjug6jQs11
 ThL154fW5KkxybgIBlU0lM7Y8u8LitlhSFyysO6Neltx0wbnE1jrmiSuG+PwbdmmU+sT lw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c89bqjr1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Nov 2021 15:36:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ABFZgk5041757;
        Thu, 11 Nov 2021 15:36:11 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2048.outbound.protection.outlook.com [104.47.51.48])
        by userp3030.oracle.com with ESMTP id 3c842e0bq6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Nov 2021 15:36:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VFeldLvNRtuxCUZxmdoBQcTfGS6PEKhsd/3zlxtXeVVSWvUhD+OVRyru5eX9L2D+KpVj0UBGzwb+TwEYvhWeRoRLZGufg5GYSvZRVTYMSl0bVXAwghNbJIlO3nsDpKvJHN7DezGydtkPrkIxKBPK0xLn9SgkLO17J4tDyfgW0a9EHGP9lf9+TUdfOaFIqqfZ9VTfsCFBuahrwY4ovn0SMDUHBjILDHkqZhdb2yhIL5+H2zk+ldqF51zrF140L8VnyufubIgpId322aXYs/WptFnvCaBOAE1k6xyjaziGMjoCWY+5SKy2F96j6lUSWQ/FOI6WQi4KdFVj5nlEmCrkvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uH/N5C3ZBul4SNOQoc3jhTbxvRGj96j43L/hOfLt2Oo=;
 b=G5Ix/z4y/0F+9hepDlzlHhElIYSMg6GjK+jQdbSF5W3+Xx2aQjwP9XPAl+ybH9si6H/zS26vLSpNMqe5P2dDfjLpm6cDszr83p61lb8MixBpKwdrUi7xapGrRYQwHjj3g5T/PDllUrC4IhAIzgaiPNAEsQfOeP9ZIeb/Rgpw5KTTcBSSigA2MbpRFomTrXcjlgrjsbbjBy4N3Ii3i6OP9e4bpPYmnAX/c6Y9mU9R3jEj2klfYlxB9uD8bjS/HZmSXSuWXK+8GUeEx1cKFa+kFVX86gvd/2t0GfOEeTirNhVvzBJwcYyX4d3OfyzRfBgwUjobWD6tzbExD1bIY006ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uH/N5C3ZBul4SNOQoc3jhTbxvRGj96j43L/hOfLt2Oo=;
 b=wkwR5syaLrTxf84dqdgOnVTcpYLImWkutxFbl7pXOl9UOwVzG5NmHvgEcshdXyCq0xGxJxgV6MsZjX4RUpbfyvGUBYRgAD8eER7BvR/w/O6TiWkAe2hqQu7bJK835yfV5vbobRflbT9df2URW4heueGu2hwjOzsZLmbRNIGpFK8=
Authentication-Results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB5513.namprd10.prod.outlook.com (2603:10b6:510:103::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 11 Nov
 2021 15:36:09 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349%8]) with mapi id 15.20.4669.016; Thu, 11 Nov 2021
 15:36:08 +0000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] block: move queue enter logic into blk_mq_submit_bio()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq11r3mg1gm.fsf@ca-mkp.ca.oracle.com>
References: <20211104182201.83906-1-axboe@kernel.dk>
        <20211104182201.83906-5-axboe@kernel.dk>
        <YYQoLzMn7+s9hxpX@infradead.org>
        <2865c289-7014-2250-0f5b-a9ed8770d0ec@kernel.dk>
        <YYQo4ougXZvgv11X@infradead.org>
        <8c6163f4-0c0f-5254-5f79-9074f5a73cfe@kernel.dk>
        <461c4758-2675-1d11-ac8a-6f25ef01d781@kernel.dk>
        <YYQr3jl3avsuOUAJ@infradead.org>
        <3d29a5ce-aace-6198-3ea9-e6f603e74aa1@kernel.dk>
        <YYQuyt2/y1MgzRi0@infradead.org>
        <87ee0091-9c2f-50e8-c8f2-dcebebb9de48@kernel.dk>
        <alpine.DEB.2.22.394.2111111350150.2780761@ramsan.of.borg>
        <yq1sfw2g7xr.fsf@ca-mkp.ca.oracle.com>
        <CAMuHMdVdwwT5yQPpQ5Frr-Un5OMk9LX3sF_zocOejrouSjaO-w@mail.gmail.com>
Date:   Thu, 11 Nov 2021 10:36:07 -0500
In-Reply-To: <CAMuHMdVdwwT5yQPpQ5Frr-Un5OMk9LX3sF_zocOejrouSjaO-w@mail.gmail.com>
        (Geert Uytterhoeven's message of "Thu, 11 Nov 2021 15:48:37 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SA0PR11CA0124.namprd11.prod.outlook.com
 (2603:10b6:806:131::9) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
Received: from ca-mkp.ca.oracle.com (138.3.201.5) by SA0PR11CA0124.namprd11.prod.outlook.com (2603:10b6:806:131::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15 via Frontend Transport; Thu, 11 Nov 2021 15:36:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25779599-e0e6-4525-597e-08d9a528fb9a
X-MS-TrafficTypeDiagnostic: PH0PR10MB5513:
X-Microsoft-Antispam-PRVS: <PH0PR10MB55132311B3BA3C861BD81A298E949@PH0PR10MB5513.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nid/EpzIDR6gGxc8iQto+WrMXGz1We8fpei5Iix57B5aMC2KjLPRhLIzv1UlCvtFE8jHTV73yrNRHNiUAJratrFA599TtzvQbRVP+xy5J1oxqedynaONBYWlL9IqUSBNuJRKhINsXf4PbILUzrlMkrr9makpQxcjH86bYETeckkNJhHUTXioZF5piEKdIBNjNWxRE0Frmnsh228WUpoZVy9AroE2NFULAuz9uBPj1ItQqmfe/EIZWQHH4ye/SJI+7BeIC8xZAGPHQ5LFAIB+ciFIspHzh1hw1rfE94BTNW/2pDkpg0EiqPYiEvbKwCYFkSih7n12aACY5bxOXa0O/utIPgV19mgStfHQ1i6BkRZkHaWroq3ytGZRdK6rMnfnxPiiqE6EpnF8JGcuL7+Lmj8Hkdb354eMif4EmBZF3SWCzCjCW5neRhDZO35Afs5QkbBztZaogAxMvWfm44SbdDquxXF5wcdwAkiYkhUN9e52j9k6OIkCu1muPKtAHIN1Plhpcl+I3tRnnGbqoMvqTWzbVmM7WXcOE94T15EoU3HApbSnoyBYfqV16rWQyd3W6WEhOUt9oqy+Wnsa7ejSF8qsNsIBbKfrkdrYGN/L6HoaXDA+q+p3Ozl9gja28CRPJi0Nxulsu2qTenE7Ik4mcJVtmMnsLJrayjI2si9GLgTOJwO2THz6Xwz6mzYaLDF+ByAlcyOyR8dy1/6zfJIpPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(7696005)(54906003)(36916002)(52116002)(66946007)(66476007)(83380400001)(2906002)(5660300002)(4744005)(66556008)(186003)(26005)(956004)(6916009)(38100700002)(8676002)(38350700002)(86362001)(316002)(8936002)(55016002)(4326008)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YMV/k95mmL+OxBp69luya5x9MuvTiFg+oKbummovmDAd0jBcT+c36gmOFtTE?=
 =?us-ascii?Q?EqBIgu0GMfLxb0YmmzxBjSyTSmyU2YulYK5u9xNTac39Xz3siP4mHj04/Zve?=
 =?us-ascii?Q?E5Bj646EoQ0rbcH3yn8JVE3qUCa56Iw6DXg53nFKTNXLCrkeYw1rlYi0tRJ6?=
 =?us-ascii?Q?mFDu9BrIr8/WrTDIrtP5ceQhBknSlIaTnUXVLVAqSjTojptzGn41FQeoBmAX?=
 =?us-ascii?Q?1LNTpsoW+c7PvRSnNNyKg9dmSO/ApTZW4tHKBSiC1G5wI+b0TV8FtD0h3sAs?=
 =?us-ascii?Q?99TWKb1lMZdECoF8n7gE4K8b2DqAnOO1Rze9z0V+sNOrZvoRnteEOAzS9Bpk?=
 =?us-ascii?Q?UWaIdKe9kPqPlRI6nhweja9BiRc2KEwPWnA8VS/zluQ73O+Wcy9waiPTxlz+?=
 =?us-ascii?Q?MjtWbcs3RIiSiH6Qbj8kL/6SVl3XVhaFUc1XoY3bM73PJI5xynoopE3q/o+z?=
 =?us-ascii?Q?6ae3Qp3BL9BCYG+EAsKCoMASRyZrXzIP48IXAseNe6duBZpIyY7hDrDpAb4h?=
 =?us-ascii?Q?YFwYin5DzXlhGfevjWEh/QxJvU32h055vurHERXrJ0g839km8RlY3ezUmVD3?=
 =?us-ascii?Q?udrRIN4PCqR3Cc5KxphjXyxxSpnAlSR9wtRtRTgzwYJb+VtFOhN16LvqPcpZ?=
 =?us-ascii?Q?S+eZaDg86NcArQmwdeJ5jaAywB1S+/BXT9eFdhZSfMan66jJ8H7oTDcScW1Z?=
 =?us-ascii?Q?MZ5YUCMbgU5+ozv65ADF6uSEfHusX/4mynm8jsYMcRODPOQMuMUCa8ORWVdL?=
 =?us-ascii?Q?8NpXpmadXuMfAdq5WhqopDVbmSa/JDaOZ1RN8oie4B8xF34TIQyUMIM9U9Ft?=
 =?us-ascii?Q?YtEBYcjNtHCa6UsmQ5sAxEBiUrkSlhPqcU4e96U87M9GE3I6f6eGhDKkpYjx?=
 =?us-ascii?Q?S3b/FGkLowBaXS/4uurksn/oBaBenx2hsIK/eJ4bIFGo3aTsnDTK47fAziLW?=
 =?us-ascii?Q?ZsovEjjTTmRzh49lCTA0bE/s64tG6sfVfkM4F0ZmCg6VpnPsQczu/c5peLmM?=
 =?us-ascii?Q?WpLXkfdX8mhqNOlzjIqeUO4+wlKXPGIf5zqdu9OjJB72ppK8wlZxqV9lrNTy?=
 =?us-ascii?Q?QUm44tkx6HRsftgqJTSagDN6Ze0QL616IGKDQNuGT9K2K82ABhLBu1m/hBuL?=
 =?us-ascii?Q?gAldGRFfyJFaynX7rxd0XoZ4fHu0DpbAOee2jHgobLkApTlDgUZgMRQoJI37?=
 =?us-ascii?Q?750Fom629/La71ntxL20nYUFOz+Xb42F7WJ/RlTcOgzyvczLzHYuxgSh9kY9?=
 =?us-ascii?Q?eYrFkAS8E/7M1lFku5Cr9/XYYcbWoDl4m7vCnhPof1ZXeBAuBkEOYsTYGUfB?=
 =?us-ascii?Q?47ilmHDNsFXaLVM/l40g2kTIMydvYoxF+5COFhCR5cXUnxHn5vPnLii+Iwoc?=
 =?us-ascii?Q?5dt7TGYmm5cPHVNGeEyNhj2EWAeDjROVbxsU5c3HoFMUXOmhTcY4QZKIYUbO?=
 =?us-ascii?Q?rSZJrxhznINpaCACwfQzLRymtHdPwdTxAdJpyfZw/011VkwBmFQ93Pfq2X1i?=
 =?us-ascii?Q?kT/UDgcDjSc6P4wupwePubIoVYuB48+cjyXY4wpefid9+mWtlmNQY51NeeN4?=
 =?us-ascii?Q?p31IQ6IntTpGftI0Z9zxhKzwMqFyVUeiLdXPqvv6KsubM2pux6cRL0KGpxMO?=
 =?us-ascii?Q?G1sb9S8+AELu7B1EyfHlZLmRg6dmDkW1S0ubFMAcektcqx1Y4MymgpUAguxa?=
 =?us-ascii?Q?7905Qw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25779599-e0e6-4525-597e-08d9a528fb9a
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 15:36:08.9401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xGYjJ62oMp3vpbZhAeqUV4lJmdKKnKYSYYvIRKQx8ZmIkPwmfNvr40ZCMkDLLzzdyDdvtGb5Tv8x289kVYyL6MhDjfnVTtNMcbtZpT49i5A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5513
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10165 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111110087
X-Proofpoint-GUID: qbsYTe3_DJg32Uu5yDvpglmPrglBEaIR
X-Proofpoint-ORIG-GUID: qbsYTe3_DJg32Uu5yDvpglmPrglBEaIR
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Geert,

>> > sd 0:0:0:0: [sda] tag#0 CDB: Write(10) 2a 08 00 00 00 01 00 00 08 00
                                               ^^
                                               FUA

> sd 0:0:0:0: [sda] Write cache: disabled, read cache: enabled, doesn't
> support DPO or FUA

The device is correct in rejecting the command, then. But I'm not sure
how the commit in question would cause us to inadvertently set that
flag...

-- 
Martin K. Petersen	Oracle Linux Engineering
