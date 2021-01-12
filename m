Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A80DC433E0
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 17:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1074920B1F
	for <linux-block@archiver.kernel.org>; Tue, 12 Jan 2021 17:11:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405742AbhALRLB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Jan 2021 12:11:01 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:42556 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405438AbhALRLA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Jan 2021 12:11:00 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CH9C6E108476;
        Tue, 12 Jan 2021 17:10:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=IlbVk9yfievLMwMH174fFPZHiYCq2kBiKxNxYwxgr0o=;
 b=mY/gTqfkq5BsuJXKa9UqrmX5x2IVZH/2dcxr23lzzCtygF4f4kmaiIcq1UJfq46O0LYx
 HA+7QWn+WolYshy4LvUV1EWOpCgxhrYqKFefGB0+/klOLJnjNpU9VDw1Bp0a8HCD2GPz
 is9wAwOJHaUWtBlaBsX4qai+uaQvxHyIkf2ykRFL1hXqYAvKDaBVIrPH1tU/mNX5QKhh
 d0Y7B+2T7+RDyjxQZsWfKfY/65/DXmT5YFfcvahzMrf++M6A4kJJaEHQOt3qr48Xm0Uk
 i62fMpKy1Ni+X01l5uQy9SaI51Nk3D4p3z1Q+Ox+BMWroL9e+Gmlpn9p+1pgwQh/ZfeZ Lg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 360kvjybvy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 17:10:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10CHA34l114791;
        Tue, 12 Jan 2021 17:10:11 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2047.outbound.protection.outlook.com [104.47.73.47])
        by aserp3030.oracle.com with ESMTP id 360key3mf0-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Jan 2021 17:10:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfmDRutXBYE/Rna4bn+BLOGPAdJKTejeS8UgRkJxe8F+ZlTMm0iNAqiNMsjZPHCbeg0DC1lySpfs3hLrW0f7T4vcHPUiXLQYFCCEMqsMu31vZeO7BDC8QgSMQdnf3YkW9GVw3QmBPFFZiDRDRqfDJAild8ePA9E77tiIl3WhvErh0XJjlq52YbyIlerB6OLE9txQQjwDKGW8Q5idYkk3n68RS6VyfCAgDMY5j4/HcMJFY+jxOhq4dxCxMVQKAIYnqS0Sh0VyUSqUnbKF9NH2FVskwXqcpc5o2qLCF+PLxxNh4ECv/LTfJu098Wll/mDtl6N8EXBwHOnyixhkPUGMMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlbVk9yfievLMwMH174fFPZHiYCq2kBiKxNxYwxgr0o=;
 b=iQ+gvRL8SjKyHuof2FI0fHGrYjlY5qN6uVWnyMokdfeg2zU1MHEAXKmN8mrQHbPGoV3ML6i1BCIArF2dErGI7QF3vTu1B6+B6GvISrlpPpZHUEBT8cmpS8qs5R9j7mibON0z8q+1H76mvC1wjVaVGcB+Tdh+RwvhhPN4Cm7y3/Ft4por91i+3AEwp2R1v4DSaeW4jAYqr8sLPcGSmgi+wLKncBb0XLHgGHE94dyiF5132v4knE7GCdidshJrgqa+wof0EBR8URTbBbQleSMEU5hOhqqt8t7HvAOKqrzJ0HMDN042ePkpjpYPJg60h9kmrIIx6zDlBaHGfGYg36AXWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlbVk9yfievLMwMH174fFPZHiYCq2kBiKxNxYwxgr0o=;
 b=JfS42BwPLnBX6yUmHo2s4/iBmqC8zn7rGi00UOgjhICbcBl7tjr9aUXWaBwWy9KzmTKO3ApELhKFexo/X/BvpM7kuf0/H2OgLqABr6qnIDxLEzqjS/6pK5snDPKTgqAxJ2LVnRDk5De0YFLRVTm0iRKCXLtE5nikm8SVavtaZfY=
Authentication-Results: smartx.com; dkim=none (message not signed)
 header.d=none;smartx.com; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4502.namprd10.prod.outlook.com (2603:10b6:510:31::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Tue, 12 Jan
 2021 17:10:09 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::54f3:a8aa:a2cd:a3a4]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::54f3:a8aa:a2cd:a3a4%5]) with mapi id 15.20.3763.009; Tue, 12 Jan 2021
 17:10:08 +0000
To:     Li Feng <fengli@smartx.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list), lifeng1519@gmail.com
Subject: Re: [PATCH v2] blk: avoid divide-by-zero with zero granularity
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1v9c25bm1.fsf@ca-mkp.ca.oracle.com>
References: <20210112152951.154024-1-fengli@smartx.com>
        <20210112155502.426331-1-fengli@smartx.com>
Date:   Tue, 12 Jan 2021 12:10:05 -0500
In-Reply-To: <20210112155502.426331-1-fengli@smartx.com> (Li Feng's message of
        "Tue, 12 Jan 2021 23:55:02 +0800")
