Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793108324;
	b=Gm8EyAMJkPKNOuvUhhMvWhK1ln/FO7WfXaniwRLoYLvNtoYm2jv5MIxfH1iN0Afm86Aq
	 qtPnQ5i9QC9ZpDQCrMUa2ExyEK6tL7zLx9P9cSz65KI8q4kPoYlQIxBu8m/WONIckYdik
	 A5AaxSLhlG10Ju+xl17WUfI3DrEMCKpps/ZBit69kiZPqZn3xzCviAz7wqn685oON+fYj
	 3rIHfdkTrKSf+GDjgfKDGzNPwhhaOda3bBOLADmwzuhreGoju1Rmcom/xvSw7XbFXSAEm
	 grXoEd1m4+RQoOLu5TMdpyxB9r2PLieI8WEOf3+u+jtHjovLtOPwxOLJ8OORvqdAy5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793108324;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:From:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=aMXzMChEGdcJMKKjeeeyUhIhhKoRWxvP81BBpiRyepA=;
	b=z9tevbs+w/3GmeGaCF0l3wCUl+jJMsH8mNRfqTGnGJwXsw/FhJKXuOr85DA+7WuXpkZ0
	 x0aDvHAa+BXCt30ruAeSu9VFl3EF7aF3shPRGakjUDb480ppXq1OWlSH3wEn+iPw9ekNR
	 0JZtHSqHwel+UIfQfN3DPHXHWAbLhd27iYV7IHzHMEsN5/QrDXLcOx9vv3dWHR9XoPSiD
	 NvGrd1uJ0Wd2vp5G430RWa+SO2cym/NbHGTRuC7FCnEEAWpxV4u7w0HmSlmX1WXv5fN0H
	 V3hF57xyn3TcdVLB8srADsgMEg+5FYzqn6m5AWy4JI133pQoppcLv+S+WyUVrq7/XqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lAxHIhv7;
	arc=none smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB7F606A31A
	for <linux-block@vger.kernel.org>; Tue, 27 Oct 2026 13:38:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEB7F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lAxHIhv7
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c37b612635bso553770066b.3
        for <linux-block@vger.kernel.org>; Tue, 27 Oct 2026 06:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793108322; x=1793713122; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aMXzMChEGdcJMKKjeeeyUhIhhKoRWxvP81BBpiRyepA=;
        b=lAxHIhv7ojOHCvA4AyPbMIGbCDdoIOGB+7gsMo/uQgGVkSmdWdLPUhht7cwCpUqrna
         nxA16JuIIm70bvPsqImmllfgTCzWJyOiUFDp5StIuMnpQvZN3z+M3uXbd22e6FqD1mge
         2I8sSIyan5T4FwkQ+HMx9NTErd6/CVu6VDa6Kmk+6crSMOAAvaC4ImnwpHvJoPa7ITC0
         vrF/6uosAWqevUTnWSx7Qxxmtvvb9/296S/AT3wX10DxSma/5Vr7UUEztp+g7qQNLs1d
         I0ykvyL3Sxf3Xwu8f+OWDfmk7xK8Qr7NQ+HinPZ3Ef9AQ+63CND1zDl0JPg4WLq7wgjJ
         yMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793108322; x=1793713122;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aMXzMChEGdcJMKKjeeeyUhIhhKoRWxvP81BBpiRyepA=;
        b=1olZe+ySsUUtPcvAXEccCguPl6NHoYjXYWXcxHKhiyaWar+vTWksMyIknBgLE1b7S9
         lO5tWbjA5deAp1ZPTUiqUdlaotm6f768oXu9SY/DUllvYr6hhvc3WERF5a3xsV0DCUSK
         Vcc4YlqjNfStKCIBaGisCGOM9tu3GeQb/Y04qSw+hWJipvH7NDnpdZ2UfKfz6+UKgPsw
         erd2k/lNBYbyXkmMyh0EMSsZVP3JSMv6VfIiwKyQo1PetuBWiV2z8ByKVj4GyrUS53qc
         6muyxaURB8AD3U7b8bqvNQBqN+fdk5D99fNKdXllsRmfjBcxrdPpdgbEEW3ZY3GbOgGI
         Rnew==
X-Forwarded-Encrypted: i=1; AKwUvBxboUJsgV6IEvqC8owWVM6Nq0hKualbPMwodCVFouvceepqwua+rNCNhAMHxzQCX6Oq/HTJeHByrUR9cQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIXWt6MKG/1pHUGNmu7xAJTMK0fdLDUb3jdOuoOJ6T9/9V+W3lm
	66aN2GcMDbeZbx5so+OI9jf+qM2N1yaTeLqXM2BCSvO/MzAgil+GColhRQFrRw==
