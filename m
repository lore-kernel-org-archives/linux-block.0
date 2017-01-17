Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34784 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751169AbdAQD4f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Jan 2017 22:56:35 -0500
MIME-Version: 1.0
From: Ming Lei <tom.leiming@gmail.com>
Date: Tue, 17 Jan 2017 11:56:21 +0800
Message-ID: <CACVXFVO2hPfu1G_ASzHLVvFgDdVR8HTNitGPVYRbq-ovMNabAw@mail.gmail.com>
Subject: [LSF/MM ATTEND] block: multipage bvec upstreaming & next step
To: lsf-pc@lists.linux-foundation.org,
        linux-block <linux-block@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Guys,

The multipage bvec patchset[1] has been posted out for a while, and
xfstest(ext4, xfs and btrfs) have been run and no regression is
observed, and I hope having talk about this in person would help
moving it forward.

Secondly I'd like to discuss with guys about the following next steps
of mp-bvec:

1) cleanup raid1/raid5/raid10 for removing the only singlepage bvec path
2) optimizing block layer with sort of 'complete' multipage bvec implementation
3) use multpage bvec direclty in some drivers
4) pass multipage segment from iov iterator helpers / get_user_pages()

Also I am intereted in Kirill's topic about THP for filesystem too.


[1] https://lkml.org/lkml/2017/1/15/266


Thanks,
Ming Lei