Content-Type: text/plain
X-Originating-IP: [138.3.200.58]
X-ClientProxiedBy: SJ0PR13CA0152.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::7) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-mkp.ca.oracle.com (138.3.200.58) by SJ0PR13CA0152.namprd13.prod.outlook.com (2603:10b6:a03:2c7::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.2 via Frontend Transport; Tue, 12 Jan 2021 17:10:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 836c528a-5843-4467-b4ca-08d8b71cea31
X-MS-TrafficTypeDiagnostic: PH0PR10MB4502:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB4502532A86B3C69D755CF0F88EAA0@PH0PR10MB4502.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GD3CQpmld+tduX/9ELrUGraqCXW8CcTMjQ5OLELyQuIcpWJfLHx0t2Nq38N8dymI15veQRbkPjADFgidM9cpXxpoWYLNmPkEfjq3h3QhfiCTiY7Gavd5PdIJ2W2X7wDrjFhegg7tlqx+KJAE0nb9eOblAjxDs6x2vxROzchq/+LVEaEwYINT2w5i+LCbiaw6YvL92gmHQnaSG1p3SUPtnjm6+UzAIOc89qleBUscKTaYxwnGdFQDLhU3Gj0nbMaNESBgPH+PTJD2ff2wNhsfbCuWqtvOGZMp6CrECNu+xXnyaNYqUWzz6TO4+Y3McQ4rF1+FTBNsHkHBRDQDCmwZaApItVvkNyIiUZojd7Mr8g4ULaRV0Rv+mKAKO74dygD33i6dSuLTSyjETC/RIWFQpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(346002)(376002)(366004)(39840400004)(558084003)(36916002)(316002)(6666004)(6916009)(478600001)(55016002)(7696005)(16526019)(52116002)(66476007)(66946007)(8936002)(4326008)(26005)(186003)(8676002)(956004)(66556008)(86362001)(2906002)(5660300002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?G2OoxDL+TPg0uluunj0pTx7QohY/t0ycktpR6dGij+G9u0GIT+NyT+PnfoiG?=
 =?us-ascii?Q?KxjWZyzUPoz/fluveHcWm4s8CXKKrt1RpaIGPbi1ySsZ+rauQOmmdYBmmzSk?=
 =?us-ascii?Q?z9SXpUTFRiFD57h7BkleHn5Dmga2HExmVWvczWjGK0RQzbpVpiVQ45wSbC03?=
 =?us-ascii?Q?mP4n3gjWWsN5ES91TgXXu+gMmjlCS1nfcgV/kCK08Oif6lVkERwCvonS867N?=
 =?us-ascii?Q?hU4CE7IBrmWE0Y8BSShDd4tEwTlAIZGJ1a2hdVreWdaiNP+DYmEWM152qZQt?=
 =?us-ascii?Q?h6UhNt8cGFzuFkBLO6UKkB9QY6BbN8fHr0Ar75ZAsXG7SdnlASenO19Obcum?=
 =?us-ascii?Q?9+yrxhg6lYj7ixh79aiok2pWvMZWkyyaEKrY9jupInQUHuRTNuIo0See1CfZ?=
 =?us-ascii?Q?uJ0vMncOyyTqiR/3NLqfxYvCGdon9+JvcHIfi5VJI1kFEle4Nki3Wpj/THYO?=
 =?us-ascii?Q?O1f6y09/3NSlmQ3qxevEYTMJ60me/KNkU9ftl62jGC517es1vr1VBvlhivzE?=
 =?us-ascii?Q?qnn753rqFlqlbN6z4U8LSARXoViLdjJSd7p8s528+76t2qBTZx1VWIDJgz0X?=
 =?us-ascii?Q?oxKqgxALtQ4Uq4u5AWNL0N1LWtpVkqggfc7Vxfj8u7trpGu+q156d4Jh5ab3?=
 =?us-ascii?Q?yOrL8ioMUR0PoRapUC/+bxsSTIGvuuCSbUlxEDHjGSFNubELnFdoBDTUlKnm?=
 =?us-ascii?Q?lL2NNvnid7NpLW2kZDDEN6DZNxd/xBW54KA65l9kjj+zUYajx7/UjIE84hUc?=
 =?us-ascii?Q?JL7YlorBx4KMaqHivLNN0yOgNgIkECrp00AaTu0ieJ4rftf0v3RLAPy/hCOG?=
 =?us-ascii?Q?ND4cdomgDuXDSlxDc1cPz4YTAyDqGshmWGSnhbprRGFz1GrKTMyaUX59UjVc?=
 =?us-ascii?Q?eGw/ZQubm5N94am+TXQspvaKSc6Nb1j+jJyPGOEaEDIRQueLV5pqC1v7z/Rf?=
 =?us-ascii?Q?qM71JUVPowvNJ6KlK6SNAP5wrS76RYekgNX78IGbwxY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2021 17:10:08.7296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-Network-Message-Id: 836c528a-5843-4467-b4ca-08d8b71cea31
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ap6DhSQNZ4M2vkPepR9zIAifEeSt4ShE+5OKdYGWnmSRDxSxqClLI3CdAJYRamqKyUkvjt2KpMBCwkLPLViFL3nBMpaYJoKCLa9lQV0iAc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4502
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=889 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101120100
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9862 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 clxscore=1011 impostorscore=0 spamscore=0 mlxscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101120100
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


Li,

> If the physical_block_size and io_min is less than a sector,

That's not supposed to happen. What device/driver is this?

-- 
Martin K. Petersen	Oracle Linux Engineering
