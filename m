Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F4D0C433ED
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 19:35:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ACE161289
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 19:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239472AbhELT1Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 15:27:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:44562 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237832AbhELR4g (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 13:56:36 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 87A0AB20B;
        Wed, 12 May 2021 17:55:26 +0000 (UTC)
Subject: Re: [PATCH v1 8/8] block: add add_disk() failure injection support
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Akinobu Mita <akinobu.mita@gmail.com>
Cc:     axboe@kernel.dk, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210512064629.13899-1-mcgrof@kernel.org>
 <20210512064629.13899-9-mcgrof@kernel.org>
 <e938c21f-3872-232c-4956-dfa53aec579b@suse.de>
 <20210512165639.GB4332@42.do-not-panic.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <989175a7-5533-02ef-c096-b24b2769c9cf@suse.de>
Date:   Wed, 12 May 2021 19:55:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210512165639.GB4332@42.do-not-panic.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/12/21 6:56 PM, Luis Chamberlain wrote:
> On Wed, May 12, 2021 at 05:22:48PM +0200, Hannes Reinecke wrote:
[ .. ]
>> So I'd rather delegate the topic of error injection to a more general
>> discussion (LSF springs to mind ...), and then agree on a framework which is
>> suitable for every function.
> 
> Or we just get cranking and produce proof of concepts to compare and
> contrast later. At least I hope this patch and the respective blktests
> patches suffice to help demo what we need to test.
> 
Yeah; I know; 'tis a hard topic.
(Will we have another ALPSS this year? Would be ideal to discuss things 
there. Christoph?)

What I would love to see is to facilitate kernel live patching for 
testing, blanking out the function body under test and just return 
specific error codes.
That would be _ideal_ for testing, as we don't have to modify the kernel 
at all, we just need to compile it with the appropriate compiler options 
for live patching.
And then we should be able compile modules for the functions to test, 
load the module, do the test, remove the module, and everything would be 
back to normal again.

I know, but one can dream ...

But maybe I can trick you in trying it ... hmm?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
