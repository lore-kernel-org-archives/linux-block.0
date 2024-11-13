Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D15E7346F
	for <linux-block@vger.kernel.org>; Wed, 13 Nov 2024 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509799; cv=none; b=oRFY53YgzVGAu/WSj6mhJeAtazXuqXqxkFgtbeDWCrdgGISCLENyapLqBS0W79GXqZvdNPsv8AoG2LoiBOngei0dVJAaj++bMDJFh6yzpEgUKWdjxr0HsLJ+8u9SgA40qpInliI3E388qlvZu+3DUyLPUqjgMIKqFtWeOWJ1p34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509799; c=relaxed/simple;
	bh=eIkjLLNMrOTgKdrUV/DLwVLfsAZwQHuzR9r2zUyFARQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TbUqK8M5fXsE5jvaaguJUMwLv0+I3CuYJlqlCEAuFX//Pei6K043wYjraXrVgeYp+zNBb3FyRGiz6/k+GgPdX/bM8hfGbGgDpI8WjXE4Xag98cG4w0vBJe+vpBk8lbDUaimQOiL/9GeO6lUNbIEIgMVVKcSsWJeIOzc9Qx/gcrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=20boCeLa; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="20boCeLa"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3e604425aa0so4008816b6e.0
        for <linux-block@vger.kernel.org>; Wed, 13 Nov 2024 06:56:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1731509796; x=1732114596; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ETI46CrVRN/AdNYcI+1seCc7SU3b9+tN5rtOG2Eyac=;
        b=20boCeLaRsYg22g/wA7W5YrCz0oVR7SSjVCEFV/XwD7DVetH4/wYNMGAw0KPtT62cG
         QJFnyLkF9PPVEcUAF0fItcmkBi2QBxru2lr1pwAcAquSXgpc9TNfzN2w7Ew6G9mNpKTH
         myAo0SkLbFJyd4m3IE2KQEnhIIw1AYBr8TgyfSp2y8H9l57MeMflyFBDb/YXwhDWEWQN
         BO6lllsqxPDlla1QhNixk2GkvOmKh8JuxV0YGv0jUtNFx/TchFpgHxx8aZqLlpsJEKAR
         eF7euZiEmdQ8Y/hQFTo7DZHgPq7babdRwnvF+a2Z2lYjWWkb3f3NYsF84DFnhrxMVbwG
         YybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731509796; x=1732114596;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ETI46CrVRN/AdNYcI+1seCc7SU3b9+tN5rtOG2Eyac=;
        b=uSTI3ykEkrL6I36B249vmdRknWYNYp7qdcPdgGNEJ4fG+9o+CJGP2H6/jGiRem5Hko
         d6w9dqQc/b3gSwIqLwYa0aViwcNu6qPP8gsn3ZUCN3XMoA1qu54/rkIxHXMWLIQtIfMO
         QKryksOLmh+8OybejncmedajZ/O6DVwS3N+mxd+mjJan0m6I1B0gNNT991Sd0jZXfiAo
         84q7YOqty1KMAuae2bC6imQQa1YrY9sbge6P2sjVF9JoqHxyKSI6RWufoMIsJ5O4EOMF
         JHUy3mZ9w2HrjvjvCbAVOsYCwM7GxHskzpsODpbXIXoXCQtGeTZxkxrvG3ZS2RGnzgj3
         KjGg==
X-Forwarded-Encrypted: i=1; AJvYcCX29PADNjlLV7Zi6yeECvAtuk9XAfquC2AivlCO9EbOMyg/4geqiS+dSHoRCJqSVMgEeEPYy5J83zO4bw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyFM/M1/ac/9xgCcZhjsxB4WhVs825Qh4tgxGkPOgh1z5jWyrSF
	NbA4Xx5Cf7Juah+SgbzrjbeSblK2mS3qyBcFDvAF5OV8ZOqF0ZU7NupOZ/uCw7c=
X-Google-Smtp-Source: AGHT+IEBwVEnStoPVwsIe3d/tdvdN70G40ogseE8WLLw9ogcccCwmno2kVPsub8f5peOg+3DL5bnLw==
X-Received: by 2002:a05:6808:19a9:b0:3e6:19a9:4718 with SMTP id 5614622812f47-3e794775b91mr16469854b6e.40.1731509796190;
        Wed, 13 Nov 2024 06:56:36 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3e7b09797a7sm587243b6e.23.2024.11.13.06.56.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 06:56:35 -0800 (PST)
