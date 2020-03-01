Return-Path: <SRS0=IUku=4S=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EE7C3F2D1
	for <linux-block@archiver.kernel.org>; Sun,  1 Mar 2020 08:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A1221556
	for <linux-block@archiver.kernel.org>; Sun,  1 Mar 2020 08:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725812AbgCAIVt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 1 Mar 2020 03:21:49 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38664 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgCAIVs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sun, 1 Mar 2020 03:21:48 -0500
Received: by mail-lf1-f67.google.com with SMTP id w22so4448592lfk.5;
        Sun, 01 Mar 2020 00:21:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:autocrypt:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=FEomqfZZfIuYbMlkSGRjHi9lKtcuo2m8E1r6mo7nbNQ=;
        b=aLG51rzWgY+J6jRdb8wVtKkftjzKeTkPqF7aQZ/yhLsQp7btCiSTpXy1WNP46rV8Uy
         DsVE1/QDgPkqOf7jqQWLQvWcjcRzm2f7KPA2Ygb6Dejc40SYqs58tjRW4SfF6bnnW2kg
         0EgJ1TR9pRITP8xk4vFjwkR+VCG/hU45jQ2p/RuacR+obnbj9EexdYW5XlXEQIDsQakY
         tRJRtgCX6MHEOQD8Het+5c9vxejHnrs764k3QaVRUTEXGOywrXQy/ZosJjWa3jrXkQda
         naqI0WqelFq6ArtteI5dUt0biQTCDVVQfLH250ZT0gw0DPT9J+0kRC6wrr4QwEMFwVdw
         VZ4A==
X-Gm-Message-State: ANhLgQ249E3Olao2PVYjipan3s03pQbKEO/n3CuT+Zx1QAbuZiEpZxYs
        6TeHDJoyuw0yRwOgKwfLK9dXBSYq
X-Google-Smtp-Source: ADFU+vu+j3d9UWzBe+peQwPP/6kV3GmsR+7TMq92i8E3aeO0L+ZUpeyZlA8plw8lUTsKhgTKwrfGCg==
X-Received: by 2002:ac2:5e90:: with SMTP id b16mr7151187lfq.155.1583050906587;
        Sun, 01 Mar 2020 00:21:46 -0800 (PST)
Received: from [10.68.32.192] (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.gmail.com with ESMTPSA id l22sm9353353lje.40.2020.03.01.00.21.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Mar 2020 00:21:46 -0800 (PST)
To:     Willy Tarreau <w@1wt.eu>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200224212352.8640-1-w@1wt.eu> <20200226080732.1913-1-w@1wt.eu>
From:   Denis Efremov <efremov@linux.com>
Autocrypt: addr=efremov@linux.com; keydata=
 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
Subject: Re: [PATCH 11/16] floppy: remove dead code for drives scanning on ARM
Message-ID: <758c8079-50d7-7dc7-ca83-46be038f182b@linux.com>
Date:   Sun, 1 Mar 2020 11:21:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200226080732.1913-1-w@1wt.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

For patches 11-16,

I've checked the building on x86, arm.
x86 shows no difference in floppy.o binary.

Compilation on arm tested (make rpc_defconfig).

I think that macro fd_outb from arm could be turned to
the static inline function, like on mips or m68k arches. However,
it's up to you if you want to keep the changes close to the
original structure.

Please address the warnings and resend the patches:

In file included from drivers/block/floppy.c:251:
./arch/arm/include/asm/floppy.h:60:2: warning: braces around scalar initializer
   60 |  { 0x10, 0x21, 0x23, 0x33 },
      |  ^
./arch/arm/include/asm/floppy.h:60:2: note: (near initialization for ‘floppy_selects[0]’)
./arch/arm/include/asm/floppy.h:60:10: warning: excess elements in scalar initializer
   60 |  { 0x10, 0x21, 0x23, 0x33 },
      |          ^~~~
./arch/arm/include/asm/floppy.h:60:10: note: (near initialization for ‘floppy_selects[0]’)
./arch/arm/include/asm/floppy.h:60:16: warning: excess elements in scalar initializer
   60 |  { 0x10, 0x21, 0x23, 0x33 },
      |                ^~~~
./arch/arm/include/asm/floppy.h:60:16: note: (near initialization for ‘floppy_selects[0]’)
./arch/arm/include/asm/floppy.h:60:22: warning: excess elements in scalar initializer
   60 |  { 0x10, 0x21, 0x23, 0x33 },
      |                      ^~~~
./arch/arm/include/asm/floppy.h:60:22: note: (near initialization for ‘floppy_selects[0]’)
  CC [M]  drivers/block/loop.o
drivers/block/floppy.c: In function ‘fdc_outb’:
./arch/arm/include/asm/floppy.h:15:14: warning: suggest parentheses around comparison in operand of ‘&’ [-Wparentheses]
   15 |   if ((port) & 7 == FD_DOR) {    \
      |              ^
drivers/block/floppy.c:603:2: note: in expansion of macro ‘fd_outb’
  603 |  fd_outb(value, fdc_state[fdc].address + reg);


Everything else looks good to me. Thanks!

Regards,
Denis
