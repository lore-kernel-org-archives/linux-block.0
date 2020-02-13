Return-Path: <SRS0=GmId=4B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DC9C352A3
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 20:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9E524650
	for <linux-block@archiver.kernel.org>; Thu, 13 Feb 2020 20:08:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="LaETPekx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728294AbgBMUIW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Feb 2020 15:08:22 -0500
Received: from mail-eopbgr80095.outbound.protection.outlook.com ([40.107.8.95]:49669
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728236AbgBMUIW (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Feb 2020 15:08:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h6Qrw3pwTHGup7Ze3r7Z65f3DimKBNi9EupESzMweKqB4U4iX6ddpTTitgcla8RX/jPG56aBAwg0KE9xTk91fpfBRFMb9UqvQrMC15FRWPFUG45OKxZnrOID3Yvti/RX4XAJXgs6E7xJ17OVl3xhslDgr4oVkLnEvEid0/08AlVKDZCmMhI7kg7zAwZxXSM5bWTaHB5glzhn90GyVq8Z3oMOsZTDrse/2HfKmiO0MewKnpM2h6x+PVYce+W68LTiT/ZCC+siNdop1p9m0A/R774MmN4GWziDWVoYt6xiZrhv9FexwOL1A9fv+875c87j5UOtCZsU7Pxxnn8ssdM8Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZSM8XMa67H24VUG0pAjveCWcZjFTkP79RtY4g/g51E=;
 b=GmCxDJ4IJ1PK49PmGVB3C/qcCyMdFjzs0Qt+enOms+pQj2gITqGkk6FZyPcASI/LdLSx8hfuzD/NZ6C7TUUoAk1p2IvUE7ViSvASdCZwcKja0RMBao0nGDuQzQiCWCwjgqWWvTHu1Dg8xF/7sH0LcimsAr0O9ZvkhHYyqFfMz6xeOTIm0iW3I76ZDJSFbU+I8AzDcd7psAECJ3MZsb+O53AJbxuaNgFKUMdTGTvGPE1WsD10buY06gkuul+VK62XwhA9b3d6Ry6+9EOutByslMSoNy6vfGeBto37ADR7ypFsh9hKXN5fj+eeIOC7YSD1UyVdGJOiMjHljZQWNl9Hsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oZSM8XMa67H24VUG0pAjveCWcZjFTkP79RtY4g/g51E=;
 b=LaETPekxjj7ngfvowJeaJN/LvzQSztBpx0EtwJvY0wIum6b8NxODl81txTMd5CAZr8/yxYm1JcnxrsZOtNXfeAdfXECcJ3PIadiWJcFz1RwaJ+COZfWx5DUcQ6wS1acDkWkX2Q45bcncbY/nadSGkXWj236f0RPNhFQBMvinrzM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=ktkhai@virtuozzo.com; 
Received: from DB7PR08MB3276.eurprd08.prod.outlook.com (52.135.128.26) by
 DB7PR08MB3387.eurprd08.prod.outlook.com (20.176.239.94) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Thu, 13 Feb 2020 20:08:18 +0000
Received: from DB7PR08MB3276.eurprd08.prod.outlook.com
 ([fe80::304f:d257:baf1:4d22]) by DB7PR08MB3276.eurprd08.prod.outlook.com
 ([fe80::304f:d257:baf1:4d22%4]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 20:08:18 +0000
Subject: Re: [PATCH v7 6/6] loop: Add support for REQ_ALLOCATE
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     martin.petersen@oracle.com, bob.liu@oracle.com, axboe@kernel.dk,
        agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        song@kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
        Chaitanya.Kulkarni@wdc.com, ming.lei@redhat.com, osandov@fb.com,
        jthumshirn@suse.de, minwoo.im.dev@gmail.com, damien.lemoal@wdc.com,
        andrea.parri@amarulasolutions.com, hare@suse.com, tj@kernel.org,
        ajay.joshi@wdc.com, sagi@grimberg.me, dsterba@suse.com,
        bvanassche@acm.org, dhowells@redhat.com, asml.silence@gmail.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <158157930219.111879.12072477040351921368.stgit@localhost.localdomain>
 <158157957565.111879.5952051034259419400.stgit@localhost.localdomain>
 <20200213181141.GT6874@magnolia>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <6e3081f5-9462-c6e8-2ab9-524dc3d0304c@virtuozzo.com>
Date:   Thu, 13 Feb 2020 23:07:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200213181141.GT6874@magnolia>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: HE1P190CA0023.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::33)
 To DB7PR08MB3276.eurprd08.prod.outlook.com (2603:10a6:5:21::26)
MIME-Version: 1.0
Received: from localhost.localdomain (176.14.212.145) by HE1P190CA0023.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25 via Frontend Transport; Thu, 13 Feb 2020 20:08:14 +0000
X-Originating-IP: [176.14.212.145]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d129ce7-93fd-4650-f0ff-08d7b0c0776e
X-MS-TrafficTypeDiagnostic: DB7PR08MB3387:
X-Microsoft-Antispam-PRVS: <DB7PR08MB338766E746A15D8B55E708DFCD1A0@DB7PR08MB3387.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39830400003)(366004)(136003)(396003)(189003)(199004)(8936002)(81166006)(6506007)(2906002)(6916009)(16526019)(8676002)(186003)(53546011)(6486002)(26005)(52116002)(81156014)(36756003)(6512007)(956004)(66556008)(478600001)(7416002)(66476007)(66946007)(316002)(4326008)(2616005)(31696002)(5660300002)(31686004)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB7PR08MB3387;H:DB7PR08MB3276.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DwJFGDxyl0MyXmNz/0g+szVR7l9zY+wC7mCRvFb+DAyASo7Pu80DWqhsY0sx3zrCnD5bDd17pT2gAkTuqCOu+JibDy0HBtJr62Vhmys9VkfFxMLqPZDMrrWCE25NmdQrdOMmWjhViGAA9PqD2WJqfNau9R/RTfgMJzyMBNuvXSX2awDymdanI7P1ErqhEiEYNOR9aiWqIQnQQloWAmi/H4+mmWt0TQVxykMRnvcg5skprlJWGdMdHBk+YdCs4DxU/mI3/Kd4tC0W0+vCROO+oqd11xIdeDh7lwo9YT5CK/7YxVIIt04Iu/DwAfHDxJg/MZlN89R3OAuB7Vv/Bq2RNAMhCYQc/Vuah1VCU9VFBQk/gjwlmianCr58fVBjvaVA58NfDjMCqOm2UTW3qJCvIvo/CG9ESJ8XAM9R3Lrrthk46AF7QLZIu6KAuUz/QnVn
X-MS-Exchange-AntiSpam-MessageData: 3u6WJWy96Drpuv4VqHVDRjeDzQ1/qNcGDiW4FZxOmRbaxlJ1pvFSyZKzZP36ufkrqMeZ4cUUJy3dNAWrP/nLWF2O0OzIvomD3UYmHfMzfDX1P9HyhydZ1OZi1dsJPJo/yXQC12POe36/id5TmqhrBg==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d129ce7-93fd-4650-f0ff-08d7b0c0776e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 20:08:18.3321
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AB3oqubc00LDjbpHNNx7TapAZfZT+4mfQGE02hvLXfMhBCC2vySSleJp4llmclXWa/9+5HCb8/DgQ6q6ct06eA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR08MB3387
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 13.02.2020 21:11, Darrick J. Wong wrote:
> On Thu, Feb 13, 2020 at 10:39:35AM +0300, Kirill Tkhai wrote:
>> Support for new modifier of REQ_OP_WRITE_ZEROES command.
>> This results in allocation extents in backing file instead
>> of actual blocks zeroing.
>>
>> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
>> Reviewed-by: Bob Liu <bob.liu@oracle.com>
>> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
>> ---
>>  drivers/block/loop.c |   20 +++++++++++++-------
>>  1 file changed, 13 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/block/loop.c b/drivers/block/loop.c
>> index 739b372a5112..0704167a5aaa 100644
>> --- a/drivers/block/loop.c
>> +++ b/drivers/block/loop.c
>> @@ -581,6 +581,16 @@ static int lo_rw_aio(struct loop_device *lo, struct loop_cmd *cmd,
>>  	return 0;
>>  }
>>  
> 
> Urgh, I meant "copy the comment directly to here", e.g.
> 
> /*
>  * Convert REQ_OP_WRITE_ZEROES modifiers into fallocate mode
>  *
>  * If the caller requires allocation, select that mode.  If the caller
>  * doesn't want deallocation, call zeroout to write zeroes the range.
>  * Otherwise, punch out the blocks.
>  */
> 
> The goal here is to reinforce the notion that FL_ZERO_RANGE is how we
> achieve nounmap zeroing...

The function is pretty small, and its meaning is easily seen from the name
and description.

I don't think we have to retell every function code line in a separate
sentence, since this distract the attention from really difficult places,
which are really need it.

Kirill
