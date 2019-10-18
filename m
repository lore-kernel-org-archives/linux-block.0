Return-Path: <SRS0=h0yA=YL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85DDECA9EA0
	for <linux-block@archiver.kernel.org>; Fri, 18 Oct 2019 14:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AA15222C3
	for <linux-block@archiver.kernel.org>; Fri, 18 Oct 2019 14:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="C1Bhufnz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390628AbfJROew (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Oct 2019 10:34:52 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38508 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729584AbfJROew (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Oct 2019 10:34:52 -0400
Received: by mail-ot1-f67.google.com with SMTP id e11so5140494otl.5
        for <linux-block@vger.kernel.org>; Fri, 18 Oct 2019 07:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g6+4JoLiL6V1SIjZNTIuRSfTBNPVVCRxDn3tmyCRlmo=;
        b=C1BhufnzjmOHHgXIpYOcKg5ZqQHol5zirz43o6d92AwgmLqBEAgUl94ya6SZ/Nv0Mz
         t6Q6YzpBBzg1TthXZarSRy/P9jTRR9CXHhXPfRjl6wCNmoCAvzjXYmPIq4E7jxm45WKH
         TB8Tt2YOF5QPmT/UfJWsVi0rrFi/r/jJ2XEAA95LUgLzfI6dpZPYY7jmf0YncFzCVypV
         6+n4Sf0YWLhyb6YjAGb7DNOCnzDXWrwq1QctFJd9sOSUkA5mR+pxLvIZV3IE82woFkR3
         b7c3Zy1bpiwY0U71+1swvjgO9wnqwviEjHGzoLsLoLqeXvmurFomSsd6bZ6ELtovTNsP
         5wIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g6+4JoLiL6V1SIjZNTIuRSfTBNPVVCRxDn3tmyCRlmo=;
        b=cYjx+j1EH9Ix8myWNP82+xPaPMRQj6DumujaB7xFd+b9ElJjeIWL/rywb8qlw3AY6J
         e3GMtqZKIOODGFE/eLrhGYoBShr723HtD36uRkubkue14c0jpl8j2uRG3f0qmXWny93q
         UasPCchKfL0TnBsXAYOPlHxtNTxdDs+pVQnBr1JsAf7Dqk+ry+pLQIQUMVe02fisea0O
         t0qsk5F+xH4ORW0CQ/rZKY7MX+lSnFNJCV7ufl8Jwgw8GXKKp9xdrKwBlf2QgRLJMxbN
         BfgW8DthNAKSPi8+WIjKZRvMl7q+pO/zVM13w60TIhnQgrx0613LDevbiMOopFkH5oWh
         54DA==
X-Gm-Message-State: APjAAAVV3la0FKua17vxv/DVCEB58y8iCGZ2+C9Eb/8DLtRorrSuypia
        F55KMfk3PboQhXeLEpaHgoAfL5Su9FKDw1KVE2PkHDyFn7YZ/w==
X-Google-Smtp-Source: APXvYqx6js4H+AAPnP9YXQ0hOrdC+Cpx+YlkpA6KeQoOe7TITs2E6oq6h0lpoUSjbzL6njcFTeIGU4EiHAloVz82aIA=
X-Received: by 2002:a9d:19ee:: with SMTP id k101mr8131972otk.183.1571409291178;
 Fri, 18 Oct 2019 07:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <20191017212858.13230-1-axboe@kernel.dk> <20191017212858.13230-2-axboe@kernel.dk>
 <CAG48ez0G2y0JS9=S2KmePO3xq-5DuzgovrLFiX4TJL-G897LCA@mail.gmail.com> <0fb9d9a0-6251-c4bd-71b0-6e34c6a1aab8@kernel.dk>
In-Reply-To: <0fb9d9a0-6251-c4bd-71b0-6e34c6a1aab8@kernel.dk>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 18 Oct 2019 16:34:24 +0200
Message-ID: <CAG48ez181=JoYudXee0KbU0vDZ=EbxmgB7q0mmjaA0gyp6MFBQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] io_uring: add support for async work inheriting files table
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 18, 2019 at 4:01 PM Jens Axboe <axboe@kernel.dk> wrote:
> On 10/17/19 8:41 PM, Jann Horn wrote:
> > On Fri, Oct 18, 2019 at 4:01 AM Jens Axboe <axboe@kernel.dk> wrote:
> >> This is in preparation for adding opcodes that need to modify files
> >> in a process file table, either adding new ones or closing old ones.
[...]
> Updated patch1:
>
> http://git.kernel.dk/cgit/linux-block/commit/?h=for-5.5/io_uring-test&id=df6caac708dae8ee9a74c9016e479b02ad78d436

I don't understand what you're doing with old_files in there. In the
"s->files && !old_files" branch, "current->files = s->files" happens
without holding task_lock(), but current->files and s->files are also
the same already at that point anyway. And what's the intent behind
assigning stuff to old_files inside the loop? Isn't that going to
cause the workqueue to keep a modified current->files beyond the
runtime of the work?
