Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE44C433F5
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 18:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CE2C60FBF
	for <linux-block@archiver.kernel.org>; Wed, 15 Sep 2021 18:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhIOSsa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 15 Sep 2021 14:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbhIOSs2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 15 Sep 2021 14:48:28 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54DF9C061574
        for <linux-block@vger.kernel.org>; Wed, 15 Sep 2021 11:47:09 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so5624099pjc.3
        for <linux-block@vger.kernel.org>; Wed, 15 Sep 2021 11:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SIWKZlon0kVVHDjSqUrAEDCIPd5swua31Z2cKyzZPb8=;
        b=iZtw+V2XmE2Jqg+Iq02Slnjco0vhgXwhxauMxKgS6sf41tYdogk6ms5rHdgvqHqF47
         ECXBtTCBXqsP43qBIEbYen4SuCQWjdeEIqllNmXvNK4R87X5VSUx6qfekBPMb/wBL89e
         GqiZWwQs2lw8Kquxzvk7xrVGBgjaKYuYFl8rEoEUxFYWU6U8grwYhw4TJwBHKC3w/V7K
         Y+TlPP6KsjQb4buy/L44LS31CfCsRjjvuFGnzknkLjK4kKPRv4fbi7esuQDFK8mKLr2G
         rhs3kYV2NCwJ3WK0Yf8IG7cSTs3G/M/9v85KHMXPtMuH0I9vvU985gpxAr6dn4pV2qfq
         gWGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SIWKZlon0kVVHDjSqUrAEDCIPd5swua31Z2cKyzZPb8=;
        b=6anuhb8t2rOC8T8e22N/0Zqk38El0w/PqX4uH8JB0YjPISgAaoJ7010jWb8m5MOtJ8
         cLp6y4ZkpMWVRo+1FQDW9OjUnVlTmvjFHpXjGHt3fu80pQqQQ+D55GlfRu8tTGOWBwK9
         Wk5qots8H2fekMwIlhyLPd+gXeyA4V43Nz/rSCEyTtLcqCfqh+GykWaAyNvUNnw4tiJ9
         Ru/LZSYiDFMjCvXn9q27dtY/9TEsa0HqxFG6ogM1eHWt9rH4xOBFcqieSbpJ4ujXu3fQ
         y5S+PA1zWENs4DygT58ascccrHp2CBnOW2Xxhdi4yHGVPH2SoT1k6VmDLfLJvekiMmef
         OxaQ==
X-Gm-Message-State: AOAM530l9/nEc2PRwET/0pfS/1Mp9NJWXCRSy0aoIJDvepsfmnYJUiYW
        XXtuuhSIiphdlKnicuSo0krMQA==
X-Google-Smtp-Source: ABdhPJz+H94oA3slDbuEtmrnuHQD9IxxbVVSy9ZTjnsc85lJzqK0BjRvFA6TfA92/3cDjHMxzafoZQ==
X-Received: by 2002:a17:90a:198b:: with SMTP id 11mr1281906pji.209.1631731628724;
        Wed, 15 Sep 2021 11:47:08 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:1a3d])
        by smtp.gmail.com with ESMTPSA id r5sm379201pjd.13.2021.09.15.11.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 11:47:08 -0700 (PDT)
Date:   Wed, 15 Sep 2021 11:47:06 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     bvanassche@acm.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: [PATCH blktests] nvmeof-mp/001: fix failure when
 CONFIG_NVME_HWMON enabled
Message-ID: <YUI/qlrbFw6Q89BD@relinquished.localdomain>
References: <20210912120336.6035-1-yi.zhang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210912120336.6035-1-yi.zhang@redhat.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sun, Sep 12, 2021 at 08:03:36PM +0800, Yi Zhang wrote:
> Skip checking ng0n1/hwmon5 in count_devices
> 
> $ use_siw=1  ./check nvmeof-mp/001
> nvmeof-mp/001 (Log in and log out)                           [failed]
>     runtime  3.695s  ...  4.002s
>     --- tests/nvmeof-mp/001.out	2021-09-12 05:35:17.866892187 -0400
>     +++ /root/blktests/results/nodev/nvmeof-mp/001.out.bad	2021-09-12 06:49:25.621880616 -0400
>     @@ -1,3 +1,3 @@
>      Configured NVMe target driver
>     -count_devices(): 1 <> 1
>     +count_devices(): 3 <> 1
>      Passed
> $ ls -l /sys/class/nvme-fabrics/ctl/*/*/device
> lrwxrwxrwx. 1 root root 0 Sep 12 06:49 /sys/class/nvme-fabrics/ctl/nvme0/hwmon5/device -> ../../nvme0
> lrwxrwxrwx. 1 root root 0 Sep 12 06:49 /sys/class/nvme-fabrics/ctl/nvme0/ng0n1/device -> ../../nvme0
> lrwxrwxrwx. 1 root root 0 Sep 12 06:49 /sys/class/nvme-fabrics/ctl/nvme0/nvme0n1/device -> ../../nvme0
> 
> Signed-off-by: Yi Zhang <yi.zhang@redhat.com>
> ---
>  tests/nvmeof-mp/001 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/nvmeof-mp/001 b/tests/nvmeof-mp/001
> index 69f1e24..3c3e8d5 100755
> --- a/tests/nvmeof-mp/001
> +++ b/tests/nvmeof-mp/001
> @@ -11,6 +11,7 @@ count_devices() {
>  	local d devs=0
>  
>  	for d in /sys/class/nvme-fabrics/ctl/*/*/device; do
> +		[[ "$d" =~ hwmon[0-9]|ng[0-9]n[0-9] ]] && continue

I'm not too familiar with NVME_HWMON, but presumably it's possible to
have more than 10 of these "ng" devices. Should this be ng[0-9]+n[0-9]?

>  		[ -d "$d" ] && ((devs++))
>  	done
>  	echo "$devs"
> -- 
> 2.21.3
> 
