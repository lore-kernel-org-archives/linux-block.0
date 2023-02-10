Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02F49C61DA4
	for <linux-block@archiver.kernel.org>; Fri, 10 Feb 2023 00:06:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbjBJAF6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 9 Feb 2023 19:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBJAF5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Feb 2023 19:05:57 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DB630B3F
        for <linux-block@vger.kernel.org>; Thu,  9 Feb 2023 16:05:57 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id m2so4776518plg.4
        for <linux-block@vger.kernel.org>; Thu, 09 Feb 2023 16:05:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1675987556;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxQJQURhixOkBgSh/tkHoWjD9dcrSRHKTOYFtLbPpRs=;
        b=Hb0Y3GUWKWTN8WIEcKiiGv4jrVfrBVr2shKlI71ARKxzVo+z3SRhp41zMqWliKlb+b
         rfETef/ALIpk8DDbJ6n1pA1lpA0J9qc5kMi3YphLxlLFdaqP2b0ALT3mi5aFWUTBLufK
         Hnnq/9VFhp3ilOe7ESfRXkyVkin3SHbe25Au1eqn/8Q49aR9CWZF4SB8DfeKQBEkyi1U
         LqK2bF1Qg/2mTzKFX2reolxJY9W2XzlfRw8FQJ/CsIDGW1IAtZHBmsMirCmUtutuE+i3
         nBR7I8RGXmi3JDGp2239+adLfMHYAxlLHDWEtjjduA7pZ1GUxf6sNuB42QyCgxiFhNeT
         6v8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1675987556;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NxQJQURhixOkBgSh/tkHoWjD9dcrSRHKTOYFtLbPpRs=;
        b=Uhu46Ytt2p16cmOtAgeaJCXvBMzAoaFaOAbdQg0yX7bO0muiIs1l2qB/nY1NcL4U/b
         IStyksq1cuEFLZsZcnHpcFtOHS2n1+Qq5lpiqfhfGjEmkptRRXzNgF/PYLRHT5jtzB+8
         cvT5WBIAevWkobRlFQINWpAH3ckmTxPZ+ej8EIZM5vInuiCuevlF6qjJCiN54MaUj+z1
         xdKBpU37XNO/ECYjaO++cltYP8XY1HB5nvHV3FnTHo6W20OjPzr19ymlF2+KJse85bVh
         528HrJ3m/8FGNMPJTEEQfs60/VGEtnURJrMaUb2rORwqISBRTMWYnM4VQQUEvhiPeyPW
         eu0w==
X-Gm-Message-State: AO0yUKWmVIQ1f4yniLMOpJTvHTfC6VGpouXUMT2IOhIkl5jpWlBvrAR2
        +rUWVqfFzaJZ80td3TQ+G0whOxVPfINzSdb8
X-Google-Smtp-Source: AK7set+rnr+rBnaK1GV7cExTby6Ix+sKYXmtem07g+6+gerh/mFb4ZZLhdkfGlBlYBs2DcUAsu0B9Q==
X-Received: by 2002:a05:6a20:42a1:b0:bc:f665:8656 with SMTP id o33-20020a056a2042a100b000bcf6658656mr15448353pzj.6.1675987556432;
        Thu, 09 Feb 2023 16:05:56 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id s1-20020a63af41000000b004f1e73b073bsm1831517pgo.26.2023.02.09.16.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 16:05:55 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org,
        Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20230209230135.3475829-1-bvanassche@acm.org>
References: <20230209230135.3475829-1-bvanassche@acm.org>
Subject: Re: [PATCH] block: Remove the ALLOC_CACHE_SLACK constant
Message-Id: <167598755566.7194.11114446893901944534.b4-ty@kernel.dk>
Date:   Thu, 09 Feb 2023 17:05:55 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.0
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Thu, 09 Feb 2023 15:01:35 -0800, Bart Van Assche wrote:
> Commit b99182c501c3 ("bio: add pcpu caching for non-polling bio_put")
> removed the code that uses this constant. Hence also remove the constant
> itself.
> 
> 

Applied, thanks!

[1/1] block: Remove the ALLOC_CACHE_SLACK constant
      commit: 9af9935494e4b86ec3c44ec42779f08c4ba79ffe

Best regards,
-- 
Jens Axboe



