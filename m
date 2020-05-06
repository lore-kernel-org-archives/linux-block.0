Return-Path: <SRS0=ToMJ=6U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EEFC28CBC
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 09:55:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAFA52082E
	for <linux-block@archiver.kernel.org>; Wed,  6 May 2020 09:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="LEfzudg1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgEFJzs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 6 May 2020 05:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728306AbgEFJzs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 6 May 2020 05:55:48 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB58BC061A41
        for <linux-block@vger.kernel.org>; Wed,  6 May 2020 02:55:47 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 188so797240lfa.10
        for <linux-block@vger.kernel.org>; Wed, 06 May 2020 02:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m1a2PkwV2T8+2DItaMD9IItjhWohAns0GTTh7+ScaUs=;
        b=LEfzudg1N43QZjTlPIxvvlD34Fb6yTWkxh+eLzWYTWcd/9UIKEfv5stX7ryBfvg9g6
         4FEWoUoC0LtPshkhjHT4vcyfMfYAn7ZPnLGdV5/iXBcWvyh64jodk2owgmeghnA//F6e
         ZtjpQwu9epWZIkLsWcpWCdbHh5nw0dZvRcxTyoYXHqY1aiPCLmegMHCyERwAWp8D5r4x
         q/dUEV4ApkG8PhkWIGCcm4QybyLXmsMtZCsXevtDVeVEdX96M2IQT15/txUTjfBPfHLH
         JlWG+5IWq6iYWsB5a2TRaUPEHo4iV6r8MtxUDWgVqL4/4pHEP//ovBgnH47kQDKJep1D
         OMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m1a2PkwV2T8+2DItaMD9IItjhWohAns0GTTh7+ScaUs=;
        b=aIFsL1V9tHYSB7Do/M9kjTqVCL1Iskltxaenb6/HVqU6UqxwNOuf+RIhaSVOlxsNyw
         nhLA6QXJif6XG/+EuRB+CTcG+kV88XSVcxPmBUaaBzYnB9/HXBtlT5ebKPUVw/VLwPXi
         3QAHYzSvfGuSI4nrONwIIArFLqSAum3NZCzr1WUT2mlOydbKZeHAaY0tqE0vNweeLHD8
         MTM0ptRqayhXOd3AAPr+LBdLjlRtpiNSP9BoUFVfdHKAroudEZXCRWRJMtJRcALLo3us
         jtzAqKbWweFaasU0gEziZsMJ+O6BavKEmUOGLJJZDXV6hVeOQ138MFpsfQaBQne9zNbh
         lV3g==
X-Gm-Message-State: AGi0PuY9ZdHz2sBF8O5BqNnOKMM0xYZX4E5Nj3Q2wl5ew3E3GZT+aKvM
        P16L7yqBk+RG17HO/JjyO1QrB+b7pDFo7eGb9t9nog==
X-Google-Smtp-Source: APiQypLdNRgTNoQn8s2a3BYqZvwycVrjdkmthqtUlOrX/8qrQhGr8sPiDSuHTs/DQ6SNcIRcaTksALi7ftLxDj5RWzI=
X-Received: by 2002:ac2:4546:: with SMTP id j6mr4684635lfm.203.1588758945507;
 Wed, 06 May 2020 02:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200429140341.13294-1-maco@android.com> <20200429140341.13294-11-maco@android.com>
 <20200506060944.GG10771@lst.de>
In-Reply-To: <20200506060944.GG10771@lst.de>
From:   Martijn Coenen <maco@android.com>
Date:   Wed, 6 May 2020 11:55:34 +0200
Message-ID: <CAB0TPYEz=GLWEtBX5ndd1p-wBRBwVAOqBW=E1rTvRrLYRgiFqQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] loop: Add LOOP_CONFIGURE ioctl
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>,
        Narayan Kamath <narayan@google.com>,
        Zimuzo Ezeozue <zezeozue@google.com>, kernel-team@android.com,
        Martijn Coenen <maco@google.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, May 6, 2020 at 8:09 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Thanks, this looks very nice!

Thanks! And thanks for all the feedback, it has made this series a lot cleaner.

>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> Are you also going to submit a patch to util-linux to use the new
> ioctl?

Yeah, I'm happy to - will do it as soon as the series lands.

Best,
Martijn
