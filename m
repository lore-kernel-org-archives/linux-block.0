Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47598 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932848AbcLMSzt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Dec 2016 13:55:49 -0500
Date: Tue, 13 Dec 2016 13:55:46 -0500
From: Jerome Glisse <jglisse@redhat.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [LSF/MM TOPIC] Un-addressable device memory and block/fs
 implications
Message-ID: <20161213185545.GC2305@redhat.com>
References: <20161213181511.GB2305@redhat.com>
 <1481653252.2473.51.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1481653252.2473.51.camel@HansenPartnership.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Dec 13, 2016 at 10:20:52AM -0800, James Bottomley wrote:
> On Tue, 2016-12-13 at 13:15 -0500, Jerome Glisse wrote:
> > I would like to discuss un-addressable device memory in the context 
> > of filesystem and block device. Specificaly how to handle write-back,
> > read, ... when a filesystem page is migrated to device memory that 
> > CPU can not access.
> > 
> > I intend to post a patchset leveraging the same idea as the existing
> > block bounce helper (block/bounce.c) to handle this. I believe this 
> > is worth discussing during summit see how people feels about such 
> > plan and if they have better ideas.
> 
> Isn't this pretty much what the transcendent memory interfaces we
> currently have are for?  It's current use cases seem to be compressed
> swap and distributed memory, but there doesn't seem to be any reason in
> principle why you can't use the interface as well.
> 

I am not a specialist of tmem or cleancache but my understand is that
there is no way to allow for file back page to be dirtied while being
in this special memory.

In my case when you migrate a page to the device it might very well be
so that the device can write something in it (results of some sort of
computation). So page might migrate to device memory as clean but
return from it in dirty state.

Second aspect is that even if memory i am dealing with is un-addressable
i still have struct page for it and i want to be able to use regular
page migration.

So given my requirement i didn't thought that cleancache was the way
to address them. Maybe i am wrong.

Cheers,
J�r�me
