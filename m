Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B30A4C433EF
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 03:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8138660FC4
	for <linux-block@archiver.kernel.org>; Fri, 29 Oct 2021 03:39:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhJ2DmX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Oct 2021 23:42:23 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:11830 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231611AbhJ2DmW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Oct 2021 23:42:22 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19T36qjC002213;
        Fri, 29 Oct 2021 03:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=BP9youmReOmk586+G7grFK5wel3fCVqPSHSZq7K17Fw=;
 b=C6Kkr+qD/w9FNWNmth0kKiKGYiO4nMfBoJOdXsG7aiBlH6C7ybFTAKI6hyvOnyS6cREM
 urZsAvvCxSd4UhOhygoBpuUOBkEhK8uWkNKZmdXZtEIS6+f6lsCmr9bRgs+xXuYRhKug
 Kj6NyB+mYt104npasOjI6WisJqIWYfZVahahA7RT5GPLHasiqoAKAz33bHlI9dk9B8ub
 jA2XMIjdk249aiVrmgfrHYVJ3MfwokQLIFWruPxRiclh6BimyB5v4BFWIK6QGk5Rql8W
 PkQPDoOspiCcxztLwzDU3B2kmeJ3Frw38WM038x3Fh6HykMs2BLMkKaW9h9qO4dSVC1i ag== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3byj7rxjuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Oct 2021 03:39:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19T3a6qR190292;
        Fri, 29 Oct 2021 03:39:49 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2108.outbound.protection.outlook.com [104.47.55.108])
        by userp3030.oracle.com with ESMTP id 3bx4h56s7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 29 Oct 2021 03:39:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ni0RKh6QaOb0WHB5himG/Lhn72qTliEpcqexuE9iokvriHjH8OPu1ZOx+RwTg5r+PPkenFpaXPC+zqxCfcfkroZ2ls9nKhEWE29qRPC9R6gCAYMVlLUq+dk6lbDY3zBuorVQCkWJx4uNU7GAqq6ZhzLjQdN2GRNLiqKSyXj1p1Tu6CE7Mn9USNtJRgzIvYe5/PmoTyZ6FCQTCEVKakhdm4IEVhthMLbdPksWHzpOPPImXg8PHb8M1wCAXy4zJNxV4Mb2ZXfOXdUtoK+n7c4/ynU/l1bdgJwazOvnpllozKEhDN5rSuqbmh08q9KFYghDvqY080OMIZnQO6fGPEmFxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BP9youmReOmk586+G7grFK5wel3fCVqPSHSZq7K17Fw=;
 b=Bdvcou9waaRRu0G9HGn/78gXUH3eRNuPJ2Coh7AsaptMoLJoufJFVppNxHxcILHC5DDCXkeHDRn3RHXOmNVUWz+l85bCFs4y8Q3qxcUNd1mTDirsik7WeQacQy05N69xQcdtfj7x3A+Qq1SzjWYCVl1Uun4VU1g/rmY459cCbpsSety/NOERZ0EIGq/Kr8mzCQLZxg+C/UWZQ47BsHYN+ZX0aJeBW1YhyLC/WJSpgBOGF5pM6+gFElSkaL2ZPOo4EDFB51mSNmIjJ8qxAxqI6f23uPvToSQDsECnrJk64KbJUPug4233/YXjZUX/lGHcarTYgBa6rEzBAwpz76c6sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BP9youmReOmk586+G7grFK5wel3fCVqPSHSZq7K17Fw=;
 b=VAr6FmQd2Uuh14Ujt2E2T5SxJdIWwu/PuXOHAJJR7lzX/K5a0/yo/A3oxtrI4W6LJnAcaaDHMJXFtkGjrmI2Io7lwHGGdsYkrPhQTsoEdvVT3jc8G85S473LUEIRYfQib6jHl13Tnl5EOf5COdF3lsk75iH0IZgzGbfYz7ZPaEY=
Authentication-Results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4647.namprd10.prod.outlook.com (2603:10b6:510:43::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Fri, 29 Oct
 2021 03:39:47 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349%8]) with mapi id 15.20.4649.015; Fri, 29 Oct 2021
 03:39:47 +0000
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Alexander V. Buev" <a.buev@yadro.com>,
        linux-block@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Mikhail Malygin <m.malygin@yadro.com>, linux@yadro.com
Subject: Re: [PATCH 0/3] implement direct IO with integrity
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1ilxgv6si.fsf@ca-mkp.ca.oracle.com>
References: <20211028112406.101314-1-a.buev@yadro.com>
        <bc336e90-378e-6016-ea1c-d519290dce5f@kernel.dk>
        <20211028151851.GC9468@lst.de>
        <85a4c250-c189-db5f-0625-2aa4bd1305f8@kernel.dk>
