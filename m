Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648CF21C17D
	for <linux-block@vger.kernel.org>; Mon,  1 Dec 2025 18:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764615156; cv=none; b=SG7WKdcEwxW//z4g1UTg/O5jdV9MPym0r/X9XOgTaIduO74Q1cJhBsciDgCsbf9d8gENe8q4oKfz1DcwzCINHGmNmU+PV7f9tbxgwBTu8oFh5/YP/VREaBuMvYDho60kxZmuzJnhXmX0Q5bGz6OS45oVR1gTKMPnEdPQCZcFWqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764615156; c=relaxed/simple;
	bh=8ZI7HXRD7C7Lk84zNoXxp8xfj4TIWd2j/I9yX/gDcBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UYDAVNv1a83YJZB4dBjlEp6G57ZQ3Wyf3tWE1rzp9WdnkO+kdan0e4OfRzrMyYnq+64D3utViSX1luxD11OVPXWCMNBq+dp29Cb2n5X0s1/Y8TIWU7kP+JHUFrTmpdp5vzNL+sRY3637JRoOWi6QuTBL+AZjJpQncGYEY3//Exk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=FTlKbk8J; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="FTlKbk8J"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7d481452588so207335b3a.3
        for <linux-block@vger.kernel.org>; Mon, 01 Dec 2025 10:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764615154; x=1765219954; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5v+tN7T+FZ7FvSyTlnaz0oo+AiRUu9HFbCnAsmSEh8=;
        b=FTlKbk8Jt+L/b6o+l1qZV5W1wtwUn3A6ITUtIlfyF2GjeP2iyFdEQm4FaXS0/Zcs1l
         1UpoUk/k2CKs6jr4I2cw4OLfBomZQskfteTSSKOL9wesbmk5OwaGTLsRJCwWXvfydrtW
         Un3vGCcXkXxlEq7H0rHgxnA5iDl16lOqBUIZnPZMDiD2WaYGL40cMlX9uYePgjv+6B93
         Qdemzn2y3kJihm5srYNsDAurv5HHrNY59bTSw78JyOnf3y90KHAx49S8g6wdLs+63b31
         0vF45twOLCKADFRSxuRNWFqWKq3O7wf2yNWB4bmZUDAgPeOOV8HOb3hvy1xUESH55i4i
         le7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764615154; x=1765219954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z5v+tN7T+FZ7FvSyTlnaz0oo+AiRUu9HFbCnAsmSEh8=;
        b=P2A/D4PCzrSQDQBZuFa2/maXSEm9LZItp9wWDxkIWNQ2yS3bi1kcxJU9CwhmfVO1vA
         eZnZqbx97BCVCyjePqzUTQn0tKLUzOCqrCgw6p7h78T/HIs8oj0jmjjapc6NyzjDi6JN
         u6hqstXA2pmWZSYG3JMRzy1EGSGVi0Oao1xS6qiVIIGtcEytm7R8/A4L/oq9PA+PZZV9
         J8jfprNlq6k5UmSjVO0LjiwmRaT0hxwmCir0KfLPHsxP9MOcfwR2kfog1K68R3AxYhOf
         2VdJZ6TszmCGh5laBMjBRtAcsrxyPh/E4q5ykiiWuwfO7kit1bXGNt6iGTSPsNSYaT8S
         JzFg==
X-Forwarded-Encrypted: i=1; AJvYcCVIChfTn1MvVnv015gHqntEmXK8ym0CbedbXpoB+Fr/GI3ApJLd9gyiVYAkY1RGxVyQB3v7N9Hb7+taug==@vger.kernel.org
X-Gm-Message-State: AOJu0YzhlJjn+gaQtoEtaHniVq1aKCrd3PKn+ikzgNO24kyAIWunRO2Q
	kiaOlO/pFlHWykA4Kf7ID/vTlceUF2vQ9YXZz2DUwzTByLnBHuppcKW2WTUdRDh4uo827YC+GPT
	e4it98CGHLaYAhhT5kgXGiB/TziLePMeQc5upEFay0LcJ1YJxiyB4A7pI+g==
X-Gm-Gg: ASbGncuLT9XWDt1k2jrNngqNIc28ijWYiXjDXES+MEZJEXJI0JcWWhLmkPVrat4dqkx
	av6xBR0Uwlp5JaaudY/5yxtKYSi0AdgEH8vcyqdcIk7L6nLKt0fnY8cWKD4XoBrt6J0+UV7KrUp
	8oiFYz7sJaKH24Fv2iamOwHuUg4anYm7fxXQZreECckH4ZI52+4dfNatWSSvqHfbId+GgV2ueei
	atXAIxS15foSH4KMc4jZrkaq3YLzOFjULnVu6tMmliqBb/q1MgGcIqAkjFVzfdzUHRjz+yg
