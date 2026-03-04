Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EC7313550
	for <linux-block@vger.kernel.org>; Wed,  4 Mar 2026 21:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772658232; cv=pass; b=dGDp5cF3LG+avyvFAp0CgQ075ffbfx8iP5qJMctcStOd2xE0Vsl7lzE7ZFZizmiMzPaJtj/zQb7QH8xATpmPoIpbBVAFUx2h+z3QcniX8NujNXnjIlxwXeQT9gvSy5Qr9FAiwcmICW6vS7v7Wtf2LukPuDHGlMpvCMpOUUvJNBQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772658232; c=relaxed/simple;
	bh=GECDR3MiHrLPiJx3AR+CazF/u3w9CAHu6SPQUhYguYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LWYyfUIZld2DM2cLY0h7g1uTbiCLG7NwLAanwyijxzvPhtiTBQmpeUNvPC+we5A7G8msAaQjS1xNXuIdJq3T7RZnM1uOvXNrHUxGFUXlJc7wdYcaAjk3EB3FEYBSJ2LXKLbJ6ODoD11sppM6l4/YjG9J0qcVtiAWSfx42O65OJU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=XwK/cPDA; arc=pass smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="XwK/cPDA"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7d189de4577so978063a34.2
        for <linux-block@vger.kernel.org>; Wed, 04 Mar 2026 13:03:50 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772658230; cv=none;
        d=google.com; s=arc-20240605;
        b=Eo3wpDbyuoXSRwKslHVKSdfRh4EKwcPX9lt2yf1G3SSTv2pwM1f58xVSc96fKGmWi3
         rjRx74I0FFGoZEDdZJVguQz0jbyF0I7geR2iH4K/VqwyLLm3dUEFuAJqwSFGrD8yEZTC
         GspDozJ7cpH4ScJb2osoD6kJxkq11eF6+BLGHkJyYvFhDkWPjOSQxImzu9+2FQLARtk/
         lXIyB2b9oPdrvs1GRlBR1mgzpIpYzurP1SscEsny0r7ePnHQNMTDbbliCGNLEBCMukKK
         iGpYyBd9C3waNkBrCcvg2KTZ+j1bGEcCpXvMLJ3fWcwkSQNBnxwZo8k9IR1sac4jptgU
         42VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=m2rJ3wHEwvn2Dls6Y/Edk+sJKb/bALjhDyQlCHbqn84=;
        fh=v6W5pYlJ+KMQ32oNkYzk6ET1RWQVKUdb+4MlfesVA78=;
        b=MgR17dwnARo46qw0XVQCwCJ4jGmypw/cIIZqfXm5Pp0G/neRPaOSQy5F7+y76y7J49
         VJTpjMVB4zHO2ozob4p33Nce9gJgvPVz6Lochw1pg4wTvNn3EPBwGhAn/O1h0SN3tQth
         ZfV3vC+akfBcHzesyFBvtAX8sbSZAJ2YpGscgH0ivSZq64rOdYh7ucZbh5EKe3CwOTB/
         aD8+iB+uJsWHkLxJ7A9vUbfN3HIiObPl7HY/3bJxOqRIyvuOBSQYLTMPu442QgkZX93/
         Zrq0FyWT4arZ+7e+/tL4K+JV8qmMVY/zILPkK5eebVKzqSVrBpY/kjO4CmTNmrADzjzZ
         flzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1772658230; x=1773263030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2rJ3wHEwvn2Dls6Y/Edk+sJKb/bALjhDyQlCHbqn84=;
        b=XwK/cPDAjuMOLqtHmEJpfAVliJga4yhCFR2Q3GgF4hRneQdP0V4eVRo8y60rWSVUIf
         X7OJcXqueA6rSunRY3h4bxompbmnLDiyIVoo/R0DReGJZMXwE6NhP5JdNo+xEf3QuPXJ
         W2hz1JEyWVUC06Ta/EIW9wRHGBU60pa9b9f4s28y8F/vNldg6fB/fYFp3znKsVQikM9x
         /tjm6VEdzhQKQqf9qdADKHiD2tPMf2BSA1HNENz/cfWG8ugbKeOkl8QGYZRmGxJnerxB
         wU6fGDL1qPfJzXPOSASCY54r213+ulD+BZgziE+r405R5NZFE8E0OBL9ZCWm3KYSikKa
         kNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772658230; x=1773263030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m2rJ3wHEwvn2Dls6Y/Edk+sJKb/bALjhDyQlCHbqn84=;
        b=BfgsfPpRk0PHu68jWuGSVkuauh+CHyQXILh0e8szFIix3zVQYn/YB1vW8z9TeToyuD
         jGRakbSnIIiAPFe4z901nUVERplQPcQyWVKUYWlRm2LYY54X/RI4dyxCvjHQoNtRqKlq
         jlbXC/AO5nSFU4ZKCmVLfMwvoXG2opmMtbxw63yHMQQU8cElIaJ/ehhlZzpAKPfnswJU
         PwxsCEomCbEQW1yLeD/53rWYjCBA8IcR4OBZtyEO1wd+bpejgmU3KDbGeeuDDrWhC4X2
         J7KA6Eh23/8PmT6s+3LGb3FYSfm0FFZC8FtuPG4xy7RufeNAEUtQLt5qgCMrzyo3jjhW
         IJbA==
