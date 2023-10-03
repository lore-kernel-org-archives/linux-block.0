Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF71E8FDB4
	for <linux-block@archiver.kernel.org>; Tue,  3 Oct 2023 20:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjJCUkQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 3 Oct 2023 16:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjJCUkP (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 3 Oct 2023 16:40:15 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8D7AC
        for <linux-block@vger.kernel.org>; Tue,  3 Oct 2023 13:40:12 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-7743448d88eso97806985a.2
        for <linux-block@vger.kernel.org>; Tue, 03 Oct 2023 13:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1696365611; x=1696970411; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Nxvc1lxZifVSA6lTiXigXFomqQxRhSDegObkyWLMxc=;
        b=Hbat7SsOta2DuorgZVddggc4g7jtFQ07eoaudBQF9xj88MBY0T7+yOjMakoGwzzVhK
         Kg3jZ+LlgJ9gQf4QWINY8dyIJjRq3YvSKAeseH2CdHHfdmkeRd72fc8Qejgda/v3puU8
         k6UfmVh+Juc7IDurB38pNO11qyK/itSAeHim0gqJpSwcfJcfzlY6m1OYSqbZyNwY3lRV
         qkIMNmRnwxYAnSScCQ0YuVvvx2KWotGJWLk3tuzJIhQW8rAiS8q8ezMAde3H5utH6QoG
         w5nj1+T07KzHJc8GmgY9bk9EAHxoGPv5toFf8oGeiAFzZOAlZUEAbRluJUmhHs9rxRnD
         TtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696365611; x=1696970411;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Nxvc1lxZifVSA6lTiXigXFomqQxRhSDegObkyWLMxc=;
        b=qrl40yKsg0vBChxuuuCavGoOyKb320akVWPA5U69MWsQa1MNezUs5of7GvMo88de5G
         d8wNgml/otno4guWfD9URhQ7hC5ojNWo4uWdNSS1EAW55e/tStBgaU/UgBjlDUpBWsPs
         sHhpwnr2n8lhfClXTwjS0vNpooGmcL7TvJc8CwjqsfV0I0BfMHvUYQkH3SazwsGsfSJi
         DS+qnDKXhMSYS8XMPRmEjYwzJL3Nn1pAeWUG6MIhbq7NUE5C4EFaXdtrOxRl6utpEkrL
         tiVzvTbpyNSs0gNC1dV0ORibh05A4NFAyqXionJss3Dp47kUcsb+uMbYi/Rik/nvkMKv
         ZiAQ==
X-Gm-Message-State: AOJu0Yz7Xrif4q2jSUSA7IiQnt0aeKyptVkEiXEIMqkZ+ufd3tKb7ifT
        9YXOK6dP+HCNSo5CQrexY7HfHg==
X-Google-Smtp-Source: AGHT+IERa23rjiYbZGQ+VUfAQarw40/LaUs9xATjvyAOXV8DcAZ8vcJgSFIsCAlJosNJWZgZwYsztg==
X-Received: by 2002:ae9:f401:0:b0:76c:9ac2:3f22 with SMTP id y1-20020ae9f401000000b0076c9ac23f22mr678434qkl.68.1696365611293;
        Tue, 03 Oct 2023 13:40:11 -0700 (PDT)
Received: from ?IPV6:2600:1700:2000:b002:6022:6438:e898:6c27? ([2600:1700:2000:b002:6022:6438:e898:6c27])
        by smtp.gmail.com with ESMTPSA id g4-20020ae9e104000000b007743360b3fasm753508qkm.34.2023.10.03.13.40.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 13:40:10 -0700 (PDT)
Message-ID: <1ded0a2d-3fc7-4268-870c-a315ba3b6232@sifive.com>
Date:   Tue, 3 Oct 2023 15:40:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nbd: don't call blk_mark_disk_dead nbd_clear_sock_ioctl
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>, josef@toxicpanda.com,
        axboe@kernel.dk
Cc:     w@uter.be, linux-block@vger.kernel.org, nbd@other.debian.org,
        Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
References: <20231003153106.1331363-1-hch@lst.de>
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <20231003153106.1331363-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2023-10-03 10:31 AM, Christoph Hellwig wrote:
> blk_mark_disk_dead is the proper interface to shut down a block
> device, but it also makes the disk unusable forever.
> 
> nbd_clear_sock_ioctl on the other hand wants to shut down the file
> system, but allow the block device to be used again when when connected
> to another socket.  Switch nbd to use disk_force_media_change and
> nbd_bdev_reset to go back to a behavior of the old __invalidate_device
> call, with the added benefit of incrementing the device generation
> as there is no guarantee the old content comes back when the device
> is reconnected.
> 
> Reported-by: Samuel Holland <samuel.holland@sifive.com>
> Reported-by: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> Fixes: 0c1c9a27ce90 ("nbd: call blk_mark_disk_dead in nbd_clear_sock_ioctl")
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  drivers/block/nbd.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Samuel Holland <samuel.holland@sifive.com>

Thanks for the fix!

