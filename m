Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55C29C77B6C
	for <linux-block@archiver.kernel.org>; Thu,  6 Apr 2023 22:06:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjDFWGm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Apr 2023 18:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDFWGl (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Apr 2023 18:06:41 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEE80A5CB
        for <linux-block@vger.kernel.org>; Thu,  6 Apr 2023 15:06:40 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id p3-20020a17090a74c300b0023f69bc7a68so41942170pjl.4
        for <linux-block@vger.kernel.org>; Thu, 06 Apr 2023 15:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680818800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ITpgZktaxq0DUf0c/nn0Wcy2+ASjfDehHOTvCUXDTsU=;
        b=e6id0shxHi5L5cekX2xuamK/TUrGrBmus07f24dzlSc1Rqy1I6vf0Y2JIRfScItNz2
         jAL3pUoKF689fxnNFIOI/jA45Yk4xxaHlq8OwftpDk0HrySoU+tKPvxRm1YXsNb9koCf
         ifsqbOsc3XXFk93vDIqUSUGJsUbqGsOAil8hOrLvokvPgibsFV9DxdrSxqHvhfIidujI
         hVZzQe4FxULRdCAiQQTDXvGm2PK4QiIOgH2BJ0HMZr9b87osk8SBNK0tVPukC6XEN7Lg
         rA8aF7BjLP3ozJnR1NRLlHiWnKsjeo7qsMr/M+SylWrP3/0UJUd0kLdbYto1We5TGwVm
         Pq+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680818800;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITpgZktaxq0DUf0c/nn0Wcy2+ASjfDehHOTvCUXDTsU=;
        b=iCzLj52cXKm3wMIFZu27apOQdFh8zdvDKuyWWFvrpb/mVqe2c+xu9TJHri9q0LrKFT
         2i5mFEWd+/YEP6KcjGjIvPWaRMIR4Lthh+ZVmvaw9LM3fFXkALZr9l69oCquDjMckaKr
         +l1uiao7gddonW1brytlzM4ODBf28Ar2iAcqmdMNZ2P+FOgL+E5wB3i+rCSGhWQKum5o
         5P2Glupaf4HFZ6W+taX3l9L8I+uO/PwCahl0w5K3wnRGQf1OsPBF6wm2sSSa1QiOCXYJ
         wlYagfflWIL9pjjCJJEim8sC6JECVstHupK1qHTlrtq7vWqXAlKsg88Uo8Bm9vA/LaNj
         dZWw==
X-Gm-Message-State: AAQBX9curNXFDgqqf1760jUwTs4nY+Ay4HxnrKrVAWKNEf+hq4yMQ8+B
        RpsKY+yRRPn0jDBhSq336PE=
X-Google-Smtp-Source: AKy350YLEn3LnQGDjuLre4nFF55VZuy5YDOPvyXhAiXv0FQqAq0XzF2PNE2tZCh4Pz1CQzM+x4nheg==
X-Received: by 2002:a05:6a20:659c:b0:d9:b820:10a4 with SMTP id p28-20020a056a20659c00b000d9b82010a4mr20095pzh.8.1680818800257;
        Thu, 06 Apr 2023 15:06:40 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:6a8d:6a82:8d0e:6dc8])
        by smtp.gmail.com with ESMTPSA id v12-20020aa7850c000000b005da23d8cbffsm1781655pfn.158.2023.04.06.15.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 15:06:39 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 6 Apr 2023 15:06:37 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: zram I/O path cleanups and fixups v2
Message-ID: <ZC9CbeXxf/sIr7sU@google.com>
References: <20230406144102.149231-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406144102.149231-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Apr 06, 2023 at 04:40:46PM +0200, Christoph Hellwig wrote:
> Hi all,
> 
> this series cleans up the zram I/O path, and fixes the handling of
> synchronous I/O to the underlying device in the writeback_store
> function or for > 4K PAGE_SIZE systems.
> 
> The fixes are at the end, as I could not fully reason about them being
> safe before untangling the callchain.
> 
> This survives xfstests on two zram devices on x86, but I don't actually
> have a large PAGE_SIZE system to test that path on.
> 
> Changes since v1:
>  - fix failed read vs write accounting
>  - minor commit log and comment improvements
>  - cosmetic change to use a break instead of a return in the main switch
>    in zram_submit_bio
> 
> Diffstat:
>  zram_drv.c |  377 ++++++++++++++++++++++---------------------------------------
>  zram_drv.h |    1 
>  2 files changed, 137 insertions(+), 241 deletions(-)

It really cleaned the zram long time mess.

Kudos to Christoph!
