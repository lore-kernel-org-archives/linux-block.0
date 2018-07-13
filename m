Return-Path: <linux-block-owner@vger.kernel.org>
Received: from smtp2.provo.novell.com ([137.65.250.81]:34246 "EHLO
        smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbeGMWiQ (ORCPT
        <rfc822;groupwise-linux-block@vger.kernel.org:0:0>);
        Fri, 13 Jul 2018 18:38:16 -0400
Message-ID: <fde41361161503b12808bf8770c2cce9c8ecf869.camel@suse.com>
Subject: Re: Silent data corruption in blkdev_direct_IO()
From: Martin Wilck <mwilck@suse.com>
To: Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Date: Sat, 14 Jul 2018 00:21:34 +0200
In-Reply-To: <6ba0d73a-aaf7-f283-88e7-eb151caa8628@kernel.dk>
References: <e36f28d8-0eb8-1600-f327-8b066eeaf45c@suse.de>
         <3419a3ae-da82-9c20-26e1-7c9ed14ff8ed@kernel.dk>
         <a1679897-ed41-1ceb-f94f-bd1be537ce4e@suse.de>
         <57a2b121-9805-8337-fb97-67943670f250@kernel.dk>
         <a0b0e59b-60cd-9933-6752-4c21a7a975fe@kernel.dk>
         <2311947c2f0f368bd10474edb0f0f5b51dde6b7d.camel@suse.com>
         <b85c5eff-d6dc-e43c-8e2c-608249ae81a2@kernel.dk>
         <6ba0d73a-aaf7-f283-88e7-eb151caa8628@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, 2018-07-13 at 12:50 -0600, Jens Axboe wrote:
> On 7/13/18 12:00 PM, Jens Axboe wrote:
> > On 7/13/18 10:56 AM, Martin Wilck wrote:
> > > On Thu, 2018-07-12 at 10:42 -0600, Jens Axboe wrote:
> > > > 
> > > > Hence the patch I sent is wrong, the code actually looks fine.
> > > > Which
> > > > means we're back to trying to figure out what is going on here.
> > > > It'd
> > > > be great with a test case...
> > > 
> > > We don't have an easy test case yet. But the customer has
> > > confirmed
> > > that the problem occurs with upstream 4.17.5, too. We also
> > > confirmed
> > > again that the problem occurs when the kernel uses the kmalloc()
> > > code
> > > path in __blkdev_direct_IO_simple().
> > > 
> > > My personal suggestion would be to ditch
> > > __blkdev_direct_IO_simple()
> > > altogether. After all, it's not _that_ much simpler thatn
> > > __blkdev_direct_IO(), and it seems to be broken in a subtle way.
> > 
> > That's not a great suggestion at all, we need to find out why we're
> > hitting the issue. For all you know, the bug could be elsewhere and
> > we're just going to be hitting it differently some other way. The
> > head-in-the-sand approach is rarely a win long term.
> > 
> > It's saving an allocation per IO, that's definitely measurable on
> > the faster storage. For reads, it's also not causing a context
> > switch for dirtying pages. I'm not a huge fan of multiple cases
> > in general, but this one is definitely warranted in an era where
> > 1 usec is a lot of extra time for an IO.
> > 
> > > However, so far I've only identified a minor problem, see below -
> > > it
> > > doesn't explain the data corruption we're seeing.
> > 
> > What would help is trying to boil down a test case. So far it's a
> > lot
> > of hand waving, and nothing that can really help narrow down what
> > is
> > going on here.
> 
> When someone reports to you that some kind of data corruption occurs,
> you need to find out as many details you can. Ideally they can give
> you
> a test case, but if they can't, you ask as many questions as possible
> to
> help YOU make a test case.
> 
> - What is the nature of the corruption? Is it reads or writes? Is it
>   zeroes, random data, or data from somewhere else? How big is the
>   corrupted area?
> 
> - What does the workload look like that reproduces it? If they don't
>   really know and they can't give you a reproducer, you help them
> with
>   tracing to give you the information you need.
> 
> Those are a great start. Right now we have zero information, other
> than
> reverting that patch fixes it. This means that we're likely dealing
> with
> IO that is larger than 16k, since we're going to be hitting the same
> path for <= 16k ios with the patch reverted. We also know it's less
> than
> 1MB.

The nature of the corruption is an interesting question. The weird
thing is that it's not block-aligned - "bad" data starts at some
apparently random offset into the log file. That'd actually made me
think that we're not looking at a block IO issue but maybe some
corruption that occured in memory before write-out. But then we
isolated this specific patch by bisection... I had my doubts, but it
seems to be sound, at least the test results indicate so.

The user application is a database which writes logs in blocks that are
multiples of 8k. The IO goes through various layers in the VM (ext3 on
LVM on MD on virtio), then through qemu via virtio-scsi, and onto a
host multipath device which is backed by FC storage. The VM is running
an old SLES 11 distro, the problems were caused by a host kernel
update.

My attempts to reproduce a corruption with lab equipment have failed up
to now. I've been trying to replay the customer's workload with
btreplay. I also tried to replay it with fio with verification to try
to find corruptions, but I guess I didn't get the setup quite right. 

>  But that's it. I don't even know if it's writes, since your (and
> Hannes's) report has no details at all.
> Go look at what you ask customers to provide for bug reports, then
> apply
> some of that to this case...

Sorry. It's writes. The reason we posted this here was a) the concrete
questions Hannes asked about the code, b) the patch we'd isolated - we
thought you or Christoph might just have a bright idea about it, or see
what we didn't, and c) that we thought the problem might affect
upstream, too.

We don't expect you to do the dirty work for us. We'll come back to the
list when we know more, or have specific questions.

Martin

-- 
Dr. Martin Wilck <mwilck@suse.com>, Tel. +49 (0)911 74053 2107
SUSE Linux GmbH, GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
