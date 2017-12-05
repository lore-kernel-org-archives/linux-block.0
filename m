Return-Path: <linux-block-owner@vger.kernel.org>
Received: from LGEAMRELO11.lge.com ([156.147.23.51]:41934 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751325AbdLEGTt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Dec 2017 01:19:49 -0500
Subject: Re: [PATCH v2 0/4] lockdep/crossrelease: Apply crossrelease to page
 locks
From: Byungchul Park <byungchul.park@lge.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: peterz@infradead.org, mingo@kernel.org, akpm@linux-foundation.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-block@vger.kernel.org,
        kernel-team@lge.com, jack@suse.cz, jlayton@redhat.com,
        viro@zeniv.linux.org.uk, hannes@cmpxchg.org, npiggin@gmail.com,
        rgoldwyn@suse.com, vbabka@suse.cz, mhocko@suse.com,
        pombredanne@nexb.com, vinmenon@codeaurora.org,
        gregkh@linuxfoundation.org
References: <1512364583-26070-1-git-send-email-byungchul.park@lge.com>
 <20171205053023.GB20757@bombadil.infradead.org>
 <0aad02e4-f477-1ee3-471a-3e1371ebba1e@lge.com>
Message-ID: <55674f0a-7886-f1d2-d7f1-6bf42c1e89e3@lge.com>
Date: Tue, 5 Dec 2017 15:19:46 +0900
MIME-Version: 1.0
In-Reply-To: <0aad02e4-f477-1ee3-471a-3e1371ebba1e@lge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 12/5/2017 2:46 PM, Byungchul Park wrote:
> On 12/5/2017 2:30 PM, Matthew Wilcox wrote:
>> On Mon, Dec 04, 2017 at 02:16:19PM +0900, Byungchul Park wrote:
>>> For now, wait_for_completion() / complete() works with lockdep, add
>>> lock_page() / unlock_page() and its family to lockdep support.
>>>
>>> Changes from v1
>>>   - Move lockdep_map_cross outside of page_ext to make it flexible
>>>   - Prevent allocating lockdep_map per page by default
>>>   - Add a boot parameter allowing the allocation for debugging
>>>
>>> Byungchul Park (4):
>>>    lockdep: Apply crossrelease to PG_locked locks
>>>    lockdep: Apply lock_acquire(release) on __Set(__Clear)PageLocked
>>>    lockdep: Move data of CONFIG_LOCKDEP_PAGELOCK from page to page_ext
>>>    lockdep: Add a boot parameter enabling to track page locks using
>>>      lockdep and disable it by default
>>
>> I don't like the way you've structured this patch series; first adding
>> the lockdep map to struct page, then moving it to page_ext.
> 
> Hello,
> 
> I will make them into one patch.

I've thought it more.

Actually I did it because I thought I'd better make it into two
patches since it makes reviewers easier to review. It doesn't matter
which one I choose, but I prefer to split it.

But, if you are strongly against it, then I will follow you.

-- 
Thanks,
Byungchul
