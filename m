Return-Path: <SRS0=cenR=W7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D84C3A5A7
	for <linux-block@archiver.kernel.org>; Wed,  4 Sep 2019 08:32:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938BE20882
	for <linux-block@archiver.kernel.org>; Wed,  4 Sep 2019 08:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="GVSe+1Tc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfIDIc7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 4 Sep 2019 04:32:59 -0400
Received: from mail-eopbgr20054.outbound.protection.outlook.com ([40.107.2.54]:65184
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726486AbfIDIc6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 4 Sep 2019 04:32:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l13c4By8K4kXyiDWMtcvhl6nmTBeirxzD8bW3MCPVDfWhgGtl3wGLYp2/X/FpiqLAxCbUkNkiZhwBe8oMNJdHMgL2y9A7OPPsqp6rN7SEUD/NYvZZN0WajBaCj59MMugp/6MooC6h+wCTJS9IlrHAdlk7LLgvL9EvPi5rO8yiP1MWHFN5c3tVwPvMzbXhNxiy6YYK5fZpz+vYvvCoP1blNElEo1GXdJl/i0ry+iPSgJh/zb4KdPozrsJwXQc1NSjzAyVtIKl4/e7G3GfDmOPgfj4W2OrgfKJJ8Qo2qVMuep7NmMXFRnyZrJFMMx0Pa1Rty9J6PDcgs+a7AE/e0EV0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWxc9uFtqjRxJ8dfSACkllxnPOZIlUAKBGzU0q/QvhA=;
 b=UmLnNp54Rxstm6mkEGU0vYyV+0e6FObmZTi5deDwNwYdAjz+B+qhoXPcgip5Mq/nT6mOaMqbgik1KaaYxGNLjhZqjEIFsqqDE8+32IMJJ16iab6SRPD+qr8IIkHozkvRlUp0PVRyWtEatZP8fTqIL/FQWFCePGRaZB0IQoy+iGl9+RPUrNQEpx2ewE045OnTus0zywHueM63tR106N2Ift3JIIiUIL4UnvhY6MQxouULm6mIhm+VTh1l1TQ15ED8AcFC8KlNOI7vzLgkIldXsCWE0gqaDKLtjEHtvH5S5f8bFiCVd62iLGc+LtrDOAIekZXefM44AFmHXhuRriz7Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.47.165.251) smtp.rcpttodomain=intel.com smtp.mailfrom=mellanox.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=mellanox.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWxc9uFtqjRxJ8dfSACkllxnPOZIlUAKBGzU0q/QvhA=;
 b=GVSe+1TcvtmrNgjx/0RFyWc0vCI3V47+UK4lOYKJ4FTM7VdvOpR+WOmcpfIR1MgPWM2IBhokp209UQ4nKVYbPNHJ9rUQQT0ey8bnLvK0NMmPLA8uArmekn3smAinQVhoGDJ2moq3ZuHBbpcBjTJ6d1zLUkwc0Rg/2SKawROFClw=
