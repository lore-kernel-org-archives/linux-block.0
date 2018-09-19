Return-Path: <bart.vanassche@gmail.com>
Return-Path: <bart.vanassche@gmail.com>
Message-ID: <1537393090.186311.1.camel@acm.org>
Subject: Re: [PATCH v7 5/6] block: Make blk_get_request() block for non-PM
 requests while suspended
From: Bart Van Assche <bvanassche@acm.org>
To: "jianchao.wang" <jianchao.w.wang@oracle.com>, Jens Axboe
 <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Ming Lei
	 <ming.lei@redhat.com>, Hannes Reinecke <hare@suse.com>, Johannes Thumshirn
	 <jthumshirn@suse.de>, Alan Stern <stern@rowland.harvard.edu>
Date: Wed, 19 Sep 2018 14:38:10 -0700
In-Reply-To: <faa2e932-8557-37b7-3283-8de551d54482@oracle.com>
References: <20180917201525.26570-1-bvanassche@acm.org>
	 <20180917201525.26570-6-bvanassche@acm.org>
	 <be1de777-357c-ef19-1de0-7b352b3cee96@oracle.com>
	 <bf97c289-0786-230c-5b81-4e5b9ae17026@acm.org>
	 <faa2e932-8557-37b7-3283-8de551d54482@oracle.com>
Content-Type: text/plain; charset="UTF-7"
Mime-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

On Wed, 2018-09-19 at 10:21 +-0800, jianchao.wang wrote:
+AD4 On 09/19/2018 01:44 AM, Bart Van Assche wrote:
+AD4 +AD4 There is only one blk+AF8-pm+AF8-request+AF8-resume() call and that call is
+AD4 +AD4 inside blk+AF8-queue+AF8-enter() after the pm+AF8-only counter has been
+AD4 +AD4 checked.
+AD4 +AD4 
+AD4 +AD4 For the legacy block layer, nr+AF8-pending is increased after the
+AD4 +AD4 blk+AF8-queue+AF8-enter() call from inside blk+AF8-old+AF8-get+AF8-request() succeeded.
+AD4 +AD4 
+AD4 +AD4 So I don't see how blk+AF8-pm+AF8-request+AF8-resume() or q-+AD4-nr+AF8-pending+-+- could
+AD4 +AD4 escape from the preempt checking?
+AD4 
+AD4 For example:
+AD4 
+AD4 
+AD4 blk+AF8-pre+AF8-runtime+AF8-suspend                    generic+AF8-make+AF8-request
+AD4                                              blk+AF8-queue+AF8-enter  //
+AD4 success here, no blk+AF8-pm+AF8-request+AF8-resume here
+AD4                                              blk+AF8-mq+AF8-make+AF8-requset
+AD4 blk+AF8-set+AF8-pm+AF8-only
+AD4 
+AD4 if (blk+AF8-requests+AF8-in+AF8-flight(q) +AD0APQ 0) +AHs
+AD4   synchronize+AF8-rcu()+ADs
+AD4   if (blk+AF8-requests+AF8-in+AF8-flight(q) +AD0APQ 0)
+AD4     ret +AD0 0+ADs
+AD4   +AH0
+AD4                                              blk+AF8-mq+AF8-get+AF8-request

Hello Jianchao,

I think you are right. I will add a q+AF8-usage+AF8-counter check before
setting 'ret' to zero.

Bart.
