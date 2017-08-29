Return-Path: <axboe@kernel.dk>
Subject: Re: [GIT PULL] nvme update for Linux 4.14
To: Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@infradead.org>
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
 <bcceb1b2-2b17-7a98-a459-5ba0bc661e74@grimberg.me>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <b0471487-4bf6-4040-7e21-a23cef5bc96c@kernel.dk>
Date: Tue, 29 Aug 2017 08:34:29 -0600
MIME-Version: 1.0
In-Reply-To: <bcceb1b2-2b17-7a98-a459-5ba0bc661e74@grimberg.me>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 08/28/2017 01:56 PM, Sagi Grimberg wrote:
>>>> Meh, I don't think that'll work out - the rdma refactoring from
>>>> Sagi deeply depends on the unіnit_ctrl split..
>>>
>>> I can do a for-4.14/block-postmerge branch, which is for-4.14/block
>>> with -rc7 pulled in. Should apply on top of that.
>>>
>>> Did that branch, doesn't apply. But should be easier for you to
>>> rebase on top of that branch. Pushed it out.
>>
>> I've pushed out a nvme-4.14-rebase branch with the rebase, but I didn't
>> have time for non-trivial testing yet, that'll have to wait for
>> tomorrow.
>>
>> Sagi: can you double check the resolutions around blk_mq_reinit_tagse?
> 
> Thanks for doing it Christoph,
> 
> It looks good to me, there is one glitch in patch:
> "nvme-rdma: reuse configure/destroy_admin_queue"
> 
> The "nvme_rdma_configure_admin_queue" block needs to
> be squashed into "nvme-rdma: don't free tagset on resets> 
> I'll do that now.

Let me know when it's ready.

-- 
Jens Axboe
