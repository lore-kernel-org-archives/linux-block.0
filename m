Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C986C636CC
	for <linux-block@archiver.kernel.org>; Thu, 16 Feb 2023 19:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjBPT1L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 14:27:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjBPT1K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 14:27:10 -0500
Received: from mail-pj1-x1064.google.com (mail-pj1-x1064.google.com [IPv6:2607:f8b0:4864:20::1064])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D264DE04
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 11:27:04 -0800 (PST)
Received: by mail-pj1-x1064.google.com with SMTP id w20-20020a17090a8a1400b00233d7314c1cso6899395pjn.5
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 11:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ghxJBe9F/gi1ztZfAp08sB8NNLqrampvOT1lwb1dYDw=;
        b=RRnk5JV7NbvRDKiksh3LzOVGvGQf5jSLCUXimP0xasVFvQBbt+dYIPlwiYDALj62sR
         b7oJFU9wJ+aIwhKEoJbV7d368R2ybG1Ga+U3tk1V8EkhxhT7Otrl6DTe23NtIhIhUQd1
         NzDwH2Dv7FkU+ckgJ1T8+pB7WXGh6TaKpEdooDcQeVbhn56B3jIvAitHd1WP/FyVRFe3
         5hBqUq46vCEIqrHPd0w2IRW5fgdHaZYke8+FBZw4g3aGold5mk8O+WL6xVu5pjgNHIxx
         s3Rft6Aao4BpQ6Zp32AxraypZ0Xi54fzO9bfssbHnBW/TEZUje7PtOWuVvAx4Jsb0n2H
         oskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ghxJBe9F/gi1ztZfAp08sB8NNLqrampvOT1lwb1dYDw=;
        b=1ogL8Qou9LAOfqhX6fArH0mDLTo7YT+9EGVRWRiskNjb8xZmY79Pw7faG+ye1FNXGm
         adH7PiF1qlCEsm7jOymV4Ba8dN2gQUrZHg3Eqr+cP7x78LMGj9OIxQ8LbLSoJ1OJ9IcK
         9rgOh1zPGSMN9TTVR3x9wtu7Gw0H0yzK8OUkTJukW1IN+3eQvDinHdeFapVGq70TMrk1
         t6JuydKpQwkrtSA0Rs2rfYWlGaNcjJSCeymOjnAfTdZKTkJvWJio1kK2jJqM8TPa17j+
         lphutSdDO1T4j8QBtxGjXVTwa3WIvZyYGmmlcz8hDUir555PVhRxDaqIcP428x5L1tUL
         2HOw==
X-Gm-Message-State: AO0yUKX/fc1FtndC6P1CSeQQzvDZ7fWFkyDGUFBBYS6xW+K63QoZqr2h
        dUea2yaS7JnnguLPkZ8A6Q+FJsFmgUvKEEjHj5ixDReaiRfQTo834jsiyNDYsHIBRQ==
X-Google-Smtp-Source: AK7set/tXZ+EgPepRguZedA3khzI9tJlpcxsA1zsmkTgODhTRA/fB376DbygzXK1LBiY2RLtW5OmcNuoVz5S
X-Received: by 2002:a17:90b:1e49:b0:233:f7a5:9942 with SMTP id pi9-20020a17090b1e4900b00233f7a59942mr7965483pjb.30.1676575623337;
        Thu, 16 Feb 2023 11:27:03 -0800 (PST)
Received: from c7-smtp.dev.purestorage.com ([2620:125:9007:320:7:32:106:0])
        by smtp-relay.gmail.com with ESMTPS id l4-20020a17090aaa8400b0023413f68b7esm123360pjq.7.2023.02.16.11.27.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2023 11:27:03 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
        by c7-smtp.dev.purestorage.com (Postfix) with ESMTP id 7857C220FA;
        Thu, 16 Feb 2023 12:27:02 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
        id 734D2E4068D; Thu, 16 Feb 2023 12:27:02 -0700 (MST)
Date:   Thu, 16 Feb 2023 12:27:02 -0700
From:   Uday Shankar <ushankar@purestorage.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Subject: Re: [PATCH] blk-mq: enforce op-specific segment limits in
 blk_insert_cloned_request
Message-ID: <20230216192702.GA801590@dev-ushankar.dev.purestorage.com>
References: <20230215201507.494152-1-ushankar@purestorage.com>
 <Y+3IoOd02iFGNLnC@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y+3IoOd02iFGNLnC@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 15, 2023 at 10:09:36PM -0800, Christoph Hellwig wrote:
> I'd just remove the debug check entirely

Older kernels have these checks in a separate function called
blk_cloned_rq_check_limits, which carries the following comment:

/**
 * blk_cloned_rq_check_limits - Helper function to check a cloned request
 *                              for the new queue limits
 * @q:  the queue
 * @rq: the request being checked
 *
 * Description:
 *    @rq may have been made based on weaker limitations of upper-level queues
 *    in request stacking drivers, and it may violate the limitation of @q.
 *    Since the block layer and the underlying device driver trust @rq
 *    after it is inserted to @q, it should be checked against @q before
 *    the insertion using this generic function.
 *
 *    Request stacking drivers like request-based dm may change the queue
 *    limits when retrying requests on other queues. Those requests need
 *    to be checked against the new queue limits again during dispatch.
 */.

Is this concern no longer relevant?
