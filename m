Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qt0-f194.google.com ([209.85.216.194]:49525 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751823AbdJGVqv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 7 Oct 2017 17:46:51 -0400
Received: by mail-qt0-f194.google.com with SMTP id k31so1866708qta.6
        for <linux-block@vger.kernel.org>; Sat, 07 Oct 2017 14:46:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170919221111.18549-1-colyli@suse.de>
References: <20170919221111.18549-1-colyli@suse.de>
From: Michael Lyle <mlyle@lyle.org>
Date: Sat, 7 Oct 2017 14:46:50 -0700
Message-ID: <CAJ+L6qdpS8ncKTB+5HS1yuHijd6gK_KfdqvDNEgPypYOnfatgA@mail.gmail.com>
Subject: Re: [PATCH] bcache: check ca->alloc_thread initialized before wake up it
To: Coly Li <colyli@suse.de>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Sep 19, 2017 at 3:11 PM, Coly Li <colyli@suse.de> wrote:
> In bcache code, sysfs entries are created before all resources get
> allocated, e.g. allocation thread of a cache set.
>
> There is posibility for NULL pointer deference if a resource is accessed
> but which is not initialized yet. Indeed Jorg Bornschein catches one on
> cache set allocation thread and gets a kernel oops.
> Signed-off-by: Coly Li <colyli@suse.de>
> Reported-by: Jorg Bornschein <jb@capsec.org>
> Cc: Kent Overstreet <kent.overstreet@gmail.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Michael Lyle <mlyle@lyle.org>
