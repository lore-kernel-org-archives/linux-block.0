Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] [LSF/MM ATTEND] FS Management Interfaces
To: Jan Kara <jack@suse.cz>
References: <c13ef7f9-e687-5fcc-6fdb-5dd6f1122227@redhat.com>
 <20170110101441.GD32191@quack2.suse.cz>
Cc: lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-block@vger.kernel.org, David Lehman <dlehman@redhat.com>,
        Justin Mitchell <jumitche@redhat.com>,
        paul evans <pevans@redhat.com>, Jan Tulak <jtulak@redhat.com>
From: Steven Whitehouse <swhiteho@redhat.com>
Message-ID: <82bfb4fa-cf87-3db8-3907-4ae7b760d30e@redhat.com>
Date: Wed, 11 Jan 2017 12:07:32 +0000
MIME-Version: 1.0
In-Reply-To: <20170110101441.GD32191@quack2.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-fsdevel-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Hi,


On 10/01/17 10:14, Jan Kara wrote:
> Hi,
>
> On Tue 10-01-17 09:44:59, Steven Whitehouse wrote:
>> I had originally thought about calling the proposal "kernel/userland
>> interface", however that seemed a bit vague and management interfaces seems
>> like a better title since it is I hope a bit clearer of the kind of thing
>> that I'm thinking about in this case.
>>
>> There are a number of possible sub-topics and I hope that I might find a few
>> more before LSF too. One is that of space management (we have statfs, but
>> currently no notifications for thresholds crossed etc., so everything is
>> polled. That is ok sometimes, but statfs can be expensive in the case of
>> distributed filesystems, if 100% accurate. We could just have ENOSPC
>> notifications for 100% full, or something more generic), another is state
>> transitions (is the fs running normally, or has it gone read
>> only/withdrawn/etc due to I/O errors?) and a further topic would be working
>> towards a common interface for fs statistics (at the moment each fs defines
>> their own interface). One potential implementation, at least for the first
>> two sub-topics, would be to use something along the lines of the quota
>> netlink interface, but since few ideas survive first contact with the
>> community at large, I'm throwing this out for further discussion and
>> feedback on whether this approach is considered the right way to go.
>>
>> Assuming the topic is accepted, my intention would be to gather together
>> some additional sub-topics relating to fs management to go along with those
>> I mentioned above, and I'd be very interested to hear of any other issues
>> that could be usefully added to the list for discussion.
> So this topic came up last year and probably the year before as well (heh,
> I can even find some patches from 2011 [1]). I think the latest attempt at
> what you suggest was here [2]. So clearly there's some interest in these
> interfaces but not enough to actually drive anything to completion. So for
> this topic to be useful, I think you need to go at least through the
> patches in [2] and comments to them and have a concrete proposal that can
> be discussed and some commitment (not necessarily from yourself) that
> someone is going to devote time to implement it. Because generally nobody
> seems to be opposed to the abstract idea but once it gets to the
> implementation details, it is non-trivial to get some wider agreement
> (statx anybody? ;)).
>
> 								Honza
>
> [1] https://lkml.org/lkml/2011/8/18/170
> [2] https://lkml.org/lkml/2015/6/16/456

Yes, statx is something else I'd like to see progress too :-) Going back 
to this topic though, I agree wrt having a concrete proposal, and I'll 
try and have something ready for LSF, we have a few weeks in hand. I'll 
collect up the details of the previous efforts (including Lukas' 
suggestion) and see how far we can get in the mean time,

Steve.


