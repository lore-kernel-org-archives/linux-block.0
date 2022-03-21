Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E81FAC433F5
	for <linux-block@archiver.kernel.org>; Mon, 21 Mar 2022 12:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244174AbiCUMdZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 21 Mar 2022 08:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243724AbiCUMdW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Mar 2022 08:33:22 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D902D86E34
        for <linux-block@vger.kernel.org>; Mon, 21 Mar 2022 05:31:57 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id t5so15304148pfg.4
        for <linux-block@vger.kernel.org>; Mon, 21 Mar 2022 05:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=Lux+Oce5954ZCR4SaazZ6s8iSwpkGBWeDb8gTfwBZqM=;
        b=VrY4yTDBoUuWUPRu7aAjBfZBak2f/Vf5gOla5mUSXo8iqCal7uXrULn3rX5d+D2eqK
         MFMAh1iO1clvFctmNChOz7kBBggbO0xgsjYcS59nhB7OG210nPjHe+FZ9BYkN8lfwvuQ
         q4T162hV9jUxUzkjRdxKZ9orkKEC+J/BinC4wuDSjMApJarYj96Vg9omJdBG/2ptTgMk
         mX5YH2Fa3yF5ePKcqiS9uD2wFF+OhdfbXWGoTp04bTy8GUHOqq1QFtfFPYVJOgRDsELa
         utUXMG1apjvDJU7Z9Vlhkp0fsM4L83eAiC3r2/Hg88DU7cXjuRZbOJVhMvCN+8vRONfn
         9qAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=Lux+Oce5954ZCR4SaazZ6s8iSwpkGBWeDb8gTfwBZqM=;
        b=KSi25Tggvt3x2BtydUjsR6pOQJCAX0QK5mIJsuLQB6dBPxnlr+AEPozKxB5VUL3ZmR
         nrgNdxq3EL31q97AOr4IfACg8WyP6VfGQbbQQhKYDvIEcKhK/jHTDo82Bib0wlB0oH1t
         jow7mGecYWcQbJGW1nVUW8OT87Ii+za6+Y7234CkkqtTue284xpiYM+N52rH2ZyEN72l
         BGLJJa0UTEP+skb3mgNV12SvzBWXZ9H1HL+FuaV//78mdkrMmjMajBg9krlpy612Ey72
         RGwUFjWLsJ0Lwq7dVg3q/xhPhTCjxVKzbM3HlnzFxnudcA53Fa/7lpsMlJaezHlUr0V5
         5Jhw==
X-Gm-Message-State: AOAM531S8hMqP00D2k7R8yfW1BvSZZ7KMv2VvZ0toMtCPSmFGDQ6Y2JJ
        5SZLeI4XHNm93/Anlfc7maHC6Q==
X-Google-Smtp-Source: ABdhPJyHp8/6kKFBxi4tI0DjZuF7CfbyQs3okZ47Jb114AtRRldFRxb2PaEGX7OOzdRY5sldVEnNuA==
X-Received: by 2002:aa7:8896:0:b0:4f7:b8f7:772e with SMTP id z22-20020aa78896000000b004f7b8f7772emr23053440pfe.62.1647865917359;
        Mon, 21 Mar 2022 05:31:57 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y30-20020a056a001c9e00b004fa9246adcbsm5277920pfw.144.2022.03.21.05.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 05:31:56 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org,
        Dongli Zhang <dongli.zhang@oracle.com>,
        xen-devel@lists.xenproject.org
Cc:     boris.ostrovsky@oracle.com, roger.pau@citrix.com,
        linux-kernel@vger.kernel.org, jgross@suse.com,
        sstabellini@kernel.org
In-Reply-To: <20220317220930.5698-1-dongli.zhang@oracle.com>
References: <20220317220930.5698-1-dongli.zhang@oracle.com>
Subject: Re: [PATCH 1/1] xen/blkfront: fix comment for need_copy
Message-Id: <164786591631.5804.10829961862244970151.b4-ty@kernel.dk>
Date:   Mon, 21 Mar 2022 06:31:56 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, 17 Mar 2022 15:09:30 -0700, Dongli Zhang wrote:
> The 'need_copy' is set when rq_data_dir(req) returns WRITE, in order to
> copy the written data to persistent page.
> 
> ".need_copy = rq_data_dir(req) && info->feature_persistent,"
> 
> 

Applied, thanks!

[1/1] xen/blkfront: fix comment for need_copy
      commit: 08719dd9176b4c55f547bd11812fd6cc35907d37

Best regards,
-- 
Jens Axboe


