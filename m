Return-Path: <SRS0=s1xr=SI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B308EC10F06
	for <linux-block@archiver.kernel.org>; Sat,  6 Apr 2019 16:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B85920989
	for <linux-block@archiver.kernel.org>; Sat,  6 Apr 2019 16:50:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="g6p4fZ7N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbfDFQuH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 6 Apr 2019 12:50:07 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46428 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbfDFQuG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 6 Apr 2019 12:50:06 -0400
Received: by mail-pg1-f194.google.com with SMTP id q1so4745522pgv.13
        for <linux-block@vger.kernel.org>; Sat, 06 Apr 2019 09:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=fJqUVnMmmEGBR4w+RV9U88Z7XLYYwszXyiTahWLXm6o=;
        b=g6p4fZ7NRBKnNQp8GTKRTAdlPFY9JQuTk29Aq7vvUvmcVughgSXEb+XY0IA0SCRLaY
         6zseHCxmmHsFJs/HxRzhzQJ7qIK8Ju6rL+Y1za/Fc6MfUF6EiaY2zEJL3uLh59gp9Dhs
         cCAPt5w97cDeXKUizwkXjQPRG9tNx+kjbnh5CJr1xwAVSrMEh/waIChBIUCq4OYdiC5q
         w1e9do38qn+Nuva8BjxbZuO3KS8VFAuAGMNIswyGjpVIJrg0LEq+SwnJw9veiILiHQRI
         ZhRCbpm9entarmLxFr+WiTRuAEoROda7S29VN8qwQmr2cnxTmZTE9RsYaVCoLRFPbnmO
         3Jug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=fJqUVnMmmEGBR4w+RV9U88Z7XLYYwszXyiTahWLXm6o=;
        b=cxMJBsd3D+3T1Vm0+KEwKV1QhsQF+1a+JFYqF7+ngYHClPLpzBbVa3PhXVmMH3Lisn
         0yqzBx4uNt58RgFzaUSakqjPPbRoUXfZ8r803qmSeorBZNMdB48RZItea4zrDa90vrc/
         Ms62oDSJi/RWGoWOLbRYB/2NOkcclx1z8WtAIBynLJnwJSBvETrptPIJ4hvro0kjOwbd
         k4+QAHBoccIEYeUEA+Jl9iXOgpqE21jdot2T2g+ZWOcKDH8NoV7+vzcW2mY52sr7pUh2
         kDLJPLEGTtgPuCQCia04oQDzVKu5iDUOeW/1DU/DbQ0gek4Y3BVu11O9O/UtLBBDKxVp
         I5Mw==
X-Gm-Message-State: APjAAAXJ37wUNdJdEt01cYMCPTX7OgbftOBm7cI3/W5WN98++L8GwA8F
        Up+WPUHUi6bH/PHsSnSpmdxkYg==
X-Google-Smtp-Source: APXvYqx3GEvjDm8lhRXrT5DgTq0D6MP3gcOr7f99w3IE/lAK+ZX8qaklrO3rs0w0JQOjT6VOu7o8Ww==
X-Received: by 2002:aa7:8284:: with SMTP id s4mr19965008pfm.235.1554569406096;
        Sat, 06 Apr 2019 09:50:06 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id p2sm19666998pfb.80.2019.04.06.09.50.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 06 Apr 2019 09:50:05 -0700 (PDT)
Subject: Re: [PATCH] null_blk: prevent crash from bad home_node value
To:     John Pittman <jpittman@redhat.com>
Cc:     linux-block@vger.kernel.org, Ming Lei <minlei@redhat.com>,
        Yi Zhang <yizhan@redhat.com>
References: <20190405214245.19834-1-jpittman@redhat.com>
 <f737dfe8-9e7f-4cb2-1f15-82daa62c479c@kernel.dk>
 <CA+RJvhxyp2n=p2gfbkv1qHstshCBq1rO2i0quxV4HPjNsqCFpg@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <7333e34d-a10d-cbf8-a2d3-e6119abb3724@kernel.dk>
Date:   Sat, 6 Apr 2019 10:50:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CA+RJvhxyp2n=p2gfbkv1qHstshCBq1rO2i0quxV4HPjNsqCFpg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/6/19 8:47 AM, John Pittman wrote:
> Hi Jens, I got some unexpected results with this patch this morning.
> When loading null_blk with no arguments, I got the invalid home_node
> value error message.  I did some debug and found that the values
> seemed fine:
> 
> +       pr_err("g_home_node is %d", g_home_node);
> +       pr_err("nr_online_nodes is %d", nr_online_nodes);
> +       pr_err("NUMA_NO_NODE is %d", NUMA_NO_NODE);
> +
> +       if (g_home_node >= nr_online_nodes) {
> +               pr_err("null_blk: invalid home_node value\n");
> +               g_home_node = NUMA_NO_NODE;
> +       }
> +
>         if (g_queue_mode == NULL_Q_RQ) {
>                 pr_err("null_blk: legacy IO path no longer available\n");
>                 return -EINVAL;
> 
> [root@localhost linux]# modprobe null_blk
> [  296.336473] g_home_node is -1
> [  296.336474] nr_online_nodes is 1
> [  296.336514] NUMA_NO_NODE is -1
> [  296.336558] null_blk: invalid home_node value
> [  296.338825] null: module loaded
> 
> [root@localhost linux]# numactl --hardware
> available: 1 nodes (0)
> node 0 cpus: 0 1 2 3
> node 0 size: 828 MB
> node 0 free: 451 MB
> node distances:
> node   0
>   0:  10
> 
> Fortunately, and also unexpectedly to me, I was able to fix the issue
> just by casting nr_online_nodes as an int.
> 
> +       if (g_home_node >= (int)nr_online_nodes) {
> +               pr_err("null_blk: invalid home_node value\n");
> +               g_home_node = NUMA_NO_NODE;
> +       }
> +
> 
> Would you like me to send in a v2 for this?

Well, I already added it... I'll just edit it. But I think we should
make it:

if (g_home_node != NUMA_NO_NODE && g_home_node >= nr_online_nodes)

instead.

-- 
Jens Axboe

