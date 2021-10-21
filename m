Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6743DC433EF
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 13:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B532610CB
	for <linux-block@archiver.kernel.org>; Thu, 21 Oct 2021 13:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhJUNfA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 21 Oct 2021 09:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbhJUNe7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 21 Oct 2021 09:34:59 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556D9C0613B9
        for <linux-block@vger.kernel.org>; Thu, 21 Oct 2021 06:32:42 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id r10so874202wra.12
        for <linux-block@vger.kernel.org>; Thu, 21 Oct 2021 06:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kyCextoPvgtr3t/y/l6axBP+SOq5Z1Feyg2dwwLVO0c=;
        b=fst3EueJTT/Hb77O5cXVUT7TQaBTvpvydDAQPuQPWCicq8zd2H7Vr1mB3q8VucOVAO
         dsEc/gXQ4RE4/BunzcAK0PQNJItV+D2tcM2Ierk6XNW5LgLhuXnBPTHICon/ipiSnM32
         TOr8p2n9M8OFhCIZunc856ea8QtlRsQ3viGA1tsvwtAgaOwtBz/kq6yUY7vSNWmEjpRz
         5tUcuarvgDTKf7WVkwd+6UpbUktC+8o0KZFy7DeYzormTUVV0ymRscmelM4c5A/+ha2I
         DVritg0lc8iswFPqtwqfvsYhSoK76ccCocB5E+WLdnyxzrtadQ0keTekAnoJ1h/MRGUU
         jQJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kyCextoPvgtr3t/y/l6axBP+SOq5Z1Feyg2dwwLVO0c=;
        b=0u3G9SGqF65AGzqEv9unck6+bXZU9eclmATKZblIMY+E2Ot6w0AqieHQ1zw54kynb1
         rs7mac5UKhIPS/yl3qpZzvzo1k+Pl5aOotkYdmojmbWeluSXtZoVoAHKnOAyZhayiMY1
         OQv5KD6iShlP8murczvnX0LMG9GKN+GMsY7gdziHneemi4rSahGVP60q5hVDljm9HySd
         hB/h2xBwj2JTLpVvBaUJfsK1t70k6hYqKeqDVwmNqCySLwA5RImJTcAi1B3ha5wMY0Wn
         M0FTUep7J9jI/mDFBdseAas8WhHk8+vc8FoOx6xqepMuxo6OVM6f8gmg4m8SIQFQpuQ6
         DuOw==
X-Gm-Message-State: AOAM5314w4Trbu7KgsQb+zQj7Xw7fCfAdAlbBMvvCXJ8q/t0ELYI6R5l
        h1UBDa/SSPIqdYhAKd5CXIU=
X-Google-Smtp-Source: ABdhPJxSPPSRuogEM8xXM1lFqjkiBNKcJpzHCCubEeIHsH/13tTgPuBiwlb9xGcCbYU1fAd9YZS0OQ==
X-Received: by 2002:a05:6000:1544:: with SMTP id 4mr7636824wry.374.1634823161011;
        Thu, 21 Oct 2021 06:32:41 -0700 (PDT)
Received: from [192.168.8.198] ([185.69.145.206])
        by smtp.gmail.com with ESMTPSA id k10sm4772468wrh.64.2021.10.21.06.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Oct 2021 06:32:40 -0700 (PDT)
Message-ID: <4c9beb78-f8b2-ce2e-eaed-d4bb2ebd302c@gmail.com>
Date:   Thu, 21 Oct 2021 14:32:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH 2/3] block: clean up blk_mq_submit_bio() merging
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
References: <cover.1634755800.git.asml.silence@gmail.com>
 <daedc90d4029a5d1d73344771632b1faca3aaf81.1634755800.git.asml.silence@gmail.com>
 <YXElIFr6EE2Cy7zL@infradead.org>
From:   Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <YXElIFr6EE2Cy7zL@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/21/21 09:30, Christoph Hellwig wrote:
> Looks good,
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Great, thanks!

-- 
Pavel Begunkov
