Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048A21534FB
	for <linux-block@vger.kernel.org>; Sat,  1 Jun 2024 19:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717271642; cv=none; b=l6CrNx8/N5g5cSCimwr+hA6agYy+KJF8r0yv1fTH0zqZTZET+F4YugvLFNakgQHVMc+zgmxQhIbGey8CMDQavgi1t3t+yyA1S0ti7LVmvuQJM7hj0tf+DdZAlGdgvuwZ9UKjUC/ptZDK82UlxNFelLb0QqO0natMtGMDLEzsGQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717271642; c=relaxed/simple;
	bh=sjTvnLL15+axd8kEPHCrI1q2EZzeItpEAdxMZyj56QQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XSqvT35W+dTLlhw7LsPsOA61HnZC6NHhusj10lCBGQw8cizAff4PdNANicnA+WY44BdEMkmpOSPuPzA+dbc6mQDE9R55itFW6+uE8L99PKPoNkPlRDkuKEsdWYcYkroIEiqM/1UJ8fZ4joJ2hyh6UEhTgeZ8IWlVgfjXUbr8XXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=j6+JKXK9; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="j6+JKXK9"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57a23997da3so3104510a12.3
        for <linux-block@vger.kernel.org>; Sat, 01 Jun 2024 12:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1717271638; x=1717876438; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=jr2Al8+ndIMPJPdlShlncDNXoaIKKJSR1q01cY4wntc=;
        b=j6+JKXK9DoUXHI7BnH41+jvrY3T7Uyzt4W0eazDXOhSvG1K8S2duPPt/Hqm6AhZsgB
         C5IQLXFJWRYblqCxJQ7FXZ4oFVxqRUvL0Y33GYbPZcv9WftEP2hFcMYzw2b3WLcyorYc
         0gzd+u8pPG9J11WR6tkwwwXgXD+dbl2/gIOU3bEDJHMsXT0RJRS1EaBMjqBWvRQj6nM2
         bfyVgH55WgIRcRuDIaL8FRIrMBdCbEH6GZ0k/SU/S7rmqhLqgRDpPy7/3ib8HP6XaIrw
         o/j2AgllMma/RokiDWrjkbT8gvYHvAF10tOZyQh5sWBK1cfVyWF6uwVl6+uEhzlw0Q7A
         yWTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717271638; x=1717876438;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jr2Al8+ndIMPJPdlShlncDNXoaIKKJSR1q01cY4wntc=;
        b=fsWtDIDuNas6gyRZIEa9vGVktD3dx2JlorWHnMMaCuR5xifABh1P6LNWJowoS5d0Uy
         fQAbuzmtnx+gos4z5bNCqyiNWtMlzKFfbKt9A+Q5JaXplRYXwrfavfrm+gthiU4z8lvk
         dDyURKcS+4TZmG9JWvVC4K2cI5ol7R5BkNww5gJsSEtIVJrBlJsUpGp08Rh5/TyKi9MW
         msEHQ5e8YfE9hGvXkrBP2GKUbb5COIL4q1hi4aLCBqXF+nLcfDvXcbrQmnQ5txPBlb8J
         dzUSrJODViIpy2Ns5BGYc5Z0S2ByKZYwotKt0dfjWJlJ7uaWtcWXPJJ3Ex/dZanuSNrq
         mfPA==
X-Forwarded-Encrypted: i=1; AJvYcCWzMXuc915fiUvN+fsBzFZrC4TXhj+pvbFUck5mSt/N0/z7yd7qo88jiu4o9wWs/FcXPDhUbfgPkbKKKnV7y6tQ32msivFxdiWAlyo=
X-Gm-Message-State: AOJu0YzBE79HN7fk4/nRpRufdkhlAJh7WWZZWQ4teKywudLTAW3KWI4m
	KhQx69RQkUc5GmrU6l+Dv5rAXYPzufJm/g2QXdpdMC7VsRGC9UinBJs9/GpF5AQ=
X-Google-Smtp-Source: AGHT+IHg/Tdb9DK9+R9MFmqVcUxrNUbRCWNDM/3aHBB9G/2ub/z/P4O87DthrD+4wpkjKUhladJ/Gw==
X-Received: by 2002:a50:9992:0:b0:57a:2546:2512 with SMTP id 4fb4d7f45d1cf-57a36456201mr3737951a12.34.1717271637875;
        Sat, 01 Jun 2024 12:53:57 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57a31b9958fsm2594386a12.2.2024.06.01.12.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 12:53:57 -0700 (PDT)
