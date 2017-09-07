Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f48.google.com ([209.85.215.48]:35442 "EHLO
        mail-lf0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754349AbdIGJQY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Sep 2017 05:16:24 -0400
Received: by mail-lf0-f48.google.com with SMTP id d17so23143951lfe.2
        for <linux-block@vger.kernel.org>; Thu, 07 Sep 2017 02:16:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <93626ad390557b27c872bb8325485c9d56cc4e06.1504742003.git.shli@fb.com>
References: <cover.1504742003.git.shli@fb.com> <93626ad390557b27c872bb8325485c9d56cc4e06.1504742003.git.shli@fb.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Thu, 7 Sep 2017 17:16:21 +0800
Message-ID: <CACVXFVO3UaHn32E+kNjRkUHUwn3d=goWA9HFNXqgYHNr+7ZbxA@mail.gmail.com>
Subject: Re: [PATCH V2 3/3] block/loop: suppress discard IO error message
To: Shaohua Li <shli@kernel.org>
Cc: linux-block <linux-block@vger.kernel.org>,
        FB Kernel Team <kernel-team@fb.com>,
        Jens Axboe <axboe@kernel.dk>, Shaohua Li <shli@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Sep 7, 2017 at 8:13 AM, Shaohua Li <shli@kernel.org> wrote:
> From: Shaohua Li <shli@fb.com>
>
> We don't know if fallocate really supports FALLOC_FL_PUNCH_HOLE till
> fallocate is called. If it doesn't support, loop will return -EOPNOTSUPP
> and we see a lot of error message printed by blk_update_request. Failure
> for discard IO isn't a big problem, so we just return 0 in loop which
> will suppress the IO error message.

Setting RQF_QUIET for discard IO should be more clean for suppressing error,
and upper layer can get the failure notification too.

-- 
Ming Lei
