Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B425FC7EE25
	for <linux-block@archiver.kernel.org>; Sat, 10 Jun 2023 00:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjFJAXz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 9 Jun 2023 20:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjFJAXz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 9 Jun 2023 20:23:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C471A3A81
        for <linux-block@vger.kernel.org>; Fri,  9 Jun 2023 17:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686356593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bsQWyXs3Wi1lrZUD+4VBakidjsUgNo6KG4s1PH+Z7sA=;
        b=C1OMuM9R/RiIFb3WgRj2abK4gWSqdTtVHj0Dn42EHrHo0lmoV077PA03WkndemyXxKCHQ7
        FRJrkMRlBbsAuGcIqDl7ymn3iwqktvSh0UubD3loaZIZlQiJwUTMrNJuifqN7QAaNIMv6G
        IfMrweF5wcjg5c5VW1Ye/G7zb9nD3H4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-64PHJ2Y8NmKmkYBr5xvh8A-1; Fri, 09 Jun 2023 20:23:09 -0400
X-MC-Unique: 64PHJ2Y8NmKmkYBr5xvh8A-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2b1a7e31de7so17666241fa.1
        for <linux-block@vger.kernel.org>; Fri, 09 Jun 2023 17:23:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686356588; x=1688948588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bsQWyXs3Wi1lrZUD+4VBakidjsUgNo6KG4s1PH+Z7sA=;
        b=BUW/2dt1nz+8vYpXQFUZR3bAs2GQmmxREfTayAaCiBxIEGfP/wETQSosNiwRN81Yy7
         dCMo2Jt0fZNISXeXqCETMuYA6+dqiaaMXTzsc8tXt5YY0U/a6/OQXBgNl0RZYb0HQxpf
         nFyFn68zoOBtbbieqXR8K4nphFbZNJ7xmqXZZTC8ZilRNeIC8UohNnATdhrWtdTEwSU0
         Gf8h0Un1Io1e2T63e6rSGSwCire4T66Mt5IBj0pjss6pLcbzC1oZUFnabttvIbRMdzo4
         ePxWV5t0mkdLrkzeR+1iXdAhmcg9skAgl4Kv0dU7JkSnRNNLfbHe23wPT0U7Rb5RVeW4
         wiWQ==
X-Gm-Message-State: AC+VfDxXh8QcznAFpF1DiZdeDZDmtr46QZ470Jqze/UmSpDQKBzh0g2g
        RRp8x308Asux4t7RobDDFx4kDVsTwMeR3q8acVtH8lzuhFQs2kOGR5UmbaBrnDeDspf2eirO2Du
        oVCuTXHaRyg1SW72Rn+pBAlbmXnPeqTi4fBkUuxw=
X-Received: by 2002:a2e:9c97:0:b0:2b2:a174:c9f9 with SMTP id x23-20020a2e9c97000000b002b2a174c9f9mr99051lji.37.1686356588088;
        Fri, 09 Jun 2023 17:23:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6CgfNRbFyZRr2JEpFuiWGY2Gqn+v0iwO7DBONp5N+dihzUr4eidMfArrQ36mDZnO+btif76a4JgjxTZ8NE0zU=
X-Received: by 2002:a2e:9c97:0:b0:2b2:a174:c9f9 with SMTP id
 x23-20020a2e9c97000000b002b2a174c9f9mr99046lji.37.1686356587784; Fri, 09 Jun
 2023 17:23:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230609180805.736872-1-jpittman@redhat.com> <yq1legs1nns.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq1legs1nns.fsf@ca-mkp.ca.oracle.com>
From:   John Pittman <jpittman@redhat.com>
Date:   Fri, 9 Jun 2023 20:22:31 -0400
Message-ID: <CA+RJvhzPfmjD0FZxWS5gFeZJWKki5OcdmywZdngqhgSjm6wiFA@mail.gmail.com>
Subject: Re: [PATCH] block: set reasonable default for discard max
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     axboe@kernel.dk, djeffery@redhat.com, loberman@redhat.com,
        emilne@redhat.com, minlei@redhat.com, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Thanks alot for responding Martin.  Forgive my ignorance; just trying
to gain understanding.  For example, if we find a device with a 2TiB
max discard (way too high for any device to handle reasonably from
what I've seen), and we make a quirk for it that brings the max
discard down, how do we decide what value to bring that down to?
Would we ask the hardware vendor for an optimal value?  Is there some
way we could decide the value?  Thanks again for any help.

On Fri, Jun 9, 2023 at 2:48=E2=80=AFPM Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> John,
>
> > Some drive manufacturers export a very large supported max discard
> > size. However, when the operating system sends I/O of the max size to
> > the device, extreme I/O latency can often be encountered. Since
> > hardware does not provide an optimal discard value in addition to the
> > max, and there is no way to foreshadow how well a drive handles the
> > large size, take the method from max_sectors setting, and use
> > BLK_DEF_MAX_SECTORS to set a more reasonable default discard max. This
> > should avoid the extreme latency while still allowing the user to
> > increase the value for specific needs.
>
> What's reasonable for one device may be completely unreasonable for
> another. 4 * BLK_DEF_MAX_SECTORS is *tiny* and will penalize performance
> on many devices.
>
> If there's a problem with a device returning something that doesn't make
> sense, let's quirk it.
>
> --
> Martin K. Petersen      Oracle Linux Engineering
>

