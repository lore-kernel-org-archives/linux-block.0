Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09F818E0E
	for <linux-block@vger.kernel.org>; Mon, 19 Aug 2024 20:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724097688; cv=none; b=lKG8GTiDSmRn3jNmpw8eiQL+uW0SqesbbKhj4xsSuAIpR7LgcLzcsr9TK1fHXF7EMyht1b3B7LizmYb3VhmJm3xPIDLk4xuGasozKZL30r9fDJFDnwjhylqhvu6vAdILdTVR9ptbB+bCT7IL7WtQv8GMoNGLIajp+Zc/o33mPp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724097688; c=relaxed/simple;
	bh=2ZE45+cgUIuyQJkodXhsuEckR1niX26Fn0JyzWLTMpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SuGeYF2sf/Dxd9aG5F8RC29+Sh9pvO31WNFMwE1T9KxRWla14XI6xvIwMT+NBZVW1dLthGfQffvNhq5noS4maR97+ZyUKjdUmgcK3e9R8g2WhtUnkwe363w7AjDL78Ub5BV6qRrWF+Baq1aZlhWMJAMMJZeyVHUi89h3JO8DHBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=kWAgMPt3; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="kWAgMPt3"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-75abb359fa5so487929a12.0
        for <linux-block@vger.kernel.org>; Mon, 19 Aug 2024 13:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1724097683; x=1724702483; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H2mIXT54Vz7IA9OZ4shkVd+tu83njeLY/qswpba/Pp4=;
        b=kWAgMPt38yxiDMcRQRfVLTddXqiX+l4gjyfVpSy8OH4X97n5p7rntF5WiADDBQ8k9R
         sT4TBVOQSJGyq0zSh2d4UCOTy75Fr8/YuPnBp2bhcy+/ijaSQu/HRUuGkPs2cuJwVhjT
         hokyuoyn0/6c9CHT4uv3E8q6ZgRFyiPNHMmDSKVnOsfaWPK/yFR6gM5HrT8O2nOwXxiG
         8tncyZ8moH8tTocc4Tsmt1eeGFQehComfZhVzig6X72yj/2MQyAN5BOQiu+XrGXF674e
         3E70tgqfEIiJGjlTdowgDypxJ6bsxPUVQJTama4OnAUuuEoxlDjFLd4BhzV4UR+I/jgZ
         h8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724097683; x=1724702483;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H2mIXT54Vz7IA9OZ4shkVd+tu83njeLY/qswpba/Pp4=;
        b=PEyQtJSWQdslkpcCHehDIIv5HLEFc0HjkBkB1F8lIU37k9AHCNTn/69tFmzHVRsXS2
         SagYhZFyNTq6BQ/+LJXmxVUXjWnH7uATRRqn3cLsUeBzWAF2SpeWWUSewyR0Nxlp+Su6
         J9nxYMy8h7WWHRuXzwWGvvl5O7Sa0VgiEqhKmQo9Ot91k4rZZa+XNgjUq/cCGxT9AVOC
         8t6ve1q6Rvba87qzUnuKuwGApTvdJbB4GbO2rktEb9tdot/a4+w30WHrY7H5v/0LXYWT
         cdNfcTAQQY9yoEh9/4DNORHYqUGvME8Z5QTrYNSgKmsvvLZMTizUrXQKaKZQpCEatnFz
         8yJg==
X-Forwarded-Encrypted: i=1; AJvYcCXNnkXBDgeuYFK+9rR3KqT+iZBNpTEHeD4l9ibD9zJPWpbFgQDkXIn/98NCanb9TzNstkQbQ/p+F274Bg==@vger.kernel.org
X-Gm-Message-State: AOJu0YykJY8IhtoVNS62HBl4HU4/47yd29+hPMtPQkKyF7mPUgur36xu
	yi44PJoskFpam+uw1scdJwzL77T6+w7f3gVz+x8PXAGEIoLciyI0oEZm+f7Of5k=
X-Google-Smtp-Source: AGHT+IGxK0714j0qnuBA0v3/eGwfOW/pLE6uS1AGzxKfJHOdxJfoqgI1eCAmaWhTaP21fMWQQG51Eg==
X-Received: by 2002:a17:902:d492:b0:202:371c:3331 with SMTP id d9443c01a7336-202371c3702mr44311775ad.9.1724097683015;
        Mon, 19 Aug 2024 13:01:23 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f038a7a6sm66237685ad.195.2024.08.19.13.01.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 13:01:22 -0700 (PDT)
Message-ID: <e9562cf8-9cf1-409e-8fbd-546d11fcba93@kernel.dk>
Date: Mon, 19 Aug 2024 14:01:21 -0600
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
 linux-mm@kvack.org
References: <cover.1723601133.git.asml.silence@gmail.com>
 <6ecd7ab3386f63f1656dc766c1b5b038ff5353c2.1723601134.git.asml.silence@gmail.com>
 <CAFj5m9+CXS_b5kgFioFHTWivb6O+R9HytsSQEHcEzUM5SqHfgw@mail.gmail.com>
 <fd357721-7ba7-4321-88da-28651754f8a4@kernel.dk>
 <e06fd325-f20f-44d8-8f72-89b97cf4186f@gmail.com> <Zr6S4sHWtdlbl/dd@fedora>
 <4d016a30-d258-4d0e-b3bc-18bf0bd48e32@kernel.dk> <Zr6vIt1uSe9/xguH@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Zr6vIt1uSe9/xguH@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/15/24 7:45 PM, Ming Lei wrote:
