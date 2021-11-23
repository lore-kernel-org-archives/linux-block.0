Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A738C4332F
	for <linux-block@archiver.kernel.org>; Tue, 23 Nov 2021 16:18:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232807AbhKWQVZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Nov 2021 11:21:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237830AbhKWQVZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Nov 2021 11:21:25 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344FDC061714
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 08:18:17 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id p23so28665554iod.7
        for <linux-block@vger.kernel.org>; Tue, 23 Nov 2021 08:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u499gl0OTaviQ7lyFe4Y05am+yoUsJ0YNdKWI2pHWk4=;
        b=bT5FXF8xdQ6yMBI9xmneJDshDZpOWplGVIFkeTyLUh1NerpvcKiCzFCderxK7Uz2Jt
         qjYfcGRgXXzT6o2mhzn5FA5Zyu9uc5B1KjFtMc0XLWgPuzbmwmIXwC/oHR4n3N800UOu
         6ZBNQa4UWoGBru4V9El4izXxf9GF3GOlj61woa/ZLcJjL0KZj4CvjZP3v6TD9pJD9DX1
         k6elwVI+fvfJs2BJb8M6IBlhbRxPLkDvPtIp8cvRE+SQCwU9MDuxCp84lh41QNqIO3IN
         3cWsq7WpjTkwh/8TgOiuxO8PcwP4Rd+XPJZ6Snc8igNyTEfK9tyo75tOMq7J4XaDy1HX
         7+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u499gl0OTaviQ7lyFe4Y05am+yoUsJ0YNdKWI2pHWk4=;
        b=LnCcUfc1PIz45wssLJqJ4rxklvuiY9NtwtXeJvZpAvwjPSTGsey6+2Q7Q0b+qS2Nsk
         atbsCCAVR/d+EXB/P/9vkILlDaR+8DJxK2kJaQWUm9BkdIbQkb9WvDN6e41hLFNqfGs1
         txwJF0ha8U7Eaf2kJ69S0BJn5WREvRfPlilD1HR7RVbW0iiyHzDHOVc9cpNcd/wQ7+rX
         aR2qRl1ULcOhyLrL52ttYL+Lov/1II5LPDIwbISQ+D/dLim4ZKlRcV4w6mYM7yE/9lar
         G/mOfXoT68GV7yziW6kacfCsujamArRzPvQncLOrvcCKubhsFuuMsT8UShhl3lsQ2J9f
         dqQQ==
X-Gm-Message-State: AOAM530Kqil6XKOwhQGPKLKpYUnM2ErrDr4QaHnnEfj35tJTAgenM4tk
        CY43lhSPhc3ftWIw9JajF+K4Qkx2YwUWisOz
X-Google-Smtp-Source: ABdhPJwLgievO2HvO4U73v5M8G6Ef6YWmsAg/lB/WWzUTOO08WNNFGy6ieNl7lQHDE5Wj2rGz+sqtQ==
X-Received: by 2002:a05:6638:19a:: with SMTP id a26mr8317772jaq.133.1637684294989;
        Tue, 23 Nov 2021 08:18:14 -0800 (PST)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id t188sm7858034iof.5.2021.11.23.08.18.14
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 08:18:14 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Subject: [PATCHSET 0/3] Misc block cleanups
Date:   Tue, 23 Nov 2021 09:18:10 -0700
Message-Id: <20211123161813.326307-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

First patch avoids setting up an io_context for the cases where we don't
need them, second patch optimizes re-writing to the bio if not needed, and
prunes a huge chunk of memory in the request_queue and makes it dynamic
instead.

-- 
Jens Axboe


