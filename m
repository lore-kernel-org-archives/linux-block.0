Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EE5C7619A
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 02:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbjDFCih (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Apr 2023 22:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbjDFCib (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Apr 2023 22:38:31 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A877C8A42
        for <linux-block@vger.kernel.org>; Wed,  5 Apr 2023 19:38:27 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id j13so35986860pjd.1
        for <linux-block@vger.kernel.org>; Wed, 05 Apr 2023 19:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1680748707; x=1683340707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AAFGQ2476gbAATNnoGVnGw14QyBhRkaui/ZpTM7HPOo=;
        b=guLvNQy2OTDImSJnvUFyI5jIp7mkQToX5Zb/Fc93Ij6coE79mq86Egq0MpLB8EUTxa
         Jg2/oSW1oJUHd/D96n2EX6UMowNhgYmkAWSRpiE+a7WBJlp9MzXUN2gO8Uud6ektx/MJ
         7SvuB6GC2yhSQ8P00qAho9qw/ypiQxAnvW558=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680748707; x=1683340707;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAFGQ2476gbAATNnoGVnGw14QyBhRkaui/ZpTM7HPOo=;
        b=Yh2m/LieJGPzmJh5AMIVShS2FvooozIrvPP62Z/qKY5Ur8ZLbpiwW1I1xwvym/bVu9
         I7BhhyewQxXAaquqFRdK9dMRe0AEf9MfQJ/hXHlVf+I1x8sOVTNOsxQED0HP3TfV9uwT
         E57qfSgMg5P8gvGUMiieQzoH0xaEB5BKgK6k+vpzDcnByIZDmLPxaa1tD3PgyWRBhJHL
         pjjpx7AXGZVvBKQmpuOsN1tx+3xftD02DgHbeT0+QhEmujSOfu4DzB3R1RVGhY1QW3Q1
         AjSKe4zCn8DiJgnyjw15uL1l0f6HjWOJF2o7O4F+4DhHSmf18L41JcbPwXNd2A0k+FBN
         PJsw==
X-Gm-Message-State: AAQBX9fRqrTD64nIFzS4pD+xsKHPYUejMELFISn4xYl2eMBdFYpnmA58
        u1Y3c/SQjLt9UofXXoTlr/toTA==
X-Google-Smtp-Source: AKy350aFTiqlULTME0+JD+zfPdDfV64jZiOo0vPw1fMthsIQK/GXiSmE1GOV3oPrxPE411pCAYaw7w==
X-Received: by 2002:a17:903:cd:b0:19f:1e3e:a84d with SMTP id x13-20020a17090300cd00b0019f1e3ea84dmr6160319plc.64.1680748707082;
        Wed, 05 Apr 2023 19:38:27 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id ji17-20020a170903325100b001a3e8020348sm230082plb.3.2023.04.05.19.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 19:38:26 -0700 (PDT)
Date:   Thu, 6 Apr 2023 11:38:23 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 05/16] zram: return early on error in zram_bvec_rw
Message-ID: <20230406023823.GQ12892@google.com>
References: <20230404150536.2142108-1-hch@lst.de>
 <20230404150536.2142108-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404150536.2142108-6-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On (23/04/04 17:05), Christoph Hellwig wrote:
> @@ -1939,23 +1939,23 @@ static int zram_bvec_rw(struct zram *zram, struct bio_vec *bvec, u32 index,
>  
>  	if (!op_is_write(op)) {
>  		ret = zram_bvec_read(zram, bvec, index, offset, bio);
> +		if (unlikely(ret < 0)) {
> +			atomic64_inc(&zram->stats.failed_writes);

This is !op_is_write() so we need to increment ->failed_reads

> +			return ret;
> +		}
>  		flush_dcache_page(bvec->bv_page);
>  	} else {
>  		ret = zram_bvec_write(zram, bvec, index, offset, bio);
> +		if (unlikely(ret < 0)) {
> +			atomic64_inc(&zram->stats.failed_reads);

and ->failed_writes here.

> +			return ret;
> +		}
>  	}
