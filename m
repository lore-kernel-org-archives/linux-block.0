Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB0C8C433F5
	for <linux-block@archiver.kernel.org>; Tue, 22 Mar 2022 16:45:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239231AbiCVQq4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 22 Mar 2022 12:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235446AbiCVQqz (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 22 Mar 2022 12:46:55 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 324ECB876
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 09:45:27 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id i11so15262731plr.1
        for <linux-block@vger.kernel.org>; Tue, 22 Mar 2022 09:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ty1JS/ttvDyDFx9V90uwDOaH1IzDnQKswPjHPNWj2fY=;
        b=m5e+OFZno8EeYfH4GGjKIycC5OsiSx+NMNBKA9l2YexTM77brHzY9j3vhtQEWvagYE
         PoTYPVoGiS2v8m/DBwi62vcnxG/TTAxn/tsgBegoQLX409+okKM5q/Wyf1RJ0S70BUrU
         buFWN/eGvECW9dwe64i6QCal0KiJ69S/e2qRnyCNmsEUdGNTaZwjIChzxQv2UjSP1jjz
         rVkH3cmOdI5y/qQXOWhmNH2lvN6TQhGVmw1ECUY7KakN39vmKZ123TC683UNkFsSFLLz
         omv1UiUOYgQ4RKwzBUpiZImWeFil3yb4L5T7QafccHY1FUrEyluHkS+h26CZptaan8ZJ
         EC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ty1JS/ttvDyDFx9V90uwDOaH1IzDnQKswPjHPNWj2fY=;
        b=Qlt0VNiG6xmitye3c2mrM89EW5AFkhJDpeCrxzyM50aDFCbDqF36B0d0CoA61YJwro
         O0nAa0/61hpLlrsHCKLoacJq4iTjILQv9R7IcDGGjThqAVbiGP8HJmpGvjxPKrkgFikL
         cIS7p6pfAqDeKgawESBnPWfDXaiUjxijcrPrYcyJ1VgpW6gGwo7R3rXT/C9YFVUn167m
         uDcti5P442uAeTwhA/S9iIQh3PKJ5jxHQ5ET/D1pbeiWTe5zLGDPpmUmtUFbWcJMrJbP
         TmG9yfV93tH+/Juy/Elb9mLq8riYHac2zXp2Q0Vv57fYZxUWc6kj6+UkXnUHDrDeZ5X5
         BCQQ==
X-Gm-Message-State: AOAM530PsRTfDOoTd79mmLJDbM7k83tJ3o1PnNa7jsOT0RENoozSxQDc
        w32w7MPrGZngaGMXYyN7WME=
X-Google-Smtp-Source: ABdhPJzdqR0mvtjVO2kr9SNPVusBTD9XO82GuK2SfB88XUDR6v80kgQnp9EArO46Dks2C0E4KUnaYA==
X-Received: by 2002:a17:902:c401:b0:154:1398:a16b with SMTP id k1-20020a170902c40100b001541398a16bmr18867515plk.67.1647967526571;
        Tue, 22 Mar 2022 09:45:26 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id c4-20020a056a00248400b004faad8c81bcsm6438344pfv.127.2022.03.22.09.45.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 09:45:25 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 22 Mar 2022 06:45:24 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, Yu Kuai <yukuai3@huawei.com>
Subject: Re: [PATCH 2/3] block: let blkcg_gq grab request queue's refcnt
Message-ID: <Yjn9JBT02ZbSdRbb@slm.duckdns.org>
References: <20220318130144.1066064-1-ming.lei@redhat.com>
 <20220318130144.1066064-3-ming.lei@redhat.com>
 <20220322093322.GA27283@lst.de>
 <YjmjplwpQpkOlimQ@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjmjplwpQpkOlimQ@T590>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Mar 22, 2022 at 06:23:34PM +0800, Ming Lei wrote:
> One solution is to delay 'blk_put_queue(blkg->q)' and 'kfree(blkg)'
> into one work function by reusing blkg->async_bio_work as release_work.
> 
> I will prepare one patch for addressing the issue.

Ah, so, this is the report. Can you please include the backtrace and
reference to the patch you posted?

Thanks.

-- 
tejun
