Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35591 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752081AbdBJLAN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Feb 2017 06:00:13 -0500
MIME-Version: 1.0
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DB02833C4@AcuExch.aculab.com>
References: <1486660801-5105-1-git-send-email-scott.bauer@intel.com>
 <1486660801-5105-3-git-send-email-scott.bauer@intel.com> <e82756b9-df77-6033-b6ce-fbf9aac3b9a8@suse.de>
 <063D6719AE5E284EB5DD2968C1650D6DB02833C4@AcuExch.aculab.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 10 Feb 2017 12:00:03 +0100
Message-ID: <CAK8P3a1VkAjZyWbJEUBFsuH2096cVbXZsYX-KpZDwvvVUE3G5w@mail.gmail.com>
Subject: Re: [PATCH V3 2/2] Move stack parameters for sed_ioctl to prevent
 oversized stack with CONFIG_KASAN
To: David Laight <David.Laight@aculab.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>,
        Scott Bauer <scott.bauer@intel.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "jonathan.derrick@intel.com" <jonathan.derrick@intel.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Feb 10, 2017 at 11:28 AM, David Laight <David.Laight@aculab.com> wrote:

>>
>> > -           if (copy_from_user(&session, arg, sizeof(session)))
>> > -                   return -EFAULT;
>> > -           return opal_erase_locking_range(dev, &session);
>> > +   ioctl_ptr = kzalloc(cmd_size, GFP_KERNEL);
>> > +   if (!ioctl_ptr)
>> > +           return -ENOMEM;
>> > +   if (copy_from_user(ioctl_ptr, arg, cmd_size)) {
>> > +           ret = -EFAULT;
>> > +           goto out;
>> >     }
>>
>> Can't we use memdup_user() instead of kzalloc() + copy_from_user()?
>
> You either want the copy_from_user() or the memzero() not both.
>
> ISTM there could be two 'library' functions, maybe:
> void *get_ioctl_buf(unsigned int cmd, long arg)
> to malloc the buffer, memzero/copy_from_user, returns -EFAULT if copy fails.
> int put_ioctl_buf(int rval, unsigned int cmd, const void *buf)
> does copy_to_user() if rval >= 0 and IOR_READ, then frees buf.
> return value is rval unless the copyout fails.

All the ioctls commands in this driver are IOW, and no data is passed back
to user space, so there is no need for the memzero(): we can either copy
the data from user space or we fail.

    Arnd
