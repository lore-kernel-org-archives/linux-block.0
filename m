Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41CE30ACE5
	for <linux-block@vger.kernel.org>; Mon, 26 Jan 2026 10:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769424951; cv=pass; b=EQ8C4+utbjLNKu4x7ZEZ0r3Yn6ta0gN4qRmvXHwEhmHHn+4vqti0D5W42TpyG5YbigYsiOCdr5U5Bejs+BQpkPiNQChUvb5mzifn6W2EBIhQYSJ+IV/3lJbNNB1TfukHd8HGJi3shVHXsF9xxsyncE7kje9Jrs1j/o/KKyf98MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769424951; c=relaxed/simple;
	bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SzAc+bxxWwMftO8HlxGnzwXz8eHiRQPA8p9tPlNf2T1e95CbpEIjq0u5PYoYzeIbRSW/Hmz0PTBRoGXSsjM0+/Gpt3oblZU5qTD1cvyfdSX6sJ+/OkGqiPDJyz8yNte3HtA5U3kU3Szc6ITZe20e7h4l8kB6pc2Dof19jRoKK3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3iPKmcd; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3iPKmcd"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-658381b28e8so5821746a12.0
        for <linux-block@vger.kernel.org>; Mon, 26 Jan 2026 02:55:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769424948; cv=none;
        d=google.com; s=arc-20240605;
        b=ctMmOzgFbfht28YqTYRjv+69BtROVaO83S7hnnAExKJm0eKL6fA1kh2y7PA7oEd1fr
         B8jGLYIgItneyQ7wowGs13z8gNpBpcFhDd8PEZZuxEBo7AWyF1pEeJNXQe4QkffQIKSY
         WoU9rgbtpYvBJXmW+HHHy/JJEkw4t2DEb1KndS8p/QviDN/iw1dbHYZdt5ZuxKEiPv7v
         WaHQFImGoFAZWTK/H8yMQv0iVRLpBZl8ji2lViuLxNI6EK3sXmqmmcaG7/NF+VDJ3utn
         G56gCg/l5m2gP5whLjXPod2jZBVeBaX0JAafCXr1YnE7U6aU7gvmGKsugl5BAi2LCwIU
         PBbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        fh=VoxQxy4SkIAYDRu4gGOXB0TTTHLrFAFWJPxvb2XdmVQ=;
        b=TT048ITSSsjqmh7/5Jr2vHCWJ9aJy7ILS0PYBQli4M+41WJifSdVDVGbt81fVOKg/w
         TOoIaS4oaEDK20I7VM4pstVQfwIjOpcebNj8NdiUyTPB1T38VAF/FPEnL9rMm3gHHhUs
         OG5KXdRwyzJtVjWj1BOD0Tp6Oburw4FJl2CWwFbyIuQxU/67+hcOTckZjLqt+m4eyqMa
         yDOQ69+v3U1N9dKTB5GeeAgkuoAaXvvoWDWlWC+atInwU+wU2xFb+C4pj2YbbuECmjGj
         aXaALi/PZ/OfilFyhBt6RiXZsdkcm2l4JooHZThXR4HfXcXdkXhe8HjYY25mYaDncqUy
         puLQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769424948; x=1770029748; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=c3iPKmcdWcrKJaAj/tOAIo5py1TPzrNQ5pnCQBDB5cDKZBqdHFmbS2cqW9rU4pd1BZ
         xo3+8zTVQNLKxD+hOyRZmewYR3RYRC3SyibdkCCyBnF7cuRF5YucN15R6RtEEWQlFxAy
         NpVZAC2tc0lG0F1smKvYG4EBrF/KdDlLJliGkZQgEFBs1rPPMFhas58k6dZf1FKOUDZ5
         7Ync/FiSACF5NS+fns8XGi/3p5YOQPPZGHI8gPSRF0EU/oz/phSYciODICKoCqgDNwSk
         +D+AXYHRfBa//b7v0zpEPo8lK2n/F4uwg0lBf/jxL/b7TlGtN1oAEnNixJE2uEk1k2e+
         S5Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769424948; x=1770029748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm1y3HjSbfjetP2qj6SkQ/PvAerOiP935sq/jHQIUpg=;
        b=Cbs3tmLEPKJqloN0nOTlxFoEN11ZKWcDI5USfJ1RZCUOgsftXmHnD9WhHDL155/HaJ
         4B3VQ0w/4Z/L84Ue7iD/0AxQFQjongGYtz7dLzZT/o1gC6Gry1vQG2knTZBZQx5oUpqx
         6T19H/PjNV26jUkJal2J7E0loJkg7lyhpzQUYTJ3LVUPXTeEA/2q9t9aV1yzMFmgAA2w
         zA3W8ZCvzs0pnQH9M5apZEwe79GVs/u46ou71ifENEkSZeNreatnu2dF9ixNScxgPYlY
         eBJB8CM/5bmUzbPyZSdLJhfMhKx05FUeoqPhiqg/ff2c5kNz3vfTIh+73v9hiBUB2ssW
         FDlA==
X-Forwarded-Encrypted: i=1; AJvYcCUyuOTYBroTvyAUK0UDw0Svf+J1j+QOfoB3GC5I4mx05QGrCdmbk5Vgw15CXnsxZwrw5EwGZxc946kl4w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsGZG5ei1+GpTkPb9VdyQXVeOwvjOOTnFfrQbn+M55kufqLV/f
	nBc4mTdCaBgLB8I/hX8+4503+nuVSp8BR4ryormUaTlwsyOvg8F+Lc0n/JFo4viVlWJk++3x464
	uZKWCFuDrxY3B8X2f4fpq5IWyoi29zg==
X-Gm-Gg: AZuq6aJTf8qUc+GYu++IA6t3+8C1PeyzAaR53KIJ/yO/sPn5jt2pWTQIoV1ryDr4SN/
	yzRMGpBOlyNxcgn9Pvufczl3dxJhGfaSPEvJnLldMdxU4/XdmG+6xEUnEm7tAZnAZ+bicUu/kO4
	eU6nkxsTLoZ+LPFp2Bn9AkD1uJQFNy05qhxfLsQ8cWOK4knzVlC8RX5+aA8mRca+NIDtvl9/1pu
	20rplAMoOmBMvkWHbV6/34v9HDPREzKOAI4QOu1915mayyG0EAj4lBUW5I8dDFTpR4YS6V+x9Jo
	dlMxFQMrZ91OsvMx1HqS55Z0CMw/tbckwlLRD4CoQxr2/cnhxXQFICYw7g==
X-Received: by 2002:a05:6402:380c:b0:655:a20a:a258 with SMTP id
 4fb4d7f45d1cf-6587069c213mr2486327a12.10.1769424947707; Mon, 26 Jan 2026
 02:55:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126055406.1421026-1-hch@lst.de> <20260126055406.1421026-2-hch@lst.de>
In-Reply-To: <20260126055406.1421026-2-hch@lst.de>
From: Anuj gupta <anuj1072538@gmail.com>
Date: Mon, 26 Jan 2026 16:25:09 +0530
X-Gm-Features: AZwV_QjUgod4A74r99ZxhhMNDurfLjL6lQ1hQ8sz2YOsyYFIfGBA-FWn3r3zY7U
Message-ID: <CACzX3AuJb887ish66TQLWyDezFBW0-XiuOaq6E624s9hxEBhUg@mail.gmail.com>
Subject: Re: [PATCH 01/15] block: add a BIO_MAX_SIZE constant and use it
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>, Qu Wenruo <wqu@suse.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-block@vger.kernel.org, 
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
