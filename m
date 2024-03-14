Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB881841
	for <linux-block@vger.kernel.org>; Thu, 14 Mar 2024 03:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710385286; cv=none; b=R/wW0VK34038hG4t9hMGe47w8Lg09h9+3JYU2kmHOPk/i5ieGP0J21W+5ODsGhEeBocEmuqLUd7yvNhjrvjswhhrRqzQxWfcdPZS6lKxT+ktxU45MYA9PPkaTUSmEpTJ+eAjA3BK3YlkB4EFqTWdwaapUVpcadmKcD2M2uHEchA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710385286; c=relaxed/simple;
	bh=+Vq3AeKl3C1qUQJmHkneTonIUipuNRajCzalRvq1COA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sQAsKXceWQxzrEFYetnZPBmYCrg/YP2/+hPo9c/0K/uBlHXjBgFhD4s8U6ptcOjyfxk4+r6i63kWhXZWohlhU4wZg8qJeq4Xm1nRrSm7XH6jSXeDepjBoQTekbQdbNBqVYTPqbCwmjcDvha9Y/u92pqFqSZT4DCqHbjSFwKSuAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G7qvTKL5; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G7qvTKL5"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-29c731ba369so433660a91.3
        for <linux-block@vger.kernel.org>; Wed, 13 Mar 2024 20:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710385284; x=1710990084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VbQjdKi96QONzeXCPoEnkmrmvzgAcy1aMT3dE81BnPk=;
        b=G7qvTKL5qoU+XKN1vvUHfTO3YCOu60nUEXQvWSqSNQToUkeohCxuKzebKnzn/E9DfM
         W2fVpyfyAUB/eRaNldsPwG/gS1ne+cLCwj4XEBfysDEmtdpTB55OU8U0vBdOxhtTdKTm
         WN6bwcgvcbTd+Y3TxdywtP9rMes3dtuKCBS7I/YRFfUNqx4OgSWwn9MJsxRFbGaiLk+F
         BKZMus16WolFfh1Mj13r3qRYjb85z9ImaAxGXPC23TEpsGhM+r6WH2RD9c0n4aQaFwhA
         AYC7YQm2HvpfXPr/DUd3r1L6Fdaw7twlw4MJDe+9N0OG3mbF6sJx9coVsVuF/kbL+Fgj
         JfrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710385284; x=1710990084;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VbQjdKi96QONzeXCPoEnkmrmvzgAcy1aMT3dE81BnPk=;
        b=lVyl47CdiO5n3zB5lXqPhWgPuMRsecf6+l206kxob+B0ICmCZjuuRNhla+FFCmSpSy
         OAaSsRI3hr45Ca08c5i/tfb/lCSokpDL/ACVN69nj+2QelqnAjxmnUGERZOCTD1rzsiA
         eGaUSbZQj7T1YZHEAnJ+XSvEFvjvoIrHH9k1r+btydktLa92Qsv4lnylIw5/fBpjd4Bw
         R5JpASCnvy59/9UJw+82a3rvEQpRLtDXnW8Uk8mbWkdZeiOfVOwLvfHbpDJVSgEacwbk
         a0PacNQVAeE6fZixGmD7+Gv2AYyU4yHJ/3d8afCvlD/6lLSmwjXdvgcB9VapvL+xFn5o
         tmqw==
X-Forwarded-Encrypted: i=1; AJvYcCVcpZCkQFtpUzeUlw8xuAjpG2qXH1/4VqhFoWw7JXTfQiFiAaycuPJzJJIuhYTscuzSgYLGYwFTOr9DW/ODXqDIh3wd3XUpreC3Ms0=
X-Gm-Message-State: AOJu0YwJTNil5v8RDlDaXI0Ko164PVzqQ5St0u+dXzTQhUhtGr8NMKPU
	SXXYm5MZRAsn0mHcOwp9nSpsLrEwEFJBAQ1wg33iQH13VZAVYiqRUq4Ny0hoTblmeY7v+njbcwO
	MxELoejXR6zwWySREj1FHZZ/qP2E=
X-Google-Smtp-Source: AGHT+IGcuswIVqwR062xCy7y0MyYAP2f8liRy5fCzy5Lw8gjzUrL/aOgIwKcwIPJULwXTKcxy5Yfu0XnaqkYqYKlAW4=
X-Received: by 2002:a17:90a:7405:b0:29c:6fe9:10cd with SMTP id
 a5-20020a17090a740500b0029c6fe910cdmr503093pjg.5.1710385284288; Wed, 13 Mar
 2024 20:01:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313092346.1304889-1-zhengxu.zhang@unisoc.com> <ZfIfejdNTL8oassd@infradead.org>
In-Reply-To: <ZfIfejdNTL8oassd@infradead.org>
From: =?UTF-8?B?5byg5pS/5pet?= <char.zzx@gmail.com>
Date: Thu, 14 Mar 2024 11:01:13 +0800
Message-ID: <CA+-C3hcgEpY8b_cLPYkDa5t45ud6weaCjmVkD0WfCY2nNvc8eg@mail.gmail.com>
Subject: Re: [PATCH] block: Minimize the number of requests in Direct I/O when
 bio get pages.
