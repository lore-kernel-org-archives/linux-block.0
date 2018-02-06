Return-Path: <talgi@mellanox.com>
Subject: Re: [PATCH rfc 0/5] generic adaptive IRQ moderation library for I/O
 devices
To: Or Gerlitz <gerlitz.or@gmail.com>, Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org,
 RDMA mailing list <linux-rdma@vger.kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Idan Burstein <idanb@mellanox.com>,
 Bart Van Assche <bart.vanassche@wdc.com>
References: <20180205220316.30236-1-sagi@grimberg.me>
 <CAJ3xEMi0KzOMJt7d01ohHW-ZpmdwvfzZCLN0qA-LLFwROeVseQ@mail.gmail.com>
From: Tal Gilboa <talgi@mellanox.com>
Message-ID: <4c8a45cb-bd4b-8dce-b8d2-2d26c471ef7b@mellanox.com>
Date: Tue, 6 Feb 2018 11:02:13 +0200
MIME-Version: 1.0
In-Reply-To: <CAJ3xEMi0KzOMJt7d01ohHW-ZpmdwvfzZCLN0qA-LLFwROeVseQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Return-Path: talgi@mellanox.com
List-ID: <linux-block@vger.kernel.org>

On 2/6/2018 10:54 AM, Or Gerlitz wrote:
> On Tue, Feb 6, 2018 at 12:03 AM, Sagi Grimberg <sagi@grimberg.me> wrote:
> 
>> The main reason why this implementation is different then the common networking devices
>> implementation (and kept separate) is that in my mind at least, network devices are different
>> animals than other I/O devices in the sense that:
> 
> Oh, I see now  that you do refer to the netdev library, I was confused
> by "In the networking stack, each device driver
> implements adaptive IRQ moderation on its own" comment.
> 
>> (a) network devices rely heavily on byte count of raw ethernet frames for adaptive moderation
>>      while in storage or I/O, the byte count is often a result of a submission/completion transaction
>>      and sometimes even known only to the application on top of the infrastructure (like in the
>>      rdma case).
> 
>> (b) Performance characteristics and expectations in representative workloads.
>> (c) network devices collect all sort of stats for different functionalities (where adaptive moderation
>>      is only one use-case) and I'm not sure at all that a subset of stats could easily migrate to a different
>>      context.
> 
> I think Tal has idea/s on how the existing library can be changed to
> support more modes/models
> 
What I was thinking is allowing DIM algorithm to disregard data which is 
0. Currently if bytes == 0 we return "SAME" immediately. We can change 
it to simply move to the packets check (which may be renamed to 
"completions"). This way you could use DIM while only optimizing to (P1) 
high packet rate and (P2) low interrupt rate.
