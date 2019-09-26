Return-Path: <SRS0=S7xR=XV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AB2C432C2
	for <linux-block@archiver.kernel.org>; Thu, 26 Sep 2019 10:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 353A7217F4
	for <linux-block@archiver.kernel.org>; Thu, 26 Sep 2019 10:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="aCR/PPqJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbfIZKFB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 26 Sep 2019 06:05:01 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34582 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbfIZKFB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Sep 2019 06:05:01 -0400
Received: by mail-wm1-f68.google.com with SMTP id y135so6213340wmc.1
        for <linux-block@vger.kernel.org>; Thu, 26 Sep 2019 03:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6t/395YJPTpkIopiqPd9n80eFNg313G8rGGfISQ+VfY=;
        b=aCR/PPqJD5az8PqU6htoYprQuoxi7bbJbDzAMw7SCjFliKTyHNHDsrMU/Es0kD0IKJ
         8dTMn1rgrNN0M5spolH8refi7QIWe1fuAbfCwqmcjWdjWF2ZOLao78thpPiAvaVMdcNj
         kjXpF20o+b4LkR+VRCkrOGiTYK3TOZKM0grW4bqCLWgMEIO7PM42kAEhEmHIux8b3W4h
         28NcouGFosy0r2iQshHzaMVIo9f0F/Zi47Lc+QFY/4RjjIxLPmP1sPnIQfKCB0sluBML
         kTed6SxjK1lbgClKZf4d4xY32MgOk/ipxSKqqexzVPS8ZSt00VVgOrrLwy3W99s+UYhz
         yYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6t/395YJPTpkIopiqPd9n80eFNg313G8rGGfISQ+VfY=;
        b=a0o7RT+whPdatkqZv1thNqLHpKIFyDiv47n9fVlzDVX1hK5g2+KvxBS2mYuYBy7VVs
         vUEYbO1dmx1Zj4+tBPasXhTWTpQe7vvp0Nga2NfBdv0KBnMMunmhl/wjNZb/RLzLa7MP
         Yx8lL9oYBLFA0ytH1F14Cw3WOdDWUkCmQIJvQwsWQ1BZ9NhkDXKIy60T42bEEt4qcedR
         Pp/UdUc8gjtMAkmrz0U+DEw22Mw1ZUh3WxUXSNAisBl597oc0VZZazsWxzxoxBJ0AQIr
         dYXs1NmHSzPU9LpyPivge4KyGtZqIJrSJoMdeFGyjxYHFIAuU2wm7ahUxfN6Ws/VBgUL
         sbjw==
X-Gm-Message-State: APjAAAWJQBkhpAm52/6NwGD0IsFoESZ2V0qHRvUKAV8oH6fbayLl5LXw
        hDdywHMaziNU2SHLawCmDxGYOQ==
X-Google-Smtp-Source: APXvYqzfVmZJDDfYzTQKfhcEoESp05tB95zXfX5FO7FI6eI2UAgyETMyDPEv/j13dLRIJU0H+rcbqw==
X-Received: by 2002:a1c:b745:: with SMTP id h66mr2199329wmf.70.1569492297740;
        Thu, 26 Sep 2019 03:04:57 -0700 (PDT)
Received: from [192.168.1.145] ([65.39.69.237])
        by smtp.gmail.com with ESMTPSA id s1sm3815000wrg.80.2019.09.26.03.04.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Sep 2019 03:04:57 -0700 (PDT)
Subject: Re: [PATCH v4] block: fix null pointer dereference in
 blk_mq_rq_timed_out()
To:     Yufen Yu <yuyufen@huawei.com>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Christoph Hellwig <hch@infradead.org>,
        Keith Busch <keith.busch@intel.com>,
        Bart Van Assche <bvanassche@acm.org>, stable@vger.kernel.org
References: <20190925122025.31246-1-yuyufen@huawei.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9fda0509-0ee5-9f9d-8a37-2d33a097d1bd@kernel.dk>
Date:   Thu, 26 Sep 2019 12:04:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190925122025.31246-1-yuyufen@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/25/19 2:20 PM, Yufen Yu wrote:
> diff --git a/block/blk.h b/block/blk.h
> index ed347f7a97b1..de258e7b9db8 100644
> --- a/block/blk.h
> +++ b/block/blk.h
> @@ -30,6 +30,7 @@ struct blk_flush_queue {
>   	 */
>   	struct request		*orig_rq;
>   	spinlock_t		mq_flush_lock;
> +	blk_status_t 		rq_status;
>   };

Patch looks fine to me, but you should move rq_status to after the
flush_running_idx member of struct blk_flush_queue, since then it'll
fill a padding hole instead of adding new ones.

-- 
Jens Axboe

