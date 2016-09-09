Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:54451 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753756AbcIIXBA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 9 Sep 2016 19:01:00 -0400
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
To: Wouter Verhelst <w@uter.be>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com>
 <20160909200203.phhvodsfs7ymukfp@grep.be>
 <3536bb1d-623d-8533-1584-0040207a6c3d@fb.com>
 <20160909205535.xfl3py76z6zedejt@grep.be>
CC: <linux-block@vger.kernel.org>, <mpa@pengutronix.de>,
        <kernel-team@fb.com>, <nbd-general@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
From: Josef Bacik <jbacik@fb.com>
Message-ID: <cc4d274c-184d-02de-cd98-ad30f8cce74f@fb.com>
Date: Fri, 9 Sep 2016 19:00:28 -0400
MIME-Version: 1.0
In-Reply-To: <20160909205535.xfl3py76z6zedejt@grep.be>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/09/2016 04:55 PM, Wouter Verhelst wrote:
> On Fri, Sep 09, 2016 at 04:36:07PM -0400, Josef Bacik wrote:
>> On 09/09/2016 04:02 PM, Wouter Verhelst wrote:
> [...]
>>> I see some practical problems with this:
>>> - You removed the pid attribute from sysfs (unless you added it back and
>>>   I didn't notice, in which case just ignore this part). This kills
>>>   userspace in two ways:
>>>   - systemd/udev mark an NBD device as "not active" if the sysfs pid
>>>     attribute is absent. Removing that attribute causes the new nbd
>>>     systemd unit to stop working.
>>>   - nbd-client -check relies on this attribute too, which means that
>>>     even if people don't use systemd, their init scripts will still
>>>     break, and vigilant sysadmins (who check before trying to connect
>>>     something) will be surprised.
>>
>> Ok I can add this back, I didn't see anybody using it, but again I didn't look
>> very hard.
>
> Thank you.
>
>>> - What happens if userspace tries to connect an already-connected device
>>>   to some other server? Currently that can't happen (you get EBUSY);
>>>   with this patch, I believe it can, and data corruption would be the
>>>   result (on *two* nbd devices). Additionally, with the loss of the pid
>>>   attribute (as above) and the ensuing loss of the -check functionality,
>>>   this might actually be a somewhat likely scenario.
>>
>> Once you do DO_IT then you'll get the EBUSY, so no problems.
>
> Oh, okay. I missed that part.
>
>> Now if you modify the client to connect to two different servers then yes you
>> could have data corruption, but hey if you do stupid things then bad things
>> happen, I'm not sure we need to explicitly keep this from happening.
>
> Yeah, totally agree there.
>
>>> - What happens if one of the multiple connections drop but the others do
>>>   not?
>>
>> It keeps on trucking, but the connections that break will return -EIO.  That's
>> not good, I'll fix it to tear down everything if that happens.
>
> Right. Alternatively, you could perhaps make it so that the lost
> connection is removed, unack'd requests on that connection are resent,
> and the session moves on with one less connection (unless the lost
> connection is the last one, in which case we die as before). That might
> be too much work and not worth it though.

Yeah I wasn't sure if we could just randomly remove hw queue's in blk mq while 
the device is still up.  If that is in fact easy to do then I'm in favor of 
trucking along with less connections than we originally had, otherwise I think 
it'll be too big of a pain.  Also some users (Facebook in this case) would 
rather the whole thing fail so we can figure out what went wrong rather than 
suddenly going at a degraded performance.

>
>>> - This all has the downside that userspace now has to predict how many
>>>   parallel connections will be necessary and/or useful. If the initial
>>>   guess was wrong, we don't have a way to correct later on.
>>
>> No, it relies on the admin to specify based on their environment.
>
> Sure, but I suppose it would be nice if things could dynamically grow
> when needed, and/or that the admin could modify the number of
> connections of an already-connected device. Then again, this might also
> be too much work and not worth it.

I mean we can set some magic number, like num_connections = min(nr_cpus, 4); and 
then that way people who aren't paying attention suddenly are going faster.  I 
think anything smarter and we'd have to figure out how fast the link is and at 
what point we're hitting the diminishing returns and that path lies sadness.

>
> [...]
>>> A better way, long term, would presumably be to modify the protocol to
>>> allow multiplexing several requests in one NBD session. This would deal
>>> with what you're trying to fix too[1], while it would not pull in all of
>>> the above problems.
>>>
>>> [1] after all, we have to serialize all traffic anyway, just before it
>>>     heads into the NIC.
>>
>> Yeah I considered changing the protocol to handle multiplexing different
>> requests, but that runs into trouble since we can't guarantee that each discrete
>> sendmsg/recvmsg is going to atomically copy our buffer in.  We can accomplish
>> this with KCM of course which is a road I went down for a little while, but then
>> we have the issue of the actual data to send across, and KCM is limited to a
>> certain buffer size (I don't remember what it was exactly).  This limitation is
>> fine in practice I think, but I got such good performance with multiple
>> connections that I threw all that work away and went with this.
>
> Okay, sounds like you've given that way more thought than me, and that
> that's a dead end. Never mind then.
>

Not necessarily a dead end, but a path that requires a lot of thought and 
experimentation to figure out if it's worth it.  So maybe I'll waste an interns 
summer on figuring it out, but I've got other things I'd rather do ;).  Thanks,

Josef

