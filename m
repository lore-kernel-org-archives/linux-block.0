Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DCFC7618D
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 21:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239362AbjDFVMx (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 17:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239387AbjDFVMv (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 17:12:51 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13B2A5D9
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 14:12:47 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-2449654f8c0so26044a91.0
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 14:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680815567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1IxPcv87mOeZz2vtcFDTt245Td0JuJCdvSMMPd7snNo=;
        b=dHozf+lKHkL5GoDO+y/8E5aABe2+lk3OZYhlYNaY1LS5ByLR7nCmpdoh9IXInI1ZTW
         IIvrrOjaRDKW68Vil50OFnplqvpjKV1Su+bRwpctc7X3N8dsXhXVaOraJ23x1DoPeMsy
         XD+PBBktxOawzTJOyoxQtU2XwWnSWw1cBcCaawqwRNB21r+w2J7z/Xk1IDCDi873desy
         a0VVlLyr7Alaluoqu3aC3FZYtjrJuIHkt42xupsZO+i11s3D5D0d6xEYTtXGPnnLp5K2
         8b8ApDXDt9me4y4afzB33GOUzt1JfvD268lTRo4MWytYENI+1SDpwpDkHTFYIfNSgFLQ
         50Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680815567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1IxPcv87mOeZz2vtcFDTt245Td0JuJCdvSMMPd7snNo=;
        b=Eat0UYvDY06zku4gE4+qMnQspLwOsfzZZ+mZPwAGiYgg8c8B1ZpybN9GbB2fSBH+gP
         qQk716YdvwTvJirNcl1OFMRzUBGYKZ+VEZEM4oU2wt16SfcXQ07spHtjVbdg9LBVkqV0
         fL+jy7zIZSUIWfEi1f/xBDwMSsDr0swoG/wF1OrHU7s62mf7qjk4uWYAbgEvb6616qvq
         27AVIZvDFTL+SRA3ZbE7ar0T/d3/jwVyLw3HfkINX3K89+R1gHK8Wu2M9UDKUcbMcxA0
         yEDjL8rp0m8hH2oPE60fO4XzmvjjI15dTfy/YbWf9EJUfdaC36J6fjYJVczbbf6sJIwe
         bu0g==
X-Gm-Message-State: AAQBX9dkUdZbagc3cjIe2jYNj/QnH6YN//RnsZpia3kf9H2g7y0CwKv7
        8/tX5Q7CWxetE/zhr3y20Hl1rZlbNgI=
X-Google-Smtp-Source: AKy350bZJ9Vwi32p7FtRKQ5DSMoIZ618ZhYcq6eaNLPV1W97PzkG2+uOQYpv29NKPWgxc+927USC/g==
X-Received: by 2002:aa7:960f:0:b0:5a8:4861:af7d with SMTP id q15-20020aa7960f000000b005a84861af7dmr208229pfg.20.1680815567185;
        Thu, 06 Apr 2023 14:12:47 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:6a8d:6a82:8d0e:6dc8])
        by smtp.gmail.com with ESMTPSA id 25-20020aa79119000000b005ac419804d3sm1744699pfh.186.2023.04.06.14.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 14:12:46 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 6 Apr 2023 14:12:44 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 04/16] zram: move discard handling to zram_submit_bio
Message-ID: <ZC81zDjGdVk2D1gB@google.com>
References: <20230406144102.149231-1-hch@lst.de>
 <20230406144102.149231-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406144102.149231-5-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 06, 2023 at 04:40:50PM +0200, Christoph Hellwig wrote:
> Switch on the bio operation in zram_submit_bio and only call into
> __zram_make_request for read and write operations.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Minchan Kim <minchan@kernel.org>
