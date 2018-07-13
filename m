Return-Path: <asmadeus@notk.org>
Date: Fri, 13 Jul 2018 17:31:19 +0200
From: Dominique Martinet <asmadeus@codewreck.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: "Ed L. Cashin" <ed.cashin@acm.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH 02/18] block/aoenet: change strncpy+truncation to strlcpy
Message-ID: <20180713153119.GC14190@nautica>
References: <1531444483-17338-1-git-send-email-asmadeus@codewreck.org>
 <1531445105-18941-1-git-send-email-asmadeus@codewreck.org>
 <41bf49e3-70a5-4362-7389-55752ebc6c02@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <41bf49e3-70a5-4362-7389-55752ebc6c02@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

Jens Axboe wrote on Fri, Jul 13, 2018:
> This is a weird combination in terms of a single patch, why is
> it patching aoe and gpiolib in one patch?

I must have failed some git add command, I didn't realize they were
together until you pointed it out just now.

This has been discussed more lengthly on the netdev side but the whole
patch serie has been (quite) a bit too hasty; on one side I've been
given some interesting feedback that I would not have gotten just
sending the coccinelle patch first but I really should have waited for
that to land first and most importantly spend more time on each
individual patch, this was rude of me.

I will make sure they are split in a v2, and send them individually
(well, per big component) as self-explaining patches rather than as a
block, once the coccinelle patch has been accepted. 


Thank you for the review,
-- 
Dominique Martinet
