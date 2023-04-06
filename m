Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3049C76196
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 05:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbjDFF2x (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 01:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjDFF2w (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 01:28:52 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432AC903A
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 22:28:50 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id l14so25046056pfc.11
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2023 22:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680758929; x=1683350929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WcO8E+roST7yJZsmozpVgKrlUuLTYtZry5RT86NaHnA=;
        b=YtPvvsW7dCzmbcSn80ChLevg6BGMzUAaA6ox250i6Vytwz1NN0v8I5ZNuZlbmFdK01
         AdC2lHNM8EOSrfDMVZv3KEBxC2b8hAYJPncsSw3FueWDw93VS+vIVkS5diK1AMc407tN
         ttGnxgI+j+I6eHRhLUvsZbAxMoJQFkQ3QEMPU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680758929; x=1683350929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WcO8E+roST7yJZsmozpVgKrlUuLTYtZry5RT86NaHnA=;
        b=sqVM+1C4QBUi5Rq4gcP3nN4gKVAFoCTLFFuiAOgI1guh10YSjbaTkF2BLAZ3Y0QyFs
         KWoKhpUQpOjva5yx4FydCaE32MtEMehprb07aJevSGssI0z8m8uem6F8XwYwJpcSfwBh
         AABlaja3h3gV1EtJfs84bSTYGa8J9/pPaFCZJoy8mTtuZBvq1CbNsL6myuc6tEGRzcRH
         SO3+vxDZvKf+RmhTSolBBAFjkQEQKIApxCi/5VoNd8ES2W7PjC4cxEq1mtGCHDesUOPZ
         WSwUm1yCZwuDpM23upSKQEaWybxPKR74/mP++wNvvJk8DDjoNCY48ATAgLeS51I1xVtP
         RznA==
X-Gm-Message-State: AAQBX9dlxfRVOC0CwhJx89Kjd7SOpe6dZCk1oT2z3gYkVXI90uf4JQPQ
        zXJKFEC/tv9lerrMb98/XHle7pyOZOIiIq0l4Qw=
X-Google-Smtp-Source: AKy350bINAPsi5xHpXVMiuWfHkPN2O/kSHryAMwLUC94/21YTP8oq2U6TveyVFQWTT4MpnaXbNeSfA==
X-Received: by 2002:a62:1b0b:0:b0:627:ede2:89ee with SMTP id b11-20020a621b0b000000b00627ede289eemr7329743pfb.25.1680758929425;
        Wed, 05 Apr 2023 22:28:49 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:678c:f77b:229e:3adf])
        by smtp.gmail.com with ESMTPSA id t15-20020a62ea0f000000b005a84ef49c63sm309517pfh.214.2023.04.05.22.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 22:28:49 -0700 (PDT)
Date:   Thu, 6 Apr 2023 14:28:45 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 13/16] zram: pass a page to read_from_bdev
Message-ID: <20230406052845.GD10419@google.com>
References: <20230404150536.2142108-1-hch@lst.de>
 <20230404150536.2142108-14-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404150536.2142108-14-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/04/04 17:05), Christoph Hellwig wrote:
> read_from_bdev always reads a whole page, so pass a page to it instead
> of the bvec and remove the now pointless zram_bvec_read_from_bdev
> wrapper.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
