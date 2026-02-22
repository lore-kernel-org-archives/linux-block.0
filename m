Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3271C1FB1
	for <linux-block@vger.kernel.org>; Sun, 22 Feb 2026 16:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771777796; cv=none; b=FBrpeceS2cz8QpTZFwNSrIHYxqQtPVDCL3bMTNfTKHH5xF7yR2oRrGQ+PCOacEozFsAq9Y9tI/SQyM7X3f5nyPe7YuooKA5TMUhIFmQOCV4eRXyZG9i96NxA7x/GADSaXNCTxh95GBL+JqWpsIeMBWozkkcnOdJIz3424QPsmU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771777796; c=relaxed/simple;
	bh=rp4sBhlhbPpyWwc2T+aQzi7TLADL0kLHu+9JE0xOsS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N3D3WM5f1vpL6ZMZrDfN4u67djq4S9XUGre4Tx2oDYHATdnX1xBTMB7tB6280YUz+Tu1FGvWLmjg7klHLDAnfZ7/nDqTXaQOR/wAAoYz7c3QVCqod1hagwFmZkA6zV9NnzxlvrY+j0kkGa5Etr7hCnZybW3s0DX9+/xshXtCJCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=CeG3rHnh; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="CeG3rHnh"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6774d63d2e0so972837eaf.1
        for <linux-block@vger.kernel.org>; Sun, 22 Feb 2026 08:29:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1771777793; x=1772382593; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nSuCVZADkqgg6rkPYNhvm84R3P4gGR/vtSEzoKkW1wM=;
        b=CeG3rHnhMEdInrsqMbG7VSD/tWnbu5E/gSSV+tJQxOfMFxaRVh3WLa431R9sH/MnVe
         C3+Bey9i15jLebQmrvAPfJYFXKYeuW2llJOfwZDelxzLmoryQxw6RksHqzIVRu7T+SV4
         GaJHgvCfYnjx1fOWewdx9IemwNBgUFuZN4t1hiibP6K42jwxpfCYT9UcJgHbAD4uTrL2
         Xs/teNZd4YDjX+IQseoG9xyWW7FqjsoTBIYTO4TNlU8vs5k43KPgEpiLPcrZXIU4Hoje
         s0QEUrnuTNZ+Jad5/xP7NqFBNf3VUHEMy8TD30PtBZgXb2FDxulGXsuui4Is5N3aL6Y5
         j6uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771777793; x=1772382593;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nSuCVZADkqgg6rkPYNhvm84R3P4gGR/vtSEzoKkW1wM=;
        b=RkXT9MDiQBIDaE4m2bpohPyKxGl7Pb4I+DOPcol2F79TtCyDNqJuZ+2c2tFmv7IYVD
         g+GMmmd1RZoTFY7+8gbljfmxNH1a3XDfnpjiWcCcaJj3F7wmXIaJOesOP8VOxz7mSbQq
         xw38sliX3IyF65Camf53aqeUIP4ztd+h9h8WCF+lVh8awk8F7Yn3u0cSzh7nnL9N+v5d
         ZP8rVbGg/7l3wZQwf7qjEzA8Z1N37TmWyi3u7ZzcNXagb6ZzgLhDAle/zMZlpGX396WA
         SMKPgi01UT5lllsf/GaaAV5lu46ppYs/ql3jnbxwpkGr3dHOzPX1pG9nkWUwfXtZftt2
         acSA==
X-Gm-Message-State: AOJu0YwueicDcAxD+EGpxdGpXiWi+WgtUlOPD0IZ/hze5VX0MMrbLD7d
	xOx3fnVRdf6bzKNMfrUxR0bZ61XxCXiOXdHpwFTs93P9qKWoBf11Od87kUgrl1fZzfY=
