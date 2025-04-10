Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644A928CF4F
	for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 13:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744290792; cv=none; b=oQDMSGiL0riaa+JhiQnt11JL4X0rn3JgHQCtBfV/pc6PbAGkHVJQdNu/Pd+yk512ByNszFkjMlGJzpF0ushfO28TlHDBt+4fe0xVlHpT5m2lfcPmnkULJzTR2268Uf2UYak8yZ02W1NlfCJ/0TyEEHnwmgVzIsgyWnhq9Gh4kqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744290792; c=relaxed/simple;
	bh=+K6IGVBKpgAQ/4RP+cmVB+BtGZh7Ur4ESWOvOz8Ytpk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GMFTbaFsxTb+NsWh2hpc4eJkNFQKo/EL1Ww/5iT8qWiKn5O90e/FOFaI2e7kA9a+O3MQgoIfH0K1KXJeRgqKeHnnE/ACASedLRW9FGTcitM2pVkPllXa+c4JN/J/n7JRVLljjgdcTJcIMYHBxyVBJkSFM9zwtJ9BZn2H1qTYcmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=f8ZuV0Ok; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="f8ZuV0Ok"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3d46fddf357so3216575ab.2
        for <linux-block@vger.kernel.org>; Thu, 10 Apr 2025 06:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1744290788; x=1744895588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=d6rRsebI68acXpc7mzteuwF+RadeeW/k6hUVIar8ffs=;
        b=f8ZuV0OkBHOmcU9BYBuuhjo6rKoh1gGpd22c795ByTR0fDUKibzUgcuABxZrFW7hYf
         NkgtOrsvS/E4yA7A0/EfOoNay82eeORSG/trRb/vP5Qs8i+LmWdcR2tE7mif7o4GUnGI
         4Ymqri3gWeEYsd06/5ut/8yGxM0IZaL3saBRZO4ZSDvXeUHT6HbnnPV7qJuyvK3xWEsI
         113H4V+Z/9V86GsObdheVUrbeOqGKRKE+UdBnu3FiT4zGpdy+QBicIDtj0PrNEzKTkHW
         xwk0s2gb7JfyTW/ftblol7iSFBWGR+tYudvE82yC5otLHh5EzkB03tDvsZ8nO87TAIIG
         cx6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744290788; x=1744895588;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d6rRsebI68acXpc7mzteuwF+RadeeW/k6hUVIar8ffs=;
        b=qMUoy2zugoVhseXnbMlROPs/1Yude8PijItULn4Dzx83i27siJgdFFc7Q7gsuekKK1
         jDXbU8bBISW4+fBHnkMd5Y81O1i+GB6dpkf/h/cqWBulMpPtZcBaxjR9mgd5H+K23Pbh
         hYU8jC4yM1Wlc3zXIYQrs7dOWjBjNYo1P0LnzFV/qCOINFbnTfVY8MxGmfHalY5RZ+uR
         r8m8sgN2eToWEaeqiv4pvhZYdgl8WeQmPQNph6aWQGRYfKrmA6NNsJ0QJ1ibK5PoHDQ8
         tf8V/bUuJzpim4lX7tn+tc45JtB8rIQKyEhmp2m3nrJNHZUcWo3ad9EW7IHpwVarOk8+
         Fm9A==
X-Forwarded-Encrypted: i=1; AJvYcCXbPueK0GO2cEFvmjn2mIhHF/ce/oDdLMnF43oHtdBVnfqS6GQaDJe1QN+4KlAzSKGWqyWUCs5HgOwc4g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt0UWMGD1i6zBDbGrHYwLF+e9P/XEl6bVh7TfSc8GjlN3zCp1f
	SkSSIC2S8rwORIBX+gzYQTXjV+oWGhOb6c7ei3RTjz4mH2Wn4yx9bBdgteQ0VfU=
X-Gm-Gg: ASbGncth/o0sRFRbRaukgbCp9f5xHHFRdx1FycXJURlixB5lswRJ2RZWq1wmNx/oITG
	mVtLHwP1wjiedkuQnnuZQdwRAAb2uJbPZKeBjA39glI5bJvhr5gugLBk7RitPpGgA7QrWJwPF5L
	awDmHpv8UDEDJonjRlo8pHG+XR7c+aa8jGUXqtjM6xoedSRKD9vbW4t9r1WS/3xnA5SUFYU2H5W
	NKeISvfuH6PzxqlITi6DBmQaYp7JSob1MxymjijrsVeYyG6axhzK8MTqsCNld0yJLAXtadQwiI3
	QcBt4AYK5iSvc9qP2y7+nZmGNigaw2K+IF6R
X-Google-Smtp-Source: AGHT+IGspj9FuU6O2i8qKXi7iDEDFyU9L4Qc4D+0U3PfGoMhguebwekQBeApegxv5iCZt34JUnWBZQ==
X-Received: by 2002:a05:6e02:1d8e:b0:3d3:dcc4:a58e with SMTP id e9e14a558f8ab-3d7e5f5afadmr21297745ab.8.1744290788198;
        Thu, 10 Apr 2025 06:13:08 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f505d173c4sm742356173.36.2025.04.10.06.13.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Apr 2025 06:13:07 -0700 (PDT)
Message-ID: <a76ac487-564e-4b6e-89fb-9c848a398c43@kernel.dk>
Date: Thu, 10 Apr 2025 07:13:06 -0600
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ublk: skip blk_mq_tag_to_rq() bounds check
To: Christoph Hellwig <hch@infradead.org>,
 Caleb Sander Mateos <csander@purestorage.com>
Cc: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250409024955.3626275-1-csander@purestorage.com>
 <Z_eOX-8QHxsq21Rz@infradead.org>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Z_eOX-8QHxsq21Rz@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/10/25 3:24 AM, Christoph Hellwig wrote:
> On Tue, Apr 08, 2025 at 08:49:54PM -0600, Caleb Sander Mateos wrote:
>> The ublk driver calls blk_mq_tag_to_rq() in several places.
>> blk_mq_tag_to_rq() tolerates an invalid tag for the tagset, checking it
>> against the number of tags and returning NULL if it is out of bounds.
>> But all the calls from the ublk driver have already verified the tag
>> against the ublk queue's queue depth. In ublk_commit_completion(),
>> ublk_handle_need_get_data(), and case UBLK_IO_COMMIT_AND_FETCH_REQ, the
>> tag has already been checked in __ublk_ch_uring_cmd(). In
>> ublk_abort_queue(), the loop bounds the tag by the queue depth. In
>> __ublk_check_and_get_req(), the tag has already been checked in
>> __ublk_ch_uring_cmd(), in the case of ublk_register_io_buf(), or in
>> ublk_check_and_get_req().
>>
>> So just index the tagset's rqs array directly in the ublk driver.
>> Convert the tags to unsigned, as blk_mq_tag_to_rq() does.
> 
> Poking directly into block layer internals feels like a really bad
> idea.  If this is important enough we'll need a non-checking helper
> in the core code, but as with all these kinds of micro-optimizations
> it better have a really good justification.

FWIW, I agree, and I also have a hard time imagining this making much of
a measurable difference. Caleb, was this based "well this seems
pointless" or was it something you noticed in profiling/testing?

-- 
Jens Axboe
