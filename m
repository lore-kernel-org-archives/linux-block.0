Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f180.google.com ([209.85.216.180]:38316 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754627AbeAHR6D (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jan 2018 12:58:03 -0500
Received: by mail-qt0-f180.google.com with SMTP id d4so14632391qtj.5
        for <linux-block@vger.kernel.org>; Mon, 08 Jan 2018 09:58:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1515379587-21540-1-git-send-email-tang.junhui@zte.com.cn>
References: <1515379587-21540-1-git-send-email-tang.junhui@zte.com.cn>
From: Michael Lyle <mlyle@lyle.org>
Date: Mon, 8 Jan 2018 09:58:02 -0800
Message-ID: <CAJ+L6qe=Roiswb7DfRtCGk=FnE4JG9vesyVy6OyT8Ex+GgDTcA@mail.gmail.com>
Subject: Re: [PATCH v3] bcache: fix writeback target calc on large devices
To: Junhui Tang <tang.junhui@zte.com.cn>
Cc: linux-bcache <linux-bcache@vger.kernel.org>,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Tang Junhui--

Thanks for your feedback, help, and flexibility.  I will try to make
this better overall in the long term.

On Sun, Jan 7, 2018 at 6:46 PM,  <tang.junhui@zte.com.cn> wrote:

> OK, please replace 16384 with macro, and replease 16384 * bdev_sectors(dc->bdev)
> with bit shift operation, eg: bdev_sectors(dc->bdev)<<MACRO.
>
> Reviewed-by: Tang Junhui <tang.junhui@zte.com.cn>

I have pulled this into bcache-for-next and will be testing it all
some today, hopefully to send out to linux-block/Jens late
today/tomorrow.

Mike
