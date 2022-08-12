Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DCDC00140
	for <linux-block@archiver.kernel.org>; Fri, 12 Aug 2022 07:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236950AbiHLH0Y (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 12 Aug 2022 03:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234733AbiHLH0X (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 12 Aug 2022 03:26:23 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12CDF844D6
        for <linux-block@vger.kernel.org>; Fri, 12 Aug 2022 00:26:22 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id l4so215234wrm.13
        for <linux-block@vger.kernel.org>; Fri, 12 Aug 2022 00:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc;
        bh=I14AutUzCSKXAFyUQ0U7eTU8eBhlWiTNn1tQkj88beo=;
        b=fKyggbz2ch5M50EqTkhxa7SXdPpnFQfdZF1S5DrBWNd1AnwGIvO1Sw6k+kcJsoBe/z
         JV/qVYbRCghXPQx1Q8kOPsWeuC9sFdphj83iZkLG5bBVjnXwqH15diBcYUiemWTB6r7q
         dFjt2IORXM8IoK6YEDdNhiCKz1dRLwPp5/lCP4Nas+Z7GrTD+8XK1mTyNhqGs0bkFo2n
         6kYv6k6mJwgAoOlYKNAGhpOZMWRJIGXHr8v5vgZbj+M2qrfgeXU9ynlbW4sYMmqFPokN
         jSzXcPTGVn4qBxktSYI2K2qhrZzaJawfstnKMNt+prwfqliPLlpUYal0M9NxOKZuRbT1
         i+vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=I14AutUzCSKXAFyUQ0U7eTU8eBhlWiTNn1tQkj88beo=;
        b=GXWbvNCm0UDmsipY9nqkBR+klTAtarQkqGBZrnOMw0SDmBosCyGWORRqzbpHD0a4NG
         45Yv2nTagF4gGpGEh6eJLHAnGBcok3PfcsqSpTcf4ChhVGEfaaiBmQ52pMcTF8qEkNHc
         z2v23ccS+O3NXNAnW/55gR0/qJi6Mf86UDl3ABeSblrWCQS6F9E2VR51rSZAIuyNQKXL
         CMrMt1JWtaTBA2q23taGwXOTDMMnrbi7Y9XN5nyljJqT3Ow4vRzGHZG3cpP1Jb0zCzuB
         NxEAkFWBGnpunnm3yON5piCO5V/LN8XzwFMX3GZ0iaNCxAXCSaTC13d/HZaMe3l5aH6v
         IwNg==
X-Gm-Message-State: ACgBeo1LwqH2t0xsqYmsgR8gd16jHNMBZXx6KtdNOz4Cg3pkvxEzRcQ9
        lRWVHHlsraxit99noKRDuL1zLA==
X-Google-Smtp-Source: AA6agR4ypeHLIsU4OrZxsv9DoMMadQvxkF3MezICacx6V/qcqizlkeepyNDhOgmVGNZHtZoaRniDoQ==
X-Received: by 2002:a5d:4646:0:b0:220:5c35:d4f2 with SMTP id j6-20020a5d4646000000b002205c35d4f2mr1263398wrs.475.1660289180584;
        Fri, 12 Aug 2022 00:26:20 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id t19-20020a05600c199300b003a31c4f6f74sm9277606wmq.32.2022.08.12.00.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 00:26:19 -0700 (PDT)
Date:   Fri, 12 Aug 2022 08:26:18 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "zhangwensheng (E)" <zhangwensheng@huaweicloud.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Lee Jones <lee@kernel.org>
Subject: Re: Question: consult patch
Message-ID: <YvYAmmaJgvydex4p@google.com>
References: <420a6c4a-e526-4e8b-d5bd-563c40aa94e1@huaweicloud.com>
 <YvXo1uCFA57t89Nv@infradead.org>
 <902a45fe-1117-3f6a-b7b1-9b155e5dd984@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <902a45fe-1117-3f6a-b7b1-9b155e5dd984@huaweicloud.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, 12 Aug 2022, zhangwensheng (E) wrote:

> Hi
> 
> In CVE list last week, there is a new cve reported in asop 4.14 like below:
> Reference link: https://lore.kernel.org/all/CAODzB9rgMexvLjE=WuTm+SN8SfUggaZgWG-aBcy6cotppju6mw@mail.gmail.com/T/
> 
> ---
> CVE-2022-20158: mm: backing-dev: Take a reference to the bdi in use to
> prevent UAF
> 
> CVSS v3 score is not assigned.
> 
> AOSP kernel 4.14 contains following 2 patches.
> - 69e8f03c5ced3e4e6fb4181f4dac185104e3420b ("mm: backing-dev: Take a
> reference to the bdi in use to prevent UAF")
> - 80d91b86a199798ee2321a0ab0f09e6e12764678 ("fs: explicitly unregister
> per-superblock BDIs")
> 
> The first commit 69e8f03("mm: backing-dev: Take a reference to the bdi
> in use to prevent UAF") is not merged in the mainline and stable
> kernels.
> Commit 80d91b8 was merged in 5.16-rc1(commit hash is
> 0b3ea0926afb8dde70cfab00316ae0a70b93a7cc) which requires commit
> c6fd3ac ("mm: export bdi_unregister") that exports symbol of
> bdi_unregister().
> 
> Fixed status
> mainline: [0b3ea0926afb8dde70cfab00316ae0a70b93a7cc]
> ---
> 
> As mentioned above, patch 69e8f03c5ced ("mm: backing-dev: Take a
> reference to the bdi in use to prevent UAF") in asop 4.14 can fix
> a null dereference problem, form my analysis, may like below:
> 
> blk_cleanup_queue
>     blk_put_queue
>         kobject_put(&q->kobj)
>                 blk_release_queue
>                     blk_exit_queue
>                         bdi_put
>                             release_bdi  // bdi -> null
> del_gendisk
>     bdi_unregister(disk->queue->backing_dev_info) // null -> reference
> 
> From my analysis, In asop 4.14 kernel, in loop_remove function, there is
> such a timing that executing "blk_cleanup_queue" first and then
> "del_gendisk".
> but because of the refcnt of queue will add by hte line
> "WARN_ON_ONCE(!blk_get_queue(disk->queue));" in "device_add_disk", which may
> not result in "bdi_put" releasing bdi  in "blk_cleanup_queue".
> 
> I'm not sure where the problem is, so I want to ask Lee Jones who sent this
> patch
> for clarification.
> 
> Thanks!
> 
> Wensheng
> 
> 在 2022/8/12 13:44, Christoph Hellwig 写道:
> > On Fri, Aug 12, 2022 at 11:34:59AM +0800, zhangwensheng (E) wrote:
> > > Hi Lee ：
> > >      I saw your patch because of CVE-2022-20158, the patch like below:
> > > 
> > > ---
> > >      mm: backing-dev: Take a reference to the bdi in use to prevent UAF
> > I can't see that patch anywhere, and I've not seen an bug report for it.
> > 
> > >      Because of a distinct lack of locking and/or reference taking,
> > >      blk_cleanup_queue() puts the final taken reference to the bdi, which
> > .. and blk_cleanup_queue also is gone upstream.
> > 
> > What am I missing?

The issue reported in the aforementioned CVE was caused by a commit
which was applied to an internal, device specific repository.  One
that has never existed in Mainline.  I failed to reproduce the KASAN
report in any upstream or stable tree without the offending patch
applied.  The issue was fixed in all affected internal trees.

-- 
DEPRECATED: Please use lee@kernel.org