X-Gm-Gg: AYBFou2jTTgZkyQALuY6QDPDJ3d8HzAOvTAh9yg0rEw/8ZIyKNuX8uZ4Yn47b84Y2hN
	OjCqp6C5296jMpsrevnQ7e4E8agP1+vD0lDWn4Py9kHAgImmVfgE+ZbDqknPLlar1KkXg1kP8OY
	U77DmcLd0G7AyATB+IKOOTNaTO1SnexWJG/bGavXvLkqZT5oHMHeD9w+ofLN2mq/2m0bG0X2PGy
	Gm8fcLlcBBQGh3f0hPfN+PonUV/U/ZstADQWQPAC1LOHoxQfYGg/6qxnocNrdDRs+TfMldaE4RC
	c510QT80CnTFDr4PVCT/yNawY9HAdWC+Xew86iJt2bpNSL/YBx8aOhS8ogTK2vjaKDtF4KexNP+
	PM+jlVaU2aOLJgH8D8Ai5bIvoczVI1icl4lG/QhtlaCTYj5IAAZZnYdnGnS3Mvv6Le3J/BEFvNG
	buR8Etuo3yBq/Rjl0WE7KeBM++jNfLzwUKtK7HSACSFA/TWepXZ2Hq60HO848IoiCRwSzTpnC3E
	RWXdxMLSGZR6A7exZH2NPm9nnKQ/mjSsl8duAiWlgigXTZifvTNbYCezPILmppSb//hwuLLpV4h
	vXng3Mzh0bWatuMYO8EdLLtpCpt7vvKKrgc5RD00SXF4AUnJ3kDuHERC51DWuj7j7ccevA3pFy+
	xcFtGO98=
X-Received: by 2002:a17:907:3f86:b0:c46:7645:874 with SMTP id a640c23a62f3a-c46bded79a3mr1114595166b.48.1793108322016;
        Tue, 27 Oct 2026 06:38:42 -0700 (PDT)
Received: from [10.54.182.141] (82-132-213-26.dab.02.net. [82.132.213.26])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46bd649f69sm453325666b.43.2026.10.27.06.38.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 06:38:41 -0700 (PDT)
Message-ID: <dc128acb-d033-43e0-adb0-f866c638c7ae@gmail.com>
Date: Tue, 27 Oct 2026 13:38:32 +0000
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] block: reject dma-bufs larger than 4GiB
From: Pavel Begunkov <asml.silence@gmail.com>
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, axboe@kernel.dk
Cc: hch@lst.de, Keith Busch <kbusch@kernel.org>
References: <20261021184658.644645-1-kbusch@meta.com>
 <20261021184658.644645-2-kbusch@meta.com>
 <7c1599a8-31df-4797-a794-bf5ba3d75286@gmail.com>
Content-Language: en-US
In-Reply-To: <7c1599a8-31df-4797-a794-bf5ba3d75286@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/23/26 18:52, Pavel Begunkov wrote:
> On 10/21/26 19:46, Keith Busch wrote:
>> From: Keith Busch <kbusch@kernel.org>
>>
>> The dma-buf offset is set in the 32-bit bvec_iter bi_offset. Reject
>> buffers that can carry an offset that would wrap.
>>
>> Fixes: 839231d19393 ("block: add dma-buf support for raw bdev")
>> Signed-off-by: Keith Busch <kbusch@kernel.org>
>> ---
>>   block/fops.c | 3 ++++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/block/fops.c b/block/fops.c
>> index 46cb86dd36d23..a974b423869eb 100644
>> --- a/block/fops.c
>> +++ b/block/fops.c
>> @@ -19,6 +19,7 @@
>>   #include <linux/iomap.h>
>>   #include <linux/module.h>
>>   #include <linux/io_uring/cmd.h>
>> +#include <linux/dma-buf-io.h>
>>   #include "blk.h"
>>   static inline struct inode *bdev_file_inode(struct file *file)
>> @@ -1009,6 +1010,9 @@ static int blkdev_init_dma_buf_io_ctx(struct file *file,
>>       if (!(file->f_flags & O_DIRECT))
>>           return -EINVAL;
>> +    if (ctx->dmabuf->size > UINT_MAX)
>> +        return -EINVAL;
> 
> Sounds good, should be reasonable for now. It'd also be good to
> move it to dma-buf-io* as it's not a block problem.

fwiw, I was wrong here assuming that iov_iter's offset is also u32.

-- 
Pavel Begunkov

