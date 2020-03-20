Return-Path: <SRS0=+z0d=5F=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAD5C4332D
	for <linux-block@archiver.kernel.org>; Fri, 20 Mar 2020 21:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9A512072C
	for <linux-block@archiver.kernel.org>; Fri, 20 Mar 2020 21:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="gfyVvPPe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgCTVmK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Mar 2020 17:42:10 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:37699 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726666AbgCTVmK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Mar 2020 17:42:10 -0400
Received: by mail-pj1-f68.google.com with SMTP id ca13so3056538pjb.2
        for <linux-block@vger.kernel.org>; Fri, 20 Mar 2020 14:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NLfe7JwHgxsGW+To/CqwHJiDOPtxL2xkgiuRoT3yWsQ=;
        b=gfyVvPPexCB7XtGlu3AtxfLNjO9o47pOvl1qW8eIcMSKTpqGdzUSO4+Irk+/jSRMOD
         0jm3VYkhVa22U5NUFBl+SSJs6NIn05CByWacjmpokJuwGwj+w+o3wA5Ra4U6n7exs/pm
         oGLpAL5YfvBxIyzy0xADT0sDdrpakrJIjPsVk6kkeiEowqpdiOZjyWPldIygWZk8giun
         PMd7rI3Wfz410WH2u9w1INgk5hTTebaFsqP8hoKntyEfykEzb1AWaKttDd7vOqZWYLwp
         gXUfAycXMen9oyGTo9cb1VXRizUSrapO+Upv0LCaJW+xckuljgp8UFsUNCQmtapf/3Wr
         0g0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NLfe7JwHgxsGW+To/CqwHJiDOPtxL2xkgiuRoT3yWsQ=;
        b=kmJIRi3nzBghiFN7Tl/eL67tmFGjeGR7zw8qrYJN4JAyQErFX1nkMGZuORa/oyY7c6
         V+Tr3tbzoswzHL/We+g8v8EJac+6PFAmY8M50on77HFDkK98eUO+CSpLE8F496EufW9w
         GBf029VIO96CY4pdSBjhGuOiLfOJ8yVOVRszHM/MsJpNn4LCxHmXChTxQq3Sx2HDZzLI
         G0FGHFJvgzJMaoG6DxYX3iIy0D3JuNIaHQ4caanOsKCSKJ4JXq1Km7pQsk88knYOtQu9
         1FlMrIN0J/2D6r71GU8Wf1QzjS31Jof7LAxV1e8xoJq0jZwnkMjiWMFGSBNzVFZswwcb
         Cfcg==
X-Gm-Message-State: ANhLgQ2IPsesE+quI7m9HjCHiEHbdSk95ESLelbgwuHnp3M9wJCJSSQ+
        K2K8CkA0ctDQWlDqDmWYTcJsiQ==
X-Google-Smtp-Source: ADFU+vuLg7o7FwtpqJCAX+FFZk7hKqqFoPAUpVT52QXPd4ap02WUfnBQ1OP61Leuq6l10o8fdNuN9w==
X-Received: by 2002:a17:902:6b49:: with SMTP id g9mr6912016plt.305.1584740527211;
        Fri, 20 Mar 2020 14:42:07 -0700 (PDT)
Received: from vader ([2620:10d:c090:400::5:c783])
        by smtp.gmail.com with ESMTPSA id f69sm6462800pfa.124.2020.03.20.14.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2020 14:42:06 -0700 (PDT)
Date:   Fri, 20 Mar 2020 14:42:05 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Omar Sandoval <osandov@fb.com>, linux-block@vger.kernel.org,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [PATCH blktests v2 4/4] Add a test that triggers the
 blk_mq_realloc_hw_ctxs() error path
Message-ID: <20200320214205.GF32817@vader>
References: <20200315221320.613-1-bvanassche@acm.org>
 <20200315221320.613-5-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200315221320.613-5-bvanassche@acm.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Mar 15, 2020 at 03:13:20PM -0700, Bart Van Assche wrote:
> Add a test that triggers the code touched by commit d0930bb8f46b ("blk-mq:
> Fix a recently introduced regression in blk_mq_realloc_hw_ctxs()"). This
> test only runs if a recently added fault injection feature is available,
> namely commit 596444e75705 ("null_blk: Add support for init_hctx() fault
> injection").
> 
> Cc: Ming Lei <ming.lei@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> ---
>  tests/block/030     | 42 ++++++++++++++++++++++++++++++++++++++++++
>  tests/block/030.out |  1 +
>  2 files changed, 43 insertions(+)
>  create mode 100755 tests/block/030
>  create mode 100644 tests/block/030.out
> 
> diff --git a/tests/block/030 b/tests/block/030
> new file mode 100755
> index 000000000000..861c85c27f09
> --- /dev/null
> +++ b/tests/block/030
> @@ -0,0 +1,42 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright 2020 Google LLC
> +#
> +# Trigger the blk_mq_realloc_hw_ctxs() error path.
> +
> +. tests/block/rc
> +. common/null_blk
> +
> +DESCRIPTION="trigger the blk_mq_realloc_hw_ctxs() error path"
> +QUICK=1
> +
> +requires() {
> +	_have_null_blk || return $?
> +	_have_module_param null_blk init_hctx || return $?
> +}
> +
> +test() {
> +	local i sq=/sys/kernel/config/nullb/nullb0/submit_queues
> +
> +	: "${TIMEOUT:=30}"
> +	if ! _init_null_blk nr_devices=0 queue_mode=2 "init_hctx=$(nproc),100,0,0"; then
> +		echo "Loading null_blk failed"
> +		return 1
> +	fi
> +	if ! _configure_null_blk nullb0 completion_nsec=0 blocksize=512 size=16\
> +	     submit_queues="$(nproc)" memory_backed=1 power=1; then
> +		echo "Configuring null_blk failed"
> +		return 1
> +	fi
> +	if { echo "$(<"$sq")" >$sq; } 2>/dev/null; then
> +		for ((i=0;i<100;i++)); do
> +			echo 1 >$sq
> +			nproc >$sq
> +		done
> +	else
> +		echo "Skipping test because $sq cannot be modified" >>"$FULL"

I just pushed the support for allowing skipping from the middle of a
test, so now you could make this

	SKIP_REASON="Skipping test because $sq cannot be modified"

> +	fi
> +	rmdir /sys/kernel/config/nullb/nullb0
> +	_exit_null_blk
> +	echo Passed
> +}
> diff --git a/tests/block/030.out b/tests/block/030.out
> new file mode 100644
> index 000000000000..863339fb8ced
> --- /dev/null
> +++ b/tests/block/030.out
> @@ -0,0 +1 @@
> +Passed
