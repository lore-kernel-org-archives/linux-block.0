Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga17.intel.com ([192.55.52.151]:18039 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752100AbeDTXsX (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Apr 2018 19:48:23 -0400
Subject: Re: [RFC PATCH 00/79] Generic page write protection and a solution to
 page waitqueue
To: Jerome Glisse <jglisse@redhat.com>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Theodore Ts'o <tytso@mit.edu>, Tejun Heo <tj@kernel.org>,
        Jan Kara <jack@suse.cz>, Josef Bacik <jbacik@fb.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jeff Layton <jlayton@redhat.com>
References: <20180404191831.5378-1-jglisse@redhat.com>
 <6f6e3602-c8a6-ae81-3ef0-9fe18e43c841@linux.intel.com>
 <20180420221905.GA4124@redhat.com>
From: Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <1809b27e-e79d-f2c3-19f5-0f505c340519@linux.intel.com>
Date: Fri, 20 Apr 2018 16:48:22 -0700
MIME-Version: 1.0
In-Reply-To: <20180420221905.GA4124@redhat.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 04/20/2018 03:19 PM, Jerome Glisse wrote:
> On Fri, Apr 20, 2018 at 12:57:41PM -0700, Tim Chen wrote:
>> On 04/04/2018 12:17 PM, jglisse@redhat.com wrote:
>>
>>
>> Your approach seems useful if there are lots of locked pages sharing
>> the same wait queue.  
>>
>> That said, in the original workload from our customer with the long wait queue
>> problem, there was a single super hot page getting migrated, and it
>> is being accessed by all threads which caused the big log jam while they wait for
>> the migration to get completed.  
>> With your approach, we will still likely end up with a long queue 
>> in that workload even if we have per page wait queue.
>>
>> Thanks.
> 
> Ok so i re-read the thread, i was writting this cover letter from memory
> and i had bad recollection of your issue, so sorry.
> 
> First, do you have a way to reproduce the issue ? Something easy would
> be nice :)

Unfortunately it is a customer workload that they guard closely and wouldn't let us
look at the source code.  We have to profile and backtrace its behavior.

Mel made a quick attempt to reproduce the behavior with a hot page migration, 
but he wasn't quite able to duplicate the pathologic behavior.

> 
> So what i am proposing for per page wait queue would only marginaly help
> you (it might not even be mesurable in your workload). It would certainly
> make the code smaller and easier to understand i believe.

In certain cases if we have lots of pages sharing a page wait queue,
your solution would help, and we wouldn't be wasting time checking
waiters not waiting on the page that's being unlocked.  Though I
don't have a specific workload that has such behavior.

> 
> Now that i have look back at your issue i think there is 2 things we
> should do. First keep migration page map read only, this would at least
> avoid CPU read fault. In trace you captured i wasn't able to ascertain
> if this were read or write fault.
> 
> Second idea i have is about NUMA, everytime we NUMA migrate a page we
> could attach a temporary struct to the page (using page->mapping). So
> if we scan that page again we can inspect information about previous
> migration and see if we are not over migrating that page (ie bouncing
> it all over). If so we can mark the page (maybe with a page flag if we
> can find one) to protect it from further migration. That temporary
> struct would be remove after a while, ie autonuma would preallocate a
> bunch of those and keep an LRU of them and recycle the oldest when it
> needs a new one to migrate another page.

The goal to migrate a hot page with care, or avoid bouncing it around 
frequently makes sense.  If it is a hot page shared by many threads
running on different NUMA nodes, and moving it will only mildly improve NUMA
locality, we should avoid the migration.

Tim

> 
> 
> LSF/MM slots:
> 
> Michal can i get 2 slots to talk about this ? MM only discussion, one
> to talk about doing migration with page map read only but write
> protected while migration is happening. The other one to talk about
> attaching auto NUMA tracking struct to page.
> 
> Cheers,
> Jérôme
> 
