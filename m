Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D5931C591
	for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 20:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763066596; cv=none; b=Ebqx/EL8IUAg5Hx08igZ9N8cp6M6f0lufgrbvFX5/kO8Fm7w2OBq0Wjk/P4iwP/lM38aBASG4lwHfmgHITbdja1bZgy5o1ZobbvfXGD/MqkuVuRPeUBypVez5IPzFqdd20bgaOQf1hrFL31l+2lkgIZ7wbcw/OMNmJnzThyyQ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763066596; c=relaxed/simple;
	bh=JUKFZXqfTfk6gDB+UG4zNs+IueWq+RsKrARPoCq6yP8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D/wOoHmVzOJHshoTcA6UUv94sZZyuwHvEpDDQrwG1Xhp99MoWtFzZ0RgzDjo07AVOIx5gqb40ZjHsBKh580pj0VtcQD3Y2Zhw9RegUjgCeVzbz1r2D+JMs9cqVhLMstF5khpQaz6WkHHbVj0SPR8j19CqwHWEvR4zrftAPDktxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=tum7nOPj; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="tum7nOPj"
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-948d45692b1so45057739f.0
        for <linux-block@vger.kernel.org>; Thu, 13 Nov 2025 12:43:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1763066593; x=1763671393; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+j/Z0xLhRSjKs5wFvJcX9wYaBPUjY/kyQbPaphO1IA8=;
        b=tum7nOPjbE8GaPQhjrT6bp89KlzFpheTw9aEqW2h+WV1YqaeZdoCL/gh89SYShKlt4
         xd6f/7IPLFdAHPIWtz6qU/AGEt/9lLFhnGX5rRILT3BQbg7QTZT5PAmfA3Z2gamHp1pp
         UbqnhXRWrjReJ7qWUJli+F6z2l+HTGhEpv7HHD9Wy56V4JyYiwvlbt9tdZyHVDngTFPw
         DpU1qmI9CsasBIDljmXnyXZhBB+PEG1C9o0AxLBOvMPj8cnRTanqGYTCR+mlulwFfu0C
         Ty/dMQFea82mCtlg2wz1MdR/r6MuE5JebaOPYNkpw8Br0sLRy8Wd2LnAcN8VFLQWdE6C
         qGKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763066593; x=1763671393;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+j/Z0xLhRSjKs5wFvJcX9wYaBPUjY/kyQbPaphO1IA8=;
        b=O/+Y3NMTl4rvJNPHohMvte6tJB4LccsrUCw/SmR7MyQv/hxVZDV2sjHEAeoqEZl2EF
         XY2LT3GwK2sYCyFZkJLkM3WkhEYG5aBVCnm+K7wi2/bKuWRFymnS7PIv61znNRO2JxDc
         cDqqkSdQo/7UGwJDRtvI5p8b0lLxpHkBIlSRLChebjk8mVvYsBlFDnZLImeJZ29o3xO4
         I6ualkpXiM5GOIzxtHcsbV4eY09Fe8C0RWzvq7ICzplKKrVb6SsKspNNSo4vZDdpkgoz
         ZMXyBHnCliFUPJLN3dyU0SO3ZYf3A3TBWqUhT2uno6vIZlu9SojDAdF0NHdbRIHjZ9W/
         XtKA==
X-Forwarded-Encrypted: i=1; AJvYcCWw9wzuCGhuD1iEhU2tlm0k2SnSkpnNP/RgZiK/fzlmy5ikf5so7thB4SNqbzbLbZi3p+LZJ6kTuIobpw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgau8+G0q+9rrqpscM9K9d/RlOVXgPCRjX44ML5pCT2eCn9WRX
	ojY9MYRvLA333Dun7g5P35LNEfnzz31lfWw3itukmFPhAmfbbmn204nYGKp8lTBRa/8=
X-Gm-Gg: ASbGnctAeJlFIj3Tmjb3JUsxteh9Nazcgqkv3bikRiqeKAljCahcVzujF2PbOr1BhzA
	E68dTTPOZS05Q9kQu2As2OvtZZuJiowMU2CM9DIMejw7edGVWB64R7zBnFjECqssWi1Cq+0eZrj
	vdAaaoGNnjTEJrAGg2hkhz4JC4+LpydWlKm78GZSZbOvRrz/SBHaovHnirJhvNUIcd/RsLfr0NX
	gVTiiUMwmGk1r1I5T6AfkgOPXyLhxxdf/YjatyOFDqVNqE76q87lmIWC/nZd5XDeh0o8v26PQhB
	W0XTEodMhVw0XMPbghwuYgrqKRTaTOEfZvijIhxjV703yiuG5n7s4pO5eVhX6mXKQdjOanRUOwj
	3BSfciG11aMrCj/g6lwhnXFQDD7yNTU9GrbyKd+4z0X0XoBsmKZvEKg6ZSaf63Cf1xOQYu52nH7
	ayavHVS2q5
X-Google-Smtp-Source: AGHT+IFx6zjNpUrugZAc4wnC8a6azzxXy0tMnFASNITozSamcYusTb1sKbKe/dJVKe+5LnVSO1fFlg==
X-Received: by 2002:a05:6602:2b90:b0:887:732f:6a96 with SMTP id ca18e2360f4ac-948e0de0d30mr122779239f.17.1763066593467;
        Thu, 13 Nov 2025 12:43:13 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-948d2b42dc4sm98817839f.2.2025.11.13.12.43.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 12:43:12 -0800 (PST)
