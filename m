Return-Path: <SRS0=4lGM=Q3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E212C43381
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 23:23:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 655AD2147A
	for <linux-block@archiver.kernel.org>; Wed, 20 Feb 2019 23:23:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbfBTXXy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 20 Feb 2019 18:23:54 -0500
Received: from mx2.cyber.ee ([193.40.6.72]:43581 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbfBTXXy (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 20 Feb 2019 18:23:54 -0500
Subject: Re: ext4 corruption on alpha with 4.20.0-09062-gd8372ba8ce28
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, linux-alpha@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, linux-block@vger.kernel.org,
        linux-mm@kvack.org
References: <fb63a4d0-d124-21c8-7395-90b34b57c85a@linux.ee>
 <1c26eab4-3277-9066-5dce-6734ca9abb96@linux.ee>
 <076b8b72-fab0-ea98-f32f-f48949585f9d@linux.ee>
 <20190216174536.GC23000@mit.edu>
 <e175b885-082a-97c1-a0be-999040a06443@linux.ee>
 <20190218120209.GC20919@quack2.suse.cz>
 <4e015688-8633-d1a0-308b-ba2a78600544@linux.ee>
 <20190219132026.GA28293@quack2.suse.cz>
 <20190219144454.GB12668@bombadil.infradead.org>
 <d444f653-9b99-5e9b-3b47-97f824c29b0e@linux.ee>
 <20190220094813.GA27474@quack2.suse.cz>
From:   Meelis Roos <mroos@linux.ee>
Message-ID: <2381c264-92f5-db43-b6a5-8e00bd881fef@linux.ee>
Date:   Thu, 21 Feb 2019 01:23:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190220094813.GA27474@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

>> First, I found out that both the problematic alphas had memory compaction and
>> page migration and bounce buffers turned on, and working alphas had them off.
>>
>> Next, turing off these options makes the problematic alphas work.
> 
> OK, thanks for testing! Can you narrow down whether the problem is due to
> CONFIG_BOUNCE or CONFIG_MIGRATION + CONFIG_COMPACTION? These are two
> completely different things so knowing where to look will help. Thanks!

Tested both.

Just CONFIG_MIGRATION + CONFIG_COMPACTION breaks the alpha.
Just CONFIG_BOUNCE has no effect in 5 tries.

-- 
Meelis Roos
