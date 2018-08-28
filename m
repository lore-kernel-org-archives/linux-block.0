Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39656 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbeH1V7T (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Aug 2018 17:59:19 -0400
Received: by mail-pf1-f193.google.com with SMTP id j8-v6so1063215pff.6
        for <linux-block@vger.kernel.org>; Tue, 28 Aug 2018 11:06:30 -0700 (PDT)
Date: Tue, 28 Aug 2018 11:06:28 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Yi Zhang <yi.zhang@redhat.com>
Cc: gi-oh.kim@profitbricks.com, osandov@fb.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] blktests: remove unused null_blk parameter for
 _init_null_blk in block/016
Message-ID: <20180828180628.GB18173@vader>
References: <20180825100619.17868-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180825100619.17868-1-yi.zhang@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Aug 25, 2018 at 06:06:19PM +0800, Yi Zhang wrote:
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> ---
>  tests/block/016 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/block/016 b/tests/block/016
> index 0e6f2e1..e0a63ad 100755
> --- a/tests/block/016
> +++ b/tests/block/016
> @@ -32,7 +32,7 @@ requires() {
>  test() {
>  	echo "Running ${TEST_NAME}"
>  
> -	if ! _init_null_blk null_blk queue_mode=2 irqmode=2 completion_nsec=2000000000; then
> +	if ! _init_null_blk queue_mode=2 irqmode=2 completion_nsec=2000000000; then
>  		return 1
>  	fi

Applied, thanks!
