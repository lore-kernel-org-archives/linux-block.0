Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-qk0-f178.google.com ([209.85.220.178]:40042 "EHLO
        mail-qk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932903AbeB1QNu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Feb 2018 11:13:50 -0500
Received: by mail-qk0-f178.google.com with SMTP id o25so3622919qkl.7
        for <linux-block@vger.kernel.org>; Wed, 28 Feb 2018 08:13:49 -0800 (PST)
Date: Wed, 28 Feb 2018 08:13:45 -0800
From: Tejun Heo <tj@kernel.org>
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-block@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        kernel-team@fb.com
Subject: Re: [PATCH 0/2] block: sbitmap tweaks
Message-ID: <20180228161345.GH24003@devbig577.frc2.facebook.com>
References: <cover.1519779182.git.osandov@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1519779182.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On Tue, Feb 27, 2018 at 04:56:41PM -0800, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> Two fixlets inspired by Tejun's patch
> (https://patchwork.kernel.org/patch/10226749/). Patch 2 is what we
> discussed on that patch, patch 1 is a small preparation.
> 
> Omar Sandoval (2):
>   block: clear ctx pending bit under ctx lock
>   sbitmap: use test_and_set_bit_lock()/clear_bit_unlock()

FWIW,

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
