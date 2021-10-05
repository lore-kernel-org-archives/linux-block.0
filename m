Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB9CC433F5
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 15:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBB0A61502
	for <linux-block@archiver.kernel.org>; Tue,  5 Oct 2021 15:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbhJEPZ5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 5 Oct 2021 11:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235987AbhJEPZ4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 5 Oct 2021 11:25:56 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229F0C061753
        for <linux-block@vger.kernel.org>; Tue,  5 Oct 2021 08:24:06 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id b8so290650edk.2
        for <linux-block@vger.kernel.org>; Tue, 05 Oct 2021 08:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fho5LJ81wkyH+O6Iqe0gUmWGTziBAAGARJ143ZoXhG0=;
        b=4DDcaVFiHjZ0rr9OJGBaGeaDZLgVYCtpI8o5NyU8KsC858WuE9Qw5Xp0DVg8qv9lba
         bqdJrjNQWNCbg40VqwCYH/Ru7OfavwS/EHneTyujaEvGTC3t0+q36c1xXhFfJVJlpmtJ
         zJP44wyJiBiD5Gc9HOcj0VY/LlGsz2qxjqGjula/8MYWqR6lsfpUbRH27F9YIUqXXvLT
         Zc8NfjmCBfI1W03TN+Wlfs9xMa8nYHDQvvgNaj66yzVY6HsKEgBOyKMRcWe8mstRIJOr
         0saqm4qE5PAZfTKLlKvl2VEASoOir8F0cVq7CS4xre8yOzaTE9VuAT5SRgPqpj63BD/I
         yFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fho5LJ81wkyH+O6Iqe0gUmWGTziBAAGARJ143ZoXhG0=;
        b=XxX6gnsBhJK80YQB2cY3F9VK34S69aw9SEC1q9m6xMrhBEHKqEXBuQfpxzt3TvE+bk
         X8lN0UTGlwvBpz8oqasjNa5RaPh7r28sbdqaCvw+A36yNpw/Uh6ExBYtQGeuEQ33D13d
         aG1g/0l6n299zH4XcEgX/6GlQQoyd5IGapn9kRRT1tjKBnAiyspMKfcCo+R+4tX7Nha5
         F5VyMgR+pk4Q1/O/dV90razTpRZS0oAlrLPNz2LZqh1vjl4Tyic+0lKExVbSUxfu+kcg
         NeuIvAaLSCZ1+BVyINTKp74xqofgve0MQoVsm0gfpCmzdH+frTk4MhIyAl4pKjo1T+/x
         wE1Q==
X-Gm-Message-State: AOAM532BL5mIRrGmJDG5PbZ0H5/tl2drEDdyjVEHDMVy7mTXPZ8VXKau
        5lo8GJf40W+fvsclRseyE8wPr8/4QIfdAA2Mh620
X-Google-Smtp-Source: ABdhPJypXIkcE+Okx/EWDo4EhLxjARAHyNXvHzwHp3/vkw4HItuDYeMSDfocgpKIprC2JcHBuWMRIDdX90YJp6w2VPo=
X-Received: by 2002:a17:906:2cd6:: with SMTP id r22mr24714579ejr.398.1633447444742;
 Tue, 05 Oct 2021 08:24:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210809101609.148-1-xieyongji@bytedance.com> <20211004112623-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211004112623-mutt-send-email-mst@kernel.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 5 Oct 2021 23:24:04 +0800
Message-ID: <CACycT3t+uVaSRbW8-gmOV8o65XCthU_t-B1r1foh2ZiFixg5HA@mail.gmail.com>
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config space
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Oct 4, 2021 at 11:27 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Aug 09, 2021 at 06:16:09PM +0800, Xie Yongji wrote:
> > An untrusted device might presents an invalid block size
> > in configuration space. This tries to add validation for it
> > in the validate callback and clear the VIRTIO_BLK_F_BLK_SIZE
> > feature bit if the value is out of the supported range.
> >
> > And we also double check the value in virtblk_probe() in
> > case that it's changed after the validation.
> >
> > Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
>
> So I had to revert this due basically bugs in QEMU.
>
> My suggestion at this point is to try and update
> blk_queue_logical_block_size to BUG_ON when the size
> is out of a reasonable range.
>
> This has the advantage of fixing more hardware, not just virtio.
>

I wonder if it's better to just add a new patch to remove the
virtblk_validate() part. And the check of block size in
virtblk_probe() can be safely removed after the block layer is changed
to validate the block size.

Thanks,
Yongji
