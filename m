Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E56920C00A
	for <linux-block@vger.kernel.org>; Tue,  5 May 2026 07:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777965642; cv=none; b=cwi3MDpLnK3eJ5nKaxVWoEBZ/wyvYH92aErqVszrNUKBl8wVefIMx6W/ymPK4uWeNCZjcSA5sdqyiDGBwcjbhrl7TTuWNQCwGw38RlK7P0mvCOt/Vw3J0ZSDoNGMSuZzlN9tBqjc8DMjHxgP3OKoCwgkGz5/S0bQlBESHzKmgHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777965642; c=relaxed/simple;
	bh=qYjYOzAUq1mArZRvykIJzcZis19BKn+v0cgyoQsi7bE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eAG736A/lxfs6phrHWBrHGlKytTJdNHjiRERiRMAvjXm2P6hVDXdCPopBIBdUVNXC4bTi565yw1W1Q77U739remQKBBfKkTws2oK5Qtie4y5MWnvuxpnmbIBP5sd+2XjPqnedw4wVYXtycIFV5MfXSnJrhQtQYZVVEltP6jnMfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=b1siioBj; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="b1siioBj"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso36335025e9.3
        for <linux-block@vger.kernel.org>; Tue, 05 May 2026 00:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1777965637; x=1778570437; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lJQV4o7EngsrJVsXXyMvIqLzKoNPTM9P7REBeZfdcfA=;
        b=b1siioBjO5KTRGdiRhXQrK2ThB7hDKlwJ6MBxN8JOA7Fqz0t/HCgrF+o7JDfQZ5pXS
         HWvYYBvrWjUhg0/mUtGhtULdnt4ngHvm0C9MjGcEUDv7D9hVygDwQvNhCqDn6cOfpZBE
         VUf4IBqcXUOZc2ydrgqs2YSYfzKAhRYjzIeTs3WdMckL10w7QZXpw087fmvmy56HsSSO
         5ltKYY0MixsjOQ0AKoyfxizlOIxhbaqkKrvfof+gHolVsWDfVKuyALsmPVTeGgUGWspS
         PCar0yfA3liK/AFNGjjZ0zpzRLgKLpQN/6QJ1e/kTab3TmX57CseftLCHwii8+XLVhFN
         112g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777965637; x=1778570437;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lJQV4o7EngsrJVsXXyMvIqLzKoNPTM9P7REBeZfdcfA=;
        b=qdLI7zQv8PwBgkVk0/lGQWDFYFtFsJKoJyYW/sPbtcc9DNRlJBMaYAn0M7pOU3FtDS
         uYdyQQMEFsZNMPTM7UG8EmLpZdpbbb6bfXxc7IICV/mBtqmd1W9Jc4z2UWlAXOyyU8FS
         C121Rmvl29eEXSoLAJROpkk3wrv3Vl7wfadhMUYElaXLpPf0R+G/rjoFNC0ezl2FWFJ4
         SF9jcKKH4sYOrTzhOdst2hflyp2gewbpiZ47UJ4pAUdf+lzE8N3tidE1AdU0X1U7KcCD
         T68lV1sn6O8z2m54h9s3V35f1X29iPp/QUa2xvRFp+e+oUKQv4HTg5/pGQy+iUFbTuPt
         /OmQ==
X-Gm-Message-State: AOJu0YzizGYUM8a9xoHuDPwfYIKG9w8WQvqjlTVg9GM5Lln00cGpeSW+
	hW/ZfJQUQ61vQzjxBmY+PY/LFScBa25aWW3JfW807WyyyQ1ItXJ9XGViFVNyrKRJyGCw6q0ju/J
	NyeGcoTs=
