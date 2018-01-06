Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41896 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752369AbeAFJSU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 6 Jan 2018 04:18:20 -0500
Date: Sat, 6 Jan 2018 17:18:01 +0800
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 00/10] block: cleanup on direct access to bvec
 table(prepare for multipage bvec)
Message-ID: <20180106091800.GB13472@ming.t460p>
References: <20171208131409.11889-1-ming.lei@redhat.com>
 <dd24b1c7-ac28-89dd-985a-bab54d8192c0@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <dd24b1c7-ac28-89dd-985a-bab54d8192c0@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jan 05, 2018 at 12:02:10PM -0700, Jens Axboe wrote:
> On 12/8/17 6:13 AM, Ming Lei wrote:
> > Hi,
> > 
> > This patchse cleans up most of direct access to bvec table in tree, and
> > these patches are the follow-up of patch1 ~ 16 in the patchset of 'block:
> > support multipage bvec(V3)'[1]. 
> > 
> > Changes against [1]:
> > 1) split the cleanup patches from [1]
> > 2) address comments from Christoph:
> > 	- introduce bio helpers for dealing with the cleanup
> > 	- move bio_alloc_pages() to bcache
> > 
> > 
> > [1] https://marc.info/?t=150218197600001&r=1&w=2
> 
> Looks like good cleanups to me. I will apply this for 4.16, thanks.

Hi Jens,

Sorry for forgetting to update in this thread, the latest cleanup patchset
has been included into the following patchset of '[PATCH V4 00/45] block: support
multipage bvec' as patch 1 ~ 17: 

	https://marc.info/?t=151359981400006&r=1&w=2

If possible, please revert this 10 patches in your block-tree, and apply
the whole patchset of '[PATCH V4 00/45] block: support multipage bvec'
on the above link, and the V4 is much more clean than before.

Thanks,
Ming
