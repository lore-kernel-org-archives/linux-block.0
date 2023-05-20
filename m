Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB2C8C77B7A
	for <linux-block@archiver.kernel.org>; Sat, 20 May 2023 01:49:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbjETBtW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 May 2023 21:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjETBtV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 May 2023 21:49:21 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31889116
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 18:49:20 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-24de62e16bcso7532a91.1
        for <linux-block@vger.kernel.org>; Fri, 19 May 2023 18:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684547359; x=1687139359;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/4lk+YqVoFcHZZeklYb1IqkqFco4kh/SKJmqVGs5no=;
        b=eqeIlUNCWIdXizHbTXdLWR3A6Q5KAROXVpkekoeXjVGuT29AGCif5DAI7mS/WVV8Je
         5kmnjngzjosIwizIbMJl4QfPiTbsSF7zBJUNdwOSBv0UBzwHFU7HEQxDc/YhwSteFNHN
         WfyBF7+IFeqF0cic5xLaKXHtbWJoitX3ej3jIN+QNVP0MhscsAbOOKx0La5LTEQs8+n1
         b8S7Hspirhbh60Q8CKzJv1AGeu7iE5Udn0FcImTBDmaiHf6OMGf/Vi7G/9BJ+FWY+zL/
         2RsuHODvS8FGvsg5QC+zsfGXMmpedFkm6gwKjPx9rzsUzqWoFPTojRSUuM30MBl4jUwo
         1QOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684547359; x=1687139359;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/4lk+YqVoFcHZZeklYb1IqkqFco4kh/SKJmqVGs5no=;
        b=K4AtFSjBtQYiWnDTv0SeObGuUQ7lL7/P6sKEpfobXEB//UnYSZXfulofky+y6x/sx6
         WwexcnaZHcMT6/xKMgntVdzKTEZvsRqWw2X+3LO3r68959mb6eSKnaRVrfXJtwjwZzV8
         2A/i504VwbF6EVbkeGg/mypzMZqV/eYOcl6MVRLZBgejTHNNC8HMKqR+LFsz7reISvdE
         cZrv5Oeg4HtnvNXYTYRF61U6TAKZgSoXCiPSjOhIYVpWgRsHc8pOARB834Zr1U4wDMZd
         77AEuwI2bmoihWHIvLeJnydhow79hSL11dKMF+xIorCyvRPOpEmU+T9iyK+ENpPbEsbr
         8NRQ==
X-Gm-Message-State: AC+VfDxVIeqlRnAXBpK2T37wFCXy0/+860Mvt+c87SWrhCEbJQKReRar
        i89aX9wpzwMX7MMxnNHIl3xWGav9T+W3wlPTmBY=
X-Google-Smtp-Source: ACHHUZ4P+a03AJM5Q6L32Pcjt9zP0TR5BCpTwt/lcldYH+kScI+4berIfdpDW7cQIvW6dLM47Z6H5A==
X-Received: by 2002:a05:6a20:7d8a:b0:101:186:21d2 with SMTP id v10-20020a056a207d8a00b00101018621d2mr4423340pzj.1.1684547358997;
        Fri, 19 May 2023 18:49:18 -0700 (PDT)
Received: from [127.0.0.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h34-20020a635322000000b004e28be19d1csm346938pgb.32.2023.05.19.18.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 18:49:17 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jinyoung Choi <j-young.choi@samsung.com>,
        linux-block@vger.kernel.org
In-Reply-To: <20230512133901.1053543-1-hch@lst.de>
References: <20230512133901.1053543-1-hch@lst.de>
Subject: Re: rationalize the flow in bio_add_page and friends
Message-Id: <168454735757.379441.11939069540705924109.b4-ty@kernel.dk>
Date:   Fri, 19 May 2023 19:49:17 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-00303
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


On Fri, 12 May 2023 06:38:53 -0700, Christoph Hellwig wrote:
> when reviewing v2 of Jinyoung's "Change the integrity configuration
> method in block" series I noticed that someone made a complete mess of
> the bio_add_page flow, so this untangles this to make the code better
> reusable for adding integrity payloads.  (I'll also have a word with
> younger me when I get the chance about this..)
> 
> Diffstat:
>  bio.c |  123 ++++++++++++++++++++++++++++--------------------------------------
>  1 file changed, 53 insertions(+), 70 deletions(-)
> 
> [...]

Applied, thanks!

[1/8] block: tidy up the bio full checks in bio_add_hw_page
      (no commit info)
[2/8] block: use SECTOR_SHIFT bio_add_hw_page
      (no commit info)
[3/8] block: move the BIO_CLONED checks out of __bio_try_merge_page
      (no commit info)
[4/8] block: move the bi_vcnt check out of __bio_try_merge_page
      (no commit info)
[5/8] block: move the bi_size overflow check in __bio_try_merge_page
      (no commit info)
[6/8] block: downgrade a bio_full call in bio_add_page
      (no commit info)
[7/8] block: move the bi_size update out of __bio_try_merge_page
      (no commit info)
[8/8] block: don't pass a bio to bio_try_merge_hw_seg
      (no commit info)

Best regards,
-- 
Jens Axboe



