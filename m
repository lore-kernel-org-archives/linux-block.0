Return-Path: <linux-block-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:32925 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbeHJBo4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Aug 2018 21:44:56 -0400
Received: from mail-qk0-f197.google.com ([209.85.220.197])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <gpiccoli@canonical.com>)
        id 1fnuBh-0001rx-Mt
        for linux-block@vger.kernel.org; Thu, 09 Aug 2018 23:17:49 +0000
Received: by mail-qk0-f197.google.com with SMTP id 99-v6so7474706qkr.14
        for <linux-block@vger.kernel.org>; Thu, 09 Aug 2018 16:17:49 -0700 (PDT)
Subject: Re: [RFC] [PATCH 0/1] Introduce emergency raid0 stop for mounted
 arrays
To: NeilBrown <neilb@suse.com>, linux-raid@vger.kernel.org,
        shli@kernel.org
Cc: kernel@gpiccoli.net, jay.vosburgh@canonical.com,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20180801145608.19880-1-gpiccoli@canonical.com>
 <87tvodpmc8.fsf@notabene.neil.brown.name>
 <7cfa220e-c04d-b69e-fe39-5b9277f0538d@canonical.com>
 <87h8kcphze.fsf@notabene.neil.brown.name>
From: "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Message-ID: <5b7a349d-073d-4a42-eae1-aa1e6998c449@canonical.com>
Date: Thu, 9 Aug 2018 20:17:40 -0300
MIME-Version: 1.0
In-Reply-To: <87h8kcphze.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Neil, sorry for my delay.


On 02/08/2018 18:37, NeilBrown wrote:
> On Thu, Aug 02 2018, Guilherme G. Piccoli wrote:
>> [...]
>> Regarding the current behavior, one test I made was to remove 1 device
>> of a 2-disk raid0 array and after that, write a file. Write completed
>> normally (no errors from the userspace perspective), and I hashed the
>> file using md5. I then rebooted the machine, raid0 was back with the 2
>> devices, and guess what?
>> The written file was there, but corrupted (with a different hash). I
>> don't think this is something fine, user could have written important
>> data and don't realize it was getting corrupted while writing.
> 
> 
> In your test, did you "fsync" the file after writing to it?  That is
> essential for data security.
> If fsync succeeded even though the data wasn't written, that is
> certainly a bug.  If it doesn't succeed, then you know there is a
> problem with your data.
> 

Yes, I did. After writing, I ran both "sync" and "sync -f" after "dd"
command complete (with no errors). The sync procedures also finished
without errors, and the file was there. After a reboot, though, the
file has a different md5, since it was corrupted.


>> [...]
>> Using the udev/mdadm to notice a member has failed and the array must be
>> stopped might work, it was my first approach. The main issue here is
>> timing: it takes "some time" until userspace is aware of the failure, so
>> we have a window in which writes were sent between
>>
>> (A) the array member failed/got removed and
>> (B) mdadm notices and instruct driver to refuse new writes;
> 
> I don't think the delay is relevant.
> If writes are happening, then the kernel will get write error from the
> failed devices and can flag the array as faulty.
> If writes aren't happening, then it no important cost in the "device is
> removed" message going up to user-space and back.

The problem with the time between userspace notice something is wrong
and "warn" the kernel to stop writes is that many writes will be sent
to the device in this mean time, and they can completed later - handling
async completions of dead devices proved to be tricky, at least in my
approach.
Also, writeback threads will be filled with I/Os to be written to the
dead devices too, this is other part of the problem.

If you have suggestions to improve my approach, or perhaps a totally
different idea than mine, I highly appreciate the feedback.

Thank you very much for the attention.
Cheers,


Guilherme

> 
> NeilBrown
> 
>>
>> between (A) and (B), those writes are seen as completed, since they are
>> indeed complete (at least, they are fine from the page cache point of
>> view). Then, writeback will try to write those, which will cause
>> problems or they will complete in a corrupted form (the file will
>> be present in the array's filesystem after array is restored, but
>> corrupted).
>>
>> So, the in-kernel mechanism avoided most part of window (A)-(B),
>> although it seems we still have some problems when nesting arrays,
>> due to this same window, even with the in-kernel mechanism (given the
>> fact it takes some time to remove the top array when a pretty "far"
>> bottom-member is failed).
>>
>> More suggestions on how to deal with this in a definitive manner are
>> highly appreciated.
>> Thanks,
>>
>>
>> Guilherme
