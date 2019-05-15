Return-Path: <SRS0=Ir13=TP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FABC04E53
	for <linux-block@archiver.kernel.org>; Wed, 15 May 2019 16:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49E492084E
	for <linux-block@archiver.kernel.org>; Wed, 15 May 2019 16:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="p8QgfeYF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726394AbfEOQBR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 May 2019 12:01:17 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41952 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfEOQBR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 May 2019 12:01:17 -0400
Received: by mail-qt1-f194.google.com with SMTP id y22so230226qtn.8
        for <linux-block@vger.kernel.org>; Wed, 15 May 2019 09:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vstgejR42b5+XxiiajjdEgje6Pzn522XRSN2RWKO8MU=;
        b=p8QgfeYF6GeCHdrWIdFdhInf7fAmWwynAM8Dp5N++OcKVESaOBW3rpY6yvvEMT5qLI
         IObMxZMslYqBh8jW/zYcifaOI7d3npyH268S3ocytd4eq/ZPzh3sNeZt/1Yy62oI9o+M
         DUfj7+7jE6/4jzF2ExKe/QkdlCMfsGI8hW3v0M4e2v/JTmueXwD5ExHpKSveV5mVSQ6k
         844V/KYTllS9iQSCERyFlI2DcDS8LcKR9kMhj8xdFCz8jj2Iy78zLn41UJnJZMC145TI
         fwJktgEST9pk8V8lucTiGqgZTGnH2YhmUHHiQp1LHUm5ONNVOmYRY/Q82G+erRQ1PDrH
         bRag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vstgejR42b5+XxiiajjdEgje6Pzn522XRSN2RWKO8MU=;
        b=hsT2v6/p7VuMvwbd+yHJP2bAW+WwfWXmsNk64AWlZmis1JFmrwI8KvmlnBBa9sbBDD
         SVCTxECbNYiAY/FZ5r+UXpeBfHcXJyicMvctoOa/NrBNXs4+RSmf0zyGvivgboYVnAOz
         H6JWy183Lq2OQSjT7DhmnpfMh/1gJxKUTZmpbyQvjGnzdQDs4FX371BcOQo+vL9bUZci
         nxzYgPP1qqIpgO1sluMZVK8oUnxIxi/Eb7HWX0UIMQ4AiLpkfT1Jc3MHhDr7aAVgwGAj
         ALepted59Qn0De/q6mwT4Qld331vnHumZ1zZCxdC+GoYGbW0JEAmBqjnOkHjXMrEcN3P
         +qGQ==
X-Gm-Message-State: APjAAAVr0lQkUCjQBodDQ4DAFHHyxsfHQJSwMXM+g8gqhbdlDzIIN1C+
        /N1VrrJ+o3BQIJ5o2R5iPXgr7A==
X-Google-Smtp-Source: APXvYqx6tRaQzJKpt5UetyIqMldy+6jvgk8MRUf5ougpzxJVQpmOtUK0uFelfF2JqoFEdJDn5RJoDw==
X-Received: by 2002:ac8:2817:: with SMTP id 23mr1320901qtq.174.1557936076405;
        Wed, 15 May 2019 09:01:16 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::bca1])
        by smtp.gmail.com with ESMTPSA id f21sm1074740qkl.72.2019.05.15.09.01.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 May 2019 09:01:15 -0700 (PDT)
Date:   Wed, 15 May 2019 12:01:14 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Josef Bacik <josef@toxicpanda.com>,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 3/3] block: rename BIO_QUEUE_ENTERED as BIO_SPLITTED
Message-ID: <20190515160112.vr6vd3cjawnplugu@macbook-pro-91.dhcp.thefacebook.com>
References: <20190515030310.20393-1-ming.lei@redhat.com>
 <20190515030310.20393-4-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515030310.20393-4-ming.lei@redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 15, 2019 at 11:03:10AM +0800, Ming Lei wrote:
> cd4a4ae4683d ("block: don't use blocking queue entered for recursive
> bio submits") introduces BIO_QUEUE_ENTERED to avoid blocking queue entered
> for recursive bio submits. Now there isn't such use any more. The only
> one use is for cgroup accounting on splitted bio, so rename it
> as BIO_SPLITTED.
> 
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
