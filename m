Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE51C433ED
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 08:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60A9F61040
	for <linux-block@archiver.kernel.org>; Tue,  6 Apr 2021 08:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhDFIQ3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 6 Apr 2021 04:16:29 -0400
Received: from mail-eopbgr750071.outbound.protection.outlook.com ([40.107.75.71]:26845
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232041AbhDFIQ1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 6 Apr 2021 04:16:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C0C6pQdjT6yjYHkMONwNyTEQ77LdqC96AM23zlwMH548jNlWKgOWjIhI0o7608OgzaVsMai/wHi04bpHPj24D4ZNcKkW6LZQuQ+dV2XtwJ9PcSSe+8N8NauhhlAIktrI780oO9pucDfMqt7dLeeevP76e/TZTvDB5muLuquGx/QSzP8ouIDrZqLTPVntTW1AI6yGBytT3uSTcV2nBakEmfsowHhm68cLyuon+rAVJ/iqGVpF1a6yHVh0gKKYGUFgKD60oT4LlDGSd/WV5apAhzpLzNujzTudVugusc5amlJLgi62DC9jwLneFG/Zhq/w/qPmbUUqzoY16mc/vJKjNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yg0W5Gk3IuQbwlMwWWfFhilvMlmcx4pYLo28fp2IVOg=;
 b=bxqOtBeIC1bk7F5634ZD2pJznM1iJpsEnSmXgYUpAFrnUgXDs9buFZzC6IgPCCpf2zNhUfT0KyheClnzdqnysz2VyTIAcvllmtKYUoTmyc1cYxB0brxNvALAyqLGm9geiPKi35w8SV/P5DLiP6NjyjKGtjuNAjavJhWgDhlbmwAGrQmSlR0cnq6iEtecUQzUdJ39/EsHrsS2qKgT5GfDVkAoQzu0NtrFZTqoKPX1eN0/SQckB5z5guzixeyJku9ehfHka5dWLZrY3pPTKNAYE/AlBN9y0EmvW4oeZya3iYe+LywS+LPyncmlAB1TJs38wXe8QjvovVmRnhX2Gep0qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yg0W5Gk3IuQbwlMwWWfFhilvMlmcx4pYLo28fp2IVOg=;
 b=K9Z9+ZOWk/Sge0tZmcLCkiraB9KW3M8U31JYWl3uO5AT0z1YsOQpqVsXvsO25fCO72oO1ZC/5OoZEMIFw5fwJte0BbkOndDsxZt4qiX/CwS+dlIQltLZco7PiVtqrClb8xuT8Buiio3xH6g9ef8oVfx58q9JHC+YAKC7DKYcGLuhXlVpb1HW/s2Jk1RDCL/ZzVBx+kjWjz1uut1Wy5vFPc8khTdjXHbTvUuOO3IYHC52S5b9MCN6L2rD8MTiA9gLFv1wBqx5r/f3LVC8R90waSQLIQj3urPsflNGTjeOzx124hA2aWWfoYBqV8VH4ZDRnV3XHPRy5AUV0Ms3YL01yA==
Received: from BN9PR03CA0920.namprd03.prod.outlook.com (2603:10b6:408:107::25)
 by BYAPR12MB2664.namprd12.prod.outlook.com (2603:10b6:a03:69::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Tue, 6 Apr
 2021 08:16:18 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::d5) by BN9PR03CA0920.outlook.office365.com
 (2603:10b6:408:107::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend
 Transport; Tue, 6 Apr 2021 08:16:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3999.28 via Frontend Transport; Tue, 6 Apr 2021 08:16:17 +0000
Received: from [172.27.15.146] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 6 Apr
 2021 08:16:15 +0000
Subject: Re: [PATCH 1/1] block: add sysfs entry for virt boundary mask
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     <linux-block@vger.kernel.org>, <axboe@kernel.dk>
References: <20210405132012.12504-1-mgurtovoy@nvidia.com>
 <yq1v990ch7g.fsf@ca-mkp.ca.oracle.com>
From:   Max Gurtovoy <mgurtovoy@nvidia.com>
Message-ID: <c2c9444f-69cf-6af7-453d-2a053d56a049@nvidia.com>
Date:   Tue, 6 Apr 2021 11:16:11 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <yq1v990ch7g.fsf@ca-mkp.ca.oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5d4721c-7c3d-4fd0-e5d2-08d8f8d440ec
X-MS-TrafficTypeDiagnostic: BYAPR12MB2664:
X-Microsoft-Antispam-PRVS: <BYAPR12MB2664FBFE903C26D6538706B9DE769@BYAPR12MB2664.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +4o2juqe9skk6P9eeaWe6BJV3rD1/oT46j5qxqGSDYdntQHxFMn7Fph4KkGbD8/4ixk6qDULSLdRArMelilpjeOhAoXx20AG6GhHqHTOx6VinTlI2IB91hdNsyygQwo1OrzlzRi3oVEW97Yyr06diK+4FjgStTZk7SqTupRh6WVb/3pLr/AM/+UwtlrwE6Bebwvj6H8mLBQpGECqz3MmNCUsnIudqDHzcQoN6xY53BGhQKuazx6b1XSBMUOaulir74LVt8DmrSwz9Bj7jJGqBDn4N3ffCVxUoa7qLPC4j8q2/B75HPq8PHh4MwuFVaH0YNt8J9uDDOFSpVDn1y8WQDi0o1xWRyeaWKvf6c+oRqiYKkmCcv3vpfqQdevGjntEIzXr6tmpCyJ+3xQIEKRISpmKFoBXrHnCS3W0Rs0lmjxbYvEFlOmPT2wfSAJxCF6JMf18yMbxU/8IDJVDfXGBg6H3faBtMA9BckhDzpeiepjNRDa45ILvZZ2G4jP8SapmRJKJgwq3o8kJp5gb7A85rHFEP/ufxoX0yZLCK6XuN3OucTMKJFRb2j2z8FlIFLzUTfwYT+LwjCEEe6Ko9KVZc62XwnC26tqcklrCeLUXldVNJTF/ioKl91h+Rd4L+/vXTvEtYeekYjXRE2++kZBA33Uy6eha/lYm7smZWN14xHDjvEQwR9ApVC/6wSTj3xCg
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(136003)(376002)(346002)(46966006)(36840700001)(6916009)(54906003)(2616005)(36756003)(83380400001)(4744005)(478600001)(53546011)(31696002)(82310400003)(5660300002)(8676002)(70586007)(70206006)(82740400003)(4326008)(26005)(426003)(6666004)(36906005)(86362001)(8936002)(7636003)(31686004)(186003)(36860700001)(2906002)(47076005)(356005)(316002)(16576012)(336012)(16526019)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2021 08:16:17.6319
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5d4721c-7c3d-4fd0-e5d2-08d8f8d440ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2664
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 4/6/2021 4:53 AM, Martin K. Petersen wrote:
> Max,
>
>> This entry will expose the bio vector alignment mask for a specific
>> block device.
> Looks fine except for the (page) that Chaitanya also pointed out.

thanks for the review. In blk-sysfs.c we see both "(page) or page". I'm 
fine with Both.

Jens, can this be fixed during the merge to the preferred option please ?


>
> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
>
