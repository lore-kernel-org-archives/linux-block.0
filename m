Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDAA4C7EE29
	for <linux-block@archiver.kernel.org>; Tue, 13 Jun 2023 11:25:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239702AbjFMLZG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 13 Jun 2023 07:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242273AbjFMLYw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 13 Jun 2023 07:24:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499FB1711
        for <linux-block@vger.kernel.org>; Tue, 13 Jun 2023 04:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686655414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sPBk+yWrNJZvZrgDRYA0KMEl3CZftju4owuDc7vUT0A=;
        b=V8tt8CnWO3uwqBVGBVbCjjkdU+cWeaPLhuyxaTeEP9uuTIgXYa8axpFKzWdkp8Q3fn4lFb
        fSCbtYzDFr8shlsf5j48StSto9jMpeCZl1H9MUVjNtawLK0lx+ToUjFVRib+xKIxeZqC8R
        JsYeDik/YBgdzOeWGh3/9hdjRG9+j8k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-0U6UiUElPCO3PcqRyYZnOA-1; Tue, 13 Jun 2023 07:23:33 -0400
X-MC-Unique: 0U6UiUElPCO3PcqRyYZnOA-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-30fcc3125acso353228f8f.2
        for <linux-block@vger.kernel.org>; Tue, 13 Jun 2023 04:23:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686655412; x=1689247412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPBk+yWrNJZvZrgDRYA0KMEl3CZftju4owuDc7vUT0A=;
        b=fh8jy4oq9ngCF+6qXEoVgtVAzGpN+gx1ZBmqDCQhEnhdizHxuethFL0OP+aaXgGKGp
         sjs+N4X5FgqxUH69MX+adFwMsqSmvw3dp/jSGFK+mGbNA1nZ7ykTXur0N0xApJab/0qG
         QxyNfqPSBCkeIQz8heEMJN10GP6PwNbLz3P/ZnG+uGEJP8ivHAR3GMeQAC2n5VCA4jpT
         anZJhju4U3Kbicc9LevaSv/qYvTzbBCRgZn6iWpjtpOoa59B3IUyDkF2tV9ybbM9508m
         tOQ29pZ6e2rfObL+hM3xPZVLmsmP8NsNYugNv+sqFsJ0h9WKAqxyBx73VR7hE4oioJFv
         4ciw==
X-Gm-Message-State: AC+VfDzuck1G0xDDNsrdNXg/gsx0kp6/ztC/VczMka4MEfzp9DCiKNaN
        NLikOCmbEEWH5TE2Kai4kxQ+n4dfZyjMVnom/saA1TkNsZ/HBde4kR6Htp5h7/UOLHzy9apKh/e
        EIGkyGlujUFo04Rry7176cny6Hwzr7uPtJ0wF+Fs=
X-Received: by 2002:a5d:5185:0:b0:30f:cd69:dd42 with SMTP id k5-20020a5d5185000000b0030fcd69dd42mr1232812wrv.29.1686655412453;
        Tue, 13 Jun 2023 04:23:32 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6lDN10DT0aOMA4Q9ESTrPOH+9Ahu84Ybee5qYeXovctNO7Mzdbkk03pyx29G8vnpkVRmL2IxM+pwArnHbvz84=
X-Received: by 2002:a5d:5185:0:b0:30f:cd69:dd42 with SMTP id
 k5-20020a5d5185000000b0030fcd69dd42mr1232799wrv.29.1686655412225; Tue, 13 Jun
 2023 04:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230609180805.736872-1-jpittman@redhat.com> <yq1legs1nns.fsf@ca-mkp.ca.oracle.com>
 <CA+RJvhzPfmjD0FZxWS5gFeZJWKki5OcdmywZdngqhgSjm6wiFA@mail.gmail.com> <yq14jnc18y0.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq14jnc18y0.fsf@ca-mkp.ca.oracle.com>
From:   Ewan Milne <emilne@redhat.com>
Date:   Tue, 13 Jun 2023 07:23:21 -0400
Message-ID: <CAGtn9rmYE6eNn7+UVLsN-8DLppv5_Wu1Te-tF59nJ3t5ot9Fnw@mail.gmail.com>
Subject: Re: [PATCH] block: set reasonable default for discard max
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     John Pittman <jpittman@redhat.com>, axboe@kernel.dk,
        djeffery@redhat.com, loberman@redhat.com, minlei@redhat.com,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

FWIW the most recent discard performance issue I looked at was
an early SSD that only supported a small max discard size.  Doing
a discard of the whole device (mkfs) took several minutes with
lots of little discards.  So it isn't always just an issue of the max size.

-Ewan

On Mon, Jun 12, 2023 at 10:00=E2=80=AFPM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> John,
>
> > Thanks alot for responding Martin.  Forgive my ignorance; just trying
> > to gain understanding.  For example, if we find a device with a 2TiB
> > max discard (way too high for any device to handle reasonably from
> > what I've seen),
>
> That really depends. On some devices performing a 2TB discard may just
> involve updating a few entries in a block translation table. It could be
> close to constant time regardless of the number of terabytes unmapped.
>
> > and we make a quirk for it that brings the max discard down, how do we
> > decide what value to bring that down to? Would we ask the hardware
> > vendor for an optimal value? Is there some way we could decide the
> > value?
>
> The best thing would be to ask the vendor. Or maybe if you provide the
> output of
>
> # sg_vpd -p bl /dev/sdN
>
> and we can try to see if we can come up with a suitable heuristic for a
> quirk.
>
> --
> Martin K. Petersen      Oracle Linux Engineering
>

