Return-Path: <axboe@kernel.dk>
Subject: Re: [PATCH] Revert "blk-mq: remove code for dealing with remapping
 queue"
To: Stefan Haberland <sth@linux.vnet.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, Ewan Milne <emilne@redhat.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <20180424200144.16179-1-ming.lei@redhat.com>
 <30f75463-b50b-e3b7-8f78-768538fce016@de.ibm.com>
 <a6003752-474a-e0cc-6091-087a37470fdf@linux.vnet.ibm.com>
From: Jens Axboe <axboe@kernel.dk>
Message-ID: <27da3601-14c9-3363-cfa3-ee80a601370d@kernel.dk>
Date: Wed, 25 Apr 2018 07:59:43 -0600
MIME-Version: 1.0
In-Reply-To: <a6003752-474a-e0cc-6091-087a37470fdf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

On 4/25/18 2:38 AM, Stefan Haberland wrote:
> On 25.04.2018 09:41, Christian Borntraeger wrote:
>> On 04/24/2018 10:01 PM, Ming Lei wrote:
>>> This reverts commit 37c7c6c76d431dd7ef9c29d95f6052bd425f004c.
>>>
>>> Turns out some drivers(most are FC drivers) may not use managed
>>> IRQ affinity, and has their customized .map_queues meantime, so
>>> still keep this code for avoiding regression.
>>>
>>> Reported-by: Laurence Oberman <loberman@redhat.com>
>>> Cc: Ewan Milne <emilne@redhat.com>
>>> Cc: Stefan Haberland <sth@linux.vnet.ibm.com>
>>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>>> Cc: Christoph Hellwig <hch@lst.de>
>>> Cc: Sagi Grimberg <sagi@grimberg.me>
>>> Signed-off-by: Ming Lei <ming.lei@redhat.com>
>> Seems to work ok with 4.17-rc2 + this patch with s390 and dasd devices.
>> So one of the other fixes seems to have taken care of the original issue.
>> Would be good if Stefan Haberland could also verify that.
>>
>>
> 
> Looks OK to me, too.
> Did some testing with 4.17-rc2 + this patch on LPAR and z/VM with 1-65 
> CPUs as
> well as dynamic CPU definitionon z/VM and a small DASD regression test.

For both you and Christian - it'd be really nice if those positive
test results could be included in the forms of a Tested-by or similar
in the patch itself.

-- 
Jens Axboe
