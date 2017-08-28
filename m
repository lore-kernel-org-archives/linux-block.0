Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [GIT PULL] nvme update for Linux 4.14
To: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20170828143343.evhchzfzam3whgwm@infradead.org>
 <199590da-6ff8-24de-abca-00f23608b93b@kernel.dk>
 <20170828155336.GA5302@infradead.org>
 <3c45e618-6a96-6443-258a-dac8f93ccc7a@kernel.dk>
 <20170828155925.GA32254@infradead.org>
 <44a35d51-48d5-7181-df7e-b75fcbc053d9@kernel.dk>
 <20170828175744.GA26713@infradead.org>
 <3c714d50-5b75-6a94-2fad-3ab491afc1cf@kernel.dk>
 <20170828184035.GA11383@infradead.org>
 <379b013e-4762-6871-e9b2-861772143817@kernel.dk>
 <20170828194325.GA3447@infradead.org>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <bcceb1b2-2b17-7a98-a459-5ba0bc661e74@grimberg.me>
Date: Mon, 28 Aug 2017 22:56:41 +0300
MIME-Version: 1.0
In-Reply-To: <20170828194325.GA3447@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>

>>> Meh, I don't think that'll work out - the rdma refactoring from
>>> Sagi deeply depends on the unіnit_ctrl split..
>>
>> I can do a for-4.14/block-postmerge branch, which is for-4.14/block
>> with -rc7 pulled in. Should apply on top of that.
>>
>> Did that branch, doesn't apply. But should be easier for you to
>> rebase on top of that branch. Pushed it out.
> 
> I've pushed out a nvme-4.14-rebase branch with the rebase, but I didn't
> have time for non-trivial testing yet, that'll have to wait for
> tomorrow.
> 
> Sagi: can you double check the resolutions around blk_mq_reinit_tagse?

Thanks for doing it Christoph,

It looks good to me, there is one glitch in patch:
"nvme-rdma: reuse configure/destroy_admin_queue"

The "nvme_rdma_configure_admin_queue" block needs to
be squashed into "nvme-rdma: don't free tagset on resets".

I'll do that now.
