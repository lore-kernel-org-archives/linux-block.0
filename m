Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42452 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1754654AbcIIUge (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 9 Sep 2016 16:36:34 -0400
Subject: Re: [Nbd] [RESEND][PATCH 0/5] nbd improvements
To: Wouter Verhelst <w@uter.be>
References: <1473369130-22986-1-git-send-email-jbacik@fb.com>
 <20160909200203.phhvodsfs7ymukfp@grep.be>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-team@fb.com>, <mpa@pengutronix.de>,
        <nbd-general@lists.sourceforge.net>
From: Josef Bacik <jbacik@fb.com>
Message-ID: <3536bb1d-623d-8533-1584-0040207a6c3d@fb.com>
Date: Fri, 9 Sep 2016 16:36:07 -0400
MIME-Version: 1.0
In-Reply-To: <20160909200203.phhvodsfs7ymukfp@grep.be>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 09/09/2016 04:02 PM, Wouter Verhelst wrote:
> Hi Josef,
>
> On Thu, Sep 08, 2016 at 05:12:05PM -0400, Josef Bacik wrote:
>> Apologies if you are getting this a second time, it appears vger ate my last
>> submission.
>>
>> ----------------------------------------------------------------------
>>
>> This is a patch series aimed at bringing NBD into 2016.  The two big components
>> of this series is converting nbd over to using blkmq and then allowing us to
>> provide more than one connection for a nbd device.  The NBD user space server
>> doesn't care about how many connections it has to a particular device, so we can
>> easily open multiple connections to the server and allow blkmq to handle
>> multi-plexing over the different connections.
>
> I see some practical problems with this:
> - You removed the pid attribute from sysfs (unless you added it back and
>   I didn't notice, in which case just ignore this part). This kills
>   userspace in two ways:
>   - systemd/udev mark an NBD device as "not active" if the sysfs pid
>     attribute is absent. Removing that attribute causes the new nbd
>     systemd unit to stop working.
>   - nbd-client -check relies on this attribute too, which means that
>     even if people don't use systemd, their init scripts will still
>     break, and vigilant sysadmins (who check before trying to connect
>     something) will be surprised.

Ok I can add this back, I didn't see anybody using it, but again I didn't look 
very hard.

> - What happens if userspace tries to connect an already-connected device
>   to some other server? Currently that can't happen (you get EBUSY);
>   with this patch, I believe it can, and data corruption would be the
>   result (on *two* nbd devices). Additionally, with the loss of the pid
>   attribute (as above) and the ensuing loss of the -check functionality,
>   this might actually be a somewhat likely scenario.

Once you do DO_IT then you'll get the EBUSY, so no problems.  Now if you modify 
the client to connect to two different servers then yes you could have data 
corruption, but hey if you do stupid things then bad things happen, I'm not sure 
we need to explicitly keep this from happening.

> - What happens if one of the multiple connections drop but the others do
>   not?

It keeps on trucking, but the connections that break will return -EIO.  That's 
not good, I'll fix it to tear down everything if that happens.

> - This all has the downside that userspace now has to predict how many
>   parallel connections will be necessary and/or useful. If the initial
>   guess was wrong, we don't have a way to correct later on.

No, it relies on the admin to specify based on their environment.

>
> My suggestion is to reject an additional connection unless it comes from
> the same userspace process as the previous connections, and to retain
> the pid attribute (since it is now guaranteed to be the same for all the
> connections). That should fix the first two issues (while unfortunately
> reinforcing the last one). The third would also need to have clearly
> defined semantics, at the very least.

Yeah that sounds reasonable to me, I hadn't thought of some other pid trying to 
setup a device at the same time.

>
> A better way, long term, would presumably be to modify the protocol to
> allow multiplexing several requests in one NBD session. This would deal
> with what you're trying to fix too[1], while it would not pull in all of
> the above problems.
>
> [1] after all, we have to serialize all traffic anyway, just before it
>     heads into the NIC.
>

Yeah I considered changing the protocol to handle multiplexing different 
requests, but that runs into trouble since we can't guarantee that each discrete 
sendmsg/recvmsg is going to atomically copy our buffer in.  We can accomplish 
this with KCM of course which is a road I went down for a little while, but then 
we have the issue of the actual data to send across, and KCM is limited to a 
certain buffer size (I don't remember what it was exactly).  This limitation is 
fine in practice I think, but I got such good performance with multiple 
connections that I threw all that work away and went with this.

Thanks for the review, I'll fix up these issues you've pointed out and resend,

Josef
