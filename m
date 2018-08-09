Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:50864 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbeHIKea (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Aug 2018 06:34:30 -0400
MIME-Version: 1.0
In-Reply-To: <CAK=WzwePk3iREsb3mz_+RuHV_f2WhcQ9AECnMCWGW2wW=4amew@mail.gmail.com>
References: <CAK=WzwePk3iREsb3mz_+RuHV_f2WhcQ9AECnMCWGW2wW=4amew@mail.gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 9 Aug 2018 16:10:47 +0800
Message-ID: <CACVXFVMEgKEUQE8ALCjEvhxMtEzFYyP8QUM2ds8-Uw=x7USFAg@mail.gmail.com>
Subject: Re: [BUG] Loopback devices with 4k logical block size are not
 automatically scanned for GPT partitions
To: Andrew Jeddeloh <andrew.jeddeloh@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Aug 9, 2018 at 7:30 AM, Andrew Jeddeloh
<andrew.jeddeloh@redhat.com> wrote:
> I think I found a bug with partition scanning/loopback devices with 4k
> logical sectors. It affects 4.14.x and 4.17.x kernels (and presumably
> others). I've also filed the bug on the kernel bugzilla:
>
> https://bugzilla.kernel.org/show_bug.cgi?id=200749
>
> Copied from the bugzilla report:
>
> Loop devices with the logical sector size set to 4096 do not
> autodetect partitions when attached. It may be the case for devices
> with 4k logical sectors in general, but I do not have hardware to test
> that. I have not tested with non-GPT disks.

You may setup 4k sector-size with scsi_debug or qemu virtio-scsi,
then try to reproduce on these devices.

Cc block list.


Thanks,
Ming Lei
