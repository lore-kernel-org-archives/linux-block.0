Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67B2CC433DB
	for <linux-block@archiver.kernel.org>; Thu,  7 Jan 2021 18:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 167AB207C8
	for <linux-block@archiver.kernel.org>; Thu,  7 Jan 2021 18:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729082AbhAGSVw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Jan 2021 13:21:52 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49937 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbhAGSVw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Jan 2021 13:21:52 -0500
Received: from mail-wr1-f71.google.com ([209.85.221.71])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mauricio.oliveira@canonical.com>)
        id 1kxZuH-0007Ne-Qe
        for linux-block@vger.kernel.org; Thu, 07 Jan 2021 18:21:09 +0000
Received: by mail-wr1-f71.google.com with SMTP id o12so2963339wrq.13
        for <linux-block@vger.kernel.org>; Thu, 07 Jan 2021 10:21:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1yH8XJ+SsEmCmR1IemBhmlBy8uJA25p1sUW8hvVstic=;
        b=Lzz0hTQ9hMILZ8IBFJw2sEjZ2uKvpzwOrf2/y2kCxphg7H6X3+0cENYQEvtl7wlfmp
         zNaHf6qUpUs0xcz7PIBiDxlgg2b+Om/r33O3NKJJ9d+d04mSXnUZdXet8KKPvoVSa8Yr
         ZfB/ZBR9NCNZo4JNsj8SaNAwhtr1z1gJVHMyV/VMufITDfLB3zxNdRgLuKCM6POZeNqS
         dX7hfu+kIjSvL2KrPVcO9ZX1rcuRqlt5IoL1cAG8NnJAENAmZrglkb+OUUacreXScbI1
         /K0hzxbiVaRAZb2m/OVmPyVVpIafC6o6Flm2NlA4HkDri2chj2x8KTUeGmuP8lj8Qfcz
         sXZQ==
X-Gm-Message-State: AOAM531JiRQRS1YmYXn39uOPzl5zQI+DqwcT1HgfVJb/rimvfAEOXtAI
        jMVQ9uoq6thVPYZAT0oDL1UnrK0aU2XtWPcmCAlXadUU+hSeQTu3jFDguG8KjNw5rmygxqij1pQ
        cHNuzAXGyAtbt+nv7T1CQrK4B8SZ3WvMaOZNcJoliMh03mS/kNnO8oTt+
X-Received: by 2002:a1c:dc87:: with SMTP id t129mr9044714wmg.52.1610043669536;
        Thu, 07 Jan 2021 10:21:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz3c0mezv6YeA6BCMZ6z8n9194LaLFGX/ijTyEcry16Ek01hDA0K0VLFO5nuFasrESVg34HYsJbl4rvYNDEDHk=
X-Received: by 2002:a1c:dc87:: with SMTP id t129mr9044701wmg.52.1610043669240;
 Thu, 07 Jan 2021 10:21:09 -0800 (PST)
MIME-Version: 1.0
References: <20210105135419.68715-1-mfo@canonical.com> <20210106090758.GB3845805@T590>
 <CAO9xwp0ad6Hs2AJOLKUn-oVSp+kwHKM67saxdwv0JsrSza+C7Q@mail.gmail.com> <20210107071055.GA3900112@T590>
In-Reply-To: <20210107071055.GA3900112@T590>
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
Date:   Thu, 7 Jan 2021 15:20:58 -0300
Message-ID: <CAO9xwp2pOQSuD21ec6qR=_n-Zh=VbjWB4b=+_7FyC1Bpw4gjpw@mail.gmail.com>
Subject: Re: [PATCH v2] loop: fix I/O error on fsync() in detached loop devices
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Eric Desrochers <eric.desrochers@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jan 7, 2021 at 4:11 AM Ming Lei <ming.lei@redhat.com> wrote:
[snip]
> OK, looks it is fine to disable writeback cache in __loop_clr_fd().
>
> BTW, just wondering why don't you disable WC unconditionally in
> __loop_clr_fd() or clear it in the following way because WC can be
> changed via sysfs?
>
>         if (test_bit(QUEUE_FLAG_WC, &q->queue_flags))
>                 blk_queue_write_cache(q, false, false);
>

Nice catch. Fixed that in v3.

That was actually a bug, where a read-only loop device (losetup -r)
that had write cache enabled via sysfs while attached, would not
disable it, since it was checking only for the read-only bits, thus
still suffering from the original issue.

Thanks,

> Thanks,
> Ming
>


-- 
Mauricio Faria de Oliveira
