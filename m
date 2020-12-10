Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C0AC433FE
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 19:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3083B23E1E
	for <linux-block@archiver.kernel.org>; Thu, 10 Dec 2020 19:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390244AbgLJThu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 10 Dec 2020 14:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390178AbgLJO2v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 10 Dec 2020 09:28:51 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13891C0613D6;
        Thu, 10 Dec 2020 06:28:11 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id 186so4877436qkj.3;
        Thu, 10 Dec 2020 06:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5KT0oTb3mRoegGrtWGW20ktqKvohby2eKOLMVIlayEs=;
        b=YM8R74Awf/f2e2mBYw6imzoId/7z7GeQZeO6bM6UtoFmW9mphtPH6zKtAhQsGXjliy
         Xp7Dk5XtsJA9FR8L62hheX5yh5fqQ7kBwoo8SzJqOTcge+Ke1Zmp3jYlCXKZCPviWxxg
         5UrKmQetxiJNfMaWBpu1e9uND0pbrrZ6PgATsXSAATFKHQcoQUK+SITRrLY0yBAaH1Nq
         NOo0ktNQlmT6HvBGz1wATwB02gmUrBC2EX1LUpm4ZycolIejrwqvtC6o62SQGtM/zloB
         0LKEfleAfic63sf1G6GAun9EX1gUUZPcn2+MPpRJ+o6qDkMnvsgShm5FA4czMVSXBXDj
         93Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=5KT0oTb3mRoegGrtWGW20ktqKvohby2eKOLMVIlayEs=;
        b=LfohSqvOtkQ4dDVENw9F8seTvAq0mZNBPiNKQQf0/fSNqSnMirHXAAP1fpNqbZhSbG
         31xo0ftqmUwaWhg4f66PIdTwq8KK+ECYn0T2TtzLPxUt+4Z5TfcnobBANl58TOXIgDVL
         6LPsx3eP1u59R2EkBFige3x5J3Z3MnlCRPO95pXgXcqonrfVDjMyqAbtHh6HVhavD6kb
         ntXmNA9lIhnE0QDAV1UTQHan9zuqDGL1gxsgMOBDgPsU/6pUXOB9ztyPR2WAlwd0VeI5
         NPmrxFo2EX4hj+PEzl4UQ51mpJO4f2Uq0VN+2HXF2KrsME1MyE0gKgag2fdw7wwHq74W
         f8qA==
X-Gm-Message-State: AOAM533VL1gzho2lVF8OqYvfuMAFoOK1mFl6lc7HcTKntMV7wCFXgCuA
        llvg4FX2LBqJvD/VbYaIfnQ=
X-Google-Smtp-Source: ABdhPJyuG1Np9CsPL4WeD/C+l/1mQS9Q2hc6ZCJAEX8z33MeSAFp5AjsWluY32UupWY/PjC3IE8o5Q==
X-Received: by 2002:a05:620a:144a:: with SMTP id i10mr9470027qkl.431.1607610489803;
        Thu, 10 Dec 2020 06:28:09 -0800 (PST)
Received: from localhost ([2600:380:5a4a:42b3:c6ce:6e34:f826:c141])
        by smtp.gmail.com with ESMTPSA id a20sm3042563qta.6.2020.12.10.06.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 06:28:09 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 10 Dec 2020 09:27:38 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] blk-iocost: Add iocg idle state tracepoint
Message-ID: <X9IwWmIgnAl8R34d@mtj.duckdns.org>
References: <1ba7a38d5a6186b1e71432ef424c23ba1904a365.1607591591.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ba7a38d5a6186b1e71432ef424c23ba1904a365.1607591591.git.baolin.wang@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Dec 10, 2020 at 06:56:44PM +0800, Baolin Wang wrote:
> It will be helpful to trace the iocg's whole state, including active and
> idle state. And we can easily expand the original iocost_iocg_activate
> trace event to support a state trace class, including active and idle
> state tracing.
> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
