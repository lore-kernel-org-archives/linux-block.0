Return-Path: <sagigrim@gmail.com>
Return-Path: <sagigrim@gmail.com>
Subject: Re: [GIT PULL] nvme update for Linux 4.14, take 2
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
 Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org
References: <20170829150507.rjixn6uf3id6kltx@infradead.org>
 <9a27048d-1252-985f-c905-b738d709b204@kernel.dk>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <38ddd70f-3fec-09c0-dafb-eba1e8f9cc18@grimberg.me>
Date: Wed, 30 Aug 2017 18:10:07 +0300
MIME-Version: 1.0
In-Reply-To: <9a27048d-1252-985f-c905-b738d709b204@kernel.dk>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-block@vger.kernel.org>


>> Hi Jens,
>>
>> below is the current set of NVMe updates for Linux 4.14, now against your
>> postmerge branch, and with three more patches.
>>
>> The biggest bit comes from Sagi and refactors the RDMA driver to prepare
>> for more code sharing in the setup and teardown path.  But we have various
>> features and bug fixes from a lot of people as well.
> 
> Pulled, thanks.

I just realized that patch:
--
commit d352ae205d8b05f3f7558d10f474d8436581b3e2
Author: Bart Van Assche <bart.vanassche@wdc.com>
Date:   Thu Aug 17 16:23:03 2017 -0700

     blk-mq: Make blk_mq_reinit_tagset() calls easier to read

     Since blk_mq_ops.reinit_request is only called from inside
     blk_mq_reinit_tagset(), make this function pointer an argument of
     blk_mq_reinit_tagset() instead of a member of struct blk_mq_ops.
     This patch does not change any functionality but makes
     blk_mq_reinit_tagset() calls easier to read and to analyze.
--

Makes it impossible for me to move controller reset flow to
nvme-core without adding a trampoline (as the reinit_request
is transport specific)...

I'd really like to avoid adding more churn to the code refactoring
than it already has.

Given that this patch is not fixing anything should we revert it?
