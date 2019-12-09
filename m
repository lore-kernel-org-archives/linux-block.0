Return-Path: <SRS0=mQXl=Z7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC79C43603
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 11:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECB692077B
	for <linux-block@archiver.kernel.org>; Mon,  9 Dec 2019 11:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbfLILIN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Dec 2019 06:08:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:45292 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726377AbfLILIN (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Dec 2019 06:08:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 07F04AE4D;
        Mon,  9 Dec 2019 11:08:11 +0000 (UTC)
Subject: Re: [PATCH v3 0/1] xen/blkback: Squeeze page pools if a memory
 pressure
To:     SeongJae Park <sjpark@amazon.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "sj38.park@gmail.com" <sj38.park@gmail.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
References: <20191209105218.23583-1-sjpark@amazon.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <17131297-6d09-7302-d632-246f62487652@suse.com>
Date:   Mon, 9 Dec 2019 12:08:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191209105218.23583-1-sjpark@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 09.12.19 11:52, SeongJae Park wrote:
> On Mon, 9 Dec 2019 11:15:22 +0100 "Jürgen Groß" <jgross@suse.com> wrote:
> 
>> On 09.12.19 10:46, Durrant, Paul wrote:
>>>> -----Original Message-----
>>>> From: Jürgen Groß <jgross@suse.com>
>>>> Sent: 09 December 2019 09:39
>>>> To: Park, Seongjae <sjpark@amazon.com>; axboe@kernel.dk;
>>>> konrad.wilk@oracle.com; roger.pau@citrix.com
>>>> Cc: linux-block@vger.kernel.org; linux-kernel@vger.kernel.org; Durrant,
>>>> Paul <pdurrant@amazon.com>; sj38.park@gmail.com; xen-
>>>> devel@lists.xenproject.org
>>>> Subject: Re: [PATCH v3 0/1] xen/blkback: Squeeze page pools if a memory
>>>> pressure
>>>>
>>>> On 09.12.19 09:58, SeongJae Park wrote:
>>>>> Each `blkif` has a free pages pool for the grant mapping.  The size of
>>>>> the pool starts from zero and be increased on demand while processing
>>>>> the I/O requests.  If current I/O requests handling is finished or 100
>>>>> milliseconds has passed since last I/O requests handling, it checks and
>>>>> shrinks the pool to not exceed the size limit, `max_buffer_pages`.
>>>>>
>>>>> Therefore, `blkfront` running guests can cause a memory pressure in the
>>>>> `blkback` running guest by attaching a large number of block devices and
>>>>> inducing I/O.
>>>>
>>>> I'm having problems to understand how a guest can attach a large number
>>>> of block devices without those having been configured by the host admin
>>>> before.
>>>>
>>>> If those devices have been configured, dom0 should be ready for that
>>>> number of devices, e.g. by having enough spare memory area for ballooned
>>>> pages.
>>>>
>>>> So either I'm missing something here or your reasoning for the need of
>>>> the patch is wrong.
>>>>
>>>
>>> I think the underlying issue is that persistent grant support is hogging memory in the backends, thereby compromising scalability. IIUC this patch is essentially a band-aid to get back to the scalability that was possible before persistent grant support was added. Ultimately the right answer should be to get rid of persistent grants support and use grant copy, but such a change is clearly more invasive and would need far more testing.
>>
>> Persistent grants are hogging ballooned pages, which is equivalent to
>> memory only in case of the backend's domain memory being equal or
>> rather near to its max memory size.
>>
>> So configuring the backend domain with enough spare area for ballooned
>> pages should make this problem much less serious.
>>
>> Another problem in this area is the amount of maptrack frames configured
>> for a driver domain, which will limit the number of concurrent foreign
>> mappings of that domain.
> 
> Right, similar problems from other backends are possible.
> 
>>
>> So instead of having a blkback specific solution I'd rather have a
>> common callback for backends to release foreign mappings in order to
>> enable a global resource management.
> 
> This patch is also based on a common callback, namely the shrinker callback
> system.  As the shrinker callback is designed for the general memory pressure
> handling, I thought this is a right one to use.  Other backends having similar
> problems can use this in their way.

But this is addressing memory shortage only and it is acting globally.

What I'd like to have in some (maybe distant) future is a way to control
resource usage per guest. Why would you want to throttle performance of
all guests instead of only the one causing the pain by hogging lots of
resources?

The new backend callback should (IMO) have a domid as parameter for
specifying which guest should be taken away resources (including the
possibility to select "any domain").

It might be reasonable to have your shrinker hook in e.g. xenbus for
calling the backend callbacks. And you could have another agent in the
grant driver reacting on shortage of possible grant mappings.

I don't expect you to implement all of that at once, but I think having
that idea in mind when addressing current issues would be nice. So as a
starting point you could move the shrinker hook to xenbus, add the
generic callback to struct xenbus_driver, populate that callback in
blkback and call it in the shrinker hook with "any domain". This would
enable a future extension to other backends and a dynamic resource
management in a natural way.


Juergen