Received: from HE1PR05CA0214.eurprd05.prod.outlook.com (2603:10a6:3:fa::14) by
 AM6PR05MB5379.eurprd05.prod.outlook.com (2603:10a6:20b:57::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Wed, 4 Sep 2019 08:32:53 +0000
Received: from DB5EUR03FT005.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::205) by HE1PR05CA0214.outlook.office365.com
 (2603:10a6:3:fa::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2241.13 via Frontend
 Transport; Wed, 4 Sep 2019 08:32:53 +0000
Authentication-Results: spf=pass (sender IP is 193.47.165.251)
 smtp.mailfrom=mellanox.com; intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=pass action=none header.from=mellanox.com;
Received-SPF: Pass (protection.outlook.com: domain of mellanox.com designates
 193.47.165.251 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.47.165.251; helo=mtlcas13.mtl.com;
Received: from mtlcas13.mtl.com (193.47.165.251) by
 DB5EUR03FT005.mail.protection.outlook.com (10.152.20.122) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2241.14 via Frontend Transport; Wed, 4 Sep 2019 08:32:52 +0000
Received: from MTLCAS13.mtl.com (10.0.8.78) by mtlcas13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4; Wed, 4 Sep 2019 11:32:50
 +0300
Received: from MTLCAS01.mtl.com (10.0.8.71) by MTLCAS13.mtl.com (10.0.8.78)
 with Microsoft SMTP Server (TLS) id 15.0.1178.4 via Frontend Transport; Wed,
 4 Sep 2019 11:32:50 +0300
Received: from [10.223.0.54] (10.223.0.54) by MTLCAS01.mtl.com (10.0.8.71)
 with Microsoft SMTP Server (TLS) id 14.3.468.0; Wed, 4 Sep 2019 11:32:04
 +0300
Subject: Re: [PATCH 1/4] block: centrelize PI remapping logic to the block
 layer
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Sagi Grimberg <sagi@grimberg.me>, <linux-block@vger.kernel.org>,
        <martin.petersen@oracle.com>, <linux-nvme@lists.infradead.org>,
        <keith.busch@intel.com>, <shlomin@mellanox.com>,
        <israelr@mellanox.com>
References: <1567523655-23989-1-git-send-email-maxg@mellanox.com>
 <8df57b71-9404-904d-7abd-587942814039@grimberg.me>
 <e9e36b41-f262-e825-15dc-aecadb44cf85@kernel.dk>
 <20190904054956.GA10553@lst.de>
From:   Max Gurtovoy <maxg@mellanox.com>
Message-ID: <fd70d115-bb29-a8a7-83ae-7e3dcaa1dc1c@mellanox.com>
Date:   Wed, 4 Sep 2019 11:32:04 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904054956.GA10553@lst.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.223.0.54]
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:193.47.165.251;IPV:NLI;CTRY:IL;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(396003)(376002)(346002)(2980300002)(199004)(189003)(26005)(2486003)(23676004)(76176011)(336012)(53546011)(2870700001)(107886003)(31686004)(36756003)(31696002)(5660300002)(7736002)(16526019)(478600001)(54906003)(70586007)(486006)(70206006)(476003)(106002)(126002)(50466002)(81166006)(81156014)(186003)(6246003)(316002)(2906002)(86362001)(16576012)(8676002)(14444005)(110136005)(2616005)(58126008)(4326008)(65806001)(65956001)(8936002)(47776003)(356004)(6116002)(305945005)(229853002)(53936002)(3846002)(11346002)(446003)(3940600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR05MB5379;H:mtlcas13.mtl.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9045fd05-c460-4558-8326-08d731127a86
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(4709080)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR05MB5379;
X-MS-TrafficTypeDiagnostic: AM6PR05MB5379:
X-Microsoft-Antispam-PRVS: <AM6PR05MB5379498047C0781FB4482078B6B80@AM6PR05MB5379.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0150F3F97D
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: XI6BN/GFCXntrsot5CTElFJxPeRpVxAEcstP5Q6c8NCLKwugvHJB8vAqgAQIwuizmlnN6e7G8iFyLg6+nxQIrQMH2UWeVqhbZFzDqfHd1cvMitmJ3qo9tS+LqeqI5Eh5rUf90svFZIAxRFACI1fZH/PD9bcgwKW93Tuz8CZsLaAjQAxCIQ368bSret8ro2ijGRULQq+TSg2iKLScmwXaKyD0JHoctLR3gtzXnIlQo+zNah8+Jdh2pQl48zI1Ibrw4ydxxHRv9pk85z33mbwEcjtb129qvt7qZaibAxW0ocv7lhOZSidDD+Av0vzhvlTUzBWjr0orPSPwG1I4jOTsWhrmz5GYTBzbTuhnP+Ar27Jo8OlIax9JfxyJhQnOY438+dQkMi6jKDUVGJtrIvctBWtQDgoGcYUsUZlDc7BWikc=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2019 08:32:52.8950
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9045fd05-c460-4558-8326-08d731127a86
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a652971c-7d2e-4d9b-a6a4-d149256f461b;Ip=[193.47.165.251];Helo=[mtlcas13.mtl.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR05MB5379
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On 9/4/2019 8:49 AM, Christoph Hellwig wrote:
> On Tue, Sep 03, 2019 at 01:21:59PM -0600, Jens Axboe wrote:
>> On 9/3/19 1:11 PM, Sagi Grimberg wrote:
>>>> +	if (blk_integrity_rq(req) && req_op(req) == REQ_OP_READ &&
>>>> +	    error == BLK_STS_OK)
>>>> +		t10_pi_complete(req,
>>>> +				nr_bytes / queue_logical_block_size(req->q));
>>>> +
>>> div in this path? better to use  >> ilog2(block_size).
>>>
>>> Also, would be better to have a wrapper in place like:
>>>
>>> static inline unsigned short blk_integrity_interval(struct request *rq)
>>> {
>>> 	return queue_logical_block_size(rq->q);
>>> }
>> If it's a hot path thing that matters, I'd strongly suggest to add
>> a queue block size shift instead.
> Make that a protection_interval_shift, please.  While that currently
> is the same as the logical block size the concepts are a little
> different, and that makes it clear.  Except for that this patch looks
> very nice to me, it is great to avoid having drivers to deal with the
> PI remapping.

Christoph,

I was thinking about the following addition to the code (combination of 
all the suggestions):


diff --git a/block/blk-core.c b/block/blk-core.c
index 58ecfd3..cef604c 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1409,7 +1409,7 @@ bool blk_update_request(struct request *req, 
blk_status_t error,
         if (blk_integrity_rq(req) && req_op(req) == REQ_OP_READ &&
             error == BLK_STS_OK)
                 t10_pi_complete(req,
-                               nr_bytes / 
queue_logical_block_size(req->q));
+                               nr_bytes >> 
queue_logical_block_shift(req->q));

         if (unlikely(error && !blk_rq_is_passthrough(req) &&
                      !(req->rq_flags & RQF_QUIET)))
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 2c18312..8183ffc 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -330,6 +330,7 @@ void blk_queue_max_segment_size(struct request_queue 
*q, unsigned int max_size)
  void blk_queue_logical_block_size(struct request_queue *q, unsigned 
short size)
  {
         q->limits.logical_block_size = size;
+       q->limits.logical_block_shift = ilog2(size);

         if (q->limits.physical_block_size < size)
                 q->limits.physical_block_size = size;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 1ef375d..4a0115e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -332,6 +332,7 @@ struct queue_limits {
         unsigned int            discard_alignment;

         unsigned short          logical_block_size;
+       unsigned short          logical_block_shift;
         unsigned short          max_segments;
         unsigned short          max_integrity_segments;
         unsigned short          max_discard_segments;
@@ -1267,6 +1268,16 @@ static inline unsigned int 
queue_max_segment_size(struct request_queue *q)
         return q->limits.max_segment_size;
  }

+static inline unsigned short queue_logical_block_shift(struct 
request_queue *q)
+{
+       unsigned short retval = 9;
+
+       if (q && q->limits.logical_block_shift)
+               retval = q->limits.logical_block_shift;
+
+       return retval;
+}
+
  static inline unsigned short queue_logical_block_size(struct 
request_queue *q)