Date:   Thu, 28 Oct 2021 23:39:44 -0400
In-Reply-To: <85a4c250-c189-db5f-0625-2aa4bd1305f8@kernel.dk> (Jens Axboe's
        message of "Thu, 28 Oct 2021 09:20:46 -0600")
Content-Type: text/plain
X-ClientProxiedBy: SN2PR01CA0074.prod.exchangelabs.com (2603:10b6:800::42) To
 PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
MIME-Version: 1.0
Received: from ca-mkp.ca.oracle.com (138.3.201.52) by SN2PR01CA0074.prod.exchangelabs.com (2603:10b6:800::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.14 via Frontend Transport; Fri, 29 Oct 2021 03:39:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7430a43e-1cf3-4576-a7c0-08d99a8dc0f9
X-MS-TrafficTypeDiagnostic: PH0PR10MB4647:
X-Microsoft-Antispam-PRVS: <PH0PR10MB46478E7937F36B7247B7B4688E879@PH0PR10MB4647.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VfISz0xZzpyS/zRyPWZistnQ83qZuNfsNtQimP71lOxTZShuFNUZjQIbWZK7r/4x/2tzdjllcF22TMcbazk77YqsVSe9dpUogylGVPCjZDf58A7Rod3Df7yOl627hYJ+R5sxXFAlO87Pkjx4waW1ST3J7umAPPp3dCSuFQTs4NeCo4Hk3KAjRvzHa2XKqPIAzlQM4uQ7h9Lmm1MeACU42hzyNy/e14sZI8KH4jj1BIqx/4/Gc41u8IfN6zYcB1DOk8+vXIqsOWHhp0m0rzKjd+oEA362zQVrneFi6Qvc1QREyd1sTZAt0xGRT/L5R6dALk8g5mqy9yG1c0uwoHyRcJCcUM8qDl4T1Bwa/eoLWGx3Rn5i7iuSMdyHLGznlzlZwABYR3xj6fJmDkiokjgY+l3i9DzH1Hb67jK1iQLmrkNt45fjyOxWbaL3O9/aqUWmi6TzBkg1aOQfb1hWQwfVCDND01MOf2lhIDkLYLTYU4WA6ULuT/97zQoK8w0nFmkhqzL0OshUzZRK3Eqw0tvMayeDAUF61P12bPBWqV/wpX5GkdqydyyhUh9BoXnBvVYMGgyuNq4uuJNydCAHLKx2wIQR1fjUksux12707HkMZu56BYJbZEBWqjuuJv4tPUX/BqtikgFlElkVFWe6+6DUjLs2jkUMRMierOzNQBDzYosjFw+ayv72SNifjzS/wlSspjdlhB8hlvjF2BowcopAGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(8936002)(54906003)(6916009)(66556008)(5660300002)(86362001)(8676002)(2906002)(508600001)(55016002)(66946007)(66476007)(956004)(36916002)(4744005)(4326008)(316002)(186003)(38350700002)(52116002)(38100700002)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Wxn+O9dyNU0BIMuGky9VY5TSkpsZK94Vvwn9El3gYotx2x44f0VutKadYnau?=
 =?us-ascii?Q?VHZ0QXj+X9n7SR9gXK3BPoNdSNaQgj4KjHba/iGtGGug6Cr/D5Lvhe4eF4Rp?=
 =?us-ascii?Q?0X8BkH7kcTmxHwxLR+EWmiuVa+7vnBQMhu5IMCekE9u2FFn7HLTH2D63H8OO?=
 =?us-ascii?Q?W2pdTwYxVqnHydkQcz8V9UZxLaWw4wNF0+lSTjxlMXKpiwYD10ynOauaqbLU?=
 =?us-ascii?Q?y5va4gRW0tJ0qKqpp4f+QIQia34bwj2QRUyMJhG16BYxR6LCwqfqSntX03yF?=
 =?us-ascii?Q?Otbo7EF/Ri+1+TPotJtAhLZnNx5moLQ3kWyp4UaJsv7u//Ngh6fcgMpAR+Gx?=
 =?us-ascii?Q?XefZ9R042o2grjy9i5xrgyJLvx6o+xOMsFbOnCw1Idabb4vxxxoRSHZhm92m?=
 =?us-ascii?Q?e0csJMLomqD/tu80KG/TdEdcdbrHIuHusOy5qrGfrcXRfGfpKI1rdY7Y+IX8?=
 =?us-ascii?Q?OkHqr9AN7sdovELLb6iUBxdFA/UWqoIsaeeI5ncYJvZGvPmXs8gkthc1Jm9Y?=
 =?us-ascii?Q?J5iP9WeHp8RvuSZMbkK/lOxUHa2psYFOlz7N2NQGcsblDUJo3aQZQQ0zKRb6?=
 =?us-ascii?Q?ndGCexYEIhyuQrmF/msbSN91HvlTmiEitV7NcKJMHbnvh/8+GIr1+rLA5WiP?=
 =?us-ascii?Q?fxnzaHADTnzjdjHbd0vEz3U9CHK5zECH3dPf/juZI/tyQ5Rsb/QPClu15h2s?=
 =?us-ascii?Q?mgy65F3gg+OfFsQ1SM/5NmzLuqL85tUtRbb3p/25w5Fbtzn/r2gSQEmbX8EJ?=
 =?us-ascii?Q?gVOSIVKzWqJOJZ85rSHpAtE44NevucnT9t8VjVWERZZvs4eU9OWmMwgC4MQb?=
 =?us-ascii?Q?TFKPW76oJNWtieUq5hEfsGgaJVRHKIGrA+StnXro/LtMA15KH/90LQ/J94Eg?=
 =?us-ascii?Q?xhT8qLDw6K1NV6vjwzpoNyygKUjr9LMcHdSsQrXBI9HjizGyTs2IqyYIhe43?=
 =?us-ascii?Q?tWj26GBFrihKi7RznhleJG4kqVM8B7I22i3maxweMNix3sr0Dp7NNNOnvbeL?=
 =?us-ascii?Q?avWwRizjc/MqNWN9tNGi/ciBMdISwTT4hTIKXlymGL8ohzwPEdLEoVoxZPAL?=
 =?us-ascii?Q?67Dv9whr7m6IRX1/jzmuOCOpu8S5e4PHH2RtTXb29chNWNsCUz85jqvRQiwM?=
 =?us-ascii?Q?c8wh/ZppmhYC4DhwzSjAx2Y43Cz+vmUe1UYmcSByAxcP46QF4lDqjeCcuYBg?=
 =?us-ascii?Q?DoAYp4kxXJVxMzpMA9kpL0qHhaWp9w7o5mfuv9Nx0WjPPjGgpCn/GyksCpSQ?=
 =?us-ascii?Q?tqKf5H9WVKXIiEwZUBAA/yEYUtdlz2JDY4yysVSimn/mspMr1gcoBV9nKIr3?=
 =?us-ascii?Q?uKMQ64IsHovWKaNq4l7hwP4k+eJYvR5vPMX5QH/yNeV2vE4r+aSBiR42gUwf?=
 =?us-ascii?Q?XVbnpp1aaI2B1ycffPdey9rWecSUMZgJEwfNeswGdBci6f8wnMsQNE+a03QI?=
 =?us-ascii?Q?KZLCyFpcTFBuej508EYV46k+7uDjZxOT3UPZuwskkz4bUcFCSpjc0BENe7Ve?=
 =?us-ascii?Q?fy5OnZLk+5na5hRYZ8ab3Vxsbp2wmga7dMNtsETMgywRC0BDspFiBVu8y3jM?=
 =?us-ascii?Q?yD3W695cV/SI/P2OjaioBz5BenDUYdhh0ieHQ5FHy15KlcLqhxB9A1cpWzDi?=
 =?us-ascii?Q?MPq/eWNyxkXrQh0om3sqpNhZats71vRIN5SCo9JeaN4XlqoZLLgu6wm7owqF?=
 =?us-ascii?Q?+8JSUg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7430a43e-1cf3-4576-a7c0-08d99a8dc0f9
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2021 03:39:46.9613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lk433j0aZ1TxmP+IOHkJxtnyHSbV7RaP59ge6rtoRZc26+1ZwP2BYHLVe2PiEPtHbJ6Zy1hN4G9DdBXj/Qw62l7C3c8ebG+Igukb+CEswUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4647
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10151 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 mlxscore=0 adultscore=0 malwarescore=0 phishscore=0 mlxlogscore=816
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2110290019
X-Proofpoint-ORIG-GUID: iDHQVuzst6cczgPSydI3ky-jUi4K-2Ut
X-Proofpoint-GUID: iDHQVuzst6cczgPSydI3ky-jUi4K-2Ut
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Jens,

> Yeah, the whole "put PI in the last iovec" makes the code really ugly
> dealing with it. Would be a lot cleaner to separate the two. IMHO this
> is largely a work-around that you'd apply to syscall interfaces that
> only take the iovec, but we don't need to work around it here if we
> can define a clean command upfront.

Yup, I agree.

-- 
Martin K. Petersen	Oracle Linux Engineering
