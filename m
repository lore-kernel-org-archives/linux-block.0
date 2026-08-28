Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501F623A564
	for <linux-block@vger.kernel.org>; Fri, 28 Aug 2026 03:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787888041; cv=pass; b=t/OCyeBULwDT0OPyHLMMpqfxmIb0KD9A5TIBnf0+kUDAhPQgjzfA/5m57seyK36mRZ7jFCwjIb6Z8J6ybSgqCu4QDDeJWX7inkzRaCxTfa3ywRoEOwszleBo4qzOMUva96Of6vNmGra4Pet6/Je5OQNbW7Bioh1hF8PGSfNIrD8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787888041; c=relaxed/simple;
	bh=eVCUgnuZPY9rp4G0hxfWBoh/8wdCFKKRU8Eq9Q7yXbg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PBGf3o9+i0YMtxIBw9Axi073+IgZpGtKBYGgIChwL+TYETV9J59S3F4eVs5L3L4HfkYnM0MnMM2nRg1hEJuh++lBPbd7AwsuYuKqueAVqVciK0ihPjEKxmwRM9AzjMysO9j42Xul7q8izUOpVAk7lcaPO7Up9VUNB59//uJF5Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qoJ0brIm; arc=pass smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qoJ0brIm"
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7f3b01b8996so38026a34.3
        for <linux-block@vger.kernel.org>; Thu, 27 Aug 2026 20:33:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787888039; cv=none;
        d=google.com; s=arc-20260327;
        b=ipaf6LnB5ih0nD3LgRgh8Y12rbLJb3MnAPwqebhAqTkObUgwLNzL93+sN6w13uokMX
         wVb60b4bQANJ+WvyT7WCpGFQYpzYI7Fm5ZXpcN4JQZU5R/Zbui07+7hw0YBQTILYZxYx
         fU/HpFr6myxNCIjV0Yrh6+MGPk42nWn3bLGekNbot0BtRWhxDNo2frNNMAh0FtR75tpt
         BhPOvWUN1PnArwtWCUhAzB5VIhKYf7ItnOosnoo8X9r5rmL3WMYr7fy/tShfuSswmke0
         tmqNg7BPpCN/vOEkVYqe7HfTQETkzuTYkMy0fsSy9CkJrceiVDIrJmvxKWlrDJ5y8UCf
         kVRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tJ6GRA/2LwQW6/jDEIjrj/TZS2ZKHOJ3XYsZbyYACDw=;
        fh=SOjbjKFzxXZtXkjy/NqBwfs/FUHQT1+/Oh1OreiEL3k=;
        b=SPzoJWgh3LBmRP3kJ9EJluVHzBgU5Vikh9i2zmFdrOFxBRMqrbZi0/0B59Yx1lux/R
         ZInwiBh4F9TEWxqz0HGtARR7Mgjs3uqJKFoJiUre8ZvTYYA5Py8PRwAbEKsS9buKDto2
         cYY4OB9SDUCU0rh/QpKu6HSuMIzT3H0NobU5mzWDQAV9Cg1X2woQRi62j9GBkd1To6a4
         aMKCdSS//J3LmM7Jqz+xylKNCD7TDrfruF20+Kva80LqHMoOlWveXD35m8z99tIHPqr4
         yfczGJVYZExZ6nGHLWcQvpnUAvKaB9T8ouXbZR/39wjlYe/3midtS1COjeATQSk/UmSV
         vRrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787888039; x=1788492839; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tJ6GRA/2LwQW6/jDEIjrj/TZS2ZKHOJ3XYsZbyYACDw=;
        b=qoJ0brImXYW2jxuJ/+X9STf16jjXZ92rLmZ4786e6MVSpMWvhHnkJ14DzuZd++/cjq
         iXnv5vvRllyON65+nnXaCJ/b6+YH56o0zedDj/zHvJNlAGDchuDSruVJyLQBrV8WAXWs
         SravIim8345TcwwvXjYeU75tQ4kL7jLhRajFS1OSDokJJV/2VK2hrLyNHeytc09YbPBE
         jM2IhEqSV04jlyvKp+lPOuB2WYY9aatRDk+LOTBeBnMlDt3YlDDVrTb0oSdatP/JD6YQ
         IL0Ud2rj4HI2GkkPVHkPeM+vv4EnsEOhUTSW45cOfdJ43h4sIYmtFzLdciJnJMx53rpl
         0bRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787888039; x=1788492839;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tJ6GRA/2LwQW6/jDEIjrj/TZS2ZKHOJ3XYsZbyYACDw=;
        b=Hjk3kXcXZEgikMVDLuP+fa40Z19YWE8IooLMR8CzzYkx6Z0BGiipj2YwOYHt4QIjpG
         bibELfJtgV++K6yEQ+E1EtcET/6i0y2Y2GaCQ4GncKtHYMTEuySLkVmkAeNLqhUkWb5G
         nkQnke+8XWMP7u/Dl/ZSdwgCGjCaFoQCZ5wRcYoIHTPaxojs5XkmxpNBiMeS8TlIhrW3
         zAndBX+If4p0yQ6SvKHoeoXMtJVuqJrMBgdGILIiWbG42N3PFqeVwRT9R4oIT4ez6z9L
         g+QnM9u4AeGllosMx8RtjZvh05Lg6l2tgLCLM3rjGJZKNIdYKV4F9o47kMgzLOdCyfy8
         K0EA==
