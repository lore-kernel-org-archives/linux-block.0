Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B195C76196
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 22:05:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjDFWFs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 18:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238077AbjDFWFp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 18:05:45 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BA1AD2C
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 15:05:44 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id nh20-20020a17090b365400b0024496d637e1so2895267pjb.5
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 15:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680818744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9a6/k/SzfTkZfewYomrOiasG9AATaeLvbMKSPSyuF8Q=;
        b=AQvQUZLpQ/Gwt1PUk4/NHqcObniGKxsZkf0NX4XUjTVZ9lv5qCTO/bWT8H24FUgouT
         8PUJOgo5sKEm3XirRWF5tcVAWHDjOEdppGEGi2XiKwnoZFVu1L2YE//znYKvLMRXImQQ
         bhLoGP3aMvv3c2VDnaTnACUc4G23vPRcvLyEbr2agBGuzxxPAuaJ0fJ7N7gGwz/7JkwA
         bhRlxvPIFY82yA5pPE81r9706BS9w0DG7v39i+cAXgWIOLYHpKUyXBN9Dd+zoS9DBieg
         rmhPRTPla+QjpYpIX0i93s/7ANhMBMSXH5RffujQs2AORTLFaIRGH0mumflDXbpJ14R0
         Ugyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680818744;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9a6/k/SzfTkZfewYomrOiasG9AATaeLvbMKSPSyuF8Q=;
        b=VLeLN+fzZqeUxK0iCLncu5o0P7qIaUyoAaZZHGUMQFEt+IQfoPnsT5wJeZ6AKr/igI
         OqT3oP1MRC9hHlZX7PwlEBEks5kl0V97XwGAgJ0XEpM++3uKr25rfgwAl+ThJOOBRaGs
         rOPulz5wKO3LP7fu6PeyRetdT976b/zrcGxPlr/zP8aO1fI2zNgH85uLh/IEI9Laregt
         8Wf7RbCz40XIFIc4jDDfwtksKEoTDsf5kwAfwN2+fFYt7F4sKkfDL4b4uFP1zLGTAkTh
         zQHb/cvSXlRX6uJ2kqd/5B6lTIq/oHo+XGl3043Sri+b8B92rTLJ3FyccgKwVJQVTog8
         Bs/w==
X-Gm-Message-State: AAQBX9dsDbQjugVgJJfm4Si0wvJi3GJhxtIL2li9VlKv5LBqfgD3E0TX
        Iefn3zq9ZzVZ/9L/ZTfFK8Q=
X-Google-Smtp-Source: AKy350YwsX0eR8eNvXgaQ8xUUPXSAT6m8If6PPVbbmfna9QKB/fiVR5ieV2aiSpNh7Lr8mIVqebihg==
X-Received: by 2002:a17:902:d4cf:b0:1a2:1a5b:cc6a with SMTP id o15-20020a170902d4cf00b001a21a5bcc6amr588845plg.40.1680818743954;
        Thu, 06 Apr 2023 15:05:43 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:6a8d:6a82:8d0e:6dc8])
        by smtp.gmail.com with ESMTPSA id g9-20020a636b09000000b00502e7115cbdsm1560056pgc.51.2023.04.06.15.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 15:05:43 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 6 Apr 2023 15:05:41 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 16/16] zram: return errors from read_from_bdev_sync
Message-ID: <ZC9CNbMgMPDO9w1M@google.com>
References: <20230406144102.149231-1-hch@lst.de>
 <20230406144102.149231-17-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406144102.149231-17-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 06, 2023 at 04:41:02PM +0200, Christoph Hellwig wrote:
> Propagate read errors to the caller instead of dropping them on
> the floor, and stop returning the somewhat dangerous 1 on success
> from read_from_bdev*.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Minchan Kim <minchan@kernel.org>
