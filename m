Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-it0-f67.google.com ([209.85.214.67]:37606 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750878AbdIITyH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Sep 2017 15:54:07 -0400
Received: by mail-it0-f67.google.com with SMTP id d6so2495490itc.4
        for <linux-block@vger.kernel.org>; Sat, 09 Sep 2017 12:54:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1f069ba0-19bf-a7b3-3a65-78f7f20ddc65@kernel.dk>
References: <1f069ba0-19bf-a7b3-3a65-78f7f20ddc65@kernel.dk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 9 Sep 2017 12:54:05 -0700
Message-ID: <CA+55aFwbmkTkPo5hgnDZ7aSKhUHZeec21wwcxCszZvrTgjaY7g@mail.gmail.com>
Subject: Re: [GIT PULL] Followup block pull request for 4.14-rc1
To: Jens Axboe <axboe@kernel.dk>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Fri, Sep 8, 2017 at 10:34 AM, Jens Axboe <axboe@kernel.dk> wrote:
>
> Single merge conflict here, for nvme/rdma. Trivial to fixup, see my
> for-next branch here:
>
> http://git.kernel.dk/cgit/linux-block/log/?h=for-next

Your earlier merge for mm/page_io.c is ugly, and mixes up the bi_disk
thing oddly in the middle of the task struct code.

Other than that, we match.

              Linus
