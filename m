Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D1BC7619A
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 02:50:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbjDFCuQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Apr 2023 22:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235188AbjDFCtr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2023 22:49:47 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76F19778
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 19:47:55 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id f22so32151155plr.0
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2023 19:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680749275; x=1683341275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ha/rKzaudsUCSkVVbpt/j/z29wWBNCJMuC+oaOkquHw=;
        b=cosJVyjT9Omv3YnUqKul9cKxEIz4mDPvm3PXLZ0EX2alSVyxRwIAjV2Oyl95V0a+hw
         hfHsvT65siM9wxfYyZMMshvNs2djYITROYREgflOzhHyNy0UBFcSU8rY/b7vpNwQBlFo
         KEo37cEftGScoeQds+uO5XYteicicdMGUHwuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680749275; x=1683341275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ha/rKzaudsUCSkVVbpt/j/z29wWBNCJMuC+oaOkquHw=;
        b=6PzZnWNSP0mtzcuSH7bB+o0uAHp1HCVexP3yZKiqirYi6OIt3vVCmM9ZUo7kNX0ASV
         4Hjnm3USN3B/0MQtuMM0Xmeq3bEIRo1YSgo2bPU6sX6iYQyEWWAY8vGOw5qmrTktlq+B
         rk3n9GBFjDXnlsV5QaQwoeK9uUngDVl+HGxP3AAJKDRiAFzQXDTt6QoTl58ggeT7lux8
         hx/5YrExsn10rkoOy0QX3DfNpUv5P8ovlvaegPWo05dKRiX5VirTNfCB8oKuYQPR+aV2
         l8l8z4J3FDRlZl1g3UfYmbBHlMopMt8CqQR39b/iN4Y9nqBSx7UKBzG9zc93muwFTYzM
         ujyw==
X-Gm-Message-State: AAQBX9cO30FR1mkkJce8gbnQjOfnHQgQomGyZcL7xkRHH5opZXiriKhJ
        93wYLf1lnpFAqoQMudAD6ttUAw==
X-Google-Smtp-Source: AKy350bbxrCUpYjzjxUj12UtIHxh1pJxI4SckYVlAkjQ9wbdkpzWhkZ11FlZ0kOD7JVlOEMNst/DAA==
X-Received: by 2002:a17:902:f944:b0:19f:27fd:7cb5 with SMTP id kx4-20020a170902f94400b0019f27fd7cb5mr6655641plb.10.1680749275376;
        Wed, 05 Apr 2023 19:47:55 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id j8-20020a17090276c800b0019908d2c85dsm229779plt.52.2023.04.05.19.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 19:47:55 -0700 (PDT)
Date:   Thu, 6 Apr 2023 11:47:51 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 08/16] zram: rename __zram_bvec_read to zram_read_page
Message-ID: <20230406024751.GT12892@google.com>
References: <20230404150536.2142108-1-hch@lst.de>
 <20230404150536.2142108-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404150536.2142108-9-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/04/04 17:05), Christoph Hellwig wrote:
> 
> __zram_bvec_read doesn't get passed a bvec, but always read a whole
> page.  Rename it to make the usage more clear.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
