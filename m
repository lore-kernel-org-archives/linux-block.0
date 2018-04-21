Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH v6] blk-mq: Avoid that a completion can be ignored for
 BLK_EH_RESET_TIMER
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
 "jianchao.w.wang@oracle.com" <jianchao.w.wang@oracle.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "israelr@mellanox.com" <israelr@mellanox.com>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "hch@lst.de" <hch@lst.de>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "ming.lei@redhat.com" <ming.lei@redhat.com>,
 "maxg@mellanox.com" <maxg@mellanox.com>, "tj@kernel.org" <tj@kernel.org>
References: <20180419164353.13561-1-bart.vanassche@wdc.com>
 <18cd85bb-ee41-ce6f-e8c8-dcf6e7fd0504@oracle.com>
 <a47209f74d52d19464f993c11c4a4811271e6348.camel@wdc.com>
 <389cc1a6-6c2a-db08-fec1-1e103a6a9c9e@oracle.com>
 <7183cb81-5fb5-eea2-afaf-443f26921257@kernel.dk>
 <f806a661-4702-1757-94fe-243704974fa4@oracle.com>
 <e885c77ec18a9c7f71ca7339202c7db10e8cbc04.camel@wdc.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <d5e9f5a5-6167-368f-5cbb-c3c6c79bb709@kernel.dk>
Date: Sat, 21 Apr 2018 10:21:00 -0600
MIME-Version: 1.0
In-Reply-To: <e885c77ec18a9c7f71ca7339202c7db10e8cbc04.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/21/18 9:05 AM, Bart Van Assche wrote:
> On Sat, 2018-04-21 at 22:55 +0800, jianchao.wang wrote:
>> So we have a __deadline as below:
>>                  
>>     deadline     gen state   
>>> ______________|____|_|
>>
>>                \___ __/ 
>>                    V
>>               granularity 
>>
>> and even we usually have a 30~60s timeout,
>> but we should support a 1s granularity at least.
>> How to decide the granularity ?
> 
> Your diagram shows that the uppermost bits are used for the deadline. What I
> proposed is to use the lower 32 bits for the deadline such that we again have
> a resolution of 1/HZ.

It honestly doesn't matter how we do it, granularity could be exactly
the same. But yeah, storing it at the lower bits is perfectly fine,
either way works. Only difference is in the encoding, functionally
they can be identical.

-- 
Jens Axboe
