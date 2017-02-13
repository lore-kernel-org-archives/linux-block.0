Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:33099 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751578AbdBMUQT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 13 Feb 2017 15:16:19 -0500
MIME-Version: 1.0
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DB02851D7@AcuExch.aculab.com>
References: <1487002272-17940-1-git-send-email-scott.bauer@intel.com>
 <1487002272-17940-4-git-send-email-scott.bauer@intel.com> <063D6719AE5E284EB5DD2968C1650D6DB028519B@AcuExch.aculab.com>
 <20170213162941.GB18913@sbauer-Z170X-UD5> <CAK8P3a3-4UOkGjLWQpt9Rh=+QJNnJxJSHyha3R_-rGrqQ_LmFw@mail.gmail.com>
 <063D6719AE5E284EB5DD2968C1650D6DB02851D7@AcuExch.aculab.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 13 Feb 2017 21:16:18 +0100
Message-ID: <CAK8P3a1gqtEB76nZTNKpBTko-j7aPx-XHwsZFKzW7EzCbBcX6A@mail.gmail.com>
Subject: Re: [PATCH V5 3/4] Move stack parameters for sed_ioctl to prevent
 oversized stack with CONFIG_KASAN
To: David Laight <David.Laight@aculab.com>
Cc: Scott Bauer <scott.bauer@intel.com>,
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

On Mon, Feb 13, 2017 at 6:07 PM, David Laight <David.Laight@aculab.com> wrote:
> From: Arnd Bergmann
>> Sent: 13 February 2017 17:02
> ...
>> >> > +   ioctl_ptr = memdup_user(arg,  _IOC_SIZE(cmd));
>> >> > +   if (IS_ERR_OR_NULL(ioctl_ptr)) {
>> >> > +           ret = PTR_ERR(ioctl_ptr);
>> >> > +           goto out;
>> >> ...
>> >> > + out:
>> >> > +   kfree(ioctl_ptr);
>> >> > +   return ret;
> ...
>> >> That error path doesn't look quite right to me.
> ...
>> > good god, this is a mess this morning. Thanks for the catch, I'll review these
>> > more aggressively before sending out.
>>
>> memdup_user() never returns NULL, and generally speaking any use of
>> IS_ERR_OR_NULL() indicates that there is something wrong with the
>> interface, so aside from passing the right pointer (or NULL) into kfree()
>> I think using IS_ERR() is the correct solution.
>
> You missed the problem entirely.
> Code needs to be:
>         if (IS_ERR(ioctl_ptr))
>                 return PTR_ERR(ioctl_ptr);

Sorry if that wasn't clear, I expected the part about the kfree(errptr) to be
obvious but was trying to avoid having Scott go through another revision
for removing the IS_ERR_OR_NULL() after fixing the first problem.

    Arnd
