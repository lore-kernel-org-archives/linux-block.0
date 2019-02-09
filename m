Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D53C282C4
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 13:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C05921919
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 13:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ho854t0V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbfBINwf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Feb 2019 08:52:35 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54628 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfBINwf (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Feb 2019 08:52:35 -0500
Received: by mail-wm1-f66.google.com with SMTP id a62so8493432wmh.4;
        Sat, 09 Feb 2019 05:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a1FxRbJ08wKgp4Co0znQWeKyAEWRpt3r5CDQgl/lzA4=;
        b=ho854t0VeE6vkAj0xsMCBVg+GmgJHVfw5OjfuHOJNNggl2sV7EERA8YSfPVlbMvOI/
         8VfPfvbCOdKdg1UTWHM/i0jDat3tgSYv0ewqUWVbUABw4sOc26cXz78V1kDZdl0FeXcU
         fUUbDB73SdMwb9ZQit//tkf/yJmMy+BsmPYc5egWKEuM9+cJW5rYCz/vmSeWAyyx8Fsk
         hc27LyFIpXFFNT7f/0lYIbAdpujM488pot5HUf31+3kyX5gkm3JvloV91OtiSEWmXl4a
         S+ls75NLMEcJxwYPKh92JNiCRLHdMp4QjFpU7eGPGle1WxcJM7BvMOUeEOWjSkya9ZGO
         1TGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a1FxRbJ08wKgp4Co0znQWeKyAEWRpt3r5CDQgl/lzA4=;
        b=t6BRZl1Q/YW3JS1badTRVLnueZPBU0w8U/1r7k/QExXkPggRGaler3vw/OcxU02XuK
         /eXpT3dq050t1wKPtUrSDDk1NUMtZ80dK+S4lBgkEuCX6/cc3eAP6wr6quD8BpOHISBU
         hvPo1l4l7uI27O6pUUmJqG+pM47nad8eUAi5o4h+kxATnXtJ2b8ytuC4U1m/b4w9zV2l
         w470QHq/hI2kk3OqQQ+K8yEBIXWTpiXoxk9EhNU3CFJ8TK/vAkxnt7SQVsTSbC9hjeiE
         fuiM8aR4eU8vcvSOUV8kuki3bPxrdz3GKY4SfKGgnLtXJpYcd+2xhKFqDRf+zaWcXmJ4
         1fvA==
X-Gm-Message-State: AHQUAua/5MdPPT2hLzzGPh/K+clJMOHdXIUFKbz+aAnhDhbZm5JO410w
        UiwTEjiSrZOynkGp6SNe5A==
X-Google-Smtp-Source: AHgI3IYCGgyeMoumNCNf/hlgXlYmgnGoCIA2EAC1vCyg+s6hZ7Scw34UnmRgzD6RTx7omoGjVtJXAw==
X-Received: by 2002:adf:9004:: with SMTP id h4mr13476386wrh.121.1549720353621;
        Sat, 09 Feb 2019 05:52:33 -0800 (PST)
Received: from localhost ([95.238.120.247])
        by smtp.gmail.com with ESMTPSA id r12sm6648362wrt.76.2019.02.09.05.52.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 Feb 2019 05:52:32 -0800 (PST)
Date:   Sat, 9 Feb 2019 14:52:31 +0100
From:   Andrea Righi <righi.andrea@gmail.com>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Paolo Valente <paolo.valente@linaro.org>,
        Tejun Heo <tj@kernel.org>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jens Axboe <axboe@kernel.dk>, Vivek Goyal <vgoyal@redhat.com>,
        Dennis Zhou <dennis@kernel.org>, cgroups@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] blkcg: prevent priority inversion problem during
 sync()
Message-ID: <20190209135231.GA1910@xps-13>
References: <20190209120633.GA2506@xps-13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190209120633.GA2506@xps-13>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Sat, Feb 09, 2019 at 01:06:33PM +0100, Andrea Righi wrote:
...
> +/**
> + * blkcg_wb_waiters_on_bdi - check for writeback waiters on a block device
> + * @bdi: block device to check
> + *
> + * Return true if any other blkcg is waiting for writeback on the target block
> + * device, false otherwise.
> + */
> +bool blkcg_wb_waiters_on_bdi(struct backing_dev_info *bdi)
> +{
> +	struct blkcg *blkcg, *curr_blkcg;
> +	bool ret = false;
> +
> +	if (unlikely(!bdi))
> +		return false;
> +
> +	rcu_read_lock();
> +	curr_blkcg = css_to_blkcg(task_css(current, io_cgrp_id));

Sorry, the logic is messed up here. We shouldn't get curr_blkcg from the
current task, because during writeback throttling the context is
obviously not the current task.

I'll post a new patch soon.

> +	list_for_each_entry_rcu(blkcg, &bdi->cgwb_waiters, cgwb_wait_node)
> +		if (blkcg != curr_blkcg) {
> +			ret = true;
> +			break;
> +		}
> +	rcu_read_unlock();
> +
> +	return ret;
> +}

-Andrea
