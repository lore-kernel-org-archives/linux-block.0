Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5ACC433F5
	for <linux-block@archiver.kernel.org>; Mon, 17 Jan 2022 14:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237968AbiAQOYy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Jan 2022 09:24:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236869AbiAQOYv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Jan 2022 09:24:51 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB9DC061574
        for <linux-block@vger.kernel.org>; Mon, 17 Jan 2022 06:24:51 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id s11so13651236ioe.12
        for <linux-block@vger.kernel.org>; Mon, 17 Jan 2022 06:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=jVNvNvayy+/A20FL6hPuQrewXxQXZtn0natzaMP+ak0=;
        b=2BEPxoauM98xTgJnDC2nYSYqkRNyN31G8gSDCIQMkCnMQXJXFlkF8gJaGzHmjA6xjT
         Bc8zGYswk4NOC21eEGGtKjxK2Lq8I2CAoBR5atSV63DReIoLAbLodajEcdFJ7RO+AzFD
         owcQVGbG4idnPMovKnolnRcjyXpHHhg3Av+P4EAyMUCol3PRRLwfBWGUgLcq/I6sabs3
         zeKWelmS2aGqdePN1MAXi7zaCb5cF8ftuaP2bvA1agK+bumz/dA/uBHY2Brsw3LElEBv
         rwQcAac6/p4GHBALntPrKOjY6a7DCXMCVnqT480fG7HhcxHl/NRu0hO224tI58/u1FzS
         qEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=jVNvNvayy+/A20FL6hPuQrewXxQXZtn0natzaMP+ak0=;
        b=YBDVxe3pB3+Gd9TeNj9bMY8t7vBJWymYHDyUqgYk3ss3taEHaLYsTRScKhh1vvaIhE
         OId1yAZtENOO/OJ1oEX/TsC3w8DvZI+LbrRZzjDvdlGZKmc4oqKW8GwJ15OmYeOQtWOi
         k/CsOARJ+zzTC1MdvM9dxYGBpNBMchxHWR75bkDKiciJa9gqN5i0TwBELsuv0Bu8gIgT
         G7xPiR/2QitXVC6k1794v2HRIb47DfagBZjrTdbtCI06bChOlHB00qYM9WXKzQrdNjRm
         JXu9eVRVu2Ut1tFG3V8qDIaCg/9aPnpCKnpbSDLKHfMPJJhJC7HVCXyZGYdWht/uSbcH
         fDSg==
X-Gm-Message-State: AOAM533rVsx5XmXzHsfPRwfueOUCGFGWFL0mdWs1+7XnWCI478hrowTe
        eu0d4Ta8rJuWjXFt1I7Uo7EPrg==
X-Google-Smtp-Source: ABdhPJw7+WXjyYstT0h5Iz9qanxPv7F627Uth+6ZBRj/0lZoj+IzDljcB4KW04tryq2HG/Ocp2urtQ==
X-Received: by 2002:a05:6602:2c0d:: with SMTP id w13mr10125692iov.158.1642429490918;
        Mon, 17 Jan 2022 06:24:50 -0800 (PST)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id x16sm5289305iol.33.2022.01.17.06.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 06:24:50 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     syzbot+4f789823c1abc5accf13@syzkaller.appspotmail.com,
        linux-block@vger.kernel.org
In-Reply-To: <20220111123401.520192-1-ming.lei@redhat.com>
References: <20220111123401.520192-1-ming.lei@redhat.com>
Subject: Re: [PATCH] block: cleanup q->srcu
Message-Id: <164242948774.335178.5737870910553010377.b4-ty@kernel.dk>
Date:   Mon, 17 Jan 2022 07:24:47 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 11 Jan 2022 20:34:01 +0800, Ming Lei wrote:
> srcu structure has to be cleanup via cleanup_srcu_struct(), so fix it.
> 
> 

Applied, thanks!

[1/1] block: cleanup q->srcu
      commit: 850fd2abbe02eb2b52cbb1550adbcc89b36d65de

Best regards,
-- 
Jens Axboe


