Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C14A4409
	for <linux-block@vger.kernel.org>; Tue, 20 Aug 2024 16:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724171446; cv=none; b=bnuKGeCc9Mjm3w/E4oMSHIMTO6EDRkwN0YQ02Dk6LW5FF+snKP1cWBru+Sf+Uaou+9s8XBRvTWMzHC/o3uCHabZQUtdS/kMIXly43gjjAU2/sH0IFBdzuX9hJbudgII77L4TkK3uSkKaBEh5EubeNMbzVmFgZ0dEQX+4kgkV/Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724171446; c=relaxed/simple;
	bh=ZXUiYwUmwpG3dRZzBimcNRRN6x6SZl4ULXgo5/Gvikc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=trLZSVk1dgA6DDN0ZIplB5Bd/MQYhDEKlewEHzB1iMKNSpOCsafw19cvdQEaibcYm8tCaZpO2FMIhZywWyMmASihU+r3xkCKhfiaKgtofcgCJDF3aEQtddy4i+dYD9dsjZOKMe2TRy7+bhwrRq4eHLnFbUDQCfScpwUzBPCrbXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=plKemKcE; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="plKemKcE"
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-81f861f369aso208831039f.0
        for <linux-block@vger.kernel.org>; Tue, 20 Aug 2024 09:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1724171442; x=1724776242; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DYpNnAfdwkTY7rhE6SZ5xCU9aT/qWIRpF1Zi1RiAgrM=;
        b=plKemKcE47GSXzqo+wHuGf85HOu6QKo848cyB4+f/gYI6qObjRErrPhcuqTmpItiQt
         bl7cz6zDU9GZXGXqtKvKBIdS0j70LiiE1WnlY8rzTBrdKZ2E/7Doa58UTKGiB1Ksghim
         PL78gJtS0RFrIoC5cJiWW3J0+8YkuqtgnQKFFxIvWfrKbQXHUZvxLHQT0mUF+kJbp+zq
         alciMpU4ex3vYc51nwg1MYLY/G7DEe4bCHZyJ2/PL7alaWpsaGAJujn3+LNcZ8DdiUl8
         TeSWdkt+nrsTU8ZLTRxU2iIPvILYfCMW557d4k4L74bfTKDfTxxhmP83GictLoXQ6AVZ
         WEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724171442; x=1724776242;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DYpNnAfdwkTY7rhE6SZ5xCU9aT/qWIRpF1Zi1RiAgrM=;
        b=anBhlU4Qh27c43uJWaUK7DAAblBqkPoN8IBhlnQBlrveWFEMh0HD0cIxzVl6ED8weH
         SfiMHvzcIOOka67+k7MuCdxsWY0zypr5s9a8Pyrzx/xefbw2hZdKwO9ONA8f4rrIkn2e
         E49Eh2tT47rWDry+yhvx0+Lrm9ixrd9S1jU1uoyCW9OdfE/wF7Ja3tHfTLhwqLJwrXq6
         KLezO9uKcn+wfERfoEGYd2E1ZFvyAQ3Lh8QDH+zDP9jeoksG90Z3b2K2eSMaUTqTxYgO
         o/PJK9gcHDjed9iYArysZNmrI4oFk4TcOuzJqIBPKddRgNGIay8OCwGQD8AHFmbLUcW+
         Bi0A==
X-Forwarded-Encrypted: i=1; AJvYcCVaRVvsVyd/F8v66ieBRBOaByLR+YXNSLrNEn1YzlfocI9AvvapccvfT61sSxcfWjkrAo1TdT5cNKiNp0jTbsC45O8xmDwOKug6nN0=
X-Gm-Message-State: AOJu0YxlQsZr4oixngAU+uRMmgjaMWMYKBFQ9awK8ZmdJYQd5LRb7P4i
	mky08MP6XZYfcMfbzrzCMviutktJ/XEq1gTUjq9bhgmI3azUtJ7iG4lJTYDEUxg=
X-Google-Smtp-Source: AGHT+IFo1x+o4q+ouOKPox7DDrQHi+9mUH/kuJu0zMBLnyBj6r0dvjPKc26d3wbkH/VYLDydJnAxBw==
X-Received: by 2002:a05:6e02:198b:b0:39d:3c87:1435 with SMTP id e9e14a558f8ab-39d56dd821fmr44069135ab.1.1724171441835;
        Tue, 20 Aug 2024 09:30:41 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ccd6e7db2csm3879660173.32.2024.08.20.09.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 09:30:41 -0700 (PDT)
