Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24ECBC28B57
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 02:17:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CD3460F9D
	for <linux-block@archiver.kernel.org>; Tue, 21 Sep 2021 02:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346089AbhIUCRj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233073AbhIUByS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Sep 2021 21:54:18 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4A7C0EDAF7
        for <linux-block@vger.kernel.org>; Mon, 20 Sep 2021 16:37:33 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id bb10so12133676plb.2
        for <linux-block@vger.kernel.org>; Mon, 20 Sep 2021 16:37:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fF0TCTjeEHkCVv6xpdHuJdavcWQVB5eohqIs8o03UdA=;
        b=P5C3ARdy3+RMB5+/3T2u/5p624EzdMi+ZOVC/bDgjdkc5T2B0TDDI6KuW+OMeZQfVV
         mc2qqOApF0mOumKhbxeUZBHAatTJ1GAH+sZHLiCPNVnocX7/g2WwalLRkSr73pHe4Rk7
         /X6WFPMtP2tKJbIi7SnCB/jNqAL0TpXFpqfNY/OLfrPE7WtXmv3CEFXBFIwWPZ/FKYpH
         6sbhq7KhYs0UBrHvenrrOi1k5l1+lgbYwP4KFYyxt77O+LdMKxmDgPwYti8G8ua7j2xg
         a8dKy6pSzq8KlM11K+8DBom5vfN3OBlHuQQiMbaUlVy9q6f7JGm9M6K3f4ovMh9LQEbK
         oBfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fF0TCTjeEHkCVv6xpdHuJdavcWQVB5eohqIs8o03UdA=;
        b=Octi8OrwssoSe5uT5rQ7s3i7GjS1WlE5RcX4vgjFSIyCBiPt8NZRb4AeEWb07PxIrp
         Iecmx5FCS7lQuesEGRHnU4NZWeX7bTDNWX6grLvJj16oEMzt3+i/gWE3ew7VVVSpCQ4r
         HplnZuOren/0KZzxI5cH/zcFicT3BIdQtPTU7OPeTnCE5I0jpYYtDIdrBmz6nl3yfeeC
         0stvysHIf8iP3C3bFy07Z3LF3WoL4+K5eGxCxCMOxXT5t04DCl/TgBR2or1WKp/avCQL
         laOcyuGTNO9X1oVYyIoOw1utlAGdjoCGtV3E4DTvW26KU6hIa6MI5thZavKsBVlYuq2O
         kHxg==
X-Gm-Message-State: AOAM533Ivx13ilQElEK7sJZAP7nMK9zE1bho7wiCqoe/Le/nmIm3e0/b
        mNVRBcGFBg3ha+xeCpmrf3F5bjzYD75f+vcNZ7jA/A==
X-Google-Smtp-Source: ABdhPJzQO/CQq0iHCsKH/QNdbS8qNKnmFW6qjPLg5q6lCcSBWHVGyHuGIILH0iBAMv7pOzaCIxTvJ+y3tKSJ/T/m3dY=
X-Received: by 2002:a17:902:e80f:b0:13b:721d:f750 with SMTP id
 u15-20020a170902e80f00b0013b721df750mr24772956plg.18.1632181053137; Mon, 20
 Sep 2021 16:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210920072726.1159572-1-hch@lst.de> <20210920072726.1159572-3-hch@lst.de>
In-Reply-To: <20210920072726.1159572-3-hch@lst.de>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 20 Sep 2021 16:37:22 -0700
Message-ID: <CAPcyv4g+KdhFpr8Prn9Wg2E7k0OeRSbs2siNDgJBH9h0RSVN2Q@mail.gmail.com>
Subject: Re: [PATCH 2/3] nvdimm/pmem: move dax_attribute_group from dax to pmem
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, linux-block@vger.kernel.org,
        Linux NVDIMM <nvdimm@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Mon, Sep 20, 2021 at 12:29 AM Christoph Hellwig <hch@lst.de> wrote:
>
> dax_attribute_group is only used by the pmem driver, and can avoid the
> completely pointless lookup by the disk name if moved there.

After the additional fixups that 0day-robot found, you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
