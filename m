Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6AEC433F5
	for <linux-block@archiver.kernel.org>; Thu, 12 May 2022 12:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353719AbiELMdu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 12 May 2022 08:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353706AbiELMdt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 12 May 2022 08:33:49 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E51A5A0B9
        for <linux-block@vger.kernel.org>; Thu, 12 May 2022 05:33:49 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id c1-20020a17090a558100b001dca2694f23so4757971pji.3
        for <linux-block@vger.kernel.org>; Thu, 12 May 2022 05:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=qYBC9MAoh1L0z3Uw+O0qlXefUDgsE1aZG60eo3WvUIE=;
        b=HQUZ2+FW3u9KFGr/N3tAfzAJVSMZD+eLFnY+2qZSN5k8J6FFrgiLnV1vtibPHGW1Qd
         fCeFU8nfiusskhV/Ivdb8pwlBFlywy9WLlEFT0rql4JPsIxPj4m8mx9jZt7DptSwy2yV
         prHIAJd6tgEFCW6mfQxtu5XkdtcG117c2L0ToM5YJATcLU+6VHX9vhDC4BWDPwIMdLCp
         xbRLTr48RWWkUkboLWxuRk5d60wghko1ej0c6dIkrVSqoYdx4MFIlxrbLtGSrQtqeJRq
         8jhlLXQEF+RkSjvP4vFjGPA/bGnIR2J6lJm+H1byyPKhxciHd8waS7JNIU2lZKKdY+U+
         ir7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=qYBC9MAoh1L0z3Uw+O0qlXefUDgsE1aZG60eo3WvUIE=;
        b=PZ45hfp3Xv786XiQSWFDwlxVmowmfF1nZNtJWWp9hflrmWExa9uUHcqGHgMlDCH851
         Gkk8DG+zU9xzaYIr/Gy+V5NgL6ZVIt6BUJ2TDjpTepceAFWdT1DOZAAQ1syNTqV4Gr5A
         +4119Mb6S73VPPgMUfPHQqF76Bimbsxdbx0bwALf5alOMIN/P/QnOxqilVj1rPwACaWn
         m8iWKGVKTCtaniLHfMdXBZPySkcMRr4N9UIZCccecDYu81j+E+9E5meRBfN4hMeTdQAa
         Pdzi9BrRvK3iiqmY702KpcexW7U6MFhUoq2Y8d7FJ4fJgScxVHGuaBU72v2H+LPq8phs
         v5NA==
X-Gm-Message-State: AOAM532wHQRIoILhT9+xX3U40SdJbDus2ACmFhSYRVS1fBflEfkHy+EW
        JjU+ZvFZ/W4NtX9NJ67WJBm8YA==
X-Google-Smtp-Source: ABdhPJyuxj5b5QTBDPK691R+Wk38Bd+aL9JmKvjgntuCXIVQGMu8zwrGm7lFtEuU4PIcfmwGh1VX8g==
X-Received: by 2002:a17:90b:1d10:b0:1dc:dea8:d2ad with SMTP id on16-20020a17090b1d1000b001dcdea8d2admr10776295pjb.174.1652358828532;
        Thu, 12 May 2022 05:33:48 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902f08a00b0015e8d4eb205sm3736598pla.79.2022.05.12.05.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 05:33:47 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     bvanassche@acm.org
Cc:     Christoph Hellwig <hch@lst.de>, ming.lei@redhat.com,
        linux-block@vger.kernel.org
In-Reply-To: <20220511235152.1082246-1-bvanassche@acm.org>
References: <20220511235152.1082246-1-bvanassche@acm.org>
Subject: Re: [PATCH] block: Fix the bio.bi_opf comment
Message-Id: <165235882729.234858.4820183561551148997.b4-ty@kernel.dk>
Date:   Thu, 12 May 2022 06:33:47 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, 11 May 2022 16:51:52 -0700, Bart Van Assche wrote:
> Commit ef295ecf090d modified the Linux kernel such that the bottom bits
> of the bi_opf member contain the operation instead of the topmost bits.
> That commit did not update the comment next to bi_opf. Hence this patch.
> 
> From commit ef295ecf090d:
> -#define bio_op(bio)    ((bio)->bi_opf >> BIO_OP_SHIFT)
> +#define bio_op(bio)    ((bio)->bi_opf & REQ_OP_MASK)
> 
> [...]

Applied, thanks!

[1/1] block: Fix the bio.bi_opf comment
      commit: 5d2ae14276e698c76fa0c8ce870103f343b38263

Best regards,
-- 
Jens Axboe


