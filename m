Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683CDC76196
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 21:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjDFVYu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 17:24:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238773AbjDFVY0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 17:24:26 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7FA8A4A
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 14:24:22 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id w4so38618569plg.9
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 14:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680816262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cQnx6CWs97HABdSj1WBg7W+dmeDj7oBw6VUesCl2p88=;
        b=XwdZiGmhfkUNDigtf54MZ1xCsBHO5KBrZ5YoW67vuqmK8M6Weu9gp0+OMa3+9vXHjU
         ikuIJ5uaReY8kBIcBweZNoUBfzAov/KzkwHKZGmBXnnRxvAsYgsuFXI4yND5cCbxXfL3
         oLmR4hr+Irm7PH9gaSrMANE6g3YA/HTSJYsVsBTryI8x7H0iDYJxzuMyRRjdKxhT6cvo
         1CBQIFJeM6v4y2kMrOMKe6DWR64cTF0gVenA2rWJn9H8OW41W8avHTqhablVKDsI6+vg
         sPZzMQI6dd3ittnwZZDkPAqEDo6t5l6EjNeuSK3DaqDQ/R5jQrZEK4lDBNVBUeZgRsKZ
         ez2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680816262;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cQnx6CWs97HABdSj1WBg7W+dmeDj7oBw6VUesCl2p88=;
        b=rLCEjc8mdY40yZF/MqoSyFolr+Db/JuWhHnv4d5kfZNN+T1PP65f90j/PXb/8nCybD
         bHhjdwVijlIN9iDuIVxNzNh8SnHkKd+2V5PZ7sH8+q2t3rrgs3rUeV8QHpHYAyjfwg8/
         j7Q5hYTc/cKIG3rY14/NwkmyK3Ab8Xfw9qT0ji8IUEolopU7uZykvCm2+1K6ukVJMeY7
         BotBuUlZz9JLh8JosDyUSbwMeqFeV9+Q7pJJk55sRkeMtrFtWnftcXO15LIVftdtTAHR
         +R92P+3C/tSbP++EU+rzI8pgnCYKnsR8urUXougBPuCQBqQJU7ehoX7bXsx2vOhNK9OY
         C69g==
X-Gm-Message-State: AAQBX9dIZqeOhRBvec5iyn2ojJhY3nWVYu9AnhcaA6O5d9PsFur1lmvc
        btbyqPS3/Hx1VRtak/qMZsg=
X-Google-Smtp-Source: AKy350betnGVNR1zoPuMBa8Mvcs0STHAj3iDjSWBHDv2sXVxg9RIVmDNA+IVw2CvxAmBiUUd78JtdA==
X-Received: by 2002:a17:902:d512:b0:1a5:918:df40 with SMTP id b18-20020a170902d51200b001a50918df40mr588617plg.13.1680816262171;
        Thu, 06 Apr 2023 14:24:22 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:6a8d:6a82:8d0e:6dc8])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902b19200b001a2806ae2f7sm1797939plr.83.2023.04.06.14.24.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 14:24:21 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 6 Apr 2023 14:24:19 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 14/16] zram: don't return errors from read_from_bdev_async
Message-ID: <ZC84g1Pm0vaQNEnp@google.com>
References: <20230406144102.149231-1-hch@lst.de>
 <20230406144102.149231-15-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406144102.149231-15-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 06, 2023 at 04:41:00PM +0200, Christoph Hellwig wrote:
> bio_alloc will never return a NULL bio when it is allowed to sleep,
> and adding a single page to bio with a single vector also can't
> fail, so switch to the asserting __bio_add_page variant and drop the

Oh,,,, didn't know it.
Great!

> error returns.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>

Acked-by: Minchan Kim <minchan@kernel.org>
