Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04A6C433F5
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 13:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA1B361211
	for <linux-block@archiver.kernel.org>; Thu, 11 Nov 2021 13:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233328AbhKKNW1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 11 Nov 2021 08:22:27 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:64552 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233339AbhKKNWY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Nov 2021 08:22:24 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ABCuL37025608;
        Thu, 11 Nov 2021 13:19:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=jQnUzqXrjaxMjG55vPuCkCEQNwLBPm5NSx7QUd7hjNE=;
 b=cZ92BNDmTgxfCbgK1Xcxuzhkk1gHOxuBzNWiR2vb4Af/aFHP9L8DaiUlEzMH+3GKMbwD
 l1ayDJSwFbGz485yWjrOVBkpaUqDwf5dNp4JwiCLgh7y7ldKkYZgJuyvIK8SU8GcN6Gm
 TLrohHdXOYzwcnmv7vlakNTrbRpKMYCJNtjtFM6oGWhYr+ImFYpeO9BLC+9YoH4w+0r0
 5dvrwIpT7FZhuJxpeZibA2xFPAEB2sZHf+o/adSaP//u3JdgWhr/OWH2vbqVcJLOfOyp
 SSM/QrYPNjzaPheBwJh26gr70qbmmrEB6Tbf6Wa3Yjnhs4AZcXQ+1Hnyb7J+JL/IcGmk dg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c82vgjf2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Nov 2021 13:19:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ABDBexL018760;
        Thu, 11 Nov 2021 13:19:22 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by userp3030.oracle.com with ESMTP id 3c842dumh0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Nov 2021 13:19:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5Wuos12TfYt4qG/+7eV8ZVh+mAZxlam/TNoJqm7fut7hB524qe7M95XHFizieJNFXaUNuJetgEvoFS2o3gzt8fM+aXxKKBf2YBw01PgHr538EAEvjj7dB+kBYkeu3io2nbY5V8tcNMAuDyTkIPY0sfqURRTNT3W5Y9k/MzgPfaHDxk2iQlHcOkcyKW8eotjQw/djTXwuRO2ZK2NacQV2HCWH8FElM7so0mpZIH7dSLUnhu+nYQnBeixAo8MsYy+MHVo7j2yAUoZDsvpmKAlelKO0Rnt6z9tXlTES3E2Y8JFeVCBbBNRpXLbs2mowg/XOHI5yKVussYgDNoBS14T/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQnUzqXrjaxMjG55vPuCkCEQNwLBPm5NSx7QUd7hjNE=;
 b=ZcJ9k5uqwmoyf3MLNDkcIZn14d2I7kMhsgaKNfW9bvQTDynzaKPowJl/r2exC6B/yWK2IZIr4VnDMUahYSybie5STLKVR8Y4Ij0afK1LKS1Nbf0uta0Dlv4AmWPvwq3J6/OI5F1SnZXZ/N+ozo/PXod18dm9j+QwoNnDqv8hj3jO1wxrfxIrjjANTdJExLqJBWVTF7n3svsxurlW54Nc2NcpV48L/FHqSg0Qok0+j/OGIrCuXuzdH5+bdwip45govGfMlOtw3IoZogtGJZXTeJaGusXfeUXdxR/2UMDKkCPHvOzAK5tlVsSgdKl6d3odMn1fcplsrfDZl15g45SjjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQnUzqXrjaxMjG55vPuCkCEQNwLBPm5NSx7QUd7hjNE=;
 b=YPE8FGz/WCUKskMTdEaKKMIy50HUDFezFEJU8xirVI8Q9akmqyfq8qKGNYb3j5fEOsaYiHo1xFbhmQ4aodB18Wd92aqN4pKb+lT/9cZuv/GT+PF4Y9pHuI3en87s+TFyulMPsvzojhA5sWP9E0O98i/wweScVs5ZC+I5X8KR9mE=
