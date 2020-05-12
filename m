Return-Path: <SRS0=GKfo=62=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED649C81826
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 09:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC0E22192A
	for <linux-block@archiver.kernel.org>; Tue, 12 May 2020 09:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="M+XOt9U5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbgELJDW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 May 2020 05:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729459AbgELJDV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 May 2020 05:03:21 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D66C061A0C
        for <linux-block@vger.kernel.org>; Tue, 12 May 2020 02:03:21 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id f134so8686934wmf.1
        for <linux-block@vger.kernel.org>; Tue, 12 May 2020 02:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Rz7gFzEXdqOY+Id7vQxHVv/zsVbUm1g62miHZ/3Yi58=;
        b=M+XOt9U5zrxkajsUSZNtmrRv5c60xtcj21c66pNLHunA7xbTlrnyYzdvVqRRXx3T6z
         +7RjZaPRrt3Hm5yBeAhaSM3IKIELCiUHeIaHC3THeZYRFGbaSL51Osn64ezRBG8B3HEc
         eLCBcfO4bjfRrBoaeVHXN4rYRWtTG9Q/tOCY9WWPlqk2RQCEtzVAsB4Px2HQvl/VggJh
         Tr+rlBbX8dBQgbNxoSVwWgBcGLRjwwnslY9ePNwtCfj3mBXgr/k7mwMHmr62adx76qfB
         Lqn9H5r0lep+79URCDV7YoJPOR6tLv4MRN62grOLWRgOjM31Z+beCEipk4MdS3Zo/J7e
         vKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Rz7gFzEXdqOY+Id7vQxHVv/zsVbUm1g62miHZ/3Yi58=;
        b=BCQ7yKLiq/SsuQ1nw8x1KsSn6uT0pRvBg1ecy4zOAUaP3ZV9rqL3FpGwi+lUWdeRK5
         zSI97CJkijWMFUnB0mN3qBP0yyDGY9lhln7E+dRlG6jP1pDgR45SY6wATTfokzL5mFoT
         eCMGuMcJBG99GZh3TAsKBwqIEnAYtiBDTsOzb6lKzKLae1Uttgx0PwSY3E65V2PemAac
         SvyK7iN42N/xROZ5tTEtL0jyday/vSioccVOEfW4X8kiUvVoMaPtudY2pfFwwSwwmxRK
         w01QbUrAIEBmMduvRklDSGyb54/ujWdA2nPhx8EtQ7B1FhnoUrAjAisc2dtwJlCM6Jve
         6Dog==
X-Gm-Message-State: AOAM532j1IoLU2vCCxJTYRVSQal5nfHIkVG/cEF7jYaWCjvz4WljZHgg
        rOSSuccKcMq79YA3ECOwUC9K4rCDhu5J4zVU
X-Google-Smtp-Source: ABdhPJxBCKZtHScAoBua0UNU9O6gSTLZGkyhzbNTquuionWBb55nVCzXfH1bTz5umi0AN1PnQlUnvg==
X-Received: by 2002:a1c:ba83:: with SMTP id k125mr2617536wmf.20.1589274199719;
        Tue, 12 May 2020 02:03:19 -0700 (PDT)
Received: from localhost (ip-5-186-121-52.cgn.fibianet.dk. [5.186.121.52])
        by smtp.gmail.com with ESMTPSA id g6sm21782449wrw.34.2020.05.12.02.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 02:03:19 -0700 (PDT)
Date:   Tue, 12 May 2020 11:03:18 +0200
From:   Javier =?utf-8?B?R29uesOhbGV6?= <javier@javigon.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     linux-block@vger.kernel.org
Subject: Re: [bug report] lightnvm: pblk: return NVM_ error on failed
 submission
Message-ID: <20200512090318.svnr2iqpyowh62bs@mpHalley.localdomain>
References: <20200511135058.GA216886@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200511135058.GA216886@mwanda>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11.05.2020 16:50, Dan Carpenter wrote:
>Hello Javier González,
>
>The patch b6730dd4a954: "lightnvm: pblk: return NVM_ error on failed
>submission" from Jun 1, 2018, leads to the following static checker
>warning:
>
>	drivers/lightnvm/pblk-recovery.c:473 pblk_recov_scan_oob()
>	warn: 'pblk->inflight_io.counter' not decremented on lines: 426.
>
>drivers/lightnvm/pblk-recovery.c
>   417
>   418                  for (j = 0; j < pblk->min_write_pgs; j++, i++)
>   419                          ppa_list[i] =
>   420                                  addr_to_gen_ppa(pblk, paddr + j, line->id);
>   421          }
>   422
>   423          ret = pblk_submit_io_sync(pblk, rqd, data);
>   424          if (ret) {
>   425                  pblk_err(pblk, "I/O submission failed: %d\n", ret);
>   426                  return ret;
>
>The pblk_submit_io_sync() increments the pblk->inflight_io counter but
>doesn't decrement it on all error paths.  It looks like something a
>little bit subtle is going no but I'm not sure how it works exactly.
>
>   427          }
>   428
>   429          atomic_dec(&pblk->inflight_io);
>                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>
>   430
>   431          /* If a read fails, do a best effort by padding the line and retrying */
>   432          if (rqd->error && rqd->error != NVM_RSP_WARN_HIGHECC) {
>   433                  int pad_distance, ret;
>   434
>   435                  if (padded) {
>   436                          pblk_log_read_err(pblk, rqd);
>   437                          return -EINTR;
>   438                  }
>   439
>
>regards,
>dan carpenter

Hi Dan,

As I recall, we used this counter to see the total I/Os that were
submitted through pblk and wanted to keep track of how many of them
completed - so the error path did not decrement as it was I/O that had
made it to the FTL but had not reached the device.

I can see how this is confusing, as through time we introduced dedicated
counters to the failed I/Os and inflight became a counter on I/Os going
to the device.

I believe we can fix this by checking the return value on the submit
functions and decrementing in case of error.

Do you want me to send a patch or you want to fix it yourself?

Thanks,
Javier
