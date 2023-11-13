Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF932377B
	for <linux-block@vger.kernel.org>; Mon, 13 Nov 2023 21:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SWNKusEi"
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A405D5F
	for <linux-block@vger.kernel.org>; Mon, 13 Nov 2023 13:27:03 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5446c9f3a77so7634320a12.0
        for <linux-block@vger.kernel.org>; Mon, 13 Nov 2023 13:27:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699910822; x=1700515622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mttVMjujBnJtfA9qmPOIHfeRm+JAOLtRVgarlviBSVY=;
        b=SWNKusEikZ1DnrYVHQ0hQIr0P5xQ6d7ccHuOGHJIjnhbSRJxEpYKgjbrhrwOYU93Tz
         UXeeIK82VcqmypH86NZdLRny5x+n3RkaXs9A0Q8zejFkSAWi3wON91+UFgN0drxH7dZS
         L1I8W1/dkxAmQBmo2KMtchZsfVIPIaVscjoQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699910822; x=1700515622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mttVMjujBnJtfA9qmPOIHfeRm+JAOLtRVgarlviBSVY=;
        b=VPHz0z24wGyGhGf9Hr1ew40owSlhQ6/y4TJwEd37x83C6ABmpJ5ogbrAj75uZq3r2i
         sij4Yed+GBO2e5tmo6fVhYJbbw6+2vXDutWDEVdy7BJUPZSUO9jCMics88CUgUfa2q4L
         nyrKe7Ly8RqI0CxdihIw6YbvkVdupEA6w7iWtLPPndqSbhnTTN9uLKhURZq+C2qNWOAF
         MINRYFdpEr0GjraFmw9OXETzMELZVeVwjN/6o7mZadDz7zJx8LKUoTi7w/1tR3BO9g87
         oaHzG2PBgd3WcxbiP0oS1qEbBrS0SSCSShaMuqtapti2sVzV2KHgryFbLs67j0Wh30PE
         rksg==
X-Gm-Message-State: AOJu0YyVoQsWh6AVIRAxcshbKF9J4qk6XhsZdYzJBOPDhudnQ75BoEZe
	HhiTaeVpihw2/s6ZDoVat9IVH1KfKm9UpgyPLR7tBQ==
X-Google-Smtp-Source: AGHT+IGoL4C64VRkqMMt2Ko2g8gaFMw8YCcpuwoNcjFqFlvPZKJTDjJL2Bgl7LbSUmzZ0cB+I9TezFzC6HBD0IZ7Sjs=
X-Received: by 2002:a17:906:dfca:b0:9e4:67d9:438 with SMTP id
 jt10-20020a170906dfca00b009e467d90438mr5397879ejc.56.1699910821965; Mon, 13
 Nov 2023 13:27:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110010139.3901150-1-sarthakkukreti@chromium.org> <ZU7RVKJIzm8ExGGH@dread.disaster.area>
In-Reply-To: <ZU7RVKJIzm8ExGGH@dread.disaster.area>
From: Sarthak Kukreti <sarthakkukreti@chromium.org>
Date: Mon, 13 Nov 2023 13:26:51 -0800
Message-ID: <CAG9=OMPFEV9He+ggq2mcLULnUZ2jm8fGU=4ca8kBoWtvqYcGVg@mail.gmail.com>
Subject: Re: [PATCH v9 0/3] [PATCH v9 0/3] Introduce provisioning primitives
To: Dave Chinner <david@fromorbit.com>
Cc: dm-devel@lists.linux.dev, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Jens Axboe <axboe@kernel.dk>, Mike Snitzer <snitzer@kernel.org>, 
	"Darrick J . Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>, Brian Foster <bfoster@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2023 at 4:56=E2=80=AFPM Dave Chinner <david@fromorbit.com> =
wrote:
>
> On Thu, Nov 09, 2023 at 05:01:35PM -0800, Sarthak Kukreti wrote:
> > Hi,
> >
> > This patch series is version 9 of the patch series to introduce
> > block-level provisioning mechanism (original [1]), which is useful for
> > provisioning space across thinly provisioned storage architectures (loo=
p
> > devices backed by sparse files, dm-thin devices, virtio-blk). This
> > series has minimal changes over v8[2], with a couple of patches dropped
> > (suggested by Dave).
> >
> > This patch series is rebased from the linux-dm/dm-6.5-provision-support
> > [3] on to (a12deb44f973 Merge tag 'input-for-v6.7-rc0' ...). The final
> > patch in the series is a blktest (suggested by Dave in 4) which was use=
d
> > to test out the provisioning flow for loop devices on sparse files on a=
n
> > ext4 filesystem.
>
> What happened to the XFS patch I sent to support provisioning for
> fallocate() operations through XFS?
>
Apologies, I missed out on mentioning that the XFS patches work well
with loop devices.

I might have misunderstood: were those patches only for sanity testing
or would you prefer that I send those out as a part of this series? I
can whip up a quick v10 if so!

Cheers

Sarthak


> Cheers,
>
> Dave.
> --
> Dave Chinner
> david@fromorbit.com
