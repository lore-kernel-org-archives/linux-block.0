Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:60290 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750784AbdAWO6L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Jan 2017 09:58:11 -0500
Date: Mon, 23 Jan 2017 09:57:52 -0500
From: Josef Bacik <jbacik@fb.com>
Subject: Re: [PATCH 4/4] nbd: add a nbd-control interface
To: Greg KH <gregkh@linuxfoundation.org>
CC: <arnd@arndb.de>, <axboe@fb.com>,
        <nbd-general@lists.sourceforge.net>, <linux-block@vger.kernel.org>,
        <kernel-team@fb.com>
Message-ID: <1485183472.21123.0@smtp.office365.com>
In-Reply-To: <20170123145212.GA19582@kroah.com>
References: <1484949412-6903-1-git-send-email-jbacik@fb.com>
        <1484949412-6903-4-git-send-email-jbacik@fb.com>
        <20170121090531.GB27048@kroah.com> <1485182528.9861.22@smtp.office365.com>
        <20170123145212.GA19582@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Jan 23, 2017 at 9:52 AM, Greg KH <gregkh@linuxfoundation.org> 
wrote:
> On Mon, Jan 23, 2017 at 09:42:08AM -0500, Josef Bacik wrote:
>> 
>> 
>>  On Sat, Jan 21, 2017 at 4:05 AM, Greg KH 
>> <gregkh@linuxfoundation.org> wrote:
>>  > On Fri, Jan 20, 2017 at 04:56:52PM -0500, Josef Bacik wrote:
>>  > >  This patch mirrors the loop back device behavior with a few
>>  > > changes.  First
>>  > >  there is no DEL operation as NBD doesn't get as much churn as 
>> loop
>>  > > devices do.
>>  > >  Secondly the GET_NEXT operation can optionally create a new NBD
>>  > > device or not.
>>  > >  Our infrastructure people want to not allow NBD to create new
>>  > > devices as it
>>  > >  causes problems for them in containers.  However allow this to 
>> be
>>  > > optional as
>>  > >  things like the OSS NBD client probably doesn't care and would 
>> like
>>  > > to just be
>>  > >  given a device to use.
>>  > >
>>  > >  Signed-off-by: Josef Bacik <jbacik@fb.com>
>>  >
>>  > A random char device with odd ioctls?  Why?  There's no other
>>  > configuration choice you could possibly use?  Where is the 
>> userspace
>>  > tool that uses this new kernel api?
>>  >
>>  > You aren't passing in structures to the ioctl, so why does this 
>> HAVE to
>>  > be an ioctl?
>> 
>>  Again, this is how loop does it so I assumed a known, regularly 
>> used API was
>>  the best bet.  I can do literally anything, but these interfaces 
>> have to be
>>  used by other people, including internal people.  The 
>> /dev/whatever-control
>>  is a well established way for interacting with dynamic device 
>> drivers (loop,
>>  DM, btrfs), so that's what I went with.  Thanks,
> 
> Again, please don't duplicate what loop did, we must _learn_ from
> history, not repeat it :(

Sure but what am I supposed to do?  Have some random sysfs knobs?  
Thanks,

Josef

