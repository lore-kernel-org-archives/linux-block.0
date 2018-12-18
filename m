Return-Path: <SRS0=v1Da=O3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA432C43387
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 04:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4470214C6
	for <linux-block@archiver.kernel.org>; Tue, 18 Dec 2018 04:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="f1g4klHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbeLREe7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 23:34:59 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:35504 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbeLREe6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 23:34:58 -0500
Received: by mail-pl1-f178.google.com with SMTP id p8so7220800plo.2
        for <linux-block@vger.kernel.org>; Mon, 17 Dec 2018 20:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UmSdy7Oyqfmd+zr/NgQ8aaEBf5yxhw4I+bvNQyIiFp0=;
        b=f1g4klHT4PzpO8/gxV3d6WiScb933qjO7U/cszGgALJdzN2U96SQaGAw7CZ2Qb2KlF
         XKUKReHLZjMpdpJdjIlrdtdFH/aK7wyGZ/qQjtD43XtPnGqDIPy+mbAFcNgIL8ylqm0C
         c5M7w/feJpwoLOPjp9KY/s96GKCFOi+VxGpBFNA717dMA2GMyCVkcHqNJXH1QdN9Lo0B
         NsBJ1UzIgSeBZ6zHweBW3wQkrrk3VA7DS1SojygT4wJooasSqILxg39mCH9xTbYkGVbZ
         IgismEyR84nNxL95yGbQyBESfr5nmcJZjKSzxRPxrFxBj4PSh/FEq5S2I900ZcZgOtat
         b3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UmSdy7Oyqfmd+zr/NgQ8aaEBf5yxhw4I+bvNQyIiFp0=;
        b=a92oT3vRfbbl0cZiklpTdFpqiyAijGVds6gdvbPZYCQgJEa/8A6Fhml5/V6nywof70
         5pVYGxN2YLWAG+FhrRTeON5JdNacnGmI/EMqwSRGsSpGXPsHEzLTJfhigMmNzW2wcjCj
         by/5NP42P5ka1TDVhRkXJAt6fTiEbOQvN9OtIPrLr7MMvxCHauwcXLwzZ6iKLm5Ue7PM
         AuCwjFYuMFbnWbgGpJahYOEF5jp/NcDG/i7d1DrAOcWwUaOci+l9rB0af7vewSfU96pJ
         Ijx3t16mpA7TLfhPApDmbvG58hwTcmN7ry5zxY1C4VFsrONchPmzo+wy01tNdSaGEazH
         j0nQ==
X-Gm-Message-State: AA+aEWYysGZfHuRQRIeFBaYTnPl6wadjL6cEInhJpTsdqUCtQKtN+vEG
        1UgQQRwRKGenWeeHmchn4+XfbJem+ZfHrA==
X-Google-Smtp-Source: AFSGD/VN5alf5RZK9DFaAt6LRHQ9LnHwpQ38owFmmkEiIWCokxA/0/0tvHonQQtuyU/ueN/Bf/uIqQ==
X-Received: by 2002:a17:902:9006:: with SMTP id a6mr14991137plp.334.1545107698096;
        Mon, 17 Dec 2018 20:34:58 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id i21sm15543293pgm.17.2018.12.17.20.34.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 20:34:57 -0800 (PST)
Subject: Re: [PATCH] blk-mq: enable IO poll if .nr_queues of type poll > 0
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>,
        Christoph Hellwig <hch@lst.de>
References: <20181218041529.27787-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <95d4e41f-24a7-bdb5-e014-994e021f901a@kernel.dk>
Date:   Mon, 17 Dec 2018 21:34:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181218041529.27787-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/17/18 9:15 PM, Ming Lei wrote:
> The queue mapping of type poll only exists when set->map[HCTX_TYPE_POLL].nr_queues
> is bigger than zero, so enhance the constraint by checking .nr_queues of type poll
> before enabling IO poll.
> 
> Otherwise IO race & timeout can be observed when running block/007.

Looks good to me, but we might consider having a helper for this, since
we have this check in 3 places now. But for now this is good, thanks
Ming.

-- 
Jens Axboe

