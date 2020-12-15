Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E78EC4361B
	for <linux-block@archiver.kernel.org>; Tue, 15 Dec 2020 07:42:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B4E1222B3
	for <linux-block@archiver.kernel.org>; Tue, 15 Dec 2020 07:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgLOHly (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 15 Dec 2020 02:41:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:43798 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726266AbgLOHlu (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 15 Dec 2020 02:41:50 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BA42AAD0E;
        Tue, 15 Dec 2020 07:41:08 +0000 (UTC)
Subject: Re: [PATCH 0/3] block: blk_interposer - Block Layer Interposer
To:     Bob Liu <bob.liu@oracle.com>, Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@redhat.com>,
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
 <cdc3c792-17ac-de61-12ae-74691769fc3c@oracle.com>
From:   Hannes Reinecke <hare@suse.de>
Message-ID: <299962c3-c52b-a580-5b1f-a21b9021f9e6@suse.de>
Date:   Tue, 15 Dec 2020 08:41:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <cdc3c792-17ac-de61-12ae-74691769fc3c@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/15/20 7:51 AM, Bob Liu wrote:
> Hi Folks,
> 
> On 12/12/20 12:56 AM, Hannes Reinecke wrote:
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
>> I'll be working with the Veeam folks to present a joint patchset (including the DM bits) for the next round.
>>
> 
> Besides the dm approach, do you think Veeam's original requirement is a good
> use case of "block/bpf: add eBPF based block layer IO filtering"?
> https://lwn.net/ml/bpf/20200812163305.545447-1-leah.rumancik@gmail.com/
> 
That would actually a really cool use-case.
You could also consider a XDP-like functionality for eBPF, to move 
individual requests from one queue to the other; DM on steroids :-)

Should I try to include that patchset?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                Kernel Storage Architect
hare@suse.de                              +49 911 74053 688
SUSE Software Solutions GmbH, Maxfeldstr. 5, 90409 Nürnberg
HRB 36809 (AG Nürnberg), Geschäftsführer: Felix Imendörffer
