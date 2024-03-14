Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739416BB56
	for <linux-block@vger.kernel.org>; Thu, 14 Mar 2024 08:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710406713; cv=none; b=Wot5jMs5Zvj+Nz1EkOPIpANRssPxVRHCpZ17g25MQy2pwMpjPn9ncNc4DM9Lo5LcsQYKE9/FKPOYqpTo4hnzCeQ8SX3LfaXT/W8gkQN4QLY69xeriyDRQiPdUPVRSS+dbReExSzWgiKmyu+QhDdbd9uQSBZHccQhhJi4HtvU4vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710406713; c=relaxed/simple;
	bh=jkjR2w3eWbGlskRSUh2BEg4E8O6gDXTWPhByDoL1bi0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=azOrfAbrSjz7WbSsNQgl/aoxisrkhn7lVglYl9eEyU0BRcBPrCXN7Qz8Y8Yrc+4a7MiH06RU7LBIOVYnMqbE8ztH00Ol5MVHCAov9zPjdZIU59UJD6Ce7t95VajpLY3mmRg0wKmhPFX1jX9dSh6n6FFTS7pKvvWSoQN7645JW7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=wxNpqt70; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="wxNpqt70"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a28a6cef709so89801966b.1
        for <linux-block@vger.kernel.org>; Thu, 14 Mar 2024 01:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1710406709; x=1711011509; darn=vger.kernel.org;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JfJRdvNmTUKtc18a61BTNZaQgzgnNE8vdtGOTX+Hn14=;
        b=wxNpqt70cIc14ItKxiTJTKI355oQBzEXo0VvZZIyYPKth8rkRCIzw0pGAJt17ph+Ku
         39ic6+0jg4YfdVPzSRQAq0zF+rlo9Jk8RsT0a++ZUCmDDCAPM030Ei4i16DhurXDk7SD
         6G9pHY7Gjcejnsi3prPlH69vMrWaiiFdv24qcSKpcuJMjGq3EqMr4XmIbT5jMO1uidZd
         gyHb10GLTNHIe0WQN76n7C3XjZPVaYjcQXoyl1Ml6qJV4CCtHgshrh++j+L5shDgZuFp
         2WfKOgRihHrDyxPeVnISocJIVXd/31aG3PNq6iYt4Ju+x2zTi5Co1cj0pQDv0WpVggxi
         PNUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710406709; x=1711011509;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfJRdvNmTUKtc18a61BTNZaQgzgnNE8vdtGOTX+Hn14=;
        b=pqRqH3K34bR2JbeLHVEGfO6lAe/q0GbktC73VAqgxTSsMGed/U7NTNAdzoe3RgLYgN
         xQeBYepWsPqit7btKuvdCb+AQZOMkhZxQwilLBxa1GC/frkEW80xC397rUCekgOuN6Wv
         mRFyU7haGzMb4JSUGhyYxy1cpwJRsInwAbQuZ5kVIlP1/TEfxJvKvwOkOyf5BiUCbYRT
         sIwMNqj4yaomaSZ1rE7S7KHoUkzmTRBNsZcG9MljGUpG19L5Eb6VJvF9h9hzl68l09vD
         m6wmRG/8uqDpFWecNQd9NFLx/ebS8cOZ2SlBEXCDbUvu4loKAi3+d67uvWYwtdd5ZW/8
         ZfbA==
X-Forwarded-Encrypted: i=1; AJvYcCU8jYDJe+KDlFMAvg9wWH5j7gdln+Q6iFelbMB2faZyIM75yA3CdBVIKDzoAM/KwkvrVylmF+XiWAj2Ica8/v3s9qok2OnbNt2W1PI=
X-Gm-Message-State: AOJu0YwM3jJmDxxuH/XTsJ4HmSUst2MESZLIrD+Y2LSTKzq5kA1tGt3F
	ullAp2UnSxqLyV+LNrugx4MbkUZZ98DAdJR8XN5n7BxLRaDfpLdY+vPgXXtFr6Y=
X-Google-Smtp-Source: AGHT+IGDNDCN5CCMaL99FT0i0uR6q6MMaRkgS+4KGrsnIavL/ICpH3WKWV3WV4mufqGGK2bFBpuXwA==
X-Received: by 2002:a17:906:7ccf:b0:a46:2649:16f9 with SMTP id h15-20020a1709067ccf00b00a46264916f9mr28844ejp.2.1710406709328;
        Thu, 14 Mar 2024 01:58:29 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id dn21-20020a17090794d500b00a465ee3d2cesm484705ejc.218.2024.03.14.01.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 01:58:28 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>,  Christoph Hellwig <hch@lst.de>,  Keith
 Busch <kbusch@kernel.org>, 	Damien Le Moal <Damien.LeMoal@wdc.com>,  Bart
 Van Assche <bvanassche@acm.org>, 	Hannes Reinecke <hare@suse.de>,
  "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,  Andreas
 Hindborg <a.hindborg@samsung.com>,  Wedson Almeida Filho
 <wedsonaf@gmail.com>,  Niklas Cassel <Niklas.Cassel@wdc.com>,  Greg KH
 <gregkh@linuxfoundation.org>,  Matthew Wilcox <willy@infradead.org>,
 	Miguel Ojeda <ojeda@kernel.org>,  Alex Gaynor <alex.gaynor@gmail.com>,
  Gary Guo <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,
  Benno Lossin <benno.lossin@proton.me>, 	Alice Ryhl
 <aliceryhl@google.com>,  Chaitanya Kulkarni <chaitanyak@nvidia.com>,  Luis
 Chamberlain <mcgrof@kernel.org>,  Yexuan Yang <1182282462@bupt.edu.cn>,
  Sergio =?utf-8?Q?Gonz=C3=A1lez?= Collado <sergio.collado@gmail.com>,  Joel
 Granados
 <j.granados@samsung.com>,  "Pankaj Raghav (Samsung)"
 <kernel@pankajraghav.com>,  Daniel Gomez <da.gomez@samsung.com>,  open
 list <linux-kernel@vger.kernel.org>,  "rust-for-linux@vger.kernel.org"
 <rust-for-linux@vger.kernel.org>,  "lsf-pc@lists.linux-foundation.org"
 <lsf-pc@lists.linux-foundation.org>,  "gost.dev@samsung.com"
 <gost.dev@samsung.com>