X-Forwarded-Encrypted: i=1; AJvYcCWn3fuRXYnY2CX3uu35qgEHHNOGwXd3grg/zwFf+5k3XCc89ljbyTrNk6Ez3BhVsw4emN8oWC6o9AVkpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrVvr7jOZFK6yxes0TjgpkR+Gtd1DsRE4NZyo2Yvk3w42PQ/HV
	zsoBDTXZ9Rmz08wy25cIxWPN1HLbWdl8a2ushVNzQzHClAId/WK9gLv41ZM4K6bS1p/1xgGuITg
	v+haNWG8TDqWbdawud2ItT2HTLZQyd8sFLFJzUCC2TA==
X-Gm-Gg: ATEYQzwx4d5bGb8bq5ya/1dEnH9c5Lke8oeocH0Rohk5kwSfu/dR3rnA9piOBFw/0oe
	aomtQ/1P8dnwQH613f7C7MM07HKWOM6hURYbahXPeECkZYozDnh0CEk1PO1Ip44PrkkZnyXIYY3
	+8kI6iUcjeITOav+AyRRN0XsU9ZsEXbzgyjMnNIDG2M03GQxBLaO8ZRPVQ5kdMAOP0JMK3OsLSD
	HvQPppUlMWOpOxZRkPM4mySrG/xybmXbRplnkGbb8Vo4yQEMkhmlkK5EiPMpS10pxf7hKiGODHi
	2I7XUl8=
X-Received: by 2002:a05:6808:1a04:b0:45a:8cdc:5ff1 with SMTP id
 5614622812f47-4651ab2b460mr1492953b6e.1.1772658229895; Wed, 04 Mar 2026
 13:03:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304194843.760669-1-bvanassche@acm.org> <20260304194843.760669-12-bvanassche@acm.org>
 <CADUfDZon_tUuZzH3we4NdPg_MB-LQsMWbeRrLAiqzBbSM9hG-g@mail.gmail.com> <c658a073-ec42-40df-a03e-c34cb5c3f545@acm.org>
In-Reply-To: <c658a073-ec42-40df-a03e-c34cb5c3f545@acm.org>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Wed, 4 Mar 2026 13:03:38 -0800
X-Gm-Features: AaiRm53HqePbCxazs3mibuc-_1FD2l9DP2wxz-eS4QCG9XVF7CE2GDFl6SzKHZ8
Message-ID: <CADUfDZrYu42KbiBNoXtuHUKAuXFxovydLRvNrXAEw9hL6puXiw@mail.gmail.com>
Subject: Re: [PATCH 11/14] ublk: Fix the lock context annotations
To: Bart Van Assche <bvanassche@acm.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Damien Le Moal <dlemoal@kernel.org>, 
	Marco Elver <elver@google.com>, linux-block@vger.kernel.org, 
	Ming Lei <ming.lei@redhat.com>, Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 12:55=E2=80=AFPM Bart Van Assche <bvanassche@acm.org=
> wrote:
>
> On 3/4/26 2:43 PM, Caleb Sander Mateos wrote:
> > On Wed, Mar 4, 2026 at 11:50=E2=80=AFAM Bart Van Assche <bvanassche@acm=
.org> wrote:
> >>   /* device can only be started after all IOs are ready */
> >>   static void ublk_mark_io_ready(struct ublk_device *ub, u16 q_id)
> >> -       __must_hold(&ub->mutex)
> >
> > I don't think this is right. Both callers of ublk_mark_io_ready() hold
> > the mutex: ublk_fetch() acquires it directly, and ublk_batch_prep_io()
> > is called with it having been acquired in
> > ublk_handle_batch_prep_cmd(). The stores to ub->unprivileged_daemons
> > and ub->nr_queue_ready would be data races if the mutex weren't held.
>
> Does this patch look better to you?
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 34ed4f6a02ef..26c368e5358b 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -353,11 +353,13 @@ static inline bool ublk_support_batch_io(const
> struct ublk_queue *ubq)
>   }
>
>   static inline void ublk_io_lock(struct ublk_io *io)
> +       __acquires(&io->lock)
>   {
>          spin_lock(&io->lock);
>   }
>
>   static inline void ublk_io_unlock(struct ublk_io *io)
> +       __releases(&io->lock)
>   {
>          spin_unlock(&io->lock);
>   }
> @@ -3160,6 +3162,7 @@ static int ublk_check_fetch_buf(const struct
> ublk_device *ub, __u64 buf_addr)
>
>   static int __ublk_fetch(struct io_uring_cmd *cmd, struct ublk_device *u=
b,
>                          struct ublk_io *io, u16 q_id)
> +       __must_hold(&ub->mutex)
>   {
>          /* UBLK_IO_FETCH_REQ is only allowed before dev is setup */
>          if (ublk_dev_ready(ub))
> @@ -3581,6 +3584,7 @@ static void ublk_batch_revert_prep_cmd(struct
> ublk_batch_io_iter *iter,
>   static int ublk_batch_prep_io(struct ublk_queue *ubq,
>                                const struct ublk_batch_io_data *data,
>                                const struct ublk_elem_header *elem)
> +       __must_hold(&data->ub->mutex)
>   {
>          struct ublk_io *io =3D &ubq->ios[elem->tag];
>          const struct ublk_batch_io *uc =3D &data->header;

Sure, these annotations all look correct. But it's not clear to me how
you're deciding which functions need an annotation. Is clang just
unable to see that ub->mutex is held here because the function is
called indirectly through a function pointer?

Best,
Caleb
