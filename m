Return-Path: <SRS0=ocaT=2I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F25B3C43603
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 15:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D290F2146E
	for <linux-block@archiver.kernel.org>; Wed, 18 Dec 2019 15:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727511AbfLRPL4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:11:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:51290 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727021AbfLRPLz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Dec 2019 10:11:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A01B4AD45;
        Wed, 18 Dec 2019 15:11:53 +0000 (UTC)
Subject: Re: [Xen-devel] [PATCH v12 2/5] xenbus/backend: Protect xenbus
 callback with lock
To:     SeongJae Park <sjpark@amazon.com>
Cc:     axboe@kernel.dk, sj38.park@gmail.com, konrad.wilk@oracle.com,
        pdurrant@amazon.com, SeongJae Park <sjpark@amazon.de>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        xen-devel@lists.xenproject.org, roger.pau@citrix.com
References: <20191218144025.24277-1-sjpark@amazon.com>
From:   =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Message-ID: <7edb266e-3185-5adc-1121-1b61feaf5a34@suse.com>
Date:   Wed, 18 Dec 2019 16:11:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191218144025.24277-1-sjpark@amazon.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 18.12.19 15:40, SeongJae Park wrote:
> On Wed, 18 Dec 2019 14:30:44 +0100 "Jürgen Groß" <jgross@suse.com> wrote:
> 
>> On 18.12.19 13:42, SeongJae Park wrote:
>>> On Wed, 18 Dec 2019 13:27:37 +0100 "Jürgen Groß" <jgross@suse.com> wrote:
>>>
>>>> On 18.12.19 11:42, SeongJae Park wrote:
>>>>> From: SeongJae Park <sjpark@amazon.de>
>>>>>
>>>>> 'reclaim_memory' callback can race with a driver code as this callback
>>>>> will be called from any memory pressure detected context.  To deal with
>>>>> the case, this commit adds a spinlock in the 'xenbus_device'.  Whenever
>>>>> 'reclaim_memory' callback is called, the lock of the device which passed
>>>>> to the callback as its argument is locked.  Thus, drivers registering
>>>>> their 'reclaim_memory' callback should protect the data that might race
>>>>> with the callback with the lock by themselves.
>>>>
>>>> Any reason you don't take the lock around the .probe() and .remove()
>>>> calls of the backend (xenbus_dev_probe() and xenbus_dev_remove())? This
>>>> would eliminate the need to do that in each backend instead.
>>>
>>> First of all, I would like to keep the critical section as small as possible.
>>> With my small test, I could see slightly increasing memory pressure as the
>>> critical section becomes wider.  Also, some drivers might share the data their
>>> 'reclaim_memory' callback touches with other functions.  I think only the
>>> driver owners can know what data is shared and what is the minimum critical
>>> section to protect it.
>>
>> But this kind of serialization can still be added on top.
> 
> I'm still worrying about the unnecessarily large critical section, but it might
> be small enough to be ignored.  If no others have strong objection, I will take
> the lock around the '->probe()' and '->remove()'.

The lock is per device, so contention is possible only for the
reclaim case. In case probe or remove are running reclaim will have
nothing to free (in probe case nothing is allocated yet, in remove
case everything should be freed anyway). So the larger critical section
is no problem at all IMO.

>> And with the trylock in the reclaim path I believe you can even avoid
>> the irq variants of the spinlock. But I might be wrong, so you should
>> try that with lockdep enabled. If it is working there is no harm done
>> when making the critical section larger, as memory allocations will
>> work as before.
> 
> Yes, you're right.  I will try test with lockdep.

Thanks,


Juergen

