Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f177.google.com ([209.85.220.177]:55346 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753612AbdJPRj0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Oct 2017 13:39:26 -0400
Received: by mail-qk0-f177.google.com with SMTP id x82so13852802qkb.12
        for <linux-block@vger.kernel.org>; Mon, 16 Oct 2017 10:39:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170921195458.53890-1-colyli@suse.de>
References: <20170921195458.53890-1-colyli@suse.de>
From: Michael Lyle <mlyle@lyle.org>
Date: Mon, 16 Oct 2017 10:39:25 -0700
Message-ID: <CAJ+L6qdqn1i=UFJcaO+xQzgZj_o5RNm71XhnSznrtMqt0P5Tew@mail.gmail.com>
Subject: Re: [PATCHv3] bcache: only permit to recovery read error when cache
 device is clean
To: Coly Li <colyli@suse.de>
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Nix <nix@esperi.org.uk>, Kai Krakow <hurikhan77@gmail.com>,
        Eric Wheeler <bcache@lists.ewheeler.net>,
        Junhui Tang <tang.junhui@zte.com.cn>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hey Coly--

On Thu, Sep 21, 2017 at 12:54 PM, Coly Li <colyli@suse.de> wrote:
> When bcache does read I/Os, for example in writeback or writethrough mode,
> if a read request on cache device is failed, bcache will try to recovery
> the request by reading from cached device. If the data on cached device is
> not synced with cache device, then requester will get a stale data.
[...]
> +       if (s->recoverable &&
> +           (dc && !atomic_read(&dc->has_dirty)) {

Looks like this is missing a parens.

Thx,

Mike
