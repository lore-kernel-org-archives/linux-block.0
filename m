Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA48FC7618D
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 02:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbjDFCbu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Apr 2023 22:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234767AbjDFCbr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2023 22:31:47 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EF083E1
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 19:31:46 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id ix20so36260650plb.3
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2023 19:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680748305; x=1683340305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3mTqdCKa/BgpVYmngQQBW3U8hZrFZJHD1ZbgUkn1dDw=;
        b=gsl48+XS2vCTyrin0+YFASn3zO4AjEYxZhQNLO0ctOG3r/fl32cdJhHwJ2LyY0u2BQ
         Hp2w8pirLutuUa2F9oOENHHC0z2Td8JZ0yIK4yas2VS6Mxblbz7iXE11nGkMtQxnwG0c
         QgAK2LlMoYwAiPqN476iR+fY5lv03sHrk6h+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680748305; x=1683340305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3mTqdCKa/BgpVYmngQQBW3U8hZrFZJHD1ZbgUkn1dDw=;
        b=AZ7Vvrrr8wIhfmPFq9UOZVo2QT6nD3jp71nP51lSbSgSbEScwlXZJXUR/Ayb+B0ImS
         v+BsDQU9PbD388F/wd9KQKqbOoahQSaLPoH/gK5XOFXD3j9VSTwH678K16JeKxRX7T7e
         ZUxqYDCaARIMK2+KgTUo8Hqm9VxN1TVZX/Iiu87S+OgVxhVjDlhCo1pJ8Gq/HNjNnjKo
         KX8LswX564g1NVJh2Knajs9jfORJ6Tsu8PfEUkN2PbuvRikGvdefiCpBrPO7vhsp6umO
         I3n6aJPQipm6XAGG99K+RXZm0XAspu741NA6DlsDOG8Tvtx3oPFT6gujCUtFjTnbf4O8
         wlEQ==
X-Gm-Message-State: AAQBX9dr3Clz4gpk259sHU3ymne9FU+r5jH2lbIPFQunoQYf/rwZ1Zsg
        hJfXop4fazjovetxYmrnQCOiCxcp/GoCmrHDAU0=
X-Google-Smtp-Source: AKy350Z0M0Q+gEs+wwAmqu8/WYGQhGg2VuTxP3xLtfyGX8ccjw7HRGeoW/evxuXU+yAz+iAMjxJ/XA==
X-Received: by 2002:a17:903:244c:b0:19e:2495:20d2 with SMTP id l12-20020a170903244c00b0019e249520d2mr10613517pls.30.1680748305511;
        Wed, 05 Apr 2023 19:31:45 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id z20-20020a170902ee1400b0019cb6222691sm207343plb.133.2023.04.05.19.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 19:31:45 -0700 (PDT)
Date:   Thu, 6 Apr 2023 11:31:40 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 03/16] zram: implify bvec iteration in __zram_make_request
Message-ID: <20230406023140.GO12892@google.com>
References: <20230404150536.2142108-1-hch@lst.de>
 <20230404150536.2142108-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404150536.2142108-4-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/04/04 17:05), Christoph Hellwig wrote:
> 
> bio_for_each_segment synthetize bvecs that never cross page boundaries,
> so don't duplicate that work in an inner loop.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
