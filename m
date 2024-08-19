Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EA11D6DD9
	for <linux-block@vger.kernel.org>; Mon, 19 Aug 2024 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724097733; cv=none; b=TV3y3BzjsXrdvqE2Uuf4qjBi9FvVuWxz+aQoXzIVUbCC9oeFzqDpkJaLSPXEBn7jEK8VRAxP/tNKLihqAzpNaTKJwuGPK0PTQ1ur0K3SBfpxGxiYJgekpHb2/4YZemfHIR5FuUQoOjdn+/bm90YBHlonWIE41zP53j4YUMCRucc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724097733; c=relaxed/simple;
	bh=brqBzu5hwTI9ikdmDQFMDsnGTdp+3wdYRz0VCgj12Gs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QXD8k2508h0OzFDu49MTord/NVExBE25hwLisum5+RcDcXmC+KpoWQhXFyObFt5upjN+191OM1EXVzgd1Fm04MlWgU1dZnx3njD55EErQpa+18UOczFC4Xs7LkGeT+tJ8/ty0OmsBwn5mIPcH/XMxeH2TWaeDd9Jj0aX0vaM2Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=fiHPE709; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="fiHPE709"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2d3bc9405c2so632340a91.2
        for <linux-block@vger.kernel.org>; Mon, 19 Aug 2024 13:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1724097731; x=1724702531; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pBkl3+XvJeAklRL+6TFbxoUucjnynnJ4wXSRFBTFaQc=;
        b=fiHPE709FnI1QiEOtQZ2ekHW1o2kHh7Y1qp0mPb7KGrdWtotEhOBN5+537v9T+YyuJ
         TICWCnJo2xeQdoXSu7ejX+oayAGi2I2KQ9K+YbEJwnhj/Oj7E8nNhiG46Fa+xtgS4QSH
         9ffCxO/IJMbUCUOhuNnUkHnY5OA3eM0nDbIbgqow9wIN1XmzB0FrBR8mV+IcBNMaZhHv
         SwLEMC++KyX8hwAj/NFt6ZGPaPMaHSX5YxKvKr9ZtxVV9IISBA93NiAlsvJG10gVQk/X
         I9/Y4wdoLj8OpHix+8Ba9FMUIFXOX2hNAe+V4frrpy5Gwloi89WCoKg6tof/XXOX8v/X
         3MCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724097731; x=1724702531;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pBkl3+XvJeAklRL+6TFbxoUucjnynnJ4wXSRFBTFaQc=;
        b=sxI5K1hfysPUj1CPr0KBc7FWpFb38y5qG8z/TKZC9yL2ZE4DfryOrhHpgf5pE0xWvU
         36lqhgSg+iIRDn9XtnqcNxHEmyyiQyZQe9tvqWx+g0oh19Cp4NPNtGCte1tG8j7iQ4sl
         cXdlouqfwHv0PXxsxRqI5niccR1lh1N43l1uhNSikb4qfzq/84taN+5cKkVXtOOmhfME
         +by81VWhzf5LfMSJyJ89FW3opKXoe7GO6Urck7COlhf0OXoy6UxJfitVbTK3OIDPRr0Q
         qMf+31lwuE2Mo5cXJC895s0qxXrb9NxhgnDHV9UHoIaIppn4Tq+l0nZT7ovTHTSulSS3
         MB3g==
X-Forwarded-Encrypted: i=1; AJvYcCX1n8eAHv1TIMYd0DZb8xZfuSus7SWXw0ObgyBU0A5yAF5NE9riK+4ZpfHkeO2gRguB2Zz7NDUMu+7h2g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5KM4EqWDEWGZONci49nQVdsucX62+K4AB/GgMn6trwiO55PfR
	966Vf20abYl9W4yRs7i+7FTRzmYZhQUbp+Y7DGBxJ90w1YjFCcbggdngpeLNP/I=
X-Google-Smtp-Source: AGHT+IGhGfvDEMLkeZJwlMhyh4v1+tO0SzOoGdLBcZEfbz9YTeG1J9v2kob+e+94rKiTd1PuLu4OJw==
X-Received: by 2002:a17:90a:d517:b0:2d3:c488:fa6b with SMTP id 98e67ed59e1d1-2d3e151f6d8mr8019983a91.5.1724097730914;
        Mon, 19 Aug 2024 13:02:10 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d3e2e6b1f6sm7772049a91.19.2024.08.19.13.02.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 13:02:10 -0700 (PDT)