From: Andreas Hindborg <nmi@metaspace.dk>
To: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,  Christoph Hellwig <hch@lst.de>,  Damien
 Le Moal <dlemoal@kernel.org>,  Bart Van Assche <bvanassche@acm.org>,
  Hannes Reinecke <hare@suse.de>,  Ming Lei <ming.lei@redhat.com>,
  "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,  Andreas
 Hindborg <a.hindborg@samsung.com>,  Greg KH <gregkh@linuxfoundation.org>,
  Matthew Wilcox <willy@infradead.org>,  Miguel Ojeda <ojeda@kernel.org>,
  Alex Gaynor <alex.gaynor@gmail.com>,  Wedson Almeida Filho
 <wedsonaf@gmail.com>,  Boqun Feng <boqun.feng@gmail.com>,  Gary Guo
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  Benno
 Lossin <benno.lossin@proton.me>,  Alice Ryhl <aliceryhl@google.com>,
  Chaitanya Kulkarni <chaitanyak@nvidia.com>,  Luis Chamberlain
 <mcgrof@kernel.org>,  Yexuan Yang <1182282462@bupt.edu.cn>,  Sergio
 =?utf-8?Q?Gonz=C3=A1lez?= Collado <sergio.collado@gmail.com>,  Joel
 Granados
 <j.granados@samsung.com>,  "Pankaj Raghav (Samsung)"
 <kernel@pankajraghav.com>,  Daniel Gomez <da.gomez@samsung.com>,  Niklas
 Cassel <Niklas.Cassel@wdc.com>,  Philipp Stanner <pstanner@redhat.com>,
  Conor Dooley <conor@kernel.org>,  Johannes Thumshirn
 <Johannes.Thumshirn@wdc.com>,  Matias =?utf-8?Q?Bj=C3=B8rling?=
 <m@bjorling.me>,  open list
 <linux-kernel@vger.kernel.org>,  "rust-for-linux@vger.kernel.org"
 <rust-for-linux@vger.kernel.org>,  "lsf-pc@lists.linux-foundation.org"
 <lsf-pc@lists.linux-foundation.org>,  "gost.dev@samsung.com"
 <gost.dev@samsung.com>
Subject: Re: [PATCH v4 2/3] rust: block: add rnull, Rust null_blk
 implementation
In-Reply-To: <871q5goaz0.fsf@metaspace.dk> (Andreas Hindborg's message of
	"Sat, 01 Jun 2024 18:59:31 +0200")
References: <20240601134005.621714-1-nmi@metaspace.dk>
	<20240601134005.621714-3-nmi@metaspace.dk>
	<ZlsvHV6y4DEdC8ja@kbusch-mbp.dhcp.thefacebook.com>
	<875xusoetn.fsf@metaspace.dk>
	<ZltF5NvDnKFphcOo@kbusch-mbp.dhcp.thefacebook.com>
	<871q5goaz0.fsf@metaspace.dk>
Date: Sat, 01 Jun 2024 21:53:38 +0200
Message-ID: <87wmn8mocd.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andreas Hindborg <nmi@metaspace.dk> writes:

> Keith Busch <kbusch@kernel.org> writes:
>
>> On Sat, Jun 01, 2024 at 05:36:20PM +0200, Andreas Hindborg wrote:
>>> Keith Busch <kbusch@kernel.org> writes:
>>> 
>>> > On Sat, Jun 01, 2024 at 03:40:04PM +0200, Andreas Hindborg wrote:
>>> >> +impl kernel::Module for NullBlkModule {
>>> >> +    fn init(_module: &'static ThisModule) -> Result<Self> {
>>> >> +        pr_info!("Rust null_blk loaded\n");
>>> >> +        let tagset = Arc::pin_init(TagSet::try_new(1, 256, 1), flags::GFP_KERNEL)?;
>>> >> +
>>> >> +        let disk = {
>>> >> +            let block_size: u16 = 4096;
>>> >> +            if block_size % 512 != 0 || !(512..=4096).contains(&block_size) {
>>> >> +                return Err(kernel::error::code::EINVAL);
>>> >> +            }
>>> >
>>> > You've set block_size to the literal 4096, then validate its value
>>> > immediately after? Am I missing some way this could ever be invalid?
>>> 
>>> Good catch. It is because I have a patch in the outbound queue that allows setting
>>> the block size via a module parameter. The module parameter patch is not
>>> upstream yet. Once I have that up, I will send the patch with the block
>>> size config.
>>> 
>>> Do you think it is OK to have this redundancy? It would only be for a
>>> few cycles.
>>
>> It's fine, just wondering why it's there. But it also allows values like
>> 1536 and 3584, which are not valid block sizes, so I think you want the
>> check to be:
>>
>> 	if !(512..=4096).contains(&block_size) || ((block_size & (block_size - 1)) != 0)
>
> Right, that makes sense. I modeled it after the C null_blk validation
> code in `null_validate_conf`. It contains this:
>
> 	dev->blocksize = round_down(dev->blocksize, 512);
> 	dev->blocksize = clamp_t(unsigned int, dev->blocksize, 512, 4096);
>
> That would have the same semantics, right? I guess I'll try to make a
> device with a 1536 block size and see what happens.

This happens:

root@debian:~# insmod /mnt/linux-build/drivers/block/null_blk/null_blk.ko bs=1536
BUG: kernel NULL pointer dereference, address: 0000000000000000
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 0 P4D 0
Oops: Oops: 0002 [#1] SMP
CPU: 2 PID: 291 Comm: insmod Not tainted 6.10.0-rc1+ #839

Probably a good idea with a better check.

BR Andreas
