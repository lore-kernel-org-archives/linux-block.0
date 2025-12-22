Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC952F3C34
	for <linux-block@vger.kernel.org>; Mon, 22 Dec 2025 15:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766416206; cv=none; b=am9DPOix2rGtejI3pkJ8GBfNSzatLCZ7v4jIRWp64Jc+UpFOpJUeZUQJxGOeMOrizlfa7O7b6B0/hOneKd1K7nU3EIKrLFsDdibIUGh7xiNkqedFYGXboOUNo/WB4jXbJJ/M6Yt18pvw/srozongV5YrAtlbpZJ/tanvZHNSi60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766416206; c=relaxed/simple;
	bh=tAKy4bMV3DM0vKtgXMN0pMiR+oQPhcjNnK2H4+iMMMM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SKesMLHa5Z0r36ME5G0WAD10vfSSQ/AGQ8yvKcIL162K3USk2Qj4uAfH6ud1mg4YL5rUuYAzC/e5ZhEbyVietPM77V7/l21DPb3xvjWdXdoP/roN575wLi1zs4To8LCWJcfMqS8xuhoJ0pBUC9Crtffcx2608KdJI+OVuVDP79Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=O8INUE8N; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="O8INUE8N"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7e7a1b08e9dso161688b3a.2
        for <linux-block@vger.kernel.org>; Mon, 22 Dec 2025 07:10:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1766416203; x=1767021003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMdFQ93xacGpn515wZlx0nZOWnyfYznFKimZtqIXQqA=;
        b=O8INUE8N1tnNWC/+QFTNKW0QsT06uRFjXZKHOeXX1QLwpxtJnEwwNWVo1v5IY7jozM
         dpmefzbTE9uHiqdzqQ/eehTf9CwNx216h99NW2djLNpNdGqPA4AT7eLSTH2LQVehsNUv
         8BrtScjO2R+oZPhuzdrPr1pdbpVxOtRo/z5rO1bb4JaK9XH+EqI5bL2Nu8m57XHhDgCK
         WLy0I5iwxNrVAbHI6OAvamxExinShjDNgLamjZUj++2orR6O5U0PgKln03lmzzaUKzUB
         VJRNqezpOK0cL1/bPG1FYlWBfMNh++yjRTCnZAjaQ8hs50OxVGrsvjjTrH2sKo4Z0I29
         kx9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766416203; x=1767021003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WMdFQ93xacGpn515wZlx0nZOWnyfYznFKimZtqIXQqA=;
        b=I+bwZXUKRgOpHbwQIsnlPHyDQquv1DTOVfHx4bymGWxRGB3oCM6sHG1WP7K2HF1LEV
         ITH8BtDZqlED2vrJ+5E5znE75h/UHC3UYuOGc4uOVDStu+1XuCTaUx9jonfncY65Pvj+
         zl9tcY7lN21GUZWd9PfYRCn78RANy2JC5sdYLDmhh7ZEbCAxrrWET8E5W+V4rUiYGYU1
         x4YxhZZf/4/V5sPtjYEYKF8z3dZx4P97sIwBPvPBMCPqkzen+cO85f5TywxAeOJPRn/M
         IQPbdbR7s+tck9Ih1vEjGfxs58h+znlI/Yp9Bo1J8cN2I8sBFG1DIX9HuAdExfO8dQuG
         FPDw==
X-Forwarded-Encrypted: i=1; AJvYcCU1lC0NQz6LYuE0ViPw0vnh2gkgzaxbPNClIRVZpYfPDaE+GWSvxlJ/67Cb7Hz2w2Ln5dtY/OhViJ2FIw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/6TdlE+w3M0/BK3TIWsCCkXLYPEnRhf+eATWQr+6gwARZy6nC
	EeYYbzKU/NmhRrv6hvqGb3vOceC7BB3KdzWw36peIg1Ge2bhADGsWwGuTIX95e5y4BFNyjzss1X
	tPmWlM8dkFy4cjdaPPqtPEPhWZ6jQLNmQlBqlOAW4Og==
X-Gm-Gg: AY/fxX7lR7pgt3Z3KDL4+nO9lOBAKO7uqjrnMwbANPr7gA/j1mRVYnyDUHbQKnTSOdZ
	80BUfFeyIHYHCNgqaa53ZVMiMlQDmQxRFajw2VEo2SQnjiP3DFd7o/R2njTcGZVj2cAbYpkQT8l
	aVeitDOheHuyOkdp9B2fXIgYiJ+xh8jataKXmZvKDQaUK3Ef34tVrKaWCJeZlUjc5oW40VhYXFI
	DJGVeD0slJq1+LItJXt5TUYblrRZWHUtJjZD8mcp2H7rz4lRf+G/mpxHqbGREmy7uraqgk=
X-Google-Smtp-Source: AGHT+IGLJDtjymDAr9V5Vg5EfhSwI1vfO4LprXhvsDLowCFqm0dSh+n8i/q9s2iDn4CdDy6KrAe64MOogTgDbE3+B2k=
X-Received: by 2002:a05:7022:4287:b0:11e:3e9:3ea5 with SMTP id
 a92af1059eb24-1217230117bmr6596225c88.7.1766416202455; Mon, 22 Dec 2025
 07:10:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251217053455.281509-1-csander@purestorage.com>
 <20251217053455.281509-5-csander@purestorage.com> <aUlVDtLgPh6NCWsC@fedora>