X-Gm-Gg: AZuq6aIjSybAm2TTNTFGYEsCecP/ks7DMDq9Xj9QW8ZO8KJDtXUCSsVOilXbxfouvWW
	ni4GIf5WkB9J0WEgSXKb5s0ByJ718D028HPkkgw1FdWTQYRBtjiX0CUWxQ14OtmE8qv4Rw/MydK
	1/W+PDpFQFU2H+0jFjVHtV1fvtAyYf4fxzGPfJIjAL6KffZguzzYiMfNrsT2KNFrR/UjdZYtjmC
	9S1D8mNiA3ut+4KMPMgq1D6KTuIv9IKTmF3IZ4P/zJ7KenkXAY9gWd1KJfmGqwkIs+E6v5/H66Y
	CU3iMtDAeCc326iSyoRSV6kJm2kG9YIKpEPFtqx+gLHO2U26Cuj7rKdmFIVayV9cO2MqadVAA3z
	E+CVPbSsVBCWfyRamtj15YjBuvbSHhz+06KqGOsRRKH7CIE37KEYAgWDaX4XwS5OYviQAM3KQfi
	suHT/l2qZ1gQqxhp4m0gOw+VoRm0j/7Ilma3g4vHfffFAe0Rd9GIKsPoqHRbeyizFSlGzvj6xN2
	6Zre9G8iBTN3w==
X-Received: by 2002:a05:6820:4b12:b0:679:97ac:2cc0 with SMTP id 006d021491bc7-679c4278e12mr3549590eaf.24.1771777792925;
        Sun, 22 Feb 2026 08:29:52 -0800 (PST)
Received: from [172.25.209.35] ([187.223.170.195])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679c5630a56sm4486431eaf.1.2026.02.22.08.29.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Feb 2026 08:29:52 -0800 (PST)
Message-ID: <b1c7cb9b-f790-4e3d-b1bd-4f4f516f9b3a@kernel.dk>
Date: Sun, 22 Feb 2026 09:29:50 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv7] blk-integrity: support arbitrary buffer alignment
To: Keith Busch <kbusch@kernel.org>, Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, csander@purestorage.com,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Christoph Hellwig <hch@lst.de>
References: <20251125185718.2190305-1-kbusch@meta.com>
 <aZYy3L-UVjgNQS11@kbusch-mbp>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aZYy3L-UVjgNQS11@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/18/26 2:45 PM, Keith Busch wrote:
> On Tue, Nov 25, 2025 at 10:57:18AM -0800, Keith Busch wrote:
>> From: Keith Busch <kbusch@kernel.org>
>>
>> A bio segment may have partial interval block data with the rest
>> continuing into the next segments because direct-io data payloads only
>> need to align in memory to the device's DMA limits.
>>
>> At the same time, the protection information may also be split in
>> multiple segments. The most likely way that may happen is if two
>> requests merge, or if we're directly using the io_uring user metadata.
>> The generate/verify, however, only ever accessed the first bip_vec.
>>
>> Further, it may be possible to unalign the protection fields from the
>> user space buffer, or if there are odd additional opaque bytes in front
>> or in back of the protection information metadata region.
>>
>> Change up the iteration to allow spanning multiple segments. This patch
>> is mostly a re-write of the protection information handling to allow any
>> arbitrary alignments, so it's probably easier to review the end result
>> rather than the diff.
>>
>> Martin reports many SCSI controllers are not able to handle interval
>> data composed of multiple segments when PI is used, so this patch
>> introduces a new integrity limit that a low level driver can set to
>> notify that it is capable of handling that, default to false. The nvme
>> driver is the first one to enable it in this patch. Everyone else will
>> force DMA alignment to the logical block size to ensure interval data is
>> always aligned within a single segment.
> 
> Hi Jens,
> It just came to my attention that this one is still outstanding. Any
> thoughts about pulling this in? I may have to rebase it, but just want
> to check before doing that.

Looks like that got missed. If you rebase it, let's take a look and see
if we can do it for this kernel release. It is on the bigger side though
for this deep into the merge window... But since it's still early days
for the release as a whole, we may be able to sneak it in.

-- 
Jens Axboe
