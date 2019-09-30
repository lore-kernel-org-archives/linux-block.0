Return-Path: <SRS0=9W5b=XZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9952BC388F3
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 21:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DFA8207FA
	for <linux-block@archiver.kernel.org>; Mon, 30 Sep 2019 21:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sDrqqtHC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732118AbfI3VVz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Sep 2019 17:21:55 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:36278 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbfI3VVy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Sep 2019 17:21:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id y22so6319058pfr.3;
        Mon, 30 Sep 2019 14:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H97JuRzTawzjptZSMNylKho6vMxm73iMh4ASCWPnXgg=;
        b=sDrqqtHCvLRw5rjgT4ECfrcTAIgkWkGA8e5ODBlso7j+D4qSIlUyYRBoH5wRYQ/REp
         fnHFK+nemA9Rir50ieKU0/40UcLC25oakL093aGMC4EkUUCunodt/zHU34AXEB+BTTW/
         +CMRiI/38rw4rxxzAqumdjee2h90Gw0bvkpCte451dK+lGdB9c9mGk8O7Th8dPSf0miH
         r/ORozUT+agvVozZXjVfocor49ZLd2TapfSjbWT3hMRPi34NmVbxVp1vECMVcf2uO8xA
         qgn0jOxtqF+bPQmzBggpTfK+cChuqjCL+5yEFz2yLVltWTsIlftnd62zrcbjbHfpTD/S
         vVIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H97JuRzTawzjptZSMNylKho6vMxm73iMh4ASCWPnXgg=;
        b=Yu1EcL3PbOnMhRYzkL9p86UvENV29Tv0SyhZ+nCVSVENykb97OUXN8dtn4p8i/rH8J
         fY3hrW8iLbcrq53UCNSV3rzlKS+XElCs3HEFlS9GxCgnly3p9rV/A65KrFGqoGeyNkl2
         j1SK3QvD0pHPQNDBhLOL74tT/Xqw8pmgyLyCM+ATwRnKFuOANl5zilcVcw0s8WPltqjv
         H+0do//aiRzrak3F74MuSxxHQ6tIUsYMTNwufCDKWGlJPQNnRKxPvGwA2LKCY52UA6G0
         NYCbn4BNRqSOCo0NFvqA1+UaHOmpZ5CVRKRjyfQANLQoO+16SfMlK8spowPd3hGuMgZX
         Mvvw==
X-Gm-Message-State: APjAAAUKnvryAJ9j6bIDEW2nrNwXo2XF0nD+QWXfLGqFBMBxfIh7cm9q
        8F94V/wDFQQd+yWjR3I8LPQ++Ci9Z8jU3A==
X-Google-Smtp-Source: APXvYqy7/nPFlApe6mStEXZgM/YAlHqZ4LO8JdkvjapX1nhFQGFEmthsSKSz8H1Hx4JytcVHlRi0Rg==
X-Received: by 2002:a17:90a:360b:: with SMTP id s11mr1038166pjb.30.1569872192133;
        Mon, 30 Sep 2019 12:36:32 -0700 (PDT)
Received: from [172.19.249.239] ([38.98.37.138])
        by smtp.gmail.com with ESMTPSA id m12sm341402pjl.22.2019.09.30.12.36.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Sep 2019 12:36:31 -0700 (PDT)
From:   Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH v4 2/2] mdadm: Introduce new array state 'broken' for
 raid0/linear
To:     "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        linux-raid@vger.kernel.org
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        jay.vosburgh@canonical.com, liu.song.a23@gmail.com,
        nfbrown@suse.com, NeilBrown <neilb@suse.de>,
        Song Liu <songliubraving@fb.com>
References: <20190903194901.13524-1-gpiccoli@canonical.com>
 <20190903194901.13524-2-gpiccoli@canonical.com>
Message-ID: <608284db-7b82-6545-74bf-7a9f1d578c2f@gmail.com>
Date:   Mon, 30 Sep 2019 15:36:15 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190903194901.13524-2-gpiccoli@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/3/19 3:49 PM, Guilherme G. Piccoli wrote:
> Currently if a md raid0/linear array gets one or more members removed while
> being mounted, kernel keeps showing state 'clean' in the 'array_state'
> sysfs attribute. Despite udev signaling the member device is gone, 'mdadm'
> cannot issue the STOP_ARRAY ioctl successfully, given the array is mounted.
> 
> Nothing else hints that something is wrong (except that the removed devices
> don't show properly in the output of mdadm 'detail' command). There is no
> other property to be checked, and if user is not performing reads/writes
> to the array, even kernel log is quiet and doesn't give a clue about the
> missing member.
> 
> This patch is the mdadm counterpart of kernel new array state 'broken'.
> The 'broken' state mimics the state 'clean' in every aspect, being useful
> only to distinguish if an array has some member missing. All necessary
> paths in mdadm were changed to deal with 'broken' state, and in case the
> tool runs in a kernel that is not updated, it'll work normally, i.e., it
> doesn't require the 'broken' state in order to work.
> Also, this patch changes the way the array state is showed in the 'detail'
> command (for raid0/linear only) - now it takes the 'array_state' sysfs
> attribute into account instead of only rely in the MD_SB_CLEAN flag.
> 
> Cc: Jes Sorensen <jes.sorensen@gmail.com>
> Cc: NeilBrown <neilb@suse.de>
> Cc: Song Liu <songliubraving@fb.com>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@canonical.com>
> ---

Applied thanks!

I fixed up one minor nit rather than having to do the merry-go-round by 
email one more time:

> diff --git a/Monitor.c b/Monitor.c
> index 036103f..cf0610b 100644
> --- a/Monitor.c
> +++ b/Monitor.c
[snip]

> @@ -1116,7 +1119,8 @@ int WaitClean(char *dev, int verbose)
>   			rv = read(state_fd, buf, sizeof(buf));
>   			if (rv < 0)
>   				break;
> -			if (sysfs_match_word(buf, clean_states) <= 4)
> +			if (sysfs_match_word(buf, clean_states)
> +			    < (int)ARRAY_SIZE(clean_states)-1)

I moved the < up to the correct line where it belongs, and added spaces 
") - 1)"

Cheers,
Jes
