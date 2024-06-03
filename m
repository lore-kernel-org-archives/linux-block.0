Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1846BFA7
	for <linux-block@vger.kernel.org>; Mon,  3 Jun 2024 09:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717405633; cv=none; b=I/lLllZBjWsxgnC3kF3jYH9m7VB0sIer5L0CTKrT7ORcECOWbr60kTokCZi7gpdrksn1h9Xi6G53P4FHbH2nMAcEenGS5BJQ5lBNBv2bjHImzbCh26zy7AiENwwuN1/o/Xy/azxOwu+iaqKE+aVPGWuArQPQvq0KC74FXFmybQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717405633; c=relaxed/simple;
	bh=NMLIrWVOxloW5pn8E6KBsdN1eZ/FcHMC1f1GD8Gydew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SxQ+83AZu7Ad+iTlUi6j37xCXKdHReiyAOK5kVY27rmGhiFjovLlw2fWETQFe6hjSf4a4TtzqonhJApaldd6ioeC63MIHHOC3u4/bdnQZPRdtEbnTmBmE53tXyOyvQJ7RqD+SPCv6mKhnSQbL807/QHIZ4CE8j2e0NVu4T3BXlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a75Wqm0Q; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a75Wqm0Q"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-35dce610207so1883077f8f.2
        for <linux-block@vger.kernel.org>; Mon, 03 Jun 2024 02:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717405630; x=1718010430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7PmqG8TIP0dxpOI4D2HNkzcCx9m77ESUaP5kCF4QUg=;
        b=a75Wqm0QFRYBKdGyeA14sBdgret59O1iFe31fIXFFey6GWks9cVUcPjkcM7b7+v06M
         wkVdqYkvgYXBn0R6WGhYZ1hj3rg/+OZwQBPJM0OLio/lbdF2/5Np1At3AX8b5XXfr170
         5I/fJ7mBdWF+Zux0jywgvwvDwAm7Sw9ETbJ/mGFhA3d4U0ew/7C6B5xUD8q/XT0lEGw8
         A7el3IOYPESvDJJMv2uFCGpTciZUso+1mVnarKR5G4C2gXH9J9vbbTTlyavAwErJ5S+j
         QJrATs7K/2A4oav11QFBhy3hauCIczbusnRkOuJG/LpuOg1I7VqI09Mc2N8CZv8jB+sl
         AMYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717405630; x=1718010430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7PmqG8TIP0dxpOI4D2HNkzcCx9m77ESUaP5kCF4QUg=;
        b=HjLbLbHosjjm5oNIeQHS60+7jlgc/7y3weXxLTcmxPS9rm1abRDegTLGKQ6V92aqf6
         3N9cS/igW5xYQHvG5KY/j5L3Ye6KRpLSwNpYbaYlOyElrfd0eKn0FToacMliiTbRCugq
         wuUEY168mOhF97w7IC0ADXrpX95SZ55QNTfCxaa/Fh/SaJ5Anjkqhc8vs4Ve8nRW+l/4
         o9nErbx6taucfndhV+qnA56TPt9HlQ1Y8d8iQcinaRVspi86x3unPP0J/p66NW7/tvdT
         Vnlm6Sh420z+sDxs3fUHFHdoBA6N4ak2mXDDGAjMy3XXu+AsJGxW9SpDmQ3UKdJGzeVD
         BeIA==
X-Forwarded-Encrypted: i=1; AJvYcCWzbiVV3aW9fppmJchq/gsaHsDvX6EftTQY5chdnkylyXER6fFpa4eZgpf6GxNNkPkoj8kaDYqmfNLnQzvmUMUKCbMdBLZOqX57fVs=
X-Gm-Message-State: AOJu0YyTh3ek2TwPXtGQravRrj9V37dAwACWbR0pfhrjB42cUK9HdPYE
	eiEKBUhLP+7wj2Bjnth4FgFuqqckzA63EwtvRTUhMXA5julR0UYtj9Er67K8g7ewpmFHqVuZ1la
	GSRF8MGvEEb2o+4hHxQC8EKU74Zz1W4himgtR
