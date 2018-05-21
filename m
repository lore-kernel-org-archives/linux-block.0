Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:45188 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751050AbeEUS3G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 May 2018 14:29:06 -0400
Received: by mail-pg0-f65.google.com with SMTP id w3-v6so6704678pgv.12
        for <linux-block@vger.kernel.org>; Mon, 21 May 2018 11:29:06 -0700 (PDT)
Date: Mon, 21 May 2018 11:29:04 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Linux Block Layer Mailinglist <linux-block@vger.kernel.org>,
        Linux NVMe Mailinglist <linux-nvme@lists.infradead.org>
Subject: Re: [PATCH blktests] Documentation: document prerequisite scriptlets
Message-ID: <20180521182904.GA14774@vader>
References: <20180514114042.12082-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180514114042.12082-1-jthumshirn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, May 14, 2018 at 01:40:42PM +0200, Johannes Thumshirn wrote:
> The config file is bash and it gets sourced, so all bash magic is
> doable in there as well. Document it so others don't have to
> re-discover this gem as well.

I'm supportive of this...

> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  Documentation/running-tests.md | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/Documentation/running-tests.md b/Documentation/running-tests.md
> index a479d5e94c5e..b477c0679683 100644
> --- a/Documentation/running-tests.md
> +++ b/Documentation/running-tests.md
> @@ -66,3 +66,15 @@ command line option.
>  QUICK_RUN=1
>  TIMEOUT=30
>  ```
> +
> +### Pre-test setups
> +
> +Some tests, may need special prerequisites, like configfs being
> +mounted for NVMe over Fabrics tests. You can add your custom bash
> +scriptlets to `config` to get this done, e.g.:
> +
> +```sh
> +if ! test $(grep -q configfs /proc/mounts) ; then
> +        mount -t configfs none /sys/kernel/config
> +fi
> +```

But I'm curious about this specific example. Is this not mounted for you
automatically? I'm guessing systemd does it for me on my setup.
