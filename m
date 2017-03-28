Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:32900 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753806AbdC1CxG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2017 22:53:06 -0400
Received: by mail-pg0-f51.google.com with SMTP id n5so50844504pgh.0
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2017 19:53:05 -0700 (PDT)
Date: Mon, 27 Mar 2017 19:52:13 -0700
From: Omar Sandoval <osandov@osandov.com>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com
Subject: Re: [PATCH 2/2] block: fix leak of q->rq_wb
Message-ID: <20170328025213.GA3451@vader>
References: <de751892a392533e8e26fffbf72ba7904cfda468.1490636543.git.osandov@fb.com>
 <d6f2baa4f64dce04da94a649d080acdaaf7d6b57.1490636543.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <d6f2baa4f64dce04da94a649d080acdaaf7d6b57.1490636543.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Mon, Mar 27, 2017 at 10:43:59AM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> CONFIG_DEBUG_TEST_DRIVER_REMOVE found a possible leak of q->rq_wb in a
> couple of cases: when a request queue is reregistered and when gendisks
> share a request_queue. This has been a problem since wbt was introduced,
> but the WARN_ON(!list_empty(&stats->callbacks)) in the blk-stat rework
> exposed it. The fix is unfortunately a hack until we fix all of the
> drivers sharing a request_queue.

FYI, I went through the remaining cases and fixed most of them up,
working on the remaining few. Maybe we can finally put this crap to
rest...
