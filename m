Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:35411 "EHLO
        mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752037AbdC0MEc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2017 08:04:32 -0400
Received: by mail-vk0-f49.google.com with SMTP id r69so48366309vke.2
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2017 05:04:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1490381059.3312.15.camel@sandisk.com>
References: <20170324123621.5227-1-tom.leiming@gmail.com> <20170324123621.5227-3-tom.leiming@gmail.com>
 <1490376267.3312.1.camel@sandisk.com> <CACVXFVN7_PovXhKFofqf7N99Fq6RHEtFojHzwc6AN1oEpFLYxA@mail.gmail.com>
 <1490381059.3312.15.camel@sandisk.com>
From: Ming Lei <tom.leiming@gmail.com>
Date: Mon, 27 Mar 2017 19:31:13 +0800
Message-ID: <CACVXFVPhqvypq--2uq7UctM-SkvpNK2dQoC5a=0MShBvirQxtA@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] block: add a read barrier in blk_queue_enter()
To: Bart Van Assche <Bart.VanAssche@sandisk.com>
Cc: "hch@infradead.org" <hch@infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "hare@suse.de" <hare@suse.de>, "axboe@fb.com" <axboe@fb.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Sat, Mar 25, 2017 at 2:45 AM, Bart Van Assche
<Bart.VanAssche@sandisk.com> wrote:
> On Sat, 2017-03-25 at 01:38 +0800, Ming Lei wrote:
>> As I explained, the dying flag should only be mentioned after we change
>> the code in blk_set_queue_dying().
>
> Hello Ming,
>
> If patches 2 and 4 would be combined into a single patch then it wouldn't
> be necessary anymore to update the comment introduced in patch 2 in patch 4.
> I think that would make this patch series easier to review.

I think it is better to not do that, because we know patch 2 and patch
4 are doing
two different things, and patch 2 can be thought as one fix, but patch 4 should
be a improvement.  And it is normal to update comment after code changes.

>
> Since the issues fixed by your patches are longstanding issues, have you
> considered to add a "Cc: stable" tag?

I don't know because there isn't real report, and maybe never, so I leave it
alone.


Thanks,
Ming Lei
