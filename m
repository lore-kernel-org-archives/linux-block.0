Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] nvme fixes for 4.18
From: Jens Axboe <axboe@kernel.dk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
References: <20180608055811.24xz3qfvf3gsvuef@infradead.org>
 <8fdcff52-a017-11ba-2ec1-2d2dc265d2a8@kernel.dk>
Message-ID: <059df767-07b1-4c8a-e084-d61bad810ba1@kernel.dk>
Date: Fri, 8 Jun 2018 12:51:55 -0600
MIME-Version: 1.0
In-Reply-To: <8fdcff52-a017-11ba-2ec1-2d2dc265d2a8@kernel.dk>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 6/8/18 7:09 AM, Jens Axboe wrote:
> On 6/7/18 11:58 PM, Christoph Hellwig wrote:
>> Hi Jens,
>>
>> a few more small fixes for NVMe for this merge window:
>>
>> The following changes since commit af6c5d5e01ad9f2c9ca38cccaae6b5d67ddd241f:
>>
>>   Merge branch 'for-4.18' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/wq (2018-06-05 17:31:33 -0700)
>>
>> are available in the Git repository at:
>>
>>   git://git.infradead.org/nvme.git nvme-4.18
> 
> This is based off some random point in master, 2k commits or so ahead
> of my for-linus branch.
> 
> The patches look fine, but I don't want to pull that. I can either apply
> the patches (trivial), or you can rebase. I'm fine with either.

JFYI, to avoid holding them up any further, I've committed them
manually and pushed it out.

-- 
Jens Axboe