X-Forwarded-Encrypted: i=1; AHgh+RrNaPRODGEW95Vyh89nC7g/mLKOqQ9NIFphAS/LcPQCFbjt+xtDYcxIKY9HCepoZu9ELnmgysOhJmtoFg==@vger.kernel.org
X-Gm-Message-State: AFuF++ngwCd1d9rQRcaeM4Schd0cwB1mzyiIKLoHi1/ILLnxit5vDJN5
	Ha/88wn19X4CiVnoQu2KHUEsPxv0GJaCfy67fVhp835JxH6gfJdYD6uGzjoJu2GLV1ol65mFuUz
	4zgQlI1FwXX6oNUO80fRwDTcYrtw1GUA=
X-Gm-Gg: AR+sD100K6h4sHY+j5gMSS9Mmm253/oxICt5WGkrVwyvg1VE97qviyRut1uCN4+HlXX
	tpXXKYYp3IWeg2QgYOfWncNQiV/vNS8v71i9+u3LDgoHFlcP/xM1Xn2xzSi3w006v5Xeq61gHq3
	vUGkVF3iGU0fs20ydQoSMDXPJXbKvYw0caLiaHsaVJPrlxU3wG0GgNOV59xC9VjDIgeQNx9jbJc
	+MqAautDeCJs3s4DN4r2Hk9+dYG9+PyWPik2B592/YdlyGzSRng+CCXwpcSTb05ZOddbfnUiYQi
	O0K7e8mP8EDwfUXf49j0IKpTBUqA695yKxpVFhm33M7L2rIJ3k98i28W2j4ORd21iKIqAFCv9vQ
	G7azKmucQYTMb+mp6cZxzdxvfWpo7UFP+BQe2sf1OqUvy
X-Received: by 2002:a05:6820:340e:10b0:6b1:67e1:fc8e with SMTP id
 006d021491bc7-6b1c66e6ce5mr2559540eaf.25.1787888038951; Thu, 27 Aug 2026
 20:33:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827185722.3234622-1-csander@purestorage.com>
 <20260827185722.3234622-2-csander@purestorage.com> <CAJnrk1YfTg-Lz+TmM+c=Asc8N4QGuY9_g8zUXtaNr4O7hG1Djw@mail.gmail.com>
 <CADUfDZoEosgMMQ47BDWBskTOZrYZpg6VUT5c4kwczDLRLXYk=Q@mail.gmail.com>
In-Reply-To: <CADUfDZoEosgMMQ47BDWBskTOZrYZpg6VUT5c4kwczDLRLXYk=Q@mail.gmail.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 27 Aug 2026 22:33:46 -0500
X-Gm-Features: AcwNN1V96G10EnqkMmlBEbQoJ8ihVOlJhML3SIuW3TsrH3jrmu0CBU7aGovmtII
Message-ID: <CACVXFVOLBVVGwfo+mbn+4jnGKZS66dL_2ghsKiaT6buscWJg6w@mail.gmail.com>
Subject: Re: [PATCH 1/2] io_uring/cmd: split io_uring_cmd_set_res() from io_uring_cmd_done()
To: Caleb Sander Mateos <csander@purestorage.com>
Cc: Joanne Koong <joannelkoong@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
	Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Chris Mason <clm@fb.com>, David Sterba <dsterba@suse.com>, 
	Bernd Schubert <bernd@bsbernd.com>, Miklos Szeredi <miklos@szeredi.hu>, linux-block@vger.kernel.org, 
	linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org, 
	linux-btrfs@vger.kernel.org, fuse-devel@lists.linux.dev, 
	io-uring@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 4:44=E2=80=AFPM Caleb Sander Mateos
<csander@purestorage.com> wrote:
>
> On Thu, Aug 27, 2026 at 1:05=E2=80=AFPM Joanne Koong <joannelkoong@gmail.=
com> wrote:
> >
> > Hi Caleb,
> >
> > On Thu, Aug 27, 2026 at 11:57=E2=80=AFAM Caleb Sander Mateos
> > <csander@purestorage.com> wrote:
> > >
> > > In preparation for setting the io_uring NVMe passthru CQE results fro=
m
> > > the blk-mq request completion rather than the task work callback, spl=
it
> > > out functions io_uring_cmd_set_res{,32}() from io_uring_cmd_done{,32}=
().
> > > This allows io_uring_cmd_done{,32}() and __io_uring_cmd_done() to be
> > > consolidated into a single CQE-size-agnostic function with 3 fewer
> > > arguments than __io_uring_cmd_done().
> > >
> >
> > The conversion looks logically correct to me but the interface feels a
> > bit annoying / fragile on the caller side.
> >
> > Is there a way nvme can get what it needs without changing the other
> > callers? Would it work to just keep the existing
> > io_uring_cmd_done{,32}() as is and add a separate API for special
> > callers like nvme, eg:
> >
> >   void io_uring_cmd_set_res32(struct io_uring_cmd *cmd, s32 ret, u64 re=
s2);
> >   void __io_uring_cmd_done(struct io_uring_cmd *cmd, unsigned issue_fla=
gs);
> >
> > where io_uring_cmd_done{,32} would then just be inline wrappers over
> > those? afaict, then only the nvme callsite would have to change and
> > fuse, btrfs, block, ublk, and scsi_bsg could just stay as is. Do you
> > think something like that makes sense to do?

Yeah, this way is definitely much better from a driver viewpoint.



Thanks,
Ming Lei
