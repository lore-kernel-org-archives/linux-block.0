Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH 3/6] block: make part_in_flight() take an array of two
 ints
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: "brking@linux.vnet.ibm.com" <brking@linux.vnet.ibm.com>
References: <1501859062-11120-1-git-send-email-axboe@kernel.dk>
 <1501859062-11120-4-git-send-email-axboe@kernel.dk>
 <1501875501.2757.25.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <78872ad9-aecf-c34b-8686-22e35adea79c@kernel.dk>
Date: Fri, 4 Aug 2017 13:40:16 -0600
MIME-Version: 1.0
In-Reply-To: <1501875501.2757.25.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/04/2017 01:38 PM, Bart Van Assche wrote:
> On Fri, 2017-08-04 at 09:04 -0600, Jens Axboe wrote:
>> Instead of returning the count that matches the partition, pass
>> in an array of two ints. Index 0 will be filled with the inflight
>> count for the partition in question, and index 1 will filled
>> with the root infligh count, if the partition passed in is not the
>> root.
> 
> Hello Jens,
> 
> It looks like a letter 't' is missing from the patch description ("infligh")?

Oops thanks, fixed up.

-- 
Jens Axboe
