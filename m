Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64CE0C43217
	for <linux-block@archiver.kernel.org>; Thu,  3 Mar 2022 00:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiCCAAz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:00:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiCCAAw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 2 Mar 2022 19:00:52 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514C14E3AD
        for <linux-block@vger.kernel.org>; Wed,  2 Mar 2022 16:00:04 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id B935E1F447C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1646262253;
        bh=kCGdmb3Zl8LmQYTtv4iaRAdRVGxPo2kdF0JrVOMn1ek=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ETjYzzTaVrp37XmpJS0G0V8CSyUFQFXBuH8aJ74w6P3h9XzbBxQdppdMvF4mP/0bB
         JsiweFdlOqDD3z/Zffg21OWxgnxioFrRL/TJ/zHbUNJ7vD5MnI/syYhX6yL0Ki1+ZM
         BVcGFQh7KDYcNyZTBn25eqlkgpOxQrOZMwu3oSqY1eIAmpdgDlorAYI2r86vfHcHri
         dQIw5M6YukYQahAylyzdn6VtTAVsaOsrx1nFgGQU0xkRy3+vrVnnKRvl+2d9qfBnvb
         DQ3woOfEeGLREBs1eAGc0emV284DQLiRZogI20KTZ06LnqxMKQSTCxMUP4iQCGvuty
         5aEIbywI2nSHA==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Organization: Collabora
References: <87tucsf0sr.fsf@collabora.com>
        <986caf55-65d1-0755-383b-73834ec04967@suse.de>
Date:   Wed, 02 Mar 2022 18:04:08 -0500
In-Reply-To: <986caf55-65d1-0755-383b-73834ec04967@suse.de> (Hannes Reinecke's
        message of "Tue, 22 Feb 2022 07:57:27 +0100")
Message-ID: <87tucgj6s7.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hannes Reinecke <hare@suse.de> writes:

> Actually, I'd rather have something like an 'inverse io_uring', where an
> application creates a memory region separated into several 'ring' for 
> submission and completion.
> Then the kernel could write/map the incoming data onto the rings, and
> application can read from there.
> Maybe it'll be worthwhile to look at virtio here.

>
> But in either case, using fds or pipes for commands doesn't really
> scale, as the number of fds is inherently limited. And using fds 
> restricts you to serial processing (as you can read only sequentially
> from a fd); with mmap() you'll get a greater flexibility and the option 
> of parallel processing.

Hannes,

I'm not trying to push an fd implementation, and seems clear that
io_uring is the right way to go.  But isn't fd virtually unlimited,
as they can be extended up to procfs's file-max for a specific user?

Also, I was proposing one fd per IO operation, so each request data is
independent.  But, even within each IO, it doesn't necessarily need to
be sequential.  Isn't pread/pwrite parallel on the same fd?

A FD-based implementation could also use existing io_uring operations,
IORING_OP_READV/IORING_OP_WRITEV, against the file descriptor.

-- 
Gabriel Krisman Bertazi
