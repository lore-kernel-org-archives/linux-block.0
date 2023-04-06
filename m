Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3C2C7618D
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 21:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232526AbjDFVUR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 17:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbjDFVUQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 17:20:16 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF75BA26B
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 14:20:15 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6281bcdd365so32774b3a.0
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 14:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680816015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V8Qf+szFFT/GNM7wXoyCzO7xgypE4dl//tS3URt0Ic8=;
        b=Iw5YPGS/DjoqOzlaa9e3mfETYNr41sUWim4+oYi2abhikouWK9vbu8xbprddyEbo0S
         XoeWLF4TrM+gGNR61MuMnYlEBq1bLTJZKMqN0RmLPo8adiYWLVKc+mzoI/o5mEGGs+0q
         13FqrSTALDdyPFBKSrTZdMWzDMx57ofK1fn3BCwCnsL3mcvNCLlKsi3jGPnQbnt8aC+d
         kYlm6nqSYzeJ+v3U3jWc7R1kEaJlNP8L63wPfs3c7apNc2HEafwEXcHMY6AyIRKNsQOz
         UBMuZ+zF0/FP1xTvKhhgOcu6t6K7iPXJ7BWxqxZxBE7CXfETiuUO2YKNvieyWDVF1Kbi
         9awA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680816015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V8Qf+szFFT/GNM7wXoyCzO7xgypE4dl//tS3URt0Ic8=;
        b=30emVqPhg4ZCUCDOPKTX04TMaSquE1Ej1E6CY6fCEFvd1W87WajxLY5JXHGATHmWIP
         GRP5JmgjMgjJ/jpoPoRTk/H6u3Fff/0mGNfugEYnQ2eDo5GO1K4BJgXyuEH5vkmbQyyE
         Zz46QggFkJ59X47ndemc1irJ6gh99ONXo51uf1MvDnL2PdjQ5lUG36V2jqI3mF6Lc3Zr
         mmDzpPNHq7QdxLpa9HZBdlWwaaSO2VPzN7ZIfseh3WJS5Vu4uaP6KsVJoecxXCgF1QOa
         Bu5Tl+BPSU0Q/pA7KNYlX1k0U+keuzMOeoZ2CL3QCB6T0ojAqBtmkmJtNdnEHf4OL+Am
         GybQ==
X-Gm-Message-State: AAQBX9cVFC/h/s2KaAiPtuzE0WUDlcT0l+e1ZxxgxqP+/PevDdrOoKUa
        g2mQpcnVqy2+twcgnJlEhgI=
X-Google-Smtp-Source: AKy350bqMvTMCbBYwLb8aWzjEG1x4S+8bC29SKBJbMAesPykSKJA21jmpT6wjdNPh3efjhbx2BD3gA==
X-Received: by 2002:aa7:95b9:0:b0:626:26f:5e4b with SMTP id a25-20020aa795b9000000b00626026f5e4bmr367817pfk.1.1680816015122;
        Thu, 06 Apr 2023 14:20:15 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:6a8d:6a82:8d0e:6dc8])
        by smtp.gmail.com with ESMTPSA id bm1-20020a056a00320100b0062dd8809d67sm1829971pfb.141.2023.04.06.14.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 14:20:14 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 6 Apr 2023 14:20:12 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 10/16] zram: refactor zram_bdev_read
Message-ID: <ZC83jAuidqnRPZnq@google.com>
References: <20230406144102.149231-1-hch@lst.de>
 <20230406144102.149231-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406144102.149231-11-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 06, 2023 at 04:40:56PM +0200, Christoph Hellwig wrote:
> Split the partial read into a separate helper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Minchan Kim <minchan@kernel.org>
