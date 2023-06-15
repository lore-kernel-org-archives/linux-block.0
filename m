Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40257EB64D9
	for <linux-block@archiver.kernel.org>; Thu, 15 Jun 2023 02:17:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237338AbjFOCRk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 14 Jun 2023 22:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241113AbjFOCRk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jun 2023 22:17:40 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441382735
        for <linux-block@vger.kernel.org>; Wed, 14 Jun 2023 19:17:16 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-3f9e36e5ea8so25447111cf.3
        for <linux-block@vger.kernel.org>; Wed, 14 Jun 2023 19:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1686795435; x=1689387435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=85Z0uYT5Nl/EvJTfOgIEe7E+EGlrziVxkO6bFL1/58I=;
        b=WoS9AwF0Sl7PZaAkQ91Db0FDd6+zSdm0MwWCLvLRAO4jVKf53J4hCKnuG2Xr1NBrxU
         jwEoANHFxaRAUsz+qaBKAOUyfKqsKPOgMgSHViP0jf5ve8Tx78PCtYAXAZ9sjNaH2xh8
         jMcefhGnQKQLl5cy+RCUM+NozxwxhhBIY82nMMxLiHViYXXPtGuJ90p/dze1GXb2hmNx
         tUShCfLtRGgzdLO2/lJtjckVTeaYeMDmjBZFSfMnht7wHwgK+BSpy/4CYxiBZldOfCue
         eSiymuLshcTeHx1L76JatRV1eJWtLF7mODFwxgmp21uB9eUHHvxHugdn1mVLm7m77GRq
         vL8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686795435; x=1689387435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=85Z0uYT5Nl/EvJTfOgIEe7E+EGlrziVxkO6bFL1/58I=;
        b=VdnxYV/VzbX6q7bRf4Hir0qC7BsNQUCMMjWrvbDaNpV0UoDvy3NOAgcgwE2b35SpgI
         1PMK239BvtPgUo/BSaMMhUaGu1qjh3HgMl69y0UEVeFlW1xN0T/JzGTzcuC5dSwOGpuz
         PoBLyXjNObipgChOIv8AZq4YoTee/SQA/vB68kU5Ug31rBlWH2RgnxanFX3UA3gy5CoB
         SbrLqBFBRnU/UtJavGO/mzEcnX/TZJi0l6RLgtOvNYbeepX0YZ1Sag2eYeTF5Wg9S4FC
         xyPt1l5ii7G2HbgrpvnPXz7jZvk/AJH/DK1eV3dEBt6DwVk5lwfaNAGc1kOk9fKrssE3
         bYYA==
X-Gm-Message-State: AC+VfDwAa4cGjZp67BgwczwLUfyKvxAoDyWBkEihy67gcpnxs/ubX+ho
        20hBWu1sYRdFAezFEnZJK3V5tw==
X-Google-Smtp-Source: ACHHUZ4goXHljgEoJlG9j+9Uj00Cw1Q5b8I2MZhOzdkqgDpqmjTTQ4qsL6jiEIQdHUJGaLdgSBJ9EA==
X-Received: by 2002:a05:622a:181c:b0:3f2:25e6:47bc with SMTP id t28-20020a05622a181c00b003f225e647bcmr3847309qtc.68.1686795435207;
        Wed, 14 Jun 2023 19:17:15 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id k15-20020aa7820f000000b0065e279c5c2csm10932058pfi.181.2023.06.14.19.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 19:17:14 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q9cXw-00Bu0v-1F;
        Thu, 15 Jun 2023 12:17:12 +1000
Date:   Thu, 15 Jun 2023 12:17:12 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 4/7] brd: make sector size configurable
Message-ID: <ZIp0qH3CAMr1mGzX@dread.disaster.area>
References: <20230614114637.89759-1-hare@suse.de>
 <20230614114637.89759-5-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614114637.89759-5-hare@suse.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Jun 14, 2023 at 01:46:34PM +0200, Hannes Reinecke wrote:
> @@ -310,6 +312,10 @@ static int max_part = 1;
>  module_param(max_part, int, 0444);
>  MODULE_PARM_DESC(max_part, "Num Minors to reserve between devices");
>  
> +static unsigned int rd_blksize = PAGE_SIZE;
> +module_param(rd_blksize, uint, 0444);
> +MODULE_PARM_DESC(rd_blksize, "Blocksize of each RAM disk in bytes.");

This needs CONFIG_BLK_DEV_RAM_BLOCK_SIZE to set the default size
for those of us who don't use modular kernels....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
