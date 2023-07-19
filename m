Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05556EB64DA
	for <linux-block@archiver.kernel.org>; Wed, 19 Jul 2023 09:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjGSJ63 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 19 Jul 2023 05:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjGSJ6Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 19 Jul 2023 05:58:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D503EC
        for <linux-block@vger.kernel.org>; Wed, 19 Jul 2023 02:58:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EACBB61361
        for <linux-block@vger.kernel.org>; Wed, 19 Jul 2023 09:58:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9205DC433C9;
        Wed, 19 Jul 2023 09:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689760703;
        bh=LNaU7AsCWhM7fjN460KnXXlK9YWtQtGTOH9hZWQGGl4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Ww3lOhXLL0U3enCbhdgJFjUATW/04UmGHgL3aJdIuybkvl7R00unaWdK7NpjGcd/B
         T/L5iYW1F0BXO8JDFq72zBI+j5JNFXDz08YFQp7SdWhdoOm0o4fj6NpSeDBboAsQ1D
         MdZZ3pMjoTCSWF52zuNcoATy9/P2iCSmM+rknPrt6Pf6PhRkTm3yjHHkWY/yCzTWZi
         qi/xXU4COqeIiCqtEQoBVeprE2bCWITDSGcPayPcI7xR7Ej2p3HbGrUyS71ZPASnpj
         c2ORD/WEEY1d1kYLjBIskLNTZjJAKJeSYQic9+nuWW9I1Ob/NL7PgwSmZdHk12VBMk
         Do6puPkkz8L/A==
Message-ID: <83a90168-bd06-9247-bada-d4889ba4aece@kernel.org>
Date:   Wed, 19 Jul 2023 18:58:21 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/5] block: Introduce a request queue flag for
 pipelining zoned writes
Content-Language: en-US
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <20230710180210.1582299-1-bvanassche@acm.org>
 <20230710180210.1582299-2-bvanassche@acm.org>
 <9feab737-acb6-9e03-effb-8b130fdfa12a@kernel.org>
 <e1af3db6-0614-d0f2-a8c4-eb2a1de82e85@acm.org>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <e1af3db6-0614-d0f2-a8c4-eb2a1de82e85@acm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/19/23 07:37, Bart Van Assche wrote:
> On 7/17/23 23:34, Damien Le Moal wrote:
>> On 7/11/23 03:01, Bart Van Assche wrote:
>>> +/* Writes for sequential write required zones may be pipelined. */
>>> +#define QUEUE_FLAG_PIPELINE_ZONED_WRITES 8
>>
>> I am not a big fan of this name as "pipeline" does not necessarily
>> imply "high
>> queue depth write". What about simply calling this
>> QUEUE_FLAG_NO_ZONE_WRITE_LOCK, indicating that there is no need to
>> write-lock
>> zones ?
> 
> Hi Damien,
> 
> I'm not a big fan of names with negative words like "no" or "not" embedded.
> Isn't pipelining standard computer science terminology? See also
> https://en.wikipedia.org/wiki/Pipeline_(computing).

Sure, pipeline is a well known term. But I do not think it is synonymous
with "high queue depth write" :) A "pipeline" for zoned write may still
operate at write qd=1 per zone...

Given that the default is using zone write locking, I would prefer a
flag name that indicates a change to this default. What about something
like QUEUE_FLAG_UNRESTRICTED_ZONE_WRITE ?

But tht is beside the point as I still have reservations on this
approach anyway. See my reply to patch 4.

-- 
Damien Le Moal
Western Digital Research

