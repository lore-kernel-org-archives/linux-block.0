Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f47.google.com ([209.85.218.47]:34299 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755034AbdEGWYn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 7 May 2017 18:24:43 -0400
Received: by mail-oi0-f47.google.com with SMTP id b204so32877640oii.1
        for <linux-block@vger.kernel.org>; Sun, 07 May 2017 15:24:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAMuHMdV_CvOZ91KXjwEEUOWCKCkkgLkd3T=K5aP6kPgo+ZKQPQ@mail.gmail.com>
References: <CAMuHMdV_CvOZ91KXjwEEUOWCKCkkgLkd3T=K5aP6kPgo+ZKQPQ@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Sun, 7 May 2017 11:26:12 -0700
Message-ID: <CAPcyv4jrWS6ityJO_qNqbs1EtOpeU45YXUeXO+D1CLYJHkaJng@mail.gmail.com>
Subject: Re: BLOCK selects DAX (was: Re: dax: introduce dax_direct_access())
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sun, May 7, 2017 at 9:20 AM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Hi Dan,
>
> On Sat, May 6, 2017 at 4:21 AM, Linux Kernel Mailing List
> <linux-kernel@vger.kernel.org> wrote:
>> Web:        https://git.kernel.org/torvalds/c/b0686260fecaa924d8eff2ace94bee70506bc308
>> Commit:     b0686260fecaa924d8eff2ace94bee70506bc308
>> Parent:     d8f07aee3f2fd959878bf614d4e984900018eb9e
>> Refname:    refs/heads/master
>> Author:     Dan Williams <dan.j.williams@intel.com>
>> AuthorDate: Thu Jan 26 20:37:35 2017 -0800
>> Committer:  Dan Williams <dan.j.williams@intel.com>
>> CommitDate: Thu Apr 20 11:57:52 2017 -0700
>>
>>     dax: introduce dax_direct_access()
>>
>>     Replace bdev_direct_access() with dax_direct_access() that uses
>>     dax_device and dax_operations instead of a block_device and
>>     block_device_operations for dax. Once all consumers of the old api have
>>     been converted bdev_direct_access() will be deleted.
>>
>>     Given that block device partitioning decisions can cause dax page
>>     alignment constraints to be violated this also introduces the
>>     bdev_dax_pgoff() helper. It handles calculating a logical pgoff relative
>>     to the dax_device and also checks for page alignment.
>>
>>     Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> This looks like a fairly innocent change...
>
>> ---
>>  block/Kconfig          |  1 +
>>  drivers/dax/super.c    | 39 +++++++++++++++++++++++++++++++++++++++
>>  fs/block_dev.c         | 14 ++++++++++++++
>>  include/linux/blkdev.h |  1 +
>>  include/linux/dax.h    |  2 ++
>>  5 files changed, 57 insertions(+)
>>
>> diff --git a/block/Kconfig b/block/Kconfig
>> index e9f780f815f5..93da7fc3f254 100644
>> --- a/block/Kconfig
>> +++ b/block/Kconfig
>> @@ -6,6 +6,7 @@ menuconfig BLOCK
>>         default y
>>         select SBITMAP
>>         select SRCU
>> +       select DAX

Whoops, yes, that should be "select DAX if FS_DAX". We don't need the
DAX core if we're never going to mount a DAX capable filesystem.

>>         help
>>          Provide block layer support for the kernel.
>
> ... but it is not: now DAX is always enabled if you use block devices.
>
>     $ bloat-o-meter vmlinux.nodax vmlinux.dax  | head
>     add/remove: 59/0 grow/shrink: 10/1 up/down: 6048/-8 (6040)
>     function                                     old     new   delta
>     dax_host_list                                  -    4096   +4096
>     alloc_dax                                      -     306    +306
>     dax_fs_init                                    -     230    +230
>     dax_get_by_host                                -     128    +128
>     dax_sops                                       -     100    +100
>     dax_srcu                                       -      90     +90
>     dax_direct_access                              -      80     +80
>     bdev_dax_pgoff                                 -      80     +80
>
> Does all block device access really needs DAX enabled?
>
> Furthermore:
>
>       Maximum number of Device-DAX instances (NR_DEV_DAX) [32768] (NEW) ?
>
>     There is no help available for this option.
>     Symbol: NR_DEV_DAX [=32768]
>     Type  : integer
>     Range : [256 2147483647]
>     Prompt: Maximum number of Device-DAX instances
>       Location:
>         -> Device Drivers
>           -> DAX: direct access to differentiated memory (DAX [=y])
>       Defined at drivers/dax/Kconfig:31
>       Depends on: DAX [=y]
>
> What should I answer here?
> "256" already sounds like a large number to me, "32768" sounds huge, and
> "2147483647" sounds insane? But perhaps this doesn't really mean what I
> would expect...
>
> Can you please add some help for this option?

Will do. The number gets passed directly to the @count parameter of
alloc_chrdev_region().
