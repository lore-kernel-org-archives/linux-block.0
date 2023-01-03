Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773ABC3DA7D
	for <linux-block@archiver.kernel.org>; Tue,  3 Jan 2023 20:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbjACUfS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Jan 2023 15:35:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjACUfP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Jan 2023 15:35:15 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF9213F26
        for <linux-block@vger.kernel.org>; Tue,  3 Jan 2023 12:35:15 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id DDBBD4BF;
        Tue,  3 Jan 2023 20:35:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net DDBBD4BF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1672778115; bh=Fldhr9NQzeQF48ej8J/wc9C6F5zuwb28IP8EzCxroJk=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ZNhLzsBopIoxZbDednfmT26aHZ1ieVWe8bcvrvu3oMCkVnmrHiqg8xJQeJhYXKecg
         REg862Dor0mq5UBXobED29xdPQFQw3hko7568z3jEyVVP31ylHHP013W8JQPvp7WLr
         TFce3y4hTY7rGFaYCJgk6DoXY8zLeKq0D0Zr8jy6jbM4zyRUZXVTbMXug4e1V25MLr
         +BzZxQRUgxDTSyRSvzQX/Bs5Caa7ibdl/xMaZvlx4c98txoloFCFO+jv5HAnYp/7HS
         EkOyxuH6X3Nt6fSHE32rtbFmRxP5riS64YZVNWrSDgJyGtQ7Dhi8gWd+7sFxYA52cp
         XF2NzjL7OeG8g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org,
        ZiyangZhang <ZiyangZhang@linux.alibaba.com>,
        Ming Lei <ming.lei@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH V3 6/6] ublk_drv: add mechanism for supporting
 unprivileged ublk device
In-Reply-To: <20221207123305.937678-7-ming.lei@redhat.com>
References: <20221207123305.937678-1-ming.lei@redhat.com>
 <20221207123305.937678-7-ming.lei@redhat.com>
Date:   Tue, 03 Jan 2023 13:35:14 -0700
Message-ID: <87a62ze4ql.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I have one quick question...

Ming Lei <ming.lei@redhat.com> writes:

> In case of UBLK_F_UNPRIVILEGED_DEV:
>
> 1) for command UBLK_CMD_ADD_DEV, it is always allowed, and user needs
> to provide owner's uid/gid in this command, so that udev can set correct
> ownership for the created ublk device, since the device owner uid/gid
> can be queried via command of UBLK_CMD_GET_DEV_INFO.

Why do you have the user provide the uid/gid rather than just using the
user's credentials directly?  It seems a bit strange to me to let
unprivileged users create devices with arbitrary ownership.  What am I
missing here?

Thanks,

jon
