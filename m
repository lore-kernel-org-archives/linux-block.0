Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911681527A0
	for <linux-block@vger.kernel.org>; Sat,  1 Jun 2024 16:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717261181; cv=none; b=WxbtNPve8mZ38haPczoHVIpK/D4QZcuxXjCWBQfjs28Q00sGKETPS5kPgNfbUIqF157FNjDNXM+II4fslXy4T5ClMvt8lgRpkhwRGewUIk/x4y3JVu2LlxqY9HgM0aVgYhMqGOxKPzTdS8UGkxq6aAaew9UX9UkEbj87tgwLk/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717261181; c=relaxed/simple;
	bh=vY83/g5DnlUfQZA9zDchrVy8+HtF22bRD22oke+NysM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CBY0T7c1T8kz+8iqGLXP+D1yW0j2vLBDGlh97WvWoXskofbhuyaI081lTY/K0i/BoZFTG6YqzKRoDZHhjLbARpCF+/mZt4WjoIwjibIvLT9BRb5r6ucLvpU2Glj0Yv6KPIfXywo+Z/BNNTzeLqWAnCHCYmmRxJpM/gtLl+hTjVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk; spf=none smtp.mailfrom=metaspace.dk; dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b=wwKh0pMr; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=metaspace.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=metaspace-dk.20230601.gappssmtp.com header.i=@metaspace-dk.20230601.gappssmtp.com header.b="wwKh0pMr"
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2e6f51f9de4so43698791fa.3
        for <linux-block@vger.kernel.org>; Sat, 01 Jun 2024 09:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20230601.gappssmtp.com; s=20230601; t=1717261178; x=1717865978; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2mL6l8seCFLH+FLqk0uzi6xe60dPnwEuIbsZWb+Jgs8=;
        b=wwKh0pMrCWNf4pWpmwi3ABDnaTpDxSwyyrA80PhnQmjMYHVBfFwl1gU1tNehlN70yp
         AjJVtXUN+8hXokiyJ4QYKhcpZsbH2K27Em0LrPQfHHzp5ud8CI1uNPsSH5In2/0iMC5w
         zsicMxacBqOKMgUTEKxQCKKQxQn8p7iB838ge4xG4Y6IJqpHpNzmKUpWDWtfb/DLrP9u
         d0fZhIEP7ExWRHBgIbhq9cF5dV0QFebPozDtHJEWTJmEBB74d7sMPhaqoP/3Z9PlRsFB
         3l3Vc+c6tWQXlmYxHmUpRs/+fGnyzJ+XWXONFfpmAVWwSzZLkla5MghltLYFGqBEtbqS
         fZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717261178; x=1717865978;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2mL6l8seCFLH+FLqk0uzi6xe60dPnwEuIbsZWb+Jgs8=;
        b=Gw8vu+heT+XW6oKYY1brcN9JiORcmqsgZBvlDkC25lCtb32z3gQqvsNRKhAuA4w0Dy
         TRcXtZPlXulC/8aVIV7FUzJB1FHB+x0tYxv2m9VidR6npx9Xk0V1yxArzoR8Ix9IE5KJ
         3dHqoJKb2xMEAyoF4iglLpRI/ANvDB/MNJsy84SX/nPFlCv6bI9BqGu9IkFyZyfHqYn1
         g9BWMKGo1NyI1vnfr7IbPkM9bTv9sU7UIYdC2cc3KQ8SlEigtjFbIV9ZN0T5Xr5fa+mj
         jf8J0ALEdOzlJatpi8S6AL4hQ/TYUu/XLzZ4hrIA7cfPiSoNqwbldQAHPR83SPlfG8wF
         EfOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWg7w7sp0yGIK8FdwpN7AeoX6YQFdvIkYZZfsGQONObZDs4nccM6wi1Bt++hVCr/DsV1Q+QM1F0r188SvlQKA8cst+sY3XCfIsnP2c=
X-Gm-Message-State: AOJu0YxLoymDv/kOzsaJ8823I9zLg5fHve0/CnSOFIRP4VM4QgN0UXO0
	aMVtHnKFEeqE3OlW7awcDs3tP8QffkGNfM3wM5c7117HvkJUrfs6UMcdSqZHibE=
X-Google-Smtp-Source: AGHT+IFVGuaNXbhM1O7OzZMAjBCAkB+1ODN3q2YCCYkCSfm5BH2IuT/IISoTcabi+6Ng5qUysh1/bw==
X-Received: by 2002:a2e:3517:0:b0:2e2:a99a:4c4 with SMTP id 38308e7fff4ca-2ea951f5e53mr39476581fa.47.1717261177607;
        Sat, 01 Jun 2024 09:59:37 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a67ea67b4b2sm217708466b.117.2024.06.01.09.59.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jun 2024 09:59:37 -0700 (PDT)
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
In-Reply-To: <ZltF5NvDnKFphcOo@kbusch-mbp.dhcp.thefacebook.com> (Keith Busch's
	message of "Sat, 1 Jun 2024 10:01:40 -0600")
References: <20240601134005.621714-1-nmi@metaspace.dk>
	<20240601134005.621714-3-nmi@metaspace.dk>
	<ZlsvHV6y4DEdC8ja@kbusch-mbp.dhcp.thefacebook.com>
	<875xusoetn.fsf@metaspace.dk>
	<ZltF5NvDnKFphcOo@kbusch-mbp.dhcp.thefacebook.com>
Date: Sat, 01 Jun 2024 18:59:31 +0200
Message-ID: <871q5goaz0.fsf@metaspace.dk>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Keith Busch <kbusch@kernel.org> writes:

> On Sat, Jun 01, 2024 at 05:36:20PM +0200, Andreas Hindborg wrote:
>> Keith Busch <kbusch@kernel.org> writes:
>> 
>> > On Sat, Jun 01, 2024 at 03:40:04PM +0200, Andreas Hindborg wrote:
>> >> +impl kernel::Module for NullBlkModule {
>> >> +    fn init(_module: &'static ThisModule) -> Result<Self> {
>> >> +        pr_info!("Rust null_blk loaded\n");
>> >> +        let tagset = Arc::pin_init(TagSet::try_new(1, 256, 1), flags::GFP_KERNEL)?;
>> >> +
>> >> +        let disk = {
>> >> +            let block_size: u16 = 4096;
>> >> +            if block_size % 512 != 0 || !(512..=4096).contains(&block_size) {
>> >> +                return Err(kernel::error::code::EINVAL);
>> >> +            }
>> >
>> > You've set block_size to the literal 4096, then validate its value
>> > immediately after? Am I missing some way this could ever be invalid?
>> 
>> Good catch. It is because I have a patch in the outbound queue that allows setting
>> the block size via a module parameter. The module parameter patch is not
>> upstream yet. Once I have that up, I will send the patch with the block
>> size config.
>> 
>> Do you think it is OK to have this redundancy? It would only be for a
>> few cycles.
>
> It's fine, just wondering why it's there. But it also allows values like
> 1536 and 3584, which are not valid block sizes, so I think you want the
> check to be:
>
> 	if !(512..=4096).contains(&block_size) || ((block_size & (block_size - 1)) != 0)

Right, that makes sense. I modeled it after the C null_blk validation
code in `null_validate_conf`. It contains this:

	dev->blocksize = round_down(dev->blocksize, 512);
	dev->blocksize = clamp_t(unsigned int, dev->blocksize, 512, 4096);

That would have the same semantics, right? I guess I'll try to make a
device with a 1536 block size and see what happens.

BR Andreas