Message-ID: <5d7aabe5-3988-4a85-b329-4dfe89b22582@kernel.dk>
Date: Mon, 19 Aug 2024 14:02:09 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/5] block: implement io_uring discard cmd
To: Pavel Begunkov <asml.silence@gmail.com>, Ming Lei <ming.lei@redhat.com>
Cc: io-uring@vger.kernel.org, Conrad Meyer <conradmeyer@meta.com>,
 linux-block@vger.kernel.org, linux-mm@kvack.org
References: <cover.1723601133.git.asml.silence@gmail.com>
 <6ecd7ab3386f63f1656dc766c1b5b038ff5353c2.1723601134.git.asml.silence@gmail.com>
 <CAFj5m9+CXS_b5kgFioFHTWivb6O+R9HytsSQEHcEzUM5SqHfgw@mail.gmail.com>
 <fd357721-7ba7-4321-88da-28651754f8a4@kernel.dk>
 <e06fd325-f20f-44d8-8f72-89b97cf4186f@gmail.com> <Zr6S4sHWtdlbl/dd@fedora>
 <4d016a30-d258-4d0e-b3bc-18bf0bd48e32@kernel.dk> <Zr6vIt1uSe9/xguH@fedora>
 <df7c7a6c-3d6f-459b-a7c4-3c105c7b67c5@gmail.com> <Zr60qvr5u1Z4/aZC@fedora>
 <dbfd1a3f-a8b6-4d05-943e-4a1387c9d03a@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <dbfd1a3f-a8b6-4d05-943e-4a1387c9d03a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/15/24 8:16 PM, Pavel Begunkov wrote:
> On 8/16/24 03:08, Ming Lei wrote:
>> On Fri, Aug 16, 2024 at 02:59:49AM +0100, Pavel Begunkov wrote:
>>> On 8/16/24 02:45, Ming Lei wrote:
>>>> On Thu, Aug 15, 2024 at 07:24:16PM -0600, Jens Axboe wrote:
>>>>> On 8/15/24 5:44 PM, Ming Lei wrote:
>>>>>> On Thu, Aug 15, 2024 at 06:11:13PM +0100, Pavel Begunkov wrote:
>>>>>>> On 8/15/24 15:33, Jens Axboe wrote:
>>>>>>>> On 8/14/24 7:42 PM, Ming Lei wrote:
>>>>>>>>> On Wed, Aug 14, 2024 at 6:46?PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>>>>>>>>>
>>>>>>>>>> Add ->uring_cmd callback for block device files and use it to implement
>>>>>>>>>> asynchronous discard. Normally, it first tries to execute the command
>>>>>>>>>> from non-blocking context, which we limit to a single bio because
>>>>>>>>>> otherwise one of sub-bios may need to wait for other bios, and we don't
>>>>>>>>>> want to deal with partial IO. If non-blocking attempt fails, we'll retry
>>>>>>>>>> it in a blocking context.
>>>>>>>>>>
>>>>>>>>>> Suggested-by: Conrad Meyer <conradmeyer@meta.com>
>>>>>>>>>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>>>>>>>>>> ---
>>>>>>>>>>     block/blk.h             |  1 +
>>>>>>>>>>     block/fops.c            |  2 +
>>>>>>>>>>     block/ioctl.c           | 94 +++++++++++++++++++++++++++++++++++++++++
>>>>>>>>>>     include/uapi/linux/fs.h |  2 +
>>>>>>>>>>     4 files changed, 99 insertions(+)
>>>>>>>>>>
>>>>>>>>>> diff --git a/block/blk.h b/block/blk.h
>>>>>>>>>> index e180863f918b..5178c5ba6852 100644
>>>>>>>>>> --- a/block/blk.h
>>>>>>>>>> +++ b/block/blk.h
>>>>>>>>>> @@ -571,6 +571,7 @@ blk_mode_t file_to_blk_mode(struct file *file);
>>>>>>>>>>     int truncate_bdev_range(struct block_device *bdev, blk_mode_t mode,
>>>>>>>>>>                    loff_t lstart, loff_t lend);
>>>>>>>>>>     long blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
>>>>>>>>>> +int blkdev_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags);
>>>>>>>>>>     long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
>>>>>>>>>>
>>>>>>>>>>     extern const struct address_space_operations def_blk_aops;
>>>>>>>>>> diff --git a/block/fops.c b/block/fops.c
>>>>>>>>>> index 9825c1713a49..8154b10b5abf 100644
>>>>>>>>>> --- a/block/fops.c
>>>>>>>>>> +++ b/block/fops.c
>>>>>>>>>> @@ -17,6 +17,7 @@
>>>>>>>>>>     #include <linux/fs.h>
>>>>>>>>>>     #include <linux/iomap.h>
>>>>>>>>>>     #include <linux/module.h>
>>>>>>>>>> +#include <linux/io_uring/cmd.h>
>>>>>>>>>>     #include "blk.h"
>>>>>>>>>>
>>>>>>>>>>     static inline struct inode *bdev_file_inode(struct file *file)
>>>>>>>>>> @@ -873,6 +874,7 @@ const struct file_operations def_blk_fops = {
>>>>>>>>>>            .splice_read    = filemap_splice_read,
>>>>>>>>>>            .splice_write   = iter_file_splice_write,
>>>>>>>>>>            .fallocate      = blkdev_fallocate,
>>>>>>>>>> +       .uring_cmd      = blkdev_uring_cmd,
>>>>>>>>>
>>>>>>>>> Just be curious, we have IORING_OP_FALLOCATE already for sending
>>>>>>>>> discard to block device, why is .uring_cmd added for this purpose?
>>>>>>>
>>>>>>> Which is a good question, I haven't thought about it, but I tend to
>>>>>>> agree with Jens. Because vfs_fallocate is created synchronous
>>>>>>> IORING_OP_FALLOCATE is slow for anything but pretty large requests.
>>>>>>> Probably can be patched up, which would  involve changing the
>>>>>>> fops->fallocate protot, but I'm not sure async there makes sense
>>>>>>> outside of bdev (?), and cmd approach is simpler, can be made
>>>>>>> somewhat more efficient (1 less layer in the way), and it's not
>>>>>>> really something completely new since we have it in ioctl.
>>>>>>
>>>>>> Yeah, we have ioctl(DISCARD), which acquires filemap_invalidate_lock,
>>>>>> same with blkdev_fallocate().
>>>>>>
>>>>>> But this patch drops this exclusive lock, so it becomes async friendly,
>>>>>> but may cause stale page cache. However, if the lock is required, it can't
>>>>>> be efficient anymore and io-wq may be inevitable, :-)
>>>>>
>>>>> If you want to grab the lock, you can still opportunistically grab it.
>>>>> For (by far) the common case, you'll get it, and you can still do it
>>>>> inline.
>>>>
>>>> If the lock is grabbed in the whole cmd lifetime, it is basically one sync
>>>> interface cause there is at most one async discard cmd in-flight for each
>>>> device.
>>>>
>>>> Meantime the handling has to move to io-wq for avoiding to block current
>>>> context, the interface becomes same with IORING_OP_FALLOCATE?
>>>
>>> Right, and agree that we can't trylock because we'd need to keep it
>>> locked until IO completes, at least the sync versions does that.
>>>
>>> But I think *invalidate_pages() in the patch should be enough. That's
>>> what the write path does, so it shouldn't cause any problem to the
>>> kernel. As for user space, that'd be more relaxed than the ioctl,
>>> just as writes are, so nothing new to the user. I hope someone with
>>> better filemap understanding can confirm it (or not).
>>
>> I may not be familiar with filemap enough, but looks *invalidate_pages()
>> is only for removing pages from the page cache range, and the lock is added
>> for preventing new page cache read from being started, so stale data read
>> can be avoided when DISCARD is in-progress.
> 
> Sounds like it, but the point is it's the same data race for the
> user as if it would've had a write in progress.

Right, which is why it should not matter. I think it's pretty silly to
take the sync implementation as gospel here, assuming that the original
author knew what they were doing in full detail. It just needs proper
documenting.

-- 
Jens Axboe