To: Christoph Hellwig <hch@infradead.org>
Cc: Zhengxu Zhang <zhengxu.zhang@unisoc.com>, axboe@kernel.dk, bvanassche@acm.org, 
	linux-block@vger.kernel.org, hongyu.jin.cn@gmail.com, zhiguo.niu@unisoc.com, 
	niuzhiguo84@gmail.com, hongyu.jin@unisoc.com, yunlongxing23@gmail.com, 
	ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hi Christoph Hellwig:

>queue_max_bytes is a limit only available to the
>splitting routines and not to the upper layers submitting I/O.

keep  =E2=80=9Cbio->bi_iter.bi_size % request_max_size =3D 0=E2=80=9D if po=
ssible ,it
better for he final number of requests to be processed.

>Please try to debug your scenarious a little more - just because a bio
>get split off it should not just turn into a request of it's own,
>but be merged with the next bio due to the plug.  If that doesn't happen
>we do have a problem somewhere.

without patch,the request can not merge with the next bio.

for example:
first bio size is 2088 * 512 , split by 1024+1024+40,address
138577200,138578224,138579248
second bio size is 2064 * 512, split by 1024+1024+16,address
138579288,138580312,138581336
They are continuous. However, when decomposing requests in bio,
try to split the maximum request as much as possible,
resulting in the first request of the second bio being the maximum request =
size,
 so it cannot be merged with the last request of the first bio.
Therefore, two additional requests need to be consumed.

This is the trace without patch.
request 1.3 do not merged with request 2.1,beacause request 2.1 is
full.And also can not merged with request2.3.
        Thread-6-11566   [007] .....  1982.474122:
f2fs_direct_IO_enter: dev =3D (254,48), ino =3D 6366 pos =3D 0 len =3D
33554432 ki_flags =3D 20000 ki_ioprio =3D 4004 rw =3D 0
        Thread-6-11566   [007] .....  1982.474843: block_bio_queue:
254,48 R 123268400 + 2088 [Thread-6]
        Thread-6-11566   [007] .....  1982.474854: block_bio_remap:
8,0 R 123268400 + 2088 <- (254,48) 123268400
        Thread-6-11566   [007] .....  1982.474854: block_bio_remap:
8,0 R 138577200 + 2088 <- (259,55) 123268400
        Thread-6-11566   [007] .....  1982.474855: block_bio_queue:
8,0 R 138577200 + 2088 [Thread-6]                 <<<<first bio
        Thread-6-11566   [007] .....  1982.474863: block_split: 8,0 R
138577200 / 138578224 [Thread-6]
        Thread-6-11566   [007] .....  1982.474869: block_getrq: 8,0 R
138577200 + 1024 [Thread-6]
        Thread-6-11566   [007] .....  1982.474876: block_split: 8,0 R
138578224 / 138579248 [Thread-6]
        Thread-6-11566   [007] .....  1982.474878: block_getrq: 8,0 R
138578224 + 1024 [Thread-6]
        Thread-6-11566   [007] ...1.  1982.474881: block_rq_insert:
8,0 R 524288 () 138577200 + 1024 [Thread-6]       <<<<<request1.1
        Thread-6-11566   [007] .....  1982.474897: block_rq_issue: 8,0
R 524288 () 138577200 + 1024 [Thread-6]
        Thread-6-11566   [007] .....  1982.477396: block_getrq: 8,0 R
138579248 + 40 [Thread-6]
        Thread-6-11566   [007] ...1.  1982.477400: block_rq_insert:
8,0 R 524288 () 138578224 + 1024 [Thread-6]       <<<<<request1.2
        Thread-6-11566   [007] .....  1982.477409: block_rq_issue: 8,0
R 524288 () 138578224 + 1024 [Thread-6]
        Thread-6-11566   [007] .....  1982.477515: block_bio_queue:
254,48 R 123270488 + 2064 [Thread-6]
        Thread-6-11566   [007] .....  1982.477520: block_bio_remap:
8,0 R 123270488 + 2064 <- (254,48) 123270488
        Thread-6-11566   [007] .....  1982.477521: block_bio_remap:
8,0 R 138579288 + 2064 <- (259,55) 123270488
        Thread-6-11566   [007] .....  1982.477522: block_bio_queue:
8,0 R 138579288 + 2064 [Thread-6]                 <<<<second bio
        Thread-6-11566   [007] .....  1982.477528: block_split: 8,0 R
138579288 / 138580312 [Thread-6]
        Thread-6-11566   [007] .....  1982.477530: block_getrq: 8,0 R
138579288 + 1024 [Thread-6]
        Thread-6-11566   [007] .....  1982.477534: block_split: 8,0 R
138580312 / 138581336 [Thread-6]
        Thread-6-11566   [007] .....  1982.477536: block_getrq: 8,0 R
138580312 + 1024 [Thread-6]
        Thread-6-11566   [007] ...1.  1982.477538: block_rq_insert:
8,0 R 20480 () 138579248 + 40 [Thread-6]          <<<<<request1.3
        Thread-6-11566   [007] ...1.  1982.477538: block_rq_insert:
