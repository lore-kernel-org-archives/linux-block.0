Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76ABCC433B4
	for <linux-block@archiver.kernel.org>; Sun,  2 May 2021 09:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46D71613AC
	for <linux-block@archiver.kernel.org>; Sun,  2 May 2021 09:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbhEBJNL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 2 May 2021 05:13:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26177 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229754AbhEBJNK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 2 May 2021 05:13:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619946739;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hWwZGLdaGBnu7du6ieoJeVqv8Y1BBlHwek4tKB9bhs8=;
        b=BTwAlQG19342wNMTMtx+8xoXmXg0aQpx1ea7Ehe7w3bsAdlP1cEgUPBB3sY/ILO8ijQZIJ
        VPExpaGllr5ByUzsTOJDlIH/8P1UlBvCG9E6VGAr0Crjn0y2Bh/ULDfMNmztw8obXP4mwJ
        3KBf3+6WWJ2gaDGhheaOn4AoxG8OkpY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-nNmzVn6JOu-nP6F0FQ4UFA-1; Sun, 02 May 2021 05:12:16 -0400
X-MC-Unique: nNmzVn6JOu-nP6F0FQ4UFA-1
Received: by mail-wr1-f71.google.com with SMTP id 88-20020adf95610000b029010758d8d7e2so1996400wrs.19
        for <linux-block@vger.kernel.org>; Sun, 02 May 2021 02:12:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hWwZGLdaGBnu7du6ieoJeVqv8Y1BBlHwek4tKB9bhs8=;
        b=rcZ+QllRXVky0R1KipQHr4YWbh16577NuzqzcZ6IsTtgKEzjFPTlHT3QWTDb0QGOR0
         pFalIcexOqzE0XCQPyRhbQ77zDGKfSEJ+Ju60y9rdtzZsn/0rpmCJ8VhM8CZL4kqZDbY
         pszs5OxBPi0QuRpVSjWBIQNgBlayMCsBbZL4IogvoAFvvMMjjLd82bKF5TYttdQ0okLF
         uUiDWV50zh9u+Yw08Zc8AnAyCxWgr0NbmlRLh96DS1HbDxus5stQz8WzHWmZk8U9Gxrm
         c4f5PGLNSQb+ijTKP/0vTcCOMupL9FkytofvSkkZhRBe++t/4TPZGf4XI6m1Eq7GoeMA
         56Wg==
X-Gm-Message-State: AOAM531UFaoqlH36HYxTxnIh8zW5eSaGFWI0xxGFb20ARXBtK5EoyDga
        Ihn+fXi5CD30bSym87sxzvsCDgE9fal2W6mH8ONG6qPxtQRiqOEzRdoBICRupLXYy27Uifgz9CS
        9jC82olF2keatrYgISVVcVu0=
X-Received: by 2002:adf:f74a:: with SMTP id z10mr18563141wrp.406.1619946734932;
        Sun, 02 May 2021 02:12:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVkZyL+2vuum44t8EKk144CbaOWB5l4YsegxZG7LMzEdFXY0YjhqUpAVXGDPDXJvmcu0qF2g==
X-Received: by 2002:adf:f74a:: with SMTP id z10mr18563129wrp.406.1619946734759;
        Sun, 02 May 2021 02:12:14 -0700 (PDT)
Received: from redhat.com ([2a10:800a:cdef:0:114d:2085:61e4:7b41])
        by smtp.gmail.com with ESMTPSA id n10sm8324376wrw.37.2021.05.02.02.12.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 May 2021 02:12:14 -0700 (PDT)
Date:   Sun, 2 May 2021 05:12:11 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Enrico Granata <egranata@google.com>
Cc:     virtio-dev@lists.oasis-open.org, hch@infradead.org,
        linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] Provide detailed specification of virtio-blk lifetime
 metrics
Message-ID: <20210502045740-mutt-send-email-mst@kernel.org>
References: <20210420162556.217350-1-egranata@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420162556.217350-1-egranata@google.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, Apr 20, 2021 at 04:25:56PM +0000, Enrico Granata wrote:
> In the course of review, some concerns were surfaced about the
> original virtio-blk lifetime proposal, as it depends on the eMMC
> spec which is not open
> 
> Add a more detailed description of the meaning of the fields
> added by that proposal to the virtio-blk specification, as to
> make it feasible to understand and implement the new lifetime
> metrics feature without needing to refer to JEDEC's specification
> 
> This patch does not change the meaning of those fields nor add
> any new fields, but it is intended to provide an open and more
> clear description of the meaning associated with those fields.
> 
> Signed-off-by: Enrico Granata <egranata@google.com>

