Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:33129 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726834AbeHJWEd (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 10 Aug 2018 18:04:33 -0400
Received: by mail-qt0-f193.google.com with SMTP id c15-v6so11527791qtp.0
        for <linux-block@vger.kernel.org>; Fri, 10 Aug 2018 12:33:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CACVXFVMEgKEUQE8ALCjEvhxMtEzFYyP8QUM2ds8-Uw=x7USFAg@mail.gmail.com>
References: <CAK=WzwePk3iREsb3mz_+RuHV_f2WhcQ9AECnMCWGW2wW=4amew@mail.gmail.com>
 <CACVXFVMEgKEUQE8ALCjEvhxMtEzFYyP8QUM2ds8-Uw=x7USFAg@mail.gmail.com>
From: Andrew Jeddeloh <andrew.jeddeloh@redhat.com>
Date: Fri, 10 Aug 2018 12:33:19 -0700
Message-ID: <CAK=Wzwf3+KX=RowWYMwJCw7S5-Vj+pZ5-rtxEeMAmB=X1hiNQw@mail.gmail.com>
Subject: Re: [BUG] Loopback devices with 4k logical block size are not
 automatically scanned for GPT partitions
To: Ming Lei <tom.leiming@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

I tried with qemu virtio-blk-pci (couldn't find a qemu option for
logical or physical block size for virtio-scsi-pci) and it found the
partition when booting. I see

virtio_blk virtio1: [vdb] 262144 4096-byte logical blocks (1.07 GB/1.00 GiB)

quickly followed by

 vdb: vdb1

on dmesg on bootup. I haven't tried hotplugging it yet. I don't know
if that would matter.

 - Andrew Jeddeloh

On Thu, Aug 9, 2018 at 1:10 AM, Ming Lei <tom.leiming@gmail.com> wrote:
> On Thu, Aug 9, 2018 at 7:30 AM, Andrew Jeddeloh
> <andrew.jeddeloh@redhat.com> wrote:
>> I think I found a bug with partition scanning/loopback devices with 4k
>> logical sectors. It affects 4.14.x and 4.17.x kernels (and presumably
>> others). I've also filed the bug on the kernel bugzilla:
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=200749
>>
>> Copied from the bugzilla report:
>>
>> Loop devices with the logical sector size set to 4096 do not
>> autodetect partitions when attached. It may be the case for devices
>> with 4k logical sectors in general, but I do not have hardware to test
>> that. I have not tested with non-GPT disks.
>
> You may setup 4k sector-size with scsi_debug or qemu virtio-scsi,
> then try to reproduce on these devices.
>
> Cc block list.
>
>
> Thanks,
> Ming Lei
