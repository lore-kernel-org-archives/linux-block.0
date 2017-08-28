Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] nvme update for Linux 4.14
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20170828143343.evhchzfzam3whgwm@infradead.org>
 <199590da-6ff8-24de-abca-00f23608b93b@kernel.dk>
 <20170828155336.GA5302@infradead.org>
 <3c45e618-6a96-6443-258a-dac8f93ccc7a@kernel.dk>
 <20170828155925.GA32254@infradead.org>
 <44a35d51-48d5-7181-df7e-b75fcbc053d9@kernel.dk>
 <20170828175744.GA26713@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <3c714d50-5b75-6a94-2fad-3ab491afc1cf@kernel.dk>
Date: Mon, 28 Aug 2017 12:05:38 -0600
MIME-Version: 1.0
In-Reply-To: <20170828175744.GA26713@infradead.org>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/28/2017 11:57 AM, Christoph Hellwig wrote:
> On Mon, Aug 28, 2017 at 10:03:39AM -0600, Jens Axboe wrote:
>> But one rock is shittier than the other. If you based it against
>> 4.14, then at least I only have to resolve the the problem once.
>>
>> The real problem is that the patch that went into master had
>> cleanups too. You should push back against that, since it will
>> inevitably cause problems by diverging 4.13 and 4.14 more than
>> absolutely necessary. Having conflicts in nvme for the block tree
>> is not isolated to this series, unfortunately.
> 
> Given that the update doesn't appear to be in your for-next branch
> yet: do you want me to rebase it and resend?

Yes please.

-- 
Jens Axboe
