Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A276C39C639
	for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 15:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773673342; cv=pass; b=lFf/vbwKAbSZHNdFg4aXoCBBjsJ4FHLhn8nv/MwlNN42sxKfdFHOih4NePAbJykyVDlkEKsKqrbmNYLPX2k+4LCUS8n2izrLblgd8+gQ6LXlxJEkvMT7QTYxhbU+nXZE5wfqFIWVkLo/GM1MOPiGgPHbylr3sO1SMlQ8DDFQZwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773673342; c=relaxed/simple;
	bh=aB1BhmwfaYDhk9Ng1L6dfOkJ4tW5IumC6VwMJNkiH0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m2+2AB/n/yjNBTIric+gom0X7ri3VBx4g9QXsWF34TS3y62BL6W0ptCfsHlGWOudrKXLLxt+tXPZlgimtI9anSJ1VmxU+9T8m2NYL4yVXVSmOOyOq0IvV9rD/AxnQZiDId36cNXoa4pFyyv2JX0FnAGpBALtkVgedbAQYOOSoPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rrpER0b3; arc=pass smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rrpER0b3"
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-38a3990e87fso31420411fa.3
        for <linux-block@vger.kernel.org>; Mon, 16 Mar 2026 08:02:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773673335; cv=none;
        d=google.com; s=arc-20240605;
        b=a6ZEnSn/bOujpQxVrXoYctQ5AHoNPxZsouqkOZbvwN8fPWBTAQhBCBw+FyL39phHHy
         Swqn/Gv121FMVczJt+ps2rki2z51gI5qvd5ZKezJRM3e3M+wM4K25XPaEQXxXtIXIzbG
         FOXtIUxQF57dtWXe6aK/Ji2sF1JnAxisirNnMQdanuH71ABJLV5Ei9gvrTNKL3m9ZF8Q
         ac0yH/BWulWXqwGvluqH94LaMW3dsbHLujL8sGK3J6gYowOPeJfYE6NkI4ShHbB0UKYl
         ZsC8mdCGShu0FLSQJcIFZll13RKg/U04niEGMinS/R8IkzVd+QvgXIZA0SmR2aHcy6RN
         HkgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=fPpnDc3nJAqYDYdTF/V0tJtbqHodlka6bXcAXAw45mk=;
        fh=IxbL6Ugw3/0rNO2IIcTZ4hBNP4NRxi+ZgMlElmxwVp4=;
        b=GSGPj7A8xUNO9ahZGXnDM7hjBa166KZ65l40Bczoshjt0Fcj47VsK+igG7eVqUj08J
         Gdwmr3qdzrB3JD/p9hc8HX0c78B2cTIKPyu8+SWipXIExq3AFC7KsQN3ueiM+yZRi8IY
         vZncEQEVpLfzqJLrVoUqKBlFT3skX8ngVQZjaeE8VLea0nxbSf3SIGUA/V1+66pXYkAP
         OiP9IliFGhR7YM25FuafoMtdKkuL+pasj46l9ENprh16c/c9e3LoE4Bdd2UNbNYLboop
         058hEX1TR7OKWrfKsxh6bb1RG/Stfi5EsylX1we3aW4ib8og/2ygEToj55n+rJOg5AVR
         r+UA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1773673335; x=1774278135; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fPpnDc3nJAqYDYdTF/V0tJtbqHodlka6bXcAXAw45mk=;
        b=rrpER0b3oQsl6qd2wTfTEp8KCyKWgEh9CHFbHkgrXLBuvYmNT5Y2mxceUIujR/vcsD
         +Bhng7syUXf0SiOomcKMZE763J18jXLbfTU64FUJIQxmEEUs+WtiA6tXvfIMF9scfvH3
         ZKPxuxaHtsVgFGQprRYhFAYlC8Ttzo2unQA4yhQwv7yfK6xbl4F7KXul4Ergno712TLQ
         dDWFHs784BFXDfdUDOip2Qb1tkXYz/nL+Ijrvd1W8q0+bthVUzVQoA9YWaRGjNMFIN4H
         YZf4diIt+XMOMusyeDcqa0PmJdPk4LjOB+SFNMTqBX3kD+dLhP/fu5pSaybhlGKPFZ8N
         SOFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773673335; x=1774278135;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fPpnDc3nJAqYDYdTF/V0tJtbqHodlka6bXcAXAw45mk=;
        b=clQjbssvrIIEQ1K9JMJj9dr1GPrEhYdrtjshrHqte5aCAJBrewmXRyMD8zl88wZW7r
         Xf60sdnwszfbumIGBJLf8Wn035vNxL35b2vEIt54+9ww5FSzS1q9P/+gq6Oh8cV2/5bV
         fHGP5CoeGCYdGyNRCUvpjxDjqKHKisJeZkew9zGmz6secBiNvY7ZjwGAhp4huVoCVuDg
         JsG4M7iNb5o+/Y5WMIJsDnQftFXqynPVg6BO/veJwUbJ3TFMtWif4P825BQN9+f1qvZE
         w22J/2gtTvo65MXK+t3wMZ560NVV5L8hZJH13ppsfq+xqnqzIatlzlkgUb2WNqhs7puY
         3JAQ==
