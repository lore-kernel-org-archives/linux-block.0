Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Wed, 18 Jan 2017 12:00:57 +0100
From: Jan Kara <jack@suse.cz>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Jerome Glisse <jglisse@redhat.com>,
        lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF/MM ATTEND] Un-addressable device memory and
 block/fs implications
Message-ID: <20170118110057.GA31377@quack2.suse.cz>
References: <20161213181511.GB2305@redhat.com>
 <87lgvgwoos.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87lgvgwoos.fsf@linux.vnet.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Fri 16-12-16 08:44:11, Aneesh Kumar K.V wrote:
> Jerome Glisse <jglisse@redhat.com> writes:
> 
> > I would like to discuss un-addressable device memory in the context of
> > filesystem and block device. Specificaly how to handle write-back, read,
> > ... when a filesystem page is migrated to device memory that CPU can not
> > access.
> >
> > I intend to post a patchset leveraging the same idea as the existing
> > block bounce helper (block/bounce.c) to handle this. I believe this is
> > worth discussing during summit see how people feels about such plan and
> > if they have better ideas.
> >
> >
> > I also like to join discussions on:
> >   - Peer-to-Peer DMAs between PCIe devices
> >   - CDM coherent device memory
> >   - PMEM
> >   - overall mm discussions
> 
> I would like to attend this discussion. I can talk about coherent device
> memory and how having HMM handle that will make it easy to have one
> interface for device driver. For Coherent device case we definitely need
> page cache migration support.

Aneesh, did you intend this as your request to attend? You posted it as a
reply to another email so it is not really clear. Note that each attend
request should be a separate email so that it does not get lost...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
