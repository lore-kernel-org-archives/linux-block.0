Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33B1C433DB
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 16:25:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B10D8619B8
	for <linux-block@archiver.kernel.org>; Tue, 23 Mar 2021 16:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbhCWQZO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Mar 2021 12:25:14 -0400
Received: from mail-bn7nam10on2064.outbound.protection.outlook.com ([40.107.92.64]:2272
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233298AbhCWQZL (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Mar 2021 12:25:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h4HWY6wvhpuH1/ZAqAclAyf7c/NO4PcsLoP/VpRjYgV8yaDKHS7fDt0j2Q5xwWzWdyiKTgdZDCXq4xH2RRrVcSf/j9YWLu65Mdd7q3BCz8xBUPXCVPs9O+ra/xdLb3DmtnVKSwuIT0r91ZGtWlHA/5NgYlOuKQbq98ApVKG4qUgWwGyrnSMkHGp+Y+srLGvxMDY4Yw4pLggRrS02qVQBRLcbgjAvR5RUrMbxc+QjrUa0in/sb8XQdgq2dT9WZWQyxsADNE4uwdNdmBrzHglIxPoXHng2yEQPaUZFvy5CSQMglSJrnqW9+t23B0i62Vd7aFDTmnoDNyNZkWligLY7Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ug8FNK4okKR6BkHxKhe/sI8UVRlH73dCnLvvxS6yOXo=;
 b=fGRO7OsN853/LIqFBep2FgNu80okpZCjxF7G4KTvaKiTyaKZVjs8xwfkw94EidoNJRVMlns2L4Md8xCIntwvWUyoLKtXC6MOSGxqll+x23XncS7D2VQDrftTYhhR0K+Aiz25xCeQZ6m806GhlkDqK5H0kzTxYPZMInjdzeoOxootUL4mZ5tJHUXF9OegfuC16AxxwjxUcoTFOARVYW0sypIIuIjy0qLHm10eKX6Qhg1UTrvstaL+v5n4aEdYvglAgtfruR9zofFLi115PYO9BeKxCaWZvJ3sopCOtHw4eVE6EAbiQ6p/84RauJeU6pzl5k641Mc8Iorb84oX+T61PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=lists.ozlabs.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ug8FNK4okKR6BkHxKhe/sI8UVRlH73dCnLvvxS6yOXo=;
 b=ciKftxYfqgy7Bnlq3v2MGfQDAw1ERjqa5B8E6KSM+euSHe07vzR8jOmoraH7zZHhf/FRTzfJuuMP+LDEqRQOMV1fBSxqJ9xXc6lBnrRJXWpD4gu+8K46JUe5XaEec+JlarIr+mPNcDkdsPQOtwbf8UlgLOSKx5Bkg6PDczZ0eo8=
Received: from SA0PR13CA0001.namprd13.prod.outlook.com (2603:10b6:806:130::6)
 by SN6PR02MB5229.namprd02.prod.outlook.com (2603:10b6:805:76::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Tue, 23 Mar
 2021 16:25:08 +0000
Received: from SN1NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:130:cafe::35) by SA0PR13CA0001.outlook.office365.com
 (2603:10b6:806:130::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.10 via Frontend
 Transport; Tue, 23 Mar 2021 16:25:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; lists.ozlabs.org; dkim=none (message not signed)
 header.d=none;lists.ozlabs.org; dmarc=pass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT011.mail.protection.outlook.com (10.152.72.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.24 via Frontend Transport; Tue, 23 Mar 2021 16:25:07 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 09:25:06 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 23 Mar 2021 09:25:06 -0700
Envelope-to: git@xilinx.com,
 linuxppc-dev@lists.ozlabs.org,
 linux-block@vger.kernel.org,
 devicetree@vger.kernel.org,
 yuehaibing@huawei.com,
 robh+dt@kernel.org,
 paulus@samba.org,
 mpe@ellerman.id.au,
 chris.packham@alliedtelesis.co.nz,
 benh@kernel.crashing.org,
 monstr@monstr.eu,
 linux-kernel@vger.kernel.org,
 dave@stgolabs.net,
 axboe@kernel.dk
Received: from [172.30.17.109] (port=49726)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <michal.simek@xilinx.com>)
        id 1lOjq5-00039S-8J; Tue, 23 Mar 2021 09:25:05 -0700
Subject: Re: [PATCH] xsysace: Remove SYSACE driver
To:     Jens Axboe <axboe@kernel.dk>, Davidlohr Bueso <dave@stgolabs.net>,
        "Michal Simek" <michal.simek@xilinx.com>
CC:     <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
        <git@xilinx.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Rob Herring <robh+dt@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>, <devicetree@vger.kernel.org>,
        <linux-block@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
References: <ee1fe969905f641f5f97d812ee0cac44c12fe0f6.1604919578.git.michal.simek@xilinx.com>
 <20210323000436.qm5rkiplwt5x5ttk@offworld>
 <6948510c-dc7e-d74a-62e3-e42be14cff16@kernel.dk>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <9c4911e6-92dc-0a0f-2f81-7d23e268144f@xilinx.com>
Date:   Tue, 23 Mar 2021 17:25:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <6948510c-dc7e-d74a-62e3-e42be14cff16@kernel.dk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 053ae622-563a-4bdb-ec36-08d8ee18392b
X-MS-TrafficTypeDiagnostic: SN6PR02MB5229:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Antispam-PRVS: <SN6PR02MB5229FA80884256C72EA1B370C6649@SN6PR02MB5229.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qm52a0CKOUjuG83i8WBNm+lMD5W63fv2IIK7vyurNoJ8C1m6yPKv74lTHqUJwwofPh86hL7eOJk2EUBhpNNqH7+SyJFdzwCsj5WeEhN9RqEUhnSeZpzh25Xflbmpk9IDTpT17IhShyk6BhvR9JTdcwQAk0Tbm6jTeHsP4vQph4Sfc+6fJfx4DRXROZboyckkDICmsv8zr637xh/FobFfmE7OK/i/kRyjwUjVR57jk7Guf0B+pzBGvUKXXJfrEwvuGGhF20S3mVtala+itVanIZw2QgcQfUP8hug6Dil/2wTE2SpYrddr6rPUY1zv9xIzAP/WHwIiuJqK06PMM7NmRIPtss9ump2u1UHOcl073gS/+mksXOiIIzJ+n5uMvGKJVGTaTwYBMtGzJf5LTom8LHVg4QTgDkQQcT7ctC4ynABkIv/ixdCBeaOGT1510wvPDiTkEyQTCRjgsCNhLfmf8t6B8Z4yYxXQNF9prp+ByMRjr8tq6YhM+SjAzuhvVHF+Ej+1wh+1H7cDr1uuxGHnIUdLhvK1PTDrjt2EgVzsNLgvamklfMJdQIcMLFIiQY8R0qsG4uY+Ynrrpw7CDZN4Oc3ve+7FN9N+qEITHRfCFDBrPG9CmHdLNmBQ7N+Zvn5kVe+bwX/qItR9QlnmvvSqkCwzvotNTHS5hzQZc6WRXzmcPtZroal4bMsHkWF2hDJdMfg/He2ak/hnbVDxN+ww9A==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39850400004)(376002)(346002)(396003)(136003)(36840700001)(46966006)(336012)(70586007)(36756003)(6666004)(36860700001)(9786002)(31696002)(426003)(47076005)(478600001)(82740400003)(2616005)(54906003)(7416002)(7636003)(186003)(36906005)(82310400003)(316002)(31686004)(2906002)(5660300002)(4326008)(70206006)(26005)(8676002)(8936002)(53546011)(356005)(44832011)(110136005)(4744005)(50156003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2021 16:25:07.7921
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 053ae622-563a-4bdb-ec36-08d8ee18392b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT011.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5229
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org



On 3/23/21 5:23 PM, Jens Axboe wrote:
> On 3/22/21 6:04 PM, Davidlohr Bueso wrote:
>> Hi,
>>
>> On Mon, 09 Nov 2020, Michal Simek wrote:
>>
>>> Sysace IP is no longer used on Xilinx PowerPC 405/440 and Microblaze
>>> systems. The driver is not regularly tested and very likely not working for
>>> quite a long time that's why remove it.
>>
>> Is there a reason this patch was never merged? can the driver be
>> removed? I ran into this as a potential tasklet user that can be
>> replaced/removed.
> 
> I'd be happy to merge it for 5.13.
> 

Can you just take this version? Or do you want me to send it again?

Thanks,
Michal
