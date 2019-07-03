Return-Path: <SRS0=UuDU=VA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71A77C0650E
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 12:19:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B8FD218A4
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 12:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfGCMT3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jul 2019 08:19:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54689 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbfGCMT3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Jul 2019 08:19:29 -0400
Received: from mail-wr1-f69.google.com ([209.85.221.69])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1hieER-0004xu-K4
        for linux-block@vger.kernel.org; Wed, 03 Jul 2019 12:19:27 +0000
Received: by mail-wr1-f69.google.com with SMTP id g8so1016235wrw.2
        for <linux-block@vger.kernel.org>; Wed, 03 Jul 2019 05:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hl4IN+UFShyWybz5Y9nFx/v6kLwn65u0JGDKlBXalYE=;
        b=NxPl4UMAMZdctInfqq3A+4r3jYLgcQNz9irWP8weu4qTSRvC+ms5JIsgjaC6zlzHUN
         /QTKOj3DSbzTQ5vpqdB3cIpxx+xPu8JaYEPY6i3gblm0+p1CxiRJbnA+W6nxkORotBC1
         3CyG1yBuMMpTUyeDGV/7PTErugl1tgPiFKFJDWzwW51MuUBf5k3a9isjF3bqfuoejPUH
         Vj311LEx65HAXPovDnbcMW5VPyAyus1EvBdu7BL57Znfv+eU0gO2f5noaz/eopXSPAKC
         9rKFDI/Ywhe9OpT+D7caT69MY+ne38v4pXKZpal8nUD707gge+9IypfTGyUhybox8X5j
         p4DQ==
X-Gm-Message-State: APjAAAV7YPr5OxJoZctIhSwtYG7rWqLVZHvJXkp9BTeZTu4ld0k9Qq++
        s5gviRzsWRz4a9kshD9U+uN9GSVHjbpAfCtFVxFcPA/gk6sH3ZuUjjN/CMnk66kAIIC78LJwHQv
        Iryuv/AHt5Bkd6T8AqfUWvQU6JQ4VPNs3w5a5PozRYuGOXhUcAzZJRt7r
X-Received: by 2002:a1c:7304:: with SMTP id d4mr7806056wmb.39.1562156367411;
        Wed, 03 Jul 2019 05:19:27 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzWDxudz+dZ2eL2tgM1xv05DBOxBXD5d9mfD6trqmEZtBgjgFSRf5Jats2GQunAnlnOsWSWp007ri9L831lJAw=
X-Received: by 2002:a1c:7304:: with SMTP id d4mr7806046wmb.39.1562156367242;
 Wed, 03 Jul 2019 05:19:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190628221759.18274-1-gpiccoli@canonical.com> <20190703121700.GE7784@kroah.com>
In-Reply-To: <20190703121700.GE7784@kroah.com>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Wed, 3 Jul 2019 09:18:51 -0300
Message-ID: <CAHD1Q_z+V7NgL1cT3hWioWwWfpViNHDLbhpK=USbBnE=MY7X+A@mail.gmail.com>
Subject: Re: [4.19.y PATCH 1/2] block: Fix a NULL pointer dereference in generic_make_request()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
        linux-block@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Song Liu <songliubraving@fb.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Ming Lei <ming.lei@redhat.com>,
        Eric Ren <renzhengeek@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jul 3, 2019 at 9:17 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> [...]
> Both patches now queued up, thanks.

Thanks a lot Song and Greg!
Cheers,


Guilherme
