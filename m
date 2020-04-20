Return-Path: <SRS0=3ryC=6E=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25000C3815B
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 07:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 005FF2078E
	for <linux-block@archiver.kernel.org>; Mon, 20 Apr 2020 07:00:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="MgGtdqwv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgDTHAr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Apr 2020 03:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726006AbgDTHAr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Apr 2020 03:00:47 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D12C061A0F
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2020 00:00:47 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id r2so2063024ilo.6
        for <linux-block@vger.kernel.org>; Mon, 20 Apr 2020 00:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FXlpspJEbDHoQKzTWZ7OoJ0DmgN59WGOBFVzZ9ECAqQ=;
        b=MgGtdqwvkxDCWV/ys6L9qG4ozrCBAixZ6iysWCPYpc/7PZKSM43UYUnXg8tVZVxZll
         Xfde+dd8EVxYj8DBhtERhrbDBVu2ZKs4wMpj/imwAxmcZkrEuAEsFf6ZDl4EbGd1ICJZ
         n0HeyCNKixRjOGN/dGYyVLUhsmD8iB0bJIQfNQvJQtZdWZHvel9Vf9dcQ+tmlz04pEZl
         S0q3YxBkqFOqwMPcUabyzqcoZlys9Qof4QqYbV5O340sHLAsZx+/toOXDO9dzmGSrEpl
         /MnoP5VMxTmJhF97M+Trvz36pc9iP5ls3Lm6RR7nKKFQW3yjnzrakoz8kCdQ9zssp+OY
         SeHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FXlpspJEbDHoQKzTWZ7OoJ0DmgN59WGOBFVzZ9ECAqQ=;
        b=mZbe1w5P2ajEsIe/W98BmThAilka4P2T7hv6juBq9Ln7JgN3R0RMh2dH/O4aao6yOW
         oVoNPxvnudkz7qSAO/pMWxrmb674KEWQCFjL7bNpS4CXccsFhLwOngGbEQvae8GWZXOh
         NDe+Xkiwc8UcyQtBHP0aJPjKOGk6d3p75WFkxEKG6l2gggYkfTfa4vUCkrLE1lPX4qOw
         P9vP0lCYXLyucJ2PFdIk8AeASG8nKI6m8uhLKWYjZbJkCHDKDE+YySi7LRq/uTbyNTVH
         9XQncnJO6UAc+qCYxlvOxnG1dOqJFlEuXJB0LKTw9ZYoL69zUC3AH7N3ZYUaS93T8k3i
         1R+A==
X-Gm-Message-State: AGi0PuZqCVnMZQvBpggfomrWYwP5DxjX2TfzrjEXvfhoJXk2HwvgWxl8
        5YobCiCmIJkR2BkJ9829+U+hEWNHOvzZKojlXtznkQ==
X-Google-Smtp-Source: APiQypKVKmZRHiGPVWXVvY9+klgoFYg/ZzKF0xk1aCtXv/786RkD707yD8EhFnvTqR/eKHRQnf43BmUs5pj0hn8e1tg=
X-Received: by 2002:a92:ba01:: with SMTP id o1mr13961843ili.217.1587366046506;
 Mon, 20 Apr 2020 00:00:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200415092045.4729-1-danil.kipnis@cloud.ionos.com>
 <20200415092045.4729-23-danil.kipnis@cloud.ionos.com> <0b161f96-c6de-ff6a-e71c-b0e2e623105a@acm.org>
In-Reply-To: <0b161f96-c6de-ff6a-e71c-b0e2e623105a@acm.org>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Mon, 20 Apr 2020 09:00:38 +0200
Message-ID: <CAMGffEm+O8tOTDuZX++T1mDOJA4GuoT9xZMNH83JTNfJk4uPBg@mail.gmail.com>
Subject: Re: [PATCH v12 22/25] block/rnbd: server: sysfs interface functions
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Danil Kipnis <danil.kipnis@cloud.ionos.com>,
        linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Apr 19, 2020 at 1:39 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 4/15/20 2:20 AM, Danil Kipnis wrote:
> > This is the sysfs interface to rnbd mapped devices on server side:
> >
> >    /sys/class/rnbd-server/ctl/devices/<device_name>/
> >      |- block_dev
> >      |  *** link pointing to the corresponding block device sysfs entry
> >      |
> >      |- sessions/<session-name>/
> >      |  *** sessions directory
> >         |
> >         |- read_only
> >         |  *** is devices mapped as read only
> >         |
> >         |- mapping_path
> >            *** relative device path provided by the client during mapping
>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Thanks Bart!
