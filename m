Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f193.google.com ([209.85.220.193]:45897 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750941AbeCPSoY (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Mar 2018 14:44:24 -0400
Received: by mail-qk0-f193.google.com with SMTP id s9so12056880qke.12
        for <linux-block@vger.kernel.org>; Fri, 16 Mar 2018 11:44:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180315150814.9412-9-bart.vanassche@wdc.com>
References: <20180315150814.9412-1-bart.vanassche@wdc.com> <20180315150814.9412-9-bart.vanassche@wdc.com>
From: Michael Lyle <mlyle@lyle.org>
Date: Fri, 16 Mar 2018 11:44:23 -0700
Message-ID: <CAJ+L6qfH9FSx6kFh2mz5AjyOH8RLS=7jqaYnA0UVyiQCTaWCYw@mail.gmail.com>
Subject: Re: [PATCH 08/16] bcache: Fix a compiler warning in bcache_device_init()
To: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Kent Overstreet <kent.overstreet@gmail.com>,
        Coly Li <colyli@suse.de>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        linux-bcache <linux-bcache@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Thu, Mar 15, 2018 at 8:08 AM, Bart Van Assche <bart.vanassche@wdc.com> wrote:
> Avoid that building with W=1 triggers the following compiler warning:
>
> drivers/md/bcache/super.c:776:20: warning: comparison is always false due to limited range of data type [-Wtype-limits]
>       d->nr_stripes > SIZE_MAX / sizeof(atomic_t)) {
>                     ^
>
> Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>

LGTM, applying.
