Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32E7C433EF
	for <linux-block@archiver.kernel.org>; Sat, 16 Oct 2021 22:57:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEA0760FDC
	for <linux-block@archiver.kernel.org>; Sat, 16 Oct 2021 22:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241083AbhJPW7J (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 18:59:09 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:49527 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236447AbhJPW7I (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 18:59:08 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 8ABDA32008FD;
        Sat, 16 Oct 2021 18:56:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 16 Oct 2021 18:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=8i8WYj
        DIhrEQ0/Z8Qo0Op4UPbrZU2DIMxgjvejckIBc=; b=BfapxsJ0bcWBiiMyrx4twu
        XeBl/pdeG1nrIqkYC4yI9BpfwEGlQtBQrKDUbTgWU33Gyk5GG3BQphH0g9STXAWB
        MqFrfj2oJ9qL3Q8GGqEOu0QmF5oDhIpABBcS01VLtHWIzesz6UGGI4iXAGls6hhE
        XdzGmtqAyC3XvgH44fj0Tg3qS9VnuUo4Bmp/xl7XEPD4lMxMqX+zQsRa9ulC4oZ/
        GNYRpi7jAAf6/DjljhTGPyE9uVQcY3+o0lN2Ddgi1cvircBXvR9BqoE1TPNnJzUZ
        /yqoeSS5lwJyBTN5qUtverX3RpBA09VZEcKPwtNargUHUEIBitw88dPG0MiasXwA
        ==
X-ME-Sender: <xms:tlhrYfFFWDOcyUg_oxThSOz-R0FfRmS4Ho294lolHw9tng8gQ39rAg>
    <xme:tlhrYcVpjuuxmlNzTfZzV8rVSYgXHFCohqVXZTbg1JHw-ixfaAgAvsBrK98_5G-Tn
    a_t6t1AKA1pzLjIucc>
X-ME-Received: <xmr:tlhrYRJfpo248QT0QVXX9LhCMrw6EousjxxedjsNgH0eJ7xFXcPchihzYmH_rlsrzRZPUidDyp2OFLH1__9ltVnq0eV8H0UVy9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddujedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffujgfkfhggtgesthdtredttddtvdenucfhrhhomhephfhinhhnucfv
    hhgrihhnuceofhhthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgheqnecuggftrfgrth
    htvghrnhepffduhfegfedvieetudfgleeugeehkeekfeevfffhieevteelvdfhtdevffet
    uedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfh
    hthhgrihhnsehlihhnuhigqdhmieekkhdrohhrgh
X-ME-Proxy: <xmx:tlhrYdESvE5EaxJgxwyrItOZzTJWbp-asn32TmOMUeC0rCvoilv4PQ>
    <xmx:tlhrYVWN61Egm482Qg4TeWFK3OtkcpXSypGrz5JuYIu6EN5T5BtFUQ>
    <xmx:tlhrYYMniANn5AKq3XKoD8SAja5eAzT6iWrSRPlC-F_p7YML_d-_zg>
    <xmx:t1hrYSgQOdFrloqMxksNreferwG3IwCJIz43ghulcRCBjQ7MJFpKDQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Oct 2021 18:56:52 -0400 (EDT)
Date:   Sun, 17 Oct 2021 09:56:52 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     linux-block@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH] ataflop: unlock ataflop_probe_lock at
 atari_floppy_init()
In-Reply-To: <1d9351dc-baeb-1a54-625c-04ce01b009b0@i-love.sakura.ne.jp>
Message-ID: <84fe74c6-9174-695b-563d-6ccbfa69ccd@linux-m68k.org>
References: <1d9351dc-baeb-1a54-625c-04ce01b009b0@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, 16 Oct 2021, Tetsuo Handa wrote:

> Commit bf9c0538e485b591 ("ataflop: use a separate gendisk for each media
> format") introduced ataflop_probe_lock mutex, but forgot to unlock the
> mutex when atari_floppy_init() (i.e. module loading) succeeded. If
> ataflop_probe() is called, it will deadlock on ataflop_probe_lock mutex.
> 
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Fixes: bf9c0538e485b591 ("ataflop: use a separate gendisk for each media format")
> ---
> To m68k users
> 
>   This patch suggests that nobody is testing this module using a real hardware.
>   Can somebody test this module?
>   Is current m68k hardware still supporting Atari floppy?
>   If Atari floppy is no longer supported, do we still need this module?
> 

It is only to be expected that no-one would have reported this bug yet.

2 months ago, Debian 11 shipped with a 5.10 kernel, but the bug you found 
first appeared in Linux 5.11.

The existence of buggy drivers in mainline is undesirable but the real 
problem here is the rate at which new bugs get added.

So I wonder if it would have been possible to use Aranym to find the 
regression, or avoid it in the first place?
