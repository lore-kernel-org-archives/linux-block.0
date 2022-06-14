Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02773C433EF
	for <linux-block@archiver.kernel.org>; Tue, 14 Jun 2022 18:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238089AbiFNS0g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 14 Jun 2022 14:26:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238534AbiFNS0f (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 14 Jun 2022 14:26:35 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478A733A17
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 11:26:34 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id r5so2532401pgr.3
        for <linux-block@vger.kernel.org>; Tue, 14 Jun 2022 11:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=URzV4jleoUWouE1Wp0sYypw+fpessHdkHQsSuiNYtxk=;
        b=OFY2K2mNiUM7NSpYpDkyzxRw0r14DOpmoQLsWwqsMytbfipelgdZODJExbhB3PvSjQ
         RjPGLP3UVr0chdD1CGt7Gi0HIGfvi5Wqumi88zXi5bYaIlfKUsTXAHr4fzT8yoi7JQKR
         7p3+1xn/s7hZRo4nMEjxVBBpBC9O5D8nBqRm6arb5FF0Bx86tNYHHXLMhbUt/ZkBFjHf
         pKxR6LrAB7szJqg+EXbuA0UQoudHgrEkECygvmYleOkvurWgE/jBeaajIbIJ+/7VPoGI
         cI8IfM1cpXCLkuQObnpqqOJMf09j8cZSUBuqtZ4BIPMd2Y88+7F8O8X4f0SNsQwikdGm
         XbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=URzV4jleoUWouE1Wp0sYypw+fpessHdkHQsSuiNYtxk=;
        b=aNmzEBh1Se3EIZrjT+d6ja+ae35wn2R5UWrvsnQMkSZ8WFd9sJMJX5Ik24kaGo592P
         ANjr/wS6UVC5kPXo/vKEnR5KFsHu48AyxcUye+jlKRkSDsu2WpbqrBDJC92zOAyU7DlM
         acUFyER2w6F6vhWcePf3mbKgKVH3UrbqI8urRfQO6mlYENKg4I4Qz4ItZnffYz/zzUyN
         i2vmY6k6ErZwSHJPFFZDTKIGXQ4GEeE83Yd6id8AltlIM5wnjMHI/PhhYEyVinFn2igT
         E65GKBeCMuruaK7lSQS0LroBkrSZfNtvDda9iPTnzZ5D1JlqlEECZi17vAxHWoo8saV7
         /D6w==
X-Gm-Message-State: AOAM530eC7UcjP9sW6dmCfgY1iNQn5+2I4aJwSLlEB1T1EMDGl5C9kBa
        HurUB1h1tABuqp2+77SupzE=
X-Google-Smtp-Source: ABdhPJwcyndvHTQL2WJvQyl0PQ8xr1H5FzP2xAo5AZ6LR8qkhmHsfXe3lneEy5cTMHzua0nTyy4E/Q==
X-Received: by 2002:a05:6a00:218c:b0:51c:c64:3f6a with SMTP id h12-20020a056a00218c00b0051c0c643f6amr5696086pfi.50.1655231193628;
        Tue, 14 Jun 2022 11:26:33 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:d337])
        by smtp.gmail.com with ESMTPSA id iz20-20020a170902ef9400b00168c52319c3sm7599484plb.149.2022.06.14.11.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 11:26:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 14 Jun 2022 08:26:31 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/3] blk-iocost: Simplify ioc_rqos_done()
Message-ID: <YqjS1xysCIj2jBlQ@slm.duckdns.org>
References: <20220614175725.612878-1-bvanassche@acm.org>
 <20220614175725.612878-2-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614175725.612878-2-bvanassche@acm.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Jun 14, 2022 at 10:57:23AM -0700, Bart Van Assche wrote:
> Leave out the superfluous "& REQ_OP_MASK" code. The definition of req_op()
> shows that that code is superfluous:
> 
>  #define req_op(req) ((req)->cmd_flags & REQ_OP_MASK)
> 
> Compile-tested only.
> 
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
