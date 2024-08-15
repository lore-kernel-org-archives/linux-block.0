Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC8C19FA99
	for <linux-block@vger.kernel.org>; Thu, 15 Aug 2024 14:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723732420; cv=none; b=AVzqoQ9Qs30drDffxLclY/8CVXcOIT+7uXnKMG1Ro7Qp+uafF5XjZyi6ojhfmRMLcKDLe1Y8c/7bB99KYrsZl4hDLpsE6jnEO/5U6vMN8jS1MwBxuNHnxpTou93EFVdK5Y3mn9livpx3wjgyXHzPWGeJPoViddu6xZvLsz+r4Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723732420; c=relaxed/simple;
	bh=DSUGtq/9K941kinoQIx3PPemHfZMHkN9rIaiuu2LfGQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a/FzY0OZ88H6AY6M+N8daCmNaYlth8oCq93bJ1rb+lpV3XwnEE0Mf9xKuc1c7CBgHRs1c02LidTqQwrObXi+z3owkJ033divB4TP6QZMNn6bGVHdSNnEYSuImXjZMlKnTJH4+402Us+rabRRMF9bmcug2kamE6kHn47l3/0EHhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=FKl1OVJw; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="FKl1OVJw"
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-81f902e94e6so3523439f.0
        for <linux-block@vger.kernel.org>; Thu, 15 Aug 2024 07:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1723732416; x=1724337216; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6rICprDujQR2UM4HfjMuX0CO7+q7wHZGrKy7Agwu530=;
        b=FKl1OVJwAR1kZuBLBeUXm1I2Pj9nn+wI4xSPZWhpWnYc5wTSn6U4qU/zl21sMBWGlG
         5rJVOGvq6Ws4Nqc6Ppp5jLVjgLkd568kTW3q91duWRM0zIFPZ9roLnwLI59sMmnRIXRJ
         7b/nmDFbPemPGm/zcmSfvOPGnGMnTes4tvtCwAs9LVv4N9VY1xgMmBMk5rzLlsnUUPOr
         Z1LOyWOQshsScLd3wrec6ABcmTahHO+FnwFR3dfecSS4rWzWv34H0MNR1b3IReIh4Ola
         kKfmjGMtZ8byxyhRksWgjcQuIkVA5Lvc9akLRCaoCGLrb0qo3dIfCv6NYUPqAHKwkmAE
         TJEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723732416; x=1724337216;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6rICprDujQR2UM4HfjMuX0CO7+q7wHZGrKy7Agwu530=;
        b=wIXBDXj/QAIqrttgO6nemuF/mGjyWoTlqI7RTenx7hr3oFID7AbIU5xejDNbHsokc6
         gajuwpVs7Xke/YNFu7+33nLyFSL80nezodskCki2tNUcHb0cWIAnYZ4PXjZSIiij2aqe
         oTzNBVVq5Y4c2dKevUgBkuvUTs3gwHIPHTPFbynnfguC0rQq96tvWz/5UsOlREkSc7ou
         1JlojvBBTlHEqupOg8RKZKKMvccBg+wSJMIQ/Bxj1bsw0XeF3Apq0k6130/Gfcz139WC
         rMXlhomXm7GPWgrL7S7KHWDJa684aP1H4MPsQZTU5mz8gvyB5YScesJFGx9ahqNby56s
         rf9w==
X-Forwarded-Encrypted: i=1; AJvYcCUP8u0YRDPYvOlLngovA2KrzwYqim/HFDpPX3nkNDazzifcHbtbeCCPMRNrpFOLaGEogECy20dndCKm4NgEh4HHsOGh+lfD7Mg3WPk=
X-Gm-Message-State: AOJu0YwFN3QFKQGCCaENnacxb6v2LtmBoYSnf630+mwvzbyHx2gnmogl
	Q+Sqx1vDGOcD338n5pvq0AaGDSXAVDzBBoMlaaxNmwDBxthFIj7TwxroQCK08xs=
