Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33159 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752661AbdBMRBp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Feb 2017 12:01:45 -0500
MIME-Version: 1.0
In-Reply-To: <20170213162941.GB18913@sbauer-Z170X-UD5>
References: <1487002272-17940-1-git-send-email-scott.bauer@intel.com>
 <1487002272-17940-4-git-send-email-scott.bauer@intel.com> <063D6719AE5E284EB5DD2968C1650D6DB028519B@AcuExch.aculab.com>
 <20170213162941.GB18913@sbauer-Z170X-UD5>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 13 Feb 2017 18:01:44 +0100
Message-ID: <CAK8P3a3-4UOkGjLWQpt9Rh=+QJNnJxJSHyha3R_-rGrqQ_LmFw@mail.gmail.com>
Subject: Re: [PATCH V5 3/4] Move stack parameters for sed_ioctl to prevent
 oversized stack with CONFIG_KASAN
To: Scott Bauer <scott.bauer@intel.com>
Cc: David Laight <David.Laight@aculab.com>,
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

On Mon, Feb 13, 2017 at 5:29 PM, Scott Bauer <scott.bauer@intel.com> wrote:
> On Mon, Feb 13, 2017 at 04:30:36PM +0000, David Laight wrote:
>> From: Scott Bauer Sent: 13 February 2017 16:11
>> > When CONFIG_KASAN is enabled, compilation fails:
>> >
>> > block/sed-opal.c: In function 'sed_ioctl':
>> > block/sed-opal.c:2447:1: error: the frame size of 2256 bytes is larger than 2048 bytes [-Werror=frame-
>> > larger-than=]
>> >
>> > Moved all the ioctl structures off the stack and dynamically activate
>> > using _IOC_SIZE()
>>
>> Think I'd not that this simplifies the code considerably.
>> AFAICT CONFIG_KASAN is a just brainf*ck.
>> It at least needs annotation that copy_from_user() has properties
>> similar to memset().
>> So if the size matches that of the type then no guard space (etc)
>> is required.

I think it still would, as the pointer to the local variable gets passed through
dev->func_data[].

>> ...
>> > +   ioctl_ptr = memdup_user(arg,  _IOC_SIZE(cmd));
>> > +   if (IS_ERR_OR_NULL(ioctl_ptr)) {
>> > +           ret = PTR_ERR(ioctl_ptr);
>> > +           goto out;
>> ...
>> > + out:
>> > +   kfree(ioctl_ptr);
>> > +   return ret;
>> >  }
>
>
>>
>> That error path doesn't look quite right to me.
>>
>>       David
>>
>
> good god, this is a mess this morning. Thanks for the catch, I'll review these
> more aggressively before sending out.

memdup_user() never returns NULL, and generally speaking any use of
IS_ERR_OR_NULL() indicates that there is something wrong with the
interface, so aside from passing the right pointer (or NULL) into kfree()
I think using IS_ERR() is the correct solution.

     Arnd
