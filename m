Return-Path: <SRS0=gurp=SW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9E9C282DD
	for <linux-block@archiver.kernel.org>; Sat, 20 Apr 2019 13:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D780E21479
	for <linux-block@archiver.kernel.org>; Sat, 20 Apr 2019 13:34:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cnL8f/I9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726675AbfDTNeb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 20 Apr 2019 09:34:31 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43249 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbfDTNeb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 20 Apr 2019 09:34:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id z9so3834561pgu.10
        for <linux-block@vger.kernel.org>; Sat, 20 Apr 2019 06:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=FuHU311J+PXYa7M2Qqx9D3TCfJbxWnGPcdLwP1BqIyE=;
        b=cnL8f/I9K+Hass3P+8dFOF/NiSQY0PHeWKUcjk9KGZE5hdAROKdBIZPZHAb3ogf7P9
         sJj9vSFSd+9jVB2AJc+lYhuFnRv9kPt2gwULcPxJXzRgwA3g3dFjWlQvFGlCvoQHwiLH
         69fhpvORwiYZs1qUOJ0uDSV7MMdFbTVgKaOaRramox0Y7ns5RSoFgtauTR2zVIa2RBbP
         I/Wiht7ke2r6t4rTO1S2O42GukkDHpu8yj7DZTq/xGIzTQUvPD4wtQwqd11WY/rj63ns
         d28UmbfId633P+wCVB1GBTHmswuvBcBC8VnaGSvcZBLVgFjkc8zBNmW+UQqvhxT87YI+
         OiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=FuHU311J+PXYa7M2Qqx9D3TCfJbxWnGPcdLwP1BqIyE=;
        b=LjKHPVFWPM9HuaPXu01v1F+IwtOPggnvhJFKPIELRda5ydsw7VCLQxmmX1vi3PFVnW
         j0AGSaHGEzVQktWtCBKqTpuFdIB+OVCNPYxbsDHkSndnoko2hJbI1v9oNxMKvowA0nbo
         /YW4Eq1+JUrjO0FumIHAHKhgCbn+VgmDqvRQ737djbb1nK8hmbhZe5CeQ552n9Qh7VR2
         qv4ynV6b8tGzQ2KWQpQs/kIKWfHKG3S2uxnFv03kPLDRcxy6rku9APuecRfbPbEcJJtD
         30cbYP739fi2AXb1oAYrONXsB2JsoYC/8zkOR/e1ccgCu7aaVdcUhbvE9WfKGV5Ds9vu
         HDKA==
X-Gm-Message-State: APjAAAXReWPkxrlK4M+nVKoZ8WIhf+lHenMXeTa7KaWesCbWRIT3hFQN
        cH+gGmTwiA+8zeQsb+l+c1rtKHkODv/Rrw==
X-Google-Smtp-Source: APXvYqxOAjwpENlrKwR01ernSP/6D7M1jjRnW4WBxJ8DPg/2kQHqC1oHyA/0WJVW6xKtlZY/ls+kKg==
X-Received: by 2002:a65:448b:: with SMTP id l11mr9233475pgq.185.1555767269836;
        Sat, 20 Apr 2019 06:34:29 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id g4sm14679665pfc.75.2019.04.20.06.34.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Apr 2019 06:34:28 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block fixes for 5.1-rc6
Message-ID: <ce3f98a4-7d83-b0b4-bb69-ffd90e5c2520@kernel.dk>
Date:   Sat, 20 Apr 2019 07:34:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

A set of small fixes that should go into this series. This pull request
contains:

- Removal of unused queue member (Hou)

- Overflow bvec fix (Ming)

- Various little io_uring tweaks (me)
	- kthread parking
	- Only call cpu_possible() for verified CPU
	- Drop unused 'file' argument to io_file_put()
	- io_uring_enter vs io_uring_register deadlock fix
	- CQ overflow fix

- BFQ internal depth update fix (me)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-linus-20190420


----------------------------------------------------------------
Hou Tao (1):
      block: kill all_q_node in request_queue

Jens Axboe (6):
      io_uring: park SQPOLL thread if it's percpu
      io_uring: only test SQPOLL cpu after we've verified it
      bfq: update internal depth state when queue depth changes
      io_uring: drop io_file_put() 'file' argument
      io_uring: fix possible deadlock between io_uring_{enter,register}
      io_uring: fix CQ overflow condition

Ming Lei (1):
      block: make sure that bvec length can't be overflow

 block/bfq-iosched.c      |  8 +++++++-
 block/blk-mq.c           |  2 ++
 fs/io_uring.c            | 41 ++++++++++++++++++++++++++++++-----------
 include/linux/blkdev.h   |  1 -
 include/linux/bvec.h     |  5 +++--
 include/linux/elevator.h |  1 +
 6 files changed, 43 insertions(+), 15 deletions(-)

-- 
Jens Axboe