Message-ID: <569825cd-c98f-4399-ad25-d4e62fba4255@kernel.dk>
Date: Thu, 13 Nov 2025 13:43:09 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/2] block: Enable proper MMIO memory handling for P2P
 DMA
To: Leon Romanovsky <leon@kernel.org>
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
References: <20251112-block-with-mmio-v4-0-54aeb609d28d@nvidia.com>
 <176305197986.133468.1935881415989157155.b4-ty@kernel.dk>
 <cec91b1e-a545-4799-97c3-676e3b566721@kernel.dk>
 <4f75497d-11cb-437c-ab90-d65d4d2e0a52@kernel.dk>
 <20251113195008.GA111768@unreal>
From: Jens Axboe <axboe@kernel.dk>
Content-Language: en-US
In-Reply-To: <20251113195008.GA111768@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/25 12:50 PM, Leon Romanovsky wrote:
> On Thu, Nov 13, 2025 at 10:45:53AM -0700, Jens Axboe wrote:
>> On 11/13/25 10:12 AM, Jens Axboe wrote:
>>> On 11/13/25 9:39 AM, Jens Axboe wrote:
>>>>
>>>> On Wed, 12 Nov 2025 21:48:03 +0200, Leon Romanovsky wrote:
>>>>> Changelog:
>>>>> v4:
>>>>>  * Changed double "if" to be "else if".
>>>>>  * Added missed PCI_P2PDMA_MAP_NONE case.
>>>>> v3: https://patch.msgid.link/20251027-block-with-mmio-v3-0-ac3370e1f7b7@nvidia.com
>>>>>  * Encoded p2p map type in IOD flags instead of DMA attributes.
>>>>>  * Removed REQ_P2PDMA flag from block layer.
>>>>>  * Simplified map_phys conversion patch.
>>>>> v2: https://lore.kernel.org/all/20251020-block-with-mmio-v2-0-147e9f93d8d4@nvidia.com/
>>>>>  * Added Chirstoph's Reviewed-by tag for first patch.
>>>>>  * Squashed patches
>>>>>  * Stored DMA MMIO attribute in NVMe IOD flags variable instead of block layer.
>>>>> v1: https://patch.msgid.link/20251017-block-with-mmio-v1-0-3f486904db5e@nvidia.com
>>>>>  * Reordered patches.
>>>>>  * Dropped patch which tried to unify unmap flow.
>>>>>  * Set MMIO flag separately for data and integrity payloads.
>>>>> v0: https://lore.kernel.org/all/cover.1760369219.git.leon@kernel.org/
>>>>>
>>>>> [...]
>>>>
>>>> Applied, thanks!
>>>>
>>>> [1/2] nvme-pci: migrate to dma_map_phys instead of map_page
>>>>       commit: f10000db2f7cf29d8c2ade69266bed7b51c772cb
>>>> [2/2] block-dma: properly take MMIO path
>>>>       commit: 8df2745e8b23fdbe34c5b0a24607f5aaf10ed7eb
>>>
>>> And now dropped again - this doesn't boot on neither my big test box
>>> with 33 nvme drives, nor even on my local test vm. Two different archs,
>>> and very different setups. Which begs the question, how on earth was
>>> this tested, if it doesn't boot on anything I have here?!
>>
>> I took a look, and what happens here is that iter.p2pdma.map is 0 as it
>> never got set to anything. That is the same as PCI_P2PDMA_MAP_UNKNOWN,
>> and hence we just end up in a BLK_STS_RESOURCE. First of all, returning
>> BLK_STS_RESOURCE for that seems... highly suspicious. That should surely
>> be a fatal error. And secondly, this just further backs up that there's
>> ZERO testing done on this patchset at all. WTF?
>>
>> FWIW, the below makes it boot just fine, as expected, as a default zero
>> filled iter then matches the UNKNOWN case.
>>
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index e5ca8301bb8b..4cce69226773 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -1087,6 +1087,7 @@ static blk_status_t nvme_map_data(struct request *req)
>>  	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
>>  		iod->flags |= IOD_DATA_MMIO;
>>  		break;
>> +	case PCI_P2PDMA_MAP_UNKNOWN:
>>  	case PCI_P2PDMA_MAP_NONE:
>>  		break;
>>  	default:
>> @@ -1122,6 +1123,7 @@ static blk_status_t nvme_pci_setup_meta_iter(struct request *req)
>>  	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
>>  		iod->flags |= IOD_META_MMIO;
>>  		break;
>> +	case PCI_P2PDMA_MAP_UNKNOWN:
>>  	case PCI_P2PDMA_MAP_NONE:
>>  		break;
>>  	default:
> 
> Sorry for troubles.
> 
> Can you please squash this fixup instead?
> diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
> index 98554929507a..807048644f2e 100644
> --- a/block/blk-mq-dma.c
> +++ b/block/blk-mq-dma.c
> @@ -172,6 +172,7 @@ static bool blk_dma_map_iter_start(struct request *req, struct device *dma_dev,
>  
>         memset(&iter->p2pdma, 0, sizeof(iter->p2pdma));
>         iter->status = BLK_STS_OK;
> +       iter->p2pdma.map = PCI_P2PDMA_MAP_NONE;
>  
>         /*
>          * Grab the first segment ASAP because we'll need it to check for P2P

Please send out a v5, and then also base it on the current tree. I had
to hand apply one hunk on v4 because it didn't apply directly. Because
another patch from 9 days ago modified it.

I do agree that this should go elsewhere, but I don't think there's much
of an issue doing it on the block side for now. That can then get killed
when PCI does it.

-- 
Jens Axboe