> On Thu, Aug 15, 2024 at 07:24:16PM -0600, Jens Axboe wrote:
>> On 8/15/24 5:44 PM, Ming Lei wrote:
>>> On Thu, Aug 15, 2024 at 06:11:13PM +0100, Pavel Begunkov wrote:
>>>> On 8/15/24 15:33, Jens Axboe wrote:
>>>>> On 8/14/24 7:42 PM, Ming Lei wrote:
>>>>>> On Wed, Aug 14, 2024 at 6:46?PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>>>>>>
>>>>>>> Add ->uring_cmd callback for block device files and use it to implement
>>>>>>> asynchronous discard. Normally, it first tries to execute the command
>>>>>>> from non-blocking context, which we limit to a single bio because
>>>>>>> otherwise one of sub-bios may need to wait for other bios, and we don't
>>>>>>> want to deal with partial IO. If non-blocking attempt fails, we'll retry
>>>>>>> it in a blocking context.
>>>>>>>
>>>>>>> Suggested-by: Conrad Meyer <conradmeyer@meta.com>
>>>>>>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>>>>>>> ---
>>>>>>>   block/blk.h             |  1 +
>>>>>>>   block/fops.c            |  2 +
>>>>>>>   block/ioctl.c           | 94 +++++++++++++++++++++++++++++++++++++++++
>>>>>>>   include/uapi/linux/fs.h |  2 +
>>>>>>>   4 files changed, 99 insertions(+)
>>>>>>>
>>>>>>> diff --git a/block/blk.h b/block/blk.h
>>>>>>> index e180863f918b..5178c5ba6852 100644
>>>>>>> --- a/block/blk.h
>>>>>>> +++ b/block/blk.h
>>>>>>> @@ -571,6 +571,7 @@ blk_mode_t file_to_blk_mode(struct file *file);
>>>>>>>   int truncate_bdev_range(struct block_device *bdev, blk_mode_t mode,
>>>>>>>                  loff_t lstart, loff_t lend);
>>>>>>>   long blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
>>>>>>> +int blkdev_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags);
>>>>>>>   long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
>>>>>>>
>>>>>>>   extern const struct address_space_operations def_blk_aops;
>>>>>>> diff --git a/block/fops.c b/block/fops.c
>>>>>>> index 9825c1713a49..8154b10b5abf 100644
>>>>>>> --- a/block/fops.c
>>>>>>> +++ b/block/fops.c
>>>>>>> @@ -17,6 +17,7 @@
>>>>>>>   #include <linux/fs.h>
>>>>>>>   #include <linux/iomap.h>
>>>>>>>   #include <linux/module.h>
>>>>>>> +#include <linux/io_uring/cmd.h>
>>>>>>>   #include "blk.h"
>>>>>>>
>>>>>>>   static inline struct inode *bdev_file_inode(struct file *file)
>>>>>>> @@ -873,6 +874,7 @@ const struct file_operations def_blk_fops = {
>>>>>>>          .splice_read    = filemap_splice_read,
>>>>>>>          .splice_write   = iter_file_splice_write,
>>>>>>>          .fallocate      = blkdev_fallocate,
>>>>>>> +       .uring_cmd      = blkdev_uring_cmd,
>>>>>>
>>>>>> Just be curious, we have IORING_OP_FALLOCATE already for sending
>>>>>> discard to block device, why is .uring_cmd added for this purpose?
>>>>
>>>> Which is a good question, I haven't thought about it, but I tend to
>>>> agree with Jens. Because vfs_fallocate is created synchronous
>>>> IORING_OP_FALLOCATE is slow for anything but pretty large requests.
>>>> Probably can be patched up, which would  involve changing the
>>>> fops->fallocate protot, but I'm not sure async there makes sense
>>>> outside of bdev (?), and cmd approach is simpler, can be made
>>>> somewhat more efficient (1 less layer in the way), and it's not
>>>> really something completely new since we have it in ioctl.
>>>
>>> Yeah, we have ioctl(DISCARD), which acquires filemap_invalidate_lock,
>>> same with blkdev_fallocate().
>>>
>>> But this patch drops this exclusive lock, so it becomes async friendly,
>>> but may cause stale page cache. However, if the lock is required, it can't
>>> be efficient anymore and io-wq may be inevitable, :-)
>>
>> If you want to grab the lock, you can still opportunistically grab it.
>> For (by far) the common case, you'll get it, and you can still do it
>> inline.
> 
> If the lock is grabbed in the whole cmd lifetime, it is basically one sync
> interface cause there is at most one async discard cmd in-flight for each
> device.

Oh for sure, you could not do that anyway as you'd be holding a lock
across the syscall boundary, which isn't allowed.

> Meantime the handling has to move to io-wq for avoiding to block current
> context, the interface becomes same with IORING_OP_FALLOCATE?

I think the current truncate is overkill, we should be able to get by
without. And no, I will not entertain an option that's "oh just punt it
to io-wq".

-- 
Jens Axboe

