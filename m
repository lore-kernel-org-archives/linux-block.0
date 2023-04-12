Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543B8C7619A
	for <linux-block@archiver.kernel.org>; Wed, 12 Apr 2023 12:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbjDLMaA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Apr 2023 08:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbjDLM3v (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Apr 2023 08:29:51 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D64B76AB
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 05:29:24 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id c3so12246835pjg.1
        for <linux-block@vger.kernel.org>; Wed, 12 Apr 2023 05:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681302563; x=1683894563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dRkzygZEtZmHZoJIpnZOuD9y9yPyj66UkFc7pwq8Fyg=;
        b=UJfjbb2QT77EieE+3XbJ/OBoMTJRjY3GRR+aXvVLieATK/NfJH94VfHjcSkIR821Hl
         FGBCnLpJMjAZ6Ebw0Te4GcwsHY4Goleh1FjmaQtUcTGPEVtoIaGr3VqgvejN5TpH25IQ
         kJLRIjVtuPR2W62D2NGsRTV7otnqD9+vRyDg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681302563; x=1683894563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRkzygZEtZmHZoJIpnZOuD9y9yPyj66UkFc7pwq8Fyg=;
        b=f5FqTxQOqN7aigpYzeYZzMGyVjIFziikN0tUY6qaBXsJJblMiXHnDpQwpoLsg0+9CM
         bW9FHcrUYEBvN9+bM3ycyqO7wIqm5G4h3/NjyMhDRcaUB1nNa6EeP4VghteWLjyct4tG
         zWhgezYK46VT5au7qqOeFFrrFxxeHO6l+BlL0W/bsy4lLzIw+G1ZNDhvir/ugeS0nGfn
         evgIgEaz+7zwppnsV0ZTWAZEC4zfgVYs3kDmhzJiL5L4wegOCFa3jAhheYVZehoZB5a/
         wzt/AQUe7PMNS/loMji9WYgl4oCS8JQTuTF1ewiMETxcTnExLm5095VgN4w37csGjwGN
         ZmLQ==
X-Gm-Message-State: AAQBX9eU+ub7HGAZZA8KRyoA1QauXwS1hZ0dpEYNc+AnGFBy0ygLBbtl
        kxv+co+9EXP7tvypVVW8eJdmKdULLIRqob6xzfg=
X-Google-Smtp-Source: AKy350arJtJX3bi1vRcb1gV19O9EXCB04AYUiIq8L8T5ek8TxP2bJJsOCLflfUerDq3dvztqvEeccQ==
X-Received: by 2002:a17:902:c952:b0:1a0:53b3:ee87 with SMTP id i18-20020a170902c95200b001a053b3ee87mr17981495pla.62.1681302562995;
        Wed, 12 Apr 2023 05:29:22 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c21500b001993a1fce7bsm1804907pll.196.2023.04.12.05.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 05:29:22 -0700 (PDT)
Date:   Wed, 12 Apr 2023 21:29:18 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 06/17] zram: return early on error in zram_bvec_rw
Message-ID: <20230412122918.GF25053@google.com>
References: <20230411171459.567614-1-hch@lst.de>
 <20230411171459.567614-7-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411171459.567614-7-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/04/11 19:14), Christoph Hellwig wrote:
> When the low-level access fails, don't clear the idle flag or clear
> the caches, and just return.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Minchan Kim <minchan@kernel.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
