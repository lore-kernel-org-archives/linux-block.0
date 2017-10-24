Return-Path: <linux-block-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:33680 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751278AbdJXBr5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Oct 2017 21:47:57 -0400
Received: from mail-oi0-f71.google.com ([209.85.218.71])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <dann.frazier@canonical.com>)
        id 1e6oJw-0001JP-C8
        for linux-block@vger.kernel.org; Tue, 24 Oct 2017 01:47:56 +0000
Received: by mail-oi0-f71.google.com with SMTP id 82so20171501oid.11
        for <linux-block@vger.kernel.org>; Mon, 23 Oct 2017 18:47:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1508792914.2634.6.camel@wdc.com>
References: <20171020225420.utvoqmtwit2isalc@xps13.dannf> <1508542254.3029.24.camel@wdc.com>
 <20171023154129.iik3ic36i5fi7sqs@xps13.dannf> <1508792914.2634.6.camel@wdc.com>
From: dann frazier <dann.frazier@canonical.com>
Date: Mon, 23 Oct 2017 19:47:54 -0600
Message-ID: <CALdTtnuL6_Tc5QF79xrGvxT+FAJrWN4MK++d7b4+QjPktcQdcA@mail.gmail.com>
Subject: Re: [bug report] regression bisected to "block: Make most
 scsi_req_init() calls implicit"
To: Bart Van Assche <Bart.VanAssche@wdc.com>
Cc: "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Oct 23, 2017 at 3:08 PM, Bart Van Assche <Bart.VanAssche@wdc.com> wrote:
> On Mon, 2017-10-23 at 09:41 -0600, dann frazier wrote:
>> (gdb) list *(sg_io+0x120)
>> 0xffff0000084e71a8 is in sg_io (./include/linux/uaccess.h:113).
>> 108   static inline unsigned long
>> 109   _copy_from_user(void *to, const void __user *from, unsigned long n)
>> 110   {
>> 111           unsigned long res = n;
>> 112           might_fault();
>> 113           if (likely(access_ok(VERIFY_READ, from, n))) {
>> 114                   kasan_check_write(to, n);
>> 115                   res = raw_copy_from_user(to, from, n);
>> 116           }
>> 117           if (unlikely(res))
>
> Hello Dann,
>
> Would it be possible to check whether the patch below is sufficient to fix this?

hey Bart,
 Yes, it does appear to be sufficient:

ubuntu@ubuntu:~$ sudo dmesg -c > /dev/null
ubuntu@ubuntu:~$ sudo dmraid -r -c
ERROR: isw: seeking device "/dev/vda" to 18446744073708843520
ERROR: sil: seeking device "/dev/vda" to 18446744073709401600
no raid disks
ubuntu@ubuntu:~$ dmesg
ubuntu@ubuntu:~$

  -dann
