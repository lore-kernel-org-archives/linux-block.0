Return-Path: <SRS0=jUAw=TV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD5FFC04AAF
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 14:10:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80C2217D7
	for <linux-block@archiver.kernel.org>; Tue, 21 May 2019 14:10:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728342AbfEUOKp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 21 May 2019 10:10:45 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43613 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbfEUOKp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 21 May 2019 10:10:45 -0400
Received: from mail-wm1-f72.google.com ([209.85.128.72])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <guilherme.piccoli@canonical.com>)
        id 1hT5TX-0000qE-Vb
        for linux-block@vger.kernel.org; Tue, 21 May 2019 14:10:44 +0000
Received: by mail-wm1-f72.google.com with SMTP id 9so824793wmi.7
        for <linux-block@vger.kernel.org>; Tue, 21 May 2019 07:10:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3og88PFnyLDuGAX9qCeRLfhcIKeYUgXunXJTzgjv6aI=;
        b=MLii7cEgZs/1zAsIYrYYWhQ1aIt0b1iiANWawb+lo1dSsOMMynB8YtqyWQbLjb4SXe
         xugnOg1+iTwl8biV0WQ35wF6NZMGopfTZvbnBSI3N60Duk1aIW+gTMW+g1V8wzSbAWrI
         y22t5W+Lyj0PGtDsNMBls9MAUpDTsaBAxbyZs+8Phb33M9lkrycG0i25vaWscbqpTBHd
         hDbzTMkU/zeNfZ8mnC2O7waYGcuDsQ0kNPvW7UV41QQkwt95mPZmh+nPNwfrxo0h9esL
         5Y0NeHn0ZcXRjIAcVizY+44TF0n85UgQfXdIqtZjD7aCDBlXC4zgHz9xxchSdtam08YB
         jERA==
X-Gm-Message-State: APjAAAV/fIaQElgQTMYUJl7fqxUlQ14mw2dVxWbjGorXPMNMhrTy4zBI
        D2aG4h2de5lemV+rwIDyMfkdfj9MBe6aus9D4nC9Ku5xnKb2ieVYg9T8UpeO91YcmBtF+uMtUX/
        MRrrkcVtkK1TY2DEM8B1tze/Dpjulo79mhN9nSmYG9Cc3cCUdugwQqVc9
X-Received: by 2002:a7b:cd0e:: with SMTP id f14mr3465094wmj.127.1558447843747;
        Tue, 21 May 2019 07:10:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw8DBZ1IFI4I+4dRGP+NgpwHHDVqa+fRTuAL80nwVbzVmjyDmk52vwMf9qjuQHgGxBE3XVoFFNu9M/75ptmK9U=
X-Received: by 2002:a7b:cd0e:: with SMTP id f14mr3465016wmj.127.1558447842648;
 Tue, 21 May 2019 07:10:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190520220911.25192-1-gpiccoli@canonical.com>
 <20190520220911.25192-2-gpiccoli@canonical.com> <20190521125634.GB16799@infradead.org>
In-Reply-To: <20190521125634.GB16799@infradead.org>
From:   Guilherme Piccoli <gpiccoli@canonical.com>
Date:   Tue, 21 May 2019 11:10:05 -0300
Message-ID: <CAHD1Q_z23AO+NRid1xYTeke_5GAe6hPianEZKBf5P30FrfZGFg@mail.gmail.com>
Subject: Re: [PATCH V2 2/2] md/raid0: Do not bypass blocking queue entered for
 raid0 bios
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org,
        linux-raid <linux-raid@vger.kernel.org>, dm-devel@redhat.com,
        axboe@kernel.dk, Gavin Guo <gavin.guo@canonical.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        "Guilherme G. Piccoli" <kernel@gpiccoli.net>,
        Ming Lei <ming.lei@redhat.com>,
        Song Liu <liu.song.a23@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, May 21, 2019 at 9:56 AM Christoph Hellwig <hch@infradead.org> wrote:
> > [1] https://lore.kernel.org/linux-block/20190515030310.20393-4-ming.lei@redhat.com/
>
> Actually - that series should also fix you problem and avoid the need
> for both patches in this series.  Can you please test it?

Hi Christoph, thanks for looking into this.
You're right, this series fixes both issues. The problem I see though
is that it relies
on legacy IO path removal - for v5.0 and beyond, all fine. But
backporting that to
v4.17-v4.20 stable series will be quite painful.

My fixes are mostly "oneliners". If we could get both approaches upstream,
that'd be perfect!
Cheers,


Guilherme