Message-ID: <59666f0e-53d5-482c-b7e5-3d2d5779da49@kernel.dk>
Date: Wed, 13 Nov 2024 07:56:34 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH V10 0/12] io_uring: support group buffer & ublk
 zc
To: Pavel Begunkov <asml.silence@gmail.com>, Ming Lei <ming.lei@redhat.com>
Cc: io-uring@vger.kernel.org, linux-block@vger.kernel.org,
 Uday Shankar <ushankar@purestorage.com>,
 Akilesh Kailash <akailash@google.com>
References: <20241107110149.890530-1-ming.lei@redhat.com>
 <173101830487.993487.13218873496602462534.b4-ty@kernel.dk>
 <b0004544-91f7-47b8-a8d6-da7c6e925883@kernel.dk> <ZzKm_lN_1U_u6St7@fedora>
 <f3a83b6a-c4b9-4933-998d-ebd1d09e3405@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <f3a83b6a-c4b9-4933-998d-ebd1d09e3405@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/24 6:43 AM, Pavel Begunkov wrote:
> On 11/12/24 00:53, Ming Lei wrote:
>> On Thu, Nov 07, 2024 at 03:25:59PM -0700, Jens Axboe wrote:
>>> On 11/7/24 3:25 PM, Jens Axboe wrote:
> ...
>> Hi Jens,
>>
>> Any comment on the rest of the series?
> 
> Ming, it's dragging on because it's over complicated. I very much want
> it to get to some conclusion, get it merged and move on, and I strongly
> believe Jens shares the sentiment on getting the thing done.
> 
> Please, take the patches attached, adjust them to your needs and put
> ublk on top. Or tell if there is a strong reason why it doesn't work.
> The implementation is very simple and doesn't need almost anything
> from io_uring, it's low risk and we can merge in no time.

Indeed, nobody would love to get this moving forward more than me!
Pavel, can you setup a branch with the required patches? Should be your
two and then the buf update and mapping bits I did earlier. I can do it
too. Ming, would you mind if we try and setup a base that we can do this
on more trivially? I had merged the sqe grouping, but the more I think
about it, the less I like the added complexity, and the limitations we
had to put in there because relationships weren't fully understandable.

With the #1 goal of getting leased/borrowed buffers working asap, here's
what I suggest:

1) Pavel/I provide a base for doing the bare minimum, which is having an
   ephemeral buffer that zc can use.
2) You do the ublk bits on top

Yes this won't have grouping, so buf update will have to be done
separately. The downside here is that it'll add a (tiny) bit of overhead
as there's an extra sqe involved, but I don't really think that's an
issue, not even a minor one. The main objective here is NOT copying the
data, which will dwarf any other tiny extra overhead added.

This avoids introducing sqe grouping as a concept as a requirement for
zero copy ublk, which I did mention earlier is part of the complication
here. I'm a BIG fan of keeping things simple initially, particularly
when it adds major dependency complexity to the core code.

The goal here is doing the simple buffer leasing in such a way that it's
trivially understandable, and doesn't depend on grouping. With that, we
can easily get this done for the 6.14 kernel and finally ship it. I wish
6.13 was a week more away because then I think we could get it in for
6.13, but we only really have a few days at this point, so it's a bit
late. Unfortunately!

Ming, what do you think? Let's get this sorted so we can move on to
actually being able to use zc ublk, which is the goal we all share here.

> If you can't cache the allocation in ublk, io_uring can add a cache.
> If ublk needs more space and cannot embed the structure, we can add
> a "private" pointer into io_mapped_ubuf. If it needs to check the IO
> direction, we can add that as well (though I have doubts you really need
> it, read-only might makes sense, write-only not so much). We'll also
> merge Jens' patch allowing to remove a buffer with a request.

Right, we can always improve the little things as we go forward and make
it more efficient. I do think it's diminishing returns at that point,
but that doesn't mean we should not do it and make it better. But first,
let's get the concept working.

That's just violent agreement btw, I think we all share that objective
:-)

-- 
Jens Axboe