In-Reply-To: <aUlVDtLgPh6NCWsC@fedora>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 22 Dec 2025 10:09:50 -0500
X-Gm-Features: AQt7F2r98lslmm2BhKy0RLdile86RIpHXz0S5jBJQgkpLCUcmVLkZRGm8cFGzHY
Message-ID: <CADUfDZp5Or_Q+7HKtdi97n5kBpQ=zpOFAtqfatR3nu+=yGLb_Q@mail.gmail.com>
Subject: Re: [PATCH 04/20] ublk: add integrity UAPI
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Stanley Zhang <stazhang@purestorage.com>, Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 22, 2025 at 9:26=E2=80=AFAM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> On Tue, Dec 16, 2025 at 10:34:38PM -0700, Caleb Sander Mateos wrote:
> > From: Stanley Zhang <stazhang@purestorage.com>
> >
> > Add UAPI definitions for metadata/integrity support in ublk.
> > UBLK_PARAM_TYPE_INTEGRITY and struct ublk_param_integrity allow a ublk
> > server to specify the integrity params of a ublk device.
> > The ublk driver will set UBLK_IO_F_INTEGRITY in the op_flags field of
> > struct ublksrv_io_desc for requests with integrity data.
> > The ublk server uses user copy with UBLKSRV_IO_INTEGRITY_FLAG set in th=
e
> > offset parameter to access a request's integrity buffer.
> >
> > Signed-off-by: Stanley Zhang <stazhang@purestorage.com>
> > [csander: drop feature flag and redundant pi_tuple_size field,
> >  add io_desc flag, use block metadata UAPI constants]
> > Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
> > ---
> >  include/uapi/linux/ublk_cmd.h | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/uapi/linux/ublk_cmd.h b/include/uapi/linux/ublk_cm=
d.h
> > index ec77dabba45b..5bfb9a0521c3 100644
> > --- a/include/uapi/linux/ublk_cmd.h
> > +++ b/include/uapi/linux/ublk_cmd.h
> > @@ -129,11 +129,15 @@
> >  #define UBLK_QID_BITS                12
> >  #define UBLK_QID_BITS_MASK   ((1ULL << UBLK_QID_BITS) - 1)
> >
> >  #define UBLK_MAX_NR_QUEUES   (1U << UBLK_QID_BITS)
> >
> > -#define UBLKSRV_IO_BUF_TOTAL_BITS    (UBLK_QID_OFF + UBLK_QID_BITS)
> > +/* Copy to/from request integrity buffer instead of data buffer */
> > +#define UBLK_INTEGRITY_FLAG_OFF              (UBLK_QID_OFF + UBLK_QID_=
BITS)
> > +#define UBLKSRV_IO_INTEGRITY_FLAG    (1ULL << UBLK_INTEGRITY_FLAG_OFF)
> > +
>
> I feel it is more readable to move the definition into the patch which us=
es
> them.

Sure, I can do that.

>
> > +#define UBLKSRV_IO_BUF_TOTAL_BITS    (UBLK_INTEGRITY_FLAG_OFF + 1)
>
> It is UAPI, UBLKSRV_IO_BUF_TOTAL_BITS shouldn't be changed, or can you
> explain this way is safe?

It's not clear to me how userspace is expected to use
UBLKSRV_IO_BUF_TOTAL_BITS. (Our ublk server, for one, doesn't use it.)
Can you provide an example? It looks to me like the purpose is to
communicate the number of bits needed to represent a user copy offset
value, in which case it makes sense to include the integrity flag now
that that bit is being used.

>
> >  #define UBLKSRV_IO_BUF_TOTAL_SIZE    (1ULL << UBLKSRV_IO_BUF_TOTAL_BIT=
S)
> >
> >  /*
> >   * ublk server can register data buffers for incoming I/O requests wit=
h a sparse
> >   * io_uring buffer table. The request buffer can then be used as the d=
ata buffer
> > @@ -406,10 +410,12 @@ struct ublksrv_ctrl_dev_info {
> >   *
> >   * ublk server has to check this flag if UBLK_AUTO_BUF_REG_FALLBACK is
> >   * passed in.
> >   */
> >  #define              UBLK_IO_F_NEED_REG_BUF          (1U << 17)
> > +/* Request has an integrity data buffer */
> > +#define              UBLK_IO_F_INTEGRITY             (1U << 18)
> >
> >  /*
> >   * io cmd is described by this structure, and stored in share memory, =
indexed
> >   * by request tag.
> >   *
> > @@ -598,10 +604,20 @@ struct ublk_param_segment {
> >       __u32   max_segment_size;
> >       __u16   max_segments;
> >       __u8    pad[2];
> >  };
> >
> > +struct ublk_param_integrity {
> > +     __u32   flags; /* LBMD_PI_CAP_* from linux/fs.h */
> > +     __u8    interval_exp;
> > +     __u8    metadata_size;
> > +     __u8    pi_offset;
> > +     __u8    csum_type; /* LBMD_PI_CSUM_* from linux/fs.h */
> > +     __u8    tag_size;
> > +     __u8    pad[7];
> > +};
> > +
>
> Just be curious, `pi_tuple_size` isn't defined, instead it is hard-coded =
in
> ublk_integrity_pi_tuple_size().
>
> However, both scsi and nvme sets `pi_tuple_size`, so it means that ublk P=
I
> supports one `subset` or scsi/nvme `pi_tuple_size` can be removed too?

blk_validate_integrity_limits() validates that pi_tuple_size matches
the expected PI size for each csum_type value. So it looks like these
fields are redundant. Yes, pi_tuple_size could probably be removed
from the scsi/nvme block drivers too. But maybe there's value in
having the drivers explicitly specify both values?

Thanks,
Caleb
