Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E94C761AF
	for <linux-block@archiver.kernel.org>; Tue, 28 Mar 2023 16:37:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjC1QhD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Mar 2023 12:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjC1QhC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Mar 2023 12:37:02 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A585593
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 09:36:11 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id t19so12458523qta.12
        for <linux-block@vger.kernel.org>; Tue, 28 Mar 2023 09:36:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680021371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qZR6cbXQdwB5nUHvEEH2VeiB5R9CC8hRiYSzmgcjAyg=;
        b=eXL1N4GaGLaiuHCJ0ue5AkBSPTy6tAfuq3rAc9EmOzAVW8Rp4+BRtI0JgXcZmVJea0
         Z2nu+BgAlC0DzFDDJBJXUgkdJOF9M3HzkgoEgz8b2OqH6lKso2eNspiQfyfwWsPZv86m
         4OzYQYYHQZygDVpNX+tnvsiVxFt00h+mggggC+5Y4IOLcTz/b9eNvN9sbccl+4KXH8wP
         0+EM/ElCCGBCa4Ls6ufwktYYcYPzo48b2KT2j/hT9+XjiOKStzw2pmmVo9Em5VcMTSI2
         DgMulLgCLaB3t1UBuxlIWLn8IsL05+czSpBMsHaUwqN02Sg64mK1b2EYcJJVD0Vl4SUt
         tThg==
X-Gm-Message-State: AO0yUKXziqUIB3shMiPMq7MBS1GNqU+OMuo4LdWbQ5THk5z4W0XEAtlS
        nbv9UhRgJ1TP2oBM8/cL98TF
X-Google-Smtp-Source: AK7set8/4ablYvt1w3rWWxBu5RP3Per1gtZi0bV85eHN9m6lD3okcPGkDhxHJ2UAhi56YjYdObx6pQ==
X-Received: by 2002:ac8:7d46:0:b0:3e3:95fb:8771 with SMTP id h6-20020ac87d46000000b003e395fb8771mr28046888qtb.31.1680021371021;
        Tue, 28 Mar 2023 09:36:11 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id t23-20020ac865d7000000b003b635a5d56csm15765739qto.30.2023.03.28.09.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 09:36:10 -0700 (PDT)
Date:   Tue, 28 Mar 2023 12:36:09 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Mike Christie <michael.christie@oracle.com>
Cc:     bvanassche@acm.org, hch@lst.de, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com,
        linux-block@vger.kernel.org, dm-devel@redhat.com, axboe@kernel.dk,
        linux-nvme@lists.infradead.org, chaitanyak@nvidia.com,
        kbusch@kernel.org, target-devel@vger.kernel.org,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v5 01/18] block: Add PR callouts for read keys and
 reservation
Message-ID: <ZCMXecSrJ97oCD+s@redhat.com>
References: <20230324181741.13908-1-michael.christie@oracle.com>
 <20230324181741.13908-2-michael.christie@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324181741.13908-2-michael.christie@oracle.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Mar 24 2023 at  2:17P -0400,
Mike Christie <michael.christie@oracle.com> wrote:

> Add callouts for reading keys and reservations. This allows LIO to support
> the READ_KEYS and READ_RESERVATION commands and will allow dm-multipath
> to optimize it's error handling so it can check if it's getting an error
> because there's an existing reservation or if we need to retry different
> paths.

Not seeing anything in DM's path selectors that adds these
optimizations. Is there accompanying multipath-tools callouts to get
at this data to optimize path selection (via DM table reloads)?

Mike
