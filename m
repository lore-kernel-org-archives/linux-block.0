Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f49.google.com ([74.125.83.49]:36040 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751819AbdFZUTs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Jun 2017 16:19:48 -0400
Received: by mail-pg0-f49.google.com with SMTP id u62so5093629pgb.3
        for <linux-block@vger.kernel.org>; Mon, 26 Jun 2017 13:19:47 -0700 (PDT)
Date: Mon, 26 Jun 2017 13:19:46 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Linux Block Layer Mailinglist <linux-block@vger.kernel.org>
Subject: Re: [PATCH blktests] sg/001: don't require scsi_debug
Message-ID: <20170626201946.GC6710@vader.dhcp.thefacebook.com>
References: <20170623081448.8121-1-jthumshirn@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170623081448.8121-1-jthumshirn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jun 23, 2017 at 10:14:48AM +0200, Johannes Thumshirn wrote:
> Don't require scsi_debug but check if TEST_DEV is a SCSI device and use it
> instead.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
> ---
>  tests/sg/001 | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/sg/001 b/tests/sg/001
> index a4cfabe25ba0..fc883ebd1c8a 100755
> --- a/tests/sg/001
> +++ b/tests/sg/001
> @@ -24,13 +24,13 @@ DESCRIPTION="try triggering a kernel GPF with 0 byte SG reads"
>  QUICK=1
>  
>  requires() {
> -	_have_src_program sg/syzkaller1 && _have_scsi_debug
> +	_have_src_program sg/syzkaller1
>  }
>  
> -test() {
> +test_device() {
>  	echo "Running ${TEST_NAME}"
>  
> -	if ! _get_scsi_debug_dev; then
> +	if ! _test_dev_is_scsi; then
>  		return 1
>  	fi

Since we already check this in tests/sg/group, we don't need this bit.
Got rid of it and applied, thanks, Johannes!

> @@ -38,7 +38,5 @@ test() {
>  	cd "$TMPDIR" || return 1
>  	timeout -s INT 10s "$SRCDIR/sg/syzkaller1" "$SG_DEV"
>  
> -	_put_scsi_debug_dev
> -
>  	echo "Test complete"
>  }
> -- 
> 2.12.3
> 