X-Gm-Message-State: AOJu0YyYfx8TTPFCcL3NmoXtC7p05GDYM2rS4G9uzFNp1CSBGf/58wXN
	OU0rFryzBMR61Vg/JiiGv7j7Ww9h9CZi4yyO2PvqZXl9DBc6r3cDHSpdCgfb9qLV4WT1Om6pIQW
	VNrTnEER2i8awmzQnkPoinpWpaKHRokoqeFFnBR8t6A==
X-Gm-Gg: ATEYQzwYbnfW5g2tMUp9TZQj8HJ8xXQMfEOzuvySAWXnzLF++8DPlVfaUltm4ATWhCl
	RQvhdBFn0A0R7pno6z6Bw6Zh+k4xou9ZRvwS2Q8I0/vQeuAIfP8nmJY1WyfWH3xP6ntzc4X+Y+s
	6MgoHq+rS3fQg8s0zRy/xv8rb/3Esqt3UjzfUGTBWU3ZZ89lLBURk9LK42VCvewYROBot8oyFa6
	7DXFF7n43WmnijphPQ8qt6y6GID63FpANrrQK3lr70miFgdNA4XgjHZq56VGpETTp2n8/OIvtgj
	oSw8XywY
X-Received: by 2002:a05:651c:198d:b0:38a:6acb:eb1d with SMTP id
 38308e7fff4ca-38a896a74e6mr48932831fa.12.1773673335310; Mon, 16 Mar 2026
 08:02:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260310160408.3976760-1-b-liu@ti.com>
In-Reply-To: <20260310160408.3976760-1-b-liu@ti.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 16 Mar 2026 16:01:38 +0100
X-Gm-Features: AaiRm53DmLZQRz5smLYrt90KUkm2n5La6ui90ypON_Qi-KmDRDlQMD2Uiw4Wo1g
Message-ID: <CAPDyKFrM92eAxCxU9E1eDNfXMdOC4JvAOXYgY=HcmFG2YfrQEg@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: use single block write in retry
To: Bin Liu <b-liu@ti.com>
Cc: linux-block@vger.kernel.org, linux-mmc@vger.kernel.org, axboe@kernel.dk
Content-Type: text/plain; charset="UTF-8"

On Tue, 10 Mar 2026 at 17:04, Bin Liu <b-liu@ti.com> wrote:
>
> Due to errata i2493[0], multi-block write would still fail in retries.
>
> This patch reuses recovery_mode flag, and switches to single-block
> write in retry when multi-block write fails. It covers both CQE and
> non-CQE cases.
>
> [0] https://www.ti.com/lit/pdf/sprz582

It's great that a link like the above can be provided, still it would
be nice to explain a bit more about the problem in the commit message
too. Can you please do that?

