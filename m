Return-Path: <SRS0=5Asf=UN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD706C31E4B
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 13:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937902168B
	for <linux-block@archiver.kernel.org>; Fri, 14 Jun 2019 13:40:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="HyoWdc02"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbfFNNkl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Jun 2019 09:40:41 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:46856 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728418AbfFNNkk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jun 2019 09:40:40 -0400
Received: by mail-qk1-f194.google.com with SMTP id x18so1632620qkn.13
        for <linux-block@vger.kernel.org>; Fri, 14 Jun 2019 06:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=G9SAo/9m3Ee6pfPkvimz/VQaTFNGe+yHp2e4LnZeqWc=;
        b=HyoWdc02XVOEpU8YXclbrtD3Mxp3j/f6lp6SQRUm/QWlC7SbxwAiZLFB9O3cLeJx5x
         xU66//NZQoe+f5s3bcyN3j+B5gqMJDlidXSnpTRHpwzHE+AwJA6s07gU8sNqKWknaBbu
         9+sJrYu+wYlWvFHPEP9JQ7hFiMfVkpnswCaknWua47sUyBWB0xFkUdakvVRcJsn1i3ze
         8LKYZrR2kXnUIo59cVEl2Xp6hBNNv3uZJCcPPSoHskfty31e1iCbUuU0eMOcUuNRWK7W
         tdE2Uy+hqzYBJTXAako63k5qtREdmHFQ2fUvdJI50HjzP3qRT6+EP2E0d1ItChlTuayx
         ocvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=G9SAo/9m3Ee6pfPkvimz/VQaTFNGe+yHp2e4LnZeqWc=;
        b=kNTribeihfxr2ayi6OJiI0/pblGhF0/VCclz8w1MahxkJ6QJ/SWx9vAeZi47Rmrj8Y
         +QwNMOfCgNspajnimGs2YQv8Qko5l8hIWWhROu44aareT9dHAnrTa05tiIHV1DKj9YVe
         DKbnGdbSqGICL3mybzeDr7eZbPxDL2K0jk39EfA0z6alb+QoZImzyH4R55QZyQ/0NhsA
         lIL3FfSkfOuE7b4xnjipz78pdDmCljHcf1INtKPgbyrao3bdTUDWS66V4o0MENgf2AHW
         QckMfT93vxdCWR3rQIkqX3Z9Kes9A6D40j58IBMLlj2e6STPiKY+JtI/hFOBNex3WOuN
         QuYA==
X-Gm-Message-State: APjAAAVUGf9Kd13/0eI89g91YdHQGFlDQckwugRWEahaFugDv1vkJNL2
        0xZvCwTfBBa9QRFElrKBq9UNhw==
X-Google-Smtp-Source: APXvYqz4I5m3TPqusrXwcRcNEOsw8WOBPlVFlSUGuzCF4txMKFyf9UoWPfKOzmQddUa3z4XbMAcwdA==
X-Received: by 2002:a37:4914:: with SMTP id w20mr44894944qka.156.1560519639020;
        Fri, 14 Jun 2019 06:40:39 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::a658])
        by smtp.gmail.com with ESMTPSA id e133sm1106145qkb.76.2019.06.14.06.40.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jun 2019 06:40:38 -0700 (PDT)
Date:   Fri, 14 Jun 2019 09:40:37 -0400
From:   Josef Bacik <josef@toxicpanda.com>
To:     "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, josef@toxicpanda.com,
        dennis@kernel.org
Subject: Re: [PATCH 0/2] Fix misuse of blk_rq_stats in blk-iolatency
Message-ID: <20190614134037.ie7zs4rb4oyesifr@MacBook-Pro-91.local>
References: <cover.1560510935.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1560510935.git.asml.silence@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Jun 14, 2019 at 02:44:11PM +0300, Pavel Begunkov (Silence) wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
> 
> There are implicit assumptions about struct blk_rq_stats, which make
> it's very easy to misuse. The first patch fixes consequences, and the
> second employs type-system to prevent recurrences.
> 
> 
> Pavel Begunkov (2):
>   blk-iolatency: Fix zero mean in previous stats
>   blk-stats: Introduce explicit stat staging buffers
> 

I don't have a problem with this, but it's up to Jens I suppose

Acked-by: Josef Bacik <josef@toxicpanda.com>

Thanks,

Josef
