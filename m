Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:35586 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752763AbeCPBAw (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 21:00:52 -0400
Subject: Re: [PATCH 12/16] bcache: Make it easier for static analyzers to
 analyze bch_allocator_thread()
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "mlyle@lyle.org" <mlyle@lyle.org>,
        "kent.overstreet@gmail.com" <kent.overstreet@gmail.com>
Cc: "hch@lst.de" <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        linux-bcache <linux-bcache@vger.kernel.org>
References: <20180315150814.9412-1-bart.vanassche@wdc.com>
 <20180315150814.9412-13-bart.vanassche@wdc.com>
 <bed0d218-75f8-2f6a-04f6-3e0c19563ef8@suse.de>
 <1521132734.2834.8.camel@wdc.com>
From: Coly Li <colyli@suse.de>
Message-ID: <9c3e2a8e-d2bb-9dcd-6247-f151c12af2eb@suse.de>
Date: Fri, 16 Mar 2018 08:59:47 +0800
MIME-Version: 1.0
In-Reply-To: <1521132734.2834.8.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 16/03/2018 12:52 AM, Bart Van Assche wrote:
> On Fri, 2018-03-16 at 00:29 +0800, Coly Li wrote:
>> On 15/03/2018 11:08 PM, Bart Van Assche wrote:
>>> This patch does not change any functionality but avoids that smatch
>>> reports the following:
>>>
>>> drivers/md/bcache/alloc.c:334: bch_allocator_thread() error: uninitialized symbol 'bucket'.
>>>
>>> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
>>
>> Hi Bart,
>>
>> Your change is OK to me, but the original code seems OK too. Can I say
>> this is a bug should be fixed from smatch ?
> 
> Hello Coly,
> 
> It would be great if smatch would be modified such that it does not complain
> about this code. But I think that this patch does not only make the code
> easier to analyze for static analyzers but also for humans. So please evaluate
> this patch from that perspective.

Hi Bart,

It's fair enough, I am convinced. Thanks.

Reviewed-by: Coly Li <colyli@suse.de>

Coly Li
