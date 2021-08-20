Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDC6C4338F
	for <linux-block@archiver.kernel.org>; Fri, 20 Aug 2021 20:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E083610FF
	for <linux-block@archiver.kernel.org>; Fri, 20 Aug 2021 20:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238656AbhHTUVl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Aug 2021 16:21:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57502 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238717AbhHTUVl (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Aug 2021 16:21:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629490862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=e0xk0PCgbvrI9oL4egy0zV/DTKLD6KkoLQ6vPavMKGE=;
        b=jCCL2WHwOt2USIMK9PuQ4i/CjYpB7oKqKJMUcsj768JoJ5kDC8s2m5QjNSCUUlKb0O7qwa
        LOsVtmKJcRiFWBN25Mjyf5ftmi3nV9BSpw1/SrqI6NuT/7tL9jjUBYlIW25xqe4tPaCaOd
        dq/OpVHv+wVrfhnk90sODGau0Ei3m4s=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-9-lk__hVGwNayuwSE3bw0Dtw-1; Fri, 20 Aug 2021 16:19:27 -0400
X-MC-Unique: lk__hVGwNayuwSE3bw0Dtw-1
Received: by mail-qk1-f200.google.com with SMTP id x19-20020a05620a099300b003f64d79cbbaso1548998qkx.7
        for <linux-block@vger.kernel.org>; Fri, 20 Aug 2021 13:19:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e0xk0PCgbvrI9oL4egy0zV/DTKLD6KkoLQ6vPavMKGE=;
        b=AaBxoLxnM8GySH3D/+GGiSPKX235YEJGB88ftZhRtwgVMIBHM+Etw963aBZcupxek8
         Yol3qB+zl6B5kxDIky3nFc5epdcWITf4DLECUSYIh/dLYFvAfxntcsVki7+7h4F3rAE+
         YRyWQiPiioENRVhzrY81cLO81qmLPmu4umnzIm4qm8UUqIKrZrpiKaP6i9cdC+22oY2c
         Ho6JCku3R3LkRrqZrSEhAFmBX6ho3k3A2oSLNmh1K132xRlm7SiQcYhYRQW0+O//KDpn
         eobmncHjoPYsSbzUoLPrxZOEzLXG0f0QafICjuG+Ce3nlK6woVddsDaWHwJ5w1AspDZz
         03mQ==
X-Gm-Message-State: AOAM533SM/YvOuvo1QMBpg9uFeq12VRowqkfVImnSbS+tmLjMOjeOgT7
        HH4B1/jNii06qNkH7jWbkVGHLUROaPcqqiTx0OhPMh4OkxfchOo78v+S/PvZLBES+WqJOZpzONj
        tdGMcEDbxUk9xqN5la4DF+A==
X-Received: by 2002:ae9:f701:: with SMTP id s1mr4317133qkg.223.1629490766944;
        Fri, 20 Aug 2021 13:19:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyb2iDL3pszKH41Z1jgPp9S39r1QoXK1jvTsWR2PAHnl9VBPP2M+hZZXFZGgTA1ObYjix4Usw==
X-Received: by 2002:ae9:f701:: with SMTP id s1mr4317111qkg.223.1629490766730;
        Fri, 20 Aug 2021 13:19:26 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id a14sm2768090qtb.57.2021.08.20.13.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 13:19:26 -0700 (PDT)
Date:   Fri, 20 Aug 2021 16:19:25 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc:     dm-devel@redhat.com, agk@redhat.com, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org, sfr@canb.auug.org.au,
        public@thson.de, nramas@linux.microsoft.com,
        linux-block@vger.kernel.org
Subject: Re: [PATCH 0/6] updates to device mapper target measurement using ima
Message-ID: <YSAOTX+TQwaCUeCn@redhat.com>
References: <20210813213801.297051-1-tusharsu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813213801.297051-1-tusharsu@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Fri, Aug 13 2021 at  5:37P -0400,
Tushar Sugandhi <tusharsu@linux.microsoft.com> wrote:

> 
> There were several improvements suggested for the original device mapper
> target measurement patch series [1].
> 
> Those improvement suggestions include: 
>  - Prefixing hashes for the DM tables being measured in ima log with the
>    hash algorithm.
>  - Adding version information for DM related events being measured in the
>    ima log.
>  - Prefixing DM related event names with "dm_".
>  - Including the verity target attribute - "root_hash_sig_key_desc"
>    in the ima measurement log.
> 
> This series incorporates the above suggestions.
> 
> This series also has the following fixes:
>  - Adding a one-time warning to dmesg during dm_init if
>    CONFIG_IMA_DISABLE_HTABLE is set to 'n'.
>  - Updating 'integrity' target to remove the duplicate measurement of
>    the attribute "mode=%c".
>  - Indexing various attributes in 'multipath' target, and adding
>    "nr_priority_groups=%u" attribute to the measurements.
>  - Fixing 'make htmldocs' warnings in dm-ima.rst.
>  - Adding missing documentation for the targets - 'cache', 'integrity',
>    'multipath', and 'snapshot' in dm-ima.rst.
>  - Updating dm-ima.rst documentation with the grammar for various DM
>    events and targets in Backus Naur form.
>  - Updating dm-ima.rst documentation to be consistent with the code
>    changes described above.
> 
> This series is based on top of the following git repo/branch/commit:
>  Repo: https://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git
>  Branch: dm-5.15
>  Commit: commit 5a2a33884f0b ("dm crypt: Avoid percpu_counter spinlock contention in crypt_page_alloc()")
> 
> 
> [1] https://patchwork.kernel.org/project/dm-devel/cover/20210713004904.8808-1-tusharsu@linux.microsoft.com/
> 
> Tushar Sugandhi (6):
>   dm ima: prefix dm table hashes in ima log with hash algorithm
>   dm ima: add version info to dm related events in ima log
>   dm ima: prefix ima event name related to device mapper with dm_
>   dm ima: add a warning in dm_init if duplicate ima events are not
>     measured
>   dm ima: update dm target attributes for ima measurements
>   dm ima: update dm documentation for ima measurement support

Hi,

I reviewed and staged these changes in dm-5.15 (and for-next) with
minimal tweaks. Really just some whitespace and a simplification of
the conditional for the warning in dm_init().

Please make sure that you manually apply Christoph's fix for the issue
you reported earlier in the week, you were cc'd on the ultimate fix
which has a different patch header than this patch but on a code level
it is identical (and only patch that landed on a public mailing list
due to typo in linux-block email address when hch sent the final fix):
https://listman.redhat.com/archives/dm-devel/2021-August/msg00154.html

It is an issue that'll linger in the dm-5.15 because I cannot rebase
at this late hour even once Jens picks the fix up into the
linux-block tree.

Thanks,
Mike

