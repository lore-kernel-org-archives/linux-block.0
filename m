Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97B1C7EE23
	for <linux-block@archiver.kernel.org>; Wed,  7 Jun 2023 13:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238838AbjFGNwh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Jun 2023 09:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbjFGNwg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Jun 2023 09:52:36 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9544C1BE6
        for <linux-block@vger.kernel.org>; Wed,  7 Jun 2023 06:52:34 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-75d4f06b302so62378085a.0
        for <linux-block@vger.kernel.org>; Wed, 07 Jun 2023 06:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686145953; x=1688737953;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ATelbEey9YqITdBNEhlVknT1NxjwiMcqCvYxHbd4Ko=;
        b=wMhwr1xfNlbDE70oKXzzLiEU+1vVgxU1IosZYD9QCdsLJketjJpcw9/+2UEVNdbyhO
         mjez+vxtn4nOpS+3qUCAiq7PgJW2fPPpx0+Uv0XQJqBoN4yMoLrt2Rl9awgnH2XqQjk6
         gNQvqEXTryqWlAW49owoodgWmsql0YrHRxj+uanNJEXDFgifyusJrBgJtLYkPQRbMUb9
         w59Y6jF2jeUf9QkVGQbGcCqtc5V00MFJ5rnpgZcUoJnD9raRZz+B59Nui/QFnOFvSgIT
         2jim8ft8cz+Ki/3p817pH8t6WP9TlHlZltm5bZ3z84CoSsBpvhorG9WvVW53z5wLoO1D
         Pb1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686145953; x=1688737953;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ATelbEey9YqITdBNEhlVknT1NxjwiMcqCvYxHbd4Ko=;
        b=kM7FjVcLnxBms05k4AV0Py5Yx60i5Osnvq9GlL1ibEESU/75Jn5MOvJSU9BmNg8MDg
         2vgKJqslaGpEZmQqESGdDKwR6/c2t96EMQgIuvIvQbjMv9waFpstd8I5MtQUfwhaR19b
         AzT0rQ+vaRigWd2fbwR/Ztz5NPLqH1d81hP7t/BoiDwMwfDSWH4z1ABnOBmjwIEGz04a
         sAmt7NKmo6bh/48+M4CaQ5jy3HA4WovVEWSLEa76g9aJFk2cii7mJLYeVGgvP7MDIZW2
         mSF2EELqIkT50/49xoFLQ/qCreKtxIvDNBBKJaGcoiSWVa0jIllNBz9zwu+ujNEELMez
         VguA==
X-Gm-Message-State: AC+VfDwdKhTfsPzuIyG5Api3K27+YdOdJK8qKNy+VxnZSQhdvbVeFQU3
        gAOOvRzHXtpGyXbTC+xvTjm53Q==
X-Google-Smtp-Source: ACHHUZ49Oh3b7Y6iFWQKYu5DqKnGXEfj1mjRUktdPRfW2jeikSvwGrTUsu6pWhn2aXJbSK88m7oQzQ==
X-Received: by 2002:a05:620a:1a89:b0:75e:da20:a10e with SMTP id bl9-20020a05620a1a8900b0075eda20a10emr2222379qkb.3.1686145953723;
        Wed, 07 Jun 2023 06:52:33 -0700 (PDT)
Received: from [127.0.0.1] ([50.234.116.5])
        by smtp.gmail.com with ESMTPSA id s5-20020a05621412c500b0062119a7a7a3sm6141611qvv.4.2023.06.07.06.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 06:52:33 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     hch@lst.de, yukuai3@huawei.com, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com
In-Reply-To: <20230606011438.3743440-1-yukuai1@huaweicloud.com>
References: <20230606011438.3743440-1-yukuai1@huaweicloud.com>
Subject: Re: [PATCH -next] blk-ioc: fix recursive spin_lock/unlock_irq() in
 ioc_clear_queue()
Message-Id: <168614595209.134969.6798849940705397930.b4-ty@kernel.dk>
Date:   Wed, 07 Jun 2023 07:52:32 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-c6835
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Tue, 06 Jun 2023 09:14:38 +0800, Yu Kuai wrote:
> Recursive spin_lock/unlock_irq() is not safe, because spin_unlock_irq()
> will enable irq unconditionally:
> 
> spin_lock_irq	queue_lock	-> disable irq
> spin_lock_irq	ioc->lock
> spin_unlock_irq ioc->lock	-> enable irq
> /*
>  * AA dead lock will be triggered if current context is preempted by irq,
>  * and irq try to hold queue_lock again.
>  */
> spin_unlock_irq queue_lock
> 
> [...]

Applied, thanks!

[1/1] blk-ioc: fix recursive spin_lock/unlock_irq() in ioc_clear_queue()
      commit: a7cfa0af0c88353b4eb59db5a2a0fbe35329b3f9

Best regards,
-- 
Jens Axboe