Authentication-Results: linux-m68k.org; dkim=none (message not signed)
 header.d=none;linux-m68k.org; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB5484.namprd10.prod.outlook.com (2603:10b6:510:e1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Thu, 11 Nov
 2021 13:19:20 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349%8]) with mapi id 15.20.4669.016; Thu, 11 Nov 2021
 13:19:20 +0000
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] block: move queue enter logic into blk_mq_submit_bio()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1sfw2g7xr.fsf@ca-mkp.ca.oracle.com>
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
Date:   Thu, 11 Nov 2021 08:19:18 -0500
In-Reply-To: <alpine.DEB.2.22.394.2111111350150.2780761@ramsan.of.borg> (Geert
        Uytterhoeven's message of "Thu, 11 Nov 2021 13:58:38 +0100 (CET)")
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0010.namprd13.prod.outlook.com
 (2603:10b6:208:256::15) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
Received: from ca-mkp.ca.oracle.com (138.3.201.5) by BL1PR13CA0010.namprd13.prod.outlook.com (2603:10b6:208:256::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.8 via Frontend Transport; Thu, 11 Nov 2021 13:19:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba18a987-ed40-45c9-89a8-08d9a515deea
X-MS-TrafficTypeDiagnostic: PH0PR10MB5484:
X-Microsoft-Antispam-PRVS: <PH0PR10MB5484837F8AC8A6C8388748D78E949@PH0PR10MB5484.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R50ZewkFj3TnjBjgMTk8tafx4aiTssLoaDHFer9yiA3pnHNLpcgWlSs1LoLzUNbcpjxL05Yyo1h8/gTdyh+9rVVuH+0lv34St4Kqzy9DtIRhVT/ntltkn4SIEjn88QMINpkxXRNLa9HATaGA87JlCjqgzOQSTK16GLkkhczX8evsRa10DnmfXWyiARvtQMiRXY1fcaLZvSR6gH3XZC/gi3hpbMt2yMuOXPmf8AT5tql7qTKrw68psIGnrIyVUkE4Z7W5s0KZq37IYDg1OVzAQ1YkvB7xD6GBQnNYrfqI2TahgzAR0bncf2ykyouEeWRXuAChYL+AehluoWDpIQW+Yj9axe87KoMA0yvj8VTqd3ZcHqV0WuSG50vyBd+xms5GxgjR9yH/2mT4KNPJK3QU6cgZTxIzkMsfKI9cNfczMLCxMZnAoWBkiinujm4DEyZLHIcMDC/SqsjnPrM/nphojo0xB1IzLNyHgSu2eHJI1HNTtZ0ksyhs8VF17oRgY+ubOhrmvRut9arlqHH8fGQ7MTLxWp7yu+T7YsN7c6vuAO7gYGMn5OBiya0AZol76J85xsVk7Q/Dta2223cJ9MN9/UpahIebdy3aziqPME3PjQ0q6QMfUHNK2/QYhajZMn3/MjzQLrRr1f/ZrDotTIJI8Uq2hPd+wGOkBVvvo5thSgssblgV9IRbvU2YdIHR6jATZ5kewmtL9odsdUFx83EAKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(66476007)(38100700002)(38350700002)(4326008)(7696005)(186003)(83380400001)(508600001)(66556008)(5660300002)(26005)(36916002)(8936002)(52116002)(8676002)(6916009)(54906003)(316002)(4744005)(956004)(55016002)(66946007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PjxjVhSQS5CYlqHbpHYeMiErq7eO0JJzacO4a50slE1gAu/sMsBn2Nn201iG?=
 =?us-ascii?Q?T8k48F4KHuT3GDTJmZr44tlrTBfXCxD0rEp223zoEwYlACZtEVbw4aumdtpB?=
 =?us-ascii?Q?/t0+VJw9uxmAPDfEaR3dGI8rwiFaa7CG8TU9X3+h0ZMD28FEU/ctrwPF/AGX?=
 =?us-ascii?Q?c0wSFOcoh8SL391zrcVxB0CSxQGA1OLtMVryEmeA/uZS48CeWMQoReVtAsvb?=
 =?us-ascii?Q?nL73bRaDhfYJQB1vRzcYUDRews7TAGqmEybVxZgiaNnkZF/7+JskLPtXjxDR?=
 =?us-ascii?Q?gaZA5wE1ijzEjk0PS7OsQ7KrJkBHvbf6jyxKBCu9gDjs7pPzpgzxcDRYAxIj?=
 =?us-ascii?Q?vlCo7PT8KNZoehYlUjEnxBY+d5qxJbU6OorbVIcl8XWjX5kBuF+qb3m1O4zo?=
 =?us-ascii?Q?JOTlf4QoDpztyoFLigTpci8j/iU/4O4ez1mz5ZtGwqXv6OrbajRXI27N7Ujp?=
 =?us-ascii?Q?bY7/3hPa4FsLyhcjTeEVn5CgQK20QJN2tWme4yYWDmE+XtsV0OExKf9gcJu0?=
 =?us-ascii?Q?7DJy/kehW7IKdRK0jwQI1SVKCap3AfeYATOBOko4cW5DIPtd3/+SPz/7LaeK?=
 =?us-ascii?Q?PAhIffRE+diZmr+Ad60L8C2T1NVWJlxe3LolkGmKR03j6cT80pZGO5ZbvVxx?=
 =?us-ascii?Q?0LYbnCvEOz/Kml29U1cDNDLjZPuHf+YWibhrJ20oesiNpZQ+xhWJgNywvT/8?=
 =?us-ascii?Q?iR0t9+oGiUzSLeOPCzKQrGcA1GU6wUvle6X/gPNg3iE/64u3Zv6SnLT44vKm?=
 =?us-ascii?Q?7CvbKvJ03OZRnUH7akGfS61K+5v5TqxdKsVfQyAZBhoQXaZ4NybKqMzKsdCW?=
 =?us-ascii?Q?UxK+dWKtvWcypXU0cw7Bhi8TRNgFLJwI5d+YEFI1t3vVYIHKQ5jr5MezdIpu?=
 =?us-ascii?Q?Y5jr4bPqRDtVHbQ/V/q7JI7Uoz8EdB4XB7zbEwUm5Uz4WF4b58EsMn88HegE?=
 =?us-ascii?Q?0amoEcka+PMHt+B958GP31WmnOp/Bb7bZkiyZmemETfIVk6b/n7zp0FoRCb7?=
 =?us-ascii?Q?XXN/WXfwhgROT+ME8yuY9sWyQV6gA7GdcCxKRRiq4QYJoVq5IOeApv7boPDg?=
 =?us-ascii?Q?DnQgWTY4nVf0Ss8IWgZVD1+WWcEfN+IZpYe5zFY7dUbl68Iah3Qa9LrcosUC?=
 =?us-ascii?Q?2BJfOx+Lh1m8sUkGbSphkB2JRjblTKaXeQMzpSS5HUW0SXM+30DFxaQ8VQDr?=
 =?us-ascii?Q?6UdaC5ZBQBaLCGnO6N2uog3U/9RW4SCJuLapKlefPuj++vjBANS7DWLtBQGk?=
 =?us-ascii?Q?xEZ8j1GFOoyfPZqqvH/2ug48/QJydqZIoFlX/QUMhLxFisxl0EieNXVNWceI?=
 =?us-ascii?Q?GXyiQNAYRmmkX95MfhlskdsqECR4ljpZivBp6gH4t37pCy6wlwfV7W8WANCC?=
 =?us-ascii?Q?jh7LNwS2SXHRWFI/R/vdGea4NDJLhpGgZUNYJ9yawCgBeIwDtKgbTFpnly8Y?=
 =?us-ascii?Q?tCfk1cEGMHqXqp0MrDmqfvLkaMGA/5NTZ6fC5aafWa7rmIobfYzhJrAYByaw?=
 =?us-ascii?Q?ZK/vNDtNoCKZuOmsEzc5XRHFSCaAR/fcBbHkrwtPHf3wRNejLN1NKFzZMmyn?=
 =?us-ascii?Q?rt/Nlr2AX7v3atW1DkQBOjklMBMQe0sU1kKj2V6k414oAEgY421nPsHJ86vK?=
 =?us-ascii?Q?GfbGUZxF2ivDaEsWdMzb0ryqEdb6MhLaeuM4hZav6veVPNTiUdP4b1vIDAYV?=
 =?us-ascii?Q?lHtL0w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba18a987-ed40-45c9-89a8-08d9a515deea
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 13:19:20.4336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PwzskDM3FyZP4cG79TNK1B7swPLrsHbi1OVGOo//BPIQhCN+u5ym3jVSvlWsNEmtIdDlRoAtsQeLAZZIuEpOrPcK2nj+EpJuM+grqflZSfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5484
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10164 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=898 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111110079
X-Proofpoint-ORIG-GUID: X7v38xWPfnPIH8RhP_cX9hrDNT2cBY5B
X-Proofpoint-GUID: X7v38xWPfnPIH8RhP_cX9hrDNT2cBY5B
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Geert,

> sd 0:0:0:0: [sda] tag#0 FAILED Result: hostbyte=DID_OK driverbyte=DRIVER_OK cmd_age=0s
> sd 0:0:0:0: [sda] tag#0 Sense Key : Illegal Request [current]
> sd 0:0:0:0: [sda] tag#0 Add. Sense: Invalid field in cdb
> sd 0:0:0:0: [sda] tag#0 CDB: Write(10) 2a 08 00 00 00 01 00 00 08 00
> critical target error, dev sda, sector 1 op 0x1:(WRITE) flags 0x20800 phys_seg 1 prio class 0
> Buffer I/O error on dev sda1, logical block 0, lost sync page write

Peculiar. That write command looks OK to me. I wonder if it's the FUA
bit that trips it?

What does:

# dmesg | grep FUA

say?

-- 
Martin K. Petersen	Oracle Linux Engineering
