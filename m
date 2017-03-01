Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Subject: Re: [PATCHv2 2/2] nvme: Complete all stuck requests
To: Keith Busch <keith.busch@intel.com>
References: <1487896561-10454-1-git-send-email-keith.busch@intel.com>
 <1487896561-10454-2-git-send-email-keith.busch@intel.com>
 <b66a614e-140e-86e9-56bf-d3eafb750aa5@grimberg.me>
 <20170227150107.GA5789@localhost.localdomain>
 <4c952c67-9871-249d-86b0-5f81acf00571@grimberg.me>
 <20170227191459.GA1170@localhost.localdomain>
 <913d4d24-b80b-b7f6-2374-8095bc6fc047@intel.com>
 <20170228165719.GA23236@localhost.localdomain>
From: Artur Paszkiewicz <artur.paszkiewicz@intel.com>
Message-ID: <a1e30246-20d4-ac78-89f9-b0fbd3b3f7de@intel.com>
Date: Wed, 1 Mar 2017 09:54:17 +0100
MIME-Version: 1.0
In-Reply-To: <20170228165719.GA23236@localhost.localdomain>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
 Marc MERLIN <marc@merlins.org>, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

On 02/28/2017 05:57 PM, Keith Busch wrote:
> On Tue, Feb 28, 2017 at 08:42:19AM +0100, Artur Paszkiewicz wrote:
>>
>> I'm observing the same thing when hibernating during mdraid resync on
>> nvme - it hangs in blk_mq_freeze_queue_wait() after "Disabling non-boot
>> CPUs ...".
> 
> The patch guarantees forward progress for blk-mq's hot-cpu notifier on
> nvme request queues by failing all entered requests. It sounds like some
> part of your setup needs those requests to succeed in order to hibernate.
> 
> If your mdraid uses a stacking request_queue that submits retries while
> it's request queue is entered, that may explain how you remain stuck
> at blk_mq_freeze_queue_wait.
> 
>> This patch did not help but when I put nvme_wait_freeze()
>> right after nvme_start_freeze() it appeared to be working. Maybe the
>> difference here is that requests are submitted from a non-freezable
>> kernel thread (md sync_thread)?
> 
> Wait freeze prior to quiescing the queue is ok when the controller is
> functioning, but it'd be impossible to complete a reset if the controller
> is in a failed or degraded state.
> 
> We probably want to give those requests a chance to succeed, and I think
> we'd need to be able to timeout the freeze wait. Below are two patches
> I tested. Prior to these, the fio test would report IO errors from some
> of its jobs; no errors with these.

With these patches it works fine. I tested multiple iterations on 2
platforms and they were able to hibernate and resume without issues.

Thanks,
Artur

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
