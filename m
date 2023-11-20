Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y5licVVA"
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5B109E
	for <linux-block@vger.kernel.org>; Mon, 20 Nov 2023 16:00:00 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-a0039ea30e0so143778866b.2
        for <linux-block@vger.kernel.org>; Mon, 20 Nov 2023 16:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1700524799; x=1701129599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hvy2CV8CQ1z8xyF0eqyyieG0M3+ja1/tOprJQEZU3U0=;
        b=Y5licVVAyPYKD/k20MMZkSMbBgiQ++7QRIuNqG+xiuB0SnUHTKl3SoFGXT9oOR1BFC
         6te8qwB6pW5OllpzSlBA9GOtTqW+jpPSILGsKwRrY8KLEvYpVbUVFoqRZkoGqV7rnhFC
         aZyf/bNkojtKE+Jy9BzgucSosPFunWOnts5Jg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700524799; x=1701129599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hvy2CV8CQ1z8xyF0eqyyieG0M3+ja1/tOprJQEZU3U0=;
        b=wUF5L0XqnguSTH0hB9bJCi1icdJnxn2H210Fjr+h5UXR3hkDPynjNaf9KsKS8/RlEg
         iYTcK/Om8lzCjoAxah3LnrwIoREvEMRjHNg3vFu/NzklQ9lbApgs4d5zr5b50kkAimmZ
         hmSLQ9TQ7jQWKoZuAhCjziDDrrg4hTBGm7SbJi0jwPGMgyCrI+H5zAEDwD3qpjFGeOQm
         IVIYIQaoFaUrGL3oGLzEGTaDUCnGkKyi1VZpUSJJjKsc1Xk5J3wKZvwSio0pcDII20Xe
         3akKgPJtv9GWFLHCW2frSP7eo9WGORdMPpAafZozbA5H8eMt5fqlFW28kVANjVF3CERc
         pKrg==
X-Gm-Message-State: AOJu0YzDH7QGot7bsvWZOrIhwwu35GirdFMshDjcowTk7fUTSzSP5ftO
	8Aa4VTOD+4zqj8AkHUxfDbW9nBBrfiVL8lUlSzLAKw7Z/MuelZO3
X-Google-Smtp-Source: AGHT+IGS/DMjLcVARh7/W+3Xwjr7CBqtoFkp2YHIj8I+RchJwxdGIbnk77jU2LOk1Rw8ir/jKvddnwjVTa6iwN+tqTI=
X-Received: by 2002:a17:906:5904:b0:9be:e90:5016 with SMTP id
 h4-20020a170906590400b009be0e905016mr6390836ejq.24.1700524799291; Mon, 20 Nov
 2023 15:59:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110010139.3901150-1-sarthakkukreti@chromium.org>
 <ZU7RVKJIzm8ExGGH@dread.disaster.area> <CAG9=OMPFEV9He+ggq2mcLULnUZ2jm8fGU=4ca8kBoWtvqYcGVg@mail.gmail.com>
 <ZVvCsPelezZesshx@dread.disaster.area>
In-Reply-To: <ZVvCsPelezZesshx@dread.disaster.area>
From: Sarthak Kukreti <sarthakkukreti@chromium.org>
Date: Mon, 20 Nov 2023 15:59:48 -0800
Message-ID: <CAG9=OMMar0shTijQfehFSktir2vsvRkvH8t69gREzVyLKyPH4A@mail.gmail.com>
Subject: Re: [PATCH v9 0/3] [PATCH v9 0/3] Introduce provisioning primitives
To: Dave Chinner <david@fromorbit.com>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>, Brian Foster <bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2023 at 12:33=E2=80=AFPM Dave Chinner <david@fromorbit.com>=
 wrote:
>
> On Mon, Nov 13, 2023 at 01:26:51PM -0800, Sarthak Kukreti wrote:
> > On Fri, Nov 10, 2023 at 4:56=E2=80=AFPM Dave Chinner <david@fromorbit.c=
om> wrote:
> > >
> > > On Thu, Nov 09, 2023 at 05:01:35PM -0800, Sarthak Kukreti wrote:
> > > > Hi,
> > > >
> > > > This patch series is version 9 of the patch series to introduce
> > > > block-level provisioning mechanism (original [1]), which is useful =
for
> > > > provisioning space across thinly provisioned storage architectures =
(loop
> > > > devices backed by sparse files, dm-thin devices, virtio-blk). This
> > > > series has minimal changes over v8[2], with a couple of patches dro=
pped
> > > > (suggested by Dave).
> > > >
> > > > This patch series is rebased from the linux-dm/dm-6.5-provision-sup=
port
> > > > [3] on to (a12deb44f973 Merge tag 'input-for-v6.7-rc0' ...). The fi=
nal
> > > > patch in the series is a blktest (suggested by Dave in 4) which was=
 used
> > > > to test out the provisioning flow for loop devices on sparse files =
on an
> > > > ext4 filesystem.
> > >
> > > What happened to the XFS patch I sent to support provisioning for
> > > fallocate() operations through XFS?
> > >
> > Apologies, I missed out on mentioning that the XFS patches work well
> > with loop devices.
> >
> > I might have misunderstood: were those patches only for sanity testing
> > or would you prefer that I send those out as a part of this series? I
> > can whip up a quick v10 if so!
>
> I was implying that if you are going to be adding support to random
> block devices for people to actually test out, then you should be
> adding support to filesystems and writing new -fstests- to ensure
> that loop devices are actually provisioning blocks at exactly the
> locations that correspond to the physical file extents the
> filesystem provisioned, too.
>

Fair enough, let me work on an additional fstests patch to validate that.

Best
Sarthak

> -Dave.
> --
> Dave Chinner
> david@fromorbit.com
