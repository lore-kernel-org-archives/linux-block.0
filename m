Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D95CC433EF
	for <linux-block@archiver.kernel.org>; Tue,  4 Jan 2022 04:24:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbiADEYo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Jan 2022 23:24:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbiADEYo (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Jan 2022 23:24:44 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28C8C061761
        for <linux-block@vger.kernel.org>; Mon,  3 Jan 2022 20:24:43 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id u8so42768778iol.5
        for <linux-block@vger.kernel.org>; Mon, 03 Jan 2022 20:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=fysgzqADL/lBpOy4VPT5bc0kbkh347ywGZe1pIcOs5M=;
        b=qeBt172nL1IAP3rTVlHJnaaBDgpYbvJHhH5lPOjRLyaO6KNi9t8oOe+4S1MHsuL9Lj
         Ed4JlToLjjE5Xs0OBMzz739ioOgS/rlGl9eFdMtBnJTeIkbmfmfwyAWWPsLBDQ3Fc0vr
         W4L9hbuF2EA9WcKHl1W2nZ0VWLrxfneO1dGlVcpf7vI3k7MBU+R1QMLz7aliW8RisBPX
         PYW+vcNcyOd+lacwqzhK//8UIFjrUZOcpJYjvAol9RaQ8yeFoup8oNzPLhMPLN/f0INX
         o2dDy4DMgXG360NUZkMG+hvd+q+DrA9qr64MR3XoxWGTMVaq8Rlcs/rCmr2ACne+tNZb
         k1Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=fysgzqADL/lBpOy4VPT5bc0kbkh347ywGZe1pIcOs5M=;
        b=vvLx9giVY/gr4bw4wUZyMKmOeCIyqzGaKVhu4XGe8N1eg25ngwCG/UtQHyoh0utNrE
         Locx1m5+mtOk8OIQWaMscKWF8A1MuumtHo/sTRFmCqnsg4ZCMjEUOntvVkNM94jGgJWT
         L82EZ98IBiFKcYQ3yv0DkTzV4qed0BYi8jDvIkkQb8YaxZmr/6PGcSGdwW6Oym2r02Lt
         t97CK6iye/DCgSiX4xuqGvUjxJujVnG0aw6Yy7XvBhVjckLbt8C2128w4dxQPpuO+e+g
         K1OfFhTSVTUAU0haUGQB2zHWRLJGLPzRYEu2C5M/o0gUEZ3+eBJsRHIehHSEUmi3IeXh
         agqg==
X-Gm-Message-State: AOAM531Ro7MiJfat4rNCo9o47yKp24bYsYiyI7QHIxgrFdb3RS9ut/uj
        8drih1QGtuNjQJC+Mz12xac00yXNAz7gew==
X-Google-Smtp-Source: ABdhPJxGj5WEFOVDh/ojNhTb+ma9rGNeAotZnvSLkrPSdnx9XVirxl9inzRwRgVtmcnpQig9LO7qCw==
X-Received: by 2002:a05:6602:330e:: with SMTP id b14mr19580953ioz.192.1641270283348;
        Mon, 03 Jan 2022 20:24:43 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id y19sm19195536iov.23.2022.01.03.20.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 20:24:43 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-block@vger.kernel.org
In-Reply-To: <20220103162408.742003-1-gregkh@linuxfoundation.org>
References: <20220103162408.742003-1-gregkh@linuxfoundation.org>
Subject: Re: [PATCH] pktcdvd: convert to use attribute groups
Message-Id: <164127028280.171067.13286005071410412665.b4-ty@kernel.dk>
Date:   Mon, 03 Jan 2022 21:24:42 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 3 Jan 2022 17:24:08 +0100, Greg Kroah-Hartman wrote:
> There is no need to create kobject children of the pktcdvd device just
> to display a subdirectory name.  Instead, use a named attribute group
> which removes the extra kobjects and also fixes the userspace race where
> the device is created yet tools like libudev can not see the attributes
> as they think the subdirectories are some other sort of device.
> 
> 
> [...]

Applied, thanks!

[1/1] pktcdvd: convert to use attribute groups
      commit: d5dbcca70182501bed99de85c224cef04c38ed92

Best regards,
-- 
Jens Axboe