X-Google-Smtp-Source: AGHT+IEBkAx6gW/q8xkDbcB4C4fmfmF5iyWdGNWJphenjeroDliWAZuJC2p1wG9RCKQ1AAJUSV6SZZE7KybYqqYo+qk=
X-Received: by 2002:a05:7022:921:b0:11b:98e8:624e with SMTP id
 a92af1059eb24-11c9f37aa52mr22490823c88.4.1764615153480; Mon, 01 Dec 2025
 10:52:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251121015851.3672073-1-ming.lei@redhat.com> <20251121015851.3672073-16-ming.lei@redhat.com>
In-Reply-To: <20251121015851.3672073-16-ming.lei@redhat.com>
From: Caleb Sander Mateos <csander@purestorage.com>
Date: Mon, 1 Dec 2025 10:52:22 -0800
X-Gm-Features: AWmQ_bl4QoAMVT_b3D9obcI4iNDffDJVizl2DAR_WAsIYzaRMrqMzeee_XKnLdc
Message-ID: <CADUfDZrGq31ayxH-UkU6RcsApQdaqEgehcrVtPyuxXnkTOze1Q@mail.gmail.com>
Subject: Re: [PATCH V4 15/27] ublk: abort requests filled in event kfifo
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org, 
	Uday Shankar <ushankar@purestorage.com>, Stefani Seibold <stefani@seibold.net>, 
	Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 20, 2025 at 6:00=E2=80=AFPM Ming Lei <ming.lei@redhat.com> wrot=
e:
>
> In case of BATCH_IO, any request filled in event kfifo, they don't get
> chance to be dispatched any more when releasing ublk char device, so
> we have to abort them too.
>
> Add ublk_abort_batch_queue() for aborting this kind of requests.
>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>
> ---
>  drivers/block/ublk_drv.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
> index 2e5e392c939e..849199771f86 100644
> --- a/drivers/block/ublk_drv.c
> +++ b/drivers/block/ublk_drv.c
> @@ -2241,7 +2241,8 @@ static int ublk_ch_mmap(struct file *filp, struct v=
m_area_struct *vma)
>  static void __ublk_fail_req(struct ublk_device *ub, struct ublk_io *io,
>                 struct request *req)
>  {
> -       WARN_ON_ONCE(io->flags & UBLK_IO_FLAG_ACTIVE);
> +       WARN_ON_ONCE(!ublk_dev_support_batch_io(ub) &&
> +                       io->flags & UBLK_IO_FLAG_ACTIVE);
>
>         if (ublk_nosrv_should_reissue_outstanding(ub))
>                 blk_mq_requeue_request(req, false);
> @@ -2251,6 +2252,26 @@ static void __ublk_fail_req(struct ublk_device *ub=
, struct ublk_io *io,
>         }
>  }
>
> +/*
> + * Request tag may just be filled to event kfifo, not get chance to
> + * dispatch, abort these requests too
> + */
> +static void ublk_abort_batch_queue(struct ublk_device *ub,
> +                                  struct ublk_queue *ubq)
> +{
> +       while (true) {
> +               struct request *req;
> +               short tag;

unsigned short?

> +
> +               if (!kfifo_out(&ubq->evts_fifo, &tag, 1))
> +                       break;
> +
> +               req =3D blk_mq_tag_to_rq(ub->tag_set.tags[ubq->q_id], tag=
);
> +               if (req && blk_mq_request_started(req))

If the tag is in the evts_fifo, how would it be possible for the
request not to have been started yet?

Best,
Caleb

> +                       __ublk_fail_req(ub, &ubq->ios[tag], req);
> +       }
> +}
> +
>  /*
>   * Called from ublk char device release handler, when any uring_cmd is
>   * done, meantime request queue is "quiesced" since all inflight request=
s
> @@ -2269,6 +2290,9 @@ static void ublk_abort_queue(struct ublk_device *ub=
, struct ublk_queue *ubq)
>                 if (io->flags & UBLK_IO_FLAG_OWNED_BY_SRV)
>                         __ublk_fail_req(ub, io, io->req);
>         }
> +
> +       if (ublk_support_batch_io(ubq))
> +               ublk_abort_batch_queue(ub, ubq);
>  }
>
>  static void ublk_start_cancel(struct ublk_device *ub)
> --
> 2.47.0
>