Subject: Re: [RFC PATCH 1/5] rust: block: introduce `kernel::block::mq` module
In-Reply-To: <ZfI8-14RUqGqoRd-@boqun-archlinux> (Boqun Feng's message of "Wed,
	13 Mar 2024 16:55:39 -0700")
References: <20240313110515.70088-1-nmi@metaspace.dk>
	<20240313110515.70088-2-nmi@metaspace.dk> <ZfI8-14RUqGqoRd-@boqun-archlinux>
User-Agent: mu4e 1.12.0; emacs 29.2
Date: Thu, 14 Mar 2024 09:58:23 +0100
Message-ID: <87il1ptck0.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Boqun Feng <boqun.feng@gmail.com> writes:

> On Wed, Mar 13, 2024 at 12:05:08PM +0100, Andreas Hindborg wrote:
>> From: Andreas Hindborg <a.hindborg@samsung.com>
>> 
>> Add initial abstractions for working with blk-mq.
>> 
>> This patch is a maintained, refactored subset of code originally published by
>> Wedson Almeida Filho <wedsonaf@gmail.com> [1].
>> 
>> [1] https://github.com/wedsonaf/linux/tree/f2cfd2fe0e2ca4e90994f96afe268bbd4382a891/rust/kernel/blk/mq.rs
>> 
>> Cc: Wedson Almeida Filho <wedsonaf@gmail.com>
>> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
>> ---
>>  block/blk-mq.c                     |   3 +-
>>  include/linux/blk-mq.h             |   1 +
>>  rust/bindings/bindings_helper.h    |   2 +
>>  rust/helpers.c                     |  45 ++++
>>  rust/kernel/block.rs               |   5 +
>>  rust/kernel/block/mq.rs            | 131 +++++++++++
>>  rust/kernel/block/mq/gen_disk.rs   | 174 +++++++++++++++
>>  rust/kernel/block/mq/operations.rs | 346 +++++++++++++++++++++++++++++
>>  rust/kernel/block/mq/raw_writer.rs |  60 +++++
>>  rust/kernel/block/mq/request.rs    | 182 +++++++++++++++
>>  rust/kernel/block/mq/tag_set.rs    | 117 ++++++++++
>>  rust/kernel/error.rs               |   5 +
>>  rust/kernel/lib.rs                 |   1 +
>>  13 files changed, 1071 insertions(+), 1 deletion(-)
>>  create mode 100644 rust/kernel/block.rs
>>  create mode 100644 rust/kernel/block/mq.rs
>>  create mode 100644 rust/kernel/block/mq/gen_disk.rs
>>  create mode 100644 rust/kernel/block/mq/operations.rs
>>  create mode 100644 rust/kernel/block/mq/raw_writer.rs
>>  create mode 100644 rust/kernel/block/mq/request.rs
>>  create mode 100644 rust/kernel/block/mq/tag_set.rs
>> 
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 2dc01551e27c..a531f664bee7 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -702,7 +702,7 @@ static void blk_mq_finish_request(struct request *rq)
>>  	}
>>  }
>>  
>> -static void __blk_mq_free_request(struct request *rq)
>> +void __blk_mq_free_request(struct request *rq)
>>  {
>>  	struct request_queue *q = rq->q;
>>  	struct blk_mq_ctx *ctx = rq->mq_ctx;
>> @@ -722,6 +722,7 @@ static void __blk_mq_free_request(struct request *rq)
>>  	blk_mq_sched_restart(hctx);
>>  	blk_queue_exit(q);
>>  }
>> +EXPORT_SYMBOL_GPL(__blk_mq_free_request);
>>  
>
> Note that for an EXPORT_SYMBOL_GPL() symbol, you can just add the
> corresponding header file in rust/bindings/bindings_helper.h:
>
> +#include <linux/blk-mq.h>
>
> and you will be able to call it from Rust via:
>
> 	bindings::__blk_mq_free_request()
>
> in other words, rust_helper_blk_mq_free_request_internal() is probably
> not necessary.

Yes, good point. Another option suggested by Miguel is that
`__blk_mq_free_request` need not be exported at all. We can make it
non-static and then call it from
`rust_helper_blk_mq_free_request_internal()`. Then only the latter will
be in the kernel image symbol table, which might be better in terms of
not exposing `__blk_mq_free_request()` directly.

BR Andreas