Enrico it's great that you are reaching out to the
wider storage community before making spec changes.

Christoph could you please comment on whether this addresses
your concerns with the lifetime feature.
You wrote "it really needs to stand a lone and be properly documented"
and this seems to be the direction this patch is going in.


> ---
>  content.tex | 34 +++++++++++++++++++++++++++-------
>  1 file changed, 27 insertions(+), 7 deletions(-)
> 
> diff --git a/content.tex b/content.tex
> index 9232d5c..7e14ccc 100644
> --- a/content.tex
> +++ b/content.tex
> @@ -4669,13 +4669,32 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>  \end{lstlisting}
>  
>  The device lifetime metrics \field{pre_eol_info}, \field{device_lifetime_est_a}
> -and \field{device_lifetime_est_b} have the semantics described by the JESD84-B50
> -specification for the extended CSD register fields \field{PRE_EOL_INFO}
> -\field{DEVICE_LIFETIME_EST_TYP_A} and \field{DEVICE_LIFETIME_EST_TYP_B}
> -respectively.
> +and \field{device_lifetime_est_b} are discussed in the JESD84-B50 specification.
>  
> -JESD84-B50 is available at the JEDEC website (https://www.jedec.org)
> -pursuant to JEDEC's licensing terms and conditions.
> +The complete JESD84-B50 is available at the JEDEC website (https://www.jedec.org)
> +pursuant to JEDEC's licensing terms and conditions.

These links really belong in either normative or non-normative
references section.

> For the purposes of this
> +specification, these fields are defined as follows.

All this seems kind of vague. What does one need that spec for?
Is it just a note for pass-through developers?

How about "to simplify pass-through
from eMMC devices the format of fields 
  pre_eol_info, device_lifetime_est_typ_a and device_lifetime_est_typ_b
matches PRE_EOL_INFO, DEVICE_LIFETIME_EST_TYP_A and DEVICE_LIFETIME_EST_TYP_B
in the 
\hyperref[intro:PCI]{[PCI]}.



Also, now that I mention it, what about NVMe pass-through? Arguably
nvme is getting more popular. Will we be able to support that use-case
as well? Or is more data needed? What is the plan there?

> +
> +The \field{pre_eol_info} will have one of these values:
> +
> +\begin{lstlisting}
> +// Value not available
> +#define PRE_EOL_INFO_UNDEFINED    0
> +// < 80% of blocks are consumed
> +#define PRE_EOL_INFO_NORMAL       1
> +// 80% of blocks are consumed
> +#define PRE_EOL_INFO_WARNING      2
> +// 90% of blocks are consumed
> +#define PRE_EOL_INFO_URGENT       3
> +// All others values are reserved


Block comments /* */ should be used as these are documented
in the introduction.

> +\end{lstlisting}
> +
> +The \field{device_lifetime_est_typ_a} refers to wear of SLC cells and is provided in
> +increments of 10%, with 0 meaning undefined, 1 meaning up-to 10% of lifetime used, and so on,
> +thru to 11 meaning estimated lifetime exceeded. All values above 11 are reserved.
> +
> +The \field{device_lifetime_est_typ_b} refers to wear of MLC cells and is provided with
> +the same semantics as \field{device_lifetime_est_typ_a}.
>  
>  The final \field{status} byte is written by the device: either
>  VIRTIO_BLK_S_OK for success, VIRTIO_BLK_S_IOERR for device or driver
> @@ -4812,7 +4831,8 @@ \subsection{Device Operation}\label{sec:Device Types / Block Device / Device Ope
>  or UFS persistent storage), the device SHOULD offer the VIRTIO_BLK_F_LIFETIME
>  flag. The flag MUST NOT be offered if the device is backed by storage for which
>  the lifetime metrics described in this document cannot be obtained or for which
> -such metrics have no useful meaning.
> +such metrics have no useful meaning. If the metrics are offered, the device MUST NOT
> +send any reserved values, as defined in this specification.
>  
>  \subsubsection{Legacy Interface: Device Operation}\label{sec:Device Types / Block Device / Device Operation / Legacy Interface: Device Operation}
>  When using the legacy interface, transitional devices and drivers
> -- 
> 2.31.1.368.gbe11c130af-goog
> 

