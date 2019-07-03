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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5456CC5B578
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 05:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26AC221871
	for <linux-block@archiver.kernel.org>; Wed,  3 Jul 2019 05:52:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWW/XEIb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbfGCFwV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 3 Jul 2019 01:52:21 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43555 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725927AbfGCFwV (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 3 Jul 2019 01:52:21 -0400
Received: by mail-pl1-f196.google.com with SMTP id cl9so580406plb.10
        for <linux-block@vger.kernel.org>; Tue, 02 Jul 2019 22:52:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jsBjsPbznGbNott6mEMTaUi1JTGh9aYXFzPTuw8anoI=;
        b=FWW/XEIbL3sDpvEMJLLGa7K6x/RehBAQzsRUHsXjGFCg4I+HqVpGM9adn6D6VZnaQA
         zTBbPmrbc4RQ9J4Ll1DkDPNinXkbu/rlXtJvql67tQU37j7W5ZZ1tyMLAGV59+v8fTRR
         ATXbGkQtV/Sfyk5iECjC0nnLJ9oFHElMafxEGpIrUAWbNjwVcRnIhy2LGek6ONYzACVK
         9SMHaBV+ZSgu8Ai3kAEYTihq9EgZtUk9SkSbA96WPIHYg1NQ1nS5NN1xX7L0EOUM8FXm
         QVaU+jOPzt6iYW4ECupvRR7QNVS2kWxZmaBd9DCCq8Mph3H5Lwac2p3oXgceizibbOwd
         k3sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jsBjsPbznGbNott6mEMTaUi1JTGh9aYXFzPTuw8anoI=;
        b=aXgEhWX43a+fs8YN0LqxBOw3NmC/oKTmykcYcCHmVOf4kSmMMljS++iRoTi/aFABZs
         s0PfAyPB/66gVgUaLGt6ugwk6tsFXS2rHTcgmrR5uH2o0xVjOT44IVq46cO0A26znRkd
         BNQvGdJVybex45on/PUlByWp2F/YELeY3bL9sKwavhx9FFl8e6wR8/pYh+eWQ0kjVAjH
         +Oy0KFjCC07EbK3529Hry315LSsRAkdmvTRh4TdYTdJyfE9e/zPvxG8z+bUS9d3/oj1l
         5rZQF+aijSWTE6WVueUK+sfc3dUf9TPEJeqDQFlGcYFbGkcQI39ioP0EfxEPXdk1ZRZT
         C49A==
X-Gm-Message-State: APjAAAUoS5iGxKybXrMUKKvAYRbkQXbDFHYH47UHYNPPGoMnA7oFjVLj
        7nvprMTuE/gZBESpKnYMpzs=
X-Google-Smtp-Source: APXvYqxifp1WrFPbiK3pveJZIuBDvmuVSj3+aeun/bHWN4Pc2iQXYfaVYdF+cv3ST1xDOxDn9lp7iw==
X-Received: by 2002:a17:902:2884:: with SMTP id f4mr39273593plb.286.1562133140565;
        Tue, 02 Jul 2019 22:52:20 -0700 (PDT)
Received: from localhost ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id c83sm990060pfb.111.2019.07.02.22.52.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Jul 2019 22:52:19 -0700 (PDT)
Date:   Wed, 3 Jul 2019 14:52:16 +0900
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>,
        Hannes Reinecke <hare@suse.com>,
        Minwoo Im <minwoo.im.dev@gmail.com>
Subject: Re: [PATCH] block: Document the bio splitting functions
Message-ID: <20190703055216.GC21258@minwoo-desktop>
References: <20190701162328.216266-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190701162328.216266-1-bvanassche@acm.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 19-07-01 09:23:28, Bart Van Assche wrote:
> Since what the bio splitting functions do is nontrivial, document these
> functions.
> 
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Ming Lei <ming.lei@redhat.com>
> Cc: Hannes Reinecke <hare@suse.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

Bart,

I really appreciate your work here.  I think it would be very helpful to
someone like me who just started to hack block layer :)

Thanks!