X-Gm-Gg: AeBDiesl/rGUTujnuz3IiNhWar7BSx9AsL8Xg6yUaGePZw3EiFo3mFLu+sBJzVi/yKB
	jtfRXuAxTOZQ3HcUny0Rf2Itqw1ySE5qK5bUzDURocDs7VdA1Hg+4e8TDOOyYQNPueEQC9mQ8wy
	zlTjHTO0/wgFefhwJzlfNN5mqpIkLRBNp2qrkJlj/9q1phD8K1kYKY/4rOACXR5EoRZ9sxD5jFB
	p5tWRGZKAuXSzRDVWuYBDV+WJLf7qwn8UOTRD9GEDcDhQLdhHYXg3w9cVL7orvJvfkkBGo6Dr6r
	jhga2h3YlStsot+/IEmeZarQS+nuKrigQcCtgVDyOEWxDQ4poDePDCrl/UEBzB03TBhUErqLkqm
	DoNcU3qUSz+s8JTEzslhjSERBIM7ATmV+r+RVafZLOOjqJWAcNTupe0HegsKq27R088O+vJos5q
	zWRkPEj27pZ1ZYPeYvYCZ77SAFmkepu9jlvOnulKWX7pmpKM47Y7iNmk2Y5en6pspvrhw6j2MCG
	24YPaBynxJv7npFotUr
X-Received: by 2002:a05:600c:4f8e:b0:486:fbdb:b718 with SMTP id 5b1f17b1804b1-48d18ce4b2amr26409615e9.25.1777965636607;
        Tue, 05 May 2026 00:20:36 -0700 (PDT)
Received: from [10.211.9.173] ([213.147.98.98])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81b99127sm371750775e9.0.2026.05.05.00.20.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2026 00:20:35 -0700 (PDT)
Message-ID: <ccd71c69-05db-407d-817b-e43fff3f3525@kernel.dk>
Date: Tue, 5 May 2026 01:20:34 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] block: only read from sqe on initial invocation of
 blkdev_uring_cmd()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
References: <14e454d3-8f27-459a-a515-8a2b70ac109d@kernel.dk>
 <CADUfDZqw6P1a5Q55cEgAPbULxJatEXNL6UXyn=ftS_dqBBqq9A@mail.gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CADUfDZqw6P1a5Q55cEgAPbULxJatEXNL6UXyn=ftS_dqBBqq9A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/4/26 11:40 AM, Caleb Sander Mateos wrote:
> On Mon, May 4, 2026 at 7:39 AM Jens Axboe <axboe@kernel.dk> wrote:
>>
>> This passthrough helper currently only supports discards. Part of that
>> command is the start and length, which is read from the SQE. It does
>> so on every invocation, where it really should just make it stable
>> on the first invocation. This avoids needing to copy the SQE upfront,
>> as we only really need those two 8b values stored in our per-req
>> payload.
>>
>> Cc: stable@vger.kernel.org # 6.17+
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>>
>> ---
>>
>> diff --git a/block/ioctl.c b/block/ioctl.c
>> index fc3be0549aa7..6aa02575e08d 100644
>> --- a/block/ioctl.c
>> +++ b/block/ioctl.c
>> @@ -857,6 +857,8 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
>>  #endif
>>
>>  struct blk_iou_cmd {
>> +       u64 start;
>> +       u64 len;
>>         int res;
>>         bool nowait;
>>  };
>> @@ -946,23 +948,27 @@ int blkdev_uring_cmd(struct io_uring_cmd *cmd, unsigned int issue_flags)
>>  {
>>         struct block_device *bdev = I_BDEV(cmd->file->f_mapping->host);
>>         struct blk_iou_cmd *bic = io_uring_cmd_to_pdu(cmd, struct blk_iou_cmd);
>> -       const struct io_uring_sqe *sqe = cmd->sqe;
>>         u32 cmd_op = cmd->cmd_op;
>> -       uint64_t start, len;
>>
>> -       if (unlikely(sqe->ioprio || sqe->__pad1 || sqe->len ||
>> -                    sqe->rw_flags || sqe->file_index))
>> -               return -EINVAL;
>> +       /* Read what we need from the SQE on the first issue */
>> +       if (issue_flags & IO_URING_F_INLINE) {
> 
> I don't think IO_URING_F_INLINE is guaranteed to be set on the first
> issue? For example, a subsequent command in a linked chain, or one
> that sets REQ_F_FORCE_ASYNC or REQ_F_IO_DRAIN will be issued
> asynchronously originally. Could you check !(issue_flags &
> IORING_URING_CMD_REISSUE) instead?

Good point, that is more self-explanatory too (and correct). I'll
make the change.

-- 
Jens Axboe

