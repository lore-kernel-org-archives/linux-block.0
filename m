Return-Path: <SRS0=UuDU=VA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9B3C5B57D
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 00:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BD5D218AD
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 00:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGZ30bM1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbfGCAnn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:43:43 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46939 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbfGCAnn (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jul 2019 20:43:43 -0400
Received: by mail-pf1-f193.google.com with SMTP id 81so271533pfy.13
        for <linux-block@vger.kernel.org>; Tue, 02 Jul 2019 17:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=6y6EFOhHrVmqN2XOhvdXRL5MBH9KN4a7EwEf4TQ0LK0=;
        b=IGZ30bM1JVOPOn2JA+NtaBwtZCElZa9uYzP2ylrANUFzTjF3Dkq+iNvLaqjj6ix+aI
         nA9de5UEkcculTGHTzdEEqH86BophVqKEYvPU/4MzbqKfjg5aNWMPotTKTUCCJfYv4GC
         Sqki0kHHRXESEW/X/WuNKhTc7IwRgrT5Wq63SJFIDle/UzSEKQNVu43wzYot67CTK+w8
         khrhvDwxf3kLs+57Lp9vhz8bFX4E+0eleOJGyivbAE7Y47ZUxmvjGcu8vitfSedQfwS7
         9ZblMYQvJWsSx7YNwQSS2rziLFiGrVIbLCMChwYj8jsga+TpenASB/ufRQ4vCyekZjkd
         vfwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6y6EFOhHrVmqN2XOhvdXRL5MBH9KN4a7EwEf4TQ0LK0=;
        b=BFreZCM1DKn/l1yUWMj/2caotdzHxAzSpZuh9+TPbSkzv7UHuArxoktYZlpXRod31x
         9ra6MM7haX9/gAtmZkQNMO04//+MXEN28mHda7Yf349j96+hLYWM/9FUllzya3atwVSG
         JPgpEkNe5t0zyBNFb5+Qdim29a3HdsKkkJqbsL15zRQG2tKT4LG/pmbsfjrvfXAu7IGM
         xZ3HHFNEDSWO1+mdymI4eL+KMqHoJKpCL8QwR9VfGoft9jlpmzsucBxZKTRLsU7CfmOB
         fAnbS/7PPxEsMdtezaF4ir31bMQeqenpHyCSlkTC/UQzLXDdpKutX4wIptV7/zYym+Az
         CZ4w==
X-Gm-Message-State: APjAAAUJfqLJiSG5qtVengJMZXAETIb+Byw6ZIuCJ31wEQXweMORVE3A
        R2uC9C+8ZLNT8Ajr4wRMPDk=
X-Google-Smtp-Source: APXvYqwXN0YlGyDKipGp+Wa48c4rIIsx1oMVVP+Ah7qzo/SOpMyEZfZSGlOaFzcqOjVgqeCapgZUug==
X-Received: by 2002:a17:90a:8c92:: with SMTP id b18mr8626932pjo.97.1562114622776;
        Tue, 02 Jul 2019 17:43:42 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id h18sm262259pfr.75.2019.07.02.17.43.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2019 17:43:42 -0700 (PDT)
Date:   Wed, 3 Jul 2019 09:43:39 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc:     linux-mm@kvack.org, linux-block@vger.kernel.org,
        bvanassche@acm.org, axboe@kernel.dk,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH 2/5] block: update error message in submit_bio()
Message-ID: <20190703004339.GB19081@minwoo-desktop>
References: <20190701215726.27601-1-chaitanya.kulkarni@wdc.com>
 <20190701215726.27601-3-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190701215726.27601-3-chaitanya.kulkarni@wdc.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19-07-01 14:57:23, Chaitanya Kulkarni wrote:
> The existing code in the submit_bio() relies on the op_is_write().
> op_is_write() checks for the last bit in the bio_op() and we only
> print WRITE or READ as a bio_op().
> 
> It is hard to understand which bio op based on READ/WRITE in
> submit_bio() with addition of newly discussed REQ_OP_XXX. [1]
> 
> Modify the error message in submit_bio() to print correct REQ_OP_XXX
> with the help of blk_op_str().
> 
> [1] https://www.spinics.net/lists/linux-block/msg41884.html. 
> 
> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

It looks good to me.

Reviewed-by: Minwoo Im <minwoo.im.dev@gmail.com>
