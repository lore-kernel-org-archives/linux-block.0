Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48E0C433F5
	for <linux-block@archiver.kernel.org>; Wed, 16 Mar 2022 11:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240341AbiCPLpQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Mar 2022 07:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbiCPLpQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Mar 2022 07:45:16 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7EA62D3
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 04:44:01 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id c2so52149pga.10
        for <linux-block@vger.kernel.org>; Wed, 16 Mar 2022 04:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=X3jw9w3ITJcYSRiUxwXSALrb2HX1/qI4NyXGsKOE6sQ=;
        b=PElglWCpVmJpYPrZ2Bi4Wam92C2GhZFb/hUkFu4S5Lavys2leqNB3AOM/qd14qLTIH
         AnpQimtplkAnIBvNNA2zk2Bk/jS6v+uBdbziDTuCa6enABcpISo+m9iHHDZziBC2W0b/
         UzhMxHULk8fFmd3HvC3VCC6cCu4aAAD/UrVguNcDVBkByd2UAK0Vc/CvW9IuZFWLPeR3
         MpktrPf+Aq3s0ltgye+ikkYrVUEpux9PuyWQOaimwIEoRcU9DxTDiE76405cbTBn9xvX
         9ZRLlsyajhviy/PJ/m0WHRmptg94+JESZcqsmzXs9cfT2VXY6qwJD9S1LPCbUAR77+TF
         MkLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=X3jw9w3ITJcYSRiUxwXSALrb2HX1/qI4NyXGsKOE6sQ=;
        b=3Mm3EkEYNweW9j/5jhvXFuyYEq5xpch7wxS2t3nrL/M+Y8IXu3aDly1AthLpTfA3Uw
         xRrRxrqukTqOjdOiVW4JHJ5iExZbeL3uHKGWWNo8HqgU65E4r4TCDc6+zRGWH10RUyyn
         FerFPRQyfnloq+p5nzzn3iBjzvrRghAJVnfoakvjoan/Q7kivWAWKBuzkwj9avEXxkyM
         eBqLRB+6GK4wRqvCFdtlFLcksYg32J0kq+9CtAfc4X5SMFIKyejZ6O9AEIXEL736Nff3
         //T39bzOimKiiNPsf/man9Su75B/VkYmVOns3tZRR11cjEtra/pApL/nA0MUANP27EHM
         4A4Q==
X-Gm-Message-State: AOAM533D89YTswe4mNadWJYRUpBrXWM4itTacivxHO3pEmNPjCwPMhbb
        c6gxiTRw7itaPKe3YOwowc/uJw==
X-Google-Smtp-Source: ABdhPJyy0Udlinl7bEMkIJYj45RWE+I5oaMZBCpf1Ihx1DjAykjEHFKso7t5UMBQynWzmgh6nWj5kQ==
X-Received: by 2002:a65:48c8:0:b0:375:9c2b:ad33 with SMTP id o8-20020a6548c8000000b003759c2bad33mr29224651pgs.232.1647431041007;
        Wed, 16 Mar 2022 04:44:01 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p10-20020a637f4a000000b00373a2760775sm2333715pgn.2.2022.03.16.04.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Mar 2022 04:44:00 -0700 (PDT)
Message-ID: <527b4816-b266-bcbf-5ebd-e7175ebbc92b@kernel.dk>
Date:   Wed, 16 Mar 2022 05:43:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [GIT PULL] nvme fix for Linux 5.17
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org
References: <YjGxBNRRK/VLVYsF@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <YjGxBNRRK/VLVYsF@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/16/22 3:42 AM, Christoph Hellwig wrote:
> The following changes since commit c2700d2886a87f83f31e0a301de1d2350b52c79b:
> 
>   nvme-tcp: send H2CData PDUs based on MAXH2CDATA (2022-02-23 14:43:11 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-5.17-2022-03-16

Pulled, thanks.

-- 
Jens Axboe

