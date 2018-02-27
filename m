Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:44227 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751554AbeB0T1J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Feb 2018 14:27:09 -0500
Received: by mail-pf0-f196.google.com with SMTP id 17so8361459pfw.11
        for <linux-block@vger.kernel.org>; Tue, 27 Feb 2018 11:27:09 -0800 (PST)
Subject: Re: [PATCH v7 0/9] bcache: device failure handling improvement
From: Michael Lyle <mlyle@lyle.org>
To: Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org
References: <20180227165557.20442-1-colyli@suse.de>
 <d49160a9-cfee-1547-f08a-dcf83daba6f6@lyle.org>
 <881d16b5-e356-bb2a-459d-15c9ad11ca16@lyle.org>
Message-ID: <942b59f3-6222-7131-c99c-515c822dd099@lyle.org>
Date: Tue, 27 Feb 2018 11:27:05 -0800
MIME-Version: 1.0
In-Reply-To: <881d16b5-e356-bb2a-459d-15c9ad11ca16@lyle.org>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 02/27/2018 10:33 AM, Michael Lyle wrote:
> On 02/27/2018 10:29 AM, Michael Lyle wrote:
>> Hi Coly Li--
>>
>> On 02/27/2018 08:55 AM, Coly Li wrote:
>>> Hi maintainers and folks,
>>>
>>> This patch set tries to improve bcache device failure handling, includes
>>> cache device and backing device failures.
>>
>> I have applied 1, 2, 4 & 6 from this series to my 4.17 bcache-for-next
>> for testing.
> 
> Correction: I meant 1, 2, 5 & 6.

Sorry everyone for churn.  Present applied state is 1-6:

#6 6a2fb6357eae bcache: fix inaccurate io state for detached bcache devices
#5 6aee8a57d141 bcache: add stop_when_cache_set_failed option to backing
device
#4 3a9c638b1950 bcache: add CACHE_SET_IO_DISABLE to struct cache_set flags
#3 1b355007b5ae bcache: stop dc->writeback_rate_update properly
#2 70120583e4b5 bcache: quit dc->writeback_thread when
BCACHE_DEV_DETACHING is set
#1 b8f557d64115 bcache: fix cached_dev->count usage for
bch_cache_set_error()

There's some checkpatch warnings relating to non-preferred style
(splitting strings to hit 80 character limit) but I will fix them up
myself later).  This subset is through review and passes initial testing
(will be testing more / and writing test suite).

Mike