X-Google-Smtp-Source: AGHT+IG5F4HUfzTh3bjVkCxMisDd/GQAmf7i4n85odVioFozhVS9QQpptOWUoY0oJu3I8OqOtdb/xZVJyfdWkVBU/O0=
X-Received: by 2002:a05:6000:1a8d:b0:35e:eaf:697e with SMTP id
 ffacd0b85a97d-35e0f27f011mr9009296f8f.28.1717405629653; Mon, 03 Jun 2024
 02:07:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240601134005.621714-1-nmi@metaspace.dk> <20240601134005.621714-3-nmi@metaspace.dk>
 <ZlsvHV6y4DEdC8ja@kbusch-mbp.dhcp.thefacebook.com> <875xusoetn.fsf@metaspace.dk>
 <ZltF5NvDnKFphcOo@kbusch-mbp.dhcp.thefacebook.com> <0a47eebd-2aca-494d-814b-bc949b08630b@suse.de>
In-Reply-To: <0a47eebd-2aca-494d-814b-bc949b08630b@suse.de>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 3 Jun 2024 11:06:57 +0200
Message-ID: <CAH5fLgiSCTa=BCr2aGZBhsY2gvctE9OTFFA5CNiVR-YGbXhgxg@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] rust: block: add rnull, Rust null_blk implementation
To: Hannes Reinecke <hare@suse.de>
Cc: Keith Busch <kbusch@kernel.org>, Andreas Hindborg <nmi@metaspace.dk>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>, Bart Van Assche <bvanassche@acm.org>, 
	Ming Lei <ming.lei@redhat.com>, 
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Greg KH <gregkh@linuxfoundation.org>, Matthew Wilcox <willy@infradead.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Chaitanya Kulkarni <chaitanyak@nvidia.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Yexuan Yang <1182282462@bupt.edu.cn>, 
	=?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>, 
	Joel Granados <j.granados@samsung.com>, 
	"Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, Daniel Gomez <da.gomez@samsung.com>, 
	Niklas Cassel <Niklas.Cassel@wdc.com>, Philipp Stanner <pstanner@redhat.com>, 
	Conor Dooley <conor@kernel.org>, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>, 
	=?UTF-8?Q?Matias_Bj=C3=B8rling?= <m@bjorling.me>, 
	open list <linux-kernel@vger.kernel.org>, 
	"rust-for-linux@vger.kernel.org" <rust-for-linux@vger.kernel.org>, 
	"lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>, 
	"gost.dev@samsung.com" <gost.dev@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 11:05=E2=80=AFAM Hannes Reinecke <hare@suse.de> wrot=
e:
>
> On 6/1/24 18:01, Keith Busch wrote:
> > On Sat, Jun 01, 2024 at 05:36:20PM +0200, Andreas Hindborg wrote:
> >> Keith Busch <kbusch@kernel.org> writes:
> >>
> >>> On Sat, Jun 01, 2024 at 03:40:04PM +0200, Andreas Hindborg wrote:
> >>>> +impl kernel::Module for NullBlkModule {
> >>>> +    fn init(_module: &'static ThisModule) -> Result<Self> {
> >>>> +        pr_info!("Rust null_blk loaded\n");
> >>>> +        let tagset =3D Arc::pin_init(TagSet::try_new(1, 256, 1), fl=
ags::GFP_KERNEL)?;
> >>>> +
> >>>> +        let disk =3D {
> >>>> +            let block_size: u16 =3D 4096;
> >>>> +            if block_size % 512 !=3D 0 || !(512..=3D4096).contains(=
&block_size) {
> >>>> +                return Err(kernel::error::code::EINVAL);
> >>>> +            }
> >>>
> >>> You've set block_size to the literal 4096, then validate its value
> >>> immediately after? Am I missing some way this could ever be invalid?
> >>
> >> Good catch. It is because I have a patch in the outbound queue that al=
lows setting
> >> the block size via a module parameter. The module parameter patch is n=
ot
> >> upstream yet. Once I have that up, I will send the patch with the bloc=
k
> >> size config.
> >>
> >> Do you think it is OK to have this redundancy? It would only be for a
> >> few cycles.
> >
> > It's fine, just wondering why it's there. But it also allows values lik=
e
> > 1536 and 3584, which are not valid block sizes, so I think you want the
> > check to be:
> >
> >       if !(512..=3D4096).contains(&block_size) || ((block_size & (block=
_size - 1)) !=3D 0)
> >
> Can't we overload .contains() to check only power-of-2 values?

Rust integers have a method called is_power_of_two. If you need to
assert that it's a power of two, you can use that.

Alice
