Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36014 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752363AbeFYWyt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jun 2018 18:54:49 -0400
Received: by mail-pf0-f193.google.com with SMTP id u16-v6so3359995pfh.3
        for <linux-block@vger.kernel.org>; Mon, 25 Jun 2018 15:54:48 -0700 (PDT)
Date: Mon, 25 Jun 2018 15:54:47 -0700
From: Omar Sandoval <osandov@osandov.com>
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org
Subject: Re: [PATCH blktests 13/15] src/Makefile: Fix pattern rule
Message-ID: <20180625225447.GD1218@vader>
References: <20180622221946.10987-1-bart.vanassche@wdc.com>
 <20180622221946.10987-14-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180622221946.10987-14-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Jun 22, 2018 at 03:19:44PM -0700, Bart Van Assche wrote:
> According to the GNU make documentation, the syntax for pattern rules
> is as follows:
> 
> <target pattern>+: <source pattern>
> 	<rule>

That's because this is a static pattern rule:

https://www.gnu.org/software/make/manual/html_node/Static-Usage.html

So calling this a fix isn't accurate :) I'll fold this change into the
change adding the C++ program.

> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
> ---
>  src/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/Makefile b/src/Makefile
> index 612282d14af8..d7ae832fc4fd 100644
> --- a/src/Makefile
> +++ b/src/Makefile
> @@ -13,7 +13,7 @@ all: $(TARGETS)
>  clean:
>  	rm -f $(TARGETS)
>  
> -$(TARGETS): %: %.c
> +%: %.c
>  	$(CC) -Wall -o $@ $(CPPFLAGS) $(CFLAGS) $^
>  
>  .PHONY: all clean
> -- 
> 2.17.1
> 
