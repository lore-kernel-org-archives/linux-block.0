Return-Path: <SRS0=Ci6H=A3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E11BC433DF
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 14:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D756C207E8
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 14:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594910406;
	bh=Ybi5i+K/1tMcNrYgcgCKdrb4m3qyNHGuBXZdhqlTq3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qJY/RZFj/cFW4yepBHj3w2BzWXQosUgWp11lsvEXIdHO86ef5c0K5oT4xoaVjJWQH
	 zKvBEbluGntUk6Guncuwou6aArPlin+gjKA1ljDdCUkWVlUMbn6bwSmhlEU4MIQMxh
	 GI202TBgfqGCG4ti6Nrpp/2A9LYbSspF3EDyf3BA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgGPOkG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728589AbgGPOkF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jul 2020 10:40:05 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3C9C061755
        for <linux-block@vger.kernel.org>; Thu, 16 Jul 2020 07:40:05 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id m8so2792930qvk.7
        for <linux-block@vger.kernel.org>; Thu, 16 Jul 2020 07:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D4kXaFYARC8v6V8vRT04NzDO7iec5276KU1ksZoTZWw=;
        b=ahc0Sw7LF119ElwsLm+X4BNllKbWH1luyN2/9oyU2JbePtEy8c/p9QeClNt3eHl25x
         6/3Dr6uT5QG03SUZ4zvI5JPekODYcAHjEr7n9nXN8ENN5a6WmsVN9WHE2myLTjjXk++/
         YAVHhBLDNJI6v6LZQM12L0swnks3Ru7eU8xxesjMz9XBDpMechzQ9NYDB8PSRGZJauZO
         1VKVPLeVF0qg1K2lcy88MQneKXUP66hN5opf7KXZu47rnn++TtlGgbU2WXDeyH+JPd2h
         j/zgQjQSKC9L3aOngvBkamPHPOd8pWUwoRCbdoya7NfNV2ol48GKJVR/XFKufOIJLRRM
         Fqdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=D4kXaFYARC8v6V8vRT04NzDO7iec5276KU1ksZoTZWw=;
        b=e81kSQ7h4JmzMcl5z1lqsFAUsuSi7G6fuQEQmyKJmAyIfRRp5lZp4cZJZ1E0Zgc0MD
         lwNWf5B3Xg7xvhXjhntw9ec9/OxEvH5Uu9U/lJkLZwKZix1dTGrHKtkSGnkvaSAsgzj+
         AhUCA8KSCdkHpNs/YnoIlsdTBxZEN138XxU93r3ruX1Qjf1MdjOQUb9TQZm1X27qIUf+
         zDUN1HYgGh2xUezJquIN1RB+D8uxUYXGJQE7SRrOx6YyXy6fzfVQJOff/OXM/x6j7pnT
         4VNFmy+cpcFi/kdgjHVh89d8gWXvc/T2pKWhq+dAzGn1xElmzFzBDMuOqi6MmyKvyhvn
         JMVA==
X-Gm-Message-State: AOAM530jS23lcOlY/FRMa88Bf9h7FMes0BkEI/KObKJpmsmRI03Fexz/
        tIp+Fj0w0E773asHAO8+8125W4mU2m8=
X-Google-Smtp-Source: ABdhPJx0VodlVowQDLgH8se6lc4jM7QDPr4ttCqR/h9X8q2yt/Ip/T/9wHKYaeyIrEKDKI30iQfEfA==
X-Received: by 2002:a0c:e901:: with SMTP id a1mr4624529qvo.27.1594910404788;
        Thu, 16 Jul 2020 07:40:04 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:3423])
        by smtp.gmail.com with ESMTPSA id 21sm7464715qkj.56.2020.07.16.07.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 07:40:04 -0700 (PDT)
Date:   Thu, 16 Jul 2020 10:40:01 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 1/4] block: simplify the restart case in __blkdev_get
Message-ID: <20200716144001.GA135797@mtj.thefacebook.com>
References: <20200716143310.473136-1-hch@lst.de>
 <20200716143310.473136-2-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716143310.473136-2-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Jul 16, 2020 at 04:33:07PM +0200, Christoph Hellwig wrote:
> Insted of duplicating all the cleanup logic jump to the code that cleans
> up anyway, and restart after that.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
