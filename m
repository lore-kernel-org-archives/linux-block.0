Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2860C432BE
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 16:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A497C60F25
	for <linux-block@archiver.kernel.org>; Fri, 27 Aug 2021 16:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhH0Qic (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 27 Aug 2021 12:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbhH0Qic (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Aug 2021 12:38:32 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E683C061757
        for <linux-block@vger.kernel.org>; Fri, 27 Aug 2021 09:37:43 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id g9so9246741ioq.11
        for <linux-block@vger.kernel.org>; Fri, 27 Aug 2021 09:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N8h3ICh2d8swsBpwd0T0Wx1ceSdNKUwK+rnS0ndjImE=;
        b=SM2js4jdXE6gbDGLrVxC2yr7yA8OwGnll9h6VGN7HX30evWtxt/JG194I+Fm0O6kg3
         76Czi0olVJ0fW3DEsJkSP6ygpepjrx4JmoK7h5imOLLIz1pIBGxZJVreSEsO0fkB5m+k
         NoWB/TZkH7gQKYhWpfZ7y1K9HQ/DIvnCVp/9ujA+CVsTtVKPjFLos8tju2WQxvKQR0vT
         4dYwxF7XOiBpW7617wwMN2ZrPSYtQOSVOblYr7wsHyadORWF+sEgpx2TnHrDR64hReVT
         Sqmfv7PMoKecLnqa2i4uPauycajl2QWta2WdwI/IjHIkwcVcR43aP+LQYxX16TOk7Snr
         LgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N8h3ICh2d8swsBpwd0T0Wx1ceSdNKUwK+rnS0ndjImE=;
        b=nF0rnqTrEA7b682ax+oeKbBn9OTGLJwcXjpvA7pWrfAbdIyIlE0YRnySNLPHB19RU+
         XTPYcq1Lm+cj87Ac4sm6+U26zuz4o8fVhrJE6aw4lErzrSfW7weStWQkx/Z3k+ybjTC8
         eJXANd542whtsTd2cRuALQE95u+0bRloyncFGMzg1+caOqVKUENHcsrORbr0+1+vjFjv
         I/C8kkR5BXdVq0IvyObpTPSjXpehBiQNYASJrJ9espw+8Vdv7Op4poi8LPug/o4en8BO
         ptc/JYBqezdPB2JImcpk4gj4rswaQtaP7i4Tu/01ss+jcLHkBpD9RLvuVYpM+m9lQLKo
         S5Wg==
X-Gm-Message-State: AOAM530OmkQHc7O+kU2OXUuoISb/1286XB7jskGuQJjmAn/TQnLavoMA
        jZBXtV/DNFfs0vyMDAhYJoXnxb1OWmQo7A==
X-Google-Smtp-Source: ABdhPJxLy0nn0VQCiwexovjX280EXQ6zjH/QlgLCgi203Uh25ApRv0+eYur1rTEp8ItLuRrxway6gg==
X-Received: by 2002:a6b:f714:: with SMTP id k20mr8080207iog.148.1630082262569;
        Fri, 27 Aug 2021 09:37:42 -0700 (PDT)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t15sm3676690ilq.88.2021.08.27.09.37.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 09:37:42 -0700 (PDT)
Subject: Re: [PATCH for-5.14] cryptoloop: add a deprecation warning
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org
References: <20210827163250.255325-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <59808096-34ff-151f-b7a2-f53d4262f00a@kernel.dk>
Date:   Fri, 27 Aug 2021 10:37:41 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210827163250.255325-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/27/21 10:32 AM, Christoph Hellwig wrote:
> Support for cryptoloop has been officially marked broken and deprecated
> in favor of dm-crypt (which supports the same broken algorithms if
> needed) in Linux 2.6.4 (released in March 2004), and support for it has
> been entirely removed from losetup in util-linux 2.23 (released in April
> 2013).  Add a warning and a deprecation schedule.

Would probably look better to queue with the 5.15 patches at this point.
Which then begs the question of whether we want to make the removal
target 5.17 instead.

-- 
Jens Axboe

