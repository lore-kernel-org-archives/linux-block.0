Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE44C61DA4
	for <linux-block@archiver.kernel.org>; Thu, 23 Feb 2023 03:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbjBWDnn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Feb 2023 22:43:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbjBWDnm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Feb 2023 22:43:42 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC02E2823F
        for <linux-block@vger.kernel.org>; Wed, 22 Feb 2023 19:43:30 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id k21-20020a17090aaa1500b002376652e160so157627pjq.0
        for <linux-block@vger.kernel.org>; Wed, 22 Feb 2023 19:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmZbWBcg/AW2Tz+32ksLqYO/e6dt8EO4hZXdp/nul3s=;
        b=jgmENm0qng91d/uZPHQSAWkoiVVxT4onyeHR5L5btjZajYusPq4nUw5afIJxAtioSW
         scnBMZU4SusEUc/10D4ADcSUzhExYbRW0FDBS+ZSQdsOjhNIzZIH6Gh54XACwmm/FuvQ
         Ds2udvU7ZUiKYeLH2IRyJpQYiosSYh30jezjIZ8ipOPb1XHpfjNwvLOuMqkQPF3HoGeN
         GOdbKCuAKw2blvJ3Pae92bvI/mkAabOd6Jji/0AN69Xlh2pxnsEHgzI7vb1kiHQyRLKK
         hwXFYBVsDd8ieMUUhHNPOfilqJEmd/zUIGzheKj8Hta9neoVwocb/mdaCyH+l/c73IIu
         slUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmZbWBcg/AW2Tz+32ksLqYO/e6dt8EO4hZXdp/nul3s=;
        b=NkRXprZ83lj3nWwFJokxUO7+Hci8T5wVqBMoiU+NMe0aWWwsHuwsV+bM9WL+xO3w/q
         ofsYBOosZFqPa3ePOQDAUEtjeLBPnN2o+n4zXNbjBIx6e+L40YIdhQR8eTftVuj1Q+6b
         3HXUpy22FZ75HC38k9kEr57jBIcLLJV+Rv26sPeqjQLoGjhq7GdEVe5GUA+8Wc7AF789
         sA3bxjQrnIiiAGrqKSVhwOJwpMk+zSwOGgjne+6pWQEzX4GGtR51/ae5h1frdsMtSyJT
         /HILOiTk7IAQz14WrBTWJ37xGpbGjuzT2eKxGIg3iy97VtuasLhkwO86xAQ9YAqMRDpx
         +1OA==
X-Gm-Message-State: AO0yUKX+7EKfEXa0+MV4ZQbMVv1KtBfZF/nm/onJBqhY8uDNUKdlvyF3
        a4mKH4GQ6mtEfhcEYb4xBbCeRA==
X-Google-Smtp-Source: AK7set+q4wdLmbrdYnGFANCbxREwGbuNbB5X3p6jbUJKYBm9j0HofsQcDFA0tDaKWvi/Ov5hXJcytw==
X-Received: by 2002:a05:6a20:5484:b0:bc:b3fa:ee70 with SMTP id i4-20020a056a20548400b000bcb3faee70mr13545163pzk.0.1677123809888;
        Wed, 22 Feb 2023 19:43:29 -0800 (PST)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id jc4-20020a17090325c400b001991e59fde6sm12491403plb.216.2023.02.22.19.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 19:43:29 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     code@siddh.me, willy@infradead.org,
        Zhong Jinghua <zhongjinghua@huaweicloud.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongjinghua@huawei.com, yi.zhang@huawei.com, yukuai3@huawei.com,
        houtao1@huawei.com
In-Reply-To: <20230221095027.3656193-1-zhongjinghua@huaweicloud.com>
References: <20230221095027.3656193-1-zhongjinghua@huaweicloud.com>
Subject: Re: [PATCH-next v4] loop: loop_set_status_from_info() check before
 assignment
Message-Id: <167712380884.13855.10551951254719805732.b4-ty@kernel.dk>
Date:   Wed, 22 Feb 2023 20:43:28 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-ada30
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 21 Feb 2023 17:50:27 +0800, Zhong Jinghua wrote:
> In loop_set_status_from_info(), lo->lo_offset and lo->lo_sizelimit should
> be checked before reassignment, because if an overflow error occurs, the
> original correct value will be changed to the wrong value, and it will not
> be changed back.
> 
> More, the original patch did not solve the problem, the value was set and
> ioctl returned an error, but the subsequent io used the value in the loop
> driver, which still caused an alarm:
> 
> [...]

Applied, thanks!

[1/1] loop: loop_set_status_from_info() check before assignment
      commit: 9f6ad5d533d1c71e51bdd06a5712c4fbc8768dfa

Best regards,
-- 
Jens Axboe



