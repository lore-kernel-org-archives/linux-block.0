Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D87AC04AA5
	for <linux-block@archiver.kernel.org>; Thu, 25 Aug 2022 11:48:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241086AbiHYLsq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Aug 2022 07:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235610AbiHYLsp (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Aug 2022 07:48:45 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFDB97694A
        for <linux-block@vger.kernel.org>; Thu, 25 Aug 2022 04:48:44 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id q18so18159742ljg.12
        for <linux-block@vger.kernel.org>; Thu, 25 Aug 2022 04:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=C+2ctt3lw+WMjCGoK5SbIkJaHBLmWnV6wca5LMGjxlY=;
        b=G0uhYkrbkFa2WWgldijunqL2Q+s35VR0gEUcTTbZw2y7kqdMgghcCIvWp5mTKVQ5i4
         vqfkeE6TmkbPYN5yabghS7whRb5KWeOzDHQ4rLsN4G1VIE2w6BH/sm/sHGi0FsYacadl
         nyYk1w7IKmddnTMDxmazAjaPsyCjVGAhCbBbE/TDFCTUZOgGbWybIeyrbEMWudhtdvB0
         HPVg2k1MnJWgWE9GQoS5uEFzT9eG97JNX0xYHpQNq4QuC7GS/Rcgw5ybE+yzNtLklZpO
         Ac7zIiEMeMN15KNrn7zwUXAK4/hg9ZEBCd1yfbZhpkOQcFDyOAGmo/iEO9rVfNciZ3Nq
         ShwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=C+2ctt3lw+WMjCGoK5SbIkJaHBLmWnV6wca5LMGjxlY=;
        b=cjzOQcVQwKANIR7XHsJVKWM1qzvdf1gA+UkJeat0E2QtCbXqQf6awR2AB5Nqdk9rcQ
         wrvQPJkcRXnuFcWVifJQLMw/yQ9MQiLThCdQl+/Kq/TLQWfD//QOPWWDlHDeiBThm+JZ
         jf6fj51iZkudA4rLCiBK83i4tMrwnl2RTLnQiJEZHOxCzF3QjttveHWcXJhRd0nNAUYu
         aTCdJLEsPGDaaeobGmXf1USUdF4VDsOvH5NMNAOLeJF4vZJzZV5wIqCTh+WFHIzLSxVm
         yZOKkv6MQmkfEVyKzGOi6e3sEPjzExYY+y/dv7aGrYSSQCIim7VTiPHqOmrl3joVFANn
         4zlQ==
X-Gm-Message-State: ACgBeo0c18uTbS4A4EeTK0zYhdUCc8Kf5YirV/8i9ZyY7KwLUhy4T6Cp
        2bcZCI9VbZkmLAqYXwkx3uY=
X-Google-Smtp-Source: AA6agR4QcqxYt2PW0Oqv8S+r3L2fZxeOoSjRa6FJc51jDcUGTmhIekUAdZCvyySzGIP5ZKzp8r1tLw==
X-Received: by 2002:a05:651c:4cb:b0:261:ca07:dc5e with SMTP id e11-20020a05651c04cb00b00261ca07dc5emr1069065lji.325.1661428123077;
        Thu, 25 Aug 2022 04:48:43 -0700 (PDT)
Received: from localhost (87-49-45-210-mobile.dk.customer.tdc.net. [87.49.45.210])
        by smtp.gmail.com with ESMTPSA id j13-20020a056512344d00b00492efa461aasm450246lfr.204.2022.08.25.04.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 04:48:12 -0700 (PDT)
Date:   Thu, 25 Aug 2022 13:48:07 +0200
From:   Pankaj Raghav <pankydev8@gmail.com>
To:     Keith Busch <kbusch@fb.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>,
        Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCHv2] sbitmap: fix batched wait_cnt accounting
Message-ID: <20220825114807.v5pjnkvtfttlsiv4@quentin>
References: <20220824201440.127782-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220824201440.127782-1-kbusch@fb.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Aug 24, 2022 at 01:14:40PM -0700, Keith Busch wrote:
>  
> -static bool __sbq_wake_up(struct sbitmap_queue *sbq)
> +static bool __sbq_wake_up(struct sbitmap_queue *sbq, int *nr)
>  {
>  	struct sbq_wait_state *ws;
> -	unsigned int wake_batch;
> -	int wait_cnt;
> +	int wake_batch, wait_cnt, sub, cur;
>  
>  	ws = sbq_wake_ptr(sbq);
>  	if (!ws)
>  		return false;
>  
> -	wait_cnt = atomic_dec_return(&ws->wait_cnt);
> +	wake_batch = READ_ONCE(sbq->wake_batch);
> +	do {
> +		cur = atomic_read(&ws->wait_cnt);

I think the above statement is not needed if we use atomic_try_cmpxchg
as the old value is updated in that function itself.
https://docs.kernel.org/staging/index.html?highlight=atomic_try_cmpxchg#atomic-types
> +		sub = min3(wake_batch, *nr, cur);
> +		wait_cnt = cur - sub;
> +	} while (!atomic_try_cmpxchg(&ws->wait_cnt, &cur, wait_cnt));
> +
> +	*nr -= sub;
> +
>  	/*

-- 
Pankaj Raghav
