Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B3EBECAAA1
	for <linux-block@archiver.kernel.org>; Thu, 27 Oct 2022 13:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbiJ0NQI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Oct 2022 09:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235654AbiJ0NQH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Oct 2022 09:16:07 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC8686808
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 06:16:06 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id t16so1194508qvm.9
        for <linux-block@vger.kernel.org>; Thu, 27 Oct 2022 06:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUXGTDslsfAFx1Eylt2BsWoz/ZloDL/xps+YJzdNYlY=;
        b=p/b/XgFb8jWDu74h/b7N4m8vFa7PDMMumfrSzVb60lpropn3O0nsAGpwDvrCvolbwq
         0kS5YJwKi7BpT8TcYyHnLJnS9Ko1QwEgwzSew9CfNF2Lv+PEv02EbWYIdvo2Sm+EEzNW
         E/EIC0plO5tpYJjLoof51wHC8HraevOwce7PHgVTGEbjB4Djs2L8hQZg9IVV3gT0KoLR
         yw5wtteEtHzKvEyxC67ENxtbWodNXBw8rkMMuPFhu01vGSJm+GsT4pX8VTMbWZUzxAD/
         vStxZP6WBBG8T9Xw2bMF9sXRmJBUiekcbfEGd37AWrI0914CGRAIypfVus92+5Jv2OKI
         +ZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lUXGTDslsfAFx1Eylt2BsWoz/ZloDL/xps+YJzdNYlY=;
        b=J4qfdbo5LjqXbzP/pAc/ZgKIbAGs05aRrMVVebX+Apyyq1lmYlq8v+2BX6pohm8RdH
         H3w9y5My5zokr2cciwQLvukjNfizGiuj+DKJp+cO8QGxvxJ9gd/vNCv6b1fGmyjbwE+K
         AGKiJ3K26R9aot9z/dq7gFddlbEvL+nfh7C6tefLyHcpP/3yghIZrXTRFR0u1XD9FEyK
         mK/4bQ084OMbJ9Xntz/xXSUFwMrHP5y5Sk+7kXb/6JQ5nkpbKoLeUDSnSaVDfzPW5aZu
         9roltvRt0gdwyd75yBGmOmdcjo1SVFbj6xywMCuXC5fhBAVQudNKp1bO6wOHJgRXU3Hu
         Cx/A==
X-Gm-Message-State: ACrzQf1XhB3FMMaiBn6SNU0OCWKUb6CFadnaeXtI4L/cgZefU9EgWXHI
        zk75m+U0jeJbIyqhMABuWuLSwAVorGeZGaKq
X-Google-Smtp-Source: AMsMyM5BPlA5HVPe6ZOlhjWSe4vnDS/vIpcXIHC2Ni6AyJB7oroOBPJBhdMyzoUGKJBqZ+CrpKLBeQ==
X-Received: by 2002:a17:902:d70a:b0:178:5d52:9e41 with SMTP id w10-20020a170902d70a00b001785d529e41mr48242037ply.0.1666876555034;
        Thu, 27 Oct 2022 06:15:55 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id m10-20020a63f60a000000b004608b721dfesm1027480pgh.38.2022.10.27.06.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 06:15:54 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Changhui Zhong <czhong@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>
In-Reply-To: <20221027085709.513175-1-ming.lei@redhat.com>
References: <20221027085709.513175-1-ming.lei@redhat.com>
Subject: Re: [PATCH] blk-mq: don't add non-pt request with ->end_io to batch
Message-Id: <166687655373.10763.598511493848886543.b4-ty@kernel.dk>
Date:   Thu, 27 Oct 2022 07:15:53 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.11.0-dev-d9ed3
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 27 Oct 2022 16:57:09 +0800, Ming Lei wrote:
> dm-rq implements ->end_io callback for request issued to underlying queue,
> and it isn't passthrough request.
> 
> Commit ab3e1d3bbab9 ("block: allow end_io based requests in the completion
> batch handling") doesn't clear rq->bio and rq->__data_len for request
> with ->end_io in blk_mq_end_request_batch(), and this way is actually
> dangerous, but so far it is only for nvme passthrough request.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: don't add non-pt request with ->end_io to batch
      (no commit info)

Best regards,
-- 
Jens Axboe


