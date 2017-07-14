Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f175.google.com ([209.85.192.175]:35161 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753522AbdGNRLO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jul 2017 13:11:14 -0400
Received: by mail-pf0-f175.google.com with SMTP id c73so48314806pfk.2
        for <linux-block@vger.kernel.org>; Fri, 14 Jul 2017 10:11:14 -0700 (PDT)
Date: Fri, 14 Jul 2017 10:11:10 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Jens Axboe <axboe@fb.com>,
        Linux Block Layer Mailinglist <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests v2] tests: use nproc to get number of CPUs for
 fio jobs
Message-ID: <20170714171110.GA13690@vader.DHCP.thefacebook.com>
References: <20170630090735.11709-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170630090735.11709-1-jthumshirn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jun 30, 2017 at 11:07:35AM +0200, Johannes Thumshirn wrote:
> Use nproc to get number of CPUs for fio jobs and introduce
> _run_fio_rand_io helper for parallel IO which we don't really care about
> the details and just want some IO.

Thanks, Johannes, applied with a fix below.

> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  common/fio      | 7 +++++++
>  tests/block/005 | 4 +---
>  tests/block/006 | 2 +-
>  tests/block/008 | 4 +---
>  tests/block/011 | 5 ++---
>  5 files changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/common/fio b/common/fio
> index 86ed4b2b7180..2b0759d19f5d 100644
> --- a/common/fio
> +++ b/common/fio
> @@ -166,6 +166,13 @@ _run_fio() {
>  	fio "${args[@]}" "$@"
>  }
>  
> +# Wrapper around _run_fio used if you need some I/O but don't really care much
> +# about the details
> +_run_fio_rand_io() {
> +	_run_fio --bs=4k --rw=randread --norandommap --numjobs=$(nproc) \
> +		--name=reads --direct=1

I added "$@" at the end here, it looks like that's what you intended and
it doesn't work otherwise.

> +}
> +
