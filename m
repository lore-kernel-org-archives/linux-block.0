Return-Path: <SRS0=I4RS=DX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92E1C433DF
	for <linux-block@archiver.kernel.org>; Fri, 16 Oct 2020 08:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4370A20878
	for <linux-block@archiver.kernel.org>; Fri, 16 Oct 2020 08:39:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AfeeXMXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394665AbgJPIj3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 16 Oct 2020 04:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394641AbgJPIj3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 16 Oct 2020 04:39:29 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16FDEC0613D2
        for <linux-block@vger.kernel.org>; Fri, 16 Oct 2020 01:39:29 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id az3so988439pjb.4
        for <linux-block@vger.kernel.org>; Fri, 16 Oct 2020 01:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oOQoOAZUDHpcUncJgxnxM2Jw3xEiUcKHa7EZVIA2/KY=;
        b=AfeeXMXyOFoWs5rfmfRajUGzRsAFGVsAA/Gm++BDufUn+gVueuzC9L69OGUVMZsDHA
         hef9tacKJTPQYY1PNrpSG3g2TrG0Lhipn7hh69qT8FpHcp41Pkf5OWQt2t6D7QQbXakQ
         /7qZeMGngPhg/y26dwUhhOWUfSPEleGFL2O5cSwGergDj3JInvTJtraVAvQ+3p/STt9Z
         8g3rTVCUGpa0iV7AJAdiTIbfDYZlBAvsPlA0/Y9atJ7okw5NG3AmaA3TT8Oso1wvNt5a
         fxpdtdi3od/KfPajvP00zYspH+82jDgw3eM/2zwfDsXST1iWMOWf1NFfj2JCh4J+92kl
         /JBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oOQoOAZUDHpcUncJgxnxM2Jw3xEiUcKHa7EZVIA2/KY=;
        b=JB9hFX+Zh3ymwa+M40rxJ60Mdz/8T1ot6pi4tvbuAS2h2egHF8sTz6oZrJXnwhU1th
         wF9rS5AClgVsYg3lpr5Ni1GKKErzKhL1VR60Hjx/hnJRE7uUeIWubDc5mAUlf400I27w
         /Pcz1Lp0+eBW55SfVaHzBVMj7SD5zFvQ5JvoSKqVC9vCO8+RSlCCMrvdxOSrQVbjp0pF
         XnRa8OzZ86LFbjEi0UqpYZgbWoeE1FZjNQKYCc3lr/e9vBcI10WQmdjPVitaDRRCLvKN
         YV9oU6+oIihFl7HMkECbwlD+IgwynBGlx14haJqXdLGG5PkTNITfa0i/dNcgAusG3Y+o
         1e1A==
X-Gm-Message-State: AOAM530Qv4RdbQBqgiQRaXFLkkjihiOl65ptcR3+FwevKcXz3XvWp/FI
        TWda3mvkle0pYamZLJs06rmSMg==
X-Google-Smtp-Source: ABdhPJzCXwVXYAwp16Dlkk8/x6p+3Cy3jEcFR6m+PNEsA7BzP+RsUV77M3ev3md1fXDOhCjEfftfrA==
X-Received: by 2002:a17:902:684b:b029:d5:a3a0:3b47 with SMTP id f11-20020a170902684bb02900d5a3a03b47mr2976376pln.76.1602837568269;
        Fri, 16 Oct 2020 01:39:28 -0700 (PDT)
Received: from google.com (154.137.233.35.bc.googleusercontent.com. [35.233.137.154])
        by smtp.gmail.com with ESMTPSA id js21sm2038954pjb.14.2020.10.16.01.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 01:39:27 -0700 (PDT)
Date:   Fri, 16 Oct 2020 08:39:23 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Jens Axboe <axboe@kernel.dk>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v2 2/4] block: add private field to struct keyslot_manager
Message-ID: <20201016083923.GA134672@google.com>
References: <20201015214632.41951-1-satyat@google.com>
 <20201015214632.41951-3-satyat@google.com>
 <20201016071941.GA14885@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016071941.GA14885@infradead.org>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Oct 16, 2020 at 08:19:41AM +0100, Christoph Hellwig wrote:
> On Thu, Oct 15, 2020 at 09:46:30PM +0000, Satya Tangirala wrote:
> > Add a (void *) pointer to struct keyslot_manager that the owner of the
> > struct can use for any purpose it wants.
> > 
> > Right now, the struct keyslot_manager is expected to be embedded directly
> > into other structs (and the owner of the keyslot_manager would use
> > container_of() to access any other data the owner needs). However, this
> > might take up more space than is acceptable, and it would be better to be
> > able to add only a pointer to a struct keyslot_manager into other structs
> > rather than embed the entire struct directly. But container_of() can't be
> > used when only the pointer to the keyslot_manager is embded. The primary
> > motivation of this patch is to get around that issue.
> 
> No, please don't bloat the structure.  If some weird caller doesn't
> like the embedding it can create a container structure with the
> blk_keyslot_manager structure and a backpointer.
Ah, ok. Thanks!
