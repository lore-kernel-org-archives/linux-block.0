Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39917 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbeG1Nhz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Jul 2018 09:37:55 -0400
Received: by mail-wm0-f65.google.com with SMTP id h20-v6so8384015wmb.4
        for <linux-block@vger.kernel.org>; Sat, 28 Jul 2018 05:11:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180727154741.v2ubbwerblyug43a@destiny>
References: <CACVXFVNKAhGkievaHXDvPngw7xW5hWg_0oOSLXD1R4uaxSJs3w@mail.gmail.com>
 <83C56CD1-93E0-41E3-AF41-27C4F33851FE@fb.com> <20180722072804.GA955@ming.t460p>
 <20180727154741.v2ubbwerblyug43a@destiny>
From: Ming Lei <tom.leiming@gmail.com>
Date: Sat, 28 Jul 2018 20:11:33 +0800
Message-ID: <CACVXFVOuaCT6Q04ztFubLAZUhPPXjpCdDNckoRquN1jvtb8eZw@mail.gmail.com>
Subject: Re: [Bug] block/for-next: IO hang in rq_qos_throttle
To: Josef Bacik <josef@toxicpanda.com>
Cc: Ming Lei <ming.lei@redhat.com>, Josef Bacik <jbacik@fb.com>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jul 27, 2018 at 11:47 PM, Josef Bacik <josef@toxicpanda.com> wrote:
> On Sun, Jul 22, 2018 at 03:28:05PM +0800, Ming Lei wrote:
>> On Sun, Jul 22, 2018 at 02:15:38AM +0000, Josef Bacik wrote:
>> > Yup I sent a patch for this on Thursday, sorry about that,
>> >
>>
>> I just applied the patch of 'blk-rq-qos: make depth comparisons unsigned',
>> looks the same IO hang can be triggered too.
>
> Ok I'm back from vacation and I'm trying to reproduce but it's not happening for
> me.  What testing infrastructure is this?  blktests and xfstests don't have a
> sanity/ in their test suites.  I'm wondering if there's something else about the
> test that I'm missing.  Thanks,

As I mentioned,

The following IO hang is triggered on dbench test on xfs/usb-storage:

      dbench -t 20 -s 64

thanks,
Ming Lei
