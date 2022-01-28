Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D47C43217
	for <linux-block@archiver.kernel.org>; Fri, 28 Jan 2022 17:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343972AbiA1RUY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 28 Jan 2022 12:20:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350605AbiA1RTR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 28 Jan 2022 12:19:17 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C2EC0613E7
        for <linux-block@vger.kernel.org>; Fri, 28 Jan 2022 09:19:12 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id q204so8561881iod.8
        for <linux-block@vger.kernel.org>; Fri, 28 Jan 2022 09:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=8RmVGniZmHcvwcWEDKH/kYZlMbnd/uwqHE2Oo5hNPa0=;
        b=0N43KOkrCsZYUww/ygNl/rT0AnlkFw42OyhOswJqBwKfqIGt3CSfjdtuTBN/BLs0Mc
         gr54rl70ngMiOmUN++wyUl53olQDTMRjjlxxcvnNMhbp09Pc/Siz+J8lxfUGrXIqu+Oe
         EIS0yHxqg/8wtsBrxzMVP8rq36obugmAc2lgQzyAb6OOqZCl6krnnr9bVbVbnlU5gONt
         sHQCUjzNroavsAzePDjOnOlWr7wVJX0fVm4RsanT1zZyAoMubt2L/3ITyjFutbVLApHF
         YP5G6G5iarQRcox5nGqbE5IcThXMjymkUdHFhGBpwN0ar0iR4sas4p02bDBcZms0fW3W
         8oxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=8RmVGniZmHcvwcWEDKH/kYZlMbnd/uwqHE2Oo5hNPa0=;
        b=Ode4n+8I7xHdzOOuYS6jWb716RT0DwBCikQh+aGRDk7iUO+suSN+hMH/+ALLD/CNAL
         L505pD7p3Nd8T7vC/YokZYStoEaPqLdsTbg0+yz0Lbmr/ChMyszqJiu3TJqjcALxLMiO
         pt10K0b9RjPxoJMTusg9HdbuqaQ/2G1DgFlhg1qB8rGOqOFiEAv61zJUP8LK5/7uP4YB
         V/a882rwWG1okTYLnWXoAqdQ0b7+vzJqwYdoBJFwkIC7kZA6jn9UxyPGqA2mgpdIFteA
         W7uN7NiF8l1wdlLZLTROq6XI88XBvF0UALYXdeC6/j9l9A34Bc7akJGQLiypButRIY8G
         KNjA==
X-Gm-Message-State: AOAM531HckqdrJTArCgSfECHHxE9MDgA7JOhAGZ9UzmF+N85nMMqjKPH
        HKh21jevoebQHeXGPP+jnjG9EVirRiGTRg==
X-Google-Smtp-Source: ABdhPJwC61Mrr7nsRCUtfuUGH56jvUq/5GrMBamk5MOUSAy5rrDSO8kxyOI21Pnnj+XHPGYKtsVV7A==
X-Received: by 2002:a05:6638:12c3:: with SMTP id v3mr1175752jas.254.1643390351642;
        Fri, 28 Jan 2022 09:19:11 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id u17sm3181407ilk.49.2022.01.28.09.19.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 09:19:11 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     linux-block@vger.kernel.org, dm-devel@redhat.com, hch@lst.de
In-Reply-To: <20220128155841.39644-1-snitzer@redhat.com>
References: <20220128155841.39644-1-snitzer@redhat.com>
Subject: Re: [PATCH v4 0/3] block/dm: fix bio-based DM IO accounting
Message-Id: <164339035062.308241.9563111056017072139.b4-ty@kernel.dk>
Date:   Fri, 28 Jan 2022 10:19:10 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 28 Jan 2022 10:58:38 -0500, Mike Snitzer wrote:
> [this v4 is final iteration, should be "ready"...]
> 
> Hi Jens,
> 
> Just over 3 years ago, with commit a1e1cb72d9649 ("dm: fix redundant
> IO accounting for bios that need splitting") I focused too narrowly on
> fixing the reported potential for redundant accounting for IO totals.
> Which, at least mentally for me, papered over how inaccurate all other
> bio-based DM's IO accounting is for bios that get split.
> 
> [...]

Applied, thanks!

[1/3] block: add bio_start_io_acct_time() to control start_time
      commit: 5a6cd1d29f2104bd0306a0f839c8b328395b784f
[2/3] dm: revert partial fix for redundant bio-based IO accounting
      commit: b6e31a39c63e0214937c8c586faa10122913e935
[3/3] dm: properly fix redundant bio-based IO accounting
      commit: 3c4ae3478082388ae9680a932d6bfd54c10fca0d

Best regards,
-- 
Jens Axboe


