Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD292C65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 20:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1FB2087F
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 20:13:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A1FB2087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbeLMUNb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 15:13:31 -0500
Received: from verein.lst.de ([213.95.11.211]:43052 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbeLMUNb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 15:13:31 -0500
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 53AF068DD6; Thu, 13 Dec 2018 21:13:30 +0100 (CET)
Date:   Thu, 13 Dec 2018 21:13:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Keith Busch <keith.busch@intel.com>,
        linux-rdma@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH v2 6/6] nvme-multipath: disable polling for underlying
 namespace request queue
Message-ID: <20181213201330.GD15478@lst.de>
References: <20181213063819.13614-1-sagi@grimberg.me> <20181213063819.13614-7-sagi@grimberg.me> <20181213083157.GD869@lst.de> <4f3f213e-9042-5963-d47d-0ee501bf94fa@grimberg.me> <20181213155235.GA10566@lst.de> <0c5c172f-9b34-3cba-37ab-a39ad9351da5@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c5c172f-9b34-3cba-37ab-a39ad9351da5@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 13, 2018 at 08:14:57AM -0800, Sagi Grimberg wrote:
>>>> +	if (!test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
>>>> +		bio->bi_opf &= ~REQ_HIPRI;
>>>> +
>>>
>>> Maybe we can simply check (q->queue_flags & (1 << QUEUE_FLAG_POLL)) and
>>> avoid the extra atomic operation in the host path?
>>>
>>> Would it make sense?
>>
>> test_bit is not usually implemented as an atomic operation.
>>
>> Take a look at e.g.
>>
>> arch/x86/include/asm/bitops.h:constant_test_bit()
>
> Ah.. But its still read from volatile argument so still more expensive?

I don't think the volatile should make a difference.  I actually
compiled both versions and the test_bit version generates a movq + testl
insted of testb:

-	movq	120(%rbx), %rdx	# MEM[(const long unsigned int *)q_38 + 120B], _135
-	testl	$524288, %edx	#, _135
+	testb	$8, 122(%rbx)	#, q_40->queue_flags

But actually generates a larger object:

 36966	   9470	     88	  46524	   b5bc	blk-core.o-opencode
 36956	   9470	     88	  46514	   b5b2	blk-core.o-test-bit

No idea what is going there.
