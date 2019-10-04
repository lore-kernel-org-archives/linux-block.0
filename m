Return-Path: <SRS0=jhC6=X5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8D4C4360C
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 16:22:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85BF02133F
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 16:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="tjowRk8u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbfJDQWb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:22:31 -0400
Received: from mail-pf1-f181.google.com ([209.85.210.181]:38052 "EHLO
        mail-pf1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfJDQWa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Oct 2019 12:22:30 -0400
Received: by mail-pf1-f181.google.com with SMTP id h195so4199710pfe.5
        for <linux-block@vger.kernel.org>; Fri, 04 Oct 2019 09:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=EGoqdeKgNyfz8kLNBTimQgSR9Wp1zFupDdts0k7rkyA=;
        b=tjowRk8u3BOj2YDJkgYOzm1d4pIBDM9UIAi5uAQVlg0s5L8TWU8RyiLCoyIONVoEpt
         EtmGpy5P79UpZ4IrvUAZ+Fp5zkGTvC18lQ1nhIEUlPpwwtWopwyhcb55B1a205oJoJ39
         g+N5RivHBfZWS3SeBlfVyaok+nyH+O7sMMelJ6AoDOcANBHrAJRTuLfgR+ZETCwTqKWC
         Ctsi4pn6mrs7j0NSs+b9xDl8mxVW0mYKC9oWHtkYxQxXbS4VzCx1onREyKV/Ai15B/GH
         4VNkTJ08qEiw7qhDjxRb6Q0WYCXtNmTO/B8NkwDIH1jX2ZZqVSzmdyF1aKAUn7u05iZr
         w3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EGoqdeKgNyfz8kLNBTimQgSR9Wp1zFupDdts0k7rkyA=;
        b=mUj244hENT7wL/beMk1/UicifCKfKqYkQjKWVM2IjKLDX7ATR6tCp4X0m+muYtiWrX
         DpICHN7AgCiEhe6AqMWUpu9SEF6SZh4kpZmNlvAt8grbHx4wiYYIacq6aQwbU1PBNCTM
         OIVt8zjWKdefgB1yUQ6gDgN+ybe8z+qqbmn7Yc+VeL8HJmJqHM1RwZQJnpZxaUVQ5ZhP
         3EaMTu2U3SfFSHtbWfEkx/gZi9Y7XyoeiyfWZ8Akgv0SydYkGLNplCyAkCxfCeoOjL08
         +HG9U7NeV0RU/nt6YICfXzVWjHwceJdepg5k/6p6NoEtvM98Reta0MgeNgtoAM7qqM4l
         dgAg==
X-Gm-Message-State: APjAAAWJIXkoGbdcaXQcsTqJ6Jyn9bZIK+ITrzJnVvZ3LCQ7Xc2fb1vL
        5iHpUF/MrfECM+rvgGAcsQSYgPfY6gC+iw==
X-Google-Smtp-Source: APXvYqzQF6k0p0mpL0Rz+XqjDlqW+30Cz10q5MdR+8DpXk+VWeuW8Qz8hmYT2JdOmVLuhnEJYF+wYg==
X-Received: by 2002:a62:5c82:: with SMTP id q124mr969267pfb.177.1570206149644;
        Fri, 04 Oct 2019 09:22:29 -0700 (PDT)
Received: from localhost.localdomain ([2600:380:7548:69cb:e476:ab55:1c76:9921])
        by smtp.gmail.com with ESMTPSA id v20sm994054pgh.89.2019.10.04.09.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 09:22:28 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     jmoyer@redhat.com
Subject: [PATCHSET v2] io_uring: support fileset add/remove/modify
Date:   Fri,  4 Oct 2019 10:22:20 -0600
Message-Id: <20191004162222.10390-1-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently we only support registrering a fixed file set. If changes need
to be made to that set, the application must unregister the existing set
first, then register a new one.

This patchset adds support for sparse file sets (patch 1), which means
the application can register a fileset with room for expansion. This is
done through having unregistered slots use fd == -1.

On top of that, we can add IORING_REGISTER_FILES_UPDATE. This allows
modifying the existing file set through:

- Replacing empty slots with valid file descriptors
- Replacing valid descriptors with an empty slot
- Modifying an existing slot, replacing a file descriptor with a new one

-- 
Jens Axboe


