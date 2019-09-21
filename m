Return-Path: <SRS0=12de=XQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CAFC4360D
	for <linux-block@archiver.kernel.org>; Sat, 21 Sep 2019 22:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE8F621835
	for <linux-block@archiver.kernel.org>; Sat, 21 Sep 2019 22:05:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="gc91O/ON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbfIUWFt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 21 Sep 2019 18:05:49 -0400
Received: from mail-eopbgr60062.outbound.protection.outlook.com ([40.107.6.62]:51785
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725446AbfIUWFt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 21 Sep 2019 18:05:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AjWH1X0k+pweDWM18ze3EuxAQmn9m5jLtC+diboRzjSxgoEDyyMvFfQB6o+d/tQYcZu7qGQsN38EkV7kYEYIyiupqvx6uDl/jRZN20JsbgKW7TY/XidQUh0i3XDJxkAuM78Xtet6lyBgdwQv1xDwxStvNZrJFwifXyPPw53La32CBr8fD+0YzoS30RuoOanU4bvDKNr2zkoLzVrmRZNZ+IRhkn6ZydZGL7rlBSYLf6wJSMnO/JjLfd5CH1yDsUBwCRs2shl8sETcy9ukmPL6xAHB006H3lF6iiX9w4e0JCdbeDlHlKXjEJKNKl1XpRNMuaoboR/beFAQF4d3XkKJmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7G+CY4v2Tsx5+2zlWHgZFrzxFPhktBpYM3MXGImCgM=;
 b=kuBsXJmXejTeVzznywuQ88dYyWpVZiNdpl8US1P9lwvXpCRLrbys9DxyxoZcditTDQ4E2YMx3GSSy+246qb3EmjcmXcwwvQcWaHGBoxBKrWiC6QtxbupTOV1aXdvcJZWd6RP2Vcy1Cwgnuvk+Ti3ch0TQ+h3qJcFLGs14M3QdqLaPcdDJTIMPEGzG816V7vToq2o9OrDIliFZaXx/vgEFTZTJcv0RMJobbxSwfi1UuAYSNKnUJ1u7g1aN5xX/3z+czZlKRjikOIR7Wf9NsoLQ8eVqJ1vN3tPtNxcuvZMOyVCL5AMiCQSHT/b+WSpdBz9CH7k6fNFEk1YCMxYAKQMAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=googlegroups.com
 smtp.mailfrom=mellanox.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=mellanox.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o7G+CY4v2Tsx5+2zlWHgZFrzxFPhktBpYM3MXGImCgM=;
 b=gc91O/ONWp85ueTupu/Jbo6iBc37GkkFFWTIZCEo18hLuXUl+B6VPxV45/xbuQcNFVwHMv93xbOyA/14FoBQC927n3yGDJbGUemoZRgx7oZIo1Vu0iTogZq5mtVhkEykw5G96HpfOlE5n+95vz6ugCpDLYgtyYFdNc3JcKaGNUM=
Received: from AM6PR0502CA0029.eurprd05.prod.outlook.com (2603:10a6:209:1::42)
 by VI1PR0502MB3805.eurprd05.prod.outlook.com (2603:10a6:803:12::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20; Sat, 21 Sep
 2019 22:05:45 +0000
Received: from AM5EUR03FT062.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::207) by AM6PR0502CA0029.outlook.office365.com
 (2603:10a6:209:1::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.21 via Frontend
 Transport; Sat, 21 Sep 2019 22:05:45 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; googlegroups.com; dkim=none (message not signed)
 header.d=none;googlegroups.com; dmarc=pass action=none
 header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 AM5EUR03FT062.mail.protection.outlook.com (10.152.17.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2284.20 via Frontend Transport; Sat, 21 Sep 2019 22:05:45 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Sun, 22 Sep 2019 01:05:44
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Sun,
 22 Sep 2019 01:05:44 +0300
Received: from [172.16.0.37] (172.16.0.37) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Sun, 22 Sep 2019 01:05:42
 +0300
Subject: Re: [PATCH] block: t10-pi: fix -Wswitch warning
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
CC:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <clang-built-linux@googlegroups.com>
References: <20190919135725.1287963-1-arnd@arndb.de>
 <20190920060503.GA130425@archlinux-threadripper>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <f279edcb-1d54-2333-8aa1-1af8c91bbc95@mellanox.com>
Date:   Sun, 22 Sep 2019 01:05:42 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190920060503.GA130425@archlinux-threadripper>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [172.16.0.37]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(376002)(136003)(39850400004)(396003)(346002)(199004)(189003)(36756003)(70206006)(2906002)(26005)(53546011)(186003)(229853002)(31686004)(8936002)(16526019)(336012)(70586007)(478600001)(50466002)(6246003)(476003)(16576012)(126002)(486006)(86362001)(58126008)(316002)(4326008)(65806001)(36906005)(76176011)(65956001)(8676002)(2616005)(106002)(47776003)(81156014)(110136005)(446003)(11346002)(2486003)(3846002)(23676004)(7736002)(356004)(81166006)(5660300002)(305945005)(14444005)(54906003)(230700001)(31696002)(6116002)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0502MB3805;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d71de84-fbbd-4c2a-d365-08d73edfd9ff
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328)(7193020);SRVR:VI1PR0502MB3805;
X-MS-TrafficTypeDiagnostic: VI1PR0502MB3805:
X-Microsoft-Antispam-PRVS: <VI1PR0502MB38050C80216817798EB2CF4EB68B0@VI1PR0502MB3805.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0167DB5752
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: wYFzLXpJcVmKWS7QLcBftKvLWiAi/pgzYVEty14MeHXSJvltqWs/aP5Pg7Y5gHRsAXrnOj4UmSVbjpsyHcVbTrMgaZ9YtMb3IC28NvppeCuB4SH7QIqxLdUw4/9kwYxL3Uw+n1NPqkxH/s/ygkkD1kwwZQsln5JpsLoqbBkDHth6WdU1rpV1SmKAMeDGfqDs1tcLwr50F0ZekIqfLpWHsb16N6bXjNRGiy9C4ptndvRotTqXz9vJIcWZ+qThKB1seCjmXCkIEa5ZDpGLDh6rZYimn+1lMbvmzRJHcKmbDH6hok7lMBZw5ZoWQzrLO+T/nyfa2d77T6hfsrHQFFsJ8RWm0wwNX0dtYm1iONGJ9sGEtKfY2J9sC5l0LLdvSa1Q5AyTpkQZ4scNqmSHqEQ9akHCTNXD5v05mERoA07Cizs=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2019 22:05:45.0383
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d71de84-fbbd-4c2a-d365-08d73edfd9ff
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0502MB3805
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 9/20/2019 9:05 AM, Nathan Chancellor wrote:
> On Thu, Sep 19, 2019 at 03:57:19PM +0200, Arnd Bergmann wrote:
>> Changing the switch() statement to symbolic constants made
>> the compiler (at least clang-9, did not check gcc) notice that
>> there is one enum value that is not handled here:
>>
>> block/t10-pi.c:62:11: error: enumeration value 'T10_PI_TYPE0_PROTECTION' not handled in switch [-Werror,-Wswitch]
>>
>> Add another case for the missing value and do nothing there
>> based on the assumption that the code was working correctly
>> already.
>>
>> Fixes: 9b2061b1a262 ("block: use symbolic constants for t10_pi type")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>   block/t10-pi.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/block/t10-pi.c b/block/t10-pi.c
>> index 0c0120a672f9..055fac923946 100644
>> --- a/block/t10-pi.c
>> +++ b/block/t10-pi.c
>> @@ -60,6 +60,8 @@ static blk_status_t t10_pi_verify(struct blk_integrity_iter *iter,
>>   		__be16 csum;
>>   
>>   		switch (type) {
>> +		case T10_PI_TYPE0_PROTECTION:
>> +			break;
>>   		case T10_PI_TYPE1_PROTECTION:
>>   		case T10_PI_TYPE2_PROTECTION:
>>   			if (pi->app_tag == T10_PI_APP_ESCAPE)
>> -- 
>> 2.20.0
> I didn't have the break in my local patch but I think this is more
> correct based on the description of the enums. Like Nick pointed out,
> there is no functional change because this value is not used in this
> file.
>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

Hi,

we had a thread with Martin regarding this issue and we decided to set a 
default clause and add a BUG() in case we get there.

I've sent a patch with this fix.

-Max.

