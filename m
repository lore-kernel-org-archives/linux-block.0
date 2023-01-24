Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10ACC05027
	for <linux-block@archiver.kernel.org>; Tue, 24 Jan 2023 01:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjAXBlc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Jan 2023 20:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjAXBlb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Jan 2023 20:41:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4E835252
        for <linux-block@vger.kernel.org>; Mon, 23 Jan 2023 17:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=1g8rJeVMlQ/HySUMtGPrVNB0AVWPc1UPUlwjLl3cAdM=; b=Sy5NNZHyXuEe14owLQ1OGzg5x3
        DIxOoJ0QtvWVGGOhiI1vhn8D5oYjnR2YEMwKAxquhpyfx1eLYjMVKYqEoptzL0ju8zDpQdltw/CA1
        gJ8bZCaZZOliHlpnkxEfk9/BHkYBwgn3NzdInqtZYcfui+aDyuFQjVlIEexo01Vr33id8796heQXM
        d/O4OPNtgCMRnPOPeKhhDOj/58XeV7JyEfVXAYdKAztN9fsXoxZ0hvLQnqk4e2pWG/6hbkdOxCWAT
        SCrim9G5GIrLg7EHc6K94AwaHQbrtilouBb+ilRDjUzmrJV0nSteYlSckRKpyFYWOeW2QeixCZMsY
        t4418MKw==;
Received: from 108-90-42-56.lightspeed.sntcca.sbcglobal.net ([108.90.42.56] helo=[192.168.1.80])
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pK8JM-004gKO-Tk; Tue, 24 Jan 2023 01:41:21 +0000
Message-ID: <aed3d64e-1209-0a28-2337-8d40b1a78d6c@infradead.org>
Date:   Mon, 23 Jan 2023 17:41:15 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] ps3vram: remove bio splitting
To:     Christoph Hellwig <hch@lst.de>, jim@jtan.com
Cc:     linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20230123074718.57951-1-hch@lst.de>
Content-Language: en-US
From:   Geoff Levand <geoff@infradead.org>
In-Reply-To: <20230123074718.57951-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Christoph,

On 1/22/23 23:47, Christoph Hellwig wrote:
> ps3vram iterates over the bio one segment, that is page aligned and max
> page sized chunk, a time.  Because of that there is no point in
> calling bio_split_to_limits, or explicitly setting the default limits
> that are only used by bio_split_to_limits.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/ps3vram.c | 7 -------
>  1 file changed, 7 deletions(-)

I tested this patch applied to the ps3-queue branch (v6.2-rc5 based) of my
kernel.org ps3-linux repo.  I could format the ps3vram device with ext4,
copy files to it, run fsck, etc.

Thanks for your effort.

Tested-by: Geoff Levand <geoff@infradead.org>

