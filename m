Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2829C433F5
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 11:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C910A60F4B
	for <linux-block@archiver.kernel.org>; Mon, 27 Sep 2021 11:17:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbhI0LTD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 07:19:03 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:57259 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbhI0LTC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 07:19:02 -0400
Received: from fsav411.sakura.ne.jp (fsav411.sakura.ne.jp [133.242.250.110])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 18RBH0N1054907;
        Mon, 27 Sep 2021 20:17:00 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav411.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp);
 Mon, 27 Sep 2021 20:17:00 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav411.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 18RBH0Yq054885
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 27 Sep 2021 20:17:00 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] loop: avoid out-of-range warning
To:     Martijn Coenen <maco@android.com>, Arnd Bergmann <arnd@kernel.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev
References: <20210927094327.644665-1-arnd@kernel.org>
 <CAB0TPYGWXAs5t_bG8BMs_9xvOmfsJiy1ejM0WoJC3Ts3yC6E1Q@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <755aa284-06f4-ee10-ec7b-0f69a1617349@i-love.sakura.ne.jp>
Date:   Mon, 27 Sep 2021 20:16:59 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAB0TPYGWXAs5t_bG8BMs_9xvOmfsJiy1ejM0WoJC3Ts3yC6E1Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Well, you found a bug here.

lo_simple_ioctl(LOOP_SET_BLOCK_SIZE) passes "unsigned long arg" to
loop_validate_block_size() via loop_set_block_size(), and uses only
lower 32bits. "(lo->lo_queue->limits.logical_block_size == arg)" is
failing to "return 0;" if lower 32bits are the same but higher 32bits
are not 0. Shouldn't we also check that higher 32bits are 0, by either
making loop_validate_block_size() to accept "unsigned long" or making
loop_set_block_size() return -EINVAL if larger than UINT_MAX ?

> There is nothing wrong here, so just shut up the check by changing
> the type of the bsize argument.

I think there is something wrong here.
Since "unsigned short bsize" checked only lower 16bits, a fuzzer can
pass e.g. 0xDEAD0200 (which is not a is_power_of_2() 32bits value) to

	blk_queue_logical_block_size(lo->lo_queue, arg);
	blk_queue_physical_block_size(lo->lo_queue, arg);
	blk_queue_io_min(lo->lo_queue, arg);

and confuse the system?
