Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9167C433F5
	for <linux-block@archiver.kernel.org>; Mon, 21 Feb 2022 19:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbiBUUAS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Feb 2022 15:00:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiBUUAR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Feb 2022 15:00:17 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5B1D22B29
        for <linux-block@vger.kernel.org>; Mon, 21 Feb 2022 11:59:53 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 3D99A1F43DDC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645473592;
        bh=s8nFRvn1fXk67BM20f1v0ZnyLtu2ZS71MAFad0ynIVg=;
        h=From:To:Cc:Subject:Date:From;
        b=OHPBq3kB3Mob3wA2Kn0Hdc5Gnc4FDfKyNMNyPG25pDjYj/j2TsY0Wey6wTMKdGXll
         rt9o7/o4HLC6jO3ev+MHAwH4wESP7wAVhVNLsSNX05ptRrMJbdZBPlvlxId6TIM6s5
         1spoU/Co/fe9kTLRyEn8u2iVB4Wgh0OvdS0ZjQ6qoY9YraI+wOBzl+ecjvDa06pFWH
         ktt1EBgV9WlN3b76Zof6+Q5psiWYzhuVDHSjMlaA6IoLrE6tYJ079bmqanJ4qjkyAE
         /FxNtS/fOnDHeInbq2S69FOk6Ne6rAN+E0GnzmDdmngL/rp3qQ2HOwntQ+Gs7u+Eyr
         8jsAZ/hONEwtg==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-block@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] block drivers in user space
Date:   Mon, 21 Feb 2022 14:59:48 -0500
Message-ID: <87tucsf0sr.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

I'd like to discuss an interface to implement user space block devices,
while avoiding local network NBD solutions.  There has been reiterated
interest in the topic, both from researchers [1] and from the community,
including a proposed session in LSFMM2018 [2] (though I don't think it
happened).

I've been working on top of the Google iblock implementation to find
something upstreamable and would like to present my design and gather
feedback on some points, in particular zero-copy and overall user space
interface.

The design I'm pending towards uses special fds opened by the driver to
transfer data to/from the block driver, preferably through direct
splicing as much as possible, to keep data only in kernel space.  This
is because, in my use case, the driver usually only manipulates
metadata, while data is forwarded directly through the network, or
similar. It would be neat if we can leverage the existing
splice/copy_file_range syscalls such that we don't ever need to bring
disk data to user space, if we can avoid it.  I've also experimented
with regular pipes, But I found no way around keeping a lot of pipes
opened, one for each possible command 'slot'.

[1] https://dl.acm.org/doi/10.1145/3456727.3463768
[2] https://www.spinics.net/lists/linux-fsdevel/msg120674.html

-- 
Gabriel Krisman Bertazi
