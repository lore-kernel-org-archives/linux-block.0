Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBC2C433EF
	for <linux-block@archiver.kernel.org>; Mon, 21 Feb 2022 23:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbiBUXa4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Feb 2022 18:30:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiBUXa4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Feb 2022 18:30:56 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 642E024F30
        for <linux-block@vger.kernel.org>; Mon, 21 Feb 2022 15:30:31 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 5CB861F43EDD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645486229;
        bh=al3grlSIwr0KO5eIfyvtNPHZvzUCo7rmWPjNoVxQgIo=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=ApRjBUvCqrR0hj9ATDP9Gz+XIs3tjxfOTJLAfhFYfRnU0Ueue9zqXZO9fCpzPyomP
         NbPpo7E+BAMDfyI9DxZNBRQoN32Tt7ZUxJx69VvsohBUmjX9hq8X40uUo0r+J3Xck/
         T36CYBxe1gIDVeK0GNpbM1Qkn3wIen4oTzvnTGMprtG4d5XAfkRQGUWknJWUcUMBVN
         zcZy354fh3scF9pJv6LZj3+EFMN4rWR/ibR2VtZ+bZPQJkOcTf4bWPzGJv26htZwU7
         J16PXg85mfvcsE73hPnQ/o+wLfRZrr2//rsL8n4gvCOSpJqiQXhCZzjmRPXtRBoU1q
         grGiLAuYuVg/A==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] block drivers in user space
Organization: Collabora
References: <87tucsf0sr.fsf@collabora.com>
        <18da367b-bbe1-c591-358e-6f8111a90eaf@opensource.wdc.com>
Date:   Mon, 21 Feb 2022 18:30:25 -0500
In-Reply-To: <18da367b-bbe1-c591-358e-6f8111a90eaf@opensource.wdc.com> (Damien
        Le Moal's message of "Tue, 22 Feb 2022 08:16:21 +0900")
Message-ID: <87fsobg5m6.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Damien Le Moal <damien.lemoal@opensource.wdc.com> writes:

> On 2/22/22 04:59, Gabriel Krisman Bertazi wrote:
>> I'd like to discuss an interface to implement user space block devices,
>> while avoiding local network NBD solutions.  There has been reiterated
>> interest in the topic, both from researchers [1] and from the community,
>> including a proposed session in LSFMM2018 [2] (though I don't think it
>> happened).
>> 
>> I've been working on top of the Google iblock implementation to find
>> something upstreamable and would like to present my design and gather
>> feedback on some points, in particular zero-copy and overall user space
>> interface.
>> 
>> The design I'm pending towards uses special fds opened by the driver to
>> transfer data to/from the block driver, preferably through direct
>> splicing as much as possible, to keep data only in kernel space.  This
>> is because, in my use case, the driver usually only manipulates
>> metadata, while data is forwarded directly through the network, or
>> similar. It would be neat if we can leverage the existing
>> splice/copy_file_range syscalls such that we don't ever need to bring
>> disk data to user space, if we can avoid it.  I've also experimented
>> with regular pipes, But I found no way around keeping a lot of pipes
>> opened, one for each possible command 'slot'.
>> 
>> [1] https://dl.acm.org/doi/10.1145/3456727.3463768
>
> This is $15 for non ACM members... Any public download available ?


Hi Damien,

Yes. Sorry for the ACM link.  yuck.  One of the authors published the
paper here:

https://rgmacedo.github.io/files/2021/systor21-bdus/bdus-paper.pdf

>
>> [2] https://www.spinics.net/lists/linux-fsdevel/msg120674.html
>> 

-- 
Gabriel Krisman Bertazi
