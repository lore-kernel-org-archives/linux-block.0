Return-Path: <SRS0=6LXE=TW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CE0C282CE
	for <linux-block@archiver.kernel.org>; Wed, 22 May 2019 20:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D1C321019
	for <linux-block@archiver.kernel.org>; Wed, 22 May 2019 20:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbfEVUUu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 May 2019 16:20:50 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41998 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729679AbfEVUUt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 May 2019 16:20:49 -0400
Received: by mail-ed1-f66.google.com with SMTP id l25so5581851eda.9
        for <linux-block@vger.kernel.org>; Wed, 22 May 2019 13:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HIQjU7W1517xzC6E8FPYkI2SHzlzEbtjalA/f08V8fg=;
        b=Ssb3QgFpKCLE3pT4cOwkR876hM6goGDPBIBAzukzGmPoIHIpAqFwCb0/bcMEYGbeku
         NPrG9iezPZyzIt/ld41wBGAhkeZuBPLVM8SNJvFLCujIGizaTMGSf27SfMZ9NW1fk8A8
         nteBcWfTEf/ikrPRCvito5Da/qrQUIatXJZwTboxjC97eWnIq+zfAeO5QedW6WQ67OvZ
         G2AsNPV0hBN4DRiKlt8nr1HZQ0g9kA2nhjvPnzZh89JiaYG8yMLrNvpM9HRRs8bgsz3W
         JBjlsbLk+/ijSvP6sdXtrSqDHoGN7so8hPo1SdiCB2FdmJvNBec3tN/Lf2vqN7MSLMTL
         rD0w==
X-Gm-Message-State: APjAAAUYvGvXbp0Qn9+EoICpmIP0iuzGIes7krxu+jifbD2jqqmu6Viz
        w9S4U/GLQreZn7XJgQvRTwU=
X-Google-Smtp-Source: APXvYqwxFbbzeFEnij6ywPND3rClzaDLu2aezuK3tbBNZK81WKU64tCi3FMqFpVPMlh8+/13I0yqdA==
X-Received: by 2002:a50:9968:: with SMTP id l37mr91263691edb.143.1558556448074;
        Wed, 22 May 2019 13:20:48 -0700 (PDT)
Received: from [192.168.1.6] (178-117-55-239.access.telenet.be. [178.117.55.239])
        by smtp.gmail.com with ESMTPSA id a3sm7330472edc.75.2019.05.22.13.20.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 13:20:47 -0700 (PDT)
Subject: Re: [PATCH 0/2] Reset timeout for paused hardware
To:     Keith Busch <keith.busch@intel.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org
Cc:     Ming Lei <ming.lei@redhat.com>
References: <20190522174812.5597-1-keith.busch@intel.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <721e059e-ed88-734c-fea2-3637e6d31f4c@acm.org>
Date:   Wed, 22 May 2019 22:20:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190522174812.5597-1-keith.busch@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/22/19 7:48 PM, Keith Busch wrote:
> Hardware may temporarily stop processing commands that have
> been dispatched to it while activating new firmware. Some target
> implementation's paused state time exceeds the default request expiry,
> so any request dispatched before the driver could quiesce for the
> hardware's paused state will time out, and handling this may interrupt
> the firmware activation.
> 
> This two-part series provides a way for drivers to reset dispatched
> requests' timeout deadline, then uses this new mechanism from the nvme
> driver's fw activation work.

Hi Keith,

Is it essential to modify the block layer to implement this behavior
change? Would it be possible to implement this behavior change by
modifying the NVMe driver only, e.g. by modifying the nvme_timeout()
function and by making that function return BLK_EH_RESET_TIMER while new
firmware is being activated?

Thanks,

Bart.