Message-ID: <d8ef3e63-1a94-45a4-974a-01324d6ce310@kernel.dk>
Date: Tue, 20 Aug 2024 10:30:40 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/5] block: implement io_uring discard cmd
To: Ming Lei <ming.lei@redhat.com>
Cc: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 Conrad Meyer <conradmeyer@meta.com>, linux-block@vger.kernel.org,
 linux-mm@kvack.org, Jan Kara <jack@suse.cz>,
 Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <cover.1723601133.git.asml.silence@gmail.com>
 <6ecd7ab3386f63f1656dc766c1b5b038ff5353c2.1723601134.git.asml.silence@gmail.com>
 <CAFj5m9+CXS_b5kgFioFHTWivb6O+R9HytsSQEHcEzUM5SqHfgw@mail.gmail.com>
 <fd357721-7ba7-4321-88da-28651754f8a4@kernel.dk>
 <e06fd325-f20f-44d8-8f72-89b97cf4186f@gmail.com> <Zr6S4sHWtdlbl/dd@fedora>
 <4d016a30-d258-4d0e-b3bc-18bf0bd48e32@kernel.dk> <Zr6vIt1uSe9/xguH@fedora>
 <e9562cf8-9cf1-409e-8fbd-546d11fcba93@kernel.dk> <ZsQBMjaBrtcFLpIj@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZsQBMjaBrtcFLpIj@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/19/24 8:36 PM, Ming Lei wrote:
> On Mon, Aug 19, 2024 at 02:01:21PM -0600, Jens Axboe wrote:
>> On 8/15/24 7:45 PM, Ming Lei wrote:
>>> On Thu, Aug 15, 2024 at 07:24:16PM -0600, Jens Axboe wrote:
>>>> On 8/15/24 5:44 PM, Ming Lei wrote:
>>>>> On Thu, Aug 15, 2024 at 06:11:13PM +0100, Pavel Begunkov wrote:
>>>>>> On 8/15/24 15:33, Jens Axboe wrote:
>>>>>>> On 8/14/24 7:42 PM, Ming Lei wrote:
>>>>>>>> On Wed, Aug 14, 2024 at 6:46?PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>>>>>>>>
>>>>>>>>> Add ->uring_cmd callback for block device files and use it to implement
>>>>>>>>> asynchronous discard. Normally, it first tries to execute the command
>>>>>>>>> from non-blocking context, which we limit to a single bio because
>>>>>>>>> otherwise one of sub-bios may need to wait for other bios, and we don't
>>>>>>>>> want to deal with partial IO. If non-blocking attempt fails, we'll retry
>>>>>>>>> it in a blocking context.
>>>>>>>>>
>>>>>>>>> Suggested-by: Conrad Meyer <conradmeyer@meta.com>
>>>>>>>>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>>>>>>>>> ---
>>>>>>>>>   block/blk.h             |  1 +
>>>>>>>>>   block/fops.c            |  2 +
>>>>>>>>>   block/ioctl.c           | 94 +++++++++++++++++++++++++++++++++++++++++
>>>>>>>>>   include/uapi/linux/fs.h |  2 +
>>>>>>>>>   4 files changed, 99 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/block/blk.h b/block/blk.h
>>>>>>>>> index e180863f918b..5178c5ba6852 100644
>>>>>>>>> --- a/block/blk.h
>>>>>>>>> +++ b/block/blk.h
>>>>>>>>> @@ -571,6 +571,7 @@ blk_mode_t file_to_blk_mode(struct file *file);
>>>>>>>>>   int truncate_bdev_range(struct block_device *bdev, blk_mode_t mode,
>>>>>>>>>                  loff_t lstart, loff_t lend);
>>>>>>>>>   long blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
>>>>>>>>> +int blkdev_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags);
>>>>>>>>>   long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
>>>>>>>>>
>>>>>>>>>   extern const struct address_space_operations def_blk_aops;
>>>>>>>>> diff --git a/block/fops.c b/block/fops.c
>>>>>>>>> index 9825c1713a49..8154b10b5abf 100644
>>>>>>>>> --- a/block/fops.c
>>>>>>>>> +++ b/block/fops.c
>>>>>>>>> @@ -17,6 +17,7 @@
>>>>>>>>>   #include <linux/fs.h>
>>>>>>>>>   #include <linux/iomap.h>
>>>>>>>>>   #include <linux/module.h>
>>>>>>>>> +#include <linux/io_uring/cmd.h>
>>>>>>>>>   #include "blk.h"
>>>>>>>>>
>>>>>>>>>   static inline struct inode *bdev_file_inode(struct file *file)
>>>>>>>>> @@ -873,6 +874,7 @@ const struct file_operations def_blk_fops = {
>>>>>>>>>          .splice_read    = filemap_splice_read,
>>>>>>>>>          .splice_write   = iter_file_splice_write,
>>>>>>>>>          .fallocate      = blkdev_fallocate,
>>>>>>>>> +       .uring_cmd      = blkdev_uring_cmd,
>>>>>>>>
>>>>>>>> Just be curious, we have IORING_OP_FALLOCATE already for sending
>>>>>>>> discard to block device, why is .uring_cmd added for this purpose?
>>>>>>
>>>>>> Which is a good question, I haven't thought about it, but I tend to
>>>>>> agree with Jens. Because vfs_fallocate is created synchronous
>>>>>> IORING_OP_FALLOCATE is slow for anything but pretty large requests.
>>>>>> Probably can be patched up, which would  involve changing the
>>>>>> fops->fallocate protot, but I'm not sure async there makes sense
>>>>>> outside of bdev (?), and cmd approach is simpler, can be made
>>>>>> somewhat more efficient (1 less layer in the way), and it's not
>>>>>> really something completely new since we have it in ioctl.
>>>>>
>>>>> Yeah, we have ioctl(DISCARD), which acquires filemap_invalidate_lock,
>>>>> same with blkdev_fallocate().
>>>>>
>>>>> But this patch drops this exclusive lock, so it becomes async friendly,
>>>>> but may cause stale page cache. However, if the lock is required, it can't
>>>>> be efficient anymore and io-wq may be inevitable, :-)
>>>>
>>>> If you want to grab the lock, you can still opportunistically grab it.
>>>> For (by far) the common case, you'll get it, and you can still do it
>>>> inline.
>>>
>>> If the lock is grabbed in the whole cmd lifetime, it is basically one sync
>>> interface cause there is at most one async discard cmd in-flight for each
>>> device.
>>
>> Oh for sure, you could not do that anyway as you'd be holding a lock
>> across the syscall boundary, which isn't allowed.
> 
> Indeed.
> 
>>
>>> Meantime the handling has to move to io-wq for avoiding to block current
>>> context, the interface becomes same with IORING_OP_FALLOCATE?
>>
>> I think the current truncate is overkill, we should be able to get by
>> without. And no, I will not entertain an option that's "oh just punt it
>> to io-wq".
> 
> BTW, the truncate is added by 351499a172c0 ("block: Invalidate cache on discard v2"),
> and block/009 serves as regression test for covering page cache
> coherency and discard.
> 
> Here the issue is actually related with the exclusive lock of
> filemap_invalidate_lock(). IMO, it is reasonable to prevent page read during
> discard for not polluting page cache. block/009 may fail too without the lock.
> 
> It is just that concurrent discards can't be allowed any more by
> down_write() of rw_semaphore, and block device is really capable of doing
> that. It can be thought as one regression of 7607c44c157d ("block: Hold invalidate_lock in
> BLKDISCARD ioctl").
> 
> Cc Jan Kara and Shin'ichiro Kawasaki.

Honestly I just think that's nonsense. It's like mixing direct and
buffered writes. Can you get corruption? Yes you most certainly can.
There should be no reason why we can't run discards without providing
page cache coherency. The sync interface attempts to do that, but that
doesn't mean that an async (or a different sync one, if that made sense)
should.

If you do discards to the same range as you're doing buffered IO, you
get to keep both potentially pieces. Fact is that most folks are doing
dio for performant IO exactly because buffered writes tend to be
horrible, and you could certainly use that with async discards and have
the application manage it just fine.

So I really think any attempts to provide page cache synchronization for
this is futile. And the existing sync one looks pretty abysmal, but it
doesn't really matter as it's a sync interfce. If one were to do
something about it for an async interface, then just pretend it's dio
and increment i_dio_count.

-- 
Jens Axboe

