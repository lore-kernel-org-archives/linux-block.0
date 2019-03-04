Return-Path: <SRS0=5cmc=RH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17AEC43381
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 22:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EB2420823
	for <linux-block@archiver.kernel.org>; Mon,  4 Mar 2019 22:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="f+lrq+we"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726088AbfCDWgO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 4 Mar 2019 17:36:14 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46923 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbfCDWgN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 4 Mar 2019 17:36:13 -0500
Received: by mail-pg1-f195.google.com with SMTP id 196so4079649pgf.13
        for <linux-block@vger.kernel.org>; Mon, 04 Mar 2019 14:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IkcCgT2zzHdxQ83cZmajr62PlwWbl7UeMSkETvCDpNA=;
        b=f+lrq+we1vCCwzuBJ4zskttynWuTEpn5M/b/riZLvPvdfsc4G1iDb4tlC69KK/MdLm
         YrC1YYICACLak4VUdyeKn1igB//xlEBpzIwZpYWjpmfYgLcyqhEvocnQJUuhizun9fBY
         q1azRJDSbLFpm4iQUuLWUJoY+Y5SvIPU06T850nOoGd/GgBqTjf8A/P8YV07u4Ar+gMc
         qxyWgzZTLn7hsuf084UOvc8IqZwdK3jbzlwDQ8XkGMKvNOXKe6YdbxmHb6lz16H9udDH
         iAZ6R0r1SSMwqksKcd2XA93d3Z9vKQ1q5mkzJCQr7GDk5IEelHdy7TF5rmal8yL9M8Vl
         Wfhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IkcCgT2zzHdxQ83cZmajr62PlwWbl7UeMSkETvCDpNA=;
        b=WIpPy0srcciFBMMXvrPopy3tGN8QL3YemqkXuE1E1KBg/lCGK1LTpXsnsTjTY2Bh7Q
         dbcyccUBav3baWLEMeGdfKeHTUyM975NdyRqG/YoiqzxUz+JiPd1V7Cd9ez+wgAPf8pW
         dEtbQ10Mry+CQFerNRwUTUL13/NS7WZgVPoFi2oK8illqPRG7wprwUq5G+EWr+c6kDeQ
         Q+SdTNdQ6nGEewffHb65CuSM8DeDCv/WDD2KrsZd10NKzZnonJTtiSvgzHQFCICZ7ihv
         6rK6hyb64BsSdA/O5fA/JHHUAvUPABeERXhOmIeMUEXU7BXApFO1Nkg2qBB+tjtLiVpt
         e0oQ==
X-Gm-Message-State: APjAAAVuFi709c0mm5Jfkfq6VNa5udS4gqsjdKnj6sk56QB0xGajFiV6
        Yh0WkzTgX1kn57MjnBrc4upiGliciEU=
X-Google-Smtp-Source: APXvYqwm1tatrjlO41dVVVjYHWwBMy3xU1ZsIdRI/N533tXLMaqd+wrJenzje5bEjYEScisOFrAmXA==
X-Received: by 2002:a63:c34a:: with SMTP id e10mr20449382pgd.194.1551738972931;
        Mon, 04 Mar 2019 14:36:12 -0800 (PST)
Received: from vader ([2620:10d:c090:200::3:9d2c])
        by smtp.gmail.com with ESMTPSA id k8sm9285747pgg.75.2019.03.04.14.36.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Mar 2019 14:36:12 -0800 (PST)
Date:   Mon, 4 Mar 2019 14:36:10 -0800
From:   Omar Sandoval <osandov@osandov.com>
To:     Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     linux-block@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Masato Suzuki <masato.suzuki@wdc.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: Re: [PATCH blktests 4/5] common: Add _test_dev_is_partition() helper
 function
Message-ID: <20190304223610.GD5450@vader>
References: <20190220081231.15366-1-shinichiro.kawasaki@wdc.com>
 <20190220081231.15366-5-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220081231.15366-5-shinichiro.kawasaki@wdc.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Feb 20, 2019 at 05:12:30PM +0900, Shin'ichiro Kawasaki wrote:
> To control test conditions unique for partition devices, introduce the
> _test_dev_is_partition() helper function. Refer TEST_DEV_PART_SYSFS
> variable to tell if the TEST_DEV is a partition device or not.

Reviewed-by: Omar Sandoval <osandov@fb.com>

> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> ---
>  common/rc | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 153a323..0c354a2 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -208,6 +208,14 @@ _test_dev_in_hotplug_slot() {
>  	return 0
>  }
>  
> +_test_dev_is_partition() {
> +	if [[ -z ${TEST_DEV_PART_SYSFS} ]]; then
> +		SKIP_REASON="${TEST_DEV} is not a partition device"
> +		return 1
> +	fi
> +	return 0
> +}
> +
>  # Older versions of xfs_io use pwrite64 and such, so the error messages won't
>  # match current versions of xfs_io. See c52086226bc6 ("filter: xfs_io output
>  # has dropped "64" from error messages") in xfstests.
> -- 
> 2.20.1
> 
