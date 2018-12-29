Return-Path: <SRS0=+PfW=PG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FFAC43387
	for <linux-block@archiver.kernel.org>; Sat, 29 Dec 2018 04:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B0C218FD
	for <linux-block@archiver.kernel.org>; Sat, 29 Dec 2018 04:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725926AbeL2ENn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Dec 2018 23:13:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:53394 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbeL2ENn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Dec 2018 23:13:43 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BAA8EACA9;
        Sat, 29 Dec 2018 03:57:27 +0000 (UTC)
Subject: Re: [PATCH v5 1/2] lib: add crc64 calculation routines
To:     NeilBrown <neil@brown.name>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-bcache@vger.kernel.org,
        linux-block@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Eric Biggers <ebiggers3@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20180726053352.2781-1-colyli@suse.de>
 <20180726053352.2781-2-colyli@suse.de>
 <20180726130210.97450a74c164a02d7cfd79c1@linux-foundation.org>
 <87y3899gzi.fsf@notabene.neil.brown.name>
From:   Coly Li <colyli@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=colyli@suse.de; prefer-encrypt=mutual; keydata=
 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
Message-ID: <5084b641-0a9e-aeb3-4956-247b45eeffd2@suse.de>
Date:   Sat, 29 Dec 2018 11:57:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <87y3899gzi.fsf@notabene.neil.brown.name>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 12/29/18 10:58 上午, NeilBrown wrote:
> On Thu, Jul 26 2018, Andrew Morton wrote:
> 
>> On Thu, 26 Jul 2018 13:33:51 +0800 Coly Li <colyli@suse.de>
>> wrote:
>> 
>>> This patch adds the re-write crc64 calculation routines for
>>> Linux kernel. The CRC64 polynomial arithmetic follows ECMA-182
>>> specification, inspired by CRC paper of Dr. Ross N. Williams 
>>> (see http://www.ross.net/crc/download/crc_v3.txt) and other
>>> public domain implementations.
> 
> Hi Coly and Andrew,
> 
> This patch breaks compilation if linux headers files are not
> installed (reported at
> https://github.com/gnubee-git/GnuBee_Docs/issues/75). Following
> fixes it.
> 
> Thanks, NeilBrown
> 

Hi Neil,

Thanks for the fix. I add by Acked-by.

Coly Li


> From: NeilBrown <neil@brown.name> Subject: [PATCH] lib: don't
> depend on linux headers being installed.
> 
> gen_crc64table requires linux include files to be installed in
> /usr/include/linux.  This is a new requrement so hosts that could
> previously build the kernel, now cannot.
> 
> gen_crc64table makes this requirement by including <linux/swab.h>, 
> but nothing from that header is actaully used.
> 
> So remove the #include, so that the linux headers no longer need to
> be installed.
> 
> Fixes: feba04fd2cf8 ("lib: add crc64 calculation routines") 
> Signed-off-by: NeilBrown <neil@brown.name>

Acked-by: Coly Li <colyli@suse.de>

> --- lib/gen_crc64table.c | 2 -- 1 file changed, 2 deletions(-)
> 
> diff --git a/lib/gen_crc64table.c b/lib/gen_crc64table.c index
> 9011926e4162..094b43aef8db 100644 --- a/lib/gen_crc64table.c +++
> b/lib/gen_crc64table.c @@ -16,8 +16,6 @@ #include <inttypes.h> 
> #include <stdio.h>
> 
> -#include <linux/swab.h> - #define CRC64_ECMA182_POLY
> 0x42F0E1EBA9EA3693ULL
> 
> static uint64_t crc64_table[256] = {0};
> 

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEE6j5FL/T5SGCN6PrQxzkHk2t9+PwFAlwm8JsACgkQxzkHk2t9
+PxELA//U8FohU56Xty9Yfe/5IX0WXHzpLk8efz34xNodo1bavy9yIlpzG8l9cX5
c2vaM4hYvc2rrYokgkxHcANSpFkRzD9TjkwNbij7wd37lEJYzPWr0Qk1Ttuojs7b
iJYLis0pbu6WTeUpM4NwdkKzylqWXg0dRrf3tNpF5ttN+LZOSEzbIiP8P2rnQUmD
a9WCM6Ka/E9dP5H2CIvR6gAJL/BwsVyFgd6PiYy8ElMVYBpIu2uG34eO0tx6ebSE
TPxWrSXY92jWCggJUBNr5zDXyBQADBQfy0YIv36zsplcolF/4mN4LWF2WCC4jp0c
XLBrvSslzombjxq3h+zE4GNXsDNiKtaNQy1N30b1+N3ilXa4uav1wVvaBQBMwf4I
QQDM8ZZ2alS5zAyzgtnbIr0AhlNEya+GO+42+rY0yrWG2Ffg3ONHSgylQ7hANVdk
2qAWugdXZLw/pqustIodIR3hjsWLc4zZDF+d6BywdB5WqSiS54u7ENSPkbGInKRR
8zprb2tjjjgwxL1MXF+6J1HG+GoTvEjjwjh26XDSiFbWCIX3hRjej+EjltKDARIo
RWfX6/hTVnljkNUEpBfsi7DaiDVwkgo1OLQ3OSXgG9rZxs50ASMb4dBuN8wGdRrX
jK3PF5m3ddVxCW2I5CFltd3qHlUFn+fmQojXtU6VSACgw0roQhw=
=qnbZ
-----END PGP SIGNATURE-----
