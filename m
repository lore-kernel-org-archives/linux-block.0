Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:38846 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752114AbeCQKGB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 17 Mar 2018 06:06:01 -0400
Subject: Re: [PATCH 15/16] bcache: Fix an endianness bug
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "mlyle@lyle.org" <mlyle@lyle.org>,
        "kent.overstreet@gmail.com" <kent.overstreet@gmail.com>
Cc: "hch@lst.de" <hch@lst.de>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <20180315150814.9412-1-bart.vanassche@wdc.com>
 <20180315150814.9412-16-bart.vanassche@wdc.com>
 <6b2b29bb-f26b-2df9-3609-26100cc1c9a5@suse.de>
 <1521212430.5384.1.camel@wdc.com>
From: Coly Li <colyli@suse.de>
Message-ID: <35a7fcc6-0b94-5813-a27d-639a05fe2c89@suse.de>
Date: Sat, 17 Mar 2018 18:05:53 +0800
MIME-Version: 1.0
In-Reply-To: <1521212430.5384.1.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 16/03/2018 11:00 PM, Bart Van Assche wrote:
> On Fri, 2018-03-16 at 12:47 +0800, Coly Li wrote:
>> The code still does not work with your patch on big endian machine (e.g.
>> s390x). When I fix the bcache s390x bug, I did something like this patch
>> in my first try. It turns out more things need to be fixed,
>> 1, some cache_sb members only swapped to cpu endianness when read in,
>> not swapped to little endian when write out. For example data_offset,
>> nbuckets, nr_in_set, nr_this_dev ...
>> 2, checksum is calculated in cpu endiannness, not explicitly in little
>> endian.
>>
>> Also user space tools need to update to support the endianness issue.
>>
>> How about leave the endianness problem to me? I will pick code piece
>> from your patch and set 'From: Bart Van Assche <bart.vanassche@wdc.com>'
>> on the patch(s), and continue my fix for bcache on s390x.
> 
> Hello Coly,
> 
> That sounds fine to me. Please let me know if you would like me to repost
> this series and/or address the feedback that I received for this patch series.

Hi Bart,

I see Mike already picks some of your patches, repost an updated version
for the rested patch should be a good idea.

Thanks.

Coly Li