> Signed-off-by: Bin Liu <b-liu@ti.com>
> ---
>  block/blk-mq-debugfs.c   |  1 +
>  drivers/mmc/core/block.c | 12 ++++++++++--
>  include/linux/blk-mq.h   |  3 +++
>  3 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
> index 28167c9baa55..5f97d07fa3c8 100644
> --- a/block/blk-mq-debugfs.c
> +++ b/block/blk-mq-debugfs.c
> @@ -243,6 +243,7 @@ static const char *const rqf_name[] = {
>         RQF_NAME(ZONE_WRITE_PLUGGING),
>         RQF_NAME(TIMED_OUT),
>         RQF_NAME(RESV),
> +       RQF_NAME(XFER_SINGLE_BLK),
>  };
>  #undef RQF_NAME
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 05ee76cb0a08..00016584d70d 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -1401,6 +1401,9 @@ static void mmc_blk_data_prep(struct mmc_queue *mq, struct mmc_queue_req *mqrq,
>                     rq_data_dir(req) == WRITE &&
>                     (md->flags & MMC_BLK_REL_WR);
>
> +       if (req->rq_flags & RQF_XFER_SINGLE_BLK)
> +               recovery_mode = 1;
> +

I don't get this, sorry.

Under what circumstances do we need to fall back to using "single
block"? Or is this just for debugging?

>         memset(brq, 0, sizeof(struct mmc_blk_request));
>
>         mmc_crypto_prepare_req(mqrq);
> @@ -1540,10 +1543,13 @@ static void mmc_blk_cqe_complete_rq(struct mmc_queue *mq, struct request *req)
>                 err = 0;
>
>         if (err) {
> -               if (mqrq->retries++ < MMC_CQE_RETRIES)
> +               if (mqrq->retries++ < MMC_CQE_RETRIES) {
> +                       if (rq_data_dir(req) == WRITE)
> +                               req->rq_flags |= RQF_XFER_SINGLE_BLK;
>                         blk_mq_requeue_request(req, true);
> -               else
> +               } else {
>                         blk_mq_end_request(req, BLK_STS_IOERR);
> +               }
>         } else if (mrq->data) {
>                 if (blk_update_request(req, BLK_STS_OK, mrq->data->bytes_xfered))
>                         blk_mq_requeue_request(req, true);
> @@ -2085,6 +2091,8 @@ static void mmc_blk_mq_complete_rq(struct mmc_queue *mq, struct request *req)
>         } else if (!blk_rq_bytes(req)) {
>                 __blk_mq_end_request(req, BLK_STS_IOERR);
>         } else if (mqrq->retries++ < MMC_MAX_RETRIES) {
> +               if (rq_data_dir(req) == WRITE)
> +                       req->rq_flags |= RQF_XFER_SINGLE_BLK;
>                 blk_mq_requeue_request(req, true);
>         } else {
>                 if (mmc_card_removed(mq->card))
> diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
> index 18a2388ba581..06b6e1c4fca3 100644
> --- a/include/linux/blk-mq.h
> +++ b/include/linux/blk-mq.h
> @@ -64,6 +64,7 @@ enum rqf_flags {
>         /* ->timeout has been called, don't expire again */
>         __RQF_TIMED_OUT,
>         __RQF_RESV,
> +       __RQF_XFER_SINGLE_BLK,
>         __RQF_BITS
>  };
>
> @@ -85,6 +86,8 @@ enum rqf_flags {
>                         ((__force req_flags_t)(1 << __RQF_ZONE_WRITE_PLUGGING))
>  #define RQF_TIMED_OUT          ((__force req_flags_t)(1 << __RQF_TIMED_OUT))
>  #define RQF_RESV               ((__force req_flags_t)(1 << __RQF_RESV))
> +#define RQF_XFER_SINGLE_BLK    \
> +                       ((__force req_flags_t)(1 << __RQF_XFER_SINGLE_BLK))
>
>  /* flags that prevent us from merging requests: */
>  #define RQF_NOMERGE_FLAGS \
> --
> 2.34.1
>

Kind regards
Uffe
