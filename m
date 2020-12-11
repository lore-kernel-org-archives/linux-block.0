Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59EFC4361B
	for <linux-block@archiver.kernel.org>; Fri, 11 Dec 2020 19:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67A7223D5A
	for <linux-block@archiver.kernel.org>; Fri, 11 Dec 2020 19:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391464AbgLKSE1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 11 Dec 2020 13:04:27 -0500
Received: from mx2.suse.de ([195.135.220.15]:45346 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390628AbgLKSET (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 11 Dec 2020 13:04:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C087DAE4A;
        Fri, 11 Dec 2020 18:03:37 +0000 (UTC)
Subject: Re: [PATCH 0/3] block: blk_interposer - Block Layer Interposer
To:     Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@redhat.com>,
        Sergei Shtepa <sergei.shtepa@veeam.com>, hch@lst.de
Cc:     "johannes.thumshirn@wdc.com" <johannes.thumshirn@wdc.com>,
        "koct9i@gmail.com" <koct9i@gmail.com>,
        "ming.lei@redhat.com" <ming.lei@redhat.com>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "steve@sk2.org" <steve@sk2.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pavel Tide <Pavel.TIde@veeam.com>, dm-devel@redhat.com
References: <1607518911-30692-1-git-send-email-sergei.shtepa@veeam.com>
 <20201209135148.GA32720@redhat.com> <20201210145814.GA31521@veeam.com>
 <20201210163222.GB10239@redhat.com> <20201211163049.GC16168@redhat.com>
 <1ee7652e-b77f-6fa4-634c-ff6639037321@kernel.dk>
 <208edf35-ecdc-2d73-4c48-0424943a78c0@suse.de>
 <06b4a10d-5ea5-27e1-af0d-83d5c714996f@kernel.dk>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <b4f3ee74-58fd-52c8-ae60-f352758fb42a@suse.de>
Date:   Fri, 11 Dec 2020 19:03:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <06b4a10d-5ea5-27e1-af0d-83d5c714996f@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/11/20 6:04 PM, Jens Axboe wrote:
> On 12/11/20 9:56 AM, Hannes Reinecke wrote:
>> On 12/11/20 5:33 PM, Jens Axboe wrote:
>>> On 12/11/20 9:30 AM, Mike Snitzer wrote:
>>>> While I still think there needs to be a proper _upstream_ consumer of
>>>> blk_interposer as a condition of it going in.. I'll let others make the
>>>> call.
>>>
>>> That's an unequivocal rule.
>>>
>>>> As such, I'll defer to Jens, Christoph and others on whether your
>>>> minimalist blk_interposer hook is acceptable in the near-term.
>>>
>>> I don't think so, we don't do short term bandaids just to plan on
>>> ripping that out when the real functionality is there. IMHO, the dm
>>> approach is the way to go - it provides exactly the functionality that
>>> is needed in an appropriate way, instead of hacking some "interposer"
>>> into the core block layer.
>>>
>> Which is my plan, too.
>>
>> I'll be working with the Veeam folks to present a joint patchset
>> (including the DM bits) for the next round.
> 
> Just to be clear, core block additions for something that dm will
> consume is obviously fine. Adding this as block layer functionality than
> then exposes an application API for setting it up, tearing down, etc -
> that is definitely NOT
> 
That was never my intention.
Any consumers of this thing would need to be in-kernel.
If that was your concern.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
