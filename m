Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AB8C433EF
	for <linux-block@archiver.kernel.org>; Tue,  1 Mar 2022 09:41:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiCAJl6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Mar 2022 04:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233953AbiCAJlz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Mar 2022 04:41:55 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5822A8B6C4
        for <linux-block@vger.kernel.org>; Tue,  1 Mar 2022 01:41:13 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id h16so17755012iol.11
        for <linux-block@vger.kernel.org>; Tue, 01 Mar 2022 01:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MU2HWPXy4mAk2gUeuMPfPjZpOmd7MfczuTjNa/BKYeM=;
        b=J5tf+w9wJrpI84ECFWJeCND7fgEugL1Y44J/PeJZI5J8YWiyX+HtHV4sQLIs8Lv9MP
         AiUX5b0cP+UUp70Ks5gg6JCXGhXNEB31VGMNwDkGqc4ab+pW5kH6WmTWwpL+CKmhYNqt
         hYeXF8Y3fWhW9T+GCnaXz+kYm7c1vnceiDEm4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MU2HWPXy4mAk2gUeuMPfPjZpOmd7MfczuTjNa/BKYeM=;
        b=dOP4IeU4kBQH7irp0KOw0kAvu/wLFZJ+bWHAdMwsbh0u098L4uubTmJjWBwq+s70zs
         2TFC9y2BH1plJjI+WKT07hYxKdGlWyfC9hKN/uCT+UtC3m5D+H4wBfEWzfBPIAGa08zP
         fi6kPqh68dv6qFyVjutD6acvSv/Mjtxu4SwS4HQRLzUyCxq4xMhYNoM5q1ZspDKbpi7Y
         IWuGY/X9tNMYEQ8XUhhDKl4GOZxPNNAzdHcWSAJMqq0XLixURbfOUFDXcl9sWUlFDarD
         XjRNNBc4qTENUW/rpm7/w2m65ZJAhf0BoLV6Tf6YdN4C2kl3Z1CfljdZRfqSyJ+oPJ4h
         FWcQ==
X-Gm-Message-State: AOAM532FN8pFzgmvtkO2gVLDj4oGs+xsn4kogG3lZKJgYRwKxNqOCcgR
        UgiMO7KWgtiGoYjzl5YW6+aXGqJMUaYRSNksy3SS7w==
X-Google-Smtp-Source: ABdhPJxj9kVmLDPb5TzfYODF4nrClsQQz+30NgAHek1PNbHF0Q1C9hdcWEyqYC4IdVu0LWbB+6deHxoZYu2hC0zKG8s=
X-Received: by 2002:a02:95a2:0:b0:30f:61cc:346f with SMTP id
 b31-20020a0295a2000000b0030f61cc346fmr20276611jai.273.1646127672760; Tue, 01
 Mar 2022 01:41:12 -0800 (PST)
MIME-Version: 1.0
References: <20220227093434.2889464-1-jhubbard@nvidia.com> <20220227093434.2889464-7-jhubbard@nvidia.com>
 <CAJfpegsDkpdCQiPmfKfX_b4-bkkj5N5vRhseifEH6woJ7r0S6A@mail.gmail.com> <f0b158dc-5b01-67aa-1f49-331bf1ff2bfd@nvidia.com>
In-Reply-To: <f0b158dc-5b01-67aa-1f49-331bf1ff2bfd@nvidia.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 1 Mar 2022 10:41:01 +0100
Message-ID: <CAJfpegvcX4n3Ac5ekNNKGRh-cDGjSjX3CuS7+SOWvfksii-UEw@mail.gmail.com>
Subject: Re: [PATCH 6/6] fuse: convert direct IO paths to use FOLL_PIN
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     jhubbard.send.patches@gmail.com, Jens Axboe <axboe@kernel.dk>,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <dchinner@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs <linux-xfs@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, 28 Feb 2022 at 22:16, John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 2/28/22 07:59, Miklos Szeredi wrote:
> > On Sun, 27 Feb 2022 at 10:34, <jhubbard.send.patches@gmail.com> wrote:
> >>
> >> From: John Hubbard <jhubbard@nvidia.com>
> >>
> >> Convert the fuse filesystem to support the new iov_iter_get_pages()
> >> behavior. That routine now invokes pin_user_pages_fast(), which means
> >> that such pages must be released via unpin_user_page(), rather than via
> >> put_page().
> >>
> >> This commit also removes any possibility of kernel pages being handled,
> >> in the fuse_get_user_pages() call. Although this may seem like a steep
> >> price to pay, Christoph Hellwig actually recommended it a few years ago
> >> for nearly the same situation [1].
> >
> > This might work for O_DIRECT, but fuse has this mode of operation
> > which turns normal "buffered" I/O into direct I/O.  And that in turn
> > will break execve of such files.
> >
> > So AFAICS we need to keep kvec handing in some way.
> >
>
> Thanks for bringing that up! Do you have any hints for me, to jump start

How about just leaving that special code in place?   It bypasses page
refs and directly copies to the kernel buffer, so it should not have
any affect on the user page code.

> a deeper look? And especially, sample programs that exercise this?

Here's one:
# uncomment as appropriate:
#sudo dnf install fuse3-devel
#sudo apt install libfuse3-dev

cat <<EOF > fuse-dio-exec.c
#define FUSE_USE_VERSION 31
#include <fuse.h>
#include <errno.h>
#include <unistd.h>

static const char *filename = "/bin/true";

static int test_getattr(const char *path, struct stat *stbuf,
             struct fuse_file_info *fi)
{
    return lstat(filename, stbuf) == -1 ? -errno : 0;
}

static int test_open(const char *path, struct fuse_file_info *fi)
{
    int res;

    res = open(filename, fi->flags);
    if (res == -1)
        return -errno;

    fi->fh = res;
    fi->direct_io = 1;
    return 0;
}

static int test_read(const char *path, char *buf, size_t size, off_t offset,
              struct fuse_file_info *fi)
{
    int res = pread(fi->fh, buf, size, offset);
    return res == -1 ? -errno : res;
}

static int test_release(const char *path, struct fuse_file_info *fi)
{
    close(fi->fh);
    return 0;
}

static const struct fuse_operations test_oper = {
    .getattr    = test_getattr,
    .open        = test_open,
    .release    = test_release,
    .read        = test_read,
};

int main(int argc, char *argv[])
{
    return fuse_main(argc, argv, &test_oper, NULL);
}
EOF

gcc -W fuse-dio-exec.c `pkg-config fuse3 --cflags --libs` -o fuse-dio-exec
touch /tmp/true

#run test:
./fuse-dio-exec /tmp/true
/tmp/true
umount /tmp/true
