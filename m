Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886D32913
	for <linux-block@vger.kernel.org>; Thu,  7 Nov 2024 02:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730945814; cv=none; b=QuNpbpTwEc0TxW/5aX+gXzSipBqpKchBgR3nK7qHvphQJgyE1SeuVETOGuYBy1iAfP0eAbjs8D8FBY8Thmk3wsPcFhF8THU0wyGC85deSfVf0YJaqaD8MwiWhxGVe/tJSzapetyVsslZ0JLgkT+kHBLCpfkG6SLubnfwcThcq4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730945814; c=relaxed/simple;
	bh=OJ14XdTv1tu3Kkitd6JIAbJSYe4fefgtpEhkTm46bZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ra6/FYVDX0pWuZUeqsDwu+zidI8oRZSiMgiHk8vy5rWW8ukIJlmEPMwrKX65EJnEgkc9kYu+IWWAEMDP+xJmeFL14JJofUuMqPi/teviiQBOZXHzMs24SnOZAuNMsaUhoPy36HDYlxPkhCFh+o46lZQKKnZmrOI7nqZwSjSLSfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=2aTOnY0Q; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="2aTOnY0Q"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20ca1b6a80aso5484705ad.2
        for <linux-block@vger.kernel.org>; Wed, 06 Nov 2024 18:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1730945812; x=1731550612; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kFV1BDQBhll90BH2DcL4n38cLizHsHuts0MSkfqFk2Y=;
        b=2aTOnY0QNxLh9dhFWOLG6RGwfg9tFJfHyHYzZ6Mp5h5VriBF4B/IMNzOBEMNGIfLeS
         CSv5VIY7tlf/a2TnnqS6FmJZX+j6Q1/Rx6Rh15iiQxZcdhwhFG8Pt7m/t34t0INDxmH6
         uTEJHbrqlcOKkeMqOpnapKHbeUXF0elaD7ZlzDHvBqCPusniTJqzuNi0BVFIzPe2QwnY
         ifRG0zIrhB/MgXvmVVSlF65LqH9RDkh6/sK06nBmECCmyAXRE7IITTXtzLwwwpUBYwA1
         SjQa94/aRhqa8XTfWQlFlDemPLSPKIQ1+WNHBivW760m62G2ZRTDjpbLjURnOtnpU2DV
         TJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730945812; x=1731550612;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kFV1BDQBhll90BH2DcL4n38cLizHsHuts0MSkfqFk2Y=;
        b=M7n+jSXoJTv9d7YrskfeXEVxZ+0+1bPj5l1rgCwVS+yObaojvnPz7Mr0/ChES8kLC6
         V518a+ER45UjsVoFv1vAgW4l8NABJk7Le2Pepx1ySoXGZksraT0DAb5Ypj0AJoZ1wDeC
         CSPHCIHJGzCjdx9p74VXABp7l5eg9IUrEdrXW78/IQrcF7n58q2+rzDT4StTtrVxVIPa
         t3z60rvTbZsRsvaJxkvYLRB2vAHeWS8Lndcr+dL0WxhSKtqUVIqzGkNOSISunqH7oDZs
         rxKdYulVvn+IeKAg+j585hyabdYR5AXnVJmyeJJuCVerpJJJgDggq/8EdQ4WPfI6nbkj
         jSAg==
X-Forwarded-Encrypted: i=1; AJvYcCUHGA8Kop5Btnu8YNxmsZRcZnFmV+EHpN175dvBjkJj4k9/s8lSX2w90NHVZy5dTeGrA83EqM9vTko4gA==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywc1hND7GU3OL9pT191QcB6LXmzkUSLR/NT1Hl34gOpJ+l0ikQ+
	ajKlpr3o8qXbIHEN/0x1v+nj1dXFKMcQVmm0zID/azblfsD87CpzqKSXje+iXCs=
X-Google-Smtp-Source: AGHT+IEpCkLPyN3SfMnMFVrXgMGvflWs9M30B6PYyzwSWaXMSerBsjSAY97lYBYM1aE0B1Rs6t06Ug==
X-Received: by 2002:a17:902:e805:b0:202:cbf:2d6f with SMTP id d9443c01a7336-2111b0181b5mr297683785ad.57.1730945811875;
        Wed, 06 Nov 2024 18:16:51 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177ddf7c7sm1553275ad.101.2024.11.06.18.16.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Nov 2024 18:16:51 -0800 (PST)
Message-ID: <1884fb1f-b24d-4807-83ed-0017351c8516@kernel.dk>
Date: Wed, 6 Nov 2024 19:16:50 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V9 4/7] io_uring: reuse io_mapped_buf for kernel buffer
To: Ming Lei <ming.lei@redhat.com>
Cc: io-uring@vger.kernel.org, Pavel Begunkov <asml.silence@gmail.com>,
 linux-block@vger.kernel.org, Uday Shankar <ushankar@purestorage.com>,
 Akilesh Kailash <akailash@google.com>
References: <20241106122659.730712-1-ming.lei@redhat.com>
 <20241106122659.730712-5-ming.lei@redhat.com>
 <e27c7b11-4fa0-4c51-a596-67c0773a657a@kernel.dk> <ZywWbb_RmuA9hp3Z@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZywWbb_RmuA9hp3Z@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/6/24 6:22 PM, Ming Lei wrote:
> On Wed, Nov 06, 2024 at 08:15:13AM -0700, Jens Axboe wrote:
>> On 11/6/24 5:26 AM, Ming Lei wrote:
>>> Prepare for supporting kernel buffer in case of io group, in which group
>>> leader leases kernel buffer to io_uring, and consumed by io_uring OPs.
>>>
>>> So reuse io_mapped_buf for group kernel buffer, and unfortunately
>>> io_import_fixed() can't be reused since userspace fixed buffer is
>>> virt-contiguous, but it isn't true for kernel buffer.
>>>
>>> Also kernel buffer lifetime is bound with group leader request, it isn't
>>> necessary to use rsrc_node for tracking its lifetime, especially it needs
>>> extra allocation of rsrc_node for each IO.
>>
>> While it isn't strictly necessary, I do think it'd clean up the io_kiocb
>> parts and hopefully unify the assign and put path more. So I'd strongly
>> suggest you do use an io_rsrc_node, even if it does just map the
>> io_mapped_buf for this.
> 
> Can you share your idea about how to unify buffer? I am also interested
> in this area, so I may take it into account in this patch.

I just mean use an io_rsrc_node rather than an io_mapped_buf. The node
holds the buf, and then it should not need extra checking. Particularly
with the callback, which I think needs to go in the io_rsrc_node.

Hence I don't think you need to change much. Yes your mapping side will
need to allocate an io_rsrc_node for this, but that's really not too
bad. The benefits would be that the node assignment to an io_kiocb and
putting of the node would follow normal registered buffers.

> Will you plan to use io_rsrc_node for all buffer type(include buffer
> select)?

Probably not - the provided ring buffers are very low overhead and
shared between userspace and the kernel, so it would not make much sense
to shove an io_rsrc_node in between. But for anything else, yeah I'd
love to see it just use the resource node.

-- 
Jens Axboe
