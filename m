Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f48.google.com ([74.125.83.48]:40966 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424337AbdKRRBO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 18 Nov 2017 12:01:14 -0500
Received: by mail-pg0-f48.google.com with SMTP id p9so4206165pgc.8
        for <linux-block@vger.kernel.org>; Sat, 18 Nov 2017 09:01:13 -0800 (PST)
Subject: Re: [RFC] bcache: fix a circular dead locking with dc->writeback_lock
 and bch_register_lock
To: Coly Li <colyli@suse.de>, linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org
References: <20171118081415.49669-1-colyli@suse.de>
From: Michael Lyle <mlyle@lyle.org>
Message-ID: <a64160cc-f008-3732-4c95-818368614cbb@lyle.org>
Date: Sat, 18 Nov 2017 09:01:11 -0800
MIME-Version: 1.0
In-Reply-To: <20171118081415.49669-1-colyli@suse.de>
Content-Type: text/plain; charset=utf-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Coly--

It's a real circular lock dep between registration (a very rare
operation) and writeback rate calculation (a fairly rare operation).
While it's definitely a real issue, it's a very unlikely one to be
actually encountered.

(Encountering it requires the every-5-second periodic task of
calculating writeback to be running, between writeback lock and register
lock [a pretty short window], and then for the user to register a new
cached volume)

This particular issue was introduced in a8394090a9129b40f9 ("bcache:
correct cache_dirty_target in __update_writeback_rate()") as part of
4.14. I'm concerned that if we keep putting in small local patches like
this (especially to lock ordering or registration/deregistration
behavior) that we're just moving problems around.

I'm planning on working on the writeback lock this cycle to make it less
contended.  As part of this I plan to audit overall lock order, and to
broaden use of the registration lock to better control reg/dereg
ordering.  That is, there's already going to be a lot of change in this
path and I hope to catch/fix a lot of issues like this.

Mike
