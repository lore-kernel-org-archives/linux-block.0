Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Date: Mon, 19 Dec 2016 09:46:57 +0100
From: Jan Kara <jack@suse.cz>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Jan Kara <jack@suse.cz>, Jerome Glisse <jglisse@redhat.com>,
        Dave Chinner <david@fromorbit.com>,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] Un-addressable device memory and
 block/fs implications
Message-ID: <20161219084657.GA17598@quack2.suse.cz>
References: <20161213181511.GB2305@redhat.com>
 <20161213201515.GB4326@dastard>
 <20161213203112.GE2305@redhat.com>
 <20161213211041.GC4326@dastard>
 <20161213212433.GF2305@redhat.com>
 <20161214111351.GC18624@quack2.suse.cz>
 <20161214171514.GB14755@redhat.com>
 <20161215161939.GF13811@quack2.suse.cz>
 <87oa0cwoup.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87oa0cwoup.fsf@linux.vnet.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

On Fri 16-12-16 08:40:38, Aneesh Kumar K.V wrote:
> Jan Kara <jack@suse.cz> writes:
> 
> > On Wed 14-12-16 12:15:14, Jerome Glisse wrote:
> > <snipped explanation that the device has the same cabilities as CPUs wrt
> > page handling>
> >
> >> > So won't it be easier to leave the pagecache page where it is and *copy* it
> >> > to the device? Can the device notify us *before* it is going to modify a
> >> > page, not just after it has modified it? Possibly if we just give it the
> >> > page read-only and it will have to ask CPU to get write permission? If yes,
> >> > then I belive this could work and even fs support should be doable.
> >> 
> >> Well yes and no. Device obey the same rule as CPU so if a file back page is
> >> map read only in the process it must first do a write fault which will call
> >> in the fs (page_mkwrite() of vm_ops). But once a page has write permission
> >> there is no way to be notify by hardware on every write. First the hardware
> >> do not have the capability. Second we are talking thousand (10 000 is upper
> >> range in today device) of concurrent thread, each can possibly write to page
> >> under consideration.
> >
> > Sure, I meant whether the device is able to do equivalent of ->page_mkwrite
> > notification which apparently it is. OK.
> >
> >> We really want the device page to behave just like regular page. Most fs code
> >> path never map file content, it only happens during read/write and i believe
> >> this can be handled either by migrating back or by using bounce page. I want
> >> to provide the choice between the two solutions as one will be better for some
> >> workload and the other for different workload.
> >
> > I agree with keeping page used by the device behaving as similar as
> > possible as any other page. I'm just exploring different possibilities how
> > to make that happen. E.g. the scheme I was aiming at is:
> >
> > When you want page A to be used by the device, you set up page A' in the
> > device but make sure any access to it will fault.
> >
> > When the device wants to access A', it notifies the CPU, that writeprotects
> > all mappings of A, copy A to A' and map A' read-only for the device.
> 
> 
> A and A' will have different pfns here and hence different struct page.

Yes. In fact I don't think there's need to have struct page for A' in my
scheme. At least for the purposes of page cache tracking... Maybe there's
good reason to have it from a device driver POV.

> So what will be there in the address_space->page_tree ? If we place
> A' in the page cache, then we are essentially bringing lot of locking
> complexity Dave talked about in previous mails.

No, I meant page A will stay in the page_tree. There's no need for
migration in my scheme.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