X-Google-Smtp-Source: AGHT+IGvpiwXjlJpt5son2O8gjjV3rFX1h5+5bydBPLKRSpEg1HWIUur+IBQ2exWat+kjseYTgNOvQ==
X-Received: by 2002:a6b:6305:0:b0:7f6:85d1:f81a with SMTP id ca18e2360f4ac-824e86c307dmr186663439f.2.1723732416308;
        Thu, 15 Aug 2024 07:33:36 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-824e98eda17sm52953239f.6.2024.08.15.07.33.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Aug 2024 07:33:35 -0700 (PDT)
Message-ID: <fd357721-7ba7-4321-88da-28651754f8a4@kernel.dk>
Date: Thu, 15 Aug 2024 08:33:34 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/5] block: implement io_uring discard cmd
To: Ming Lei <ming.lei@redhat.com>, Pavel Begunkov <asml.silence@gmail.com>
Cc: io-uring@vger.kernel.org, Conrad Meyer <conradmeyer@meta.com>,
 linux-block@vger.kernel.org, linux-mm@kvack.org
References: <cover.1723601133.git.asml.silence@gmail.com>
 <6ecd7ab3386f63f1656dc766c1b5b038ff5353c2.1723601134.git.asml.silence@gmail.com>
 <CAFj5m9+CXS_b5kgFioFHTWivb6O+R9HytsSQEHcEzUM5SqHfgw@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAFj5m9+CXS_b5kgFioFHTWivb6O+R9HytsSQEHcEzUM5SqHfgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/24 7:42 PM, Ming Lei wrote:
> On Wed, Aug 14, 2024 at 6:46?PM Pavel Begunkov <asml.silence@gmail.com> wrote:
>>
>> Add ->uring_cmd callback for block device files and use it to implement
>> asynchronous discard. Normally, it first tries to execute the command
>> from non-blocking context, which we limit to a single bio because
>> otherwise one of sub-bios may need to wait for other bios, and we don't
>> want to deal with partial IO. If non-blocking attempt fails, we'll retry
>> it in a blocking context.
>>
>> Suggested-by: Conrad Meyer <conradmeyer@meta.com>
>> Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
>> ---
>>  block/blk.h             |  1 +
>>  block/fops.c            |  2 +
>>  block/ioctl.c           | 94 +++++++++++++++++++++++++++++++++++++++++
>>  include/uapi/linux/fs.h |  2 +
>>  4 files changed, 99 insertions(+)
>>
>> diff --git a/block/blk.h b/block/blk.h
>> index e180863f918b..5178c5ba6852 100644
>> --- a/block/blk.h
>> +++ b/block/blk.h
>> @@ -571,6 +571,7 @@ blk_mode_t file_to_blk_mode(struct file *file);
>>  int truncate_bdev_range(struct block_device *bdev, blk_mode_t mode,
>>                 loff_t lstart, loff_t lend);
>>  long blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
>> +int blkdev_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags);
>>  long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
>>
>>  extern const struct address_space_operations def_blk_aops;
>> diff --git a/block/fops.c b/block/fops.c
>> index 9825c1713a49..8154b10b5abf 100644
>> --- a/block/fops.c
>> +++ b/block/fops.c
>> @@ -17,6 +17,7 @@
>>  #include <linux/fs.h>
>>  #include <linux/iomap.h>
>>  #include <linux/module.h>
>> +#include <linux/io_uring/cmd.h>
>>  #include "blk.h"
>>
>>  static inline struct inode *bdev_file_inode(struct file *file)
>> @@ -873,6 +874,7 @@ const struct file_operations def_blk_fops = {
>>         .splice_read    = filemap_splice_read,
>>         .splice_write   = iter_file_splice_write,
>>         .fallocate      = blkdev_fallocate,
>> +       .uring_cmd      = blkdev_uring_cmd,
> 
> Just be curious, we have IORING_OP_FALLOCATE already for sending
> discard to block device, why is .uring_cmd added for this purpose?

I think wiring up a bdev uring_cmd makes sense, because:

1) The existing FALLOCATE op is using vfs_fallocate, which is inherently
   sync and hence always punted to io-wq.

2) There will most certainly be other async ops that would be
   interesting to add, at which point we'd need it anyway.

3) It arguably makes more sense to have a direct discard op than use
   fallocate for this, if working on a raw bdev.

And probably others...

-- 
Jens Axboe

