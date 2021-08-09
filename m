Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8E17C4320A
	for <linux-block@archiver.kernel.org>; Mon,  9 Aug 2021 18:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CB6C60FE3
	for <linux-block@archiver.kernel.org>; Mon,  9 Aug 2021 18:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbhHIS5L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 9 Aug 2021 14:57:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235656AbhHIS5J (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 9 Aug 2021 14:57:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 862FB60F11;
        Mon,  9 Aug 2021 18:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628535408;
        bh=Club1rpvylBf8gX0nH4hqgxX2CQBVQEJTP5FNvLKgAk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ANWNU9Tm1mKTkj9B/l+QFWhzd7r/JBDVhmaDmwjWAHIfKqdJAN/jzm1orZCfZP5Wl
         t0OdJAU3y+ZCBGkiYl5lnLnC160AZGO+lWsZEhHjg2B0M+tZNQG9YPH1oKLA+dfqq7
         y9Fu45aXst02HJVczZl2JshcolbV1AIGDoEtKLlcRD4YVj7Y8P/GVO9gKhxJXWJbTM
         NAKlzpgG3xxZsv6Qxk+bpusM+j8o1L2+y0b/UvNmGsr57+dnKodlo1/ztipg7iZ6EL
         peGna2Dl7YW2cdd+fSqDh+d5Xn9pc8kPYRrGtAikq4nbS2m78IihhCF770eCs72jgI
         SKq3tFfNBmhdA==
Date:   Mon, 9 Aug 2021 20:56:33 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Ian Pilcher <arequipeno@gmail.com>, pali@kernel.org
Cc:     linux-block@vger.kernel.org, linux-leds@vger.kernel.org,
        axboe@kernel.dk, pavel@ucw.cz, linux-kernel@vger.kernel.org,
        kernelnewbies@kernelnewbies.org
Subject: Re: [RFC PATCH v2 00/10] Add configurable block device LED triggers
Message-ID: <20210809205633.4300bbea@thinkpad>
In-Reply-To: <20210809033217.1113444-1-arequipeno@gmail.com>
References: <20210809033217.1113444-1-arequipeno@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hello Ian,

thank you for your proposal. Some comments below:

On Sun,  8 Aug 2021 22:32:07 -0500
Ian Pilcher <arequipeno@gmail.com> wrote:

> One thing that has not changed is that associations between block
> devices and LEDs are still set via an attribute on the device, rather
> than the LED.  This is much simpler, as the device attribute only has
> to handle a single value (the name of the associated LED), rather than
> potentially handling multiple device names.

It may be simpler, but it is in contrast to how the netdev trigger
works, which already is in upstream for many years. I really think we
should try to have similar sysfs ABIs here. (I understand that the
netdev trigger is currently unable to handle multiple network
interfaces - but it is possible to extend it so.)

> I have modeled the interface for the /sys/block/<DEVICE>/led
> attribute on the sysfs interface used for selecting a trigger.  All
> available LEDs (all LEDs associated with the blkdev trigger) are
> shown when the attribute is read, with the currently selected LED
> enclosed in square brackets ([]).

I think it is reasonable to be able to set something like this:
  led0 : blink on activity on any of [sda, sdb, sdc]
  led1 : blink on activity on sda
  led2 : blink on activity on sdb
  led3 : blink on activity on sdc

If I am reading your code correctly, it looks that only one LED can be
configured for a block device. Is this true? If so, then the above
configuration cannot be set.

Also you are blinking the LED on any request to the block device. I
would rather expect to be able to set the LED to blink on read and on
write. (And possibly on other functions, like discard, or critical
temperature, or error, ...) I would like to know what other people
think about this.

Marek
