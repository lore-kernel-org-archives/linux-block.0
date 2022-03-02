Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9486CC433F5
	for <linux-block@archiver.kernel.org>; Wed,  2 Mar 2022 10:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239677AbiCBKq7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Mar 2022 05:46:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbiCBKq6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Mar 2022 05:46:58 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD37B54E4
        for <linux-block@vger.kernel.org>; Wed,  2 Mar 2022 02:46:15 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id qt6so2761464ejb.11
        for <linux-block@vger.kernel.org>; Wed, 02 Mar 2022 02:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dTWbHVP694/y8JRF1U4dnDjjT3Lz4bGbKprHj3pcE9M=;
        b=eXpqzEGGVA93vhCHsrUsBrS5LACnekzMj0M39dATR9U8X0F7qOtOM/CZOOHzlMr0/e
         KDs8wd4IVzR0vds0PkdsfroW5uPOGsAqSQhOn++mJPfQSSKU0NNAoADXYkK5Wd0twQ8B
         H2DslTcoFjgsL7cQx5BRsNIXQ3NSaulgZF3MG4CIkOm5Olmhk4UMoi5yiPBcNu4uqfWI
         0ogiSXytpoU06uEwaIwAY6AqhoGuhp+PZZvgx4Yi3XK8awXMHs749IZUK1+e0ZsoZDhR
         5o8ZYNOMEYCS4TzUw2bWweljVV1txSPi6G67WhEGENDrCvEIlY8skK1wWXk+135LR6+q
         RloQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dTWbHVP694/y8JRF1U4dnDjjT3Lz4bGbKprHj3pcE9M=;
        b=oGCsl5hWo0a2K11IirgntQMj46ABirGYP4IdjQPK0rOxKDF0jCMV3I49P9VrqbIleT
         p5QuzvBvFL9a6TB41/HkO01uszSSLmG7DIx4mYRGVBWL5YDB3kzZrm6HVAGQuDaDumqm
         N4q7vLkZdznS0sPvmmkgWcncuASCKG/QpgI4IklQQPp5DRIILZ4F4XoY4VJ/Eo7ugvga
         XtQhwylOxq6I/wUyV5kexlRkytcSQh11Dmepyec/6QtBGENmk70JNf8vFwfoi8VV+Bd5
         oP9IysIaJk42zZBsAvHHERJe/g4G0rR2dEWJu4kmK4c+a+niKMqPOZKLBF2Wxf4yu23s
         GuWw==
X-Gm-Message-State: AOAM532ClThgCW11FQogJXwDbm2qBzbMdTi5q5zvGYw/rxZD4Oh3b0ht
        kkEBMafBUmAerPJIJFdUdpTkMqU6kUfLaIOqDiLU
X-Google-Smtp-Source: ABdhPJy+OIdiSSoVcciyXhDi5uiVzbX+Oo5S7yF/lDRAZdb2JqwiFwjXej42BMAn3XwJOC3/Fs4yUT0eqwcHND7FOHg=
X-Received: by 2002:a17:906:56cd:b0:6d6:e276:f455 with SMTP id
 an13-20020a17090656cd00b006d6e276f455mr6680402ejc.257.1646217974246; Wed, 02
 Mar 2022 02:46:14 -0800 (PST)
MIME-Version: 1.0
References: <20220228065720.100-1-xieyongji@bytedance.com> <20220301104039-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220301104039-mutt-send-email-mst@kernel.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Wed, 2 Mar 2022 18:46:03 +0800
Message-ID: <CACycT3uGFUjmuESUi9=Kkeg4FboVifAHD0D0gPTkEprcTP=x+g@mail.gmail.com>
Subject: Re: [PATCH v2] virtio-blk: Remove BUG_ON() in virtio_queue_rq()
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 1, 2022 at 11:43 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Feb 28, 2022 at 02:57:20PM +0800, Xie Yongji wrote:
> > Currently we have a BUG_ON() to make sure the number of sg
> > list does not exceed queue_max_segments() in virtio_queue_rq().
> > However, the block layer uses queue_max_discard_segments()
> > instead of queue_max_segments() to limit the sg list for
> > discard requests. So the BUG_ON() might be triggered if
> > virtio-blk device reports a larger value for max discard
> > segment than queue_max_segments().
>
> Hmm the spec does not say what should happen if max_discard_seg
> exceeds seg_max. Is this the config you have in mind? how do you
> create it?
>

One example: the device doesn't specify the value of max_discard_seg
in the config space, then the virtio-blk driver will use
MAX_DISCARD_SEGMENTS (256) by default. Then we're able to trigger the
BUG_ON() if the seg_max is less than 256.

While the spec didn't say what should happen if max_discard_seg
exceeds seg_max, it also doesn't explicitly prohibit this
configuration. So I think we should at least not panic the kernel in
this case.

Thanks,
Yongji