8,0 R 524288 () 138579288 + 1024 [Thread-6]       <<<<<request2.1
        Thread-6-11566   [007] .....  1982.477545: block_rq_issue: 8,0
R 20480 () 138579248 + 40 [Thread-6]
        Thread-6-11566   [007] .....  1982.477557: block_rq_issue: 8,0
R 524288 () 138579288 + 1024 [Thread-6]
        Thread-6-11566   [007] .....  1982.477596: block_getrq: 8,0 R
138581336 + 16 [Thread-6]
        Thread-6-11566   [007] ...1.  1982.477597: block_rq_insert:
8,0 R 524288 () 138580312 + 1024 [Thread-6]       <<<<<request2.2
        Thread-6-11566   [007] .....  1982.477604: block_rq_issue: 8,0
R 524288 () 138580312 + 1024 [Thread-6]
        Thread-6-11566   [007] .....  1982.477703: block_bio_queue:
254,48 R 123272552 + 2072 [Thread-6]
        Thread-6-11566   [007] .....  1982.477707: block_bio_remap:
8,0 R 123272552 + 2072 <- (254,48) 123272552
        Thread-6-11566   [007] .....  1982.477707: block_bio_remap:
8,0 R 138581352 + 2072 <- (259,55) 123272552
        Thread-6-11566   [007] .....  1982.477708: block_bio_queue:
8,0 R 138581352 + 2072 [Thread-6]
        Thread-6-11566   [007] .....  1982.477713: block_split: 8,0 R
138581352 / 138582376 [Thread-6]
        Thread-6-11566   [007] .....  1982.477715: block_getrq: 8,0 R
138581352 + 1024 [Thread-6]
        Thread-6-11566   [007] .....  1982.477719: block_split: 8,0 R
138582376 / 138583400 [Thread-6]
        Thread-6-11566   [007] .....  1982.477721: block_getrq: 8,0 R
138582376 + 1024 [Thread-6]
        Thread-6-11566   [007] ...1.  1982.477722: block_rq_insert:
8,0 R 8192 () 138581336 + 16 [Thread-6]           <<<<request2.3
        Thread-6-11566   [007] ...1.  1982.477723: block_rq_insert:
8,0 R 524288 () 138581352 + 1024 [Thread-6]
        Thread-6-11566   [007] .....  1982.477728: block_rq_issue: 8,0
R 8192 () 138581336 + 16 [Thread-6]
        Thread-6-11566   [007] .....  1982.477740: block_rq_issue: 8,0
R 524288 () 138581352 + 1024 [Thread-6]
        Thread-6-11566   [007] .....  1982.477778: block_getrq: 8,0 R
138583400 + 24 [Thread-6]
        Thread-6-11566   [007] ...1.  1982.477779: block_rq_insert:
8,0 R 524288 () 138582376 + 1024 [Thread-6]
        Thread-6-11566   [007] .....  1982.477784: block_rq_issue: 8,0
R 524288 () 138582376 + 1024 [Thread-6]
        Thread-6-11566   [007] .....  1982.477886: block_bio_queue:
254,48 R 123274624 + 2056 [Thread-6]
        Thread-6-11566   [007] .....  1982.477889: block_bio_remap:
8,0 R 123274624 + 2056 <- (254,48) 123274624

....
        Thread-6-11566   [007] ..s..  1982.478899: block_rq_complete:
8,0 R () 138579248 + 40 [0]                        <<<<request1.3
finish
.....
        Thread-6-11566   [007] ..s..  1982.478995: block_rq_complete:
8,0 R () 138577200 + 1024 [0]                       <<<<request 1.1
finish
...
        Thread-6-11566   [007] ..s..  1982.479603: block_rq_complete:
8,0 R () 138578224 + 1024 [0]                    <<<<<request1.2
finish
        Thread-6-11566   [007] ..s..  1982.479824: block_rq_complete:
8,0 R () 138581336 + 16 [0]       <<<<request 2.3 finish
....
....
        Thread-6-11566   [007] ..s..  1982.480173: block_rq_complete:
8,0 R () 138579288 + 1024 [0]     <<<<request 2.1 finish
....
        Thread-6-11566   [007] ..s..  1982.480739: block_rq_complete:
8,0 R () 138580312 + 1024 [0]     <<<<request 2.2 finish

Christoph Hellwig <hch@infradead.org> =E4=BA=8E2024=E5=B9=B43=E6=9C=8814=E6=
=97=A5=E5=91=A8=E5=9B=9B 05:49=E5=86=99=E9=81=93=EF=BC=9A
>
> > +             request_max_size =3D queue_max_bytes(bdev_get_queue(bio->=
bi_bdev));
>
> Besides all the coding style problems this is simply not how the bio
> interface works.  queue_max_bytes is a limit only available to the
> splitting routines and not to the upper layers submitting I/O.
>
> Please try to debug your scenarious a little more - just because a bio
> get split off it should not just turn into a request of it's own,
> but be merged with the next bio due to the plug.  If that doesn't happen
> we do have a problem somewhere.
>
