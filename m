Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44414 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725949AbeG1Gtl (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Jul 2018 02:49:41 -0400
Subject: Re: [PATCH 8/9] bcache: initiate bcache_debug to NULL
To: Noah Massey <noah.massey@gmail.com>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        Vojtech Pavlik <vojtech@suse.com>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
References: <20180726142239.44669-1-colyli@suse.de>
 <20180726142239.44669-9-colyli@suse.de>
 <CADfjVrhRtwdGF6bs_yCQms=TXxHynZb87r9gzRNoicQ70-n8OQ@mail.gmail.com>
 <CADfjVrj+3pqT3xrQW4tEcTJo0OCFXpovLj9+EixBChptdtLRzw@mail.gmail.com>
From: Coly Li <colyli@suse.de>
Message-ID: <80e01975-f57d-b638-ddac-d4649b8bda05@suse.de>
Date: Sat, 28 Jul 2018 13:24:19 +0800
MIME-Version: 1.0
In-Reply-To: <CADfjVrj+3pqT3xrQW4tEcTJo0OCFXpovLj9+EixBChptdtLRzw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 2018/7/28 3:32 AM, Noah Massey wrote:
> On Fri, Jul 27, 2018 at 1:37 PM Noah Massey <noah.massey@gmail.com> wrote:
>> On Thu, Jul 26, 2018, 10:23 AM Coly Li <colyli@suse.de> wrote:
>>>
>>> Global variable bcache_debug is firstly initialized in bch_debug_init(),
>>> and destroyed in bch_debug_exit(). bch_debug_init() is called in
>>> bcache_init() with many other functions, if one of the previous calling
>>> onces failed, bcache_exit() will be called in the failure path.
>>>
>>> The problem is, if bcache_init() fails before bch_debug_init() is called,
>>> then in bcache_exit() when bch_debug_exit() is called to destroy global
>>> variable bcache_debug, at this moment bcache_debug is unndefined, then the
>>> test of "if (!IS_ERR_OR_NULL(bcache_debug))" might be buggy.
>>>
>>> This patch initializes global varabile bcache_debug to be NULL, to make
>>> the failure code path to be predictable.
>>>
>>> Signed-off-by: Coly Li <colyli@suse.de>
>>> ---
>>
>>
>> Makes sense
>>
>> Reviewed-by: Noah Massey <noah.massey@gmail.com>
>>
> 
> Wait... aren't static variables already initialized to 0?
> So this makes it explicit, but no code change to generated binary, right?

Hi Noah, Vojtech and Bart,

You are right, of course. I just notice this is already in C11 (and
early versions) for static duration storage,

6.7.9 Initialization
10 If an object that has automatic storage duration is not initialized
explicitly, its value is indeterminate. If an object that has static or
thread storage duration is not initialized explicitly, then:
— if it has pointer type, it is initialized to a null pointer;
— if it has arithmetic type, it is initialized to (positive or unsigned)
zero;
— if it is an aggregate, every member is initialized (recursively)
according to these rules, and any padding is initialized to zero bits;
— if it is a union, the first named member is initialized (recursively)
according to these rules, and any padding is initialized to zero bits;

Then this patch is useless, it is unnecessary.

Thank you all for the comments, I am about to read the C11 document :-)

Coly Li
