Return-Path: <linux-block-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([23.128.96.9]:57632 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbeJIBXn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Oct 2018 21:23:43 -0400
Date: Mon, 08 Oct 2018 11:10:46 -0700 (PDT)
Message-Id: <20181008.111046.1103300226053324861.davem@davemloft.net>
To: keescook@chromium.org
Cc: axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH sparc-next] sunvdc: Remove VLA usage
From: David Miller <davem@davemloft.net>
In-Reply-To: <20181008154651.GA36881@beast>
References: <20181008154651.GA36881@beast>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Kees Cook <keescook@chromium.org>
Date: Mon, 8 Oct 2018 08:46:51 -0700

> In the quest to remove all stack VLA usage from the kernel[1], this moves
> the math for cookies calculation into macros and allocates a fixed size
> array for the maximum number of cookies and adds a runtime sanity check.
> (Note that the size was always fixed, but just hidden from the compiler.)
> 
> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
> 
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: linux-block@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Applied.
